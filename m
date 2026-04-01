Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72635D35144
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE7B10ED02;
	Wed,  1 Apr 2026 06:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fcvXp+nI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTMReWEY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE2310EC5D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:47:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6310D83e3240035
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 06:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QqJzznn7Jynr9ThiDh/BQmWbeg+9dCozPKVtRFqAuV0=; b=fcvXp+nIkCZV7eQP
 2U6Z+OXf5E0JLgERCFCTw/Z3YKRQp47VJpBWg7jCn8oGwt3S3Uob9Oc+RkyEYoaH
 BtmEThIzPnCZ58GIS4MaEvy9NHxBreyM/xwynN15dFwC86gE7czPyOsjzcZRashf
 JGRrWKO2keq2SOn62kAlhsOAu25nitsna0fMWr+QIZrg0MSbcQjWMCG1+j4BGmKO
 Ocaue5q13FEXqeFnqa4zjJQRzQssQ6xgj75rr7ZoiPfRKhfAs4yk+ayp1hOKO/YN
 dmTXGQnkdDgvAqE/NlAFiMV8ziPiG/SrAaM/F+6P8TxXj5rd7ohQb8SJHC++kukh
 HCRD9A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1yw4xt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:47:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b6f869676so139617351cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 23:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775026046; x=1775630846;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QqJzznn7Jynr9ThiDh/BQmWbeg+9dCozPKVtRFqAuV0=;
 b=KTMReWEYMTp1dNx3viaALQN7QJkDpFwu0Tiu8YAU5qoe+Rf09CScUYkMZ1S27PNbhp
 IV83CBWY+qW2GsQx8pvKeU5znYynN12NsLpNtnlbhj757VgtFGM+im50ww2VcBkPBni4
 WkGlgTwPHz6EUuh2PTGZAwmJ9yDuinzSOQSaUa4/fu27CWFYB3VSuzBT7AFOc9vI9FVQ
 IgExwqW3+xY4SskUmU01Eu44+jVqURFO9jxieF+h/uaremqdOJhe4alA5hjWSooWUngv
 8fb7qeBl8X5KQy1IDGvjl+NPrAKXluMZuXMSO/z1uksv3u0IVy9nmt1H7SVgGOsHxB++
 exsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775026046; x=1775630846;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QqJzznn7Jynr9ThiDh/BQmWbeg+9dCozPKVtRFqAuV0=;
 b=V3F6WBZufricxKdjPlBxgPWvlubphk/d87FaEcLqnmn3FK0reEiZTqpYnBuA1BR7IX
 Vv0EeWlhZvr4PyjtUTj/cxmIjpIe6bzlQ8i55AJ6vzNIi0NyQXgwuKC9kqqngc2Q++XM
 Lox2coITZWBc51hGjEmI8w3a8UdX+s4mx2xU5CyeKPufBt4xE+fXLExiMO6OjvqB0A1H
 XaaC6XmZVaLSOYGA8vYkK+teihmI/dPMOOggRrFIreLogooGbb4MrYbrhHoqhGkZR+np
 X5erVElbRNYi364EqfsDrLjTdPeSMDLhBaF/H0/5AQ0fo55COZ47qvNGRiZlOCeshyds
 K92g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWetCitr/fFbeLgDEwX8wD2gI67XR54Lm+/kq5uWdlmrlniBEHv1GZWFbKP8Eyoybv+3w3MSFkIqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgsuPRbqMRdDNT8pfZd04yl401eSNZMbn/dAhBMkSTTjImzth9
 nQcRTLDFddynY1pfSqjAG/ue9gOHxwjOn1k9fa90YAPMgpQpGngj3SrHQctTM3+FSHGkYYaHcSH
 cn0sow+lsHjcvhOHZko95a0QoP6mCQ7zfB7eEomoJl/huPgbzkQep4qsZ30Mdeq2IikYiCcA=
X-Gm-Gg: ATEYQzzZOgJrQNuk5AEyNjkEv5Rc8UJIS61mDr09U9071Gwu0h8dD8cx0PfK29HW3UP
 c0pHckb/xf2JlN1W6mjIjM8kd+oUDUMCU3HIXdB5u1Q9TcQ9cH1av8k9E5VOtGpSd5SRAG+DTwn
 vKY5Kg6ZBs+s1ZN4GcKgO5/DCPjEtfZ9or/b3sawhiPVM8qbN4pqDnPIBN2zjqUqnMNgA7hOeyo
 GYcqKdumYEYRug8wuF83viyzdLWt1WKPP9yDqHcCvKfRAf9MBs5eJNqLJR4wE6BORkdO67uob/e
 BP94gI2rHrCs0/ro1fRCbRgcY4I0CsrZ20ENoXQGUMSomKUIIZefE/E5a8/hwzxGUQRqKW8hDWk
 6VEIGZUGdU4Ug1mvwh5TR1Dkl3iR+qWErbmq7Znkmw1Zspgyqt/nMIvhQR0Su+4noIQclQV8MuR
 pFGBcZXVX1u3wd7rmCu/3rddSd
X-Received: by 2002:a05:622a:256:b0:50b:6b39:4df9 with SMTP id
 d75a77b69052e-50d3bbfd9f2mr34036261cf.30.1775026046229; 
 Tue, 31 Mar 2026 23:47:26 -0700 (PDT)
X-Received: by 2002:a05:622a:256:b0:50b:6b39:4df9 with SMTP id
 d75a77b69052e-50d3bbfd9f2mr34035991cf.30.1775026045796; 
 Tue, 31 Mar 2026 23:47:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a073:af00::4c9?
 (2001-14ba-a073-af00--4c9.rev.dnainternet.fi. [2001:14ba:a073:af00::4c9])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c43b3597sm173211e87.23.2026.03.31.23.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 23:47:24 -0700 (PDT)
Message-ID: <4cb29e7a-9a75-4f8a-9036-c96e9190b7b0@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 09:47:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/38] drm/msm/dp: add support to send ACT packets for
 MST
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
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
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <46d97aec-9f46-42bd-8725-2c236ffd13ba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -9l2mZyhP6JWHQTGJdcPzm9uQX1Ou95M
X-Proofpoint-ORIG-GUID: -9l2mZyhP6JWHQTGJdcPzm9uQX1Ou95M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1OCBTYWx0ZWRfX/r+PyllVkBHi
 TKUYdAXEv1sTsaaAPEI7wOINaqknZM54ma1+/1Q5xhTyJGWPaJTMNyVqR6h6FOCW3QOOsl5l5Mp
 RbR3HirK1gN5zpkiYE4sGypbrho2nie3S4RKkwMo8NIAl36tZy4zaipRniAu+Pj5PKwSIHdffu/
 2k/I42xhsCqHFnZEQTgDBMQs++pwygDYOJ2as/452dvfsM2n3WvDgkgfUV33ucNw1+OPtDHP5r0
 V2mz6JGMjifcZCM6gimMUxqg6dqfkFMinkJDzhBcgyJW/Nf7KAvqRTAFeoNgLBenQ0Mag7wwdG/
 GmeCe3LBa/SjbA4ZuZLSjUc2KT7L31wM/kTRMs3GV8JsenQ++CaULG6y6LMz2pxt/P+7FlzBu0T
 D6IPUMF+R67P8/nc7JNXJo+/CNEuIX03dJrJL1vBb8Nauy+hl1jI8oc42D2y0eySVUd7n28KKHQ
 lHzXR8iaoL/1oTzk+tA==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69ccbf7e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=hEYASa3n4XitINDXwYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010058
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

On 01/04/2026 09:44, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 5:10 AM, Dmitry Baryshkov wrote:
>> On Mon, Aug 25, 2025 at 10:16:03PM +0800, Yongxing Mou wrote:
>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>
>>> Whenever virtual channel slot allocation changes, the DP
>>> source must send the action control trigger sequence to notify
>>> the sink about the same. This would be applicable during the
>>> start and stop of the pixel stream. Add the infrastructure
>>> to be able to send ACT packets for the DP controller when
>>> operating in MST mode.
>>>
>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>> ---
>>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39 ++++++++++++++++++++++++++ 
>>> +++++++++--
>>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
>>>   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>>>   5 files changed, 44 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/ 
>>> dp/dp_ctrl.c
>>> index 
>>> 608a1a077301b2ef3c77c271d873bb4364abe779..16e5ed58e791971d5dca3077cbb77bfcc186505a 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>>>       bool core_clks_on;
>>>       bool link_clks_on;
>>>       bool stream_clks_on[DP_STREAM_MAX];
>>> +    bool mst_active;
>>>   };
>>>   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private 
>>> *ctrl, u32 offset)
>>> @@ -227,6 +228,32 @@ static int msm_dp_aux_link_configure(struct 
>>> drm_dp_aux *aux,
>>>       return 0;
>>>   }
>>> +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
>>> +{
>>> +    struct msm_dp_ctrl_private *ctrl;
>>> +    bool act_complete;
>>> +
>>> +    ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, 
>>> msm_dp_ctrl);
>>> +
>>> +    if (!ctrl->mst_active)
>>> +        return;
>>> +
>>> +    msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
>>> +    /* make sure ACT signal is performed */
>>> +    wmb();
>>> +
>>> +    msleep(20); /* needs 1 frame time */
>>> +
>>> +    act_complete = msm_dp_read_link(ctrl, REG_DP_MST_ACT);
>>> +
>>> +    if (!act_complete)
>>> +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete 
>>> SUCCESS\n");
>>> +    else
>>> +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete failed\n");
>>
>> Shouldn't it return an error if the register dind't latch? Also,
>> shouldn't we set mst_active only if the write went through?
>>
> In some cases, MST still works correctly even when the ACT trigger 
> fails; here refer to the downstream implementation.

I don't think it is a good idea. It would be better to signal this to 
the user and rollback the MST configuration (as in the case of any other 
error).

I will change my mind if you point out i915, amdgpu or nouveau drivers 
ignoring the ACT issues.

-- 
With best wishes
Dmitry
