Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFA9EA71A2
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 15:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241D110E076;
	Sun, 19 Apr 2026 15:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l5AGKxvY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hBQTEiqp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A85610E076
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 15:58:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63J2bDA34072489
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 15:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pVVzUjtYcVo9D1/wybwB7s5q
 oA7TWDEHP34W7TdGa/w=; b=l5AGKxvYZq2DqP/YuqpOwKC9QnzRafnVw6qV1EDN
 30FxoSFbOI7D5hnY/U+APqwxQWetvVK3dpMErN1fzo4PzK76qURiAAIRzhKJB3JE
 F9PedlL7qSnRgfEBeGm3cKod/sZ180nfLNhkdp5UWXXebkjkY/k4Cjsbj09i1QXV
 1hYpRPikA2/lmIJeO2RJqIjjCIGWGXF+nVcfoGpH5MVBk+N/ZTALLS/AjhUPUKhB
 V+6w+1j14fYdj1JNpqrPYC5xK/tyD+JJBrd7ezIfOjNNGUStFU1usWG5pwG74xpT
 XPSRD1n0CR1HkYgaU2xvwnJBaOUYLC9QnoQUcWdvcsiKWw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2qajsgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 15:58:36 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-612d26038fbso3142549137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776614315; x=1777219115;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pVVzUjtYcVo9D1/wybwB7s5qoA7TWDEHP34W7TdGa/w=;
 b=hBQTEiqpYnbh3/eD0cLcpfJHauMV9dwjbOLQfTmkil/mhBq8MhiUdJifH1GTXngOVl
 Ye5b8xPQxNtdwnXURW7iUQDGS9SfzK+G/CyaQEdyJ0mFnPw7fKifTN5GGuIBCVeikHXy
 JMbRj8pWFnkP1wjQpGXs2jnLI+uZBOtIfi+SXzbjpXV2g8ERv5viHZZydjjMwpW9GpZh
 q9KJ9IA9DIc+K8Z5PjLoiP0uW+dpvPd8tAuuCXz/8yzujwbkFSw/ceLnEE3tNj4B+Bsh
 ers5eCoGX5Y0TVnHu3Q3JzTpzcxxB6tmZp75QNB1T/gXOK09CydFjsDUsOlhgNoD9DBv
 EvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776614315; x=1777219115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVVzUjtYcVo9D1/wybwB7s5qoA7TWDEHP34W7TdGa/w=;
 b=rTb5f3g9DeGpmxa+jcNLR5VnLe/QlOyegls/65lu8rvJ6mlIFE1z4jm512McmZLhGl
 Pj+rVtRtVbuNEoe/4FaGEA/YAmhNMaUqNuluclNymgaYUpNx8TVU2lF12utzRqDjkPzW
 Wps2hRkanUiFF31xdz0M7d9ie6l+Fx30c3sTPsXKGoecmXpy5xdNAJWSiJE5PJ+rOZLm
 zn1telxse9TFc2sexwRAvoM/pfZx7XQMlidF6DW1VzA6wjoZpCh5AnOxEG8kAoPLnIxU
 O50dBARXAx30TWSkKENojko/lxuryxYTK7u0MBIsnV0mBJYbLViMM7JYtI5JZbCk83jg
 poBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aTXiDW4+spstlxxJdQB8FV0FYeSNVxmjJY0SB6VTULD1oEFECJiKRqvQ//U3uXknMYPNXjj37qa4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4sjGnrvyxhhKI+AMfR5KRVp+uHEAdkJR/vEtH+AMFHKpDzBWm
 KjkPKB1rmIkk5uO7eBjsYp6BhbiX/QOlUeJGdfK/0M+ptea6evkWnbmm3QQwqADN3GLyM/uwRw6
 kyrDslxrDXXsbrGv+PFCFZezUgVoKZBbjMNxi3OklgtAlJoFFFcLrZWlBRDdkw5+iQFXUl9U=
X-Gm-Gg: AeBDiesPPOLCT97iybWhwGJBH2wNgH9PbXHGwJ9HBO1mfw6iT0eu7ZidoibbFy1qtnl
 CWwoGg8Tqq75ntvv/+EdCD+MPI71ehMjMy9bb5jIcwFaCofBAC/5WLsgqKQR+hsBUaR3H1F4sEy
 LGtKKbDtLI6378PGLDAWrWmQu7lDXUTjESNYiCtUGrIPZbUdQ80fhifzqqN/HN3+acCgoqQUn6p
 MRZ8QmoS/BmPDrCxY5P99GYu7ZO5+HZPC3gsN4IpV6bfC7ni/fCn5gnE569dPtUetsYzn4QUhdF
 yD2zJU80pO5/uAO8o8XtvxE3L8vSF4i4u9u5HMJf97hN5ji8Bquc9iJhsVAgYqyBmjvCV3Cj14v
 Fqc7gRVTtMbf5BJBwPi0uX3c8A1C6zmz4sIjFhcNSOA1GTitccm2x5GeN8cO5874v/ZsKzy29he
 zckN7c8JO5knBDf/Ynsdj+Te+NDCEHugw/yBhu6tKwrSimLQ==
X-Received: by 2002:a05:6102:419f:b0:604:f029:224c with SMTP id
 ada2fe7eead31-616f4d6abf2mr4579235137.8.1776614315116; 
 Sun, 19 Apr 2026 08:58:35 -0700 (PDT)
X-Received: by 2002:a05:6102:419f:b0:604:f029:224c with SMTP id
 ada2fe7eead31-616f4d6abf2mr4579226137.8.1776614314564; 
 Sun, 19 Apr 2026 08:58:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb4f54ffsm19642361fa.1.2026.04.19.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 08:58:33 -0700 (PDT)
Date: Sun, 19 Apr 2026 18:58:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS
 encoder
Message-ID: <td55nrjrchomtatyx5phbojvjipwh64gnlnydqame5xakviafp@ixzaju2lnkpm>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
 <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
X-Proofpoint-GUID: iDvBLbmzo44-UQKx4Ej9Sxi7c3C83TD8
X-Authority-Analysis: v=2.4 cv=KdDidwYD c=1 sm=1 tr=0 ts=69e4fbac cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=yC-0_ovQAAAA:8
 a=6jxhfPqqJYEutQ7Ysb8A:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: iDvBLbmzo44-UQKx4Ej9Sxi7c3C83TD8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE3MSBTYWx0ZWRfX6FtU1uGD5mmm
 mWrvN6CiBOI5L4vXbvHGxbYN+BRnwU95EqgKENJwX7BY/wn+quQmZmQbitwh8DTE299cXvMiVnP
 oeReWNy5zqGuKoYZz3G+wFLt2fuMhdygX7+RERaDCK9eXRpIKHE8m37rTrSTtQ8C3KMBOHzT8+z
 lcdn8NclwlQJnzupwDTyzUsE+nfU7GPyLJrqwuChzmeRg3RwjrmFx4d/3arfFc3FPLKoLPfULQG
 3DWNuv3Zc/vUONdSTB6t34uta3nA3M4G56pn5Bjde0R47+jIdctXZVjomXPmM1wEKbLh47goUwW
 cbxVBkigoqJI/vxZ/TvqpslyU0W32cqtvkDwthdVPdj8Q+mCgIvths1yC2vrWchuDop592uZFo1
 egro9wzWTbLztXZC82JoBDCs3yqLVGczrWJuojymn4u1WaIyiE168UZF21SsbSWwJyFvrwTaqWH
 eZkXCbE12yLXv6sW+EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_04,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190171
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

On Fri, Apr 17, 2026 at 06:52:30PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
> mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
> from 25 to 87 MHz. The LVDS module cannot be used at the same time as
> MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
> the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
> MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
> module.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
>  drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
>  drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 333 ++++++++++++++++++
>  drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h    |  22 ++
>  .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  26 ++
>  5 files changed, 395 insertions(+)
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
>  create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
> index 7f2ef7137ae5..cbfc7b6bccb8 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
> @@ -26,3 +26,16 @@ config DRM_RZG2L_MIPI_DSI
>  	def_tristate DRM_RZG2L_DU
>  	depends on DRM_RZG2L_USE_MIPI_DSI
>  	select DRM_MIPI_DSI
> +
> +config DRM_RZG3L_USE_LVDS
> +	bool "RZ/G3L DU LVDS Encoder Support"
> +	depends on DRM_BRIDGE && OF
> +	default DRM_RZG2L_DU
> +	help
> +	  Enable support for the RZ/G3L Display Unit embedded LVDS encoders.
> +
> +config DRM_RZG3L_LVDS
> +	def_tristate DRM_RZG2L_DU
> +	depends on DRM_RZG3L_USE_LVDS
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL
> diff --git a/drivers/gpu/drm/renesas/rz-du/Makefile b/drivers/gpu/drm/renesas/rz-du/Makefile
> index 2987900ea6b6..46decb7ac4f1 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Makefile
> +++ b/drivers/gpu/drm/renesas/rz-du/Makefile
> @@ -8,3 +8,4 @@ rzg2l-du-drm-$(CONFIG_VIDEO_RENESAS_VSP1)	+= rzg2l_du_vsp.o
>  obj-$(CONFIG_DRM_RZG2L_DU)		+= rzg2l-du-drm.o
>  
>  obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+= rzg2l_mipi_dsi.o
> +obj-$(CONFIG_DRM_RZG3L_LVDS)		+= rzg3l_lvds.o
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
> new file mode 100644
> index 000000000000..bedeedbdfada
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RZ/G3L LVDS Encoder Driver
> + *
> + * Copyright (C) 2026 Renesas Electronics Corporation
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +#include "rzg3l_lvds.h"
> +#include "rzg3l_lvds_regs.h"
> +
> +enum rzg3l_lvds_mode {
> +	RZG3L_LVDS_MODE_JEIDA = 0,
> +	RZG3L_LVDS_MODE_JEIDA_MIRROR = 1,
> +	RZG3L_LVDS_MODE_MODE2 = 2,
> +	RZG3L_LVDS_MODE_MODE2_MIRROR = 3,
> +	RZG3L_LVDS_MODE_VESA = 4,
> +	RZG3L_LVDS_MODE_VESA_MIRROR = 5,
> +	RZG3L_LVDS_MODE_MODE6 = 6,
> +	RZG3L_LVDS_MODE_MODE6_MIRROR = 7,
> +};
> +
> +struct rzg3l_lvds {
> +	struct device *dev;
> +	struct reset_control *prstc;
> +	struct reset_control *lvd_rstc;
> +	struct regmap *regmap;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next_bridge;

Please use next_bridge from the drm_bridge struct.

> +};
> +
> +#define bridge_to_rzg3l_lvds(b) \
> +	container_of(b, struct rzg3l_lvds, bridge)
> +
> +/* -----------------------------------------------------------------------------
> + * Bridge
> + */
> +static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
> +				     struct drm_atomic_state *state)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +	const struct drm_bridge_state *bridge_state;
> +	int ret;
> +	u32 fmt;
> +
> +	/* Get the LVDS format from the bridge state. */
> +	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> +	if (!bridge_state) {
> +		dev_err(lvds->dev, "failed to get bridge state\n");
> +		return;
> +	}
> +
> +	switch (bridge_state->output_bus_cfg.format) {
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +		fmt = RZG3L_LVDS_MODE_JEIDA;
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +		fmt = RZG3L_LVDS_MODE_VESA;
> +		break;
> +	default:
> +		fmt = RZG3L_LVDS_MODE_VESA;
> +		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
> +			 bridge_state->output_bus_cfg.format);
> +		break;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(lvds->dev);

If this  fails for any reason, the atomic_disable() would still be
called and it will decrement the counter, potentially undeflowing it.
Consider switching to pm_runtime_get_sync(), which suits better here.


> +	if (ret < 0) {
> +		dev_err(lvds->dev, "pm_runtime_resume_and_get error\n");
> +		return;
> +	}
> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, LVDS_0_PHY_CH_EN_BGR);
> +	usleep_range(20, 25);
> +
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, LVDS_0_PHY_CH_EN_LDO);
> +	usleep_range(10, 15);
> +
> +	regmap_write(lvds->regmap, LVDS_CMN, LVDS_CMN_RST_PHY0_SEL);
> +	regmap_update_bits(lvds->regmap, LVDS_0_CTL_OFFSET,
> +			   LVDS_0_CTL_FMT_SEL_MSK,
> +			   FIELD_PREP(LVDS_0_CTL_FMT_SEL_MSK, fmt));
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN_MSK, LVDS_0_PHY_CH_IO_EN);
> +	regmap_write(lvds->regmap, LVDS_CMN,
> +		     LVDS_CMN_RST_PHY0_SEL | LVDS_CMN_PHY_RESET);
> +	usleep_range(100, 150);
> +}
> +
> +static void rzg3l_lvds_atomic_disable(struct drm_bridge *bridge,
> +				      struct drm_atomic_state *state)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +
> +	regmap_update_bits(lvds->regmap, LVDS_CMN, LVDS_CMN_PHY_RESET, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_IO_EN_MSK, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_LDO, 0);
> +	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
> +			   LVDS_0_PHY_CH_EN_BGR, 0);
> +
> +	pm_runtime_put(lvds->dev);
> +}
> +
> +static int rzg3l_lvds_attach(struct drm_bridge *bridge,
> +			     struct drm_encoder *encoder,
> +			     enum drm_bridge_attach_flags flags)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +
> +	if (!lvds->next_bridge)
> +		return 0;
> +
> +	return drm_bridge_attach(encoder, lvds->next_bridge, bridge, flags);
> +}
> +
> +static enum drm_mode_status
> +rzg3l_lvds_bridge_mode_valid(struct drm_bridge *bridge,
> +			     const struct drm_display_info *info,
> +			     const struct drm_display_mode *mode)
> +{
> +	if (mode->clock > 87000)
> +		return MODE_CLOCK_HIGH;
> +
> +	if (mode->clock < 25000)
> +		return MODE_CLOCK_LOW;
> +
> +	return MODE_OK;
> +}
> +
> +bool rzg3l_lvds_is_connected(struct drm_bridge *bridge)
> +{
> +	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
> +
> +	return !!lvds->next_bridge;
> +}
> +EXPORT_SYMBOL_GPL(rzg3l_lvds_is_connected);

How is this going to be used? I don't see the user in the patch. Please
drop the unused API.

> +
> +static const struct drm_bridge_funcs rzg3l_lvds_bridge_ops = {
> +	.attach = rzg3l_lvds_attach,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_enable = rzg3l_lvds_atomic_enable,
> +	.atomic_disable = rzg3l_lvds_atomic_disable,
> +	.mode_valid = rzg3l_lvds_bridge_mode_valid,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Power Management
> + */
> +
> +static int rzg3l_lvds_pm_runtime_suspend(struct device *dev)
> +{
> +	struct rzg3l_lvds *lvds = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = reset_control_assert(lvds->lvd_rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_assert(lvds->prstc);
> +	if (ret)
> +		goto err_deassert_lvd_rstc;
> +
> +	return 0;
> +
> +err_deassert_lvd_rstc:
> +	reset_control_deassert(lvds->lvd_rstc);
> +	return ret;
> +}
> +
> +static int rzg3l_lvds_pm_runtime_resume(struct device *dev)
> +{
> +	struct rzg3l_lvds *lvds = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = reset_control_deassert(lvds->prstc);
> +	if (ret)
> +		return ret;
> +
> +	return reset_control_deassert(lvds->lvd_rstc);
> +	if (ret)
> +		goto err_assert_prstc;
> +
> +	return 0;
> +
> +err_assert_prstc:
> +	reset_control_assert(lvds->prstc);
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops rzg3l_lvds_pm_ops = {
> +	RUNTIME_PM_OPS(rzg3l_lvds_pm_runtime_suspend,
> +		       rzg3l_lvds_pm_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +};

DEFINE_RUNTIME_DEV_PM_OPS()

> +
> +/* -----------------------------------------------------------------------------
> + * Probe & Remove
> + */
> +
> +static int rzg3l_lvds_parse_dt(struct rzg3l_lvds *lvds)
> +{
> +	struct device *dev = lvds->dev;
> +	struct drm_panel *panel;
> +	int ret;
> +
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
> +					  &panel, &lvds->next_bridge);
> +	if (ret)
> +		return ret;
> +
> +	if (panel) {
> +		lvds->next_bridge = devm_drm_panel_bridge_add(dev, panel);
> +		if (IS_ERR_OR_NULL(lvds->next_bridge))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg3l_lvds_probe(struct platform_device *pdev)
> +{
> +	struct reset_control *rstc, *arstc;
> +	struct device *dev = &pdev->dev;
> +	struct rzg3l_lvds *lvds;
> +	int ret;
> +
> +	lvds = devm_drm_bridge_alloc(dev, struct rzg3l_lvds, bridge,
> +				     &rzg3l_lvds_bridge_ops);
> +	if (IS_ERR(lvds))
> +		return PTR_ERR(lvds);
> +
> +	lvds->dev = dev;
> +	lvds->bridge.of_node = pdev->dev.of_node;
> +
> +	lvds->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(lvds->regmap))
> +		return PTR_ERR(lvds->regmap);
> +
> +	rstc = devm_reset_control_get_optional_exclusive(dev, "rst");
> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc), "failed to get rst\n");
> +
> +	arstc = devm_reset_control_get_optional_exclusive(dev, "arst");
> +	if (IS_ERR(arstc))
> +		return dev_err_probe(dev, PTR_ERR(arstc),
> +				     "failed to get arst\n");
> +
> +	lvds->prstc = devm_reset_control_get_shared(dev, "prst");
> +	if (IS_ERR(lvds->prstc))
> +		return dev_err_probe(dev, PTR_ERR(lvds->prstc),
> +				     "failed to get prst\n");
> +
> +	lvds->lvd_rstc = devm_reset_control_get_shared(dev, "lvdrst");
> +	if (IS_ERR(lvds->lvd_rstc))
> +		return dev_err_probe(dev, PTR_ERR(lvds->lvd_rstc),
> +				     "failed to get core reset\n");
> +
> +	platform_set_drvdata(pdev, lvds);
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable Runtime PM\n");
> +
> +	ret = rzg3l_lvds_parse_dt(lvds);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = reset_control_assert(rstc);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = reset_control_assert(arstc);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_drm_bridge_add(dev, &lvds->bridge);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register drm bridge\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id rzg3l_lvds_of_table[] = {
> +	{ .compatible = "renesas,r9a08g046-lvds" },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, rzg3l_lvds_of_table);
> +
> +static struct platform_driver rzg3l_lvds_platform_driver = {
> +	.probe		= rzg3l_lvds_probe,
> +	.driver		= {
> +		.name	= "rzg3l-lvds",
> +		.pm	= pm_ptr(&rzg3l_lvds_pm_ops),
> +		.of_match_table = rzg3l_lvds_of_table,
> +	},
> +};
> +
> +module_platform_driver(rzg3l_lvds_platform_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_AUTHOR("Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G3L LVDS Encoder Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
> new file mode 100644
> index 000000000000..2ea3cf4e1cae
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RZ/G3L LVDS Encoder
> + *
> + * Copyright (C) 2026 Renesas Electronics Corporation
> + *
> + */
> +
> +#ifndef __RZG3L_LVDS_H__
> +#define __RZG3L_LVDS_H__
> +
> +struct drm_bridge;
> +
> +#if IS_ENABLED(CONFIG_DRM_RZG3L_LVDS)
> +bool rzg3l_lvds_is_connected(struct drm_bridge *bridge);
> +#else
> +static inline bool rzg3l_lvds_is_connected(struct drm_bridge *bridge)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_DRM_RZG3L_LVDS */
> +#endif /* __RZG3L_LVDS_H__ */
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
> new file mode 100644
> index 000000000000..281b7648f168
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * RZ/G3L LVDS Interface Registers Definitions
> + *
> + * Copyright (C) 2026 Renesas Electronics Corporation
> + *
> + */
> +
> +#ifndef __RZG3L_LVDS_REGS_H__
> +#define __RZG3L_LVDS_REGS_H__
> +
> +#define LVDS_CMN			0x00
> +#define LVDS_CMN_RST_PHY0_SEL		(1 << 24)
> +#define LVDS_CMN_RST_PHY0_SEL_CH0	(1 << 24)
> +#define LVDS_CMN_PHY_RESET		(1 << 0)
> +
> +#define LVDS_0_PHY_OFFSET		0x10
> +#define LVDS_0_PHY_CH_IO_EN_MSK		(0x1f)
> +#define LVDS_0_PHY_CH_IO_EN		(LVDS_0_PHY_CH_IO_EN_MSK << 0)
> +#define LVDS_0_PHY_CH_EN_BGR		BIT(8)
> +#define LVDS_0_PHY_CH_EN_LDO		BIT(9)
> +
> +#define LVDS_0_CTL_OFFSET		0x14
> +#define LVDS_0_CTL_FMT_SEL_MSK		GENMASK(23, 20)
> +
> +#endif /* __RZG3L_LVDS_REGS_H__ */
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
