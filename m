Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31E7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC3B10E4F7;
	Thu,  2 Jul 2026 15:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iNRlEMaa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C4210E4F7
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:02:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2C9941B0C;
 Thu,  2 Jul 2026 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B041F000E9;
 Thu,  2 Jul 2026 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004572;
 bh=wuYY+YFf2R67nbFXOG6u4vDB4ULT/dIvel46MQzuZfE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iNRlEMaaM5IeIGMSSagfuPMd7PWUjUcqKZOr73SRQ7vjJzL/UBgfxhrk1+AJv9QZb
 XkSvdJ6lshELeN7I3W2c5bIWyjLfVOBFzk7iuzxciDEHj2bEf063XlcMN3ftMIiBQc
 q1TtBolPlPZ0SUPNEsdj7RQ+Wj1mY1cFttyxuThiDg6vlm/nrDwIe5xsS9T9LRjxzw
 U0gfreGnhAMN9+7shTTRPg2TRSnwSr8hDSRBo9+hfWYBPohjmahU9fDn+RFx8P7Mk5
 NBbID6ohLhJ1u8aeVp04OH6fFNK6sjsq/e0+SCfiMDnSmBkUNNdv7Zo3siwBWhkYv5
 nIuUjX8SHZ4zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector
 init helper
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-2-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-2-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:02:51 +0000
Message-Id: <20260702150252.B3B041F000E9@smtp.kernel.org>
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
- [Low] The kernel-doc for drmm_connector_hdmi_init_with_caps incorrectly c=
laims the caps parameter is optional, but the implementation strictly requi=
res it.
--

commit 0bf3f9f06453c1934cf1bf6f51eb321720ded5eb
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/connector: Add caps-based HDMI connector init helper

In preparation for adding HDMI 2.x source capabilities, introduce struct
drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_caps()
helper.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 8b4baed060f3a..c7ce6b7bd8b0e 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -552,8 +552,7 @@ EXPORT_SYMBOL(drmm_connector_init);
>   * @hdmi_funcs: HDMI-related callbacks for this connector
>   * @connector_type: user visible type of the connector
>   * @ddc: optional pointer to the associated ddc adapter
> - * @supported_formats: Bitmask of @drm_output_color_format listing suppo=
rted output formats
> - * @max_bpc: Maximum bits per char the HDMI connector supports
> + * @caps: optional HDMI connector capabilities
>   *
>   * Initialises a preallocated HDMI connector. Connectors can be
[ ... ]
> @@ -591,13 +589,18 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  	      connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIB))
>  		return -EINVAL;
> =20
> -	if (!supported_formats || !(supported_formats & BIT(DRM_OUTPUT_COLOR_FO=
RMAT_RGB444)))
> +	if (!caps)
>  		return -EINVAL;

[Severity: Low]
The kernel-doc for drmm_connector_hdmi_init_with_caps() marks @caps as an
optional parameter, but the implementation explicitly rejects a NULL caps
pointer with -EINVAL.

Should the documentation be updated to reflect that @caps is actually
required?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D2
