Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B24606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BusFV5Oo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C884C10E3C7;
	Thu, 22 Oct 2026 12:57:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429AD10E3C7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:57:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0ADC4412A2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47321F000C1;
 Thu, 22 Oct 2026 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673829;
 bh=O2S2t+i42MFHNJvDmA1Nfmh1GpAK61dZdpwJ8SeMLsM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BusFV5OoJUddL0G6ChHcxJ75yEcSlu18PHJCb4zLILegzCGbxnMZynBr89ztI1RCo
 03ktKOCmLke5xbZImTGQbpSzw3+TuI0L+ldvl/zsVHt6LRr8cMeozdyVIOEbuEWiH9
 2BhhVngBnSw4j4D2V4gdMpyxozVTyK0eEK/jNdMPuDL9Bw5H4e5P78I1td9nOLpnhi
 esEvY1vJR1cEDADRhsiYvZs6Rrzq23ZsGQcKwmVnMTW70fzrXnQhzp23jrY/7v0mHO
 8UoUA6yq2FTCPFxK6F+uyxgvam7LudIAHanlPmjIIw0tT76IStt/DB0h2zoR30HZ1r
 foH2WSaKTdclg==
Message-ID: <sashiko-outbox-181521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 44/59] drm/bridge: synopsys: dw-hdmi: Convert to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-44-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-44-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:57:09 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/bridge: dw-hdmi: missing connector cleanup in dw_hdmi_connecto=
r_create()
--

commit 79a659d48a2ba43f6a6effe5800fc818debe3d47
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: synopsys: dw-hdmi: Convert to atomic_create_state

This commit replaces the call to drm_atomic_helper_connector_reset() in
dw_hdmi_connector_create() with drm_atomic_helper_connector_create_state() =
to
allocate the initial connector state required by
drm_connector_attach_max_bpc_property().

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/=
bridge/synopsys/dw-hdmi.c
> index 917cf764c9c5d..5f11707c67b5c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2605,7 +2605,15 @@ static int dw_hdmi_connector_create(struct dw_hdmi=
 *hdmi)
>  	 * drm_connector_attach_max_bpc_property() requires the
>  	 * connector to have a state.
>  	 */
> -	drm_atomic_helper_connector_reset(connector);
> +	if (!connector->state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state =3D drm_atomic_helper_connector_create_state(connector);
> +		if (IS_ERR(conn_state))
> +			return PTR_ERR(conn_state);

[Severity: High]
If drm_atomic_helper_connector_create_state() fails in
dw_hdmi_connector_create() in drivers/gpu/drm/bridge/synopsys/dw-hdmi.c,
does returning PTR_ERR(conn_state) directly leak the initialized connector
and leave &hdmi->connector linked on dev->mode_config.connector_list?

Just before allocating the state, dw_hdmi_connector_create() initializes
the unmanaged embedded connector:

	drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
				    &dw_hdmi_connector_funcs,
				    DRM_MODE_CONNECTOR_HDMIA,
				    hdmi->ddc);

which registers &connector->base in dev->mode_config.object_idr, allocates
connector->name, and adds &connector->head to
dev->mode_config.connector_list.

When dw_hdmi_connector_create() returns an error via
dw_hdmi_bridge_attach() -> drm_bridge_attach() during component binding,
dw_hdmi_bind() cleans up the bridge and component_bind() in
drivers/base/component.c releases the component devres group, freeing
struct dw_hdmi while &hdmi->connector remains on
dev->mode_config.connector_list. When the master driver later runs
drm_mode_config_cleanup() in drivers/gpu/drm/drm_mode_config.c, iterating
connector_list will dereference the already-freed &hdmi->connector.

Should this error path call drm_connector_cleanup(connector) before
returning?

> +
> +		connector->state =3D conn_state;
> +	}
> =20
>  	drm_connector_attach_max_bpc_property(connector, 8, 16);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D44
