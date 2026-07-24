Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A5FC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6AF10F3F1;
	Fri, 24 Jul 2026 21:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OCoFx7j2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBAA10F3F1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:31:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91EF04404B
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BB41F00ADF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784928703;
 bh=1lyKPNn2+QBheUHLLKeFUz3rZkaxAhPd6rt5QtwoqWY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=OCoFx7j2pIEMeh9nhRSL8q/TYgVfqJjt4dtbiICKctHvcakmeRD09WLrhX6nKPJu0
 dVndMg9nCsYBR6MLTXYiH2aATB7R79iQp0JN9vuhmWubEnXHCytzsVrVdCNdffdJmU
 dpYnFt1ZYDI2GJPyp452rcXEi8stnsMn/HpGFR9LcatN7nAVjuHJa7tztCCtmLXET0
 hmUCtkuP5lUKHcvJhw1IWPuOnRHoHurSUf354KkaNVSGR39tW7IZtGtDh2UQvuoV+f
 rFz0D08y4+BuGwd69jzb0XhxjEVtAPJ7NvGUNXzAFkKnqRrRBNTKBtom0VsTmxqLjT
 esqUfx3aGyY2g==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-39c7ce122c7so8088181fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:31:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5IEizWIo0m/OA/nZFiztRx7awlvMrqRH/Wvg5xmPC1j8/NNpOgGED3M8haIb+xIVSo0P68byZ6yg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2Hz0lTbpIMzzQbg5/l1drrsArus1/WG2ehM8i8kI2XItrd7f9
 uwvHHkkmIQGCRclrYa7PiOX5MrB1g9gZsxwybUVOtx5L9taAEaNvQnLyAqVz2v0p0lD9ybrojeg
 uVTKJSodvw60HuDHER8L3ZrIm3nXusjU=
X-Received: by 2002:a05:6512:368e:b0:5ae:b584:562b with SMTP id
 2adb3069b0e04-5b2b2f76626mr1381067e87.48.1784928701837; Fri, 24 Jul 2026
 14:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
In-Reply-To: <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Jul 2026 23:31:29 +0200
X-Gmail-Original-Message-ID: <CAD++jLn9VMq5RcGQy-1TB=SdgkynSDbjeeKoNQ7Z4ZArw-AGFw@mail.gmail.com>
X-Gm-Features: AUfX_mx-62JQQDBcTKutXOrN-Q2fNr59laJWx5ddo44mrkoC0a-8lhzFzZvvk98
Message-ID: <CAD++jLn9VMq5RcGQy-1TB=SdgkynSDbjeeKoNQ7Z4ZArw-AGFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Add Advantech EIO GPIO driver
To: Ramiro Oliveira <ramiro.oliveira@advantech.com>
Cc: Lee Jones <lee@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, 
 Andi Shyti <andi.shyti@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, 
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-pm@vger.kernel.org, Wenkai Chung <wenkai.chung@advantech.com.tw>, 
 Francisco Aragon-Trivino <francisco.aragon-trivino@advantech.com>, 
 Hongzhi Wang <hongzhi.wang@advantech.com>, 
 Mikhail Tsukerman <mikhail.tsukerman@advantech.com>, 
 Thomas Kastner <thomas.kastner@advantech.com>
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

Hi Ramiro,

thanks for your patch!

On Tue, Jul 14, 2026 at 5:54=E2=80=AFPM Ramiro Oliveira
<ramiro.oliveira@advantech.com> wrote:


> +static int get_dir(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u8 dir;
> +       int ret;
> +
> +       ret =3D pmc_read(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +       if (ret)
> +               return ret;
> +
> +       return dir ? 0 : 1;

Please use:
return dir ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;

> +static int dir_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u8 dir =3D 0;

Use some local define for this stuff like:

#define EIO_GPIO_DIR_IN 0
#define EIO_GPIO_DIR_OUT 1

> +static int dir_output(struct gpio_chip *chip, unsigned int offset, int v=
alue)
> +{
> +       u8 dir =3D 1;

Also here.

> +       u8 val =3D value;
> +
> +       pmc_write(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +
> +       return pmc_write(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &val);
> +}
> +
> +static int gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       u8 level;
> +       int ret;
> +
> +       ret =3D pmc_read(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &level=
);
> +       if (ret)
> +               return ret;
> +
> +       return level;

return !!level;

so you clamp this to [0, 1]

> +static int check_support(struct device *dev)

Check support for what? Spell it out.

> +{
> +       u8  data;
> +       int ret;
> +
> +       ret =3D pmc_read(dev, EIO_GPIO_STATUS, 0, &data);
> +       if (ret)
> +               return ret;
> +
> +       if ((data & 0x01) =3D=3D 0)
> +               return -EOPNOTSUPP;

Use:

#define EIO_GPIO_HAS_SUPPORT_FOR_X BIT(0)

if (!(data & EIO_GPIO_HAS_SUPPORT_FOR_X))
        return -EOPNOTSUPP;

> +static int check_pin(struct device *dev, int pin)
> +{
> +       int ret;
> +       int group, bit;
> +       u16 data;
> +
> +       /* Get pin mapping */
> +       ret =3D pmc_read(dev, EIO_GPIO_MAPPING, pin, &data);
> +       if (ret)
> +               return ret;
> +
> +       if ((data & 0xFF) > ARRAY_SIZE(group_map))
> +               return -EINVAL;
> +
> +       group =3D group_map[data & 0xFF].group;
> +       bit   =3D data >> 8;
> +
> +       /* Check mapped pin */
> +       ret =3D pmc_read(dev, EIO_GPIO_GROUP_AVAIL, group, &data);
> +       if (ret)
> +               return ret;
> +
> +       return data & BIT(bit) ? 0 : -EOPNOTSUPP;
> +}

So there is some pin muxing going on here. If that should be made dynamic
at some point this should make use of the pin control subsystem, but I gues=
s
it is currently hard-coded?

Yours,
Linus Walleij
