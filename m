Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14989C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497F510E160;
	Thu, 30 Jul 2026 12:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ooPTrQJf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F5Fcl2Jl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C57010E160
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:59:44 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UCfU5N643079
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IZj8afYz4TH7NX2z9E4K544D8/dPECrObKm5nM3IWL4=; b=ooPTrQJfXw+167vw
 22IRx3Y3y2D8kka5ClK3UOvP262VX0ljXcsGQKIyK1Tz8N4ZwwnMWjy6maaugb7V
 9jCjS8AQVbJ/GD90Y7R7wKqVQU/lOW/nHiZ+hX9DoZVJtAZ8XUShu8J52Ek6Bqqw
 BM9O/h6ampQKEQNWK5T5PNpgQ4fiG1+YAarJL4q8s1vebOtq/elPu8EYOxmFCOgI
 0IiAY0b0p+g6U0PiLaH16swX+C6xnnXLVz2kCMY46Q34r5YlLcR4zZBgzsBY2XP0
 oHyShAnX8wfDnKYQD3MlptnjQojURK9AenaIkznfeyyEz96wY3X4++awMc8tYgXm
 Y/XZ7g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ucr2c2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:59:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso25025345ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785416383; x=1786021183;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IZj8afYz4TH7NX2z9E4K544D8/dPECrObKm5nM3IWL4=;
 b=F5Fcl2Jl8vPQtTPe4KzQzvlNkrc6PnvZ+xV893zg0DeYSVLfGDcqkCKNiRdmalxygB
 xWT7NVI2WIa8KdftsJ/ZTGUHZ9clnU5oalazbDheMqKpu51IAeyOkvsbIv7cFMijDhtq
 EL2i3DLIHFN3Sf2nfCXh/PSCrUCpgWpUvcBdAbWoxUiqcsyxdQngW2/2mrvdIifly+Pj
 3857SH5DlHiXtdhBSKL0n0TZN19T4706VKpAH/nyJmpnuCuiwSelB2j/46FJVLjz8RgH
 /9nzkmYobbKELZmbItNEYRLm+FSJAOT1miFds06ML9BUXEO70Wmj6cl08KlL+uhSkVkY
 lgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785416383; x=1786021183;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IZj8afYz4TH7NX2z9E4K544D8/dPECrObKm5nM3IWL4=;
 b=YbADZ1PNxVz9kNV+6xcT1h3dETbcqeiqbHGA5skg+H5ISnmhb/ygCKv5kH86BI5ikZ
 L9T6PaW4+J5eD1WX10FzwzS5p4BU9FSaqFrKK8HcgmSuPIl5ozJxRqtY2wwKQ9Ju6qnx
 cmPy/50dOOlwSXrE7BVWL6T+vlWoVpMvRm5u3/ZUHWpH3rQScwEn2WX02B68giLIioCI
 tR7Bs6ksjdLqGYWljw6/G0Xf6nLrZqC1mD0uZr6YR17XynyNe2Rzj2+9zn6NzAClyk6K
 X1q5CwP1w/Yh0oT+cE0AEGxqQLXdfae3UpS6H8TozE4EF/6f1DPmPWEhFO0K8TcK986n
 UL6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKwKKlOwiJ6NqiH1Sse5+JPZHa5pMPxCfHR7MatwJZP8IIswhc4HKOXjt3IRXjlGZB4z6CiK2bq6c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzx4LariFxm5LKuGL9+ZBiAHyH/jsLkG9BYcFxQxr3ilzNQvAL6
 RJzogufC4hZxcroY9zy0NZKV+WINm1wDU7Jlxl6+qFt7SsOqy1D0p4kNOI78KaSm2zwd55mVHHv
 tBJNEfX92sQTfBNXlw1i7YoN0vm1/rUPZWUiSykkOkMKKepkzuMTalibxKQdcy8BSfbUZyU0=
X-Gm-Gg: AR+sD12d+FprT8VZAKDqUVTCUo6pMoLWQ7NSBqxhB4DgLe0lfDudjZnEaBgMqCimLJI
 hDwfX53e+oNkj7HZJuLPLxnPxij+vXMNiiaQSnujQR8is+7RUOk2a3nZYjKgVAC3SKCOE6Qqne3
 zC9KILZnOhAfGZz2IJYJ5tZd3el8vZdDlhNYZGXVaPK7BuPLaU1qCFK2RB6z7Eg0n4WAJoSZ2Fm
 jokRWWcTzwU4JosUCbB5OKYRyzq2a1WAwPpM62WNj6J0yP/HycEgKFkUpmskLEKVd3Y8Lioz0Mj
 SSVvBmJ7WALlplZnyCg/TbMhoj4jNMy/ifrR8OsgKdosZCY3lNfmSVdRiW4MGL0uq1BjkMCOJuo
 sa5m/7vNllWJE/VzwH/VrFFSeNBE=
X-Received: by 2002:a17:903:2f84:b0:2c9:b48c:fdec with SMTP id
 d9443c01a7336-2d035c4edf1mr23886435ad.12.1785416382599; 
 Thu, 30 Jul 2026 05:59:42 -0700 (PDT)
X-Received: by 2002:a17:903:2f84:b0:2c9:b48c:fdec with SMTP id
 d9443c01a7336-2d035c4edf1mr23886155ad.12.1785416382067; 
 Thu, 30 Jul 2026 05:59:42 -0700 (PDT)
Received: from [10.204.78.62] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a1586esm26996045ad.12.2026.07.30.05.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 05:59:41 -0700 (PDT)
Message-ID: <cd76a3aa-f86d-49be-a94b-820f4549d4dd@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:29:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/msm: default separate_gpu_kms to auto selection
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260330-separate_gpu_kms-v3-1-a3e54b9c9417@oss.qualcomm.com>
 <7cb406ca-e631-4cd4-9782-d3efe30844e4@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7cb406ca-e631-4cd4-9782-d3efe30844e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfX5VEcBASjBgRZ
 Cu8QzFZLhQAEeLir7faS7N0YmoAwu/Wst2BhI1F4Px5lmWGILcHL9xMgnyy6Q80SlS4YLLe7lIY
 2wNqBpxJDXC9003ZGnNweJdJw5B8RQk=
X-Proofpoint-GUID: H-zLnBnFG0J4vYtVbJ0szAdOUBUfIPb1
X-Proofpoint-ORIG-GUID: H-zLnBnFG0J4vYtVbJ0szAdOUBUfIPb1
X-Authority-Analysis: v=2.4 cv=W6QIkxWk c=1 sm=1 tr=0 ts=6a6b4abf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K928gvJhYKBOjmkGNO8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5OCBTYWx0ZWRfX4S5JllsToOqB
 ioUn8y8ih+mHg7685OulN/VbgbovsZk97FuqArm0+I99ZVd3OtYVzQxAqNib2kWUHU08UB65FTp
 d7Whq0fg2oCwh2IF9iGOShet61JnGzXVYiPk7YReyyE5jpnIdnwXNKHfCGPQC1Og21S5wj4Fw3w
 j+4lcP9Zayl+XqqpmBEOp3aA5LbRjypmZwSNoKok1iFA6yvaxSgCK2w1YQXkhHU/Tb61mbYNQFr
 wBBynbbhFqkfwRqJ5/nWYngGZjlKrwIVQgwnQeQgns+BSnZPlCdje917Wx9tZPBA7qw6EJitMCM
 Kr05wd28EpBshvR7cHBUmexaOqrCWw3vKv4wlFg4N42yvvdgaAsllXkhrV+7ea8/kLPg0l7tW0J
 b40FhoPKdbNnorShGtQSdRUMhq2IM5tSKVDqqVSbJILQbOYpFPpeFLb12xMGMeFRUtZIncxWVHK
 hFNapRvhEApXiQC6xYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300098
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

Hi Dmitry, Rob,

Gentle reminder on this one . Happy to rework anything that doesn't look
right;

On 4/13/2026 2:14 PM, Mahadevan P wrote:
> Hi all,
> 
> Just a gentle ping on this patch below.
> Any feedback would be very helpful.
> 
> On 3/30/2026 3:22 PM, Mahadevan P wrote:
>> On platforms with multiple display subsystems, such as SA8775P, the GPU
>> binds to the first display subsystem that probes. This implicit binding
>> prevents subsequent display subsystems from probing successfully,
>> breaking multi-display support.
>>
>> Use the tristate separate_gpu_kms module parameter with the default
>> value set to auto (-1). In auto mode, the driver selects the binding
>> behavior based on the number of GPUs and display subsystems. This allows
>> display subsystems to probe independently when required, while
>> preserving the existing single-card behavior on simpler systems.
>>
>> The separate_gpu_kms module parameter has the following semantics:
>>
>>    -1 (auto, default):
>>       Select the binding mode based on hardware topology. If exactly one
>>       GPU and one display subsystem are present, bind them together to
>>       form a single DRM device. Otherwise, expose the GPU and display
>>       subsystems as separate DRM devices.
>>
>>     0:
>>       Always bind the GPU and display together to form a single DRM
>>       device.
>>
>>     1:
>>       Always expose the GPU and display subsystems as separate DRM
>>       devices.
>>
>> Additionally, ensure that display subsystems are always exposed as
>> separate DRM devices when no recognized Adreno GPU is present,
>> regardless of the separate_gpu_kms setting.
>>
>> This ensures correct probing on multi-display platforms without
>> affecting single-display, single-GPU systems.
>>
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> ---
>> Depends on:
>>    https://lore.kernel.org/lkml/20260124-adreno-module-table- 
>> v1-1-9c2dbb2638b4@oss.qualcomm.com/
>>
>>    When separate_gpu_kms is enabled, the GPU and display drivers are
>>    probed independently. In this configuration, the Adreno GPU driver
>>    may no longer be loaded implicitly via the display subsystem.
>>
>>    The referenced patch adds a MODULE_DEVICE_TABLE() entry for the
>>    Adreno GPU device, ensuring proper module autoloading based on
>>    device tree matching. This is required to guarantee that the GPU
>>    driver is loaded correctly when GPU and display probing are
>>    decoupled.
>>
>> Changes in v3:
>> - Ensure display subsystems are always exposed as separate DRM devices 
>> when
>>    no recognized Adreno GPU is present (!adreno_has_gpu()), regardless of
>>    separate_gpu_kms setting. (Dmitry)
>> - Extend auto-selection logic to account for legacy display 
>> controllers (MDP4 and MDP5). (Dmitry)
>> - Rename msm_mdss_count_masters() to msm_mdss_count() to better 
>> reflect functionality. (Dmitry)
>> - Common helper to determine presence of a valid Adreno GPU node, 
>> avoiding repeated
>>    adreno_has_gpu() and availability checks.
>> - Update commit message to reflect the above behavior.
>> - Link to v2: https://lore.kernel.org/r/20260317-separate_gpu_kms- 
>> v2-1-b027ca97b9fe@oss.qualcomm.com
>>
>> Changes in v2:
>> - Drop dependency on Lemans dual-DPU device tree changes as this patch
>>    works independently (Dmitry)
>> - Switch separate_gpu_kms to tristate and default to auto mode (Rob)
>> - Rename msm_gpu_no_components() to msm_separate_gpu_kms_components() 
>> for clarity
>> - Link to v1: https://lore.kernel.org/r/20260223-seperate_gpu_kms- 
>> v1-1-e8231e7f1685@oss.qualcomm.com
>> ---
>>   drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
>>   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c   | 14 +++++++
>>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 14 +++++++
>>   drivers/gpu/drm/msm/msm_drv.c              | 64 ++++++++++++++++++++ 
>> ++++++----
>>   drivers/gpu/drm/msm/msm_drv.h              |  8 +++-
>>   drivers/gpu/drm/msm/msm_mdss.c             | 15 +++++++
>>   6 files changed, 107 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/ 
>> drm/msm/adreno/adreno_device.c
>> index 4edfe80c5be7..e40648c05797 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -272,7 +272,7 @@ static const struct component_ops a3xx_ops = {
>>   static int adreno_probe(struct platform_device *pdev)
>>   {
>>       if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
>> -        msm_gpu_no_components())
>> +        msm_separate_gpu_kms_components())
>>           return msm_gpu_probe(pdev, &a3xx_ops);
>>       return component_add(&pdev->dev, &a3xx_ops);
>> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/ 
>> drm/msm/disp/mdp4/mdp4_kms.c
>> index 809ca191e9de..409000b739b6 100644
>> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
>> @@ -15,6 +15,20 @@
>>   #include "msm_mmu.h"
>>   #include "mdp4_kms.h"
>> +static const struct of_device_id mdp4_dt_match[];
>> +int msm_count_mdp4(void)
>> +{
>> +    struct device_node *np;
>> +    int count = 0;
>> +
>> +    for_each_matching_node(np, mdp4_dt_match) {
>> +        if (of_device_is_available(np))
>> +            count++;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>>   static int mdp4_hw_init(struct msm_kms *kms)
>>   {
>>       struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
>> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/ 
>> drm/msm/disp/mdp5/mdp5_kms.c
>> index 1e3dc9bf9494..086895c9f103 100644
>> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
>> @@ -19,6 +19,20 @@
>>   #include "msm_mmu.h"
>>   #include "mdp5_kms.h"
>> +static const struct of_device_id mdp5_dt_match[];
>> +int msm_count_mdp5(void)
>> +{
>> +    struct device_node *np;
>> +    int count = 0;
>> +
>> +    for_each_matching_node(np, mdp5_dt_match) {
>> +        if (of_device_is_available(np))
>> +            count++;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>>   static int mdp5_hw_init(struct msm_kms *kms)
>>   {
>>       struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/ 
>> msm_drv.c
>> index e5ab1e28851d..e2101c6632ac 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -54,16 +54,64 @@ static bool modeset = true;
>>   MODULE_PARM_DESC(modeset, "Use kernel modesetting [KMS] (1=on 
>> (default), 0=disable)");
>>   module_param(modeset, bool, 0600);
>> -static bool separate_gpu_kms;
>> -MODULE_PARM_DESC(separate_gpu_drm, "Use separate DRM device for the 
>> GPU (0=single DRM device for both GPU and display (default), 1=two DRM 
>> devices)");
>> -module_param(separate_gpu_kms, bool, 0400);
>> +/*
>> + * separate_gpu_kms (tristate):
>> + *   -1 (default): decide automatically based on hardware topology. 
>> Split devices
>> + *                 if there is more than one GPU or more than one 
>> display master.
>> + *    0: force single DRM device (bind display + GPU)
>> + *    1: force separate DRM devices
>> + */
>> +static int separate_gpu_kms = -1;
>> +MODULE_PARM_DESC(separate_gpu_kms,
>> +         "Use separate DRM device for the GPU (-1=auto (default), 
>> 0=single DRM device, 1=separate DRM devices)");
>> +module_param(separate_gpu_kms, int, 0400);
>>   DECLARE_FAULT_ATTR(fail_gem_alloc);
>>   DECLARE_FAULT_ATTR(fail_gem_iova);
>> -bool msm_gpu_no_components(void)
>> +static const struct of_device_id msm_gpu_match[];
>> +static inline bool msm_gpu_node_present(struct device_node *np)
>> +{
>> +    return np && of_device_is_available(np) && adreno_has_gpu(np);
>> +}
>> +
>> +static int msm_count_gpus(void)
>> +{
>> +    struct device_node *np;
>> +    int count = 0;
>> +
>> +    for_each_matching_node(np, msm_gpu_match) {
>> +        if (msm_gpu_node_present(np))
>> +            count++;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>> +static bool msm_separate_gpu_kms_auto(void)
>> +{
>> +    int gpus = msm_count_gpus();
>> +    int display_subsystems = msm_count_mdss() + msm_count_mdp4() + 
>> msm_count_mdp5();
>> +
>> +    if (gpus <= 0 || display_subsystems <= 0)
>> +        return false;
>> +
>> +    /* If exactly one GPU and one display subsystem single card */
>> +    return (gpus > 1) || (display_subsystems > 1);
>> +}
>> +
>> +bool msm_separate_gpu_kms_components(void)
>>   {
>> -    return separate_gpu_kms;
>> +    struct device_node *np;
>> +
>> +    np = of_find_matching_node(NULL, msm_gpu_match);
>> +    if (!msm_gpu_node_present(np))
>> +        return true;
>> +    if (separate_gpu_kms == 1)
>> +        return true;
>> +    if (separate_gpu_kms == 0)
>> +        return false;
>> +    return msm_separate_gpu_kms_auto();
>>   }
>>   static int msm_drm_uninit(struct device *dev, const struct 
>> component_ops *gpu_ops)
>> @@ -1019,7 +1067,7 @@ static int add_gpu_components(struct device *dev,
>>       if (!np)
>>           return 0;
>> -    if (of_device_is_available(np) && adreno_has_gpu(np))
>> +    if (msm_gpu_node_present(np))
>>           drm_of_component_match_add(dev, matchptr, 
>> component_compare_of, np);
>>       of_node_put(np);
>> @@ -1030,7 +1078,7 @@ static int add_gpu_components(struct device *dev,
>>   static int msm_drm_bind(struct device *dev)
>>   {
>>       return msm_drm_init(dev,
>> -                msm_gpu_no_components() ?
>> +                msm_separate_gpu_kms_components() ?
>>                       &msm_kms_driver :
>>                       &msm_driver,
>>                   NULL);
>> @@ -1069,7 +1117,7 @@ int msm_drv_probe(struct device *master_dev,
>>               return ret;
>>       }
>> -    if (!msm_gpu_no_components()) {
>> +    if (!msm_separate_gpu_kms_components()) {
>>           ret = add_gpu_components(master_dev, &match);
>>           if (ret)
>>               return ret;
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/ 
>> msm_drv.h
>> index 6d847d593f1a..a977fe7b36b8 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -555,6 +555,12 @@ void msm_kms_shutdown(struct platform_device *pdev);
>>   bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
>> -bool msm_gpu_no_components(void);
>> +bool msm_separate_gpu_kms_components(void);
>> +
>> +int msm_count_mdss(void);
>> +
>> +int msm_count_mdp4(void);
>> +
>> +int msm_count_mdp5(void);
>>   #endif /* __MSM_DRV_H__ */
>> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/ 
>> msm_mdss.c
>> index 9047e8d9ee89..4c788f2647b0 100644
>> --- a/drivers/gpu/drm/msm/msm_mdss.c
>> +++ b/drivers/gpu/drm/msm/msm_mdss.c
>> @@ -73,6 +73,21 @@ static int msm_mdss_parse_data_bus_icc_path(struct 
>> device *dev,
>>       return 0;
>>   }
>> +static const struct of_device_id mdss_dt_match[];
>> +
>> +int msm_count_mdss(void)
>> +{
>> +    struct device_node *np;
>> +    int count = 0;
>> +
>> +    for_each_matching_node(np, mdss_dt_match) {
>> +        if (of_device_is_available(np))
>> +            count++;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>>   static void msm_mdss_irq(struct irq_desc *desc)
>>   {
>>       struct msm_mdss *msm_mdss = irq_desc_get_handler_data(desc);
>>
>> ---
>> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
>> change-id: 20260316-separate_gpu_kms-04d2cf4d91e2
>>
>> Best regards,
> Thanks,
> Mahadevan

Thanks,
Mahadevan


