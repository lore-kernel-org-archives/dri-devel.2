Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE40606A68B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C26710F40B;
	Tue, 24 Nov 2026 09:39:57 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022123.outbound.protection.outlook.com [40.107.75.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B5010F405
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfyopID4Wc1VozArl1akIf/kTq7agDfopBVmrp1AOQJS17HO5JQaAm8FcBa2rSpK9XkGDFHZDr6izTCnKHsRUXxdA1oiJxcixZUycIP8XDOM9U0LP11XpFD9HI4iegxpf25WToukcbszwb1UJqhcP9VpJjDGR5mDYgGlQ1oL1dnVTuubt8x+MGNXcs6RljxXrqkNY4181FeFA7S5H/2gX1ad/oz0+g5r2lMAvTwSyCjjhSGDkgibYFOaX533lAGXxcjjW2Grazvi0ramapsErFPZiaf9tJ54YvC3pHkr4CU9MnnCqhBjWeC/ZCA1SPts7DsUWG6MxpxlNHwNR/+rQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIzumed32/gBxKUGHWy4CfR/6gKb5JJOIkbUwJqmZ/4=;
 b=Pkyd7m8Y6BYUQUBTCgDERI7bOw9xqi63B0hKAlXbCeGJy3WOfwwAcUpf13agUdNd5kyCPdOvXYpvjDmaF26TJtV3pTnLvUDi6YL4U8AHE10z4RENfZIyKhZXxrMIc+m5cF/9LSfq+fimW6uYDiYPlcZdptvZ8BRzF3GF35UoyYAqxdiY5SwePuFRQxyFq2DzTqwVCyuRx8Qp33we4j/Kg3qAv1CXNHq5W8GXPRI1KP8iylac/RYcPf0w5xmpMbUhFGaamQmzKSMtfaXyPErj/HldoMVetnAAvLAYUiXgruhVhUdfbapSEaj7HDaS2884UxwBXevIFPzRuzQiTt3XwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PSAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:301:19::13)
 by TYZPR06MB6934.apcprd06.prod.outlook.com (2603:1096:405:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Tue, 24 Nov
 2026 09:39:31 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:301:19:cafe::8) by PSAPR04CA0006.outlook.office365.com
 (2603:1096:301:19::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 09:39:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:39:29 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 251EF427EFC6;
 Tue, 24 Nov 2026 17:39:28 +0800 (CST)
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
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] drm/komeda: Use the bridge connector
Date: Tue, 24 Nov 2026 17:39:24 +0800
Message-Id: <20261124093928.3220071-1-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|TYZPR06MB6934:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5686c125-e690-4bca-e527-08df4a0ed67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|42112799006|10067099003|261022075727099003|261009221727099003|261009220027099003|56012099006|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261009223327099003|261026121527099003|261009223027099003|261009221227099003|261028144727099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: mVmvPqm8i3aS8ipHWErU/TPbDMfOLEC3xjIIeoprmqN97XpzdaBuagMOEHSLzMf/iweFTsYj3yl75BkwyIAb4eMMH8b5Gcb2ONoKLeQ36dzzoYY/XaYneOt1tN82MwUIQ9JxCilwPUreUOzsyBnYYBRC737lXiDR/Wrh4BqVx7CG0k+FMaeZkN8w8lkbHBnnUFsC+3LLrJexzXWaZGOVN6WIKYMHb8wtLcS/wbBvLXByVckYt2EfkdpJknMjkVlSYDDKMb6JI4ujzc2av2tb2eSeW9/sfZpiJyNSoLFRLj3cwhNZ1x3MsmkJs59xHMSjhGUxOuHCU0RENhJGcmH/3c8Eux7lCm+jHOFrS64EtHOg9HqaXnSJhi3PGcgLfBqaBgSSPw37EHhAC11YtmwTWaGbec52DNEO8KuoW5PtdtB+zwLIpYiiLokqoV/56Zq4Ir8DEaeFtfl+sfQ+pxOXKtR2XIKcTyS6pgdGGwc6klPbJt3dTZeEwFlY1PRTGhXK2UQ7YV7ctwMnTG3fZQvZRoyDfrocJiIYu8yMBJ1b8H2SzeV/fKMwavxaP1cuZLG9bekWsjwXkxkPO++0/fzuuBOeoQTcNk84Le7Q5MmyHM6zKzqT14jp+NrLt0aGDLZDwJZXJh7jGPZI7wO9t8jv4nwS2K7uhSQd8fSS8p8cFkFbmc1h+L+WJTRIvr0bx4pK
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(42112799006)(10067099003)(261022075727099003)(261009221727099003)(261009220027099003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261009223327099003)(261026121527099003)(261009223027099003)(261009221227099003)(261028144727099003)(261102123227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aNroUTQJq1/jLn2AFJrrQ5uI6NHR4dsK++m0tlvTRl2NVLxdH5t544pDyJC3h+jl6Q7PAvqPYgDgq4sZaqAFGHIrNZSbZeaXXX6FpNyvvZYLyhB5QPFSiMdvqODG7EN2U7RPRTrL+eqJELLQ9VwnMBZW1yNioK3fHyTCqgGmB6agOUIiWqWHgPaUqFYW+ODzWUnVufnVtW2uWuH5DAWwb2Cbgcml46DtmaInU7GpHaCITgfqi+K0Z4zd/GvabS1T7ZMYNv2PYg3FqbR6QcG4pzvXWzGTyldAnFd80I/ybSoDUWiG+LfYW4i5Iv/DYjpatJDbbElkW8grBlabPXB+TFAY0/GAoUZYNMfcz1oIIQpbZd2+VZt4h8lGb/iPBA1cm0bYN8Lcyh20ZJF6IyYseTAwpzx99sc6enRzBuo2pHRtYYHcwQuzMzrkNgYBcdZk
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:39:29.5800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5686c125-e690-4bca-e527-08df4a0ed67c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6934
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

