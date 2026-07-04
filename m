Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C13C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D4B10E465;
	Sat,  4 Jul 2026 08:26:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZemKFxjO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EXEUZajt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C372010E465
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:26:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6646hreL2282430
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Jul 2026 08:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D6CPp0iJudsU6L8wSjPuRWKqGYqr17Tm7EBF+oYdEIM=; b=ZemKFxjO6AcQKlK0
 SCLwmrUnKICDVi4LvF863+RK7x0XoghxqaAI+vd2UKkMfM9GjsDYhEANFCMJqxX+
 5oMN+94676A8gao4D90SiC+WYIVk89xLAjPVeS5Mm8xHd2bqvcRqjw5mX6H8FnFq
 C42TDsuFiT0ZkYYskPs1QdAhaqIh1ZDvPye+EbsB7C6yRGTT4xs3PeU2phxTapSh
 eNdsY7dbeU+C6yQwcCBXuagTTOszxPEVr1fcfbnnnvUgwUF1IF64iS67VDN2YqdE
 prxG8NZrZQvPmzrD+a8Ii9XmJnS58IfJzdX//+AWlJ4Z0a/wkAxtEnCeOQO90dUm
 muosbg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh0kbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 08:26:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso1973419a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783153606; x=1783758406;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6CPp0iJudsU6L8wSjPuRWKqGYqr17Tm7EBF+oYdEIM=;
 b=EXEUZajtqtftJT0lBEZmzA6ZRLRHTGDUEbjq89EIhsh6eThKjZJSRhUOa2Sf4VOyeb
 kfTa9ZSoSlsrLrcM2eVKhRQ2Unds2wDAiojeoEHe82yB5MR6W1AXwtbLONgJCzcB4G6M
 u3kALrn7B7IDrEtqmkTq5Nmy0qX2zKTJU5hEQhIfxHHdYsMc45SbC7aeLHUv71eeI61r
 T2XVej3EsEl5L3RGWXvE8rBBibIgzn1It8pW65WGqaF36BI5iOMKyc3paTY5B0nGzI95
 qWIc/dzbVKC6L6cSPJ7FjKMB/SWqsgze9p6Q507jlYdOFgMmWSO2LfcrkVQBWqdHlB2A
 3fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783153606; x=1783758406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6CPp0iJudsU6L8wSjPuRWKqGYqr17Tm7EBF+oYdEIM=;
 b=FPVgj4FlSdrDMLgtuG6Epa9OMH6QjIlgUS5IxRvTxxIGIiaLcHPG6GOuBdhgNXOxWm
 w1zmadSYq1PGHmpNjp2Rxctg9I6o5IvlUzRBfMFbCcrlz78qTTlhmDvgfBynxmnvkDxI
 4uHqmR3UQU+wRjpxvPi0OWRF9bKzOfvGjkWL/dzGOsg0w0CdYDlIWrbWGDw37JdOQao5
 pLx9tCs6eUY5gWJJX1qpGlZZyVehPrn9NeQKJ8eNGz5624axVWBdim3bv8raTPjKEDZQ
 +eke+Ftc7JaGt7yirzvJP3Jfe6fvlwLdbOKWGM1Eg87ki3WH7FtnxCKVzijCuN93pJRb
 44+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1mvHA4+4IJd0PQzDTpLJlHoy0YhyAPcgERZRwupld1DQWW2QmaNfEpIMnhbOYmf9q/kbhH49/M+4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmK0cQh0z0/z//UpCbshnlpv325MKqAiVG9QF+KUv4LrAjdT05
 7smbpfgASxpwXoDcUpFiysvh2//CoVpKJZ2NrR0KMBlr37cp6JL7vFhfOI9s3c2Ux7vkvFN878v
 qiTTiyt3TzN6FuIQjGaDSD33i/5nxAwX7wi0FSgEI9NwCP0X2r/1ZVVyAlE4uKdvh5PpbDYY=
X-Gm-Gg: AfdE7cm6aNSFBy7lRzTsSixWwtNdcV5w9hyOMwroe4IS2LjvkUQkb7rv70387G9co+1
 ECENCHUdnXAhG1UFW6AJiuW3ao3XH3cGZ+ibUsHEf3Zil5WoQ4yN23cP8WuAqOB+UzDZczXiANx
 RRVaqGapPwFu+GRrSM8jl9OIqLF0V058LLWorYD3pU0LRjCePGK5McJU12b6o95deOWR/2HXpWy
 EoV5HTHzoP2CsMuI7KE7hcuUhs9zqhvcD/HED4aicaCZrSCvkCs1VhqjMdtZohmG61H5vbWB+l8
 oP9SmZfu/JsQApNldyysT+8DpmE4oev4PFgjByFY2WcjewyDIfllLI6+etTzlnkmwU9Wqoht2Zr
 +BP6NdpOb1/ssKAFEbHj9S1J5sN6ibsfm8zY275567SI=
X-Received: by 2002:a05:6a21:3294:b0:3bf:b5fb:d7ac with SMTP id
 adf61e73a8af0-3c03e1fa2f3mr2525736637.10.1783153605600; 
 Sat, 04 Jul 2026 01:26:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:3294:b0:3bf:b5fb:d7ac with SMTP id
 adf61e73a8af0-3c03e1fa2f3mr2525713637.10.1783153605147; 
 Sat, 04 Jul 2026 01:26:45 -0700 (PDT)
Received: from [192.168.29.91] ([49.43.231.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f376bf710sm10035822eec.6.2026.07.04.01.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 01:26:44 -0700 (PDT)
Message-ID: <ca8f3731-3f23-45f5-82ed-ba1a65514b95@oss.qualcomm.com>
Date: Sat, 4 Jul 2026 13:56:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
 <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
Content-Language: en-US
From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
In-Reply-To: <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a48c3c6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=lXa6t/u14VstaBBXcWJ8zA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=wGVdvqWwsIcFZm6VKzoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA4MSBTYWx0ZWRfXyMo8RbinUSCS
 ScYO2uvK2ikBo8OigXDVvv7euPBKJE5Tu3Qynl302ikMz2plavXwWxQj1MlK3/jBed032z7W5Vd
 F9Rz9QFMTJbe6hYcynun75xnr7Kk+ejVHyku9CzRrPJmAHFK53NJS+7JeflAQVGzFTaYkSUU3P3
 RsjFp5GrmvXHWTpeP9VlW+s/RVtGfj9TqC07pWzcYJZL4aQyrwwkBuEdvF5QWs9VVnQVqVXkGrN
 Yvt05QsUWhcQ8EjfvrgkTWZ9zZayo12SS6nTy1XkQ0MVhIYmuKj4koV9rHr4Dnod6zoWtQD8t/p
 JoqivwT1nNBgX6b58t0YkAqiCN+QSwAEKpKudWJ9ODr/efIvIMVlFTYkhddvdgvigNg1MldqAD/
 vRS1YDtgMcPTC5IhYzurgRW7Pt8IJCVDMn+SvdokUfA8/4nnCRs+pX3Os69T1k/E+hKHEfy8Eri
 5nyL1IEYC5m3DGnYhuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA4MSBTYWx0ZWRfX/carp5Vdj9ZW
 YVFscdsJSrheVnYq7p6Q2MDFe+DpfWpL+aLByZBdge2MzCnVS5OcaaCmH3dgyIUzXegHW8QGKyM
 mqFe5bAwwqrULZdINlRvWhfywjrthwU=
X-Proofpoint-ORIG-GUID: 3OYJtwINwAlw0B9Wi1l_87TesKK18px0
X-Proofpoint-GUID: 3OYJtwINwAlw0B9Wi1l_87TesKK18px0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040081
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

will update why part in commit message.

On 7/4/2026 4:41 AM, Dmitry Baryshkov wrote:
> On Sat, Jul 04, 2026 at 02:04:32AM +0530, Akhil P Oommen wrote:
>> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>>
>> Unlike the CPU, the GPU does not throttle its speed automatically when it
>> reaches high temperatures.
>>
>> Set up GPU cooling by throttling the GPU speed
>> when reaching 115°C.
> 
> Nit: 72 chars. It looks really strange to see two paragraphs with
> different line wrapping.
> 
>>
>> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> index 34261221664b..eeeaa369d3a7 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> @@ -2510,6 +2510,7 @@ cpuss0-critical {
>>   		};
>>   
>>   		gpuss-thermal {
>> +			polling-delay-passive = <10>;
> 
> Why?
> 
>>   			thermal-sensors = <&tsens0 6>;
>>   
>>   			trips {
> 

-- 
Thanks & Regards,
Aastha Pandey

