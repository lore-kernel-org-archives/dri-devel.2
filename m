Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F74606BA5C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=b7ZdO7Vw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8E310E4AF;
	Mon,  2 Nov 2026 17:55:10 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE50F10E0E4;
 Mon,  2 Nov 2026 17:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6xYPhWXc1z2R3R3NWuG8Qq4H3ix9m88vnUwYN70oTPyhSF2gEa4+gxDYkz83GrbU3ajJQF7jCmQizsLxoboY6dp5pQFOxPBD5eAk4JI8v7q5Ysa4hPQ+2c/x1B+YItD9PTk/7W3PQua9c3RPgXZ83OylnKQhf1ktOfSbRq+W2C8pSCaQtm7tE19XVAkekUX4zNlZURkFKRdoEqvvKehtRmoxXk0mazlNT5ZgRzGjvsfX+yHaKIzRmFLHI11COmZYXBW39o9QjYzwFTw4tTymFhncI823BaMLfQnW+Dv+sW/VlAPwAHoyH0EZaWf/5GSZEF1UnEltYul4a20LQfk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSP/L+1wwjyy9SUn/66ePOLwVbTRndmKdKOYPxLc9X8=;
 b=ffS3IovrB4cLkiBmvJUQMPFDWwn1DJyvp4C26/nNeeXiJZ3RtdvO7ftSDPizzsmBL5Y5hafQeW7Ankf8wIXVwvfUF1S9TKlm6oVE6zFcF0O97hiElDgF3i5CYj1MWoRGZ9BRX3nXZ7W6smeUv2/FclUbiyv21zvGMGNEhL6vcFQB/vKvPsyzQV/YIaeI7sgi6RnWHdEmqKAfuNK+awyMlOq/vPl8sD7yso+lGqW6hpXusygbQ6GFhQuNKOxjAsN3CJKY3vOS6E/AkFoFAuvQAhXcgsByBymLDSOKFOoFyWFbOhHlH9ayzIdz8AvlKx4EO10O7eeFMTnDKEj6Kci7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hughsie.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSP/L+1wwjyy9SUn/66ePOLwVbTRndmKdKOYPxLc9X8=;
 b=b7ZdO7VwsCcWgJsCc1f6cbg1+i8CrrUjIWi7TFrt/tANZh3g2p6ReZKEeIGgiWoQqArKSdWNtu+jGTlhqm7LxgGR9SAuEZ5KfTLFDWP5X1xtga333E0KymZKkC1EaUvxUSmRdky7x+m7vIE9C9i406QE2/KrxSguOm23zUwOtjY=
Received: from SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::7)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:54:57 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::42) by SJ0P220CA0001.outlook.office365.com
 (2603:10b6:a03:41b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 17:54:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 17:54:57 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 11:54:55 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 2 Nov 2026 11:54:52 -0600
Subject: [PATCH] drm/amd/display: Point the DP/eDP connector ddc link at
 the AUX i2c adapter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com>
X-B4-Tracking: v=1; b=H4sIAGvO6GoC/yXMQQqDQAxA0atI1g0kKbjoVaQLnYmagjpMOkUQ7
 95pXb7F/we4ZlOHR3NA1o+5bWsF3xoIc79OiharQUhaZhL0kjQvjP0Sp1QwxoDtfSQdmAKJQA1
 T1tH2/7R7XvYyvDS8fyc4zy+YyvSMdgAAAA==
X-Change-ID: 20261102-superm1-amdgpu-ddc-63f0eb10c022
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
CC: Richard Hughes <richard@hughsie.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <simonit.orig@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: a26466ff-39ec-487d-712e-08df390a685a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|18002099003|261102123227099003|13003099007|56012099006|11063799006|261022105027099003|261026121527099003|261009223027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: i6npFq4/hMpE67/V2AOSq1ZPfdUDNl9ODhG0vul6t+XuATYD6C7eyHdP9VAbWT7vnkU3B5AAxx22+QIFStgWi24ncIu7QmaEtxUKELYYZ0Rum1TdZsrEwRdnz1jM9gwpX5gSvBMg+p4nGO7+zsV7eD5kCAra+9JIEz62+uEjoLscabmCYGl8+gQYKMvdDFc7qQrYXnR2uuB7TaIDh5lwPct+yfvWFUGBWWekPH3t6a/BjwGM7QAtsgsxgmECzMEAf5KdO+WhaZg1cUGLlb1LTokEePug9xu16/xujCVv0Ss9Ebw/oPuztpvlBEoj3xJnUrt8D8RoxRmW5fkiAsFPln4x2PORBLxIuINiKCStf36zrjlQqs5dEdwWg9WsRHMqlRw0TELuL6GztffjBtQ5BbQ7ebSMVYe4l9dBsGNs3znKkEnFLpyS1Li/H/p/PHpTCMt4yJquZkkjB8Gj8iBpapRAX1bvH+ZO1KWfVB/D3/E4XouS1vERjf8WlR96S99lMpXy6oaNLFKsE8ho5CeWKpj4vC6dwwsD4utweUzTuF9EqPXHusk66bS2FkXCaZbrBQ4gLOWIjYfkNEP6o7pNbWntuHIZJOdNj4KA5F6d7/FfGCfDbiYl+Vbs853xelFGLb68W2r16AeXstfS3nBSZaAK2KiicS5LDzXo+dHZ+sD5vWfLYIw+r+W7tY/IyOsMGSMNX3RHQN60zSMjZ4kEoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(261102123227099003)(13003099007)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261009223027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +HCwOacD2Ejk/nNHm873XA/gkrdaeWjPpKistaLpKre3ZMZheXC3ySMwj9n8wGRLPSzZQ/3WBMBQFmkSPfhqswWi8eTeH3zdBeKcuXOSPcOXkHX93ucDJZx+6fKQqMdlotqHIWR0SYxZbrd09t5wH15xKcsvC88Td+9jjk646sNd6WtfzvbMUfv48vG/gcyQI+BmvJDUtvGSE7waw1+pAzhuaAoQ0k81ecsaP5uwgkpYHVFxc1rgDKM4J85pHqL4bpyCRuqEUkHsycQpn6JkFu+ssh12YSJPDU8mHhV/NM5EwQwCTTJVlK6uLvh19YJf+LmG68vop040JI6rrHNQypsoEoAKnMT2m1/teov0JNsGfSGopFO3ATlGLoTaAMftr+DlWQYzjENG9AuLl/uuV2sKmTEdF8UNhhnw+B/Q+m7TnTt1UDhKqP3nien71mY/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:54:57.1828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26466ff-39ec-487d-712e-08df390a685a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DisplayPort and eDP connectors DDC is tunneled over the AUX channel,
but amdgpu_dm registers the physical i2c bus ("AMDGPU DM i2c hw bus N")
as the connector's ddc adapter.  The "ddc" sysfs symlink therefore points
at a bus that does not reach the sink, while the AUX backed adapter
("AMDGPU DM aux hw bus N"), which is registered as a child of the
connector, does.  Userspace such as fwupd, which uses the "ddc" link for
DDC/CI, has to work around this.

Pass the AUX ddc adapter to drm_connector_init_with_ddc() for DP and eDP
connectors.  The adapter is registered in late_register, before the core
creates the "ddc" link, so the link resolves correctly.  Other connector
types keep using the physical i2c bus.

Reported-by: simonit.orig@gmail.com
Closes: https://github.com/fwupd/fwupd/pull/11308
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index b498fc5fbb140..656249dc3f69b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3483,6 +3483,7 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	struct amdgpu_i2c_adapter *i2c;
+	struct i2c_adapter *ddc;
 
 	/* Not needed for writeback connector */
 	link->priv = aconnector;
@@ -3504,12 +3505,24 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 
 	connector_type = to_drm_connector_type(link->connector_signal, link->link_id.id);
 
+	/*
+	 * On DisplayPort DDC is tunneled over the AUX channel, so expose the
+	 * AUX backed i2c adapter (registered in late_register) as the
+	 * connector's "ddc" sysfs link.  The physical i2c bus doesn't reach
+	 * the sink.
+	 */
+	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	    connector_type == DRM_MODE_CONNECTOR_eDP)
+		ddc = &aconnector->dm_dp_aux.aux.ddc;
+	else
+		ddc = &i2c->base;
+
 	res = drm_connector_init_with_ddc(
 			dm->ddev,
 			&aconnector->base,
 			&amdgpu_dm_connector_funcs,
 			connector_type,
-			&i2c->base);
+			ddc);
 
 	if (res) {
 		drm_err(adev_to_drm(dm->adev), "connector_init failed\n");

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-superm1-amdgpu-ddc-63f0eb10c022

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

