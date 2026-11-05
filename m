Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F94606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PzL9Mq9k;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZVUkpZqp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE15910E372;
	Thu,  5 Nov 2026 20:19:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC7410E353
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:19:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeNXU1485140
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lxXTwSAlvx9lt6rkuQmRiJRYp7ZZFMogLLhtoRNClYA=; b=PzL9Mq9krBZg4xSS
 eu1nGVNKLj8C5vTi9rWUqken8D1xApgsIglnoN/FAbWGJLT2d9LQw25WMaGOkDtk
 d5Xe/tXxud64iI4K44vOSS1nATdsHWnWmv4B8lWWTtxvjFma5nYUUtKXpzB3WUEr
 Gck0EaikC3YBi13ciQ5qOM5SKyim3V3hpoEe1c8ZaNia4rOLQ6S4PICQjlrTAFg1
 4hFMhdeIw860knXw9BexW1U4WrwUfgihNoj0MuuD5uy7iGxKzOrzqidCwYhb8cZC
 rEUDP6Up29wVeNEhitRhZ4fM2aDCUkjsNDN5FDl5qeyYStzChTldOLfxdrie3Wyt
 1z4pDA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaak4sw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:18:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso4382723eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793909938; x=1794514738;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lxXTwSAlvx9lt6rkuQmRiJRYp7ZZFMogLLhtoRNClYA=;
 b=ZVUkpZqpw0f2BXj8I2kdgrTPuhvebFIqA6e/NecWBji/BGQtxw96peMGHWez9A2GK9
 oUIfOqugCPOMiqUoUGTy6yWXPL5eVENcg8BurOr3YgaoN09HQQcJ4D+Up7LnItF4RHTt
 BmglNLGmF2zObmQG0RzKGoLIZRHXOQPG9j8HQ+UVqjUKSiMVOc72opUr8tC3u0wWNDre
 nPFasqXMZd3XtSW++YVORXVHo615cdILm68xxkMLjt2H7SqePvn/NjQW6ooZbs7qIVVR
 60B2vrMylo9ytWJoAVk7ti9trbraGG1gTbaq5Afix+kvKHRL3sNt4fwTlYv5XYKikqP6
 s57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909938; x=1794514738;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lxXTwSAlvx9lt6rkuQmRiJRYp7ZZFMogLLhtoRNClYA=;
 b=DjNs+b2q4+acMiU4AuQlqLpzXm245et8zIXoytnxmfHPmPooqJwfUZjMRwQKH7jNRH
 MRAXvUFknc6lnjyMtlvIdtcGkEmJ5yADLrv8c5ZMLstuK0iCJZqM+C8SpSd+/YHIkH91
 0df1z48PqYT+BgIwk24SmIjGxtb7Z7f6ulD0DMlWLFfNRfqzBqI1J69VJ+I5+x90/AVu
 3vAwQ6LyoFHMfcp5G/vjHaUi6Ii9YLxCj2FogwwlaOy7zyO/9HOzriQy4X9c+I0rHVj8
 LTwA32UKtanANM+ceU6ZUm3Ukpb1sB4IYszkeN1uEmBDX6Z3QOhvlRviVH9OuWN1F5X3
 dlWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+S/wvEHGazcpjGWspwDqAUC3FNrnyaZ6KTWkhCnoRFQ+/ayIomZFu2nhdJnspC7COLzmPQY5NJro=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9QVFUoc8zjRsoJJHEqdvlQ2l+G1erdgUE1tK+G78rfis+hIQ2Y
 HA5JsVONHrbOJG9d8gv4fopS/iAlpSPgYdrZFQnCv+XUTcsMQdwZeK6mRwuhjFzSrSoPSf7f131
 Cc/aMwg9TOUF4Rcm46e0TQvvCSBPVP8ExD0MT9kG+qNQf8i1MzXs5Wce/5oKrV+q83MqazPw=
X-Gm-Gg: AYBFou2FNvSMBWbMmTVfSbNh/vUprb+D8QNLRTjweSPIGTGEkP4BssSJu/hcA+I7sGb
 MMz05KfsdRRYyzWMTIAbttyVrDh34I+ng5Nd+KC1kXhMPQbPOOi/auU81uzSBvEcsPy0AIzWsV+
 TGAgTToy/j62Wz4cgQ4IoFIan/ziHB/nO2qfRz5s/prhkpKtxRCsG7T8nJG72WcuL8VAfKkP0/E
 YRDFC3bw3b1zanVQzW8KRQd9CqiCpluJ51qgvql/8Lh2/V8LtI6ufb5e6Z0bzoENAMDlo0+xt2z
 d7G2E+R+oK2cjf+tsRcA0W+KDKo7jr5A+yRxBrveb2mZgXyuzWQCMc/cUnX2rNo8EcHtYOrmnqa
 nhty+roA6N8ulJAlWgm8fBvnxjaXhUULNDkp8lnA8qc6zWwrPsXZRSy4F/CydsEAQzmyOkWw=
X-Received: by 2002:a05:7300:f88f:b0:36e:8e6d:a0c0 with SMTP id
 5a478bee46e88-36f76b14213mr327066eec.19.1793909937944; 
 Thu, 05 Nov 2026 12:18:57 -0800 (PST)
X-Received: by 2002:a05:7300:f88f:b0:36e:8e6d:a0c0 with SMTP id
 5a478bee46e88-36f76b14213mr327010eec.19.1793909937286; 
 Thu, 05 Nov 2026 12:18:57 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f722eabb1sm614019eec.20.2026.11.05.12.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 12:18:56 -0800 (PST)
Message-ID: <4d591c0a-8488-4293-b2f2-fb77d87a5d5b@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 01:48:49 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/msm/a6xx: Reset the GMU state when restoring from
 hibernation
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20261103-b4-drm-msm-a6xx-rsc-restore-hibernation-v1-1-3250fd8eefb6@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261103-b4-drm-msm-a6xx-rsc-restore-hibernation-v1-1-3250fd8eefb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MCBTYWx0ZWRfXwYRZcYU9rL8I
 jBPbaYpxbLEPACRQxMczqYU9K2ebrOSdNWlLD6TUk2ODGJ3nhaY2e9MvTq3c/zkxOT4N5xZuUzv
 l2w5Y4CiRJox8jbB8bBl8YXjFxMIvPAealqM0EJgxyGSw2O7ubqHybSfZkjqjM4R3Hkhxx9bzxq
 6sNGvUI92WkYGq/LrKUUWs0w2kYJQAheOOEuinnCoKHPc6ug40Im4EJyvnohBPnn4gtTUUhQym9
 UKk3uEIfZEPW0YLCf7PFtPjYrbue5jCWFAOtEYOxTINQhGiAsEtYngd+y46hzkdWKzGSGeEdLpm
 oHAXb3wuD67WTfabh3WolgNbrHhunbRcVHRn3v8QNInjstlaG0e9bf4xjC4/GtM8QMVRQKIwOgx
 8IEPGUeJdnDrI14o1IAgbhkg+VK/lvh/zlZ3Cvy+p2UwtTkoLt7NtKpQoixtkEODx97ArMGPM7E
 pUHeju8KXDRguvGb+uA==
X-Proofpoint-GUID: ws69m4gQbHaE3CQN0Vg6gz3l-JJhKK8Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MCBTYWx0ZWRfX3SDdqWLM4hsk
 iqBQwedTMDW/corohq4d8lbHgmCfub4rQCfKz7ZwNmKwcMzbc9nih2YDkDG7p4i3jqp0mVL9lro
 8KKLuEWIx/f48kL9Y9U8sCWFKdD+WnQ=
X-Proofpoint-ORIG-GUID: ws69m4gQbHaE3CQN0Vg6gz3l-JJhKK8Y
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aece4b3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VSE_0_8NIXlJEWB0Zz0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050080
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



On 11/3/2026 4:15 PM, Abel Vesa wrote:
> The GMU puts the RSC to sleep when the GPU is suspended, and remembers
> that it has to request the RSC to wake up again on the next resume. A
> hibernation image is restored after a power cycle though, and the RSC
> then starts from scratch, in a state where it does not answer that
> request:
> 
>   adreno_gmu 3d6c000.gmu: [drm:a6xx_gmu_resume [msm]] *ERROR* Unable to power on the GPU RSC
>   adreno_gmu 3d6c000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x0
>   msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 44070041: hangcheck detected gpu lockup rb 0!
> 
> The first job submitted after the resume hangs, and the compositor is
> left with nothing to show.
> 
> The GMU secure init has the same problem: it is done once, but the
> registers it has the secure world program are reset by the power cycle
> as well, so the restored kernel only gets them set up if the kernel
> that loaded the image happened to initialize the GPU.
> 
> Forget about both when restoring, so that the resume starts the GMU
> like after probe.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Sent as an RFC, as this only resets the GMU state the driver keeps
> track of. That is enough on the Glymur CRD (A8xx), where the AOP
> configures the RSC and PDC. On A6xx and A7xx, a6xx_gmu_rpmh_init()
> programs the RSCC sequence, and on older parts the PDC, only at probe,
> so after a restore they are only set up if the kernel that loaded the
> image probed the GPU.
> 
> The zap shader has a similar problem: it is loaded once per boot (the
> static "loaded" in a6xx_zap_shader_init()), while the secure world and
> the zap memory region start out empty after the power cycle.
> 
> Would a full GMU re-initialization on restore be preferred over
> resetting the status bits?
> 
> Tested on the Glymur CRD over 9 hibernation and restore cycles, with
> msm in the initramfs of the kernel that loads the image. The GPU renders
> after each restore, with no RSC, OOB or hangcheck errors.
> 
> Prepared with help from an LLM-based assistant.
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 10 ++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  8 ++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  1 +
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 22 +++++++++++++++++++++-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  2 ++
>  5 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 662f09bec9d5..1e6e47b635f0 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1319,6 +1319,16 @@ static int a6xx_gmu_gxpd_put(struct a6xx_gmu *gmu)
>  	return 0;
>  }
>  
> +/*
> + * After a power cycle the RSC does not expect a wakeup request and the GMU
> + * secure init is gone, so start the GMU like after probe.
> + */
> +void a6xx_gmu_power_cycled(struct a6xx_gpu *a6xx_gpu)
> +{

Need a check to skip this on gmu_wrapper.
> +	clear_bit(GMU_STATUS_PDC_SLEEP, &a6xx_gpu->gmu.status);
> +	clear_bit(GMU_STATUS_SECURE_INIT, &a6xx_gpu->gmu.status);
> +}
> +
>  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 92e8c8abb86d..962b497868da 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2796,6 +2796,11 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  	return gpu;
>  }
>  
> +static void a6xx_gpu_power_cycled(struct adreno_gpu *adreno_gpu)
> +{

This wrapper is unnecessary.

> +	a6xx_gmu_power_cycled(to_a6xx_gpu(adreno_gpu));
> +}
> +
>  const struct adreno_gpu_funcs a6xx_gpu_funcs = {
>  	.base = {
>  		.get_param = adreno_get_param,
> @@ -2831,6 +2836,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
>  	.bus_halt = a6xx_bus_clear_pending_transactions,
>  	.mmu_fault_handler = a6xx_fault_handler,
>  	.gx_is_on = a6xx_gmu_gx_is_on,
> +	.power_cycled = a6xx_gpu_power_cycled,
>  };
>  
>  const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
> @@ -2903,6 +2909,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
>  	.mmu_fault_handler = a6xx_fault_handler,
>  	.gx_is_on = a7xx_gmu_gx_is_on,
>  	.aqe_is_enabled = a6xx_aqe_is_enabled,
> +	.power_cycled = a6xx_gpu_power_cycled,
>  };
>  
>  const struct adreno_gpu_funcs a8xx_gpu_funcs = {
> @@ -2935,4 +2942,5 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
>  	.mmu_fault_handler = a8xx_fault_handler,
>  	.gx_is_on = a8xx_gmu_gx_is_on,
>  	.aqe_is_enabled = a6xx_aqe_is_enabled,
> +	.power_cycled = a6xx_gpu_power_cycled,
>  };
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 79912a33e17c..37266d64427c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -286,6 +286,7 @@ static inline void a6xx_cx_misc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 va
>  		((_ring)->id * sizeof(uint32_t)))
>  
>  int a6xx_gmu_resume(struct a6xx_gpu *gpu);
> +void a6xx_gmu_power_cycled(struct a6xx_gpu *gpu);
>  int a6xx_gmu_stop(struct a6xx_gpu *gpu);
>  
>  int a6xx_gmu_wait_for_idle(struct a6xx_gmu *gmu);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 7108d4aa59b5..b91b32e61fab 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -402,8 +402,28 @@ static int adreno_system_resume(struct device *dev)
>  	return pm_runtime_force_resume(dev);
>  }
>  
> +static int adreno_system_restore(struct device *dev)
> +{
> +	struct msm_gpu *gpu = dev_to_gpu(dev);
> +	struct adreno_gpu *adreno_gpu;
> +
> +	if (!gpu)
> +		return 0;
> +
> +	adreno_gpu = to_adreno_gpu(gpu);
> +	if (adreno_gpu->funcs->power_cycled)
> +		adreno_gpu->funcs->power_cycled(adreno_gpu);
> +

Can we please reset the zap loaded state here even though Glymur doesn't
require it at the moment?

Also, please ensure all registers are reloaded on the smmu driver side.
for eg: PRR configuration.

-Akhil.

> +	return adreno_system_resume(dev);
> +}
> +
>  static const struct dev_pm_ops adreno_pm_ops = {
> -	SYSTEM_SLEEP_PM_OPS(adreno_system_suspend, adreno_system_resume)
> +	.suspend = pm_sleep_ptr(adreno_system_suspend),
> +	.resume = pm_sleep_ptr(adreno_system_resume),
> +	.freeze = pm_sleep_ptr(adreno_system_suspend),
> +	.thaw = pm_sleep_ptr(adreno_system_resume),
> +	.poweroff = pm_sleep_ptr(adreno_system_suspend),
> +	.restore = pm_sleep_ptr(adreno_system_restore),
>  	RUNTIME_PM_OPS(adreno_runtime_suspend, adreno_runtime_resume, NULL)
>  };
>  
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 4b2156825bdf..7ad8cbcfede4 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -81,6 +81,8 @@ struct adreno_gpu_funcs {
>  	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
>  	bool (*gx_is_on)(struct adreno_gpu *adreno_gpu);
>  	bool (*aqe_is_enabled)(struct adreno_gpu *adreno_gpu);
> +	/* Called on restore from hibernation, after the hardware lost its state */
> +	void (*power_cycled)(struct adreno_gpu *adreno_gpu);
>  };
>  
>  struct adreno_reglist {
> 
> ---
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> change-id: 20261023-b4-drm-msm-a6xx-rsc-restore-hibernation-912730e2de2d
> 
> Best regards,
> --  
> 
> Abel

