Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B71CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 12:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D90D10E264;
	Sat, 10 Oct 2026 12:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YGfwA1/j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B88810E264
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 12:12:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A51460202;
 Sat, 10 Oct 2026 12:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C21F000FF;
 Sat, 10 Oct 2026 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634372;
 bh=rq078x30mntqmt9YXxlBXp+2iWrDU8Zm1mGtRU3YIQc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YGfwA1/jFy9kkW5cB4jMpXUahbh1G9cvi8QtJS1V7vAUGFAC/AwpNsFeUZwqZHp3C
 EoYKNH5dXy3SGWW8rdmlICWz9IHSTcKeuAzfmpdMsmGjW0K4mn18Q5U1dhVM+nyDYU
 mdyjDclNIYwR7wUCmrMon7pPUsJBlO0ZhKtlcnGzd5+MM7aqtNmVePLeX2in6a3MEy
 EHu8oM+9P5OwSeF9l54m/OLJlaNSVt7xN0+CS01DJQ3OaKVlICB9R3ZLGAyhaUenBk
 4zYg9M6HPDUUEnRKKHXVW1JwHkesDT6iKlEYW3EXwYnZ0RpS+rnqxq7395gtn99tvJ
 jiYorbPZwelAg==
Message-ID: <sashiko-outbox-166489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] phy: mediatek: hdmi: Add support for mt8167
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261010115539.9237-3-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
 <20261010115539.9237-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:12:50 +0000
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
- [High] clk: determine_rate callback fails to propagate best_parent_rate a=
nd mutates persistent state
- [Medium] clk: phy-mtk-hdmi: recalc_rate returns internal rate instead of =
logical TMDS clock
--

commit c9a6701a365f2268fb32f51141821ccc937de091
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

phy: mediatek: hdmi: Add support for mt8167
   =20
Add support for the HDMI PHY found in MediaTek mt8167.

> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c b/drivers/phy/med=
iatek/phy-mtk-hdmi-mt8167.c
> new file mode 100644
> index 0000000000000..2435054d4e176
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c

[ ... ]

> +static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
> +				       struct clk_rate_request *req)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
> +
> +	hdmi_phy->pll_rate =3D req->rate;
> +
> +	return 0;
> +}

[Severity: High]
Does this callback fail to calculate and set req->best_parent_rate?

This clock is registered with the CLK_SET_RATE_PARENT flag set. Failing to
update req->best_parent_rate means the parent clock's rate might never be
adjusted to support required pixel clock frequencies, such as 148.5MHz or
108MHz. The hardware dividers configured in set_rate would be applied to an
unscaled parent frequency, yielding an incorrect HDMI pixel clock.

Also, since determine_rate is a dry-run CCF query callback (e.g., invoked by
clk_round_rate), is it safe to mutate persistent driver state
(hdmi_phy->pll_rate) here?

[ ... ]

> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy =3D to_mtk_hdmi_phy(hw);
> +
> +	unsigned long out_rate, val;
> +	u32 tmp;

[ ... ]

> +	tmp =3D readl(hdmi_phy->regs + HDMI_CON2);
> +	val =3D FIELD_GET(RG_HDMITX_TX_POSDIV, tmp);
> +	out_rate >>=3D val;
> +
> +	if (tmp & RG_HDMITX_EN_TX_POSDIV)
> +		out_rate /=3D 5;
> +
> +	return out_rate;
> +}

[Severity: Medium]
Does this mathematically compute the internal PHY output rate instead of the
logical TMDS pixel clock requested by the HDMI controller?

It appears this calculates a fraction of the TMDS clock (e.g., 37.125MHz fo=
r a
74.25MHz clock). Since the HDMI controller driver requests the TMDS pixel c=
lock
rate, returning the internal rate could lead to CCF rate mismatches and
warnings like "Want PLL 74250000 Hz, got 37125000 Hz".

Combined with mtk_hdmi_pll_determine_rate() failing to configure the
appropriate scaled rate for the parent clock, could this cement the framewo=
rk
mismatch and violate the clock framework API contract?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010115539.9237=
-1-l.scorcia@gmail.com?part=3D2
