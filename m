Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D5BC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77ED710E28E;
	Fri, 25 Sep 2026 19:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R9deWuCc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/6jHD4L";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4414310E28E
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:59:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIo86K1733218
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BoGtlFMrTCZDnWzopkng0s/Kflr9jZ0FN5wZjUl38mw=; b=R9deWuCcVazo/u9o
 p8DlRF3ME8neof4XV7bS5GYW8MCsYiq8HqQBCLUe0eQTstEcpRcVh+BQGLvaCTcT
 KbyfCuXa/wCdO2SR+n6Rkwjrjhw2QuN/k3zbAsq5wpM+2hMHCBb1hKO1YZtyW6PV
 t5ZvwQQVkSh8CnZikDsOs5g5uVIjGXmKeGkWNSs6T03P2YYauG+eadvOzdQLoWEW
 6CIaS6vG4vu31mwkS14W3y3cAcTfLcXR6k4ItwjJ+3e/bKYlGSExF4EXG3BCG+Kw
 lDlGLw1/Pj+ZsGnxMBiYk6HQTb+5ulrrefltrm/44J9lHVcY+ixDx7ukwVqNxAFA
 z80R8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnt35r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:59:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2052975eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790366348; x=1790971148;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BoGtlFMrTCZDnWzopkng0s/Kflr9jZ0FN5wZjUl38mw=;
 b=V/6jHD4Lpg1He6LsBaEAU+nu4YxQbEUbDUn+3hr+TvidCEBLreJCSyZFhDHcv48GXs
 b7orOu8+DUV5J9ZY4QYbPizxiK0MBnmCYv2kp2IWpwAoQGuad61Oex48pJF5Yzll+iqD
 /Uw/uwbhJzbYT1sfDPbpDJ7d/BySwHg2sckbUTjarJBOxlvK7AREzcaUWLjB1lMMoU3h
 MtIIFbRgI1FM0d6vCtlaJFvdQui/TP7Rh0M8BnTANCcDxtp/VGx1quQtfVYksJa19dtV
 R/tw8diFIlcNzNqPQ0z4Zc89egkKVJbE3Jo16ZZwE0ylEqcs/+J/TGA00TPX7PK7LGIY
 RLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790366348; x=1790971148;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BoGtlFMrTCZDnWzopkng0s/Kflr9jZ0FN5wZjUl38mw=;
 b=CtODEeo+6S20xS4/5EhdY5MAWKHMZtZ1s/+RGDbzAUtXpD/z7u7so5oRzONbeBldDZ
 rfcrEOMlEyNRWT1am6GIl1O1XcZar0EWHXJJWbFABt1ZNT2G7UGQlT9wHpEVenqI62ry
 Xln/1goIvNZDBxTad4Q+Wkyx0hfMIuzy3avU28uSgz4UQS1VDjY5Dc80JKvEE2KmeE/K
 opf8RANBI8vDcA9CPCFyPICfacESTojKvkJ8wCzn1hulJhM/gAhei/ts3oNOKzr5luVu
 6ONQTo1xGbDDEKDVk9cxreqdhxkMzpDzGbNlS3xLgr6ngI1aa0upo85wO3OXzkx8f40i
 UE7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsfqT33t/HOVcxiXN+wUmcO9zt0Tt2Io3s2f/PckQlD/JiBqLdvEo7Uqy2Oyh/ccOfJW5KXRp1VVA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ne/7H9LtFbCJBKLORoSsG2UIv3oPpalw3VfTkUH/VfFesUdA0o
 U2qgKx4cghH7FsKUzO8nyNorCq1zD7LvmI55P6oRHMjWodcVCUfYqkd2a2eWSuDpaNCJoInucJ1
 qHpQOTLSVNjjMYUwEOPz+0hCgmsTsQ1Qv/a2zualibDga0igYOFnBA/70feV06sDt/IkFuWw=
X-Gm-Gg: AYBFou2Jzmfuyr6SsEsGufyUjp+lNlD6suVLzsJo8No+LiMaAgeN8RsBGIV2TOvhcHX
 k0W0hWEs5pU5XrpCFrA2aQ3vfphGqj5/l4lWTosMiFJumZObbsFmNYaCPXZgchLWaVQIw0kDu26
 tCRrnS9gX2zybzk3DW6JNUNH2BE9TnvYHleGplAKWZwG2elR8rfc/EyFDlff3KVKacIhRWxLYyg
 lo90Q2LA+rRA0sVgZQJwp/z4YCdWO8AvpOBui7fDVvM4uOo1/6XEqSAaYdRb6ZqrQSz1j4QwhUU
 yRpiLkVBPSvOlCfedB21Vbgza79sqNuSSMLK34Q6Qn5u3AXjP/HZI+GhnKNbYwvtooZJgXFVFFe
 /Dw0DoHnG/Mf8rcQZflgl1UJ2
X-Received: by 2002:a05:7301:1442:b0:342:5966:7626 with SMTP id
 5a478bee46e88-34271d8d2c2mr922089eec.25.1790366347578; 
 Fri, 25 Sep 2026 12:59:07 -0700 (PDT)
X-Received: by 2002:a05:7301:1442:b0:342:5966:7626 with SMTP id
 5a478bee46e88-34271d8d2c2mr922062eec.25.1790366346939; 
 Fri, 25 Sep 2026 12:59:06 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34145c17074sm7137779eec.26.2026.09.25.12.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 12:59:06 -0700 (PDT)
Message-ID: <761386ae-f1e5-4892-ac18-b450a803a433@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 01:28:57 +0530
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
 <692ff69a-330e-40db-bffc-a53987fa4bce@oss.qualcomm.com>
 <CACu1E7FuCVhu_0gKmVVeBL=e4=zghvXJT=mZVfg8UjUzRrv3Yw@mail.gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <CACu1E7FuCVhu_0gKmVVeBL=e4=zghvXJT=mZVfg8UjUzRrv3Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kAjWA839W0lKV6lmc-jyBIYGKrd24q77
X-Proofpoint-GUID: kAjWA839W0lKV6lmc-jyBIYGKrd24q77
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OSBTYWx0ZWRfX5xM/xJtV43LG
 hHjIEdhenhWtNcoUOfWnRtCV8ss8Y3fFMFV6qRSE663IldBqGxymqkI6uMZmWkVPCeJ1A9y8EjY
 uEusCRGuWdwBNQjHujKZW8qY48WaRNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OSBTYWx0ZWRfX6/qDNKk/Icwl
 VbEnMY87yb8Jy8oiWPgkw/hICE03RoebVirPFiUAkBAfNlHN1xbrziKJthesPzb2AMBpxVel5nR
 RANCu01t/MvfcoBAxhilz/BH/YqcbuJBjj7pw9x46LexxlrOLQlv06mG4mBQUqV3UK3sLY+K4pC
 cqT2HHW+OYJ5+mLb4N5UC1Aol1IiuZD5WxzvdiwX0Na8pwYyPW3y8s2ty7hu6cHv8H40bHzhw+i
 DIs04lssCMWe+HjMwUiqCG3KJP40Tbl5WGQQjgtfUX6sD723sh/M+733Y1sSZYcWDF0B8y2rp0E
 iNJbVerDYtJpRqMg1aWmG95pWugas6yZlPeMXUea/f2GhTkwvyj30qkKp2obUesibBCtrOeEKDA
 7CZPCLEzUlbu6/T5l0/InXYpZQ7pCmBBamQkzDsNHA0DqH7paVvWAVZu016STHtlqg0DGHJ7eg4
 8egcA+37LJJGhO8Zyng==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6d28c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=tVI0ZWmoAAAA:8 a=MmXTpdYTAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8
 a=HOaGrLfzmr4yaBHx-_YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=fsdK_YakeE02zTmptMdW:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=7hoCnnChfAR1N-e-f1W3:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250079
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



On 9/24/2026 7:36 PM, Connor Abbott wrote:
> On Thu, Sep 24, 2026 at 9:41 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 9/24/2026 12:54 AM, Connor Abbott wrote:
>>> On Wed, Sep 23, 2026 at 6:26 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>>>
>>>> Adreno 850 is the next generation of A8x GPU present in Hawi SoC. It shares
>>>> the ADRENO_8XX_GEN2 family and slice architecture with A840, but has many
>>>> architectural improvements. There is a new block Matrix core (MALU) which
>>>> helps to accelerate certain compute workloads. Also, there is a new Bx rail
>>>> that powes a part of the GPU IP. GMU is now powered by a dedicated GDSC
>>>> powered by MxG rail.
>>>
>>> If there is a dedicated rail for GMU, then
>>> VK_KHR_calibrated_timestamps is likely broken, assuming that the GMU
>>> AO counter is on this rail. The AO offset logic in kgsl probably needs
>>> to be ported here. Has this been tested?
>>
>> Not sure how GMU core's power domain affect the AO timer. Could you please point
>> me to the AO offset related change in KGSL? I will check.
> 
> Previously the GMU AO counter was part of CX, which is kept on by
> other things in the system, so it continues to tick even if the GPU is
> suspended. However kgsl does not rely on that, and recalibrates the
> GMU AO timer whenever booting the GMU [1], which we currently don't

KGSL doesn't do that during every resume. KGSL recalibrates it only after a
system suspend. The AO counter is still in CX MISC which is under CX domain.
So it should not be affected in Hawi.

-Akhil.

> do. I don't know if the timer is still part of CX, but if not, then
> this part of kgsl could become load-bearing in a way it wasn't before.
> It seems possible that it isn't part of CX anymore, given your
> description that GMU and other things have been moved to new
> GPU-specific power domains.
> 
> Connor
> 
> [1] https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.16.0.r14-rel/adreno_gen8.c?ref_type=heads#L917

> 
>>
>> -Akhil.
>>>
>>> Connor
>>>
>>>>
>>>> Maili GPU (Adreno 845) is very similar to A850, except that it doesn't
>>>> have the MALU block.
>>>>
>>>> We will post the Mesa support and linux-firmware support soon. MALU support
>>>> will be brought in separately along with its support in Mesa.
>>>>
>>>> As there is no display support available for Hawi/Maili, validated offscreen
>>>> testcases that render basic triangles, glmark2-offscreen etc.
>>>>
>>>> The driver/dt-binding patches are for Rob to pickup and the DT patches
>>>> are for Bjorn.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>> To: Rob Clark <robin.clark@oss.qualcomm.com>
>>>> To: Sean Paul <sean@poorly.run>
>>>> To: Konrad Dybcio <konradybcio@kernel.org>
>>>> To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> To: Dmitry Baryshkov <lumag@kernel.org>
>>>> To: Abhinav Kumar <abhinav.kumar@linux.dev>
>>>> To: Jessica Zhang <jesszhan0024@gmail.com>
>>>> To: Marijn Suijten <marijn.suijten@somainline.org>
>>>> To: David Airlie <airlied@gmail.com>
>>>> To: Simona Vetter <simona@ffwll.ch>
>>>> To: Jordan Crouse <jordan@cosmicpenguin.net>
>>>> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>> To: Maxime Ripard <mripard@kernel.org>
>>>> To: Thomas Zimmermann <tzimmermann@suse.de>
>>>> To: Rob Herring <robh@kernel.org>
>>>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>>> To: Conor Dooley <conor+dt@kernel.org>
>>>> To: Bjorn Andersson <andersson@kernel.org>
>>>> Cc: linux-arm-msm@vger.kernel.org
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> Cc: freedreno@lists.freedesktop.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: devicetree@vger.kernel.org
>>>>
>>>> ---
>>>> Akhil P Oommen (11):
>>>>       drm/msm/a6xx: Honor perfmode_bw threshold on A8x
>>>>       drm/msm/a6xx: Fix secondary rail vote in ARC votes
>>>>       drm/msm/a6xx: Fix RPMH dependency votes
>>>>       drm/msm/a6xx: Factor out RPMh arc-vote helpers
>>>>       drm/msm/a6xx: Add BX rail support to GMU dependency votes
>>>>       drm/msm/a6xx: Clamp MX dependency vote
>>>>       drm/msm/a8xx: Add Adreno 850 support
>>>>       drm/msm/a6xx: Send THINMEM config to GMU for A850
>>>>       dt-bindings: display/msm: Document A850 GPU and GMU
>>>>       arm64: dts: qcom: hawi: Add GPU support
>>>>       arm64: dts: qcom: hawi-mtp: Enable GPU
>>>>
>>>> Bhaskar Reddy Valluru (4):
>>>>       drm/msm/a8xx: Add Adreno 845 support
>>>>       dt-bindings: display/msm: Document A845 GPU and GMU
>>>>       arm64: dts: qcom: maili: Add GPU support
>>>>       arm64: dts: qcom: maili-mtp: Enable GPU
>>>>
>>>>  .../devicetree/bindings/display/msm/gmu.yaml       |  90 ++++-
>>>>  .../devicetree/bindings/display/msm/gpu.yaml       |   4 +
>>>>  arch/arm64/boot/dts/qcom/hawi-mtp.dts              |   8 +
>>>>  arch/arm64/boot/dts/qcom/hawi.dtsi                 | 336 ++++++++++++++++
>>>>  arch/arm64/boot/dts/qcom/maili-mtp.dts             |   8 +
>>>>  arch/arm64/boot/dts/qcom/maili.dtsi                | 309 ++++++++++++++
>>>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 446 +++++++++++++++++++++
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 231 +++++++----
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   1 +
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +
>>>>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  25 ++
>>>>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   1 +
>>>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  16 +-
>>>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  21 +
>>>>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   8 +
>>>>  15 files changed, 1407 insertions(+), 99 deletions(-)
>>>> ---
>>>> base-commit: 1e9b8055458b92f9ebab6f39d97ade5265a0b012
>>>> change-id: 20260811-hawi-gpu-05b4ecfc3c4c
>>>> prerequisite-message-id: 20260923-hawi-dt-post-v1-0-e41473b6298b@oss.qualcomm.com
>>>> prerequisite-patch-id: 239c169e15da44519b2dad09ecd92f0052757929
>>>> prerequisite-patch-id: 6c586be864944bb1eed773e8c211b898bb1289fe
>>>> prerequisite-patch-id: f3d8748ccdb6760563f3e07f701a18388a9408ed
>>>> prerequisite-patch-id: b1639353868bed10fd3cbfcd01cfb88b7e737ead
>>>> prerequisite-message-id: 20260922-maili-dts-v1-0-ac2b1b76bfd9@oss.qualcomm.com
>>>> prerequisite-patch-id: 36f12c16bf9cb0411d8be2f396407c724162189d
>>>> prerequisite-patch-id: 28ede1ab83d4b5b56423ebb09bae74b6599b3bac
>>>> prerequisite-patch-id: 6b3e28c55c07bfcdca8bfa9219fa0c6c763c6f6e
>>>> prerequisite-patch-id: a2007fdaaeaf2981860c54ae5514f5a6f06c6bb3
>>>> prerequisite-patch-id: af8aa3c630647336bdaeffa9c88de3650f1e49e4
>>>>
>>>> Best regards,
>>>> --
>>>> Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>
>>

