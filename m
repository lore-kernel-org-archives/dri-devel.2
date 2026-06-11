Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D60CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D786C10EED3;
	Thu, 11 Jun 2026 12:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+0jv+Bj";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C9110EED3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:33:57 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-30759632453so2996562eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181237; cv=none;
 d=google.com; s=arc-20240605;
 b=T9TW7+U+q4fteD8LoZj7Bxvlx43DUmOWUNU7Y1U1K+DIyAAgD6MQMNf+DRtAFdpi3F
 zHcBU/ST008xM8R4HrWnEIrW8aPPoBvGHwUerxQKLNtuPPARnjdI9HIsgyVMaChQO7Tl
 iM7o19RVpDvJtgIwtbaid3VYDe2e6Bv+DQZxT/3m96IzIzZKRowEGc7qE4+tIssPyXTF
 NfMQOrlTW47fY0YOKd6mQC3Y4VtSxgru3DeZch/tRtNJ/rnDJzav30HtplmYWQzSVpk3
 8D2ylHiQa32/j2a9kV7bX3FcFVc15ee99DJNtq98ZwFeZ5k897OYdmCs3FTiFJvMkeH+
 fuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
 fh=6ILaehTz89Fp8UwHMXGDki1s6xNtfo7zX/2t098xg4w=;
 b=f/nKOF0ds89nqoGLR3D5n8ePdVsqtvXeRYE6rY3iNQqYtfznhVgB/qpnkMDuYL+Kmj
 5bm624ysLziNZHsiSugoF9UaHh30qJT50auQv8/VzKikvkneRytTvUVcuUET0SclcB+J
 G4sCu9GzVtWytQyEi+dirPUklhhNUTMGhk6sctqSbolY/qYPybKxoMF/yCuDW0+dNBGZ
 9hBadm4XAH5XDXn666Oonv7uZrjbxZdM8/KJYYATeWmeGTAIXURC3jJRkzP3FLzn6m7J
 wYEV0k2G94kJXEgkI38aXa/5d5i+3wM4/PnpiET8DGBpKIjyjg+kKPvSUZQExmQXKghl
 4n7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781181237; x=1781786037; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
 b=e+0jv+BjxjRA/qb33IDv0DJy7sAHLu/GacU8neNZD4/1OMD+rhIAwXIse2YU4R6ucm
 KSNRC0jmiwgyEIJoOvU998B9P4KJEh2wnh2hvLxdORhreODwJI7xptBu8EXz7a8ukB08
 jZ/ahph6yn7qye/Dqj0WQ63F/0RGL11hkKyCdso67ww3csvcW1v7iuh1h77J7yOFx+Tx
 tmVTmSW6FBWgHnDCmJGDGqOvl8PfR/LZZLPDLTlzgdV/JriXXUTP/E+W5DaqfHVLywrN
 RQpboyE+NAUcpysxNuUXcgrQ0vaODURX8sLQRg1fOp5acTtbZj6+KpGVVBaJC4Px55aB
 W+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181237; x=1781786037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ofA25PebqL4AsSYn/VWzRODqpKmh1tVfH1mE+QYxUbM=;
 b=Zp0RuS/08utb7T053yFsBQfsJHytMyaOp3GwYMknGVGPOOm3GWbw3NEV89vInsCAS9
 apL8iSlsUPuzpyDJpXEKqeK8D93KKnzBSAL+ak4PeL1a1w6APLokDNOZJ9JO68di45R2
 l4rDw1+JT1KYXHF7T8NUJyFxFrLmbfjF64CPzYLuh6rq3KjJjNi547DmnrwaCfFvkFqh
 f6d+nCutPFpOMZkpUNOau6GyuAzjsy+WrFib1r/ecjxDy36JHWnZbs7gucP9KEutBb1Y
 hpIvt8vkJFJtMVG/SJcgNPE/UD5HcnKkxGWzy/A0VzbGBHXkdr5yVpSZ+YDbH8ju9NnZ
 /PSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ93CCyFNhtoHox+F95qCDJT3xPBtR2eD1kdr2bgygp39Ek6TwSnGe5RfB1Pl3YMwrZk9226kPWvDgQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsBZpbvKrTg3iHbxgrTZFxFHBn0hVExOhWI8gg8tqOrIhkLnp3
 QfCGiX8a7CfYJ0jE+cL8ATVmHMw63PBGd0qDhkdxBN6tVPMOUucOHjezkNkxasMeWSy1soCzUZv
 fxxMDjwdEuIPd8bheTVdx8piVDGiYVbo=
X-Gm-Gg: Acq92OFHbRJgq1FXCk5OWN5gw9e4OzHb9aoOKCzNqlT4P7J9YDb9NRPULB4RbdSXjem
 CIVwR2dyK4u3aBIp3T4xzNG1DUqd6GMwOvvBiZ9l6I9P5jE4A0x/ikWKIRqRXqPA9uPbdDMY3Xt
 YxSx1PdcaiGzARZR67ErxrIjgaNjHeEQ2gpqbVi53ZoO2usr+1cSKY3iIW2tdaqA1kqa/9LkJ05
 UXUcGa+3cAyAHkLQkPcuJdWAePVMshg5iSFYkqhuL1EuI3o2VxaRrmzfEwQo2kGPJOefX28viM7
 roLdtAYTZoQlmO6KtZw=
X-Received: by 2002:a05:7300:6da6:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-3080411cef8mr2308986eec.0.1781181236808; Thu, 11 Jun 2026
 05:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-15-clamor95@gmail.com>
 <aihoH9Pmzufa9pnE@ashevche-desk.local>
 <CAPVz0n0m+i7wexfC0BWwvdOuJxDk_=x+EpxEbNmoHN1AsEmfNg@mail.gmail.com>
 <aimy3BxBaXQ3Uigd@ashevche-desk.local>
In-Reply-To: <aimy3BxBaXQ3Uigd@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:33:42 +0300
X-Gm-Features: AVVi8CeX4OO_pI5sFq7qWhCQuBWbqnNi5DWXxYDyaE3k8yybACe4K7ODLE9J31I
Message-ID: <CAPVz0n0bpo6PAfdN+LGEgPYhEx8mqtu_SL=WnDxhWn-Cq4rQKA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
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

=D1=81=D1=80, 10 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 21:5=
4 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 10, 2026 at 05:45:28PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:23 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > > Add Control Bank to HVLED/LVLED muxing support based on the led-sou=
rces
> > > > defined in the device tree.
>
> ...
>
> > > > +     int ret, i;
> > >
> > > No need to add 'i'.
> >
> > This is personal preference as well. There is no strict rule that
> > iteration variable must be defined strictly in the for loop.
>
> This is a preference by Linus who is the leader of the project.
> Also in IIO we have some set of maintainer preferences.
>

Well, this is not meant for IIO, though it seems that Lee is also in
favor if this approach.

> > > > +             for (i =3D 0; i < led->num_leds; i++) {
> > >
> > >                 for (unsigned int i =3D 0; i < led->num_leds; i++) {
> > >
> > > > +                     if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> > > > +                             continue;
> > > > +
> > > > +                     output_cfg_shift =3D led->leds[i] * 2;
> > > > +                     output_cfg_val |=3D led->id << output_cfg_shi=
ft;
> > > > +                     output_cfg_mask |=3D OUTPUT_LVLED_MASK << out=
put_cfg_shift;
> > > > +             }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
