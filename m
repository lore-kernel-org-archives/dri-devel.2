Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C0C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6976910E7D5;
	Mon,  7 Sep 2026 12:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A8C+SgIJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CC810E7DA
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:42:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46F4540BDE;
 Mon,  7 Sep 2026 12:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D321F00A3D;
 Mon,  7 Sep 2026 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788784929;
 bh=cQo0LZ/uQqw62oq7NjHGpBnUZxdbPfX41ofoqStI4XM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A8C+SgIJnj6IM1ZoZBzbvXQzA6TFPKS/oRitiNNpYymcs/HYb+LaPi9TNNgGjIVkj
 g3xVVZLrEwEBNGHDeZ/uguPshvNZNrdTOTzyMTW40THkrDCK6sKzxs6FzG/tFkzeGq
 6HlaeKRXXvMuE1XfyzcBnziEDE7k7JiezkSL+aivL0TPWl2OAw1dgZcuYRrsEInCNZ
 QJ4BrNBekC2AvLwC8T+SffzzUsj9GTvMtHTs2IeKAPeMQHawxG5DBXUZwOmP5dzrCW
 Ao7S98NYgO/nxn6a3Ss0eHdK4JHMkloPGuSYcAt75XF+gWUNlhtIpo29PTB0ZCWVEP
 rqFCMdog0mO2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/amd/display: support HDMI 1.4 3D modes on
 HDMI connectors
To: "Adrian Betschart" <adrian.betschart@cinemaone.ch>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907115229.64477-2-adrian.betschart@cinemaone.ch>
References: <20260907115229.64477-1-adrian.betschart@cinemaone.ch>
 <20260907115229.64477-2-adrian.betschart@cinemaone.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:42:08 +0000
Message-Id: <20260907124209.08D321F00A3D@smtp.kernel.org>
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
- [Low] Bitwise AND operator is incorrectly used on an enum value, causing =
false positives for other 3D formats.
- [Low] Ternary check for 3D frame packing on saved_mode is logically dead =
code and modifies an unused variable.
--

commit 69c7b6a13ec338ae92b4b6e911a4bfd520258818
Author: Adrian Betschart <adrian.betschart@cinemaone.ch>

drm/amd/display: support HDMI 1.4 3D modes on HDMI connectors

Allow the stereo modes drm_edid derives from a sink's HDMI VSDB on
HDMI connectors, and drive them the way a 2D stream is driven. The
source lays both views out in the frame itself, and the HDMI vendor
infoframe tells the sink how the frame is laid out.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 0e71ba498e8aa..aa3f47632de06 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c

[ ... ]

> @@ -1451,6 +1491,9 @@ create_stream_for_sink(struct drm_connector *connec=
tor,
>  	struct dc_sink *sink =3D NULL;
> =20
>  	drm_mode_init(&mode, drm_mode);
> +	/* frame packing scans out both views plus the active space in one fram=
e */
> +	if (mode.flags & DRM_MODE_FLAG_3D_FRAME_PACKING)
> +		drm_mode_set_crtcinfo(&mode, CRTC_STEREO_DOUBLE);

[Severity: Low]
Does this bitwise AND incorrectly match other 3D formats? The 3D flags share
bits in the DRM_MODE_FLAG_3D_MASK. For example, DRM_MODE_FLAG_3D_TOP_AND_BO=
TTOM
is 7<<14 and DRM_MODE_FLAG_3D_FRAME_PACKING is 1<<14, so this evaluates to =
true
for Top-and-Bottom modes.

Even though drm_mode_set_crtcinfo() filters this internally via a switch
statement, should this use an exact match check like:
(mode.flags & DRM_MODE_FLAG_3D_MASK) =3D=3D DRM_MODE_FLAG_3D_FRAME_PACKING?

>  	memset(&saved_mode, 0, sizeof(saved_mode));
> =20
>  	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_WRITEBACK) {

[ ... ]

> @@ -1530,7 +1573,9 @@ create_stream_for_sink(struct drm_connector *connec=
tor,
>  	}
> =20
>  	if (recalculate_timing)
> -		drm_mode_set_crtcinfo(&saved_mode, 0);
> +		drm_mode_set_crtcinfo(&saved_mode,
> +				      (saved_mode.flags & DRM_MODE_FLAG_3D_FRAME_PACKING) ?
> +				      CRTC_STEREO_DOUBLE : 0);

[Severity: Low]
Is this ternary check for 3D frame packing on saved_mode reachable?

The recalculate_timing variable is evaluated to true only when
amdgpu_dm_is_freesync_video_mode() returns true, but that function was
modified in this patch to explicitly reject any mode with 3D flags.

Since saved_mode will never contain a 3D flag when recalculate_timing is
true, and saved_mode is modified here but never consumed again, could this
dead code be simplified?

> =20
>  	/*
>  	 * If scaling is enabled and refresh rate didn't change

[ ... ]

> @@ -2449,7 +2494,9 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid=
(struct drm_connector *connec
>  	if (!test_mode)
>  		goto fail;
> =20
> -	drm_mode_set_crtcinfo(test_mode, 0);
> +	drm_mode_set_crtcinfo(test_mode,
> +			      (test_mode->flags & DRM_MODE_FLAG_3D_FRAME_PACKING) ?
> +			      CRTC_STEREO_DOUBLE : 0);

[Severity: Low]
Similar to the check in create_stream_for_sink(), does this bitwise AND
incorrectly pass CRTC_STEREO_DOUBLE for non-frame-packing 3D modes like
Top-and-Bottom due to the overlapping mask values?

> =20
>  	stream =3D amdgpu_dm_create_validate_stream_for_sink(connector, test_mo=
de,
>  						 to_dm_connector_state(connector->state),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907115229.6447=
7-1-adrian.betschart@cinemaone.ch?part=3D1
