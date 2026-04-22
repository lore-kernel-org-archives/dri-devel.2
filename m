Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91688FA1FDC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 18:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F091310EA48;
	Wed, 22 Apr 2026 18:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fBMdUNDl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DhXy5UMx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F9110EA48
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:50:44 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MHuHii2631268
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZZ/rC3G2Otsg3yWgS1m94gZy
 k3jVpDtL9qpL7MYYVFw=; b=fBMdUNDlDFh3BWJHOXQoSG/Cg2ltA7AtAuYWv3+z
 igyN1Z7Vimi22NF3HbMiXWWSuBQD73itn86oFwAek8XO5i3APWSrLgSDwkmtJASq
 fA6LB18rQbmMUPzhmBbo+wYqW2pzlqVdbombN8U3yT8Cq2v9eyrd8jP18Xqrq/wF
 fksatdw22wbMgSDl6qW4ppLw4a7+6TC4P8mWyIhJ1SUDiRaEAArQgsRNhiwDD1X4
 dKgtIipMQaNNJCzk+qIY8JY3pn/1EFfk6mySsjwlUOWFZjqaHT9se4Ak+fYSsed6
 EReyrImYUWRRtvTgELbQX1PNHv8l9PiNu4HSpr0Hy2JStw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35r862k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 18:50:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so32880971cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776883842; x=1777488642;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZ/rC3G2Otsg3yWgS1m94gZyk3jVpDtL9qpL7MYYVFw=;
 b=DhXy5UMx/7JQ61tLPFC4K5rwoq8eEcjXxMcuEFLUjB7Wpeh3saWEIoSuKnmnbAV8F8
 BccBqketyeEEXnWVhRFPVYt4CYWX8SLxqircJ8/KSNt+7T/GqS6ju67EbLFxpGie8wfX
 V/qH1YqTr0D5vDjQ4Pnj1Bw25Q4iB18zKPBut/xpSxxe1sfLP75f5+zGX4Nghrf2E+2T
 q2TrDJ8vnrfp3I66zhO1r2CZ3kNr+9YV2bpA5xXrmMnGy0uZxIDNRpc5qJ1HQBZr2qJd
 zBfFVnJHsAAEEi7tV/oHDM8NuiVhyYSPTrqHlf+9lZlnhsLF+rB2gltNWe5pXBlYHtXi
 3HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776883842; x=1777488642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZ/rC3G2Otsg3yWgS1m94gZyk3jVpDtL9qpL7MYYVFw=;
 b=opeBeuk7f3RsL1jEHsMmtblQzQtxRusqK3VtzlElBAdjv7XjNrATY49UFXvxx/Agwa
 1srjDu+5dczGLU2ugAFe3fHEO60gJvwYNDIGnx90CwTWF8hSz+DGKycPKQAQFD4wjZA6
 XVtfHzuNtzASEJemSkiiERbcchFQC8/twuCl7AWpV2uI2LI8+6jvWR7JZlNJNKRHXKrq
 QKvVMkXJwxnO1V5GvwfARDiL0CfuUSCNk5AE7X0yY04sT3DreU7Z61V56zvmhdryBS1g
 OzoqbOQLjshmNf+g+RcpPD31edw86XJW0Nhj1LxDyrWzMewcMXLVAqpBm+FVqlG9Mb3F
 YaqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9B/8EV3WReXGBkfUcu/AZ7WONpmwYAnotnvXzYK0aHz6bd0v73ovdFtw9LNQ5DuWNOxqlPigB4eaw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBt9qM/LXkitvFGCqd+nqNJcxsApzNPFNedm8NnDlKsu1sElEr
 gSig63Vfh4E3BTdsdIl1suIzf/aMPEMx8lxo6ysdXp+ha1lb0tcpBjnwIJqB3K9DeIpQtyh1eVj
 dXd0+DSLNjniogvF9nd71C4j1y6JknM67nX8Ra+bTe8wshBKdREzeUe7w/Gpmd6J+hmM5a+2RuH
 WdCwM=
X-Gm-Gg: AeBDieuJ4aWugQuLT1DQx0oBqJnYT7y7mRMgd3JG2mB1R/QrU5xw6hFD/bVFOwBhdCh
 wl0112TOSelAcIjgXNgT9L0hiGIgpG7dNpNM0F/QYvPnJETkj3gYWwAqc9bRbtk3IcdclENvCrf
 Tm0i+5IlFvSCwtphpQhyiD2SFALfLbc3pUsIFUyj+vXDuw6z93qIdC7m5sO/otzmr6Rvge7Ms41
 t+vNTeMCqV5IU8WpTbvwM2aWP1b5AswluH6pBQ3BeyFjuMt9CC9zgo15GH8vqXfXfJV5blkK5O0
 TlSIy/nz/piLhxq4kpsdtYET1O8qvJV/pE5luk7KcygVA8IYwURpZnhaQi5wpJR7emienLPP/PE
 MZ1yk/ALFcpxIvCXJ1kh0w5RgWCsD78I9evdmncddHhgSnwf3jInfKdWYQB8cS7WurY4mhBuDA+
 daYYNX4V96UVDOM/XMlUedh3o4Jl8t/o+SyHLUqW9JojqbHQ==
X-Received: by 2002:a05:622a:5147:b0:50e:631c:c38d with SMTP id
 d75a77b69052e-50e631cc483mr180983341cf.46.1776883841625; 
 Wed, 22 Apr 2026 11:50:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5147:b0:50e:631c:c38d with SMTP id
 d75a77b69052e-50e631cc483mr180982871cf.46.1776883841185; 
 Wed, 22 Apr 2026 11:50:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebef9sm4587237e87.77.2026.04.22.11.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 11:50:40 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:50:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: webgeek1234@gmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Teguh Sobirin <teguh@sobir.in>
Subject: Re: [PATCH v6 2/2] drm/panel: Add panel driver for ChipWealth
 CH13726A based panels
Message-ID: <57jvp4yi6mhut7yveoq25qgxowc747mu6x47xf4kicdm73dpur@s76omxabsga5>
References: <20260422-ch13726a-v6-0-03680d6673ff@gmail.com>
 <20260422-ch13726a-v6-2-03680d6673ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-ch13726a-v6-2-03680d6673ff@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4MyBTYWx0ZWRfX36gpbS5oyY1c
 lbvLjrX/LkExdsWFrEzgsamQGPywH5Takr0eSc+DczusREuJyZ7q6BOsgW0QuURVCxNqxsbAcn3
 8nJ1g3oREkRcAcaiYGT+H563hoXUx9wQvRE89kXINDsFlofsZJad/yrzwbvz20o+PFPsZXy1GHx
 0DmTXpCR2H7dh+rAhtn5p4UYpw5SjJyToCHwh1I37MtlVZOH6AENb+SwNB0paB9ngq03VWgMlPB
 dpnJOYLEMTOtUmQ0HINL1q5MiuDF/KiVW/nN02rCpN5aqILSu1nBL2699wd4BcAGdXGyqo+qWI4
 e/YRaJTPVnipkGYOLGv8kiTWMb0dSb8+Xsyop1r+IC952NoIEIlTGFRHsS6d5GLO4X0Dq5r0BqX
 wvuQ7qm4kolxUVsF/Q30FJ2AhyrL05xdyz+Hv0YEOpXNhtOy7VLdYKWwVR0+HOZSU0MAGDVw1d4
 cVqx676xkngZcPnlhpA==
X-Proofpoint-ORIG-GUID: J_axKqs4Us_kfZXfiasJxgd69dXVGPfn
X-Proofpoint-GUID: J_axKqs4Us_kfZXfiasJxgd69dXVGPfn
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69e91882 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=-GCnFWqknJ9Tug8pFpUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220183
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

On Wed, Apr 22, 2026 at 02:43:25AM -0500, Aaron Kling via B4 Relay wrote:
> From: Teguh Sobirin <teguh@sobir.in>
> 
> This is used by the AYN Thor for the bottom panel.
> 
> Signed-off-by: Teguh Sobirin <teguh@sobir.in>
> Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                     |  11 +
>  drivers/gpu/drm/panel/Makefile                    |   1 +
>  drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 333 ++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index d6863b28ddc559..e2c00f08f4507d 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -105,6 +105,17 @@ config DRM_PANEL_BOE_TV101WUM_LL2
>  	  Say Y here if you want to support for BOE TV101WUM-LL2
>  	  WUXGA PANEL DSI Video Mode panel
>  
> +config DRM_PANEL_CHIPWEALTH_CH13726A
> +	tristate "CHIPWEALTH CH13726A-based DSI panel"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DP_HELPER
> +	select DRM_DISPLAY_HELPER
> +	help
> +	  Say Y here if you want to enable support for ChipWealth
> +	  CH13726A-based display panels.
> +
>  config DRM_PANEL_EBBG_FT8719
>  	tristate "EBBG FT8719 panel driver"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index a4291dc3905bed..343d283d1620fb 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_BOE_TD4320) += panel-boe-td4320.o
>  obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) += panel-boe-th101mb31ig002-28a.o
>  obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) += panel-boe-tv101wum-ll2.o
>  obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
> +obj-$(CONFIG_DRM_PANEL_CHIPWEALTH_CH13726A) += panel-chipwealth-ch13726a.o
>  obj-$(CONFIG_DRM_PANEL_DSI_CM) += panel-dsi-cm.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> new file mode 100644
> index 00000000000000..175f40e752126f
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChipWealth CH13726A MIPI-DSI panel driver
> + * Copyright (c) 2024, Teguh Sobirin <teguh@sobir.in>.
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
> +
> +#include <video/mipi_display.h>
> +
> +static const struct regulator_bulk_data ch13726a_supplies[] = {
> +	{ .supply = "vdd1v2", },
> +	{ .supply = "vddio", },
> +	{ .supply = "vdd", },
> +	{ .supply = "avdd", },
> +};
> +
> +struct ch13726a_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct regulator_bulk_data *supplies;
> +	struct gpio_desc *reset_gpio;
> +	struct ch13726a_desc *desc;
> +	enum drm_panel_orientation orientation;
> +};
> +
> +struct ch13726a_desc {
> +	unsigned int width_mm;
> +	unsigned int height_mm;
> +	unsigned int bpc;
> +
> +	const struct drm_display_mode *modes;
> +	unsigned int num_modes;
> +};
> +
> +static inline struct ch13726a_panel *to_ch13726a_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct ch13726a_panel, panel);
> +}
> +
> +static void ch13726a_reset(struct ch13726a_panel *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 11000);

This looks like the active-low reset. Should it be rather described as
GPIO_ACTIVE_LOW in the DT?

> +}
> +

Other than that:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
