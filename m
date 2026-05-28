Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59DCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9CDC10F37A;
	Thu, 28 May 2026 15:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tw7EWfSF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hv/TI1dx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78AF10F358
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:22:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8wM5k382529
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PEDqP6PRnD4f3w0pOYnhKn4r
 OzVoretJwgoZHP7f+y8=; b=Tw7EWfSFFA0va9E7Sln0BwnmKyNm+kMw6d0AyuNK
 xznaaxFnEG+XAew3WIa8LiCTIXF5wKPjd3/cF4CAjiRU+4cKdEsCC0DvmaHmQc5S
 25GAMJOoCx+RhlAAknYGOGk39tEg1BMJPCCJA3sq7rQpKRf5Wsj1BkcFPkpQTI7a
 1lYROLTxnr9k8UFyggCgzWS2jFf8JvqZM0/kNsJkLD8Jfm4kabZqjysCkzR4itAw
 FQ0yHiQCbpb/Kxla+VENdjzXUngT8YZng5k+T6DZDEsZQwXQ9E+SdI/qU9B1OH6m
 X9qF44+Pw47t9BZkTWxENiCeNENHulg4fNqs6YgCfDHTYQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yrkbas-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:22:59 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5753ef2562aso9020096e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779981778; x=1780586578;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PEDqP6PRnD4f3w0pOYnhKn4rOzVoretJwgoZHP7f+y8=;
 b=hv/TI1dxtMZB0qe3AY+g1kku30Ai9aijmDLDsXy4CYCrA9iY0rLf8UxKBJwQAObpUk
 05tQlYvtiWetLFoGlWzOBVlt/vUS6lHCbQMQ42VOQSipTe03NuI2fHPXCN6Gny05Xqda
 R28DUQ0hR7/g7hpZiu9KqalC1L4TGsSD/u7UfAu9jl8YytwzfHYrj9CQmraxBiWjEM+b
 c2MrzhmQr1pH7kbECKN00XR/jppetpCVtrrcxXcK6DEoucZgVip6p2lO4YKW7BGqnNwV
 7sB6apI0Zo3ouPiumhSvZ+laIcgdcy8iM+f4l1/GboSYrUlmgI7DT2fqjQdUO6sdmcMO
 cpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981778; x=1780586578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEDqP6PRnD4f3w0pOYnhKn4rOzVoretJwgoZHP7f+y8=;
 b=FcLTmAHxocnT6hnkE0/ZwcNC5s8H1NvvwJw64a+vI0KQWKmRvnngz6NU+DKcEm2OTr
 /YCxBq64/YykJ5wAHXN/4Z7Xiq4ljGMJSAS2yEbRrCXsS0Ikc0GXoagI4Cr1QPVF6QuB
 QmMomS0KErIWgSzhLiZ5olpTIOUvbsbVB9/qG/zA5QgjkLDplx4KU4/1Q+9jvQw2zE/r
 itAxt37RVCR2GiAMijEHcvRJVM+1rJ7Cd8KjBuCToZgzF6Oh1+GXR3G0DXoEZUQaAaCs
 zS+lK0ciD6oxGjbcliojYaKCg9c1KxNksvAAiljh1xV9mtrdeitnbttoMi/UjUnwZCZs
 7ncg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/04zzypl9NSB4sdA6+FD96h+V4XvasHHBCQaQQa/PhV1YrCx72zFV/SLfnri/msqn0hl+pVy2H2/8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyu6FCyTqinOOEfSxmFkhRq0F6znMpnfnt1Q3lzmCM6/krz0MjW
 1qEnmomCLYQH92pAEXEK531+nW8fySOtnsyHHxKPc6YonQReU6pBVv27aHLWvLprUL0PI3XiGjN
 5e9vIB6XHAxzUOoa9+uhWsrtRYDVwO+YwjkfqoUMgGq7ZgA+FCgmZO0vdlCiOaa4EDpQiltg=
X-Gm-Gg: Acq92OEjYMXLfnvbylKzmZxYxa1jOZWYhnBTUmWn3P0p7X42BP+mITBBFiO4J6Ayjy1
 xXvooXifXYz2Rcz2AZ6W6ZNzbdTxzQ2HIRLb9sYWaZlsUUqrwqGvXKn0lZxeImLM6HBikDQyn6L
 ngWoeykZxU+GJl1M1zwgcyVKgx6mowBlbU6IXW1E/qhuig+1Q0s30gJiCMzZi7ACc/tG6eC0WLu
 ygirXv/lhwWDUIyJuhsFn3XbQXCprMEdEQse32sVdPidY0SJz844v+oMj1uZVzDT2LMyKqe1RqD
 q28U10N+LMMUTUUdRpvC9vAcUi26i/0WdjT3SWlRZMA1SqiBKGBxol7+eoue8PxYbDZByMJguot
 ozplyd7M/1uW98mSt4CPpH9flHbX43om91vTOjP0FLXCodQV1ggEHfI933Uipw63rWLy7g8s9m7
 NzsgC0xbSFgL2WCqpsJJXZcNLJQHUfcdydjq4vLBGYtpm6tQ==
X-Received: by 2002:a05:6122:1ac9:b0:56c:da22:6921 with SMTP id
 71dfb90a1353d-5865f621e09mr15145956e0c.5.1779981778024; 
 Thu, 28 May 2026 08:22:58 -0700 (PDT)
X-Received: by 2002:a05:6122:1ac9:b0:56c:da22:6921 with SMTP id
 71dfb90a1353d-5865f621e09mr15145915e0c.5.1779981777570; 
 Thu, 28 May 2026 08:22:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa4634d472sm2009767e87.77.2026.05.28.08.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:22:56 -0700 (PDT)
Date: Thu, 28 May 2026 18:22:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
Message-ID: <nop7uyplq643ps4naczmrqhukeiuvfxllutmaz2sbohrnxk6ko@pr7emfe5panj>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
 <20260528-dp_mstclean-v5-4-a9221c1f1f3b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-dp_mstclean-v5-4-a9221c1f1f3b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1NSBTYWx0ZWRfXxCJas8W7/J6Y
 Ep2Iclt10no7y1xtmuv89FldpW0gk+Xnlk5cDgqUvrzqXA+LBPrk/kSeywqd1AMw26vzj4XxjM+
 sV4HgyAYegmcZqTGFtW9GsCsN6n3bqKiZ9fgGK7EakjECCsq/kXetNGttG/5mCy1JRuNKUopazm
 H8B2Nixig8oYZkJYu4KAq9fM/bTVA6dXuFTae36NU6ieBpkatnUCM80UmiQe09dPTwtHxeYswV3
 FZ8dwdbD7O1M5DzwweP6MjY3/Ic42cG5FNuks6dM7G4d1734JShKTF4uRT1VIp8SOahFWf8IJGl
 rLqnisd+ntiTvP2hidWOrIulqGFgChZ7HwZAJohU6WPhaYimB+tacdIoQIoNhViAInqVvwHWX3I
 di/2JCc/mCQoQaaUUdAyhG87OQIv++w+KOMqHE3w7DDX8Pee15lcbDkK9/rWv+NcWhNbJgoUS7N
 eGlejXMVC5w+9EP6xFA==
X-Authority-Analysis: v=2.4 cv=PLo/P/qC c=1 sm=1 tr=0 ts=6a185dd3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=NxVLH6Ql9juLhvLULPkA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: lh6DwKj46xHx3NrnwlopIPIicKSx0N_L
X-Proofpoint-ORIG-GUID: lh6DwKj46xHx3NrnwlopIPIicKSx0N_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280155
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

On Thu, May 28, 2026 at 06:40:25PM +0800, Yongxing Mou wrote:
> The DP_CONFIGURATION_CTRL register contains both link-level and
> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> all of them together. Separate the configuration into link parts and
> stream parts to support MST.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 47 +++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 86ef8c89ad44..cc00e8d2d6c7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -388,26 +388,45 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>  	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
>  }
>  
> -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
> +					    struct msm_dp_panel *msm_dp_panel)
>  {
>  	u32 config = 0, tbd;
> +
> +	/*
> +	 * RMW: in SST, config_ctrl_link and config_ctrl_streams are called
> +	 * sequentially on the same thread. In MST, caller holds mst_lock.

There is neither MST nor mst_lock. Also being called on the same thread
means nothing, there can be another thread, executing the same code
concurretly. Please point out that they are called only from the
atomic_enable() callback, which is guarantted to be executed once at a
time.

> +	 */
> +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);

-- 
With best wishes
Dmitry
