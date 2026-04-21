Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB54EF94CB6
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C7910EDE3;
	Tue, 21 Apr 2026 23:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="a9ixl5NW";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4811F10EDC7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776814991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4n3L9YXNYUs42p4pG9fQtijWpd8tlkezrsRa1fweUZ8=;
 b=a9ixl5NW0NE8xL3EIfBDZNWxYvYRNaiPKGak/XCNmaH3DTm3zX+C6TwniQ7wuPnhLtdZKl
 ohaha5FmmYygqUE2uNXF77jaxZADCmAAHVNjp5Ml4smihjMwOYYtgoBQYlL32ZTrx6QvPT
 30hnYas+7siKXMhXHLdwfm3JW0ZlxJo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-eG0GhK4uPa60IcKanzbnAg-1; Tue,
 21 Apr 2026 19:43:07 -0400
X-MC-Unique: eG0GhK4uPa60IcKanzbnAg-1
X-Mimecast-MFC-AGG-ID: eG0GhK4uPa60IcKanzbnAg_1776814984
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E01E61800358; Tue, 21 Apr 2026 23:43:03 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F8F21800352; Tue, 21 Apr 2026 23:43:00 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: Matthew Maurer <mmaurer@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, christian.koenig@amd.com,
 Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, linux-media@vger.kernel.org,
 Shankari Anand <shankari.ak0208@gmail.com>,
 David Airlie <airlied@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Subject: [PATCH v11 5/5] rust: drm: gem: Add vmap functions to shmem bindings
Date: Tue, 21 Apr 2026 19:40:41 -0400
Message-ID: <20260421234234.638503-6-lyude@redhat.com>
In-Reply-To: <20260421234234.638503-1-lyude@redhat.com>
References: <20260421234234.638503-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: vOOsL6bI04S9cyYWPWJEFnVAVcPP8snenGooC344G8g_1776814984
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

Similar to how we handle SGTables, we make sure there's two different types
of mappings: owned mappings (kernel::drm::gem::shmem::VMap) and borrowed
mappings (kernel::drm::gem::shmem::VMapRef).

Signed-off-by: Lyude Paul <lyude@redhat.com>

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

 rust/kernel/drm/gem/shmem.rs | 364 ++++++++++++++++++++++++++++++++++-
 1 file changed, 360 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index ca9d66900f8ac..d9a7ba950bd6a 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -26,6 +26,11 @@
         from_err_ptr,
         to_result, //
     },
+    io::{
+        Io,
+        IoCapable,
+        IoKnownSize, //
+    },
     prelude::*,
     scatterlist,
     types::{
@@ -35,6 +40,11 @@
 };
 use core::{
     cell::UnsafeCell,
+    ffi::c_void,
+    mem::{
+        self,
+        MaybeUninit, //
+    },
     ops::{
         Deref,
         DerefMut, //
@@ -45,6 +55,7 @@
     },
 };
 use gem::{
+    BaseObject,
     BaseObjectPrivate,
     DriverObject,
     IntoGEMObject, //
@@ -74,14 +85,15 @@ pub struct ObjectConfig<'a, T: DriverObject> {
 #[repr(C)]
 #[pin_data]
 pub struct Object<T: DriverObject> {
+    /// Devres object for unmapping any SGTable on driver-unbind.
+    ///
+    /// This is protected by the object's dma_resv lock. Additionally, this needs to be at the top
+    /// of the structure to ensure that it is dropped before `obj`.
+    sgt_res: UnsafeCell<Option<Devres<SGTableMap<T>>>>,
     #[pin]
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
     parent_resv_obj: Option<ARef<Object<T>>>,
-    /// Devres object for unmapping any SGTable on driver-unbind.
-    ///
-    /// This is protected by the object's dma_resv lock.
-    sgt_res: UnsafeCell<Option<Devres<SGTableMap<T>>>>,
     #[pin]
     inner: T,
 }
@@ -288,6 +300,84 @@ pub fn owned_sg_table(&self, dev: &device::Device<Bound>) -> Result<SGTable<T>>
         // `Some(Devres<SGTableMap<T>>)`.
         Ok(SGTable(self.into()))
     }
+
+    /// Attempt to create a vmap from the gem object, and confirm the size of said vmap.
+    fn raw_vmap(&self, min_size: usize) -> Result<*mut c_void> {
+        if self.size() < min_size {
+            return Err(ENOSPC);
+        }
+
+        let mut map: MaybeUninit<bindings::iosys_map> = MaybeUninit::uninit();
+
+        // SAFETY: drm_gem_shmem_vmap can be called with the DMA reservation lock held
+        to_result(unsafe {
+            // TODO: see top of file
+            bindings::dma_resv_lock(self.raw_dma_resv(), ptr::null_mut());
+            let ret = bindings::drm_gem_shmem_vmap_locked(self.as_raw_shmem(), map.as_mut_ptr());
+            bindings::dma_resv_unlock(self.raw_dma_resv());
+            ret
+        })?;
+
+        // SAFETY: The call to drm_gem_shmem_vmap_locked succeeded above, so we are guaranteed that
+        // map is properly initialized.
+        let map = unsafe { map.assume_init() };
+
+        // XXX: We don't currently support iomem allocations
+        if map.is_iomem {
+            // SAFETY:
+            // - The vmap operation above succeeded, guaranteeing that `map` points to a valid
+            //   memory mapping.
+            // - We checked that this is an iomem allocation, making it safe to read vaddr_iomem
+            unsafe { self.raw_vunmap(map) };
+
+            Err(ENOTSUPP)
+        } else {
+            // SAFETY: We checked that this is not an iomem allocation, making it safe to read vaddr
+            Ok(unsafe { map.__bindgen_anon_1.vaddr })
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
+        let resv = self.raw_dma_resv();
+
+        // SAFETY:
+        // - This function is safe to call with the DMA reservation lock held
+        // - Our `ARef` is proof that the underlying gem object here is initialized and thus safe to
+        //   dereference.
+        unsafe {
+            // TODO: see top of file
+            bindings::dma_resv_lock(resv, ptr::null_mut());
+            bindings::drm_gem_shmem_vunmap_locked(self.as_raw_shmem(), &mut map);
+            bindings::dma_resv_unlock(resv);
+        }
+    }
+
+    /// Creates and returns a virtual kernel memory mapping for this object.
+    #[inline]
+    pub fn vmap<const SIZE: usize>(&self) -> Result<VMapRef<'_, T, SIZE>> {
+        Ok(VMap {
+            // INVARIANT: `raw_vmap()` checks that the gem object is at least as large as `SIZE`.
+            addr: self.raw_vmap(SIZE)?,
+            owner: self,
+        })
+    }
+
+    /// Creates and returns an owned reference to a virtual kernel memory mapping for this object.
+    #[inline]
+    pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, SIZE>> {
+        Ok(VMap {
+            // INVARIANT: `raw_vmap()` checks that the gem object is at least as large as `SIZE`.
+            addr: self.raw_vmap(SIZE)?,
+            owner: self.into(),
+        })
+    }
 }
 
 impl<T: DriverObject> Deref for Object<T> {
@@ -386,6 +476,155 @@ unsafe impl<T: DriverObject> Send for SGTableMap<T> {}
 // it points to is guaranteed to be thread-safe.
 unsafe impl<T: DriverObject> Sync for SGTableMap<T> {}
 
+macro_rules! impl_vmap_io_capable {
+    ($impl:ident, $ty:ty) => {
+        impl<D, R, const SIZE: usize> IoCapable<$ty> for $impl<D, R, SIZE>
+        where
+            D: DriverObject,
+            R: Deref<Target = Object<D>>,
+        {
+            #[inline(always)]
+            unsafe fn io_read(&self, address: usize) -> $ty {
+                let ptr = address as *mut $ty;
+
+                // SAFETY: The safety contract of `io_read` guarantees that address is a valid
+                // address within the bounds of `Self` of at least the size of $ty, and is properly
+                // aligned.
+                unsafe { ptr::read(ptr) }
+            }
+
+            #[inline(always)]
+            unsafe fn io_write(&self, value: $ty, address: usize) {
+                let ptr = address as *mut $ty;
+
+                // SAFETY: The safety contract of `io_write` guarantees that address is a valid
+                // address within the bounds of `Self` of at least the size of $ty, and is properly
+                // aligned.
+                unsafe { ptr::write(ptr, value) }
+            }
+        }
+    };
+}
+
+/// A reference to a virtual mapping for an shmem-based GEM object in kernel address space.
+///
+/// # Invariants
+///
+/// - The size of `owner` is >= SIZE.
+/// - The memory pointed to by addr remains valid at least until this object is dropped.
+pub struct VMap<D, R, const SIZE: usize = 0>
+where
+    D: DriverObject,
+    R: Deref<Target = Object<D>>,
+{
+    addr: *mut c_void,
+    owner: R,
+}
+
+/// An alias type for a reference to a shmem-based GEM object's VMap.
+pub type VMapRef<'a, D, const SIZE: usize = 0> = VMap<D, &'a Object<D>, SIZE>;
+
+/// An alias type for an owned reference to a shmem-based GEM object's VMap.
+pub type VMapOwned<D, const SIZE: usize = 0> = VMap<D, ARef<Object<D>>, SIZE>;
+
+impl<D, R, const SIZE: usize> VMap<D, R, SIZE>
+where
+    D: DriverObject,
+    R: Deref<Target = Object<D>>,
+{
+    /// Borrows a reference to the object that owns this virtual mapping.
+    #[inline(always)]
+    pub fn owner(&self) -> &Object<D> {
+        &self.owner
+    }
+}
+
+impl<D, R, const SIZE: usize> Drop for VMap<D, R, SIZE>
+where
+    D: DriverObject,
+    R: Deref<Target = Object<D>>,
+{
+    #[inline(always)]
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
+impl<D, R, const SIZE: usize> Io for VMap<D, R, SIZE>
+where
+    D: DriverObject,
+    R: Deref<Target = Object<D>>,
+{
+    #[inline(always)]
+    fn addr(&self) -> usize {
+        self.addr as usize
+    }
+
+    #[inline(always)]
+    fn maxsize(&self) -> usize {
+        self.owner.size()
+    }
+}
+
+impl<D, R, const SIZE: usize> IoKnownSize for VMap<D, R, SIZE>
+where
+    D: DriverObject,
+    R: Deref<Target = Object<D>>,
+{
+    const MIN_SIZE: usize = SIZE;
+}
+
+impl_vmap_io_capable!(VMap, u8);
+impl_vmap_io_capable!(VMap, u16);
+impl_vmap_io_capable!(VMap, u32);
+#[cfg(CONFIG_64BIT)]
+impl_vmap_io_capable!(VMap, u64);
+
+impl<D: DriverObject, const SIZE: usize> Clone for VMapOwned<D, SIZE> {
+    #[inline]
+    fn clone(&self) -> Self {
+        // SAFETY: We have a successful vmap already, so this can't fail.
+        unsafe { self.owner.owned_vmap().unwrap_unchecked() }
+    }
+}
+
+impl<'a, D: DriverObject, const SIZE: usize> Clone for VMapRef<'a, D, SIZE> {
+    #[inline]
+    fn clone(&self) -> Self {
+        // SAFETY: We have a successful vmap already, so this can't fail.
+        unsafe { self.owner.vmap().unwrap_unchecked() }
+    }
+}
+
+impl<'a, D: DriverObject, const SIZE: usize> From<VMapRef<'a, D, SIZE>> for VMapOwned<D, SIZE> {
+    #[inline]
+    fn from(value: VMapRef<'a, D, SIZE>) -> Self {
+        let this = Self {
+            addr: value.addr,
+            owner: value.owner.into(),
+        };
+
+        mem::forget(value);
+        this
+    }
+}
+
+// SAFETY: VMap is thread-safe, and the fact that this VMap has an owned reference to the object
+// means this object will remain valid until dropped.
+unsafe impl<D: DriverObject, const SIZE: usize> Send for VMapOwned<D, SIZE> {}
+// SAFETY: VMap is thread-safe, and the fact that this VMap has an owned reference to the object
+// means this object will remain valid until dropped.
+unsafe impl<D: DriverObject, const SIZE: usize> Sync for VMapOwned<D, SIZE> {}
+
 /// An owned reference to a scatter-gather table of DMA address spans for a GEM shmem object.
 ///
 /// This object holds an owned reference to the underlying GEM shmem object, ensuring that the
@@ -413,3 +652,120 @@ fn deref(&self) -> &Self::Target {
         unsafe { (*self.0.sgt_res.get()).as_ref().unwrap_unchecked() }
     }
 }
+
+#[kunit_tests(rust_drm_gem_shmem)]
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
+    fn create_drm_dev() -> Result<(faux::Registration, ARef<drm::Device<KunitDriver>>)> {
+        // Create a faux DRM device so we can test gem object creation.
+        let data = try_pin_init!(KunitData {});
+        let dev = faux::Registration::new(c"Kunit", None)?;
+        let drm = drm::Device::<KunitDriver>::new(dev.as_ref(), data)?;
+
+        Ok((dev, drm))
+    }
+
+    #[test]
+    fn compile_time_vmap_sizes() -> Result {
+        let (_dev, drm) = create_drm_dev()?;
+
+        // Create a gem object to test with
+        let cfg_ = ObjectConfig::<KunitObject> {
+            map_wc: false,
+            parent_resv_obj: None,
+        };
+        let obj = Object::<KunitObject>::new(&drm, PAGE_SIZE, cfg_, ())?;
+
+        // Try creating a normal vmap
+        obj.vmap::<PAGE_SIZE>()?;
+
+        // Try creating a vmap that's smaller then the size we specified
+        obj.vmap::<{ PAGE_SIZE - 100 }>()?;
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
+        // Create a gem object to test with
+        let cfg_ = ObjectConfig::<KunitObject> {
+            map_wc: false,
+            parent_resv_obj: None,
+        };
+        let obj = Object::<KunitObject>::new(&drm, PAGE_SIZE, cfg_, ())?;
+
+        let vmap = obj.vmap::<PAGE_SIZE>()?;
+
+        vmap.write8(0xDE, 0x0);
+        assert_eq!(vmap.read8(0x0), 0xDE);
+        vmap.write32(0xFFFFFFFF, 0x20);
+
+        assert_eq!(vmap.read32(0x20), 0xFFFFFFFF);
+
+        assert_eq!(vmap.read8(0x20), 0xFF);
+        assert_eq!(vmap.read8(0x21), 0xFF);
+        assert_eq!(vmap.read8(0x22), 0xFF);
+        assert_eq!(vmap.read8(0x23), 0xFF);
+
+        Ok(())
+    }
+}
-- 
2.53.0

