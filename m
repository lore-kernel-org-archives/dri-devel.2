Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A655FCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5B510E500;
	Wed, 10 Jun 2026 16:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mUyHuKGs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E67BF10EAB9
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:46:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC6A0601DC;
 Wed, 10 Jun 2026 16:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5AB1F00893;
 Wed, 10 Jun 2026 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781109982;
 bh=GMSMsukFLFPaqNkaKOiI/413+G7+n/I8tOFC9c5WHRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mUyHuKGsqGipTtxmIeU/65j0eFZNBLaspsXmDekJpEZymSz8VofXC2KqsRMCx+tt1
 cjmSVvckF20WSFqt1UzH4CaLN/Z9645YyVrwP90Ktwj8dNK1JnecDZvu6bxWjhYSpE
 HAQvLqXArdR1RoGsWBX4mdHQMAs7QfxgTotltSh4hgmiE9Es6G8+oqnu2D+YbE7T9g
 tshB1GuXBsDW5YdGj6EffGHiONFPZmANiuWRyMNJpKNYWN2oCXn3dBHX2YNJJIerb2
 nJ2CauT+Zguw1rWVu/mwNKjYqqH0OLAVuGLK5LLfEJTFPal0TJCbtECT3vdqWsLIRE
 jpaWk5xXO3cdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 4/4] rust: drm: gem: Introduce
 shmem::Object::sg_table()
To: "Lyude Paul" <lyude@redhat.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260610162433.923550-5-lyude@redhat.com>
References: <20260610162433.923550-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:46:21 +0000
Message-Id: <20260610164622.6A5AB1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A concurrent device unbind and GEM object destruction results =
in a use-after-free and double-free when SGTableMap::drop accesses the free=
d GEM object.
- [High] SGTableMap::drop unconditionally calls __drm_gem_shmem_free_sgt_lo=
cked(), causing NULL pointer dereferences for purged objects, memory corrup=
tion for PRIME-imported objects, and leaked page references.
--

commit 8c8b7df9b9589f955da172bd30324598c3ed5764
Author: Lyude Paul <lyude@redhat.com>

rust: drm: gem: Introduce shmem::Object::sg_table()
   =20
In order to do this, we need to be careful to ensure that any interface we
expose for scatterlists ensures that any mappings created from one are
destroyed on driver-unbind. To do this, we introduce a Devres resource into
shmem::Object that we use in order to ensure that we release any SGTable
mappings on driver-unbind.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index d4afc06d1be50..f44665cc24119 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> @@ -488,6 +560,64 @@ unsafe fn io_write(&self, value: $ty, address: usize=
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

[Severity: Critical]
Can a concurrent device unbind and GEM object destruction result in a
use-after-free here?

When a GEM object's final reference is dropped, free_callback() is executed
and it drops the SetOnce wrapper:

    unsafe { ManuallyDrop::drop(&mut (*this).sgt_res) };

This invokes Devres::drop(), which calls revoke_nosync().

If the device is concurrently unbound, the devres unbind thread will call
revoke() on the Devres object, setting its availability flag to false and
waiting via synchronize_rcu() before dropping SGTableMap.

Because revoke_nosync() on the free_callback thread sees the flag is already
false, it returns immediately without synchronizing. free_callback() then
proceeds to free the GEM object memory via drm_gem_shmem_release().

Once synchronize_rcu() finishes in the unbind thread, this SGTableMap::drop
runs and dereferences the now-freed self.obj pointer, resulting in a
use-after-free.

> +
> +        // SAFETY: We acquired the lock needed for calling this function=
 above
> +        unsafe { bindings::__drm_gem_shmem_free_sgt_locked(obj.as_raw_sh=
mem()) };

[Severity: High]
Does unconditionally calling __drm_gem_shmem_free_sgt_locked() handle purged
or PRIME-imported objects correctly?

If a Rust Object is PRIME-imported, shmem->sgt points to an SGT owned by the
exporting driver, and calling this could free and corrupt the exporter's
memory.

Additionally, if the object was purged by the shrinker, shmem->sgt is freed
and set to NULL. Calling __drm_gem_shmem_free_sgt_locked() does not check
for NULL, which could lead to a NULL pointer dereference in
dma_unmap_sgtable().

Finally, for native objects, drm_gem_shmem_get_pages_sgt() pins the pages
and increments pages_use_count. By only freeing the SGT and skipping the
required drm_gem_shmem_put_pages_locked() call, does this leak page
references until the object's file descriptor is closed?

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610162433.9235=
50-1-lyude@redhat.com?part=3D4
