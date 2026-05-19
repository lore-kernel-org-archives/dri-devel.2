Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4DBCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4E110EB5E;
	Tue, 19 May 2026 09:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CJy/n8oO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801F110EB5E;
 Tue, 19 May 2026 09:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SA5gY3+m8kPxmHAxbJU0myIRWxWmB4tVaQ/uUG/nlXyD9GKmvqG8dWCTDilAl7OLH8PMRbg95iYOHT0Z68U1UN3NVa8bWKAyoiPFga1o+kI5hfmeZAEhZAT71imuPF3rvxx6ZgqDpKtVpxuniwfT0plsgGRjdwrueaZ4FA6/G/LBTNjzOkg6d+x4IZ8uYpiFTqclJ3Yk/PYAaHmv14oHFVzUFGt7NGAT5lzuddEkfXI9EPpjrq+8NtdL0vzjjaTbwNyD0rgTm+pLhPUAECMuYYdDZaJvK4E/ztxcLIaTDMUokYNJUrtqkEjAfcQ8mvgZBbojrJoKAWsMB4dwz6zr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3XC2w4iUBwwpDJwC4SQ4T4ACRYm2KB+0DfN1xFXKdo=;
 b=OAAy/2bYbDzQosLwf15uBNFs2MqYdL89I/cZj1A6CwDAtIE9HQFTnW66Mx3Tz2TXqsK2iX1Nzmoa1zYm2fIjcm68agQcGziDFT2RcaXp6E8tukrp4cnimivJVezAnRmsDHz0HSqXLb4SNuim+jLGJQkWhv7NPISC4tYCYSIXXD1wJYHWZkyA9qCaARN2UKOn4EIOb40/t+vjOIsKaK8jK6Q8XJhK/ZEO1QjjYu4npclA3RmecPgvgBsrNaNtM9Z7eyS7PjFob3e6c+KkarMEblYPwBo1T302jZGd01RBF4gIqG72cqyoCB/dFx6Zwn7hX9H/GuH12dhii0fo/2YIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3XC2w4iUBwwpDJwC4SQ4T4ACRYm2KB+0DfN1xFXKdo=;
 b=CJy/n8oOIVGFBMHR6Ywkn7n3odUiRWZ4sCnh+vako2XtwhDYhyfJCGmeMNqfz+069gqYRYwiwpyj4WFRiyTmhNQI+nWXUmxOjTOtuY6EyWYsnOnPngbgM1nGujg/ttz/Xz91PZ3/S5UPBjyYf2FUluRcxmKoTnUOr+1oyAwPEF4=
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 09:23:32 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::81) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 09:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:23:32 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:27 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 0/8] drm/amdgpu: add xnack off support for SVM
Date: Tue, 19 May 2026 17:23:05 +0800
Message-ID: <20260519092313.3115848-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: d90b887a-a6f0-4cae-f193-08deb5884b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003|11063799006|921020|13003099007;
X-Microsoft-Antispam-Message-Info: s2/jY49D8EOrNkO09/z7xdbxl7fFGzMt4NACaOyq2fEZ3x1MkxdAWk4FTW/O+YM9eFhwlZSg0X3po63QkKmM3DPpuxE/cEICyib0FsVdTNvQ8zUTw56ICvbQo7LFFTFsexLBZ8EYbCZ8usrDlco5QS/ivsJr6mLQjvIbvkRhOKTjNEY4y6b7kjmkHMLSNMuL2ZvWWCah7LOwCqBe0eFF9SmT8UyGbKYzsiS90JkZDlU7a3jvD1iY/9530hiz3vVSYYBWh7A4lrm5vJjxksgm+XeLUHC1WP0gsSWogF0ENei/x5yMXQZvfAZ4RrSzHVxvnT7jXZBBe4w0rkEuz+cXisNgKincZcdYKWf3GYpAEG1lnF6eTj9k2efpjdtMPe2ET1AdlCbpKuZniqbEm/Et1EdteVdDN0QzszZdgFiHC/29H6pZTGm8FJbNvlgpEvdsKA0b693SavJZ0uOsr9JeqbkRJ38YkCKKS67FsSUa/LZLmAwN5L5xkf2bOAm1KJ8yOo5hmz6QBmabUN+XrRPMP58h0vWLpcX2tvHFBdBVv6k7lPtgv/HzCXuILFfbuQZ0vtaz71nZfdDtnkaR5ZV7XRvFSoZun9s7iqrAGB2puvV2sdgnYM2yXbnZ+j7+jlosHB26nnJ+bLXYVhzxisVtqDKy1bmFzwlF8gE9ZCOSVmZn9l2CCIsJYUEnN+78WDo2qubU4VpfrYJ1fYXTrMwFVLWJrTbQy2JBDs88I6MWFBI+65oQ/7iEdo7lm/Rrp1tLynxA28ivm6l6o9taFHu002pNW4qvZEECmLuy0fosgt8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003)(11063799006)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7zK17dWjYiv6UgKXzI89n7h4PO2YrGqjM9jgqNNiiHeJeyYDr4Do8zwLx2R5WjY9IO9nRh5dlu3fQB607f0FOGp6CYr7HXJaadF/3ZUfYG1o7PeAmi5SfyiS+Yl+rNizqL0ki78E193TDaEry/q/t/agHAc96WwLHqz2tJQhMQNGbi1gGyzdmfS1sjwYebE36421R9oKA/XToasx80T39ek+xEgVPQVA/ZeBsrC1UmP4HGtPkVodnUqbbsaCcVMW5tWUH3W9rgT77pp/get0gG1Riww3pPq5BSi1ZM64FirdIoL9cK9onwUCTNV2dQcBUoKwrGVT88xGezpBBRxN2mf9bkVY4wX2LQfevNb6WjA4lDqH24Tri8oU3Tm340kSfKLeUVxJk1a4BTXLvhg1m6f/nGshoNNqP7vaU9dORHaSyFEUqzd/mTtvwZytdI07
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:32.0087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d90b887a-a6f0-4cae-f193-08deb5884b8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768
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

From: Honglei Huang <honghuan@amd.com>

This series adds xnack-off mode support to the amdgpu SVM.
The design follows the invalidate and restore pattern in xe_userptr.
extending it from per VMA userptr scope to drm gpu svm range with the
additional requirements by amdgpu's xnack-off mode.
Like xe_userptr, the implementation is built on top of the drm_gpusvm
framework and centers around an MMU notifier driven invalidation.
This implementation refers to xe_userptr.c:

This patch series implements SVM support with the following design:
  - The notifier invalidate callback moves ranges onto a
    spinlock-protected invalidated list, like the __vma_userptr_invalidate
    in xe_userptr.

  - A restore worker iterates the invalidated list, calls
    drm_gpusvm_get_pages() to re-acquire pages and GPU
    mappings. the same get_pages + rebind flow used by
    xe_vm_userptr_pin(). On transient failure, ranges will re-enqueue,
    following xe_userptr's retry on EAGAIN pattern.

  - Lifecycle follows the same init/fini/flush structure as
    xe_userptr_setup/remove/destroy, with flush ensuring all pending
    work completes before teardown.

Related work:
This series depends on the base amdgpu SVM series:
  https://lore.kernel.org/amd-gfx/20260519083057.3108087-1-honglei1.huang@amd.com/

Test results:
  Tested on gfx943 (MI300X) and gfx1100 (W7900) with XNACK on:
  - KFD test: 99% passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 99% passed.
                    gfx1100 (W7900): 99% passed.

Patch overview:
  Patch 1-2: Define restore types/states and integrate into core headers.
  Patch 3:   Invalidate callback - dispatch ranges to restore or GC list.
  Patch 4:   Restore worker - get_pages + rebind loop with retry.
  Patch 5:   GC worker - remove unmapped ranges, rebuild partial intervals.
  Patch 6:   Compute queue quiesce/resume helpers.
  Patch 7:   Attr change boundary realign helper.
  Patch 8:   Wire restore into SVM lifecycle and attr set path.

Honglei Huang (8):
  drm/amdgpu: add xnack-off restore types header
  drm/amdgpu: integrate xnack-off restore types into core headers
  drm/amdgpu: implement xnack-off restore core and invalidate callback
  drm/amdgpu: implement xnack-off restore worker
  drm/amdgpu: implement xnack-off GC work function
  drm/amdgpu: add xnack-off compute queue quiesce and resume helpers
  drm/amdgpu: add xnack-off attr change boundary realign helper
  drm/amdgpu: wire xnack-off restore into lifecycle and attr set

 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c   | 890 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h   |  68 ++
 7 files changed, 1013 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h

-- 
2.34.1

