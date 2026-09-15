Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE8FC982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F02310F8F1;
	Tue, 15 Sep 2026 15:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ir7RL1KK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB4D10F8F1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:45:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E710D4057E;
 Tue, 15 Sep 2026 15:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3491F000FF;
 Tue, 15 Sep 2026 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789487099;
 bh=mu9Q99hcvwNEtgql17+2eBH/L+oan3LO4fmdoLSsofM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ir7RL1KKkkz9wkehIGqJ6VO9Z55M/+7316QFQQvCa+Sse6kB+Xv8yE39I1gdgRFNW
 0FdZrOY95DernjMUh3lp7SklqrQfzAyuoKn3qacUjWOP8JG9ZJGGTcRxMEKMxGvRVk
 mp6ZoudHnBFy8w1JvJqVnDdZ2WxyghNjWEAp55hQh1VcynRQItx+4sG0kUBttRpf6l
 8ZEfu1/ipzI4JZJQaR6FQrxCbXvntfY1tndOJMlYm2gWhs6OGND2p70rPNEGElxly9
 qkUsHJ93jn+fU9jXGd2G+O6K14naiQKp9iq2Wc15GOoDn2gYWFKFTZTCoMfZ4t2zaQ
 2mWZeTXtcR6JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/20] phy: rockchip: inno-hdmi: Use the common
 Innosilicon PHY helpers
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: neil.armstrong@linaro.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 vkoul@kernel.org, robh@kernel.org, mfd@lists.linux.dev, lee@kernel.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260915-jh7110-clean-send-v4-17-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153244eucas1p180f69e8f957a5c615d3c6a59a1c205b2@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-17-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:44:58 +0000
Message-Id: <20260915154459.3A3491F000FF@smtp.kernel.org>
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

> The RK3328 pre-PLL programming, its table lookup and its recalc_rate and
> determine_rate implementations are the generic Innosilicon ones, so drop
> the local copies and use the shared helpers instead.
>=20
> The RK3228 pre-PLL sits at different register addresses, so it keeps its
> own register level code and only shares the table lookup.
>=20
> The now unused RK3328 pre-PLL register macros go with it, as does the
> local pre-PLL config lookup wrapper; both call sites already have the
> TMDS clock to hand and call inno_hdmi_phy_pre_pll_lookup() directly.
>=20
> The RK3328 recalc_rate used to log the pre-PLL output as "vco". The
> shared helper logs it too, and reports the actual VCO frequency
> alongside the rate, which is the value with the 1.4-3.2 GHz constraint.
>=20
> The register writes, their order and the values written are unchanged.
> No functional change intended.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D17

