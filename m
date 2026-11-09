Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E36606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1AC10EB78;
	Tue, 10 Nov 2026 08:33:34 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023115.outbound.protection.outlook.com [52.101.127.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 116DB10E848
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAz5uplkhZjAJ/HkDOi67tbM0vQ4uEHATap4kRKlo7J4m3jZO04lTg7PRDTvRmam35HO3fgpB5zhGm/HV4ykFu2HIkasXyYh7G0qUCkm9mHsP8G9W5CzRMSpaMOpBs1vUiXRGw6ajbs/7zbgiq0huSYvZ4thtbc4kWz/EH0VJQekv7SIyXpbNp6YIdPNqqBlwkRx4E3//RNJBuJ5e4Fy+ssNGpRlVUrjKQOM23wAOu7+IgwLoaJdjzZYl+qGcyy26WxSvQSYVBSC8wYz23r3h4yMHXBX7yiWUfiDi/SxfRHUtF4zabQz9z3NMRi6Ea9h5m/9kvPMqhOdoghlV7+cjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/GTny8y0Fq03kHeou/H4pJdVMeDeQY+v7vRik/494U=;
 b=t1REAI0JYwu2L541JTC+9VFKgNNiZeSUr6dMiBx6ymbtsaGO1gtmRCMHb0lOHYKUWI/VxtZfwfMQfCo1N+taaUjeszC5Uf3OTopunkaisYLzdX49pivGhlqJGPlhXkrZqMuF7BD0Evec0UacZyyNWOyRugZY6z7oR3TfGi2xmW7osqxgFMj8eBBGQujAYYhyo090VFFRlNWSaa8xJve9+GwzbhEYhAWOIKmdfv+VWV7uchuZSfWoz/BZi5BHOX9DLj3FBlhyOui4HWbpMkZTqt551gIsWbU+/mJsv+fRYKP1tGpXl6uRaetbztMOOBxQP+MS+OJ+Tqb8XhplJHAB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI3PR02CA0013.apcprd02.prod.outlook.com (2603:1096:4:295::10)
 by SEZPR06MB8912.apcprd06.prod.outlook.com (2603:1096:101:33d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 12:09:05 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:4:295:cafe::84) by SI3PR02CA0013.outlook.office365.com
 (2603:1096:4:295::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:09:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 12:09:04 +0000
Received: from cix (unknown [172.16.64.42])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2D89D4102E74;
 Mon,  9 Nov 2026 20:09:02 +0800 (CST)
From: Cunyuan Liu <cunyuan.liu@cixtech.com>
To: boris.brezillon@collabora.com, steven.price@arm.com, liviu.dudau@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gary.yang@cixtech.com, fugang.duan@cixtech.com
Cc: daniel.almeida@collabora.com, aliceryhl@google.com, p.zabel@pengutronix.de,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 robin.wang@cixtech.com, cunyuan.liu@cixtech.com
Subject: [PATCH v2 0/3] Add initial GPU support for CIX Sky1
Date: Mon,  9 Nov 2026 20:08:58 +0800
Message-ID: <20261109120902.125242-1-cunyuan.liu@cixtech.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|SEZPR06MB8912:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af872209-5929-4319-701d-08df3e5a3fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: foHW/4yj7Jh+S7ImBFbxQboGzflUB85LVE6u3nRhB4W4/Dkihc4VXfQfdLPS1iCnv+ikU8QyO37K2eW3tDGTyKUAbVFsXjmQTSvUPyT2sZYcYUqsyVeGE2RlfcWx++nmPUmDJMDWRy8Wmrk0HToZmq05rkieTKmXmZDho3wnEBasz/k+ThpERsBrVGxCWZN7xl3OEVId/eaTU13TyMuVAeqbQgp60SXv+4KLEofm8+z8KeUi4mF0mCP70KXxD0T8biBkC7zdosAVSvzm/M7twWewxM9tIHz4SKJUez4dAurKZ/5z/Cl+Z5B/7L1W2diZDm+0Vg+FQpb/w/kEnjq8rFcS1d1qAQAr1pFHAbsTO+02emI0dimv9K6cyh5t4FDiHph7xYUXpicbcs56HNS1DgbMp1kw8Y43x9RiUfolj4ALFnM5cibZEpN8hxToQmUqjzaupOVrkLcMSONa3ORLmjApUWlNN37T4wq47n9NIYzEr1lfLMUCCxIBvg7nTcWkoGM8Ubi9KDq1Vt4teOk2l5whScz3zHLzmDLT4NOp6FFksVjcMsoXcM6VnGMsaXd33aivO2XrKm6bluSaXvO/WCIqjaNy4gKaJGfLpotCE/GHNMovzDl0P8X3IVWYcAauKxHiHlaAOqhelCgchC7OQQ==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I49n9k9nsQ/JjEnBu0+OEa6NZpXlHwolbNj4kMi/cb/Mf+6uLFNRwJJZVmDh1T5zFPMp9GSHAzLCa8MTbs6DBZ5q7ygSIawaFMr7zav5GTwf2Uw2uUC6JFKA72vwZmxdxQzTTawOxRzBT5Mxd4Y1DvTFTHN0zR0DSkw6UqOpplG3iUtKg2RFPY4bgxbEPVBB/bg6qdb7W7cEw1TaM2NUIKjqVRPNsOeoc1mTMflY+CwnwTuALr8jpoQoAZx/SDV4zXCnq62WlaN0cGBuziNkLx7Ne2FWYSfVjRtsJoMutTsZ4yqJhFaSqA/aLGstq55666AziJ8XYrkXqjS/0zEjXXBUoo5uSX7TL/NEUHV0Pl8BG1hKl0BUEt52rMxwHzt14KyTQwnRnblHWkuVKCK78cPLThCT0Mcs9+R/DGap/19QzEEE3Nh6AP3H3S3t8xPy
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:09:04.6083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af872209-5929-4319-701d-08df3e5a3fd0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8912
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
the hardware. Add optional reset support to Panthor to perform this
reset during initialization.

This initial version keeps the PM firmware default clock settings and
skips devfreq. It does not read OPPs or request a performance level.
The firmware sets the default GPU frequency to 1 GHz. No devfreq
governor or GPU cooling device is registered.

Configure the system-level cache before L2 power-on using the settings
from the working CIX Sky1 driver. On Sky1, devices on the MMHUB bus
cannot access the system-level cache, so buffers shared between the GPU
and MMHUB devices require a specific system-level cache policy. Without
this configuration, the GPU display output is corrupted.

The series contains three patches:
[1/3] dt-bindings: gpu: Add CIX Sky1 Mali support
[2/3] drm/panthor: Add initial support for CIX Sky1
[3/3] arm64: dts: cix: Add GPU support for Sky1 Orion O6


Tested on Radxa Orion O6:
  - Offscreen rendering with pixel readback
  - kmscube
  - glmark2 at 1080p
  - Runtime suspend and resume with a retained EGL context
  - Reset-worker operations
  - Module unload and reload


Changes in v2:
  - Use devm_reset_control_get_optional_exclusive() unconditionally,
    remove the redundant NULL check before reset_control_reset(), and
    drop needs_external_reset, as suggested by Philipp Zabel.
  - Add Conor Dooley's Acked-by to the unchanged binding patch.

Link to v1:
https://lore.kernel.org/all/20261106104735.1651267-1-cunyuan.liu@cixtech.com/


Best regards,
Cunyuan

Cunyuan Liu (3):
  dt-bindings: gpu: Add CIX Sky1 Mali support
  drm/panthor: Add initial support for CIX Sky1
  arm64: dts: cix: Add GPU support for Sky1 Orion O6

 .../bindings/gpu/arm,mali-valhall-csf.yaml    | 51 +++++++++++++++++++
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  4 ++
 arch/arm64/boot/dts/cix/sky1.dtsi             | 16 ++++++
 drivers/gpu/drm/panthor/panthor_devfreq.c     | 11 +++-
 drivers/gpu/drm/panthor/panthor_device.c      | 13 +++++
 drivers/gpu/drm/panthor/panthor_device.h      | 19 +++++++
 drivers/gpu/drm/panthor/panthor_drv.c         | 14 +++++
 drivers/gpu/drm/panthor/panthor_gpu.c         | 14 +++++
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |  2 +
 9 files changed, 143 insertions(+), 1 deletion(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

