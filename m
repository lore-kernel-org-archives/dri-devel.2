Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9DE606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NpkqRHRn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2402411212C;
	Thu, 19 Nov 2026 08:25:04 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7232B1120F4;
 Thu, 19 Nov 2026 08:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPelNYqA+GVTN/dicc2SZP6H5EVK8A22BAsTj4oY0mkb7h+R5Z8KumgJHLiEZaVmBnZVMxZiE3DMgO1fTqH7PCRA/FqkUfMJ3eR0QaT5YV5SZOMkLjH3eyA6DFqLb8jpwrVnQYopxU7jpGnjmnmgl5hTxQubhFza7ZM6fNZQrsQ2XI8u4Cqd+RuQ4DXrunfOOYrzfBYImp3gd2WlmcTMaiE4EuJmwpTOU6zEsc5xJD/7ESZGiSli3FcTNDTzq0V9vxbWi6Ay1gMat93AP1DDEdji+0+yr/9DV/NvzI6W7hjP+ye6+4lgOoKyyxmQZkiSec3YHdvf3OcEbE5kCZTpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYAnnLAWGWpbPa7K70KIDLnkFENZigxRXn/NspMMfT4=;
 b=SE5Alp1n0i5nxDBwfGKG1nwQXaNKr3UtsiH8I/a2n6NzawPuT5UeQPFyqkfprDlEmV+DENaSqzQzKmHp2R92tA9zHf7kf9NCC8wcw2ziE3ZS2HJhDUFGTGcUd5K+unat03tNPMGkgjXq2cY/O7dVNprxIiwnVeJD6MILQx2BdQ1rQKF/fd28DuiQyNA+SQP0xSP+91M3c3vIcvtRoRM7zRiv8mZ9LU0xuvaRXJZrLBwszuHWYzWd29PG7uUnEGMpa2RQNymxCO4Pgb2Da8jlVBZ9k/gfwd3t8SyqwqQfh5fiFUL3Nur+tez5qzZ+niGbptvEVoO/i1t0LncBfnIx8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYAnnLAWGWpbPa7K70KIDLnkFENZigxRXn/NspMMfT4=;
 b=NpkqRHRnJbA41WOu+NaYiHstLlYUWmrLhZqUNqGfvrjHVs0fEsbKm9brX5yx3b7sX16wUx4cDEHuvOJsp6EcUhbrrX8NxvmiP+IY08xEAMFn4lcEuvavGbPuQgFk/dsP40hmkUD4C+fhAliYtkaSGp5rDOnWmOebKpRmaIfPXKc=
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 08:24:40 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::4a) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 08:24:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 08:24:39 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:24:36 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>,
 <ville.syrjala@linux.intel.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 2/5] drm/vblank: Add
 drm_crtc_wait_one_vblank_interruptible()
Date: Thu, 19 Nov 2026 16:24:21 +0800
Message-ID: <20261119082424.554841-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119082424.554841-1-Prike.Liang@amd.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: b79b2886-e62c-4db3-1f7b-08df46168e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|261102123227099003|10067099003|261026121527099003|11063799006|261102130727099003|56012099006|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261028144727099003|261009223027099003|261009221727099003|261009223327099003|261009220027099003|261009221227099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xiGVB1oIhY+y+4LxA88jBNABheaM2neWsY/O6ywoZxGtyWUUEzjnd6t3CMiTXisZ3CwDb8iXfEcLIp/lZETUFuQTaJPomMTO7va/yWwfYdHP2HqPUeU7NNTfBxuARHOvWcmzdQzFDyQpLDZ84dRKsCduE2V5P7P5zjDMrRzQ1VbIYHiNl1FBOHuvLTxXSkVereApIXSamJierffGFSWxoV2XtmGlWBgTA+D8mPRCyw7fwxVj2SImYIeXEwkV0gjeFlYr6fcqnKljNwa/BhhoucN05U2n3WwBUszmBi4uJih/dtXn309Ach8Io2O7uD5cSFiG1ePMMiJ6TJ21iNZtIdI9Snk33zJw7LbtycSYrk465FxM9pUPjcxrQPCfDvjfKWnrNKZ7eoNA9GMtVmO7ZRUhTCku/22tTWGaaBm0HQ7CmhO94HP2IfIbiyokKemwQJZxy870io28gMrOtcJx+bXX3QODoATQgSEBEGlE1YMVjg5Sd1xq8JDYIKku0jEI21EAYU55TX68uyJ9zmgztIljV74Xffvded8s3zWs02a5gj/f9akZeV14VU6MSuMR3vzzrk79ZzFBOLfib8O8gzCHpsVcIfzs6gZoeVKWYixYnA+/IDvk5wI0OPpiF9JuSK4e36SfJJRRKSeYzwQqcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(261102123227099003)(10067099003)(261026121527099003)(11063799006)(261102130727099003)(56012099006)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009220027099003)(261009221227099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TMEvD4dNIJsCJieqXQTRizerOt2/H12rpU6K9+MJLQkR899uA94B+if0TgnUst1xoLBgq3meVMDPO542vxAj7YiFuV+0JRMJj56zfFBj2WwuwbgSBwORq3is/kO9pq6zOPfKPmcuDk96Lr0vbTBG6RXpc1CUise0+Ciy1nGPLrcMFpzCJuUlTk17uzT9KY9aTgm5NUaaAs/NqH0n7tFu+Rhy5x+6JC0esF6FaH4Sd9K+qkVI1k2uUDiCRQsE5c0grzuAe4ffc+ZtzIU4o7R22ARS85IjcmjbPIPJvBwX6TfUMIm+rygtASoZMDMqZm6BmPm+E2u3KsSXePRqvTXWjigRqsdrTWcFNK11KiKhxp1qz7/1kb+Vvl4qimgbpuoU8qioC4cmEXoN5gE1dsNgVPQUgZO0/B7TwIK9b/pUg1lXWFGabLOt/xrLHxMum5yf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 08:24:39.6657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79b2886-e62c-4db3-1f7b-08df46168e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992
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

Version update:
1) https://lists.freedesktop.org/archives/dri-devel/2026-November/616727.html

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/drm_internal.h |  1 +
 drivers/gpu/drm/drm_vblank.c   | 64 ++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 18 deletions(-)

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
index 54118eb1413c..5e247663978a 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1297,22 +1297,12 @@ void drm_crtc_vblank_put(struct drm_crtc *crtc)
 }
 EXPORT_SYMBOL(drm_crtc_vblank_put);
 
-/**
- * drm_crtc_wait_one_vblank - wait for one vblank
- * @crtc: DRM crtc
- *
- * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
- * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
- * due to lack of driver support or because the crtc is off. The wait also fails
- * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.
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
 
@@ -1323,14 +1313,22 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
 
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
@@ -1341,8 +1339,38 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
 
 	return ret;
 }
+
+/**
+ * drm_crtc_wait_one_vblank - wait for one vblank
+ * @crtc: DRM crtc
+ *
+ * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
+ * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
+ * due to lack of driver support or because the crtc is off. The wait also fails
+ * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.
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

