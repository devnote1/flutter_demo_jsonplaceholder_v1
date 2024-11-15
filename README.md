# flutter_demo_jsonplaceholder_v1

### Provider와 ProviderContainer 간의 관계 도식화 (PostViewModel 포함, StateNotifier 명시)

```
[ProviderContainer]
      └───────────▶ [DioProvider]
                           │
                           ▼
                   ┌────────────────┐
                   │ Dio Instance │
                   └────────────────┘
                           │
                           ▼
           [PostRepositoryImpl Provider]
                           │
                           │
                           ▼
           [PostViewModel (StateNotifier)]
                           │
                           ▼
           [PostListViewModelProvider (StateNotifierProvider)]
                           │
                           ▼
[PostListPage (ConsumerWidget)]
```

### 설명
1. **`[ProviderContainer]`**:
   - 모든 **Provider를 중앙에서 관리**하는 역할을 합니다. 모든 Provider와 관련된 객체들의 상태를 저장하고 관리합니다.

2. **`[DioProvider]`**:
   - **`DioProvider`**는 **HTTP 클라이언트(Dio)**를 전역적으로 제공하는 역할을 합니다.
   - 이 `Dio` 객체는 **`PostRepositoryImpl`**의 **의존성**으로 사용됩니다.

3. **`[PostRepositoryImpl Provider]`**:
   - **`DioProvider`**로부터 **`Dio` 인스턴스**를 주입받아 **데이터 통신**을 처리합니다.
   - 이 Repository는 **데이터의 CRUD 작업**을 수행하는 역할을 합니다.

4. **`[PostViewModel (StateNotifier)]`**:
   - **`PostViewModel`**은 **`StateNotifier`**를 상속받아, **상태 관리**와 **비즈니스 로직**을 함께 처리합니다.
   - **`StateNotifier`**는 상태의 변경을 관리하며, 상태가 변경되면 자동으로 **상태 구독 중인 Consumer 위젯**에 변경을 반영합니다.

5. **`[PostListViewModelProvider]`** (`StateNotifierProvider`):
   - **`PostViewModel`**을 **상태 관리용으로 제공하는 Provider**입니다.
   - `StateNotifierProvider`를 사용해 **상태 변경이 자동으로 UI에 반영**되도록 합니다.

6. **`[PostListPage]` (ConsumerWidget)**:
   - **`PostListPage`**는 **ConsumerWidget**으로, `ref.watch(postListViewModelProvider)`를 사용해 **상태를 구독**합니다.
   - 상태 변경에 따라 **자동으로 UI를 업데이트**합니다.

