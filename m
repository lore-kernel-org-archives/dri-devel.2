Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A30CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B211F10EED8;
	Mon,  8 Jun 2026 08:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SrYht+RA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WIY30x6J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB03010EEE3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:10:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OeuR2385857
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dwK4nxtWG15SAP6eEf7FAH9IOIg1BXS7vzSJRCfLPlk=; b=SrYht+RAwtYeCCds
 9qFb+I/dB1fJW/qmTzRTbc9GcjNLjfGJeBMpDdeE4viUNkos+R5sqNmTM4VkX+fB
 icn6WgSeTX00Np9DjXMEO52AWQSg+qDIf02IpktMzNUfAWP+4ksBjp6m9HQA5SIQ
 WhTKWZCCiNVhnaihOUZ5vcj0VYNzn1Cg2CQCXF4mwgEoBQjVypMuTpl5MwbN6c2G
 CRf5wvwwDWRc+it00cGwfx7A/AGqeNRATPRQBzpq5LtIuXfTdvNswNyz/RCN2I1R
 gRaIwWVmVAOvyIC8suT3dXMv4Fp1vXH79+uX0bu7ID7NyfZhk97fpErUWgiRCUOO
 zWV65Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8xg9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 08:10:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915a547f4b3so103959385a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 01:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780906235; x=1781511035;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dwK4nxtWG15SAP6eEf7FAH9IOIg1BXS7vzSJRCfLPlk=;
 b=WIY30x6JLAfvzOPG648InSzukGccwrNQw+uflFE+pUG6gjHsE73KQQjWNWmH+uKCi0
 yQNduhXK+9eUBSf2mh2p87CAhz0+d8nDw8DSz/FfIO7BnZf8MOf1ExO/N/Je4vbEcOWw
 9pGR7MOWUVnLnyMetrBbn5ICsA+ezMNBwHRsY1Wach7ekwM3tK0SQBxgji3Zn99MN42s
 FNSi7tc9l0+0kEqX8SoWJWMiVXaBt+vsmx3V8TxmWqPWZ/A7osqoMCa9jEhXH/A0HBUC
 jTAAZfxUy0DRSWg2tLosb9v5xluhQNIYLazjzuG/gc7bAZYc/vvq9HUDDb8keE+xzTqD
 ajeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780906235; x=1781511035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwK4nxtWG15SAP6eEf7FAH9IOIg1BXS7vzSJRCfLPlk=;
 b=PNKQ/hlUSK9L156fXKbkoEaNyFij2cNFWoj/D4GBEQn4dxFK5NhudBvRKC4vgeIvEX
 1OOGk1wNmcQcfVhWcd9tzYimYQ5u4gdoa5DKtRKvUB+VtegahY+vUIz6dt7bNK1wl90X
 /z6bXZpGLhelYl+iLyU5pYSI8qweFnjsWOrEg9r5Hf2chW6Gt6hcbUFd51cY3bZLEq0l
 dpdO8kj6krBBas/KsxQ5gb8D9L4VWOT/u5V7sdO+DqCQvKRPaQPLA4R2RYAAUsin0XeK
 lxHsRUS9zArjBO2Z2yv1Latp4acB5y80g2ZHM5pnM/2QLENKSK2GyMCla23xR0Z35p4Y
 Jgrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ956nJT3j+DeiG1APRNLXUKhF5qjaTNn74dKdnNhTpXUev+LvdLYqI2xCXF5lAYPGxCjJFF15WsxYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNaB/FiD7sbQVJIeISfINoHWfxSO2pNqcQVRc7XYeXtc2GjUI4
 M3mtqL0MEG4nN4Iyn7nZRdWelUOb7yg8Y8y8Bpc94E7GZM05PNfj5z07h6E9pCSHPdiPBoEMuos
 Cy0jyld62dzHXKwEWZje7YpAJ2MTdbGmp9ryFA0lAON616vWCM/r0L6YYp7hhscN1MyenwFg=
X-Gm-Gg: Acq92OE81vI8praq1z+hvmR8Q45AtfZd62yyRBPYvWrh5ag4TdG98mC9i9CxPQ1vZ6w
 0dPCcIAlHSqaFYuqQHQ+32a7a2i3mH4XtRqOdoqVDWyUS5UbD8lM5mRY5q72kzEu40tuR5TXRsB
 /R2Lu7pVW9GMl4BudPWKLTaf9KluoG612aDOVAw6jHK9fiBy57hyguPQi5AuMbnmbGGtiI2+bPQ
 iRnmJJZAM2+l9CtrtCbxI6Va/qG+w0AecUbFZ1Y/m/UJbaAli4rQQB4e2JuziQdaE6EGv3fNjCz
 P7l/ksFmnAjPQ+ymW8gnx4iHC9uQo+DPhCtFFxj2td38gnAF4I8jyAh4Nw1xiMW8/w77VOdS/pX
 u/cYC+IwS4yig+dJ2KytlC3Sj/Dn2hmh2vu8MRgWGzJXF/dNa9LElYMXT
X-Received: by 2002:a05:620a:1a06:b0:915:79da:a898 with SMTP id
 af79cd13be357-915a9e33362mr1287257985a.8.1780906235166; 
 Mon, 08 Jun 2026 01:10:35 -0700 (PDT)
X-Received: by 2002:a05:620a:1a06:b0:915:79da:a898 with SMTP id
 af79cd13be357-915a9e33362mr1287255785a.8.1780906234714; 
 Mon, 08 Jun 2026 01:10:34 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05208e897sm817000766b.25.2026.06.08.01.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 01:10:33 -0700 (PDT)
Message-ID: <35449083-8124-4eab-a17d-a9b7854a8bbd@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/msm/a6xx: Fix stale rpmh votes after suspend
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-1-2caa04f7287c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mTb45ol-hpIjEnm6oOl3Ang50LXPvua2
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a2678fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=DOYe0rhNWOoO_G-RWt4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX6bCav6OVAGfw
 Pfeu+Rj0VA6a9dN5FZ5AXEJtHpR4KqeAzvkfrRJDkrDb1grCHzEi1wp5s8B20KL5hK7jITH1QvY
 En6nGJg/0CnwUqMCOm1C7SGNkNst+RFhnIalHJLUWBu6guN6oe+LCOBMiJnqnMKHHbbhpoPdRkS
 52dJ+QUiZpVyOqZ74ykcwzXb1hfhFyD1HD8+7Sbmz7NuO9rG9jyPn2bFNGCcMcUxFHARL2VEA7o
 lj1rQMOzY/6IiC/WMrdwgqmsjXr7XZOZ53nl4SLQ1mYctKYgUrgQpQNTpNhptVlcnqh8PtrKb2K
 sr/Pvj3pC5dWK4PnpD2Ru8K9ytNOCbZUntKtziAVf9cxedp2D1TP3qzje51R8LHExLz3/QaU1ST
 KMbP3sbzUG6b7L8eyub75EjjQWmdYvk9M6nBQM1FOBuWsbIUmsT2Kn8t8SsPpLk+EiitYi+kEhc
 XqHbOeAhirPfHQ6PKTg==
X-Proofpoint-GUID: mTb45ol-hpIjEnm6oOl3Ang50LXPvua2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080074
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

On 6/4/26 10:08 PM, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> There are stale RPMH votes (BCM votes) observed after GMU suspend. This
> is because the rpmh stop sequences are skipped during gmu suspend. Fix
> this and also move GMU to reset state to avoid any further activity.
> 
> Fixes: f248d5d5159a ("drm/msm/a6xx: Fix PDC sleep sequence")
> Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 2e5d7b53a0c3..a2f6918c4f7f 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -642,7 +642,7 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>  	int ret;
>  	u32 val;
>  
> -	if (test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
> +	if (!test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
>  		return;

Hiding in plain sight!

>  
>  	if (adreno_is_a840(adreno_gpu))
> @@ -1465,6 +1465,9 @@ static void a6xx_gmu_shutdown(struct a6xx_gmu *gmu)
>  	/* Stop the interrupts and mask the hardware */
>  	a6xx_gmu_irq_disable(gmu);
>  
> +	/* Halt the gmu cm3 core */
> +	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 1);

I believe this is what kgsl does as well, so:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
