Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C76BC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C824710E7F5;
	Mon, 17 Aug 2026 14:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DYGyarDy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lv0DORV8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF85710E7F6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:12:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HD643b1995004
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P6EJqjf/ZpjAHqfRtSteItluHMK97of1aYhfzczi1y4=; b=DYGyarDypd/DVrKh
 JgtV8dWBq+DC62RIAJWVyE5ZX/xfrd2rAaXQE8UX7BQ9cuRATgNLnAmno3TIQ7nM
 VtUEoX05NgcbbHCh0Flky0ir+y6ZOd1jKMhpuyluR6TOXl3EO7tZU6LjOSVVtCp1
 xCob9W/Hl61UIeXox6tjaJvCxxA6GLaLUrqf1tJ7IoCTYTPf2Q4+lfKQZEz0CZHF
 5vdU4mZY/4LL4ZwevfNUm/F3be767vUW6sX6WeKS4JxvGBC77AfDX9s1i2J48Oer
 o4OPxM0ghRjWpYUkAPXZGSunpdxEjuzkcwjA81w6/M4FPFdnEZHN9XW01EbT4Cu5
 O3CDrw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1hd2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:12:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92eebb130dcso31508585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786975977; x=1787580777;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P6EJqjf/ZpjAHqfRtSteItluHMK97of1aYhfzczi1y4=;
 b=Lv0DORV8Qfa50/FO8UihFspaXx/uIBcgND80tcpoLa715Ac9rlrb6RENdo4Uw3isPj
 K0piTaPdJGDqWYv01SnxKBzwt2Oe0fT8WberR8cNO3jS9+czJ6xMC/gj7yXLwr2MZct8
 lDhKIzMqLVkKRwfTrORnQe/vxUEa4GnPzP5OB/RcNDK+qxJKSVgxSYRdfMNsusd1bQsP
 2aW+4ZXzQGpJ/UN9jjoTl0u4tPXz1IaLUcKdr4ubW/7uOs+EtvBkdYFERAV1JfOLaELr
 sfFyARA6IlxWbfljcrKz1rZBdSlTdD+K3Kb06s0pde6BV/I204T123yUb/GhAg+U2PlE
 kJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786975977; x=1787580777;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P6EJqjf/ZpjAHqfRtSteItluHMK97of1aYhfzczi1y4=;
 b=g1ot+DTC5nFg/1ViCtJ5YPgIX9sfYRRaE693RMi6rmhv428l5UDu4syZxT9dZZTJIw
 Gb8qM6pp1pxX8uxhOumSDlfgHh9QSTU8rHPIbjKIbOLvEQbx8Se/I0xrZMmDQLNWVwy5
 N3DiiASqpYgMiH5Bd9kAz4alBWiczD1hf8Z0cfk46lGr7iQxjEUcOJVmsuAmQUGhb/h0
 6q/5z2ynPVcvci6hleWo/fTvun+qVRoSOlueEtR8KK5IU52IfX/sBtYI3nmLBkxLsczH
 gwR6fLe0+4N2gsdqbfaXfcSHBXgQFavElJ6saxW/QLEngDdubFySeiaVbujL/dsn1hvH
 o0ZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2kXDbxCW4xsNI82CIXV6vq3y95YRAibs17DLIATzYnNzEq6MtbhDfBt+J5RiSMAXcjVkNlI5ljKE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOzRlpT/BMxyCvp1WwgxI5lnuZbUllEojwy0ZYlgCtB2n639+Y
 5RMo2lveUXhz+n26EmrLu1d2sHO7YEPfU8nschXTK5wTzGvoNO7Abw6VFbcQuWk/jeO4tD4tq+p
 6ZOrovC5+gwEXqvZFf+Fmez9lECZOCCelmfMIBbYhHJ7ZXK6VgT+0eVydfE5LoED7CephZF0=
X-Gm-Gg: AR+sD13ZTTOYMk3iu23qSPjc7U4QlIHcuFHEaceUW9IcQly8WRdHkD+FXw4zErylbuM
 7I87kxVSPIO7ELx+AT//izICUP59dR0vuN4X7/LKFAqZvfk40NRsLZ7IBSwt/ovbNFMcyoA/3Nz
 jkm67h06TZfFsnfvmy8Qvup3lZA8P+/v+2LcJtxtlbnGhdl0DAQaIVfM2no4vQDRTGccJNWI7kq
 W+y3WuO9s9BG/fsRjkYTQhLUvy3FyVv5+PVzSjOhy6rZwHHwySD5x0zMCPJAfrRcrN0ym3xYwD/
 WFZDjY4rvepJX3bPu7Af19SqR1usFrcuAsLgCSRwQcbu65rRPMgchoS3CPBsTSjM2KbMe7AVWUa
 VA29iLvF+YYisMjb8uArldcHg
X-Received: by 2002:a05:620a:454b:b0:936:5a34:7a6a with SMTP id
 af79cd13be357-936d237abbbmr1883533585a.3.1786975977154; 
 Mon, 17 Aug 2026 07:12:57 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:936:5a34:7a6a with SMTP id
 af79cd13be357-936d237abbbmr1883523085a.3.1786975976586; 
 Mon, 17 Aug 2026 07:12:56 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3d8596d4csm718864a12.22.2026.08.17.07.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 07:12:54 -0700 (PDT)
Message-ID: <53a32af5-daa8-4a11-86c9-10b1fbf01566@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
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
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a8316ea cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=HZuXiAIfS_KyvvDLycUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: W597dFIhZ_Imzv7UD9dXPjAZrQFf-gbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwOSBTYWx0ZWRfX5V/Ik+5h4YNZ
 wU3kvaDJRiOSCZkiSQ1rgdn8J7VDO2JUJiZSIifKBJWewK1casX1CMOarddXexgN3bc+PLjy0bS
 UfR8NcV68zmuOzkpHyG01XkIdX2SWZo0QYL+a/9G8Pa/A9v168Q4n2TStV4AYdQBMT1GqL11lVg
 wp95uHiKgDJbQWiqmqGUN1T8GocwpdRPov72jk/EHgGeUA/iooD1J8sYGTlrD//dLnbN4KGiCxd
 SiEwMyXsYbazPnmX2350TFuUrni4pTLISS9T4HhTN2rn94JHyrVLbN1/6MB+oT67Yh4BwvdPCYU
 zdw3vb4vk4NgkXp4H+EvAWwFyAQy7tpwJ7KiY/jE0JtbfKXOIkel2StkC3xubXBC8GUwsj5N8zN
 Mqo+1sJZLplGloPQYkENb/c+C1jXPbtIWeVK+A5uAb96kB3qcduP/CzZZ+iHUNPt6GxgjiOuwsw
 zp7OK/t6eDNRygrHB6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwOSBTYWx0ZWRfX1wBMcrNIWhw9
 OoQbUyw39x7Q8ArL2BYHdw6PiXmOpc/uEH8JHPAlQFOfw5bBIGik6fcqlK+8L8yQozh8pDNxwMM
 Xlbb3ixGuZCQQ5t6k+tBGAnPcePN9QY=
X-Proofpoint-ORIG-GUID: W597dFIhZ_Imzv7UD9dXPjAZrQFf-gbw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170109
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

On 8/13/26 9:44 AM, Yongxing Mou wrote:
> 
> 
> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>> powers a subset of SSPP blocks.
>>
>> Can they operate independently? Does INT2_GDSC need to be
>> powered on after CORE_GDSC?
>>
> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
>    - CORE off, INT2 off
>     - CORE on,  INT2 off
>     - CORE on,  INT2 on
>> If so, perhaps changing the clock driver to make CORE a parent
>> of INT2 could be the simpler solution
>>
>> Konrad
> That would still need DT and binding changes -- DPU has to reference INT2_GDSC directly to gate it independently, so it can't be hidden in the clock driver. The two GDSCs have independent GDSCR registers with no HW-enforced sequencing, so they appear to be peers rather than parent/child.

No, if that was a reasonable change (which I don't know if it is), the
genpd core would take care of enabling the parent before the child, since
the genpds are intrinsically hierarchical

Konrad
