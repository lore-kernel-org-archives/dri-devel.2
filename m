Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB8FC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2616F10F2C4;
	Fri, 24 Jul 2026 06:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fUdDw2Vj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B6210F2C4
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:06:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8570C600AA;
 Fri, 24 Jul 2026 06:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721BF1F000E9;
 Fri, 24 Jul 2026 06:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784873184;
 bh=sR2SdUSKgTFGbEVS0wvxdwiXMBvONMXt7n2+RC5+RK0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fUdDw2VjHIGIpf5xZK2NH4yo+1pJFxeBM9CgSPqyS6NiRHacehwh09nsBV6fNg1eK
 MMkWLPbRC2B4g+e/aTFz/G5tXpi2D6rAzlUXc7keNTiku/42ixQmhkqNrj+Wx/93Hl
 u/iYAa2fslepTR0QxkJQnhPlWR0fk6ykIegJzvuX5lrjxNak42E0JDaEJb8ZpuZXtG
 Jke/u3BfXWPnp9mQ7jIPE6eqJOO+3uqgHhXvETEkoKh5168x8GpZ3DUAmmtc4/oXBK
 iTtAOhgrb5TKP6xiADv9ObVv0/VfEHeC+VTcKDR0W5XlpngyWA0kZ1lCsqpcv4wBT/
 FYKWsMIZBeYsg==
Date: Fri, 24 Jul 2026 08:06:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 
 linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 daniel.baluta@nxp.com, 
 simona.toaca@nxp.com, goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v4 4/4] dt-bindings: leds: backlight: Convert TPS65217 to
 DT schema
Message-ID: <20260724-gentle-starfish-of-fantasy-cbb2a3@quoll>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-5-egbostina@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723100605.628882-5-egbostina@gmail.com>
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

On Thu, Jul 23, 2026 at 10:06:02AM +0000, Eduard Bostina wrote:
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
> The regulator/tps65217.txt binding documented the same 'ti,tps65217'
> compatible and is superseded by this schema, so remove it as well.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

