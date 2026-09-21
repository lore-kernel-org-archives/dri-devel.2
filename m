Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F8FC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BCA10E043;
	Mon, 21 Sep 2026 11:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fw8aYA0n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A35510E043
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:50:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C45A3600D1;
 Mon, 21 Sep 2026 11:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFDF1F000FF;
 Mon, 21 Sep 2026 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789991430;
 bh=uMNo+W7eeEQLJwnzZvEaZJQy4yg6U6SXNwHqFT59FwY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fw8aYA0n1E5v3ptknTslf1AyKASp5wZ8YYfPLWx5d882fOQ+AxzOtHzkHmxpJv2np
 uHvvPz6jWle47KWaIWzd60ftnVZgXUP8JU+l5B14M0AyAdrtE2by1Qjkk9tiloiKzH
 EQBMY8mD+qMid0k1khc/H1Yty+djap4ziGip617OEtTlDP8MayXshq7zCQLbt0v34i
 CoajZQnqNp7gplOzqOM5EtmA8PX9dywKIE8T3KTYKc2qSydIG6/W8YilCVeFFFYpB4
 nT7XpH5mNxFklfybtX9lTHk5NaI20QTaAvs4NjuauDnVtHeBhXFePQPQ3ujVysU0jZ
 gJIGfZpIQFsmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] soc: mediatek: mt8167-mmsys: add routes for all
 display paths
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260921113914.779393-4-l.scorcia@gmail.com>
References: <20260921113914.779393-1-l.scorcia@gmail.com>
 <20260921113914.779393-4-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:50:29 +0000
Message-Id: <20260921115030.2DFDF1F000FF@smtp.kernel.org>
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
- [High] mmsys: concurrent MOUT outputs broken by full bitmasks
--

commit 8ae801c4ff167fb410aace262b9f0eef4667f2c9
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

soc: mediatek: mt8167-mmsys: add routes for all display paths

This commit adds support for additional routes according to the SoC data
sheet and Android sources. It redefines existing routing table entries to
use full masks and adds new concurrent display output configurations.

> diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/m=
t8167-mmsys.h
> index 001379373507a..7da81b6688715 100644
> --- a/drivers/soc/mediatek/mt8167-mmsys.h
> +++ b/drivers/soc/mediatek/mt8167-mmsys.h

[ ... ]

> @@ -34,16 +78,162 @@
> =20
>  static const struct mtk_mmsys_routes mt8167_mmsys_routing_table[] =3D {
> +	/* OVL0<->COLOR0 */
>  	MMSYS_ROUTE(OVL, 0, COLOR, 0,
> -		    MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, OVL0_MOUT_EN_COLOR0,
> -		    OVL0_MOUT_EN_COLOR0),
> +		    MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, MT8167_OVL0_MOUT_EN_MASK,
> +		    MT8167_OVL0_MOUT_EN_COLOR0),

[Severity: High]
Does changing this mask to the full MT8167_OVL0_MOUT_EN_MASK inadvertently
introduce a regression for concurrent multi-output pipelines?

Looking at mtk_mmsys_ddp_disconnect(), it performs a read-modify-write
operation on the register using (tmp & ~mask) | (val & mask). When
disconnecting a route, val is 0, so the register is masked with ~mask.

By using the full bitfield mask instead of the individual bit mask, does
disconnecting one route clear the enable bits for all other active
concurrent paths originating from the same block?

> +	MMSYS_ROUTE(OVL, 0, COLOR, 0,
> +		    MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, MT8167_COLOR0_SEL_IN_MA=
SK,
> +		    MT8167_COLOR0_SEL_IN_OVL0),
> +
> +	/* OVL0<->WDMA0 */
> +	MMSYS_ROUTE(OVL, 0, WDMA, 0,
> +		    MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, MT8167_OVL0_MOUT_EN_MASK,
> +		    MT8167_OVL0_MOUT_EN_WDMA0),

[Severity: High]
For example, if the OVL0-to-WDMA0 route is active alongside OVL0-to-COLOR0,
does disconnecting WDMA0 here clear the active OVL0-to-COLOR0 routing
bits as well because of the shared MT8167_OVL0_MOUT_EN_MASK mask?

[ ... ]

> +	/* DITHER<->UFOE */
> +	MMSYS_ROUTE(DITHER, 0, UFOE, 0,
> +		    MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN, MT8167_DITHER_MOUT_EN_=
MASK,
> +		    MT8167_DITHER_MOUT_EN_UFOE),

[Severity: High]
Similarly, does using the full MT8167_DITHER_MOUT_EN_MASK here cause the
disconnect of the DITHER-to-UFOE route to accidentally break concurrent
routing to RDMA0 and WDMA0?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921113914.7793=
93-1-l.scorcia@gmail.com?part=3D3
