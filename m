Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA4BC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF9310E17B;
	Thu,  3 Sep 2026 18:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sw0DQZFg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26C010E17B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 18:48:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82E3343BC4;
 Thu,  3 Sep 2026 18:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC6C1F000E9;
 Thu,  3 Sep 2026 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788461294;
 bh=es7WXDRXbQDfVhXg/YwzHT9GMNFYZQHqAN7CNSCaBjc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sw0DQZFgtV434/XJLdExVuvHBgowZhL5boyEijyKgNnpXWeoC/KCq+AtMMmIuPUBo
 Lvzm3JLeGK8SCSIlSD81Z/Dtw1H+uy5Y5ZrQHw9pd6R95dVizcJWhHC4P3vLFKqA98
 7c3biUweOqNzkYvwlwDXP7JhKh8+Tj2URyAZSTkpyk1gGJG9zkCuqEBSGbta9uAQoR
 sFfSoJ/E2z+yRo4aSVcJzlkrUDOyVaQMrrAt6v0D1u6SUSXLl1cNUXam0DpiVdGXFS
 8FE3ZP15lI4sZQfWBV9z211INpSzd3tApd+PzpcMsPJV8FjiwuQ4XSCW7k+DgW89mU
 t6IuSMjOWQOag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm: Enable THP for GEM buffers
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903183725.15835-1-robin.clark@oss.qualcomm.com>
References: <20260903183725.15835-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 18:48:13 +0000
Message-Id: <20260903184814.3BC6C1F000E9@smtp.kernel.org>
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
- [High] THP initialization (`msm_gem_thp_init`) occurs after the DRM devic=
e is exposed to userspace via `drm_dev_register`, creating a data race and =
allowing premature access.
- [Low] The module parameter `transparent_hugepage` is defined inside an `#=
ifdef CONFIG_TRANSPARENT_HUGEPAGE` block but accessed unconditionally in `m=
sm_gem_thp_init()`, causing a compilation error when the config is disabled.
--

commit 46b2b6fe3a31a0213c502585828f1edd5794c935
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Enable THP for GEM buffers

This commit introduces a dedicated tmpfs mount point for Transparent
Hugepage support in MSM GEM buffers to improve page allocation performance.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index db1b655dd055b..33b9f495af020 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
[ ... ]
> @@ -58,9 +58,29 @@ static bool separate_gpu_kms;
>  MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the GPU =
(0=3Dsingle DRM device for both GPU and display (default), 1=3Dtwo DRM devi=
ces)");
>  module_param(separate_gpu_kms, bool, 0400);
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static bool transparent_hugepage =3D true;
> +module_param(transparent_hugepage, bool, 0400);
> +MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount poin=
t with Transparent Hugepage enabled (true =3D default)");
> +#endif
> +
>  DECLARE_FAULT_ATTR(fail_gem_alloc);
>  DECLARE_FAULT_ATTR(fail_gem_iova);
> =20
> +static void msm_gem_thp_init(struct drm_device *dev)
> +{
> +	int err;
> +
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && !transparent_hugepage)

[Severity: Low]
Will this cause a build failure when CONFIG_TRANSPARENT_HUGEPAGE is disable=
d?
The transparent_hugepage module parameter is only defined inside the ifdef =
block
just above, but the C compiler will still evaluate it unconditionally here =
in
msm_gem_thp_init(), resulting in an undeclared identifier error.

> +		return;
> +
> +	err =3D drm_gem_huge_mnt_create(dev, "within_size");
> +	if (drm_gem_get_huge_mnt(dev))
> +		drm_info(dev, "Using Transparent Hugepage\n");
> +	else if (err)
> +		drm_warn(dev, "Can't use Transparent Hugepage (%d)\n", err);
> +}
[ ... ]
> @@ -178,6 +198,8 @@ static int msm_drm_init(struct device *dev, const str=
uct drm_driver *drv,
>  	if (priv->kms_init)
>  		msm_drm_kms_post_init(dev);
> =20
> +	msm_gem_thp_init(ddev);

[Severity: High]
Is it safe to initialize the THP mount point here?

Looking earlier in msm_drm_init(), drm_dev_register(ddev, 0) is called befo=
re
this point. Because the device node is already exposed to userspace, a proc=
ess
could open it immediately after registration.=20

If userspace starts allocating GEM objects before msm_gem_thp_init() comple=
tes,
could this race condition cause the allocations to silently fall back to no=
n-THP
shmem, or potentially lead to a crash if a partially written pointer is rea=
d?

> +
>  	return 0;
> =20
>  err_msm_uninit:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903183725.1583=
5-1-robin.clark@oss.qualcomm.com?part=3D1
