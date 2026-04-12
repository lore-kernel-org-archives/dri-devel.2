Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6490CF3ED4A
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 01:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C0610E27D;
	Sun, 12 Apr 2026 01:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LcCMSJ5X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fj330J7V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801F010E27D
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 01:10:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B48N1U1201965
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 01:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yyw915w7CN2Ucujh2TM/cNADCTu08+fT8ReCAQdEMoY=; b=LcCMSJ5X2Kf8An3D
 hsp9V6uqb94B70aXCltnlTIXtDWAaGYot8JjtDogmmP0wJvvT7A3Nt1UmdCS3jQV
 cn4P1gbx9TWZnE3EmxRodkz/WL0sJVYCJROIxCowjex34V6nwV7DOMbaxHjHACrY
 nSSZhyigGzrb1bI1TeFa5B3We1lvxowBxVJjHOq2n+ZpiB/qkgWIjFHUewZ8fI6b
 Rv8eVApkCt8BzN6u2ioQn8w3X9S16SpqZ0jnq+cHVQmqYxb0TkJ9dAhs3GwBOY8c
 Fz73EaXfZPzVMWhE6+ySWo0zcaGyFLP8ErS21p07p1Rd830kzXL8O2LYT5EGBzfB
 sqqKIg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jsk96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 01:10:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so22915785ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775956205; x=1776561005;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yyw915w7CN2Ucujh2TM/cNADCTu08+fT8ReCAQdEMoY=;
 b=Fj330J7VM/Ccwdn8H9jEbmUyepJooqjNBikDSliPBQaoeutII9Kk2mB0geYT0+u925
 uGhrjT/NK5m+RwMXzg0xkGliNzPTqfiha7/VleYZ6dWy+BwA8sU9VPnfrbWsE0v/2U/E
 m5bTaWZsqgufV5Gglc6/xP3FSvxRhHSKBZw0LkTmcFcXWd7bJtcV8L5OJOeOB1cmRWEz
 aj+sdU9dgBPUQGueycc8krvoNx0FHZ9aZzfLWJlwZ+tnvJVdPFHWavo+GT7niJy9IA1P
 S2cdop2wFfGAZ2x5QD8IdxDyff6sy16CwSeyrbWfXwzQgNhgzXJzLgL1vgNWnoc1muTi
 BHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775956205; x=1776561005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yyw915w7CN2Ucujh2TM/cNADCTu08+fT8ReCAQdEMoY=;
 b=pCUEqZqIXuvWqQvnRuN/ZJN0R+M4CuFVHe2Vq01bw7FQVTwU35eJdoxapKucUaqpeu
 GoDggIfNtTDOtvxxMoZGxXRUn3ozweKNy38cIrugWBYTmb38ZaECuJm6g3IY+YzxLFCM
 g4/t/szAtnqCarIjPAlqv2ZxOMizxsHitG0VlXjEfnn+O3J/pc6lHxdxFXZUC1e3Tir5
 2HO0LYFqxtoOXr2imAHChd2gs91UzPyXqsd3/DEDLyX4sf8jJiyrYlDs8ECnWEZ4MG9T
 zJkseYp9zArW9j5L/2M1DpveXXuVv3cStzDSBoZcmP/CPzkS7RwyXJQ3/NGU3hLw/8rS
 Yqig==
X-Gm-Message-State: AOJu0YwT/xYh5pNKd4stDzl6pakXJ2c2nl5Ug28VoFOfxbILaOZFY/Hz
 H2uO26qyJdh/ZjJJT/f71+6pmkuXXHoveQ01uf440aTV80gxZXULVWZJCItkClAPNLHglcjUImB
 cIklzW3pAEL/ExpuCr6H62X7o0UlJDiZeAIdB+uNAuHLvr3+zSRbAGAohyk/TXY3vSzlZr3Q=
X-Gm-Gg: AeBDiessXn6Pidx6hCadkLs3X6CVe09bcGezYHlwyGicjPhSL36Ardyi+8wM6Ub+XxA
 mZY9RXngbgjDqlOTuAt0cksnaiYBB8bhCDaEc5cN/UqfPyVSIzVF0mSJqpQfx2FT6gMJ96ntVQ5
 RvWw51K1ZDOqJqIIeFypO7tXv1QD1Hnswc6Sddfp/qZjMplq7J6YNtDKCUmo0teubqMAb4oayj7
 i2dnApkyaP4rVtrxgH3hnnwVkpnWatCjH6wpd8Zu/HoMjypN4vot860+wJkqLlGERiNlNwOSiV+
 qrVO7WV2AQGIb+EWxffIgatbaSfRMsuOMh6JjYjRAEe+qWYezMUF19d4RwE8hHK1oLpwyYeXK0y
 sYmLwwrf93R/CAbD5uRtAQ33pXbXfwmuysZdokn+zkBVerMur927IfXI8sJD+ou1jL4wI/Q7yqd
 x1TSSKW7i6WQ==
X-Received: by 2002:a17:902:be0a:b0:2b0:663f:6b53 with SMTP id
 d9443c01a7336-2b2d599ab4amr62318745ad.13.1775956204844; 
 Sat, 11 Apr 2026 18:10:04 -0700 (PDT)
X-Received: by 2002:a17:902:be0a:b0:2b0:663f:6b53 with SMTP id
 d9443c01a7336-2b2d599ab4amr62318525ad.13.1775956204259; 
 Sat, 11 Apr 2026 18:10:04 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f43994sm72371285ad.80.2026.04.11.18.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 18:10:03 -0700 (PDT)
Message-ID: <b52dc143-5238-408e-9162-632b5a1386fd@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 09:09:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/21] drm/panel: add driver for Waveshare 8.8" DSI
 TOUCH-A panel
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-19-75cdbeac5156@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-19-75cdbeac5156@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwOCBTYWx0ZWRfXzV35hxAE+37C
 lMZx+61BMrs8Je0kH+lZ1znmXhlb9gqI3RP8W8YoyNFJSRJnINwmBksJ+pNGDsXeJ7+hcsZc44A
 G2JyCxKtSkD9NThbjybzgIWfR/r4wlNy8+0nYtJ+fmoYtJM8wOi5ZTdXho1//wJWZxtMAYtmdGg
 HBH+4d01i7g60XfUJLNfJ1U7fxP6PxqkIu98MJoZvSNQqo/T9icJswAayK4g6dL60qPOuiVBxZ2
 32QUkdAjOcuiEUC7B/gkQccOcyv+rs9z89R0DF0D5HJ+kY89uyEyvIO6rbIba0Xt8zGmiP3DiFz
 klbT237waxU+FNlTYCUvtBWcsf+OsSruPnJLRfEMRbTO+NY4LDr7J/qxnjiWoC+mqcumUmn1/LI
 H6VubIBPosnY5Xlar4+PlyrtFWz80VQRm6WHP+auooXunRHdA8ToEohuYGqeLFrF74aJ2d1v2jY
 i5n3/tn8pG7gtywt0vQ==
X-Proofpoint-ORIG-GUID: h9a0tNat3GWac9mCn78HT8-kgTxKqxDR
X-Proofpoint-GUID: h9a0tNat3GWac9mCn78HT8-kgTxKqxDR
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69daf0ee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6uJ51tyDExStV_pVDtAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
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
> Add driver for the panel found on Waveshare 8.8" DSI TOUCH-A kit. It
> uses ota7290b IC as a controller.
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/Kconfig                    |  12 ++
>   drivers/gpu/drm/panel/Makefile                   |   1 +
>   drivers/gpu/drm/panel/panel-focaltech-ota7290b.c | 208 +++++++++++++++++++++++
>   3 files changed, 221 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index ba527b4d7737..979109c27b9b 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -144,6 +144,18 @@ config DRM_PANEL_FEIYANG_FY07024DI26A30D
>   	  Say Y if you want to enable support for panels based on the
>   	  Feiyang FY07024DI26A30-D MIPI-DSI interface.
>   
> +config DRM_PANEL_FOCALTECH_OTA7290B
> +	tristate "Focaltech OTA7290B"
> +	depends on DRM_MIPI_DSI
> +	depends on I2C
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_KMS_HELPER
> +	help
> +	  Enable support for panels using OTA7290B as a controller (for
> +	  example, Waveshare 12.3" DSI TOUCH-A panel). Say Y here if you want
> +	  to enable support for this panel. To compile this driver as a module,
> +	  choose M here.
> +
>   config DRM_PANEL_DSI_CM
>   	tristate "Generic DSI command mode panels"
>   	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index a4291dc3905b..0d694acbfbb6 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_DRM_PANEL_EBBG_FT8719) += panel-ebbg-ft8719.o
>   obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) += panel-elida-kd35t133.o
>   obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) += panel-feixin-k101-im2ba02.o
>   obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
> +obj-$(CONFIG_DRM_PANEL_FOCALTECH_OTA7290B) += panel-focaltech-ota7290b.o
>   obj-$(CONFIG_DRM_PANEL_HIMAX_HX8279) += panel-himax-hx8279.o
>   obj-$(CONFIG_DRM_PANEL_HIMAX_HX83102) += panel-himax-hx83102.o
>   obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) += panel-himax-hx83112a.o
> diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> new file mode 100644
> index 000000000000..991d6a4caf17
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Waveshare International Limited
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct ota7290b {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +
> +	struct regulator *power;
> +	struct gpio_desc *reset;
> +	struct regulator *avdd;
> +	struct regulator *iovcc;
> +
> +	enum drm_panel_orientation orientation;
> +};
> +
> +static inline struct ota7290b *panel_to_ota(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ota7290b, panel);
> +}
> +
> +static int ota7290b_prepare(struct drm_panel *panel)
> +{
> +	struct ota7290b *ctx = panel_to_ota(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +	int ret;
> +
> +	if (ctx->iovcc) {
> +		ret = regulator_enable(ctx->iovcc);
> +		if (ret)
> +			dev_err(panel->dev, "failed to enable IO regulator: %d\n", ret);
> +	}
> +
> +	if (ctx->avdd) {
> +		ret = regulator_enable(ctx->avdd);
> +		if (ret)
> +			dev_err(panel->dev, "failed to enable AVDD regulator: %d\n", ret);
> +	}
> +
> +	if (ctx->reset) {
> +		gpiod_set_value_cansleep(ctx->reset, 0);
> +		msleep(60);
> +		gpiod_set_value_cansleep(ctx->reset, 1);
> +		msleep(60);
> +		gpiod_set_value_cansleep(ctx->reset, 0);
> +		msleep(60);
> +	}
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 50);
> +
> +	if (dsi_ctx.accum_err < 0)
> +		dev_err(panel->dev, "failed to init panel: %d\n", ret);

better to check dsi_ctx.accum_err instead ret here?

dev_err(panel->dev, "failed to init panel: %d\n", dsi_ctx.accum_err);

Thanks,
Jie

> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ota7290b_unprepare(struct drm_panel *panel)
> +{
> +	struct ota7290b *ctx = panel_to_ota(panel);
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +
> +	if (ctx->reset) {
> +		gpiod_set_value_cansleep(ctx->reset, 1);
> +		msleep(5);
> +	}
> +
> +	if (ctx->avdd)
> +		regulator_disable(ctx->avdd);
> +
> +	if (ctx->iovcc)
> +		regulator_disable(ctx->iovcc);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode waveshare_dsi_touch_8_8_a_mode = {
> +	.clock = 75000,
> +
> +	.hdisplay = 480,
> +	.hsync_start = 480 + 50,
> +	.hsync_end = 480 + 50 + 50,
> +	.htotal = 480 + 50 + 50 + 50,
> +
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 20,
> +	.vsync_end = 1920 + 20 + 20,
> +	.vtotal = 1920 + 20 + 20 + 20,
> +
> +	.width_mm = 68,
> +	.height_mm = 219,
> +	.type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static int ota7290b_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &waveshare_dsi_touch_8_8_a_mode);
> +}
> +
> +static enum drm_panel_orientation ota7290b_get_orientation(struct drm_panel *panel)
> +{
> +	struct ota7290b *ctx = panel_to_ota(panel);
> +
> +	return ctx->orientation;
> +}
> +
> +static const struct drm_panel_funcs ota7290b_funcs = {
> +	.prepare = ota7290b_prepare,
> +	.unprepare = ota7290b_unprepare,
> +	.get_modes = ota7290b_get_modes,
> +	.get_orientation = ota7290b_get_orientation,
> +};
> +
> +static int ota7290b_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct ota7290b *ctx;
> +	int ret;
> +
> +	ctx = devm_drm_panel_alloc(&dsi->dev, struct ota7290b, panel,
> +				   &ota7290b_funcs,
> +				   DRM_MODE_CONNECTOR_DSI);
> +	if (!ctx)
> +		return -ENOMEM;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +	ctx->dsi = dsi;
> +
> +	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->reset))
> +		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
> +				     "Couldn't get our reset GPIO\n");
> +
> +	ctx->iovcc = devm_regulator_get_optional(&dsi->dev, "iovcc");
> +	if (IS_ERR(ctx->iovcc))
> +		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
> +					"Couldn't get our iovcc supply\n");
> +
> +	ctx->avdd = devm_regulator_get_optional(&dsi->dev, "avdd");
> +	if (IS_ERR(ctx->avdd))
> +		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->avdd),
> +					"Couldn't get our avdd supply\n");
> +
> +	ret = of_drm_get_panel_orientation(
> +			dsi->dev.of_node, &ctx->orientation);
> +	if (ret) {
> +		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
> +			dsi->dev.of_node, ret);
> +		return ret;
> +	}
> +
> +	ret = drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	ctx->panel.prepare_prev_first = true;
> +
> +	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_HSE |
> +		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	dsi->format = MIPI_DSI_FMT_RGB888,
> +	dsi->lanes = 2;
> +
> +	return devm_mipi_dsi_attach(&dsi->dev, dsi);
> +}
> +
> +static const struct of_device_id ota7290b_of_match[] = {
> +	{ .compatible = "waveshare,8.8-dsi-touch-a", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ota7290b_of_match);
> +
> +static struct mipi_dsi_driver ota7290b_driver = {
> +	.probe		= ota7290b_probe,
> +	.driver = {
> +		.name		= "focaltech-ota7290b",
> +		.of_match_table	= ota7290b_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(ota7290b_driver);
> +
> +MODULE_DESCRIPTION("Panel driver for Focaltech OTA7290B panels");
> +MODULE_LICENSE("GPL");
> 

