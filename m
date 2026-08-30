Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FCCC61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 04:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A3910E049;
	Sun, 30 Aug 2026 04:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mwaatOa4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98AA10E049
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 04:06:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2174600AE;
 Sun, 30 Aug 2026 04:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9B01F000E9;
 Sun, 30 Aug 2026 04:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788062794;
 bh=9Nna3LQOLyyqtOVGUeoSBmpbzPu69BENPdJ/uFtbodY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mwaatOa4P2GYCCpYy4Wt42z4eDCOsl6oWS4QY4EDWVc2OVrNDXiAYXYqyUj50RZ4e
 vARrSnFwBpywwdGg6USb59X5rP8rDXpdFsk/8eiZrMnk4P8gPwPLYlHee2omJomEXG
 d5O81AzzuEQ6obj62a+0cKdhdf8aGwQM9NNO2t+e9l2pE2vWxbmp16Q7fgWmvVuuB/
 9KK9xYC4JupggcXZFrojHrVhEUYJl5PDMYxhBrW9Nb3b1kHcC5//3Ec7clr/we02Hw
 SLF/REN6Ocr0nlTEURMgC81qPAs2mG9t33FO5LSFq/hag0t5w7D9XPCWambddn6fj5
 T6W6aYeWPXcIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amd/display: Honor Broadcast RGB for BT.2020
 RGB output
To: "Satyajit Roy" <edu042sjroy@proton.me>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260830035120.937992-3-edu042sjroy@proton.me>
References: <20260830035120.937992-1-edu042sjroy@proton.me>
 <20260830035120.937992-3-edu042sjroy@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 04:06:33 +0000
Message-Id: <20260830040634.3E9B01F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] NULL pointer dereference in `amdgpu_dm_atomic_commit_tail` whe=
n changing the `Broadcast RGB` connector property.
--

commit 25a82016e5e929302d7c5fe7edf379f4e6cec7a0
Author: Satyajit Roy <sroy14@alum.utk.edu>

drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output

This patch updates amdgpu_dm_get_output_color_space() to apply the Broadcast
RGB connector property for BT.2020 RGB output. It explicitly selects limited
range when requested, fixing an issue where it always defaulted to full ran=
ge.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 8a35e4df13cbf..f2f6a2a0db99e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -758,10 +758,14 @@ amdgpu_dm_get_output_color_space(const struct dc_cr=
tc_timing *dc_crtc_timing,
>  		break;
>  	case DRM_MODE_COLORIMETRY_BT2020_RGB:
>  	case DRM_MODE_COLORIMETRY_BT2020_YCC:
> -		if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB)
> -			color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
> -		else
> +		if (dc_crtc_timing->pixel_encoding =3D=3D PIXEL_ENCODING_RGB) {
> +			if (connector_state->hdmi.broadcast_rgb =3D=3D DRM_HDMI_BROADCAST_RGB=
_LIMITED)
> +				color_space =3D COLOR_SPACE_2020_RGB_LIMITEDRANGE;
> +			else
> +				color_space =3D COLOR_SPACE_2020_RGB_FULLRANGE;
> +		} else {
>  			color_space =3D COLOR_SPACE_2020_YCBCR_LIMITED;
> +		}
>  		break;
>  	case DRM_MODE_COLORIMETRY_DEFAULT: /* ITU601 */

[Severity: Critical]
This is a pre-existing issue, but does changing the Broadcast RGB property
crash the kernel via a NULL pointer dereference?

When userspace changes the Broadcast RGB property on a connector, DRM core
creates an atomic commit containing only the updated connector state. The A=
MD
driver's amdgpu_dm_atomic_check() does not add the associated CRTC to the
atomic state for these broadcast_rgb changes.

This leads to a crash in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
within amdgpu_dm_atomic_commit_tail(), where drm_atomic_get_new_crtc_state()
returns NULL:

	if (acrtc) {
		new_crtc_state =3D drm_atomic_get_new_crtc_state(state, &acrtc->base);
		old_crtc_state =3D drm_atomic_get_old_crtc_state(state, &acrtc->base);
	}

	/* Skip any modesets/resets */
	if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
		continue;

Since new_crtc_state is NULL, drm_atomic_crtc_needs_modeset() unconditional=
ly
dereferences it and crashes.

Even if this did not crash (for example on a disabled CRTC where modeset
might evaluate to false), execution proceeds to the fast-update path in
the same function:

	if ((new_con_state->hdmi.broadcast_rgb !=3D old_con_state->hdmi.broadcast_=
rgb) &&
		(dm_old_crtc_state->stream->output_color_space !=3D
			amdgpu_dm_get_output_color_space(&dm_new_crtc_state->stream->timing, new=
_con_state)))

For a disabled CRTC, stream is NULL, which causes dm_new_crtc_state->stream
and dm_old_crtc_state->stream to trigger a second unavoidable NULL pointer
dereference.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830035120.9379=
92-1-edu042sjroy@proton.me?part=3D2
