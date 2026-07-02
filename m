Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46875C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8B610E514;
	Thu,  2 Jul 2026 16:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WSiC5iXC";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4442710E514
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:01:21 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-470174001a0so1471224f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783008079; x=1783612879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=hyBy6M8pfJIet42O2HWF6w856c4etTz6bW2vlxGM7bE=;
 b=WSiC5iXCXOZtOrJu+mJA2DpF4HTZ6/z/p0lKKXUV6M9RRkwHatS4STBlKd9Yg4Zoro
 XTw1m4DgebNd2+Ce85/f2acNVi6VTtKShFDOVv0UI1UoBu677+NOI1lV4AgIcYYwP9G+
 udNQ4y6FnEMrToDWuS2/nUm/7OFbM/JPmwlFuDfbjDxgJ2hU3kKuRZy1C4DwErcf3zQ7
 5/O49Zg8ig9X5H+64NcZDJXbQGnC1+iisic6rpnqkz0n3eMtoc9doguJxdbnzNX9BIk0
 Tg1U9vcAs7qoN/VXpcyxY5H5yg9KQQ6vmauK2aiJs+ZnEX8zBj286IPl5t4Tul+MD1aQ
 4+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783008079; x=1783612879;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyBy6M8pfJIet42O2HWF6w856c4etTz6bW2vlxGM7bE=;
 b=mzFpeCmrkTwxFF2WJj3y5vM4CoQIqJpRhTNq9yXSI6nye+BhOrrGI1q+G2qvyEcy+e
 O2k3akffm44z7yfAewbBifGAITj+m0wJ06cBs6cPfAg95taqPFzPmaoSxon5jnIRkm4B
 6j/0Am1PohXGHcyNQ0/0xhZ7ZERs8ecfgvX9S+vVSy3kKCxCMjHCk//UQOX1SbQbBNEB
 G0dXTzdi3OGmeASUbdQJaevujSJCL1q2CkorPKl6bzYkqOiEbLyzwmk+Q26C3tgZP9gx
 VO3XeBm5ByA73+EAPZm9a2ycjg4ueCAANSY8wXm9z/p/vjv/DX2C7bLzmmYOShWz+SFr
 yWyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RosSeQuC3j+4f0yAhU7heEFi9jNA59N/3FGzu8GYKku/lOnqKo64NPg0UlvBrty5dpTC9CEO8IGwiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPV9m3pRYMiktRpVXnrMTafaNV8RBvcPOzvG7oqko3y60xnECN
 4vvEFm/04tUm9pcllKRIn6C6NJRqT+bmhoCSjP1XWrXkuIZ6bYlZA5NFNOsWdle4ouQ=
X-Gm-Gg: AfdE7clqlI/aTuv9rOzSJeWGNglD3U19iDD56Z+dlWiZW208wYi/PlwI7ywdjR1juJy
 Ra4aj3HCylIF+5QUzmAK/ZmFSUTcqOFW9BlqH2+uo01GNpZWLWitENRSTqEw51S34ipl+kaykIO
 YYKqNp20EMz4tLnJw9f/CtuQ8jm9oTx/uMqYXg94G2UczLHdlFNETsz2HRzVMQsSsCJPb+VKHgZ
 4dP+ZG5Ym7ePfrH6ZA+MDP2PRcjZHmNVbGKWiYN2CmFDsAG8SNUn3eASEGM/+3nPRS7VLEvU0/t
 egmXUqxaMJHT9QpcFs8W0GPQF93K8JJsBICrpVmhvFORyPC8oB2bkLkvN6jeVolLb0S2HQRBx5w
 Ux7t+W+HFXM2K3iI27oBAytdpxgp3L+JFRMVm63KF41VA+yGGlbiWo5dFb1FlmgVna50NmU+v8a
 tvgA33NpfNHR6JOMEbZWxhesIiQrM5lHZjP9nTXTt4GOTjYoBEc4rYVORdqOnxuPBg1Gkv
X-Received: by 2002:a05:6000:2c0d:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-477b5487cb9mr8516113f8f.40.1783008079349; 
 Thu, 02 Jul 2026 09:01:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:bbc2:d1c5:84fa:44fb?
 ([2a01:e0a:106d:1080:bbc2:d1c5:84fa:44fb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4b73sm10118644f8f.15.2026.07.02.09.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 09:01:17 -0700 (PDT)
Message-ID: <a3c69349-2be8-486e-adba-55df32c291db@linaro.org>
Date: Thu, 2 Jul 2026 18:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 2/2] backlight: Add SY7758 6-channel High Efficiency
 LED Driver support
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
 <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-2-03aacd49747c@linaro.org>
 <20260702155157.GX2108533@google.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260702155157.GX2108533@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Lee,

On 7/2/26 17:51, Lee Jones wrote:
> Please consider these:
> 
> /* Sashiko Automation: Issues Found (4 Findings) */
> 
> On Fri, 29 May 2026, Neil Armstrong wrote:
> 
>> From: KancyJoe <kancy2333@outlook.com>
>>
>> Implement support for the Silergy SY7758 6-channel High Efficiency LED
>> Driver used for backlight brightness control in the Ayaneo Pocket S2
>> dual-DSI panel.
>>
>> Signed-off-by: KancyJoe <kancy2333@outlook.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/video/backlight/Kconfig  |   8 ++
>>   drivers/video/backlight/Makefile |   1 +
>>   drivers/video/backlight/sy7758.c | 259 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 268 insertions(+)
>>
>> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
>> index a7a3fbaf7c29..a1f70a2bae99 100644
>> --- a/drivers/video/backlight/Kconfig
>> +++ b/drivers/video/backlight/Kconfig
>> @@ -207,6 +207,14 @@ config BACKLIGHT_KTZ8866
>>   		Say Y to enable the backlight driver for the Kinetic KTZ8866
>>   		found in Xiaomi Mi Pad 5 series.
>>   
>> +config BACKLIGHT_SY7758
>> +	tristate "Backlight Driver for Silergy SY7758"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	  Say Y to enable the backlight driver for the Silergy SY7758
>> +	  backlight controller found in Ayaneo Pocket S2.
>> +
>>   config BACKLIGHT_LM3533
>>   	tristate "Backlight Driver for LM3533"
>>   	depends on MFD_LM3533
>> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
>> index 794820a98ed4..39ef588b1cf2 100644
>> --- a/drivers/video/backlight/Makefile
>> +++ b/drivers/video/backlight/Makefile
>> @@ -56,6 +56,7 @@ obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
>>   obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
>>   obj-$(CONFIG_BACKLIGHT_RT4831)		+= rt4831-backlight.o
>>   obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
>> +obj-$(CONFIG_BACKLIGHT_SY7758)		+= sy7758.o
>>   obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
>>   obj-$(CONFIG_BACKLIGHT_TPS65217)	+= tps65217_bl.o
>>   obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
>> diff --git a/drivers/video/backlight/sy7758.c b/drivers/video/backlight/sy7758.c
>> new file mode 100644
>> index 000000000000..786589cb8df9
>> --- /dev/null
>> +++ b/drivers/video/backlight/sy7758.c
>> @@ -0,0 +1,259 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Silergy SY7758 6-channel High Efficiency LED Driver
>> + *
>> + * Copyright (C) 2025 Kancy Joe <kancy2333@outlook.com>
>> + * Copyright (C) 2026 Linaro Limited
>> + * Author: Neil Armstrong <neil.armstrong@linaro.org>
>> + */
>> +#include <linux/backlight.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/of.h>
>> +#include <linux/err.h>
>> +#include <linux/bits.h>
>> +#include <linux/delay.h>
>> +#include <linux/regmap.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#define DEFAULT_BRIGHTNESS	1024
>> +#define MAX_BRIGHTNESS		4080
>> +#define REG_MAX			0xAE
>> +
>> +/* Registers */
>> +#define REG_DEV_CTL		0x01
>> +#define REG_DEV_ID		0x03
>> +#define REG_BRT_12BIT_L		0x10
>> +#define REG_BRT_12BIT_H		0x11
>> +
>> +/* OTP memory */
>> +#define REG_OTP_CFG0		0xA0
>> +#define REG_OTP_CFG1		0xA1
>> +#define REG_OTP_CFG2		0xA2
>> +#define REG_OTP_CFG5		0xA5
>> +#define REG_OTP_CFG9		0xA9
>> +
>> +/* Fields */
>> +#define BIT_DEV_CTL_FAST	BIT(7)
>> +#define MSK_DEV_CTL_BRT_MODE	GENMASK(2, 1)
>> +#define BIT_DEV_CTL_BL_CTLB	BIT(0)
>> +
>> +#define MSK_BRT_12BIT_L		GENMASK(7, 0)
>> +#define MSK_BRT_12BIT_H		GENMASK(3, 0)
>> +
>> +#define MSK_CFG0_CURRENT_LOW	GENMASK(7, 0)
>> +
>> +#define BIT_CFG1_PDET_STDBY	BIT(7)
>> +#define MSK_CFG1_CURRENT_MAX	GENMASK(6, 4)
>> +#define MSK_CFG1_CURRENT_HIGH	GENMASK(3, 0)
>> +
>> +#define BIT_CFG2_UVLO_EN	BIT(5)
>> +#define BIT_CFG2_UVLO_TH	BIT(4)
>> +#define BIT_CFG2_BL_ON		BIT(3)
>> +#define BIT_CFG2_ISET_EN	BIT(2)
>> +#define BIT_CFG2_BST_ESET_EN	BIT(1)
>> +
>> +#define BIT_CFG5_PWM_DIRECT	BIT(7)
>> +#define MSK_CFG5_PS_MODE	GENMASK(6, 4)
>> +#define MSK_CFG5_PWM_FREQ	GENMASK(3, 0)
>> +
>> +#define MSK_CFG9_VBST_MAX	GENMASK(7, 5)
>> +#define BIT_CFG9_JUMP_EN	BIT(4)
>> +#define MSK_CFG9_JUMP_TH	GENMASK(3, 2)
>> +#define MSK_CFG9_JUMP_VOLTAGE	GENMASK(1, 0)
>> +
>> +struct sy7758 {
>> +	struct i2c_client *client;
>> +	struct regmap *regmap;
>> +	struct gpio_desc *gpio;
>> +	struct backlight_device *bl;
>> +};
>> +
>> +static const struct regmap_config sy7758_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = REG_MAX,
>> +};
>> +
>> +static int sy7758_backlight_update_status(struct backlight_device *backlight_dev)
>> +{
>> +	struct sy7758 *sydev = bl_get_data(backlight_dev);
>> +	unsigned int brightness = backlight_get_brightness(backlight_dev);
>> +	int ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_L,
>> +			   FIELD_PREP(MSK_BRT_12BIT_L,
>> +				      brightness & 0xff));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_H,
>> +			   FIELD_PREP(MSK_BRT_12BIT_H,
>> +				      (brightness >> 8) & 0xf));
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct backlight_ops sy7758_backlight_ops = {
>> +	.options = BL_CORE_SUSPENDRESUME,
>> +	.update_status = sy7758_backlight_update_status,
>> +};
> 
> [Severity: High]
> This driver sets the BL_CORE_SUSPENDRESUME option, which relies on the
> backlight core to blank and unblank the brightness on suspend and resume.
> However, if the system's power management cuts power to the vdd regulator
> during suspend, won't the device lose all the configuration state established
> in sy7758_init()?

This will never happen, if we don't disable the regulators they will stay on during system suspend.

> 
> Because there are no standard pm_ops to re-apply this initialization sequence
> upon resume, it seems the backlight might operate with incorrect parameters or
> fail to turn on. Should this driver implement a resume callback to restore the
> volatile hardware configuration?
> 
> 
> 
>> +
>> +static int sy7758_init(struct sy7758 *sydev)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_DEV_CTL,
>> +			   BIT_DEV_CTL_FAST | BIT_DEV_CTL_BL_CTLB |
>> +			   FIELD_PREP(MSK_DEV_CTL_BRT_MODE, 2));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_L,
>> +			   FIELD_PREP(MSK_BRT_12BIT_L,
>> +				      DEFAULT_BRIGHTNESS & 0xff));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_BRT_12BIT_H,
>> +			   FIELD_PREP(MSK_BRT_12BIT_H,
>> +				      (DEFAULT_BRIGHTNESS >> 8)));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_OTP_CFG5,
>> +			   FIELD_PREP(MSK_CFG5_PS_MODE, 6) |
>> +			   FIELD_PREP(MSK_CFG5_PWM_FREQ, 4));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_OTP_CFG0,
>> +			   FIELD_PREP(MSK_CFG0_CURRENT_LOW, 85));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_OTP_CFG1,
>> +			   BIT_CFG1_PDET_STDBY |
>> +			   FIELD_PREP(MSK_CFG1_CURRENT_MAX, 1) |
>> +			   FIELD_PREP(MSK_CFG1_CURRENT_HIGH, 10));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_OTP_CFG9,
>> +			   FIELD_PREP(MSK_CFG9_VBST_MAX, 4));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(sydev->regmap, REG_OTP_CFG2,
>> +			   BIT_CFG2_BL_ON | BIT_CFG2_UVLO_EN);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int sy7758_probe(struct i2c_client *client)
>> +{
>> +	struct backlight_properties props = { };
>> +	struct device *dev = &client->dev;
>> +	struct sy7758 *sydev;
>> +	unsigned int dev_id;
>> +	int ret;
>> +
>> +	sydev = devm_kzalloc(dev, sizeof(*sydev), GFP_KERNEL);
>> +	if (!sydev)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, sydev);
>> +
>> +	/* Initialize regmap */
>> +	sydev->client = client;
>> +	sydev->regmap = devm_regmap_init_i2c(client, &sy7758_regmap_config);
>> +	if (IS_ERR(sydev->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(sydev->regmap),
>> +				     "failed to init regmap\n");
>> +
>> +	/* Get and enable regulator */
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get regulator\n");
>> +
>> +	fsleep(100);
>> +
>> +	/* Get enable GPIO and set to high */
>> +	sydev->gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(sydev->gpio))
>> +		return dev_err_probe(dev, PTR_ERR(sydev->gpio),
>> +				     "failed to get enable GPIO\n");
> 
> [Severity: Medium]
> Is it possible for the enable pin to be hardwired to a power rail on some
> hardware designs? Using devm_gpiod_get() makes this GPIO strictly mandatory
> and fails the probe if the enable-gpios property is absent in the Device Tree.
> Would devm_gpiod_get_optional() be more appropriate here?
> 

This makes no sense, the enable gpio is required per the spec, and is required in the bindings.

> 
> [Severity: High]
> The enable GPIO is asserted high here, but is there a mechanism to ensure it
> is explicitly driven low during driver removal or if the probe fails later?

This is not an issue, the enable is required to be high when operating the IC
which depends on vdd to be on. No need to put it back.

> 
> If devres automatically disables the vdd regulator while the host is still
> driving the GPIO high, couldn't this back-power the chip through its internal
> ESD protection diodes and cause hardware damage? Using
> devm_add_action_or_reset() to drive the GPIO low before the regulator is
> disabled might prevent this.

No, spec says this won't happen and is safe.

> 
> 
> 
>> +
>> +	/* Let some time for HW to settle */
>> +	fsleep(10000);
>> +
>> +	/* try read and check device id */
>> +	ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed to read device id\n");
>> +	if (dev_id != 0x63) {
>> +		dev_err(dev, "unexpected device id: 0x%02x\n", dev_id);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Initialize and set default brightness */
>> +	ret = sy7758_init(sydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	props.type = BACKLIGHT_RAW;
>> +	props.max_brightness = MAX_BRIGHTNESS;
>> +	props.brightness = DEFAULT_BRIGHTNESS;
>> +	props.scale = BACKLIGHT_SCALE_LINEAR;
>> +
>> +	sydev->bl = devm_backlight_device_register(dev, "sy7758-backlight",
>> +						   dev, sydev, &sy7758_backlight_ops,
>> +						   &props);
>> +	if (IS_ERR(sydev->bl))
>> +		return dev_err_probe(dev, PTR_ERR(sydev->bl),
>> +				     "failed to register backlight device\n");
>> +
>> +	return backlight_update_status(sydev->bl);
>> +}
>> +
>> +static void sy7758_remove(struct i2c_client *client)
>> +{
>> +	struct sy7758 *sydev = i2c_get_clientdata(client);
>> +
>> +	backlight_disable(sydev->bl);
>> +}
> 
> [Severity: Medium]
> Since the backlight was registered using devm_backlight_device_register(),
> devres will unregister the sysfs interface after sy7758_remove() returns.

this will never happen.

> 
> Does this leave a race window where userspace could concurrently write to the
> sysfs brightness file and re-enable the hardware right after
> backlight_disable() turns it off?
> 
>> +
>> +static const struct i2c_device_id sy7758_ids[] = {
>> +	{ "sy7758" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, sy7758_ids);
>> +
>> +static const struct of_device_id sy7758_match_table[] = {
>> +	{ .compatible = "silergy,sy7758", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, sy7758_match_table);
>> +
>> +static struct i2c_driver sy7758_driver = {
>> +	.driver = {
>> +		.name = "sy7758",
>> +		.of_match_table = sy7758_match_table,
>> +	},
>> +	.probe = sy7758_probe,
>> +	.remove = sy7758_remove,
>> +	.id_table = sy7758_ids,
>> +};
>> +
>> +module_i2c_driver(sy7758_driver);
>> +
>> +MODULE_DESCRIPTION("Silergy SY7758 Backlight Driver");
>> +MODULE_AUTHOR("Kancy Joe <kancy2333@outlook.com>");
>> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.34.1
>>
> 

Thanks,
Neil
