Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23048C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B99510E28D;
	Wed, 26 Aug 2026 13:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMs+jxax";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W1SELYaj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581BA10E28D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:20:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCBjLM1909131
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ELhK3Fdw98kZw2wfGL+DHumauqq7uUpJz9jAzGKztAE=; b=aMs+jxaxOaA28pFt
 LCipY1WVLPXxjplFYjxAFfm7P1lxB3TpXMgZo8csCEO9aHmo1xer9vpGl1V0nr9o
 ugtrkRPE//+mic8wgmvHgwK1+b+m4vyhHmCI5DUuYuPDOSrC4icmcwXmf93OF6bN
 rFwHKSqm4gPuuJ+OcQ+Rlb86yjlPhYhULAgNEPUOjT7uLNmoZmCTWoE7GC37vlK4
 21jLiKj57YCy5S0pbmfPPxLYIXHsoeQL+ssEBWbxvPMTA3hC7IwKaNl5DUK6tD9O
 inL95T5xej9Db8zz2Tij43UPd17kmWZO8jRLd+16xmBOfg4heCxv1PmvZVWsyy6R
 A7dprQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1sdab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:20:06 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97cbaa9bef2so12075241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787750406; x=1788355206;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ELhK3Fdw98kZw2wfGL+DHumauqq7uUpJz9jAzGKztAE=;
 b=W1SELYajDmA/1Huir49jtofw/ggJi9yu1pqYMAL3F+/Tcnder4cYnYajJUy7xnwC3p
 c9l1WIIXpA+NTDZ1Ap8EOCjf8u1qQb/9PxVMTXRTJX0M7VGmKqkoP6GB4kqQBL3E9V8A
 znG3KM5cP4RaV5DGe4+w8LXT5qDfbC/ddh/ocQvDV6UfKJmI6bOC54S6f6Dl9GnEm2bE
 vZATMaGOIlAIUyyZzq0CLMbtCEAFO1Sw/PMzEE4xqQO1iql0G3ITFiJ+cP8H5DBEa3p9
 6mI8ulBGY+TXX1cY6CyJPvoVTKk0O4BA5p9B4ofnSxJ6a1jhK26rKmouv3Cy0E42njwr
 jDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787750406; x=1788355206;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ELhK3Fdw98kZw2wfGL+DHumauqq7uUpJz9jAzGKztAE=;
 b=qgjtyECK8AFYx7h5d2HqIlmlFwlwP5nqyNQxc/fKa62HsoKS7VzQRe/ZDO0n9zdahX
 vEMdWQxtvW/IpS2PaulDqtctMpw8bBXVQ77r3Dudoq8apmOP6YK58UhPTZtf7yuF5c3k
 9ZDjya91Ydez+Q7bvtRol9wK/e9C1k4p5y3eCPBJ+mY/qVp1zjQz4TVg4zkLifEV1rJI
 otWvUpXc7zAm/gQ/HWdk6WjFSD/G9hmUPXSz7yV+QQFEIyKUzt9TmIRMlf0KdZ4+DcXG
 X0bMGhjw80GGZMaKRSzc94+NRyAOpSdxBOTWt4f+MGLYTMGrnw+cpMa/tqAulzSyNJ5n
 DZrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqO1SbC4x775rPDv027MrwCIBKb4RNlZprd2aKM27x+P7HBji7AyvoZYxS3LZINPWI/iVd+63FIjs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kV0iR1xo1bB+zWM1NmKVDi1tUHKss7Frrsdzc/DSYSd85pnvrH
 7pwA/iHLJ9Ex0CdayE5ev2pGngRU8NPWTiaEUzUgUK/Wtg4hLW3P6pwFP3dR0x7upg7Zzq+/hTJ
 ulwfeAN2IZRxLhP9BtdaPjlpFcvMRbEBR4j9rIp0ifIAWDMWJSmSgZWr+QKQPY6cILCFFX4U=
X-Gm-Gg: AR+sD10LKqAx3XaGz8YcwDaYadezVF7JMk9hf/ar3miXqA5EnECwVBU4vlTsVLVRJ6s
 Xd8g82zlelCsf6GqDwI4uOAt7wN5F1ywwvJptJlX3bW8a8pb2NY+TMCKlVmHrK/mT7VclzkNP57
 l1iMNLrYpZhBO8vDBNRjxQ70Kl5qNMQ/vkyNx47oHDtz5W65+CFrRBzTjYyvverlEVwgeR4quUB
 p9mM6Ysvit2gBVabMmzBU5o3Q/nAeMrXvEj7QtsfDwY20Yy+aenZ+9wZisbe0y8JE+teTfv0zum
 x08Yc6wtJ2jaMi6YfHNc8/2DMcTYlm0xkFTzqAgNwwFIJWZNZWRZTW/N2jY1VYp6bUzSZlA0aF8
 L7IPC72Ukxa1MRT8sdJzaDyfg
X-Received: by 2002:a05:6102:1490:b0:783:a923:efac with SMTP id
 ada2fe7eead31-783f9034d7fmr55351137.0.1787750405597; 
 Wed, 26 Aug 2026 06:20:05 -0700 (PDT)
X-Received: by 2002:a05:6102:1490:b0:783:a923:efac with SMTP id
 ada2fe7eead31-783f9034d7fmr55324137.0.1787750404893; 
 Wed, 26 Aug 2026 06:20:04 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c251b7a9936sm337362766b.49.2026.08.26.06.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 06:20:03 -0700 (PDT)
Message-ID: <f36b9019-91c8-43bb-bfcc-5da06d2d122e@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
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
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
 <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
 <db2a18aa-f5fb-4ee8-8747-05fcf740749f@oss.qualcomm.com>
 <f344a913-cc95-4fef-880b-f1fee200c108@oss.qualcomm.com>
 <b6d6b627-a38b-427a-9e62-ee883505b2ad@oss.qualcomm.com>
 <15826e27-514c-4aaf-b56e-b40ed0bd600b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <15826e27-514c-4aaf-b56e-b40ed0bd600b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IWsX9QK1WwdwpOmeQH8uLoQejFXG62LL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMCBTYWx0ZWRfXw+MxcVKdWZ5X
 Hvpb7TL8c8ZD0MsMrKbsggjoCY0+i+j2C1SdgfsLIxh9AATejnJhMIZl5Dt7ZyQ8KQg/kzsTJpt
 bT8ZVzyREcl+fQFUGvKLdejh4Y8ul8BKbNpqaln8I1CsdfbSXZasR2VRxakZfURqlXdMccVfFMM
 r9wKlTCzXiRYjuVdeVar8lvTpnqG/+vcAReVJVX2qI4lSyhvBlshJXIFn065+vdJtXe/cTuX8Gs
 zpz2ancWdMmInkEyTvPVlRPAq0ZAjREU1StZvdxqPW/GLsvqBqEGnSU1JTuEQZwkRNH6LnF1DjH
 VqE7UD36ZL3BrxgayXvCnajcPAXAkhdV/7qi+k8CUcv7zQbGbK9R1S0erbAWtQ8G/pymIKNdcow
 qNsKnKqnMKy970HWHb5dCTmou1tsO2ZjiMpN9HIWGtsmR95L+OB5J2PaB7Ql+BcFRJ1F6aEAtj3
 bZ7/sKyHUclLnQJUd4A==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8ee806 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=TDtJeqXoE0GuUOfqXLQA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: IWsX9QK1WwdwpOmeQH8uLoQejFXG62LL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMCBTYWx0ZWRfXwspiuuwSgzfS
 xTWPpe1utCfOmOlwoWUWT/lYMe0RxK4qI+qoTxe40aVayKiwTlZPZwuhMGjHJ19wDbp0spSPNCL
 34AMHY1ZG7vjVSX4SUTOCtKI7prUCyQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260110
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

On 8/26/26 4:53 AM, Yongxing Mou wrote:
> 
> 
> On 8/25/2026 4:30 PM, Konrad Dybcio wrote:
>> On 8/25/26 8:28 AM, Yongxing Mou wrote:
>>>
>>>
>>> On 8/17/2026 10:14 PM, Konrad Dybcio wrote:
>>>> On 8/17/26 4:13 PM, Konrad Dybcio wrote:
>>>>> On 8/13/26 9:44 AM, Yongxing Mou wrote:
>>>>>>
>>>>>>
>>>>>> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>>>>>>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>>>>>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>>>>>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>>>>>>> powers a subset of SSPP blocks.
>>>>>>>
>>>>>>> Can they operate independently? Does INT2_GDSC need to be
>>>>>>> powered on after CORE_GDSC?
>>>>>>>
>>>>>> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
>>>>>
>>>>> Is the MDSS any useful if *only* INT2_GDSC is enabled? Can the INT2_GDSC
>>>>> be enabled itself if CORE_GDSC is off?
>>>>
>>>> (I didn't quite know how to parse the list of states you provided in your
>>>> reply so I asked again)
>>>>
>>>> Konrad
>>> Hi, Konard. Would you recommend adding the parent clock in the clock driver, or handling 2 GDSC in the display driver? I'm preparing the next revision and would appreciate your feedback.
>>
>> Does disabling INT2 provide us with any power benefits and will the
> So far, I haven't found any documentation that explicitly describes a power-saving use case achieved by disabling the INT2 GDSC. The material I found instead describes it in the context of display tiering:
> "Goal for partial display is to tier down from premium tier to match low tier pipe configurations."
>> display driver do the accounting for what resources need the INT2
>> GDSC specifically?
> Not at the moment. Our current requirement is simply to enable and disable it together with the core GDSC.

So WDYT Dmitry, should we just wire it up as a child of the core gdsc on
the clk side and pass just one gdsc to mdss?

Konrad
