Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A55606A333
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DB/9f5zb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fcGQP6eD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61FE10E256;
	Mon, 23 Nov 2026 06:47:52 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB0510E4B8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:47:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN50sCj831181
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EkvQnwkJJcWAN0emGOjl8nhSfJ3XAraZnDzQtBA1wZA=; b=DB/9f5zb6LL/s06+
 7AkH9xZyg7KjWX3p1n/3CRpa6iy5m+NNqcP1Qv7ovi2azEU+MR/WPzisjQvhw1il
 HqDgzSQbnfaTOry760OhvONqpoDK99zO8W+GWNRYRGpa4wB6IJgNtnjjEC7al0Ee
 4HTM1rtvs1cDL3d02KJz7n9k4TSpBxWkUKgLfjjdZOw3Xi/QFJ81754XuezXAcGW
 TGDRJC6N0FKx2xaCeRcj6XdT6g8LBO9axEaEyxQdCjdv5dwV57lGF2SSxLzJvPSt
 bRN1QssiuRn+jROWhYKPuXVD8HF/X5weB65V7rGfaDycvmUnm/8ce5uST+QyILHv
 9b7v+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx0asu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:47:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd60e4e8bc3so2073094a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795416460; x=1796021260;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EkvQnwkJJcWAN0emGOjl8nhSfJ3XAraZnDzQtBA1wZA=;
 b=fcGQP6eDxkup0R2WiQe4LkZLL4ipv2+mgy/rH/FUPmYrG4upUXDRRw2jsTuLpfhrO4
 mPOvJ9IorKOY5eTrnhiL0BJD3K64AxPNI/kYAkQ7q8qdZgq2j1reTiJIlG6Ur3sYUP6F
 vRWXkUr2r00g1e8mSiYOd9dzeL9ujdWr69HeWMNMgw/NWMHBTZH5zaSqJBnmBqWc2MBQ
 3fpL5WiMtSjmefngOnWalz6WVpnbLR8Ft0BB8LVQj2gUchuK2Tb+V2RVKwkKd/DzxLyP
 Oc9rD5rwmgUo5HVZywtooi03nnxrYam4/HhAUtxNdA9uoQv3i3stVmi4U8WyLz1pYZk8
 9IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795416460; x=1796021260;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkvQnwkJJcWAN0emGOjl8nhSfJ3XAraZnDzQtBA1wZA=;
 b=wdyRh9G1K2ZoTKAOVcv6zfI/1MhRIhX0aLLgO+bBukQzlizQxVw2c+Ozhw0VNXMhG3
 GlZhwiquPCTHGHBjGywxazHbI4o5ZKuFICltes1zs13LHugF3gQ9vh5RNX6CFzelywiM
 tADomikiY5pdFCpYmgrYgrLFFEaE+VYDzie7guY64IkSHgueS0wzcPIZcMaPlRAncAK7
 L7VGLuHHNdO7tiKe2ksWdHKraqZqaUjHQ85BHPE3nTX//hba+IHnSdD9A3LtfcgJGNaJ
 v6QQBc/6tm540KYtxqjQDtg6zRZMDWJ7mv+21OUxR/sxvG++p+ugk/s1nXr//aK5PeVD
 9Ibw==
X-Gm-Message-State: APuU4Z8QyC5sX6qglBZrMWSiF0qODjHXbFS/OIwtiJpO55cbdhfLRvsU
 s4CTaBLA/eQnIYfErTAzcj3QV2/f4wpPqCclXOA5dBZv3K0TuhTTs3bHjjemrW8YiDXCdzPKZ+d
 /C6wf3seN95YpiN8k5WRvjn31NBTLQizhAw1rllONSMtm/o/jgpeLlGwqv5/V+gHbxbajnOYlGo
 ZBjEI=
X-Gm-Gg: AZFdTZfWhtqWQ/3/xHexu2ctC1rOt2u0yO3UIuyeqpAGA22DlKpdwPKkuZnoVlwS2s9
 YeYq3yNjthwWRQde9qo7XameDY56YzFDRGA/sr19aBnlMWk54VVhS2XW7oV50mf5jndhtmTwJ/v
 6V6ZsAlKdwUJLApJYhXhVr6l2DfTd8yV9nfP9CF/5RAN3decAuMkEyg04n9aipBkq/pVIjiO2Bw
 ZqnJS12uU+OyDMJEC4F6+23zeei8T4oe77zFpyL0QIbyISghKL4goaIbCeLEohIu88SbFJoXxpB
 2L0R0RVjS9Fk9Z9zcTmtt2BbKt6x3dwh+qKBeKwEJFX4XqGAy/86QTPlcujhNtUEHm1e6GIeetp
 7y9/CKHXCSHRCE+E0iHPrcvLuEgGrSDg3sSnUD51qTnwcyM6LP4hFGU1Zj4MKnktKTKo59EpU/L
 01
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9d14:feb2 with SMTP id
 98e67ed59e1d1-3b41c933eefmr9505043a91.35.1795416459671; 
 Sun, 22 Nov 2026 22:47:39 -0800 (PST)
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9d14:feb2 with SMTP id
 98e67ed59e1d1-3b41c933eefmr9505026a91.35.1795416459202; 
 Sun, 22 Nov 2026 22:47:39 -0800 (PST)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d1361fsm19057034a91.6.2026.11.22.22.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 22:47:38 -0800 (PST)
Message-ID: <2fb796f9-bd23-468a-b70a-ac1924ee198a@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:47:35 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 22/29] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-22-ca61be4edfc3@oss.qualcomm.com>
 <sashiko-outbox-222708@kernel.org>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <sashiko-outbox-222708@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b03e18c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=LrEcQCBHgJHnzhMH_loA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: vBY7r4zN2-ZBYrzFs5VQBhvCqizv66Y4
X-Proofpoint-GUID: vBY7r4zN2-ZBYrzFs5VQBhvCqizv66Y4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNiBTYWx0ZWRfXwDObY/0fSa5s
 J9ubTXJlBl7tqo+32tW2oORMEivTD0vXjslwsK0Eq5H9SNNeLGkbEk7LISWY7NbkhMY//y0EyGQ
 mizYeQg+J/jjwO4x8V/d2JVfps3UHc8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNiBTYWx0ZWRfXwPi4TB1neN4f
 omWWxN8KwgoXd0TvG2oNyQd74iZ9rYM0i9RRiKM/FZ/vx3oiJ4m2s3QFcz50fJCVdexpPos6NEI
 oMCox8IvpOl9EazZw0EuJkJhCSrDBKm+o79YAQZQm1R3cRU5Hph1ET5urthm2VjPeLt8gl/POS0
 IjPIl1mgEDRLVHx2lJixqtc7Pf6fDxRBRK0Mg9Iq4DdkGRrvPm1igb6euWi0GEqQVwKawvaz334
 YvNimjU0uoZqNVcNxne3dSjNPvURcIUndtxaILWZRMy3L1o4FL0TRsH34skY28mXTx6d/s0FiKS
 9W6L3kuG8PmkuqPE4razGTj1ujbVdY5iVk+0385kjHqv9cieQth1zcdLw3hlK2vHEMA1Sh0XIQe
 mgeidAJpPgKtPuFGMqYSzVgtEkJYIMJGkU70IgG4m+kNRxbRYE8Me+xrywuXVTal+Bpu8k3UdY4
 mGeEu3JlgF6stPWB7Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230026
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/2026 4:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/msm: link failure from unconditional DP MST calls when
>    DRM_MSM_DP=n
> --
> 
> commit 45937631fc3531311a3391632556b054bf1c3512
> Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> drm/msm/dp: wire MST helpers into atomic check and commit paths
> 
> This commit wires the DisplayPort MST atomic helper functions into the
> MSM KMS atomic check, commit setup, and commit tail paths.
> 
>> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
>> index a8babf1dbe0d3..e70e5088cfe53 100644
>> --- a/drivers/gpu/drm/msm/msm_atomic.c
>> +++ b/drivers/gpu/drm/msm/msm_atomic.c
>> @@ -4,6 +4,7 @@
>>    * Author: Rob Clark <robdclark@gmail.com>
>>    */
>>   
>> +#include <drm/display/drm_dp_mst_helper.h>
>>   #include <drm/drm_atomic_uapi.h>
>>   #include <drm/drm_vblank.h>
>>   
>> @@ -207,7 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
>>   	if (ret)
>>   		return ret;
>>   
>> -	return drm_atomic_helper_check(dev, state);
>> +	ret = drm_atomic_helper_check(dev, state);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return drm_dp_mst_atomic_check(state);
>>   }
>>   
>>   void msm_atomic_commit_tail(struct drm_atomic_commit *state)
>> @@ -221,6 +226,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit *state)
>>   
>>   	trace_msm_atomic_commit_tail_start(async, crtc_mask);
>>   
>> +	drm_dp_mst_atomic_wait_for_dependencies(state);
>> +
>>   	kms->funcs->enable_commit(kms);
>>   
>>   	/*
>> @@ -322,3 +329,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit *state)
>>   
>>   	trace_msm_atomic_commit_tail_finish(async, crtc_mask);
>>   }
>> +
>> +int msm_atomic_commit_setup(struct drm_atomic_commit *state)
>> +{
>> +	return drm_dp_mst_atomic_setup_commit(state);
>> +}
> 
> [Severity: Medium]
> Will calling drm_dp_mst_atomic_check(),
> drm_dp_mst_atomic_wait_for_dependencies(), and
> drm_dp_mst_atomic_setup_commit() unconditionally break the build when
> CONFIG_DRM_MSM_KMS is enabled and CONFIG_DRM_MSM_DP is disabled?
> 
> msm_atomic.c is built under CONFIG_DRM_MSM_KMS, which only selects
> DRM_DISPLAY_HELPER, whereas drm_dp_mst_topology.o is built under
> CONFIG_DRM_DISPLAY_DP_HELPER (selected by CONFIG_DRM_MSM_DP) and
> drm_dp_mst_helper.h does not provide inline stubs when
> CONFIG_DRM_DISPLAY_DP_HELPER is disabled.  Unless DRM_DISPLAY_DP_HELPER
> is selected by another enabled driver, linking fails with undefined
> references to these three symbols.
> 
Hi, Dmitry,

Sashiko is right about the link failure with CONFIG_DRM_MSM_KMS=y and 
CONFIG_DRM_MSM_DP=n; I plan to fix it with thin wrappers in dp_mst_drm.c 
and no-op stubs in msm_drv.h for !CONFIG_DRM_MSM_DP, if that approach 
sounds OK to you?
