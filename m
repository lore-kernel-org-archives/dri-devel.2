Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF20F3ED5B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 17:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3699C10E0BE;
	Sat, 11 Apr 2026 17:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fciAvYDa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICu0Ivxw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA5910E0BE
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:55:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BGMKYB167791
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3EpLe1bigpIp0uweD8x8d34d
 Vgkxj8tPhHlBc6q0pWk=; b=fciAvYDa7yQzIDZ2+Zp5mCc/KNSHyDKycCAxLDBe
 L5Q2eN36CNfdmc34UyPTmEwT12uUCTswrMF+7yjirIPNgJ3EX+A0rYhNdalrgCIU
 Q5WA8C2DABt6FvvEWbARIK6f22Lg7zf4FrLvNJZW99q038OB4GwdA98nVumlZw7O
 CJ0XcL968e/t5KGkVoKSljTlr8Erxxkv0CRFPkG7sE28AAY3AwlfXPkQp6S4JtGX
 pQ2pYA8z+YTnTxwb73PyIHC71IzepDWxZWMJXbyC5FH7kcfEfDYQEsusXgNXq9B7
 IVP9V8B/+AS25bGCnXB0y7pdHwH7CPnmVfPHm15OrgJklg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbp8u8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:55:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4076dc16so50418641cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775930156; x=1776534956;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3EpLe1bigpIp0uweD8x8d34dVgkxj8tPhHlBc6q0pWk=;
 b=ICu0IvxwaBb1cUjBr9z3DQ3yaybVHQvxUeJANO1gn4Cqh+b7A51X3Ki9XXohEcf+MK
 vAFku5z3Y2CUv1ct2N/r2cKuWnZV4R2npociTHkp+R91yvx63hkMa2hOAeobgh64plm9
 W9KyJgyqyc1H/RiAY7sro7T7/RzRGvTm+UFanE8p7INPNPDDWq3PyuuuwBClZS67R9lh
 L9VXZoyM/pqaBSQUf4UUnvvM/w05AH0rlqtdV/wJIHnB9Cs6J38FGIgSGNLsxxgrtPZZ
 SxP4GJs98cnPFPFwcQMCoNpf5NWFVP9i/0F3eKH0BvtE+jO3OHAdODbkeBc5zrQxluWt
 I7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775930156; x=1776534956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EpLe1bigpIp0uweD8x8d34dVgkxj8tPhHlBc6q0pWk=;
 b=A7FqdNpJ3a4oYpFvPNsU91FmP9E8OH/IbOWVPgkr2yk3EsHHdjuzqpePRLLRzGcOIF
 TzYCbpR2Lt0BDdQuYGYqqDfou9fNswk4H7m3Ein//eD9TbQ2ATumEYGjR4/csIrJa8xr
 W3uSjIxH/pAJ/Ni6T0zWf8R+LMzswjGpBCR2/pIg4rzqTv/c61FKMbuPJBVVGrKGhX0w
 5sExJDmoLgup4gcIJ/Vd89oVLaHenC7CIImGJt2B29NwMfoiMyrZ8fFmI5FwiSfqGJT0
 v6deekFUpt/HOZAkr/7Pj2BrHmJP79Yd547b/OkQnYntxOoCisxe+t98W6bsGNs/g12T
 eL8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz2AbB+bOA+0NAa97iimZFvo6bWhJ82XPEShd+vaXyv1VxWRR0PxuN2jxPML93hph0z0Mz3GIHL+A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwG1XO8s/wEkCa8haF0yRebixvIUBQ9sfVLuxg7lr8HACr4pYQe
 knRz8Rnx2HakPSmHCIyj6cy2onGMiI2d4FojAmBDNamHgMoG3rVWfsv1ZTQSjaBqQZDeK5W4Tvl
 kvW1ER/r69ZliG+ikzOHfOy2bFmHuovU8wTe/3IVacEIisKtWhP/iHvXmDcpCckMos4hjl0U=
X-Gm-Gg: AeBDiev/YnPi1nMnQKKxRe8MN1ruWCGwrGUsO1PO6Ig+s+zt9trZYgLJlafeM7/p7oi
 mW9RcMf6B9k70CwTYr9eAC0gSw1A6Hxa3crTxIDNJOzaCwpBvQb7d9LIkJ5ERvEbtUdvFz/wn6u
 KMsRbCnyNWMFDRcK4AUWe31oXrWSiUs5PlYUfcSpeulmd88SvUPjwLWqtwZXcUFKAU72c1wdQsb
 nG2HRJaqYXFXKAP15qc6zbP5jZhkedvgBlvKSolYT1jCHMNZmw27ic3H/JgCeeDJszKBRsfYIRz
 I4X4V5csIkaDaqcp8eJBxIQRTCB41Mn4YadmzxUWjxgqtBX9FmLlRpFMpKNXOEF7rcqrQ8KAE3h
 lkM9EnHSy6/zbd220MwZzYhrV9oVEjLnewRXDBzlM32Et7xdOiHkKdQMwTBQ6vv+MHMGTEgyWKI
 S6wKqu0Xaq7eqghUHGFyMg6QoR4v3EyRQfOlI=
X-Received: by 2002:a05:622a:51:b0:50b:37d5:67a4 with SMTP id
 d75a77b69052e-50dd5c01968mr116910351cf.27.1775930155778; 
 Sat, 11 Apr 2026 10:55:55 -0700 (PDT)
X-Received: by 2002:a05:622a:51:b0:50b:37d5:67a4 with SMTP id
 d75a77b69052e-50dd5c01968mr116910121cf.27.1775930155220; 
 Sat, 11 Apr 2026 10:55:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeefbb1csm1497199e87.63.2026.04.11.10.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 10:55:54 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:55:52 +0300
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
Subject: Re: [PATCH v4 13/39] drm/msm/dp: introduce stream_id for each DP panel
Message-ID: <nzouhzeoimf32nwbm2qjecopildvmlay4t4xxshufsjaydmwlc@bnfom377r5b2>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69da8b2f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=lDrsiWV98Tgi0JVLTm0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jUARU-s_TcjNDO1k9bdkoHdUDEph82dg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1OSBTYWx0ZWRfX6vbCd058Rzsd
 hv0kF7MCG/Zgm2KOdXjKUp8KOl4UNAlgSQhY/VO+4FyVn+Jy5Jo/s9iPXe//smjycQZD23L2Xo3
 pMuq52mwdRVMWQIT0AaaOGESF1a64lnY80iAoY8HSV5C3wo0IynNDevVXljrrsH9t9CsewRpJ84
 rc9tRHiMrQWhGoQlaCtsgF/JtD4bxXT0WLC8P7UZNcpRp3DFiUyAeoVemNhM9fWT5At75Xk5M1p
 9+TKnr2d/tG0qhdLyL7lAjYMlYx+PZOn5uMHdYsfAZAXb/IC/+5s2Xm+qBDBgs2EabX02YSJBH1
 31ofWNmdlOEP3B0LrK0upRpLX2qJ7IjhJGnXd4j6mErOUUEDD29CKh4cyx3b3vx/MsVZq/Kv6RG
 q+HB4wwu0vdYyb6s8MsuEJxWUBg3wpDW1QDrdnJ6PWQE1drVT7R8966b7jffV3Al19125sB7+eh
 BQ5bUgDKEH4UahZMUXw==
X-Proofpoint-GUID: jUARU-s_TcjNDO1k9bdkoHdUDEph82dg
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

On Fri, Apr 10, 2026 at 05:33:48PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, each DP controller can handle multiple streams.
> There shall be one dp_panel for each stream but the dp_display
> object shall be shared among them. To represent this abstraction,
> create a stream_id for each DP panel which shall be set by the
> MST stream. For SST, default this to stream 0.
> 
> Use the stream ID to control the pixel clock of that respective
> stream by extending the clock handles and state tracking of the
> DP pixel clock to an array of max supported streams. The maximum
> streams currently is 4.

Please mention that panels are going to be dynamically assigned to
actual stream IDs.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++--------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
>  5 files changed, 71 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 120ec00884e5..fb6396727628 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -127,7 +127,7 @@ struct msm_dp_ctrl_private {
>  	unsigned int num_link_clks;
>  	struct clk_bulk_data *link_clks;
>  
> -	struct clk *pixel_clk;
> +	struct clk *pixel_clk[DP_STREAM_MAX];
>  
>  	union phy_configure_opts phy_opts;
>  
> @@ -139,7 +139,7 @@ struct msm_dp_ctrl_private {
>  
>  	bool core_clks_on;
>  	bool link_clks_on;
> -	bool stream_clks_on;
> +	bool stream_clks_on[DP_STREAM_MAX];
>  };
>  
>  static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> @@ -2176,39 +2176,40 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>  	return success;
>  }
>  
> -static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate,
> +				    enum msm_dp_stream_id stream_id)
>  {
>  	int ret;
>  
> -	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	ret = clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
>  	if (ret) {
>  		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
>  		return ret;
>  	}
>  
> -	if (ctrl->stream_clks_on) {
> +	if (ctrl->stream_clks_on[stream_id]) {
>  		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
>  	} else {
> -		ret = clk_prepare_enable(ctrl->pixel_clk);
> +		ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
>  		if (ret) {
>  			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
>  			return ret;
>  		}
> -		ctrl->stream_clks_on = true;
> +		ctrl->stream_clks_on[stream_id] = true;
>  	}
>  
>  	return ret;
>  }
>  
> -void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
> +void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
>  
>  	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>  
> -	if (ctrl->stream_clks_on) {
> -		clk_disable_unprepare(ctrl->pixel_clk);
> -		ctrl->stream_clks_on = false;
> +	if (ctrl->stream_clks_on[stream_id]) {
> +		clk_disable_unprepare(ctrl->pixel_clk[stream_id]);
> +		ctrl->stream_clks_on[stream_id] = false;
>  	}
>  }
>  
> @@ -2228,7 +2229,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>  	 * running. Add the global reset just before disabling the
>  	 * link clocks and core clocks.
>  	 */
> -	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
> +	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);

Why are we using ctrl->panel again here for the stream-related
functions? Didn't you got rid of its usage few patches ago?

>  	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
>  
>  	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
> @@ -2238,7 +2239,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>  	}
>  
>  	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
> -	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
> +	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, ctrl->panel->stream_id);

And here...

>  
>  	msm_dp_ctrl_send_phy_test_pattern(ctrl);
>  
> @@ -1451,6 +1469,8 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0);

DP_STREAM_0

> +
>  	rc = msm_dp_display_enable(dp);
>  	if (rc)
>  		DRM_ERROR("DP display enable failed, rc=%d\n", rc);

-- 
With best wishes
Dmitry
