Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EA6C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 05:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3195010E530;
	Sat, 18 Jul 2026 05:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LuAm/eZW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E5710E52C
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 05:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F57645180;
 Sat, 18 Jul 2026 05:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015831F00A3F;
 Sat, 18 Jul 2026 05:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784352779;
 bh=siyOnS6l4OgE+SqBMQ+V/Oxq7Qn3CqbcWz13kbHYzvY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LuAm/eZWD7/asTYwGGHjQla5wF7zdbYTWEDTOJizwNsZJLFi/sxjExNO1OJhUp1/8
 EpTzxCSUXwpmLXkvJlQieQdLJiFgyDBDxZWXumLFrPWbufhiNw+mC4VW9/qFIPiTKw
 K5dhTCG0HyCwbbNr9TIU+oApgo/vUxvXUhoRt2TBZ8Y5OwrUJUo/RifwjOFTzBWkGk
 H9imvG+WKWk25X4xN3hk9v+pCznv7mhMQnbKGyZsn3+BX4BHfI8z+bHYKD2ki6B4LU
 9VgHrpC2mXlmtwC6vEWyi4TNWeAPDxirEJfQGf7jGNpjOpPYgt/s6GE9PypnPvv8FL
 A0a0gIg+9KuXA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 28E26F4006A;
 Sat, 18 Jul 2026 01:32:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sat, 18 Jul 2026 01:32:57 -0400
X-ME-Sender: <xms:CRBbal0f4TF1GOEeTKlAucxG3TgzTOXYfgpLSEPu59HI6Tc8GITuNw>
 <xme:CRBbal7DE12LmkHccLlpQ820yjKfEAARY9Oe80AeG_xkxhn126MxlmkcO0KCFyd4L
 TSmMfk63SWs6t3ipV9tWTp23RzBwRBBwoL_Lor1MqkZIUdoddKwvw>
X-ME-Received: <xmr:CRBbahWgW9Xkr8UqRbTsHe-5_P0teLekAC6T63o_xMq9R0IABzgJUr6C2b6RfOxKNackkdYI_zV7NTTFQnXKZCN1MVtuFZGE>
X-ME-Proxy-Cause: dmFkZTE3j4lQBeju3HcweDJLEhgBazSdYdANC00q2qr0s4koYeBtdPShv70v8pi3tGI1gb
 rI8gxibm6pg/EQlIbC5FCYfXYVoSlDO/lTkmwnSzTVXyDHp0bfUhA0XAFwbqJvrGefhv0r
 XUnOrITJ3N4nqMI0h7+jzGq32g0S5vfV61f6E12mCvHFBAfvexQj6fIzJszAZ9rfBYqYfO
 T6OIfII3tTQkjZZVd1g1QAoU9kPbui+CHn/TMFHwriLkDlU60ZMdQktApUZbVe8QEyUYr3
 jVEpI07EG25Rz4jWtBQdqLQWlPbWtXp4KaGcuyKCPxFukwJtrryv/3hqo9da0SnjgWsXR5
 r634v+PE6k1OOxPqJGPC6mLQ2SHFvEjMbkLTHDB2JAngHD5Xb2TlmvMt5+deZLEFky8MTp
 +pZ6vDgd1ct7pb24/9mOaEE4bzmFLaxvMSjZqNWGE36StaJFzQ7OhQswbLfkdihoypCLJO
 wVah/j4nT8Tv8JoxYMGrX08FYk3Vu3BOCb5PlbFyBTIg+gmWbN7az9X0FdnG6gtttdtOSO
 ZfqnYHBkPgYnV2p1bQV0o85xip/4UU1y5gZplGT/oIUI0zqVr4nfnYtzGq9aRg4Pkk4A+b
 gMq2pVnWbONZT/jamHXyJA/y6YTQ11zB6QsVeP78ZsiyEKnUDmeC7sew4kKg
X-ME-Proxy: <xmx:CRBbavOR5w-PE2hjaET1N4mC_rEQwwAXGpoQV6--Xu6qZru9JXrrVQ>
 <xmx:CRBbai88NHAJBu7GuF625FZR16YZM_J2opngYukSyE86TOhFeHLniQ>
 <xmx:CRBban_tgKioVBwNrKAOkaex0m96IQEwTvjwWys4XCt3zC5MyM3O3Q>
 <xmx:CRBbaqqIpcuB7cwxNDqP7OpfgefvXVsdQy2-PXWB9jtZDaraJXJG5g>
 <xmx:CRBbaqIIw5gxJkKlso4-urSnPIlQAd_vIOUxQ8t-etRXm5ML03IbFEN6>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 01:32:56 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 "Liam R. Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
 Lyude Paul <lyude@redhat.com>,	"Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Matthew Maurer <mmaurer@google.com>,	Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org,	maple-tree@lists.infradead.org,
 linux-mm@kvack.org,	linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org,	dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH v2 1/4] rust: rcu: Add RcuBox type
Date: Fri, 17 Jul 2026 22:32:44 -0700
Message-ID: <20260718053247.25154-2-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260718053247.25154-1-boqun@kernel.org>
References: <20260718053247.25154-1-boqun@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Alice Ryhl <aliceryhl@google.com>

This adds an RcuBox container, which is like Box except that the value
is freed after waiting for one grace period (via {kvfree_,}call_rcu()).

To allow containers to rely on the RCU properties of RcuBox, an
extension of ForeignOwnable is added.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
[boqun: Make RcuBox generic over Allocator and add tests]
[boqun: Add type alias for Rcu*Box]
[boqun: Adjust the ForeignOwnable changes on `T` not being `:'static`]
Co-developed-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync/rcu.rs         |  36 ++++-
 rust/kernel/sync/rcu/rcu_box.rs | 248 ++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/rcu/rcu_box.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b..3e3f1799a49f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -81,6 +81,7 @@
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index 2bae76d229f0..42f6bbc83f71 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -4,7 +4,19 @@
 //!
 //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
 
-use crate::{bindings, types::NotThreadSafe};
+use crate::{
+    bindings,
+    types::{
+        ForeignOwnable,
+        NotThreadSafe, //
+    }, //
+};
+
+mod rcu_box;
+pub use self::rcu_box::RcuBox;
+pub use self::rcu_box::RcuKBox;
+pub use self::rcu_box::RcuKVBox;
+pub use self::rcu_box::RcuVBox;
 
 /// Evidence that the RCU read side lock is held on the current thread/CPU.
 ///
@@ -66,3 +78,25 @@ pub fn synchronize_rcu() {
     // SAFETY: `synchronize_rcu()` is always safe to be called from process context.
     unsafe { bindings::synchronize_rcu() };
 }
+
+/// Declares that a pointer type is rcu safe.
+pub trait ForeignOwnableRcu: ForeignOwnable {
+    /// Type used to immutably borrow an rcu-safe value that is currently foreign-owned.
+    type RcuBorrowed<'a>
+    where
+        Self: 'a;
+
+    /// Borrows a foreign-owned object immutably for an rcu grace period.
+    ///
+    /// This method provides a way to access a foreign-owned rcu-safe value from Rust immutably.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must have been returned by a previous call to [`into_foreign`].
+    /// * If [`from_foreign`] is called, then `'a` must not end after the call to `from_foreign`
+    ///   plus one rcu grace period.
+    ///
+    /// [`into_foreign`]: ForeignOwnable::into_foreign
+    /// [`from_foreign`]: ForeignOwnable::from_foreign
+    unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorrowed<'a>;
+}
diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_box.rs
new file mode 100644
index 000000000000..cb1fd422480a
--- /dev/null
+++ b/rust/kernel/sync/rcu/rcu_box.rs
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Google LLC.
+
+//! Provides the `RcuBox` type for Rust allocations that live for a grace period.
+
+use core::{
+    marker::PhantomData,
+    ops::Deref,
+    ptr::NonNull, //
+};
+
+use crate::{
+    alloc::{
+        self,
+        allocator::{
+            KVmalloc,
+            Kmalloc,
+            Vmalloc, //
+        },
+        AllocError,
+        Allocator, //
+    },
+    bindings,
+    ffi::c_void,
+    prelude::*,
+    types::ForeignOwnable,
+};
+
+use super::{
+    ForeignOwnableRcu,
+    Guard, //
+};
+
+/// A box that is freed with rcu.
+///
+/// The value must be `Send`, as rcu may drop it on another thread.
+///
+/// # Invariants
+///
+/// * The pointer is valid and references a pinned `RcuBoxInner<T>` allocated with `A`.
+/// * This `RcuBox` holds exclusive permissions to rcu free the allocation.
+pub struct RcuBox<T: Send, A: Allocator>(NonNull<RcuBoxInner<T>>, PhantomData<A>);
+
+/// Type alias for [`RcuBox`] with a [`Kmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::sync::rcu::{self, RcuKBox};
+/// let rb = RcuKBox::new(42, GFP_KERNEL)?;
+///
+/// assert_eq!(*rb, 42);
+/// assert_eq!(*rb.with_rcu(&rcu::read_lock()), 42);
+/// # Ok::<(), Error>(())
+/// ```
+pub type RcuKBox<T> = RcuBox<T, Kmalloc>;
+
+/// Type alias for [`RcuBox`] with a [`Vmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::sync::rcu::{self, RcuVBox};
+/// let rb = RcuVBox::new(42, GFP_KERNEL)?;
+///
+/// assert_eq!(*rb, 42);
+/// assert_eq!(*rb.with_rcu(&rcu::read_lock()), 42);
+/// # Ok::<(), Error>(())
+/// ```
+pub type RcuVBox<T> = RcuBox<T, Vmalloc>;
+
+/// Type alias for [`RcuBox`] with a [`KVmalloc`] allocator.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::sync::rcu::{self, RcuKVBox};
+/// let rb = RcuKVBox::new(42, GFP_KERNEL)?;
+///
+/// assert_eq!(*rb, 42);
+/// assert_eq!(*rb.with_rcu(&rcu::read_lock()), 42);
+/// # Ok::<(), Error>(())
+/// ```
+pub type RcuKVBox<T> = RcuBox<T, KVmalloc>;
+
+struct RcuBoxInner<T> {
+    rcu_head: bindings::callback_head,
+    value: T,
+}
+
+// Note that `T: Sync` is required since when moving an `RcuBox<T, A>`, the previous owner may
+// still access `&T` for one grace period.
+//
+// SAFETY: Ownership of the `RcuBox<T, A>` allows for `&T` and dropping the `T`, so `T: Send +
+// Sync` implies `RcuBox<T, A>: Send`.
+unsafe impl<T: Send + Sync, A: Allocator> Send for RcuBox<T, A> {}
+
+// SAFETY: `&RcuBox<T, A>` allows for no operations other than those permitted by `&T`, so `T:
+// Sync` implies `RcuBox<T, A>: Sync`.
+unsafe impl<T: Send + Sync, A: Allocator> Sync for RcuBox<T, A> {}
+
+impl<T: Send, A: Allocator> RcuBox<T, A> {
+    /// Create a new `RcuBox`.
+    pub fn new(x: T, flags: alloc::Flags) -> Result<Self, AllocError> {
+        let b = Box::<_, A>::new(
+            RcuBoxInner {
+                value: x,
+                rcu_head: Default::default(),
+            },
+            flags,
+        )?;
+
+        // INVARIANT:
+        // * The pointer contains a valid `RcuBoxInner` allocated with `A`.
+        // * We just allocated it, so we own free permissions.
+        Ok(RcuBox(NonNull::from(Box::leak(b)), PhantomData))
+    }
+
+    /// Access the value for a grace period.
+    pub fn with_rcu<'rcu>(&self, _read_guard: &'rcu Guard) -> &'rcu T {
+        // SAFETY: The `RcuBox` has not been dropped yet, so the value is valid for at least one
+        // grace period.
+        unsafe { &(*self.0.as_ptr()).value }
+    }
+}
+
+impl<T: Send, A: Allocator> Deref for RcuBox<T, A> {
+    type Target = T;
+    fn deref(&self) -> &T {
+        // SAFETY: While the `RcuBox<T>` exists, the value remains valid.
+        unsafe { &(*self.0.as_ptr()).value }
+    }
+}
+
+// SAFETY:
+// * The `RcuBoxInner<T>` was allocated with `A`.
+// * `NonNull::as_ptr` returns a non-null pointer.
+unsafe impl<T: Send, A: Allocator> ForeignOwnable for RcuBox<T, A> {
+    const FOREIGN_ALIGN: usize = <Box<RcuBoxInner<T>, A> as ForeignOwnable>::FOREIGN_ALIGN;
+
+    type Borrowed<'a>
+        = &'a T
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = &'a T
+    where
+        Self: 'a;
+
+    fn into_foreign(self) -> *mut c_void {
+        core::mem::ManuallyDrop::new(self).0.as_ptr().cast()
+    }
+
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
+        // INVARIANT: Pointer returned by `into_foreign, A` carries same invariants as `RcuBox<T>`.
+        // SAFETY: `into_foreign` never returns a null pointer.
+        Self(unsafe { NonNull::new_unchecked(ptr.cast()) }, PhantomData)
+    }
+
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T
+    where
+        Self: 'a,
+    {
+        // SAFETY: Caller ensures that `'a` is short enough.
+        unsafe { &(*ptr.cast::<RcuBoxInner<T>>()).value }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T
+    where
+        Self: 'a,
+    {
+        // SAFETY: `borrow_mut` has strictly stronger preconditions than `borrow`.
+        unsafe { Self::borrow(ptr) }
+    }
+}
+
+impl<T: Send, A: Allocator> ForeignOwnableRcu for RcuBox<T, A> {
+    type RcuBorrowed<'a>
+        = &'a T
+    where
+        Self: 'a;
+
+    unsafe fn rcu_borrow<'a>(ptr: *mut c_void) -> &'a T
+    where
+        Self: 'a,
+    {
+        // SAFETY: `RcuBox::drop` can only run after `from_foreign` is called, and the value is
+        // valid until `RcuBox::drop` plus one grace period.
+        unsafe { &(*ptr.cast::<RcuBoxInner<T>>()).value }
+    }
+}
+
+impl<T: Send, A: Allocator> Drop for RcuBox<T, A> {
+    fn drop(&mut self) {
+        // SAFETY: The `rcu_head` field is in-bounds of a valid allocation.
+        let rcu_head = unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
+        if core::mem::needs_drop::<T>() {
+            // SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInner<T>`. All users will be
+            // gone in an rcu grace period. This is the destructor, so we may pass ownership of the
+            // allocation.
+            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T, A>)) };
+        } else {
+            // SAFETY: All users will be gone in an rcu grace period.
+            // TODO: We are luckily since `kvfree_call_rcu()` works on both kmalloc and vmalloc,
+            // maybe a new `Allocator` method is needed.
+            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr().cast()) };
+        }
+    }
+}
+
+/// Free this `RcuBoxInner<T>`.
+///
+/// # Safety
+///
+/// `head` references the `rcu_head` field of an `RcuBoxInner<T>` that has no references to it.
+/// Ownership of the `Box<RcuBoxInner<T>, A>` must be passed.
+unsafe extern "C" fn drop_rcu_box<T, A: Allocator>(head: *mut bindings::callback_head) {
+    // SAFETY: Caller provides a pointer to the `rcu_head` field of a `RcuBoxInner<T>`.
+    let box_inner = unsafe { crate::container_of!(head, RcuBoxInner<T>, rcu_head) };
+
+    // SAFETY: Caller ensures exclusive access and passed ownership.
+    drop(unsafe { Box::<_, A>::from_raw(box_inner) });
+}
+
+#[kunit_tests(rust_rcu_box)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn rcu_box_basic() -> Result {
+        let rb = RcuBox::<_, alloc::allocator::Kmalloc>::new(42i32, alloc::flags::GFP_KERNEL)?;
+
+        assert_eq!(*rb, 42);
+        assert_eq!(*rb.with_rcu(&Guard::new()), 42);
+
+        drop(rb);
+
+        let rb = RcuBox::<_, alloc::allocator::Vmalloc>::new(42i32, alloc::flags::GFP_KERNEL)?;
+
+        assert_eq!(*rb, 42);
+        assert_eq!(*rb.with_rcu(&Guard::new()), 42);
+
+        drop(rb);
+
+        Ok(())
+    }
+}
-- 
2.50.1 (Apple Git-155)

