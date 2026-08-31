Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B7C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B066410E5EC;
	Mon, 31 Aug 2026 05:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pFtIktcc";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2121710E5E7;
 Mon, 31 Aug 2026 05:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcebXLP4rb7KIBInr55LjTxQNz3EXI90JX4Eh+sG4SKBFuXqucqU/VH5n1X5UM++bTlMDJKfRvA9jqUNAa63yaaFzJZKB62x7O1gNH4iyS/AuQrcJAA08RQPDoofP9VE28R9dpiUee05ggPl1r1imAUoinR4favlCDVNZdmY22VnIacLpiywAdrTChkqwN3gdu4SrpPINR4noIyXiY+K41XXQcAqlp5cJbcsvgpC7np+b7SfFl/uGqtGU1OQblw7PdnD1n3Y4vCHQ+eLzF1zquFADS0cbuwgIOmxcxVVqjY7L0BavyAKPwbm79lHIFB7NWLjNfCY3DLDzh/mP4Dcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq1yGTXtEk4z5y+o8g8y736180no0JpzlTJ80uYwQto=;
 b=R7K3Tf3stDjuXiPXT77Fdg82kemcLnMBt76NvZHJpJtHGGGuKEO7L/cnNZVfC1WqYWsXkqU9k2Q1iN+PD1NzXyMXJQw8o/UUZL4j/fb5kXOrIgFdeE2kCvtVsXW2VijlSjV6qBhdDFsfDyc1Vkab5qnE7LHh63A7not+dVv0XwjLjhaKhCUabqsovDnBLAUaanTEabvs2d6/cX828hOGFO0gdQUVXBhM6ik8WqECqIWf8V/+A+at7W1Gt/pr80LWgVfK/WNuCCFJkw6DEmI7Hs5mut9hJz21bfJ9FwhaIKXuyJ2jCN94rgUwBchewKFYSyxxD0A0pcyd4kB0qe3lIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq1yGTXtEk4z5y+o8g8y736180no0JpzlTJ80uYwQto=;
 b=pFtIktccYD+PTwr7MZwLkGnJtteiuC7akavk3LG9+j9tmpo1bmVo0yuu4jE1qsj+QcUheEAjtgKgkDYjxsJEW9JsGKIqtQ/tMhgsyzPZ5SyrGsYYeFfRaEffhAZ89jqAzC01+NBjQD1jxglgbZUlMF1/kBqEBUCxoPE/YQk7nKg=
Received: from MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:42:17 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::2d) by MW4PR04CA0092.outlook.office365.com
 (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:42:17 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:42:14 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, =?UTF-8?q?Thomas=20Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>
Subject: [PATCH v5 0/4] drm: Add common drm_work_fence/drm_user_fence helpers
 and convert XE
Date: Mon, 31 Aug 2026 11:11:50 +0530
Message-ID: <20260831054154.107602-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: cec95aa9-ad59-4904-3329-08df07229e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: n3+YIUaDTkjF9JerMU5lH4uW7+I3NTgOM4hui9otkm87d6gJGqlWo9Homyu+Yc+pxKY3iULv8rKuwMSeh8RWsjW9335p7PKNT8pXFXTkaCWyaj51SwbMJrRstPWNHOzTHtCI/6BS84xq5zEtEZW/tKpzKEirkSGgTb6G0u7ljhNggr515o3ezOcONLUfEGKsx9yHAsloXmpS+MK2qpEr7y2GfT/NPONFo8GkE1BILQx9PJoHu7NEEGzzhS7jar9z66SIyaprM3xSNIFGBxhwpa9MjilqTMIJZZS05Ii+yeOyfVPJYL/f36E1uFsmOaSH8qlwBj48RZ76BokBy17BuAPl/Rkegw83H43DGQ84EEqlO+GzKIVsJ74Rm9WPR4CGbrpwXNGpre/bQoHcfh2JALNY0efPkiMQ83VJ/cAOobZKMalFPkoRO0N7IE0Zl0WLmUQw7j8/hRg0736m+qmxAVWMODGQBn2hZoGF2udIY8bp1pa+LnLsdtycFuZ6cs2ibpv6Jpoo/e46Uippg2f7UWVSkX5tQB00H0E3FWCIf/nbZFHjhwzNVnumG6bMv61PRNqOQH3xv3mxMxET92JAS/AuVGBUrwmapIq8I5LSCCRtVcJ45ELRpKR2KgkQQRNaVc1GmzXot+/b9F+YmL14u+osswjOrKBbj/5zoQpH5RYyMV0dlf64X8CG7jhhb+RS6ufU/JZx7D9vjGd9ulQGcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P5kpKHKOTd2t+fCKbf9fXDM0KSzcb7KVyk+pCbndfAyoJFoVORTXKgCUSAJYjuwKwBdlcAHRIo1dTZIicjV32vXfAJg6I/1k28WYJY/ylmdmPULM9w0TdcQ53FpvvmQL6igaKc1kKGKBBj/u4KrJSDklzAluraVxm/V2SzRrhOE4uMnoXp5K+043Q7kg4DxUgkHEBp5bpvyMMtgBRXuAwe2/VHBy16Krf8NPslKBHKTJjekgA3F6IVVt0RysGWKwyQnRrcBUCjAEAue64kcZyawpG1bfMweFkQWMrUsXxIdkSE3+pzwoCCV3VY4HWf7yfs6++vURRiSoJXpQZ1z39uILhgsgWtVinU35wfpTJwfo27Uf/nEqR9Am+stFfsIlHv0hV0m4Blv+ikmaYpxFjKgx8m3sGwysl9tbfuEAWqa+xQ7LDtfcnGEUSvmgk4Pl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:42:17.3848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec95aa9-ad59-4904-3329-08df07229e40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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

When a GPU dma-fence signals, drivers often need to perform work that
cannot run in IRQ context. This pattern is currently open-coded in
multiple drivers.

This series introduces two layered helpers:

Patch 1 introduces drm_work_fence — a generic embeddable base structure
that handles the dma-fence-callback-to-workqueue pattern. Any driver
needing deferred fence work can use this directly.

Patch 2 introduces drm_user_fence — a thin layer on top of
drm_work_fence that adds kthread_use_mm() support for drivers that need
to access userspace memory when a fence signals.

Patch 3 converts XE to use drm_user_fence. XE continues to write a
fence completion value to a userspace VA using the new helper.

Patch 4 adds optional per-signal compare functionality to drm_user_fence.
When cmp_addr is set, the worker is called only if the value at cmp_addr
satisfies the configured comparison. This enables AMDGPU's EOP eventfd
per-signal filtering without open-coding the read+compare pattern.

A follow-on patch (not in this series) will wire AMDGPU's render-node
EOP eventfd signaling path to drm_work_fence.

v5:
 - Split drm_user_fence into drm_work_fence (generic) and drm_user_fence
   (MM-borrowing subclass) per Matthew Brost's suggestion.
 - Add per-signal compare functionality (drm_user_fence_set_compare())
   per Christian König's suggestion.
 - Use mmput_async() instead of mmput() to avoid potential deadlock in
   MMU notifier release path. (Sashiko review)

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org

Srinivasan Shanmugam (4):
  drm: Add drm_work_fence helper
  drm: Add drm_user_fence helper
  drm/xe: Convert xe_user_fence to drm_user_fence
  drm: Add per-signal compare functionality to drm_user_fence

 drivers/gpu/drm/Makefile           |   2 +
 drivers/gpu/drm/drm_user_fence.c   | 147 ++++++++++++++++++++++
 drivers/gpu/drm/drm_work_fence.c   | 195 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sync.c       | 149 ++++++++++++----------
 drivers/gpu/drm/xe/xe_sync.h       |   2 +
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 drivers/gpu/drm/xe/xe_vm.c         |   1 +
 include/drm/drm_user_fence.h       | 115 +++++++++++++++++
 include/drm/drm_work_fence.h       |  76 +++++++++++
 9 files changed, 619 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 drivers/gpu/drm/drm_work_fence.c
 create mode 100644 include/drm/drm_user_fence.h
 create mode 100644 include/drm/drm_work_fence.h

-- 
2.34.1

