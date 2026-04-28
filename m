Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23BBFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A95010EF38;
	Wed, 29 Apr 2026 10:11:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HGsk2SUy";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F33710E09A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:12:53 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-479eb8bcacbso4326047b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777363973; cv=none;
 d=google.com; s=arc-20240605;
 b=fC6bLp8Ph04JCuLzlBrvP4v3HQauuUcVZJCLX1bbKVNXq4z6WKkJzsk4Z3lgGEuUJc
 VOOqaYkbMiUCgvv1OG9tG+0/U8JsEUjLY8L1g0kL/H4RQYKpj2B0IPRDNQJe7HDLYGlP
 BF+K5j1Pzarlv/cZFSodnKu8Nk6nDhIGhfBA7GeW93X1hTKR0Rf+/7gcOh9CM2/oDMV0
 VyMhHZXFUBkwg45taURbXga1oWHwI1fwp0wxir1vMVQ0FxJMWfGp6yfEMBmVJ8o/VtD1
 6BEZMAEGYH/wSpEUkBS4ZTuKDZxeq5fpbouoMAZ+S/z5GQ4QmMS0FKptQiz3zua8npJy
 pkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S4SMKua/Q4FYJC/q2iwoO/pP2cuR3lZNeCTatqb8PHw=;
 fh=fRD8Pw/Vpor7y7Qadpy9XEhpN8PKsSxWVUoAKGMxlak=;
 b=iKdB3nkNwDsf3zEJRyxdKa0BsHYjWiAiaDjxvcwaC25BE38couElx47gVK+sXoU485
 6O9BtoewmfSUHsQAAdTNDTB2GsgQE6nT+BsjFzv0Gqbe5ESOC9eLOSc1TTuwHvTvuqIX
 SAX8tbZgLIaj7Nl30whN4lv5EYbDoXdPuIo7m1XNeTo4BNmjEyLle9UjlCG/RSu3sbZd
 +PkLv3Nt+cv6wK7TLnVai8qaH4/n6OyNLa7ML2F76gQMXXABa2GtHGyxo8ZPW12OZ404
 510aZROH+SJxAnpUujRVUsMqSsD7ATmBNNzMu510UFeVUY4iv3TxUu2mYhbmctESc0mt
 9xMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777363973; x=1777968773; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4SMKua/Q4FYJC/q2iwoO/pP2cuR3lZNeCTatqb8PHw=;
 b=HGsk2SUyoLlPkr+CUSaiKJBN6gspbPwRGFZl49zALFYJSOONGdgCvoFOJnqlvOq3Wv
 BeblV9yl1ekQsGAwKP4wncYkh1Bqep0mf6IW60AVOC4DZnaTCoM0FvsAVkCqwHjCTG1K
 s0rrKIgjBlaTB75WjaiaiB912zUWiJATcFATLDF1i3xSKsDvN6fVLyav0rlzLUqhJpF2
 bfozydxINhBiwcmjDvDwu/rwUU7sBnGcKjfjOtBgax1S7+op5IAprlR9+HwltvcCB7rY
 /pkS+3JuX72cYewuV7oJYVzUOENYiUnYWsvPMfp9Z4Mpw8ST/DzlYzmqJVKLrnwJxizn
 FKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777363973; x=1777968773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S4SMKua/Q4FYJC/q2iwoO/pP2cuR3lZNeCTatqb8PHw=;
 b=ZuQQdRPy9saeI5fCf+v3BbEkyWuaXzD1sv0syI2V8QIghEkP0RuuEEbLjhjsE4VFcN
 hMMDXZL8r2g4PbmX+L1giQ2Uql4BAbHk0C/JJQVjB2Zr9xFL/ye7bSfzaYn/rboRL9uR
 jIqC6n2dylaPLq0iMhiluOpB9SsqfILobFk8gnIwUcQv0v3zspNYNq9fmfD3mpRe/0cA
 Wp8gc3UXZC+nr27xjsFJ3PWXsAcHtelNqDC5CleP+hfmU67BR0t7iETg+n0CU/NINWtJ
 7Pj4u2ZzscR3P28bh6YysgO/2ggargC/hyaH+ndmaUQQE9ivttz8VdDBKenCMHpKce3X
 WbfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/U04L3zY4t5gQ1hJb49VRyYqkItsiHxNWakl17zrDZdahmINQlyL6y+Cc24XTPn9hJmRcP+0kCLaQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTOhl35VpKEy+jRqlZAiQ+Z/KQ1Aky39GNvV4sISRowRcI53cS
 v/DJp9tuDk/U8aD0ZXL5TsOPLdL2J8KfhVvfhLYMaMRJjZIq3On9/nwkc7JttXGFmuIsu5bO2Cr
 A+22vkFZXbY5VftRSE6XNAS/2LS321OE=
X-Gm-Gg: AeBDieunhVZARlbytRfmNeEMSiefp/RLMAypKr0OfAhwRnQivKbMKW+UDKj0Uppub1p
 SX3n8nCu7nmEDXZJxWAlDHNTWF3/wEHXViTFhHCMG9T9jyLhZOcMmA2frcWLyGesu7OrEDt44X1
 3+IRp14Nuj57dv5JB6yzWS6NjDHlSJfHU+Th5y0xiX4R0pEg+nWQZORnA/f92WNEq/IhmYf7vJf
 fsQ9ba73uRNVyeRdJOaA49H6qkf0tNkty6ImVG+JqfhAvtUF9/MdHFWFnX5BP8Wfqqn6wBCr4xb
 7vc0G5P9oZNnMr4Skg==
X-Received: by 2002:a05:6820:1b05:b0:696:177d:5246 with SMTP id
 006d021491bc7-6965ca4bcd0mr937609eaf.5.1777363972642; Tue, 28 Apr 2026
 01:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260428063224.3316655-1-syyang@lontium.com>
 <20260428063224.3316655-3-syyang@lontium.com>
 <ygxqqtql2puvej5bkmac3vhlwd4lv2f4mcjim2ornq5gj7rsoo@6zfnqckp2d7a>
In-Reply-To: <ygxqqtql2puvej5bkmac3vhlwd4lv2f4mcjim2ornq5gj7rsoo@6zfnqckp2d7a>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 28 Apr 2026 16:12:40 +0800
X-Gm-Features: AVHnY4KsepSq0dzd7vJjcut4qHV0tgsykTgs9ixdxu9xepitP8tPT2zTf4tt96I
Message-ID: <CAFQXuNYV_Jzi26FN23b8zgw-UEsgheo8R4OVzz2TG4YZnJoYcw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI
 bridge
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
4=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 15:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 28, 2026 at 02:32:24PM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> > and output signal/dual port mipi.
> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig             |  13 +
> >  drivers/gpu/drm/bridge/Makefile            |   1 +
> >  drivers/gpu/drm/bridge/lontium-lt7911exc.c | 497 +++++++++++++++++++++
> >  3 files changed, 511 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index c3209b0f4678..8cff2bf15b09 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -132,6 +132,19 @@ config DRM_ITE_IT6505
> >       help
> >         ITE IT6505 DisplayPort bridge chip driver.
> >
> > +config DRM_LONTIUM_LT7911EXC
> > +     tristate "Lontium eDP/MIPI bridge"
> > +     depends on OF
> > +     select CRC32
> > +     select FW_LOADER
> > +     select DRM_PANEL
> > +     select DRM_KMS_HELPER
> > +     help
> > +       DRM driver for the Lontium LT7911EXC bridge chip.
> > +       The LT7911EXC converts eDP input to single/dual port
> > +       MIPI DSI output.
> > +       Please say Y if you have such hardware.
> > +
> >  config DRM_LONTIUM_LT8912B
> >       tristate "Lontium LT8912B DSI/HDMI bridge"
> >       depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index beab5b695a6e..70ddca75dd3a 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_I2C_NXP_TDA998X) +=3D tda998x.o
> >  obj-$(CONFIG_DRM_INNO_HDMI) +=3D inno-hdmi.o
> >  obj-$(CONFIG_DRM_ITE_IT6263) +=3D ite-it6263.o
> >  obj-$(CONFIG_DRM_ITE_IT6505) +=3D ite-it6505.o
> > +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) +=3D lontium-lt7911exc.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8912B) +=3D lontium-lt8912b.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9211.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/d=
rm/bridge/lontium-lt7911exc.c
> > new file mode 100644
> > index 000000000000..85cb6cedbfa3
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > @@ -0,0 +1,497 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > + */
> > +
> > +#include <linux/crc32.h>
> > +#include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_of.h>
> > +
> > +#define FW_SIZE (64 * 1024)
> > +#define LT_PAGE_SIZE 32
> > +#define FW_FILE  "lt7911exc_fw.bin"
>
> Do you plan to submit the referene image to linux-firmware?
>
I want to submit it, but I don't know how. Please help me.

> > +#define LT7911EXC_PAGE_CONTROL 0xff
> > +
>
> [...]
>
> > +
> > +static void lt7911exc_remove(struct i2c_client *client)
> > +{}
>
> If it's empty, it should be dropped. .remove is an optional callback.
>
it will be fixed in next version.

> > +
> > +static const struct i2c_device_id lt7911exc_i2c_table[] =3D {
> > +     {"lontium, lt7911exc"},
>
> Drop  the "lontium, " part. The I2C ids (unlike OF ids) don't have the
> vendor part.
>
it will be fixed in next version.

> > +     {/* sentinel */}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
> > +
>
> --
> With best wishes
> Dmitry
