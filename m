Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A9BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 00:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E270710E4FC;
	Mon, 13 Jul 2026 00:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIyctDIw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LPGzCbwI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CA510E4FC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:09:42 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNUbQe3944510
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GA+QgBdn0574n3JABCA8ZO+N
 9bz6eWFUrGRBq86C1/c=; b=gIyctDIwwyRbQvRU16O2xyqcGc1vbm4on0Nrt1XP
 BdeYPABiIKRVNluEY6vQX169LXccosTqLcMyX3LrsrqKRfEenz2WXvp1ppMcFvqa
 j0rCSW3GHRcMZg6rUwATKDLYZE6hwWoLQBMe6qhP5Jc+rJgwNWk2/H308SPqsKM7
 KhRbqX+wijzMXFbQVeTvZSkU5R4853i7YKqfylJd7IxxeAM18X2ZBxyE2Lpveu/L
 /Mhzl4dK8W1Qj51LC76fLfLxxV0ST4s9JDtFYO/HtjC21wyO6505flgVwRyrbYaf
 4vAHCuZRE6tvpdIhmhyAOc0jshPo0Z8qkPZxXkJyK2IgVQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr3nq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:09:42 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5bffdc86fd4so850921e0c.1
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783901381; x=1784506181;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GA+QgBdn0574n3JABCA8ZO+N9bz6eWFUrGRBq86C1/c=;
 b=LPGzCbwIo1L/fqHVUGMmD3juKfeSm5vlcsnoAuuEByZMrCizF307vGi5iRg2I2i21y
 bbyiCDzMZ47prqkcOiNGhtLrVNxJi1TI5/H2Bz5ZX36OJ56X9j+3swFFx6TU1hbEmoRW
 BKu51LmJW4cnQbHtdkc6SNmeSEVXZmmkuD5vxOaZgNofz9bORO0K0gpcWSWRYfsw2fG7
 lgC8XLPgCpFcDmJ2jPI7rrx0ZCGl8RL5B+KMEWn/mGaAA9evUda5gXStHqsAY0i44rV3
 gGaMRg9Ncrt02xE8VpAW7iDLJY62fiGUnrGu2jyVpjS9bmefb8tZl0zD1EL3DZtfOF+k
 42jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901381; x=1784506181;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GA+QgBdn0574n3JABCA8ZO+N9bz6eWFUrGRBq86C1/c=;
 b=CHbH9bAYzSCZNkKd748SyvV2e3zTCVAwU9J8scjIsfLVNR8d0lpkSzDo1xWWKNyFqv
 Bzlb7KU6UwG9FpHfHOaurqZYWLKKDPH3WZudEv7dagiK3zDF27NnxgaYjGYQxLjahbP1
 Apu1D+DvsXpMKlcluM+TWLcGwQ0vbC6GdrsjEP7eEFK7WzEri0z1M8/oPOJ9g4xGzfmT
 MUn3+HavVGMB0Di0m6ImWNkDcyyEfaXJKDdwqOAFjgayl2vVxRFEL7v1RHXAoolPtuK6
 ViOEycKYH6trpOsNWGwTzMnI9oj1N+KbGImHnZmfb9hXr14lPTroSjWEmxjJdUaafdYE
 9bzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPhbJLaQYtyOebTO74VWpcDyQPhLvpOQ0hQhe8lmuBqooDUxAboxjsAB6iCVJLc8Y3fkEPxcG1jdM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzd2vWprUfCxzURWPN2E/0zbfYDedwH88grw+IOfLgI1QzafOHk
 hN9txCKq3gN4J0EAASzLmoM4skwEpmXrUPE41CmMEeo2saezYiR7C/3PzLhaxQzk5l5Xp7Unn/7
 ZPCb3SWNV3HSJgiA4j3iOr2CIKlPLif6DTANZ+gzWtmzul625CcQ/Yvc+3WT7dKfRtnG07zIQpd
 Sn7SU=
X-Gm-Gg: AfdE7cmiNbPdO/fEpGdYkcLTK9ZsTnxtJeFQNgOZyDOHa7QP1dFoAH2VKUdxzhN9otP
 yOZb7tvezkNN/tZ/Y8WaVMJJ++OlDdyrCZWtrvz1k5SqjC+654C+zaS7R7jBvitGewGKS6aZFdt
 8BIGZjecSKadmT3vI2RyFSjF5d6tMUFkix6XC/0Uco6Jg1abpro7kDw/n48pnlqkPdFbHVg0ZG2
 xmQ/+1Nwxre8d4CUiUGskToNEdmvwTHpbQwLuvj8E8YFh5oyt4L29sraQ4rmq2lSYmDCmrA5Fbi
 GasqiJrEJfZWM2FH+eNYTM7SlWaucRfKwZVK4T6pRn1735c7t77ZVZqFJof2jRA2jRbQuH17DTz
 5TBZEgKeuOuWDwno65iP0SrFYvnKEPG6zndtHY5EaoMaDiFSVw0ZqL4ot4/bVq0I+pQPANqg5+e
 k5fXZrOYdPFZln+aFbzGmqsXR+
X-Received: by 2002:a05:6122:6310:b0:5bd:a2dd:60ee with SMTP id
 71dfb90a1353d-5bfa470c003mr5528523e0c.3.1783901380969; 
 Sun, 12 Jul 2026 17:09:40 -0700 (PDT)
X-Received: by 2002:a05:6122:6310:b0:5bd:a2dd:60ee with SMTP id
 71dfb90a1353d-5bfa470c003mr5528506e0c.3.1783901380396; 
 Sun, 12 Jul 2026 17:09:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b97553sm25969171fa.33.2026.07.12.17.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 17:09:38 -0700 (PDT)
Date: Mon, 13 Jul 2026 03:09:34 +0300
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
Subject: Re: [PATCH RESEND v5 21/25] drm/msm/dpu: use
 msm_dp_get_mst_intf_id() to get the intf id
Message-ID: <pnhfi37ijlxuboqritlsg2o6wew44pe7niyhyvxc3dbrdvgazc@dfpldilmrp7r>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-21-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-21-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI2MSBTYWx0ZWRfX8/B4TmHXaqBM
 huKTs4ZHnSV0QmFTLR2clbEukJfW1YioYOF4Sj8qNIg+ffhb+uWtYCG+HrrV6pDZ0vpmUdIpbwl
 ROyuJGnAdMc+ekh17lzQWvhqfOOx5Xc=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a542cc6 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Ur00xY7Li4RbIHJ_WnoA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3kBCYiuCpJfQfBfORMoDnZVD7hgykcqR
X-Proofpoint-ORIG-GUID: 3kBCYiuCpJfQfBfORMoDnZVD7hgykcqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI2MSBTYWx0ZWRfX2LxQNXMxomG1
 B5fnURyRj3flBdzJkbPmTs/xwoeQ7zjlc/2J8LZhXcmKu2t8e+5Akg0Cw5ZiT979oYfyZ/ntu4z
 Vi9SYlz7alr9f7hCo2Qza+b8TrOGkh35qrSlOjOT6ADsNdJF5PNCa5V4SQCGECAfCYolpIant0/
 Y84IQ2gJV2eMVuu3P8pa3ZIOd6jdYAziLpzDPaMQfxQyS4UODGMqPDcP2ur+b5eCRJc+wkgb4aJ
 iNMmnfZdo1XradYf4kD/X8/fHwlr/tLWbTGFz/OgLN4t+jj7X8k61WZdx3U+FeIshodxwD+idNa
 j+lf922p8epM9VfNkJaAzENioWHmyELyJhqKCMM7KmRVDz+PKV/AR0MGbNy0vtjtbbbmEyVJm2y
 c5EYNTf6sL2i1qvWd+1SNnyriBosq/08MqGR/n5rVm+LP0xjyaa9AiBqUNF4sE4NmTyGKdXSDZn
 A1KQ96oJJ7vLkizCx5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120261
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

On Mon, Jun 29, 2026 at 10:14:42PM +0800, Yongxing Mou wrote:
> Use msm_dp_get_mst_intf_id() to get the interface ID for the DP MST
> controller as the intf_id is unique for each MST stream of each DP
> controller.
> 
> For DSI/eDP/DP SST, the stream_id is always 0, so existing behavior
> remains unchanged.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 +++++++++++---------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  4 ++++
>  3 files changed, 17 insertions(+), 9 deletions(-)

This really should have been a part (or done before) the patch adding
DPMST encoders.

> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 1c74ff6f0dbd..3adfaeaab71d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1438,18 +1438,21 @@ void dpu_encoder_phys_disable(struct drm_encoder *drm_enc,
>  
>  static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
>  		struct dpu_rm *dpu_rm,
> -		enum dpu_intf_type type, u32 controller_id)
> +		struct msm_display_info *disp_info, u32 controller_id)

As you are now passing whole msm_display_info, controller_id is
available as disp_info->h_tile_instance[i]. Pass index to this function
instead of passing controller_id.

Ideally, split this patch into two: one changing the function to get
disp_info, another one adding stream_id to the struct.

>  {
> -	int i = 0;
> +	int i = 0, cnt = 0;
> +	int stream_id = disp_info->stream_id;
>  
> -	if (type == INTF_WB)
> +	if (disp_info->intf_type == INTF_WB)
>  		return NULL;
>  
> +	DPU_DEBUG("intf_type 0x%x controller_id %d stream_id %d\n",
> +		  disp_info->intf_type, controller_id, stream_id);
>  	for (i = 0; i < catalog->intf_count; i++) {
> -		if (catalog->intf[i].type == type
> -		    && catalog->intf[i].controller_id == controller_id) {
> -			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
> -		}
> +		if (catalog->intf[i].type == disp_info->intf_type &&
> +		    controller_id == catalog->intf[i].controller_id)

Why did you change the order of the args?

> +			if (cnt++ == stream_id)

Squash into the condition.

> +				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
>  	}
>  
>  	return NULL;
> @@ -2675,8 +2678,7 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
>  				i, controller_id, phys_params.split_role);
>  
>  		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
> -							   disp_info->intf_type,
> -							   controller_id);
> +							   disp_info, controller_id);
>  
>  		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
>  			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 25ade3dbbeda..861d69afbd76 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -28,6 +28,7 @@
>   * @h_tile_instance:    Controller instance used per tile. Number of elements is
>   *                      based on num_of_h_tiles
>   * @is_cmd_mode		Boolean to indicate if the CMD mode is requested
> + * @stream_id		stream id for which the interface needs to be acquired
>   * @vsync_source:	Source of the TE signal for DSI CMD devices
>   */
>  struct msm_display_info {
> @@ -35,6 +36,7 @@ struct msm_display_info {
>  	uint32_t num_of_h_tiles;
>  	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
>  	bool is_cmd_mode;
> +	int stream_id;
>  	enum dpu_vsync_source vsync_source;
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 91d33b432427..b32ecd5b0777 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -614,6 +614,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
>  			info.h_tile_instance[info.num_of_h_tiles++] = other;
>  
>  		info.is_cmd_mode = msm_dsi_is_cmd_mode(priv->kms->dsi[i]);
> +		info.stream_id = 0;

It is memset to 0. Drop this (here and below).

>  
>  		rc = dpu_kms_dsi_set_te_source(&info, priv->kms->dsi[i]);
>  		if (rc) {
> @@ -689,6 +690,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  			}
>  
>  			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
> +				info.stream_id = stream_id;
>  				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
>  				if (IS_ERR(encoder)) {
>  					DPU_ERROR("encoder init failed for dp mst display\n");
> @@ -716,6 +718,7 @@ static int _dpu_kms_initialize_hdmi(struct drm_device *dev,
>  	info.num_of_h_tiles = 1;
>  	info.h_tile_instance[0] = 0;
>  	info.intf_type = INTF_HDMI;
> +	info.stream_id = 0;
>  
>  	encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_TMDS, &info);
>  	if (IS_ERR(encoder)) {
> @@ -748,6 +751,7 @@ static int _dpu_kms_initialize_writeback(struct drm_device *dev,
>  	/* use only WB idx 2 instance for DPU */
>  	info.h_tile_instance[0] = wb_idx;
>  	info.intf_type = INTF_WB;
> +	info.stream_id = 0;
>  
>  	maxlinewidth = dpu_rm_get_wb(&dpu_kms->rm, info.h_tile_instance[0])->caps->maxlinewidth;
>  
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
