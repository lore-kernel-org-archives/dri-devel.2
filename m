Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA5FFF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFCAE10E0AA;
	Tue,  7 Apr 2026 19:16:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GX1jWm1A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NKAK2YD/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60E510E040
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 19:16:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637DRXL81405882
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BvnMmdo4Wei5AuJO4jFfKnRL9Ab9uaFew2yOkjgAHXY=; b=GX1jWm1A22dLBEHn
 LbDMrxMuxB0ntj5CLmZzrttGhhPdimmav09K5d3WLx6I1jc5SsU1e/Mj8SJ/cqlC
 IXHLFg3bR+82fu/aDC9nVV2qHvWIZcw9leEQHv9gxEJPKBIa5GZ2Xh8biSoFiL/L
 K4GFpIxUceDEy3gn7nvoOvaIOPqeU0CqIhVoydn7RNAqkSBUqDi3eP4/Xoo7dcgW
 bVOeF3HGflNuvWPGw0lN7cTOUeG5q2KQ9d7ioZjb6vrRC7IKHF2E225eFPd8sQh7
 igpHlZaPg99KFP8pFwci2VV+cnAbtvmxA1xyaoTaBrQH7SKj5oAdP5TSI15RCkpn
 szpVPQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrav9gs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 19:16:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82c9364612fso7836529b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775589400; x=1776194200;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BvnMmdo4Wei5AuJO4jFfKnRL9Ab9uaFew2yOkjgAHXY=;
 b=NKAK2YD/vBzRmRUTmx3pEQE9vEBWvSpIfgRC1ZRN5ostECjmTXKvHj48+Yu9Q1orLV
 xOqsG7q4cSOiR2+Xmnsh1cKHJMxrd/rMUs6Q4/aVBjiOFrw2jE5EEbyP5YbGpSWOgyUt
 HKvOHfWoO4vSq65Cy/3s04Keaepjix+GSSJ4DkLRc0EUltoPtP0Ii+Js7e1ujLT3QJwV
 hWgCQck6RsgXc5Rt96146wueLgeHCPtqJWu9N42r/hGHvU4RQBDzBZsKDWURWOIwSOpb
 sCMXquCg7AYMtbIR+48E8HukIcs5P5R3dT+83RGGILkEfxo6ZuEuGpNoWQuegbj42hq7
 Sk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589400; x=1776194200;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvnMmdo4Wei5AuJO4jFfKnRL9Ab9uaFew2yOkjgAHXY=;
 b=Q5KiAXWTffMP67GvcuZLVyVGWCDPtPjxvORGkXPkIhxgY8cfJsVjwzXehr2krmnZUK
 tlmmg8nuDRKNFCmtlQjGzAxa1lmFlrjE0WviX/fj4EkLjAzorofRP/SAPtaYiJ8OURmY
 DSsT08QRPOuoznl7dGiuXJInQHNz/Sk+5BRMO+PT+jKK2YnRYUS0SEycBm1LgEoh9uLs
 lutVnb0W1ikM1PDjikiVm9JvEUIXx822vRmsfFYxxm9EtaC0qHQBU61RdJWAe0C2WoJx
 uMTnGs5dBIV4shxrfOi34L67soUvp+CPnDJ6bNwKmFx3YpRpvYV5dzyBxIpnkGpNz4xo
 Ovhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCcWea539SwTzSpcm2BV7B8OEgH8yicpL9SzqYUxtNZ70vN/KZjKRMnv+/weDii4jooDmsHXMtac0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJCL2dUazjddeKqckzYaMZmw5rirFvpZx8LJ7aJTTUsFYUv/nE
 UbytP9iKqPRRb5+7Ymh+Hktq9jiHOxj0yCmV8tTNZlpBuQ7wp++cXPt0lKg0r3h9Q2vDn+sD4N+
 It3JPoD4U3izX4cnyQsJmjfYC7AbDKD17XWX6E4mP5NEZLI5oqdsZ5JJTtNW870q8cja6UTo=
X-Gm-Gg: AeBDiet1W4WSDGyeWg04cE4f0jexR7bSw87VHvC9o6FBk67yVCz1ljdovYH9p+a7Hgk
 s/R5rYd2/w1hy3xhhlQLkAkgVWcYYFGATvks4lhdY0yFDeE78ASxFP00e+l9CjT5ONrLHoL5nrT
 WXBMjpS/E/IVCEJc8NUopsuu/DRHMi1xPvbhvMxSEPS+J/EBNyyPmXYUEv78lYwIcOwrsj1/DXS
 fLowHDiDifljeaMapz1JxEB8rJBYO6YYAHNoY3uDyAzaxgtjtiCbAHL34Xuz8+kBBashZeqKQjp
 AG/oYxCHNnZVD+57bQxtbG5kz/MxpQMhtvTX+91bX1CVHfyWBz0r/M3oYWR5pkC9oDpM1Sfvfhr
 YHQEQbqDXf0Am/Vf0Yrxr9IsHzuyz+aGW0RlGrpvVhKzwlg==
X-Received: by 2002:a05:6a00:b53:b0:829:793f:da6c with SMTP id
 d2e1a72fcca58-82d0db88417mr17663427b3a.39.1775589400503; 
 Tue, 07 Apr 2026 12:16:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:b53:b0:829:793f:da6c with SMTP id
 d2e1a72fcca58-82d0db88417mr17663393b3a.39.1775589399957; 
 Tue, 07 Apr 2026 12:16:39 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c41a2asm19340341b3a.37.2026.04.07.12.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:16:39 -0700 (PDT)
Message-ID: <df708bd9-466a-4526-ba74-548896b45e74@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 00:46:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/msm/a6xx: Limit GXPD votes to recovery in A8x
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-6-4bb5583a5054@oss.qualcomm.com>
 <8f5ffecc-007e-4a8a-9c5e-9994e7841659@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8f5ffecc-007e-4a8a-9c5e-9994e7841659@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2GR69bUmXrUeVmaaMLW9VkUfN3EHaToE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE3NSBTYWx0ZWRfXzAmO24iasOwA
 y0BB/qDOx+ALPFCkvmy5oEmIrvl+BS2Qbq+b7CrEgmsKvxKJN/PDbhHj7Y566M095Z/lfOWRx8e
 PF9pYvR34QYP+AbFC04mra+xR/yd3AO4HCqXzyhq79V9I2vyIpYJzBZC1lJvzMOUMjeALXNsiCO
 X0bpiVtGvMRtYl4SbmIjQCEv088vdQBIJ6/zNxzFUZZowW9p7ztFK23nqwtW6C5tczXIfyAaabY
 3kjyOnmm+WHE01bVkbxROuYDkF3fw/KR8cU6S1HD/9KqVrYt+0JUzLWdCWStPWI4uuor3i3qeSc
 3x16DEjBN8eHMZSWvXk12DFQcjEiYSk3IOmdeNamCc6dfqkY0eltuF8DyvPSGYoQwZf/Buy+LeX
 rNGzxbIOlgd/l/8pgnlh3v5CyASWrn5aV1P13ppVo6IKaeKBid90gGiSlXhAxLdtxgCXwpUdOAF
 RiIEGjwXHH8o5SnRWYQ==
X-Proofpoint-GUID: 2GR69bUmXrUeVmaaMLW9VkUfN3EHaToE
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d55819 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KZt6Vqo0b7mNqYgsowAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070175
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

On 4/7/2026 4:31 PM, Konrad Dybcio wrote:
> On 4/7/26 11:30 AM, Taniya Das wrote:
>> From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>
>> In A8x GPUs, the GX GDSC is moved to a separate block called GXCLKCTL
>> which is under the GX power domain. Due to the way the support for this
>> block is implemented in its driver, pm_runtime votes result in a vote on
>> GX/GMxC/MxC rails from the APPS RSC. This is against the Adreno
>> architecture which require GMU to be the sole voter of these collapsible
>> rails on behalf of GPU, except during the GPU/GMU recovery.
>>
>> To align with this architectural requirement and to realize the power
>> benefits of the IFPC feature, remove the GXPD votes during gmu resume
>> and suspend. And during the recovery sequence, enable/disable the GXPD
>> along with the 'synced_poweroff' genpd hint to force collapse this GDSC.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
> 
> Can we simply make this change unconditional on the gen, so as not to
> maintain 2 separate code paths that try to achieve mostly the same thing?

We can skip the gdsc vote on A8x because the 'gdsc disable' callback is
dummy when the synced_poweroff hint is not set. Otherwise, gdsc may get
disabled during system resume while GMU assumes the ownership. Taniya
touched upon this point in the cover letter:

"""
when GX GDSC is managed through the generic GenPD runtime PM
framework, it can be unintentionally disabled by the OS during system
resume (resume_noirq/complete phases) or runtime PM suspend paths.
"""

-Akhil.

> 
> Konrad

