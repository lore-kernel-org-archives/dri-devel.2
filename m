Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEBEC5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3735910E626;
	Mon, 17 Aug 2026 04:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRH80dUn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NYkqKPPL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCE910E61C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDHsL4127983
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KWdK6qCL0RqvkILEEB3YURSKbabo3L45W/kg4lUsZ+0=; b=ZRH80dUnbye2hipf
 GinfdofhsP/2qme+RLJapLhK7hafmF5Nc5JnzKJH89rgIdbGtiARWff0oE7kBJo9
 g2Z/VjJxNl9uBiCQJlT9m5tEeZg44Nao2MrWWN+o+/FU7AzA+kfsfCkwGIO8gQHY
 BMuuGuXzR0lmYgIEcGD4By+pArkHojzzLduYfWIKO3QdcH/SPjO/jwWl+/tY267G
 Egb9qzokMuiqX8u6MhzHehZRtvgKhTYbVxnoTLD2LksX2U0Xi1WZzh4TzVdqKhTF
 HvrOXYPsFbEqpUJXpYt3yyoTtiSfmjCBmGfA4EIrRyeoJinPiAcJUpwGlSum4nEh
 iQrqsA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322qauht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:48:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb7049fa552so2434648a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942136; x=1787546936;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWdK6qCL0RqvkILEEB3YURSKbabo3L45W/kg4lUsZ+0=;
 b=NYkqKPPLbAKrUQpYMK2lILmqzVZUCvnutyhkNB3RXbEXkIT9ZKol9q6CgtLKW1s3Td
 8tNfz7qChzaJDehO8azaACe2N1p8VHR+pQkQQhV9wnMFwfLWlkv2trkVAQ92gQ9gJuAi
 HoysBEKODwXg1mrKJ21UueCu7z8Hs0uXxRufLXCdbRgAOaZBL4YnB3fmtvfKjN/JiT9t
 SLFyE6u/+jlrPu5SDhz1B3DG6M8g+5JZYSurFWENm5JxWgM7dV7xgwNgUt2Gva9Rx0lZ
 10gRG2gKeBRlTaziib5tjHl2KmQjuJY9QfbetIJEiTrEVeCyIxYEguHxX5BagzoKD6bn
 /5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942136; x=1787546936;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KWdK6qCL0RqvkILEEB3YURSKbabo3L45W/kg4lUsZ+0=;
 b=HbrcIvDgxNZZMch+fpxJh9mF1nOb5+MCou00WSfkFpjFAv+6TA35vHqFXAkITvAkS0
 P1+qEkR/p0MKDz0IvD6pFf7sP9XpxlhdvbXzT6995ovTXVcqsiXve1OXX/Tciospdjea
 wmVPTZixF6eBwVi8iDDQqC9QAKmUnY05BXaK51Ai6YFIuQ8+BZXYt9N6p9w/r73Kl+OS
 USjy6iSZVNAMTS8HYHsQjNeikeDMu/JznmUalKGFPlql7+oXaGmlCraKxRUBxk8Tyw7a
 J60DoXC71cgElRcrIsO7Xn8U1dhMGMzc59/z2gZoKe/WgujKQTYi8b/Kg0DpcoFdZrFZ
 2SNg==
X-Forwarded-Encrypted: i=1;
 AHgh+Royt9YCKNajHj7nZX5Z7C+IHpTOy++UUiAYp2O039jQKs+FtBjGl2Lwk8e3lfVX9UBpPmlEyQtL2Rw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQh9azfBUF2Axdg8gWWS+E8f+sh3dJLAzOgeHtIxJPYxEg+jz4
 +nxlfrF8GTG0kDlAcbI96WWl9eBx9pNSBpe6wxHMGzFfYbfTURwkvNd4J3XdfEXwrDAYvj6g3Ze
 BE9rM1DhuX5x1OyfDDEpleLEVgZ2ZqQi80awFvw8+HnsJK3Gid+ImAaZfoGJqb0p1p9IHb/g=
X-Gm-Gg: AR+sD12EjUkn7sEZpvpZKTN9RJS6c/Aw0lixMv1pkDX2MsaD2QisvN2LBAxmD1m2kMz
 Qb0BPXV7CWp8/NNHa0AE2bo2192AKJnNGyrjKaLt3249+qGkC1ZiqbwXz4hQCVqs4Ij93tMUwd+
 iqUA8W0LeAwRnITTJnoHFChgWnvgZOXO8ynOtJf4BOKCqnSh9FD6FEKeLAcWOtl/Kp44r7mDkyM
 Ks4Sj9e6+4DEfTp7BZzFjr8zNSA+Cd1AHXi67ozBLHHn2dnEmCn2OHOiwqdW+B4Bb0UV6gSo5zJ
 wHKZGAbSqXVb6Ib6ZNl6HarGV4wPDwBXRokMg4e1FzMtRnopdoWESbhEt11V2/lby3N9/kezRun
 KPO0DpBxswOgbuFBpOfhvLtQrxxNs1Oxn
X-Received: by 2002:a05:6a00:4c1a:b0:848:6447:e0a6 with SMTP id
 d2e1a72fcca58-84fde00137dmr21176326b3a.9.1786942136064; 
 Sun, 16 Aug 2026 21:48:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c1a:b0:848:6447:e0a6 with SMTP id
 d2e1a72fcca58-84fde00137dmr21176263b3a.9.1786942135512; 
 Sun, 16 Aug 2026 21:48:55 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:48:54 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:43 +0530
Subject: [PATCH v2 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=6616;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=HryfLUSzYfOSihZ2yYCxpjSQhD0XgSu5HdZLWNDT3u4=;
 b=5HADVLVN5lGTFZ9UeILGBmzRpc1Heah8/zNUOHlR0SsZM2QupNwPalwofSLkeR6L3t6rmu1FR
 qeDXX1eA5nqAhCunMGLV8+3heCm+nel9Ymani3iC3X4j6e4UGrtFwW5
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX4hRUVL9K5u9W
 aj59kG22/52Q+5nAoy1MUBHChh0ipL5DL93DZecIITmgSdQkH71flGaTpHOGawRUSj/4fUN8CW4
 jsmsX6XXW8Q/kOlHOPZM5RqWU8iqQgQ=
X-Proofpoint-GUID: -ABt3jf1i-xIE0DtSniIj_iLBPDm_rP7
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a8292b8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=50c3GPANBYZkxQ3LsMsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX5Y/CTCXB0NUf
 fu0IGW+pOp5gcmbSmGlPagdJJK2Ca1vy7uenpyD8WpylzcoqdgwOF/K+pUaslhqm4DxXXLPGvv/
 clw5r7EVpv0h389asi6o7EwmjmuXIWKRja+3ISyYuIsMLHxNvDnB8FAZtv7cBwfHYZcy6MrN35Z
 nTCsTZb9UVIyRIbTJbaMY2aNjX054l0KL3qTz3hcSgdXdS/WXUwGW30gyMJdV5fyuUyev/Oz0Ae
 ISPleecfE8736u0Or2eXPYt5q3rTGr6ROelpJ3bjJd2Zwc5m3PAQZ0gYFv4yD/1KGN34FcTP9+H
 S93Fzeuh7kv1tkDbb3i1P//Qb5nXJNp+bpzkpqFwZMznPuyAxI/rPNse/hn0zQwOb+RyD9Jf95E
 OIRbxxM2XLFIY2pGmLWOAyudnRTGzenjUEqRxRjOJWiOtsoc2NincdLopOgvrlskXTn6H29gV8i
 iO3e+JLid0iiQqLxh+g==
X-Proofpoint-ORIG-GUID: -ABt3jf1i-xIE0DtSniIj_iLBPDm_rP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170033
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

Introduce DRM_IOCTL_QDA_QUERY, a query IOCTL that lets user-space
retrieve information about the DSP a given /dev/accel/accel* node
represents.

The IOCTL takes a query_type selector as input, so it can be extended
to return additional parameters (capabilities, attributes) in the
future without adding new IOCTLs: drm_ioctl() zero-extends the argument
structure, so new fields can be appended to struct drm_qda_query as
long as they go at the end. The first supported query,
QDA_QUERY_DSP_NAME, returns the DSP domain name (e.g. "cdsp", "adsp").

The UAPI header include/uapi/drm/qda_accel.h defines the command number,
the DRM_IOWR IOCTL definition, the query_type values, and struct
drm_qda_query. It follows the standard DRM UAPI conventions: fixed-width
types, a C++ extern "C" guard, and GPL-2.0-only WITH Linux-syscall-note
licensing.

qda_ioctl_query() validates the reserved pad field, dispatches on
query_type, and copies the DSP name from qda_dev.dsp_name into the
user-supplied buffer with strscpy(). Unknown query types are rejected
with -EINVAL.

qda_drv.c registers the qda_ioctls[] table with the drm_driver so the
DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Add a query_type input selector so the IOCTL can return different
  parameters in future, and switch DRM_IOR -> DRM_IOWR so the input
  reaches the kernel (Dmitry Baryshkov)
- Reject unknown query types and a non-zero pad with -EINVAL
---
 drivers/accel/qda/Makefile    |  1 +
 drivers/accel/qda/qda_drv.c   |  8 +++++++
 drivers/accel/qda/qda_ioctl.c | 35 +++++++++++++++++++++++++++
 drivers/accel/qda/qda_ioctl.h | 13 ++++++++++
 include/uapi/drm/qda_accel.h  | 55 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+)

diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
index 701fad5ffb50..b658dad35fee 100644
--- a/drivers/accel/qda/Makefile
+++ b/drivers/accel/qda/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
 qda-y := \
 	qda_cb.o \
 	qda_drv.o \
+	qda_ioctl.o \
 	qda_memory_manager.o \
 	qda_rpmsg.o
 
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index fdc909facd95..e1fd8bfa12d7 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -8,8 +8,10 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_print.h>
+#include <drm/qda_accel.h>
 
 #include "qda_drv.h"
+#include "qda_ioctl.h"
 
 static int qda_open(struct drm_device *dev, struct drm_file *file)
 {
@@ -35,11 +37,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 
 DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
 
+static const struct drm_ioctl_desc qda_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
+};
+
 static const struct drm_driver qda_drm_driver = {
 	.driver_features = DRIVER_COMPUTE_ACCEL,
 	.fops = &qda_accel_fops,
 	.open = qda_open,
 	.postclose = qda_postclose,
+	.ioctls = qda_ioctls,
+	.num_ioctls = ARRAY_SIZE(qda_ioctls),
 	.name = QDA_DRIVER_NAME,
 	.desc = "Qualcomm DSP Accelerator Driver",
 };
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
new file mode 100644
index 000000000000..c1d6c9bc0465
--- /dev/null
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <drm/drm_ioctl.h>
+#include <drm/qda_accel.h>
+#include "qda_drv.h"
+#include "qda_ioctl.h"
+
+/**
+ * qda_ioctl_query() - Query DSP device information
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_query)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_query *args = data;
+	struct qda_dev *qdev;
+
+	if (args->pad)
+		return -EINVAL;
+
+	qdev = qda_dev_from_drm(dev);
+
+	switch (args->query_type) {
+	case QDA_QUERY_DSP_NAME:
+		strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
new file mode 100644
index 000000000000..b8fd536a111f
--- /dev/null
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_IOCTL_H__
+#define __QDA_IOCTL_H__
+
+#include "qda_drv.h"
+
+int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
+
+#endif /* __QDA_IOCTL_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
new file mode 100644
index 000000000000..fe695347762c
--- /dev/null
+++ b/include/uapi/drm/qda_accel.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_ACCEL_H__
+#define __QDA_ACCEL_H__
+
+#include "drm.h"
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+/*
+ * QDA IOCTL command numbers
+ *
+ * These define the command numbers for QDA-specific IOCTLs.
+ * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
+ */
+#define DRM_QDA_QUERY		0x00
+
+/*
+ * QDA IOCTL definitions
+ *
+ * These macros define the actual IOCTL numbers used by userspace applications.
+ * They combine the command numbers with DRM_COMMAND_BASE and specify the
+ * data structure and direction (read/write) for each IOCTL.
+ */
+#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
+					 struct drm_qda_query)
+
+/* Query type definitions for drm_qda_query */
+#define QDA_QUERY_DSP_NAME	1
+
+/**
+ * struct drm_qda_query - Device information query structure
+ * @query_type: Type of query (input)
+ * @pad: Padding for 64-bit alignment (must be zero)
+ * @dsp_name: Null-terminated name of the DSP (returned when query_type is QDA_QUERY_DSP_NAME)
+ *
+ * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
+ * based on @query_type.
+ */
+struct drm_qda_query {
+	__u32 query_type;
+	__u32 pad;
+	__u8 dsp_name[16];
+};
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* __QDA_ACCEL_H__ */

-- 
2.34.1

