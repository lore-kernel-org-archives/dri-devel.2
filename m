Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A996C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EC410E324;
	Tue,  1 Sep 2026 19:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipo9foAx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730BE10E324;
 Tue,  1 Sep 2026 19:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEegqX9BeLjNi5ltqtdZ0sGvPI3HBx8XY0YcGLvUDorKCURlc3O96iOaSwVz2MCgEn3U84CsacDD+XHFLXwvDs3PFSNxJCvodRV1D+TuLGO2vFtk1pKCJC84Y7Nk+ugc3ccBnvcflInUAHIhEWT4wsc2YA8EdnP+W9HefUOnXDcZbc48Ljw2oOG4xpf35SkZAuJNASvMU+1+9BYlSgTFknmG0feHOjgTw+7aFC24LRtTq5l+6eVN6rYdD0d4QakzUSW1xIMp/eEJp6T1SyPqU3XAQ3zJG4rxwdh5z6SkE1XKzsxbTwLHGEJ3ubMXmvIjBxS78CkyvVZgn4Jfr/cDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMVgTJ2+aZtYIBsd67YYyrMp/iiBpw9D33VTjrOVZQc=;
 b=cikf2zKR3i/76lwbPrnuALNe1JmCxqwnghkpKvNPv5IlVzKzybIkP20UrU9xtB271UvcxyR/ew1ScRABOmuvkfOxiy/c/geRjx2hbl6Lu2jw1FjR5fUDpW/DiI9yDb57Etp/eddztdfxW6pZE+SPerCfAiJt0kIHGcSId9hKgtA1nfnHHt5yMW96dnHeLz5WE9WeBSJD9kXXnb3vQSD1yGoYwtI3LnOS1G+amVI0vkp13QXlP1r7kCEf8Ge4+OeGwiG5tPlWcbhAJ2EsSp/SMDXDCzlXia6ryycC6Jr4WY9aoGKNsI3Cu+haH8u/2Pj4UfDFso/k/21MkAW/l4Q9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMVgTJ2+aZtYIBsd67YYyrMp/iiBpw9D33VTjrOVZQc=;
 b=ipo9foAxPL17oLc8p5M3dLpUlMCtOFgDU8Sg3YozJxnjb2pmEX1AuUl/gipiHlJIxCJnMUI2ivGBu4gEXcttZFzUvipa3NssHjxvPEOm8RWPhDFbPCQjsUt/wylzE69DMjcLkDiwb0Jm9oAdD2fSlwn0m77mHaVfNPOai/+511M=
Received: from DM6PR03CA0082.namprd03.prod.outlook.com (2603:10b6:5:333::15)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:13:48 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::3b) by DM6PR03CA0082.outlook.office365.com
 (2603:10b6:5:333::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:13:45 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 14:13:44 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <adolfotregosa@gmail.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v1 1/3] drm: Add passive_vrr properties for passive/desktop VRR
Date: Tue, 1 Sep 2026 15:12:49 -0400
Message-ID: <20260901191251.2653684-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901191251.2653684-1-jerry.zuo@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 266d0963-2944-485d-95aa-08df085d252d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|3023799007|5023799004|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: XZiBmDiRrTOYowhQ1pIOhOXytHSzNSSbN+QbQqG6XbqeLkrVzKS5/jZIBFX5yKSFCQJ+yAF4PBGyfMNufpW9A95YetmxQAw8gel/G2PRrDLc+HsmeVOc/8GzRoddEn8XAfPZqwkf6gE2IJiFXlfO0EgPXdpUUwsq0LbmytwZEZ+NrLGPXtOfKiMbhQQncb9nCnwe8acqgzGllW1+QMb/RHUKpGQi67EoMnVfOmLIbmFvNoV5O7TBLhlfg4p+Gg8QxatMMIy+l1egpolt+6V4k1z9Bdk/5TERRLatr5Ew2sk74KjilXjhUmv9NQcuk/7OSXxiJALvwZUc1jjvlrErOzW9AY6nXKBOo/kqQb+GJwdODaBXEz5tL2vgC/DzgQn81w9ORT/JdbFIujso2qZxaGKy7jQL4JcvZrNwfyZWjSxl676f456H3V/mP3vKUDl/bGOdOAsUawXd09ETc8T3axm76GH+PjZh4UPhdCb2YmPDerp0O/kZ9Djm0aQahFqlJntD/Ncbs0theX8zTc2bkzT2FHM4LQIyriR3V+wjuYruANE1Rvvu052pMrz1PKzlejG08LxVCk3T0CiF/SQd5RUfXbZCvetu2W9TlwVZ4V6hJaA79MVSFb6+mRkfa4+7IqZnbeFK4YP2cKo9syeAwV02NRTN7Yu19taB6Rt0rZAblq1WXiKXv20mGNR7PTTMcD5fzZ93p9SfK029xHDfog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(5023799004)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WWwra9fCwsQKBdsBajCUi3BuTTLQzP5vte8HZu8xblfWI6I3b4ZgU4NpIHzg2/6ppk+p92anLWlfplFzFI3NXVeraxDxCHyR+1xhq8UYqP9Ec3zZS2p4XzROVwUuG9ok4hoTlmKarPE9tMjRB+YZxC8m7vu7toXf/t4fb9TTTjKHC3SsJEfWyK5qUuEJ6F3bEyO5fC5L+tkmlwTD30/KYVTIOWO2XOKqnRtZYfeBONrUuZLIqT6S0IcJbDOYQWyfN9SgLXQH9xwq2smsphYVK5PU0ZNZnTC8ZtspVUyoHkQJtzY5+xom3Q6PrGdijIBSQR31y46M8WXY9Ak8ozAuZF5UYN0J21vDOM1ne7IQ46j/fKiDtkrWXWYBDHtC26z7eq5AjUehZmGM2X2bZNVPwyv/xM7tTCXMBGV19ud9pNtH5c9S0g0mFMTjMoaWKvp6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:13:45.7831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 266d0963-2944-485d-95aa-08df085d252d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

Backport of upstream (Tomasz Pakula) amd-gfx v4 series patches 23/27 and
24/27, squashed into the drm-core change required for passive_vrr_capable.

Add the PASSIVE_VRR_DISABLED atomic CRTC property (drm_crtc_state.
passive_vrr_disabled) and the immutable passive_vrr_capable connector
property, together with drm_connector_attach_passive_vrr_capable_property()
and drm_connector_set_passive_vrr_capable_property() helpers.

Passive VRR keeps a sink in its variable-refresh state during fixed
refresh (desktop) use, avoiding blanking/flicker on VRR entry/exit for
HDMI sinks that lack seamless VRR transitions. The property is opt-out
(default enabled where the connector advertises passive_vrr_capable);
lacking hardware support is not treated as failure. Not useful for
DP/eDP where seamless VRR transitions are enforced by the standard.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c |  4 ++
 drivers/gpu/drm/drm_connector.c   | 73 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_crtc.c        |  2 +
 drivers/gpu/drm/drm_mode_config.c |  6 +++
 include/drm/drm_connector.h       | 15 +++++++
 include/drm/drm_crtc.h            |  9 ++++
 include/drm/drm_mode_config.h     |  6 +++
 7 files changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index e997917819e8..c50c83360ba2 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -420,6 +420,8 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		return ret;
 	} else if (property == config->prop_vrr_enabled) {
 		state->vrr_enabled = val;
+	} else if (property == config->prop_passive_vrr_disabled) {
+		state->passive_vrr_disabled = val;
 	} else if (property == config->degamma_lut_property) {
 		const size_t elem_size = sizeof(struct drm_color_lut);
 		u64 lut_size;
@@ -505,6 +507,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
 		*val = (state->mode_blob) ? state->mode_blob->base.id : 0;
 	else if (property == config->prop_vrr_enabled)
 		*val = state->vrr_enabled;
+	else if (property == config->prop_passive_vrr_disabled)
+		*val = state->passive_vrr_disabled;
 	else if (property == config->degamma_lut_property)
 		*val = (state->degamma_lut) ? state->degamma_lut->base.id : 0;
 	else if (property == config->ctm_property)
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 9d820a2a87ce..c429105172b0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2368,6 +2368,16 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *
  *	Absence of the property should indicate absence of support.
  *
+ * "passive_vrr_capable":
+ *	Optional &drm_connector boolean property that drivers should attach
+ *	with drm_connector_attach_passive_vrr_capable_property() on
+ *	connectors that could support keeping variable refresh rate signalling
+ *	in fixed-refresh rate scenarios like desktop work. Drivers should update
+ *	the property value by calling
+ *	drm_connector_set_passive_vrr_capable_property().
+ *
+ *	Absence of the property should indicate absence of support.
+ *
  * "VRR_ENABLED":
  *	Default &drm_crtc boolean property that notifies the driver that the
  *	content on the CRTC is suitable for variable refresh rate presentation.
@@ -2386,6 +2396,17 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
  *
  *	The driver may place further restrictions within these minimum
  *	and maximum bounds.
+ *
+ * "PASSIVE_VRR_DISABLED":
+ *	Default &drm_crtc boolean property that notifies the driver that the
+ *	VRR singalling should be disabled in fixed refresh rate scenarios.
+ *	Functionally, psssive vrr works the same as VRR_ENABLED == false
+ *	but works around displays blanking (mainly HDMI) that do not support
+ *	seamless VRR transitions. Also helps with brightness flickering during
+ *	VRR transitions.
+ *
+ *	Passive VRR mode is not that useful for DP/eDP sinks where seamless VRR
+ *	transitions are enforced by the standard.
  */
 
 /**
@@ -2419,6 +2440,37 @@ int drm_connector_attach_vrr_capable_property(
 }
 EXPORT_SYMBOL(drm_connector_attach_vrr_capable_property);
 
+/**
+ * drm_connector_attach_passive_vrr_capable_property - creates the
+ * passive_vrr_capable property
+ * @connector: connector to create the passive_vrr_capable property on.
+ *
+ * This is used by atomic drivers to add support for querying
+ * variable refresh rate on desktop capability for a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_passive_vrr_capable_property(
+	struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	if (!connector->passive_vrr_capable_property) {
+		prop = drm_property_create_bool(dev, DRM_MODE_PROP_IMMUTABLE,
+			"passive_vrr_capable");
+		if (!prop)
+			return -ENOMEM;
+
+		connector->passive_vrr_capable_property = prop;
+		drm_object_attach_property(&connector->base, prop, 0);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_passive_vrr_capable_property);
+
 /**
  * drm_connector_attach_scaling_mode_property - attach atomic scaling mode property
  * @connector: connector to attach scaling mode property on.
@@ -2985,6 +3037,27 @@ void drm_connector_set_vrr_capable_property(
 }
 EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
 
+/**
+ * drm_connector_set_passive_vrr_capable_property - sets the variable refresh
+ * rate on desktop capable property for a connector
+ * @connector: drm connector
+ * @capable: True if the connector is variable refresh rate on desktop capable
+ *
+ * Should be used by atomic drivers to update the indicated support for
+ * variable refresh rate on desktop over a connector.
+ */
+void drm_connector_set_passive_vrr_capable_property(
+		struct drm_connector *connector, bool capable)
+{
+	if (!connector->passive_vrr_capable_property)
+		return;
+
+	drm_object_property_set_value(&connector->base,
+				      connector->passive_vrr_capable_property,
+				      capable);
+}
+EXPORT_SYMBOL(drm_connector_set_passive_vrr_capable_property);
+
 /**
  * drm_connector_set_panel_orientation - sets the connector's panel_orientation
  * @connector: connector for which to set the panel-orientation property.
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..bd666dbc30f2 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -322,6 +322,8 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
 					   config->prop_out_fence_ptr, 0);
 		drm_object_attach_property(&crtc->base,
 					   config->prop_vrr_enabled, 0);
+		drm_object_attach_property(&crtc->base,
+					   config->prop_passive_vrr_disabled, 0);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 66f7dc37b597..dc1ca08655ca 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -345,6 +345,12 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.prop_vrr_enabled = prop;
 
+	prop = drm_property_create_bool(dev, 0,
+			"PASSIVE_VRR_DISABLED");
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.prop_passive_vrr_disabled = prop;
+
 	prop = drm_property_create(dev,
 			DRM_MODE_PROP_BLOB,
 			"DEGAMMA_LUT", 0);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 9f8f109c2dd1..fd370ecfc6a2 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2212,6 +2212,17 @@ struct drm_connector {
 	 */
 	struct drm_property *vrr_capable_property;
 
+	/**
+	 * @passive_vrr_capable_property: Optional property to help userspace
+	 * query hardware support for passive variable refresh rate on a
+	 * connector. Drivers can add the property to a connector by
+	 * calling drm_connector_attach_passive_vrr_capable_property().
+	 *
+	 * This should be updated only by calling
+	 * drm_connector_set_passive_vrr_capable_property().
+	 */
+	struct drm_property *passive_vrr_capable_property;
+
 	/**
 	 * @colorspace_property: Connector property to set the suitable
 	 * colorspace supported by the sink.
@@ -2606,6 +2617,8 @@ int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
 					       u32 scaling_mode_mask);
 int drm_connector_attach_vrr_capable_property(
 		struct drm_connector *connector);
+int drm_connector_attach_passive_vrr_capable_property(
+		struct drm_connector *connector);
 void drm_connector_attach_panel_type_property(struct drm_connector *connector);
 int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
 int drm_connector_attach_colorspace_property(struct drm_connector *connector);
@@ -2629,6 +2642,8 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
 					    uint64_t link_status);
 void drm_connector_set_vrr_capable_property(
 		struct drm_connector *connector, bool capable);
+void drm_connector_set_passive_vrr_capable_property(
+		struct drm_connector *connector, bool capable);
 int drm_connector_set_panel_orientation(
 	struct drm_connector *connector,
 	enum drm_panel_orientation panel_orientation);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index c6dbe8b7db9e..642a374f403e 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -311,6 +311,15 @@ struct drm_crtc_state {
 	 */
 	bool vrr_enabled;
 
+	/**
+	 * @passive_vrr_disabled:
+	 *
+	 * Indicates if variable refresh rate on desktop should be enabled for
+	 * the CRTC. Support for the requested state will depend on driver and
+	 * hardware capabiltiy - lacking support is not treated as failure.
+	 */
+	bool passive_vrr_disabled;
+
 	/**
 	 * @self_refresh_active:
 	 *
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index e584652ddf67..e312e6ae4d7e 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -701,6 +701,12 @@ struct drm_mode_config {
 	 * whether variable refresh rate should be enabled on the CRTC.
 	 */
 	struct drm_property *prop_vrr_enabled;
+	/**
+	 * @prop_passive_vrr_disabled: Default atomic CRTC property to indicate
+	 * whether passive variable refresh rate should be disabled
+	 * on the CRTC.
+	 */
+	struct drm_property *prop_passive_vrr_disabled;
 
 	/**
 	 * @dvi_i_subconnector_property: Optional DVI-I property to
-- 
2.53.0

