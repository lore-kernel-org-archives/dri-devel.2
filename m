Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9340AC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBE810EC89;
	Wed, 22 Jul 2026 07:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X4qFircQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE21910EC89
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:04:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89C9F43554;
 Wed, 22 Jul 2026 07:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422D81F000E9;
 Wed, 22 Jul 2026 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703881;
 bh=9Xd1irictntXRnTyt34BCScYtJ/IyVbmfggMM6104N8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X4qFircQzP/CQeh8rWtLu6iP7OmKFAvOV2DWO8sykBgM2CArZvXiInpNMO4q6Terb
 yw16Uottjaogp63UDf3GemVGUUk24KeYBcUfetNoHD8kS4g04M+LOQpRe69fGNAdTV
 vQmuXSV44D/ANSwBueHuMANCjqMKuHPa26KTI3P6yUs2A2B8ngBEXSIedndQh7baa+
 Xk4S22NjlgQnMkH6ySDCPJT1z/TxwIadQyfhD5OwKHwhPN7C5+Ybllm9ceoRMKAgxW
 EbQizuQbZI1/XhiR1pHhN67MSoEexZlfphdf+jQ0jnMcR++cEK7LFAU6Hu6/TnBpYZ
 gWXSARmVFFpuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/24] drm/msm: create the bridge connectors from common
 code
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-23-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-23-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:04:40 +0000
Message-Id: <20260722070441.422D81F000E9@smtp.kernel.org>
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
- [High] Centralized `msm_kms_init_connectors` loop unconditionally calls `=
drm_bridge_connector_init` for all non-virtual encoders, failing the driver=
 probe with `-EINVAL` if any encoder lacks an attached bridge.
--

--- Patch [23]: [PATCH 23/24] drm/msm: create the bridge connectors from co=
mmon code ---
commit 04453784aafc591b434b0736383d9d31623d416b
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
drm/msm: create the bridge connectors from common code

This patch centralizes bridge connector creation in the msm backend by
having each sub-block only set up its bridge chain. A new function,
msm_kms_init_connectors(), then walks through all encoders to create the
connectors using common code.

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index 1a081e15a0a89..71af3780b7b13 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> @@ -310,6 +313,35 @@ static int msm_kms_init_connectors(struct drm_device=
 *ddev)
>  	return ret;
>  }
> =20
> +/* Build a bridge connector for each encoder. */
> +static int msm_kms_init_connectors(struct drm_device *ddev)
> +{
> +	struct drm_encoder *encoder;
> +
> +	drm_for_each_encoder(encoder, ddev) {
> +		struct drm_connector *connector;
> +		int ret;
> +
> +		/* the virtual writeback encoder brings its own connector */
> +		if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_VIRTUAL)
> +			continue;
> +
> +		connector =3D drm_bridge_connector_init(ddev, encoder);
> +		if (IS_ERR(connector)) {
> +			DRM_DEV_ERROR(ddev->dev,
> +				      "failed to init connector for %s: %ld\n",
> +				      encoder->name, PTR_ERR(connector));
> +			return PTR_ERR(connector);
> +		}

[Severity: High]
Will this fail the entire driver probe on hardware where some encoders are
left without an attached bridge?

For example, on MDP4 hardware, a TMDS encoder is registered unconditionally
in mdp4_modeset_init_intf(), but it will have an empty bridge chain if HDMI
is not present. Similarly, for bonded DSI, msm_dsi_modeset_init() skips
bridge creation for the slave DSI, leaving its encoder without a bridge.

When drm_bridge_connector_init() processes an encoder with an empty bridge
chain, it returns ERR_PTR(-EINVAL) because it cannot determine the connector
type. Since this loop treats any error as fatal, won't this break
display initialization on these configurations?

> +
> +		/* The DP subconnector property applies to DisplayPort only. */
> +		if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort)
> +			drm_connector_attach_dp_subconnector_property(connector);
> +	}
> +
> +	return 0;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D23
