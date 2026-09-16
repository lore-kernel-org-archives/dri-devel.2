Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F1DC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35D510E870;
	Wed, 16 Sep 2026 11:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rGjgbUUn";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E2810E69C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:19:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B0EA31A07A8;
 Wed, 16 Sep 2026 11:19:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 80BB360337;
 Wed, 16 Sep 2026 11:19:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD72A11C7AFE8; 
 Wed, 16 Sep 2026 13:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789557554; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DQyerW7t6Bd+bJtenwArRhRB5Pn1kPMUDZ4Lln1tqfw=;
 b=rGjgbUUnMZGoIULBVDkMYvcKXJhf8MHhxSVLnCW7abAyI2qrXQMPNGaH5Kxf5T6waKZcQ8
 reHjxvtYnTQVp7h5B0F+T7Ijeg8nJjtfAHwIJcoI0HLnMMAPQGhw8M5iOfTgFdEAHp0DXg
 tP/VjECAntD4GF9T65VpU1jpwEs3tl6K9jF59W0AimgMer1/QzNwBjyjqYrqnehnFzc001
 OiLl1s37pkgwnWePBneyITwjpC8lOhqe/FUyqLWnF+EXp3uRt1sYTbnZb6+YLQOfOXWP8B
 50UbFG5DdH+0QkPG91JjF+9C8pQg8oXMmnP/nr5NTM2KQGRnRdbJDSJVHsjk8Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 13:19:08 +0200
Message-Id: <DLGP7GKZJBOP.350QK94UOGRYV@bootlin.com>
Subject: Re: [PATCH v4 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Cc: "Marek Vasut" <marex@denx.de>, "Stefan Agner" <stefan@agner.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, "Alexander Stein"
 <alexander.stein@ew.tq-group.com>
To: "Francesco Dolcini" <francesco@dolcini.it>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260813092836.38367-1-francesco@dolcini.it>
 <20260813092836.38367-3-francesco@dolcini.it>
 <178954813309.214898.6895255097019153080.b4-review@b4>
 <20260916091543.GA277833@francesco-nb>
In-Reply-To: <20260916091543.GA277833@francesco-nb>
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed Sep 16, 2026 at 11:15 AM CEST, Francesco Dolcini wrote:
> Hello Luca,
>
> On Wed, Sep 16, 2026 at 10:42:13AM +0200, Luca Ceresoli wrote:
>> > LCDIF programs LCD_DATABUS_WIDTH from the selected media bus format. T=
he
>> > format reported by the downstream panel or bridge describes the displa=
y
>> > input, but it does not describe how the LCDIF data pins are physically
>> > wired on the board.
>> >
>> > These can differ. For example, a 16-bit LCDIF bus can be connected to =
a
>> > 24-bit display by wiring the available color bits to the corresponding
>> > display inputs. In that case, using the display's 24-bit format to
>> > configure LCDIF selects the wrong data-bus mode and changes the assign=
ment
>> > of color bits on the LCD_DATA pins.
>> >
>> > Read the optional bus-width endpoint property from the LCDIF output po=
rt
>> > and use it to select the media bus format used to configure LCDIF. Thi=
s
>> > allows the LCDIF bus mode to describe the physical interface
>> > independently of the downstream display format.
>> >
>> > When the optional property is absent, or it has an invalid value, cont=
inue
>> > using the format reported by the downstream display device, preserving
>> > the existing behavior. The code is not validating the DT for
>> > correctness and just fall back to the previous behavior in case of
>> > errors.
>>
>> Why? Generally speaking errors are better spotted immediately, not ignor=
ed
>> silently.
>
> My understanding is that the C driver code should not validate the DT
> and that this is the general recommendation when parsing properties from
> the DT.
>
> The DT checker is going to spot errors in the DT even earlier and in a
> static way.

Drivers typically check for invalid values.

And people writing their private dts can do mistakes and not run the static
checks. Bad on their side, sure, but having a runtime error would be useful
there.

Also consider potential regressions. Say someone has an invalid value in
their product, say bus-width =3D <15>, which works because the default 18
which gets used as a fallback happens to be the correct value for their
hardware. Some years later we implement the new bus-width =3D <15>, and the=
n
that user upgrades to a newer kernel and their display won't work because
it will start using that incorrect bus-witch =3D <15>. Better stopping this
before it starts, IMO.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
