//
//  CheckoutView.swift
//  CapCakeCorner
//
//  Created by Андрей Коноплев on 02.01.2023.
//

import SwiftUI

struct CheckoutView: View {

    @ObservedObject var order: Order

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                    .padding()
            }
            .alert("Заказ", isPresented: $showingConfirmation) {
                Button("Ok") {}
            } message: {
                Text(confirmationMessage)
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"

        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                showError(message: "Ошибка запроса")
                return
            }

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            showError(message: "Ошибка создания заказа")
        }
    }

    func showError(message: String) {
        confirmationMessage = "error is \(message)"
        showingConfirmation = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
