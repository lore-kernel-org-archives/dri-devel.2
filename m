Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E090BCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4976A10E376;
	Tue,  6 Oct 2026 10:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d2qDkNb2";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897D110E376
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:06:59 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-35127e848feso672489eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 03:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791281219; cv=none;
 d=google.com; s=arc-20260327;
 b=Mf4rvjNuyhhnJdtp3n1sV4LnEd8LW2QArcQjblDjW0Pu8zqeTNkAAhBqFoQNqvVpzj
 tvSkp9R1QShyXtzMGZn5wNV6IviKC4FQSRhrNQzNX7o0HciqV/PahC83IkmRwGodeMsv
 6MbbTcbis20VJ0Z6s0gFQUDPrKtm7/91QyfdsXnKe0upcT1TZq/CpiUDRAeHUWyNxOX/
 JJDBW+OGMOzgDsudWkBTnr8XubdfAPkQPdm74W8d2KscUwtAAB8iiPVlQPeU+uNR0cSk
 kBlUnIi9PPNZBpjNUiU2krEBTzuUEibC/CY+4u1MHmgXi4UPhNxRROhuUcAUT8Wc9Q+S
 MDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6NBVbMbxanh8syK4XzpA91skjBSLQAwKVvNkTlGCE98=;
 fh=YTLwdZBr6w15DVM5DBJoZFFPgsODeMPkAHILD9V6eG8=;
 b=mLz8a7dEPDgzlysu35MR3nh4t9QGBvuMep93IPAb4xc6Zp/DOgEoYe6ksz/gzbzwNa
 Pls/c4hdNYWLnuQu2cDd1mP/pOLuwSeEMOOg59Zwrl7giRm6O1GLkgArU6BhMaX5gMdV
 oPocnhygca0KTEUqMEQnmjZOZV31YKnupwd62jCMiYyF+S/esQt2e2YdvmM2/tWC7gm4
 SO/0F7RCQh507QPtGwYdUaZ9ekIGmtAMk6ZxG8cHvvZCWpCM8RHE8WntfSdcrq3OvhbT
 3Gn6t1p/PJvbaOcQvRB/zy6rNTmWQq5luIWlt0A3WARN6fz+R1IDgAxXuzZ7iRk+Ynla
 zN5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791281219; x=1791886019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6NBVbMbxanh8syK4XzpA91skjBSLQAwKVvNkTlGCE98=;
 b=d2qDkNb2bYEyrlf5GqLFbWSJz2AXMr5OVW6etnLM3Fq7ohTr4syognCW2OSV9luPxu
 1+ogw5pPMQQFElIRYAruywQKu4hR2N4/FVRsgNfyTcF6OVn9YRMwtTfidky27Q8DqMJ7
 lI0hb469x7SmvBdj3XVqgsMupHeob1imAXH3qz7qa3MGTscK9XYoSPHeSCqUIFjzukxn
 LS5y7Eh4PxIWc7SJtR0aiasSZXSaJO/LkqYYMyW345+srM76iJZ2rcyJE4L1xfDwXay0
 VPWQKbjbqnGTEIK0n3ZmLqvmfaYpfiqYOaIBBfdUmlIpCEXBndwLRrTbUhExlueTpnZg
 7DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791281219; x=1791886019;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6NBVbMbxanh8syK4XzpA91skjBSLQAwKVvNkTlGCE98=;
 b=srMgqaEKll69doGU1kdtz3CKAWT67OOdoI8IUxaubAKfA+HrnOwWb29DpENmntp/et
 Yzc4wFsA2ZfwFaoSKVvp2w6/5RzQ7EtSChEvU4SFKoo42K1tHmrU7qV9owShAsPpQ0Mr
 5aMlOeWFehNiw1edTExqjwcHoeqqPAvkt9ZNzRCEjEFM2Pgy/ilERHLYkkHvMcaaoldj
 qRfiakcnLM04r91zSreLETKB0pGliu/9gTahX9xhuYEfOFDcn2L7UIvhpPR+EgHPPgOk
 27toTIEm0aOfQhaeyqxmT/4LaEB1ZaOUxW7PLyVWgvqL2J1MYeLzCvrc/vJKpsC3hrSN
 6bow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlK+KIEEUZQbBVSEu+B+mDb5dbk8Zvqbr5WhzVAcGvesSUyvT2Mso8YuMTzKacypMOlrjyXu3CdIg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLlRGltcHXbcQAF3C+GUNUcz0I/C8GtLnguNY9ImlQDftF7AxfL
 eM5bmx1G27VrhXP5BDiZ3qKPxCYWDm9ymLSwCuIWbonsqjWVUkkuFvo5hcvBRV9DKynzcBm8Z0k
 5682PXdhZ/rAapldT2rwF43Tcvj/+iLo1+g==
X-Gm-Gg: AYBFou1RA58bxSQn6SHBSzr/cvglltHFIhqg8dzUoeoFjBzEsghmQzz8dolnDR06H+H
 ZcnBpExosQuFc6U2RRr9u+57lWV7zQ203qntmbEUu8uEKmK5Us3lssrCEPBsjwsM6Wywb79rVTg
 0QQ3Xbkks7AvjAsuFLMH1mD4KJmDBjnYiXqjulCD//LF2ZXeuvE4hpX4RHzImP3pSI50lIxhZoF
 RiL0wl7PEgKya3EcKJlMvR5oD/RU6a9r1CCxcESA/0qj/N0Hk9a0BrAvaVNWN1AQ4N7Hrd5g/Rz
 eD5gtntSmVzDvBzE4v9AzppvmY788xSpxT8m+ljx2SAx/Xo1CR81h1t8fIjvSyKT9LPaLT4vT4j
 P8DLJhHCzeDslZMe5nHdIyPE=
X-Received: by 2002:a05:7300:fe83:b0:34d:2c1a:9881 with SMTP id
 5a478bee46e88-3514e2e4731mr1077709eec.36.1791281218726; Tue, 06 Oct 2026
 03:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-3-clamor95@gmail.com>
 <asPVmbvyslGgEsjk@aspen.lan>
 <CAPVz0n29+1yOO0i057RdpUAu+z85hhnm9GGaHkqgf5XW1SPfeQ@mail.gmail.com>
 <asTBp2RPPvsD4AsU@aspen.lan>
In-Reply-To: <asTBp2RPPvsD4AsU@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 6 Oct 2026 13:06:47 +0300
X-Gm-Features: AclHuK9B4BcbljbuUp4qHu8_KC4fu9LyfN3Q8g8blEUDDcIte_SIuNY9L1q_5iI
Message-ID: <CAPVz0n1PMxOoHMJ3viKa-e3=tjZ6AtzffjnHE9kCFrz1tjezOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: aat2870: Convert to use OF bindings
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
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

=D0=B2=D1=82, 6 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:38=
 Daniel Thompson <danielt@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Oct 05, 2026 at 08:18:31PM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 5 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 1=
9:51 Daniel Thompson <danielt@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sun, Oct 04, 2026 at 07:41:20PM +0300, Svyatoslav Ryhel wrote:
> > > > Conversion of the AAT2870 driver to use OF bindings requires a few =
complex
> > > > changes that should be done simultaneously.
> > > >
> > > > The AAT2870 essentially provides two functions via child devices:
> > > > backlight and regulators. Both functions are fairly self-sufficient=
 and
> > > > may not be populated on the final board. Consequently, the MFD
> > > > registration API was replaced with of_platform_populate(), and each
> > > > sub-device was given its own compatible string.
> > > >
> > > > Additionally, aat2870-core utilizes an enable GPIO. Obtaining this =
GPIO
> > > > was converted to use modern gpiod/OF helpers, allowing the redundan=
t
> > > > aat2870_enable() and aat2870_disable() helpers to be removed.
> > > >
> > > > The aat2870-regulator driver was updated to register each of the fo=
ur LDOs
> > > > from a dedicated OF node.
> > > >
> > > > The aat2870-backlight driver was changed to populate all required
> > > > properties from a dedicated Device Tree node. Its channel map was u=
pdated
> > > > to use u8 instead of int. Furthermore, because the maximum current =
is now
> > > > parsed as an absolute value rather than an enum entry, the calculat=
ion and
> > > > application of the maximum current were updated accordingly.
> > > >
> > > > All of the changes above allow platform data to be removed entirely=
.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/mfd/aat2870-core.c            | 115 ++++++----------------=
----
> > > >  drivers/regulator/aat2870-regulator.c |  76 ++++++++++++-----
> > > >  drivers/video/backlight/aat2870_bl.c  |  55 ++++++------
> > > >  include/linux/mfd/aat2870.h           |  95 +--------------------
> > > >  4 files changed, 111 insertions(+), 230 deletions(-)
> > > >
> > > > [snip]
> > > >
> > > > diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/b=
acklight/aat2870_bl.c
> > > > index 8b790df1e842b..933a8f728f66a 100644
> > > > --- a/drivers/video/backlight/aat2870_bl.c
> > > > +++ b/drivers/video/backlight/aat2870_bl.c
> > > > @@ -15,11 +15,19 @@
> > > >  #include <linux/backlight.h>
> > > >  #include <linux/mfd/aat2870.h>
> > > >
> > > > +/* Backlight has 8 channels, each bit represents one channel */
> > > > +#define AAT2870_BL_CH_ALL    0xff
> > > > +
> > > > +/* Backlight current magnitude (uA), 450uA current is eq to 0 */
> > > > +#define AAT2870_CURRENT_MIN  450
> > > > +#define AAT2870_CURRENT_MAX  27900
> > > > +#define AAT2870_CURRENT_STEP 900
> > > > +
> > > >  struct aat2870_bl_driver_data {
> > > >       struct platform_device *pdev;
> > > >       struct backlight_device *bd;
> > > >
> > > > -     int channels;
> > > > +     u8 channels;
> > > >       int max_current;
> > > >       int brightness; /* current brightness */
> > > >  };
> > > > @@ -30,7 +38,7 @@ static inline int aat2870_brightness(struct aat28=
70_bl_driver_data *aat2870_bl,
> > > >       struct backlight_device *bd =3D aat2870_bl->bd;
> > > >       int val;
> > > >
> > > > -     val =3D brightness * (aat2870_bl->max_current - 1);
> > > > +     val =3D brightness * aat2870_bl->max_current;
> > > >       val /=3D bd->props.max_brightness;
> > >
> > > What is the purpose of max_brightness?
> > >
> > > Normally it is used to limit brightness but max_current is already do=
ing
> > > that. Is it just being used to reduce the number of steps in the
> > > brightness scale (and if so, why is that useful)?
> > >
> >
> > This is the original driver behavior; I did not modify it.
>
> I can see that but the parameters for these (rather dubious) previous
> behaviours are now being copied into the devicetree bindings where they
> become stable ABI.
>
>
> > The AAT2870 backlight intensity is regulated by the Main Backlight
> > Current Magnitude register. It has 31 steps from 450uA (0) to 27.9mA
> > (31), so even setting max_current to 0 will not disable the backlight.
> > The max current value may be limited for some configurations, which is
> > why this property exists.
> >
> > The max_brightness property determines the maximum number of steps the
> > backlight can have and is mapped to the available current range
> > provided by the hardware. The backlight is controlled in steps, not in
> > uA.
>
> This behaviour does not match the devicetree bindings documentation for
> max-brightness:
>
>   Normally the maximum brightness is determined by the hardware and this
>   property is not required. This property is used to put a software limit
>   on the brightness apart from what the driver says, as it could happen
>   that a LED can be made so bright that it gets damaged or causes damage
>   due to restrictions in a specific system, such as mounting conditions.
>
> Hence the question, why is the current behaviour useful?
>
> If I understand your summary correctly the hardware has 32 steps
> including 0) and the effect of max_current is to ban all brightness
> values greater than max_current / AAT2870_CURRENT_STEP.
>
> If that is the case then max_brightness if fundamentally broken because
> it's default value offers more steps than exists in the hardware.
> bd->props.max_brightness should be set to max_current /
> AAT2870_CURRENT_STEP and the whole of aat2870_brightness() should be
> removed (use backlight_get_brightness() instead).
>
> IMHO the patchset will be cleaner if the weird max_brightness logic is
> removed in a separate before doing the DT changes.
>

Noted, I will see what I can do. Thank you.

>
> Daniel.
