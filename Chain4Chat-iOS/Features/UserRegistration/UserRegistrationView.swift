//
//  UserRegistrationView.swift
//  Chain4Chat-iOS
//
//  Created by Adriano Song on 06/11/23.
//

import SwiftUI
import ComposableArchitecture

struct UserRegistrationView: View {
    
    let store: StoreOf<UserRegistrationFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }, content: { viewStore in
            ZStack {
                loading(viewStore: viewStore)
                    .zIndex(1)
                
                loaded(viewStore: viewStore)
                    .animation(.smooth, value: viewStore.viewState)
                    .blur(radius: viewStore.viewState == .loaded ? 0 : 5)
                
                error(viewStore: viewStore)
            }
            
            
        })
    }
    
    private func loading(
        viewStore: ViewStore<UserRegistrationFeature.State, UserRegistrationFeature.Action>) -> some View {
            ZStack {
                
                Color.clear
                
                LoadingView()
            }
            .animation(.smooth, value: viewStore.viewState)
            .opacity(viewStore.viewState == .loading ? 1.0 : 0.0)
        }
    
    private func loaded(
        viewStore: ViewStore<UserRegistrationFeature.State, UserRegistrationFeature.Action>) -> some View {
        VStack {
            Spacer()
            
            Text("New User")
                .font(.title)
            
            Form {
                Section {
                    TextField("Nickname", text: viewStore.binding(get: (\.name), send: { .updateName($0) }))
                    
                    TextField("Your bio here...", text: viewStore.binding(get: (\.bio), send: { .updateBio($0) }))
                        .multilineTextAlignment(.leading)
                }
            }
            
            Spacer()
            
            CustomButtonView(title: "Register", buttonTapped: {
                viewStore.send(.performRegistration)
            })
            
            Spacer()
        }
        .padding()
    }
    
    private func error(
        viewStore: ViewStore<UserRegistrationFeature.State, UserRegistrationFeature.Action>) -> some View {
        ZStack {
            
            Color.clear
            
            ErrorView(onTryAgainButtonTapped: {
                
            })
        }
        .background(Color.gray.opacity(0.4))
        .cornerRadius(25)
        .animation(.smooth, value: viewStore.viewState)
        .opacity(viewStore.viewState == .error ? 1.0 : 0.0)
    }
}

#Preview {
    UserRegistrationView(
        store: .init(
            initialState: UserRegistrationFeature.State(name: "Test User", bio: "Test user bio"),
            reducer: {
                UserRegistrationFeature(registrationCID: { _ in })
            }
        )
    )
}
