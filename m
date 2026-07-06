Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09841C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B4B10E330;
	Mon,  6 Jul 2026 11:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENQWdUF6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WtQfbXqI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD65210E8C5
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:08:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxIkN369076
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 11:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M9+o4PUKMgHJp9AdorOs0p5SVquVy+abyY/nSxhj6Bs=; b=ENQWdUF6x1jx8yL0
 TK34NknB8KymeARAmE8QPgyereYZDw3jnXe1q0/8g8VIFp52NHROi3RqaFudgQWB
 5zhFcvneVdsjzC4lAtz+xN4hN8soi0D0zrkeozEht9CPW4BSfkXXGS/jD9U323y1
 /ogrS24EEAoedojh9FLljIPmZiPkg3Je1RtIU/U/X9Y9YxRXjiwi5R8cE2hJs9XK
 pm9NYzofTI9ptS+Zy118aqiLUxsiF0BAVbr5c+zxiNtevKsFrT9hHyGN7ggwLDOs
 TYMKWyTD5JQoP8CysdFe+g8AbOM/w9G0UIwT4QyYEOOxbQ9xwEiHh/esOHlx+YT6
 Ywkprw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h98qvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 11:08:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe75b7dbso9661391cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783336085; x=1783940885;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M9+o4PUKMgHJp9AdorOs0p5SVquVy+abyY/nSxhj6Bs=;
 b=WtQfbXqIzyZCy4L3uI5p1h5WRumR4cHZIET1KoEi2a4rE1XUVT3+bRXSV/N64w1txG
 GPcTRqeU6CPNZHtqPe82OMYEUbq8UVHwC2VWIECacbYXMPlI0mDnHnPfxi2rSCsjD7kw
 69jI3BX2o4HHxlMN6G6i90pHTyUvLgnAJTnixqh6nT1szmDlZF5ynPGFACGAtuVwlpTf
 Yj9xyCVVjthjQ+Ipv6Fmyd4SuRuldne6FcFPWSey0ayVT1lg/hkL9eRmT+iU3dAfOJ8/
 IZqyNuO/jg599IGdjHm11b0P5NaSXAIM3/9ikqglE/nO0VBuoJtfSes4OnYcF8PR+VK3
 BlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783336085; x=1783940885;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M9+o4PUKMgHJp9AdorOs0p5SVquVy+abyY/nSxhj6Bs=;
 b=lhVa23VKHOADEB97gEsHftDpxb4MV/asqiX187xifabQLge6gEDEvM0vXJGTHlOLAf
 UEZhvSYmoZcwaCpL/Bb+uwTk+qV726tHpU1bPRT4ucftSmgALJngImfyihmlYx3zJ6Zk
 puzWSFBM4bdDys+H76Y8nstI9wah+kYi83mWMLcAt5B6U608Aoh5xSVrNZ6UQ9BpwoqO
 IitNNRFAUqNli1wREfpnykw0YrsGVE2ZUDUVhuxIyi1RfZetnh3nhoSiS3qpNSRdDooP
 8Fy+rEcBL3YNcfJ3+xoY988c3FQBFHqyJS3V1sdXDX3Ke1mQDPCIDJEdNBjd82UF4mmX
 qb5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2Pfbf6GbVMzpOpFbkP9ckOVwC1J0LeyFbup3e2gfhTjKGv+Xq7ouPQZ5qcXM56YQ4r1d/zy2/nnA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtI0pTocsq/KBlj4NdyxNDq43PQf2QPvaRVfDTVuPtqd+5gHJi
 el5vbXG8qOChzzCqPPVKpMkD92eZTeSRQO7h5hCF0rPc2Kdw9RPkoli5qqC46fNL4TPVJtPfFkl
 UWlxOIO4HNwrxfpaI61WLXKqaKazxLp6OMPahPb6GdUCfivYOfXDCjtsrCSAi8uRmy/k+1KY=
X-Gm-Gg: AfdE7clC1VXuexc/vxHb3DS6P0r02XjT3jJVtFonhebqiNsZJ5ZR+vNPfOYLPRDML5A
 ypWluTdkgiOAaU2sWghW0q1oFqviKyX94Mc686ixLbT6/DJ6j1dqMRgcxqmXhcnHYce2s1IdbZe
 7GLbRO0xUcnc0rNvY2bFLAs3wyhYZiOM67xThGg5zSYLQQ6pAJlyecCd0fVxdWgwbKE4p61awap
 Cs5Y7vwucjv0MGFyaNS2JLQxfelp6irn05ZkYF0dPU8whGrfsGLuTYD+J2fD/pZB4Jm64NY260Q
 VyCFs+KHF2YOKOA2LMrBAxrvKLbvEFuYFe+bCPDUItL9+hgWDMgJAtTXv/MCFEl7ILwWwtII+y8
 ViHNOiaKhgoI2Ky7v+6fFZ+w37cqY7vVULyw=
X-Received: by 2002:ac8:5710:0:b0:51c:db4:3cb8 with SMTP id
 d75a77b69052e-51c4bed6cd2mr88275311cf.8.1783336085175; 
 Mon, 06 Jul 2026 04:08:05 -0700 (PDT)
X-Received: by 2002:ac8:5710:0:b0:51c:db4:3cb8 with SMTP id
 d75a77b69052e-51c4bed6cd2mr88274771cf.8.1783336084718; 
 Mon, 06 Jul 2026 04:08:04 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b629a1c7sm723146366b.30.2026.07.06.04.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:08:03 -0700 (PDT)
Message-ID: <5fcc0bc1-7f9e-4611-be77-42860e0f4c74@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
 <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LRUgpL--aTWmGEDB7sNNpaRejafuHW1c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX9Q50dfe4mSli
 WLnj+FxSPv8bAKCZtcKgOmq41+cfewkT5HSvN78NOaFMdFzNNOJV3dV1DBYiK7kmcVFLF+1ykvQ
 jrT/jdE3taWKVup6ApIBAMO0jjJs8+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfXzSo38OBWTuJ0
 qOr417lDT6VBofspw5bG8X8HmLaAo/e4l7ZE+HUf0kNO6iV7Jfi1yr+wBJFEtC6jFa7w5cwYpHC
 HGH79dRTMCQBL52rcebCQDAq29TCfF9f/I6Ijf4T8I7euAnHGs4LaWHZ47FCfG7JM1eFzHeBGX6
 pNdy891PzyN1Y04VEc/p1u6bUFsC7anNG8RY/Zy1nx+M4kLZZkJKXTawVc91ANGBaHWRzXC0imq
 m07UYk7rKL7qYESEqzsAGzjNUeb/LJqiQfwbaKxd+8qQIbKUU/VcKEANfFCxDO2qGihguXxImFe
 3uzqgsKVb+4yzG9Zf0fVYBlCWzzrPuc0ZiDr/Skepwz76vibile30i2u+4IMCuyMht36Rl4vNwO
 Z6CNdBE6PXBj9Jc1YbD3FtfYZn5hvJDRmON3r/26GyvQTLHCHQAZcymupOr6ayINnA+Seu7mFy8
 86rvdtDtN2kEzHnwLEg==
X-Proofpoint-GUID: LRUgpL--aTWmGEDB7sNNpaRejafuHW1c
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b8c95 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rL6LpJHDE9oUo6aHBFIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113
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

On 7/6/26 1:07 PM, Konrad Dybcio wrote:
> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>
>> Add the nodes to describe the GPU SMMU.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> index c5635f22e2a7..e5b8377e6c3a 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>>  			};
>>  		};
>>  
>> +		adreno_smmu: iommu@3da0000 {
>> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
>> +				     "qcom,smmu-500", "arm,mmu-500";
>> +			reg = <0x0 0x03da0000 0x0 0x40000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <1>;
>> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> 
> 674 is the correct globla

(modulo the issue i explained below)

[...]

> This list is not quite correct. It must be sorted by the context index,
> to which a given interrupt corresponds to - the driver relies on that
> to give you information about where a context fault happens
> 
> Moreover, I see that the interrupt sheet has the bug where some
> interrupts are offset by 32 from the base vector, and others are offset
> by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
> out which mapping is correct with the right folks

Konrad
