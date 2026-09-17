Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F42C982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBCF10E02B;
	Thu, 17 Sep 2026 15:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ngBXbn7/";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1635110E02B
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 15:06:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 634831A0934;
 Thu, 17 Sep 2026 15:05:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 26C255FAA3;
 Thu, 17 Sep 2026 15:05:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C35C211C7B08C; 
 Thu, 17 Sep 2026 17:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789657549; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=/OfWtIewPY5C/r0HMIf+o2IIttSmiKU4y8rC/hzPssc=;
 b=ngBXbn7/ts81Rynz7n5bSN7vmTTpu4edcR52tEjvtmzV0mtJnaTqQaaGTaP6UXbcZcuttd
 OmHSxedWnPBXZuzpLcrjJddURZ4iBxRQxqWuUXqCtPjgw44XdjtUZzeb4ixeueEh/Pjs3x
 /eWz9LcI5bxvgzjpghmVc+XOtR8IQ3BUPB6X/utwtHLYoy1NQVdzrmV/b3RW+jMtn6MkTh
 +P+X9EUacmGoXpVXdFe93bfZwrZ5ww11hjFw5RlJwwEHjnY4K+Lzz34RW8ywCr6zBFQl5u
 wZSqY+rp+UjM2V2g8x9tD4szg7BX2Co1MnCeqc+BhGY2Fm25gVBYVqzQV44emw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Lee Jones <lee@kernel.org>,  =?utf-8?Q?Andr=C3=A9?= Draszik
 <andre.draszik@linaro.org>,
 Ulf Hansson <ulfh@kernel.org>,  Liang Yang <liang.yang@amlogic.com>,
 Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo
 Pieralisi <lpieralisi@kernel.org>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Manivannan Sadhasivam <mani@kernel.org>,  Ray
 Jui <rjui@broadcom.com>,  Scott Branden <sbranden@broadcom.com>,  Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,  Will
 Deacon <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  Vinod
 Koul <vkoul@kernel.org>,  Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,  Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,  Jose Abreu
 <joabreu@synopsys.com>,  Ray Jui <ray.jui@broadcom.com>,  Scott Branden
 <scott.branden@broadcom.com>,  Atish Patra <atishp@rivosinc.com>,  Shawn
 Guo <shawn.guo@linaro.org>,  Dmitry Osipenko <digetx@gmail.com>,  Thierry
 Reding <thierry.reding@gmail.com>,  Ibrahim Tilki
 <Ibrahim.Tilki@analog.com>,  Okan Sahin <Okan.Sahin@analog.com>,
 devicetree@vger.kernel.org,  Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>,  Conor Dooley <conor@kernel.org>,
 linux-rtc@vger.kernel.org,  Ricard Wanderlof <ricardw@axis.com>,
 patches@opensource.cirrus.com,  Lukas Wunner <lukas@wunner.de>,  Chunfeng
 Yun <chunfeng.yun@mediatek.com>,  Eugen Hristev <ehristev@kernel.org>,
 dri-devel@lists.freedesktop.org,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux@analog.com,
 linux-input@vger.kernel.org,  chrome-platform@lists.linux.dev,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com> (Daniel
 Matyas's message of "Thu, 17 Sep 2026 17:40:28 +0300")
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 17 Sep 2026 17:05:33 +0200
Message-ID: <87tsnnj4ua.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3
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

On 17/09/2026 at 17:40:28 +03, Daniel Matyas <matyasdaniel006@gmail.com> wrote:

> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-strings)
>
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.
>
> Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com> # MTD
