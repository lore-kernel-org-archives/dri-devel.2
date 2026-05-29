Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3EDCD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 17:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB7B112310;
	Fri, 29 May 2026 17:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="J2x2iaFU";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257B7112310
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780075934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OrO3a42S41lJJNYXb6XfMiTxjoSVK/EuCVR7kSM8TA=;
 b=J2x2iaFUbtV+erMQyAnZNI40S926risTTUX59BZ0LQXiysnk9A9bbBO3UhumX9/3cjHVk+
 mjDSsFTXXcXq7mQdWMHrGXYj4rih7RQfEZ4YEeZOpjNVUjXgVfBsWr8FTx0T75McaCODVC
 H9LkmrQd11xpufYHWk9LfHsYgbC09RU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-sMu1eDT_NbGDOylbKIWmPQ-1; Fri,
 29 May 2026 13:32:09 -0400
X-MC-Unique: sMu1eDT_NbGDOylbKIWmPQ-1
X-Mimecast-MFC-AGG-ID: sMu1eDT_NbGDOylbKIWmPQ_1780075927
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83104180058F; Fri, 29 May 2026 17:32:07 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.89.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D6373002D2D; Fri, 29 May 2026 17:32:05 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: "Gary Guo" <gary@garyguo.net>, "Ingo Molnar" <mingo@redhat.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Benno Lossin" <lossin@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 2/2] rust: sync: Introduce LazyInit
Date: Fri, 29 May 2026 13:30:42 -0400
Message-ID: <20260529173137.303717-3-lyude@redhat.com>
In-Reply-To: <20260529173137.303717-1-lyude@redhat.com>
References: <20260529173137.303717-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: uFyErNQJ5e0iDK6z_5qtOJn-bryLs7LbGrMH2jLYCMw_1780075927
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

SetOnce is nice, but it does have one problem - you can't use it with
fallible initializers. While we will be adding support for doing that with
SetOnce, this leads into another problem: There's no way for racing callers
to actually block on the initialization of SetOnce, which makes it a
difficult type to use safely for situations where we want to initialize
data fallibly once, and then provide access to it to multiple users at once
until drop.

So to solve this, introduce a new type: LazyInit. LazyInit is like SetOnce
with a couple of important differences:

* It can't be used in const context
* It can handle in-place fallible initializers.
* It uses a Mutex for synchronization instead of an atomic, allowing
  callers to block on initialization.
* It requires its contents already be Send + Sync, since the Mutex protects
  initializing data and not the data itself.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Get rid of references to populate() in safety comments
* Drop unused import in kunit tests
* s/r @ _/r/ in unit tests
* Fix many safety comments, a few of them did not get updated by me by
  mistake before submitting the first version of this series.
* Pin-project harder, since the last time I looked at this I've got a
  better understanding of pin projection - so let's take advantage of that
  to cut down on some unsafe blocks.
* Improve root doc comment a little bit
* Improve INVARIANT comments

 rust/kernel/sync.rs           |   2 +
 rust/kernel/sync/lazy_init.rs | 352 ++++++++++++++++++++++++++++++++++
 2 files changed, 354 insertions(+)
 create mode 100644 rust/kernel/sync/lazy_init.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 993dbf2caa0e3..d18c26c56c4d2 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -15,6 +15,7 @@
 pub mod barrier;
 pub mod completion;
 mod condvar;
+mod lazy_init;
 pub mod lock;
 mod locked_by;
 pub mod poll;
@@ -25,6 +26,7 @@
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use completion::Completion;
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
+pub use lazy_init::*;
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
diff --git a/rust/kernel/sync/lazy_init.rs b/rust/kernel/sync/lazy_init.rs
new file mode 100644
index 0000000000000..3f3126f4b153b
--- /dev/null
+++ b/rust/kernel/sync/lazy_init.rs
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Thread-safe lazy-initialization containers for use with [`Init`] and [`PinInit`].
+use crate::{
+    prelude::*,
+    sync::{
+        LockClassKey,
+        Mutex,
+        MutexGuard, //
+    },
+};
+use core::{
+    mem::{
+        self,
+        MaybeUninit, //
+    },
+    ptr,
+};
+use pin_init::{
+    pin_init,
+    PinInit, //
+};
+
+/// # Invariants
+///
+/// - `data` is guaranteed to be initialized if `is_init` is `true`.
+/// - There is only one location where `data` is written to through an immutable shared reference,
+///   `LazyInit::init()`. All other places where `data` is written to through this container require
+///   exclusive mutable references. This means `data` cannot be deinitialized so long as shared
+///   references to it exist.
+#[pin_data(PinnedDrop)]
+struct Inner<T: Send + Sync> {
+    #[pin]
+    data: MaybeUninit<T>,
+    is_init: bool,
+}
+
+#[pinned_drop]
+impl<T: Send + Sync> PinnedDrop for Inner<T> {
+    fn drop(self: Pin<&mut Self>) {
+        if self.is_init {
+            let project = self.project();
+
+            // SAFETY:
+            // - We drop this in place, ensuring we don't violate pinning invariants.
+            // - `is_init` is true, ensuring `data` is initialized via our type invariants.
+            unsafe { project.data.get_unchecked_mut().assume_init_drop() };
+
+            *project.is_init = false;
+        }
+    }
+}
+
+/// Errors that can occur during [`LazyInit::new`].
+#[derive(Debug)]
+pub enum LazyInitError<'a, T: Send + Sync, E = Error> {
+    /// The [`LazyInit`] has already been initialized.
+    ///
+    /// `self.0` contains a reference to the previously initialized value.
+    AlreadyInit(&'a T),
+    /// An error occurred during initialization.
+    DuringInit(E),
+}
+
+impl<'a, T: Send + Sync, E> From<E> for LazyInitError<'a, T, E> {
+    fn from(value: E) -> Self {
+        Self::DuringInit(value)
+    }
+}
+
+/// Creates a [`LazyInit`] initialiser with the given name and newly-created lock class.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_lazy_init {
+    ($( $name:literal )?) => {
+        $crate::sync::LazyInit::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+pub use new_lazy_init;
+
+/// A thread-safe container that allows thread-safe single-time initialization of its contents,
+/// which can then have shared references taken to its contents. It is similar to [`SetOnce`] except
+/// that it uses a [`Mutex`], it can be populated using fallible [`PinInit`] initializers, and
+/// multiple callers attempting to initialize at the same time will block until the conetents of the
+/// [`LazyInit`] is finished initializing.
+///
+/// This type cannot be used in `const` contexts, however, unlike [`SetOnce`] users of this type are
+/// able to block if another thread is busy populating the [`SetOnce`]. This also allows the use of
+/// fallible initializers for population.
+///
+/// This type internally uses a [`Mutex`] for synchronizing creation of `T`, but allows access to
+/// `T` outside of lock post-init. This means that only the initialization of the value is protected
+/// by the lock, and thus `T` must provide it's own synchronization by implementing `Send` + `Sync`.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::{
+///     LazyInit,
+///     LazyInitError,
+///     Arc,
+///     new_lazy_init, //
+/// };
+///
+/// struct Inner {
+///     a: u8,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     #[pin]
+///     lazy: LazyInit<Arc<Inner>>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             lazy <- new_lazy_init!(),
+///         })
+///     }
+/// }
+///
+/// // Allocate a boxed `Example`.
+/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
+///
+/// assert!(e.lazy.init(Arc::init(init!(Inner { a: 42 }), GFP_KERNEL)).is_ok());
+///
+/// // `as_ref()` can be used to get a reference to the contents of a `LazyInit` if its initialized.
+/// assert_eq!(e.lazy.as_ref().unwrap().a, 42);
+///
+/// // If `LazyInit::init()` fails due to the `LazyInit` already being initialized, a reference to
+/// // the initialized data can still be retrieved from the error.
+/// match e.lazy.init(Arc::init(init!(Inner { a: 54 }), GFP_KERNEL)) {
+///     Err(LazyInitError::AlreadyInit(ret)) => assert_eq!(ret.a, 42),
+///     _ => unreachable!(),
+/// }
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// [`SetOnce`]: super::SetOnce
+#[pin_data]
+pub struct LazyInit<T: Send + Sync> {
+    #[pin]
+    inner: Mutex<Inner<T>>,
+}
+
+impl<T: Send + Sync> LazyInit<T> {
+    /// Create a new initializer for an empty [`LazyInit`].
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            inner <- Mutex::new(
+                pin_init!(Inner {
+                    data <- MaybeUninit::uninit(),
+                    is_init: false,
+                }),
+                name,
+                key
+            )
+        })
+    }
+
+    /// Retrieve the contents of `inner.data` and extend their lifetime.
+    ///
+    /// # Safety
+    ///
+    /// The caller guarantees that `self.inner.data` has been previously initialized.
+    #[inline(always)]
+    unsafe fn data<'a>(&'a self, inner: &MutexGuard<'_, Inner<T>>) -> &'a T {
+        // SAFETY:
+        // - Our safety contract guarantees `inner.data` is initialized.
+        // - `T` is `Send` + `Sync`, and thus does not need the `Mutex` for synchronization, making
+        //   it safe to hold onto outside of the lock.
+        // - We're guaranteed via `Inner`'s type invariants that so long as immutable references to
+        //   self exist, `data` cannot be uninitialized - ensuring it lives throughout the lifetime
+        //   of A.
+        // - We're guaranteed the container of `T` will not be written to via `Inner`s type
+        //   invariants until `Drop`, ensuring it remains populated for the lifetime of 'a.
+        unsafe { mem::transmute::<&_, &'a _>(inner.data.assume_init_ref()) }
+    }
+
+    /// Attempt to init the contents of [`LazyInit`] and return a reference to its contents.
+    ///
+    /// If the contents of the [`LazyInit`] were already initialized, they will not be
+    /// re-initialized.
+    ///
+    /// Returns:
+    ///
+    /// - `Ok(&T)` if the container was initialized successfully, or if it was already initialized
+    ///   by another user.
+    /// - [`Err(LazyInitError::AlreadyInit)`](LazyInitError::AlreadyInit) if the container was
+    ///   already initialized. This error contains a reference to the contents of the [`LazyInit`].
+    /// - [`Err(LazyInitError::DuringInit)`](LazyInitError::DuringInit) if an error was encountered
+    ///   while trying to initialize this [`LazyInit`].
+    pub fn init<'a, E>(
+        &'a self,
+        init: impl PinInit<T, E>,
+    ) -> Result<&'a T, LazyInitError<'a, T, E>> {
+        let mut inner = self.inner.lock();
+        let do_init = !inner.is_init;
+
+        if do_init {
+            let inner = inner.as_mut().project();
+
+            // INVARIANT: This is the only place we can write to `data` through an immutable shared
+            // reference, and because we check `do_init` before writing - it can only be written to
+            // once.
+            //
+            // SAFETY:
+            // - We drop `inner.data` in place, ensuring we don't violate pinning invariants.
+            // - Via Inner's invariants, since we checked `is_init` we're guaranteed `data` is
+            //   uninitialized.
+            // - We do not touch `data` at any point after this if we fail.
+            // - This does not move `data`.
+            unsafe { init.__pinned_init(inner.data.get_unchecked_mut().as_mut_ptr()) }?;
+
+            // INVARIANT: Now that we've successfully initialized `inner.data`, we update
+            // `inner.is_init` to reflect this - fulfilling the relevant Inner type invariant.
+            *inner.is_init = true;
+        }
+
+        // SAFETY: We confirmed `data` is initialized above.
+        let ret = unsafe { self.data(&inner) };
+
+        match do_init {
+            true => Ok(ret),
+            false => Err(LazyInitError::AlreadyInit(ret)),
+        }
+    }
+
+    /// Get a reference to the contained object.
+    ///
+    /// Returns [`None`] if this [`LazyInit`] is empty.
+    pub fn as_ref<'a>(&'a self) -> Option<&'a T> {
+        let inner = self.inner.lock();
+
+        inner.is_init.then(|| {
+            // SAFETY: This closure can only execute if `inner.is_init` is true, guaranteeing
+            // `inner.data` is initialized via `Inner`s type invariants.
+            unsafe { self.data(&inner) }
+        })
+    }
+
+    /// Release the contents of the [`LazyInit`].
+    ///
+    /// Since this call borrows the [`LazyInit`] mutably, no locking actually needs to take place -
+    /// as parallel lock acquisitions are prevented via the compiler enforcing Rust's borrowing
+    /// rules.
+    ///
+    /// Returns [`true`] if `self` was initialized before calling this function.
+    pub fn reset(self: Pin<&mut Self>) -> bool {
+        let inner = self.project().inner.get_mut_pinned();
+        let was_init = inner.is_init;
+
+        // SAFETY:
+        // - We drop in place, and therefore do not move `inner`.
+        // - The `PinnedDrop` implementation of `Inner` leaves it in a well-defined
+        //   state, so we do not need to worry about UB from further usage.
+        unsafe { ptr::drop_in_place(inner.get_unchecked_mut()) };
+
+        was_init
+    }
+}
+
+#[kunit_tests(rust_lazy_init)]
+mod tests {
+    use super::*;
+    use pin_init::{
+        init_from_closure,
+        stack_pin_init, //
+    };
+
+    #[derive(Debug)]
+    #[pin_data]
+    struct LazyInitTest {}
+
+    impl LazyInitTest {
+        fn init_ok() -> impl Init<Self> {
+            init!(LazyInitTest {})
+        }
+
+        fn init_err(e: Error) -> impl Init<Self, Error> {
+            // SAFETY:
+            // This initializer is intended to fail for testing purposes, and does not actually
+            // initialize any data meaning:
+            //
+            // - We don't need to worry about returning Ok(()).
+            // - We have nothing to actually clean in the slot.
+            // - Since there is no data in the slot, nothing can meaningfully move and we have no
+            //   pinning invariants.
+            unsafe { init_from_closure(move |_| Err(e)) }
+        }
+    }
+
+    fn try_lazy_init(once: &LazyInit<LazyInitTest>) -> Result {
+        // It should start as being empty.
+        assert!((*once).as_ref().is_none());
+
+        // Try populating it a single time, this should succeed.
+        let res = once.init(LazyInitTest::init_ok()).map_err(|_| EINVAL)?;
+        assert!((*once).as_ref().is_some());
+
+        // Populating a second time should fail and return the contents.
+        match once.init(LazyInitTest::init_ok()) {
+            Err(LazyInitError::AlreadyInit(data)) => assert!(core::ptr::eq(data, res)),
+            r => panic!("Calling once.init() twice returned unexpected value: {r:?}"),
+        }
+
+        // And it should still hold a value
+        assert!((*once).as_ref().is_some());
+
+        Ok(())
+    }
+
+    #[test]
+    fn lazy_init() -> Result {
+        stack_pin_init!(let once: LazyInit<LazyInitTest> = new_lazy_init!());
+
+        try_lazy_init(&once)?;
+        Ok(())
+    }
+
+    #[test]
+    fn lazy_init_error() -> Result {
+        stack_pin_init!(let once: LazyInit<LazyInitTest> = new_lazy_init!());
+
+        // Make sure it starts as empty.
+        assert!((*once).as_ref().is_none());
+
+        // Try populating it with a initializer that fails.
+        match once.init(LazyInitTest::init_err(EJUKEBOX)) {
+            Err(LazyInitError::DuringInit(e)) => assert_eq!(e, EJUKEBOX),
+            r => panic!(
+                "Calling once.init() with a failing initializer returned an unexpected value: {r:?}"
+            ),
+        }
+
+        try_lazy_init(&once)?;
+        Ok(())
+    }
+
+    #[test]
+    fn lazy_init_reset() -> Result {
+        stack_pin_init!(let once: LazyInit<LazyInitTest> = new_lazy_init!());
+
+        try_lazy_init(&once)?;
+        assert_eq!(once.as_mut().reset(), true);
+        assert_eq!(once.as_mut().reset(), false);
+        try_lazy_init(&once)
+    }
+}
-- 
2.54.0

