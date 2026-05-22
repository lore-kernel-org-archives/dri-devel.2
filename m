Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3F0CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9EE10E28A;
	Fri, 22 May 2026 14:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i53jBIPC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVhgCcul";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D158810E28A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:21:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8auAo399343
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b9j+7eXCckmlcKUILjcOcoFvG2Vudf6r9KN2UMOzISo=; b=i53jBIPC/i0fJ+XE
 U31AvAFJK00Aw55SLFDhZpf9lvBlALSDqdHh83+TDNR4hZ9LMb4r6C5pvR3RF6sc
 tz+1NaA9oVMMfS2OE74RLPcfsTrOc+/HAHZfoEa9fToc+kkNpA+x94/S9Gn0hDCS
 GYa9PIdAmiM/jSqOm7/gjriNvVSLCf7fcILcUCrOgw0ks5dh7mQQBUpHLXTPAfzk
 0BygaLwdAcCIgymhEwPdYoli/ZQs7HGFxDmti17UqaVPnSOk6gh3deoEljrMKkim
 M+E9DVkYdXwhbXglNrn4dCnB0LTroG6qq5SSKRePg+jTBKw58ePQxP/rssPTbKkO
 8z4+MQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9vp1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:21:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-365e70c39d0so7079043a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779459684; x=1780064484;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9j+7eXCckmlcKUILjcOcoFvG2Vudf6r9KN2UMOzISo=;
 b=WVhgCculeWSMw3xAoGCHcjOXRDXv4mIe94nfe7bkaodSQQbyq0Y15VaTwkjZAelJpG
 wBbyhSJ2N3D54FP9ImeD0zTxLjcvljzfS6BttRa1fKhb4w0RV9whE/U3rLxTl1T7iDCs
 WYvA6eoxNB1Lm7S4CBTeyK3aeozZRV6tIwQwomeLwu0VT2w43S0KjB1udAsYm/NGSeXE
 EkVOD3WE58H+xWvOhy1l1T1FdV5nBqDPYTpbhE0H79XU/CT8AQ+OwXEMLaCWohrPQcMT
 9xL3G/ljbddNmphMX265AyPIhBHAiawFQ8qDY2DObXOc7RYoI09IY1nbFwYutmShcmur
 6knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779459684; x=1780064484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9j+7eXCckmlcKUILjcOcoFvG2Vudf6r9KN2UMOzISo=;
 b=hWafLJOLGZx71MGWrnv302LePwNZVeMGDucPZJp1dtcqSdQfeCzbNRrpGJJuVLqeH6
 5JhzKQzD9+GGn+QQwODHCfjOzUnJP3PmcvoZ9dzlyMn55iqLDj/swF6NgYkXrrA1bZXr
 /R/Un/TyG+2qPPOWuHwMolxiP5T0InXPCSi/VLMbZsPqAjonrNtSg3KM+40ndNW7WhIy
 pPIVuBBvI9MD5s+K5Z5eSXDAuKF/hTKeL4qPE7spzsd/V5J3vwuGtPicXgmf9v3+EAeN
 Hxy4V4ex4Zjk/mqi1IrAtINJBPhqWO/k+TwBnTLoVchztEaRjAi0+29ZR34EthIGMTSY
 CrBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QGuEEPXy/dU6b8rr/+KLUFbBLCR/6FppleXxszmGOl2wyivpoDMg9oMPE72hAxDfbopBBcaCig+Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKUAg0LX6CoKwdAxa84AbDcld4oSi7C+zw9qNALsUQUyDllgKy
 Cy/pN7MLneTCv5bKop0w2+mvluavqE00UXq8W9cMaDwXzt9XCGaXUzhfRecYbydxnMPh4Y9PXhG
 E5p8zy4LAavqXWYmBHa+95bMuQBLMden4bRxs3UaEQTRWwjPwxRAcOVORP8Lg/weHLawqg1U=
X-Gm-Gg: Acq92OEOKEt/1B+Y5Bm76/76sbaaxGgyl3WIaK2VgJ+e6xNPCiH1MSPC1okKk8OLqgR
 7iz1SopLESqqfE6+TRKnxzp+gJJmc66sePasyg5nmVIWE4APsXyukDtBb9+C9keXv/ZtrWfEpfh
 Dsb/AlMwTxo27q5n872S6bHKLOVQrfvS+4eP6ZpQVuBvoK0UmWD3ITFr5vnCl68lRea61pRuWzb
 x8wqhD6liz8uYeETAXeEWPJ23KfChPQ3rR36YdKSqVKi32Jr1oA4mzk3fxkUwzu5Zc4pVCLWfoi
 pZ68CIhTMXh6q8MnnN14Xxj1PMfybGuFF7Dr2YeEDtif/ZZ5YDZL7WxPIpVqr5msG7L9x3eH/hc
 VuOZsvunKPUp7uhv+KYDSeu8Gagjo37Bm4/GDfF9bcS/PK++7xGw9
X-Received: by 2002:a17:90b:5343:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-36a671e98dcmr3494377a91.0.1779459684538; 
 Fri, 22 May 2026 07:21:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5343:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-36a671e98dcmr3494333a91.0.1779459683996; 
 Fri, 22 May 2026 07:21:23 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.231.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6f0baca7sm1350671a91.2.2026.05.22.07.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 07:21:23 -0700 (PDT)
Message-ID: <8da827fa-bc60-4086-a424-5ec376f15e27@oss.qualcomm.com>
Date: Fri, 22 May 2026 19:51:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
 <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
 <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
 <vjdz65uy4pxlbt2e4wlwvdu5llwazyopeqb3caswvejenm5iv7@3s3p7iz4otef>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <vjdz65uy4pxlbt2e4wlwvdu5llwazyopeqb3caswvejenm5iv7@3s3p7iz4otef>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a106665 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JaHktJlP2QtFIg7UHuVw+g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=rjDOXfNolGiz0B_7zKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 4EyU5hS4oX6jt6ef2SgqnFuk8mO7SIJD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MiBTYWx0ZWRfX+MBxyLwklh6w
 jtllJXPhQFDAdKCwk4EVkzBUVU/O7NU8GBsyhtmRz7gptnZCCf00slm/fTk9FbViVBewie5xxS5
 pePy4CL6LqxZiPLsK/qqxNL4ow6HFh0d38tVHe2oTNEjV71xTu/GI7y0c8qNZHIQvOALztUNnAq
 OR8mXwtwCLl+SSvUEkOEPBxQAgO8gdg0N0e1HVWSAE0PYxAkSUdiuJCPXoQwbP7ywab64SzEa86
 hMnPUXHTR0OSg8aPv1075gn5h1ly66kUdXm9FlYenjSO0lJoj2xcZ/ScPMeSdQ49Tpnb8kdCZ62
 B2tRaIYS4w1LVC7kz2Ic1uLB2g5aX65EWMy3+9NzOHexyoNxcbiXcexRkY913S8m+kX1S76QrY7
 Fqi7pN42zcb7u7w8lVLuQJzl4k7S91xQe+5FFDJcO5xCc1eVrzC8Y2t6YOIZ8HfMAYB1VYPlRtv
 PhESsCpZbQddquPFBoQ==
X-Proofpoint-ORIG-GUID: 4EyU5hS4oX6jt6ef2SgqnFuk8mO7SIJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220142
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



On 5/17/2026 11:56 PM, Dmitry Baryshkov wrote:
> On Thu, May 14, 2026 at 12:17:54PM +0530, Gaurav Kohli wrote:
>>
>>
>> On 5/13/2026 11:23 PM, Dmitry Baryshkov wrote:
>>> On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
>>>> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>
>>>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>>>> reaches high temperatures.
>>>>
>>>> Set up GPU cooling by throttling the GPU speed
>>>> when reaching 105°C.
>>>>
>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
>>>>    1 file changed, 135 insertions(+), 30 deletions(-)
>>>>
>>>> +
>>>>    			thermal-sensors = <&tsens5 0>;
>>>>    			trips {
>>>> -				gpuss-0-hot {
>>>> -					temperature = <120000>;
>>>> +				gpuss_0_alert0: gpuss-0-alert0 {
>>>> +					temperature = <105000>;
>>>>    					hysteresis = <5000>;
>>>> -					type = "hot";
>>>> +					type = "passive";
>>>>    				};
>>>
>>> Why don't we keep both passive and hot trip points?
>>>
>>
>> Need guidance here, we are keeping passive at low temp so still hot trip is
>> needed for such cases.
> 
> I think we are saying the same. Keep both passive and hot trip points.
> 

Sure, will send updated one.

>>
>>>>    				gpuss-0-critical {
>>>>
>>>
>>
> 

