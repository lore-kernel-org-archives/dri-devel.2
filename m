Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8071C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B368510E12D;
	Wed,  9 Sep 2026 18:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pfj3G4Ib";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RUeIAMXA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D34910E1F0
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 18:31:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689H7Z6O2600030
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 18:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DYCA1Sf/sCKR4WUaiBuPo9s4vAkj0GrzntRClJ3GrEQ=; b=pfj3G4Ib/DbZ9Qdt
 fyg/ZtxFpqiewRzCKI9FxlewKlMs3QgmP1lwZ3KJCfzqUsbaCPkMsJ6LibVdvR2F
 7aTQrHaH8UjyafyiZMM7vpqkAuWvhdrZIdNJBsj3NHf20sSemLoyblHm0XHjJ3cL
 HhE1TkPn02GK+6MYNfkV82aonK7+DarfqhQb6slARvAKNwcKc0b81IvC3eW+GuYe
 nnVArfeuivql23+S1X9AlW2K7sKV3gEuiCzieuu9vqLRx+yqfcjUdk4R+rHo3Q7S
 8niYfAGeBv04hmxpv3jbFvoK4QurXGXH2xTzPkZAOXrG3B0sA1x8yzzXOby5J5em
 35wIVQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r1mmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 18:31:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398ba5404d2so2670932a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788978710; x=1789583510;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DYCA1Sf/sCKR4WUaiBuPo9s4vAkj0GrzntRClJ3GrEQ=;
 b=RUeIAMXADMl8VrIl/8q+8yjB4WeZptGUIlYPXRMMw7J8yuhflv8/DYEg/WUWCKNq0x
 MV1x7e9nC1bab6lJZ9YtqhwMFXmV03rXTqt8+ny18J64AGG82q9kh1rcNCGd25ZlqyS7
 hoNLiR+qrnkVA/ebWHkixgZsto2Ss/McHUvCzorie80zqCWdnwaNbTpa4PT13lMpp6T0
 CpjGwx+epHCr8OH/WkeLwtGgLJ004Saq0aESscRdJ9gbPB+30DFEB+jiIrxDn+wva4V+
 Gvr1TqDQ1vjNN0/1O5fKGM/rHBDHG8kbMQLtVorA2Pdmn5Trd2iy7ijJ68dXWtlZ/H2o
 NHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788978710; x=1789583510;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DYCA1Sf/sCKR4WUaiBuPo9s4vAkj0GrzntRClJ3GrEQ=;
 b=bDnWZ8X91WF9obHk3FEs6ujtJfJgfJzs0N+BAnDSyRDG1n5pe2jdMvGQc2mvdHpA7F
 O2GPuIDiq2zRaVpWFFYD1kD4b28rVM41aEoKHYYKRKH8f0oxBAqP7Cw2botaJhOgEvaf
 ECAsQZdaeuoTLiu6R5NfJsRgHDD9FP7tIb1NLlIGLNLuRJv8j1L7NpZfvMD3++SfHwEy
 EK21OgAqz4/62cdx019YQW6l/4IMEvaub47OO8M670RkdBV5ekOG6q5N2RI4rcYQL5jR
 o1oGUbKXcWhmMAFnX8pCjC4a/gvqf95g4UCRxmn+tkbyt9rySrQUT7RHMRFGArDytaVJ
 FZUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9EWZQVg+UcttL/Mt6+FAKsqwsf9Zx+CwH+ZcVR1fc0px2BvI7b3LuH9EIRatxv22Z7yrpmn5lwy8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n3QG+PXUzT5cyso3+HuaB5aE433QRPYnb6Y/XjlpQ8wQ4mbXfH
 QiY7LICUoQQZtnxCNtkxZgEq8xmiNg8AdyRdSXLokZrWjtGxbOSOYTgYNQN7JjUUr9JIsGOngl2
 7aWDAecEPEzOOZBT0OB+TcxPi3ny4cIwj9VgZO6nA5d98kWUqhULQUG7FG30UTDER597Jt6uC9j
 g+8sM=
X-Gm-Gg: AYBFou3pM4hZFYmwQOwOR1uTzcMty6GfJpX3azvYgNYGzZFLpRSJoiTyCV4komzCn8p
 VDZE40PFHJt+pghs6IJGmsCw80tfSu3j/+woHbjUiDhMbyj8O2v/C2g7L8TD5BdCjqrX3WY+zKP
 7SNR7ONvp3TsfoFDGt31DdoSWdBOuP+R/a79ZCB8S6/orEwahSMKDqe6WnfXkhBevxVAWC9sYvT
 C5F9ENDXGdGoXMyOdpvGcetfBrn7ZUhBEvfjPLZxzUQMg/mc2DIVyt9uCik0aP6txsD3kwVA48z
 4+OGjFM7Q05yT5N0cncmGi6kJVpPammFIBmL6wHKd42i5/QksVmaLUzdLv5Os/GHie0EVY2FGKL
 SxocU5VM1FcNKZFZGwwV054W+
X-Received: by 2002:a17:90a:d406:b0:395:4de5:1054 with SMTP id
 98e67ed59e1d1-39d70b4e3bfmr3896745a91.16.1788978709780; 
 Wed, 09 Sep 2026 11:31:49 -0700 (PDT)
X-Received: by 2002:a17:90a:d406:b0:395:4de5:1054 with SMTP id
 98e67ed59e1d1-39d70b4e3bfmr3896632a91.16.1788978709223; 
 Wed, 09 Sep 2026 11:31:49 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324410092sm42858991c88.14.2026.09.09.11.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 11:31:48 -0700 (PDT)
Message-ID: <33be46a9-207d-4f0d-b3e8-18adb8197a57@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 00:01:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
 <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa1a616 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=ubtBxe2QYwUAodWgXbcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwNyBTYWx0ZWRfX1QqIwq0xeu4x
 NankkoCRPHg5XiemH5fZgheDQ68nUJP2dlh8fHhyGNHsjKy6lPwdyHzXzZF/mzOQJ5VcMlcqxqX
 i0nM0kHDoyt6DhWHd0X08ivyP7PPasSSqpOtl7CmenuUxPhE/IUCLw3ex8WqMkZqK5p471pwXR2
 rTEo2ydioWouBUjl2rLYCAA7TpPmN5KdRWqhk4AoQ707ZKufUhHzpCMtceVxBvq35Ro7fGIBP7N
 C/Pwq2ToqZ+imeZUr0qn0t27/5q50j8iO/G5a4FWjgCwHWVA9TI0+AkPH+lrW/Jvs8R4ftuPWJT
 UuOl5C9Pth2/jElF0ar9sCjzXcUpPuJ8hHGmV/1QW0SD+IKssibVmlHtfbe1dTo0E2h+iRUz8k4
 iqXlUdNvfrV422GMGLr9vFzWFgWZ7cTsvnePalpWixP/1wi3Co3vAD1j1aOYinlFx7oPoJ/ov08
 GazyBTtR1tqzNCxPw8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwNyBTYWx0ZWRfX6Don1Wd7rUOS
 Akk6najSSaJpGaWfyYTeHYaXkQX7qd5aoAkXHSr1QrVJVyn3KNrVwitXUvU67UTdGZMtGoqe0px
 +dyOxcH4F0qiq3AjKbUZxUNzIuLv0Y4=
X-Proofpoint-ORIG-GUID: e_mk6RuuxxztZjwqPvc3bB3eDhtk1oCo
X-Proofpoint-GUID: e_mk6RuuxxztZjwqPvc3bB3eDhtk1oCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090207
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



On 9/8/2026 6:54 PM, Neil Armstrong wrote:
> The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
> register on A6xx and other A7xx GPUs, use it when running a A750 GPU.

Do you see any difference in behavior? Both counters are synchronized.

-Akhil.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index f9de9329dee3..081e79ea4652 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
>  	u64 count_hi, count_lo, temp;
>  
>  	do {
> -		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> -		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
> -		temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +		if (adreno_is_a750_family(adreno_gpu)) {
> +			count_hi = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
> +			count_lo = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_L);
> +			temp = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
> +		} else {
> +			count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +			count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
> +			temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
> +		}
>  	} while (unlikely(count_hi != temp));
>  
>  	return (count_hi << 32) | count_lo;
> 

