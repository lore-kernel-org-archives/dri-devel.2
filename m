Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CADDF327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FC510EB8A;
	Tue, 21 Apr 2026 07:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=q-lab.dev header.i=@q-lab.dev header.b="HDfzC4N0";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="aHwGW4lb";
	dkim-atps=neutral
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDFB10E02E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 05:06:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=HDfzC4N0VT+Sxnn9fhyCLBnQRawPkFp9LVpgYN/Y7Q74pMs8BDDlIPq1EAjnUYj7gQ2KZsraNdzKqHZg/PIAd/SHxecCQAaWs6XTi0cLBPPJVKAO1BXXNb1IAWDR5xEOl4Ztbx3istVy/nuH2lu/XctlfiQqMjC17XVqy3Gb1GRNbvsxELcloc+d822oYGuQtgd0qWryKelWkbwXHyUuVMjQY1VfjfJb9wzwge7f4B4+49MXWVnjGTeCB+3U7flWY/RF4sGWPB23ftWLJFUNFjXyjiZbMNysZ7pd1AKFKdDKiHTiMoFR1rEF+RTxL+mRdwPcyhZUyvp9JxGokr8row==;
 s=purelymail1; d=q-lab.dev; v=1;
 bh=93jk/Iv73K4c2TdiyrlEwAW0W+0rTRjSIBxyGj+XH3Q=;
 h=Received:Date:Subject:To:From; 
DKIM-Signature: a=rsa-sha256;
 b=aHwGW4lbQdBzEI6RcHKf5cvnw9hpbGiQuxZJre7FLMQKSSfsCmftxi5tP7b9FFruEU+w6DP24AjpI1JUchGTwDC9vwFZBAaWkXwsbEGZoZs+L/ZXrhWOg5QNqlnjmUFGKqQ+GEN3bm+fhEI7gEojY5Ig7Dc7fBSmKgQn3guyL1L94KDmEvpEpl1yZZH1p/th4Ot+2zRXiem11akGKQqt9KxGbJ3PQlkUtiQc2jriYWkAFxTtXLTAGbsxtVn2DYPTCC++Gwun1jDLCw/0v0b0KfWQlQG61bZVh5t5GXT9nskgs2OeU74KuXL8WNSYjQpRVrPVVRjQK+jbN1BRQf8i4g==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=93jk/Iv73K4c2TdiyrlEwAW0W+0rTRjSIBxyGj+XH3Q=;
 h=Feedback-ID:Received:Date:Subject:To:From; 
Feedback-ID: 284201:25281:null:purelymail
X-Pm-Original-To: dri-devel@lists.freedesktop.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1011416591; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 20 Apr 2026 05:06:02 +0000 (UTC)
Message-ID: <f9753cfc-bfe1-4256-af35-0f262a4e8b81@q-lab.dev>
Date: Sun, 19 Apr 2026 22:05:59 -0700
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 2/2] drm/bridge: Add LT7911EXC edp to mipi bridge driver
To: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-3-syyang@lontium.com>
Content-Language: en-US
From: Quentin Freimanis <quentin@q-lab.dev>
In-Reply-To: <20260420023354.1192642-3-syyang@lontium.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
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

On 2026-04-19 7:33 p.m., syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
>=20
> LT7911EXC is a high performance  eDP1.4 to MIPI chip for
> VR/Display application.
>=20
> -eDP1.4Receiver
>   1.Support SSC

s/1.Support/1. Supports/

>   2.Support 1/2/4 lanes
>   3.Support up to 4K@60HzRGB/YCbCr4:4:48bpc
>   4.Support lane swap and PN swap

Same for these

>=20
> -MIPI Transmitter
>   1.CompliantwithD-PHY1.2&DSI1.1&CSI-22.0=EF=BC=9B1 clock lane,
>     and1/2/3/4 configurable data lanes:2.5Gbpsperdatalane
>   2.CompliantwithC-PHY1.0&DSI-21.0&CSI-22.0;
>     1/2/3 configurable data trio=EF=BC=9B2.5Gsps perdatatrio
>   3.Support1/2configurable ports
>   4.DSISupport16/20/24-bit YCbCr4:2:2,16/18/24/30-bit RGB

Missing spaces, this is hard to read and needs to be cleaned up

>=20
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>   drivers/gpu/drm/bridge/Kconfig             |  18 +
>   drivers/gpu/drm/bridge/Makefile            |   1 +
>   drivers/gpu/drm/bridge/lontium-lt7911exc.c | 571 +++++++++++++++++++++
>   3 files changed, 590 insertions(+)
>   create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
>=20
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index c3209b0f4678..bae8cdaea666 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -202,6 +202,24 @@ config DRM_LONTIUM_LT8713SX
>   =09  to 3 configurable Type-C/DP1.4/HDMI2.0 outputs
>   =09  Please say Y if you have such hardware.
>  =20
> +config DRM_LONTIUM_LT9611C
> +=09tristate "Lontium LT9611C DSI/HDMI bridge"
> +=09select SND_SOC_HDMI_CODEC if SND_SOC
> +=09depends on OF
> +=09select CRC8
> +=09select FW_LOADER
> +=09select DRM_PANEL_BRIDGE
> +=09select DRM_KMS_HELPER
> +=09select DRM_MIPI_DSI
> +=09select DRM_DISPLAY_HELPER
> +=09select DRM_DISPLAY_HDMI_STATE_HELPER
> +=09select REGMAP_I2C
> +=09help
> +=09  Driver for Lontium DSI to HDMI bridge
> +=09  chip driver that converts dual DSI and I2S to
> +=09  HDMI signals
> +=09  Please say Y if you have such hardware.
> +
>   config DRM_ITE_IT66121
>   =09tristate "ITE IT66121 HDMI bridge"
>   =09depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Mak=
efile
> index beab5b695a6e..54b293d1663e 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9211) +=3D lontium-lt9211.o
>   obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
>   obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
>   obj-$(CONFIG_DRM_LONTIUM_LT8713SX) +=3D lontium-lt8713sx.o
> +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) +=3D lontium-lt7911exc.o
>   obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
>   obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) +=3D megachips-stdpxx=
xx-ge-b850v3-fw.o
>   obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) +=3D microchip-lvds.o
> diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm=
/bridge/lontium-lt7911exc.c
> new file mode 100644
> index 000000000000..d1c1d9e073ef
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> @@ -0,0 +1,571 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> + */
> +
> +#include <linux/crc32.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <drm/drm_of.h>
> +
> +#define FW_SIZE (64 * 1024)
> +#define LT_PAGE_SIZE 32
> +#define FW_FILE  "LT7911EXC.bin"

Other lontium bridge chips use lowercase and a _fw.bin suffix, such as=20
"lt9611uxc_fw.bin". Rename to be consistent

> +#define LT7911EXC_PAGE_CONTROL 0xff
> +
> +struct lt7911exc {
> +=09struct device *dev;
> +=09struct i2c_client *client;
> +=09struct drm_bridge bridge;
> +=09struct drm_bridge *panel_bridge;
> +=09struct regmap *regmap;
> +=09/* Protects all accesses to registers by stopping the on-chip MCU */
> +=09struct mutex ocm_lock;
> +=09struct regulator_bulk_data supplies[2];
> +
> +=09struct gpio_desc *reset_gpio;
> +=09const struct firmware *fw;
> +=09int fw_version;
> +=09u32 fw_crc;
> +
> +=09bool enabled;
> +};
> +
> +static const struct regmap_range_cfg lt7911exc_ranges[] =3D {
> +=09{
> +=09=09.name =3D "register_range",
> +=09=09.range_min =3D  0,
> +=09=09.range_max =3D 0xffff,
> +=09=09.selector_reg =3D LT7911EXC_PAGE_CONTROL,
> +=09=09.selector_mask =3D 0xff,
> +=09=09.selector_shift =3D 0,
> +=09=09.window_start =3D 0,
> +=09=09.window_len =3D 0x100,
> +=09},
> +};
> +
> +static const struct regmap_config lt7911exc_regmap_config =3D {
> +=09.reg_bits =3D 8,
> +=09.val_bits =3D 8,
> +=09.max_register =3D 0xffff,
> +=09.ranges =3D lt7911exc_ranges,
> +=09.num_ranges =3D ARRAY_SIZE(lt7911exc_ranges),
> +};
> +
> +static u32 cal_crc32_custom(const u8 *data, u64 length)
> +{
> +=09u32 crc =3D 0xffffffff;
> +=09u8 buf[4];
> +=09u64 i;
> +
> +=09for (i =3D 0; i < length; i +=3D 4) {
> +=09=09buf[0] =3D data[i + 3];
> +=09=09buf[1] =3D data[i + 2];
> +=09=09buf[2] =3D data[i + 1];
> +=09=09buf[3] =3D data[i + 0];
> +=09=09crc =3D crc32_be(crc, buf, 4);
> +=09=09}
> +
> +=09return crc;
> +}
> +
> +static inline struct lt7911exc *
> +=09=09bridge_to_lt7911exc(struct drm_bridge *bridge)
> +{
> +=09return container_of(bridge, struct lt7911exc, bridge);
> +}
> +
> +static int lt7911exc_regulator_enable(struct lt7911exc *lt7911exc)
> +{
> +=09int ret;
> +
> +=09ret =3D regulator_enable(lt7911exc->supplies[0].consumer);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09usleep_range(5000, 10000);
> +
> +=09ret =3D regulator_enable(lt7911exc->supplies[1].consumer);
> +=09if (ret < 0) {
> +=09=09regulator_disable(lt7911exc->supplies[0].consumer);
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int lt7911exc_regulator_disable(struct lt7911exc *lt7911exc)
> +{
> +=09int ret;
> +
> +=09ret =3D regulator_disable(lt7911exc->supplies[1].consumer);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09ret =3D regulator_disable(lt7911exc->supplies[0].consumer);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09return 0;
> +}
> +
> +static void lt7911exc_reset(struct lt7911exc *lt7911exc)
> +{
> +=09gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> +=09msleep(20);
> +
> +=09gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> +=09msleep(20);
> +
> +=09gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
> +=09msleep(400);
> +
> +=09dev_dbg(lt7911exc->dev, "lt7911exc reset");

missing newline in dev_dbg(), all other calls have it.

> +}
> +
> +static int lt7911exc_parse_dt(struct lt7911exc *lt7911exc)
> +{
> +=09int ret;
> +
> +=09lt7911exc->supplies[0].supply =3D "vcc";
> +=09lt7911exc->supplies[1].supply =3D "vdd";
> +
> +=09ret =3D devm_regulator_bulk_get(lt7911exc->dev, 2, lt7911exc->supplie=
s);
> +=09if (ret) {
> +=09=09dev_err(lt7911exc->dev, "failed get regulator\n");
> +=09=09return ret;
> +=09}
> +
> +=09lt7911exc->reset_gpio =3D devm_gpiod_get(lt7911exc->dev, "reset", GPI=
OD_OUT_LOW);
> +=09if (IS_ERR(lt7911exc->reset_gpio)) {
> +=09=09dev_err(lt7911exc->dev, "failed to acquire reset gpio\n");
> +=09=09return PTR_ERR(lt7911exc->reset_gpio);
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int lt7911exc_read_version(struct lt7911exc *lt7911exc)
> +{
> +=09u8 buf[2];
> +=09int ret;
> +
> +=09ret =3D regmap_bulk_read(lt7911exc->regmap, 0xe081, buf, 3);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return (buf[0] << 16) | (buf[1] << 8) | buf[2];
> +}
> +
> +static void lt7911exc_lock(struct lt7911exc *lt7911exc)
> +{
> +=09mutex_lock(&lt7911exc->ocm_lock);
> +=09regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
> +}
> +
> +static void lt7911exc_unlock(struct lt7911exc *lt7911exc)
> +{
> +=09regmap_write(lt7911exc->regmap, 0xe0ee, 0x00);
> +=09mutex_unlock(&lt7911exc->ocm_lock);
> +}
> +
> +static int lt7911exc_prepare_firmware_data(struct lt7911exc *lt7911exc)
> +{
> +=09struct device *dev =3D lt7911exc->dev;
> +=09int ret;
> +=09u8 *buffer;
> +=09size_t total_size =3D FW_SIZE - 4;
> +
> +=09ret =3D request_firmware(&lt7911exc->fw, FW_FILE, dev);
> +=09if (ret) {
> +=09=09dev_err(dev, "failed load file '%s', error type %d\n", FW_FILE, re=
t);
> +=09=09return ret;
> +=09}
> +
> +=09if (lt7911exc->fw->size > total_size) {
> +=09=09dev_err(dev, "firmware too large (%zu > %zu)\n", lt7911exc->fw->si=
ze, total_size);
> +=09=09release_firmware(lt7911exc->fw);
> +=09=09lt7911exc->fw =3D NULL;
> +=09=09return -EINVAL;
> +=09}
> +
> +=09dev_dbg(dev, "firmware size: %zu bytes\n", lt7911exc->fw->size);
> +
> +=09buffer =3D kzalloc(total_size, GFP_KERNEL);
> +=09if (!buffer) {
> +=09=09release_firmware(lt7911exc->fw);
> +=09=09lt7911exc->fw =3D NULL;
> +=09=09return -ENOMEM;
> +=09}
> +
> +=09memset(buffer, 0xff, total_size);
> +=09memcpy(buffer, lt7911exc->fw->data, lt7911exc->fw->size);
> +
> +=09lt7911exc->fw_crc =3D cal_crc32_custom(buffer, total_size);
> +=09dev_dbg(dev, "firmware crc: 0x%08x\n", lt7911exc->fw_crc);
> +
> +=09kfree(buffer);
> +=09return 0;
> +}
> +
> +static void lt7911exc_block_erase(struct lt7911exc *lt7911exc)
> +{
> +=09struct device *dev =3D lt7911exc->dev;
> +=09const u32 addr =3D 0x00;
> +
> +=09const struct reg_sequence seq_write[] =3D {
> +=09=09REG_SEQ0(0xe0ee, 0x01),
> +=09=09REG_SEQ0(0xe054, 0x01),
> +=09=09REG_SEQ0(0xe055, 0x06),
> +=09=09REG_SEQ0(0xe051, 0x01),
> +=09=09REG_SEQ0(0xe051, 0x00),
> +=09=09REG_SEQ0(0xe054, 0x05),
> +=09=09REG_SEQ0(0xe055, 0xd8),
> +=09=09REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
> +=09=09REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
> +=09=09REG_SEQ0(0xe05c, addr & 0xff),
> +=09=09REG_SEQ0(0xe051, 0x01),
> +=09=09REG_SEQ0(0xe050, 0x00),
> +=09};
> +
> +=09regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE(seq_w=
rite));
> +
> +=09msleep(200);
> +=09dev_dbg(dev, "erase flash done.\n");
> +}
> +
> +static void lt7911exc_prog_init(struct lt7911exc *lt7911exc, u64 addr)
> +{
> +=09const struct reg_sequence seq_write[] =3D {
> +=09=09REG_SEQ0(0xe0ee, 0x01),
> +=09=09REG_SEQ0(0xe05f, 0x01),
> +=09=09REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
> +=09=09REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
> +=09=09REG_SEQ0(0xe05c, addr & 0xff),
> +=09};
> +
> +=09regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE(seq_w=
rite));
> +}
> +
> +static int lt7911exc_write_data(struct lt7911exc *lt7911exc, u64 addr)
> +{
> +=09struct device *dev =3D lt7911exc->dev;
> +=09int ret;
> +=09int page =3D 0, num =3D 0, page_len =3D 0;
> +=09u64 size, offset;
> +=09const u8 *data;
> +
> +=09data =3D lt7911exc->fw->data;
> +=09size =3D lt7911exc->fw->size;
> +=09page =3D (size + LT_PAGE_SIZE - 1) / LT_PAGE_SIZE;
> +=09if (page * LT_PAGE_SIZE > FW_SIZE) {
> +=09=09dev_err(dev, "firmware size out of range\n");
> +=09=09return -EINVAL;
> +=09}
> +
> +=09dev_dbg(dev, "%u pages, total size %llu byte\n", page, size);
> +
> +=09for (num =3D 0; num < page; num++) {
> +=09=09offset =3D num * LT_PAGE_SIZE;
> +=09=09page_len =3D (offset + LT_PAGE_SIZE <=3D size) ? LT_PAGE_SIZE : (s=
ize - offset);
> +=09=09lt7911exc_prog_init(lt7911exc, addr);
> +
> +=09=09ret =3D regmap_raw_write(lt7911exc->regmap, 0xe05d, &data[offset],=
 page_len);
> +=09=09if (ret) {
> +=09=09=09dev_err(dev, "write error at page %d\n", num);
> +=09=09=09return ret;
> +=09=09}
> +
> +=09=09if (page_len < LT_PAGE_SIZE) {
> +=09=09=09regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
> +=09=09=09regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> +=09=09=09//hardware requires delay
> +=09=09=09usleep_range(1000, 2000);
> +=09=09}
> +
> +=09=09regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
> +=09=09addr +=3D LT_PAGE_SIZE;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int lt7911exc_write_crc(struct lt7911exc *lt7911exc, u64 addr)
> +{
> +=09u8 crc[4];
> +=09int ret;
> +
> +=09crc[0] =3D lt7911exc->fw_crc & 0xff;
> +=09crc[1] =3D (lt7911exc->fw_crc >> 8) & 0xff;
> +=09crc[2] =3D (lt7911exc->fw_crc >> 16) & 0xff;
> +=09crc[3] =3D (lt7911exc->fw_crc >> 24) & 0xff;
> +
> +=09regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> +=09regmap_write(lt7911exc->regmap, 0xe05a, (addr >> 16) & 0xff);
> +=09regmap_write(lt7911exc->regmap, 0xe05b, (addr >> 8) & 0xff);
> +=09regmap_write(lt7911exc->regmap, 0xe05c, addr & 0xff);
> +
> +=09ret =3D regmap_raw_write(lt7911exc->regmap, 0xe05d, crc, 4);
> +=09if (ret)
> +=09=09return ret;

nit: Newline here makes it more readable

> +=09regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
> +=09regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
> +=09usleep_range(1000, 2000);
> +=09regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
> +
> +=09return 0;
> +}
> +
> +static int lt7911exc_firmware_upgrade(struct lt7911exc *lt7911exc)
> +{
> +=09struct device *dev =3D lt7911exc->dev;
> +=09int ret;
> +
> +=09ret =3D lt7911exc_prepare_firmware_data(lt7911exc);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09dev_dbg(dev, "starting firmware upgrade, size: %zu bytes\n", lt7911ex=
c->fw->size);
> +
> +=09lt7911exc_block_erase(lt7911exc);
> +
> +=09ret =3D lt7911exc_write_data(lt7911exc, 0);
> +=09if (ret < 0) {
> +=09=09dev_err(dev, "failed to write firmware data\n");
> +=09=09return ret;
> +=09}
> +
> +=09release_firmware(lt7911exc->fw);
> +=09lt7911exc->fw =3D NULL;
> +
> +=09ret =3D lt7911exc_write_crc(lt7911exc, FW_SIZE - 4);
> +=09if (ret < 0) {
> +=09=09dev_err(dev, "failed to write firmware crc\n");
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int lt7911exc_upgrade_result(struct lt7911exc *lt7911exc)
> +{
> +=09struct device *dev =3D lt7911exc->dev;
> +=09u32 read_hw_crc =3D 0;
> +=09u8 crc_tmp[4];
> +=09int ret;
> +
> +=09regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
> +=09regmap_write(lt7911exc->regmap, 0xe07b, 0x60);
> +=09regmap_write(lt7911exc->regmap, 0xe07b, 0x40);
> +=09msleep(150);
> +=09ret =3D regmap_bulk_read(lt7911exc->regmap, 0x22, crc_tmp, 4);
> +=09if (ret) {
> +=09=09dev_err(lt7911exc->dev, "Failed to read CRC: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09read_hw_crc =3D crc_tmp[0] << 24 | crc_tmp[1] << 16 |
> +=09=09=09=09crc_tmp[2] << 8 | crc_tmp[3];
> +
> +=09if (read_hw_crc !=3D lt7911exc->fw_crc) {
> +=09=09dev_err(dev, "lt7911exc firmware upgrade failed, expected CRC=3D0x=
%08x, read CRC=3D0x%08x\n",
> +=09=09=09lt7911exc->fw_crc, read_hw_crc);
> +=09=09return -EIO;
> +=09}
> +
> +=09dev_dbg(dev, "lt7911exc firmware upgrade success, CRC=3D0x%08x\n", re=
ad_hw_crc);
> +=09return 0;
> +}
> +
> +static void lt7911exc_pre_enable(struct drm_bridge *bridge)
> +{
> +=09struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> +=09int ret;
> +
> +=09if (lt7911exc->enabled)
> +=09=09return;
> +
> +=09ret =3D lt7911exc_regulator_enable(lt7911exc);
> +=09if (ret)
> +=09=09return;
> +
> +=09lt7911exc_reset(lt7911exc);
> +
> +=09lt7911exc->enabled =3D true;
> +}
> +
> +static void lt7911exc_disable(struct drm_bridge *bridge)
> +{
> +=09/* Delay after panel is disabled */
> +=09msleep(20);
> +}
> +
> +static void lt7911exc_post_disable(struct drm_bridge *bridge)
> +{
> +=09struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> +=09int ret;
> +
> +=09if (!lt7911exc->enabled)
> +=09=09return;
> +
> +=09lt7911exc->enabled =3D false;
> +
> +=09ret =3D lt7911exc_regulator_disable(lt7911exc);
> +=09if (ret)
> +=09=09return;
> +
> +=09gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
> +}
> +
> +static int lt7911exc_attach(struct drm_bridge *bridge,
> +=09=09=09    struct drm_encoder *encoder,
> +=09=09=09    enum drm_bridge_attach_flags flags)
> +{
> +=09struct lt7911exc *lt7911exc =3D bridge_to_lt7911exc(bridge);
> +
> +=09return drm_bridge_attach(lt7911exc->bridge.encoder, lt7911exc->panel_=
bridge,
> +=09=09=09=09 &lt7911exc->bridge, flags);
> +}
> +
> +static const struct drm_bridge_funcs lt7911exc_bridge_funcs =3D {
> +=09.pre_enable =3D lt7911exc_pre_enable,
> +=09.disable =3D lt7911exc_disable,
> +=09.post_disable =3D lt7911exc_post_disable,

These are all deprecated, is there any reason to use them and not the=20
atomic_* callbacks?

> +=09.attach =3D lt7911exc_attach,
> +};
> +
> +static int lt7911exc_probe(struct i2c_client *client)
> +{
> +=09struct device *dev =3D &client->dev;
> +=09struct lt7911exc *lt7911exc;
> +=09struct drm_bridge *panel_bridge;
> +=09bool fw_updated =3D false;
> +=09int ret;
> +
> +=09if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +=09=09dev_err(dev, "device doesn't support I2C\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09lt7911exc =3D devm_drm_bridge_alloc(dev, struct lt7911exc, bridge,
> +=09=09=09=09=09  &lt7911exc_bridge_funcs);
> +=09if (IS_ERR(lt7911exc))
> +=09=09return PTR_ERR(lt7911exc);
> +
> +=09panel_bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
> +=09if (IS_ERR(panel_bridge))
> +=09=09return PTR_ERR(panel_bridge);
> +
> +=09lt7911exc->panel_bridge =3D panel_bridge;
> +=09lt7911exc->client =3D client;
> +=09lt7911exc->dev =3D dev;
> +=09i2c_set_clientdata(client, lt7911exc);
> +=09mutex_init(&lt7911exc->ocm_lock);
> +
> +=09lt7911exc->regmap =3D devm_regmap_init_i2c(client, &lt7911exc_regmap_=
config);
> +=09if (IS_ERR(lt7911exc->regmap)) {
> +=09=09dev_err(dev, "regmap i2c init failed\n");
> +=09=09return PTR_ERR(lt7911exc->regmap);
> +=09}
> +
> +=09ret =3D lt7911exc_parse_dt(lt7911exc);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D lt7911exc_regulator_enable(lt7911exc);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09lt7911exc_reset(lt7911exc);
> +=09lt7911exc->enabled =3D true;
> +=09lt7911exc_lock(lt7911exc);
> +
> +retry:
> +=09lt7911exc->fw_version =3D lt7911exc_read_version(lt7911exc);
> +=09if (lt7911exc->fw_version < 0) {
> +=09=09dev_err(dev, "failed to read FW version\n");
> +=09=09lt7911exc_unlock(lt7911exc);
> +=09=09goto err_disable_regulators;
> +
> +=09} else if (lt7911exc->fw_version =3D=3D 0) {
> +=09=09if (!fw_updated) {
> +=09=09=09fw_updated =3D true;
> +=09=09=09ret =3D lt7911exc_firmware_upgrade(lt7911exc);
> +=09=09=09if (ret < 0) {
> +=09=09=09=09lt7911exc_unlock(lt7911exc);
> +=09=09=09=09goto err_disable_regulators;
> +=09=09=09}
> +
> +=09=09=09lt7911exc_reset(lt7911exc);
> +
> +=09=09=09ret =3D lt7911exc_upgrade_result(lt7911exc);
> +=09=09=09if (ret < 0) {
> +=09=09=09=09lt7911exc_unlock(lt7911exc);
> +=09=09=09=09goto err_disable_regulators;
> +=09=09=09}
> +
> +=09=09=09goto retry;
> +
> +=09=09} else {
> +=09=09=09dev_err(dev, "fw version 0x%04x, update failed\n", lt7911exc->f=
w_version);
> +=09=09=09ret =3D -EOPNOTSUPP;
> +=09=09=09lt7911exc_unlock(lt7911exc);
> +=09=09=09goto err_disable_regulators;
> +=09=09}
> +=09}
> +
> +=09lt7911exc_unlock(lt7911exc);
> +
> +=09lt7911exc->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
> +=09lt7911exc->bridge.of_node =3D dev->of_node;
> +=09drm_bridge_add(&lt7911exc->bridge);
> +
> +=09return 0;
> +
> +err_disable_regulators:
> +=09regulator_bulk_disable(ARRAY_SIZE(lt7911exc->supplies), lt7911exc->su=
pplies);
> +=09if (lt7911exc->fw) {
> +=09=09release_firmware(lt7911exc->fw);
> +=09=09lt7911exc->fw =3D NULL;
> +=09}
> +
> +=09return ret;
> +}
> +
> +static void lt7911exc_remove(struct i2c_client *client)
> +{
> +=09struct lt7911exc *lt7911exc =3D i2c_get_clientdata(client);
> +
> +=09drm_bridge_remove(&lt7911exc->bridge);
> +=09mutex_destroy(&lt7911exc->ocm_lock);
> +}
> +
> +static const struct i2c_device_id lt7911exc_i2c_table[] =3D {
> +=09{"lontium, lt7911exc", 0},

Extra space here in the device id

> +=09{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
> +
> +static const struct of_device_id lt7911exc_devices[] =3D {
> +=09{.compatible =3D "lontium,lt7911exc",},
> +=09{}
> +};
> +MODULE_DEVICE_TABLE(of, lt7911exc_devices);
> +
> +static struct i2c_driver lt7911exc_driver =3D {
> +=09.id_table=09=3D lt7911exc_i2c_table,
> +=09.probe=09=09=3D lt7911exc_probe,
> +=09.remove=09=09=3D lt7911exc_remove,
> +=09.driver=09=09=3D {
> +=09=09.name=09=3D "lt7911exc",
> +=09=09.of_match_table =3D lt7911exc_devices,
> +=09},
> +};
> +module_i2c_driver(lt7911exc_driver);
> +
> +MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
> +MODULE_DESCRIPTION("Lontium lt7911exc edp to mipi dsi bridge driver");
> +MODULE_LICENSE("GPL v2");

