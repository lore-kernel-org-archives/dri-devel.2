Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BC5C5DF8C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 04:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BD310E01F;
	Mon, 24 Aug 2026 04:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GpVc9cg3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D369810E01F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:16:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AFAA41AA0;
 Mon, 24 Aug 2026 04:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C294E1F000E9;
 Mon, 24 Aug 2026 04:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787544962;
 bh=kiHuxWS4+yRfFsEvGsgIlrGm5ToShlnfWvcD6E0KTQU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GpVc9cg3Qi3ctHlv+DyGNSm35ck4iLhdyJFCAnw5OJ5UNb51GJn/yOfGVV5aI3d6y
 brrMFh+sGhcyQBinzfL5PPAACCib2joQtdE34GwCL3I26MpYbCjCp4yy+OXRBSPfmJ
 sW06HwAEOwjlrtM+mstYKnRZAZVmr/Ev9VgacC/YmOz9KRNr+zIoqbyj064a/U2L9B
 9C9aeF8tXYnJij4ZrRBLImf1bePpFG8qWAWdXZ9jqLf86zqjBll0Sb+IC21rCfjS6p
 F6jJsVcx7lT8MdIaK32BDHcEt3QaluSQl2GT9UWryV6+kJCotZ0O+67xRv+Sf/nKvm
 lDLqV2Be0/HdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/edid: Add HDR Static Metadata Type 1 quirk for LG
 UltraGear
To: Xela <git@xela.zone>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260824040209.22517-1-git@xela.zone>
References: <20260824040209.22517-1-git@xela.zone>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 04:16:02 +0000
Message-Id: <20260824041602.C294E1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The calculation for minimum luminance in `drm_calculate_luminance_=
range` always evaluates to 0 due to flawed integer division.
- [High] `drm_calculate_luminance_range` incorrectly calculates the display=
's maximum luminance using the Max Frame-average Luminance field instead of=
 the Max Luminance field.
--

--- Patch [1]: [PATCH] drm/edid: Add HDR Static Metadata Type 1 quirk for L=
G UltraGear ---
commit f96110d8b7a4665ac963f7b030033a65f6235f0a
Author: Xela <git@xela.zone>

drm/edid: Add HDR Static Metadata Type 1 quirk for LG UltraGear

The LG UltraGear monitor (PNP ID GSM 0x7766) advertises HDR support in
its CTA-861 Extension block with SMPTE ST 2084 (PQ) EOTF support
(byte 0x9e =3D 0x05) and valid desired content luminance descriptors
(351 cd/m^2 max CLL/FALL at bytes 0xa0-0xa2).

However, due to a factory firmware bug, the HDR Static Metadata Data
Block descriptor byte (byte 0x9f) is reported as 0x00 instead of 0x01,
omitting the Static Metadata Type 1 capability bit (bit 0).

Because of this omitted bit, drm_parse_hdr_metadata_block() sets
metadata_type to 0. Consequently, drm_calculate_luminance_range()
rejects the block, and userspace attempts to perform atomic KMS commits
configuring HDR output metadata fail with -EINVAL (Error 22), preventing
compositors (Plasma, Gamescope, MPV) from engaging HDR on this display.

Introduce EDID_QUIRK_FORCE_HDR_STATIC_METADATA_TYPE1 to force the Static
Metadata Type 1 descriptor bit for displays with this defective EDID block,
and register the LG UltraGear (GSM 0x7766) in the EDID quirk table.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 07970e5b5f65e..dd279fad17a42 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c

[ ... ]

> @@ -5498,6 +5503,10 @@ drm_parse_hdr_metadata_block(struct drm_connector =
*connector, const u8 *db)
>  	hdr_metadata->eotf =3D eotf_supported(db);
>  	hdr_metadata->metadata_type =3D hdr_metadata_type(db);
> =20
> +	if (drm_edid_has_internal_quirk(connector,
> +				       EDID_QUIRK_FORCE_HDR_STATIC_METADATA_TYPE1))
> +		hdr_metadata->metadata_type |=3D BIT(HDMI_STATIC_METADATA_TYPE1);
> +
>  	if (len >=3D 4)
>  		hdr_metadata->max_cll =3D db[4];
>  	if (len >=3D 5)

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be an issue
in how these values are used in drm_calculate_luminance_range() which is
called just after this block.

Does drm_calculate_luminance_range() incorrectly calculate max luminance
using the Max Frame-average Luminance field (max_fall) instead of the
Max Luminance field (max_cll)?

drivers/gpu/drm/drm_edid.c:drm_calculate_luminance_range() {
	...
	max_avg =3D hdr_metadata->max_fall;
	min_cll =3D hdr_metadata->min_cll;
	...
	q =3D max_avg >> 5;
	r =3D max_avg % 32;
	max =3D (1 << q) * pre_computed_values[r];
	...
}

It seems max_avg maps to max_fall, entirely ignoring hdr_metadata->max_cll.
Could this lead to underreporting the maximum peak luminance?

[Severity: High]
This is another pre-existing issue, but does the minimum luminance calculat=
ion
in drm_calculate_luminance_range() always evaluate to 0?

drivers/gpu/drm/drm_edid.c:drm_calculate_luminance_range() {
	...
	/* min luminance: maxLum * (CV/255)^2 / 100 */
	q =3D DIV_ROUND_CLOSEST(min_cll, 255);
	min =3D max * DIV_ROUND_CLOSEST((q * q), 100);
	...
}

Since min_cll is bounded to 255 (a 1-byte value), q will be at most 1, and
DIV_ROUND_CLOSEST(1, 100) truncates to 0. Would this force the computed
minimum luminance limit to always be exactly 0 for all panels? Can this
integer math sequence be adjusted to prevent the loss of precision?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824040209.2251=
7-1-git@xela.zone?part=3D1
