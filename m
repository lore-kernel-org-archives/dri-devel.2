Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B90C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7336A10E02C;
	Mon,  7 Sep 2026 11:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n/U+XN4i";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8276010E02C
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:32:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A35A460D91;
 Mon,  7 Sep 2026 11:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BAF1F00ACA;
 Mon,  7 Sep 2026 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788780745;
 bh=pkbfKIaPCrjQK6Ih/hM04+T4+ucDK2ncZcxyLruFONs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n/U+XN4iAi96bi3JBKLBha6WjP3IK2t3sVfo7gL987dDHgvriwCPBdLXQSkj9IUdJ
 1C0+/9pdhHTVOlfAyAPNtXVg1zLcCgEAIW3+Sg173Prv1Vxutc4Qaz7CjR28Qc1xZ3
 tB6tCWfsofXApvVvmOhG2pHRYsPhtmrXz0iE3TmOgpZQWf5LMeiVYWp7UThViBKW6P
 jFby8DrPa2p1hvY40ik6x4JvcKxo3O0xr03S1iIJ9lLIrx1ukWgUXNFb97Y6yhBpmG
 1NZEfgf1AQJdhH1SxkSJsnLR6Z0t5bgIyU5+GCqjDcTlHwX/ooS8Gwna9jjfx1PAmE
 QFRpk1b+7Cj0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amd/display: support HDMI 1.4 3D modes on HDMI
 connectors
To: "Adrian Betschart" <adrian.betschart@cinemaone.ch>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907100626.54465-2-adrian.betschart@cinemaone.ch>
References: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
 <20260907100626.54465-2-adrian.betschart@cinemaone.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:32:24 +0000
Message-Id: <20260907113225.39BAF1F00ACA@smtp.kernel.org>
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
- [High] CRTC timings for 3D Frame Packing modes are silently overwritten w=
ith native 2D timings when hardware scaling is enabled, breaking 3D output.
- [High] FreeSync Video Mode optimization overwrites 3D mode flags, silentl=
y downgrading 3D streams to 2D.
--

commit 70b8f690db70299cb56618e8af16a07b44f95bd2
Author: Adrian Betschart <adrian.betschart@cinemaone.ch>
Subject: drm/amd/display: support HDMI 1.4 3D modes on HDMI connectors

This commit enables stereo modes (such as 3D Frame Packing, Top-and-Bottom,
and Side-by-Side) derived from a sink's HDMI VSDB on HDMI connectors. It
treats them as 2D streams by packing the views in the frame itself and reli=
es
on the HDMI vendor infoframe to inform the sink.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 0e71ba498e8aa..7a2beb1756249 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
[ ... ]
> @@ -887,7 +906,15 @@ STATIC_IFN_KUNIT void fill_stream_properties_from_dr=
m_display_mode(
>  	 */
>  	timing_out->pixel_encoding =3D requested_encoding;
> =20
> +	/*
> +	 * The source packs both views into the frame itself (side-by-side,
> +	 * top-and-bottom, or the doubled frame-packing timing), so the display
> +	 * core scans it out as a plain 2D stream and only the HDMI vendor
> +	 * infoframe tells the sink how the frame is laid out. Any DC stereo
> +	 * timing format would make the hardware treat the surface as two views.
> +	 */
>  	timing_out->timing_3d_format =3D TIMING_3D_FORMAT_NONE;
> +	stream->vsif_3d_format =3D amdgpu_dm_vsif_3d_format(mode_in->flags);

[Severity: High]
If amdgpu_dm_is_freesync_video_mode() matched earlier in
create_stream_for_sink(), will this silently downgrade the 3D stream to 2D?

In create_stream_for_sink(), if a 3D mode (like Side-by-Side or Top-and-Bot=
tom)
matches the base timings of a FreeSync mode, the entire mode struct is
overwritten:

create_stream_for_sink() {
	...
	if (recalculate_timing) {
		freesync_mode =3D amdgpu_dm_get_highest_refresh_rate_mode(aconnector, fal=
se);
		drm_mode_copy(&saved_mode, &mode);
		...
		drm_mode_copy(&mode, freesync_mode);
		...
	}
}

This wipes the DRM_MODE_FLAG_3D_* flags from mode_in. When
amdgpu_dm_vsif_3d_format(mode_in->flags) is called here, it will evaluate t=
o 0
and fall back to TIMING_3D_FORMAT_NONE, causing the HDMI vendor infoframe to
never be sent and leaving the sink in 2D mode.

>  	timing_out->display_color_depth =3D amdgpu_dm_convert_color_depth_from_=
display_info(
>  		connector,
>  		(timing_out->pixel_encoding =3D=3D PIXEL_ENCODING_YCBCR420),
[ ... ]
> @@ -1451,6 +1478,9 @@ create_stream_for_sink(struct drm_connector *connec=
tor,
>  	struct dc_sink *sink =3D NULL;
> =20
>  	drm_mode_init(&mode, drm_mode);
> +	/* frame packing scans out both views plus the active space in one fram=
e */
> +	if (mode.flags & DRM_MODE_FLAG_3D_FRAME_PACKING)
> +		drm_mode_set_crtcinfo(&mode, CRTC_STEREO_DOUBLE);

[Severity: High]
Are these CRTC_STEREO_DOUBLE timings at risk of being silently overwritten
if hardware scaling is enabled?

Later in create_stream_for_sink(), the mode is passed for timing adjustment=
s:

create_stream_for_sink() {
	...
	} else {
		decide_crtc_timing_for_drm_display_mode(
				&mode, preferred_mode, scale);
	...
}

If scale is true, decide_crtc_timing_for_drm_display_mode() unconditionally
copies the standard 2D timings from the preferred mode:

decide_crtc_timing_for_drm_display_mode() {
	if (scale_enabled || ...) {
		if (native_mode->crtc_clock)
			copy_crtc_timing_for_drm_display_mode(native_mode, drm_mode);
	}
}

Will this wipe out the stereo-doubled timings just set here, misconfiguring
the hardware scanout with standard 2D timings instead and leading to
truncated/corrupted 3D output?

>  	memset(&saved_mode, 0, sizeof(saved_mode));
> =20
>  	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_WRITEBACK) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907100626.5446=
5-1-adrian.betschart@cinemaone.ch?part=3D1
