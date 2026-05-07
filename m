Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D5ECD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65ED010EF48;
	Thu,  7 May 2026 06:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmU4McbE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZndiQv9a";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B65610EF48
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:23:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64757fR93036458
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wqlIPTlhmBb
 CJdFzW+UetDgAOjHAm1lIAxJEuFxtZms=; b=AmU4McbEwZZVev9lpbyDoJqTvkZ
 hPQDHckicgyHEsO+7eCNACzVUDqFQXOUhqezQRHVclxaFZm+SHG6FRNI/rOlCv2N
 v84rEOSh/q8us6rcEnKVLT//YfH/KFJ6nLLSYk+lLh1wjNuqaLQBlXlz+uIWGE+t
 GUp0xGIDMMdKgDuGy2I1FG/2aFj9DZ4fnaJOWoma1snmn/vP+Ql+J/EEgraTZ8e4
 UHiU4S0sfBGXAdovky7ykT3CikzEM2uhFH5Srs7HTKiFysCPQXPzDptzYJNBxHKD
 QduVFEoV+rWvGGQ+fVqUM3zhbUefWap01NyQhR/hGxOwdE+RbooicRwOAAQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf3gf1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:23:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c823549b1fcso613905a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778134985; x=1778739785;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqlIPTlhmBbCJdFzW+UetDgAOjHAm1lIAxJEuFxtZms=;
 b=ZndiQv9azaikt+HTa1xqvzrNN4KJo0NETRR/gYq8+tHMON15HQg2HzkmRAY9d7UAH2
 PI7NKlNyoAHOCHkRCSe7xXCV0yZ2FRiFEX+P+gZgxHXYg7+ijoiNiMDhySzPiul0Wbi1
 w5SwyikYq6xCF6Vd93to+W0HNuV8V789kbKtZwmxODlg9Vltd9bW0YmehOVDAtJADS/r
 3T0faLmmwKATHam52pEWyvQI6HJwuKb/7GFPUBy28GNfzg0/C9RwHpsnw84d+sWW8rij
 DFscHdDiezdK97YdDVMO+5ZWItQw2JvDwav8rnWIdbmiEraL4f4xRCjebKs0U7tH1QEJ
 iKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134985; x=1778739785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wqlIPTlhmBbCJdFzW+UetDgAOjHAm1lIAxJEuFxtZms=;
 b=fLgHM7C4j0/b85QbYXaA5K03Qnls8lK8qLP8WLsAjliZ0FhufSP1zHyV27VocQ/2SR
 D3pJpUZKwBdgByVT9CgJzOao4IsX5Fzk4FOsU66l0e310Vd93otSWJ0laKTdgfZrHXFB
 cipaOEbSFQgidwOB4E3pd8Qb+pKMoNF7HXJHe1Tcaz2CqujmarxOnlj/3oQPugs/+cF1
 QmUweM6tedIX/kqAJAz80gaEwU2fKwlsvWOUjxJ4Qcr5TKOAtGJ+/3G0+3oP6S4UduFP
 Oc7xDvYQQcKphmH4i2GMETQkqLevFor1MQfTbG7mv8cNo6ZrPulldPciOTURLrLBwyy+
 06NA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/m7iZyqF7muj9UI+oU8OsvsA1/qN9jYzBpEwbZ8XqQKKbeNRvHaEK46nVpKzuLnE6scX0xivjTjuQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweMlibdKKZqrH8ZVdeifZFMivYuC4fzNpJ05/zHaXCIhhX6oN/
 7mTeOtf5nwfaX5jG6RdRBgRH+zWtidKkTOqE8ldS7lb5InC04ykHQfusBdTuovd2s5oxlkOXpNo
 zxQBIw4ntNqU3+ouhm9DZuG64vEgE2DkuP+lFqd2MVp/yJmPFXljg79v9rRa6DG7djUvTTvM=
X-Gm-Gg: AeBDievocMlCwGagcd3SVXL07KPgouLtfSns1pAnz0qGw2gm91EJH8VxLxAekbWaY5f
 /XhM2kncBwuLgoc+Xw7Iemh23/bewgnSWE9iDpa0wLotIgW1Kt3Qu2JiMDq37qU+3ZaHaB/eVrc
 1sA2Gy62K88LT3KZ7EfOkGA0oH0Q8Fmm25mAW3tXA85Y2XupqeloFAxBd6Bw8LUeyXPRsMNWUGN
 3i5mQ/nnxRA+jAmDTPkfU8XEtb9Vp+2By84yvmp9LmdWnlPM7gB2SDfNdlpa/tvZsHVRlUkiZEU
 TFLMxAGfqCmQyXmL+fRjHkxJDjpQMtlXqHt6gS4S5tn83Jm7FnsVagBq9T1Z6Eh1OF/SEOQu2HV
 udKnXIDtmMqRbkc53gm9w1FjdnqGkB443fBVq/Xlq/3bsfqyKsYRM98yJF2HLvDeZe/LC+EaH1s
 5x7hTKeMuT5Sx0iTcLqZXZUM4ccNMXk5yK+XG50JCPv314TTc=
X-Received: by 2002:a05:6a00:c95:b0:82a:65fa:cecf with SMTP id
 d2e1a72fcca58-83a5bada322mr6431046b3a.4.1778134984993; 
 Wed, 06 May 2026 23:23:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:c95:b0:82a:65fa:cecf with SMTP id
 d2e1a72fcca58-83a5bada322mr6431017b3a.4.1778134984445; 
 Wed, 06 May 2026 23:23:04 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:23:04 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Shivnandan Kumar <quic_kshivnan@quicinc.com>,
 Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>,
 Amir Vajid <avajid@quicinc.com>
Subject: [RFC V6 2/8] firmware: arm_scmi: vendors: Add QCOM SCMI Generic
 Extensions
Date: Thu,  7 May 2026 11:52:31 +0530
Message-Id: <20260507062237.78051-3-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfXxExt+tEvZ8Se
 7OCliu4qfeSMzt9hGfFQ+q5uyrsHCMtGR5YFItwltjwYEA9YskQHMMt1PAMAp++LBgoiPPfP8L/
 WDEkZE6qksNWRoOR3iO0/uv8t3BfOF/rJTodWEby7PR76a0khbukEbdd4EXfdtITEr/4/ZRwHQi
 wNzuVjvlLW41OWcy+BxLTJ9+kvPyP1+sEyRCx1WfaOjJE7LGnpKXmHAEQ7twqrwsugiaYzfzoXe
 cbhrEJ0T/K7Y3QvCLU9mu4JeK4UdJVirI9tdRT6Frd2pkhas/0qjt9hsY56uCxEfbd43neeuJC5
 sLC2RTbhVqCa/l0LlyN0SX+pxs79Ur7kD0Gkxz5brpKoLK/dX2ZltS54FHxBjGnoxzmtelWbuRc
 iB3zeJPjE1O/6CErWIVP2/KDaSTC7S1kq19A/GNnOVYVPUNfjHi1FV7gCVLNAq03P5pMHI34FvB
 lC2tG2nCuBKR6iaz98w==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fc2fca cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=5qo32d-oOMBYuVP3DBMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sWrwpPwN-Hal65I7DBjrmJ6D-UbURGfW
X-Proofpoint-ORIG-GUID: sWrwpPwN-Hal65I7DBjrmJ6D-UbURGfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070060
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

The QCOM SCMI Generic Extensions Protocol provides a generic way of
exposing a number of Qualcomm SoC specific features (like memory bus
scaling) through a mixture of pre-determined algorithm strings and
param_id pairs hosted on the SCMI controller.

Co-developed-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
Co-developed-by: Amir Vajid <avajid@quicinc.com>
Signed-off-by: Amir Vajid <avajid@quicinc.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

@Sudeep/@Christian, Just moving the series back in RFC mode to get feedback
on the devfreq part of the series. Will add a lot more documentation in the
next re-spin, so definitely not ignoring your earlier comments :).

 drivers/firmware/arm_scmi/Kconfig             |   1 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 .../firmware/arm_scmi/vendors/qcom/Kconfig    |  15 ++
 .../firmware/arm_scmi/vendors/qcom/Makefile   |   2 +
 .../arm_scmi/vendors/qcom/qcom-generic-ext.c  | 135 ++++++++++++++++++
 include/linux/scmi_qcom_protocol.h            |  37 +++++
 6 files changed, 191 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/Makefile
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
 create mode 100644 include/linux/scmi_qcom_protocol.h

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index e3fb36825978..a52f4d1b8b2c 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -84,6 +84,7 @@ config ARM_SCMI_QUIRKS
 
 source "drivers/firmware/arm_scmi/transports/Kconfig"
 source "drivers/firmware/arm_scmi/vendors/imx/Kconfig"
+source "drivers/firmware/arm_scmi/vendors/qcom/Kconfig"
 
 endif #ARM_SCMI_PROTOCOL
 
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 780cd62b2f78..5a0e003c2477 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -13,6 +13,7 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += transports/
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += vendors/imx/
+obj-$(CONFIG_ARM_SCMI_PROTOCOL) += vendors/qcom/
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
diff --git a/drivers/firmware/arm_scmi/vendors/qcom/Kconfig b/drivers/firmware/arm_scmi/vendors/qcom/Kconfig
new file mode 100644
index 000000000000..5dd9e8a6b75f
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "ARM SCMI QCOM Vendor Protocols"
+
+config QCOM_SCMI_GENERIC_EXT
+	tristate "Qualcomm Technologies, Inc. Qcom SCMI vendor Protocol"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	help
+	  The QCOM SCMI vendor protocol provides a generic way of exposing
+	  a number of Qualcomm SoC specific features (like memory bus scaling)
+	  through a mixture of pre-determined algorithm strings and param_id
+	  pairs hosted on the SCMI controller.
+
+	  This driver defines/documents the message ID's used for this
+	  communication and also exposes the operations used by the clients.
+endmenu
diff --git a/drivers/firmware/arm_scmi/vendors/qcom/Makefile b/drivers/firmware/arm_scmi/vendors/qcom/Makefile
new file mode 100644
index 000000000000..6b98fabbebb8
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_QCOM_SCMI_GENERIC_EXT) += qcom-generic-ext.o
diff --git a/drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c b/drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
new file mode 100644
index 000000000000..4f9eba8ff4bd
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/scmi_qcom_protocol.h>
+
+#include "../../common.h"
+
+/**
+ * enum qcom_generic_ext_protocol_cmd - vendor specific commands supported by SCMI Qualcomm
+ *                                      generic vendor protocol.
+ *
+ * This protocol is intended as a generic way of exposing a number of Qualcomm SoC
+ * specific features through a mixture of pre-determined algorithm string and param_id
+ * pairs hosted on the SCMI controller.
+ *
+ * The QCOM SCMI Vendor Protocol has the protocol id as 0x80 and vendor id set to
+ * Qualcomm and the supported version is set to 0x10000. The PROTOCOL_VERSION command
+ * returns version 1.0.
+ *
+ * @QCOM_SCMI_SET_PARAM: is used to set the parameter of a specific algo_str hosted on
+ *			 QCOM SCMI Vendor Protocol. The tx len depends on the algo_str used.
+ * @QCOM_SCMI_GET_PARAM: is used to get parameter information of a specific algo_str
+ *			 hosted on QCOM SCMI Vendor Protocol. The tx and rx len depends
+ *			 on the algo_str used.
+ * @QCOM_SCMI_START_ACTIVITY: is used to start the activity performed by the algo_str.
+ * @QCOM_SCMI_STOP_ACTIVITY: is used to stop a pre-existing activity performed by the algo_str.
+ */
+enum qcom_generic_ext_protocol_cmd {
+	QCOM_SCMI_SET_PARAM = 0x10,
+	QCOM_SCMI_GET_PARAM = 0x11,
+	QCOM_SCMI_START_ACTIVITY = 0x12,
+	QCOM_SCMI_STOP_ACTIVITY = 0x13,
+};
+
+/**
+ * struct qcom_scmi_msg - represents the various parameters to be populated
+ *                        for using the QCOM SCMI Vendor Protocol
+ *
+ * @ext_id: reserved, must be zero
+ * @algo_low: lower 32 bits of the algo_str
+ * @algo_high: upper 32 bits of the algo_str
+ * @param_id: serves as token message id to the specific algo_str
+ * @buf: serves as the payload to the specified param_id and algo_str pair
+ */
+struct qcom_scmi_msg {
+	__le32 ext_id;
+	__le32 algo_low;
+	__le32 algo_high;
+	__le32 param_id;
+	__le32 buf[];
+};
+
+static int qcom_scmi_common_xfer(const struct scmi_protocol_handle *ph,
+				 enum qcom_generic_ext_protocol_cmd cmd_id, void *buf,
+				 size_t buf_len, u64 algo_str, u32 param_id, size_t rx_size)
+{
+	struct scmi_xfer *t;
+	struct qcom_scmi_msg *msg;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, cmd_id, buf_len + sizeof(*msg), rx_size, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->algo_low = cpu_to_le32(lower_32_bits(algo_str));
+	msg->algo_high = cpu_to_le32(upper_32_bits(algo_str));
+	msg->param_id = cpu_to_le32(param_id);
+	memcpy(msg->buf, buf, buf_len);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret && rx_size)
+		memcpy(buf, t->rx.buf, t->rx.len);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int qcom_scmi_set_param(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			       u64 algo_str, u32 param_id)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_SET_PARAM, buf, buf_len, algo_str,
+				     param_id, 0);
+}
+
+static int qcom_scmi_get_param(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			       u64 algo_str, u32 param_id, size_t rx_size)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_GET_PARAM, buf, buf_len, algo_str,
+				     param_id, rx_size);
+}
+
+static int qcom_scmi_start_activity(const struct scmi_protocol_handle *ph, void *buf,
+				    size_t buf_len, u64 algo_str, u32 param_id)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_START_ACTIVITY, buf, buf_len, algo_str,
+				     param_id, 0);
+}
+
+static int qcom_scmi_stop_activity(const struct scmi_protocol_handle *ph, void *buf,
+				   size_t buf_len, u64 algo_str, u32 param_id)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_STOP_ACTIVITY, buf, buf_len, algo_str,
+				     param_id, 0);
+}
+
+static struct qcom_generic_ext_ops qcom_proto_ops = {
+	.set_param = qcom_scmi_set_param,
+	.get_param = qcom_scmi_get_param,
+	.start_activity = qcom_scmi_start_activity,
+	.stop_activity = qcom_scmi_stop_activity,
+};
+
+static int qcom_generic_ext_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	dev_dbg(ph->dev, "QCOM Generic Vendor Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(ph->version), PROTOCOL_REV_MINOR(ph->version));
+
+	return 0;
+}
+
+static const struct scmi_protocol qcom_generic_ext = {
+	.id = SCMI_PROTOCOL_QCOM_GENERIC,
+	.owner = THIS_MODULE,
+	.instance_init = &qcom_generic_ext_protocol_init,
+	.ops = &qcom_proto_ops,
+	.vendor_id = "Qualcomm",
+	.supported_version = 0x10000,
+};
+module_scmi_protocol(qcom_generic_ext);
+
+MODULE_DESCRIPTION("QCOM SCMI Generic Vendor protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_qcom_protocol.h b/include/linux/scmi_qcom_protocol.h
new file mode 100644
index 000000000000..465b2522ca29
--- /dev/null
+++ b/include/linux/scmi_qcom_protocol.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SCMI Message Protocol driver QCOM extension header
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_SCMI_QCOM_PROTOCOL_H
+#define _LINUX_SCMI_QCOM_PROTOCOL_H
+
+#include <linux/types.h>
+
+#define SCMI_PROTOCOL_QCOM_GENERIC    0x80
+
+struct scmi_protocol_handle;
+
+/**
+ * struct qcom_generic_ext_ops - represents the various operations provided
+ *				 by QCOM Generic Vendor Protocol
+ *
+ * @set_param: set parameter specified by param_id and algo_str pair.
+ * @get_param: retrieve parameter specified by param_id and algo_str pair.
+ * @start_activity: initiate a specific activity defined by algo_str.
+ * @stop_activity: halt previously initiated activity defined by algo_str.
+ */
+struct qcom_generic_ext_ops {
+	int (*set_param)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			 u64 algo_str, u32 param_id);
+	int (*get_param)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			 u64 algo_str, u32 param_id, size_t rx_size);
+	int (*start_activity)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			      u64 algo_str, u32 param_id);
+	int (*stop_activity)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			     u64 algo_str, u32 param_id);
+};
+
+#endif /* _LINUX_SCMI_QCOM_PROTOCOL_H */
-- 
2.34.1

