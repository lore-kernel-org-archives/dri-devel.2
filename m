Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B3AC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314C810E465;
	Wed, 16 Sep 2026 16:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LwL5uJTv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82EFD10E465
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:56:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AA3143D6A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE591F00906
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577763;
 bh=FsAF5t94/E+0eDbBJV3FrxLYtGfzl97iFt4l9Z2gsvc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=LwL5uJTvk+caRQNwbSB5ATPRXw7brmRpqJk2QtEll9wNrHzM4LXKPhOBdmC+qqHOI
 NaAfUFq4rzoGACFTTyQdLoVYuJm1jdHaHb3qn8txxe+xc8JINpsTykSozSnWxabH7h
 op/idZS1YNtNoCVSPRb1QEGHzn2m7zw2LDIyCIF4UfpM40ioUVIK3/wHAx+xiSWMvN
 /xVulE7ndQVQaOLAUcAleHr+kdN6ev6pJOs9oO4QLDkU1T8hSvaeyWKeIa8Kzkm0DD
 ggUQq/Z5XbsvLX0fdmmQODqsVDJJlwrxRbedL+4Z4hrIX17PbxybKgpia9/d18jI5C
 V90mrPeJbBvPw==
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b88dc3bc02so1254691e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:56:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzcD6AsrFwulUaBx3TBbJUhUWzhVXTNaceOCdiF40xMVf9RC/YxEVXi1ehKqKAx/rrr7rOqL1iLIZM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mdIqsilo6t24x/lvmBXbCjeL/pn9vCYVpo2qKX5nW+4+MYwvoQ
 CS+pFENzZ+q209YppMQ1kmYB2h6CnIa1rya0zHoz/0mJkhIqo//D0nLL9OuWLBPzv3ZQkP3nh/O
 H/q2EV2Lh756QPysP3iIEzilJMui8AKQ=
X-Received: by 2002:a05:6512:3e1b:b0:5b6:1a7c:fd7f with SMTP id
 2adb3069b0e04-5b8b6652b42mr975442e87.37.1789577761635; Wed, 16 Sep 2026
 09:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-8-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-8-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:55:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLmJ4tbJuwuQtAx6UCxWU4XghXwp=saMqy5SRsASqe-=Hg@mail.gmail.com>
X-Gm-Features: AcwNN1X4XEEO3B_3JMl6a8g-CgUfyegbwNLsrb9Ef6iUWMuuaWJ5SqyyXzqaDA0
Message-ID: <CAD++jLmJ4tbJuwuQtAx6UCxWU4XghXwp=saMqy5SRsASqe-=Hg@mail.gmail.com>
Subject: Re: [PATCH 07/14] mfd: remove unused lp8788 driver
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
> This driver was apparently never used upstream, and without devicetree
> support cannot be used by external board support.
>
> The MAINTAINER entry was already removed in 2021 as the email address
> bounced.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
