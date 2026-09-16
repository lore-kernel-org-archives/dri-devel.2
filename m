Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C7AC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BB910E3E9;
	Wed, 16 Sep 2026 16:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GjbO+wUK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A385210E3E9
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:54:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 826B241E7C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2749D1F008A7
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789577648;
 bh=+Cs3VDVugIjX3MNVr9btCbWNjreSEbxnWC6UpAzcikY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=GjbO+wUK8PFGJDHTykoLXmuHDqj5Q7HLnMpLEGqYG36NblxMPUNwQLqNuP7FzEtT4
 JtNiFzZ/1GJdhAx3cf2d/F6lgfSLCGCB6qOb6ixqEY8owR8DlGvYXsSTeAdY2dHNf4
 um0RvShJEozxLwpw/Um8fJ9MSJePrMWS+n9P+W2MJEQKKTtNV/ybCuERrp5NU/6B95
 lZj0/o+SBlzX8Ebb7rn+q5ig4whFnumLJBwY77N7myjOW9XvPxgXpgFzYNCbq1Hw4n
 xV3s0FQA2HKc/MFPuqF6apfb/pYnlhD4tXsFKK4J8z0/eokzzdgWXGC3jEzMW515N9
 BQQxBTOl+bhjQ==
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b5e4f1744eso1095700e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:54:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwf1W0MvQe3rQmnSLVO9Dm3sM/aRnhvcBK9cMHVR2PGMJl//mAiC2gKNOLb2eZgIBuaXfBl9h3ULI8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l95Qf0yL6teTn1dcHvu3HIXzqtBhTxigQjDWbPP97ToL9/lqQR
 PZu6YLXRZCDXQMc4UgTTKRe3ncqDGmj8+FHow+xje4w16whNJXuD38c471Xnmk/7ylZoeQvFyiK
 0l/65rUkGzvje+QSHTcVs9cIBEPYvLxo=
X-Received: by 2002:a05:6512:b83:b0:5b6:183c:5ca3 with SMTP id
 2adb3069b0e04-5b8b665fbb5mr1072085e87.65.1789577646856; Wed, 16 Sep 2026
 09:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-5-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:53:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLk6wQ=GOzRODdd+D2GQg1=GoP5UN7ZJpPPBQJxZcMQy+w@mail.gmail.com>
X-Gm-Features: AcwNN1VTSOwI-aMkaQ5X6FNcYlrB3vHQ8mD-kiafJFD8muXAXYKzzuAMRSbPmhw
Message-ID: <CAD++jLk6wQ=GOzRODdd+D2GQg1=GoP5UN7ZJpPPBQJxZcMQy+w@mail.gmail.com>
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
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
> This driver requires a platform_data definition, which does not exist
> in the kernel.
>
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.
>
> Since this is clearly unused, remove it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
