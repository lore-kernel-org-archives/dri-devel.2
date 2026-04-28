Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DF3FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D88710E287;
	Tue, 28 Apr 2026 11:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OyQN3EWb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UA2zuWKC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3B810E029
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:29:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SA3tpR2112620
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0IfYo/CntwwiLEZ3vhK+hpUb
 6DgwSIZulel/sENVZRI=; b=OyQN3EWb+KQcCalY6BHyE1R5E2hPeDwMxmJ8AU/F
 8V7UZjBsXJyZRN42PoF2eS8B9zjOGIxZgeEwhEWPh6maf+EK5AJla/LDYRIWcdWe
 V501DxGVW9TmWB9kGWchcKo/mU5priNX9Sq0hD1+XqWqQa2SUQdeaN9733diGFG8
 bl2Vo4sglcyyYOotpnsdzuorcCxmHsS61h1CqopysbFvCHG5PBcPwTfPLBIObTfi
 k/tRzyGTpLV2YMh/Q98GrI2obqf0M6GBiSM/PDn+b6CepvqhkfDp4rdJtmF0Y+6L
 UpdyDGZadi31engSWxL/MEeH7Voied+sKh9mVtEVi2DqmQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbk941-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:29:43 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56d9f191b6eso19100453e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777375782; x=1777980582;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0IfYo/CntwwiLEZ3vhK+hpUb6DgwSIZulel/sENVZRI=;
 b=UA2zuWKCjKrsgkm1wFuORxJbZnvgnA1W+6aU3Obc4nS3IyHcty1/lqPGO6ucqsfbFx
 o3aU6XU5tVluslTw77XlGpyelCqvZoqcuuO1Lf5aTMLr0gMDX6kxj3S541LWwYKlxgnF
 wt8Frh7wzWtHh5Q8GOyS7RdIUrl4C4Qgli1uG0+vSULTpJjxT3JrgGD20m+PkeHkLQwI
 ax/fT358syKLFeDux0xvVHSOr2bmtVM8vFt8S3WXiGmlsMn3tkaK3VtWS8Yu9icA5zQy
 zN20HCViA99ijsviHfCyXApFKaMuliMWw2WyifD1l7ZwMcvasfi/qP98iJahzdU/1eHp
 4xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777375782; x=1777980582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IfYo/CntwwiLEZ3vhK+hpUb6DgwSIZulel/sENVZRI=;
 b=GU6H/zWVD9IdaDx7zDhg+vfMu9c/RosdlTUq51tzPgjkyJlas94yzlm/AZGv7RkrK9
 Z36/EOS2zjfG13z7KStAJQaXYxVLLSAH+TZXMllGPzW10BoATq5dUz7zAPYZx93jWW9t
 UNO5c3YYQ2wlJ/YiCjEaIV76q3vuOeKyu89jybAgd2uOTo1/12YZiX1s76flsUfUfxe9
 ZuJEAeZR3piF5jVSsJnx0n0cagLKxkZ2pxudfXJaSBJXJgDe5PVBRa1tJjyqbZo0Yaz2
 8+0yWaC4ryGy3gfvQ+a1P52TJAJr4klm+DbbQMQCXddelMJhGVq3dvA+xaHX2V2NYiKa
 6M8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R18VNL+uCPSsmGFRX4SHrQe4HUEQ6oVitGaI/Iy8i/cZWJkX15ajkmZC7yTNw6O3QIkzSJiptwb8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcjAGhf2Bv5rqvbDXAzyquQaJiJMsQ7XGCx57kUoP6rT3ArxEv
 fgD5DUpFLX2rTwcJuB2myh6R3px3Psj9faZAWYrojqfyR6yhTYR4Xv+thFEre4RyAKBEEwyYv5Z
 QQ2gUp2uATEkKxc+4V+ozTGDu1mqSY418w6zpxolbdLpBZOJO6e6P6rT/2+VmqmkSDJCfTXw=
X-Gm-Gg: AeBDieta/jWNakUns07onYCvHpJlF6LF00gytsB0WjpoHDyJLRtZqNDnRlT/NskQSCq
 6qEzTqrrnMI5xVzCop8xeA3FMWxaNj9uPdF/13LXISJM+5nNxTvXIOWZ9dmrpG1TxMJ6Cj4Ol5N
 cm68Bz+A0O37GF1QIfAWecBWNaY2GVvBElzUuK9YMkErgmUjUZCk9iqYmKwBYWGZRz0EQmWC/J+
 H7mqqayUJvZpYDm8lyqpdjki5QrNTzqZyrkb9HkgN8Y4hOcyl4KljXA3/jrK5ilMh/FWQ2g7ELA
 O3/yUs+v/e1xXEVJ+c5VaKiVWkFGiSzBZPNIW+/FFQr/46Mj4W9953uvsXDSaHiWA10DtO9q17s
 1k7dUlUQ/U3ixX4x+B2nUCgbNcjDx5eUV8ooUCkaIeOvFvK97y5M6UJQesS+W7K9VDGSHwm6r03
 2iL9US8eMNgv3kOGcUUSSVza5UhvfJnWhVldJxiQrfAub5kg==
X-Received: by 2002:a05:6122:f90:b0:56d:b4d1:3c1e with SMTP id
 71dfb90a1353d-573a56746aemr1116954e0c.10.1777375782215; 
 Tue, 28 Apr 2026 04:29:42 -0700 (PDT)
X-Received: by 2002:a05:6122:f90:b0:56d:b4d1:3c1e with SMTP id
 71dfb90a1353d-573a56746aemr1116935e0c.10.1777375781729; 
 Tue, 28 Apr 2026 04:29:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f2e0f5bsm6739471fa.1.2026.04.28.04.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:29:40 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:29:39 +0300
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
Subject: Re: [PATCH v2 01/11] drm/bridge: drm_bridge_get/put(): ignore ERR_PTR
Message-ID: <vf4ddg5retquxjbzqueligpbfhweuwgmqnm4y2hmla4air4lx2@ubi25fqbxuar>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-1-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-1-4300744a1c47@bootlin.com>
X-Proofpoint-GUID: Z6RAL97d2rFlUyBR0koO_ha3IupRF50G
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f09a27 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=P1BnusSwAAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=lmVp1xxxIbapqg5Hp4gA:9
 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=D0XLA9XvdZm18NrgonBM:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: Z6RAL97d2rFlUyBR0koO_ha3IupRF50G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwMyBTYWx0ZWRfX6EE0mh7OwlUh
 bOLzZBUoalxnhErW6IM6257BPffI31g8zil7GHd+cDXSghjMrEl93sXHCbI2UISFEl/QZw1lsoE
 eckgTZjKCpTSNRdhybMWDeFpmga07GewF2D97uUPEmYS4LTPrt0hiKCsHzfsVvFwF2xkFmDS/hL
 lzk+b4fvi4vZWd0CdFYsav4vv0z0i+Jrc8SgHwc0tCvSjx/vB4xWlrhyimpYN2YxdyhtsIDsIpM
 M9FyeZDY37KQCIBULO8mSQKOjlERw8tLV8obshinlf4AaTRD1q104SSqmPov9NOBmdmggFBAiVJ
 Rl9dfm/D3fXoTp/hcnZoBKmszIy0ZLAfz77Yw/c1tEP2/TyprzgZ7Iv5l7RL/PosGacIaPZyTPS
 rVUVvMP7xwWrkJfuXpAanXqFXYOIWvdgCKjOt5cxm4IxYgmGHo72ae1wS5MLLBAiGilcTWqsmn/
 4qM+8I8sKtCywljDvvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280103
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

On Tue, Apr 28, 2026 at 11:15:47AM +0200, Luca Ceresoli wrote:
> Most functions returning a struct drm_bridge pointer currently return a
> valid pointer or NULL, but this restricts their ability to return an error
> code describing the error kind.
> 
> In preparation to have new APIs that can return a struct drm_bridge pointer
> holding an ERR_PTR (and for those which already do) make drm_bridge_get()
> and drm_bridge_put() ignore ERR_PTR values, just like they ignore NULL
> pointers.
> 
> This will avoid annoying error checking in many places and the risk of
> missing error checks.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Link: https://lore.kernel.org/all/20260318152533.GA633439@killaraus.ideasonboard.com/
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/omlnswxukeqgnatzdvooaashgkfcacjevkvbkm6xt33itgua2k@jcmzll2w6kdq/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
