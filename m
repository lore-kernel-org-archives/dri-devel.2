Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56316C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 21:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1420D10E4EA;
	Sun, 12 Jul 2026 21:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pND/cEdk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KxpyI74E";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F7310E4DC
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:56:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CLVtGC3622977
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=miBRTRUcyF4er0wPQFfEz88S
 7Bst8TkGlZ4fEE+O0R0=; b=pND/cEdkdz4o9/ckHycSjI6mkfzl2tOw4Fd7IbCM
 1N7YSZPnb65MXyc/t13sRkEJMeuWFezYk3SQOR+zwWfgZM63ZGUmVFWrxrzaqtTy
 /eGm/FNy8m0nxzzNw9e9QgzBftKZgtSdaU3IJOF+ebZKERmRBhcSjGJGKhzYZFsB
 reOoUpH21/eD5gVo/FggbnwB1j3tilqW3T+DJSR63SGwq/mbfC9IVUGv0uWq3Scd
 Ce1FPWqnncPNazR2Ldx8IKgO7D3FwD83DjoaE8trGqX8+MMAWB0Cto8/AJW7qBTJ
 /J2rLCJKPdBRpkGbSvlj12y1skN4GYASqjwJFYZSmU/a7g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe913m1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 21:56:15 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c0fc9b4f43so251284e0c.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783893375; x=1784498175;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=miBRTRUcyF4er0wPQFfEz88S7Bst8TkGlZ4fEE+O0R0=;
 b=KxpyI74Es2Unmhl4+hIayY1Wove4byiZKncV6C5B+R1p+X0WSIYjXOJUvRxTMvR0im
 xvYFGNx4nE2Lx1BLl+rn7G+DTJ/f30VtofsmRhrvjorkwk6Q1X2JNl51OtpsCPRx5MGF
 SztO925ZHiwBgKxBu1+jZ5lkY47W1tCYf5Gv4aj6unl+gRffXOEnaUi7NxalZ9Xd60TU
 NcH5oIUlMQslQ10/p0N+KFAsnGbIP/BiXgn13VDA/+f+EASSb6IUEXgc2sGhzPGSOlVt
 Xk5UDDpfNioFu0bumZRp9d5QVQf8LbAE/HKtDkASXujL5e2tdJEyA0/rv0c2wMraUJK5
 TDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783893375; x=1784498175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=miBRTRUcyF4er0wPQFfEz88S7Bst8TkGlZ4fEE+O0R0=;
 b=WS47eAC+i2aOLBdaqxsKuz6E0X+qh8LJBENVxco4LHR/sbnj2qGu2CoI+Qcd+S2vYu
 rXNsvfvhrc5CfqnS09ij3C9sBY64sLXylQALzxhuY0xRqIbNuJpNYKWJTH0efK9wQ3lv
 A4OdOpO5P4+urCP1pFk2dKciYJl96pJ7Uv/PxvszuesqfSuCTU1lwsSSwRg+hI7g2VA7
 X1C63dHzrb7wZc63D1zrSApxFt5aTE3+SYhzZZaJZiQzXm4e5n7H6QA/ZRw9mnGmQC7x
 noaTCQoYUt9GdFaAv/qdL36oaKoieBkqjrxexA0jXewoeYv4m4diU09Va8ARv4B2AhkK
 +vOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrpb4SRN6m+Y/eP6ZFCvtTSw2CYMzhqRZpQPjuJv3kogikTs6TzIa2VUSX2Bt/ljXeu17qFSzfm0HU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3bw0G6kgppPg6J3Ps6WYkBRXJQA1XRKUhCd8ox4o6WKlsfTBb
 s2Ddgwp4hgiuuvYvyvI1kyQ9r2A3wJef1yY7wldNUWNdNUPxkUKMvhqhQjQe/DavKCutxtTb719
 nerGLZ/i9quDk44BXQr3MrxFJiHSDqXtCzK7x39W9cgQB3Z0op2Icd+N3i7/HqrI/xAKyrl0=
X-Gm-Gg: AfdE7cmzQFv2eVwtYZJwQ7GVzlI9YRydYDRzzmTmuWwJd2fqUf8eRpyRp7bU+1ZvCey
 QatpSmjWahljvEoXR8Z/i7YlpXq8j4CWYsj8oaKLb29J+/vOB/NsocvwulovQBVQVVx7AAV5zkc
 PqtUlI6Z1+voT/FKugPdIcVYwlyHYfOibI1VAc1sUYUxDqc4gSAR+teG9J7ZHDV7mX8eBJEa/KP
 1gZvXRKNoni6DSWnIuCEWqebnb5OmhRhlG23nmrwqufhGdx5SrHJa3ll6KKFfm0RoRKpxnZUid+
 EZ/5w/37dAGGKG4lvOmIGL6y+JWg1wEP8/2b3C6V5EFIh2U09pYafwvWFAtNJANfgHHcIb20Xif
 ywEtG4D9Lz9D0ZLH1nyk/Tcib1tPa1Xity/mCx8+tBxcXD1A36y9VxHXowWan33y806Gtir6Jtd
 REgVHGxmO/VwcUfFhTxusd8RCC
X-Received: by 2002:a05:6122:1818:b0:59e:feb7:8a5b with SMTP id
 71dfb90a1353d-5bfbed5ff4cmr4688816e0c.0.1783893374964; 
 Sun, 12 Jul 2026 14:56:14 -0700 (PDT)
X-Received: by 2002:a05:6122:1818:b0:59e:feb7:8a5b with SMTP id
 71dfb90a1353d-5bfbed5ff4cmr4688807e0c.0.1783893374562; 
 Sun, 12 Jul 2026 14:56:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b1a164sm23484121fa.16.2026.07.12.14.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 14:56:12 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:56:10 +0300
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
Subject: Re: [PATCH RESEND v5 16/25] drm/msm/dp: add
 msm_dp_display_get_panel() to initialize DP panel
Message-ID: <x73tylpiatrtwm7e6zomd4awwgoqdzqnbhdtd2cwxh4s6zlp33@6cjnrita5ypq>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-16-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-16-2ed6aee1867a@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a540d7f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=qYs0ZBLfSisuqDwih3YA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDIzNyBTYWx0ZWRfX7vWUuHtOESze
 8ogDTcE3r/Ez7z8ubKr2Yuah3uxcIMUCHG1Xp0v4Y7Jweo/1+sx6DVyZYfF9G+2XU1xZFs3adEP
 REKBvnozUr6E0Tpyoq8vK0w8U7k+0ug=
X-Proofpoint-GUID: hOVUjoq-JjqIwMSmnWr8hkFgTUjpcM2x
X-Proofpoint-ORIG-GUID: hOVUjoq-JjqIwMSmnWr8hkFgTUjpcM2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDIzNyBTYWx0ZWRfX0nKGafMUJugy
 clRp4+O6yHofvYmJIRJJ4ydPzqB/DhJgc7VD2Z9chSiwPu1qpde0vA3ovYDi3hlZk9+CMLbyhgw
 xGoAq6d1wvwRYrtr0acrrDz/eOWLGQ3aibfBAeTrs3GwAH6dVi4e6vG9T5PSksKdsXojy4Pi9CB
 xx/2GCl3esQGc6Z6ro5DEHNMae1iCdBPtxKkRQS7Yd3Vu6VZA9vdkW8X3ludjbrMHKhEGMWHiYR
 2bB6iakVdQZg1GI4M48wNi0Ky0h51M8F4/75thTWCWnnd7nXs/W9p9167YPmPa76aym6p702bYB
 MZRw7MD8+ZhipbkOjyZ5CdQNMcFKt+JbnT+XEu5hcO2ykwGrLgdYJx5q2MIZI2C0M/9Da0TYL64
 AvN7ufCAh1I11BJYzejhNtyyihu0oZ5uxnfVWlR4PV0Em1AhBrf1fZLj3vZfErYRxqVs4tC3Gm8
 2m7JnSMh2L1n905RmSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120237
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

On Mon, Jun 29, 2026 at 10:14:37PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add an API msm_dp_display_get_panel() to initialize and return a DP
> panel to be used by DP MST module. Since some of the fields of
> DP panel are private, dp_display module needs to initialize these
> parts and return the panel back.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c3be656f10ee..2a74302bcb7c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -565,6 +565,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
>  	return rc;
>  }
>  
> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
> +					      enum msm_dp_stream_id stream_id)
> +{
> +	struct msm_dp_display_private *dp;
> +	struct msm_dp_panel *dp_panel;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	if (stream_id >= DP_STREAM_MAX || stream_id >= dp->max_stream) {

We know that max_stream is <= DP_STREAM_MAX

> +		DRM_ERROR("invalid stream_id %d\n", stream_id);
> +		return NULL;
> +	}
> +
> +	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
> +				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
> +				    dp->pixel_base[stream_id]);
> +
> +	if (IS_ERR(dp_panel)) {
> +		DRM_ERROR("failed to initialize panel\n");
> +		return NULL;
> +	}
> +
> +	dp_panel->stream_id = stream_id;
> +
> +	return dp_panel;
> +}
> +
>  static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
>  {
>  	msm_dp_audio_put(dp->audio);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 75dc40261723..676213a48089 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -58,4 +58,6 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
>  int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
>  void msm_dp_display_unprepare(struct msm_dp *dp);
>  
> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
> +					      enum msm_dp_stream_id stream_id);
>  #endif /* _DP_DISPLAY_H_ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
