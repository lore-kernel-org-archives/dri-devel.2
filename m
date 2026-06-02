Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6902CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6910EE95;
	Tue,  2 Jun 2026 10:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HuyD9beV";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF9F10EE93
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:31:56 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304cf518c9dso7558672eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 03:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780396315; cv=none;
 d=google.com; s=arc-20240605;
 b=RjiHYyYidJp9PCGoWJcUf1XVgQ/g4CxreZAFevmTjegqIkYU7ggfZ2iFkNa99exMBi
 4VzkDgckYFvvFeXfYYPhJT0potOTyLqgwKvtdcq77sES3h3Z3btaovqCa9XYnxwamm8x
 18RHsA+njImquSA73O1UpZ0u6H8gTeZUkwRMdNTYURimJDtOEULPHo1PvXLXwwwnkfNB
 vQoqh8WNij34qL7vaJCFdg66LV0505h+BHypqo5D5w8L5BJjqXDHxJkGvWSfbCxejKqD
 JbHY5zDadZKY6n7NbA7rpQuzH726Mhm8ENqSLaXQx1B74eEYuc6WR1ZRq5LhiiSy3cNO
 lK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
 fh=aZ6dvXWrV/bSfRf8HSieS8IQIqTfQoHj5EUvrU6FPEA=;
 b=GLWzlhILBgsQEK8JjOSr3qZBb0yrasMmjY8voRy4/G2Rkuvw/v1rLGnncY9szZSRwC
 2Z1ucBwi5fNHUTIluQ7rvkgeB2ZjgVg85GIfGaOQrrMIx5FrPlRa+S3sjk6MyazZ+74u
 hydOPo28JoSgI1po6Bw7xCtKHlHCYJ4W0nPXu67rDKsMmGtdUruSI/aVtpVEQl4WIeZh
 T2LSI1xqJd10BqltsiQwCaLK4zlorxWqpi9fw1Q4lhVdHH563mPQlrquR32iNTO6ifya
 EC+bqifAjJB7CEC/FAYX8UxgBduvxPxfuqoDc83IUxEhhOVMAs5fhi5cFIQYja55yMzH
 XCdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780396315; x=1781001115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
 b=HuyD9beVqV7Q2B0c9AUnbvEEd9GZtX7LpF32aje97hGyrE1m4WaRyKEJqBGAyYLxkC
 eY1MFiLM0jDGk+H5qoRm+gdcokHX4hXc6cx0gZC+83jb4mcoeC3h3teL1ZEufgIoMHem
 ee7XNE2rDoAAkzOtOKPIohXU5+ABda6OIgAbdjT4runiFTzPEHctxi3MWUTuDY7jSYzu
 IPY2K8eQ05geJ1fESF/zWWeZpl7iIGc4TfMnlP6xw59Y5mLHa2zRzazjAtT4w+g/z1+3
 /z5wq/NEsW9fX7YkXMqpymE525QV9DwIdHs1dqsxHqDHrbs7aO3lmE7WE0XKoyJO/cAg
 wRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780396315; x=1781001115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lDdI0YPykfuK0xhOe7sArc4RNqAa0Hyds1kbH01jcws=;
 b=Al8t5+dX9lMZo5KptnM/dXEjMSiU6VEJ25QbA0s6OpY+BbSP80xGL5IHoeqRTH/me4
 wx4oMenVJvzxWPTMTrGmZfJaOCgFz8PJcj+N14tb+7oosqg/PvR1v+PjT+dKwFdokoRd
 dSa8GGbyI2NEei2W22BcNuq9Zpb2c83DU0D0m2SJM6p7EyPHwzWW926kjWzZUSkfFRB7
 M8UUPcLnEl6742Jzh8z4U3DERl81JGqWgzWNB7kOsewK4EkBeTgqGRK+Rx33Ld7UIOlF
 EyEbzWOYSMmkT+03yPsO7un7vqdBIs9HMcRHZaY8VpbT88S8cckc0MlRrkw7lX4PYRa1
 G5Gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uWn9LNikDFfz0hrl7aMywXRn2S5N2WmdwGovYoVjekPnXMMIZp2SF6ntfN8EsagMfYDy2AMeX12k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKhFaEWMWVsXaZxrvsLBNJ9ZnynRQVuF+nAZaqxC7sHnqVnbbK
 TRjBqWAiP/AJSoFrd2CJdeXsCpoJDbLpxstMf16ljagib+O1fXwR0K8mMP0QGFUm8WQ8khXPTM6
 X4H0lERChZYeSQXFci6uSAqIBWOttFGE=
X-Gm-Gg: Acq92OF6h+4bAl/k8ndip7e6ryagmwQfw81kayTpmOhKQNUESB304rHvGBf1MztEv8B
 TMpo718nfBrqEilBjrrM+FNhP5pFep1qdQj1cO9kMWYKAvSyLNmJT0nMEg3oSGnteqrikrwA7Vj
 gKDV4e/o3tpC5czFKQlgIPKqxh5iK3VmWokFYCLXhk6RhhgBDME+Z+c5W+eVm5gg/Cp9u5RWGOk
 05mJf7qal2g0g6kvBjb2vdKXeQLfNND2LC1X9e6dJWvblvkRQyXQvWI2IX4Xb/kfqOsYGBuHmDw
 3ykl1pV/rmW8VVc2xXuZ5d1/XRCBCg==
X-Received: by 2002:a05:693c:2c86:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-304fa64c553mr7093613eec.27.1780396315135; Tue, 02 Jun 2026
 03:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
 <ah6TGjRNnDpQGO60@ashevche-desk.local>
In-Reply-To: <ah6TGjRNnDpQGO60@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 13:31:44 +0300
X-Gm-Features: AVHnY4LWQiJbbknL3YlvePeYbIxJnooafI1v7YVQtfA6307ubpWpYRL37q4rijM
Message-ID: <CAPVz0n21RGAaJc1sda4xyp1h0z+6R6FJ4=XWdOtB1mgtV8=RUA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:24=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
>
> ...
>
> > @@ -57,6 +60,9 @@ struct lm3533_als {
> >
> >       atomic_t zone;
> >       struct mutex thresh_mutex;
> > +
> > +     bool pwm_mode;
> > +     u32 r_select;
> >  };
>
> Have you run `pahole`? Does it agree with the layout you made here?
>

Noted.

> ...
>
> > -     als->irq =3D lm3533->irq;
> > +     als->irq =3D platform_get_irq_optional(pdev, 0);
>
> > +
>
> Redundant blank line.
>

Simplifies code perception, whatever.

> > +     if (als->irq =3D=3D -EPROBE_DEFER)
> > +             return -EPROBE_DEFER;
>
> What about other error codes when IRQ is found by can't be retrieved for =
some
> reasons? IIRC we check against ENXIO in similar cases
>

Then we treat it as no IRQ. Original implementation cares only if IRQ
is present or no.

>         als->irq =3D platform_get_irq_optional(pdev, 0);
>         if (als->irq =3D=3D -ENXIO)
>                 als->irq =3D 0;
>         if (als->irq < 0)
>                 return als->irq;
>
> ...
>
> > +     led->pwm =3D 0;
>
> Isn't it 0 by zalloc ?

It is, thanks.

>
> > +     device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->=
pwm);
>
> ...
>
> >  #define LM3533_BOOST_FREQ_MASK               0x01
> >  #define LM3533_BOOST_FREQ_SHIFT              0
> > +#define LM3533_BOOST_FREQ_MIN                500000
> > +#define LM3533_BOOST_FREQ_MAX                1000000
>
> HZ_PER_KHZ  (since you included units.h)?
>

500 * HZ_PER_KHZ
1000 * HZ_PER_KHZ

You meant this? Sure.

> ...
>
> > +     nchilds =3D device_get_child_node_count(dev);
> > +     if (!nchilds || nchilds > LM3533_CELLS_MAX) {
> > +             dev_err(dev, "num of child nodes is not supported\n");
> > +             return -ENODEV;
>
> Why not dev_err_probe() here and elsewhere? It looks inconsistent with th=
is
> patch.
>

I must have overlooked it, thanks. WDYM elsewhere, this is the only occuran=
ce.

> >       }
>
> ...
>
> > +     device_for_each_child_node_scoped(lm3533->dev, child) {
>
> > +             if (!fwnode_device_is_available(child))
> > +                     continue;
>
> Do we need this check?
>

This is nice to have if the node is disabled. If we assume that there
are no disabled nodes, I can remove it.

> ...
>
> > +                             dev_err(dev, "invalid LED node %s\n",
> > +                                     fwnode_get_name(child));
>
> %pfw
>

Noted.

> ...
>
> > +     ret =3D sysfs_create_group(&dev->kobj, &lm3533_attribute_group);
>
> No way. You should use .dev_groups.
>

I did not change how driver does this, just swapped lm3533->dev to
dev. I will set is back as it was.

> > +     if (ret) {
> > +             dev_err(dev, "failed to create sysfs attributes\n");
> >               goto err_unregister;
> >       }
>
> ...
>
> Can you think on how to split this change to smaller steps? I believe it'=
s
> possible.
>

No, I am done with tinkering with this patchset. It is broken enough
and it has inflated enough.

> --
> With Best Regards,
> Andy Shevchenko
>
>
