Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F9F3ED5C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 19:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4F610E235;
	Sat, 11 Apr 2026 19:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pu1+1z9a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kuczjTOd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1B610E234
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:26:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B485bW1201549
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=E3IcyDvJ1i17Lur9ph/QOElg
 Ara1tTa7mfLQQ9nB/dg=; b=Pu1+1z9aL8b3lpAvgh09k2u/i2B9Fe/vxdR1KnEP
 AFovKI/USbqsdyIARr/OGiXOIjj+3f0XqFpIgNmONx4lv3DOkxQZJ5S15Dj341WE
 duZNfU6o8ff0AdQhcmimPnnjamYmkDVKDycbYpuTj6Up4XgheVwbnqeadDXmPnj2
 65pwN4wr6WfXCWrz5Y1qezC8UeJS8jw/0r43WF1zrrpCp3/jlyZ+ar5x7XUyrDGJ
 LcUa5qjKclHuO1BCclTKQZ8+y0nclmtDwK3c1FJuMeoR9GkkQDNPosis02dWvC5u
 eKnQU0x/MZ41uIiaqPWqHLXrjhDOg3WP5C73k8k7b3J2Mg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0js8g2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:26:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d826ed6f9so71632721cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775935614; x=1776540414;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E3IcyDvJ1i17Lur9ph/QOElgAra1tTa7mfLQQ9nB/dg=;
 b=kuczjTOdv4j21BXvl54QV3T+0NpGbUfW1nNGBGgR03hvKpa806jI/S6vfuth6bJA7u
 bw6oLqbHUoAfEEc4PKrQMnzflEAZPAS3+0dDJRtfqt6Vd6xTWa5RRsNhraVR8x6zWa8f
 I9xyqbFQGO6eGfhNeH7i7sfiHz1+kZ6hVCOG1wzmwKxtxvaRBf1umHGz1BuPgftL0os8
 VAFLBSnez8LQKAbn7oRnpPoN+Bm8Q4LT48nftdEzfH0kn7DOy3xMMW9jED3R7XvGNob7
 jZFXUtTihUCxNiMCjGVPPs2r8zy2N0zVtpTFlIukkhp2XSzEA7VolCvpvmU5F4mge9H+
 exSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775935614; x=1776540414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3IcyDvJ1i17Lur9ph/QOElgAra1tTa7mfLQQ9nB/dg=;
 b=AY4YIISJD5THBBQF7WfaXQpneXVy6EuoaSGLC+vtTvCkthTeo57RZ9LN/G5Ad1Ydmg
 q655tTp8KrpComMNgHKYI0FdzMAG+czeu3GlCHUvxLtH+vFBdLlqL83SAWGaPaEVANUL
 emNve5TsmEpDo6uhd5Cw1hq58zRof2YjVimHa0jPe7E1elzyJwaRJdQS8wiBC8yiRpUU
 OzPLoK0LH7AUKg3cCgc1W5S35Bo5+UFlXsbt7HPNWRa/dtkB8z2HBgKUv8gssP7Jwg78
 JseDJ8Exvg4XPx0khpE4/UNdDO58fTyUNF3lN5rBxQYkaBM5lqabHedBLp17o+V91BUH
 ae5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxNxrvs8EDfhbvjYsVukPxWNn2aSPKVD7Gtqunwqq/9JSEyiJbubqg8DZSr7+7iIVWgxl4tbl5E1U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyo3ioFmIMKgLIptURE3umGOLu6wUNBjt23HimhzfSU+ltFWzTg
 FCdeLIjChIE9/E5jgnwYz0BNfRcuDeymp7GGBVevlefNbXomP94TNm7aQRdLPSla7utfcFiBFEq
 P93bcxnayrp3i9fsUm2fZMzFhpgr9QbL6RTLHFkNVjX6z4snD1tuSoX5h1XNgvNiW/oH+83E=
X-Gm-Gg: AeBDieucW/GUzCBT8WEtHOmvdDbDGEDIvvuDo+uNNuR9xiolGtonWmh3XVPSBOSdMA9
 f5t9oABPUih/JJu4idjCcD171Q2A31VqMkjLKWuQLd6dkRDOc7I2HTogcDdkDgjTNFXIvNR0dmt
 cNZy8/H/Ab7Yk2MjnoJMvAgLGdoBTmYnLpm8NDt3utRLXTGgr8hIMO70glSy76qrNw0WuhG26J9
 SF4S4hwpNomHMus+O6dKFFkihysxK+Xsx+DzK6dH5v6IJzJWzqTlcI6e/F/nv7XmeKvexpUST98
 w8Yy/hB9l4BM5HNFE+Tzp7mAR2tMu9vmP+2sy4hfUH3kXG+cU411ZSkK3vP9GNtCb+B+a3Fal59
 VMG25iqfjyk+TqmfYathmVV4rVFDpr1RYLgJymGqhBMesTrdYIbJtiO+6qKllZsWsQ8NNaEnqK1
 BBaSiC8SeCxb3rJKR6Tha7XpTzT0VVFhjrlCM=
X-Received: by 2002:a05:622a:150:b0:509:5c6f:c0e with SMTP id
 d75a77b69052e-50dc1b85089mr154121921cf.37.1775935613931; 
 Sat, 11 Apr 2026 12:26:53 -0700 (PDT)
X-Received: by 2002:a05:622a:150:b0:509:5c6f:c0e with SMTP id
 d75a77b69052e-50dc1b85089mr154121641cf.37.1775935613469; 
 Sat, 11 Apr 2026 12:26:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e492710ccsm14248581fa.7.2026.04.11.12.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 12:26:52 -0700 (PDT)
Date: Sat, 11 Apr 2026 22:26:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 39/39] drm/msm/dp: Add MST stream support for
 supported DP controllers
Message-ID: <lo66frdojl4l244h4zvo3g7p6saonytsf2mej7cvuwp6qc3ejr@pjsy577o2e4d>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-39-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-39-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE3NCBTYWx0ZWRfX9Ab7FV58wV2V
 R9EaYVG6ZNrfufbAQAYkjXBFCG4Tc+49PmTqV0Eq4FpkpF7Pv1O1Iz/9e743T3V3vpZnQtVoLDY
 ZJU9GrDa5r0h3spYTl4GuNNdCyKKxZY1Y5ZLBZhkexhbDOld48w7royI/NsxdVAeX28hhk1Vvdc
 LX68PffGIIM+LubAvH45NP/mFiVvwEgvvJnHw4mgsXP2B5xc3GL2yQ61/N3rcfWtItRcUcuYeEg
 m5jDgl9CDQayfh+L+vRAzu8rbzc/p65uMh5o1q9LGaok9zs87ry/bWR2Bwsa4zIM8HLmUBZDK9H
 Frs1lAqNCRaZPfKNP1qUkbVXQUxHyhJkEp4IHUFnuf7cpShSdSBVGbfoQS2fNPSDCIFpwfp+8d4
 SwvmXE51hlCNGryD2m+gvdZkgMx3ZhHMT6MHZmNQR5lZDZflAvr7ituBqcFqOYShtcwgHzfrOwm
 ZRdxTM6hLkjgkSSE48Q==
X-Proofpoint-ORIG-GUID: paMK0_PLrgSGbjQ9R2Y3XuzUsQNqKQDr
X-Proofpoint-GUID: paMK0_PLrgSGbjQ9R2Y3XuzUsQNqKQDr
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69daa07e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=J3SxvE2sJgW6avChXnAA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110174
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

On Fri, Apr 10, 2026 at 05:34:14PM +0800, Yongxing Mou wrote:
> Enables MST support for MSM DP controllers that support it, allowing each
> controller to handle up to two or four DisplayPort streams. All necessary
> MST support code was already implemented in the previous series of patches.

As I wrote earlier, we have this information in the DT. Please drop.

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index ca89e20b7563..f632b4f64ccc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -107,16 +107,21 @@ struct msm_dp_desc {
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_glymur[] = {
> -	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> -	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> -	{ .io_start = 0x0af64000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
> +	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
> +	{ .io_start = 0x0af64000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
>  	{ .io_start = 0x0af6c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>  	{}
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
> -	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> -	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 4},
> +	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .mst_streams = 2},
>  	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>  	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>  	{}
> @@ -133,38 +138,47 @@ static const struct msm_dp_desc msm_dp_desc_sc7180[] = {
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sc7280[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
>  	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>  	{}
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sc8180x[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
>  	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
>  	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
>  	{}
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sc8280xp[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> -	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2},
> +	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .mst_streams = 2},
>  	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
>  	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
> -	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> -	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x22090000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2},
> +	{ .io_start = 0x22098000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .mst_streams = 2},
>  	{ .io_start = 0x2209a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
>  	{ .io_start = 0x220a0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>  	{}
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sm8650[] = {
> -	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2 },
>  	{}
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
> -	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> -	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .mst_streams = 2},
> +	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .mst_streams = 2},
>  	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
>  	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>  	{}
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
