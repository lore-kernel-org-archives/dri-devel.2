Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB98C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB8B10E8C7;
	Mon, 13 Jul 2026 10:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ASx7LbFT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF08510E8C7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:07:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0443D6004E;
 Mon, 13 Jul 2026 10:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607151F000E9;
 Mon, 13 Jul 2026 10:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937249;
 bh=dDzfYof70ljUNHuLry4Fi5f1sDYBScDeZGbh7HflqXM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ASx7LbFTAYU/Tf/TIOiVh+8EccB7uWXEF8VryO9iMhmv9MYL78zXpfS11ZB7HSw7T
 3VP9exWopeHyjvvwfmTtV6dbKfm32NsykQk76g7l7+M9qC5FaFN0zobdKlu2tzd2XP
 aAkDETzzlCznUAmwpAIXGl7PWgvT4yrs+0UPySYHcAAc2v6y80Cu73f6PBZL5+VyDw
 CZj5+2vRsiRVDAp1tWHOzZyIHppMGD50JKa9QYCUyqgnX3N+Uq1FFU8NDG/hFbzI9G
 n2PK3MscrCDeZ2ROAoHtp+S7bQS8nXNVxvG4++uLRNAH5iIblQRn3nETYvTJe0TyY1
 tje1ovhXP9VUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] drm/mediatek: mtk_dsi: Transfer register
 offsets to per-SoC const
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260713095837.16590-6-angelogioacchino.delregno@collabora.com>
References: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
 <20260713095837.16590-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:07:28 +0000
Message-Id: <20260713100729.607151F000E9@smtp.kernel.org>
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
- [High] The loop reading DSI RX data in `mtk_dsi_host_transfer` incorrectl=
y uses the loop counter to offset the `reg_main` array index instead of the=
 MMIO base offset, causing out-of-bounds array reads and accessing incorrec=
t hardware registers.
--

--- Patch [5]: [PATCH v2 05/10] drm/mediatek: mtk_dsi: Transfer register of=
fsets to per-SoC const ---
commit 43b878ef0a8fe56d80e1c26ea5be280083d3ccaf
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Transfer register offsets to per-SoC const

This patch refactors the MediaTek DSI driver by moving register offsets
into per-SoC constant arrays. This separates the main DSI registers from the
advanced and SoC-specific ones, preparing the driver for newer hardware
generations with different register layouts.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 284dae372c7c2..6a77ce8eea91f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
[ ... ]
> @@ -1259,7 +1394,8 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_ds=
i_host *host,
>  	}
> =20
>  	for (i =3D 0; i < 16; i++)
> -		*(read_data + i) =3D readb(dsi->regs + DSI_RX_DATA0 + i);
> +		*(read_data + i) =3D readb(dsi->regs +
> +					 dsi->driver_data->reg_main[DSI_RX_DATA0 + i]);

[Severity: High]
Does this code read out of bounds on the reg_main array?

The original code added i to the DSI_RX_DATA0 offset to read consecutive by=
tes.
In the new code, DSI_RX_DATA0 is an enum value (17). When adding i (which g=
oes
up to 15) to DSI_RX_DATA0 inside the index, this accesses reg_main up to in=
dex
32, but DSI_MAIN_REG_MAX is only 28.

This means for i >=3D 4, the code will fetch unrelated register offsets (su=
ch as
DSI_RACK or DSI_PHY_LCCON) instead of the expected RX data bytes. For i >=
=3D 11,
it reads past the end of the reg_main array, which could cause MMIO reads at
unexpected addresses.

Should the loop counter i be added after the array lookup instead, such as
dsi->driver_data->reg_main[DSI_RX_DATA0] + i?

> =20
>  	recv_cnt =3D mtk_dsi_recv_cnt(read_data[0], read_data);
> =20
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095837.1659=
0-1-angelogioacchino.delregno@collabora.com?part=3D5
