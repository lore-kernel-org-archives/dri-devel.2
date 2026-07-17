Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406CDC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B30810F62A;
	Fri, 17 Jul 2026 21:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KYN1UjQK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F1B10F62A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:07:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A44A34075F;
 Fri, 17 Jul 2026 21:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF171F000E9;
 Fri, 17 Jul 2026 21:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322477;
 bh=WmqWSsG7oEYyKjYgxw66SFCZbhfaUdsYmCiw4GL3Zbg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KYN1UjQKi9SJRnadS5GPpUFR9vqybhzaCOUnbClkgTCeY8JmUcVhWtmFGrgn6+gkn
 nurRcXmZlXtq4tSxZ4HWRTQHKqKUAcvqj4e07s5iPMh3HWS0xpElDBjier5kExvH6V
 qfpAjlmIdGIku2zQ4RGWojqCmJFvUiPgb3Cr9vMAsqv2n5+KEekUOsSXqiw9cbxbX+
 E0VrwziJTmRV9kYUpnDN20SXY43O7JsqOaK/NVpjA/PLyccgxhNNfApHQYA4LBMOMq
 Hc3RbZYPotg5AQ5BdX20jFGJFHyI15i/IhiraxVr2/aE8MC2SfpOwzJqhwrC7+44OJ
 I0KyDtexm0Vew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/16] drm/msm: Don't fallback to shared VM for VM_BIND
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-15-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-15-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:07:56 +0000
Message-Id: <20260717210757.5CF171F000E9@smtp.kernel.org>
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
- [High] The patch exposes a tight-loop, unbounded memory leak of MMU paget=
ables by failing to cache error states during lazy VM initialization.
--

--- Patch [14]: [PATCH v6 14/16] drm/msm: Don't fallback to shared VM for V=
M_BIND ---
commit 4383cea99723fe11a1653c676500fab3a15f1fda
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Don't fallback to shared VM for VM_BIND

If the user wants a userspace managed VM (EN_VM_BIND) don't silently
fall back to shared VM.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 3bd9a13837be3..50cc32184bb9d 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -235,7 +235,8 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *d=
ev, struct msm_context *ctx
>  	if (!ctx->vm) {
>  		vm =3D msm_gpu_create_private_vm(
>  			priv->gpu, current, !ctx->userspace_managed_vm);
> -		smp_store_release(&ctx->vm, vm);
> +		if (!IS_ERR_OR_NULL(vm))
> +			smp_store_release(&ctx->vm, vm);

[Severity: High]
This is a pre-existing issue, but does discarding the error pointer here
expose a tight loop memory leak of the mmu pagetables?

If msm_gpu_create_private_vm() returns an error pointer, ctx->vm stays NULL.
This allows userspace to repeatedly trigger vm creation on the same context
by calling the submit ioctl in a tight loop.

When msm_gpu_create_private_vm() fails (for example, if drm_sched_init()
fails inside msm_gem_vm_create()), the underlying mmu object allocated in
a6xx_create_private_vm() is leaked.

Previously, msm_gpu_create_private_vm() replaced this error pointer with a
fallback to gpu->vm. This bounded the leak to once per context. Because this
patch restricts the fallback to kernel managed vms, userspace managed vms
now return the error pointer directly.

Could we cache the error state in ctx->vm so we don't continually retry
failing vm creations, or fix the underlying leak by freeing the mmu object
on error?

>  	}
> =20
>  	return ctx->vm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D14
