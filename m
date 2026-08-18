Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0202FC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E166C10EA37;
	Tue, 18 Aug 2026 07:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GVn6mRL4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6BD410E204
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:34:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 41EBC4193B;
 Tue, 18 Aug 2026 07:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBF81F000E9;
 Tue, 18 Aug 2026 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787038460;
 bh=G9I4R3jOHLHOfWJOZBAE7WTG/IrAoqeaAXlK3GV6pUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GVn6mRL4S5AirIJhFQ4kWX7K86N66U/C3U5aowt9WbpNJquc5SRBUI8oDBQPSqVU8
 JP2kMNaCBMDUPJrv1rBZGGbP16gpWAedUm7mwqRRF6LgNLdVSRldjHLdFySmP38V8Z
 xb4CacYSummIFJEHa9H9eRIc49TmKlCpZbLb0SNamLv5DxPCi41wJZrnchr3OULa0l
 5hHa5lYNGpX0COHta7RSWUgjIdhUHdNePJ799c/ZV21WyjBVnBp6cXZBpYCMwOnZQm
 74veCqzNS9TXF7VWMHow/VsP/cZGUE8N0+do9mdWxGuE1Q1FzgvEY2/WaLvwwPif4K
 we9z3X6S5zF4A==
Date: Tue, 18 Aug 2026 09:34:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <20260818-crazy-corgi-of-sorcery-abaa23@quoll>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-2-caf95c453c50@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816-ocp8178-backlight-v3-2-caf95c453c50@dewith.io>
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

On Sun, Aug 16, 2026 at 12:57:04PM +0200, Wim de With wrote:
> Add a driver for the Orient Chip OCP8178 backlight controller.
> 
> The OCP8178 supports either PWM or a vendor-specific onewire protocol
> over GPIO. This driver implements the onewire protocol, which enables
> setting static brightness levels without requiring a continuous PWM
> signal from the host CPU. Note that while the vendor calls the protocol
> 1-Wire, it is not the 1-Wire protocol from Dallas Semiconductor as
> implemented in drivers/w1.
> 
> Signed-off-by: Wim de With <wf@dewith.io>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> ---
>  MAINTAINERS                          |   1 +
>  drivers/video/backlight/Kconfig      |  10 ++
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/ocp8178_bl.c | 231 +++++++++++++++++++++++++++++++++++
>  4 files changed, 243 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ca99d9c32ef1..7146e4dea8d78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19682,6 +19682,7 @@ OCP8178 BACKLIGHT DRIVER
>  M:	Wim de With <wf@dewith.io>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> +F:	drivers/video/backlight/ocp8178_bl.c
>  
>  OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
>  M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 7aa1c4b21111f..aa845230c5f58 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -226,6 +226,16 @@ config BACKLIGHT_LOCOMO
>  	  If you have a Sharp Zaurus SL-5500 (Collie) or SL-5600 (Poodle) say y to
>  	  enable the LCD/backlight driver.
>  
> +config BACKLIGHT_OCP8178
> +	tristate "OCP8178 Backlight Driver"
> +	depends on GPIOLIB
> +	help
> +	  If you have an Orient Chip OCP8178, say Y to enable the backlight
> +	  driver.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called ocp8178_bl.
> +
>  config BACKLIGHT_OMAP1
>  	tristate "OMAP1 PWL-based LCD Backlight"
>  	depends on ARCH_OMAP1 || COMPILE_TEST
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index 21c8313cfb121..c4e87b708ae21 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_BACKLIGHT_MAX25014)	+= max25014.o
>  obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
>  obj-$(CONFIG_BACKLIGHT_MP3309C)		+= mp3309c.o
>  obj-$(CONFIG_BACKLIGHT_MT6370)		+= mt6370-backlight.o
> +obj-$(CONFIG_BACKLIGHT_OCP8178)		+= ocp8178_bl.o
>  obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
>  obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
>  obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
> diff --git a/drivers/video/backlight/ocp8178_bl.c b/drivers/video/backlight/ocp8178_bl.c
> new file mode 100644
> index 0000000000000..6c1e8c9451f12
> --- /dev/null
> +++ b/drivers/video/backlight/ocp8178_bl.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Orient Chip OCP8178 Backlight Driver
> + *
> + * Copyright (C) 2026 Wim de With
> + *
> + * Author: Wim de With <wf@dewith.io>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/irqflags.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#define OCP8178_MAX_BRIGHTNESS 0x1F /* 5 bits */
> +
> +#define OCP8178_DEVICE_ADDRESS 0x72
> +
> +#define OCP8178_DATA_RFA BIT(7)
> +#define OCP8178_DATA_ADDR GENMASK(6, 5)
> +#define OCP8178_DATA_VALUE GENMASK(4, 0)
> +
> +#define OCP8178_1W_INIT_MAX_RETRIES 5
> +#define OCP8178_1W_INIT_SLEEP_US (50 * 1000)
> +
> +#define OCP8178_T_OFF_US (3 * 1000) /* datasheet specifies at least 2.5 ms */
> +#define OCP8178_1W_T_DELAY_US (100 + 10) /* 10 us as safety factor */
> +#define OCP8178_1W_T_DETECT_US (260 + 10) /* 10 us as safety factor */
> +#define OCP8178_1W_T_START_US 2
> +#define OCP8178_1W_T_EOS_US 2
> +#define OCP8178_1W_T_WIN_NS (1000 * 1000)
> +
> +/*
> + * The datasheet specifies 1.7 Kbps to 160 Kbps.
> + * 1 / (160 Kbps) is about 6.67 us, so using 7 us per bit should be fine.
> + * T_HIGH + T_LOW = 7 us
> + * T_HIGH > 2 * T_LOW for high bits
> + * T_LOW > 2 * T_HIGH for low bits
> + */
> +#define OCP8178_1W_HIGH_BIT_T_LOW_US 2
> +#define OCP8178_1W_HIGH_BIT_T_HIGH_US 5
> +#define OCP8178_1W_LOW_BIT_T_LOW_US 5
> +#define OCP8178_1W_LOW_BIT_T_HIGH_US 2
> +
> +struct ocp8178_bl {
> +	struct device *dev;
> +	struct gpio_desc *gpiod;
> +};
> +
> +static int ocp8178_bl_enable_onewire(struct ocp8178_bl *ocp8178)
> +{
> +	u64 start, duration;
> +

It seems you re-implemented one-wire interface instead of using w1. Why?
What sort of one-wire bus/interface is this?

Best regards,
Krzysztof

