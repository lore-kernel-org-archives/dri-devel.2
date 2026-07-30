Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E99C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A7210F039;
	Thu, 30 Jul 2026 18:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aW6//+os";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F06910F039
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:34:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FAF260A66;
 Thu, 30 Jul 2026 18:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0717B1F000E9;
 Thu, 30 Jul 2026 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785436451;
 bh=8R8btklmtp0Jy4E7UWA7oDa1ASx8Q9ewFep9ghD//4k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aW6//+os4mHIrdxVn/50qlO10EwaBF1Noy5yPt47EpxAnoP0p/QVR0tCdhdj1ekF9
 jm5cdz7rxNHQKYKTRlokIs2/2ZADn2D9mRKFHBXyowFpoSaShvVNvoOWAoUvfQFJTH
 rOkloJ8q3rXCNMyYCxiI0UHVO1Wjy4fc6TN9Li2wmohpKQwQMggkppiTmErXaJc6aU
 BfHGhsRqD1ABmNerePwixoSvZYAM25vc0SD4UfCP5EZo86GrR+hU751aaxjeEwueb0
 SYZVdhZMW7HebVvk6UT2QLoNa/eaoimkeyJZXfeSqqq/VszIcyQtG1ButcE9xO9HRp
 2iP2BS1VBq6rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] fbdev: tdfxfb: Add helper to read config table from
 BIOS
To: "Daniel Palmer" <daniel@0x0f.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730182640.2808572-2-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
 <20260730182640.2808572-2-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:34:10 +0000
Message-Id: <20260730183411.0717B1F000E9@smtp.kernel.org>
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
- [Low] The patch introduces `tdfxfb_get_bios_cfg` and `tdfx_pll_to_khz` as=
 `static` functions but does not use them anywhere in the file. This trigge=
rs `-Wunused-function` compiler warnings, which break builds with `CONFIG_W=
ERROR` enabled.
--

--- Patch [1]: [PATCH 1/5] fbdev: tdfxfb: Add helper to read config table f=
rom BIOS ---
commit d67a333d81585d56234b84350edd145b08f26be1
Author: Daniel Palmer <daniel@0x0f.com>

fbdev: tdfxfb: Add helper to read config table from BIOS

This commit adds a helper to get the config table from the video BIOS in
preparation for manually booting cards.

> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
[ ... ]
> +/*
> + * Convert a pllctrl register value back to a frequency in kHz.
> + * Formula from 3dfx documentation.
> + */
> +static u32 tdfx_pll_to_khz(u32 pll)
> +{
> +	return (14318 * (((pll >> 8) & 0xff) + 2) /
> +		(((pll >> 2) & 0x3f) + 2)) >> (pll & 3);
> +}
> +
> +/* Layout of the "OEM config" table in voodoo 3 BIOS */
> +struct tdfx_bios_cfg {
[ ... ]
> +};
> +
> +#define TDFX_ROM_CFG_PTR	0x50
> +
> +static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
> +				struct tdfx_bios_cfg *cfg)
> +{

[Severity: Low]
Does adding this static function and its helper tdfx_pll_to_khz without any
callers trigger a -Wunused-function compiler warning that breaks builds with
CONFIG_WERROR enabled?=20

Could these functions be marked with __maybe_unused, or introduced in the
same commit as their callers to ensure the tree compiles cleanly at every
commit?

> +	u16 romcfg, oemcfg;
> +	void __iomem *rom;
> +	size_t romsize;
> +	u8 *image;
> +	u32 khz;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730182640.2808=
572-1-daniel@0x0f.com?part=3D1
