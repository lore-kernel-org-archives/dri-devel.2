Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCC606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NE7cUHft
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B71F10F7F3;
	Thu,  5 Nov 2026 18:01:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1771110F7F3
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:01:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC08042A44;
 Thu,  5 Nov 2026 18:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9091F000C1;
 Thu,  5 Nov 2026 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793901683;
 bh=oZYVV0SZdq4FbwEl+C6sCMTXGqWYmTvBvZ9dx5666/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NE7cUHftpAjqvUQXL+zkAMZrNz0lSbnN5IrDzliqmvfQR4A2KSFx7Am0sbwvfQ3ET
 mg9EQOP6Ha/spFMRgKeazSVzhiYmRfzXarmr/68mynHOXzuQzso7YvLiyGbX/VKu1P
 X7qmqowYnjF6APKiKp6Shuil3PGv4CNeK3GJ4e2FT7mfS9IV2EAu9Tk+iUDrwsIwqk
 RGnnH1D+Lt8BxKul7P3cx4+R8m/I6WHRedn0Wq9WhEbRUGoBCE9CPkgvxOO0ix8IFA
 3c80uCPJ6vhFw0LCzSgEKZP3IF4Ds7tdbm3/e/zv8aRufzZakNgP3KlqwMkYiZD6MU
 9BYWvvsCsv6mQ==
Message-ID: <sashiko-outbox-199683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/27] drm/rockchip: dw_hdmi_qp: Add QMS support
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-21-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-21-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:01:23 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/rockchip: dw_hdmi_qp: QMS rate changes do not update VTEM EMP =
or CRTC
- [High] drm/rockchip: dw_hdmi_qp: broken QMS-only sink and VTEM EMP valida=
tion
- [High] drm/rockchip: gated VRR helpers in vop2_vp_handle_vblank() break Q=
MS vtotal
--

commit fc51237acec11aa5e7ba522a20138aec70453297
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/rockchip: dw_hdmi_qp: Add QMS support

This commit enables Quick Media Switching (QMS) on Rockchip DW HDMI QP
connectors by adding VRR_DISPLAY_MODE_MEDIA to RK_VRR_DISPLAY_MODES and
setting connector->hdmi.qms_supported to true.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index dcde50bca36bf..215cf746dc41c 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -90,7 +90,8 @@
>  #define RK_COLOR_FMT_YUV420		0x3
> =20
>  #define RK_VRR_DISPLAY_MODES		(BIT(VRR_DISPLAY_MODE_GAME) | \
> -					 BIT(VRR_DISPLAY_MODE_OFF))
> +					 BIT(VRR_DISPLAY_MODE_OFF) | \
> +					 BIT(VRR_DISPLAY_MODE_MEDIA))
> =20
>  struct rockchip_hdmi_qp {
>  	struct device *dev;
> @@ -753,6 +754,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
v, struct device *master,
>  			return dev_err_probe(hdmi->dev, ret,
>  					     "Failed to attach 'vrr_display_mode' property\n");
> =20
> +		connector->hdmi.qms_supported =3D true;

[Severity: High]
Does enabling QMS here work when switching QMS target frame rates or
updating vrr_display_mode without a full modeset?

When userspace changes CRTC VRR target frame rate limits
(VRR_MIN_NUMERATOR, VRR_MIN_DENOMINATOR, VRR_MAX_NUMERATOR,
VRR_MAX_DENOMINATOR) while vrr_enabled remains true,
rockchip_drm_atomic_check() only checks whether vrr_enabled toggled:

drivers/gpu/drm/rockchip/rockchip_drm_fb.c:rockchip_drm_atomic_check() {
	...
	if (old_crtc_state->vrr_enabled !=3D new_crtc_state->vrr_enabled) {
		new_crtc_state->mode_changed =3D true;
	...
}

Because drm_atomic_crtc_needs_modeset() remains false,
drm_atomic_helper_check_modeset() does not call
drm_atomic_add_affected_connectors(), so
drm_bridge_connector_atomic_check() ->
drm_atomic_helper_connector_hdmi_check() -> hdmi_validate_vrr() is never
run. As a result, hdmi_validate_qms(), hdmi_validate_vrr_limits(), and
hdmi_generate_emp_infoframe_vtem() are skipped.

Even when the connector is included in a non-modeset commit, dw-hdmi-qp
only calls drm_atomic_helper_connector_hdmi_update_infoframes() inside
dw_hdmi_qp_bridge_atomic_enable():

drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c:dw_hdmi_qp_bridge_atomic_enabl=
e() {
	...
	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
}

Consequently, dw_hdmi_qp_bridge_write_vtem_emp() is not called outside a
full modeset, leaving the PKT_EMP_VTEM_CONTENTS0..7 registers with stale
QMS_EN, Next_TFR, and M_CONST values. In addition, after the initial
modeset where old_conn_state->hdmi.qms_tfr_byte !=3D
new_conn_state->hdmi.qms_tfr_byte sets vrr_state->dynamic =3D true and
vtem->m_const =3D 0, subsequent commits at that constant QMS rate never
update the hardware VTEM EMP to transition M_CONST to 1.

[Severity: High]
How are QMS-only HDMI sinks and VTEM EMP validation handled when
VRR_DISPLAY_MODE_MEDIA is used?

First, an HDMI sink can support QMS (info->hdmi.vrr_cap.qms_capable =3D=3D
true) without supporting continuous Gaming-VRR
(info->hdmi.vrr_cap.supported =3D=3D false). However,
hdmi_generate_emp_infoframe_vtem() returns early if vrr_cap.supported is
false:

drivers/gpu/drm/display/drm_hdmi_state_helper.c:hdmi_generate_emp_infoframe=
_vtem() {
	...
	if (!info->hdmi.vrr_cap.supported)
		return 0;
	...
	switch (conn_state->vrr_display_mode) {
	...
	case VRR_DISPLAY_MODE_MEDIA:
		if (!connector->hdmi.qms_supported)
			return -EOPNOTSUPP;
		vtem->qms_en =3D true;
		vtem->next_tfr =3D conn_state->hdmi.qms_tfr_byte;
		vtem->m_const =3D !vrr->dynamic;
		break;
}

Similarly, dw_hdmi_qp_rockchip_encoder_atomic_check() sets the connector's
vrr_capable property using drm_display_info_is_vrr_capable(), which only
checks info->hdmi.vrr_cap.supported and ignores
info->hdmi.vrr_cap.qms_capable. Won't QMS-only sinks report vrr_capable as
false and fail to generate VTEM EMPs?

Second, when crtc_state->vrr_enabled is false, hdmi_validate_vrr() returns
0 early, but hdmi_generate_emp_infoframe_vtem() still runs without
checking crtc_state->vrr_enabled or info->hdmi.vrr_cap.qms_capable. If
conn_state->vrr_display_mode is VRR_DISPLAY_MODE_MEDIA on a sink where
vrr_cap.supported is true, won't it emit a VTEM EMP with qms_en =3D true and
a zero or stale qms_tfr_byte even when VRR is disabled or the sink does
not support QMS?

Third, in hdmi_validate_qms():

drivers/gpu/drm/display/drm_hdmi_state_helper.c:hdmi_validate_qms() {
	...
	if (info->hdmi.vrr_cap.qms_tfr_max)
		max_rate =3D info->hdmi.vrr_cap.vrr_max;
	else
		max_rate =3D 60;
}

If a sink advertises qms_tfr_max =3D true with vrr_max =3D 0 (indicating no
HF-VSDB upper limit below the mode refresh rate), max_rate becomes 0 and
cmp_fraction(rate_n, rate_d, max_rate, 1) <=3D 0 rejects every QMS target
frame rate.

[Severity: High]
Will VOP2 vtotal updates in vop2_crtc_atomic_flush() and
vop2_vp_handle_vblank() work properly for fixed-rate QMS modes?

In hdmi_validate_qms(), VRR_DISPLAY_MODE_MEDIA requires
drm_crtc_helper_vrr_is_fixed_rate(&crtc_state->vrr_state) to be true. In
drm_crtc_helper_vrr_flush(), fixed-rate VRR unconditionally returns false:

drivers/gpu/drm/drm_crtc_helper.c:drm_crtc_helper_vrr_flush() {
	...
	if (drm_crtc_helper_vrr_is_fixed_rate(vrr))
		return false;
}

Because vop2_crtc_atomic_flush() only calls vop2_vp_set_vrr_vtotal() when
drm_crtc_helper_vrr_flush() returns true, the initial frame in QMS mode is
not programmed at flush time.

Instead, fixed-rate cur_vtotal updates and fractional QMS frame-rate
dithering (such as 24000/1001 or 60000/1001 Hz) only happen in
drm_crtc_helper_vrr_vsync(). However, vop2_vp_handle_vblank() only calls
drm_crtc_helper_vrr_vsync() when vp->event is pending:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_vp_handle_vblank() {
	if (!vp->event)
		return;

	val =3D vop2_readl(vop2, RK3568_REG_CFG_DONE);

	if (!(val & BIT(vp->id))) {
		drm_crtc_send_vblank_event(crtc, vp->event);
		vp->event =3D NULL;
		drm_crtc_vblank_put(crtc);

		if (crtc->state->vrr_enabled)
			if (drm_crtc_helper_vrr_vsync(crtc->state))
				vop2_vp_set_vrr_vtotal(vp, crtc->state->vrr_state.cur_vtotal);
	}
}

Once the commit event is sent and drm_crtc_vblank_put() is called,
subsequent vblanks without a new atomic commit will return early at
!vp->event, stopping fractional vtotal dithering between base_vtotal and
base_vtotal + 1.

Furthermore, because both vop2_crtc_atomic_flush() and
vop2_vp_handle_vblank() guard the VRR helper calls with
if (crtc_state->vrr_enabled), the !crtc_state->vrr_enabled paths in
drm_crtc_helper_vrr_flush() and drm_crtc_helper_vrr_vsync() that reset
cur_vtotal and cur_err to 0 are never reached when VRR is disabled. If QMS
is disabled (resetting RK3568_VP_DSP_VTOTAL_VS_END to mode->crtc_vtotal
during modeset) and later re-enabled at the same integer-divisible target
rate, cur_vtotal already matches base_vtotal, so
drm_crtc_helper_vrr_vsync() returns false and vop2_vp_set_vrr_vtotal() is
never called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D21
