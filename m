Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BA7C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3463210E194;
	Wed, 15 Jul 2026 12:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LAgfM15h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA83110E194
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:24:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB19D6001A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815E41F00A3A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784118271;
 bh=PclXy2Uq7OPMyI+t/qU2+B3wDB55fTcxu4iOX0BaM3I=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=LAgfM15hhVaC15vSj8XQxsRNvGquqsgUOdks7kt343R7a1N5g9nUkhGh/uXHD9xfk
 nHuL0dFcxgvuhWFebeKG/ml37YscroM+LGpmg6vTy/NYhLFGJkXcxF49V5NileYc42
 yFcBl+s67bzQ7PDTJyhysHWIH3tWgPuHTNtr9YG4smlEOxhmeOTfhh5daJaeq0q4VC
 dVM8Wgqjwvx9UaMSkun0m/2IJKP0e4vLDNXe4PMhRzEKFuvISWLu21N/04zi2Ia3kf
 EMfQpJbcuN8aNGEmfLMx1xjXLy5cpYICzJI1CA7lIsIjNYsegE++dezSLCFahJvia/
 vzzxugae/c9Fg==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5aec6360133so4116322e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 05:24:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoNa/v67iDl7QaaLsnVJkxizMzLR3RKpxxgYrLfWXDYcH/ccvByeIeBkXMm4koLEutsqtNis5B+M/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIXFf1is0Uo6EuT27DLdsj+kFdCtTftAKm3OOtU1KYBhq9T+ki
 Q/u6TXxL5MbpIRgVWLyP0GB/LGI7m7P4ckZ5WrmsIBaOszyRsWrzwFEAZDmeHXL4G5i1KmF8yWe
 D4yqE83FKJry2c4CsqsPJ4jOGs+zoJcvXGVUIlriikg==
X-Received: by 2002:a05:6512:3a87:b0:5b0:12e1:4879 with SMTP id
 2adb3069b0e04-5b1582c715emr2068822e87.60.1784118270190; Wed, 15 Jul 2026
 05:24:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:24:27 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:24:27 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
MIME-Version: 1.0
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-2-76e5e41026db@advantech.com>
Date: Wed, 15 Jul 2026 05:24:27 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mcnbv++YhPvocyiv9m_vuy2hWeuJ2sk9BNH=j7U3-dBFQ@mail.gmail.com>
X-Gm-Features: AUfX_mzXdlShUuByf9jSWwdYpIzB9dN3xsnMMdNBfJC8EmPDXbPafGgehOl5DxQ
Message-ID: <CAMRc=Mcnbv++YhPvocyiv9m_vuy2hWeuJ2sk9BNH=j7U3-dBFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Add Advantech EIO GPIO driver
To: Ramiro Oliveira <ramiro.oliveira@advantech.com>
Cc: linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-pm@vger.kernel.org, Wenkai Chung <wenkai.chung@advantech.com.tw>, 
 Francisco Aragon-Trivino <francisco.aragon-trivino@advantech.com>, 
 Hongzhi Wang <hongzhi.wang@advantech.com>, 
 Mikhail Tsukerman <mikhail.tsukerman@advantech.com>, 
 Thomas Kastner <thomas.kastner@advantech.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, 
 Andi Shyti <andi.shyti@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 14 Jul 2026 17:54:16 +0200, Ramiro Oliveira
<ramiro.oliveira@advantech.com> said:
> This driver controls the GPIO component of the Advantech EIO chip.
>

The subject should be: "gpio: add a driver for the Advantech EIO GPIO
controller"
or similar.

> Signed-off-by: Ramiro Oliveira <ramiro.oliveira@advantech.com>
> ---
>  MAINTAINERS             |   7 ++
>  drivers/gpio/Kconfig    |   6 ++
>  drivers/gpio/Makefile   |   1 +
>  drivers/gpio/gpio-eio.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 266 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 53b5f7412966..a7da47393815 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -609,6 +609,13 @@ S:	Maintained
>  F:	Documentation/scsi/advansys.rst
>  F:	drivers/scsi/advansys.c
>
> +ADVANTECH EIO DRIVER
> +M:	Ramiro Oliveira <ramiro.oliveira@advantech.com>
> +S:	Maintained
> +F:	drivers/gpio/gpio-eio.c
> +F:	drivers/mfd/eio_core.c
> +F:	include/linux/mfd/eio.h

Shouldn't this be part of the MFD entry?

> +
>  ADVANTECH SWBTN DRIVER
>  M:	Andrea Ho <Andrea.Ho@advantech.com.tw>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index f03c05288376..696065d77235 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -295,6 +295,12 @@ config GPIO_DWAPB
>  	  Say Y or M here to build support for the Synopsys DesignWare APB
>  	  GPIO block.
>
> +config GPIO_EIO
> +	tristate "Advantech EIO GPIO"
> +	depends on MFD_EIO
> +	help
> +	  Say Y or M to build support for Advantech EIO GPIO block.
> +
>  config GPIO_EIC_SPRD
>  	tristate "Spreadtrum EIC support"
>  	depends on ARCH_SPRD || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index fa14581e3995..628596705c21 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
>  obj-$(CONFIG_GPIO_DS4520)		+= gpio-ds4520.o
>  obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
>  obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
> +obj-$(CONFIG_GPIO_EIO)			+= gpio-eio.o
>  obj-$(CONFIG_GPIO_ELKHARTLAKE)		+= gpio-elkhartlake.o
>  obj-$(CONFIG_GPIO_EM)			+= gpio-em.o
>  obj-$(CONFIG_GPIO_EN7523)		+= gpio-en7523.o
> diff --git a/drivers/gpio/gpio-eio.c b/drivers/gpio/gpio-eio.c
> new file mode 100644
> index 000000000000..34e1aefd0716
> --- /dev/null
> +++ b/drivers/gpio/gpio-eio.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * GPIO driver for Advantech EIO Embedded controller.
> + *
> + * Copyright (C) 2025 Advantech Corporation. All rights reserved.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/eio.h>
> +#include <linux/module.h>
> +
> +#define EIO_GPIO_MAX_PINS	48
> +#define EIO_GPIO_WRITE		0x18
> +#define EIO_GPIO_READ		0x19
> +
> +struct eio_gpio_dev {
> +	u64 avail;
> +	int max;
> +	struct gpio_chip chip;
> +	struct device *dev;
> +};
> +
> +static struct {
> +	int size;
> +	bool write;
> +} ctrl_para[] = {

Please use a common prefix for all symbols. "eio_gpio" like above is fine.

> +	{ 0x01, false }, { 0x00, false }, { 0x00, false }, { 0x02, false },
> +	{ 0x01, false }, { 0x00, false }, { 0x00, false }, { 0x00, false },
> +	{ 0x00, false }, { 0x00, false }, { 0x00, false }, { 0x00, false },
> +	{ 0x00, false }, { 0x00, false }, { 0x00, false }, { 0x00, false },
> +	{ 0x01, true  }, { 0x01, true  }, { 0x02, true  }, { 0x02, true  },
> +	{ 0x02, false }, { 0x10, false }
> +};
> +
> +enum gpio_ctrl {
> +	EIO_GPIO_STATUS = 0x0,
> +	EIO_GPIO_GROUP_AVAIL = 0x3,
> +	EIO_GPIO_ERROR = 0x04,
> +	EIO_GPIO_PIN_DIR = 0x10,
> +	EIO_GPIO_PIN_LEVEL = 0x11,
> +	EIO_GPIO_GROUP_DIR = 0x12,
> +	EIO_GPIO_GROUP_LEVEL = 0x13,
> +	EIO_GPIO_MAPPING = 0x14,
> +	EIO_GPIO_NAME = 0x15
> +};
> +
> +static struct {
> +	int group;
> +	int port;
> +} group_map[] = {
> +	{ 0, 0 }, { 0, 1 },
> +	{ 1, 0 }, { 1, 1 },
> +	{ 2, 0 }, { 2, 1 },
> +	{ 3, 0 }, { 3, 1 },
> +	{ 3, 2 }, { 3, 3 },
> +	{ 3, 4 }, { 3, 5 },
> +	{ 3, 6 }, { 3, 7 }
> +};
> +
> +static int pmc_write(struct device *mfd_dev, u8 ctrl, u8 dev_id, void *data)
> +{
> +	struct pmc_op op = {
> +		 .cmd       = EIO_GPIO_WRITE,
> +		 .control   = ctrl,
> +		 .device_id = dev_id,
> +		 .payload   = (u8 *)data,
> +	};
> +
> +	if (ctrl >= ARRAY_SIZE(ctrl_para))
> +		return -ENOMEM;
> +
> +	if (!ctrl_para[ctrl].write)
> +		return -EINVAL;
> +
> +	op.size = ctrl_para[ctrl].size;
> +
> +	return eio_core_pmc_operation(mfd_dev, &op);
> +}
> +
> +static int pmc_read(struct device *mfd_dev, u8 ctrl, u8 dev_id, void *data)
> +{
> +	struct pmc_op op = {
> +		 .cmd       = EIO_GPIO_READ,
> +		 .control   = ctrl,
> +		 .device_id = dev_id,
> +		 .payload   = (u8 *)data,
> +	};
> +
> +	if (ctrl > ARRAY_SIZE(ctrl_para))
> +		return -ENOMEM;
> +
> +	op.size = ctrl_para[ctrl].size;
> +
> +	return eio_core_pmc_operation(mfd_dev, &op);
> +}
> +
> +static int get_dir(struct gpio_chip *chip, unsigned int offset)
> +{
> +	u8 dir;
> +	int ret;
> +
> +	ret = pmc_read(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +	if (ret)
> +		return ret;
> +
> +	return dir ? 0 : 1;
> +}
> +
> +static int dir_input(struct gpio_chip *chip, unsigned int offset)
> +{
> +	u8 dir = 0;
> +
> +	return pmc_write(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +}
> +
> +static int dir_output(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +	u8 dir = 1;
> +	u8 val = value;
> +
> +	pmc_write(chip->parent, EIO_GPIO_PIN_DIR, offset, &dir);
> +
> +	return pmc_write(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &val);
> +}
> +
> +static int gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	u8 level;
> +	int ret;
> +
> +	ret = pmc_read(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &level);
> +	if (ret)
> +		return ret;
> +
> +	return level;
> +}
> +
> +static int gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +	u8 val = value;
> +
> +	return pmc_write(chip->parent, EIO_GPIO_PIN_LEVEL, offset, &val);
> +}
> +
> +static int check_support(struct device *dev)
> +{
> +	u8  data;
> +	int ret;
> +
> +	ret = pmc_read(dev, EIO_GPIO_STATUS, 0, &data);
> +	if (ret)
> +		return ret;
> +
> +	if ((data & 0x01) == 0)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int check_pin(struct device *dev, int pin)
> +{
> +	int ret;
> +	int group, bit;

Why not put all ints on the same line? Same elsewhere.

> +	u16 data;
> +
> +	/* Get pin mapping */
> +	ret = pmc_read(dev, EIO_GPIO_MAPPING, pin, &data);
> +	if (ret)
> +		return ret;
> +
> +	if ((data & 0xFF) > ARRAY_SIZE(group_map))
> +		return -EINVAL;
> +
> +	group = group_map[data & 0xFF].group;
> +	bit   = data >> 8;
> +
> +	/* Check mapped pin */
> +	ret = pmc_read(dev, EIO_GPIO_GROUP_AVAIL, group, &data);
> +	if (ret)
> +		return ret;
> +
> +	return data & BIT(bit) ? 0 : -EOPNOTSUPP;
> +}
> +
> +static int gpio_init(struct device *mfd, struct eio_gpio_dev *eio_gpio)
> +{
> +	int ret, i;
> +
> +	ret = check_support(mfd);
> +	if (ret)

This warrants an -ENODEV. We don't want to retry probe here, do we?

> +		return dev_err_probe(eio_gpio->dev, ret, "GPIO not supported\n");
> +
> +	eio_gpio->avail = 0;
> +
> +	for (i = 0 ; i < EIO_GPIO_MAX_PINS ; i++) {
> +		ret = check_pin(mfd, i);
> +		if (ret)
> +			continue;
> +
> +		eio_gpio->avail |= BIT(i);
> +		eio_gpio->max = i + 1;
> +	}
> +
> +	return eio_gpio->max ? 0 : -EOPNOTSUPP;
> +}
> +
> +static int gpio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct eio_gpio_dev *eio_gpio;
> +	struct eio_dev *eio_dev = dev_get_drvdata(dev->parent);
> +
> +	if (!eio_dev)
> +		return dev_err_probe(dev, -ENODEV, "Error contact eio_core\n");

-ENODEV is used for silently bailing out of probe and telling the driver core
to not defer. Basically it means: this device cannot be enabled on this system
or is not present at all. This means: don't use dev_err_probe() and don't emit
any logs. Just return -ENODEV.

Though it makes me think - can this even happen at all? MFD cells won't get
created if parent's probe() failed.

> +
> +	eio_gpio = devm_kzalloc(dev, sizeof(*eio_gpio), GFP_KERNEL);
> +	if (!eio_gpio)
> +		return -ENOMEM;
> +
> +	eio_gpio->dev = dev;
> +
> +	if (gpio_init(dev->parent, eio_gpio))

Can you use the ret = gpio_init() pattern for consistency with the rest of the
code?

> +		return -EIO;
> +
> +	eio_gpio->chip.parent = dev->parent;
> +	eio_gpio->chip.ngpio = eio_gpio->max;
> +	eio_gpio->chip.label = KBUILD_MODNAME;
> +	eio_gpio->chip.owner = THIS_MODULE;
> +	eio_gpio->chip.direction_input = dir_input;
> +	eio_gpio->chip.get = gpio_get;
> +	eio_gpio->chip.direction_output = dir_output;
> +	eio_gpio->chip.set = gpio_set;
> +	eio_gpio->chip.get_direction = get_dir;
> +	eio_gpio->chip.base = -1;
> +	eio_gpio->chip.can_sleep = true;
> +
> +	return devm_gpiochip_add_data(dev, &eio_gpio->chip, eio_gpio);
> +}
> +
> +static struct platform_driver gpio_driver = {
> +	.probe  = gpio_probe,
> +	.driver = { .name = KBUILD_MODNAME, },
> +};
> +
> +module_platform_driver(gpio_driver);
> +
> +MODULE_AUTHOR("Wenkai Chung <wenkai.chung@advantech.com.tw>");
> +MODULE_AUTHOR("Ramiro Oliveira <ramiro.oliveira@advantech.com>");
> +MODULE_DESCRIPTION("GPIO driver for Advantech EIO embedded controller");
> +MODULE_LICENSE("GPL");
>
> --
> 2.43.0
>
>

Bart
