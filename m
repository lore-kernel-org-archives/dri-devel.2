Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9928DC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC7A10EB21;
	Tue, 30 Jun 2026 07:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hf5H6phk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF99C10EAE9;
 Tue, 30 Jun 2026 07:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM7Aj5D3CAxzslfyAeCllrXFDTtSkQ8Ei1hyuMSEiWPLvoO0TZYuywP7cDORRMsbe8kjOUqFFFRGbET6pBDwaoPQmvKE7dCgri+oIlBVfXfzT8Na5L/iqoOWQ5q2OrwhpMAYJV6XBXR4nD6MtpcDjExs7FnUc680KY/65G1u/H+Oz3maMDkuSv+nfMKHRjCyee34H0T16DhUdcekpKYIPoqhD9UR1ItlPetCHBKhDFuy6WYHdsYYIenPX/Nb4UamfNttXVdAjGMuNQLG+rd6NBWKVPckgWygFvZfd1GkE2D+x1+cJX8VHsfHWgUNao4Q6sIxTy6IjZvyMtzGu8K0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPbbiwe14RV4t7jb9nxNZZMzzUzufiWU5jYzZrFpbdc=;
 b=o+CfYy2wdQ0XWYmAM7dLiv7ekjoUwNjl71rqU1T1wSBGKHCnpEk+iiSNTMbx9Q6h343qJ3PEjLvXafBNWqZTuDwpVyUvsFxtyEFfKqByhLNSPlS2E8b1i1HR0K7s8dk9PSJXLs33Kiu+ldrIG/hwBgHuAlZwDs1fwG+Ie2YSpw/yFN6thKc4OZeN1qasHCNRXIG+jrrfXcSO7hFMKuBGP8GFY1xbFiI8ujkO3ACPgdcrLmfFyBhRg2GrUAyjFQc5C6seEvstNZbGEUfi9dUFDfH5uy7zxjqnEbBLTgpnzCaKUR25xSXuLBO1Le31Czl1wVf72xMtPleySsP3AEAnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPbbiwe14RV4t7jb9nxNZZMzzUzufiWU5jYzZrFpbdc=;
 b=Hf5H6phkrDYXCASl3t+ALlmmeSALYjq8jNNbUPq5ksWl1aVESoKz0Ho0rajaaBfevEs78FDumswGiAjxpSJRB3xk6BJxS1cGGlEK5kHPEvVT/czoe6F7OzLZ5s8j/C9+X1HHzRYLVJJuYpXYN1f8HEaaY1/i/Hz3ux0rZRGhtEk=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:09:16 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::74) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 07:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 07:09:16 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 02:09:14 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v3 0/3] drm/gpusvm: fix IOVA/DMA unmap leaks in
 __drm_gpusvm_unmap_pages()
Date: Tue, 30 Jun 2026 15:08:56 +0800
Message-ID: <20260630070859.372954-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 98802c41-7cb2-4a0a-97f7-08ded6767f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 0SrJ7WWzQnOnBJkcgLioA4tyJ5OgQWhB9oBOLuYgQzXuzHi5hpXojX1LIHzrttSLF6TXfCgltfEt58TJAuABl4664XuE03f6sywvFqTOt59Rm/Xx1u8GpbDdAyqx9ufstJc/T6h7AQ4JGWqdLECfL4TdulF1gt1Wlrm0OdgXbUrWlGZ88gazKc7pHtXC4nt7wRdOF4ofBqgopoJ/SCmvkkluOTjoPZj60ymvSsfwu3hxcq5Yv4bP6Ebe1FPT8TkXgN874LTT3fV31nHMz51FS+yOWbN8ujeZdoW/uMZR34Y1HVXtjrslkgWmSHHTa0JjvpWulBN9vwAqT2LncXoX6UXz6cuHadblNQiEZlFm/8bS4QsPN5lE7X7bgfoDzF7+FTqp2O+rP4SJzPgV0HHwc95Xtfk0iwwN0ZOw9iAjL8c4ZCi11Ri/57dZ3vsrlmO5tEImCllmiAVU3aB8CvAa/w/YaxdDJ5qO0nBQ8O519ITpCptbK9K+ryeNbKuGjx6WVaETo6dhejftGmT4zsXamPZBc62cw5sqZ1qfy7X1yHBUgNGvsae6cON59CBY+ANwc5Xw+uyH5nvNP2znQJKuWJHIjRmvaGW6LjaAJDrCRXwRr2t9NesEg1oQtnK1I8ZNtSZo3VBcYQ2TSuV7ZQ4AVjg1hm8T+bR+gi+7XaIzshNY0TYmVvK0/GEIUO428ig1YGYEvyLJvNxhiIV6ieWQWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 16Donrf4LhCWfvjtYu6jkj/q5eV+NZ2QfPMXteEJo9xGifnKUIuoPBmPx/HgeRHPB0JjWIf+yFkeITdUBMCaAxeEPUd4Sf7OgkZIjVNdaTOebuBX79xTBWRYrGdMshDabQEIWbhp79b4CyviBNxd8H8YR94Z6xwhOFVRMh0a3mtAu78lzVgOAImAqrZNL+23rpQ2U+qb3wR/IS0eNQbw7gAXJI7fPOVXTAmjA2TG+Tw0eG12+zqsVDH0y+YhLUQqHDlPXoXfDLloKv9aaEUFHXr0z8vJ4aBpomkCePuiTWtiP15C38uYhIXGOVx1guT3hjaLd5+PBOLcWuR+5iBI90kBpzrv29HIzxRGpEanpIcMHxOcxyYo13Pl19krYUCGNgzf/i5j17P4j59G8dVpeR+2LLbaFI/8t8SCRG6tDNXNoxy+lsuGTIPbZflx/0d2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:09:16.4423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98802c41-7cb2-4a0a-97f7-08ded6767f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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

