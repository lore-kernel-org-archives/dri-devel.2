Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DFAFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0946710E350;
	Tue, 28 Apr 2026 11:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQ5hqlpD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJAP0ZpK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065CA10E350
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:31:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S7kWbR440715
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=e6kbSqYZzJcGS2gc3yj0gG/z
 i1Gf5AJhMNDlMIMu6Qc=; b=jQ5hqlpDoI5BgghzDD08b6QhYBNPnGVP59FNl306
 RKI4JmoDxQR2wC7GVpKTCu78SEiIPsFPP4UQybMmKVR0No4kDAOvDwk/fQp+AwQs
 lbaZ6d80X3JWDXqFIJLGyBiLLyhLS7dzfryR5dbIiPcTx6ahGVYsnJnkss1v2KdP
 MsMRubDrpKOLP9yHj582DYpcqyP9dmBO4sAr0MB9HBWPrIzaCfeBf2qptnqfPvVt
 +fV+m/tg55TUGIdHToBbmCbWqp4MPb9aX5fQkCVZRXH131IgHgRl+iiBPr2w/+lL
 tqw14LubPn0tZkEOyoC8FBb+Qq0UOvr4ug39jHyNQhF8wg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac445q3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:31:09 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-696133ef271so1819934eaf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777375868; x=1777980668;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e6kbSqYZzJcGS2gc3yj0gG/zi1Gf5AJhMNDlMIMu6Qc=;
 b=VJAP0ZpK1ln0wm6b61kDZwYaCMDSKBL2tvsyBU6VIWYwCqMHqe4qoBcVAeY89tYYnz
 sGdk37U5QEF8sjaYQ212dKSfMWrI2kCJdE3tzvau2NTnsFgr3iXK7hkPWMwikqeIQzoV
 oS6HftGbOdjbVXrzJ0U9OPcmfdTjEYJhRw1lLDPLsJ6eGMNCZLLSEy8l+tN6EIqlEOw3
 XK1FOYk4CD6BQdn3bVj4U95MoJaoTOHHUFuYZZjSiEmUsyxkl3FpLKOCxTGySxj3KIJT
 cRtZD6Rjj4Me9zvWlXhNiu2UZV5iUNnfL8JuHEw160LCz3cT6tS5qDoGJ36cG9Gr7Xev
 hotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777375868; x=1777980668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6kbSqYZzJcGS2gc3yj0gG/zi1Gf5AJhMNDlMIMu6Qc=;
 b=oGEek5ZmQeLca+LJCkGjvzhmHRI0Wq4XA2QeMMf8+mw8/oVf5QjlQ2e036T4HiOgVP
 CjPNtB6g92+WdQVNwpJ9fGDE4uqTRyymS6xiM3wMBbDkF9frhK8WKWIP7RwdojBZhQND
 8b9q3KHfFk6ulZFKfmCSGPgKV6Hh7YTRmueHDzgCWTcDMzqmmjUc1g//YgMFXj78R1si
 Iu8qs2dRnjik2OYQSRW8Pu4vBtUd2ntU/wYXtgXuPcS3HPxkyh2NHSykHA6NbouXqYu6
 qG4bCTSy1riHtkBOqXS/+xpsE3mIBplXf1XcdGmPiFLztP2uUYGZwbE/MJ75ecCspoRL
 VFvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RBOcNkSz6wWAbOPnIg1rVSOOLURnAxPPI4rW6Oi2yrUrzrzDkqaaQuE9a0vDHKKNIld0MnP1ONnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQgVxV86xN4/F3HresY1oGImwQ3ElXSWl1Z1tmNqnzbYBopafN
 BSJVCl1JoGUcNxqovyVVqrqUVL0aJkVeXQAb+5bh38Umtz2vmchUdQUzM/ixnnoIJQOVYdCZ3Lt
 MzQ203LfoD4OZjPZOGEhch86HneWpQTCS7XL8GAHYVNbThKcxZu1d1PKgcGadDHOdTPwxBhk=
X-Gm-Gg: AeBDieuG+AZUcnoMhxgpZsmEqfg5DWh4IpfZMkaZcctS6ix809DV0zgo7rv5yzCYTtO
 R/Ggz/BicDHS4pxsJAT+Zsc8zWhaZAt/FGvLtzmzCjx+17nQrXTBJvmN4rI22Z+oc7ZtEIiZA+J
 ufKD8MMZDqF36m06oNeZTBHRYTz7ysRROpIFbLkDv0Xzh0tV8nEVnkbyqn/ZhpB0OhVz7fPWwfH
 Psrf73nSnZPhUnpf2LMPFIuImVgHmCrbQqyxspN5GSCj2YfOqiV/+uRgake+DwMw3kR9Q6A8BJC
 qts949qejvIdJWNAYTMnete0B2BZncA2a33Nn2lfc8ESPvBSB0BUREjwXJoKhyPtdISyL1OgB79
 cpNYNoCF8FFFhknVdkUBCUsr7JgwptZLwNznHQucW/Y/ZcWAQvwmtiqLazd2EwVAyzmsGzp1ZuR
 r0K5pB6uCLutF/b5nlreKL2NMm+TM/sQrGT3TkUbJabRuPlQ==
X-Received: by 2002:a05:6820:1b05:b0:694:914f:c18f with SMTP id
 006d021491bc7-6965ca69f0emr1224703eaf.3.1777375868570; 
 Tue, 28 Apr 2026 04:31:08 -0700 (PDT)
X-Received: by 2002:a05:6820:1b05:b0:694:914f:c18f with SMTP id
 006d021491bc7-6965ca69f0emr1224690eaf.3.1777375868164; 
 Tue, 28 Apr 2026 04:31:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463f5f91sm548695e87.43.2026.04.28.04.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:31:07 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:31:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 03/11] drm/msm/hdmi: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <4zlmusbxhafoevbprgxempl7yjmhc2cvo2xozlt4yhcnwa247z@ac6xhtfrc5bz>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-3-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-3-4300744a1c47@bootlin.com>
X-Proofpoint-GUID: l_V1pAzvpKMqr_-cshZwqVundzHDDvK6
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f09a7d cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=hXVsb92WUBna0ZnZifYA:9 a=CjuIK1q_8ugA:10
 a=k4UEASGLJojhI9HsvVT1:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: l_V1pAzvpKMqr_-cshZwqVundzHDDvK6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNSBTYWx0ZWRfX8X+tR3HNjyVh
 gHsWbsYZuSbDziG/J6qIHTOzO5Pg614wM29tJnoNDE/fMho8dLB3LpwV/ETEJsdtiRtaZH8D1Wl
 6VDOWbgC6wTlgkggYHfcmKlmRJkHGlsuw6VJhABdVt0C1qTH+wBsi029cqEGDgnAFOzCDCuHNT+
 Lr0hOWJ2siWG+xiZbtKVBb480HqzwLIjoNK+6gvXMJ7TxnSSvb/Feg9dwWBzWIS9Kpofuoxy6Qn
 cwYda5rTlOAB6gcTPJruBBN938BaW/TqHyZjJaqY90cewatZSVYIjJW7+NFGvf3ispmdCm+A4rq
 p+Tn/k+RM9/7MjDtQLSM8Cgi17ackdn3IV5+WGG805ZT0APnT9i/ym98LPOWAXdvUubmKvzb+Fc
 V1oGvlXskn+/kAOeHitfkZe4ShfGSPaHUUVQdRwwCrxQ66sK3xCPsIlYhd625E1YgsP4HsYaAnr
 idEkMsIbA5RUnTayGCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280105
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

On Tue, Apr 28, 2026 at 11:15:49AM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
