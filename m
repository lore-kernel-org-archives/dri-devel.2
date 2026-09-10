Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D0AC88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2803010E875;
	Thu, 10 Sep 2026 21:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q27UkZJT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8925510E875
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 21:33:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 777BC601F0;
 Thu, 10 Sep 2026 21:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F4C1F000FF;
 Thu, 10 Sep 2026 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789076025;
 bh=Gwt7j+VVqug1o+wKkPwxbBdl6Ek+XedFhA56E9ZCvoM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q27UkZJTELN1Zr+g+JC0RGsJ3FXMTjJdpd9dm1xbwua1HFL52S/eHTNNmKDT+kqpB
 nNKD0zZ2ZOiwB9n3rTXO2a7W5pdcIOQm6B8FRakgbZ+cBgPGgwzsN6jYV+EvTHs06G
 5LkMs9d8XwX6QizULWTFgqB+RDjIM3cqIxN1RyaOZNiB5InRaRWGuBFBlOtomuBXu7
 uELRHCWylqZUJ3BF/WpdVkKe2fnkdHqsXo8q7jbORGBoI3xc4iTkKFl3JP8+Q0Zn8D
 7mqbAx9cDYPQVZH2K7dMgITniQ2kXV0AmbiR/B7UyUzJWfVVanoKf1D4EEt130pvVw
 omEa5VyvcC6lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] accel/amdxdna: Fix unsafe use of handle_mm_fault()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910211338.1102315-1-lizhi.hou@amd.com>
References: <20260910211338.1102315-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:33:44 +0000
Message-Id: <20260910213345.01F4C1F000FF@smtp.kernel.org>
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

New issues:
- [High] Flawed VMA offset calculation in amdxdna_gem_mixedmap_fault causes=
 data corruption on VMA splits and DMA-buf mmaps.

Pre-existing issues:
- [High] DMA-buf mmaps bypass HMM notifier registration, causing missing pr=
e-faulting and unsafe page table teardown.
--

commit 5de79a60bd0ef403c4515e6d277ad3386e515ac9
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix unsafe use of handle_mm_fault()

This commit removes handle_mm_fault() from the mmap callback because the
VMA is not yet linked. For imported BOs, it marks the mapping invalid and
relies on the first command submission to fault in the pages. For shmem
BOs, it sets VM_MIXEDMAP and implements amdxdna_gem_mixed_vm_ops to handle
the page faults.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 3f05fa8811af1..f07f63a194537 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> +static vm_fault_t amdxdna_gem_mixedmap_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	struct drm_gem_object *gobj =3D vma->vm_private_data;
> +	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(gobj);
> +	loff_t num_pages =3D gobj->size >> PAGE_SHIFT;
> +	vm_fault_t ret =3D VM_FAULT_SIGBUS;
> +	pgoff_t page_offset;
> +	struct page *page;
> +
> +	/*
> +	 * Partial free of vma is unexpected. Otherwise, the wrong page
> +	 * will be faulted in and the user application may crash itself.
> +	 */
> +	page_offset =3D vmf->pgoff - vma->vm_pgoff;

[Severity: High]
Will this calculation cause the wrong pages to be mapped on VMA splits or
non-zero offset DMA-buf mmaps?

Because the core MM computes vmf->pgoff as:
vmf->pgoff =3D vma->vm_pgoff + ((vmf->address - vma->vm_start) >> PAGE_SHIF=
T)

The subtraction here cancels out the VMA's logical offset, causing it to
always yield the offset relative to the current VMA start. If a user mmaps a
GEM object, unmaps the first half to split the VMA, and then triggers a page
fault on the second half (e.g., after MADV_DONTNEED), could this erroneously
map pages[0] into the middle of the object?

> +
> +	dma_resv_lock(gobj->resv, NULL);

[ ... ]

>  static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_ar=
ea_struct *vma)
>  {
>  	struct drm_gem_object *gobj =3D dma_buf->priv;
>  	struct amdxdna_gem_obj *abo =3D to_xdna_obj(gobj);
> -	unsigned long num_pages =3D vma_pages(vma);
>  	int ret;

[Severity: High]
This is a pre-existing issue, but does amdxdna_gem_dmabuf_mmap() need to
call amdxdna_hmm_register() here?

Without this call, the VMA is not added to the HMM tracking list. If a user
exports a BO to a DMA-buf, mmaps the DMA-buf, and passes the virtual address
to the NPU, the driver might fail to pre-fault the pages before execution.

Additionally, if the user unmaps the VMA while the NPU is active, could the
lack of an MMU interval notifier bypass the driver's teardown stall
(dma_resv_wait_timeout()), allowing the CPU to tear down page tables while
the NPU is still executing and causing IOMMU translation faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910211338.1102=
315-1-lizhi.hou@amd.com?part=3D1
