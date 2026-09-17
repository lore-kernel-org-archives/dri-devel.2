Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13763C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260B510E76E;
	Thu, 17 Sep 2026 18:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LVkG09Hq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3302510E76E
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:00:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61C626022F;
 Thu, 17 Sep 2026 18:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF31F00893;
 Thu, 17 Sep 2026 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789668042;
 bh=bDkA9Is1Jx1AOE6Tvx2VWAovPxbpbhANimFsfanmC0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LVkG09HqfsKZmJFS9qmt6OvQIdIMnn38+xzlPNcI19TxAJDAVqDvcv13mx5RhiTJF
 BLFpnR+BysQpygTq/jJME04w/nYC6JbWWyngMv/UqyKfFg/XRgx7vghrbUABrl1xVa
 gzPWxiGrTTasJL7YDq+byQVo+FUUD/WjlOUBbOLR/Xd71lWSaRrldlsJicJcKWYeHS
 hiIJQAirnKUCBG3M/4JbVZfqSp+8BFzJVS57Tp/RKVgvNfoJF+cer2fMfEtKfCDQB9
 69UFkPdaOAPFuQu79OdO6zaHZJVHecxL8QaqbdLDMo5FenvMFzH+F34vu3f36Eukda
 OZliUmPKbP87Q==
Date: Thu, 17 Sep 2026 23:30:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
 =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
 Ulf Hansson <ulfh@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>,
 Atish Patra <atishp@rivosinc.com>, Shawn Guo <shawn.guo@linaro.org>,
 Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Okan Sahin <Okan.Sahin@analog.com>, devicetree@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
 linux-rtc@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>,
 patches@opensource.cirrus.com, Lukas Wunner <lukas@wunner.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eugen Hristev <ehristev@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux@analog.com, linux-input@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
Message-ID: <aqwqxSxqg7aRjchE@parshuram>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 17-09-26, 17:40, Daniel Matyas wrote:
> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-strings)
> 
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
