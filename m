Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBE5C44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8768910F4D1;
	Fri, 17 Jul 2026 09:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qov3sl3X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jcyousaa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E708010F4D1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:59:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H6cRAT951362
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4m4mhHCdwe+iD4gbi28L8euNiv4IB7P2LYKO26utpc4=; b=Qov3sl3XOGvuaaS9
 FzJ64v8p+4oY/aWx3GR75C+9X6OpIO2Ur6Y/TrlskZq7xyE4qWVcdLzgAK1OkjcW
 /O1PfaH+hCukscfvU0Usf//CEk+9veVwA/G6+tNr3UL5NsUHHrdRVPTjn/Y0TlEb
 LEVvhlslkKG67+QUs0vgfT3Af3AdvBk+sINzKnG390ybx+UpMIayENdJnYE4m9q+
 c7Cr5MyXPrw54nkerytxqHoMPPoGxBTdNvngbm3R4fwW13K8hB0gqkBkCFZ1fwq/
 eESdJxByGALHzIP2JC5Y3tAe5udjJlu/OgjRhjaDv5y/gVkCUi4NqZU3eFfD3YZG
 4XXPdw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2un6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:59:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e9c0c4492so152839485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784282359; x=1784887159;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4m4mhHCdwe+iD4gbi28L8euNiv4IB7P2LYKO26utpc4=;
 b=jcyousaagYXhvhCDV08fERtbPFC/RzS0tiNCC9EiAdj8N91sGEeeFDE/dsS31GCvOj
 rEHTirpnugh+G2NDj+netaz5qlzs2oijkezysiosdIOKtVXy0qvE/V0hBnkcL8uiPYQY
 q2QQby1W0RRN0PXoWJlVAI0GuDBAsE6R/rlWv7aUS4wru+pUMTW9rcDKE32F2e2gSgEL
 D1TKFDUavEpi0TGgmdZeUQAA+IGBsL6gELWsrATyLwzE2V3wRB2AlC7LBHXkE0RUZYwZ
 T+9GyVwlUlWjAZZwacfU6sJX/MfE2RnEk0JXffLiyRrWWWurx/dlYMrnap+oywhsYGez
 eVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282359; x=1784887159;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4m4mhHCdwe+iD4gbi28L8euNiv4IB7P2LYKO26utpc4=;
 b=Z5GBcUylc96zSNKWehyN760lDytLWDJusqADciqiRhEcG2Q3fLg+1eSRIa8fLPeix8
 XXkuuDC2shUQZ37XhdCcWK3hx2V+ZRrnmGX0ye+S8w76tNcnmCxvxaLkqE5KnXAtsqao
 IZ6v3ExS03rv89OPmvwxLqVHn1m6tFT9o46BqL7zi/OBKZnC0NvSr3oHHA7bgM3nIpuT
 FWOYPoy+vNkzkW2UM/xlpW8ITqpKDWVXKcxOugGi3Q3QEXcb9B6ONAKIWyCoO5raTD2H
 31GeC7bur2XNz28MvSDmlYZR08t0Fh7vIFGnrE+6woArGtVS8Cn22Y82317K+FdmIKmT
 Dflg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFprtcLU63OuGSc4ms7xvGsPa8JJmxm6kloBuZf8URdsHal5i+TCzfj6B+dqoguSDH4iyJZwIPeOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxaBiMyzZIi8wyqKhGvdD2DXD8tbl6PAEiLoeyCmWbqQxknHRXC
 X6IX+oqwEDkME/I9nN8ACV689lE55XyyUfIZnDB1ESD/CywWg9NCvpcx034V7Mb2+gzlwg+4LUo
 iBZmMbsIWvQdggnluL6NmHCH7pWLVpcNVZrycO6+6deHJTek8JAlEq+ZRrhCT7D2z1d4YzJ0=
X-Gm-Gg: AfdE7ckHsVflI9231GSU1x4yd4udl89XzLji9i1GiaHUL7v3vt4ZtB8wy6Y8xCHrhWK
 FggFhKS00t6/4VXv0ZcSZi8jKRtQGMNiEVyeNe2uvPdk+2i+YNrMbDmh/VSOCrldMIh8s7QQ/2A
 5WPtDuWeBo/dIEpbRyuGhKEwqoseRuyn0CfIt+p4+OgvGmAptSNQhnrv1O3D3L0w0R8INfKfDP1
 cF+5+zSSODn7vnwQw5vyxZ87rgvfN7dgxCGIAQITLlc3yOUWefnt1wgyq2AsbHj/Mxn+pdeShd9
 K5ASkmc7sNgQICRPz07ZiYq0OJJ2ugispKx0Q6p+RXWDkgQd+Rb0zbPn4BC6FvvJgslK6qZYMT5
 aBTkKa6ehS8aM4EkcfbJA8YBa
X-Received: by 2002:a05:620a:4396:b0:92a:228:1bfc with SMTP id
 af79cd13be357-930b3e2e4famr170489785a.2.1784282359415; 
 Fri, 17 Jul 2026 02:59:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4396:b0:92a:228:1bfc with SMTP id
 af79cd13be357-930b3e2e4famr170487485a.2.1784282359012; 
 Fri, 17 Jul 2026 02:59:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1740bf5df5sm50044466b.61.2026.07.17.02.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 02:59:18 -0700 (PDT)
Message-ID: <f7de5852-c255-4a17-b87d-c9a4542255f7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 11:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
 <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
 <5fcc0bc1-7f9e-4611-be77-42860e0f4c74@oss.qualcomm.com>
 <e8255fe2-a67c-490e-a905-ed056c6af950@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e8255fe2-a67c-490e-a905-ed056c6af950@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g1u0q98vjuzw91MG_NR-iQELZyJiX0M_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5OSBTYWx0ZWRfX2/iqZsAR0bV4
 rRMp7sTcchySxHHtwYCv45uQ39ISAEeJEegl+MS8keVMAjMHkWkY2yrrg8gh9jGd7FZwdp/lg4a
 Oqn6LpHzvpah/xE3eZsb+SOy2aVS1GI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5OSBTYWx0ZWRfX9qZbR7RjIi24
 UaqjuXrhgOf1GGNli9Kf2l4h/rWpHhuM3yrDyZOO/Pd+t6ZpiVNyHMvHC75/qh4sb5oD8Q/2toc
 PxGHbVdLXiZh48C4dIg8ig14J+tZ1xNVeKP41o4I72W64WeswS675V2r7/54g5aClImIpTbmQ5a
 gdBGjCxccDmoaUka3FCYuhhKgU0lnkepyHCTwJAUrnkqz6uKpttxDWwmfuG2m07X0wEGqL2wD8l
 drpZlJe3Ko8v5fb/eLTjnQ3i32S6ZZSgshGz7lm/Hokf9EXSHW9u2lHWejYzLCbH29VH0TS9R6S
 86I4/4d9ELrkVh1q3lJfcdjIxRMimbBOHuJNqIsLigkA6C8rimHzraPRTVyB3jvLkBo7gvi9Ia4
 p8o19ehYwatYBnYDYCWeb+72ChODcpaOiiOxWrSUf1kRuHdrS5u306SOLLLIQI8YarladNf2qAe
 XiQth3NFmjlJMzb7Smg==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a59fcf8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hbrWYzUuUx-UyiL5C5EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: g1u0q98vjuzw91MG_NR-iQELZyJiX0M_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170099
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

On 7/13/26 9:47 PM, Akhil P Oommen wrote:
> On 7/6/2026 4:38 PM, Konrad Dybcio wrote:
>> On 7/6/26 1:07 PM, Konrad Dybcio wrote:
>>> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>>>> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>>>
>>>> Add the nodes to describe the GPU SMMU.
>>>>
>>>> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>>> index c5635f22e2a7..e5b8377e6c3a 100644
>>>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>>> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>>>>  			};
>>>>  		};
>>>>  
>>>> +		adreno_smmu: iommu@3da0000 {
>>>> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
>>>> +				     "qcom,smmu-500", "arm,mmu-500";
>>>> +			reg = <0x0 0x03da0000 0x0 0x40000>;
>>>> +			#iommu-cells = <2>;
>>>> +			#global-interrupts = <1>;
>>>> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
>>>
>>> 674 is the correct globla
>>
>> (modulo the issue i explained below)
>>
>> [...]
>>
>>> This list is not quite correct. It must be sorted by the context index,
>>> to which a given interrupt corresponds to - the driver relies on that
>>> to give you information about where a context fault happens
>>>
>>> Moreover, I see that the interrupt sheet has the bug where some
>>> interrupts are offset by 32 from the base vector, and others are offset
>>> by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
>>> out which mapping is correct with the right folks
> 
> I reviewed this and looks correct to me. Also, this matches the
> downstream configuration. Did you confuse with Dest Port vs Vector ID in
> the documentation?

What I'm trying to say is that the documentation is confusing, we've had
that issue in the past on other platforms. If you see that the correct
irqs are firing, it's fine

Konrad
