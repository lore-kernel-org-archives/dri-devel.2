Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CF8C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E223710EE03;
	Mon, 14 Sep 2026 12:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hjOk9pzn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDBB10EE03
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:11:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37C2F60120;
 Mon, 14 Sep 2026 12:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BF21F00893;
 Mon, 14 Sep 2026 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789387865;
 bh=g9boCQT3MsnPj/NEGZBxC5NyaRFO13IZCgLb6bhn340=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hjOk9pznvQyoU6RisAITbSUay7Ypjxvp/gtuodZELKksA4XOvznKTVHKl1de34EKZ
 /fx3H487xUy3REuLSpZ3kDLqEIg75fLv5AM3uodkjb8XbvH2LUBK6XGr0Ukjt+Q2Xi
 4ihxa9J+4N6ouTMMtXNuRJ8y+r8dZZAD/cPpkOr9VvTAn/CPgbxpECYuaoN/BoZAQc
 VWl9+pcBtQN5GY3HHNaEAIqCNkk0wd54O/lMFe1B+ORKYtnJYkqUmu+tsgAB8RFmQP
 KpvYK/LVFdAr2nsvhZ+nIqf9Emif/zEUJM007liza0WwJLLMVk529NyJKpCwWoD/TW
 HiWnrrR+KUXIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/13] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260914115812.22751-6-angelogioacchino.delregno@collabora.com>
References: <20260914115812.22751-1-angelogioacchino.delregno@collabora.com>
 <20260914115812.22751-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:11:05 +0000
Message-Id: <20260914121105.96BF21F00893@smtp.kernel.org>
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
- [High] The DSI interrupt is enabled before hardware clocks are turned on,=
 leaving the system vulnerable to a kernel panic or interrupt storm from un=
clocked register access.
--

commit c2f480f41de24a194e9b0ecae5811e54e2bf871e
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Enable interrupt at component bind time

This commit requests the DSI interrupt with IRQF_NO_AUTOEN to prevent it
from firing prematurely during probe. It explicitly enables the interrupt
during component bind and disables it during unbind instead.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 0b167b4411e59..ef1638e77f00e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -1101,6 +1102,8 @@ static int mtk_dsi_bind(struct device *dev, struct =
device *master, void *data)
>  		return ret;
>  	}
> =20
> +	enable_irq(dsi->irq);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this leave the system
vulnerable to a kernel panic or interrupt storm from unclocked register
accesses?

By enabling the interrupt here at the GIC level before the hardware clocks
are actually enabled in mtk_dsi_poweron(), the mtk_dsi_irq() handler can be
invoked while clocks are off. The handler in
drivers/gpu/drm/mediatek/mtk_dsi.c unconditionally accesses DSI_INTSTA:

mtk_dsi_irq() {
    ...
    status =3D readl(dsi->regs + DSI_INTSTA) & flag;
    ...
}

If a spurious interrupt or a delayed bootloader interrupt fires between
mtk_dsi_bind() and mtk_dsi_poweron(), or indefinitely after the display is
disabled via mtk_dsi_poweroff() (which disables clocks but does not disable
the IRQ), the handler will execute while clocks are off. Accessing hardware
registers while clocks are disabled can cause a synchronous external abort.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914115812.2275=
1-1-angelogioacchino.delregno@collabora.com?part=3D5
