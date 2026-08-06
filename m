Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6282FC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 05:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E7B10F0AE;
	Thu,  6 Aug 2026 05:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cCD2hPEI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8FF10F0A8
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 05:00:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31BF060A64;
 Thu,  6 Aug 2026 05:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B038C1F000E9;
 Thu,  6 Aug 2026 05:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785992405;
 bh=FHlLFuA02EUn0W2JnDd/48j6gUdW+5/LBmn7V/aI5u4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cCD2hPEIkSDso4d5Z1InI75BxZ4ooAoqLUAulJivWpD86XugiOVSkKSqQyIqIL5DW
 HJX1KcQ4v1XOdn3tBgqX6WEVd6Zgg4hSgtB6l/4BCPkQeFQl5fIK4XZstiZOGOXqv3
 ZK8QzbgnAKP1Rj7xN5+VEhaRshSmLPDZgYH3BidZurPwoKJH7cqtkqJRVDppY/eHvD
 RQGf5Q+jH5qz/8/HhDTe5CbYZhln4rLCNYoVTN+dzET6rDOMiyOxZbc5dA6erI4T8E
 UTajN3yDdpWyVkbVUwGvg9smbwcPzvEXwIe66Vi9nVarquGZSd16p0GWzu9h4b3lrS
 /uuNuDjRle+cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amdgpu: fix VM update overrun on non-4K page
 kernels
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-amdgpu-fixes-v1-2-ce247012d4da@outlook.com>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-2-ce247012d4da@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 05:00:05 +0000
Message-Id: <20260806050005.B038C1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Unhandled error path leaks BOs and leaves dangling pointers to=
 a stack-allocated list, leading to stack corruption.
- [High] Sub-page offset is dropped when mapping contiguous system memory o=
n non-4K page kernels, causing data corruption.
--

--- Patch [2]: [PATCH 2/3] drm/amdgpu: fix VM update overrun on non-4K page=
 kernels ---
commit 250ebbca695a7882625e4e4f1a9f6af7c33fde76
Author: Junrui Luo <moonafterrain@outlook.com>
drm/amdgpu: fix VM update overrun on non-4K page kernels

This commit fixes a VM update overrun bug in amdgpu_vm_update_range() on
systems where the CPU page size is larger than the GPU page size. It clamps
num_entries against the rounded-up value during the contiguity scan. This
prevents an issue where an unprivileged caller could trigger a BUG_ON by
mapping memory with a non-multiple GPU page count.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index dc6a9d7dd0b28..365a1c4a45275 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1193,8 +1193,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>  				}
>  				if (!contiguous)
>  					count--;
> -				num_entries =3D count *
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +				num_entries =3D min(count *
> +						  AMDGPU_GPU_PAGES_IN_CPU_PAGE,
> +						  num_entries);
>  			}
> =20
>  			if (!contiguous) {

[Severity: High]
This is a pre-existing issue, but does this code drop the sub-page offset
when mapping contiguous memory?

In amdgpu_vm_update_range(), if a user maps system memory where
PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE at a sub-CPU-page offset and the pages are
physically contiguous, addr is set to pages_addr[cursor.start >> PAGE_SHIFT=
].

Because params.pages_addr is set to NULL, the sub-page offset
(cursor.start & ~PAGE_MASK) is dropped. Could this cause the GPU to map
memory starting from the beginning of the CPU page instead of the requested
offset, returning incorrect data to the user?

[Severity: Critical]
This is a pre-existing issue, but does the error_free path in this function
leave dangling pointers to the stack-allocated params.tlb_flush_waitlist?

During amdgpu_vm_ptes_update() later in this loop, replaced page table
entries are added to params.tlb_flush_waitlist, which is allocated on the
stack in amdgpu_vm_update_range().

If a subsequent operation fails, the code jumps to error_free:

		r =3D amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
		if (r)
			goto error_free;

This bypasses the call to amdgpu_vm_pt_free_list() which would normally
process and free the list.

When the function returns, its stack frame is reclaimed, but the
amdgpu_vm_bo_base entries in the software tree still have their vm_status
list nodes pointing to this reclaimed stack memory.

When the VM is later destroyed, amdgpu_vm_pt_free_root() traverses the tree
and calls list_del() on these entries. Could this write to the dangling sta=
ck
pointers and cause arbitrary stack corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-amdgpu-fix=
es-v1-0-ce247012d4da@outlook.com?part=3D2
