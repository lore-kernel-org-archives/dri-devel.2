Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1A606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A6310F00C;
	Wed, 25 Nov 2026 03:32:55 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023109.outbound.protection.outlook.com [52.101.127.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512AB10E345
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asF6EujxYp+8H0KphpMPpdn39ysbFCpd49bm3QtCZ1Z8w24tWiqCWadpt+GiBKxBKKLq8PpbtAz2Dw8VvXZsGAueTtIfH+AmNY2rRmLKqHJoLgU8/enagJEkouD5QW8m8/frvKYUTUqUI8qJ1L/Px1xHj6ZYkRPOzhzxqbjnDvQIEaJxz7owByDOXCZxwbDI9s/p60vM39qC/Du/XJhVYKNGZY3Ry3rHzlGDnnqUzfgfPLFe65NO/coJZS6WN3+E0tWMfrttK5wfRhvUcRQ6SB2XIWGWr/Qa/b7VnUkyqQ+S6ycfpPUooRwAu99MHpgsUatg7itaFVa18wipIHOVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HHJUwPDdIesF2jE9CWrCvYrfxoPRQMzPSCEEPpLNnc=;
 b=XohxX4HwmBzUOhQlVKmR0gBP3tTvxFrQ9eJh+6YjrgmRLB3EMAx0kNcZJo/6o8l9RO8jCUSqAFYhF4y78QZpE8gbaj59xymDWnTS3ymEdgGOnUSlxLGA8zhNETUk8NaS+uXLcbWW62rKouIciPgEB4MFyv3bAW8HQzNaZgJTlOXOtpJElI4WjdZBEbUn6x18gEouXovVC8eNGbU/Sq6IsA5KQIuIqkf9B7yM2WbP7cbBrBzzyy/q9manM293EMBTD0BUq7KOCW+ynM5ybLvNJoXtkLLhpBb/MuLx96/tn3f4m0oMaDor3gPAzp4D8yeWYeaXYoXuhkVd/TpQx0n//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS7PR01CA0235.jpnprd01.prod.outlook.com (2603:1096:604:25d::7)
 by OSNPR06MB9052.apcprd06.prod.outlook.com (2603:1096:604:481::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 03:32:42 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:604:25d:cafe::97) by OS7PR01CA0235.outlook.office365.com
 (2603:1096:604:25d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 03:32:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 03:32:40 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0FE31427EFC0;
 Wed, 25 Nov 2026 11:32:39 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v4 0/5] drm/bridge: trilinear: add the Sky1 DisplayPort
 transmitter
Date: Wed, 25 Nov 2026 11:32:33 +0800
Message-Id: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|OSNPR06MB9052:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9db9837e-682f-4049-1ab9-08df4aa4c248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|42112799006|1800799024|36860700016|23010399003|376014|7416014|18002099003|6133799003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|3023799007|56012099006|5023799004|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261022075727099003|261021123027099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: DGsTd1j0P8pcZgPddy6N2WA58cc5HyXdAOIIstG1ORJ0sxz2FMhFpnqb/5vf8u3Rs+c43I3N8A7rvEzj4l/JV1FeF9Cotb5S1VhLgG1nHLZ1d82zCrLnLKD8wRV9COZuf+7Xr17MwCrHSIvJW+UNP38zceL9p7Sh+pk/YHXtD8xSj0UUFK5prVIjwyd+pkc4rzfxXxR4FMk46ZszmE65XeE3n2MRSsANiJqsO0hT8FRRmbxwS/z+swbSV5UZpL2tGEQtMX6TiOkCNNBIeVgjuxUP08uMCM7kab0+zarYlFy7jasJG+xMbATPHBtzuEssEDB9izliWbJrBshAdosbxRjFz62OSdn+z6nElTJhZ0Eg/gsHXbRCYQudBnGBw+lp0yaL7vgBQyyqADfGOVQ4nQQ1jn4bpnqJVT5zulUbllCZgywkZPsjL55Ea3osr6DZ4zSaXAmioVu/zunhM1R+TSbCNcV4aFTpnWJdBQtQVeGAsTAKkhZBKVqLhG4Dcbh2bpbVJJIKoCRspFGX5ZzlHblMPX7kv0T8+OuGcmZMnFUP8xkMFIoe/aehfLOdoi2J2wGneDlkQ52Ns+5DP9TtQ33x1/1Vgw9SROCETMXVzLHDZM0CsbbLrtBHsENWg2XdmQFIn7NjhOdFJmJZMpWTchTeOcEN7UDpw+ShlbeNpFkvOml+M6g9wX1jwdMWWYvRuMENJR1CXNmachGp9lnqyw==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(42112799006)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(6133799003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(3023799007)(56012099006)(5023799004)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261022075727099003)(261021123027099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NfMI2yf85I9Xcwvy3bKUqAVPDCl2dgN7hwD+NGFtmyEDM+xCYbJekFFTxsxOWsYb2rBE+s3Gq/RALtzrr4uaanvHrBO4BOg8kWSML8rT+9rdYHU4FPSYwOLFwsZi2BMUdSfPfMlnCg4ynw3qVLy7nrU2XBQPaUP0pbJpNYOmX/D05e54FIA3gFk87cAIFtfLEbinNysjffErUEZFqdUeqHnSqnZ8ytlHYn6JwhqimQjDrh20z9xQ05orZKK0WVpfBbFy09ftWULQKihINu33UmbjGE1nQZIlxHpWoxvv37HLHkuBwoS8F/UtAWLF/AvLUF/HQJTkgnqUC3JDxfvnir/uSU7T8lDtYGJSTPfnsycGisFx8OBK1VJ5oerkSRqdbd7IxjaUF7WA/bbHOOkWpP8F3lFNolKqyS2EtRJVGHdyJPlAfbQ2xokoJpuUquVs
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:32:40.0999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9837e-682f-4049-1ab9-08df4aa4c248
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB9052
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

Changes in v4:
- Address the issues reported in the sashiko review of v3, most serious
  first:
  - dptx_detect() clears DPTX_STATE_CONNECTED when HPD is deasserted,
    and the hotplug worker updates dp->status in the same locked section
    as the state change, so an early userspace detect can neither keep
    stale sink capabilities nor suppress the hotplug notification.
  - dptx_pm_prepare() re-asserts DPTX_STATE_SUSPENDED and disables the
    interrupt again after cancelling the hotplug works, and dptx_detect()
    returns -EBUSY while suspended, so a concurrent detect or atomic
    enable cannot power the host back up during suspend.
  - dptx_irq_off() now requires dp->lock and is called with it held from
    dptx_pm_prepare() and dptx_deinit(), removing the unlocked
    dp->irq_suspended updates.
  - dptx_replay_deferred_hotplug() calls sink_present() under dp->lock
    and rechecks the pending state, so it cannot issue AUX transfers
    while dptx_host_deinit() gates the APB clock.
  - dptx_bridge_get_modes(), dptx_bridge_mode_valid() and
    dptx_bridge_atomic_check() read the link capabilities under
    dp->lock, so they cannot observe a half-refreshed DPCD capability
    set.
  - dptx_wait_phy_dp_mode() aborts on suspend, detach or HPD
    deassertion instead of polling for ten seconds, the hotplug worker
    skips detection when the PHY never entered DP mode, and it rechecks
    dptx_hpd_work_aborted() after detection before notifying, so no
    hotplug event is reported while suspended or detached.
  - dptx_get_irq() rejects the 0 returned by of_irq_get() when the
    interrupt cannot be mapped.
  - Mode validation matches what dptx_bridge_atomic_check() selects:
    dptx_bridge_mode_valid() accounts for the 4:2:0/4:2:2 minimum bpp
    and the adjusted clock, dptx_cal_bpc() rejects YCbCr below 8 bpc,
    and dptx_adjust_mode() clears both sync polarity flags.
  - The hardware layer writes DPTX_ENHANCED_FRAMING_ENABLE with the
    negotiated value and clears the cause bits that are masked in
    DPTX_INTERRUPT_MASK before testing them.
  - dptx_hpd_notify() keeps the reported state while suspended,
    dp->hpd_event_work is always queued on system_freezable_wq, and the
    bridge power management no longer toggles output polling for the
    whole DRM device.

Changes in v3:
- Move the driver out of drivers/gpu/drm/cix/dptx/ into the shared
  drivers/gpu/drm/bridge/trilinear/ bridge, leaving only the Sky1
  platform data under drivers/gpu/drm/cix/dptx/.
- Split the driver into the hardware layer, the DRM bridge, and the core
  state machine with the build glue.
- Switch to the connector-less bridge model: the bridge refuses an attach
  without DRM_BRIDGE_ATTACH_NO_CONNECTOR, and the connector is created by
  drm_bridge_connector_init() instead of by the driver from .attach().

Luo Liu (5):
  dt-bindings: display: add CIX Sky1 DisplayPort transmitter
  drm/bridge: trilinear: add the DPTX hardware layer
  drm/bridge: trilinear: add the DPTX DRM bridge
  drm/bridge: trilinear: add the DPTX core and build glue
  drm/cix: add the Sky1 DisplayPort platform glue

 .../bindings/display/cix,sky1-dp.yaml         |  102 ++
 MAINTAINERS                                   |   12 +
 drivers/gpu/drm/Kconfig                       |    1 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/bridge/Kconfig                |    2 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/trilinear/Kconfig      |    9 +
 drivers/gpu/drm/bridge/trilinear/Makefile     |    4 +
 drivers/gpu/drm/bridge/trilinear/dptx.h       |  106 ++
 drivers/gpu/drm/bridge/trilinear/dptx_core.c  | 1101 +++++++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.c   |  664 ++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.h   |   17 +
 drivers/gpu/drm/bridge/trilinear/dptx_hw.c    | 1384 +++++++++++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_hw.h    |  109 ++
 drivers/gpu/drm/cix/Kconfig                   |    3 +
 drivers/gpu/drm/cix/Makefile                  |    3 +
 drivers/gpu/drm/cix/dptx/Kconfig              |   15 +
 drivers/gpu/drm/cix/dptx/Makefile             |    4 +
 drivers/gpu/drm/cix/dptx/cix_dptx.c           |  163 ++
 include/drm/bridge/trilinear_dp.h             |   68 +
 20 files changed, 3769 insertions(+)
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

