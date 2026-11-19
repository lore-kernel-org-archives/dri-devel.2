Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77460A260D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=akYyBiyB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C251127DA;
	Thu, 19 Nov 2026 23:28:13 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E881127B5;
 Thu, 19 Nov 2026 23:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXMI9dtHIWIH2+QFWx160tZuk+0uTnEE0P1/QE2d4PqUPi9dOogwDD1vVw/ERaxOInqtay2HIIYHrkbmpkRJU4kKl+KD1fizYb0TnGjV8nBr3p9kVzTQmPXqWAiRSD+ZYexVs7G1iUuIWsJ4eZCJEw6Pj+uzYNMEdbSR1PWGt8uxUuJrR0cPyaPs6a5wDL//NaUkm1HbLolXrgkVN9Ks5Sj/9qXdKDPe4VCmzEqZSEKS4vRIGQKeOff9r53ZPDLR7rWfgylZJhENpCf3gOW/1O9cgec7EYl3ZzN8A8aByrbWkKmnwH+dyNs6LpFAFVCdomRvEJOsHANcDE7Pq+shJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ/TL6bJ6hC74ln0gT6Pj0+BkpcVRMwtu4QsdLPu4/w=;
 b=xjtUZz3+fSa+GJTHzlDGG2auuwm/Ogh5u0BI6eVPROnNqIDMpZjgnuC4nf5fWm6kJHCNV3GNvuC35ELbWBi9vbmvINNZh29YrTmijQchihLE8Yc+8h57u1pfx29lyibyfXDkDVsl6TAE38hcBFlEV1cbwjhqMX6ojolvEfFziMjfhGte5oP9VI8sT9VfIHeBn+5FSm2MCj5hspx7lM4f6JIVDxIhOGkCh0gzhYugYZrm/WN0HLHU4afJnUd2pq0L49xKrkor2ioG672xUjaZALnkvfmnczNqiKJeCV+HbwEDlfO4PzeChLC7kGn47KZbvW4QZ6NX8vGEjev/JbEXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ/TL6bJ6hC74ln0gT6Pj0+BkpcVRMwtu4QsdLPu4/w=;
 b=akYyBiyBO3JEzbfd7eDuEZbAZf1vAdoGZhyJV0j6kBi9JrkxZnFULzS4iZkoHxvcjL1ftQFrpGZWE+LzTb6j0o+Q6NfT6fRlkRQiAZQ94wnntdB8TXiitzGosNomFV0mriTkMqRAPEqylZ8PY5PVqZsg+6rvMwjD3cOsej2w/Fo=
Received: from PH0PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:e::10)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 23:28:00 +0000
Received: from PH7PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::2a) by PH0PR07CA0035.outlook.office365.com
 (2603:10b6:510:e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 23:27:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000009.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:36 -0600
Subject: [PATCH v12 09/12] drm/nouveau: add connector luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-9-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
In-Reply-To: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
To: Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>
CC: Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000009:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f1652c-28b8-40be-f4cc-08df4694beff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|921020|10067099003|261022075727099003|261026121527099003|261026140227099003|56012099006|11063799006|261022105027099003|261009221227099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BeHBqfb/GTgJQ1KMBUDBab5pk4sQBYs4F08b0Qoc2exz/Ai67kCEavceVV/y9gGIGiMx+9EACVwfCNq2Gjs0w7XXA/BltOjdhqmgmZJZwkbCANoQxA0pMLpP/y4otSSmM7BLRa/E6IwYp9nna3cpnm820EnxF7XCpDoepXOmfBxacITsMVKUgr1n11P9gT9YXqroeS1bMTFA4yEzzhY7kibjIf9smdDFM1wJtKYiFXOSRgMM+eP1ovGES4g2/JyxoaDdPeZcYtkaRHAk/+cgxh7jtqYXZHvooAIX4sjABewnXxxOUo+xh2GaZ2cVJWL2ElwzGn+LGq80+AoB9NRMNbhW+txiLqM3bmArUPik77TLTq0n1clXC54LUmuGZJC44F6ulNAIG/c5dOxidrgQzL4NvKF/MuwdPMLutMnFZ1H2zfUZIdzAhNEl+Gjjma3n3mMMQCwhwc1w6EsyCC8iuHfSLbkvtlJYZ5Ujz1WFKKIrsx83KBKotLjiTQNhdaRdjSW8bDSdOySLPXkqHzOH30foijVX9rbB+dgvXxxv/LFAF2lJYBh76FGl7jmoHoeAGHhbC1YwKP43HLXqrkOXBzjF0v20VUjUzwPQqvxF0Jfzp4MM81dJF4gpYjPyAbFiUyN2gYVFGq4hFEZbbZHgE20GWV3mZ4fiZPYyJgNevZwrlAcSycJq/bOkThGl7t/AQqoHLXl0/EfGOuauQo9Jrvvx9MUr7N+bKfC/i6+CT6pGI+eaN9tA8TW8LLJMDJEm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(921020)(10067099003)(261022075727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(261022105027099003)(261009221227099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LLgpHP/aVD6Z7c44QK+vmq9cR8+0rygI26tbFDC8KguSXWmWm69ni/Y3CVa2uMQeVtgVV1On/ZQE+XmvjXZndVjLjAOpEsns23uvSNc3cpY5m7tJmoR9oKEBhxqgiKLMQeTVpYAcTEJ44haiHh8RK8ZnlQyWbiK6whij6ZFaY1USDKkkcGq3+80Adqw/od+QSV3s+u41jx+XkV3FdrSgALC4h2OI/iESNU75nTnZq+zGK5DayzoAFrKzhsRb54ZKwT5VjWaVjlJ/4wuN6hUJdrJJt/N3WH7SyBmMCTQeiidR3DDW0RAByhUgd1GkGTKOuC0IYlEzcKCxhu/ilVDTKIHGKl5drJQjqtAfGGPFUCMmYTfOnPdkRI0wvUdHE5ImbnygApIjjBBmGbs7pRHQNqQynleM0fblbQs8JHjawi3aXco4MUHmZPaSR8MVQ66+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:58.2269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f1652c-28b8-40be-f4cc-08df4694beff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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

Expose Nouveau panel brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled and atomic modesetting is exposed. Reuse
the existing NV50 and DPCD hardware paths while preserving the backlight
class interface otherwise, including for pre-NV50 displays.

The panel backlight is probed and the property attached before the DRM
device is registered. The luminance helpers are called from the NV50
atomic commit tail.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

---
v12:
 * Clamp the initial brightness to the maximum before attaching the
   property, an out of range hardware level failed the device probe
   (Sashiko)
v11:
 * Call the luminance commit helpers from nv50_disp_atomic_commit_tail()
   (Sashiko)
 * Attach the property before drm_dev_register() (Sashiko)
 * Keep the class device for non-atomic NV04 and nouveau.atomic=0
   (Sashiko)
 * Fix stale brightness on eDP enable for the class device path (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE (Sashiko)
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  13 ++-
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 154 ++++++++++++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c |   3 +
 drivers/gpu/drm/nouveau/nouveau_connector.h |  23 +++++
 drivers/gpu/drm/nouveau/nouveau_drm.c       |   6 ++
 5 files changed, 176 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db67..57653fe720d95 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1755,6 +1755,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 	struct nouveau_connector *nv_connector;
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight;
+	u16 level;
 #endif
 	struct nvbios *bios = &drm->vbios;
 	bool lvds_dual = false, lvds_8bpc = false, hda = false;
@@ -1836,9 +1837,14 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 		backlight = nv_connector->backlight;
-		if (backlight && backlight->uses_dpcd)
+		if (backlight && backlight->uses_dpcd) {
+			if (backlight->dev)
+				level = backlight->dev->props.brightness;
+			else
+				level = nv_connector->base.state->luminance;
 			drm_edp_backlight_enable(&nv_connector->aux, &backlight->edp_info,
-						 backlight->dev->props.brightness);
+						 level);
+		}
 #endif
 
 		break;
@@ -2188,6 +2194,7 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_commit *state)
 	drm_dp_mst_atomic_wait_for_dependencies(state);
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 	drm_atomic_helper_calc_timestamping_constants(state);
+	drm_atomic_helper_commit_luminance_disables(state);
 
 	if (atom->lock_core)
 		mutex_lock(&disp->mutex);
@@ -2370,6 +2377,8 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_commit *state)
 	if (atom->lock_core)
 		mutex_unlock(&disp->mutex);
 
+	drm_atomic_helper_commit_luminance_enables(state);
+
 	list_for_each_entry_safe(outp, outt, &atom->outp, head) {
 		list_del(&outp->head);
 		kfree(outp);
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index da1ee24a2531d..b3d5289b2abe8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -234,12 +234,15 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 		    const struct backlight_ops **ops)
 {
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
+	int brightness;
+
+	brightness = nvif_outp_bl_get(&nv_encoder->outp);
 
 	/*
 	 * Note when this runs the connectors have not been probed yet,
 	 * so nv_conn->base.status is not set yet.
 	 */
-	if (nvif_outp_bl_get(&nv_encoder->outp) < 0 ||
+	if (brightness < 0 ||
 	    drm_helper_probe_detect(&nv_conn->base, NULL, false) != connector_status_connected)
 		return -ENODEV;
 
@@ -284,11 +287,25 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 
 	*ops = &nv50_bl_ops;
 	props->max_brightness = 100;
+	props->brightness = brightness;
 	return 0;
 }
 
-int
-nouveau_backlight_init(struct drm_connector *connector)
+/*
+ * LUMINANCE is an atomic connector property. Pre-NV50 hardware and
+ * nouveau.atomic=0 don't expose atomic modesetting to userspace (even though
+ * NV50+ still commits atomically internally), so keep the backlight class
+ * device there.
+ */
+static bool
+nouveau_backlight_use_luminance(struct drm_device *dev)
+{
+	return IS_ENABLED(CONFIG_DRM_LUMINANCE) &&
+	       drm_core_check_feature(dev, DRIVER_ATOMIC);
+}
+
+static int
+nouveau_backlight_create(struct drm_connector *connector)
 {
 	struct nouveau_drm *drm = nouveau_drm(connector->dev);
 	struct nouveau_backlight *bl;
@@ -317,6 +334,8 @@ nouveau_backlight_init(struct drm_connector *connector)
 	bl = kzalloc_obj(*bl);
 	if (!bl)
 		return -ENOMEM;
+	bl->id = -1;
+	bl->encoder = nv_encoder;
 
 	switch (device->info.family) {
 	case NV_DEVICE_INFO_V0_CURIE:
@@ -349,26 +368,38 @@ nouveau_backlight_init(struct drm_connector *connector)
 		goto fail_alloc;
 	}
 
-	if (!nouveau_get_backlight_name(backlight_name, bl)) {
-		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
-		goto fail_alloc;
-	}
-
 	props.type = BACKLIGHT_RAW;
-	bl->dev = backlight_device_register(backlight_name, connector->kdev,
-					    nv_encoder, ops, &props);
-	if (IS_ERR(bl->dev)) {
-		if (bl->id >= 0)
-			ida_free(&bl_ida, bl->id);
-		ret = PTR_ERR(bl->dev);
-		goto fail_alloc;
+	if (nouveau_backlight_use_luminance(connector->dev)) {
+		/* The hardware level isn't clamped, but the property requires it */
+		props.brightness = min(props.brightness, props.max_brightness);
+		ret = drm_connector_attach_luminance_property(connector, 0, props.max_brightness,
+							      props.brightness);
+		if (ret)
+			goto fail_alloc;
+	} else {
+		if (!nouveau_get_backlight_name(backlight_name, bl)) {
+			NV_ERROR(drm,
+				 "Failed to retrieve a unique name for the backlight interface\n");
+			goto fail_alloc;
+		}
+
+		bl->dev = backlight_device_register(backlight_name, connector->kdev,
+						    nv_encoder, ops, &props);
+		if (IS_ERR(bl->dev)) {
+			if (bl->id >= 0)
+				ida_free(&bl_ida, bl->id);
+			ret = PTR_ERR(bl->dev);
+			goto fail_alloc;
+		}
 	}
 
 	nouveau_connector(connector)->backlight = bl;
-	if (!bl->dev->props.brightness)
-		bl->dev->props.brightness =
-			bl->dev->ops->get_brightness(bl->dev);
-	backlight_update_status(bl->dev);
+	if (bl->dev) {
+		if (!bl->dev->props.brightness)
+			bl->dev->props.brightness =
+				bl->dev->ops->get_brightness(bl->dev);
+		backlight_update_status(bl->dev);
+	}
 
 	return 0;
 
@@ -384,8 +415,40 @@ nouveau_backlight_init(struct drm_connector *connector)
 	return ret;
 }
 
-void
-nouveau_backlight_fini(struct drm_connector *connector)
+/* Called from .late_register, the backlight class device needs connector->kdev */
+int
+nouveau_backlight_init(struct drm_connector *connector)
+{
+	if (nouveau_backlight_use_luminance(connector->dev))
+		return 0;
+
+	return nouveau_backlight_create(connector);
+}
+
+/* Called before drm_dev_register(), the LUMINANCE property must exist by then */
+int
+nouveau_backlight_luminance_init(struct drm_device *dev)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+	int ret = 0;
+
+	if (!nouveau_backlight_use_luminance(dev))
+		return 0;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
+		ret = nouveau_backlight_create(connector);
+		if (ret)
+			break;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return ret;
+}
+
+static void
+nouveau_backlight_free(struct drm_connector *connector)
 {
 	struct nouveau_connector *nv_conn = nouveau_connector(connector);
 	struct nouveau_backlight *bl = nv_conn->backlight;
@@ -401,6 +464,23 @@ nouveau_backlight_fini(struct drm_connector *connector)
 	kfree(bl);
 }
 
+/* Called from .early_unregister */
+void
+nouveau_backlight_fini(struct drm_connector *connector)
+{
+	/* LUMINANCE state is needed by commits until the connector is destroyed */
+	if (nouveau_backlight_use_luminance(connector->dev))
+		return;
+
+	nouveau_backlight_free(connector);
+}
+
+void
+nouveau_backlight_destroy(struct drm_connector *connector)
+{
+	nouveau_backlight_free(connector);
+}
+
 void
 nouveau_backlight_ctor(void)
 {
@@ -412,3 +492,35 @@ nouveau_backlight_dtor(void)
 {
 	ida_destroy(&bl_ida);
 }
+
+void
+nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct nouveau_connector *nv_connector = nouveau_connector(conn_state->connector);
+	struct nouveau_backlight *bl = nv_connector->backlight;
+	unsigned int luminance = conn_state->luminance;
+
+	if (!bl)
+		return;
+
+	if (bl->uses_dpcd)
+		drm_edp_backlight_set_level(&nv_connector->aux, &bl->edp_info,
+					    luminance);
+	else
+		nvif_outp_bl_set(&bl->encoder->outp, luminance);
+}
+
+void
+nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct nouveau_connector *nv_connector = nouveau_connector(conn_state->connector);
+	struct nouveau_backlight *bl = nv_connector->backlight;
+
+	if (!bl)
+		return;
+
+	if (bl->uses_dpcd)
+		drm_edp_backlight_disable(&nv_connector->aux, &bl->edp_info);
+	else
+		nvif_outp_bl_set(&bl->encoder->outp, 0);
+}
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b0..cbbdd36f49bb7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -400,6 +400,7 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	cancel_work_sync(&nv_connector->irq_work);
 	drm_edid_free(nv_connector->drm_edid);
 	drm_connector_unregister(connector);
+	nouveau_backlight_destroy(connector);
 	drm_connector_cleanup(connector);
 	if (nv_connector->aux.transfer)
 		drm_dp_cec_unregister_connector(&nv_connector->aux);
@@ -1225,6 +1226,8 @@ nouveau_connector_helper_funcs = {
 	.mode_valid = nouveau_connector_mode_valid,
 	.best_encoder = nouveau_connector_best_encoder,
 	.atomic_check = nouveau_connector_atomic_check,
+	.set_luminance = nouveau_backlight_set_luminance,
+	.disable_luminance = nouveau_backlight_disable_luminance,
 };
 
 static const struct drm_connector_funcs
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index eb292d2ba4bcd..f53107ec0bf3f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -50,6 +50,7 @@ struct nouveau_backlight {
 	struct backlight_device *dev;
 
 	struct drm_edp_backlight_info edp_info;
+	struct nouveau_encoder *encoder;
 	bool uses_dpcd : 1;
 
 	int id;
@@ -237,8 +238,12 @@ nouveau_conn_mode_clock_valid(const struct drm_display_mode *,
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 extern int nouveau_backlight_init(struct drm_connector *);
 extern void nouveau_backlight_fini(struct drm_connector *);
+int nouveau_backlight_luminance_init(struct drm_device *dev);
+void nouveau_backlight_destroy(struct drm_connector *connector);
 extern void nouveau_backlight_ctor(void);
 extern void nouveau_backlight_dtor(void);
+void nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state);
+void nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state);
 #else
 static inline int
 nouveau_backlight_init(struct drm_connector *connector)
@@ -250,6 +255,16 @@ static inline void
 nouveau_backlight_fini(struct drm_connector *connector) {
 }
 
+static inline int
+nouveau_backlight_luminance_init(struct drm_device *dev)
+{
+	return 0;
+}
+
+static inline void
+nouveau_backlight_destroy(struct drm_connector *connector) {
+}
+
 static inline void
 nouveau_backlight_ctor(void) {
 }
@@ -257,6 +272,14 @@ nouveau_backlight_ctor(void) {
 static inline void
 nouveau_backlight_dtor(void) {
 }
+
+static inline void
+nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state) {
+}
+
+static inline void
+nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state) {
+}
 #endif
 
 #endif /* __NOUVEAU_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5e1336615cf6d..53bf7c2caa164 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -673,6 +673,10 @@ nouveau_drm_device_init(struct nouveau_drm *drm)
 		ret = nouveau_display_init(dev, false, false);
 		if (ret)
 			goto fail_dispinit;
+
+		ret = nouveau_backlight_luminance_init(dev);
+		if (ret)
+			goto fail_backlight;
 	}
 
 	nouveau_debugfs_init(drm);
@@ -697,6 +701,8 @@ nouveau_drm_device_init(struct nouveau_drm *drm)
 	}
 
 	return 0;
+fail_backlight:
+	nouveau_display_fini(dev, false, false);
 fail_dispinit:
 	nouveau_display_destroy(dev);
 fail_dispctor:

-- 
2.43.0

