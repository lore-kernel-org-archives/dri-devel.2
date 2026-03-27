Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9467D10AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F098210EC1A;
	Fri, 27 Mar 2026 00:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJ1cRI6C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T6iXBHPF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AA2D10EBE0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:18:03 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QI57gb1476111
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vh8ik5Yl+pBvNFbXoIfyhUJq3wlpS+a/bJ7UQeBXlWQ=; b=dJ1cRI6Ca6X+/VOg
 Zieb1aWwkKAanPOpas1sjVntbhgqH6osC71dNlkBKnbO1oHl/vi0TX1yr1FlCOsG
 CtnLHbNw5V75d0p6zupTwSovJ2ZDC/PHuemoo4wRp8yGKGY5ey8BV52QOtYf5m69
 sTqLcAGev8lMRz8JoM8TGk3OIH/UFTJ78EJnC5tqVX2kVLftJLMvPR6XAlJHQfX5
 G7XCe7I4qhGENtEbbYsbixKVNgY7nTfXVWbfOj9i3Nlx38jmEK5i61M1rMPAh6Ho
 jOgR3KwbeIePdppjs/hbvZdcinkCyjHVpP8loEBdR1PwyesCj+Hb8JlTFisTl7ua
 k4swmA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59s4111p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:18:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82a77f807e4so2741175b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570681; x=1775175481;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vh8ik5Yl+pBvNFbXoIfyhUJq3wlpS+a/bJ7UQeBXlWQ=;
 b=T6iXBHPFQ+ic7IJUUQ7Eu6PzEFZtJYG2cLTb3regxLbwXuLXeT3tBR9bBRy5JlobUZ
 qzZHPhQ3+H2zTaLQRaEBqujGeOR3O1tqWYTW5WB7QJp9F/YixsgC9ciGQDPjWMlyqZrW
 sN7MwIqgVfvavvqKm41x8Fg974kSzLRXnSBESbfAhDLMw8FahLBFbdOuzUKD03gyu33o
 PFft3jw6kxG5DSkrz/tN413VoL6ePM09a1eKEhl9pIVfXUBvnJRwl7y2mbXN+qRIbiNE
 SXZj01qjEnA+8hz9hNBww5w4stEe3mHazaWyUFtft3ndjvagPmUFgKLtM8uxXusEvvqM
 UeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570681; x=1775175481;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vh8ik5Yl+pBvNFbXoIfyhUJq3wlpS+a/bJ7UQeBXlWQ=;
 b=bglDSR4oHpBaw01XPml2vq1aqrpVsDflIbGrDJKCuUThLMX7KWKsMbnNgBcGyGv7o9
 4wGBwtMtjRGSntLrOaNL6ZleKg4CHoIY05Wyn7cl+WMAqE0CEs3exD8mRaZ5CMozFYpW
 CQndSgR4dzfSuKig3IspFmpjekpJH9S3FyEnTdlTk1PG5Hpgh0mptlxp4Yqg7bhkhEzm
 GTHTBZxJIAQnUloALx8cZIkYWAJyBGt6fj5KXhKpaDdhzlsc/CuNSArc6hfLkGuzHw4I
 d/Mtd7UjuqAhSb6usCOTrlgvuQdXEBV7ZlfrndYF11mf3HpAwNkoYJk1sbc1eJ5WP0Uu
 EYHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIv/cJ1GaxZ2jE9cZwUTPLQNi7kDwyxhc9geAI4cEBS7pccStw0FXXTKSmcztK62HDox4LcnxSi64=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4q8H/dFtDqyT+CVTtA/mfaaIab0QhDP4vN/UxulpxeqjID0b+
 d6TxpyMxNVD/6VOUZdglSQRjRGOsiMCYfFDjYIJpotGeiEZzRBW0Zu+lTT2/rcn0koSdI7lLGzY
 PN7E4T+T8vq4SljXxJ5XX1Yogdgagf4DbpP5iMOjYsYu40KPVdqMxkHuZgPcnW+fSQFzHSME=
X-Gm-Gg: ATEYQzxpZuQvMdWo1iSsH5In8Iw2UUaA+ZQXUlZGFCkowtdVZo7I/VRxfrYknH91ZLk
 uLNOraNgOfwfMXtwqLETFEyZnu3YsMxSqmBWDrHK/OX70DmXj2xE5JB7tHzMd2exa6M7S6oRSKf
 zxefGcLF6UFM56rcOivjodijyAQPB/j5tcaOtIDwID07gWnKyK7vZIsTp2tLidkVt2xSYWl2jNg
 tGD9kbdZleBEp3UMF2HuZxQttT5XdruXrZugslbZIb7RpcXr9wbYZxHd5wIBqdSxFNOmPBMFqWP
 UZkXe/z6HwRwAZALuJk12PORP88p/KN1UdqsazgLoRFb+4UbPryC1VHNOTddSCopdaP6kjBOMAU
 nPhnDiupXkOvGPBaqeSg1Z72xwdqukDLp2I2xXpFqFg/g
X-Received: by 2002:a05:6a00:3698:b0:81e:e09d:2687 with SMTP id
 d2e1a72fcca58-82c95af13f9mr405556b3a.1.1774570680878; 
 Thu, 26 Mar 2026 17:18:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:3698:b0:81e:e09d:2687 with SMTP id
 d2e1a72fcca58-82c95af13f9mr405532b3a.1.1774570680352; 
 Thu, 26 Mar 2026 17:18:00 -0700 (PDT)
Received: from [192.168.1.7] ([106.222.235.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d3ff085sm3575721b3a.57.2026.03.26.17.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 17:17:59 -0700 (PDT)
Message-ID: <fe3177bd-a3d2-4c0a-ab6f-9752eaf32fc4@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:47:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm: gpu: msm: forbid mem reclaim from reset
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260127073341.2862078-1-senozhatsky@chromium.org>
 <acSRDNA8fCP7qAFJ@google.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <acSRDNA8fCP7qAFJ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: waM3kY5e9nvOOnpPBLkP21XzpoTds8ms
X-Proofpoint-GUID: waM3kY5e9nvOOnpPBLkP21XzpoTds8ms
X-Authority-Analysis: v=2.4 cv=CoGys34D c=1 sm=1 tr=0 ts=69c5ccba cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=yg4K9g8yQ9z8uKSC4i4MOg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=cm27Pg_UAAAA:8 a=iIcgFftJmQX6hLS7D9wA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfXw2xgvayLHqto
 nSNVRcnIUo+thtnrWfu2TH3JbiAjjyYjsz0aS8dZy6GoXpQOAd22vXXZ9/yzHjYHcM5TMPg0Mwb
 +UsKxMbuV9E3ck8Qj50EW0sR4NW/bYcRaJlFG/iB0COTBXG0tsXFabgKjN1oAMldttXyzwlvMX8
 En7CULyqHiEW67a18xh0gODywkB4K/7W6R+buQDH6x+kQsna++tEkuy8ZZ58SuYtxrAUP1BOixD
 vkPGxpIJ9ejNIo8OrTaLWdgZgxsby3PUJYixizFCdrwUqtIF9BaBjQbVyzMTDdkXv8lpwHMf+V7
 i0Hy0DGYuoc4W6ckjgsJRELRcBd705yuT6QpbIrzHFuQy0aCe5MF0800CO5M5hhplEolh8sJp8R
 viIkY3mJQAqBtJK7UpQ0lgWCh71zM3WnRiMo+lwKICuUDxT/FfduYv045iLRWjLIniRhWe/yl3p
 +oZ2nbsIXe5aSmEoVdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270000
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

On 3/26/2026 7:24 AM, Sergey Senozhatsky wrote:
> On (26/01/27 16:33), Sergey Senozhatsky wrote:
>> We sometimes get into a situtation where GPU hangcheck fails to
>> recover GPU:
>>
>> [..]
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840161
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840162
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840162
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840163
>> [..]
>>
>> The problem is that msm_job worker is blocked on gpu->lock
>>
>> INFO: task ring0:155 blocked for more than 122 seconds.
>> Not tainted 6.6.99-08727-gaac38b365d2c #1
>> task:ring0 state:D stack:0 pid:155 ppid:2 flags:0x00000008
>> Call trace:
>> __switch_to+0x108/0x208
>> schedule+0x544/0x11f0
>> schedule_preempt_disabled+0x30/0x50
>> __mutex_lock_common+0x410/0x850
>> __mutex_lock_slowpath+0x28/0x40
>> mutex_lock+0x5c/0x90
>> msm_job_run+0x9c/0x140
>> drm_sched_main+0x514/0x938
>> kthread+0x114/0x138
>> ret_from_fork+0x10/0x20
>>
>> which is owned by recover worker, which is waiting for DMA fences
>> from a memory reclaim path, under the very same gpu->lock

I am still thinking if there is a better way to handle this. Btw, Rob
had a few fixes related to this area recently. Do you think those would
help in this scenario?

-Akhil

>>
>> INFO: task ring0:155 is blocked on a mutex likely owned by task gpu-worker:154.
>> task:gpu-worker state:D stack:0 pid:154 ppid:2 flags:0x00000008
>> Call trace:
>> __switch_to+0x108/0x208
>> schedule+0x544/0x11f0
>> schedule_timeout+0x1f8/0x770
>> dma_fence_default_wait+0x108/0x218
>> dma_fence_wait_timeout+0x6c/0x1c0
>> dma_resv_wait_timeout+0xe4/0x118
>> active_purge+0x34/0x98
>> drm_gem_lru_scan+0x1d0/0x388
>> msm_gem_shrinker_scan+0x1cc/0x2e8
>> shrink_slab+0x228/0x478
>> shrink_node+0x380/0x730
>> try_to_free_pages+0x204/0x510
>> __alloc_pages_direct_reclaim+0x90/0x158
>> __alloc_pages_slowpath+0x1d4/0x4a0
>> __alloc_pages+0x9f0/0xc88
>> vm_area_alloc_pages+0x17c/0x260
>> __vmalloc_node_range+0x1c0/0x420
>> kvmalloc_node+0xe8/0x108
>> msm_gpu_crashstate_capture+0x1e4/0x280
>> recover_worker+0x1c0/0x638
>> kthread_worker_fn+0x150/0x2d8
>> kthread+0x114/0x138
>>
>> So no one can make any further progress.
>>
>> Forbid recover/fault worker to enter memory reclaim (under
>> gpu->lock) to address this deadlock scenario.
>>
>> Cc: Tomasz Figa <tfiga@chromium.org>
>> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> 
> Folks, can somebody please review/pickup this patch?  It solves a real
> (deadlock) problem that we observe in the field.
> 
> // keeping the patch body just in case
> 
>> ---
>>  drivers/gpu/drm/msm/msm_gpu.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>> index 995549d0bbbc..ddcd9e1c217a 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/string_helpers.h>
>>  #include <linux/devcoredump.h>
>>  #include <linux/sched/task.h>
>> +#include <linux/sched/mm.h>
>>  
>>  /*
>>   * Power Management:
>> @@ -469,6 +470,7 @@ static void recover_worker(struct kthread_work *work)
>>  	struct msm_gem_submit *submit;
>>  	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
>>  	char *comm = NULL, *cmd = NULL;
>> +	unsigned int noreclaim_flag;
>>  	struct task_struct *task;
>>  	int i;
>>  
>> @@ -506,6 +508,8 @@ static void recover_worker(struct kthread_work *work)
>>  			msm_gem_vm_unusable(submit->vm);
>>  	}
>>  
>> +	noreclaim_flag = memalloc_noreclaim_save();
>> +
>>  	get_comm_cmdline(submit, &comm, &cmd);
>>  
>>  	if (comm && cmd) {
>> @@ -524,6 +528,8 @@ static void recover_worker(struct kthread_work *work)
>>  	pm_runtime_get_sync(&gpu->pdev->dev);
>>  	msm_gpu_crashstate_capture(gpu, submit, NULL, comm, cmd);
>>  
>> +	memalloc_noreclaim_restore(noreclaim_flag);
>> +
>>  	kfree(cmd);
>>  	kfree(comm);
>>  
>> @@ -588,6 +594,7 @@ void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_
>>  	struct msm_gem_submit *submit;
>>  	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
>>  	char *comm = NULL, *cmd = NULL;
>> +	unsigned int noreclaim_flag;
>>  
>>  	mutex_lock(&gpu->lock);
>>  
>> @@ -595,6 +602,8 @@ void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_
>>  	if (submit && submit->fault_dumped)
>>  		goto resume_smmu;
>>  
>> +	noreclaim_flag = memalloc_noreclaim_save();
>> +
>>  	if (submit) {
>>  		get_comm_cmdline(submit, &comm, &cmd);
>>  
>> @@ -610,6 +619,8 @@ void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_
>>  	msm_gpu_crashstate_capture(gpu, submit, fault_info, comm, cmd);
>>  	pm_runtime_put_sync(&gpu->pdev->dev);
>>  
>> +	memalloc_noreclaim_restore(noreclaim_flag);
>> +
>>  	kfree(cmd);
>>  	kfree(comm);
>>  
>> -- 
>> 2.53.0.rc1.217.geba53bf80e-goog
>>

