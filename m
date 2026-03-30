Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC37F10D14A4
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F1B10E4A9;
	Mon, 30 Mar 2026 11:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UDgkPzVO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="crWYNZWA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD1810E4A3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:26:33 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UAGeGJ3174075
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J9OacODv0jxOnFnHvap4XRUfvTFpgpYUyq/ZZHZUXA0=; b=UDgkPzVOlZfZxCFn
 QvJQ/9AkVsMn6h2/b13qH3kQAvpFmZ0fpBB8sDbGbBU9yMzQ50NENTemuqe15xH+
 bDyslHAkeEoYWzKJsomdij6doHzcymE+dQASaT68GO+lfi/YgQDZzxrvZItgIdyU
 6KjwF0X1D47rF+hdYg4jFCYXtasUZOdh0x7aTHlIx3S1zvFYAsyQu0y6kC7gBRwN
 03qcxTOKNdc4tu++LPZ3aN5XJUOh0wFxfMbuY39unlNgcngZlA8Fpl795Vm7Z/DH
 lhKv0DYtISVEdRBXaDNobWk7/8xgsNWQnKy+VsmH15/XA/057MARmAg1TLPU1Ti+
 iWj/tw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h076a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:26:32 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-127337c8e52so1342777c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774869992; x=1775474792;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9OacODv0jxOnFnHvap4XRUfvTFpgpYUyq/ZZHZUXA0=;
 b=crWYNZWAkpEL/YSREZ0dF0uPMLHkf0GZv6a8wx0mq/r1VGMCl42rIn7xzMkA09M2Mh
 XsiJYCUgJHQaq2Hr6MI9RLUCN+/E7V+Halo8CizGSm1xftpwn7+WBgV1aN5WHHJoZxAD
 AZZET+zKRhqn8/SJvMJK1ykxzSiU5ZCowvEZw0wJPls6Pg8A1k2C7VZ8iCv7OQ+acmqT
 yHgD2YxHrgHybZo8SCBnHqLcfBt2xwxLfYh3I9YldpLgePz+Y1ALRItjT4KDCbTjMyj3
 WUms7g+oq2XQGsBjIQjkXRXt2WV1dz2ghDIrINHhVvW0EDbDjWPISVHrgA0NJBTsfL+I
 bbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774869992; x=1775474792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9OacODv0jxOnFnHvap4XRUfvTFpgpYUyq/ZZHZUXA0=;
 b=SB9MleK3Jf13T95HWgaO52Samr/lwAVtQl2ukKuel8cWc1Euvmgwc06P3vxwNNU32p
 9vT14Fvb8SuWhikuUlyW2cTZ72vLK4Wj4KcUZOLoOyGX545anGn29S3dItQV5InppY2h
 MpyeUNcX6XV8JVTHKGkawinpwm9qCrW2chsyVYO1uAVQIRrscIdz8FOhKYLnCybsyPwT
 GFWDGw7XrkQu7DyKH4jv+SqSczIZaeLK/u8qLPR2tUyXFBt71TLWdQFT61OZZehUPx7m
 I6Gp169FZ93Okvg7HvTXqYbGlK7lsynXoKNXVjcxfPArMOTurqGAqfCON2t/dRNtRcoT
 2ldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwsvTpPPs0Yc55REvK3a8en2p3oc0RH/ptcp2WVyBY6389lSIlsGziP7jnJ1F/oGsGuco/mOgytPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4+q1pmfT5GGtbyW7GMQO6Rp+3FVuO/JpX46QD8Hyz9mWMm4TI
 w9mJUuHsZ/QZ6AX7JSJKQ4kKRxVn/N+HFQeF+1ZH5u7+ZD9oAo1OJimqTFCU8gYA1tuUYu/ucEO
 IM6Wu2iXY8/T+gTFhmbQAzz5iNzJ3I209kP4AcGq91Z/JIp+wFMhb+yQYcqoLHv/orkSk6vQ=
X-Gm-Gg: ATEYQzxFtP9vUZ+Ag/vU/0pnu7EmKbgIJHlJGi2oUa7NdV5OjmFuRENwgjFqZbsrXlc
 7pvP/vkkGfJALVi6Jshe7Sk8zJlMR0lcLBkH+wQ4VgIR/t1F2qJL519DuhUVEt1dogMzcGNbK0+
 mGDi7/OzfcMzHFUdgVgs5fm3gXg2yIErSFpsAciqMOQ8KfafLt9JuiI4yXMSHGXm7Hy3xfZIIoU
 zLSSqmwwkHhifAewSQMZmVTYHOeMnoulRhcLabi4aSHEN+b8eWnQWa9epT7XN4ALsw9qNKgW2TX
 R3Hq8ZwaNhmuRSdmVM4tHi+Juvn3r5cNttgtmMQlgAUBhxE9bnxqihWI4wGKKRpH08I25QmV8pP
 GC7GmKtoOe63jprn+A35l/w0iUDP+SY63EUIw8TlwWn+zHjBEcYf+gPPCmQpz5R0DJuInNkWzl7
 Bhk3M=
X-Received: by 2002:a05:7022:128b:b0:128:c9fa:4c32 with SMTP id
 a92af1059eb24-12ab28f861emr7327511c88.28.1774869991664; 
 Mon, 30 Mar 2026 04:26:31 -0700 (PDT)
X-Received: by 2002:a05:7022:128b:b0:128:c9fa:4c32 with SMTP id
 a92af1059eb24-12ab28f861emr7327494c88.28.1774869991104; 
 Mon, 30 Mar 2026 04:26:31 -0700 (PDT)
Received: from [10.110.38.145] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ab97e7a57sm9133344c88.6.2026.03.30.04.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 04:26:30 -0700 (PDT)
Message-ID: <04303789-2473-4030-817e-9a1dce99e6ae@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 19:26:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/38] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-5-01faacfcdedd@oss.qualcomm.com>
 <vvemyg2t3ycjwb3uhwua7ow6yjvo2mnu5tdrqc3ed3iuj5ue3v@bfvgfhcxbgke>
 <e9d15987-7c8a-4ec6-8c65-a882139ba0cb@oss.qualcomm.com>
 <r4dtuhse2v2i33x56fjymlouk4ue4ftj2ff7pt3scsgoknegc2@innzpujxngit>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <r4dtuhse2v2i33x56fjymlouk4ue4ftj2ff7pt3scsgoknegc2@innzpujxngit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA5MCBTYWx0ZWRfXzkVL8eKmE7kY
 htTGhNotzACqQbcJmRj4Zhv82bB+ReKXqKGm8bFY+YkgLNSosXUJQoZATnGHomEuoYlYnGtPzuH
 vvvtCT0jFDNLfurn6tgqcaiKvbLy0aCVHnxmlEjY0dL1qcEgH8BL2KY+dLKdZGkrhMpy4vB25af
 HGwbzgS5JeneYrRBmn2K2BzVkVtqCSlZ46KiW0NpxqQk1dDFj0x3P8WSRHhqlo+5IBlswP/02lB
 cbPtV5l/aFWlYjkHZLlRzoDxjs3IDTCt3he/ZtG23qYxO5YrdaJEGJZRNuMdIVcXbtUxnX/fs80
 5jGGsYwcqNloUpfzLQrWJPX9p7pSOL1XD8Qf/R3r3Fv40KDDBW5dwAfHtZdejgiTmVtHw2781uc
 gbq/ph2lHLtt7fqxh3rkRBaO+hVq9kyYTNYJsLJxoWbBgjesjvG3K05mmPcigSu5dvdCX6zr/ut
 Pa8e4lpdlMSWEC/OxLw==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69ca5de8 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_li15neZe1v-_mplcrYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: CL8hgmmOIOuDyCNPr8xFnKeu4KKR5n1O
X-Proofpoint-ORIG-GUID: CL8hgmmOIOuDyCNPr8xFnKeu4KKR5n1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300090
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



On 3/30/2026 6:33 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 30, 2026 at 05:00:56PM +0800, Yongxing Mou wrote:
>>
>>
>> On 8/26/2025 1:28 AM, Dmitry Baryshkov wrote:
>>> On Mon, Aug 25, 2025 at 10:15:51PM +0800, Yongxing Mou wrote:
>>>> The DP_CONFIGURATION_CTRL register contains both link-level and
>>>> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
>>>> all of them together, which makes it harder to support MST.
>>>>
>>>> This patch separates the configuration into two functions:
>>>
>>> git grep "This patch" Documentation/process
>>> Got it. Will fix it next patch.
>>>> - msm_dp_ctrl_config_ctrl_link(): handles link-related fields
>>>> - msm_dp_ctrl_config_ctrl_streams(): handles stream-specific fields
>>>>
>>>> It also moves the link-related configuration out of
>>>> msm_dp_ctrl_configure_source_params().
>>>
>>> Why? And it looks like a separate patch...
>>>
>> Because the patches following msm_dp_ctrl_configure_source_params() will
>> take a panel parameter, and lane_mapping and peripheral_flush seem to be
>> more closely related to the link, they have been moved out.
> 
> This still looks like a separate patch.
> 
Sure. Will update it next patch.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c | 49 +++++++++++++++++++++++++---------------
>>>>    1 file changed, 31 insertions(+), 18 deletions(-)
>>>>
> 

