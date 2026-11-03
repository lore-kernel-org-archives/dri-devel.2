Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C9606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cqyXACz5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095D610F885;
	Tue,  3 Nov 2026 21:38:22 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010011.outbound.protection.outlook.com
 [52.101.193.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8A210F855;
 Tue,  3 Nov 2026 21:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fce7f89jR/W1pSZXv0sKY3M2GrK9sqv39fLugnYiCtb+FuDTCtQLIEhoG3i+KiRRO6BA+mj7fpGvLgPReSc3HtYb5DkeD3OPM90GVkY6AaJxQZ3VIOsKYOqpxU9zRI2EbFROn6aZ+yRGSepTibZwoo630uNZfhvGGKoBhRiyDEJoTcxYnE01QA40tkQfseMzSxHHmWs1NdWcvEZAIf+hWH0kzYvf5YIn/XbbnKFf1Af+po8Kx2Bi6AiheeHHm0t4kuiYwBOjGOvG34cin3yGPgqqixlg55ReCUECUgME0/CSkvloKcf0LC+YqEHu3t8jEdR21+cyP9GE96SJydOMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExFLxr/5NI2Zg8CD+OdDYq/IBr9lCmoZVhfhtIsL8jk=;
 b=vK0F/TFTvhSJeXevTglKYBvMR7RjIS/zlaAlEEm2O3GLAFzWQBTRyhyyLLsuYEo7j7QpolIkU/iiT2/fraHNlW7dIuVbycMpBM+VxzYQuuXQaw5r9zxGqQKlgRbvRZCIRiOfRull7wUjbF/O4O6pM5Irj53QfesQ+PFn4oqI4JBgQT62dmSdBZzSq4vyuWhr5lKNC9S7EAQOwnF2L3rZIRj8g/VlKsw3qmcPoDazs+FKvN7AhFyRkJTKujCYBpfpoKIoDxFTV/aG4u6CRyVxWZkbdBXfryiGkoyDf8eCIwEEZCK3HNLBK2BRIMW+pgFbbbP90A8mtb3XKA6L8qMMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExFLxr/5NI2Zg8CD+OdDYq/IBr9lCmoZVhfhtIsL8jk=;
 b=cqyXACz5ic9lAnYwtS8RT28QubiJMzUmXdmDh/00PI0GBmaD7uSXC6vHmE1URx8HpxPxjsqoqqtTR4YD4rqtqNfAApcH13/xKYiGZ33CaWHlNASl974bGCzlONIA6uy1CzF2aYN6gQex2ptEaRrskBaJPS4XCMXNGQrDRbl1v00=
Received: from BN1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:408:e2::9)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:38:09 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::76) by BN1PR13CA0004.outlook.office365.com
 (2603:10b6:408:e2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:05 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:05 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 05/13] drm/atomic: add colorop prepare_fb and cleanup_fb
 helper hooks
Date: Tue, 3 Nov 2026 16:37:48 -0500
Message-ID: <20261103213756.618024-6-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: feb08506-1ea1-4cbf-3a0f-08df39f2c0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|261102130727099003|56012099006|261026130827099003|261022105027099003|261022115727099003|261022075727099003|261022113327099003|261021123027099003|261009221227099003|261021121427099003|261026121527099003|261009223027099003|11063799006|261028144727099003|261026135527099003|261026140227099003|261021133027099003|260925021311599003|260925022911599003|261021130227099003|260925021911599003|261021135927099003;
X-Microsoft-Antispam-Message-Info: nKrVSs4FdyR3wrm4W82h36/1IPvme/rJ7WxaWMZhbvS/IjDV8EEOle9zypxN1rR41Hcaj3fp7qcvu2+fsa1kNbo9tfs4Y1RtZtQWMULPzqs2Vrzoq0gGhNMXrhUocZglf1/xD+/hF9OBEISGZhf3Z6xzztm+Sybm21dzmsWG14Txm7/DtT3HzwpqBTvq8N+bBPflPScB79HuTh9AnbX4LJ+N5rvtYTvtEj8UPp2/DnzdRpJjTQb/GOmEB6tFunOmxS3hRoHhAJyyX0b0bjPSLoMPDhmZxH9P3N0EkgbNQWcV4/59XdCEmlzm2BbKEFeUOoDG1Vprcb6NRjBaO2sMnlEhuhkX1Ij5ZttxX+zeF9oEaCL8UTTnpf96SKh0dEXfbGhBYcWh2G77j5Iq+sRP1MeERbqds9mkbmVRcCFfZJSMeN9zTJ+nCfrsN0Zk8dbepldWPKmixfI5b3WdHsM/SVbquaKCcMlR/pp536iF3i5vKNRJKbv/9pudzD1EoVvHwFIrUAnZMFR3k/x5qiTKedssrKvkpUdKp8q6ZIfazR5d+Mzr03KBBbRhkpKRp3Vy5p4hvLiAhf2Fp3jICJV4GpIeEgkLVJtx2oWq2M79Ojjblb0LPpK23heRgNOfDbsr67vVmhlNp1pllub28Ls0ZaboWk5vpWp5J7W4B2Gn4+XhZFzKgM3Yvstr28jg7M5/azUbpfp1u+H0lQjLlU0Ylw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(261102130727099003)(56012099006)(261026130827099003)(261022105027099003)(261022115727099003)(261022075727099003)(261022113327099003)(261021123027099003)(261009221227099003)(261021121427099003)(261026121527099003)(261009223027099003)(11063799006)(261028144727099003)(261026135527099003)(261026140227099003)(261021133027099003)(260925021311599003)(260925022911599003)(261021130227099003)(260925021911599003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0PcuITK/zVhdSoDd70zqcRT+JlTZ8kOkKd9Jd7Xf08QA+Tovrx1vYP2koumUz9AeDAjEzRAFOeKWHom9KDjte3HMDCJcqXG8AP4FjkOZU0M9QWMl9hXbq8DZq6Emo/E3Gq7h4EMBTpTNQuaOK6A13B5ejnJtyoc4dzmoCOd6yddB9my1r80msJKIrJDU5i1itMr2olVWd4RA4IfcyRsa3L4pD+C7/JlJg9HAoxCDsCDhGMxOGtCOei3KnQcKPl1UJyGQfVSkSwb2T2CBQyPMgW9cjQpC6gGX7teoChnKpJmePvcc3xCdhBrmIasK2LgE6/TJzv+WwOHZHql0VaUjbNCLueH6/W8TyF/y6XrIE6fMUxejIFFIqhz2tVss286ncWFTQfZw6PC8RQYc+MkO7Fl45EzFoVSlNVNUPie40pxONZhKKI0gQsHWQI2mU9Nq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:08.7894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb08506-1ea1-4cbf-3a0f-08df39f2c0bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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

A DRM_COLOROP_3D_LUT_DMA colorop references a framebuffer through its
FB_ID property. Drivers need to prepare that framebuffer (pin it, wait
for rendering) the same way they prepare plane framebuffers, but the
plane hooks only see the plane state and can't reliably find the
colorop state that was prepared once the commit is swapped or aborted.

Add struct drm_colorop_helper_funcs with prepare_fb and cleanup_fb,
set with drm_colorop_helper_add(). The atomic helpers call them for
each colorop in the commit:

- prepare_fb on the new colorop states from
  drm_atomic_helper_prepare_planes(), before the plane hooks
- cleanup_fb on the old colorop states from
  drm_atomic_helper_cleanup_planes()
- cleanup_fb on the new colorop states from
  drm_atomic_helper_unprepare_planes() and the prepare_planes()
  failure path

Add a fence to drm_colorop_state and drm_gem_colorop_helper_prepare_fb(),
which extracts the implicit write fence from the colorop framebuffer.
If the colorop's plane has an explicit IN_FENCE_FD fence, only kernel
fences are extracted, as in drm_gem_plane_helper_prepare_fb(). It is
the default prepare_fb for GEM drivers. drm_atomic_helper_wait_for_fences()
waits on colorop fences after the plane fences.

Add for_each_old_colorop_in_state() for the cleanup path.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic_helper.c      | 93 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_colorop.c            |  8 ++
 drivers/gpu/drm/drm_gem_atomic_helper.c  | 81 +++++++++++++++++++++
 include/drm/drm_atomic.h                 | 20 +++++
 include/drm/drm_colorop.h                | 15 ++++
 include/drm/drm_gem_atomic_helper.h      | 11 +++
 include/drm/drm_modeset_helper_vtables.h | 62 ++++++++++++++++
 7 files changed, 290 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9d006f98413a..ccd182d58875 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1786,6 +1786,8 @@ static void set_fence_deadline(struct drm_device *dev,
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	ktime_t vbltime = 0;
 	int i;
 
@@ -1814,6 +1816,12 @@ static void set_fence_deadline(struct drm_device *dev,
 			continue;
 		dma_fence_set_deadline(new_plane_state->fence, vbltime);
 	}
+
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		if (!new_colorop_state->fence)
+			continue;
+		dma_fence_set_deadline(new_colorop_state->fence, vbltime);
+	}
 }
 
 /**
@@ -1828,6 +1836,8 @@ static void set_fence_deadline(struct drm_device *dev,
  * drm_atomic_helper_swap_state() so it uses the current plane state (and
  * just uses the atomic state to find the changed planes)
  *
+ * Fences stashed in &drm_colorop_state.fence are waited on as well.
+ *
  * Note that @pre_swap is needed since the point where we block for fences moves
  * around depending upon whether an atomic commit is blocking or
  * non-blocking. For non-blocking commit all waiting needs to happen after
@@ -1843,6 +1853,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	int i, ret;
 
 	set_fence_deadline(dev, state);
@@ -1866,6 +1878,18 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 		new_plane_state->fence = NULL;
 	}
 
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		if (!new_colorop_state->fence)
+			continue;
+
+		ret = dma_fence_wait(new_colorop_state->fence, pre_swap);
+		if (ret)
+			return ret;
+
+		dma_fence_put(new_colorop_state->fence);
+		new_colorop_state->fence = NULL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_helper_wait_for_fences);
@@ -2804,6 +2828,49 @@ void drm_atomic_helper_commit_cleanup_done(struct drm_atomic_commit *state)
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_done);
 
+static void colorop_cleanup_fb(struct drm_colorop *colorop,
+			       struct drm_colorop_state *colorop_state)
+{
+	const struct drm_colorop_helper_funcs *funcs = colorop->helper_private;
+
+	if (funcs && funcs->cleanup_fb)
+		funcs->cleanup_fb(colorop, colorop_state);
+}
+
+static int prepare_colorops(struct drm_device *dev,
+			    struct drm_atomic_commit *state)
+{
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
+	int ret, i, j;
+
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		const struct drm_colorop_helper_funcs *funcs = colorop->helper_private;
+
+		if (funcs && funcs->prepare_fb)
+			ret = funcs->prepare_fb(colorop, new_colorop_state);
+		else if (drm_core_check_feature(dev, DRIVER_GEM))
+			ret = drm_gem_colorop_helper_prepare_fb(colorop, new_colorop_state);
+		else
+			ret = 0;
+
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, j) {
+		if (j >= i)
+			continue;
+
+		colorop_cleanup_fb(colorop, new_colorop_state);
+	}
+
+	return ret;
+}
+
 /**
  * drm_atomic_helper_prepare_planes - prepare plane resources before commit
  * @dev: DRM device
@@ -2814,6 +2881,9 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_done);
  * is encountered this function will call &drm_plane_helper_funcs.cleanup_fb on
  * any already successfully prepared framebuffer.
  *
+ * Framebuffers referenced by colorops are prepared first, through
+ * &drm_colorop_helper_funcs.prepare_fb, and cleaned up the same way on failure.
+ *
  * Returns:
  * 0 on success, negative error code on failure.
  */
@@ -2822,6 +2892,8 @@ int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 {
 	struct drm_connector *connector;
 	struct drm_connector_state *new_conn_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
 	int ret, i, j;
@@ -2835,6 +2907,10 @@ int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 			return ret;
 	}
 
+	ret = prepare_colorops(dev, state);
+	if (ret)
+		return ret;
+
 	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
 		const struct drm_plane_helper_funcs *funcs;
 
@@ -2892,6 +2968,9 @@ int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 			funcs->cleanup_fb(plane, new_plane_state);
 	}
 
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, j)
+		colorop_cleanup_fb(colorop, new_colorop_state);
+
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_prepare_planes);
@@ -2905,12 +2984,16 @@ EXPORT_SYMBOL(drm_atomic_helper_prepare_planes);
  * atomic state. It undoes the effects of drm_atomic_helper_prepare_planes()
  * when aborting an atomic commit. For cleaning up after a successful commit
  * use drm_atomic_helper_cleanup_planes().
+ *
+ * &drm_colorop_helper_funcs.cleanup_fb is called for the new colorop states.
  */
 void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
 					struct drm_atomic_commit *state)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	int i;
 
 	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
@@ -2926,6 +3009,9 @@ void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
 		if (funcs->cleanup_fb)
 			funcs->cleanup_fb(plane, new_plane_state);
 	}
+
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
+		colorop_cleanup_fb(colorop, new_colorop_state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_unprepare_planes);
 
@@ -3204,12 +3290,16 @@ EXPORT_SYMBOL(drm_atomic_helper_disable_planes_on_crtc);
  * This function may not be called on the new state when the atomic update
  * fails at any point after calling drm_atomic_helper_prepare_planes(). Use
  * drm_atomic_helper_unprepare_planes() in this case.
+ *
+ * &drm_colorop_helper_funcs.cleanup_fb is called for the old colorop states.
  */
 void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
 				      struct drm_atomic_commit *state)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *old_colorop_state;
 	int i;
 
 	for_each_old_plane_in_state(state, plane, old_plane_state, i) {
@@ -3218,6 +3308,9 @@ void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
 		if (funcs->cleanup_fb)
 			funcs->cleanup_fb(plane, old_plane_state);
 	}
+
+	for_each_old_colorop_in_state(state, colorop, old_colorop_state, i)
+		colorop_cleanup_fb(colorop, old_colorop_state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_cleanup_planes);
 
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 3fc7884befbf..4fe2bd98fb94 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -24,6 +24,8 @@
  *
  */
 
+#include <linux/dma-fence.h>
+
 #include <drm/drm_colorop.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -483,6 +485,9 @@ EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
  * userspace select one via LUT_3D_FORMAT, and points FB_ID at the
  * framebuffer holding the LUT data.
  *
+ * Drivers that need to pin the framebuffer set &drm_colorop_helper_funcs with
+ * drm_colorop_helper_add().
+ *
  * @return zero on success, -E value on failure
  */
 int drm_plane_colorop_3dlut_dma_init(struct drm_device *dev, struct drm_colorop *colorop,
@@ -624,6 +629,7 @@ static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colo
 							struct drm_colorop_state *state)
 {
 	memcpy(state, colorop->state, sizeof(*state));
+	state->fence = NULL;
 
 	if (state->data)
 		drm_property_blob_get(state->data);
@@ -659,6 +665,8 @@ static void __drm_atomic_helper_colorop_destroy_state(struct drm_colorop_state *
 	drm_property_blob_put(state->data);
 	if (state->fb)
 		drm_framebuffer_put(state->fb);
+	if (state->fence)
+		dma_fence_put(state->fence);
 }
 
 void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index c952cfed84c1..7497c2725e22 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -4,8 +4,10 @@
 #include <linux/dma-fence-chain.h>
 #include <linux/export.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_colorop.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -175,6 +177,85 @@ int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane,
 }
 EXPORT_SYMBOL_GPL(drm_gem_plane_helper_prepare_fb);
 
+/*
+ * Colorop Helpers
+ */
+
+/**
+ * drm_gem_colorop_helper_prepare_fb() - Prepare a GEM backed colorop framebuffer
+ * @colorop: Colorop
+ * @state: Colorop state the fence will be attached to
+ *
+ * This is the colorop counterpart of drm_gem_plane_helper_prepare_fb(). It
+ * extracts the write fence from &drm_colorop_state.fb and stores it in
+ * &drm_colorop_state.fence for drm_atomic_helper_wait_for_fences() to wait on.
+ *
+ * If the colorop's plane has an explicit fence set through IN_FENCE_FD, only
+ * kernel fences are extracted, matching drm_gem_plane_helper_prepare_fb().
+ * This relies on being called before the plane's prepare_fb, which adds
+ * implicit fences to &drm_plane_state.fence.
+ *
+ * This function is the default implementation for GEM drivers of
+ * &drm_colorop_helper_funcs.prepare_fb if no callback is provided.
+ *
+ * Returns:
+ * 0 on success, negative error code on failure.
+ */
+int drm_gem_colorop_helper_prepare_fb(struct drm_colorop *colorop,
+				      struct drm_colorop_state *state)
+{
+	enum dma_resv_usage usage = DMA_RESV_USAGE_WRITE;
+	struct drm_plane_state *plane_state;
+	struct dma_fence *fence = NULL;
+	size_t i;
+	int ret;
+
+	if (!state->fb)
+		return 0;
+
+	plane_state = drm_atomic_get_new_plane_state(state->state, colorop->plane);
+	if (plane_state && plane_state->fence)
+		usage = DMA_RESV_USAGE_KERNEL;
+
+	for (i = 0; i < state->fb->format->num_planes; ++i) {
+		struct drm_gem_object *obj = drm_gem_fb_get_obj(state->fb, i);
+		struct dma_fence *new;
+
+		if (!obj) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		ret = dma_resv_get_singleton(obj->resv, usage, &new);
+		if (ret)
+			goto error;
+
+		if (new && fence) {
+			struct dma_fence_chain *chain = dma_fence_chain_alloc();
+
+			if (!chain) {
+				dma_fence_put(new);
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			dma_fence_chain_init(chain, fence, new, 1);
+			fence = &chain->base;
+		} else if (new) {
+			fence = new;
+		}
+	}
+
+	dma_fence_put(state->fence);
+	state->fence = fence;
+	return 0;
+
+error:
+	dma_fence_put(fence);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_gem_colorop_helper_prepare_fb);
+
 /*
  * Shadow-buffered Planes
  */
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..80259ded0efc 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1127,6 +1127,26 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 			      (new_colorop_state) = (__state)->colorops[__i].new_state,\
 			      (void)(new_colorop_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
+/**
+ * for_each_old_colorop_in_state - iterate over all colorops in an atomic update
+ * @__state: &struct drm_atomic_commit pointer
+ * @colorop: &struct drm_colorop iteration cursor
+ * @old_colorop_state: &struct drm_colorop_state iteration cursor for the old state
+ * @__i: int iteration cursor, for macro-internal use
+ *
+ * This iterates over all colorops in an atomic update, tracking only the old
+ * state. This is useful in disable functions, where we need the old state the
+ * hardware is still in.
+ */
+#define for_each_old_colorop_in_state(__state, colorop, old_colorop_state, __i) \
+	for ((__i) = 0;							\
+	     (__i) < (__state)->dev->mode_config.num_colorop;		\
+	     (__i)++)							\
+		for_each_if ((__state)->colorops[__i].ptr &&		\
+			     ((colorop) = (__state)->colorops[__i].ptr,	\
+			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
+			      (old_colorop_state) = (__state)->colorops[__i].old_state, 1))
+
 /**
  * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update
  * @__state: &struct drm_atomic_commit pointer
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 95922eb1044c..36afe9c7c298 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -31,6 +31,8 @@
 #include <drm/drm_mode.h>
 #include <drm/drm_property.h>
 
+struct dma_fence;
+struct drm_colorop_helper_funcs;
 struct drm_framebuffer;
 
 /* DRM colorop flags */
@@ -330,6 +332,16 @@ struct drm_colorop_state {
 	 */
 	struct drm_framebuffer *fb;
 
+	/**
+	 * @fence:
+	 *
+	 * Optional fence to wait for before @fb is used by the hardware. Set
+	 * by &drm_colorop_helper_funcs.prepare_fb, typically through
+	 * drm_gem_colorop_helper_prepare_fb(), and consumed by
+	 * drm_atomic_helper_wait_for_fences(). Not copied on duplicate.
+	 */
+	struct dma_fence *fence;
+
 	/** @state: backpointer to global drm_atomic_commit */
 	struct drm_atomic_commit *state;
 };
@@ -548,6 +560,9 @@ struct drm_colorop {
 
 	/** @funcs: colorop control functions */
 	const struct drm_colorop_funcs *funcs;
+
+	/** @helper_private: mid-layer private data */
+	const struct drm_colorop_helper_funcs *helper_private;
 };
 
 #define obj_to_colorop(x) container_of(x, struct drm_colorop, base)
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index f605a8a7b017..f2141226535d 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -9,12 +9,23 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane.h>
 
+struct drm_colorop;
+struct drm_colorop_state;
+struct drm_simple_display_pipe;
+
 /*
  * Plane Helpers
  */
 
 int drm_gem_plane_helper_prepare_fb(struct drm_plane *plane, struct drm_plane_state *state);
 
+/*
+ * Colorop Helpers
+ */
+
+int drm_gem_colorop_helper_prepare_fb(struct drm_colorop *colorop,
+				      struct drm_colorop_state *state);
+
 /*
  * Helpers for planes with shadow buffers
  */
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 60b30cc26940..821b051f5632 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -29,6 +29,7 @@
 #ifndef __DRM_MODESET_HELPER_VTABLES_H__
 #define __DRM_MODESET_HELPER_VTABLES_H__
 
+#include <drm/drm_colorop.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
 
@@ -1534,6 +1535,67 @@ static inline void drm_plane_helper_add(struct drm_plane *plane,
 	plane->helper_private = funcs;
 }
 
+/**
+ * struct drm_colorop_helper_funcs - helper operations for colorops
+ *
+ * These functions are used by the atomic helpers for colorops that reference
+ * a framebuffer, such as &DRM_COLOROP_3D_LUT_DMA.
+ */
+struct drm_colorop_helper_funcs {
+	/**
+	 * @prepare_fb:
+	 *
+	 * This hook prepares &drm_colorop_state.fb for use by the hardware,
+	 * e.g. by pinning it in memory. It can also extract an implicit fence
+	 * into &drm_colorop_state.fence, see drm_gem_colorop_helper_prepare_fb().
+	 *
+	 * It is called from drm_atomic_helper_prepare_planes() for each colorop
+	 * in the commit, before the &drm_plane_helper_funcs.prepare_fb hooks.
+	 * Whatever it sets up must depend only on @new_state, since
+	 * @cleanup_fb only gets the colorop state to undo it.
+	 * If this hook returns an error, it must undo any resources it acquired
+	 * before returning; @cleanup_fb is called only when preparation
+	 * succeeded.
+	 *
+	 * If not set, GEM drivers get drm_gem_colorop_helper_prepare_fb().
+	 *
+	 * This function must not block for outstanding rendering, since it is
+	 * called in the context of the atomic IOCTL even for nonblocking
+	 * commits. Set &drm_colorop_state.fence instead.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success or one of the negative error codes allowed by the
+	 * &drm_mode_config_funcs.atomic_commit vfunc.
+	 */
+	int (*prepare_fb)(struct drm_colorop *colorop,
+			  struct drm_colorop_state *new_state);
+
+	/**
+	 * @cleanup_fb:
+	 *
+	 * This hook undoes @prepare_fb for a colorop state. It is called for
+	 * the old colorop states after a commit, and for the new colorop states
+	 * when a commit is aborted after @prepare_fb. It is called only for
+	 * colorop states whose preparation succeeded.
+	 *
+	 * This callback is optional.
+	 */
+	void (*cleanup_fb)(struct drm_colorop *colorop,
+			   struct drm_colorop_state *old_state);
+};
+
+/**
+ * drm_colorop_helper_add - sets the helper vtable for a colorop
+ * @colorop: DRM colorop
+ * @funcs: helper vtable to set for @colorop
+ */
+static inline void drm_colorop_helper_add(struct drm_colorop *colorop,
+					  const struct drm_colorop_helper_funcs *funcs)
+{
+	colorop->helper_private = funcs;
+}
+
 /**
  * struct drm_mode_config_helper_funcs - global modeset helper operations
  *
-- 
2.56.0

