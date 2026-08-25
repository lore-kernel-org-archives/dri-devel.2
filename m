Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE05C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CB610EA0A;
	Tue, 25 Aug 2026 12:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SpO814xc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CC710EA0D;
 Tue, 25 Aug 2026 12:17:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D30876011F;
 Tue, 25 Aug 2026 12:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFCB1F00A3A;
 Tue, 25 Aug 2026 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660248;
 bh=jxGZ/7Bag3BNzsAQAbcWVG4Ku2W1VHYdpC0vYdF4Bus=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SpO814xc77Xz724ILlImObbsu0LgX+4QE3+LZ5/C5j3A59oPmey2BIQiOzoM1lq2b
 eWyFx0gO0kVihilfslAcCbAZB2yFU0qsP4aAQvJvS3MevCWZzygm9XqCc7a4EpQ2ax
 77wEM1zIKDeUlpqYhw1sAISwsRUgrAlEBPYOFUVD9W1HsRLBNeMViKgmdgNjY7zm3p
 F+Y5mcblObMc1nysCQ92L4QctiOSFb9mYDUlglLAGGlOF+hDn/tqel+wEXkf0kIIEo
 3Wk4RVJdpDchYdP/gwPyySGiC0wtQoKt+7pfhnnYgXnCSFy/+OxCk2z7CJlhYCUocI
 mVPwf4f8l4DEw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 25 Aug 2026 14:16:34 +0200
Subject: [PATCH 3/6] rust: hrtimer: use the expiry injecting callback variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-expires-v2-v1-3-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
In-Reply-To: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=27378;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=UFqkRvv2iETXszvsITqqCGKP4sK+8kra0jg8CbP3mLc=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjYe7d+X4eM0gRm3jiWFmCIWSrmHpeCMY4y6V0
 XbD9yPS4SmJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCao2HuwAKCRD6UCkIqsW9
 0IAREACpajM0cyKVARyX+BrGpLwXtGjjfyIVCMx/nkS9CJpUq8EBakjcHo76o26QePXZVQk/wbe
 IZ+Gqhauqp5FbNNJ4O2ZwcQUlzNOZZYQ92O7wMWJeouNtGk6DVhR+/u2WT5kpaoXx9ZMqRfREgz
 b7zNOcjrAoXGMqkL4iH1D1WIG1iQvzBUkQs0NmxnYMAYcJ0MNnN4zJ/SOCwl2OMJW9iToEflSHr
 Nwj7GJx91I4Yipov66wFGQjBZVopC/ATyNv/ONxnFByCIy+0Ag7L3lHgLPWyTHPSgdQmk+85b9+
 6oIWM1WlgdBojlrF2QQQo6oxPNnWTUBYdH3uzYhBMfYTq6L03V1h+T9vveh+1hbbKt92pXH0wSH
 KF71br+8/kt2h+ZCgs7ENHEfRjjQElOSf4LAjADIWgy4ZSfIndMzonIdPU472euEYgtm2ynNpwb
 UHJePK4lQUKbQPYSeCOhdNpjLAXSjhuf5nprB04nb36uwAePnjMNCwmXJFRFlU0p3t5fmIqmB0r
 js6QjKG5pWw2NQJkjvjpY6lGg2HmO73ZLnHXc1T2QOzX19G3SoR/qzwHl/GRe1iDd18CTnnFcDj
 iU50Ytz1wcbq4S0VfCCjmG7POxCxWIJ8tFxBSnL01Hzq0yAiGW1ZbxUqNEGgzQvbOO0UG/lpDz7
 AqUsicVKGrjKvfg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

A timer callback could modify the expiry of its timer with
HrTimerCallbackContext::forward(). The C side runs callbacks with the
timer base lock dropped, and a concurrent start operation - reachable
from safe code, since Arc<T> is Clone and Pin<&T> is Copy - rewrites
the expiry under the base lock and requeues the timer. The unlocked
read-modify-write of the expiry in hrtimer_forward() is a data race
with such a concurrent start, and forwarding a requeued timer changes
the expiry of a node inside the timerqueue without re-sorting it,
leaving the tree unordered.

Switch the abstraction to the expiry injecting callback variant
provided by hrtimer_setup_ext(). The callback receives the expiry by
value, snapshotted under the timer base lock, and requests a restart
by returning HrTimerRestart::Forward { now, interval }. The timer
core applies the forward and requeues the timer under the timer base
lock after the callback has returned. If a concurrent start operation
requeued the timer while the callback ran, the request is discarded
and the concurrent start operation wins.

The callback never accesses live timer state, so the race is removed
structurally while concurrent start operations remain allowed:

- HrTimerCallback::run() receives the expiry snapshot instead of a
  HrTimerCallbackContext and returns HrTimerRestart<T>, which now
  carries the forward request.

- HrTimerCallbackContext is removed together with its forward() and
  forward_now() methods. HrTimer::forward() on an exclusive reference
  remains available.

- The callback trampolines of the four pointer types translate the
  expiry snapshot and the forward request across the FFI boundary.

Link: https://lore.kernel.org/r/87h5kp88uy.fsf@kernel.org
Suggested-by: Gary Guo <gary@garyguo.net>
Assisted-by: claude-code:claude-fable-5
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         | 212 ++++++++++++++++++------------------
 rust/kernel/time/hrtimer/arc.rs     |  21 ++--
 rust/kernel/time/hrtimer/pin.rs     |  21 ++--
 rust/kernel/time/hrtimer/pin_mut.rs |  24 ++--
 rust/kernel/time/hrtimer/tbox.rs    |  21 ++--
 5 files changed, 162 insertions(+), 137 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 2d7f1131a8131..e6570a6162035 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -60,16 +60,23 @@
 //! by the `cancel` operation. A timer that is cancelled enters the **stopped**
 //! state.
 //!
-//! A `cancel` or `restart` operation on a timer in the **running** state takes
-//! effect after the handler has returned and the timer has transitioned
-//! out of the **running** state.
+//! The handler receives the expiry time that was in effect when the timer fired. To restart the
+//! timer, the handler returns a forward request; the timer core applies the request and requeues
+//! the timer. A concurrent `start` operation overrides the restart request of the timer handler.
+//!
+//! A `cancel` operation on a timer in the **running** state takes effect after
+//! the handler has returned and the timer has transitioned out of the
+//! **running** state.
 //!
 //! A `restart` operation on a timer in the **stopped** state is equivalent to a
 //! `start` operation.
 //!
-//! When a type implements both `HrTimerPointer` and `Clone`, it is possible to
-//! issue the `start` operation while the timer is in the **started** state. In
-//! this case the `start` operation is equivalent to the `restart` operation.
+//! When a type implements both `HrTimerPointer` and `Clone`, it is possible to issue the `start`
+//! operation while the timer is in the **started** or **running** state. In this case the `start`
+//! operation is equivalent to the `restart` operation. A `restart` operation on a timer in the
+//! **running** state takes effect immediately: the timer re-enters the **started** state before the
+//! handler returns, and a restart requested by the return value of the handler is discarded in
+//! favor of the `restart` operation.
 //!
 //! # Examples
 //!
@@ -87,8 +94,8 @@
 //! #     },
 //! #     time::{
 //! #         hrtimer::{
-//! #             RelativeMode, HrTimer, HrTimerCallback, HrTimerPointer,
-//! #             HrTimerRestart, HrTimerCallbackContext
+//! #             RelativeMode, HrTimer, HrTimerCallback, HrTimerInstant,
+//! #             HrTimerPointer, HrTimerRestart
 //! #         },
 //! #         Delta, Monotonic,
 //! #     },
@@ -130,7 +137,7 @@
 //! impl HrTimerCallback for BoxIntrusiveHrTimer {
 //!     type Pointer<'a> = Pin<KBox<Self>>;
 //!
-//!     fn run(this: Pin<&mut Self>, _ctx: HrTimerCallbackContext<'_, Self>) -> HrTimerRestart {
+//!     fn run(this: Pin<&mut Self>, _expires: HrTimerInstant<Self>) -> HrTimerRestart<Self> {
 //!         pr_info!("Timer called\n");
 //!
 //!         let flag = this.shared.flag.fetch_add(1, ordering::Full);
@@ -139,7 +146,7 @@
 //!         if flag == 4 {
 //!             HrTimerRestart::NoRestart
 //!         } else {
-//!             HrTimerRestart::Restart
+//!             HrTimerRestart::forward_now(Delta::from_micros(200))
 //!         }
 //!     }
 //! }
@@ -176,8 +183,8 @@
 //! #     },
 //! #     time::{
 //! #         hrtimer::{
-//! #             RelativeMode, HrTimer, HrTimerCallback, HrTimerPointer, HrTimerRestart,
-//! #             HasHrTimer, HrTimerCallbackContext
+//! #             RelativeMode, HrTimer, HrTimerCallback, HrTimerInstant, HrTimerPointer,
+//! #             HrTimerRestart, HasHrTimer
 //! #         },
 //! #         Delta, Monotonic,
 //! #     },
@@ -208,8 +215,8 @@
 //!
 //!     fn run(
 //!         this: ArcBorrow<'_, Self>,
-//!         _ctx: HrTimerCallbackContext<'_, Self>,
-//!     ) -> HrTimerRestart {
+//!         _expires: HrTimerInstant<Self>,
+//!     ) -> HrTimerRestart<Self> {
 //!         pr_info!("Timer called\n");
 //!
 //!         let flag = this.flag.fetch_add(1, ordering::Full);
@@ -218,7 +225,7 @@
 //!         if flag == 4 {
 //!             HrTimerRestart::NoRestart
 //!         } else {
-//!             HrTimerRestart::Restart
+//!             HrTimerRestart::forward_now(Delta::from_micros(200))
 //!         }
 //!     }
 //! }
@@ -252,8 +259,8 @@
 //! #     },
 //! #     time::{
 //! #         hrtimer::{
-//! #             ScopedHrTimerPointer, HrTimer, HrTimerCallback, HrTimerPointer, HrTimerRestart,
-//! #             HasHrTimer, RelativeMode, HrTimerCallbackContext
+//! #             ScopedHrTimerPointer, HrTimer, HrTimerCallback, HrTimerInstant,
+//! #             HrTimerPointer, HrTimerRestart, HasHrTimer, RelativeMode
 //! #         },
 //! #         Delta, Monotonic,
 //! #     },
@@ -283,7 +290,7 @@
 //! impl HrTimerCallback for IntrusiveHrTimer {
 //!     type Pointer<'a> = Pin<&'a Self>;
 //!
-//!     fn run(this: Pin<&Self>, _ctx: HrTimerCallbackContext<'_, Self>) -> HrTimerRestart {
+//!     fn run(this: Pin<&Self>, _expires: HrTimerInstant<Self>) -> HrTimerRestart<Self> {
 //!         pr_info!("Timer called\n");
 //!
 //!         this.flag.store(1, ordering::Release);
@@ -324,8 +331,8 @@
 //! #     },
 //! #     time::{
 //! #         hrtimer::{
-//! #             ScopedHrTimerPointer, HrTimer, HrTimerCallback, HrTimerPointer, HrTimerRestart,
-//! #             HasHrTimer, RelativeMode, HrTimerCallbackContext
+//! #             ScopedHrTimerPointer, HrTimer, HrTimerCallback, HrTimerInstant,
+//! #             HrTimerPointer, HrTimerRestart, HasHrTimer, RelativeMode
 //! #         },
 //! #         Delta, Monotonic,
 //! #     },
@@ -368,7 +375,7 @@
 //! impl HrTimerCallback for IntrusiveHrTimer {
 //!     type Pointer<'a> = Pin<&'a mut Self>;
 //!
-//!     fn run(this: Pin<&mut Self>, _ctx: HrTimerCallbackContext<'_, Self>) -> HrTimerRestart {
+//!     fn run(this: Pin<&mut Self>, _expires: HrTimerInstant<Self>) -> HrTimerRestart<Self> {
 //!         pr_info!("Timer called\n");
 //!
 //!         let flag = this.shared.flag.fetch_add(1, ordering::Full);
@@ -377,7 +384,7 @@
 //!         if flag == 4 {
 //!             HrTimerRestart::NoRestart
 //!         } else {
-//!             HrTimerRestart::Restart
+//!             HrTimerRestart::forward_now(Delta::from_micros(200))
 //!         }
 //!     }
 //! }
@@ -405,7 +412,7 @@
 
 use super::{ClockSource, Delta, Instant};
 use crate::{prelude::*, types::Opaque};
-use core::{marker::PhantomData, ptr::NonNull};
+use core::marker::PhantomData;
 use pin_init::PinInit;
 
 /// A type-alias to refer to the [`Instant<C>`] for a given `T` from [`HrTimer<T>`].
@@ -417,7 +424,7 @@
 ///
 /// # Invariants
 ///
-/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
+/// * `self.timer` is initialized by `bindings::hrtimer_setup_ext`.
 #[pin_data]
 #[repr(C)]
 pub struct HrTimer<T> {
@@ -442,13 +449,14 @@ pub fn new() -> impl PinInit<Self>
         T: HasHrTimer<T>,
     {
         pin_init!(Self {
-            // INVARIANT: We initialize `timer` with `hrtimer_setup` below.
+            // INVARIANT: We initialize `timer` with `hrtimer_setup_ext` below.
             timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
                 // SAFETY: By design of `pin_init!`, `place` is a pointer to a
-                // live allocation. hrtimer_setup will initialize `place` and
-                // does not require `place` to be initialized prior to the call.
+                // live allocation. hrtimer_setup_ext will initialize `place`
+                // and does not require `place` to be initialized prior to the
+                // call.
                 unsafe {
-                    bindings::hrtimer_setup(
+                    bindings::hrtimer_setup_ext(
                         place,
                         Some(T::Pointer::run),
                         <<T as HasHrTimer<T>>::TimerMode as HrTimerMode>::Clock::ID,
@@ -510,8 +518,7 @@ pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
     /// # Safety
     ///
     /// - `self_ptr` must point to a valid `Self`.
-    /// - The caller must either have exclusive access to the data pointed at by `self_ptr`, or be
-    ///   within the context of the timer callback.
+    /// - The caller must have exclusive access to the data pointed at by `self_ptr`.
     #[inline]
     unsafe fn raw_forward(self_ptr: *mut Self, now: HrTimerInstant<T>, interval: Delta) -> u64
     where
@@ -533,8 +540,8 @@ unsafe fn raw_forward(self_ptr: *mut Self, now: HrTimerInstant<T>, interval: Del
     /// `interval`.
     ///
     /// This function is mainly useful for timer types which can provide exclusive access to the
-    /// timer when the timer is not running. For forwarding the timer from within the timer callback
-    /// context, see [`HrTimerCallbackContext::forward()`].
+    /// timer when the timer is not running. To forward the timer from within the timer callback,
+    /// return [`HrTimerRestart::Forward`] from the callback instead.
     ///
     /// Returns the number of overruns that occurred as a result of the timer expiry change.
     pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interval: Delta) -> u64
@@ -707,9 +714,16 @@ pub trait RawHrTimerCallback {
     ///
     /// # Safety
     ///
-    /// Only to be called by C code in the `hrtimer` subsystem. `this` must point
-    /// to the `bindings::hrtimer` structure that was used to start the timer.
-    unsafe extern "C" fn run(this: *mut bindings::hrtimer) -> bindings::hrtimer_restart;
+    /// Only to be called by C code in the `hrtimer` subsystem. `this` must
+    /// point to the `bindings::hrtimer` structure that was used to start the
+    /// timer, `expires` must be the expiry of the timer snapshotted under the
+    /// timer base lock, and `fwd` must be valid for writing a
+    /// `bindings::hrtimer_forward_args`.
+    unsafe extern "C" fn run(
+        this: *mut bindings::hrtimer,
+        expires: bindings::ktime_t,
+        fwd: *mut bindings::hrtimer_forward_args,
+    ) -> bindings::hrtimer_restart;
 }
 
 /// Implemented by structs that can be the target of a timer callback.
@@ -719,10 +733,14 @@ pub trait HrTimerCallback {
     type Pointer<'a>: RawHrTimerCallback;
 
     /// Called by the timer logic when the timer fires.
+    ///
+    /// `expires` is the expiry time of the timer, read under the timer base
+    /// lock when the timer fired. A concurrent restart of the timer is not
+    /// reflected in `expires`.
     fn run(
         this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>,
-        ctx: HrTimerCallbackContext<'_, Self>,
-    ) -> HrTimerRestart
+        expires: HrTimerInstant<Self>,
+    ) -> HrTimerRestart<Self>
     where
         Self: Sized,
         Self: HasHrTimer<Self>;
@@ -829,19 +847,62 @@ unsafe fn start(this: *const Self, expires: <Self::TimerMode as HrTimerMode>::Ex
     }
 }
 
-/// Restart policy for timers.
-#[derive(Copy, Clone, PartialEq, Eq, Debug)]
-#[repr(u32)]
-pub enum HrTimerRestart {
+/// Restart policy for timers, as returned by [`HrTimerCallback::run`].
+///
+/// A timer callback requests a restart of its timer by returning
+/// [`HrTimerRestart::Forward`]. The forward is not applied by the callback
+/// itself: the timer core applies it and requeues the timer under the timer
+/// base lock after the callback has returned. If the timer was restarted by a
+/// concurrent start operation while the callback was running, the request is
+/// discarded and the concurrent start operation wins.
+pub enum HrTimerRestart<T: HasHrTimer<T>> {
     /// Timer should not be restarted.
-    NoRestart = bindings::hrtimer_restart_HRTIMER_NORESTART,
-    /// Timer should be restarted.
-    Restart = bindings::hrtimer_restart_HRTIMER_RESTART,
+    NoRestart,
+    /// Forward the timer expiry to lie past `now` in increments of `interval`
+    /// and restart the timer.
+    ///
+    /// `interval` must be a positive time delta.
+    Forward {
+        /// The point in time to forward the expiry past.
+        now: HrTimerInstant<T>,
+        /// The time interval to forward the expiry by.
+        interval: Delta,
+    },
 }
 
-impl HrTimerRestart {
-    fn into_c(self) -> bindings::hrtimer_restart {
-        self as bindings::hrtimer_restart
+impl<T: HasHrTimer<T>> HrTimerRestart<T> {
+    /// Request that the timer be forwarded past the current time by `interval`
+    /// and restarted.
+    pub fn forward_now(interval: Delta) -> Self {
+        Self::Forward {
+            now: HrTimerInstant::<T>::now(),
+            interval,
+        }
+    }
+
+    /// Convert to the C representation, filling `fwd` with the forward
+    /// request.
+    ///
+    /// # Safety
+    ///
+    /// `fwd` must be valid for writing a `bindings::hrtimer_forward_args`.
+    pub(crate) unsafe fn into_c(
+        self,
+        fwd: *mut bindings::hrtimer_forward_args,
+    ) -> bindings::hrtimer_restart {
+        match self {
+            Self::NoRestart => bindings::hrtimer_restart_HRTIMER_NORESTART,
+            Self::Forward { now, interval } => {
+                // SAFETY: By our safety contract, `fwd` is valid for writing.
+                unsafe {
+                    *fwd = bindings::hrtimer_forward_args {
+                        now: now.as_nanos(),
+                        interval: interval.as_nanos(),
+                    }
+                };
+                bindings::hrtimer_restart_HRTIMER_RESTART
+            }
+        }
     }
 }
 
@@ -1010,63 +1071,6 @@ impl<C: ClockSource> HrTimerMode for RelativePinnedHardMode<C> {
     type Expires = Delta;
 }
 
-/// Privileged smart-pointer for a [`HrTimer`] callback context.
-///
-/// Many [`HrTimer`] methods can only be called in two situations:
-///
-/// * When the caller has exclusive access to the `HrTimer` and the `HrTimer` is guaranteed not to
-///   be running.
-/// * From within the context of an `HrTimer`'s callback method.
-///
-/// This type provides access to said methods from within a timer callback context.
-///
-/// # Invariants
-///
-/// * The existence of this type means the caller is currently within the callback for an
-///   [`HrTimer`].
-/// * `self.0` always points to a live instance of [`HrTimer<T>`].
-pub struct HrTimerCallbackContext<'a, T: HasHrTimer<T>>(NonNull<HrTimer<T>>, PhantomData<&'a ()>);
-
-impl<'a, T: HasHrTimer<T>> HrTimerCallbackContext<'a, T> {
-    /// Create a new [`HrTimerCallbackContext`].
-    ///
-    /// # Safety
-    ///
-    /// This function relies on the caller being within the context of a timer callback, so it must
-    /// not be used anywhere except for within implementations of [`RawHrTimerCallback::run`]. The
-    /// caller promises that `timer` points to a valid initialized instance of
-    /// [`bindings::hrtimer`].
-    ///
-    /// The returned `Self` must not outlive the function context of [`RawHrTimerCallback::run`]
-    /// where this function is called.
-    pub(crate) unsafe fn from_raw(timer: *mut HrTimer<T>) -> Self {
-        // SAFETY: The caller guarantees `timer` is a valid pointer to an initialized
-        // `bindings::hrtimer`
-        // INVARIANT: Our safety contract ensures that we're within the context of a timer callback
-        // and that `timer` points to a live instance of `HrTimer<T>`.
-        Self(unsafe { NonNull::new_unchecked(timer) }, PhantomData)
-    }
-
-    /// Conditionally forward the timer.
-    ///
-    /// This function is identical to [`HrTimer::forward()`] except that it may only be used from
-    /// within the context of a [`HrTimer`] callback.
-    pub fn forward(&mut self, now: HrTimerInstant<T>, interval: Delta) -> u64 {
-        // SAFETY:
-        // - We are guaranteed to be within the context of a timer callback by our type invariants
-        // - By our type invariants, `self.0` always points to a valid `HrTimer<T>`
-        unsafe { HrTimer::<T>::raw_forward(self.0.as_ptr(), now, interval) }
-    }
-
-    /// Conditionally forward the timer.
-    ///
-    /// This is a variant of [`HrTimerCallbackContext::forward()`] that uses an interval after the
-    /// current time of the base clock for the [`HrTimer`].
-    pub fn forward_now(&mut self, duration: Delta) -> u64 {
-        self.forward(HrTimerInstant::<T>::now(), duration)
-    }
-}
-
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index 7be82bcb352ac..8a9fcb5c69e64 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -3,13 +3,13 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
-use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerMode;
 use super::HrTimerPointer;
 use super::RawHrTimerCallback;
 use crate::sync::Arc;
 use crate::sync::ArcBorrow;
+use crate::time::Instant;
 
 /// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
 /// [`HrTimerPointer::start`].
@@ -79,7 +79,11 @@ impl<T> RawHrTimerCallback for Arc<T>
 {
     type CallbackTarget<'a> = ArcBorrow<'a, T>;
 
-    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+    unsafe extern "C" fn run(
+        ptr: *mut bindings::hrtimer,
+        expires: bindings::ktime_t,
+        fwd: *mut bindings::hrtimer_forward_args,
+    ) -> bindings::hrtimer_restart {
         // `HrTimer` is `repr(C)`
         let timer_ptr = ptr.cast::<super::HrTimer<T>>();
 
@@ -100,12 +104,13 @@ impl<T> RawHrTimerCallback for Arc<T>
         //    allocation from other `Arc` clones.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        // SAFETY:
-        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
-        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
-        // - We are within `RawHrTimerCallback::run`
-        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+        // SAFETY: By C API contract, `expires` is the expiry of the timer
+        // snapshotted under the timer base lock, and timers cannot have
+        // negative expiry times.
+        let expires = unsafe { Instant::from_ktime(expires) };
 
-        T::run(receiver, context).into_c()
+        // SAFETY: By C API contract, `fwd` is valid for writing a
+        // `bindings::hrtimer_forward_args`.
+        unsafe { T::run(receiver, expires).into_c(fwd) }
     }
 }
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index 4d39ef7816971..d1143f278f312 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -3,11 +3,11 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
-use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerMode;
 use super::RawHrTimerCallback;
 use super::UnsafeHrTimerPointer;
+use crate::time::Instant;
 use core::pin::Pin;
 
 /// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
@@ -82,7 +82,11 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a T>
 {
     type CallbackTarget<'b> = Self;
 
-    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+    unsafe extern "C" fn run(
+        ptr: *mut bindings::hrtimer,
+        expires: bindings::ktime_t,
+        fwd: *mut bindings::hrtimer_forward_args,
+    ) -> bindings::hrtimer_restart {
         // `HrTimer` is `repr(C)`
         let timer_ptr = ptr.cast::<HrTimer<T>>();
 
@@ -104,12 +108,13 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a T>
         // here.
         let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
 
-        // SAFETY:
-        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
-        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
-        // - We are within `RawHrTimerCallback::run`
-        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+        // SAFETY: By C API contract, `expires` is the expiry of the timer
+        // snapshotted under the timer base lock, and timers cannot have
+        // negative expiry times.
+        let expires = unsafe { Instant::from_ktime(expires) };
 
-        T::run(receiver_pin, context).into_c()
+        // SAFETY: By C API contract, `fwd` is valid for writing a
+        // `bindings::hrtimer_forward_args`.
+        unsafe { T::run(receiver_pin, expires).into_c(fwd) }
     }
 }
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 9d9447d4d57e8..04f9d8cbddcd2 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{
-    HasHrTimer, HrTimer, HrTimerCallback, HrTimerCallbackContext, HrTimerHandle, HrTimerMode,
-    RawHrTimerCallback, UnsafeHrTimerPointer,
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, HrTimerMode, RawHrTimerCallback,
+    UnsafeHrTimerPointer,
 };
+use crate::time::Instant;
 use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
 
 /// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
@@ -85,7 +86,11 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
 {
     type CallbackTarget<'b> = Self;
 
-    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+    unsafe extern "C" fn run(
+        ptr: *mut bindings::hrtimer,
+        expires: bindings::ktime_t,
+        fwd: *mut bindings::hrtimer_forward_args,
+    ) -> bindings::hrtimer_restart {
         // `HrTimer` is `repr(C)`
         let timer_ptr = ptr.cast::<HrTimer<T>>();
 
@@ -107,12 +112,13 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
         // here.
         let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
 
-        // SAFETY:
-        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
-        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
-        // - We are within `RawHrTimerCallback::run`
-        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+        // SAFETY: By C API contract, `expires` is the expiry of the timer
+        // snapshotted under the timer base lock, and timers cannot have
+        // negative expiry times.
+        let expires = unsafe { Instant::from_ktime(expires) };
 
-        T::run(receiver_pin, context).into_c()
+        // SAFETY: By C API contract, `fwd` is valid for writing a
+        // `bindings::hrtimer_forward_args`.
+        unsafe { T::run(receiver_pin, expires).into_c(fwd) }
     }
 }
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index aa1ee31a71953..c7f86909e21b5 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -3,12 +3,12 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
-use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerMode;
 use super::HrTimerPointer;
 use super::RawHrTimerCallback;
 use crate::prelude::*;
+use crate::time::Instant;
 use core::ptr::NonNull;
 
 /// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
@@ -102,7 +102,11 @@ impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
 {
     type CallbackTarget<'a> = Pin<&'a mut T>;
 
-    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+    unsafe extern "C" fn run(
+        ptr: *mut bindings::hrtimer,
+        expires: bindings::ktime_t,
+        fwd: *mut bindings::hrtimer_forward_args,
+    ) -> bindings::hrtimer_restart {
         // `HrTimer` is `repr(C)`
         let timer_ptr = ptr.cast::<super::HrTimer<T>>();
 
@@ -120,12 +124,13 @@ impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
         //   `data_ptr` exist.
         let data_mut_ref = unsafe { Pin::new_unchecked(&mut *data_ptr) };
 
-        // SAFETY:
-        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
-        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
-        // - We are within `RawHrTimerCallback::run`
-        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+        // SAFETY: By C API contract, `expires` is the expiry of the timer
+        // snapshotted under the timer base lock, and timers cannot have
+        // negative expiry times.
+        let expires = unsafe { Instant::from_ktime(expires) };
 
-        T::run(data_mut_ref, context).into_c()
+        // SAFETY: By C API contract, `fwd` is valid for writing a
+        // `bindings::hrtimer_forward_args`.
+        unsafe { T::run(data_mut_ref, expires).into_c(fwd) }
     }
 }

-- 
2.51.2


