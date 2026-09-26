Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3FAC9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A21E10E1D7;
	Sat, 26 Sep 2026 15:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XBjZLn1n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DF110E19A
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:59:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFFB841737;
 Sat, 26 Sep 2026 15:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE5D1F000FF;
 Sat, 26 Sep 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790438376;
 bh=CaVQYE4flfS1k/m675Ubhrg/jCvfuE7TBeamQBZlz2k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XBjZLn1nAC65zcNNzm/LlyI0VUATKXcWIAotO4w/o+imz8ez+cYHvNB/JBWP5SJsF
 K1trfxWYDQjt5eLSuNkMZ4QmttCC3L2OSSmE7hyGGD/daWfYYX41B1G1FC5oc4ewi/
 tV6wS1Er5XCSMOVSxYtxjiJWtySSEcAT60QOimRMXge8lZHkALl5ui1+c2Z4+vEiH5
 zGBCdhqTnQzqI6NsJRQwpsnrvbfE/gNVDjTrc1OS7ZnMMW9p/QFLIQHeaI5u/BNcrX
 hQO3re6bTLnjGLPvgBOV/wxKpTWvv8le9Y46SDxHVfWEd437eoMdY8r2bSLRr4ctOa
 eHjjj3nCvKmbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] drm/msm/adreno: migrate zap shader loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260925155737.4161358-3-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:59:36 +0000
Message-Id: <20260926155936.8DE5D1F000FF@smtp.kernel.org>
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
- [High] drm/msm/adreno: memory leak of PAS metadata buffer
- [High] drm/msm/adreno: shmbridge preparation step silently skipped
- [Medium] drm/msm/adreno: struct qcom_pas_context leaked via devres on pos=
t-probe retries
--

commit 4d137953382eb8839541fc9229948a9472d95133
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and qcom_=
pas_prepare_and_auth_reset()

This commit replaces the open-coded memremap/mdt_load sequence for zap shad=
er
loading with devm_qcom_pas_context_alloc and qcom_mdt_pas_load. It then pas=
ses
the context to qcom_pas_prepare_and_auth_reset to ensure the shmbridge
preparation step is executed before TrustZone authentication.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c

[ ... ]

> @@ -122,9 +122,9 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, c=
onst char *fwname,
>  	}
> =20
>  	/* Allocate memory for the firmware image */
> -	mem_region =3D memremap(mem_phys, mem_size,  MEMREMAP_WC);
> -	if (!mem_region) {
> -		ret =3D -ENOMEM;
> +	ctx =3D devm_qcom_pas_context_alloc(dev, pasid, mem_phys, resource_size=
(&r));
> +	if (IS_ERR(ctx)) {
> +		ret =3D PTR_ERR(ctx);

[Severity: High]
Is the shmbridge preparation step actually skipped here?

The commit message mentions fixing the omission of the shmbridge prepare st=
ep.
However, devm_qcom_pas_context_alloc() uses devm_kzalloc() which zeroes the
context, and ctx->use_tzmem is never explicitly set to true in
zap_shader_load_mdt().

Because of this, it looks like qcom_pas_prepare_and_auth_reset() will hit
the early return (if (!ctx->use_tzmem)) downstream and bypass the shmbridge
creation entirely, leaving the behaviour unchanged.

[Severity: Medium]
Can this devm allocation cause an accumulating memory leak during post-prob=
e=20
retries?

Since devm_qcom_pas_context_alloc() ties the allocation to the device
lifetime, if zap_shader_load_mdt() fails and is called multiple times during
runtime PM resume or GPU recovery sequences, the context allocations might
accumulate without being freed since the device remains bound.

>  		goto out;
>  	}
> =20

[ ... ]

> @@ -165,9 +163,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, c=
onst char *fwname,
>  		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
> =20
>  out:
> -	if (mem_region)
> -		memunmap(mem_region);
> -
>  	release_firmware(fw);
> =20
>  	return ret;

[Severity: High]
Does this exit path leak the PAS metadata buffer?

When qcom_mdt_pas_load() executes, it internally calls qcom_pas_init_image(=
),
which allocates a metadata buffer and stores it in ctx->ptr. Unlike the
previous flow with a NULL context where the buffer was immediately freed
internally, a valid context tracks it so the caller can free it.

Should there be a call to qcom_pas_metadata_release(ctx) in this exit path
to prevent leaking this physical memory on every execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155737.4161=
358-1-mukesh.ojha@oss.qualcomm.com?part=3D2
