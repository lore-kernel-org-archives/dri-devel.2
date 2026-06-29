Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626DEC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B141310E0A2;
	Mon, 29 Jun 2026 15:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Er6pzspM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3FB10E0A2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:39:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0514641815;
 Mon, 29 Jun 2026 15:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23B71F000E9;
 Mon, 29 Jun 2026 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782747573;
 bh=U92dAhczgFyZqZyit73xhgQwSTt7GejI92AqH/D4lko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Er6pzspMXLQUh0MRLlURVVF3q/VcDIYT6wnwmm5Yjv2RHHvfF8/wzQl8Tyz5LtHRc
 jvss/4PlaTEi8/MjJeBELy2HHrzk56/PYfpq5+lEFvtDfysTe0qZAgLJTSlFZighrg
 +U3JEJ/Zh/qX3KJsjXg8yBYjXC32hCERDu31nKtQcSPnb6k3eH7dRq+KI7Vo8fytYQ
 SIA9gebrfqd6JBn8Lz2piUh9nV/yiR85RPtHCVLil7Xnha+OmTiF7e7QD+ajTyy5Lo
 /P1gsl7cTdiXZDdOpbI4cAQEshTbZx/Zw6tYgYe+Rt8gnSzcXni6UZD/zdHFFBGHhH
 sfm436wWyBkqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/amdgpu: reject mapping info when BO VA is gone
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629152807.13492-1-alhouseenyousef@gmail.com>
References: <20260629152807.13492-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:39:33 +0000
Message-Id: <20260629153933.B23B71F000E9@smtp.kernel.org>
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
- [Critical] The patch adds a duplicate check for a missing BO VA, which ch=
anges the API return code and renders the existing check as unreachable dea=
d code.

Pre-existing issues:
- [High] Potential deadlock due to allocating memory with `GFP_KERNEL` whil=
e holding `dma_resv` locks.
--

commit 6d1719ca92ca060fce9b1b2b5a70616a3a67fa1c
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

drm/amdgpu: reject mapping info when BO VA is gone

This commit adds a check in amdgpu_gem_op_ioctl() to reject the
AMDGPU_GEM_OP_GET_MAPPING_INFO operation if the BO VA is missing.
The intention is to prevent a NULL pointer dereference when a concurrent
handle close removes the per-file BO VA before the mapping list is walked.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, vo=
id *data,
[ ... ]
>  		int num_mappings =3D 0;
> +
> +		if (!bo_va) {
> +			r =3D -EINVAL;
> +			goto out_exec;
> +		}
> +

[Severity: Critical]
Does adding this check break userspace ABI by changing the error code?

There is a pre-existing check for a NULL bo_va slightly lower in this
function that correctly returns -ENOENT. By returning -EINVAL here,
applications expecting the standard -ENOENT for a missing BO VA might
fail unexpectedly.

[ ... ]
>  		/*
>  		 * num_entries is set as an input to the size of the user-allocated ar=
ray of
[ ... ]
>  		 * be retried.
>  		 */
>  		if (!bo_va) {
>  			r =3D -ENOENT;
>  			goto out_exec;
>  		}

The newly added check above also makes this original check unreachable dead
code.=20

[ ... ]
>  		if (args->num_entries > INT_MAX / sizeof(*vm_entries)) {
>  			r =3D -EINVAL;
>  			goto out_exec;
>  		}
> =20
>  		vm_entries =3D kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KE=
RNEL);

[Severity: High]
This is a pre-existing issue, but can allocating memory with GFP_KERNEL here
cause a deadlock?

This allocation occurs while sleepable dma_resv locks are held (acquired via
drm_exec_lock_obj() and amdgpu_vm_lock_pd() earlier in the function).

Using GFP_KERNEL allows direct memory reclaim. If system memory pressure
forces the kernel to invoke GPU shrinkers while this thread holds dma_resv
locks, the shrinker may attempt to lock the same BO or VM root PD, leading
to a deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629152807.1349=
2-1-alhouseenyousef@gmail.com?part=3D1
