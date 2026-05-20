Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B6DCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B0A10E454;
	Wed, 20 May 2026 14:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALUpjjFB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UPftkqJD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1046E10E454
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:19:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuZMf3680433
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jjNnASAt5iqKMaT3xE7uUJEpw63hfaVPY06gYhwCG3U=; b=ALUpjjFBst8BY3aC
 gOVk9qIAjwkF0BFDiaZNf9nqmOMsjJs6YBOZjvUYoyjzKJES5I7Bp9/7wErcw+ka
 PTYeKXlYY4eWoga3fIvf3iTh2CJeSoj/e5gh3qPEzZ755lLiqL2uld+bypupgzR/
 5Jklc/hboMwP9hjsGRxAom9Y8z1w8hi0tF3293ei998qkwD7ZZ+QAh4orsZdepl5
 ztd1OxFWfW4p2FRevkhHwf6Bukfbko9l9a5ae13G1ug/Ycoh7ime1IE9ldm4XOe9
 xwxCl0VV+4rZ9WFmR3xSyBuuhTqD4MkHKBSeVhD9ncwVBi+n8mdgyxlm8jox0fPh
 zhtsoQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j02u1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:19:30 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-439e3568bf0so6006633fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779286769; x=1779891569;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jjNnASAt5iqKMaT3xE7uUJEpw63hfaVPY06gYhwCG3U=;
 b=UPftkqJDFZE19NSD+GilwZqiq+TTCW9TYRQWHyjvXuIX8RjGGxZ1o9odJbeK0vq+oU
 dKiEc4e1KYvm+tyRZb0mD9AoxJ3X2lXWaXOhG/1GHKZfvLWUgQ/m4d+P/Z6cIHiXv2Ej
 9O2KAKmdxoFBfuurlzUuUltuDnppCBmoPvpK4TvGkd+PBdlcvZGMNin65uix5jAND0bd
 hsIW4CCwmWcm82PWJswVb8zzt0ZUVUUEoT7m5Z2e1b7n8i1ScZO+JlkVOA0g1mcU5+4l
 QYJRViOt6NILzNs5q3Tze4+kVIWNgUPNtDR5e8fFhC3u/mt6eZp6RC58saBZ4MC34A2H
 Ujnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286769; x=1779891569;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jjNnASAt5iqKMaT3xE7uUJEpw63hfaVPY06gYhwCG3U=;
 b=bDz07g4Lbwue5CY2P9dBQY7I1ZyQaoXpBPKHMBJWN68xN1SpXY+9Lxo8FEeeZfi4fm
 /PFV6PS0Wkg4x2s/69ZgYWrSTwf4+KbRnyFnFW5xsV/IqauLb5dXnAZNnON0C2tOvqnk
 1bijI5HnGUQgX4T6j1nMjJRfsMUNYrVSRiPvFHFJSGXVVkCAQEjk5T0ksJRyLo2pOGhE
 RuBxZnJ5tNSRr2+8p2ZPEqdHyg1hVuGQALQ6fekXAhZCR5Dq255nYLyILx+eHJAqp1rw
 zGKBuoFYMVRDbDmOCkdg0aVPuPKwwoYj79bXqoEEFYpOR20oXePPzG3YbUAWOQ247X58
 9nTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+qkUb4ceLlcYDgcdYDFaQDRVuV34GCfVh8pBgWZbcQ9WWpKHIeTIxmxjsiuiKTFRxjeSPvffzTsg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzwko/b2YCgUCzXyXssaJb+jQ6sdCElLKHxottW9YF0wKN/hRTt
 zRIVLEc97NB9/VpyaS/5/7Dsx8bsOs9jAs8vSe2b6O93QbFkw70pyvullduv+0jktfBqCklQNr4
 DJ1AqjBYTFuUfMi9kM1CYi95izNy6L4Or/dSNeIFohXMQqfgt1dMsu9vf7C0Wza/ZsI8ORp8=
X-Gm-Gg: Acq92OFG8mxV+tJgOTjtY6gNCATkbl2AFsiqRt35T3orkOJlEncE0FnEu+EKNqGhLZ/
 RtW8kqrUymiM+agKgCUxo0PwcDvZoDfrFFp7I0KDDqqroU2Kdo51LflwmZ8CDL4mV7KB7j4pj8z
 8Ij4ThypC4YhHFqXinwVrVJ9aePDQg9v7xE2UlMpGum5WIl/6p1F6o2+7Q5PWmqwBlpD9zugAgM
 /W8VWKiTH91iHrQ3PHY8k4BIOMDEfd0QxI8KAuGwuwVHZwTOhNTkJ1YjJ9hPbOcAsr9UdLmnQ7x
 cg7sFKYqilChlYU9NFMUhbpllZ/0jzFeD06mwJhi+z/okj01/xv+NssXv4bz+KBzUv6h8J0rWXY
 okax3nFlcAWoWnwARyC3IkTF3rgnaFZ4JzBHHCCwy6AXpzkqXNy04FGasmAewceY3rm6/r+I3YF
 XlWtx3DwcvnZ/iN35nrLLcB6X/M0gnpVO91Z4=
X-Received: by 2002:a05:6820:4b8c:b0:699:90a5:106b with SMTP id
 006d021491bc7-69c942f73a1mr14792741eaf.24.1779286769479; 
 Wed, 20 May 2026 07:19:29 -0700 (PDT)
X-Received: by 2002:a05:6820:4b8c:b0:699:90a5:106b with SMTP id
 006d021491bc7-69c942f73a1mr14792713eaf.24.1779286768912; 
 Wed, 20 May 2026 07:19:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc462sm4990268e87.45.2026.05.20.07.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:19:27 -0700 (PDT)
Date: Wed, 20 May 2026 17:19:26 +0300
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
Subject: Re: [PATCH 04/15] accel/qda: Add compute bus for QDA context banks
Message-ID: <gnlpw4ijwtjv43nhcv5iirhjnuc7dntx5vucdrhnxeyznyxa5x@t65o5owldu5s>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-4-b2d984c297f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519-qda-series-v1-4-b2d984c297f8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dc2f2 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=cV-vn9ENGD0yosCfWX4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-GUID: L86dZBvF3Dw1SzQweFoxNXFDEMkYvOgO
X-Proofpoint-ORIG-GUID: L86dZBvF3Dw1SzQweFoxNXFDEMkYvOgO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzOSBTYWx0ZWRfX00C8d+SsSvUl
 rAQeK2iBnzDqboDPQjXkB/you2sKFf+lI68mkkLgdsr0YI2gdtOz3giyfUcoq3VS/7fGuxQwvoQ
 s1zXWe8N+WHztxGAg2SH0Yo3F9s8YA1nBrSDgVw1+9GE52teKItiJcKf2RsaB8MqFEG7R8SRd/c
 P8bVlR8jEscz6B9pm3u/rFxS/a53jVMi896rRKW95YexJTpkiJTT8DcHl/jgEu6635sCGgomEHS
 YG4RHnoZXcSTa6BeKySdYZaF15xrjexzxhpG+CFS2LlcQYw/c+pMpK1K05nsqNkf4qEOexr3v6b
 tGgZN+c/gepGVd9q1db7eOqyl2obqzEd3mbZ+KtmOluUCOemgBoGv5KLNATKoKyhLLg8vy0PJiT
 g1qvYoFw4ucwZ8vhGgY8A3TvGikexd3hpyAiOvdSFPMKXeDlEKiwCEesPgYUNSrgvWgTOha9Dyu
 yZHJknI8bxXwEwDhN1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200139
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

On Tue, May 19, 2026 at 11:45:54AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce a custom virtual bus (qda-compute-cb) for managing IOMMU
> context bank (CB) devices used by the QDA driver.
> 
> IOMMU context banks are synthetic constructs — they are not real
> platform devices and do not appear as children of a platform bus node
> in the device tree. Using a platform driver to represent them was
> therefore incorrect and introduced a probe-ordering race: device nodes
> were created before the RPMsg channel resources were fully initialized,
> and because probe runs asynchronously, user-space could open a CB
> device and attempt to start a session before the underlying transport
> was ready.
> 
> The qda-compute-cb bus solves this by allowing the main QDA driver to
> create CB devices explicitly and under its own control, making their
> lifetime strictly subordinate to the parent qda_dev. The bus provides
> a dma_configure callback that calls of_dma_configure() so that each CB
> device gets its own IOMMU domain derived from its device-tree node,
> enabling per-session memory isolation.
> 
> The bus type and the CB device constructor (create_qda_cb_device) are
> exported for use by the QDA memory manager.
> 
> A hidden Kconfig symbol (DRM_ACCEL_QDA_COMPUTE_BUS) is introduced and
> automatically selected by DRM_ACCEL_QDA so that the bus initialisation
> runs via postcore_initcall before any QDA device probes.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/Makefile              |  1 +
>  drivers/accel/qda/Kconfig           |  4 +++
>  drivers/accel/qda/Makefile          |  2 ++
>  drivers/accel/qda/qda_compute_bus.c | 68 +++++++++++++++++++++++++++++++++++++
>  include/linux/qda_compute_bus.h     | 32 +++++++++++++++++
>  5 files changed, 107 insertions(+)
> 
> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> index 58c08dd5f389..9ed843cd293f 100644
> --- a/drivers/accel/Makefile
> +++ b/drivers/accel/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
>  obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/

Ugh. The previous line should be enough (but don't trust me).

>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
> \ No newline at end of file
> diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
> index 484d21ff1b55..2a61a4dda054 100644
> --- a/drivers/accel/qda/Kconfig
> +++ b/drivers/accel/qda/Kconfig
> @@ -3,11 +3,15 @@
>  # Qualcomm DSP accelerator driver
>  #
>  
> +config DRM_ACCEL_QDA_COMPUTE_BUS
> +	bool
> +
>  config DRM_ACCEL_QDA
>  	tristate "Qualcomm DSP accelerator"
>  	depends on DRM_ACCEL
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on RPMSG
> +	select DRM_ACCEL_QDA_COMPUTE_BUS
>  	help
>  	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
>  	  This driver provides a standardized interface for offloading computational
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index dbe809067a8b..424176f652a5 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,3 +8,5 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_drv.o \
>  	qda_rpmsg.o
> +
> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> diff --git a/drivers/accel/qda/qda_compute_bus.c b/drivers/accel/qda/qda_compute_bus.c
> new file mode 100644
> index 000000000000..c59d977e924d
> --- /dev/null
> +++ b/drivers/accel/qda/qda_compute_bus.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/qda_compute_bus.h>
> +#include <linux/slab.h>
> +
> +static int qda_cb_bus_dma_configure(struct device *dev)
> +{
> +	return of_dma_configure(dev, dev->of_node, true);
> +}
> +
> +const struct bus_type qda_cb_bus_type = {
> +	.name = "qda-compute-cb",
> +	.dma_configure = qda_cb_bus_dma_configure,
> +};
> +EXPORT_SYMBOL_GPL(qda_cb_bus_type);
> +
> +static void release_qda_cb_device(struct device *dev)
> +{
> +	of_node_put(dev->of_node);
> +	kfree(dev);
> +}
> +
> +struct device *create_qda_cb_device(struct device *parent_device, const char *name,
> +				    u64 dma_mask, struct device_node *of_node)
> +{
> +	struct device *dev;
> +	int ret;
> +
> +	dev = kzalloc_obj(*dev);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->release = release_qda_cb_device;
> +	dev->bus = &qda_cb_bus_type;
> +	dev->parent = parent_device;
> +	dev->coherent_dma_mask = dma_mask;
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +	dev->of_node = of_node_get(of_node);
> +
> +	dev_set_name(dev, "%s", name);
> +
> +	ret = device_register(dev);
> +	if (ret) {
> +		put_device(dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dev;
> +}
> +EXPORT_SYMBOL_GPL(create_qda_cb_device);
> +
> +static int __init qda_cb_bus_init(void)
> +{
> +	int err;
> +
> +	err = bus_register(&qda_cb_bus_type);
> +	if (err < 0) {
> +		pr_err("qda-compute-cb bus registration failed: %d\n", err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +postcore_initcall(qda_cb_bus_init);
> diff --git a/include/linux/qda_compute_bus.h b/include/linux/qda_compute_bus.h
> new file mode 100644
> index 000000000000..90bf248c7285
> --- /dev/null
> +++ b/include/linux/qda_compute_bus.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_COMPUTE_BUS_H__
> +#define __QDA_COMPUTE_BUS_H__
> +
> +#include <linux/device.h>
> +
> +/*
> + * Custom bus type for QDA compute context bank (CB) devices
> + *
> + * This bus type is used for manually created CB devices that represent
> + * IOMMU context banks. The custom bus allows proper IOMMU configuration
> + * and device management for these virtual devices.
> + */
> +#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
> +extern const struct bus_type qda_cb_bus_type;
> +
> +struct device *create_qda_cb_device(struct device *parent_device, const char *name,
> +				    u64 dma_mask, struct device_node *of_node);
> +#else
> +static inline struct device *create_qda_cb_device(struct device *parent_device,
> +						  const char *name, u64 dma_mask,
> +						  struct device_node *of_node)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +#endif
> +
> +#endif /* __QDA_COMPUTE_BUS_H__ */
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
