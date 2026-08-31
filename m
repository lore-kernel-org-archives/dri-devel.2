Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA01C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F67B10E637;
	Mon, 31 Aug 2026 18:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZ5AWEwR";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4875F10E637;
 Mon, 31 Aug 2026 18:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLVikBq/c6d3ggeg0KKK3T8/qTD0TxY8Id5ySO4tS591S2j3WZFnicydg+zvtIXFuXAMk4yiHCfA9ljXae/NZugqPMIKdQTHECfRp+8C2jxj/ijBgiqMBB4drdbtQ+M8w1EI68HMO8yQUBwhG3KwkVBQeYzMpCaQBAQHuK3qcGU6GwzjhpygiuWHe73X11RXod/VgPTKKNOdwBpwK0sFPa7VYpkfRo5oOgSHUe3nuOMd256H0g8VGZ8AhOp7ua2Qs6O2kYj0ApsmGes8aZatwt69N4rN8Yn6U7qIxq2mzaBqf5E5Zp2YrUjVNT2adX0LozERb6V/m03adLmu4jTRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf8ti99MPE6UjTpniv8xse7AWQYmiQkQwvcOmgB9Nag=;
 b=JHd54ZjXin67Es42KZAdUMJtXJ3JX6lGYw5EV36V84x1onSmjRL8S3f3PSHXpVyne8JzqIEmzYhPF3eFVPgfXjR0I2qD0lnj75hQajlB92yRvA7F/ZBmPm2L/CC2m7v52HJDPUkWYJ2uztiY9xJbywxbV1QhwKtweKQPJLc9kIouAc1xTushlh13p/UzE4mjR2iCXJe1D112C+4KXzJUEya40Eu17CpJM8xK2QWkb+p2noGujtZWkBjicw0zOTu4DCkaNYaTnW6VMnliEme0Vk4zzNLKzX/FITbX5nfxtFc+37CxTV0A/83k8jR6+9elAA+kK9rp4yjBrnfdkrr/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf8ti99MPE6UjTpniv8xse7AWQYmiQkQwvcOmgB9Nag=;
 b=sZ5AWEwRRnABrpKZs/iTP2jjIw79sSAxcNNLjuHYj+UdkdfTTgSBKgKR2nI3W4TlLzxUbGcxPYQNhVFVnFvA5LIBg82BVaBo5UWypyMTiT/7wOts5gVKGORnTYl17FekcHAwiQK0dyqiwAbgfe8oGXEXEGNlTqFMOhAdU1asRc8=
Received: from BN1PR14CA0021.namprd14.prod.outlook.com (2603:10b6:408:e3::26)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Mon, 31 Aug
 2026 18:33:21 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::7a) by BN1PR14CA0021.outlook.office365.com
 (2603:10b6:408:e3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:33:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:33:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:33:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:33:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 0/3] Add UALink infrastructure series 2
Date: Mon, 31 Aug 2026 14:33:08 -0400
Message-ID: <20260831183311.1090131-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc72cf6-a8e4-4bf2-b207-08df078e5534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|56012099006|5023799004|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +MNgNN/EAPmufqvQd+aFcSwkSYTr9BobWO7dOP1oFPsGQmprrkVWnVOkIQrsNVVXG8pIw0xQVr7jR6Hi/2Y9GiOgYa0CRXHFaQ0b9e16du4I31vMfW6aQ2SSA94yUUx6IKjndrciRTWj36Yi3KnC5pXjBQ3+QPW46SHOlzE58j77LM/t3GXbXlGI+S4FVNOiMhJf37Tc3mICOU2UNKrkDDRVSiX8d95CFUMLqbJM+i6z5GPmh7TlprYeZtw98A5p32D0VtOtYmA4F3rlgVdoF1LkkKB6/n8fXtupRB3jXB6e4qAoJhxpv6EwIdgfC1/3ztvVjCm8ZS8p2aXN5Dm1gq6qp//43IMAC7NLDgJ15jWG3Z0DKuGLFGnlxTw4g3/tN+xqBSiFvIy7ae7hrd3rltO/QvuErvYlodhgqyPoHLYCtoDWTSO7wqqBDG53qy1o0jm3PWF5bTZQ/6GXYlfNeR6tMNXEyPmDZM9czczU0u9yqPWAyaF9QxSno6SOOZs8Bs1tBwvam0iThjUQTvCOrI1DqdrdipjQhOewiKpzhRdiL944cY6DiHOOXBxJjg4kUODpSen4ALqXQKTLUclcSXnbohdOEOstf39xdSpCprKxMhgYj8RCB55o9Y52ZRPm2xytMDM1rwpJPrzKxp7baxz+Q2brOTsGEAjWgP4uTbk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(56012099006)(5023799004)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s1V3S4fYejc5H5pefNts9KF1YBh1n0UrTlNGVibv3HgJ84+RGCtuG557HxzzaQxdSNdTjfUM1R/L8irY44kaQel9GohB+idjm+kOAJWN0ZKRZ+mpFfbEl4k0ajg6NHCnbj4raPi+jTaCN3bIhXd3Q8In/cbQK06mI6i61CLst0zRnRLtGUUwSdKNkdseJ6E75GsrytQgsflr7G6BS4tuEU8tbnp+qvzG+E7dC+Up1VC6aSQyVirPRcePG+foS/n7wUv8yXeuPQuze+KRtVeTo/kSE0qyGFT4eZyma2Q7ujwTUYkN3OCltcAKeT9OMkBbz3eILRtMvhmn/kvn0jVofN9AwJ9hLwJUd81QW2KhrWxNmeE/zDk9CYbir20RJVom4x3FoXJEmFK+0hHw7a1KhrWtm3lsECY1d7Hdu78IqoxZpx3sZcQbjAD0iardEdMo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:33:20.5724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc72cf6-a8e4-4bf2-b207-08df078e5534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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
V2: https://lists.freedesktop.org/archives/amd-gfx/2026-August/151914.html
V1: https://lists.freedesktop.org/archives/amd-gfx/2026-August/151200.html

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

Exported memory is pinned.  This is similar to how dma-bufs in VRAM are pinned
for P2P access.  Remote TLB shootdowns from the exporter are used when the
exported memory is freed in order to remove access by remote GPUs

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

v2:
- Update the Documentation based on review feedback

Alex Deucher (1):
  Documentation: add initial UALink Documentation

Mukul Joshi (2):
  drm/gem: Add callback for when handle count goes to 0
  drm/amdgpu: Add ioctl infra for exporting/importing UALink handles

 Documentation/gpu/amdgpu/index.rst         |  1 +
 Documentation/gpu/amdgpu/ualink.rst        | 75 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 44 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  2 +
 drivers/gpu/drm/drm_gem.c                  |  5 +-
 include/drm/drm_gem.h                      | 11 ++++
 include/uapi/drm/amdgpu_drm.h              | 30 +++++++++
 9 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/gpu/amdgpu/ualink.rst

-- 
2.55.0

