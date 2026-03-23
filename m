Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B860FF483FB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A0B10E486;
	Mon, 23 Mar 2026 20:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vzi+42j+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010068.outbound.protection.outlook.com
 [52.101.193.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDD710E47A;
 Mon, 23 Mar 2026 20:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g130KaLH/LYSXirmmhkFs3C5tRku3X0yf7kIqZdoHqS0eg2F2u5akhS1RlLJ+Sc7uNWQtAndNLZbn9YfTZtDoqMbXMjc52E4/QI7Pj+gaG7ngSMwXyAGfLRTPYwNgLFZPb/LyNqwg7O7y2v+K21rhkivq6Ep1Fs9dOXwUTnF4PsgofnnETqRiqt3w6vT6GpaWZHOKGyejMNOfFSsaiFNB6b4Q2OIeiii0s2AUIIpySkkGM+GkhV28X0ImoZOFRPoZQf8e1r4n48IAmz2l5bTsGR0yQ4MMtQEK0Bju3wQy4SF9oKbl/bQXacM5m9Q3kUSzHTYxsN0+BSHaNdS/ige8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/238w9NEcxz7SbrST1FDVfOi9bANGNn3CEMIDE7BXrE=;
 b=LoxsLXrROF6T8rwrQjkghY5eI9RihWUJXct0QXY/cnnPYCp10dS2D5C3mwGRH/r1kd6lsQNvfdo6oSv5iwDNyBXRlxfrutui2JFN30eEnJeluAgOpu3n7JNLmYxW3Gnyoyw0CPryMY5baB6yr/2jTH5dhDZ2sXtVhjRpiJkxrGf/f1IYBpDl6VXgZEJkm4QfHlUwSyebAcRtosCB7l7pVKSd0XsHJgmnEZFBXTgc2QQcMw4Zaz+q2ma8ICRMpUmaJ9q5Yz7p2Tip67qjhktHzyM2p8vtzEvBMDt1Lqlm4FsDQCxxQ9er7Y5g1qdU2rZr7ugc3KJUUaLm0VsSHLaoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/238w9NEcxz7SbrST1FDVfOi9bANGNn3CEMIDE7BXrE=;
 b=Vzi+42j+vAztaJRyT5WmbbFkQ/R8ztCawkVSsprI2iKk/8OaPDWN24FB4bpM8J00XnaVxjSnqTCgvwCc3zZ+V97ehVXri1SiXEUkH4FXHtVHPrHU1//o3qk3HUVUOU2KCfEIfI9AvRBJ9sNidqMM+PWfJEFYFeHZkvtypo3psO8=
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 20:30:13 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::ef) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:30:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 15:30:11 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Mon, 23 Mar 2026 15:30:10 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <simona@ffwll.ch>, <airlied@gmail.com>,
 <jani.nikula@linux.intel.com>, <ville.syrjala@linux.intel.com>,
 <superm1@kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 2/5] drm/vblank: Introduce deferred vblank enable/disable
Date: Mon, 23 Mar 2026 16:27:52 -0400
Message-ID: <20260323202755.315929-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323202755.315929-1-sunpeng.li@amd.com>
References: <20260323202755.315929-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ae5f3f-3a0e-4713-3ffa-08de891afc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: grmb8Zwi6en651xi/pK+touf0b9n51W66qpxVIOgFnX/V9oPhbwj0875WtjLbq69I7iK9lxd1CGnJ0oKCdTZlQz7AQvI89ZKyka1cKke0yMy9rZV34KThUspGf2G4rcH3s/1dViMj4fL7xk/5HYPxmga3OGbQE7P8/AlUVBL6bhhhmEPwT1rgKLKFos1eDovhq2w4mahHds+ybl+mxEQy/lVHAp3okDhbOq0tQu3bQzEtqqopdlebU97B11X2Iv55zUd444Z+RU1+eSvBCutM+t0M7nI7i7YHKv4wXgfa4OBEMuHJxXfLhgLtNAlAryZgLYtt9zS5+C2my2U1vg26ffl2p9gi9d+GU9WDzljrPXhixsKHiPq6652eb1lOU+wzVSzBAft2GPSQor09hal1Qpx2BURzOf35api4lLCZzIVYlJYcKt09VX99ykj/3En1lX55am7ZZIKVNAI1kroW6BKqcKrWe89Xhc3J5Ew8nM+CZMlOktiaSKz3J+gW8e1jLy1PzdgkVnoQs9M0SIXQTJiwQq3AoETUTWW/I7aj1+WgIj5qoptKWaU3P1/HWhbpz1fy7sHyTLISiF+1NACWqGPzWvqbatg4ROtdkRhzrzzDmccYULmn031iwYGpjG3iQQ10j8rn1XW9jgplxvApQA08OhgJfe5x47w6cXyUk5saqn+JJBbvslWLlxMLPOLBuTbrx973RV8bF9zp/4Jk0O1W1+auwGVFR8TQSGMl9C3+uU88kutN3iG6XIApi4KIHknWYVkoFXJL3MXUKV79w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QOViFJ9LyMgaQV/wgbmgQwcBMqo+2OGmZKT/lQPU9aBTWcb7V/pwfJjuaIj11RQH+H8SCaOskpQGWpj2Q6SlYrUvtNw+FeC6vVU30nArcA9L9g+8g+86ANKrsfnZh7mPKf/e2qiaipR/iCxYsLCbCnlUeuAnwY19GeZTM7PXCZiBY1K6maFtPlclIcOM/B2ubbQv5PFw65q1xCsBvefI4Fe56VjMABkAtAUNlhArpNo3k1Zx0dC0R2hp2IUp2ja7XN/V+sFPficrLWo25dNcani7XVcAClXoyWtOz8rnjai3VxsDyx+f2OEcEryUPmaSupd/wqFLQ86hEo+SVYYSYe4eFuAf4GSZ0dAig2wP60zRSyJUqWxt5iVK5pZfPdbYHbx8WtPkggfKhIKohsc780JzpGqzTSyP4adJbWEdMmJYbVPluz7qkhSvKpWDWIwx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:30:12.9469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae5f3f-3a0e-4713-3ffa-08de891afc66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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

From: Leo Li <sunpeng.li@amd.com>

Some drivers need to do blocking work as part of enabling/disabling
their vblank reporting mechanism in hardware(HW). Acquiring a mutex, for
example. However, the driver callbacks can be called from atomic
context, and therefore cannot block.

One solution is to have drivers defer their blocking work from their
enable/disable callbacks However, it can introduce concurrency between
the deferred work, and access to HW upon the callback's return. For
example, see drm_vblank_enable()'s call to drm_update_vblank_count()
that reads the HW vblank counter and scanout position immediately after
the driver callback returns. If the underlying HW remains accessible
when vblanks are disabled, then this wouldn't be an issue, but that's
not always the case.

This patch introduces a new per-device workqueue for deferring
drm_vblank_enable/disable_and_save(). Drivers can advertise their need
for deferred vblank by implementing the new
&drm_crtc_funcs->(pre|post)_(enable|disable)_vblank() callbacks, in
which they can do blocking work. DRM vblank will only defer if one or
more of these callbacks are implemented. Otherwise, the existing
non-deferred path will be used.

With deferred vblank enable, it is still possible that HW vblanks are
not ready by the time drm_vblank_get() returns. In cases where the
caller wants to ensure that vblank counts will increment (e.g. for
waiting on a specific vblank), this shouldn't be an issue: HW vblanks
will be enabled eventually, and the counter will progress (albeit with
some additional delay). But if the caller requires HW to be enabled upon
return (e.g. programming something that depends on HW being active), a
new drm_crtc_vblank_wait_deferred_enable() helper is provided. Drivers
can use it to wait for the enable work to complete before proceeding.

The &drm_crtc_funcs->(pre|post)_(enable|disable)_vblank() are also
inserted into drm_vblank_on and off(), as they call
drm_vblank_enable/disable(). I don't see a case where they're called
from atomic context, hence why they're not deferred. If that turns out
to be wrong (for a driver that needs to defer), we can change
enable/disable to be deferred there as well.

v2: Fix failing igt@kms_vblank tests:
* Fix wait_vblank_ioctl() skipping on deferred enable (because it skips
  on !vblank->enabled) by calling drm_crtc_vblank_wait_deferred_enable()
  (fixes all subtests that call wait_for_vblank()).
* Fix drm_vblank_get() not returning -EINVAL on deferred enable when
  drm_crtc_vblank_off() was called (fixes ts-continuation-dpms/modeset).

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/drm_drv.c    |   5 +
 drivers/gpu/drm/drm_vblank.c | 200 +++++++++++++++++++++++++++++++++--
 include/drm/drm_crtc.h       |  34 ++++++
 include/drm/drm_device.h     |   6 ++
 include/drm/drm_vblank.h     |  20 ++++
 5 files changed, 254 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 2915118436ce8..84884231f1f0e 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -696,6 +696,11 @@ static void drm_dev_init_release(struct drm_device *dev, void *res)
 	mutex_destroy(&dev->master_mutex);
 	mutex_destroy(&dev->clientlist_mutex);
 	mutex_destroy(&dev->filelist_mutex);
+
+	if (dev->deferred_vblank_wq) {
+		flush_workqueue(dev->deferred_vblank_wq);
+		destroy_workqueue(dev->deferred_vblank_wq);
+	}
 }
 
 static int drm_dev_init(struct drm_device *dev,
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 983c131b23694..4b73ccde35425 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -127,8 +127,11 @@
  * maintains a vertical blanking use count to ensure that the interrupts are not
  * disabled while a user still needs them. To increment the use count, drivers
  * call drm_crtc_vblank_get() and release the vblank reference again with
- * drm_crtc_vblank_put(). In between these two calls vblank interrupts are
- * guaranteed to be enabled.
+ * drm_crtc_vblank_put(). If drivers do not implement the deferred vblank
+ * callbacks (see &drm_crtc_funcs.pre_enable_vblank and related callbacks), in
+ * between these two calls vblank interrupts are guaranteed to be enabled.
+ * Otherwise, drivers have to wait for deferred enable via
+ * drm_crtc_vblank_wait_deferred_enable() in-between get() and put().
  *
  * On many hardware disabling the vblank interrupt cannot be done in a race-free
  * manner, see &drm_vblank_crtc_config.disable_immediate and
@@ -524,6 +527,9 @@ static void drm_vblank_init_release(struct drm_device *dev, void *ptr)
 	timer_delete_sync(&vblank->disable_timer);
 }
 
+static void drm_vblank_deferred_enable_worker(struct work_struct *work);
+static void drm_vblank_deferred_disable_worker(struct work_struct *work);
+
 /**
  * drm_vblank_init - initialize vblank support
  * @dev: DRM device
@@ -548,6 +554,12 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 	if (!dev->vblank)
 		return -ENOMEM;
 
+	dev->deferred_vblank_wq = alloc_workqueue("drm_vblank_deferred_wq",
+						  WQ_HIGHPRI | WQ_UNBOUND,
+						  0);
+	if (!dev->deferred_vblank_wq)
+		return -ENOMEM;
+
 	dev->num_crtcs = num_crtcs;
 
 	for (i = 0; i < num_crtcs; i++) {
@@ -567,6 +579,17 @@ int drm_vblank_init(struct drm_device *dev, unsigned int num_crtcs)
 		ret = drm_vblank_worker_init(vblank);
 		if (ret)
 			return ret;
+
+		INIT_WORK(&vblank->enable_work,
+			  drm_vblank_deferred_enable_worker);
+		INIT_DELAYED_WORK(&vblank->disable_work,
+				  drm_vblank_deferred_disable_worker);
+
+		init_completion(&vblank->enable_done);
+		/* Initialize in the completed state, the first deferred vblank
+		 * enable will reinitialize this.
+		 */
+		complete_all(&vblank->enable_done);
 	}
 
 	return 0;
@@ -595,6 +618,29 @@ bool drm_dev_has_vblank(const struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_dev_has_vblank);
 
+/**
+ * drm_crtc_needs_deferred_vblank - If crtc needs deferred vblank enable/disable
+ * @crtc: which CRTC to check
+ *
+ * If the driver implements any of the pre/post enable/disable vblank hooks
+ * where blocking work can be done, then vblank enable/disable need to be
+ * deferred.
+ *
+ * Returns:
+ * True if vblank enable/disable needs to be deferred, false otherwise.
+ */
+static bool drm_crtc_needs_deferred_vblank(const struct drm_crtc *crtc)
+{
+	const struct drm_crtc_funcs *funcs;
+
+	if (!crtc)
+		return false;
+
+	funcs = crtc->funcs;
+	return (funcs->pre_enable_vblank || funcs->post_enable_vblank ||
+		funcs->pre_disable_vblank || funcs->post_disable_vblank);
+}
+
 /**
  * drm_crtc_vblank_waitqueue - get vblank waitqueue for the CRTC
  * @crtc: which CRTC's vblank waitqueue to retrieve
@@ -1208,10 +1254,88 @@ static int drm_vblank_enable(struct drm_device *dev, unsigned int pipe)
 	return ret;
 }
 
+static void drm_vblank_deferred_enable_worker(struct work_struct *work)
+{
+	struct drm_vblank_crtc *vblank =
+		container_of(work, struct drm_vblank_crtc, enable_work);
+	struct drm_device *dev = vblank->dev;
+	struct drm_crtc *crtc = drm_crtc_from_index(dev, vblank->pipe);
+	unsigned long irqflags;
+	int ret;
+
+	if (drm_WARN_ON(dev, !crtc))
+		return;
+
+	if (crtc->funcs->pre_enable_vblank)
+		crtc->funcs->pre_enable_vblank(crtc);
+
+	spin_lock_irqsave(&dev->vbl_lock, irqflags);
+
+	/* Deferred enable should not error */
+	ret = drm_vblank_enable(dev, vblank->pipe);
+	drm_WARN(dev, ret, "CRTC-%d deferred vblank enable failed with %d\n",
+		 crtc->index, ret);
+	/* Deferred enable completed */
+	complete_all(&vblank->enable_done);
+
+	spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
+
+	if (crtc->funcs->post_enable_vblank)
+		crtc->funcs->post_enable_vblank(crtc);
+}
+
+static void drm_vblank_deferred_disable_worker(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct drm_vblank_crtc *vblank =
+		container_of(dwork, struct drm_vblank_crtc, disable_work);
+	struct drm_device *dev = vblank->dev;
+	struct drm_crtc *crtc = drm_crtc_from_index(dev, vblank->pipe);
+
+	if (drm_WARN_ON(dev, !crtc))
+		return;
+
+	if (crtc->funcs->pre_disable_vblank)
+		crtc->funcs->pre_disable_vblank(crtc);
+
+	vblank_disable_fn(&vblank->disable_timer);
+
+	if (crtc->funcs->post_disable_vblank)
+		crtc->funcs->post_disable_vblank(crtc);
+}
+
+/**
+ * drm_crtc_vblank_wait_deferred_enable - wait for deferred enable to complete
+ *
+ * @crtc: the CRTC to wait on
+ *
+ * After vblank_get() queues a vblank_enable() worker, wait for the worker to
+ * complete the enable. Drivers that defer vblank enable and use this to wait on
+ * HW vblank enable before continuing with programming that might race with it.
+ *
+ * If the CRTC does not need deferred enable, this function does nothing.
+ *
+ * Can block, and therefore must be called from process context.
+ */
+void drm_crtc_vblank_wait_deferred_enable(struct drm_crtc *crtc)
+{
+	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
+
+	if (!drm_crtc_needs_deferred_vblank(crtc))
+		return;
+
+	if (!wait_for_completion_timeout(&vblank->enable_done,
+	    msecs_to_jiffies(1000)))
+		drm_err(crtc->dev, "CRTC-%d: Timed out waiting for deferred vblank enable\n",
+			 drm_crtc_index(crtc));
+}
+EXPORT_SYMBOL(drm_crtc_vblank_wait_deferred_enable);
+
 int drm_vblank_get(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
 	unsigned long irqflags;
+	bool needs_deferred_enable;
 	int ret = 0;
 
 	if (!drm_dev_has_vblank(dev))
@@ -1220,12 +1344,30 @@ int drm_vblank_get(struct drm_device *dev, unsigned int pipe)
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return -EINVAL;
 
+	needs_deferred_enable =
+		drm_crtc_needs_deferred_vblank(drm_crtc_from_index(dev, pipe));
+
 	spin_lock_irqsave(&dev->vbl_lock, irqflags);
 	/* Going from 0->1 means we have to enable interrupts again */
 	if (atomic_add_return(1, &vblank->refcount) == 1) {
-		ret = drm_vblank_enable(dev, pipe);
+		if (needs_deferred_enable) {
+			/* Arm completion before queueing deferred enable */
+			reinit_completion(&vblank->enable_done);
+			queue_work(dev->deferred_vblank_wq, &vblank->enable_work);
+		} else {
+			ret = drm_vblank_enable(dev, pipe);
+		}
 	} else {
-		if (!vblank->enabled) {
+		/*
+		 * If deferred enable is not pending, and vblank is disabled,
+		 * while there's an active requestor (refcount > 1), then crtc
+		 * is turned off. Decrement refcount, and error.
+		 */
+		bool deferred_enable_pending =
+			needs_deferred_enable &&
+			!try_wait_for_completion(&vblank->enable_done);
+
+		if ((!deferred_enable_pending && !vblank->enabled)) {
 			atomic_dec(&vblank->refcount);
 			ret = -EINVAL;
 		}
@@ -1255,6 +1397,7 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
 	int vblank_offdelay = vblank->config.offdelay_ms;
+	bool needs_deferred_disable;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
@@ -1262,13 +1405,28 @@ void drm_vblank_put(struct drm_device *dev, unsigned int pipe)
 	if (drm_WARN_ON(dev, atomic_read(&vblank->refcount) == 0))
 		return;
 
+	needs_deferred_disable =
+		drm_crtc_needs_deferred_vblank(drm_crtc_from_index(dev, pipe));
+
 	/* Last user schedules interrupt disable */
-	if (atomic_dec_and_test(&vblank->refcount)) {
-		if (!vblank_offdelay)
-			return;
-		else if (vblank_offdelay < 0)
+	if (!atomic_dec_and_test(&vblank->refcount))
+		return;
+
+	if (!vblank_offdelay)
+		return;
+	else if (vblank_offdelay < 0) {
+		if (needs_deferred_disable)
+			mod_delayed_work(dev->deferred_vblank_wq,
+					 &vblank->disable_work,
+					 0);
+		else
 			vblank_disable_fn(&vblank->disable_timer);
-		else if (!vblank->config.disable_immediate)
+	} else if (!vblank->config.disable_immediate) {
+		if (needs_deferred_disable)
+			mod_delayed_work(dev->deferred_vblank_wq,
+					 &vblank->disable_work,
+					 msecs_to_jiffies(vblank_offdelay));
+		else
 			mod_timer(&vblank->disable_timer,
 				  jiffies + ((vblank_offdelay * HZ) / 1000));
 	}
@@ -1348,6 +1506,9 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
 
+	if (crtc->funcs->pre_disable_vblank)
+		crtc->funcs->pre_disable_vblank(crtc);
+
 	/*
 	 * Grab event_lock early to prevent vblank work from being scheduled
 	 * while we're in the middle of shutting down vblank interrupts
@@ -1394,6 +1555,9 @@ void drm_crtc_vblank_off(struct drm_crtc *crtc)
 
 	spin_unlock_irq(&dev->event_lock);
 
+	if (crtc->funcs->post_disable_vblank)
+		crtc->funcs->post_disable_vblank(crtc);
+
 	/* Will be reset by the modeset helpers when re-enabling the crtc by
 	 * calling drm_calc_timestamping_constants(). */
 	vblank->hwmode.crtc_clock = 0;
@@ -1489,6 +1653,9 @@ void drm_crtc_vblank_on_config(struct drm_crtc *crtc,
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
 
+	if (crtc->funcs->pre_enable_vblank)
+		crtc->funcs->pre_enable_vblank(crtc);
+
 	spin_lock_irq(&dev->vbl_lock);
 	drm_dbg_vbl(dev, "crtc %d, vblank enabled %d, inmodeset %d\n",
 		    pipe, vblank->enabled, vblank->inmodeset);
@@ -1510,6 +1677,9 @@ void drm_crtc_vblank_on_config(struct drm_crtc *crtc,
 	if (atomic_read(&vblank->refcount) != 0 || !vblank->config.offdelay_ms)
 		drm_WARN_ON(dev, drm_vblank_enable(dev, pipe));
 	spin_unlock_irq(&dev->vbl_lock);
+
+	if (crtc->funcs->post_enable_vblank)
+		crtc->funcs->post_enable_vblank(crtc);
 }
 EXPORT_SYMBOL(drm_crtc_vblank_on_config);
 
@@ -1797,6 +1967,8 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 	}
 
 	ret = drm_vblank_get(dev, pipe);
+	drm_crtc_vblank_wait_deferred_enable(drm_crtc_from_index(dev, pipe));
+
 	if (ret) {
 		drm_dbg_core(dev,
 			     "crtc %d failed to acquire vblank counter, %d\n",
@@ -1962,8 +2134,14 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe)
 
 	spin_unlock_irqrestore(&dev->event_lock, irqflags);
 
-	if (disable_irq)
-		vblank_disable_fn(&vblank->disable_timer);
+	if (disable_irq) {
+		if (drm_crtc_needs_deferred_vblank(drm_crtc_from_index(dev, pipe)))
+			mod_delayed_work(dev->deferred_vblank_wq,
+					 &vblank->disable_work,
+					 0);
+		else
+			vblank_disable_fn(&vblank->disable_timer);
+	}
 
 	return true;
 }
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 312fc1e745d22..dc45400c18094 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -904,6 +904,40 @@ struct drm_crtc_funcs {
 	 */
 	void (*disable_vblank)(struct drm_crtc *crtc);
 
+	/**
+	 * @pre_enable_vblank:
+	 *
+	 * Optional callback to do blocking work prior to vblank_enable(). If
+	 * set, vblank enable/disable will be deferred to a single-threaded
+	 * worker.
+	 */
+	void (*pre_enable_vblank)(struct drm_crtc *crtc);
+
+	/**
+	 * @post_enable_vblank:
+	 *
+	 * Optional callback to do blocking work after vblank_enable(). If set,
+	 * vblank enable/disable will be deferred to a single-threaded worker.
+	 */
+	void (*post_enable_vblank)(struct drm_crtc *crtc);
+
+	/**
+	 * @pre_disable_vblank:
+	 *
+	 * Optional callback to do blocking work prior to vblank_disable(). If
+	 * set, vblank enable/disable will be deferred to a single-threaded
+	 * worker.
+	 */
+	void (*pre_disable_vblank)(struct drm_crtc *crtc);
+
+	/**
+	 * @post_disable_vblank:
+	 *
+	 * Optional callback to do blocking work after vblank_disable(). If set,
+	 * vblank enable/disable will be deferred to a single-threaded worker.
+	 */
+	void (*post_disable_vblank)(struct drm_crtc *crtc);
+
 	/**
 	 * @get_vblank_timestamp:
 	 *
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index bc78fb77cc279..c0e22f8d868b2 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -333,6 +333,12 @@ struct drm_device {
 	 */
 	spinlock_t event_lock;
 
+	/**
+	 * @deferred_vblank_wq: Workqueue used for deferred vblank
+	 * enable/disable work.
+	 */
+	struct workqueue_struct *deferred_vblank_wq;
+
 	/** @num_crtcs: Number of CRTCs on this device */
 	unsigned int num_crtcs;
 
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f5b1b..6bd3cbf1bb831 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -282,6 +282,25 @@ struct drm_vblank_crtc {
 	 * @vblank_timer: Holds the state of the vblank timer
 	 */
 	struct drm_vblank_crtc_timer vblank_timer;
+
+	/**
+	 * @enable_work: Deferred enable work for this vblank CRTC
+	 */
+	struct work_struct enable_work;
+
+	/**
+	 * @disable_work: Delayed disable work for this vblank CRTC
+	 */
+	struct delayed_work disable_work;
+
+	/**
+	 * @enable_done: Signals completion of deferred vblank enable
+	 *
+	 * If deferred enable work is needed, it is reinitialized before
+	 * queueing the enable worker, and completed after the deferred
+	 * drm_vblank_enable() completes.
+	 */
+	struct completion enable_done;
 };
 
 struct drm_vblank_crtc *drm_crtc_vblank_crtc(struct drm_crtc *crtc);
@@ -302,6 +321,7 @@ bool drm_handle_vblank(struct drm_device *dev, unsigned int pipe);
 bool drm_crtc_handle_vblank(struct drm_crtc *crtc);
 int drm_crtc_vblank_get(struct drm_crtc *crtc);
 void drm_crtc_vblank_put(struct drm_crtc *crtc);
+void drm_crtc_vblank_wait_deferred_enable(struct drm_crtc *crtc);
 int drm_crtc_wait_one_vblank(struct drm_crtc *crtc);
 void drm_crtc_vblank_off(struct drm_crtc *crtc);
 void drm_crtc_vblank_reset(struct drm_crtc *crtc);
-- 
2.53.0

