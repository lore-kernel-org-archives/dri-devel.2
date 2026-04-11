Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA15F3ED5C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1019910E198;
	Sat, 11 Apr 2026 17:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/hecqtI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XpdRNdnM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293A510E198
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:59:15 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B7uZOb3336122
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qW70khYy2WNXiUNmnUcPyczZ
 0lMdb45il3ujjOXq68E=; b=L/hecqtIlYuP4E2gx46gyDCupz72cm0vlxvt51jk
 8Wq1pTP0PteCcAERXsN9Dr+6qImJ+moJW3cRSQjn75YeoO8wBLbFMNShled29VOJ
 pYTy4fIpLYcnHbzdPUcPg8jjnhGiFsZq2Qsxgt8UruM3hR5tZvd5YJ3FEyEk7T0s
 POKzSf2uoAv5NYjAUvSwObzvxJ2smTYtZFSROo8U5g99YpD4Xf1AN/iLUlIh3Q6U
 6cOxLGouH/uA6VF+Lr3bMWi4i02FIrIFQA85cU7HDP2LIoF86TQHVIGfI51R1fIq
 rYRtY0TAeU7VW+vQJYxxjQP3oL8lScFN+6oqNGT5ZJqp+g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbp8uc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:59:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b220c72bbso65652551cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775930353; x=1776535153;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qW70khYy2WNXiUNmnUcPyczZ0lMdb45il3ujjOXq68E=;
 b=XpdRNdnMwK0p2yneNV3RY6hUumxTMIozwN+g8p/Z2oJCn/SVi2t07lp5Vq+Wly2gT2
 Ugvve5AIx53RiBFIeUhOCcxmBldU4fcEFVTs/77VIwtQ57J0K+TshO+yYaG50E6mDzQQ
 V0Hv5++JOCl63O5rsBoWHgnwHz9JpsEYZ0gKfkHGEuaON4/Vc7SMQEsi8FKFyUvoFbFz
 89Ewhz68XYwNOfR1VjeESN9Vg4oNo/eOTHVz+9TY7Owyp+2URB6vxGs/yOy79n7iHKG7
 5b33oevQvABNgTyW1zQhjz2mPG2dqKM3jjHH4qRcwSgDBvQb4w8mulTFZPBH0gtRfXnM
 ABgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775930353; x=1776535153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qW70khYy2WNXiUNmnUcPyczZ0lMdb45il3ujjOXq68E=;
 b=KIWVcGjPL1clZlW9SsLNkEkXHctBRP0BdBbO0/01BKQ9S8/NmMFKZXe1P0NgZUhE7O
 /BayzXiLae7eUMByvZvdBzeLxokCStbrNcGAW0qKZp/nEaE2JXUKLCnilY72ZvjQniIr
 0zTf+qPyirDq6m/7pG8FXQw6QaNo4LJeINdVGLkQfIZA9LY3z21pfVLtMVeUedXisxK9
 /o9SrV/AEAmrYvjnbtwzSd2vQuFeNo1hKuqrGRPaZNtiu9Q1sCIfIBTMGRvwj3RPRTi5
 Ci0Jk7ZZWWRET1mIoI4ewd/uexaxXkK7tzSuNMxuo+WuMWbEBWu5t5s5udTZS2WVsTk5
 azEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0VnBkEEY7lNxCa0Wuo9Tl7Px51n/KbP/fBcMkOAvHdtS3+WF4y0x2iDRVCj3GDLK9+JlYcs+by5k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlGuIeEBdHre6xnAZQTWr1RW0bpQE/bBUZPzOw0UnAnVTBzFr+
 hN1sIQsaYEIeHzpN6haVRpg6nNVG9CQ2tvxZutuzUpMVvx/0KEOUlo/DQ1sOEODuJSkyRhtNFlB
 lLMxSUZVeyj4OJSEWofdixbLrz+xNDY3My0yGg7hEamtabv+KaCa91/KGXlzsCpr51z3i0cg=
X-Gm-Gg: AeBDievGE1yUvpJWv/66Jwff6wk+SZ7pGlA3g47Qhq754vHyNHoIvkq3/AH6VQGs3LI
 bToHWi5ylxxhnmqGMOd7pY9+1U0a8LxYWSGJD7huP6wbGTaO9WJfTr3ZglEX0+JCHAq99D7tfJS
 Kz6+PBnGKucs7I7lcCP2Ml4zAY38JcGgZEM3cVgKtDbEcX+SPcAuP5B5ptdaCJu0bwIkYwONrQ6
 n15vdg1m2/VAey6YJocp+rCljKHsjcl0PSSXpuuSwKFXm/g+AVD6CobWKqHEuM6tT6cdZxmwEjX
 wJiMp68pHEoGqUfwzAD00Wnw9OVeqm7eFqbuqqdI1fdeAcp2K/Q71pBhEc4hwYw5hUkUVuHaLgn
 pVv67gSS7KvJCHdLZkaDK2z+OXSnO6ygt96/Dcs06SRrusiLc6/o6jgqWrdqgnLjNXnlk34BKzA
 80TxzVK2VpPXqjKuLfr6x1E4dhUCLTTAMZArU=
X-Received: by 2002:a05:622a:488b:b0:509:14e2:89fb with SMTP id
 d75a77b69052e-50dd5b15ddemr114458201cf.7.1775930353536; 
 Sat, 11 Apr 2026 10:59:13 -0700 (PDT)
X-Received: by 2002:a05:622a:488b:b0:509:14e2:89fb with SMTP id
 d75a77b69052e-50dd5b15ddemr114457891cf.7.1775930353128; 
 Sat, 11 Apr 2026 10:59:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49298f1csm13098381fa.12.2026.04.11.10.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:59:11 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:59:09 +0300
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
Subject: Re: [PATCH v4 14/39] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <s32w4u44y4jhuk4c4qxsytat2pdiskzuvbozklhofpjh54r7pc@2i6vvbaen2ur>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-14-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-14-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69da8bf2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=BYW76SVRhHWKZf3cv-UA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: aVnZcURz04utjuDVdZxCVTaiSfGpgEbz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1OSBTYWx0ZWRfX1RJdqW+Ym+Xo
 92dKnAUEY0sw9GjpnJijD068nb+RIhJ1XG6cO2sQktoiFmJKK+d9C63aOupgFy+tSTGI80kCB/t
 Z2y5HtltBcrlyphNRp9Nxt9Y3Vu6OnQI8BpakOhPT2eFUfWSFc4KH7y12eLUIgAPKD+eApu1lJu
 lClDgT/SV2M1f7xOkXlrB/1lt0VD9Cw6kwP9u7aBwcVmsq+hoWz2EdXutgXRJAIYzxpEbh3rp0v
 GMMow9P6ufqL2E4ebYFGzQLckYx8bczq6c6OLw0p0V5iW/q8L9zmb/hJvg/7i++dVqnenqJOee7
 iF/PxU7rMaAeH2+Aa2d53SbdUkLObtXntjfw5+ntYFdpsmLRUtOPWAqTq420A7s71QpvrVrY6dj
 RYQm7QsizSDdHMC78EGE/wV6khStn5dC5+qo+MGCMmd2r/WLnzjs/8Gk8VrT9XKGBF9kmGva+uW
 d2XLSWKXxVAMAHXed1g==
X-Proofpoint-GUID: aVnZcURz04utjuDVdZxCVTaiSfGpgEbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110159
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

On Fri, Apr 10, 2026 at 05:33:49PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Introduce the `mst_streams` field in each DP controller descriptor to
> specify the number of supported MST streams. Most platforms support 2 or
> 4 MST streams, while platforms without MST support default to a single
> stream (`DEFAULT_STREAM_COUNT = 1`).

There is no such const anymore.

> 
> Also accounts for platforms with asymmetric stream support, e.g., DP0
> supporting 4 streams and DP1 supporting 2.

There is no need to mention it.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 20 +++++++++++++++++---
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 ++
>  drivers/gpu/drm/msm/dp/dp_display.c | 20 +++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  4 files changed, 39 insertions(+), 4 deletions(-)
> 
> @@ -2740,7 +2741,8 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  	if (rc)
>  		return rc;
>  
> -	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
> +	ctrl->num_pixel_clks = 0;
> +	for (i = DP_STREAM_0; i < max_stream; i++) {

Why? I think the code was fine with getting up to DP_STREAM_MAX clocks.
In fact, I'd rather use that instead of the hardcoded value for
determining how many streams can be there. Think of the old DTs which
didn't have extra stream clocks. We still need to support those.

>  		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
>  
>  		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
> @@ -2750,14 +2752,26 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  			DRM_DEBUG_DP("stream %d pixel clock not exist", i);
>  			break;
>  		}
> +
> +		ctrl->num_pixel_clks++;
>  	}
>  
>  	return 0;
>  }
>  
> @@ -1234,6 +1248,10 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>  	dp->msm_dp_display.is_edp =
>  		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
>  	dp->hpd_isr_status = 0;
> +	dp->max_stream = 1;
> +
> +	if (desc->mst_streams > 1)
> +		dp->max_stream = desc->mst_streams;

Here you can assign it from the DT resources.

>  
>  	mutex_init(&dp->plugged_lock);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index a5c6ed5b18e4..b0cfdf215970 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -26,6 +26,7 @@ struct msm_dp {
>  	bool psr_supported;
>  };
>  
> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
>  int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
>  bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
>  int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
