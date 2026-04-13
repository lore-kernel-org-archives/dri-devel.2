Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F79DEBFD30
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821C210E3F9;
	Mon, 13 Apr 2026 10:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aOuwDKJ9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E9210E3F9;
 Mon, 13 Apr 2026 10:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWNbA/uLSAx/R7AdsZu/bROqhsusAuBaUV9kARmFPx04n48T8NoA/0DoGG3rGik/lAwp4J/R7HQHVzJd1QnJNa7bwKh6QUfceKNSANW3ECJYRZtQADl8TIYEuJ90qYIOt6DbqwSIV1kvc5PgivsSbft/pAZ3tfOgI3WpNsLQJMfkSeQbWhKFuOETqUIUAVtHXTEiYWWywjYt6BYzDAtGfKI0AwzqpMfSEqrMF7e9lLqpWsplZSAbGu6g6Ox2iPM1bc8m2xz/oH+KuwGe3H9NvENzcifH7GjdtdQdeP9a0hlnI0I0vhFP2sy2ssjv29NS8AXTTPUlk4fHhg8Zx/KZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wAwSphObC0y1huMcgrIyBNJteksnGeD7l08U0MfgNs=;
 b=zJvI7Ja5upOcGHeBGgt8ku2js2og6RX6Z2etzxWqr0IDPKyNQeoIOGhy/x9A9VAAo0Y/9bZ9QLo6PlrmM08BqV30HzIHplFAtQCFluTwUPlfOPyFJvU96r0ac6lMN3cr5XNhkLx6EZQUR36J2dhMg2vue1NRQnGFvWMZy/5BdGY7xZalyOlcO0EOLi3+U9SuBazW8vmTs0hE0skYPSyyrJdX6xAvrFuRHBCDxrOhI/8zawZiaY7dQtl6pdFJQPKZ3IuZdagl26zBLZdL/vj7daZ9xxs3tccf3IcixqU29EZCOaatxvwH/Zi+zi4a0rKDjhCCVRZbsjBdQjFfj6f9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wAwSphObC0y1huMcgrIyBNJteksnGeD7l08U0MfgNs=;
 b=aOuwDKJ9s2c03gZJq6bsKBgtR2o4hOMSA6XyTQDrOl+R9DMYA+HZnaAQyJEFHXoIKiW3/5ymabr+McYuTEUxsyEEYAOF25cpNxiClW7oOcuQ92qnrdT7Yp3687cKHONx1GdbGA6CufEsDK0ZQNLme45gUJXhvcoujlvZWv43A8E=
Received: from BYAPR06CA0022.namprd06.prod.outlook.com (2603:10b6:a03:d4::35)
 by IA0PPFC855560D7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Mon, 13 Apr
 2026 10:30:37 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::2c) by BYAPR06CA0022.outlook.office365.com
 (2603:10b6:a03:d4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:30:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:30:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 03:30:35 -0700
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 05:30:32 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v2 0/5] drm/amdgpu: SVM VRAM migration via drm_pagemap
Date: Mon, 13 Apr 2026 18:30:26 +0800
Message-ID: <20260413103031.181953-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec30155-9d2c-4d03-7074-08de9947b368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lE4Zm5EBCnz5unVXCR9jCk7Vf09Q5sdJNt3hKs4HBPK0LHNTTj6LIfPnr7+5l6ni3m+FXbc1Qrs+TvsaOg/aWKM6da+cytdxVHAaQpbBT26u+U1WHAEgkfxB1CtcbpsBCDIEtb0VFli5U1enHaiRU2mOwv19f00VXTkJQF6yD0L4Y0gAC4O3shOGPRqyHruEghVn3Sl8YaOKHrmuzZZkkAECrMnq5Xs1G3Vwd2nSwIgKRxjZEm11P300tXGb8d8cqFEyVrPXb11403y97M1ex52ZQd5RJSHcdHtTJB1dzJuZSJQ986JgUh0vBrjaaMJe8JGfHBdt24PwQp4wurQ9hNikiZWSOddt5Yo063BBSPlbNhi3yMjR9mgXExH6L01MSzMhg4EssHtVCKZFzlueUcWiIeg7H9tfErCmECVYtEKwmx+SV8Z/+monC9U04yeih8aAJPbtfuDWMI8KMtvd6wIHSH+ib0VgZQIUWe35ZrvC3xx1bKIYw6HZmfNh2yrJjwAN85xsZz0EEaHkLTcK4u4Ce0+F9p98w6rSTROnsKBUa8/aDNIkzBEyOVFSFJ6yB1BU3NXD+Q/9T6dZrDgD9vCV3yggVjJWuQJDmbi4AJMPa7/V0KvmX54x/+JBPCLovf11tBS2Dt8NGQY5p7aPzVdPDWLMVTw/R6WIsglk+eHrE2XivXc6gCpuBpJ0uxvdr/UPa3GrI54UoE2FkSe72PR9W8cKvwLXADLI+5xwzxlFRlvKox6a4dQupz4eq2RH1kjJrlwImuEiR8alv0AKD8ZfwnpSsAgOvjkb7WyzxQhYLlhadlpt5ovTTd63M0aqr6oib37B3DPyXav2VB7pwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(921020)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E+/cNUgupgZOTZmeEOFbj00SLFQW/uMfqIRR1aaRfN96QUF39b9TXq+SzD5sEpUZ7HVXiB4gXxAWg1hJ0H+59JP3YaU7L4/atgR/YBSzSEB0OFuyzg0hLM7lHLdP5P2IJ+kEUFVxR9Gbl69IQ4WMjnqBM9WxvesTeK82UV0K/AIEAqipQZXV8GIiQjIekCO0E12d/XZ2HX9MiP4uHxR47xrsJP6NF4a9oojZUkjoKSYgYFBDr12ziBi7NTxHizxfP7ioih5SmYAGYkAI3asexfFHXai7fwEHdDaXLLunXkMaLtCUqlLSwBVXKqY3t6bESdxndzTWH1eD9eYvnYX2UuM+BG6eFydQ8IMUoCaWOXJUVsYeMbXY8WFWzbpgTIKpTTPSgsN+YkkxlZsQwyq7QidlvqEyb+rxKS+y4Lo/dHu3KhvDvFCrCBzem2PTlm0U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:30:36.3787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec30155-9d2c-4d03-7074-08de9947b368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
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

This series adds VRAM migration support to the amdgpu DRM SVM
subsystem, building on top of the POC SVM core series [1]. It uses
the drm_pagemap infrastructure for ZONE_DEVICE based page migration
between system RAM and GPU VRAM.

This is NOT a production-ready submission — it is a POC/RFC to
validate the drm_pagemap migration path and start discussion on
the design.

Changes since v1

  - Dropped the "eviction fence" patch (was 4/6 in v1) after
    Christian König pointed out it violates the dma_fence contract.
    The eviction problem will be addressed separately in a future
    series.

  - Refactored "integrate VRAM migration into SVM range map path"
    (now 5/5, was 6/6):
    * Extracted migration logic into new files
      amdgpu_svm_range_migrate.{c,h}
    * Introduced enum amdgpu_svm_migrate_mode (PREFERRED, TO_VRAM,
      TO_SYSMEM, NONE) to make migration intent explicit throughout
      the map call chain, replacing the _ex functions used in v1.

Limitations

  - Single GPU only; multi-GPU migration is not addressed
  - No XNACK-on GPU fault-driven migration
  - VRAM overcommit / eviction under memory pressure is not yet
    handled (will be addressed in a follow-up series)

Design

GPU VRAM is registered as a ZONE_DEVICE region via
devm_memremap_pages(). A new struct amdgpu_pagemap wraps
dev_pagemap with drm_pagemap state. The drm_pagemap_ops and
drm_pagemap_devmem_ops callbacks implement SDMA-based data transfer
through a GART aperture window.

Migration policy is driven by SVM range attributes (preferred
location, prefetch hints) and integrated into the existing SVM
range map path.

Testing

  - Hardware: gfx1100 (W7900) and gfx943 (MI300X)
  - KFD test: same failures as official release, except VRAM
    overcommit due to lack of eviction mechanism.

Dependencies

This series applies on top of the amdgpu DRM SVM core series [1]
which provides range management, GPU mapping, and attribute
infrastructure.

[1] https://lore.kernel.org/amd-gfx/20260317112958.2925370-1-honglei1.huang@amd.com/

v1: https://lore.kernel.org/amd-gfx/20260410113146.146212-1-Junhua.Shen@amd.com/

Junhua Shen (5):
  drm/amdgpu: introduce amdgpu_pagemap and kfd pgmap accessor
  drm/amdgpu: register ZONE_DEVICE for drm_pagemap SVM migration
  drm/amdgpu: implement drm_pagemap SDMA migration callbacks
  drm/amdgpu: add SVM attr prefetch/force-trigger and in_populate tracking
  drm/amdgpu: integrate VRAM migration into SVM range map path

 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c   | 787 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h   |  67 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 143 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   5 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 195 +++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  53 ++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   2 +-
 16 files changed, 1299 insertions(+), 82 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

-- 
2.34.1
