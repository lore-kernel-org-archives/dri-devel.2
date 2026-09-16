Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA44DC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FDB10E3DF;
	Wed, 16 Sep 2026 16:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JRfWJMYb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8163010E2B5
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:50:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B8B843D4A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A841F0089C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577409;
 bh=L7Nv3D+LAVl5eGsM7/8TZo2OXjqL6TT+3lXEOOWeVno=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=JRfWJMYb32Rm+IxTGvWpJpVsMLrjJ68BqhbJ1lGRrYsTjhE1OZfZj1qbzkB0veld6
 aydd8hcy346Zxb6783g1qefug17abCGHwEEP5EzN/vTF6tUlqT5ZPT9NonaNcBN6Mm
 iFHRI8HRf+oFvcyk19LmsMR/ieQvjycJb8CfLWsfTiXI1BT7/RcsPiDeyUeP4sl6Te
 lG7eTE1DFCyEJnR2F3YWWd+EREGj4zAlFNo6xxzQLZbMu98CG5M/4U6F5hTA659o1r
 atcvb2ngG2XHrNfqUI5igAlUejpBaeyRareRjXW7WalzRDlX5tkNV+y19q3/HKoiYf
 MIIkl+PwLwMGg==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b5e4f13d77so1507725e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:50:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByrDQWg9iNhLifb3XZB2V9GCNRtx62wZQiwCYDu5bONBGngfupbU2auka3qyfiuLk0n3+IfgTzbph8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8cCimcHXtKNBdlI96j2HP8R5Yfx3l0pRN7st08/m9lbIOGlSV
 VLd/qR3VqenQHO48Gu60kKvpDnK542k9hjqibVhos8VX3VshlGEXckT06aeMrxHJiRQ4VMX18Iv
 M3ORbMRDs43CL5NU4wRwO4hqrspHD+gI=
X-Received: by 2002:a05:6512:a91:b0:5b5:edd1:471f with SMTP id
 2adb3069b0e04-5b8b660ce5dmr1007964e87.11.1789577407936; Wed, 16 Sep 2026
 09:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-4-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-4-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:49:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLm-AwYYyJ9s2MTa7r_raesRar36Hugyf1R1Ny0zCqL5_A@mail.gmail.com>
X-Gm-Features: AcwNN1UmqUhvwRMmw62XliPfw_HgO3-Fmrm9oMts4wPzbRxPuRqcz84S4okTZmg
Message-ID: <CAD++jLm-AwYYyJ9s2MTa7r_raesRar36Hugyf1R1Ny0zCqL5_A@mail.gmail.com>
Subject: Re: [PATCH 03/14] mfd: remove unused si476x driver
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

On Wed, Sep 9, 2026 at 3:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The si476x driver was added in linux-3.9 without devicetree
> support, and has always failed the probe function in the
> absence of a si476x_platform_data definition.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
