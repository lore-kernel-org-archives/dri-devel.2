Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB84F8925C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D687010EC27;
	Tue, 21 Apr 2026 11:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZYW25xK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FMikoCYX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9656610EC27
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:15:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L9PJqk046024
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 raxzNDTJkJQS4LmbFguntO7lYnDRtrcUSBIb/Cy85BI=; b=CZYW25xK1c2pWSK2
 SlGo8pEU+ZlJFwEvoH7Fy9ykEhbsXOAhAXZkKnWH7j+KWRH1sj1Ss6ZtrhDFEymJ
 RbFQ7Da/VVe7thBS/FNg+o+xwkQTKohGOYuVCkocPOpwIgzUOaOqpfx1/F0lqHeg
 Jm+cW+EXG6hXR1Jb+Eb5dpWFyGtxGf2V08c1kf7NMm+3OBwtB1ZfkMJcjbhihjP8
 goK1K9R+8vHgiFtB1TMNEAVcI6EkXMMDd2LkAcw8wFjhj+lk/xOZeEzwtXHDPn8M
 igbRWFQiitYNvstoSfxbLPzMhUfTgcK9zH9bvV0JmW688WI5HO+x+B732DsihlMf
 jvC7Cw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1spgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:15:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so548281cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776770141; x=1777374941;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=raxzNDTJkJQS4LmbFguntO7lYnDRtrcUSBIb/Cy85BI=;
 b=FMikoCYX6KtowFYyyhkklpQJpuZXS8jwE6Pg8rsOP/wQ4Bu7d2S6Gc1/5CmK8pf81H
 6dp7t/hg12VT2pjUxC2hccsGNo7GXK59oUWt7ugV0S1T94YQ06L2kiLyL6pEmRMVsJbI
 WPE83vfCSGe4I8fw5gML30wmV30u2T2XqO+2QJmvNYIOolwAZrNfbQs1OVG6i9q3kUYO
 4VcRQzn049AN8Ol0OVDEfQj59/lyslStuR7et+eCGrUJAl7ewvCyzsD1Y+jjJ0yWuZaQ
 G0KvO3NAFs4yGcAFNrP2+P9d+b14injUCXpoimfGkGCqPIqNzlwqiOhivA1vu4MPfEaZ
 EDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776770141; x=1777374941;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=raxzNDTJkJQS4LmbFguntO7lYnDRtrcUSBIb/Cy85BI=;
 b=O8gZx6fCkaFsGCszsEde+J7XwfCNaCicfVolYHZo7hufWBw4c0UDARlkD/ZG6FszeY
 t9NcyHf7EWbaIy3SHg5ar7girrkranKSD6lwsK8KT5cMrSW+EZbHyRn0XX3YFTFylA6E
 9z/FOs5+fYSdCWIhMqRsbpnXwl9D/dvNByIWLYFgpkFzNdb5YpIa1YKQQkG9qBFxYhNs
 m5jFOtOLaA1NSvANfKh6OLJLR1/f79xdWtcuETIagAAPA1GMNClVSU8TY0A0o1PPQVJl
 eSfk1zYbSDAl2WQWX6+2mlqrJM7fNkvCPT+EobAmWfh+gWWNz2WuW7Gj/Rhj/c05t4Dv
 5gWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bSCDFclXDtf5xPNk9LvNQ6ElgSd91EEXbWY1a3Kz6lYfBqM94CqFnNeTq8Qj7buhwgfMgUGVtOIw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfrIWbp6Gfwp/2TN6VHo+N7b0hC5hbXAzc6pOr8zfOA40Npjw1
 +Ul9fm97S8nhpyztpBxcZEYqZHdszP3LLwk8T4HsXNy1DT4xhoPSc9q5cTWQMNeXPowOvtQnw5Y
 SGujeEZOT7Kt/aaLH27AJXlPw+LPDHM7wEtDKIHYHAGkvQbvoi5upYl9y90GqvKYHWry/wNI=
X-Gm-Gg: AeBDietvYChr8nMJ1USMa/8v87MGFqXTJiOHSZocYO+eRr8TaShlTac+WqJ/frh57QB
 A099OITPscA/O23Ns9DNUv36LAaO9JgKzrWB6lDxHmLwfhT2mTMpqYWwkCFGb8g9lGPTWlWgh2j
 tX8pzjUEJU6LD6NBzPFTg0KRDnIHi36Wd8Gyzox8LTHeGjQ+KKNoBmAhLjL0snyFOa+QBDCSTTH
 nM7lH7SOcrNCNKRs9sGoT4aN3bHp8SGF3NZIvjuaK7UW7RPx1oHXIGeCePbXL4LefxuHV9JI77p
 9DgQYwMcoVISbqRef3Ygr1dr3zDb19lHkjxfqjZsvHd3/hSm+LicCtndjOGWX02LGZgmyCDRGcX
 RZGl2zx2tilH7YQAIgD09qxoFgvwpge+t9XWv3ZmHD+a1zhC43KrjQwffm7gmcViiQZcQSFRgJP
 fXBuEtZIxV8qgimRtxYFCGqkHTPOi4Ta6HCEkMc6+Zc8e6qQ==
X-Received: by 2002:a05:622a:11ca:b0:50d:9192:b9b5 with SMTP id
 d75a77b69052e-50e36e9b9b4mr263017871cf.32.1776770140730; 
 Tue, 21 Apr 2026 04:15:40 -0700 (PDT)
X-Received: by 2002:a05:622a:11ca:b0:50d:9192:b9b5 with SMTP id
 d75a77b69052e-50e36e9b9b4mr263016981cf.32.1776770140132; 
 Tue, 21 Apr 2026 04:15:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41abceab0sm3297476e87.61.2026.04.21.04.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 04:15:39 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:15:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?5p2o5a2Z6L+Q?= <yangsunyun1993@gmail.com>
Cc: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, tzimmermann@suse.de,
 xbpeng@lontium.com, rlyu@lontium.com, xmzhu@lontium.com
Subject: Re: [PATCH 2/2] drm/bridge: Add LT7911EXC edp to mipi bridge driver
Message-ID: <ed5u73a5lpsixqvm35zpmooolstjv22ygusorub2owbgz7cwj5@42uq6kl6run7>
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-3-syyang@lontium.com>
 <CAO9ioeXDfTdETEBQknoLehk2aiabCgse109sDgJoPHuQ_07nKQ@mail.gmail.com>
 <CAFQXuNYV+wt2-+8R4m+mtby9TBwcX+vGdqvUvb_6wXkkBg6b=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNYV+wt2-+8R4m+mtby9TBwcX+vGdqvUvb_6wXkkBg6b=w@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e75c5d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Kz8-B0t5AAAA:8 a=ycQz9VjxGySVRsFM4MMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfX3j2bn9eiM3dW
 Gq90gqSCAnEfPl5HwmAE9OS3Nykdtn4z/8QbUuJFt10D5huZFOviJJ0U5bxkms8/3Al1ypXyzP8
 jh3bWr3o1h+DQp38ZHscAhI3pi2jRImjWcDUa3tl5q0kACefBwlDLu/RQ4+/UmxFWGOaOjVz1l+
 2PvKtGgDcKJtMjpDARo7H4vuMLwF+kexUiqQglyJyIZatoPizmnYbfVAyYSsrDQztBSIqUaSDvO
 Q2KWVgOmhpMaa4v6iLbo/306YC0DS79I5zelq4cOQzQT+Oe39rLq9xhg1Kk9c9FMiOgYr4wpeWp
 AJ/8qE2eYNImCnwg0vQCThnqvDAuLCV2EL593IuwIfDLUhcRJ/VX5TcoB6TAuzmM2107CV7KnHi
 uz52Mhiy7iSH6B8Gdr1q7+xigmx/3Lz8HGkWgCsnjs9aWE5K5L5A9iH6c746aIDXFkFKDgbSmAr
 5ZVNvGatFp6+SNyWh+A==
X-Proofpoint-ORIG-GUID: qtDtfjWA89McCLVFHtIeJXPy06g6wYuA
X-Proofpoint-GUID: qtDtfjWA89McCLVFHtIeJXPy06g6wYuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210112
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

On Tue, Apr 21, 2026 at 11:13:30AM +0800, 杨孙运 wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年4月20日周一 11:57写道：
> >
> > On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
> > >
> > > From: Sunyun Yang <syyang@lontium.com>
> > >
> > > LT7911EXC is a high performance  eDP1.4 to MIPI chip for
> >
> > MIPI what?
> >
> MIPI DSI,
> It will be modified in the next version.
> 
> > > VR/Display application.
> > >
> > > -eDP1.4Receiver
> > >  1.Support SSC
> > >  2.Support 1/2/4 lanes
> > >  3.Support up to 4K@60HzRGB/YCbCr4:4:48bpc
> > >  4.Support lane swap and PN swap
> > >
> > > -MIPI Transmitter
> > >  1.CompliantwithD-PHY1.2&DSI1.1&CSI-22.0；1 clock lane,
> > >    and1/2/3/4 configurable data lanes:2.5Gbpsperdatalane
> > >  2.CompliantwithC-PHY1.0&DSI-21.0&CSI-22.0;
> > >    1/2/3 configurable data trio；2.5Gsps perdatatrio
> > >  3.Support1/2configurable ports
> > >  4.DSISupport16/20/24-bit YCbCr4:2:2,16/18/24/30-bit RGB
> > >
> > > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > > ---
> > >  drivers/gpu/drm/bridge/Kconfig             |  18 +
> > >  drivers/gpu/drm/bridge/Makefile            |   1 +
> > >  drivers/gpu/drm/bridge/lontium-lt7911exc.c | 571 +++++++++++++++++++++
> > >  3 files changed, 590 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > >
> > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > index c3209b0f4678..bae8cdaea666 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -202,6 +202,24 @@ config DRM_LONTIUM_LT8713SX
> > >           to 3 configurable Type-C/DP1.4/HDMI2.0 outputs
> > >           Please say Y if you have such hardware.
> > >
> > > +config DRM_LONTIUM_LT9611C
> >
> > I thought the patch is for LT7911EXC
> >
> Yes, it is LT7911EXC, It will be modified in the next version.
> 
> > > +       tristate "Lontium LT9611C DSI/HDMI bridge"
> > > +       select SND_SOC_HDMI_CODEC if SND_SOC
> > > +       depends on OF
> > > +       select CRC8
> > > +       select FW_LOADER
> > > +       select DRM_PANEL_BRIDGE
> > > +       select DRM_KMS_HELPER
> > > +       select DRM_MIPI_DSI
> > > +       select DRM_DISPLAY_HELPER
> > > +       select DRM_DISPLAY_HDMI_STATE_HELPER
> > > +       select REGMAP_I2C
> > > +       help
> > > +         Driver for Lontium DSI to HDMI bridge
> > > +         chip driver that converts dual DSI and I2S to
> > > +         HDMI signals
> > > +         Please say Y if you have such hardware.
> > > +
> > >  config DRM_ITE_IT66121
> > >         tristate "ITE IT66121 HDMI bridge"
> > >         depends on OF
> > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > > index beab5b695a6e..54b293d1663e 100644
> > > --- a/drivers/gpu/drm/bridge/Makefile
> > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > @@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
> > >  obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
> > > +obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) += lontium-lt7911exc.o
> >
> > Keep the list sorted, please.
> >
> Where can I see the sorting rules? Please guide me.
> it is:
> obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) += lontium-lt7911exc.o
> obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o

zoom out, check the overall contents, submit a patch fixing the error.

> ?
> 
> > >  obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
> > >  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
> > >  obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) += microchip-lvds.o
> > > diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > > new file mode 100644
> > > index 000000000000..d1c1d9e073ef
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
> > > @@ -0,0 +1,571 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > > + */
> > > +
> > > +#include <linux/crc32.h>
> > > +#include <linux/firmware.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/regmap.h>
> >
> > I think you use more than that.
> >
> It will be modified in the next version.
> 
> > > +#include <drm/drm_of.h>
> > > +
> > > +#define FW_SIZE (64 * 1024)
> > > +#define LT_PAGE_SIZE 32
> > > +#define FW_FILE  "LT7911EXC.bin"
> > > +#define LT7911EXC_PAGE_CONTROL 0xff
> > > +
> > > +struct lt7911exc {
> > > +       struct device *dev;
> > > +       struct i2c_client *client;
> > > +       struct drm_bridge bridge;
> > > +       struct drm_bridge *panel_bridge;
> >
> > Use next_bridge from struct drm_bridge instead.
> >
> It will be modified in the next version.
> 
> > > +       struct regmap *regmap;
> > > +       /* Protects all accesses to registers by stopping the on-chip MCU */
> > > +       struct mutex ocm_lock;
> > > +       struct regulator_bulk_data supplies[2];
> > > +
> > > +       struct gpio_desc *reset_gpio;
> > > +       const struct firmware *fw;
> >
> > Do you need to store it during the runtime? If not, please remove from
> > the data struct.
> >
> Don't need  store during the runtime.
> Can I use the global variable 'fw'?

Of course not.

> Because I need use 'fw' to calculate the CRC32 and burn the firmware.

Sure, but what does it have to do with the field in struct lt7911exc?

> 
> > > +       int fw_version;
> > > +       u32 fw_crc;
> > > +
> > > +       bool enabled;
> >
> > What for?
> >
> (bool enabled;) is used as a flag in the code to reduce the frequency
> of power supply switching.

How does it help to reduce the rate?

> Of course, it can also be removed in the next version.
> 
> > > +};
> > > +
> > > +static const struct regmap_range_cfg lt7911exc_ranges[] = {
> > > +       {
> > > +               .name = "register_range",
> > > +               .range_min =  0,
> > > +               .range_max = 0xffff,
> >
> > Is it an actual range?
> >
> 0xe8ff is actual  range.

Then why?

> 
> > > +               .selector_reg = LT7911EXC_PAGE_CONTROL,
> > > +               .selector_mask = 0xff,
> > > +               .selector_shift = 0,
> > > +               .window_start = 0,
> > > +               .window_len = 0x100,
> > > +       },
> > > +};
> > > +
> > > +static const struct regmap_config lt7911exc_regmap_config = {
> > > +       .reg_bits = 8,
> > > +       .val_bits = 8,
> > > +       .max_register = 0xffff,
> > > +       .ranges = lt7911exc_ranges,
> > > +       .num_ranges = ARRAY_SIZE(lt7911exc_ranges),
> > > +};
> > > +
> > > +static u32 cal_crc32_custom(const u8 *data, u64 length)
> > > +{
> > > +       u32 crc = 0xffffffff;
> > > +       u8 buf[4];
> > > +       u64 i;
> > > +
> > > +       for (i = 0; i < length; i += 4) {
> > > +               buf[0] = data[i + 3];
> > > +               buf[1] = data[i + 2];
> > > +               buf[2] = data[i + 1];
> > > +               buf[3] = data[i + 0];
> > > +               crc = crc32_be(crc, buf, 4);
> >
> > How is it different from crc32_le()?
> >
> The implementation differs from crc32_le() in both byte ordering and
> processing granularity.
> This function performs a 32-bit word-wise byte swap (little-endian to
> big-endian) before feeding data into crc32_be(), while crc32_le()
> processes the input stream directly in little-endian order without
> transformation.
> Therefore, the result is not equivalent to crc32_le(), and is required
> to match the firmware's expected big-endian word-based CRC format.

ack.

> 
> 
> > > +MODULE_LICENSE("GPL v2");
> Should GPL be used here? I got an error during testing: GPL v2;

Which error?

-- 
With best wishes
Dmitry
