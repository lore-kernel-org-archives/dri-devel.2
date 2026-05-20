Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6958ECD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0FBC10F076;
	Wed, 20 May 2026 14:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZmVQFG/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7Pk2z7d";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA81110F076
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:29:53 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K8vCss4115900
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pxOt6IK/i3ibZ79BpGFSHKfb
 P+cfEih0yG4dCpDnkIo=; b=eZmVQFG/A3xV3qUS4A0vUqI9P0C7ARkGzo0UX+4z
 ttYkvelNRt8/3mtaxRtZiGQMTYFTeZa0qD+e+bbTtQHPMtb1q4FYEuaA+E6SpUun
 Rx865+RpRmohzVR612Om1+ptNWx/pRYRS3zumRhYDpLpUS8x9iJiLkusgJmgrPR1
 9tIDn/ZN/vkOXo416xZlg4nJ6VktEK112DGJ6p3UWQ3vbesOi1ZExRo3Nsy/p4H2
 WHiuTbU8kIvFlttlPUhPEDnlSV37cheZyCntY42NL/EsMEsbGpG+KF0imZCp9Peq
 hCYYKSLFaSysZA8ODrnuxfkbMTqKpPyj8oz87joZg74c8g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0h7qm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:29:52 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-575958d4e01so13204526e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779287392; x=1779892192;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pxOt6IK/i3ibZ79BpGFSHKfbP+cfEih0yG4dCpDnkIo=;
 b=F7Pk2z7dcM5X0wZJPh9WaFLPS0t2+erPzKWVaTBUP7UIocKnDN+uI4f8DoB3pOzRc7
 S+Gv5WvHUG1e0gz5j06MMk+s5655qSze1Duo2VKh8qz7gtAoY+wV3xEVr4MLXU/lg7A/
 cOkGbFkEMRaL9riD2r4pRSggyPpASUP83UH8NYLP0VVGVKdg0kJvJpoonauH3Ks/jMFf
 s+9huy6O36artVuoVUt58xwwDTjMcfm+xTDnuL/2LLSsga2zcTq+kRYgtl0M5FfJgiKu
 hV3/B3QhVwf2Dp8iyLq2N6REPYNvuMJHRrq8g9ThwWH0rw+P9DfPUfNaFsjyW0s6XFqT
 hxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779287392; x=1779892192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxOt6IK/i3ibZ79BpGFSHKfbP+cfEih0yG4dCpDnkIo=;
 b=M/rCpSotXtxV+vqfBg029a2ra6E0wMuRqlv4vh9BORaBAZDjsbTRmIfhMMNe/QcQGv
 toNs0RcqxfjJV1vEdSjbP5Wx0kcS7tEmFz30qgX45ZNK2fRwFm2n84EdpVzQn5d351E8
 4f0QcDbtzxTS0gXt9xQ1IuP0xA8FsOuVMogqLsn66lhvsyioVgNieWj1vrDIBBI9P22k
 lbrgFEygw3tE4GeV9MWZNzN8XTDHDFnteBKnD9NUF3BBqd4geBB1nyrMLzp/ZxzUBUUc
 Ab7Nwmaw+PVaist3GrQSbQoo5FoETMjTVqMNumImK/+mSejofrTrA51yrDuQSkFj0pZ9
 YRDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kz4hRQ5rKspBMJw5w8J1a9k3cYJFGHGslvE/9Xj85OXH/zoa9b7xQeCkzLVNjr2wcywgpmse4RWY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoSAPgMTNqoz3ksAhX0fo6GpwkDrd4R5GxVI+zXxCRVm+nqpfi
 +MAa2zojxvATNAu2k6/WvWk+Nf2IVC9vff9wa+hNFUI+VePGfn0rH3M/yO19kG/JFalOxUYztky
 33bGt0whwH2R1mwwjHNqzbWN1e3NnymdgGPIfbbxmt95HySWrMyKZLvOGaUfWmYXqHBPoUak=
X-Gm-Gg: Acq92OEf2bZ7FxGfiZbPrKyn4nXli1joR5aKgiGEAcahZRzdpcoWUxo2T4N9OW4N9WK
 DlahBwg68/vJID1C69UMX+1onpP+WPXrJCpdNbXqB8l8mYEdMHCON4g68UDq756cUFjcOVUz/FY
 Ff7dpAHLZBQBEjinpS3W7J/+ibBe3/ny4+YvX8kiv+D4enUqEsYgXv6cx3H4MF8Z3fBceWakjn5
 5TWG5ETk/NoANcBB6EOfcHvRvCdPecxRYLtrCiGkjDtjwd7IrOMW01VZ/CRhkE5MaGXv869cEYn
 TOrSpeGs2Nm+WN75yfyVFJ1Lk5KgJpiP/H3634Mda746mBR9oEQZrqRFu1RBnFZNPbA4slFs95G
 Mpcuf7HqtKtiNAwipscle3uet7f4Lb/ry1PSE8gAuz1dMBvr4UJbgbNHSABZqiukGlnWAMDKhmW
 k1dDK8yDLKVQS2ThCc70UufmyEHxN1InsbHV0=
X-Received: by 2002:a05:6122:910:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5760be33374mr13875369e0c.3.1779287391865; 
 Wed, 20 May 2026 07:29:51 -0700 (PDT)
X-Received: by 2002:a05:6122:910:b0:56e:e9cf:7134 with SMTP id
 71dfb90a1353d-5760be33374mr13875318e0c.3.1779287391196; 
 Wed, 20 May 2026 07:29:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164cf0a5sm4942878e87.75.2026.05.20.07.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:29:50 -0700 (PDT)
Date: Wed, 20 May 2026 17:29:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
Message-ID: <m4zo2nkxtl5yeyo7riuata6r5saflmdgqf37cz2g2ezrwhk53m@mnad6bb7n3ik>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-8-b2d984c297f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-8-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SNY_tB_vyI2hVUNmkhGcamcakaLwQaGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX0Vpz9YMpFp4b
 fyyrvHLd5Zvqm7u4bbShnpTF37kVj64y8EbWdxuKY0MNL/YgG7pFPuLv0D1ItmKlIfKjXSs9I6n
 1iMBg7FLwWTXu5OXIT8Hk16JATNurL5RXENrxX+nmrC4cNxBdh1u0iW0vrXkJJcR65UCKNtUTOy
 vOtYBJdF+TSKqHP7Cg4xsBn6b3eChrFmJns8AUYDldC9IYAJxzkz19oTR/1AbQmqd81QX6ZYxbL
 AsFfb3xf9/Vw1/CWl+odPhR+O8GkQ3x2fG/UPxR3pVKkijn9w6BpkQWpsRnpqxdChJJFfH2sSBb
 dn7WaqRay4fruYXi4ILFDObHyRs/CQNvI8TsfWKp0xUHYDe7xCnPpXczHf3/4nQlxe/y3OSiyOx
 c2d6LTx3Bc2rexW85ijJPjm5fZt0CBPbU3gXpqZDiyNx0i3L9WF6T9mzdunlcSJPTMgu2c3V95I
 GVdci+oudtJoZ2vg58A==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0dc560 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=KrLRuONc4nWYnVYYFb0A:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: SNY_tB_vyI2hVUNmkhGcamcakaLwQaGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200141
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

On Tue, May 19, 2026 at 11:45:58AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce the DRM_IOCTL_QDA_QUERY IOCTL, which allows user-space to
> identify which DSP domain a given /dev/accel/accel* node represents
> (e.g. "cdsp", "adsp").
> 
> include/uapi/drm/qda_accel.h
>   Defines the QDA IOCTL command numbers and the associated data
>   structures. The header follows the standard DRM UAPI conventions:
>   __u8/__u32 types, a C++ extern "C" guard, and GPL-2.0-only WITH
>   Linux-syscall-note licensing.
> 
> drivers/accel/qda/qda_ioctl.c / qda_ioctl.h
>   Implements qda_ioctl_query(), which copies the DSP domain name
>   stored in qda_dev.dsp_name into the user-supplied drm_qda_query
>   buffer using strscpy().
> 
> drivers/accel/qda/qda_drv.c
>   Registers the qda_ioctls[] table with the drm_driver so that the
>   DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile    |  1 +
>  drivers/accel/qda/qda_drv.c   |  8 +++++++
>  drivers/accel/qda/qda_ioctl.c | 26 +++++++++++++++++++++++
>  drivers/accel/qda/qda_ioctl.h | 13 ++++++++++++
>  include/uapi/drm/qda_accel.h  | 49 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 97 insertions(+)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index 701fad5ffb50..b658dad35fee 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_cb.o \
>  	qda_drv.o \
> +	qda_ioctl.o \
>  	qda_memory_manager.o \
>  	qda_rpmsg.o
>  
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 0ad5d9873d7e..becd831d10be 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -8,8 +8,10 @@
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
>  #include <drm/drm_print.h>
> +#include <drm/qda_accel.h>
>  
>  #include "qda_drv.h"
> +#include "qda_ioctl.h"
>  #include "qda_rpmsg.h"
>  
>  static int qda_open(struct drm_device *dev, struct drm_file *file)
> @@ -36,11 +38,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>  
>  DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>  
> +static const struct drm_ioctl_desc qda_ioctls[] = {
> +	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
> +};
> +
>  static const struct drm_driver qda_drm_driver = {
>  	.driver_features = DRIVER_COMPUTE_ACCEL,
>  	.fops = &qda_accel_fops,
>  	.open = qda_open,
>  	.postclose = qda_postclose,
> +	.ioctls = qda_ioctls,
> +	.num_ioctls = ARRAY_SIZE(qda_ioctls),
>  	.name = QDA_DRIVER_NAME,
>  	.desc = "Qualcomm DSP Accelerator Driver",
>  };
> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> new file mode 100644
> index 000000000000..761d3567c33f
> --- /dev/null
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <drm/drm_ioctl.h>
> +#include <drm/qda_accel.h>
> +#include "qda_drv.h"
> +#include "qda_ioctl.h"
> +
> +/**
> + * qda_ioctl_query() - Query DSP device information
> + * @dev: DRM device structure
> + * @data: User-space data (struct drm_qda_query)
> + * @file_priv: DRM file private data
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
> +{
> +	struct drm_qda_query *args = data;
> +	struct qda_dev *qdev;
> +
> +	qdev = qda_dev_from_drm(dev);
> +
> +	strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
> new file mode 100644
> index 000000000000..b8fd536a111f
> --- /dev/null
> +++ b/drivers/accel/qda/qda_ioctl.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_IOCTL_H__
> +#define __QDA_IOCTL_H__
> +
> +#include "qda_drv.h"
> +
> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
> +#endif /* __QDA_IOCTL_H__ */
> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
> new file mode 100644
> index 000000000000..1971a4263065
> --- /dev/null
> +++ b/include/uapi/drm/qda_accel.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_ACCEL_H__
> +#define __QDA_ACCEL_H__
> +
> +#include "drm.h"
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +/*
> + * QDA IOCTL command numbers
> + *
> + * These define the command numbers for QDA-specific IOCTLs.
> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
> + */
> +#define DRM_QDA_QUERY		0x00
> +
> +/*
> + * QDA IOCTL definitions
> + *
> + * These macros define the actual IOCTL numbers used by userspace applications.
> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
> + * data structure and direction (read/write) for each IOCTL.
> + */
> +#define DRM_IOCTL_QDA_QUERY		DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
> +					 struct drm_qda_query)
> +
> +/**
> + * struct drm_qda_query - Device information query structure
> + * @dsp_name: Name of DSP (e.g., "adsp", "cdsp", "cdsp1", "gdsp0", "gdsp1")
> + *
> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device type,
> + * allowing userspace to identify which DSP a device node represents. The
> + * kernel provides the DSP name directly as a null-terminated string.
> + */
> +struct drm_qda_query {
> +	__u8 dsp_name[16];

Are you sure that you want to query only the name? No extra options, no
attributes, no hardware capabilities?

> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* __QDA_ACCEL_H__ */
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
