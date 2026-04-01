Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD84D35163
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EF410E940;
	Wed,  1 Apr 2026 09:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mktgjZKc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xf893MZQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868E610E940
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:32:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317EpVK4106736
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 09:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8DZG0eROtWmud3ZdD4EmRKx3UCJmwtzdRxZUWrs7KTg=; b=mktgjZKc5bsnghQB
 ydBx3gbKjuZl2Vc6GW1EQtrSd7z2FBd5HsZucM+iz8rkJeKapfrvbD1JoCRvwBcQ
 A1OatOYwGhrHve47u8wfK0oywq0GbN40neBP5MZII6Tlqdiyq5CrAYSQPUml0hPh
 HKe8HKggE775HlyGcrhvI8tkJj0KvL3RnmVw9cZ22Ry6gxEbfEZBVnsoWJR2oMya
 xKd9aYzS9op0Q91wVMov8v+WJkIQh0Ag2AhZR5Dqs/vupg1t4QiHHLFE6ICSHEu4
 rvaTC2rKwOx4vWVxdYZw3JDDatLCWAMiJQ1a7Py8XpFIgzOFpZGZPify0HB02+ub
 /lBB6Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xt90kte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 09:32:42 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89cbcb48003so29074326d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775035962; x=1775640762;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8DZG0eROtWmud3ZdD4EmRKx3UCJmwtzdRxZUWrs7KTg=;
 b=Xf893MZQixEORhStZxQqINmZ70A+I8SYLnhF1x9+BmhGkKp49xiyLI2nGr/6vqh8L3
 AffRsM3YX6F0XqMNAVfv0hOy6g1298Jn7MizUd0NqbQhVypvIB5vhXSD4sKAy1T1sgYb
 lifUiOFpr8HseNGtx/zt/Ro7XJx/lox8qKCGZs+NG2U+7VOkQ8XBSFjcRcvSY5s1dx2r
 WG4F+3fmR6KYwskycV80oRjXhseDfhtT/bUyRQqp3xANJdUqoMMZNMG3nRTRm34eurjJ
 VEe9OcuTSdlEEZuYZHtvgEFoSP7UMo3Fc92KGs8ITvsj3Yr7efTIw7X/N2MiNxTt1jQa
 Hxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035962; x=1775640762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8DZG0eROtWmud3ZdD4EmRKx3UCJmwtzdRxZUWrs7KTg=;
 b=CzZsKFGFlDtDmiFWEmcZlVTJPEzxC2wlpdCMdebxpzF/1kh9TaYr2UhW+jivzc2oxb
 +6IRS51SrAr42lBKUig0gW9cij8M2MQ9QbJT+rtj2PdzteoqeHrBF8V0CXp2JoWsnVCr
 QpA4VZbrLTooOgUsx4DGhkTVGfZfrOO6xYC3hXxcAKgz45bV8FkyxL0sLqljK8M8EiZR
 xCyRgV0kNd4rfAotiH7buuABy6ccrwUvoG3kL0OdQdJhv0irQx4le03cUMiDsBjGzhKq
 tsKgPGC/3Anc6ObeVpLtbc9YYW0oDI3V/0VZ/beexq/IwhCmtzkOakkjgkejcycEns9D
 p5mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUquvSW2yjPgFAOYF1Kpu5x/oAHD4pvTaHoyYQgy4SEsOJXbnQrWWpbD+A2oRH0JNPEdrsaxsnNZeM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO7Ad3j4HBR9nnzXt/qKJTmcAFlky72rmT03zOpDbksbrqcsJi
 HxkgwIhG/8um+rOOnBRdMPnywwCwnFYbr4gXtrTGWIaDMW5pCXN+4tK4+DgpjLvNrhefN2sRoqU
 F2HK77+uDrlIZrh4Q3B2p4NF+plHCeL62oL30r8v6klM64aMIJ56u55ER3/jnMrldHF6Yi2Y=
X-Gm-Gg: ATEYQzz5B0Rd1sacgovl79UQrsTqLkRHFas3El/Fyx6wr1hJU5o/uug2gYTSOLgqtxZ
 oQ+/m3/9Kk74cOWGh1T/blLxzW67UjD/V3lGSRA+688fDfJuQeBjw/LxtMTxzvxfA5NcbpFsK5B
 WPGYwm4E5ca6eYhbrCh5kEj7dUzYk6zoezDMPNZuWDInj8yjpLElmrGPYdv8Kkj8NXMvO1/6uPO
 7Lv4O+lLBbaaWJO4kzlerv43Ml/JM5AYv0rqdfljn9uu+99RGard3U6LS8lSgk9nGNZZKTAwx+j
 BhRLGegV3KY9SqkWjVo2pgpBZQ40nneQxrWR1q0jSe+v8e89ud5YVKLG1w4gXn9LT6ye4LiIAwW
 4HHKgecjkD65kSrQsmWi8k2iUszjpRFvaHZu1e4zpiFIxQONeKq4t1KPozE1UFVUCk2m4Ysjw9H
 Ys7Dw=
X-Received: by 2002:a05:6214:627:b0:89a:5129:510f with SMTP id
 6a1803df08f44-8a433f48ddcmr31691426d6.0.1775035961956; 
 Wed, 01 Apr 2026 02:32:41 -0700 (PDT)
X-Received: by 2002:a05:6214:627:b0:89a:5129:510f with SMTP id
 6a1803df08f44-8a433f48ddcmr31691156d6.0.1775035961433; 
 Wed, 01 Apr 2026 02:32:41 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c0cce9b2esm115233666b.26.2026.04.01.02.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:32:39 -0700 (PDT)
Message-ID: <387635e8-d49e-4e08-bd26-e76838bb27d5@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 11:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/msm/a8xx: use pipe protect slot 15 for
 last-span-unbound feature
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-4-725801dbb12b@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331-adreno-810-v1-4-725801dbb12b@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: m0bsdqijv3Cxjz-mDYpTNpd66WCfMlji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4NiBTYWx0ZWRfX/G/Y+qRRyyev
 I9fF3wYdxr2YYpgOs2QSexQoHyn51LlVaXeLHPMfi51u/ExKzLUpg8VaWgy/qIyOtxRKQJ7vREG
 az1dTQAqP6/+QWNN/Y14NdnttSEjQ244nw7EcUfyRJvQRBY25309ZSFRnA7KA2+CHAUysLzpT2m
 Fe5fLt4qk/JC7NZhuUs8Ko20Z6t4O6jYz9SaagIV9AOul0pHiqpjKIo4SrhO6T3CF6XpO5fEe/V
 qTL9odO+/2IoBOvwZCoBWEy/2U9mdEKp2VY2JB3VvWuveTKlVre4SkkhLOXA5aL0ZFzd/d4HiYh
 9PJWJpAt80r3V/KWc0d2sIg6o83Zj4VXsUJZRynyfxVUYINboL2FV7JD8thO0G53b943GztSseZ
 Wrhc/Gxs6KIBuBon+EKn53PX6LjcV/4ME9/7sBTSs9uXwRdMouYp8D+W5TkWlzijjVg9cPlC5H0
 etUt4fKJbSfn093jImA==
X-Proofpoint-ORIG-GUID: m0bsdqijv3Cxjz-mDYpTNpd66WCfMlji
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=69cce63a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qGQNF-HaROJYSwuyTOwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010086
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

On 4/1/26 4:17 AM, Alexander Koskovich wrote:
> A8XX GPUs have two sets of protect registers: 64 global slots and 16
> pipe specific slots. The last-span-unbound feature is only available
> on pipe protect registers, and should always target pipe slot 15.
> 
> This matches the downstream driver which hardcodes pipe slot 15 for
> all A8XX GPUs (GRAPHICS.LA.15.0.r1) and resolves protect errors on
> A810.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 5af82d43f1e4..63387ee9b04a 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -252,11 +252,12 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
>  	}
>  
>  	/*
> -	 * Last span feature is only supported on PIPE specific register.
> -	 * So update those here
> +	 * Last span setting is only being applied to the last pipe specific
> +	 * register. Hence duplicate the last span from protect reg into the
> +	 * BR and BV protect reg pipe 15.
>  	 */
> -	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(protect->count_max), final_cfg);
> -	a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(protect->count_max), final_cfg);
> +	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);
> +	a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);

I think this is a better fix than:

https://lore.kernel.org/linux-arm-msm/20260225-glymur-protect-fix-v1-1-0deddedf9277@oss.qualcomm.com/

which will let us bring back the BUILD_BUG_ON.. WDYT Akhil?

FWIW KGSL just hardcodes the number 15 here as well.. may make it
configurable if that ever changes

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
