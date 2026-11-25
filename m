Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E79606A330
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEkurMEw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1963D10FBF2;
	Wed, 25 Nov 2026 11:59:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013B810FBF2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:59:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B67FA45EC1;
 Wed, 25 Nov 2026 11:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F5F1F0089F;
 Wed, 25 Nov 2026 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795607955;
 bh=pT4w/2V+q5Vq1P7jobZdTaAEMqWVdX82CGH5VChTN0E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lEkurMEwRDzpqu8ExXzRid5vRwc6/LiXdW2nLPy+alawIklxUSomOoW9ADIZ/3PgX
 T+a20/0tgkC4Lclu2AxEqfxAjt2bgW74yL6g1qLDRPlsAbR/vvsDy0x9YuusI2kkGP
 LLZydYDxwicvObalKa4oaFNn2unOurmGfGNMcYcuzcRozicR2lEmm0f+mxavu4To7t
 NzWCI/kLoiHPD+c3adVyZ38pWWFUSIoqIOG8kIZEGzmHTVPr9GF+pyeALkfG22e5ty
 oe1aS7Jip1HyVvf5PtpYorV6kVClM9S1FQhm6VpJ7CmGdXDqDpCv15gwDEqzA1wmTg
 rItL155U4ko7A==
Message-ID: <sashiko-outbox-233307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] drm/imagination: Release firmware after init
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-4-69657fa52ac3@imgtec.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
 <20261125-b4-commonize-fw-segment-loading-v1-4-69657fa52ac3@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:59:15 +0000
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
- [Medium] drm/imagination: memory leak of fw_dev.metadata on GPU init
  error paths
--

commit 8d2db63e357e744b233475780670c4fc83790aca
Author: Matt Coster <opensource@mtcoster.net>

drm/imagination: Release firmware after init

This commit stops storing struct firmware in pvr_fw_device and instead
passes it through the initialization functions and releases it at the end
of pvr_device_gpu_init().

> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/i=
magination/pvr_device.c
> index 0c4832d2cce1b..210eeb91f4ecf 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c

[ ... ]

> @@ -701,40 +691,52 @@ pvr_device_info_validate(struct pvr_device *pvr_dev)
>  static int
>  pvr_device_gpu_init(struct pvr_device *pvr_dev)
>  {
> +	const struct firmware *firmware;
>  	int err;
> =20
>  	err =3D pvr_load_gpu_id(pvr_dev);
>  	if (err)
>  		return err;
> =20
> -	err =3D pvr_request_firmware(pvr_dev);
> -	if (err)
> -		return err;
> +	firmware =3D pvr_request_firmware(pvr_dev);
> +	if (IS_ERR(firmware))
> +		return PTR_ERR(firmware);
> =20
> -	err =3D pvr_fw_load_metadata_and_device_info(pvr_dev);
> +	err =3D pvr_fw_load_metadata_and_device_info(pvr_dev, firmware);
>  	if (err)
> -		return err;
> +		goto out_release_firmware;
> =20
> -	if (PVR_HAS_FEATURE(pvr_dev, meta))
> +	if (PVR_HAS_FEATURE(pvr_dev, meta)) {
>  		pvr_dev->fw_dev.processor_type =3D PVR_FW_PROCESSOR_TYPE_META;
> -	else if (PVR_HAS_FEATURE(pvr_dev, mips))
> +	} else if (PVR_HAS_FEATURE(pvr_dev, mips)) {
>  		pvr_dev->fw_dev.processor_type =3D PVR_FW_PROCESSOR_TYPE_MIPS;
> -	else if (PVR_HAS_FEATURE(pvr_dev, riscv_fw_processor))
> +	} else if (PVR_HAS_FEATURE(pvr_dev, riscv_fw_processor)) {
>  		pvr_dev->fw_dev.processor_type =3D PVR_FW_PROCESSOR_TYPE_RISCV;
> -	else
> -		return -EINVAL;
> +	} else {
> +		err =3D -EINVAL;
> +		goto out_release_firmware;
> +	}
> =20
>  	err =3D pvr_device_info_validate(pvr_dev);
>  	if (err)
> -		return err;
> +		goto out_release_firmware;
> =20
>  	pvr_stream_create_musthave_masks(pvr_dev);
> =20
>  	err =3D pvr_set_dma_info(pvr_dev);
>  	if (err)
> -		return err;
> +		goto out_release_firmware;
> =20
> -	return pvr_fw_init(pvr_dev);
> +	err =3D pvr_fw_init(pvr_dev, firmware);
> +	if (err)
> +		goto out_release_firmware;
> +
> +	err =3D 0;
> +
> +out_release_firmware:
> +	release_firmware(firmware);
> +
> +	return err;
>  }

[Severity: Medium]
Do the error paths here leak pvr_dev->fw_dev.metadata?

pvr_fw_load_metadata() allocates metadata with kzalloc_flex() and
pvr_fw_load_metadata_and_device_info() assigns it to
pvr_dev->fw_dev.metadata before calling pvr_fw_get_device_info().  If
pvr_fw_get_device_info() or any later step in pvr_device_gpu_init()
such as pvr_fw_init() fails, pvr_device_init() jumps past
pvr_device_gpu_fini(), so pvr_fw_free_metadata_and_device_info() is
never called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-b4-commoni=
ze-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com?part=3D4
