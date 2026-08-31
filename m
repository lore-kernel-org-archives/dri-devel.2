Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623E6C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 718CF10E9CF;
	Mon, 31 Aug 2026 18:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YihDwGEy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zxld+vpf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE33110E991
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:38:22 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIYpXw072425
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iZOTnXM7bX1DTcrHV8IO/aLJneZD06qlZ/yboW8oqiY=; b=YihDwGEyQ7JnttWn
 BEK/vSKlMfEOAZlNfbixXhBXbOuGGAHvTQmMzsN8qpbmY2fRf8MY0b4Xus9iwwx+
 6KZ1M/utpMK8pAsA7zIZw2DCxyI3dZaRgWELSVrEWQJRM+ioJDYd3+9fxnCXh7Zk
 M3OUMZHH5e+JYw/Lrsjb84gvqWZ1eb+BuyXKuF/zueKislPA6Oz0+1ChqN1hmTQL
 fzxHx+FKIOYm3D+pD8rk7OBlpzEUkTrmPTddKNmlQ2cz+I8fhZxg/d/vHOlLXouK
 2T0L6BoqzTlf/LgClaU8nm8wtr8bGkHFaabsqiGofHOIDnGxaJwlATV3TWR7HaYq
 BSo9nQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yatgre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:38:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398dcfabbf8so230605a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788201500; x=1788806300;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iZOTnXM7bX1DTcrHV8IO/aLJneZD06qlZ/yboW8oqiY=;
 b=Zxld+vpfPe6hlYtRMkDPIF9gSkJGibBARJgxfAOLH34xBdzLYn+RJqmXuzzJYT8/8q
 f8Z38I1Y1H7pCngcN6xEAms5WacuKr4R27lIlgrY8Jdxe2RorwjrfFBhBK2+Fpdp3zXw
 f15ATCIkLMPN2jOj5Hwj5wu0oX8jYaIx4Mwqp0CgQLfL4Nu+YoBjW/ScmveY/+qwaX4A
 4CJ5lFB0SFsS4iILLZfeEnsRe95c+x73Wu5gH5r/mo4Tfsbj1wQJiiaXeU4nDFKCkRF0
 GY5TK3xl5HbwGgMZrTrVZ2rKwJLDsVsrjKPcsTvmIRr+pLt47qFPVqUqT1SqAGuu8MfH
 CUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788201500; x=1788806300;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iZOTnXM7bX1DTcrHV8IO/aLJneZD06qlZ/yboW8oqiY=;
 b=KDDva08VKOjbfpVTLd+qdcpd6hD0oiupigOIpdbJzBInR5YAGtfF9aB9Xd0hYuNPAd
 qsU1Mb8qkvfiS/gqoFGEFTFg5MbjGY0yCs9jSCzWG5IVIrqyfjzvcz1bp8F6KoLfphP3
 tWw7rY/1din/czdFsUKq1vZjMUqGkKfgDt+MKhYABD3VXt5b5nCPT11k6WONFNAtqFLs
 AGxUpzkTsol7WFTlxrOwd7mfvXgC1V9Q5JyC4L3TR7u4CAr07u+MZOOjMc93Gzu1qqFI
 L0XSFkN17AKH6/+JUlTAnmGt9V4rykA1p1MuM4dCFlSDmmBYPyZK3EtiRONwOLrrkmJM
 t1Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwV+Wqzsj/IEb3RFRWXT1Rw9GvV4mlToFmzj/tbyk4x/d3Pihb5U2GqCYUQ80ghyw4rZoDIGX1Wg2U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lcxl2Qi0toKag0L/jug2j7r9z/xSUvrz202Kx+ohxzcjr/Jh6c
 Ua7+MCAGtMUzsDnjWJRLJbhSWboKW/yFAXsX+yRpu/RawDd5w3q2GLWP9V4wEYNwYzKTNXgdzhi
 dRtQse0wFD2aVE/ToKCWR9Fj6h4dRX5rgPHS8f5fmhbm2TP/+jRRRKcHxRpmF9clMv5isDCs=
X-Gm-Gg: AYBFou1nd+oRqgkYjlG0bDYpLkUTLwSmeNWNyEeZBL4BU6M4vufRevwSFHBff3YIWrF
 oJsHW7Pon/+OBSEj+JxgPstiXcTggpFviESjX7Ea+i5y+X2/Vg0ObgzOXMDph/wmRad4lmtvpGc
 PNYGFcmTC6CudazzWlgFeidk16lipzFJFK4v97roccws3LzvnbCYJBmWpJla1Ur7uL3IdKQSJjZ
 EBBhOr30tQkc+6fWm0FI7dL8Wo4FA4CExt1RGrS8jwbDQBTPGw0rAWOu6SuYaxdIu8INSZlp/72
 MrBkLO1uROeAXpAmx0oA4VNnKBIaI6VDiJULkJDOCSAkolvQRxXzNfKPAKeeZHn0G0WR/2KZKhG
 f2/T9sPBx928EBO/tXJ6cAjJtUw==
X-Received: by 2002:a17:90b:2f0f:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-396d0fd2a75mr44414550a91.13.1788201499995; 
 Mon, 31 Aug 2026 11:38:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0f:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-396d0fd2a75mr44414448a91.13.1788201499382; 
 Mon, 31 Aug 2026 11:38:19 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm41840363c88.12.2026.08.31.11.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 11:38:18 -0700 (PDT)
Date: Tue, 1 Sep 2026 00:08:09 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <apXKES8WQzVDbQG8@hu-mdsor-hyd.qualcomm.com>
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
 <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
 <178766696083.117435.16339828039068931624.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178766696083.117435.16339828039068931624.b4-review@b4>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1OSBTYWx0ZWRfX0Wg+QuEotYGi
 ZHRuLJwoXxkjEBqfTNWvCJLUX9Q1WQui8AJHbcLtlKQiNeTMl4k4GXc2x9EazC5yAX9PT+niwnw
 blPmZUjB4/Lf0E6O+JGBQdfCpVSpv+Y=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a95ca1d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=5e_Z8SBgEUBnTVUOhy8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1OSBTYWx0ZWRfX0PVF0NMoZGhD
 ekVuS7oHNjS8r7JVn+FajtxIXabX8ITJyJBpsHjniXfSlRgzWCvO7Ij1XpiExzjRx/frWVVOO6r
 dTPnmIunclkY2DSU0SKFX1IxTDoTjwMw6uF5efZxFifwDd5xOavX2wuxXkYSpfF5FZudbKCIzhl
 VE3+iT5qa6W1NtZisPANkYSHVI2HFweCeByw5YJTFSIkIe/tb/sdGmNG3N+mC6IJOqSoo2Ehmwx
 TuZWUWcfCgmRnTdNDmfvYwuqNnUJxSPWBvJT1oGo91jAauRU9WbVaPbtKMXsIU7+/dqzGLI7nvR
 2Z5t6+/c+Y33vSqVklkjVGJGeTLEL1D0iqE+uegyCEZosAhIKJVpNFk07vtHjXVUaG02wD8qCaD
 afNGk7l77ZCFb0Gz4fxGIeqgOwSJSzM3hu/dzBleX7f98VMCjyA0HWJRCHd/cdAW2Phxr2pyyg0
 OTXYDdRiVjDhJBSW+8g==
X-Proofpoint-ORIG-GUID: qw_GX4UBRprmdQe946WcE2JBebTteNtS
X-Proofpoint-GUID: qw_GX4UBRprmdQe946WcE2JBebTteNtS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310159
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

On Tue, Aug 25, 2026 at 04:09:20PM +0200, Luca Ceresoli wrote:
> Hello Mohit,
> 
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > mipi dsi and output hdmi, differences in hardware features:
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> 
> Looks good overall, but I have various small improvements to suggest, see
> below.
> 
> Additionally, can you have a look at the issues reported by Sashiko and
> reply stating whether you think they are relevant (and they should be
> fixed) or not relevant (and why)?
Sure, will fix relevant comments of sushiko.
> 
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
> >  	  HDMI signals
> >  	  Please say Y if you have such hardware.
> >
> > +config DRM_LONTIUM_LT9611C
> > +	tristate "Lontium LT9611C DSI/HDMI bridge"
> > +	select SND_SOC_HDMI_CODEC if SND_SOC
> > +	depends on OF && I2C
> > +	select CRC8
> > +	select FW_LOADER
> > +	select DRM_PANEL_BRIDGE
> 
> I don't think the code in this revision uses the DRM_PANEL_BRIDGE API.
Will fix it in v12.
> 
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > @@ -0,0 +1,1283 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>                  ^
> 		 Nit: both 'C' uppercase
Will fix it in v12.
> 
> > +#include <linux/crc8.h>
> > +#include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/media-bus-format.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/platform_device.h>
> 
> Unused include?
Will fix it in v12.
> 
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/unaligned.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_drv.h>
> 
> Unused include?
Will fix it in v12.
> 
> > +#include <drm/drm_edid.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_of.h>
> 
> Unused include?
Using this header for of_drm_get_bridge_by_endpoint
> 
> > +#include <drm/drm_print.h>
> 
> Unused include?
Will fix it in v12.
> 
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/display/drm_hdmi_audio_helper.h>
> > +#include <drm/display/drm_hdmi_state_helper.h>
> > +#include <sound/hdmi-codec.h>
> > +
> > +#define FW_SIZE (64 * 1024)
> > +#define LT_PAGE_SIZE 256
> > +#define FW_FILE  "Lontium/lt9611c_fw.bin"
> > +#define LT9611C_CRC_POLYNOMIAL 0x31
> > +#define LT9611C_PAGE_CONTROL 0xff
> > +#define LT9611C_INFOFRAME_MAX_SIZE 32
> > +#define LT9611C_CMD_HDR_SIZE 4
> > +#define LT9611C_CMD_Y0_SIZE  1  /* Y0 echo byte in ACK response */
> > +#define LT9611C_EDID_BUF_SIZE 32
> > +
> > +struct lt9611c_cmd_hdr {
> > +	u8 func;
> > +	u8 type;
> > +	u8 seq;
> > +	u8 sep;
> > +};
> > +
> > +/* lt9611c_cmd_hdr.func values */
> > +#define LT9611C_FUNC_WRITE	0x57 /* 'W' */
> > +#define LT9611C_FUNC_READ	0x52 /* 'R' */
> > +#define LT9611C_FUNC_ACK	0x41 /* 'A' */
> > +
> > +/* lt9611c_cmd_hdr.type values */
> > +#define LT9611C_TYPE_MIPI	0x4d /* 'M' */
> > +#define LT9611C_TYPE_LVDS	0x4c /* 'L' */
> > +#define LT9611C_TYPE_HDMI	0x48 /* 'H' */
> > +#define LT9611C_TYPE_AUDIO	0x41 /* 'A' */
> > +#define LT9611C_TYPE_CUSTOM	0x43 /* 'C' */
> > +
> > +/* lt9611c_cmd_hdr.sep is always ':' */
> > +#define LT9611C_CMD_SEP		0x3a /* ':' */
> > +
> > +struct lt9611c_cmd {
> > +	struct lt9611c_cmd_hdr hdr;
> > +	const u8 *data;
> > +	size_t data_len;
> > +};
> > +
> > +struct lt9611c_rsp {
> > +	struct lt9611c_cmd_hdr hdr;
> > +	u8 *data;
> > +	unsigned int data_len;
> > +};
> > +
> > +enum lt9611_chip_type {
> > +	CHIP_LT9611C = 0,
> > +	CHIP_LT9611EX,
> > +	CHIP_LT9611UXD,
> > +};
> > +
> > +struct lt9611c_chip_data {
> > +	enum lt9611_chip_type chip_type;
> > +	unsigned long long max_tmds_rate;
> > +};
> > +
> > +static const struct lt9611c_chip_data lt9611c_chip_data[] = {
> > +	[CHIP_LT9611C]   = { CHIP_LT9611C,   340000000 },
> > +	[CHIP_LT9611EX]  = { CHIP_LT9611EX,  340000000 },
> > +	[CHIP_LT9611UXD] = { CHIP_LT9611UXD, 600000000 },
> > +};
> > +
> > +struct lt9611c {
> > +	struct device *dev;
> > +	struct i2c_client *client;
> > +	struct drm_bridge bridge;
> > +	struct regmap *regmap;
> > +	struct mutex mcu_lock;
> > +	struct work_struct work;
> > +	struct device_node *dsi0_node;
> > +	struct device_node *dsi1_node;
> 
> These two device_nodes are unused after probe finishes, so storing them for
> the entire device lifetime is unnecessary. You could make
> lt9611c_parse_dt() return them to lt9611c_probe(), taking care of putting
> them correctly.
> 
> While that, consider using
> 
>   struct device_node __free(device_node) dsi0_node = ...;
> 
> instead of
> 
>   struct device_node dsi0_node;
>   ...
>   dsi0_node = ...;
>   ...
>   of_node_put(dsi0_node);
> 
> when applicable
Will do the changes in v12.
> 
> > +	struct mipi_dsi_device *dsi0;
> > +	struct mipi_dsi_device *dsi1;
> 
> And these two are never used outside of lt9611c_probe(). Make them
> temporary variables in lt9611c_probe().
Will fix it in v12.
> 
> > +	struct gpio_desc *reset_gpio;
> > +	struct regulator_bulk_data supplies[2];
> > +	int fw_version;
> > +	/* Chip variant: C/EX/UXD */
> > +	enum lt9611_chip_type chip_type;
> > +	unsigned long long max_tmds_rate;
> 
> Why storing a copy of these two? You can just store the 'const struct
> lt9611c_chip_data *' returned by i2c_get_match_data(), which points to an
> entry in the static i2c_get_match_data[], and use it to fetch the
> model-specific info. As a bonus this will also be future-proof in case more
> fields are added to struct lt9611c_chip_data in the future.
> 
> > +static int lt9611c_write_data(struct lt9611c *lt9611c, const struct firmware *fw, size_t addr)
> > +{
> > +	struct device *dev = lt9611c->dev;
> > +	int ret;
> > +	unsigned int page = 0, num = 0, i = 0;
> 
> No need to initialize these variables, they are set before reading.
Will fix it in v12.
> 
> > +	size_t size, index;
> > +	const u8 *data;
> > +	u8 value;
> > +
> > +	data = fw->data;
> > +	size = fw->size;
> > +	page = DIV_ROUND_UP(size, LT_PAGE_SIZE);
> 
> 'page' really holds the number of pages, please rename to 'npages' or
> 'pages'.
Will change it in v12.
> 
> > +	if (page * LT_PAGE_SIZE > FW_SIZE) {
> > +		dev_err(dev, "firmware size out of range\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(dev, "%u pages, total size %zu byte\n", page, size);
> > +
> > +	for (num = 0; num < page; num++) {
> 
> Some variables (i, ret, value, maybe others?) are only used inside the
> loop, move their declaration inside the loop.
Will fix it in v12.
> 
> > +		lt9611c_data_to_sram(lt9611c);
> > +
> > +		for (i = 0; i < LT_PAGE_SIZE; i++) {
> > +			index = num * LT_PAGE_SIZE + i;
> > +			value = (index < size) ? data[index] : 0xff;
> > +
> > +			ret = regmap_write(lt9611c->regmap, 0xe059, value);
> > +			if (ret < 0) {
> > +				dev_err(dev, "write error at page %u, index %u\n", num, i);
> > +				return ret;
> > +			}
> > +		}
> > +
> > +		lt9611c_wren(lt9611c);
> > +		lt9611c_sram_to_flash(lt9611c, addr);
> > +
> > +		addr += LT_PAGE_SIZE;
> > +	}
> > +
> > +	lt9611c_wrdi(lt9611c);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> > +{
> > +	struct device *dev = lt9611c->dev;
> > +	const struct firmware *fw;
> > +	u8 *buffer;
> > +	size_t total_size = FW_SIZE - 1;
> > +	u8 fw_crc;
> > +	int ret;
> > +
> > +	/* load firmware — must happen outside the mcu_lock */
> 
> Ain't this obvious? I'd remove this comment line.
Will remove it in v12.
> 
> > +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> > +{
> > +	struct lt9611c *lt9611c = dev_id;
> > +	struct device *dev = lt9611c->dev;
> > +	int ret;
> > +	unsigned int irq_status;
> > +
> > +	guard(mutex)(&lt9611c->mcu_lock);
> > +
> > +	ret = regmap_read(lt9611c->regmap, 0xe084, &irq_status);
> > +	if (ret) {
> > +		dev_err(dev, "failed to read irq status: %d\n", ret);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (!(irq_status & BIT(0)))
> > +		return IRQ_NONE;
> > +
> > +	/*Clear interrupt: hardware requires two writes with delay*/
> 
> Nit: space after '/*' and before '*/'.
Will fix it in v12.
> 
> Same in other places in this patch.
> 
> > +static int lt9611c_regulator_init(struct lt9611c *lt9611c)
> > +{
> > +	struct device *dev = lt9611c->dev;
> > +	int ret;
> > +
> > +	lt9611c->supplies[0].supply = "vcc";
> > +	lt9611c->supplies[1].supply = "vdd";
> > +
> > +	ret = devm_regulator_bulk_get(dev, 2, lt9611c->supplies);
> > +
> > +	return ret;
> 
> Just:
> 
>    return devm_regulator_bulk_get(dev, 2, lt9611c->supplies);
> 
> and remove the 'ret' variable.
Will fix it in v12.
> 
> > +static int lt9611c_bridge_attach(struct drm_bridge *bridge,
> > +				 struct drm_encoder *encoder,
> > +				 enum drm_bridge_attach_flags flags)
> > +{
> > +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> 
> I think it would be nice to ban the deprecated connector creation by adding
> here:
> 
>     if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> 	return -EINVAL;
> 
> and maybe log an error too. Look at other drivers which do this.
Will fix it in v12.
> 
> > +
> > +	return drm_bridge_attach(encoder, lt9611c->bridge.next_bridge, bridge, flags);
> > +}
> > +
> > +static enum drm_mode_status
> > +lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
>                      ^^^^
> Out of curiosity, what does "char" means here?
"char" = character — TMDS (Transition Minimized Differential Signaling) transmits data using 8b/10b encoding, where each
  encoded 10-bit symbol is called a "character". The TMDS character rate is the number of these symbols transmitted per second
  per lane, which equals the TMDS clock frequency.
> 
> > +static void lt9611c_video_setup(struct lt9611c *lt9611c,
> > +				const struct drm_display_mode *mode)
> > +{
> > +	struct device *dev = lt9611c->dev;
> > +	int ret;
> > +	u32 h_total, hactive, hsync_len, hfront_porch, hback_porch;
> > +	u32 v_total, vactive, vsync_len, vfront_porch, vback_porch;
> > +	u8 timing_data[22];
> > +	struct lt9611c_rsp rsp = {};
> > +	u8 framerate;
> > +	u8 vic = 0x00;
> > +	struct lt9611c_cmd cmd = {
> > +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x33, LT9611C_CMD_SEP },
> > +		.data = timing_data,
> > +		.data_len = ARRAY_SIZE(timing_data),
> 
> Nit: sizeof(timing_data) would be more correct. It is equivalent here
> because it's a u8 array, but as a general rule it's better to ensure you
> catch the entire buffer size, not the amount of elements which in other
> cases might be larger than 1 byte.
Will fix it in v12
> 
> > +	};
> > +
> > +	guard(mutex)(&lt9611c->mcu_lock);
> > +	h_total = mode->htotal;
> > +	hactive = mode->hdisplay;
> > +	hsync_len = mode->hsync_end - mode->hsync_start;
> > +	hfront_porch = mode->hsync_start - mode->hdisplay;
> > +	hback_porch = mode->htotal - mode->hsync_end;
> > +
> > +	v_total = mode->vtotal;
> > +	vactive = mode->vdisplay;
> > +	vsync_len = mode->vsync_end - mode->vsync_start;
> > +	vfront_porch = mode->vsync_start - mode->vdisplay;
> > +	vback_porch = mode->vtotal - mode->vsync_end;
> > +	framerate = drm_mode_vrefresh(mode);
> > +	vic = drm_match_cea_mode(mode);
> > +
> > +	dev_dbg(dev, "hactive=%d, vactive=%d\n", hactive, vactive);
> > +	dev_dbg(dev, "framerate=%d\n", framerate);
> > +	dev_dbg(dev, "vic = 0x%02x\n", vic);
> > +
> > +	put_unaligned_be16(h_total,       &timing_data[0]);
> > +	put_unaligned_be16(hactive,       &timing_data[2]);
> > +	put_unaligned_be16(hfront_porch,  &timing_data[4]);
> > +	put_unaligned_be16(hsync_len,     &timing_data[6]);
> > +	put_unaligned_be16(hback_porch,   &timing_data[8]);
> > +	put_unaligned_be16(v_total,       &timing_data[10]);
> > +	put_unaligned_be16(vactive,       &timing_data[12]);
> > +	put_unaligned_be16(vfront_porch,  &timing_data[14]);
> > +	put_unaligned_be16(vsync_len,     &timing_data[16]);
> > +	put_unaligned_be16(vback_porch,   &timing_data[18]);
> > +	timing_data[20] = framerate;
> > +	timing_data[21] = vic;
> 
> You are kind us (ab)using an array as a manually-maintained
> struct. Wouldn't it be a lot cleaner and readable if you declare a struct?
> E.g.:
> 
>     struct {
>       __be16 htotal;
>       __be16 hactive;
>       ...
>       u8 framerate;
>       u8 vic;
>     } timing_data;
> 
>     ...
> 
>     timing_data.htotal    = cpu_to_be16(htotal);
>     timing_data.hactive   = cpu_to_be16(hactive);
>     ...
>     timing_data.framerate = framerate;
>     timing_data.vic       = vic;
> 
> With that you can stop including unaligned.h too.
Will fix it in v12
> 
> > +static int lt9611c_probe(struct i2c_client *client)
> > +{
> > +	struct lt9611c *lt9611c;
> > +	struct device *dev = &client->dev;
> > +	bool fw_updated = false;
> > +	int ret;
> > +
> > +	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		return dev_err_probe(dev, -ENODEV, "device doesn't support I2C\n");
> > +
> > +	lt9611c = devm_drm_bridge_alloc(dev, struct lt9611c, bridge, &lt9611c_bridge_funcs);
> > +	if (IS_ERR(lt9611c))
> > +		return dev_err_probe(dev, PTR_ERR(lt9611c), "drm bridge alloc failed.\n");
> > +
> > +	lt9611c->dev = dev;
> > +	lt9611c->client = client;
> > +
> > +	const struct lt9611c_chip_data *cdata = i2c_get_match_data(client);
> > +
> > +	if (!cdata)
> > +		return dev_err_probe(dev, -EINVAL, "no match data for device\n");
> 
> Nit: no empty line between a function call and its error checking if().
Will fix it in v12.
> 
> > +
> > +	lt9611c->chip_type = cdata->chip_type;
> > +	lt9611c->max_tmds_rate = cdata->max_tmds_rate;
> > +
> > +	ret = devm_mutex_init(dev, &lt9611c->mcu_lock);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to init mutex\n");
> > +
> > +	lt9611c->regmap = devm_regmap_init_i2c(client, &lt9611c_regmap_config);
> > +	if (IS_ERR(lt9611c->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(lt9611c->regmap), "regmap i2c init failed\n");
> > +
> > +	ret = lt9611c_parse_dt(dev, lt9611c);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> > +
> > +	lt9611c->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(lt9611c->reset_gpio)) {
> > +		ret = PTR_ERR(lt9611c->reset_gpio);
> > +		goto err_of_put;
> > +	}
> > +
> > +	ret = lt9611c_regulator_init(lt9611c);
> > +	if (ret < 0)
> > +		goto err_of_put;
> > +
> > +	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +	if (ret)
> > +		goto err_of_put;
> 
> Why not moving this inside lt9611c_regulator_init()?
Will modify it in v12. 
> Also, I _think_ lt9611c_regulator_init() could just
> devm_regulator_bulk_get_enable() to do both things at once, but I'm not
> sure that would be compatible with PM. If it's safe it would simplify the
> code quite a lot, and also allow using devm_drm_bridge_add() below, making
> the remove function almost empty.
regulator_bulk_disable/enable are called in suspend/resume and in remove — so devm_regulator_bulk_get_enable is not suitable
  here
> 
> > +
> > +	lt9611c_reset(lt9611c);
> > +
> > +	lt9611c_lock(lt9611c);
> > +
> > +	ret = lt9611c_read_chipid(lt9611c);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to read chip id.\n");
> > +		lt9611c_unlock(lt9611c);
> > +		goto err_disable_regulators;
> > +	}
> > +
> > +retry:
> > +	lt9611c->fw_version = lt9611c_read_version(lt9611c);
> > +	if (lt9611c->fw_version < 0) {
> > +		dev_err(dev, "failed to read fw version\n");
> > +		ret = -EOPNOTSUPP;
> > +		lt9611c_unlock(lt9611c);
> > +		goto err_disable_regulators;
> > +
> 
> Nit: no empty line.
Will fix it in v12
> 
> > +	} else if (lt9611c->fw_version == 0) {
> > +		if (!fw_updated) {
> > +			fw_updated = true;
> > +			lt9611c_unlock(lt9611c);
> > +			ret = lt9611c_firmware_upgrade(lt9611c);
> > +			if (ret < 0)
> > +				goto err_disable_regulators;
> > +			lt9611c_lock(lt9611c);
> > +			goto retry;
> > +
> > +		} else {
> > +			dev_err(dev, "fw version 0x%04x, update failed\n", lt9611c->fw_version);
> > +			ret = -EOPNOTSUPP;
> > +			lt9611c_unlock(lt9611c);
> > +			goto err_disable_regulators;
> > +		}
> > +	}
> > +
> > +	lt9611c_unlock(lt9611c);
> > +	dev_dbg(dev, "current version:0x%04x", lt9611c->fw_version);
> > +
> > +	INIT_WORK(&lt9611c->work, lt9611c_hpd_work);
> > +
> > +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> > +					lt9611c_irq_thread_handler,
> > +					IRQF_TRIGGER_FALLING |
> > +					IRQF_ONESHOT |
> > +					IRQF_NO_AUTOEN,
> > +					"lt9611c", lt9611c);
> > +	if (ret) {
> > +		dev_err(dev, "failed to request irq\n");
> > +		goto err_disable_regulators;
> > +	}
> > +
> > +	lt9611c->bridge.of_node = client->dev.of_node;
> > +	lt9611c->bridge.ops = DRM_BRIDGE_OP_DETECT |
> > +			DRM_BRIDGE_OP_EDID |
> > +			DRM_BRIDGE_OP_HPD |
> > +			DRM_BRIDGE_OP_HDMI |
> > +			DRM_BRIDGE_OP_HDMI_AUDIO;
> > +	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> > +
> > +	lt9611c->bridge.vendor = "Lontium";
> > +	lt9611c->bridge.product = "LT9611C";
> > +
> > +	lt9611c->bridge.hdmi_audio_dev = dev;
> > +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels = 8;
> > +	lt9611c->bridge.hdmi_audio_dai_port = 2;
> > +
> > +	drm_bridge_add(&lt9611c->bridge);
> > +
> > +	/* Attach primary DSI */
> > +	lt9611c->dsi0 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node);
> > +	if (IS_ERR(lt9611c->dsi0)) {
> > +		ret = PTR_ERR(lt9611c->dsi0);
> > +		goto err_remove_bridge;
> > +	}
> > +
> > +	/* Attach secondary DSI, if specified */
> > +	if (lt9611c->dsi1_node) {
> > +		lt9611c->dsi1 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi1_node);
> > +		if (IS_ERR(lt9611c->dsi1)) {
> > +			ret = PTR_ERR(lt9611c->dsi1);
> > +			goto err_remove_bridge;
> > +		}
> > +	}
> > +
> > +	lt9611c->hdmi_connected = false;
> > +	i2c_set_clientdata(client, lt9611c);
> > +	enable_irq(client->irq);
> > +
> > +	return 0;
> > +
> > +err_remove_bridge:
> > +	drm_bridge_remove(&lt9611c->bridge);
> > +	cancel_work_sync(&lt9611c->work);
> > +
> > +err_disable_regulators:
> > +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +
> > +err_of_put:
> > +	of_node_put(lt9611c->dsi1_node);
> > +	of_node_put(lt9611c->dsi0_node);
> > +
> > +	return ret;
> > +}
> > +
> > +static void lt9611c_remove(struct i2c_client *client)
> > +{
> > +	struct lt9611c *lt9611c = i2c_get_clientdata(client);
> > +
> > +	disable_irq(client->irq);
> > +	cancel_work_sync(&lt9611c->work);
> > +	drm_bridge_remove(&lt9611c->bridge);
> > +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> > +	of_node_put(lt9611c->dsi1_node);
> > +	of_node_put(lt9611c->dsi0_node);
> > +}
> 
> > +static struct i2c_device_id lt9611c_id[] = {
> > +	{ "lontium,lt9611c",   (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
> > +	{ "lontium,lt9611ex",  (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
> > +	{ "lontium,lt9611uxd", (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },
> 
> AFAIK there should be no vendor prefix for the i2c_device_id. Have a look
> at the docs and other drivers for the best practice.
Will remove the prefix in v12.
> 
> Luca
> 
> -- 
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
