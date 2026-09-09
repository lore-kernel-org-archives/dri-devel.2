Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F04DC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2DA10EEAA;
	Wed,  9 Sep 2026 04:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gvr5r0gC";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBFF10EEA6;
 Wed,  9 Sep 2026 04:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP7GUsLRrUGCo9jCPt6RREE4M+8I5G9cxfQw+xledWgKDF4z1beXWeZePw/2uP4XAYYakhig4JPNRStO4JVx79hvmsc+Ifb6hFavJhDgE9WZQmAfsc8tItquXrPLsgPpQQuIAQ2SjSLzgFbBpZxiV7J+O531mbpzBL77qHXwXEUT0y+NXu4R2Mtp/VqDF3FHwAzB482ZKz4txt2O3Gw6QkpcrdCK7Fa6z3/Ruaz8opUw6u8VwCbRrPFb0uXe2zLZO59DUnxUECjpDujvPQ4Ge5/DLE3Q2/DdvfZlWZ29CIqUiQ3TY+xPnW0zWSgP7qkt5i28Y+Z13ILTQvDkJ8TOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0SgiLPACEGcEluLTL+gGHTYTvd0Rfomht0e6BHVg5Y=;
 b=jcJ+dBFqlr5UPxMDMftli54AYIp0CHtye2qillXDydRIEG8WZpK0x+QgPqYWy/yAosoiuFZV1sQLxaors/tHfEp6el2tyI+tkdBC747NE2rThwgxfrqp17FFkEd/qfXMq1FY3dR0y0tQCU4yqH11gdgqQwjWpAN5bsR4cdwLcnWR/ezE3dxWBo+4aT3me518fbdrdwUwLYNvf/xH4WVUNCeU6lnCTsSssSbq088AFLGyRFaNX81+p8y4zyoY4aXN+naDvrW+ydEeR6milqbKNIOPV+w6v3AMILaoYOxh9xY35xzSHE0ovoo2QSoWtF1/8trwVzhGokwZf7YhFW7T3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0SgiLPACEGcEluLTL+gGHTYTvd0Rfomht0e6BHVg5Y=;
 b=Gvr5r0gC6DJSi++Lmb+6vsWBvzMnJ3cLd1HJByu3PuEa1U/FZBzoxL2odUIJTWG0k6LtPVzILKjHhefqeavN7TfrbIMnNuEOuK0KatKYmO8H0dwXwaCAQ1MyeyWNvuZz+88aQBXpVizdRKCrc65xbNQc+2n20rSr+41IAXCq4qs=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:45:11 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::41) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Wed, 9
 Sep 2026 04:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 04:45:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 23:45:09 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v9 0/3] drm: Extract dma-fence-to-workqueue pattern into
 common helpers
Date: Wed, 9 Sep 2026 10:14:51 +0530
Message-ID: <20260909044454.399340-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f25a26c-b38c-4da5-71bd-08df0e2d221d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: RP4kMNRKFJ9A+wzOreXBX0yyWeDFVMCZx8L6vhrEAD4TRqhDzYJ2CiJhynEHlZpe1sa54QzcGqZPX159rQZ3f8OuEvjXezX2xuWfsZPoL2MZJ9rMNDZdgA5mzBKHZxyR19nqTW908rr0qCIcKwPkxcoBE/Z2SxxKo1EgWxi8Dqfq9+K/RG65FTfOg6G/dazmcuV5nTaZR9PKPKhjT30u/v/L1Xkv4p/IJAbCTVUZ/XYLpz43UNgGCVwuHMpJcrsOPBmUYGYsVrdMYS/OYwg6Uz6yaIv4qFbNKvSkiPu9L9/IbmMXAKb7pZq24OicrHeK537q7ABBZwiXvj4p/tD/qgx/mcmgcENs0QQLKTAfNEqbXqBBaGutzaDvMEpNOno2U6YIz1FLBdZ51TrtobqFQmnqR/E4dezi9qEjvbMYhryI2jVm/OswnXIQwXHYvY+j6PfNl7Djr00IR9TBzaSPjO8+Fba3+wx8i3iSteG2vBPmNmakIVpJ7vkINTeorhffDkpTHLUsytIX5nIo688SUSEQxEomQ+7X4JBf21K27so2pPspleNayTxPIgFffOIZ/YqPOC7Q+B3h8hj/eoiXrr4bqoutyW4W71Yv8wGALAPPfQ0vwrXk84n4sYiFrcsSJR0iBXAbnwzSJbMSiWkzrE4kZF3/nDbyZ6qaj1ErWlIHC1E4xZR7HPqXywx+W7Gvmh3UsPVTIiLCxpV9++09MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4l1NaZeOAvmBoer4q0X4f/TuHOc3+Q+g5eeWOB88vNMCY3ML8qny8OxECGQzjf7nylRaKTzFUkZZzuamEEXz7iDJKK81EOJlLQc+FJI/EneajHEhCbUXCNAuanX1zCygKI25JP29mjrFutVZyidkG/P7jcbide6lQ4J78FDu66y7n1ypN75DkucToOQZRgNCUrIalVUj0J/CNvEbesc6yUZnc9PRUZiE1j/tlEjcNavice3wt3Jm/ZkD9v0peRafeOms/YQHVwX6R3cUZn3oQSQdebbFo2VhbddOKVSJysoGGi5oPwm6VAtjh1N1xuCmui+QXuCyqHFj2BtXeGA+JSUoNB/1c8SKh3UVjH5s6zC1al0qC6h0HhwA0nHs1GkES0SG6mquOJJD2+3EZgbQZAMDVpPfLNrr2gCA2F0eHxaQpeEsH4jg9cdz2RkV8Ty3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:45:11.7299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f25a26c-b38c-4da5-71bd-08df0e2d221d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This series extracts the dma-fence-callback-to-workqueue pattern shared
between XE and AMDGPU into common DRM helpers.

Patch 1 introduces drm_work_fence — a generic helper that queues a work
item when a dma-fence signals, for work that cannot run in IRQ context.

Patch 2 introduces drm_user_fence — extends drm_work_fence with
kthread_use_mm() support for drivers that need to write completion
status to userspace memory.

Patch 3 converts XE's open-coded xe_user_fence to use drm_user_fence.

Note: Patch 4 (per-signal compare functionality for AMDGPU's EOP
eventfd path) is deferred pending resolution of the compare address
read method (get_user() vs page-pinning), raised by Matthew Brost.

v9:
- Fix drm_work_fence_queue: drop ref if queue_work returns false,
  closing the race between callback firing and queue_work() (Matt)
- Fix drm_work_fence_cancel_sync: use disable_work_sync() to close
  the UAF race window between callback and queue_work() (Matt)
- Remove xe_sync_ufence_cancel_sync — no caller in this patch (Matt)
- Remove xe_sync_ufence_cancel from xe_vma_destroy_late — unnecessary
  behaviour change; xe_ufence_worker only accesses device-level
  resources, safe to run after VMA teardown (Matt)

v8:
- Fix copyright: The Linux Foundation → Advanced Micro Devices, Inc.
- Switch EXPORT_SYMBOL_GPL → EXPORT_SYMBOL for MIT-licensed code (Matt)
- Rename drm_work_fence_ops callback: writeback → worker (Matt)
- Rename drm_user_fence_ops callback: worker → writeback (Matt)
- Fix xe_ufence_worker ordering: WRITE_ONCE before copy_to_user,
  add smp_wmb() before wake_up_all (Matt, confirmed via 8ae04fe9ffc93)
- Rename .worker → .writeback in xe_ufence_ops (Matt)
- Drop Patch 4 pending design decision on compare address read method

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Christian König <christian.koenig@amd.com>

Srinivasan Shanmugam (3):
  drm: Add drm_work_fence helper
  drm: Add drm_user_fence helper
  drm/xe: Convert xe_user_fence to drm_user_fence

 drivers/gpu/drm/Makefile           |   2 +
 drivers/gpu/drm/drm_user_fence.c   |  70 +++++++++++
 drivers/gpu/drm/drm_work_fence.c   | 186 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sync.c       | 141 +++++++++++-----------
 drivers/gpu/drm/xe/xe_sync.h       |   1 +
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 include/drm/drm_user_fence.h       | 123 +++++++++++++++++++
 include/drm/drm_work_fence.h       |  69 +++++++++++
 8 files changed, 524 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 drivers/gpu/drm/drm_work_fence.c
 create mode 100644 include/drm/drm_user_fence.h
 create mode 100644 include/drm/drm_work_fence.h

-- 
2.34.1

