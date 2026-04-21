Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7BAF5A8DB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDFD10E96A;
	Wed, 22 Apr 2026 08:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GasF7IZh";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A5789E1D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:38:06 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso358003a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 00:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776757086; cv=none;
 d=google.com; s=arc-20240605;
 b=cgNRMcNT+HbkmoAL9wnOKl8XWjvl7Ro6ZM4fvY+8nlVGgjazMa66NuEJHvL7ABuX4a
 pvSGE8+hvfe8gAbI70IX3PVeG9PUXGiQIoiOzhJnfAdBkbLR8rNP2tNoZrCSBA+a2k07
 3htWDKsptUN46jtSZyvt47RAKteWSnTYJdqHe3nJtl52MCqXe11BneZbZsntdEcC2DLK
 z/Xa4ne1KHqEQMGJkkfFqIzJvr0sQ6/+8/WaHjAZtpvKDZHYXbAGJgk+sViYdtPLZtSK
 MWLMJ4Ycz34fOyUgfkp8vqcHXnipKS/01xT817tb3GRo3vNcBoSga3jb7/eiVlcy+ioV
 VNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F9J2JHFagyZ3wiWAru2ykRGIfElJTJV/MpVwclmAXV8=;
 fh=cojzv17MIw5ZLFsutRX5ADvmxNiD700F7u/XfcgGdrw=;
 b=ayro06VR6H/mOOFhSWSkv/1dvX+2ETU2qezaVjDZ/q5dU26lmhYQvmNssi6LtOLaKU
 yLiUeZACAA8JSWITx0QuSoPj6I+4pqK7XOxlllz1GYONalnHeE6eh0QKpd5lr4Vc6jlb
 m7fC7TR/zQzsOaaTXpawWxL33kSvVjB1WscBfaSGEmSAlFdX/OzSeAfcAdC8YqevEKe2
 UcVVUHMXmaie1LKrkbERFQtYhRLCQfbTpWX6QRUyq0lzFMi7JYmf3yvuy+Y5VCN089nU
 hYe67G0fKQE6tdh5r+1W2pOzk8tV4sJNoIv2/bJhU6hk90utVT//vySWSSKFYHChf5TJ
 iMEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776757086; x=1777361886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9J2JHFagyZ3wiWAru2ykRGIfElJTJV/MpVwclmAXV8=;
 b=GasF7IZh+HqYbpnJY7cl41oV3mrXYJOSKL7+rwAn4M/eya5tgh9/2wmoWN2KlwYL+p
 Sm/jW09grjcWSaRxiXgAJFrcX4AGeWw1Poe0G4VZtOTtWShc6jy1X5QijQnBKTJcxvyw
 iMsMwcrjBkTTCFPSVpPMhDTF95oDDocX+ZbcIZmfG0XWBYqmVvYEw6A8tA6tL+5+tXvb
 JfE5DIb5GhEbLobmT0Q2pfzUG7F0nUyQevPk4MqqFtXFk29q7ylSkfF32WQTlsAml54O
 3bMjIUcnQnfpt5lxdwX+Q+xSgVypYiwFsDjcV2lZiV1BM+fAHwY2LyosMkeXH1omWzoY
 hFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757086; x=1777361886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9J2JHFagyZ3wiWAru2ykRGIfElJTJV/MpVwclmAXV8=;
 b=Rp7K5T8YixAr6rgU6q1eKiE0otjM06pTmy7Xyvr7bLmrIhtfPcKarjErlCm+FXyWTh
 NLTOQIOtrvlX4dBfzCpsWOxnR0MlU7jgKMx2DT42hWZ0LGlP8T6KXQsSo/BG4UrfFt7C
 k5CTy8CwQTwQX2tPrfvVSTzmplFQXoXiwEg/JYaD/fV8r5XuIZ2Nfd7JCf6k9xUtOSII
 7+lVmWC70HO8w6mU/G9909RMOS2fnwYq90MCg5XhkQ+jEwSk3IaYiwnEAqA5eMu4DfPh
 OGq45iMA+kTnc6fhzOWnOl5xMHn/pyGmgUcpLbsPIlCoAIyLl75zdHbZT8dbrLkfyXmb
 Ne3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RWrTj7/H1xC7TetaYeYcsUytc8Nzq1vkIzojV3Y0kurphnoPALv2G6nV8FCeGD3RAZDDGctkeVaM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxuIyFXDkAA3nXsnH2hoWXbFQkyQU+7/ceaowmxH0VTC+T431b
 sLrgVEr07Cx+gGHUGs6ykdWZAPT7jZvpaKmndu6rsK0x3Nk9unXJX3MrhGHOlw24+xGNBQXUS8R
 l14OD9auLFbNI5/mJk0RqanZ6gJZFxAE=
X-Gm-Gg: AeBDieu2DEKjEvRgVUKGVXV6TkOVOvELQhT8GCFbce5MQDyLjjv/yX9vp4D8Al4jHLo
 R7YkqOS00xjxVhhAvLON95KoSFdurLT6/HnCwgRSut1p7ZV8ghEwShIGvQTznurs4MHZxjqj86z
 Ceg1yDHeV/qlEOxxSsNN2hzmU0mdlwW3YS31nvzyxrJCQhgJtXLVC/FTLrDkB5C7qcfHYTMcs/9
 tbGfy7RnNYn6sMbvnf0qmSfobNBnbuKmclfb13w9VBb9Nv5rBI0QfW6MTvzav4tIpeS0wRTAhM+
 0ps/Wa4NWvK8hclb
X-Received: by 2002:a05:6820:1793:b0:694:926b:551 with SMTP id
 006d021491bc7-694926b0c46mr2438171eaf.55.1776757085412; Tue, 21 Apr 2026
 00:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260420061644.1251070-1-syyang@lontium.com>
 <20260420061644.1251070-3-syyang@lontium.com>
 <stkoeboxioodtki3nyksdglihgze243u25ui7dbyac4tuuobgx@ncl4j6l4vfqh>
In-Reply-To: <stkoeboxioodtki3nyksdglihgze243u25ui7dbyac4tuuobgx@ncl4j6l4vfqh>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Tue, 21 Apr 2026 15:37:52 +0800
X-Gm-Features: AQROBzDUY6lkCkw_h2LAMfIg-ZphA2-NY88Jg3qare1gKTtpMamFO3miNe_YmA8
Message-ID: <CAFQXuNYXP1fiJtUiMb5iBL=jVXTB8HX8JLzto_eGOZvUaeZkfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: This patch add new DRM bridge driver
 for LT9611C(EX/UXD) chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com, 
 tzimmermann@suse.de, xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
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
4=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 20:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 20, 2026 at 02:16:44PM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > LT9611C(EX/UXD) is a high performance Single/Dual-Port MIPI to
> > HDMI 1.4/2.0 converter:
> >
> > -Single/Dual-port MIPI DSI Receiver
> >  1. Compliantwith D-PHY1.2&DSI-2 1.0
> >  2. 1/2configurable ports
> >  3. 1 clock lane and 1/2/3/4 configurable data lanes per port
> >  4. 80Mbps~2.5Gbps per data lane
> >  5. Support RGB666, loosely RGB666, RGB888, RGB565,16-bit YCbCr4:2:2
> >
> > -HDMI 1.4/2.0 Transmitter
> >  1.Data rate up to 6Gbps
> >  2.Support HDCP1.4/2.3
> >  3.Support CEC,HDR10
> >  4.Support lane swap
> >
> > -audio
> >  1.sample rates of 32~192 KHz and sample sizes
> >    of 16~24 bits
> >  2.SPDIF interface supports PCM, Dolbydigital, DTS digital audio
> >    at up to 192KHz frame rate
> >
> > -Miscellaneous
> >  1.CSC:RGB<->YUV444<->YUV422
> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig           |   18 +
> >  drivers/gpu/drm/bridge/Makefile          |    1 +
> >  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1365 ++++++++++++++++++++++
> >  3 files changed, 1384 insertions(+)
> >  create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index c3209b0f4678..32b85a2a65d9 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> >         HDMI signals
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
> >  config DRM_LONTIUM_LT9611UXC
> >       tristate "Lontium LT9611UXC DSI/HDMI bridge"
> >       select SND_SOC_HDMI_CODEC if SND_SOC
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index beab5b695a6e..92688be9692f 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) +=3D ite-it6505.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8912B) +=3D lontium-lt8912b.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9211.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> > +obj-$(CONFIG_DRM_LONTIUM_LT9611C) +=3D lontium-lt9611c.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
> >  obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm=
/bridge/lontium-lt9611c.c
> > new file mode 100755
> > index 000000000000..a6d11d0bddf5
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > @@ -0,0 +1,1365 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > + */
> > +
> > +#include <linux/crc8.h>
> > +#include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/media-bus-format.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_drv.h>
> > +#include <drm/drm_edid.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_probe_helper.h>
> > +
> > +#include <drm/display/drm_hdmi_audio_helper.h>
> > +#include <drm/display/drm_hdmi_state_helper.h>
> > +#include <sound/hdmi-codec.h>
> > +
> > +#define FW_SIZE (64 * 1024)
> > +#define LT_PAGE_SIZE 256
> > +#define FW_FILE  "LT9611C.bin"
>
> lt9611c_fw.bin
>
will use lt9611c_fw.bin in the next version

> > +#define LT9611C_CRC_POLYNOMIAL 0x31
> > +#define LT9611C_PAGE_CONTROL 0xff
> > +
> > +struct lt9611c {
> > +     struct device *dev;
> > +     struct i2c_client *client;
> > +     struct drm_bridge bridge;
> > +     struct drm_bridge *next_bridge;
>
> Use drm_bridge::next_bridge instead.
>
it will be fixed  in the next version.

> > +     struct regmap *regmap;
> > +     /* Protects all accesses to registers by stopping the on-chip MCU=
 */
> > +     struct mutex ocm_lock;
> > +     struct work_struct work;
> > +     struct device_node *dsi0_node;
> > +     struct device_node *dsi1_node;
> > +     struct mipi_dsi_device *dsi0;
> > +     struct mipi_dsi_device *dsi1;
> > +     struct gpio_desc *reset_gpio;
> > +     struct regulator_bulk_data supplies[2];
> > +     u32 chip_type;
>
> Define a enum. Having if (chip_type =3D=3D 2) doesn't help readability.
>
it will be fixed  in the next version.

> > +     const struct firmware *fw;
>
> Please drop it from the global struct. It is not necessary once the
> bridge is up and running.
>
 Remove from struct.
 I need use fw  to calculate CRC8 and update the firmware.
 Can I use a global variable for 'fw'?

> > +     int fw_version;
> > +     u8 fw_crc;
> > +     bool hdmi_connected;
>
> You've lost the imortant comment here.
>
comment about hdmi_connected ?

> > +};
> > +
> > +DECLARE_CRC8_TABLE(lt9611c_crc8_table);
> > +
> > +static const struct regmap_range_cfg lt9611c_ranges[] =3D {
> > +     {
> > +             .name =3D "register_range",
> > +             .range_min =3D  0,
> > +             .range_max =3D 0xffff,
> > +             .selector_reg =3D LT9611C_PAGE_CONTROL,
> > +             .selector_mask =3D 0xff,
> > +             .selector_shift =3D 0,
> > +             .window_start =3D 0,
> > +             .window_len =3D 0x100,
> > +     },
> > +};
> > +
> > +static const struct regmap_config lt9611c_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D 0xffff,
> > +     .ranges =3D lt9611c_ranges,
> > +     .num_ranges =3D ARRAY_SIZE(lt9611c_ranges),
> > +};
> > +
> > +static int lt9611c_read_write_flow(struct lt9611c *lt9611c, u8 *params=
,
> > +                                unsigned int param_count, u8 *return_b=
uffer,
> > +                                unsigned int return_count)
> > +{
> > +     int count, i;
> > +     unsigned int temp;
> > +
> > +     regmap_write(lt9611c->regmap, 0xe0de, 0x01);
> > +
> > +     count =3D 0;
> > +     do {
> > +             regmap_read(lt9611c->regmap, 0xe0ae, &temp);
> > +             usleep_range(1000, 2000);
> > +             count++;
> > +     } while (count < 100 && temp !=3D 0x01);
>
> read_poll_timeout()
>
will use  read_poll_timeout() in the next version.

 > > +
> > +     if (temp !=3D 0x01)
> > +             return -1;
>
> -ETIMEDOUT
>
return value of -1 means the chip did not receive the operation to
write 0x01 to 0xE0DE.
Below:
     if (temp !=3D 0x02)
            return -2;
means the chip did not receive the operation to write 0x02 to 0xE0DE.

-1 and -2 help us determine where in the code the error occurred.
If both return -ETIMEDOUT, it would be less friendly for debugging
when we encounter issues.
Please confirm whether I should change all of them to return -ETIMEDOUT.

> > +
> > +     for (i =3D 0; i < param_count; i++) {
> > +             if (i > 0xdd - 0xb0)
>
> 0xe0dd - 0xe0b0 at least.
>
it will be fixed  in the next version.

> > +                     break;
> > +
> > +             regmap_write(lt9611c->regmap, 0xe0b0 + i, params[i]);
> > +     }
> > +
> > +     regmap_write(lt9611c->regmap, 0xe0de, 0x02);
> > +
> > +     count =3D 0;
> > +     do {
> > +             regmap_read(lt9611c->regmap, 0xe0ae, &temp);
> > +             usleep_range(1000, 2000);
> > +             count++;
> > +     } while (count < 100 && temp !=3D 0x02);
>
> Again, read_poll_timeout().
>
it will be fixed  in the next version.

> > +
> > +     if (temp !=3D 0x02)
> > +             return -2;
>
> -ETIMEDOUT
>
> > +
> > +     regmap_bulk_read(lt9611c->regmap, 0xe085, return_buffer, return_c=
ount);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_prepare_firmware_data(struct lt9611c *lt9611c)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +     u8 *buffer;
> > +     size_t total_size =3D FW_SIZE - 1;
> > +
> > +     ret =3D request_firmware(&lt9611c->fw, FW_FILE, dev);
> > +     if (ret) {
> > +             dev_err(dev, "failed load file '%s', error type %d\n", FW=
_FILE, ret);
> > +             return -EPROBE_DEFER;
> > +     }
> > +
> > +     if (lt9611c->fw->size > total_size) {
> > +             dev_err(dev, "firmware too large (%zu > %zu)\n", lt9611c-=
>fw->size, total_size);
> > +             release_firmware(lt9611c->fw);
> > +             lt9611c->fw =3D NULL;
> > +             return -EINVAL;
> > +     }
> > +
> > +     dev_dbg(dev, "firmware size: %zu bytes\n", lt9611c->fw->size);
> > +
> > +     buffer =3D kzalloc(total_size, GFP_KERNEL);
> > +     if (!buffer) {
> > +             release_firmware(lt9611c->fw);
> > +             lt9611c->fw =3D NULL;
> > +             return -ENOMEM;
> > +     }
> > +
> > +     memset(buffer, 0xff, total_size);
> > +     memcpy(buffer, lt9611c->fw->data, lt9611c->fw->size);
> > +
> > +     lt9611c->fw_crc =3D crc8(lt9611c_crc8_table, buffer, total_size, =
0);
> > +
> > +     dev_dbg(dev, "firmware crc: 0x%02x\n", lt9611c->fw_crc);
> > +
> > +     kfree(buffer);
> > +     return 0;
> > +}
> > +
> > +static void lt9611c_config_parameters(struct lt9611c *lt9611c)
> > +{
> > +     const struct reg_sequence seq_write_paras[] =3D {
> > +             REG_SEQ0(0xe0ee, 0x01),
> > +             REG_SEQ0(0xe103, 0x3f), //fifo rst
> > +             REG_SEQ0(0xe103, 0xff),
> > +             REG_SEQ0(0xe05e, 0xc1),
> > +             REG_SEQ0(0xe058, 0x00),
> > +             REG_SEQ0(0xe059, 0x50),
> > +             REG_SEQ0(0xe05a, 0x10),
> > +             REG_SEQ0(0xe05a, 0x00),
> > +             REG_SEQ0(0xe058, 0x21),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt9611c->regmap, seq_write_paras, ARRAY_SI=
ZE(seq_write_paras));
> > +}
> > +
> > +static void lt9611c_wren(struct lt9611c *lt9611c)
> > +{
> > +     regmap_write(lt9611c->regmap, 0xe05a, 0x04);
> > +     regmap_write(lt9611c->regmap, 0xe05a, 0x00);
> > +}
> > +
> > +static void lt9611c_wrdi(struct lt9611c *lt9611c)
> > +{
> > +     regmap_write(lt9611c->regmap, 0xe05a, 0x08);
> > +     regmap_write(lt9611c->regmap, 0xe05a, 0x00);
> > +}
> > +
> > +static void lt9611c_erase_op(struct lt9611c *lt9611c, u32 addr)
> > +{
> > +     const struct reg_sequence seq_write[] =3D {
> > +             REG_SEQ0(0xe0ee, 0x01),
> > +             REG_SEQ0(0xe05a, 0x04),
> > +             REG_SEQ0(0xe05a, 0x00),
> > +             REG_SEQ0(0xe05b, (addr >> 16) & 0xff),
> > +             REG_SEQ0(0xe05c, (addr >> 8) & 0xff),
> > +             REG_SEQ0(0xe05d, addr & 0xff),
> > +             REG_SEQ0(0xe05a, 0x01),
> > +             REG_SEQ0(0xe05a, 0x00),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq=
_write));
> > +}
> > +
> > +static void read_flash_reg_status(struct lt9611c *lt9611c, unsigned in=
t *status)
> > +{
> > +     const struct reg_sequence seq_write[] =3D {
> > +             REG_SEQ0(0xe103, 0x3f),
> > +             REG_SEQ0(0xe103, 0xff),
> > +             REG_SEQ0(0xe05e, 0x40),
> > +             REG_SEQ0(0xe056, 0x05),
> > +             REG_SEQ0(0xe055, 0x25),
> > +             REG_SEQ0(0xe055, 0x01),
> > +             REG_SEQ0(0xe058, 0x21),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq=
_write));
> > +
> > +     regmap_read(lt9611c->regmap, 0xe05f, status);
> > +}
> > +
> > +static void lt9611c_crc_to_sram(struct lt9611c *lt9611c)
> > +{
> > +     const struct reg_sequence seq_write[] =3D {
> > +             REG_SEQ0(0xe051, 0x00),
> > +             REG_SEQ0(0xe055, 0xc0),
> > +             REG_SEQ0(0xe055, 0x80),
> > +             REG_SEQ0(0xe05e, 0xc0),
> > +             REG_SEQ0(0xe058, 0x21),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq=
_write));
> > +}
> > +
> > +static void lt9611c_data_to_sram(struct lt9611c *lt9611c)
> > +{
> > +     const struct reg_sequence seq_write[] =3D {
> > +             REG_SEQ0(0xe051, 0xff),
> > +             REG_SEQ0(0xe055, 0x80),
> > +             REG_SEQ0(0xe05e, 0xc0),
> > +             REG_SEQ0(0xe058, 0x21),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq=
_write));
> > +}
> > +
> > +static void lt9611c_sram_to_flash(struct lt9611c *lt9611c, size_t addr=
)
> > +{
> > +     const struct reg_sequence seq_write[] =3D {
> > +             REG_SEQ0(0xe05b, (addr >> 16) & 0xff),
> > +             REG_SEQ0(0xe05c, (addr >> 8) & 0xff),
> > +             REG_SEQ0(0xe05d, addr & 0xff),
> > +             REG_SEQ0(0xe05a, 0x30),
> > +             REG_SEQ0(0xe05a, 0x00),
> > +     };
> > +
> > +     regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq=
_write));
> > +}
> > +
> > +static void lt9611c_block_erase(struct lt9611c *lt9611c)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     int i;
> > +     unsigned int block_num;
> > +     unsigned int flash_status =3D 0;
> > +     u32 flash_addr =3D 0;
> > +
> > +     for (block_num =3D 0; block_num < 2; block_num++) {
> > +             flash_addr =3D (block_num * 0x008000);
> > +             lt9611c_erase_op(lt9611c, flash_addr);
> > +             msleep(100);
> > +             i =3D 0;
> > +             while (1) {
> > +                     read_flash_reg_status(lt9611c, &flash_status);
> > +                     if ((flash_status & 0x01) =3D=3D 0)
> > +                             break;
> > +
> > +                     if (i > 50)
> > +                             break;
> > +
> > +                     i++;
> > +                     msleep(50);
> > +             }
> > +     }
> > +
> > +     dev_dbg(dev, "erase flash done.\n");
> > +}
> > +
> > +static int lt9611c_write_data(struct lt9611c *lt9611c, size_t addr)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +     unsigned int page =3D 0, num =3D 0, i =3D 0;
> > +     size_t size, index;
> > +     const u8 *data;
> > +     u8 value;
> > +
> > +     data =3D lt9611c->fw->data;
> > +     size =3D lt9611c->fw->size;
> > +     page =3D (size + LT_PAGE_SIZE - 1) / LT_PAGE_SIZE;
> > +     if (page * LT_PAGE_SIZE > FW_SIZE) {
> > +             dev_err(dev, "firmware size out of range\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     dev_dbg(dev, "%u pages, total size %zu byte\n", page, size);
> > +
> > +     for (num =3D 0; num < page; num++) {
> > +             lt9611c_data_to_sram(lt9611c);
> > +
> > +             for (i =3D 0; i < LT_PAGE_SIZE; i++) {
> > +                     index =3D num * LT_PAGE_SIZE + i;
> > +                     value =3D (index < size) ? data[index] : 0xff;
> > +
> > +                     ret =3D regmap_write(lt9611c->regmap, 0xe059, val=
ue);
> > +                     if (ret < 0) {
> > +                             dev_err(dev, "write error at page %u, ind=
ex %u\n", num, i);
> > +                             return ret;
> > +                     }
> > +             }
> > +
> > +             lt9611c_wren(lt9611c);
> > +             lt9611c_sram_to_flash(lt9611c, addr);
> > +
> > +             addr +=3D LT_PAGE_SIZE;
> > +     }
> > +
> > +     lt9611c_wrdi(lt9611c);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_write_crc(struct lt9611c *lt9611c, size_t addr)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +     u8 crc;
> > +
> > +     crc =3D lt9611c->fw_crc;
> > +     lt9611c_crc_to_sram(lt9611c);
> > +     ret =3D regmap_write(lt9611c->regmap, 0xe059, crc);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write crc\n");
> > +             return ret;
> > +     }
> > +
> > +     lt9611c_wren(lt9611c);
> > +     lt9611c_sram_to_flash(lt9611c, addr);
> > +     lt9611c_wrdi(lt9611c);
> > +
> > +     dev_dbg(dev, "crc 0x%02x written to flash at addr 0x%zx\n", crc, =
addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +
> > +     ret =3D lt9611c_prepare_firmware_data(lt9611c);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     dev_dbg(dev, "starting firmware upgrade, size: %zu bytes\n", lt96=
11c->fw->size);
> > +
> > +     lt9611c_config_parameters(lt9611c);
> > +     lt9611c_block_erase(lt9611c);
> > +
> > +     ret =3D lt9611c_write_data(lt9611c, 0);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write firmware data\n");
> > +             return ret;
> > +     }
> > +
> > +     release_firmware(lt9611c->fw);
> > +     lt9611c->fw =3D NULL;
> > +
> > +     ret =3D lt9611c_write_crc(lt9611c, FW_SIZE - 1);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to write firmware crc\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_upgrade_result(struct lt9611c *lt9611c)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     unsigned int crc_result;
> > +
> > +     regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> > +     regmap_read(lt9611c->regmap, 0xe021, &crc_result);
> > +
> > +     if (crc_result !=3D lt9611c->fw_crc) {
> > +             dev_err(dev, "lt9611c fw upgrade failed, expected crc=3D0=
x%02x, read crc=3D0x%02x\n",
> > +                     lt9611c->fw_crc, crc_result);
> > +             return -1;
> > +     }
> > +
> > +     dev_dbg(dev, "lt9611c firmware upgrade success, crc=3D0x%02x\n", =
crc_result);
> > +     return 0;
> > +}
> > +
> > +static struct lt9611c *bridge_to_lt9611c(struct drm_bridge *bridge)
> > +{
> > +     return container_of(bridge, struct lt9611c, bridge);
> > +}
> > +
> > +/*read only*/
> > +static const struct lt9611c *bridge_to_lt9611c_const(const struct drm_=
bridge *bridge)
> > +{
> > +     return container_of(bridge, const struct lt9611c, bridge);
> > +}
> > +
> > +static void lt9611c_lock(struct lt9611c *lt9611c)
> > +{
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +     regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> > +}
> > +
> > +static void lt9611c_unlock(struct lt9611c *lt9611c)
> > +{
> > +     regmap_write(lt9611c->regmap, 0xe0ee, 0x00);
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +}
> > +
> > +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> > +{
> > +     struct lt9611c *lt9611c =3D dev_id;
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +     unsigned int irq_status;
> > +     u8 cmd[5] =3D {0x52, 0x48, 0x31, 0x3a, 0x00};
> > +     u8 data[5];
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
>
> Where applicable (like here) please switch to
> guard(mutex)(&lt9611c->ocm_lock);
>
it will be fixed  in the next version.

> > +
> > +     regmap_read(lt9611c->regmap, 0xe084, &irq_status);
> > +     if (!(irq_status & BIT(0))) {
> > +             mutex_unlock(&lt9611c->ocm_lock);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     ret =3D lt9611c_read_write_flow(lt9611c, cmd, 5, data, 5);
>
> Here and in all other places. Switch to ARRAY_SIZE instead of specifying
> lengths directly.
>
it will be fixed  in the next version.

> > +     if (ret) {
> > +             dev_err(dev, "failed to read HPD status\n");
> > +     } else {
> > +             lt9611c->hdmi_connected =3D (data[4] =3D=3D 0x02);
> > +             dev_dbg(dev, "HDMI %s\n", lt9611c->hdmi_connected ? "conn=
ected" : "disconnected");
> > +     }
> > +
> > +     schedule_work(&lt9611c->work);
> > +
> > +     /*clear interrupt*/
> > +     regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> > +     //hardware need delay
> > +     usleep_range(10000, 12000);
> > +     regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));
> > +
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void lt9611c_hpd_work(struct work_struct *work)
> > +{
> > +     struct lt9611c *lt9611c =3D container_of(work, struct lt9611c, wo=
rk);
> > +     bool connected;
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +     connected =3D lt9611c->hdmi_connected;
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     drm_bridge_hpd_notify(&lt9611c->bridge,
> > +                           connected ? connector_status_connected :
> > +                           connector_status_disconnected);
> > +}
> > +
> > +static void lt9611c_reset(struct lt9611c *lt9611c)
> > +{
> > +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > +     msleep(20);
> > +
> > +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > +     msleep(20);
> > +
> > +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> > +     msleep(400);
> > +
> > +     dev_dbg(lt9611c->dev, "lt9611c reset");
> > +}
> > +
> > +static int lt9611c_regulator_init(struct lt9611c *lt9611c)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +
> > +     lt9611c->supplies[0].supply =3D "vcc";
> > +     lt9611c->supplies[1].supply =3D "vdd";
> > +
> > +     ret =3D devm_regulator_bulk_get(dev, 2, lt9611c->supplies);
> > +
> > +     return ret;
> > +}
> > +
> > +static int lt9611c_regulator_enable(struct lt9611c *lt9611c)
> > +{
> > +     int ret;
> > +
> > +     ret =3D regulator_enable(lt9611c->supplies[0].consumer);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     usleep_range(5000, 10000);
> > +
> > +     ret =3D regulator_enable(lt9611c->supplies[1].consumer);
> > +     if (ret < 0) {
> > +             regulator_disable(lt9611c->supplies[0].consumer);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_regulator_disable(struct lt9611c *lt9611c)
> > +{
> > +     int ret;
> > +
> > +     ret =3D regulator_disable(lt9611c->supplies[0].consumer);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D regulator_disable(lt9611c->supplies[1].consumer);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct mipi_dsi_device *lt9611c_attach_dsi(struct lt9611c *lt96=
11c,
> > +                                               struct device_node *dsi=
_node)
> > +{
> > +     const struct mipi_dsi_device_info info =3D { "lt9611c", 0, NULL }=
;
> > +     struct mipi_dsi_device *dsi;
> > +     struct mipi_dsi_host *host;
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +
> > +     host =3D of_find_mipi_dsi_host_by_node(dsi_node);
> > +     if (!host) {
> > +             dev_err(dev, "failed to find dsi host\n");
> > +             return ERR_PTR(-EPROBE_DEFER);
>
> here and futher, in the probe path use `return dev_err_probe()`.
>
it will be fixed  in the next version.

> > +     }
> > +
> > +     dsi =3D devm_mipi_dsi_device_register_full(dev, host, &info);
> > +     if (IS_ERR(dsi)) {
> > +             dev_err(dev, "failed to create dsi device\n");
> > +             return dsi;
> > +     }
> > +
> > +     dsi->lanes =3D 4;
> > +     dsi->format =3D MIPI_DSI_FMT_RGB888;
> > +     dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYN=
C_PULSE |
> > +                      MIPI_DSI_MODE_VIDEO_HSE;
> > +
> > +     ret =3D devm_mipi_dsi_attach(dev, dsi);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to attach dsi to host\n");
> > +             return ERR_PTR(ret);
> > +     }
> > +
> > +     return dsi;
> > +}
> > +
> > +static int lt9611c_bridge_attach(struct drm_bridge *bridge,
> > +                              struct drm_encoder *encoder,
> > +                              enum drm_bridge_attach_flags flags)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +
> > +     return drm_bridge_attach(encoder, lt9611c->next_bridge, bridge, f=
lags);
> > +}
> > +
> > +static enum drm_mode_status
> > +lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> > +                               const struct drm_display_mode *mode,
> > +                               unsigned long long tmds_rate)
> > +{
> > +     const struct lt9611c *lt9611c =3D bridge_to_lt9611c_const(bridge)=
;
> > +
> > +     if (lt9611c->chip_type =3D=3D 2) {
> > +             /*lt9611uxd use*/
> > +             if (tmds_rate > 600000000)
> > +                     return MODE_CLOCK_HIGH;
> > +
> > +     } else {
> > +             if (tmds_rate > 340000000)
> > +                     return MODE_CLOCK_HIGH;
> > +     }
> > +
> > +     if (tmds_rate < 25000000)
> > +             return MODE_CLOCK_LOW;
> > +
> > +     return MODE_OK;
> > +}
> > +
> > +static void lt9611c_video_setup(struct lt9611c *lt9611c,
> > +                             const struct drm_display_mode *mode)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +     u32 h_total, hactive, hsync_len, hfront_porch, hback_porch;
> > +     u32 v_total, vactive, vsync_len, vfront_porch, vback_porch;
> > +     u8 video_timing_set_cmd[26] =3D {0x57, 0x4d, 0x33, 0x3a};
> > +     u8 return_timing_set_param[3];
> > +     u8 framerate;
> > +     u8 vic =3D 0x00;
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +
> > +     h_total =3D mode->htotal;
> > +     hactive =3D mode->hdisplay;
> > +     hsync_len =3D mode->hsync_end - mode->hsync_start;
> > +     hfront_porch =3D mode->hsync_start - mode->hdisplay;
> > +     hback_porch =3D mode->htotal - mode->hsync_end;
> > +
> > +     v_total =3D mode->vtotal;
> > +     vactive =3D mode->vdisplay;
> > +     vsync_len =3D mode->vsync_end - mode->vsync_start;
> > +     vfront_porch =3D mode->vsync_start - mode->vdisplay;
> > +     vback_porch =3D mode->vtotal - mode->vsync_end;
> > +     framerate =3D drm_mode_vrefresh(mode);
> > +     vic =3D drm_match_cea_mode(mode);
> > +
> > +     dev_dbg(dev, "hactive=3D%d, vactive=3D%d\n", hactive, vactive);
> > +     dev_dbg(dev, "framerate=3D%d\n", framerate);
> > +     dev_dbg(dev, "vic =3D 0x%02x\n", vic);
> > +
> > +     video_timing_set_cmd[4] =3D (h_total >> 8) & 0xff;
> > +     video_timing_set_cmd[5] =3D h_total & 0xff;
> > +     video_timing_set_cmd[6] =3D (hactive >> 8) & 0xff;
> > +     video_timing_set_cmd[7] =3D hactive & 0xff;
> > +     video_timing_set_cmd[8] =3D (hfront_porch >> 8) & 0xff;
> > +     video_timing_set_cmd[9] =3D hfront_porch & 0xff;
> > +     video_timing_set_cmd[10] =3D (hsync_len >> 8) & 0xff;
> > +     video_timing_set_cmd[11] =3D hsync_len & 0xff;
> > +     video_timing_set_cmd[12] =3D (hback_porch >> 8) & 0xff;
> > +     video_timing_set_cmd[13] =3D hback_porch & 0xff;
> > +     video_timing_set_cmd[14] =3D (v_total >> 8) & 0xff;
> > +     video_timing_set_cmd[15] =3D v_total & 0xff;
> > +     video_timing_set_cmd[16] =3D (vactive >> 8) & 0xff;
> > +     video_timing_set_cmd[17] =3D vactive & 0xFF;
> > +     video_timing_set_cmd[18] =3D (vfront_porch >> 8) & 0xff;
> > +     video_timing_set_cmd[19] =3D vfront_porch & 0xff;
> > +     video_timing_set_cmd[20] =3D (vsync_len >> 8) & 0xff;
> > +     video_timing_set_cmd[21] =3D vsync_len & 0xff;
> > +     video_timing_set_cmd[22] =3D (vback_porch >> 8) & 0xff;
> > +     video_timing_set_cmd[23] =3D vback_porch & 0xff;
> > +     video_timing_set_cmd[24] =3D framerate;
> > +     video_timing_set_cmd[25] =3D vic;
> > +
> > +     ret =3D lt9611c_read_write_flow(lt9611c,
> > +                                   video_timing_set_cmd, 26,
> > +                                   return_timing_set_param, 3);
> > +     if (ret)
> > +             dev_err(dev, "video set failed\n");
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +}
> > +
> > +static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> > +                                      struct drm_atomic_state *state)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +     struct drm_connector *connector;
> > +     struct drm_connector_state *conn_state;
> > +     struct drm_crtc_state *crtc_state;
> > +     struct drm_display_mode *mode;
> > +
> > +     connector =3D drm_atomic_get_new_connector_for_encoder(state, bri=
dge->encoder);
> > +     if (WARN_ON(!connector))
> > +             return;
> > +
> > +     conn_state =3D drm_atomic_get_new_connector_state(state, connecto=
r);
> > +     if (WARN_ON(!conn_state))
> > +             return;
> > +
> > +     crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state->c=
rtc);
> > +     if (WARN_ON(!crtc_state))
> > +             return;
> > +
> > +     mode =3D &crtc_state->adjusted_mode;
> > +
> > +     lt9611c_video_setup(lt9611c, mode);
> > +}
> > +
> > +static enum drm_connector_status
> > +lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector =
*connector)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +     struct device *dev =3D lt9611c->dev;
> > +     int ret;
> > +     bool connected =3D false;
> > +     u8 cmd[5] =3D {0x52, 0x48, 0x31, 0x3a, 0x00};
> > +     u8 data[5];
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +
> > +     ret =3D lt9611c_read_write_flow(lt9611c, cmd, 5, data, 5);
> > +     if (ret)
> > +             dev_err(dev, "failed to read HPD status (err=3D%d)\n", re=
t);
> > +     else
> > +             connected =3D (data[4] =3D=3D 0x02);
> > +
> > +     lt9611c->hdmi_connected =3D connected;
> > +
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     return connected ? connector_status_connected :
> > +                             connector_status_disconnected;
> > +}
> > +
> > +static int lt9611c_get_edid_block(void *data, u8 *buf,
> > +                               unsigned int block, size_t len)
> > +{
> > +     struct lt9611c *lt9611c =3D data;
> > +     struct device *dev =3D lt9611c->dev;
> > +     u8 cmd[5] =3D {0x52, 0x48, 0x33, 0x3a, 0x00};
> > +     u8 packet[37];
> > +     int ret, i, offset =3D 0;
> > +
> > +     if (len !=3D 128)
> > +             return -EINVAL;
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +
> > +     for (i =3D 0; i < 4; i++) {
> > +             cmd[4] =3D block * 4 + i;
> > +             ret =3D lt9611c_read_write_flow(lt9611c, cmd, sizeof(cmd)=
,
> > +                                           packet, sizeof(packet));
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to read EDID block %u packet=
 %d\n",
> > +                             block, i);
> > +                     mutex_unlock(&lt9611c->ocm_lock);
> > +                     return ret;
> > +             }
> > +
> > +             memcpy(buf + offset, &packet[5], 32);
> > +             offset +=3D 32;
> > +     }
> > +
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct drm_edid *lt9611c_bridge_edid_read(struct drm_brid=
ge *bridge,
> > +                                                    struct drm_connect=
or *connector)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +
> > +     return drm_edid_read_custom(connector, lt9611c_get_edid_block, lt=
9611c);
> > +}
> > +
> > +static void lt9611c_bridge_hpd_notify(struct drm_bridge *bridge,
> > +                                   struct drm_connector *connector,
> > +                                   enum drm_connector_status status)
> > +{
> > +     const struct drm_edid *drm_edid;
> > +
> > +     if (status =3D=3D connector_status_disconnected) {
> > +             drm_connector_hdmi_audio_plugged_notify(connector, false)=
;
> > +             drm_edid_connector_update(connector, NULL);
> > +             return;
> > +     }
> > +
> > +     drm_edid =3D lt9611c_bridge_edid_read(bridge, connector);
> > +     drm_edid_connector_update(connector, drm_edid);
> > +     drm_edid_free(drm_edid);
> > +
> > +     if (status =3D=3D connector_status_connected)
> > +             drm_connector_hdmi_audio_plugged_notify(connector, true);
> > +}
> > +
> > +static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridg=
e,
> > +                                           const u8 *buffer, size_t le=
n)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +     u8 audio_infoframe_cmd[16] =3D {0x57, 0x48, 0x35, 0x3a, 0x02};
> > +     u8 data[5];
> > +     int i, ret;
> > +
> > +     for (i =3D 0; i <  len; i++)
> > +             audio_infoframe_cmd[i + 5] =3D buffer[i];
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +
> > +     ret =3D lt9611c_read_write_flow(lt9611c, audio_infoframe_cmd, siz=
eof(audio_infoframe_cmd),
> > +                                   data, sizeof(data));
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     if (ret < 0) {
> > +             dev_err(lt9611c->dev, "write audio infoframe failed!\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *bridg=
e)
> > +{
> > +     return 0;
>
> Hmm? What if we need to clear the infoframe?
>
don't need to clear the infoframe.

can remove.

> > +}
> > +
> > +static int lt9611c_hdmi_write_avi_infoframe(struct drm_bridge *bridge,
> > +                                         const u8 *buffer, size_t len)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +     u8 avi_infoframe_cmd[16] =3D {0x57, 0x48, 0x35, 0x3a, 0x01};
> > +     u8 data[5];
> > +     int i, ret;
> > +
> > +     for (i =3D 0; i <  len; i++)
> > +             avi_infoframe_cmd[i + 5] =3D buffer[i];
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +
> > +     ret =3D lt9611c_read_write_flow(lt9611c, avi_infoframe_cmd, sizeo=
f(avi_infoframe_cmd),
> > +                                   data, sizeof(data));
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     if (ret < 0) {
> > +             dev_err(lt9611c->dev, "write avi infoframe failed!\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_hdmi_clear_avi_infoframe(struct drm_bridge *bridge)
> > +{
>
> The same question.
>
don't need to clear

> > +     return 0;
> > +}
> > +
> > +static int lt9611c_hdmi_write_spd_infoframe(struct drm_bridge *bridge,
> > +                                         const u8 *buffer, size_t len)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +     u8 spd_infoframe_cmd[16] =3D {0x57, 0x48, 0x35, 0x3a, 0x04};
> > +     u8 data[5];
> > +     int i, ret;
> > +
> > +     for (i =3D 0; i <  len; i++)
> > +             spd_infoframe_cmd[i + 5] =3D buffer[i];
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +
> > +     ret =3D lt9611c_read_write_flow(lt9611c, spd_infoframe_cmd, sizeo=
f(spd_infoframe_cmd),
> > +                                   data, sizeof(data));
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     if (ret < 0) {
> > +             dev_err(lt9611c->dev, "write spd infoframe failed!\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_hdmi_clear_spd_infoframe(struct drm_bridge *bridge)
> > +{
> > +     return 0;
> > +}
don't need to clear
> > +
> > +static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge=
,
> > +                                          const u8 *buffer, size_t len=
)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +     u8 spd_infoframe_cmd[16] =3D {0x57, 0x48, 0x35, 0x3a, 0x05};
> > +     u8 data[5];
> > +     int i, ret;
> > +
> > +     for (i =3D 0; i <  len; i++)
> > +             spd_infoframe_cmd[i + 5] =3D buffer[i];
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +
> > +     ret =3D lt9611c_read_write_flow(lt9611c, spd_infoframe_cmd, sizeo=
f(spd_infoframe_cmd),
> > +                                   data, sizeof(data));
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +     if (ret < 0) {
> > +             dev_err(lt9611c->dev, "write hdmi infoframe failed!\n");
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_hdmi_clear_hdmi_infoframe(struct drm_bridge *bridge=
)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
> > +                                   struct drm_connector *connector,
> > +                                   struct hdmi_codec_daifmt *fmt,
> > +                                   struct hdmi_codec_params *hparms)
> > +{
> > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > +     u8 audio_cmd[6] =3D {0x57, 0x48, 0x36, 0x3a};
> > +     u8 data[5];
> > +     int ret;
> > +
> > +     /* Validate sample rate and width (LT9611C auto-detects but we st=
ill check) */
>
> What for? You don't trust ASoC / ALSA core that the rates would match
> HDMI_RATES?

Chip has limitations on sample_rate, sample_width, and fmt, and cannot
support all formats.
The validation here is to ensure that only the formats supported by
the chip are used.
>
> > +     switch (hparms->sample_rate) {
> > +     case 32000:
> > +     case 44100:
> > +     case 48000:
> > +     case 88200:
> > +     case 96000:
> > +     case 176400:
> > +     case 192000:
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     switch (hparms->sample_width) {
> > +     case 16:
> > +     case 18:
> > +     case 20:
> > +     case 24:
>
> and no support for 32?
>
no support for 32

> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     switch (fmt->fmt) {
> > +     case HDMI_I2S:
> > +             audio_cmd[4] =3D 0x01;
> > +             break;
> > +     case HDMI_SPDIF:
> > +             audio_cmd[4] =3D 0x02;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     audio_cmd[5] =3D hparms->channels;
> > +
> > +     mutex_lock(&lt9611c->ocm_lock);
> > +     ret =3D lt9611c_read_write_flow(lt9611c, audio_cmd, sizeof(audio_=
cmd),
> > +                                   data, sizeof(data));
> > +     mutex_unlock(&lt9611c->ocm_lock);
> > +
> > +     if (ret < 0) {
> > +             dev_err(lt9611c->dev, "set audio info failed!\n");
> > +             return ret;
> > +     }
> > +
> > +     return drm_atomic_helper_connector_hdmi_update_audio_infoframe(co=
nnector,
> > +                                                                     &=
hparms->cea);
>
> Please check the indentation.
>
it will be fixed  in the next version.

> > +}
> > +
> > +static void lt9611c_hdmi_audio_shutdown(struct drm_bridge *bridge,
> > +                                     struct drm_connector *connector)
> > +{
> > +     drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector)=
;
> > +}
> > +
> > +static int lt9611c_hdmi_audio_startup(struct drm_bridge *bridge,
> > +                                   struct drm_connector *connector)
> > +{
> > +     return 0;
> > +}
> > +
> > +static const struct drm_bridge_funcs lt9611c_bridge_funcs =3D {
> > +     .attach =3D lt9611c_bridge_attach,
> > +     .detect =3D lt9611c_bridge_detect,
> > +     .edid_read =3D lt9611c_bridge_edid_read,
> > +     .hpd_notify =3D lt9611c_bridge_hpd_notify,
> > +     .atomic_enable =3D lt9611c_bridge_atomic_enable,
> > +
> > +     .hdmi_tmds_char_rate_valid =3D lt9611c_hdmi_tmds_char_rate_valid,
> > +     .hdmi_write_audio_infoframe =3D lt9611c_hdmi_write_audio_infofram=
e,
> > +     .hdmi_clear_audio_infoframe =3D lt9611c_hdmi_clear_audio_infofram=
e,
> > +     .hdmi_write_avi_infoframe =3D lt9611c_hdmi_write_avi_infoframe,
> > +     .hdmi_clear_avi_infoframe =3D lt9611c_hdmi_clear_avi_infoframe,
> > +     .hdmi_write_spd_infoframe =3D lt9611c_hdmi_write_spd_infoframe,
> > +     .hdmi_clear_spd_infoframe =3D lt9611c_hdmi_clear_spd_infoframe,
> > +     .hdmi_write_hdmi_infoframe =3D lt9611c_hdmi_write_hdmi_infoframe,
> > +     .hdmi_clear_hdmi_infoframe =3D lt9611c_hdmi_clear_hdmi_infoframe,
>
> You implemented all these callbacks, but you haven't tested them. They
> won't be called as is. You would need to set one more DRM bridge OP. And
> once set, you can drop the .hpd_notify, it will be handled by the
> generic code.
>
i will add DRM_BRIDGE_OP_HDMI  and remove .hpd_notify  in next version.

> > +     .hdmi_audio_startup =3D lt9611c_hdmi_audio_startup,
> > +     .hdmi_audio_prepare =3D lt9611c_hdmi_audio_prepare,
> > +     .hdmi_audio_shutdown =3D lt9611c_hdmi_audio_shutdown,
> > +};
> > +
> > +static int lt9611c_parse_dt(struct device *dev,
> > +                         struct lt9611c *lt9611c)
> > +{
> > +     lt9611c->dsi0_node =3D of_graph_get_remote_node(dev->of_node, 0, =
-1);
> > +     if (!lt9611c->dsi0_node) {
> > +             dev_err(dev, "failed to get remote node for primary dsi\n=
");
> > +             return -ENODEV;
> > +     }
> > +
> > +     lt9611c->dsi1_node =3D of_graph_get_remote_node(dev->of_node, 1, =
-1);
> > +
> > +     return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt=
9611c->next_bridge);
> > +}
> > +
> > +static int lt9611c_gpio_init(struct lt9611c *lt9611c)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +
> > +     lt9611c->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LO=
W);
> > +     if (IS_ERR(lt9611c->reset_gpio)) {
> > +             dev_err(dev, "failed to acquire reset gpio\n");
> > +             return PTR_ERR(lt9611c->reset_gpio);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lt9611c_read_version(struct lt9611c *lt9611c)
> > +{
> > +     u8 buf[2];
> > +     int ret;
> > +
> > +     ret =3D regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_bulk_read(lt9611c->regmap, 0xe080, buf, 2);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return (buf[0] << 8) | buf[1];
> > +}
> > +
> > +static int lt9611c_read_chipid(struct lt9611c *lt9611c)
> > +{
> > +     struct device *dev =3D lt9611c->dev;
> > +     u8 chipid[2];
> > +     int ret;
> > +
> > +     ret =3D regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_bulk_read(lt9611c->regmap, 0xe100, chipid, 2);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (chipid[0] !=3D 0x23 || chipid[1] !=3D 0x06) {
> > +             dev_err(dev, "ChipID: 0x%02x 0x%02x\n", chipid[0], chipid=
[1]);
> > +             return -ENODEV;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t lt9611c_firmware_store(struct device *dev, struct devic=
e_attribute *attr,
> > +                                   const char *buf, size_t len)
> > +{
> > +     struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     lt9611c_lock(lt9611c);
> > +
> > +     ret =3D lt9611c_firmware_upgrade(lt9611c);
> > +     if (ret < 0) {
> > +             dev_err(dev, "upgrade failure\n");
> > +             goto out;
> > +     }
> > +     lt9611c_reset(lt9611c);
> > +     ret =3D lt9611c_upgrade_result(lt9611c);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +out:
> > +     lt9611c_unlock(lt9611c);
> > +     lt9611c_reset(lt9611c);
> > +     if (lt9611c->fw) {
> > +             release_firmware(lt9611c->fw);
> > +             lt9611c->fw =3D NULL;
> > +     }
> > +
> > +     return ret < 0 ? ret : len;
> > +}
> > +
> > +static ssize_t lt9611c_firmware_show(struct device *dev, struct device=
_attribute *attr, char *buf)
> > +{
> > +     struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);
> > +}
> > +
> > +static DEVICE_ATTR_RW(lt9611c_firmware);
> > +
> > +static struct attribute *lt9611c_attrs[] =3D {
> > +     &dev_attr_lt9611c_firmware.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group lt9611c_attr_group =3D {
> > +     .attrs =3D lt9611c_attrs,
> > +};
> > +
> > +static const struct attribute_group *lt9611c_attr_groups[] =3D {
> > +     &lt9611c_attr_group,
> > +     NULL,
> > +};
> > +
> > +static int lt9611c_probe(struct i2c_client *client)
> > +{
> > +     const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
> > +     struct lt9611c *lt9611c;
> > +     struct device *dev =3D &client->dev;
> > +     bool fw_updated =3D false;
> > +     int ret;
> > +
> > +     crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
> > +
> > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > +             dev_err(dev, "device doesn't support I2C\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     lt9611c =3D devm_drm_bridge_alloc(dev, struct lt9611c, bridge, &l=
t9611c_bridge_funcs);
> > +     if (IS_ERR(lt9611c))
> > +             return PTR_ERR(lt9611c);
> > +
> > +     lt9611c->dev =3D dev;
> > +     lt9611c->client =3D client;
> > +     lt9611c->chip_type =3D id->driver_data;
> > +     mutex_init(&lt9611c->ocm_lock);
> > +
> > +     lt9611c->regmap =3D devm_regmap_init_i2c(client, &lt9611c_regmap_=
config);
> > +     if (IS_ERR(lt9611c->regmap)) {
> > +             dev_err(dev, "regmap i2c init failed\n");
> > +             return PTR_ERR(lt9611c->regmap);
> > +     }
> > +
> > +     ret =3D lt9611c_parse_dt(dev, lt9611c);
> > +     if (ret) {
> > +             dev_err(dev, "failed to parse device tree\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D lt9611c_gpio_init(lt9611c);
> > +     if (ret < 0)
> > +             goto err_of_put;
> > +
> > +     ret =3D lt9611c_regulator_init(lt9611c);
> > +     if (ret < 0)
> > +             goto err_of_put;
> > +
> > +     ret =3D lt9611c_regulator_enable(lt9611c);
> > +     if (ret)
> > +             goto err_of_put;
> > +
> > +     lt9611c_reset(lt9611c);
> > +
> > +     lt9611c_lock(lt9611c);
> > +
> > +     ret =3D lt9611c_read_chipid(lt9611c);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to read chip id.\n");
> > +             lt9611c_unlock(lt9611c);
> > +             goto err_disable_regulators;
> > +     }
> > +
> > +retry:
> > +     ret =3D lt9611c_read_version(lt9611c);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to read fw version\n");
> > +             lt9611c_unlock(lt9611c);
> > +             goto err_disable_regulators;
> > +
> > +     } else if (ret =3D=3D 0) {
> > +             if (!fw_updated) {
> > +                     fw_updated =3D true;
> > +                     ret =3D lt9611c_firmware_upgrade(lt9611c);
> > +                     if (ret < 0) {
> > +                             lt9611c_unlock(lt9611c);
> > +                             goto err_disable_regulators;
> > +                     }
> > +
> > +                     lt9611c_reset(lt9611c);
> > +
> > +                     ret =3D lt9611c_upgrade_result(lt9611c);
> > +                     if (ret < 0) {
> > +                             lt9611c_unlock(lt9611c);
> > +                             goto err_disable_regulators;
> > +                     }
> > +
> > +                     goto retry;
> > +
> > +             } else {
> > +                     dev_err(dev, "fw version 0x%04x, update failed\n"=
, ret);
> > +                     ret =3D -EOPNOTSUPP;
> > +                     lt9611c_unlock(lt9611c);
> > +                     goto err_disable_regulators;
> > +             }
> > +     }
> > +
> > +     lt9611c_unlock(lt9611c);
> > +     lt9611c->fw_version =3D ret;
> > +
> > +     dev_dbg(dev, "current version:0x%04x", lt9611c->fw_version);
> > +
> > +     INIT_WORK(&lt9611c->work, lt9611c_hpd_work);
> > +
> > +     ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL=
,
> > +                                     lt9611c_irq_thread_handler,
> > +                                     IRQF_TRIGGER_FALLING |
> > +                                     IRQF_ONESHOT |
> > +                                     IRQF_NO_AUTOEN,
> > +                                     "lt9611c", lt9611c);
> > +     if (ret) {
> > +             dev_err(dev, "failed to request irq\n");
> > +             goto err_disable_regulators;
> > +     }
> > +
> > +     lt9611c->bridge.of_node =3D client->dev.of_node;
> > +     lt9611c->bridge.ops =3D DRM_BRIDGE_OP_DETECT |
> > +                     DRM_BRIDGE_OP_EDID |
> > +                     DRM_BRIDGE_OP_HPD |
> > +                     DRM_BRIDGE_OP_HDMI_AUDIO;
> > +     lt9611c->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
> > +
> > +     lt9611c->bridge.hdmi_audio_dev =3D dev;
> > +     lt9611c->bridge.hdmi_audio_max_i2s_playback_channels =3D 8;
> > +     lt9611c->bridge.hdmi_audio_dai_port =3D 2;
> > +
> > +     drm_bridge_add(&lt9611c->bridge);
> > +
> > +     /* Attach primary DSI */
> > +     lt9611c->dsi0 =3D lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node)=
;
> > +     if (IS_ERR(lt9611c->dsi0)) {
> > +             ret =3D PTR_ERR(lt9611c->dsi0);
> > +             goto err_remove_bridge;
> > +     }
> > +
> > +     /* Attach secondary DSI, if specified */
> > +     if (lt9611c->dsi1_node) {
> > +             lt9611c->dsi1 =3D lt9611c_attach_dsi(lt9611c, lt9611c->ds=
i1_node);
> > +             if (IS_ERR(lt9611c->dsi1)) {
> > +                     ret =3D PTR_ERR(lt9611c->dsi1);
> > +                     goto err_remove_bridge;
> > +             }
> > +     }
> > +
> > +     lt9611c->hdmi_connected =3D false;
> > +     i2c_set_clientdata(client, lt9611c);
> > +     enable_irq(client->irq);
> > +     lt9611c_reset(lt9611c);
> > +
> > +     return 0;
> > +
> > +err_remove_bridge:
> > +     free_irq(client->irq, lt9611c);
> > +     cancel_work_sync(&lt9611c->work);
> > +     drm_bridge_remove(&lt9611c->bridge);
> > +
> > +err_disable_regulators:
> > +     regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->su=
pplies);
> > +
> > +err_of_put:
> > +     of_node_put(lt9611c->dsi1_node);
> > +     of_node_put(lt9611c->dsi0_node);
> > +     if (lt9611c->fw) {
> > +             release_firmware(lt9611c->fw);
> > +             lt9611c->fw =3D NULL;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static void lt9611c_remove(struct i2c_client *client)
> > +{
> > +     struct lt9611c *lt9611c =3D i2c_get_clientdata(client);
> > +
> > +     free_irq(client->irq, lt9611c);
> > +     cancel_work_sync(&lt9611c->work);
> > +     drm_bridge_remove(&lt9611c->bridge);
> > +     mutex_destroy(&lt9611c->ocm_lock);
> > +     regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->su=
pplies);
> > +     of_node_put(lt9611c->dsi1_node);
> > +     of_node_put(lt9611c->dsi0_node);
> > +}
> > +
> > +static int lt9611c_bridge_suspend(struct device *dev)
> > +{
> > +     struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     dev_dbg(lt9611c->dev, "suspend\n");
> > +     disable_irq(lt9611c->client->irq);
> > +     ret =3D lt9611c_regulator_disable(lt9611c);
> > +     gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> > +
> > +     return ret;
> > +}
> > +
> > +static int lt9611c_bridge_resume(struct device *dev)
> > +{
> > +     struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret =3D lt9611c_regulator_enable(lt9611c);
> > +     enable_irq(lt9611c->client->irq);
> > +     lt9611c_reset(lt9611c);
> > +     dev_dbg(lt9611c->dev, "resume\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct dev_pm_ops lt9611c_bridge_pm_ops =3D {
> > +     SET_SYSTEM_SLEEP_PM_OPS(lt9611c_bridge_suspend,
> > +                             lt9611c_bridge_resume)
> > +};
> > +
> > +static struct i2c_device_id lt9611c_id[] =3D {
> > +     /* chip_type */
> > +     { "lontium,lt9611c", 0 },
> > +     { "lontium,lt9611ex", 1 },
> > +     { "lontium,lt9611uxd", 2 },
> > +     { /* sentinel */ }
> > +};
> > +
> > +static const struct of_device_id lt9611c_match_table[] =3D {
> > +     { .compatible =3D "lontium,lt9611c" },
> > +     { .compatible =3D "lontium,lt9611ex" },
> > +     { .compatible =3D "lontium,lt9611uxd" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, lt9611c_match_table);
> > +
> > +static struct i2c_driver lt9611c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "lt9611c",
> > +             .of_match_table =3D lt9611c_match_table,
> > +             .pm =3D &lt9611c_bridge_pm_ops,
> > +             .dev_groups =3D lt9611c_attr_groups,
> > +     },
> > +     .probe =3D lt9611c_probe,
> > +     .remove =3D lt9611c_remove,
> > +     .id_table =3D lt9611c_id,
> > +};
> > +module_i2c_driver(lt9611c_driver);
> > +
> > +MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
> > +MODULE_DESCRIPTION("Lontium lt9611c mipi-dsi to hdmi driver");
>
> MIPI, DSI, HDMI
>
it will be fixed  in the next version.

> > +MODULE_LICENSE("GPL v2");
>
>
> I think, checkpatch.pl should have flagged this.
>
yes,  it is need use GPL?
I see that many of the latest code still use GPL v2.

> > +
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry
