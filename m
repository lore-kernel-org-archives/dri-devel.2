Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D61F483FC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412C810E47A;
	Mon, 23 Mar 2026 20:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dRqtu8fU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA01510E4DB;
 Mon, 23 Mar 2026 20:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARlYjg4Na3ZPutkUGjVPWN70WwnReGPmyXkaU7ja7Amo2S5UW2uzfUki3KGoQYBAh0poMrYKnDOq1ucwjekou2ZlE6D0oQwsc2XzFieJZQ+fHjxf1NztvNAPa/26xf1N/CRmWOaBl+idR9bcOD27ibdxhYkwc87OsUG6tNf7nXh9A4o/RaV3J99Y8BHlw++zO20+m4mFmjp9oeRTzaZ1AzsicF7ZLqj9BFKNualGOL65rik3nwnmd5XFceSa48PFWvfQqHr2QFIHJ048413FzRt7si6eRUaP8kZQ5haQM4HGc7YEwbY1YnKSO5kqkh5fP3UMzzObaisbcsDio3tgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBBU0IvdK/KNPOanmAyegpeln0LccqYcTffUHfdMqk4=;
 b=oQ3FWV/oAZnbLcPdi3Ju+ndtWcPhgaipB5OaB4S4ZdvYj0fzMImvyx/IfmD6FfDuw8pPKbQOWG20CYol5wP23cG9g1GhQaMbDS8v/ULg3qYL+qhEjRdOLhPXDUXFspAb4EgIfZYmAsgITXhpMebncG+dsb1qvCP+igY90TgQAkXvEgmW15Eb+jyYBnjEHxpC/jnAllo8exWU/cW8GYr8dgWBQ4qlATbD8yWG/uyaW/OO/ajnlDAo40ns0xwosRWVeQ8jItJPU5bVpIabDK95YV5ur+ZrUh3yFsXvBf2KjmlNDOQ6SBt6wF7UL+PZn7rxb6YX4X3PUlGpKzeM98Q7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBBU0IvdK/KNPOanmAyegpeln0LccqYcTffUHfdMqk4=;
 b=dRqtu8fUNqUMum9kVwmCF34pOSErlL0Q5MEdDm3jP5RqTTuwwkgo7MSE0o8JMEX25++wGwH+AfiY9+vOQe+l5CfVEJ8b/RXardKz427s9+uPgmrkKLS27vPsMFpDqZDXgaZrEQ9q/RvT1y3dChxQIp3lNu3TeEtTNVtf0jfLnBk=
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 20:30:17 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::c6) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:30:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:15 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Mon, 23 Mar 2026 15:30:15 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <simona@ffwll.ch>, <airlied@gmail.com>,
 <jani.nikula@linux.intel.com>, <ville.syrjala@linux.intel.com>,
 <superm1@kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 4/5] drm/amd/display: Implement deferred vblanks on IPS
 platforms
Date: Mon, 23 Mar 2026 16:27:54 -0400
Message-ID: <20260323202755.315929-5-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323202755.315929-1-sunpeng.li@amd.com>
References: <20260323202755.315929-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e40c6b-f5f4-448e-d068-08de891afe68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1I1+zCJVDusRxiMkopxLxa+MIcvbs4tgMxpPTRlTM78XaNaT84A/rivcTMwquHfMZ0qx23xQ++ZsaNuwouRspL85SiEc4rJdj4+Nz+Ij6n9Hnq/XNDMOrT6T7iTbHhog6HEBHpF/yuxCzPo1C6ZJwG42/YkFqeJB3UnYT6RTiL9ta6s51m4s9wn/3HGep5Pqg8oHvFwCjT+eyk9bveYpK9azbPC4g1jNgzXM7GoH+mVWhuvyt5HlF45mdrdVV6KfbA535GDBlGClOlNmjMUMrHUlUn1KgYm2hhiL/ivdg8vV/ktus4KMsIcaemygRCJAeg8E4H/LKLW3VW6SGfVzxwbOBP52D/qrlCObhuFlWwr4PScl8i7fWQZwTwJaX7R8Wz42NGr5wFgmZlX0kIWo3KHWvc+SdJb0cAuV9N/C4CFMwSkR1b560T/XO82Aq6RDM8yjV2r2UQG/syXh62Mv1UOthJpdQ5UbdifLzlJaQ9yY4/GGetQFheQKd4nIPtHPwu8mGQfukTtMdM6C86G8DQHD0uhvSPC51bV8bRTUCLTWWA9qcmjoFVz5yRSi8/L084MWb7XCPkF6ZeAzrT7J7IcaNrmT+zl4sbS8z83JXpcpUCchs8eiDgOtS8lyTw2YoxQ4C3YSuKAtcpQJ1y5IEKVTTtCG1YW2Ua6JVRbMQIH+bl/XRyQU/iAy6tZ0Ec20lqPCb6ex49L5EIxd1R7aRdPKuCxTWiNUGkbPC4vWjjnsucx0E4KcSDf3tj52wXW2ULllMJ2vlPMGfaLIj4c8zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lIOLDTqPUlQwd0qpeyy1novdydAYtwEeRpDD/UaCexHBA4a4ZAA37euVwrNNOlhy15iidQubCq1vyUi/QkAHmc3KZk+GxnnLaFJkSW+9CGYEgYj8mpQCvmHDcJFmWH6MU26gpl3wIR8Kd1T1tqDAKd+WsY7IUKMiQ+VUbR4Bs6H9zTd1ZuZ+u/tWy/Aw6jjE6LiwZZK5yiT+NE0HH31GnZ4kqGkftfh7zz8lB340sUuKlSBM6EO8ISs2gJ5Qh/NShBcRMRCkBkPHC4LPa1nuZfcNPlClmTp+N642Wb9TwW+NMDHeQDp1Q5ybYCbPzVhJmniztRjj9VJZFlg8+uVFH105yf/udtHodFFHX82mxRAod6e8+DU/pvlIYY5tfNAUdxaOIxsyqjtyhauzykv8T6j4tUZtwBy446N+CdA8cP9Hlnc3Wb5s4ruyWq568AS8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:30:16.3173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e40c6b-f5f4-448e-d068-08de891afe68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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

[Why]

Newer generations of Display Core Next (DCN) hardware allow for the
entire DCN block to be power-gated in a feature called Idle Power States
(IPS). Once DCN is in IPS, HW register access will timeout. Therefore,
allowing/disallowing IPS requires synchronization with the rest of the
driver through the big dc_lock mutex. It happens that writing vblank
interrupt control and reading counter/scanout position registers
requires IPS disallow. Since that requires the dc_lock, it turns into a
blocking operation.

The immediately obvious (not)solution is to disable IPS. But since it
provides sizable power savings, and it's not going away for future APUs,
it's not a good option.

The other (non)solution is to get rid of the dc_lock or make it not
block. But since all hardware (HW) and Display Micro-controller (DMCU)
access is invalid when DCN is in IPS (because everything is gated), it
needs to be synchronized with all other HW/DMCU access. It happens that
the dc_lock is responsible for that. I don't think replacing it with a
spinlock is a valid solution either. Consider link training: IPS cannot
be allowed while that is happening, yet the timescale of link training
can be in the 100ms. A spinlock would spin too long here.

So let's implement the newly introduced deferred vblank enable/disable
callbacks in DRM vblank core.

[How]

Implement the deferred CRTC callbacks to request the DRM vblank core to
defer vblank enable/disable. Only implement for ASICs that have IPS
support. Otherwise, keep the non-deferred behavior.

To ensure interrupts are enabled before programming flips (otherwise the
page flip interrupt for event delivery may not fire), call
drm_crtc_vblank_wait_deferred_enable() in the commit_planes code when
getting a reference on vblanks.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 178 +++++++++++++++++-
 2 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fc5e0bf121d22..76cd50036db92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10208,6 +10208,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				&acrtc_attach->dm_irq_params.vrr_params.adjust);
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
+
+		/*
+		 * If vblank is being enabled in worker thread, wait for it to
+		 * enable interrupts before programming pflips, otherwise the
+		 * interrupt may not fire.
+		 */
+		drm_crtc_vblank_wait_deferred_enable(pcrtc);
+
 		mutex_lock(&dm->dc_lock);
 		update_planes_and_stream_adapter(dm->dc,
 					 acrtc_state->update_type,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e6727d5098863..6ea99ad9c4b36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -453,6 +453,141 @@ static void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 						 acrtc_state, false);
 }
 
+/*
+ * Deferred vblank enable/disable works differently: the drm vblank core manages
+ * the workqueue instead of amdgpu_dm, sandwiching the vblank_enable/disable()
+ * with the crtc pre/post callbacks. Therefore, they need to be sequenced
+ * differently from their non-deferred variants.
+ */
+
+static int amdgpu_dm_crtc_deferred_enable_vblank(struct drm_crtc *crtc)
+{
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	int ret;
+
+	ret = amdgpu_dm_crtc_set_vblank(crtc, true);
+	if (!ret)
+		dm->active_vblank_irq_count++;
+
+	return ret;
+}
+
+static void amdgpu_dm_crtc_deferred_disable_vblank(struct drm_crtc *crtc)
+{
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
+	amdgpu_dm_crtc_set_vblank(crtc, false);
+
+	if (dm->active_vblank_irq_count)
+		dm->active_vblank_irq_count--;
+}
+
+
+static void amdgpu_dm_crtc_pre_enable_vblank(struct drm_crtc *crtc)
+{
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
+	mutex_lock(&dm->dc_lock);
+	dc_allow_idle_optimizations(dm->dc, false);
+}
+
+static void amdgpu_dm_crtc_post_enable_vblank(struct drm_crtc *crtc)
+{
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct vblank_control_work vblank_work = { 0 };
+
+	/* If crtc disabled, skip panel optimizations exit */
+	if (!crtc->enabled) {
+		mutex_unlock(&dm->dc_lock);
+		return;
+	}
+
+	vblank_work.dm = dm;
+	vblank_work.acrtc = acrtc;
+	vblank_work.enable = true;
+	if (acrtc_state->stream) {
+		dc_stream_retain(acrtc_state->stream);
+		vblank_work.stream = acrtc_state->stream;
+	}
+
+	/*
+	 * Control PSR based on vblank requirements from OS
+	 *
+	 * If panel supports PSR SU, there's no need to disable PSR when OS is
+	 * submitting fast atomic commits (we infer this by whether the OS
+	 * requests vblank events). Fast atomic commits will simply trigger a
+	 * full-frame-update (FFU); a specific case of selective-update (SU)
+	 * where the SU region is the full hactive*vactive region. See
+	 * fill_dc_dirty_rects().
+	 */
+	if (vblank_work.stream && vblank_work.stream->link && vblank_work.acrtc) {
+		amdgpu_dm_crtc_set_panel_sr_feature(
+			&vblank_work, true,
+			vblank_work.acrtc->dm_irq_params.allow_sr_entry);
+	}
+
+	if (vblank_work.stream)
+		dc_stream_release(vblank_work.stream);
+
+	mutex_unlock(&dm->dc_lock);
+}
+
+static void amdgpu_dm_crtc_pre_disable_vblank(struct drm_crtc *crtc)
+{
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
+	mutex_lock(&dm->dc_lock);
+}
+
+static void amdgpu_dm_crtc_post_disable_vblank(struct drm_crtc *crtc)
+{
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct vblank_control_work vblank_work = { 0 };
+	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
+
+	/* If a vblank_get got ahead of us (can happen when !disable_immediate),
+	 * skip panel optimizations
+	 */
+	if (atomic_read(&vblank->refcount) > 0) {
+		mutex_unlock(&dm->dc_lock);
+		return;
+	}
+
+	vblank_work.dm = dm;
+	vblank_work.acrtc = acrtc;
+	vblank_work.enable = false;
+	if (acrtc_state->stream) {
+		dc_stream_retain(acrtc_state->stream);
+		vblank_work.stream = acrtc_state->stream;
+	}
+
+	if (vblank_work.stream && vblank_work.stream->link && vblank_work.acrtc) {
+		amdgpu_dm_crtc_set_panel_sr_feature(
+			&vblank_work, false,
+			vblank_work.acrtc->dm_irq_params.allow_sr_entry);
+	}
+
+	if (vblank_work.stream)
+		dc_stream_release(vblank_work.stream);
+
+	if (dm->active_vblank_irq_count == 0) {
+		dc_post_update_surfaces_to_stream(dm->dc);
+		dc_allow_idle_optimizations(dm->dc, true);
+	}
+
+	mutex_unlock(&dm->dc_lock);
+}
+
 static void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state)
 {
@@ -622,6 +757,33 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
 #endif
 };
 
+static const struct drm_crtc_funcs amdgpu_dm_crtc_deferred_vblank_funcs = {
+	.reset = amdgpu_dm_crtc_reset_state,
+	.destroy = amdgpu_dm_crtc_destroy,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = amdgpu_dm_crtc_duplicate_state,
+	.atomic_destroy_state = amdgpu_dm_crtc_destroy_state,
+	.set_crc_source = amdgpu_dm_crtc_set_crc_source,
+	.verify_crc_source = amdgpu_dm_crtc_verify_crc_source,
+	.get_crc_sources = amdgpu_dm_crtc_get_crc_sources,
+	.get_vblank_counter = amdgpu_get_vblank_counter_kms,
+	.enable_vblank = amdgpu_dm_crtc_deferred_enable_vblank,
+	.disable_vblank = amdgpu_dm_crtc_deferred_disable_vblank,
+	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
+#if defined(CONFIG_DEBUG_FS)
+	.late_register = amdgpu_dm_crtc_late_register,
+#endif
+#ifdef AMD_PRIVATE_COLOR
+	.atomic_set_property = amdgpu_dm_atomic_crtc_set_property,
+	.atomic_get_property = amdgpu_dm_atomic_crtc_get_property,
+#endif
+	.pre_enable_vblank = amdgpu_dm_crtc_pre_enable_vblank,
+	.post_enable_vblank = amdgpu_dm_crtc_post_enable_vblank,
+	.pre_disable_vblank = amdgpu_dm_crtc_pre_disable_vblank,
+	.post_disable_vblank = amdgpu_dm_crtc_post_disable_vblank,
+};
+
 static void amdgpu_dm_crtc_helper_disable(struct drm_crtc *crtc)
 {
 }
@@ -754,6 +916,7 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 			       struct drm_plane *plane,
 			       uint32_t crtc_index)
 {
+	const struct drm_crtc_funcs *crtc_funcs;
 	struct amdgpu_crtc *acrtc = NULL;
 	struct drm_plane *cursor_plane;
 	bool has_degamma;
@@ -770,12 +933,25 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	if (!acrtc)
 		goto fail;
 
+	/*
+	 * Only enable deferred vblank enable/disable for ASICs with IPS
+	 * support
+	 */
+	if (dm->dc->caps.ips_support) {
+		crtc_funcs = &amdgpu_dm_crtc_deferred_vblank_funcs;
+		drm_dbg_driver(dm->ddev,
+			       "Initializing CRTC %d with deferred vBlank enable/disable\n",
+			       crtc_index);
+	} else {
+		crtc_funcs = &amdgpu_dm_crtc_funcs;
+	}
+
 	res = drm_crtc_init_with_planes(
 			dm->ddev,
 			&acrtc->base,
 			plane,
 			cursor_plane,
-			&amdgpu_dm_crtc_funcs, NULL);
+			crtc_funcs, NULL);
 
 	if (res)
 		goto fail;
-- 
2.53.0

