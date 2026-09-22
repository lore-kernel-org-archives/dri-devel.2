Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCBFC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869F710EC4F;
	Tue, 22 Sep 2026 10:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Swqvf3MJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80BF10EC41;
 Tue, 22 Sep 2026 10:30:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9737842D99;
 Tue, 22 Sep 2026 10:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC81F000FF;
 Tue, 22 Sep 2026 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790073026;
 bh=jmdK/h1nAPyOJG6ZtdSP5Dmy6QYJeYHFDDCJutgljvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Swqvf3MJ1AzkI9d/keQNDp5Nq2m5cMB+omvahPPz84MQ/HqtutXVnmV6zXquWXVTy
 szuY53j4Uz94Thjm9OyBstySyBxaqKonOO6m/m4xa8oHfID0T+CNt6cAQheLU2eZx+
 tgoxp5KJ4s4dPtt26ohAbyU236GqNSY8JZBt2pV7vlaSy0zprb09a6HTpA2TZYfBCw
 l6tK7HsgkBJi4k8CcvjPNHvnj69k6hM5red5aeaTj93OM8sLbJC3aFEBLA0AdAGfwm
 J7rtcac9NKzsGpCt046OJy0tPvVwxI84x6RaPrrZcx0tSdHPpEkpTtFPncsEk5y6Dj
 XoD2x9jM/xh7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] drm/xe: Invalidate existing VRAM mappings on
 wedge
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922101721.1583542-10-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
 <20260922101721.1583542-10-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:30:25 +0000
Message-Id: <20260922103026.41EC81F000FF@smtp.kernel.org>
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
- [High] drm/xe: dma-buf VRAM mappings are not invalidated on device wedge
- [High] drm/xe: PAT aliasing violation by mapping GFP_KERNEL dummy page as=
 WC
--

commit c757615e833a0d49b9d8ef7258c5d9bef1106610
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Invalidate existing VRAM mappings on wedge

This commit introduces a mechanism to drain active CPU faults and invalidate
all tracked VRAM mappings when a device wedges. Subsequent faults use a per=
-BO
dummy page, preventing valid PTEs from keeping access to VRAM.

> CPU mappings created before a device wedge can keep valid PTEs and
> continue accessing VRAM. Mapping new faults to a dummy page does not
> replace these existing mappings.
>=20
> Use the common device I/O SRCU gate to wait for active CPU faults to
> finish. Then invalidate all tracked VRAM mappings. Faults starting
> after the wedge use the per-BO dummy page.

[Severity: High]
Can mapping the dummy page cause a Machine Check Exception or SIGBUS?

When CPU faults occur on a VRAM BO after the device wedges, they trigger
xe_bo_vm_dummy_page():

drivers/gpu/drm/xe/xe_bo.c:xe_bo_vm_dummy_page() {
    ...
	page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
    ...
	return vmf_insert_pfn_prot(vma, vmf->address, pfn,
				   vma->vm_page_prot);
}

This allocates a standard system RAM page using GFP_KERNEL (which has
Write-Back caching) and maps it into userspace using the VMA's original
vma->vm_page_prot. For VRAM mappings, vma->vm_page_prot contains Write-Comb=
ine
(WC) bits.

Does mapping a WB page as WC create a conflicting PAT alias on x86?
track_pfn_insert() may reject this for RAM pages, leading to a SIGBUS, or if
bypassed, a hardware MCE.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 7902ce3fe0127..73dcd397dc13c 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -4155,6 +4155,26 @@ void xe_bo_runtime_pm_release_mmap_offset(struct x=
e_bo *bo)
>  	list_del_init(&bo->vram_userfault_link);
>  }
> =20
> +/**
> + * xe_bo_wedged_invalidate_mmaps - Invalidate CPU mappings backed by VRAM
> + * @xe: xe device instance
> + *
> + * The caller must drain the common device I/O gate before calling this
> + * function. Remove all tracked VRAM mappings so later faults map the
> + * per-BO dummy page.
> + */
> +void xe_bo_wedged_invalidate_mmaps(struct xe_device *xe)
> +{
> +	struct xe_bo *bo, *next;
> +
> +	mutex_lock(&xe->mem_access.vram_userfault.lock);
> +	list_for_each_entry_safe(bo, next,
> +				 &xe->mem_access.vram_userfault.list,
> +				 vram_userfault_link)
> +		xe_bo_runtime_pm_release_mmap_offset(bo);

[Severity: High]
Does this code miss active dma-buf CPU mappings?

xe_bo_runtime_pm_release_mmap_offset() only unmaps the VMA node associated
with the DRM device file (drm_vma_node_unmap()). It doesn't seem to clear
dma-buf mappings, which are tracked under
bo->ttm.base.dma_buf->file->f_mapping.

If a userspace application exports a VRAM BO as a dma-buf and maps it, would
it retain CPU access to VRAM after the device wedges? Accessing VRAM on a
wedged device can cause PCIe hangs or system crashes.=20

Could a call to dma_buf_invalidate_mappings() be required here, similar to
how it is handled in xe_bo_move_notify()?

> +	mutex_unlock(&xe->mem_access.vram_userfault.lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922101721.1583=
542-1-arvind.yadav@intel.com?part=3D9
