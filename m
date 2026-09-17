Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6557DC982D6
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ADDC10EF4C;
	Thu, 17 Sep 2026 14:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5noAOEuO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DF610EF4C;
 Thu, 17 Sep 2026 14:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL3yPYz9bmwz7030ckFTHZv4McMGWtVD619gAxc7KRdRviQ+mB3jxAVzh+wroPH+7Vs3eLk5u63vKUzmzScR+yr61AEi9ECL9dYUzC5umbLSlm1uLgpAIg4WfFbA/OkpysFhXF87PisD6OWVUuqfxJYG6P9HTOEKXxvb7IbjbKKAbt1iXEez61Q74vRHLKQM5e6rg4IGIVLvWDXTwGLbcQpnmV4nPJEW3JY8QfSDz6W3xLX/FDl+ZvC113uXBFuE+IcVaZ8Go7Tde3tfYoM13tbCOOOGHUE4TNEtjoerRh+TKpbtAZYJHp0fUmChGGQD1ZHJWiTiYU3OSeKp8NTkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yu8f1y8iRvbyXv46b1YpiHqXCYphCCVrq/IdNy12OOk=;
 b=JCVWNAedWjK59CSjg3oo01aZ9i/q90Xb1F6LiX6mFcLOTAgsxg0SnzPOD/yONX3eZQ2u/ZIuAae2oY3kxrw2FiZbW765N1ydTRBI6pjpAFQ8TCgwszQVrItHFxVdOmou9vlvAwznjydfF+pb95h0Bby1AXx7felp1CSvaOApsVdeEQQPS4AOdOso8dJDQEx3cFk7GaUYO3GJ7NVRuMJkPyiu6riLbfwwkuWD8PhEoQYYfIOIUqmdRyz1e0mLay1ube3VH7SJqYkKbRzMfShC06l9rc7KrO2F9kNtfEeXfSTeGTZhaCnBST9MdGx0EhIFUMq9TZLtd1gyujaQisB5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu8f1y8iRvbyXv46b1YpiHqXCYphCCVrq/IdNy12OOk=;
 b=5noAOEuOT35zj9uAnqsPrhKzDQQmNcOKFmuuUN6rl43hSarJ7nkqIzeaYpRpCyOGEJvh2UgeyU4qL9PVqKZ3LpMeYg86UCymiXm7VeIM9dwaKtZ1598cc5071m4HJu+RgQsw/jZFs7ETEHl1lQ9IfcEQfRYKJc9GMvDdmBMRLOI=
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 14:36:21 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::a) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 14:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 14:36:18 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 09:36:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] drm/edid: Add an override-only EDID reader
Date: Thu, 17 Sep 2026 08:59:48 -0500
Message-ID: <20260917135949.2552704-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917135949.2552704-1-mario.limonciello@amd.com>
References: <20260917135949.2552704-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: b446a37d-9f05-4273-60a8-08df14c90960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1IaMOzrqB655fxOcgANuJZzUKMHKvzIL3T64OPqub6BwAaCAYIsYlnXjtPFyubto6pzY1SE1YV2wJ17tYIPK+W6A6U944llJksDodDXDsPiA/OWV08imRmL3GEmQsScF5XqtPJwE8iN/WusGdFjcWXgVxBhFGc4eWs4uppi8LzYE5fiGMp/m2TQerylZGzfCfDF4FzmPBJaAWYM8FBDjaS0QvQk+wauEpZ5VDqrsfXZuTzD0TnuG1/nBl7W0K+UN69elJsHqf/ysyn16xzywFhUd/W3eiSFx/4sIArN9wV9CtbLWbds3G5qyhjokAuoYJE7L0vWkDZKsvVpqBiZURpo2x/nMKUwoMNGSn8F9L/Io3pG4zidINro8yLMl4fnR9YP9+KDEaM43MIU8876uFQDYsM4qZ1ZBf/scOvpA0wjVMf+1+f7rBCEF3XDXRTG0pYcHMZbJvCz2YtxusYMTcHtFFaYDa0/OvtaVh7xNanlPjIbIXqFyfpdjuQ3nI2NV90+ORdksW3P0v/C7N3Sod8s7w4h1f/BLwUyCV1u+fjgxy+3zcoZVyUg9SpFgdFqm3NGOL1kOjUwVXI++/ANDK4wcmmhFiYrBonb8qOT0nDFA1O0GqObvEHWRaEMNgno6E437GUMNlZlO9zR/2P7NjOq8Zg62PKmZlEjIUy0YnRIQ61OJM6lkIIsU2vRDz+71wWmjia/lyZs7KC4boZW3QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DHhxFMiRQ2VRu9tMvC4SzLQPDo60jKKUDQksJNGmOKiNr8WE0lm2LLyqZBL3PP/MP/3uoyaV50m/Mip6b12Cuyn9JGn9PK5qRoHX2jUjlUNS5datxNHkd01n8IVKDhXHo/tXRF0adg5mS/wh7haKmXFSL1deQMTxx4AdkRn8nI0vk/SEFjimIY4FeNKEx36kfC9+sDbdxh67kznHkBldlPhXV4H8n+xrRrruXribulMnVdMwMek+oL7HSLlYcfCQXLh+HVQhpwUsMRDAqdFUaLI1zr64EbSBn6zeKAob6EfcpTyn9YEYLS7Hl9WmgnGqSJF/Hbh8LEjizfKxZUVdv8YQsafavHSbE3gi7BlP4R8J/e20IAPgPvZM0R2d7TH8/v8jOlm/BKAu+IhARhnATQeQAvDqLzoAk5SPXzdzKardT9s9vp4sotyidcjJinq4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:36:18.6910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b446a37d-9f05-4273-60a8-08df14c90960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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

The existing EDID read helpers retain a DDC presence probe before they
consult debugfs or firmware overrides. This is necessary for drivers that
use a successful EDID read as connector-presence evidence.

Drivers with independent presence detection cannot retrieve an override
when DDC is unresponsive.

Add drm_edid_read_override() so those drivers can retrieve a configured
override without probing hardware. Keep DRM_FORCE_OFF semantics and the
existing debugfs-before-firmware priority.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/drm_edid.c | 22 ++++++++++++++++++++++
 include/drm/drm_edid.h     |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3148038747b6e..4857bcae5e117 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2289,6 +2289,28 @@ static const struct drm_edid *drm_edid_override_get(struct drm_connector *connec
 	return IS_ERR(override) ? NULL : override;
 }
 
+/**
+ * drm_edid_read_override - read override or firmware EDID
+ * @connector: connector to use
+ *
+ * Read the EDID from debugfs override_edid or firmware EDID
+ * (drm_edid_load_firmware() and drm.edid_firmware parameter), in this priority
+ * order. This does not probe the connector or read the EDID from hardware.
+ *
+ * The returned pointer must be freed using drm_edid_free().
+ *
+ * Return: Pointer to EDID, or NULL if the connector is forced off or no EDID
+ * override is available.
+ */
+const struct drm_edid *drm_edid_read_override(struct drm_connector *connector)
+{
+	if (connector->force == DRM_FORCE_OFF)
+		return NULL;
+
+	return drm_edid_override_get(connector);
+}
+EXPORT_SYMBOL(drm_edid_read_override);
+
 /* For debugfs edid_override implementation */
 int drm_edid_override_show(struct drm_connector *connector, struct seq_file *m)
 {
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index a2617aa34edfc..cdd874b98340d 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -469,6 +469,7 @@ const struct drm_edid *drm_edid_dup(const struct drm_edid *drm_edid);
 void drm_edid_free(const struct drm_edid *drm_edid);
 bool drm_edid_valid(const struct drm_edid *drm_edid);
 const struct edid *drm_edid_raw(const struct drm_edid *drm_edid);
+const struct drm_edid *drm_edid_read_override(struct drm_connector *connector);
 const struct drm_edid *drm_edid_read(struct drm_connector *connector);
 const struct drm_edid *drm_edid_read_ddc(struct drm_connector *connector,
 					 struct i2c_adapter *adapter);
-- 
2.43.0

