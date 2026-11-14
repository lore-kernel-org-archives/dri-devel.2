Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D87606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anZdYjkg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D3110E590;
	Sat, 14 Nov 2026 18:55:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB0C10E2BB
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:54:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9EA2459BE;
 Sat, 14 Nov 2026 18:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A221F000C5;
 Sat, 14 Nov 2026 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794682496;
 bh=Hu9Lw7r+aHyF1TEr76uiSPI9fladcuG5BJV7gD6A5DM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=anZdYjkgillV4DJPQJDqUjaqDfrEETwmxWUz1nGjuddJv9trcbXWid9ryOByFTYa+
 GHaRWgL0hO+AidDsyxoc5VqE23OLk+JKroh4tBTY52XWYrSCawe2bC3a2e8/EJH9yA
 t5ufv9WU51M1zLSZ5MRMGb/f3eqQd93Urh3x2wAZU/8HO2S08QvmheNLQWhPxdnUWX
 r4dRtjhdGHoErPDm3Kq7fcobRY2GPRyoXnwb2UePVKdIHwkwj3Z60UtH3ZgX7A9AXW
 Mn3ZVTu7ZugB00n3YrRg1JzCi8FfW2eKKGGZN6+Gbfu97nNU7BSI2DAor1zXP7jaZQ
 lbdC+u5SzWfCQ==
Message-ID: <sashiko-outbox-214915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261113185009.157893-5-mukesh.ojha@oss.qualcomm.com>
References: <20261113185009.157893-1-mukesh.ojha@oss.qualcomm.com>
 <20261113185009.157893-5-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:54:56 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] media: iris: unzeroed carveout scanned by
  iris_detect_firmware()
- [Low] media: iris: missing kernel-doc entry for pas_ctx in struct
  iris_core
--

commit 7ebe09aa487374b06a38922ce80ef4d57f96da6a
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

media: iris: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_p=
repare_and_auth_reset()

This commit embeds a struct qcom_pas_context in struct iris_core and
migrates iris firmware loading and authentication to qcom_mdt_pas_load()
and qcom_pas_prepare_and_auth_reset().

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
> =20
>  int iris_core_init(struct iris_core *core);

[Severity: Low]
This isn't a bug, but struct iris_core has a kernel-doc comment block
that lacks an @pas_ctx entry, which causes a W=3D1 kernel-doc warning.

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
Can iris_detect_firmware() scan uninitialized carveout memory now that
memset(mem_virt, 0, res_size) is removed?

qcom_mdt_pas_load() calls qcom_mdt_load_no_init(), which only writes each
PT_LOAD segment and zeroes its BSS tail, leaving inter-segment gaps and
the trailing [fw_size, res_size) portion of the reserved memory region
untouched.  When a dual-generation platform uses a DT firmware-name
override to load a Gen1 image, iris_detect_firmware() ->
iris_detect_gen2_from_fwdata() scans the entire res_size mapping and can
match stale bytes in the unwritten carveout (for example after a warm
reboot or kexec), misclassifying the Gen1 firmware as Gen2 and selecting
incompatible HFI operations and buffer-sizing callbacks.  Commit
a9ff61527805 ("media: iris: Add Gen2 firmware autodetect and fallback")
added the memset() specifically to avoid scanning stale data across
res_size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113185009.1578=
93-1-mukesh.ojha@oss.qualcomm.com?part=3D4
