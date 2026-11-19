Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA7606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB65112381;
	Thu, 19 Nov 2026 12:39:00 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022123.outbound.protection.outlook.com [52.101.126.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A98D211238A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMJbDgazA6sWIl6w08lVYkmsKdlKF3z1teqJiE6UHDR8yJdUkGAS5Up/DSiI1odr6+UVLep1mH0Lbi8/WIpGQKHmq8Od8bCj35qc3nvATnWpaHfTgxEnH3L5VQi8J5AZHHixQFtqWFtywmsFm3OFZUdLaivAiSgade+J4ekg74sUmsPW5gg+4fgGUHMzE5XliAdaTUgP7YGr088O6iyWGmNxyHauiFs3xSDtGEWHlVMbQJ+eU7Gbgbrr4pnkz5XfnTBKvEyAy1KgOZvjLWqOE7ZcEd1k7B1OzK/DBFsIgPHQ0Z0qTKICVOr+7mtp/2xv297BnKYdN9G1oF2gkZLcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olAOl9rlOmSSINGFpRQXmItoI09BaEXrfHFxRDgl1W0=;
 b=tUVPbhX1z1BC7QsBlHP55MrJVvgEgNt0sV/wrTA7yxdyq11WWfZ62n8/RlL3Tu7QiCIKfml368ORF7lWCc2UFmPOsVUHO5n0Z9YmOHl5QHw3mkMRuRFm/EN/bdXz8hMb+o+oSTxPXJGowHqbfnOPOa6srczOGKGgx+YSunIdCKJgXnONeH0CfJiw7IdQlhnQP1fzNU0zhgqWKaQTdQkerD6X7eOPxKN7BDQjynlnvHuJhJUgCx2CXkJ4sqsdr2taWOtBdk29qZn2fQt+V2ZgYjJlgN3D+LkF255nw+0B/9hzex8Ga8cjF+qdSU8rgVPzepN1MyueF6keCjgg6MDFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR03CA0005.apcprd03.prod.outlook.com (2603:1096:300:5b::17)
 by SI4PR06MB8874.apcprd06.prod.outlook.com (2603:1096:4:2b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 12:38:54 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::97) by PS2PR03CA0005.outlook.office365.com
 (2603:1096:300:5b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.1 via Frontend Transport; Thu, 19
 Nov 2026 12:38:53 +0000
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
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 12:38:53 +0000
Received: from cix (unknown [172.16.66.176])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2B8B3427EFC3;
 Thu, 19 Nov 2026 20:38:51 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 daniel@fooishbar.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v3 0/7] Add initial GPU support for CIX Sky1
Date: Thu, 19 Nov 2026 20:38:43 +0800
Message-ID: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|SI4PR06MB8874:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08518d30-5d29-4a2a-f612-08df463a1224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|6133799003|261009223027099003|18002099003|3023799007|261026140227099003|261026121527099003|261028144727099003|921020|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 2Q/oej1YCjtAfgQ3N624IbciPCB/up6HX1kMQaTTqaHh2JNdWkilYPD2Sij+tIKK2PgXYy1SgTMb2+sWsPntoXt7qpp9f5y67vtpHmNp93ANoXMGjI2Ci/HdnKA4j1gcArPy7X8fnn0EDFYH5RWDlrtpP97v50zF4gjU7t4AKpXYo1m4KfVNuByc50Fwd9dTqDw6P2zzgHsGpkgrqcxJVQzlcDTm60KNTlLeJWXtrnHguXEep3LVwiIE7rzq+xjoNZ+lPuIw8+zlYrjwQYA5aMYF0K7tZi/PE6HwoxYdy88UH+tUiC+xno/s31SIF9P002CbJbW2lDHo418ivguCiMkccnvtWBEMEqGA5MIoduK1YPkwm7m9HhF4Glpr5C4ycJwaPFDHK4ofwtAfHg7CFRI5JgJszqAnoGCezAkuqyshwZ7tIGqbBGl7icQZo1mRCOv4ZDElx2TLCa4ETxhgK8ZBJEG0L62HsfixzmruyIVr81lxaubxLMSnyTIAVtxbKJ8A/3W1Q8g5bg4lh5DdjJnJ1PlKItx/SyndBSa7NSsyH4Gya1Cmi3QohExPxPpda7EJ57Yc+jI4BG+8+Z7UqxJWakcJzr8j0X5cde8L4PDxOhMiyZy/POdF0SvTGRpMC5jeAxIHHe9n2VvxJzZN8CLkHg36RpOi4bV9rrKVxytQOv22bcbvLLpmde/WQr/J
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(6133799003)(261009223027099003)(18002099003)(3023799007)(261026140227099003)(261026121527099003)(261028144727099003)(921020)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tQy3VUh181nx/ckEwFn9ChGcqlNatWXm24yopBoDaeVEywZwLDrN7E7Hmlruk70BtLfGuvEeG+HF0w/xOltUPc84xrwvve/WutG74A/fEBBtXuGZOcbPogjILzYuyMueexlIeS4auS7Ofxtf6++RRwS5YEVe7dROHQiEeTk3DegwVDFo06852+j1Dl8OMDHegE3Aq7c/lVo8Y56vyVug/W77hvv0ZqJJ/pPNQ+QHkNzgRWEyY1Qpg+C6HFHjn1u0zsag1YfiX3uuxtJKs9ez4EboSWYPfrWtIhU6ftUZUsAordHqnQimDFycPexQILtS5b7GX3uXJ2A/Lwkk/MUQMxdNokn0BYKxdX2v6+qKyAmrLfgc8pTDBm3mbKpr2m/dmdeAZrBD01mwE2coSNBfhuJnz50Nnk3+UEzhBTlZNAiJ0JQnM81vdreOmRDYe9T/
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:38:53.3076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08518d30-5d29-4a2a-f612-08df463a1224
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8874
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

This series adds initial support for the Mali GPU on CIX Sky1 and
enables it on the Radxa Orion O6 board.

The GPU requires an external reset before the driver first accesses
the hardware. Add optional reset support to Panthor to perform this reset
during initialization.

This initial version keeps the PM firmware default clock settings and
skips devfreq. It does not read OPPs or request a performance level.
The firmware sets the default GPU frequency to 1 GHz. No devfreq
governor or GPU cooling device is registered.

Without an OPP table, the driver can only run when neither mali-supply
nor sram-supply is present and the platform provides working clocks and
power.

Configure the system-level cache before L2 power-on using the policies
from the working CIX Sky1 driver. On Sky1, devices on the MMHUB bus
cannot access the system-level cache, so buffers shared between the GPU
and MMHUB devices require a specific system-level cache policy. Without
this configuration, the GPU display output is corrupted.

The system-cache support is a separate patch and reads the policies from
DT. The proposed format is <source-id read-policy write-policy>, so the
DT only lists sources with nonzero policies. When the property is absent,
the driver leaves the registers unchanged. The format and zero-default
semantics are included for review.

The series contains seven patches:
[1/7] drm/panthor: Add optional external reset support
[2/7] drm/panthor: Allow operation without an OPP table
[3/7] dt-bindings: gpu: arm,mali-valhall-csf: Add system-cache policies
[4/7] drm/panthor: Add system-cache allocation policy support
[5/7] dt-bindings: gpu: Add CIX Sky1 Mali support
[6/7] drm/panthor: Add CIX Sky1 compatible
[7/7] arm64: dts: cix: Add GPU support for Sky1 Orion O6

Tested on Radxa Orion O6:
  - Offscreen rendering with pixel readback
  - kmscube
  - glmark2 at 1080p
  - Runtime suspend and resume with a retained EGL context
  - Reset-worker operations
  - Module unload and reload


Changes in v3:
  - Split optional reset, no-OPP operation and system-cache support into
    separate patches, as suggested by Liviu Dudau.
  - Remove the Sky1-specific skip_devfreq flag. Use the generic no-OPP
    path.
    Limit this fallback to configurations without GPU supply properties,
    retaining probe failure for supplies without an OPP table.
  - Move system-cache policies to DT and use separate read/write values,
    as suggested by Liviu Dudau and Daniel Stone. Add explicit source IDs
    so that unused entries can be omitted.
  - Validate the architecture, source IDs and policies. Restore the
    configuration through the common L2 power-on entry.
  - Drop Conor Dooley's Acked-by because the Sky1 binding now requires
    the new arm,sysc-alloc property. Please review the updated binding.

Changes in v2:
  - Use devm_reset_control_get_optional_exclusive() unconditionally,
    remove the redundant NULL check before reset_control_reset(), and
    drop needs_external_reset, as suggested by Philipp Zabel.
  - Add Conor Dooley's Acked-by to the then-unchanged binding patch.


Link to v2:
https://lore.kernel.org/all/20261109120902.125242-1-cunyuan.liu@cixtech.com/

Link to v1:
https://lore.kernel.org/all/20261106104735.1651267-1-cunyuan.liu@cixtech.com/


Best regards,
Cunyuan

Cunyuan Liu (7):
  drm/panthor: Add optional external reset support
  drm/panthor: Allow operation without an OPP table
  dt-bindings: gpu: arm,mali-valhall-csf: Add system-cache policies
  drm/panthor: Add system-cache allocation policy support
  dt-bindings: gpu: Add CIX Sky1 Mali support
  drm/panthor: Add CIX Sky1 compatible
  arm64: dts: cix: Add GPU support for Sky1 Orion O6

 .../bindings/gpu/arm,mali-valhall-csf.yaml    |  79 ++++++++
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |   4 +
 arch/arm64/boot/dts/cix/sky1.dtsi             |  19 ++
 drivers/gpu/drm/panthor/panthor_devfreq.c     |  13 +-
 drivers/gpu/drm/panthor/panthor_device.c      |  13 ++
 drivers/gpu/drm/panthor/panthor_device.h      |   7 +-
 drivers/gpu/drm/panthor/panthor_drv.c         |   1 +
 drivers/gpu/drm/panthor/panthor_gpu.c         | 187 ++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gpu.h         |   1 +
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |  58 ++++++
 drivers/gpu/drm/panthor/panthor_hw.c          |  13 ++
 drivers/gpu/drm/panthor/panthor_hw.h          |   5 +-
 12 files changed, 394 insertions(+), 6 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

