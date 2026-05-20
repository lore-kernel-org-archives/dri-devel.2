Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E761CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B4110F099;
	Wed, 20 May 2026 14:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nH4BkxUo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dA29dCqB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6CF10F093
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:27:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCeWTq317544
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UVWE9cDv8dNKqJnEWb+COja9
 5369BrxIeUqGSeAbb1c=; b=nH4BkxUogTtNIAEqilLYHObEFJgMG/D/I6AWiKcL
 gT9NyuhjEGPJjace/hLozjlYcZwbwfFRV91CP0BVqIhyrSuMqAPCIZbA8DN4DmFf
 hPCU2ZDE10kkQJphfYXUm2hHwGa0fgb01ylh3m5ByFd7fO3pbFGfwg78Ei/yjEPx
 bEy7uXL7yQ4/2MmkCCp9OZCLGZw87F4k1zqBS7hN6HbS4XmsbpRN3vEAxPERoMfh
 kyFhQpagYlYoilMeAjBUkXjdv1eabc16L2No76klbeHFWzEMgpHjLZS52rLeiT3E
 83xZGGdUeH7D6rq+10rqZtA2QQj2bvO/QF2MgSdMzvgCqA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9d5qrd37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:26:59 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-575346e50c4so7009180e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779287219; x=1779892019;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UVWE9cDv8dNKqJnEWb+COja95369BrxIeUqGSeAbb1c=;
 b=dA29dCqBC8eMR6E0ZlabP0WONDkiLmOiIBb67caUltGxZrhLiAVFKAGsb71ooIz4kW
 dT/T1U+jnJ+t0m3MiP4gK0RD0MM/4mU9/G272nvkqT5zIGw5LXoMdqhYN/kLZaFhudVZ
 I0F3F2h8lje5nkkTxOlgprOTxRZsV12rcpafTdwxkodM1lWoCX/7tGdt4DdNouXSAIJl
 UpBew7fZ2/94B2HBFB6KrZqQfbo9yVHvIG3AB6KwYsRboBbw8FwiuJJWiF+wH5e/qYpq
 23697mkqC+p+h1ulPMXf3NudAG26/G5XC2ivdOO+S582L0fLpvIc8nSAgLQBiRdxJ9gY
 JESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779287219; x=1779892019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVWE9cDv8dNKqJnEWb+COja95369BrxIeUqGSeAbb1c=;
 b=RVEIq9qvUaObXACrsQS7R1Ul2RMqaJIvMKcknDA+RUhpMdNCDJhYGb19+h5s4nrANu
 gP+kWIoEe+mmTulyHXPJlqnor7mfma+1Q7s+N6PQClplCCLXWqZEbLqLVrRf8Rlaq2MV
 ACWNSstSWPLiwkZGVXnyV26kc94Q23UP1DvUy0ZGvVwlBeA1RSozz0KBmyiKKDFsQ7nT
 Of5U1if/xcQXQ9OgyBqyE3nzCfms/Tal0o0CFi/+INHJpwE9rXhCrVPD/QXBbhsdOFjo
 IAc37rh1WD/OLSbF3JKNeDiXaUc7+txmQ9+fpsQsrSAcKVjzCVPPMFKJDPCoYGCMwC+M
 fTbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97JnCpyhBE8LrQBsFTig6eKYwO8OaLrKEXweETyqaY/1rqcejyWmlM/MY3KJxZVA/b+OkoTXqFCsM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLRJ7D0W5eGYkgZcmD+8Pmy/0jZgTFQD0sTeuWtfd3VnyTREDm
 CFdsrYIwP2ZkLN62pdYobclozUPFOkgHvTSG2QiMCLqelIU1+1IkiU7WMfVqfEaZYSk6MdgVDRT
 vptXGeLAe4qGiLVloS73zcG9dXWDthH4EPTjc0Uduc1+J0AJX70lM5tQcICPacEzXlVBBbw8=
X-Gm-Gg: Acq92OFH4w4QWBj9+c/F5F5sq2oRoao65OyRS49WZFKKN6mKbYp/BNRYonHhmRkdSob
 cQPp75r8v5qMWmhNzJ/EFBaQ85jq/6fq2MKinkhLXGTf1ItOnWWdaW+o5sw6qQhiVYPh4Bs3XXt
 lRYQRwWcNPc0lsFmpgpiqUUDLt5+FitzxE0/y663w8lUW7w4J9Sn9WH359xybfzuaKUWsBXKoMK
 Ppn3fVSl3n1zoVHvxGkRY2cPUPhOUxf8Sl7+05pu+4uZyfwqVeqXj+4GN6L48ba6Pgaq6T1NFJg
 B5zZWjkS6BCZlJ0tkyYlHeiNFyzG9ouutVoOKSU3hzso96lEnjicbG2tGyQ8wuZtpDyHzcMyi6p
 Hrax7Wr990ooKQIsj7K2ccezYYybRdLODn5FpDXPBUO0vWE1ISxufNvwwMO6Q15boh6Al0lrQB5
 cLhGKkmFwRqmpmofMw9mG4QTXBVWN4raHwp4U=
X-Received: by 2002:a05:6122:4d0d:b0:56e:e80c:bb25 with SMTP id
 71dfb90a1353d-5760c0a673cmr14617904e0c.13.1779287219080; 
 Wed, 20 May 2026 07:26:59 -0700 (PDT)
X-Received: by 2002:a05:6122:4d0d:b0:56e:e80c:bb25 with SMTP id
 71dfb90a1353d-5760c0a673cmr14617821e0c.13.1779287218313; 
 Wed, 20 May 2026 07:26:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164c5a28sm4950743e87.61.2026.05.20.07.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:26:57 -0700 (PDT)
Date: Wed, 20 May 2026 17:26:55 +0300
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
Subject: Re: [PATCH 07/15] accel/qda: Add memory manager for CB devices
Message-ID: <sbktzorprxvo5625zkqwjgsaj723xtbsgzyypbnbgdbbxdgnnh@do5rprsx4oxr>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX4paJW/WibpRe
 nE8YTxFd+AADjmywatLyv+x1f13pLjG6eEPOdAQzKsKzso+KeBdaFvTdAI7zB5Y3mNwI419YsYf
 gFtbDCw52EUSUfHqYiTc4DPYrgqyuLjixOemz5MUuoi7JGhM4xSijLS/mAOWYNnAsz1H43gXTK/
 5kQEZZikzHH4ratvuXjIzXyknsIg1YOn/VqPTgH0aXvogPic9Qona+3eQGGhHp7gLL8j8h7yGNu
 GMrIEl+9cHW7/v5Mi9n5hQyU0XKUIMlenrmyIyGiS5vPlZADMhvZiKIDZhRUjUAAcoQjQuz/ZYH
 enZblbwpEwH64NIJXSWqERU4IctMvxco6VnsSrdBrkDUrngm8Sq5HSaCZHIqha7WRc1FhcY0ZVp
 y8QrzBrqL8DhXoayhx1Ts61EfN6KMxssj4HtyQ+H5q5/xlkoAqW36UdPt+t81hz37hDqvqtzy/D
 ATMkG+VrQO9hKASUcug==
X-Authority-Analysis: v=2.4 cv=QshuG1yd c=1 sm=1 tr=0 ts=6a0dc4b3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=U7MGAyCTa2LO6tN26UQA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: br9arWBtbqlgPD_rOMbOm2jBrmFYG_m4
X-Proofpoint-ORIG-GUID: br9arWBtbqlgPD_rOMbOm2jBrmFYG_m4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
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

On Tue, May 19, 2026 at 11:45:57AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce the QDA memory manager (qda_memory_manager) to track and
> manage the IOMMU devices that back each compute context bank (CB).
> 
> Each CB device registered on the qda-compute-cb bus is assigned a
> unique ID via an XArray and wrapped in a qda_iommu_device descriptor

Why do you need an XArray? The number of devices is (more or less)
fixed. You can use a normal array, allocated in the probe function after
counting OF children nodes.

> that records the device pointer and its stream ID. This registry
> allows the driver to look up the correct IOMMU domain for a given
> session when mapping DSP buffers.
> 
> The memory manager is initialised in qda_init_device() before CB
> devices are populated and torn down in qda_deinit_device() after they
> are destroyed, ensuring no dangling references remain in the XArray.
> 
> qda_cb.c is extended with qda_cb_setup_device(), which is called
> immediately after a CB device is registered on the bus. It allocates
> a qda_iommu_device, registers it with the memory manager, and stores
> it as the CB device's driver data so that qda_destroy_cb_device() can
> retrieve and unregister it during teardown.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile             |   1 +
>  drivers/accel/qda/qda_cb.c             |  47 ++++++++++++++
>  drivers/accel/qda/qda_drv.c            |  34 ++++++++++
>  drivers/accel/qda/qda_drv.h            |   5 ++
>  drivers/accel/qda/qda_memory_manager.c | 111 +++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_memory_manager.h |  49 +++++++++++++++
>  drivers/accel/qda/qda_rpmsg.c          |   7 +++
>  7 files changed, 254 insertions(+)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index 143c9e4e789e..701fad5ffb50 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_cb.o \
>  	qda_drv.o \
> +	qda_memory_manager.o \
>  	qda_rpmsg.o
>  
>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
> index 77caf8438c67..6d540bb0ec7b 100644
> --- a/drivers/accel/qda/qda_cb.c
> +++ b/drivers/accel/qda/qda_cb.c
> @@ -8,11 +8,42 @@
>  #include <linux/slab.h>
>  #include <drm/drm_print.h>
>  #include "qda_drv.h"
> +#include "qda_memory_manager.h"
>  #include "qda_cb.h"
>  
> +static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev, u32 sid)
> +{
> +	struct qda_iommu_device *iommu_dev;
> +	int rc;
> +
> +	drm_dbg_driver(&qdev->drm_dev, "Setting up CB device %s\n", dev_name(cb_dev));
> +
> +	iommu_dev = kzalloc_obj(*iommu_dev);
> +	if (!iommu_dev)
> +		return -ENOMEM;
> +
> +	iommu_dev->dev = cb_dev;
> +	iommu_dev->qdev = qdev;
> +	iommu_dev->sid = sid;
> +
> +	rc = qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
> +	if (rc) {
> +		drm_err(&qdev->drm_dev, "Failed to register IOMMU device: %d\n", rc);
> +		kfree(iommu_dev);
> +		return rc;
> +	}
> +
> +	dev_set_drvdata(cb_dev, iommu_dev);
> +
> +	drm_dbg_driver(&qdev->drm_dev, "CB device setup complete - SID: %u\n", sid);
> +
> +	return 0;
> +}
> +
>  int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>  {
>  	struct device *cb_dev;
> +	int ret;
>  	u32 sid = 0;
>  	char name[64];
>  	struct qda_cb_dev *entry;
> @@ -30,6 +61,13 @@ int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>  		return PTR_ERR(cb_dev);
>  	}
>  
> +	ret = qda_cb_setup_device(qdev, cb_dev, sid);
> +	if (ret) {
> +		drm_err(&qdev->drm_dev, "CB device setup failed: %d\n", ret);
> +		device_unregister(cb_dev);
> +		return ret;
> +	}
> +
>  	entry = kzalloc_obj(*entry);
>  	if (!entry) {
>  		device_unregister(cb_dev);
> @@ -80,6 +118,7 @@ int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
>  void qda_destroy_cb_device(struct device *cb_dev)
>  {
>  	struct iommu_group *group;
> +	struct qda_iommu_device *iommu_dev;
>  
>  	if (!cb_dev) {
>  		pr_debug("qda: NULL CB device passed to destroy\n");
> @@ -88,6 +127,14 @@ void qda_destroy_cb_device(struct device *cb_dev)
>  
>  	dev_dbg(cb_dev, "Destroying CB device %s\n", dev_name(cb_dev));
>  
> +	iommu_dev = dev_get_drvdata(cb_dev);
> +	if (iommu_dev && iommu_dev->qdev && iommu_dev->qdev->iommu_mgr) {
> +		dev_dbg(cb_dev, "Unregistering IOMMU device for %s\n",
> +			dev_name(cb_dev));
> +		qda_memory_manager_unregister_device(iommu_dev->qdev->iommu_mgr,
> +						     iommu_dev);
> +	}
> +
>  	group = iommu_group_get(cb_dev);
>  	if (group) {
>  		dev_dbg(cb_dev, "Removing %s from IOMMU group\n", dev_name(cb_dev));
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 6c20d6a2fc47..0ad5d9873d7e 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -57,6 +57,40 @@ struct qda_dev *qda_alloc_device(struct device *dev)
>  	return qdev;
>  }
>  
> +static void cleanup_memory_manager(struct qda_dev *qdev)

Prefixes...

> +{
> +	if (qdev->iommu_mgr) {
> +		qda_memory_manager_exit(qdev->iommu_mgr);
> +		kfree(qdev->iommu_mgr);
> +		qdev->iommu_mgr = NULL;
> +	}
> +}
> +
> +static int init_memory_manager(struct qda_dev *qdev)
> +{
> +	qdev->iommu_mgr = kzalloc_obj(*qdev->iommu_mgr);
> +	if (!qdev->iommu_mgr)
> +		return -ENOMEM;
> +
> +	return qda_memory_manager_init(qdev->iommu_mgr);
> +}
> +
> +void qda_deinit_device(struct qda_dev *qdev)
> +{
> +	cleanup_memory_manager(qdev);

Ugh, inline all your one-line wrappers.

> +}
> +
> +int qda_init_device(struct qda_dev *qdev)
> +{
> +	int ret;
> +
> +	ret = init_memory_manager(qdev);
> +	if (ret)
> +		drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", ret);
> +
> +	return ret;
> +}
> +
>  void qda_unregister_device(struct qda_dev *qdev)
>  {
>  	drm_dev_unregister(&qdev->drm_dev);
> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> index 2715f378775d..eb089e586b17 100644
> --- a/drivers/accel/qda/qda_drv.h
> +++ b/drivers/accel/qda/qda_drv.h
> @@ -13,6 +13,7 @@
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include "qda_memory_manager.h"
>  
>  /* Driver identification */
>  #define QDA_DRIVER_NAME "qda"
> @@ -40,6 +41,8 @@ struct qda_dev {
>  	struct device *dev;
>  	/** @cb_devs: Compute context-bank (CB) child devices */
>  	struct list_head cb_devs;
> +	/** @iommu_mgr: IOMMU/memory manager instance */
> +	struct qda_memory_manager *iommu_mgr;
>  	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
>  	const char *dsp_name;
>  };
> @@ -59,6 +62,8 @@ static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
>  struct qda_dev *qda_alloc_device(struct device *dev);
>  
>  /* Core device lifecycle */
> +int qda_init_device(struct qda_dev *qdev);
> +void qda_deinit_device(struct qda_dev *qdev);
>  int qda_register_device(struct qda_dev *qdev);
>  void qda_unregister_device(struct qda_dev *qdev);
>  
> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
> new file mode 100644
> index 000000000000..00a9c0ae4224
> --- /dev/null
> +++ b/drivers/accel/qda/qda_memory_manager.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +
> +#include <linux/refcount.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/xarray.h>
> +#include <drm/drm_file.h>
> +#include "qda_drv.h"
> +#include "qda_memory_manager.h"
> +
> +static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
> +{
> +	unsigned long index;
> +	void *entry;
> +
> +	pr_debug("qda: Starting cleanup of all memory devices\n");

pr_debug is a third way to debug. Stop it, please.

> +
> +	xa_for_each(&mem_mgr->device_xa, index, entry) {
> +		struct qda_iommu_device *iommu_dev = entry;
> +
> +		pr_debug("qda: Cleaning up device id=%lu\n", index);
> +
> +		xa_erase(&mem_mgr->device_xa, index);
> +		kfree(iommu_dev);
> +	}
> +
> +	pr_debug("qda: Completed cleanup of all memory devices\n");
> +}
> +

-- 
With best wishes
Dmitry
