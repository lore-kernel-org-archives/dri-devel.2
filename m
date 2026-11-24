Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD2606A68D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC3C10ECBE;
	Tue, 24 Nov 2026 07:36:09 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022092.outbound.protection.outlook.com [52.101.126.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919D510ECBE
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTVx/SQNszfZfWz1nxqruCGb5h2Udm7kgYBBHpIwHJw2HHHlI6EiWT4AWY0cY65n8+V5teJgqbYHwkr9CROZtj7LxN6VVmbxSKWxD+UEYwJ6kFOsSzAST387kltijGrODaHmRPXCdinV4qrOQGK6B4TcJI+0qUvnAGV0+Qyo2zxzT1H/eWXUcMg69Mojv9Dk0Ghp0/tdpBgdDqkbXg484MfsULGi/5e2My5FbWwUlXavScqETohFryN05ZWwsnd0t+vpn9v8aYr0ubIBei8IUK+UdjK27tSK56qIY/VBRlKy6XaV07ax5ZkfHD7uaOilhGc7B3n7gN2gz9BZ1ZkqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lnh4Hz6eypUahM6CD4PAa9VLWuCYpWMG2wp8hO4gGKw=;
 b=J9rZkby2i7KPk7uA/053dXv7YZcuEudK2joExbI1EHeGnfDX6P4ibAHxQHe+V/G4Ym5EdHdDgI84KptoUGbFPgC3T0re62Gx+ZoTH3dji+EtyKoSwpYKjinBkd2g1grCvmRNI85dQ6bOl8EOYu+QXFz1zofnFCAL114mxcva3V2eKScW/MnTRTcxG0Z2TcDJuJ+zwAxNY+LvJqExyIE2MIvWfdFWcvHkel/sxkyu3wZF4yAkcX0HjH+PN5myWZMYk/pnxyC8uiG8QypKNDbjZ4maFIbYT0HT4r7RBnHUDA6R4ykohsCKaA1yiFeiRnYUassxYUeSSWyfy14+DeTyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI3PR02CA0003.apcprd02.prod.outlook.com (2603:1096:4:295::15)
 by SEYPR06MB5038.apcprd06.prod.outlook.com (2603:1096:101:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 07:36:03 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:295:cafe::8b) by SI3PR02CA0003.outlook.office365.com
 (2603:1096:4:295::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 07:36:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 07:36:02 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9B92A427EFD7;
 Tue, 24 Nov 2026 15:36:00 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 cix-kernel-upstream@cixtech.com
Cc: airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Wuyi.Shen@cixtech.com
Subject: [PATCH v2 0/3] drm/komeda: Use the bridge connector
Date: Tue, 24 Nov 2026 15:35:57 +0800
Message-Id: <20261124073600.3124817-1-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEYPR06MB5038:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26771266-3ff2-414d-ce4a-08df49fd976c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|42112799006|23010399003|36860700016|1800799024|376014|18002099003|6133799003|56012099006|261009220027099003|261028144727099003|261102123227099003|261021121427099003|261009221227099003|261026140227099003|261009223327099003|261026121527099003|261022075727099003|261009223027099003|261009221727099003|261022105027099003|10067099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: eDDA+nHkKTASKBzjvKKngAYMBr1rM0UPjCYojIOhOYj8QkUd/4N/MrWRUIgy79i72iCDb0FZvbu0V+drcE1Hh71JtAP08bTwMj/IuLScdhwH63wb1wVcPJGDkN2bOgY4k5xZu93QZVN6puSRS4Zdzkvxe2dDVGwraG9DRowQ1Ng4Zf6rzaoC7obu3+jeCwJ0Ol9w6XlNezKmf9FbXhy280CPutxvhUMKz1VEveWquH3dtJwFGr3rqJlkJZlSnNCcpm/tvKyf3y46Hl73vO46X/AXDyqBl63Bwzm5amWHcByUNN3pjA4Dw4hzAEfjXkeEj2ftP/CP4qKUe71evNhCl5mrohuMZ5GwYsxZtOCul3HlUEKgoKvCtt/HeTC0wBl6IHH15qzGY+9ZjB4zRUHrvQlBPvK5K3NF/3LQVt3D3cAgtipe4FjPGi4NIMfpUWkJ+n5P7WwhoTWyzEe5KxqyjDUymt6yUtZ0qg9EmmxqLnKRligqCyWHeY8n54Jf15uqqVGHOdVx7vkNoD7IWdkF4NRV6tTcCdhy5S82Rn9PK9JJyCzjO8sGRDGGV3z9sppELXMjW/KGlW8ukPXoA8XRqurESus/QQCLRhqptoXiI/KbbA5aaQGvxAlIs1VbeIH20XptxH+YceRyID1Ka/6ML3qn2/GibAeOUH9kuvJQ6pVM1Kfn9yia2XCX6Vnjcpdq
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(42112799006)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(6133799003)(56012099006)(261009220027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009221227099003)(261026140227099003)(261009223327099003)(261026121527099003)(261022075727099003)(261009223027099003)(261009221727099003)(261022105027099003)(10067099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: znKA9WH/nccUj6W3OFfQqpYcsJ2vs6hptilOM2mB4vSTZpdetIBevnPhGw8wFVMCrO+xtWu3mIpOr/xswAvf1+589J58DWpEslPn0QtlDFxubi1+q9eZ/xfcIfvyAECoqbLMib9t/SmIxR9SuYcNtGBKbFgf3T98prqp5LbMAqnIg7eih2bIxeI6sImmpTg91/+m+rxaqX7buqQqs7gXf8Z8H1dfkYaP084hOp4uehRoFR+0Xeclx/zUuxSa24BuSaNrj/cfvTBAMc4pqUvdGMZ63sWIPlumnV7VH5q/jPfgenHAMlk9t6XpGzKtkB3E/Ld5PBza/m8a4lA5quS5vYpNQRCm/N3ePiPMNowYpuRona+hQB3+JNS5P5k6ty1J1SdVqw+WqUvDIfGWx3SSBk9Bul68hp8ljLE1DPFYO9z1IbFg5R7uYWsV8TtQtLRS
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:36:02.4194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26771266-3ff2-414d-ce4a-08df49fd976c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5038
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first patch converts komeda to the new DRM bridge model. Bridges
following that model no longer create a connector themselves, so the
display driver attaches them with DRM_BRIDGE_ATTACH_NO_CONNECTOR and
creates one connector for the whole chain with
drm_bridge_connector_init().

The second patch fixes the teardown path that the conversion exposes.
drm_bridge_connector_init() creates the connector with
drmm_connector_init(), which provides no ->destroy hook and leaves the
cleanup to a managed action. The drm_mode_config_cleanup() call in
komeda_kms_detach(), and in the komeda_kms_attach() error paths, drops
the connector references directly, so drm_connector_free() ends up
calling the NULL ->destroy pointer.

Switching to drmm_mode_config_init() lets the core release the mode
configuration after the connector cleanup actions have run. The komeda
private objects are then finalized by walking the pipelines instead of
mode_config.privobj_list, which also holds the bridges that the encoder
cleanup releases.

The third patch fixes a latent interrupt race found in review. The IRQ
is still registered after komeda_kms_detach(), and the
komeda_kms_attach() error path, clear drm->dev_private, so a shared
interrupt can reach komeda_kms_irq_handler() and dereference a NULL
mdev. It is independent of the conversion.

Luo Liu (3):
  drm/komeda: Use the bridge connector
  drm/komeda: Use drmm_mode_config_init()
  drm/komeda: Free the IRQ before clearing dev_private

 drivers/gpu/drm/arm/display/Kconfig           |  2 +
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 18 +++++++--
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 39 ++++++++++++-------
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 +-
 .../arm/display/komeda/komeda_private_obj.c   | 23 ++++++++---
 5 files changed, 60 insertions(+), 24 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.25.1

