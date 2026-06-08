Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FFECD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D5410F171;
	Mon,  8 Jun 2026 10:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xh/NHPl8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SYqPnPNO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BBE10F171
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:40:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586PkLW2733114
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 10:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tveSNRQ+h6fN2eRH75FNEmJTO0yYAeUsEKQ0M1WDmbc=; b=Xh/NHPl8SuBYxP6X
 caNzrzGEU4RACsw9uhw+2TwPnuajGd9102JDEiZeiZ7bucvwXPV1rRBsQ3CzdHUf
 n5RFO7d3CvX3uTOIqyVgWNQEVCwDDkJ9JeGeI9Xc/oU0wr3eehmyRA+k5ssidZS9
 UmzCA5I1RCChgGLmbFMoXEbvWNmZKgHzVFlGCHaO3owwK+fTGK4Yaz8HqyXP6V9p
 KIpvWBLYn7cdfz5oeWOqlxuMLiqPO/ADJC17v1NE//qGiBWfIMjcmFue2G1+FMf6
 T+c2uMliiCR+aqePeDyJHfPJerRlUFyEWdd0rJNla5wX6P1IRU4XqpwOu6OTEs+C
 UoWB5Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf7gth-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 10:40:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915827fb1a3so87801285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780915232; x=1781520032;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tveSNRQ+h6fN2eRH75FNEmJTO0yYAeUsEKQ0M1WDmbc=;
 b=SYqPnPNODSmNYS12qcfDcZJFuhE1yZk7UbY1sNRDCrm7ZIsXsC4Wg+v4FdnxGi5Bev
 O+eygt1DUq5TwRp4+yFgLwc6A7rmINlde/i+WrHQg3gI2wBgMut/kx5YLiaRkifigA97
 VnPmKgU+9FV40Drr2s5r0mTPO8ONSnKi1IF922lsJeYI6vVepGuCTMmNt4Xu5pRNNfAy
 VfIw0GTuvRcTKGCYyywY8TKjdXx+xs0miTER3ewiMmmx5v7KKGf7+EGiuGt1pVj9kJIp
 xVlWL+mGr4EHylNXfJ9qDQx5ICshHVXSCCDTmbAL5o6CP4AOrY/ehSEq/ssKazjEDAXS
 dysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780915232; x=1781520032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tveSNRQ+h6fN2eRH75FNEmJTO0yYAeUsEKQ0M1WDmbc=;
 b=KcZUfdCsOCaPFQdkd8DvSW8bCZsNsxoT69PAQFvKpkylRCizwJZw6eCUmiwJ10EN0M
 yvDduYkDIt+knjPfbG3t5Yq8y9WETlwnI5KMoGZfv5/gJxOXeUZikbHPcvNqby/DqS8f
 ZHF1SNSRzRgxbb4MvL1tD5S0lLBNXbGwCvOma5o2tAxOu/VWgxsEHzoiedJAoF4bLUPg
 5linKJMlHQwSEGB1/RWjKM5XlUEnU3WgP+qSSj4ijUOH5KA92PjpExbO9cS+jVWtXv96
 /wu3d2T5h+B/lipaMMO+RVYF9x0GCZB3gkeRnsl8ahU1kLm4/4mJD68QXr+ZjumUITJb
 z9yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Leg8VkmQ3qjeO1AX17CyTrjRmsOnPO6MObcJcDG43nuAPA+LlaTX2MttP+1s+pj85Y9kxn5VPefs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/TuOZ/XboY/8ix0hWvB+B1jLBGrPi6SzBVXJGURFdDQ9NgCob
 vpv6ETsRWCr8LUYF3ddGkMimtllOW2q8r0RIYecG46CDagNL/IhPkWT3ZWp9RzdtPGpMMnUGcA4
 5taBRxiVEuNLc55uH/aCoglL+6QOxmLYfeeruQYZ3lcGtri//rlgFpSNfkXf/YCYQ2I8Y2jI=
X-Gm-Gg: Acq92OEUSMB50Xwhgy2iII7xlFy/7vSeRVeBPEcWCo8PkhaozNVeQEi4TUCS/7gHdl2
 YOWQW/24lul7VkUmR0nb4X7TdYJ92VMujEP8A6KM5d+whxpqrTAV96vuJtZYu5Evwzs6XkfLDCQ
 P5XnK322zBMWWUFWlTvPHGPSpgcfdWav/ws0E+MC7JGturTTKVpgok3xuMCak0k9fpgBQvZBIHu
 2T/3BOoGP7seHhc+L6UEnh7xkAxdvDdCa9lLifhRqJqNYrN9M0NmIn/BEFHG4pVlnj/EI9MwuIA
 ePfMtkMhAuoKOK+GlGt4jVyUDT/3pnuJmx8V7xfkBNKh7G9LlllptyeP+JOtrzi/ZfjwWSAHbB5
 8ZTmec60dQX68u4SinokPu01uBoLoI/VeMlybhO9heG+5uDXVioC7+bsE
X-Received: by 2002:a05:620a:28cc:b0:915:4ca0:1210 with SMTP id
 af79cd13be357-915a9d9a69emr1477173285a.3.1780915231504; 
 Mon, 08 Jun 2026 03:40:31 -0700 (PDT)
X-Received: by 2002:a05:620a:28cc:b0:915:4ca0:1210 with SMTP id
 af79cd13be357-915a9d9a69emr1477142585a.3.1780915226033; 
 Mon, 08 Jun 2026 03:40:26 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65868049sm6890844a12.24.2026.06.08.03.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 03:40:24 -0700 (PDT)
Message-ID: <cdd7d88c-224d-49cd-9a7e-6d4a2ae74d01@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 12:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] soc: qcom: rpmh-rsc: Skip TCS init when RSC is
 managed by firmware
To: Gekko <graham.oconnor@gmail.com>, linux-arm-msm@vger.kernel.org,
 Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522060645.4399-2-graham.oconnor@gmail.com>
 <934e6039-4639-49bd-8cf9-a1674f86b8c8@oss.qualcomm.com>
 <4b911ed0-64b1-48aa-a00f-e2ade66afa1c@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4b911ed0-64b1-48aa-a00f-e2ade66afa1c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a269c20 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=dIxFNMqCpUz1sDLjZpAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: sJAz4IdlKOdQ5f5pW9A-a258In3_vvD0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMCBTYWx0ZWRfX9X8ySjvfNCJm
 IZphs/JIEiumj2oGiaEjp5Fv5hABXQZM296NB27FSYBvfKGfqaQE4W7tMM2oMyiXKPx8cd7qZ16
 z0hgi9QDtbrJPjtwzURtN2EcRUG202bmjoClfpXCbyHGDefxSA/69s/SRiHVA9ACbB1++FdMEVK
 JURu9UYYEdZJKKBp4RwnV+J8bC0LHzXwA+8KHLctqSFrB+oQUFGzWIkoykhOQrZeDPs/EjpWYn+
 FCE+6GK0/wHdqDPrjl3Vy0vcoC4g2480bKFxa57BpHt6/5UEV/yfG9TcaVKB8+Lj/wKVfOGvd+V
 b7rfxRW6h91kSBmR89LwfURmUjjtZWWo0BhblH8jbxnhmuq3GRT9PQ0mFY1Z1hmI9hT+EwbUx1+
 zywGwO8E62tydqloFWGbo75hrImmSAxvJGlg9g1yP/FcItpeeuw5ZTogYKKyJMjPOHy3ukyqYYD
 aoKlhHs3Rc1HHi3Hyag==
X-Proofpoint-GUID: sJAz4IdlKOdQ5f5pW9A-a258In3_vvD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080100
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

On 5/27/26 10:30 PM, Gekko wrote:
> Hi Konrad,
> 
> This one is confusing.
> 
> I started the bring-up on this board on gentoo-sources 6.18.18 but the board would not boot. After an almost subliminal flash of tux the board would lock every time.I found the solution from PostmarketOS who obviously faced the same issue which formed the genesis of this patch. With this patch applied the board booted fine so I've applied it ever since.
> 
> However, as a result of your response here I tried booting my current kernel (gentoo-sources 7.0.10) without the patch and to my surprise it booted just fine. This leaves a few options, including:
> 1) the kernel source has changed
> 2) this is a firmware issue and a firmware update fixed it
> 3) It's a timing issue.
> 
> To eliminate 2 I would have to test 6.18.18 with the current firmware, then regress the firmware and test again. The do the same with 7.0.10. I can't honestly recall whether the firmware upgrade was before or after this issue first appeared.
> 
> If it's a timing issue it's a bit more concerning. If the kernel is taking slightly longer to initialise before calling rpmh_probe_tcs_config() then it may just be missing the solver activation, everything appears to work and nobody is any the wiser. If the existing solver code doesn't deal with early firmware TCS initialisation then it could, under some circumstances, lead to the security reset that I was seeing. This patch specifically tests for that case.
> 
> Based on the AI review feedback I've also modified the patch to not simply return early but to just skip the sensitive parts of the code to allow any other setup to complete normally.
> 
> My current objective evidence is that the board boots without this patch and it's quite possible this patch is unnecessary if the above is incorrect.

I would skew towards this being a firmware issue. But I'm interested
in any findings you encounter.

Maybe +Maulik could know more

Konrad
