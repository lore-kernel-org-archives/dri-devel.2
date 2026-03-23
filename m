Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF987F4612B
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0880610E48D;
	Mon, 23 Mar 2026 14:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FCEqIwQU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yj6tjzyP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7626810E3EE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:26:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NDtxal1364149
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q8MEwGZvZBzKxOvXFYbCiIUql2m67G/KfJewSSa/tAY=; b=FCEqIwQUe0G4B+4e
 zycwwl8D0aVorIfQgKi2f+U0Ie1Rsmy8mJcPQv9ta1zUjIRobIXPRX1FB+je6tFy
 lWD6YNGpm4ryD0UGclb1tO9bnvUzmsbC04jtc8zf25QkqKIzZMGBKlIgof23JVU5
 sSpH/Ka9AkItoR6abfTE9BQG/H6Q0/w+x+D1FGGxi7pQIk803hOvATDR/hHCEi9f
 P+qb9sVlsJrjZgOZiR/TEEvqsf79rCjhVZjXMDlHCecg6nKC8iaSqLczdOMn24Xx
 /eyehRrNiyyTuCjELGNSwoRzYFbrrH8hkneo/UREupc1mFc4RoKAp1GjUlNbF9ZO
 HLT3fA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p79brh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:26:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-602845e6661so456914137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774275969; x=1774880769;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q8MEwGZvZBzKxOvXFYbCiIUql2m67G/KfJewSSa/tAY=;
 b=Yj6tjzyPYwByEMBAfOSbcqnmgKxLaoXQmFmJ2YNY7cbZipBedFKZI85HWxRXvir9X1
 RT4BYMgtKZnUJrPVoLdHjHNMJw8Mq/+3FKFR9TAf18HDsdQRbTE4aW2ohUCtu7PLvmxp
 Fp0I0+kL3nh6+VbMahxbLY0R36fhRqJbsrDlJIl3yJqPDTg9s0tluzt1/paXuoYugFI0
 /FiOjr0Zu0eephzSPIUWMXZlTI9MnJn55D8dg4WMn7KRqEZOUXRTb+UBAhFfJFSzYE1R
 kdzJEs+RoGflfhATyC3g91vKnS3mHg8lYY2vkECtTY9ZEVi9id1kvIsJdlGsant6rNLY
 8JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774275969; x=1774880769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q8MEwGZvZBzKxOvXFYbCiIUql2m67G/KfJewSSa/tAY=;
 b=o0agvNtYfN0kF/zIplWdSVqb9yNwNutcWvgMV20m4ZCnXjDPttnXEN7XCfI+uwamch
 2h4Il1M6bBtSNVmuSgdOCcoPjkMIq43nwMT0LX2ouUIbBZ0kbkOCHnxN/KYpeEFeonjf
 NlaEQgBlwnpG228jHmqAHFmXl6MXbKUQ5gct5wYnQT8HAEzqDNPRgkCpkxVAOXfmUUbd
 dpqmS5RtXQDygESDXx9NxYA1TK43153YeUBKOeqvVOJVkpJuPec2V5jCdbVWuNorE0xL
 0fJlno60E9hqF7NlyhIAbJWNHKhwPSu1qM2c13YTB1KIBPKna12ec6GgaGZ3A62wvSTS
 YmZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/4UWSRLlmlxmyIQUY2gceAF7AG7sC3v+0KuYgWYfx4DnJzNKX/20Q4bGoG3cpCku7hO/+Mm3ekSs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfqlnX229XzE4RJjC1p025B5CJgaEr3ipDr/B7uUEHRn2TVqRq
 T8bBSmXMmgp1q1mKgPaL//Fyomg6bbLlXSIZ8jjobKbVlYH6J181BDRDMAPtoYsYCVo9wYJu8xM
 KrqAgIMBUTbBNJxRYys+IB1fhSNyQjaMh78Fg1YrGPspu2SrZay1EpIl+QskGpx7j/6Stefg=
X-Gm-Gg: ATEYQzxIJSlIeURbQMzYHhQ3bCsa3+3PcYDXIIbMi40dUD/48GmZx35+/6UpevlpCdt
 uHkbkFXG7CMXnDJF1olMKdjnVAuwUjc8tSlQlpJrgbnygfc73ADQsdW/sHCcMigeOCEhnBc3fDs
 j01V8AuOUXQSPwgy9rQ4ECXMD3/K81UMfkGoycoDMZ2rs4JCqc875WxWM3RJ59pvtbCdO3vYYVL
 kwrHSFEkjcgRNSjezVS155Sxa2zA0YZuNtHkirxU0zsoyM9hN5RNvdXvqYMsaRPYctErsrHsFHq
 hTJ3r2iZlDAY0Gk9THj+kLDl5pTvwnNAny48F7eNIxbtQ0wzlC/vzN5OIpx9y7SN2BzbZ69GcLc
 3dJgpBQwFD9LQD3yhCcdpT8juGuIkAwH8zkhg3vduWrZuEmOFiT8MfzaRl5SpHvM0Cm6cfAcaBS
 OmG6g=
X-Received: by 2002:a05:6102:3910:b0:5ff:9d74:9677 with SMTP id
 ada2fe7eead31-602aec08323mr2933726137.3.1774275968559; 
 Mon, 23 Mar 2026 07:26:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3910:b0:5ff:9d74:9677 with SMTP id
 ada2fe7eead31-602aec08323mr2933671137.3.1774275967928; 
 Mon, 23 Mar 2026 07:26:07 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983e4e9b65sm398492366b.31.2026.03.23.07.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 07:26:07 -0700 (PDT)
Message-ID: <2e55bdc3-54a1-4f18-b9ad-fe03f21fc4da@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 15:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
To: Krzysztof Kozlowski <krzk@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260312062756.694390-1-sumit.garg@kernel.org>
 <20260312062756.694390-3-sumit.garg@kernel.org>
 <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
 <acE-kAi2tkPh2qie@sumit-xelite>
 <5c5b49aa-7819-44c6-b5f7-19ec780d73fa@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5c5b49aa-7819-44c6-b5f7-19ec780d73fa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c14d81 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=RZWjG5IIt-miciyuqOEA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: 1bNUyoIIQHMA6XYv25gWOjUSoxAkLV4w
X-Proofpoint-GUID: 1bNUyoIIQHMA6XYv25gWOjUSoxAkLV4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExMSBTYWx0ZWRfXyrmytB2pThr6
 E5uoC415Fm/a5dwTvkAtqfear5xmDI5xgaIrFEiEwTfvuqIntQWY74nzbiLhyCJRd3864QtrmtU
 CC4MHNnQLCqaPxbbCe+wv4VTkeG6rLPcAVm2La68Cjbn/yrpDhv2DjWuCd4z97HPFrWXtmljt0C
 EQMgxD1prFq49EB1rZlgABv0qbPLFatrD3/KYSjDhqwjE1Ct9f9vEHVx1Xcrt3r6ocyO+2RTNOX
 +MBtZNlqNVeTJBxaLy7kR/Bu2uXJlNd7ZM+4kCy+eMUlN99YD1kdwpAzZLRB8fzeFu1DJQSQNLB
 q67EwcMIcM197xXFyVyCd5NSv4bqqdRL5HtHUHfH1ZbF6RB/oxVy8JIvdWY/hX5c/ZRTJBKsXR2
 VPWGc8KOEtSScUtaIVg/NG1EltEGINdv0bH0mbeD6qpnoZS98zq/BqyAAjmqIKGRpVR90BrauH1
 a0oeUCRTmJ5bmZWhFAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230111
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

On 3/23/26 3:19 PM, Krzysztof Kozlowski wrote:
> On 23/03/2026 14:22, Sumit Garg wrote:
>> On Mon, Mar 16, 2026 at 08:51:16AM +0100, Krzysztof Kozlowski wrote:
>>> On 12/03/2026 07:27, Sumit Garg wrote:
>>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>>
>>>> Qcom platforms has the legacy of using non-standard SCM calls
>>>> splintered over the various kernel drivers. These SCM calls aren't
>>>> compliant with the standard SMC calling conventions which is a
>>>> prerequisite to enable migration to the FF-A specifications from Arm.
>>>>
>>>> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
>>>> support these non-standard SCM calls. And even for newer architectures
>>>> with S-EL2 and Hafnium support, QTEE won't be able to support SCM
>>>> calls either with FF-A requirements coming in. And with both OP-TEE
>>>> and QTEE drivers well integrated in the TEE subsystem, it makes further
>>>> sense to reuse the TEE bus client drivers infrastructure.
>>>>
>>>> The added benefit of TEE bus infrastructure is that there is support
>>>> for discoverable/enumerable services. With that client drivers don't
>>>> have to manually invoke a special SCM call to know the service status.
>>>>
>>>> So enable the generic Peripheral Authentication Service (PAS) provided
>>>> by the firmware. It acts as the common layer with different TZ
>>>> backends plugged in whether it's an SCM implementation or a proper
>>>> TEE bus based PAS service implementation.
>>>>
>>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>> ---
>>>>  drivers/firmware/qcom/Kconfig          |   8 +
>>>>  drivers/firmware/qcom/Makefile         |   1 +
>>>>  drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
>>>>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>>>>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>>>>  5 files changed, 401 insertions(+)
>>>>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>>>>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>>>>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
>>>>
>>>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
>>>> index b477d54b495a..8653639d06db 100644
>>>> --- a/drivers/firmware/qcom/Kconfig
>>>> +++ b/drivers/firmware/qcom/Kconfig
>>>> @@ -6,6 +6,14 @@
>>>>  
>>>>  menu "Qualcomm firmware drivers"
>>>>  
>>>> +config QCOM_PAS
>>>> +	tristate
>>>> +	help
>>>> +	  Enable the generic Peripheral Authentication Service (PAS) provided
>>>> +	  by the firmware. It acts as the common layer with different TZ
>>>> +	  backends plugged in whether it's an SCM implementation or a proper
>>>> +	  TEE bus based PAS service implementation.
>>>> +
>>>>  config QCOM_SCM
>>>>  	select QCOM_TZMEM
>>>>  	tristate
>>>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
>>>> index 0be40a1abc13..dc5ab45f906a 100644
>>>> --- a/drivers/firmware/qcom/Makefile
>>>> +++ b/drivers/firmware/qcom/Makefile
>>>> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>>>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>>>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>>>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>>>> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
>>>> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
>>>> new file mode 100644
>>>> index 000000000000..beb1bae55546
>>>> --- /dev/null
>>>> +++ b/drivers/firmware/qcom/qcom_pas.c
>>>> @@ -0,0 +1,298 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> + */
>>>> +
>>>> +#include <linux/device/devres.h>
>>>> +#include <linux/firmware/qcom/qcom_pas.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +
>>>> +#include "qcom_pas.h"
>>>> +
>>>> +struct qcom_pas_ops *ops_ptr;
>>>
>>> Same comment as before. Don't create singletons. And for sure not global
>>> ones.
>>
>> This pattern has been carried from the PAS API contract among kernel
>> clients and the SCM PAS service earlier. The clients don't hold a
>> reference to the PAS data like underlying platform or TEE device etc.
>> Hence the need to have a global data pointer to hold reference to the
>> ops data structure registered by drivers having different lifetime of
>> devices. Also, the PAS APIs can be called from very different client
>> driver contexts.
>>
>> Surely, avoiding global data is always better given a better alternative
>> is there. Do you have any better alternative proposal here?
> 
> Why it cannot be part of the context?
> 
> Look at your API, e.g.:
> qcom_pas_init_image(). It takes struct qcom_pas_context which should
> contain the ops.

This would make the client have to select the ops. The whole point is to
avoid that, since the client has no clue (and is supposed not to have any).

What Sumit does is to bind the ops based on the runtime-discovered
mechanism (which needs to only happen once, given we're not replacing the
TZ at runtime)

Konrad
