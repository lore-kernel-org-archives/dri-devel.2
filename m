Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BF7F9D0D2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD8210E61D;
	Tue, 14 Apr 2026 14:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P1kk1sNQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YPeFxenu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DBF10E61D
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:28:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EBSw4I3681515
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d4h/bSO/ywHvkpULu8zqbn2UT6WifoipO/Bcqnz4RFQ=; b=P1kk1sNQ1Kjd16G/
 EsTz/FryVDczRexmWIYsCZFvDTV8xzXxKuijCUvH/c2tM0OwAem2iofOu2LbT6Xl
 m89a5ASsLX+bH9LMO03wejmc/NkqCX4cV14bCownHt/xnKcSUz1QhBG2q/EaAiWs
 bZOu5+k6g4pRycBJobjO4Z0tbvsWiwH4YeC7tvBqWZAy+RrSLn70zu3BMqBQhU1a
 AEmm4jJQDG3NC5vpprDtNLRtRR1HppC02uRRhDNfZ7QEJCgzHaFp0F+niI/HNjVw
 E//1EsAIzE1/ABDKO2lZobp3Q8CmvNPBSrR1BRJPprRe+50D9u4VbUITs+9qXSFR
 ug+l3Q==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d324j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:28:30 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6110e7e82b8so89260137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776176910; x=1776781710;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4h/bSO/ywHvkpULu8zqbn2UT6WifoipO/Bcqnz4RFQ=;
 b=YPeFxenuVBs8blk8AqlLrhrDRiM3w/CfxJzpsKSd0Gdpz1h5f9BpXZzFtvGHJV1YXa
 8wa7oa/lWl0CTOC34EoTI1qps/wycjrnlRcEU8GCZYcfhv89fg0/IklRXGB1zQHmU99G
 hXe4iRGExSZMVRa9ZqiF0ptgJhJVo69bpbrvDm8u9fJ4moF3Ct7qRFBZ2XEGFV1UEDgw
 Ng974KERnAdfw3p2QVvXiXYFAiT2obEe1VNIcx2nbWmcjf+nYe74MN2ZvP32FykQpMj0
 i1W3VeXov6TvZSKasKIHSTLCH/fYspGFIFRs+m8VVT9L0yciumypjpQAlF5QAPQcA+qv
 +Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776176910; x=1776781710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4h/bSO/ywHvkpULu8zqbn2UT6WifoipO/Bcqnz4RFQ=;
 b=d9QryxXZUt+FfvtnhoeUFCWcnfM0R0UQc+Ns6pNuDAzbddk8nhFEhkfuqIiztrzQmV
 aXFlM38TjBSB0+rDgJ+Zi4qxp5tppTXHm+zyxbnFaSEhTu0TgB/sfI0sfFi0kj1qj3Md
 m01vj1cOr/zmnW0dPA7Zcp/CiubeYxstP0/jd67Dr6jJJspDVHgxHlaIxrW4QW2Ha4TG
 Z1pcoM7cpTc1BajluW/Ma+DO/8FqFXpa/8Hic/d7VXYgWHxbsUu9H6lsaq2FNgPG2OBE
 INIuMkiVNMD/v7tg+B2WzINT6GPqzrGoI+P3dnLBUMqGjrcWAXzaFkHsX70nyp21BQgs
 2SnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+DLhny4l3mpS7t/d1WmSI2ULcDZGFGEZLO7ursbtAwaOwNzm703MKau3aUfuUgYfn/7B8Sb/vtko=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxMWESBn7BCN+kejO9f4/JqDWw1UliGURT0w00OeGUwylOuZyK
 I96jFe2SXBAx/9El566YokMYht4LUhj9CO7j06kFH++eMlMwVIwwos9Yh/zotVoSD7c6EAe6xLF
 CobLao4JKv/JCRQSOEcdWiiqwjOZ7AnoK8uTVldkifLtL8uc02058AFYXYDrwKvg1/tozRwM=
X-Gm-Gg: AeBDietAam0CJ36pNAOIj02Ehnn4I+cS0EfAaB3fCwLAgcvH7CCmZwwgRwuUGUrxtwd
 YPbfsgkkSOOj9L640TCTsMEM029s08b7voNf1hfDnasF4RxpGujlVcGS8Vj++boyIeCmnAFJnmZ
 zN6nY9Z/+5ah1A5FSjL3KOD9ipWR1cETV2xMUiQT82/8NwOJ44qOnGjDRQnkou7lxFpL7AQwAT5
 ThjHQi69SC1dNzLHyOT/cH1Kwk/gc8ethc9G7hDpAOfdsAnTiMZgv/IpSmm1/lq9Wkay+KAsR67
 U7/rgPC2PqMIJ0TdV772JoywPAS4b5eeJ5xyF89tXZoUu7gXGBQFg3ZakqMMQoN/5QMlinPIj9/
 rOI6bLGN3NpzmuyEaGWbyOWuoUu9QU9ZNkkUG1LLqru2PiM352d0AYtDhJIWYeXqdQxbhE0e7Y6
 t185Y2JfxWMuyugw==
X-Received: by 2002:a05:6102:31b4:b0:606:2f5:7b49 with SMTP id
 ada2fe7eead31-60a0169097fmr2647061137.7.1776176910067; 
 Tue, 14 Apr 2026 07:28:30 -0700 (PDT)
X-Received: by 2002:a05:6102:31b4:b0:606:2f5:7b49 with SMTP id
 ada2fe7eead31-60a0169097fmr2647051137.7.1776176909545; 
 Tue, 14 Apr 2026 07:28:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9d6dfd76b8sm409854766b.20.2026.04.14.07.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 07:28:28 -0700 (PDT)
Message-ID: <eebff16b-2671-4c7f-9930-dc4b3fa903e1@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 16:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/msm/a6xx: Limit GXPD votes to recovery in A8x
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <df708bd9-466a-4526-ba74-548896b45e74@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzNiBTYWx0ZWRfX/DT7VrVhFZwC
 0CJ7cGcONXZ1s+heVwglqX0Lm2szIYnNbQRbEyfW4TOL7ZYtzBOgCSyylqZOERj8v5AwkKbuZzh
 Nho5+8H/bv9r3mlj65qyz4bJ4/Hw1g+iCocJf9djaRkaN7mXZyvZ4z/0K9+wR3TQcwc+sUcOdWd
 h8BL18caBx3DuHuQ1sN+B0+L3v+VqXRlEoxGvMEddVK2DKE9yejwrT6X1AdfSN1s3yUdO2MbAV1
 Lv2ueklVjDL+RfbcrsSgSTHrpP2wBqNFqG9/j7scnDq2ezefz0gbwO/EGSDe07NjB5De4cJyZIo
 e24G82E+kcEXQh4pNf/eQt3joOp2ihhNXLaNwU3pdUpSn/fLpM8mpuWE4gGbpO/aNiEE2hyNWeB
 s4eS6QNoVWG3V5VGc4QGisgPNH8UNsodAgJ2GuiQSTccyAxnrnQzfCLF3l3i8dALDSaDewsx24z
 vqZTSwuMVZYRFIUFXsw==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69de4f0e cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=NcxxfY7wZcMA6x9h_jEA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 1C5hiNExCExyqoNZWB6pRPgOVKbCtfwh
X-Proofpoint-ORIG-GUID: 1C5hiNExCExyqoNZWB6pRPgOVKbCtfwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140136
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

On 4/7/26 9:16 PM, Akhil P Oommen wrote:
> On 4/7/2026 4:31 PM, Konrad Dybcio wrote:
>> On 4/7/26 11:30 AM, Taniya Das wrote:
>>> From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>
>>> In A8x GPUs, the GX GDSC is moved to a separate block called GXCLKCTL
>>> which is under the GX power domain. Due to the way the support for this
>>> block is implemented in its driver, pm_runtime votes result in a vote on
>>> GX/GMxC/MxC rails from the APPS RSC. This is against the Adreno
>>> architecture which require GMU to be the sole voter of these collapsible
>>> rails on behalf of GPU, except during the GPU/GMU recovery.
>>>
>>> To align with this architectural requirement and to realize the power
>>> benefits of the IFPC feature, remove the GXPD votes during gmu resume
>>> and suspend. And during the recovery sequence, enable/disable the GXPD
>>> along with the 'synced_poweroff' genpd hint to force collapse this GDSC.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> ---
>>
>> Can we simply make this change unconditional on the gen, so as not to
>> maintain 2 separate code paths that try to achieve mostly the same thing?
> 
> We can skip the gdsc vote on A8x because the 'gdsc disable' callback is
> dummy when the synced_poweroff hint is not set. Otherwise, gdsc may get
> disabled during system resume while GMU assumes the ownership. Taniya
> touched upon this point in the cover letter:
> 
> """
> when GX GDSC is managed through the generic GenPD runtime PM
> framework, it can be unintentionally disabled by the OS during system
> resume (resume_noirq/complete phases) or runtime PM suspend paths.
> """

Right, but if we made the GDSC.disable() a dummy on all platforms this
could be done.

On a second thought though, this won't work for gmu_wrapper, so we'd
need two paths either way.

Konrad
