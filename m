Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1550BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C978410E2FC;
	Wed,  1 Jul 2026 06:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qTElyHCL";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB3C10E2FC;
 Wed,  1 Jul 2026 06:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM76kpATZRYvL6o/KeCf2doHQMP9th6HZtTFHRLZlNcyWr39ngYADgTLRW3M7hbrL/6BgEReNXUjxnMViRfrkAGqMDA8Pxwk2o9OrrZlubZHWPW4nbGWoHe3Qf4Uie1l9YvCz3rIJ96WX1eJGqJjyiQz+gwBcrogNXernVJVwhQjbeb8h9yu4pFLpBA1tlc1crxqxBWKsMrH2HC7UCCKsYr+cn6dMk7rLuf/8RE37n4db9PwEmqoWKJ9clXS5ulX4qDRujtVTfMY6+m1oBRc/2FFjHV8AeC8z/0vTNwJmoGXfcIRIeNrMdoOuyMbVao66liu4qZ8tGjEYgIWVC9GJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YimKKcZxXCK5Z2bOjLneMcn3XX+4Gf9m2i33BS4EUN4=;
 b=mRnjEaPREdFsHMZfWm9zc4TYbcJE3b/G6OzhY/uXDwdGG06Z3JygC3piZIjhBMO4XP1H3JqmcWp9N4AEnHPc8b+LEWhHE+1vJbxizcOrLRJeot0JgDSfcbmyaA+RVJQEDF6m54tmTPL28BTh6xXreqPa2gIob42zn7HfNs2GgdFjRxkAwvkPEHNTJkj7nzer/e5g4Ef73lTH/zgqtSVu6p3ZzvsHtjU7XChyB8PgllcSqPBXIWH/Fa3sI9T31g3WCuJ+JZU9ACIwqQtu1apSdyrGF80TW0tRXRpF22PhCfG+fWd5ZT6dNsX/IUt//L1Xo7hqGxlh5A+lEkxdR6juNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YimKKcZxXCK5Z2bOjLneMcn3XX+4Gf9m2i33BS4EUN4=;
 b=qTElyHCL602Fe6+sgRXgEinTXaQpt8CYO52vRBqS0u/uu6wklI7FpSU75jrIvj6gaRiBeC1bP8PCJcmXsdLOijg9esvDWOAc9Z4fOvtA+5Gey6KViBAqpouzV75b247TLQ5tcg5LXFGZUVCELVusHkRdxFmp5Ua0vFqbJx5lTJI=
Received: from CH2PR14CA0039.namprd14.prod.outlook.com (2603:10b6:610:56::19)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:28:15 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::c) by CH2PR14CA0039.outlook.office365.com
 (2603:10b6:610:56::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 06:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:28:14 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 01:28:12 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v4 0/3] drm/gpusvm: fix IOVA/DMA unmap leaks in
 __drm_gpusvm_unmap_pages()
Date: Wed, 1 Jul 2026 14:27:57 +0800
Message-ID: <20260701062800.409248-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ba85f2-fd13-4332-9ed0-08ded739ee4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: mSO3sikSykB5EYBbblskg7oEAbM9R9ypmlKfuWzu9gdNrqexGIGQiiRzFMpi4Ao/uGCzFdAcazqSxLqJtkelumPeoYLjiGGsc9XtglfZWbO+8Fv/q+pmPhGwczhes/MlwhRjCZXIUmkiV/kAoCMTQfOYTzkDjUo2dTuqgvkV/iOTpIcm5Fmv/qnBed6BvnFD9PnYvkx18KzQ18eB1MwdFh2634g0WELFu1BDWvpyDOOzKEJ2TvmOecc4Yl2WnCPLPZvJ/k2vJ6/+Xfs5uKvGcS1iL+TYgfmmlaWszBmL+4tOMHw1zfSHK6AF/rWug4CYxZMXqWhWsVDHdBhp1gBucCvMDkYTMA6vn0UZrdnS8ROAdN6OHWjUURns34bBnmKIFEOwblt4nGlZtKCHROq/fZEqRcYJXAhSi7fOZbu+gN6n+OqNgzMtqRAO7oOpgOYdYvw7WnvSzFAq6DF8CdCVefJiCLh4dUtW1coU5eKxZHbUnvAOZa/wOWDFSFdkKBmV0EHG73sqk5+5+BpPem3L2gf6RS8HdB6e6kyx8UIdx5O6YyqC4MrPqfQCDInpRulqjStmLIVcsI1Vu5INvqci8cs6nftBZiWfhvLy7UHKRLPRBumve4/JK9KxoOqUUVTlnJ/s2i7Sp3oK+SDXNbdJnSuQEYplQ6TY9fm7Ci/Hl314tHRNybD90+tYFdEYvHa+BMvzU/bvrQXj2YB5CiNcLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ESzZmaStR5GBPNm07SBNKUIIe0wwdawBEDBXi9gN28dg2u5LPUGc0d1ukF6CKfVNMCMQU7xsVzbDwwx1oaNIzdmpqh0YdQqT0eHgQBdNQYI+lB/Aa+7IAecw6B8bEkoMX7b+UELa/oQ6XPM+XZmkCqgGrDLoahKevmCCL57ym6eAcqqVl2xatWXK3HhIzAZjGBpH77CdjQkJfuseGY3O4FTINNEVIMaPUmVyADNuQW5OzeD56LCnnVspSDJ/ogZqJ7jFe2imVnihSibaU8dyib77NGDQDApVRCu1CqreryY8vzXxxREAN9VYs49u8ImDOp5bcTWW5GrPFikhcRXNBLMrV5MRN8KzqFQTTi2RqOsIIgOPFiPMXNJgcYbgo4UfJgONwCqBzvgtNTONpx0gexg/kaQlSW6eCd8TZtlBpxRPNYYpegr0pUeE5n43aZlN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:28:14.3773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ba85f2-fd13-4332-9ed0-08ded739ee4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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

Three small fixes for the IOVA/DMA unmap path in
__drm_gpusvm_unmap_pages() and the get_pages() error path, all spotted by
AI review:

  - Free the whole IOVA reservation on unmap. In a mixed range only the
    system pages are linked, so freeing just the linked part leaks the
    IOVA reserved for the device pages. Unlink the linked portion and
    free the whole reservation. On the get_pages() error path
    state_offset is 0, so skip the unlink, also avoiding the
    uninitialised dma_addr[0].dir read, allocate dma_addr with the
    zeroing kvzalloc_objs().
  - Do not route system pages to device_unmap() on the IOVA path. Branch
    off addr->proto so only real device pages reach device_unmap().
  - Publish dpagemap early to avoid leaking device mappings on the
    get_pages() error path. It was only stored on success, so a mid-way
    failure left svm_pages->dpagemap NULL and skipped device_unmap().
    Assign it when the first device page is mapped.

All three issues are preexisting and independent of the gpusvm MM/device
state split series; they were surfaced by the AI review of that series,
so this series addresses them separately.

V4:
  - Add reviewed-by for Matt's review.

V3:
  - Add fixes for all patches, add Cc stable.
  - Add reviewed by in patch 1.
  - Move AI review note into commit message instead of reported by.

V2:
  - patch 1: extend the uninitialized dma_addr[0].dir fix into freeing
    the whole IOVA reservation, fixing the IOVA leak for mixed ranges
    (the earlier version only guarded the direction argument).
  - add patch 3: publish dpagemap early to fix the device-mapping leak on
    the get_pages() error path.

Honglei Huang (3):
  drm/gpusvm: free the whole IOVA reservation on unmap
  drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap
  drm/gpusvm: publish dpagemap early to avoid device mapping leak on
    error

 drivers/gpu/drm/drm_gpusvm.c | 53 +++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 16 deletions(-)

-- 
2.34.1

