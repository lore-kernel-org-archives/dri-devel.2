Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8245C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407EA10E355;
	Wed, 19 Aug 2026 05:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5h+Tm+N";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KrJIWOgl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092B110E2A7
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 05:51:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J5IEED2285347
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 05:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ojm2+u9vHv8+sQ8wnLowKabjsVDJJmVlvtgKrDJSMuU=; b=b5h+Tm+NRxgoI5Vs
 ipeYtg1F5HmRB5ZyWZFhwpECHFsEUpxPDja+/P3B3fMqrPFWlBlpbUBBoIk9CcIb
 tInEaY5ikGxQ1N8qJVkH8dgdASWVJeQkog7prhow0nk5MPYfxNb/kbECYDa70NQD
 FUIiPPQN4jhVLfjlLS0Mwosn9lbqGwjZ4eqzIu18ev4ijWKoVYb0GhmgrSbDLWc/
 VXQiR9T5PkG34+GlAXuO26QcOyCd9S2QuyPLFnPM5l9wypnNm8pwVKIYBo00rH7o
 RZ6AjSX2jBhkj066rmGYfHtSnyrQl4Cw8LkGUCLRLh1qv7nxfh6ujLSeGiKqkBa/
 G1uqRA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfk9hr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 05:51:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso17606965ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787118660; x=1787723460;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ojm2+u9vHv8+sQ8wnLowKabjsVDJJmVlvtgKrDJSMuU=;
 b=KrJIWOglvC6obUJJHFTbJXw4ucbBG6OYguNCDdw2fjEvNcI/Owqkj3dL+Mf50YmYCu
 jeTnUpbUbBEjRdxd2DMkodQPbRt7C+gRl4984VcPPeY8qb1ci71RfPSqHDn2DwIJx97c
 nLHJkas/S6QTHbmpYR+hiphikShCMDW2OUzNCU7YgggGuM/48O/2m2vBSfjOY9fhitWk
 bF9L+o1ABwv7M54Sv8HqtfKYvPg6RCmhA7OSHVETHIzT8+5utLlmqg+jx2pE9vknaRm4
 cYftHUYV7b6u4yBoLtF+//dA8lX8rX81/mIXgVQvJxlCxxaFXt/Kl5/3EIWQxFG4T0Vy
 qTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787118660; x=1787723460;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ojm2+u9vHv8+sQ8wnLowKabjsVDJJmVlvtgKrDJSMuU=;
 b=H1pAQEOuBZALD2B7XZINf803DxDUgT5Cn+O2JRkeniJg0GA5og6cYXkI2hlHJIX0ZZ
 iri15y8NEUzf4k7heGSIixoxgrflVeMki71542tnNy79h8h9sQ/NyZJ9Ki1owaNUqhqp
 Zo8K8o8I35abzDQut258n8LSqSSiRr/dcPcvI6aXg6Fz5bUBldXjUf9SW0I7RtfW4sWJ
 xjHZGMDkrj6araIgunB3ZhUiJApUcSrWB7fCit2tyn7zmKsOzCqq9cTSqvSUentYSY31
 AyNgkQ9AJIZJcGu7btgAfUche7117St62q31HGR/nH+DftcpOp03HtZl+3dytXNGBOrX
 Zeyg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrvow/wLReIQPENxY3kS2lCSB44lVq172a2qBzb5qkRpK9GRrNKcztq3mrIuxoMs5A6DIAlGck5TDk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZ/jYR4iIf47n1NRZUz1JieWuwLf+wUvbS76p2KMhfcRE9X369
 CKAkE+ShBcgd0/jtDlfEXKzZ6Qz7G9T0dXY33UfoQsFLaHUCvZlqBbSYzKTPiPpbk2w0EyCu35j
 QByTkouIs0yPC6bClavgFMzNVag4D9xs9jFxtLB9dyeRkyewbLLMG2mtnl9VjE7s2RpBOlsg=
X-Gm-Gg: AR+sD13ILm22k6O5OxdXOEXxFOCYhaesQQ4OVuy0VzstJoVhlwuOZZn5BgDhOFCyB7A
 dl6CPf56VskQkBAoIPlaK3+k99qLmSVDsR4BOhwuNLiJefei/5mBDhPu2ktqYdijfK3FQl7ng15
 i0REI+6DE9XYnbjjZSsdo8CvWYhtSux3IdXVxO3osbxs0KcZLc+5Yd2EfEYjX1q0/CFXH5flHcA
 qWlQ8E1SCN03Ld7JZR97B/LNZww+o6E2TITTdjNuja9DU4De9Ftbs45Xgj1IXS4xPyLvJnKfu4z
 s3L5lOJjaosfSn2fWKJQtYdn7IJHqq/e25TbYS42fMFaqv0GFEij7uIYs8EwskXhjrb4EnM7iPV
 7LEau1oBPuNueZPXJEyXa8Lo66kQ=
X-Received: by 2002:a05:6a20:3d19:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3cd00dcb3dfmr5032692637.2.1787118660007; 
 Tue, 18 Aug 2026 22:51:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d19:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3cd00dcb3dfmr5032622637.2.1787118659611; 
 Tue, 18 Aug 2026 22:50:59 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc15544d5basm211672a12.10.2026.08.18.22.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 22:50:59 -0700 (PDT)
Message-ID: <5355d0f7-4987-41a7-9640-886c90b5a2ad@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 13:50:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
 <5hksiunlpcuv6b6eu2tx5furtzhsmutlts25vi2t62totceedg@r6fagkhlflic>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <5hksiunlpcuv6b6eu2tx5furtzhsmutlts25vi2t62totceedg@r6fagkhlflic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PoGjqQM3 c=1 sm=1 tr=0 ts=6a854444 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=BEJFxvBaT2hUfSgglMUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA0MSBTYWx0ZWRfXyuibFePjSfNl
 0oXbSJ0u5YOpQFw5cw2cBwbDq+8NWKcwXXCT5CpjgibPXS+S6kIV6QZH/9DEcgEyB41tQs9CUDQ
 QDXEFjOz7F2UsmNq5sqopnh6YSODykiyDG2duMExjHx79zPTVLKrHmH0iIBAiDB1bRMQdiD2Mbg
 9OwVmblIIXNxoDSB6shBkUCeseFklEfq+fF9W3oExeG+Enca/IPdbAV3ibPKwHIdxlPIKfZxG5y
 fnU3g2wa3M6jYPXMjI1kjo4vMEx0nbshgYDrPrBOU9A6ee9im/sWfay799sLy1b9lIalJyBgznY
 FHZQlViUGHkaXmhFlxBfqLMyFbCs+ypOXCLqhrSglOGhpWtYoUO+br3m7jgtbcC5+KTjCZ6LbOS
 SM32n5RQIyZlqIZD4ZhO68S2AXZhl99UAh63xnPTAt6kByTiYVEuLKJSHIVk/Gk5YSrYhRGrP+T
 1NlWNwUb+O98+L16nUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA0MSBTYWx0ZWRfX6oEQlJbzDRp/
 bZE+5lB5kTBctYguxPwF3x+kYO8uqlPGliOKxgLS79af3/Qzh2//AXLVCwiKnl+nv8GvDH9Uy7A
 420HfEYBcd0b2ECnGjUHeLMq7E+gRH4=
X-Proofpoint-GUID: e9cN5yrIrwuHPHevrDv89eH6O5q7wg8q
X-Proofpoint-ORIG-GUID: e9cN5yrIrwuHPHevrDv89eH6O5q7wg8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190041
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



On 8/18/2026 11:31 AM, Dmitry Baryshkov wrote:
> On Thu, Aug 13, 2026 at 03:44:53PM +0800, Yongxing Mou wrote:
>>
>>
>> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>>> powers a subset of SSPP blocks.
>>>
>>> Can they operate independently? Does INT2_GDSC need to be
>>> powered on after CORE_GDSC?
>>>
>> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should
>> generally track the same state, except that INT2_GDSC may be powered down
>> when SSPP1 (VIG2/VIG3/DMA5) is unused.
>>     - CORE off, INT2 off
>>      - CORE on,  INT2 off
>>      - CORE on,  INT2 on
> 
> What will happen if CORE is off, but INT2 is on?
> 
As mentioned in the reply to Konrad, we can't do that. INT2 can be on 
only when CORE on.
>>> If so, perhaps changing the clock driver to make CORE a parent
>>> of INT2 could be the simpler solution
>>>
>>> Konrad
>> That would still need DT and binding changes -- DPU has to reference
>> INT2_GDSC directly to gate it independently, so it can't be hidden in the
>> clock driver. The two GDSCs have independent GDSCR registers with no
>> HW-enforced sequencing, so they appear to be peers rather than parent/child.
> 

