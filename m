Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B4FCA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8F310E656;
	Mon, 12 Oct 2026 18:08:33 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F9E10E656
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEJO3Jq2cW/HDZWlmFkVJ0GlBnhVPGuuGus+2L9BtFoLwyk4XffDOIpDawugeOezGCxnm5DH4l6DnI6by60XDCOd2nv8fCjwT/CKLkvUXKkxbIlv1R9tXLHYAxRrDSefyCCQe+N3EYiGOs3vOOGUrKQ7W4UNHelQIEMaOObhsdFIUBep64C8d4MPcw6OK1V4wJVsE1aBj4q1glWMDtNpLl7HHM/kCXYoGzTVARQrJc4VtoDfGg39z+9sVAOOf7ScYXhrzzh3o5syRWGAspOZDVjco614na2kLnc7ejkSwdrZOovoSwgBMX8mIZJwNqthk5VrQSruhcnNlBFsg9FZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDZPliZLu16Pr4nGdKyynvulGsy/2Iu+j/vvG+eqCDY=;
 b=TNflixKVLGIWqECdYC+QQ2mZyuVd3j5LHlic8zC9jchK8hUSZvOj6BoKI9Y4THcuUnOrIar31x2fQkJzXVb+Yd1EktrKNhgLa4jeQ2oBst6ST6SuBQLNmS8VUvlzefgvldVIG395HFgEjk1iiiqfIDZraDRulsA4Rkt/VHaPIpkJDJRRKnvYxkQ8R0xjb33W0gRx2wEsWcFPK9ZCl7feiYWcD1SbEiByjOegychYph16sn+p9FSHMi82Owwg823cuZtMiWFQCumwG55dhhW27R/2zEGdK1+uDMh6fwIbP5iSZEvZ7guYA0tE55SJ9R5aYDX+skq/g1OLuAtNaaybTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDZPliZLu16Pr4nGdKyynvulGsy/2Iu+j/vvG+eqCDY=;
 b=seEoc3TBonZ+fcs5VMo4lpB5dLAfMVpsioakWPLuvOv0L6BESgsjMOz6wKNIo4QfeHRck5RfE5j0gLC5+RYFF7KvrxrjwkJb/8aGspyzG2jUoAR9UAj3N8vlGhHFeanFW6jn4GOG/Kil/sNHSWtEwrgEFF/fH+m4WwliB3BcGP4=
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 18:08:18 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::24) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 18:08:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 18:08:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 13:08:11 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 13:08:11 -0500
From: Max Zhen <max.zhen@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <lizhi.hou@amd.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Expose NPU device busy time via DRM fdinfo
Date: Mon, 12 Oct 2026 11:08:08 -0700
Message-ID: <20261012180808.2548697-1-max.zhen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a952bce-36c0-4a9f-96cd-08df288bcab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: E1GKTxy/MwTaLwAjctnW4RoShEmh9xqG9LmVucMFWT86egVGlvYXJFkdGSPK5rPzWy1iYBgkp5sIk7QtzS21Ai4popzQoGsxY68ZERZB55U64OEe0xVA9ygWsR2SV9BFzLOE6dqksaXJmQRGMQfoPHaAVGNXUK3SrjQ0oMJD0WC5iO59Ys+reexQRQ6qitzqTod7Ki6f2VD0oRVX3gRW0r0EAZLjLpcQDlYu/MxjWrG3rBW/BUTIcVyPt4Nxz6Daw7kUv8IFWcWvQFd7/ypjQGUgPPZsVGWToTrfA83iCc5WCYG4GjK+CTAFwU25sPMMJ6qfC35RuqEQN/GtH9gZKLkkGF7KBo3i8j5CgncBfRrUh24tPCMXLl2gHmDV6CQDUMe5/aDeMKv8YnvTjV2l5TzmeR88/i2lFD5qCO3N5ZiYByosInJZGZAUE/IJdwWzplBtcqh1FxbEKk6aNNPLwLk647fBGUDGNb/lp6K4P3aGSfQbTc8KnXeIqs8BTE0nfHzdrJDlC2ChWCugEewdiagp4OB4d34pqrUOao0kiBvkFZYzb6V2JGgcKNUzylmpo9UOIGbOsZ5tn18bHZJJ3wRKU8ANMB5k9oSbmP22qV2EMEwYOKCF5kkH2p/vWmb9eENxaHdF3ZF7wE9CNBIK9SAa5zB34ySg1XKkXdVej/9LIofVMwF2cC2kzGq4cO08rzDBaV8D06+5R+LxUKCNGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NBqrioBAAhgfZr4+3wGlSlMhFFT4G4DxsMWl3YmVZcWPmSr16sFYz9/Vni0nY/ZQAz5eDsv2sHzTHupf2PAHktWO3LgRmpUMP+av+niLg0pja1/dwGQez0MgH/ze5E93hPSVx/2iZ1fYeAkRCyjTYi5Y7mRw9Ap2PDG24dzRbcdGPGwjwlVQWjr2I7E1mpuWDSyB9+YtZP5vNlBOdT7n0ST/ScYDAP0MvgGUgssT/yFlZKoPPO5NtP+0Q+NW7jmDeSmBKB/Z4yZx34NujO2eeypLmd1xaFsEUNjdCc3CUYzQjpwFezj07Aw3AHOt/5a+G7tjdfh8VBO/LPkQAxFdr8O9NZgJL8BV59h9cUMflEYUr/JQJFYYLGNcrOp6byrefg1fut+u2ARDY85oM7BQ9sbCp8jK2qQI9UTyjSwmaRB+anjUiVIzO8xp06Vzxk5x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:08:17.5596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a952bce-36c0-4a9f-96cd-08df288bcab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

Expose NPU device engine busy time through DRM fdinfo to enable
standardized userspace monitoring and profiling.

Add support for reporting per-engine busy time in nanoseconds
via fdinfo using the "drm-engine-<driver-name>" key. The value
reflects the accumulated NPU device execution time for a given
process, allowing userspace tools to observe NPU device
utilization without driver-specific ioctls.

Signed-off-by: Max Zhen <max.zhen@amd.com>
---
 Documentation/accel/amdxdna/amdnpu.rst  |  1 +
 drivers/accel/amdxdna/aie.c             | 39 +++++++++++++++++++++++++
 drivers/accel/amdxdna/aie.h             |  4 +++
 drivers/accel/amdxdna/aie2_ctx.c        |  6 ++++
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  6 ++++
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  9 ++++++
 6 files changed, 65 insertions(+)

diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
index 064973bf4893..d72af1b51ccf 100644
--- a/Documentation/accel/amdxdna/amdnpu.rst
+++ b/Documentation/accel/amdxdna/amdnpu.rst
@@ -289,6 +289,7 @@ Example of the output showing the implemented key value pairs:
         drm-driver:	amdxdna_accel_driver
         drm-client-id:	3219
         drm-pdev:	0000:c5:00.1
+        drm-engine-npu: 14003870 ns
         amdxdna_accel_driver-heap-alloc:	60 KiB
         amdxdna_accel_driver-internal-alloc:	67588 KiB
         amdxdna_accel_driver-external-alloc:	0
diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
index dd6f36f222c7..bf8eb66baab8 100644
--- a/drivers/accel/amdxdna/aie.c
+++ b/drivers/accel/amdxdna/aie.c
@@ -118,6 +118,45 @@ void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
 	amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
 }
 
+void amdxdna_io_stats_job_start(struct amdxdna_client *client)
+{
+	int depth;
+
+	guard(spinlock)(&client->io_stats.lock);
+
+	depth = client->io_stats.job_depth++;
+	if (!depth)
+		client->io_stats.start_time = ktime_get_ns();
+}
+
+void amdxdna_io_stats_job_done(struct amdxdna_client *client)
+{
+	u64 busy_ns;
+	int depth;
+
+	guard(spinlock)(&client->io_stats.lock);
+
+	depth = --client->io_stats.job_depth;
+	if (!depth) {
+		busy_ns = ktime_get_ns() - client->io_stats.start_time;
+		client->io_stats.start_time = 0;
+		client->io_stats.busy_time += busy_ns;
+	}
+}
+
+u64 amdxdna_io_stats_busy_time_ns(struct amdxdna_client *client)
+{
+	u64 busy_ns;
+
+	guard(spinlock)(&client->io_stats.lock);
+
+	busy_ns = client->io_stats.busy_time;
+	if (client->io_stats.job_depth)
+		busy_ns += ktime_get_ns() - client->io_stats.start_time;
+
+	return busy_ns;
+}
+
 int amdxdna_get_metadata(struct aie_device *aie,
 			 struct amdxdna_client *client,
 			 struct amdxdna_drm_get_info *args)
diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
index 0483d582b7f8..1fc5ddfe696a 100644
--- a/drivers/accel/amdxdna/aie.h
+++ b/drivers/accel/amdxdna/aie.h
@@ -117,4 +117,8 @@ void aie_smu_fini(struct smu_device *smu);
 int aie_smu_set_clocks(struct smu_device *smu, u32 *npuclk, u32 *hclk);
 int aie_smu_set_dpm(struct smu_device *smu, u32 dpm_level);
 
+void amdxdna_io_stats_job_start(struct amdxdna_client *client);
+void amdxdna_io_stats_job_done(struct amdxdna_client *client);
+u64 amdxdna_io_stats_busy_time_ns(struct amdxdna_client *client);
+
 #endif /* _AIE_H_ */
diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index d927c8c9d557..9c6b7353cbe9 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -290,6 +290,7 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
 	int ret = 0;
 	u32 status;
 
+	amdxdna_io_stats_job_done(job->hwctx->client);
 	cmd_abo = job->cmd_bo;
 
 	if (unlikely(job->job_timeout)) {
@@ -322,6 +323,8 @@ aie2_sched_drvcmd_resp_handler(void *handle, void __iomem *data, size_t size)
 	struct amdxdna_sched_job *job = handle;
 	int ret = 0;
 
+	amdxdna_io_stats_job_done(job->hwctx->client);
+
 	if (unlikely(!data || size != sizeof(u32))) {
 		job->drv_cmd->result = U32_MAX;
 		ret = -EINVAL;
@@ -344,6 +347,7 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 	u32 cmd_status;
 	int ret = 0;
 
+	amdxdna_io_stats_job_done(job->hwctx->client);
 	cmd_abo = job->cmd_bo;
 
 	if (unlikely(job->job_timeout)) {
@@ -405,6 +409,7 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 	kref_get(&job->refcnt);
 	fence = dma_fence_get(job->fence);
 
+	amdxdna_io_stats_job_start(job->hwctx->client);
 	if (job->drv_cmd) {
 		switch (job->drv_cmd->opcode) {
 		case SYNC_DEBUG_BO:
@@ -432,6 +437,7 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
 
 out:
 	if (ret) {
+		amdxdna_io_stats_job_done(job->hwctx->client);
 		dma_fence_put(job->fence);
 		aie2_job_put(job);
 		mmput(job->mm);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index bb339e641416..67a02d6b7f97 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -14,6 +14,7 @@
 #include <linux/iommu.h>
 #include <linux/pci.h>
 
+#include "aie.h"
 #include "amdxdna_cbuf.h"
 #include "amdxdna_ctx.h"
 #include "amdxdna_debugfs.h"
@@ -151,6 +152,8 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 	filp->driver_priv = client;
 	client->filp = filp;
 
+	spin_lock_init(&client->io_stats.lock);
+
 	XDNA_DBG(xdna, "pid %d opened", client->pid);
 	return 0;
 
@@ -287,6 +290,9 @@ static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
 	size_t heap_usage, external_usage, internal_usage;
 	char *drv_name = filp->minor->dev->driver->name;
 
+	drm_printf(p, "drm-engine-npu:\t%llu ns\n",
+		   amdxdna_io_stats_busy_time_ns(client));
+
 	mutex_lock(&client->mm_lock);
 
 	heap_usage = client->heap_usage;
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index a997d27a504d..510356a31532 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -143,6 +143,13 @@ struct amdxdna_device_id {
 	const struct amdxdna_dev_info *dev_info;
 };
 
+struct amdxdna_io_stats {
+	spinlock_t			lock; /* protect io stats */
+	int				job_depth;
+	u64				start_time;
+	u64				busy_time;
+};
+
 /*
  * struct amdxdna_client - amdxdna client
  * A per fd data structure for managing context and other user process stuffs.
@@ -169,6 +176,8 @@ struct amdxdna_client {
 	size_t				heap_usage;
 	size_t				total_bo_usage;
 	size_t				total_int_bo_usage;
+
+	struct amdxdna_io_stats		io_stats;
 };
 
 #define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
-- 
2.34.1

