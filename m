Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE805C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1820610E00D;
	Sat,  5 Sep 2026 13:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XRL+zhxH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB1C910E00D;
 Sat,  5 Sep 2026 13:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SF/1ZP064B+gBNJoPPf5GvnBiHpPphg3oEvMVM8ybVj4S1E3MqVd5FbuK4DDF7L+4xbkg9IcIsUbPS4dQ0wpad86tDISi3NT/MlIw2LuaEE1hLwTHqj+MGAIjDF3R3skYAkxV3156K6zNn1PoxFEdKAIqWtGueJ7uQMTC2X1nu1KH2+n7HfJV3DU7XTce0PVmidkMh2KG3NvwfEcJ8gPWkRXkwDlZsW6fRgDSSOYeZ/zVTR5bRZE7+IiecMvnTWHOA0vRqyRCGAUjCZboQoyNIChrN5xB9LgxoNeYThgJtDb8jKp4D1hORaGILsATOtrBqldDa+t81wQbkiunWRTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIDKNeCh+n9w53XzPmocMMypfprUK7u6fQZrKGHT/Ko=;
 b=YJbmKT1hIbeyWSxHehEsGKQuiAGH9Bo+PZmPqYtNaNh2LKyL8ihYOdrc9qAMTiuAKH25P39hhKrFplH7mEEnYXYzFkSo0uDWJBaVENj+leQNpX20vjDo+DJw9msHGLZmFlAcJh/EuNd3eqo43Ho6u4sq7oNxVxxHqHSjtg/sw/GhR+vdxMzWcuMvib0+iBXZpjTwber3mN0bzM449WzRHtzS6lzK9tQuc9iiek6FyuSTyExsEvaRK38/lcaxHLO9TRIxRWF4wZbXuahLiob7o2U+gxUMrGSm6fAhqwazblnNLJ8HItv2a5JZQAB7hxMtgdnjivxBFmrMW02r0QIU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIDKNeCh+n9w53XzPmocMMypfprUK7u6fQZrKGHT/Ko=;
 b=XRL+zhxHWuwbiYPL3b3b7FQFwyEF/jOY/Z+fguQGLd5OTnXDilBPaze98GDPsD2dCPNwSBJn64euFX3iV4vIDWKUXd7rkKPInd/Iq/7eO3EriymJNrBwDHGvNFTdYjjH1aMmLlb7kSvqwA/GED43w/MoD/5jq3+y1lth2mIqS4E=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 13:31:59 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::63) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 13:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 13:31:59 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 5 Sep
 2026 08:31:55 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 0/6] drm/gpusvm: share one HMM fault and keep single
 mappings inline
Date: Sat, 5 Sep 2026 21:31:36 +0800
Message-ID: <20260905133142.3628027-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 067dcfe2-b82e-4b86-c47e-08df0b52101b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: KG+KG4JF0JtUxJLEEk151FeWHwXbQZkr38e5m2QBkMhW3+pCCOsjzvCAvs5CPDVaJAJDNj4EkxtSn3od0z7aokEIhUOXuieNMS24Ed5XBwr37FrdlcUOJh82uB1i5fCgEaEbBIZpe8DUzV8JS8/L9o1i4sAntVJSPumhgQRXKp75oiv6PfMb1v/YrVZNSKEKirayc0vE3DLWxO7LmBeLhQ0nUnk2OYSmCV27xeFh3nvhvyOkwQIxDubccBNNMCUfhC5LF6APaS1EcKvSiKDiF5VY7LcvupTucGDwjPEJAHxX7aoq9aMM4cUThVh1ydl73X/Ib/SmL70DOLRluLYALyGffg4CU1lqGtZ2KoSOheYUMKYoLcNqS3RmdZGl+hDsprA8Dz+xuko/KVWQtL8zwdjAes28x/IkcTBV13p+GoLgcQRl+O3fkPcBRcvWdaTBuZdeNEJNIWNqwaN40r3RpDnfYw+PuHKQw2kxFIPsX6m7i7snmlGHrOjEkGSh/cygU0CBPT2UZltFagsc+H6qIE+aIJJUB2LBnzxjEan6Mb07vo1fQeoH4YPiFC0Y+lSb1DrWLxoxGz7iuFO68n6kHWy/sLjfhtWAqeE6DB29zaAqWkrmw1B+gfyWFTmZsCmpr7jV1Anvk/CSBNO8wp3J8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q0zn4mX8ilKmSjQ24kRAlB/Vr2R36xTYhiDjQcTkZawvjYpbxKJuW2OyfXX4CUvpXcCN96ITCAshLRoCJDLsqasIJ06c5yBEJ7KX6R4HiWTzLR13R4lhutCyKQGXcUuY5M6kGRPPcXDsIB820j9lenj781cqGt8GY+HWK17QkJmpH9t0nNKMYEXQo+J00ZyYttsdJZ26crpEuxdeoMnjHMA8TOYXJIK/YCjcX4GmSRzHePxTf2k8XAIrX1TKMHEA9FJZeRGozvWCfrJo9Lx8kMup6j0A8SML/+M4q0OsMcjfoNGDF6o2BUMl9w3mZMn0cZLN1ORSxOQ6N3AJwp6dxUXIl8LYgrR3EUgdpiKsTJOTmdA2pL4A8Jamzzu5dxa/zZ0cmJa8cWYhnRgm0oIdjWu6JuzQYVFGycF2zRLqB0R5IKcB/MXyNwPybjJ9cEc0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 13:31:59.4825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067dcfe2-b82e-4b86-c47e-08df0b52101b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

Patches 1 to 4 are the get_pages() split already posted as v2. Patches 5
and 6 implement the dma_addr storage optimization Matt suggested in [6].
They build on the DMA paths v2 reworks, so they are sent in the same
series; I can split them out if that is preferred.

drm_gpusvm_get_pages() does two things at once: the MM level HMM fault
of the CPU range, and the device DMA mapping of the faulted pages. When
one CPU range is mirrored on several devices, every device has to call
get_pages() and redo the HMM fault. Matt suggested [2] passing an array
of drm_gpusvm_pages plus a count so the fault is taken once and shared,
while the notifier retry loop stays in common code so drivers never open
code it.

For patches 5 and 6, the focus is on optimizing the storage of DMA
addresses for THP pages and IOVA mapped ranges. get_pages() sizes
dma_addr for the worst case of one entry per page, but the mapping loop
advances by page order, so a 2 MiB THP holds an 8 KiB array with 16
bytes of address in it. Patch 5 keeps that single mapping inline. Patch
6 extends the optimization to IOVA mapped ranges, where contiguous
device addresses allow for a similar inline approach.

A range folds only when one drm_pagemap_addr describes all of it, which
leaves three shapes not included:
  - Mixed device and system pages: the device addresses come from
    device_map(), outside the IOVA reservation, so they are not
    contiguous. Not included for inline storage.
  - Mixed orders: contiguous under IOVA and foldable in principle, but
    one entry carries one order; expressing two needs an entry count or
    a segment iterator. Needs additional handling for mixed orders.
    So not included for this inline storage change.
  - Several huge entries: needs a chunk larger than PMD size, which no
    consumer configures today.

Patches overview:
  - patch 1 moves the dma_addr allocation out of the notifier locked
    section, so the mapping step becomes self contained.
  - patch 2 pulls the per-device mapping loop into
    drm_gpusvm_dma_map_pages(). Code motion only.
  - patch 3 makes get_pages() take an array of drm_gpusvm_pages plus a
    count: fault once, then DMA map each instance, one per owning
    drm_device, under a single notifier retry gate. Instances that are
    already mapped are skipped, so an -EAGAIN retry does not redo them.
    The common 1:1 case passes count == 1 and is unchanged.
  - patch 4 adds a no_dma_map context flag so a driver that only needs
    the CPU pages faulted in can skip the device DMA mapping.
  - patch 5: keeps a single mapping inline for THP.
  - patch 6: extends that to IOVA mapped ranges.

v2:
  - Rebased on drm-tip.
  - Dropped v1 patch 1 ("drm/gpusvm: extract drm_gpusvm_hmm_fault()
    helper"), it is part of [3] now.
  - patch 3: drm_gpusvm_pages_valid_unlocked() takes the array and the
    count itself, instead of get_pages() open coding an all_valid loop.
  - patch 3: fixed the N:1 doc example, it used the wrong union member
    when the count is 1. Added a driver_pages() accessor.
  - patch 3: documented that on error the instances mapped before the
    failing one stay mapped, the caller must unmap and free all of them.
  - patch 4: reject no_dma_map together with devmem_only, without the
    DMA mapping step there is no page type check to enforce it.
  - patch 4: documented that no_dma_map only returns a snapshot, the
    caller must recheck mmu_interval_read_retry() itself.

V3:
 - Patch 3: check svm_pages[0].flags.unmapped instead of walking every
   instance, per Matt's review. drm_gpusvm_range_set_unmapped() flags
   the whole array in one go under the write lock, so any instance
   answers for all of them.
 - Patch 3: reject a zero page count instead of relying on the caller.
 - Patch 5: new, keeps a single mapping inline for THP.
 - Patch 6: new, extends that to IOVA mapped range.
 - Add Reviewed-by Matt in patches 1, 2 and 4.

V4:
 - Patch 5: add xe_svm_range_first_dma(), with a stub for the
   CONFIG_DRM_XE_GPUSVM disabled build, so xe_pt_stage_bind() type
   checks in both configurations. Reported by Intel CI [7].
 - Patch 6: the wrapper hands out the contiguous flag too, and the stub
   clears it.
 - Add Reviewed-by Matt in patch 3.

tests:
AMDGPU:
  SVM:DRM N:1 multi device support is work in progress on top of this
  series. The single device (1:1) path was tested with the amdgpu SVM
  adaptation on top. Based on amdgpu SVM [4].
  Tested on gfx906 (MI60) with XNACK on, in three configurations:
  THP ON + IOVA ON, THP ON + IOVA OFF, NO THP + NO IOVA.
  - KFD test: SVM all passed except the get attr refactor.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 99% passed.
                    gfx906 (MI60): 99% passed.

links:
[1] drm_gpusvm_pages decoupling series:
    https://lore.kernel.org/amd-gfx/20260630102127.392396-1-honghuan@amd.com/
[2] Matt's suggested direction:
    https://lore.kernel.org/amd-gfx/aijdg7RWwrEDEMxC@gsse-cloud1.jf.intel.com/
[3] drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults:
    https://lore.kernel.org/20260723-hmm-v10-v11-8-c55b003a4b61@gmail.com
[4] amdgpu SVM:
    https://lore.kernel.org/amd-gfx/20260804094246.1719318-1-ray.huang@amd.com/
[5] v2 of this series:
    https://lore.kernel.org/amd-gfx/20260901090100.2024933-1-honghuan@amd.com/
[6] Matt on keeping the dma address inline:
    https://lore.kernel.org/amd-gfx/apcp%2FXJpPdG3jzPd@gsse-cloud1.jf.intel.com/
[7] Intel CI build report on v3:
    https://patchwork.freedesktop.org/series/173405/

Honglei Huang (6):
  drm/gpusvm: move dma_addr allocation before the notifier lock
  drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
  drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages
  drm/gpusvm: make the DMA mapping step in get_pages() optional
  drm/gpusvm: keep a single DMA mapping inline for THP
  drm/gpusvm: keep an IOVA mapped range dma address inline

 drivers/gpu/drm/drm_gpusvm.c       | 406 +++++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_pt.c         |  22 +-
 drivers/gpu/drm/xe/xe_res_cursor.h |   5 +-
 drivers/gpu/drm/xe/xe_svm.c        |   2 +-
 drivers/gpu/drm/xe/xe_svm.h        |  20 ++
 drivers/gpu/drm/xe/xe_userptr.c    |   2 +-
 include/drm/drm_gpusvm.h           |  71 ++++-
 7 files changed, 400 insertions(+), 128 deletions(-)


base-commit: 313da1cc22491f07075c7ae36372343aa235d11e
-- 
2.34.1

