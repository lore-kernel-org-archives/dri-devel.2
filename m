Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B07D35144
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2BD10EC19;
	Wed,  1 Apr 2026 06:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkAs45Bi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLLrGMmt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FEA10EC19
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:55:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316NeNb3104026
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 06:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WQQBKnTeuxvZFrzaqYE4weQC+7shJLwzkpMeciVeR2c=; b=kkAs45BixoDdaqYD
 m5zsRRk5FPMRMUuN/wmaYH2UnhTIRI7ScnjOHA+i0PQn7TFDfC0qDMz3765iAtyX
 iUlKmPk3t9IFYtOLlTwyofF71TYu71kSSICrAC6aAhbc8NAuD6sy54fSpL30bnkD
 LocEabT0ljT0ApYU5reQdl3TQPdHss2Xu3NTUlHb8h8ze8ZpS7fY+DRoYNQgI6zD
 bJv6+l2P2svSfjriEORkUgxKWcFD16lyoorkQuBWOuKBxHMH+O/3g4arOdDcUIDJ
 Xx+ObbBZSViwoGG5ftgfn2fw3upOrN5wwfCTysHThtY8varxpWaPrmUD3n2FJJEe
 4dwBjw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js22y48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:55:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b242cbb97aso36809155ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 23:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775026539; x=1775631339;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQQBKnTeuxvZFrzaqYE4weQC+7shJLwzkpMeciVeR2c=;
 b=ZLLrGMmtE324ZsPZg/MssEw4YeIRqzqw9KBzBSdMLyUiRNXOQDEMhKrbnQnmAOqEd0
 p0Gboj4g981MM6oG7l8yNLOlT/fFqdJ+q5epuxf01W+maiEuMuKcXxPpTA2hcC2iuucC
 wrf2VOks+bCpoh2ZGM4r3NzZQlV5JtRw1n9bp+0K9JYt2xzmFovglkHod10X5lbZruJ+
 Mew6wobpoq2P4S04s6uGIOMlz+LcWacylll6g3onEg0ZEuXxVN8SRXtODNXGW8Y9LbW2
 4kgdNtcavlMkO55ZD1JQUlMvWpAm/X1dvXkICvL9fidi8g7mwFopfqVgVNEENHQwc/6C
 T94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775026539; x=1775631339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQQBKnTeuxvZFrzaqYE4weQC+7shJLwzkpMeciVeR2c=;
 b=EoJr5gaudjXA9RMc+YeFTRtK6JSzU2/1cgXYqtWs/JE1kXlrUW+04yFs7Y256pu9pC
 C/ZdxWXLf+8Y34G4gJ+Hp5u3T/IqSLl05gXRAvF8Y5zbyFe6ZjeTa9u5G4zmexMKUqAT
 usy5dSIL0QEfcHqgnzQ4wbjPjZ7LuLaIAgizLFCqwQsJhmFuJ3c046kcOjgg682f4TF9
 gq/j+TaC8rm7mCgYvhJBmz3U/z5zDICdvqEXHGZ6heidr0dAJG93w58hxZ0xcsoH972M
 ATlJysdjk2PsZjWg7q8W43bsGK88b44+j+X67v9eBZpwi+HWXqGS5nYk2260hmF8AXAf
 1KbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1TYNZqZd9rzBdSM7OwXei0lVQruEAQU1Ei9+cCO68HCPF7znKPbKB30NfaRYDQAg9vN7KeTw/2Ms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjqX3DKMlP4+tOFwtcK9UTb3Wk33+mdJlY7Jb2p3EmKfXX0IhT
 TuVvY2+/MlRb3HgO2dSs+gyyqncro2o7UmRHStXYKjGo3VQ1DpecPAdcPUwWLz2tcAwyLHcW0/0
 z6J7l8m9oi5MyNYXsW1utvsIPgB/OIchw1/ozFENFc4qkWHJmKuJjZ6NA9BWzQPrd3LxqB8Q=
X-Gm-Gg: ATEYQzxHB7wDMMr2ITRvZ8VEdn0vx5lwjaLUpiSgE6y5PB90NWY8pDwrsEEp9Col71I
 Gk8Iqk4Y8/8sh3MYM6nrBC9LSqUtD5QE6gAwlc1oghBjseEs1o5QgRy2DT/+nAhaYA0RngPRBHK
 TbHkBBxk7hql3NXk2SBN7F5qqh+PwRsaRW4EC8G7AN52GzcTW8qXbShlqJHoKzpY4LOXor0Vghw
 TGQ2KlWDuZQlsf7oAAFJBJ0RaxXf/i7sJM9C2NcXcSdab/BD5sep+O+XET/w55WMMQFyUKEICqr
 2tYQRO8+eV5WMc19j5l3F5t7mkMY8j+MLcXY9aTfgMe3ZtnELJm8blT1X1oDvOcpSMnG/apywxm
 1IYcDdJ2sLNQpS+J6wiX2m9XrRsBChsKiwitwVBIXeq0KWuy8P9c6PjRAoNQ/e19numAlu+Nj8a
 gfiRtTkzl1zOSs9a744g==
X-Received: by 2002:a17:903:3c2b:b0:2b0:5968:a6d5 with SMTP id
 d9443c01a7336-2b269ab5ffamr23059225ad.18.1775026539047; 
 Tue, 31 Mar 2026 23:55:39 -0700 (PDT)
X-Received: by 2002:a17:903:3c2b:b0:2b0:5968:a6d5 with SMTP id
 d9443c01a7336-2b269ab5ffamr23059055ad.18.1775026538539; 
 Tue, 31 Mar 2026 23:55:38 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24ddc0afbsm137964415ad.64.2026.03.31.23.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 23:55:38 -0700 (PDT)
Message-ID: <fbca1547-d54d-4bab-89b9-404d97c3c08c@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 14:55:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/38] drm/msm/dp: add support to send ACT packets for
 MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-17-01faacfcdedd@oss.qualcomm.com>
 <mtli7kelybfot6ai3lqjagy6hahnpkimqjnjbk26shaoekqoht@cbycvfsmry4o>
 <46d97aec-9f46-42bd-8725-2c236ffd13ba@oss.qualcomm.com>
 <4cb29e7a-9a75-4f8a-9036-c96e9190b7b0@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <4cb29e7a-9a75-4f8a-9036-c96e9190b7b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yVFqnVHaEQ5Y2542mYqRBWQdDJG1lJUG
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69ccc16b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FT7dueq81gZMvNQLzlUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MCBTYWx0ZWRfX88mK0Iw0ATIx
 oFyV4IEeHRx9C6VqdlVR7GjF3x9PCjNxzGQOXB4Wq5/I2o+Jzwxpj0EOqxfYaNju6neJjTvN1Ct
 7PV+mQQ171WmZ7ZAUcj2JXKc3mHr7JOQ9anVFFhg0Ypd83O2TsWhWhkVeGz+VuqO2SQgH8pC3xa
 UBuyp0kG4JOD0uARWHYtKPCNs5s1lAk+MMrcaGevAxyEzG9+UpHsV/iQT62zg6WL7W1PRQfWGB9
 m7XnwWhdqrSbp4VRDmCJ5TBzLi+YTT0I8qwFWY6Phuc5YPXsCHbAuSVo6NVHZ6SaAzZubMFMgRp
 2+6+AVBQzd0AX8w7v5Mpw2IDwdBtBpLQANn+sZWtv6Wt8SMLdANBpR9pGRaUF6j2rhMA+9wBDeV
 rls35vo/9PNGw3ZvvtgV8xXz8EOHTGfbc/iJP+iUXve9giajSgqUnNo7xQ+DroN0md7lE1dvlFg
 1cvTIQnJywKL2gyGTtQ==
X-Proofpoint-GUID: yVFqnVHaEQ5Y2542mYqRBWQdDJG1lJUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010060
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



On 4/1/2026 2:47 PM, Dmitry Baryshkov wrote:
> On 01/04/2026 09:44, Yongxing Mou wrote:
>>
>>
>> On 8/26/2025 5:10 AM, Dmitry Baryshkov wrote:
>>> On Mon, Aug 25, 2025 at 10:16:03PM +0800, Yongxing Mou wrote:
>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>
>>>> Whenever virtual channel slot allocation changes, the DP
>>>> source must send the action control trigger sequence to notify
>>>> the sink about the same. This would be applicable during the
>>>> start and stop of the pixel stream. Add the infrastructure
>>>> to be able to send ACT packets for the DP controller when
>>>> operating in MST mode.
>>>>
>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39 +++++++++++++++++++++++++ 
>>>> + +++++++++--
>>>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
>>>>   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>>>>   5 files changed, 44 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/ 
>>>> dp/dp_ctrl.c
>>>> index 
>>>> 608a1a077301b2ef3c77c271d873bb4364abe779..16e5ed58e791971d5dca3077cbb77bfcc186505a 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>>>>       bool core_clks_on;
>>>>       bool link_clks_on;
>>>>       bool stream_clks_on[DP_STREAM_MAX];
>>>> +    bool mst_active;
>>>>   };
>>>>   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private 
>>>> *ctrl, u32 offset)
>>>> @@ -227,6 +228,32 @@ static int msm_dp_aux_link_configure(struct 
>>>> drm_dp_aux *aux,
>>>>       return 0;
>>>>   }
>>>> +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
>>>> +{
>>>> +    struct msm_dp_ctrl_private *ctrl;
>>>> +    bool act_complete;
>>>> +
>>>> +    ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, 
>>>> msm_dp_ctrl);
>>>> +
>>>> +    if (!ctrl->mst_active)
>>>> +        return;
>>>> +
>>>> +    msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
>>>> +    /* make sure ACT signal is performed */
>>>> +    wmb();
>>>> +
>>>> +    msleep(20); /* needs 1 frame time */
>>>> +
>>>> +    act_complete = msm_dp_read_link(ctrl, REG_DP_MST_ACT);
>>>> +
>>>> +    if (!act_complete)
>>>> +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete 
>>>> SUCCESS\n");
>>>> +    else
>>>> +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete 
>>>> failed\n");
>>>
>>> Shouldn't it return an error if the register dind't latch? Also,
>>> shouldn't we set mst_active only if the write went through?
>>>
>> In some cases, MST still works correctly even when the ACT trigger 
>> fails; here refer to the downstream implementation.
> 
> I don't think it is a good idea. It would be better to signal this to 
> the user and rollback the MST configuration (as in the case of any other 
> error).
> 
> I will change my mind if you point out i915, amdgpu or nouveau drivers 
> ignoring the ACT issues.
> 
Sure. Until I can find more convincing evidence, I will make the changes 
as requested.
