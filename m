Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391DFC43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E8D10E4DE;
	Sat, 27 Jun 2026 13:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mER2w5Fa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF62D10E4DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBB946001A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B321F000E9;
 Sat, 27 Jun 2026 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567747;
 bh=erjGDge6p0mhDGvNF2URJwNrrQsyqC/iXpnSWVBaEsY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mER2w5FaBh9lxIx411q+7GkfNY4hdciXV1dIIxqpPYKLnp/V9G1PQyXFKcvWk68Wx
 7ESdELmVZc4j8nTe7BlqKAUqxaMFBEgaHWAjOwXuqmSWMPWNTfB0fr278+rn8zkk1C
 cwA2U6IkKLuSR0BTDz88CmrRGVffdfW4RuPlyfDlZO/1Cf0MbbswZGqX7mR8oqVcNx
 181eiKgfuBDnNWCjeSktGG1mor7EXtRwZsudRoueHA6Ukq/lY2A0LRVTGUzDfSFesP
 H0M0EJzjUjSQYf3QXpVudTla1A/tUHGkzbWk1txneBZI2ey/PifKFBzV86pg2i6Zh9
 BN7ymkCjQ/Vcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/14] drm/msm: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-9-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-9-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:26 +0000
Message-Id: <20260627134227.41B321F000E9@smtp.kernel.org>
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
- [High] Infinite probe deferral on platforms without PAS firmware support.
- [High] TOCTOU race leading to NULL pointer dereference or UAF due to lock=
less `ops_ptr` access in the generic PAS wrappers.
--

commit 58fde983bce7410af49e9cbf67e95a22f4ec47cb
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

drm/msm: Switch to generic PAS TZ APIs

Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS TZ
service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index c62c45bb0ddbb..c36382b23310a 100644
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
Does this new PAS API wrapper introduce a race condition?

Looking at qcom_pas_auth_and_reset() in drivers/firmware/qcom/qcom_pas.c, it
evaluates ops_ptr without try_module_get() or RCU protection:

int qcom_pas_auth_and_reset(u32 pas_id)
{
	if (!ops_ptr)
		return -ENODEV;

	return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
}

If the backend module (like qcom-pas-tee) is unloaded concurrently, could
ops_ptr become NULL after the check but before the dereference, leading to
a NULL pointer dereference or use-after-free?

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
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
>  		return -EPROBE_DEFER;
>  	}

[Severity: High]
Will this cause an infinite probe deferral on platforms without PAS firmware
support?

If a platform lacks both a zap shader node in the device tree and PAS
firmware support, qcom_pas_is_available() will return false. This causes
an immediate -EPROBE_DEFER before we can reach zap_shader_load_mdt(), which
is where we would normally check the device tree and gracefully return
-ENODEV.

With the previous qcom_scm implementation, the SCM subsystem would probe
and be available, allowing this check to pass so the code could proceed to
the graceful fallback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D8
