Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CC6C88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857CB10E1DB;
	Mon, 14 Sep 2026 20:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E3vBpWfR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03D610E1DB
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 20:42:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D13D66025B;
 Mon, 14 Sep 2026 20:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F60F1F00893;
 Mon, 14 Sep 2026 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789418560;
 bh=cNRR9dxrn5pZCZaIL4+tiB6pmJcgg4BFlPX1HcUHDok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E3vBpWfRovlG0ECFjpHXsfGbuudyOW/W8aYT2rQM8co5T1szTQtEFJUf9lP8gEcpT
 1R4Nhwl4kIr1l8i0lxr0Ix/tC8NCb4sHPjJnZXEJI/HgNRBNMV1rKiiPoEp9YMZm/m
 twxVfKtBm13XSh3AS804II1d9v55HbO9PubA31e7Ktsn6MEsavh2UIMcN5N7lg44CH
 vMewwxSvZHdhUfKo0hwNLxG3wifkL+42CH6u53YeDEAvtF4Y1lwd35Z4mo1Mnl9ZIF
 5G7eLGUWQvRluwPzLOA6T2tPzMUU71ZKWWAmA8V7gfpgdW/pdth1X3qCxfMnTZECYA
 pLUl7eMSWpSHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/amdgpu: commit pending work when
 amdgpu_vm_ptes_update fails
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-amdgpu_vm_fixes-v1-4-d6d835591e0f@igalia.com>
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-4-d6d835591e0f@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 20:42:39 +0000
Message-Id: <20260914204240.5F60F1F00893@smtp.kernel.org>
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
- [Critical] Ignored return value of update_funcs->update leads to NULL poi=
nter dereference or silent GPU page faults.
- [High] Dangling pointer / Use-After-Free in amdgpu_vm_pt_alloc when amdgp=
u_vm_pt_clear fails.
--

commit 7a14ea1f8dd61c2e4083bcbdd9192e590552290f
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm/amdgpu: commit pending work when amdgpu_vm_ptes_update fails

This commit changes the error path when amdgpu_vm_ptes_update() fails to
break the loop and commit pending work instead of jumping to error_free.
This fixes an SDMA job memory leak and ensures TLB entries are flushed
and local stack waitlists are cleared properly.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 5bde36754607f..1495adaaacd89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1235,7 +1235,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>  		tmp =3D start + num_entries;
>  		r =3D amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>  		if (r)
> -			goto error_free;
> +			break;

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free in t=
he
page table allocation path called from amdgpu_vm_ptes_update():

drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:amdgpu_vm_pt_alloc() {
    ...
    error_free_pt:
        amdgpu_bo_unref(&pt_bo);
        return r;
}

If amdgpu_vm_pt_clear() fails (e.g., due to memory allocation failure or
fence wait timeout), it jumps to error_free_pt and frees the newly
allocated pt_bo. However, this BO has already been assigned to entry->bo
and added to VM tracking lists by the preceding call to
amdgpu_vm_bo_base_init(). Is it possible that freeing pt_bo here leaves
entry->bo pointing to the freed memory?

[Severity: Critical]
This is a pre-existing issue, but there appears to be an unhandled error
path during PTE updates called from amdgpu_vm_ptes_update():

drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:amdgpu_vm_pte_update_flags() {
    ...
    params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
                                     flags);
}

The update function's return value is completely ignored. If the update
fails (for example, if amdgpu_vm_sdma_update() fails to allocate a job due
to ENOMEM), the job pointer (p->job) is set to NULL. Since the error is
dropped, amdgpu_vm_ptes_update() continues iterating and calls
amdgpu_vm_pte_update_flags() again.

Will this cause amdgpu_vm_sdma_update() to dereference the NULL p->job on
the next iteration, leading to a kernel panic? Or if it's a CPU update,
will ignoring the failure lead to invalid GPU page tables and subsequent
GPU page faults?

> =20
>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>  		start =3D tmp;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-amdgpu_vm_=
fixes-v1-0-d6d835591e0f@igalia.com?part=3D4
