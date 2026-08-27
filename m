Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EB2C61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9C610E3AE;
	Thu, 27 Aug 2026 06:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o0wpZ+2f";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D4588EBA;
 Thu, 27 Aug 2026 06:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX8dOup2C/A9KzaFK+NHahoQ0ywrfTWI1nd2fVJlWzN+l9A+c1mfJkYKa4n1PH232cGNSnV+iKLd/G7E8Yvz76mTgc3DfEaABHpH6fFrefDekO8hK2B4x0VFUDFW5/Ntz+6uuuvot/qhbxbQOQecjTOurum4SMhaIShfKyHVzJw9DhhDIKDn3TWB9PZJDO/L7bFOaN1g9hYUE3bdEFy8Wxyuu+NyzjPGgMBicRt/GDWPHPkx7nwz62fsvWvgGo35i0g2VL3qtZXxKQX6klAFO6JU8b1+b6Y7sirMUBGMawHfY1TNmuwNb41njHjrGRbkkBjKhDleAGkjW+JMtyZkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUCI94qSoX0tJ5S/YxS0FkLQWVT2BwihTKfpSyFRTIs=;
 b=aJaGSYCV6OBi2gtxFQOTV2ov8pJFm/uMkjR1OSN+Sd2zo2Fg9FScGyhuvLWtauGm8nUN/pddc8Yg+lqrLm+17czHTT5utrn2kWCJrD2sP7tk/DHhs6DHcyFr4j1vWYLyJCaLMaAgATQxRLqO1tW5ES9WRZE9f454qeS/4xkaUDmoV0BW3GZOq0DLpu5ytCk1xNI46+jtO7SerAjeFeRiR/90bZh203nB2eevjdFYl+8hZ4ZRnCUC3M/TqNumYyL+ZBeXFvyg1O5ufFoYH9JOYW6J90B80exyvFp18iyFztSz8FdaoxdVM5iB7VV/z68ciOo/5JioONSIxKOBCu+BvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUCI94qSoX0tJ5S/YxS0FkLQWVT2BwihTKfpSyFRTIs=;
 b=o0wpZ+2fjXTmx0Ee/ThYfZ5OBGwuBXg/fc1KDhXXozPzkKISv1kcYMctIpRAE6G2bffUzXmgUdEsFFs8l1/PEeGeCiNMX6Zq9XU9VWegPHl0dtaQPqVNPyEH2Gbf36l1zf5kS/YOuzFwyeaSS3/k/XwwZyCioGWBZNvxjqS+7Dk=
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 06:22:05 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::d) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Thu, 27
 Aug 2026 06:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 06:22:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 01:22:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 "Mika Kuoppala" <mika.kuoppala@linux.intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] drm: Add Common drm_user_fence helper and Convert XE
Date: Thu, 27 Aug 2026 11:51:40 +0530
Message-ID: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 016dd069-4a69-4887-69f9-08df040383cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|7416014|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: T5B4VpOl8TnGp4thRsH2NMYK0FkM1k86bKV4i7rC8tIW/rq6DBf9AtEU1xBequJDQfxIhAHhMzWjDT8tl60XZvKoqMjV7YyO/a8I4I2TsYXqx11XoSXAm/DbchIMOAVd6oeXx0eH4u51NKPJSP6dbemD7aKDMdV54O7x/nfgxaq/6U4IB7SSX5eVUkg/pRnikwWkEs7+P8Jaoo3oA1UTYGqSr5SZCbFZQZArMGXc4MkBi0VXCNVzrgBW/TBnImqMoNTbV+J0QgMRRYemtkt3r5bvm3wiCNjJOURW4jXYA8dFv5wM+9zLKM1vOsLyt8ew8NaFNxfQZ9xorhQkqcZ7ReDWsfj5x8SMtkQ507mVubwOVTHmQqd3J5IVDqNO2QtP1bLt65HUf+eoiwJvU4gy2DHzGMFQ0P8mTh9gyg4oQHQOlgqoVSiqn6Y6FSFsewVNawzbMTF39LEcJcBmf1hHtomSWCIMedEnsu+uAKAqOlw+7YF98p09Tgo0BNj9Ldqc71U1vki48fsbRmpMgLGoNyWGuDzF9YbxEoVbB/zpJkmISwoS40K2te24DIoejmtBDcUAzbyWCXIlt9/SmFP2IdbPNiVwhLfbXuEmkwoiy0SIM8zeGL/IMqLfw56fFehP5G8cm64zcrdj+jyFZnpHFDgJ7RKSdAE8kQ4KFi68QnIIXyzg3ulohqLDgvJliZ3VcHQO3vbdvUG5M45Py6na3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: igEPQTg8ZEh1uuqKwFZmNmlBW2kcLl/CJ0T0c0QrDJP4joBNYKvAmxRBAUdHGCOMh4wDooVJKh6bfi/OiK3K9UL2QTayjUMoxGe6aDeaV1amZ/x48VBIqLm7s5Uj4MDFwaxe0ObFj7Fw+po0sUWwQmgJHyKMiuidG8bHerHsyFI0etGkZ871b9KgRDTyiE9tpsAeS103/Vd0iYTxdUMKsD/4WHOJNdkcosMGjgzfbo1Ww9+9jQIHvnA74zXZv7hkTN3nrIjZk6sc5l4/6chKR0aQ4uDFYt3TyVCgWqgWSVhUuKI2KkAuKC52S1zo6dX4sVqjv5H5o6tI+kF7lLed+/C7yaUUZB+RaIpOavQalEFiBC0D996p7worPrEnwDUWi79pZZsWSGaiCKI6atui2l4SZJ4rxqkoQWdHC3vbPp0QPmgrEWNr+28YjJpe/dEV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:22:05.2166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016dd069-4a69-4887-69f9-08df040383cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540
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

When a GPU dma-fence signals, drivers often need to access userspace
memory from a kthread context — either to write a fence completion
value to a userspace VA (XE) or to signal a per-queue eventfd (AMDGPU).
Both require borrowing the process MM via kthread_use_mm(), and both
use the same kref-managed dma-fence-callback-to-workqueue pattern.

Extracting this pattern into a shared DRM helper allows both XE and
AMDGPU to use it instead of maintaining independent open-coded
implementations.

This series does that:

Patch 1 introduces drm_user_fence — an embeddable base structure with
driver-supplied worker/destroy callbacks. The common code handles:
 - process MM grab at init (mmgrab)
 - dma-fence callback registration
 - workqueue dispatch on fence signal
 - mmget_not_zero/kthread_use_mm/mmput in the worker
 - kref lifetime management

Patch 2 converts XE to use the new helper. struct xe_user_fence embeds
struct drm_user_fence as its base. XE-specific fields (xe_device pointer
for ufence_wq wake-up, userspace VA, expected value, signalled flag)
remain in the wrapper. No behavioral change is intended.

A follow-on patch (not in this series) will wire AMDGPU's render-node
EOP eventfd signaling path to the same helper.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org

Srinivasan Shanmugam (2):
  drm: Add common drm_user_fence helper
  drm/xe: Convert xe_user_fence to drm_user_fence

 drivers/gpu/drm/Makefile           |   1 +
 drivers/gpu/drm/drm_user_fence.c   | 130 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sync.c       | 114 ++++++++++---------------
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 include/drm/drm_user_fence.h       |  68 +++++++++++++++
 5 files changed, 244 insertions(+), 70 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 include/drm/drm_user_fence.h

-- 
2.34.1

