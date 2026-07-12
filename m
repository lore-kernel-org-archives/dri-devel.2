Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE19C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B406A10E2CF;
	Sun, 12 Jul 2026 11:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQpo3+5f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwUdcYGo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C6710E2C9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:23:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAcqPj2288843
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 al+c4HA1/mkq1/e+JdUUTQZ0NNKkY/oSTg09WKvnFvA=; b=EQpo3+5fW/2kK3o4
 9BhYKb9qyXxnaiBNf2roa5NqkgGe0L9xnCQd6ihJ5uvhgkxLacpXOUHsOOZ/3M+V
 3rWDP17Au+Akj1WAE4bTVJ8AkrfQuoYGe+/syqFU/naxmSvV6fB/tr6Xr1ia+PJ2
 tsnGMXFsQknfivk09gV+D5GDvyHsKB65qoOtvgfI4Q4622UotE3sCjINKHNX5FKq
 JJyaDT3YUicfvh/NvHxXzZbH/Sg/t7VyiMOmQJvcMNFm81oZtt6QIDc9Be0JzA23
 N8sa7zZBBjuqvyrvZUIWaPKSGKOatrRCtHWTxP4zFgGEmXgKeCP569r3+6MvYzmL
 mRpQJw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe912pk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:23:53 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-738e5b5ef68so910400137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783855433; x=1784460233;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=al+c4HA1/mkq1/e+JdUUTQZ0NNKkY/oSTg09WKvnFvA=;
 b=ZwUdcYGok63X4rSkNFXte91G0nn2G6YgWMaTmQKx4Hv2Z3bCe410SfkUpK3xfTf025
 FigzAVgN4YJMQO9S3ndM7HUmGuhEu0Tj9d5m8tY8EGlM9u7EUPK/3VCHqDAMdjVlncIu
 6IbOEQ1n2uAiN1HolNqUBr/HChf9dpa3prZG5lDqsKS/JfbdAaQ1yqLZjemsjk7qyTdU
 V42eaN/SC7Eg6GLjMCc9Oe5SUh7suYWqidM3gVlIGTcsgyY7a7PJuyBY55wAkeQpnUq5
 GrN8q7Wxl0WD3ZoqIEJPUSkzMQ6YM446YrEDyV2LDWFkVlRiZgkhU1k5+znY8cNZBCdk
 GsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783855433; x=1784460233;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=al+c4HA1/mkq1/e+JdUUTQZ0NNKkY/oSTg09WKvnFvA=;
 b=XeL2ysnWaa/pOVWO5al1NraFrzZvU3Li+Uq5X7IgfljkmnLJSF4PU5zt63qxWgOUaL
 peENsDoQ4uBV87N2SNFOQE0WZpUOAKZ/ZIxiGUo41RuOWpJP2mkS4BPjYVcKi/6hmTfE
 BZfSFgbXf8Cw/sVH705slDTQEQNtUGu5sxLVtwDlzIK5rBjTr9f3iaop5pb2FC7MxcLz
 4KSwZEoX8KYYdAJb0SxhsmUn74S8rzYw1Nsg8aABGZOnAUquJeFfCYnZ41jmc1YfxvDX
 7wiOwyMmpIhCorqqDCDHZ9pnxafjnmyDQvorNxB9geaZ9SLpgIquOaD3wnN/OAgfTFY6
 FM1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqipk5ed/yCfuAcI+jZtlovDBA3NYsM0IszBF+eo2pIAFFNfHF7GYypJYACImyYCZ4Msxn/SrJ7L8E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOpOnOmX0bGdHk/IOCEbzgInyHg7E6m1Xkkib0oOg30yebzb7w
 39r/JmvCQBvobchvmpHXa6RAOB7Jw17GueZfOKmAUDCMNfy+ooO7R51FZyxivmvUmXANhpl/Tnn
 RpJDVociwLheBY54mk5vRSYbpZs6g8xxEpU+8eHrZaJhmrIv2u6tGTC1iK/8v0GQ9taKnh8M=
X-Gm-Gg: AfdE7ckmPhyGiond+gt2VCZq4avCtqhhIsZXZw7tYr+QxJlFoy9ZVRPBud56AheCHzg
 0NL84IfHo7hJ0AatJeMV9I1SA7Wty9k2YpTJHuH8iHa1Z+RnMcWFSfnmE2l9Hnqw3HxnGDVU6/2
 3NAT82QSuUqIMvj4EAsqrO1J1h9oFRdwplX81cYSdNK75Jt2YyniQlpA5q8boXrFZtdqihBQ/DU
 7dCfbjoGm5oAxI25Dqmqs+hDBY2/Ll2uOKBvOat2MD8rvO0TusCkSRfRtcWjjPX7qqls+pRYb+p
 GinSfed662VPUSMFR0+LfxxkChqkK/LW9tAucCK5fjFq0YgTyrtX9LPFHy7PANluV2ccvs1+zvU
 rf2wka+MpySXmGvN/1AXl5ORVgMGB4QDLrzYiUQdbmTDMtqyw7qBgd18TxdMvLCFndJ47qdD/Il
 doM21/7TVUfdIEcPueBoYZuaAA
X-Received: by 2002:a05:6122:3790:b0:5bf:9f77:477a with SMTP id
 71dfb90a1353d-5bfbf18ee3fmr2933463e0c.2.1783855432631; 
 Sun, 12 Jul 2026 04:23:52 -0700 (PDT)
X-Received: by 2002:a05:6122:3790:b0:5bf:9f77:477a with SMTP id
 71dfb90a1353d-5bfbf18ee3fmr2933447e0c.2.1783855432152; 
 Sun, 12 Jul 2026 04:23:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c849180f3sm19740161fa.4.2026.07.12.04.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 04:23:49 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:23:46 +0300
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
Subject: Re: [PATCH RESEND v5 03/25] drm/msm/dp: Add support for programming
 p1/p2/p3 register blocks
Message-ID: <fvbqltre4qqdf3ss6huv3wz2exd6lin46pykp7ualvr6att4og@4ti6htrtcnlm>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-3-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629-msm-dp-mst-v5-3-2ed6aee1867a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a537949 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=uj3fcQ3Jo-9mkThLgboA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExOSBTYWx0ZWRfXysjcUCdMMQWQ
 He4oXp6ZiMEq+LP+sH8/C8Jcdyh3VhEsR646/QREfjLuvgShBRQ8kNKmJ6SrZBj6oNpu2ZypNXP
 gaKfjJaziLyLvFujg5UuJWFSMaV7a7E=
X-Proofpoint-GUID: IzIAHwA0_CPT2e9hlujdDpROnPm4Hz5m
X-Proofpoint-ORIG-GUID: IzIAHwA0_CPT2e9hlujdDpROnPm4Hz5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExOSBTYWx0ZWRfXx8w0xZ7eIlNl
 SY0sjPhEGiuqRRsw17YxfDRd+fuuClPbw59qtMvzV/ae7OjLfMBm4Boxiz+MVCLcZ32u3RdCYNA
 LTvtiGF0cwqaNfshzufZdAvDSG0WRww21Z0Bd/iI65GGi90+8E7S0XY2y0nKTpjDw9Zl5Ch/Ofv
 CdJsRen1sWcmj2SLYuFA6xp6aPUmT099B9qwr77I1gO4P1G6CfQUcZcSdQ0m1V1Sa3j2b2ZbEg8
 RGFRRWsh8YIxEZkYV7lxFSuSLN6f09Ft492incb3BBoM2MCF461N8lzEJLyr8jzeBkXm2AmLg1c
 w77ZjJfV7/Qsw0CwZGzebzcCjZGxvQmsDCCzVEYIH4usU3NMcq7VF1BznVuUMxKWpH2+KunB8eU
 uohGu4CC/pfdly6gwykj13EOjE0fix58klxcRNbKIs48+hS/aK0pqVmYJ0+yMLm4tL9ClzWEG81
 JJ8Nz0YDntUKzxk1yxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120119
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

On Mon, Jun 29, 2026 at 10:14:24PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add support for additional pixel register blocks (p1, p2, p3) to enable
> 4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
> and msm_dp_write_pn for pixel register programming. All pixel clocks
> share the same register layout but use different base addresses.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 40 +++++++++++++-----
>  drivers/gpu/drm/msm/dp/dp_panel.c   | 82 ++++++++++++++++++-------------------
>  drivers/gpu/drm/msm/dp/dp_panel.h   |  2 +-
>  3 files changed, 71 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 9cd243411e44..74f481a18164 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -85,8 +85,8 @@ struct msm_dp_display_private {
>  	void __iomem *link_base;
>  	size_t link_len;
>  
> -	void __iomem *p0_base;
> -	size_t p0_len;
> +	void __iomem *pixel_base[DP_STREAM_MAX];
> +	size_t pixel_len;
>  
>  	int max_stream;
>  };
> @@ -564,7 +564,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  		goto error_link;
>  	}
>  
> -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
> +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
>  	if (IS_ERR(dp->panel)) {
>  		rc = PTR_ERR(dp->panel);
>  		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
> @@ -850,8 +850,14 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>  				    msm_dp_display->aux_base, "dp_aux");
>  	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
>  				    msm_dp_display->link_base, "dp_link");
> -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
> -				    msm_dp_display->p0_base, "dp_p0");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[0], "dp_p0");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[1], "dp_p1");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[2], "dp_p2");
> +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +				    msm_dp_display->pixel_base[3], "dp_p3");

It should be:
  for int i = 0; i < DP_STREAM_MAX; i++)

Also, you've just added a NULL pointer exception in the crash handler.
Check for the address being non-zero before adding it to the snapshots.

>  }
>  
>  void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
> @@ -1131,6 +1137,7 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
>  static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  {
>  	struct platform_device *pdev = display->msm_dp_display.pdev;
> +	int i;
>  
>  	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
>  	if (IS_ERR(display->ahb_base))
> @@ -1160,8 +1167,8 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  		display->aux_len = DP_DEFAULT_AUX_SIZE;
>  		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
>  		display->link_len = DP_DEFAULT_LINK_SIZE;
> -		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
> -		display->p0_len = DP_DEFAULT_P0_SIZE;
> +		display->pixel_base[0] = display->ahb_base + DP_DEFAULT_P0_OFFSET;
> +		display->pixel_len = DP_DEFAULT_P0_SIZE;
>  
>  		return 0;
>  	}
> @@ -1172,10 +1179,21 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  		return PTR_ERR(display->link_base);
>  	}
>  
> -	display->p0_base = msm_dp_ioremap(pdev, 3, &display->p0_len);
> -	if (IS_ERR(display->p0_base)) {
> -		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
> -		return PTR_ERR(display->p0_base);
> +	display->pixel_base[0] = msm_dp_ioremap(pdev, 3, &display->pixel_len);
> +	if (IS_ERR(display->pixel_base[0])) {
> +		DRM_ERROR("unable to remap p0 region: %pe\n", display->pixel_base[0]);
> +		return PTR_ERR(display->pixel_base[0]);
> +	}
> +
> +	for (i = DP_STREAM_1; i < DP_STREAM_MAX; i++) {
> +		/* pixels clk reg index start from 3*/
> +		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
> +		if (IS_ERR(display->pixel_base[i])) {
> +			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
> +				     display->pixel_base[i]);
> +			display->pixel_base[i] = NULL;
> +			break;

Here we should differentiate between the address being not present in
DT (which should be ignored) and any other errors.

> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 745ee6976897..238920c45261 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -25,7 +25,7 @@ struct msm_dp_panel_private {
>  	struct drm_dp_aux *aux;
>  	struct msm_dp_link *link;
>  	void __iomem *link_base;
> -	void __iomem *p0_base;
> +	void __iomem *pixel_base;
>  	bool panel_on;
>  };
>  
> @@ -44,24 +44,24 @@ static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
>  	writel(data, panel->link_base + offset);
>  }
>  
> -static inline void msm_dp_write_p0(struct msm_dp_panel_private *panel,
> -			       u32 offset, u32 data)
> +static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
> +				   u32 offset, u32 data)
>  {
>  	/*
>  	 * To make sure interface reg writes happens before any other operation,
>  	 * this function uses writel() instread of writel_relaxed()
>  	 */
> -	writel(data, panel->p0_base + offset);
> +	writel(data, panel->pixel_base + offset);
>  }
>  
> -static inline u32 msm_dp_read_p0(struct msm_dp_panel_private *panel,
> -			       u32 offset)
> +static inline u32 msm_dp_read_pn(struct msm_dp_panel_private *panel,
> +				 u32 offset)
>  {
>  	/*
>  	 * To make sure interface reg writes happens before any other operation,
>  	 * this function uses writel() instread of writel_relaxed()

Hmm, so the comment talks about writel(_relaxed), but the code is readl.
Is the comment wrong? Or is it not applcable and we should be using
readl() here?

>  	 */
> -	return readl_relaxed(panel->p0_base + offset);
> +	return readl_relaxed(panel->pixel_base + offset);
>  }
>  

-- 
With best wishes
Dmitry
