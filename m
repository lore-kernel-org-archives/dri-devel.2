Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEE5C5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6863310F03B;
	Thu, 30 Jul 2026 18:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dhRc3QE9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA5710F03B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:41:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44170417DF;
 Thu, 30 Jul 2026 18:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F331F000E9;
 Thu, 30 Jul 2026 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785436877;
 bh=Dxf2m9s+WPfdOGNnFFrLrBmTL3JOJdzENC3Gn8RgjiU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dhRc3QE9aQPhMEeKMOAMNgsRnMKq4LYrADOryFx3GufOK1Y9FjMThYQb3Y/qsijCb
 blM4JsMsiUnNIueveNDxcMZavB/AuBZAI5QJ3F+XF1K5E0Oomt05Mdbq2bKyvTfh8K
 aazWo+7vVMwC/2EW2Ry5hssp0J57lV9Jrp7u0GJRydLxcn2FUBV3uigWuUDbTMeEP9
 e924syU99vLUrS9hn8HaNLo6/mkg8PX0nKuLQECTpAdJwFKGOD+ykpIUSucT+KyR/Y
 /RTE0FuiUvKy1PcRTY97wsVobiFXONjQV7jKl8yPdokhPeqJoL/miyQKL0oRu4WaCk
 CQFKolaAe6SwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] fbdev: tdfxfb: Attempt to detect if the card wasn't
 booted
To: "Daniel Palmer" <daniel@0x0f.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730182640.2808572-3-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
 <20260730182640.2808572-3-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:41:16 +0000
Message-Id: <20260730184116.F0F331F000E9@smtp.kernel.org>
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
- [High] The driver unconditionally rejects perfectly working cards if the =
video BIOS ROM is inaccessible or in an unsupported format.
--

--- Patch [2]: [PATCH 2/5] fbdev: tdfxfb: Attempt to detect if the card was=
n't booted ---
commit e450df3d917986ae9c59e1033b55fdddafa9cf19
Author: Daniel Palmer <daniel@0x0f.com>
Subject: fbdev: tdfxfb: Attempt to detect if the card wasn't booted

This commit adds hardware initialization checks to tdfxfb_probe() by
attempting to read the configuration from the video BIOS. If the register
values do not match the BIOS config, it rejects the card to avoid providing
a blank display.

> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
[ ... ]
> +/*
> + * Try to work out if the card was booted or not, just checks
> + * if the register reported memory amount matches what the BIOS
> + * reports for now.
> + */
> +static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
> +{
> +	struct tdfx_par *par =3D info->par;
> +	struct tdfx_bios_cfg cfg;
> +
> +	if (tdfxfb_get_bios_cfg(pdev, &cfg) &&
> +	    tdfx_inl(par, DRAMINIT0) =3D=3D le32_to_cpu(cfg.draminit0))
> +		return 0;
> +

[Severity: High]
Will this unconditionally reject working cards if the video BIOS ROM is
inaccessible or in an unsupported format?

Looking at tdfxfb_get_bios_cfg(), it can naturally return false if
pci_map_rom() fails. This is common on architectures without PCI ROM
support, or if the ROM BAR is disabled. It will also return false if the
BIOS ROM does not contain the specific 3dfx OEM configuration table.

Because of the logical && short-circuit, if tdfxfb_get_bios_cfg() fails to
read the config, the tdfx_inl() check is skipped and the function falls
through to return -ENODEV.

Could this cause a regression for hardware that was previously supported but
lacks a readable BIOS ROM?

> +	dev_err(&pdev->dev,
> +		"Card hasn't booted and is unusable\n");
> +	return -ENODEV;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730182640.2808=
572-1-daniel@0x0f.com?part=3D2
