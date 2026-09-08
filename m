Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DD4C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C6E10E3B0;
	Tue,  8 Sep 2026 17:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mw0IZTWl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C15C10E3B0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:28:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E801043F44
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8411F00A3D
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788888485;
 bh=XjM+NfW0WLuiq2c1NmH2zxMXe3faot5pYKc+rUVJPpc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Mw0IZTWlWZd6tmpbKwNOisRcQuvXK2SkbNf6x6GS/qCuKYmI4IVrMy1TpjMYgP4Mv
 oRcHvPLOjYnpMcRJ5/hteWoU6abVG08FkgBcNv3nByz/EOTkBgmWPuOfvUTBwhK7vM
 tw9+rF2Zfwq6oE8tnzcmwUx7Xt6fuTWlVA1W9uFIt58IIQZIcFqZHTzpDsnWAwKkj+
 wQdCWkkZ1fcuo1Dpv7Kx6Rp5SC80ktHjitdRpRhH9tWj5zSxnGYZ3EX1xmFCLfEHfh
 /B5iXqWRo5LbOjo8TI4VwCjfaQLBXVD7JzD8erPg4NYDtqwnvve9FXhYv+ZYS/bECe
 hriFz4ItaI54g==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5b6036e9c70so3767614e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 10:28:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzLfLQOx4MUQOQNOpHzo8gxf7aB4vI4Ops6GvPiwqzcxRtnM0uTCNlCDHT+qFY8ow8f3XxzL4zTuBs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++no2e49OvM3DZ0J3fCSgnqWPonu8qC+s8AChn0uM+ULwBlfTbnO
 6Fc7nI4RGmw1k/1UY03K1TTkml94TcP2iC55hXrY1/xm0kmhhcqDjcfNctJi9V1P6rav+hqBKhc
 EefEwYVttPj0n8ujNRIYFs6Rlwqffyy4=
X-Received: by 2002:a05:6512:6884:20b0:5b6:1a7c:3f with SMTP id
 2adb3069b0e04-5b61a7c0196mr2554286e87.66.1788888482136; Tue, 08 Sep 2026
 10:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-3-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-3-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 19:27:48 +0200
X-Gmail-Original-Message-ID: <CAD++jLkzrp4hsOERqOt6Zc75p-+KoWj0Tvu6VQk=ma2kgDH=Qw@mail.gmail.com>
X-Gm-Features: AcwNN1UJNXIoMX0oKBuT_VyMabX-dcNfrhwjoX9gJLRVYT9sdHBezlMdahVsqlw
Message-ID: <CAD++jLkzrp4hsOERqOt6Zc75p-+KoWj0Tvu6VQk=ma2kgDH=Qw@mail.gmail.com>
Subject: Re: [PATCH 02/13] ARM: remove footbridge
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
 Ralph Siemsen <ralphs@netwinder.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org
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

On Tue, Sep 8, 2026 at 5:28=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Footbridge was deprecated in 7.3 to be removed along with the other
> StrongARM platforms and most remaining board files.
>
> The main machine here is the NetWinder, which was a popular Arm based
> desktop PC in the late 1990s and contributed to Arm's later success as
> an embedded Linux platform, but was discontinued over 25 years ago and
> is no longer all that useful.
>
> I previously tried to convert this to devicetree in a sensible way but
> gave up due to the platform being too different from modern SoC based
> targets.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ralph Siemsen <ralphs@netwinder.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linusw@kernel.org>

I have one of those machines and it boot mainline but I
certainly consider it a paperweight at this point, I can't use
it for anything useful.

Yours,
Linus Walleij
