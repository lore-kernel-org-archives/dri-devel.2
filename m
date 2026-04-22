Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BD1F55811
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B23810E09D;
	Wed, 22 Apr 2026 08:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KeFnbuNQ";
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486AB10E269
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 04:41:26 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-673ee2a98b1so2752529eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 21:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776832885; cv=none;
 d=google.com; s=arc-20240605;
 b=OsWtTTikqVc7RmwxFy/5ViERpwVm9E7MiOCaek5YwsQNaQ8kJdTgXZyiYHJJ78ZA1k
 oNsaOXK9wdF9fhSk5h/GHalnkoJ/2vSDf0+wBB6vZGcXDB9zBjibd8Nyy9Q8ZKc691Iv
 ulpo9rWaPoitLTZx7jQnzFR4BVtKvyHRp5NtRvxxiH98FzT4whA8uOFkVefeMYnC6u63
 a3yW+uLF6sS8mSR5EgU74lArc8ZFr7jzQcmSuHxx4jcW9Ef3AIN6NlRduEDQo1Ye4q25
 9oW67iIFdidTzlIGCeMiLTEK1BtpTz1pifPdQszmnT9cqg6fYZJEmr3x7UyhRwChZnC/
 NM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iqpI2Qga7qV1SoO0DpNYUT1AHnLY7neznziWT82FXjM=;
 fh=5L0ZscDG7zibg1dhZctCnanDj7xBGtY1k87v0MrzgsQ=;
 b=iwyqcvdROk0y7AZ/uk2vb6pw19TbIRkRFPLq0KfntXJRzScttUpzsHmQ317qra1vOj
 vdv8yUMCvsApKZtnciYbk4G8n2hkq6hMsLq5rFePftyRqWpLsOc06XxiL5iHVnjCaMfX
 2ZCWDGmPWSyoNzgvFQvqX/Lso4OfLR+ioujOvSQF4h0WaZX00yJeoJH0uJ/BMVnvc1y/
 qjUby0SKtfeHpyCkDURh/bpkewEAlWK3Ki7NPF+5md+C2oTquaZT69+AApChrU5jgL5s
 qzLdHqes8h7pDIgpz9ycXZY73qJ9MJfWmaGu88GdYWUixA93gLeZmYY7g1j3eWxfHdQw
 ocvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776832885; x=1777437685; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqpI2Qga7qV1SoO0DpNYUT1AHnLY7neznziWT82FXjM=;
 b=KeFnbuNQRyRKov5DcgANcV06tKBhP0D89ni2CpnXIl0eLCgVn3N3FWKecfFveBvhQh
 Osc1NrO6rG6RwWadfth0ozXcIDy/Ot7EhG+JhTZ84A9H1QStcAYtQF23EMjZD8YX19+3
 BPUtVO5qJCLlSrNk868/8c0ai9xtX5L82jA0EmuAyKlJtdl9IEjGiUnHSOi3eQ7s3nor
 GNnbPS4iPNcH2UKABM5LVy02lVRhT8DM4MRzDVUDjrzI4nCmRL0tQfKBOmGuscMw98e5
 PLS6yc/PcfSrRR7o6maOE8pIMcdWSXc+kvdh7tdVHxVZugM0oihAeWD2n7NcgSX1gZVX
 Dmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776832885; x=1777437685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqpI2Qga7qV1SoO0DpNYUT1AHnLY7neznziWT82FXjM=;
 b=cO6V/eNhlnFI5HQ/w5Ac69ave3p20tX8QdK53IS6alsfO+DaoyF30kzG0U3QzEQQT2
 NVeKVAPG7wpfBgDmPiHkygVy4Zk6TfZCK6WWb5E/rz5eKUJfkdGIK9AR1jKzROga4YHA
 WZhamArDTXcRef/6ST/re0jgMDCvrMIrr5U/XwYxqy5qfIHy23/0MusDvBrj0/fh6Z5C
 YZ2ikGo/DVz2ztAvMPbAbxRr4y7+SC+JGOOVplT9YMl1X1aZLrTq0cny9kaZi9JkZmF1
 UcKDY/GQ21JcWLefBM4GecUOIfHZG4WI4DX5eqzFW9nJtvimxCq5c4mPk2sv/m3O8Owr
 hq7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M8DzVNSIv2dcxpsHxDxx3f/26ZjcUp4/wQlhyl1DohZQujdlysi2BgAnLL9RMbmg0qzNPsQ2Dri0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFowNUxaJ0cN95i/WeS+4ITxRcYUB/j5lpgzVmWyTEFMuoFGnJ
 IKIo3BWyXlpB/1FHEC1rWFWFL5WO2R4Y/9bEUYPgoAqivZHoP7zHKxiTOpwOVzmcl9zQYaOZb5X
 utKJtv5cqZFjS1OoufopzullTXcAxXew=
X-Gm-Gg: AeBDiesqf58cMAz/dk+4W17zPTtbOBqA6JkZE28/8542UcMNXEAl7qE9WkMt6ZgFjeN
 O/xiyZW8JHsb9rnMiqLOkqLGl+3OQvuoK9v4oHZpfWle7oqFq/YJ79vz+54k49ETBZT7Cg8hnPM
 IniLqeZnb0b0jZJWutMYP6GIx9LBHGPaXBSrY4zYZ24J2JLoE/gWoNhZ95l+BAX9K8ZnES/XXuZ
 z7bhq1aYVevswWcPj2BCg5dsNxdn3mR6NDvDY6IVgMiqrb5GJkCevnCyshVYSdu4qTpoHSLqrSZ
 RL56PWbxdGOBKH5B
X-Received: by 2002:a05:6820:81f:b0:694:9f11:c206 with SMTP id
 006d021491bc7-6949f11d12cmr2180362eaf.43.1776832885315; Tue, 21 Apr 2026
 21:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260420061644.1251070-1-syyang@lontium.com>
 <20260420061644.1251070-3-syyang@lontium.com>
 <stkoeboxioodtki3nyksdglihgze243u25ui7dbyac4tuuobgx@ncl4j6l4vfqh>
 <CAFQXuNYXP1fiJtUiMb5iBL=jVXTB8HX8JLzto_eGOZvUaeZkfw@mail.gmail.com>
 <mvthlwcekj6i2h7bi5lns7ycictafjjyninvubp6adgaqxchkz@372c36cxon5t>
In-Reply-To: <mvthlwcekj6i2h7bi5lns7ycictafjjyninvubp6adgaqxchkz@372c36cxon5t>
From: =?UTF-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Date: Wed, 22 Apr 2026 12:41:11 +0800
X-Gm-Features: AQROBzCrKn71q3qJQGVrOxF_O3MY_lk3-znik2-XRYtUo-_4CkhOOCaBXWhMwsA
Message-ID: <CAFQXuNZG-La0YpmHgMA-TZ2ayPDLfEvkbrSJZyW-jFCzXU-mLw@mail.gmail.com>
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
4=E6=9C=8821=E6=97=A5=E5=91=A8=E4=BA=8C 18:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 21, 2026 at 03:37:52PM +0800, =E6=9D=A8=E5=AD=99=E8=BF=90 wro=
te:
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=
=B9=B44=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 20:18=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > On Mon, Apr 20, 2026 at 02:16:44PM +0800, syyang@lontium.com wrote:
> > > > From: Sunyun Yang <syyang@lontium.com>
> > > >
> > > > LT9611C(EX/UXD) is a high performance Single/Dual-Port MIPI to
> > > > HDMI 1.4/2.0 converter:
> > > >
> > > > -Single/Dual-port MIPI DSI Receiver
> > > >  1. Compliantwith D-PHY1.2&DSI-2 1.0
> > > >  2. 1/2configurable ports
> > > >  3. 1 clock lane and 1/2/3/4 configurable data lanes per port
> > > >  4. 80Mbps~2.5Gbps per data lane
> > > >  5. Support RGB666, loosely RGB666, RGB888, RGB565,16-bit YCbCr4:2:=
2
> > > >
> > > > -HDMI 1.4/2.0 Transmitter
> > > >  1.Data rate up to 6Gbps
> > > >  2.Support HDCP1.4/2.3
> > > >  3.Support CEC,HDR10
> > > >  4.Support lane swap
> > > >
> > > > -audio
> > > >  1.sample rates of 32~192 KHz and sample sizes
> > > >    of 16~24 bits
> > > >  2.SPDIF interface supports PCM, Dolbydigital, DTS digital audio
> > > >    at up to 192KHz frame rate
> > > >
> > > > -Miscellaneous
> > > >  1.CSC:RGB<->YUV444<->YUV422
> > > >
> > > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/Kconfig           |   18 +
> > > >  drivers/gpu/drm/bridge/Makefile          |    1 +
> > > >  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1365 ++++++++++++++++++=
++++
> > > >  3 files changed, 1384 insertions(+)
> > > >  create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridg=
e/Kconfig
> > > > index c3209b0f4678..32b85a2a65d9 100644
> > > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > > @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> > > >         HDMI signals
> > > >         Please say Y if you have such hardware.
> > > >
> > > > +config DRM_LONTIUM_LT9611C
> > > > +     tristate "Lontium LT9611C DSI/HDMI bridge"
> > > > +     select SND_SOC_HDMI_CODEC if SND_SOC
> > > > +     depends on OF
> > > > +     select CRC8
> > > > +     select FW_LOADER
> > > > +     select DRM_PANEL_BRIDGE
> > > > +     select DRM_KMS_HELPER
> > > > +     select DRM_MIPI_DSI
> > > > +     select DRM_DISPLAY_HELPER
> > > > +     select DRM_DISPLAY_HDMI_STATE_HELPER
> > > > +     select REGMAP_I2C
> > > > +     help
> > > > +       Driver for Lontium DSI to HDMI bridge
> > > > +       chip driver that converts dual DSI and I2S to
> > > > +       HDMI signals
> > > > +       Please say Y if you have such hardware.
> > > > +
> > > >  config DRM_LONTIUM_LT9611UXC
> > > >       tristate "Lontium LT9611UXC DSI/HDMI bridge"
> > > >       select SND_SOC_HDMI_CODEC if SND_SOC
> > > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/brid=
ge/Makefile
> > > > index beab5b695a6e..92688be9692f 100644
> > > > --- a/drivers/gpu/drm/bridge/Makefile
> > > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > > @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) +=3D ite-it6505.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT8912B) +=3D lontium-lt8912b.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9211.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> > > > +obj-$(CONFIG_DRM_LONTIUM_LT9611C) +=3D lontium-lt9611c.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
> > > >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
> > > >  obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
> > > > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu=
/drm/bridge/lontium-lt9611c.c
> > > > new file mode 100755
> > > > index 000000000000..a6d11d0bddf5
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > > > @@ -0,0 +1,1365 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > > > + */
> > > > +
> > > > +#include <linux/crc8.h>
> > > > +#include <linux/firmware.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/interrupt.h>
> > > > +#include <linux/media-bus-format.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/of_graph.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > +
> > > > +#include <drm/drm_atomic_helper.h>
> > > > +#include <drm/drm_bridge.h>
> > > > +#include <drm/drm_connector.h>
> > > > +#include <drm/drm_drv.h>
> > > > +#include <drm/drm_edid.h>
> > > > +#include <drm/drm_mipi_dsi.h>
> > > > +#include <drm/drm_modes.h>
> > > > +#include <drm/drm_of.h>
> > > > +#include <drm/drm_print.h>
> > > > +#include <drm/drm_probe_helper.h>
> > > > +
> > > > +#include <drm/display/drm_hdmi_audio_helper.h>
> > > > +#include <drm/display/drm_hdmi_state_helper.h>
> > > > +#include <sound/hdmi-codec.h>
> > > > +
> > > > +#define FW_SIZE (64 * 1024)
> > > > +#define LT_PAGE_SIZE 256
> > > > +#define FW_FILE  "LT9611C.bin"
> > >
> > > lt9611c_fw.bin
> > >
> > will use lt9611c_fw.bin in the next version
> >
> > > > +#define LT9611C_CRC_POLYNOMIAL 0x31
> > > > +#define LT9611C_PAGE_CONTROL 0xff
> > > > +
> > > > +struct lt9611c {
> > > > +     struct device *dev;
> > > > +     struct i2c_client *client;
> > > > +     struct drm_bridge bridge;
> > > > +     struct drm_bridge *next_bridge;
> > >
> > > Use drm_bridge::next_bridge instead.
> > >
> > it will be fixed  in the next version.
> >
> > > > +     struct regmap *regmap;
> > > > +     /* Protects all accesses to registers by stopping the on-chip=
 MCU */
> > > > +     struct mutex ocm_lock;
> > > > +     struct work_struct work;
> > > > +     struct device_node *dsi0_node;
> > > > +     struct device_node *dsi1_node;
> > > > +     struct mipi_dsi_device *dsi0;
> > > > +     struct mipi_dsi_device *dsi1;
> > > > +     struct gpio_desc *reset_gpio;
> > > > +     struct regulator_bulk_data supplies[2];
> > > > +     u32 chip_type;
> > >
> > > Define a enum. Having if (chip_type =3D=3D 2) doesn't help readabilit=
y.
> > >
> > it will be fixed  in the next version.
> >
> > > > +     const struct firmware *fw;
> > >
> > > Please drop it from the global struct. It is not necessary once the
> > > bridge is up and running.
> > >
> >  Remove from struct.
> >  I need use fw  to calculate CRC8 and update the firmware.
> >  Can I use a global variable for 'fw'?
>
> Of course not. You need the struct firmware and CRC only when reflashing
> the firmware. Pass them within those functions as arguments.
>
 it will be fixed  in the next version.

> >
> > > > +     int fw_version;
> > > > +     u8 fw_crc;
> > > > +     bool hdmi_connected;
> > >
> > > You've lost the imortant comment here.
> > >
> > comment about hdmi_connected ?
>
> Yes.
>
it will be fixed in next version
> >
> > > > +};
> > > > +
> > > > +DECLARE_CRC8_TABLE(lt9611c_crc8_table);
> > > > +
> > > > +static const struct regmap_range_cfg lt9611c_ranges[] =3D {
> > > > +     {
> > > > +             .name =3D "register_range",
> > > > +             .range_min =3D  0,
> > > > +             .range_max =3D 0xffff,
> > > > +             .selector_reg =3D LT9611C_PAGE_CONTROL,
> > > > +             .selector_mask =3D 0xff,
> > > > +             .selector_shift =3D 0,
> > > > +             .window_start =3D 0,
> > > > +             .window_len =3D 0x100,
> > > > +     },
> > > > +};
> > > > +
> > > > +static const struct regmap_config lt9611c_regmap_config =3D {
> > > > +     .reg_bits =3D 8,
> > > > +     .val_bits =3D 8,
> > > > +     .max_register =3D 0xffff,
> > > > +     .ranges =3D lt9611c_ranges,
> > > > +     .num_ranges =3D ARRAY_SIZE(lt9611c_ranges),
> > > > +};
> > > > +
> > > > +static int lt9611c_read_write_flow(struct lt9611c *lt9611c, u8 *pa=
rams,
> > > > +                                unsigned int param_count, u8 *retu=
rn_buffer,
> > > > +                                unsigned int return_count)
> > > > +{
> > > > +     int count, i;
> > > > +     unsigned int temp;
> > > > +
> > > > +     regmap_write(lt9611c->regmap, 0xe0de, 0x01);
> > > > +
> > > > +     count =3D 0;
> > > > +     do {
> > > > +             regmap_read(lt9611c->regmap, 0xe0ae, &temp);
> > > > +             usleep_range(1000, 2000);
> > > > +             count++;
> > > > +     } while (count < 100 && temp !=3D 0x01);
> > >
> > > read_poll_timeout()
> > >
> > will use  read_poll_timeout() in the next version.
>
> Or a more suitable definition from <linux/iopoll.h>. Please check those
> and find the most suitable.
>
I think regmap_read_poll_timeout is more suitable here.

> >
> >  > > +
> > > > +     if (temp !=3D 0x01)
> > > > +             return -1;
> > >
> > > -ETIMEDOUT
> > >
> > return value of -1 means the chip did not receive the operation to
> > write 0x01 to 0xE0DE.
> > Below:
> >      if (temp !=3D 0x02)
> >             return -2;
> > means the chip did not receive the operation to write 0x02 to 0xE0DE.
> >
> > -1 and -2 help us determine where in the code the error occurred.
> > If both return -ETIMEDOUT, it would be less friendly for debugging
> > when we encounter issues.
>
> Inside the kernel it is expected to use drm_dbg instead of returning a
> case-specific return codes.
>
it will be fixed in next version


> > Please confirm whether I should change all of them to return -ETIMEDOUT=
.
>
> Yes
>
> > > > +
> > > > +static int lt9611c_hdmi_clear_audio_infoframe(struct drm_bridge *b=
ridge)
> > > > +{
> > > > +     return 0;
> > >
> > > Hmm? What if we need to clear the infoframe?
> > >
> > don't need to clear the infoframe.
> >
> > can remove.
>
> No. We need to be able to stop sending the infoframe. Please implement
> those.
>
it will be fixed in next version.

> >
> > > > +
> > > > +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
> > > > +                                   struct drm_connector *connector=
,
> > > > +                                   struct hdmi_codec_daifmt *fmt,
> > > > +                                   struct hdmi_codec_params *hparm=
s)
> > > > +{
> > > > +     struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> > > > +     u8 audio_cmd[6] =3D {0x57, 0x48, 0x36, 0x3a};
> > > > +     u8 data[5];
> > > > +     int ret;
> > > > +
> > > > +     /* Validate sample rate and width (LT9611C auto-detects but w=
e still check) */
> > >
> > > What for? You don't trust ASoC / ALSA core that the rates would match
> > > HDMI_RATES?
> >
> > Chip has limitations on sample_rate, sample_width, and fmt, and cannot
> > support all formats.
> > The validation here is to ensure that only the formats supported by
> > the chip are used.
>
> Again, for sample rates, is it different from HDMI_RATES? If not, it is
> useless protective coding.
>

I checked the definition of HDMI_RATES and ended up doing a redundant
validation.

#define HDMI_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |\
SNDRV_PCM_RATE_192000)

However, if HDMI_RATES is extended in the future to include sample
rate not supported by LT9611C, this driver would require corresponding
updates.
If this is not expected to happen, I can remove the redundant check.

> > >
> > > > +     switch (hparms->sample_rate) {
> > > > +     case 32000:
> > > > +     case 44100:
> > > > +     case 48000:
> > > > +     case 88200:
> > > > +     case 96000:
> > > > +     case 176400:
> > > > +     case 192000:
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     switch (hparms->sample_width) {
> > > > +     case 16:
> > > > +     case 18:
> > > > +     case 20:
> > > > +     case 24:
> > >
> > > and no support for 32?
> > >
> > no support for 32
>
> Then check for that rather than listing all the widths. If you check the
> hdmi-codec, you can't get 18-bit samples at all.
>
You are right, there is no 18-bit support.

same reason with sample rate.

> > > > +MODULE_LICENSE("GPL v2");
> > >
> > >
> > > I think, checkpatch.pl should have flagged this.
> > >
> > yes,  it is need use GPL?
>
> If it flagged the line, why didn't you fix it? What did checkpatch say?
>
Sorry, it is my mistake. i will fix.
checkpatch say:
WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db
("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#1450: FILE: drivers/gpu/drm/bridge/lontium-lt9611c.c:1364:


> > I see that many of the latest code still use GPL v2.
>
> --
> With best wishes
> Dmitry
