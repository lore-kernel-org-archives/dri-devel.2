Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D486BE9A75A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F330B10E13F;
	Tue, 24 Mar 2026 10:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mYq+kP27";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kozjjtgH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CBB10E13F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:09:38 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O9pFaC4060299
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3X+z9f71+Se6G8QKmI4SJspHkjGgd4hGFUe4Lri+hy0=; b=mYq+kP278rWz5bKi
 W/6tWIdUw3BBPckBujL+YXfE4rbLvZ5+krUfgxN8ubk1qh4sj8Q0wF9h47HfHxer
 x2zmaTXHDe3HbH29vvDi608sKeYPN2EVp34FPUMOocD/fYB3m28Llrb0rA6g8RkC
 z/h6UP036fWtowbVru1+hxxMx3oqFmdlUJdgLcYX7mhCYe69o9VWJvkyBQallooU
 YMQzYBdzv9TZvFUJesnNWjuV+zhOPE4gHtFh1p9PhoAP/OShYnUIKcxBhkcJQMso
 0Mf+6ZLS6WRoCj5SprVv3O6RKuDVCRMBJsKoYwJYMmQ/TaWxtOljqd/zH5ZhSv2Z
 zyTTNw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3jskscjt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:09:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cff2297253so91421085a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774346977; x=1774951777;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3X+z9f71+Se6G8QKmI4SJspHkjGgd4hGFUe4Lri+hy0=;
 b=kozjjtgHmxB+ZJ9osljGevbGZ6yv7ErFQwpEImpWOUV0eoGbENkzwzNWzNREW9BwTJ
 ISg6AES1C3rpWgTMLke3d/ze4g/jEgojUygm6VhFOSmpGiJtmKlewiW5t06eTbF/HFux
 75L3X2HSvi7+C1x2So3l6FiQFAlrX3Ci/gq59/kLgvQHgEzSzaBKsQMOdJkNwX6kFRJ2
 2ivnNQTSurW533KDxce0EeNhhrlJ/WmyFhsPlP0JolJRrmm+vusAU1gqxPD0/cUQbkDj
 4hAA6wQq+GeUbDUc3A2ULJLQKSg9l79uQF9CY7xBe2YYQWknVU3B9+wdOUKe+k1Hd/PD
 BEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346977; x=1774951777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3X+z9f71+Se6G8QKmI4SJspHkjGgd4hGFUe4Lri+hy0=;
 b=A7VDMK6srK/IYOH9Uvlzl7GlHzKaNR+nOtD9uBP+lxg0phsdmIPTBz0m9zpQQgUJSD
 YaP8Hio3zhCKnJF4ingVJSzGaGkFKUCq9gPzAvq5fbpOduJ/56EamIpi71/nWptPkUSg
 sA/MuELYcY1biaI9BNKAtuJPdrH/6Gi3cpM80TCT9Raw+pzbtBlbCNymYRCR+tEtOkUh
 A2A786tWojg7iYH+wvUxq7e1UWwtuWH85HQS06tLFRwYr+pHukw9rDm7q/fVgPE/OCHd
 +Xai1tgNpwzlwoJWZfERf1k97JnGbuZUOUalrZcmBk7vPZ6Y248cYh243IbGEssXWxhU
 4hwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJSDbh7C9Gy4hUw4ZB4mJhbkE4QXoZ2CJTE9mIAt6/LW1T39FTyBvlkDBlyb9ShlFhrpuK95X/Cug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX80AVSwc4UBnJESE0ZgEO19SjTWOuEZixht74JIVDiDOTF6QI
 qFm7WM9BiOOHe5nuH+ONZY/IH0/NcXZJA5xDDWVX4YUl4WuWVazFUolmkJSg+PNcmacOC8sWnpi
 mlIZZ3Ev7Wubuhbwuo7kWv/HeIa13bfwsDaQpYaEL755OgQt8th2WIFjR4/SSkti1FClPKv8=
X-Gm-Gg: ATEYQzxY8WeKQFBZ1JryoWTkZndQC1LthJj1oPm35a04Mls0V23E5DdJb14Z8QaCkfd
 fy6nOp0HzXnvUwEgHb/4jXrTCu3QICxcRNH1Tl6/9VQmZHBAZQO4Z5eezwetFJTXLKmxCzvqln3
 HFjppesolapnvnsMwZIXcgGBY0GNgztKE7nKtKh1ED7a/2FwmwfyCApG45d4EM9j/GIKJxiHbMv
 F4ijzmV4DrjIK+omxjQ/528MfYwrvySvhM3MtUoDClv5L4Ia3rNGmG1Eh58KZDYddRHVbvZ4Zl6
 KdhlpDKw400UEhvrbVDBvldCQ+HknbLJHpPjwAF9zJQ6qcp4hQPH/3Eh264wnDXb0I1Ku72O7Ar
 KxhCMWcb2rUahEQhRWpU7JKpR1wMXp2vRtf7m+dIhyeNBXAs6Pe8FiUuloyyt4D4HlnpqcsQvYI
 p4iIo=
X-Received: by 2002:a05:620a:4450:b0:8cd:86d4:648a with SMTP id
 af79cd13be357-8cfc7f1fcadmr1635371785a.4.1774346977230; 
 Tue, 24 Mar 2026 03:09:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4450:b0:8cd:86d4:648a with SMTP id
 af79cd13be357-8cfc7f1fcadmr1635368685a.4.1774346976716; 
 Tue, 24 Mar 2026 03:09:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668d2a4b390sm4513271a12.28.2026.03.24.03.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:09:34 -0700 (PDT)
Message-ID: <2ef8138a-56a3-4851-a98b-597475ea8eb3@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] drm/msm/a6xx: Add SKU detection support for X2-85
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MSBTYWx0ZWRfX6DuNHpqtHgDj
 E/pJTiEdt11Wdk5Bghj2hc10l7QY0s1f443ZvMQTfnhhjh98W/xHINpjgaNVZYI7wgoE+ajPRa+
 13TJI2RdVcK3fUQYOmWXkWzIB8v8AcDZJnml1pcTRM5sUyr2lLZ/dRmDXqYebFKUR/z/rQNemtL
 W3EFSLcKumufZy8lG7ppdekrw7BkSs8QTmeBvFNYMmRw6T+6P77C7LIoNwZwF5tuIBG1xkWUDRh
 lojDsLdETmRQdEeY2R2A3wqRuHSeOhuP8AoLLe/h13RJY9KPQh1GvSpM1kzo7D/j3rlWn5t3pXN
 QxfOL1TKjfcazAhKw0jZPx4eECMRVXnkfCtoZPo61K2FamNjW/bW95bPUIFYcxmu2ldtIv+QHSN
 IXhLiJ8YVQqHpe90ZljyFdHadhyG128gsRyI9+juWtYWjkJIxHm2/U1ROTJVHcM4wAOtsscPcdC
 sE35AIExMXtQ0xH/GGw==
X-Proofpoint-GUID: usTLe9gMio9dJ275HnY9JLTwhqxsQyH_
X-Proofpoint-ORIG-GUID: usTLe9gMio9dJ275HnY9JLTwhqxsQyH_
X-Authority-Analysis: v=2.4 cv=I+pohdgg c=1 sm=1 tr=0 ts=69c262e2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=u65CJqherDVI_0nTr6EA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240081
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

On 3/23/26 9:12 PM, Akhil P Oommen wrote:
> Adreno X2-85 series present in Glymur chipset supports a new mechanism
> for SKU detection. A new CX_MISC register exposes the combined (or
> final) speedbin value from both HW fuse register and the Soft Fuse
> register.
> 
> Implement this new SKU detection along with a new quirk to identify the
> GPUs that has SOFT SKU support. Also, enable this quirk for Adreno X2-85
> and add its SKU table to the catalog.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	/* Set the speedbin value that is passed to userspace */
> +	if (adreno_read_speedbin(&pdev->dev, &speedbin) || !speedbin)
> +		speedbin = 0xffff;
> +	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);

FWIW this is lower_16_bits()

[...]

> +	if (info->quirks & ADRENO_QUIRK_SOFTFUSE) {
> +		*speedbin = a6xx_llc_read(a6xx_gpu, REG_A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS);
> +		*speedbin = A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS_FINALFREQLIMIT(*speedbin);

Do we need to act upon the other field here (SOFTSKUDISABLED)?

Konrad
