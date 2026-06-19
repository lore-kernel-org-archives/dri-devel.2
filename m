Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB48CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E46E10E09E;
	Fri, 19 Jun 2026 14:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k7A9g2wh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279CD10E09E
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:18:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F352601E1;
 Fri, 19 Jun 2026 14:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94431F000E9;
 Fri, 19 Jun 2026 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781878715;
 bh=3dL3NsU1aeC59grDDZMHUA+Vc3YEhM9REQGQ4Yj6BDo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k7A9g2whwZ7LEP26VpAivFT3tTFXjXHlHdtA/Jz2R/fF3MdM+3+xeYJEk1mDn4XaJ
 jOzAgeCRvW1ZI0ubvmWIV8SFW4MnpoOb6PHTtCjlyXNvTC6ZlYwx6XZADC70m5Gc0Z
 Qvc7HTOLB2xbNdKOhdwwRZLloipRF2vaIqnk51SkV3Q0/Sw8ENH640zn4H7mpo0lDD
 Y1aLsjTXDAPNe7H85p65abSVWj6spB56DsVasWtAvW6NVQYT1wS0HrRfCNB8iSe2IB
 a/PssDqIgE6C+YzmT5BiiFJEgRgrtC+/2OVJQDlmyx3faESBLJxyBTvAKhpBl4zpwl
 ddWxrNWVGiD5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 3/4] drm/bridge: Wire drmm_connector_dp_init()
 via new DRM_BRIDGE_OP_DP flag
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619-feat_link_cap-v2-3-a3dec4c02ad9@bootlin.com>
References: <20260619-feat_link_cap-v2-0-a3dec4c02ad9@bootlin.com>
 <20260619-feat_link_cap-v2-3-a3dec4c02ad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 14:18:35 +0000
Message-Id: <20260619141835.B94431F000E9@smtp.kernel.org>
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
- [High] Unconditional call to drmm_connector_dp_init() breaks bridge chain=
s with downstream format converters.
- [Low] Kernel-doc for DRM_BRIDGE_OP_DP incorrectly references a non-existe=
nt structure member.
--

commit 95b54bb01e2f24e6a00ddf825b25aaa6985fa864
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/bridge: Wire drmm_connector_dp_init() via new DRM_BRIDGE_OP_DP flag
   =20
Introduce DRM_BRIDGE_OP_DP to indicate bridges that provide DP connector
operations. Update drm_bridge_connector_init() to use
drmm_connector_dp_init() when this flag is present to expose link training
state properties.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 39cc18f78eda1..5238b1ec738ce 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c

[ ... ]

> @@ -986,6 +1003,13 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
>  					       max_bpc);
>  		if (ret)
>  			return ERR_PTR(ret);
> +	} else if (bridge_connector->bridge_dp) {
> +		ret =3D drmm_connector_dp_init(drm, connector,
> +					     &drm_bridge_connector_funcs,
> +					     bridge_connector->bridge_dp->dp_link_caps,
> +					     connector_type, ddc);
> +		if (ret)
> +			return ERR_PTR(ret);

[Severity: High]
If a DRM bridge chain consists of a DisplayPort transmitter followed by a
format-converting bridge (e.g., DP-to-VGA or DP-to-LVDS), the final
connector_type of the chain will be the output format (like
DRM_MODE_CONNECTOR_VGA).

Since drmm_connector_dp_init() explicitly enforces that connector_type must
be DRM_MODE_CONNECTOR_DisplayPort or DRM_MODE_CONNECTOR_eDP, will this call
immediately return -EINVAL and break display initialization for legitimate
format-converted hardware combinations?

Does the branch condition need to verify the final connector_type is actual=
ly
DP/eDP before forcing the DP initialization path?

>  	} else {
>  		ret =3D drmm_connector_init(drm, connector,

[ ... ]

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index a8d67bd9ee505..63db754d21146 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1092,6 +1092,14 @@ enum drm_bridge_ops {
>  	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
>  	 */
>  	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME =3D BIT(10),
> +	/**
> +	 * @DRM_BRIDGE_OP_DP: The bridge provides DisplayPort connector
> +	 * operations, including link training support. Bridges that set
> +	 * this flag must provide DisplayPort-related information and
> +	 * fill the &drm_bridge->dp_link_train_caps link training

[Severity: Low]
This isn't a bug, but there's a typo in the documentation. It references
&drm_bridge->dp_link_train_caps, but the actual structure member added
in this patch is named dp_link_caps.

> +	 * capabilities.
> +	 */
> +	DRM_BRIDGE_OP_DP =3D BIT(11),
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-feat_link_=
cap-v2-0-a3dec4c02ad9@bootlin.com?part=3D3
