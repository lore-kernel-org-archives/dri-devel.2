Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D6DC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58AC10E5BB;
	Fri,  3 Jul 2026 12:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d1p5DJtE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4BE10E5BB
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB0C46001A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101971F000E9;
 Fri,  3 Jul 2026 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080159;
 bh=XJhoqtd+XutQZMwJdnD8usqZSwYWXDGcrDFKt/cuKCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d1p5DJtEVbdyTioR5+QMpYmqo6VLyhMMI1B8Uot6GSf6A5lBx1DawbaxUIHRcHR9B
 qL5Pbva7ClpXPJUYn7ZPondXmHoWUiLfh+idbw2gmFGfGuNkPkcLPdOTauzjLBGl1m
 VKLJofi9RmKKbeG84d6CQ+FMxDgzsNH0Ht4e+P1q8nl3KUPT71UEaaoCyADQZnXVAf
 IbjkAuXhPHrZUmzUoqoEdHkt+RLAWDodwCsZmgEtvi0Q4MqsInKtXTihe8sGYRku/i
 xVi7OZHRKymXwdLgItswiFy6gNXIgfSUTOVOWmsQ1w3Ny9tHR3jsfUR/NesVUtfHPo
 kyNljEawMpAdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/14] drm/msm: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-9-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-9-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:38 +0000
Message-Id: <20260703120239.101971F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Generic PAS TEE backend maps TA-level errors to -EINVAL, breaking =
the DRM MSM fallback logic.
- [High] TOCTOU race condition in generic PAS API wrappers leading to NULL =
pointer dereference.
- [High] Unconditional PAS availability check causes infinite probe deferra=
l on platforms without PAS support.

Pre-existing issues:
- [High] The MSM DRM driver propagates -EOPNOTSUPP instead of -ENODEV, fata=
lly failing GPU initialization.
--

commit fd17ff54a9520d92288105f263b3bc29eb9cbd4b
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

drm/msm: Switch to generic PAS TZ APIs
   =20
Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index c62c45bb0ddbb..489462065ea95 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c

[ ... ]

> @@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu,=
 const char *fwname,
>  		goto out;
> =20
>  	/* Send the image to the secure world */
> -	ret =3D qcom_scm_pas_auth_and_reset(pasid);
> +	ret =3D qcom_pas_auth_and_reset(pasid);

[Severity: High]
Does this new PAS API wrapper have a TOCTOU race condition?

If the PAS backend unregisters concurrently, could ops_ptr become NULL
between the check and the dereference in qcom_pas_auth_and_reset()?

drivers/firmware/qcom/qcom_pas.c:qcom_pas_auth_and_reset() {
	if (!ops_ptr)
		return -ENODEV;

	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
}

> =20
>  	/*
> -	 * If the scm call returns -EOPNOTSUPP we assume that this target
> +	 * If the pas call returns -EOPNOTSUPP we assume that this target
>  	 * doesn't need/support the zap shader so quietly fail
>  	 */
>  	if (ret =3D=3D -EOPNOTSUPP)

[Severity: High]
Is the DRM MSM fallback logic preserved with this generic backend?

The driver expects -EOPNOTSUPP to gracefully handle unsupported zap shaders.

If the generic PAS TEE backend's __qcom_pas_tee_auth_and_reset()
unconditionally maps all TA errors to -EINVAL, will this cause GPU probe
to fail fatally on TEE platforms where the zap shader is not supported?

drivers/firmware/qcom/qcom_pas_tee.c:__qcom_pas_tee_auth_and_reset() {
	ret =3D tee_client_invoke_func(data->ctx, &inv_arg, param);
	if (ret < 0 || inv_arg.ret !=3D 0) {
		...
		return ret ?: -EINVAL;
	}
}

[Severity: High]
This isn't a bug introduced by this patch, but does this function propagate
-EOPNOTSUPP instead of -ENODEV?

If qcom_pas_auth_and_reset() returns -EOPNOTSUPP, the code sets
zap_available =3D false but leaves ret =3D -EOPNOTSUPP.

Since callers explicitly check for -ENODEV to fall back to
SECVID_TRUST_CNTL, could this unmapped -EOPNOTSUPP abort hardware
initialization?

>  		zap_available =3D false;
>  	else if (ret)
>  		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");

[ ... ]

> @@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 p=
asid)
>  	if (!zap_available)
>  		return -ENODEV;
> =20
> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "PAS is not available\n");
>  		return -EPROBE_DEFER;
>  	}

[Severity: High]
Could this unconditional PAS availability check cause infinite probe
deferral on platforms without PAS support?

By checking qcom_pas_is_available() before checking if the zap-shader DT
node exists (which happens inside zap_shader_load_mdt()), do platforms
that lack PAS capabilities fail to reach the DT node check and defer
indefinitely?

Previously, qcom_scm_is_available() returned true on these platforms,
allowing the driver to gracefully return -ENODEV when the DT node was
missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D8
