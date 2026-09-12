Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD434C88E59
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0192110E727;
	Sat, 12 Sep 2026 15:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nMbo1N5K";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE93310E722
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:12:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12DDD60232;
 Sat, 12 Sep 2026 15:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A854E1F000FF;
 Sat, 12 Sep 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789225959;
 bh=6zHvN+WY82rvpGOUXxHX8lnX30XyCYGojvjUrpir+/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nMbo1N5K6812JoCMOuatKWEBox/RAmUGmPJe5gjqUHjE5LgBky+RsE4Pih4SV0E7r
 pGlVF7OIb6kzH4HRFJg9uOSj+Qp8M3XOJBYbtfChB1wB4z8j7/Spu3ww077MyCJU0X
 D8y7ZuE3f/nH2uPJ7vk8ipjV6P85Z9gu0kOW/K1Fk3Qw0DTlU+sScIfKDZCl/38J+1
 uGnthx4yyL72GMEWxnx+I2+o/xis7hT7Lq7R9l13l34UV/qILyLKVI9bqisrsVsYIq
 tyT2Gs0hNTuWaBSaaoFgSTdx3O3VDYyOJgQIxLxyDOQBDpuXVxohe9DuFtgdMLY6m9
 /HNApQS5+ikhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/msm: Enable THP for GEM buffers
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
References: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 15:12:39 +0000
Message-Id: <20260912151239.A854E1F000FF@smtp.kernel.org>
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
- [High] Unchecked ERR_PTR and dangling pointers from drm_gem_huge_mnt_crea=
te cause catastrophic GEM allocation failures or Use-After-Free.
--

commit cb4549ef63304d3139dafdf100bc5423a484100d
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Enable THP for GEM buffers

This patch enables Transparent Hugepage (THP) support for GEM buffers in the
MSM DRM driver by introducing a module parameter and initializing it during
device setup.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index db1b655dd055b..b96bad6e154a6 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -58,9 +58,31 @@ static bool separate_gpu_kms;

[ ... ]

> +static void msm_gem_thp_init(struct drm_device *dev)
> +{
> +	int err;
> +
> +	if (!transparent_hugepage)
> +		return;
> +
> +	err =3D drm_gem_huge_mnt_create(dev, "within_size");
> +	if (drm_gem_get_huge_mnt(dev))
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
This is a pre-existing issue, but does this correctly handle error returns
from drm_gem_huge_mnt_create()?

If drm_gem_huge_mnt_create() fails, it can leave an ERR_PTR or a dangling
pointer in dev->huge_mnt. Because this code evaluates the truthiness of
drm_gem_get_huge_mnt(dev) before checking the err variable, it will
evaluate to true for these error pointers and falsely indicate success.

Later, when drm_gem_object_init() passes this invalid pointer to
shmem_file_setup_with_mnt(), it can lead to a use-after-free or continuous
allocation failures. Should this code check for IS_ERR() or check the err
variable first before assuming the mount was successful?

> +		drm_info(dev, "Using Transparent Hugepage\n");
> +	else if (err)
> +		drm_warn(dev, "Can't use Transparent Hugepage (%d)\n", err);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912145922.2411=
5-1-robin.clark@oss.qualcomm.com?part=3D1
