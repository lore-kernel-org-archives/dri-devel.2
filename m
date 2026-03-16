Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBA7FB5E81
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 23:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2BD10E3F7;
	Mon, 16 Mar 2026 23:02:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M9KT9F9e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDrAgH0F";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFB710E3F6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:02:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GGFlOO3125457
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=; b=M9KT9F9ewLJ/9dch
 etaL+nfEl6Ie44a0dNC5UrgWkq/vzzUcnI2g7lXs6rShD5R8IQMxzZIfgk8RY0DT
 IPjTjn8inkoF61vGENpB/n08ate0ITMtWwRGjjsUS/0qKseDdwum2Cg8BYLjGM/F
 Nq6y2sJoXlA1OwPyS1HbRgUmhl8SOUSVtJSAzMjCGjdBRJmax5gnLMMtC2XYytuM
 7zc+F6Tby7aAbkJ6vPNWLYM59K4rvn69Q31Fxcxa+fYKyaqLoOSsOPb4rDDTG73V
 zZVM3UBFpN8WgSxgNn5x9QhdoxcV3wMfgLSk+RfM/vGGCMe+TDKykn47Yq7tgSMP
 gIH4jA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxfsmjkmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:02:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so4766703eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773702155; x=1774306955;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=;
 b=JDrAgH0F0KTviQO7OzOE1qFW4uNP1B+eou0wxTnIzis4oPQ7rgD5kv9sburXwm0rN5
 nOEEgqwyN076k32gW7uefQ3BV2+KZSz/jXXUuheTo+yiUhO0Zi4k2bPrW/lz6K9AHdTx
 cgRe/wMxKLuEbYS0NEJeouS7Nqwt1k6t9iWhN38mOBj8GB/PZ5nRN+m9/0iKN1F28g29
 /MlOy699dVrU6b17bZOLdkzw5fvq9BlA9PxGiiJVnt4MXIUFl4CX+2sMqV9Ue6jcFtVM
 SxRB8dIa/mqj1K5g6sbgnD8UlkQoBew+ER1rj9TZkDzAD6pqxRxKdrT2fwhtY/VvkZ51
 AOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773702155; x=1774306955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mlchTDxr3z3qRdgb94yGA2QNfyjLI6qsy4bLeJPkpzo=;
 b=Z0FKfFZjXlqKv+tsrplf4CtPg3nOSefuSmZwA3gojcPKz+BfppA98Ztr+Wp9lESvvQ
 i7xiRez06T+IFio4KLx5OC+rOhwk2RSghfCHkwIUEldM5eUt3rFfadWqKh92b5KFyUsd
 Ha6+8UiJ1KxCPGxR1K/QOmLx3rUBVT5aFFhe5HT64NaUYWgwRtuftnZWdY+ImdG2Ft5O
 +e46352Yl5sDH7JiZw15kN59yRit9+6DcKSpLJodGbGWwX8az/FK5QMlXt8sxikUxkOi
 Kq2XrJyOOMbHzEQXXuQPHLJW70YRL0kS/FfadhBJK8Wt5OKqzNXpSkMqEt+BRBWxFn5X
 9hug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDt34qhSdueaywK/mNy+6OhhtqNo9ukUlz93uD7XSQWLJ3iKFrkTjH4gedsCAllYH/lmvHQrC5NoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/1dm133umI/dBXXebueKir2WrfDqsJ8Cu4WC9P1SMWV5OBwHo
 3RUwq0mbqSqW06KWeIzqD4pnwp/RbsFobvFKdXp20RUtmlH/64r0lXwE2JrKBKsjIZcjcoBiW6r
 pfopKD8UO9eHCnHTGv77Q/F42XR+3fCgjG3nCZ76UsyKZTMylUvvPdiOil6qynLbqfknfgK8=
X-Gm-Gg: ATEYQzxLgE5BexsvyEo6lxT8wT/lSfC7cLHH7Tn54GK36x2aE/T6sLm2FQHLmk/Qo75
 gO6rEkNlcyuDJpqH2BAhMlFZnclwr1xvBMj4bsceqNYzPwSJ4TABrZPovT/snUxgGuHRPa5yy2c
 lqt1kc/dI9xdrYARXHwmXxm3c1QQ+X7JwdEZ2hYxdGOBPt9N5JFjmDBf0vN+/Z3mDyAjKL7VhVq
 FZ1ofsvH8TtSthPBGdlXtCCUQwHpaWGP81n3Epd4w4Zh5fj7nwX2JntBoGEoz3Zbpnb8iYBGS1y
 Io4t3+yuzZ6kyLhvDiMOuDKZpWcoR6PtPYuH+MJtN0T/pWY8yeHuJEmSZByIDMFhnWxvr9WH6vi
 imEOIorvfJBTte6P0zQCNxS7ixIlGvYdfJoOVGKhui8WKwkw2U5sWCQuPZcA12e7/jkZAcexirB
 VEtTS6
X-Received: by 2002:a05:7300:6ca0:b0:2be:1779:3289 with SMTP id
 5a478bee46e88-2bea573d146mr6203974eec.35.1773702154725; 
 Mon, 16 Mar 2026 16:02:34 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca0:b0:2be:1779:3289 with SMTP id
 5a478bee46e88-2bea573d146mr6203932eec.35.1773702153972; 
 Mon, 16 Mar 2026 16:02:33 -0700 (PDT)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0bbe04304sm9795623eec.23.2026.03.16.16.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 16:02:33 -0700 (PDT)
Message-ID: <3934e17f-a2fa-423f-898b-a0d89e69f564@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 16:02:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] firmware: qcom: Add a generic PAS service
To: Krzysztof Kozlowski <krzk@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com,
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
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <28d63822-f191-400a-8005-5185dd480dbb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5MSBTYWx0ZWRfX8bcExyA1ZNIJ
 At8SLMWeDfW2SgwhdCUn0PFwcBWBDaohRRs10soqitC4GlmiwlXnkR1mRVPQMNCLCIEU7CjAv6G
 A/NmI0t17PHGtTfIKirzFjC+bxqpRrcboU8NeChJuxE5DinXdQ+4X3jbl8Jv0xa9kjhXWMi93Tl
 V6A2hyJabhxq3+geQ5Tw7NvzQtpdWj6Sbi6KFMXJrTymQaeg777VNO6nAEXUWcHWUrCliADcF4G
 zVmGHI21FNdBzUVSZDAAmPlebAcHYr8Yli78UZ8lohgBj+6+Lw8QdbEc1TaZ1ro53XI/GlUfvyi
 VHjX8S9Xf2PLBcfC7QLG7UAWzTl9SV4Q88X5PEZdineQW88HYg6iMmFvfbdfqG0PzWGHboyVL1U
 F7UE/80mf1PhLlY5hnajKT12NM9Awz3YI35PP/NgqUFY53K2JB2kL+DFBTr5iKNUV9fLqpVaFbi
 IUy7+JWnqneF2UpvFGA==
X-Proofpoint-GUID: D-AuOxmJjJU5d_WjetV4KOgw4C-GY6VI
X-Authority-Analysis: v=2.4 cv=V/hwEOni c=1 sm=1 tr=0 ts=69b88c0b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_eXaltnX1kRmSEBu75cA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: D-AuOxmJjJU5d_WjetV4KOgw4C-GY6VI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160191
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

On 3/16/2026 12:51 AM, Krzysztof Kozlowski wrote:
> On 12/03/2026 07:27, Sumit Garg wrote:
>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>
>> Qcom platforms has the legacy of using non-standard SCM calls
>> splintered over the various kernel drivers. These SCM calls aren't
>> compliant with the standard SMC calling conventions which is a
>> prerequisite to enable migration to the FF-A specifications from Arm.
>>
>> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
>> support these non-standard SCM calls. And even for newer architectures
>> with S-EL2 and Hafnium support, QTEE won't be able to support SCM
>> calls either with FF-A requirements coming in. And with both OP-TEE
>> and QTEE drivers well integrated in the TEE subsystem, it makes further
>> sense to reuse the TEE bus client drivers infrastructure.
>>
>> The added benefit of TEE bus infrastructure is that there is support
>> for discoverable/enumerable services. With that client drivers don't
>> have to manually invoke a special SCM call to know the service status.
>>
>> So enable the generic Peripheral Authentication Service (PAS) provided
>> by the firmware. It acts as the common layer with different TZ
>> backends plugged in whether it's an SCM implementation or a proper
>> TEE bus based PAS service implementation.
>>
>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>> ---
>>  drivers/firmware/qcom/Kconfig          |   8 +
>>  drivers/firmware/qcom/Makefile         |   1 +
>>  drivers/firmware/qcom/qcom_pas.c       | 298 +++++++++++++++++++++++++
>>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>>  5 files changed, 401 insertions(+)
>>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
>>
>> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
>> index b477d54b495a..8653639d06db 100644
>> --- a/drivers/firmware/qcom/Kconfig
>> +++ b/drivers/firmware/qcom/Kconfig
>> @@ -6,6 +6,14 @@
>>  
>>  menu "Qualcomm firmware drivers"
>>  
>> +config QCOM_PAS
>> +	tristate
>> +	help
>> +	  Enable the generic Peripheral Authentication Service (PAS) provided
>> +	  by the firmware. It acts as the common layer with different TZ
>> +	  backends plugged in whether it's an SCM implementation or a proper
>> +	  TEE bus based PAS service implementation.
>> +
>>  config QCOM_SCM
>>  	select QCOM_TZMEM
>>  	tristate
>> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
>> index 0be40a1abc13..dc5ab45f906a 100644
>> --- a/drivers/firmware/qcom/Makefile
>> +++ b/drivers/firmware/qcom/Makefile
>> @@ -8,3 +8,4 @@ qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>> +obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
>> diff --git a/drivers/firmware/qcom/qcom_pas.c b/drivers/firmware/qcom/qcom_pas.c
>> new file mode 100644
>> index 000000000000..beb1bae55546
>> --- /dev/null
>> +++ b/drivers/firmware/qcom/qcom_pas.c
>> @@ -0,0 +1,298 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/device/devres.h>
>> +#include <linux/firmware/qcom/qcom_pas.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#include "qcom_pas.h"
>> +
>> +struct qcom_pas_ops *ops_ptr;
> 
> Same comment as before. Don't create singletons. And for sure not global
> ones.

I agree, no globals here please. 

> 
> Best regards,
> Krzysztof

