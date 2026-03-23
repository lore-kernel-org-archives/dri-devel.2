Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B1CF483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839E210E4CD;
	Mon, 23 Mar 2026 20:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kBR6kCqq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012060.outbound.protection.outlook.com
 [40.107.200.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BE910E42C;
 Mon, 23 Mar 2026 20:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRKCsKvz+dHry2YlQVljKF+zkOqTAIR5MBWy7W8sNCZtFNXLqHV9LOAKS5ILOHLCz8WD7dRQRNY+8OAsw+Q62Du6urFpAGKfxIGgqGpwCMCMthARV7WlG1lNFh4YHfOiK7XpTpMEIOf1ksVPPM+zjezo1kIaHyBT21xy3mdf5yl5nfED3VzAk162qDfhJ7cONm720ADYp+wA+WFqunpl/oybvJW/78Izw73n8IS7t84a3SgKGORyv1UudcgEvi45xhfkTMFeq/VoxZvupXMEt/QEYj4XOCuYweyJTPAKV/7xJebjZGjrHTgVGovOa8UtIbnTeCRnQxLrVWl6nvqWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkCymYAwp3inG8y+3iMMEHRdKobFzOGS7SQEWIl24V4=;
 b=oqxqj9gJDqotuINDGsMNlSBx8rFXhsmxsEVtHSDinmcnr8sZYVIuaVXa4ERCA1lvFHJJ0g99tqqhb5B96fh1QzxghmozJbnlgO0VzIj+ckX0c7/akA6PX25/opGDGK9GS+U1OTCAv6TseJj4TxOt1mpq50CWNhxyjIeL6OapDQMmfMC5SvACVFFycImCE3CfonTYaBmu5ioTzo+fn1qfnQY6TQDixDkoOhIJpA8PXib9YLyxsqdPnySQ62H7ZSp+dGrDTIGTy/9yoYkTs1rrxnMn0K0F+h/tiAjWr5CbbyVDLO28mD4TCEfGmXIu5DEx+fjMSlG0yyzD0TnWD8ecYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkCymYAwp3inG8y+3iMMEHRdKobFzOGS7SQEWIl24V4=;
 b=kBR6kCqqcsB2sy4PMNAvdiy7iCMWQVHjzOogc8mLsdyyiLX/Gxl3s0gekJptjU93xtHgPx6SYSOY4KXjCgGKsF5tXwf0zX+gIpRVKjUFUk1d75LUbzYDoobQ6xn6AbGL1CmPjUps6gibMHpVfnidBegXGdVlB3yJXFb0lCJViTU=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by LV9PR12MB9782.namprd12.prod.outlook.com (2603:10b6:408:2f2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Mon, 23 Mar
 2026 20:30:12 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1a) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:30:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:08 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Mon, 23 Mar 2026 15:30:07 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <simona@ffwll.ch>, <airlied@gmail.com>,
 <jani.nikula@linux.intel.com>, <ville.syrjala@linux.intel.com>,
 <superm1@kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 1/5] drm/vblank: Add drm_crtc_vblank_is_off() helper
Date: Mon, 23 Mar 2026 16:27:51 -0400
Message-ID: <20260323202755.315929-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323202755.315929-1-sunpeng.li@amd.com>
References: <20260323202755.315929-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|LV9PR12MB9782:EE_
X-MS-Office365-Filtering-Correlation-Id: df3b449f-61a0-4a94-2dc9-08de891afbf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lwv2IJErZTN3VXu0ejMkNuvEuLQP/JVSVxTkXRmGA9zRIym8V3on3NtKRTPsa7HwRE+wb4+Uai9xg8nd1hJvO7gsbDWiyhKp7BAWLRrp1frP82Z4LCLsmcstRBowjJhIcvHziRUSehuotcANd6ElNK76leg2u1XhHWRSiGHRZ5gK0uy5gZTWDh/u3drwPc+T1NJ7aIk9j5GXMd6PnyxgIXhpWcyIVxSmW87A6RvB6TZSmR0Ilfa6Eivbo4+fi0DhtXmkGFBTG+3L+WqBzUSSDuslT3eNC3WBirFR3q/NG7SEdPYmsvFQWfTxc4KRgXV1+pcUJ3qtQ5mvR+FzOAwZguYmQnb17i58DaQ2edLvg7ep+mNET5OblxZOExBKRh3CHb3UERs0941hPZVV+P6lMlMLC3nq2Q8iV5aoOzljrlL/hdODfGVkOKQ9O+uMXGH8EAQkDyVt5Nz4vglPdZBjwHb+mmnO3VSgK5MmCthkaxGqEp659uUv5sKRbU1h3K1al3R790ZVoQCiPPTjkj8U6tm1RVuMsdqcSjLP7d7+pCHnVdHU3jgLdKXVy8ijT6++3vEeNU4hziTRqgsQeQGFJY5vOAYLlY/DshLucsNUdlO5s9Q3ZREMKKJAtnOQ/fE1BHJSaysGBcg0jtw+MG9oVF51WL5ak/hhZI0p84KNxS/Lp0OE3sFlzCmj3FZ5EKMBFV85JmWAyBYqy0TAu8QebX5g6FgvSyq4lFYzt5387clj2ELtwEh1EP82HDNy4ISQlUao7MntKWv5DUwjl3gf/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mbVb6KcoY4/bLw66/Dl+uXuBSWqJzpGsldVZrgnoeVD1pBG8PKYsRI2Htiov8WbVrVz5d/zntbgdVcFpxYEaI228jTabIluIVDQMIHMyW6hKC3ZsT2KtArf6xwE3MiWOzdQ0lAWJbtMgYEWc+/9cB0X28lIMgj1VtUowS+wEjpp8WjZk+n7ZBhkX4hCfD8IDG6RxZH6++o7ObgkbsRy+bB2uqCiFf0DQgyz7K95j8nOyNzRawkQYZQfFCmKTwg2mFGU2oFj8zL2Y6mOVEuS6kc7/M3xfJ42ixMk6J6zKzTDmoKd0IMa2m5dk4qth6uyXmUrXG2MqxZq84VEKKRHeGsn5aDSxVtZol5trQnfsnKizn3jFxiPiHZpNvF8GlAQKYuCF8DKujDpawLOH9MDzeGBa/EuLo7fZn1+qnyU7q4Cob8s2Lt2rrYdrPF0AISnM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:30:12.1805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df3b449f-61a0-4a94-2dc9-08de891afbf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9782
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

Add and use an drm internal helper to check if vblanks have been turned
off (via drm_crtc_vblank_off()) for a CRTC, rather than relying on the
return value of drm_crtc_vblank_get().

This is in preparation of introducing deferred vblank enable/disable, as
vblank_get() will not return the expected error code when the driver
defers vblank enable.

No functional change is intended.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 11 +++++------
 drivers/gpu/drm/drm_internal.h      |  1 +
 drivers/gpu/drm/drm_vblank.c        | 17 +++++++++++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 26953ed6b53e8..102937e3ff35b 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -48,6 +48,7 @@
 
 #include "drm_crtc_helper_internal.h"
 #include "drm_crtc_internal.h"
+#include "drm_internal.h"
 
 /**
  * DOC: overview
@@ -1259,7 +1260,7 @@ drm_atomic_helper_commit_crtc_disable(struct drm_device *dev, struct drm_atomic_
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		const struct drm_crtc_helper_funcs *funcs;
-		int ret;
+		bool vblank_off;
 
 		/* Shut down everything that needs a full modeset. */
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
@@ -1287,19 +1288,17 @@ drm_atomic_helper_commit_crtc_disable(struct drm_device *dev, struct drm_atomic_
 		if (!drm_dev_has_vblank(dev))
 			continue;
 
-		ret = drm_crtc_vblank_get(crtc);
+		vblank_off = drm_crtc_vblank_is_off(crtc);
 		/*
 		 * Self-refresh is not a true "disable"; ensure vblank remains
 		 * enabled.
 		 */
 		if (new_crtc_state->self_refresh_active)
-			WARN_ONCE(ret != 0,
+			WARN_ONCE(vblank_off,
 				  "driver disabled vblank in self-refresh\n");
 		else
-			WARN_ONCE(ret != -EINVAL,
+			WARN_ONCE(!vblank_off,
 				  "driver forgot to call drm_crtc_vblank_off()\n");
-		if (ret == 0)
-			drm_crtc_vblank_put(crtc);
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_crtc_disable);
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index f893b1e3a596e..7d10515fe2ed5 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -131,6 +131,7 @@ static inline void drm_vblank_destroy_worker(struct drm_vblank_crtc *vblank)
 int drm_vblank_worker_init(struct drm_vblank_crtc *vblank);
 void drm_vblank_cancel_pending_works(struct drm_vblank_crtc *vblank);
 void drm_handle_vblank_works(struct drm_vblank_crtc *vblank);
+bool drm_crtc_vblank_is_off(struct drm_crtc *crtc);
 
 /* IOCTLS */
 int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f78bf37f1e0a7..983c131b23694 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2318,3 +2318,20 @@ void drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 	*vblank_time = ktime_sub(*vblank_time, vtimer->interval);
 }
 EXPORT_SYMBOL(drm_crtc_vblank_get_vblank_timeout);
+
+/**
+ * drm_crtc_vblank_is_off - check if vblank is off on a CRTC
+ * @crtc: CRTC in question
+ *
+ * Return true if vblanks is currently turned off via drm_crtc_vblank_off().
+ * Return False otherwise.
+ */
+bool drm_crtc_vblank_is_off(struct drm_crtc *crtc)
+{
+	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
+
+	/* Spinlock adds the necessary barriers */
+	guard(spinlock_irqsave)(&crtc->dev->vbl_lock);
+	return vblank->inmodeset && !vblank->enabled;
+}
+EXPORT_SYMBOL(drm_crtc_vblank_is_off);
-- 
2.53.0

