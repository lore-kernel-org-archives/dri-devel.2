Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55922C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFAC10E39A;
	Tue,  1 Sep 2026 09:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3kzV/SMe";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD1C10E39A;
 Tue,  1 Sep 2026 09:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+Gr2SsFM53yVxB0Lo/g4oebmmAt8H5Hr/4i23wQfn6Yg03TdqYnO2qXFHV8nodx7/OM7Ultf3AOPXNGOoOqODJlvXM56EXa1WVbAeGvTzJsWC+w4Y77j4ova4x85OTghurRO1aIpm+4WRdnrSHe7p8EWFDdxFUg8Ov+l5dDPhB1rnjlveNtVEkokVvUemGmV+Ol4ZKLdMW1teTMb7X5KF/RAxY8A2vwz+3JblkabbLK5vYITmzzPpRPqtewvdy6bo9Q6xUd5zajuqxHiPf2TXwXUTTNBh6VvF9y4nK5eU2RgbUOSIFEa0/sRom67gQeHCf92eOpJv7KnJTCX2JtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bNcMnE8OBmQkiWltrsWZs7ufcWxM4P2eSALjx6zuHk=;
 b=MbR2Tlj6ovhyNJ6vmhc2Yn3e5h54aGCPV6fipvmTPIHL7onKd74Yc3vzK7pdtokQx6pMsh2k/tIHg6CEDMg349zLxEQJcRjuxpVcXB/kyaQlWtplYD1QKPHL24z2bE/eoIgoaENxwsHZicgGemhmb9/eUS8mWSxITU4e7WpO+2AT/kTwVP9VXak4RDaZEyYuxmohoFwAaQumsTfFLLC3YRy5nuphskab4orPayZf/dZHElq/BR6UjWrKnsmo8BfMPenLEwET2vZOMBCxOBFWwIWVyIli3IiIqnESdGgw0aWX2qiR41Nlasce+rUW1xPxEna4n/KjgN/ED6usPGi4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bNcMnE8OBmQkiWltrsWZs7ufcWxM4P2eSALjx6zuHk=;
 b=3kzV/SMeumt+SQnZ0Fzrh8FOUCxe11LN4YNDV0o65srXra2RblF6mmfmn7eIC56510GWwZmykVvzGsUWW4sb5VGbjbFUDTG1Iri9idAa3THqAx+g++Op4C1rzBca5eE2XDY3NitcxeL/XsA+vgYbvaSvnbLLupMss9Za7Dq9Jjs=
Received: from SJ0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:33b::17)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:01:15 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::76) by SJ0PR05CA0012.outlook.office365.com
 (2603:10b6:a03:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:01:15 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:01:11 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 0/4] drm/gpusvm: share one HMM fault across per-device DMA
 mappings
Date: Tue, 1 Sep 2026 17:00:56 +0800
Message-ID: <20260901090100.2024933-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 137ea3c0-2e35-437f-5c83-08df0807942b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|7416014|10067099003|18002099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: JlFk4xYA1OJ8Z+9sZSZvf87lCxt9BkvHu8YqnOJrUvCG4NyZnzOFn6OfFqL/m4pR1yazW9H6L6z8ibI8HDcSZhOx6zLXwgzBSnrHdrxocJYUNkPvBbYAK8BPLT/RIdm9oReTQi6XIrm0NYq12iR2eV2rmgZk/tvmtCXlwoEaX2bfkOyVcS5MDPzFSuFccoufaZzG3p9QbtiTWMRvjvPZuLE6DlKzQieDZpybrbdTcT4SIbjkF+wnwdTsH4cgg+PHi2PJKbBUD+7E02yzaJFdm9UMVFm2TzDuzyGfB+KY5ithktr0NNoh0Omt4dyjymtsbbuIWFI8KQjgeMHyNZzs48vLrPyAlFjEu/FuA4QfFAr4VYNZARMQs1uq1KmOVboqFCYtsFzglHnXiILBKPxn0RzlTjbTA+GKB2a1v4JdSJTXxAk4Gm+15lSJORweC6MXjDTZ8GnO7ilBZGgYaGryHbUMpwtSVl/hee9rfPuRh+IK7lZkJqti5X27u10RgIYa23uk3/X+skde3wyhrPT9EfpjL8B/95VLVx+GSUwQdyml1j9LoPCSE3miUVPyst7yxUPrKqARgJBUIdU1eUY6G0FZA6mlNuqWZNPuwTFCHzl6CpISpPZX4Ix0FEazSBtd+krC6zrq1pNTRPEKlMcptg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(18002099003)(56012099006)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CH35ppZ1hXyART6qNc09uVDD5QO7cwc+AxmRh3AUP6VlXDBRghUTUTXZIP75D1g8Dkd+TApKadHi8RV9qZAyiJt9jsRUEdnm8HTKmnNPAhjnmxSgfVvtkjyaHhUxDcPCNktYHEwllgTiOvRS7KDgU0/RYwWejxySGwW9fBKWRxADZNXZWLbVKZA2KhBuRQ/SdAajowfX+dgZ3MhHAMW0/MFUUGWM/W+5S97FyHtH1F+lz7UU0OcgieHGAmfCc9RujnhBMvghixCiZa3ffnsnSN+SDoPAwNRXWm26LzVkD7spD2+Je9NoRIcwcHT4Eb4XeTNBJan+jWyASqen97d2l+cMcLngtoCAR9rsZBRLElcxf/LgmP5Don678GmT+qNW35NC2Drn08CgHkmQZ80uRcdv6vCOVEVlrAAU5h/tWKjcKyPB3TOV+Q8HZx/GG3hQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:01:15.2237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137ea3c0-2e35-437f-5c83-08df0807942b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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

This series is a follow up to the earlier drm_gpusvm_pages decoupling
series [1], and follows the direction Matt suggested [2].

drm_gpusvm_get_pages() does two things at once: the MM level HMM fault
of the CPU range, and the device DMA mapping of the faulted pages. When
one CPU range is mirrored on several devices, every device has to call
get_pages() and redo the HMM fault. Matt suggested [2] passing an array
of drm_gpusvm_pages plus a count so the fault is taken once and shared,
while the notifier retry loop stays in common code so drivers never open
code it.

The series builds up to that in small steps, no functional change until
the last two patches:

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

Patch 4 has no in-tree user yet, AMDXDNA is the intended consumer but
that conversion is not ready. It is independent of patches 1-3, happy to
drop it and repost it together with its user.

v2:
  - Rebased on drm-tip. Matt asked for Stanislav's
    hmm_range_fault_unlocked_timeout() patch [3] to be carried at the
    base of this series, it has since landed in drm-tip, so this version
    is just rebased on top of it.
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

tests:
AMDGPU:
  SVM:DRM N:1 multi device support is work in progress on top of this
  series. The single device (1:1) path was tested with the amdgpu SVM
  adaptation on top. Based on amdgpu SVM [4].
  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
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

Honglei Huang (4):
  drm/gpusvm: move dma_addr allocation before the notifier lock
  drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
  drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages
  drm/gpusvm: make the DMA mapping step in get_pages() optional

 drivers/gpu/drm/drm_gpusvm.c    | 336 +++++++++++++++++++++-----------
 drivers/gpu/drm/xe/xe_svm.c     |   2 +-
 drivers/gpu/drm/xe/xe_userptr.c |   2 +-
 include/drm/drm_gpusvm.h        |  10 +
 4 files changed, 239 insertions(+), 111 deletions(-)


base-commit: c8420bcb1802510e5411ea4c98e2e07bdb43d74e
-- 
2.34.1

