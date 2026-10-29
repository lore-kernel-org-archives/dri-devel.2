Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335D606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NP9MBSuJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59ACA112525;
	Thu, 29 Oct 2026 20:30:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 225F610E1A4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:30:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJkCWs3718379; Thu, 29 Oct 2026 20:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5KQe29yL9m0
 TctdOW1cq2yqwC7U8Uqx3xJbsVsHGYQo=; b=NP9MBSuJXKVZYmqpiQabUH1qf2E
 mMC4RSlqk5LbRfskZOA0QV7WDFzni/7ChBQ8FC8rCAKBA8nFy63w/Y7NfJ9w/p3/
 IWu6MHhaYHYw3fH9xxscVpc3l3FBIyPUsRedlikzQXDrSZnSd/5Bl3n3phK00wJT
 tAxqLvWqxeQfPD1+oLlK00te24kGckQKf2zCxhRVXOb/eYTWUDppK/IvkHMtFNZw
 qVbkx4FI6X34/BrvwFvkzrRXnjw0Si15RreAlwB3sOGrYOTcR3zC3xZauXoAtBUW
 1KJ5K8r9f4j2lgm6aBbRznVTwO4it2P0WVWuHYiaM5benoXJT5GZmTwKgQA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b30ka-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TKUEmN2842135; Thu, 29 Oct 2026 20:30:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-zmckevit-lv.qualcomm.com
 [10.81.84.220])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69TKUDaj2842014
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 20:30:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4696302)
 id DF66B24DF1; Thu, 29 Oct 2026 13:30:13 -0700 (PDT)
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v2 3/3] accel/qaic: Add callbacks for DRM RAS netlink telemetry
Date: Thu, 29 Oct 2026 13:30:00 -0700
Message-ID: <20261029203000.1763447-4-zachary.mckevitt@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfX1LiUXiQMXLuG
 WTpdLF+Ktzv2yXoMO8FleJQFKjcl0YcQCb0ilBR1q1yhTvJxwLiiUhAl3O7Ejt7Pn+TV6KDk+Nx
 gWVn/y6dNwrFQIAGBrRlcLZbGEdzgUk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4MCBTYWx0ZWRfXzjnh5cjmr5BF
 +IyBOJsF/hYaBc3SSoeVLa34qhljN2KiwyxW9KyhvlTpBW1Q5PgqJaJ1NA2/jlW0HK34EgDBVyj
 eksI1BA3qavc1e9YZQxGv1coUH5SUdSMVmHfl5lsXW7tNpqjY5wh0SAvOBtt4FVMsby7PwBm1SF
 EU3+pDYi+d/z4E3ATU2qeC/8f4V5xJrMmXb5jlI+CGrNDhiw4ujxugjMYXuPmM0qJLYGP6NuYin
 k5Kqu3bLEIOe61U4nLWTwlFaMr3PPn55Ds3o8+i2VCXelUDDOoPRQdwMVKvWD2kepTZ7Hcz7LDb
 6ibcihMzbDycMS/AKZshfCDTSP/OnFqwvF8fTokZbRecpwKpGGXStRkdSh1CAUMKXty+isjmTtI
 ChcEuA5OIwDjdj294a27mZqhJt028MRUkbhROIWMhGGFXtITNB7rWnMWHBKSvjWDtrOqoYlgmA5
 yOl5URrIv1Gjaml9Q0Q==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae3acd7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=ou8Spt5mRBd0vl4EEM4A:9
X-Proofpoint-GUID: ofZpAgned0EfMwF8k7ZfwAibjQdZu8Nu
X-Proofpoint-ORIG-GUID: ofZpAgned0EfMwF8k7ZfwAibjQdZu8Nu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290080
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the DRM RAS netlink infrastructure to perform device telemetry.
During PCI probe, create a DRM RAS node with DRM_RAS_NODE_TYPE_TELEMETRY
type and add callbacks to telemetry_request for read and write operations.

Co-developed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
---
 drivers/accel/qaic/Makefile         |   1 +
 drivers/accel/qaic/qaic.h           |  19 ++
 drivers/accel/qaic/qaic_drv.c       |  22 ++
 drivers/accel/qaic/qaic_telemetry.c | 513 ++++++++++++++++++++++++++++
 drivers/accel/qaic/qaic_telemetry.h |  18 +
 include/uapi/drm/qaic_accel.h       |  28 ++
 6 files changed, 601 insertions(+)
 create mode 100644 drivers/accel/qaic/qaic_telemetry.c
 create mode 100644 drivers/accel/qaic/qaic_telemetry.h

diff --git a/drivers/accel/qaic/Makefile b/drivers/accel/qaic/Makefile
index 71f727b74da3..b2bbe9b3e077 100644
--- a/drivers/accel/qaic/Makefile
+++ b/drivers/accel/qaic/Makefile
@@ -13,6 +13,7 @@ qaic-y := \
 	qaic_ras.o \
 	qaic_ssr.o \
 	qaic_sysfs.o \
+	qaic_telemetry.o \
 	qaic_timesync.o \
 	sahara.o
 
diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
index 889fa51da7da..fa19c758f504 100644
--- a/drivers/accel/qaic/qaic.h
+++ b/drivers/accel/qaic/qaic.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <drm/drm_device.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_ras.h>
 
 #define QAIC_DBC_BASE		SZ_128K
 #define QAIC_DBC_SIZE		SZ_4K
@@ -204,6 +205,24 @@ struct qaic_device {
 	void			*ssr_mhi_buf;
 	/* DBC which is under SSR. Sentinel U32_MAX would mean that no SSR in progress */
 	u32			ssr_dbc;
+	/* MHI telemetry channel device */
+	struct mhi_device	*tele_ch;
+	/* Head in list of requests queued in MHI telemetry device */
+	struct list_head	tele_xfer_list;
+	/* Req. ID of request that will be queued next in MHI telemetry device */
+	u32			tele_next_seq_num;
+	/* Synchronizes MHI telemetry device transactions and its xfer list */
+	struct mutex		tele_mutex;
+	/*
+	 * TRUE: A tx MHI transaction has failed and a rx buffer is still queued
+	 * in telemetry device. Such a buffer is considered lost rx buffer
+	 * FALSE: No rx buffer is lost in telemetry device
+	 */
+	bool			tele_lost_buf;
+	/* Work queue for tasks related to MHI telemetry device */
+	struct workqueue_struct	*tele_wq;
+	/* Netlink telemetry node */
+	struct drm_ras_node *ras_node;
 	/* Array of DBC struct of this device */
 	struct dma_bridge_chan	dbc[] __counted_by(num_dbc);
 };
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 9e1e184efe0d..e24a4f271a58 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -32,6 +32,7 @@
 #include "qaic_debugfs.h"
 #include "qaic_ras.h"
 #include "qaic_ssr.h"
+#include "qaic_telemetry.h"
 #include "qaic_timesync.h"
 #include "sahara.h"
 
@@ -389,6 +390,7 @@ static void qaic_notify_reset(struct qaic_device *qdev)
 	qdev->dev_state = QAIC_OFFLINE;
 	/* wake up any waiters to avoid waiting for timeouts at sync */
 	wake_all_cntl(qdev);
+	wake_all_telemetry(qdev);
 	for (i = 0; i < qdev->num_dbc; ++i)
 		wakeup_dbc(qdev, i);
 	synchronize_srcu(&qdev->dev_lock);
@@ -439,6 +441,9 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 	if (ret)
 		return NULL;
 	ret = drmm_mutex_init(drm, &qdev->bootlog_mutex);
+	if (ret)
+		return NULL;
+	ret = drmm_mutex_init(drm, &qdev->tele_mutex);
 	if (ret)
 		return NULL;
 
@@ -451,6 +456,9 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 	qdev->ssr_wq = qaicm_wq_init(drm, "qaic_ssr");
 	if (IS_ERR(qdev->ssr_wq))
 		return NULL;
+	qdev->tele_wq = qaicm_wq_init(drm, "qaic_tele");
+	if (IS_ERR(qdev->tele_wq))
+		return NULL;
 
 	ret = qaicm_srcu_init(drm, &qdev->dev_lock);
 	if (ret)
@@ -466,6 +474,7 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 
 	INIT_LIST_HEAD(&qdev->cntl_xfer_list);
 	INIT_LIST_HEAD(&qdev->bootlog);
+	INIT_LIST_HEAD(&qdev->tele_xfer_list);
 	INIT_LIST_HEAD(&qddev->users);
 
 	for (i = 0; i < qdev->num_dbc; ++i) {
@@ -611,6 +620,13 @@ static int qaic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
+	ret = qaic_drm_ras_register_node(qdev);
+	if (ret) {
+		qaic_mhi_free_controller(qdev->mhi_cntrl, link_up);
+		qaic_destroy_drm_device(qdev, QAIC_NO_PARTITION);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -624,6 +640,7 @@ static void qaic_pci_remove(struct pci_dev *pdev)
 		return;
 
 	qaic_dev_reset_clean_local_state(qdev);
+	qaic_drm_ras_unregister_node(qdev);
 	qaic_mhi_free_controller(qdev->mhi_cntrl, link_up);
 	qaic_destroy_drm_device(qdev, QAIC_NO_PARTITION);
 }
@@ -860,6 +877,10 @@ static int __init qaic_init(void)
 		goto free_bootlog;
 	}
 
+	ret = qaic_telemetry_register();
+	if (ret)
+		pr_debug("qaic: qaic_telemetry_register failed %d\n", ret);
+
 	return 0;
 
 free_bootlog:
@@ -889,6 +910,7 @@ static void __exit qaic_exit(void)
 	 * reinitializing the link_up state after the cleanup is done.
 	 */
 	link_up = true;
+	qaic_telemetry_unregister();
 	qaic_ssr_unregister();
 	qaic_ras_unregister();
 	qaic_bootlog_unregister();
diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qaic_telemetry.c
new file mode 100644
index 000000000000..fdce7a71d3eb
--- /dev/null
+++ b/drivers/accel/qaic/qaic_telemetry.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (c) 2020-2021, The Linux Foundation. All rights reserved. */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+#include <drm/drm_file.h>
+#include <drm/drm_ras.h>
+#include <asm/byteorder.h>
+#include <linux/completion.h>
+#include <linux/fs.h>
+#include <linux/fs_struct.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/mutex.h>
+#include <linux/namei.h>
+#include <linux/path.h>
+#include <linux/sprintf.h>
+#include <linux/srcu.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <uapi/drm/qaic_accel.h>
+
+#include "qaic.h"
+#include "qaic_telemetry.h"
+
+#define MAGIC				0x55AA
+#define VERSION				0x1
+
+/*
+ * Telemetry fields defined by the uAPI.
+ * This table will be used by drm_ras's dumpit to display
+ * each field to userspace.
+ */
+const struct drm_ras_telemetry_field qaic_telemetry_fields_gettable[] = {
+	{"QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP", 1},
+	{"QAIC_DEVINFO_THERMAL_BOARD_TEMP", 2},
+	{"QAIC_DEVINFO_THERMAL_BOARD_MAX_TEMP", 3},
+	{"QAIC_DEVINFO_THERMAL_DDR_TEMP", 4},
+	{"QAIC_DEVINFO_THERMAL_WARNING_TEMP", 5},
+	{"QAIC_DEVINFO_THERMAL_SHUTDOWN_TEMP", 6},
+	{"QAIC_DEVINFO_BOARD_TDP", 7},
+	{"QAIC_DEVINFO_BOARD_POWER", 8},
+	{"QAIC_DEVINFO_POWER_STATE", 9},
+	{"QAIC_DEVINFO_POWER_MAX", 10},
+	{"QAIC_DEVINFO_THROTTLE_PERCENT", 11},
+	{"QAIC_DEVINFO_THROTTLE_TIME", 12},
+	{"QAIC_DEVINFO_UPTIME", 13},
+	{"QAIC_DEVINFO_THERMAL_SOC_FLOOR_TEMP", 14},
+	{"QAIC_DEVINFO_THERMAL_SOC_CEILING_TEMP", 15},
+	{"QAIC_DEVINFO_VOLTAGE_CX", 16},
+	{"QAIC_DEVINFO_VOLTAGE_MX", 17},
+	{"QAIC_DEVINFO_VOLTAGE_NSP_CX", 18},
+	{"QAIC_DEVINFO_VOLTAGE_NSP_MX", 19},
+	{"QAIC_DEVINFO_CFG_TOPS", 20},
+	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_A", 21},
+	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_C", 22},
+	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_E", 23},
+	{"QAIC_DEVINFO_POWER_ACTION", 24},
+	{"QAIC_DEVINFO_SOC_TDP", 25},
+	{"QAIC_DEVINFO_SOC_POWER", 26},
+	{},
+};
+
+const struct drm_ras_telemetry_field qaic_telemetry_fields_settable[] = {
+	{"QAIC_DEVINFO_THERMAL_WARNING_TEMP", 5},
+	{"QAIC_DEVINFO_THERMAL_SHUTDOWN_TEMP", 6},
+	{"QAIC_DEVINFO_BOARD_TDP", 7},
+	{"QAIC_DEVINFO_POWER_STATE", 9},
+	{"QAIC_DEVINFO_CFG_TOPS", 20},
+	{"QAIC_DEVINFO_POWER_ACTION", 24},
+	{"QAIC_DEVINFO_SOC_TDP", 25},
+	{},
+};
+
+enum fw_errno {
+	ERR_READ_ONLY		= -1,
+	ERR_NOT_SUPPORTED	= -2,
+	ERR_WHILE_PROCESSING	= -3,
+	ERR_INVALID_VALUE	= -4,
+	ERR_INVALID_HEADER	= -5,
+};
+
+enum cmd_type {
+	TYPE_READ,  /* read value from device */
+	TYPE_WRITE, /* write value to device */
+};
+
+enum msg_type {
+	MSG_PUSH, /* async push from device */
+	MSG_REQ,  /* sync request to device */
+	MSG_RESP, /* sync response from device */
+};
+
+struct telemetry_data {
+	u8	cmd;
+	u8	cmd_type;
+	u8	status;
+	__le64	val; /* signed */
+} __packed;
+
+struct telemetry_header {
+	__le16	magic;
+	__le16	ver;
+	__le32	seq_num;
+	u8	type;
+	u8	id;
+	__le16	len;
+} __packed;
+
+struct telemetry_msg { /* little endian encoded */
+	struct telemetry_header hdr;
+	struct telemetry_data data;
+} __packed;
+
+struct wrapper_msg {
+	struct kref ref_count;
+	struct telemetry_msg msg;
+};
+
+struct xfer_queue_elem {
+	/*
+	 * Node in list of ongoing transfer request on telemetry channel.
+	 * Maintained by root device struct
+	 */
+	struct list_head list;
+	/* Sequence number of this transfer request */
+	u32 seq_num;
+	/* This is used to wait on until completion of transfer request */
+	struct completion xfer_done;
+	/* Received data from device */
+	void *buf;
+};
+
+struct resp_work {
+	/* Work struct to schedule work coming on QAIC_TELEMETRY channel */
+	struct work_struct work;
+	/* Root struct of device, used to access device resources */
+	struct qaic_device *qdev;
+	/* Buffer used by MHI for transfer requests */
+	void *buf;
+};
+
+static void free_wrapper(struct kref *ref)
+{
+	struct wrapper_msg *wrapper = container_of(ref, struct wrapper_msg, ref_count);
+
+	kfree(wrapper);
+}
+
+int telemetry_request(struct qaic_device *qdev, u8 cmd, u8 cmd_type, s64 *val)
+{
+	struct wrapper_msg *wrapper;
+	struct xfer_queue_elem elem;
+	struct telemetry_msg *resp;
+	struct telemetry_msg *req;
+	long ret = 0;
+
+	wrapper = kzalloc_obj(*wrapper);
+	if (!wrapper)
+		return -ENOMEM;
+
+	kref_init(&wrapper->ref_count);
+	req = &wrapper->msg;
+
+	ret = mutex_lock_interruptible(&qdev->tele_mutex);
+	if (ret)
+		goto free_req;
+
+	req->hdr.magic = cpu_to_le16(MAGIC);
+	req->hdr.ver = cpu_to_le16(VERSION);
+	req->hdr.seq_num = cpu_to_le32(qdev->tele_next_seq_num++);
+	req->hdr.type = MSG_REQ;
+	req->hdr.id = 0;
+	req->hdr.len = cpu_to_le16(sizeof(req->data));
+
+	req->data.cmd = cmd;
+	req->data.cmd_type = cmd_type;
+	req->data.status = 0;
+	if (cmd_type == TYPE_READ)
+		req->data.val = cpu_to_le64(0);
+	else
+		req->data.val = cpu_to_le64(*val);
+
+	elem.seq_num = qdev->tele_next_seq_num - 1;
+	elem.buf = NULL;
+	init_completion(&elem.xfer_done);
+	if (likely(!qdev->tele_lost_buf)) {
+		resp = kzalloc_obj(*resp);
+		if (!resp) {
+			mutex_unlock(&qdev->tele_mutex);
+			ret = -ENOMEM;
+			goto free_req;
+		}
+
+		ret = mhi_queue_buf(qdev->tele_ch, DMA_FROM_DEVICE, resp, sizeof(*resp), MHI_EOT);
+		if (ret) {
+			mutex_unlock(&qdev->tele_mutex);
+			goto free_resp;
+		}
+	} else {
+		/*
+		 * we lost a buffer because we queued a recv buf, but then
+		 * queuing the corresponding tx buf failed. To try to avoid
+		 * a memory leak, lets reclaim it and use it for this
+		 * transaction.
+		 */
+		qdev->tele_lost_buf = false;
+	}
+
+	kref_get(&wrapper->ref_count);
+	ret = mhi_queue_buf(qdev->tele_ch, DMA_TO_DEVICE, req, sizeof(*req), MHI_EOT);
+	if (ret) {
+		qdev->tele_lost_buf = true;
+		kref_put(&wrapper->ref_count, free_wrapper);
+		mutex_unlock(&qdev->tele_mutex);
+		goto free_req;
+	}
+
+	list_add_tail(&elem.list, &qdev->tele_xfer_list);
+	mutex_unlock(&qdev->tele_mutex);
+
+	ret = wait_for_completion_interruptible_timeout(&elem.xfer_done, HZ);
+	/*
+	 * not using _interruptable because we have to cleanup or we'll
+	 * likely cause memory corruption
+	 */
+	mutex_lock(&qdev->tele_mutex);
+	if (!list_empty(&elem.list))
+		list_del(&elem.list);
+	if (!ret && !elem.buf)
+		ret = -ETIMEDOUT;
+	else if (ret > 0 && !elem.buf)
+		ret = -EIO;
+	mutex_unlock(&qdev->tele_mutex);
+
+	resp = elem.buf;
+
+	if (ret < 0)
+		goto free_resp;
+
+	if (le16_to_cpu(resp->hdr.magic) != MAGIC || le16_to_cpu(resp->hdr.ver) != VERSION ||
+	    resp->hdr.type != MSG_RESP || resp->hdr.id != 0 ||
+	    le16_to_cpu(resp->hdr.len) != sizeof(resp->data) || resp->data.cmd != cmd ||
+	    resp->data.cmd_type != cmd_type) {
+		ret = -EINVAL;
+		goto free_resp;
+	}
+
+	if (resp->data.status) {
+		switch ((int8_t) resp->data.status) {
+		case ERR_READ_ONLY:
+			ret = -EROFS;
+			break;
+		case ERR_NOT_SUPPORTED:
+			ret = -EOPNOTSUPP;
+			break;
+		case ERR_WHILE_PROCESSING:
+			ret = -EREMOTEIO;
+			break;
+		case ERR_INVALID_VALUE:
+			ret = -EINVAL;
+			break;
+		case ERR_INVALID_HEADER:
+			ret = -EBADR;
+			break;
+		default:
+			ret = -EPROTO;
+		}
+		goto free_resp;
+	}
+
+	if (cmd_type == TYPE_READ)
+		*val = le64_to_cpu(resp->data.val);
+
+	ret = 0;
+
+free_resp:
+	kfree(resp);
+free_req:
+	kref_put(&wrapper->ref_count, free_wrapper);
+
+	return ret;
+}
+
+static int qaic_telemetry_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_id *id)
+{
+	struct qaic_device *qdev = pci_get_drvdata(to_pci_dev(mhi_dev->mhi_cntrl->cntrl_dev));
+	int ret;
+
+	ret = mhi_prepare_for_transfer(mhi_dev);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&mhi_dev->dev, qdev);
+	qdev->tele_ch = mhi_dev;
+	qdev->tele_lost_buf = false;
+
+	return 0;
+}
+
+static void qaic_telemetry_mhi_remove(struct mhi_device *mhi_dev)
+{
+	struct qaic_device *qdev = dev_get_drvdata(&mhi_dev->dev);
+
+	mhi_unprepare_from_transfer(qdev->tele_ch);
+	qdev->tele_ch = NULL;
+}
+
+static void resp_worker(struct work_struct *work)
+{
+	struct resp_work *resp = container_of(work, struct resp_work, work);
+	struct qaic_device *qdev = resp->qdev;
+	struct telemetry_msg *msg = resp->buf;
+	struct xfer_queue_elem *elem;
+	struct xfer_queue_elem *i;
+	bool found = false;
+
+	if (le16_to_cpu(msg->hdr.magic) != MAGIC) {
+		kfree(msg);
+		kfree(resp);
+		return;
+	}
+
+	mutex_lock(&qdev->tele_mutex);
+	list_for_each_entry_safe(elem, i, &qdev->tele_xfer_list, list) {
+		if (elem->seq_num == le32_to_cpu(msg->hdr.seq_num)) {
+			found = true;
+			list_del_init(&elem->list);
+			elem->buf = msg;
+			complete_all(&elem->xfer_done);
+			break;
+		}
+	}
+	mutex_unlock(&qdev->tele_mutex);
+
+	if (!found)
+		/* request must have timed out, drop packet */
+		kfree(msg);
+
+	kfree(resp);
+}
+
+static void qaic_telemetry_mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
+					  struct mhi_result *mhi_result)
+{
+	struct telemetry_msg *msg = mhi_result->buf_addr;
+	struct wrapper_msg *wrapper;
+
+	wrapper = container_of(msg, struct wrapper_msg, msg);
+	kref_put(&wrapper->ref_count, free_wrapper);
+}
+
+static void qaic_telemetry_mhi_dl_xfer_cb(struct mhi_device *mhi_dev,
+					  struct mhi_result *mhi_result)
+{
+	struct qaic_device *qdev = dev_get_drvdata(&mhi_dev->dev);
+	struct telemetry_msg *msg = mhi_result->buf_addr;
+	struct resp_work *resp;
+
+	if (mhi_result->transaction_status) {
+		kfree(msg);
+		return;
+	}
+
+	resp = kmalloc(sizeof(*resp), GFP_ATOMIC);
+	if (!resp) {
+		pci_err(qdev->pdev, "dl_xfer_cb alloc fail, dropping message\n");
+		kfree(msg);
+		return;
+	}
+
+	INIT_WORK(&resp->work, resp_worker);
+	resp->qdev = qdev;
+	resp->buf = msg;
+	queue_work(qdev->tele_wq, &resp->work);
+}
+
+static const struct mhi_device_id qaic_telemetry_mhi_match_table[] = {
+	{ .chan = "QAIC_TELEMETRY", },
+	{},
+};
+
+static struct mhi_driver qaic_telemetry_mhi_driver = {
+	.id_table = qaic_telemetry_mhi_match_table,
+	.remove = qaic_telemetry_mhi_remove,
+	.probe = qaic_telemetry_mhi_probe,
+	.ul_xfer_cb = qaic_telemetry_mhi_ul_xfer_cb,
+	.dl_xfer_cb = qaic_telemetry_mhi_dl_xfer_cb,
+	.driver = {
+		.name = "qaic_telemetry",
+	},
+};
+
+int qaic_telemetry_register(void)
+{
+	return mhi_driver_register(&qaic_telemetry_mhi_driver);
+}
+
+void qaic_telemetry_unregister(void)
+{
+	mhi_driver_unregister(&qaic_telemetry_mhi_driver);
+}
+
+void wake_all_telemetry(struct qaic_device *qdev)
+{
+	struct xfer_queue_elem *elem;
+	struct xfer_queue_elem *i;
+
+	mutex_lock(&qdev->tele_mutex);
+	list_for_each_entry_safe(elem, i, &qdev->tele_xfer_list, list) {
+		list_del_init(&elem->list);
+		complete_all(&elem->xfer_done);
+	}
+	qdev->tele_lost_buf = false;
+	mutex_unlock(&qdev->tele_mutex);
+}
+
+static int qaic_telemetry_pre(struct drm_ras_node *ep)
+{
+	struct qaic_device *qdev = ep->priv;
+	struct inode *dev_inode;
+	struct path path;
+	char devpath[24];
+	int ret;
+
+	snprintf(devpath, sizeof(devpath), "/dev/accel/%s", to_accel_kdev(qdev->qddev)->kobj.name);
+	scoped_with_init_fs()
+		ret = kern_path(devpath, LOOKUP_FOLLOW, &path);
+	if (ret)
+		return -EINVAL;
+
+	dev_inode = d_inode(path.dentry);
+	ret = inode_permission(&nop_mnt_idmap, dev_inode, MAY_READ | MAY_WRITE);
+	path_put(&path);
+
+	return ret;
+}
+
+static int qaic_telemetry_get(struct drm_ras_node *ep, u32 *field, s64 *value, s32 *status)
+{
+	struct qaic_device *qdev = ep->priv;
+
+	*status = (s32)telemetry_request(qdev, *field, TYPE_READ, value);
+
+	return *status;
+}
+
+static int qaic_telemetry_set(struct drm_ras_node *ep, u32 *field, s64 *value, s32 *status)
+{
+	struct qaic_device *qdev = ep->priv;
+
+	*status = (s32)telemetry_request(qdev, *field, TYPE_WRITE, value);
+
+	return *status;
+}
+
+int qaic_drm_ras_register_node(struct qaic_device *qdev)
+{
+	struct drm_ras_node *node;
+	struct pci_dev *pdev = qdev->pdev;
+	const char *device_name, *node_name;
+	int ret;
+
+	node = kzalloc_obj(struct drm_ras_node);
+	if (!node)
+		return -ENOMEM;
+
+	device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
+				pci_domain_nr(pdev->bus), pdev->bus->number,
+				PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!device_name) {
+		kfree(node);
+		return -ENOMEM;
+	}
+
+	node_name = kasprintf(GFP_KERNEL, "qaic_telemetry");
+	if (!node_name) {
+		kfree(device_name);
+		kfree(node);
+		return -ENOMEM;
+	}
+
+	node->device_name = device_name;
+	node->node_name = node_name;
+	node->type = DRM_RAS_NODE_TYPE_TELEMETRY;
+	node->priv = qdev;
+	node->telemetry_get = qaic_telemetry_get;
+	node->telemetry_set = qaic_telemetry_set;
+	node->telemetry_pre = qaic_telemetry_pre;
+	node->telemetry_fields_gettable = qaic_telemetry_fields_gettable;
+	node->telemetry_fields_settable = qaic_telemetry_fields_settable;
+
+	ret = drm_ras_node_register(node);
+	if (ret) {
+		kfree(device_name);
+		kfree(node_name);
+		kfree(node);
+		return ret;
+	}
+
+	qdev->ras_node = node;
+	return 0;
+}
+
+void qaic_drm_ras_unregister_node(struct qaic_device *qdev)
+{
+	drm_ras_node_unregister(qdev->ras_node);
+	kfree(qdev->ras_node->node_name);
+	kfree(qdev->ras_node->device_name);
+	kfree(qdev->ras_node);
+}
diff --git a/drivers/accel/qaic/qaic_telemetry.h b/drivers/accel/qaic/qaic_telemetry.h
new file mode 100644
index 000000000000..a80922591e37
--- /dev/null
+++ b/drivers/accel/qaic/qaic_telemetry.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* Copyright (c) 2020, The Linux Foundation. All rights reserved. */
+
+#ifndef __QAIC_TELEMETRY_H__
+#define __QAIC_TELEMETRY_H__
+
+#include "qaic.h"
+
+int telemetry_request(struct qaic_device *qdev, u8 cmd, u8 cmd_type, s64 *val);
+int qaic_drm_ras_register_node(struct qaic_device *qdev);
+void qaic_drm_ras_unregister_node(struct qaic_device *qdev);
+
+int qaic_telemetry_register(void);
+void qaic_telemetry_unregister(void);
+void wake_all_telemetry(struct qaic_device *qdev);
+
+#endif /* __QAIC_TELEMETRY_H__ */
diff --git a/include/uapi/drm/qaic_accel.h b/include/uapi/drm/qaic_accel.h
index c92d0309d583..5aac05101426 100644
--- a/include/uapi/drm/qaic_accel.h
+++ b/include/uapi/drm/qaic_accel.h
@@ -51,6 +51,34 @@ extern "C" {
 #define QAIC_TRANS_VALIDATE_PARTITION_FROM_DEV	19
 #define QAIC_TRANS_VALIDATE_PARTITION_TO_DEV	20
 
+/* Telemetry fields */
+#define QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP	1
+#define QAIC_DEVINFO_THERMAL_BOARD_TEMP		2
+#define QAIC_DEVINFO_THERMAL_BOARD_MAX_TEMP	3
+#define QAIC_DEVINFO_THERMAL_DDR_TEMP		4
+#define QAIC_DEVINFO_THERMAL_WARNING_TEMP	5
+#define QAIC_DEVINFO_THERMAL_SHUTDOWN_TEMP	6
+#define QAIC_DEVINFO_BOARD_TDP			7
+#define QAIC_DEVINFO_BOARD_POWER		8
+#define QAIC_DEVINFO_POWER_STATE		9
+#define QAIC_DEVINFO_POWER_MAX			10
+#define QAIC_DEVINFO_THROTTLE_PERCENT		11
+#define QAIC_DEVINFO_THROTTLE_TIME		12
+#define QAIC_DEVINFO_UPTIME			13
+#define QAIC_DEVINFO_THERMAL_SOC_FLOOR_TEMP	14
+#define QAIC_DEVINFO_THERMAL_SOC_CEILING_TEMP	15
+#define QAIC_DEVINFO_VOLTAGE_CX			16
+#define QAIC_DEVINFO_VOLTAGE_MX			17
+#define QAIC_DEVINFO_VOLTAGE_NSP_CX		18
+#define QAIC_DEVINFO_VOLTAGE_NSP_MX		19
+#define QAIC_DEVINFO_CFG_TOPS			20
+#define QAIC_DEVINFO_THERMAL_PMIC_TEMP_A	21
+#define QAIC_DEVINFO_THERMAL_PMIC_TEMP_C	22
+#define QAIC_DEVINFO_THERMAL_PMIC_TEMP_E	23
+#define QAIC_DEVINFO_POWER_ACTION		24
+#define QAIC_DEVINFO_SOC_TDP			25
+#define QAIC_DEVINFO_SOC_POWER			26
+
 /**
  * struct qaic_manage_trans_hdr - Header for a transaction in a manage message.
  * @type: In. Identifies this transaction. See QAIC_TRANS_* defines.
-- 
2.43.0

