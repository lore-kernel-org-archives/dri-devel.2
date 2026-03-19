Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A80F109190B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD7410E9C0;
	Thu, 19 Mar 2026 18:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5q3qQUX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JuK8pOyW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF63110E9BE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:26 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JF6cY23771122
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IcWtP11DQrOj4IlqS7tGJSlp
 8VMgZRHhYrfiJyDbgxA=; b=o5q3qQUXWzf1G/8tMkd6uN9y7e+z8KbANEpew+Zk
 4URjBiLpJsX9WG44M/Dy+ICofbn8rTJ8ZGhXsMfOKJZ4vl+HuFDWk6S9SGfO1oVE
 X+y+5lUv18ERX7NgXlCDEDsj9+OJO8o0R3hBlqDioY9vfHFoKhau/s3vpocgBPQJ
 gt14CWjDWmzIhkekqKRl5a3l2u871f9/FO+B54ahYHUvoAG5VkNUjp1iVnCZuoV7
 pL88A9XrRCzajwG0Ao+znQ/eaV4Vur+wauBZ/kZobLuH4lcRAHnKWfq+mBdHVMtm
 +63bXuc6YpnK8FQEYssrLqeDFIHx0vl/DgLZ2pcEICBOeQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083rb10v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-509044f54aaso90226191cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773946225; x=1774551025;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IcWtP11DQrOj4IlqS7tGJSlp8VMgZRHhYrfiJyDbgxA=;
 b=JuK8pOyWCUT6Q2V3n+NLYlzjtvT+sQ7MI9K5zmIO6AGhvnm4n4P/2M1qCMTgFIrom4
 QvUk+BN3X1C8tApRZKmWwbipl2TgQSmWp4pCwHFVkNRIjhwjoXn8gsp+lBdHbYYgUINx
 Tf/sa4hHYaNGgPgPjGLXaZ2gyzzpH6ZcRaKqbe5WZuJDFhXsmlnHB5dLZzwPg+l4/DV8
 3/X94kLlXtNSqmyRpRnQvlOqZqX2yYGOQA+KJFFo/AOmNr1NWNDQEjj9jv3phkTr2Dge
 l1GFG+GuEAdcpwH+6SQTYVCCYsuW/tyEW3dTVVyhEUaz41+p8nMiUQkVwH5zo9nazmCa
 3zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946225; x=1774551025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcWtP11DQrOj4IlqS7tGJSlp8VMgZRHhYrfiJyDbgxA=;
 b=Svo2bRWjrEUnEFiRKNm0fxebIRzJz4GU1OM9zhHV5a3Z8VejQUnyOgcin4ehU13eOD
 GGP0GVJEfdyP9yBqak7KnEkf2ZRYxCqKdt7rDl2xKubmpXEaL1iPYkM89erhUlEnH6CI
 RBcao4ggMOajaM6AUYpJR7RuNnDCygps9/dI8e/0WM3mJ5GAozSYU9Zd0lckOV5Fo/bd
 CqwLXRNFjSS+8FmHLbIikYBB1Ho+/aJ6WVhaMb14dhfP177kujoL0mJLCABdCHbAAeAw
 9EI/2iTPIoKjQpLXif67xhs0tX7er80A+Qdoy/U0vQmO3uUKBwS1qkceXA0+twkif0hr
 PWsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULz/IoxfQGOTse5VIVYAt/iRfuVslmS6Wae6KoTJYAz5vbZ4pD//tnsQm3+6kNBYwJvYLFQXx8hPg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKW5b/E+LNBWJiRnUs0tb/Z19sdKJaiUnLPJwMwfDFSziUkfZf
 z91bY2NjVTG+57R6W6nbCltDs6xSy3jW6jRDXIgcUSAQW18hJ1XoSlhsKuvLDLBig/KTox68ybv
 0SXEhOnVYiql8oLBvNcujFiw5g/f/ul8wkAS/f6DSbqujGI5lveCozbSADvw3h7kPHkaZyPk=
X-Gm-Gg: ATEYQzx1MXElV4Fx1C7iQIQXSGTO4aUB5zk21PHNj0TZf2W8VVVH5tLup04nBuflPy9
 ZnD9qiIJ/tOBfNtK9LUXDl2vQemfoPalJ6EWc+fLvl2wMuLgLF5Ctavz8t9oyw1W46v86y+mgDK
 isnewERwx/sok2G+UowMG5QFTDO7mavXW6jhgkcIy1zKVmMRdeLmeBeTwMQT4jLArtaZGoH1dOq
 EGeQPLar4vs5tBDDh9bmlNjVhHx3B94JLiFmrtswtJ0JkFD8x20MzpSOgpld96zvCSEL6Bg+0YN
 PVkyUSEaPMg8qLSn9tpzpDke6XC32YFYa4apKOnJtWxZCcQVKoglgkvzK5A/c5YeKLFABaitoCQ
 e+weDBWml2oODNSeZ0q2UAvLgB4PxlQJo24vedKmGgFeofX22kQH6eCvVFuLzLBoneFJHE9e3n6
 pHnPI45qoRuuToyUynOJ+iWpgJabFjpw0UUO0=
X-Received: by 2002:a05:622a:118e:b0:509:3fc5:a847 with SMTP id
 d75a77b69052e-50b3738ea69mr4834941cf.12.1773946225015; 
 Thu, 19 Mar 2026 11:50:25 -0700 (PDT)
X-Received: by 2002:a05:622a:118e:b0:509:3fc5:a847 with SMTP id
 d75a77b69052e-50b3738ea69mr4834371cf.12.1773946224409; 
 Thu, 19 Mar 2026 11:50:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2851adeeasm73398e87.35.2026.03.19.11.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 11:50:23 -0700 (PDT)
Date: Thu, 19 Mar 2026 20:50:21 +0200
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
Subject: Re: [PATCH v3 1/4] drm/msm/dsi: rename MSM8998 DSI version from
 V2_2_0 to V2_0_0
Message-ID: <hzcf4tu32linqxpk7aq74ujt4hbvevh4pjxlfvi5r3l7ngbaxq@gjor4kflqipf>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-1-85b99df2d090@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-dsi-rgb101010-support-v3-1-85b99df2d090@pm.me>
X-Proofpoint-GUID: 1_JTyrNlwM-D_CcsU8bdRAYPVJyn8OcO
X-Proofpoint-ORIG-GUID: 1_JTyrNlwM-D_CcsU8bdRAYPVJyn8OcO
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bc4572 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=LOFc8Sdq0yBhcMBbFKQA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MSBTYWx0ZWRfX5h4WVdiUl3kP
 KZWE7DHN09dnd0kW4rTZL52cVUjJUkNVbyipNotNkAkKuCH9DeN/DtoX6LOCoexqx6xfz1tR4+6
 QH3gdCYNQ6O1D+ZBVoAqRHKXET3ed/B0wY07VFg6OvGM7qjH0T4t1cSzgTYZU2Itsuiexsc+Qlh
 FTUpYQp78nkZSCr48WLbcUtUDc/iWGtG38OJFzogEWgZpMBJNrXd3rjgjqqlBsPUbhfxLSWkYkt
 cJ4Rq4W9bJd4pChtiHtTasK8N2wsvRadNvtjAV6N+5abBqsX/bIiNp4rf5SDVtWZ/c6i9Djp8O2
 kImsZxASy3G1EVUFOhNNd+DEen1+EuO6FW6lDCDOMGLdp0BMpP8haAXjg6sms7qLqT5Vbj/hF72
 +drvaheoTvJ+NPj8FR0yS+WAZNwtwO1tzf0XvaPZ3ZmAjqmLal9vLkvoK9KgC2naXTry/u9YSOk
 lPib8wCFQAy3npr5yOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190151
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

On Thu, Mar 19, 2026 at 11:57:47AM +0000, Alexander Koskovich wrote:
> The MSM8998 DSI controller is v2.0.0 as stated in commit 7b8c9e203039
> ("drm/msm/dsi: Add support for MSM8998 DSI controller"). The value was
> always correct just the name was wrong.
> 
> Rename and reorder to maintain version sorting.
> 
> Fixes: 7b8c9e203039 ("drm/msm/dsi: Add support for MSM8998 DSI controller")
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 4 ++--
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
