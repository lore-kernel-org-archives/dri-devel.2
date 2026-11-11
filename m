Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85C606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n3mBRAF3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0FD10F9C4;
	Wed, 11 Nov 2026 08:56:03 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4CB10F9A3;
 Wed, 11 Nov 2026 08:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDa+Oif6Of+XK1CbTSL/d/fpnxj7Utjrhu/fVVoI6qOWAMF672OKlohl+brxjL8MzVeLuxyRDHmUmzKmL3FS+JFCthQQA9xFeT9NwYElhmb9B9uOzGtYn5wS2FDk4mk+vZzjRqcxaMnCiMhuap154nu0fX4dJ37CACYsTi13Wvd3eo8ucm1Vshs47gMIDeSDw63zFmsVLtjTguvamF+0/BNyJ7T98av2XFyQqQAaDqZbI//6Zl61Uh3rgTghN/JBerNVEktGgkUHqbP6CRU+8qbL0E7A5QdZM2RW1YKI4caQ2xG5EBwv09O6OqlCGgSeIQGXoWymQ6LiMTvCUNFNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5SOfZItCOPb3SMC030qP0U5bz9VvLd3BMG0lWmMn/w=;
 b=BgN1nyTZlUmeg2Hsmbg2QTb2W1CYVc9TvzpZpAit/zf0eGsoF3qM2e7UxNJb4QxM30FmVc4npVRkbfT2EogviS8Rapw/LQ5O9TKS2BjssK+N3hHTto9HwTWYy0lYNnTfLMnWI0i+8Ipfh416uRtOfprcv4ahHGD+F5+8x3kqcJLYqjwAf8N3z6w9jPV2M6d3E4b+7fUxefux/BDhO/GXwnH5SWNDL/dv04BAQPrz57bgW6iFOZpEGOGx0kZgKUMBRVpTTY3nQxnzR2s44bZjaoPNKIE8r0ddLmQgjNBidOmCYetP1ZOGO2lg61nZzcKiX2lZ6UHehPCiJGb+LLvJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5SOfZItCOPb3SMC030qP0U5bz9VvLd3BMG0lWmMn/w=;
 b=n3mBRAF3XRSdpLzxxnT0oifBcjCzFKhqYRYI+0fxuvPElFkUMOC+WPrf/Z3t4e4Ld7RF5vsNpt2SWAyWHFHM17xEGV47t3v/t6E270neXGjERHlw4Dp87Cnsn5o9bOoBq8oYVyBb0LL9ZL77eV7jYoKzG9D8c1YPC6/HscTNmmc=
Received: from DS1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::11) by
 MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 08:55:47 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::22) by DS1P222CA0011.outlook.office365.com
 (2603:10b6:8:454::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 08:55:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:55:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:55:43 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>
Subject: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
 interruptible
Date: Wed, 11 Nov 2026 16:55:30 +0800
Message-ID: <20261111085534.514957-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 777e8ccf-9a51-4581-fc65-08df3fd19385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261022115727099003|261022105027099003|261022075727099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info: uArOrXS6hxONZXpOY6osPytcorVVBe4Gx50ELVJomFpR/i0k4i865vwkv4ot5b0iZIP78X1J1+aPa8QTmBn85D4ImOrWNjj4n5X1OyKkYrIRI2ULw7M2oVwVkRDcdjB+neksdYX2M+ywxq3piFBvcf5FmKkTryGsyXYqZS5L6q2lUl7x1mb09JNzrSFRXEk7TVeIG5Sl2nDdZkjY1pxg5GEPn6FdFCd9VKpCtlKrjGM+jqpevkC3Jo5p1IGCq+M8sdEMmwE7SIdCsjgjqozFqxmiPmjaEmoPBsHFCiIvgQUS2r0+SZgrTOAd7ZUqHmgcx72UB8HLBZWQGe3hsZivHG7SkiYJnm+t2CQlb4tUI1L8fIvH4iuE2pYNFAITbzkH1AJFK/v7NjZCUzn8iiJpkvZ9+HtN2/F/2uD0+qzWUsve03ZQixDyJgzQWakhBYytIZQ6gyfeWu1Asttt0lMC7taAXhqQ37oVecDI6L4CbnQeZfB2bSbaU+Lng8TuBo0Bd8hfuuQMejD4n6neR6iaTQX4gm/631IpoBEdLjxomWVto25jm95PIpxCYNDBZjPUEEizXxY2wZ0jbx1wpQXDMsDMUGx194uKSU66cdHA+LpkyFK8Ljnz/EtMH5Ua2rARJBkuEqjxRQgl4TxbvKQ3VNH9ucn8tBMxWsm9lNDV0B0dWMj3Fbnokv5bZwOlHjOUDdjy0y+CyKHZUS1Ani+IGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LSRD1zlrGZGIITouQGYVNiZGrsr7CLEoOYTQB+5D9M5HOUJYl3funjRFS+89GxPyBtgbdkUv9iZmM4/Fi6U19lOH+s4d3VqiaqXKJSygcUf0svdiOkeishuGtSOKfdYhlY9aeqpfuF3UsFgyuXqRxCmQCj+RL3Zj/uDqEZgeTkM923Orobom8rzGlLlfxqhVtARAWuAhqZwm81aR1slZB6ikDUXB1c2eyNNINytivZusxeezuLmT+aanWzWXNO1eTkXdFGrZdtUkdOxEohXNDtGmgFir2jbiBOs1aC6bgo8uC9pgPFLgEzgYTC1/WUvX8POqWF42CFb9d3v/vN1Z0mvBtAr+nVtAhgJVuehGt3hIC6DHbX296EjwPTXee/p9/JHBR548KE9Gf0sli0P+MaSEusW6S4zDPujjUyjQw9KvVaZxH8+l7YGdTEy6otcl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:55:46.4821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777e8ccf-9a51-4581-fc65-08df3fd19385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FBIO_WAITFORVSYNC calls drm_client_modeset_wait_for_vblank(), which
waits with drm_crtc_wait_one_vblank(). That wait is uninterruptible and
only gives up after one second. If no vblank interrupt arrives, for
example while the driver resets the display hardware, the caller sleeps
in D state for the whole second and can't be interrupted, not even by
SIGKILL.

DRM_IOCTL_WAIT_VBLANK waits interruptibly, and so do fbdev drivers that
implement FBIO_WAITFORVSYNC themselves, such as atyfb and matroxfb.

Add drm_crtc_wait_one_vblank_interruptible(), a DRM-internal variant of
drm_crtc_wait_one_vblank() that a signal can interrupt, and use it in
drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a signal
interrupts the wait, so that the ioctl returns to userspace or is
restarted. Timeouts and disabled CRTCs are still not reported.

The fbdev damage worker also calls drm_client_modeset_wait_for_vblank(),
but it runs in a kernel thread, which doesn't receive signals, so its
wait doesn't change. Drivers keep using drm_crtc_wait_one_vblank().

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/drm_client_modeset.c | 10 +++--
 drivers/gpu/drm/drm_internal.h       |  1 +
 drivers/gpu/drm/drm_vblank.c         | 60 ++++++++++++++++++++--------
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 0080a8e9556a..b475b8dbdb17 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -1301,10 +1301,11 @@ EXPORT_SYMBOL(drm_client_modeset_dpms);
  *
  * Block the caller until the given CRTC has seen a VBLANK. Do nothing
  * if the CRTC is disabled. If there's another DRM master present, fail
- * with -EBUSY.
+ * with -EBUSY. A signal interrupts the wait.
  *
  * Returns:
- * 0 on success, or negative error code otherwise.
+ * 0 on success, -ERESTARTSYS if a signal interrupted the wait, or
+ * negative error code otherwise.
  */
 int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned int crtc_index)
 {
@@ -1328,13 +1329,14 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
 	 */
 	ret = drm_crtc_vblank_get(crtc);
 	if (!ret) {
-		drm_crtc_wait_one_vblank(crtc);
+		ret = drm_crtc_wait_one_vblank_interruptible(crtc);
 		drm_crtc_vblank_put(crtc);
 	}
 
 	drm_master_internal_release(dev);
 
-	return 0;
+	/* Only report interruption by a signal, not timeouts. */
+	return ret == -ERESTARTSYS ? ret : 0;
 }
 EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);
 
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index f893b1e3a596..2be21c20eb78 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -115,6 +115,7 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
 int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
 void drm_vblank_put(struct drm_device *dev, unsigned int pipe);
 u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe);
+int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc);
 
 /* drm_vblank_work.c */
 static inline void drm_vblank_flush_worker(struct drm_vblank_crtc *vblank)
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..c3c9afc08ed2 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1297,21 +1297,12 @@ void drm_crtc_vblank_put(struct drm_crtc *crtc)
 }
 EXPORT_SYMBOL(drm_crtc_vblank_put);
 
-/**
- * drm_crtc_wait_one_vblank - wait for one vblank
- * @crtc: DRM crtc
- *
- * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
- * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
- * due to lack of driver support or because the crtc is off.
- *
- * Returns: 0 on success, negative error on failures.
- */
-int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
+static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool interruptible)
 {
 	struct drm_device *dev = crtc->dev;
 	int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
+	long timeout = msecs_to_jiffies(1000);
 	int ret;
 	u64 last;
 
@@ -1322,18 +1313,55 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
 
 	last = drm_vblank_count(dev, pipe);
 
-	ret = wait_event_timeout(vblank->queue,
-				 last != drm_vblank_count(dev, pipe),
-				 msecs_to_jiffies(1000));
+	if (interruptible)
+		timeout = wait_event_interruptible_timeout(vblank->queue,
+							   last != drm_vblank_count(dev, pipe),
+							   timeout);
+	else
+		timeout = wait_event_timeout(vblank->queue,
+					     last != drm_vblank_count(dev, pipe),
+					     timeout);
 
-	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
+	drm_WARN(dev, timeout == 0, "vblank wait timed out on crtc %i\n", pipe);
 
 	drm_vblank_put(dev, pipe);
 
-	return ret ? 0 : -ETIMEDOUT;
+	if (timeout < 0)
+		return timeout;
+
+	return timeout ? 0 : -ETIMEDOUT;
+}
+
+/**
+ * drm_crtc_wait_one_vblank - wait for one vblank
+ * @crtc: DRM crtc
+ *
+ * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
+ * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
+ * due to lack of driver support or because the crtc is off.
+ *
+ * Returns: 0 on success, negative error on failures.
+ */
+int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
+{
+	return __drm_crtc_wait_one_vblank(crtc, false);
 }
 EXPORT_SYMBOL(drm_crtc_wait_one_vblank);
 
+/**
+ * drm_crtc_wait_one_vblank_interruptible - wait for one vblank, interruptibly
+ * @crtc: DRM crtc
+ *
+ * Like drm_crtc_wait_one_vblank(), but a signal interrupts the wait.
+ *
+ * Returns: 0 on success, -ERESTARTSYS if a signal interrupted the wait,
+ * negative error on other failures.
+ */
+int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc)
+{
+	return __drm_crtc_wait_one_vblank(crtc, true);
+}
+
 /**
  * drm_crtc_vblank_off - disable vblank events on a CRTC
  * @crtc: CRTC in question
-- 
2.34.1

