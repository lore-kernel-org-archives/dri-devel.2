Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE49F3ED5B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2DA10E281;
	Sat, 11 Apr 2026 17:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jumy6wPi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NxXjkZek";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2107910E281
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:38:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4BQ99653122
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yyRH0qM1t0DffykVpcZOI/IC
 2eDaHpipeVNrbq3xmqI=; b=Jumy6wPit6pM+3mTeJT7udZIbhWGwTL+J4fz7da1
 CbyHoo2AM08l2HwR0tTakPdsv5CawA0v9Y123GHeVfWelwtZH1uk1FeyLPuyW7Gd
 9EONHX1odR2urMwyuXd8x5SfJAbewd+SDfdMV+KTe9O71jn4ilOGVfWzHrUqb71M
 A1GfbVKtkRJnQnerqg+nvN4OKIRldP4GaBz9M+fgVV80cw290DNr6mz1pTd/FR2n
 A+HJIL+Z5+Qctqcru6hW2jJr3AXG8C+4IOvTdd5b90Nb8DN41ObP4DvNaniPxXYt
 tINg/xE9DJMvDiyrArE8A98N6ynH9OOavs5/V8LnRfSSaw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2b93xf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:38:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d68dbb77bso21674041cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775929107; x=1776533907;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yyRH0qM1t0DffykVpcZOI/IC2eDaHpipeVNrbq3xmqI=;
 b=NxXjkZekNp2mBpQoUrRRwC6ZUEm/5POjolk/x9J0/0H+zHcr2kwgwcHTjhwkvVnS8g
 FsJKA1NQExKMCxRHZjScllGAKAQHu/HwxufR/M8A5kpG5l2punBFo9iQSMmLH/HInJVN
 BS5ndrbuOD1nE1XWK24dM8URU5vRhH1RMksUpxHK3VXHwkQgCIK+m2OFYVtsd4mX80Qd
 Xy28RxKoyjMJqPpWY6xqoEvKvWewx96rma104MyQIryOuQuhuNuVvehr3IiaESAoyRbl
 gKwC+/+Mhnncj+h2Ty9PxUOi0/MQUg32kIYA8XBaYlxt9q1uJwfgY8aZ4v37TM9eGoQ8
 pidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775929107; x=1776533907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyRH0qM1t0DffykVpcZOI/IC2eDaHpipeVNrbq3xmqI=;
 b=Jp4uY+5UbVNwp9rwm5KYUZ1WzEDvQZXaVhyKqFHIah9SFawXHCPeX4i1ibcTwpaRGv
 EPJjQgqBociePiDnV0je1xICiaB1/AHSzXV1rtVjSr5msGQbDWiMDyFGIrGjD5TA3jN0
 rL9fK6cKm5wAh8GZ4tT9SoLdKiIJM4JGwloPGc8+ggVUmgguOpzzfsbj7oRvBuNkMmt0
 aeJgB5yFIkZd8YVSxW3tl+aE5MLgcYeP049+qCV7FW/aiL+9pNg3UNpZHrB+qgZJ+K5/
 dHV/6Mt6dyYfzFTFUGIT6s+nyFggRSmTUs7D5KbAzxMdLSiHMOBB53qHJk/o+4FYME6R
 fwzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqopz2fnoJYhdVXr6O5+GONk5HtJVOSFVHgTGqgDqPx+LbzI7CH+9AGnggdnYKAMoMMBw+9LDajlQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNcHgxma4U3zIvTUhXA1TEnAXEBVxmrmec0iJstQXm7Vxr2RyZ
 CPn0tjf3OCW9/SA4D8pwsUlo4w6K7Ur3C7jBVnY+jl19A9DTh4DMqTSUXYGCdCQgx+My43/LJ/L
 fmHYbfc+xv8wwMUCHAT0yx+s9XjvDS8+gKCdDF6Scyjpp0GeLEmziD3YqENbiub1HakMU58I=
X-Gm-Gg: AeBDievuhEMpZAlNLjAUwpcxHI2VOnObCvwkKF7+a96FRrrE10vqidgcaxDgpeY80Jd
 9ozKSk9IQX5wyJiVzt29WMIlqfLd5UCD5yKffoAwTn0Bw9Cjks7rFi4Z6BDPMHFvGHV1igQmz65
 yK0e8mnbx/gQW2Z+NzSqljC4dvuHbw0FHFnmcUFTOpSQ8NE+WGfdeG3FFH7tAs976lozqkuH7UF
 pKAQVHC/JqG7MTyXSyBnsfM8zOnjOMBTqPcoYk86bq3+4j/goXupuIr4HNsPQBRTE+4DzfDawcR
 n5tMc55YTKnvLWHmYWycYQCVTSKQusQPRmUAJ0JqsWH3uZATa+TWAkuDec+dsjXwDFm/iv96X01
 5A3gJwQz5LvA3o+R7gLTFkYfQYq/KS26dnRAlNIbUiZ1C0eyIGY7kPk9w97mCOE26t/P9iTJq+P
 rq3nu9qnDXRMCSL4A/BWcU5aKK/bGLb+rjQpc=
X-Received: by 2002:ac8:7d96:0:b0:50d:82bc:d2b4 with SMTP id
 d75a77b69052e-50dd5b3f2ecmr127481151cf.25.1775929107504; 
 Sat, 11 Apr 2026 10:38:27 -0700 (PDT)
X-Received: by 2002:ac8:7d96:0:b0:50d:82bc:d2b4 with SMTP id
 d75a77b69052e-50dd5b3f2ecmr127480691cf.25.1775929106900; 
 Sat, 11 Apr 2026 10:38:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee1315sm1509744e87.53.2026.04.11.10.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:38:25 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:38:24 +0300
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
Subject: Re: [PATCH v4 08/39] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <oughavmmvruhnehdpa4e3ptigcb4wndugxazhoeg2yed7ubvgi@aa7wtrz5s6mx>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-8-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-8-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NCBTYWx0ZWRfX8hZbNytFe918
 nfJcYvgXzxGRYCwxRtHE2BzIWKKVx8do2hBGH3fBC1S/RTJx4A/WvQgio50PB/ARGhXJMQecld1
 MHhor7NIZGqZUjXSg5QpTFe8U1fzStz8xL6MGSyVceTuai6SvZalLF+KFenZjsOsAsnOs0qbjIt
 J9uE+axgx9voMYBlJClzlqz5dCBFZz2CCSu2FmEwIzZtHulAZgNH5Bn/qZRd/W5mwlfYifd9Aqj
 PscfacdxGOm6agvzngQtE1Id7OfrsVqyOjv7DfqbJWZU3ewlqMd0H/St9vf1DXn4bJ930LOQvND
 EmFHcrLLtTvOsh0JgT1Vj1wyBNFVgykILYPMPnDWShIz/Zg6kEn8IQ27bB6Zn5Fda8mCtcHkNX1
 C7sQC9Qal5tBX8h2t3uzxmQl4L+VTVQ7ts83d/9aZ6EYY7nIyvzeg+ba2+mvN3UIiEkPEtn74kr
 PMNfP7Y6Pgc57tbe3GQ==
X-Proofpoint-GUID: 0SRWxoyHiSSrZfjQPS_CTIKTsuF3EmjU
X-Proofpoint-ORIG-GUID: 0SRWxoyHiSSrZfjQPS_CTIKTsuF3EmjU
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69da8714 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=hUxYLGb64pCA3aMMaCQA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110154
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

On Fri, Apr 10, 2026 at 05:33:43PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Currently, the dp_ctrl stream APIs operate on their own dp_panel
> which is stored inside the dp_ctrl's private struct. However with MST,
> the stored panel represents the fixed link and not the sinks which
> are hotplugged. Allow the stream related APIs to work on the panel
> which is passed to them rather than the stored one. For SST cases,
> this shall continue to use the stored dp_panel.

Hmm. Why? Can't we get rid of it (in the followup patch)?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index cd58968d4e14..d0eed8c7df45 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -477,13 +477,14 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
>  	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
>  }
>  
> -static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
> +static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
> +						struct msm_dp_panel *msm_dp_panel)
>  {
> -	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
> +	msm_dp_ctrl_config_ctrl_streams(ctrl, msm_dp_panel);
>  
> -	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
> +	msm_dp_ctrl_config_misc1_misc0(ctrl, msm_dp_panel);
>  
> -	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
> +	msm_dp_panel_timing_cfg(msm_dp_panel, ctrl->msm_dp_ctrl.wide_bus_en);
>  }
>  
>  /*
> @@ -2523,7 +2524,7 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
>  	return ret;
>  }
>  
> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
>  {
>  	int ret = 0;
>  	bool mainlink_ready = false;
> @@ -2536,10 +2537,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>  
> -	pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
> +	pixel_rate_orig = msm_dp_panel->msm_dp_mode.drm_mode.clock;
>  	pixel_rate = pixel_rate_orig;
>  
> -	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
> +	if (msm_dp_ctrl->wide_bus_en || msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>  		pixel_rate >>= 1;
>  
>  	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
> @@ -2571,14 +2572,14 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
>  	msm_dp_setup_peripheral_flush(ctrl);
>  	msm_dp_ctrl_config_ctrl_link(ctrl);
>  
> -	msm_dp_ctrl_configure_source_params(ctrl);
> +	msm_dp_ctrl_configure_source_params(ctrl, msm_dp_panel);
>  
>  	msm_dp_ctrl_config_msa(ctrl,
>  		ctrl->link->link_params.rate,
>  		pixel_rate_orig,
> -		ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420);
> +		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420);
>  
> -	msm_dp_panel_clear_dsc_dto(ctrl->panel);
> +	msm_dp_panel_clear_dsc_dto(msm_dp_panel);
>  
>  	msm_dp_ctrl_setup_tr_unit(ctrl);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 5d615f50d13b..32196e97cbe9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -17,7 +17,7 @@ struct msm_dp_ctrl {
>  struct phy;
>  
>  int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>  void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 58c46d5ab4d8..1bf1335712bc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -666,7 +666,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
>  		return 0;
>  	}
>  
> -	rc = msm_dp_ctrl_on_stream(dp->ctrl);
> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
>  	if (!rc)
>  		msm_dp_display->power_on = true;
>  
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
