Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F83F3ED4A
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 01:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B9410E27B;
	Sun, 12 Apr 2026 01:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDK5SyAt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aMsu3C07";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440C610E27B
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 01:07:03 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BNsN5x2122654
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 01:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cj8Mv/ie2mU8MZuhnfvt5j6+NsZ00dsXgrPHeC4p2KE=; b=bDK5SyAtxhPNqro1
 6lhbERpWBuOxd727/SN+AagqeMkwhsq11T80PHXYmWmgYQIDidfkzGbKUlSuOgLh
 81a5IIkZlY5ym4OmJE7vaSgSrr2ydiB/SllrKh5wmxACnts2QAkaTJqr6RSzATL3
 W5fZzRyXSeL3+SvF3r8Sh0fU5beg+tSouU9erl/8TwRgdTePokqXb25DQJzB/Y8s
 dV+0fTP1rn8OorLmkcB3CyhAk9uB5GeSLYiKYvlOG2egFzhvaq2FHhgVqaphNKgS
 0+N5u6OPx4utNo2Lj+XlTSsHDykiu6OuglzlhYnpasQRvxZBdXB/XxvxCUpd4CXp
 KyrFVQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfew01kgw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 01:07:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b0be75dfd4so32896845ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775956021; x=1776560821;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cj8Mv/ie2mU8MZuhnfvt5j6+NsZ00dsXgrPHeC4p2KE=;
 b=aMsu3C07gvAbe6tYoSItw9Py9VgyCQsJ3RvJbzoloiZqAX74kxTY6xOp03vPop9bCC
 90QaZ+IFuEOXdoeGYZhOpwoCuR+ewmoXZ0Q05gEdaQl3STKMwycGqsC9zEXmIMyftIod
 GcAfRgv8D2AVaWcRfxn9+Np35PvCV1p0MnTh39ggKNbqdF4hSuGmkvn2wwCz8iVF8/Ui
 rnrBUtgVf6CBMFz6Y2DF9wmWc89RJVBINEIukoqypRE3EbtHE+KGlAK2BZI50OY9rQ05
 sguyxGxLuYiXklulAm1x1BRUIdbbQzvq+TUHaVuNsIJ/bDnaq/jHnPecSeNXt38qUaEO
 8Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775956021; x=1776560821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cj8Mv/ie2mU8MZuhnfvt5j6+NsZ00dsXgrPHeC4p2KE=;
 b=m05T1G+ceq6olIueuI3EvBfDOVcjaLxVyskr8WB78DKfRIZeiiMK+GriW48RwfVJRc
 aP6Ip/topksWslKI7NM/MbvRGDkPbprk4eQSB3cHMSF9AOA7Y7MlMyg872W4czjVAZHV
 WJQWSeRc7xBYdECkfokd04O2Pi7JQ67EJu+QtBEq8rKYIJDS68s86HsejfKDbxTioNlV
 SX0YkiLGc3jxQw89V3w1OigpD0+uSO6SYPMiN0rJyg8ZUonTgnLqJ3X0mvF2Bq1LywE1
 XKKfCynmX9cAi9vCAwdoqcOZ+WSHYpQPqqwa+alhuTFoU46Z8D0nA+ZZ+nEIYrG05sCL
 l9aQ==
X-Gm-Message-State: AOJu0YxBb+jHTLmqdRTyOBu2ULc8w3LO+yv1lMfKkvhlD9P0/zqLv3Ec
 l+Rngd/NLDHK0VCOxyDgwznQCE8197tt1fbx17y67NKce9NCIbm+wamMY6whPNfZvkjXJcaiL+K
 eStDPZYZoqx5oCiEJScDctWty/5ObOkUEIO7KEEt5AAy3sQROhmg2iPFfP+xf4qiOveRC54g=
X-Gm-Gg: AeBDiesm7wk4aT40z82mdtcaUBYCgiyi5CXkhvVG6SuAWZxXsG4Dd6WhhBkMN/hDCXn
 +oueRUZOuG1iu3wP1WrFStFEBOYQopKJpgmLJQ6oq6ozWRxxNbt9qQwjnezOiE6oE26Ig+hy3sF
 U+75XRzOZK5VvFEppWStTsVheVA+ppGVRFRPF6FGXMD4qbLlGDgYtP4eS0YdnGmpqmNB/YQhH8b
 fNrOa679HLHRuuQYulbHaYEdZOyJ7Fbt8F5+GZjmYwpFGQld08uu5iCOWk6mMd7JcpdmPu/t/57
 xwWdSswqZVfMsU7bpeP36pZjrV05TGWB6E4oOh/MB7zgLw8EOFn0GAddddSAUnArihW1/pDkeT+
 3Rj52einC/f+c5wYXkz7xB1bx3qg/hEJR+9a31Z8rO2gL5HVT11bMspFRGNCUbAkS5V6L5ygT1G
 3TznXuIgYbfA==
X-Received: by 2002:a17:902:a982:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b2d59a0c3cmr64582135ad.15.1775956020871; 
 Sat, 11 Apr 2026 18:07:00 -0700 (PDT)
X-Received: by 2002:a17:902:a982:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b2d59a0c3cmr64581845ad.15.1775956020278; 
 Sat, 11 Apr 2026 18:07:00 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f27048sm67859815ad.62.2026.04.11.18.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 18:06:59 -0700 (PDT)
Message-ID: <5d1dd70e-0300-4ca0-adb9-73f03cf4bf4d@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 09:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/21] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwOCBTYWx0ZWRfXxH5ypU4FjmHR
 DtOHDy8X97NoJZfyqMu2UpLXPFsmOt/awPExC+KS0d/YcvBeweFa/z6bZRxngId6+YKDDEeIPMQ
 ctadJEH5H46NpkxsqCinRZlwWk6vLf9LU8Na5cpg3blbSgFRiC98iyol79TDEubc3TjczxqS2LA
 qMnbW9FLlrjnoAkWOttEeW31GZUlOtR0dOICNbGx3u4IpjmKH0njGiOdaN7u3zp5BEvtBq6AudG
 Vv5iDER8WPhU9auWDSBwOuEE2lU9bbzb97Ds3n7bLgO6BgApJ084OPeiCrMLdVedIip4rWeADir
 rDV0tGHOIhRQhZWobdRx+GSwND1UMR9YETBcupyAyIXmVsTqWXRub9e8P/ZpuQ7kCXSykc3n/+v
 qhVIfvtgVJBBZc+j+3DzS+fVKzwxwe8SsOvUon/mG9z1t8gLXsusorGcKMP1V+T5/xevlLnQuzd
 Qq2el69Kup/r40aWcxQ==
X-Proofpoint-GUID: br1oqYYucdPJKfyn1BnWZvXhUEQQ3J4N
X-Authority-Analysis: v=2.4 cv=AofeGu9P c=1 sm=1 tr=0 ts=69daf035 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=f_8IO1HHPxn9Zh0c9RAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: br1oqYYucdPJKfyn1BnWZvXhUEQQ3J4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120008
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



On 4/11/2026 8:10 PM, Dmitry Baryshkov wrote:
> The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> controller, which controls power supplies to the panel and the touch
> screen and provides reset pins for both the panel and the touchscreen.
> Also it provides a simple PWM controller for panel backlight. Add
> support for this GPIO controller.
> 
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpio/Kconfig              |  10 ++
>   drivers/gpio/Makefile             |   1 +
>   drivers/gpio/gpio-waveshare-dsi.c | 208 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 219 insertions(+)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index dbe7c6e63eab..1b210c451151 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -805,6 +805,16 @@ config GPIO_VISCONTI
>   	help
>   	  Say yes here to support GPIO on Tohisba Visconti.
>   
> +config GPIO_WAVESHARE_DSI_TOUCH
> +	tristate "Waveshare GPIO controller for DSI panels"
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Enable support for the GPIO and PWM controller found on Waveshare DSI
> +	  TOUCH panel kits. It provides GPIOs (used for regulator control and
> +          resets) and backlight support.
> +
>   config GPIO_WCD934X
>   	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controller driver"
>   	depends on MFD_WCD934X
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 20d4a57afdaa..75ce89fc3b93 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -207,6 +207,7 @@ obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
>   obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
>   obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
>   obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
> +obj-$(CONFIG_GPIO_WAVESHARE_DSI_TOUCH)	+= gpio-waveshare-dsi.o
>   obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
>   obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
>   obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
> diff --git a/drivers/gpio/gpio-waveshare-dsi.c b/drivers/gpio/gpio-waveshare-dsi.c
> new file mode 100644
> index 000000000000..f4a1d4d3b872
> --- /dev/null
> +++ b/drivers/gpio/gpio-waveshare-dsi.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Waveshare International Limited
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/err.h>
> +#include <linux/fb.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +/* I2C registers of the microcontroller. */
> +#define REG_TP		0x94
> +#define REG_LCD		0x95
> +#define REG_PWM		0x96
> +#define REG_SIZE	0x97
> +#define REG_ID		0x98
> +#define REG_VERSION	0x99
> +
> +enum {
> +	GPIO_AVDD = 0,
> +	GPIO_PANEL_RESET = 1,
> +	GPIO_BL_ENABLE = 2,
> +	GPIO_IOVCC = 4,
> +	GPIO_VCC = 8,
> +	GPIO_TS_RESET = 9,
> +};
> +
> +#define NUM_GPIO 16
> +
> +struct waveshare_gpio {
> +	struct mutex dir_lock;
> +	struct mutex pwr_lock;
> +	struct regmap *regmap;
> +	u16 poweron_state;
> +
> +	struct gpio_chip gc;
> +};
> +
> +static const struct regmap_config waveshare_gpio_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = REG_PWM,

.max_register = REG_VERSION,

check comments in probe

> +};
> +
> +static int waveshare_gpio_get(struct waveshare_gpio *state, unsigned int offset)
> +{
> +	u16 pwr_state;
> +
> +	guard(mutex)(&state->pwr_lock);
> +	pwr_state = state->poweron_state & BIT(offset);
> +
> +	return !!pwr_state;
> +}
> +
> +static int waveshare_gpio_set(struct waveshare_gpio *state, unsigned int offset, int value)
> +{
> +	u16 last_val;
> +	int err;
> +
> +	guard(mutex)(&state->pwr_lock);
> +
> +	last_val = state->poweron_state;
> +	if (value)
> +		last_val |= BIT(offset);
> +	else
> +		last_val &= ~BIT(offset);
> +
> +	state->poweron_state = last_val;
> +
> +	err = regmap_write(state->regmap, REG_TP, last_val >> 8);
> +	if (!err)
> +		err = regmap_write(state->regmap, REG_LCD, last_val & 0xff);
> +
> +	return err;
> +}
> +
> +static int waveshare_gpio_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int waveshare_gpio_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct waveshare_gpio *state = gpiochip_get_data(gc);
> +
> +	return waveshare_gpio_get(state, offset);
> +}
> +
> +static int waveshare_gpio_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
> +{
> +	struct waveshare_gpio *state = gpiochip_get_data(gc);
> +
> +	return waveshare_gpio_set(state, offset, value);
> +}
> +
> +static int waveshare_gpio_update_status(struct backlight_device *bl)
> +{
> +	struct waveshare_gpio *state = bl_get_data(bl);
> +	int brightness = backlight_get_brightness(bl);
> +
> +	waveshare_gpio_set(state, GPIO_BL_ENABLE, brightness);
> +
> +	return regmap_write(state->regmap, REG_PWM, brightness);
> +}
> +
> +static const struct backlight_ops waveshare_gpio_bl = {
> +	.update_status = waveshare_gpio_update_status,
> +};
> +
> +static int waveshare_gpio_probe(struct i2c_client *i2c)
> +{
> +	struct backlight_properties props = {};
> +	struct waveshare_gpio *state;
> +	struct device *dev = &i2c->dev;
> +	struct backlight_device *bl;
> +	struct regmap *regmap;
> +	unsigned int data;
> +	int ret;
> +
> +	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	ret = devm_mutex_init(dev, &state->dir_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mutex_init(dev, &state->pwr_lock);
> +	if (ret)
> +		return ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &waveshare_gpio_regmap_config);

for waveshare_gpio_regmap_config: .max_register = REG_PWM,

> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to allocate register map\n");
> +
> +	state->regmap = regmap;
> +	i2c_set_clientdata(i2c, state);
> +
> +	ret = regmap_read(regmap, REG_ID, &data);

REG_ID here is 0x98,

in _regmap_read -> regmap_readable will check the max_register, then 
return -EIO.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read register\n");
> +
> +	dev_dbg(dev, "waveshare panel hw id = 0x%x\n", data);
> +
> +	ret = regmap_read(regmap, REG_SIZE, &data);

ditto.

Thanks,
Jie

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read register\n");
> +
> +	dev_dbg(dev, "waveshare panel size = %d\n", data);
> +
> +	ret = regmap_read(regmap, REG_VERSION, &data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read register\n");
> +
> +	dev_dbg(dev, "waveshare panel mcu version = 0x%x\n", data);
> +
> +	ret = waveshare_gpio_set(state, GPIO_TS_RESET, 1);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to program GPIOs\n");
> +
> +	msleep(20);
> +
> +	state->gc.parent = dev;
> +	state->gc.label = i2c->name;
> +	state->gc.owner = THIS_MODULE;
> +	state->gc.base = -1;
> +	state->gc.ngpio = NUM_GPIO;
> +
> +	/* it is output only */
> +	state->gc.get = waveshare_gpio_gpio_get;
> +	state->gc.set = waveshare_gpio_gpio_set;
> +	state->gc.get_direction = waveshare_gpio_gpio_get_direction;
> +	state->gc.can_sleep = true;
> +
> +	ret = devm_gpiochip_add_data(dev, &state->gc, state);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to create gpiochip\n");
> +
> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = 255;
> +	props.brightness = 255;
> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, state,
> +					    &waveshare_gpio_bl, &props);
> +	return PTR_ERR_OR_ZERO(bl);
> +}
> +
> +static const struct of_device_id waveshare_gpio_dt_ids[] = {
> +	{ .compatible = "waveshare,dsi-touch-gpio" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, waveshare_gpio_dt_ids);
> +
> +static struct i2c_driver waveshare_gpio_regulator_driver = {
> +	.driver = {
> +		.name = "waveshare-regulator",
> +		.of_match_table = of_match_ptr(waveshare_gpio_dt_ids),
> +	},
> +	.probe = waveshare_gpio_probe,
> +};
> +
> +module_i2c_driver(waveshare_gpio_regulator_driver);
> +
> +MODULE_DESCRIPTION("GPIO controller driver for Waveshare DSI touch panels");
> +MODULE_LICENSE("GPL");
> 

