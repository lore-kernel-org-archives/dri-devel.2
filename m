Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CEACC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C470E10E268;
	Thu, 15 Oct 2026 12:44:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFB310E249
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:44:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9je951955612
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=w8o5JafesiRvwaLb/g8OOXSj
 6qim+o/hrusYm3HaIh8=; b=O+Ke54GgUCNZs50ieolXqxwKWZv0GIbzUBWi/mRX
 qAr6Yc9v7NGxFfNxuj1qm+mf68ZVCtMHRN/GHTRMJQiIoKc8h1h84O3NW2NiiT2R
 wLdLcB8PSbHwQqJoTa3n00fLvxuYQ1WxSTJdTbHfVACOEMIJMfTL0kI8f+cId4Uu
 Ofom2YTbY9cCqIN666IL9KBx4fbze9wANQhw2i/msJHFhBaVbRBac+rszrbYC8Kj
 3pL7HzIWeJ9b4zWstuSD75Vu3okjf8sdEngWm5Dyc+K8H69jlyzuQpNzOU38trOO
 TUb4BmS1X2z8hfsvxeljav8v/3aQ/PKwsB4izHosZsRD6w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdetwt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 12:44:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917b7dd3f1dso24311816d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792068256; x=1792673056;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w8o5JafesiRvwaLb/g8OOXSj6qim+o/hrusYm3HaIh8=;
 b=YRcjxagX5hzQkSsTsxn6KZNft+CXk00sIvtJhLSo2YZF8oUBD+WPSsoSJIpVfEHWci
 /0xbfhnkTZptaxEADI2r7q4KJqB7h3BEI6bTrpXv94jfhNZ9AGQi03O+kOgNFpGzSPTj
 42dy3moOJGf2347HguiMtYPHcqglMG6DYxK7XbHnWBICWjDELpRxwBbTsK2yJOmZNkyP
 PMA4DLli8MHAkZkfdE5CdZI4oDpzUCVFuLjPLIWwrIB1BM7tnrsH/aq8CWrR6kO9EX9+
 D46kD7onlMdrxvcbiz5g6PYhIXJyHLGhseNhs5LbojFRq+kv1ONLzvnrJtXZHeyPxVWP
 3pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792068256; x=1792673056;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w8o5JafesiRvwaLb/g8OOXSj6qim+o/hrusYm3HaIh8=;
 b=PjVV8vErZ59IVa1nswi8O28ylztNLUMFb4LvepJf/LgU7eMCpWmsctwrrHGE3bfhdU
 UR6C9zGcxtrkbCbgE6GzLPI+VVhkcFwSY9sCmUyPLmghu+pCB/olyXsEJ9Lba8r7Y+Bu
 JGkinC5ucrunDHmxcPf2lRWkkRhADGALvcL+97p/O2SgvECAaUI6ODhaj64XPi2X7tG0
 GhfKrNeiQjg/5g1aqxK0i7L+vUIHUDszjPW/ZbV7t97O0vt+WXSxTWTtP2QDFRKIF9HQ
 HiXQvah8/s189GT7ihUeDNAYCGOOG4IzlYe1UBOOtYosqPP6V4sBxczNO1Oyi/HGDOLg
 r5og==
X-Forwarded-Encrypted: i=1;
 AKwUvByQGukw1Nv+uxENEPqH2Z/6wb+U67dPnW8ZxkBZPrlcRyDcNQQoSXj69I7VLCGBTMz8FpXdnv1ck2U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLHcvCP4zQrO+7Mrjfm3D2V4oN/ZUmtExHyIGf6h8SJfr7q0jaD
 oE+Sg1x2pQ9aFQ2Xg9qjP4//ssHfKvB4RLXcliYKKG+HcvR0k0ducPQlEQrJ7BOomgNASTU44fH
 dipKfKdzNyP4XLJUDwYCBOjJEhDmLyhyJpacVYEjopijJ6pKv2CjlXFeSMFGZKLVBhL2Qpho=
X-Gm-Gg: AYBFou13v20H44IYs7qQZ4QV+bFCqDY3IWQVMmIqKbsIryr4HMFlYmAXkjdtlJvQxi0
 6kjq+7LPC/r5ctHjEQvi+VxyO8HzeaqiAVRziZYrAa30vEPbApLp388bgSlMBOxOrDglW52OotB
 csh82r0j8kA0sTjA6ipVzBT4g/hBEFeTYQ36XyDOkOo+64AgZo0eCNUswnpPYQIRSIb0FgEMcEd
 7DH82Tjoe3Gcgnw+GbfJVexiiLNR0CFZ0kmC9SL9ajn74SVCFG17ZURzNNOUz5tu9E0ob4uZI4Y
 Y/XXvHzTKc2VDcBV909gqM/g8NmkaTIKiWP1uvXj5ePlDGyRiawBVPEiXVrRsgtrshGHwpUgEi3
 RTmLL6Yqb3rf5jjyj+i4D/BOtkpfbCgkicMhHCYV4WXb1QhMFFTM4qkwdOsTB8ynqkA5b8YE/IO
 ZAbKB4i4OLEjub
X-Received: by 2002:a05:620a:4041:b0:937:675e:2903 with SMTP id
 af79cd13be357-93ebd212371mr3197368485a.14.1792068255566; 
 Thu, 15 Oct 2026 05:44:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4041:b0:937:675e:2903 with SMTP id
 af79cd13be357-93ebd212371mr3197362985a.14.1792068254905; 
 Thu, 15 Oct 2026 05:44:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafdf2fa18sm5761271fa.36.2026.10.15.05.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 05:44:13 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:44:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 07/13] drm/msm/dcp: Add DCP encoder
Message-ID: <bmtabdrtxygyubfmxgvixn5r4rosu4tepopc2ro37heeqzwzgx@mu5wk2stm7yi>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-7-48aad0fe4f72@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-7-48aad0fe4f72@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0caa0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=N3-jI2xQlndCWEcerb8A:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: R3NPJrOluzURbsCpQw5h36Z6s0cFvYl0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfX+WJw9d3otOFl
 OlPgSroJGhMfFpU1CJr/4cTO6lkprEree0pbzDMrBhm16oVPAUR6p2Jze/dhyWoIfuRkRXIcy36
 4c8+YfC3Zrnn6l45oemG69PyR4ZHPm+nRLSkuoqfqKr9age7/LQ3Fy04nYg3F4XWle8rdj1fFKn
 Obk9p7wwXkJMCqD0/DSxkZTOP9LXUoQuozedvLMMTw1jZHS+Jbb2OKYkDUvkL3uc0wYGA0aGLq3
 lU7AiOHOgPd3G2lerzoyFf2sG6kEkUK30FU+Qso+kYE4+9SxwmcdJzv0D75rmrJnyQMck7ik9QQ
 0ww5LvkXCcZoc+kF+2Fbba3WRZnLOPhE7DN4JWa6vK3A3jwrb9hIpYSSZJRXeDobQsLUxfSekUZ
 FoVCqdCKoKoIASST93LY3+PGxjLWd8Tm++1m02grtCqX9xh9/fU22akDVEmb4wF7UAHKrmVY6FZ
 MLGUbUdZD1iBsnQpaFQ==
X-Proofpoint-GUID: R3NPJrOluzURbsCpQw5h36Z6s0cFvYl0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfX94jtqHXk2mNX
 2EoK+bR01vOUFMjZpVo8JZI+3GdcQB2wT9kjcpvw8wgIzDUGZdMlAR36QK+NPWbmEriYtgN1C/a
 W56Yanfzp635BEDVXcgcal9ZxzbMB4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150050
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

On Thu, Oct 15, 2026 at 01:08:27PM +0530, Jayant Shekhar wrote:
> The DCP display pipeline needs a DRM encoder to connect a CRTC to its
> firmware-backed output bridge while reusing the existing MSM DRM object
> model.
> 
> Add the DCP encoder wrapper and keep encoder allocation and DRM object
> initialization independent from bridge and KMS registration.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/msm/Makefile          |  1 +
>  drivers/gpu/drm/msm/dcp/dcp_encoder.c | 31 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_encoder.h | 16 ++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index b7c1a2e9a19e..e7d24be72113 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -81,6 +81,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_plane.o \
>  	dcp/dcp_ipcc.o \
>  	dcp/dcp_plane.o \
> +	dcp/dcp_encoder.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.c b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
> new file mode 100644
> index 000000000000..bc173fffb325
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP encoder wrapper for the CRTC-to-bridge connection.
> + * Hardware programming and mode sequencing are handled by the bridge and HFI.
> + */
> +
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_managed.h>
> +
> +#include "dcp_encoder.h"
> +
> +struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type)
> +{
> +	struct drm_encoder *encoder;
> +	int ret;
> +
> +	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
> +	if (!encoder)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = drmm_encoder_init(dev, encoder, NULL, enc_type, "encoder%d",
> +				dev->mode_config.num_encoder);
> +	if (ret) {
> +		dev_err(dev->dev, "encoder init failed: %d\n", ret);

Again, ignored feedback. Use drm_foo functions instead of dev_foo().
Also, there is little point in printing an error here.

> +		return ERR_PTR(ret);
> +	}
> +
> +	return encoder;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.h b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
> new file mode 100644
> index 000000000000..de40c9bca4bb
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP encoder interface between the CRTC and bridge chain.
> + * Hardware programming is delegated to DCP firmware.
> + */
> +
> +#ifndef __DCP_ENCODER_H__
> +#define __DCP_ENCODER_H__
> +
> +#include <drm/drm_encoder.h>
> +
> +struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type);
> +
> +#endif /* __DCP_ENCODER_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
