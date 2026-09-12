Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E932CC88E59
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 13:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170F510E407;
	Sat, 12 Sep 2026 13:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NpvmFygT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2498C10E407
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 13:33:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48290601F1;
 Sat, 12 Sep 2026 13:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63651F00893;
 Sat, 12 Sep 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789219992;
 bh=Gvx6QhVraRpiBr2J8lwdLKeOENPa2T+wMxqscuWJvfo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NpvmFygTkfD0D4YzpfT+q/FERVZIVAWp1C96uV3X6KGlhEWSNi0Rz9AaSMv39Y+5c
 XjOzCHnr/vNaGR+IB5+1IGdM/Ya0ltSN31sFLlpegpsNvuS2Ky9zcAu9tVKJP8ThoR
 W8dg+Fi6KFoTQWw6IOLG5zSxQnMQVeyAbHd1k725OEg+eU+/cjIGEPRogpGqP1AUbO
 d0DTeL8Kt/KmUQCFkqatV4rmLo93VLBZRoc16Qarav5QQ6ffr4E3zuSo3Px5c6oyYV
 mw/VjxKtPZQe3/BwycNAixhhckmy4hF2JIdeOVsXrUKEc90eAzlGtb3OB4mwRzhLun
 x3JAh4gbUqi7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] drm/msm: unwind msm_drm_kms_init() on failure
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-3-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
 <20260912-fd-kms-fix-smmu-v3-3-a7ddc6fe2032@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 13:33:11 +0000
Message-Id: <20260912133311.D63651F00893@smtp.kernel.org>
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
- [High] msm_disp_snapshot_destroy() unconditionally passes an ERR_PTR to k=
thread_destroy_worker() if kthread creation failed.
- [High] destroy_workqueue() is called on a potentially NULL kms->wq when m=
sm_kms_init() fails.
- [High] Double destruction of DRM private object state if hw_init fails.
--

commit 972acdabb4a5813d8316cd0796e9b9df36ce8dff
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: drm/msm: unwind msm_drm_kms_init() on failure

This commit updates the error unwinding in msm_drm_kms_init() and
msm_drm_init() to avoid calling the full teardown process when early
initialization steps fail. It undoes only the steps which have successfully
completed.

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> @@ -328,14 +334,20 @@ int msm_drm_kms_init(struct device *dev, const stru=
ct drm_driver *drv)
>  	pm_runtime_put_sync(dev);
>  	if (ret < 0) {
>  		DRM_DEV_ERROR(dev, "failed to install IRQ handler\n");
> -		goto err_msm_uninit;
> +		goto err_destroy_event_threads;
>  	}
> =20
>  	drm_mode_config_reset(ddev);
> =20
>  	return 0;
> =20
> -err_msm_uninit:
> +err_destroy_event_threads:
> +	msm_drm_kms_destroy_event_threads(kms);
> +err_destroy_kms:
> +	msm_disp_snapshot_destroy(ddev);

[Severity: High]
This is a pre-existing issue, but does this error path lead to a kernel=20
panic?=20

If kthread_run_worker fails in msm_disp_snapshot_init, it stores an ERR_PTR=
=20
in kms->dump_worker but returns success. When we hit this error path and ca=
ll=20
msm_disp_snapshot_destroy, it evaluates if (kms->dump_worker) which is true=
=20
for an ERR_PTR, and passes the error pointer directly to=20
kthread_destroy_worker, leading to an invalid memory dereference.

> +	if (kms->funcs)
> +		kms->funcs->destroy(kms);

[Severity: High]
This is also a pre-existing issue, but could this cause a NULL pointer=20
dereference if the workqueue failed to allocate?

If alloc_ordered_workqueue fails earlier in msm_kms_init, kms->wq is NULL=20
but kms->funcs is already assigned. This error propagates up, jumping to=20
err_destroy_kms, and we call kms->funcs->destroy here. That delegates to=20
msm_kms_destroy, which unconditionally calls destroy_workqueue(kms->wq)=20
without checking if the workqueue was actually allocated.

[Severity: High]
Additionally, this is a pre-existing issue, but can this lead to a double=20
free and list corruption in the DPU driver?

If dpu_kms_hw_init fails, it internally cleans up by calling=20
_dpu_kms_hw_destroy. This invokes drm_atomic_private_obj_fini to remove=20
the private object from its list via list_del. The error propagates to=20
msm_drm_kms_init, we jump to err_destroy_kms, and execute this destroy=20
callback. This resolves to dpu_kms_destroy, which calls=20
_dpu_kms_hw_destroy a second time and executes list_del on a poisoned=20
list head.

> +
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-fd-kms-fix=
-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com?part=3D3
