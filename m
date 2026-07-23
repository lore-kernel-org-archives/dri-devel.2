Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56641C4453D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB20110E510;
	Thu, 23 Jul 2026 01:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JBvjLr3n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2BF10E4FC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:48:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7794600AB;
 Thu, 23 Jul 2026 01:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549281F000E9;
 Thu, 23 Jul 2026 01:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784771279;
 bh=FgHe+npIqS2rAfjj6XicyzwnNjdSW1SvMFF7N8eDgH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JBvjLr3n3VMNuG7/MSeytoSINk8IFf9kqXqGL83pJyhNVObO0Bg6UjaKcLThOvj0P
 +eTey9fqxzanEM9mCy9mNi9OBlYSNGCJ4uWeCoKjzEPb6gX8Mr1raG1o8E2EQ3PXfY
 obQs4cRrsDP2zkeSwlt/fxVksIIrQl5T3R+KZBa/rayzt0PRrO8+hoLbeLSsYCFfx/
 Z6e8N8xYIbmP1tObpqn/+IgOn7PuL4qtIliVWZ5UlqB0jweLOOM0M9ss/v6U1/wUwD
 Paqx+yyUb0qMF4lmaurQZiGjee7kHhkwvF9xCIfDJPis/H/OSRec9E0J8Aj3kMVug3
 qdhdZ50WTMjcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/61] drm/bridge: Add bridge ops for source-side
 HDMI 2.0 scrambling
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-11-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-11-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:47:58 +0000
Message-Id: <20260723014759.549281F000E9@smtp.kernel.org>
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
- [High] Missing implementation of HDMI 2.0 scrambler callbacks in drm_brid=
ge_connector causes initialization failure
--

--- Patch [11]: [PATCH v9 11/61] drm/bridge: Add bridge ops for source-side=
 HDMI 2.0 scrambling ---
commit 449aac531f177fb10d98b7aac7653c2b23b627e6
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Add bridge ops for source-side HDMI 2.0 scrambling

This commit adds hdmi_scrambler_enable and hdmi_scrambler_disable callbacks
to drm_bridge_funcs. This enables bridges advertising HDMI 2.0 to configure
source-side scrambling for modes exceeding 340 MHz.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 727eeb94119a5..348ddbe41dec5 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -561,6 +561,41 @@ struct drm_bridge_funcs {
>  				     const struct drm_display_mode *mode,
>  				     unsigned long long tmds_rate);
> =20
> +	/**
> +	 * @hdmi_scrambler_enable:
> +	 *
> +	 * Enable source-side scrambling and the high TMDS clock ratio for the
> +	 * mode currently being applied.
> +	 *
> +	 * This only programs the source side. Sink-side SCDC configuration is
> +	 * handled by the HDMI connector helpers.
> +	 *
> +	 * Mandatory for bridges that set the DRM_BRIDGE_OP_HDMI flag in their
> +	 * &drm_bridge->ops and advertise HDMI_VERSION_2_0 or later via
> +	 * &drm_bridge->supported_hdmi_ver; unused otherwise.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise.
> +	 */
> +	int (*hdmi_scrambler_enable)(struct drm_bridge *bridge);
> +
> +	/**
> +	 * @hdmi_scrambler_disable:

[Severity: High]
Will bridge drivers adopting these new callbacks fail to probe?

Looking at drm_bridge_connector_init(), the wrapper fails to map these
newly added bridge callbacks to the connector's hdmi_funcs before calling=20
drmm_connector_hdmi_init():

	ret =3D drmm_connector_hdmi_init(drm, connector,
				       &drm_bridge_connector_funcs,
				       &bridge_connector->hdmi_funcs,
				       connector_type, ddc);

Because these new bridge ops are not mapped over to=20
bridge_connector->hdmi_funcs, the core DRM HDMI initialization in=20
drmm_connector_hdmi_init() will see them as missing and unconditionally=20
fail with -EINVAL for HDMI 2.0+ devices:

	if (hdmi_funcs->supported_hdmi_ver >=3D HDMI_VERSION_2_0) {
		if (!hdmi_funcs->scrambler_enable || !hdmi_funcs->scrambler_disable) {
			drm_err(dev, "Scrambler callbacks missing for HDMI 2.x\n");
			return -EINVAL;
		}
	}

Should drm_bridge_connector_init() be updated to populate .scrambler_enable=
=20
and .scrambler_disable from these new bridge ops to prevent initialization=
=20
failures?

> +	 *
> +	 * Disable source-side scrambling and the high TMDS clock ratio.
> +	 *
> +	 * This only programs the source side. Sink-side SCDC configuration is
> +	 * handled by the HDMI connector helpers.
> +	 *
> +	 * Mandatory for bridges that set the DRM_BRIDGE_OP_HDMI flag in their
> +	 * &drm_bridge->ops and advertise HDMI_VERSION_2_0 or later via
> +	 * &drm_bridge->supported_hdmi_ver; unused otherwise.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise.
> +	 */
> +	int (*hdmi_scrambler_disable)(struct drm_bridge *bridge);
> +
>  	/**
>  	 * @hdmi_clear_avi_infoframe:
>  	 *

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D11
