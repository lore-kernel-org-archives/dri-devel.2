Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF20F3ED5C
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D9E10E268;
	Sun, 12 Apr 2026 00:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACi638hn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eFit1sVM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1FC10E267
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:05:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BKeUxU1212272
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aqO0icBg/ZpRZ3dRKkqaa/3i
 zcSqhytJU77i4TeGTwQ=; b=ACi638hnetjYWr2XA1NYh44ll3Y+k89zSX/fZj3Y
 KActKdHr0DEfWzD5n0oIerQ13Ry5VChpHKVLHSZAJQteUHSVWgePCL7ZKNp+3+4I
 xf3q3ec388zUzdQBMR0+BLVaswkg3LSaGZ5lTRNI0Uu4/U6qW15v7l+wRXRLpyyn
 KBw+ln7gxRsNC0ef+slEl4YDiyoryyHYIwxLE6wimc1x04pNSIolIkuXUo48QWPk
 HSK1W89/B+r3EMTg4N4Z3IUJTRjcPyNK1Ffhn1Wjx50qaJxeU+Me9abXy8OI+cWb
 1u/BMJ2eHlHifCkP4/TvD2iUyM9y6D4NsxAInRqD/c6f4A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkshuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:05:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d9d52ad9aso13604131cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775952337; x=1776557137;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aqO0icBg/ZpRZ3dRKkqaa/3izcSqhytJU77i4TeGTwQ=;
 b=eFit1sVMTmLheqcOzFBAmAy1z17p5JyCzWsgRjFQek6zigNU7mmjOPtmiLp6u3XR6S
 SDnxI9OrkBVMGtNlLVd42rGrehNdUw7vQpN4pc6VZ0Yb8qSXvMxzS+ymeLxWhtWYPUQY
 9DwYcoi9WOxnlLRxgsYgbvqBT4nul3Zr3E2okzTrHYhDWAmRryEmsz4csgrjkauOzNai
 sxGIZ8VBF9+pm+U0VdrRd7A0U8C8FvRBee4cQszosC9MXd3zEQV2NEB7aXXmbQ2ZMArA
 hcvIIZMVlXjYtUh/aY/g30HRAoT1Tx3LWYs/dppPwdIcQ+dD+xtUuVY+HM85B4JO2mNb
 4MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775952337; x=1776557137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqO0icBg/ZpRZ3dRKkqaa/3izcSqhytJU77i4TeGTwQ=;
 b=AP4CyN682enxixfyMHaEddhGJSRPORIXMapkV6WDMhEG8nF65pAlen6QHme4VZL7i3
 pJLJ1wX3lWAAFi8/OswJzUU67Gr59Pg+in/+KRlDgOyK0SRBEyafbfB/rFqQDwSGNMdj
 BC7zxrHNZHA7l4eIlrfeH5AhhPzl+1zhJE71zmjZfVvCTR39aZO5dCtk97N7C0iQutkZ
 yMcvqmcVfhJO1d7qHq5nGRvdYaCSAWOoLAcobnTyLNHkducapTq9ijAuGY2j4WWrrecG
 HQ6phWgWczMOtBIxMcMDoU/w6Yz6gvfpxHZ/snPiDRkMIP80cuMQpWRBDPpuMTodbzx1
 No9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZjyc43j2GvdLj2QqCzJojJkaxNDWE8GcgaNRLruNf6zIv1JuSfr3cp6Wx+5gPiCKp9Q8eQx9Q0rI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5Vs320fRAil8l0QvXayxLZjO+kiSp2BQVHEIBWLyO0/iB+AYL
 yf1Jz3korPwworpNAe+XkBh41xhMn2a0nsvrGXwNEMa2FJkNWPmuoIkEUthSOLt5DnYiRGgojo9
 525s86Kkn64JBk5tVyxdgAFT27fBZEkEYJ20Qli32E3QG+rtpfdY5mL51rOz3yc0HXvHidXs=
X-Gm-Gg: AeBDieumYEAf9hQ0g0oJJfSa52GR/KpHd8ZboYEHOGsSmws6ccwnOvIbOei1p1ZCSFi
 j7B4eMBQBQhiNFxsRnCSxfZaT4X1lwreZZAn+96E4afw/zcO8ovZ5p/njlm8xegCIMklZuZqRVq
 kXmmE4ivH8O8FfSjHHVTJkN9p4WuvZLMRFH6OgN9lAN5AFCRFHL59Hx7cw78cm+1yiMKhq/Bh3d
 x26x75ZrByxAr8J616IOulmug4tDDC3PBsi2bMSienXI1OVcmEsQw49A8ZVYbUAFqUlRujnVl9N
 PQDZd5d1HJbwAFTtXsEcAGdH21k2Iryr9M+ZKMS8Yl/93u7ycPOA8FhdiBgdFgPAo4v3LB+cao0
 7qDIh6W0pluOCjVlhxF3da2eURXu8z0ZlwGXyGDxST/9iH84quwei38PgH4wDGnyOzXf+GrkNqK
 02t+MUHmqSmFbXpADrWECPiZnsWCLBhWJwL54=
X-Received: by 2002:a05:622a:5883:b0:50d:e45a:a3fb with SMTP id
 d75a77b69052e-50de45ab108mr62360621cf.51.1775952337074; 
 Sat, 11 Apr 2026 17:05:37 -0700 (PDT)
X-Received: by 2002:a05:622a:5883:b0:50d:e45a:a3fb with SMTP id
 d75a77b69052e-50de45ab108mr62360231cf.51.1775952336603; 
 Sat, 11 Apr 2026 17:05:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee9342csm1644069e87.31.2026.04.11.17.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:05:35 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:05:33 +0300
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
Subject: Re: [PATCH v4 25/39] drm/msm/dp: pass panel to display
 enable/disable helpers
Message-ID: <7dxlzm5hm2uq7ai56lmvzyjntn4kprdg5bp6qr77cqetku4hgu@iom7kqnfn4eo>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-25-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-25-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dae1d1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=LgG4ybvrVFF0rsqfD0EA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIyMSBTYWx0ZWRfX7RHN/EXUs01P
 UsLYt7bxA38swzlwzvIA8wI7QFx2JXQWL4yD7ANHCaU1lKIfW5DkbyubpG/jJOCojJUgjD7lyWh
 lQZfQOw1CkbbI7JJvGTQTqYZTZ1eGDyTOTlzTGCjJV+LypRjndgBm4ONoT48AoasZZbpZFrXhjr
 G2RuGdTRBcTeisZgFoeTDaLy5l8mjhhMBMOvPqM81yKDI8qJOOwAT/i6ypAP4qT4AxXzxAIcHab
 M1AejQbxzwLObv2QJotjLqZ5vEDYjiMdfc5kdItBJLzw04cx4Y/ld48KgeyciLWPMnS6YcPJvzz
 b5G2eT9EoGgoVNlOGo6q4OR+OnKCVsU6v8UkKt5KVwM2h5vOWdIBJ74kh4X2nBeWLjVn5/AneDk
 3SMjHEaskrF3dTmkiXm/zsNcWBlXBrwDtwXFoCyJS/LZjvfV+hGh6WAwJCMeT3bnALAr6wc5UJl
 wkBKkkZnSvuaELXtKrA==
X-Proofpoint-ORIG-GUID: 6w5KXHK5yaBJ06cT8uZ1JLoxBuNfyA_c
X-Proofpoint-GUID: 6w5KXHK5yaBJ06cT8uZ1JLoxBuNfyA_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110221
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

On Fri, Apr 10, 2026 at 05:34:00PM +0800, Yongxing Mou wrote:
> Pass struct msm_dp_panel to the display enable/disable helpers to make
> them easier to reuse for MST stream handling.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7b3b9160e005..88a078e53dc1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -668,7 +668,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>  	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
>  }
>  
> -static int msm_dp_display_enable(struct msm_dp_display_private *dp)
> +static int msm_dp_display_enable(struct msm_dp_display_private *dp,
> +				 struct msm_dp_panel *msm_dp_panel)

Where is it being used?

>  {
>  	int rc = 0;
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> @@ -725,20 +726,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
>  	msm_dp_display->audio_enabled = false;
>  }
>  
> -static int msm_dp_display_disable(struct msm_dp_display_private *dp)
> +static int msm_dp_display_disable(struct msm_dp_display_private *dp,
> +				  struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	if (!msm_dp_display->power_on)
>  		return 0;
>  
> -	msm_dp_panel_disable_vsc_sdp(dp->panel);
> +	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>  
> -	msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
> +	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
>  
>  	/* dongle is still connected but sinks are disconnected */
>  	if (dp->link->sink_count == 0)
> -		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> +		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
>  
>  	msm_dp_ctrl_off_link(dp->ctrl);
>  
> @@ -1529,14 +1531,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  
>  	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);
>  
> -	rc = msm_dp_display_enable(dp);
> +	rc = msm_dp_display_enable(dp, dp->panel);
>  	if (rc)
>  		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
>  
>  	rc = msm_dp_display_post_enable(msm_dp_display);
>  	if (rc) {
>  		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
> -		msm_dp_display_disable(dp);
> +		msm_dp_display_disable(dp, dp->panel);
>  	}
>  
>  	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
> @@ -1573,7 +1575,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
>  
>  	msm_dp_display_audio_notify_disable(msm_dp_display);
>  
> -	msm_dp_display_disable(msm_dp_display);
> +	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
>  
>  	msm_dp_display_unprepare(msm_dp_display);
>  }
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
