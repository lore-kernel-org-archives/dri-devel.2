Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2226606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPf2do13
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB0310F6A0;
	Tue, 24 Nov 2026 14:48:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054AD10F6A0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:48:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0BD941780;
 Tue, 24 Nov 2026 14:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C2A1F000CF;
 Tue, 24 Nov 2026 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795531704;
 bh=NmzeHjQpwb8xr6UOoWnMTNzzDHjAarvzlglxmIf5kC8=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=YPf2do13UJY/NFUdq6FHPxFG8KZoWIt2yCsrXBO2YGch4P96BCx+vrisjtTER57tA
 J4z4KxtgbX0OKi/41M5AqCZF7w99rrwZVkDQB1mHeXCv5a+SrnexPld9IOSVBXImU/
 fCC6I2KpmISBjjyMgs3pdTMEMPZqWNueh3SpSfFgMCBfsmOJLHLW+ERUIjCLzj5rhs
 /exN9lHQkb2ARVCNNWvJLebtQ3b7rlLXt/RnIJ39/8IF7I+EX9WKq21IcT91/vOEkD
 i07N6sSUja/WQO9HwFz+oIWETeIyOePxlUIjeRY7csqWeug+aJeZD9yCE+AkSTUZ3o
 xExZtPvui9egQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 07/20] ASoC: ti: omap3pandora: Convert sound card to DT
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
 kernel@pyra-handheld.com, Stefan Leichter <sle85276@gmx.de>, 
 Grond <grond66@riseup.net>
In-Reply-To: <57d9a8b26bd2282deb9188d6913976cfee41aee9.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <57d9a8b26bd2282deb9188d6913976cfee41aee9.1795505160.git.hns@goldelico.com>
Date: Tue, 24 Nov 2026 14:48:03 +0000
Message-Id: <179553168323.264265.7045861860225672057.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=473; i=broonie@kernel.org;
 h=from:subject:message-id; bh=O+rxne3vfbE84eTyYkF7T4fTftOwK7+9DZzNOJ+HZzk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZFy8x+dXb7LL+HKf1wXKuIz81p8++sCJJKZWD9TSn0
 rfClbtrOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRdY4M/8ytHs5iDcsvmLh0
 YcYOxydMZY4LfGfsfGA/c+r3NWGXPDcxMpy59iWt6P6TdwapdvPZb+UIJU1sidvM9fdryqElzQm
 KN/gB
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

> Convert the OpenPandora ASoC machine driver to bind through a Device
> Tree sound-card node instead of creating a platform device from board-
> specific setup code. Describe the CPU and codec DAIs and audio routes
> through DT, including the external PCM1773 playback DAC.

> +	DAILINK_COMP_ARRAY(COMP_CODEC("pcm1773-codec", "pcm1773")),

You've added the external CODEC but not updated the Kconfig dependencies
for that.

-- 
Mark Brown <broonie@kernel.org>
