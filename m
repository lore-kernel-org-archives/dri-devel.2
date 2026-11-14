Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB82606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOt7i9Wk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1895110ED55;
	Sat, 14 Nov 2026 05:30:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3071F10ED45
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:30:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BE3661754;
 Sat, 14 Nov 2026 05:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DE11F000C4;
 Sat, 14 Nov 2026 05:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794634240;
 bh=4rYPcnhXcQcL1PI6KbTxDEuCC8s/86I+H5pDkJs2lPw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jOt7i9WkDqM7JSNJkj+ywg5lJksErr/ClI2TlRl97TI0WWk6VEQ6OWvFbAVl79H3A
 wl9/aGDuoc6cbvmwqAYyybelkT6lyrTSrcoWyWlkDyY/Ylp97AZmlxPjCDFKTSukE9
 zNgRa8JdOpfa8u62O6wUFprzJ9wpUWTFLSL0aO7CaCLmG8E5hEBf6J5JzB04vMJ5IP
 XYb90WBOtLrWz9Qx+/OQO5cZbNjyUiSsqpPu6GdptA/qf/uIwYao3F5muHdK1dfeU2
 Z+AB687CPkTYx8/gRKVwJ9JfTw1w3v48SYfljZLJPrQcaSi5lSU9qgDT6vUxT/Dwnl
 rAZ98wTHBH5zg==
Message-ID: <sashiko-outbox-214178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 12/23] drm/bridge: synopsys: dw-dp: Support software
 triggered OOB HPD
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-12-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
 <20261114-synopsys-dw-dp-improvements-v12-12-d42d3dc5bdd4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:30:39 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/bridge: dw-dp: missing HPD debounce wait in
  dw_dp_bridge_oob_notify()
- [Low] drm/bridge: dw-dp: split __free() declaration in
  dw_dp_is_routed_to_usb_c()
--

commit 8854deef3437dfb8f0f36f50f761f07577702cde
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD

This commit adds support for USB-C DisplayPort AltMode out-of-band hotplug
notifications to the DesignWare DisplayPort bridge driver via platform
callbacks.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 74ba1306caee6..b4eed4d0a5205 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1875,6 +1875,19 @@ static struct drm_bridge_state *dw_dp_bridge_atomi=
c_duplicate_state(struct drm_b
>  	return &state->base;
>  }
> =20
> +static bool dw_dp_is_routed_to_usb_c(struct drm_encoder *encoder)
> +{
> +	struct drm_bridge *last_bridge __free(drm_bridge_put) =3D NULL;
> +	struct fwnode_handle *fwnode;
> +
> +	last_bridge =3D drm_bridge_chain_get_last_bridge(encoder);

[Severity: Low]
This isn't a bug, but per the Cleanup API conventions, last_bridge can be
defined and initialized in a single statement rather than declared as NULL
and assigned later:

	struct drm_bridge *last_bridge __free(drm_bridge_put) =3D
		drm_bridge_chain_get_last_bridge(encoder);

[ ... ]

> @@ -1923,6 +1943,22 @@ static void dw_dp_bridge_detach(struct drm_bridge =
*bridge)
>  	drm_dp_aux_unregister(&dp->aux);
>  }
> =20
> +static void dw_dp_bridge_oob_notify(struct drm_bridge *bridge,
> +				    struct drm_connector *connector,
> +				    enum drm_connector_status status)
> +{
> +	bool hpd_high =3D status !=3D connector_status_disconnected;
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	if (!dp->plat_data.hpd_sw_cfg) {
> +		dev_err_once(dp->dev, "Missing platform handler for OOB HPD handling\n=
");
> +		return;
> +	}
> +
> +	dev_dbg(dp->dev, "Force HPD connected=3D%s\n", str_yes_no(hpd_high));
> +	dp->plat_data.hpd_sw_cfg(dp->plat_data.data, hpd_high);
> +}

[Severity: Medium]
Does dw_dp_bridge_oob_notify() return before the DW-DP controller has
debounced the forced HPD signal in DW_DP_HPD_STATUS?

Right after bridge->funcs->oob_notify() returns,
drm_bridge_connector_oob_hotplug_event() calls
drm_bridge_connector_handle_hpd() -> drm_kms_helper_connector_hotplug_event=
(),
which probes the connector via dw_dp_bridge_detect() -> dw_dp_hpd_detect():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_hpd_detect() {
	...
	regmap_read(dp->regmap, DW_DP_HPD_STATUS, &value);

	return FIELD_GET(HPD_STATE, value) =3D=3D DW_DP_HPD_STATE_PLUG;
}

As seen in dw_dp_reset() (which polls DW_DP_HPD_STATUS for up to 200 ms),
the hardware requires ~100 ms of HPD held high before asserting
HPD_HOT_PLUG and updating HPD_STATE to DW_DP_HPD_STATE_PLUG. Returning
immediately after hpd_sw_cfg() causes synchronous detection on plug-in to
read a stale HPD_STATE and overwrite connector->status back to
disconnected.

Even with the later commit "drm/bridge: synopsys: dw-dp: Add Runtime PM
support", which adds msleep(110) in dw_dp_runtime_resume(), that delay only
runs when waking from runtime suspend; if the device is already
runtime-active when dw_dp_bridge_oob_notify() is called (for example during
the 500 ms autosuspend window or while a stream is active),
dw_dp_runtime_resume() is not called and hpd_sw_cfg() still returns before
HPD_STATE updates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-synopsys-d=
w-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com?part=3D12
