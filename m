Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3F606ECE9
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bSM99qZu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BBDVfRt+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3647610E49B;
	Sun,  1 Nov 2026 22:22:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B30110E49B
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:22:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK41R192130
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f/TC7D20pry+/Aonp7VR6KKpRG6Wv8FkejFoFRuGgRU=; b=bSM99qZuUHuFNTgu
 4g4tuMKZFpWbKK5JryBqytjT8ssav/wg78lDxaqd8/cpoRL9N1w8D+i09//XlN0X
 2zX8FN0XtTqlxgIaIoeUqwcayW+WxvQiKlUqptDepoVypXytapqIudWlOHN4jIOr
 udPj5X9MLNVtXBCImAPNk50eib1fDssOvb2eIAtgbCbgrtDFi0A78fByhlPWSLHv
 8IEh0QUAuMyx37zoml9+EUBmV9AQWBGrMUftfELF7FtLlxE5Yq3aSI42f5zokaSC
 5quUW0lZaLOECi8oWdnwqo6KdyT4oWkqCGPlJBadpifowBPuXe10zIeK+eTIGUH9
 cZv8hw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9gk43ge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:22:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5737460eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571723; x=1794176523;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f/TC7D20pry+/Aonp7VR6KKpRG6Wv8FkejFoFRuGgRU=;
 b=BBDVfRt+bJKjRhiTenmHyzsTRdmfYoiTQxDT2cd0g8pMMH3pOurBQYtWgn0E3tZAoO
 W2y901Wzfui90mpCGPgDVBagRX97mhltOYHwVmYlhtfOr8R5YVHeybBiWW30sf+iYmLB
 eR4CcI+ykaLG2zjA1F30qHKr+q5Yg5JU++gh3DQw1vQg5o/1dzrwYQ4vO0wBDpeG41zi
 RVK8XFIVAVMcLLO66jg9mqtiQ7dC9ge96lt2kKbe4lNl9mKHa3pxlFU1KGcoqMxGirIy
 U5fUdXRgGDcjqly3xZ818r9LrftpvtZnK8lnQhw1jb9DWD9zHe+D78hnKLsjK3D7uBVk
 OsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571723; x=1794176523;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f/TC7D20pry+/Aonp7VR6KKpRG6Wv8FkejFoFRuGgRU=;
 b=ReiBgODfkUgBbOHeeHfWcDUpnRcSuvzir+sU1DkzeZntxJWKtvnP7lftUNiVqiZTea
 UWU4+M6hKGnTjBDUeHFshGR8cfaRfqkfKmfMpix7UwnJntjG8zN0LxN9NpWpQJbzE/Xh
 JnijxvEzePLeH0HxodNddcs0Q8o7GBxyhhoKVlqUsADVnLuXcgrMkfAELAvd/NHEctkJ
 8s6u10W5JPeoDqbGXEXxvSmmaZmVpZ9XyVtm6yVu/EtLUH4Onh0RaCYDJtwcUOPiFVkA
 MBvks3Z/zd/QsXSUGAiLzmVBsvO5MEHoQ4ysqYlggYrlrXXJuUo2NZSptn/zN06M0U5D
 L/rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR09+ItCZA9EKQBBexOAB9r53xr88e5q1ORKkbLio/9Gif1ORkyMSgLO+cTahrvIE9g+7sY/g2cIo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI39qQFotqE9nl1OU0KlNjfJ1K2fkw/Hj4ECQAWJ4jx5e8mGkXl
 uIZx8ki7lYTn5NXc8KtJRwpz9Mwv/EFPQIEQ3Y553oPNMN1Da+dD/EWZWkAcjdu3QsUXM/UzV4P
 QgBVGnl2cVMlg60llG9YkgkdPbAVBkKktpaFql0CK+VG6eNY97RSrPYyJ4RKw6FQYx22kmGQrwC
 wxrvfOfA==
X-Gm-Gg: AYBFou33AyNcgHWOqHo3cwqO13ePoRhQyAOQ7yaQNjAoQ5A9hRgaoNI90nBWZGtvL/f
 zKxwTXYCrc6epsRuut2PJO7nys21yU/oq6JIBfbGYItvQGv2ciDeNg3eHIwZTVqDhzfUhvCw0nT
 WIik39tqM8LeGb7wjxaYA4Um5I+cmPBUgcIXJVO7mZFnTlBjXz5u5/uMelJTlxW/mmP5GneIWJt
 y4S3sfKUfmv7H2NhkXx7X/TNNqpellCL6dhFIZTRegQzS99gdOfhaB5bCMWUs8+8NsLJqbfPECx
 H4FI0tXLNXNDZUWOVLvyJ1xLF6tKUOjqJnJCQoiplnhu87bqITx2k1kVw/4o2rbsgkFYTyiNcEA
 0g9qNcjkRYJveO66ta1PogO9sy3a88Pn2z1lsInpEZ+QXtNWzG6B4zRqTrvkbTqFQq81BiIkvnK
 N3+AEc6w==
X-Received: by 2002:a05:7022:eb53:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-1ac5d88c9c9mr12972966c88.15.1793571722974; 
 Sun, 01 Nov 2026 14:22:02 -0800 (PST)
X-Received: by 2002:a05:7022:eb53:20b0:168:6ad8:e8c6 with SMTP id
 a92af1059eb24-1ac5d88c9c9mr12972929c88.15.1793571722307; 
 Sun, 01 Nov 2026 14:22:02 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:22:01 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:16 +0530
Subject: [PATCH v4 03/25] accel/qda: Add compute context bank devices
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-3-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
In-Reply-To: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=10953;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=AEvsn32ivhk3XVOKxDEqRU0Wbh3W3SdNAogbEYlrP+8=;
 b=a17HJ4E2zswJsHHcHADxbkmtxg9zb2IWt74VQjsu4HwzDA7w3N8iN10DMvNHK7UWjV5DNSQb2
 bFc+I5ii5NiAemXxBEsAlIg5MDHLmreWs+MMfGi/MfzJtsJBO3NF+Kd
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-GUID: iX-sdmE40kgQixMrLFfvaahm1D9W1x52
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX/SDSnnm0UQmK
 +QNPBcGEZFyGYBMc6aj4Wl4qgPCDV6A9pM/VY4A+K118eIPQMlAxW9wLMM/ujucVQCbp+USOINc
 RYmkMX8XdIUx1CpYFPyapuCLeZi+39jxwLwcmieH3NZ9PxAr9TaqBiABlJk4BrMhx8On2moGo3R
 IQfhjmqZ6I3PxgeulD9VxYmAwXTHbrOyRdbExg6QmwDoTIlf5rkDiF/FqEZ5DB9pTu0Mxb8Ovy0
 KQxeOYjWL8E+gbJlGLFSKJ+To+6QqN9nGYbVTPtJQvpAysKzQHxAHm6Pi2YR6BKQkBFCQGEk8uQ
 Ce9wIoWX9cTsgxdvkizSUdPd9ZBHnwrYXtVSIdOSMTrPDuI0wJ3mp0AjFCQvkaAplp+RAZhr2KJ
 BoAU/i6YV0gplhZVHpP0MlDUYWsYixeaTtw9P/KI7En/uY690/4lXLDk8YZO19Jei8FFyXMm8sb
 OImCMN0n7g3AsDYp8Ew==
X-Authority-Analysis: v=2.4 cv=HNBWhYtv c=1 sm=1 tr=0 ts=6ae7bb8b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=myGEx3QdhjGBzXGUh0MA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX9+akM+UV8TD1
 pPp650JxKfbshlMGN72dL2SD+31V1MnlkaMwyRxzG+hTy0+XS0h0Skj9uwozvBV91Pp08AnY999
 W0wXDZWMTQqPA8KS7xKGpfcLgOu6Hy0=
X-Proofpoint-ORIG-GUID: iX-sdmE40kgQixMrLFfvaahm1D9W1x52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010089
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DSP does not access memory through a single IOMMU domain. Its
device tree node describes a set of context banks, one
"qcom,fastrpc-compute-cb" child node each, and every context bank has
its own SMMU address space. Later patches give each session a context
bank of its own so that sessions cannot reach each other's buffers, but
that needs a struct device per context bank to allocate from.

Create a platform device for each context bank node when the rpmsg
channel probes, and destroy them again when the channel goes away or
probe fails. Registering the device is what gives it an IOMMU group
and domain: the IOMMU core probes it from the platform bus notifier
when it is added, so no driver needs to bind to it. The devices are
created before the DRM device is registered, so user space can never
reach a context bank that does not exist yet. They are destroyed after
drm_dev_unplug(), which makes sure no ioctl is still running against
them.

The width of the address space the DSP can reach differs between SoCs
and DSPs: the CDSP on Kaanapali and the platforms that use it as their
fallback compatible can address 34 bits, everything else 32. Carry this
in struct qda_soc_data, selected through the OF match data of the two
compatibles the binding defines, and apply it to each context bank with
dma_set_mask(). All CDSP instances (cdsp, cdsp1, ...) share the CDSP
width, which is why the DSP name is matched by prefix. The remaining
per-SoC parameters are added together with the code that uses them.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/Makefile    |  4 ++-
 drivers/accel/qda/qda_cb.c    | 76 +++++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_cb.h    | 29 +++++++++++++++++
 drivers/accel/qda/qda_drv.c   |  2 ++
 drivers/accel/qda/qda_drv.h   |  6 ++++
 drivers/accel/qda/qda_rpmsg.c | 25 ++++++++++----
 drivers/accel/qda/qda_soc.c   | 31 ++++++++++++++++++
 drivers/accel/qda/qda_soc.h   | 30 +++++++++++++++++
 8 files changed, 196 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index dbe809067a8b..4f2f236086a4 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -6,5 +6,7 @@
 obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 
 qda-y := \
+	qda_cb.o \
 	qda_drv.o \
-	qda_rpmsg.o
+	qda_rpmsg.o \
+	qda_soc.o
diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
new file mode 100644
index 000000000000..afb0bb71a1f4
--- /dev/null
+++ b/drivers/accel/qda/qda_cb.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <drm/drm_print.h>
+#include "qda_cb.h"
+#include "qda_drv.h"
+#include "qda_soc.h"
+
+static int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
+{
+	struct qda_cb_dev *entry;
+	struct platform_device *pdev;
+	u32 dma_bits;
+	int ret;
+
+	pdev = of_platform_device_create(cb_node, NULL, qdev->dev);
+	if (!pdev) {
+		drm_err(&qdev->drm_dev, "Failed to create CB device for %pOFn\n", cb_node);
+		return -ENODEV;
+	}
+
+	dma_bits = qda_soc_dma_addr_bits(qdev);
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(dma_bits));
+	if (ret) {
+		drm_err(&qdev->drm_dev, "%u-bit DMA enable failed for %pOFn: %d\n",
+			dma_bits, cb_node, ret);
+		goto err_destroy;
+	}
+
+	entry = kzalloc_obj(*entry);
+	if (!entry) {
+		ret = -ENOMEM;
+		goto err_destroy;
+	}
+
+	entry->pdev = pdev;
+	list_add_tail(&entry->node, &qdev->cb_devs);
+
+	return 0;
+
+err_destroy:
+	of_platform_device_destroy(&pdev->dev, NULL);
+	return ret;
+}
+
+int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
+{
+	int ret;
+
+	for_each_available_child_of_node_scoped(parent_node, child) {
+		if (!of_device_is_compatible(child, "qcom,fastrpc-compute-cb"))
+			continue;
+
+		ret = qda_create_cb_device(qdev, child);
+		if (ret) {
+			qda_cb_unpopulate(qdev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+void qda_cb_unpopulate(struct qda_dev *qdev)
+{
+	struct qda_cb_dev *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &qdev->cb_devs, node) {
+		list_del(&entry->node);
+		of_platform_device_destroy(&entry->pdev->dev, NULL);
+		kfree(entry);
+	}
+}
diff --git a/drivers/accel/qda/qda_cb.h b/drivers/accel/qda/qda_cb.h
new file mode 100644
index 000000000000..070dc1de67a0
--- /dev/null
+++ b/drivers/accel/qda/qda_cb.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_CB_H__
+#define __QDA_CB_H__
+
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include "qda_drv.h"
+
+/**
+ * struct qda_cb_dev - Bookkeeping for one compute context bank device
+ */
+struct qda_cb_dev {
+	/** @node: Entry in &qda_dev.cb_devs */
+	struct list_head node;
+	/** @pdev: Platform device created for the context bank node */
+	struct platform_device *pdev;
+};
+
+/* Create a device for each context bank child node of @parent_node */
+int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node);
+/* Destroy every context bank device created by qda_cb_populate() */
+void qda_cb_unpopulate(struct qda_dev *qdev);
+
+#endif /* __QDA_CB_H__ */
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index f4430332ff6e..6ecb6a966f68 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -65,6 +65,8 @@ struct qda_dev *qda_alloc_device(struct device *dev)
 	if (IS_ERR(qdev))
 		return ERR_CAST(qdev);
 
+	INIT_LIST_HEAD(&qdev->cb_devs);
+
 	return qdev;
 }
 
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index dd3345b6a5ad..737232f7027f 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -7,11 +7,13 @@
 #define __QDA_DRV_H__
 
 #include <linux/device.h>
+#include <linux/list.h>
 #include <linux/rpmsg.h>
 #include <linux/types.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
+#include "qda_soc.h"
 
 /* Driver identification */
 #define QDA_DRIVER_NAME "qda"
@@ -41,6 +43,10 @@ struct qda_dev {
 	struct rpmsg_device *rpdev;
 	/** @dev: Underlying Linux device */
 	struct device *dev;
+	/** @cb_devs: Compute context-bank (CB) child devices */
+	struct list_head cb_devs;
+	/** @soc_data: Per-SoC DSP integration parameters */
+	const struct qda_soc_data *soc_data;
 	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
 	const char *dsp_name;
 };
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
index 6bd977e8d68a..78b5f31974c1 100644
--- a/drivers/accel/qda/qda_rpmsg.c
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -5,18 +5,18 @@
 #include <linux/rpmsg.h>
 #include <drm/drm_print.h>
 
+#include "qda_cb.h"
 #include "qda_drv.h"
+#include "qda_soc.h"
 
 /*
  * Both compatibles the binding defines are matched here. The glymur, hawi,
  * maili and nord nodes name "qcom,kaanapali-fastrpc" as their fallback
- * compatible and so are matched by that entry. Per-SoC DSP parameters are
- * attached as match data by a later patch, once there is something that
- * consumes them.
+ * compatible and so are matched by that entry.
  */
 static const struct of_device_id qda_rpmsg_of_match[] = {
-	{ .compatible = "qcom,kaanapali-fastrpc" },
-	{ .compatible = "qcom,fastrpc" },
+	{ .compatible = "qcom,kaanapali-fastrpc", .data = &kaanapali_soc_data },
+	{ .compatible = "qcom,fastrpc", .data = &default_soc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qda_rpmsg_of_match);
@@ -58,6 +58,7 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
 	 */
 	drm_dev_unplug(&qdev->drm_dev);
 	qdev->rpdev = NULL;
+	qda_cb_unpopulate(qdev);
 }
 
 static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
@@ -69,13 +70,25 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (IS_ERR(qdev))
 		return PTR_ERR(qdev);
 
+	qdev->soc_data = of_device_get_match_data(&rpdev->dev);
+	if (!qdev->soc_data)
+		return -ENODEV;
+
 	ret = of_property_read_string(rpdev->dev.of_node, "label", &qdev->dsp_name);
 	if (ret) {
 		dev_err(&rpdev->dev, "Missing 'label' property in DT node: %d\n", ret);
 		return ret;
 	}
 
-	return qda_register_device(qdev);
+	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
+	if (ret)
+		return ret;
+
+	ret = qda_register_device(qdev);
+	if (ret)
+		qda_cb_unpopulate(qdev);
+
+	return ret;
 }
 
 static struct rpmsg_driver qda_rpmsg_driver = {
diff --git a/drivers/accel/qda/qda_soc.c b/drivers/accel/qda/qda_soc.c
new file mode 100644
index 000000000000..323b620b8adb
--- /dev/null
+++ b/drivers/accel/qda/qda_soc.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/string.h>
+#include "qda_drv.h"
+#include "qda_soc.h"
+
+const struct qda_soc_data kaanapali_soc_data = {
+	.dma_addr_bits_cdsp = 34,
+	.dma_addr_bits_default = 32,
+};
+
+const struct qda_soc_data default_soc_data = {
+	.dma_addr_bits_cdsp = 32,
+	.dma_addr_bits_default = 32,
+};
+
+/**
+ * qda_soc_dma_addr_bits() - DMA address width of a device's context banks
+ * @qdev: QDA device
+ *
+ * All CDSP instances (cdsp, cdsp1, ...) share the CDSP width.
+ *
+ * Return: Number of DMA address bits the DSP can address on @qdev
+ */
+u32 qda_soc_dma_addr_bits(const struct qda_dev *qdev)
+{
+	if (!strncmp(qdev->dsp_name, "cdsp", 4))
+		return qdev->soc_data->dma_addr_bits_cdsp;
+
+	return qdev->soc_data->dma_addr_bits_default;
+}
diff --git a/drivers/accel/qda/qda_soc.h b/drivers/accel/qda/qda_soc.h
new file mode 100644
index 000000000000..b052964f11ae
--- /dev/null
+++ b/drivers/accel/qda/qda_soc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_SOC_H__
+#define __QDA_SOC_H__
+
+#include <linux/types.h>
+
+struct qda_dev;
+
+/**
+ * struct qda_soc_data - Per-SoC DSP integration parameters
+ *
+ * Selected by OF match on the fastrpc node; see qda_rpmsg.c.
+ */
+struct qda_soc_data {
+	/** @dma_addr_bits_cdsp: DMA address width of CDSP context banks */
+	u32 dma_addr_bits_cdsp;
+	/** @dma_addr_bits_default: DMA address width of all other context banks */
+	u32 dma_addr_bits_default;
+};
+
+extern const struct qda_soc_data kaanapali_soc_data;
+extern const struct qda_soc_data default_soc_data;
+
+u32 qda_soc_dma_addr_bits(const struct qda_dev *qdev);
+
+#endif /* __QDA_SOC_H__ */

-- 
2.34.1

