Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C811606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdYStcYs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990181125E4;
	Thu, 22 Oct 2026 12:52:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D921125E4
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:52:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63CE060204
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01B41F000C1;
 Thu, 22 Oct 2026 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673568;
 bh=qB4kWlRu1whz2sZ/Qg1ohM6dRWQQDvBk2YvmDXLbxOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NdYStcYsOABIisEK0lsxnmz6nry8QPvQX8D8hHWNYf1nuM1k2ZBjr0f4p5dNaV2NP
 Jn4bGT1AySFTzakjDN5bT7BwwWk5e24bV+t//XrDPJJDdkCEzLJG6SkQVCZJ6Rgs3w
 gBnf0tHqOcXMfJjbzSp/W0RN77Bq5b+w2pyAMbpURpUCsp3xbw6MQ1hZ35MsL7+SIp
 3esINtBVVOx66nYGMHgHSXy8g6bR1vpOVxj965qCJo6aY28porDZoLC6E/CCdIAvKE
 b3DnQTCB8z83BO3wvIWy8vKYpd/unbO7mCjEWeXhhA7kC0xE4O+tT5Rm8J8EhBdjVv
 +7Hj0LPpnpUeQ==
Message-ID: <sashiko-outbox-181508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 59/59] drm/connector: Remove reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-59-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-59-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:52:47 +0000
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
- [High] drm/connector: premature removal of reset hook breaks unconverted =
drivers
--

commit 86331e69eb719274bf362ebe2870d757866546bb
Author: Maxime Ripard <mripard@kernel.org>

drm/connector: Remove reset

This commit removes the reset callback from struct drm_connector_funcs and
drops the calls to it in drm_mode_config_reset(), drmm_connector_hdmi_init(=
),
drmm_connector_hdmi_ini2(), and panel_bridge_attach().

[ ... ]

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index 48a56f23dadbb..c1e993a78702e 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -315,9 +315,7 @@ void drm_mode_config_reset(struct drm_device *dev)
> =20
>  	drm_connector_list_iter_begin(dev, &conn_iter);
>  	drm_for_each_connector_iter(connector, &conn_iter) {
> -		if (connector->funcs->reset)
> -			connector->funcs->reset(connector);
> -		else if (connector->funcs->atomic_create_state)
> +		if (connector->funcs->atomic_create_state)
>  			drm_mode_config_connector_reset_with_create_state(connector);
>  	}
>  	drm_connector_list_iter_end(&conn_iter);

[ ... ]

> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index a87cd13d0a45f..f656ed8324d37 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1658,15 +1658,6 @@ struct drm_connector_funcs {
>  	 */
>  	int (*dpms)(struct drm_connector *connector, int mode);
> =20
> -	/**
> -	 * @reset:
> -	 *
> -	 * Reset connector hardware and software state to off. This function is=
n't
> -	 * called by the core directly, only through drm_mode_config_reset().
> -	 * It's not a helper hook only for historical reasons.
> -	 */
> -	void (*reset)(struct drm_connector *connector);
> -
>  	/**
>  	 * @detect:
>  	 *

[Severity: High]
Are all in-tree users of struct drm_connector_funcs.reset converted to
atomic_create_state before removing this callback?

Removing reset from struct drm_connector_funcs in include/drm/drm_connector=
.h
and dropping the connector->funcs->reset(connector) call from
drm_mode_config_reset() in drivers/gpu/drm/drm_mode_config.c appears to bre=
ak
the build for 26 struct drm_connector_funcs definitions across 25 files that
still initialize .reset and do not implement .atomic_create_state.

Specifically, several drivers still wire up custom reset callbacks:

drivers/gpu/drm/arm/malidp_mw.c:
static const struct drm_connector_funcs malidp_mw_connector_funcs =3D {
	.reset =3D malidp_mw_connector_reset,

drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c:
static const struct drm_connector_funcs rcar_du_wb_conn_funcs =3D {
	.reset =3D rcar_du_wb_conn_reset,

drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c (and vmw_sou_connector_funcs in
drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c, vmw_stdu_connector_funcs in
drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c):
static const struct drm_connector_funcs vmw_legacy_connector_funcs =3D {
	.dpms =3D vmw_du_connector_dpms,
	.detect =3D vmw_du_connector_detect,
	.fill_modes =3D drm_helper_probe_single_connector_modes,
	.destroy =3D vmw_ldu_connector_destroy,
	.reset =3D vmw_du_connector_reset,

In addition, the sysfb helper macro and several other drivers, bridges, and
KUnit tests still initialize .reset to drm_atomic_helper_connector_reset:

drivers/gpu/drm/sysfb/drm_sysfb_helper.h (used by simpledrm.c, efidrm.c,
ofdrm.c, vesadrm.c, and corebootdrm.c):
#define DRM_SYSFB_CONNECTOR_FUNCS \
	.reset =3D drm_atomic_helper_connector_reset, \
	.fill_modes =3D drm_helper_probe_single_connector_modes, \
	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state, \
	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state

Other unconverted struct drm_connector_funcs definitions include:
- komeda_wb_connector_funcs in
  drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
- lt8912_connector_funcs in drivers/gpu/drm/bridge/lontium-lt8912b.c
- ge_b850v3_lvds_connector_funcs in
  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
- sii902x_connector_funcs in drivers/gpu/drm/bridge/sii902x.c
- simple_bridge_con_funcs in drivers/gpu/drm/bridge/simple-bridge.c
- hv_drm_connector_funcs in drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
- imx_tve_connector_funcs in drivers/gpu/drm/imx/ipuv3/imx-tve.c
- dpu_wb_conn_funcs in drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
- ssd130x_connector_funcs in drivers/gpu/drm/solomon/ssd130x.c
- lvds_conn_funcs in drivers/gpu/drm/stm/lvds.c
- appletbdrm_connector_funcs in drivers/gpu/drm/tiny/appletbdrm.c
- vc4_txp_connector_funcs in drivers/gpu/drm/vc4/vc4_txp.c
- vc4_dummy_connector_funcs in drivers/gpu/drm/vc4/tests/vc4_mock_output.c
- dm_test_audio_connector_funcs in
  drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c (along
  with amdgpu_dm_backlight_test.c, amdgpu_dm_crc_test.c,
  amdgpu_dm_helpers_test.c, amdgpu_dm_irq_test.c, amdgpu_dm_mst_types_test.=
c,
  and amdgpu_dm_wb_test.c)

Beyond failing to compile when any of these drivers or tests are enabled,
wouldn't drm_mode_config_reset() also skip state allocation for these
connectors because they do not implement atomic_create_state, leaving
connector->state uninitialized or unreset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D59
