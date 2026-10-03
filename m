Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6606DCA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50BC10E72B;
	Sat,  3 Oct 2026 01:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bo3WcuKq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D31A10E727
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:34:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4AAA60D9B;
 Sat,  3 Oct 2026 01:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504BF1F00893;
 Sat,  3 Oct 2026 01:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991271;
 bh=BV+rzcyP5EkFJzvJNX9STan0xdjUSXVk3JynaiPOxT0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bo3WcuKq/Sx1bYj3FMBCJ4xdISY/lu/XZfgXQLEAgfBWH5BUdVY3WFuSI8modxHGC
 hTP4AarQfICZaLFAzhgRz8HenPyaFk9eFFQTgLCKO1oXTLz3/ab9J8/KES+Nla0+5Y
 Ysu573KKphVJHXBpOm5Fj8Q4bf4TT++mCa0yb/UcM5sE6ZweCoxQtooBVlG/wm0vBs
 cphZ9EZoBDkVA8kIbp6Ws/xc3EC7pXU4nEeO4LIy8TsznX1dKiwqr+Kga0HuPEyQop
 fUuSbj7wrauToVG9nuh9dmYJBn3d3rS4gX7sBk1VaT/lHOUPdqQD7KYShUAKrKz2Sv
 0R9jZD4eN7rEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] drm/msm/dpu: unwind a failed dpu_kms_hw_init()
 step by step
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-9-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
 <20261003-msm-kms-destroy-fixes-v1-9-e062b7dae77f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:30 +0000
Message-Id: <20261003013431.504BF1F00893@smtp.kernel.org>
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
- [High] drm/msm/dpu: use-after-free on hw_vbif during bind retry
--

commit 010fe925950b01a30ca06eec05c2a4db435b69ed
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dpu: unwind a failed dpu_kms_hw_init() step by step

This commit replaces the blanket _dpu_kms_hw_destroy() call in the error
path of dpu_kms_hw_init() with step-by-step unwinding. Only the completed
steps are undone, in reverse order.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index 65ba8fa697e94..2de4d881d13d9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
[ ... ]
> @@ -1263,7 +1263,7 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_kms)
>  	rc =3D _dpu_kms_drm_obj_init(dpu_kms);
>  	if (rc) {
>  		DPU_ERROR("modeset init failed: %d\n", rc);
> -		goto err_pm_put;
> +		goto err_mmu_destroy;
>  	}
> =20
>  	dpu_vbif_init_memtypes(dpu_kms);
> @@ -1272,10 +1272,12 @@ static int dpu_kms_hw_init(struct dpu_kms *dpu_km=
s)
> =20
>  	return 0;
> =20
> +err_mmu_destroy:
> +	_dpu_kms_mmu_destroy(dpu_kms);

[Severity: High]
If initialization fails after dpu_kms->hw_vbif is allocated, such as when
_dpu_kms_drm_obj_init() fails, the error path jumps to err_mmu_destroy. Can
this regression leave a dangling pointer in dpu_kms->hw_vbif?

Since the memory for dpu_kms->hw_vbif is allocated via drmm, it will be fre=
ed
when the component bind fails and the DRM device is torn down. However,
dpu_kms itself persists because it is allocated via devm.

Could a subsequent bind retry trigger a use-after-free?

When a deferred probe or bind retry occurs, dpu_kms_hw_init() calls
pm_runtime_resume_and_get(), which triggers the runtime PM resume callback
and accesses the dangling pointer:

dpu_runtime_resume()
  dpu_vbif_init_memtypes()
    vbif =3D dpu_kms->hw_vbif;
    if (vbif && vbif->cap && ...)=20

This would result in a use-after-free on the previously freed vbif memory.

Is it necessary to explicitly clear dpu_kms->hw_vbif in the unwind path to
prevent it from being accessed during bind retries?

>  err_pm_put:
>  	pm_runtime_put_sync(&dpu_kms->pdev->dev);
> -error:
> -	_dpu_kms_hw_destroy(dpu_kms);
> +err_global_obj_fini:
> +	dpu_kms_global_obj_fini(dpu_kms);
> =20
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-msm-kms-de=
stroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com?part=3D9
