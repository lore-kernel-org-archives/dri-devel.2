Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F6606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deKYAGF8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA61410E5A7;
	Sun, 22 Nov 2026 13:16:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5197C10E9E4
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:16:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3969541FCF;
 Sun, 22 Nov 2026 13:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AF61F000C6;
 Sun, 22 Nov 2026 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795353387;
 bh=ZYfGwL5/ErqiOIEWbC+tQI2JHAA+iT59T+IkRwvCEs8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=deKYAGF8Qsk3ThmJ3zc50Wmr2O4MMCXDVG3gQzpr1cDDvijXHtGU43eVXGU8rg3vf
 08fVa5vytkiX0eOBvlQuLsI4qMNK/8nHuvpnOqYqTYaYzlPauqEyZuR53UBxsVym/d
 kwc6vbTGbEo4CR79mXh/2tym1ZeY7o7vknSNTyc/WwcG8XXUjNyw3MWKQIdWdEOtMx
 zXr2l1gPEEJ6FIt2HQG16XU7H0vcJf+skY5Q4mj/AIFnmALRSWVdqfDxkkvMYBJ4G0
 hncPNCbSxfUcGNWypAGYPoOHPezGfP9Kn04liIdQtpkb2U4vzE3zxd09nutn8uLp5i
 2mHBiOm0j27rQ==
Message-ID: <sashiko-outbox-227955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] drm/tyr: support write-combine BO mappings
To: "Alvin Sun" <alvin.sun@linux.dev>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261122-tyr-ioctls-v7-9-3a2af624b992@linux.dev>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-9-3a2af624b992@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 13:16:27 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/tyr: unconditional sg_table() call in new_object() for
  write-back BOs
- [Medium] drm/tyr: should_map_wc() disables WC on coherent devices
  without GPU coherency
--

commit 86892ff5c6c9751c0ce3610b27d27ca95ece458f
Author: Sami Tolvanen <samitolvanen@google.com>

drm/tyr: support write-combine BO mappings

This commit queries device DMA coherence at probe time to decide whether
shmem-backed GEM buffer objects should be mapped write-combine or
write-back, and fetches the scatter-gather table at BO creation time to
flush zeroed pages.

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

[Severity: Medium]
Can enabling write-back BO mappings when DmaAttr::COHERENT is set break MCU
boot before GPU and MMU coherency are configured?

Tyr currently hardcodes non-coherent operation in the GPU and MMU:
GpuInfo::new() sets selected_coherency to DRM_PANTHOR_GPU_COHERENCY_NONE
without programming COHERENCY_ENABLE, VmAsData::new() sets coherent_walk to
false, and MEMATTR::attribute_from_mair() always encodes
Coherency::MidgardInnerDomain.  On a platform whose firmware marks the GPU
device as dma-coherent, passing coherent =3D true causes KernelBo::new() to
create MCU firmware section BOs with map_wc: false, so
Firmware::init_section_mem() writes firmware sections through a write-back
cached vmap without CPU cache maintenance while the MCU reads stale memory
from DRAM.

> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 60f6363995a5a..55e2d67b96d98 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
[ ... ]
> @@ -56,24 +69,48 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCre=
ateArgs) -> impl PinInit<Se
>  /// Type alias for Tyr GEM buffer objects.
>  pub(crate) type Bo =3D gem::shmem::Object<BoData>;
> =20
> +/// Returns whether a BO should be mapped write-combine.
> +pub(crate) fn should_map_wc(coherent: bool, flags: u32) -> bool {
> +    if coherent {
> +        return false;
> +    }
> +
> +    if flags & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_WB_MMAP !=3D 0 {
> +        return false;
> +    }
> +
> +    true
> +}
> +
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

When map_wc is false (for example with DRM_PANTHOR_BO_WB_MMAP), calling
bo.sg_table(pdev) here eagerly pins all backing pages and runs
dma_map_sgtable() at BO creation time even though CPU accesses use cached
mappings.  Because shmem::Object::sg_table() caches the result in a SetOnce,
consuming that one-shot dma_map_sgtable() call before userspace writes to
the write-back mapping also means the later sg_table() call in
GpuVmData::sm_step_map() during VM_BIND returns the cached table without
flushing dirty CPU cache lines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-tyr-ioctls=
-v7-0-3a2af624b992@linux.dev?part=3D9
