Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64699F94CA2
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85DC10EDFA;
	Wed, 22 Apr 2026 00:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O7PwNQs/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MTBoip6Z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D520910EDF8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:13:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIaGtM3083221
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gFxqEuiUW8mX9TjUpbfMX8nx
 BQmwupZNk5aNTkZ9aRg=; b=O7PwNQs/j3HYKQUOTigogulIGxxc638z4aUQEWGQ
 /YoGRBu7LdICp619Tu5UL9ljkM9r6kE6gkHtu5amc/fMEX+YoGGcgrP+vkiOUQbm
 YsvS6YBkgugCjj5OYz8p2WrQP6wdeNT6UOO7pAX8YFVdnIcmAmMaw5Rsw/17HRv5
 eXMs1x9zL6Kea+7VqyYeQkzuH8S1pl/cGQuchN9Oi3BwJn12DLDsREYnemW2BiTf
 0Sq28IgWPd+eXmKd/O+F9K5SPlR5RSiZb4uiZKAjp2NStGvpwvV8FZDWFuAEbxC2
 Lx3F14GZ81ILHvqbYVR2wU39aNameut5CCP8TciwNJweYQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmgvxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:13:34 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-610503b689eso6497241137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776816814; x=1777421614;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gFxqEuiUW8mX9TjUpbfMX8nxBQmwupZNk5aNTkZ9aRg=;
 b=MTBoip6Z70Dhb7J+oZZXQn7JA9za1uFR7UHyAX+iKeeqXBrTrEB5rgSaAcPDv1TBSp
 IW9bEL6JiVLHDcG7viRnCQNMgdFG+eDJMXO/S/V1mX9DcmXYzo8wb5wCh998bnu03Wzj
 4S45YAIR67MPUJmb+BQ9aAZcWO97HynbtoAx6RIntM4jBcWN11Yhlw8AqOD44akfM+Sy
 843g0ivacJ40tx3yOZAPYc8dMAEphtrr1K3PtB3Q6alu5eNsXX+lBG0mHkKEXI0GE474
 A3RC1VjiN++6zTVLT3MA2dzGtp/IsK/GQTUpb6SpGwDNLDf1H/pHD0hNn9MSF+lEGWeG
 N9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816814; x=1777421614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFxqEuiUW8mX9TjUpbfMX8nxBQmwupZNk5aNTkZ9aRg=;
 b=K7i74uRj3BekjQ5g5pNtifbJwl6jP27awsf+Lnebwlv8LGuEMZ0AQxCrjru5JqTjKE
 mDgmwz8RzO0r1tUVwlHzA5dn8EOCYuVx/+Ilut8LcPWoIRGbK0tWiNnJVJDHvFoSad4c
 5LmCqPQHqi4Qt+HOTCo220ynhWcca3PNVg0BwIPT4YlwlN/4OokxPLxadkbqjvLntvde
 J3bKd3157gdPxtT+DezmIHw7sDbwrlXqUNoIxmXEdTXv4iM3opgP+usPoDvHQUyoyr6k
 EVSqjc0WC7EfgEnvnUUrphe6CfsLEjaTY3lrWG5s7/h6eFAfxPoN80hExlyouQnrB7TW
 9A0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q+2CwHuJktj4sKELKBL5IliW4eZqhepsPPUBsUzrI/EgXhezIhEdxz0k5VEPV2oBIKW5WCcYYkMw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMTnDstEUuOEVkCILBw5ifmDCNRT/lpH4MY/bTIYmPd7IV6hRA
 rzBP5IgZHI8p0QHwrdC1A5wHPCpfnPRvTE7eWJ+BhgWp+tRTZzTL+5NqDFPJcpkFmLNMuf8/M33
 P2NjRpXo5fhnQCUcOl17Nlvb+b9X4lrmDV4eQWdFUpyelySEXHPbaEtAFH2GQewTExjcV9ao=
X-Gm-Gg: AeBDiesDpTduSrf7aPdPW5jtMM0occ1PuUrnKh1Ud3Cjf5yuhi4dPRM4Ft/f3uA8fv0
 hONYLowWxviix1xLiKuTXN2tufhH1E6MIR2br5TTp4eE084plzv0s/cuf/1ZER/dlu2fP11wOu7
 HJWGmJr9u+hHJCmBUSBy9rmbR7zvdfLwGMo8d0sqngIoIdp4t40HnUMpicUu9IhQns88qjS47X/
 kIojka++RoxFPFn2oCqfLptgf3Bq7Ns7LXBW6Ve5PPVnXN27j3MGaF1azxYBXth+4dfuyld03c9
 +GA3fXsd0Mjl3h4HK6a9gUUOhJsgNN543BxxcUPraIeoCtaUwl+6mYc0nAREC94CuIHsas6ydqn
 6ExtmMR0Ua1XKP0TUqmve8KCyA1CNXqHerevnuDkiN8e3GReuR9gRrWXeEfYRReOa4GbmfQ8/Ps
 C5862MQccj03GW+zQl8wDYT23KUDkLkaPZXuZpbJRoGDmveA==
X-Received: by 2002:a05:6102:f8b:b0:607:b901:5d74 with SMTP id
 ada2fe7eead31-616f4d7d122mr11002525137.9.1776816814082; 
 Tue, 21 Apr 2026 17:13:34 -0700 (PDT)
X-Received: by 2002:a05:6102:f8b:b0:607:b901:5d74 with SMTP id
 ada2fe7eead31-616f4d7d122mr11002509137.9.1776816813715; 
 Tue, 21 Apr 2026 17:13:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f68edsm31547371fa.16.2026.04.21.17.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 17:13:31 -0700 (PDT)
Date: Wed, 22 Apr 2026 03:13:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 6/6] drm/msm: Make msm_framebuffer_init() an internal
 interface again
Message-ID: <q6fhnbd2trwlkquzx5hnvtladveusuy4shzbcccemaegynjbc5@jr4eagrod2nd>
References: <20260421125733.209568-1-tzimmermann@suse.de>
 <20260421125733.209568-7-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125733.209568-7-tzimmermann@suse.de>
X-Proofpoint-GUID: Xp7ObvPhcBfHV2YxJmdo8vjevOITMrGj
X-Proofpoint-ORIG-GUID: Xp7ObvPhcBfHV2YxJmdo8vjevOITMrGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAwMCBTYWx0ZWRfX7FRusd7lG28t
 a5q/NIZRPuRJMciKX/08ZF6V0e0wyTBOfajSyfinbclaGwxyqXo3OZHCkTJ7ysws22ONyFylK/7
 aCeCcQvk6SlESQi8N12ke0vVzD8WsLwbDVjKZ6zBp2M8ZwofdjkmVtO4OtANfESiknZFqAc6WoZ
 oGbSPcdr+Uw2tcTtscwqKv0qtz0e48lxZu40Zvj1xMzOkDRzFxfmUiZyw8g/CXEQ3TRyWsOHKLB
 qANz3lxciXNaRUYlSVS2nG0JS7HtdT/bS3T/Xb42ZrOLqou6SYMJNj/XDeZu/Dk6YpIzWUieeih
 am5pDQ/ta5RIuyf1tmD5ygE0MAdG7ex/dL4w8p+SjQ/Q4Nr26NSYUO40/SNV1PMXU6VE2nexcMm
 5C6baEl6HH251iLQbpTDKTFIqlYkmlKR4bSLSqzdcAG/UQJCjcYPukut69uMMTF4Rcue/U9tuJx
 VMy7uDVFlJTTy20iw/g==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e812af cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=CE9xpL8bT2USc2ompkMA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220000
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

On Tue, Apr 21, 2026 at 02:51:19PM +0200, Thomas Zimmermann wrote:
> The only caller of msm_framebuffer_init() is msm_framebuffer_create()
> from the same source file. Declare the former as static.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_drv.h | 4 ----
>  drivers/gpu/drm/msm/msm_fb.c  | 8 ++++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
