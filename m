Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85A0E937F2
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0254F10E0CA;
	Sun, 12 Apr 2026 17:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXhNqKJu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6isTZlc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DCF10E0CA
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:18:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CE5RtB3690476
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=awvj3JA9kyhP+O20XoYCNKRQ
 hs00blktdD733kRwv78=; b=TXhNqKJuHoyRlvpafbZMF30GZ8EHAoH/FfLfQc6q
 1sqtm0N1eZ2KlFsMnRNI3tU8mBrlvZQFUdK6qdvLi5t4gMU3+jd/ou+zyRUlQBCq
 3IJsuM4xdmL+lCoGtpHvQGKWPu/RKKFqeF1w6IJvEczragNQmvKKrGx/ZS7khe0o
 7D7wPa1LdeeLJjrBoMnAHyB/k89WaPvff/qY/dfSntxTL9UK92Mvl7K2yt5LATTz
 sfA/g/c8EdwrZkOoOpoSxtgqYqO0lRADelK04aob/u8GeVQCRx7NFBChZj9MUrpC
 CvdJqJqD1l8OvsLlVQx9rgFFqZERRjODnSYTEMGMpOLxgQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhtp3e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:18:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da529ff48so91191651cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776014281; x=1776619081;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=awvj3JA9kyhP+O20XoYCNKRQhs00blktdD733kRwv78=;
 b=h6isTZlc0DOhnAcisJgp4m42qPxDZTBgmM3YhJ8YPTaegIp9KE4wb8A+5yibomgnPN
 zmEU/4zDgAWKkhEdhrq5Epa43+g3JRJRFfXXmSHibogtjtygrll4G0NOKw5nVq5neNKQ
 mkhRETlyWg95kBk58aZNpZXY8srmhSJZQjAO1Yo1Tx9ESoG4ynfC1hE3gaUUkqP7Nl2X
 touvG4Qj6lqXzEcuFIKt4p9fOlWRPdD6tvWI9WVnusGFjWY+duAsGjDe7CYeDPjSvbhq
 ntCVFVRvPzj65JWV9xzmNQaI5/QosmfPpvEt3nO3ECqd9I4GILZw8mKkf+fOrT/gf95V
 3gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776014281; x=1776619081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awvj3JA9kyhP+O20XoYCNKRQhs00blktdD733kRwv78=;
 b=pS/e4H5jx7qks4YxVsIU8QseVsiFr8FCv/w2f1+8S3WiAklmHd2JzoMsXdbB2A/cQX
 WXLeG7rrKpH1C8iMsxt00/xL0anu6Csi/SeVrKn8OWlU+t6WjLpoTLz5xv0fru6Skfc7
 5uyU3dC2YKOU13LofTt1gEazebuD6z5+4oV5y1wWr0Ei2XWfZGp9KVKwJnRSPFP8ZC3U
 k1i6xly5deGxUXlDpHCri95p9pRl+MjJIvdivktjmhkqfar70H3MI6GZORcpFwhhcZaC
 53fN5Ul3ZapeRq/WLD6YFVs3rI6tE3ckY/zLP024l+1F5E5yRxinXZ0GWMUEiKSmKvXv
 E/XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcDXzLPtYy7mQPRXBUzx1zIBBzAa1+CusRwVWOENH57mlE57f/TkQnV05GuPkYrG6YKr6Om4fW39U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywbmo/cu15kfzrrE6boEga550jK9L9xH9GkRsipuyYE2yuKJS9C
 LQzH6a1mpKlOSJF5E4ns3tTgKa3kG6Rv044nabjGqr8aTTq9QzpKGsmeHnQkO7TJ8G6uop/TnnN
 lx7MCLWf4iUIDTgPm+CUCG4ln7NTF1ejCGzdoNaUsmwllncW62z7KVhQtYR3nvFRWcVtwPjw=
X-Gm-Gg: AeBDieujkVy1OjPQn/SP/pOUfKe9vYCf0TJJU0RL08JYAelC3Cc8Q2ZobudlfCvql5x
 gBiUTrikauIqqmHi2ALzs/qMGO6rJC0ueZYzt+E3bHhqAPu+xOZOcd7mVyVFSGa4JJT8WEV1h9J
 vTpeVvrL3yEkvyhtRDM9w6x1ayAldS4+Rsgoh+9Zaqwj5+5VnPMeK31Hebw6zGVc2bp9GDLVqC1
 ZjQwcitGCtCWk+CHrmKyC6mDJkXcaj531stkDCIm/7DJGd+kdTzFdoJlbJH7L6H6cDrk0SWS0a1
 /hSeYS3Fj2BCFOYz6l+4RgLJRR36IzX+CWBMACP0131KI1pW7CtwT9NlxjhjETzIoay8v/SK3IF
 L7IPI7o7D/NEaL0Di971BvVIQiVnDqrNXUbszlUqKxwAIgxkdKE8U1/Sj8pFEL1SjagiXrvyipe
 ENlUElKAAdtubtiOUtH8+sAAH+BLhbJxYQoSk=
X-Received: by 2002:a05:622a:a707:b0:50d:a466:6d11 with SMTP id
 d75a77b69052e-50dd5b77e0cmr129285661cf.33.1776014281333; 
 Sun, 12 Apr 2026 10:18:01 -0700 (PDT)
X-Received: by 2002:a05:622a:a707:b0:50d:a466:6d11 with SMTP id
 d75a77b69052e-50dd5b77e0cmr129285111cf.33.1776014280832; 
 Sun, 12 Apr 2026 10:18:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee93264sm2063738e87.29.2026.04.12.10.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:17:59 -0700 (PDT)
Date: Sun, 12 Apr 2026 20:17:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH v2 21/21] gpio: add GPIO controller found on Waveshare
 DSI TOUCH panels
Message-ID: <mb6qy4hlwqvhwon57nlfc2aaqtc55lbwj5fjclv6y54wyimuhr@5qks67lpakz4>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
 <5d1dd70e-0300-4ca0-adb9-73f03cf4bf4d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1dd70e-0300-4ca0-adb9-73f03cf4bf4d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE2OSBTYWx0ZWRfX+w6LgBQqAF6C
 oTRt5ey9pPmQ33CC7HUpH89uEuMKgOCgWF30Gzqp7ww58k2JXCs8hTCMU/BMr+D7TxMO+FZRdFv
 ejAxUwbiMmKbkiJ5F4nMSPJo043NMNgR7WKQPX637+8midepGsnsvDuKfPvsmB8y3zlgq2BG+dR
 zAOjxI5zE/Y2xy+n8j8PhTmxN7sxpEqvuxPHP0OWeDnukgLW7ZzmPrkVEyJ9KkSIlvBLjRwbjOG
 JtcnzUOoYnjTHdiYShrvqZ4nn/LmQam6qiwEBVMNOgzoRKquTkGvwlkc6g5Q5/sBru90ODRCuOO
 pr6XryK0nc4ySJnptKw+0k5S9Fv0mtPIaNzJlKwzW4mTAk5d2C7m3ZgG/YLSXy26QN8d3DTT4sr
 BUVc/J0WxmgUfISmSYq7NtTnK2UFEYtakRBmvss5QDbMPLlVQAflfAU9+RJjevKFWWXI/5WSdbA
 AHFp85qFFw2C7z++Uog==
X-Proofpoint-ORIG-GUID: t54svy4Q6jWNqjzKuL4WFTAtpxPPJ50O
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69dbd3ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=uOKmLFOxzNBE1KF2lgkA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: t54svy4Q6jWNqjzKuL4WFTAtpxPPJ50O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120169
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

On Sun, Apr 12, 2026 at 09:06:51AM +0800, Jie Gan wrote:
> 
> 
> On 4/11/2026 8:10 PM, Dmitry Baryshkov wrote:
> > The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> > controller, which controls power supplies to the panel and the touch
> > screen and provides reset pins for both the panel and the touchscreen.
> > Also it provides a simple PWM controller for panel backlight. Add
> > support for this GPIO controller.
> > 
> > Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   drivers/gpio/Kconfig              |  10 ++
> >   drivers/gpio/Makefile             |   1 +
> >   drivers/gpio/gpio-waveshare-dsi.c | 208 ++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 219 insertions(+)
> > 
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index dbe7c6e63eab..1b210c451151 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -805,6 +805,16 @@ config GPIO_VISCONTI
> >   	help
> >   	  Say yes here to support GPIO on Tohisba Visconti.
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
> >   config GPIO_WCD934X
> >   	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controller driver"
> >   	depends on MFD_WCD934X
> > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > index 20d4a57afdaa..75ce89fc3b93 100644
> > --- a/drivers/gpio/Makefile
> > +++ b/drivers/gpio/Makefile
> > @@ -207,6 +207,7 @@ obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
> >   obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
> >   obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
> >   obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
> > +obj-$(CONFIG_GPIO_WAVESHARE_DSI_TOUCH)	+= gpio-waveshare-dsi.o
> >   obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
> >   obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
> >   obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
> > diff --git a/drivers/gpio/gpio-waveshare-dsi.c b/drivers/gpio/gpio-waveshare-dsi.c
> > new file mode 100644
> > index 000000000000..f4a1d4d3b872
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-waveshare-dsi.c
> > @@ -0,0 +1,208 @@
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
> > +};
> > +
> > +#define NUM_GPIO 16
> > +
> > +struct waveshare_gpio {
> > +	struct mutex dir_lock;
> > +	struct mutex pwr_lock;
> > +	struct regmap *regmap;
> > +	u16 poweron_state;
> > +
> > +	struct gpio_chip gc;
> > +};
> > +
> > +static const struct regmap_config waveshare_gpio_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = REG_PWM,
> 
> .max_register = REG_VERSION,
> 
> check comments in probe

Yep, thanks (and for other comments too)!


-- 
With best wishes
Dmitry
