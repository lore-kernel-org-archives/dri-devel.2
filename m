Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56205CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27B810FD8E;
	Wed,  3 Jun 2026 12:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CofqQoNX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UGf80WDu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273AA10FD89
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 12:53:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653CjGRe1946613
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 12:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2CR0Nxo/LHhSwkjcrEkBeCqOaHQ2ASUZ2dBUfobv+EQ=; b=CofqQoNXQIWnE4rP
 BF4xw5mIl3DXIbLEvTMEfYQgI55z4M1K9l7Oi8AP2rUGYFsIJpEX74Vh8PdILBAz
 uADOxedsFaCjNv6CA+/XfXlsHRRa9pXEnhvVq8K0Y/PHyOcnyp8QvMr7lKUshV8H
 jDgf3neqtxqwyoVuWACgHNo0pzHtdLiSj+JuUqsh1oihGntY2ICqbsYlOEIw23Uz
 lu2niPYcuKStlMZKtgfEqH8zXCNU2HIeyN6hDpf0Lynw0K+PI4tjaLiA4tJ1pbBl
 Gdm1aJ3oBIZkiyCA5s0n/tywldtYFJrJpAONWN0VnLgx3RGYXkvBUlR59xCEV/m5
 ZSV2kQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabgjhhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 12:53:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5176ff55dc2so3754431cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780491202; x=1781096002;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2CR0Nxo/LHhSwkjcrEkBeCqOaHQ2ASUZ2dBUfobv+EQ=;
 b=UGf80WDuJZdVTZVCO1d+1fjB5ziYKmkdJbkRfdUnTZgNz7MrCOtJIVPoiMaa0Kea6L
 PTTzx/Q4E4J8JyAaO9Xb1UeJ8IPH9EE0IC7aXDYH+jIoJEL2AafT7D62EI39piAq3gsv
 YF5JN+VbuAkGa3KjGgBj9Mb/MEqbhcKeuKS/VPNwXkfCu4X7RaqIKtHNvdxr5UBqRWbR
 /IcMvAnWW8h0KTE6MC26qyY6i8H/+bIlvwDEC2JI13xSHjU4qBnWRm7y+GEfiOL1x0Qt
 gDeGtnziezhOwc2kCRWoAUQRO+hnS7lrHgdIIhlKdX48UlYCDbeKxRoslC/iAdv0ftE1
 byWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780491202; x=1781096002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2CR0Nxo/LHhSwkjcrEkBeCqOaHQ2ASUZ2dBUfobv+EQ=;
 b=prcdlUU4TgwzYCMyaK/KEjnjE0Mn/I+cThuFX11ffRxSFmIrz0JTX/AFMyAp2QpeDe
 Os8w7M68HmKbtyp919fnFn7l3GBOxtdvPJwhd6dQTVa4tljjzAGfXPWoHMXu3rdIHhac
 g3YgZDdslTmHuRyRwAkwK1gwZqcDMjtAoHItEvx8hByWdOFVNgH5+xILbcnAKHOEdNtQ
 SqEPSmaTSHr61GwgHAChos9OkpXT+PGnqV2SdzckqsBkHSloJYKRHEYYOoZKlEUtKFKK
 fGvmcJjLlYmMVTWcMD0QOGhEpEc3yjHluay3+gRTms545iGsyydF2t7SNNVWk42DOu6o
 cGww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gXX4fghysrWjz6NxKPNmSwMFDZAo5jiz0eSok4tiAsTICXqa/ODTiC9BVAxA6xkAZtcjldj8HOy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyf7XBnMqGNsN3dRaxzUCWfawXMvF4JITnPKgC4umerA4DRW4jv
 wzQyYfE2H2VPr+0e2b3Hdt/vx6tEyKxDy2myPQKMmjiJLjyJZTWSJJimgVUrxhaS7Ejv4jG1wRb
 9oMY4EJ3BI1PZy6Wvwd+b0agGPIrVZivfPGFT5/qu8uNknEcA2qV+ry7CXSNiGWDLyqQcYtQ=
X-Gm-Gg: Acq92OEkPGYU/Szt/Sku9PGHg/sZmzIYiD2dAYATXy9GnH5HbtUWHMUm9bs4ypZejSh
 Sm7uwrP3LJW5h2Ht3I1d/weAcREzoFjr7eUH27yTDtqE7q1+RlHC2FNHm67VZFi3hB8AXBakZdF
 It4aOjgTGGIpp7+/GIqb43Twix8X97vgWCj1zUl4sVeF0XtiK2MCngTuRiJmxx6W4GoBC8zNM8t
 g12tNybxFhvZuNNJU/gq4dWh6x8CTOP/o/TRn2futLDRo33Klv5rLJQ+1nxjWz18EOftBmKjXIA
 REFsHqS/OJc9HHp91I9ICe8PcGfUeO4IyDUUETv2Mv+appJ00PXldJaYM+2X66GT8qKCspJbC7I
 eoKXrPmGqxTZub5XzEaqx39kOX2hiSReJR6E18Ru5DHap80CYijZa/IqJXJkT3UnMEaX58c+kpl
 amnvwTX4du3AI=
X-Received: by 2002:ac8:5814:0:b0:517:6162:daf5 with SMTP id
 d75a77b69052e-5177830b1a0mr35058491cf.3.1780491202689; 
 Wed, 03 Jun 2026 05:53:22 -0700 (PDT)
X-Received: by 2002:ac8:5814:0:b0:517:6162:daf5 with SMTP id
 d75a77b69052e-5177830b1a0mr35058011cf.3.1780491202306; 
 Wed, 03 Jun 2026 05:53:22 -0700 (PDT)
Received: from [10.100.11.76] (public.toolboxoffice.it. [213.215.163.27])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05177150esm152678766b.5.2026.06.03.05.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 05:53:21 -0700 (PDT)
Message-ID: <fb536e99-7868-4d79-9d00-b422e831b9f8@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 14:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] qcom: x1: GAMMA_LUT corruption on DPMS wake
To: Daniel J Blueman <daniel@quora.org>, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Val Packett <val@packett.cool>, Steev Klimaszewski <threeway@gmail.com>
References: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R6sz39RX c=1 sm=1 tr=0 ts=6a2023c3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=aBIYUfOEhgoR9egqXYNcqA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=zIC3kcA1p7w0c6vzSjUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: XWsw-UpHjVMe4KnFAF6silgubjfFFxwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyMyBTYWx0ZWRfX8BRMv6yBXYpc
 kKK5JGBQDcDLbnIQwmBLp/3OMJPDg+pVrmcDU7es+hlgneRD5YUamSwUmmWwxCAveZ4hGgSZTzF
 tbDnyboaSTMB9PxIAcoAyOQNTzgu4DJ/0p2FADM+gMGPfQPCLgq6Plq0uoz3L0sZ0WHC/U2CZSZ
 ADK2ctxyN/+O0DIuvNQU3A00dN85dck44eG0Ox0ExRj3J54uCaj3DQv6gx0dDmtjrW9yvA/rqI9
 0iMwLZ9PwNQyvfoXVzuJrzpbLKlWHjAzmahHWRwgjCdV+y47uvuI0DfyrW/vod/sDOymxCxOFVS
 97AXzocTsZMSV3JrI2enScwhC/GaIxQ093Rqu+wWnFSYF95Fka5MErowJpISMVqZ6uIOkdwVulP
 7amqpNZpQ9fjQldbY2jucoZermShGs6hWTG2X9mVNLcEMC/AygcMSM5CfquEw7sdBh+Inv+JsHC
 nfBfHE+iZXW8bx9wIbg==
X-Proofpoint-ORIG-GUID: XWsw-UpHjVMe4KnFAF6silgubjfFFxwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030123
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



On 01-Jun-26 07:37, Daniel J Blueman wrote:
> Since Adreno X1-85 GAMMA_LUT support was introduced in Linux v7.0 (eg
> Ubuntu 26.04), when waking from DPMS-off, palette corruption is
> frequently seen; this manifests as purple banding. If GNOME night
> light or similar is enabled, the visual impact is greater.

This is not a very useful reply, but FYI Adreno is the GPU part,
which is wholly separate from the display engine (which we refer
to as DPU)

Konrad
