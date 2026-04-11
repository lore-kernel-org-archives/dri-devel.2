Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70DAF3ED6A
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 23:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CC910E25B;
	Sat, 11 Apr 2026 23:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmTSBBOz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U2xRYY5i";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FD210E254
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:36:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BKhVfR448950
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ndnsEcdM+WZ9+2nFNoaruvZ7
 RSxJleFTofK5CTCFo0s=; b=jmTSBBOzSothtkzLfF1s8Sa2ShMwkvSxBduvCbQy
 Hp9uXgctDKLjz3SxPiyK9MwXe9ER7Y9e6/wV52s3kBV8wVd+dRY8BzcP5wj9Dueh
 g7RqjehTt2SnfRQ+pBkLshA9sTjtfSNNm907RGSVBECTLPVMZzntWLNu3gr8R9M6
 5q8ZJe4kvJg6zltDs0qPTsNU3zVTBnk7I0BwyXqfKVqKRfzx3J/ziOz54s9VZS36
 DxqycNtGpnnb1Ha1KLCdRcCtPMFKToKEVO265YRZHGQ7NbMa3zXRrZlRPZxqrOGL
 MovKuZGrhCnzCkgJnQWa5ciIF5E6XixbjjH9k3EcjFglVA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfeyysh4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:36:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50da529ff48so82119051cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775950586; x=1776555386;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ndnsEcdM+WZ9+2nFNoaruvZ7RSxJleFTofK5CTCFo0s=;
 b=U2xRYY5idorwiHnD2lgrciEYwbLS4UyB1KmGZrIaEelN1nm8SZ1cNBvlZhlkhL7l8B
 zMPaN5UOQHPZrFlK05z1nflnZel0USffV6WcYsMx+dLdRKWYOT83IO2c5uACiGKr+D8j
 wZn9OigUDr0SWbfOtHyab1UZ78Hbf+MdmIm7V6R/3dYttl38CLJ1YSaiHZhJFlNoFog9
 f93xgBf5ZO65RpokTThNfiMWNk3so5vW5hY04ZXUpQfO9s48W9RVwPkMYz5Sem+iUlX8
 L5qG3uclqBRRORFRJMvBbUk+ZB3QgnJogZU9yF6s5PU+J3sd2OXjhdmtlJKY0evEnbmk
 3l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775950586; x=1776555386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndnsEcdM+WZ9+2nFNoaruvZ7RSxJleFTofK5CTCFo0s=;
 b=YG1o7xMlZWgaAD87zIofaPUT+v1qZZypAFRnfWlCWDTMB8YeE0phTKbsFwbEeMHvpn
 AbgsdwiHvKU0Jwmpe7v6esQTQQySTGzZdbpX4cSZKMr2OxHR4CSX1XVG0Q9DSblUTtQI
 daYi6i7chInJuqxbyF2J8G6C+z4gP0EW0GHMFU9mj7L/3XMXGi0fRl/y4vpbDeaAVPcs
 SdGZWlhsLURbbXJnwlhJdORcncbmQoKDGgZXCdeOmZYhqZreoRVRFCMUW3Q90d5qhD/j
 SUlm4GM3t45y6hPYiNy6WkTcgWOlgqxHjT5AK+VotqMegbERR4eFThnGA4OZFHjfOs8E
 PBzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFnRmTC2dwn5tOJqL02NdEdttr1RmwE/GtVUrG55jCUImJ/tCHjk/WJnHmYmwlp7HopJorGdNgK/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxelU8X6VDVVj0vdrYh6IIXO3sanjNDhHFJjuGj/O9BOxi0pc41
 JuEA/MDGr41huqb+MwKhtvFVmoRcNaS/9ffTZE8a+rW595lZ5PTfgonNDCNVePaGmkY9D9kOkcx
 f4+2mElMDWttHv/ZTm7Mc5zH264XoAXZVFTKjjXHloLqaAyqh+zfHqDH+kedZ5nN8pJRXqSY=
X-Gm-Gg: AeBDiet6QAOQw41HQ7hYIMAI/zTLu4QSYGbPqOAF/tRdr96CQepyNqW4iI5y3OLCfKZ
 u/UU4gjGf5+lT7Nr0dbrAeh1u6B/x1DyWEMg1sApmOn5snRffJjj7tH3jtXr2nbqZMuUBV3xePx
 JvqJRNdbC/xJqnMGUmDmUfdYG509rVwaWnd8gMGP2Oz8XcGanBRZ6s3+/S6qXlo6OBSq/Bmdo+v
 2Y8UyKq2Wi9HopC4oH5hO9lqn+/qdaWZxJEjEBl1+joBA8COij05t3Tlw6Xvdm/jC338NoNulL/
 e09Usba6G2a/FGgYZAptEVVPFFBTvINs7jfTR/4I7g/JAitwYJ6bih5Ab+6p9nxjZ5UsGWb1XwK
 oEVBdkA9ISbxCi/bd4lBKSGSOiq5KEV7Nxjf9MGrBnPM2b99XQylm2DAVt1oD1TjPovX6a76xew
 3waQBFpWVfpNk718tSvQKOA722PZDrCxcEqic=
X-Received: by 2002:a05:622a:453:b0:50b:41ff:e9d2 with SMTP id
 d75a77b69052e-50dd5aca2b2mr130811081cf.21.1775950585704; 
 Sat, 11 Apr 2026 16:36:25 -0700 (PDT)
X-Received: by 2002:a05:622a:453:b0:50b:41ff:e9d2 with SMTP id
 d75a77b69052e-50dd5aca2b2mr130810691cf.21.1775950585093; 
 Sat, 11 Apr 2026 16:36:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee14bbsm1717576e87.43.2026.04.11.16.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 16:36:22 -0700 (PDT)
Date: Sun, 12 Apr 2026 02:36:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 33/39] drm/msm/dp: initialize dp_mst module for each
 DP MST controller
Message-ID: <rkfweyvcy7x2wv7zqsrihzxhwkftwrdn6vohnfxwhcf3gphlmw@ilnxcrnhhh7r>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-33-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-33-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-GUID: jHS93R4ENLeNnP4Ma4ElobygOi7-lKoP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIxNiBTYWx0ZWRfX6eHNIEJbxi2Z
 e5DX+25ebRX/g9aU+SsWWI1su9bXPDzLOTAY98GtU7ozpfum+oRTu4leNMrInv/cvrdW9o2VJSl
 XOZ7dgwpKVYszDxSG7VG+rEXPKBSb4gwtwrgAurHstleNJ72aNSyYXZIpyIrzawJgetkfR8ZzF2
 br9SntRxzTLEGSmlV1yTx75H33Sh6FO7ubWZm0gX0an4TrX4Tak8u4Cek43SEUjRu9BgjdXesXo
 IE93NY0nqdBymvI+qRU1zxJT9pyPew6Q3u1splyoSGzzsLdoi8EATEwDjmZffsFQ/MLJxLjMeRb
 l+eWiAjsXc+vMYmGEAH/3Nd+uW80W8+YD3hqIiVwC0xK1KeJQUKMhevlaGQYVfkcxTAkFrytv2i
 vw0VPWfjxmG5Hu/wyKYMzqCdSrIlAXIUHyVcVD6ASgaSpaouCwIcBQ4407sJMR5ILOXaxADVVyc
 vcD2PmRTIVFE7iyEvMA==
X-Authority-Analysis: v=2.4 cv=FPQrAeos c=1 sm=1 tr=0 ts=69dadafa cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ngwmFtEitNIM1oEfZucA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jHS93R4ENLeNnP4Ma4ElobygOi7-lKoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110216
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

On Fri, Apr 10, 2026 at 05:34:08PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> For each MST capable DP controller, initialize a dp_mst module to
> manage its DP MST operations. The DP MST module for each controller
> is the central entity to manage its topology related operations as
> well as interfacing with the rest of the DP driver.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile            |  3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  6 +++
>  drivers/gpu/drm/msm/dp/dp_display.c     | 18 ++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h     |  2 +
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 73 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h     | 13 ++++++
>  drivers/gpu/drm/msm/msm_drv.h           |  6 +++
>  7 files changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 8b94c5f1cb68..1d8426876aa1 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -144,7 +144,8 @@ msm-display-$(CONFIG_DRM_MSM_DP)+= dp/dp_aux.o \
>  	dp/dp_link.o \
>  	dp/dp_panel.o \
>  	dp/dp_audio.o \
> -	dp/dp_utils.o
> +	dp/dp_utils.o \
> +	dp/dp_mst_drm.o
>  
>  msm-display-$(CONFIG_DRM_MSM_HDMI_HDCP) += hdmi/hdmi_hdcp.o
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 090e7d790593..d7ce13a4586d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -680,6 +680,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
>  
>  		if (stream_cnt > 1) {
> +			rc = msm_dp_mst_register(priv->kms->dp[i]);
> +			if (rc) {
> +				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
> +				return rc;
> +			}
> +
>  			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
>  				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
>  				if (IS_ERR(encoder)) {
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 9eaf6994a350..919767945ba5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -28,6 +28,7 @@
>  #include "dp_drm.h"
>  #include "dp_audio.h"
>  #include "dp_debug.h"
> +#include "dp_mst_drm.h"
>  
>  static bool psr_enabled = false;
>  module_param(psr_enabled, bool, 0);
> @@ -360,6 +361,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
>  		msm_dp_display_mst_init(dp);
>  
> +	if (dp->msm_dp_display.mst_active)
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);
> +
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
>  
>  end:
> @@ -527,6 +531,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
>  						 dp->panel->dpcd,
>  						 dp->panel->downstream_ports);
>  
> +	if (dp->msm_dp_display.mst_active) {
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
> +		dp->msm_dp_display.mst_active = false;
> +	}
> +
>  	/* signal the disconnect event early to ensure proper teardown */
>  	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
>  
> @@ -1556,6 +1565,15 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>  	return 0;
>  }
>  
> +int msm_dp_mst_register(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	return msm_dp_mst_init(msm_dp_display, dp->max_stream, dp->aux);
> +}
> +
>  int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
>  				   struct drm_atomic_state *state,
>  				   struct drm_encoder *drm_encoder,
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index bda76319c459..55874daf41c4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -24,6 +24,8 @@ struct msm_dp {
>  	bool is_edp;
>  	bool prepared;
>  
> +	void *msm_dp_mst;
> +
>  	struct msm_dp_audio *msm_dp_audio;
>  	bool psr_supported;
>  };
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> new file mode 100644
> index 000000000000..b6c7b8211025
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <drm/drm_edid.h>
> +#include <drm/drm_managed.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/display/drm_dp_mst_helper.h>
> +
> +#include "dp_mst_drm.h"
> +#include "dp_panel.h"
> +
> +#define MAX_DPCD_TRANSACTION_BYTES 16
> +
> +struct msm_dp_mst {
> +	struct drm_dp_mst_topology_mgr mst_mgr;
> +	struct msm_dp *msm_dp;
> +	struct drm_dp_aux *dp_aux;
> +	u32 max_streams;
> +	/* Protects MST bridge enable/disable handling. */
> +	struct mutex mst_lock;

I don't see it being used here. Please drop. Isn't mst_mgr->lock enough?

> +};
> +
> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
> +{
> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> +	int rc;
> +
> +	rc = drm_dp_mst_topology_mgr_set_mst(&mst->mst_mgr, state);
> +	if (rc < 0) {
> +		DRM_ERROR("failed to set topology mgr state to %d. rc %d\n",
> +			  state, rc);
> +	}
> +
> +	drm_dbg_dp(dp_display->drm_dev, "dp_mst_display_set_mgr_state state:%d\n", state);
> +	return rc;
> +}
> +
> +int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
> +{
> +	struct drm_device *dev = dp_display->drm_dev;
> +	int conn_base_id = 0;
> +	int ret;
> +	struct msm_dp_mst *msm_dp_mst;
> +
> +	msm_dp_mst = devm_kzalloc(dev->dev, sizeof(*msm_dp_mst), GFP_KERNEL);
> +	if (!msm_dp_mst)
> +		return -ENOMEM;
> +
> +	memset(&msm_dp_mst->mst_mgr, 0, sizeof(msm_dp_mst->mst_mgr));
> +
> +	conn_base_id = dp_display->connector->base.id;
> +	msm_dp_mst->msm_dp = dp_display;
> +	msm_dp_mst->max_streams = max_streams;
> +
> +	msm_dp_mst->dp_aux = drm_aux;
> +
> +	ret = drm_dp_mst_topology_mgr_init(&msm_dp_mst->mst_mgr, dev,
> +					   drm_aux,
> +					   MAX_DPCD_TRANSACTION_BYTES,

Inline 16 here.

> +					   max_streams,
> +					   conn_base_id);
> +	if (ret) {
> +		DRM_ERROR("DP DRM MST topology manager init failed\n");
> +		return ret;
> +	}
> +
> +	dp_display->msm_dp_mst = msm_dp_mst;
> +
> +	mutex_init(&msm_dp_mst->mst_lock);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> new file mode 100644
> index 000000000000..5d411529f681
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DP_MST_DRM_H_
> +#define _DP_MST_DRM_H_
> +
> +#include "dp_display.h"
> +
> +int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
> +
> +#endif /* _DP_MST_DRM_H_ */
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 3061eca49cb2..5f73e0aa1c2f 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -363,6 +363,7 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
>  			       const struct drm_display_mode *mode);
>  bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
>  int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
> +int msm_dp_mst_register(struct msm_dp *dp_display);
>  #else
>  static inline int __init msm_dp_register(void)
>  {
> @@ -384,6 +385,11 @@ static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
>  	return -EINVAL;
>  }
>  
> +static inline int msm_dp_mst_register(struct msm_dp *dp_display)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
>  {
>  }
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
