Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5971C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB0710E8AB;
	Wed, 16 Sep 2026 11:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JbGJ8Dvz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23BA10E043
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:20:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B29442E05;
 Wed, 16 Sep 2026 11:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056C71F0089D;
 Wed, 16 Sep 2026 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789557643;
 bh=MuGTO7xoHRG8oa2hRVVZ6JnW5iHJxnSna20OIii0sQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JbGJ8Dvz6ETZ28IQkDw+xEDYSSEChicD4eq9if2TYDu3kpM9GtclPeRgq1kTfszzd
 o1+VKNFizpPvWc9X+Tr87ILGr36KaS2UgVPLmlJCNCylxAGoXwVzWrEuA/q0xtWW1j
 1uRBiwoq+OJoze9WAs02NZWH32hLy8VUQepUX2+USHk+9UYaXDhYljhVOMmB5Bwc/I
 Y07/QOFMKz9G/ZXHugT6oJw+1d1304tbvAU0LJ9n4dABHiA1Qpis7/iF6qfbPrUc81
 kVN8Xp03oyuUfcZTydnRHG6fqwqQbGMJBUs54IQ87PD59FcXPFlSH9d0RHa1BBgiHv
 kPn8g1u6Ew4Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/13] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260916110825.102631-6-angelogioacchino.delregno@collabora.com>
References: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
 <20260916110825.102631-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 11:20:42 +0000
Message-Id: <20260916112043.056C71F0089D@smtp.kernel.org>
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
- [High] drm/mediatek: mtk_dsi: IRQ enablement in bind leaves hardware uncl=
ocked
--

commit 341145986d590feda3b9b8dd572d45aaa3bc1404
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable interrupt at component bind time

This patch changes the DSI interrupt to be requested with IRQF_NO_AUTOEN
during probe, deferring its enablement to the component bind phase.
It aims to prevent interrupt storms or premature hardware resets before
the display controller is fully bound and ready.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 28ba532210ff5..6ac6daa61e684 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -1101,6 +1102,8 @@ static int mtk_dsi_bind(struct device *dev, struct =
device *master, void *data)
>  		return ret;
>  	}
> =20
> +	enable_irq(dsi->irq);

[Severity: High]
Does enabling the IRQ here leave the hardware vulnerable to unclocked MMIO
reads if an interrupt fires before power-on?

The hardware clocks (engine_clk, digital_clk) are not enabled until
mtk_dsi_poweron() is called. If an interrupt fires immediately after this
enable_irq() call, or during any power-off state where mtk_dsi_poweroff() h=
as
been called (since disable_irq() is only in mtk_dsi_unbind()), the interrupt
handler mtk_dsi_irq() will execute:

mtk_dsi_irq() {
    ...
    status =3D readl(dsi->regs + DSI_INTSTA) & flag;
    ...
}

On MediaTek SoCs, reading unclocked APB/AHB registers like DSI_INTSTA can
cause a bus hang resulting in a synchronous external abort (kernel panic).

Could this happen consistently if the bootloader asserts the interrupt, or
randomly during suspend/DPMS off if a spurious interrupt occurs?

> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916110825.1026=
31-1-angelogioacchino.delregno@collabora.com?part=3D5
