Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92DACD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC30610ED49;
	Mon,  8 Jun 2026 06:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UgQJPeKZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQG+7SNg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2C910ED49
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:06:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580FgXZ2004225
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oyxNnw8gCz5l4KgIAYmR/0X6
 QtgzggU4xD62oj4wLG8=; b=UgQJPeKZhVnyacVMlCzPWtIcYJPlWaTbjPA/9G1e
 E2lLV03qX1KmNg+m6qJes8lMDm8Dd3xRzIId2qjALUCAI3XNKD2bF1FIm/FLlBCF
 ZYF9C0ZV9nvkUrT9euKUpDiNwR4Fsqm9DmXbj66vWGcok5SaGU99ydchypgttaoO
 49GSouptWyFgIUE8tgSDdNgGQsxM479YaQ6bWicgSjDvAWRFuDL6ONnQAIs5BjEJ
 Fyljgii8jYOf5tw1Ojr2//Jk5tDElBIUow4Xt5d09Crkj75sUubNG/hgHObeam4f
 7/K6gZGI489z7mB8JENakXs4FXMIsF5bqbQRC8EYggjT6Q==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w67x4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:06:19 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963b07e2003so3857296241.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780898779; x=1781503579;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oyxNnw8gCz5l4KgIAYmR/0X6QtgzggU4xD62oj4wLG8=;
 b=CQG+7SNg3NMYiVhFAuSFaqNAY+pH7tY53iUs3qbuxngnhBs6EsqK0nbGzlGeq81uum
 kubWmDxwrp6QYaU+fk1HUnVtYZWQlFBEbcNdhsAR6T2mRQfdjg+lxzzWLWHgfYjOAIT8
 QLndyMO11md3fV4zXr/6DBvZp6lLfoQs1MkO9AoLaZAXFv3G+QQnPc0xbzIwgNXwzU4c
 AEbNHVdo7atzYlTNratJkmfTnQa2v6DBhYc1NPn9X7sfgWpnDkYhCsxK4yltVR72qhxG
 FNTB7EpBO4cllgs3JtHoU7NlRlst5Us9bHi39SrsWeJgYEd82j3YHECo4OkHUdjwA4eh
 8MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780898779; x=1781503579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyxNnw8gCz5l4KgIAYmR/0X6QtgzggU4xD62oj4wLG8=;
 b=RjzONYGs9F5bRmK4vbfX4//lG9WE3UcSddgITQaSDBAIkRQr990TfmwlUEEwXOxAuo
 1QAaVGBwTrR3J86e00VuM1CxX1KezGNBzqKx8prEqnZFXawTwAdlt3JEniWpvxN8tjpY
 ndpFyBAg8dtrlmj0/gMdQF7W4aA14bFIOB67Qe5lvR4syOJiHSCg85nBBwbeUKe4zDXE
 wH2xoZVkB52wPJg2/bmEg4aceP2YUjgvNpJfRXhTnO7CkgO+1eMgdfbufpNLit0D4nKX
 mzmUiPJonHqoYGsYHoWTrY0pP/d6C52+vRL/jaUByqbBwNPVOU9j1byz29aArD9sM4GX
 VgzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KdwSVZmIoos/fbHlxA0Eo165YQBejH8rghAoI0uRlw/MXmkZYpFDuA7tFRwzX3y3yaHTkDKsO3wY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6kibcDwNMAEZ8lhvUE9S5srGuxK5Mg4PVZ+NSaW7e3daF7PWR
 GOqKo+CtDzHiEnwChMsV8gNYdZc/HNgpmaJU9PVpU+y5CZNu13T/OT8X/hOquIndUNylH4Y8aEt
 EkX7DOnpR121VxuK2q+vpEOtEvaUic7LjoIaAi1EdVG28CvVYEe2HAxbfX62djlO/UEKYi80=
X-Gm-Gg: Acq92OGoMwrkQ+M1p18CGxJzCYFF6Jmew7CuVnoOCJOWW8UCbWgGR7lumsOxgmrn2nA
 fGZbOyYfWR7apwt8PJ3YJSe1zkQquMMfR9RnVBGgo3xLDpAwcezF0uFnpjFuuN9Cc40mSaRbHNq
 9/cSZCXP3bJOBgqv567+lsnfg5zNv8dzBCPg3x2JjATmcjsLsed+5nFND7BfxImiCSrrG53H9DJ
 YyKHDD1Kf0GWLk8aL1vA+OgOCqeLYqXV1odBsj36Q6ctcsPVurSRIfCaiKi5NhJgG1N+ZVxAABo
 abkxggUY0Ht4RrxvDLFahux7IzLvKZxUdaRXADrf4GhJHq2RhHMcYL71YA9q9jAWszGeLKKKUCB
 9MjWlXdhXHn2hP3eZ8znYRJZW9t72+2FKb1jnYqpnfEO/2S4huoNA5cV2hItsW7qkb9o6HQien8
 ZbiRXIAn8YOVVJ+tmYSOExN6YLphLMpTnAAJ4FfopYjhlMSg==
X-Received: by 2002:a05:6102:3591:b0:632:1e2f:3a6f with SMTP id
 ada2fe7eead31-6fefb852cd4mr6708416137.24.1780898779020; 
 Sun, 07 Jun 2026 23:06:19 -0700 (PDT)
X-Received: by 2002:a05:6102:3591:b0:632:1e2f:3a6f with SMTP id
 ada2fe7eead31-6fefb852cd4mr6708407137.24.1780898778664; 
 Sun, 07 Jun 2026 23:06:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b990486sm3503733e87.68.2026.06.07.23.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:06:17 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:06:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v7 1/5] misc: fastrpc: Fix initial memory allocation for
 Audio PD memory pool
Message-ID: <bhn7gsvbdlm62trxfnmtmclujcc3cnod7pnhhf7pr6n5wbwlas@kgoadnui2hx6>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
 <20260602071750.526-2-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071750.526-2-jianping.li@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: m3LOEZAqrjdRtB7p-joO26TKJQGaZ9KY
X-Proofpoint-GUID: m3LOEZAqrjdRtB7p-joO26TKJQGaZ9KY
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a265bdb cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=gKdS22MHRqfbWWTX0SsA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1MyBTYWx0ZWRfX/Fq3utgcXuaZ
 63lDD3Cn2o0dX4I1IVw/BoH3tFuDep5qgTRlyg9CetAKkLXPmcky4DxRwFpOwbExPOS3Et5ExGN
 lhhfU3XIf0tnyu9oHhvBI38sQoZBh//0faVlwSpUZdxH1Pjt4/6akc0GWULcknD95L4dc3ZSUX2
 D6r3lRgxpSpfvtGUl5Zvk7mbAqeDrs+Fbh6VfSJ++IA6IMs2eGrl9ikN5l7RdKsDS2PexEiZkJv
 cWFIe1zdyAEC/R2ob0TMomG3S8cWVtdujJcz9GN/sf4emT/r9jy00Ab7rsRsOMfULw8kAxBMkfD
 91IJDks9h6gtOeV76RpehmQOIQEABkqlVS7HiGx30gkAa0T0u67o8JyWRypqeIol7bUfbAT6hwK
 4BCaArAofE/3rP2NOL40ID10JPNKoRvYtLObS6BOmqLCTdyzh3GB6qH5FWtKk5bdV9jeC9FORue
 YKebQzd/TJwnpJjDwqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080053
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

On Tue, Jun 02, 2026 at 03:17:46PM +0800, Jianping Li wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> The initial buffer allocated for the Audio PD memory pool is never added
> to the pool because pageslen is set to 0. As a result, the buffer is not
> registered with Audio PD and is never used, causing a memory leak. Audio
> PD immediately falls back to allocating memory from the remote heap since
> the pool starts out empty.
> 
> Fix this by setting pageslen to 1 so that the initially allocated buffer
> is correctly registered and becomes part of the Audio PD memory pool.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
