Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A52105F792
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 10:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F0410EB7D;
	Fri, 13 Mar 2026 10:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pm9lU4B/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WdNDEIMj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D7710EB7D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:31:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D7JSOk240513
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HAiEN5O88AauO/e6CBheAfLSiqoyqpVyEHYZIPbWbCs=; b=Pm9lU4B/VRT9okLI
 LGcYwnm9Bk9RGsxP7ZlIZSrJ+LGwMLrIjIc6OQx0iRXjIOuLm/3l2xcNPmNdVcNx
 Avr0XNR1M0EMaJ5ID7YlvMXPWafzV25P68ah7q5howdPUoxSJZp5DNkUc+QhIKw0
 gYTTyG0rWqVKy3Owka8K3GPRan8LoCXQ9F8uJm7yLv1XGLzyI0z4L/qzvYkb09ou
 4RyM+SBG0UgWLd+iZaEyvsuzo7LL9gggRHn3YqXN//QdDr8N0qI4EO9REBY5/Uwi
 nivayRnrZT+zLe3LhEOW/pAhQJNjPru57KId1T/z8VimT9BHbWYtx6I4FvFiTr7V
 KtXG5w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cve3d8pbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 10:31:17 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5ffaa21ba15so300129137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773397876; x=1774002676;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HAiEN5O88AauO/e6CBheAfLSiqoyqpVyEHYZIPbWbCs=;
 b=WdNDEIMjMN1UgOG3jAozyaRmeoXEeZdAQzIzByRdHcO/ANYP1LIcWf1KXWBKFUdKZX
 7yGcR4SGUGER/DpP0U4ekAaA4C25OXRiC0glvT34RSJTyqJa/jdgF2c8UtgbyFTmeuiE
 wRgZKwA3X8KvBWyqAFTCa55K1qXFaLTf9sfczI5F8gMHVdPUd9anxkirdESFYwYEVLQV
 lv6bP0yklFYttFf8x8Fkb6MeraDVS2EqHWyH4T+RIHAoNo9Zsw5CjIdvLObMWPNbQ9h5
 tXXFB0tnMKQkClQ5MNEWu+SpR89dDV3okJJUXH6jXhg5zaIyy3lKdnJEJmVgTGuRNFG8
 QoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773397876; x=1774002676;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HAiEN5O88AauO/e6CBheAfLSiqoyqpVyEHYZIPbWbCs=;
 b=oSurK1Wt7BbWGHrFXgi+Ffbv3tmTJc2TPk56XM9z0n1HPLWVDaE//V1UbSMMZ/HIAJ
 f4rxZsqFRSI1jjyGZFxGHnu8waim5IKqqqAV+S4SVHffM/aK2XuXOYxLtBhydo9GWo/Y
 aHxjeQ+toUS1vFNSrhGM1OGXiYEwTIMHxoEo/R4jTou/slAo4abl2PY2v0N5QF9duexq
 0zIJoew7uu/im6JCxfa8OXAsrVQ2EBc3YD+HxZRVp8HAgUuv+mvlbPqVOttoFSUIuSLV
 uHbnP63d9Gm+g2DVLs2hRRhaNBaPcv1EZ9ZdOz8qKbsULX3K1n7IrsWzo3gcD/7UP3aj
 jVpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGhLU/eMc1KwhJUXNV2U/0WFDUGmcdI/mB89nJW0N9pYvi6T/qsRrNg2oVhln004IodNiRakaN2NE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNEODGIOPSHGvxhzcPNynYx+Z0fPv7Ti4lwtVUYwjenHtTSHGd
 A+8PT7vvqkVkTldG647KIsCSctN6NyubVjIdxdMAhL4ulb1CirVYCTxLvDfibsslYI+lUG3DLWE
 WDEK9is6SFy8Oja+mOWEceTgnwcieH/noihFN6nc7gDJQ2sD3meczFhZqdPduRIEXVcvEjsM=
X-Gm-Gg: ATEYQzxUyguqV5RMqlnQcxchVruZ+PFufAJCFArkdYE3pIbTN+35zxNkdXvWpvjHkHf
 fy/CZ50iGX2vSQ3VwmOQdjy26r6aAicXPvcbosQ8mzfSQJhsh97BXlJaOUzuAgmSrgCP/xQ/GN6
 AQo+FuhFtjG7gu1Dr3/aAOb63bMBBob8lhwjE1HYGahE/kSH5q/OQ8wr5h1NCOt9db5juMOEUa2
 xkjhSWfP5RIu29OAQkv7+VFCI5hZ29Aj0RaPMfFS0kkJ3iLWnjRcXiBGuIiDRFIb2LZbMfmJsyK
 QcNkXf5ABG37TiNitKStcP9t+dN+nBgIWknbVq6nSlRflMI3qiYYglJgAcCtrkKlkWK+5Ae5uD4
 6r3SQYbFp3YGa4cZ00tnd24M4LvINjRd5Z6eCW12PaDtPIDTBlmFx38GAkqFu9rfchFtI+360B/
 ifUDg=
X-Received: by 2002:a05:6102:e0f:b0:5ff:9d74:9677 with SMTP id
 ada2fe7eead31-6020e5f6aa2mr554597137.3.1773397876000; 
 Fri, 13 Mar 2026 03:31:16 -0700 (PDT)
X-Received: by 2002:a05:6102:e0f:b0:5ff:9d74:9677 with SMTP id
 ada2fe7eead31-6020e5f6aa2mr554581137.3.1773397875538; 
 Fri, 13 Mar 2026 03:31:15 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cbf9028sm37293566b.19.2026.03.13.03.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 03:31:14 -0700 (PDT)
Message-ID: <531091c5-92cc-4fa3-b32f-5359ad16f4bc@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 11:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/27] drm/msm/adreno: use new helper to set amsbc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-16-b7e8f800176a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-ubwc-rework-v3-16-b7e8f800176a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: m7J7ho3L0z4WQYZ_x_ndVTM5vpCjynQJ
X-Authority-Analysis: v=2.4 cv=FLwWBuos c=1 sm=1 tr=0 ts=69b3e775 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=udGKqQrmj_Eh5FJO_w0A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MiBTYWx0ZWRfX836wDMFXq9xE
 nqkVd6LwaDojIF/DbPaZxiAVyPHYqu42aWhPjoKt7FGWS+HVHJUCN99JDssEmQVhgEB0jjZagRo
 7a75b2NNhtVKA/70XzjP/3NDspW/KxHQd0LU3AjK5JTbrjv8YBB8og3vBrM2Q5CkctafcXKDezv
 yVluZgTCvC7KkopoqtPByAACpFBmVPIWxDPYRDpp5z9gAaqaWYIbO65O5xsil7umIFz3WXVJlmZ
 eLPSr2pBqCVSRWm+An/pZ4YcUXIMJz1TumB026iwrDCytXRGOro9fI7+MjuKaTrDrL7tdq7T/Z7
 HqZLeMS6HDxjo/QHYpAC7DyampA+0pSN4+3TBGh4cNwVgsAFgRJ7RAs1vynUd2c23D73hCcoU0g
 5cCtqo2tTo9pLbtZ3ZXe3iJaNh8MzD8PfNkJdyx89jMFAswi/7QM5eHowJOd0A8vA1ThROoEKhY
 IafFaNap6cRxvtuKcPQ==
X-Proofpoint-GUID: m7J7ho3L0z4WQYZ_x_ndVTM5vpCjynQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130082
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

On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> Use freshly defined helper instead of checking the UBWC version
> directly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 7be31de3b525..f6bd906f2ac9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -743,7 +743,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>  	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
>  	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
>  	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
> -	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
> +	bool amsbc = qcom_ubwc_enable_amsbc(cfg);
>  	bool min_acc_len_64b;
>  	u8 uavflagprd_inv = 0;
>  	u32 hbb_hi = hbb >> 2;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 680f0b1803a1..63934d21c831 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -275,22 +275,22 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	u32 hbb, hbb_hi, hbb_lo, mode;
>  	u8 uavflagprd_inv = 2;
>  
> +	if (ubwc_version < UBWC_6_0)
> +		amsbc = qcom_ubwc_enable_amsbc(cfg);

You may have better sources, but it's possible AMSBC is not a thing (or
not configurable) on UBWC6 at all

Konrad
