Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71CCC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C7210E664;
	Tue,  4 Aug 2026 15:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nV/nwvnO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB1210E664
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:23:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C45C860A73;
 Tue,  4 Aug 2026 15:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F211F000E9;
 Tue,  4 Aug 2026 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785857026;
 bh=Ox0UvcVp1gNli8qcowt7xvx0lKE51/5jbJFoW+p/KFg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nV/nwvnOUjVuwQtjnExBKeKPWfOOCwRkbr/86ZnboI3wPK8k1ywPossIbbd9Z1fD0
 +zhgf/gVMYhqFXz1uqq7XE0cJnUKPs/EVqv5oCi0A2o0M63pfXYtk3pUYfK2w1+n5N
 goYQPksggYZc++houghpfJhh8r/HDpHFbkDwcpVNsTGA2ZZXlkRq+wyWuxEAhetUP9
 Etq33agyuY+eAlgzIeb39EnaLDrtWdi9rXrFVwwpHtbVu7d0lfx3vDgP/GvzGuToZW
 jxgCJbeYAt8n7tTB666rHM8fr14qZLCp8b82bzzIWZFgCmMV3kj85Kzu+f9E3VWJcb
 IBGJqUaQHKLZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
To: "Konstantin Fastov" <kfastov@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804140403.16337-1-kfastov@gmail.com>
References: <20260804140403.16337-1-kfastov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:23:45 +0000
Message-Id: <20260804152346.52F211F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect page offset calculation for split VMAs in drm_gem_shmem =
fault handlers.
--

--- Patch [1]: [PATCH] drm/gem-shmem: Install writable PTEs for write fault=
s ---
commit e62e2d7a0bc9f9a9b0ed15d3b6506aec1a894539
Author: Konstantin Fastov <kfastov@gmail.com>

    drm/gem-shmem: Install writable PTEs for write faults
   =20
    Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
    .pfn_mkwrite handler, which causes read-only PTEs to be installed even
    for write faults. This commit fixes the issue by directly installing
    writable PTEs for write faults and recording the write for dirty tracki=
ng.
    This mirrors a similar fix previously applied to the PMD path.

    Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status =
in mmap")
    Cc: stable@vger.kernel.org
    Closes: https://github.com/AsahiLinux/linux/issues/560
    Assisted-by: Claude:claude-fable-5
    Signed-off-by: Konstantin Fastov <kfastov@gmail.com>

> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index 06d019d51d3e6..2afef0b9bb5b0 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -593,7 +593,25 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vm=
f, unsigned int order,
>  				 unsigned long pfn)
>  {
>  	if (!order) {
> -		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
> +		vm_fault_t ret;
> +
> +		/* .pfn_mkwrite enables write-notify, so vm_page_prot lacks
> +		 * the write bit and a plain vmf_insert_pfn() would install
> +		 * a read-only PTE even for a write fault.  Not every fault
> +		 * resolver refaults into .pfn_mkwrite() to upgrade it (KVM
> +		 * doesn't), so install a writable PTE and record the write
> +		 * directly, like the PMD path below.
> +		 */
> +		if (vmf->flags & FAULT_FLAG_WRITE) {
> +			ret =3D vmf_insert_pfn_mkwrite(vmf->vma, vmf->address,
> +						     pfn);
> +			if (ret =3D=3D VM_FAULT_NOPAGE)
> +				drm_gem_shmem_record_mkwrite(vmf);

[Severity: High]
This is a pre-existing issue, but does drm_gem_shmem_record_mkwrite()
calculate the correct page offset for split VMAs?

In drm_gem_shmem_record_mkwrite(), the page offset is calculated as:
    pgoff_t page_offset =3D vmf->pgoff - vma->vm_pgoff;

If userspace maps a GEM shmem object and then splits the VMA (e.g., via a
partial munmap or mprotect), this yields the offset relative to the VMA
start rather than the GEM object. This causes the wrong folio to be marked
dirty, leading to potential data loss if the actually modified pages aren't
written back.

A similar issue appears in drm_gem_shmem_any_fault(), which also calculates
page_offset as vmf->pgoff - vma->vm_pgoff, causing subsequent faults on the
remaining split VMA to map the wrong physical pages.

> +		} else {
> +			ret =3D vmf_insert_pfn(vmf->vma, vmf->address, pfn);
> +		}
> +
> +		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804140403.1633=
7-1-kfastov@gmail.com?part=3D1
