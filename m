Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322E3F589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DAB10F11B;
	Thu, 23 Apr 2026 13:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghjhN4sM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fsGGCHil";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC7910F11B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N96VHj1204755
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JgwjwFdvvj5l++UKF5Dcssi0Wo7kEhu0ad5cAFD1lJs=; b=ghjhN4sMDwiDYsIQ
 Re09rM5kmTRK4/3Qs5o8Ji8YmRTsBUq2t7Qb2gEZLqiU9+xly3MT5TtnIbklDNFq
 IrAvAhTNA4BG5Mmj1FpoOQ0wy2qQVyK8nNQcIt+dr4lU96qulA0KvwXofmMt44Is
 02PGvYX2JezK5VsRpXVpdZTgBvgYbt0rLLSBUWn7nN5gOLpgpPCYRDrlrfcZyd1c
 g7YSy7jOMNNwQJQH3L+pjRk3J/tr7pNtifMrkpLAbZjWeu7W1SqLw0XJFSzJ7y6e
 c6qyezTNDPdO4iQEgIB9RwVRtwpMMHCZ56uPJo5BZBIOv3VrYLnUVsiaYlMaKlVd
 B0pYig==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqggn91c4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:30:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24af7ca99so90459455ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951025; x=1777555825;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JgwjwFdvvj5l++UKF5Dcssi0Wo7kEhu0ad5cAFD1lJs=;
 b=fsGGCHil49X8vQ5VjxxbDWqAvsfhXpYYvQ/z1Vn83rlVbedN7Qr1PKgXekkTACUYy7
 rpAnQa+OtgCvBS+SHtTQHBR+odDpftnnvJLz1yrLfP6SLywBq2WwtuW9RomzQ/6zeh2E
 dK9j+CCdwo/Nlx4M4G6sQvKKwoi6hOrOhhDaJt0TGWpdBKQBuR5OkSrv6jIYx2AcXI8v
 DugJRHBLl1ySlJNW3G4VoLOkFKe8qvDBMKejvei13WfAxzG2GGorI1f17TF87IrJlIBl
 6OAPGVz2ut6YdNthepWjRxD0iwWk5gqRNOFc9QIJvDCSmr7BTANt25LsFd5xtVd2j1tL
 SO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951025; x=1777555825;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JgwjwFdvvj5l++UKF5Dcssi0Wo7kEhu0ad5cAFD1lJs=;
 b=htl0zJxRJHr9t7Js/MNK+j32IDgGBo+ihCQv8x2q7qp87pcvDnwymxWoIpuwjzut8t
 iZm9dILvXRnptmX5c/LslOGOgY5/jNfK6joCiR42sYGn6SSTu2om8NZRmRiLvH0faG1g
 gJM9vGBaARY8cJVJXxYfSEqiLr6fnGkSb652xytFnTVSbwFsp52TEPn5sbVpHKHH/tmx
 IdykZ3xmItprRHlVaGuhFHp7byzVh4/wyQAwIRuKGNIaaQDqis8AaFhA49uK2NnXa+5R
 +iKIrNBS3lgrTZFU8DzDSw7mqNOUdMJUdJKM4DGJEaV0V9M6nH+0bY72pqWeX+TxVFP/
 BV1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/frypKrAdDJsXadWOi21DOXJBcHx4VBJg2MllssIr15QPE0eNQZI3qHTmnBrNEuteRUjJUAzkpBEM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiDL1+sq42zE2jurxeDso9l2TL+O6yD8EhYW7T055QLHGxQaea
 0KOhezdQuA/vACqt+WQbe2Lj8AeJh86M/3k9hA7vJmLQhwrRAPGvd6WuC4ayCOcBycNYPSMDYip
 Jpj4xmwtJOoiJmY9B/i53KPVx852fXhmsEb+uQNLObv+/ruL2nBEzOZHBTnF2FxQPz+ubnXI=
X-Gm-Gg: AeBDiesCCzXGsL2r/cTWnfuKTAQZZ/h2uKAmnToYKcUH1pUMlzjTUCUgjfQOJkbNe7r
 3Kdz2wa4yPc6DjN/oDRhJF784LB4H0Ljo7dKoa1toKg8GZXhIGbWhmMbx2wChBcyLa/7dc7nObr
 TCwqc0/L7KFwgp/Z7Uh7X5Jp4wwgCpJfmXnV86Q7WvdWlMB30mTBWuHopJZ88f0/+g7dm7VAL//
 oNICS8ji9JTAl89n7cUSZ1AxGP5bZN2DTG0thc40gxvSMRk5iY7fZ2CZ9HISHmd8gVnBgG/BgKS
 KqQsutIkEF3oSL3ew5OOB0mc/HwRA0r5zh/SNfAvO5YQPjlp5q4ElZ2ZXMJiRmiXFPYzfXgObsY
 uCPNfiTVUmFB/fvQdmixNxp6OIsbNmS8UO6jtxr67in3y6wRxeBDo0ukEjU6tCYdygw==
X-Received: by 2002:a17:902:ea12:b0:2b0:6e4a:32d0 with SMTP id
 d9443c01a7336-2b5f9fbbdacmr283588605ad.35.1776951024358; 
 Thu, 23 Apr 2026 06:30:24 -0700 (PDT)
X-Received: by 2002:a17:902:ea12:b0:2b0:6e4a:32d0 with SMTP id
 d9443c01a7336-2b5f9fbbdacmr283587505ad.35.1776951023495; 
 Thu, 23 Apr 2026 06:30:23 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:30:23 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:32 +0530
Subject: [PATCH v2 03/13] gpu: host1x: Migrate to generic dma context bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-3-0296bccb9f4e@oss.qualcomm.com>
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
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=9125;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=KAZGJcms8W81ZmK2zjFmjrcOZ1HBohJzHFPq/diKVJY=;
 b=G6RcIQ17RYpJWR8JDM591/LpwoVkQ6XZG36hL1jc+jg2eaqYSNxbMR/xAkW6nsA4aDE06Ugnh
 G6EQkaClw2AAJ756RAnNV8DDM78rg/FXf7UziboAh2VUdY6eWdWtwwA
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: FM0Cv8_pu74IMQAOkSc2mD2Kqag530Zg
X-Authority-Analysis: v=2.4 cv=YZeNIQRf c=1 sm=1 tr=0 ts=69ea1ef1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=smED1w4oCYVFD8D0vxMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX4HS7Hqy/X/ja
 ucmvHaz4K4CGTKQ+szMV/z6uye07yE/oLM4PBNheuvMgfngQxoArgvSRnW8Entjq12m38iRO3ut
 yo8DXRXX1A+c3DqFHMMmEOJjpXaNOnQHM466ShGU4AvaTgd+nnJ8QUUIn/+RGcGp8MGW/XcRTe9
 qN17pMkVxBYLewPqOsYMdhuwViTBaz4iXgT+tvaAledQMNi/YB6kYtyyQuRsAVqcfiL86NvrNId
 i4gnyFmPgXa31C1wP2UltBzBDjfQ2GQnSHyWzodWj6AnuQHPpWzlUJ6Oj7awhjDQRaubtJCcTG8
 A7TFrn9cTZS1DCdJODNQzW6bkip4o9/VPqAbrNplOf5vykR4qPoP4saAGQTGqel8QMPNgztKwww
 lbFoT+Hz+bjnPTwwFSu/iN8Be633Qv3OAXtBOOik0z1q/T2bZwoxMOoV1GPr99tMpNC7VsYCtSg
 gc58IbrbJJAP4USp6Xg==
X-Proofpoint-GUID: FM0Cv8_pu74IMQAOkSc2mD2Kqag530Zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230134
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

The host1x driver creates context bank devices to map IOMMU contexts
for memory isolation. Previously, this required a host1x-specific bus
type with its own device setup and IOMMU configuration logic.

A generic "dma-context-bus" is now available in the driver core that
handles this for any driver. Replace the host1x-specific bus with this
shared generic bus. This removes the private bus registration, device
setup, and of_dma_configure_id() from host1x, as the generic bus handles
all of this internally.

The IOMMU subsystem is also updated to reference the generic bus instead
of the host1x-specific one.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/gpu/drm/tegra/uapi.c       |  2 +-
 drivers/gpu/host1x/Kconfig         |  5 +---
 drivers/gpu/host1x/Makefile        |  1 -
 drivers/gpu/host1x/context.c       | 47 ++++++++++++--------------------------
 drivers/gpu/host1x/context.h       |  3 +--
 drivers/gpu/host1x/context_bus.c   | 26 ---------------------
 drivers/iommu/iommu.c              |  6 ++---
 include/linux/host1x.h             |  2 +-
 include/linux/host1x_context_bus.h | 15 ------------
 9 files changed, 21 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
index c0ac6b45f2d7..9547725a6c3c 100644
--- a/drivers/gpu/drm/tegra/uapi.c
+++ b/drivers/gpu/drm/tegra/uapi.c
@@ -215,7 +215,7 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 	kref_init(&mapping->ref);
 
 	if (context->memory_context)
-		mapping_dev = &context->memory_context->dev;
+		mapping_dev = context->memory_context->dev;
 	else
 		mapping_dev = context->client->base.dev;
 
diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
index e6c78ae2003a..0539ff057a51 100644
--- a/drivers/gpu/host1x/Kconfig
+++ b/drivers/gpu/host1x/Kconfig
@@ -1,13 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config TEGRA_HOST1X_CONTEXT_BUS
-	bool
-
 config TEGRA_HOST1X
 	tristate "NVIDIA Tegra host1x driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	select DMA_SHARED_BUFFER
-	select TEGRA_HOST1X_CONTEXT_BUS
+	select DMA_CONTEXT_BUS
 	select IOMMU_IOVA
 	help
 	  Driver for the NVIDIA Tegra host1x hardware.
diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index fead483af0b4..2ccd9a5f1c65 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -23,4 +23,3 @@ host1x-$(CONFIG_IOMMU_API) += \
 	context.o
 
 obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
-obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index d50d41c20561..ab7b156ab002 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -13,16 +13,12 @@
 #include "context.h"
 #include "dev.h"
 
-static void host1x_memory_context_release(struct device *dev)
-{
-	/* context device is freed in host1x_memory_context_list_free() */
-}
-
 int host1x_memory_context_list_init(struct host1x *host1x)
 {
 	struct host1x_memory_context_list *cdl = &host1x->context_list;
 	struct device_node *node = host1x->dev->of_node;
 	struct host1x_memory_context *ctx;
+	struct device *dev;
 	unsigned int i;
 	int err;
 
@@ -44,42 +40,27 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 
 		ctx->host = host1x;
 
-		device_initialize(&ctx->dev);
-
 		/*
 		 * Due to an issue with T194 NVENC, only 38 bits can be used.
 		 * Anyway, 256GiB of IOVA ought to be enough for anyone.
 		 */
 		ctx->dma_mask = DMA_BIT_MASK(38);
-		ctx->dev.dma_mask = &ctx->dma_mask;
-		ctx->dev.coherent_dma_mask = ctx->dma_mask;
-		dev_set_name(&ctx->dev, "host1x-ctx.%d", i);
-		ctx->dev.bus = &host1x_context_device_bus_type;
-		ctx->dev.parent = host1x->dev;
-		ctx->dev.release = host1x_memory_context_release;
-
-		ctx->dev.dma_parms = &ctx->dma_parms;
-		dma_set_max_seg_size(&ctx->dev, UINT_MAX);
-
-		err = device_add(&ctx->dev);
-		if (err) {
+
+		dev = create_dma_context_bus_device(host1x->dev, NULL, ctx->dma_mask, &i);
+		if (IS_ERR(dev)) {
+			err = PTR_ERR(dev);
 			dev_err(host1x->dev, "could not add context device %d: %d\n", i, err);
-			put_device(&ctx->dev);
 			goto unreg_devices;
 		}
 
-		err = of_dma_configure_id(&ctx->dev, node, true, &i);
-		if (err) {
-			dev_err(host1x->dev, "IOMMU configuration failed for context device %d: %d\n",
-				i, err);
-			device_unregister(&ctx->dev);
-			goto unreg_devices;
-		}
+		ctx->dev = dev;
+		ctx->dev->dma_parms = &ctx->dma_parms;
+		dma_set_max_seg_size(ctx->dev, UINT_MAX);
 
-		if (!tegra_dev_iommu_get_stream_id(&ctx->dev, &ctx->stream_id) ||
-		    !device_iommu_mapped(&ctx->dev)) {
+		if (!tegra_dev_iommu_get_stream_id(ctx->dev, &ctx->stream_id) ||
+		    !device_iommu_mapped(ctx->dev)) {
 			dev_err(host1x->dev, "Context device %d has no IOMMU!\n", i);
-			device_unregister(&ctx->dev);
+			device_unregister(ctx->dev);
 
 			/*
 			 * This means that if IOMMU is disabled but context devices
@@ -96,7 +77,7 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 
 unreg_devices:
 	while (i--)
-		device_unregister(&cdl->devs[i].dev);
+		device_unregister(cdl->devs[i].dev);
 
 	kfree(cdl->devs);
 	cdl->devs = NULL;
@@ -110,7 +91,7 @@ void host1x_memory_context_list_free(struct host1x_memory_context_list *cdl)
 	unsigned int i;
 
 	for (i = 0; i < cdl->len; i++)
-		device_unregister(&cdl->devs[i].dev);
+		device_unregister(cdl->devs[i].dev);
 
 	kfree(cdl->devs);
 	cdl->len = 0;
@@ -132,7 +113,7 @@ struct host1x_memory_context *host1x_memory_context_alloc(struct host1x *host1x,
 	for (i = 0; i < cdl->len; i++) {
 		struct host1x_memory_context *cd = &cdl->devs[i];
 
-		if (cd->dev.iommu->iommu_dev != dev->iommu->iommu_dev)
+		if (cd->dev->iommu->iommu_dev != dev->iommu->iommu_dev)
 			continue;
 
 		if (cd->owner == pid) {
diff --git a/drivers/gpu/host1x/context.h b/drivers/gpu/host1x/context.h
index 3e03bc1d3bac..558638c457d6 100644
--- a/drivers/gpu/host1x/context.h
+++ b/drivers/gpu/host1x/context.h
@@ -8,13 +8,12 @@
 #ifndef __HOST1X_CONTEXT_H
 #define __HOST1X_CONTEXT_H
 
+#include <linux/dma_context_bus.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 
 struct host1x;
 
-extern struct bus_type host1x_context_device_bus_type;
-
 struct host1x_memory_context_list {
 	struct mutex lock;
 	struct host1x_memory_context *devs;
diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
deleted file mode 100644
index 7cd0e1a5edd1..000000000000
--- a/drivers/gpu/host1x/context_bus.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2021, NVIDIA Corporation.
- */
-
-#include <linux/device.h>
-#include <linux/of.h>
-
-const struct bus_type host1x_context_device_bus_type = {
-	.name = "host1x-context",
-};
-EXPORT_SYMBOL_GPL(host1x_context_device_bus_type);
-
-static int __init host1x_context_device_bus_init(void)
-{
-	int err;
-
-	err = bus_register(&host1x_context_device_bus_type);
-	if (err < 0) {
-		pr_err("bus type registration failed: %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-postcore_initcall(host1x_context_device_bus_init);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..5d0fad1402eb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -16,7 +16,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
-#include <linux/host1x_context_bus.h>
+#include <linux/dma_context_bus.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
@@ -173,8 +173,8 @@ static const struct bus_type * const iommu_buses[] = {
 #ifdef CONFIG_FSL_MC_BUS
 	&fsl_mc_bus_type,
 #endif
-#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
-	&host1x_context_device_bus_type,
+#ifdef CONFIG_DMA_CONTEXT_BUS
+	&dma_context_bus_type,
 #endif
 #ifdef CONFIG_CDX_BUS
 	&cdx_bus_type,
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 1f5f55917d1c..30dbb3a71828 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -462,7 +462,7 @@ struct host1x_memory_context {
 	struct pid *owner;
 
 	struct device_dma_parameters dma_parms;
-	struct device dev;
+	struct device *dev;
 	u64 dma_mask;
 	u32 stream_id;
 };
diff --git a/include/linux/host1x_context_bus.h b/include/linux/host1x_context_bus.h
deleted file mode 100644
index c928cb432680..000000000000
--- a/include/linux/host1x_context_bus.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2021, NVIDIA Corporation. All rights reserved.
- */
-
-#ifndef __LINUX_HOST1X_CONTEXT_BUS_H
-#define __LINUX_HOST1X_CONTEXT_BUS_H
-
-#include <linux/device.h>
-
-#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
-extern const struct bus_type host1x_context_device_bus_type;
-#endif
-
-#endif

-- 
2.34.1

