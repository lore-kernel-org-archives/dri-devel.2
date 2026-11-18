Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130F606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DvzCfnnB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B5210E2EB;
	Wed, 18 Nov 2026 23:32:27 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AEA510E0EA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO+at/f/iTRZD8Hk/i3SWVpQ9qTO91HznnEyCfg7gPxk43hbpy2MKWnpopnp+pCxQHdsNhiIwEKkHZIs2ZD8HeV66UIudBt1slk3gx3uF6AYx9BRUmE0Hp7GnExy+2SvPgf6p9eK3hXB4C8hhyrO7dywZ32lNWQd9TIs+38faD4UmWDg0Ah7H0Ru4CgaUeW1R0ZTlZ7uxz4B14YW6613KjwKrBrC/IP81pceBcV9zlDOJBiJfEKeG0fkC77D3XP+Ebo9j2JlnFcDGH/t0vpW1u9EgUj7g8ccrka/Argzjq+8q1iZj8FJrS65eHcm+qlmIWEZmzR0AFQT+JlByRkzPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUKdIa18y3lriXkABUAwIeNo7mM2QG9cDpZiXv9NeIU=;
 b=tWgb1JJJtDjTgzNWtDFL3h1422bqs+CTjiGt7nfc1SCpJV6c1G4JdekUGPnqmcPIGidT8USWw9rVH3lmBgY1x+kLBrQhH6C7a9NwtAfwzUhTN+yFZQj2hYp11GDzdaVnkjsgke7BEqgisN2RLWQxr5mywnHLluQgaMVGygPeOJb003mYV/xTR1QYOYnhujVuvwBjPyQNMSI1kfcUBI2yWTiuXYG4vcsWO74zv2itVgDDLDnuK/7qWy4qFHX8Iew9jRxl0MiXUg6tUDkr1Aor7uV0AKxrNcdBI9U8GCmxp9a4Kq6hUY+MnF5plbwujKNpgL8n74JFRSkyPnDGpRFecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUKdIa18y3lriXkABUAwIeNo7mM2QG9cDpZiXv9NeIU=;
 b=DvzCfnnBWo+85qu7P19dY4nfGXrRzwz8COeRsaDa0u0sCU8Sew9B4nKPtbgQ6/qBFy6wKJPEUFCeBxS1s/cmu+X0UCtDacV4Pbp6Of3kdjEuf2olPAwjbzr51dULpQ6V/ULc5yUDKvRDphR7XjC1UKGDjzq4B1bXAlCuOuqqA5c=
Received: from MN0P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::27)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:32:16 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::88) by MN0P223CA0007.outlook.office365.com
 (2603:10b6:208:52b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 23:32:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:32:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:32:13 -0600
Received: from xsjgregoryw50.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Wed, 18 Nov 2026 17:32:12 -0600
From: Gregory Williams <gregory.williams@amd.com>
To: 
CC: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Oded Gabbay <ogabbay@kernel.org>,
 kishore Manne <nava.kishore.manne@amd.com>, Izhar Ameer Shaikh
 <izhar.ameer.shaikh@amd.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
 Ronak Jain <ronak.jain@amd.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 00/15] accel: Add AMD Versal AI Engine driver (with Versal Gen
 2 firmware support)
Date: Wed, 18 Nov 2026 15:31:56 -0800
Message-ID: <20261118233211.4121361-1-gregory.williams@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2445c1eb-ac39-4516-33b0-08df45cc2e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|10067099003|261026140227099003|261026130827099003|261021130227099003|56012099006|11063799006|5023799004|261026121527099003|261022075727099003|261021123027099003|261021135927099003|261021121427099003|261022105027099003|261022113327099003|261022115727099003|261102123227099003|261028144727099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: EgYGFKH9ODa04kx1XUqQjsguWBRU6P9OG0oBaBRBvlrAI3KcEhUX0MCc0ecbJC8TGlxuaC1wZwyqbjOLxmdC6gKUJ396DCsQUtZmJJdbED+LPAQbfi76gGjQ8250HqaC2NNDUb+7YTNR/IIe036dRTmfN9ghixyiy5OiMLnFVmENNtXE0Z1Dm0BXa9+4oGuWz+j6MzwiS1lF2xCaUsaCEK02StFV9LhHKvB600GI1VCi3zlLtMyKQ272mBKByAKSWLk4YMrYMYspudOYTn/J30xD6iwteFdwX1wZbqEfI5pD3n0b+M6GM2Mdl8H4SyR9VU8waQvRSOGU2lbRTHnvwP7UGDytn3lMcpKTM/eofONOTDPENXk51DWrNZOZaIU9UEtRDAxP2XyY6dJlgzt3fL50WNxTXmU7T0lVf+zn6PRSRFL5yigzuF9OCHXIkUSAVmxeRwz19liP7TSn9YpbH1FWpLIZZhXE5VaLANPf663zRXpdTdGUXnPQp4qmqGy0dVPrHta9Pu/X6rX1o4Rj3bP37Lzmaz9sy6WsHirLW+tVVuXJDK7VbnNWOmgorxJ6r9hya6ziMCSmmcJ5pSsVR8r5ENSnNFU8HTr5vk8xXXDWZ7zY/HPJBtOm5ikMRO0BridrvirwTXreCRsloKS3Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(10067099003)(261026140227099003)(261026130827099003)(261021130227099003)(56012099006)(11063799006)(5023799004)(261026121527099003)(261022075727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261022105027099003)(261022113327099003)(261022115727099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w2q3jFfjRHO4VZOoF+ZbvDI9kTIGJF5LDvW4ZA3SkYltiffo4Ljd1pmzCHM+VPVYWgx+3gkzRz9D5gVh2zOT47jT1NwSASh7J+80dN4U86Eq2H1mkz5E9e544dGVUk1q/dtP8tqy7hetD2edexbPZoUQApyS7lCCpHjZRFySbtWqJKHKcyXWQ9zmUeKetNDIR8ejA5ujSBKW5bVHOdfLdYQSwX2PITXrQkOIS+g9SmfRwJ4b/lyrGAvofcr3F05iFNjO8HtzYExShKU53KO7a1rv2Y3BxGEJYouG8YL8XAOvB3tAQTvKzMClvhPJVuJsq1HGooOOQfaPymHFVKRCh/6g0cvmnjFuXTif4oOi60fowBQNkUj984mph3avYyCf/e51urQYHcfyIvOC0GS5ffQeNtWNURBw/AbHoo9Mp1edUrt23x4FxCzFkBMd7+++
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:32:16.0588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2445c1eb-ac39-4516-33b0-08df45cc2e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a driver for the AMD AI Engine (AIE) found on Versal
devices, together with the firmware changes the driver depends on. AI Engine
is a tile array based accelerator used for applications such as beamforming and
machine learning inference. Tiles are organised in columns, and groups of
columns form partitions that an application requests, initialises and releases.

Several registers in the AI Engine array (column and shim resets, memory
zeroisation, tile clock gating, NoC and interrupt routing) are privileged
and can only be written by the trusted firmware. The driver therefore
packs operations into a DMA buffer and hands it to the platform firmware,
which executes them in order.

Firmware patches included
-------------------------
Patches 1-10 are not part of the AI Engine driver itself, but the driver
cannot work without them, so they are included here to keep the series
self-contained and reviewable in one place:

  - 1-5:  zynqmp firmware driver refactoring and a va_start()/va_end()
          fix (patch 2 carries Fixes: tags), preparing for the extended
          SMCCC call format.
  - 6-7:  Versal Gen 2 compatible string and firmware support, where all
          EEMI APIs use the extended SMCCC payload.
  - 8-9:  Versal Gen 2 clock binding and clk driver match entry.
  - 10:   firmware IOCTL support for the Versal Gen 2 AIE run time
          operations, used by the driver.

I am happy to split out or reorder the firmware and clock patches if the
maintainers prefer to take them through their own trees, and would
appreciate guidance on how the series should be merged.

AI Engine driver
----------------
  - 11:   devicetree binding for the AI Engine.
  - 12:   driver core: device probe, partition request and release.
  - 13:   pm ops: building and sending firmware operation packets.
  - 14:   enabling and disabling tile clocks.
  - 15:   partition initialize and teardown (reset operations).

Previous submission
-------------------
This driver was posted for review a little over a year ago:

  https://lore.kernel.org/dri-devel/20250702155630.1737227-1-gregory.williams@amd.com/

Since then the scope of what is proposed for upstream has changed, this series
is considerably different from that posting, in particular targeting only Versal
Gen 2 support. All comments received on the earlier posting have been addressed
or in this version.

Abhyuday Godhasara (1):
  drivers: firmware: xilinx: Add IOCTL support for the AIE run time
    operations

Gregory Williams (5):
  dt-bindings: soc: xilinx: Add Versal AI Engine DT binding
  accel/amd-ai-engine: Add AMD AI Engine device driver
  accel/amd-ai-engine: Add pm ops for firmware calls
  accel/amd-ai-engine: Add support to enable/disable tile clocks
  accel/amd-ai-engine: Add reset operations

Naman Trivedi (1):
  dt-bindings: clock: versal: add Versal Gen 2 compatible string

Senthil Nathan Thangaraj (8):
  firmware: xilinx: Separate TF-A checking
  firmware: xilinx: Call va_start after pm feature check
  firmware: xilinx: Add comments about number of arguments
  firmware: xilinx: Use match data for ZynqMP/Versal
  firmware: xilinx: Rename zynqmp_pm_invoke_fw_fn()
  dt-bindings: firmware: xilinx: Add Versal Gen 2 compatible string
  firmware: xilinx: Add support for Versal Gen 2
  clk: zynqmp: Add Versal Gen 2 compatible string

 .../bindings/clock/xlnx,versal-clk.yaml       |   5 +-
 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |   3 +
 .../bindings/soc/xilinx/xlnx,ai-engine.yaml   |  61 +++
 MAINTAINERS                                   |   9 +
 drivers/accel/Kconfig                         |   1 +
 drivers/accel/Makefile                        |   3 +-
 drivers/accel/amd-ai-engine/Kconfig           |  15 +
 drivers/accel/amd-ai-engine/Makefile          |  14 +
 .../accel/amd-ai-engine/ai-engine-aiemlv2.c   | 441 ++++++++++++++++
 drivers/accel/amd-ai-engine/ai-engine-clock.c | 154 ++++++
 drivers/accel/amd-ai-engine/ai-engine-dev.c   | 255 ++++++++++
 .../accel/amd-ai-engine/ai-engine-internal.h  | 377 ++++++++++++++
 drivers/accel/amd-ai-engine/ai-engine-part.c  | 140 ++++++
 drivers/accel/amd-ai-engine/ai-engine-pm.c    | 472 ++++++++++++++++++
 drivers/accel/amd-ai-engine/ai-engine-res.c   | 184 +++++++
 drivers/accel/amd-ai-engine/ai-engine-reset.c |  69 +++
 drivers/clk/zynqmp/clkc.c                     |   1 +
 drivers/firmware/xilinx/zynqmp.c              | 340 +++++++++++--
 include/linux/amd-ai-engine.h                 | 115 +++++
 include/linux/firmware/xlnx-zynqmp.h          |  65 ++-
 20 files changed, 2679 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
 create mode 100644 drivers/accel/amd-ai-engine/Kconfig
 create mode 100644 drivers/accel/amd-ai-engine/Makefile
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-aiemlv2.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-clock.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-dev.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-internal.h
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-part.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-pm.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-res.c
 create mode 100644 drivers/accel/amd-ai-engine/ai-engine-reset.c
 create mode 100644 include/linux/amd-ai-engine.h

-- 
2.34.1

