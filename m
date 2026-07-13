Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C2EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E475E10E658;
	Mon, 13 Jul 2026 19:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LyBk6hsU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kVbXsWWD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC19410E653
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:50:25 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9FTr2448898
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2ucGZQxg2reJFI939JSAKmdJkAoKn8gx0mJoRPr4qic=; b=LyBk6hsU5QfSEQIl
 a7iKaaVJ5egLKv+CBOviDq4gAmwGWqnQFRWUdVXsrX8zU2EvXLEiI0U3NkuXTQB1
 5XJrafTzPcublpd/6SMcJd9MpBINSDU0ImV2FVCq0QRMZKUUFTm1Gdv3lR+1vD2e
 ibmSEsZG9iGnKsHvxw2JdzmMOIAAy0KolV3IbxmFe5PTM5no8OE1IxDcdkhMldRp
 Cem6cuxLQeiuu9BmOsMrOPW1XbChhmz/FX/W+FSWa8Q18kT2W41Mbih0RZM0er3s
 ICvrBCD6y0CsVOMNM4j7L4tqvce9Jc3bgALNRi7wCk3OY56Y3NEZg7FEHzCZW3fw
 aDwIXw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37x8ub9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:50:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so382697a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783972225; x=1784577025;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2ucGZQxg2reJFI939JSAKmdJkAoKn8gx0mJoRPr4qic=;
 b=kVbXsWWDmQyjt5rSpT+Ehikm8Djv7vITOoTYE2Hv6hhsgaProFWi1unu4at8H7i/Jy
 4MSizqHETbiD5jKnKNmwBmAKVaUBQW87qFj7JYJLaAe72tx8YFTtjD9qzTG6ayTmco/2
 kCBO9Jc2yN8BV5vowmsTqwFBa1BRs+kT77xYhTmgC46La4DJjBUSiqruJCX/PRQdp0Zo
 Fa65CDS3v3eWX0AHgCrFse9/6pnXJsvRnSHJrWyjdN+/H/zUFq5/7HLHSp6WUGYzig+b
 EDR+dn/HxQqy8rV9ZDnaENWK7nSLcnYQCICuO5BYC5w8Vc8dlPnKM1bkGstoCFIuc5ER
 eI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783972225; x=1784577025;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ucGZQxg2reJFI939JSAKmdJkAoKn8gx0mJoRPr4qic=;
 b=PjeT1/GAzcJW546G4zBFdAg/ETEpTvAi8YLxCa4BTpREzs/vgSmp1xsoWaugls2/h7
 dX3rxn6VRUEPqJXTOGI1/KdSAwN4c61Bm/IzEY2Yif0smJWmslXgADmaQaXM0+IZHxGG
 rbiZ+2jgdV2KVv0Vq51GiazMnqpE7/tjsc17FP1skkXH/sG0NhwxKbGrHpEeQ1UbFlVn
 0cvpCu7udTlAzcQPO7b6+cPwCEx5bi3t5b9rd9lUfpsIOW2yvTXC1PkuB2S2tClLVrmg
 tjXJ7tO8VqYPPLTN1QrrwuSDVTfthxKnxOpqSaQ/lGhTgRCoMvVBP/Wz9yMJ+eL+0NGe
 gL5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDs8N9dTyUpTchFYTbewn2L1djfvh2nzfI6C5yyVazXm0OuC/k9RpTSOoOOLrpEbF942JirGpKmV4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9ixwIm/krpnBUIAfvSHD4pQ4ZbWK5uKjnWrhQS+LFWZB2h2T+
 E2LJGT8vvjXltTIqTg0O4lsoJxfNevs4aiUT5XJ9VDyWMMCHF6Q2oxlxWiSVi5SMLCwJWA8Vkk1
 rU5l6KReKQQjxZQJHJIQnrlsBtn/mWKC2kQxuEJdy1k+IkOJk45xiqCmM84uNpJJKaOntHFE=
X-Gm-Gg: AfdE7cmyuOJN7vxwJj3uD/JNEOo/h0Uz/FitbpMjZmNrcFhPvkSP3m0VOXIOaNlKbDQ
 BCO0ee74cy/jl0zTQmvz9YwvmWh/3itwY2KFklZdXKpMStsQEsFdL54figtVo3ZOjzcBf4lGOZW
 Kk9VnI7c61Z61sugmj5q7jwh/X1mjNK1mkJlXJqjmXhgMFu7VlwlaE6Q+K3ppd8KaTgpGnJo9rJ
 Y83bDgBCVYK5FndxtZNwg935K4Eb0B8aTblgdgsnqak0MjNpT0CBY83iEG5cHrauM//nSQvW+vK
 Wcmo5fA7dhWWPaeHDlpX9eGMcj6zxsN8ogVD9y/vHGQXmJ34xFh8h2DI1LJpBGe020l0L4hW8Yc
 RrJZDUOEsAOjqQ3SqYiLIrbORjepu5XEwcXo=
X-Received: by 2002:a05:6a21:6e43:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3c0f08602bbmr16998108637.2.1783972224694; 
 Mon, 13 Jul 2026 12:50:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e43:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3c0f08602bbmr16998079637.2.1783972224229; 
 Mon, 13 Jul 2026 12:50:24 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.235.180])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm57081837c88.1.2026.07.13.12.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 12:50:23 -0700 (PDT)
Message-ID: <2d9d6724-a3ea-42ad-8cb3-ef08fd0882be@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:20:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-8-c9f1354dbd29@oss.qualcomm.com>
 <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <clfy5lvz7vm3ogw7pvyyidiujqcjxftx55p67szwgc6ivsq6r6@xrrcbfdkqkjo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwNSBTYWx0ZWRfX8gxj6Trgb0YK
 calwsiNFn937o2YGBMnWDDZ0316KeDMIWhDvyp8F2N3Cm3s1lCltHPVHKfU+1NTehBb7EvxE/Tj
 7Jiu2r+WUgY/dtvCo4fz59ZDimqWNaAgb7kiKTmSTFrms3khD21DAAV/+m5iKxs9HujpgM4Ofq8
 mrdvnEz+S6qybe0ngS554eEScvYSWM2niHzjCMliNl56fOGEiZO8EO26gAteAGekgEmo/JDIdCN
 DFplxDhSreXxG/1U5lI0CmvDqiTg26OHwSPpObrd6GfE1Xo/5hkmPsmPYNdkyjoo8Ti14VRThiO
 nUs3fpuIID8eNdGWlUuVqm3DxCrvG1M4i+JlI6QQZMcguR4t3/EZUaNoSGx+I/q/7TZ7r6jfe83
 iAE7euIxQkxYk1DvuKwqDDXvcAcHGd70mTs6eoW2SF980ybw/sSyzCuiXVw5Q/w8U/IFSzDH2Yb
 LkbdapGKjerpUtbISmA==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a554181 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=yNfbWwvibup9Ri9izU+P7Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JoE_KpbED9LNO2fW3XkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: UZzidlEkJd0MIPPbhXcYYHLZip-FPGkM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwNSBTYWx0ZWRfX0P/X+76gooug
 I7d2QtSOmdiMnlVZmns8gschNC8ySCJqNWzm8p1I8/QKnYQrap1oanQ+nXPbAtn2wCbDeMpZEWu
 CULZ1QV8k6MPtgM75bGnb613E4te9y8=
X-Proofpoint-GUID: UZzidlEkJd0MIPPbhXcYYHLZip-FPGkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130205
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

On 7/7/2026 3:53 AM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 01:44:23PM +0530, Akhil P Oommen wrote:
>> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>>
>> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
>> shader firmware path.
>>
>> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>> index 1374afd9d14e..b280d8e845b1 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
>> @@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
>>  	};
>>  };
>>  
>> +&gpu {
>> +	status = "okay";
>> +};
>> +
>> +&gpu_zap_shader {
>> +	firmware-name = "qcom/eliza/gen70e00_zap.mbn";
> 
> Should it be gen71700_zap.mbn?

Downstream uses gen70e00_zap.mbn as this fw is shared between Eliza and
another GPU. But, for upstream we can rename it. In linux-firmware, I
will keep gen71700_zap.mbn as a symlink to gen70e00_zap.mbn.

-Akhil.

> 
>> +};
>> +
>>  &mdss {
>>  	status = "okay";
>>  };
>>
>> -- 
>> 2.54.0
>>
> 

