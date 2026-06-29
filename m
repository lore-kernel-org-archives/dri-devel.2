Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9CEC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CE110E061;
	Mon, 29 Jun 2026 09:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPQxh9/Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayz7YXV0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8814F10E061
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:51:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T8wVjT2391252
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hjPLHndmLVKQTG4TpiuHBOh11+YSR/gs656clgRuRBY=; b=BPQxh9/QX9qx323n
 AlpS8CL0dXRqKQYQx7sLhm6VFBFEuFqEPtpsB3fWvXVQPZpcydyvuQq4ikRebJ/n
 2C9k2/gaaRN5ka+JkoN4teZ9vH+6PbHs3MeSi0T4dCZXQy8bQ2oc7ofjVEDzbApy
 YOvmNLzaDgS3uyY4wp5pH2tE7c1VdhBHHQTKYH8mmav74kKm89MFurT+dN/P/2RS
 GbdEMUQcdapnWS/X7dqSxXTmGy32ukitikVXsqk/X5pL61zkJyUEI6So/zxCqTVf
 GPQurw7NuUcfRrRZ4c9S2yl/yZfXR6mLT12Gs8pDmPz0fPhCuPDDtjWvzqH8yzwC
 Rs4dyQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw87qr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:51:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c7f385887bso51706975ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782726690; x=1783331490;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hjPLHndmLVKQTG4TpiuHBOh11+YSR/gs656clgRuRBY=;
 b=ayz7YXV0RAv3wS8iYFiFF9G+BxydRdPdLCL5KWYFZF/UzWGuyRqDppa1N8uyTd0nrQ
 lmvAbBbCDNHn9VwvgK6EqygiGUYrikpulZtPow7RtgekOAfuWkt3h/4tAjaIlRwks9P3
 7ZSLcl14zyT+5FWfRikqkdO092GHmGqvKuvb5gI5yBhRS627k0xowjsnhWzjprCcV3Fq
 Zl1BZPtU3MBH+oESfPM1sPcnU5RteHaU+qo3Tj6BChC5+PnSoFpQHE2upeOXTDYDJhd/
 TLpfAlAWymPe1hg6WSKKyUxS8GOLl/RstLlxquJ0uEev1RgyB/5DHF9L/4qZpM08XZLQ
 It6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782726690; x=1783331490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hjPLHndmLVKQTG4TpiuHBOh11+YSR/gs656clgRuRBY=;
 b=QL+NC5vyfUp4l7aAha4c5D5Q9PJTKzKQOpHjHH1oT2U0HY3FIrBpnasYOcH8HsSlaO
 jrZ+Tqt5zk1UsKUKkIt0Vv/kQ+zUQ9UYwEwAbygCoCunYYuDRLVodg+gbN5/yK3JY5FD
 8SHsiThtrI+vcueTxYgDhj97Xo4Y0UTh0B39iKijk/JVmfefPuOkb+ZB0ks/jotWHrxh
 OOPUpHUlq/EPDuEcLzA5ecSwCp7d1YXQe5mp8URg4XwDWyoQpDKUdkGquvsPDvfGyLL0
 j2y3BtvnXdcbaounm6dwsHvfVmwxKTHmZlFRbx+YT528PRx2kkU7pi5Aqib7ILWw1BrD
 t7SQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rphr/GRs2TM9z2zfmlpVcLe8NIdQv9Eot1gNR7PIX5dy+/8/3FxeSzDWLKrx/wliUmkzEkfq0pYBrM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUE719A9hKP67LJQ5kAkyUFP4NIYjSvyYHSVfV4iYdOrES/kxW
 CYAh4aQql+m39Ajkt+lmJi1o7d6DYEemajKHuaM7MfREP9HFp5Qgx7e5NbqiE8PA0zg3+Of6h4Q
 ux4J1pa1dX1GJoYcv1pN6jOj/FbZAYK93NDi+8QXomrzmHLz3bkN306KfJ/BjI1t8YJOCf4c=
X-Gm-Gg: AfdE7cn0g5XCQKiqxmpzxIMdDlgnv0AGQNNtFzHANiShKLR8DZbiC2wfBIgrHKO6qSb
 5Xa9UNZAbf2lLguBuQ8nbn92PL/huDFhPLtsEtoVwvNtMrX8bOcCNnyqTdiWglo0S/EUAJvPJvG
 90RZNpr31SJdfcHQAjHspmyr0ZDATXo3sP2F6c+PKEY/VdQOQvvYw4nFwkZpY41Zy2rzvcXJ10L
 yThMsy4xaXnsnOhGtMVWQJOxs4LmMHw8gVoV+f6Cw4LMNNmTjj+BK94DG1BZxhktp1nBXHwZn5v
 ZP5M1sOLEpEy28SdsYUpG02BgKPTnS2/McDF9UmNA+RXia9B8AFW/FBUQTRItikj46UTkiEFUOd
 lasc/Q0mBjGzF1siU0OFCls1CFIJUk6HWE4KIZos9
X-Received: by 2002:a17:903:32c4:b0:2c9:ff83:41e3 with SMTP id
 d9443c01a7336-2c9ff834537mr22842615ad.21.1782726689909; 
 Mon, 29 Jun 2026 02:51:29 -0700 (PDT)
X-Received: by 2002:a17:903:32c4:b0:2c9:ff83:41e3 with SMTP id
 d9443c01a7336-2c9ff834537mr22842375ad.21.1782726689261; 
 Mon, 29 Jun 2026 02:51:29 -0700 (PDT)
Received: from [10.206.100.243] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c980f15234sm51913875ad.39.2026.06.29.02.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 02:51:28 -0700 (PDT)
Message-ID: <8236a2a1-040a-4ef3-ae14-41c1127a749b@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:21:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/panel: add Ilitek ILI7807S panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
References: <20260624-ili7807s-v3-0-ddf37052a289@oss.qualcomm.com>
 <20260624-ili7807s-v3-2-ddf37052a289@oss.qualcomm.com>
 <5pvhrsikc3spr5jworztun7pjpgnkfihxvqd3dthhn7yeoud56@vcajuuwqplvo>
Content-Language: en-US
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
In-Reply-To: <5pvhrsikc3spr5jworztun7pjpgnkfihxvqd3dthhn7yeoud56@vcajuuwqplvo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3OSBTYWx0ZWRfX66NPo3ZJJxy+
 cueHxu8rIO3a89ng5y6i+FlnE9OGWq1HCvjRqtPUTnGie9KH6RMLzG8kn0Aoxm/58HsiMeehMx7
 rujqxHrmAmDyJdq7001OGL1o5qDYi1o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3OSBTYWx0ZWRfX/01AXNEPsxv5
 QN45Ulm1dj8s5NgRzSrvdEc3dgOHoZWL5oZLffoXdiQIGPwxYFqnNzGvKlptpASvReklQDZUi4d
 VEEtGLnwMLCQ2UkpDbCbEZL/E1RRsd9QoSiSDByHeREr7PtmnsLpRjQnBUrWuIrX10SHD7btMHz
 O6TGnnc2ed80+j22ptlqHAJpqaEJ0b96+kNAQrUdeKR9pLRdZGaZcRszhDfHhdHhP+K8Dhs0Vz4
 WJSMdHtMuUnn1xOI5TEULQke0npya2JCnUSenAFjPDmep1bh/jqWp5KJgXhDNU13Y4a8MAh8Qmv
 iPSciIbMUeHlQMIjHv1ZmiH96IKhdWrSV1WeZE6stZBSkphwimBaH/8AxqQGyVNUr8bGTC7IZDv
 ZQduuFrmhbXnwXV0xWSnQa3sNI95GQwmBp/MgF6UPLaFDcdplxisdEKRe3ydYIdOAItFS6fYRLH
 1OVNeQmY27XYN25MVdQ==
X-Proofpoint-GUID: cWG8ikMB-X5t113__MOD2rLoOlbrLyDW
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a424022 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yukSKlyBphtQfdkUWQ4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: cWG8ikMB-X5t113__MOD2rLoOlbrLyDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290079
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

Hi Dmitry,

On 6/27/2026 2:11 AM, Dmitry Baryshkov wrote:
> On Wed, Jun 24, 2026 at 02:23:52PM +0530, Arpit Saini wrote:
>> Add a DRM panel driver for the DLC DLC0697 1080x1920@60Hz MIPI DSI
>> panel based on the Ilitek ILI7807S display controller.
>>
>> The panel operates in video burst mode with four data lanes using
>> RGB888 pixel format.
>>
>> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/panel/Kconfig                 |  12 ++
>>   drivers/gpu/drm/panel/Makefile                |   1 +
>>   drivers/gpu/drm/panel/panel-ilitek-ili7807s.c | 293 ++++++++++++++++++++++++++
>>   3 files changed, 306 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index 7450b27622a2..1cbaac1bf545 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -264,6 +264,18 @@ config DRM_PANEL_HYDIS_HV101HD1
>>   
>>   	  If M is selected the module will be called panel-hydis-hv101hd1
>>   
>> +config DRM_PANEL_ILITEK_ILI7807S
>> +	tristate "Ilitek ILI7807S-based panels"
>> +	depends on OF
>> +	depends on DRM_MIPI_DSI
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	help
>> +	  Say Y if you want to enable support for panels based on the
>> +	  Ilitek ILI7807S display controller, such as the DLC DLC0697
>> +	  1080x1920 MIPI DSI panel.
>> +
>> +	  If M is selected the module will be called panel-ilitek-ili7807s.
>> +
>>   config DRM_PANEL_ILITEK_IL9322
>>   	tristate "Ilitek ILI9322 320x240 QVGA panels"
>>   	depends on OF && SPI
>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
>> index c2c5cf817116..c3002b351cb8 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -26,6 +26,7 @@ obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112B) += panel-himax-hx83112b.o
>>   obj-$(CONFIG_DRM_PANEL_HIMAX_HX83121A) += panel-himax-hx83121a.o
>>   obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
>>   obj-$(CONFIG_DRM_PANEL_HYDIS_HV101HD1) += panel-hydis-hv101hd1.o
>> +obj-$(CONFIG_DRM_PANEL_ILITEK_ILI7807S) += panel-ilitek-ili7807s.o
>>   obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
>>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) += panel-ilitek-ili9341.o
>>   obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) += panel-ilitek-ili9805.o
>> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
>> new file mode 100644
>> index 000000000000..8ddfab2693ec
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
>> @@ -0,0 +1,293 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/backlight.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_modes.h>
>> +#include <drm/drm_panel.h>
>> +#include <drm/drm_probe_helper.h>
>> +
>> +struct panel_desc {
>> +	const struct drm_display_mode *mode;
>> +	unsigned int lanes;
>> +	enum mipi_dsi_pixel_format format;
>> +	unsigned long mode_flags;
>> +	void (*init)(struct mipi_dsi_multi_context *dsi_ctx);
>> +};
>> +
>> +struct ili7807s {
>> +	struct drm_panel panel;
>> +	struct mipi_dsi_device *dsi;
>> +	const struct panel_desc *desc;
>> +
>> +	struct regulator_bulk_data *supplies;
>> +	struct gpio_desc *reset_gpio;
>> +};
>> +
>> +static const struct regulator_bulk_data ili7807s_supplies[] = {
>> +	{ .supply = "vddi" },
>> +	{ .supply = "avdd" },
>> +	{ .supply = "avee" },
>> +};
>> +
>> +static inline struct ili7807s *to_ili7807s(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct ili7807s, panel);
>> +}
>> +
>> +static void ili7807s_reset(struct ili7807s *ctx)
>> +{
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>> +	usleep_range(10000, 11000);
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +	usleep_range(10000, 11000);
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>> +	usleep_range(10000, 11000);
> This looks like the reset being active-low. Please define it as is in
> the DT and use normal (hold = 1, drop = 0) semantics in the driver.\
Ack.
>
>> +}
>> +
>> +static void dlc0697_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
>> +{
>> +	mipi_dsi_dcs_soft_reset_multi(dsi_ctx);
>> +	mipi_dsi_msleep(dsi_ctx, 120);
>> +
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x78, 0x07, 0x00);
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x35, 0x00);
> mipi_dsi_dcs_set_tear_on_multi()
>
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5e, 0x09, 0x99);
> MIPI_DCS_SET_CABC_MIN_BRIGHTNESS
>
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x24);
> MIPI_DCS_WRITE_CONTROL_DISPLAY
>
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x01);
> MIPI_DCS_WRITE_POWER_SAVE
Ack.
>
>> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51, 0x3f, 0xff);
> mipi_dsi_dcs_set_display_brightness_large_multi(). Also please use
> 0x1fff instead of the full brightness.
>
>> +
>> +	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
>> +	mipi_dsi_msleep(dsi_ctx, 120);
>> +
>> +	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
>> +	mipi_dsi_msleep(dsi_ctx, 20);
>> +}
>> +
>> +static int ili7807s_on(struct ili7807s *ctx)
>> +{
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>> +
>> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> Drop, set it in probe()
Ack.
>
>> +
>> +	ctx->desc->init(&dsi_ctx);
>> +
>> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> Drop
>
>> +
>> +	return dsi_ctx.accum_err;
>> +}
>> +
>> +static int ili7807s_off(struct ili7807s *ctx)
>> +{
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>> +
>> +	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> Drop
>
>> +
>> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>> +	mipi_dsi_msleep(&dsi_ctx, 20);
>> +
>> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>> +	mipi_dsi_msleep(&dsi_ctx, 120);
>> +
>> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> Drop
>
>> +
>> +	return dsi_ctx.accum_err;
>> +}
>> +
>> +static int ili7807s_prepare(struct drm_panel *panel)
>> +{
>> +	struct ili7807s *ctx = to_ili7807s(panel);
>> +	int ret;
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
>> +	if (ret < 0) {
>> +		dev_err(ctx->panel.dev, "failed to enable regulators: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	msleep(20);
>> +
>> +	ili7807s_reset(ctx);
>> +
>> +	ret = ili7807s_on(ctx);
>> +	if (ret < 0) {
>> +		dev_err(ctx->panel.dev, "failed to initialise panel: %d\n", ret);
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +
>> +	regulator_bulk_disable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
>> +	return ret;
>> +}
>> +
>> +static int ili7807s_unprepare(struct drm_panel *panel)
>> +{
>> +	struct ili7807s *ctx = to_ili7807s(panel);
>> +	int ret;
>> +
>> +	ret = ili7807s_off(ctx);
>> +	if (ret < 0)
>> +		dev_err(ctx->panel.dev, "failed to disable panel: %d\n", ret);
>> +
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +
>> +	regulator_bulk_disable(ARRAY_SIZE(ili7807s_supplies), ctx->supplies);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ili7807s_get_modes(struct drm_panel *panel,
>> +			      struct drm_connector *connector)
>> +{
>> +	struct ili7807s *ctx = to_ili7807s(panel);
>> +
>> +	return drm_connector_helper_get_modes_fixed(connector, ctx->desc->mode);
>> +}
>> +
>> +static const struct drm_panel_funcs ili7807s_panel_funcs = {
>> +	.prepare = ili7807s_prepare,
>> +	.unprepare = ili7807s_unprepare,
>> +	.get_modes = ili7807s_get_modes,
>> +};
>> +
>> +static int ili7807s_bl_update_status(struct backlight_device *bl)
>> +{
>> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
>> +	u16 brightness = backlight_get_brightness(bl);
>> +	int ret;
>> +
>> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> +
>> +	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>> +
>> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct backlight_ops ili7807s_bl_ops = {
>> +	.update_status = ili7807s_bl_update_status,
>> +};
>> +
>> +static struct backlight_device *ili7807s_create_backlight(struct mipi_dsi_device *dsi)
>> +{
>> +	struct device *dev = &dsi->dev;
>> +	const struct backlight_properties props = {
>> +		.type           = BACKLIGHT_RAW,
>> +		.brightness     = 0x3fff,
>> +		.max_brightness = 0x3fff,
>> +	};
>> +
>> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
>> +					      &ili7807s_bl_ops, &props);
>> +}
>> +
>> +static const struct drm_display_mode dlc0697_mode = {
>> +	.clock = 131911,
> = (1080 + 18 + 2 + 16) * (1920 + 26 + 4 + 20) * 60 / 1000
Ack.
>> +
>> +	.hdisplay    = 1080,
>> +	.hsync_start = 1080 + 18,
>> +	.hsync_end   = 1080 + 18 + 2,
>> +	.htotal      = 1080 + 18 + 2 + 16,
>> +
>> +	.vdisplay    = 1920,
>> +	.vsync_start = 1920 + 26,
>> +	.vsync_end   = 1920 + 26 + 4,
>> +	.vtotal      = 1920 + 26 + 4 + 20,
>> +
>> +	.width_mm  = 0,
>> +	.height_mm = 0,
> Do you really don't know the dimensions of the panel you are
> contributing?

Ack, will update in v4.

Thanks

Arpit

>> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
>> +};
>> +
