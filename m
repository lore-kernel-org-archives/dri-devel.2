Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56D3C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1862610E7F6;
	Mon, 17 Aug 2026 14:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIDJDKcq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OfmbQcip";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35DA10E7F6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:14:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HD6KSm2431695
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6KIqa8NWjnhrY+o22T90DyvLOoGWN8sNSAn3IPl7xuQ=; b=HIDJDKcq54Ui5H4z
 fdVChMBtd6v73U1FQRXbqKwqT9cKpv8s59dOSnvtbum/BZ+UPsmewdigrK2TigFo
 6MnS5eMY4qXLbJATw/EWO1yPS2b6NHL+AVw5NFQalHPM4slYwIGtm/LngpL0iM4D
 JCgdPqJMBI0BFuvi9+N6CdtJ77UNDEndnNeZ20qbFoEmNQZToPKIvPNznKzhsdtu
 etGx9C0p7Mz4nFZHPkTp7mEvd5bowqYxMM8MfJufG0Tdr+hBQ35QXUBUHj1tR68K
 QdFjNM+mi0yHmXMFdY9RFhXIhYOuDpD6FAs6R6hWRhzrO6N3jONNrYAW1+8OQkfe
 gau7ug==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wrehkrm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:14:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92eebb130dcso31534585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786976064; x=1787580864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6KIqa8NWjnhrY+o22T90DyvLOoGWN8sNSAn3IPl7xuQ=;
 b=OfmbQciphILS2N8gtNWMny27wTylNPaTj2P7ZUqVRwXKgBYjIUz/tkOc/aFQzJ0O3w
 DzZWJr/V82ZY9YJ2986TVqQHhjXO7wc12OToi3k/y+N2ryky/cLPvhbVVs+7Xys5qVOQ
 2bXV7EBBFO7bsZx16mDcUiyRwGqaiN5mvZNaWNbNZTnE6OlIlDBIPoQnn4QAiy95P1R/
 f1P3tN3WXJ4N2MH0+QCjyEYSQrS/UWy7vMSRdC8wF+851z4lIyM3mytiHYYG/oebE/cf
 FiI/fl1hj7nboMhceOkTMIyyvgHokVNazV5+hyawkit/jeHKDKdaEcyfI8Ok5CSwbtLW
 2uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976064; x=1787580864;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6KIqa8NWjnhrY+o22T90DyvLOoGWN8sNSAn3IPl7xuQ=;
 b=TGukRFrB7tW+HF3PaNyfeJZZL4TMDGCkafBp7K4ZHs0xyC/YJOFRoc4TupGgkfCW+p
 aqaMYzvCCEsHwoLeIRcpC0xBJhTsyVKZ5p9thKEmBNiYBn45Mnkygpw4/5qtRPJTfUkc
 MH3gLNUbiBiDghgkhp9jnbAl29HQAKwlhABCQXwG38EgxskWVU2JT6mUqWVtyDZhF6nm
 LPKbok/IEHVj31ffP6kpJPhQdMhMActBZWfD60UzOb6bdiaaE5s8URlZ4DNKGxnkwuTZ
 vKe9mhXMBf7qi8wBuDHJP8i3m3dD2qdDYNTNskQTs5+WAgMv3UjbSR82Lm+Szvp2fp0g
 2Uhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPvsBjZNUXcrUIiVjgMMJxbl7OO8BbQotY3ylccUVWWFsmH71LnspsBYQsGaVTQ4YN8J48shEcqiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxt7r/rR17nvNp48Ta8lB97gP6KOuoI5WwKHnmfOLC1/SwFKM9A
 Ne+b1mRVKQN9PttHODirTSwe0RhN7nYAkraY2ErHHYXnEdssMAN/G5y++Bx1rKnWy7rFGcKlIt7
 GBESI2pLsuk5LNut4uwLbe+5grip4/MhuluGfklZ4cHOdA4b2ZUFmO1qZIucpRrD0YGNZWuM=
X-Gm-Gg: AR+sD13/PzA6MJwRcfG36HGGSKEzmQZa9JvbCgIV+ITaPTs6VfDan8Fio5BHHcGZIt2
 FBsCblsLXHo5XV33FdqgKs2KQYE8xHxJhx/hXIr5sQDhGtLP8DwN1S+NqSdvUs9WrHUPlrtwfZd
 1qmnLU635wefZyLaoKJ8/sHeYdWekbrbzAC0/unJ3wDa/cT4z2oh4hH+Dr2GqcJ7D3qjwa+vaDa
 hkfPOS5R9qG4qe/BL4vx0T2Yp5srZoYYUYsNHNI3qfVCzwgA9c3zvvX2AsjGv0/QJUywpBjW64Q
 WwGrAvkF/7jNjdDaWa+BqMH9nA3Tk8LUvilHwNRfGV2zCanVVm3oNFhYhzkt/CuEIEfC3K1Iued
 R3w9ZeDNzn4wHNZfZo7Zhnu2p
X-Received: by 2002:a05:620a:6910:b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-936d1edd4fdmr1907563885a.0.1786976063502; 
 Mon, 17 Aug 2026 07:14:23 -0700 (PDT)
X-Received: by 2002:a05:620a:6910:b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-936d1edd4fdmr1907555485a.0.1786976062918; 
 Mon, 17 Aug 2026 07:14:22 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3d852d915sm757705a12.9.2026.08.17.07.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 07:14:21 -0700 (PDT)
Message-ID: <db2a18aa-f5fb-4ee8-8747-05fcf740749f@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:14:17 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FqI1OWrq c=1 sm=1 tr=0 ts=6a831740 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7SNk80zgYqIXXrXIq28A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: I0J8u-NR_hFcu3cxfGCIGbnbBuhdYvT6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwOSBTYWx0ZWRfXy26QneOrgJ5O
 f5Fhaa9oGqYZwrKoSHCVH4lXTVRwaGzYAC7bD78cwBuWea/4Hh//UekB+Yr4+y5i4GQs1ddXQAP
 IIjFdCPv99BVeBMmrAcUCMzFCy09G53L1ejHvmGBlSTnk/k5XteXUlJiQwz3AwmbQrIFK+87CVF
 r0D9fMMU0XkZOVbqtgIEnA/0xyFNKzhQL3SnTpQPKDyFJOoa/ELIemC6+HOJ133L1GU9sYQ7M48
 zAXKanTYofkZK0UOt1VKIASYch6506xKtYMCw0bF+q3PltIxxrFpEIH2/PxVBUDOvzIShy29+Ge
 WHdNPnVFVaLo978+jQTzE7jeziBbDRkaJwVafSy/Ia9236SYmHynDNfwMrm4x+YDmZP086sHdT6
 iP35WfRAyHgbzVpBItVMH6+vjSiH48f/sSdsNq0dY2NJEf8h8VLeQMiAeITWj4ia3XsmNR1eZhV
 anrq3qlftJPgAqv4FXg==
X-Proofpoint-GUID: I0J8u-NR_hFcu3cxfGCIGbnbBuhdYvT6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwOSBTYWx0ZWRfX1Wu0WWBMbDck
 7FWHxwN3syBXWwIV4AaJVlKZo5fUtONcj7RdyD8ftaTkep8urR1Rb2R0PdAxymrXl0SDv68yXxo
 ExTdftLHlA9mT8RNQUhwxGhxtBcHjo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170109
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

On 8/17/26 4:13 PM, Konrad Dybcio wrote:
> On 8/13/26 9:44 AM, Yongxing Mou wrote:
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
>> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
> 
> Is the MDSS any useful if *only* INT2_GDSC is enabled? Can the INT2_GDSC
> be enabled itself if CORE_GDSC is off?

(I didn't quite know how to parse the list of states you provided in your
reply so I asked again)

Konrad
