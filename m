Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D407EFC72D6
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 18:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C30110E061;
	Sun, 22 Mar 2026 18:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AfJK85Sn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hkgtVi5B";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8695210E105
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 18:35:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62M8In6k3107414
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 18:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2whQYxYAX/vh03tBzskqkZaS
 QYQOGqrmyV5jVACuwOQ=; b=AfJK85SnNB3K5U+auyc2KNB+nT15vTgA7QaWfzg5
 vITwwXww3qQaBEOd+MXt4d+GdLb4yIy4+SJlU6nxQeMxHHV25YFteiRFdsP/TL+u
 /l45C+vBLdRFXLLE2wUVl4LkY/C3JA/GNHqsXmdMeo25aYg0LwzrcTJjxeWMsGn5
 z3LSI1lgOZm1eKcCLFV9oPKuHxxrh9jtyVWc4WZJ5YmBw54dp4mrOwpw5OZEayr6
 AD6k6rGdz1PR12xq7kEWJicqzJ9xP2NK+TWUagsQ2hvdp4wLYRKQ/RfYIQQer+j6
 vzCaj6YA05T6XGg8BNgn+W3/lyz5U4PNJLRK4sBbSBpLYQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jwvju8s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 18:35:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5090cc6a7d2so196343791cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774204514; x=1774809314;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2whQYxYAX/vh03tBzskqkZaSQYQOGqrmyV5jVACuwOQ=;
 b=hkgtVi5BVxBtjtXq85A1MwCo845huAIU8Drz1h8tBjcTatdnTzFB4wFe5ElWMsFc4D
 irlqeTaoh3eOHke6vQ+EfgtGnL1Hi2Q2cDJCjXMNblsBNFqgZKU5MF2rI1EB1rVo5tzq
 KZR3RKU28uPnIWIlbzo2y/wcJPxntTdoQ6Aeq4H8gbVwcc0EXI24TNExQlKO/t4nzwCm
 oXD0y0vVkrhCbsG2iX4UzOn4FHn54zXLx3D4T1BmV2FQDeNIp8f224hQy6X39XFQ9M/T
 ib+JGYIYiJs5D0O3UMjpX+CanicsBzZ2tHmTWz7XTYXJ1Tsm+CeRKqKsCghfSwoxE2bS
 IeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774204514; x=1774809314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2whQYxYAX/vh03tBzskqkZaSQYQOGqrmyV5jVACuwOQ=;
 b=ZVF9ad9nR1YlwQj4HM2GVz31uXADSVg7liaGf3afma0OlyOZ9OjPzrF1++in670Bci
 cXX5Oy8R5yIFeSnkQHIvHwEQnCwyEJQVuLFbkfKT319yzwFJdm6bfyHKpqFBM+Q5qEBg
 MyWzbKXsoGIg1jeHS6JICHfiHr1XroIhZD/UM8fKCsyuXS8Ic3Vn/cWcHgCt6xzWfkr0
 BLnaESZ8jeu8cahwI9o3L7d1FVSp14/Jvfc/jVUwKnXJ1Ar1Fh1FwQBodtiHyb5s7iYA
 x8V1OXSSSkdqZkLM5y0xXJ8CZ5iPSUXpTeEWGujnDCgaU6FhTKg+ihlJlADX9KAVnCwD
 y3vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXufKFNqzwQHEuN70pZGflKlzqFzIL85CtxqP/IphrNCwiyl8Ek/nieIJmOWZ6aW+/yN4iIJoFEQA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwitqabLoz0jb6+aidouHeQ+tp5x9U/F97hClAocPpBh56dsAXj
 Q7fUCzO67/OYCr6vInbXz2L+KlSzSZLQENjYjCXobWwjJtscLy0NVKw84wXrOPk02PuKZpwubV9
 DrSptQLho+Rk0xah/3pzO6A3BY4kfsZQlaPVYsLTXW5MWEAclrV6NY4G4o1YlgQ7DF3lnRXE=
X-Gm-Gg: ATEYQzwzsILJmEWUN6vvCjMJ4uUq7fgnQJ5clSiRMBigQRiBUjT817Z9P4liJ0YlGi5
 nCIvkZ6c65CVYbnbzqmM/ot38iFg5/XJD9CnvAHlsy5I2AImpK493d9zWEjxA0HJ1SpLEajp+K4
 JRkUajDD+K1lr+Vlkuy9oAZKNCbH5PjxZG47Aio6k+3HhQ5W5uyTQa8i1C5fpDhA28UCUXXvl89
 M/4klr98mNTTPvmTfR3GlHojRhfsVbEd+GPgOXWo4azHsQTt99CSL0+5IjgUdEQWiaExnD+r0Cm
 PcaR3XIm+ufaAb5pUUsS2gXM2qb3SdqisvW4yIynVEWRalp+GfUd1JfyRtca7aBGTqNfH1AIlg6
 BJfxWYPB2Ph8RTRHiXfTosMtg7B/N97Drq4ZNVOPq1PtAqCk5BPJIy6C6xB9UfgAYXdu+K14fyO
 GPdJQjH2G6TnDxdd7VfRKm/eg6IxTRB9GMyd8=
X-Received: by 2002:ac8:5a8b:0:b0:50b:5243:d679 with SMTP id
 d75a77b69052e-50b5243d749mr60019471cf.46.1774204513649; 
 Sun, 22 Mar 2026 11:35:13 -0700 (PDT)
X-Received: by 2002:ac8:5a8b:0:b0:50b:5243:d679 with SMTP id
 d75a77b69052e-50b5243d749mr60018991cf.46.1774204513130; 
 Sun, 22 Mar 2026 11:35:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2851ac54fsm1971244e87.29.2026.03.22.11.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 11:35:11 -0700 (PDT)
Date: Sun, 22 Mar 2026 20:35:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] drm/msm/dpu: calculate data_width like downstream
Message-ID: <5fu22a3qcg3zn4qq2bt3j5teyzeihzitompenvdb3y72qa2tuh@vvvz5nrlfgtf>
References: <20260322-fix-data-width-calc-v1-1-128880f5a067@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322-fix-data-width-calc-v1-1-128880f5a067@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDE2MSBTYWx0ZWRfX53reRWaNKJir
 eIAzw8FgvlHZe8fgdkVt/vogKobAVFJ0bIZe8RKzxZFGDmPPC0SD2j2lWSiIBS2cfRBD19nr/Co
 5JN2/kZWj7wUdAbDWyY5GuIK3kszLod2+luP8HGMycQ3pCPI5NmC/zdBg4H53JrA+QsEHaBK/aR
 IXrZYiHQHWl3txF7qMCi2MHptbNIAEeoCgSdxLQj+0F5u0msWg8cwXBvGoYqkuHSnRTlTumWoYI
 B8M5EPxYtBw2a3YKDhLKqvZky8pj6Kk5sOyv4OeUPxfm+FyGI0HTz9tJpcbogUTVQCWMKTHC4wt
 V/c3HXgosVX/XZturOS/MBWSWpKHS47GX8cpne8oytFbLgKnqEon/AgjN1VM4YhnwqEvMfZzGo5
 dDef9uAqFOknUJsZbLVo5dgt/SI8s5LnzraPKVotHBHu5NVT8C3xD3kYdnIXyp7y7RH7iB+iq9E
 rsWLS5fZl3kgiXgp3kQ==
X-Authority-Analysis: v=2.4 cv=bcdmkePB c=1 sm=1 tr=0 ts=69c03662 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=polRaJZFt_3Xv9GgdtEA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: N9gaWPtWFYsnsFtIQISWoUOU047MV7o2
X-Proofpoint-GUID: N9gaWPtWFYsnsFtIQISWoUOU047MV7o2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603220161
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

On Sun, Mar 22, 2026 at 02:31:13PM +0000, Alexander Koskovich wrote:
> Derive INTF data_width from dce_bytes_per_line rather than
> timing->width when DSC is enabled. Use DIV_ROUND_UP to avoid
> rounding errors.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
> This patch changes the data_width calculation to match downstream,
> and avoids needing to change the divisor for timing->width to /24.
> 
> However I am not sure if this is a correct approach, but at least
> with this I get the same values for data_width as downstream now:
> 
> data_width w/ no widebus
> before: 288
> after: 360
> 
> data_with w/ widebus
> before: 144
> after: 180
> 
> This was tested with the BOE BF068MWM-TD0 on the Nothing Phone (3a),
> it would be greatly appreciated if someone from QCOM could weigh in
> on if this is a correct approach.
> 
> Tested with kmscube and getting 120FPS, also note that this was
> tested with a few other changes:
> 
> (drm/msm/dsi: fix hdisplay calculation when programming dsi registers)

This is a part of msm-fixes

> (drm/msm/dsi: fix pclk rate calculation for bonded dsi)

This is a part of msm-fixes

> (drm/msm/dsi: fix bits_per_pclk)
> (drm/msm/dsi: fix hdisplay calculation for CMD mode panel)

Okay, let's pick these two. I assume we've had enough of testing. I hope
Marijn can also r-b those.

> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  2 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 23 +++++++++++++++++-----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  1 +
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index 0ba777bda253..ba810f26ea30 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -10,6 +10,7 @@
>  #include "dpu_formats.h"
>  #include "dpu_trace.h"
>  #include "disp/msm_disp_snapshot.h"
> +#include "msm_dsc_helper.h"
>  
>  #include <drm/display/drm_dsc_helper.h>
>  #include <drm/drm_managed.h>
> @@ -136,6 +137,7 @@ static void drm_mode_to_intf_timing_params(
>  		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
>  				(dsc->bits_per_component * 3);
>  		timing->xres = timing->width;
> +		timing->dce_bytes_per_line = msm_dsc_get_bytes_per_line(dsc);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 7e620f590984..de6b5b0f70c4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -173,13 +173,26 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *intf,
>  	data_width = p->width;
>  
>  	/*
> -	 * If widebus is enabled, data is valid for only half the active window
> -	 * since the data rate is doubled in this mode. But for the compression
> -	 * mode in DP case, the p->width is already adjusted in
> -	 * drm_mode_to_intf_timing_params()

Please keep the DP comment. We need to fix the assymmetry between DSI
and DP, but that needs DP DSC support first.


With that in place, the patch LGTM.

> +	 * If widebus is disabled:
> +	 * For uncompressed stream, the data is valid for the entire active
> +	 * window period.
> +	 * For compressed stream, data is valid for a shorter time period
> +	 * inside the active window depending on the compression ratio.
> +	 *
> +	 * If widebus is enabled:
> +	 * For uncompressed stream, data is valid for only half the active
> +	 * window, since the data rate is doubled in this mode.
> +	 * For compressed stream, data validity window needs to be adjusted for
> +	 * compression ratio and then further halved.
>  	 */
> -	if (p->wide_bus_en && !dp_intf)
> +	if (p->compression_en && !dp_intf) {
> +		if (p->wide_bus_en)
> +			data_width = DIV_ROUND_UP(p->dce_bytes_per_line, 6);
> +		else
> +			data_width = DIV_ROUND_UP(p->dce_bytes_per_line, 3);

I was concerned about DPU < 5.0, but data_width is only used for
HCTL-related timings, which means DPU 5.0+. I'll look at restructuring
the code.

> +	} else if (p->wide_bus_en && !dp_intf) {
>  		data_width = p->width >> 1;
> +	}
>  
>  	/* TODO: handle DSC+DP case, we only handle DSC+DSI case so far */
>  	if (p->compression_en && !dp_intf &&
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index f6ef2c21b66d..badd26305fc9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -35,6 +35,7 @@ struct dpu_hw_intf_timing_params {
>  
>  	bool wide_bus_en;
>  	bool compression_en;
> +	u32 dce_bytes_per_line;
>  };
>  
>  struct dpu_hw_intf_prog_fetch {
> 
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260322-fix-data-width-calc-c44287df08b8
> 
> Best regards,
> -- 
> Alexander Koskovich <akoskovich@pm.me>
> 
> 

-- 
With best wishes
Dmitry
