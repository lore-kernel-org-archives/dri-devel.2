Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90179C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D813210F476;
	Fri, 21 Aug 2026 19:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nziqgDlt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686C310F46F;
 Fri, 21 Aug 2026 19:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl3IcRQp6lpD3h4boEpyzeI+dTZBWaOhwOM5yyPy/Ted5H+j2Uosyap7rrG0VyyItgNHvQVmgRBog7+VCP7qr110lQsSDw3H8t5hncy/+6hwPXHX2roMbiElXpVyFP/40BBFDVeaVEmBbUkP1dIYkptAdAezLwh5WFsmBDX4ozRO6G6R+smwF9uAEgHM62+uRXa7Yimy/GoWTHpT2Wy+woGvIVmoa+FmHEae+bemHZhocyuwKhkoFqMebAsnkdFPlf+OCitwrRDQ2pBtbXLMmNtQR6vQDmZ5nq/aycnUZoiXO/KooJthKRbjO++J69D/IM7ZSaz4w1CW12f1VHY+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS84qDd87QKvcgNgsxmYGsqUvDX5Vx96aVvIkkF9nVE=;
 b=hw2tyqd6h1naYoT409aa2/3hEAHt3Z+hL0bwO2XGVcsRiKZMduma7s22YUd+2DTVFKrvQF6HjL5wA2AaCcoWSzCRlEyBnvaydI8sqGgxUZkIN9tNPiqvsz/ACNVNUBOD6T0ZLKmpiI+3NtO6r1q2LUJudhEvgCE89MBWbKqI+lAxpynFhvFy+kv1+K+nPkZdn40/vlkIEUQNr6iQUKQ28xY3YsiMQDVn8RFrsmfXuB0O2ODpUpib9MD0k5o9+9u5okvTaLonDcLrnHjPCimwtvCZTiCdtRI72kNS2Smrg9la8HAAChnMrkuT9NKr1pYrQRsky+uYljFL737UgsBXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS84qDd87QKvcgNgsxmYGsqUvDX5Vx96aVvIkkF9nVE=;
 b=nziqgDltmuCE/aIAUv0vT52Aa9VX6vHTJpr0HQR3xjlzhSXxVL6i/2We/WIyAg3GhYYjgBOOeHU3BF3K/Qrhg3Yi5QmxKEd+g0Io7dAuVvXnKjcp4qb+6i41Lq8PRRypLPuXNihOej2XKfZhrhb3y+snvzJ5/2BeOtFPgmMYWAY=
Received: from DS7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::6) by
 DSSPR12MB999238.namprd12.prod.outlook.com (2603:10b6:8:374::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 19:52:41 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::69) by DS7P220CA0001.outlook.office365.com
 (2603:10b6:8:1ca::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:52:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:52:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, <Joseph.Greathouse@amd.com>
Subject: [PATCH 3/3] Documentation: add initial UALink Documentation
Date: Fri, 21 Aug 2026 15:52:24 -0400
Message-ID: <20260821195224.809173-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821195224.809173-1-alexander.deucher@amd.com>
References: <20260821195224.809173-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DSSPR12MB999238:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0581a8-5eec-4a30-448e-08deffbdc2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|11063799006|10067099003|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: N28UnW83Rr90onhBnDV10ktxhk5vUPm0+x6J6rSOBHwvoHevyH9rl6QuPcqKSkA7TzvdpBiOu24lk1hSTeaKlazzGDagzJBRVRrT0SZ2epBiK5VYdgvOtiNhtE7rsYxoqlJlIHeAN/e4I3pnt/Pj1o5Xw1/YpMNt1x8t2oAFUKbUvG8kSw+UgEhQuVKt4S6WprY8FhmQGsVdrxFMPKm6hCfmMvy3UqllVyTOU4/mmN7V8jbXC13kC/DbTgmm8KWfw93qqB3BvGTYna8Eizjesq/gZad4AUBKuHyJ4uih7WA6gA4C+UTZ+kb3f8hiOjpwx5tHXpyzRuJLpesv80tGgAxVPaW5AH57A+Ums5x/N/Jv0ayM7NGC5IQrlxuIStOcZ/C1U1Q0RYK//x1FCWHeEv94WWj99AhSgN++Wa7pRCcTOlBfOxUCZV3IyOXwckEocJ43X1SN3jTE7Jigv0gEgqEszfN7mTFH3m/RmhBDh5YAyrgmf1w+s2p58S820tPkkeZ6B+8jZsSnnqrnxkYr7dEYm8AuiuM8XA4oD94AcWr5RIfi7pEbUZwom5slIXnnS4ep97qqd4d/bgxUsspWnyowEmWPq+l8wnbxuSnI5KMKUYfcCjmIKJ+59owXaYExyD/wQHUSGwIvbaOQpIAnOtaraBe7lFMTyRBSHNANBap8amB0fifkV9V8KxfD4mWnE87Fd/mMDTc3U73oACmrlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6HntL0ud+YEn522k5ms+cgEiAhfv5OSYgE5qH94A8RH29+nVXJ8lAcjukousyF8UqQkuVDFcUPZmgW43+orn5MRIq+5ehn/TENFTQF5RSAyRoog6/bO7oEr0RYEoEAUFW67jeCkPWi0/EwoUdwgEj+sfeIXo4zc0krV8NS6UFu58vZ/Vm+aZGwTLbzexwDiDfFY8kDIiePf/sI4BNeba/sKbFjIxlA1mqandD4HGcoDDDh0ZmG3zSjXcc3aTefvGa4vfzYuHuyXl9BCjLhr0yuyoXD41jpT4kh0zXsWTXEkI/NQ0n43vSGZznHYPHZxvqimXSs1SRe+bK7X2WI2xPU0mmH6y1oVEQUf+3IPH1chx4rSlm5DGJMs0h3VkL/JULkgpO6yJ8tGYi45OiqE+eaj6fa/f/o209cQqI9Pk84eG6vdrHfXClwdTnIAJlr69
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:52:41.2211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0581a8-5eec-4a30-448e-08deffbdc2ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999238
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

Document the details of UALink on the GPU.

Cc: Felix.Kuehling@amd.com
Cc: Joseph.Greathouse@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/index.rst  |  1 +
 Documentation/gpu/amdgpu/ualink.rst | 74 +++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/ualink.rst

diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index b2ab182236efb..ba2ee73278672 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -23,4 +23,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    debugfs
    process-isolation
    amdgpu-glossary
+   ualink
    ptl
diff --git a/Documentation/gpu/amdgpu/ualink.rst b/Documentation/gpu/amdgpu/ualink.rst
new file mode 100644
index 0000000000000..1e0a6c52b7b7a
--- /dev/null
+++ b/Documentation/gpu/amdgpu/ualink.rst
@@ -0,0 +1,74 @@
+==============
+UALink Support
+==============
+
+Overview
+========
+
+Connected GPUs in a pod can directly access the remove memory on another GPU
+over UALink.  Unlike RMDA, there is no copy involved; it is direct loads/stores
+over the fabric.  Shared memory can only be accessed by a remote GPU if the
+memory was exported and the importer has been authorized. For the memory to be
+shared, it must be part of a unified physical address space shared between
+nodes.  This address space is called NPA (Nework Physical Address) space.  This
+address space is partitioned between the GPUs so that each GPU has its own
+segment of the address space in which to export its memory.  Each GPU maintains
+a dedicated set of page tables for their NPA space similar to GPUVM.  Note that
+this mechanism only allows for GPU access to remote memory.  The remote memory
+is not CPU accessible.
+
+Exported memory is not pinned.  The exporter may need to move memory or make it
+unavailable to the importers.  This is handled via remote TLB shootdowns on the
+exporter in the case of TTM evictions or MMU notifiers and remote presense
+checks with retry on the importer.
+
+To access remote memory, the driver can map NPA addresses into its per process
+GPUVM page tables just like local memory.  Applications use opaque handles to
+represent remote memory.  GPUs in a pod communicate with eachother directly to
+exchange NPA addresses between importers and exporters.  If a node goes offline
+or is reset, their peers will clean up any remaining refrences that are lost
+when that happens.
+
+On the importer, the NPA space is like another physical address space. NPA
+addresses can be used as physical addresses for GPUVM to provide GPU virtual
+addresses to the memory for processes using the GPU.
+
+On the exporter, the NPA space provides a way to expose discontiguous local
+memory as a contiguous address range for remote GPUs.  This allows the exporter
+to locally manage the pages mapped into the NPA space.
+
+Remote NPAs are managed like another device specific TTM pool similar to
+doorbells or VRAM, however they cannot be CPU mapped.
+
+
+User Interface
+==============
+Two IOCTLs are provided to export and import remote memory.
+
+Export Memory
+-------------
+To export memory, a UALINK handle must be created for an allocation that can be
+shared with another node in the pod.  To do this the exporter calls the GEM
+UALink IOCTL with the GEM handle to the buffer it wants to export.  The IOCTL
+returns a unique 128 bit handle which can be shared with the remote host.
+Calling export on the same GEM handle always returns the same UALink handle.
+The UALink handle is destroyed when the GEM object is freed.
+
+Import Memory
+-------------
+To import remote memory, the UALink handle from the remote node must be
+converted from a UALink handle to a local GEM object which represents the local
+reference to the NPA space on the importer.  If the memory has already been
+imported, it just returns a new reference to the existing GEM object.  If not,
+the importer queries the exporter to get the NPA address.  Once it has that, the
+importer can create the GEM to represent the NPA space used by the allocation.
+The GEM object is then exported to the caller as a dma-buf. The dma-buf is
+leveraged for dynamic attachment which provides the ability to revoke access
+when necessary.
+
+
+Device to Device Communications
+===============================
+
+Devices communicate via a protocol implemented in firmware.  Mesages sent to a
+remote node generate an interrupt on that node for servicing.
-- 
2.55.0

