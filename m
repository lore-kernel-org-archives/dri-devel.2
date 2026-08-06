Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B6C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA93810F2E6;
	Thu,  6 Aug 2026 21:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iKz41C7w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A695710F2E6
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 21:13:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4725D42B1A;
 Thu,  6 Aug 2026 21:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0901A1F000E9;
 Thu,  6 Aug 2026 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786050838;
 bh=c47GMJ11rYKnMFpI7qDVqrPzeSJ6nt7tiMOxZx+8Xyg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iKz41C7wpI/TrrvY3nYERJytB0fN/B2yWOLHEaP6jYpxWLbdO8hKYK8+iX19c+px2
 N4H99OVMwYoyNiMIMFoHyQtiQRyxxTOnN3AHlIKpDZj5C/sDtU1DJKAifNrSbsKKkr
 lliHK1uPyYWIOcDZGITf13p8p7OKwtrN0a+jaI4f9IPPiEp6B+/sKsrK/86LwHBV83
 VwR/XJl/FQTcluv6cW/v2/tnM6Jo1cKLI4xMmZ4AvmaLy30BeRWdh9+4egoyrVmxc2
 GsoKeUaZi7ONfLZDeO5BHSd8+JklXLfxaoFQ7L+d9iha9to6RJ7/CaZmuSDcgfnwls
 kJi4AX06+ATCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/amd/display: Add 2.1 FreeSync support for
 AMD VSDB EDID Block
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806205449.16806-2-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260806205449.16806-2-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:13:57 +0000
Message-Id: <20260806211358.0901A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Dereferencing deprecated `new_stream->sink` pointer risks a NULL p=
ointer dereference.
- [High] VTEM packet overwrites the FreeSync SPD infopacket and is misroute=
d to the hardware's SPD slot.
- [Medium] Unconditional VTEM transmission to all HDMI FRL displays, includ=
ing non-VRR sinks.
- [Medium] 32-bit integer overflow when calculating `fieldRateInHz` for VTE=
M packets in ultra-high bandwidth modes.
- [Low] Unused parameter `signal` in `build_infopacket_header_vtem()`.
--

--- Patch [1]: [PATCH v2 1/4] drm/amd/display: Add 2.1 FreeSync support for=
 AMD VSDB EDID Block ---
commit b0ebd1a49b36a5e82edcd0396a4c4d22fe23f9d3
Author: Fangzhi Zuo <Jerry.Zuo@amd.com>

drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block

This commit adds 2.1 FreeSync support for AMD VSDB EDID block over HDMI FRL=
.=20
It updates the capability parsing to accept HDMI FRL signals and builds the=
=20
required VTEM info packet. The VTEM data set length is dynamically set to 0=
=20
when no VTEM feature is enabled to comply with HDMI GCTS.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 7e484adb4120f..1fa078cdba527 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -229,6 +230,9 @@ void amdgpu_dm_update_freesync_state_on_stream(
>  		&vrr_infopacket,
>  		pack_sdp_v1_3);
> =20
> +	if (new_stream->sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_FRL)
            ^^^^^^^^^^^^^^^^

[Severity: High]
Can this dereference a NULL pointer? The sink pointer inside
dc_stream_state is officially deprecated and could be NULL in headless or
writeback scenarios. Would it be safer to use new_stream->signal here?

[Severity: Medium]
Will this transmit VTEM packets even to sinks that do not support VRR or FV=
A?
There doesn't appear to be a check for vrr_params.send_info_frame, which
could result in unconditional VTEM transmission to all HDMI FRL displays,
potentially violating the HDMI 2.1 specifications.

> +		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);
                                                                      ^^^^^=
^^^^^^^^^^

[Severity: High]
Does this overwrite the previously built AMD Vendor Specific InfoFrame
(VSIF)? By passing &vrr_infopacket, the newly created VTEM packet is stored
in the same local variable.

Additionally, since dc_resource.c writes stream->vrr_infopacket exclusively
to the hardware's SPD slot, will this cause the VTEM packet to be incorrect=
ly
transmitted through the SPD slot instead of the VTEM slot?

> +
>  	new_crtc_state->freesync_vrr_info_changed |=3D
>  		(memcmp(&new_crtc_state->vrr_infopacket,
>  			&vrr_infopacket,
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.=
c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index f5ac4bf32a784..e956c707ac507 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c

[ ... ]

> @@ -644,6 +659,100 @@ void mod_build_hf_vsif_infopacket(const struct dc_s=
tream_state *stream,
>  		info_packet->valid =3D true;
>  }
> =20
> +static void build_vtem_infopacket_data(const struct dc_stream_state *str=
eam,
> +		const struct mod_vrr_params *vrr, int fva_factor,
> +		struct dc_info_packet *infopacket)
> +{
> +	unsigned int fieldRateInHz;
> +
> +	/* FVA Factor setting */
> +	setFieldWithMask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__FVA_FACTOR_M=
1,
> +			(fva_factor > 0)?(fva_factor-1):0);

[ ... ]

> +		fieldRateInHz =3D stream->timing.pix_clk_100hz * 100;
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Can this multiplication overflow for ultra-high bandwidth modes? For displa=
ys
like 8K@120Hz, stream->timing.pix_clk_100hz * 100 could exceed the 32-bit
unsigned integer limit before the subsequent division. Should this be cast
to a 64-bit integer?

> +		fieldRateInHz /=3D stream->timing.h_total;
> +		fieldRateInHz =3D (fieldRateInHz + stream->timing.v_total / 2)
> +						/ stream->timing.v_total;
> +
> +	}
> +

[ ... ]

> +static void build_infopacket_header_vtem(enum signal_type signal,
                                            ^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Is the signal parameter needed here? It doesn't appear to be evaluated or
used anywhere within the body of this function.

> +		struct dc_info_packet *infopacket)
> +{
> +	// HEADER
> +
> +	// HB0, HB1, HB2 indicates PacketType VTEMPacket
> +	infopacket->hb0 =3D 0x7F;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806205449.1680=
6-1-jerry.zuo@amd.com?part=3D1
