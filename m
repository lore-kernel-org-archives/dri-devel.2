Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8624FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3968610E029;
	Tue, 28 Apr 2026 11:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zzdt1xeZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AmcK1Ad2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECEA710E029
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:30:45 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SA40093275300
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kLXO0lfyU+XcYQwDhmvBELIf
 QT2ztbA8E5R4omjgiCQ=; b=Zzdt1xeZzWtTlz491A/UL2+x38bbtZYoavONT5xa
 Ywrxd4JDyGvzPXJTjKL8+Xsg3hvRObybKlx9+DElkHUBrn0C82dNfOr1vmCMxYww
 P2dEItfHO6m4owRRo9L3XadgneWcHyzk+LWR3QVwyu1F2La+15RtC4gRm+E0PVO9
 q09VnWcBROAPQbD3Idv99WNTQi1alkVaGcvSfqxK2Sr2EYISlqspNDVqhMAKns1X
 XTpuoIR68xVlap6s3wD4GY9Rd6iKIpZWApA4QpiCq3TAkrE3A37g2VFIj5CLW9vJ
 Bz9wUU+qZNXM+V3JUWvhaOxk9X6KrK9klaHNbTDg0kXmYA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjg9ga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:30:44 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-611740c0b8fso4704189137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777375844; x=1777980644;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kLXO0lfyU+XcYQwDhmvBELIfQT2ztbA8E5R4omjgiCQ=;
 b=AmcK1Ad2wX5vwubCf02Y3kl03P1EctIMmxOtpSPG40hgIuSZYHMm9po5uhu/Bwlpcv
 AKa3FKxV+W7ql9DzQCtNz7peCBwNxVKX62ztX5YlbOf8jHfci0T5VwlmuHklAYXv0/EG
 iqIuWsSU4Mtm7l9pQ+Ul5o2wQP63u28ks9QBAj9DpGFlEp3ZX77DzSrMSrez7M/3FrDh
 weAnUv354CiHLP7O+29ewWPPptMm7D3XZf5t+qMseDi13cpWkx6d9IptRC4vMIkrF7sp
 Mt4f77ngvw5R/9kM/8MWPvl0FTty97qnQEhywzRSwit4FdOk8d5so//Fo7tkb2TTxRbh
 xfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777375844; x=1777980644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLXO0lfyU+XcYQwDhmvBELIfQT2ztbA8E5R4omjgiCQ=;
 b=gEypIIKODCsP6jk9lDtpTwxbfJhl9j6QQ33PP2af11mCDBZQytaghQTtv49urS/ceQ
 IaoU4WLmaPKQTbNQ0uVC/zuY1hEg4Gzc9C2kK+yDSQrp36/G+LLuEQdWJmBxzIW8SACm
 jYWP7bWMVdNDECgtFuYiG4W06DLS4tkzGGGjUEvUKD/vdt/t+zodQaFx1SYD74qtU4aD
 7qrMOw+fnxa27yA9ewIj/geT5B8s6zpjfR4S4FLC2QVncKpj3vBNRNix7c3Y00PuGKtW
 vWznLzIPZXQtHZx3/Uw9dBz8oZuCRSnZBVTAtoARBIuf+bmUPyx+4g+PSvznEGAeyU49
 vGpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rSR3xWuZUON/Tj36LCjNEbvgEp40YawlTodDCjPcQ8KPqu7kekFXtKVHmnGwLcNT+d+zwzM6rtwU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytdAXjVRlbnKaLGjPsYI+pRwiOlGzNkGM9Rpx45KB02ZyW5rYT
 QScCJn7TPdrfoWm8UwXgibSOU9UUdaA84aPxILdYBZSP2Ko8SX/PVjZAcDR4PYqH6xoZ4rX34/g
 cE7iNFtAI40W49Tc6iY5FJQpdhgq97n+THyfn+N6TmdJ3I9gCGSnl+7TjI6R6OeW5HJ1cZV8=
X-Gm-Gg: AeBDieslw/vv0npXJiw02q2b7ptFqwsWsz31TAcPFWM/G/iGnVijOu7VDe26Jbbfy0f
 GJdbHzQHZW86KkPNr0pTePqYnC2mDCtLSGiH1XPlkrfAdf65uLd0ocV+rs2u6jw65Q9jDWrh4GS
 nAV0euLwf0F+0MTZLadNptf3q862W7TbfKg6NmiWPbDMB+a8/xOzGFzqXmOp0bNwCNBhZDSn6J5
 GZN37v1MmYzrM4zTuuz+MrnJJFY3B1QHQMMXIaichi6sZB1DOVLGGuYu3qRe8MJ7Hv616R8ia5N
 f5yr8RivVjnDVV62XcW4x/XglHxT8HDopV2ASyRFLX48tIY0ltlTBicOlN9/TAu/wVgPlWMRJFj
 LJ65sOsGQdQ+SomoRzf1cIFyEaCNpEvblwnRfYL3UeB1dY5w39Y2PX4TRCYaxrgz7DfZ0yPyxRP
 4Da8qH5lH6zGVFrgunCigT2r73SCUEG+fCS1bee6+x0WJgzg==
X-Received: by 2002:a05:6102:2c1c:b0:602:7a74:fbbe with SMTP id
 ada2fe7eead31-6280957715cmr809844137.9.1777375843986; 
 Tue, 28 Apr 2026 04:30:43 -0700 (PDT)
X-Received: by 2002:a05:6102:2c1c:b0:602:7a74:fbbe with SMTP id
 ada2fe7eead31-6280957715cmr809797137.9.1777375843385; 
 Tue, 28 Apr 2026 04:30:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f2e3237sm6235331fa.3.2026.04.28.04.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:30:42 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:30:40 +0300
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
Subject: Re: [PATCH v2 02/11] drm/bridge: add of_drm_get_bridge_by_endpoint()
Message-ID: <3csl5orvlakqg7sfqhitlrnag4u6onrs4mvinkezxyxdw4whrx@ee2hrdhspfn7>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-2-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-2-4300744a1c47@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNSBTYWx0ZWRfX1EWEHQXMSApI
 2PXnt2o0ptClnOcokCc7EtV01NwFzjiaTeh9Fy77tx+O86lEuzznFmqX2NlLUua1fITVniH3WPw
 n1SKWYLxAuERhZm5MthEiceCJM6qycl87CnVmu0sXUK28XySsG8+yf1ifcv9GWg01646y1YCFEn
 EB8MD7jbg7PBiYBnnYmtmyhNVFJvM58pKnZBP7aT/YuxdYBV4u3RevDKRyFhU0Wj/HY9D/kSaB1
 cEJ5yBHyGem+8z/J0UNBO0J0QXDwork9sVSHy4LTmfQVkoOflGJ3lx6QBOxE8SmdFFlLZ63J41W
 XR4xr92rO1pGMZsXWiePNZW0K3mabPwvcyRP1FUjHgeptaHcgU4Buo0cOial1eJfTPoU9+RKiOd
 f5uEKwONteYFiPjcX3UFPLI2JtdkfWV/zDuezFk2nDCW/CGSq6bmAF7OCtk9c1eG9F/KJFhlVE0
 oPSIqZLja3vyF5BFrTA==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f09a64 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=cIC2YJPMRTRrWvxiOScA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: HUqfzolBzrIF-f7pcnKnA_8iILDw3Jk9
X-Proofpoint-ORIG-GUID: HUqfzolBzrIF-f7pcnKnA_8iILDw3Jk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
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

On Tue, Apr 28, 2026 at 11:15:48AM +0200, Luca Ceresoli wrote:
> drm_of_find_panel_or_bridge() is widely used, but many callers pass NULL
> into the @panel or the @bridge arguments, thus making a very partial usage
> of this rather complex function.
> 
> Besides, the bridge returned in @bridge is not refcounted, thus making this
> API unsafe when DRM bridge hotplug will be introduced.
> 
> Solve both issues for the cases of calls to drm_of_find_panel_or_bridge()
> with a NULL @panel pointer by adding a new function that only looks for
> bridges (and is thus much simpler) and increments the refcount of the
> returned bridge.
> 
> The new function is identical to drm_of_find_panel_or_bridge() except it:
> 
>  - handles bridge refcounting: uses of_drm_find_and_get_bridge() instead of
>    of_drm_find_bridge() internally to return a refcounted bridge
>  - is simpler to use: just takes no @panel parameter, returns the pointer
>    in the return value instead of a double pointer argument
>  - has a simpler implementation: it is equal to
>    drm_of_find_panel_or_bridge() after removing the code that becomes dead
>    when @panel == NULL
> 
> Also add this function to drm_bridge.c and not drm_of.c because it returns
> bridges only.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
