Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAB606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXEQb5dc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B224D10F67E;
	Tue, 24 Nov 2026 14:48:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B3910F67E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:48:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A0EC40AFD;
 Tue, 24 Nov 2026 14:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0881F000CF;
 Tue, 24 Nov 2026 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795531694;
 bh=lyUEGhLGDykIVP/ED9acLT2Z8Hu6snwbttemda4QuYE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=YXEQb5dcxm1JxN5d6fK6F4oynjusGJRZv8vCmoMzvS89AoMaYdInrCBv05fE+jHUW
 fTL5hjlNbYu8MXPYgWqWC4eo9o2KkDFOle2aTYKqkJK4qy3nX8SBCSSwjqahRFLSyL
 vFuOzEKh6o1aUUCsfRe8eiUVb7F5DuD0xSpmiJwJPEqfu8qobdmLgHz1G6sOu3pUBf
 EKvY/YSA4Xj+O9LAOr4qg8BCOnQ2T3hT87mcHfZ6ODxe1m40otGD2ltuAVkkji8MkJ
 mrFY403fHKdzIXtXKhU01DwLQfwSTq1hFdb920DI5qMZvALxpZoiF4WWFstZjFZsHm
 MT6fjrxfaRT9Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 05/20] ASoC: codecs: pcm1754: Add PCM1773 support
From: Mark Brown <broonie@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, 
 kernel@pyra-handheld.com, Grond <grond66@riseup.net>
In-Reply-To: <7e12ac0772314b256a253314a24b9d0ad50ba5f3.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <7e12ac0772314b256a253314a24b9d0ad50ba5f3.1795505160.git.hns@goldelico.com>
Date: Tue, 24 Nov 2026 14:48:03 +0000
Message-Id: <179553168322.264265.14757755735561826656.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ShazBqroLpfTImF2hfJrbg+0pBRZfzBJNJtZVfX1368=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZFy/haI4yjItITLqY+Ty2yyZD584RZlGJmvZmw0XPf
 X+VhF3tKGVhEONikBVTZInL4n5ZX/J6Dd/BhW0wc1iZQIYwcHEKwET6bBn+KR+6tNuJ1zepu2mZ
 1uoD51dGqZ/7e+NXo8bE7DKP3tdtRowM1yabiC52qP0vZvkoWqj6eZrRTTEj7tkbn79Lujp14rF
 kPgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Extend the PCM1754 codec driver to support the related PCM1773 DAC.
> Select the DAI name, supported formats and sample rate limits per
> variant. Handle the different FMT pin polarity and an optional format
> GPIO, avoiding GPIO writes when the format pin is not controlled by the
> driver. Add an optional enable GPIO for the PCM1773 power-down input,
> controlled by a DAPM supply event to enable the DAC after power-up and
> disable it before power-down.

> +	case SND_SOC_DAIFMT_LEFT_J:
> +		if (priv->variant != &pcm1773_variant ||
> +		    (params_width(params) != 16 && params_width(params) != 24))
> +			return -EINVAL;
> +		format = 0;
>  		break;

If you've got a struct describing the variant it is obviously not
tasteful to open code a check based on the address of the variant struct
rather than looking at something inside the description of the variant.

-- 
Mark Brown <broonie@kernel.org>
