Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F205FF483DE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5DB10E231;
	Mon, 23 Mar 2026 17:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaNL/OeM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VTDZ+2I6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC9D10E16A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:55:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqZY72971865
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S+/K3Ay6UwXU3b+2kgmj7HuQL43oNjZ4mR3zsbDc9Bw=; b=BaNL/OeMncP2SQ1j
 4oEPmOmV4KFJKU0uNZ8aUBhFwpE91EvqRjUhbDdz1JgX14DD03JrGpjKwZpjpBn8
 o33OCigheY9EzQLs/BzKwiyi5C2JyfRWSaZwwtaOWeX3pKtS1Qku64cobByn3+9b
 YwcPODlCjZbX3U2aPbo/dZNZoFnR0ihu54CTnL4Io8aKnvA8jbCcPUQvXd6v3spa
 mBqwWpAHCIS4evLnyXr4wj7RwBXkeYn6qisC3sHDX8JTgIksQbONQL7cVrc7Lmtf
 nFKSPMQYfzQk2foGVl78KlG9q0S4HtsB4kvlr2tx1nQhGytyI0zjeyIP67OVwdhm
 DFpxTw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc25fn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:55:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82a782029b7so2365593b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774288538; x=1774893338;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+/K3Ay6UwXU3b+2kgmj7HuQL43oNjZ4mR3zsbDc9Bw=;
 b=VTDZ+2I6GefHyQlG/LgRpT2rSd3ALut9K4WYUt6Hq1J++Z3GQKWi2yN2yVXRbQizkO
 oNbW8jg1dCid45xGNr+BIvQa6+CuFhzX4eBXqpFkp0v58iViknT29KSwP+lw1URcSdkJ
 /QzAGHi/VypZ1PO6tzFPIKrsnRiHVXCpxXOeBKCEg4XVuOgwgziN3xZ9Wt70zPLsdlK0
 R3Q7asucWxMYnVvj+F1gTnL0ZfDDH7CvAXxYmUbwOEosRMfbVANPjWevPH4UVe6HLH25
 orDbZNEJT1g96u2/gN5KsC7qu6YVPEvLDU80ghfVqvlhhwwa0fR8polq58tws383ykyQ
 3Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774288538; x=1774893338;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+/K3Ay6UwXU3b+2kgmj7HuQL43oNjZ4mR3zsbDc9Bw=;
 b=nryJ76Za+1KMPQxmDpnwR9CSct6TmuC+Qbg+8HT/xKhIVL76kviV8U/8LTG9PU2jT2
 wVoAR1dDlXKIKdotPirSMqLD83bsZQDrWgnfKRHjCnRnV8ltLKAEDlNLmc0aV2sBo/5P
 GjXyeB/zi0ULOAzCaAQv16HH951Z4GggBwyliDQNVoVVoKzull4LXXOgTurcdM7Qszv5
 2S0+tGXqi/gheGiDw1QMvcpU1JqrZRMg2hCKyh3xOaBqdM3Z4oEbwbUE3R6zvwm5sCv/
 enq89v3pSjqIFyJ7Stee1Q8YBHsXqJyJlXaPsTQbJRG4HYOQJpyTwbZSxyQDGwqTyiq3
 e6DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZygcqCfCzn0vZ1CBbZ5EEbZQ3rRotZi33TSQQ7epxqIM4/Bm/6+tZcYTz1lHphZb1V3jPzbPfjh8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk26YIUA27+TFtC8kZYtZL+WJ8wwRddB7R0sgWYGQQwRh4AKDD
 kPyd+ciGvasVIEgBCjoi0wowpGFfDwTfdFonPgvZb7+NKuVJfM/yBQ20T03oPdRz6QaFZOSXuXg
 tKyvvpvc0UI8PgnrrwxtCae8q/0FXzoKkwxI2fqVTNzxiWwk6yiPC18rC69L+Fd4SNYXoras=
X-Gm-Gg: ATEYQzyIh7YEJ6abQwBpMGCianZU9hqBejAwwpJaLVcHiHnZP4BJgAF2G9soZwc36uy
 gePxsusNwcLVPUJ9QPOE81PygaX7/4DFQgbZk6Ge+dRZVjG84Hvkq3Dw2Wc+8yCF88xX/z72Zx6
 ZGTIjxT8rXAaASqky/6n7H+pjNO0Pl7bPxpaxL6VHPc5Nl7tFxTFd8GQoR2juJ1jXrw6fFsBXfW
 9ynJz+xxHA30YuCViQn+V5eiBWJc8hM056qsh0pkoJq+5nV6aCk8D7bQzkA3c423/6MI8wS32z7
 LgfmnToEGvF8zzyDoAhg+Ylt0LLBnS32HhIMaAwyik/WbsK/9yZeuEd818zPbPhU/hTBwxyX0zJ
 lisuGwZH22PW82Bgeir56PqsYx9mCtnkoyEURLEhJRWM2CWk=
X-Received: by 2002:a05:6a00:21d5:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-82a8c233026mr10579453b3a.1.1774288537898; 
 Mon, 23 Mar 2026 10:55:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:21d5:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-82a8c233026mr10579426b3a.1.1774288537393; 
 Mon, 23 Mar 2026 10:55:37 -0700 (PDT)
Received: from [192.168.1.12] ([106.222.230.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b04222f42sm11959100b3a.61.2026.03.23.10.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 10:55:37 -0700 (PDT)
Message-ID: <1862c582-0e7c-431b-a5da-684af2febc95@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 23:25:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Add missing aperture_lock init
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260323161603.1165108-1-robin.clark@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260323161603.1165108-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c17e9a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=WRfdsTvTEh9BIu3+I5rxZw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HBqI_kkDSLXZieHAmgUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: HH1aaf6S9mdVEcQLiF7yXQarf_bOhny3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzMiBTYWx0ZWRfX2Zkrlmi/993R
 g7YNAP7/z2Cn7GViNxtbfLcpyZHpXiR+ol8lRNd9uPxIm8wBjIWkdhXOBdrVw8//KDSt2D3Aar5
 ReNAZEo9L+XoJC/Oaz6cQRMyP+4cmgoBIsukVTN/FHLkmOBNFENKiNsPZQoCKtcdLRIPIxGbl+l
 AybyHydANMs2l4Y3vrYD/5GTk9vFoOyCSIMzHZfSKIL2VsF71oYp2/7/VdB7cyjh2OrH8EH8ztW
 lHF0e7DA9LAVwVgsS6RdoKuVwNw3M3QECnRJy68MFADG7GB/m/sDuR/41xM5yOCAMLRtcah+13h
 vdSF1XH31TjOkukWbYyFwr+c+j9kpC3DhudHMOYFuiCLX2phya8WGhxl2851VFsGmQ35OufF9BN
 ITbAa2582abxP5Xv/Ggy8/0R8x/wGBFkLxhtqXhk6yqXrf1oHH0MAYjBp2S25pkY5gCGBbe6R9f
 ycnx8KpAikKuJ7kvW6w==
X-Proofpoint-ORIG-GUID: HH1aaf6S9mdVEcQLiF7yXQarf_bOhny3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230132
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

On 3/23/2026 9:46 PM, Rob Clark wrote:
> Looks like this was somehow missed when introducing gen8 support.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 2129d230a92b..a00215b7bd1e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2656,6 +2656,7 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  	gpu = &adreno_gpu->base;
>  
>  	mutex_init(&a6xx_gpu->gmu.lock);
> +	spin_lock_init(&a6xx_gpu->aperture_lock);
>  
>  	adreno_gpu->registers = NULL;
>  

