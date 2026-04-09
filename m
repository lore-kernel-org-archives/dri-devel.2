Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0F310FC463
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 01:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2961810E15C;
	Thu,  9 Apr 2026 01:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yt4Mh1Vm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X15V8P4+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620AD10E15C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 01:26:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638JeifG1727555
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 01:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dDnk3ruHiHMF/0uvVDLmz4WG
 2YJ8OdFJaHFnUpJqBok=; b=Yt4Mh1VmXz4PfwqtPgBAIDJKxRJJ2Q6QTWS+zcr2
 gz7IrlP27jjHvxB2E0bgYIUDa0FJfeERLD5PD5/Yaj4vW+zmG66pTaivIEqUPCCv
 gRsIGvvwMBvxpBOG5NHT+4H659+Mq2Wm1ZNAY75GvApOZulebuJ5Eka4rHdeVSOz
 i1Dz1pHfPLu8JrtX9banqI4vyDlgK3IydqOsF+TNL2uCCKTXp/lTz55HXo7zjeYk
 NJNEVapvyvqyeGG5EP/1GFVhMKyoKjGX1rfAXqWN07qGRli1EGbFgWpBcndLJ00m
 DLkSWVKrTKwIhrRVHgOM6VKjUQesmPiwZlArzk+zJQlH4g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddwcrs0vs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 01:26:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4b81c632so13718231cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775698005; x=1776302805;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dDnk3ruHiHMF/0uvVDLmz4WG2YJ8OdFJaHFnUpJqBok=;
 b=X15V8P4+BWWJvf1qqffGy+x//FESFVt7+oPSGGmYS3kROj5asPGZxt6zbzLiYDaLME
 fiRyElgkwf9+5ScBgW7h3RtrNZKmPLqXoLWckWFOYGP8Asr2ut1RGCWUgOzuvCnUh0a8
 g9zXarNlaRpOGbV807cnthmjxWVV9tQ6N2YhESchIMqavgDEOH603KJ4w/8+whhaposa
 OQHzmm6oZyxzv0byznwxL021jOlC38WyhvXFj5BdEW+Y6B2/plLxwlhGXdDZbd8DkQtI
 sVQ0bZez3H80TZdDlSHPRiieICzSFAkkyEwpDFgt4rUh1uzlCruhpBnzRk9mcwxjMsfZ
 RfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775698005; x=1776302805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDnk3ruHiHMF/0uvVDLmz4WG2YJ8OdFJaHFnUpJqBok=;
 b=ro/Zw0xtgCfbOmx6ZAVBTsEWJL0zImS6WSOFyd2kdUpmxFUYQDzEGmCDWyVY6FBt/m
 eSmg2M/oA/lajP/2dsv0zhl8h9HejG6DAHFDRCXqwJ0yCkJK3jLdO35QwWvqXeTtXGWo
 zqyORfGsPnwZidS/kmkxHOgjXdtR5y0aapqNqZtyRGvX4ODJjoP5QBTz1Quv0wyo2HJI
 9mnjYYuEbJRgEWxoWRXOuwq1UcLhsCumXD79bRNwPqS6OqfS7HOhT0799Af65+HUExfu
 OgaT2RPdM318F+t035xXvwc2gxOQUnJVHDClDXsfIEJHkqSBiNh33xMfkYhKHSOU6smf
 jdfg==
X-Gm-Message-State: AOJu0YzuzVrXooSbvEYe4YjHFi0OK6ytOtA9TiniokudcGpsi65YOhj5
 /C83Wygl1To4KjtRgOLGxPUBXDVEQohZ0JR/y4dLi+v7icjykIHRjt6SEl65BENHQJwGyNmltMD
 telwnwHqPCyMbJBsUq5syckKUeKsq3qPS489AtHxt0W8MQ4/OFQi68utuDodF2uBwQTDCYdQ=
X-Gm-Gg: AeBDievif1kxyPbzsGsqI9TogZA54F0ELb/SRKNqjnnvneNX/H7QsRKDhFPg4PshYao
 ngO31hmY7QHmGn1pGq2hop3629VfnwtSPdT3oSOGfy4mbpR8DQuW6k6HOjOVX9RiInp2+JQA7EA
 QYuHWz1WWUVFpefB8+5DWkJRxIOPvkc+52yTPxwCGtPUMUp8P4gaKYQo2NSQ/nTfUvAoT0vDOux
 qkQH+YqACOhjie5oGGisF60Ckf1dpxzIHcItxDPs9h1PxTp00Qk+qi/AEYVUQLDs7QY/uI7Kb3u
 7nR8MvVsdzfBcEuBOWexXjrolgfnlLIGUToIqeN4F4gB4tEvKwwLIPdMc459CyqQQYzRFrXyBMI
 zVLZmhIAdoTsrwxSeoazgTbGJDUMsfuwMmGu1iwtvQDXPKfi0WdmacXKN89M6KEjasP4VQx5iya
 zrSNHWDFxUmIXCjgPTd1Mo/yP44XEZujFBP8E=
X-Received: by 2002:a05:622a:5a8a:b0:50b:49c0:b6f0 with SMTP id
 d75a77b69052e-50d62b52891mr341037741cf.61.1775698004729; 
 Wed, 08 Apr 2026 18:26:44 -0700 (PDT)
X-Received: by 2002:a05:622a:5a8a:b0:50b:49c0:b6f0 with SMTP id
 d75a77b69052e-50d62b52891mr341037451cf.61.1775698004239; 
 Wed, 08 Apr 2026 18:26:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cd6799sm5085625e87.81.2026.04.08.18.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 18:26:41 -0700 (PDT)
Date: Thu, 9 Apr 2026 04:26:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
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
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 19/19] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
Message-ID: <l6pezliurpgv2mopw2xl4gfgpki6r3v6ufpsaavj774qnxgept@h3jxxpco23oa>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-19-5e9119b5a014@oss.qualcomm.com>
 <CAMRc=Mcusnm-k76e6jTiwrw5xJL7f-nWBsg4=QpD08cv8pPgMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcusnm-k76e6jTiwrw5xJL7f-nWBsg4=QpD08cv8pPgMw@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAxMSBTYWx0ZWRfX2E8N5rX+X8s4
 Xo65+NPMpojbekB1IJzIc33Wt8n93sPp5MJtwwQokwErbdLGRx5CKcZfYASTf4epT85G4phLsZf
 HEwqI7lHmKAeiQVmCZ4bhh/8RMrTN1PcJHpNsJV3+5lb2+HFPFjhFqYqikSy/vlrUfMZrW6jNLT
 W1zSlgO5smWl2iYGxCADvoUZsP0vuPv676HRZpBe2t7EuM7L0aEGWqjaxo1dL/RzvLBMPPNekWL
 v8p8x0iM7RRjTwAK8bY3xvAf59OuB8EoAtNhUxicj0y/T5wHrRxpCAvtYFxW3PzqkGS5fFGnCef
 eoHk8iEVfWqRfSfkeTFxh4dFfcp8tNeIISDpIkZWW0YtthSbD/Hrd8qSX7dWnCcm0+BCCqS4vX1
 qIeYxc7GfHx8CI7reJ2e/wAPBCLxQO4K3ze3pEBVnqsiWMIevq00KwS4NkB0WyoYMplZO5aJ8gM
 bTrZEQhA5U7tiv6yNqQ==
X-Authority-Analysis: v=2.4 cv=SsWgLvO0 c=1 sm=1 tr=0 ts=69d70055 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=cggtC_SuP12cYYYmGtYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: DsrJrk03Jvv6aS2TSty999lVByZSoJH7
X-Proofpoint-ORIG-GUID: DsrJrk03Jvv6aS2TSty999lVByZSoJH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090011
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

On Fri, Apr 03, 2026 at 08:30:22AM -0400, Bartosz Golaszewski wrote:
> On Wed, 1 Apr 2026 09:26:38 +0200, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> said:
> > The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> > controller, which controls power supplies to the panel and the touch
> > screen and provides reset pins for both the panel and the touchscreen.
> > Also it provides a simple PWM controller for panel backlight. Add
> > support for this GPIO controller.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpio/Kconfig              |  10 ++
> >  drivers/gpio/Makefile             |   1 +
> >  drivers/gpio/gpio-waveshare-dsi.c | 220 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 231 insertions(+)
> >
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 4c3f6ec336c1..f0bb5cdebf9b 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -804,6 +804,16 @@ config GPIO_VISCONTI
> >  	help
> >  	  Say yes here to support GPIO on Tohisba Visconti.
> >
> > +config GPIO_WAVESHARE_DSI_TOUCH
> > +	tristate "Waveshare GPIO controller for DSI panels"
> > +	depends on BACKLIGHT_CLASS_DEVICE
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +	  Enable support for the GPIO and PWM controller found on Waveshare DSI
> > +	  TOUCH panel kits. It provides GPIOs (used for regulator control and
> > +          resets) and backlight support.
> > +
> >  config GPIO_WCD934X
> >  	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controller driver"
> >  	depends on MFD_WCD934X
> > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > index 20d4a57afdaa..75ce89fc3b93 100644
> > --- a/drivers/gpio/Makefile
> > +++ b/drivers/gpio/Makefile
> > @@ -207,6 +207,7 @@ obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
> >  obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
> >  obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
> >  obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
> > +obj-$(CONFIG_GPIO_WAVESHARE_DSI_TOUCH)	+= gpio-waveshare-dsi.o
> >  obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
> >  obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
> >  obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
> > diff --git a/drivers/gpio/gpio-waveshare-dsi.c b/drivers/gpio/gpio-waveshare-dsi.c
> > new file mode 100644
> > index 000000000000..30fe7569c150
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-waveshare-dsi.c
> > @@ -0,0 +1,220 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2024 Waveshare International Limited
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <linux/backlight.h>
> > +#include <linux/err.h>
> > +#include <linux/fb.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +/* I2C registers of the microcontroller. */
> > +#define REG_TP		0x94
> > +#define REG_LCD		0x95
> > +#define REG_PWM		0x96
> > +#define REG_SIZE	0x97
> > +#define REG_ID		0x98
> > +#define REG_VERSION	0x99
> > +
> > +enum {
> > +	GPIO_AVDD = 0,
> > +	GPIO_PANEL_RESET = 1,
> > +	GPIO_BL_ENABLE = 2,
> > +	GPIO_IOVCC = 4,
> > +	GPIO_VCC = 8,
> > +	GPIO_TS_RESET = 9,
> > +	NUM_GPIO = 16,
> 
> Why is this part of an enum?

I'll move this out of the enum.

> 
> > +static int waveshare_gpio_set(struct waveshare_gpio *state, unsigned int offset, int value)
> > +{
> > +	u16 last_val;
> > +
> > +	mutex_lock(&state->pwr_lock);
> 
> Can you use guards for locks?

Yes

> 
> > +
> > +	last_val = state->poweron_state;
> > +	if (value)
> > +		last_val |= BIT(offset);
> > +	else
> > +		last_val &= ~BIT(offset);
> > +
> > +	state->poweron_state = last_val;
> > +
> > +	regmap_write(state->regmap, REG_TP, last_val >> 8);
> > +	regmap_write(state->regmap, REG_LCD, last_val & 0xff);
> 
> I2C regmap writes can fail and their return value should be checked.

Ack.

> 
> > +
> > +	mutex_unlock(&state->pwr_lock);
> > +
> > +	return 0;
> > +}
> > +

[...]

> > +
> > +static int waveshare_gpio_update_status(struct backlight_device *bl)
> > +{
> > +	struct waveshare_gpio *state = bl_get_data(bl);
> > +	int brightness = backlight_get_brightness(bl);
> > +
> > +	waveshare_gpio_set(state, GPIO_BL_ENABLE, brightness);
> > +
> > +	return regmap_write(state->regmap, REG_PWM, brightness);
> > +}
> > +

[...]

> > +static int waveshare_gpio_probe(struct i2c_client *i2c)
> > +{

[...]
> > +
> > +	dev_dbg(dev, "waveshare panel mcu version = 0x%x\n", data);
> > +
> > +	state->poweron_state = BIT(GPIO_TS_RESET);
> > +	regmap_write(regmap, REG_TP, state->poweron_state >> 8);
> > +	regmap_write(regmap, REG_LCD, state->poweron_state & 0xff);

And this can become waveshare_gpio_set().

> > +	msleep(20);
> > +
> > +	state->regmap = regmap;
> > +	state->gc.parent = dev;
> > +	state->gc.label = i2c->name;
> > +	state->gc.owner = THIS_MODULE;
> > +	state->gc.base = -1;
> > +	state->gc.ngpio = NUM_GPIO;
> > +
> > +	/* it is output only */
> > +	state->gc.get = waveshare_gpio_gpio_get;
> > +	state->gc.set = waveshare_gpio_gpio_set;
> > +	state->gc.get_direction = waveshare_gpio_gpio_get_direction;
> > +	state->gc.can_sleep = true;
> > +
> > +	ret = devm_gpiochip_add_data(dev, &state->gc, state);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to create gpiochip\n");
> > +
> 
> This driver looks like it could be easily converted to use gpio-regmap and
> become much shorter in the process. Could you please take a look at
> linux/gpio/regmap.h?

I took a glance. It is a nice wrapper, but I think being able to call
waveshare_gpio_set() internally without extra troubles overweights the
bonuses of the wrapper. Also, I'd agree if there were extra complexity
here (e.g. the stride or the in/out handling), but having just the out
GPIOs doesn't seem to warrant it.

An alternative would be to split away the backlight into a separate
pwm-backlight device. Then having waveshare_gpio_set() isn't that
important and thus I could switch to GPIO_REGMAP. But then... We don't
have real control over the PWM. We are really programming some values,
with the actual PWM duty cycle calculations being handled internally.

With all that in mind, unless you really insist, I'd prefer to leave
this part the driver as is.

> 
> > +	props.type = BACKLIGHT_RAW;
> > +	props.max_brightness = 255;
> > +	props.brightness = 255;
> > +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, state,
> > +					    &waveshare_gpio_bl, &props);
> > +	return PTR_ERR_OR_ZERO(bl);
> > +}
> > +

-- 
With best wishes
Dmitry
