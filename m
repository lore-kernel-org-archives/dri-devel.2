Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2E9C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C5210E45A;
	Wed, 16 Sep 2026 16:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jgG2fcgm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1153010E45A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:55:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5472560A54
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EB81F00A08
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577738;
 bh=3Rl9kH69FoIDw7gGLNXjdv5fuBqhGXd9XmucXEFUoPA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=jgG2fcgm04XQ1sjv96yZWoL9W/lNflacZnI7oSFM1D9ZHGfNQQoEWWSMuQG/IC2/T
 2VuhpPXP8oBGkHZtPfmlzEoCglvXu8AYWKJ6X2RLLUZ5sChU4Uhy7YW6OUHmroACcr
 AjGBRjESalVhyQaIXKoxQj/+xiefBFKY77Vyt8vXOTqRH2tTrsPkfVkbJWnysisBe4
 ZLlwQY3EjrTvAb8MZuXdCJf47zm/QDAlH8wgNCWJRVgHxqLSx/j1A0MBJDPgaNwxBz
 ZxK2KUNJH//fwQQp9knX4O8sha16fCgt/rNFFXZAkNG2+va1/xHBuVoEU+PGVQYV26
 M6VHoCiEiQlEQ==
Received: by mail-lr2-f27.google.com with SMTP id
 38308e7fff4ca-3a5b6840edcso10431091fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:55:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw9grS7buVeGKetAGSEgohULpFf47PYgXWPxygOgSBovHZNAEWYSwNIfka2CM0W71Bod9bwejSTh2k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n4wtK7OIKrQ9EmOZ+4+FeTRKAHwu0bySSzgasidBV6Lwm2tw/Q
 yGTmL9z+OEi8w2aL/dSf/smUeQZW9oobk2716YmUn5hCQyc3pEcA2/xorjH8wNBLwM4jnrDYp71
 2qm1UCdMj2Eunm0sWsD7GB9IZvMPMx4o=
X-Received: by 2002:a05:6512:2c97:b0:5b4:ac27:6bb0 with SMTP id
 2adb3069b0e04-5b8b666abe2mr2187526e87.25.1789577736627; Wed, 16 Sep 2026
 09:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-7-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-7-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:55:24 +0200
X-Gmail-Original-Message-ID: <CAD++jL=7tuZWkXqn0gj14JDbsxkT=cU_1aFOXMRc=PmE-3X-eg@mail.gmail.com>
X-Gm-Features: AcwNN1XvcQ2YIjfo5CFBtXX11PIudi6lRGCv7LMnZ1tHaTMlEuKLFH_DVwfW2u8
Message-ID: <CAD++jL=7tuZWkXqn0gj14JDbsxkT=cU_1aFOXMRc=PmE-3X-eg@mail.gmail.com>
Subject: Re: [PATCH 06/14] mfd: remove unused da903x driver
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

On Wed, Sep 9, 2026 at 3:23=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver was used on a handful of ARM/PXA boards until those
> got removed a few years ago. Without devicetree support, there is
> no way to use them upstream.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
