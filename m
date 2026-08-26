Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18860C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 02:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B56910E23A;
	Wed, 26 Aug 2026 02:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nGyRCOOE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dBLbVcx5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FA110E23A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 02:54:01 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q06gXs301902
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 02:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ddJboHpSvSX1Z16yPX/eIHL9/F7ni+5viQTQ2BSEvlY=; b=nGyRCOOEBwAI0SrN
 vodQLvRU4DRtSev1J5AxMFJZa5OBFM65xAwLeRXUXy3sh65mf+odo0x++njSM5ZW
 C8gjEc8lronFyxQsSNJd5DlLMPnBwoOGtK2bxkMCCBR2cKCPEwxzwd4l//CMEULG
 n8xWlUdpt6x1GfkZgjD5VduCBuIvmjTMi7jht55sVnTZJinTEKkjbapeU3kIHL13
 Ryvn2jBA9EL55lx1wLWx75K5f7WrlZbXu59nbxkLjh+FIJMnZzRTIyX6rwV0TppN
 eAANZ6gYFw6UK5kF27rwr3GaKxRbmP77/1X/AsMLedI7YE+2lQv4KVH7qVAfRHx+
 Jy1xig==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bnjaxbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 02:54:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso949302a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 19:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787712840; x=1788317640;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ddJboHpSvSX1Z16yPX/eIHL9/F7ni+5viQTQ2BSEvlY=;
 b=dBLbVcx5LLEbh2JFrEX7pFFxWV8ioX0wHYddrKgpFs0iF631FxM7iJxWmRt1XXvs2T
 DOyfW0C6RcPAIENF+SeXO37TWkrQT1E14As7mmZd6p58PTJ7BMCm3R8gcPdyGMqTAiN3
 yJw4r9wBxnOBQ5JAaE615KnIsByGbW4Uoccdz9m2Nfwdts2d5o3C5/enZk5t/g5dn1fG
 r9qhCeKeywvBBR3POVufoD+4eH8Z8FFWor9VJ0OvXqPfAqvXvt2M+cASG7a1BgRVns/6
 uLF8k7HANjH79ARMcT0nnG3E0RqwcnIW6JX82R9q9KlO3g4oomcdYgiPRcWOBm3Cklv/
 WIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787712840; x=1788317640;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ddJboHpSvSX1Z16yPX/eIHL9/F7ni+5viQTQ2BSEvlY=;
 b=Jq2lgtsG86ZLTArt/dW8ri3rh0rugxWhXdtsPN3aHb8vAQpySPyGYHeFRgoW/SW0+V
 nzlCe5DoBQFlvLY7raCtQL8U3Qu/3aI8Jgl6CO7rEi4W+Ai7ZYyCgH1rpSnIlA7CGFe6
 uXYTCLZPaf3Pt/A0d2ZqNAttfE52m0TwA6sLCtSYT9AnrB4m0aQrrq5SJgKFpxjSzy3q
 e4qp3lX/g1ttzUA3cn6Xqfkg1617IQjrDaWH9N17GNpsThnLMFvzVT4f26UgB3gO0jmP
 CH7ikpfGVvq9a+zts6Rlb/m3Pga9EwhwsphwlRqteiv+ocvhq0PoRG4nunNj7OTNXqCi
 oxMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoClKww9cD3u0lkLm5QIxGHHhPh4NYsNHwqnUbm53BFbk1syqDNEoW04Xnwy//CgDIzWL4k5ChBqGI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhF9YB8gRS8MSdmYEqn+6rF5VOeO/tRoZLssm3CC4FkcjB5Spe
 3PjPYwRgJvPLcG0nF5XvTAJPEM/eoOhFau5zAkYEkz5tS31I7xNcWJM9wYQSSsP2fUZ8r+JX1xO
 kQL1XMJPcraeVmYJbei2vk2H84ltYz6qohdTmmkHyFZ4UstM2oi+IiN3bYrwvfn4/XwYH8GY=
X-Gm-Gg: AR+sD12HkVwBLgqYdVV56iOXN3mhF4oLJdd94IGgqzfvKDZEMmqOCON3BK3HXmiwHE4
 YDv5pe9uX8YWrZbU91g+2clIHOsri5oeO0QVRRtzTPpS2ZQyg20yGjPWMHaSUtjxDHR3JN1JuSV
 FZ3TJgPIlap4U59iFGcUtrKHpd5oDTpWW+xOn1F4U92JstmfbBIwhZqgonzKPk9h6HAVxFmzLWU
 mA374CtFWSGo0oPEj0bfoZqJ/6E1ssk99nbfEfYh2BUMKYLYS5biq5JPGNYe2/zKkuf9FckGC+6
 AQWLQjoeT+mgMfHroI+XIGvuyrZw/PHu3SvAO32zlN5so2Y4NNCzCH/0Cd6V5JTEhvuS4qmMcw1
 09rvhlWnTFe5OwrGGv4gphFhN5KMikiNOvt6RYMBKf6jQAOanHED3ZfJ05leBLczu2gZKBowl
X-Received: by 2002:a17:903:1b08:b0:2d0:cc92:f7af with SMTP id
 d9443c01a7336-2d707b7f5bemr53716345ad.9.1787712839952; 
 Tue, 25 Aug 2026 19:53:59 -0700 (PDT)
X-Received: by 2002:a17:903:1b08:b0:2d0:cc92:f7af with SMTP id
 d9443c01a7336-2d707b7f5bemr53715585ad.9.1787712839459; 
 Tue, 25 Aug 2026 19:53:59 -0700 (PDT)
Received: from [10.133.33.110] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d704bfc5aasm3273085ad.61.2026.08.25.19.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 19:53:59 -0700 (PDT)
Message-ID: <15826e27-514c-4aaf-b56e-b40ed0bd600b@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 10:53:51 +0800
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
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
 <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
 <db2a18aa-f5fb-4ee8-8747-05fcf740749f@oss.qualcomm.com>
 <f344a913-cc95-4fef-880b-f1fee200c108@oss.qualcomm.com>
 <b6d6b627-a38b-427a-9e62-ee883505b2ad@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <b6d6b627-a38b-427a-9e62-ee883505b2ad@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _A8YqMjg7BPZzytY3sPHaWh6G7gGrBzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDAyMiBTYWx0ZWRfX4t4Z4qaAatFb
 ngCKT0VvsU9ei7Ebtu1xtPKXJfS2fByBbyCoZR6XKGpfxpqe6YnbnQLTr3Gr9OHjcu8aSG9DaPJ
 TNKGXGP8wbV15tdy3a15RCVDM01jQVS7PGASmDngIHKktK+f6Z8o4myhwK5bAqtkhREzvBVWgpk
 vQwqdyWqiz4NTjfe9sizLQ/kmewMqZlqEAi4UFL55LPwKwcg6rcW9QjnKxy2UJ9r3+LEr61doqA
 XVDCh4gZvI2y/b1GzzTmfCARJ3eBZFv55sTuXOYeUGwFrOkdU+KmLyKQUW85cP/EkzXoYM+rSYH
 j4enneMUo+erw0IFwqad158wah+dBd3A05hW2irdUhRLlhgoAYjgm+8Yxi12jSqn/ZD+t0Us2uv
 u1iWaqGyJ5LWb+LCFFlifaHdzAKP/ekAp5k8wcbNwop7oQrv9BdCUBAVC3cVJ9y0NYUmBErRnA9
 n/9bEWVYGGrDEAxZjzQ==
X-Authority-Analysis: v=2.4 cv=ZuHd7d7G c=1 sm=1 tr=0 ts=6a8e5548 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=XoI0lUbBRiva2J4xD0cA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDAyMiBTYWx0ZWRfX2/9oN51n8e1u
 AGKQP3TKUfK0F4uGF97/uB+tOYhpRLj3e9WOVUhceTWT9tl+Xk+kv0lYUE46xDs1MDLtjOUrho/
 0WaBegr83/g8dRS2kAN/0QIX1SZI3dg=
X-Proofpoint-ORIG-GUID: _A8YqMjg7BPZzytY3sPHaWh6G7gGrBzf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_07,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260022
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



On 8/25/2026 4:30 PM, Konrad Dybcio wrote:
> On 8/25/26 8:28 AM, Yongxing Mou wrote:
>>
>>
>> On 8/17/2026 10:14 PM, Konrad Dybcio wrote:
>>> On 8/17/26 4:13 PM, Konrad Dybcio wrote:
>>>> On 8/13/26 9:44 AM, Yongxing Mou wrote:
>>>>>
>>>>>
>>>>> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>>>>>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>>>>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>>>>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>>>>>> powers a subset of SSPP blocks.
>>>>>>
>>>>>> Can they operate independently? Does INT2_GDSC need to be
>>>>>> powered on after CORE_GDSC?
>>>>>>
>>>>> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
>>>>
>>>> Is the MDSS any useful if *only* INT2_GDSC is enabled? Can the INT2_GDSC
>>>> be enabled itself if CORE_GDSC is off?
>>>
>>> (I didn't quite know how to parse the list of states you provided in your
>>> reply so I asked again)
>>>
>>> Konrad
>> Hi, Konard. Would you recommend adding the parent clock in the clock driver, or handling 2 GDSC in the display driver? I'm preparing the next revision and would appreciate your feedback.
> 
> Does disabling INT2 provide us with any power benefits and will the
So far, I haven't found any documentation that explicitly describes a 
power-saving use case achieved by disabling the INT2 GDSC. The material 
I found instead describes it in the context of display tiering:
"Goal for partial display is to tier down from premium tier to match low 
tier pipe configurations."
> display driver do the accounting for what resources need the INT2
> GDSC specifically?
Not at the moment. Our current requirement is simply to enable and 
disable it together with the core GDSC.
> 
> Konrad

