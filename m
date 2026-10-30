Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF83606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SuJJaK4Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EErphdHn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A97089083;
	Fri, 30 Oct 2026 17:07:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D4189083
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:06:55 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERB6Z2494579
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1+QjOGUHNV6g3mx0sg1Jrx3XtV4BRZaSsgv5wHeNG7Y=; b=SuJJaK4Zqg0DHe1h
 SRoGJjGUkObm9CxiFqWw31uBdcK3DtTay6zqM6fd70EdrYgdP9pN4IuYJM19eShP
 MS8c9a3JC3AQZEiFTKZJe5TbBkLN64Vr8JQQu/T7eotTUOD7FJ631OoU/W1D7flU
 JTxT8utX687E0yza46RPsPRio2KlZGfLY85B3brnZwxBflS9K7Qxa8oJnxYQGEsV
 vDod39aMyq8ZP9IQQQZXgpv3G8mlEU6wt8gvddnikXm6LGhPpP2CFcYVVEGq8Vem
 pd7NMRa3usW3xAXneXnbOippJNNFEUY1i2XaGaIYYQtRlNDcJMtsZauJhKDnVdUx
 x7w7/A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p466n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:06:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2eaf8ea208bso9953875ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380013; x=1793984813;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1+QjOGUHNV6g3mx0sg1Jrx3XtV4BRZaSsgv5wHeNG7Y=;
 b=EErphdHnoAkOcgimCGIylSAwym7csK0VLdwUt4+MzSWp/FUlYBqYQwy+0WHPrC9K/i
 KjiXf4UIP2oTnIvoly6877XWeluFYs3hWBQQIVvQo42zSHjmofVYtjLrEi+XKujBRZTj
 x9HF3QUNZV65XzsJdod1VBXr6WvNjx/iXAwVLECJT0eR5NiDR7IHG+Xb9XveHs6nrhwx
 gMqS2ti5f/+gR3KG8OFKV5zCYGaoN2LRYfR3z8eZjhIdsvjDPQNiZVwEX1jt2b3UHP9f
 tXo3VYE6BbdINqFSnJjAxPMVt3xdOuQhBEQca4nxTVqjYQ8bRJvAeRo/HBOtx6aQ1DEn
 CtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380013; x=1793984813;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1+QjOGUHNV6g3mx0sg1Jrx3XtV4BRZaSsgv5wHeNG7Y=;
 b=c3VKuU9Uf84K/7v8XyKOIodGyFU71IhEB4JLNe1lRiRO8itUDghQJ6HumxS8A8NWzh
 r/WoR+ZfOfVkq+G80aqYfrZ7Rczw+gX3GqiS/EiDTu/mStUKSIoOXH+yIOwQ334jnb1T
 47lkTX/aloZcxPxb8T50GG3C8fotYcqUetLjBe75w5jhHegRUrSkA2q0oVFa3Oy5LMwx
 Z2S8cdf0+w0XUr/SZNyzUMMouSf966Q6Ju0fNhb7MWjAREpMTmDs47KZzG/xEhD4mqKL
 8i/ZrAU3LUY9J82xG6NYiRplT3uQF67vYGzN+JCswaCBg4x9jEJqvcwE4BSeVAwelo+6
 e8nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKCzwq2B0yi5h2Ugi+30DJg0yoCIwXLgcRMA8ReHs2WhBPPZ+nJizRSRARBMSd5/UZl5BYpa9cQMQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLBRWlEXxrQJ2Fo6JpQQWiEcMSxJfzrT+HrVZ+84j8phSWn/+kc
 L6ae/dPZ+iKZOjsKFCwcOB25mddg7aNIzqD7bYJNDtjjEl7f8G1wsHRF1fhvSd1I9CtERP/cXe6
 r8niqHfVcpCTpA8nZUALRU/y8OAr2A3i02yatiKr5l1pZhdysc9+DBA1gtNXCku9ArUmdsbY=
X-Gm-Gg: AYBFou2IjkkMeoGZmZxRgZyAGXuKFGSgPH96J0+JudDUdmfp09VNvpypkHb7wFLtJka
 2mlAUwA4bUFLTHwUanFbYHcBss3xXPjSpFVLkvRToSBH6hyyeNyAvQ+KcSxlVfZn0WtWZnKiAxd
 DqL94SiI+mwNsx1G8ul3IYPZrFdTtm1rKgU2BVYFfifSnQX4aJMWaZrVXRmQnVlxqPW5ODgmE8G
 e3VAhaVcRH1Orwu0w81xwfjOAQd27mrffL7poSmbRx3o/BI6u/bCNNOXIPzKQLGbt7+FQRos9g+
 XpAdxS7KWz/Py8g5ONkWtvRUn/F5miWi9rphVeU+bVA+6uu5Os26s+agv/C+YdCgl1F+db9L8nk
 g2b/nbFQcCtmXOICKRYk8MzV8pNRZ5227aauKeKwl1K9Hu2eqYxenJxeuZ9Ch6Nv9VHBSAHhO60
 x4wOtUxUqMCBE8ahnKwF6oDlU=
X-Received: by 2002:a17:902:f54d:b0:2e8:4f3f:60dd with SMTP id
 d9443c01a7336-2eb3645b7bbmr27073125ad.37.1793380013167; 
 Fri, 30 Oct 2026 10:06:53 -0700 (PDT)
X-Received: by 2002:a17:902:f54d:b0:2e8:4f3f:60dd with SMTP id
 d9443c01a7336-2eb3645b7bbmr27072895ad.37.1793380012717; 
 Fri, 30 Oct 2026 10:06:52 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3927e526sm10442855ad.51.2026.10.30.10.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:06:52 -0700 (PDT)
Message-ID: <13f102db-287d-4d5f-a113-c5614a3cb7bc@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:06:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-4-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX9GGgtj9D+uaz
 eCQWoPKjDYycWPOtDUKFQZl1uqYeweonWTZ6x34t6qtAtWxCLMgtybGXdce/jIUEtW5TehgbVdS
 jE88CutUcqDHkQ66hxDSjE0Y963ljAddN9fbKJWvz9ocaj7P/dLBA/j9zK9GuZ5MnCkZFFwZxAU
 1XCrrbsmk6wrAzMCgpIngiyMG35mv2GeFvDPQajGXB7t0AiePktBaaG2GwNJWzRjahuGBB5ua4O
 ydAqMU2g/hNKGe3v2w0FrAdt/vGuqjF/mgr20Pb0sg8rrrknoW9zgTgMGYqLCW3f6HqFPcNrUzs
 XPrGCvWVx99UoTqVoC7lVS9stQ6iZscrsU2rQUTnaLw/fKa2Pvat7h2lxE2+tpWO1C64NsPsPRH
 VLQoxixY424kph7FY7E8y0O9Ve3xu6PtzOEbLNxybzx1RNh0Ecr/13S9Vz2TKvL1WFDj8hHghiq
 XB1jMVIzT/8mBeuLq5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX1z9KwVqeI0hB
 uWxNocdinAzZuagnpNISkaYW01P0s6xSl/+aPBCs8AizqBTK1h9dCr7FaTkYfXbjr2+es+JcStZ
 gLcMv66hCYt6IlAIaXbtGkAjwmvtCKw=
X-Proofpoint-ORIG-GUID: 0LshhC_UozCAY1s8tS1Nb8Lyag2Twt_R
X-Proofpoint-GUID: 0LshhC_UozCAY1s8tS1Nb8Lyag2Twt_R
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4ceae cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=sY8SXE2aXj8CL1lXyIYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300068
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 2:30 PM, Zack McKevitt wrote:
> @@ -611,6 +620,13 @@ static int qaic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		return ret;
>   	}
>   
> +	ret = qaic_drm_ras_register_node(qdev);
> +	if (ret) {
> +		qaic_mhi_free_controller(qdev->mhi_cntrl, link_up);
> +		qaic_destroy_drm_device(qdev, QAIC_NO_PARTITION);
> +		return ret;
> +	}
> +
>   	return 0;
>   }

Registering the mhi_controller will kickoff a whole init and boot 
sequence for the hardware. Feels like we should attempt this before that 
as if this fails, we don't leave the hardware in a weird state.

> diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qaic_telemetry.c
> new file mode 100644
> index 000000000000..fdce7a71d3eb
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/* Copyright (c) 2020-2021, The Linux Foundation. All rights reserved. */
> +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +
> +#include <drm/drm_file.h>
> +#include <drm/drm_ras.h>
> +#include <asm/byteorder.h>

A before D in the alphabet?

> +#include <linux/completion.h>
> +#include <linux/fs.h>
> +#include <linux/fs_struct.h>
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/mhi.h>
> +#include <linux/mutex.h>
> +#include <linux/namei.h>
> +#include <linux/path.h>
> +#include <linux/sprintf.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +#include <uapi/drm/qaic_accel.h>
> +
> +#include "qaic.h"
> +#include "qaic_telemetry.h"
> +
> +#define MAGIC				0x55AA
> +#define VERSION				0x1
> +
> +/*
> + * Telemetry fields defined by the uAPI.
> + * This table will be used by drm_ras's dumpit to display
> + * each field to userspace.
> + */
> +const struct drm_ras_telemetry_field qaic_telemetry_fields_gettable[] = {
> +	{"QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP", 1},
> +	{"QAIC_DEVINFO_THERMAL_BOARD_TEMP", 2},
> +	{"QAIC_DEVINFO_THERMAL_BOARD_MAX_TEMP", 3},
> +	{"QAIC_DEVINFO_THERMAL_DDR_TEMP", 4},
> +	{"QAIC_DEVINFO_THERMAL_WARNING_TEMP", 5},
> +	{"QAIC_DEVINFO_THERMAL_SHUTDOWN_TEMP", 6},
> +	{"QAIC_DEVINFO_BOARD_TDP", 7},
> +	{"QAIC_DEVINFO_BOARD_POWER", 8},
> +	{"QAIC_DEVINFO_POWER_STATE", 9},
> +	{"QAIC_DEVINFO_POWER_MAX", 10},
> +	{"QAIC_DEVINFO_THROTTLE_PERCENT", 11},
> +	{"QAIC_DEVINFO_THROTTLE_TIME", 12},
> +	{"QAIC_DEVINFO_UPTIME", 13},
> +	{"QAIC_DEVINFO_THERMAL_SOC_FLOOR_TEMP", 14},
> +	{"QAIC_DEVINFO_THERMAL_SOC_CEILING_TEMP", 15},
> +	{"QAIC_DEVINFO_VOLTAGE_CX", 16},
> +	{"QAIC_DEVINFO_VOLTAGE_MX", 17},
> +	{"QAIC_DEVINFO_VOLTAGE_NSP_CX", 18},
> +	{"QAIC_DEVINFO_VOLTAGE_NSP_MX", 19},
> +	{"QAIC_DEVINFO_CFG_TOPS", 20},
> +	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_A", 21},
> +	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_C", 22},
> +	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_E", 23},
> +	{"QAIC_DEVINFO_POWER_ACTION", 24},
> +	{"QAIC_DEVINFO_SOC_TDP", 25},
> +	{"QAIC_DEVINFO_SOC_POWER", 26},

This should be in sync with the defines in qaic_accel.h right? Can we 
just use those defines here?


