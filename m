Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF38C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002F410E7F7;
	Mon, 24 Aug 2026 17:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwo0dWa6";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB07D10E7EC;
 Mon, 24 Aug 2026 17:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wyq9wLpgC3lqLMnq+SmR41s9vNHdCmY7NoZg8uq3GgzuUfdM+mfq0EdGYDRe9aJm/Ws2IdqJuWL5poU/xA2kAK1aIOMzWFZ2+x9tgGkcC9la2+VbOap6/16Tt4htuFiuUtxPacApPvxfSsj/+D/lYOfpkt6fQi+vy+duTDzBClOiw1BrhSvtn+FzeKDSYXKuOUnh8RK729aIlRDhhBwr0+78Z7MdbEekGQD5be5POQcb7Yi8UElhnRGRAv9Tf3JMZmW9TsPKyiCb4HaGYOdYs5sWAPLDq0L8s7QTK92aPHj14QR3NY4RDgjjUFekbavAUA8EhwromWap+AohvliPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi7Kt82bx/xXjPQRZnlPpB4p3UPHdUQmeRDTLIQMhMI=;
 b=A2jZ04PWaCAPKfJRO8smx8oL2aiPBQkwbAhZ+qDXVrJ5RC+Otvd6qvFa7aSahhdVKlkF6EvysnP3QM/knpfWYLwb3Y+tC87qOWEUzSb51Q3aj4zyzTJfJyZhHUOSLAubf4dn5vMjDJReQ/cSSigYzOIoCOs5rZCT31paC1ATj3YqjjeUYW1dHZLtOUqXCxtVxxW7ygBA7KFynMWCTiLj7rOSr0roBa1wMxqeE/Kqhfxc3pnelrPIsSHiQIOuf812JbS86a724lYg3J92E8R14z/LtkjuOR3zu1aAQ116hggsDDzWFZq4QnfPDQl4CVUhq9otcx7I/Sei160k4NFnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi7Kt82bx/xXjPQRZnlPpB4p3UPHdUQmeRDTLIQMhMI=;
 b=lwo0dWa6/0DlE1qjWy+enP0+bR+FhGJ9xEAavR384fYbSYNvLqWjRG1rlS8WlNHhcdVq52L5CLAxpGIdf2kAiac7EZE2MTzTdKxnupHRB6Xr9slWgIHrCt1GcIjVzbVOkimbSy5bsKFR91QLCwtmW/wzqksOvr16OCTVNYW1xT8=
Received: from BY3PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:39a::18)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:02:28 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::50) by BY3PR03CA0013.outlook.office365.com
 (2603:10b6:a03:39a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 17:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 17:02:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 12:02:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 12:02:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, <Joseph.Greathouse@amd.com>
Subject: [PATCH 3/3] Documentation: add initial UALink Documentation
Date: Mon, 24 Aug 2026 13:02:02 -0400
Message-ID: <20260824170202.1764463-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824170202.1764463-1-alexander.deucher@amd.com>
References: <20260824170202.1764463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: e01eb2b4-c80b-4082-9685-08df02017aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cOuDDAG387RBiAUigS/MzuztX8p2YO4gCjD4Gpm8ZvuT/MVQ1OU/imEPUESNiLm1pP/t/ce9jVKYjXjTNLqWNx/a4bmBEipqYu5oZF/FyL30FrPQbTfi8cxKXjuwkusw9boLeCcmhZs7Uld1JTM1gz1xxrd5YppnWVtfe6Tv4n0qvjWZIL8zNYozaO8Gf+F8Rn5xvtP6noCe9EXurAoUYrDChlYIpzO+j8O4phU4Cd/fYE2O3OMadN/FikI95Fa+kZme1y1EhkRk8fEzKPc+JK+/oEaN/GTqimIsKQ1ripAX+LVpdobrbigWRP4Tr/aswPS0vNgJr5ozEHwmNgf4KbQxblztIf/0uS/jvnV85LcL3JRmgM4J7IY+yXlClXvT2MlP5/p0Kcs3xMZ81iGkDmqpMiU+NC8+XXUT+yjMR//4NNfgaE0nmOFFHVWfKJsgA4Jql5TZ2/dhU64cFPd2WMaGCy8g3ww+mSRrJ+INTXcHBFZcvw6OsN9j83ecKTV94I411QAPgezhlqS1d14tBWs0NF9LlfZMflgGRCK8PEM0BwqAJvuAXdwHTKbj5qxWX5fqyO44W7NYGtt94a+ks9eZCOZLPnadol5zlk4uz8sD1JpA5wtSbjXv4nh39DtrdM4se1REBXYI4bqeI167COWszZMzdXklp/2FJGZ37fRWc9+kbqYrikW3oypqewUj1vjO6t44rAcjCZGycFEFlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eXpMlwg/TTEipb2PWWFL0FHSRgEfW5ckdNLCoazfMAF4StxVN65wR8CDctrcNRunbUkL5psZ+rfT/uu5VSLG/mWB/unfCKmeyyEAGExclT0cVGLYnZEs4aVBxkwkIRt5Ar1MwwtmQtqVYr2HzevTUM+X+I130p7NVdfwtOkhSFmKmWRVj/9CqbgowCy/eL3TWqBrc05/2nm+zN2j0i+vWGFVVTeFtPDkrN1o9MTwNQfKaK/uIUXdF+KNo6f3PnfxT6Hapk6XaNQV20kj0U7lJ9QUYjsAd8Fgl07u5yKLdx7h6Rhd4Zs/Xr2yMB9zwS1UxqMXPfQ+yO1RRncTKiuaoZXO+2ASMEogz/noDYoIdyuUJbMDOhpYlCcy5M3+4JtuQg/Lrcb4kmTgsQr7aAzzD7Kcm17hRpiv2Hj7LX0r8g6T+EFvJm2EjAj1VWZSY3t/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:02:28.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01eb2b4-c80b-4082-9685-08df02017aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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

