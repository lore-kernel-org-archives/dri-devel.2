Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0357606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xy2pPQkB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE58E10E2D1;
	Mon,  9 Nov 2026 01:10:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACFF10E2D1
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 01:10:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D41E41924;
 Mon,  9 Nov 2026 01:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108DD1F008A6;
 Mon,  9 Nov 2026 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794186626;
 bh=z3YmTo4g4SXcAn+pNEDPkvubdSm08ICPoeux+fCDLbI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xy2pPQkBuzp2qAZ5nSGPoXN17GUXh92+nxYh8SiynaGd7D2yfnlbNpJcoYPNrHg0b
 lofxO4MB8zdNwI7PGDUn1aUWK7vRnxKCrPMn6Lbc+LokiktQTUy4aGpfBm7XPncOI1
 9IDMTfhvKOe//k/XivTcknpExYz+MpN9DudIjcGW6EGaYb40qR+MNWaDZleJEwe4cg
 RzcbHZZ3uW5SNEZW+ri50N2kjSNvE6l6vBUaB1aggQ8Ntp8uAxHDZwmZSibwTwO95w
 2j08Tv7Rmh7/BGYo941yZ3I0qwvU8ywjP60SAX2FhkieIuW8aO040i31Xi31XWksMn
 EdKjrppaFFqhQ==
Message-ID: <sashiko-outbox-204284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] drm/tyr: support write-combine BO mappings
To: "Ke Sun" <sunke@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261109-tyr-ioctls-v6-9-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
 <20261109-tyr-ioctls-v6-9-b2896bf2b3c9@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:10:25 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Critical] drm/tyr: invalid downcast in lookup_handle() for PRIME or
  dumb GEM BOs
- [High] drm/tyr: cached BO mappings on coherent devices without GPU
  coherency
- [Medium] drm/tyr: unconditional sg_table() call in new_object() when
  map_wc is false
--

commit 6624593ccd32e8779801a0fe4fb33fa8b31a7440
Author: Sami Tolvanen <samitolvanen@google.com>

drm/tyr: support write-combine BO mappings

This commit caches device DMA coherency at probe time and threads it to
GEM shmem object creation to configure write-combine vs write-back CPU
mappings, while calling sg_table() at BO creation to flush cached zero-init
pages.

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index ba03cc4c52539..6869ab345d8fd 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
[ ... ]
> @@ -151,6 +158,8 @@ fn probe<'bound>(
>              // other threads of execution.
>              unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_=
bits)?)? };
> =20
> +            let coherent =3D pdev.as_ref().dma_attr() =3D=3D DmaAttr::CO=
HERENT;
> +
>              let unreg_dev =3D drm::UnregisteredDevice::<TyrDrmDriver>::n=
ew(pdev, Ok(()))?;
> =20
>              let mmu =3D Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &=
gpu_info)?;
> @@ -161,6 +170,7 @@ fn probe<'bound>(
>                  &unreg_dev,
>                  mmu.as_arc_borrow(),
>                  &gpu_info,
> +                coherent,
>              )?;

[Severity: High]
Does setting coherent from dma_attr() break MCU firmware boot and BO
mappings on platforms whose Device Tree or ACPI tables mark the GPU
DMA-coherent?

When coherent is true, gem::should_map_wc() returns false, so firmware
KernelBo sections and user BOs are mapped write-back cached (PAGE_KERNEL) on
the CPU, and dma_map_sgtable() performs no cache maintenance because the
device is marked coherent.  However, Tyr does not yet enable GPU or MMU
coherency: GpuInfo::new() hardcodes selected_coherency to
DRM_PANTHOR_GPU_COHERENCY_NONE, gpu::l2_power_on() never programs
COHERENCY_ENABLE, VmAsData::new() sets coherent_walk to false, and
MEMATTR::attribute_from_mair() always encodes Coherency::MidgardInnerDomain:

drivers/gpu/drm/tyr/regs.rs:MEMATTR::attribute_from_mair() {
    ...
            // TODO: Add a `coherent` parameter like panthor's mair_to_mema=
ttr().
            // For now, assume a non-coherent system and always encode writ=
e-back
            // memory with MidgardInnerDomain coherency.
            Self::try_new_memattr(
                 UseRecipe::AttributeMode,
                 Coherency::MidgardInnerDomain,
    ...
}

As a result, CPU writes to the cached vmap in Firmware::init_section_mem()
can remain in dirty CPU cache lines while the non-coherent MCU and GPU read
stale DRAM.

> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 60f6363995a5a..55e2d67b96d98 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
[ ... ]
> @@ -38,6 +43,14 @@ pub(crate) struct BoData {
>      flags: u32,
>  }
> =20
> +impl BoData {
> +    /// Returns the flags the BO was created with.
> +    #[expect(dead_code)]
> +    pub(crate) fn flags(&self) -> u32 {
> +        self.flags
> +    }
> +}

[Severity: Critical]
Can looking up a GEM handle via gem::lookup_handle() and accessing Bo fields
such as BoData::flags() or Object::sg_table() read and write out of bounds =
on
PRIME-imported or dumb GEM objects?

In rust/kernel/drm/gem/shmem.rs, Object::ALLOC_OPS leaves gem_create_object
as None while wiring gem_prime_import_sg_table and dumb_create to the C
drm_gem_shmem helpers:

rust/kernel/drm/gem/shmem.rs:Object::ALLOC_OPS {
    const ALLOC_OPS: driver::AllocOps =3D driver::AllocOps {
        gem_create_object: None,
        prime_handle_to_fd: None,
        prime_fd_to_handle: None,
        gem_prime_import: None,
        gem_prime_import_sg_table: Some(bindings::drm_gem_shmem_prime_impor=
t_sg_table),
        dumb_create: Some(bindings::drm_gem_shmem_dumb_create),
        dumb_map_offset: None,
    };
}

When userspace creates a handle via DRM_IOCTL_PRIME_FD_TO_HANDLE or
DRM_IOCTL_MODE_CREATE_DUMB, __drm_gem_shmem_create() sees a NULL
gem_create_object callback and allocates only sizeof(struct
drm_gem_shmem_object) bytes without the trailing Rust gem::shmem::Object<T>
fields (parent_resv_obj, sgt_res, sgt_lock, and inner: BoData).  Passing
that handle to DRM_IOCTL_PANTHOR_VM_BIND (or a subsequent BO ioctl) resolves
it through Bo::lookup_handle(), which uncheckedly casts the bare struct
drm_gem_shmem_object pointer to &gem::shmem::Object<BoData> and accesses
sgt_lock, sgt_res, or inner.flags past the end of the slab allocation.

> @@ -56,24 +69,48 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCre=
ateArgs) -> impl PinInit<Se
[ ... ]
>  /// Create a new GEM buffer object.
>  #[expect(dead_code)]
> -pub(crate) fn new_object(ddev: &TyrDrmDevice, size: usize, flags: u32) -=
> Result<ARef<Bo>> {
> +pub(crate) fn new_object(
> +    ddev: &TyrDrmDevice,
> +    pdev: &Device<Bound>,
> +    size: usize,
> +    flags: u32,
> +    coherent: bool,
> +) -> Result<ARef<Bo>> {
>      if size =3D=3D 0 {
>          return Err(EINVAL);
>      }
> =20
>      let aligned_size =3D size.checked_next_multiple_of(PAGE_SIZE).ok_or(=
EINVAL)?;
> =20
> -    Bo::new(
> +    let map_wc =3D should_map_wc(coherent, flags);
> +    let bo =3D Bo::new(
>          ddev,
>          aligned_size,
>          shmem::ObjectConfig {
> -            map_wc: true,
> +            map_wc,
>              parent_resv_obj: None,
>          },
>          BoCreateArgs { flags },
> -    )
> +    )?;
> +
> +    bo.sg_table(pdev)?;
> +
> +    Ok(bo)
>  }

[Severity: Medium]
Should bo.sg_table(pdev) only be called when map_wc is true?

Object::sg_table() caches its result in a SetOnce (self.sgt_res).  On a
non-coherent device when userspace sets DRM_PANTHOR_BO_WB_MMAP (map_wc is
false), calling bo.sg_table(pdev) at BO creation immediately pins the pages
and consumes the one-time dma_map_sgtable() cache flush before userspace
mmaps and writes to the cached buffer.  When the BO is later bound via
DRM_IOCTL_PANTHOR_VM_BIND, GpuVmData::sm_step_map() -> bo.sg_table() hits t=
he
already-populated SetOnce and skips dma_map_sgtable(), leaving CPU writes
made before VM_BIND unflushed in the CPU cache.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-tyr-ioctls=
-v6-0-b2896bf2b3c9@kylinos.cn?part=3D9
