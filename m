Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCAECA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B5410EE54;
	Mon,  5 Oct 2026 19:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CwV8UX8F";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7073510EE45;
 Mon,  5 Oct 2026 19:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXB4WBqdlYonX6D2nncdtSD+6fNuKSRqWS4JeG/coqu0Q8m0gGZySaEJMOOwbWbnGMPoRo8tZGq5vkzx4vederDZLZbFVOmHFAno95lqpUE+KtsA5R6t8VAWQm27LP0ZNT6pi7IvIjBio9Fj3q4Qhs6sxmA10kgrn8TT81Vg7jAdvR6RCUF5MVc5jTwzVdvLvraSzLXrGcrB3VnjWLy/2UyfTmVnwfUrxdHthJDHQDMiYFA6Ktyo8HTc9xPlVDn4EeBsJCuaguQBGm6wyXnD7AzPWnfzd/XsFmoRA8foqAnpMR5mcdeNDDnzU4rFqkUy1YcWLT2vTP6eZRVGvvLXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTc5FmCoO+l9mJ+jDXYlUg4FaLVx6R000ZhYQcszZvM=;
 b=FQuztREpcKCOaW3rDh4RCc2jENS/liSBGcny0TeAFjFEeq9FzlrEKk5nA0uo7hF8orSSV1KYABlYD5kX1slt3JB6ARFiMcRDIGQd2eEnwk/VNToouNZhkQMOv/sBVKOOxk55UTW7vMXV8DqXJKekpEBxCy84HWEggxsW23z+KEKVa3/DAdd68XIw4Tjg34Av734i3htq8WhZWj20MtijgWUBiic1j3d+4y5r/N8PLQOIFz8aGF8c0VQiuU1IevzyB/OSoTtremNTLZYdg7eqknx3Og9jArKBDqMYQvXMQc1YySyNXvZeKCTLlbvnF8eueX0VqS+3ZOtlI10YpjAmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTc5FmCoO+l9mJ+jDXYlUg4FaLVx6R000ZhYQcszZvM=;
 b=CwV8UX8FUsVjNarVpzfZsmQ01GOZmCUVvgbTewsEf700wLE/q+aoYMNOCAqrVnRgmRYb+bXBNJLNN2RVco4VFwY+FBwRKqQ3+BHF/d+44FHaxLS4VVCZutUa/ncy2EieW6fsvAe3HLUZQYVRPpgOi+9zbSo+KHhw1HfF3OlDvEI=
Received: from DM6PR04CA0006.namprd04.prod.outlook.com (2603:10b6:5:334::11)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 19:46:02 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::a2) by DM6PR04CA0006.outlook.office365.com
 (2603:10b6:5:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:46:01 +0000
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
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:46:01 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 14:45:58 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Curtis Vogt
 <curtis.vogt@gmail.com>
Subject: [PATCH v2 2/2] drm/amd/display: Honor EDID overrides for connected
 sinks
Date: Mon, 5 Oct 2026 14:45:46 -0500
Message-ID: <20261005194546.1712792-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 09be52a8-b64e-4f04-95be-08df231948ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|13003099007|22082099003|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4ez1y+/0ZeieUO3UTKeBaJwK24YvjxqrY7IwHt5e1yno1HvsTCnG+bbJsJqzYWb0H5rK5SuBq9LPOdLv3MQA4ZkE/VnZoN++eMWsid6iOjsCPZWWsWsYEp27T5eFZJCVKepxs7RUerEM9YLP18qhGtt/+spqH+XzrKm1A2Cuj0hSZBxslWgMcXK14094MXsYUMbLeRTBAcsySE65WxF3prYsjP/OT2AlJuViqH/3XJITvUSifdwXfa0Zhog4+6bDBksFRb3SVhKexibmvtnaNe/mOP9Y+Z+A+fHbzwq5+BS8pMNVa9XiuTW16mh7ekr8sxBeLx5YlrNPKXs1AVAJgaRkFQWfuys0OAyV64sUjaXQqOLDY4TJvRe2i2G+1uxfh9ttK5qW9TRMXfWV5AVy65Hv0n1ziJSksrKjXDo/WfHZiMyKtJ/yTvS4jvcqS5V+L6X0BayC7ljqzK68bXg03Pk6If1tKZxzTEagwn14wHAlbSoKbq1++5B2FsiXcRq0weBbwozF0e/zxNwD0U53BaainvBLT5EaSXO9NwsrqERnXEDoAqNnG0HR7hLdgKiNCEtLJD4pmXXOXE5Y8YM9ZbaM0xvrZw5eux1obZ3PW7QZiBv5t23rF5/OEU3xPgSl2gPupKWNQ196RsbbDQvX7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SKvBGXULfzCM/2BC0J+6Ct+gRGgi0xZodE7U8UaLC+PD9Fc1VMOyCIk/4mBI1EEBO46R1vojuGCr7EnnV6weA2hHrHoAkDy1A4OSXzLFv9+WfYCQTU1kIedRZQkbwouAxi4h3JQPZrwwaSjsPQ/RvOqGGRT6xOEF5xldGW75Hp5hio6rEBcNgcwrzaS+JGu3QHwP7DmxJ8OXTrowcIr4t/PGfvTTLMJhP+HWt/bslneLqHRyhlEzw/7P7VJNVoqsnOxSdkNhxUoM4U0S5JQbDH8PIaUpvX8aK15fcdtftD2VpACWP8Wm9H4KuO4wq9QGOEK1MD9bUXo2ey8i/IWgIti0Np5Q5QOdiP5L8SM+/PXjgRWuxw8tRald8vWJLAZ4aDS0aaZda9oPlF8QHLu9gV4fLGDyZ7QA8SwROd/2K1qmeo1l8AI+ynxuwoFlzuXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:46:01.3902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09be52a8-b64e-4f04-95be-08df231948ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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

Display Core determines whether a digital sink is physically connected
from HPD before dm_helpers_read_local_edid() attempts to acquire its EDID.

The helper eventually calls drm_edid_read_ddc(). For an unforced
connector, that function probes DDC before consulting a debugfs or
firmware override. If a present sink stops responding over DDC, the probe
returns early. The configured override is ignored, and AMDGPU creates a
640x480 fallback mode.

Use the connector DDC probe callback to report the connection type already
established by Display Core. This lets DRM core reach its unified override
and firmware EDID handling without making an override force a disconnected
connector on.

Reported-by: Curtis Vogt <curtis.vogt@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5779
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 25f168a8ea311..a3ab26b68a889 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2071,7 +2071,15 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *conn
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_force);
 
+static bool amdgpu_dm_connector_probe_ddc(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+	return aconnector->dc_link->type != dc_connection_none;
+}
+
 static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
+	.probe_ddc = amdgpu_dm_connector_probe_ddc,
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.detect = amdgpu_dm_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-- 
2.43.0

