Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692DFFF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 09:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C217010E19E;
	Sun, 26 Apr 2026 09:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="m/RnLxP8";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2793D10E19E
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 09:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=gV5QBlTsgLILU6JSw4kpZ5JoHyOHW2i+WmDaIwIjC9Q=; b=m/RnLxP8B4FG5gPj38wYUIyKCA
 CC9/YsFqeiKmTnfNyo7aW4aoT4sLU56ys9nX+rf3mmRGcIk95Zmoj7uIITMPpqNZYNasOQR3JINNa
 oA1x4aBNMQ5de6+rzVQYTtYpttYYN5AtwRuOJRzBGhhYZ+FORvC0OBhC9uN9J9aScekucU3ilfD9x
 AASX62TJqQ89SmONeYN2mK/FmwomBNMVo6Lamdpz0JOLIGnEuQEVnyouxtcPYWcZZL3gPW8+oYaT2
 SrwklFlVqsgB0qJgBWw4wKal98Mpm+EG7Qv2fJPMwDIFS3sXUZ3Q+bc8+uHmsWTQQSXDs95H/WPQ1
 frCIgW1g==;
From: Heiko Stuebner <heiko@sntech.de>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dennis Gilmore <dennis@ausil.us>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
Date: Sun, 26 Apr 2026 11:54:57 +0200
Message-ID: <6519122.LvFx2qVVIh@phil>
In-Reply-To: <20260425234845.GC2964234@killaraus.ideasonboard.com>
References: <20260425031011.2529364-1-dennis@ausil.us>
 <ur7mow4lw47ylxj3uigwwasrfywe6n42zb2to7ygeyjlkcgfkf@guzkembyy5hc>
 <20260425234845.GC2964234@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Sonntag, 26. April 2026, 01:48:45 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Laurent Pinchart:
> On Sun, Apr 26, 2026 at 12:44:59AM +0300, Dmitry Baryshkov wrote:
> > On Sat, Apr 25, 2026 at 01:10:02PM -0500, Dennis Gilmore wrote:
> > > On Sat, Apr 25, 2026 at 9:24=E2=80=AFAM Dmitry Baryshkov wrote:
> > > > On Sat, Apr 25, 2026 at 02:28:44PM +0300, Laurent Pinchart wrote:
> > > > > Hi Dennis,
> > > > >
> > > > > Thank you for the patch.
> > > > >
> > > > > On Fri, Apr 24, 2026 at 10:10:08PM -0500, Dennis Gilmore wrote:
> > > > > > The Lontium LT8711UXD is a high performance two lane Type-C/DP1=
=2E4
> > > > > > to HDMI2.0 converter, designed to connect a USB Type-C source or
> > > > > > a DP1.4 source to an HDMI2.0 sink.
> > > > >
> > > > > As far as I can tell, the LT8711UXD has an I2C control interface.
> > > > > Shouldn't it be an I2C device ?
> > > >
> > > > From the datasheet:
> > > >
> > > > The device is capable of automatic operation which is
> > > > enabled by an integrated microprocessor that uses an
> > > > embedded SPI flash for firmware storage. System control
> > > > is also available through the use of a dedicated
> > > > configuration I2C slave interface.
> > > >
> > > > My guess was that it can either be an I2C device or it can function=
 as a
> > > > simple platdev with no I2C controls. Please correct me if my
> > > > understanding was wrong.
> > > >
> > > > But now looking at the schematics, it seems to be connected to I2C6.
> > > > Which means that it should be desribed (and bound) as such.
> > >=20
> > > Hi Dmitry and Laurent,
> > >=20
> > > While the schematic shows that it can use I2C and has been wired up,
> > > it also shows that both MODE_SEL and I2C_ADDR have unpopulated 10k
> > > resistors; as a result, MODE_SEL is connected directly to GND,

looking at the schematics linked in the board patch, I somehow see
both R9 (mode_sel -> vcc3v3_io) but also R17 (mode_sel -> gnd) marked
as 10K.nc ?


> > > putting
> > > the bridge in autonomous mode. I confirmed this by running `i2cdetect
> > > -r -y 6`, with the only device on the bus being the HYM8563 RTC at
> > > 0x51. Without reworking the board, the device is not directly
> > > controllable and just runs autonomously.
> >=20
> > I think it would be nice to mention:
> > - In the commit for the bindings, that the device can be running
> >   uncontrolled or it can be attached over I2C, bindings describe the
> >   uncontrolled mode.
> > - In this commit message, the same.
> > - In the commit message for the board DT mention your findings about the
> >   board, mention soldering R9 or R17 (which one?) and R27.
>=20
> Additionally, how are we going to handle boards where the device
> operates in I2C mode ? Will we use a different compatible string (maybe
> "lontium,lt8711uxd-i2c") ? If DT maintainers are fine with that, I have
> no objection to this patch.

I would assume it'd be more the dt-maintainers objecting?
I.e. the two different bindings for the same hardware and leaking Linux
implementation-specifics into the binding.

I'm don't have deep insight into the i2c framework, but I guess the i2c
device probe does not need to talk to an i2c device due to resources
needing setup. Does the i2c core need to talk to the device at all?

Because otherwise, you could just do a regular i2c device (the routing
for everything is there afterall), add a lontium,automatic-mode; flag
to the node to denote mode.

And if for whatever reason a variant appears with the lines connected
you can just modifiy the DT via an overlay?


Heiko


