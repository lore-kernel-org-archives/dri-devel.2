Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE460A2600
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EF010F410;
	Tue, 24 Nov 2026 09:41:34 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023137.outbound.protection.outlook.com [52.101.127.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6D510F40E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWmacN5IJlSRNUgdIAFHUD6yJVYrsJRYmey8xLCCCtoMxCEtdIoyXpqLVozo7kSdNDMUsVE3pAqyGiJmvVdFufgjIHVa8HutOTa7lVqVM3VEfddiecpt6yYtJdMb60V9Mc8CS0KUJFjAEfN0b/uOkNUAgL4NcJVNLB2vZw3fGSTr5AnWO+hoMyHubZMu6oBcfnO1LyxPlsRCfzPhZrD+vfeohxYMgu1Gc3L68TmVnr8ihqw2BS/WZOQ7+TlFsEHb5i1Hwvli1Lk5N45SAzlTGSPTkHvgwRiF3L6gkmSXQ1RuEGzwVGujmMvt+5A+rT8v3uyxofNT55eXPkAyMdqgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIzumed32/gBxKUGHWy4CfR/6gKb5JJOIkbUwJqmZ/4=;
 b=iN6wpwZQ+py+jnhCA6DhrL+77295CiFtG2NKP5aitMrCfxtVb2kuTyrK/xgkmZNj7dyjmHhfoWjnAakmMdnKWA74kiHIaR7g07FbBTQm2lks6oSqG6mKdeTrzbTtNrBtvXJyIPflOb3BfLcG45qCWQ2Y6nCARUZe7m0Xr/JwV79EdvdF4pgDEVrAOOhto+sWMGQ4rR0O5SzNMrN5hier2QdzqS/pkQOxGqrlbqJWHSHUbqcFzzhrfDyl3lUp0ApmQeKNr2lLIwM5gB1F+WxQmJIU4nlZwJ83oCsWOu+6yHJDNgSanVH72bBwfsWqAwoXhI6XXDnLBajUx0O6eZlBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) by KL1PR06MB6942.apcprd06.prod.outlook.com
 (2603:1096:820:129::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 09:41:22 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:189:cafe::83) by SG2PR01CA0183.outlook.office365.com
 (2603:1096:4:189::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 09:41:21 +0000
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
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:41:20 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 16CA9427EFD4;
 Tue, 24 Nov 2026 17:41:20 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Liviu Dudau <liviu.dudau@arm.com>,
 Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org
Cc: Ayan Halder <Ayan.Halder@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 Wuyi.Shen@cixtech.com
Subject: [PATCH v3 0/4] drm/komeda: Use the bridge connector
Date: Tue, 24 Nov 2026 17:41:15 +0800
Message-Id: <20261124094119.3220267-1-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|KL1PR06MB6942:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ae942c6-61f5-413b-73ae-08df4a0f18b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|42112799006|261102123227099003|10067099003|261009223327099003|261026121527099003|261009223027099003|261009220027099003|261028144727099003|261009221727099003|261026140227099003|261022105027099003|261021121427099003|261009221227099003|261022075727099003|261021123027099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: j8QcswIig2IDl0/yFzQGBFeSksJvITyh9cmVM1yuKNy1K71nHECbyFa3YLWVp0nQZodbEgvh4o1wSxpG4MeL+EN8SO/f7AtTHytNT4xyTAS0WrGQQZJYxwLtPO4CvWLeu7CuPNkuHujRiuT03jZcIasgM2fmINYppo2czmg9CV5Xgk1rzp+8GBQfXm6PK4yqAdUzqk8LLWgdnNtqIhOTr9B5E8WYtXWH++PTjUYwFy2HDfTy8Be0kKjGJIAKajpDyEU4MEHzzlE8NqUPiCQp50fN11v3EV79XZP0NAB+HBgwc2UuqccDuCI1bLaxO48lI3dcv3ymYvmchiAHTGcO0apri3OvfbgwEPzgICeX1TxaeMXljoTtEQfjD8MJ4mSQ5f4N8UTzlWMiUiuJoWQN6hidnj66kMjHRIaBMXbnlbkSnekrhBF1NJf0Ze7y9RQeLAVOQw/qSxCy7PkOl1dv64O/EcdEQObgPkx1N/80jRuUBNn68Ib+Fcs3EBESLz0sKRI4nPuzZxM48TL4tUV61p7cbxfzzkoTC3xyid6zKd4n2P9h0tnT5OyVcrUVwUD1QeBAlr/N/JYiAUcIwemDZqyX4dtlsDRPob7UjbNM6UU2rEywnAr3sjAc+Ku4gMMMrCDO97Z1G2NMoTjO86cLPkS/uNtTtRKkQ/bm8TNCUHmrmWoyZEnNh5ARVDCldkN0
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(42112799006)(261102123227099003)(10067099003)(261009223327099003)(261026121527099003)(261009223027099003)(261009220027099003)(261028144727099003)(261009221727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261009221227099003)(261022075727099003)(261021123027099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O9X/CssKaycyF2zBO+yZDmZ+bA5t8xe+RysPmAGlFQub8eOuN46CWMVDfCgjkTK8CcjjuYPhMij1lfdRHfdm2FgmGiIyWBBCTIKA3B3Dz0SDQK94Ssd0paAVxihx+n6adQEWc2FSmD+IuB0VL7cZHtzEIQIsMAHPGiCwh9kI9d/vXF9aEjQRK9SCFxea2RjJraRw0PzyJqn+OuXhkRwmMIYYoFeytWd23zF5sOBSipFiGDhU41EjPpnBsfYo/euRLJqDRJMrk3uP6Ve27dmi5QWOXoR/fKJea3uHewjv7UBnnCsscfO5I6NCz7lZefNgLMbNcOd4vr9VO6FwHdugRjO7uKLlBAl/8+YQsPe6MXQRpjMIlsZHgXn2swljgNw/iJMdZN1zBqSsA4yHjP6zJR7ueIaxpHHiierL0g3hdXuuhz2p96GeeXrJLDt3Ccg9
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:41:20.7677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae942c6-61f5-413b-73ae-08df4a0f18b4
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6942
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

The fourth patch fixes the tda998x bridge, which accepts the
connector-less attach flag but keeps using its own connector. In that
mode the connector is never initialised, so the bridge reads an empty
display_info and ELD and stays in DVI mode without sending hotplug
events. Use the connector provided to the detect and EDID read
operations, report hotplug through drm_bridge_hpd_notify() and
advertise interlaced mode support through the bridge.

Changes in v3:
- Add a fix for the tda998x bridge, which accepts
  DRM_BRIDGE_ATTACH_NO_CONNECTOR but keeps using its own connector.

Luo Liu (4):
  drm/komeda: Use the bridge connector
  drm/komeda: Use drmm_mode_config_init()
  drm/komeda: Free the IRQ before clearing dev_private
  drm/bridge: tda998x: fix DRM_BRIDGE_ATTACH_NO_CONNECTOR support

 drivers/gpu/drm/arm/display/Kconfig           |  2 +
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 18 +++++-
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 39 ++++++-----
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 +-
 .../arm/display/komeda/komeda_private_obj.c   | 23 +++++--
 drivers/gpu/drm/bridge/tda998x_drv.c          | 64 +++++++++++++------
 6 files changed, 105 insertions(+), 43 deletions(-)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--
2.25.1

