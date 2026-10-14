Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955F5CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA8C10EAA2;
	Wed, 14 Oct 2026 18:14:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E54910EAA2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:14:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5BAE412D5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6C01F000C4;
 Wed, 14 Oct 2026 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792001678;
 bh=E+RHxGpRrP17YEYyau1s1lt67wr47jZBdOkXxgTr0FY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kLMIOneLhExXfL1e77VamLcW88k0uaGRQWlJ5hN5F+hv7TOeP/GRQAIeXbaodWcp5
 xAEgKwy35QufL7/D9VAWu8oE5dIy112hjuyiL5yv1swmsggto0gsWIYW0ng12zMWgl
 ONvFE/eaJlRtSptOyxQeivW5eR3uU8R8TQGd6GJAIjVXRcZpQj/SpTbNl+mi1nITc2
 VValC2pPcfMJ7MadcYHfLZYhnUALPgttBR4wgfjzxd6HuNQcO/Tx4Jg/2RRkIvMpAl
 G30aq/Z1oFflUNIYRS7KixdLYF/u7aEzlyTlKBNXiPXxm7xoyFnR88HJkh9fn/Zjfr
 dBQmFRCmu8t1w==
Message-ID: <sashiko-outbox-171679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 57/75] drm/bridge: synopsys: dw-hdmi: Convert to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-57-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-57-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 18:14:38 +0000
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
- [High] drm/bridge: dw-hdmi: missing error check for drm_connector_init_wi=
th_ddc
- [Medium] drm/bridge: dw-hdmi: max_bpc state is lost during drm_mode_confi=
g_reset()
--

commit 00a6167b722bff3c39b80a7bcee2827035fd652c
Author: Maxime Ripard <mripard@kernel.org>
Subject: drm/bridge: synopsys: dw-hdmi: Convert to atomic_create_state

The dw-hdmi driver allocates an initial connector state during creation.
This commit converts the allocation from drm_atomic_helper_connector_reset()
to drm_atomic_helper_connector_create_state() and adds proper error handlin=
g.

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
> +
> +		connector->state =3D conn_state;
> +	}

[Severity: High]
Does this code handle failures from drm_connector_init_with_ddc() correctly?

Looking at dw_hdmi_connector_create(), drm_connector_init_with_ddc() is cal=
led
just before this block, but its return value is ignored:

    drm_connector_init_with_ddc(hdmi->bridge.dev, connector,
                                &dw_hdmi_connector_funcs,
                                DRM_MODE_CONNECTOR_HDMIA,
                                hdmi->ddc);

If this initialization fails, connector->base.properties remains uninitiali=
zed
(NULL).

When execution continues to drm_connector_attach_max_bpc_property(), it will
attempt to attach the property and dereference connector->base.properties,
resulting in a NULL pointer dereference.

> =20
>  	drm_connector_attach_max_bpc_property(connector, 8, 16);

[Severity: Medium]
Will this max_bpc initialization be lost during a drm_mode_config_reset()?

The driver assigns .atomic_create_state =3D
drm_atomic_helper_connector_create_state in dw_hdmi_connector_funcs without
a custom hook to restore max_bpc.

If a host DRM driver calls drm_mode_config_reset(), the core fallback in
drm_mode_config_connector_reset_with_create_state() will destroy this
initially allocated state and replace it with a newly allocated one:

    if (connector->state) {
        connector->funcs->atomic_destroy_state(connector, connector->state);
        connector->state =3D NULL;
    }

    return drm_mode_config_connector_create_state(connector);

This wipes out the max_bpc property attached here, resetting it to 0. This
could cause the driver to incorrectly fall back to 8-bit color depth later
in dw_hdmi_bridge_mode_set().

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D57
