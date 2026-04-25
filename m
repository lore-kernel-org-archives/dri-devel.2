Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFFFF885D
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EF210E12A;
	Sat, 25 Apr 2026 09:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzUj1w8Q";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OqiBXl2U";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B77710E12A
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 09:57:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3QGB3469031
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 09:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AZExIZavOwKLJirxIZDH3BFh2jY1Vt1v0FLp3r7lz1g=; b=OzUj1w8Q2ssnZpj3
 HLB3WZSeCEilZsnigNWyXXkh2qTKpaa2IkdQCRhjOIUUAWvrBAqoSEUC/rQ9/4qj
 doNf0Ue666/ghX/bdSgXlNM0VGqXwWpU/D2bCrbQN9qXTw5SOzJmzjEm5wJidG22
 o/DuhbsmWOY2hqgjSysxpSkQg9ZvcjYFB1V615nULS1UvlujcZWe6HHD4xEZqG/o
 1cBWGGkWjxRTxn35TktvymcPnVMi1y5QtfzKmovJ8cgtjdAHoBjrp30TfspJIuGd
 B0KR7OJcUmVFQNklk3+zaIkkHMrtCo6kA0GE+k9zRO1L6nYxacv2F6QzfFmhJMA2
 Zd6KxA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnq5rmtw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 09:57:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82fa7c6699fso9392417b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777111030; x=1777715830;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AZExIZavOwKLJirxIZDH3BFh2jY1Vt1v0FLp3r7lz1g=;
 b=OqiBXl2UVYVGh7OQHQabImKanSSI2fgLf+sSFN00ploLhsyCKPOoOlGMlgWEaSeuUd
 D4dc8wM5sN6zzyTWL9kNELAkbVkJS0bvfsZ28TdKkDotQDo0QJXWOetuXKLhilQYfOlW
 0A9pE64jUdRkuPcIZ26THvSnZOYG2FnKQ3vFQH6iffad6OlCSU+BtNkEkzaYNt8RKG+F
 5b3RW+ylEct9nGQvhtX9yGXYFw5cTnLjm0LAB2e5Vh3v1T4Y3WoNh57PdHvHx/XfH3OW
 EUNcm4NwmtYQNwf2Z1YMRt4NU12P1+89yaJ5DXKjuar954fEmpUbQiBaWbThY2ZlQQcR
 QSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777111030; x=1777715830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZExIZavOwKLJirxIZDH3BFh2jY1Vt1v0FLp3r7lz1g=;
 b=k0rwdlVoVSGVFbT8Z8n8h90amdBxM+VPQLcJXd7s7N3pUPVTzzZEo40JoMk0RFyfpi
 UK8NNwkL6E/fyWLqy1l1JI56WmZYuDYFIDbtzhxjX6fqk9EKCRqkOISt8Puprrra1YZ4
 Otp4M0Ykl3o4mW0hp9kjfGJhU2lui0HQY4dt6+/SfNQIE7FJqkjN6MU2MohlT07mJlOK
 MO7QGvNEFuKJ3PcNMsHcjx7/ZR/Eci9Sw/ZQjP0p8SOAFtKiPdyOjBYUyl6CJPJ7m862
 HqAhmfvEd15g91i3SXwyagJm3C70j+5ky3mEccnXvn93htIkUkUrb3mILKWYqARTQ7hm
 HkbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3sfK6rp3DQANwn5UE7bWe/YtpxODLPIb5Z+KKe0JRxg1mE2X7EN5CqqUnW5P9YhwncU99t677mr4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSsVfUEm5rwQhLa2FY/aC7zIZX8L54BeS1o79dyPJg8AkqDfAz
 m0SOe0YxmN1iMRPeT84YuFDMFBCl7+6GXqyVDDFNbkgr4ZrCXsA/zmvZM+6etAC2LMlJYj5b4dz
 nqooC/w+v/2rCsP/BSHVXWKAllxnvbZmXN1KKbvGSUFGqLCW5V4IYZ/qru3DT1DUcbykOeTs=
X-Gm-Gg: AeBDieujYwyBdb67UCa5tyE2umlfJeIoD3jGvJ3OqNaJdYDi/5DqRHSwj55ldf/qa+8
 MYxgs+m4NUfq7d2JSgPXLMvNGH2SzpmiFIJ59NGzKv5gxjAaJ9+4lTaOroJYaBWqHk4jUTo57cI
 fjzb0v6+jAb9ugGOxBeU/q7MnYjmpmQ0y2ot6aHS9uYPWFr74zRL5CRwzwb+OALdXhEpy+gzKei
 V9fC+2wEegTM6p8kb81RAE3/epPiWAAd+8ECNPAzBXLbXtCNmuKjP7UoEKYESdPV8lsrcSqGATP
 liSlPiPsBZa3M2iiUA0zD70IoZ+ZZ5blb7hNvBIAacJPyFNSdpbGJxFr0nx1L6bmiQDYowzamkm
 QR+cSa+SogVAur0ynWTUul3YUvLoGQxA0P08bROrqmsU3VzG4WUYBctR9OfoXrnuPEg==
X-Received: by 2002:a05:6a00:2da2:b0:829:8942:2c85 with SMTP id
 d2e1a72fcca58-82f8c86b594mr36379962b3a.17.1777111029794; 
 Sat, 25 Apr 2026 02:57:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:2da2:b0:829:8942:2c85 with SMTP id
 d2e1a72fcca58-82f8c86b594mr36379925b3a.17.1777111029289; 
 Sat, 25 Apr 2026 02:57:09 -0700 (PDT)
Received: from [192.168.202.18] ([106.192.38.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec037e1sm31035140b3a.54.2026.04.25.02.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2026 02:57:08 -0700 (PDT)
Message-ID: <b89eabd9-3d0d-0128-eb56-99ab2ead2257@oss.qualcomm.com>
Date: Sat, 25 Apr 2026 15:26:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 04/13] dt-bindings: media: qcom, glymur-iris: Add glymur
 video codec
To: Krzysztof Kozlowski <krzk@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-4-0296bccb9f4e@oss.qualcomm.com>
 <a9cacc9d-c7da-4803-8950-97511f8d927a@kernel.org>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <a9cacc9d-c7da-4803-8950-97511f8d927a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QNxYgALL c=1 sm=1 tr=0 ts=69ec8ff6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=zt2h8jT1BUEQU1rgsTrZfQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=yXM0pRxr-LgjvrZoWBMA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: mcT79vx-JGCjao7lK6ykWv-qJLILYP24
X-Proofpoint-ORIG-GUID: mcT79vx-JGCjao7lK6ykWv-qJLILYP24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDA5OCBTYWx0ZWRfXwoxl9U0ka3lB
 yXkBhHjWLedCEx/4vWpIo8HF3+y5t4e/fAdf2ZSHh2WmLzReQjvCqJB6LFGZ8n3kbkVIOW2A/2c
 KACFl31lp5rzERFmjS5RHGfrZfAqdLxMIbVkF/T3UKlxa1J/9+mR1Fsw6XMxOxWo5NIfT3oQH0D
 TefhjDnP4XiWMTQZtcy6HEIUy1YsNK4DZTI489a45DC0zEaPFBx/69yeTAz0GMLExSd4tat/C6K
 wFbE7mYCrG62MN+YO4RXQL10/1Yh7jdM9qyRV2BjpRnOaOqrIfKoBST3nRtzV1Gyt3Q//Z5kAOe
 xAndYlfG3/rHJ9NX50EPR0ocxpRp84MM3edqvr2gdoXH/E0rnUCd4zRWDKtrD5acljtOO+2bLii
 9VNk/ktX9wtbQQWtx73vgYAL4jult7oF4OQboP9WGcohXTusgYj11LQ7JxED36ohA0DuPIo9pHQ
 OxSSCuWYhvkYhtI2ZSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250098
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


On 4/24/2026 10:39 PM, Krzysztof Kozlowski wrote:
> On 23/04/2026 15:29, Vishnu Reddy wrote:
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - dma-coherent
>> +  - interconnects
>> +  - interconnect-names
>> +  - interrupts
>> +  - iommus
>> +  - memory-region
>> +  - power-domains
>> +  - power-domain-names
>> +  - resets
>> +  - reset-names
>> +
>> +unevaluatedProperties: false
>> +
> I think I commented around here but probably not specific enough. You
> miss here either reference to venus or usage of additionalProperties
> instead of unevaluatedProperties.
>
> If you intend not to use qcom,venus-common.yaml, then explain WHY in
> commit msg and switch to additionalProperties: false.
>
> Otherwise, you miss $ref.
>
> Rest looked good.

Iris glymur platform have more clocks and power domains, which exceed
the maxItems limits defined in qcom,venus-common.yaml. Inheriting from
it would cause dt-schema validation failures, so I have chosen not to
reference it.

I will add this information in the commit message explaining this, and
switch from unevaluatedProperties: false to additionalProperties: false
as you suggested. Will address in the next version.

Thanks,
Vishnu Reddy.

>
> Best regards,
> Krzysztof
