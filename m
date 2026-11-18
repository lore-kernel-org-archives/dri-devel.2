Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3337606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4+pnCC3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5153511206E;
	Wed, 18 Nov 2026 22:05:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CEE11206B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:05:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8E5A63FA5;
 Wed, 18 Nov 2026 22:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2889E1F000C5;
 Wed, 18 Nov 2026 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795039510;
 bh=IIc7twuSMCJv49qBEXa12fA8LCRjjiEJYGjYVZZI3g0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a4+pnCC3TuAFJpo3h2GSSm3wcQTgfQzuIVfbGlJ0vrmmEl/30RoX7w/MF1p36uYAA
 j51sW1MiwaBfd8F4qhlBIqCeXmD/JPfSaii2iXvgQPoDf8j+pYGs/HJtcT/JVWc2ms
 0xmWVHiD/nX1zF4GXHsRxR8NrL3B+8/DJATDLXR+C2O2PZMLtNMpEv0JAL/D5w27gH
 20P0ife+RKf3NI5WkvmY6gWXR+cpmjNo2AH/K/yGaJdFKvHco4XS7fJJNnzkt7FFgG
 eutNRV4U1VrGqQ7mUf+09HuHqbPm8aXKquUV07HYM3FwwgHoUo3fhn2fvaaVVE9iOT
 5pCDxCPcihjDg==
Message-ID: <sashiko-outbox-222076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/bridge: synopsys: dw-hdmi-qp: Attach the next
 bridge in the chain
To: "Joachim Eastwood" <joachim.eastwood@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261118-dw-hdmi-qp-bridge_attach-v1-2-e370920bc7f3@gmail.com>
References: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
 <20261118-dw-hdmi-qp-bridge_attach-v1-2-e370920bc7f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:05:09 +0000
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
- [High] drm/bridge: dw-hdmi-qp: missing DRM_DISPLAY_CONNECTOR Kconfig
  select
--

commit 2fdd511539969260584719b2d1604f9b1b9ed26e
Author: Joachim Eastwood <joachim.eastwood@gmail.com>

drm/bridge: synopsys: dw-hdmi-qp: Attach the next bridge in the chain

This commit implements drm_bridge_funcs.attach for dw-hdmi-qp to look up and
attach the next bridge connected to output port 1.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index eed249aca1e23..200229e5d9afc 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
[ ... ]
> @@ -1024,7 +1028,33 @@ static void dw_hdmi_qp_bridge_hpd_disable(struct d=
rm_bridge *bridge)
>  		hdmi->phy.ops->disable_hpd(hdmi, hdmi->phy.data);
>  }
> =20
> +static int dw_hdmi_qp_bridge_attach(struct drm_bridge *bridge,
> +				    struct drm_encoder *encoder,
> +				    enum drm_bridge_attach_flags flags)
> +{
> +	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
> +	struct device_node *remote __free(device_node) =3D
> +		of_graph_get_remote_node(hdmi->dev->of_node,
> +					 DW_HDMI_QP_OUTPUT_PORT, -1);
> +
> +	/*
> +	 * The HDMI connector node is optional. When present, chain its bridge
> +	 * so that properties such as ddc-i2c-bus, hpd-gpios and supplies are
> +	 * honoured by the DRM bridge connector.
> +	 */
> +	if (!remote)
> +		return 0;
> +
> +	struct drm_bridge *next_bridge __free(drm_bridge_put) =3D
> +		of_drm_find_and_get_bridge(remote);
> +	if (!next_bridge)
> +		return -EPROBE_DEFER;

[Severity: High]
Should DRM_DW_HDMI_QP (or ROCKCHIP_DW_HDMI_QP) select DRM_DISPLAY_CONNECTOR
in Kconfig?

All in-tree RK3576 and RK3588 board device trees wire port 1 to an
"hdmi-connector" node, which is handled by display-connector.c under
CONFIG_DRM_DISPLAY_CONNECTOR.  Neither DRM_DW_HDMI_QP nor
ROCKCHIP_DW_HDMI_QP selects DRM_DISPLAY_CONNECTOR, so configs that previous=
ly
worked without it will now have of_drm_find_and_get_bridge() return NULL and
defer probe forever, preventing rockchip_drm_bind() from binding the display
subsystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-dw-hdmi-qp=
-bridge_attach-v1-0-e370920bc7f3@gmail.com?part=3D2
