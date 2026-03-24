Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11B8E9A747
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F31610E64B;
	Tue, 24 Mar 2026 09:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bSu0JCgA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pw2frKzA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1681210E5A6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:23:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O7RAWH2371344
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3YK0/akJLM7CPIvSiwDnz+wZ1B/Z9qONHpxp5SmLtKI=; b=bSu0JCgABCKgkMYl
 0fSBF2ayYG16mbf5E/Ms8NB9PW3yyw1us/8IkABXacJQHfRdDPBvEnaJira35IyZ
 G0F44aOHshhbJefYWYeKq3fsLxd+bkxPaqj1c8HGbsdAd+uLw83QPV3JbsaH7s1O
 D5zof1thvlnNeI+mHENsc/ugIxxs7Ud87MfyHqhKCItm1c/XDeMkp70WHQgclnha
 OvEJ254+G3kqkfeCyGpFvi5DJk/UqqCiWMmhZ4sM6LX8n1Yljn4pTASIAikn95FA
 Q5KUQM3tlCKE541mK3buXLK1znYxfhjWrLyNuT8xSof6KWB2Fky+lBJoC7sta+xt
 W4f6BQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p830csg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:23:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89c68ac09f5so44117316d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774344230; x=1774949030;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3YK0/akJLM7CPIvSiwDnz+wZ1B/Z9qONHpxp5SmLtKI=;
 b=Pw2frKzA5OqCvGmcQvxnXeBukJKVb94kJDXF0OU10dKOoQ0RiADIre5gcgrvshGPrr
 AkW7D1HitppPdehnUSma5nWKtCSkzbrCyPEd1Vy0ioOMI2qRfdFtmdzj+HsjmGIVCp7r
 epAGCO/45yGuRK0LLyl7qoaT2ca6eloq44oJSNvRgaG82qG0vgShecvW8nXAUvBriseF
 PvzSffZmVFQW28NBAHAD1RnFxh97C91q9K+3pTJPalrMom5PccWpRxffqK1/O05qW8Wq
 a1+CUGzRbTQe4wk0F+938rFnowoSBV+BaPASCvCBza3X+2aNW+As+uKsGYQtl54pKnPU
 Zn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774344230; x=1774949030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YK0/akJLM7CPIvSiwDnz+wZ1B/Z9qONHpxp5SmLtKI=;
 b=N4RD380ROE3GtbnpvwnDg382sYL1rxKU8BNXQgU8fhPwAc/SDaaht/PhHBltXMxpdt
 S5OW1nhEmrjIqrXgPh3efjunUzLRiNPrwShqRX9X7oZ72qCN5if+oOI5PdF4Obzs7AR5
 E1LLynBt57LG1ILftdfkZ3rojYFFfLSHBjKl+pqJByEgaSyVi66pUrAqlhpAPmfwp9BY
 Vv1m7xh+dBHez4m23Z8DbnhNs+kPo4lolT05jPmi6dyOuV+1XCX7A6eP9Ncb+qZeLGeO
 WK2Sit8/VI/9aevPhiHrt6MpnOhDXnzZZ4LLenRw3sFkAt/kRcTjUkOkpmk6p8luUOYn
 1deg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1eXvOlaJiJHSBadccce/XXY9m1LT0PEQ65x6agPcPtzJiMjXWGFHBvB9wZyup8Ks/zhnYvVQ4GbA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIAeONJA8L7aztGBPA7TWKTeAGIcbjBeqOo4ym4etoDSf+ccuN
 d6UT2JS7dWdIooUXH4JNnaUFc55tgBLBVsEfi66qnW4qXn9PeZUCVwlr6Eii7T9fD26SbffVT1t
 0OnKde6cx5+9rTHgrtt5njspa+upL9K/4svAXKVZqo39nj/hU0a5y3ubZli4AA625MtAMfmY=
X-Gm-Gg: ATEYQzxnTn6cFezfbRh9FTQHHkkrFj8twGgjPD6auxJe/ElaC8Na+4FnOxvvnzEEluB
 DTP36FxVZ+GV6rfA/Q92v0GNGTH+cUM39MrG3/y5+4ETihfP6xFNXshB7JRKKvdJFTF38fh6EIZ
 fgP/drO6sBW64Gdq12Q9BFzaietakNRnh2WZooTWVoTjzXTqxaif07OShsskJz9pTBkhwsL7v0x
 Z6+YIJY8ULX4Y+UCzXMeUha5r/K/DaSJnTofPPmnzRPik1MtVzQ0Xr5SqlwcGaT8Ll0My3otXG3
 2Q0+vUrdzQJq6WqocXipQ29ZBJ/frk74rMR/b7300V6iWOgrpLBgfaLHlqkFY7eVia0dnnmud/P
 UkGMhiqeyUtYKyu4lcM2GypyHwjViUpH/wbqOTAJF5OkTnxicn0Ovuqj3T7/s4eIY83BdF81mw+
 25g/4=
X-Received: by 2002:a05:6214:d8a:b0:89a:51ad:ea14 with SMTP id
 6a1803df08f44-89c85b1d077mr186848446d6.7.1774344230505; 
 Tue, 24 Mar 2026 02:23:50 -0700 (PDT)
X-Received: by 2002:a05:6214:d8a:b0:89a:51ad:ea14 with SMTP id
 6a1803df08f44-89c85b1d077mr186848196d6.7.1774344230006; 
 Tue, 24 Mar 2026 02:23:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f440f2sm612432666b.5.2026.03.24.02.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 02:23:49 -0700 (PDT)
Message-ID: <275cb08b-598b-43ca-a880-9681db077d16@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Add missing aperture_lock init
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260323161603.1165108-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323161603.1165108-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3NCBTYWx0ZWRfX2BAR7yHpCZu4
 8d0ob+06hqZCGck1PdkF/Ebr0kMozrbMsUoKrxKq6byfomFEOJ+Wa6iZKcfFGM8a1mG7CKfC3VY
 kmj45zXcvHQhHWU7gD8mvvU3pYko0/EI+j/O4lHOkfQzRshZ7r0y74cEsUNTbbTtJl19rmtuSF2
 e7gLxyw67XZaVFyW7qSQq4aYtvULUbCXoXasc/aHmeLtulLYqRP9BQsDHLDHrtg8JZqqe6QbNA4
 ZPE9li/7Qwg1o5TdVh9CJ7kL7tVQveeWqNsRG2Wpffvjgr/ueHnjzjic36iOVD7Rawpx7+Y7MKx
 Jlyzu9bkUXjxsJ84SpzcoKzdL/UsFtKs7i69g+VEdIfHgGH5Y+LNTen1Q07lOkMA6xbRWY9jIo+
 DK4NZlegmGge9DTHg1kHVRrAIYfukRYoIU9DLI9vL1i1EELYa7lZGZyO2mastvDPzAVRxHMnPbm
 DUZakHHoy8WgvSqGqJA==
X-Proofpoint-ORIG-GUID: IfLx7WEk1MLXX1IxEj-2bfSIvLvEzLt8
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c25827 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=9tEP0OE30YQ_IqY-BwIA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: IfLx7WEk1MLXX1IxEj-2bfSIvLvEzLt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240074
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

On 3/23/26 5:16 PM, Rob Clark wrote:
> Looks like this was somehow missed when introducing gen8 support.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
