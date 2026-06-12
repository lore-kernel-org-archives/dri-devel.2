Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4513DCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E7E10F581;
	Fri, 12 Jun 2026 16:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kY40Iw/j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A8F10F581
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:18:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05E39600AF;
 Fri, 12 Jun 2026 16:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F6D1F00A3A;
 Fri, 12 Jun 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781281093;
 bh=t59SHBM/VnxNzq8RXGo9/WOt6b2EmmZZqsobTFLaZsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kY40Iw/jyhoBShnqbs4tO+X4bPSLaSNBb69NP2nyAtkQfCRIlfETj5U3LYjbg+7vd
 VU237ntWsQSo9Yr3akENeHyUQqIe0/Ha3yMvGxa4Ce8xs1/0wFluWa9qeaB3apMACq
 EhFaTb5EJ9SX/UnDWB8DEqZB6XBpPCwV+OeXZ31afkcTk5cKdIbnIH1CGVJa7QqVvr
 VahhRTGopjjbqlvbKpb+/YQnt0T2uXMsCZ6JTWagTE6k/XtjrxtOr1nlBKaaXGotaB
 1ry8eZqr7JMbWcYvHMchXhUmToBacgrwJXkgOLT1NhvZDmnrq9D/TbWcVOj6qLkSm+
 eJjd8clEscl/g==
Date: Fri, 12 Jun 2026 11:18:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Johan Hovold <johan@kernel.org>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Pavel Machek <pavel@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 01/14] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <178128109241.1149158.14270432284406889754.robh@kernel.org>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-2-clamor95@gmail.com>
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


On Sat, 06 Jun 2026 07:57:25 +0300, Svyatoslav Ryhel wrote:
> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight
> ---
>  .../leds/backlight/ti,lm3533-backlight.yaml   |  69 +++++++
>  .../bindings/leds/ti,lm3533-leds.yaml         |  67 +++++++
>  .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

