Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C943C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7310410EFD8;
	Wed, 23 Sep 2026 11:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6t8J6vi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZkyZqQMX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA3F10EFD2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:18:23 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2kMO3087092
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y5HvJEnsTYcbFbHF9VSG+7AqvWxgJBjz8BE23CP1doU=; b=n6t8J6viQBHuQx0Z
 pC5UuZ0f2h1zGjtmqozBoFR6EJGtFqrxr3pReq3t6R9bTgqDm8QOUBbEXArJVI8z
 3g9ZjCaLkUdpMLuAzbd4Zl7ugBHCJncyI/aAVZeZ2PfnTvwZU4n8L6Sh58dzcFXS
 nf43IpxmpoMhPFDIC1nrz/q1+iRnsq7VLOLW1cQlThBagT9QvgXs1Pjg0/XCXHeb
 ayz6Jiacpkgs7NlXwhxujVcp/RY9MCSBbqgTTDVZ85CA9NfkWQnmcWfuf7GluAL0
 HjxKQNAMi3jJTca0PKPPYEPaF2dy/c/ejtA1eLtMH+F+5o99aazUgvX4UOTwsxI9
 1B/LKA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm8gv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:18:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93bfab40895so22148985a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790162302; x=1790767102;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y5HvJEnsTYcbFbHF9VSG+7AqvWxgJBjz8BE23CP1doU=;
 b=ZkyZqQMX0S6AcAMAe5k6jSoM15QCAyOVxqTyjfFogAOoYQgzJx1E6Pmroi0S+dTDoF
 bOL43dyPdo/svXoaOBRLzbQ9/K6v419sIesAHKfoZTQyF1dWHrvU5YVnGwxqG3vuTQXe
 trX+ksh1OeIr2sCGh15wAakdKeJDEjnpFoWh87CY+oN3FaL/IudwOW+AIp5DkmTKHoql
 9BbtENiR3k5Z0N1HD4GEECEgd5QpaB6dlGTYprdtg7LSsLdYt12RJGDh3KjyArojabrh
 IpBJHd82JRRQy2EZX5xFL51WigBnV+4osT+FwlgFgvTwJ/sFYve9C364G85B1Q0NfnEi
 8JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790162302; x=1790767102;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y5HvJEnsTYcbFbHF9VSG+7AqvWxgJBjz8BE23CP1doU=;
 b=rZqIidb99jG5WzXWoqdIA30gIccN7TdYX6oD9+CHyNXTdNFSILED+3hRx8LM+TCDvb
 sgCyD9CKmvLGha5BBHLt2UGE18+yMisYtwReIu+JeBNpBKpkq5R0ZxSAlFSlZ4dgJafv
 bQ42MTo1G2tU6ix+h9AYL7nlbR1Cmn/JyL5YWZ3CiKfv+PlKdKiViiZGmBVSF4N+HcdQ
 40YozBnBjtIZhhFR9i7QF1aYibrW4MilPDORspX0gjvIv2xSXYkGEC0W5rj9VlYvhN7K
 pE6yhCbw/16CVjIpD52ngha9p04i9AMS7AYvFWX/KtXWWeyRrdsg/RrxiYVgpNn88L80
 cTzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzymVX0HZXJwmIUIzDflwczsEEK3JYRcBfyyA4LjyWe6E7BxltfSex/4oVttFpWp2UcgG5j2zyovvU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mp7GDXfVI8/3FTR3izWhPjqsf4I4uv90Ttom1afLLHQCMbmbuZ
 Cjcv21HTRl+lsF3EmDlzMLzgKpAgdc2f6LYdZysRS0FvHjQnhs5ceTfCu4Cz+aoT3dtYKfn2wCf
 i3g3rlVEO0W5yt/O6Yui+oueDDiyMLkI0hCsYWfEeQd03UzIfEBdKBOZP/+J5CH+n/l+Lxr8=
X-Gm-Gg: AYBFou1CU0CXtTW+U/gQMlQMEljAF7FyVURfx0SNmSQ/2XmeyLF3tTI0wRPZc+cOc61
 biNdnvyzuaM0TKhxSKQoFZfC7m49X9sdZ0BgQLr3hFu3obYTQFsdbnDyHGca74k4/cTGcY2ameN
 C+1ol6o33B7cAKUUb09cJNVpARV+T0Ijo+wP8YnaIb7pUPZKzl2VMCThFeOF4c68wtztuBYikQn
 dSN2vliH5dQOJeMhmsHcPYNk/SgHSNlwl3GO0lOFJrtjeCrUcqkF7Awi7YU/L44bM0pz4Zedqgt
 YNtXICE1p+lL7U2JBgfVClb/YeS4BCpo9Gij70s0b1OZElnsBA7RNHsJLMZCsTOTPwQt9+wV4yg
 aUO0n3eV1CO5Fn/Nmtc8YBCM0MkOG/AJu
X-Received: by 2002:a05:620a:438c:b0:93a:19cc:107a with SMTP id
 af79cd13be357-93c250972e1mr336213285a.1.1790162301559; 
 Wed, 23 Sep 2026 04:18:21 -0700 (PDT)
X-Received: by 2002:a05:620a:438c:b0:93a:19cc:107a with SMTP id
 af79cd13be357-93c250972e1mr336210185a.1.1790162301150; 
 Wed, 23 Sep 2026 04:18:21 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6e3677sm100600266b.62.2026.09.23.04.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 04:18:20 -0700 (PDT)
Message-ID: <75d01a06-b943-4dc8-85e7-0eb578bd0e27@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 13:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] drm/msm/a6xx: Honor perfmode_bw threshold on A8x
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
 <20260923-hawi-gpu-v1-1-0c3c79a1a470@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-1-0c3c79a1a470@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX3enkDsktM4WX
 rQ4mQen8eYMicgzV9kMEmIncn8c+VJ8h7ByFtrI9BF+yWMQYvgOldZ16eutfEPt/WgqSM1cQMU/
 Ygy927zbI1wh+5hz7vJgpbdu4zfJ5QE=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3b57e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=YJv5aonfaXPMDC4gfg4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 7Y9hFiY-o4_41Cn6hgwWUc6haSYJyaVB
X-Proofpoint-ORIG-GUID: 7Y9hFiY-o4_41Cn6hgwWUc6haSYJyaVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX78EXQLKlGpiR
 PRaexuUmYm8aHewhKEhtA76/3/CTQnsZBzn4ZYDC31tKtt4x6ppO4YK0/Vd5Th1jZjsPrK+WfVM
 qvIVM4mE4s39iJ5wYFYuPPiHYaaFRExJpDGvZXGhufc45BuTNjoqYwsc35gKxoc6YPAAI6uc9te
 XOjjjNvzQnt96w0aMT7ib5lsh62e2w0JTy0w3+mD2Zh/rh9uvOTsR8T6oAwIPmcN+xdFk9026Jb
 cIvLf7bFsvDeJs3OywJKlYAQj5FmofixftS+TLXatdylqI4QyxO9P3+g4TlPasabNMWF6SRkEJx
 cKfYAzb106nysXt08EszOwAbyCFY3/Kio8VrgNYQHcVU4pFtYMbnkl1Uruj7LQbyQv9tQi2Vozc
 O22nIVUlZ9VJxzq+HKwolcdVdxcilPNcqHM2gHWoogv0ZuaUTIdYsQEZqe/kz5vNYXRmkBW0VpC
 qPDtG+b9tyxXjcvN1sQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230044
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

On 9/23/26 12:25 PM, Akhil P Oommen wrote:
> Instead of voting ACV for all bw corners for A8x GPU, restrict it to BW
> votes above the perfmode_bw threshold, similar to the A7x GPUs.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
