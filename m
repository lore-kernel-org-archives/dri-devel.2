Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A386C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A446E10E53E;
	Mon, 21 Sep 2026 16:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j7sTECdK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9179010E53E
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:13:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AEA84395E;
 Mon, 21 Sep 2026 16:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF671F000FF;
 Mon, 21 Sep 2026 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007229;
 bh=NZhFGZZsGrRDZUrG97UPodF4A6mjgFaU7W7p93SYquA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j7sTECdKDqohXOe3WUZghnOGXC1J3ahsL759vuLZu7ykEmyP1upFWCr/A9MHFUc4Y
 cQJmqlDsiZee5sppH+rnvc23MdL0Wr//htxzWswPsqUArS1xp/raHwjWluC+QNvM0v
 SGj3EWEnUddnuPxd74GMwBygf4iELeP4DoNArQUDgG1EXZhm/dRc4uEh8yJsS5FXPk
 tyCHFTXIASYgXVtA05miz4InZB9nsK6fWXkCOqK+TDxSLe3xX+vzbG4Y/2s0nkq1/G
 zL3PDss5NzzjUjff0il/pkqIU5kx+8GRfMuTnrngKI+ain9szxlAqz2BsZGOyFj/IH
 6HWhH9nimITUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/25] drm/edid: Parse CinemaVRR flag from HDMI SCDS
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-12-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-12-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:13:48 +0000
Message-Id: <20260921161349.0FF671F000FF@smtp.kernel.org>
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
- [Medium] drm/edid: redundant cinema_vrr field introduces logic duplication
- [Medium] drm/edid: off-by-one payload length check in drm_parse_vrr_info()
--

commit 2696b9f8c9224d0c1b191489f857db21f792e625
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/edid: Parse CinemaVRR flag from HDMI SCDS

HDMI's extension to EDID contains a flag which is used by sinks to
signal that they support CinemaVRR. When CinemaVRR is enabled, some
VRR is possible even if the minimum VRR range is set to 0.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index a1494028e0f5e..cc6f2ba8c9f4d 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6314,6 +6314,11 @@ static void drm_parse_vrr_info(struct drm_display_=
info *info, const u8 *hf_scds)
>  	struct drm_monitor_range_info *range =3D &info->monitor_range;
>  	const int pld_len =3D cea_db_payload_len(hf_scds);
> =20
> +	if (pld_len < 9)
> +		return;

[Severity: Medium]
Does this length check prematurely abort parsing for valid HDMI Forum VSDBs
that provide exactly an 8-byte payload?

Since cea_db_payload_len() returns the number of payload bytes following the
tag, and payload bytes are indexed starting from 1 up to pld_len, accessing
hf_scds[8] requires pld_len to be at least 8.

When pld_len =3D=3D 8, it seems the valid 8th payload byte containing the
CinemaVRR flag would be incorrectly skipped.

> +
> +	info->hdmi.cinema_vrr =3D !!(hf_scds[8] & DRM_EDID_CINEMA_VRR);
> +
>  	if (pld_len < 10)
>  		return;

[ ... ]

> @@ -6392,7 +6397,7 @@ static void drm_parse_hdmi_forum_scds(struct drm_co=
nnector *connector,
> =20
>  	drm_parse_vrr_info(info, hf_scds);
> =20
> -	if (info->monitor_range.min_vfreq > 0)
> +	if (info->monitor_range.min_vfreq > 0 || hdmi->cinema_vrr)

[Severity: Medium]
Are we consuming a newly added redundant field here instead of the existing
vrr_cap.cinema_vrr?

Since the driver already correctly parses the CinemaVRR capability from the
exact same EDID bit in drm_parse_hdmi_gaming_info() into
hdmi->vrr_cap.cinema_vrr, could using this new duplicate field cause driver
state inconsistencies if the two parsing logics diverge?

>  		hdmi->vrr_capable =3D true;
>  	else
>  		hdmi->vrr_capable =3D false;
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index b18684d039d5e..b147b8474f1a9 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -383,6 +383,9 @@ struct drm_hdmi_info {
> =20
>  	/** @vrr_capable: The sink supports variable refresh rate */
>  	bool vrr_capable;
> +
> +	/** @cinema_vrr: The sink supports "CinemaVRR" */
> +	bool cinema_vrr;

[Severity: Medium]
Could this introduce a duplicate field when vrr_cap.cinema_vrr already exis=
ts
in the same structure?

>  };
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D12
