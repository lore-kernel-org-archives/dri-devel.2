Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DFAC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F0D10EC87;
	Wed, 22 Jul 2026 07:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nm8u9tDX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920CF10EC87
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:04:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE9EC60A65;
 Wed, 22 Jul 2026 07:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6851F00A3A;
 Wed, 22 Jul 2026 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703860;
 bh=idFMjNdiu33sK+rOuEyxc2EEPdiZxnoMBb7N/WS1IWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nm8u9tDXptReHv1jIyiYqK7+RnsAyDio0adyyjy7n9O0L2ZbsonvGERn6kiTCvEsH
 ijCQssqs0TkGFyCUN9186C7ZELBe1EX4AkDM+t0iWUmYKftMHBqX/ZYeQplLKi8118
 0ikcHbsYHGZzXxnPEa+58p8nVuDQsV8iAMiqnAuuUTA2+DPC1OIc4WYKZlgHR+Ijb8
 aP66wYKpQwp9q+Yte8umqiscqcN5HXEOCV9bgIz/Yyqozk9E8spJEOiZejEP8j7uEq
 etyOGFcfK6XhBlYfbGMPDSXHro+7yjiChzYoDO8WdBhGyQLMFuAH3BQth193EBmrV9
 JYrcYLkDiKrxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/24] drm/msm: create the display connectors from
 common code
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-3-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-3-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:04:20 +0000
Message-Id: <20260722070420.7A6851F00A3A@smtp.kernel.org>
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
- [High] Unconditional calls to modeset_init functions with potentially NUL=
L encoders causes kernel crash or probe failure.
--

--- Patch [3]: [PATCH 03/24] drm/msm: create the display connectors from co=
mmon code ---
commit a0a4ea009e59812e9ecb6b60251e9294d0b779b8
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: create the display connectors from common code

This commit moves the bridge and connector setup logic from the individual
KMS backends into a common msm_kms_init_connectors() function. The backend
is now only responsible for creating the encoder, which is then used by the
common code.

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index e5d0ea6294484..87530145e82b0 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> @@ -260,6 +260,57 @@ void msm_drm_kms_uninit(struct device *dev)
>  		kms->funcs->destroy(kms);
>  }
> =20
> +/*
> + * Set up the bridges and connectors for the display sub-blocks, using t=
he
> + * encoders the backend created in ->kms_init().
> + */
> +static int msm_kms_init_connectors(struct drm_device *ddev)
> +{
> +	struct msm_drm_private *priv =3D ddev->dev_private;
> +	struct msm_kms *kms =3D priv->kms;
> +	int i, ret;
[ ... ]
> +	if (kms->hdmi) {
> +		ret =3D msm_hdmi_modeset_init(kms->hdmi, ddev, kms->hdmi_encoder);

[Severity: High]
Will this cause a NULL pointer dereference if the encoder was not created?

If the device tree defines an HDMI node (so kms->hdmi is populated), but the
KMS backend's hardware configuration doesn't support the interface, encoder
creation is skipped and kms->hdmi_encoder remains NULL.

If msm_hdmi_modeset_init() receives a NULL encoder and there is no external
bridge, it eventually calls drm_bridge_connector_init():

drivers/gpu/drm/msm/hdmi/hdmi.c:msm_hdmi_modeset_init() {
    ...
    hdmi->connector =3D drm_bridge_connector_init(hdmi->dev, encoder);
    ...
}

This unconditionally dereferences the encoder to access the bridge chain:

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_init() {
    ...
    drm_for_each_bridge_in_chain(encoder, bridge) {
    ...
}

Should there be a check ensuring the encoder was actually populated before
calling msm_hdmi_modeset_init() (and similarly for DP and DSI above this)?

> +		if (ret) {
> +			DRM_DEV_ERROR(ddev->dev,
> +				      "modeset_init failed for HDMI: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D3
