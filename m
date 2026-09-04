Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E905C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E25710F9A0;
	Fri,  4 Sep 2026 13:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n2sohWUV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BA410F990
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:45:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A69CC42EA5;
 Fri,  4 Sep 2026 13:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09531F00A3D;
 Fri,  4 Sep 2026 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529500;
 bh=xbUpGSCx0twqvK2uYMhh0Z5HEmXOnKyfgNEX/KAG5Rg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n2sohWUVbJtultNnzRI8n3i7cqBG7Ys9UHIezllEqyWvBgu8tyIJzrNChxgmGznaZ
 pJMFmO05zDTxWy9L+MOqlZtfqyPllls3HQigZAzzZN740D+BcmMTjmNMvZd9toQjvf
 /z86e+M91jObN7SLeNIZ8OjarFc59XAIhHn5AOqzF2XO8FDHwuiqSg57u7RXq2hhO+
 bStO+h6dZxKNVodvxtxUwQiyOQgbF5A2y5DljJxGDSyDEgdcI/6MZH5pcFs/kHZXOh
 dNkZWH0U+lqWea0DEUlsuHAu4ed7ftzGk5fZwcxQwfHXG8P2iuHAotdDjpO+cmeuIp
 hB1Sd+j3G79bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/19] clk: starfive: jh7110-vout: Allow pixel clock
 rate propagation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: conor+dt@kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org,
 olteanv@gmail.com, devicetree@vger.kernel.org, lee@kernel.org,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, robh@kernel.org,
 linux-phy@lists.infradead.org, mfd@lists.linux.dev
In-Reply-To: <20260904-jh7110-clean-send-v3-13-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132733eucas1p1a6529cb2ea97bc75c9cd190d1ba901c0@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-13-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:44:59 +0000
Message-Id: <20260904134459.C09531F00A3D@smtp.kernel.org>
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

> The dc8200_pix0 and dc8200_pix1 MUXes feed the display controller, and
> the rate they carry is ultimately produced by the HDMI PHY, which
> registers hdmitx0_pixelclk as a clock provider.
>=20
> Add CLK_SET_RATE_PARENT to both MUXes so a rate requested on them
> reaches that parent, instead of being clamped to whatever rate the
> parent already happens to run at.
>=20
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D13

