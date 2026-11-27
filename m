Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F886606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A388910F51F;
	Fri, 27 Nov 2026 05:58:16 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023080.outbound.protection.outlook.com
 [40.107.44.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7AF10E9B4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFhIxMhribCn26XTYDPSDpQ1HAANhX9aIwfg+KLbCFnwmjlYs2Pb47GxTdwuyO1lshwUwg+pRL8fSacumEidhYlsjEZVjyKfunCRj4jK8VIPjmamlS4LZfeXdxZkrY2x69QglXkWe79kt9RgVDVOxiOsJfdQKSQEeIDbq2Nn4xwo8MVv3K3lpKABWj7dgL2P5Klis7dVrtriA2IobxEG4PrK6nema3VIOvuLgBEC+jTz1npIhirtkXHlk//4zzHRsScHtIoRLyoyQkeKS1KW2O/UblMmXmZitUbEs4alw5q6kteRnzQKBdN9nJUrKyx6NwMsDnfBKwWS91+9Y982Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Y12/iQo38OYg8UQ28fS5VRRpdi9fsugST0mkNbf1E=;
 b=JeiPL+QdH7Y+hluBXYQb1kTQ+Ux9JsK51TCmD4/dL3HHFeDfATalOUHVAcr5i2nVXuvCJpiLrNns53A+XQN+nUAqsyAznE6WDxBc5i52wiC67i6CPpw7NVtteXgqtyfK0ybw0xYX4fgGbciI61dA1DnsNMooD//MthALBBn2OYZbntHWCsdDuGieX+bcW8KThyMYBM3n21gVpyNbB1DrhTKyujYp31NV8n3e7FnNgOMJJfwZoZZjOcUdwdmRVnNIE1ph8x56ULMdhn38WlDElDo56vW/Zt/4WKIwUUC6opXvOjZBiibOvCqOecI3TWrsvnXiFioM7ripKA+V/J6HzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PUVP216CA0061.KORP216.PROD.OUTLOOK.COM (2603:1096:301:225::16)
 by SE3PR06MB8070.apcprd06.prod.outlook.com (2603:1096:101:2e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 05:58:10 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:301:225:cafe::2b) by PUVP216CA0061.outlook.office365.com
 (2603:1096:301:225::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 05:58:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 05:58:09 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 02297427EFD5;
 Fri, 27 Nov 2026 13:58:08 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v6 0/5] drm/bridge: trilinear: add the Sky1 DisplayPort
 transmitter
Date: Fri, 27 Nov 2026 13:58:02 +0800
Message-Id: <20261127055807.109667-1-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|SE3PR06MB8070:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d3e3cd8-45fc-4081-ef20-08df4c4b6a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|82310400026|23010399003|36860700016|376014|7416014|6133799003|18002099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|261009223327099003|3023799007|5023799004|261021121427099003|56012099006|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: wUrznBAd+z1tTEn7/DvO0El70j9DpNluyWyC+N8tRCZaRD429lfdfpHxHA7UpWHWaIBJZsk7H1XfCOiP9sWFv5iRAe7KOX/SQaCxIwr2PJjFieVfrKwQ1tw/U6WBLD/8hPQsuVb3MOuiTmyvXfhaJTtOz+jfHAEAPJXJG4/pW9+yQdKeh2YjpMgPPeXABCA4UtiOPoUueRt9GdQ8/s/EwO9mSjA2vMeZggE58WPCo2q6RWipJLuLUoea3XbO4j+xRlSU0f1tfACJLiGI5pucZrl0HsSk5p9DzDxaEv9zCaH7FPNHb0d9gunC14qi5XOryKgouFSZSiGgT9XvbnV+wVrv3Tc2hlCkSaEZTpnX2zhiTrMuoR6g/NwFtxf9mdJEsTtZAGjXAqQDPHMwsi7ID8MlKO3KfdQw8gCBK0X0Cv3TGi+dCphgUMWwyAFh3ydyY/7h9M0QCGxYHdfUW99ryeSHmnz7B46ez0SX4BQIVvKVjtkHhuP7IdzAK2A9aAdPoBMqNY2rYGc4G+H+SF/fq5KAtkHMOQA6jS/Y5v4MOvv8tqo1GDjdgufT2f9ygIRazeg505uRdWdo+iEcTqnSw4ET8yT/YBT5c9Rf7+rN8TVmJNMX4WJyO9AGNv3stkNrHRCtvDAEW/LUdl6J3CKxADJ/YZLuMBT3Fke+l9I+yZCR5NMVI39uxpeJWpy92sW6IITacFiUNVqV0zwBuKLCqw==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(6133799003)(18002099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(261009223327099003)(3023799007)(5023799004)(261021121427099003)(56012099006)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d06x7XtYzN6VIiw+5iIzf5hiJ+fBzCV1ZQFrWSEUOIk0tg5WhN+QPZtGO/XCXXPvUZg4Soi2+w9UORO1qX093wmWfqBk8fxzqGpOIF32WjNplpzrPvQkKagBkP6OiXM+bbLn5q6ZiKmCAQD8P5RaAFUVXHgo3/o54d8e+sG6QQ0QgyZ0iW07bwXu5TNpm34eU2ffS7tLeXcrZm/D6qSrq8rkpIShimt0lWHhPwjq+J0HyORIdwOkHMODfim5jR+/Kg1d2H+UKiYchZzwe9CP98xglPoDLieX+2hpkvDRZX4ctnyvFcwAlvb02UAJSFdFMgBWWbto47dcQ+eck3ywhdjLK3u+lbisFqO5HKT+Za7drmDgrhh/3Uos8LYLb/RjBvm5tjjGrTxuvB1mj9A2bytxupOXyyVOMhFNyXPdoyceVPGrzoIDZS2lapNFPOFs
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 05:58:09.4151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3e3cd8-45fc-4081-ef20-08df4c4b6a21
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8070
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

Add the Trilinear DisplayPort transmitter as a DRM bridge, with the CIX
Sky1 platform glue behind a platform data structure.

The hardware layer, the DRM bridge and the core state machine live in
drivers/gpu/drm/bridge/trilinear/, so other SoCs using the same
transmitter can share them; the platform registers its own dptx_plat_data
through include/drm/bridge/trilinear_dp.h. The transmitter drives up to
four lanes at HBR3 and has two SST sources. MST is not implemented and
stays disabled.

The USB-C transmitters and the native DP/eDP transmitter use different
RCSU video-adapter register offsets and bit layouts, so the binding has
one compatible for each. The Sky1 devicetree nodes are not included in
this posting.

Scope: DPTX hardware, bridge and bindings only. Komeda (the Sky1 display
controller that feeds these bridges) and the board DTS are separate
series. Nothing in this posting wires a full display stack.

Tested on a Radxa Orion O6 board; the USB-C DisplayPort output works
with the connector created by drm_bridge_connector_init().

Connector handling in this driver:

  The bridge is meant to be attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR
  and drm_bridge_connector_init() creates the connector from the bridge
  operations. The driver implements the bridge side only and never
  registers a connector of its own.

Changes in v6:
- Sink capabilities are re-read on every detect, and a failed read drops
  the connected state.
- The bridge adds the affected planes itself when a colorspace change
  forces a modeset.
- The downspread setting is forwarded to the PHY.
- Link-rate downshift covers every rate a sink can report as its
  maximum.
- Cleanups: drop the dead DPTX_STATE_INIT_TRAIN bit and a stale include,
  and move DPTX_VSC_COLORIMETRY_EN to the MISC1 group.

Luo Liu (5):
  dt-bindings: display: add CIX Sky1 DisplayPort transmitter
  drm/bridge: trilinear: add the DPTX hardware layer
  drm/bridge: trilinear: add the DPTX DRM bridge
  drm/bridge: trilinear: add the DPTX core and build glue
  drm/cix: add the Sky1 DisplayPort platform glue

 .../bindings/display/cix,sky1-dp.yaml         |  133 ++
 MAINTAINERS                                   |   12 +
 drivers/gpu/drm/Kconfig                       |    1 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/bridge/Kconfig                |    2 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/trilinear/Kconfig      |    9 +
 drivers/gpu/drm/bridge/trilinear/Makefile     |    4 +
 drivers/gpu/drm/bridge/trilinear/dptx.h       |  111 ++
 drivers/gpu/drm/bridge/trilinear/dptx_core.c  | 1053 +++++++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.c   |  719 +++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.h   |   17 +
 drivers/gpu/drm/bridge/trilinear/dptx_hw.c    | 1380 +++++++++++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_hw.h    |  103 ++
 drivers/gpu/drm/cix/Kconfig                   |    3 +
 drivers/gpu/drm/cix/Makefile                  |    3 +
 drivers/gpu/drm/cix/dptx/Kconfig              |   15 +
 drivers/gpu/drm/cix/dptx/Makefile             |    4 +
 drivers/gpu/drm/cix/dptx/cix_dptx.c           |  173 +++
 include/drm/bridge/trilinear_dp.h             |   74 +
 20 files changed, 3818 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
 create mode 100644 drivers/gpu/drm/bridge/trilinear/Kconfig
 create mode 100644 drivers/gpu/drm/bridge/trilinear/Makefile
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx.h
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_core.c
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.c
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.h
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_hw.c
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_hw.h
 create mode 100644 drivers/gpu/drm/cix/Kconfig
 create mode 100644 drivers/gpu/drm/cix/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/Kconfig
 create mode 100644 drivers/gpu/drm/cix/dptx/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.c
 create mode 100644 include/drm/bridge/trilinear_dp.h

--
2.25.1

