Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6617DCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0CD10F692;
	Fri, 12 Jun 2026 19:45:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Z5VffGT7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BDF10F6AA
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781293515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwuPED89nQqouefrX1pxa+KVPjonwbTJEyx+s3xqlBI=;
 b=Z5VffGT7NVp8iddNi/RHKDmZcteOPD2XF3fIamiCpUsc5311Obdi3FjdWFsqUe3xJQl2vl
 lFO3oF3/s8PuiOC8b+y+TU3qrisZszt0YSJKF31xekkbin2eQSaPJTSYPz6tLvlwjE80+x
 F6pXunCBsCqCP8sNHszglW9JZp/9axc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-gGKyiGrPPKK1srXmXX0h6w-1; Fri,
 12 Jun 2026 15:45:07 -0400
X-MC-Unique: gGKyiGrPPKK1srXmXX0h6w-1
X-Mimecast-MFC-AGG-ID: gGKyiGrPPKK1srXmXX0h6w_1781293504
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19A631805C19; Fri, 12 Jun 2026 19:45:04 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A1A3D6E; Fri, 12 Jun 2026 19:44:59 +0000 (UTC)
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
Subject: [PATCH v21 2/4] rust: drm: gem: shmem: Add vmap functions
Date: Fri, 12 Jun 2026 15:43:34 -0400
Message-ID: <20260612194436.585385-3-lyude@redhat.com>
In-Reply-To: <20260612194436.585385-1-lyude@redhat.com>
References: <20260612194436.585385-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: QlKRzoExrSUtpoKrPe5Wg1CD_U93wG7f56U8tmzZWPY_1781293504
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

One of the more obvious use cases for gem shmem objects is the ability to
create mappings into their contents. So, let's hook this up in our rust
bindings.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
V7:
* Switch over to the new iosys map bindings that use the Io trait
V8:
* Get rid of iosys_map bindings for now, only support non-iomem types
* s/as_shmem()/as_raw_shmem()
V9:
* Get rid of some outdated comments I missed
* Add missing SIZE check to raw_vmap()
* Add a proper unit test that ensures that we actually validate SIZE at
  compile-time.
  Turns out it takes only 34 lines to make a boilerplate DRM driver for a
  kunit test :)
* Add unit tests
* Add some missing #[inline]s
V10:
* Correct issue with iomem error path
  We previously called raw_vunmap() if we got an iomem allocation, but
  raw_vunmap() was written such that it assumed all allocations were sysmem
  allocations. Fix this by just making raw_vunmap() accept a iosys_map.
V11:
* Use Alexandre's clever solution to remove the macros we were using for
  maintaining two different VMap types.
* Change the order of items in Object<T> to ensure that sgt_res is always
  dropped before obj.
* Fix typo in Object.raw_vmap()
* s/raw_vmap()/make_vmap()/
  Deduplicate code a bit more as well by using more generics here
V15:
* Add these patches back
* We only have one VMap type now!
* Use ObjectConfig::default() in unit tests since we unbroke it.
V16:
* Fix huge rebase error I made and did not notice that squashed 1.5 patches
  together that were definitely not supposed to be squashed
* Update old commit message
V17:
* Rebase
* Fix format of commit message title
V19:
* Drop outdated safety comment
* Move impl_vmap_io_capable! definition to right before it gets used
* Add missing `` in rustdoc for VMap type
* Add a bunch of missing `` in make_vmap()
* Remove one outdated safety comment about reading vaddr_iomem
* Add some missing periods in safety comments in make_vmap().
* Use read_volatile/write_volatile() instead of read()/write() to prevent
  compiler reordering.
* Remove impl argument from impl_vmap_io_capable!()
* Check .owner() and .maxsize() in compile_time_vmap_sizes()
* Use more varied pattern in vmap_io()
V20:
* Add missing Send/Sync implementations for VMap
* Use #[inline] not #[inline(always)]
* Add missing invariant comment to VMap instantiation
* Make sure that kunit test doesn't fail on big endian
V21:
* Update Send/Sync impl for VMap so we only implement them if `R` is also
  `Send`/`Sync`.
* Fix off by one error in vmap_io test.

 rust/kernel/drm/gem/shmem.rs | 338 ++++++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 090c5d869fdb7..a38c98add3d17 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -20,6 +20,11 @@
         Registered, //
     },
     error::to_result,
+    io::{
+        Io,
+        IoCapable,
+        IoKnownSize, //
+    },
     prelude::*,
     sync::aref::ARef,
     types::{
@@ -28,7 +33,9 @@
     },
 };
 use core::{
+    ffi::c_void,
     marker::PhantomData,
+    mem::MaybeUninit, //
     ops::{
         Deref,
         DerefMut, //
@@ -39,6 +46,7 @@
     },
 };
 use gem::{
+    BaseObject,
     BaseObjectPrivate,
     DriverObject,
     IntoGEMObject, //
@@ -200,6 +208,79 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
         // SAFETY: We're recovering the Kbox<> we created in gem_create_object()
         let _ = unsafe { KBox::from_raw(this) };
     }
+
+    /// Attempt to create a vmap from the gem object, and confirm the size of said vmap.
+    fn make_vmap<'a, R, const SIZE: usize>(&'a self) -> Result<VMap<T, R, C, SIZE>>
+    where
+        R: Deref<Target = Self> + From<&'a Self>,
+    {
+        // INVARIANT: We check here that the gem object is at least as large as `SIZE`.
+        if self.size() < SIZE {
+            return Err(ENOSPC);
+        }
+
+        let mut map: MaybeUninit<bindings::iosys_map> = MaybeUninit::uninit();
+        let guard = DmaResvGuard::new(self);
+
+        // SAFETY: `drm_gem_shmem_vmap()` can be called with the DMA reservation lock held.
+        to_result(unsafe {
+            bindings::drm_gem_shmem_vmap_locked(self.as_raw_shmem(), map.as_mut_ptr())
+        })?;
+
+        // Drop the guard explicitly here, since we may need to call `raw_vunmap()` (which
+        // re-acquires the lock).
+        drop(guard);
+
+        // SAFETY: The call to `drm_gem_shmem_vmap_locked()` succeeded above, so we are guaranteed
+        // that map is properly initialized.
+        let map = unsafe { map.assume_init() };
+
+        // XXX: We don't currently support iomem allocations
+        if map.is_iomem {
+            // SAFETY: The vmap operation above succeeded, guaranteeing that `map` points to a valid
+            // memory mapping.
+            unsafe { self.raw_vunmap(map) };
+
+            Err(ENOTSUPP)
+        } else {
+            Ok(VMap {
+                // INVARIANT: `addr` remains valid for as long as `owner` does, which extends to the
+                // lifetime of `VMap` itself.
+                // SAFETY: We checked that this is not an iomem allocation, making it safe to read
+                // vaddr.
+                addr: unsafe { map.__bindgen_anon_1.vaddr },
+                owner: self.into(),
+            })
+        }
+    }
+
+    /// Unmap a vmap from the gem object.
+    ///
+    /// # Safety
+    ///
+    /// - The caller promises that `map` is a valid vmap on this gem object.
+    /// - The caller promises that the memory pointed to by map will no longer be accesed through
+    ///   this instance.
+    unsafe fn raw_vunmap(&self, mut map: bindings::iosys_map) {
+        let _guard = DmaResvGuard::new(self);
+
+        // SAFETY:
+        // - This function is safe to call with the DMA reservation lock held.
+        // - The caller promises that `map` is a valid vmap on this gem object.
+        unsafe { bindings::drm_gem_shmem_vunmap_locked(self.as_raw_shmem(), &mut map) };
+    }
+
+    /// Creates and returns a virtual kernel memory mapping for this object.
+    #[inline]
+    pub fn vmap<const SIZE: usize>(&self) -> Result<VMapRef<'_, T, C, SIZE>> {
+        self.make_vmap()
+    }
+
+    /// Creates and returns an owned reference to a virtual kernel memory mapping for this object.
+    #[inline]
+    pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, C, SIZE>> {
+        self.make_vmap()
+    }
 }
 
 impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {
@@ -263,7 +344,6 @@ struct DmaResvGuard<'a, T: DriverObject, C: DeviceContext = Registered>(
 
 impl<'a, T: DriverObject, C: DeviceContext> DmaResvGuard<'a, T, C> {
     #[inline]
-    #[expect(unused)]
     fn new(obj: &'a Object<T, C>) -> Self {
         // SAFETY: This lock is initialized throughout the lifetime of `object`.
         unsafe { bindings::dma_resv_lock(obj.raw_dma_resv(), ptr::null_mut()) };
@@ -279,3 +359,259 @@ fn drop(&mut self) {
         unsafe { bindings::dma_resv_unlock(self.0.raw_dma_resv()) };
     }
 }
+
+/// A reference to a virtual mapping for an shmem-based GEM object in kernel address space.
+///
+/// # Invariants
+///
+/// - The size of `owner` is >= SIZE.
+/// - The memory pointed to by `addr` remains valid at least until this object is dropped.
+pub struct VMap<D, R, C = Registered, const SIZE: usize = 0>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target = Object<D, C>>,
+{
+    addr: *mut c_void,
+    owner: R,
+}
+
+/// An alias type for a reference to a shmem-based GEM object's VMap.
+pub type VMapRef<'a, D, C, const SIZE: usize = 0> = VMap<D, &'a Object<D, C>, C, SIZE>;
+
+/// An alias type for an owned reference to a shmem-based GEM object's VMap.
+pub type VMapOwned<D, C, const SIZE: usize = 0> = VMap<D, ARef<Object<D, C>>, C, SIZE>;
+
+impl<D, R, C, const SIZE: usize> VMap<D, R, C, SIZE>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target = Object<D, C>>,
+{
+    /// Borrows a reference to the object that owns this virtual mapping.
+    #[inline]
+    pub fn owner(&self) -> &Object<D, C> {
+        &self.owner
+    }
+}
+
+impl<D, R, C, const SIZE: usize> Drop for VMap<D, R, C, SIZE>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target = Object<D, C>>,
+{
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY:
+        // - Our existence is proof that this map was previously created using self.owner.
+        // - Since we are in Drop, we are guaranteed that no one will access the memory
+        //   through this mapping after calling this.
+        unsafe {
+            self.owner.raw_vunmap(bindings::iosys_map {
+                is_iomem: false,
+                __bindgen_anon_1: bindings::iosys_map__bindgen_ty_1 { vaddr: self.addr },
+            })
+        };
+    }
+}
+
+// SAFETY: `addr` points to a valid memory address for as long as `owner` exists, meaning that so
+// long as `owner` is `Send` so is `VMap`.
+unsafe impl<D, R, C, const SIZE: usize> Send for VMap<D, R, C, SIZE>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target = Object<D, C>> + Send,
+{
+}
+
+// SAFETY: `addr` points to a valid memory address for as long as `owner` exists, meaning that so
+// long as `owner` is `Sync` so is `VMap`.
+unsafe impl<D, R, C, const SIZE: usize> Sync for VMap<D, R, C, SIZE>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target = Object<D, C>> + Sync,
+{
+}
+
+impl<D, R, C, const SIZE: usize> Io for VMap<D, R, C, SIZE>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target = Object<D, C>>,
+{
+    #[inline]
+    fn addr(&self) -> usize {
+        self.addr as usize
+    }
+
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.owner.size()
+    }
+}
+
+impl<D, R, C, const SIZE: usize> IoKnownSize for VMap<D, R, C, SIZE>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target = Object<D, C>>,
+{
+    const MIN_SIZE: usize = SIZE;
+}
+
+macro_rules! impl_vmap_io_capable {
+    ($ty:ty) => {
+        impl<D, R, C, const SIZE: usize> IoCapable<$ty> for VMap<D, R, C, SIZE>
+        where
+            D: DriverObject,
+            C: DeviceContext,
+            R: Deref<Target = Object<D, C>>,
+        {
+            #[inline]
+            unsafe fn io_read(&self, address: usize) -> $ty {
+                let ptr = address as *mut $ty;
+
+                // SAFETY: The safety contract of `io_read` guarantees that address is a valid
+                // address within the bounds of `Self` of at least the size of $ty, and is properly
+                // aligned.
+                unsafe { ptr::read_volatile(ptr) }
+            }
+
+            #[inline]
+            unsafe fn io_write(&self, value: $ty, address: usize) {
+                let ptr = address as *mut $ty;
+
+                // SAFETY: The safety contract of `io_write` guarantees that address is a valid
+                // address within the bounds of `Self` of at least the size of $ty, and is properly
+                // aligned.
+                unsafe { ptr::write_volatile(ptr, value) }
+            }
+        }
+    };
+}
+
+impl_vmap_io_capable!(u8);
+impl_vmap_io_capable!(u16);
+impl_vmap_io_capable!(u32);
+#[cfg(CONFIG_64BIT)]
+impl_vmap_io_capable!(u64);
+
+#[kunit_tests(rust_drm_gem_shmem)]
+mod tests {
+    use super::*;
+    use crate::{
+        drm::{
+            self,
+            UnregisteredDevice, //
+        },
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
+        fn new<C: DeviceContext>(
+            _dev: &drm::Device<KunitDriver, C>,
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
+        type Object<Ctx: DeviceContext> = Object<KunitObject, Ctx>;
+
+        const INFO: drm::DriverInfo = INFO;
+        const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor] = &[];
+    }
+
+    fn create_drm_dev() -> Result<(faux::Registration, UnregisteredDevice<KunitDriver>)> {
+        // Create a faux DRM device so we can test gem object creation.
+        let data = try_pin_init!(KunitData {});
+        let dev = faux::Registration::new(c"Kunit", None)?;
+        let drm = UnregisteredDevice::new(dev.as_ref(), data)?;
+
+        Ok((dev, drm))
+    }
+
+    #[test]
+    fn compile_time_vmap_sizes() -> Result {
+        let (_dev, drm) = create_drm_dev()?;
+
+        let obj = Object::<KunitObject, _>::new(&drm, PAGE_SIZE, ObjectConfig::default(), ())?;
+
+        // Try creating a normal vmap
+        obj.vmap::<PAGE_SIZE>()?;
+
+        // Try creating a vmap that's smaller then the size we specified
+        let vmap = obj.vmap::<{ PAGE_SIZE - 100 }>()?;
+
+        // Verify the owner matches
+        assert!(ptr::eq(vmap.owner(), obj.deref()));
+
+        // Verify the max size matches the actual object size
+        assert_eq!(vmap.maxsize(), PAGE_SIZE);
+
+        // Make sure creating a vmap that's too large fails
+        assert!(obj.vmap::<{ PAGE_SIZE + 200 }>().is_err());
+
+        Ok(())
+    }
+
+    #[test]
+    fn vmap_io() -> Result {
+        let (_dev, drm) = create_drm_dev()?;
+
+        let obj = Object::<KunitObject, _>::new(&drm, PAGE_SIZE, ObjectConfig::default(), ())?;
+
+        let vmap = obj.vmap::<PAGE_SIZE>()?;
+
+        vmap.write8(0xDE, 0x0);
+        assert_eq!(vmap.read8(0x0), 0xDE);
+        vmap.write32(0xFEDCBA98, 0x20);
+
+        assert_eq!(vmap.read32(0x20), 0xFEDCBA98);
+
+        // Ensure the ordering in memory is correct
+        let expected = 0xFEDCBA98_u32.to_ne_bytes().into_iter();
+        for (offset, expected) in (0x20..=0x23).zip(expected) {
+            assert_eq!(vmap.read8(offset), expected);
+        }
+
+        Ok(())
+    }
+}
-- 
2.54.0

