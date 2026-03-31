Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C44E10F92E3
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E9E10EAB4;
	Tue, 31 Mar 2026 17:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1JXZVqi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IcX3LTJ0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DA110EAB4
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:44:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VGdUMe3239966
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D+yGuI/cnn9s0aXH93O9cB1RiK/gxeg7flRhGmZ3lRE=; b=S1JXZVqirPIsnDKO
 eNlI8hu0j1OVYc+QTtfzhIir27jFgYQehRjJjQA0ZwyZKkD8XBhtiZH707YlaNQ6
 CZwDOScICExmkufo6Rek9e5Y/XZQvbyy9+xvVQvIqXSPcmb3TUn9UvfZVRl8Ey4G
 63jWwFpzI7iTMpMB0+vEbPjl218yvzBwzJ+RbrhRPlx1cf2pDfiJ30G2DjtT+Y3i
 pafCLu5tNErS9Tlhj6LhO2O4RL195lZP959c+knhEG9QdEy7oCZ/KDQe7RI/PHCZ
 O9jI7S4xcvNxAOlukEyWFzT1I0IylPI6pgQbrwlmn+np7OjySI2B3t5lNyGatc9A
 t0RReQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1ytaa1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:44:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b249541063so31021515ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774979056; x=1775583856;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D+yGuI/cnn9s0aXH93O9cB1RiK/gxeg7flRhGmZ3lRE=;
 b=IcX3LTJ0N6l+DL1hMoXaQh3ePpKguOEzZEDlRHHVnjqWutWa2D/rG9dLMIpg4bHNOy
 LYAwmWwkO3zXqMbaxC1vB+dG8N3g7NDI3SiG+QT5fMbnRIH8L8N6rv/S4aVQiLvz3NJd
 aug00lDlAHv4x5HT6sTinYlISX43KOeYIYvB0RsWmi6iw8/JDwzn8vrwWW7vo9CXK/ub
 00PRPHcthA0Ygc4TuqJfW8R1RPM4Q4UyHzRmRS1f7FtT0S1rzWpf+VFfVxqnBO7XQ8vY
 buPeX+AU56/aAsT1W7W4XckOSGdVaM8YGQDss4X7c5m+eU2ZFJgkX8aDPGE7KTIxwX3r
 GSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774979056; x=1775583856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D+yGuI/cnn9s0aXH93O9cB1RiK/gxeg7flRhGmZ3lRE=;
 b=nFiLKwZ56HZ7v89PBQr9p9nRpnjiMoH4Z28m3mqTsTVvUncpUK5J/ozuvryKjD8Vzl
 LtdUoZ6fSDGA3U3S7x76kwd+P8tyd+pWmkEd7rvFt1mSvK5wFDcpirY/pm9a3hEMT/FY
 y3FEO1JV1FSfw3IHS/d8c04ZEOZtv1rYTZygWavWYQWhFI0XRfH1N6iST82qKJ7sfGT6
 HmSTGj96qY6MNXlaMFpi0ZHH+Y8WE9+VseT4BQr7RTUCIABPFLhcinY/cwY8nWjAVKqR
 inTWybP2ghCF3Ivr++QGC8SestseQ4wdfQacZKOq+FJwnItozHpw5TGFHznX9zudvW7o
 sVnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLrPZpl7r7em8QDCTN0MnGfFqs6T4sH0CYWyMSiTXx6qyDDtFatZDz3TsLVaBgkjjkBf10ivv22PM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqpuLpxSKQOx9tg2cnT9ljHYbrJoTGnIVdIu8Jrc9qcEjuak2Y
 OEjOZB8WePLN2dQk4MJf62ciUEe4eFwjBdxLoyV0P05Gz6pJPw11qbnYUWHyUsZtbd2CUmmHWBX
 TFrEx2Mc8VYFIhVktE/D1X5OLRsNtbk92a7xJGsYbzZW+sLV7yfWcLFzEs376a0gFPklsnGU=
X-Gm-Gg: ATEYQzy2XwGCJxqYwLmzslizon+Okk1OQ5uX5rnLPNa+737KfsgtAzuQn2DwR2Q164O
 WgaHIUYYkInzaRxH/nU5gYb8YAOlqEixoOsYjYkiAR/kD+Dta2+zo2+mJ6jEB0dXjwvFmgGbky1
 d0Xk3HWgZAXGwsOVbGE2MXH4iF/GXMOvDM7r+DlH9tmsNTMYaLMAzVXCDmsxDaoz6W7Smm8bqvp
 Ppurrk/QU2Rkb5p8HvwygvTFxNV8ADf92ANFB3y252GfK9faaLgZDzd3MPsHUYPbpYcvBMQx1wK
 5AJ54z8MTpPjIhlJnYeegm/c8gI8+RCRtlvfU0vU1CD1DSSDfKFE2Gkto02RieprH/Pl7U9aTcW
 fpNoXfq5eV25x2/jfqdxyUlxTFQ8H0mUvUpwVQyCbeKf8
X-Received: by 2002:a17:903:2acc:b0:2b2:5515:661c with SMTP id
 d9443c01a7336-2b269c9c7f9mr922105ad.31.1774979055670; 
 Tue, 31 Mar 2026 10:44:15 -0700 (PDT)
X-Received: by 2002:a17:903:2acc:b0:2b2:5515:661c with SMTP id
 d9443c01a7336-2b269c9c7f9mr921875ad.31.1774979055071; 
 Tue, 31 Mar 2026 10:44:15 -0700 (PDT)
Received: from [192.168.1.11] ([106.222.233.0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242765be9sm159057465ad.39.2026.03.31.10.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 10:44:14 -0700 (PDT)
Message-ID: <43a76705-bad2-4b17-9dd8-86721b80ea76@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 23:14:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] drm/msm/a6xx: Update HFI definitions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <2108dfe4-bbe9-48b8-b77f-e7d2904f18b4@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2108dfe4-bbe9-48b8-b77f-e7d2904f18b4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _W2XNXbnBw3SJiyls92o1pI4z7_reDmO
X-Proofpoint-ORIG-GUID: _W2XNXbnBw3SJiyls92o1pI4z7_reDmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2OSBTYWx0ZWRfX5lC32puj7/k9
 jsQynmJDt13MkePalzuCrhf0rxDVHRBzNzUMLqAEqL0k+9FJb5rGvqjxYtoaob2QVf+lG63hCLb
 Q0bUaBF0jeohoVXUf6vtiEOzt6NuJwM413yBhgqNVy8bho0YSpOjrYfbzvzHeeGeeI1UYyK8sbR
 weDKL4nDt/t6mypHHK9iUXh6B+VUqydZ51qV3vixsDcAXr8B1h0gBsaVALL9LihkDNrBSVwwHS/
 lbuEyyAAQlmSSnAwYCcEMaI5Vll3ryo59BD6Tmb6Z0aW2IP0PFjO2DPX/DBiOPTm78GsKxHOszf
 d6OnjSnwNHnt0GFdUZI9DwAZVl0c46NQJ5YkxfgnG7Vj7Onapc43hhFdaEeUMHFG3Mb1cEuTbx7
 tUlY9vZSxF9CflQp2ErNOnnbKGzh7uK6l8DATROx5AuxHSJPIVjcnvwIXBbZilImFrOBftC1rzo
 njwWP7jsucQTE2Tq9LA==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69cc07f0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=LIJ1G+IszuYCLGPi0MaIKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FyolfZIV0nzXbpKuJ4EA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310169
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

On 3/31/2026 1:52 PM, Konrad Dybcio wrote:
> On 3/30/26 10:27 PM, Akhil P Oommen wrote:
>> On 3/30/2026 4:45 PM, Konrad Dybcio wrote:
>>> On 3/27/26 1:13 AM, Akhil P Oommen wrote:
>>>> Update the HFI definitions to support additional GMU based power
>>>> features.
>>>>
>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>> ---
>>>
>>> Whether you want to proceed with bitfields or not:
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Thanks. I still feel it is bitfield layout is a 'bit' complicated.
>>
>> I did an experiment:
>>
>> #include <stdio.h>
>> #include <stdint.h>
>> #include <stddef.h>
>>
>> struct packed_u8 {
>>         uint16_t mitigation_time;
>>         uint8_t current_rating    : 6;
>>         uint8_t num_phases        : 6;
>>         uint8_t path_notification : 1;
>>         uint8_t extra_features    : 3;
>> } __packed;
>>
>>
>> void main() {
>>
>>         struct packed_u8 data = {
>>                  .mitigation_time  = 0xffff,
>>                  .current_rating   = 0x3f,  /* all 6 bits set */
>>                  .num_phases       = 0x3f,
>>                  .path_notification = 1,
>>                  .extra_features   = 0x7,
>>          };
>>
>>         printf("Akhil 0x%x\n", *((uint32_t *) &data));
>> }
>>
>> The output I got in Kaanapali is: Akhil 0x7f3fffff
>>
>> This means that the compiler inserted a padding between current_rating
>> and num_phases.
> 
> That's because __packed doesn't work outside the kernel - you're just
> creating a variable named __packed, so this is effectively the same as:
> 
> struct foo {
>         int a;
>         int b;
>         unsigned char c : 2;
> } __hotdog;
> 
> int main () {
>         printf("Akhil 0x%x\n", *((uint32_t *) &__hotdog));
> }
> 
> Outside the kernel tree, you need to use the full annoying __attribute__((foo))
> syntax:
> 
> include/linux/compiler_attributes.h:#define __packed                        __attribute__((__packed__))
> 
> with that changed, we get:
> 
> Akhil 0xffffffff
> 
> which is the expected behavior

Yeah, I can confirm this. The AAPCS doc which describes this is a bit
difficult to decipher for the case where a bitfield straddles between 2
storage units. Anyway the experiment confirms that your assumption is
correct.

Will address this separately when I post the CLX patches.

-Akhil.

> 
> Konrad

