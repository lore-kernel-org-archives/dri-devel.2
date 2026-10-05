Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7018CA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B4810E20A;
	Mon,  5 Oct 2026 19:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3pGGocrW";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E89410E20A;
 Mon,  5 Oct 2026 19:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU9msaBPnKuNsq6WQBxz6PkQsyL9gQFTZyoe9wMcReuLrwpzB8n1nictezqM/VAqD37ecfv4aWPeTR/Buz5eVl3F2TnTmU1kGfHGtFkV1TW3pXXj4IXbXQ7VraaLJdwAocadgg66dLhm2UmuzeeeoGKwewfDm5eKxMasa2Cfh1ILYZREW9suIw7nQSBmBZ370bAwI9UDNb/UQM5hIKqhQ9oNSbw5gWE6yK62p1SaQnUJSGe95quFjkG6PyBbbFC6krLDV+zrW2Rh5edlwuKVSNJ8ZK7B3fCCf/8RNfgjhh5n8hupWX75R0RMNJZl+a9rGVX45L+xMDLBj1Bdj4vSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR89lu3tuOqauMwnlbX9GtagJtGIUe/Rt7OovjzOldY=;
 b=oGrhXP3dMe7Zvhlmf2XmVN66pKLonjeT/HEqXN1rtre7x5yfgoFIf25lGRNWH+d9wnsLCvXADmWD5iUyrortDV4SYtNRZmjdTnMGYz2mIDv+KQXHwxMOScKXpplj18VV5kdcVU4TlGNbE1K5Nj3Sie8EH0hKp7PCOgduBenJnJnLAgtmVWHKsZ/aVAj6GvIgusBRw/SjKZ8AANuN0Dve3BIDDAtXSCXFjpYIBY5Y5v8OoeWqMxUTfSBPY8Glv+y0bmlXZLZ71sHeRMFUg0dR7QrzXriZnpRZKXZr21fWhyBTFriBO8zZFIv1slN4vD7WuNgJunHmqhJijs49AB9lRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR89lu3tuOqauMwnlbX9GtagJtGIUe/Rt7OovjzOldY=;
 b=3pGGocrW0VRlu4Ubq78CHU4d5SRlz/tN0hcEsGKF/JRsCx3JIqnnwR1TJVXnSekR8wnKNNkd+BiCydyALm24UJq9istmIpBMy6SoYYgUNfpi94PX/kpvAAnVzEWPFlr+x7CSAhmrjtxMCE78uB5oT3QbIGnR+YXxQQ+YfC9Gm0Q=
Received: from DM6PR04CA0028.namprd04.prod.outlook.com (2603:10b6:5:334::33)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 19:46:00 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::23) by DM6PR04CA0028.outlook.office365.com
 (2603:10b6:5:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:46:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:46:00 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 14:45:58 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Curtis Vogt
 <curtis.vogt@gmail.com>
Subject: [PATCH v2 1/2] drm/edid: Add a connector-specific DDC probe callback
Date: Mon, 5 Oct 2026 14:45:45 -0500
Message-ID: <20261005194546.1712792-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005194546.1712792-1-mario.limonciello@amd.com>
References: <20261005194546.1712792-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 0224751c-0717-4dda-7bf9-08df2319485e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|3023799007|10067099003|11063799006|56012099006|260925021911599003|260925021311599003|260925022911599003|18002099003;
X-Microsoft-Antispam-Message-Info: wnzN+6aI759QXQA9SCeiRBYXybPs2LAH2OMRSmuUg5E6f2MiVso88PHp+MMqiaRDkdUQlEonQ/CPpu0EFzOjFnZ6+jAdK/RqJjJrghNmJbFcGJ8sG3wmfzMI99gXYczqx2IWw60SBgF7okLZlBg4hwbwEDrfkKtiDeqlibRxTxeZLbG/oFkkitsRhJv7pzoDeYSj3oEs3N+kkLzjK3xIx0yxz6O3JeugMvNjkvv6PhJwmuyceIU+E5hTJAgFtnRKAEqtnnNeO2z63VSCbQ5XtqxS85ErbN148vIZG0lXNZPZVA5rnmRjwgi/O4mIRnahuKHW2Q/2eUM3cxGhLGr5Bz6+1oS1zw+vwcGUKSdZ7cY5Lbgv0FH8kNYIkuoPj0PAvoiMJC2sqeGegH8rQeiXwZUBOmUxjmgW2+tRN2H8wIWfkFkaqBWARuwL2O9/xMSDh5yombR7bIBrqIIAryrzKd+NGsIMs/FDll8a9zLVM9YGbgNA+2T/CdbRCvlLyvNv4sKOHlWe+uykZKmS2ZTSAN2JNTnVSOl2BUdW6ddKZ6sL1vrfMgE2HosO9C9bzDFkQ8iAiOM1tIHmlGCLo8PEloiFHqRFbkwyyL6tHL6eyQhvL8xXgVBZZ/5JTk3YwDQf6vK47JLPPC07sUH93B9R1cq0z14ZeF8fhvG62u9VYwX6CSZ0nxgrzMJWgazpcSLOtwdktVKI+blagS19nBchpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8s5lG6yWXb8Y/PFW3HZH3X0OWeh4JVxQo1m4x0TAAcxUxlFWGuVwtdazuzUfMumHrzpnAXoAY43fqJtiz2ytFCvV79HuTgM2Z6xtEbvZYsz2ZDFxX8tPGIX+wnYgV8b93/AD8gp8WcyBvo6XPofvQOmKvdTDeEUHMoAG4Iwys/j+aJG4K6dZjbr+vX20H+f+yHiJ+txVeITtMFUX6YDHj/M+qEkc935jl2hG0bHn0FgfidCVH1MScbkVPTFPaCxLFPlpCXSGELity+7yXUHzX4lhHefgScRJUZBkTAEZKjy4r3OmxNosvNMA019980jKx5n/45sJr/TgtiaAdXcyQxccV1YjKf/lwpe4RvrckYDye5p+brXK7Qdrtt5b+CS8GL8MNEMgxX7o28X7M8Y22cEc2hlGyQlGijrDaLUFFEmWRkbyWt4Yo6M5RKnIaq/h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:46:00.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0224751c-0717-4dda-7bf9-08df2319485e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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

The EDID helpers probe DDC before consulting debugfs or firmware
overrides. This preserves connector-detection semantics for drivers that
use a successful DDC probe as presence evidence, but it prevents drivers
with independent presence detection from using an override when DDC is
unresponsive.

Add an optional connector callback that replaces drm_probe_ddc() in
drm_get_edid() and drm_edid_read_ddc(). Drivers can report presence using
their own reliable detection while retaining the unified override and
firmware EDID handling in DRM core.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Curtis Vogt <curtis.vogt@gmail.com>
 drivers/gpu/drm/drm_edid.c  | 15 +++++++++++++--
 include/drm/drm_connector.h | 17 +++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3148038747b6e..c0e73ead308d3 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2643,6 +2643,15 @@ drm_probe_ddc(struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL(drm_probe_ddc);
 
+static bool drm_connector_probe_ddc(struct drm_connector *connector,
+				    struct i2c_adapter *adapter)
+{
+	if (connector->funcs->probe_ddc)
+		return connector->funcs->probe_ddc(connector);
+
+	return drm_probe_ddc(adapter);
+}
+
 /**
  * drm_get_edid - get EDID data, if available
  * @connector: connector we're probing
@@ -2661,7 +2670,8 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 	if (connector->force == DRM_FORCE_OFF)
 		return NULL;
 
-	if (connector->force == DRM_FORCE_UNSPECIFIED && !drm_probe_ddc(adapter))
+	if (connector->force == DRM_FORCE_UNSPECIFIED &&
+	    !drm_connector_probe_ddc(connector, adapter))
 		return NULL;
 
 	edid = _drm_do_get_edid(connector, drm_do_probe_ddc_edid, adapter, NULL);
@@ -2742,7 +2752,8 @@ const struct drm_edid *drm_edid_read_ddc(struct drm_connector *connector,
 	if (connector->force == DRM_FORCE_OFF)
 		return NULL;
 
-	if (connector->force == DRM_FORCE_UNSPECIFIED && !drm_probe_ddc(adapter))
+	if (connector->force == DRM_FORCE_UNSPECIFIED &&
+	    !drm_connector_probe_ddc(connector, adapter))
 		return NULL;
 
 	drm_edid = drm_edid_read_custom(connector, drm_do_probe_ddc_edid, adapter);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aae..185cefe6e292f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1640,6 +1640,23 @@ struct drm_connector_hdmi_funcs {
  * etc.
  */
 struct drm_connector_funcs {
+	/**
+	 * @probe_ddc:
+	 *
+	 * Optional connector-specific replacement for drm_probe_ddc(). Drivers
+	 * may use this to report connector presence when they have a reliable
+	 * detection method other than probing the DDC bus.
+	 *
+	 * This callback is used by drm_get_edid() and drm_edid_read_ddc() before
+	 * retrieving an override or reading the EDID. If it is not implemented,
+	 * the helpers fall back to drm_probe_ddc().
+	 *
+	 * RETURNS:
+	 *
+	 * True if a sink is connected, false otherwise.
+	 */
+	bool (*probe_ddc)(struct drm_connector *connector);
+
 	/**
 	 * @dpms:
 	 *
-- 
2.43.0

