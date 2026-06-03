Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADCBCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 05:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2B310F886;
	Wed,  3 Jun 2026 05:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLRejsnA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xm77L3Na";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19FAA10F886
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 05:51:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6535Wsjf1727829
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 05:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AoBXmuqEDW/B4n4M1GtYaMi2nefd/8NaLnywKReRnKk=; b=gLRejsnAQCm/y5ik
 ugn0LJwtvecXJpobc9QOcYHsKyVw+1ctVQ18LgKhz/YIJ8x77vwGfOGruVZ5gEz6
 PSY3LGCD/rL1Hrpr5QKxUa0viKgbwk6mSIWn+e/jqfFl4jt9bA+jSSS2Jc0BuH3A
 64KAweYROTEsZ2x7VVaixA1e4+OChDAb/vVr5su+lQxNgVXcW4dSZo51c/lhoi7H
 8GMSAC4i+tsgxdkS+RcNO7Xik29ObYSD5xYQSRNZSLK2jYAOKtjKyUZwvdRy81cY
 Ia63ghCRnpR7QDZpBU/i97wmIe/mD4/sAwW/obIKA1m9GJoUica6Q3apSplGsIEJ
 iTxykw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsu15a5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 05:51:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0c331eda3so43283705ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780465913; x=1781070713;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AoBXmuqEDW/B4n4M1GtYaMi2nefd/8NaLnywKReRnKk=;
 b=Xm77L3NaRg9TUPDFaG7/2dayqoLwC/UxQendDllRZl31Q/D1g4j2DLh9X/t7Nd6RwF
 9KnjWacwXVRM0gyHLIoMzmoO8cryySrW6q+98UVO2JcCuHnURjs5KQoFoFPxwoPsIgl0
 kLVZzQQNAhNne5uLtyu9J9TeLD2tpGy097Ed52887kUnGgiQitjY1dg2BMo3rX2+5Lpc
 331BtecuOW3yRL816ESiRpv8Q5EdTxk/HQkjaB7HXa6OESbqoAUdDAeeFILW8I+z46xj
 vNh8EMSYk2vojwcTDQFp9qFNSNXXeOVnnJXzDnOqfGJgV5+JTf2YvFBdvJPKKsI1Tkfr
 v70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780465913; x=1781070713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AoBXmuqEDW/B4n4M1GtYaMi2nefd/8NaLnywKReRnKk=;
 b=KVbtI8yBwv3ThnzHjffqtXn/+W78xBgn7pdTQhM5ol/YZTosaELjbbuKFWKOwnRPQn
 qmtpJHt0g+XAe6qe176UwyQPzrzv1Wpe5cAx98ETXm/ZOtKU7zdfZL7muClIaVueXd5s
 /Y7H7M5OlkzqL5O0WA8xbxZXCmUakErJjl1qeUGKowGuifw/+pd/10y32SHXRIaMOb8I
 DqvrPdj/TXMQgJXE6ts/XGe19ZWXsXR1hWV2Jx98DdPCtUxDjXnyNE3P2JzR4NJ4o/pT
 tl2+3T0hnZ5yMPc+3dgPDcw6eaYVkI5T09Y83iTpzy0ra1uMIh1U+inXmkonwyFmjTN6
 J+ng==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XGTOfDDJpBBMsTjpNl/lFEx6dGBJ3ktCPtqPBsviVK18cqKg5EpCkaELQlaB0ex1t3RFHzla60Ic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWbpZuxs0AGSiec/cCBzuw0xTUdjZrVNPeT7DNU4Jxv2XYxgWA
 OXk5heCXnfu2XAGUyB8QFoE8fCgRTVbASVqMbJ3quS17tJ4dD1tpf2llSlYYT7QsMz/vTd0ZYyp
 uhGk9Q5f3Q+E+g4xSyX6Onic9lq7oxk/X8MFWVlIb1nBYsno2BUDIbJ0FD7TAhZ/WnbgWQEE=
X-Gm-Gg: Acq92OHoT6Xa2tNuYqrG2nU++JQanpwAfSpA+2Zp2btyI1QY2ssItegTTCBeRzVPq+Z
 rGzck9hxLJ+wNHaFOL7vNtXY/TamdpkIjNc1rLaTgeXiMLN3MizZvpz31Je/l6RAla339IQ05YX
 ilJzm1z67RFP5OYv5olOk8v7AVHP6gtcMEtsJ5esp5vR60bduHIiwXMukxJpkYI8oQ8FdAsz6l8
 PnmeSEV1CLMpaC4vTFI03RYZRyv1vFPxOM6cj5F9fPERm+zK4a2NPG1vwbCXH9xGY5HIzJL63vg
 Zm1FqsgtpnlxNkkjse4FX6bYYvNQtTZakQg5lC2RfO+zxvRatAJIlVb04Ig9Mjn+tHhrPtql90i
 YyZu912uu87hG1A3gY9sClnpC979eM6FhJgL1m9E++xIE37tb1pI+5qkbvOse
X-Received: by 2002:a17:903:2312:b0:2be:fefc:d5b9 with SMTP id
 d9443c01a7336-2c163a1352amr20027015ad.5.1780465912913; 
 Tue, 02 Jun 2026 22:51:52 -0700 (PDT)
X-Received: by 2002:a17:903:2312:b0:2be:fefc:d5b9 with SMTP id
 d9443c01a7336-2c163a1352amr20026725ad.5.1780465912431; 
 Tue, 02 Jun 2026 22:51:52 -0700 (PDT)
Received: from [10.204.78.54] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649d2d4sm11280795ad.77.2026.06.02.22.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 22:51:51 -0700 (PDT)
Message-ID: <b5c9d149-1a48-4c0d-aa0d-9ad331896f47@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 11:21:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-8-b2d984c297f8@oss.qualcomm.com>
 <m4zo2nkxtl5yeyo7riuata6r5saflmdgqf37cz2g2ezrwhk53m@mnad6bb7n3ik>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <m4zo2nkxtl5yeyo7riuata6r5saflmdgqf37cz2g2ezrwhk53m@mnad6bb7n3ik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rNzvPf75sBb1DuTjlbglygvFmOM-xYp8
X-Proofpoint-GUID: rNzvPf75sBb1DuTjlbglygvFmOM-xYp8
X-Authority-Analysis: v=2.4 cv=MKFQXsZl c=1 sm=1 tr=0 ts=6a1fc0f9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-e_ofER35s36BqmFglcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1MyBTYWx0ZWRfX6YIgtrRQinJz
 xbWLvGse6rywkUrYbyQ7R65KSY68p30YniYNiP4PwzQBnP60H8YfFHVkBEubss5Oos2Ljk3He9G
 KtoAOBFQfCdxk/isE64cbPYBEnyy6bxiXGDPftxkHOe2sALq4XtMaY7w4Zh2fK8Tap61BV3VpP5
 NLv06L1m8a3pgx6e8MQHK6xbqj6IoAzY70ogUMojpjns95sKOf3CgW5jVf6MPPg+GIiAbUOmASH
 pEqBoxSMX9IVXkIjEv90E1alajg6yX6T0rm5QaXgUF2FwUFvuUYs3Wn899a1fKd9aU00GoW13E4
 DVR8wgEuBsD7mhZj18813cF8RzCJ6GeYrzwfMlil+Xdas4b169G5jIyHWhCyDSH/hJm/vSuXAzo
 EnuWhQjkedOGffjVMgSzpxR4r3d6+rQQD9c474424cy524xvSJjmCmQy48AmCaxt15SwZqKwTDE
 rwOiwu5iNIVEXICE3Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030053
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

On 20-05-2026 19:59, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 11:45:58AM +0530, Ekansh Gupta via B4 Relay wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> Introduce the DRM_IOCTL_QDA_QUERY IOCTL, which allows user-space to
>> identify which DSP domain a given /dev/accel/accel* node represents
>> (e.g. "cdsp", "adsp").
>>
>> include/uapi/drm/qda_accel.h
>>   Defines the QDA IOCTL command numbers and the associated data
>>   structures. The header follows the standard DRM UAPI conventions:
>>   __u8/__u32 types, a C++ extern "C" guard, and GPL-2.0-only WITH
>>   Linux-syscall-note licensing.
>>
>> drivers/accel/qda/qda_ioctl.c / qda_ioctl.h
>>   Implements qda_ioctl_query(), which copies the DSP domain name
>>   stored in qda_dev.dsp_name into the user-supplied drm_qda_query
>>   buffer using strscpy().
>>
>> drivers/accel/qda/qda_drv.c
>>   Registers the qda_ioctls[] table with the drm_driver so that the
>>   DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
>>
>> Assisted-by: Claude:claude-4-6-sonnet
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/Makefile    |  1 +
>>  drivers/accel/qda/qda_drv.c   |  8 +++++++
>>  drivers/accel/qda/qda_ioctl.c | 26 +++++++++++++++++++++++
>>  drivers/accel/qda/qda_ioctl.h | 13 ++++++++++++
>>  include/uapi/drm/qda_accel.h  | 49 +++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 97 insertions(+)
>>
>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>> index 701fad5ffb50..b658dad35fee 100644
>> --- a/drivers/accel/qda/Makefile
>> +++ b/drivers/accel/qda/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>>  qda-y := \
>>  	qda_cb.o \
>>  	qda_drv.o \
>> +	qda_ioctl.o \
>>  	qda_memory_manager.o \
>>  	qda_rpmsg.o
>>  
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 0ad5d9873d7e..becd831d10be 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -8,8 +8,10 @@
>>  #include <drm/drm_gem.h>
>>  #include <drm/drm_ioctl.h>
>>  #include <drm/drm_print.h>
>> +#include <drm/qda_accel.h>
>>  
>>  #include "qda_drv.h"
>> +#include "qda_ioctl.h"
>>  #include "qda_rpmsg.h"
>>  
>>  static int qda_open(struct drm_device *dev, struct drm_file *file)
>> @@ -36,11 +38,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>>  
>>  DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>>  
>> +static const struct drm_ioctl_desc qda_ioctls[] = {
>> +	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
>> +};
>> +
>>  static const struct drm_driver qda_drm_driver = {
>>  	.driver_features = DRIVER_COMPUTE_ACCEL,
>>  	.fops = &qda_accel_fops,
>>  	.open = qda_open,
>>  	.postclose = qda_postclose,
>> +	.ioctls = qda_ioctls,
>> +	.num_ioctls = ARRAY_SIZE(qda_ioctls),
>>  	.name = QDA_DRIVER_NAME,
>>  	.desc = "Qualcomm DSP Accelerator Driver",
>>  };
>> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
>> new file mode 100644
>> index 000000000000..761d3567c33f
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_ioctl.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#include <drm/drm_ioctl.h>
>> +#include <drm/qda_accel.h>
>> +#include "qda_drv.h"
>> +#include "qda_ioctl.h"
>> +
>> +/**
>> + * qda_ioctl_query() - Query DSP device information
>> + * @dev: DRM device structure
>> + * @data: User-space data (struct drm_qda_query)
>> + * @file_priv: DRM file private data
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
>> +{
>> +	struct drm_qda_query *args = data;
>> +	struct qda_dev *qdev;
>> +
>> +	qdev = qda_dev_from_drm(dev);
>> +
>> +	strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
>> new file mode 100644
>> index 000000000000..b8fd536a111f
>> --- /dev/null
>> +++ b/drivers/accel/qda/qda_ioctl.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_IOCTL_H__
>> +#define __QDA_IOCTL_H__
>> +
>> +#include "qda_drv.h"
>> +
>> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
>> +
>> +#endif /* __QDA_IOCTL_H__ */
>> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
>> new file mode 100644
>> index 000000000000..1971a4263065
>> --- /dev/null
>> +++ b/include/uapi/drm/qda_accel.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#ifndef __QDA_ACCEL_H__
>> +#define __QDA_ACCEL_H__
>> +
>> +#include "drm.h"
>> +
>> +#if defined(__cplusplus)
>> +extern "C" {
>> +#endif
>> +
>> +/*
>> + * QDA IOCTL command numbers
>> + *
>> + * These define the command numbers for QDA-specific IOCTLs.
>> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
>> + */
>> +#define DRM_QDA_QUERY		0x00
>> +
>> +/*
>> + * QDA IOCTL definitions
>> + *
>> + * These macros define the actual IOCTL numbers used by userspace applications.
>> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
>> + * data structure and direction (read/write) for each IOCTL.
>> + */
>> +#define DRM_IOCTL_QDA_QUERY		DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
>> +					 struct drm_qda_query)
>> +
>> +/**
>> + * struct drm_qda_query - Device information query structure
>> + * @dsp_name: Name of DSP (e.g., "adsp", "cdsp", "cdsp1", "gdsp0", "gdsp1")
>> + *
>> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device type,
>> + * allowing userspace to identify which DSP a device node represents. The
>> + * kernel provides the DSP name directly as a null-terminated string.
>> + */
>> +struct drm_qda_query {
>> +	__u8 dsp_name[16];
> 
> Are you sure that you want to query only the name? No extra options, no
> attributes, no hardware capabilities?
There are plans to extend this ioctl to support DSP capabilities and few
other query options, but as per my understanding, I don't need to add
reserved IOCTLs in drm case and I can extend it in future. Please
correct me if my understanding is wrong and I should add reserved fields.

Copying the statement from the doc[1].
"Note that drm_ioctl() automatically zero-extends structures, hence make
sure you can add more stuff at the end, i.e. don’t put a variable sized
array there."

[1]
https://www.kernel.org/doc/html/v7.0/gpu/drm-uapi.html#ioctl-support-on-device-nodes>

>> +};
>> +
>> +#if defined(__cplusplus)
>> +}
>> +#endif
>> +
>> +#endif /* __QDA_ACCEL_H__ */
>>
>> -- 
>> 2.34.1
>>
>>
> 

