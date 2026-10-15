Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2052CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D1410E040;
	Thu, 15 Oct 2026 16:59:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB2910E174
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:59:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E97CB41400
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39E21F000C5;
 Thu, 15 Oct 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792083552;
 bh=YS0Y60DD2QRe8Vqh1sg5jGmePC6r9/rGZE3IY6ezGE4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mzMxXDGBvd8TW+32lM5amb6oI9u3nPwuy328aON2ep9UC3fOVajKypCaMzJeH/+T4
 WDi5ugCFAfvhaxbTfCbUT3adw7dI1VoG/XSZhW59JlIvSYHECA6QzKp4z1QHknFr9H
 Wq80ho9c/t/hju5aKCn3U+gHHEVkPB6XTr7TMvO7B6oXhFYyyAeZbrCMdF1yHlu9R8
 RGOat4t165Lp5tvcZ8Q95+hOmAISHmIOomX53PraPtHWgbMZk70CBsIuPygOUHpsqd
 MTsjGOdCNeVmufTUkXpAFmx+QVFV9K4gWCyvOUgICssb8bBRjSKYWfi0XMOEqsRr7n
 miTM8GLwtzOoQ==
Message-ID: <sashiko-outbox-173218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 22/28] drm/bridge_connector: Implement hw readout for
 connector
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-22-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-22-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:59:12 +0000
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
- [Medium] drm/bridge_connector: refcount leak of hw_readout bridge on clea=
nup
--

commit d10ad940eac7c7ab253337c97ac0dbff416cd941
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge_connector: Implement hw readout for connector

This commit implements hardware state readout support for the generic bridge
connector. It allows the last bridge in the chain that supports readout to =
fill
the connector state from its own hardware state.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
[ ... ]
> @@ -896,6 +927,10 @@ struct drm_connector *drm_bridge_connector_init(stru=
ct drm_device *drm,
>  		if (!bridge->ycbcr_420_allowed)
>  			connector->ycbcr_420_allowed =3D false;
> =20
> +		if (bridge->ops & DRM_BRIDGE_OP_CONNECTOR_HW_READOUT) {
> +			drm_bridge_put(bridge_connector->bridge_connector_hw_readout);
> +			bridge_connector->bridge_connector_hw_readout =3D drm_bridge_get(brid=
ge);
> +		}

[Severity: Medium]
Does this leak the bridge reference when the connector is destroyed?

In drm_bridge_connector_init(), a reference to the bridge implementing hard=
ware
readout is acquired using drm_bridge_get() and stored in
bridge_connector->bridge_connector_hw_readout.

The teardown of the other bridge references in this struct is managed by the
action callback drm_bridge_connector_put_bridges():

drivers/gpu/drm/display/drm_bridge_connector.c:drm_bridge_connector_put_bri=
dges() {
	struct drm_bridge_connector *bridge_connector =3D (struct drm_bridge_conne=
ctor *)data;

	drm_bridge_put(bridge_connector->bridge_edid);
	drm_bridge_put(bridge_connector->bridge_hpd);
	drm_bridge_put(bridge_connector->bridge_detect);
	...
}

However, it doesn't look like drm_bridge_connector_put_bridges() was updated
to release the newly added bridge_connector_hw_readout reference when the
connector is cleaned up.

>  		/*
>  		 * Ensure the last bridge declares OP_EDID or OP_MODES or both.
>  		 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D22
