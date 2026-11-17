Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D07606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHYWXBkg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E273210F156;
	Tue, 17 Nov 2026 16:24:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A72810F306
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:24:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD71C60D71;
 Tue, 17 Nov 2026 16:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382F71F000C4;
 Tue, 17 Nov 2026 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794932653;
 bh=46q7dd3zzH3x8aPEdeF+Zdc3u6MaYe16TlNrz0CsQt0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CHYWXBkg7hPsn3WZ6gt8d50NXvOmCBf8KpA4pcTqiJQD2x6YWvNVXpaa4GR7osUqj
 eeUtMR77/oEUMgnlwHfu89Rs/Tdafe/VEZQ3pOV8+anrcqM9dhfgkjkzul6eetfy6d
 oJM/6UZ4XcsambDuIN/1jeTDxN2PHkBgMQm3ROKOtHWmddVVT8vvMOmdNn6yvSmi/t
 zhCeu6WZzR0mmtxpuXJfgqSlVF/DIfcwrOIQn1WZZuEBiU1rUzIbJ/sN5Yil2hPTuF
 FPVVdMI9qeKkHWwysyZoLQEqIlVlgy4dEjbiyenzhhZNI1S/v3zAzuY7NEwWhr7Plu
 jWXuW3YdF2G9w==
Message-ID: <sashiko-outbox-219166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] wifi: ath12k: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261116162148.2864501-8-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-8-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 16:24:12 +0000
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
- [High] wifi: ath12k: PAS metadata leak in ath12k_ahb_power_up() and
  shared FW load
--

commit dad01e3cbb75f83eee2677fffc757868fad930d0
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

wifi: ath12k: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_=
prepare_and_auth_reset()

This commit replaces qcom_mdt_load() and qcom_pas_auth_and_reset() in
ath12k_ahb_power_up() and ath12k_ahb_load_auth_shared_fw() with
qcom_pas_context_init(), qcom_mdt_pas_load(), and
qcom_pas_prepare_and_auth_reset().

> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless=
/ath/ath12k/ahb.c
> index 2c55aae06dd06..355f1f5509975 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -411,6 +411,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>  	struct ath12k_ahb_rproc_info *rproc_info =3D ab_ahb->rproc_info;
>  	char fw_name[ATH12K_USERPD_FW_NAME_LEN];
>  	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
> +	struct qcom_pas_context ctx;
>  	struct device *dev =3D ab->dev;
>  	const struct firmware *fw, *fw2;
>  	unsigned long time_left;
> @@ -444,14 +445,15 @@ static int ath12k_ahb_power_up(struct ath12k_base *=
ab)
>  		ATH12K_AHB_UPD_SWID;
> =20
>  	/* Load FW image to a reserved memory location */
> -	if (ab_ahb->scm_auth_enabled)
> -		ret =3D qcom_mdt_load(dev, fw, fw_name, pasid, rproc_info->mem_region,
> -				    rproc_info->mem_phys, rproc_info->mem_size,
> -				    NULL);
> -	else
> +	if (ab_ahb->scm_auth_enabled) {
> +		qcom_pas_context_init(&ctx, dev, pasid,
> +				      rproc_info->mem_phys, rproc_info->mem_size);
> +		ret =3D qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
> +	} else {
>  		ret =3D qcom_mdt_load_no_init(dev, fw, fw_name, rproc_info->mem_region,
>  					    rproc_info->mem_phys, rproc_info->mem_size,
>  					    NULL);
> +	}
>  	if (ret) {
>  		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
>  		goto err_fw;
> @@ -485,7 +487,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
> =20
>  	if (ab_ahb->scm_auth_enabled) {
>  		/* Authenticate FW image using peripheral ID */
> -		ret =3D qcom_pas_auth_and_reset(pasid);
> +		ret =3D qcom_pas_prepare_and_auth_reset(&ctx);
>  		if (ret) {
>  			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
>  			goto err_fw2;
> @@ -1023,6 +1025,7 @@ static int ath12k_ahb_load_auth_shared_fw(struct at=
h12k_base *ab,
>  					  struct ath12k_ahb_rproc_info *rproc_info,
>  					  const char *fw_name, u32 pasid)
>  {
> +	struct qcom_pas_context ctx;
>  	int ret;
> =20
>  	const struct firmware *fw __free(firmware) =3D NULL;
> @@ -1041,14 +1044,16 @@ static int ath12k_ahb_load_auth_shared_fw(struct =
ath12k_base *ab,
>  	ath12k_dbg(ab, ATH12K_DBG_AHB, "loading firmware %s, size %zd\n", fw_na=
me,
>  		   fw->size);
> =20
> -	ret =3D qcom_mdt_load(ab->dev, fw, fw_name, pasid, rproc_info->mem_regi=
on,
> -			    rproc_info->mem_phys, rproc_info->mem_size, NULL);
> +	qcom_pas_context_init(&ctx, ab->dev, pasid,
> +			      rproc_info->mem_phys, rproc_info->mem_size);
> +
> +	ret =3D qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
>  	if (ret) {
>  		ath12k_err(ab, "failed to load RO firmware %s: %d\n", fw_name, ret);
>  		return ret;
>  	}
> =20
> -	ret =3D qcom_pas_auth_and_reset(pasid);
> +	ret =3D qcom_pas_prepare_and_auth_reset(&ctx);
>  	if (ret)
>  		ath12k_err(ab, "failed to authenticate and boot shared firmware: %d\n",
>  			   ret);

[Severity: High]
Does this leak the PAS metadata buffer stored in ctx.ptr in both
ath12k_ahb_power_up() and ath12k_ahb_load_auth_shared_fw()?

Previously, qcom_mdt_load() passed a NULL context pointer to
__qcom_mdt_pas_init() -> qcom_pas_init_image(), which caused the backend
to free the metadata buffer immediately.  qcom_mdt_pas_load() instead
passes &ctx to qcom_pas_init_image(), which retains the allocated
metadata buffer in ctx.ptr:

drivers/firmware/qcom/qcom_scm.c:qcom_scm_pas_init_image() {
    ...
	if (ret < 0 || !ctx) {
		dma_free_coherent(dev, size, mdata_buf, mdata_phys);
	} else if (ctx) {
		ctx->ptr =3D mdata_buf;
		ctx->phys =3D mdata_phys;
		ctx->size =3D size;
	}
    ...
}

Neither qcom_mdt_pas_load() nor qcom_pas_prepare_and_auth_reset() frees
this allocation, so ctx goes out of scope and leaks the metadata memory
on every firmware load and error unwind path unless
qcom_pas_metadata_release(&ctx) is called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116162148.2864=
501-1-mukesh.ojha@oss.qualcomm.com?part=3D7
