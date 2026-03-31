Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573C1FF60E7
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16E810E62A;
	Tue, 31 Mar 2026 08:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+7bvyny";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drrzuRri";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDBF10E561
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:22:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V7OS7v2465180
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ty9ajhQdOOIwc79Wf8xk5txDu2PvCUdpTXfca71qAjU=; b=F+7bvynyr19IUZqn
 bG9LLBFKsQWN+ClFKtNxECjQmi2H3DaVvZOZn9uH6ocEmFgJNqKALpkOPFAFUWRs
 bSucBFqvewzjj+ZRjxRt1ki/mh76TVAwvLtShNuWwVIPSyNm9xtXMNzcdYP+pDvL
 GMGAiJKXlJbjgGyKU/sAWLyyz5X+cPLFkWrA76d19hY5BsAr/RvtafD9ACpdR5GR
 P+Evy/Fx8b5zF8u0iCHfMg0PpNkhV/haoVtgtaea/BopGnE9P2Z9DcSHik07pOjd
 KIbFqbVLEIK4xfHeM2Bg9GKNcaEyoJ4pL73IAMrorwK+Pa97R5GQ3K9uNcuuAWWd
 lVOc0w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d89ut88y2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:22:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89ed6f0c71aso11815226d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774945376; x=1775550176;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ty9ajhQdOOIwc79Wf8xk5txDu2PvCUdpTXfca71qAjU=;
 b=drrzuRrimxE/uoMIu+uUE+UIsH9KMc/XnDSjR+d7tyHLGLCOr5P5ONdX76VfXvkWJN
 r+GBS4w9IMz4xyC1tbLbRFJwy8dbU9+IjbVkXcIaX676EGznnQLlBKbqysIUkv3xyJIm
 HfMUE+yLPJcROwnnCdXhF2mBweusS8fC1C0bzbNf/ZGba/Wvl7J8civAMGYhM2fjhI4A
 OhgT2IPAuNWD5uD2OxQOUZeVdPxGGqVpQdxh92GjpltHANi5wUbBwvidgwTUUEEw5/7c
 aOlMWX1uXJSZwRJWB3evg2NqpJu8139nsXteVkJtZ58qko+xxkuNcWhRZcvUEXVznNGC
 6ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774945376; x=1775550176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ty9ajhQdOOIwc79Wf8xk5txDu2PvCUdpTXfca71qAjU=;
 b=NaM5FvNiuez5sYpLxshtjkiR6enkDkeRNx0NIua8vzpGqAFA+VvBCWSYed97gBCLDo
 9ShmJWxMbY8JPIPRHbbsjEg2h9PjUP8qrRTPQcUS8PLZJ6XQ3R4c4y3oIOEAS67GIjZJ
 WYPpqZnnzjiJmEIQk3PCkDTCJ4qmZ6bgSyPDbfewID8Iey7vRLPkq9h4EVD7botgXJAa
 U9UsVlmAL5IY1vokmmedQmOPoRwq0lHT8q6yF5kpSyFuVnoOPc6msZB1njrLLQjTNA0T
 tYFl1p+sFkj6b21mbqaoCfV+14CGFYDs/+uZcx21t7vBwrq3ppF0CS2faCxKkyt49FMC
 Ge3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCwDZOboxD/u5l01azQH4s6AUg01fGFxtljl44uMkZtGDp+PH0seYnAGOtIpvllZO0mCCqlyPJ5N0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2B1fyiRK5an6FdgF1wOK3rsV6SwAZ14+wOJz0pcoaf80a3NWK
 h90R4x1/TdM5L0rSESx+E6Yf5CqzqN4kE/hmScE3DGAxu/zl5aE7JQGucugHnz9PFkyKpVPtfJt
 hMH3fsIiFG0XkpIb5j9QhWeCMotJkRG78RZAplnphNCFh0cnq6aX1oy9i+z0iBh2Uu+OjoEU=
X-Gm-Gg: ATEYQzxALfXB7r/kvasjS2GAb79K3OsxcJF9qNDziADqplde0qApWFIDTR4Je0vx8rW
 WEIjirGWLqMPKNgjqM4XHYiI2Q+6Wzc2F9xvHC8o3zTD3mbAAPUwJgCT2JNUQlxvggAia49ww0T
 p6K3xDOSD362L8Sr0ZPJByGcDvzeEfLIxqTvfDYCy1KyyUQQOS5iWkViKyGfP3cJY5HW5S4wTLl
 Rq/T55sIhS/PJiVKnX7KQVrd5PD5vLh5FVEe9FFiSMG1ggKXiVuiTafjpAOuuDMIZavqoZz6Z5b
 V8gWDHsJmiHZzactRuX9jXzKkb8rwdPVHrIslkZKxF2cuqa6KW6p9524EmgsXq7ef4gR1kajrbf
 rY0AYCcKzTXVtQzqIlskukB5bGJqq7pdKSQ+jId/6EWbeYkOTHb+VETrUJz30tFQa9s5+zCLpeK
 qw4F8=
X-Received: by 2002:a05:6214:766:b0:89c:5fbe:cc5b with SMTP id
 6a1803df08f44-89ce8b8423dmr160477566d6.0.1774945376394; 
 Tue, 31 Mar 2026 01:22:56 -0700 (PDT)
X-Received: by 2002:a05:6214:766:b0:89c:5fbe:cc5b with SMTP id
 6a1803df08f44-89ce8b8423dmr160477306d6.0.1774945375960; 
 Tue, 31 Mar 2026 01:22:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7ae522d4sm387153766b.22.2026.03.31.01.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 01:22:54 -0700 (PDT)
Message-ID: <2108dfe4-bbe9-48b8-b77f-e7d2904f18b4@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 10:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] drm/msm/a6xx: Update HFI definitions
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-10-2b53c38d2101@oss.qualcomm.com>
 <3465929e-262f-407e-bc3d-7564787bce3d@oss.qualcomm.com>
 <67cca0c6-669c-4dcf-be3f-76fc46d1e59f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <67cca0c6-669c-4dcf-be3f-76fc46d1e59f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XhlO1DDDcU2TLGp6upodahn6ccdvbN66
X-Authority-Analysis: v=2.4 cv=C5LkCAP+ c=1 sm=1 tr=0 ts=69cb8461 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=xmSHU_qjkZn9DgC3Z3sA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: XhlO1DDDcU2TLGp6upodahn6ccdvbN66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3OSBTYWx0ZWRfX98FcF1a4sofA
 XXHkv/ajtkkRV+sPKFGWXK46/db+ObkanDwKezbwqFOAkpWgoewWRIz8KzztF9xo/Db/dG/ohC8
 s0XbSc0fDZ8WaUxACTPK9EKs0MDGV8OHjHEPPWJrwADxzFuJ4UJeo3giZN1a9v+tUJWURs169P3
 Ug2AMwRGJX4j1o4G2Jqy/fM9RyqCrgkXkMFTD39o5vn2Gt4Z3zCFr3pxpyMauCP5V5AwiLs0y7x
 9O1Mt2VkW1ZjyHZMuDxUnzcU2EYMqKC2qlRYbUWhZ2vG35PVOdljwUOLQHixNm0k+cRms8tBX6X
 nsWkdYzTHvfGaUaDrTNmy17QWQUlTfCzRlJYqmJ/jYi1TgOHesqaTtOBgA/eoFeH0c7YD+jeq3O
 mGm/I1A0sR4WNyXyMz2uDsWjTxoDYEQVaE7ORjXc7VRdj122k0yH6YI6UvAfmSolRPKNCvCUvVg
 bQGqaSHkrPB3xOeP8rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310079
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

On 3/30/26 10:27 PM, Akhil P Oommen wrote:
> On 3/30/2026 4:45 PM, Konrad Dybcio wrote:
>> On 3/27/26 1:13 AM, Akhil P Oommen wrote:
>>> Update the HFI definitions to support additional GMU based power
>>> features.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> Whether you want to proceed with bitfields or not:
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Thanks. I still feel it is bitfield layout is a 'bit' complicated.
> 
> I did an experiment:
> 
> #include <stdio.h>
> #include <stdint.h>
> #include <stddef.h>
> 
> struct packed_u8 {
>         uint16_t mitigation_time;
>         uint8_t current_rating    : 6;
>         uint8_t num_phases        : 6;
>         uint8_t path_notification : 1;
>         uint8_t extra_features    : 3;
> } __packed;
> 
> 
> void main() {
> 
>         struct packed_u8 data = {
>                  .mitigation_time  = 0xffff,
>                  .current_rating   = 0x3f,  /* all 6 bits set */
>                  .num_phases       = 0x3f,
>                  .path_notification = 1,
>                  .extra_features   = 0x7,
>          };
> 
>         printf("Akhil 0x%x\n", *((uint32_t *) &data));
> }
> 
> The output I got in Kaanapali is: Akhil 0x7f3fffff
> 
> This means that the compiler inserted a padding between current_rating
> and num_phases.

That's because __packed doesn't work outside the kernel - you're just
creating a variable named __packed, so this is effectively the same as:

struct foo {
        int a;
        int b;
        unsigned char c : 2;
} __hotdog;

int main () {
        printf("Akhil 0x%x\n", *((uint32_t *) &__hotdog));
}

Outside the kernel tree, you need to use the full annoying __attribute__((foo))
syntax:

include/linux/compiler_attributes.h:#define __packed                        __attribute__((__packed__))

with that changed, we get:

Akhil 0xffffffff

which is the expected behavior

Konrad
