Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3171D10A88F5
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4D810EB61;
	Thu, 26 Mar 2026 17:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h+qofs3o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqliIFn/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C794910EB61
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:47:33 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9fbq334263
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rZmPC46sgZ1WVHObuXQsL8cBPLZIUSXcaX5lFJpWXPI=; b=h+qofs3oeP5JSQ36
 yzy/s+VNqddZvplttcSf05hIGRzIE3T4azsG+bA+pLIUm70t9fNABy76RHgPntEe
 CgDwBxLOYfXdyQHoyqxWPIYwh8Jsassi+ZG+nebe8fl3RNMq6DjZofW80bYMi3y7
 YU/RwOrBv6QYYjvpBJeYbq8C4gER0/5HwtFMtzIhg9IOQU6GNGZCjImIXEokDDdK
 L6p5eepQ/i0lPD41c/vhmLAciqMzOzrZr5QLsUq9mOfcCbXNJqyRDryOn+x3eltu
 QAzk49rVqt/VxQSsM8WtIgnHJUpOjSycQfNR19WRVvFOFNUkjOwqU8DFAFFCMykf
 QorUUA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d527yss41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:47:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso3778402a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774547252; x=1775152052;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rZmPC46sgZ1WVHObuXQsL8cBPLZIUSXcaX5lFJpWXPI=;
 b=dqliIFn/Sqt5GNagoG38JnSBNe7Zrux+caI5hbP79xzKWhNCblLT33YVSf3iYBOeX/
 4HahKDm4bhinTnqCSetd8lbj6jX8t/v4I77rDd6AFFNxEyGJTFKiRRVKOtQt5VRRYzu9
 fQn2alutBXcNRyTP+xjoRgPT0Tqaise2/HQbEq5eSDgsm+AYzp7dkTgrbzhpul6Qqtxv
 k7XNwF5GuPC7ws5rmZV6QprTExLUvc69liq/djggqvvHI8LWxBdWLV17l3Hob1gArrBZ
 dMRfYxLPcsxZR2UrPVLHXxnu/dxTa+sjobs5UvnkI9G0+9TQ3XVqsIwXth6OF00oONGZ
 HbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774547252; x=1775152052;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZmPC46sgZ1WVHObuXQsL8cBPLZIUSXcaX5lFJpWXPI=;
 b=MWuhX4Xom9wqqltNL7h0dNPYG/m4uEKdooa5ocEBDBOD+vApixCggyI4eQ3q1LktTB
 lIeiDggjY1DST25wQod48uwB9qK0bczUAA6/UJnfaQgW0lcxLP2hQD1Au8SW0/nH+kJR
 g4HkCenmOSVWCXyx5r3EkSm0VOlIziXxEOV56RsTTDt5sq6R/algDwbl8Nmi+tJuAt7V
 KtEcPE2VKlQecU2aB/WlBCbGhshTpy7bBfquO+T6Q8HSSI3nwl7WXnuid2QdjrMy7sKw
 237d2JLXy9HsBOAfD3tg2jZHlluMC1uoIxbqU5N5CtX0rWxYJDMmHGIpCqpIYRjQEmBZ
 XYwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxVfQgn9wihmbFIZZ/LYjCJZEuRayrYTkPaO+8CROOdCkoKjPtbAfeDUpUDDc2HQXsCoNw7veuUW0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVAZTPsgN5MP+sE3K1hLV1rr31qx3p7HXPU2uz6CyilhaioTrz
 BCOc0tKADnlG56lL91GkLw7WvekaEEnP3VPcDmzblEOvJLoPSoxzIVU2mZXYiteGc+dZjVMXRa0
 4KoeF1x4mefIGtN3LBbxWXdDo603F/p3zZRCrfgNosyS0ihOqNud7LqzwJPmUjqqbg+BGnNM=
X-Gm-Gg: ATEYQzwScToChbkJCl3Ri3ulW+zhYipHXCeVlP+btVGMbfO88sLG1qoungxnXk+gp5n
 WCOtcgbnwhHygqWFg462ke+3eebH9gAnjmaggY8dcjlP2ElbwrYUAtKxPYvqy9JvtM6wh9eWa/L
 Kru1vkuysX5Ir4rdVj28qNJTph1gJNGNENcaVrx+6WavOUz0U1bT0xRBLzR5ZpVpNFoIm06Bffw
 HNXGGexNadxljulZThY36ZiR4ER1EkbCJ6++CD/rGMAmTFat0zrF5A38y5jY/GQAs34KhqS+KAC
 J0UBmttidlPMG6mJAZxXOsfV3GR0BHvnqZ0Q2Clg+cQgkhRRJZWngRNLya/Pi4xrthxoNAgXN1r
 F3XK00TOgeVyC49pqqYsMSgrZdkF+RU4tHGEOziEqmRWX
X-Received: by 2002:a17:90b:4c81:b0:34c:fe57:2793 with SMTP id
 98e67ed59e1d1-35c0ddad8c6mr7281951a91.20.1774547251647; 
 Thu, 26 Mar 2026 10:47:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4c81:b0:34c:fe57:2793 with SMTP id
 98e67ed59e1d1-35c0ddad8c6mr7281929a91.20.1774547251056; 
 Thu, 26 Mar 2026 10:47:31 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22a82231sm3579514a91.6.2026.03.26.10.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 10:47:30 -0700 (PDT)
Message-ID: <acea56a0-f854-4415-b4b2-2e320934b6c7@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 23:17:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] drm/msm/a6xx: Update HFI definitions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-8-fc95b8d9c017@oss.qualcomm.com>
 <30a4cdad-47c0-43f0-9327-04c28eac52ae@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <30a4cdad-47c0-43f0-9327-04c28eac52ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dLurWeZb c=1 sm=1 tr=0 ts=69c57134 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=TiZlnAevEPvvlz0WFoUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: d8eF4SHG2E1b2HFnfy7jiEtC9uA-65PT
X-Proofpoint-GUID: d8eF4SHG2E1b2HFnfy7jiEtC9uA-65PT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNyBTYWx0ZWRfX4/jfMRVfdIQt
 uOionh6xNl6SPvB9LyWT9LhaqrlytEypRVT/CcWh70Qf7/LeL1p1f45fZVBwtyq10L0AetB9KaW
 Dr7d8RbXHT3QHELIUs/6bqIobPUK/h1x5c6RYYFQivYUggVWv+wbg3e8lenTgV42Ajs939ERRCy
 S+7HvBvYKye29FhRxAWWQERqgp6+457Dc7f9ZPTgWthX9MoFMmuE2+tezHJibUjki9QwFlO208w
 ndskyQUEIpzw9zvensWxEcNbw4YVlJWKT6HVCVcRAfT13CP4wq9wDle7idHLQNuNESuffSCP9+J
 OmUwjFjaYuF5gIhNNsXmC7NMUZtaDmEJDJlUe2pg7O47gzLtDlx1mQl8IGpZDvehbpkLL3xOckX
 w9K3+/Jm/kXOQGhgMMioP3FhiZaNVKFavBoZXHsezNnWImg4Gaasbly35GqHQVpE5BdhsuCtZbR
 YvjRfXiEA0y8e3jz+QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260127
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

On 3/24/2026 3:30 PM, Konrad Dybcio wrote:
> On 3/23/26 9:12 PM, Akhil P Oommen wrote:
>> Update the HFI definitions to support additional GMU based power
>> features.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +#define CLX_DATA(irated, num_phases, clx_path, extd_intf) \
>> +	((extd_intf << 29) |				  \
>> +	 (clx_path << 28) |				  \
>> +	 (num_phases << 22) |				  \
>> +	 (irated << 16))
>> +
>> +struct a6xx_hfi_clx_domain_v2 {
>> +	/**
>> +	 * @data: BITS[0:15]  Migration time
>> +	 *        BITS[16:21] Current rating
>> +	 *        BITS[22:27] Phases for domain
>> +	 *        BITS[28:28] Path notification
>> +	 *        BITS[29:31] Extra features
>> +	 */
> 
> My first thought would be to define these as bitfields, i.e.
> u16 mitigation_time
> u8 current_rating : 6;
> u8 num_phases : 6;
> u8 path_notification : 1;
> u8 extra_features : 3;
> 

I am unsure if the compiler would mess with the ordering. Aside from the
fact that this is an ABI with the firmware, what make this piece of data
very risk is that, these are power related configurations where the
issues due to misconfiguration won't be immediately obvious.

-Akhil.

> (hopefully I counted them right)
> 
> You would then not need custom macros to set/get the data
> 
>> +	u32 data;
>> +	/** @clxt: CLX time in microseconds */
> 
> slash-star-star implies kerneldoc, which this isn't - but it would
> be appreciated, see e.g. struct qcom_icc_provider in
> drivers/interconnect/qcom/icc-rpmh.h
> 
> Konrad

