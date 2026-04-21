Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D0AF327AD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F255210EB61;
	Tue, 21 Apr 2026 07:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RHreKemV";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940C510E758
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 03:13:43 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7dc9af41f6fso2762825a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 20:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776741223; cv=none;
 d=google.com; s=arc-20240605;
 b=b8ReiC/9FpPj2cXMx+46GQURzkuMx3OnLPCpBmZ4DIeIUIqYdvNIeIVi2fHBRkUNnI
 Bn07ofnyrYSX1FSwB6X+Mc5XYsSgyllWkthIKTaR/YcOc7C80K/zv8T5NXFzTrf0V0BT
 ljZ9cPzwG6HwcLV8cl+xV+BfEiB4Z7/SYZWC+j/pe7KPRnuF6a23Eq0ilflidmR9bhuW
 f8NF4MFL5VYsu7cgOkotsz8giIkRyKeQpGE452OHJbkoWajqsYefD9AcnUJbPceLE+e4
 zj+ebuxF2KcFbpXgJCgKDMsVRlbIc9md8fViw1sTHyX/QxUNvJNLqaF7hZog0PWyR+G3
 6maA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rrtkUSWZIy95P/iJa/uQqRRJd2duk6lAzuzBS8qGhmU=;
 fh=x0VKpWOcaRfLINStFXXTsnj5u54gj0A7JHNSjnlHtkA=;
 b=drRBvQnHE1CIoLisuVjrMtySfcmxjfrxWhwfokVrPiPL4+ur/v6CBWptP3z+4lvyTz
 LrXiViJuEptHKHt/48fNX4Hp0uhgdGXqopx/4zZFoUFkDs8q91F7GSQT7E/5sUA7jHQ/
 xvOEwclWJiXbOBv1Mh40YZMRD705GiY63RLr6V9Zs2PW5ho2e4fHRdMcAe6E01Sw24wH
 gPlnFTVpHgrsJDD214VYW4RrsLEO9rn62gJwQy9ndEP/8fOuKza9sQTOJp5frpFyNh0S
 UqNipRcFhmmrZdmHKwKS7YZs7l+INcfCM6Zo8DpF4T5isGewba99K+m7nLX6jLasHQZh
 CuyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776741223; x=1777346023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrtkUSWZIy95P/iJa/uQqRRJd2duk6lAzuzBS8qGhmU=;
 b=RHreKemVEf+8S7wyXy6E+gK/nYMbMacXyJZOX9f5LurPtJWY5PzAy0QLr9+hWcbhEx
 N86adZyMEEp7wDLwuxJWCEe0dadR1zFshgI3z8rjKffiYj10AE2g5nEPlscIj2t9yxUd
 n3Vwkror+GvDeFGvDXYgCL3nsgso2hbdE5PVTlVNzmasMDiYOB3VGtrAnxh7tqjxvLtx
 Ad+LzFopOWouMx0gR6QIenJRJHgkhla1bX069c6owfwZcPMOGw3HX6xaLHcWRowsASd8
 vpuBie9OmnqIzRmT4jHLBdTHjP2a4hcaedRfS+fxNCz59JGe2D5gZw6iInjS6EQEcW8l
 4slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776741223; x=1777346023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrtkUSWZIy95P/iJa/uQqRRJd2duk6lAzuzBS8qGhmU=;
 b=Ig1jfi7634JjQCr7QPwI2EfTHGGGn3um7zmGCrl/CRWCoY1j2Om7Iu87IT/rkjpnEk
 4m1AYCQNQpg9Jk8oItwjvKlM07TABq7SxPqCpxlEfGyy13CxcjDXVRtAQKk9ZQIMMecD
 lEYIttCpm0uymvt3dfcfI1sgFg9YqrNchhFz9ijtGl15JAYXtnU99FiytuHZ18qADTfR
 unxCzSXb7gIqoSm33KAc7SHp73loMlR6uERxcDb4Y53/k5FFvwl/DRRbTkaz2tHfdchc
 9h4FAh8YJAZfVm+DvGnib7qNOr+kDO21ya9Nz5t+yaZvVoxwYaSGFpSyi1vHYxtiZ8yw
 uZUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Gy+O6wizR4NGiGBegwpqvVTBw1extjxe+xJWLpHQcDmZzbshrf5ydWcfU7qnFXObNTqCVYAX8Zq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9nN5NimQrpUAnp7dF0ZjWZtVvTIpNav3d5UZcC8wfVjtUPvPz
 FfA5d/4V3epv4LWcUX2kfkzIIKarqoS3EwpOjEnqRYt17iuwCP5sbu0Y2OIZSqyIPcGStSJPsxl
 veCghxavioZ2SAkR3ZVEUQ7GrNe68QWE=
X-Gm-Gg: AeBDietJWq+7Zv6+CNzoP4j1KqThj98K11vhyp3kgyPBeoNR2tO7bmZ4jzBZJdh4WQn
 BfNABlEf9oKT1LnzwM1vIAasPwOEoNf9wVeCdFqOFAPJeW7tRhDcf3bB6MEBtHP2KY9dQR2eD39
 xNoRZbyHxsA3bbTBGcvfmLAIgq9E92247ekR5a/1mJ+lS0E6N+c9wvKnL/KjwKwyJst+QBAJu9M
 XkIyN65J/zlXZ4FO1ejG24+/XXTtbXoLzrYTytOpTVhDcIa0j1QoklnhHqdIo0EWdzpPDbRt88u
 kzUjZ+gMXYuoe9XkXQ==
X-Received: by 2002:a05:6820:220a:b0:692:65c1:f900 with SMTP id
 006d021491bc7-69462eb9901mr9345959eaf.32.1776741222523; Mon, 20 Apr 2026
 20:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-3-syyang@lontium.com>
 <CAO9ioeXDfTdETEBQknoLehk2aiabCgse109sDgJoPHuQ_07nKQ@mail.gmail.com>
In-Reply-To: <CAO9ioeXDfTdETEBQknoLehk2aiabCgse109sDgJoPHuQ_07nKQ@mail.gmail.com>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 21 Apr 2026 11:13:30 +0800
X-Gm-Features: AQROBzDubCMpTO50rRvRbbLXHdSpGyAunexa6REJJan6AKcl9aKnTCxMthrRCWs
Message-ID: <CAFQXuNYV+wt2-+8R4m+mtby9TBwcX+vGdqvUvb_6wXkkBg6b=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: Add LT7911EXC edp to mipi bridge driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 tzimmermann@suse.de, xbpeng@lontium.com, rlyu@lontium.com, xmzhu@lontium.com
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
4=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 11:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> >
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > LT7911EXC is a high performance  eDP1.4 to MIPI chip for
>
> MIPI what?
>
MIPI DSI,
It will be modified in the next version.

> > VR/Display application.
> >
> > -eDP1.4Receiver
> >  1.Support SSC
> >  2.Support 1/2/4 lanes
> >  3.Support up to 4K@60HzRGB/YCbCr4:4:48bpc
> >  4.Support lane swap and PN swap
> >
> > -MIPI Transmitter
> >  1.CompliantwithD-PHY1.2&DSI1.1&CSI-22.0=EF=BC=9B1 clock lane,
> >    and1/2/3/4 configurable data lanes:2.5Gbpsperdatalane
> >  2.CompliantwithC-PHY1.0&DSI-21.0&CSI-22.0;
> >    1/2/3 configurable data trio=EF=BC=9B2.5Gsps perdatatrio
> >  3.Support1/2configurable ports
> >  4.DSISupport16/20/24-bit YCbCr4:2:2,16/18/24/30-bit RGB
> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig             |  18 +
> >  drivers/gpu/drm/bridge/Makefile            |   1 +
> >  drivers/gpu/drm/bridge/lontium-lt7911exc.c | 571 +++++++++++++++++++++
> >  3 files changed, 590 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index c3209b0f4678..bae8cdaea666 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -202,6 +202,24 @@ config DRM_LONTIUM_LT8713SX
> >           to 3 configurable Type-C/DP1.4/HDMI2.0 outputs
> >           Please say Y if you have such hardware.
> >
> > +config DRM_LONTIUM_LT9611C
>
> I thought the patch is for LT7911EXC
>
Yes, it is LT7911EXC, It will be modified in the next version.

> > +       tristate "Lontium LT9611C DSI/HDMI bridge"
> > +       select SND_SOC_HDMI_CODEC if SND_SOC
> > +       depends on OF
> > +       select CRC8
> > +       select FW_LOADER
> > +       select DRM_PANEL_BRIDGE
> > +       select DRM_KMS_HELPER
> > +       select DRM_MIPI_DSI
> > +       select DRM_DISPLAY_HELPER
> > +       select DRM_DISPLAY_HDMI_STATE_HELPER
> > +       select REGMAP_I2C
> > +       help
> > +         Driver for Lontium DSI to HDMI bridge
> > +         chip driver that converts dual DSI and I2S to
> > +         HDMI signals
> > +         Please say Y if you have such hardware.
> > +
> >  config DRM_ITE_IT66121
> >         tristate "ITE IT66121 HDMI bridge"
> >         depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index beab5b695a6e..54b293d1663e 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9211.=
o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
> > +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) +=3D lontium-lt7911exc.o
>
> Keep the list sorted, please.
>
Where can I see the sorting rules? Please guide me.
it is:
obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) +=3D lontium-lt7911exc.o
obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
?

> >  obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
> >  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) +=3D megachips-stdpx=
xxx-ge-b850v3-fw.o
> >  obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) +=3D microchip-lvds.o
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
>
> I think you use more than that.
>
It will be modified in the next version.

> > +#include <drm/drm_of.h>
> > +
> > +#define FW_SIZE (64 * 1024)
> > +#define LT_PAGE_SIZE 32
> > +#define FW_FILE  "LT7911EXC.bin"
> > +#define LT7911EXC_PAGE_CONTROL 0xff
> > +
> > +struct lt7911exc {
> > +       struct device *dev;
> > +       struct i2c_client *client;
> > +       struct drm_bridge bridge;
> > +       struct drm_bridge *panel_bridge;
>
> Use next_bridge from struct drm_bridge instead.
>
It will be modified in the next version.

> > +       struct regmap *regmap;
> > +       /* Protects all accesses to registers by stopping the on-chip M=
CU */
> > +       struct mutex ocm_lock;
> > +       struct regulator_bulk_data supplies[2];
> > +
> > +       struct gpio_desc *reset_gpio;
> > +       const struct firmware *fw;
>
> Do you need to store it during the runtime? If not, please remove from
> the data struct.
>
Don't need  store during the runtime.
Can I use the global variable 'fw'?
Because I need use 'fw' to calculate the CRC32 and burn the firmware.

> > +       int fw_version;
> > +       u32 fw_crc;
> > +
> > +       bool enabled;
>
> What for?
>
(bool enabled;) is used as a flag in the code to reduce the frequency
of power supply switching.
Of course, it can also be removed in the next version.

> > +};
> > +
> > +static const struct regmap_range_cfg lt7911exc_ranges[] =3D {
> > +       {
> > +               .name =3D "register_range",
> > +               .range_min =3D  0,
> > +               .range_max =3D 0xffff,
>
> Is it an actual range?
>
0xe8ff is actual  range.

> > +               .selector_reg =3D LT7911EXC_PAGE_CONTROL,
> > +               .selector_mask =3D 0xff,
> > +               .selector_shift =3D 0,
> > +               .window_start =3D 0,
> > +               .window_len =3D 0x100,
> > +       },
> > +};
> > +
> > +static const struct regmap_config lt7911exc_regmap_config =3D {
> > +       .reg_bits =3D 8,
> > +       .val_bits =3D 8,
> > +       .max_register =3D 0xffff,
> > +       .ranges =3D lt7911exc_ranges,
> > +       .num_ranges =3D ARRAY_SIZE(lt7911exc_ranges),
> > +};
> > +
> > +static u32 cal_crc32_custom(const u8 *data, u64 length)
> > +{
> > +       u32 crc =3D 0xffffffff;
> > +       u8 buf[4];
> > +       u64 i;
> > +
> > +       for (i =3D 0; i < length; i +=3D 4) {
> > +               buf[0] =3D data[i + 3];
> > +               buf[1] =3D data[i + 2];
> > +               buf[2] =3D data[i + 1];
> > +               buf[3] =3D data[i + 0];
> > +               crc =3D crc32_be(crc, buf, 4);
>
> How is it different from crc32_le()?
>
The implementation differs from crc32_le() in both byte ordering and
processing granularity.
This function performs a 32-bit word-wise byte swap (little-endian to
big-endian) before feeding data into crc32_be(), while crc32_le()
processes the input stream directly in little-endian order without
transformation.
Therefore, the result is not equivalent to crc32_le(), and is required
to match the firmware's expected big-endian word-based CRC format.

> > +               }
>
> Wrong alignment.
>
it will be fixed in the next version
> > +
> > +       return crc;
> > +}
> > +
> > +static inline struct lt7911exc *
> > +               bridge_to_lt7911exc(struct drm_bridge *bridge)
>
> One line, please.
>
it will be fixed in the next version

> > +{
> > +       return container_of(bridge, struct lt7911exc, bridge);
> > +}
> > +
> > +static int lt7911exc_regulator_enable(struct lt7911exc *lt7911exc)
> > +{
> > +       int ret;
> > +
> > +       ret =3D regulator_enable(lt7911exc->supplies[0].consumer);
>
> If you are not using bulk interface here, why did you declare supplies as=
 bulks?
>
it will be fixed in the next version

> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       usleep_range(5000, 10000);
> > +
> > +       ret =3D regulator_enable(lt7911exc->supplies[1].consumer);
> > +       if (ret < 0) {
> > +               regulator_disable(lt7911exc->supplies[0].consumer);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int lt7911exc_regulator_disable(struct lt7911exc *lt7911exc)
> > +{
> > +       int ret;
> > +
> > +       ret =3D regulator_disable(lt7911exc->supplies[1].consumer);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret =3D regulator_disable(lt7911exc->supplies[0].consumer);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +static void lt7911exc_reset(struct lt7911exc *lt7911exc)
> > +{
> > +       gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> > +       msleep(20);
> > +
> > +       gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> > +       msleep(20);
> > +
> > +       gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
>
> Yep, it's active low. Invert polarities here.
>
gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
msleep(20);
gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
msleep(20);
gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);

next version, fixed.

> > +       msleep(400);
> > +
> > +       dev_dbg(lt7911exc->dev, "lt7911exc reset");
> > +}
> > +
> > +static int lt7911exc_parse_dt(struct lt7911exc *lt7911exc)
> > +{
> > +       int ret;
> > +
> > +       lt7911exc->supplies[0].supply =3D "vcc";
> > +       lt7911exc->supplies[1].supply =3D "vdd";
> > +
> > +       ret =3D devm_regulator_bulk_get(lt7911exc->dev, 2, lt7911exc->s=
upplies);
> > +       if (ret) {
> > +               dev_err(lt7911exc->dev, "failed get regulator\n");
> > +               return ret;
>
> return dev_err_probe();
>
it will be fixed in the next version
> > +       }
> > +
> > +       lt7911exc->reset_gpio =3D devm_gpiod_get(lt7911exc->dev, "reset=
", GPIOD_OUT_LOW);
> > +       if (IS_ERR(lt7911exc->reset_gpio)) {
> > +               dev_err(lt7911exc->dev, "failed to acquire reset gpio\n=
");
>
> return dev_err_probe();
>
it will be fixed in the next version

> > +               return PTR_ERR(lt7911exc->reset_gpio);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int lt7911exc_read_version(struct lt7911exc *lt7911exc)
> > +{
> > +       u8 buf[2];
> > +       int ret;
> > +
> > +       ret =3D regmap_bulk_read(lt7911exc->regmap, 0xe081, buf, 3);
>
> Do you see a buffer overflow here?
>
sorry, it will be fixed in the next version

> > +       if (ret)
> > +               return ret;
> > +
> > +       return (buf[0] << 16) | (buf[1] << 8) | buf[2];
> > +}
> > +
> > +static void lt7911exc_lock(struct lt7911exc *lt7911exc)
> > +{
> > +       mutex_lock(&lt7911exc->ocm_lock);
> > +       regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
> > +}
> > +
> > +static void lt7911exc_unlock(struct lt7911exc *lt7911exc)
> > +{
> > +       regmap_write(lt7911exc->regmap, 0xe0ee, 0x00);
> > +       mutex_unlock(&lt7911exc->ocm_lock);
> > +}
> > +
> > +static int lt7911exc_prepare_firmware_data(struct lt7911exc *lt7911exc=
)
> > +{
> > +       struct device *dev =3D lt7911exc->dev;
> > +       int ret;
> > +       u8 *buffer;
> > +       size_t total_size =3D FW_SIZE - 4;
> > +
> > +       ret =3D request_firmware(&lt7911exc->fw, FW_FILE, dev);
> > +       if (ret) {
> > +               dev_err(dev, "failed load file '%s', error type %d\n", =
FW_FILE, ret);
> > +               return ret;
> > +       }
> > +
> > +       if (lt7911exc->fw->size > total_size) {
> > +               dev_err(dev, "firmware too large (%zu > %zu)\n", lt7911=
exc->fw->size, total_size);
> > +               release_firmware(lt7911exc->fw);
> > +               lt7911exc->fw =3D NULL;
> > +               return -EINVAL;
> > +       }
> > +
> > +       dev_dbg(dev, "firmware size: %zu bytes\n", lt7911exc->fw->size)=
;
> > +
> > +       buffer =3D kzalloc(total_size, GFP_KERNEL);
> > +       if (!buffer) {
> > +               release_firmware(lt7911exc->fw);
> > +               lt7911exc->fw =3D NULL;
> > +               return -ENOMEM;
> > +       }
> > +
> > +       memset(buffer, 0xff, total_size);
> > +       memcpy(buffer, lt7911exc->fw->data, lt7911exc->fw->size);
> > +
> > +       lt7911exc->fw_crc =3D cal_crc32_custom(buffer, total_size);
> > +       dev_dbg(dev, "firmware crc: 0x%08x\n", lt7911exc->fw_crc);
> > +
> > +       kfree(buffer);
> > +       return 0;
> > +}
> > +
> > +static void lt7911exc_block_erase(struct lt7911exc *lt7911exc)
> > +{
> > +       struct device *dev =3D lt7911exc->dev;
> > +       const u32 addr =3D 0x00;
> > +
> > +       const struct reg_sequence seq_write[] =3D {
> > +               REG_SEQ0(0xe0ee, 0x01),
> > +               REG_SEQ0(0xe054, 0x01),
> > +               REG_SEQ0(0xe055, 0x06),
> > +               REG_SEQ0(0xe051, 0x01),
> > +               REG_SEQ0(0xe051, 0x00),
> > +               REG_SEQ0(0xe054, 0x05),
> > +               REG_SEQ0(0xe055, 0xd8),
> > +               REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
> > +               REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
> > +               REG_SEQ0(0xe05c, addr & 0xff),
> > +               REG_SEQ0(0xe051, 0x01),
> > +               REG_SEQ0(0xe050, 0x00),
> > +       };
> > +
> > +       regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE=
(seq_write));
> > +
> > +       msleep(200);
> > +       dev_dbg(dev, "erase flash done.\n");
> > +}
> > +
> > +static void lt7911exc_prog_init(struct lt7911exc *lt7911exc, u64 addr)
> > +{
> > +       const struct reg_sequence seq_write[] =3D {
> > +               REG_SEQ0(0xe0ee, 0x01),
> > +               REG_SEQ0(0xe05f, 0x01),
> > +               REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
> > +               REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
> > +               REG_SEQ0(0xe05c, addr & 0xff),
> > +       };
> > +
> > +       regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE=
(seq_write));
> > +}
> > +
> > +static int lt7911exc_write_data(struct lt7911exc *lt7911exc, u64 addr)
> > +{
> > +       struct device *dev =3D lt7911exc->dev;
> > +       int ret;
> > +       int page =3D 0, num =3D 0, page_len =3D 0;
> > +       u64 size, offset;
> > +       const u8 *data;
> > +
> > +       data =3D lt7911exc->fw->data;
> > +       size =3D lt7911exc->fw->size;
> > +       page =3D (size + LT_PAGE_SIZE - 1) / LT_PAGE_SIZE;
> > +       if (page * LT_PAGE_SIZE > FW_SIZE) {
> > +               dev_err(dev, "firmware size out of range\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       dev_dbg(dev, "%u pages, total size %llu byte\n", page, size);
> > +
> > +       for (num =3D 0; num < page; num++) {
> > +               offset =3D num * LT_PAGE_SIZE;
> > +               page_len =3D (offset + LT_PAGE_SIZE <=3D size) ? LT_PAG=
E_SIZE : (size - offset);
> > +               lt7911exc_prog_init(lt7911exc, addr);
> > +
> > +               ret =3D regmap_raw_write(lt7911exc->regmap, 0xe05d, &da=
ta[offset], page_len);
> > +               if (ret) {
> > +                       dev_err(dev, "write error at page %d\n", num);
> > +                       return ret;
> > +               }
> > +
> > +               if (page_len < LT_PAGE_SIZE) {
> > +                       regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
> > +                       regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> > +                       //hardware requires delay
> > +                       usleep_range(1000, 2000);
> > +               }
> > +
> > +               regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
> > +               addr +=3D LT_PAGE_SIZE;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int lt7911exc_write_crc(struct lt7911exc *lt7911exc, u64 addr)
> > +{
> > +       u8 crc[4];
> > +       int ret;
> > +
> > +       crc[0] =3D lt7911exc->fw_crc & 0xff;
> > +       crc[1] =3D (lt7911exc->fw_crc >> 8) & 0xff;
> > +       crc[2] =3D (lt7911exc->fw_crc >> 16) & 0xff;
> > +       crc[3] =3D (lt7911exc->fw_crc >> 24) & 0xff;
> > +
> > +       regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> > +       regmap_write(lt7911exc->regmap, 0xe05a, (addr >> 16) & 0xff);
> > +       regmap_write(lt7911exc->regmap, 0xe05b, (addr >> 8) & 0xff);
> > +       regmap_write(lt7911exc->regmap, 0xe05c, addr & 0xff);
> > +
> > +       ret =3D regmap_raw_write(lt7911exc->regmap, 0xe05d, crc, 4);
> > +       if (ret)
> > +               return ret;
> > +       regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
> > +       regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> > +       usleep_range(1000, 2000);
> > +       regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
> > +
> > +       return 0;
> > +}
> > +
> > +static int lt7911exc_firmware_upgrade(struct lt7911exc *lt7911exc)
> > +{
> > +       struct device *dev =3D lt7911exc->dev;
> > +       int ret;
> > +
> > +       ret =3D lt7911exc_prepare_firmware_data(lt7911exc);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       dev_dbg(dev, "starting firmware upgrade, size: %zu bytes\n", lt=
7911exc->fw->size);
> > +
> > +       lt7911exc_block_erase(lt7911exc);
> > +
> > +       ret =3D lt7911exc_write_data(lt7911exc, 0);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to write firmware data\n");
> > +               return ret;
> > +       }
> > +
> > +       release_firmware(lt7911exc->fw);
> > +       lt7911exc->fw =3D NULL;
> > +
> > +       ret =3D lt7911exc_write_crc(lt7911exc, FW_SIZE - 4);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to write firmware crc\n");
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int lt7911exc_upgrade_result(struct lt7911exc *lt7911exc)
> > +{
> > +       struct device *dev =3D lt7911exc->dev;
> > +       u32 read_hw_crc =3D 0;
> > +       u8 crc_tmp[4];
> > +       int ret;
> > +
> > +       regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
> > +       regmap_write(lt7911exc->regmap, 0xe07b, 0x60);
> > +       regmap_write(lt7911exc->regmap, 0xe07b, 0x40);
> > +       msleep(150);
> > +       ret =3D regmap_bulk_read(lt7911exc->regmap, 0x22, crc_tmp, 4);
> > +       if (ret) {
> > +               dev_err(lt7911exc->dev, "Failed to read CRC: %d\n", ret=
);
> > +               return ret;
> > +       }
> > +
> > +       read_hw_crc =3D crc_tmp[0] << 24 | crc_tmp[1] << 16 |
> > +                               crc_tmp[2] << 8 | crc_tmp[3];
> > +
> > +       if (read_hw_crc !=3D lt7911exc->fw_crc) {
> > +               dev_err(dev, "lt7911exc firmware upgrade failed, expect=
ed CRC=3D0x%08x, read CRC=3D0x%08x\n",
> > +                       lt7911exc->fw_crc, read_hw_crc);
> > +               return -EIO;
> > +       }
> > +
> > +       dev_dbg(dev, "lt7911exc firmware upgrade success, CRC=3D0x%08x\=
n", read_hw_crc);
> > +       return 0;
> > +}
> > +
> > +static void lt7911exc_pre_enable(struct drm_bridge *bridge)
> > +{
> > +       struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +       int ret;
> > +
> > +       if (lt7911exc->enabled)
> > +               return;
> > +
> > +       ret =3D lt7911exc_regulator_enable(lt7911exc);
> > +       if (ret)
> > +               return;
> > +
> > +       lt7911exc_reset(lt7911exc);
> > +
> > +       lt7911exc->enabled =3D true;
> > +}
> > +
> > +static void lt7911exc_disable(struct drm_bridge *bridge)
> > +{
> > +       /* Delay after panel is disabled */
> > +       msleep(20);
> > +}
> > +
> > +static void lt7911exc_post_disable(struct drm_bridge *bridge)
> > +{
> > +       struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +       int ret;
> > +
> > +       if (!lt7911exc->enabled)
> > +               return;
> > +
> > +       lt7911exc->enabled =3D false;
> > +
> > +       ret =3D lt7911exc_regulator_disable(lt7911exc);
> > +       if (ret)
> > +               return;
> > +
> > +       gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> > +}
> > +
> > +static int lt7911exc_attach(struct drm_bridge *bridge,
> > +                           struct drm_encoder *encoder,
> > +                           enum drm_bridge_attach_flags flags)
> > +{
> > +       struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> > +
> > +       return drm_bridge_attach(lt7911exc->bridge.encoder, lt7911exc->=
panel_bridge,
> > +                                &lt7911exc->bridge, flags);
> > +}
> > +
> > +static const struct drm_bridge_funcs lt7911exc_bridge_funcs =3D {
> > +       .pre_enable =3D lt7911exc_pre_enable,
> > +       .disable =3D lt7911exc_disable,
> > +       .post_disable =3D lt7911exc_post_disable,
> > +       .attach =3D lt7911exc_attach,
> > +};
> > +
> > +static int lt7911exc_probe(struct i2c_client *client)
> > +{
> > +       struct device *dev =3D &client->dev;
> > +       struct lt7911exc *lt7911exc;
> > +       struct drm_bridge *panel_bridge;
> > +       bool fw_updated =3D false;
> > +       int ret;
> > +
> > +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > +               dev_err(dev, "device doesn't support I2C\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       lt7911exc =3D devm_drm_bridge_alloc(dev, struct lt7911exc, brid=
ge,
> > +                                         &lt7911exc_bridge_funcs);
> > +       if (IS_ERR(lt7911exc))
> > +               return PTR_ERR(lt7911exc);
> > +
> > +       panel_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 0, 0=
);
> > +       if (IS_ERR(panel_bridge))
> > +               return PTR_ERR(panel_bridge);
> > +
> > +       lt7911exc->panel_bridge =3D panel_bridge;
> > +       lt7911exc->client =3D client;
> > +       lt7911exc->dev =3D dev;
> > +       i2c_set_clientdata(client, lt7911exc);
> > +       mutex_init(&lt7911exc->ocm_lock);
>
> devm_mutex_init()
>
it will be fixed in the next version

> > +
> > +       lt7911exc->regmap =3D devm_regmap_init_i2c(client, &lt7911exc_r=
egmap_config);
> > +       if (IS_ERR(lt7911exc->regmap)) {
> > +               dev_err(dev, "regmap i2c init failed\n");
> > +               return PTR_ERR(lt7911exc->regmap);
> > +       }
> > +
> > +       ret =3D lt7911exc_parse_dt(lt7911exc);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D lt7911exc_regulator_enable(lt7911exc);
> > +       if (ret)
> > +               return ret;
> > +
> > +       lt7911exc_reset(lt7911exc);
> > +       lt7911exc->enabled =3D true;
> > +       lt7911exc_lock(lt7911exc);
> > +
> > +retry:
> > +       lt7911exc->fw_version =3D lt7911exc_read_version(lt7911exc);
> > +       if (lt7911exc->fw_version < 0) {
> > +               dev_err(dev, "failed to read FW version\n");
> > +               lt7911exc_unlock(lt7911exc);
> > +               goto err_disable_regulators;
> > +
> > +       } else if (lt7911exc->fw_version =3D=3D 0) {
> > +               if (!fw_updated) {
> > +                       fw_updated =3D true;
> > +                       ret =3D lt7911exc_firmware_upgrade(lt7911exc);
> > +                       if (ret < 0) {
> > +                               lt7911exc_unlock(lt7911exc);
> > +                               goto err_disable_regulators;
> > +                       }
> > +
> > +                       lt7911exc_reset(lt7911exc);
> > +
> > +                       ret =3D lt7911exc_upgrade_result(lt7911exc);
> > +                       if (ret < 0) {
> > +                               lt7911exc_unlock(lt7911exc);
> > +                               goto err_disable_regulators;
> > +                       }
> > +
> > +                       goto retry;
> > +
> > +               } else {
> > +                       dev_err(dev, "fw version 0x%04x, update failed\=
n", lt7911exc->fw_version);
> > +                       ret =3D -EOPNOTSUPP;
> > +                       lt7911exc_unlock(lt7911exc);
> > +                       goto err_disable_regulators;
> > +               }
> > +       }
> > +
> > +       lt7911exc_unlock(lt7911exc);
> > +
> > +       lt7911exc->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
>
> So, this is the DSI host. Where do you register one? Where do you
> populate the DT entries (if there is a panel attached to this bridge
> it will be a child node).
>
it will be fixed in the next version

> > +       lt7911exc->bridge.of_node =3D dev->of_node;
> > +       drm_bridge_add(&lt7911exc->bridge);
>
> devm_drm_bridge_add().
>
it will be fixed in the next version

> > +
> > +       return 0;
> > +
> > +err_disable_regulators:
> > +       regulator_bulk_disable(ARRAY_SIZE(lt7911exc->supplies), lt7911e=
xc->supplies);
> > +       if (lt7911exc->fw) {
> > +               release_firmware(lt7911exc->fw);
> > +               lt7911exc->fw =3D NULL;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static void lt7911exc_remove(struct i2c_client *client)
> > +{
> > +       struct lt7911exc *lt7911exc =3D i2c_get_clientdata(client);
> > +
> > +       drm_bridge_remove(&lt7911exc->bridge);
> > +       mutex_destroy(&lt7911exc->ocm_lock);
> > +}
> > +
> > +static const struct i2c_device_id lt7911exc_i2c_table[] =3D {
> > +       {"lontium, lt7911exc", 0},
> > +       { /* sentinel */ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
> > +
> > +static const struct of_device_id lt7911exc_devices[] =3D {
> > +       {.compatible =3D "lontium,lt7911exc",},
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, lt7911exc_devices);
> > +
> > +static struct i2c_driver lt7911exc_driver =3D {
> > +       .id_table       =3D lt7911exc_i2c_table,
> > +       .probe          =3D lt7911exc_probe,
> > +       .remove         =3D lt7911exc_remove,
> > +       .driver         =3D {
> > +               .name   =3D "lt7911exc",
> > +               .of_match_table =3D lt7911exc_devices,
> > +       },
> > +};
> > +module_i2c_driver(lt7911exc_driver);
> > +
> > +MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
> > +MODULE_DESCRIPTION("Lontium lt7911exc edp to mipi dsi bridge driver");
>
> MIPI, DSI. It LT7911EXC or lt7911exc?
>
it will be fixed in the next version:Lontium lLT7911EXC  to MIPI DSI
bridge driver

> > +MODULE_LICENSE("GPL v2");
Should GPL be used here? I got an error during testing: GPL v2;

> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry
