Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDB9C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40C510E2BB;
	Sun, 12 Jul 2026 11:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObeW3GqT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hwbsKl4T";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4468110E2BB
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:17:57 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CAckO32371616
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nHcJCXXB3ZnfIZ8ZoMcNX1TJ
 yR9lo/auPxWHf/zGIoY=; b=ObeW3GqTDEVzXmJWMcpzzCAcgcpbAxOfsm/s6ZmY
 uiUH6rsgkfIC8992UM8HBMM43qZ08amOgrvWU7Lx6nx4PgwG7memcm4y/rR2qbjG
 2UrthL6Ju/hEb7hhEfcMpy97pc2uvZzmJVNTjnDf96droNIA2+8GbMTmZuQZH3Yi
 Xz52wrkab3XdiUU7oNFgHSlbJBbzMdQ1T0Icm030iG12/ucJHitO4ghsv8/f+BBW
 Dr9VM9Fkyx0BaSo78t7UbrXu++kSMSXJeUDnXbGvK3K8jMuxYSiJ1T3pFkdiwxRW
 R4Q6KYWMXtM+NU+FxeObeE+tyCw5h4x4wfp1nJdN/bdLug==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr2k0x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:17:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ef8249f73fso45949826d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783855076; x=1784459876;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nHcJCXXB3ZnfIZ8ZoMcNX1TJyR9lo/auPxWHf/zGIoY=;
 b=hwbsKl4TW2/RpQuHGQR8IEhRXK8Iq9erFyvAPwqRXVpxMUifgpAKvU5Tevbqwp+W8V
 IoOLyyrAEos7TAH03FEAO8VkZ7SWoUA2jHrMLGtkwYGIKUL7EWV5bnYo79BNoNgU+M2H
 oCsVA5e+Bgmg889YkMKqSrpJxVJdUnUITNE8wQTg5xYCybXdGmdDCZa4IJ5fgCHRTYa5
 FbVi7aksBGO0tm5BBaBTPpylQQShNK3PDvJOi+LwcRpUyZ9N4uAtlDxql9MEDFMlfAak
 oIDM+SAymM2MANBS5dP3zOzw5vC3hP9x0wUpyg8SwLabyeIQKD1qC4A808chz0Ifirtm
 dirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783855076; x=1784459876;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nHcJCXXB3ZnfIZ8ZoMcNX1TJyR9lo/auPxWHf/zGIoY=;
 b=P55T+lL/QDB5sU96lCFDSIg9m0HZneGPzPO9zmN/W4dXseUW05ZjPgpcTv9drUlEhn
 IJR+LauTol8elX3JkeqQUx3D6vpA3oQMZXXIHXqaVkLm7bc1+6MPdLkFte1xh9W8XIxJ
 kFQT6DJXZT62TxouZtsCMuPFQmPROHbxFef5NjgWlpXIlTzHBvvRiqrCiDoEyfrEFMQU
 f+GPl3vG7qVWuPazl2axGDdscx21lIwL6ig2pCown7tYkVmnNpXmRwJL1F8eym5W4UtP
 /3bXJFUlYprloCDKPO6v7IFTFe+6/2cRsXSPK0DT3K5Ju9wBR5Zp/CHG8Agifgc4TNUi
 FbAA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roh2OVt3Sg+TqAfzKtAmihcdJ6wf6MTpZu4iAX4d9zsDHUX0kp6YXylVvsvmnx2sLfMPUldY0pVl5U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywRwKtgXsg9vPZ8llbQetcyvsD2xSmhZqJomPMOuisMV6C62SU
 ZVGmA7be8kjJKOmhnqc4wD1oWmiMt9xtnXfaRz1cPSbfk/K8SzX0vWJQhq0X5Hn2z2a/Q9vidwJ
 YP9a26CfcD7Res0OV8FhiVsDf3IE1klxoAfYe7UoAwM0tAnheBUO3sarrjY/IcMqSCaf+Pks=
X-Gm-Gg: AfdE7clCUB/Zkbsp1rmmYrtfyuh1ZtczN3/87Wun9m8c+wqhJV4FJPxUmYIcIJntPlq
 3MjAZHozTO9f6VXFgFonwUpjDD++xV3kDuPpKUl5GY2yJs3LtXms3CX0ovP4puQxSvE3UKIH+Ai
 H6DNcobesAqPSIJZi8hTZUR+KdZKMXfz8+KH8M6NcW9TVekLI3utfqWqw8ablh/BQWMzgBh8kXf
 /ix3nSi9QC1Pyafy78XenaVCpPLElLmHIS8ULY3riEFdqHeycepKXEZQkQVs+ItH+wj1bFRvpkr
 8CWL9FrgfKVWtWOEAXRJrS9i4cT+bXjhEBXPtHdxDmUGCvMAf57zR1cV4Hr55784lUfmuWKPtAV
 wVpkxqN87W0gBhosvXl15f2t5ZgTaPKCNi9gLDODEHZookIP95ZYlutj7DSAZSR+dAhMfLFSlf3
 yH5ca/tMxzYe4y0eBZgR8CK3f1
X-Received: by 2002:a05:6214:3ca0:b0:8f2:f32c:6bbb with SMTP id
 6a1803df08f44-9040236311fmr64736766d6.51.1783855075719; 
 Sun, 12 Jul 2026 04:17:55 -0700 (PDT)
X-Received: by 2002:a05:6214:3ca0:b0:8f2:f32c:6bbb with SMTP id
 6a1803df08f44-9040236311fmr64736436d6.51.1783855075279; 
 Sun, 12 Jul 2026 04:17:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b0cea1d984sm1120207e87.51.2026.07.12.04.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 04:17:52 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:17:51 +0300
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
Subject: Re: [PATCH RESEND v5 02/25] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <anxxmx4qfdil4chif37e2xzk3juuvpnqdoc5mg3jcbdkoaa5rg@obruztrgljpp>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-2-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-2-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExNyBTYWx0ZWRfXyGnxD2FF6qce
 kAtkuq+Kz+LrYp/mcPbnHt/h6UIzEUlnLTyKE7s7MDHSz/Ha0wu2A+Yu1RayAsVSl9q5eFhBCi8
 oQofymoUzqZitBpJ2eQb/MB6YRQSUyU=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a5377e4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=vzSq-QvcmNpNVXwySUEA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3VAy0UxnCdO9qnDOfBJU7xBf6Nl-11JN
X-Proofpoint-ORIG-GUID: 3VAy0UxnCdO9qnDOfBJU7xBf6Nl-11JN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExNyBTYWx0ZWRfX9RvP2AoOjo7I
 pdbY70uxwvbKx0VjCT8DP5MsJOxTpHVCE/1ml+uZC/1KIj3sfU2yCpxgZ3BeVrJgwPnmcc+u4jh
 2/Z8L8vADk9TvZRAJRt3vW/hXoYEp05v8QPSp+1Zm8oye78uzazf7qXxfGqW/YUGbfKMd5LJ3nf
 YaGSL9A3PSHnAyNDMOJob/InQcy7TiWObvtDSrdj44L79KT39fuo8LSLusQZMy3uuy1myQ6Imda
 LA86WRA0oN/QJ6IdVnVAF/vUfYZ1KvMt1h8wdxjRYMtueWJ3reZwxqsy7hi8UIYjHPe96gV4Z4i
 gfGN8TLqOGwxE7DJC/kz523mpWw0LOQlo3LH9aO7FwbQAxlL9VsbU96AWdHMdKe2YxM1+f3BCPZ
 pVoRA2UIN7kEy1xWg7MUzIg6pr4mps0y84RiirsMmsL8IYG8HeyN+RRT5IL6BqTw/EVp6Zl9aCD
 clDYFpa7vtcovC/hGiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120117
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

On Mon, Jun 29, 2026 at 10:14:23PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> DP controllers across different SoCs vary in the number of concurrent
> MST streams they can support. Rather than hardcoding per-platform
> values, the number of available pixel clocks in DT serves as a natural
> indicator since each stream requires a dedicated pixel clock.
> 
> Introduce max_stream to capture this at initialization time and expose
> it for the MST module to use during setup.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 13 +++++++++++++
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 12 ++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  4 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index a475e787656e..68fb4facb056 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -127,6 +127,7 @@ struct msm_dp_ctrl_private {
>  	struct clk_bulk_data *link_clks;
>  
>  	struct clk *pixel_clk[DP_STREAM_MAX];
> +	unsigned int num_pixel_clks;

Squash num_pixel_clks to the previous patch.

>  
>  	union phy_configure_opts phy_opts;
>  
> @@ -2754,6 +2755,7 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  	if (rc)
>  		return rc;
>  
> +	ctrl->num_pixel_clks = 0;
>  	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
>  		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
>  
> @@ -2766,11 +2768,22 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  			DRM_DEBUG_DP("stream %d pixel clock not found", i);
>  			break;
>  		}
> +
> +		ctrl->num_pixel_clks++;
>  	}
>  
>  	return 0;
>  }
>  
> +int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *msm_dp_ctrl)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	return ctrl->num_pixel_clks;
> +}
> +
>  struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
>  			struct drm_dp_aux *aux,
>  			struct phy *phy,
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index be0d89d60914..305add3dcd93 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -55,4 +55,5 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>  
>  void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
> +int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
>  #endif /* _DP_CTRL_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index bb243ab09e66..9cd243411e44 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -87,6 +87,8 @@ struct msm_dp_display_private {
>  
>  	void __iomem *p0_base;
>  	size_t p0_len;
> +
> +	int max_stream;
>  };
>  
>  struct msm_dp_desc {
> @@ -578,6 +580,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  		dp->ctrl = NULL;
>  		goto error_link;
>  	}
> +	dp->max_stream = msm_dp_ctrl_get_stream_cnt(dp->ctrl);
>  
>  	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->link_base);
>  	if (IS_ERR(dp->audio)) {
> @@ -1178,6 +1181,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
>  	return 0;
>  }
>  
> +int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	return dp->max_stream;

Anything stopping the driver from returning
msm_dp_ctrl_get_stream_cnt(dp->ctrl) here? Why do we need to cache it?

> +}
> +
>  static int msm_dp_display_probe(struct platform_device *pdev)
>  {
>  	int rc = 0;
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 43ed79093e24..d3d4ab98089d 100644
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
