Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FB60A2626
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wftYj/cj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7224C11278C;
	Thu, 19 Nov 2026 23:28:10 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448CD11279D;
 Thu, 19 Nov 2026 23:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwzyyE0aordVT7JHllbJLA7P3d5uzn4W8NtoadFF1hhcyyAPhQAdf1h3oT6b/XC6iaSU0Yzq5mjiUxAv8Lj9Erm27876da4m0WD9wThPNAJsCn76xoIl/NUZ8TqIr7OOhjWn1v0PrmFNdfxfNWVzng4qjkMFlzeQItlw3Jjbfz8Pt6JOpB6iWc8tmISHU5LUaV8iyKzApYM/L2+anNjvvpXgrTmi/p2TOtnyt6U1V6j7Z9QMjQA/SWt+V3q3cu2AUF32jFuvOoZn7WPTEDyA2WzxxTE41CkJ6hm+nP9uNEEsULS1uoSHsJ0bOEti68z91dHBRZX6Xp3QbjIkwhCuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W9Y94XUyCwUcvAtiGBwrYvkNNA09AuI+/xkwoEUnmQ=;
 b=daZOpsAyFywZpi7Yr7zDvyXGOO9Rht9FIj3K0KI2xZNpLY9TNDaPD60DYpUEkraZxGpYwJ/bs8F/ndk3ffBCh95a7MMzBFd7EvnnEGUBgdEXISAjPmYadZkCxtTATEdR6KxpAnPN1S1invLV41+vhHqOSvwJUgCauY6lctyWqB/VRVd+dxGQJP15803UuipNqeSfYcEP8isrJ/Ee2Xkt7VkhTckDUJcOdffsJucJHB5Q9tQcdFMKmqaog7rZsecHwc/tz3DgRxR2ZkrdOuixrErwPLQOSxibta+C/EbuLO6AspeDXvlOUrThZHtP1L9nUE40Xe0+9eMx+kVTunAADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W9Y94XUyCwUcvAtiGBwrYvkNNA09AuI+/xkwoEUnmQ=;
 b=wftYj/cjusYPVZLDlzcifbAtr7s+Fq9Jzk884g9ayKHPnKDuroUFQWlu+k1LwGm1Rm9DFGo6u0bxFnW/1/S4M2UCH6/SAqrDyVzDZUrZDBulEZPZds+6vvN5mVSNiVhKqMFcGXWbCCce+XRMPmX/Vt4chpywmcR1F0vwO2D1D3s=
Received: from PH0PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:e::19)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 23:27:57 +0000
Received: from PH7PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::3c) by PH0PR07CA0044.outlook.office365.com
 (2603:10b6:510:e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 23:27:56 +0000
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
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:35 -0600
Subject: [PATCH v12 08/12] drm/bridge_connector: add luminance support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-8-89d5217d3618@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000009:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 267d6c6d-e3dc-40dd-59ff-08df4694bd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|82310400026|23010399003|36860700016|921020|261022075727099003|10067099003|261021121427099003|56012099006|11063799006|261026121527099003|261028144727099003|261026140227099003|261022105027099003|261102123227099003|261009221227099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U1BIYKI23Xebo27sTj0YR7ajZt2qUY3nskMX6kXcHakuJ4DvQ3/2OUcCHiMA3qMDYIVbX/zf07jaEkHi58yq8QfJOnA9GWycQgIHTb/6fN1L2vo03C5mndZRXmr0QsTUhj5uKG1qvkLLdqfrBes8GDJq88XKS+WV9gq04ySDcrrxUuqd5uDUSe64/eUYHGlVPWaqVAX+W9c8GF2tJHefsUG3jXMre01BNNLifyFtlFUquPIIYXnEeuxNnz2nl7XiXs0a1YaXu0wJIpXdiJ036W2Gda77POpHc68S+7QQVuDwpJ7feZSo6fBnAscyJDMxIBlZxWx++7rjdv5ST9AAIl4X5uIVHoDjufEHIQfqafJx5LknrP1FGmVHU33SmWnoxJpi/+UH9/N5uUGVriG2eJsIfn1m6RcfaT4unsk16mSHKyr4LZyQIDHXs+LnP4cC3C0H6hXbi8Fg6mpHx2Gf9JdMnEAjgw8XMGnJEHe77loORLRuJGghtWNNf+GDM9Z+3G8Ni6ItHdqbSowSiieK5N1xQtiLjo+vwuVhazmgsm05jdjYjCG/fvv9nDEp/MRhWM2R9FS3KDihDy1F+W6vsgZeHb3R4i9L5krJKP4Re9/X5CM/hAUMx95ST0uaDaB24wAYw6c63J/hgKVwOsGgCl445Y3FO9Qd2U59lyKz6sxgqnR20Ac1D1Ho5Dq6leSv/1LPBuHfLDgtcmvlte2MxFd93Kn+29KTPmoMkSJshTjV89+5D1PvfiHlpEu8t/Dg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(921020)(261022075727099003)(10067099003)(261021121427099003)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(261102123227099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6mlGWDdBa3AIn2jG+MAFnoGkvi9+w5GhJblFy4J8Zf43KNj0wBmWNuqYoXbZ7ysd6MsZPqyHGSTCOBiPfa8b15sMdHsEyg81wyDPzo9HsYnoQLzj8DW5WASTivB0YEopOL6/+ZRAASMqD/6RlFPjxs7Dj+4GxfIg3KM2ELMaAekXMdHNLzeX2kuja+jBF26akvoJ9WwYAXRZAr2yi9WdGLy8B7YIcJxLFb1N3plMuLUc+h8YgoHCDi3lDj/aPuuW9jddop0tcT5dFNlQDyYfBL7V/5S6+duUkq7fNXnXuLTeXKoauzUmMdNQEjIvCla4Lz5dUwzp3WjwpMNvLjcwuKBpIbsOtOcE7TpbrQuLC8eTLEGzsReqYljeVNARXdubQUK/xPfBKWoFVNPwSzw/6e66tzZDSd0Vru3PDjWh2QG8ZHO7mfBV5ERDxo4E+bWj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:55.5681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267d6c6d-e3dc-40dd-59ff-08df4694bd6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
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

Discover the last bridge in a chain that owns brightness control, attach
its relative luminance range to the connector, and forward atomic
luminance updates to it.

Do not infer panel luminance support from a terminal panel bridge. Panels
still have direct consumers, so their connector integration must remain
explicit.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

---
v12:
 * Add tag
v11:
 * Drop .disable_luminance, it clobbered the bridge's saved level; the
   bridge disable path already turns the panel off
 * Fix checkpatch line length
v10:
 * Split bridge connector integration into a separate patch
 * Do not special-case panels in the generic bridge connector
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 2202e60444449..18927fed83732 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -125,6 +125,13 @@ struct drm_bridge_connector {
 	 */
 	struct drm_bridge *bridge_hdmi_cec;
 
+	/**
+	 * @bridge_luminance:
+	 *
+	 * The last bridge in the chain that controls panel luminance.
+	 */
+	struct drm_bridge *bridge_luminance;
+
 	/**
 	 * @hdmi_funcs:
 	 *
@@ -421,6 +428,17 @@ static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
+static void
+drm_bridge_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(conn_state->connector);
+	struct drm_bridge *bridge = bridge_connector->bridge_luminance;
+
+	if (bridge)
+		bridge->funcs->set_luminance(bridge, conn_state->luminance);
+}
+
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
 	.detect_ctx = drm_bridge_connector_detect_ctx,
@@ -429,6 +447,7 @@ static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,
 	.atomic_check = drm_bridge_connector_atomic_check,
+	.set_luminance = drm_bridge_connector_set_luminance,
 };
 
 static enum drm_mode_status
@@ -835,6 +854,7 @@ static void drm_bridge_connector_put_bridges(struct drm_device *dev, void *data)
 	drm_bridge_put(bridge_connector->bridge_hdmi_audio);
 	drm_bridge_put(bridge_connector->bridge_dp_audio);
 	drm_bridge_put(bridge_connector->bridge_hdmi_cec);
+	drm_bridge_put(bridge_connector->bridge_luminance);
 }
 
 /**
@@ -918,6 +938,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			drm_bridge_put(bridge_connector->bridge_detect);
 			bridge_connector->bridge_detect = drm_bridge_get(bridge);
 		}
+		if (bridge->ops & DRM_BRIDGE_OP_LUMINANCE) {
+			if (!bridge->funcs->set_luminance)
+				return ERR_PTR(-EINVAL);
+
+			drm_bridge_put(bridge_connector->bridge_luminance);
+			bridge_connector->bridge_luminance = drm_bridge_get(bridge);
+		}
 		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
 			if (bridge_connector->bridge_hdmi)
 				return ERR_PTR(-EBUSY);
@@ -1144,6 +1171,18 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) &&
+	    bridge_connector->bridge_luminance &&
+	    !connector->luminance_property) {
+		struct drm_bridge *bridge = bridge_connector->bridge_luminance;
+
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      bridge->luminance_max,
+							      bridge->luminance);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);

-- 
2.43.0

