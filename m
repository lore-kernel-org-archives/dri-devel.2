Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FABC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DD110E3D5;
	Wed, 16 Sep 2026 16:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JcbHzxFv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F050C10E3D5
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:51:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5C5040280
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B865F1F000FF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577509;
 bh=jlDHHiMVqeXgdpn1Zj7e0N2hLgqwzeWFJxceKYb+YHU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=JcbHzxFvgLrpPJkR5R3XBY3y2SfCcwhDFnSiLhJ1B+/JTtnxdxndb4zLLznpRuxMr
 zDUB6DlQP+4KRhUFQ8qZIwmbtMSg4Sa213btbd920xJW3yvf/Rn4Qzedge0V2JpjlX
 DSseYM02zkMboFVManwZ9pkz7gBcwpL3z/fAJjcC2l/MJBjBv12ZukFan7Y5adtLR5
 PKISREbVUR980BR6UCPR2TSmSQ7nhb1eCTbfCo2hB8HPqtX95CCZxk0cjc1OeNxXHC
 wHby+UM/xrpkpvxH7mvJSJwmMZRLimAjK/eOXdvW4CtjMIwx6V8jFLqWrsv0qByTdb
 TzMjmwn1jm1BA==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b74e0c2e4dso1308865e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:51:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzHw/2lVHmPF0kwY803tz6TivJeMFcnvulUo9t9HeF0ZJV0vM56SnOKD2ADiHynm8lOAvl10r2jMTw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqEsG7gNYCiE+HR8yXhgikNgoUrzLX9ZIuzFeXJWBoKiOcOht2
 /nvQhh+nIsoUBOJgjRqQkH4HEYiWR3m3RCxl5ru1Sj09OdoUdpuPW7tWSAqlI8/1z3XEqzD4Cn4
 A6JxIRPrGzuZFWv5Qwu0izjRZVgoanRE=
X-Received: by 2002:a05:6512:3d10:b0:5b6:17b6:2224 with SMTP id
 2adb3069b0e04-5b8b665478emr1974764e87.23.1789577508492; Wed, 16 Sep 2026
 09:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-13-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-13-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:51:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLm253spmn1Tq2Jekiw2Q9xD_HDQ+AFRgWovLyE=veAfhA@mail.gmail.com>
X-Gm-Features: AcwNN1Xrn_ibUNrql-q0n8N3iTosx-ZSLrxjHuJr9HzfGfgIlGS2dfpxQ3q588w
Message-ID: <CAD++jLm253spmn1Tq2Jekiw2Q9xD_HDQ+AFRgWovLyE=veAfhA@mail.gmail.com>
Subject: Re: [PATCH 12/14] mfd: remove unused mcp-sa11x0/ucb1x00 driver
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
> The sa1100 platform has been removed, so these drivers are no longer
> used anywhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
