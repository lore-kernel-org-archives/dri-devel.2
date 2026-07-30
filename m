Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831C4C5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEAAD10F041;
	Thu, 30 Jul 2026 18:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g7Gws1Iv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3336510F041
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:41:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 169CF41819;
 Thu, 30 Jul 2026 18:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C340E1F00A3A;
 Thu, 30 Jul 2026 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785436913;
 bh=sRBT9hvzJ14wFzzAsYZ0JpehxMLfTIKpD4YFf4xP8+4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g7Gws1IvyD5Kbp8IyvkXj3iI8koH6eomWH//j9CYyfemDs4Ho8WbCiVouecXh49OA
 /PE7WSRnNcJIpJ8g1GtJpIms/XWyV2EnW4VR1iS4XAZhVOf+jpwKyI6rmyFg0q+1EE
 z7XzMLs7GNNLiFEQ2FYKlnbWxBm5OX44GSIgv4dzy5E3slqd52qltHhl4ZfxpIzR9R
 YQwnJbixhepsznlSFN/DmozuLfA36tjuxNShr0hCBjaKCtzkkRfT8Xv8rtXtZbzTuy
 bHdTWGG/w4J1HS+k6jts1zXq7hg1U+LifxK7BTxDZYW3ldTEq1A+rN5goPZWYlZRJX
 5IqtdCu9cTlHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] fbdev: tdfxfb: Manually boot unbooted cards
To: "Daniel Palmer" <daniel@0x0f.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730182640.2808572-4-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
 <20260730182640.2808572-4-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 18:41:52 +0000
Message-Id: <20260730184152.C340E1F00A3A@smtp.kernel.org>
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
- [High] PCI MMIO writes are not flushed before udelay() or hardware depend=
ent operations, and wmb() is misused to flush PCI writes.
- [High] The miscinit0 field from the BIOS configuration table is ignored a=
nd incorrectly hardcoded to 0.
--

--- Patch [3]: [PATCH 3/5] fbdev: tdfxfb: Manually boot unbooted cards ---
commit 2a277f3197dc755d9c642a91cfd45c9bd1ee77f8
Author: Daniel Palmer <daniel@0x0f.com>

fbdev: tdfxfb: Manually boot unbooted cards
   =20
If the card is detected as being unbooted it isn't too difficult
to use the config table in its BIOS to fire it up so do it.

> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> index 1d8bffe1e9fdf..4c1d847c89c9d 100644
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
[ ... ]
> @@ -414,19 +415,62 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pde=
v,
>   * Try to work out if the card was booted or not, just checks
>   * if the register reported memory amount matches what the BIOS
>   * reports for now.
> + *
> + * If we have a BIOS config table attempt to manually boot the
> + * card if needed.
>   */
>  static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
>  {
[ ... ]
> +	/* memory clock, and the graphics clock if the card wants one */
> +	tdfx_outl(par, PLLCTRL1, mempll);
> +	if (gfxpll)
> +		tdfx_outl(par, PLLCTRL2, gfxpll);
> +	/* PLL lock */
> +	udelay(100);

[Severity: High]
Does this delay reliably wait for the PLL lock?

tdfx_outl uses writel which performs a posted write on PCI buses, so the de=
lay
might start before the PCI bridge actually delivers the write to the device.

Would adding a dummy read to a device register (e.g. tdfx_inl) before the
udelay ensure the posted writes are flushed?

> +
> +	tdfx_outl(par, MISCINIT1, miscinit1);
> +	tdfx_outl(par, DRAMINIT0, draminit0);
> +	tdfx_outl(par, DRAMINIT1, draminit1);
> +
> +	/* Make sure the DRAM config is applied before continuing */
> +	wmb();

[Severity: High]
Does wmb actually flush the PCI posted writes?

A CPU memory barrier typically only flushes CPU store buffers, not PCI
posted write buffers, so the DRAM configuration might still be pending
when the subsequent wake-up commands are sent.

> +
> +	/* SDRAM/SGRAM wake up: load the mode register */
> +	tdfx_outl(par, DRAMDATA, dram_mode);
> +	tdfx_outl(par, DRAMCOMMAND, 0x10d);
> +
> +	tdfx_outl(par, LFBMEMORYCONFIG, 0x00001fff);
> +	tdfx_outl(par, MISCINIT0, 0);

[Severity: High]
Is this hardcoded 0 intentional?

The rest of the fields (like miscinit1) are populated from the BIOS
configuration table. It appears le32_to_cpu(cfg.miscinit0) is completely
ignored, which could overwrite essential hardware configurations managed
by MISCINIT0 with 0.

> +
> +	/* Make sure the remaining config is applied */
> +	wmb();
> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730182640.2808=
572-1-daniel@0x0f.com?part=3D3
