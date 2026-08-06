Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC933C5AC7A
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5AA10F2D5;
	Thu,  6 Aug 2026 21:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UdTCVW/B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0AE10F2D5
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 21:07:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40E0443E10;
 Thu,  6 Aug 2026 21:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8311F000E9;
 Thu,  6 Aug 2026 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786050461;
 bh=HdMMDFFFo7S+Q/encWLSaBaRIndV3dUEjky1IZr7hx8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UdTCVW/B0/czJO9pcQ82fyymIkJAfYqUW1aKOV9hocMjgAcW/AuS0sFK9Wy5cCGAj
 ctN2LnFLF5MEbPL9QT58jzY/HWAq7XzveqamIuUik2bcQCtnY2n3iY7JR9MSYMaWZO
 kb3qLqheszQd1Im2kbWqr4DIXWR6iHp3DCHUfNe5I6DdSlkVE2QMcNMjsn64kBRRo7
 C/9Dz6MryCf0D0HdubdzzGBD82z5/DZM6GDE4yqGcf4cqx0lxmuIlAi2pjeOW5zCCT
 X1BpPRmUtyGj967Q/MXG5u+GahwtXBgwfieRoWkp+iBR1/qY2RvGBWqKY069+JKRdo
 a1d3b0ryaYeZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/amd/display: Add HDMI 2.1 VRR support from
 HF-VSDB
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806205449.16806-4-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260806205449.16806-4-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:07:40 +0000
Message-Id: <20260806210740.ED8311F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The HF-VSDB VRR fallback is unconditionally overwritten to false=
 for HDMI TMDS sinks because they lack an AMD FreeSync VCP code.
--

--- Patch [3]: [PATCH v2 3/4] drm/amd/display: Add HDMI 2.1 VRR support fro=
m HF-VSDB ---
commit 3db5053c0ea2b238965bfd80def111ee342642b8
Author: Fangzhi Zuo <jerry.zuo@amd.com>

drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB

This commit adds support for HDMI 2.1 VRR capabilities derived from the
HDMI Forum VSDB (HF-VSDB) as a fallback. It parses the VRR ranges and sets
the FreeSync capability appropriately when an AMD VSDB is missing or invali=
d.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
[ ... ]
> @@ -3856,6 +3865,59 @@ void amdgpu_dm_update_freesync_caps(struct drm_con=
nector *connector,
[ ... ]
> +		/*
> +		 * If AMD VSDB didn't provide a valid FreeSync range, fall back to
> +		 * the HDMI 2.1 VRR capability parsed from the HF-VSDB.
> +		 */
> +		if (!freesync_capable && connector->display_info.hdmi.vrr_cap.supporte=
d) {
[ ... ]
> +				if (amdgpu_dm_connector->max_vfreq -
> +				    amdgpu_dm_connector->min_vfreq > 10)
> +					freesync_capable =3D true;

[Severity: Medium]
Will this newly enabled HF-VSDB fallback be unconditionally overwritten to=
=20
false for HDMI TMDS sinks?

For a monitor advertising VRR only via HF-VSDB on an HDMI TMDS link, the
AMD VSDB parsing fails, leaving sink->edid_caps.freesync_vcp_code as 0.

While this new fallback block correctly sets freesync_capable to true, later
in amdgpu_dm_update_freesync_caps(), there is an existing check:

	if ((sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
		as_type =3D=3D FREESYNC_TYPE_PCON_IN_WHITELIST) &&
		(!sink->edid_caps.freesync_vcp_code ||
		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported=
)))
		freesync_capable =3D false;

Since sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A and freesync_vcp_code is 0,
does this existing logic silently disable the fallback feature being
introduced here?

> +
> +				connector->display_info.monitor_range.min_vfreq =3D
> +					amdgpu_dm_connector->min_vfreq;
> +				connector->display_info.monitor_range.max_vfreq =3D
> +					amdgpu_dm_connector->max_vfreq;
> +			}
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806205449.1680=
6-1-jerry.zuo@amd.com?part=3D3
