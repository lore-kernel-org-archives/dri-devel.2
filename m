Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974F606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0saIndc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fOGDRAFf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DC810ED97;
	Mon,  2 Nov 2026 12:39:30 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA9510ED97
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 12:39:19 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AOUh2880892
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 12:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=; b=o0saIndcVHp8vZ6f
 CZ2rkVhjH6ouSd/s4V58y71yXm80mPHeAGEZO+CC0GP+LnpJ9lCUFhD7KjU0mpol
 LhVJHiTkF72NE9l1LmUq3b+c80HrkvP15aK90GU2lJB/zwQOfZqylENqYUtyeX3T
 AU2f5gRStFfAqYDzzvyjk7lLa8GfK7f1LNdcYXLNO11BPKqQtLcgkmyZ8Xpsixgn
 g37lQ3M1AHJJonE/at+vRCNLpPUe0IyzOUE1/wTnknCOiKOrUGj9i/319/V2CvHM
 KJxzu1UhoCsqrbX7DDFAWEqBWoRlU9cGIIM+8f3H1kFlqq0kV5l1Wqm0ffwKkjQG
 GNbzDg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrgud9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 12:39:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5350173dc7aso7934761cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793623158; x=1794227958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
 b=fOGDRAFfXsgJQjbeam94eSKINrjT8Zj9kwtrhmIH/lx2b5IbA1tO5iltMPeTYTAU8g
 fFjilvio8xVyri9AwdzrSUZ9XpLPlB1A6yE7xHdaEfkERwNd9hytBL+DhfSDsG0JbHR9
 xm33fBjPCNVGCQDRHVZUCXGb7Bhm+JdrEM/Be9Kkg7uREdfUl7HIJEr184YW7uTA/qrt
 JfXQP9tYHkxrD1m4Pa9eSzBZUluOqxLaKmCr1+vgzIrBDCtUCH7zuuv44Z468bTT8Sfj
 nGd+pKhf36siEA4R3H3MitePMzD6OouoSsHfnceiDH8JGJgZIhGlxnlN41YxO3tmFCGn
 d2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793623158; x=1794227958;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aGDvSGUaUelkvgdt8SNqfNdrDK9ovbfPV8d3W40UaUs=;
 b=ynRARsRjMjasNwTpjd+DHD4RsunosOTUeeH7lk/2gatXeu11ueJDrI2xJ8E646WORj
 DhHVkqIUBnHPc/hvrIcL2QJvQ70SN69MxTM+mYqO0jX+eSmLEMqG/kCDnTcyS5ly3cJY
 HGEvckCiPpwRzed68iyzxF8vjCDKwW0H/fC57NqgaQTujc1ebhkE6bdJc0J+KKDGqxRx
 Zgq4B+M5+thuySNJG+NYfRZAWGrPKkEE2LiKKAAbYr9eZR7HAn+jPN51V2nyfaRkLw3o
 X4OFJ9YJaMP6XYzovv+u/XKRjR5i3JPjDlc14NC3lzFaFXZFp1N029ibqmRXMV8ee+0U
 vwOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/H9Opmdn+TL1ZzS1Dy0ErDI+Icr2CET2T9/BgM8u0snU6WKrc9GXBP2HNKk2YL+zuEZEy+x5rwTc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKc/e47FcMmi58L9++Bjnu59l+b2dAAbSO91aAIO+KfTvGZSFKr
 +oF4MEVHORFaBCkZ8jIz/hIbh+oZ50gWFaSW9E8QjT+l7igBebCGnqOMJKX/KNnUA8x2287BrMR
 KUqReTBveMiucexMbK2/GtWWMTxTfDyKx+UNg795jNGAR2ryyemi7bguSCnM1RkRqwExcGtI=
X-Gm-Gg: AYBFou04YzQ0pCQ+1R1Lzt5z4bKfJinU0hBW5hzK4MmNs305zBs6XCfhRLb/pBw5NwW
 V30f5Z1Cq5HxbazENK3FZC9fytbW2v96lW4O8+UIO4LT2xQxcsPgvA3rBUeNB+jGQYE8pxldqW/
 Dw8ZSYVkc1KlAMQdPtZ66hYO9vttV0KlMZuwC/l4IuDkeUZbHup7tWK8h5pYlIJQD3XvP0lGHwT
 VRMt6qh8njvehDk76rAVe/WHsdjt0cru7jKzdhT1DR7MfdkWmijHu9kGOq4S02c78nPMt6eVUtH
 3UCy8FKB/CuZvqO3tEf1CMiFu0mb28yP/wBnqKATGNLmJ2m1qJcNfQ4KLZuPFjyC/pbInmCHOOx
 ECGSQ98T74+ZXEIvUlgvD1EpdT09pZ8b4d81H4tIDV0jkI82IfVjoMRQTWaI8qdmSGlu0vIY=
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr1815614985a.3.1793623157918; 
 Mon, 02 Nov 2026 04:39:17 -0800 (PST)
X-Received: by 2002:a05:620a:6357:b0:93e:6d87:4f69 with SMTP id
 af79cd13be357-94421666fadmr1815607285a.3.1793623157435; 
 Mon, 02 Nov 2026 04:39:17 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acbbebddacsm23222831fa.6.2026.11.02.04.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 04:39:16 -0800 (PST)
Message-ID: <ee443167-963f-4a12-a49d-0b4523afc14f@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:39:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] arm64: dts: qcom: Add initial support for MSM8952
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>,
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-9-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae88476 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=OuZLqq7tAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: 9Bclu5pfFZDI_hwNkk3ssKmmjyyWpYZM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX32X0z4pzpvbg
 s6ZQcNlFU5wNleRugV3AA2rp14u4m+mHmw3EeqnpYztol9rK3zIInrRnpitH6F8A39o7SVqIMcd
 xNJOGILPjnRPraYENcA8v+JZDP6megU=
X-Proofpoint-ORIG-GUID: 9Bclu5pfFZDI_hwNkk3ssKmmjyyWpYZM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX22OoWyWa2bId
 WgVAQZTNr8E8oKAD6YryQEBMfupn6OlMbRYtLgqJmY26bz7BMlCUZx3X0FwjnSEGN8EwHgnhpaz
 BNIdMtLWV1jKKvaHQ6RFUbmAzgJy59Dmg5f/vt73D94JWEhdUp9W1EhgIlz+C9kQAvsV4QPJlhm
 KtryeYfUT6WAmeuwsXDl9AlmQEMeqULJRhYgXjay3MTQv/+KHmx554h4A5qDnC0JjNVeFW/rfDQ
 +MprnQB+VyPe5FQccgUkyp0YgKTLEOPFdGQ1xWYCoYw2yYDI6AGeBZ7Ap6Wwsksxne/RieW0Z8z
 7PjJJ+wMwGnDhNBrm07xmxbETII2y1W4nGBHan6h1fZjhBKTLEOyqycDIOYmt3SsaD/+SdiunYT
 45pOQ9/fgZDJS7sJ4nxILEyBeGzfHhkQQzosj5g5dk8E5vqZzZW8MGEuv2TK/Cw2XDmE4AuYBNj
 mlFnveluy+LBaYwQc/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020050
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add initial support for MSM8952 SoC.

[...]


> +		gpu_iommu: iommu@1f08000 {
> +			compatible = "qcom,msm8952-iommu",
> +				     "qcom,msm-iommu-v2";
> +			ranges = <0 0x01f08000 0x10000>;
> +
> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +				 <&gcc GCC_GFX_TCU_CLK>;
> +			clock-names = "iface",
> +				      "bus";

The robot suggests this is missing the TBU clock (and also
sister iommus)

Konrad
