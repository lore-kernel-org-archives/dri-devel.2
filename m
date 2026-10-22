Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A3F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UNq+hvA9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WQdQSioa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0054110E0AE;
	Thu, 22 Oct 2026 21:46:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473EE10E4F5
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:46:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLk9ej850322
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6QE+P56C2nYaSieRX/rS/N9gClwTb0YY8JP9mDQoasU=; b=UNq+hvA9A8DEwJLN
 NSYfFSTtglUNNRNcKnXpBoF+eJxXXmuGdMTgqw7kmS6wZSsb8jP0zZbtAYPZSzvI
 sKxCKw85TSNNzD8r8KAvtkuj309mg2YOI9eQdAS7L1XUYlYegnK3AIzwdnpPabzR
 ts1NDX3Mhqs5NgWyklR+me2lpJcGfo2BgTM6lffe6lljiqxNlxwjjqWlaMcYRcZn
 7/v6+pT603Hh7qLgcO3a3t8hIvCiz5xj+hQQuoDccw+7GKskfaEsyKy2wsD1D5s8
 e5B3IBFArInFKq54Cfemsc0cdvi8cf0svwEMsRslmd1Xlg78ZZ+q/UsIiFXWZdty
 4wjHaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw1720-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:46:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so570305eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705600; x=1793310400;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6QE+P56C2nYaSieRX/rS/N9gClwTb0YY8JP9mDQoasU=;
 b=WQdQSioaa/HNezMaEHrAbStBHRBHGlm7Gqhi4GtyfziSFefGDcFxp1HWSWI9f37tFl
 K7Qgr2rPx+lPPMHEkwaOgr3+gOQG+6ij3VdAki16ZVltljiHbza8mgq1D4A6cua7Ono5
 s6euuq8N3DwjaeCpNNaDa/x7Pqp7VLF75CzBLvsH/IF3V4/d967J5Xaxjti15c1kiTUw
 lEsoLaT8r2nhulu1DcMeH2XtD7U+vGDAK+4x8WcaWmhjnfXkHiWsQOi2yu7eHgNtYMVY
 JCNCKv6TSblKRkTzfHwf3AFB3FgA18JLZkQFKcxxvJ/vgQP/hSZC7oapACZJhiTc9kPA
 3ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705600; x=1793310400;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6QE+P56C2nYaSieRX/rS/N9gClwTb0YY8JP9mDQoasU=;
 b=o574cOZmmrD44+m+83MUzRh+qNpVrRWM0qc5e3RTt/+YhFnWulMV0UuZU9K4YPWuSx
 9+lS9LHg3GQW7U8UjES5BYOKw4q4IANf6RzeEb2i6B5PhFtXOi3EmAkRabkdyZkasd96
 I+DqmEzG/klHTiw3DmAlN2isQeA9GLR5fKoKkHkWRnuE34JyQ3AvhK0bIXC22xqly3XV
 2bSkcsTnI9NLTCqXXAhFMfRYpJ0Kf/R+lPVFisQqJv+yLpG3v+jwE+VEPbs4q7F9zgxt
 n8KN38v8kYR9aneAI+xH8QUDLv1SIpcsmQh6f0qqEGPA9kUigNzlrZea7DExQrsOyK3d
 69fg==
X-Forwarded-Encrypted: i=1;
 AKwUvByvglXYFjtltjizi8by5OVmWArP0vmIfT+xF16RPYeJynLq05vXbhFFmmeGxxbU1mvEpC//2P1REHk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKk8B3yZlJt/9a0B4koprvmPreixLVdlbWbjnkis56/AjotMg7l
 j2q+Nvr6IwxO/uVEtcj7U6NM4cg4kyPcz1xh66YplAJigSv6DJTFAZZxHojUwTyc/yQvNpxDA4g
 5+UUnr1NuLfYazojVLA/4mu030BA5Tt3W0Sh9khtTepRzkR7rmdU+kbwZR1UUY7zkRdfYGsU=
X-Gm-Gg: AYBFou2c4XeaQFK5F4bMJ9byux83+6hb2+32FMrDlqDWcvSStqWpBTqDYSTKZ7VXaBu
 /mA3f2r7ecMhPIRWvhSRB/uMdB8+Ack922fULGFr2tqUMtXZqhtxSQwraXz/fQ8R3mRD3UjrQdH
 SOHR3AUMMDm3cXtaq9REIVRPO2szaf/TD5j4CKaUq7ZHqec6koAKEx378akVc+8l4SEfXxgglKM
 9LLdXQxGLy3eIqnM/ACscg9ZT7Lg3deQ5cd7JtZuwpWYrdo6LNKG4ua5KKHf8aEepPglIcwQkYn
 nI6aPUb5m4rw0WjiLYVw4aN1JMc80m3v2RCIRGm8+fEMYMhaSTUKHB/Tf3mTPCN6LXHKb6RC80e
 QZyG53eFY2GmN3s0CU9SrwA/s
X-Received: by 2002:a05:7022:1e13:b0:18b:48c3:287c with SMTP id
 a92af1059eb24-195c693fa23mr494653c88.41.1792705599621; 
 Thu, 22 Oct 2026 14:46:39 -0700 (PDT)
X-Received: by 2002:a05:7022:1e13:b0:18b:48c3:287c with SMTP id
 a92af1059eb24-195c693fa23mr494632c88.41.1792705599029; 
 Thu, 22 Oct 2026 14:46:39 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.228.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195e9e9c4c7sm954775c88.4.2026.10.22.14.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 14:46:37 -0700 (PDT)
Message-ID: <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 03:16:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: daFtJjIHW4d1_DEWzGSjWwekHHwbnnLU
X-Proofpoint-ORIG-GUID: daFtJjIHW4d1_DEWzGSjWwekHHwbnnLU
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada8440 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ipsIN8yD8anPosRfiFfp5w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8 a=InArmlTPJEDsLdIP4zgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfX8KZHF9dkDPRw
 HoDD+tfTqsy9CepH+aF9kE3F+1capbyUyXh+XgfK1beK0/aiB1Eu0smY1mKSWhQvxFR/MRCe3sj
 ujZk0JrqbeI8rULwn9ZQUDmTCxapL3E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NiBTYWx0ZWRfXympXwkMvFct6
 ctuNgAn9hgDP22kObnV7WxF+87qimC2npyzcvpStWga6ZNsuEwWUUvSEjiMFx2ioI0u45pkdkW3
 rzIQNAj4WQh92YoQvgUofL4ghLsZGHtAjqNRYSpHnU0NkmUMRqFBTszXUAMSHZdk5sL4gERM/Pg
 79RN3W5fJX91dUkYJwF+qYd6fniReROl/e+A3F8O560Mo+vuA59wZGch8x6JQlB9oH0Q3vU0e0M
 tAdxprAH3E56KKQOFQP8foATgj1Dd8gDSTOPe/aDZ463jTY5V7Dv1flrBV+ySEcOLPDLApelMgu
 eSFZOcFsFRc1kzl4UkAbvGSHqFgpks8PiAGtiLGzPo8Y/J2lbufAqTjouSiob0ogHUFvUArTf3+
 O8vDEt55zSk+6U2v8PZiLpkyP7JsBZNgVUBKt3kVPD6+/ta1E/6zM3KyKe8UR6Ur9NA2qpm1bXh
 GkcxZIYKfWdQNT84AWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/2026 6:24 PM, Anna Maniscalco wrote:
> On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
>> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>>> context bank we need a separate node on the DTS.
>>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>>> trying to separate a part of the GPU into a separate device, but it's
>>>>>>> unnecessary.
>>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
>>>>>> context banks.
>>>>>>
>>>>>>  From what I recall, so long as we use the same dt node, the iommu drivert
>>>>>> provides no way of doing this.
>>>>>>
>>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>>>>>> and secure.
>>>>>>
>>>>>> The address on the lpac device doesn't really matter. I have very limted
>>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>>> I think, you were poined to the Glymur Iris patches. Another option is
>>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>>> describe the same usecase - a set of SIDs which are used by the device
>>>>> but which should not be a part of the defaut set. With it in place you
>>>>> don't need to have separate qcom,lpac devices, no additional properties,
>>>>> etc.
>>>>>
>>>>> I'd recommend following the same approach.
>>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>>> similar case:
>>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>>> Let me check internally.
>> After a brief discussion: it can be either, depending on what suites
>> better (and if you can persuade DMA / IOMMU maintainers to let one extra
>> bus or not).
>>
> One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.
> 

+ Bjorn/Konrad

Not sure how strict is the requirement for compatibility with older kernel version. An
option in your case could be just do an override in the board dts file of the
Steam Frame.

-Akhil.

> Not sure how to address this.
> 
> Best regards,

