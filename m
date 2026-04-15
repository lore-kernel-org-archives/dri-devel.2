Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BD2F43848
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A6E10E727;
	Wed, 15 Apr 2026 17:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJlDCc+P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L3ZZOKEh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7918A10E727
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:16:26 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FF4X42862252
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXvT4zjNncbaQTzuRUGDRSkWnu4bijnWhJgtWj2vfqg=; b=DJlDCc+P7kvAcR3W
 1i9+1MbX2YXxQYZ/Z48HaSJr9AdMUgXqCSWSChH6RoDXEE2xBPyKp9anBuYiWgxS
 bqS9J0ixRzZwbUaxsx6M9EtAnU0bUKxa17zlMssX+JUzW/RcLm9LWjHcfmH6Hagj
 q073QblXiX5Zec20+sZ/rKek5Wv46TrczYvsEH9l6hs1TPcj89bGrALmS14g7u4/
 lk+qWOq7Q3Ynwx/jB7RAcRVSRPd2vUaqjZa70JGyLcS8pJeuJUisDox8hLY3aeFR
 WmtZvKh4MTnzwgQjNEtyazblgy3ItIlwsOrJn3pbrBF9nDkIKHcxdDXZr+RYjJqv
 k9VjJw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd0e8f9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 17:16:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aad5fec175so100427085ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776273384; x=1776878184;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RXvT4zjNncbaQTzuRUGDRSkWnu4bijnWhJgtWj2vfqg=;
 b=L3ZZOKEhc/ezsd/eplkXsexGS8Dhfw0wxBs4ZVQyqswgAxjV/H5L0/Zn210lLYfwCh
 cGpQG72zvbbXPcu2RyqJSpZf54H7lew2RwNte+G4wPjjeR8wrPJgnzZk2h7wB72bzX2K
 kx8vhEhM7ZRbjD4JlPzzpIhA/GSs89N4IaC68d663fEXUnPfukycVdDaQvJXKvQFsyIx
 d1rpPClJObR7fVfNUr8NuGChiM7w/LxEDRu7STn0XjuGqk1hS6VWRcAR10+7DjcGlF4k
 i/EQ5rmqwQFk5h2r6K4ehgcOoaDh1RD152kxT7o8Gmb5CvsBIKlVzfbKo0/h3i7kfyYh
 4pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776273384; x=1776878184;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXvT4zjNncbaQTzuRUGDRSkWnu4bijnWhJgtWj2vfqg=;
 b=EacgQ2XeplhtxUGHDcTUG0MV7nUdvJwrUrM5dOOZ2HmNotxtVFWOB+TrsbvZ++Mgo0
 lcPomM+2z9dc9KeNmWfpuQy8lk5N/5dM7rfthY6CtucXdzTI5XFcJYqkA0wwoIbgXosJ
 e2Ki8u6wFAmBJ6LnhGWF3RiteznsGmlNZSuoZHVJyFwGbPvMlPnD9BbfVjVvi/AJ03M5
 wiB3xv30J0ro2pBjfmt6TRtA/syPyM/qmXCFv/9EzO1nq1OyBy66Yy30Ua3Y5dW4mrZ9
 guf7cRS4da6Tf2KUqYUFLXroKHScB8EydS9n+dl8wuxFGCIQPmmxUIsuRsLhmFQVpTzG
 XahQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92jKgFT69/tF9ZkGuUEt8069qXW5fo/FTmB2iGlwNAqkAFPzYpAHhE72gfMYbJ8P9D63yHBxE0Gac=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMNl9PJfzUqEr6X/iJiDNtkgYaw5TEhZt3NnhwtAFZyiy7N3jb
 7rhxSAenSuZ8/qBcqw2LejoQjpUOiS7j7UZ1PJh4LMqYuiFVmb06/5w74DEamznk7TdLkb4quwY
 1QJxkvJDa2Dj/H2bxey6nnmCez/WVIKGH5hscWsDnPX4atUPTD4T9CahLo4Fm6DS89oD/Nio=
X-Gm-Gg: AeBDies0ogXZSsVcNQOMKOxSOex6Uvl7TMAW6YG1UDV0nTdx0oogOsiyx7Inxf35TuS
 ZOdYvQP+gH7UFIQ3DyinQaEpB+xsRq3xJQoh+6MgsJT769JjJfYPENMXLc2Wxk+VCVM59D4LHqs
 xhWARLzXdyBchLefDiCYlr2fRKNiTjFcnPvtMGYpqb1K/37G7yi2kwlxvYFz0jqu55J0hNt5rKY
 C55x0wCkKhciYB9fg3AtQZrALOx3LhkOIrgsufCVLddcvf8mDCHHLXlmMtgcgJ2zXq3J37aGU1v
 6UgZp0iR7DDp1Z00WYRqeDgBfgjPPpQ+VbWFRtX4+6eDyjBvo4kbUP6NF5I2D//JLXvnRAwHbwP
 QuO20X9PuGaVMB4XJxxbXUxECuNAENkKRCMyhw8m8EMAkp4433h7uWg==
X-Received: by 2002:a17:902:cf05:b0:2b2:42da:25c4 with SMTP id
 d9443c01a7336-2b2d59adee5mr234505615ad.14.1776273384140; 
 Wed, 15 Apr 2026 10:16:24 -0700 (PDT)
X-Received: by 2002:a17:902:cf05:b0:2b2:42da:25c4 with SMTP id
 d9443c01a7336-2b2d59adee5mr234505285ad.14.1776273383593; 
 Wed, 15 Apr 2026 10:16:23 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826e306sm27292945ad.46.2026.04.15.10.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 10:16:22 -0700 (PDT)
Message-ID: <75191131-2eb5-a7d3-0222-8c03a5ded45a@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 22:46:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] drivers: base: Add generic context device bus
Content-Language: en-US
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srini@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rVjkcMTA2y3VHlcR5D9-5ZDRlS9qJJP6
X-Proofpoint-ORIG-GUID: rVjkcMTA2y3VHlcR5D9-5ZDRlS9qJJP6
X-Authority-Analysis: v=2.4 cv=GP441ONK c=1 sm=1 tr=0 ts=69dfc7e9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=m666xMD4OwuZyzqZ95sA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE2MSBTYWx0ZWRfX9XsqkZ3efaro
 YQFRy/DcwMo+Z+4vaOpDTpRGqISWqyHKHQ4fN/kq8b7Z7rPXP31b/qGO7WRjsv6O8Cbzlzh7YKQ
 93GDmmQmomDV/cDnsvDpgBQkFhVWiATOT0uCYVPo97SRmad0mUyZFzfvVHaaZN17xAflKOTDby4
 9nQwQXNrMHQO9giPuR2JJO+ia0GMh9eXsX6yalQYUycWrRrpYUBvRN2SEoyAyNe6nZTXem/paqA
 3l6CdC0XdI9jkQhbOpgFvstrYSBhaeVUF+0FMM/V6wpLhi0MBXNa3zwwLS9RHT6M8V3lluNo8w+
 JWEKLFLyZ12jftSRwQ87mmlnynxJIOdCmjowmaaYHpmF1AOF6qwiByGDvKZgMAAtrBQjWB05DJJ
 IOK0u6122ShKLo97rGTKznHwPJL7HeRLZzjDYz4k3WaTn3ueq51p8j41fq32b+An1lAC+r9nt+M
 xjF/Pc/JlPgJsj/5nCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150161
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



On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
> Introduce a new generic bus type for synthetic context bank devices
> that require IOMMU context isolation. This bus provides a shared
> infrastructure for accelerator and GPU drivers that create virtual
> devices representing IOMMU context banks.
> 
> Currently, drivers like host1x implement their own bus types for
> context devices. This generic implementation allows multiple drivers
> to share the same bus infrastructure, simplifying the IOMMU subsystem
> integration and reducing code duplication.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>   drivers/base/Kconfig        |  3 +++
>   drivers/base/Makefile       |  1 +
>   drivers/base/context_bus.c  | 24 ++++++++++++++++++++++++
>   include/linux/context_bus.h | 15 +++++++++++++++
>   4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index f7d385cbd3ba..479bc4bb442b 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -4,6 +4,9 @@ menu "Generic Driver Options"
>   config AUXILIARY_BUS
>   	bool
>   
> +config CONTEXT_DEVICE_BUS
> +	bool
> +
>   config UEVENT_HELPER
>   	bool "Support for uevent helper"
>   	help
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 8074a10183dc..ab9a0b2dc73b 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -8,6 +8,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
>   			   topology.o container.o property.o cacheinfo.o \
>   			   swnode.o faux.o
>   obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
> +obj-$(CONFIG_CONTEXT_DEVICE_BUS) += context_bus.o
>   obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
>   obj-y			+= power/
>   obj-$(CONFIG_ISA_BUS_API)	+= isa.o
> diff --git a/drivers/base/context_bus.c b/drivers/base/context_bus.c
> new file mode 100644
> index 000000000000..6ddb6c27bf69
> --- /dev/null
> +++ b/drivers/base/context_bus.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +
> +#include <linux/context_bus.h>
> +#include <linux/init.h>
> +
> +const struct bus_type context_device_bus_type = {
> +	.name = "context-device",

add the .dma_configure callback instead of calling from the client driver.

> +};
> +EXPORT_SYMBOL_GPL(context_device_bus_type);
> +
> +static int __init context_device_bus_init(void)
> +{
> +	int err;
> +
> +	err = bus_register(&context_device_bus_type);
> +	if (err < 0) {
> +		pr_err("context-device bus registration failed: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(context_device_bus_init);
> diff --git a/include/linux/context_bus.h b/include/linux/context_bus.h
> new file mode 100644
> index 000000000000..0cd44cb5b147
> --- /dev/null
> +++ b/include/linux/context_bus.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __LINUX_CONTEXT_BUS_H
> +#define __LINUX_CONTEXT_BUS_H
> +
> +#include <linux/device.h>
> +
> +#ifdef CONFIG_CONTEXT_DEVICE_BUS
> +extern const struct bus_type context_device_bus_type;
> +#endif
> +
> +#endif /* __LINUX_CONTEXT_BUS_H */
> 
