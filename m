Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0507CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 20:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E921710EE9A;
	Wed,  6 May 2026 20:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CYv/QorB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ANlhI+si";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0276010E56D
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 20:06:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646DCKeV1527743
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 20:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qO4ADo7z/ejk030p69Qyox+9
 T6YbJpVgw4i/wWrNUSU=; b=CYv/QorBGK4AFE3PHI+dT2g6cWJ/C/nZQ7cmF1gL
 s9mW2F9Ha8lm/obT75sxr96YipPIkGZ+VqrIlzA6wy5MnI9dlp2qaN/Pbkfyyj9S
 PdsGcCySK70KbPxRJxUNqW9p6gulquhOuAM2dfK3/j44ggnETGU6A6fn+rrZ/UOy
 P8N6iS6IL+KemtftBRWmlsOowh03W96oZTPHtyNd9WevHe1ojf2DReYlw6lwihDu
 R5UTz04qqytLDZYmMk1M6lVWHmUL9c3PTQMIXfeaJozVINqeuZIfa4BLnStIrkCM
 lPNy+wXbHEY857nxu8AlLgZI3cIOKBxTO/UfZEjNTXz5qQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128awft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 20:06:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6101726c594so225960137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778097995; x=1778702795;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qO4ADo7z/ejk030p69Qyox+9T6YbJpVgw4i/wWrNUSU=;
 b=ANlhI+si+kLdLAGpf85VskQW3RncP7PGkdlV+BEXP0qwgQg5ZZ9oIh+MVUV4Um/fAL
 n6n78ZtyVHl/EhIuzBF+wKzvYnB7TwMNJQDngY/FeuNGZQ50ZBoajOPvJO4fWWCtk5gE
 H0pIOLqHoTbOY+/9pdRjOHTYK6cSplaG9Galg+X4/dF66KzZ6xfn4jIzzPLFy0Vu0RgS
 +99Qt0xKbHJm5InVNpCo3X68gflA3MO9HqKkxJ+EUTuWMdLpjXax63W16wpsOTLoPfiw
 gEYXgYy/Ss5Y3lyv9tQhPTemVycL/LnZjMLZr1ui+Q9BDcsv4Mk0HXw927p3ULQaFY18
 mzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778097995; x=1778702795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO4ADo7z/ejk030p69Qyox+9T6YbJpVgw4i/wWrNUSU=;
 b=B1giTsscTbnVXoAvczk/y13PD36x+v/9ILEAa7KxreaU2u+ZFp2mFU1Trw528Mh/k1
 Iv+gfW4+cY+s4N/pNLEH25pwH1bjISx7HrNOC1R3myuiFvnyzU52HmAxy5Fbw0+LP+fs
 6PgE4NvhcRk4Hulqlxhe6to2t/B+/PeH9L2tnFVkN8Chz2qzRlFjx2adt/KUqtuKmqQH
 S9kg5+Fz2MEBmpaacLoMOPJrr5KkhwId86oJm9um2w9yWZzs2RYEh0+Wpe8HPBAKL4ji
 t7YWqxfMb87OBkSX8tlffzMGouJDjb9jFL0V2KAJv/G/CLVvNULDyvnUtR5VoNN177O5
 Jang==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NPRCIYbx7iRiR7c9LhGak4FZO8vkUEVvAaOukkCaoTBmIUhHeVrlQq8GoBLNP4KnLfi66Jh4cXGA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0f7dAkJk7QtFv4JkWNyGZojnpW7gQ+FP0Zph8pt72zCKukbpR
 GpYEhamgryBKsXDkaLfw2/Lhm9/h/CZUsMoDi0dN2ljHVV56mkbyrcfmbHEzbZIoeGdMnMiK5nR
 r8jh2rhAPMp2TerV0VoHktsy29ZzZm6UQVh2GiemIDBEJYsQCLMxDb62vSrzzExkMCPAxaPY=
X-Gm-Gg: AeBDiesMpIPx8ZohSKTsr2DkXCvcpDBXJYimwrrBN3ZUMwlHLMbqaY9vw/9gEiaoNNu
 XLq4NJ3Bzh4CHP0C8MyrT+DwsSFV7YZLGGBq408qNCQBKNs+pCWtBSn/gVAtEy9aOJnXzlx+u9Z
 RM7U9gnvzhMgRDeyARcZw+hyMgEvydDfJG39VBXCABNctitcrBdRFDyShOtmyAv+lrLMo5uUDTr
 kxcLTG9Q5wnKdybyMYxfFIQo5OoMybBblRAcQEA5zv5jbeJnkp4xWQqWYvn5MlGzTqHmbLN5P5S
 5LnhydZHRpqFxRa7W0+diAPVRdkgantJAFZjg0sbKVM8W3RfGNPWEOOFCC79vFI0Gi2cqrk8dci
 yBuaCC/bWabwgAEIE4e0uk+B1vx/UBLPFu+hZEHPLH8cfYpqf6V2BKvOYyP3BD2jDeQivvtkzj7
 OMk87fH/GziqB1FjuKDBpmrGTxgUHbxhkm3BaIK9ZSYbfGw9hNfhZnIMoP
X-Received: by 2002:a05:6102:84d2:b0:605:38d2:26cc with SMTP id
 ada2fe7eead31-630f9036c70mr1761176137.26.1778097995225; 
 Wed, 06 May 2026 13:06:35 -0700 (PDT)
X-Received: by 2002:a05:6102:84d2:b0:605:38d2:26cc with SMTP id
 ada2fe7eead31-630f9036c70mr1761167137.26.1778097994655; 
 Wed, 06 May 2026 13:06:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a881dcc668sm1634919e87.53.2026.05.06.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 13:06:33 -0700 (PDT)
Date: Wed, 6 May 2026 23:06:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yangsunyun1993@gmail.com,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v4 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <zcteqdnovguyiae22jnittje4au5pcohdcyga5l5wk42v5rczk@5x2qs7x5tfq7>
References: <20260506095100.78998-1-syyang@lontium.com>
 <20260506095100.78998-3-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506095100.78998-3-syyang@lontium.com>
X-Proofpoint-GUID: 5qtcQD-af9-EKaGd0uQYNBxibzL5lU4T
X-Proofpoint-ORIG-GUID: 5qtcQD-af9-EKaGd0uQYNBxibzL5lU4T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE5NyBTYWx0ZWRfX3MRKoKyu19Gj
 j/E2JQ7Qlz8k9Z+i8gklZk7lyMh9fzHE+dxt7jEtu+V/eoVDJlKKhJn4m5efss3tbSoWioumpK1
 2FudLO2+Di5eKI3GuUEeoP/1t1tj6Bl9l87PXO/epZq0cruir8YQdV2MZ5w1Qdr+vFjH0jY8qzZ
 2jmH7OxL64rAYnUNglfloMnV4wii4m4aTlzfcXJMBSnCtKF5WBc5OCthXroJTXzHXaNAzqYOouw
 Hf0EtlF9OBv+lKOpP5Cx1T34aj1mzfAdqGxqjYv2KevKJSdABhoQVL2OZDABQKYvoO+NLdvYrCo
 G52WaD0OailpO3aR6bGQUWLQm/APj0v4pVzmXRqAv8ur1hc8eN5n10UMdshu8XxIqIIIVnFO5QX
 uQDWYVpZU7AJ9H++Y0xozXNiyzWC8TKWHd/yoIRUMN4TN8lWjiQcQjmlWPGxl3rogdS5aVDyWrX
 VH05XJwFnOBusJIWq4g==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69fb9f4b cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=Kz8-B0t5AAAA:8
 a=FAN-CsSX0s4W6alzs7AA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060197
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

On Wed, May 06, 2026 at 05:51:00PM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig           |   18 +
>  drivers/gpu/drm/bridge/Makefile          |    1 +
>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 1211 ++++++++++++++++++++++
>  3 files changed, 1230 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/lontium-lt9611c.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index c3209b0f4678..32b85a2a65d9 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
>  	  HDMI signals
>  	  Please say Y if you have such hardware.
>  
> +config DRM_LONTIUM_LT9611C
> +	tristate "Lontium LT9611C DSI/HDMI bridge"
> +	select SND_SOC_HDMI_CODEC if SND_SOC
> +	depends on OF
> +	select CRC8
> +	select FW_LOADER
> +	select DRM_PANEL_BRIDGE
> +	select DRM_KMS_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_DISPLAY_HELPER
> +	select DRM_DISPLAY_HDMI_STATE_HELPER
> +	select REGMAP_I2C
> +	help
> +	  Driver for Lontium DSI to HDMI bridge
> +	  chip driver that converts dual DSI and I2S to
> +	  HDMI signals
> +	  Please say Y if you have such hardware.
> +
>  config DRM_LONTIUM_LT9611UXC
>  	tristate "Lontium LT9611UXC DSI/HDMI bridge"
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index beab5b695a6e..92688be9692f 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
>  obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> +obj-$(CONFIG_DRM_LONTIUM_LT9611C) += lontium-lt9611c.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
>  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
>  obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> new file mode 100644
> index 000000000000..3131f4a32dfd
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -0,0 +1,1211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/display/drm_hdmi_audio_helper.h>
> +#include <drm/display/drm_hdmi_state_helper.h>
> +#include <sound/hdmi-codec.h>
> +
> +#define FW_SIZE (64 * 1024)
> +#define LT_PAGE_SIZE 256
> +#define FW_FILE  "lt9611c_fw.bin"

So, this file doesn't have any subdir (like all other Lontium firmware
files), but then you submit a file to linux-firmware with the Lontium/
subdir. Could you please settle on one location?

> +#define LT9611C_CRC_POLYNOMIAL 0x31
> +#define LT9611C_PAGE_CONTROL 0xff
> +

[...]

> +
> +static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
> +	.attach = lt9611c_bridge_attach,
> +	.detect = lt9611c_bridge_detect,
> +	.edid_read = lt9611c_bridge_edid_read,
> +	.atomic_enable = lt9611c_bridge_atomic_enable,

There is .atomic_enable, but no atomic state management here. Was it
actually tested?

> +

-- 
With best wishes
Dmitry
