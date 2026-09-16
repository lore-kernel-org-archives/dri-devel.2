Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7182BC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E1E10E34F;
	Wed, 16 Sep 2026 16:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KDzpsTWg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CD310E34F
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:51:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B19343D2C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77531F00921
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577459;
 bh=aPNoc/IlVGOzrz4AF5oUnZbB8ytSLfqRYFF3aP/E0sQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=KDzpsTWg/z/5krxTobDbUSigXfKLPKN3GY+kPVHqBR7Qs64CjzbIot5CkPAxP2KI+
 Upq0GS82M9H0w++Czaj9svBiDTIMQmYdYP/CnWtiPeFrOEHUujcdjRSLexmI83DV+8
 d3OQKB1DCYTLA88vtfqbmhxp+3cXxscBoXEspNQE0qlsMYOfCwjg24mnoTiNgsl1/S
 2qLgSSSaznjuc0hKlv6DMiusMtJMUHjJIhhSSySZ7vl9callQF4Q+5MgOlSemRyTDx
 yueZt3Uscllvxw64KPLdcYhjZOLgiIXI50AcSMUhvVtuef5e/bhhcPutASFv5vSY+5
 AtaQQrqZxPKdg==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b76462aae9so905444e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:50:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxBQONjdO46FqnSMc/0MMb/BhjJ1XFX8w7Pq71qqAQboH0Jp6yeXtjvj7txJbFJmgMfEWnKv0o99dU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+hE1sLvEvUdf1/J3ww9RUsSQSRCl2+KFsuVefxp5DMojuwUoW
 Jpp6NN/M1DPzsEN+T4UoKuPRS5JgW1lom/chiY25CpVLkI3hpno0j2zZtzvVdM8pc0jbJnhF0vK
 yyprB8DiJ9Np1OB2E4Ve+46M+R8/z52A=
X-Received: by 2002:a05:6512:4023:b0:5b8:b419:c8ad with SMTP id
 2adb3069b0e04-5b8b6617917mr969995e87.17.1789577458536; Wed, 16 Sep 2026
 09:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-9-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-9-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:50:45 +0200
X-Gmail-Original-Message-ID: <CAD++jL=dBJNiZMwRfYtVXC=qfWEU8WY1DRRzDA1o9Ngsd_VRqg@mail.gmail.com>
X-Gm-Features: AcwNN1VWCbypMBp0nAwSnIVxOHs3QNpjZkwVGv_5Swi1QUA8mHWSb92JoMn3LYg
Message-ID: <CAD++jL=dBJNiZMwRfYtVXC=qfWEU8WY1DRRzDA1o9Ngsd_VRqg@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
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
> This driver was apparently never used, as it has has no devicetree
> support and never had corresponding platform_data definitions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
