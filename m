Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B766ECD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FAE10F216;
	Mon,  8 Jun 2026 11:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WeXF7oHH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F0110E109
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE07243B2E;
 Mon,  8 Jun 2026 11:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AFB1F00893;
 Mon,  8 Jun 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780918223;
 bh=U/2hT8b/aylB13PKB2K42nUffEA6pspPd57ZFz96qco=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WeXF7oHHDfXSQWDy07hKs1JNJEdDDP9L6g0vyqINb6Atl3882z0NVzCtIsySNlXYq
 RV7E0DAjqWbwrOXQGLjHgesHvr3pGESeK57Kw3w6lj9Fo6CxAvKpJvn+Z9cVZXRErx
 wNKzHP+Wc7DW+4G+7HV4QIfa3JE3uTUKsoVpVNS1E5NQzbIvh7+BuaUG398JVt3qUZ
 ql/cQeE+bgmfm9eYMGWTApClv22JvyE1s2MpSzq9rA4ljTk+TduF5lNG5Sip5YJngN
 h2E17inbVB7khbuJ4+ng0GtlHRMRneAbPfBKkDHWaWqA2Xtide5pCmRrFZ5pv9r89I
 aDkgYmdGj4E8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/display: hdmi: Only allow BPC values of 8, 10,
 12 and 16
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-hdmi-max-bpc-fix-v1-1-6e8dcebc7274@collabora.com>
References: <20260608-hdmi-max-bpc-fix-v1-1-6e8dcebc7274@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 11:30:22 +0000
Message-Id: <20260608113023.67AFB1F00893@smtp.kernel.org>
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
- [High] The function `sink_supports_format_bpc` explicitly permits 16 BPC =
for RGB444 and YCBCR444 formats without verifying if the sink's EDID actual=
ly supports 48-bit deep color.
--

commit 767fa3cc832e8b93f697ad91bcc66e5b3b1ed85d
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/display: hdmi: Only allow BPC values of 8, 10, 12 and 16

As per the comment in sink_supports_format_bpc(), CTA-861-F defines that
only bits-per-channel values of 8, 10, 12 and 16 are allowed for HDMI.
Allowing more than this has surprising consequences for the atomic check
phase.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 4867edbf2622b..b06499dbfe8b3 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -419,6 +419,16 @@ sink_supports_format_bpc(const struct drm_connector =
*connector,
>  		return false;
>  	}
> =20
> +	switch (bpc) {
> +	case 8:
> +	case 10:
> +	case 12:
> +	case 16:

[Severity: High]
This is a pre-existing issue, but does explicitly allowing 16 BPC here
expose a missing validation check for 48-bit deep color further down in
sink_supports_format_bpc()?

When checking DRM_OUTPUT_COLOR_FORMAT_RGB444 and
DRM_OUTPUT_COLOR_FORMAT_YCBCR444, the code validates 10 BPC and 12 BPC
against the EDID flags, but completely omits checking 16 BPC against
DRM_EDID_HDMI_DC_48:

drivers/gpu/drm/display/drm_hdmi_state_helper.c:sink_supports_format_bpc() {
	...
	case DRM_OUTPUT_COLOR_FORMAT_RGB444:
		...
		if (bpc =3D=3D 10 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC=
_30)) {
			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n");
			return false;
		}

		if (bpc =3D=3D 12 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC=
_36)) {
			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n");
			return false;
		}

		drm_dbg_kms(dev, "RGB format supported in that configuration.\n");
		return true;
	...
}

If the TMDS clock limit permits it, the driver might incorrectly conclude
that the sink supports 16 BPC and program the hardware accordingly, which
could result in a black screen if the monitor doesn't actually support
48-bit deep color.

Should a check for (info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_48)
be added for the RGB444 and YCBCR444 cases?

> +		break;
> +	default:
> +		return false;
> +	}
> +
>  	if (!info->is_hdmi &&
>  	    (format !=3D DRM_OUTPUT_COLOR_FORMAT_RGB444 || bpc !=3D 8)) {
>  		drm_dbg_kms(dev, "DVI Monitors require an RGB output at 8 bpc\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-hdmi-max-b=
pc-fix-v1-0-6e8dcebc7274@collabora.com?part=3D1
