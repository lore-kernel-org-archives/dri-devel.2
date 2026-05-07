Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A6DCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35A510F1C8;
	Thu,  7 May 2026 15:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/mPlGnW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fPh+gBKW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3FD10F1C8
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:42:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647FbNcE258729
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 15:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IK8JA6xLLQG4xNqFkeo5i2J3M8AwE6anH5GguOVZrjE=; b=Q/mPlGnWs0ZtyFhW
 Sv6EoVqU+Vb9Yz6d++gXgtCGfZlVvdzSPCDyzgF3TQaZ1fW4hZ7UJz8hW+5DfE/i
 wFcHsgOGBSramZmcQ2fcQXypaC15q+WBkaX0zi7RWSjz0MQDnjavBXW8jSGtnX2d
 3Uh+ihQ9XmI/IGDKPa9LYZiZqglFU2Tnda19CcdDpNKY59zLzQ9+kXn8LcIRGKpC
 nkeiTKXUWiP98lBN00gHA9NXd7qLn5cRlApcM84XtLtrQ1MWxkfnZZfNBCYFth+G
 gPlTAOKaf1ibpTiaBRGjy/jFXt9i65JBSfynWHejUeFdyRaSbB//a5efNsmLPvvN
 XMthlw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8twkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 15:42:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b4678c6171so9811745ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778168558; x=1778773358;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IK8JA6xLLQG4xNqFkeo5i2J3M8AwE6anH5GguOVZrjE=;
 b=fPh+gBKWsVIkLAuVD1NeWiJPhgCj3Kl0teGAwC8wVYiNmaoR0WlTy7YPZq/B4wnygZ
 PAIiSVm8KdAXUBP4FwuZaUqnJLzWcjL1i3LZyyzDqtDHEn/jlSI0j1ndOBjYvAwGuyzM
 uHgRkP1QLjVeLXqIR7Oj4osqzuQ+iDWTKr3OTYbrUw2b0hPAQ2KV/C4kgNfLlm1VvJ5l
 yb2kQeDNRvG9i3MTBoJqPJK/f27iJCkZA3CwTPAxYgui9/zDtUpkWuBWZdmJS7+GBrDq
 RawfTbkwRVEBaFWFUX7Vl3ghSI53UI27/+R210b3myat1aMoNpe1g6LqbBrHdPeL+rCb
 u7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168558; x=1778773358;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IK8JA6xLLQG4xNqFkeo5i2J3M8AwE6anH5GguOVZrjE=;
 b=keWQAEbpn65zlu4dZgeygm3jDQ5XaCLaLNQsnPfinhYryI/8nHuTd4FAPStenJ9aHo
 GddDhQIEUQvIi3ZWXP1s7dbl5VmsrhFpGcCN4u1jYpmjKnHKJk1cf4/NbqUOscvrF/B8
 /T/OKy+H7+BoYTPbqV9W1vqGyCwXXYzm6R5vL+bCQe+NsSaYpRZVI/lp9JozOlF/LjCN
 0f2c7TBVgL7+KIeI4TGn2/j2cnL+OHOM03sjCu3jSFsYrs2MIsaTIeJWJqlykJWthmWQ
 lCofGHS/BbqwUrNns9r/KOgHRDorBoS12zIDUwpWyqrayJHhktmeNaUaeotRN+4yFRQM
 bywQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oYIq0BdLqsS3oK9Kbmk95Fogvhu2hOlhvF0NcGDR59lmyIk7bS3zz//R6tu9v81datJ2UpJmj0Bc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBtbr9JJ7jDoKuWuOz3Y7nhY0LgdaWrwXblCl5DCKiJiF8Wa99
 20yKbomuFUg2uKTK0n8Rg6y6LTTOjYbmiGxIFYbOiXp7tWMkuR/cCcDT8c/IvaSrh8UHZaXEsae
 ok20HypfsUTZ2ly5cBTDu0vH3aFmjaCid9CDN6KoC7V9iySAfop0Zjx3ANT7+ZVlnQOgNJpk=
X-Gm-Gg: AeBDiesw/u/GFDac9b2YmAXWuw4t3adP3I3iy8EIWhxNnk+vZebmLxLq+OgB3RzT7oo
 uS+Ss0Xbhm4dsLUv2IIU2fN+NZ7IUPtZD8vFyAZfj5URcjS7+ORje6RLOpc8MtWKOYs/axXt90v
 gGjHC0j0pcyMJG/hB1O233nxcV9qneJ6GS8di2BMeoq38R2Y55z2TfX3ez2HP3GKJlH3KGkEJmH
 D51Z1iCP5b7WfmsBaujCvEMZhhuqHZoHHdGU0Y1zXoaa3+TQuEbX1UKm6wIt2Sapf36IokOJQny
 CbtUKtL7rnahmFoG5JGjt/IU4qXccM1+gA6gOczQad8VYFHLYrDxF1sCGGwhDn6mBpT9MP6Yo1X
 Q1hb9Wjvg3uCIyjqtRsRTQsXA5nVa4iI3pDNbGszbMlR/GF5/D9DUMxbaj9fOva66YA==
X-Received: by 2002:a17:903:4b0d:b0:2ba:4749:c9af with SMTP id
 d9443c01a7336-2ba79ad0c52mr82610565ad.40.1778168557632; 
 Thu, 07 May 2026 08:42:37 -0700 (PDT)
X-Received: by 2002:a17:903:4b0d:b0:2ba:4749:c9af with SMTP id
 d9443c01a7336-2ba79ad0c52mr82609665ad.40.1778168556426; 
 Thu, 07 May 2026 08:42:36 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bae75575d4sm1173565ad.19.2026.05.07.08.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:42:36 -0700 (PDT)
Message-ID: <a01f4b67-847a-4e46-ad35-856a437adbe6@oss.qualcomm.com>
Date: Thu, 7 May 2026 21:12:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: arm-smmu: Update the description for
 Glymur GPU SMMU
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
 <20260501-glymur-gpu-dt-v2-2-2f128b5596bb@oss.qualcomm.com>
 <ecf6f144-0873-4f75-81db-c11f4bbfa679@kernel.org>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ecf6f144-0873-4f75-81db-c11f4bbfa679@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uVMJAEqwHP8HyMhVMlzgBTLFag8lDHJx
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fcb2ee cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=u5UU4oGBB7bzvuaK6rwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: uVMJAEqwHP8HyMhVMlzgBTLFag8lDHJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NiBTYWx0ZWRfX/aJqBT++uEeg
 rYQB3+mVirNzshZ7Go4ufgklJjsH/A5uEcE8/wO4Cjygh51AA+AulDPCcxFj/qje8ORDu5tlyPM
 PkUznKVsUneKRkmpweaeDGZrrxVJaSuorwf/xbXKB/5EvRl+UqzUMb1YbxVAYSL1a16van9Fmew
 lbwGxbe7ju8INMxKvoIpgjh8BtMJ/keGBO3XcpAS+y290N6xLnWMn85HAoREPqqF6P00zXaqMZt
 q7rh0an5DLxQ8F8dha3C0sTpau12qWWRB6gmC3/EYXdwVLfkNXPObQ4kZV5w0HauN+QIymbyces
 6I0OjEbIxeo86hcu66X7jUJp7+TQCIccHhyHGjfveHV/3JCgidilYen18RXfDJ7FbjBs7Vfmyiq
 FnXbXByvL6O0L5hydIhYWi3GL/FkPGvYFA4lwsGUmzNhk6D6Z5qMU938qE/OPMaZN3l72aJzeXr
 022hxqVNC91bm/E4Dyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070156
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

On 5/3/2026 7:44 PM, Krzysztof Kozlowski wrote:
> On 01/05/2026 19:10, Akhil P Oommen wrote:
>> Add the interconnects property to the common SMMU properties and extend
> 
> But why? And why SDX55 (or any other device) has it for example?

I don't know the reason why this property is used in the recent
chipsets. Most likely a recommendation from HW folks to address some
stability issues. I need to dig the history.

I just realized that this property doesn't have a user on the smmu
driver side. I think we should drop this property from DT for now and
bring it in a separate series along with the smmu driver support.

-Akhil.

> 
>> the sm8750 clock description section to also cover Glymur since it uses
>> the same single "hlos" vote clock.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> 
> Best regards,
> Krzysztof

