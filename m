Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9784AC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 15:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE8610E346;
	Sat, 22 Aug 2026 15:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="evqVxJFT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA6110E346
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 15:02:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2971E60008;
 Sat, 22 Aug 2026 15:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF91F000E9;
 Sat, 22 Aug 2026 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787410946;
 bh=XBQng35yBEcsTJtllkeqAr3cwPigQwYb/RKweh92JWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=evqVxJFTcSz3WLifFfNrZ43ZZn9BFpRg0F5VcIYbFC4kQDXg3hOPXE3F2LdUQ2uS3
 1nGFebQMBbnBSH9veHyfJ/GZ112dsmUh0urCovfNk2M9Jv3hmnvnQ899d2wYri1RDJ
 X6224BGG+3j/ljSv5FciSldbZjQ3p31ltPTkvCHeiO/5u6utObRyCU1q5t16fZvtFp
 G/jQfKrl5E5q0xPnsP7RD1d1Y7sXJmCPdrjKxcktSzqEcMeJpS+WCSJedu1W4HlfnD
 ue2A4m06WlYzLPv70D4Qo/9te8NrMj1IzTsmTI6BR5DZxYBLF7kJHKpeejz2Uc83gH
 4zNRtotGZ7LKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdkfd: don't leak BOs when process teardown
 can't unmap them
To: "Bocaj Gnuoy" <bocajgnuoy@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260822144402.929677-1-bocajgnuoy@gmail.com>
References: <20260822142521.899098-1-bocajgnuoy@gmail.com>
 <20260822144402.929677-1-bocajgnuoy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 15:02:26 +0000
Message-Id: <20260822150226.B3DF91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Internal BO allocations (like IB and CWSR) are leaked during error=
 unwinding because `kfd_process_alloc_gpuvm` uses `force =3D false` and per=
manently loses the reference.
- [High] The force-free path can still fail under memory pressure due to `G=
FP_KERNEL` allocations, silently bypassing teardown WARNs and causing the s=
ame Use-After-Free deadlock.
- [High] `amdgpu_amdkfd_gpuvm_free_memory_of_gpu` aborts early and leaks BO=
s if a signal is pending during error unwinding.
--

--- Patch [1]: [PATCH v2] drm/amdkfd: don't leak BOs when process teardown =
can't unmap them ---
commit d455d7ae97544007b84e3463aa9bc5371a4a8935
Author: Bocaj Gnuoy <bocajgnuoy@gmail.com>

drm/amdkfd: don't leak BOs when process teardown can't unmap them

This commit fixes a memory leak and subsequent TTM eviction deadlock that
occurs when BO unmapping fails during process teardown due to memory
exhaustion. It adds a force flag to amdgpu_amdkfd_gpuvm_free_memory_of_gpu()
to bypass the mapping check and detach attachments instead of aborting.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5672

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 0a7c1900da959..6d5126aa6fe74 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c

[ ... ]

> @@ -814,7 +814,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process=
_device *pdd,
> =20
>  err_map_mem:
>  	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->adev, *mem, pdd->drm_priv,
> -					       NULL);
> +					       NULL, false);

[Severity: High]
This isn't a bug introduced by this patch, but does this error unwinding pa=
th
leak internal BO allocations?

If amdgpu_amdkfd_gpuvm_free_memory_of_gpu() fails here due to the memory be=
ing
exhausted during unmapping (similar to the user-space BOs), the force =3D f=
alse
flag means it will safely return -EBUSY but abort the cleanup.

Since the pointers are then unconditionally cleared:

err_alloc_mem:
	*mem =3D NULL;
	*kptr =3D NULL;

Does the reference to the BO get permanently lost, causing the exact same
use-after-free sequence this patch is addressing?

>  err_alloc_mem:
>  	*mem =3D NULL;
>  	*kptr =3D NULL;

[ ... ]

> @@ -1119,18 +1119,29 @@ static void kfd_process_device_free_bos(struct kf=
d_process_device *pdd)

[ ... ]

>  		}
> =20
> -		amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, mem,
> -						       pdd->drm_priv, NULL);
> +		r =3D amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev, mem,
> +							   pdd->drm_priv, NULL,
> +							   true);
> +		if (r)
> +			pr_err("Failed to free BO on process teardown: %d\n", r);

[Severity: High]
This is a pre-existing issue, but does this still leak BOs and cause a TTM
eviction deadlock if amdgpu_amdkfd_gpuvm_free_memory_of_gpu() fails for oth=
er
reasons?

Looking at amdgpu_amdkfd_gpuvm_free_memory_of_gpu(), it can still fail duri=
ng
reservation:

	ret =3D reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
	if (unlikely(ret))
		return ret;

This reservation can fail under memory exhaustion if the GFP_KERNEL allocat=
ions
in drm_exec_init() fail. Since the caller drops the IDR handle regardless of
the error, will the dangling bo_va pointers still poison the eviction LRU?

[Severity: High]
This is also a pre-existing issue, but what happens if a signal is pending
during process teardown?

The same reservation path in reserve_bo_and_cond_vms() uses an interruptible
wait:

	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
		      DRM_EXEC_IGNORE_DUPLICATES, 0);

If a signal (e.g. SIGKILL) is pending, this fails with -ERESTARTSYS.

Does this cause amdgpu_amdkfd_gpuvm_free_memory_of_gpu() to skip the remain=
ing
cleanup and leak the attachments, leading to the same use-after-free sequen=
ce
when the handle is dropped?

>  		kfd_process_device_remove_obj_handle(pdd, id);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822144402.9296=
77-1-bocajgnuoy@gmail.com?part=3D1
