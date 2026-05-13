Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B40BCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D153A10F067;
	Wed, 13 May 2026 20:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmtO8IxW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmRPGCuE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A3110F067
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:55:24 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF3ptg3474757
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rrYm8QbjWl5AnEafqETu9LkNgXLIyRedrjSfKoLJgdE=; b=UmtO8IxWGZ3kLalY
 Pr6TcznHgFU8PGTs6pUnEbDz3iXgvLyQMyrkZFNs37FaainXyiwBYcy6Yq7ifY8+
 nuAAhoOuliqJazxh1c14/aB1PmeuWNPr1aqMnFM7N8mIsdFKJy23SARKiNWVAIdl
 jfRmZiIkwvqnwsK5wCPrCsPYY2sT+AIpkpwOxmxSlqQAkIyq2jxTuCs9Kc1hCizd
 6JvLpwSQxg68tD9J0yeeqE70nMH6p71HCPHutqVS7sMkFrgI62QiGo3tuHQUmpqd
 V4z+kZvtOvVOWqpksFYjynK4mdpySQ4grytiS6janWuvNy4aHrcZ7Ie5UIN5t463
 TmZXHg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p41auxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:55:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3684cb22502so4697403a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778705723; x=1779310523;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rrYm8QbjWl5AnEafqETu9LkNgXLIyRedrjSfKoLJgdE=;
 b=PmRPGCuEvZiq2J1mnR8S6QuGNbPyPLQIihEIRUnQsW0gyPS4A+PGGnOF3cPS2kyWTe
 yAx5y2w55A+7aQK7/U+x3MIEOyMkvSmOtSexLbjr5ZWqk/WwVXnDM9sV0VEdx4NSiMIf
 qH/gvsQlxiTqv9MdglxAY4tWxXzB+VChcZ7odp4trbcHDudQNrwh86Q9m9ZswQUvKNCn
 AKQ0nn0OM+lzmfuVbqp1wTn4pEoyYlMkIEMJkxE/+mokzecwthE3Gq8ZpQ1HfhqQsZ7+
 sbul+wSGSbut5FTpzeQgbivuZ9T63S63RhwVOoQ/v863vmtUTl9q7RO+jzOdb208bbbm
 IDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705723; x=1779310523;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrYm8QbjWl5AnEafqETu9LkNgXLIyRedrjSfKoLJgdE=;
 b=RijjDQhiHmxnuAli8KGPCOO2Fqmeduzaf/U2RHl3rDhb+25aEdPZB5HIOyPakD5nl0
 4YfFLaTmZH6dwFXwKcb4ZBWciagMuufj8/tPMEaTFYvTd2H2nxH6Y6txgEl/7+V28Uc8
 qPV5NBnICiy0YzHtMbyjxhiihzIrQynXmbuxUomR/t1Yc6pzI3DMfRBwGAG753kTjdSH
 EYuyvXzv3ghl/oM7i8qg0QEMS89N15KsdmybsKiR8nD/gMjF+b7qsUlbh4n4Hm2Fj3/o
 yRveh+fs2BXuvsiAYNmeURzyRZ5z9l+IoNBBdpsvMfUQFZqGW0BbfDaZ5Hb7WXUQoEx4
 nHMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oxrht0UADVR8MelS4T4H8OsOfaw47pojKDMtcxvrPBE+K3mNKz4ErmDHNspDqVrcuLq6AuvTcrk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpNQjLhnSka4SLgg115I3CZNu7JMRBSe9VcqbHSXg+wYEMV3j8
 DvzLFQG7x3UOHYBMcIkilt3S69l2TzAqEbFgOSciHgudtrV2myokTSYYDQBuJi7GBcwx59p6lZj
 kdspGexNOrOG4ZKRB2oyMipn3RFCZoHN7gvGYJrIoDvK1G2f2INZmiIG35lN+WcdwDQN5vFA=
X-Gm-Gg: Acq92OGECtz+YCAyTb5vAvuH0n9pkfAwDYIDbcFA/sAa/+plSfIoTK3PRF6A7p8Sc4q
 47/H4JKIoZ2p46peFB2tVdfQXUu3Uk+MPvI2FtsF1g3r3AwZJjgN+S/nnp3RVV3XuebYxHtCIi6
 EqMGNz0+y598OhYt6gUEO9Y7rsslafei2WJuDFa0fo7LPIOoGKbZeHdyMANztG7eMbwmsgPMTNz
 I/P3+EqKp93QLvJzSqmxK8B1fFf/YBzV6QGRut7cn/d+FixnZgInFRXwqkTGMhzVhbbZ/uZVEDg
 rYqvDxRF4aZR95m5bnWa3BXDvPoj5ug5d2dn/1ZDWqf65OsqNmAe5rf9ZDR37sJ5YzshYHvHezt
 rzcnx5pAfdCDRU5Oi7y/CgqKaK+s06YFxoYGgjHuhX8G90o9SUmZzJqg=
X-Received: by 2002:a17:90b:3ec1:b0:368:147b:536a with SMTP id
 98e67ed59e1d1-368f3c151e3mr5189495a91.14.1778705722866; 
 Wed, 13 May 2026 13:55:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec1:b0:368:147b:536a with SMTP id
 98e67ed59e1d1-368f3c151e3mr5189471a91.14.1778705722385; 
 Wed, 13 May 2026 13:55:22 -0700 (PDT)
Received: from [192.168.1.6] ([106.222.229.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3692da0fdf1sm192484a91.0.2026.05.13.13.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 13:55:22 -0700 (PDT)
Message-ID: <7cad2dd7-b401-4d1b-8f16-79458b563986@oss.qualcomm.com>
Date: Thu, 14 May 2026 02:25:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 2/7] dt-bindings: display/msm/gpu: Document A810 GPU
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260502-adreno-810-v5-0-bc9fd2bb788d@pm.me>
 <20260502-adreno-810-v5-2-bc9fd2bb788d@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260502-adreno-810-v5-2-bc9fd2bb788d@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a04e53b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nm1BsBjGsf7C+PoY3QnOXg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=M943YIVedLBdXAjs6fsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwNiBTYWx0ZWRfX0764xSjjA1Rk
 K5Waqvg1QllSEdCTgahaYQpllMEIkbF4q/xcbxyYptJqopf/+nN/bY1VsJpTfto8X7FOtVPbYY0
 P+Mf2qAkniCKSOpOiJFL1MF8YE420yDpm0Y0ob8hocMxLObblBT3AXPsqtP2ck0kz253kWHbP4w
 6d3Rd568xYkbbaqFfRt58Y4o1xOtm5MQy5U4ULzlsCkbSbHkrDQWln0EY6sQLyb1N5LKbYU0W9h
 8QkjcEVBMGh+P4thOIppPkylk+NRIxCRoE03AXVWb6SifHKI+VZu3WTBjHZ40KyV8FUCVP8miPd
 N8MCfcyQGwcvYMXLCtyQoDCrqQJmBMNK2DIOYKfei11Xx/UVdHmlH9iO/eIIr3aZki3sYrVrphD
 I0AH//T7uovxyovkAs3xeJvPvNUp/J3qlr2qw3p3ctXj+DQpcmB+/LVBY0rGf9U+CIgP4XPyGMh
 HaQH5zjOJKw86VMTz2w==
X-Proofpoint-GUID: LDgaUD-0mDDD8am5SYp5kDVXW8jZvrng
X-Proofpoint-ORIG-GUID: LDgaUD-0mDDD8am5SYp5kDVXW8jZvrng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130206
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

On 5/2/2026 1:37 PM, Alexander Koskovich wrote:
> Document the GPU compatible string used for the Adreno 810.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index 04b2328903ca..1875a3b9f688 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -434,6 +434,7 @@ allOf:
>                - qcom,adreno-43050a01
>                - qcom,adreno-43050c01
>                - qcom,adreno-43051401
> +              - qcom,adreno-44010000

Please add contraints for reg list like here:
https://lore.kernel.org/lkml/20260513-glymur-gpu-dt-v4-2-f83832c3bc9a@oss.qualcomm.com/

-Akhil.

>  
>      then: # Starting with A6xx, the clocks are usually defined in the GMU node
>        properties:
> 

