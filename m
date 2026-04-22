Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F642F9EDCB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C2910E2AF;
	Wed, 22 Apr 2026 13:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OAROdOi2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SphHW3z/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E915310E2AF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:04:36 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M9kTTd2000973
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w9eW7q2/yfswm/0EP7ohuo6irtJLMRsFkiVDHy32ekA=; b=OAROdOi2XqNWLjrM
 osntcLVo29SccQ+37V6UNRiSxWdk5HyHgw+Zfk+9MlzOzODfIvkCdP9ClahxPMv2
 5zbqYjRj78JglBtTbVWNCZmEwqSC9Kxu3yXR3zqqEouR5ZxXXbBoaUhtHuVxcRCW
 5GbCWQ5x9/r516wZl3/Oj8DcPeunutM0bnOKUpajNOV8wO4GJugmGCYy8yk/RlnE
 6qQrGCLG10WgbWCSBxt+NRi6WCxH+BaO9oJg4ROc8sE8J4R23hlUHggZqDvgLYdD
 p1oVAwuSpM9kJ2wD2OMR5Kn46uF7sWdEiHOVucp3FEgzFm3yK3Dtv/VZtGhIKWBz
 1pMjdw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfbhu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:04:36 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-423780ec681so1256278fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776863075; x=1777467875;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w9eW7q2/yfswm/0EP7ohuo6irtJLMRsFkiVDHy32ekA=;
 b=SphHW3z/FPmTy7ephSWnhUwAvVptvaFOnhRJdEyKRWT1D2L7NSmiFF5RXXeQxpNMti
 xHMIvuNG3puewWy3VblgjKHyn6CG54LeZNE/owYk+xD/TLUFXJ80uKFJXSqLI257yUc8
 eUAfdf6NVzPX3sk+5/0sVZkFOkHDuW13qsIlCbiKwCFHrzAM2anr1aWfb2UAB+01TVAs
 G9MWWwtceCxWiVKB8OboDpBu2QGJFjrFy8O3VrYaDxy6TVGxRI+BvQvK+VZHXfPE3JqD
 ss2lVBo2SFPRGuo9AJDEX6a1rnSzqWZVnHrGsAZ5C+O24k/nrARxW9dbpEDehtalPDig
 Mwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863075; x=1777467875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9eW7q2/yfswm/0EP7ohuo6irtJLMRsFkiVDHy32ekA=;
 b=aRBfk6pdo18xwP2oWPJTsqkPpTD0RG/yeFRZ0TtOJbS6P/mj3U5ODfE+j/tSvwai+3
 LMkZPK0uqwe2vsCRw/z6JPyDiaAKLlb4aqsbyLKPm5OG3us0JXCQb3c0nf+/z22XtTZ2
 bakiaj903UFx1RiDI2NaMruzTNbeV4Jn22mRYe8GeDJftvdtFmpj4yfzjs+X4P6zZUno
 wmuZOvvPMAy/Y+tR27HymMQ1x0xmmEm0asbOSEbFR+o1RjZDTTBDZRrsfEZdXemtUrdK
 kxQFTb8yXPvh/CMRww3BqCxO/wnWshPa1ft3dbN6G0iG+uNIOHbiLhEkWj5fVBORh8Qe
 5NEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zntLcrJp6eB82RLnsLjxmG0O/wfkaul4FxSXy4vuaaHLF+qIZcSDHkDI3Lsj/BKVU3lu0Jn+TaF4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk1jozFUsez5eU3RbpLQi8EJMSe/BUiA2d0NAsdynXlitPUYZb
 hAu35pfURyY4NEmmmFs0urxmKgA8KbZRGr2GJsTwqETE640PwEiwrN0im1ztq8CqFeJGLmsfKL2
 1a7IpTyoWOUmtwEZql8RVx4Svkz1x6nD/r+V4ntY95oiCoGhViDlFBueRQ5rG5TzOpco/oaA=
X-Gm-Gg: AeBDietStb3HHjA0VzqIov+BC6uI/iGLt4fRn+uiG1tJookcfqc3Ffk7ZiluV8cp6nD
 6/Tr9PUCTcLhnUulWvPVhPkr4vq/AtEBESGxkEAFH2YJS4nzIoOv21HeKEG4IlAkyM0Gqafy8uN
 BVDkdPC5oYhPORqd1l7xUEui3SCADWuvkZHHN6JxY+CBaw1UeBNMcMzc3LewDfTVpD5uowVV6Py
 oIGQp5BY1q/5aBgJqULunCWPnfCLtwbt4bS8ebowVKZRPGSF2E3VrU1NT0uwqlptIHWFMwYrqDI
 zd8p1yeFxG/dPLBE1wYlA8R62fDEdO2F4en3dQU6MR686tjPo6DErsZrCG5NU7GfMHaSqLtB5v5
 3dzc3b3GQw3/FDLC1wNnW8VTzLq0/Wvm4TMu19V5yX087YKQqt5PD3y5caio+SC7SlZSVILpXG/
 T7n3MnjQlWNHffEQ==
X-Received: by 2002:a05:6870:3269:b0:417:4754:c10e with SMTP id
 586e51a60fabf-42abf209f86mr8474869fac.1.1776863075397; 
 Wed, 22 Apr 2026 06:04:35 -0700 (PDT)
X-Received: by 2002:a05:6870:3269:b0:417:4754:c10e with SMTP id
 586e51a60fabf-42abf209f86mr8474824fac.1.1776863074872; 
 Wed, 22 Apr 2026 06:04:34 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c480e21fsm3263165a12.8.2026.04.22.06.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:04:33 -0700 (PDT)
Message-ID: <23fbb36e-56b4-4ecf-94e9-4038c6311b31@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 15:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 6/7] drm/msm/adreno: add Adreno 810 GPU support
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
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
 <20260416-adreno-810-v4-6-61676e073f8a@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260416-adreno-810-v4-6-61676e073f8a@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HaXVqYuFO51xNoqYfEyWFj4qyqLx1DJ1
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e8c764 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=RWVxF5DFbFL-aEys5QMA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyNSBTYWx0ZWRfX3yW76ZJJMe/s
 Cb/nxXAfkwymDGeQPdLKSqeKLmOST3hbYc6/nSGo4lUdz926wgPIOl8V1fDGhfcbCByvlXGvOkc
 e6X1PfTBVWd95jTz8lL1Axfm0Hf4NH1oYxJ70R7G2D89ELkAWAM1BNjTZNe1ngwsVBrLqU1WQoN
 lh2GaxtSFEtwoBAWEPzGupk5kJh495IrE/ea6PvJ4mWvhhchAuDmSG6u84Lp5EJ6bGqMZDc8tjJ
 KCbnWj+yZSmSDdoW8xarx45tlD3ILnNj6QSv2QoiklL8IvI2zd3jEv4tBazaZwhU9Spd/IJfnDT
 FIq4y7rJ4HOmRkQJZzOBKnNbroQKCM+alPSYWhMSyTnE/dFsxgchzAaQlMzQiYoKF96oypIzlvw
 64R10dQhdyl8qmzKK9PqrgPz1y4G+9Megaqhvlinn/wE2jNcuMbD59Z+vuSUh0oK0Uk3VznDT03
 l4JVgcf3g9kvRfv6E3w==
X-Proofpoint-GUID: HaXVqYuFO51xNoqYfEyWFj4qyqLx1DJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220125
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

On 4/16/26 1:05 PM, Alexander Koskovich wrote:
> Add catalog entry and register configuration for the Adreno 810
> found in Qualcomm SM7635 (Milos) based devices.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

[...]

> +static const uint32_t a810_pwrup_reglist_regs[] = {
> +	REG_A6XX_UCHE_MODE_CNTL,
> +	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
> +	REG_A8XX_UCHE_GBIF_GX_CONFIG,
> +	REG_A8XX_UCHE_CACHE_WAYS,
> +	REG_A8XX_UCHE_CCHE_MODE_CNTL,
> +	REG_A8XX_UCHE_CCHE_CACHE_WAYS,
> +	REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN,
> +	REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN + 1,
> +	REG_A8XX_UCHE_CCHE_TRAP_BASE,
> +	REG_A8XX_UCHE_CCHE_TRAP_BASE + 1,
> +	REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE,
> +	REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE + 1,
> +	REG_A8XX_UCHE_WRITE_THRU_BASE,
> +	REG_A8XX_UCHE_WRITE_THRU_BASE + 1,
> +	REG_A8XX_UCHE_TRAP_BASE,
> +	REG_A8XX_UCHE_TRAP_BASE + 1,
> +	REG_A8XX_UCHE_CLIENT_PF,
> +	REG_A8XX_VSC_BIN_SIZE,

This REG_A8XX_VSC_BIN_SIZE is removed from all lists for all chips
in newer kgsl

> +	REG_A8XX_RB_CMP_NC_MODE_CNTL,
> +	REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP,
> +	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN,
> +	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN + 1,
> +	REG_A7XX_SP_READ_SEL,

Somewhat similarly,

TPL1_NC_MODE_CNTL
TPL1_DBG_ECO_CNTL
TPL1_DBG_ECO_CNTL1

should be preempt+ifpc for all targets, it seems

[...]

> +static const u32 a810_ifpc_reglist_regs[] = {
> +	REG_A8XX_RBBM_NC_MODE_CNTL,
> +	REG_A8XX_RBBM_PERFCTR_CNTL,

This list matches the expectations, modulo this RBBM_PERFCTR_CNTL
and the registers I mentioned above that should be moved to the
first list

[...]
> +static const struct adreno_reglist_pipe a810_dyn_pwrup_reglist_regs[] = {
> +	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
> +	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
> +	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
> +	{ REG_A7XX_RB_CCU_CNTL, 0, BIT(PIPE_BR) },

+ RB_CCU_DBG_ECO_CNTL to BR

[...]

> +		.speedbins = ADRENO_SPEEDBINS(
> +			{ 0,   0 },
> +			{ 242, 1 },
> +			{ 221, 2 },
> +		),

The DTs I have all point to SMEM-based SKU checks. Did you find these 
numbers empirically?

Konrad
