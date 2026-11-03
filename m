Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50C606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L//lKBkL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A84D10F876;
	Tue,  3 Nov 2026 21:38:15 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0F810E1C6;
 Tue,  3 Nov 2026 21:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfWcQ90Wvdt+ZZM02YeNmtTSkgjXAl1jHmpc/NeDbGaqot23VFBlVKFg8+lCrmus/GOuHjarWNg3ZF41ACRV3AxUBRXGO3F9WXBwN1fJMHrTrjxMEGmmPHWDfGzQyvQiommQS8zf4XxsQXNHREmmc/D4zSCLd+apTDGYh1t6zqTy18am4eYlx1QEgaH3Hw0W6bJWSP1w/1pLq5rCgSlKO0oASngdwyYP2YSiIaV79NjuQMrVtt8NRFjW5JsWwyboFBWmeLNiskeWh6XwTuYbLINQaNjlAJxYr1PNGCqqheCSLEylPpa4LXJQn6JHju4fLldUbA3BMEgAi2yVMZozVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aYwqWUXZAMt5aZatsLEba12eOIcsF0cg17A+AS4qZI=;
 b=Morc8P5aWYk0XKnzwzDT91ttCDCdkSkxIkeiispmvDRYqw058syv+QXYUPG+TW3UlCBevoq+Qdz9E3J6xM5NQzUfa3WbToMl4TdcnpUMzulxgAshZ0aulFvTLj4dhObHADTDAP083xD24zgaSyWypUT8uTw8myJdSkLgb0NLCHpNni4wLW5I613RGFdih1IxPgA1C6p1hl48jatNWIT+3Nw0TgiFAG6O4dM9FboZxFVprHZk1uo11kPciCzZ56Jip4DVPqdP4rqLmoi4mvAdPwuGJA+vHSRrAiabszNDhGyQtehpM1LY/c9BoBhPO4eE+gnKyQHM5J+ZJ3c3ZY47LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aYwqWUXZAMt5aZatsLEba12eOIcsF0cg17A+AS4qZI=;
 b=L//lKBkLVvkK5x2jWPatUNbzUQ+Bn76WOyfQvFp7KERPnPNNsrBsAx/kXdadZs89yaRUnZqiTjw3pB0rC3PiOh9echz9EexzRq6nNTFZUdjZBnQgo6bUTLAJfdAlCRpNzKpjbCVs0WJVWQu0bR2/IauzzwmsT4VOjZQ+LoXnx3A=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:38:05 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::13) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:04 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:03 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 Autumn Ashton <misyl@froggi.es>, Xaver Hugl <xaver.hugl@gmail.com>
Subject: [PATCH v1 00/13] Add DRM_COLOROP_3D_LUT_DMA for fast-loading 3D LUT
Date: Tue, 3 Nov 2026 16:37:43 -0500
Message-ID: <20261103213756.618024-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|DSVPR12MB827618:EE_
X-MS-Office365-Filtering-Correlation-Id: a996e3db-2bc3-4eb9-0b26-08df39f2be72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|261021123027099003|261009221227099003|11063799006|261009223027099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261026140227099003|56012099006|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: FEldCAlIsY5zMH4VsQmwRScAocBQm0yuIld5UwhhnIxPklyKgCKTjuI5uueRPcQIMhTHBi+PbFoV/aA2MEao0VSZx/fPxOX5LSSELzzeuqgK0Y0m9nWyxCvg4ltGuKRPMat0+hfih6iJOb8wF3YCravf7vPZtiiUE3oML8yQ0EmZd2dZy8eS4y3IZQ+0IyuyIaF2IDoDZU5sOL6iWqcm/3iysMj2/8FW9XRrDlO282KNJUWWeF0XqmAsTcAZUayAalOpoelvXLMq8j6htrTuh7l2l2f31yRjna0Irmm280+Krk8AbJAjRKoaCh2wvNvY/NoksyLpmgTQa2CWIj0gJRNpSbQQ7iH3oor4nmhppOZzUa55Kn/WQdTYoxXzm5TAOLGk0+L8ZDmfhkwCGwcEahmJUzRWanfSGMVBrIs44jAUy9qixBDf5wrovwR68OhPAFokuTsd8Ze3ltqK16HpyLSm9Qf0enN1sHa747TetREEwzbCzi+POeQ3QnxAhVJO+RRlSkj+mxFl0KzA0wOjtwxCJnamev/TISaiuBSE6oNBYR/KT1E54T+WpmPyj5Qz/BOvE0EMhm3hhnnDluq7ZlkMOXvftJHTNPcFdyu21GARl2A0XLRRoYuBXsPIDZAUFrmFJMw1woBAprfZPdZllA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261021123027099003)(261009221227099003)(11063799006)(261009223027099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261026140227099003)(56012099006)(10067099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xHx6S3WvsTX/UNzJnx+3hrU1o1TdmYZm2iRC4p4T98yxkizgl27s6LqcjS0SKFV7HF/R/fa4bx9aN7PZE2fejV0ikn3gueE7Zhu0hDxKhQru3u837AnVPFM8bIyhR1joX24+UMAA+x0nEn2AEeXmGKqDhgJJ77jaV73/B4WrlKr3lYKMwL34fi1P+f77Y6mkNtnni1S1rXClqUW0YbeEBzRpfnhAdj1lqlICUY9wfEaZf1Q9iX6a8Kwoh+nzAiv7Lbt+Fsdn/fIpNdBZfCjYt+mPDJ0qA3jf/s0+PAikk+3woC/+KOj+SoGFGuymv3LnliVSs2VI904NBL1VpfdHqx7pwVgDFTVF1EbLEtX3UCXrXAwjbFFsbPeXmJROrxglVxchkVxACJ0YwYnFAy3Cjt+uMnGRxsYngrjwtr1ZuaUUNfXrnlCZ8V6+xMJvumQa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:04.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a996e3db-2bc3-4eb9-0b26-08df39f2be72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB827618
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

Loading a DRM_COLOROP_3D_LUT on AMD HW takes a long time because the
driver has to load the entire 3D LUT via register writes.

Starting with DCN 4 the HW has the ability to load a 3D LUT via DMA,
which only requires an address update for programming the 3D LUT.

I propose exposing a new DRM_COLOROP_3D_LUT_DMA type to support this DMA
3D LUT loading mechanism. Users of the DRM_COLOROP_3D_LUT_DMA will parse
the supported formats via the LUT_3D_FORMATS blob property, select the
desired format via LUT_3D_FORMAT property, and pass the 3D LUT buffer as
a drm_framebuffer via FB_ID on the colorop.

For details see the patches and/or posted branches.

In addition to the patches posted here the 3d-fl-fixes kernel branch
contains a number of fixes that will be merged via the usual amdgpu
display process. It also contains a patch to enable support on Navi 4
(DCN 4.0.1), which won't be upstreamed since that generation requires a
userspace workaround. The 3d-fl-workaround IGT branch exists solely for
that purpose. Nonetheless, Navi 4 can serve as an enablement vehicle for
anyone who wants to see the new interface working.

The kwin branch makes use of a pipeline with DRM_COLOROP_3D_LUT_DMA if
such a pipeline is discovered before a pipeline with a
DRM_COLOROP_3D_LUT.

### Branches

kernel: https://gitlab.freedesktop.org/hwentland/linux/-/commits/3d-fl
kernel w/ fixes: https://gitlab.freedesktop.org/hwentland/linux/-/commits/3d-fl-fixes
IGT: https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/3d-fl
IGT Navi 4 w/a: https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/3d-fl-workaround
kwin: https://invent.kde.org/hwentlan/kwin/-/commits/3d-fl

Cc: Melissa Wen <mwen@igalia.com>
Cc: Autumn Ashton <misyl@froggi.es>
Cc: Xaver Hugl <xaver.hugl@gmail.com>

Harry Wentland (13):
  drm/colorop: Add DRM_COLOROP_3D_LUT_DMA
  drm/colorop: add DRM_COLOROP_3D_LUT_DMA object and state
  drm/atomic: wire up DMA 3D LUT colorop properties
  drm/atomic: validate DMA 3D LUT colorop framebuffer
  drm/atomic: add colorop prepare_fb and cleanup_fb helper hooks
  drm/tests: test colorop prepare_fb and cleanup_fb helpers
  drm/amd/display: advertise a DMA 3D LUT color pipeline
  drm/amd/display: pin the DMA 3D LUT framebuffer
  drm/amd/display: program the DMA 3D LUT colorop
  drm/amd/display: add 3D LUT DMA pitch alignment cap
  drm/amd/display: derive the DMA 3D LUT pitch from DC caps
  drm/amd/display: reject direct 3D LUT loading mode changes
  drm/amd/display: add KUnit tests for the DMA 3D LUT colorop

 drivers/gpu/drm/amd/display/Kconfig           |  13 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  68 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 131 +++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  71 +++-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 286 ++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  65 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 .../dc/resource/dcn42/dcn42_resource.c        |   2 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |   2 +
 drivers/gpu/drm/drm_atomic.c                  |  66 +++
 drivers/gpu/drm/drm_atomic_helper.c           |  93 ++++
 drivers/gpu/drm/drm_atomic_uapi.c             |  28 ++
 drivers/gpu/drm/drm_colorop.c                 |  96 +++++
 drivers/gpu/drm/drm_framebuffer.c             |  45 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c       |  81 ++++
 drivers/gpu/drm/tests/Makefile                |   1 +
 .../gpu/drm/tests/drm_colorop_helper_test.c   | 397 ++++++++++++++++++
 include/drm/drm_atomic.h                      |  20 +
 include/drm/drm_colorop.h                     |  71 ++++
 include/drm/drm_gem_atomic_helper.h           |  11 +
 include/drm/drm_modeset_helper_vtables.h      |  62 +++
 include/uapi/drm/drm.h                        |   7 +-
 include/uapi/drm/drm_mode.h                   |  79 ++++
 24 files changed, 1672 insertions(+), 33 deletions(-)
 create mode 100644 drivers/gpu/drm/tests/drm_colorop_helper_test.c

--
2.56.0

