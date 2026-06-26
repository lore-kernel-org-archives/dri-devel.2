Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE192C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5593710F70D;
	Fri, 26 Jun 2026 20:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xjkds+57";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceDlLRRo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B459E10F70D
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:41:40 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8d0e1980951
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1uaGDXBW7Kq2zoKPgn7o7FFe
 mmz8E/gP79jq5g9mVQc=; b=Xjkds+57Dv5n2+7wLveuOQqMfFuJrIZOpRqz/qhM
 eHoWOqTwnj+3hWHvxA1thaGFnVYtXyvor2zE0dd/sQ8+abmgcg/5SH4VRJEYeT+L
 UdwOiw8MfZyRXVBIYBd4aM9+HIhpwfFU8YyTh+fZAIHDbdyBi3N9O7E2V6S7kXZg
 KaNnf14O8VmBYlRWfXZotB+23q8UB6Jj4OC33y8x7sY7uweeHfWSnsEYUptaAXH+
 n6Vk8UKy4NF1H673BpD/gnMbmvKwE+OR+oEMnNx7Lq+G87RX7TavqULlmEagm7Zb
 dfxkLUCRHOd6El0gHdbE7/EdugdJqsxLlzTzYTp5Jok5ZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2ttj77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:41:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92af3d5e85aso169045785a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782506499; x=1783111299;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1uaGDXBW7Kq2zoKPgn7o7FFemmz8E/gP79jq5g9mVQc=;
 b=ceDlLRRo60L3nr0xD5nTb8xkkGFUUNvcrZc9vmabVP4Tcflm0w9YOjKwRHKR8mMx13
 xwDa6zjHrLDUk1XV8yNgNAfgSML7M+egs15NoMSJHIt8Ob7y70xN2/G+KLUBHkgyaEVX
 XZXFd3w5LfNyk+ljiCRi5A/REIv1mlavpsTk/6STnE8yIuRKpm4IlmYNEmzkp2+4mYF0
 Yyj3XeVV8jIJuf2jd7VOPFI/8zeimsOyo1cOPSzXi2a/XC9mHP7IYt1xXlDLRi9TcxFq
 pODCpUjZ/5B5UI+IKBrbJzlMxpOA48Ck4XWg/caxVmQHnafUsM/Bye4WJFh7hh+B63lu
 QMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782506499; x=1783111299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uaGDXBW7Kq2zoKPgn7o7FFemmz8E/gP79jq5g9mVQc=;
 b=T7G7zsaxNkwRsC3JKEHNpIp5inhaEqZxBTgC5WlbKckfo3ESJahO9+Joi/AuYnk5SS
 T/neWdWGsc681tol/atuw/FW3ihVHR8HjTO3uPMWQQYKaZkd/vPHn/Rolw5PpHqvzGtC
 lyvX78NpbDC3sfLzOk+t5rNS6db5m/CxFXOfdoXXyaYCsuyN5Gqs8UkrarQDb+CwmTiH
 EVwE59EcAz6prJyyo62aLsnMwqHkJ9Uj8ZRN+LrxmFOeOxqV8Ub1tXBI24H8fbbOOp4+
 T+d9E7ehauioMtA5OUbuMP6zkr18v7OarGcqVS6VJfUfzLcqoosNnEzTna0yf60sxbsg
 xEJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XswYoYPlqEyWE6V6D+ejB11qIwPfvJRW5XkZm0Goh/51qVAUPo0vmYAJfo+sSLww1UvLExPuAISo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypznKg+FmWipFPRP41rGniQo/IGNvtQ61PyLRZxfGwos4o9i9O
 YYaLFIQIUPsF4YwzioyCMWoE13uEgd5y64OjkSMRVf+04OzMeYqESjVX1lYUO/SoF34V0YPFH/k
 7V3uMErMaFjLfuwJUuAYtw5kfUCph8VvidioovnQ5dyoG1mGPtOdo5EoSiZyrWd+PKvT/RgE=
X-Gm-Gg: AfdE7cmF6P9tn/ANAIsiVpArV4g4YrlOuOVl/MSdtngwl9NoMzQo1GBxT8L98lp4diH
 4q+1onUNn2yhV5UoWGBnepUSv+uxfdZ+7mseXJ6/vPMg3RprMdvRPfrfxEQuOlR0x2S2k3n+m9S
 QOpC2DEGOQ8B0+FailGD8hhKwbPt3nNmz3vqZZkr+0RU46qgNLv7qsrishAvnP0S2NjYEm8rzKH
 dCiMzFJiuIB9qidqZC0kor6q8sh2VSxz1QQ6T2mNlGx1VQdORwfWpTUQceO1ipgXYrocBL+SVQj
 2dAGqauyKd6/RjGNU914m/oMgLy6o16B/raBp4gEyZNUaFXyaeuX+Zc1bmWIVPJfzq+lTAftMqK
 1Wn4p0rPKdoXeYE1ptLims5Lq1eWMOGTfQ+bmxM9delehB9bBdduvaDirt7tYBbb63v4t0CqUw9
 19sPIDy5bLrKPVE15+6NXFgVGU
X-Received: by 2002:a05:620a:44d4:b0:925:eb05:d194 with SMTP id
 af79cd13be357-9293d4b2daamr1286066085a.57.1782506498928; 
 Fri, 26 Jun 2026 13:41:38 -0700 (PDT)
X-Received: by 2002:a05:620a:44d4:b0:925:eb05:d194 with SMTP id
 af79cd13be357-9293d4b2daamr1286057785a.57.1782506498017; 
 Fri, 26 Jun 2026 13:41:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999b1b143fsm52646381fa.39.2026.06.26.13.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 13:41:35 -0700 (PDT)
Date: Fri, 26 Jun 2026 23:41:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ayushi.makhija@oss.qualcomm.com,
 rajeevny@qti.qualcomm.com
Subject: Re: [PATCH v3 2/2] drm/panel: add Ilitek ILI7807S panel driver
Message-ID: <5pvhrsikc3spr5jworztun7pjpgnkfihxvqd3dthhn7yeoud56@vcajuuwqplvo>
References: <20260624-ili7807s-v3-0-ddf37052a289@oss.qualcomm.com>
 <20260624-ili7807s-v3-2-ddf37052a289@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-ili7807s-v3-2-ddf37052a289@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE3MCBTYWx0ZWRfXw28DSIVFayXW
 k5BfvfImxvL/IJx7Vh5YBy+RjjUWRQ2kdHGCK3cauTTeIP5Bb/izlQwQkkCmP15g5fWozkoE7cd
 QurYo/hoJLeYoXCePpNtPTYRY+Hw4uo=
X-Proofpoint-GUID: eoS0MLNXTRsM-yNjVFLB_h5raSDQRPrE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE3MCBTYWx0ZWRfX8r2TKFpfsk6p
 rYWeVA/Ee/xAj01fLXENoZn533l0VSCTctvrLN78LW+SRTOuU/+kej1qjP7V8fZ7pmyX9NN5EQS
 Kw0MMBDUuKTETDKsrGob1UMUtwnBnvRsc4m24emYcX3z9y0Nv9nRk4xoQqSNGbWXSrfyyIWmPHg
 fr1PNuRxs4j93zXB8Di3W9cLHMQFicUtv/2cRxfQ2yaveX4RNuxnx9tYziXClpBEXaE79o4he7p
 53Bv6qRsTsBq0KMDvYcB4BXjE+kSJK2aEIjo/wssBxBaNZgpUPNzsFTwoIgG9RJ8UttkRVblwXa
 dEoLDfAFej882QW5/akjo+RenYkLzYZIlmX7ID6Oyw0AmVI5D3WGpmzshPZEJgdYePkmZBxQn8m
 Hm4RihbRA+JrEjzXQ1wTE3DZXX/hT4gHnRELqnxcMaY4Ff5PBOAjusr+EWjgC4zQSu1hCXo0Nna
 CwPE26IvhmW471RdYIA==
X-Proofpoint-ORIG-GUID: eoS0MLNXTRsM-yNjVFLB_h5raSDQRPrE
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3ee403 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=UkQgNfaBbZvMdpwfnggA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260170
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

On Wed, Jun 24, 2026 at 02:23:52PM +0530, Arpit Saini wrote:
> Add a DRM panel driver for the DLC DLC0697 1080x1920@60Hz MIPI DSI
> panel based on the Ilitek ILI7807S display controller.
> 
> The panel operates in video burst mode with four data lanes using
> RGB888 pixel format.
> 
> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  12 ++
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-ilitek-ili7807s.c | 293 ++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 7450b27622a2..1cbaac1bf545 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -264,6 +264,18 @@ config DRM_PANEL_HYDIS_HV101HD1
>  
>  	  If M is selected the module will be called panel-hydis-hv101hd1
>  
> +config DRM_PANEL_ILITEK_ILI7807S
> +	tristate "Ilitek ILI7807S-based panels"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y if you want to enable support for panels based on the
> +	  Ilitek ILI7807S display controller, such as the DLC DLC0697
> +	  1080x1920 MIPI DSI panel.
> +
> +	  If M is selected the module will be called panel-ilitek-ili7807s.
> +
>  config DRM_PANEL_ILITEK_IL9322
>  	tristate "Ilitek ILI9322 320x240 QVGA panels"
>  	depends on OF && SPI
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index c2c5cf817116..c3002b351cb8 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112B) += panel-himax-hx83112b.o
>  obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) += panel-himax-hx83121a.o
>  obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
>  obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
> +obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) += panel-ilitek-ili7807s.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
> new file mode 100644
> index 000000000000..8ddfab2693ec
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct panel_desc {
> +	const struct drm_display_mode *mode;
> +	unsigned int lanes;
> +	enum mipi_dsi_pixel_format format;
> +	unsigned long mode_flags;
> +	void (*init)(struct mipi_dsi_multi_context *dsi_ctx);
> +};
> +
> +struct ili7807s {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	const struct panel_desc *desc;
> +
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static const struct regulator_bulk_data ili7807s_supplies[] = {
> +	{ .supply = "vddi" },
> +	{ .supply = "avdd" },
> +	{ .supply = "avee" },
> +};
> +
> +static inline struct ili7807s *to_ili7807s(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ili7807s, panel);
> +}
> +
> +static void ili7807s_reset(struct ili7807s *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);

This looks like the reset being active-low. Please define it as is in
the DT and use normal (hold = 1, drop = 0) semantics in the driver.

> +}
> +
> +static void dlc0697_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_soft_reset_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x78, 0x07, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0x00);

mipi_dsi_dcs_set_tear_on_multi()

> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5e, 0x09, 0x99);

MIPI_DCS_SET_CABC_MIN_BRIGHTNESS

> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);

MIPI_DCS_WRITE_CONTROL_DISPLAY

> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x01);

MIPI_DCS_WRITE_POWER_SAVE

> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0x3f, 0xff);

mipi_dsi_dcs_set_display_brightness_large_multi(). Also please use
0x1fff instead of the full brightness.

> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
> +	mipi_dsi_msleep(dsi_ctx, 20);
> +}
> +
> +static int ili7807s_on(struct ili7807s *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;

Drop, set it in probe()

> +
> +	ctx->desc->init(&dsi_ctx);
> +
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;

Drop

> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ili7807s_off(struct ili7807s *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;

Drop

> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;

Drop

> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int ili7807s_prepare(struct drm_panel *panel)
> +{
> +	struct ili7807s *ctx = to_ili7807s(panel);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
> +	if (ret < 0) {
> +		dev_err(ctx->panel.dev, "failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(20);
> +
> +	ili7807s_reset(ctx);
> +
> +	ret = ili7807s_on(ctx);
> +	if (ret < 0) {
> +		dev_err(ctx->panel.dev, "failed to initialise panel: %d\n", ret);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
> +	return ret;
> +}
> +
> +static int ili7807s_unprepare(struct drm_panel *panel)
> +{
> +	struct ili7807s *ctx = to_ili7807s(panel);
> +	int ret;
> +
> +	ret = ili7807s_off(ctx);
> +	if (ret < 0)
> +		dev_err(ctx->panel.dev, "failed to disable panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
> +
> +	return 0;
> +}
> +
> +static int ili7807s_get_modes(struct drm_panel *panel,
> +			      struct drm_connector *connector)
> +{
> +	struct ili7807s *ctx = to_ili7807s(panel);
> +
> +	return drm_connector_helper_get_modes_fixed(connector, ctx->desc->mode);
> +}
> +
> +static const struct drm_panel_funcs ili7807s_panel_funcs = {
> +	.prepare = ili7807s_prepare,
> +	.unprepare = ili7807s_unprepare,
> +	.get_modes = ili7807s_get_modes,
> +};
> +
> +static int ili7807s_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return ret;
> +}
> +
> +static const struct backlight_ops ili7807s_bl_ops = {
> +	.update_status = ili7807s_bl_update_status,
> +};
> +
> +static struct backlight_device *ili7807s_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type           = BACKLIGHT_RAW,
> +		.brightness     = 0x3fff,
> +		.max_brightness = 0x3fff,
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +					      &ili7807s_bl_ops, &props);
> +}
> +
> +static const struct drm_display_mode dlc0697_mode = {
> +	.clock = 131911,

= (1080 + 18 + 2 + 16) * (1920 + 26 + 4 + 20) * 60 / 1000

> +
> +	.hdisplay    = 1080,
> +	.hsync_start = 1080 + 18,
> +	.hsync_end   = 1080 + 18 + 2,
> +	.htotal      = 1080 + 18 + 2 + 16,
> +
> +	.vdisplay    = 1920,
> +	.vsync_start = 1920 + 26,
> +	.vsync_end   = 1920 + 26 + 4,
> +	.vtotal      = 1920 + 26 + 4 + 20,
> +
> +	.width_mm  = 0,
> +	.height_mm = 0,

Do you really don't know the dimensions of the panel you are
contributing?

> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +

-- 
With best wishes
Dmitry
