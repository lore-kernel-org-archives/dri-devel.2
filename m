Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B45C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B0610E341;
	Thu,  6 Aug 2026 21:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TWtGStVI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFD310E341
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 21:08:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8432C41996;
 Thu,  6 Aug 2026 21:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C10A1F000E9;
 Thu,  6 Aug 2026 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786050528;
 bh=sicgOMFNdQQpckSuuVCuL3qmID0aKxf2MAOVK6iqnEo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TWtGStVIHcgm+hFyMhx0NDfCKB7yPdbEjcdT17bQM/NK3ZqvhkpGqyqn/bnDabpog
 KNMjpU2BoZ2ymfqQ1UPPrLqgO9xif87oXQXdpK7Qm3ziMFZefSNCg07Ch555Kc6oai
 LuGsGrrgslwheyWcKGlkcYRKdSF1raCBFYy8729sxlwVchrtg3PZfY/ob6WLi5QLHq
 htzSCHlcGZQ57G2FAfPOZKn9JH0m8Pi/x+iYXVW4AB4csNc0Yasa2H5+sSAw7pdutA
 sS0HYaWHnOHHq7uU3lAIlEZnuzXBKMnuRTsMfEUbt14Vbb0WZcV8yl8YPrtGUS1uON
 5t49bVUJ6/xWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/amd/display: Add HDMI ALLM support
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806205449.16806-5-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260806205449.16806-5-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:08:47 +0000
Message-Id: <20260806210848.3C10A1F000E9@smtp.kernel.org>
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

New issues:
- [High] Enabling ALLM replaces the HDMI 1.4 VSIF with the HF-VSIF, droppin=
g `hdmi_vic` signaling required for legacy 4K formats.

Pre-existing issues:
- [High] HDMI VRR (VTEM) is artificially restricted to FRL links, breaking =
HDMI VRR over TMDS.
--

--- Patch [4]: [PATCH v2 4/4] drm/amd/display: Add HDMI ALLM support ---
commit 4ebe402fb25e863740386dee88638b0ecc01f7ba
Author: Fangzhi Zuo <jerry.zuo@amd.com>

drm/amd/display: Add HDMI ALLM support

This commit adds HDMI 2.1 Auto Low-Latency Mode (ALLM) support by setting
ALLM_Mode in the HF-VSIF. It builds the HF-VSIF when the sink advertises AL=
LM
and the content type is Game or Gaming-VRR is active.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index df39bc70ec6c3..6cfd7526ab56a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1572,8 +1572,22 @@ create_stream_for_sink(struct drm_connector *conne=
ctor,
>  	update_stream_signal(stream, sink);
> =20
>  	if (stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
> -	    stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL)
> -		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, f=
alse);
> +	    stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL) {
> +		/*
> +		 * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
> +		 * advertises ALLM in the SCDS and the content type is Game.
> +		 * Setting content-type =3D Game is how userspace requests the
> +		 * Sink's low-latency mode (HDMI GCTS HF1-56).
> +		 */
> +		bool allm =3D connector->display_info.hdmi.allm &&
> +			stream->content_type =3D=3D DISPLAY_CONTENT_TYPE_GAME;
> +
> +		drm_dbg_driver(dev,
> +			       "ALLM: set mode: sink_allm=3D%d content_type=3D%d -> ALLM_Mode=
=3D%d\n",
> +			    connector->display_info.hdmi.allm, stream->content_type, allm);
> +
> +		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, allm, al=
lm);

[Severity: High]
Does enabling ALLM replace the HDMI 1.4 VSIF with the HF-VSIF, dropping
hdmi_vic signaling for legacy 4K formats?

When ALLM is requested, calling mod_build_hf_vsif_infopacket() with allm=3D=
true
overrides the VSIF payload in vsp_infopacket.

Looking at the implementation in info_packet.c:mod_build_hf_vsif_infopacket=
():

if (!bALLM) {
        info_packet->sb[1] =3D 0x03;
        ...
} else {
        info_packet->sb[1] =3D 0xD8;
        ...

This acts as a mutually exclusive switch rather than populating two separate
info frames. If a user selects a display mode requiring hdmi_vic and sets t=
he
content type to Game, will this cause the display to lose format signaling =
and
result in a black screen or corrupted display?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index cb49184813dee..c4bc6e717df93 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -252,6 +252,37 @@ void amdgpu_dm_update_freesync_state_on_stream(
>  	new_stream->vrr_infopacket =3D vrr_infopacket;

[Severity: High]
This is a pre-existing issue, but does restricting VTEM generation strictly=
 to
FRL links break HDMI VRR on HDMI 2.0 displays?

HDMI 2.1 VRR requires the VTEM packet to operate. Looking earlier in
amdgpu_dm_update_freesync_state_on_stream():

if (new_stream->sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_FRL)
        mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopack=
et);

By checking for SIGNAL_TYPE_HDMI_FRL, it appears the driver will silently
skip VTEM generation for TMDS-only sinks that support VRR (via firmware
updates or HDMI 2.1 features on TMDS), causing VRR to fail to engage.

>  	new_stream->allow_freesync =3D mod_freesync_get_freesync_enabled(&vrr_p=
arams);
> =20
> +	/*
> +	 * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=3D1 when the sink
> +	 * advertises ALLM in the SCDS and either the content type is Game
> +	 * (HF1-56) or Gaming-VRR is active (VRR_EN=3D1, HF1-58 step 8.3.1).
> +	 * HDMI 2.1 7.6.6.
> +	 */
> +	if (new_stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
> +	    new_stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL) {
> +		struct dc_info_packet vsp_infopacket =3D {0};
> +		bool sink_allm =3D aconn && aconn->base.display_info.hdmi.allm;
> +		bool allm =3D sink_allm &&
> +			(new_stream->content_type =3D=3D DISPLAY_CONTENT_TYPE_GAME ||
> +			 vrr_params.state =3D=3D VRR_STATE_ACTIVE_VARIABLE ||
> +			 vrr_params.state =3D=3D VRR_STATE_ACTIVE_FIXED);
> +		bool allm_changed;
> +
> +		mod_build_hf_vsif_infopacket(new_stream, &vsp_infopacket, allm, allm);
> +
> +		allm_changed =3D memcmp(&new_stream->vsp_infopacket, &vsp_infopacket,
> +				      sizeof(vsp_infopacket)) !=3D 0;
> +		new_crtc_state->freesync_vrr_info_changed |=3D allm_changed;
> +		new_stream->vsp_infopacket =3D vsp_infopacket;

[Severity: High]
As noted above in create_stream_for_sink(), does unconditionally replacing
vsp_infopacket with the HF-VSIF here cause the display to lose hdmi_vic
signaling when Gaming-VRR is active?

> +
> +		if (allm_changed)
> +			drm_dbg_driver(adev_to_drm(adev),
> +				       "ALLM: flip on crtc=3D%u: sink_allm=3D%d content_type=3D%d vr=
r_state=3D%d -> ALLM_Mode=3D%d\n",
> +				    new_crtc_state->base.crtc->base.id,
> +				    sink_allm,
> +				    new_stream->content_type, vrr_params.state, allm);
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806205449.1680=
6-1-jerry.zuo@amd.com?part=3D4
