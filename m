Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DD7C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CE410F46B;
	Fri, 21 Aug 2026 19:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EQjnnNHN";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B9510F46B;
 Fri, 21 Aug 2026 19:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvVqecV2Jxf8UZry/urVzI02DqtSIdApFWuABYWCQ0K8/cqk5uEW8FFh115NRF76Cjru//vD44r4S8Jzev2sesabdhMbZsEQWKdYQTwG6JpWj+N3Qq9T4duyKpP2uun79fVsEn7vhbJ7VKeg7qEBvo9ykhH7IMAAfvpENKuUTU1uEIirrhvN05C/gjd72VhY4uwXkDUaMFdMWkSNGip2v1s9fLpXTqbjm3UfeQGt34EIbNVpA9uzN9T6SV/rK2ecvwZh3zkfW9NvbpBkR/5ZAemrrZXbNiIcB1UBGU01XH+d65rlJmRnv9qadpkemZbi6GzANUzCw6LDaLmZr4Sghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+U+8IFNr/HHM7RNmaDji/IvqkVi3hvuvTksAftFCyw=;
 b=giIWBWpm9MNRljevtIPn/p9sMUW8VVOO/X/51JyTJDXpNArJJvD2S7gf7XMP2npMZYp73obrFftQ1IGtp8nmUEQwNUMIGJyfxEUrgdMmpxixAAUlufwIv6Keg5ryKdnY3dyIPwi7Rn/cLU8MmB1YtwICqeqNQt0yDDxFT6B3dZh1nHVXKOAoq9OqNYfK/GKH+iJZUJjzJ0OYHcDXgjkX+mEr302wEupJN/F58MPoSQCzMsUmef711bXp1VVp9hmbJmZzlLmUNyVzVyretMCBYJWV/UuKAZhkEGgkPA+XhVh7dMvcAJVI2gTofzz0Uo+01Ai89U1lioqPBxOz0j3hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+U+8IFNr/HHM7RNmaDji/IvqkVi3hvuvTksAftFCyw=;
 b=EQjnnNHNnGD2WenA7I6hoI/JgLiHKyWJCNkwLrrJTI06v178DGOFLI9hK/eE5pZAvNMCEGSLK/bwrO2Id5VjRd1bXqHbTGqHRewD0VOSCPBhTtrXue4TcRRC9Qz5Ipo/EtoBY1N9IVu6H8DHicu+8CvyW/2lM3PdqQxaBUcRgH4=
Received: from CY5PR15CA0079.namprd15.prod.outlook.com (2603:10b6:930:18::15)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:52:34 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::9b) by CY5PR15CA0079.outlook.office365.com
 (2603:10b6:930:18::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:52:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:52:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] Add UALink infrastructure series 2
Date: Fri, 21 Aug 2026 15:52:21 -0400
Message-ID: <20260821195224.809173-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 270869b2-c159-4a53-bb82-08deffbdbe6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|6133799003|13003099007|18002099003|56012099006|5023799004|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 8yMKntC4g5i8FKsEjbrv/VzddyDn0cUEPHqeTEO2Jy+0Edc4V2NZl0mnYQHa6bSelMBpou1QMGzIs1TkQGy91gUbyMw+k9PzNpdDb3TrpAiRcBxoNkjAZYSRYU0KrRIPtkh2NNh/FM6eKLYwmStD9iPMN14Y3wcY7UReB3dd2DYUFEVwZXW7KKfUoyReGL7g1s9ypEynTGaXUZvZZp6JnbcfiGzKI2rILoYjGJKQZPZYBZwKXi8xfA4394Q+PfGe8XQsqiCgVzu80VMBAmaaUeV6C7NecpNkMOEBToaSOnfPKCm2v0gYalvzrH6BVfwVVfVn0t99A+0HfU716U6+FUlc881TNIBuwst1NVZ9IXX5HL+xPBCJZBYQHdu4UvxmZfW3Ipri5NJgRS8fQnxqT2ihkxC3nQdx0xMPpqVO/sZB380tAfAp/5SDDcUxRwBar/Pdb+7SN82LBf6V+eA96zVIXNf+qRpaPxgnZZntx43f0Ycd/HiXSRgpmBcZXi7wY2/lmfCpinrKJktV+g4z1jMVR9FAVAYopZXJ2kERP3fNCLF1go2LKm/ntIIXy/iaqepTKvu5L0O+igoUme/yZ7eaFhG2Y8iOcMK2+lLDTaBKpMG3phvOjdJZnYRK09TN2Mkynbzl/Rqgl4r75Q4OZEjPPap5id1xeVKYxVJjMbg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(13003099007)(18002099003)(56012099006)(5023799004)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OppGPn4VsI7323o7iQF4Cax8mLw65BOtQHU3ipB2pHeEvtZsA2yEiHtiDe8DIVufYpMhzSAC2YF+kCX4eJMZit26c85Z+y6dgEFCRyTRaPiAEsTDIW6xllcj9ncus2TRXdVB0FKmmkS11RY3dacehsrN52fdHWl8faY6YOR3Y3whLEDzfevyjeSWh4ixU5PFF4/ZPpOOnRybQgs0LarU41tjOM/vt1ebGPvJXdqkUAOApYxRwn9G68vBtbvdVt+3N8jyycXeE6lNSeeM++LAr+/eMYl5OTkFXQfUZqAQA1w8NuowduQGTffJSgY/sVKsk12SQh5uuSDV0Qjj5gPfBzXlDOrtLp91fWWdcgUfbm2rAEofepLWlrtV8JGCervs8vxesxYlAvKxJOe8WsARZKg85eJd6nzFSiprgCzMErZShRIKjN2PVNWJNd0D8ywG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:52:34.1090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 270869b2-c159-4a53-bb82-08deffbdbe6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

This adds the core infrastructure for supporting UALink (Ultra Accelerator Link)
connected scale up pods. I've split this into two series, one to add the core
infrastructure, and one to expose the new IOCTL interface and add the
documentation to avoid spamming the larger audience with the implemenation
defails.  This is the second series.

The first series can be found here:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/151200.html

Both series can be accessed via this git branch:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ualink?ref_type=heads

This implements UALoE (UALink over Ethernet). An overview of the complete
solution can be found here:
https://www.amd.com/en/products/rackscale-solutions/helios.html

Overview

Connected GPUs in a pod can directly access the remove memory on another
GPU over UALink.  Unlike RMDA, there is no copy involved; it is direct
loads/stores over the fabric.  Shared memory can only be accessed by
a remote GPU if the memory was exported and the importer has been authorized.
For the memory to be shared, it must be part of a unified physical
address space shared between nodes.  This address space is called NPA (Nework
Physical Address) space.  This address space is partitioned between
the GPUs so that each GPU has it's own segment of the address space in which
to export its memory.  Each GPU maintains a dedicated set of page tables
for their NPA space similar to GPUVM.

Exported memory is not pinned.  The exporter may need to move memory
or make it unavailable to the importers.  This is handled via remote
TLB shootdowns on the exporter in the case of TTM evictions or MMU notifiers and
remote presense checks with retry on the importer.

To access remote memory, the driver can map NPA addresses into its per
process GPUVM page tables just like local memory.  Applications use
opaque handles to represent remote memory.  GPUs in a pod communicate
with eachother directly to exchange NPA addresses between importers
and exporters.  If a node goes offline or is reset, their peers will
clean up any remaining refrences that are lost when that happens.

User interface

Export Memory

To export memory, a handle must be created for an allocation
that can be shared with another node in the pod.  To do this
the exporter calls the GEM UALink IOCTL with the GEM handle
to the buffer it wants to export.  The IOCTL returns a
unique handle which can be shared with the remote host.

Import Memory

To import the memory, the handle from the remote node must be converted
from a unique handle to a local GEM object which represents the local reference
to the NPA space on the importer.  If the memory has already been
imported, it just returns a new reference to the existing object.  If not,
the importer queries the exporter to get the NPA address.  Once it has that
the importer can create a dma-buf to represent the NPA space used by the
allocation and that is returned to the application.

Proposed Userspace
https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L971
https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L1036

Alex Deucher (1):
  Documentation: add initial UALink Documentation

Mukul Joshi (2):
  drm/gem: Add callback for when handle count goes to 0
  drm/amdgpu: Add ioctl infra for exporting/importing UALink handles

 Documentation/gpu/amdgpu/index.rst         |  1 +
 Documentation/gpu/amdgpu/ualink.rst        | 74 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 44 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  2 +
 drivers/gpu/drm/drm_gem.c                  |  5 +-
 include/drm/drm_gem.h                      | 11 ++++
 include/uapi/drm/amdgpu_drm.h              | 30 +++++++++
 9 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/gpu/amdgpu/ualink.rst

-- 
2.55.0

