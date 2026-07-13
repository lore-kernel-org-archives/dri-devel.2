Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D63C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381A310E99D;
	Mon, 13 Jul 2026 13:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ol29E5aG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611D910E99D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EE1C403BD;
 Mon, 13 Jul 2026 13:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44A91F00A3D;
 Mon, 13 Jul 2026 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783948050;
 bh=UTOfQVyoSaNNp8kRqF4v3J1WE1kp20ix5FCDOhfJqwQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ol29E5aGJPfkNvdI3Pm9yb0e27XtygfR1YxGb7ek7ddLug+PJwWBuDBF8oemwoHsP
 +RVSIkF0Oq4OSTXxUK1HViYGFLXAQKwyy+dMflW5/ru9JKr1f/PkCq9uhUkGjZ0lbi
 dNuSQYHhdQZu96yvZFTpSAMZ4OFKnVhKtKHCeEPB6jAoe49ym0cACAjt6ObaLi1fgO
 5Eyy5IhLarCDM472BttHf+uwUiGenzVOuQR1a+/gT5EKrtZXyG9MbLvawUxFvZf2nm
 hg2YPXgW21EDfM7PYxmHIO1E7pUdJ37iLzKFTxi020YaK42DLyPKyutUP7sJyBd677
 Qudyp4+tSvueQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] drm/mediatek: mtk_dsi: Transfer register
 offsets to per-SoC const
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713130103.34654-6-angelogioacchino.delregno@collabora.com>
References: <20260713130103.34654-1-angelogioacchino.delregno@collabora.com>
 <20260713130103.34654-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:07:29 +0000
Message-Id: <20260713130729.B44A91F00A3D@smtp.kernel.org>
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
- [High] In `mtk_dsi_host_transfer()`, reading from DSI RX data registers i=
ncorrectly adds the byte offset `i` to the `reg_main` enum array index rath=
er than the resolved register address, causing out-of-bounds array reads an=
d invalid MMIO access.
--

--- Patch [5]: [PATCH v3 05/10] drm/mediatek: mtk_dsi: Transfer register of=
fsets to per-SoC const ---
commit a32b9a7c67e660488b31bdcea6dd9055c83b92eb
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dsi: Transfer register offsets to per-SoC const

This commit transfers DSI register offsets to two const arrays to support n=
ewer
generation DSI IPs with different register offsets. It separates DSI IP
version-specific registers from SoC-specific ones.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index bdb9ea2e7b6f6..4d5cb91c788f6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c

[ ... ]

> @@ -1297,7 +1432,8 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_ds=
i_host *host,
>  	}
> =20
>  	for (i =3D 0; i < 16; i++)
> -		*(read_data + i) =3D readb(dsi->regs + DSI_RX_DATA0 + i);
> +		*(read_data + i) =3D readb(dsi->regs +
> +					 dsi->driver_data->reg_main[DSI_RX_DATA0 + i]);

[Severity: High]
Does this code perform an out-of-bounds array read?=20

Since DSI_RX_DATA0 is 17 and DSI_MAIN_REG_MAX is 28, the loop will read pas=
t=20
the end of the reg_main array when i >=3D 11. Even for smaller values of i,=
 this=20
will fetch the base offsets of unrelated registers (like DSI_RX_DATA1,=20
DSI_RACK, and DSI_PHY_LCCON) instead of consecutive bytes of the RX payload.

Should the byte offset i be added outside the array subscript instead, like
dsi->driver_data->reg_main[DSI_RX_DATA0] + i?

> =20
>  	recv_cnt =3D mtk_dsi_recv_cnt(read_data[0], read_data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713130103.3465=
4-1-angelogioacchino.delregno@collabora.com?part=3D5
