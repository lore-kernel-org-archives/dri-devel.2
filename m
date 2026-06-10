Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41CACD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C32E10EA67;
	Wed, 10 Jun 2026 16:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IImTFdhu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB9C10EA4D
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781108704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZ+zxZ1FH7NXma63fMfduhUhWlUnlPWIbw94j9fevdM=;
 b=IImTFdhuuYjCSR+UM9h7Q6NKB1wFTRKzMIu/fDE7pV6P/83agClCZLF2JfozBM7edRV7Dd
 9ycpQnznZgZwSnw42j/FaZuzPKuOznKTg63A0scK9jy1ysQfeot0d+EqAG5KBjaATAUL9S
 aaPDbrRmrPE04qQLA73kkCn/+PPJw+w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-GBAqF2m0Oum2LbJZZwrxZw-1; Wed,
 10 Jun 2026 12:24:58 -0400
X-MC-Unique: GBAqF2m0Oum2LbJZZwrxZw-1
X-Mimecast-MFC-AGG-ID: GBAqF2m0Oum2LbJZZwrxZw_1781108695
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9735F18600E0; Wed, 10 Jun 2026 16:24:55 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.89.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 447F73008DCC; Wed, 10 Jun 2026 16:24:52 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Danilo Krummrich <dakr@kernel.org>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Lyude Paul <lyude@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v20 4/4] rust: drm: gem: Introduce shmem::Object::sg_table()
Date: Wed, 10 Jun 2026 12:21:31 -0400
Message-ID: <20260610162433.923550-5-lyude@redhat.com>
In-Reply-To: <20260610162433.923550-1-lyude@redhat.com>
References: <20260610162433.923550-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: sAfKuU97_aAUTDppS0ysW_cZyVDk7B8DFAynyz_dnzI_1781108695
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

In order to do this, we need to be careful to ensure that any interface we
expose for scatterlists ensures that any mappings created from one are
destroyed on driver-unbind. To do this, we introduce a Devres resource into
shmem::Object that we use in order to ensure that we release any SGTable
mappings on driver-unbind.

There's some other slightly unfortunate caveats of this:

* Drivers don't have explicit control at the moment over when unmapping
  happens (which is exactly the same as the C side atm, so it might not be
  a problem).
* We can't just return `SGTableMap` to the user through an Arc to attempt
  to fix the last caveat - because that implies the gem object would need
  to hold a reference count to the scatterlist mapping, which just leaves
  us with the same problem.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

---
V3:
* Rename OwnedSGTable to shmem::SGTable. Since the current version of the
  SGTable abstractions now has a `Owned` and `Borrowed` variant, I think
  renaming this to shmem::SGTable makes things less confusing.
  We do however, keep the name of owned_sg_table() as-is.
V4:
* Clarify safety comments for SGTable to explain why the object is
  thread-safe.
* Rename from SGTableRef to SGTable
V10:
* Use Devres in order to ensure that SGTables are revocable, and are
  unmapped on driver-unbind.
V11:
* s/create_sg_table()/get_sg_table()
* Get rid of extraneous `ret = ` in shmem::Object::get_sg_table()
V12:
* Actually move sgt_res in this patch and not the next one
V13:
* Use DmaResvGuard suggestion from Alexander
* Use Alexander's (much better) solution for get_sg_table()
* Use SetOnce instead of UnsafeCell
* s/SGTableRef/SGTableMap
* Fix typo in SGTableMap documentation
* Create fallible constructor for SGTableMap
* Don't reuse dma_resv lock for protecting Object contents, just use Mutex
  + SetOnce
* Drop use of drm_gem_shmem_get_pages_sgt_locked(), since we don't need to
  hold the dma_resv lock ourselves for anything but this function.
* Check that the device we receive in the bounds for sg_table() and
  owned_sg_table() that said Device is in fact, the correct device.
* Remove redundant docs in owned_sg_table(), just point it back to
  sg_table().
* Implement Deborah's suggestion to fix double-free in
  free_callback()
* Restore original order of Object<T>
* Fix doc typo for SGTableMap
V14:
* Use new InitOnce container over the Mutex/SetOnce horror show we had
  before.
* Start using LazyInit container for storing Devres for sgt unmap
* Add some kunit tests for sg_table (not sure why I didn't do this before)
  using some of the boilerplate code leftover from the vmap bindings
* Get rid of the owned SGTable variant for now, we'll add it back in a
  future patch if people actually need it.
* Use new LazyInit container from me to get rid of the horrid
  Mutex<SetOnce<>> mess.
* Add the best we can do for unit tests w/r/t SGTable at the moment
V16:
* Get rid of LazyInit, go back to SetOnce, use trick that Alice recommended
  that is a lot cleaner.
* Fix horrid rebasing mistake
V17:
* Rebase
* Fix missing safety comment in free_callback() (we forgot to justify why
  &mut is safe in `unsafe { &mut (*this).sgt_res }.reset()`)
V18:
* Use ManuallyDrop instead of SetOnce::reset()
V19:
* Explain that populate() will always return true in sg_table()
* Fix outdated comment in SGTableMap
* Fix invariant comment in SGTableMap

 rust/kernel/drm/gem/shmem.rs | 174 +++++++++++++++++++++++++++++++++--
 1 file changed, 164 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 68a1ce3330b11..9dcdab5f78cd4 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -11,6 +11,11 @@
 
 use crate::{
     container_of,
+    device::{
+        self,
+        Bound, //
+    },
+    devres::*,
     drm::{
         driver,
         gem,
@@ -19,14 +24,23 @@
         DeviceContext,
         Registered, //
     },
-    error::to_result,
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
     io::{
         Io,
         IoCapable,
         IoKnownSize, //
     },
     prelude::*,
-    sync::aref::ARef,
+    scatterlist,
+    sync::{
+        aref::ARef,
+        new_mutex,
+        Mutex,
+        SetOnce, //
+    },
     types::{
         NotThreadSafe,
         Opaque, //
@@ -35,7 +49,10 @@
 use core::{
     ffi::c_void,
     marker::PhantomData,
-    mem::MaybeUninit, //
+    mem::{
+        ManuallyDrop,
+        MaybeUninit, //
+    },
     ops::{
         Deref,
         DerefMut, //
@@ -90,6 +107,11 @@ pub struct Object<T: DriverObject, C: DeviceContext = Registered> {
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
     parent_resv_obj: Option<ARef<Object<T, C>>>,
+    /// Devres object for unmapping any SGTable on driver-unbind.
+    sgt_res: ManuallyDrop<SetOnce<Devres<SGTableMap<T, C>>>>,
+    #[pin]
+    /// Lock for protecting initialization of `sgt_res`.
+    sgt_lock: Mutex<()>,
     #[pin]
     inner: T,
     _ctx: PhantomData<C>,
@@ -148,6 +170,8 @@ pub fn new(
             try_pin_init!(Self {
                 obj <- Opaque::init_zeroed(),
                 parent_resv_obj: config.parent_resv_obj.map(|p| p.into()),
+                sgt_res: ManuallyDrop::new(SetOnce::new()),
+                sgt_lock <- new_mutex!(()),
                 inner <- T::new(dev, size, args),
                 _ctx: PhantomData::<C>,
             }),
@@ -192,18 +216,26 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
         // - DRM always passes a valid gem object here
         // - We used drm_gem_shmem_create() in our create_gem_object callback, so we know that
         //   `obj` is contained within a drm_gem_shmem_object
-        let this = unsafe { container_of!(obj, bindings::drm_gem_shmem_object, base) };
-
-        // SAFETY:
-        // - We're in free_callback - so this function is safe to call.
-        // - We won't be using the gem resources on `this` after this call.
-        unsafe { bindings::drm_gem_shmem_release(this) };
+        let base = unsafe { container_of!(obj, bindings::drm_gem_shmem_object, base) };
 
         // SAFETY:
         // - We verified above that `obj` is valid, which makes `this` valid
         // - This function is set in AllocOps, so we know that `this` is contained within a
         //   `Object<T, C>`
-        let this = unsafe { container_of!(Opaque::cast_from(this), Self, obj) }.cast_mut();
+        let this = unsafe { container_of!(Opaque::cast_from(base), Self, obj) }.cast_mut();
+
+        // We need to drop `sgt_res` first, since doing so requires that the GEM object is still
+        // alive.
+        // SAFETY:
+        // - We verified above that `this` is valid.
+        // - We are in free_callback, guaranteeing we have exclusive access to `this` and that
+        //   `sgt_res` will not be used after dropping it here.
+        unsafe { ManuallyDrop::drop(&mut (*this).sgt_res) };
+
+        // SAFETY:
+        // - We're in free_callback - so this function is safe to call.
+        // - We won't be using the gem resources on `this` after this call.
+        unsafe { bindings::drm_gem_shmem_release(base) };
 
         // SAFETY: We're recovering the Kbox<> we created in gem_create_object()
         let _ = unsafe { KBox::from_raw(this) };
@@ -281,6 +313,46 @@ pub fn vmap<const SIZE: usize>(&self) -> Result<VMapRef<'_, T, C, SIZE>> {
     pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, C, SIZE>> {
         self.make_vmap()
     }
+
+    /// Creates (if necessary) and returns an immutable reference to a scatter-gather table of DMA
+    /// pages for this object.
+    ///
+    /// This will pin the object in memory. It is expected that `dev` should be a pointer to the
+    /// same [`device::Device`] which `self` belongs to, otherwise this function will return
+    /// `Err(EINVAL)`.
+    pub fn sg_table<'a>(
+        &'a self,
+        dev: &'a device::Device<Bound>,
+    ) -> Result<&'a scatterlist::SGTable> {
+        if dev.as_raw() != self.dev().as_ref().as_raw() {
+            return Err(EINVAL);
+        }
+
+        let sgt_res = 'out: {
+            // Fast path: sgt_res is already initialized
+            if let Some(sgt_res) = self.sgt_res.as_ref() {
+                break 'out sgt_res;
+            }
+
+            // Slow path: Grab the lock and see if we need to initialize sgt_res.
+            let _guard = self.sgt_lock.lock();
+
+            // If someone initialized it while we were waiting, we can exit early.
+            if let Some(sgt_res) = self.sgt_res.as_ref() {
+                break 'out sgt_res;
+            }
+
+            // If not, finish initializing and return. `populate()` cannot return false, as
+            // `sgt_res` must be unpopulated, and we must hold `sgt_lock` to reach this point.
+            self.sgt_res
+                .populate(Devres::new(dev, SGTableMap::new(self))?);
+
+            // SAFETY: We just populated sgt_res above.
+            unsafe { self.sgt_res.as_ref().unwrap_unchecked() }
+        };
+
+        Ok(sgt_res.access(dev)?)
+    }
 }
 
 impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {
@@ -497,6 +569,64 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 #[cfg(CONFIG_64BIT)]
 impl_vmap_io_capable!(u64);
 
+/// A reference to a GEM object that is known to have a mapped [`SGTable`].
+///
+/// This is used by the Rust bindings with [`Devres`] in order to ensure that mappings for SGTables
+/// on GEM shmem objects are revoked on driver-unbind.
+///
+/// # Invariants
+///
+/// - `self.obj` always points to a valid GEM object.
+/// - This object is proof that `self.obj.owner.sgt_res` has an initialized and valid pointer to an
+///   [`SGTable`].
+///
+/// [`SGTable`]: scatterlist::SGTable
+pub struct SGTableMap<T: DriverObject, C: DeviceContext> {
+    obj: NonNull<Object<T, C>>,
+}
+
+impl<T: DriverObject, C: DeviceContext> Deref for SGTableMap<T, C> {
+    type Target = scatterlist::SGTable;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY:
+        // - The NonNull is guaranteed to be valid via our type invariants.
+        // - The sgt field is guaranteed to be initialized and valid via our type invariants.
+        unsafe { scatterlist::SGTable::from_raw((*self.obj.as_ref().as_raw_shmem()).sgt) }
+    }
+}
+
+impl<T: DriverObject, C: DeviceContext> Drop for SGTableMap<T, C> {
+    fn drop(&mut self) {
+        // SAFETY: `obj` is always valid via our type invariants
+        let obj = unsafe { self.obj.as_ref() };
+        let _lock = DmaResvGuard::new(obj);
+
+        // SAFETY: We acquired the lock needed for calling this function above
+        unsafe { bindings::__drm_gem_shmem_free_sgt_locked(obj.as_raw_shmem()) };
+    }
+}
+
+impl<T: DriverObject, C: DeviceContext> SGTableMap<T, C> {
+    fn new(obj: &Object<T, C>) -> impl Init<Self, Error> {
+        // INVARIANT:
+        // - We call drm_gem_shmem_get_pages_sgt below and check whether or not it succeeds,
+        //   fulfilling the invariant of SGTableMap that the object's `sgt` field is initialized.
+        // SAFETY:
+        // - `obj` is fully initialized, making this function safe to call.
+        from_err_ptr(unsafe { bindings::drm_gem_shmem_get_pages_sgt(obj.as_raw_shmem()) })?;
+
+        Ok(Self { obj: obj.into() })
+    }
+}
+
+// SAFETY: The NonNull in SGTableMap is guaranteed valid by our type invariants, and the GEM object
+// it points to is guaranteed to be thread-safe.
+unsafe impl<T: DriverObject, C: DeviceContext> Send for SGTableMap<T, C> {}
+// SAFETY: The NonNull in SGTableMap is guaranteed valid by our type invariants, and the GEM object
+// it points to is guaranteed to be thread-safe.
+unsafe impl<T: DriverObject, C: DeviceContext> Sync for SGTableMap<T, C> {}
+
 #[kunit_tests(rust_drm_gem_shmem)]
 mod tests {
     use super::*;
@@ -613,4 +743,28 @@ fn vmap_io() -> Result {
 
         Ok(())
     }
+
+    // TODO: I would love to actually test the success paths of sg_table(), but that would require
+    // also implementing dummy dma_ops so that trying to create a mapping doesn't explode. So, leave
+    // that for someone else.
+
+    // Ensures that passing the wrong device to sg_table() fails as we expect, and also ensure it
+    // skips initializing `sgt_res` since we could otherwise create `sgt_res` with the wrong device
+    // bound to it.
+    #[test]
+    fn fail_sg_table_on_wrong_dev() -> Result {
+        let (_dev, drm) = create_drm_dev()?;
+        let wrong_dev = faux::Registration::new(c"EvilKunit", None)?;
+
+        let obj = Object::<KunitObject, _>::new(&drm, PAGE_SIZE, ObjectConfig::default(), ())?;
+
+        assert_eq!(obj.sg_table(wrong_dev.as_ref()).err().unwrap(), EINVAL);
+
+        // If sgt_res was not initialized mistakenly with the wrong device, this should still fail.
+        assert_eq!(obj.sg_table(wrong_dev.as_ref()).err().unwrap(), EINVAL);
+
+        // TODO: Someday, we should test that creating an sg_table here still succeeds.
+
+        Ok(())
+    }
 }
-- 
2.54.0

