Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02FEC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2FE10E96A;
	Mon, 31 Aug 2026 18:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jgkCeq7f";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A19110E96A;
 Mon, 31 Aug 2026 18:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr5oghqMXqBuq0YJAta9XH3sD57DFjIrzeewHY5+LDv80Uc3wOK2GBVmQ3C1l5xxZehIDOcLoUuCnpejodRSTbnKvjGZX7ajaZ8bkEt4K9PBTI7E1/e4BV+0Ue/TyGcAb2s3Ym1+tlGc5Hvh4FeWnLGl+kMczhjzxD90EoToIUWfjTCBR/179vWYgf8kyfXikmIaF8XE+hIpAEX1hhNMyBZ0HyyUdjQ02SvGm6sjnxD+oGl5N6CTnjEZMuJ8T8HavhIRp3tsLj1GVHzxP4mvYFHqxf/dH1hxXlIcwdPq/jo3GdEM8tKdBBsEtRN4QqoVJBvFx9S+fY7D+eM/iqSy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi7Kt82bx/xXjPQRZnlPpB4p3UPHdUQmeRDTLIQMhMI=;
 b=v+Bt0KsaISRQ0QxAS4N7sREzCAtiVaL7oUAheuHukFTwTf5XhqfV1fmkYSZVpBTNAJ2uypiZ6XckGc9ic28ryXVOFsGow48xuX3cm+4Rwo4pL2tiHTolKetVHyNl7QyotQQBwP99QSOrCUVlst7x5uqBt2ZaVne0VRsCqoXygzh7fjdXhB3O3TcNl5CXoJgpLhIX4IF3HQzjrNqkb7hbA4WP6JM3uCElGvEU5ZW6ckhXcaRnA4nfKMc2IFLNbxLR5BEtlkH8jArwPNlSZYRpRyzpaAQAeial6jnHzMp+U0lPrAdf9i18Zn2rrJqfvVlwWmxiHAbTrs2A84DHxTsAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi7Kt82bx/xXjPQRZnlPpB4p3UPHdUQmeRDTLIQMhMI=;
 b=jgkCeq7f1J/yc8+xHP5iTMW0dd93CbjdaZtUlUbcyVYeL+zyjyhyhMG6wpY6Z3h4ulr1GvRKY7slXqVpl8b9aRphCRAbKAbk5jEgzSQDdKaT757mwqL8d8rL8mOpjhB1F3g4gRJAZD1amhPQX7dvitx6LXrN0brZqk8sCDml2Ag=
Received: from BN9PR03CA0454.namprd03.prod.outlook.com (2603:10b6:408:139::9)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:33:28 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::a8) by BN9PR03CA0454.outlook.office365.com
 (2603:10b6:408:139::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:33:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:33:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:33:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:33:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, <Joseph.Greathouse@amd.com>
Subject: [PATCH 3/3] Documentation: add initial UALink Documentation
Date: Mon, 31 Aug 2026 14:33:11 -0400
Message-ID: <20260831183311.1090131-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831183311.1090131-1-alexander.deucher@amd.com>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0b7cc5-da35-4c0a-669a-08df078e598e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e8oNr4wD87ViQTjEhyczZCBLvsPUnEUkUa7CYnF4GAOMoqpzYjUGzPbWr7c3EJ7z1PsKWxp6PXmEeXVJ6KRrev8vXvpJIDTJxdPXHEYJFUvMHo86U9ABBiocWi3+FZzXO6PKxBwHmhYDRXLm17rH5py7oSIMRYR8algkPoTnw16aBe/F0gIeZdfXwXdvRDVKc/ks21jrrJuoyl42E8YkXwl4bra8flHxIS6mv17qY0H54v6fZPxArsC6Bd/Uhwi0qNdanoYtqJTm5VnKdeBwGQCuPZSkr+u9WyB+i9FxIGfHOIOX4UM6NmJlZNoHjePNHSCOADChOZAKuDThfphpne4Kb3OKWCSO8MNY3VZ6JmOULjTy2hU+/W6qnecm6uhgUtudtIXlYqISlOxlzgNWyHcSPRytaLVUq79rP0pSMpOGMWJylGH7QL/ytQhdKdlRKeneUcbTGwnRVUg4pBbK6KP5qu2/7Tf/R5j9QWkas6ovV8D3lJsPEk3CuA6qnwXEn+jZvNtObxJvUcU22SOwAjeCWC44HiTzSqPdnXoKUyFYVW1+wOlxFABlHLehtsiyBApr964uvZrGEzFoadJYkFIM1tHfN4bfRv5slUhb4ATjeNqws1mL1eQFgAxMtllwjDJnCZmqz/fqh1zjmWTJr9NopGmeFGvQ7skwAyDnqfXIpakpxixKcfcHqmtJRWl/Kz+mxx9vuv+FoqWM3DLbTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iZOWCFEvHgphV1y6o8ObvxQhRxjtVJUtNUnuaX7iw4pPTqJN842fZM4LKJf0TktrnP5KQPzLR6udksLr2QPhE2tucwUxoLganhWK2mrHzJdQKEyioNNnYTvrsTqIEu4U8u9TVkzXGjMvhvFRo9i1IfwNfuL2BsLYyK9dnfHDk1NB/a8SD+23P21e7jR4krvPC9NYH08mppZ19xWl1EER64lqzj3g+fWbbbVunvmsIxLjcS7gWdhesPdGc3Fidf5c/MvueiNm4gMaAiDvdn1isctL41x/24sz7276itn0JHpzXbKhIqSTH5ta7KVgy6s0PRpIqmsNKtiiNkt5j8Pf7uaKBFoCaTy/xx9EQu9EpyquwjOSVjzDOXCbwX9Lr+aGCnTaXJeBIqVoZ8P4Inuqk+EgNmZbxl8o5G3RgCVAPNPC2Cbq5wvp+mdoV3grTEch
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:33:27.8733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0b7cc5-da35-4c0a-669a-08df078e598e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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

v2: add updates from Felix

Cc: Felix.Kuehling@amd.com
Cc: Joseph.Greathouse@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/index.rst  |  1 +
 Documentation/gpu/amdgpu/ualink.rst | 75 +++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
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
index 0000000000000..e15c8621e5a1a
--- /dev/null
+++ b/Documentation/gpu/amdgpu/ualink.rst
@@ -0,0 +1,75 @@
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
+Exported memory is pinned.  This is similar to how dma-bufs in VRAM are pinned
+for P2P access.  Remote TLB shootdowns from the exporter are used when the
+exported memory is freed in order to remove access by remote GPUs.
+
+To access remote memory, the driver can map NPA addresses into its per process
+GPUVM page tables just like local memory.  Applications use opaque handles to
+represent remote memory.  GPUs in a pod communicate with eachother directly to
+exchange NPA addresses between importers and exporters.  If a node goes offline
+or is reset, their peers will clean up any remaining refrences that are lost
+when that happens.  NPA addresses are exchanged directly between the kernel
+drivers using the scale up fabric.  NPA addresses are never exposed to user
+space.
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
+The UALink handle is destroyed when the GEM object reference count reaches 0.
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

