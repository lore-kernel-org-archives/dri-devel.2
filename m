Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7DDC624CF
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B5C10E8BE;
	Mon, 31 Aug 2026 13:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uYSrotjQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5955C10E097;
 Mon, 31 Aug 2026 13:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHSEhJ9MAJ3OQ8DhngJ5fJqa9TM+3DSStfnUeCS9dNVnn9SltPNGAnTCMzGXmKSSRoyMM+XFFduDMVH3PDrA8WHBkXiBA5MsFkY8WlEOTMtT5i0MuBmXbt/GhKuFBonZmLTDXce/tO1TLJBVm/z22EJ4MmAYcUNcjGL2wYVkD69gnvNaYyOSWn5GxndlokmuOpl+yjYrNFGMeNpJkYX77wlIic849zipI8kxLtqDTxwvtEqjPLlc6cHp+PCaVFQKkRRsidkjFbfvxMP/FexHGOr58CUL7pb/OxLDMm5gSpn4S5/TRHFii56PrcrvTNvRdQERajeTZEJGzNf89U1tqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2myMWi3ndMIfrrCbal7NfLRXdf0Fe9xmgj4Eys9KT4=;
 b=nVxtWafxY8KM/wwgRnfiOREwTpMOGsLA751OeS4fxFKxYxJpNytypsu6GZy9S8u6goiq7VpAnSiRtgBRL3TaqrfZlJkbYA01zm0y23S+24W5e+JHJuns9qlSdJl+2eNFwK80Eg0nVZ/HO2YB1v4EfDEuCSVrhKq9k8ThfcSvorNlylaFBfkYbC5sh8CsoVDnqBh8RJ/JFkb7JTmu6rdCNw7QtKVGQUntcSsVdLV1vdCpQqLy6vddfPbQHoWZkhdvJxFqo+lVt9PM1c1AEnvxmexuMbhuUXWl+sN/9yUPS319vcWGhYwNwlZRysjUfGASj2ph+xnBt4t3xLqkA+YLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2myMWi3ndMIfrrCbal7NfLRXdf0Fe9xmgj4Eys9KT4=;
 b=uYSrotjQsyos05tgITy4eBX07b/0gtFeOBQ+3whoGNDJXTMLXnw9vjFFexg4fDnVUc7rSkAIJ1L6Q//anntgIyQSzNs+FD7v78oAycW8f5eyhIrmZH71QRUR699dVFeznH2H3Pbh1E/OXWEHVtm6ZqojxWLiPz0D4fIaL2ptddE=
Received: from SJ0PR13CA0121.namprd13.prod.outlook.com (2603:10b6:a03:2c6::6)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:46:02 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::ae) by SJ0PR13CA0121.outlook.office365.com
 (2603:10b6:a03:2c6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 13:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 13:46:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 08:45:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v6 0/4] drm: Add common drm_work_fence/drm_user_fence helpers
 and convert XE
Date: Mon, 31 Aug 2026 19:15:35 +0530
Message-ID: <20260831134539.112690-1-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 0653bd99-01be-4e79-e8f0-08df0766320f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: w0QOWUOkZEwJ54iaHxetGrwZR9DHw4uSuyYKS8uKzm7ODVcV1jUTLT9CqYmzRk9frXhAyETskQJAFdh/yip6uuczPJaSbL1jdmeTdTScS6q9NvlB76vHdZeKMlY3j0EvfKFPOQB8yL1zYkwS9jw0CpvalIP9A5S9J+Vi4ggGkEOxexJYgdwHBIeIlErHz2Zmn1mIFPyDXB1HAwaClcZs2jKvdOgzhdVCCVGLfWVflu8zQ8LXr0N7Dz9zjAb+n1tDkaO1TQNDQ3naKeQ8qEstmtNROuD66t3QXcjZ+NwYak0LCdN6myXH3grmSrmmlS5E3DSYc3qp1dpUfdgJQf/jwYGeGv2jtYWaBLPSiVUvumISNDxgIIoIz4VAnqKqmbCJd4mGIWmv6zVuP87NJivDcW4IfUpNPh9qmQ9GW9wkC4iWh9eZ/vbpADDrpaaxn5p+WUG7yI1p7t4KU5WKOyy5DQNlgYycfSpkzRkMJUHxbnS3vKdLsXRJR1fkVJWGNa0KQLJmqVPOxLBswB+qaXRCo2Hl4dSjSYu/roP8LsRMo4E1T7QcfZUfXkhcPnJcTC39TDMN1k6+f8gpvT1UnE01ZOgq+Z0/OZVK9wzManboP0ICrZkl2qShIfl+JreIuQEVe6ZAnhkRI59eor2mmHU+7xdNsLLbp1vQIewE6Po/hLqsOBpFzW8Df51rVRJxUMqCnAXFHyv3pMwKo+h7c/V1kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wtVp/krre2qKhb0RqVjZfdGxEs7QESm2BcmVW8r79nIlc0ZTxQCwvms8Qc98G2AYg53CoW/7MKiiLXF/0+DSqfk22Ngso/P24Hu2Sj1qoXTwFOitSz86A6p5dspPSjyikE2iJv26id0GAAokyR0C19KcszPNzRJg4emsagaEzbEBffjIU+9WPEq9tOwwogRqgnFrXFgn7tI/PPxjZ9jt8RwzFPPWcR11FBr2u4yJM/dhVyhyYWHov5/BlMz0rEasmCr+aCdQ5v4sZzvf0ZhF+XBWxj6tW8AW4+PMezMTAdZZS9qZ4R5HFNcp0hK395rMZXXNzWU3S73AFr+s9TL2BhaEhh5e9a80KV5PM2O9/tEL6lOLv9OcxFKYFQQQmZsJdOaAHtKPhC4gqTJS7jT7yhwO4PeHT0mZG2uP5i0P4RgxQzhUYWY/mVUfMli/OrLC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:46:01.6521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653bd99-01be-4e79-e8f0-08df0766320f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

v6:
 - Add WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT)) in
   drm_user_fence_set_compare() since get_user() of u64 is not safe
   on 32-bit systems. Plain WARN_ON_ONCE() is used as drm_user_fence
   holds no struct drm_device * reference. (Thomas Hellström review)

v5:
 - Split drm_user_fence into drm_work_fence (generic) and drm_user_fence
   (MM-borrowing subclass) per Matthew Brost's suggestion.
 - Add per-signal compare functionality (drm_user_fence_set_compare())
   per Christian König's suggestion.
 - Use mmput_async() instead of mmput() to avoid potential deadlock in
   MMU notifier release path. (Sashiko review)
 - Use cmp_op != DRM_USER_FENCE_CMP_NONE as gate for compare logic.
   Add WARN_ON for invalid set_compare() arguments. (Sashiko review)

Suggested-by: Matthew Brost <matthew.brost@intel.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
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
 drivers/gpu/drm/drm_user_fence.c   | 149 ++++++++++++++++++++++
 drivers/gpu/drm/drm_work_fence.c   | 195 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sync.c       | 149 ++++++++++++----------
 drivers/gpu/drm/xe/xe_sync.h       |   2 +
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 drivers/gpu/drm/xe/xe_vm.c         |   1 +
 include/drm/drm_user_fence.h       | 115 +++++++++++++++++
 include/drm/drm_work_fence.h       |  76 +++++++++++
 9 files changed, 621 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 drivers/gpu/drm/drm_work_fence.c
 create mode 100644 include/drm/drm_user_fence.h
 create mode 100644 include/drm/drm_work_fence.h

-- 
2.34.1

