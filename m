Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FD0C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1957B10E810;
	Fri, 25 Sep 2026 10:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7E0JYFA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XI2Hjjbe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED9510E244
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:42 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4YpsQ1056143
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UKy4uRrDP1MEnH67izTbk5nL5p9jm1/EIV3ngV59HBg=; b=T7E0JYFA9ZEsW3NB
 r8i3NHnOoYNT+DaTyTzDHTa+z5SkzbhlHeX4vl2uVJ0b1IUwPZYBrLi2l939PMmH
 BubQuvmaUuRVQ3Y1kZOFoaHt2Wx/zTCggWfZ+6QzwEzrEiZ7pTtJoraZyWfMMJVE
 MfdaL1pV/RJJb8L36U71yPatOKO3jsAV3lp5uL7HBpVAHd5wNtwp0opG4ekWmdn4
 Hki4Az4YjO+aCFTeRXtqqCp7yGH3ZOjQG86HPcQOdxPEnNvLrhgl4nvjBzBvoU3p
 Al0NeN3wAALjPJIpD1AaSfDFhs4iZ+1qzjqt3PSZBPnMBHYIaaeNe3rP5z6kfLlh
 6WAvdQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce79ytn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934a8cd3a8bso4809885a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790331581; x=1790936381;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UKy4uRrDP1MEnH67izTbk5nL5p9jm1/EIV3ngV59HBg=;
 b=XI2HjjbeoCs5q2/NZ9W1aykOorjoWsjoW9qPtxzk4JvP8qRUAS8j27qGj6oeINF9P6
 qv/RcJnqDKWFQKNnfiqUwKbxNz5WB6+nhq7ukvswJuC6RLVuajP6U2/mDRSzhBsSxYXz
 VEeR+KQLr7+m3QwXybFA9uR6VPVYTHvK/PvbxyqO0boa5Df21QoVGB5PLpC2aUTJJ3eP
 3g8+OEVWxvO1BSvpDWjZI5Dz/VDoavOLi9VfIbh2do3iisFHqyU3xkWS59+2JcF8zLVX
 Al2IQMep7h/u6l8h2UNkDEakHMfYNcLtKqZElBt/KhSbCd8DpdQGzMi64xGD05AUsZYz
 MiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331581; x=1790936381;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKy4uRrDP1MEnH67izTbk5nL5p9jm1/EIV3ngV59HBg=;
 b=06TuGntc1IAvi4/JCEYp3Xl917IMZdUfpt3DvfapaTCEeanNQl7+zzdK+VHUo7coSQ
 peIkDO9RsaK/3irU80USUquih+0rI6iwl8FnSX7XRRWONaXtsOVAXoPwSlMF3XzM4hM0
 DbH3+yD+Y0Gju4CR/QvZUSlglCLYnWmclH3AFzzTcqJP1mcDWcQn12mk4pTpRUB6YLSA
 YtnZXBonDAS+ggaDDzJ0UyXjA/GTLh5otfqx8NfUzthR2aDtzDSRkkZ9f/+xfe/sYm8P
 NsqNMxftdtBJTdZIIpzkVRaNMM+G6S+GpSUyqbLOo8ePbQD/t1l7sEODbBpGde0z3gcP
 FECQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyeLmdw6RKJ5n5Wrxorz4CokuEmrJuCPIX5LWX0cJTuUtGHOQ0kWTVxsT0KrAxd+hjjBVolTHqde0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mMAK1G/J16FSi38Fv/KBgosp8aW6+WK9W2fW8/4PVd8gGH1BNa
 F73AV4W55LqvMWW93/E8oTgxYyiEzQyamveF1pfDjlLwNpx6n/6hq8zc1o7Zn7LXV9hL4fIZ9wq
 6Bkhnrdr5VrkffehvPhvrcMwtYvRwnTgkoG6LGWF5ZhXKZyreRAL+J/UxbU1VaotOa5p7Xec=
X-Gm-Gg: AYBFou0yDLFZng5f5yuPIIXQt7wPt/CqKgArHM7jRi196pUmfwaTTtLUytPUFXUjlHg
 Rto+cwyqwYdEI9jXmCzxbpND4U6jit6LQMnAs6Wu4Q6RZKY6Hd5LE+0ZRW2PLfgg/9elzkgylv2
 k+EpD8x9Rgc8pZORTqS9jxYnpkWhMZdHDAYISx7eD4DDPpU1qtfSaY8QMmnIRBFplzvlKgfDix5
 tWEmlp7Wc6gY2Rr59OZBJEdEbdV1IWQWNPCjww5fJc6fP8x+6RN1jbvj8gknpkTkcCRHNZkKOBX
 ms3NT9ZZUVKkD5qH3DQP7nYK1xlkvwIQ/ml/+FLma4Ykmy+0JMrhYMcoWVVqxnMjbqxdP3o5viB
 Hz0sUwcQd5HbK8C8c4+mTtA==
X-Received: by 2002:a05:620a:2b8e:b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-93c439dbd0dmr314997885a.0.1790331580851; 
 Fri, 25 Sep 2026 03:19:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8e:b0:936:2f59:dfe4 with SMTP id
 af79cd13be357-93c439dbd0dmr314994785a.0.1790331580324; 
 Fri, 25 Sep 2026 03:19:40 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae74815easm93578766b.23.2026.09.25.03.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 03:19:39 -0700 (PDT)
Message-ID: <1736066d-b50e-4b3c-9db7-5752927978a5@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 12:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: mahua: Support GPU and GMU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8KFC_mYymYb5OqiYGwfDX8H97BdKBESx
X-Proofpoint-ORIG-GUID: 8KFC_mYymYb5OqiYGwfDX8H97BdKBESx
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab64abd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MSBTYWx0ZWRfXyg1dNGLZq/AC
 rAI8T/ny9d1H6lYPiYK/aZ9+Gld/mac18vDKTZll/xS+Av59EMpppmF3INCgQlPtRPAmh+nsEvs
 KCj9y8BtRny3wT+8FxEsKb2t3AUf0V38O/bEUIV967AhG7gFAEOY8LDyWMpp8pec1Ag0tLuZZGY
 3Pwgk7za/EYfh6gQUICsb0UbeeYDXp2uKxpLHAhXKU4e4rlFshvNyOs2mKum7PRW5I6Yqy7ytc3
 tcoS7jVyOFaV9Q5Q8eidsg6deqbE/1xzojKUUXpgJjz/DJJF/bZgEaDyHMLFaaSbai0RYiJXp+u
 L2SV3uLo0azxNHzCdoIFvEUBkj1eIjz57chdyIZviFi1l60bFrASZNUaOlevW0EB8XZVGh9Z5VJ
 fcQoRxdUhW8w08s76hsdn2MaCjKnHOhwrzlkQdW70vJFegPYX6x6TFPUecDMbljJBuHmzK1nj8N
 WJdC4cUISYG4Nx7Qocw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MSBTYWx0ZWRfX/ULrH2uS9p/d
 0o6bxn4Fwkytf9uUFsSEI8t0N02Yg/860b1v9006uy346Urrp1cBZxeWJRhOdsmXutg1+hrhz7y
 qSvCggngJbzbyC8qDbcv8Awrg4Hn8Y8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250041
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

On 9/24/26 11:14 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Mahua SoC has a new GPU called Adreno X2-85, a slightly smaller variant
> of the Adreno X2-90 found on glymur. Override the compatible strings to
> correctly support it's GPU and GMU.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
