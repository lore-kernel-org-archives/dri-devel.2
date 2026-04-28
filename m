Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7693FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138C410EB1B;
	Tue, 28 Apr 2026 11:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GezK6A7z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BgbHS7uW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7068F10EB1B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:32:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S8qXKg662982
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3kneWNrGg8df0C14GIVpb/xc
 3dEydoRSqCYt9jI5CzM=; b=GezK6A7zRdMiozihV2C5gPMjmyGsahgEaroITplR
 pRyXTwnF5bdY+3AwI6eT9eqOqV96WrxnYB34d6SevQ+poLQbcoz515FoViHLaaqC
 MndYdUBMb6P9iJtM5Juy1Ns2sQExkUgXORJ0oj5Cm9NK2D58sWTT6cpEsx1lI3Xp
 XybwrVA1jYbpw0VQurcZlHgayuYkt8eJINLL7NmZIR4zYc8aygI6QxqksswZ8YYm
 UEdLBRWv/cYMzhlI+xpoMEsQKZMDbSgGBjhzmHdHBeTfrEAnLzwc29svQpHdGq4m
 hfBJk1osI8aezaZMYn2Pd631MryRamopXIOLOgQ0rITyVw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n3pm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:32:17 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6130270a5f1so15478773137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777375937; x=1777980737;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3kneWNrGg8df0C14GIVpb/xc3dEydoRSqCYt9jI5CzM=;
 b=BgbHS7uW+4eOSCFChsfzAUu5EH/vUU3rzXNHIMH232lx+IZoZSIdkPBANasVze3yCd
 9TgUzMDsK7Wg+YqpFVKqroaWgtrk2T5g051+0DTRvuPl172sA/lCNwsBMEHddbz3F4zR
 p6p5HybewlKsLkmX4V7N5aUU46Y/U+BO3+KKj/wFVFMIxYirrG+bqjV7ANvUflspNNP1
 QTBAYF41irB5UAX0i2ZfO6mg740lhSfl3Zv5Yn9ezR/y2H/PczJbx41heM9tRl75vXRI
 cC9zwsCCaigraA1rEfVS8smr2sr6CERQOWfP4ffkacrKUefEakx0pMW39ArjsJpMahmD
 J6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777375937; x=1777980737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kneWNrGg8df0C14GIVpb/xc3dEydoRSqCYt9jI5CzM=;
 b=rIzIvLEGAhBeqth+Yjo2ch126UAVDhcB8Y6Zf/vJC3xQ07sm2yATdOINoWTPMp0G2N
 OoOAt3JFAdFinA7qaOethBocMvN8BV0FwapY/iLQ+HeoaY7OM9+Cc7sUZ0sEqOwDWzy0
 AwoICDu0fM06cBZEntnsylgOkiblL9URMFKGfu5JvKCU8rrOwlyclO8mNUkWDrdY2IL3
 lSKcM2fJlhorY5RMWtfJmJO0/mQ6zxNn/2kO86T0n+SxgcVUFWBWnOBPdcnWLTNN25BM
 2E20BX6h4ba8ynB0SE60DgwpciLjOf34W7vehNu/oDHjKPTLjKR1bPCrJecOEp8LytKD
 xe9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/pA72CsGT5dMJ1xDdQZbVNDG49TaPULPWLIR3A6+mJaVC6S2DgtpzcQ17KTN/2VVnHk0v2lAicSs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhxeeVM5U0Lbp9NBa6YfF0RgpZntqudbo5C5iDyh+zPbTcCvst
 f7pRrhH7Q7Lznl5nqqXQEar7fixRnESdmaJhEJEZWTHsyM9J3mwLIr73ft3FqObh2WuSMY0l81R
 /zH54IDcZ5QuEDM3YE6QRQPfzJvCTHyYQXcSMUSAp1vOGNOTSTQNJQSA5VvTKopNh4EA+Yac=
X-Gm-Gg: AeBDiet9kWyQrk0EB1lKADmYpvEtrV5XjSDLyzqPTw8tCa4kigZfrkV1k9kIt9TwHOh
 F2QIz1eMGS554Ti5kxnBVvddQivppzkeZ+3PXTJtUoNzlT7mRcne4vtRWCwB/fLuKv1uHHeGagL
 gzc7HncFUylYzp83bRxBenSr2RWJRjjalIFcOkkC8uGRpXWfbI7toRKJJH+3ajMWKjJdgnInA2T
 yxxslbAF4OP99juda765NScg9afQP1xG446riQatn0ocJrwi/cNZvdfbDq+d7suT/wiVS3vGy7I
 bMPpI0CazbwFIEQtwqp4v3V1fYTf1EWtFW2LCUFLPIV9dr0bRhXk22sgjSsVAMk/mCkt8kNBZoO
 +ziPpwtDQhVACSPeATTjmzJZc21+WsYcQ9qeHxVDQ6Fl1rQuv4AVlNMBnlcc+trjqZbDgX9ZG4Y
 GccWP6XyYFcVVO7K3/vVNggD0JhGPnExTkAik4GeNC3nAOIA==
X-Received: by 2002:a05:6102:149d:b0:602:ba51:5235 with SMTP id
 ada2fe7eead31-6280bce3630mr918497137.29.1777375936576; 
 Tue, 28 Apr 2026 04:32:16 -0700 (PDT)
X-Received: by 2002:a05:6102:149d:b0:602:ba51:5235 with SMTP id
 ada2fe7eead31-6280bce3630mr918465137.29.1777375936001; 
 Tue, 28 Apr 2026 04:32:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a746408102sm542985e87.70.2026.04.28.04.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:32:15 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:32:13 +0300
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
Subject: Re: [PATCH v2 07/11] drm/bridge: lt9611: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <bwapq6qstctwapmp27t3wo72bzi5fluojzhye55i3fetv3odm3@dzt7336l6wb5>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-7-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-7-4300744a1c47@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNSBTYWx0ZWRfX6pQ8scBkEJ7s
 XAdTw6G5thu1IZNIPOQipVtf/+n7/he0NjPmNLzwS2B877TSyQGjw9rlOk+UA+kaNRzYdzh/Gom
 PMORxnjmeB7R1iCCGV6xGbKwVQZtGjZ0+CEqLSNn2i/On+TvsZhbdgQoafUwPmvgfo15zRy7o0z
 Xa3Pl5QjNq6tFaAFnUMZ31CfmNP4sGdOhjwlH1Otx5gcbLjF3UxOJcclrVBb70G8fpfeJW55fBS
 DDxr4/ZxFDzPJpr7iQDjO7Cj9/r6wdHnWLyTO+Ri/JGW0ufX8uPHSA4oPLOOx9K8J4UcJx74tJE
 dIb7H8jnsrGa4ejhDRvO2YJXcjAxwNNnqzE/u60aYdKRfBuBrY1oX4vpY9nH9cBRGaM+WSzqIne
 uyRtQelHmuUXgsup/eFN6xsKp2YqQnCWzbnVn5eAcKnoAdkyazDt/rrrydbauu5WvDU8v/gCqmS
 9+6xyZGIjYnBLg3gd/g==
X-Proofpoint-GUID: T9HyHbhdDSnO0M-4un-ltDYnR9GBbpW4
X-Proofpoint-ORIG-GUID: T9HyHbhdDSnO0M-4un-ltDYnR9GBbpW4
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f09ac1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=QV8Ls2YxrGuH4NUGU1gA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280105
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

On Tue, Apr 28, 2026 at 11:15:53AM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal. To achieve this, instead of
> adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> pointer which is automatically put when the bridge is eventually freed.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
