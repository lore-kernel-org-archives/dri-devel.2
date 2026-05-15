Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B146FCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 22:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B232210E140;
	Fri, 15 May 2026 22:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Io9+h9rw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VcdgS6V/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE03510F61C
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:09:06 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJeawA903679
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YaMH5hmIAD00xqSHsQUa0nL0jAccvNpv5cFUjemkwiQ=; b=Io9+h9rwNtHe309S
 OVH+h6e78ujukoFG+67vJwR+0WA8GGWvkfs+CED7kM3wyT4k1v9lowfjIPwi1Zk+
 +6HG0ljCnzxDh37PtulhGakMBC3hAWzzqfiitC7kHCE0v8DGQuUOaLNBsjzd+0Uy
 tYfqFXE0S9X27qzlkI+MDCeT+hPOdA6OOb4QT4aQV4l03YH5e79XLqGMN/4p1pAB
 sRgAncfHAIY03FZYu7dmHCywYpzd1GvogS7gldtYuJEwrzQMNw31J+Np9vja47pj
 jyosMCP8W72ChGMJzytJE4aK0CiMbUcGRbLGSOjoEupsbn08EAUyxNsaOnW7tihV
 XD5tWw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e670u8y7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:09:05 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f756ebd0dso158084b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778882945; x=1779487745;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YaMH5hmIAD00xqSHsQUa0nL0jAccvNpv5cFUjemkwiQ=;
 b=VcdgS6V/ajTo0QJB3enoKF3sKZIdRrSoztKHy7xFM1iXdfa+LIfTPpK9HczOpXGUtA
 4UrCKjnc00fs+a9GHCiRCXW/iw1kog3TY+QwgRXOS9nIEjGXF4pypUfXk8NLL1nGjKZ8
 A1dZxt+ZIocDTr4oFxXmJCGkYkef8SKaR+kWB4+VP60r5HIk+YS+y3be+zgsB3dEzL9s
 gdp3FOsShX9jUoRV2EuHVtzQqegokmIjBFpjFiiFyn9r/Zz0RV42OIkvFfVPGwnOoS2R
 aaQ4FobSyiecWLf1dP+4+jKd7+R3uNkxvNgYw3AqkBvJDBVIzXaWU+xKzQos41SuSGBk
 NDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778882945; x=1779487745;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YaMH5hmIAD00xqSHsQUa0nL0jAccvNpv5cFUjemkwiQ=;
 b=h5MmOaPVCZy5xk93zsYHU9OlIkjtvk3zKzQuDW3PC5IO05pMFaPQwDKGLHQx6f12PE
 PSwqD1ELY07iPEF5Dk/GKbcQlBbJY4lQwLurmxDRkojz7Y1OQSYEW5QEHwRIuitEwKT9
 sVusN+EkXSH4+ul+HJNup8nvGaT6rlAZdIF8vO9mmDBR05ptrhbjOLrLFi3iem/zGPIG
 wumfa5bVpmOsDILBlJoH+/sXYg31MqIQZ1twb7yaNaIJi3lPBx1v4uuCcTACVZwOiOJG
 UzNNdQsIzDH9d9qJ4uLhVwc8SUcMtYSYEcWlISQN2aDVVQC/QrNP/l1lMGwON3pItHNk
 ylGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DTXb7OfKs6rB7Z02K3gi6hJ+mujZgpSTFcDM9yDpYpEh1eWR2fPr+QiDxQ1llYtvJ7WWHKaXRjKc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyjGCWydW9V6Yftf/ltbdP7g9A0vog+gEGXt1bv4w1PjlXQLn2
 C8iY6WkxDXZMJUy3vIVSV5rexi7uzSSlXwhgazhsHywKxKw3gXZ9NKH3ZW2CkrSlCWv+eKnegBk
 S+PdIWIbxRHYOV21NtXHeD3lzYF+mYQIALu1r+nBtdIgp7hinkKLPIc1hmvZByAshd9IPh8g=
X-Gm-Gg: Acq92OEFmu66phC+J48feJ1kOC1egWdoVykn6FoJC3jmupCXzscDPFDN6W2l9jgSp9c
 bZtCHnOsPvXVFmPUNx/JYZkUjNFZCprccePmNFZiS6U3v2hXqxjqtIuTNwiicTAILzVwABC315D
 nGNyH8FiwpQZikaF/IL7X3LfOuCNCQwXwD2bXoX6wGhav2mbyJyDDApmfoV1DVWOoLAmQp56m3v
 YtrJy/ToUGYXSRQmbpEgH649tX8+CKOVlErduMCJCkM+EDLNZLlu6v9NxJSsPIrN4noOKM0r00v
 UrDsXeW0036zlU2etQP8Q5hszdwkj7vpGZOmLeUdHG4n8Jg5KJWWE3N247O3mFctOXk1wG+FmAB
 KCKcEXM7oSl7D7t6UzO6ge4wRnvhN6vDe2vp+p8FyB08=
X-Received: by 2002:a05:6a20:4305:b0:3a8:2339:24c4 with SMTP id
 adf61e73a8af0-3b22ebed4a2mr6668406637.26.1778882944659; 
 Fri, 15 May 2026 15:09:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:4305:b0:3a8:2339:24c4 with SMTP id
 adf61e73a8af0-3b22ebed4a2mr6668373637.26.1778882944158; 
 Fri, 15 May 2026 15:09:04 -0700 (PDT)
Received: from [192.168.1.3] ([182.60.13.113])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb1156absm6447536a12.27.2026.05.15.15.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 15:09:03 -0700 (PDT)
Message-ID: <7d3dd8b9-8411-476d-a1ef-fdac476a1515@oss.qualcomm.com>
Date: Sat, 16 May 2026 03:38:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-5-13e1c07c2050@oss.qualcomm.com>
 <14a2fbfd-97c1-4ba7-aa51-a07134102d3b@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <14a2fbfd-97c1-4ba7-aa51-a07134102d3b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: biQg-Y4PIlT3XtAbCtTMVQi54rPupJMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIyMSBTYWx0ZWRfX60i12QGDytt9
 XRbZrDr8wyG8gWKL+SBf5q31flGbEXdTpvU2RkDtoVc78SIorGl5ZKO2wHVPNWNt003fiyhtT2T
 byzsbmECCzBFlcLSKD6Y8KARUIg3Ofvyh+iP2NQXG/iSGDUsilLNHhM7SVirgzaCyfz+CZgrGFH
 6Z41wNJeEqE2FqU0Vu60JAWgkE4rl4GtmmiaFATGuJVmMTdAMyGihsHaAMDEEeDvGW51gQi/OjE
 jFMle1c3xnBwYsU/anNCurisUeKqMFJpsuBqzXG2XtLpc7RAJMbwoR62H0dmsoXG8a6M4zGhsp2
 hZUjP1yNTCj9Z9cLqtvGS/0mmc9QX2gc3aD0emOxd78WiRAl6GH2voB7FuLV/bj6Kbq4viw6bMN
 S0gfFrzC0b8A6lqr1oWoLJa6Ik6kGi9/+45PpxtzubUpwY+ALUYfZLMqm0z6qjYmeYVe+n74as6
 LiX7jdCFhf3vJdRa56Q==
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a079981 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ba8plz+5YpscmDk5DVa2Cg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=mzNi1YEEKYKHT8R6ei4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: biQg-Y4PIlT3XtAbCtTMVQi54rPupJMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150221
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

On 5/14/2026 6:13 PM, Konrad Dybcio wrote:
> On 5/12/26 12:23 AM, Akhil P Oommen wrote:
>> Adreno 840 present in Kaanapali SoC is the second generation GPU in
>> A8x family. It is based on the new slice architecture with 3 slices,
>> higher GMEM/caches etc.
>>
>> There is some re-arrangement in the reglist to properly cover maximum
>> register region. Other than this, the DT description is mostly similar
>> to the existing chipsets except the OPP tables.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +			gpu_opp_table: opp-table {
>> +				compatible = "operating-points-v2-adreno",
>> +					     "operating-points-v2";
>> +
>> +				opp-222000000 {
>> +					opp-hz = /bits/ 64 <222000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>> +					opp-peak-kBps = <2136718>;
>> +					opp-supported-hw = <0x0f>;
>> +					/* ACD is disabled */
>> +				};
> 
> The clock plan also has a 160 MHz OPP @ LOWSVS_D3 and there's a couple of
> interim OPPs that you have that aren't part of it (but maybe you have
> better docs)

I somehow assumed that the 160Mhz was a thermal-only corner. Seems it is
not. Let me revisit the OPP table again. Yeah, the doc is outdated.
Looks like there was some last minute updates to the OPP table.

Also, we should update a6xx_hfi.h to accommodate more than 16 GX levels.

-Akhil.

> 
> Otherwise lgtm but the size of the GPU region and the GMU base look
> slightly confusing when I'm comparing them against the reg map
> 
> Konrad

