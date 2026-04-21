Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E34F327AD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C0910E813;
	Tue, 21 Apr 2026 07:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WmkKsWaM";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EBA10E763
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 03:27:05 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-40946982a78so1235486fac.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 20:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776742025; cv=none;
 d=google.com; s=arc-20240605;
 b=LlnaJf7bpmelAbLNOFOllpHiUFdj0T60OwcZV0wLS+fu78WBUfQe8cMUOMhgfR/C4j
 OeGSpVXMqQ0YMsEkUqc1gcZZYY5UY/i6Llu26o0pgLiYOXDyrYnuwQ+x75AXx36IbHbm
 djzigeisfweookVL7XXro7pQZIG7cpX/eaCLvr8HSmhn2n5KWJmTeu8eWQ3QhF6xd2Of
 2IDUsmpM/v7K6Q99Y4NEmI/IfHAQ6lh2ON/WKOGvLM9NiZpEikocOc0zjwDxnYMaqpJ1
 1mr5KT0Pb5T5rSIum3KWPfbHqmj7Wz6SgXMAgRhYcqO7mxppljtk3clXSuCDzWvzHb9y
 kXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=loQzKyoRfBT+9jhBHfvlNo2lwndoUWQoswn6Xs4gQ3M=;
 fh=ymxjK1OXkpsRkNW6EfE1S9Uem1+1/UD9gOHvC8wJNXg=;
 b=HTQhG1ewYlCZRtYaiQ/XEiYd+h0qJ3NhFC6YySaNR3XRtPhiwYSfvyPWuf8r4AEm+e
 uIpa5CDU3YFsbGA2jNCn8vAWzBXlhQETcat4WK/3OWoHAfajRTukT0aOK5aMscnjiUyj
 fyMZ8koMpxyWUFFIceq37ISPhGV9QSEVoph+J7R/sDwhRbsUo99w66rNnbcofLyXTYEU
 OHDcbGjWdDsKNqnaGVDAxZHoT7dYlUoajtJP+n3omfgXC/jBD181LnWeKIZcxz+ngDh+
 J+wzZvYxrIYCROWJ3vCjSdDaXy/dmWUYbN2m+p5+uxw/QOxyjf2ihT0kJZ6UnKjQ7c3w
 SZHQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776742025; x=1777346825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loQzKyoRfBT+9jhBHfvlNo2lwndoUWQoswn6Xs4gQ3M=;
 b=WmkKsWaM/WIncg22siqpqcinVooBIx9K/QQj2K1PBBLl9nfF9GxTh8Gmry3Ke0BLZ2
 rZJ0MYIQZZILrMKjxX7V0qgx+LU+1oTQCdNuJoDZD804V7vF56mS8TDZ78lvO4vYwbbt
 V5OInqzmMKk+Gobf7mCvtmSuzTCkG8ca446FVx9MkbP2h5rd1dkgzQb83O3geA1hdl8S
 jwmVXMLDSDXNhIeR5Tdcf6rk5WyupMLjaNsHn8TQgXz+B/+Opp9qCar3Lzn3p014iZ4f
 NDqp9OE58ivnymYU04VBAAk738RTos8HY2hMx7s9XEb4YINZxUCA7sv/kpChCHBSETIu
 YjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776742025; x=1777346825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=loQzKyoRfBT+9jhBHfvlNo2lwndoUWQoswn6Xs4gQ3M=;
 b=GGjFf18Newz8gMQoVq2C3Sxrh6l4YU+E2rs5yNtwIfiD5+lHV3uua8P5vJBWpr86WR
 vybZURlnSlfMCeZ0msv5lmgRc/T17U9Y0RU0sZeFo+yX6t0ZKoLW252AXwIFLqf/znxD
 mGSEtrg5rs5hXdQ5oZrZutClVQ81ioOtAfTU1sg0MeJFYw7LH4QUqjELQHHL2BUuqO57
 WLi/M582js+ZvPiiXNpLro+MkxLEUmaN1clEUT4Ipt34bpcayZgu2BYSLuhg/rf+aKFY
 elOg4mG9Ssl7ttT6ZJMpI5ahHFYtQ4XrxToH9/teKej4b9SvG6rIPhuUKOnOvMFE++vD
 hv8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ98kkToaz2olLrW9185amPC+7fp/5V3QYszoA6nJSuWW9ILPyUrgFublMYQjKUAIkvwIJTfXvKJkjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQypC8vmsa3J0xnBJbzKYI05HDqmpErLpnpwGv1Z77I4KSzzgB
 DOUEecojihv1z9r8ZUTIPXebYKdLuilETctZ/fOnw9UuPyEiY3Y4z4WM6D4ZGAQL0tHZPe5UoH8
 vcONmEI7LsVms6Sn4vSUhj+pQhR7AVFU=
X-Gm-Gg: AeBDiesnTeXRfLBHoKjV1Tj2tIlsLjpcqBqA2KnF6KlzQ0Rl6MWdNf7CH/SfMYv3xxt
 HJyEmnH7+tBlEpo1g/g7lrGaul754g1NO3IOtQjzcRp3d6tM5Hhl79bR1f7y+MYBHX6eZvrH4XH
 XHwWhuzffDSS8Z8VZB7eqECYl9Ebz81YhsIwYZ0KKs1GkYkyHQNbhfOqwztjlrcBhKAlmDnkvAn
 iG/p4+Q0Kmi90F73Ocz0k/DV1xZxHWT3+vZl5FIze0Zo6tHJj4kdO9GF8ufEitgNpPhQgM5KyFc
 DUOAHOzlhyds8l75mw==
X-Received: by 2002:a05:6820:2214:b0:694:980c:9610 with SMTP id
 006d021491bc7-694980c9c43mr562340eaf.21.1776742024793; Mon, 20 Apr 2026
 20:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-3-syyang@lontium.com>
 <f9753cfc-bfe1-4256-af35-0f262a4e8b81@q-lab.dev>
In-Reply-To: <f9753cfc-bfe1-4256-af35-0f262a4e8b81@q-lab.dev>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 21 Apr 2026 11:26:50 +0800
X-Gm-Features: AQROBzAP4DuRYq83nbm8VaynHay8MV2X06IJgaL7j8wTUmMjsaUrSLBnvwnSkaA
Message-ID: <CAFQXuNaMsBK51Cj776gaKHCd+0DPMMXhJAaa_uHFBvq4EDwq_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: Add LT7911EXC edp to mipi bridge driver
To: Quentin Freimanis <quentin@q-lab.dev>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org, Laurent.pinchart@ideasonboard.com, 
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de, xmzhu@lontium.com, 
 xbpeng@lontium.com, rlyu@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

Quentin Freimanis <quentin@q-lab.dev> =E4=BA=8E2026=E5=B9=B44=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 13:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-04-19 7:33 p.m., syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > LT7911EXC is a high performance  eDP1.4 to MIPI chip for
> > VR/Display application.
> >
> > -eDP1.4Receiver
> >   1.Support SSC
>
> s/1.Support/1. Supports/
>
it will be fixed  in the next version.

> >   2.Support 1/2/4 lanes
> >   3.Support up to 4K@60HzRGB/YCbCr4:4:48bpc
> >   4.Support lane swap and PN swap
>
> Same for these
>
it will be fixed  in the next version.

> >
> > -MIPI Transmitter
> >   1.CompliantwithD-PHY1.2&DSI1.1&CSI-22.0=EF=BC=9B1 clock lane,
> >     and1/2/3/4 configurable data lanes:2.5Gbpsperdatalane
> >   2.CompliantwithC-PHY1.0&DSI-21.0&CSI-22.0;
> >     1/2/3 configurable data trio=EF=BC=9B2.5Gsps perdatatrio
> >   3.Support1/2configurable ports
> >   4.DSISupport16/20/24-bit YCbCr4:2:2,16/18/24/30-bit RGB
>
> Missing spaces, this is hard to read and needs to be cleaned up
>
it will be fixed  in the next version.

> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> >   drivers/gpu/drm/bridge/Kconfig             |  18 +
> >   drivers/gpu/drm/bridge/Makefile            |   1 +
> >   drivers/gpu/drm/bridge/lontium-lt7911exc.c | 571 ++++++++++++++++++++=
+
> >   3 files changed, 590 insertions(+)
> >   create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index c3209b0f4678..bae8cdaea666 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -202,6 +202,24 @@ config DRM_LONTIUM_LT8713SX
> >         to 3 configurable Type-C/DP1.4/HDMI2.0 outputs
> >         Please say Y if you have such hardware.
> >
> > +config DRM_LONTIUM_LT9611C
> > +     tristate "Lontium LT9611C DSI/HDMI bridge"
> > +     select SND_SOC_HDMI_CODEC if SND_SOC
> > +     depends on OF
> > +     select CRC8
> > +     select FW_LOADER
> > +     select DRM_PANEL_BRIDGE
> > +     select DRM_KMS_HELPER
> > +     select DRM_MIPI_DSI
> > +     select DRM_DISPLAY_HELPER
> > +     select DRM_DISPLAY_HDMI_STATE_HELPER
> > +     select REGMAP_I2C
> > +     help
> > +       Driver for Lontium DSI to HDMI bridge
> > +       chip driver that converts dual DSI and I2S to
> > +       HDMI signals
> > +       Please say Y if you have such hardware.
> > +
> >   config DRM_ITE_IT66121
> >       tristate "ITE IT66121 HDMI bridge"
> >       depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index beab5b695a6e..54b293d1663e 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9211.=
o
> >   obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> >   obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
> >   obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
> > +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) +=3D lontium-lt7911exc.o
> >   obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
> >   obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) +=3D megachips-stdp=
xxxx-ge-b850v3-fw.o
> >   obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) +=3D microchip-lvds.o
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/d=
rm/bridge/lontium-lt7911exc.c
> > new file mode 100644
> > index 000000000000..d1c1d9e073ef
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > @@ -0,0 +1,571 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > + */
> > +
> > +#include <linux/crc32.h>
> > +#include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +#include <drm/drm_of.h>
> > +
> > +#define FW_SIZE (64 * 1024)
> > +#define LT_PAGE_SIZE 32
> > +#define FW_FILE  "LT7911EXC.bin"
>
> Other lontium bridge chips use lowercase and a _fw.bin suffix, such as
> "lt9611uxc_fw.bin". Rename to be consistent
>
it will be fixed  in the next version.

> > +#define LT7911EXC_PAGE_CONTROL 0xff
> > +
> > +struct lt7911exc {
> > +     struct device *dev;
> > +     struct i2c_client *client;
> > +     struct drm_bridge bridge;
> > +     struct drm_bridge *panel_bridge;
> > +     struct regmap *regmap;
> > +     /* Protects all accesses to registers by stopping the on-chip MCU=
 */
> > +     struct mutex ocm_lock;
> > +     struct regulator_bulk_data supplies[2];
> > +
> > +     struct gpio_desc *reset_gpio;
> > +     const struct firmware *fw;
> > +     int fw_version;
> > +     u32 fw_crc;
> > +
> > +     bool enabled;
> > +};
> > +
> > +static const struct regmap_range_cfg lt7911exc_ranges[] =3D {
> > +     {
> > +             .name =3D "register_range",
> > +             .range_min =3D  0,
> > +             .range_max =3D 0xffff,
> > +             .selector_reg =3D LT7911EXC_PAGE_CONTROL,
> > +             .selector_mask =3D 0xff,
> > +             .selector_shift =3D 0,
> > +             .window_start =3D 0,
> > +             .window_len =3D 0x100,
> > +     },
> > +};
> > +
> > +static const struct regmap_config lt7911exc_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D 0xffff,
> > +     .ranges =3D lt7911exc_ranges,
> > +     .num_ranges =3D ARRAY_SIZE(lt7911exc_ranges),
> > +};
> > +
> > +static u32 cal_crc32_custom(const u8 *data, u64 length)
> > +{
> > +     u32 crc =3D 0xffffffff;
> > +     u8 buf[4];
> > +     u64 i;
> > +
> > +     for (i =3D 0; i < length; i +=3D 4) {
> > +             buf[0] =3D data[i + 3];
> > +             buf[1] =3D data[i + 2];
> > +             buf[2] =3D data[i + 1];
> > +             buf[3] =3D data[i + 0];
> > +             crc =3D crc32_be(crc, buf, 4);
> > +             }
> > +
> > +     return crc;
> > +}
> > +
> > +static inline struct lt7911exc *
> > +             bridge_to_lt7911exc(struct drm_bridge *bridge)
> > +{
> > +     return container_of(bridge, struct lt7911exc, bridge);
> > +}
> > +
> > +static int lt7911exc_regulator_enable(struct lt7911exc *lt7911exc)
> > +{
> > +     int ret;
> > +
> > +     ret =3D regulator_enable(lt7911exc->supplies[0].consumer);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     usleep_range(5000, 10000);
> > +
> > +     ret =3D regulator_enable(lt7911exc->supplies[1].consumer);
> > +     if (ret < 0) {
> > +             regulator_disable(lt7911exc->supplies[0].consumer);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt7911exc_regulator_disable(struct lt7911exc *lt7911exc)
> > +{
> > +     int ret;
> > +
> > +     ret =3D regulator_disable(lt7911exc->supplies[1].consumer);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D regulator_disable(lt7911exc->supplies[0].consumer);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static void lt7911exc_reset(struct lt7911exc *lt7911exc)
> > +{
> > +     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> > +     msleep(20);
> > +
> > +     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> > +     msleep(20);
> > +
> > +     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> > +     msleep(400);
> > +
> > +     dev_dbg(lt7911exc->dev, "lt7911exc reset");
>
> missing newline in dev_dbg(), all other calls have it.
>
it will be fixed  in the next version.
dev_dbg(lt7911exc->dev, "lt7911exc reset\n");

> > +}
> > +
> > +static int lt7911exc_parse_dt(struct lt7911exc *lt7911exc)
> > +{
> > +     int ret;
> > +
> > +     lt7911exc->supplies[0].supply =3D "vcc";
> > +     lt7911exc->supplies[1].supply =3D "vdd";
> > +
> > +     ret =3D devm_regulator_bulk_get(lt7911exc->dev, 2, lt7911exc->sup=
plies);
> > +     if (ret) {
> > +             dev_err(lt7911exc->dev, "failed get regulator\n");
> > +             return ret;
> > +     }
> > +
> > +     lt7911exc->reset_gpio =3D devm_gpiod_get(lt7911exc->dev, "reset",=
 GPIOD_OUT_LOW);
> > +     if (IS_ERR(lt7911exc->reset_gpio)) {
> > +             dev_err(lt7911exc->dev, "failed to acquire reset gpio\n")=
;
> > +             return PTR_ERR(lt7911exc->reset_gpio);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt7911exc_read_version(struct lt7911exc *lt7911exc)
> > +{
> > +     u8 buf[2];
> > +     int ret;
> > +
> > +     ret =3D regmap_bulk_read(lt7911exc->regmap, 0xe081, buf, 3);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return (buf[0] << 16) | (buf[1] << 8) | buf[2];
> > +}
> > +
> > +static void lt7911exc_lock(struct lt7911exc *lt7911exc)
> > +{
> > +     mutex_lock(&lt7911exc->ocm_lock);
> > +     regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
> > +}
> > +
> > +static void lt7911exc_unlock(struct lt7911exc *lt7911exc)
> > +{
> > +     regmap_write(lt7911exc->regmap, 0xe0ee, 0x00);
> > +     mutex_unlock(&lt7911exc->ocm_lock);
> > +}
> > +
> > +static int lt7911exc_prepare_firmware_data(struct lt7911exc *lt7911exc=
)
> > +{
> > +     struct device *dev =3D lt7911exc->dev;
> > +     int ret;
> > +     u8 *buffer;
> > +     size_t total_size =3D FW_SIZE - 4;
> > +
> > +     ret =3D request_firmware(&lt7911exc->fw, FW_FILE, dev);
> > +     if (ret) {
> > +             dev_err(dev, "failed load file '%s', error type %d\n", FW=
_FILE, ret);
> > +             return ret;
> > +     }
> > +
> > +     if (lt7911exc->fw->size > total_size) {
> > +             dev_err(dev, "firmware too large (%zu > %zu)\n", lt7911ex=
c->fw->size, total_size);
> > +             release_firmware(lt7911exc->fw);
> > +             lt7911exc->fw =3D NULL;
> > +             return -EINVAL;
> > +     }
> > +
> > +     dev_dbg(dev, "firmware size: %zu bytes\n", lt7911exc->fw->size);
> > +
> > +     buffer =3D kzalloc(total_size, GFP_KERNEL);
> > +     if (!buffer) {
> > +             release_firmware(lt7911exc->fw);
> > +             lt7911exc->fw =3D NULL;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     memset(buffer, 0xff, total_size);
> > +     memcpy(buffer, lt7911exc->fw->data, lt7911exc->fw->size);
> > +
> > +     lt7911exc->fw_crc =3D cal_crc32_custom(buffer, total_size);
> > +     dev_dbg(dev, "firmware crc: 0x%08x\n", lt7911exc->fw_crc);
> > +
> > +     kfree(buffer);
> > +     return 0;
> > +}
> > +
> > +static void lt7911exc_block_erase(struct lt7911exc *lt7911exc)
> > +{
> > +     struct device *dev =3D lt7911exc->dev;
> > +     const u32 addr =3D 0x00;
> > +
> > +     const struct reg_sequence seq_write[] =3D {
> > +             REG_SEQ0(0xe0ee, 0x01),
> > +             REG_SEQ0(0xe054, 0x01),
> > +             REG_SEQ0(0xe055, 0x06),
> > +             REG_SEQ0(0xe051, 0x01),
> > +             REG_SEQ0(0xe051, 0x00),
> > +             REG_SEQ0(0xe054, 0x05),
> > +             REG_SEQ0(0xe055, 0xd8),
> > +             REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
> > +             REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
> > +             REG_SEQ0(0xe05c, addr & 0xff),
> > +             REG_SEQ0(0xe051, 0x01),
> > +             REG_SEQ0(0xe050, 0x00),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE(s=
eq_write));
> > +
> > +     msleep(200);
> > +     dev_dbg(dev, "erase flash done.\n");
> > +}
> > +
> > +static void lt7911exc_prog_init(struct lt7911exc *lt7911exc, u64 addr)
> > +{
> > +     const struct reg_sequence seq_write[] =3D {
> > +             REG_SEQ0(0xe0ee, 0x01),
> > +             REG_SEQ0(0xe05f, 0x01),
> > +             REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
> > +             REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
> > +             REG_SEQ0(0xe05c, addr & 0xff),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE(s=
eq_write));
> > +}
> > +
> > +static int lt7911exc_write_data(struct lt7911exc *lt7911exc, u64 addr)
> > +{
> > +     struct device *dev =3D lt7911exc->dev;
> > +     int ret;
> > +     int page =3D 0, num =3D 0, page_len =3D 0;
> > +     u64 size, offset;
> > +     const u8 *data;
> > +
> > +     data =3D lt7911exc->fw->data;
> > +     size =3D lt7911exc->fw->size;
> > +     page =3D (size + LT_PAGE_SIZE - 1) / LT_PAGE_SIZE;
> > +     if (page * LT_PAGE_SIZE > FW_SIZE) {
> > +             dev_err(dev, "firmware size out of range\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     dev_dbg(dev, "%u pages, total size %llu byte\n", page, size);
> > +
> > +     for (num =3D 0; num < page; num++) {
> > +             offset =3D num * LT_PAGE_SIZE;
> > +             page_len =3D (offset + LT_PAGE_SIZE <=3D size) ? LT_PAGE_=
SIZE : (size - offset);
> > +             lt7911exc_prog_init(lt7911exc, addr);
> > +
> > +             ret =3D regmap_raw_write(lt7911exc->regmap, 0xe05d, &data=
[offset], page_len);
> > +             if (ret) {
> > +                     dev_err(dev, "write error at page %d\n", num);
> > +                     return ret;
> > +             }
> > +
> > +             if (page_len < LT_PAGE_SIZE) {
> > +                     regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
> > +                     regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> > +                     //hardware requires delay
> > +                     usleep_range(1000, 2000);
> > +             }
> > +
> > +             regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
> > +             addr +=3D LT_PAGE_SIZE;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt7911exc_write_crc(struct lt7911exc *lt7911exc, u64 addr)
> > +{
> > +     u8 crc[4];
> > +     int ret;
> > +
> > +     crc[0] =3D lt7911exc->fw_crc & 0xff;
> > +     crc[1] =3D (lt7911exc->fw_crc >> 8) & 0xff;
> > +     crc[2] =3D (lt7911exc->fw_crc >> 16) & 0xff;
> > +     crc[3] =3D (lt7911exc->fw_crc >> 24) & 0xff;
> > +
> > +     regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> > +     regmap_write(lt7911exc->regmap, 0xe05a, (addr >> 16) & 0xff);
> > +     regmap_write(lt7911exc->regmap, 0xe05b, (addr >> 8) & 0xff);
> > +     regmap_write(lt7911exc->regmap, 0xe05c, addr & 0xff);
> > +
> > +     ret =3D regmap_raw_write(lt7911exc->regmap, 0xe05d, crc, 4);
> > +     if (ret)
> > +             return ret;
>
> nit: Newline here makes it more readable
>
it will be fixed  in the next version.

> > +     regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
> > +     regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> > +     usleep_range(1000, 2000);
> > +     regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt7911exc_firmware_upgrade(struct lt7911exc *lt7911exc)
> > +{
> > +     struct device *dev =3D lt7911exc->dev;
> > +     int ret;
> > +
> > +     ret =3D lt7911exc_prepare_firmware_data(lt7911exc);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     dev_dbg(dev, "starting firmware upgrade, size: %zu bytes\n", lt79=
11exc->fw->size);
> > +
> > +     lt7911exc_block_erase(lt7911exc);
> > +
> > +     ret =3D lt7911exc_write_data(lt7911exc, 0);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write firmware data\n");
> > +             return ret;
> > +     }
> > +
> > +     release_firmware(lt7911exc->fw);
> > +     lt7911exc->fw =3D NULL;
> > +
> > +     ret =3D lt7911exc_write_crc(lt7911exc, FW_SIZE - 4);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write firmware crc\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt7911exc_upgrade_result(struct lt7911exc *lt7911exc)
> > +{
> > +     struct device *dev =3D lt7911exc->dev;
> > +     u32 read_hw_crc =3D 0;
> > +     u8 crc_tmp[4];
> > +     int ret;
> > +
> > +     regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
> > +     regmap_write(lt7911exc->regmap, 0xe07b, 0x60);
> > +     regmap_write(lt7911exc->regmap, 0xe07b, 0x40);
> > +     msleep(150);
> > +     ret =3D regmap_bulk_read(lt7911exc->regmap, 0x22, crc_tmp, 4);
> > +     if (ret) {
> > +             dev_err(lt7911exc->dev, "Failed to read CRC: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     read_hw_crc =3D crc_tmp[0] << 24 | crc_tmp[1] << 16 |
> > +                             crc_tmp[2] << 8 | crc_tmp[3];
> > +
> > +     if (read_hw_crc !=3D lt7911exc->fw_crc) {
> > +             dev_err(dev, "lt7911exc firmware upgrade failed, expected=
 CRC=3D0x%08x, read CRC=3D0x%08x\n",
> > +                     lt7911exc->fw_crc, read_hw_crc);
> > +             return -EIO;
> > +     }
> > +
> > +     dev_dbg(dev, "lt7911exc firmware upgrade success, CRC=3D0x%08x\n"=
, read_hw_crc);
> > +     return 0;
> > +}
> > +
> > +static void lt7911exc_pre_enable(struct drm_bridge *bridge)
> > +{
> > +     struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +     int ret;
> > +
> > +     if (lt7911exc->enabled)
> > +             return;
> > +
> > +     ret =3D lt7911exc_regulator_enable(lt7911exc);
> > +     if (ret)
> > +             return;
> > +
> > +     lt7911exc_reset(lt7911exc);
> > +
> > +     lt7911exc->enabled =3D true;
> > +}
> > +
> > +static void lt7911exc_disable(struct drm_bridge *bridge)
> > +{
> > +     /* Delay after panel is disabled */
> > +     msleep(20);
> > +}
> > +
> > +static void lt7911exc_post_disable(struct drm_bridge *bridge)
> > +{
> > +     struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +     int ret;
> > +
> > +     if (!lt7911exc->enabled)
> > +             return;
> > +
> > +     lt7911exc->enabled =3D false;
> > +
> > +     ret =3D lt7911exc_regulator_disable(lt7911exc);
> > +     if (ret)
> > +             return;
> > +
> > +     gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> > +}
> > +
> > +static int lt7911exc_attach(struct drm_bridge *bridge,
> > +                         struct drm_encoder *encoder,
> > +                         enum drm_bridge_attach_flags flags)
> > +{
> > +     struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +
> > +     return drm_bridge_attach(lt7911exc->bridge.encoder, lt7911exc->pa=
nel_bridge,
> > +                              &lt7911exc->bridge, flags);
> > +}
> > +
> > +static const struct drm_bridge_funcs lt7911exc_bridge_funcs =3D {
> > +     .pre_enable =3D lt7911exc_pre_enable,
> > +     .disable =3D lt7911exc_disable,
> > +     .post_disable =3D lt7911exc_post_disable,
>
> These are all deprecated, is there any reason to use them and not the
> atomic_* callbacks?
>
it will be fixed  in the next version.

> > +     .attach =3D lt7911exc_attach,
> > +};
> > +
> > +static int lt7911exc_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct lt7911exc *lt7911exc;
> > +     struct drm_bridge *panel_bridge;
> > +     bool fw_updated =3D false;
> > +     int ret;
> > +
> > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > +             dev_err(dev, "device doesn't support I2C\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     lt7911exc =3D devm_drm_bridge_alloc(dev, struct lt7911exc, bridge=
,
> > +                                       &lt7911exc_bridge_funcs);
> > +     if (IS_ERR(lt7911exc))
> > +             return PTR_ERR(lt7911exc);
> > +
> > +     panel_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
> > +     if (IS_ERR(panel_bridge))
> > +             return PTR_ERR(panel_bridge);
> > +
> > +     lt7911exc->panel_bridge =3D panel_bridge;
> > +     lt7911exc->client =3D client;
> > +     lt7911exc->dev =3D dev;
> > +     i2c_set_clientdata(client, lt7911exc);
> > +     mutex_init(&lt7911exc->ocm_lock);
> > +
> > +     lt7911exc->regmap =3D devm_regmap_init_i2c(client, &lt7911exc_reg=
map_config);
> > +     if (IS_ERR(lt7911exc->regmap)) {
> > +             dev_err(dev, "regmap i2c init failed\n");
> > +             return PTR_ERR(lt7911exc->regmap);
> > +     }
> > +
> > +     ret =3D lt7911exc_parse_dt(lt7911exc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D lt7911exc_regulator_enable(lt7911exc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     lt7911exc_reset(lt7911exc);
> > +     lt7911exc->enabled =3D true;
> > +     lt7911exc_lock(lt7911exc);
> > +
> > +retry:
> > +     lt7911exc->fw_version =3D lt7911exc_read_version(lt7911exc);
> > +     if (lt7911exc->fw_version < 0) {
> > +             dev_err(dev, "failed to read FW version\n");
> > +             lt7911exc_unlock(lt7911exc);
> > +             goto err_disable_regulators;
> > +
> > +     } else if (lt7911exc->fw_version =3D=3D 0) {
> > +             if (!fw_updated) {
> > +                     fw_updated =3D true;
> > +                     ret =3D lt7911exc_firmware_upgrade(lt7911exc);
> > +                     if (ret < 0) {
> > +                             lt7911exc_unlock(lt7911exc);
> > +                             goto err_disable_regulators;
> > +                     }
> > +
> > +                     lt7911exc_reset(lt7911exc);
> > +
> > +                     ret =3D lt7911exc_upgrade_result(lt7911exc);
> > +                     if (ret < 0) {
> > +                             lt7911exc_unlock(lt7911exc);
> > +                             goto err_disable_regulators;
> > +                     }
> > +
> > +                     goto retry;
> > +
> > +             } else {
> > +                     dev_err(dev, "fw version 0x%04x, update failed\n"=
, lt7911exc->fw_version);
> > +                     ret =3D -EOPNOTSUPP;
> > +                     lt7911exc_unlock(lt7911exc);
> > +                     goto err_disable_regulators;
> > +             }
> > +     }
> > +
> > +     lt7911exc_unlock(lt7911exc);
> > +
> > +     lt7911exc->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
> > +     lt7911exc->bridge.of_node =3D dev->of_node;
> > +     drm_bridge_add(&lt7911exc->bridge);
> > +
> > +     return 0;
> > +
> > +err_disable_regulators:
> > +     regulator_bulk_disable(ARRAY_SIZE(lt7911exc->supplies), lt7911exc=
->supplies);
> > +     if (lt7911exc->fw) {
> > +             release_firmware(lt7911exc->fw);
> > +             lt7911exc->fw =3D NULL;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static void lt7911exc_remove(struct i2c_client *client)
> > +{
> > +     struct lt7911exc *lt7911exc =3D i2c_get_clientdata(client);
> > +
> > +     drm_bridge_remove(&lt7911exc->bridge);
> > +     mutex_destroy(&lt7911exc->ocm_lock);
> > +}
> > +
> > +static const struct i2c_device_id lt7911exc_i2c_table[] =3D {
> > +     {"lontium, lt7911exc", 0},
>
> Extra space here in the device id
>
  it will be fixed  in the next version.   {"lontium, lt7911exc"},

> > +     { /* sentinel */ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
> > +
> > +static const struct of_device_id lt7911exc_devices[] =3D {
> > +     {.compatible =3D "lontium,lt7911exc",},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, lt7911exc_devices);
> > +
> > +static struct i2c_driver lt7911exc_driver =3D {
> > +     .id_table       =3D lt7911exc_i2c_table,
> > +     .probe          =3D lt7911exc_probe,
> > +     .remove         =3D lt7911exc_remove,
> > +     .driver         =3D {
> > +             .name   =3D "lt7911exc",
> > +             .of_match_table =3D lt7911exc_devices,
> > +     },
> > +};
> > +module_i2c_driver(lt7911exc_driver);
> > +
> > +MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
> > +MODULE_DESCRIPTION("Lontium lt7911exc edp to mipi dsi bridge driver");
> > +MODULE_LICENSE("GPL v2");
>
