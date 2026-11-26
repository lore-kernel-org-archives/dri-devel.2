Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D6606A336
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fLQJCho7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ps8PBDqV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4D010E9CD;
	Thu, 26 Nov 2026 14:30:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B8710E9CD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:30:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQBVMrY3893625
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZYKSqpNm7JmeDVDfHCjbjXW2efJm2SoQYSo8R7KD5hY=; b=fLQJCho7UC8UCfin
 bajE0cFg1J/8Pw3XuXRvnKPdu7FNMrJG5Crue6GGgTXll1dlK3SyvSOE4Esg+BZi
 /1pIR82MvIbclgjYxvznLpFJj6GpU+/1Z4PXPwQT7mC6w5tWNIn7dao2jZ7VNXyR
 JW45x/4cFUDDYvCOoJKvuzdZrTmCCfwMN6Xv3P175H9n7UShF0BVTCCpmJaQn4uD
 Zac3qSfe+cS4JAmkMGlCIyGK9i0PUpG1wM4j9VfNniLHkKc9bP8/B9tnI1h1qyfc
 33i6SxLCYKSMIZvPgQ5FuM30lm3EGm48p8333M248Iih7dxFtyFENs7077KFkAGx
 yCPMLA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm816tc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:30:02 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7ffe90b2cfdso2559388a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703402; x=1796308202;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZYKSqpNm7JmeDVDfHCjbjXW2efJm2SoQYSo8R7KD5hY=;
 b=Ps8PBDqVUJYqML3l/KlP9HYg1s8Pt/pwD8BnHy/DhNLFCPrPqIusIMB3hOCFDWmEgd
 muqO1gYSf7I3NhLgZio0KQsH9aZwMhEyXSEdxB56xIl3hNiE0/LgwTziK4CMIHQ/aWpB
 8b7IUZb0ASvsLoRoE6CXu7GW9R8hkoE42k9ou1PMoJ52Esslr7nA/6yddSBKy2Oi7l+d
 bCyDMgEiy2kOtaWk6dVoBLWdqWKRjqed10+o7RPr9qmSq7CJavAX59Z4A1DT6VieU8Qv
 r8KIgu72rtPwA8+qbCEzsQunvju345+8P9g5Iee3yVYv3sAEE+s45GaMr/P6HdONiEJ8
 Jnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703402; x=1796308202;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZYKSqpNm7JmeDVDfHCjbjXW2efJm2SoQYSo8R7KD5hY=;
 b=U0bsKux/dYhoaTdBPGBXCiuFjZCP6v8p59eTJcWrvIw14xYhLc0x8ayxCByvXfc4L2
 XU8RuGBa2eSbkzFjwEebEQ/f39FT0NqdlKFyE+i0dLzzQ1YDt3/y7LVBYnMfLz7sYLum
 QzjLvjUJB9Juej5pAhm6K0hqrPEM+4Bu7/84Gv42kjeaBaFFgHVgUHHXYHfefGM4CBDZ
 DljECp2LTUZUJF/BONySQHd0pSJB0H+l2iqapBxn1PIJKC3JRju+3E8kscZzeQY2Sx2p
 aOBcaehTL48ruxnYhrOS8l6+Eiw6I54B5SHlKPtxl90LbHXVaQdc6qg/qJV/G8UfzozN
 jIQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGRKOdN+whj63s2XUjz5BKbw7Ex8wYse21KAXf27TXQE46b6XjAAiL9mv3SBscm1mQNQHjfTFCyfTQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ry5vg5cldcU1NIJjqylvItx7tf9sN4MU6HMdL53/80n8cFxMo
 VrcNdJ2xnLNBkz6Z9nwk05Z3sOcwbVk/KoYb/1qy0Jtciy/GgNRByuHzgmdbRqGJHTu2B/jd1bU
 TMyzf0FK92/m6WcPjVJBqYAJBvGCJH9Jnewzp83mt6ZsHvvwPcKLjRCQeuiC3QAfdb8+Vp7Q=
X-Gm-Gg: AZFdTZfj3LwG0zWcE7T66mNU39d1Dmejo6vyamArGFLMxmgICBbxYHyQOYzhpd7ilIT
 iqeyiHNwz3Xp0UUFscaNyI4aG9x3gxjhpusfwC1nCvKPxP/+bzC9D5oatTPeKCK3WVIu3fDk1U7
 11Q+Tb2+WAXImLBxLEctZfccXLFbRYxuYDqgA6MaAFz9YBMeaHZ7SKag/01mge8OVvWw5UEFNz0
 U2JCKFppvwjvXTjgYUvrWuZ+E4JKwnTbUzW+DK01TwuY35hEzzuaas/8ARuB8pDstvhkZ5ECfKx
 +82HCGsptI6saHA2XjKRq3dTxkm5hpLCpSrINP8E1hbZdeBFqq/WaMkN38EAY83JlVEwkp8YY5S
 FvczPErytExn+W6Hm7O+F0UVqG4x9S3lvgJDQghqInUnavVXmqBYs8Gl+e4GVtTKtbpTT2qQ=
X-Received: by 2002:a05:6830:2a88:b0:845:3cfe:5f2 with SMTP id
 46e09a7af769-86314ff95bemr34000823a34.0.1795703402245; 
 Thu, 26 Nov 2026 06:30:02 -0800 (PST)
X-Received: by 2002:a05:6830:2a88:b0:845:3cfe:5f2 with SMTP id
 46e09a7af769-86314ff95bemr34000765a34.0.1795703401810; 
 Thu, 26 Nov 2026 06:30:01 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513aea28f4sm782697166b.33.2026.11.26.06.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 06:30:01 -0800 (PST)
Message-ID: <56ac1346-3164-4418-a00a-168323787535@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:29:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/msm/adreno: Add speedbins for A660 GPU
To: me@fromdisposition.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
 <20261105-b4-sm8350-gpu-v1-4-a7175cdd6512@fromdisposition.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261105-b4-sm8350-gpu-v1-4-a7175cdd6512@fromdisposition.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ggaxDg1CuDuVS2XhitPdyPNPDjB8wQZf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXzxqb6tXAd4+S
 o79orJeIcWMRu43lGFNklieTQ/JQaZ+dHEND3Kwlax18PAzVw9PuexHGMBeoYTC8EbQh3RP5AzR
 PY3B/hifnwU/GzAiml5Jkz02mBqQEAo=
X-Proofpoint-GUID: ggaxDg1CuDuVS2XhitPdyPNPDjB8wQZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXyuFAkQ4EZ3q+
 eGvTytbPYEFrbcqQcpsqqUQbgXW930NznLo3JJM+LMbMVdtOS2X+JK43J4Qzrkfbqs1ck4jcuyI
 y0JKMSMA1N4erZknstztezR5l7tgio9WyUJk3HQEKK3R5UDWzK0JyiJklz1o5DL49WTp5FaFvN9
 z/QOYzTAQMhHMARhOanghEKy83e/HDgfpkkQn9bpb7iq0VI8TuSVVWSQBf6gSxRE2RLPtxZvqzR
 kD7eACX/keoLf6VPZTWldizrKf3LCYMuWVed5BlmfK++IHKUha8VCYgFc+l7oVSelTvuNb6cS51
 /g/ALnsp2ke0b/1lJP0aKPxRCWqEDL7Rxz2kct+MTLNhgwg3S0nw/uJXgSG4K87UnlJKsMFqBn/
 Frzrd2TriWa71kpbQEPTu0z888FWfu9h+feF8kyh8sIXmYnI9fuLMxM+pt7dNDtiL2OPTB0gseH
 k7pZdiWMwNNln7C6cFg==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b08426b cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Tt5JBQAfAAAA:8 a=LR9blauW7GWGG1yPYK4A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=kpHMOrJS8sLNr5ru0mYA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260056
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 2:30 PM, Demeter Barna via B4 Relay wrote:
> From: Demeter Barna <me@fromdisposition.org>
> 
> The SM8350 GPU comes in speed bins, read from QFPROM 0x17b bits 7:5.
> Qualcomm's GPU tables for this SoC give:
> 
>   fuse 1, 3:     up to 900 MHz
>   fuse 0, 5, 7:  up to 840 MHz
>   fuse 4:        up to 738 MHz

I only see at most 2 bins, what's your source?

Konrad
