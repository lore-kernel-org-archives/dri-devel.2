Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21915606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqGkerBy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6448210E95A;
	Thu,  5 Nov 2026 17:45:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C5B10E95A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:45:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1AE2600E4;
 Thu,  5 Nov 2026 17:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364F61F000C1;
 Thu,  5 Nov 2026 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793900751;
 bh=guE8l6oqa1QOxja16LK+uh0Q4VM/Vd7l3EQwdhjgZFM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QqGkerBypbMA4kRFsPwIAXzHmFVBVpRzqJDauEMk0/mdQ43ofAWSg1c/Ae36aD0JZ
 zICewP92kZtzmY2WbYbnnYm1mfIfMIbpcCYQLfJjyp4BiiTT998dVtC5zv48c+MBbi
 +4QBPSJyEtxDwQerlc4jIR2OthaUQUaVUCeJExshc+bVSGKWJ4TR5wBTf1bytz1mXx
 L0hZigEzJj39eVeaWx/3RRr0ncZlNcOYIIjXoaRGvlnb2chPq74H1udD7FamuwkwTV
 JwETgSBjSDE5LjmbtDedrF4W+wxGiFP+dY8uGPI3Rgd16aRvHZ3Uy5GAY4bJjngrd0
 rPGIYJNkAgNEQ==
Message-ID: <sashiko-outbox-199656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/27] drm/connector: hdmi: Add QMS to VTEM EMP
 generation
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-19-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-19-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:45:50 +0000
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
- [High] drm/connector: hdmi: missing sink QMS capability check in VTEM gen=
eration
- [High] drm/connector: hdmi: vfront read from unpopulated adjusted_mode in=
 VTEM
--

commit cd1865130cc65c0f62c6e87bad2b21911a9e7073
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: hdmi: Add QMS to VTEM EMP generation

This commit updates hdmi_generate_emp_infoframe_vtem() to populate QMS VTEM
Extended Metadata Packet fields when conn_state->vrr_display_mode is set to
VRR_DISPLAY_MODE_MEDIA and the connector supports QMS.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 1e576dfbd856d..892079e41a0fb 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -890,11 +890,18 @@ static int hdmi_generate_emp_infoframe_vtem(const s=
truct drm_connector *connecto
>  		break;
>  	case VRR_DISPLAY_MODE_OFF:
>  		break;
> +	case VRR_DISPLAY_MODE_MEDIA:
> +		if (!connector->hdmi.qms_supported)
> +			return -EOPNOTSUPP;
> +		vtem->qms_en =3D true;
> +		vtem->next_tfr =3D conn_state->hdmi.qms_tfr_byte;
> +		vtem->m_const =3D !vrr->dynamic;
> +		break;

[Severity: High]
Does hdmi_generate_emp_infoframe_vtem() in
drivers/gpu/drm/display/drm_hdmi_state_helper.c also need to check the sink=
's
QMS capability in info->hdmi.vrr_cap.qms_capable?

In drivers/gpu/drm/drm_edid.c:drm_parse_hdmi_gaming_info(), sink QMS support
and Gaming-VRR support are tracked as independent flags:

	vrr->qms_capable =3D db[8] & DRM_EDID_QMS;

	if (cea_db_payload_len(db) < 9)
		return;

	vrr->vrr_min =3D db[9] & DRM_EDID_VRR_MIN_MASK;
	vrr->supported =3D (vrr->vrr_min > 0 && vrr->vrr_min <=3D 48);

Earlier in hdmi_generate_emp_infoframe_vtem(), VTEM generation returns early
when Gaming-VRR is not supported by the sink:

	if (!info->hdmi.vrr_cap.supported)
		return 0;

When drm_atomic_helper_connector_hdmi_check() -> hdmi_generate_infoframes()=
 ->
hdmi_generate_emp_infoframe_vtem() runs with conn_state->vrr_display_mode s=
et
to VRR_DISPLAY_MODE_MEDIA, this leads to two issues:

1. On a sink that supports QMS (info->hdmi.vrr_cap.qms_capable is true) but
not Gaming-VRR (info->hdmi.vrr_cap.supported is false),
hdmi_generate_emp_infoframe_vtem() returns 0 early with infoframe->set =3D =
false
and never generates the QMS VTEM packet.

2. On a sink that supports Gaming-VRR (info->hdmi.vrr_cap.supported is true)
but not QMS (info->hdmi.vrr_cap.qms_capable is false), the
VRR_DISPLAY_MODE_MEDIA case only checks source-side
connector->hdmi.qms_supported. Because vrr_display_mode can be set when
crtc_state->vrr_enabled is false (where hdmi_validate_vrr() returns 0 early=
),
selecting VRR_DISPLAY_MODE_MEDIA sets vtem->qms_en =3D true and transmits Q=
MS
VTEM packets to a sink that does not support QMS.

Should the early check allow either info->hdmi.vrr_cap.supported or
info->hdmi.vrr_cap.qms_capable, and the VRR_DISPLAY_MODE_GAME and
VRR_DISPLAY_MODE_MEDIA cases verify their respective sink capability flags?

>  	default:
>  		return -EINVAL;
>  	}
> =20
> -	if (vtem->game_vrr_en && !avi_vic) {
> +	if ((vtem->game_vrr_en || vtem->qms_en) && !avi_vic) {
>  		vtem->base_refresh_rate =3D drm_mode_vrefresh(&crtc_state->mode);
>  		vfront =3D crtc_state->adjusted_mode.crtc_vsync_start -
>  			 crtc_state->adjusted_mode.crtc_vdisplay;

[Severity: High]
When (vtem->game_vrr_en || vtem->qms_en) && !avi_vic is true in
drivers/gpu/drm/display/drm_hdmi_state_helper.c:hdmi_generate_emp_infoframe=
_vtem(),
is crtc_state->adjusted_mode guaranteed to be populated yet?

In drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_check_modeset(), t=
he
connector atomic_check callback
(drm_atomic_helper_connector_hdmi_check() -> hdmi_generate_infoframes() ->
hdmi_generate_emp_infoframe_vtem()) runs before mode_fixup() copies
new_crtc_state->mode into new_crtc_state->adjusted_mode:

	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
		if (!new_crtc_state->mode_changed &&
		    !new_crtc_state->connectors_changed)
			continue;

		drm_mode_copy(&new_crtc_state->adjusted_mode, &new_crtc_state->mode);
	}

As a result, during an initial modeset on a non-CEA mode (!avi_vic),
crtc_state->adjusted_mode is still zeroed and vfront evaluates to 0, while =
on
a mode change crtc_state->adjusted_mode still contains the previous mode's
timings.

Note that hdmi_validate_vrr() in the same file computes vfront from
crtc_state->mode:

	vfront =3D mode->crtc_vsync_start - mode->crtc_vdisplay;
	if (vfront < 0 || vfront > U8_MAX) {
		drm_dbg_kms(dev, "Vfront of %d would not fit in VTEM packet\n", vfront);
		return -EINVAL;
	}

Should hdmi_generate_emp_infoframe_vtem() also read crtc_vsync_start and
crtc_vdisplay from crtc_state->mode (matching base_refresh_rate just above
it and hdmi_validate_vrr())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D19
