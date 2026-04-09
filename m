Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FBAF364B7
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1075910E09E;
	Thu,  9 Apr 2026 20:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PxUzx8To";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R+A+V/qf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33EF310E09E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 20:20:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639Eqlfw115215
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 20:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XGZaqfqEzO+/hDjbxaHef3zkJZ++VUfNhigynidW4X0=; b=PxUzx8ToDQhoK1Be
 IGU+KqUqBw99BU4FFGeUf9SIOYzMM2vHaItFSklYh6ZH6h0EyWgyjDK3AicWVuDk
 4oJ5ScRtSvJT+457O3v7toxLjh0VgtmtxYh9CxI6LVVH7nmB8GhLR7xC4vK+Y9aO
 XoQOXD85sg3/dXxr/6GOmplHVlFvsTyWpiTwCxiY0r48jhKQh21dKB5PxXVkdVLy
 PYSt2z3rB5u9QORFtvo75s5/1TGCwUjZatAZWy7lOsOzODd5mApKDPA+wrHk6SPa
 rBHujfdtdbOYLJwwHGUa851injEWAOPCAsLRVajoMcxKY2fq3jpf8S4kUuAGwG9q
 XviMsQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8x956y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 20:20:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bdc1b30ac8so5224579eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775766006; x=1776370806;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XGZaqfqEzO+/hDjbxaHef3zkJZ++VUfNhigynidW4X0=;
 b=R+A+V/qf/GoAYnTrAkslPx3zPugCJqmgrEJDM3CL0EK70ZJp1xPBNXdHM5+/Cj8qNz
 7i+1qSXGz9qPurBetA3GXDl4K17y1jhi+XSPceEnNSWcdo7Z1Ys8L+IsMz60b5Okm3jq
 oe4yvhSkBTw6FcleatTeRd+bja0H6+B82gyuCV0NXJSYT2bL4LuXRxKxVBgIUeYe+q7y
 GPh7ze8471FVG9yVSxK28n1uVrsarKQMmfn+FJf/NjRLOi/s3OaSE/oSa3H1PSVAMJnJ
 UPamk8pJJzwr2XkGwwj8j7kGASyYU90lwMwwg49l2alE2KQpvGEqwR9TbxnNmXvNfix8
 Ubjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766006; x=1776370806;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XGZaqfqEzO+/hDjbxaHef3zkJZ++VUfNhigynidW4X0=;
 b=MHJKR1zNzuu378viifVCNsoD6hL3EmGesorDRFSBueJ87idQgXqCck8xITqbW0Xqof
 3gWXOQva7oe2fRMD0y9yadVok+Yh+mcdfKp2FsPKlgVaPgPGq49Ti1RpvxgkTs2dbo2u
 PJR9dyTHNo8TAHsY5pDM6IYCqqdXJy8VtZ4mGPiPLRv/aW2cXoKaY3HeGMbHy/W8zPMz
 DYt1SmEXvG/bzV4Xvu0apGLPTmWfrlE/kkKJSLln7z5Z7LRclGq6ZMdvNI4ubAB1Hv8L
 JBkQfSpQiPAcoVRSbJHNotlk5RemXfsd6cf94OwTZmPnyN/G7zGluQLQxfpPTGoJcPZT
 1UXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsn8Vne3h4SGgiujSDh6SghFvJLgTOak4ih8rNiRmwOf5KJ0RJNjHSdpn/De0TllZm140t+3+0g/A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1HRQC6WWx3hVwNzTGp8Df6etc5W3lVFOLy4pnBlrCPxoT6PBk
 Ps6kHFk5rnGcHoXRu/EeIBh3fsMdcR6zNexhn3L3RA6CXDvaADTPro0tRj0sZoIzSGwFeGJQqj4
 PPpWa/KzINuu6q/1A+2BPnxk59DA6Kt7RJGQ/1rR6zFpn27ZDaMDT+LdmrfuDY+66x1dcuB8=
X-Gm-Gg: AeBDieuziiOQ6Xvhl/Wm7U2G6nE1jDk20nnysQISQXUBXhIajtHwwwPDoAZAtMzgwZB
 1BRjiUzbaamS/j0ZhcubZox+P4WQNnzk26aP8zMr2J40msoNJjmY1/aJiIQZ+WqjB5jb8q2GriI
 QcY6QkyczMxcXVGd7TNCO26ddZH0HrGJiEcv5ujgH2VhO2mg9npSzqF6hAYtp3ntF7lk5GA0/P0
 uq+dFY8QeUeK3ba1ynS3vYRMr2jfYywPh3NRXuea4nlx8jxW4KVzY6J7hq6TnV1O+bDqsBcCnv9
 BtCXmJ0x3uKQOYm01p6/HbS6YUF1nV04FKKrijold45e+OBSaq4rUVJ/y4fy0yv1WB5EO0aQFO1
 RrgWdZo8+fcXVcdPB6ndgKaK7ysnvFuOJVN7AvFfFiZxMThVjD2JcP43yLG08wDJASY1Yt+JCPp
 M=
X-Received: by 2002:a05:7301:1f10:b0:2d3:2983:c895 with SMTP id
 5a478bee46e88-2d5879944aamr347635eec.7.1775766005538; 
 Thu, 09 Apr 2026 13:20:05 -0700 (PDT)
X-Received: by 2002:a05:7301:1f10:b0:2d3:2983:c895 with SMTP id
 5a478bee46e88-2d5879944aamr347608eec.7.1775766004904; 
 Thu, 09 Apr 2026 13:20:04 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d562db6ac8sm1145878eec.26.2026.04.09.13.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 13:20:04 -0700 (PDT)
Message-ID: <0a2af0d1-27da-4f60-952a-409a5abc5647@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 14:20:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] bus: mhi: Move sahara protocol driver under
 drivers/bus/mhi
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-2-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-2-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE4NiBTYWx0ZWRfX1M5ctWtyccYN
 4uJSXvLuq8oJ1kn2x2DICEWR3DoU8PW5SRbZRGSnhOs/1fO+F+oPrOS6B+DskIFq4MU3kqS4+lf
 ljtgS3fTj4k4MSE+hwLsKmOcKWEg5Ts67e4+qYXeQxac26I46wGLeOoySiWGqxF0mcwSo1hFavm
 CuTaGMXAmkliZ3lwElxldvu+RAgRDxDZnB2MAG1umBjxj1V4rXW3lunYOG3WThLVF8JubmAXU+L
 xZysxS2BgzSP0cJhCuc4gdDqIdZ7zyeAhNM1K3zVocIQtk5TS+3SNJ+5bdE7FcOB5EwSkMogncD
 rzW6KYuyznJjzJ4PX0cj4n7ykEwM3laY39+cXlkJTYSDgJ7c8Kp6nwQvlfQOLHE8aFinZlV5ScP
 bilboP5t1R78GsoMl9xj5rPM08IvKcAQEioVTC0XTJs/BKK5Fbg1aj6QhlCLfLaKEIoZ18+FDSn
 /Tk3h2VzaWdWLeKqR+g==
X-Proofpoint-GUID: WmVk8hRShv3c5SJ1Zq85CCwM5yJXOmpA
X-Proofpoint-ORIG-GUID: WmVk8hRShv3c5SJ1Zq85CCwM5yJXOmpA
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d809f6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=i-BP5fTv2L-2S3ZuYlQA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090186
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

On 3/19/2026 12:31 AM, Kishore Batta wrote:
> The Sahara protocol driver is currently located under the QAIC
> accelerator subsystem even though protocol itself is transported over the
> MHI bus and is used by multiple Qualcomm flashless devices.
> 
> Relocate the Sahara protocol driver to drivers/bus/mhi and register it as
> an independent MHI protocol driver. This avoids treating Sahara as QAIC
> specific and makes it available for reuse by other MHI based devices.
> 
> As part of this move, introduce a dedicated Kconfig and Makefile under the
> MHI subsystem and expose the sahara interface via a common header.

I don't think this belongs under MHI. Mani needs to confirm that he 
agrees with the concept of moving this there.

The Sahara protocol as defined by the spec does not require MHI. We know 
that there are Sahara implementations over USB. I don't see a dependency 
or relationship to MHI other than the current in-kernel implementation 
uses MHI, but there are plenty of things that use MHI (qaic, mhi-net, 
ath12k, etc) which are not a part of the MHI bus.

The implementation presented in this series is not well integrated into 
MHI, which also suggests to me that it doesn't belong there. The 
Documentation is not integrated with MHI (which I mentioned over on that 
patch) and I see the header file (sahara.h) is also not integrated.

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 63fb8c7b4abcbe4f1b76c32106f4e8b9ea5e2c8e..76cc8086825e7949ed756d51fcb56a08f392d228 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -15,6 +15,7 @@
>   #include <linux/msi.h>
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> +#include <linux/sahara.h>

What do we need this for? register()/unregister() get removed.

>   #include <linux/spinlock.h>
>   #include <linux/workqueue.h>
>   #include <linux/wait.h>
> @@ -32,7 +33,6 @@
>   #include "qaic_ras.h"
>   #include "qaic_ssr.h"
>   #include "qaic_timesync.h"
> -#include "sahara.h"
>   
>   MODULE_IMPORT_NS("DMA_BUF");
>   
> @@ -782,18 +782,12 @@ static int __init qaic_init(void)
>   	ret = pci_register_driver(&qaic_pci_driver);
>   	if (ret) {
>   		pr_debug("qaic: pci_register_driver failed %d\n", ret);
> -		return ret;
> +		goto free_pci;

This is wrong, and there should not be a change here.

>   
>   	ret = mhi_driver_register(&qaic_mhi_driver);
>   	if (ret) {
>   		pr_debug("qaic: mhi_driver_register failed %d\n", ret);
> -		goto free_pci;
> -	}
> -
> -	ret = sahara_register();
> -	if (ret) {
> -		pr_debug("qaic: sahara_register failed %d\n", ret);
>   		goto free_mhi;

This is also wrong

>   
> @@ -847,7 +841,6 @@ static void __exit qaic_exit(void)
>   	qaic_ras_unregister();
>   	qaic_bootlog_unregister();
>   	qaic_timesync_deinit();
> -	sahara_unregister();
>   	mhi_driver_unregister(&qaic_mhi_driver);
>   	pci_unregister_driver(&qaic_pci_driver);
>   }
> diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
> index b39a11e6c624ba00349cca22d74bd876020590ab..4acedb886adccc6f76f69c241d53106da59b491f 100644
> --- a/drivers/bus/mhi/Kconfig
> +++ b/drivers/bus/mhi/Kconfig
> @@ -7,3 +7,4 @@
>   
>   source "drivers/bus/mhi/host/Kconfig"
>   source "drivers/bus/mhi/ep/Kconfig"
> +source "drivers/bus/mhi/sahara/Kconfig"
> diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
> index 354204b0ef3ae4030469a24a659f32429d592aef..e4af535e1bb1bc9481fae60d7eb347700d2e874c 100644
> --- a/drivers/bus/mhi/Makefile
> +++ b/drivers/bus/mhi/Makefile
> @@ -3,3 +3,6 @@ obj-$(CONFIG_MHI_BUS) += host/
>   
>   # Endpoint MHI stack
>   obj-$(CONFIG_MHI_BUS_EP) += ep/
> +
> +# Sahara MHI protocol
> +obj-$(CONFIG_MHI_SAHARA) += sahara/
> diff --git a/drivers/bus/mhi/sahara/Kconfig b/drivers/bus/mhi/sahara/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..3f1caf6acd979a4af68aaf0e250aa54762e8cda5
> --- /dev/null
> +++ b/drivers/bus/mhi/sahara/Kconfig
> @@ -0,0 +1,18 @@
> +config MHI_SAHARA
> +	tristate
> +	depends on MHI_BUS
> +	select FW_LOADER_COMPRESS

Why are we selecting this? I don't see anyone else doing this. Sahara 
should work with and without firmware compression.

> +	select FW_LOADER_COMPRESS_XZ
> +	select FW_LOADER_COMPRESS_ZSTD
> +	help
> +	  Enable support for the Sahara protocol transported over the MHI bus.
> +
> +	  The Sahara protocol is used to transfer firmware images, retrieve
> +	  memory dumps and exchange command mode DDR calibration data between
> +	  host and device. This driver is not tied to a specific SoC and may be
> +	  used by multiple MHI based devices.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called mhi_sahara.
> diff --git a/drivers/bus/mhi/sahara/Makefile b/drivers/bus/mhi/sahara/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..fc02a25935011cbd7138ea8f24b88cf5b032a4ce
> --- /dev/null
> +++ b/drivers/bus/mhi/sahara/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_MHI_SAHARA) += mhi_sahara.o
> +mhi_sahara-y := sahara.o
> diff --git a/drivers/accel/qaic/sahara.c b/drivers/bus/mhi/sahara/sahara.c
> similarity index 99%
> rename from drivers/accel/qaic/sahara.c
> rename to drivers/bus/mhi/sahara/sahara.c
> index fd3c3b2d1fd3bb698809e6ca669128e2dce06613..8ff7b6425ac5423ef8f32117151dca10397686a8 100644
> --- a/drivers/accel/qaic/sahara.c
> +++ b/drivers/bus/mhi/sahara/sahara.c
> @@ -1,6 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -
> -/* Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved. */
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> + *
> + */

What makes you think that changing the copyright markings is appropiate 
when moving a file?

Furthermore, I wrote this code from scratch based on the spec document 
and therefore know beyond a doubt that this file did not exist prior to 
2024, so what you are changing the markings to is completely invalid.

Also the SPDX marking you are using is long deprecated and should not be 
used.

>   #include <linux/devcoredump.h>
>   #include <linux/firmware.h>
> @@ -9,12 +11,11 @@
>   #include <linux/minmax.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/overflow.h>
> +#include <linux/sahara.h>
>   #include <linux/types.h>
>   #include <linux/vmalloc.h>
>   #include <linux/workqueue.h>
>   
> -#include "sahara.h"
> -
>   #define SAHARA_HELLO_CMD		0x1  /* Min protocol version 1.0 */
>   #define SAHARA_HELLO_RESP_CMD		0x2  /* Min protocol version 1.0 */
>   #define SAHARA_READ_DATA_CMD		0x3  /* Min protocol version 1.0 */
> @@ -928,8 +929,13 @@ int sahara_register(void)
>   {
>   	return mhi_driver_register(&sahara_mhi_driver);
>   }
> +module_init(sahara_register);
>   
>   void sahara_unregister(void)
>   {
>   	mhi_driver_unregister(&sahara_mhi_driver);
>   }
> +module_exit(sahara_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm Sahara MHI protocol driver");
> diff --git a/drivers/accel/qaic/sahara.h b/include/linux/sahara.h
> similarity index 100%
> rename from drivers/accel/qaic/sahara.h
> rename to include/linux/sahara.h
> 

