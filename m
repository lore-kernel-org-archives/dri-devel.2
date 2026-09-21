Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA2C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865CA10E27B;
	Mon, 21 Sep 2026 16:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dTnD5Dnf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF41210E27B
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:19:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8768601F0;
 Mon, 21 Sep 2026 16:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E271F00893;
 Mon, 21 Sep 2026 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007595;
 bh=zcXvOX8HXk0pqL15rKWKftcVr9d/XStx7WD6/tD794o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dTnD5Dnf1tLggZI4Yk7HMqaB1TJ6BHXpVVuwgckbjbUx29DMM/aoP4VEsReEJ6U9F
 DdZb92QxDbjZCdoaGajpGp3iHQRMKnjMvHs/P6+BOng1BYkojHwYxaY/TteQHi9f2P
 fMULVwQu1IwU1kQl4PPwUJX7uQ3b94iK2UP5XZVQmzk8nuMsSJhgYK4ypGUDJ08VmD
 J7SpY06Nn94kl+Um49gYprxk43UB/8+nwoBrn2lnoenxNenCBYcB1csw/X4dkLqOZS
 HzNjUbVD8cnIkNxbdW0719UAr0hhnSaE/6LpPG5/bHuUC8D2+AE1JSRHu6NlWRGktN
 XfgM7KiV3VIpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/25] drm/edid: Parse QMS TFR min/max flags from
 HDMI SCDS
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-16-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-16-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:19:55 +0000
Message-Id: <20260921161955.80E271F00893@smtp.kernel.org>
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
- [Medium] drm/edid: off-by-one error in HF-VSDB payload length check skips=
 QMS TFR flags
--

commit f56b6e153864bbb4bece6ab04dc75e7a1bb4de03
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/edid: Parse QMS TFR min/max flags from HDMI SCDS

HDMI has two flags in the SCDS EDID extension that signal which minimum
and maximum refresh rate the sink wishes to use when doing QMS ("Quick
Media Switching").
   =20
This commit adds definitions for these flags and parses them based on the
publicly available libdisplay-info source code. The parsed QMS TFR min/max
results are stored as booleans in drm_hdmi_info.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 5a7d3b7e65daa..4fe754328b1c8 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6332,6 +6332,12 @@ static void drm_parse_vrr_info(struct drm_display_=
info *info, const u8 *hf_scds)
>  	if (!range->max_vfreq)
>  		range->max_vfreq =3D (FIELD_GET(DRM_EDID_VRR_MAX_UPPER_MASK, hf_scds[9=
]) << 8) |
>  				    hf_scds[10];
> +
> +	if (pld_len < 12)
> +		return;
> +
> +	info->hdmi.qms_tfr_min =3D !!(hf_scds[11] & DRM_EDID_QMS_TFR_MIN);
> +	info->hdmi.qms_tfr_max =3D !!(hf_scds[11] & DRM_EDID_QMS_TFR_MAX);

[Severity: Medium]
Does this length check accidentally skip valid 11-byte payloads?

In drm_parse_vrr_info(), cea_db_payload_len(hf_scds) returns the exact numb=
er
of payload bytes declared in the EDID block header. In the CTA-861 data blo=
ck
representation, payload bytes are located at array indices 1 through pld_le=
n.

When pld_len is 11, hf_scds[11] is a valid access to the last payload byte.
However, the if (pld_len < 12) check evaluates to true and returns early,
incorrectly skipping the parsing of the QMS TFR min/max flags for displays
that advertise them in a block with exactly 11 bytes of payload.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D16
