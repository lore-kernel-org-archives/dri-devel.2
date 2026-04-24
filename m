Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9109FE51F5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EB010E3C6;
	Fri, 24 Apr 2026 09:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iU68V2J0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a+9eVBtI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A9610E3C6
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:40:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O5mlnb3804212
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TUhERKpJzC7ZYA/PnGzU9lEKyH7Mxyrhg7LHLvtN+QQ=; b=iU68V2J0hud5/fJy
 nuvb94oFVoUDgL7peYgVg3ExtzCV+kGhH/+iaNbTHa4CCtIV2bZxsaxaqriRbh4t
 PJ5BTc3jH7ybihihfQ0fAW7sjC8m94cNisCxHCTPkoQWqEGzNddAMA+3Zjg/Pp0F
 1tghCwRagqdU3BCG8qxjQGxJGbzoMa+h6ZhsLCktXN5uXjj7lBUbQph0vTqHysRr
 1slNLPgbnTDFYeUj6Kc4kMaItlFNy75CT+SFAYrb+negNIf5VrwJAnKxiCnGo9US
 5FV+8Lm2hSwYU+KlA6ct0Ymy7MFXaYkPnbUxlE78qp/3AGE9TtWpRbzixFOOxkkQ
 DD36LA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqkqfvhgq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:40:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e576143baso13411701cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777023654; x=1777628454;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUhERKpJzC7ZYA/PnGzU9lEKyH7Mxyrhg7LHLvtN+QQ=;
 b=a+9eVBtIrJe6NBD0ev+fzOdafwf0qWYPd9Dpr5JqkdQHbqJMOD5SlzrHA78nKhiWHE
 9m8k9vvNWJL4alGXXzrAq2EptJa0pRSK6P79QPIcQ5anmC3Pjw9Gv3T5dCd/tdEMLuVp
 cGzyL0g4XhDkGF3GKYgDJRxmnnCD4t2TM4XrDM+uhJyxxHmMmgahRegOtcW6E0GxIAP2
 aiCADYQ0MJBTshhPT7O7GW+Zgw9V7qu/oSN+SCxQ5nFI2A1FaUI+BEptKz7qSR0XQtcR
 D5VfpaxOiLoderSss1htlnEW3cAajZbd45fwyScjj7P5svLc91hePUCjMNEGSfoOHFk5
 7YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023654; x=1777628454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TUhERKpJzC7ZYA/PnGzU9lEKyH7Mxyrhg7LHLvtN+QQ=;
 b=AG/F5j2FVXMT9xEJl2nD3s/yUG0+Se3090oN9xozPDm6z6VpiFuSwCVGXheu5DnrjK
 vRnMRHqYpCHunUFQ5cVReVGsYLBS3/qr3erJ006gjpIylfIYJxLlew1EPeUT/oQjMdnN
 7Y0JWHs8ZqqLZ5jRtIg/CgnEtUoOzTav5Z9/3uIckkAPhS/YR/oedfAZNZ9Hdt9yfrpO
 w9Y+nVS/qkpqFrmzf/J4R92hlua8rQfe+mjhg4/3g+03EF2FQnBwbImWuF8iEYplzFjA
 RdKe8fFR+80vuAqGfkM+oSpi6D83xS0lid9rTcC3I3In+AS4PPvdcr/sVxeDNi9Tsk7o
 nCeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fTrZz59818TeecTyCwq2Py0aTK3LuSODZTZUIG6TEDKtglngKKgSjClxtRhwyIsRZcsKhp5Mzf3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyzI8KIh+XYqTKUOYu18jwY2yUl4LzGgPjt50Lj1vDZ6v3wQ2R
 XHuBGHhBzS64bOwCd/jWlKNA4sw6gkyzBk0pjGwwywRxn0m34aSmd63Lng8evWcs9NjlOTReDGO
 Hj3p9rq+8IdIWqVgmWSy2QEc6SowzGFltHk54wmpbvZivW31oCErMSxsgct3mOwg4UkI+5oU=
X-Gm-Gg: AeBDieuOpVCr4Q5VXrSp/cvHVbMAOHZ+qDREWp6/HB/qlAztdUYj445OvIn8z2pHP9s
 6+CR2OyxLWSK4hp0FztBW9E1d8jodtI20gepOhARme4ACIQliqed+ZD3UwgniNkKZv3W1es5uM7
 ToZi6FVHnXaCUMQwLOUkJeKsMQPyRas1gMYBfLM633tzN+/P9ErwKiYaA5Xo2YWxnb7CBy0pIkV
 4siqO7plFHa/cGo4luQnPNg1V3OJsmvMTXH3faU5l/Y5agqnsJh9ZXtXb6k9rS2OSoLEPniK8zA
 Kh9XIt3G+FPekncOxuYvDeaMHXmftodeCrNjQJVrVABqNlX1stFTudGJnGEIK7SDTwf69g00ix0
 D+QfDz7Bz4uWuAf8mq34iXOOT+anGBUhv63AOuaGZdI1jsWxPVbK1VL7v7XtBey+iGSx3Yu1eWa
 YQInQhRsZy9noYrg==
X-Received: by 2002:a05:620a:4589:b0:8cd:8bfb:a4a with SMTP id
 af79cd13be357-8e78bee4fc9mr2868065585a.0.1777023653810; 
 Fri, 24 Apr 2026 02:40:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4589:b0:8cd:8bfb:a4a with SMTP id
 af79cd13be357-8e78bee4fc9mr2868063185a.0.1777023653393; 
 Fri, 24 Apr 2026 02:40:53 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c4d4561fsm5009428a12.16.2026.04.24.02.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 02:40:52 -0700 (PDT)
Message-ID: <31c1a601-c249-426b-8f0e-30d729907a89@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 11:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 6/7] drm/msm/adreno: add Adreno 810 GPU support
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
 <20260416-adreno-810-v4-6-61676e073f8a@pm.me>
 <23fbb36e-56b4-4ecf-94e9-4038c6311b31@oss.qualcomm.com>
 <oka0Q911ixJLZzAbfWBx54dOmxbQAre36QqHUX4iDZoH3TE5jD-IqTAHspti6B8kfpLQ-OTnuWjFdXtsqJM-CUC8G9R3x_9vFI--LnpppiA=@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <oka0Q911ixJLZzAbfWBx54dOmxbQAre36QqHUX4iDZoH3TE5jD-IqTAHspti6B8kfpLQ-OTnuWjFdXtsqJM-CUC8G9R3x_9vFI--LnpppiA=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cbV4at-BJoYO3tdW6dwchzQSm4BOG5oh
X-Proofpoint-ORIG-GUID: cbV4at-BJoYO3tdW6dwchzQSm4BOG5oh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5MCBTYWx0ZWRfX5gJczUF8++Nv
 OHGxzTcjdTgXYphr8Ej9XGwJho8NaLgtHE0ZgwB5QsWTdZdPe24eI3+2KWCDr8Q05hzTrUbbZnT
 2zcqrR6JdqIIe/5xn2sqlmplmwPp8yLFoJgBExpWhKA+rsZG/Z+BmHZOaQ2tFmu/ezHyOCTD2VJ
 AEWVZI21GIon8SoqkygkSYvBgSplVWknBJK956hj2/a2bv5ujPTf7AuYSO48HiNlIE7Acs3nZ3q
 mlha/A7NMxmDGJjLKpaFxItJ9/xKgPQiMbFZJnbEtj0GSUJ1W5x0f1slHde/NNZypOLMwK/kbBq
 WUZXnLp3HKZNbrk9oPh/+v8eufvfISeMkU752gpPr87+DuIxX2JqJJj3qGXjeSLfOcQBUu1gWd9
 iPjzEeLUmQoacVgC7RfGZtdWtqmq+YAXxNwl23Dbp64t0KHRmheVJKZGqyNVZc5at5Pa9QzL4/3
 0oHKuij1LQWol/eRjUA==
X-Authority-Analysis: v=2.4 cv=ablRWxot c=1 sm=1 tr=0 ts=69eb3aa6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=aOPa8h4f5WR7Ygev7eEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240090
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

On 4/23/26 10:34 PM, Alexander Koskovich wrote:
> On Wednesday, April 22nd, 2026 at 9:04 AM, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
>> On 4/16/26 1:05 PM, Alexander Koskovich wrote:
>>> Add catalog entry and register configuration for the Adreno 810
>>> found in Qualcomm SM7635 (Milos) based devices.
>>>
>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>> ---

[...]

>>> +static const u32 a810_ifpc_reglist_regs[] = {
>>> +	REG_A8XX_RBBM_NC_MODE_CNTL,
>>> +	REG_A8XX_RBBM_PERFCTR_CNTL,
>>
>> This list matches the expectations, modulo this RBBM_PERFCTR_CNTL
> 
> Note on this, added this shortly before submitting this series as requested by Akhil:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40613#note_3395308

Yes, I forgot about that bit. So it's OK.

[...]

>>> +		.speedbins = ADRENO_SPEEDBINS(
>>> +			{ 0,   0 },
>>> +			{ 242, 1 },
>>> +			{ 221, 2 },
>>> +		),
>>
>> The DTs I have all point to SMEM-based SKU checks. Did you find these
>> numbers empirically?
> 
> Yes, and I used speedbin instead as upstream doesn't support the SKU checks
> downstream does. Utilizing GPU_CC_FREQ_LIMIT_VAL to serve as speedbin
> on this platform.

Hm, I'm not sure whether it's a stable identifier on this platform, or
whether it just worked by change. Akhil?

Konrad
