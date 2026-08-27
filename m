Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6795FC61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DB610EBA0;
	Thu, 27 Aug 2026 15:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ldA2LI+s";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA55D10E8AD;
 Thu, 27 Aug 2026 15:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/SSFnY0ArV6yrKQyQoAu1S5he2t0app6Ex1/nhWxfvcZGYekLNSv0Lkfnzw1UBbYodc0r2TFjGulH0HWLqlCTElirvRcxgfWcdbCWntFe+/k+4LTYHYIxzC6zRX/4AKG6UP8apH356IcD+ONhS36nE6gtOVEJ4z7xcwfOa8l8TRKO53CiEflvQRYzdc3Ys7+ZzlvsZ0Hr6fYx5YVucXNbEF2XDnRjfuGAyw10+eVMrWmH1Ob3D3XcAzCBax6vuRdgYjdeGwt97mQ6HU7NXPEf/5wiqeDEMlTMaYFT9nmRbC3bR3AsLOInCbiCkgGtA5pdYyEm85lEZYYe/Ti1KfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otXZg+y/KlBPsSRjIost2p2NeVCp3AlBrtNxq90nhzY=;
 b=qqChhQZhfZYUbyfDovGqoGSWhYENcJEQgylNw684B1zj1r5IOsTOIsax8Ot3LkdjJXTEPqs+xrwvRtNpohsyR2ePWR6OSK2Uqx2MAfhg1VSH2oK7kn+/SxA8Af8xyjXlhOWwdHFSShCiUu2znktfd8oDB7XRqTtqve+EAz6SRfK+8oJf88fNVlq3i746pcH/TC0LwcXsJtxpGAyA2oyUdACmjIKSODQQJqv4l/mRXnVN6COR//jvO0yX0cJFszZMdKBtt+uf3EAXEI5rHzWikbCuJHr7/IueYUzggIiAHc/E2Sm9HVo7rob6Jy9xctYCHNO4EO1My2k4R7A3A50coA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otXZg+y/KlBPsSRjIost2p2NeVCp3AlBrtNxq90nhzY=;
 b=ldA2LI+s3d+xHwllZL7sYqqw3gQAzjF47qG05bdG81xOEb9UlXE9Pf0jS02JFHu0QHerA5pvS2rZJB1w98Hp+0aSqYD9lQnA61wkqlnfArn5rakF4dOwamSnF/RmJiymTOS4lSkqliXrojzbjZoyqClBFyKXk7dn+p4xr+i+2/o=
Received: from SA9PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:21::19)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:20:12 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::ac) by SA9PR13CA0014.outlook.office365.com
 (2603:10b6:806:21::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Thu, 27
 Aug 2026 15:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 15:20:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 10:20:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: <matthew.brost@intel.com>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/2] drm: Add Common drm_user_fence helper and Convert XE
Date: Thu, 27 Aug 2026 20:49:48 +0530
Message-ID: <20260827151950.4080674-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: fbff7a2c-d6e0-4c53-49a9-08df044eb037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: T0ZXqYoxWSpVzYUsrnIWNSJ+AhHduXOsDNNZFpLAi1m68lQCrvcKfViqKykFepLsjtJlhT8ZG1pHupUGzvnUvmNcDjso6PMqTHVwQrL6NLiKDET5X4LBgRkS483aKkM6GJ4Ml2vSOp5/Jk1Mas58h0NMzZgvjaWn2EkHEaeiWjO3sYCgTxgZHX8JYQ23plLCwY9UHX3RDvxbL1VoB3SReH6RZwINq81imBzUVZ8yxCH0PY6PEas8ibb8/ZAQ5kPVtAx7x+NdhbQuD4MyVdcng5g2yz0gJ4VkOx1HbBABpUIQVyh4EjtRBuJOj4Ez+W48bKe3X3FAIXnyJoKLtMwzXQM36yNuCGUtLgOoIOiA2jASQExnnLkOHh0+Gw8sgj/Y/p7MXG/N7alGWzls677MmdX1sGYiG5OmhWe4Zy13a8AT6qky5lzKRg7+RhTSK5ZwIqg0T4qhMWj/dgQ10m/7o3UtA7ANDHGozCez4jivQQGsHg9tv7iYVwf1TcCezQ/LtwFgBlLVgznHNCZO62d70/+TyscOKmf12MNX8fwGNHY+bNZ+XF0QnruTSzjFg1xlfNs4Hf/cM7qI6ddnPevs/Zxh3aoRxrCPPfzcba8yhvAd7Bz/EJjVyp9hwg4NZALq3oDDDnGdXjWyq6+TwiqMKfFYZvFjC3ArGokkJuVZrVsGbgp5NORHCmUleJpgpVy7XtGMoEEaR2f9Rp1Di0IVtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W4ooUo8KIlnXtQUxMWbSd04i+dMh+IPxcY2i0Bd3NjZ0JzR0mYq0KmznngyqxpnQJJiUDsvFJvpTAyv5MutGzjVPYSRHH/y9DigXO/15e1TW5SlbgW6+BPVsYaASoFpKh76/5+XhuWD6OqgqW4nqsPA/T4eWQrF0y8ZhXFdHpEW3eYOhKipjwiCWIQ7+G8OHQ6+U9XpqdGrSkMjxxTPBSpSKeGliVqInU15ZBPhWllBAjGBK/5P47D1eukCWrOt3khHrAhclKz0DcLVHBHCi7IR76mcesO4it/rkEhENnPj96+rqOHvZsc+rccDgkS3BMJ5nnG8iK5igsJBhAfUD5DbPXx4PQUukbOP50VeLNA40Zu0Gha2YA7NSLVZygBgVFIfyijwvt62ACkTvcFKJ3RXGVZ1AXNa9S0E1ImhfEiEsURlz8l3lRBJ/vDXyoBn6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:20:11.9624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbff7a2c-d6e0-4c53-49a9-08df044eb037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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

When a GPU dma-fence signals, drivers often need to access userspace
memory from a kthread context — either to write a fence completion
value to a userspace VA (XE) or to signal a per-queue eventfd (AMDGPU).
Both require borrowing the process MM via kthread_use_mm(), and both
use the same kref-managed dma-fence-callback-to-workqueue pattern.

Extracting this pattern into a shared DRM helper allows both XE and
AMDGPU to use it instead of maintaining independent open-coded
implementations.

This series does that:

Patch 1 introduces drm_user_fence — an embeddable base structure with
driver-supplied worker/destroy callbacks. The common code handles:
 - process MM grab at init (mmgrab)
 - dma-fence callback registration
 - workqueue dispatch on fence signal
 - mmget_not_zero/kthread_use_mm/mmput in the worker
 - kref lifetime management
 - cancellation via drm_user_fence_cancel_sync() for safe driver teardown

Patch 2 converts XE to use the new helper. struct xe_user_fence embeds
struct drm_user_fence as its base. XE-specific fields (xe_device pointer
for ufence_wq wake-up, userspace VA, expected value, signalled flag)
remain in the wrapper. No behavioral change is intended.
A follow-on patch (not in this series) will wire AMDGPU's render-node
EOP eventfd signaling path to the same helper.

v3:
 - Store fence reference inside drm_user_fence during add_callback so
   drm_user_fence_cancel() can be called safely without the caller
   holding a separate fence reference, fixing a potential UAF when a
   foreign dma-fence signals after driver teardown. (Sashiko review)
 - Fix contradictory kernel-doc for drm_user_fence_cancel() which
   incorrectly instructed callers to put references that the function
   already puts internally. (Sashiko review)
 - Add drm_user_fence_cancel_sync() to guarantee the worker has fully
   completed before returning. Wire into xe_sync_entry_cleanup() and
   xe_vma_destroy_late() for safe XE teardown. (Sashiko review)
 - Add xe_sync_ufence_cancel_sync() wrapper in xe_sync.c so xe_vm.c
   does not need to include drm_user_fence.h or access struct
   xe_user_fence internals directly.
 - Add smp_wmb() in xe_ufence_worker() between WRITE_ONCE(signalled)
   and copy_to_user() to prevent store reordering on weakly-ordered
   architectures such as ARM64. (Sashiko review)
 - Replace XE_WARN_ON() on copy_to_user() failure with drm_dbg() to
   prevent unprivileged userspace from triggering a kernel warning by
   unmapping the user fence memory before it signals. (Sashiko review)
v2:
 - Move INIT_WORK() to drm_user_fence_init() fixing lockdep class
   divergence caused by two different INIT_WORK() call sites.
   (Sashiko review)
 - drm_user_fence_add_callback() now consumes the fence reference in
   all paths: transferred to the callback on success, put immediately
   on the already-signaled and error paths. (Sashiko review)
 - Add drm_user_fence_cancel() to allow drivers to safely detach a
   pending callback before context teardown. (Sashiko review)
 - Fix premature dma_fence_put() after drm_user_fence_add_callback()
   in xe_sync_entry_signal(). (Sashiko review)
 - Fix missing newline at end of new files.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org

Srinivasan Shanmugam (2):
  drm: Add common drm_user_fence helper
  drm/xe: Convert xe_user_fence to drm_user_fence

 drivers/gpu/drm/Makefile           |   1 +
 drivers/gpu/drm/drm_user_fence.c   | 210 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sync.c       | 140 +++++++++----------
 drivers/gpu/drm/xe/xe_sync.h       |   1 +
 drivers/gpu/drm/xe/xe_sync_types.h |   3 +-
 drivers/gpu/drm/xe/xe_vm.c         |   1 +
 include/drm/drm_user_fence.h       |  76 +++++++++++
 7 files changed, 360 insertions(+), 72 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 include/drm/drm_user_fence.h

-- 
2.34.1

