Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C37109190B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E694710E17B;
	Thu, 19 Mar 2026 18:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ep8bUYf9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UuHpLxjO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4758C10E9CD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:54:24 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JDEIRu2908982
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=G2WezGyr5dgk9PNvU7r1hTN9
 zFO7rnukB6Er6MUUn4w=; b=ep8bUYf9ZRAMEpLqB3fpyyKumKSf2DNGVuwOZvCf
 oNvssSRzSOLf1tSg1ElV+OBh9PZcUgE1axxVGoNWb8NsnbpGkeBwIQK4bS79Rehn
 5f0kNWbQKp9SCMiZUyC6cbjgj9Q3/V8zX7qpyjITLMnCSE50WH2UeIDbTZhVZOmi
 lAcURwidgtrn+uQ+Wv65rMJtnpwxwY6XWamnyUnHtlqKjPVs1dqnl7mlbWH7pGis
 sOhu65I5Zq+TgBlKf3Zz/rdXzLEZ14TeGXVPA7tAJM3vH3oZ2Qddf66YbjbmWJ7r
 B+ddtX5adE6tJSejvUa67bJy2gjqFAXOMpYI+0yo7ZIMsQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyy75vquq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:54:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5091a96f0bcso64215071cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773946463; x=1774551263;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2WezGyr5dgk9PNvU7r1hTN9zFO7rnukB6Er6MUUn4w=;
 b=UuHpLxjOqSdCTuwj3OnlE/NLZoYJAi35uccbbE4VzpaUkb9r2zFy3yYPhFCUOOLg3O
 fGl9XH4E7DascKnmALQhwWadYqBwqeHJPrMaM/jzTyVSHPA8vEIZX1oNSI2hQtvN8Ant
 F7y5D4SYDjiZ+HiqGcPt47WoMtyRLelwagkl/EBse4w0YsrWpWrhtKBR6XOITbNoTo7x
 HsCvJ25qVz5pEVOp4NW+tPShz4M26+XZlAhj8jRlSj0V3Qi1kaqy2MoF/LTO0z5bvNIk
 s9yih+nKckQ+oK0P2i+bJEKRkrTcXTCTLJstAPq5Di0oV1ERvbqWDS9El9m9xNG2uYdi
 1OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946463; x=1774551263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2WezGyr5dgk9PNvU7r1hTN9zFO7rnukB6Er6MUUn4w=;
 b=HvtMtiaw9I+KarYqWg8ZGr1glPC5X30rSoKOFyQdYRQOzsG9D3v17aNBs3eWpi484q
 pAGQZQpCEBW+v+596hxtJqEh03I5DBjXw2TDngDjLi3U9xSLHGyrrGxo22TMMi7sQE/6
 QwcfIRQ2Q3HJlIKQm5m9qt/0lIHHYkUUC+o7CJriV+bmEtYwwuffHtYXEEkrQT1p/jUd
 VP9qBmeUdFTMDj/RxcNEFNZXuUvtcpv/iTr/lPxNXjXMlKjBzEshjR0OqpCsEVCPr1HP
 M6dIPxpd5n0UANN7IvqDpNVjunigKHgA/VZ7XVkt5PCW4Ko6UH9Zk/0/i889LweRzvPP
 4lMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0gao0kYeKtzYF50Nb3udR0ZSWKZTitGnzpsH361mgRGkIZV3wWqM/e7cOGx6srRF9Wwyp05OgLJM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEwnb2vf6Xl8uEpLsa22UnWldyXpKNo2Sba9yH2OUaTXasqWMZ
 bP6pw/ZO/fCDXf70XnwhgDJA9ChuiXjWFR42QeibRD5CLR7js3yndIsg8vUrDmwLZ2Ml7nC7MDT
 yx/wL+lA224NGfFYNyvnHBpV3X4dtWANmGasdgMdXUnnECPAmh0tT78iRtCrBs/L1vPB9+oI=
X-Gm-Gg: ATEYQzwU8iGeng9Y9E+OFdR+vuJMyh4614e/eYqSts3dxNq0jCadn4hokHPQ340g/2Q
 bzlZQPQeBpJS3iS1T1HGCuKzF1contUF3x4+GPsgGBgkaT0GU2/Gm+lGnLLKQIGibhEp2/CQWHo
 Cd83JWzi5FAngZHqLm7azxBBTUhSSs0zuLObJP+25gCCbYyJ6AddD8LPnfbjD/DM48//MIvl8tb
 d2HWynFC+i915trqRjO0N6uS5rQ7TVG7Yu8PoOamlbnhXS9be5vAqpKiYyrtXX8ebLNLwgPhh+T
 9qCW7kZP6xPULY4dnS4S+6VAMvZBxEuEFgFSnLEEGOAjydjNUlrVFNPyhXiDnRvsj/7AnfdRkv2
 +AWjEGbb/Z1eltl2gil6sGVyeWPhleMjfXgePB2p3ap+pe4HK+Feh4HivpS/HixWAAc9LYasPbD
 03JI3jYpWY/lEkSTI0h0Fo7n0iPkARIvnjSbM=
X-Received: by 2002:ac8:598f:0:b0:50b:31ad:32a2 with SMTP id
 d75a77b69052e-50b375b76a2mr4098721cf.65.1773946462665; 
 Thu, 19 Mar 2026 11:54:22 -0700 (PDT)
X-Received: by 2002:ac8:598f:0:b0:50b:31ad:32a2 with SMTP id
 d75a77b69052e-50b375b76a2mr4098211cf.65.1773946462070; 
 Thu, 19 Mar 2026 11:54:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285207365sm70334e87.42.2026.03.19.11.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 11:54:21 -0700 (PDT)
Date: Thu, 19 Mar 2026 20:54:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] drm/msm/dsi: add DSI version >= comparison helper
Message-ID: <5626aicmljavjep2sscge3olxrwwur6v3sm6di6c4q7yuhrqfq@utx6mmdj3erp>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-2-85b99df2d090@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-dsi-rgb101010-support-v3-2-85b99df2d090@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MSBTYWx0ZWRfX4xgZfwDm2j6y
 uT6MyY7beB2tpTvoUQzThyYDdwLr8FFBn+IPJj74dmqBzFdUulbBVA8Jb+7RVuB5KCRx4jjKs64
 /ba4Se8vIzwviuhgqAmHgsvA/Con7xF4il3UfYS/LG3AB3PWNuoCanNC8+c1JqmuyziRWqg06/n
 ID6P6mso7LAXINNkBVrt0OnLQhC6708PmFNOSnKdzGImAr56cqR/Q3X0NVPljB5pNsEuFiJh8Rt
 4H9I7GlNpBphGG5ZN7+zAZjy/0ljLutqYFNUyAemVD/yaRjg/ZF2gDl/7lO613F+ZBFyZ9oRsH6
 RoMgzZibYHx3tQJucGgMjzhfT0x/Px7+a6Rk655U0QX2r+ertnJGThyxF8oTf5PnZ1pUAMru4G1
 iFSHUa7I1KrFT/EeUGb356AtfjFpbtTY9CmIH1bDu/D8NcOVkoGc6MkWs2HMcWwLboMy39QVCuM
 +K0W2Z3ueMrzQX84wtw==
X-Proofpoint-ORIG-GUID: hXOFqj_fFSJMTEpfbKZEGheDmJbF0SlJ
X-Authority-Analysis: v=2.4 cv=A7hh/qWG c=1 sm=1 tr=0 ts=69bc465f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VDRd5MJ2I6Cixv0V3c8A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: hXOFqj_fFSJMTEpfbKZEGheDmJbF0SlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190151
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

On Thu, Mar 19, 2026 at 11:57:52AM +0000, Alexander Koskovich wrote:
> Add a helper for checking if the DSI hardware version is greater
> than or equal to a given version, for use in a future change.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index db6da99375a1..6fad9a612d4d 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -782,13 +782,20 @@ static void dsi_ctrl_disable(struct msm_dsi_host *msm_host)
>  	dsi_write(msm_host, REG_DSI_CTRL, 0);
>  }
>  
> +static bool msm_dsi_host_version_ge(struct msm_dsi_host *msm_host,
> +				    u32 major, u32 minor)
> +{
> +	return msm_host->cfg_hnd->major == major &&
> +	       msm_host->cfg_hnd->minor >= minor;

I r-b'ed it, but there should be ... || msm_host->cfg_hnd->major > major.

> +}
> +
>  bool msm_dsi_host_is_wide_bus_enabled(struct mipi_dsi_host *host)
>  {
>  	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>  
>  	return msm_host->dsc &&
> -		(msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> -		 msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_5_0);
> +		msm_dsi_host_version_ge(msm_host, MSM_DSI_VER_MAJOR_6G,
> +					MSM_DSI_6G_VER_MINOR_V2_5_0);
>  }
>  
>  static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,
> 
> -- 
> 2.53.0
> 
> 

-- 
With best wishes
Dmitry
