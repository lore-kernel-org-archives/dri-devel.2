Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09794C79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED78310E9AA;
	Tue,  8 Sep 2026 04:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vEE+GwP3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDB010E989;
 Tue,  8 Sep 2026 04:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms9F25A/fLDO29eFFTxhMfe2t5TkYdpxmk+bTtcddRJN4KIaMymKLSqxe5kh2vxcA4EzbiHIg3RznhWFPc+e/NOyWl6t/XYyMnDnvDMWbY/vcZvSB8csEoe6eN3Gj+ChY6/27wAa0ki3RCt3+KQgud3rZk3zJc5SteoRJIvKubW+Xmzholb1WQIcecgtM2JU3NPXWbm2WxYB2G6gQDxvty85WCJJsGNAo8A5SF/KLtKINzG3EbEz1MZORntI3rn8gppHXTBdsZrZUj4kN+60q64j+Antva1l3noncSxt0Sb9oSlU8gqc02r7Ap+92yQib7UBom3H19OuqMMvXGmIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJRL45/d0hHGFJlb8X2s9ZLyAuaYIJLJSoBIPuhrn9Q=;
 b=oRn0A/+Lb0lRx4OzTmJR9MFgrAPfjkqG4zqtDgHMcrw37y8N7Z9Vj0T0N39ub8RIvTU5PQ4pS+6ii56J7BY1yPtNdgX69q4X1ebUKLqjUyZmk+7uUu6zavLq/yVEQ2eUw5H/fuayXtQaA//c0rgTrPnS4t+uGUrIIvXrOK2yoeFkqIzJCv07PatKhvU1syPbw712sZXm+aGTVXZtpjZthErYzuzTA6pXmwdZ/I0u+213jI5QYUtG6F38eTnByRhbr+xhieBNopolLqAGNhVpsu2fwSuP7PpgTPK4mody5ws/8XuDaW3/sUZVe0xq+UmthsHf7rz17pTQK5VFmBZ0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJRL45/d0hHGFJlb8X2s9ZLyAuaYIJLJSoBIPuhrn9Q=;
 b=vEE+GwP3E9KozuhWoJhqnvegldD8G8J6XqL2vmIJQ3it11AaMZD9tz771ELCdD5YxaykVlJ4P4iJjHGyr5VJ/BDqqTxqU9IhArNLQY47m18aDTQ6vy01lRUl2P4AGBFE9VXk07ABwz4++uDqjiAQ+txLXZFCEwhKKcM43aMCelI=
Received: from CY5PR15CA0012.namprd15.prod.outlook.com (2603:10b6:930:14::12)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:40:59 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::a5) by CY5PR15CA0012.outlook.office365.com
 (2603:10b6:930:14::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:40:58 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:40:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v8 03/14] drm/property: add a per-connector luminance flag
Date: Mon, 7 Sep 2026 23:40:24 -0500
Message-ID: <20260908044035.62093-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 0561a97b-0e95-4695-bdb5-08df0d636091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|7416014|82310400026|1800799024|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JtcrNgt4NlEE0KppwzHixUWWx2DTNZ7OoDcKAT3R0k0D2r2UKUfL/MtA6ZuLUvcJNOryhxyoYgyVTnFRmYH1F6UWh5GSuWGI6xww0nsTiMQ8zoxxwyX089QKcrtZJzzPaQwoO1mdUgOqab+dd/jqmnILl52gbbHKEM/h2m6qvlIGZfFZxRw52DC7YcilItchZjeDi7togCNAm/1h5KuQ+A/xMh2F7ixtBtK1I2+yRMY8LrUZtKLBl6nnIvCeWim8DZxKvH3PCwhasn7g/ZCRz6GGeHqTXP3/cDpwldezG3ebq6WrGdB5fYiE/IQNlKiZznlgISWRmGrz6RfENNb44iq1H7yS9uKe8wHdarQcqlSAjJeu+YXA+OUNDxYgwgSXPgY7PHPyPTEjjpm0CXD+JtaB00PVt1hC9sAFePFNqFFKFiTZ4CpmLq7A+HekBQbF8wNY9cPO35YUMyOTMVnkLiE4UNMehJv3/3ij2Td5VYQXlgh2EaGVgSYSRR+WYEKmbmtilnbGyAU57emtEjlMxPvUZQAbZBgy7lV8D3owKngnGxFZPD8u8rOEsQF/zDc234nJyYmsJV1KEBAcO20M/nxAFc+RsTS+w8Wboh/rZGjgy7QWZSw0S5C1gVMLOUXyGFQj6arJk1UcCROQDBH8u9vRm0O16m230fl/BprA2ZGRdC77eW47CmIeg37Q2GqPJ8BFPTefoP49tZ6FWVbqbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(7416014)(82310400026)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: imBW5cfsxI331HpibYOkYy2yieZ2ocSP0V2ok7OsFqj1ci3MdFYqcYW3DpWkgksgHibKTq5nfr/xWpXl/1X1RhHZvJIfSW0GA8YxXeMSQzx6967q7NVhoA2uQxtPUW4jK02KcU5NNIUIJM5WKFVwIkJ3ZnExPnxDKdcyo41QlQnFiy/paCoFIZn1o8WdJvsuLzQVJ3oEYWoctmbTXopdfoPpC4qBVOTbZJGGBAZE7NX0QghFzqyOZXVrdRI7c2qtucCt3tfOYn5hIRx4NwI8qo3WENdbgxlp5P4dHWHFO7w23c+1rrTGziq/jz7VjkySjGQ6iH8AMIYY03B/9k/cl9uPtVUlq9hv0vuXp3pO/57KdAoNb6OrhRakaVPVNVgksMeZrN+R4fZ2Brf/pqqZPIW2ywNaVE/yihVkoSQUibozbY1UDRPkWV0Og4pRhstz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:40:58.2092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0561a97b-0e95-4695-bdb5-08df0d636091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

The upcoming per-connector LUMINANCE range property needs to accept the
value 0 (to turn the display off on DPMS-off) even when its advertised
minimum is 1. The existing check special-cased a single device-wide
property object, which does not work once every connector owns its own
LUMINANCE property.

Add a kernel-internal is_luminance flag on struct drm_property and key
the value-0 exception off it instead of a pointer comparison. The flag
is not exposed to userspace.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/drm_property.c |  6 ++++++
 include/drm/drm_property.h     | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index f38f2c5437e68..adccee10cfde4 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -952,6 +952,12 @@ bool drm_property_change_valid_get(struct drm_property *property,
 	*ref = NULL;
 
 	if (drm_property_type_is(property, DRM_MODE_PROP_RANGE)) {
+		/*
+		 * Special case for the luminance property: allow 0 to turn the
+		 * display off even when the normal range starts at 1.
+		 */
+		if (property->is_luminance && value == 0 && property->values[1] > 0)
+			return true;
 		if (value < property->values[0] || value > property->values[1])
 			return false;
 		return true;
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index aa49b5a42bb56..8bb568a4cd485 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -188,6 +188,16 @@ struct drm_property {
 	 */
 	struct drm_device *dev;
 
+	/**
+	 * @is_luminance:
+	 *
+	 * True for the per-connector LUMINANCE range property. Such a property
+	 * additionally accepts the value 0 (to turn the display off) even when
+	 * its minimum is 1. This is a kernel-internal flag and is not exposed
+	 * to userspace.
+	 */
+	bool is_luminance;
+
 	/**
 	 * @enum_list:
 	 *
-- 
2.43.0

