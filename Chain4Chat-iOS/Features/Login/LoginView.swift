//
//  LoginView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 07/11/23.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    
    @State private var path = NavigationPath()
    
    var body: some View {
        WithViewStore(store, observe: { $0 }, content: { viewStore in
            NavigationStack(path: $path) {
                ZStack {
                    loading(viewStore: viewStore)
                        .zIndex(1)
                    
                    loaded(viewStore: viewStore)
                        .animation(.smooth, value: viewStore.viewState)
                        .blur(radius: viewStore.viewState == .loaded ? 0 : 5)
                    
                    error(viewStore: viewStore)
                }
                
                .navigationTitle("Login")
            }
        })
    }
    
    private func loading(viewStore: ViewStore<LoginFeature.State, LoginFeature.Action>) -> some View {
        ZStack {
            
            Color.clear
            
            LoadingView()
        }
        .animation(.smooth, value: viewStore.viewState)
        .opacity(viewStore.viewState == .loading ? 1.0 : 0.0)
    }
    
    private func error(viewStore: ViewStore<LoginFeature.State, LoginFeature.Action>) -> some View {
        ZStack {
            
            Color.clear
            
            ErrorView(onTryAgainButtonTapped: {
                viewStore.send(.performLogin(viewStore.userHash))
            })
        }
        .background(Color.gray.opacity(0.4))
        .cornerRadius(25)
        .animation(.smooth, value: viewStore.viewState)
        .opacity(viewStore.viewState == .error ? 1.0 : 0.0)
    }
    
    private func loaded(viewStore: ViewStore<LoginFeature.State, LoginFeature.Action>) -> some View {
        VStack {
            
            Spacer()
            
            Text("By putting your user hash here we can retreive your account, don't share your hash with any one")
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            TextField(
                "Insert your hash here...",
                text: viewStore.binding(get: (\.userHash), send: { .updateUserHash($0) }
                                       ))
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(25)
            
            CustomButtonView(
                title: "Login",
                buttonTapped: {
                    viewStore.send(.performLogin(viewStore.userHash))
                })
            
            Spacer()
            
            HStack {
                Text("You don't have a user?")
                
                NavigationLink("Click here", destination: {
                    UserRegistrationView(
                        store: .init(
                            initialState: UserRegistrationFeature.State(name: "", bio: ""),
                            reducer: {
                                UserRegistrationFeature(registrationCID: { cid in
                                    print("SONG save this user cid \(cid)")
                                    viewStore.send(.performLogin(cid))
                                })
                            }
                        )
                    )
                })
            }
            
        }
        .padding()
    }
}

#Preview {
    LoginView(store: .init(initialState: LoginFeature.State(userHash: ""), reducer: {
        LoginFeature(onLoginFinished: { _ in })
    }))
}
