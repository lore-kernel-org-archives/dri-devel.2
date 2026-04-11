Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEF8F3ED6B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 23:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A08D10E261;
	Sat, 11 Apr 2026 23:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAWx97eW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K2clLX/5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B32110E25C
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:55:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BNteUO3605092; Sat, 11 Apr 2026 23:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PBIRXWBFZirk+GRPYoxB9vII
 nfAQGm8M6f8aHtowUWY=; b=dAWx97eWMFMUR/XYHs0+Gz7/6SfB89MUsn/4iogc
 eMFsh0IKQek1KRjUzrYsblj8pweiFomStvuNx4kYZv2RVY1oISD/F+ww9i+KEY4t
 S5JssVz+B4HzdMsSGdMR0oT1kLe3MdQdpqO30Ky2ZcVhSEruTWfe2UQFH7dx1RJB
 ySGYwFibUT8bOBa+B+BmDyAF47JoGHfLzMIwecbR5+qiQtt+ErRDBPrSePQ0lv/7
 bQ4HSOMoemNycmr5iro5Ev3AkbVz765bN22uzHMzSkDOrd2x8FEc1em3F3gFmArN
 oSBJZ7UHJZ/F7QzsISwH7jB8Dde8bpQKxsnmulZVxJ47cg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jsgut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:55:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4661881eso36333571cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775951739; x=1776556539;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PBIRXWBFZirk+GRPYoxB9vIInfAQGm8M6f8aHtowUWY=;
 b=K2clLX/5A6Y4iay7si4jFUIVzlGa77OVmSrODqrPmwx/RvNERCYgb+R7ulr2XgpjV9
 LPgE/JKfsICPAvDnd3M/A2OqejarFbq+NiTtBVHWxkv6wYSVMvEb+2yHEsHdFMJ34Z2k
 NjRtpFDDRb4atgD2EXwsHIcVdQAeL82jOBndZu5DoQEI5qO5SI3BKobF4F8F4RX+80Mg
 ZPtCo9/aXkEo8pTPn4g5bEBkPWCzQ6QJOTeveYwBnNt5ZWQoTpRuZ0BOUdLQSHQ4O2+R
 Blt3qE0VFgQk/VeDZyW5ryevi73eYLyh+I8K6vKXpNmBzfWTJpfGxKZIwZ+unlt3Rd1r
 fS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775951739; x=1776556539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBIRXWBFZirk+GRPYoxB9vIInfAQGm8M6f8aHtowUWY=;
 b=NKUkZgHF1og0Y9WlzL1mXKrd+3EsrrgFl7cjQ/ecqY30ajeP0bNaCEWDEXuXycz5Ge
 ZazelikK6KUBC45PUsItDhBlZSs7we9bJ095uSUwqZqzS0qt/C3LiD3PrebI8ZBe6xSr
 Qj+6qe3RxfnmR+BkBuQuMl+41l0/AfffYbd0aMnezKWMBReu+zIbRpGiyzQfICuCnLcA
 EJnKc/3kxAHfH7JPYrXbGkQigFqiegSEykVVxyl5g/oTp0L5yrVijpDnUcjreRLELGeq
 4S+ZtvqvqIogvLoOyBeGa65vIEbIwiDZznMQtZNJUdrhFt6wutlnnvDYxnKS3WS+RoiK
 RigA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwilyGhYPGRR5MniBhP56rIiu4jzcmz8aWgRNbbzLX3jjMQCuzOPXDR3UNCcaUCNgX4vKfMCQErBg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXajuNeq3IZBNTslXNoaB0QtWdeMLIT8PdxCEKh1vPslyjv7IU
 Xige2x4+3BRAB40fb66ASOPJKsyBHxDDtb5bMxsaVnnvMBTCKUYEXJdDhHDY3jZbmDLOkhUQVvz
 N7n+ZDtf3hghYOrwGlAkgNqzcVoMEQio3BpQO7I1fCsQtnwetpcYNMkj9w5zpei0Q2cH26Tg=
X-Gm-Gg: AeBDievHmRMZOq3G4nur+KhqWSGQ1/bxfVMEVM8UbL+J94xg6cU/BwjYVjfY42YQCaI
 fj2i7F+YDXMlu97+9yYzFIwtb304JcrBtfxq8LpzCDQsopgbuAWVaFOTDcNXsb/9CVISLyrPmkE
 5AhuNFH2pybyYs7mVzl5pOL99Y/Lp2BtV7l/m4hxvS3gJwaIGoBPKh33gn5w6sICLnwzClmD7Xg
 hTVs41PRJj4rXdabs3DkpY+aXl7/ISUZaI6w+AwXr8XMrn/rOiJzSETIreFNP20xOJgIfvDB/aR
 8Gyf9FwQi9cO94qVkPH64UU5mo24x/mr4jwPc7J7mtmGRPlK0qA4vxUMDdBqPQq6qAEX7MQiVp/
 O+uHRk7b0JETUOEOe8Z8P84UiZT5HkuDLrydohXdmWk8e659ooNajc4kx9SS2KI575oOyxLtS6u
 7zklNaYXztHqqJ2b10GUAlWpXm9vFwQtvm3zc=
X-Received: by 2002:a05:622a:7287:b0:50d:69cb:d603 with SMTP id
 d75a77b69052e-50dd5bdb482mr87108071cf.47.1775951739585; 
 Sat, 11 Apr 2026 16:55:39 -0700 (PDT)
X-Received: by 2002:a05:622a:7287:b0:50d:69cb:d603 with SMTP id
 d75a77b69052e-50dd5bdb482mr87107861cf.47.1775951739109; 
 Sat, 11 Apr 2026 16:55:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8676csm1669389e87.17.2026.04.11.16.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 16:55:36 -0700 (PDT)
Date: Sun, 12 Apr 2026 02:55:33 +0300
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
Subject: Re: [PATCH v4 35/39] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
Message-ID: <lypjrzd3unyfqioiq6hk3cnk22ozmdn7agqrkmgwopejqmxwza@mbhyf5qlrhnh>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-35-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-35-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIxNiBTYWx0ZWRfX9fZjkqu1rudE
 XQ2GWl5kQt37gSaC5cYk7Uj7OIiWtDsegqfIj/HREb9kOiLJVgPeThn09xYdiPyIA0YPSQ9cyji
 EH7Jw1AMD1qrhYNjKLsDaC0xAaPb4zdtUmlK5XxAP/lMeiz/VMzVrXENVVDGDewmN8XGInZbK0H
 VI1GpIvPTqWEbM0Boz6XxzTP80E7rYQ5IoDDJ+xpYUD6GsM+fwSaKAEDFO2zYtRkuY8JgITl7zW
 tDxHq3el5LoIzEOSf77AkOhXCf6ZO4F58B5FW//C0P+hPWis+571oABNCz0FuEtrOiZNmHvyN7s
 N1xpMeCDnlWL5AnAe11ShRButCvFrAOmdILRyDk0elBuHgycrt1vzgC1nAEWS6tIwZAh5QEM0Af
 SLjsQ4uZdthDKcMcvhIugXp5mHjuv/f5e6VK9y6l/h1miQsOWVjntrKw11FWgwQlV1n5cbsJyvx
 7BV9ie3byPz2IKgl2xA==
X-Proofpoint-ORIG-GUID: Cf6IBsLoRthyuNv8Il8SUhCV7cKxvwU8
X-Proofpoint-GUID: Cf6IBsLoRthyuNv8Il8SUhCV7cKxvwU8
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69dadf7c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=mARqR03tnvVyoThnhWQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
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

On Fri, Apr 10, 2026 at 05:34:10PM +0800, Yongxing Mou wrote:
> Call drm_dp_mst_atomic_check() from msm_atomic_check() so MST-specific
> state, such as connector and topology changes, is validated as part of
> the atomic check.
> 
> Hook the MST helpers into atomic_commit_setup() and
> atomic_commit_tail() to support non-blocking atomic commits for
> DisplayPort MST, and ensure MST commits properly wait for dependencies.
> 
> For SST, non-blocking commits are already handled via commit_tail(),
> which waits for dependencies in the DRM core.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_atomic.c | 9 ++++++++-
>  drivers/gpu/drm/msm/msm_kms.c    | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 87a91148a731..ea064aa6d8fc 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -4,6 +4,7 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>  
> +#include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_vblank.h>
>  
> @@ -207,7 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>  	if (ret)
>  		return ret;
>  
> -	return drm_atomic_helper_check(dev, state);
> +	ret = drm_atomic_helper_check(dev, state);
> +	if (ret)
> +		return ret;
> +
> +	return drm_dp_mst_atomic_check(state);
>  }
>  
>  void msm_atomic_commit_tail(struct drm_atomic_state *state)
> @@ -221,6 +226,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>  
>  	trace_msm_atomic_commit_tail_start(async, crtc_mask);
>  
> +	drm_dp_mst_atomic_wait_for_dependencies(state);
> +
>  	kms->funcs->enable_commit(kms);
>  
>  	/*
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index e5d0ea629448..a8f5fbb3239d 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -10,6 +10,7 @@
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/sched/types.h>
>  
> +#include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_vblank.h>
> @@ -29,6 +30,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
>  
>  static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
>  	.atomic_commit_tail = msm_atomic_commit_tail,
> +	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,

I usually hate one-liners, but here I'd prefer to see this call as a
part of the msm_atomic.c

>  };
>  
>  static irqreturn_t msm_irq(int irq, void *arg)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
