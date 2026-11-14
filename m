Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC3606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ax1TgDRC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1833310E281;
	Sat, 14 Nov 2026 18:55:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EF310E281
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:54:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2920544F45;
 Sat, 14 Nov 2026 18:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BAF1F000C9;
 Sat, 14 Nov 2026 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682496;
 bh=k/PWYt5BKcLxTCxwmb+rDCIMyhARj3rQglrm4yNmAsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ax1TgDRCj/lTxpWvhH9xGWpvop6ZSbZYu8GBmcmypJYr4h6hLUinFjX+1sR045L7O
 sODkVyZQNPOWn2lsiiwrTPhzEvgd2DoAw5E+0OYiH+Vo93zMS1gUgGdEXswKLP0Mg5
 Cjc2q1rjKA4nIVxXfyum7hAlI/K5RNEk8IdnFv6Ys5RxRIWOZ97Dg5a0pBBlCBGdLx
 3m0K5duzrZiGqMQgcUVoZ4qM1vsk3rLPZ94ge65Fhv0XhuhmMrDxPwi5SB4X4hPqxH
 CqzCHdsUMylF5ClI7AxgFREt2Be669yxFKPTu6vTr20PO3lxevlzWUG0FG9QjdDvgq
 CgUsNFYuFJyVA==
Message-ID: <sashiko-outbox-214914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] drm/msm/adreno: migrate zap shader loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261113185009.157893-4-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
 <20261113185009.157893-4-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:54:55 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/msm/adreno: missing qcom_pas_metadata_release() in
  zap_shader_load_mdt()
--

commit 8918df651bb53ba4326a0ffac4f3a572875b140d
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and qcom_=
pas_prepare_and_auth_reset()

This commit updates zap_shader_load_mdt() to load and authenticate the zap
shader using qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset() with=
 a
stack-allocated struct qcom_pas_context.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index dadfe4c694384..12e35841763d8 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -34,11 +34,11 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, c=
onst char *fwname,
>  	struct device *dev =3D &gpu->pdev->dev;
>  	const struct firmware *fw;
>  	const char *signed_fwname =3D NULL;
> +	struct qcom_pas_context ctx;
>  	struct device_node *np;
>  	struct resource r;
>  	phys_addr_t mem_phys;
>  	ssize_t mem_size;
> -	void *mem_region =3D NULL;
>  	int ret;
> =20
>  	if (!IS_ENABLED(CONFIG_ARCH_QCOM)) {
> @@ -121,39 +121,32 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu,=
 const char *fwname,
>  		goto out;
>  	}
> =20
> -	/* Allocate memory for the firmware image */
> -	mem_region =3D memremap(mem_phys, mem_size,  MEMREMAP_WC);
> -	if (!mem_region) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
> +	qcom_pas_context_init(&ctx, dev, pasid, mem_phys, mem_size);
> =20
>  	/*
>  	 * Load the rest of the MDT
>  	 *
>  	 * Note that we could be dealing with two different paths, since
>  	 * with upstream linux-firmware it would be in a qcom/ subdir..
> -	 * adreno_request_fw() handles this, but qcom_mdt_load() does
> +	 * adreno_request_fw() handles this, but qcom_mdt_pas_load() does
>  	 * not.  But since we've already gotten through adreno_request_fw()
>  	 * we know which of the two cases it is:
>  	 */
>  	if (signed_fwname || (to_adreno_gpu(gpu)->fwloc =3D=3D FW_LOCATION_LEGA=
CY)) {
> -		ret =3D qcom_mdt_load(dev, fw, fwname, pasid,
> -				mem_region, mem_phys, mem_size, NULL);
> +		ret =3D qcom_mdt_pas_load(&ctx, fw, fwname, NULL);
>  	} else {
>  		char *newname;
> =20
>  		newname =3D kasprintf(GFP_KERNEL, "qcom/%s", fwname);
> =20
> -		ret =3D qcom_mdt_load(dev, fw, newname, pasid,
> -				mem_region, mem_phys, mem_size, NULL);
> +		ret =3D qcom_mdt_pas_load(&ctx, fw, newname, NULL);
>  		kfree(newname);
>  	}
>  	if (ret)
>  		goto out;
> =20
>  	/* Send the image to the secure world */
> -	ret =3D qcom_pas_auth_and_reset(pasid);
> +	ret =3D qcom_pas_prepare_and_auth_reset(&ctx);
> =20
>  	/*
>  	 * If the pas call returns -EOPNOTSUPP we assume that this target
> @@ -165,9 +158,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, c=
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
Does this leak the PAS metadata buffer stored in ctx.ptr?

Previously, qcom_mdt_load() passed a NULL PAS context to
__qcom_mdt_pas_init(), so qcom_pas_init_image() freed the metadata buffer
immediately.  Passing &ctx to qcom_mdt_pas_load() causes
qcom_pas_init_image() to retain the allocated metadata buffer in ctx.ptr,
and zap_shader_load_mdt() returns without calling
qcom_pas_metadata_release(&ctx).

Commit 2aa8fafc08e7 ("firmware: qcom: pas: Make MDT buffer retention
explicit") changes qcom_pas_init_image() to release metadata unless
ctx->keep_mdt_buf is set, but this series is based on a tree without that
commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113185009.1578=
93-1-mukesh.ojha@oss.qualcomm.com?part=3D3
