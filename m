Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BD7F531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F2810E4FE;
	Mon, 13 Apr 2026 18:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqM8U2Ih";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlswyAaJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F0910E4FC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:18:14 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DH9YO02231027
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=12XNat6g+cc/zIEfoBGBX//L
 TYgOYu/rE8OpssDOmfE=; b=VqM8U2IhfULeH5BJ6dCm3pLntcvpyiM73qIS6SVx
 oZmOYURgSAaeAeCUYSCTh5YsTe04/NklpiW58RHSTCzTSZgKa80PKvmAysuK9Zbg
 +v7MgjRC9PkR1d/lQJUlxaZ8xC3+ptW0melopkf8/a7K0UozeaEHLc5tED3eHYr0
 wCQSjuWGVxwYMPTxBWnZEavafnSULeJOZGnnMqdyEBs6ONbhHTiD+HaBetzcJtn8
 x9B36+DpsktHyIt/6AHFmRJr6rZySzfsWgllm8EOZWHQ4J2F6/eaWJHH6e1IDMXU
 F/ojMPh0FjgDTSl1PX4BU2rQ5TwRX3Vx4VWBiHqQEx3wGw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dgxt61qum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:18:13 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-61010bc9c12so425349137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776104292; x=1776709092;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=12XNat6g+cc/zIEfoBGBX//LTYgOYu/rE8OpssDOmfE=;
 b=PlswyAaJJegrajh/1SrCnxbBly5HENJbj2KXebDMY2pWBBGhhHtcLUDB+E9LZXWwlK
 rcpwZDkr9RSdkY9A0sOjWMj3x0uwEKfNjwIBEzG1tNknm6zQFa0K/CcGSnbcHNPN3Hqr
 PYJ8XvJxcU6NSXTWUIIuk1EMgfCiJCOueTbTs7rnxf5DL29MrxAE5Ownr/6ozHIG6WTf
 5j9cO0q4iJrh9E2eue3SkSMKYp19mRtPhIR5GTjvQ7F193EKH//ZzjfnRMqCJxr41s2Z
 QPZNNbgk3fvML923YSeUtKAisLfkVoRlCKVhx6ZuDN0nxIcRdxc5hHqkPhhJ5jVlDmzn
 5t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776104292; x=1776709092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12XNat6g+cc/zIEfoBGBX//LTYgOYu/rE8OpssDOmfE=;
 b=a9ikaWuJ228TDVigMSZ6qQwiCzxmvBMWLXI7wOQxNPs7pNd67iGcCrTTsq5IIOsFky
 nsqD/bAi8NG+9Z5ULOcdb8Vk1dlRDwOXfS+gZ1LMJgFcGxmST0Kt20SFXE09eVR7qjx+
 lr5e+jZl+1WAmwRzwjhpVI79YHWZIbz1FMBPWLBYlkX/MuOf7XWO/HYFWff9FrkfxNoO
 FbAe1S0zishWFSbf0uO4hLhVFTmjDrIB2NrmmgGYiTBwcJQAOn3AGrXFw3zmci+BatIm
 IZcKz0Kpn2nJCkexOCDDF5ph+Y4ppjyzlAff5bdv16Qv1bQSMooJBqf0vi2/r3g7H937
 t+6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Xbookaaea9ajy4F+UlNUx4t+a11bVpUJumvGqZ4a57EPQFA2mnntTIiaNvx0fp4Wpu2AsZEBiQHY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPT17imjXARtmqie0TvhnD0ktdEKjpCY045CihNRlZwrHqiInI
 fH/ON4c8WkdKfkTubzstdo5/hs8x1CcuH+t3ooTcZVMfQjKexkF8eV3M6B+KP6aKC9SwQFoA8BM
 kjCbqZj9wb+ocGJyrovf1j9FJgjYmxI5Aocn6GW/lLT80rei4LrI9oGUG4Xy9Q1sx7QDHVQo=
X-Gm-Gg: AeBDievWgHrEljpF9mhSsYk/szUkV5hh9sVGWpd7/O/NsAxXBj7NnPFYww5w8AZakDQ
 PCcAGQGscOtk0mol7rj7+2cxaZa4c6UjLt6rT72A9kA/ydF/f84nk1h2avCInwwWAhn7N/W3tW4
 iwJPX/7YiVSwzsabOpfHKQxNoQy6CMD06aPWTDkU+yLdcTWt9/h+7ye8Zbx6aZkZNm1470sqHY/
 u2mLTeKrDbl54ET8/Cx8orA3/HXwPSdPclIRXJPXwfgRPSlrDReQPPCNCeKKfltw+qcrGk5nBxs
 OltV+is7aOLZMjwiiaQPcjykMOtYTNI6JxQ+TSH7LrHySNYmidZJuTVN2CXdcjH9h7PxaVZUrVq
 VnMh6ZqVxVJL0IrMcWg4lKPC9joeLqO6BLkd7eaj2SB12jpEJFWQwsUGHBroViVi9GkX3p1e5TW
 vJc7EPDuxJKxKHvMiCHpWUNOvZQF4q7a4P4Y7Py6YjCXHvGQ==
X-Received: by 2002:a05:6102:c02:b0:605:5756:a515 with SMTP id
 ada2fe7eead31-60a0062cd7fmr5486858137.16.1776104292559; 
 Mon, 13 Apr 2026 11:18:12 -0700 (PDT)
X-Received: by 2002:a05:6102:c02:b0:605:5756:a515 with SMTP id
 ada2fe7eead31-60a0062cd7fmr5486820137.16.1776104292046; 
 Mon, 13 Apr 2026 11:18:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49298bbbsm25262411fa.10.2026.04.13.11.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:18:10 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:18:09 +0300
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
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
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
Subject: Re: [PATCH 06/10] drm/bridge: lt9611: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <ojinrxfmkxrakyczzkjx7wvx3je34t6emnr5ux6qbl47vyuzyt@3dbq3llvysei>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-6-acd01cd79a1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-6-acd01cd79a1f@bootlin.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE4MCBTYWx0ZWRfX5iZlEz7pSJPD
 t3BI85qGe0CFPmLUbucCHUHVlsH2U/MaMTqMO4PuMEPRv+0CSDuBuGHaH7iiyEblRD8Ir+GknzA
 zBNQpQTbWdz0yChT/LYWxTrMtabHFr9XnswG9YYgAfzpAdX5PFk2qq2A4q7WOlClsEc7cijRCog
 7vk/RcdnZIzgaWZ9CZRNVKUjdgFBF7tDo08G5UH5LWp0SfscT8+tDPl+4O/fejoXQP5UMDfKcvv
 k6Av7zT5DykwLaWF/plfIuIjQMd4b5LCSs6I+6o2bgCfxmJjN3hZfvsCxQRxZFHD6SJAsRB1Uo8
 ssvyNdhOYKuuT0uYqKFpyXYJHxUaM+WR/lZdMm5aOnPBO2AGjusuOgzyVMaftmhfyue+BWJobdw
 yZnxYL71GLEk7mORB9hN1tzz2O+vpW++6j9YmsO3GWrUtM76P22/JGo63r7OK/QcnuN5/BSlXS7
 nvrBsvhEn6TcI43ME0w==
X-Proofpoint-ORIG-GUID: D5ZkIHJA4mq0YYb9au5SI8jboVur68Gw
X-Authority-Analysis: v=2.4 cv=br58wkai c=1 sm=1 tr=0 ts=69dd3365 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=sqxsbOWVCbAVHG9YZwUA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: D5ZkIHJA4mq0YYb9au5SI8jboVur68Gw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130180
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

On Mon, Apr 13, 2026 at 03:58:38PM +0200, Luca Ceresoli wrote:
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
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
