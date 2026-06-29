Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1387C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC5010E0DE;
	Mon, 29 Jun 2026 18:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LPCtJUpy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7q6cl8v";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBF610E0DE
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 18:40:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TGKGR03388608
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 18:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CffFp0WhGRj+vqvsuwqU3TnnmViodZOWqRxtTaxYu+Y=; b=LPCtJUpylBlNWhDv
 0fxXRaARpZMPwhKF2iYU4JQJPrVJ4CHxfUSHbsGlRYH7GA8iUEc/OPHgQYnHK1fh
 6RLWWHzuDVzHZ7KFJNM8LqB6jiZm89AdLX85iQTgaCdin098Q4mfyUcJPxUuFPl3
 aSajWkgso+hCNB2cZvPakgLxy+VsKmVM1Zz0X7de3gAyD/H3UiQ+sJi4BY/5Fznb
 VcIHb6dtwr3PAdWbWjraUV704k1U5tGziQrbzycM7GloVacTvb2KplJAB9EiHT+O
 ij+6fqEX8nmmDpiFssuBthRdCrTZDcq6wGCozkeIBPl4NLFanW/DczUgf/oAfqdf
 DGm80A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vkbj8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 18:40:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30cb5001ed8so3549800eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782758419; x=1783363219;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CffFp0WhGRj+vqvsuwqU3TnnmViodZOWqRxtTaxYu+Y=;
 b=c7q6cl8vA9NDY4mAbz6RIUNV02KMRfpHK11lhrWMHgIFmoescSFiSVNPiJjSpgs+Hl
 PX4A/OBCQVq2N0vS/PD73L2XkiZuP/jvv+QQZP+8LtdG5zjgsUmLGRbzzvC9TwUOMLDS
 vu+zQ33cgOpCDWlL7s3tpbxs69Gygl6EbOeuAJLyWVRAsrKypGQor0ZsQWC0Xj12AYLH
 dD9k5HR/ZH1R7HHlrADPqpvR3ZZyGhV7TTWP0akL1OwXtK8WNs329ijh0TABVZ7TeqkT
 MDvy8jQ6Vppxtd+Fj5/+g/e/6fGiajasAJjHtPEqsrtJxHAE2Cevmy1WJwD8at0nM7tY
 I1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782758419; x=1783363219;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CffFp0WhGRj+vqvsuwqU3TnnmViodZOWqRxtTaxYu+Y=;
 b=a7cYu7eP2gjrmlkSP0mTUI7ZPxYflW3xpCIvvgdAyiXsCjj3xSS+S37WJAHfRSQvVo
 VC2htFoP48UEd6V6xqphUAy89G3OCjj0uqMUVYauE7mmIYFB+IVfbqb5Ba8FtycyBItk
 QkvXTLj3v0h8+dqRPRmFVNg4ufpgCBUlf5nq1xlSBzt+bYm4yFQsgkwFFhpLG7h+j1ew
 R/gJLsT5UFrm6Tp9Z8EFb86upFEJJIM6vgnVfG5Htn7amcMKmryAxsuRp02HTlx2Kssb
 sGhkc+wn+6mkShc3cY4WvdYl6EKHtEmBQeTFBiot5IlocGYuxIFDMwoAWfqq/4nj5TvX
 x4lg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgghBTYAdh2e5I4LAOhCFXtUBVBALbnOj5PGE+xtEpdLYVYDRTs7eKBaLkaJUe6o1NdWEx4gjiCoQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzEw+KBWb8XnlumHSq5+7SiogqQBuE39A/UC8knxpLKOoIK7zs
 erASuqDBy/x5lVPgRn5jrKkP1QPjgptcTs5H5pQlQ43WA3GeFzgTCIi6UQWNCsbHBvNMF10mn1s
 I5CpdpDzavFRb2aufQ8CbxDVfovhbevldBKsFvEPqY8m8p+THflfppolhX7HgcFW38mHbHHc=
X-Gm-Gg: AfdE7cmd+Zm1JwxNKXwet8ORG+qw9ooS/qEam7vY0GRTfjC34dBgjVj0ztLbAmoG43a
 u16AngtjmcprFmVGTPW7EzfSkWFXLxs6qBhS6YvNpCKp7Ns0KEnS0d35S9xh3hgnV7JDUJUmcLg
 zd3mvel4JS0i79rgatk8oleSiMA/HtjzTAiX1n8iCcYn6lDFs/Cf2Y9AXICCKNa42AxIjOP7B+x
 qxjvNw7DHsrNWJKgERpZOESHRs0rJZOYqwWhc8lK28TkrZEemt3k1FlfHptgMlG5j0+LuKiRZJ4
 75v81E/6a2aZcYJ+RG7EihuZQtkz9JcF3WwXRGWr7sPVIMMApsinfB3qLTcMfe7u2nz8fubgMEj
 4PXMLNYigxxFWeC9xLAo6ifEHBSvulVh6Fw==
X-Received: by 2002:a05:7301:6190:20b0:30c:116b:42a9 with SMTP id
 5a478bee46e88-30ee1489a13mr269178eec.26.1782758419315; 
 Mon, 29 Jun 2026 11:40:19 -0700 (PDT)
X-Received: by 2002:a05:7301:6190:20b0:30c:116b:42a9 with SMTP id
 5a478bee46e88-30ee1489a13mr269143eec.26.1782758418783; 
 Mon, 29 Jun 2026 11:40:18 -0700 (PDT)
Received: from [10.91.118.212] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee316bf4dsm128143eec.17.2026.06.29.11.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 11:40:18 -0700 (PDT)
Message-ID: <4e438b43-33d2-4cde-a5a6-67e7f8c53787@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 00:10:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
 <3ac0279b-105c-403a-90e8-822c28a6dcfc@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3ac0279b-105c-403a-90e8-822c28a6dcfc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: epUx3LM1ODsV_1J-wE2UiegiElBqAp6z
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a42bc14 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=l0uZIx2wMuzZ-h4bkHoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE1NiBTYWx0ZWRfX76QNb1+VEgaw
 Hh9ot3yJiBsEOt4iR30UC4KgIxgdKSDTARTvKVbH+AaByOFpdYqG2Li2gjE5mItDn8ZuduTglPc
 2Y2GIPXKCSu52Wb+7GLJfIRpeTTyYHU=
X-Proofpoint-ORIG-GUID: epUx3LM1ODsV_1J-wE2UiegiElBqAp6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE1NiBTYWx0ZWRfX2pvH7LcUdYnA
 ftlA6BXJjXori+9BfdpP9AWpcATb0fNt866Xv+PL59O3ZTn03/NI12KOe5r4xo31SMasY2PdorH
 v7YMJ7IoujAujnNe2nJlL9uIAoNeJw/dGshGNIpNHejRQDRBGdDxpXwOaLW4fP2zYw26SfOG2Vz
 l5G47h7b5FSnABN8w/XL5lW1xkfZiq3cTJkJxU7ji04MqaKbLrUcFRNQumo6LHo1fCMxroj38Xa
 +d9VfTmW5ntkmgs6h1KsRo6zo2G09DvfyLLIWt9HiPCrgfM/iaSkOSJJONHrL3TfP6MXGQ6nHkH
 IGgYJ6VDldKH35EV8ho0BWKF6wWSNNNCyUw6t7s2LYaKhYnvfzsMg/nL50QPsESWEEEB94EETVX
 nSHitQGqUdi8l/m4NvzJ4qZkM6O/9Jsv3nxxD8Kf0KBylZ31O5QiQB30G8gBoOhLyyp9qH7Hwvm
 YJPS6KHf0gqb9Sk89dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290156
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

On 6/29/2026 2:16 PM, Konrad Dybcio wrote:
> On 6/28/26 8:23 PM, Akhil P Oommen wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> 
> Drop the sign-offs that don't apply (presumably applied as part
> of shuffling around the handlers of the patch in the in-flight
> tree OR missing c-d-b)

Ack. Thanks.

-Akhil.

> 
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

