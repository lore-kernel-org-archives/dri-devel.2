Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F2606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCo2J2/w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C0410E5FA;
	Tue, 17 Nov 2026 16:24:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D18910EF55
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:24:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9515360F8D;
 Tue, 17 Nov 2026 16:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213E21F000C4;
 Tue, 17 Nov 2026 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794932651;
 bh=ARlof54HBuvMbxqKtVIqoJkff/Hsnei/1eYBlF+JXEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oCo2J2/wWlPRPwSWz5lw4JCFhseBKqnyPdEdSdKJSqBlB9gc2IlJjU3FmQX8+qmEV
 BlDPWDt0Uk+zYtOADe8Hu9XlRp01sZAcQkI4rwyNCnHM9THSunbJSpbLLnrJjfwu49
 stFPvvQY1JTDdLCg3wQL0sGPG/10PeePS0qfxuCOxhzd1NYkje84S7+l+SIWFlsa/N
 lPjKhQ/e9Wh/xteeKo8d0bpAc0K+50FyNJ0comyuE/2o5dcLmYgV2H5HryEloiI/6t
 ownMNW5HcEF4dvMrCEGVHSAu4x2aV9WkyjaK9yH33jZ9fSDaejDWru6KV29dfVnPvk
 phLLg9PzLGrtA==
Message-ID: <sashiko-outbox-219163@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261116162148.2864501-5-mukesh.ojha@oss.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-5-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 16:24:10 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] media: iris: missing qcom_pas_metadata_release() in
  iris_fw_load()
- [Medium] media: iris: unzeroed carveout memory scanned by
  iris_detect_firmware()
- [Low] media: iris: missing kernel-doc entry for pas_ctx in struct
  iris_core
--

commit 06c574841baf80a5b2f096e918c8cad3e79ad9f0
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

media: iris: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_p=
repare_and_auth_reset()

This commit embeds a struct qcom_pas_context in struct iris_core and
migrates Iris firmware loading from qcom_mdt_load() and
qcom_pas_auth_and_reset() to qcom_mdt_pas_load() and
qcom_pas_prepare_and_auth_reset().

> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media=
/platform/qcom/iris/iris_core.h
> index 3e4cf652bf39a..ac73bda072f85 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.h
> +++ b/drivers/media/platform/qcom/iris/iris_core.h
[ ... ]
> @@ -129,6 +130,7 @@ struct iris_core {
>  	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
>  	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
>  	struct dma_iova_state			*iova_state;
> +	struct qcom_pas_context			pas_ctx;
>  };

[Severity: Low]
struct iris_core has a kernel-doc comment block describing its members, so
adding pas_ctx without an @pas_ctx entry will trigger a kernel-doc warning.

> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/m=
edia/platform/qcom/iris/iris_firmware.c
> index 21f57d37da187..b701a7f43514b 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -201,21 +201,20 @@ static int iris_load_fw_to_memory(struct iris_core =
*core)
>  		goto err_release_fw;
>  	}
> =20
> -	mem_virt =3D memremap(mem_phys, res_size, MEMREMAP_WC);
> -	if (!mem_virt) {
> -		ret =3D -ENOMEM;
> -		goto err_release_fw;
> -	}
> -
> -	memset(mem_virt, 0, res_size);
> -
> -	ret =3D qcom_mdt_load(dev, firmware, fw_name,
> -			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
> +	qcom_pas_context_init(&core->pas_ctx, dev, IRIS_PAS_ID, mem_phys,
> +			      res_size);
> +
> +	ret =3D qcom_mdt_pas_load(&core->pas_ctx, firmware, fw_name, NULL);
> +	if (!ret) {
> +		mem_virt =3D memremap(mem_phys, res_size, MEMREMAP_WC);
> +		if (!mem_virt) {
> +			ret =3D -ENOMEM;
> +			goto err_release_fw;
> +		}
> =20
> -	if (!ret)
>  		iris_detect_firmware(core, fw_name, mem_virt, res_size, desc);
> -
> -	memunmap(mem_virt);
> +		memunmap(mem_virt);
> +	}

[Severity: Medium]
Can removing memset(mem_virt, 0, res_size) cause iris_detect_firmware() to
scan uninitialized carveout memory?

qcom_mdt_pas_load() -> qcom_mdt_load_no_init() only populates individual
PT_LOAD segments and their BSS tails, leaving inter-segment gaps and the
trailing [fw_size, res_size) region untouched.  When iris_detect_firmware()
subsequently scans all res_size bytes via iris_detect_gen2_from_fwdata() on
a dual-generation platform with a firmware-name override, stale data in the
unwritten carveout (for example after a warm reboot or prior Gen2 load) can
cause a smaller Gen1 firmware image to be misclassified as Gen2.

[ ... ]

> @@ -233,7 +232,7 @@ int iris_fw_load(struct iris_core *core)
>  		return ret;
>  	}
> =20
> -	ret =3D qcom_pas_auth_and_reset(IRIS_PAS_ID);
> +	ret =3D qcom_pas_prepare_and_auth_reset(&core->pas_ctx);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;

[Severity: High]
As reported by Konrad Dybcio on v1 [1], does this leak the PAS metadata
buffer stored in core->pas_ctx.ptr?

Unlike qcom_mdt_load(), which passes a NULL context to
__qcom_mdt_pas_init(), qcom_mdt_pas_load() passes &core->pas_ctx to
qcom_pas_init_image(), which retains the allocated DMA or TEE metadata
buffer in core->pas_ctx.ptr:

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

Neither qcom_pas_prepare_and_auth_reset() nor iris_firmware.c calls
qcom_pas_metadata_release(&core->pas_ctx), so the metadata buffer is leaked
on every firmware load (and overwritten when qcom_pas_context_init() zeroes
core->pas_ctx on subsequent loads or error recovery).

[1] https://lore.kernel.org/r/ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qual=
comm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116162148.2864=
501-1-mukesh.ojha@oss.qualcomm.com?part=3D4
