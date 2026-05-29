Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B11ECD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB6110FE1B;
	Fri, 29 May 2026 12:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EmNsjEuW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YZ05X9dD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74DB10FE1B
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:11:37 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TBHNtm1248248
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=myZURdkrXDIz2L+zV0UOKR91
 eBxVLnWLIAPahE6PCKY=; b=EmNsjEuWnz8ABrbiQBBvdeoCtk8jEwcyhoGBycIa
 SW/sYVJsNtHW/wOHfEIXw6ctLZ4+h7lg9dOAytI/GtAfHX28fORHJW39HBxGZLNm
 MuddKd/a96vfqBtzBi7nUVREF/QCiAv4rtN1FdGE6cNub4UUJbQRJjOPAaINQeIB
 34EMauxDWj5DaFVWEhQU5TqxThHPnIM2r5Vr7pYWYvxgjDlT3RHPxg7OmfZ6arZL
 VD9scxa+T4L3VgaQ7DLOhJUEvUn/9+N1X0QecvH4aoiPm8O6Wiw+2qGLN2jEnEOF
 fx1FZK0zLey17AciRi4oNElFutY7pBffLCGFJX94R/PbIg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj1mur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:11:36 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-575252f9c56so9976408e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780056696; x=1780661496;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=myZURdkrXDIz2L+zV0UOKR91eBxVLnWLIAPahE6PCKY=;
 b=YZ05X9dD1AKMuYBm7VUhkPYjyvlQnASJqXyEShK7x2SV/tJ5ru375/D3N+5GH4oZCL
 j1LB7PGguveTTnC0lJf+82LT9sytsXMWI+e3GDBPI6lCmjcP8z51mZ1/EzUAVTDmZXVV
 ePTsJ7A3+VZJ2u86NvuiG2deMrSZkoGw7Gwu6fO7zz38xFcg+LnGfyfvkOguM+tL5R/+
 6sg253O00SI7+W8EjUznFccrG5wu3dMJc9XKINjgMhuAJCrT8/wS14wCzJimzsTbecXI
 nrWJKBEBPbTlmmc2hcTC4cbMdg6xg3tqVCcQCzVtGjx3fvtYpi3KlNrbl28kVCvtKsdU
 256Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780056696; x=1780661496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myZURdkrXDIz2L+zV0UOKR91eBxVLnWLIAPahE6PCKY=;
 b=iLvTf6C/y+6dSgxnAx5D38xWvOkL5U25NXfZFWL9gcxrhCLROUCdXIMy51h2XCWga3
 SOXlURttHXftPkNtI4+cGgFnJFHq3sQG3XnsATgQ8kMwaU6xIYwrQwsxxCgJaUH3KuWN
 E7qs+tB0kq7lrhmGW8X8464O3wnBT9PNRAYcv0C9Ij421rIP7fr36uZLFzgyzZ9aFTE4
 7B7QJiCb9qh3vDk51FgJ7YTsWhINLkTLKak7G+jsw1IgjKv+jYSAuwplaju5N0KolEbG
 neKu/9+l4ODMYTs7FY+v1FMUQp6kWIcnpuWCylTddaDVOOlPOKG+LahaRwvDXbCdZlNm
 sYsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ehd/2UgE+k+7NmbgdeDaZd02nNv/bA/QFt0QdU+qN8XKokAV4LgtR+PYiJ1+xqb+jxIzsRqxke5I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzIkcBmzLgQStHIBHJKlYYZWc+SpX2mxfS26Qqz32irsRG82wX
 aORH16LLApyuYOngoBDHmxPkPOXSCbkJUJt77nwruH0+95lOoLNNhtCzs7qqAK3RAIF6JX2+BuZ
 lZiaz2lPNkx6Te8Dec7RTYVagX1kpGrtnRsW9C4cM6M5MdnaI5rnQUj01SO13Tf+Kth2GMvs=
X-Gm-Gg: Acq92OEYGdZqXywYpgzawW7w+AzHkci7vf0/uFeJWZH2tf911h1MOntOkCGUehyOBNj
 Q/V2HJmt4eJfSTeolbj+naVhF1mWXxD+UyEVpMotZX2HkJRytb/OKZd4vh8kFadytpCDBy9ktYx
 EOZlwfDq1vSXY5OrIit1lvTyFmXxWNXXDEYJ24Zh88XKukdZ9IkVcAGhwd+NR4BxAPtcPb1AX/0
 Ufbm3tgfnnIAcahpQVlTaY11e9IQ35AvZpPSdjtSR6MyztqoBmamdbXdFkw381NEY6Fwl20xUq7
 2y/MYA7lEHP4m2jPwjRzfZW0J/O9xo8r7LdZbXFuJN0dFijjWevVdH87g9IdpbUxbhaZOYWQJTU
 r956lynpGvcZIloW/GpegjyNms4UmaNzHx6fgdJ7iaC1oFNqBqn3Sv+j91EPPURHcdMfn1t9hPH
 inCA2gi/PowD2kXN4SPu2o1l2fuWzvClcHJ48gu0/LUpuyBQ==
X-Received: by 2002:a05:6122:3390:b0:575:3b34:28b6 with SMTP id
 71dfb90a1353d-599f7e54afcmr883162e0c.11.1780056696065; 
 Fri, 29 May 2026 05:11:36 -0700 (PDT)
X-Received: by 2002:a05:6122:3390:b0:575:3b34:28b6 with SMTP id
 71dfb90a1353d-599f7e54afcmr883143e0c.11.1780056695578; 
 Fri, 29 May 2026 05:11:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5ba625fasm225880e87.64.2026.05.29.05.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:11:34 -0700 (PDT)
Date: Fri, 29 May 2026 15:11:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/15] drm/msm/dp: move mode setup into
 msm_dp_panel_init_panel_info()
Message-ID: <6g662olfylifrsx5dkifvz3dizs4xsum6gq62dwq5gu2ghgcbe@ouwaghilkkza>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
 <20260528-dp_mstclean-v5-3-a9221c1f1f3b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-dp_mstclean-v5-3-a9221c1f1f3b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyMiBTYWx0ZWRfX9DCjQz6qDGls
 flBW0OfLaXT7kDAVe1PyKnMaQ321LHWKvAV+WExwlLvzdZhTU+t5yuj6oGjQ24+rjiC9YQH44NO
 LyUCLtrhud3j/tuY+VN70YPlHCHeOOk7WOWylisJyuqlT96gV5BcLr6aMB8bSA3tOR+QXdZ22Do
 V9aXinzqKxDmH4dtW6IeoP6d8QwY1Ucxvu6X9W4HqnsdAKsH966dkLXsuGcdsIHqEG6EeEPu1O3
 U/TZbSgyvDJ5bYvw9SUE7RXWJETqTJrmeQ7NGa4613wq628U8uCDl4sP0fm1OtPWmybqlSiAPO8
 TQaNJHVnZ4L88Oz4gAPomprZUOR34zNtVF0R+MClM6w4wc5k+WnfkfgFkY6WQ2r9LnVOuKmtcwC
 Eh82hLyMwaghn9uGFYLuiwa4SaFLBAr9qFgzvgJsLxeXUQ1qDoAQIxXfWBhliR4WNemxDVKcDlM
 d4mjhXWJBCS2LHHFa1A==
X-Proofpoint-ORIG-GUID: GWu8JnWhXm0d_GxLMrpEBLsJGB6ak9Ke
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a198278 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=czEj8ZBfGQkZxxwQui4A:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: GWu8JnWhXm0d_GxLMrpEBLsJGB6ak9Ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290122
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

On Thu, May 28, 2026 at 06:40:24PM +0800, Yongxing Mou wrote:
> The display layer directly assigns msm_dp_panel mode fields (bpp,
> sync polarity, yuv420 flag) instead of letting the panel manage its
> own state. Pass adjusted_mode and bpp as parameters to
> msm_dp_panel_init_panel_info() and move the assignments inside it.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 11 +----------
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 18 +++++++++++++++---
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  4 +++-
>  3 files changed, 19 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
