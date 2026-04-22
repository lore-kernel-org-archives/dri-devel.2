Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206CCF9EDCA
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A9710E2AB;
	Wed, 22 Apr 2026 13:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xos37Opm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ab7WVq7a";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DDCD10E2AB
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:04:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAarhd4051049
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a04HZhr0fPZ+oBqd4QTLHz07/4oVCHQZauM9ulH5LBY=; b=Xos37OpmqLJC6nZW
 HWsjiyfKQKV9bY5zvS05hojSh6pkPK+qQBaAvEAd0GLqwycdAsy8wezRtp1UOPtD
 yoJO5VbRdToiG95o6RPvJ1g+LwrKdc4zRY1mQxKmWCk0hBE5vya6cJnNfQi4C4rn
 Jj71Kcf7/QTJVOVXFRnKdqH9rGC6gzV78yhFdPJqbdnu1bQu3VnyV6jV2AGaIOPa
 1Kcm/ZpoM3awJKIng48iAOuoVY2thirK8INTQ+PyFqu0fFWR5hLzSCG381jYwnhB
 Wi05yt1QdCPoSPThH1CaF92w/OJ5dO+i82QSGAI/YadFqN2E0jCn1KthNyuTxEVs
 ODD1SQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfkhm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:04:28 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-479df2e8aeaso705099b6e.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776863068; x=1777467868;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a04HZhr0fPZ+oBqd4QTLHz07/4oVCHQZauM9ulH5LBY=;
 b=Ab7WVq7akagxMkPgvHMz8lPRrQuZLa3lzBS35jpfxJOFqZCjERHyS+kVJBeEnUEFFQ
 K4qKZbHP047ltWQd+uPzMe/ZXUkJlRFRuxUBbynpHUbHj+K2Oh6BF0YTuQlBpoZW8IsP
 lADXSduFO4IC/Nfjhnprhid46aJWlgcgXfc6XNCLGcDsEqpmim6ZyAHjsfbAWJa8Lm/I
 /l7hL+J8/DBXX0/UzmUkIZJl2EmheZ2tHYGwo1LQkdO/nwavJcUYgg1JV2dXXIUL5rwq
 6uzbcdk3ey1KDhlDIbpMT9eSgUpuwc7aWYNObTtDiR6bTtqISyKvEWPDqYjlzSbXShba
 tEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863068; x=1777467868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a04HZhr0fPZ+oBqd4QTLHz07/4oVCHQZauM9ulH5LBY=;
 b=Z15+Q4pSeg7KErqyG4+93lbMlDpCzReESXEnKnkbI7DtMP+KA+mu6oP/4dxwY/f5GX
 rFm3YRzBa5womfrdi4Zoc6lrzPkyzKtJclS3MMNzHwvXPp1qknbbwTiFlkS+i7vhibIx
 /Kfj+hxEJnd2c/ck0AkNC8d6HYjJuIUb+8YBIvkK1vW5LneaxRiSNn2ksJvVePUwRCMN
 l/a7LqibHeW2+hhyyUN3aJsRQj95/b3ZmE3Hc9ngFIK1Ox3Tkoy2gV4HPzXPK3ed+Z+P
 vRMeO4UwSGxVfQlPYdwA3PknuWH8zzvZpMmdIEM351Vium5m0tUhhRIS1QQlyGmOAlKT
 JWaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tppUxNAUef6yxjSGK3QgOORJ2u4iaXqEarOT4YK7tPH2sVX5wQ4lkJMIIcDjea1iLhXyjddttug0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy90eu4NPUVq3f40eYybd3nwn5i90GZeCGPFdvzfwFnp8QgP1SX
 Rcs2DHWdbTr6DK0cdOtLC196+fBF0My8FzVpKQiBsMabA90XLA+02/s5MXy6O9uNhiLzpx7k27H
 3hzc0wGc07aUEfjpjnonjQUnBxp6Wh4jRwJqQw3jHuBi5kLKtSoXyNDytBxXitwrGxvLMFtM=
X-Gm-Gg: AeBDiesnw9k7YnRcK7QmiZ8WzTEILhMOSdK67rS+qMCpHWW2hNjg89m1D1HgbmfwgQz
 ncwAixiMxSv8ptg4v239M2CgpXvDTZQig5tbo5+0aZIsUEx3NGKPzLvW2BgOFLAMcZn9IEeF1YX
 XqbjCDgusIGL7TRWTSAehChAOz5gGn9fIjO1qAZkoKm3KP4lLpqt8HA6NtAe1wRITMbntTeu1KK
 5WEL1c6r3bysq8frwDFdvlj+vZUKTPPlc17bVQoA9goSKsVLHmu//USAsUjzyRGVSOgZIBe/+np
 eFIIUP7vMl+Z7XVyIHzUcYi8vqRT7Ik2mhRej+ZSlp1hyJVfwj32ooZ1spP4ANgIqycZyOo2yNJ
 J54EuLRnkVYw+660UzgulXCZagW2j+12Fx74zEaP+4PLYE+rz7mkAFPIHm9wo4axlLClg54UWCi
 SQEziyV2FjmoFoELnYUQbKSEeC
X-Received: by 2002:a05:6808:181d:b0:467:ed9:ffbf with SMTP id
 5614622812f47-4799c9a66acmr7362099b6e.3.1776863067907; 
 Wed, 22 Apr 2026 06:04:27 -0700 (PDT)
X-Received: by 2002:a05:6808:181d:b0:467:ed9:ffbf with SMTP id
 5614622812f47-4799c9a66acmr7362035b6e.3.1776863067208; 
 Wed, 22 Apr 2026 06:04:27 -0700 (PDT)
Received: from [192.168.0.242] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba4512115d6sm551798466b.7.2026.04.22.06.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:04:25 -0700 (PDT)
Message-ID: <eccce3f2-01a8-4454-87d2-3a599a15b34f@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 15:04:23 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyNSBTYWx0ZWRfX1I8HOoYezDrb
 pWv9sJJwG3YdSzC9RJLoX3N2JOUNMjb/ktIsgUp6+L6u17mvYqhMc4+9ezfu23OwuyY8moldf0E
 0YYlcWas6GCTZQMBNT8MjaK7rtj/N6w4FICIz3/YB2Y9zn+/5U7IZNGvS4CILPCd7lD22+t/tbj
 6zpXFsBWZGbNetgCDXgApVqMw25QA9ON4e6W7J6oVeRjet67VGqoi6+iBlvxNtdg6j8VDpV8tfh
 W3BEJSYYEIWzGRcJOKP6kG9elOoVTJlH3ODbX2C18TBQT5gZ7jerQSjNHSvHiim1SQt4HRbcbmo
 UyVj6PqOd4vFd4Ko9LC4wnZwDXZk6EY7ADTopUpNwxU3uVO9Bm429NXA5RDvgGFyDjfEEgk415Z
 5tPNzzk4OUJU2g3wQdwBM22EwcuMK+vAzOlmQVclB3vLx7gkDzOL8lnFMKf0miciestqlInLQGz
 HP7eak4tgWqtf4XzV2A==
X-Authority-Analysis: v=2.4 cv=VMrtWdPX c=1 sm=1 tr=0 ts=69e8c75c cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=B4I3uEKCwWxQvTZmuDoA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: _6qw1Mn-Mk2BcGqs4Bn6Taj5wTo_-E6_
X-Proofpoint-ORIG-GUID: _6qw1Mn-Mk2BcGqs4Bn6Taj5wTo_-E6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
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



On 16-Apr-26 13:05, Alexander Koskovich wrote:
> Add catalog entry and register configuration for the Adreno 810
> found in Qualcomm SM7635 (Milos) based devices.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 296 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
>  2 files changed, 301 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 550ff3a9b82e..1190804632d6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1799,6 +1799,259 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
>  };
>  DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
>  
> +static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {

To align with the latest kgsl which includes all the latest
recommendations, remove:

{ REG_A8XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },

{ REG_A8XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
{ REG_A8XX_TPL1_DBG_ECO_CNTL1, 0x00000724, BIT(PIPE_NONE) },

{ REG_A8XX_UCHE_CACHE_WAYS, 0x00080000, BIT(PIPE_NONE) },

{ REG_A8XX_VSC_BIN_SIZE, 0x00010001, BIT(PIPE_NONE) },

and add:

(below RB_CCU_CNTL)
{ REG_A8XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },

(swap in place)
{ REG_A8XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
{ REG_A8XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },

(below UCHE_CCHE_CACHE_WAYS)
{ REG_A8XX_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },

(below RB_GC_GMEM_PROTECT)
{ REG_A8XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },

(The order doesn't actually matter but it'll be easier to diff)

Konrad
