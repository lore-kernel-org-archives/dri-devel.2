Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A09CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 06:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7014110E03A;
	Thu, 14 May 2026 06:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxFwvY9d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VChjpH8z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6FB10E03A
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:48:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E3K5Rb3430126
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1dIqx3AV3aEYA3aesXchj0hVPbQX+b2MuE+8b6/BrFU=; b=BxFwvY9dmeolgFNT
 rxtfCdlUKx0M67AilD/55CfJDr/7/jIa/LJgMnmnuiUC3HdG1PbTeFJVsq1ej0F4
 v0r6Joo67UxwLAsVyF9vrnBnwahlb4+QJ3a4T9UX9k0Jz4BhoB3Skk4UdGmNIaVm
 llflerEmcXADzX7fiTolPXIkHPmWE72n/uA9RtOzI66mcaP2lws9fTQEiDbsw2nH
 WjctpSSSDZ6x+gXfPJ0wS56FreTRM9USM4ZoGFnvhPn+qVQyr6ypsNaId1O/oIab
 Z8u2UpDSIqz9F8cIPRvIQaNrDu1ne316JJtUCP98BIqP5yRbhs1DW7FnNiLhhXsz
 EPQ41g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcm19r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:48:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c828f0f5c23so2409700a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778741285; x=1779346085;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1dIqx3AV3aEYA3aesXchj0hVPbQX+b2MuE+8b6/BrFU=;
 b=VChjpH8zPPrm7+Zh8KtD3grZICtKwHS+7Xo+TjbqcTJ/TdqOY+At8YRiyH74CQOEpG
 yUFSy42MhWFB5kC0JK4rDP7jvE76BytljpbvGhHZJqewWvLB/rcah5aEhJCuLDN9w7la
 D8cc1WjbAA3lvQVqlO+fT2xv5TTbs6QphrsaRqn6XXH/Nb/+UzvBT8q/SgMsFgrW3GzF
 mwKqhK6IQelPWcusbqrRPb+Z+L+nuDqjRDm6jYZhFpJo9eoH5g0YWCunXOYbChXSfM0w
 s3+ztLeQU5j1LeTEKH/ToYyU98m8nSGPDU5RnICOqPEQraf9hbg+hKMFiey0Yieb0Cng
 WXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778741285; x=1779346085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1dIqx3AV3aEYA3aesXchj0hVPbQX+b2MuE+8b6/BrFU=;
 b=cGwo03OEjT1hVusqdKPzSxG2aOWwOWVAAfmnz3dafhgF42q+l41Cl2EQU6d5gKHEZm
 yqd0zPhG28n9ccDDcOKNo+3Usd9+gFkeBeRmhqzxe9jR3Cbz2HiYWlNKDnsosFNIUwft
 V9rLgq3TCy1r3b+6v815a5SrrhPXxAEdYLwvlSqpAUORBO03CoRvHUaKG5Rj57WsBNwm
 /nugLKzbMXh8hHlaCzyNorUbB27kXRGLFrxTOb7oCl++lQwesYbbSxrMak/wfdnhG3sQ
 bvpDJ7qNtPaOr0c8QwYZ0joT9gsk+EbDTMyOPpa6nOLJ4piv87PPvcf+iozIBbkAlONx
 4Z/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BQpahlhKCgsmuyi0HvlzUTHHoBvYxvida8fPNOnaafUNKWOGwHxfys8cPPhhrD50SfDo+11kUWGA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzp2vlz65mHztUjVTsKxL1FMW2CYGr2uc8Eeww4WjLtndJJsCUt
 gDaxlOMGq42bly5lsIy2XJwkvsj+kwrlS3WM+xei+3JuiNDXcZrsDVaC0z0iy5pRktYRsPoqo/1
 C3EfjmSmL+D1TN1PPZTcoruOZ4Xnt5Nwc1QW7tIx9owFAPu63mWRIPGhIhecBhCvGt2245D0=
X-Gm-Gg: Acq92OEewYnZxCLZnfxs4QKVz58FmKMpEsRJWBKxrzcXmPO/7tzfgl5BGAcGG2n/+IU
 c0A+E7MLBpvgwfZBM6VK6Eoja6mhekt6rwcCZ0kYhM4nAf5s65OPaAMuHDmAGmyKFNThPXfeTfk
 ZuqNNyBOse/uJ1XyyFRp2rx38X7U9ZoCAKhdkI3N8ThZXcCNRmh6f73eO9HJjFi7VOVPomJWlRO
 2wHWFGXKRccJzgTPucQ9kyS8xd02bqVgkHeVQbXlo7EYFhx+Yo379FGvMrifBLjL0FZKbY4q/Os
 OEiR9QGFU+2mKyfy/o3xCOIjzq+dbAu+VV1JXjH4OZuxJ5MtRk3At0UH1/p/gLpEDiycQigl8hK
 Gi9CBroM+NjWbmu5DR+oEM6Y7dlQBkYf3By76uAXfd7EvUbOwD8g=
X-Received: by 2002:a05:6a21:33a0:b0:39b:f12e:d53 with SMTP id
 adf61e73a8af0-3af80681dcdmr7390043637.18.1778741284471; 
 Wed, 13 May 2026 23:48:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a0:b0:39b:f12e:d53 with SMTP id
 adf61e73a8af0-3af80681dcdmr7389962637.18.1778741283620; 
 Wed, 13 May 2026 23:48:03 -0700 (PDT)
Received: from [10.218.12.237] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196660f9sm1952912b3a.10.2026.05.13.23.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 23:48:03 -0700 (PDT)
Message-ID: <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:17:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
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
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zEDIdlfBSFkbRWv6--9XFsJk_fR_Q-KD
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a057025 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oeV5rHmN1k-fxemBOLwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NSBTYWx0ZWRfX40YhTbCEeJco
 X7AVWM4LDjp+jn5uPLfOpRaGSl3De+Lbt5qFRLTbZ9l3QqowH1ICEw9vut1e9FertEdvJV+z/Vu
 fyeW33yzunMX92RM9gqU0GpC2X4skW7e4q1ham+dConwNBIkaj08UGrCID+iE2QM2vTRkwgculG
 R/IlhT9nIxzjuTANwZQKKYhxUU93VGcWI5WrXonaPvEx7bcQck/T9bIYr1tEivLM2dorSzkXa5D
 Zm7txEyI6EHVTntRtnbAk/HlrOad6XWCKANXS4MoN/hR3J3AVfAVMkIdOE+CmOToj7srQ6jFk2b
 SVIsoUNn5f7/ftIs6cKwte3ne+PlNcrBIbfsq/ZLH7aY7VKMBjY7GfUAIIFK/yN0HOxTkBK+OeZ
 zK1o06xmCcw4twVssADgLxUVcEYChKhYTlD4n87chsr4s7RCPBSA/4WABWYwpQYUAxQryhd14w4
 woHt4DkNqs4dxMx4TGA==
X-Proofpoint-ORIG-GUID: zEDIdlfBSFkbRWv6--9XFsJk_fR_Q-KD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140065
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



On 5/13/2026 11:23 PM, Dmitry Baryshkov wrote:
> On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
>> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>
>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>> reaches high temperatures.
>>
>> Set up GPU cooling by throttling the GPU speed
>> when reaching 105°C.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
>>   1 file changed, 135 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> index c57aea44218e..5089416ec32c 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> @@ -26,6 +26,7 @@
>>   #include <dt-bindings/soc/qcom,gpr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>   
>>   #include "kaanapali-ipcc.h"
>>   
>> @@ -7045,13 +7046,15 @@ nsphmx-3-critical {
>>   		};
>>   
>>   		gpuss-0-thermal {
>> +			polling-delay-passive = <200>;
> 
> Other DT files use 10 for GPU thermal zones polling interval.
> 

Sure, let me update.

>> +
>>   			thermal-sensors = <&tsens5 0>;
>>   
>>   			trips {
>> -				gpuss-0-hot {
>> -					temperature = <120000>;
>> +				gpuss_0_alert0: gpuss-0-alert0 {
>> +					temperature = <105000>;
>>   					hysteresis = <5000>;
>> -					type = "hot";
>> +					type = "passive";
>>   				};
> 
> Why don't we keep both passive and hot trip points?
> 

Need guidance here, we are keeping passive at low temp so still hot trip 
is needed for such cases.

>>   
>>   				gpuss-0-critical {
>>
> 

