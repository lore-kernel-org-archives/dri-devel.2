Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D8CA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85AB10EF87;
	Tue,  6 Oct 2026 04:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OYhzT/Xg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E40C10EF86
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6RXyG58ocd80jZk0u6TQrOBTCHo4rVBNeei7kJTPg2/ThV1FX44CsIFO3GBQN7SNtTrMezi1oDLDkkYiHifaoZsFQXvV8DVURrNe7vk9tJiK4Iy9r1uSU8N7cp9/vt+NW1HLK4TevVf6os+F5Dy8p/yHLwRnN7ijw8b8cXWG1m6oRfBuWiUNXybDZmj2g5y65+OedlJV4SWpUjOVoqpbt2emFBjFGcxsWYAxCPxzG+mVA6g9Y1qOZf9uQYwHu0qBP7AdEOGtv02vm/9leYiacis5I5eqAVOJieBUIhu8fA6iBQIuA1sftVmglIiQrNzYfsxcCvy8apr7hpF8N4UHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei5uD8vsqe5jx9R36t0RnFcO1cqa8aTdVgDWsr2To0g=;
 b=ADA2WyhrRAncmdTwDrt1/5Vr73DDr5PJkjZAd0pyxn+A5WV1bC4pOlfHz0hK3dCYUBIDmvgzreZJFFWrbwgsdKobgGBrrG9ZxbOWrXbJLs+mM3nosV3bhl+rZXZEJ0HDAAbALEjLiiX9DuFim8MGSkkZKV4bJd1IBRsi9PSqCLAqIPxqNUc/gbrUED2m+ROxAoCESp2k9QrQ06bqiR5RtyHM1h00sJks3iUA1ba/0hzz2Em5l5bpKlkiqTdltJg29JN1uFI2Hymdjo5buMiMuKcAn20XrGMLNdmLNMVdaKiusnyLPC133vgLKSArrZMFvh8uX87h7dx9UMVtvCn8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei5uD8vsqe5jx9R36t0RnFcO1cqa8aTdVgDWsr2To0g=;
 b=OYhzT/XgxkD3S8j0pd95YGgcPTWvntdZKQ3BQtHKJSFhQHN6s4JSwYxwqYWMD25SATlG1v5f54O7EyuELy5uPkejg0YBa41fPRtAPxD9plPd3Ra8A/SPdTews5IatGBg1D5teR69dDdWwfMRgUoEK6SHty/9+ygOCSW7lHJ5Sxk=
Received: from CH0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:610:33::20)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 04:23:03 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::58) by CH0PR08CA0015.outlook.office365.com
 (2603:10b6:610:33::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 04:23:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 04:23:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 23:23:01 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Mon, 5 Oct 2026 23:23:01 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V2 19/20] accel/amdxdna: Implement runtime suspend and resume
 support
Date: Mon, 5 Oct 2026 21:22:29 -0700
Message-ID: <20261006042230.547807-20-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006042230.547807-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7f0560-be1a-49f2-2bf6-08df2361836d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|6133799003|22082099003|10067099003|18002099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ptlztFHxq13Bcu2fDZBy36gQROITo+uGoL955Md465uu/jItyVanQILd+7ZiOgmHE7Sg+y6wOs61MT1X7c0sodSS+fKJCnTNmfGMOMqQn185diC/d9I2Lm8E43sXq1fes7n3lb1IOACNOPBE/OS/2LOeokv58ZzYXNvU1kRYmjIPBcJZw3G+cj4nYMrlZBmk2lBcymEXwrm00FoE54++MgAZiXQ081YwWc0wmrk21TgQvEAzY5BKWMyC6XTmijfShKlGuXh/zWOJFsrExsuJ5wnu7HbVO47OAc85IEYs4i/HT+j+GT0oaJ4xNh7v2RWd5weV5M9rk9MD8/i28MU1fYpZdvykJqzPum79GXwID7Gzmw9qXBzYW8+kmtjAGgpOsvgk4T0NZZ8rAEbf48byXLLsCTJAKTpfHwLcO8QYOdR+Q6cd1GC9ewXxyWsHNOVU2obzXc9A8MUyxCOxH6Fs//6JEJVwvIc7NJUPidDQ6O/fQZuRHhr0ZE7X08rX9xDM7X8RTt6AfN0K2S7ghjU4mlYZiKyABpcEfGEuspIA9FZ7d4dle0SktxsMpy3oFfhQtO8QINp2pQtwPRV0MQc6MZAnQmSDlCwpahQwz9u7Kn0Gv6tNE1HpiZHSGzLCmKqLh0TgQDLFJfoHKGMf3z3XXezQIt1KRB2ws9ibq6gH4Jhx3C8cixwkYf2SkK3eMj9v5jqyzQyMUn5QS8l53Fa9Aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WhGe1boFZD1fbneW+eUT3KizGZYp3HBBkCk5kSt8NQ/QOLrUUApj/pQlbvt9Pdl+jpfuibzrw1XOZ4mRF27eYUjDRR1/+P1Ai6n9MZLB5HtiuknmteItCwu5As5iD3lUSnSl+BnA87d8VgkhXbZmtbVyi8Na+PlkyUoCfFaYCSSXy8Lro4Jcmx2FBoTRtj/VTzzdQ7S3caPwJwmUMFzoQ+NxcP5v/DqwGCwlPswqt5DhX2JtejXfFwLmb1ZGYZSclJh2U3Y8S8Zpm7d/BcU2XjgZE2ug+qy6D+1wziWFuVNAXHsbOREf7F7u51aJcJTsZSCrGcBmGlNDN6XAoPNDdohnGEmxMmOIgXEDrSXbS9pSDOSULqqHTprnvsfX0HyJwLt3R8h6ISNzcon/o2tSdKwzPV+5rW6YZaTRhKEgAwXtRExjgUS74HcuWeVEvmf/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:23:03.3274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7f0560-be1a-49f2-2bf6-08df2361836d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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

Add runtime suspend/resume for AIE4 driver.

Wake and acquire an RPM reference across amdxdna_sriov_configure() so
that SR-IOV management commands execute with the device active.

Update amdxdna_pm.c to implement amdxdna_pm_runtime_suspend() and
amdxdna_pm_runtime_resume().

Wrap .driver.pm with pm_ptr() to allow the dev_pm_ops structure and
its callbacks to be discarded as dead code when CONFIG_PM is disabled.

Detect passthrough VFs by comparing the VF driver with the PF driver,
since drv->owner is NULL for built-in drivers.

Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/aie2_pci.c        |  2 ++
 drivers/accel/amdxdna/aie4_pci.c        | 31 +++++++++++++++++++
 drivers/accel/amdxdna/aie4_pci.h        |  8 +++++
 drivers/accel/amdxdna/aie4_sriov.c      | 41 +++++++++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 17 +++++++---
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  2 ++
 drivers/accel/amdxdna/amdxdna_pm.c      | 34 ++++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_pm.h      |  4 ++-
 8 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index bee3d973e6bc..d8b1aa3e0bef 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -1207,6 +1207,8 @@ const struct amdxdna_dev_ops aie2_ops = {
 	.fini = aie2_fini,
 	.resume = aie2_hw_resume,
 	.suspend = aie2_hw_suspend,
+	.runtime_resume = aie2_hw_resume,
+	.runtime_suspend = aie2_hw_suspend,
 	.get_aie_info = aie2_get_info,
 	.set_aie_state = aie2_set_state,
 	.hwctx_init = aie2_hwctx_init,
diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
index f7fa55c82baa..c395052eb6fd 100644
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
@@ -1162,6 +1162,17 @@ static int aie4_pf_suspend(struct amdxdna_dev *xdna)
 	return 0;
 }
 
+static int aie4_pf_runtime_suspend(struct amdxdna_dev *xdna)
+{
+	int ret;
+
+	ret = aie4_vfs_alive(xdna);
+	if (ret)
+		return ret;
+
+	return aie4_pf_suspend(xdna);
+}
+
 static int aie4_pf_resume(struct amdxdna_dev *xdna)
 {
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
@@ -1214,6 +1225,20 @@ static int aie4_vf_suspend(struct amdxdna_dev *xdna)
 	return 0;
 }
 
+static int aie4_vf_runtime_suspend(struct amdxdna_dev *xdna)
+{
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
+	struct pci_dev *pdev = to_pci_dev(xdna->ddev.dev);
+
+	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
+	aie4_hwctx_suspend_all(ndev, false);
+	aie4_vf_hw_stop(ndev);
+	pci_disable_device(pdev);
+
+	XDNA_DBG(xdna, "vf runtime suspend done");
+	return 0;
+}
+
 static int aie4_vf_resume(struct amdxdna_dev *xdna)
 {
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
@@ -1314,6 +1339,8 @@ const struct amdxdna_dev_ops aie4_pf_ops = {
 	.sriov_configure        = aie4_sriov_configure,
 	.resume			= aie4_pf_resume,
 	.suspend		= aie4_pf_suspend,
+	.runtime_resume		= aie4_pf_resume,
+	.runtime_suspend	= aie4_pf_runtime_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_vf_ops = {
@@ -1330,6 +1357,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
 	.set_aie_state		= aie4_set_state,
 	.resume			= aie4_vf_resume,
 	.suspend		= aie4_vf_suspend,
+	.runtime_resume		= aie4_vf_resume,
+	.runtime_suspend	= aie4_vf_runtime_suspend,
 };
 
 const struct amdxdna_dev_ops aie4_classic_ops = {
@@ -1346,4 +1375,6 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
 	.set_aie_state		= aie4_set_state,
 	.resume			= aie4_classic_resume,
 	.suspend		= aie4_classic_suspend,
+	.runtime_resume		= aie4_classic_resume,
+	.runtime_suspend	= aie4_classic_suspend,
 };
diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
index 011d2f4f0b68..a03c39457ab8 100644
--- a/drivers/accel/amdxdna/aie4_pci.h
+++ b/drivers/accel/amdxdna/aie4_pci.h
@@ -180,16 +180,24 @@ void aie4_free_notification(struct cert_comp *comp);
 int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs);
 int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
 int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev);
+int aie4_vfs_alive(struct amdxdna_dev *xdna);
 #else
 static inline int aie4_create_vfs(struct amdxdna_dev_hdl *ndev, int num_vfs)
 {
 	return 0;
 }
+
 #define aie4_sriov_configure NULL
+
 static inline int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)
 {
 	return 0;
 }
+
+static inline int aie4_vfs_alive(struct amdxdna_dev *xdna)
+{
+	return 0;
+}
 #endif
 
 extern const struct amdxdna_dev_ops aie4_pf_ops;
diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/aie4_sriov.c
index 3cad0526087d..c89bb033bb16 100644
--- a/drivers/accel/amdxdna/aie4_sriov.c
+++ b/drivers/accel/amdxdna/aie4_sriov.c
@@ -6,6 +6,7 @@
 #include <drm/amdxdna_accel.h>
 #include <drm/drm_print.h>
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 
 #include "aie.h"
 #include "aie4_msg_priv.h"
@@ -119,6 +120,46 @@ static int aie4_link_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
 	return 0;
 }
 
+/* Check if a VF is actively running workloads or in passthrough. */
+static int aie4_check_vf_alive(struct amdxdna_dev *xdna, struct pci_dev *pdev_vf)
+{
+	struct device *pf_dev = xdna->ddev.dev;
+	struct device_driver *drv;
+	bool busy = false;
+
+	if (!device_trylock(&pdev_vf->dev)) {
+		XDNA_WARN(xdna, "VF:%s is busy (locked)", pci_name(pdev_vf));
+		return -EBUSY;
+	}
+
+	drv = pdev_vf->dev.driver;
+	if (!drv) {
+		device_unlock(&pdev_vf->dev);
+		return 0;
+	}
+
+	/* VF bound to a driver other than the PF's (amdxdna) is passthrough. */
+	if (drv != pf_dev->driver) {
+		XDNA_WARN(xdna, "VF:%s is in passthrough", pci_name(pdev_vf));
+		busy = true;
+	} else if (!pm_runtime_suspended(&pdev_vf->dev)) {
+		XDNA_WARN(xdna, "VF:%s is busy", pci_name(pdev_vf));
+		busy = true;
+	}
+
+	device_unlock(&pdev_vf->dev);
+	return busy ? -EBUSY : 0;
+}
+
+int aie4_vfs_alive(struct amdxdna_dev *xdna)
+{
+	if (pci_vfs_assigned(to_pci_dev(xdna->ddev.dev))) {
+		XDNA_WARN(xdna, "VF devices are being used in VMs, cannot suspend");
+		return -EBUSY;
+	}
+	return aie4_for_each_vfs(xdna, aie4_check_vf_alive);
+}
+
 static int aie4_link_vfs(struct amdxdna_dev *xdna)
 {
 	return aie4_for_each_vfs(xdna, aie4_link_vf);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 8faf651fb534..57985ebee0ac 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -469,18 +469,27 @@ static void amdxdna_remove(struct pci_dev *pdev)
 
 static const struct dev_pm_ops amdxdna_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume)
-	RUNTIME_PM_OPS(amdxdna_pm_suspend, amdxdna_pm_resume, NULL)
+	RUNTIME_PM_OPS(amdxdna_pm_runtime_suspend, amdxdna_pm_runtime_resume, NULL)
 };
 
 static int amdxdna_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	struct amdxdna_dev *xdna = pci_get_drvdata(pdev);
+	int ret;
 
 	guard(mutex)(&xdna->dev_lock);
+
+	ret = amdxdna_pm_resume_get_locked(xdna);
+	if (ret)
+		return ret;
+
 	if (xdna->dev_info->ops->sriov_configure)
-		return xdna->dev_info->ops->sriov_configure(xdna, num_vfs);
+		ret = xdna->dev_info->ops->sriov_configure(xdna, num_vfs);
+	else
+		ret = -EOPNOTSUPP;
 
-	return -ENOENT;
+	amdxdna_pm_suspend_put(xdna);
+	return ret;
 }
 
 static struct pci_driver amdxdna_pci_driver = {
@@ -488,7 +497,7 @@ static struct pci_driver amdxdna_pci_driver = {
 	.id_table = pci_ids,
 	.probe = amdxdna_probe,
 	.remove = amdxdna_remove,
-	.driver.pm = &amdxdna_pm_ops,
+	.driver.pm = pm_ptr(&amdxdna_pm_ops),
 	.sriov_configure = amdxdna_sriov_configure,
 };
 
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index fde48ef0ca6c..f669f6a6cc4c 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -57,6 +57,8 @@ struct amdxdna_dev_ops {
 	void (*debugfs_init)(struct amdxdna_dev *xdna);
 	int (*resume)(struct amdxdna_dev *xdna);
 	int (*suspend)(struct amdxdna_dev *xdna);
+	int (*runtime_resume)(struct amdxdna_dev *xdna);
+	int (*runtime_suspend)(struct amdxdna_dev *xdna);
 	int (*sriov_configure)(struct amdxdna_dev *xdna, int num_vfs);
 	int (*hwctx_init)(struct amdxdna_hwctx *hwctx);
 	void (*hwctx_stop)(struct amdxdna_hwctx *hwctx);
diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/amdxdna_pm.c
index 9c030b7836fb..2b4ce301bb96 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.c
+++ b/drivers/accel/amdxdna/amdxdna_pm.c
@@ -37,11 +37,40 @@ int amdxdna_pm_resume(struct device *dev)
 	return ret;
 }
 
+int amdxdna_pm_runtime_suspend(struct device *dev)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
+	int ret = -EOPNOTSUPP;
+
+	guard(mutex)(&xdna->dev_lock);
+	if (xdna->dev_info->ops->runtime_suspend)
+		ret = xdna->dev_info->ops->runtime_suspend(xdna);
+
+	XDNA_DBG(xdna, "Runtime suspend done ret %d", ret);
+	return ret;
+}
+
+int amdxdna_pm_runtime_resume(struct device *dev)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev_get_drvdata(dev));
+	int ret = -EOPNOTSUPP;
+
+	guard(mutex)(&xdna->dev_lock);
+	if (xdna->dev_info->ops->runtime_resume)
+		ret = xdna->dev_info->ops->runtime_resume(xdna);
+
+	XDNA_DBG(xdna, "Runtime resume done ret %d", ret);
+	return ret;
+}
+
 int amdxdna_pm_resume_get(struct amdxdna_dev *xdna)
 {
 	struct device *dev = xdna->ddev.dev;
 	int ret;
 
+	if (!pm_runtime_enabled(dev))
+		return 0;
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		XDNA_ERR(xdna, "Resume failed: %d", ret);
@@ -55,6 +84,10 @@ void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna)
 {
 	struct device *dev = xdna->ddev.dev;
 
+	if (!pm_runtime_enabled(dev))
+		return;
+
+	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
 
@@ -66,6 +99,7 @@ void amdxdna_pm_init(struct amdxdna_dev *xdna)
 	pm_runtime_set_autosuspend_delay(dev, AMDXDNA_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_allow(dev);
+	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
 
diff --git a/drivers/accel/amdxdna/amdxdna_pm.h b/drivers/accel/amdxdna/amdxdna_pm.h
index 3d26b973e0e3..26df3d50d8ea 100644
--- a/drivers/accel/amdxdna/amdxdna_pm.h
+++ b/drivers/accel/amdxdna/amdxdna_pm.h
@@ -9,7 +9,9 @@
 #include "amdxdna_pci_drv.h"
 
 int amdxdna_pm_suspend(struct device *dev);
-int amdxdna_pm_resume(struct device  *dev);
+int amdxdna_pm_resume(struct device *dev);
+int amdxdna_pm_runtime_suspend(struct device *dev);
+int amdxdna_pm_runtime_resume(struct device *dev);
 int amdxdna_pm_resume_get(struct amdxdna_dev *xdna);
 void amdxdna_pm_suspend_put(struct amdxdna_dev *xdna);
 void amdxdna_pm_init(struct amdxdna_dev *xdna);
-- 
2.34.1

