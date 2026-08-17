Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53127C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 00:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59ED810E384;
	Mon, 17 Aug 2026 00:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OGETsYg3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F05610E384
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 00:50:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C78242AED;
 Mon, 17 Aug 2026 00:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E061C1F000E9;
 Mon, 17 Aug 2026 00:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786927857;
 bh=csMzkmvZM6ovibwvnyq8sVg03lhsBbUMBJmhiB65kBU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OGETsYg36wedp2cogx0qZfJWu+57E8zFEDbN6v+Ig6fMMmpzmUK1uqL0bRf9KxvOX
 4jr9g3HxTVVTRqYXqiFOawYxjpI0ZL4En6wsuLZAOtZ9jA6RmkcDoL7cQ9SYucSVux
 rQpwQ4B2/YpHXrbrgZRxg3GUz3lfn/oLC8D4MRD/2Ja+C8LkNJ5qmsjL83f6w3eJ17
 UXOz0/ko6IvRZ2mP8iumgx3Wg8NXH5Tx2XcxJa7y3G4Hf1KWdjnfGZVKBr7RYEqDV9
 hkB2He9Eim/9Fwi3S0r2UWDDJP4owqy/j+/6r1Y4VsvKpPAZQ87R3mNaDJAqItyVbY
 q39IVtkaqQRjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/radeon: fix internal display on iMac11, 1
 (RV770/DCE3.1)
To: "Gilles Risch" <gilles.risch@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817004326.3192-1-gilles.risch@gmail.com>
References: <180318e7-0432-403a-b87b-6f9a455bb86a@gmail.com>
 <20260817004326.3192-1-gilles.risch@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 00:50:56 +0000
Message-Id: <20260817005056.E061C1F000E9@smtp.kernel.org>
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
- [Medium] Missing ATOM_ENCODER_CMD_DP_VIDEO_OFF for iMac11,1 in DPMS disab=
le path
--

--- Patch [1]: [PATCH v6] drm/radeon: fix internal display on iMac11, 1  (R=
V770/DCE3.1) ---
commit 6714fa0de0a69a7e28cd2cf7fe610715f038e79d
Author: Gilles Risch <gilles.risch@gmail.com>
drm/radeon: fix internal display on iMac11, 1 (RV770/DCE3.1)

This commit adds a DMI quirk to route the iMac11,1 internal display
through Link B of the DIG encoder. It also sets the FRAC_FB_DIV PLL flag
and enables DP_VIDEO_ON explicitly for this hardware to fix a blank screen
issue.

> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c

[ ... ]

> @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>  		if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connecto=
r) {
>  			/* DP_SET_POWER_D0 is set in radeon_dp_link_train */
>  			radeon_dp_link_train(encoder, connector);
> -			if (ASIC_IS_DCE4(rdev))
> +			if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
>  				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0);
>  		}

[Severity: Medium]
Should the corresponding disable paths (standby, suspend, off) also
include the iMac11,1 DMI check for turning the video off?

Later in radeon_atom_encoder_dpms_dig(), the ATOM_ENCODER_CMD_DP_VIDEO_OFF
command is only sent if ASIC_IS_DCE4(rdev):

    case DRM_MODE_DPMS_STANDBY:
    case DRM_MODE_DPMS_SUSPEND:
    case DRM_MODE_DPMS_OFF:

        if (ASIC_IS_DCE4(rdev)) {
            if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && c=
onnector)
                atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VID=
EO_OFF, 0);
        }

Does the iMac11,1 (which is DCE3.1) need ATOM_ENCODER_CMD_DP_VIDEO_OFF
sent here to properly stop the stream before the link is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817004326.3192=
-1-gilles.risch@gmail.com?part=3D1
