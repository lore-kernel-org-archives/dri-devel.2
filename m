Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC84C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E651D10E3E6;
	Wed, 16 Sep 2026 16:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KAhjYlUJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF61B10E3E6
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:52:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9227602CC
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696A31F008AB
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577566;
 bh=iIGcosXdsqHKF2ZHJfMci5sHM1xFoCT4RjNBihYG63k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=KAhjYlUJz4B3vlKbDDlDmaEOmLi6tMe6vOLCW5EZoCs26rLbd8glXJaTpSZ5ZncRt
 G1EQC5qwpstgB2j2XaL86slCFiWMTfVHspK6M+fbSkz9IsAkX78GqJs2dpYzkU2az5
 pLiawOJCLQ408ODC/MdUIRjzmGWlpTCTWUmaGZ7quTrO+c5iLtuE4rqYPtVgHEdkO0
 Kc8fUuOuvuraydHFdXnnYj5vBz5OVYt8cGxLANsZDmJmv0dsmNq5PvmvLSGGl3QqPP
 P7KD/vfJErAG9yROB1uqphrZwuUor23SdPagQu0WaDDl3rLRb2sksX4etGG4xRFK33
 rCWMVsGN5e/Og==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5b8b3c8c4bbso1299914e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:52:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxRUv0lo+I/MUHR/gYA+004Vgkru844xJ44RYoSoOznkNPdTy3foYeH691q00RJLZZWoeg9/7bkUKg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kX83qPoE1VL8CF/mBr1zwjIPW/NKCFDJGlgapCteCDVUy46HSR
 GfpTU6aL+ciktmVzWWHCbkH403d0fhncMNzOf0x8AmmFPxuersMa7CGg2KGRmXh8JVzaFD3grhl
 UiD9wPbEmI4awoxGl4QJjhFpmMmD7Iog=
X-Received: by 2002:ac2:5299:0:b0:5b8:9a95:e251 with SMTP id
 2adb3069b0e04-5b8ba710651mr51799e87.25.1789577565097; Wed, 16 Sep 2026
 09:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-14-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-14-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:52:32 +0200
X-Gmail-Original-Message-ID: <CAD++jLkz5WV2OBPRu+JJT3PeKhQruiF-Ydcgg7e4OGdM9qchQQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xmdqnt0f8Pu7UGQOVbB8vXW7jTvbrrYbhRnZP_VjfrieoeJn1KmD2hzRE
Message-ID: <CAD++jLkz5WV2OBPRu+JJT3PeKhQruiF-Ydcgg7e4OGdM9qchQQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] mfd: remove unused menelaus driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Pavel Machek <pavel@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, 
 Support Opensource <support.opensource@diasemi.com>,
 Sebastian Reichel <sre@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 9, 2026 at 3:24=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Menelaus was a companion chip for the omap24xx platform, which has
> been remvoed from the kernel, so now the menelaus driver is unused
> and can be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
