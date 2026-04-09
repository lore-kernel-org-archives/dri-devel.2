Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCE1EA3C4E
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC1910E7D0;
	Thu,  9 Apr 2026 11:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQgtvptO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G7rDoGLg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEB310E7CF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 11:33:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6394vsKB3532458
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 11:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lSQtNNtrN/Cj2ZcaKm5dvAcEzbJkLVwFQlaO2exXYfE=; b=GQgtvptOFJ4Wk0NK
 uevgShDBYjEwp02c0y6ad0DT+UWmh5HrVL6y/p5Pu3qQsWBdp98zLG5CCig4g8p2
 amiYLolhg9ESXTTmG6w9gXJoJK8Xa6MSvrjuTaTTRJNrIrM35JArJOcq6MPTHSHU
 vaMKRQs5TGHdLlNAO+HYIL1Iz9bR82vGhYRbhp98e9/2uxqXh7uRBDjKo3g/Xrmn
 hEA+fqOksFk45bfgEgy8hh3bO/xkKdQBVzGGrDkDxhT9M0J/11w/omMX1OB1PuB9
 OZtIZL+YmWyR6fzits8WTA5QDA0jiwfacn8oZR1MYtqwlG3za8Ji7vcVbdE2Kqov
 Xb/PjA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddw9mtwx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 11:33:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d93a8149bso947710a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775734399; x=1776339199;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSQtNNtrN/Cj2ZcaKm5dvAcEzbJkLVwFQlaO2exXYfE=;
 b=G7rDoGLgDHAGDQg+Hq/icX7zcVV14EYshq9Smx6dWHImuwxInqshcHvpr5HWutx2K6
 z4ZDPe4UG8/PK4My+KYkptcMR39RORlelbgw2bRYhvQ2gFlF/hqUITSMkzzz/WdYgqC9
 akFXaRPCfK1qT/ve1neryGNCCKLAaQCqp2PqByihfZ8FcNV+N3M5EiK9WAvRKDUcJMLC
 TndFj8pNPhYaE11+dGAc39/xcbuUdugtxz/CnmDCSyTBMRKA6LJi1V1C9s9gpyipexzK
 3th2Qlyii4iOuCVsC1qfNi4qCsVTeecyhSQr/bh2kZtMTZP6MvZFzITqOY6jAecLwv9+
 91pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775734399; x=1776339199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSQtNNtrN/Cj2ZcaKm5dvAcEzbJkLVwFQlaO2exXYfE=;
 b=rJDy/lzhBS+adwLdbRsoFwNMc27EQC3lL6BBHAzUj+pzSVxedDbUxxaiwdXActpbGb
 JYUQxrT0bGAJRHxPKlJaDswaJkuenDo666NNt8zWOh7cusvSW+tuOQWTFeI24NVgVGNb
 0qJnY9w/qeyWz5kqoCIuXIT1yWt/cH4mfONILBR/gOdizfNRw1TtjgpPSOb/W8bF7IgV
 AP2xKEHDV9ACDhGk+gU4r3GPL9Gay1scgh1msb+VjdA16IjTD5gkAvGnxfOOp1dO+6BD
 HVtJw8XHpxv+g6PPjAPAxMq3akvyHeluQ2iUUoIPqkxWlACmtmQTHjN1OHx+uAQG0fFa
 MmWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMR85D9BcdeOoctwniUlzqSYmZ1oYFC6jpTIdxmPymOuSUhGhuGl9ZWolI3VvYvFagg4AS9I0jUNg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHL4tU95Oe7jNugHdZDMjFpRqltm9mDmM13S2JRhf/VtN61PTY
 cGI+FuxarBjiTqzU6iXoFq+nEEQWHtSoqbTdM4ZtDlvJaFyPG5w//oWgKpI+GOCTYPeyPX9s8eo
 Cavp+or7pr8JtRhCqH9svyB6chKBPvJl9oCRcreawndmKioN79ToT/ffs9FfkJZHRP13+CE8=
X-Gm-Gg: AeBDievvg03NRbvUoCSW2LptOB/1jLmr62WRapyRj8yWwMi1+OpJ7rOOTm+CsNE+7QF
 nfldOQfRd4p5ulrfOsm+FrFx6Ru8mJ+maqPbttt07zR08zak1aQmHXmpYfwjbeZ1GJkxtEP802S
 j7Q8hvlqzyMxubGzNJ1RV3TfU5GmCGzdpsSTNJGJgdwaczjI6dJgRmvTNnI3eqX8NQeb+eJX02A
 At8Dvsju+Hx0LxKYzLjqHFTjIoim6XSxfNKVX09uXrvKz3uqlpazHZjLzZpnBJHtnX2VIFJ1CLq
 pPq5vK0EmxwXTelmp9u1SVT7Ve5KuOjFkaC15EHT/qv0uhslvHJWxt5RDUNdE9a8FcZLigx8KxY
 f3fm/HR+i0vBZCNuEtiUUwscBU+dGZZAgVxJBXLb3aZaN/VqM83ILUy0nePQvt/EmsTGkn4awC0
 kKpY8dLbwcFHaYDvPkDg==
X-Received: by 2002:a17:90a:e7ce:b0:35c:195e:112f with SMTP id
 98e67ed59e1d1-35e3548977fmr3157565a91.18.1775734398596; 
 Thu, 09 Apr 2026 04:33:18 -0700 (PDT)
X-Received: by 2002:a17:90a:e7ce:b0:35c:195e:112f with SMTP id
 98e67ed59e1d1-35e3548977fmr3157537a91.18.1775734398074; 
 Thu, 09 Apr 2026 04:33:18 -0700 (PDT)
Received: from [10.133.33.242] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e34cece9esm1549105a91.1.2026.04.09.04.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 04:33:17 -0700 (PDT)
Message-ID: <1e3e0fd7-742b-49cd-b432-da9bd2a0ba7b@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 19:33:12 +0800
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
 <fbca1547-d54d-4bab-89b9-404d97c3c08c@oss.qualcomm.com>
 <4rhd6qlj4jevrnj2zqctqrcbpkvcalk5qmr3ryuk6ewwa7e35p@o7xzhuzfsms2>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <4rhd6qlj4jevrnj2zqctqrcbpkvcalk5qmr3ryuk6ewwa7e35p@o7xzhuzfsms2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cfPiaHDM c=1 sm=1 tr=0 ts=69d78e7f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=YxuP5ldsg-JQntm2Dv8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BqFv8J2OaAduh58y-1k9Mt-XDPlc014w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEwMyBTYWx0ZWRfX/Ga4/tRHUt1D
 hg+BQRL+VPsJz8m/8OGwO/BGIdnlz9nfHWmUyNOt7hoSLYYQ9M4EiwVMM5jr8W4MCXpvyzgYdqo
 a3oVLe60wfO3FaKZv718OsE9+//Y1857kVXqqDEyLEvWu47OU2mEDRNvZLdndkU4D+uAq9HekEA
 7fB+xhkGLJx/rFeY9qw4jxyUn8BF+3GJKPCWa25umGx7UkRTZFaRMFH/KwAoaUgPr16GSp+T+It
 HxJuxHmqHxFkd+3TGAHzPOaA4vtK+w6F2oedAPzEJqLnPKV0Go0GSTXbnUOLoOvmBlILjdfQb0S
 t7wTsCjev6XoAs3GGrstmWdlvPTs7wZOQDJtAwceOD+doUdn1DgdwjLOSFGSZBb6QrYOs9Zi0tc
 KTIKbaWFuMft4Yi7+DzJvUyDclSECe4piIO6c1y9XI+NNtfzxKTbyo5jwTaI3OxyvlAsrjL5A+Y
 0cztDnYp+pxkgWnJIzA==
X-Proofpoint-GUID: BqFv8J2OaAduh58y-1k9Mt-XDPlc014w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090103
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



On 4/1/2026 7:27 PM, Dmitry Baryshkov wrote:
> On Wed, Apr 01, 2026 at 02:55:32PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/1/2026 2:47 PM, Dmitry Baryshkov wrote:
>>> On 01/04/2026 09:44, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 8/26/2025 5:10 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Aug 25, 2025 at 10:16:03PM +0800, Yongxing Mou wrote:
>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>
>>>>>> Whenever virtual channel slot allocation changes, the DP
>>>>>> source must send the action control trigger sequence to notify
>>>>>> the sink about the same. This would be applicable during the
>>>>>> start and stop of the pixel stream. Add the infrastructure
>>>>>> to be able to send ACT packets for the DP controller when
>>>>>> operating in MST mode.
>>>>>>
>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39
>>>>>> +++++++++++++++++++++++++ + +++++++++--
>>>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
>>>>>>    drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>>>>>    drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>>>>>    drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>>>>>>    5 files changed, 44 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>>> b/drivers/gpu/drm/msm/ dp/dp_ctrl.c
>>>>>> index 608a1a077301b2ef3c77c271d873bb4364abe779..16e5ed58e791971d5dca3077cbb77bfcc186505a
>>>>>> 100644
>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>>>> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>>>>>>        bool core_clks_on;
>>>>>>        bool link_clks_on;
>>>>>>        bool stream_clks_on[DP_STREAM_MAX];
>>>>>> +    bool mst_active;
>>>>>>    };
>>>>>>    static inline u32 msm_dp_read_ahb(const struct
>>>>>> msm_dp_ctrl_private *ctrl, u32 offset)
>>>>>> @@ -227,6 +228,32 @@ static int
>>>>>> msm_dp_aux_link_configure(struct drm_dp_aux *aux,
>>>>>>        return 0;
>>>>>>    }
>>>>>> +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
>>>>>> +{
>>>>>> +    struct msm_dp_ctrl_private *ctrl;
>>>>>> +    bool act_complete;
>>>>>> +
>>>>>> +    ctrl = container_of(msm_dp_ctrl, struct
>>>>>> msm_dp_ctrl_private, msm_dp_ctrl);
>>>>>> +
>>>>>> +    if (!ctrl->mst_active)
>>>>>> +        return;
>>>>>> +
>>>>>> +    msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
>>>>>> +    /* make sure ACT signal is performed */
>>>>>> +    wmb();
>>>>>> +
>>>>>> +    msleep(20); /* needs 1 frame time */
>>>>>> +
>>>>>> +    act_complete = msm_dp_read_link(ctrl, REG_DP_MST_ACT);
>>>>>> +
>>>>>> +    if (!act_complete)
>>>>>> +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete
>>>>>> SUCCESS\n");
>>>>>> +    else
>>>>>> +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete
>>>>>> failed\n");
>>>>>
>>>>> Shouldn't it return an error if the register dind't latch? Also,
>>>>> shouldn't we set mst_active only if the write went through?
>>>>>
>>>> In some cases, MST still works correctly even when the ACT trigger
>>>> fails; here refer to the downstream implementation.
>>>
>>> I don't think it is a good idea. It would be better to signal this to
>>> the user and rollback the MST configuration (as in the case of any other
>>> error).
>>>
>>> I will change my mind if you point out i915, amdgpu or nouveau drivers
>>> ignoring the ACT issues.
>>>
>> Sure. Until I can find more convincing evidence, I will make the changes as
>> requested.
> 
> Or you can point out the relevant part of the standard.
> 
Emm ,the DP HPG only specifies that an MST_ACT needs to be issued, and 
does not require validating its contents. This appears to be a 
Qualcomm‑specific hardware register, not a generic one.



