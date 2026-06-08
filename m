Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1891CCD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC4410EDCF;
	Mon,  8 Jun 2026 06:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mwn/J/4n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6awnd0D";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4637510EDD9
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:54:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586PTgN2808212
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=H2zQplJI8sZJybAB1FpA0/Zg
 REmKAxPvjyF7VfGGQmI=; b=Mwn/J/4nHx4+4TvQFbrU2gb/qPOTmrQz80nuzI+P
 5xpVoFLgjCkRK+aUdpq44LccryxTu0d9IauHxN++bgjKLNiGjjjE9LY+9uUbvqsw
 Lrzo6klrP334j/MMlCHqpYYYf4xE2x+YbJXiCbT0GFRwN/fG+fYFoH1GsS5bsvg5
 cY6rKp40ziOWPkn82JEnYvXV8IX/0tqyJxN0hI6N5PqGthrg5ifeRiR7qzd6ObbX
 cqXDCNl8EBy5qXk+ZgtWtaZiaTafQu4KrYHQh54ynXSGQgCzZhf6r0gQHwwgQX4U
 oL8mkVc4e+WPjTO07yniObHH7q83lKTo1XEbHA8P86/EyA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w6dkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:54:26 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5a7cbf971fcso2184153e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780901666; x=1781506466;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H2zQplJI8sZJybAB1FpA0/ZgREmKAxPvjyF7VfGGQmI=;
 b=G6awnd0DERpf6l5xvLQfhudQDydbtrJ8zXGM9f8GzWo+XVJhG9kPYUdYYboGUX6kh0
 fuVeMmeuEFYafm6FujMQuwBbU6EpdIidVLwsLPoas6xkX6egvw6YeIWy+73Tk5RrWla3
 51PI0QHk2lhPj609CnbHgQBQW+ev/qQJBndc6rF7OrDGEbwJ+8W22dTfuB8RMtj+IpOh
 pOiFMRu13VnAV3bOobPdnEDGqGvNwp7qDj0V9Y0+uviK8RS+n2vwhO3Mwxf/oS1fIvfl
 TEPwxpVzcSlfkSCTxHg1xNAZtVAIEEix46U3w7NHy+8riMuB25BHCgK3FPbsjQc4ufDM
 tu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780901666; x=1781506466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2zQplJI8sZJybAB1FpA0/ZgREmKAxPvjyF7VfGGQmI=;
 b=eMGrg0IUCRwDPzzroTpb8TCKcW40H/VbGyofE6QQEzWL6zke4cl7KFVb6dZa9d+Lrt
 eTxSDDrgEEq/0xDAg71EsfNF551oLzmknvOkNhDB9sHs2UYQYCR/KKgb3DYJaDd3vHaa
 JPmP4rmHoAm35/nWWTM5o3kUmsvMlayyPtR0IKox7FUXGx7GMA1QGRW/m9vi/yrGsF6B
 U0hqbmaIu1Bz4CLEAa3lNT6W83Jpc+p9Pht7G/YwVie5+XdLcVUTtRGcmKMx7xzqraqt
 dai/p4HvYI9hTDTPk+z3d11lVIoGXXsP4DRe0XOZzZL0MydZXTYh6Ra+o7t7JyrAIpHd
 4j/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BYkHyb2qsbHkIxuFeRRgFLgKlaG4Dgwn6ZnrFHVzgdrQLGBKa9778+a6pNV1qCR1JH8Yy/vuhKy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8lfLs62lUKgQv3jyNutNMbQgnFIAh6PWwP+v6Wn4FPzMnFrA2
 8xbk6LpG1RmamVbd7HY3T5gToa/9a7EEt71XPr48p7VIZCcAuK87AJgBoEKndbL6+PK79Cy8hqr
 liCS/p7ui5OzTpKTGia64WWXzR3teSlgy6SkNSxv6nZFcVzqeJUkU8vg4PUSvkwGRrAmujkQ=
X-Gm-Gg: Acq92OHkS0L/uz8h+A/KOQCAhwnbiAXVE7cf0b/GZeTif87F4wTLwNOY+SDEzbc0rHh
 AfGiwG0LtL3V/gY4zeWB6ByfF23jSkM6Wdo5SYRzSuNDorhFrs2U/uYFur8DhseOz8PKGnmjaD3
 zmefOxQmVBP8xwQ3ZECKGADU6b/7HCnTy82m6XobCTRwwMCaNKSv2Sx/s05wrzYPZX3E5ohg9Yw
 Cj4KPG6KvRR1W2vjq5GNbLjB0YZV5PzA9VwRVzcpEU42XR57l1eFF0I9yU/OzqWu0zGc1/qE9mw
 5olHZ30M3LStaAsfEC8IKuwR3pBf/Xc4+hlmI88NBtfVSoPHhtqd6vMOEU1u76Weoib4w7J83W1
 6UuQVPYK1dvbn5ybZ9su3SogNdIi9y+/tSkt2Gh4gqQkgzOOG/I9PpbhAW1NYJOS5qRlQjetXT7
 55a4GFt2yKy8k5+3WpseeI7sgZJV/WvGSh1xCr/kt1BMKl2w==
X-Received: by 2002:a05:6102:1609:b0:6cc:f252:6929 with SMTP id
 ada2fe7eead31-6ff0285598bmr6415258137.16.1780901665677; 
 Sun, 07 Jun 2026 23:54:25 -0700 (PDT)
X-Received: by 2002:a05:6102:1609:b0:6cc:f252:6929 with SMTP id
 ada2fe7eead31-6ff0285598bmr6415257137.16.1780901665316; 
 Sun, 07 Jun 2026 23:54:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b99c74esm3573991e87.81.2026.06.07.23.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:54:24 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:54:22 +0300
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
Subject: Re: [PATCH v6 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
Message-ID: <eqgtv2zvw25gnso3u543m3ppbwvcd57ymgaktihkj3pwnheots@wzpueuvksyy6>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
 <20260602-dp_mstclean-v6-4-2c17ff40a9b2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-dp_mstclean-v6-4-2c17ff40a9b2@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: uIwx-htznRdWX76gcUTg56D_8ojpsLOl
X-Proofpoint-GUID: uIwx-htznRdWX76gcUTg56D_8ojpsLOl
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a266722 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=CYneJor-kvHSDyyzVa8A:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX7l2JVKBaSLZ+
 bw7CfZn4BnP9tqNIA1MR/pHkcDUBBty3Yp7Bu8hmf+F8lB17AFyPMBk0HESG+6i7qEJ9bkcikJk
 5BuA6ZWLMFB5rLncmHZhFLt+Av6BirnJcFiz/xUvZuBWKsHw1yle4vy5AFvyxuJegKddaxTNFyT
 ntaAztyKcT0gtOfXFQa1Kgz38MkySwbhdFfNhI7+w+ZlptAUWfivOIBR9npiKQ144uK43EwZGs2
 Uo6sNAWh6H9cDY+QitvExQQhAI3rcWPVYq8RlYP3m9EYiO44DrHmaITK1O1gsiXbMzXMrzWpjXb
 usPokqKrfGhYLHlzrJbZ7WZx9aZc5ORrZhrAFUGkUpW/jzNAnA6c2KwtiPKoR6pGUSi5PT5/oCD
 11q7cWtvs9j/WP/k9g8U+I0CdLvSSb19GP+/XyWQWypCnAd5MIVtOO+uC9TDFAx4YVxOxUhViVw
 K2if9KYjitNq4XJvSEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
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

On Tue, Jun 02, 2026 at 05:11:16PM +0800, Yongxing Mou wrote:
> The DP_CONFIGURATION_CTRL register contains both link-level and
> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> all of them together. Separate the configuration into link parts and
> stream parts to support MST.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 46 +++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
