Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E073FF55811
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E32210E969;
	Wed, 22 Apr 2026 08:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OdtbKB+m";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5550E10E25B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 01:06:36 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d7f92bde91so2684360a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 18:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776819995; cv=none;
 d=google.com; s=arc-20240605;
 b=MdoF/Ev9dV1ahLxk9DapKrqbixElu1PYcGmgge9KIVu9/CZOR4aW27PM6RMGaZp4Dk
 xZ8utxi3Jf38pfRcvUv+D0vsclG6SwJvpVkvAQC6A/5/+TZHZpWcAfMEox0Amx+Oyekc
 R8XSajfm9QiwKRkKJW/3WJjTv2Hl7E+T1koxxM4zh4Tu5WfOIEJFANE5NSoSFgyeFt6M
 YQhtVzXufooCzs5AGLuveszONbPA0jt0BWjCdqlP8urQYrR13l1osNiieI7rMFi4i5o5
 jRFP6oggRim2a/UPEK2GC+w2fXqU9okmTP9EfIiC8PVEE/mu8rSEw4XYcices8NQIrAH
 kZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0IRFmArTYLfOKDBhdMLQmn7zlltkZiYQwJVABBk+Y1U=;
 fh=rpAaz5ee9W98YcAiPsnqLGvQpdMIXBV9PXDQ1L2CZUk=;
 b=bJ7yVnuZmEXbC3BK8MwDtmyZ9L6drpLLsEwbmL1GW9stxDUSUDfdwulhhabmicNdGT
 rbArNun2izIilFxb9eGLPaSlD45OkbhAoEC7QlU9Y9r+C5FS+yRfE2ocgXy/WNHHfcry
 GE9Hm/R0aeork57FclziHvOyTEpaKYPapgy4XpiroPJZ/9Nxi4ksKEZ9ujDpQY0ORMWi
 3leTgoIbqWAFmpCp1a/eWwyw+1N5c0gjJTdBM2oA6jxG3ifrv0SAXlvdyB+BnBFuFPNv
 8WleSpM27hUBy8vtMvT39xV7iewAco6X8xy3cUPPW6acqsRf+tg/o8/Wg1W7Apx+Fbv3
 UXxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776819995; x=1777424795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IRFmArTYLfOKDBhdMLQmn7zlltkZiYQwJVABBk+Y1U=;
 b=OdtbKB+moKa6D7h+VSxEXBYULsIE5OhweEskVLV8e0chPn1Uxnx3tY/j+cHDoLcBvM
 L6bIzXjkL4P+wkBaeJNzi7f0WL3yQzgmBTKqXlEYeCT6hibVlbXI8npWdx+DbPkK+l90
 UfHea6c26hjiB1TJr6231FPyuCPaq+Rj5yJiMMwQ82hJ57OWAYkTc5A6DhvT/NiqRYrb
 9LwebcH1bzKMz5FFW97mtvilFnKz6BXGrBwaZbv8iNi+W4E4aRZCQDyokuFjYImKyzHp
 VUknjhKjuvu6D7oeCA1ufkoM5n1MBmufdhNHenXj66/yRmHwIQqL8KPlA3aHb3Bui5e9
 L+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776819995; x=1777424795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0IRFmArTYLfOKDBhdMLQmn7zlltkZiYQwJVABBk+Y1U=;
 b=HnsoI7DfJwXoo+5Eveu1Hv32xDT0XpXEuaENSQCs7598YL6uElb0XuPEssP3FEA/79
 CSIVze/6s4Ieu9T0olXi9x1GrhEtR+Za5PehllmThuZ3haeP//mVKbtWQlqPedgakeS5
 rVnISXASc4aDzAJ9BpAjXIqOiMrOwj/q7JN8t1jhQZ4DAccl0EcnIUnjK6roTUUCcNoa
 FJ+f8d5rFXJDsKJGkA1GKg7JfsdI96Fq4LffcS/tcTPPkIAvdMA4g+NEkh36GTjVpZIs
 qBCaSG7nZ+YobOzGhbQ9OpreLZwMFdYdB/eCPloOePI7Ln/A8Oxxo4BBgjTq3Rljr+7a
 Tk4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KXOZSlxe0GCEOL+Yl+A2lGGvoQZTiSVhkHc94Hm+NilY0DVDyRZfKn9L3yIFFuUCLPaIS9bwbNS0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysomT6pCttNv8mku2v0VaZUz9gTcavGg1pK9sPsJU+jrzK1WvD
 Q4LzbzomTMj/oAj04YsqxLTtmhju7YKwPIYBGtUhwTqe0rTcFemtD5DkyzcdPpL46qdS7CMR2ic
 Lj+zZ5W1z84yEs9bYI7VHb92z+fjrCCM=
X-Gm-Gg: AeBDies/0PyHOBhTu2w5OwCQWcLGm+pdAOkR9QwpYzsGW3w7+yK3QtXWNzqOVlEEN4J
 ZeTi7FAZxY6dmnBTuW4pMUPq2IKTZarJN8ZNMAIn191e1q6OV+J3Ly8LkiEjJY1YcecEFpi9IYD
 /KsLoVLZG9Q3Fx9cTI5GpaDNOmK/kQKCCCtEGkdmn943DMEht2OcyF2vXzefipsu49nLCU9YKpv
 nP5DfEqLq4maSQ/Lg2M8YCJzia9Jz3+2aHyz1/OBp047tNLYWcjnx3OpTvoGZUvkihgkt6gcAol
 6jMDbdks0iyjpiF88w==
X-Received: by 2002:a05:6820:f015:b0:694:8428:dfd8 with SMTP id
 006d021491bc7-6948428e120mr5659420eaf.34.1776819995375; Tue, 21 Apr 2026
 18:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-3-syyang@lontium.com>
 <CAO9ioeXDfTdETEBQknoLehk2aiabCgse109sDgJoPHuQ_07nKQ@mail.gmail.com>
 <CAFQXuNYV+wt2-+8R4m+mtby9TBwcX+vGdqvUvb_6wXkkBg6b=w@mail.gmail.com>
 <ed5u73a5lpsixqvm35zpmooolstjv22ygusorub2owbgz7cwj5@42uq6kl6run7>
In-Reply-To: <ed5u73a5lpsixqvm35zpmooolstjv22ygusorub2owbgz7cwj5@42uq6kl6run7>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Wed, 22 Apr 2026 09:06:22 +0800
X-Gm-Features: AQROBzBaNDUxhxDS0HVaopMbG0cmT-p3eH7E1MY-UMTymB_tTXik718agZAW4Cs
Message-ID: <CAFQXuNZXe0vXAr+dN4LQfC95pvJ5C+Z+b+AuSGZnG4Ui+Nbjww@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:26:51 +0000
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
4=E6=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 19:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 21, 2026 at 11:13:30AM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B44=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 11:57=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> > > >
> > > > From: Sunyun Yang <syyang@lontium.com>
> > > >
> > > > LT7911EXC is a high performance  eDP1.4 to MIPI chip for
> > >
> > > MIPI what?
> > >
> > MIPI DSI,
> > It will be modified in the next version.
> >
> > > > VR/Display application.
> > > >
> > > > -eDP1.4Receiver
> > > >  1.Support SSC
> > > >  2.Support 1/2/4 lanes
> > > >  3.Support up to 4K@60HzRGB/YCbCr4:4:48bpc
> > > >  4.Support lane swap and PN swap
> > > >
> > > > -MIPI Transmitter
> > > >  1.CompliantwithD-PHY1.2&DSI1.1&CSI-22.0=EF=BC=9B1 clock lane,
> > > >    and1/2/3/4 configurable data lanes:2.5Gbpsperdatalane
> > > >  2.CompliantwithC-PHY1.0&DSI-21.0&CSI-22.0;
> > > >    1/2/3 configurable data trio=EF=BC=9B2.5Gsps perdatatrio
> > > >  3.Support1/2configurable ports
> > > >  4.DSISupport16/20/24-bit YCbCr4:2:2,16/18/24/30-bit RGB
> > > >
> > > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/Kconfig             |  18 +
> > > >  drivers/gpu/drm/bridge/Makefile            |   1 +
> > > >  drivers/gpu/drm/bridge/lontium-lt7911exc.c | 571 +++++++++++++++++=
++++
> > > >  3 files changed, 590 insertions(+)
> > > >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridg=
e/Kconfig
> > > > index c3209b0f4678..bae8cdaea666 100644
> > > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > > @@ -202,6 +202,24 @@ config DRM_LONTIUM_LT8713SX
> > > >           to 3 configurable Type-C/DP1.4/HDMI2.0 outputs
> > > >           Please say Y if you have such hardware.
> > > >
> > > > +config DRM_LONTIUM_LT9611C
> > >
> > > I thought the patch is for LT7911EXC
> > >
> > Yes, it is LT7911EXC, It will be modified in the next version.
> >
> > > > +       tristate "Lontium LT9611C DSI/HDMI bridge"
> > > > +       select SND_SOC_HDMI_CODEC if SND_SOC
> > > > +       depends on OF
> > > > +       select CRC8
> > > > +       select FW_LOADER
> > > > +       select DRM_PANEL_BRIDGE
> > > > +       select DRM_KMS_HELPER
> > > > +       select DRM_MIPI_DSI
> > > > +       select DRM_DISPLAY_HELPER
> > > > +       select DRM_DISPLAY_HDMI_STATE_HELPER
> > > > +       select REGMAP_I2C
> > > > +       help
> > > > +         Driver for Lontium DSI to HDMI bridge
> > > > +         chip driver that converts dual DSI and I2S to
> > > > +         HDMI signals
> > > > +         Please say Y if you have such hardware.
> > > > +
> > > >  config DRM_ITE_IT66121
> > > >         tristate "ITE IT66121 HDMI bridge"
> > > >         depends on OF
> > > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/brid=
ge/Makefile
> > > > index beab5b695a6e..54b293d1663e 100644
> > > > --- a/drivers/gpu/drm/bridge/Makefile
> > > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > > @@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9=
211.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
> > > > +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) +=3D lontium-lt7911exc.o
> > >
> > > Keep the list sorted, please.
> > >
> > Where can I see the sorting rules? Please guide me.
> > it is:
> > obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) +=3D lontium-lt7911exc.o
> > obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
>
> zoom out, check the overall contents, submit a patch fixing the error.
>
It will be fixed in the next version

> >
> > > >  obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
> > > >  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) +=3D megachips-s=
tdpxxxx-ge-b850v3-fw.o
> > > >  obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) +=3D microchip-lvds.o
> > > > diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/g=
pu/drm/bridge/lontium-lt7911exc.c
> > > > new file mode 100644
> > > > index 000000000000..d1c1d9e073ef
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > > > @@ -0,0 +1,571 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > > > + */
> > > > +
> > > > +#include <linux/crc32.h>
> > > > +#include <linux/firmware.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/regmap.h>
> > >
> > > I think you use more than that.
> > >
> > It will be modified in the next version.
> >
> > > > +#include <drm/drm_of.h>
> > > > +
> > > > +#define FW_SIZE (64 * 1024)
> > > > +#define LT_PAGE_SIZE 32
> > > > +#define FW_FILE  "LT7911EXC.bin"
> > > > +#define LT7911EXC_PAGE_CONTROL 0xff
> > > > +
> > > > +struct lt7911exc {
> > > > +       struct device *dev;
> > > > +       struct i2c_client *client;
> > > > +       struct drm_bridge bridge;
> > > > +       struct drm_bridge *panel_bridge;
> > >
> > > Use next_bridge from struct drm_bridge instead.
> > >
> > It will be modified in the next version.
> >
> > > > +       struct regmap *regmap;
> > > > +       /* Protects all accesses to registers by stopping the on-ch=
ip MCU */
> > > > +       struct mutex ocm_lock;
> > > > +       struct regulator_bulk_data supplies[2];
> > > > +
> > > > +       struct gpio_desc *reset_gpio;
> > > > +       const struct firmware *fw;
> > >
> > > Do you need to store it during the runtime? If not, please remove fro=
m
> > > the data struct.
> > >
> > Don't need  store during the runtime.
> > Can I use the global variable 'fw'?
>
> Of course not.
>
It will use local variable in the next version

> > Because I need use 'fw' to calculate the CRC32 and burn the firmware.
>
> Sure, but what does it have to do with the field in struct lt7911exc?
>
You are correct, and I will fix according to your suggestions.

> >
> > > > +       int fw_version;
> > > > +       u32 fw_crc;
> > > > +
> > > > +       bool enabled;
> > >
> > > What for?
> > >
> > (bool enabled;) is used as a flag in the code to reduce the frequency
> > of power supply switching.
>
> How does it help to reduce the rate?
>
The enabled flag is used to track the hardware power state. In
lt7911exc_pre_enable(), we check if (lt7911exc->enabled) return; to
avoid redundant regulator enabling and reset pulses when the DRM
framework calls pre_enable multiple times.

Similarly, lt7911exc_post_disable() uses it to prevent multiple
power-down sequences. This reduces unnecessary power supply switching
and potential side effects.

However, if you consider this optimization unnecessary, I can remove
the flag and the related checks in the next version. Please let me
know your preference.

> > Of course, it can also be removed in the next version.
> >
> > > > +};
> > > > +
> > > > +static const struct regmap_range_cfg lt7911exc_ranges[] =3D {
> > > > +       {
> > > > +               .name =3D "register_range",
> > > > +               .range_min =3D  0,
> > > > +               .range_max =3D 0xffff,
> > >
> > > Is it an actual range?
> > >
> > 0xe8ff is actual  range.
>
> Then why?
>
The actual valid register address ends at 0xe8ff. I mistakenly set
range_max to 0xffff.
I will fix it to 0xe8ff in the next version. Thank you for catching this.

> >
> > > > +               .selector_reg =3D LT7911EXC_PAGE_CONTROL,
> > > > +               .selector_mask =3D 0xff,
> > > > +               .selector_shift =3D 0,
> > > > +               .window_start =3D 0,
> > > > +               .window_len =3D 0x100,
> > > > +       },
> > > > +};
> > > > +
> > > > +static const struct regmap_config lt7911exc_regmap_config =3D {
> > > > +       .reg_bits =3D 8,
> > > > +       .val_bits =3D 8,
> > > > +       .max_register =3D 0xffff,
> > > > +       .ranges =3D lt7911exc_ranges,
> > > > +       .num_ranges =3D ARRAY_SIZE(lt7911exc_ranges),
> > > > +};
> > > > +
> > > > +static u32 cal_crc32_custom(const u8 *data, u64 length)
> > > > +{
> > > > +       u32 crc =3D 0xffffffff;
> > > > +       u8 buf[4];
> > > > +       u64 i;
> > > > +
> > > > +       for (i =3D 0; i < length; i +=3D 4) {
> > > > +               buf[0] =3D data[i + 3];
> > > > +               buf[1] =3D data[i + 2];
> > > > +               buf[2] =3D data[i + 1];
> > > > +               buf[3] =3D data[i + 0];
> > > > +               crc =3D crc32_be(crc, buf, 4);
> > >
> > > How is it different from crc32_le()?
> > >
> > The implementation differs from crc32_le() in both byte ordering and
> > processing granularity.
> > This function performs a 32-bit word-wise byte swap (little-endian to
> > big-endian) before feeding data into crc32_be(), while crc32_le()
> > processes the input stream directly in little-endian order without
> > transformation.
> > Therefore, the result is not equivalent to crc32_le(), and is required
> > to match the firmware's expected big-endian word-based CRC format.
>
> ack.
>
> >
> >
> > > > +MODULE_LICENSE("GPL v2");
> > Should GPL be used here? I got an error during testing: GPL v2;
>
> Which error?
>
Sorry, is  warning:
WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db
("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#649: FILE: drivers/gpu/drm/bridge/lontium-lt7911exc.c:571:
+MODULE_LICENSE("GPL v2");

 It will be fixed in the next version.

> --
> With best wishes
> Dmitry
