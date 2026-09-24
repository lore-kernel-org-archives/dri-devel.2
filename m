Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA832C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11EFB10F583;
	Thu, 24 Sep 2026 13:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ne/GjaE9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ewANV3Y/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D61E10F583
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:41:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC52so1430181
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QEYYv0cWpRHAP3FDxsLq4vXa1ZOHiCaWsZmD4zy72Q4=; b=Ne/GjaE9uyckCFt/
 p0/89XjL/xwCoQ9isszFuJo3idOD9dW3SJL106ZqA7rlEJN8mQBzfqf5g3YnxK+f
 3LdSU5UUqA6A18+p0+di+kxKzsyLSEpKB8aSC+f6Ow8hu11cF+CClfrRzdTqrlCs
 bZRzOqKHMcz7MYiT8WcbPbxjbmJz1oIppdMAc+phXvStU57lR5qunx2oN4aNEN2P
 3ltuD+j35Yh4UkEhlrB0c5srLVuXhox71gI/ID8m3HOx+lE+8g3xc2RubfiRay3b
 aAPLXWRFmSK/zu832WvyafWqr5f7+LyvVhoJNF3vjqiJYyTPI+lBU/lyBw8icUP+
 +crHUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgha988-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:41:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2db8c152622so13674955ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790257294; x=1790862094;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QEYYv0cWpRHAP3FDxsLq4vXa1ZOHiCaWsZmD4zy72Q4=;
 b=ewANV3Y/NF0381R36zZ67CncsW56fgdlHJzpECyoCWs4AllbJ95WhB9uRji71NWZyV
 yNpOQTUzuh3IGODYq1Cz1Jg2RCvBL7sgKrIda5TrZBYAB80q8/tUGIDoC4a2QD64HzrY
 FgtQ2s0enoMhKtkzdd30SE7tM/O7//fwaF148EYyuZcXcHU3Uq3i1+9+6EzterOIPTte
 JBCJ2jk2VtcEIhQOQMQZd5il7RLPOFBfpng4YS5mEITHNbUyLK0a9TGaYswrXgJx4THj
 whQfyPSRW6xoKaniFC/Tk2uOZHWohte5mbxl5DKyZluVNBO919zCmpWoAWTJ9Dx5AWqy
 e5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790257294; x=1790862094;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QEYYv0cWpRHAP3FDxsLq4vXa1ZOHiCaWsZmD4zy72Q4=;
 b=2aYt3iSZySPkQ42hKgspp5tUr2xtjDYy0B1SBGDLkeK+zHpwWtSHMEpkRQPzTmErQh
 kHZoj/6ybWdiiqK69s6L0/VcA3KQpNXaAfXSl9kHLz2wEnrj5GjCKfNj4uKNtxt3LuI/
 eLNrgxr6p80LHyxoTH502mdOq4IyRCSpvcQD2+WxcHGje/CQg11OXzUrc7Q9fMl41gtP
 vcBvcLLUP1MLXTo/OYg3RXvk+VsiBGguzxgcLLJC2SZ9bWciNy4T/5N+SSib+4fe/LJJ
 4xQlcFaPUl6myF8/EgsRW78w+nYAajuJ38nP3FaXJ0OdPZ0QQ+px9ldPz1KPxe1B0rvP
 V/qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLZ68jGEELp123i2dK9eITOJVqwKeBMoLQQt20MWrk/AAlQIDuqOm9wskMrnRBKxKkPf2fmApNEQQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lnTR2USraCQqQpNEiU9MXTxWVQrV+e+iUjzZ4g2CiDvcwbn1ce
 hmyDt7yFPzRVcc6uqSkOmGVyjrdy2cLigo0IAjcjwEdGDTvARFFcQxiPO57HPqQLv7EOalZuITK
 5+NzLMFagmULY7c6WH+aPsUuudxip8mu0Gc5hr3ESzpKpXypgokYdRkkjBTabNzdge6IZ5hY=
X-Gm-Gg: AYBFou3nQJ2eaEboeSg90aOVxmhy3psyC0NWpZUqBd/4otGg5j5bhpt50neucmgq0VZ
 dpmEPpK7ljDOZQl1vAExndHelM6t7k+V9oTV/kf8JRk2jnXMufxGQ7HRaa+IXLAzEIpW5ggcW/U
 0bL+2frExy0RIWGQwzXQhaOxUbIyZUUS8qR8rY3yvkHlWtmUZews8zQ1UcTOpfXLPgKjlPeSe8Z
 pdMm9fg3OMGWzbdANIiySTlCYQrdtcFMW+4CysKm+RckAwlFr2TXdZWD8S2zhSWdotRWZcqh5qA
 FvpHpb/k7DJNxBe5i1DX/yI1+cFad8H88LecFsfSLm3mlIvVdO0Txe1W4YhHtBTNH01maonGlqn
 Hc6GnuiQu5Z2lbLGicsLVkg==
X-Received: by 2002:a17:902:e54a:b0:2dd:c100:424d with SMTP id
 d9443c01a7336-2df7e246248mr24330655ad.49.1790257293608; 
 Thu, 24 Sep 2026 06:41:33 -0700 (PDT)
X-Received: by 2002:a17:902:e54a:b0:2dd:c100:424d with SMTP id
 d9443c01a7336-2df7e246248mr24330195ad.49.1790257293024; 
 Thu, 24 Sep 2026 06:41:33 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.235.96])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5f52dcsm27897905ad.69.2026.09.24.06.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:41:32 -0700 (PDT)
Message-ID: <692ff69a-330e-40db-bffc-a53987fa4bce@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:11:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] drm/msm: Support for Hawi & Maili GPU
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
 <CACu1E7GndBnSj75ZVqic9NxdSakZJL3ZJOuz7D+RbVWA4DUqTQ@mail.gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <CACu1E7GndBnSj75ZVqic9NxdSakZJL3ZJOuz7D+RbVWA4DUqTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab5288e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=36LQ094ZKnh52kRnC0Brrg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=MmXTpdYTAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=Kr7SBsR4NPCIxS1kjiwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=7hoCnnChfAR1N-e-f1W3:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: hbYKFxASKCAzg_FdXLKFE513hyczVm76
X-Proofpoint-ORIG-GUID: hbYKFxASKCAzg_FdXLKFE513hyczVm76
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX5Nk/8xItH8aD
 W6e6E06MoqD1LBtWB9NbLvFzIKHwtlWB7oYJZEh+c0giLl5eKLfOJPVdvQe2Sx7qX93vzFUIhoz
 d+ss1L0zfTC1+Jpb/6Zmm4LRpQ3kOC4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfXy5JpqqlVUCJ8
 UkP5VpQfyN3C3VaMiH91ElQyHQeVNe3d8je+HZFZp62f2jXQS1ZU5uVF2imz4Egy0+LV81yPpO7
 FJwEvKUIjv6PfB/7kndPrRMji9klZRmCy0RKuxe7DHMaeiWKjK0sqJC4rLBH1yn8Trc8d3Gokug
 PufKMbMsvc4hMAEsD1Ppi7DgPy5cJwh9kELRq0RWlUuyyiNghdsD0ztV3Q6SGz8mGzrZLKh8VMA
 3ljhxtH4XaWxmP6ApN6YZ/UuUIpw0Lc19s+YE1h+DmZtrjGw7LBENZAfTDOtytz8vs295XgZiUn
 KOzIcg5udD7/RpwjcUFmJCEvNgSL+9kwejwlYAAvJtWZXMiVLA7IOrzcmHkLO48njOpbBHE8OKa
 JYtOuWif5a0Sv08AdToqlqK8MIbosrvFv9+vTIy4rq/VSX4MdtmJsQxFp8a6d8gV+hXc8nB9f9z
 RY10qkFkBu3Y06yUubg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240056
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



On 9/24/2026 12:54 AM, Connor Abbott wrote:
> On Wed, Sep 23, 2026 at 6:26 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> Adreno 850 is the next generation of A8x GPU present in Hawi SoC. It shares
>> the ADRENO_8XX_GEN2 family and slice architecture with A840, but has many
>> architectural improvements. There is a new block Matrix core (MALU) which
>> helps to accelerate certain compute workloads. Also, there is a new Bx rail
>> that powes a part of the GPU IP. GMU is now powered by a dedicated GDSC
>> powered by MxG rail.
> 
> If there is a dedicated rail for GMU, then
> VK_KHR_calibrated_timestamps is likely broken, assuming that the GMU
> AO counter is on this rail. The AO offset logic in kgsl probably needs
> to be ported here. Has this been tested?

Not sure how GMU core's power domain affect the AO timer. Could you please point
me to the AO offset related change in KGSL? I will check.

-Akhil.
> 
> Connor
> 
>>
>> Maili GPU (Adreno 845) is very similar to A850, except that it doesn't
>> have the MALU block.
>>
>> We will post the Mesa support and linux-firmware support soon. MALU support
>> will be brought in separately along with its support in Mesa.
>>
>> As there is no display support available for Hawi/Maili, validated offscreen
>> testcases that render basic triangles, glmark2-offscreen etc.
>>
>> The driver/dt-binding patches are for Rob to pickup and the DT patches
>> are for Bjorn.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>> To: Rob Clark <robin.clark@oss.qualcomm.com>
>> To: Sean Paul <sean@poorly.run>
>> To: Konrad Dybcio <konradybcio@kernel.org>
>> To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> To: Dmitry Baryshkov <lumag@kernel.org>
>> To: Abhinav Kumar <abhinav.kumar@linux.dev>
>> To: Jessica Zhang <jesszhan0024@gmail.com>
>> To: Marijn Suijten <marijn.suijten@somainline.org>
>> To: David Airlie <airlied@gmail.com>
>> To: Simona Vetter <simona@ffwll.ch>
>> To: Jordan Crouse <jordan@cosmicpenguin.net>
>> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> To: Maxime Ripard <mripard@kernel.org>
>> To: Thomas Zimmermann <tzimmermann@suse.de>
>> To: Rob Herring <robh@kernel.org>
>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> To: Conor Dooley <conor+dt@kernel.org>
>> To: Bjorn Andersson <andersson@kernel.org>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: freedreno@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>>
>> ---
>> Akhil P Oommen (11):
>>       drm/msm/a6xx: Honor perfmode_bw threshold on A8x
>>       drm/msm/a6xx: Fix secondary rail vote in ARC votes
>>       drm/msm/a6xx: Fix RPMH dependency votes
>>       drm/msm/a6xx: Factor out RPMh arc-vote helpers
>>       drm/msm/a6xx: Add BX rail support to GMU dependency votes
>>       drm/msm/a6xx: Clamp MX dependency vote
>>       drm/msm/a8xx: Add Adreno 850 support
>>       drm/msm/a6xx: Send THINMEM config to GMU for A850
>>       dt-bindings: display/msm: Document A850 GPU and GMU
>>       arm64: dts: qcom: hawi: Add GPU support
>>       arm64: dts: qcom: hawi-mtp: Enable GPU
>>
>> Bhaskar Reddy Valluru (4):
>>       drm/msm/a8xx: Add Adreno 845 support
>>       dt-bindings: display/msm: Document A845 GPU and GMU
>>       arm64: dts: qcom: maili: Add GPU support
>>       arm64: dts: qcom: maili-mtp: Enable GPU
>>
>>  .../devicetree/bindings/display/msm/gmu.yaml       |  90 ++++-
>>  .../devicetree/bindings/display/msm/gpu.yaml       |   4 +
>>  arch/arm64/boot/dts/qcom/hawi-mtp.dts              |   8 +
>>  arch/arm64/boot/dts/qcom/hawi.dtsi                 | 336 ++++++++++++++++
>>  arch/arm64/boot/dts/qcom/maili-mtp.dts             |   8 +
>>  arch/arm64/boot/dts/qcom/maili.dtsi                | 309 ++++++++++++++
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 446 +++++++++++++++++++++
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 231 +++++++----
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   1 +
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +
>>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  25 ++
>>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   1 +
>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  16 +-
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  21 +
>>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   8 +
>>  15 files changed, 1407 insertions(+), 99 deletions(-)
>> ---
>> base-commit: 1e9b8055458b92f9ebab6f39d97ade5265a0b012
>> change-id: 20260811-hawi-gpu-05b4ecfc3c4c
>> prerequisite-message-id: 20260923-hawi-dt-post-v1-0-e41473b6298b@oss.qualcomm.com
>> prerequisite-patch-id: 239c169e15da44519b2dad09ecd92f0052757929
>> prerequisite-patch-id: 6c586be864944bb1eed773e8c211b898bb1289fe
>> prerequisite-patch-id: f3d8748ccdb6760563f3e07f701a18388a9408ed
>> prerequisite-patch-id: b1639353868bed10fd3cbfcd01cfb88b7e737ead
>> prerequisite-message-id: 20260922-maili-dts-v1-0-ac2b1b76bfd9@oss.qualcomm.com
>> prerequisite-patch-id: 36f12c16bf9cb0411d8be2f396407c724162189d
>> prerequisite-patch-id: 28ede1ab83d4b5b56423ebb09bae74b6599b3bac
>> prerequisite-patch-id: 6b3e28c55c07bfcdca8bfa9219fa0c6c763c6f6e
>> prerequisite-patch-id: a2007fdaaeaf2981860c54ae5514f5a6f06c6bb3
>> prerequisite-patch-id: af8aa3c630647336bdaeffa9c88de3650f1e49e4
>>
>> Best regards,
>> --
>> Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>

