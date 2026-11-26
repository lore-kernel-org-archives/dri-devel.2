Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E159606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YkzDBpou;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q9AJQLtV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D9210EAE4;
	Thu, 26 Nov 2026 19:48:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E175010EAE4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:48:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJe6JM024336
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cb4cbrx5kZY+Yme6rnhcpB882HS6oqTOJ86HCQTYrak=; b=YkzDBpouGmTgUZwV
 n3FFqPM8RqNM690b8Ns3q+tXhs2VHZxIKF5NaMs+H7tiElze7GGHZlPx8Ka0NhGd
 st7mMLPt3WaqxSOU4vbK8LIFqF0XNXzBrEz0sLEApjptSE4r1LNk9xv4Dr6FUkCZ
 5IBsVgWANUgvWUeyW7+ECfG1xdtkgLwuNXJJOwyDTs325a98MYBc5JOSMBj3lKFQ
 OnA6M20tkqB1HYXQbWkvTwGP89nmyLJ48557p51OQbQzUjnSSaZXTYt4T4AP7IO3
 j04qTFYWWFEPOP61ymxNHOlzgdhBvRbpR2U7Gj80AR2i4dkd4h/NG4k1f5UIiUXm
 t+89qg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hr0qw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:48:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386177b0516so18383106eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795722527; x=1796327327;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cb4cbrx5kZY+Yme6rnhcpB882HS6oqTOJ86HCQTYrak=;
 b=Q9AJQLtVVJq71OTGtScBz7eiBGZa4uxHTSd/6gNUz2jgzbWAftI6Qra/ub4W38pxg4
 +nziaW6m7oOVPxq+U4/ggcYyJqpUZFXciLs2eWSMEUsbfJlkSK4Z+5779suxBKDeZ2sC
 JonzN6CgDLMMGd35MzCgPxyYhE9waHRO0m2+0Ygxp3Okuj0smC/Y3jiI8KOZH2LTdE8+
 k2llLXXUdYJGPeeC/D4jnvO0ms3xp0tI2CdPUYEvWrMGB9tv/yeXPw56VlQAIyyPHnql
 oL8T6BpAp93nUMRSMWOq6zpD+NiTeUIaZgE1sm2Rz7HBwjPiiQtL4v7HnDObX3Q8LReb
 kOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795722527; x=1796327327;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cb4cbrx5kZY+Yme6rnhcpB882HS6oqTOJ86HCQTYrak=;
 b=27A6hhq19Ttn3J/IkoaU6wKMm71c+IZVQMlfgNeEpL8w5tkSvm3ekh79Udf9MZm2cX
 mW4YfLt8DUM4FsDTHpjyb5L4zID5RUrTeKN+z+Mzw71ubmTdFhE0agqhsJ7/Zi1GqAZM
 CYL34zJxzq9scOxFqwCkpKt5MBLCaHAOdePw+VW2uhJ2qTXmQzZpI0nX+THxXBvELv65
 AXRQDIZA3kr68bYnuJQVOii3iIeRyLFGukJk2/hNCcD2RI77iUbf1iJpIuRoFQw3BXAO
 meYHWUOrgHcMEA2ITgi8vJgEc59gdzOkWZQGpiIslFvkGcB9ynNEAK/yfiYfiMXD4IK8
 K5vw==
X-Forwarded-Encrypted: i=1;
 AL+hErH0+4e/VrtaP/dhnBKLIy3qpk1ecHF4bsKHMn/zofOmS2Hb9DafKTv0UnB6NeQOjUZ3OLkLaXN3syY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8FbYBsSOUrBQtvWWtNsfc29MladWIKgm0HfScXoL6skysvTgFv
 Wpg8/tGN3J+O0ZvTq74+0zrGZKoMjXHBA9q0mo5983JzZGhlffYfkHB3ViO4YGo6/YBb4dvIWD/
 Wo9svCPeRplWIetz9M0ZXwdwWSnNaUyIlvJSQJIm8SUxjzKo56WMoGn2cvCsjcShqgmfcTWk=
X-Gm-Gg: AZFdTZfmRNyEI/mAf3sVvwEyYRBEAB39c0mGserCOTRFwFw2xEC0lWXlY0igetrDRoJ
 aNphBMtWh94n3k89rtY6wGJE2xUUUcNmrzK24yk3cYwQscG9yQ6hrzUizMeRxgE8Z/wFodnNoDC
 PbWCjs3pYT+TTYUhBAvbkUtkqjCayH7HQWLHRpPQKRcsZqQ/UCkTpUsaDQGjyD9xB+HfUkjli1A
 3TDX4CSpml/GdbYdpX8KP/tTNK3mUtKAX6lQd0WDqxZZntRbO+hXPPOLerFfDPmua1JKRvuiVqC
 rAJAYAWYQwMYYbDMRKufhIEMxmdHkXZXy+J1DbpdK2EI0zpjdJa+zgBMz/PlNO0ztA7tQB+3Ed5
 JSg8mVCjCjHju7jzNVCgoQTXZ/f/R5uqyMzA+sUYGti1o0UPxKdDc7+A1BkmdL9jspi5Ebonb6A
 ==
X-Received: by 2002:a05:693c:414e:10b0:386:a1ae:6762 with SMTP id
 5a478bee46e88-386a1ae6d5fmr19047980eec.36.1795722526664; 
 Thu, 26 Nov 2026 11:48:46 -0800 (PST)
X-Received: by 2002:a05:693c:414e:10b0:386:a1ae:6762 with SMTP id
 5a478bee46e88-386a1ae6d5fmr19047950eec.36.1795722526108; 
 Thu, 26 Nov 2026 11:48:46 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm74349135eec.26.2026.11.26.11.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 11:48:45 -0800 (PST)
Message-ID: <b95594e1-fb17-4058-abaa-e889eb6e952c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 01:18:40 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/gpu: Unwind power and clocks on resume failure
To: Haoxiang Li <haoxiang_li2024@163.com>, robin.clark@oss.qualcomm.com,
 sean@poorly.run, konradybcio@kernel.org, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261119034718.2818183-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261119034718.2818183-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NyBTYWx0ZWRfX6/UC22bxF0UI
 2ChAl/kntabEwhouJFJAlCCWhZtFjulWDJk7jlDB/+V+GGHYH4sKikTUQXG9OK8jUKiorsbiB2m
 ZA9i8HlToJPnGhZrQ8Abu++XrQLtNwY=
X-Proofpoint-GUID: myH6JlqrxOUUs9cL8dbBJsPE5e7m-RDI
X-Proofpoint-ORIG-GUID: myH6JlqrxOUUs9cL8dbBJsPE5e7m-RDI
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b088d1f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=9G38XQudUm-3WiMgdEYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NyBTYWx0ZWRfX23DbieggjPfo
 LAignvnHXjcXKbisNSS+mbabBWMXwzod3fR7nSfYG06PyRnMqBtc/GtB0TdALNR0lXBfRNHfPZi
 XPwei9WVn2ctMDpfrPvBk2OdFaULP5VvMlXEfvk6k9RnVyQ6YrfT3bO14ey1R8bj9Qqg2u3IdvK
 y8Mt/KYu8Fb2Y+e2heRvvk/EkbaFMX+KhhvAWDzIBeyvXol7U94kUYcqONiwQ8QUJzgk4ZUX4Hb
 NbA95BoVQ8Fpnk5/HGAzob7cTxemMRlhtfVaMkSKGsu4l8hxK4mReZ9vhQ+xqOTS/X/NvGMWZHf
 TM/wHXC10SgVvQG6Fen+tYwyVBlb1okhRcZ0tkPM2evfIOK/X7HKf57TOLBrYffvazm7tfHuoDn
 /T0ZxzBuZFoXnjA2cFI28DD1rPUNHUcdzortm6aK2w7qDUwITtY/YJbiTwen6zo/0g8hUa0rMIg
 k96O+ieq0gvPJpjjfNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260077
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/2026 9:17 AM, Haoxiang Li wrote:
> msm_gpu_pm_resume() returns without disabling the power rails when
> enabling the GPU clocks fails. If enabling the AXI clock fails, both
> the GPU clocks and power rails remain enabled. In addition,
> enable_pwrrail() leaves gpu_reg enabled if enabling gpu_cx fails.
> 
> Disable gpu_reg when enabling gpu_cx fails, and unwind the completed
> power and clock stages in reverse order when resume fails.
> 
> Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 8319119041eb..5480abe1aba2 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -40,6 +40,8 @@ static int enable_pwrrail(struct msm_gpu *gpu)
>  		ret = regulator_enable(gpu->gpu_cx);
>  		if (ret) {
>  			DRM_DEV_ERROR(dev->dev, "failed to enable 'gpu_cx': %d\n", ret);
> +			if (gpu->gpu_reg)
> +				regulator_disable(gpu->gpu_reg);
>  			return ret;
>  		}
>  	}
> @@ -110,17 +112,24 @@ int msm_gpu_pm_resume(struct msm_gpu *gpu)
>  
>  	ret = enable_clk(gpu);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pwrrail;
>  
>  	ret = enable_axi(gpu);
>  	if (ret)
> -		return ret;
> +		goto err_disable_clk;
>  
>  	msm_devfreq_resume(gpu);
>  
>  	gpu->needs_hw_init = true;
>  
>  	return 0;
> +
> +err_disable_clk:
> +	disable_clk(gpu);
> +
> +err_disable_pwrrail:
> +	disable_pwrrail(gpu);
> +	return ret;
>  }
>  
>  int msm_gpu_pm_suspend(struct msm_gpu *gpu)

