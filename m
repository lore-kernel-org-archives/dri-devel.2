Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89738606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVsdHCQv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d1cYMRJ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E575310E398;
	Thu,  5 Nov 2026 21:28:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28011123CE
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:27:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6clX1935596
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZWnXimVpeQxb/+8pu9gZLHGbBkrdMiXRvBKJrkwrSno=; b=CVsdHCQv4Yh9N6q8
 riZuA1weyRqQjS9kyvUPvnkHayKLNCqxz7VB6mh/XKWqSc14Iv+AQlxsM3ajCWa/
 o/RD6PMzixrN8SlognVAeWuvk4vTpOqvnBz+UctsBBtiDfgIyjbN+L9xj0ZMVLff
 NmYZRoqpwB81nsLgg+CwO/gWVXaoLolsqGLqG+KhJWWDs5O+cFLpzMu3GkbmMw0/
 bNB1gSqCNDqa4DMsMDhfz5Pmd7OpQ8ZV0Eoj8rsXLduAs851Jb3lfAVDNKO8bRYg
 JArPJou9AKWvopAQZ3soVW2flwjKR7KoEOhH8B86jG+pHl+eXVxBUX0cuezVOssV
 5QWhrA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcdbwp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:27:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso4638816eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793914065; x=1794518865;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZWnXimVpeQxb/+8pu9gZLHGbBkrdMiXRvBKJrkwrSno=;
 b=d1cYMRJ0lfwHAXpQeJxtAyb4/+T1lV93OzMmaLkSZau9KxjzK89spIzeodRr8rkOvI
 5B2rgkYM+ZxXJgdlRrcfDH3mDliVs1TwkJYDcJqsBOZXUaXTmf9sVqAKBoEYO1qH+x60
 a0DUWnPyaR7TnWUAZ/JNmHD2r9VbNn+8pPyZ5o9RZtkpsOzLoegLOq3Me5fr7Y845DWf
 DoRnBFpNl4af/iuEvL0fSPPaycYMdW5FKdg1xO5B+CpSan8A0/P/GcX9rn5zAKjDUsOD
 BigxRCp7ZeC95C8dApt1iOTYE8pZfaEagJXBN+4xSbQqBDqvDT7kxQsBFYa2tC+hHQX1
 mnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793914065; x=1794518865;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZWnXimVpeQxb/+8pu9gZLHGbBkrdMiXRvBKJrkwrSno=;
 b=AacTCwZsnEfKzcNy9906Vwj89A9CQpPkEFuuw2RG8DE1/EYejNoli0Ue2gWMS/sTI7
 9PQdKH+DTMw0v7YxSSsgrUr+4D+dijMkvc30dhjpGpzpQJVkEKRA7tX9Ef7sRJKDnQx5
 WaD5YuQJ0a85dVHXIct2mNglkn77ZbdRScCPee/Km1HW3m6QYtc+nHNTKc6r0ApPWb10
 MqvT0RyJVNb+Yup9aqEpCWvc0r5PEwwAL9SIeX4092zWZyMFE7dtOcShJt6zxhrbmzvM
 6xVYRhT/wJnl8YV2DS87XNJGAUg3kvEgHtYAr7c3zKiYxLRrSgYYr2LFHcslu6w6iEtj
 aqBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwv1MMCkthqNho3CHK25Zrxk8UeUb5HIf/5yuxPlL9ZM1a0v4kwMyzxr2TBCYhvwn8Xp4HSrkPpcUg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8wcpkXrwl6wh2ckjdMBgyEdr4RKbRGVK+0DT/QX2q9ILDsGJ4n
 XlllJRM28osqRqSTHAyy/OaSNICCD7Wh2zHrqULqBFeaLTkmWEVmo6e5k2gYCg83fWXQsdiGOvj
 gZ7mW3qcmuevLB3yqa7TQ2RBVKRwK0e5T6q62iylzgXS0GcL00WvzNLAcnqwNPce0n7xtxYI=
X-Gm-Gg: AYBFou0Ugo1lGoaL9RBo3uusW4oibKK8IuSA5pTPoRSyo94F6/MA9MIQ1QSAbuaCXoJ
 YOHqzNd1iZYTTUMIHxzr2x4koqucUkNQmm1P6yVy09qPKVdIQ+TwrYMLDf6xZg6NZ0blvX60O9y
 072P1ih/LV+ubEQyYXLX04d+Bgqs8V9W3XeKUyO8S3YYVVd2J5D8LohuqD7vptJV3YD1JS1Gfsx
 E4qBSjeNYu7FxYeVB18iAiAa6zINpS/oQcc5S/hKpx3fuWngD0tSjhQZoGjrHgC1kASmrb7/CQm
 pCGk6X07AnSj2CGNYzggXc6QzTdgHwEXVwnm9qHjo/xZKexZ1tXuxEf9//aCnjs+Q4rcaSFoWur
 3mf119ru1jTPQyaNooKfTM8FZZKgoKma4RQ6MOzYNDcFm1j20xFmio2Gn1d36hzcnp7FFTdY=
X-Received: by 2002:a05:7300:8245:b0:36d:25e:1961 with SMTP id
 5a478bee46e88-36f76c16096mr455677eec.22.1793914064593; 
 Thu, 05 Nov 2026 13:27:44 -0800 (PST)
X-Received: by 2002:a05:7300:8245:b0:36d:25e:1961 with SMTP id
 5a478bee46e88-36f76c16096mr455637eec.22.1793914063996; 
 Thu, 05 Nov 2026 13:27:43 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f7369c69fsm912457eec.6.2026.11.05.13.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:27:43 -0800 (PST)
Message-ID: <4eb8aa1d-08ff-43a0-ad85-85005b0bdf33@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 02:57:37 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] drm/msm: Decouple IFPC disable and sysprof
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
References: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aecf4d1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aFxOFIhO4BgZX6uqFnUA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: s8h8OgakWe3YfFzjTM8p5W5uTfsBT9OQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX+GFfAQSuiuqo
 haZ5q59yxS+t/f9HH5xaOCHcPSgDB3xNayrjo+zmlrtPqar1wWvKsZ9YOqVS2TqVZa+5OYZbjlV
 hLT98euiy3kkMSp77ZhQWOspm3616Ow=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX3daJTVUey7mG
 dl4AhMJ5ZNSUXuysWki5em2vHYy681Y8nbWfC0Esx/aXA2BjsCB67Zk3s1qjtaE8Cd5K/benw8a
 8vJ4fnzFjnuBy5+OZ28CmY1b7+xoHO8kXbrzblj2KOBzcYnPMKag2CcmXmKbxEV8Iqk2xmLPslN
 hJOP8iFZejvpFKBIgtRwlpKw+dSSt904IgQDj0Ht6ruH53HOzVT5+DGnMnexZEladsq7Fq8t+u6
 sd7y0AoUtpUjMCJpr0uCG/SbAM+DyDQ5dQe7CHyjv12z1V7tgqOBmXdPTeSuFVUAOPKEw78uYCT
 ELCT3P4A+8w/nppdY5PWWqOXQdZ36kP/sncC5lo9DmgCSnwQ4E8m+m2WfJv+QcBgBc36lQQFOj2
 8C7NCBP5+5TMIZSEqMC6vNibzghI2RSpsPxis3G4pFSR6Am9bRgsW3Py6kzMVr32oKFUgFeGeur
 2bWJVMvrAW3HehafegA==
X-Proofpoint-ORIG-GUID: s8h8OgakWe3YfFzjTM8p5W5uTfsBT9OQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050085
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



On 11/5/2026 10:11 PM, Rob Clark wrote:
> Convert IFPC-disable into it's own refcnt so that multiple threads can
> request IFPC to be disabled without stomping on each other.
> 
> Extracted out of gen8 GPU state capture series[1], as other than fixing
> a missing IFPC disable in debugfs state capture path, it is unrelated.
> 
> [1] https://patchwork.freedesktop.org/series/176505/
> 
> v6:
> - Fix potential runpm ref leak in sel_worker()
> - Acquire gpu->lock before runpm
> - Fix unmatched OOB clear in a6xx_gmu_shutdown()
> - Link to v5: https://lore.kernel.org/all/20261104175931.28475-1-robin.clark@oss.qualcomm.com/
> 
> v5:
> - Skip unneeded msm_context_set_sysprof() call in msm_postclose()
> - Fix potential sel_worker deadlock
> - Revert back to original gpu-lock/runpm ordering
> - Link to v4: https://lore.kernel.org/all/20261103231850.17493-1-robin.clark@oss.qualcomm.com/
> 
> v4:
> - Don't clear GMU_STATUS_OOB_PERF_SET in suspend path.  Restore it in
>   hw_init()
> - Don't require gpu->lock in a6xx_gmu_ifpc_update(), but instead warn
>   if needs_hw_init
> - Move perfcntr resume to after hw_init()
> - Link to v3: https://lore.kernel.org/all/20261103184713.29664-1-robin.clark@oss.qualcomm.com
> 
> v3:
> - Rework IFPC disable harder to play nicer with hw_init().  If we
>   need_hw_init, simply update gmu->status mask and let hw_init()
>   restore the OOB request in a sequence that won't anger the fw.
> - Link to v2: https://lore.kernel.org/all/20261102190010.720443-1-robin.clark@oss.qualcomm.com/
> 
> v2:
> - Fix double acquire of gmu->lock
> - Fix missing a8xx hw_init() path
> - Link to v1: https://lore.kernel.org/all/20261101174631.23637-1-robin.clark@oss.qualcomm.com/
> 
> 
> Rob Clark (6):
>   drm/msm: Hold runpm ref in set_sysprof()
>   drm/msm: Resume perfcntrs after hw_init
>   drm/msm: Rework IFPC disable
>   drm/msm: Add cleanup help for disabling IFPC
>   drm/msm/debugfs: Use cleanup.h for gpu state dump
>   drm/msm: Inhibit IFPC for state snapshot
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 27 +++++++----------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  9 +++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  2 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c      |  3 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  5 +---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  1 -
>  drivers/gpu/drm/msm/msm_debugfs.c          | 32 +++++++++-----------
>  drivers/gpu/drm/msm/msm_drv.c              |  2 +-
>  drivers/gpu/drm/msm/msm_gpu.c              |  5 +++-
>  drivers/gpu/drm/msm/msm_gpu.h              | 34 ++++++++++++++++++++--
>  drivers/gpu/drm/msm/msm_perfcntr.c         | 17 ++++++-----
>  drivers/gpu/drm/msm/msm_submitqueue.c      | 20 +++++++++----
>  12 files changed, 94 insertions(+), 63 deletions(-)

For the series:

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil.> 

