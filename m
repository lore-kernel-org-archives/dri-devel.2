Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1464FCD5BD5
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 21:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C7C10E6FD;
	Tue, 26 May 2026 21:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Rzk1TyeZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC89710E646
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 21:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779830978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QL8IN54+GyGVagQ4DvSBXnS5z3z6Qs2E9s4W5m7b30w=;
 b=Rzk1TyeZNTc+1qbTHFUuHg+yHGZEZyz4Cszh3QoJbwwguwdmQJhiHR3QvgGmDlYTuhen/b
 2aPQUvoqvqv/GO4BW1WXQe25+UTtI79e2VZRvZneaDzikb+8FKzAJIGfEuDvQ0w2h47MGJ
 WN19l43w+/DwQkVv3mhuJ0X2DFITyAc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-421teixfOUim_1ns9ewfGQ-1; Tue,
 26 May 2026 17:29:33 -0400
X-MC-Unique: 421teixfOUim_1ns9ewfGQ-1
X-Mimecast-MFC-AGG-ID: 421teixfOUim_1ns9ewfGQ_1779830970
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D5C918002EF; Tue, 26 May 2026 21:29:30 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.238])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AB4D30001BE; Tue, 26 May 2026 21:29:27 +0000 (UTC)
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
Subject: [PATCH v14 6/6] rust: drm: gem: Introduce shmem::Object::sg_table()
Date: Tue, 26 May 2026 17:28:57 -0400
Message-ID: <20260526212857.1158294-7-lyude@redhat.com>
In-Reply-To: <20260526212857.1158294-1-lyude@redhat.com>
References: <20260526212857.1158294-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: ZquKi4Fa6QWPWGxiePf5SrQinZd1k6Irl3iGrdrXaNs_1779830970
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

 rust/kernel/drm/gem/shmem.rs | 214 +++++++++++++++++++++++++++++++++--
 1 file changed, 204 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 1b24cb1129a8b..12307ec6bff07 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -11,15 +11,29 @@
 
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
         private::Sealed,
         Device, //
     },
-    error::to_result,
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
     prelude::*,
-    sync::aref::ARef,
+    scatterlist,
+    sync::{
+        aref::ARef,
+        new_lazy_init,
+        LazyInit,
+        LazyInitError, //
+    },
     types::Opaque, //
 };
 use core::{
@@ -75,6 +89,9 @@ pub struct Object<T: DriverObject> {
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
     parent_resv_obj: Option<ARef<Object<T>>>,
+    /// Devres object for unmapping any SGTable on driver-unbind.
+    #[pin]
+    sgt_res: LazyInit<Devres<SGTableMap<T>>>,
     #[pin]
     inner: T,
 }
@@ -127,6 +144,7 @@ pub fn new(
             try_pin_init!(Self {
                 obj <- Opaque::init_zeroed(),
                 parent_resv_obj: config.parent_resv_obj.map(|p| p.into()),
+                sgt_res <- new_lazy_init!(),
                 inner <- T::new(dev, size, args),
             }),
             GFP_KERNEL,
@@ -170,22 +188,49 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
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
         //   `Object<T>`
-        let this = unsafe { container_of!(Opaque::cast_from(this), Self, obj) }.cast_mut();
+        let this = unsafe { container_of!(Opaque::cast_from(base), Self, obj) }.cast_mut();
+
+        // We need to reset `sgt_res` first, since doing so requires that the GEM object is still
+        // alive.
+        // SAFETY:
+        // - We verified above that `this` is valid.
+        // - `&mut (*this)` does not implement Unpin.
+        unsafe { Pin::new_unchecked(&mut (*this).sgt_res) }.reset();
+
+        // SAFETY:
+        // - We're in free_callback - so this function is safe to call.
+        // - We won't be using the gem resources on `this` after this call.
+        unsafe { bindings::drm_gem_shmem_release(base) };
 
         // SAFETY: We're recovering the Kbox<> we created in gem_create_object()
         let _ = unsafe { KBox::from_raw(this) };
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
+        match self.sgt_res.init(Devres::new(dev, SGTableMap::new(self))) {
+            Ok(ret) | Err(LazyInitError::AlreadyInit(ret)) => Ok(ret.access(dev)?),
+            Err(LazyInitError::DuringInit(e)) => Err(e),
+        }
+    }
 }
 
 impl<T: DriverObject> Deref for Object<T> {
@@ -246,7 +291,6 @@ impl<T: DriverObject> driver::AllocImpl for Object<T> {
 
 impl<'a, T: DriverObject> DmaResvGuard<'a, T> {
     #[inline(always)]
-    #[expect(unused)]
     fn new(obj: &'a Object<T>) -> Self {
         // SAFETY: This lock is initialized throughout the lifetime of `object`.
         unsafe { bindings::dma_resv_lock(obj.raw_dma_resv(), ptr::null_mut()) };
@@ -262,3 +306,153 @@ fn drop(&mut self) {
         unsafe { bindings::dma_resv_unlock(self.0.raw_dma_resv()) };
     }
 }
+
+/// A reference to a GEM object that is known to have a mapped [`SGTable`].
+///
+/// This is used by the Rust bindings with [`Devres`] in order to ensure that mappings for SGTables
+/// on GEM shmem objects are revoked on driver-unbind.
+///
+/// # Invariants
+///
+/// - `self.obj` always points to a valid GEM object.
+/// - This object is proof that `self.obj.owner.sgt` has an initialized and valid
+///   [`scatterlist::SGTable`].
+pub struct SGTableMap<T: DriverObject> {
+    obj: NonNull<Object<T>>,
+}
+
+impl<T: DriverObject> Deref for SGTableMap<T> {
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
+impl<T: DriverObject> Drop for SGTableMap<T> {
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
+impl<T: DriverObject> SGTableMap<T> {
+    fn new(obj: &Object<T>) -> impl Init<Self, Error> {
+        // INVARIANT:
+        // - We call drm_gem_shmem_get_pages_sgt_locked below and check whether or not it
+        //   succeeds, fulfilling the invariant of SGTableMap that the object's `sgt` field is
+        //   initialized.
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
+unsafe impl<T: DriverObject> Send for SGTableMap<T> {}
+// SAFETY: The NonNull in SGTableMap is guaranteed valid by our type invariants, and the GEM object
+// it points to is guaranteed to be thread-safe.
+unsafe impl<T: DriverObject> Sync for SGTableMap<T> {}
+
+#[kunit_tests(rust_gem_shmem)]
+mod tests {
+    use super::*;
+    use crate::{
+        drm,
+        faux,
+        page::PAGE_SIZE, //
+    };
+
+    // The bare minimum needed to create a fake drm driver for kunit
+
+    #[pin_data]
+    struct KunitData {}
+    struct KunitDriver;
+    struct KunitFile;
+    #[pin_data]
+    struct KunitObject {}
+
+    const INFO: drm::DriverInfo = drm::DriverInfo {
+        major: 0,
+        minor: 0,
+        patchlevel: 0,
+        name: c"kunit",
+        desc: c"Kunit",
+    };
+
+    impl drm::file::DriverFile for KunitFile {
+        type Driver = KunitDriver;
+
+        fn open(_dev: &drm::Device<KunitDriver>) -> Result<Pin<KBox<Self>>> {
+            Ok(KBox::new(Self, GFP_KERNEL)?.into())
+        }
+    }
+
+    impl gem::DriverObject for KunitObject {
+        type Driver = KunitDriver;
+        type Args = ();
+
+        fn new(
+            _dev: &drm::Device<KunitDriver>,
+            _size: usize,
+            _args: Self::Args,
+        ) -> impl PinInit<Self, Error> {
+            try_pin_init!(KunitObject {})
+        }
+    }
+
+    #[vtable]
+    impl drm::Driver for KunitDriver {
+        type Data = KunitData;
+        type File = KunitFile;
+        type Object = Object<KunitObject>;
+
+        const INFO: drm::DriverInfo = INFO;
+        const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor] = &[];
+    }
+
+    fn create_drm_dev(
+        name: &'static CStr,
+    ) -> Result<(faux::Registration, ARef<drm::Device<KunitDriver>>)> {
+        // Create a faux DRM device so we can test gem object creation.
+        let data = try_pin_init!(KunitData {});
+        let dev = faux::Registration::new(name, None)?;
+        let drm = drm::Device::<KunitDriver>::new(dev.as_ref(), data)?;
+
+        Ok((dev, drm))
+    }
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
+        let (dev, drm) = create_drm_dev(Some(c"Kunit"))?;
+        let (wrong_dev, wrong_drm) = create_drm_dev(Some(c"EvilKunit"))?;
+
+        let obj = Object::<KunitObject>::new(&drm, PAGE_SIZE, ObjectConfig::default(), ())?;
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
+}
-- 
2.54.0

