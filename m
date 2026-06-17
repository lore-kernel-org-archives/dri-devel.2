Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA5FCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F4E10EF92;
	Wed, 17 Jun 2026 10:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Byjg7XPN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1184410EF8F;
 Wed, 17 Jun 2026 10:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpwDRmqvI6I/yIJRfjMUw7T8auzEI9DTLsUCXWLDewBTsUW4jtj49wEoFyuWbXEDCJsxbsxLjq9bO9+vt567EA7qfCQQg9hVHnoZCFgVzXAqDwD9gpSrAMO3yNR8GtUfRNhVVULQmvrTGBc1AB+uWZOQOjA0OkIEwD7EBwrihu+fH55ablMECKHVVtF4gJ20pQbXpBs11U7vgfPq31ESOl+Ozap9i7//LUyQVLySpkwhkKF08x0P9GjqsSAMK3vVklhqAL1tntRKK07WB3pKp/DCueuYM/FIMY5buDMFihH0izldyLS6gh8PKhfZGAUngPBlg5407/sGLHECjuQpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYATN/5I9BgbfQbthBO/khrv3Ud3EJM4XMPG5sh0D50=;
 b=UsoQEcSAei44k1gaJGpW5xEF07/pcHW3+lbbohHqTGHTn1AQXEVOlBWi0O3nuSjePhFnaRM/A+J0OreMzYGfqWCzFxC8LMTYxr8HMrID3nofWN3Cjea9h3cEcAj/lJIJElxGy5BDzon4h5pH4fjWvLOn15MzGBEbF4KaKN07Ok6nHqdzlQlnnxqxkl/D90M1ndjRUGnsU4rjAzBeDiiXfzwVqQ4mQIqg3DoQDeutVyz4EZZNM+6j1Ce3UjJHnY6hqxnQbUTL3p3rRFqUEda4ybuRTNAo7KgfGLR5qCpgk7mfm+cJu0IenpQzj6wY7kgRqoCtD5b+CQHDbGHVJouhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYATN/5I9BgbfQbthBO/khrv3Ud3EJM4XMPG5sh0D50=;
 b=Byjg7XPNUORjDCQJazSGSNN6YiVnExZcfhneZUOUZ7Xv66NFvgSWDDhvLnEsA1ThU/x2HCx7JcwW1ovVzo42XenNd9065/UvrpDv1dMBTY1wcqU5FqZ8XAUc1DZK2sTNORtUQEW+lm5jz0Z45w5YDW7fH4epM4/ZZas70BDOqNo=
Received: from BL1PR13CA0293.namprd13.prod.outlook.com (2603:10b6:208:2bc::28)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 10:36:25 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::68) by BL1PR13CA0293.outlook.office365.com
 (2603:10b6:208:2bc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:36:23 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:36:19 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [PATCH v2 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Date: Wed, 17 Jun 2026 18:35:57 +0800
Message-ID: <20260617103602.1491609-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5161e0-e372-40ed-16c9-08decc5c4769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22122799003|11063799006|56012099006|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: jVo8rfi8fIm1go4Uf8PRazpDEaNtkTZW741ghXwJ0qqTHLlaMU+oQErAC4pB4KpDiOwteHQ1p4Er7xr4uXqIpSo+2T3xrznXzA/M6I3H7GLAoCzV0aXVX/AI3xFqwki4k3wJ+2HllR25byDV99GzlxHv8gl8G3+wfaTdR4niTyAvxF42V92cL9ONocBdOxo7F/1/mGzRqMPoNHX4/m2+iLFGFdKvPQ/WuEAp1Xh4hO80PpVUtl1pJ07todN2sdTqH4xAxXAY278tEhEbWyCZ1/zBxq20Iz5lNYTv4RFkuM1oWAmkMcxgg8LVsXKERPwolN6l/R0rrTl//zQyvb8IaKDLljJ9FiY8KSqdAY+thIC6zWL6Ea9D7HkGk+O3PApM9AoCim+i0wYXD13G7sT4zW8ow8QLM1qlJxQlAm4Ot68UQIIXZod1oHbD4x89MEy0N/td0BU1TVSVtYDbp9VpSWP1fWwrs2YnMQ0bVquOQMSTJtrFIzn3hjHpwlc2J40jNF+PJfU7Sjw9iNkoh1QENb2/XIOd7QqsNfxgxneOc5C0gNzGKKbg8Gzjq8BmFi0GYM1mrnI4aRR0Vz0JkZlSWekvoCnzh+lrLYTEMLdnl7sDG1pBONPSEYcxI1FnwOGrn+SGrKr6jWuroNMEFOUYMXQfgzmOVtxlQeCU3+dgH4gjZdYL68e6EvUyOhfAbHbU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22122799003)(11063799006)(56012099006)(18002099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hXR2DWDuuhTtmOlcWZ7G2RytSgDBJF+oJhlCYnwRjAY/GQf4mzzxbkN3ZN0DlGbFQMH8une5MTzBHbmor64/hd7QDcVYDwbzsrJ+Yid+CNC3nrdstLkp9vaFFDvNl1kFOqR7b7GcGJxpLoNiyI/PTWtl3w52jPgpwtRtM99TpuEO3sIintT/iIHT8mIqy4e6hzZVvPexSuM6Akoluh65zFZU6drnzCADKRUWRvbQS39C7DMnsR0kxF8xCgcOW2HDR4j54BzzR/s+aqejaTgmSxMSDRcNc6iHoufdSGPGouOaURQimyZaV7NGuzJQPutk7TglY8AGz6226kVZZeHrm7qlrQNf4IyZBspnUYG4rYjNsAMn/wv4Hd8p/RqDG+CoKmc7uD4zmbHnESxkhtVYn2orqkiprSVxFZz49opC5BKBYxHX2I3WYaPizq8G58pe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:36:23.8733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5161e0-e372-40ed-16c9-08decc5c4769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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

From: Honglei Huang <honghuan@amd.com>

The intent of this series is to make drm_gpusvm more flexible and give
drivers more freedom over how they assemble the MM related and device
side operations. It implements the direction Matt suggested in [1]:
Mirror MR in gitlab: [4]

  - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
  - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
    DMA through it.
  - Drop struct drm_device from struct drm_gpusvm.
  - Have the driver's range structure embed one or more struct
    drm_gpusvm_pages in addition to struct drm_gpusvm_range.
  - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
    drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
    drivers to use the drm_gpusvm_pages helpers instead.

In essence the series does only two abstractions, plus the xe
adaptation that follows from them:

  - range vs pages: split drm_gpusvm_range (MM / VA range state) from
    drm_gpusvm_pages (device physical related), so the two sides can
    have independent lifetimes and ownership.
  - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
    the device side down onto drm_gpusvm_pages, which is where DMA
    actually happens.
  - xe is updated to fit the modifications, no functional change
    intended.

V2:
  - Followed in Matt's v0 review fixups [2]:
     - keep unmapped flag in pages structures.
     - add pages_count to drm_gpusvm_range_set_unmapped() set pages unmapped flag.
       let frame work can check unmapped status in drm_gpusvm_get_pages().
  - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
  - Remove drm_device from drm_gpusvm_get_pages() parameters.
  - Reworked the DOC: overview and usage examples to describe the new
    model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
    examples that operate on a driver embedded pages object by the
    drm_gpusvm_pages helpers and etc.
  - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
  - Dropped RFC.

Follow-up (not in this series):

  - modify drm_gpusvm_get_pages() to support one time hmm range fault
    and multi drm device dma mapping.
  - Add no dma device support for drm_gpusvm_get_pages().

tests:
AMDGPU:
  based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
  1:n is on going needs many modifications and testings.

  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 99% passed.
                    gfx906 (MI60): 99% passed.
INTEL XE:
  Waiting for the xe driver git lab CI result: [4]

links:
[1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
[2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
[3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
[4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360

Honglei Huang (5):
  drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
  drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
  drm/xe: have xe_svm_range embed one drm_gpusvm_pages
  drm/gpusvm: move struct drm_gpusvm_pages out of struct
    drm_gpusvm_range
  drm/gpusvm: let the drm_gpusvm core context purely MM level

 drivers/gpu/drm/drm_gpusvm.c    | 221 ++++++++++++++++++--------------
 drivers/gpu/drm/xe/xe_pt.c      |   2 +-
 drivers/gpu/drm/xe/xe_svm.c     |  37 ++++--
 drivers/gpu/drm/xe/xe_svm.h     |   8 +-
 drivers/gpu/drm/xe/xe_userptr.c |   3 +-
 include/drm/drm_gpusvm.h        |  66 +++++++---
 6 files changed, 199 insertions(+), 138 deletions(-)

-- 
2.34.1

