Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF35C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1EC10E664;
	Mon, 13 Jul 2026 19:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/gg9+NM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IY1sz3iu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1BB10E54C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:47:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9lPv2461357
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LsYB8yHPbPP+skFaM9JiYXJZSC7Kk8Ggqc+cNJG8mMI=; b=E/gg9+NM7cdqU6GK
 J1bGF6571fqlPr11tx0ljupGSTx+WHiufAYJ0CWbEGlT9oszrTgyU+z9FAknSGwy
 fG9jvps2RIE10yGfVj2sWn/RcY8J+JeBzsMePAQJVgF6/in5qK7E7c1fTkvv6XhF
 cSG2MzLBtd29VIrn8aHj7+wshe1L8u998/J6n1ewYeW/yUZ1r+nwS1ky7lk/74b+
 AdR2WG4PBFDPeLq3sJYZyGo3Z+eF9xf9+oRcovn8qc+W8YqS63VQisAf4yQaoOwb
 46FcO5uxfjisKfE5RqYIzistF+zZ4KclOKJJMXUzyENA2Vm344ngFQJMnXVmPosR
 iwBOMg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda2dbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:47:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c890bac374eso8980247a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783972064; x=1784576864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LsYB8yHPbPP+skFaM9JiYXJZSC7Kk8Ggqc+cNJG8mMI=;
 b=IY1sz3iu44LL+sVm20XBb6t2ZC9ktU6sQjEgDhHCxR28BwrU64Qsa7ojU4mOMhVfO5
 8K398V+rmtYdeK2nEdj9VeC9T73LnhM1g3FNJLookvXxHqcqhOH0jeUrutgXTd1d/KLk
 ww26hByXlSHZYXiQ6HWbwRbkW9N/DlGsNv95rODkQyYcIsTgFbuQnzRBYTV+TsJ508Tp
 pYNQcpEOzTJql9Ud+jpXiz/iagigALpo+jkSyI3HwBzKd2S4FEdbW08hbKOViJpOu43o
 ZK8PRureoOBPODM29wuUN3dbzPMJ5ymqQUtf9+sTyKZP3GBpve2ZEy475+SlWqYGrzyv
 Xmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783972064; x=1784576864;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LsYB8yHPbPP+skFaM9JiYXJZSC7Kk8Ggqc+cNJG8mMI=;
 b=TKT4hJVcIYYFaSOoUCUEu0tNnf7+m6NuL4oE3zIqYkdiOp6uYoAhgP/vGjZc1fk4ON
 0PQnIwXszdgiWScfWW/1mW3biAeTtc85vRjNTuNSjyzu2tL1Q0kEbttW9KVoC43LymW9
 QTZNeqTrEmmqVRBvvYmFaftwGplda7++06kUkCwTj8EPnWQ+RltAR4hsJisktjFyCEXc
 7RGq410T7GOuE5FulUb5rRL34842+UiFq0IzywrbyLBNFntBG4eHpjUoan6QBLkTKvOZ
 +bW52M40nPK1oLeejtWWhAZcupgui3fnmlmLJU+kyBBpnNCZ23nuP9vpsCZZrsmm7Baj
 xLeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RovpbqFQhW4anMqP4iqyuj5TqH35USimenYJaUYfL7zER6kGeSLfQywyeqNGxID5X+sFyZki0LEQg8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWij7yMZyq9t37icoI8LdU9j+6/iM4tAhsQaXCFQ+473ZHcXU3
 k4+w6HPoawoDSPAp0aq9gyg9gaNvcntZy+JbuAtNcFHdSyq7HiwDxXyA0Lxj8hdOK/krIp8cUIi
 0N49SupgrZ2hz0MQzuCuOznZTPIiiVykIKQRAoBxuiNQZAH2fKcGy0T9xnmcsEn4DQn9MNac=
X-Gm-Gg: AfdE7cmQmJef5tww0Rt7px5vuiCgJPvPms3IlHhre5JrimBU/Du6GJWzvyQTTH0ZPoO
 LPhKDYwu870ApxuGiD5jjtflB81W3k0chpafWqGd/i9+n0Y32FtlyIuqS081Qqt3yBSCZuHKFSt
 g4kOUkR838UHfDkddke+BWo3OJNti1yJUdSpqGAXpzGO9U2Zk9mrT3OANNwgFbbRmtz55FKenIp
 Vpamlr/MeKr/Nhpn+Rq/2EVgJLccU5dqQ/s05aD10UwwfPAoFW51cfTHfyz5Nqawz+X3h3o8VX+
 F638xhqi/1a28iGjLbVIe+LR0NytCxmtN0izHUHVJ/rb9Ogo8nNbKxD1lYYIBwuIHW++arBX4yu
 5MDgRibdkqljrrPGil3p50D8KLJhQod2ZQPk=
X-Received: by 2002:a05:6a20:6a28:b0:3c0:9c19:65be with SMTP id
 adf61e73a8af0-3c110a74421mr10454881637.70.1783972064012; 
 Mon, 13 Jul 2026 12:47:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a28:b0:3c0:9c19:65be with SMTP id
 adf61e73a8af0-3c110a74421mr10454838637.70.1783972063592; 
 Mon, 13 Jul 2026 12:47:43 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.180])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ba45b7049sm6823350c88.12.2026.07.13.12.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 12:47:42 -0700 (PDT)
Message-ID: <e8255fe2-a67c-490e-a905-ed056c6af950@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:17:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5fcc0bc1-7f9e-4611-be77-42860e0f4c74@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwNCBTYWx0ZWRfX2TTrQP/7Nj5Q
 B1b75pwFTKPRUo9pXe3cmPkgzeOOm+zloaeX1DuqeGGEMjB+d77AW/xGXKUPbdZtXj0VFQqHMdy
 7WCPiGtJYPFRT2xg2G8QTILk2fGVit4=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a5540e1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=yNfbWwvibup9Ri9izU+P7Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=sy2TSPCRsGNh5uQNLmIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: NvG6Utnb2s1zgNFRuOwNPOPDV88-oyxc
X-Proofpoint-ORIG-GUID: NvG6Utnb2s1zgNFRuOwNPOPDV88-oyxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwNCBTYWx0ZWRfXwRQmHfpLxgmQ
 aK0JgvEdASFk7JWfIh46NclfIEJWymTOQIEhrWidcddRPytwSOi0bcnTYM0fIMAvm+ToZcqwg1I
 ff/5JMV6hO9PQSt8AHu6P52FyhzsNBLoLfz8LvWVcC/8VWLircVVkCui2GjPunebzazgKljgzZ2
 EJpyWshbxnxomrJpbfjjtrHjq3lLhMKib0Bx02o23e6hnEW+veCpUqa+lepq7KDS5HfMJ0oeIIh
 oHN/hkFee7cP+qyYE2y9zDgpsoL2yrOsoTCIm/J4Wd6zI6ZLdazf0mNTL01i3QT4ia1SAl/auNO
 uHQ8eyGiEeDrSEjNWHyEwG4RzLo/f6jz4SJXRLtqcMCgGCsAcASI5PiwFq6eIkgm3kW0sOaB90e
 R225HObBjfIJkft4tpbMFkttImF0wSXeLJVPIHI413HaTgpwhQXx4r9mIOYbBF/U52lF1XKrUAH
 N0bMf6t1h2MiTkAvAig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130204
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

On 7/6/2026 4:38 PM, Konrad Dybcio wrote:
> On 7/6/26 1:07 PM, Konrad Dybcio wrote:
>> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>>> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>>
>>> Add the nodes to describe the GPU SMMU.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>> index c5635f22e2a7..e5b8377e6c3a 100644
>>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>>> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>>>  			};
>>>  		};
>>>  
>>> +		adreno_smmu: iommu@3da0000 {
>>> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
>>> +				     "qcom,smmu-500", "arm,mmu-500";
>>> +			reg = <0x0 0x03da0000 0x0 0x40000>;
>>> +			#iommu-cells = <2>;
>>> +			#global-interrupts = <1>;
>>> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
>>
>> 674 is the correct globla
> 
> (modulo the issue i explained below)
> 
> [...]
> 
>> This list is not quite correct. It must be sorted by the context index,
>> to which a given interrupt corresponds to - the driver relies on that
>> to give you information about where a context fault happens
>>
>> Moreover, I see that the interrupt sheet has the bug where some
>> interrupts are offset by 32 from the base vector, and others are offset
>> by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
>> out which mapping is correct with the right folks

I reviewed this and looks correct to me. Also, this matches the
downstream configuration. Did you confuse with Dest Port vs Vector ID in
the documentation?

-Akhil.

> 
> Konrad

