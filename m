Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C4CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 01:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA11112CCB;
	Mon,  1 Jun 2026 01:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y7ClhwIL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORupfCiP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07140112CCB
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 01:23:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64VLSuvn2768377
 for <dri-devel@lists.freedesktop.org>; Mon, 1 Jun 2026 01:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MQQ/N5JLV+fPflhn/nb0oSsHxPTvVt7khfwCnr2kKEE=; b=Y7ClhwILTxPJAO++
 x+fbkBA21A3z0KL5GTp7sKdpPwJvHOZk6O4/toVRLdgPbWdIcuzjrklxCtaa7kYk
 t39ZqMngz0bCf3j1EGS7iGD1jZCEivBQLvBeQmV1ELGcMh1Q2WHU3z147EsUhsIZ
 QpcHZXzLa1lY1zqy5+c1SHvkVSTAxjaqAsvN7BEHQFg4my15nsbNx2ucMaJEft/t
 ML7YkKJev8+LXyt3Et0jmR4vk46CvRELRLTAM4/tbGk9KEQTzm1jUJ4dh8YYgyBI
 0Z7HRKO+nXc7Gv/0zY8QD1IsLkyxacANy1hs/ZoqNioqQT7ORJE47FfGrqiV6GzH
 DRfgMw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyuw29x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 01:23:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36d99629fd6so1336289a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780277037; x=1780881837;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQQ/N5JLV+fPflhn/nb0oSsHxPTvVt7khfwCnr2kKEE=;
 b=ORupfCiPpejL2YOHsRw0A4grAUCEi5meP73xiGx7TujWqznVECHqyj+MN/NrvwYdIW
 pDvDEzmQ0OUEJArhGcxJkhGYPhLGAAUo2FQbBus5sy5VGPSNaJZv5x9ba/avRUTklGNT
 hpNvho9u++vvIhNEIkyU5h9+kZDYtcUQj2tNZK1FbafatGOvE72J+WNJHr0AdQc9nMgO
 9YbewKK8oNxkC7H4tkRmDNxseaI61C9PRpGzhnp/u6J9h3BAggJTuEYCfSjkN6bInB3P
 LxHhAobnp5GPrfP55k4KahRdXKb8s61Lkf5DkNavbOL7ZnlPogmYP7NR5uW3Lq2S+s9b
 0beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780277037; x=1780881837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQQ/N5JLV+fPflhn/nb0oSsHxPTvVt7khfwCnr2kKEE=;
 b=nyV0utvQOuUTYAETTN94c7cvh/wMZ1SHxevvwhqj/JS0lolSdRbmLvaMIzKMSlajea
 32+EwNTHjVzT4Pdt43PgMkVehp585eIeuasfcxEngS8qOM1cy5OySncFuwaGkWIeHKMH
 mlGlgFTigyHS9p7a4pcKlgBpy+xo6EKOnqxcHhjeezwkDUs9uNy2ilcIqoVCq4bDay/i
 tUDarvn8d73YLRB/aVFfBRV4zBlwSFRGmEbGJJ7P1Xgjn8JXJlukuxBVREPeZNUVoFaH
 90jJMXrcMc6eF7h7ZoFsSgKXovrA7Dr1TDqyHmo59yVolBdOOtH8Mc/tv3Y2gv5t1NzX
 b39A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7R4DeMamu6i/s4i6DQFL2KWa6FIGIsc7jeh9tfHW8Vull3VJ7IXm2qVb9Wwhh+Ygi6hkb7Hmjr/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzygNZwH7NJzpH+0z+dokUg1KGsfkFplr0srNVo0GIiIeXmzQdR
 R2lqFS73VQJpGofIvnTmLRp2O4DIk+NGqcG6NjiW+7LnT6cwEHGN9/uQuK8N1E4ENgQQS6M8aQ2
 eqvq+4tpXtRhJaRceSo0ptAGi1jRlyOzjru6qMJlVzR3Dtw5iNZcQtrp4qZBzB92+D4kn1JM=
X-Gm-Gg: Acq92OHJ3rL3rIvG4ll7Eq5jtiFnqEV1/ddrGq9WXRF6aCeON4M2rcHBmjOVEd55gFf
 yBab1KeLiantzkYC7sWPZvp+mbWB+apClJsgGqynFkpQecjYTq7DwDgD9l5llBAhFPEF7fpXnn/
 35hqYQTFRsroILp3g3vsC1B8wmCszP4MReBLp6QRJIAkNj4iOEVhT5oKKjLfuV/6ztFMdAkCRJ5
 hxFxS0YMEfoqo4PNRVh82DmisdimsUNChypd5tXMseoe/UnsVVI7pt8/yo+9MsH6sSFJR2rztzA
 kNvMswuQ02CJfJik+8ATvWMtJ4brNIRGef8azcdMxdXdR+wh6iDhsVl+cIjBqBgR+1OCF/FStmR
 sYnbs6qyDl1lKQhhCfmWn4K8sezstqAC0KvsFd3eoIUz64+ixKyBdMsK4OwyKs9Q1FP0u8ZmOSf
 qe9m2k/y2RatHYWjh5dKIVwSbs
X-Received: by 2002:a17:90b:2d88:b0:369:73a:326a with SMTP id
 98e67ed59e1d1-36c501e69ccmr7803014a91.13.1780277036598; 
 Sun, 31 May 2026 18:23:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2d88:b0:369:73a:326a with SMTP id
 98e67ed59e1d1-36c501e69ccmr7802986a91.13.1780277036195; 
 Sun, 31 May 2026 18:23:56 -0700 (PDT)
Received: from [10.133.33.48] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bc660da67sm8964023a91.6.2026.05.31.18.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 18:23:55 -0700 (PDT)
Message-ID: <e00a4089-021b-4c26-8a6e-ba1faf86218f@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 09:23:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: misc: qcom,fastrpc: Add Maili FastRPC
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com>
 <meuxtcs3quchupl6gf4vtjiosmoig7zs2tc2vr2xthetem5hll@l4op77zr2srj>
 <a7b4c0ea-0e02-4ede-8d51-a4c038d55a5a@oss.qualcomm.com>
 <moeb7zqqhengrd2nrqyuqydyq4pk4imd2uylmr4tf2ypn65h34@z33iifvtf7al>
 <20260530-wise-discreet-woodpecker-3c7d0c@quoll>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20260530-wise-discreet-woodpecker-3c7d0c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAxMSBTYWx0ZWRfXwN6CwQobiMFa
 dRDI4n5xQoFK57uAhwLZbJHNMLJOPGdybX9MoQAwqbb+SIsjMK/nhefD76mPGlNcVux+SREy21e
 EUWEFtKcEQr/7SgYbhXNO/dT2mhlpfGRJdRg/Kh+PLRKEiF5kCkBF43U4fxq9p9wjn9mI1KwtgO
 7vOzi5mzs2RBxKoVrHVpzzHAn+nxwKONFT1vUiKl8iT9KbRSKbyKRxTPzEVC33T3A1B7ZTHqMcv
 YxsW6wRMFEap1dlgzwrY0HcR9xWU1X/B8TvmjnRh9t8ry8hnQfH8jSYkbvLyLNiWuZZCQRpnBzB
 pcBodA6KEToCtjSXGitqcTiI5Jv9tnFAS3s0DVXPYIr+Kam2lb/NLylEZVKjxqJL1uVITDBte4f
 VVvNHyVLevc11QgtEvANB9TTaigB2SHbUO6mcMuUuVtp7Hvx3vv1wzXR7IhuG1qK6M//nDSVaIV
 0rNFofar4xsYlXwak8w==
X-Proofpoint-ORIG-GUID: C0A6OlFrMhs7bfUPlshVr8wYbG_B7IHR
X-Proofpoint-GUID: C0A6OlFrMhs7bfUPlshVr8wYbG_B7IHR
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1cdf2d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=BeV8J-Av9qvwb3kx9y8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010011
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



On 5/30/2026 7:20 PM, Krzysztof Kozlowski wrote:
> On Mon, May 25, 2026 at 01:08:54PM +0300, Dmitry Baryshkov wrote:
>> On Mon, May 25, 2026 at 05:37:23PM +0800, Yijie Yang wrote:
>>>
>>>
>>> On 5/25/2026 4:37 PM, Dmitry Baryshkov wrote:
>>>> On Mon, May 25, 2026 at 02:21:17PM +0800, Yijie Yang wrote:
>>>>> Document compatible string for the FastRPC interface on the Qualcomm Maili
>>>>> SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
>>>>> fallback to Kaanapali.
>>>>
>>>> Can I assume that it has the same bus width as Kaanapali?
>>>
>>> Yes, the DMA width for CDSP and ADSP is the same. If you were referring to
>>> something other than the DMA width, please let me know.
>>
>> Thanks for the confirmation.
>>
>>>
>>>>
>>>>>
>>>>> Assisted-by: Claude:claude-opus-4-6
>>>>
>>>> Claude assisting to write a one-liner patch? It's becoming ridiculous.
>>>
>>> This patch was generated alongside a set of Maili-related patches and was
>>> not created specifically on its own.
>>
>> Okay...
> 
> If a human cannot write and validate this one, I see as putting effort
> on maintainers.
> 
> Dropping from patchwork.

I will write and validate this myself and then remove this tag.

> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Yijie

