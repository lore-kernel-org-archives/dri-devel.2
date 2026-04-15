Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE4EF428F5
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D7D10E74E;
	Wed, 15 Apr 2026 20:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ng5BTxKh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UaPvDUf9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01A310E74E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:51:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FINCom2772758
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uQkGrBvY1Q6Phw3ZndsRhOHv20pp4HB0vkTp3Pi0WBs=; b=ng5BTxKh1LnpJvZF
 Dr4EpzBnHj0FodO3QYrpfICS57mZGnKyqpTHGC6imcUxDsLQ4hl9N1Pz9caxfUuJ
 D8sZqGPQvnLloWQjuEqpEBEtRP+alrOBWFMLOzGMO9+wY8MapPJ/f/ODwEE5ILTn
 m5kycPBXjlVj5+YO8VYK8jXHjcaP4Bkk0nQPqr3z2PP560Ymq1GrTlwwtIp1L+Mn
 BaidGiNlV1qj41Tpi/TOGrjk475/bUZVgu1U97u8kVGryeiGnkVggF+y+z6OQy4S
 X0cLpm5RESI3oz2TDib+P3BGgS9ZAEqKdVW/HcI0dTZHrvHUIbGsh6CGZLv3Wk3d
 tGtGVg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj50v33n8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:51:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso13606488a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776286290; x=1776891090;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uQkGrBvY1Q6Phw3ZndsRhOHv20pp4HB0vkTp3Pi0WBs=;
 b=UaPvDUf923rvj3WPI3Yuc7Yrd87v2TpupDXWpS05GgCb379b7lHNOJo9Ur2S6aJIJZ
 hpbwaYpDXuv6quZrzq6e2fHOSApz/Hw2muT7WVeGy5NpW1f9SUGR+i1TKupMWx7Q4r6f
 55TwXWkpCob7i9a2FvD3oaZ7y/0G1Bz2FpmbSRRZHjOFvCY9J58QZhmzaS9vrgbhEgEc
 nJKIgDJ30Gzc2TeneS0PNV0157ePYxBm247Qr8v6T52q+8Ojib0vZDjXe2YYr6Makxif
 o/BC8d5ZX5mvd8XMd0Mn4f4tmDoDMGpWde7JvCbCPESLS+2FpDHv9lxVPn1/1rP2OwLK
 xNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776286290; x=1776891090;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uQkGrBvY1Q6Phw3ZndsRhOHv20pp4HB0vkTp3Pi0WBs=;
 b=qeemHf4OQyW00OAv9NxebP7WMp+NXIAqrCMmwKI3Lccp71ahlofhrA4K/ri0IQEi0V
 LHjAvQDJUtZJ0e/Jant75587oSCYz5SR6rM1IpicTjdV5sBJUAwPo46n3Wi/ogksrAx7
 DWdO7ZR4khyKQzvSSkn+jWpcXBgf9jQ3sf9C+VSxDGWJdfvQoVUAfxQoZdeNuFSD3NDF
 duPivSbnVhxCtNJnYOa4PIGEW20w6aiO0nEAQvtlmX8plI00rhCECk0Cgbcu7aWxTMO2
 m3cKBBCCnPCX60NWkLE2i7HOwJOhB1wTqlSU21x2TzWJflln0bQNIJxwakt8Y+65UQ5K
 ZTaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0pQBdjv1S4w3KYaC2bVv7+11+j/zgAc0SIRevrQ6cJ2zLWMvCEcLr3ssWnHdeDI4ESRe7h1AzrQQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPjW8+7k3HU4+QoR4fXdxoYHf0rz4HlI/47ZvB8a2se+Z6lULI
 s/5pAFVsM2UQ3lRUaeM7A1zdS9pkj2ecx1ID5lIbDBBYuNJegSOlY+eB+au2L5lx56HfCtjRyYU
 /hbfqsELOoDFHp6t0Bbhh906B9lDF02Ipc3g5mMtTDuQatDe1S3lXyrGAXcExP9cz7lcysrs=
X-Gm-Gg: AeBDiesYwX9w+dDwnCIbZQ7U3ILycZrtvFkYDMu7AJYXWP6+Mj9S+cju+U+NloUDzpQ
 qcQGrVBE2W1nUeWkALWEdtBcKvGfbHIITto4d1SzqJ8ie4r1eQqp2xB1xp75zEQd++WuOdAoBZM
 nPbPDnALmlul6Agr9kiJSpTUTIV+xyWdv7ye9KL+xzIcmxmLHdqTF0TVl34on1PPu3rNnYkA2h7
 vrUPpEHexYxf70O0u2gSxoU1TjsC2+h5/KEhY3wn3f4ARTRWI3BNRLNlkgEMlrc4x9brDRLSMDn
 wmA+QBqTrm1mflan1N2H6V6BYYCse5rOBpzhx2qDJI5JK6l579/IqJmD4l3OPNsMUGOhQJmdCXG
 hTtN5yZ0kmCzNBYLAIv1P19mtezGLrA43+cY0JSDwMbBVmrWJX6FPvNw=
X-Received: by 2002:a05:6a20:a111:b0:398:89b6:1b41 with SMTP id
 adf61e73a8af0-39fe3f5a009mr26877740637.32.1776286290209; 
 Wed, 15 Apr 2026 13:51:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:a111:b0:398:89b6:1b41 with SMTP id
 adf61e73a8af0-39fe3f5a009mr26877711637.32.1776286289726; 
 Wed, 15 Apr 2026 13:51:29 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79581a3015sm2487185a12.16.2026.04.15.13.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 13:51:28 -0700 (PDT)
Message-ID: <a7cbd382-49ec-4b3c-b8f9-b47646d6b0aa@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 02:21:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/msm/a6xx: Limit GXPD votes to recovery in A8x
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>
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
 <df708bd9-466a-4526-ba74-548896b45e74@oss.qualcomm.com>
 <eebff16b-2671-4c7f-9930-dc4b3fa903e1@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <eebff16b-2671-4c7f-9930-dc4b3fa903e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L_cysYkduPfByqPKotbUrwGMOlI1RuSA
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=69dffa52 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tjBgj1cQHot02RtnpFkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE5NSBTYWx0ZWRfX8UFzG06+Ys2u
 kruuL8fWCHfDLoHe8VqXlJPNn9nXaai0bgLlh8NvKPFSbdRqlY2jis6xMmnmka3XTdRexqycmba
 2ghN1PdwiVIAiFWCqsN2yaUszODoxZ3J/EWQ6K17gEO08yiROzYZeZ/kmLXbCzVippdxdoiAfZ8
 583VVYbyax/OBoPAueR9+MhXaAZ6inEgWUUzAo8UMvDzii6vH/HfBOEFZb4shfdga0mXjdtR6Ys
 HNiaZgx7+sq21F5H5+ARF5WGUAVZjExZ7ugtsKcQ6O05GctG/e0J1m74+zs+fv6BREip/ABf/j4
 lRv4cjKVKZ7uw09suP1SG27Mis/id8xOe43Rgo1yH+Iql0yUXPGOR2W1cWkdeyJ/8YBs0mttytt
 ecXr5dcXCJ682INq5OQn+u/ICec/rO/priIkYqne55qD1lfhg/jN2rDmmMiV6Xqohl2qPNpHp+9
 LgoKW6tNYvtKcaVWUIg==
X-Proofpoint-ORIG-GUID: L_cysYkduPfByqPKotbUrwGMOlI1RuSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150195
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

On 4/14/2026 7:58 PM, Konrad Dybcio wrote:
> On 4/7/26 9:16 PM, Akhil P Oommen wrote:
>> On 4/7/2026 4:31 PM, Konrad Dybcio wrote:
>>> On 4/7/26 11:30 AM, Taniya Das wrote:
>>>> From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>
>>>> In A8x GPUs, the GX GDSC is moved to a separate block called GXCLKCTL
>>>> which is under the GX power domain. Due to the way the support for this
>>>> block is implemented in its driver, pm_runtime votes result in a vote on
>>>> GX/GMxC/MxC rails from the APPS RSC. This is against the Adreno
>>>> architecture which require GMU to be the sole voter of these collapsible
>>>> rails on behalf of GPU, except during the GPU/GMU recovery.
>>>>
>>>> To align with this architectural requirement and to realize the power
>>>> benefits of the IFPC feature, remove the GXPD votes during gmu resume
>>>> and suspend. And during the recovery sequence, enable/disable the GXPD
>>>> along with the 'synced_poweroff' genpd hint to force collapse this GDSC.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>> ---
>>>
>>> Can we simply make this change unconditional on the gen, so as not to
>>> maintain 2 separate code paths that try to achieve mostly the same thing?
>>
>> We can skip the gdsc vote on A8x because the 'gdsc disable' callback is
>> dummy when the synced_poweroff hint is not set. Otherwise, gdsc may get
>> disabled during system resume while GMU assumes the ownership. Taniya
>> touched upon this point in the cover letter:
>>
>> """
>> when GX GDSC is managed through the generic GenPD runtime PM
>> framework, it can be unintentionally disabled by the OS during system
>> resume (resume_noirq/complete phases) or runtime PM suspend paths.
>> """
> 
> Right, but if we made the GDSC.disable() a dummy on all platforms this
> could be done.
> 
> On a second thought though, this won't work for gmu_wrapper, so we'd
> need two paths either way.

gmu_wrapper uses a different code path for pm_resume/suspend anyway. So,
that is not a problem.

Perhaps, we can explore this separately as it would impact a lot of
chipsets. I would like the get this series merged ASAP to unblock A8x
support.

-Akhil.

> 
> Konrad

