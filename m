Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B950CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7385010F8C3;
	Mon,  8 Jun 2026 18:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iCBNXz4O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2287910F8C3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:48:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0946744370;
 Mon,  8 Jun 2026 18:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E7B1F00893;
 Mon,  8 Jun 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780944509;
 bh=nkmEC1GidAqn0OHJD71nQ9XoqHMzLK1itjJCfvQK9oI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iCBNXz4OnJRI68mRmJxRiR/ex09Rg+ohMKJfAGAGN/OAVJcaOcVVzsDyAE97kp6gn
 JTYwejUjQSLwf1hqV0HvE1yJQnneFIL3wEs2I/c+qGdb3ViDZRhbN8k+x5bbaxLOpd
 5PaOntJI47KzkON1diV4+aNoEtip59W6/MWRG1E8FQw3pfFpkSZbNJDPdwCUsSKjh9
 8Ka1xvkpz/n+zx9Ki2nQDEWJlLGsZ1+FhQzogJiedc8CynecnZSuIv9j+e75ZZZ/vE
 OBw3cTBcqkTtzKkn0kt+JfcDLcqhJ1Sa03BBWqAD33KP6fqlrr6zDzKMU06EZrXNiS
 4zERHzBkjQf5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 4/4] rust: drm: gem: Introduce
 shmem::Object::sg_table()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260608183057.2001376-5-lyude@redhat.com>
References: <20260608183057.2001376-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:48:29 +0000
Message-Id: <20260608184829.B7E7B1F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] `SGTableMap::drop()` unconditionally frees the scatter/gather =
table, causing a double-free and memory corruption for imported GEM objects=
 whose SGT is owned by the DMA-BUF exporter.
- [Critical] Caching `Devres` in a `SetOnce` field on a reference-counted G=
EM object causes a Use-After-Free if the driver is unbound and rebound.
- [Critical] Concurrent execution of device unbind (`devres_node_release`) =
and GEM object freeing (`free_callback`) causes a fatal Use-After-Free due =
to missing synchronization.
- [High] SGTableMap fails to pin the GEM object, allowing the shrinker to p=
urge the object and free the sg_table out from under the Rust driver, leadi=
ng to a UAF and NULL pointer dereference.
- [High] `SGTableMap::drop` destroys the SGT but fails to release the backi=
ng pages reference, permanently leaking the memory and triggering a kernel =
warning on rebinds.
--

commit ca164753ace4f901b6f5bd1ab132aa0d035c5a2b
Author: Lyude Paul <lyude@redhat.com>
rust: drm: gem: Introduce shmem::Object::sg_table()

This patch introduces sg_table() to shmem::Object, utilizing Devres to ensu=
re
SGTable mappings are released on driver-unbind.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index e0bd0695ba1f8..ae97498500afa 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> @@ -183,18 +207,26 @@ extern "C" fn free_callback(obj: *mut bindings::drm=
_gem_object) {
>          // - DRM always passes a valid gem object here
>          // - We used drm_gem_shmem_create() in our create_gem_object cal=
lback, so we know that
>          //   `obj` is contained within a drm_gem_shmem_object
> -        let this =3D unsafe { container_of!(obj, bindings::drm_gem_shmem=
_object, base) };
> -
> -        // SAFETY:
> -        // - We're in free_callback - so this function is safe to call.
> -        // - We won't be using the gem resources on `this` after this ca=
ll.
> -        unsafe { bindings::drm_gem_shmem_release(this) };
> +        let base =3D unsafe { container_of!(obj, bindings::drm_gem_shmem=
_object, base) };
> =20
>          // SAFETY:
>          // - We verified above that `obj` is valid, which makes `this` v=
alid
>          // - This function is set in AllocOps, so we know that `this` is=
 contained within a
>          //   `Object<T, C>`
> -        let this =3D unsafe { container_of!(Opaque::cast_from(this), Sel=
f, obj) }.cast_mut();
> +        let this =3D unsafe { container_of!(Opaque::cast_from(base), Sel=
f, obj) }.cast_mut();
> +
> +        // We need to drop `sgt_res` first, since doing so requires that=
 the GEM object is still
> +        // alive.
> +        // SAFETY:
> +        // - We verified above that `this` is valid.
> +        // - We are in free_callback, guaranteeing we have exclusive acc=
ess to `this` and that
> +        //   `sgt_res` will not be used after dropping it here.
> +        unsafe { ManuallyDrop::drop(&mut (*this).sgt_res) };

[Severity: Critical]
Could this cause a race condition with a concurrent device unbind? If the
drop races with devres_node_release, Devres::drop's internal atomic revoke
might return false, but free_callback proceeds to free the Rust Object memo=
ry
without blocking.

When the concurrent unbind thread continues and invokes SGTableMap::drop, it
dereferences self.obj to acquire the dma_resv lock, which would access
already freed memory.

> +
> +        // SAFETY:
> +        // - We're in free_callback - so this function is safe to call.
> +        // - We won't be using the gem resources on `this` after this ca=
ll.
> +        unsafe { bindings::drm_gem_shmem_release(base) };
> =20
>          // SAFETY: We're recovering the Kbox<> we created in gem_create_=
object()
>          let _ =3D unsafe { KBox::from_raw(this) };

[ ... ]

> @@ -270,6 +302,46 @@ pub fn vmap<const SIZE: usize>(&self) -> Result<VMap=
Ref<'_, T, C, SIZE>> {
>      pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, C=
, SIZE>> {
>          self.make_vmap()
>      }
> +
> +    /// Creates (if necessary) and returns an immutable reference to a s=
catter-gather table of DMA
> +    /// pages for this object.
> +    ///
> +    /// This will pin the object in memory. It is expected that `dev` sh=
ould be a pointer to the
> +    /// same [`device::Device`] which `self` belongs to, otherwise this =
function will return
> +    /// `Err(EINVAL)`.
> +    pub fn sg_table<'a>(
> +        &'a self,
> +        dev: &'a device::Device<Bound>,
> +    ) -> Result<&'a scatterlist::SGTable> {
> +        if dev.as_raw() !=3D self.dev().as_ref().as_raw() {
> +            return Err(EINVAL);
> +        }
> +
> +        let sgt_res =3D 'out: {
> +            // Fast path: sgt_res is already initialized
> +            if let Some(sgt_res) =3D self.sgt_res.as_ref() {
> +                break 'out sgt_res;
> +            }
> +
> +            // Slow path: Grab the lock and see if we need to initialize=
 sgt_res.
> +            let _guard =3D self.sgt_lock.lock();
> +
> +            // If someone initialized it while we were waiting, we can e=
xit early.
> +            if let Some(sgt_res) =3D self.sgt_res.as_ref() {
> +                break 'out sgt_res;
> +            }
> +
> +            // If not, finish initializing and return. `populate()` cann=
ot return false, as
> +            // `sgt_res` must be unpopulated, and we must hold `sgt_lock=
` to reach this point.
> +            self.sgt_res
> +                .populate(Devres::new(dev, SGTableMap::new(self))?);
> +
> +            // SAFETY: We just populated sgt_res above.
> +            unsafe { self.sgt_res.as_ref().unwrap_unchecked() }
> +        };
> +
> +        Ok(sgt_res.access(dev)?)
> +    }

[Severity: Critical]
Does caching Devres in a SetOnce field on a reference-counted GEM object
cause a use-after-free on driver rebind?=20

On device unbind, the Devres is revoked and its internal SGTableMap is drop=
ped,
clearing the SGT. Since the GEM object outlives the binding and SetOnce is
never cleared, a subsequent rebind with the same device pointer would hit
the fast path here. The call to access() bypasses revocation checks, return=
ing
a reference to the dropped SGTableMap and accessing a NULL shmem->sgt.

>  }
> =20
>  impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {

[ ... ]

> @@ -468,6 +540,64 @@ unsafe fn io_write(&self, value: $ty, address: usize=
) {
>  #[cfg(CONFIG_64BIT)]
>  impl_vmap_io_capable!(u64);
> =20
> +/// A reference to a GEM object that is known to have a mapped [`SGTable=
`].
> +///
> +/// This is used by the Rust bindings with [`Devres`] in order to ensure=
 that mappings for SGTables
> +/// on GEM shmem objects are revoked on driver-unbind.
> +///
> +/// # Invariants
> +///
> +/// - `self.obj` always points to a valid GEM object.
> +/// - This object is proof that `self.obj.owner.sgt_res` has an initiali=
zed and valid pointer to an
> +///   [`SGTable`].
> +///
> +/// [`SGTable`]: scatterlist::SGTable
> +pub struct SGTableMap<T: DriverObject, C: DeviceContext> {
> +    obj: NonNull<Object<T, C>>,
> +}
> +
> +impl<T: DriverObject, C: DeviceContext> Deref for SGTableMap<T, C> {
> +    type Target =3D scatterlist::SGTable;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY:
> +        // - The NonNull is guaranteed to be valid via our type invarian=
ts.
> +        // - The sgt field is guaranteed to be initialized and valid via=
 our type invariants.
> +        unsafe { scatterlist::SGTable::from_raw((*self.obj.as_ref().as_r=
aw_shmem()).sgt) }
> +    }
> +}
> +
> +impl<T: DriverObject, C: DeviceContext> Drop for SGTableMap<T, C> {
> +    fn drop(&mut self) {
> +        // SAFETY: `obj` is always valid via our type invariants
> +        let obj =3D unsafe { self.obj.as_ref() };
> +        let _lock =3D DmaResvGuard::new(obj);
> +
> +        // SAFETY: We acquired the lock needed for calling this function=
 above
> +        unsafe { bindings::__drm_gem_shmem_free_sgt_locked(obj.as_raw_sh=
mem()) };
> +    }
> +}

[Severity: Critical]
Is it safe to unconditionally free the SGT here? For imported DMA-BUF
objects, the SGT is owned by the exporter and must be freed via
dma_buf_unmap_attachment. Calling __drm_gem_shmem_free_sgt_locked on an
imported object frees the exporter's table, leading to memory corruption
and a double-free when the DMA-BUF is eventually destroyed.

[Severity: High]
Does this leak the backing pages reference? SGTableMap::new calls
drm_gem_shmem_get_pages_sgt, which increments pages_use_count. When this
drop destroys the SGT, it omits the paired call to
drm_gem_shmem_put_pages_locked. If a driver unbinds and rebinds, this
will leak the extra reference and trigger a kernel warning.

> +
> +impl<T: DriverObject, C: DeviceContext> SGTableMap<T, C> {
> +    fn new(obj: &Object<T, C>) -> impl Init<Self, Error> {
> +        // INVARIANT:
> +        // - We call drm_gem_shmem_get_pages_sgt below and check whether=
 or not it succeeds,
> +        //   fulfilling the invariant of SGTableMap that the object's `s=
gt` field is initialized.
> +        // SAFETY:
> +        // - `obj` is fully initialized, making this function safe to ca=
ll.
> +        from_err_ptr(unsafe { bindings::drm_gem_shmem_get_pages_sgt(obj.=
as_raw_shmem()) })?;
> +
> +        Ok(Self { obj: obj.into() })
> +    }
> +}

[Severity: High]
Should this pin the GEM object? The documentation for sg_table mentions it
pins the object, but drm_gem_shmem_get_pages_sgt only increments
pages_use_count, not pages_pin_count.=20

If userspace calls madvise(DONTNEED), the shrinker could purge the object,
freeing shmem->sgt. When SGTableMap is dropped, passing the object to
__drm_gem_shmem_free_sgt_locked will dereference a NULL pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608183057.2001=
376-1-lyude@redhat.com?part=3D4
