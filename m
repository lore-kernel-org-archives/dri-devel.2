Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F67510F92E9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6562110E14D;
	Tue, 31 Mar 2026 18:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOdAcj/D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ph8lwf1a";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E99D10E14D
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 18:05:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VHXANo3104026
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 18:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 USrClDURSIOj2yOjY9ZTvHl5/K/quYC1V/gXkY+Qda4=; b=iOdAcj/DtzTfqhEF
 SQJo8FB8jMRwjj3uCccpI9H6tb4YGhvQ2UHThzh8awmPgkpV5duIsPYauhKzipXX
 iGUlOLp2biOFsfcvQsMXjn53poeRixNAX76ZJ7aMYgwHc3Od/8mjAblhx4Iqj/jo
 YtnmGN5y9dvjOKzbwbMKg+oPB+IjgXPTH2C7ouJx2vbaQnR+R9woTF5GLxiHx6EM
 4zq5Pj4gk8VbW/bqTLzvUk3B+b4l0YUctIRw50CEYkOB+x3DL5EHDQNj7jW/ffPk
 2pBPH61NDuOTiBNggouHZNBp3DzN9J01zGGBnY3bxA4sJTh0Xd+dsxfOgY6DAyuD
 Gx4oYg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js2067s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 18:05:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c76b6ccf298so447383a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774980337; x=1775585137;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USrClDURSIOj2yOjY9ZTvHl5/K/quYC1V/gXkY+Qda4=;
 b=Ph8lwf1aYvrt9V4pkCuM8u+DCxfb2Z5ESO9Wn1CP99BwZ9V+JveCnXdjDBMYw2y/zw
 LEaSMr/1hTnKMDcf/0NuysbwjEQWj4dymWbcB+Bc7D5u1uoYk5wlStfnx6C7ZUDBbt5Y
 3jS392hqmoBCx7GZLfoz0N8yRN2PdXkLb6Wi40D6KcFwW+Yc35+5rUsGBsfXixLmEmQf
 g5P5/S0UKXOJFTU9hKBeKHxRVKsLZvXNvfc8oQ5LU/CfUxt+MR7Uv2H6FNWaBpXhPw2a
 XV8cYygVCj6cnqPwtRfJy1kDbjfyH8w2vtxdHGMuYsxI3+svr25FW/s9LZLhislOw2S6
 Ctzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980337; x=1775585137;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=USrClDURSIOj2yOjY9ZTvHl5/K/quYC1V/gXkY+Qda4=;
 b=WlaHUvD/DNQHSCkEoqO1xubRws7zYCqaerLeEPWCWqZduPooOU8RsLi+axhMqYLSfj
 lAh6P3+CMYgahdf8peAx/Sb0yKwaeXQJB0JuOebh6FGy7PbwLChmPnL9z9FCQj/2U3C3
 jAm+v2iqEAF/B7A+35WW5oqDPZALgLcGxaKrJzbWmsEodd+MNEKfo940a6xmtK79J7/l
 3Owv8lQmw3cCLc5+8TCqlFbk4j+18ywkBdmsCNQUm0tswMdU4Cgp1ZZ3OYbwuUY+lPBt
 9myYHujDHmiur9doP70BZ/fBtWdJDOxlb3Ed/KKsCi7ERRlJpQQqTKqPMtOjGnOD6Ba2
 ylSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZslVBIkxpwZ+yuyAExQWbMZ2+WX6x2YYavoSyp/ilPBIQVRrG6/UPPS9PLQN3GR3E1aFTpXzblwg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNbuiavajaZmY9gKj4yAc+/vkf9sYcEycefpzM79lKxCCh6pNx
 fAhV7VIlKma1YE7bnUENbKDVYkqdzI9thrMftYaEHQ+PuRFIZ82dnae7ps1S3lCgZ92EZhr/jKk
 XAGKL6K3yQAVTe+HxACY4VUi+XWOKDeARN7beWLNmNbc1LxDZj+PJifrry4nuHMBjx+kaTdU=
X-Gm-Gg: ATEYQzx1KJ/Cg1EYIqy1/DoC0bpOpHleuKSizgxSB2HqWqqIZSRBuJMY3ItTDC4kYcs
 prGd64ZMIcfQaamFoH9BhEc/hv5Jxe876oK2/JcBK/LIq/NSLRPNBF0e13hhdt7Ln2RDX2EkBWz
 O2Ap1FrkMWB94pw78uEsABB/R9X8UQyHqW1YHu3Ed485x32eX1jiLK+k1eL3fq1WIen/TpWTOes
 UjAxHxSdm/nDOvqrdn37LhqQ5zG8hP4m6nqGS0jnEzoVj1yXrFGmOr5RYs596fx51kg8FC4fr/o
 wmnRuqIesnMh/TjtzcXiPYhvBeiI++bQWmvKTNk6Er1Fj5dd6F8Yxu8rHgn+DWRaQ1fo/qYJm1X
 QAXWp1Wq3vB/DK7cVWD2QlmheYbCJKZiGkDlcxglT8hIa
X-Received: by 2002:a05:6a21:6da2:b0:39b:da83:91a3 with SMTP id
 adf61e73a8af0-39ef774a085mr250665637.50.1774980337158; 
 Tue, 31 Mar 2026 11:05:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da2:b0:39b:da83:91a3 with SMTP id
 adf61e73a8af0-39ef774a085mr250607637.50.1774980336469; 
 Tue, 31 Mar 2026 11:05:36 -0700 (PDT)
Received: from [192.168.1.11] ([106.222.233.0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca860b125sm10964512b3a.50.2026.03.31.11.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 11:05:36 -0700 (PDT)
Message-ID: <720bf565-342c-45b1-b797-3e27a7e9bb56@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 23:35:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] drm/msm/adreno: Coredump on GPU/GMU init failures
To: rob.clark@oss.qualcomm.com
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
 <CACSVV01RxTce4qEkt=vPb8AmPSuTLVTh5DR5gCAP2n3U3vkDqw@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV01RxTce4qEkt=vPb8AmPSuTLVTh5DR5gCAP2n3U3vkDqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V8wrNQxjzud3rrdUQlYbQ6HOukrD1Cw9
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cc0cf1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=LIJ1G+IszuYCLGPi0MaIKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=mYQd18i7ClW-Y3202ycA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE3NCBTYWx0ZWRfX0PfmVbrinHhJ
 wwitvt0Zh8LXLlzmHUVTvYDdIE+slCcPuG3v2v6d/xS/iqS20N5ASOlc0KuLRufcZJaDKp1apbm
 eZ6iZYpQd1G66/27LoEYjUJuK21ee+KkFr4l+c2Hjvlcz5v1XG7MW128dDjS3o3tJibGwg7nG7R
 0m+0E5ncKG5r/jEQ9hG3WWlmr1eLkD6edvquw/2rNMI9Ed9lYOmKf82q0HgHg207blK6oUia9Eh
 bUHgl5jvDSzDBWhEMaExJxGpwdm3mw2Q7J5BS4Ag38CX8Ym4YoL01zpP2NJt77o/X7PxJEvujiR
 MiQAXU5DlhjWr7PRLhgel1SXkh5bcBd0h4JOjnFaPll6Hn4BTuyD4vmtlio0tGF+FYb9923XVCe
 lE1wnNAJgTW+54NSi0OppR0y77Uawi5RcQVQHDvZnet7SxpCDk5ZFq6ULQ+skInSJG0lNddOy2O
 s1J9wkL3Y94AUpn1FvQ==
X-Proofpoint-GUID: V8wrNQxjzud3rrdUQlYbQ6HOukrD1Cw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310174
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

On 3/31/2026 1:21 AM, Rob Clark wrote:
> On Thu, Mar 26, 2026 at 5:15 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> Capture coredump on GPU or GMU errors during initialization to help in
>> debugging the issues. To be consistent with the locks while calling
>> msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
>> msm_gpu->lock.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 1 +
>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++--
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 5 ++++-
>>  drivers/gpu/drm/msm/msm_gpu.c              | 5 +++--
>>  drivers/gpu/drm/msm/msm_gpu.h              | 2 ++
>>  5 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 1b44b9e21ad8..916c5d99c4d1 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -1335,6 +1335,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>>
>>  disable_irq:
>>         disable_irq(gmu->gmu_irq);
>> +       msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
>>         a6xx_rpmh_stop(gmu);
>>  disable_clk:
>>         clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index 4edfe80c5be7..ca5f96e16870 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -105,6 +105,8 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>>          */
>>         pm_runtime_enable(&pdev->dev);
>>
>> +       guard(mutex)(&gpu->lock);
> 
> so, I am a fan of guard(), but I realized this means we are holding
> gpu->lock across the debugfs_init() (only a5xx).. which I suspect will
> anger lockdep, although I don't have a good way to test that atm.

Shall we drop this patch for now? I will send a respin later.

-Akhil.

> 
> BR,
> -R
> 
>> +
>>         ret = pm_runtime_get_sync(&pdev->dev);
>>         if (ret < 0) {
>>                 pm_runtime_put_noidle(&pdev->dev);
>> @@ -112,10 +114,9 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
>>                 goto err_disable_rpm;
>>         }
>>
>> -       mutex_lock(&gpu->lock);
>>         ret = msm_gpu_hw_init(gpu);
>> -       mutex_unlock(&gpu->lock);
>>         if (ret) {
>> +               msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
>>                 DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
>>                 goto err_put_rpm;
>>         }
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> index 785e99fb5bd5..8475802fdde2 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
>> @@ -391,10 +391,13 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>>                 return 0;
>>         case MSM_PARAM_TIMESTAMP:
>>                 if (adreno_gpu->funcs->get_timestamp) {
>> +                       mutex_lock(&gpu->lock);
>>                         pm_runtime_get_sync(&gpu->pdev->dev);
>> +
>>                         *value = adreno_gpu->funcs->get_timestamp(gpu);
>> -                       pm_runtime_put_autosuspend(&gpu->pdev->dev);
>>
>> +                       pm_runtime_put_autosuspend(&gpu->pdev->dev);
>> +                       mutex_unlock(&gpu->lock);
>>                         return 0;
>>                 }
>>                 return -EINVAL;
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>> index 995549d0bbbc..472db2c916f9 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -361,7 +361,7 @@ static void crashstate_get_vm_logs(struct msm_gpu_state *state, struct msm_gem_v
>>         mutex_unlock(&vm->mmu_lock);
>>  }
>>
>> -static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
>> +void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
>>                 struct msm_gem_submit *submit, struct msm_gpu_fault_info *fault_info,
>>                 char *comm, char *cmd)
>>  {
>> @@ -886,7 +886,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>
>>         pm_runtime_get_sync(&gpu->pdev->dev);
>>
>> -       msm_gpu_hw_init(gpu);
>> +       if (msm_gpu_hw_init(gpu))
>> +               msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
>>
>>         submit->seqno = submit->hw_fence->seqno;
>>
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
>> index 666cf499b7ec..eb5b3a7b81f9 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.h
>> +++ b/drivers/gpu/drm/msm/msm_gpu.h
>> @@ -747,6 +747,8 @@ static inline void msm_gpu_crashstate_put(struct msm_gpu *gpu)
>>  }
>>
>>  void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_info *fault_info);
>> +void msm_gpu_crashstate_capture(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>> +               struct msm_gpu_fault_info *fault_info, char *comm, char *cmd);
>>
>>  /*
>>   * Simple macro to semi-cleanly add the MAP_PRIV flag for targets that can
>>
>> --
>> 2.51.0
>>

