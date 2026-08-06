Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE76EC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01B310EF23;
	Thu,  6 Aug 2026 13:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OoxNPG1z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF51110EF23
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 13:38:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F81D40DD5;
 Thu,  6 Aug 2026 13:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55AA1F00A3A;
 Thu,  6 Aug 2026 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786023493;
 bh=QWCIJYBdf1Vr1nl4/C7Q2LQVneCNu7uCDjSKsXTeDqk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=OoxNPG1zHsQLhYfcK7XcrbsJnbPsZXOO94mQNF7q6WEIWlr4y2Tv6PmsnrsXmTrOI
 hMpfwVT6HcaWifoXf9e8u16CbC2KtX5O1WG4TN1ZCvWiYTCUiABaxSRMllrwKJ6hK+
 F+kdcByZSBcVf07aABS6IjmAgIxWdsVNqsA9pEG3vpABfBxGe45AWYpEM/5msgFC4/
 smzMda896V/02Yhpr1wt/Hn8Yf1dS28wzZxTCjVFry9oK9tJBAEJ2iYwc7Nh569MNc
 1WDyVs/v6wF4m+XU5+XHW/O1mNQcvtx6VUQpiPLlOQDU201gu7vNWwPq0G0HsvHUPN
 VDAMT9jDyCkig==
From: Lee Jones <lee@kernel.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com, 
 m-chawdhry@ti.com
In-Reply-To: <20260723100605.628882-5-egbostina@gmail.com>
References: <20260723100605.628882-5-egbostina@gmail.com>
Subject: Re: (subset) [PATCH v4 4/4] dt-bindings: leds: backlight: Convert
 TPS65217 to DT schema
Message-Id: <178602348845.2925958.12911324342700206975.b4-ty@b4>
Date: Thu, 06 Aug 2026 14:38:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Thu, 23 Jul 2026 10:06:02 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 bindings to DT schema.
> 
> During the conversion, the following updates were made:
> - Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
>   which are used by the boards but were missing from the old txt
>   binding.
> - Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
>   and 'ti,pmic-shutdown-controller' properties, which are used by the
>   am335x boards and read by the driver.
> 
> [...]

Applied, thanks!

[4/4] dt-bindings: leds: backlight: Convert TPS65217 to DT schema
      commit: 95231a92250ec6d04b295b912ea42135875f6c53

--
Lee Jones [李琼斯]

