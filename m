Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F0606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjdjT1fk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C492A10E187;
	Thu,  5 Nov 2026 16:53:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DC810E0C1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:53:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F01D2422A1;
 Thu,  5 Nov 2026 16:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAE11F0093A;
 Thu,  5 Nov 2026 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793897622;
 bh=MKVhRLUg1ibyeQWhtDG4VYup0ErHEmwiv446gQdyVg0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FjdjT1fk74189MsqymHsr9KBslm2L873CuBn2Ygc82hMItIR6mdbGQDzFJbwMhZpN
 Zhxp8eLN2k/SsFUH/wQFjn6YRNNz/CijVBJmQnXC0mDLcYst/hDKPjm+d8O/lfNtn1
 ukPXjoaQGok6Wm3x0erzHw0sIbb+IN0Y8DzbQDP1jFv1BDcy2zlkn+sFsm7yynX41I
 CSolf2OhjPOTDLyJPNJ7xgrm4P3JxtudFgNc2o+yNXig/RSCi9cy0rkWftzPVMuzgb
 dSxvb3DXue8aYkf2D9HRGDMdzMg5SY050Hh/AFmXrmzHe+05Tg0fyWIDgAImTX/bBb
 F2a30/qjAeIOw==
Message-ID: <sashiko-outbox-199555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/27] drm/connector: hdmi: Add VTEM EMP generation
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-5-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-5-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:53:42 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/connector: hdmi: unpopulated adjusted_mode in hdmi_generate_em=
p_infoframe_vtem()
- [Medium] drm/connector: hdmi: invalid VTEM EMP state when vrr_display_mod=
e is Off
--

commit 404c1e52433cdea0b822a43bb7471dc9ca224073
Author: Derek Foreman <derek.foreman@collabora.com>

drm/connector: hdmi: Add VTEM EMP generation

This commit adds VTEM Extended Metadata Packet (EMP) generation and state
tracking to the HDMI connector state helpers to support variable refresh
rate signalling on VRR-capable sinks.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index c1a84e30441a6..497af307a690c 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -853,6 +853,61 @@ static int hdmi_generate_hdmi_vendor_infoframe(const=
 struct drm_connector *conne
>  	return 0;
>  }
> =20
> +static int hdmi_generate_emp_infoframe_vtem(const struct drm_connector *=
connector,
> +					    struct drm_connector_state *conn_state)
> +{
> +	const struct drm_display_info *info =3D &connector->display_info;
> +	const struct drm_crtc_state *crtc_state =3D
> +		drm_atomic_get_crtc_state(conn_state->state, conn_state->crtc);
> +	struct drm_connector_hdmi_infoframe *infoframe =3D
> +		&conn_state->hdmi.infoframes.vtem;
> +	struct hdmi_emp_infoframe_vtem *vtem =3D
> +		&infoframe->data.vtem;
> +	const struct drm_crtc_vrr_state *vrr =3D &crtc_state->vrr_state;
> +	int vfront;
> +	u8 avi_vic;
> +
> +	infoframe->set =3D false;
> +
> +	if (!connector->hdmi.funcs->vtem.write_infoframe)
> +		return 0;
> +
> +	if (!info->hdmi.vrr_cap.supported)
> +		return 0;
> +
> +	if (conn_state->hdmi.infoframes.avi.set)
> +		avi_vic =3D conn_state->hdmi.infoframes.avi.data.avi.video_code;
> +	else
> +		avi_vic =3D 0;
> +
> +	hdmi_emp_infoframe_vtem_init(vtem);
> +
> +	switch (conn_state->vrr_display_mode) {
> +	case VRR_DISPLAY_MODE_GAME:
> +		vtem->game_vrr_en =3D true;
> +		vtem->m_const =3D !vrr->dynamic;
> +		break;
> +	case VRR_DISPLAY_MODE_OFF:
> +		break;

[Severity: Medium]
When conn_state->vrr_display_mode is VRR_DISPLAY_MODE_OFF, breaking out of
the switch allows execution to reach infoframe->set =3D true at the end of
hdmi_generate_emp_infoframe_vtem().

Because new_frame->set is true, write_or_clear_infoframe() in
drm_atomic_helper_connector_hdmi_update_infoframes() will call
write_infoframe() instead of clear_infoframe():

drivers/gpu/drm/display/drm_hdmi_state_helper.c:write_or_clear_infoframe() {
	if (new_frame->set)
		return write_infoframe(connector, funcs, type, new_frame);

	if (old_frame->set && !new_frame->set)
		return clear_infoframe(connector, funcs, type);
...
}

In turn, hdmi_emp_infoframe_vtem_pack() packs a VTEM packet with
Data_Set_Length hardcoded to 4 (ptr[9] =3D 4) while game_vrr_en,
fva_factor_m1, base_vfront, and base_refresh_rate are all 0.

Should VRR_DISPLAY_MODE_OFF return 0 with infoframe->set left as false so
that write_or_clear_infoframe() invokes clear_infoframe() to stop VTEM EMP
transmission when VRR is disabled?

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (vtem->game_vrr_en && !avi_vic) {
> +		vtem->base_refresh_rate =3D drm_mode_vrefresh(&crtc_state->mode);
> +		vfront =3D crtc_state->adjusted_mode.crtc_vsync_start -
> +			 crtc_state->adjusted_mode.crtc_vdisplay;

[Severity: High]
Is crtc_state->adjusted_mode populated when
hdmi_generate_emp_infoframe_vtem() runs during atomic_check?

In drm_atomic_helper_check_modeset(), the connector atomic_check callbacks
(drm_atomic_helper_connector_hdmi_check() -> hdmi_generate_infoframes() ->
hdmi_generate_emp_infoframe_vtem()) run before mode_fixup() copies
new_crtc_state->mode into new_crtc_state->adjusted_mode:

drivers/gpu/drm/drm_atomic_helper.c:mode_fixup() {
	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
		if (!new_crtc_state->mode_changed &&
		    !new_crtc_state->connectors_changed)
			continue;

		drm_mode_copy(&new_crtc_state->adjusted_mode, &new_crtc_state->mode);
	}
...
}

When enabling a previously disabled CRTC with a non-CEA mode (!avi_vic) and
VRR_DISPLAY_MODE_GAME, crtc_state->adjusted_mode is still zero-initialized,
so vfront is calculated as 0. When switching modes on an already-active
CRTC, crtc_state->adjusted_mode still holds the previous mode's timings
from atomic_duplicate_state(), causing vtem->base_vfront to be computed
from the old mode (or causing atomic_check to fail with -EINVAL if the old
mode had vfront > U8_MAX).

Should this compute vfront from crtc_state->mode (or
connector_state_get_mode(conn_state)), matching how vtem->base_refresh_rate
and hdmi_validate_vrr() read the mode timings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D5
