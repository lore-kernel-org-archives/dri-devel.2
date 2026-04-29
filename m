Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD4BFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CCD10F038;
	Wed, 29 Apr 2026 14:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZVjkz/bw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yd4y2s8l";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818EB10F038
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:00:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T8q7dU1721232
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YKH9dv7wKtC1p8ZEO04m+kEL
 X8b+zwv/sQpT8PdfGig=; b=ZVjkz/bwitIknIzBQGGYWMnjd+c7U3oo1VDD3ojE
 amdiGSdp8vi58LpqyydYMnBfvL8uamZ8WIYrelSlx2yLPdTEBOa2u20SKht8H31S
 rCBw4E8wCS+ccd6xz/bLRB8HZ3sjjR/CxRL9FhkuuOOdnvzRrymGZEyukKJ/adAg
 VXFsgNc/BcJCVi9QDz5cbpgzNVQMrf9kHGqjuSMKWUA68mslDXOcT1Scn3oUrQ0N
 VnucAWp6lTQ0s2WEiNpo1fwxuo1B4dYbqmecD2AHb2BbvD0DiQg309g1Nz6CblUF
 emwubpt8x6BGtRXRW72mh8KyG5jTGgq91yiJJSyh+Yx8gQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dua732ahm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:00:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f6b984b3aso7052408b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777471211; x=1778076011;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
 b=Yd4y2s8lcHHz7Qz/GhUMwZJjYh0RaKKptlTe3skRvRVKEGU3JO8h5pxW2hf83+BMMh
 DFIhiN5biJ7xqzBw5tGhy7BTaCCNRaVm3QvIh0c/6t5p8MT3JCJrR154+C6iWj/tePc6
 u7hXWOucoxLvcISp+OUjHWYhUnnUhBwiqTRODgQYGiE4nY+sfLqwraY1P6MHBlF7MqxE
 FxQVYK1oQF1lLmwcWYOqMuXNKK1KmbiA8DNPSlWxJ3vrnOo4F+LIi8WaMn6XLtOBpSx6
 VaLVEpXkMNEpWkkNo7JRbCBfqv8OgHbsRhWHdHee7EkM5RojWOBJptbSDaOI63mAgi99
 JJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471211; x=1778076011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKH9dv7wKtC1p8ZEO04m+kELX8b+zwv/sQpT8PdfGig=;
 b=cSTGbplafR3NVYMzQdoE19BGgrjPYQT3elGb6U/9Uq8odPP14NxPlHtmmw0L6mvI/V
 zCmLyLBCqV5mOssU/tHcb/QoXsnKY+JgghPgaGLGfdmy9oeiOtzxHcNcMZ5ejeljakY1
 c53xY32ry59scqCFih8NWa+qQtuEu0nCTfKU4tCc8wwiRuXffsh4+r/j4diKK6pYCjwb
 6+cZPSuB5WCM2Kpti1fBpSIdqAVUWPPHaJKiywQvrOQjnaXmxnVFH/MisrZf9xTPnaYB
 VJTUihgr9GtQqDyJZik8bRKG73gH1VOSihTKjpW1LubpTP6YQTaK2dd6qt5xihYKgt/m
 kzGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ozTA5j8mQNmUmJ/wDMSBmFmI10g6L1QNPj2pRMRx57zimZSCq5ZhkJk9EOR+1YhoW032laMQ6MR8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8gapzd+OXbwhN7QH45Z3J12AzHphOo6ktZyDqNpI7+Q95A1oq
 aRe0Jm2zvUuuqC/ISYSUvP2tbf++gf68zttIm9Vl0Cxw1K2g6PDL80fIO5wcPxhbfgiNHf224A7
 q3sHzKO1sMFtHsESPDhjbqABFnR+lYIDT6qhugknbykrP0ne9G14NSZQ81Osuj5LTx5YrRYs=
X-Gm-Gg: AeBDietXWEi+77T+FQmoIjBBXtfgRK/zX+KVrHgQf2X5donDvG9jZnE5R9L53htF2yT
 prOKGKoytlrYnzJUCI5752cGPWlz9X5QAg5Xxg/JlQ3POrKfF4AjvNglAPYtl86OjC3Bmcha4dl
 NJFATrKfR3gaydoYM/vn+MZ4lQ6IMNy4aL9/Yq32wSFgC7WISdkZDYlS9FYNtnGQ73i3RQa2uJ9
 oVn+j16NC4hxupHUERLNowhu/krZIx7XmhqWYFoxPQp2JAhKRsPHb4zvEjmK2jpvh+JqmyatVmT
 +0fInkOKdeN3ISuHZjaYbtvwP2MZ8wOL/iJ/nE9KCr5qq+csnZGkTM19siIfa3hz+uxfgRRjKU1
 jm4VvR/inA8glQ4Fie/1rICjP0yjfKbfQvPd9dXc+iWN+Ipqzjx/VzTe7XR0=
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id
 d2e1a72fcca58-834ddbf1ebamr8578664b3a.29.1777471211023; 
 Wed, 29 Apr 2026 07:00:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4286:b0:82f:316:3208 with SMTP id
 d2e1a72fcca58-834ddbf1ebamr8578551b3a.29.1777471210136; 
 Wed, 29 Apr 2026 07:00:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed80ec94sm2268304b3a.52.2026.04.29.06.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:00:09 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:29:54 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <20260429135954.nvr6nyfadsjeymyt@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-11-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-11-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=XtvK/1F9 c=1 sm=1 tr=0 ts=69f20eeb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=DQeyY4SaC-8ekjbwpG4A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MSBTYWx0ZWRfX+BR5DWsXjwlW
 y3kVUhbFkBXiip5lr640FZivt2nZL3Ew3Ws3i1Xr+1JQTGrtCOepsfGiwLKdU4DvmblChMCGB9V
 6tZAh4cCIx5PACAMyJeukchofyf+iFmy821Wpz+JasTsLbrph3SzT2ppF6lcxw6xb7WC2UUK9tD
 WM2I/gN8R2h2xNsvhhBpXhGWvZpd6xg/HLRkXWpjBNOHl/WakXOYDaFLDSK1Vf+l8FRwRVz1v3P
 VgoOycazighbGPrc/ghJ0ChlGb41hPJdfmdHlp+UjHm6OjhCmq9kCjmEKzIsI/mWfbjgZ+YkI2p
 XgnQPXVN+ZEjvT2Tv5F1fx9gGW849h2W7jDCei5l5xyU/2Ec1h/Vuw+6XXywophY63CvhtDOQa2
 KHmftcj1kkBe4SLmvsZyLs6aY3E2abLFFkvhZbtOIb2LThjhMy6bPmfVnM0igCS958K52N+0ELa
 wJxV/lLORG2sz5uToVQ==
X-Proofpoint-GUID: GYXssLKob4G8PwzYi5oG3JOuh8rwofaO
X-Proofpoint-ORIG-GUID: GYXssLKob4G8PwzYi5oG3JOuh8rwofaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290141
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

On Mon, Apr 27, 2026 at 03:25:58PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gdrivers/gpu/drm/msm/Kconfigpu/drm/msm/Kconfig
> index 250246f81ea9..09469d56513b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -21,6 +21,7 @@ config DRM_MSM
>  	select SHMEM
>  	select TMPFS
>  	select QCOM_SCM

do we need this ?

> +	select QCOM_PAS
>  	select QCOM_UBWC_CONFIG
>  	select WANT_DEV_COREDUMP
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 79acae11154a..b556da823897 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -5,7 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> -#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/pm_opp.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/slab.h>
> @@ -653,7 +653,7 @@ static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
>  	if (adreno_is_a506(adreno_gpu))
>  		return 0;
>  
> -	ret = qcom_scm_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
> +	ret = qcom_pas_set_remote_state(SCM_GPU_ZAP_SHADER_RESUME, GPU_PAS_ID);
>  	if (ret)
>  		DRM_ERROR("%s: zap-shader resume failed: %d\n",
>  			gpu->name, ret);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 66f80f2d12f9..6d68edf0578c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/ascii85.h>
>  #include <linux/interconnect.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

do we need this ?

>  #include <linux/kernel.h>
>  #include <linux/of_reserved_mem.h>
> @@ -146,10 +147,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
>  		goto out;
>  
>  	/* Send the image to the secure world */
> -	ret = qcom_scm_pas_auth_and_reset(pasid);
> +	ret = qcom_pas_auth_and_reset(pasid);
>  
>  	/*
> -	 * If the scm call returns -EOPNOTSUPP we assume that this target
> +	 * If the pas call returns -EOPNOTSUPP we assume that this target
>  	 * doesn't need/support the zap shader so quietly fail
>  	 */
>  	if (ret == -EOPNOTSUPP)
> @@ -175,9 +176,9 @@ int adreno_zap_shader_load(struct msm_gpu *gpu, u32 pasid)
>  	if (!zap_available)
>  		return -ENODEV;
>  
> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");
>  		return -EPROBE_DEFER;
>  	}
>  
> -- 
> 2.51.0
> 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> 

-- 
-Mukesh Ojha
