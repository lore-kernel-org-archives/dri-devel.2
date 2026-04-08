Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20CFFD5F8F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069C210E41C;
	Wed,  8 Apr 2026 07:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxWrO6rl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jU2Eqm0a";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C154D10E41C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:26:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63879LlZ2861188
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 07:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 11H98f1tYHIJpO6RDSqhNnaFKcnwdWAOjgMNXJCTo68=; b=DxWrO6rlXv/xzJmY
 PuJypwdfwep3auuCEBuDudk9VTN1ivnHRmd6ih3uO+QWRP5ksr1+N2jE2o+BDT34
 lljlj6cVRiAPVOPBulvVDDViZd7Eo9vPeGmpQP/zeG0jGDIhppWuR2bgOBAiCILR
 ZyNDF6EAwt8n5I4wUK+HRbM/KXGFEVhWhUmJ2eG0pVPRNAWyBMXIhF7gDlzxj8q0
 /GoNnZHNHs83F+GE4cuojKTGouI0YbaMKN7WfcgiIaksaUwO8lQ1g02YMKFIpN1g
 aw8sGl3pztCYv29nY5rcrQ1L8/GhNBeuxyajHRi2B01qdi4Quk9xzM1eJg5vGQfB
 MrWKjg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddad8shpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 07:26:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24308165dso148414045ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775633169; x=1776237969;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=11H98f1tYHIJpO6RDSqhNnaFKcnwdWAOjgMNXJCTo68=;
 b=jU2Eqm0aouG7zuVkFYaggeWxJgMLLqk7m6SzxzZkTlLMqpeFDob/JfGdsoUrn+CRdw
 f1x1Q8esfEPojBPia9MnLPhF841vaObHHVvKFF/aEigiUZN/5Dm74yKPk1neL/ccGqyP
 vattpON4c3Fdb0XO3TtJ4QF2bxh/wUs0MtNTSNYjlPQpiiDRvTR0B9xmHCFmEbFnPDZB
 4tj0TzDwyCc1fMHF/LOMxo/nJz8OSRGS4ESWa1mndPIZCteoP/b/tbBZ4yKoDUPQAXAo
 3mo4U3HELGsMebkPf6KqfAKC3fbZICms/iSyX0WcAV2HI+Vq397FQQ2yF0QMIGH4ZZ2h
 Q1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775633169; x=1776237969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11H98f1tYHIJpO6RDSqhNnaFKcnwdWAOjgMNXJCTo68=;
 b=XdvjDtNtRHDdjoxCaTfKrwTa1Xb5S1At6RZXwTc9gL0qWsDqUPC533VNdwf5VdOMjX
 9OtkPm6C/MQ0M0PGhfMeeApRGHbxR3/VZIGMEXhrmaALlqrkVpldm0XEKgz70hQaPdRR
 k5VxLPKP8ZH/hgltx7i6ttdbg+F1Zv+7eMd9cYKikWo1Laz7UcisRKLNQVWb3dbiUqpY
 sR/oDP2vTKK9vYqW13pUAZTnU/nebLysmnSMvojmL58KcQ3dVN5c/8ej7UhSoAngiUmu
 yxwhqaMONyj+E423IwLJybcXW1wqtBggZZMc92d7KrhlVC+TB+Gibf7wuAMbQNBq39LB
 za9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFhei5gA9pMQ8w3Rc7ByX53bNsU0vm1NQwRt4XLSwGTU7/+us/Zl7CSLTQ+13XYje+xYQRZI8fDhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysPMf+peaApBqR5xrHRS4A5XGMKjV/zK2W17TuH4KpxKMUZw4o
 93uflRbtlphmWrwzg61Wnic2nklO/6sqfubOMDyVc8e8FzvizEpZkp4vsZ7/OYayfYDpXmO1DbV
 IpNaYTLYkf5C7Ml3zSC28e3w8GhbbYX2gsOdjWJ12YNRxJ91pCoE3QeIoFRYOi9H+rWEZ12w=
X-Gm-Gg: AeBDiesobKATChTivk08AHrlo2s00AFFY8pDIhqUwNeXk/XyIeBTDF7HMi34cfuclrx
 G+d2i2u1HsiQSIqxw3uVa7oVaelQchq0WQ3j8g0IwtrJsyV4CtqEOuCF9Dztbbo7w3j7UGiSk9y
 0rx+I9ZlTRtTGcpyGIkbCSEgr9rfcIkl3+BjJlh5TMLk3a6XccMaJolWRWrXk6ybK/Kbzp7zaLW
 c1c5+B84c9kLjlBm4jQKq1UaruF+h88m+sDCfUwHwTbkoxYODIR3J4kvZetKYjmXiKvHPe1+RFF
 u9pD+t4H1R6800pEmEF1Z6pd03OKwLo14jhqz7AmTS1dEMgpMA5545EDPNnzMK55V7Il05poY2T
 POIwMXNhvVpo6VBaEl3grVDpCmrwzL4SbvFhWY9zLLEEPjlfmQg==
X-Received: by 2002:a17:903:2c05:b0:2ae:7ed6:46e3 with SMTP id
 d9443c01a7336-2b2818016dbmr223333185ad.27.1775633168695; 
 Wed, 08 Apr 2026 00:26:08 -0700 (PDT)
X-Received: by 2002:a17:903:2c05:b0:2ae:7ed6:46e3 with SMTP id
 d9443c01a7336-2b2818016dbmr223332875ad.27.1775633168219; 
 Wed, 08 Apr 2026 00:26:08 -0700 (PDT)
Received: from [10.217.217.198] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a4791sm192337875ad.66.2026.04.08.00.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 00:26:07 -0700 (PDT)
Message-ID: <a573a9cc-7426-4d80-ac9f-e084e72207b2@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 12:55:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: qcom: gxclkctl: Remove GX/GMxC rail votes to
 align with IFPC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-4-4bb5583a5054@oss.qualcomm.com>
 <73196147-0133-4646-927d-dbe93c254286@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <73196147-0133-4646-927d-dbe93c254286@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wvCpmBLLDY7iac-ZUD2JLsnVDwVGQmZl
X-Proofpoint-GUID: wvCpmBLLDY7iac-ZUD2JLsnVDwVGQmZl
X-Authority-Analysis: v=2.4 cv=EoDiaycA c=1 sm=1 tr=0 ts=69d60311 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=lwYRxUUayc8gUbovT3YA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2NiBTYWx0ZWRfX2RZZzQpiaKDX
 BTG+yVVeloeIUJ05Jm4NJHTXOadCwyc7VamCVTx/HGh+0mNNjLgEFrBXwiYK6OU2YsORkdfCIUc
 cNGxOs1Tk5lCFitt7YH3Nm/y4VmbC4htgQEs1fITBLLhbaNoAKCb21kIbOnmZNn5lQjl2mHp5Iw
 pQVZFJVQ0Pz6LccKd40h7YsbRqQWRJt2LEOldr0v18bh3WQRhFP320aaAw/+9fl3pdTFcLLDkMD
 ylSLpBW4Z/SFpJ9WwYpqZA1RJLEdO1MAbV7X2zDxbgo5D5gdAaYj6j93alpewL70uAVaRRMC8MY
 sIA5Rmh4bVEtQ/AAHvDL+Jl2ij8hPyxeClgPoyqb1xuod/DYMm40+U7gDWV7yTsOmZJPnxDvWrz
 385kywzpwtIzIJjZJ0RU+Qj0YYOKDXTs9y5H2mCwKktdJhZ8MwZAAvF2H5lym6lQQI0LwUjKZes
 byaETaN3UQs/0hmkEsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080066
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



On 4/7/2026 4:59 PM, Konrad Dybcio wrote:
>> 
>> #include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h> @@ -61,7
>> +62,15 @@ MODULE_DEVICE_TABLE(of,
>> gx_clkctl_kaanapali_match_table);
>> 
>> static int gx_clkctl_kaanapali_probe(struct platform_device *pdev) 
>> { -	return qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc); +	int
>> ret; + +	ret = qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc); +
>> if (ret) +		return ret; + +	pm_runtime_disable(&pdev->dev);
> My understanding is that this works because we have more than one
> domain associated with the nod (so the generic code that would
> otherwise enable a single one so long as the device is resumed
> doesn't apply) and your previous patch ensures that after probe, the
> clock controller is being put to sleep, right before
> pm_runtime_disable() executes.

Konrad, by disabling runtime_pm will ensure that when GMU is moved to
runtime active the clock controller is not runtime resumed, which would
prevent the votes on the rails as per IFPC expectations.

-- 
Thanks,
Taniya Das

