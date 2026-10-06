Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB742CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2447C10E30C;
	Tue,  6 Oct 2026 09:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eUS/FOXD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7489C10E30C
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:38:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31D78406D7;
 Tue,  6 Oct 2026 09:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB921F000FF;
 Tue,  6 Oct 2026 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791279533;
 bh=gk2x8xTXFyS7Damzh5pMSZEky6AcMORsKpJ/0CVQZcI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eUS/FOXDO2qaZ0BoiqDrFJLnetqgEHuH4FDypKy7omS9ZHpfG67TTGqoXLXzQlYsr
 xQ+AA9YteCuEzOwlrK/8JQOQtin7iWFP07VzDONUispB7bVIF1vOpK+KAEw2H1ZGP6
 GTv3DhegYPF4ByutaQTnLEcZ2vg490zxVp+NLDdXTazuiWs1rIDtFhnUvCdWS7PD+7
 4EcBkbjTiy19KDPBOWRpDRLiQjcVASDdSCSwvpbcfzVdSfo2wraXuJn1jfaDS9zL09
 Zq1fodG3VoCJlP1AHVwp9Sn9eC1l8V7aWOX4PbuFGaytJf7pfooYqrlla343QezvxH
 qscIL4gbm9wkg==
Date: Tue, 6 Oct 2026 10:38:47 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] mfd: aat2870: Convert to use OF bindings
Message-ID: <asTBp2RPPvsD4AsU@aspen.lan>
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-3-clamor95@gmail.com>
 <asPVmbvyslGgEsjk@aspen.lan>
 <CAPVz0n29+1yOO0i057RdpUAu+z85hhnm9GGaHkqgf5XW1SPfeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n29+1yOO0i057RdpUAu+z85hhnm9GGaHkqgf5XW1SPfeQ@mail.gmail.com>
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

On Mon, Oct 05, 2026 at 08:18:31PM +0300, Svyatoslav Ryhel wrote:
> пн, 5 жовт. 2026 р. о 19:51 Daniel Thompson <danielt@kernel.org> пише:
> >
> > On Sun, Oct 04, 2026 at 07:41:20PM +0300, Svyatoslav Ryhel wrote:
> > > Conversion of the AAT2870 driver to use OF bindings requires a few complex
> > > changes that should be done simultaneously.
> > >
> > > The AAT2870 essentially provides two functions via child devices:
> > > backlight and regulators. Both functions are fairly self-sufficient and
> > > may not be populated on the final board. Consequently, the MFD
> > > registration API was replaced with of_platform_populate(), and each
> > > sub-device was given its own compatible string.
> > >
> > > Additionally, aat2870-core utilizes an enable GPIO. Obtaining this GPIO
> > > was converted to use modern gpiod/OF helpers, allowing the redundant
> > > aat2870_enable() and aat2870_disable() helpers to be removed.
> > >
> > > The aat2870-regulator driver was updated to register each of the four LDOs
> > > from a dedicated OF node.
> > >
> > > The aat2870-backlight driver was changed to populate all required
> > > properties from a dedicated Device Tree node. Its channel map was updated
> > > to use u8 instead of int. Furthermore, because the maximum current is now
> > > parsed as an absolute value rather than an enum entry, the calculation and
> > > application of the maximum current were updated accordingly.
> > >
> > > All of the changes above allow platform data to be removed entirely.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/mfd/aat2870-core.c            | 115 ++++++--------------------
> > >  drivers/regulator/aat2870-regulator.c |  76 ++++++++++++-----
> > >  drivers/video/backlight/aat2870_bl.c  |  55 ++++++------
> > >  include/linux/mfd/aat2870.h           |  95 +--------------------
> > >  4 files changed, 111 insertions(+), 230 deletions(-)
> > >
> > > [snip]
> > >
> > > diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
> > > index 8b790df1e842b..933a8f728f66a 100644
> > > --- a/drivers/video/backlight/aat2870_bl.c
> > > +++ b/drivers/video/backlight/aat2870_bl.c
> > > @@ -15,11 +15,19 @@
> > >  #include <linux/backlight.h>
> > >  #include <linux/mfd/aat2870.h>
> > >
> > > +/* Backlight has 8 channels, each bit represents one channel */
> > > +#define AAT2870_BL_CH_ALL    0xff
> > > +
> > > +/* Backlight current magnitude (uA), 450uA current is eq to 0 */
> > > +#define AAT2870_CURRENT_MIN  450
> > > +#define AAT2870_CURRENT_MAX  27900
> > > +#define AAT2870_CURRENT_STEP 900
> > > +
> > >  struct aat2870_bl_driver_data {
> > >       struct platform_device *pdev;
> > >       struct backlight_device *bd;
> > >
> > > -     int channels;
> > > +     u8 channels;
> > >       int max_current;
> > >       int brightness; /* current brightness */
> > >  };
> > > @@ -30,7 +38,7 @@ static inline int aat2870_brightness(struct aat2870_bl_driver_data *aat2870_bl,
> > >       struct backlight_device *bd = aat2870_bl->bd;
> > >       int val;
> > >
> > > -     val = brightness * (aat2870_bl->max_current - 1);
> > > +     val = brightness * aat2870_bl->max_current;
> > >       val /= bd->props.max_brightness;
> >
> > What is the purpose of max_brightness?
> >
> > Normally it is used to limit brightness but max_current is already doing
> > that. Is it just being used to reduce the number of steps in the
> > brightness scale (and if so, why is that useful)?
> >
>
> This is the original driver behavior; I did not modify it.

I can see that but the parameters for these (rather dubious) previous
behaviours are now being copied into the devicetree bindings where they
become stable ABI.


> The AAT2870 backlight intensity is regulated by the Main Backlight
> Current Magnitude register. It has 31 steps from 450uA (0) to 27.9mA
> (31), so even setting max_current to 0 will not disable the backlight.
> The max current value may be limited for some configurations, which is
> why this property exists.
>
> The max_brightness property determines the maximum number of steps the
> backlight can have and is mapped to the available current range
> provided by the hardware. The backlight is controlled in steps, not in
> uA.

This behaviour does not match the devicetree bindings documentation for
max-brightness:

  Normally the maximum brightness is determined by the hardware and this
  property is not required. This property is used to put a software limit
  on the brightness apart from what the driver says, as it could happen
  that a LED can be made so bright that it gets damaged or causes damage
  due to restrictions in a specific system, such as mounting conditions.

Hence the question, why is the current behaviour useful?

If I understand your summary correctly the hardware has 32 steps
including 0) and the effect of max_current is to ban all brightness
values greater than max_current / AAT2870_CURRENT_STEP.

If that is the case then max_brightness if fundamentally broken because
it's default value offers more steps than exists in the hardware.
bd->props.max_brightness should be set to max_current /
AAT2870_CURRENT_STEP and the whole of aat2870_brightness() should be
removed (use backlight_get_brightness() instead).

IMHO the patchset will be cleaner if the weird max_brightness logic is
removed in a separate before doing the DT changes.


Daniel.
