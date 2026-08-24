Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3DCC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B2710E15F;
	Mon, 24 Aug 2026 17:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZZmqRsbP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E7710E15F;
 Mon, 24 Aug 2026 17:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p91rLRu6d6FaYRa/b30MN4iTPa95Kq+kJW6nRiz6iLVObzT/nF90EuF+J7u4E7KOouT1NRzZfi+sGJCAG/pI7dlfA671JKz/ErJNucSMgIzFRz7xu1m991yFfTreRx5NVnwrSFAs/F698aFyzOOUlQGGFkEBEVT5dmnCpf6Y2wrRiTbEPupfdDmZs6lkV0a/DfZ9QNBpu5Gv6YQDFzD2QOI2Jo1mKtlJaOYLw1oZ7GcNH80PtPSFXuBKnrPP/mWLBPt63qfNwv2BpOTBD7sG2UnjBf21TdR3i7JBkZ5RXDJVllxW5Te89AU3jivHZtCrl9SmmsYAWk+XwmGsHjaLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb3zLypAvIWzOf5qDemufjTpSyjWSAXVWQCFTkOmQ+Q=;
 b=WOuoUP3VM2bLMdAYbc+VBWrFnldivdqAbStVTiIHgdwQGpDT+77itgsNzHRMBj2wQ7fcG3G9SeL/mNNa11DmqcparQBl2wgQD6jUSWGbdEUzOz8Sq+3izd45wSx5+TXJAmeVjCokN8uA4v63WDGW+yrRK3KEEt85jEnPaeuWVOQsyQrQj2Iga0kofxXuFOov8Og6VHidozwztY4cnFTHm4okBb9obaovpFoTuqaUJfToeDuzl5G8dRkcYrHpZSWcGWL+ljoTkjdEFEsvqMORE1kDE8rbpojShma+/2ApiagFeUnZJKLcxPcXSR0NGMxHxHzdxAbCI6LwiRDSexPSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb3zLypAvIWzOf5qDemufjTpSyjWSAXVWQCFTkOmQ+Q=;
 b=ZZmqRsbPG5bjsUitx9mQGdarwoFUT6RP9KSczx51y89MXXdoFM08KVkfBuhLmppBXel9lpkEH0jybPfAQGFmyvYcY+RBiCBaKD41XVdU3mSZDadaT7B8OAy1sdzEEy+d9EHGhQQgLkuTv8S9sMpeBwvaZamX4UO6NFLsGlZpMTQ=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:02:22 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::5) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 17:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 17:02:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 12:02:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 12:02:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 0/3] Add UALink infrastructure series 2
Date: Mon, 24 Aug 2026 13:01:59 -0400
Message-ID: <20260824170202.1764463-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 145a511a-2581-4aea-560e-08df020174c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|5023799004|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: agoFxDG7NrdPyRnfx1jnTxZtWRZ9uXN92n5zW6JiKrq7VVqFiU3n+dFX6ore5sXq0UkaUTwqiJ70egm/GoMaLbdJlON6rpbCosrJQwA6nCaqD0KawuWvD4nvP6ReE+Uiprkf29+O2VB3GCLRYrJPl1bFtCs3PRh5Svj3C0c1Z/01b3ArrOb7tanI0VkBKywX325ZIWOZIPOpLzgqKeV6RDfj1PoMPrds9g2q6FTfXb/LsfJUp/3YBB1dHfuvdTYVcjLS0nA134jOzdryXStMoGOJUfhR5uFMF581AM+H/JrVtU/3Qrc4vv0JYypVivhS2IkfsREgqzONBQNVpVgUNx7W3UbgdiwA8nHBRetWdzEaeKr6GLC1Flblyoh/iKzqQD7+vEqp/9RI2fvs8Aefr+wHWOa6eNRYLbUCBeNiNve1Rdv8/7vu32fhRTKptk3EYOkrUCzAgNvsjNst6T1LfqHJ/xGuwoit1/vmf4l8cfRgB5QXM4C+6UHjJi9m5a2yh4IZG9uxDXGOM/wCB6Uz8TUqYnQDoZ5eoiV/3W+vHj/mIdrxHySGhChfL8wRQIVrt9RiOESpDEwWIEgILMStdVZExiX4sFDJU0g3ujGbxDKExox3zYuRudiAyOEabKnMHs7daJspx/Xk6G0bh4EsY0sT7FOn6I6zXSGEHRC2QCA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uIUYSMrRt3kjY6Shos0UPgRfEVH1s7deXpDK9/GjvQY4IFZ9BccTpXjh0P/nC5LAu2XZtmH0hpVw7a+SJ8J2EJ5W2OL5LmYmTMzjFUhfpkILvlQ0Yq5pR0c4QrBSX4pna0UOnCBQjI0IWtfk0HdUU9qyNMFBNKjLgIBJDBGbxmEXeDzrY/FbjtwHp8hze2+e20BvdqMH6Xcn6WJXblpAL0xoOJYVVY/u0k7jvmlqmRHWPnSPKXqHgbmU9M5Xydx6k7Wixie3nec8rxQvQk1mfIvidLXEJo36xVciVy3q+1xc9IhBdPtjkrbsL5nISPomWZrEWwLiMqcyQ6bMDiwLP+29QYjkx6N0FuBWuMecVFbHbNthtKf8jHC3a7nq13okaMww8fzqjX3Pn9lJlXNYY9zchlvwPGfH3KSj4HZVd5kFpL7P7ZoBMb6LIO1z8trP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:02:18.5876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145a511a-2581-4aea-560e-08df020174c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
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

Exported memory is pinned.  This is similar to how dma-bufs in VRAM are pinned
for P2P access.  Remote TLB shootdowns from the exporter are used when the
exported memory is freed in order to remove access by remote GPUs.

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

V2: Update the documentation per Felix' feedback.  Clarify that exported memory
is pinned.

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

