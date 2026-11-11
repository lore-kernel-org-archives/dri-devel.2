Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388A606A334
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tW+ElmcT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34DA10F976;
	Wed, 11 Nov 2026 08:36:16 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A15810F96C;
 Wed, 11 Nov 2026 08:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oL4nMVLG/ZESWoQ7j942vYYCGiSHpOrKxpgwSBMq9PIFmPdZuBsONMyh2NdAknJLDQ8lrvCR4muMfacth600+/vd58/So0qCe/1gM8BzZKbz9M9B5YEX2KgDUjAgN1fzA3MW0oDqh967yb184HabgC7O+j6+SHcMQUO5LikvW38mb7NrXVjhcla6M1ntYuyyCzrF72uSoKa2YzaW/b6IqePuA/ciVrzGXBdIY9/Q6iwymDKUWEOpMFm6cGZXg34k8/0u9iJWo3BG6rjL0RFEdXxTPXCYGA7dqnyeUEGYqry5Ju/cUJ1KCvuX+6u/lkw2Z7XgqL6LXcgeLe6PqYWN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RurdWSVfRsqsXfVPd0sm4jg6QWAWn76hyTSwoNtFmLo=;
 b=LJcX5ceRQKX4yTxGG3zxZ+I5OyPAt3ekVY3EP7Xw28CeSBbP33T5Ojbb0lhRAEVDGGY2kgc9FWh50fRFwGyCHqJKB3a+yFuS4AzGshKbU63IXocCx+lGwkIKAti2+lptPyDJ3ibXbkzulH2eKKZ+xezZflhhtk/78rBk84R19BLmiNJvAGY59n3kO2c3v4HaNeuja2tAdAq9i4o5+3SAYCYtb3Ot638ac89anSGrdS71LhC9APrrHIS/TrJIBDNEKf6yL5oSx4i84Jt7smBydvhQwb1Beh9xdCfuwZsxrfrWc8sv4gIdO/1TpFUHengGYmVz4FpK4OiZlrasxTVzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RurdWSVfRsqsXfVPd0sm4jg6QWAWn76hyTSwoNtFmLo=;
 b=tW+ElmcTl7ak5Gp77ApjAu/2d0H8Lxfaarfxvx9xDlpywGQSeVkWdSdONHiKnW3RzudNaIpBV+fPe112uV3rn2knu94V+XLIv+oiCqJe3XnkvCI2FW+Ly113GDpMnhUzUut4QfzIPx8Wsek8wdPi6ZpjdReBApoOSvKYwALWxKA=
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:36:02 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::86) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 08:36:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:36:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:35:59 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>
Subject: [PATCH 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
 interruptible
Date: Wed, 11 Nov 2026 16:35:30 +0800
Message-ID: <20261111083534.514290-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: ff55999a-5a79-4691-6f9b-08df3fced1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009220027099003|261009221727099003|261009223027099003|261009223327099003|10067099003|261022115727099003|261028144727099003|261102130727099003|261102123227099003|261009221227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: YXrd5XCtjDDNLBSTx0a48UfHOSex2DDrys7+c13vSZ6Bo+K8Eb8VU+sHI6PzJSrs1BVaGT32ixlH7JyGngyVQNp7QMeMJKsuIPmUkYUnyzYS9m5rj6nJif7PLNYGy+6DRK6l2X7YdszmR+rRfU1V0Ynfx25Z2NM5hbiS6r22Uj9uwTgi2W3iVr/xnbIPYvDeqbOVh/FZzffO47hvkQNW+mos08wdgZ7JsZjVliJBhKucEiTeqz46Xm2OrzHXrLSdxj6Qro/p+NYMuCORH3+fElYUHI++5XjKVFUhqIYvtLmqdt37yybVplRALXZXuKzsQJoG93Elmf39xTZXk2q/bQoUZpouSBKjRtXcwenfFozY09Eyawf1t4jKOfydPT0PnFk8B3Dj3K80D5pMTsVeLWh+t+MGdGZfQbTwfFnIcPsM2SfYYRlMC7vBJXLahCYGpT0rC7oIdI1Xv7TDtZUOwFWx+VSmsIolXz/+KN6+7Jt63EJuHeCmbLLaMxLQ8uwNA1/P84I9Xfi/LXaAPv8n69HBhu/NwaIPmpZf4/VweKOO5XWuQpJyrSCSuaj3xDfG3T+ScQKHHPs2yk4dRi8gE0Hj1bIMEbo5QiBQTxhU9CkXwJWBM76Wt8j7z9/9m+7X+itmskTrS1YNR8M+gr0wgqwH2ii14yvW6Iz1f0Qa0WQcEZsNR0Zuo0OkHECVUvd93q7nXqU+zliE9OT6761/Aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(10067099003)(261022115727099003)(261028144727099003)(261102130727099003)(261102123227099003)(261009221227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(5023799004)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1tElykCtcsZrCHS/EMWl1NM8fNBvcrLKr4iCmkudPwHM46XwxE7MUF8eSuRdyLPdBe3p6p8bLPtMKUdz0Kv+LtKDpbzwRqeFaV7Rm2kDy5mtweCj1+tcZMPENDu19UlWDWWMftUuuvYWbvYo3JDlvsnpnEwu74kqHiBkaVt+EUZT10fm4CdVxy+h4+e0zTJ1E4RCX86aarF5hRYFue+ZfjnETBiqaQr8m5xZ2zEpOU7G9Dj5FUzbRAczM06CBebuVM7/VkzOqPZCadh163kBztYAcwNg/wxkCQ8v/MjA0EJgK2JsRKUx531uEofbhHIrUAVq68eVlSru5lAEoKE6p0rqxrqhSF3k+fBVIUucrZXwcAQXhFZ7fw7fKR4qvTfoBUazhHIqBdsI0AvqQLKkwIH6XSJffBRnLBly52YSR9xfFIdEPtigvoftO+vyQ4Ga
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:36:02.1971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff55999a-5a79-4691-6f9b-08df3fced1aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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

