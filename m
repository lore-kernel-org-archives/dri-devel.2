Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BFAC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1424E10F3C1;
	Thu, 16 Jul 2026 20:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IIjDQMbH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E882A10F3C1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:33:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4812960A5E;
 Thu, 16 Jul 2026 20:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84741F000E9;
 Thu, 16 Jul 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784234023;
 bh=ItVylX8Wqd5b/e/t14x9X4cjZqnCy3XYDZz+vpUsezY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IIjDQMbHFvyWn7SO+RNy1D5RnTko48W8gQ4iksO/kC4mUD/sVvK+Gqm+DA+ZBx+dL
 8iUcTPe7zgU1KnIAP6+sjTr70O7ak6ztboLvOMvsF0kAguezszeEI+pgrhMwZbZQaN
 tqi3yKOCTWG6dhDxJSoYo4c6pbxmbQL5ubI4PyV2+forvT+lOTSj1cSCBeACrnNDC4
 p0V2/tCsdJZg3ACuFVGOQLhfpyGd7xSuGbs6eAov/jG4WJrfVbOkgS2v0b9lYCtj1A
 7lXIU0f2vbukt5wIohbB/QuhfpM8Mlz1ph+vv1vVXQQsEQ0Yr0QVcQ+TH/a+vSrN0G
 4zFsJiSvBq5KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] drm/msm: Allow lazy VM creation to fail
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-7-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-7-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:33:42 +0000
Message-Id: <20260716203342.C84741F000E9@smtp.kernel.org>
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
- [High] Direct access to `ctx->vm` via `drm_gpuvm_resv_obj()` in `msm_gem_=
new_handle()` causes a NULL pointer dereference when called before the VM i=
s lazily initialized.
--

--- Patch [6]: [PATCH v5 06/10] drm/msm: Allow lazy VM creation to fail ---
commit b8fda3fb0d624d38526d9746f2057050a7931a85
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Allow lazy VM creation to fail

In the next commit, we'll stop falling back to shared VM if private VM
creation fails. This isn't expected to happen in practice, it would either
require small memory allocations to fail, or missing support in arm-smmu-qc=
om.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 26ea8a28be474..06b142d82e4d0 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
[ ... ]
> @@ -554,6 +554,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void=
 *data,
>  	struct msm_drm_private *priv =3D dev->dev_private;
>  	struct drm_msm_gem_submit *args =3D data;
>  	struct msm_context *ctx =3D file->driver_priv;
> +	struct drm_gpuvm *vm =3D msm_context_vm(dev, ctx);

[Severity: High]
This is a pre-existing issue, but seeing msm_context_vm() added here made
me look at other places where ctx->vm is accessed, and I noticed a potential
issue in msm_gem_new_handle().

If a user opens the DRM device and directly issues the DRM_IOCTL_MSM_GEM_NEW
ioctl with the MSM_BO_NO_SHARE flag before the VM is lazily initialized
(e.g., before creating a submitqueue), could this result in a NULL pointer
dereference?

> drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle() {
> 	...
> 	if (flags & MSM_BO_NO_SHARE) {
> 		struct msm_context *ctx =3D file->driver_priv;
> 		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);

Because drm_gpuvm_resv_obj(ctx->vm) directly dereferences the pointer
without calling msm_context_vm() first to ensure it is created, it seems
this could crash the kernel if ctx->vm is still NULL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D6
