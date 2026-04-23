Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA99F589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A4510F11E;
	Thu, 23 Apr 2026 13:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W83kJCb9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ra9+KEpZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F8E10F11E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:16 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8tq68179312
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oFs1RbQ0XkUdAOvZ3WrAthRL+JhVyLKMhXKejRMG50Q=; b=W83kJCb90RXTWXsv
 +N4MsWO5j3J1l018/9HTuTnXyck6N5sO3sEEcmhS6D/J1UM/Numbte+0JLmFIG7Y
 fDB8QyPCUSsSLwS8LDR933AUrLI7bmggaJMItyAr9c89SwvCR68I0DTo74N1nMPR
 mUyAUDvVEp8wWry2YPw3McZb9pj9zoLi+oijVtIH/sCL4RxmiT9PSj5zHM7B96YU
 8Wk+xoeVo6mf5vdmbRsDNU1TM8zC+h2Q0oj+OnIVF4Tb1JyUEKvEI3BRvZWV+Ajz
 1atvVcHB4z+RISev0c0n14GFqxUk7VkRYeozQfZ2qqh1VZnXh5sZqMLtyfM5Peup
 5+72rQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqe62hnj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2ead99f5dso84212905ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951015; x=1777555815;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oFs1RbQ0XkUdAOvZ3WrAthRL+JhVyLKMhXKejRMG50Q=;
 b=Ra9+KEpZ6p7aGwqwS0KsuAhd9KxfRWEJ0kMO/FKKrivaf/QSUewSEZyqcw8CpyL86w
 4V1I0GV9HyBHZ/yJcABZX8WQfvO8mcbTA30YjzzQBudyWYdisLdp2S/dKMx77jgNH9wr
 IxhkxNdSUEwkZW2a4emEcd3nk6YsuUW9Ot7ULAswRT41yVlJUUqYKZ6JQvCVOwSuk7lt
 OpeQBKHbew1dxXpBugjs27+nzYwYUvID8qGapTjEbs43QFlQDseuSUAjYYlB2nFuaF6a
 r7RDDBTQMaCFZDYwDJvkT8cZE8I4e3Ss43NqEEHz6DT+oRTwMuLDm8kes/BXkvYVjNFx
 mR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951015; x=1777555815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oFs1RbQ0XkUdAOvZ3WrAthRL+JhVyLKMhXKejRMG50Q=;
 b=lSK5fY4UTMA3XupjVa/sZnYRdqp4HzomMt2pw4qWTD+RzTEDPVmiwWil1XBTKfiPlZ
 LIBGynl7IiUtLLD3ffuUJ/g2N3VSGBwrc7ikioOIKmjISgXCk51Nz0ZwrN3mHLW4hM4i
 KDHibC9B9gc5r9IlvbDEVuuxqRkCaWr8HqB7tJjNpT5ioV0Sjeueac5VFSyYY07Trvu4
 ntdkq79M/Yy4jcJmv5fviIEuY5CxJcchrHAcA67YTl1LIJR1al0hBl4jaTQdAQNb3Rsx
 nd5PjDGklKcy8CRGSpIemZc5De8d/tKkUCjb2cai+NHTFNkvRGws9OHW1uTCr23RtDqV
 9JBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YOmtp3M3hhHeQbLC9y1x75i2FdciI+xiTUm3H5KEDl9RPoKC1e2WLuchg5nfafRlxCoZOPXFNZL4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrI/sR0mIqXZPQ3+zNdRDdjF3HaLWI0LxKu1lH6o/G6C6QTwN+
 ztFC2QRzQgKVdM28f4Cbm3XLexXScV3U5MT3/3FBNBwR9o19XLrtPJlMOWydwQGPtTB8CN7bK9l
 8cID2wq5L/U1GwQ60RDodZJxKil8P88VQEHQTH5dK+po52GdzLz99xX76BRfr1NBJeN2Zrwc=
X-Gm-Gg: AeBDieshd5amrIvPzsDamDGMc0RUrOsoiP7JCyRrhYhgxl4sQDRHDooFqAFQd2WPEUV
 Ws/Hzl/DWd+MoFa4dPGVuyHWqv+CNfyaeaccNWyHPyJbP6AWgKJfVKapCmY1NPRhpow9I3bsC8j
 IR9Ay9wkKtGY0OOBzy5MyGoR8hqeykaM/PTzdIKh+hH9VCWvl44lD69RuzX7wAx3XWyHY4zMd9W
 DK1CehSgxnt3WwhUfO6Wz0vHfk5wIUc/CQnYxlc4H+MfXigv/mPNPN8lc9paCwQ589mB0Fz8L5A
 ibG+19m/0SG/4GyKza+C7kIhUbdIEQHbfF9+4Jra4a8I7nSeWkNxnILVB8AUA9jxrc6NEv4MvEc
 T/5BIzdQgvkaFHoGsEI2X5iKW5X/DD4w33v9u5HjN/HREsrXEX/+p4Ai+jdM5Lmuhog==
X-Received: by 2002:a17:903:1104:b0:2b4:6529:7b9f with SMTP id
 d9443c01a7336-2b5f9f37032mr302686985ad.26.1776951014857; 
 Thu, 23 Apr 2026 06:30:14 -0700 (PDT)
X-Received: by 2002:a17:903:1104:b0:2b4:6529:7b9f with SMTP id
 d9443c01a7336-2b5f9f37032mr302686055ad.26.1776951014097; 
 Thu, 23 Apr 2026 06:30:14 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:30:13 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:31 +0530
Subject: [PATCH v2 02/13] drivers: base: Add generic dma context bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-2-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=5182;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=m9Ev3cg1dRS/apkqmuIWrlLItkWfgL3nCRaQ+GTJ4d8=;
 b=a0MO/i8o4a8De0o+pVmxc5nct6busfcAWycf0+sRmWbw7J9/KUDBhEJPpZ7lySVphzTFDiOk0
 lCbAAc8uQyBCNukA9WgkyrwbsxQ7npM3UxMTlbG7g7ze+2dYMgz8VVH
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: r6HWkSbWlqFd8fptLSDt8hjVXWpxCO5Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX/B6+dAyzLSI3
 ZnuAcn6ONwOGUoUBAhbH3FKdN3TrQIKlH73QiAGhs3RfWL6RehycWVokRk+mTbPV2qIZRG89ks8
 JqT517+SKEkXJTdDji/OqJ/Kj49qhL1JAz0p8lu/V4E79Plu8vZjwAh+Bn3BXnWeMhTscfG9BMk
 Sfgvq2vdGg5JZ1/RuNP4zvXlzhehuLNlUfoL7+Ak+cqToOl+9+wlU6KCQMteDcX7pzQ0Hi317z5
 /R9nUlWHw6Osh2ajsin3IGuTqKJ6G58jrUel5zrNnWHfez6wNrK4jSJNXTst6yqj2mOGOxU6Aah
 gK0WjOtJKtbqlPdNqIWPMu2EcBRDGid6DE3nIXsHXcfk4j8Wpvuf6PeQTLlJaxJecNxkuZulWCt
 EY9sJpiT3+zlts6he+b6S+yygb2s9U55ZlUW6a2/ivAiSr6JoXc5y/xrHfVLT8NNP0LcmiuqhnX
 m11/vqAO0vBBeSUzRJw==
X-Proofpoint-ORIG-GUID: r6HWkSbWlqFd8fptLSDt8hjVXWpxCO5Q
X-Authority-Analysis: v=2.4 cv=Nv7htcdJ c=1 sm=1 tr=0 ts=69ea1ee7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nxtABoNUPiTGfhWLCFsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

When a driver needs to create virtual device at runtime and map it to
an IOMMU context for memory isolation, there is no common bus available
for this purpose. Each driver ends up implementing its own bus type,
leading to duplicated logic across multiple drivers.

host1x driver implemented its own bus type to attach an IOMMU context to
a dynamically created device. The Iris VPU driver now has the same
requirement. Rather than duplicating the same bus logic again, a shared
bus type is introduced under drivers/base that multiple drivers can use
directly.

The bus takes care of creating a device and attaching the IOMMU context
to it based on the client inputs.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/base/Kconfig            |  3 ++
 drivers/base/Makefile           |  1 +
 drivers/base/dma_context_bus.c  | 77 +++++++++++++++++++++++++++++++++++++++++
 include/linux/dma_context_bus.h | 26 ++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f7d385cbd3ba..499ea92dd88f 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -4,6 +4,9 @@ menu "Generic Driver Options"
 config AUXILIARY_BUS
 	bool
 
+config DMA_CONTEXT_BUS
+	bool
+
 config UEVENT_HELPER
 	bool "Support for uevent helper"
 	help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 8074a10183dc..348e69695e55 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -8,6 +8,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   topology.o container.o property.o cacheinfo.o \
 			   swnode.o faux.o
 obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
+obj-$(CONFIG_DMA_CONTEXT_BUS) += dma_context_bus.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
diff --git a/drivers/base/dma_context_bus.c b/drivers/base/dma_context_bus.c
new file mode 100644
index 000000000000..c2ac189ce08d
--- /dev/null
+++ b/drivers/base/dma_context_bus.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/dma_context_bus.h>
+#include <linux/of_device.h>
+
+static atomic_t dma_context_bus_device_id = ATOMIC_INIT(0);
+
+static int dma_context_bus_device_configure(struct device *dev)
+{
+	const u32 *iommu_fid = dev_get_drvdata(dev);
+	struct device_node *of_node = dev->of_node;
+
+	if (!of_node)
+		of_node = dev->parent->of_node;
+
+	return of_dma_configure_id(dev, of_node, true, iommu_fid);
+}
+
+const struct bus_type dma_context_bus_type = {
+	.name = "dma-context-bus",
+	.dma_configure = dma_context_bus_device_configure,
+};
+EXPORT_SYMBOL_GPL(dma_context_bus_type);
+
+static void release_dma_context_bus_device(struct device *dev)
+{
+	kfree(dev);
+}
+
+struct device *create_dma_context_bus_device(struct device *parent_device,
+					     struct device_node *of_node,
+					     u64 dma_mask, const u32 *iommu_fid)
+{
+	struct device *dev;
+	int dev_id, ret;
+
+	dev = kzalloc_obj(*dev);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->release = release_dma_context_bus_device;
+	dev->bus = &dma_context_bus_type;
+	dev->parent = parent_device;
+	dev->coherent_dma_mask = dma_mask;
+	dev->dma_mask = &dev->coherent_dma_mask;
+	dev->of_node = of_node;
+
+	dev_id = atomic_inc_return(&dma_context_bus_device_id);
+	dev_set_name(dev, "dma-context-bus-%d", dev_id);
+	dev_set_drvdata(dev, (void *)iommu_fid);
+
+	ret = device_register(dev);
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(create_dma_context_bus_device);
+
+static int __init dma_context_bus_init(void)
+{
+	int err;
+
+	err = bus_register(&dma_context_bus_type);
+	if (err) {
+		pr_err("dma-context-bus registration failed: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+postcore_initcall(dma_context_bus_init);
diff --git a/include/linux/dma_context_bus.h b/include/linux/dma_context_bus.h
new file mode 100644
index 000000000000..3d89594fbce4
--- /dev/null
+++ b/include/linux/dma_context_bus.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _LINUX_DMA_CONTEXT_BUS_H
+#define _LINUX_DMA_CONTEXT_BUS_H
+
+#include <linux/device.h>
+
+#ifdef CONFIG_DMA_CONTEXT_BUS
+extern const struct bus_type dma_context_bus_type;
+
+struct device *create_dma_context_bus_device(struct device *parent_device,
+					     struct device_node *of_node,
+					     u64 dma_mask, const u32 *iommu_f_id);
+#else
+static inline struct device *create_dma_context_bus_device(struct device *parent_device,
+							   struct device_node *of_node,
+							   u64 dma_mask, const u32 *iommu_f_id)
+{
+	return NULL;
+}
+#endif
+
+#endif /* _LINUX_DMA_CONTEXT_BUS_H */

-- 
2.34.1

