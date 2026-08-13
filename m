Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6F3C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EE710F1CE;
	Thu, 13 Aug 2026 07:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WINtlxai";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LlBtdd5k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E61410F1DC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5gAdl1874671
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rQDbfdUN+IyLcTMW/cXFburEFTlhuo3IDuFHy2Cp+I0=; b=WINtlxaiEPxBdINV
 RjV/6G0okpXR/cNMdHwFtRLdmIMluUIEGulmVO88UR8RVQnYIqkpZbkZzAl0475I
 ZB/Z3kPSf+0FKdIMqG7SvCQ6xRDr6VuKx6/Z89oKELFVqGTaZM6F22ih8lo0cTMU
 dBxI9BTY7+xGU8IXp1On5Ntrhfg+0N3z+XYgM1wRkTYt2h0mQRsYKz5X58fcfVat
 r6Oho6qA1Q0ZryMAZCKN3HaONBWhIWg+v4p8SUeo33by+Dlsmfhet91kcoDzG2vm
 oAFE1ZMEjO+9fLMvO33FwOeVWb9OwSPKcQlhgebbTya9MYajLskAuBx8X59Q0Dah
 HYLuiw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g11ashvm7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:06 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f0ed4fe79aso8779796d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786607104; x=1787211904;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rQDbfdUN+IyLcTMW/cXFburEFTlhuo3IDuFHy2Cp+I0=;
 b=LlBtdd5k6rJ/lnlf6vxt0w3oQlqqQ2f68hGCn4L9O6tuOc5RVK2C4ZVFWZQdrcvA8k
 cMrCezQrzVYYW3gPgwtwuDcmEnqzj2RJn1uHlsvD07iAhY+YGWokgRVQccWu2q8/O+mN
 vAG5mFr3DUfidTjZvKV/8UdbO3qyIZyEwodXKUop8x9pBIQ5l+REjaWEOu/mrkRKN+uQ
 tfGDOPIwymOj2CFYIsExBKE1Gqo14h3Y8IiEezN0gpqHIbjgo+oCHx3/54TMyzDArbpS
 azOr4ilndWSAqrlIaWHDKcsCYWspUiAmaeiqr7INWh09Be9BD2y8uno5XSOv9VC0c0xM
 jDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607104; x=1787211904;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQDbfdUN+IyLcTMW/cXFburEFTlhuo3IDuFHy2Cp+I0=;
 b=Wnh/gCxuokVSZyhQWUwnrqGTLLPeSBU7S0tuG9YwTh686ilU6ICzHy0vHKpjkhPoU5
 Z/VHqdvyPzCdE9hSKdM2ghdQBs5FfWeOgCkw3/RBM0hhTDxUvkWkBD8R5+X97vg8lZir
 9MSN93LGbxL1Dyxb/IBo4+AVSqxHrUFmr/nscu0BbmSAFAlvkNfaMOFO0J37CGXjnMRj
 OP1n8G8CMpFU8CIHKibZDt0uyUgR+74BQ7ipi0q5zWsiZ8A1ba548w+QS7/WFZflZCo9
 GGuhxH/K3D3h6LgJ6x2naWh1s11RccpePNX7SvVPWQumfWNkDQqkEk5S3SLbm4+IDf5f
 MU+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNDaaI+VlUx5LSM3in4XQ/rSxvHN4FIyY1BJDZn8IVO6oyOzg8jG2jNNdyXXB9sUQrT4rvsmU6/lo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZjVgFoDsAQlLCCQrWLm1JcAobMknN0P/51CeeG8TyZrAtimKQ
 CFKgPOTuAHizrl9r8sFcTvNgSKJ5VmbKpKR1ZiuvxEW/SmO7ApnZk8V0EfMiIw37zzSDQaOD56O
 /X/OILnIio2qDZ/ONUNb+aGrdJtnUvFbeM5Elg6b2A7HvSoag/DV+YuuQWrQqpgc5roah9nI=
X-Gm-Gg: AR+sD114XADAgnomAaqb7Ku7w6Py0d77rO79s8snZfv0CVldefhVAwhb2w6odWX0u1J
 lh7BwdpPQX/wvLNOh0Gk2CEvAB8pyPgSzYop+XBSoBz/awBT9NFf0oX7nB+xYvSOfirw9iYTS8M
 D62AxA2HaBs9zz7AgiZKu2nyPIFLwk8eE7fb1LR55U6avcDzV0q6LKrGOVoVTIEIGwswiSPoNFX
 8eb6e1ugPMISEFVBvms+DGFD+T847mWKKETnuoxktb3DF1J0xqGdyplQPxvEUAlmjFnBfn+Pxio
 kMoqISQKLRYKsIW/CjEggtffWv7MKRVGpUUFX6iFHI6WEXQgxOzGqBAftjKN4YNcl+yH8PdyXH8
 U1vbHsvrnoeGCCWWjP5aopJbaahOX+16YzkYCZaUR8wGXTXs8OyKfx/+DnRqlxBfO
X-Received: by 2002:a05:6214:1301:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-90a8092ee22mr36705116d6.0.1786607103921; 
 Thu, 13 Aug 2026 00:45:03 -0700 (PDT)
X-Received: by 2002:a05:6214:1301:b0:8ca:f47:25ea with SMTP id
 6a1803df08f44-90a8092ee22mr36704696d6.0.1786607103539; 
 Thu, 13 Aug 2026 00:45:03 -0700 (PDT)
Received: from [10.111.164.29] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a8179e4fasm9733956d6.2.2026.08.13.00.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 00:45:02 -0700 (PDT)
Message-ID: <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 15:44:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EujiaycA c=1 sm=1 tr=0 ts=6a7d7602 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=TWG_K1dlhuyH_i5ZZ2cA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX97VmmN41h5iT
 2YkCssyRVvh6vpcoq3Fg2tQDCJLy6xg+q7fjGxjRB4rJMhWD0WL5wS9rTZ1kpF59VGSsPubfZli
 +cOKJNVmrTPf7P0KkUGY26VHAgP8HSnplUneSByyzdfkgITggQJEaAP1GOEVYo48tbBUJNpbbWx
 JKyHSxyL+NwftMU21ZtbbnvYIeVniqdJvwcF47UMVOLhfTq3LDzhWuABmdipFXp7UtXENOHxsNu
 5FsprDB8eId8YNQucvEu8lqRnpk40OSB8jssyyNcZtgb96t3Xt7dJBItfRD5ZVwFryGkuDAFcLb
 KqkdlSXm2J3ww5g5WC53JrYrs9sIPfgHX/s2J+GfJlaEDxDoOH/q/Le0CEN4bTqmhHYpnQgoN0g
 mKifsDvhsqtyxopk1UaaisYR5QlsptMLJJTsDdQkWc5UqjKcBO+Gx/agRZLSDZ0rx+ChvDB1kuM
 vegn8bNNQK8XUbv/DbQ==
X-Proofpoint-GUID: G91rDGv2Wlj9foWK6JW5cA_pN7N9toLc
X-Proofpoint-ORIG-GUID: G91rDGv2Wlj9foWK6JW5cA_pN7N9toLc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX2xB16uzcyocE
 3Ac6d4loGkVyCr78m2lpQjok0bNMOUn4Vw4/lD+Yug8ej4SjGaJludEBHunLXqKgXxveK+lH4Zx
 arYhxBosQxFZeVwLWjoreX2YktDpDHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130052
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



On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>> Kaanapali (SM8750) and Glymur use two display power domains.
>> CORE_GDSC powers the main display hardware while INT2_GDSC
>> powers a subset of SSPP blocks.
> 
> Can they operate independently? Does INT2_GDSC need to be
> powered on after CORE_GDSC?
> 
On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should 
generally track the same state, except that INT2_GDSC may be powered 
down when SSPP1 (VIG2/VIG3/DMA5) is unused.
    - CORE off, INT2 off
     - CORE on,  INT2 off
     - CORE on,  INT2 on
> If so, perhaps changing the clock driver to make CORE a parent
> of INT2 could be the simpler solution
> 
> Konrad
That would still need DT and binding changes -- DPU has to reference 
INT2_GDSC directly to gate it independently, so it can't be hidden in 
the clock driver. The two GDSCs have independent GDSCR registers with no 
HW-enforced sequencing, so they appear to be peers rather than parent/child.
