Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2191E937E0
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 01:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A94010E2ED;
	Mon, 13 Apr 2026 01:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJdbgUu8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqGvyvwR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2887110E2EC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:30:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CNoVWb1616973
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4xPVpsoMJBufQ32OcfsUYWbg
 00L8GVQNJvCwUVmXS+E=; b=aJdbgUu8P2Ed+ONcwpxyZspYWFV0T1V1yTUluTUA
 SGFGGWD1KRXeenfkxgFK5xtI8ru2B/i/ybI4ZfL02jqoT4qtY4Ip9M8H08B1syfB
 Y6zcrsD+W8Q6nl0cPIrivUjDZLeVzCce2e9luw6iYCxeadDrLk6384WEAjXHtcRi
 8c/gGeolsAWpo7zTT5FOoNGffgtFDiLeJ7HI6EWSLKF2ssisnhFNQUK8zvnMqM4B
 sdcyo6dymBDQj5aKGV6juVQQ1k0/ZAwLWz3I5/gp9hk4STKu7sUlObmiJhRzwVAU
 THx+lsBIJUyIH4+Le4A0BJVS+bu16qvD1nMvfIpXGUsPuQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtk9u0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:29:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so75973951cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776043798; x=1776648598;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4xPVpsoMJBufQ32OcfsUYWbg00L8GVQNJvCwUVmXS+E=;
 b=GqGvyvwRK4zXdziMxn5PdPS9wyzwkc+dqKuAyK0j0EugcKpRUKlxmLhtKfrE1s/T+A
 031psddr3CrmF6kD0TvUFS3wSahFD0uEqkxYu8cZ+ZRWiJPSmSOfTxMF/CguepSYcxH9
 WtpNzQBqgkPudDI2XQj1Y0G8F+aveUiprRpcHTbXwLB/YThQvl+IZhTNXqjlBGmcNAb3
 6V0dzsKAZVxLI6Uhlt5ygBwQSUj8qAVGYIhz1KEHs3dM0fajGPRqRkevk4fgJRN2a7Ln
 rcd2v7IKWWh9pESvSJHF1kY4K4o3/mBqG5cttu4drXTZ/tUGzuRY8pSz57fUtcv0deIk
 PQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776043798; x=1776648598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xPVpsoMJBufQ32OcfsUYWbg00L8GVQNJvCwUVmXS+E=;
 b=dr4fqQCuLo84YvnTbq3ohMEN5Iq8YLCi5sOIBQ7ku/iA3x1BB7MmFhbU7go4+QwzAu
 bnYv2QmNwcUaa6odBaX/pbX+OZgdpOSH5L23TrzqsRa+gidb1VMIx9lg2q3NuEqexR0w
 Y86xrJ1fkTSYh+D/iQhAsLXiksXQJqeBAumdkGTjjy11qc8WMXOrtaqqKVu8o1EVALgP
 poSaywVe7gsYnsUjg3nVM0veK9VDWd2t9bIKvvBZOVL/zDURuGwzq/NnSxjpPVXS6f8S
 KMfpU8AHnjlFwEM0K4l9lrEFAzm+LDpKn9NOO73pCsHCxUuzxsyovffHcwznHk1PI0oY
 wFQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx2ehsbywnY9/xFhfdIW6xCIcYMIPToHPctARixLC13F5rXbqzk4yK23LnBtp93uTGk1PktQO4AKU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBhRoex9c4kgkQi+KiXMbO0jSe+wZEpd/creVBTnfJ0qUBFO4S
 wc3isa9pm37l3PfDQEE5snPeA0rp+hVAPnUQ9X3ye3BoynnloppTsX/o83jFU4I7f0B9uFMkDOy
 VSPCF57ScwDsBt1uusw92GEd/8svmV8ryeSAD8wTq6y7ZZscCLnvJBIYYNS88w9QXYtNQJA4=
X-Gm-Gg: AeBDiespy+zdfcrffl7mOFQS4QKn+bDMscQbkFuQF1MuKY4iX6ogIfGUjYSifkhVGlZ
 NO/tFiU+A/B+BiVwhkONT6SAT1O6ZR+ihhr5kmOyWodwhYTo6DkoxS8zXTsqNIj0ZRXa79pRLUG
 H4n5T1oe3w+PcFvAxq90OpZUZYc6imI/5012g/EG2JtiubYOs5EEG8QtDZKRSD5vIDsnJIxTbEI
 EE02BlUiwh5zrluS0GJ58SqtusrfqQCn+V/vmrFEeOlYDNE1stgM7WzlLuMBw7hCvAz9xVX2xrA
 zVa17Me3CazpfwcNTJ/yJR8D3O7JFl/bnUqpJd7M0b02hpY3VmlR/1nvlf3bbvFKqaYxzMwUefw
 i8Iv+L5VAUxnNGHDHnpIiJuPzlOdeQ5b3nq+730CKAsqij3FUxt0pwJccoP2GobanJ7Gh7QJCSZ
 2P5JvQQfZONfikrIF5aFGcqLYbZO+1emaqzbg=
X-Received: by 2002:a05:622a:13cd:b0:50d:97c1:6626 with SMTP id
 d75a77b69052e-50dd5b30de4mr175660661cf.7.1776043798401; 
 Sun, 12 Apr 2026 18:29:58 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:50d:97c1:6626 with SMTP id
 d75a77b69052e-50dd5b30de4mr175660371cf.7.1776043797933; 
 Sun, 12 Apr 2026 18:29:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e4927037fsm21064871fa.3.2026.04.12.18.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 18:29:55 -0700 (PDT)
Date: Mon, 13 Apr 2026 04:29:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alicja Michalska <alicja.michalska@9elements.com>,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] drm/panel: Add driver for Novatek NT37701 based
 OLED panels
Message-ID: <7iwz3mveqwp5cmxajgsnfnzyffewxkweesvywsyacxsdfmdqi3@qlwgqzw2upee>
References: <20260412113851.355944-1-val@packett.cool>
 <20260412113851.355944-3-val@packett.cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412113851.355944-3-val@packett.cool>
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dc4717 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=Jt1seR1F_FQkLTMJGlMA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Iw-aR375QkViW4rBZjxEX9XMVOD8k1XN
X-Proofpoint-ORIG-GUID: Iw-aR375QkViW4rBZjxEX9XMVOD8k1XN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDAxMSBTYWx0ZWRfXx9kffxMW6Rc6
 DptaH3XJx2Kcu2klyrBG9LvaeR1RMM2+gy31DHl3JM6wgT1BRU59L/n8YqXIGcisck6H7/I/qWQ
 huulA8jQPYfsc2qb3qmgCg2YPPLgvbm/p0ifx4WjS2qxXcmeYuxUsWvjnJS1c8KPgIeP3IhX7cR
 XtIKZ+2t6KhTbbaYXeOlKB+5iPODZem92E5WABiclM64G+an7WbIEJkcGjstDPEnciDhCg7byqa
 LJ3co10HQC9FwRsT8Hqus9fDeQhNC8LY5hiVSsbSIL2GqJ7Drq1hS1KNZ0Jr/35oP6MLTAyj9kZ
 FKPGnV11SaGKkJc9wLTCbqfdBTOxEi0SqCo+iEgw9bQAXE/Wq+hO3dSc3SPfNJCJXqbasxtAvgG
 vr8d2/ZA6Zg8olQnwqLJX1Asb7hK7lTOmIa0YREA8E5U1xwTKiKoNNy6a69E7lOWvsd7mm7r+EN
 yaVYPFLtgqCzGiSkmjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130011
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

On Sun, Apr 12, 2026 at 08:00:45AM -0300, Val Packett wrote:
> Add a driver for panels with the NT37701 DDIC, starting with the Tianma
> panel (unknown model) used in the Motorola Edge 30 (dubai) smartphone.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-novatek-nt37701.c | 532 ++++++++++++++++++
>  2 files changed, 533 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt37701.c
> 
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index a4291dc3905b..183f968a5333 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36523) += panel-novatek-nt36523.o
>  obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672A) += panel-novatek-nt36672a.o
>  obj-$(CONFIG_DRM_PANEL_NOVATEK_NT36672E) += panel-novatek-nt36672e.o
>  obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37700F) += panel-novatek-nt37700f.o
> +obj-m += panel-novatek-nt37701.o
>  obj-$(CONFIG_DRM_PANEL_NOVATEK_NT37801) += panel-novatek-nt37801.o
>  obj-$(CONFIG_DRM_PANEL_NOVATEK_NT39016) += panel-novatek-nt39016.o
>  obj-$(CONFIG_DRM_PANEL_MANTIX_MLAF057WE51) += panel-mantix-mlaf057we51.o
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37701.c b/drivers/gpu/drm/panel/panel-novatek-nt37701.c
> new file mode 100644
> index 000000000000..ea8a208fecb2
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37701.c
> @@ -0,0 +1,532 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, The Linux Foundation. All rights reserved.
> + * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
> + *   Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/display/drm_dsc.h>
> +#include <drm/display/drm_dsc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +enum nt37701_mode_idx {
> +	MODE_144HZ,
> +	MODE_120HZ,
> +	MODE_90HZ,
> +	MODE_60HZ,
> +	MODE_48HZ,
> +};
> +
> +static const struct drm_display_mode nt37701_panel_modes[5];
> +
> +struct nt37701_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct drm_dsc_config dsc;
> +	struct regulator *supply;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +static inline
> +struct nt37701_panel *to_nt37701_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct nt37701_panel, panel);
> +}
> +
> +static void nt37701_panel_reset(struct nt37701_panel *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(10000, 11000);
> +}
> +
> +#define nt37701_panel_switch_page(ctx, page) \
> +	mipi_dsi_dcs_write_seq_multi((ctx), 0xf0, 0x55, 0xaa, 0x52, 0x08, (page))
> +
> +static int nt37701_panel_on(struct nt37701_panel *ctx,
> +                             struct drm_display_mode *mode)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	nt37701_panel_switch_page(&dsi_ctx, 0x00);
> +	/* Voltage */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb5, 0x00, 0x18, 0x4f);
> +
> +	nt37701_panel_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2,
> +				     0x60, 0x50, 0x66, 0x91, 0x86, 0x91);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3,
> +				     0x00, 0x08, 0x01, 0x5f, 0x01, 0x5f, 0x02,
> +				     0xa4, 0x02, 0xa4, 0x03, 0xbb);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3,
> +				     0x03, 0xbb, 0x05, 0x2f, 0x05, 0x2f, 0x06,
> +				     0x91, 0x06, 0x91, 0x06, 0x92);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x18);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3,
> +				     0x06, 0x92, 0x0a, 0x2f, 0x0a, 0x2f, 0x0d,
> +				     0xb9, 0x0d, 0xb9, 0x0f, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x00);
> +
> +	nt37701_panel_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x04);
> +
> +	nt37701_panel_switch_page(&dsi_ctx, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc, 0x11, 0x00, 0x09, 0x51);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc,
> +				     0x00, 0x09, 0x51, 0x00, 0x09, 0x51, 0x00,
> +				     0x0b, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xbc, 0x00, 0x11, 0x51);
> +
> +	nt37701_panel_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc6,
> +				     0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
> +				     0x66, 0x66, 0x66, 0x66, 0x66);
> +
> +	nt37701_panel_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x1c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0,
> +				     0x15, 0x0a, 0x38, 0x27, 0x49);
> +	/* DSC */
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x90, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x91,
> +				     0xab, 0x28, 0x00, 0x0c, 0xc2, 0x00, 0x03,
> +				     0x1c, 0x01, 0x7e, 0x00, 0x0f, 0x08, 0xbb,
> +				     0x04, 0x3d, 0x10, 0xf0);
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_MEMORY_START,
> +				     0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x88, 0x02, 0x1c, 0x08, 0x73);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x00);
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x0000);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
> +				     0x20);
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x0437);
> +	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x095f);
> +	if (mode->clock == nt37701_panel_modes[MODE_144HZ].clock)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x04);
> +	else if (mode->clock == nt37701_panel_modes[MODE_120HZ].clock)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x02);
> +	else if (mode->clock == nt37701_panel_modes[MODE_90HZ].clock)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x07);
> +	else if (mode->clock == nt37701_panel_modes[MODE_60HZ].clock)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x03);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x08);

This should be coming through the drm_atomic_state for the CRTC used by
this panel. Most of the plumbing is already there, panel bridge needs to
pass atomic state to the drm_panel functions. Note, the bridge has a
reference to the encoder, so it can retrieve CRTC state. Panel functions
would need to get drm_connector so that they can perform the same
lookup. Once you get drm_crtc_state::mode, you can perform lookups here.

It's a longer path than the one you have RFC'd here, but I think, it is
a proper way to go.

> +	nt37701_panel_switch_page(&dsi_ctx, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1,
> +				     0x00, 0x03, 0x03, 0x03, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2,
> +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +				     0x00, 0x00, 0x00, 0x00, 0x00);

-- 
With best wishes
Dmitry
