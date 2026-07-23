Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E8FC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C1510F06D;
	Thu, 23 Jul 2026 10:18:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDE710F06D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:18:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56A35600AD;
 Thu, 23 Jul 2026 10:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF001F00A3A;
 Thu, 23 Jul 2026 10:18:17 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm: don't tear down KMS twice when KMS init fails
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-msm-fix-crash-v1-1-78fb4721c2d9@oss.qualcomm.com>
References: <20260723-msm-fix-crash-v1-1-78fb4721c2d9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:18:17 +0000
Message-Id: <20260723101817.DFF001F00A3A@smtp.kernel.org>
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
- [High] Kernel panics in common KMS teardown path due to unconditional der=
eference of partially-initialized structures on early probe failures.
--

--- Patch [1]: [PATCH] drm/msm: don't tear down KMS twice when KMS init fai=
ls ---
commit dccb630956dd40369b4b75f78b147548c8331788
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: don't tear down KMS twice when KMS init fails

This commit removes the local KMS teardown from the mdp4 and mdp5 error
paths. It instead relies on the common msm_drm_kms_uninit() path to handle
cleanup on failure, preventing a use-after-free crash.

> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/m=
sm/disp/mdp4/mdp4_kms.c
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> @@ -398,7 +398,7 @@ static int mdp4_kms_init(struct drm_device *dev)
>  	ret =3D mdp_kms_init(&mdp4_kms->base, &kms_funcs);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev->dev, "failed to init kms\n");
> -		goto fail;
> +		return ret;
>  	}

[Severity: High]
This is a pre-existing issue, but by delegating all cleanup to the common
path on early failures, do we risk kernel panics from dereferencing
uninitialized pointers?

If mdp_kms_init() fails here, msm_drm_kms_uninit() will be called to clean =
up.
However, if kms->wq was never allocated, won't flush_workqueue(kms->wq)
trigger a panic inside __flush_workqueue() when it attempts to dereference
the workqueue?

Similarly, if initialization fails before kms->funcs is populated,
could msm_irq_uninstall() trigger a NULL pointer dereference when executing
kms->funcs->irq_uninstall(kms)?

Additionally, when kms->funcs->destroy(kms) eventually calls mdp4_destroy(),
would this unconditionally dereference mdp4_kms->dev->dev, where
mdp4_kms->dev remains NULL because mdp_kms_init() failed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-msm-fix-cr=
ash-v1-1-78fb4721c2d9@oss.qualcomm.com?part=3D1
