Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7CEC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEF410E686;
	Thu, 16 Jul 2026 20:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+rF7673";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855C310E686
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:28:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20BE841500;
 Thu, 16 Jul 2026 20:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE50B1F000E9;
 Thu, 16 Jul 2026 20:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784233696;
 bh=XYmrAH7AvqUDiD3m3i9QEi/Nr+3WG4nJDcYYgEQwj4c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F+rF7673szirgHRzyCuHY0xp5GEBN/hrPRaIYxGpqYQEqbujFpIAY054NMBI9ZT6e
 aC7zirgGo51nQy/V3hRAYeTbo9lSPkGlZP8S8ksONQU8thCz8aosT2hMdZkOYE3YMW
 9Pap8407Wf2EPmaLVyUxDZB08gXSptujH4NkXu0BuPpM40E/kJA5WZMdgULmrqsThn
 c3/8CWNw00eNW6+vDqvJ9xZffnWbX4Pc8+D9w+iymKG/MCFOb5KfXz5fA0ngn5JrbR
 EZGUbDXVQz0le682sNoummyvutmmCclT1SZntIxOnO3GgxQqlXduVvI1QuHiTmcJIc
 pZRUmZtOCKkUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] drm/msm: Don't fallback to shared VM for VM_BIND
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-8-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-8-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:28:15 +0000
Message-Id: <20260716202815.CE50B1F000E9@smtp.kernel.org>
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
- [High] The fallback condition for `vm` in `msm_gpu_create_private_vm` inc=
orrectly uses `!kernel_managed` instead of `kernel_managed`, breaking legac=
y contexts on older hardware and failing to prevent fallback for VM_BIND co=
ntexts.
--

--- Patch [7]: [PATCH v5 07/10] drm/msm: Don't fallback to shared VM for VM=
_BIND ---
commit fff36b547a5d97354f5a0baebf86eafdd34bd4f8
Author: Rob Clark <robin.clark@oss.qualcomm.com>
Date:   Thu Jul 16 20:15:30 2026 +0000

drm/msm: Don't fallback to shared VM for VM_BIND

This commit modifies the fallback logic for VM creation to prevent userspac=
e=20
managed VMs (VM_BIND) from falling back to the shared kernel-managed VM if=
=20
private VM creation fails.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 18ed00e5f143b..d02c37380414b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -875,7 +875,7 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct=
 task_struct *task,
>  			to_msm_vm(vm)->pid =3D get_pid(task_pid(task));
>  	}
> =20
> -	if (IS_ERR_OR_NULL(vm))
> +	if (IS_ERR_OR_NULL(vm) && !kernel_managed)

[Severity: High]
Does this boolean logic operate backwards from the stated intent of the pat=
ch?

If a legacy application runs on older hardware (A5xx or prior) that lacks
private VM support, kernel_managed is true. The !kernel_managed check
evaluates to false, skipping the fallback and returning NULL or an error.
Would this break command submission on these platforms?

Conversely, if a VM_BIND context (kernel_managed =3D=3D false) fails to cre=
ate
a private VM due to memory pressure, the !kernel_managed check evaluates to
true. This causes it to fall back to the kernel-managed shared VM, allowing
the very behavior the patch was trying to prevent.

If that VM_BIND fallback occurs, could it trigger a kernel panic later?
Userspace could issue a VM_BIND ioctl with a non-zero offset against the
erroneously assigned kernel-managed VM, hitting this BUG_ON:

drivers/gpu/drm/msm/msm_gem_vma.c:msm_gem_vma_new() {
    ...
    if (vm->managed) {
        BUG_ON(offset !=3D 0);
        BUG_ON(!obj);
    ...
}

>  		vm =3D drm_gpuvm_get(gpu->vm);
> =20
>  	return vm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D7
