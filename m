Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8490606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uuBgHdEw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B936B112205;
	Thu, 26 Nov 2026 08:56:03 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C941121EB;
 Thu, 26 Nov 2026 08:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIFVkJ8pXrzbm7jmFmDpT1oEsEKjgygE7l3eQuHMGFdhMv2APFhHyEoPS6Nye7zrDl9NKRsszsuZBdqPmc26d4R+46Tn4zoKqqCVl37I4fdPI2RS/xZvSc3/x41h3hkBZmkBiHnp/qIQUjvjJvfTSjkdULn2ZVu/icxqSlxof9H6j53WazVSL+RXTbjJuvbVP98KANo0ATmQTOY2rP7BjRGVNdjUXzK3sOGwKzwQm45YDmKjaij/vvJqtQkDD/sMXFl1wBZzAW8tvPEKdMTQNlS5Kwb6JMNz1J4+nM3CN80+gQF5esRFYEymaQAuC1B4euPcBbUxiHRNXghPqRaHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26R6jtCrl42Y0akREqzv9ynmPH8trY3C3GXQ+PzYytA=;
 b=GhiwOd9inMNiduEZqjzv8hmGkpIZhrBcHsxzj9aKUa/+FJuxm1zlDHPVjfTuQD6XFgF4+LC83a/Oq7aAglzG3yfgEYRC80HXmIiBrKrUaZ6lNHbMykSlBUzpOSDw/EjMej8gGmcDI1Flq9nXw9zy+MUHMsusWp8mz1g7VNTzrBXgb7y4yLiJxNDojP++4xWmA4MGpcxT73kUVXhMwHg+umrMqGPKiaR/fgoIg8QGVC4JhuVsUfP6qD7utinl0cf864AmUft9siVpnWjYfRFm9hQk+N89JupCxE6Qe86LBcuekGast6sldyYoTEL4I4T/Zm9VB5ds592mCPwTo/+2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26R6jtCrl42Y0akREqzv9ynmPH8trY3C3GXQ+PzYytA=;
 b=uuBgHdEw6wBdGDKbOsP1WDL6/EKcFbS9EuepzAGrUAkSWqJd0TpsDc+aM2diCYKgyqoch51/DiiMloZYtlech+s2aF8VYR8kamnO54V2Ocrn53/ybGaiBxCuIlXP0cg2A1vJZD8F/lFryfBDve1+iZ5gXypNLDPobtnEyyS867s=
Received: from DS1PR04CA0012.namprd04.prod.outlook.com (2603:10b6:8:44f::7) by
 PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 08:55:44 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:8:44f:cafe::20) by DS1PR04CA0012.outlook.office365.com
 (2603:10b6:8:44f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 08:55:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.0 via Frontend Transport; Thu, 26 Nov 2026 08:55:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 02:55:40 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <tzimmermann@suse.de>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 2/3] drm/vblank: Add drm_crtc_wait_one_vblank_interruptible()
Date: Thu, 26 Nov 2026 16:55:27 +0800
Message-ID: <20261126085528.820182-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126085528.820182-1-Prike.Liang@amd.com>
References: <20261126085528.820182-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 034934b3-f9b3-4ce2-c3ad-08df4b9b0e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|261009221727099003|261009223027099003|261009220027099003|261009221227099003|261009223327099003|22082099003|18002099003|13003099007|11063799006|10067099003|261102123227099003|261022075727099003|261102130727099003|261026140227099003|261021123027099003|261022105027099003|261026121527099003|261028144727099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5Us9yIJa1NjpqFQFNd2KNaCBVvtsFsmC1wDEwiQ0tEnhuWsjCxWUmIsBtTvNaXupe9L00PRrj8E0Bn67DUd1RZd05ttUVnyWLhkWarAMPUoTarO3w2t/OcGdy1iZEEmeE0mMJwET3Z/e8vO4zz0NkPTxqjgZbsrdNfAgHMG17nPxNLukJqG9Szz1QsTJVQNcdpudk3fejFQ9RGblSt44GS2vNt12T8ujvFZLEef8S61Sj73Edt6SZ44c6DmSuWVNW0FOtVNgM38NOgvCw8sOITjM2IcTHlPJN2YBK0W4eBcKjQFeSWRYww9+m8F0KcZTtr4cB29ljVSQ17jruts5KmpSkfinUe7dCSh911YaBCBlAYzypFmB48aiSvarKubscDYvLL/fBuo9qzQa3gh23n19HLT/eCgmfz91ILMAyGO+SfHUrwxwFmGNvOAVrrCr1S9ie/C6N567BEaxLYh+m2t/TpeUpX6hao8cdiPB/wNKmPrcKEczNAAY0TK9n7c/miYs+J0XS122MBO0s+XRGH2gFCTzymFM2r7aqHN8CXUrRyKdHPqQ+6T2q4RPoCF2XIQnmIzYaVL9Q0MxmC50BuSkheLPXSSVuVBm94WeEYGX4AkTGE3hOzN6XRKkOvTk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(261009221727099003)(261009223027099003)(261009220027099003)(261009221227099003)(261009223327099003)(22082099003)(18002099003)(13003099007)(11063799006)(10067099003)(261102123227099003)(261022075727099003)(261102130727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A0MvadAuZX/s31BrersaxPOMdVvpiewQvYC0JSj49qZgmmTJOvJLFgpgekED6lHCx8EK9zUiWkk2AYRc1SPCr9ODS3X3MKfjB+/2tyl6CBImcEBu8dKkfNV+y4FXPNJgmGi3cvIvAdFjjtDO2TiJHp5vFnmnmbjB6GlZAYfyaBV1QWNO7r5f89o7qhujrVu2kQ8NLAg8yXPUo0CkSCWaQM8Oqcz1T+4o2wj1nBTrB3ttAdy+TFrxKrZVVlbKpLhpApFKqsKvOx7KpHUqWPThUjHZX3NyZ2RgpgvbcAKX/tY2xl9guzazFPq32yDLjnRqh++Y7W8+hSI3ODhgge1IOsul8zZGZWfNvW11uNUsKjXWlbq+8gGamBuD3ORTHqhD+gaPFCvdC0XWmb/QLjWgq8krpTr7jFFojFHY5F7zMM3uRUX1iuiGioQ6rJbOLfZp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:55:44.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034934b3-f9b3-4ce2-c3ad-08df4b9b0e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_crtc_wait_one_vblank() waits uninterruptibly and only gives up after
one second. That doesn't suit a wait that userspace asks for, such as
FBIO_WAITFORVSYNC: if no vblank interrupt arrives, the task sleeps in D
state for the whole second and can't be interrupted, not even by
SIGKILL.

Add drm_crtc_wait_one_vblank_interruptible(), a DRM-internal variant of
drm_crtc_wait_one_vblank() that a signal can interrupt. It returns
-ERESTARTSYS in that case and otherwise behaves like
drm_crtc_wait_one_vblank(), which includes ending the wait when vblank
is turned off. Move the wait to __drm_crtc_wait_one_vblank(), which
implements both functions.

drm_crtc_wait_one_vblank() doesn't change, and drivers keep using it.
The new function has no user yet. The next patch uses it in
drm_client_modeset_wait_for_vblank().

Link: https://lore.kernel.org/r/20261119082424.554841-2-Prike.Liang@amd.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_internal.h |  1 +
 drivers/gpu/drm/drm_vblank.c   | 66 ++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 815486557f51..3f2120e8e010 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -128,6 +128,7 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
 int drm_vblank_get(struct drm_device *dev, unsigned int pipe);
 void drm_vblank_put(struct drm_device *dev, unsigned int pipe);
 u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe);
+int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc);
 
 /* drm_vblank_work.c */
 static inline void drm_vblank_flush_worker(struct drm_vblank_crtc *vblank)
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 02abed5324ce..82b5ad6655d6 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1297,23 +1297,12 @@ void drm_crtc_vblank_put(struct drm_crtc *crtc)
 }
 EXPORT_SYMBOL(drm_crtc_vblank_put);
 
-/**
- * drm_crtc_wait_one_vblank - wait for one vblank
- * @crtc: DRM crtc
- *
- * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
- * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
- * due to lack of driver support or because the crtc is off. The wait terminates
- * early with an error if drm_crtc_vblank_off() disables the vblank irq before
- * a vblank passes.
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
 
@@ -1324,14 +1313,22 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
 
 	last = drm_vblank_count(dev, pipe);
 
-	ret = wait_event_timeout(vblank->queue,
-				 last != drm_vblank_count(dev, pipe) ||
-				 !READ_ONCE(vblank->enabled),
-				 msecs_to_jiffies(1000));
+	if (interruptible)
+		timeout = wait_event_interruptible_timeout(vblank->queue,
+							   last != drm_vblank_count(dev, pipe) ||
+							   !READ_ONCE(vblank->enabled),
+							   timeout);
+	else
+		timeout = wait_event_timeout(vblank->queue,
+					     last != drm_vblank_count(dev, pipe) ||
+					     !READ_ONCE(vblank->enabled),
+					     timeout);
 
-	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
+	drm_WARN(dev, timeout == 0, "vblank wait timed out on crtc %i\n", pipe);
 
-	if (!ret)
+	if (timeout < 0)
+		ret = timeout;
+	else if (!timeout)
 		ret = -ETIMEDOUT;
 	else if (last == drm_vblank_count(dev, pipe))
 		ret = -EINVAL; /* drm_crtc_vblank_off() ended the wait */
@@ -1342,8 +1339,39 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
 
 	return ret;
 }
+
+/**
+ * drm_crtc_wait_one_vblank - wait for one vblank
+ * @crtc: DRM crtc
+ *
+ * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
+ * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
+ * due to lack of driver support or because the crtc is off. The wait terminates
+ * early with an error if drm_crtc_vblank_off() disables the vblank irq before
+ * a vblank passes.
+ *
+ * Returns: 0 on success, negative error on failures.
+ */
+int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
+{
+	return __drm_crtc_wait_one_vblank(crtc, false);
+}
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

