Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10A5C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB51910EE93;
	Thu, 27 Aug 2026 07:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bdtezfyr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB2610EE93;
 Thu, 27 Aug 2026 07:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A61NbBpVXVnZDwO6ve0C+QoQigtDdKa8Y4YaHFez+qYFGIOI72ilb6HmTTvHy4fG1x9KoU01/Q2aEwBqMK2nN5dKj6en3/lfiZ/LyARn74zNJXR561u9aaw5Gq6rXvZg1bTAZoEyFAnu5ne8H+O3eui9q8xHsl1dnG6doj6GCa/kHlQIQRZ8Axhqx0UJKm3t2yk+sVcHmuH/LZLoyyWJJ3uMPhYoAadKgf2ooMl+PXngsqRNvnGf33OYOjWx9jFWw1lz0AhKpWq6hQw1UzGdGJCAPasXjoTI50P34zFLhn3o4gftgbsb/yzVNzx7ovblhS6BOYRZa3jlS/5UcXe1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QRt7m4zNN2gmn2UnYudtftCL8VeAN4BweNEvEQmxw0=;
 b=wMAvywIjw1Tpi4U9FLcVDK2+KZAX9tA4y+1or/9q20LF2UcYvAj1eYMksdWD653XHxlqUqPyq0yyHUDUwto4VNX4dtJNcy0CLwmF+LUI8euVmv0sB7xza8eQHclb/3Q0Ovdp57LiJl7Npfvf9w1Buyw0oM3Tzj4E6ib3IZUZs7AO8D3xpV20BvvlwEPKquxRm53ngCZhcBl36bjl6cWzX82mRiKdIpv79Rw9Us9wHEenc29ojbrIOrPuIs+nkDNtT0vBtwpGezq84xX1CFi1HbfX+rQlJrRx/hBI5nPEbfzDQgyNPPrRA/d+ZjeY1n/gnlLzVHsb+UBmT3cpuiQ3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QRt7m4zNN2gmn2UnYudtftCL8VeAN4BweNEvEQmxw0=;
 b=BdtezfyrFNBRpwVOsTujcH2Omiw/cQBDD9BwBi1qz87cRLsGmWoydZ/JKg32FKVmeT5QMOts7Z8kMmgXQeJcLavb278et9IzJZvGKuaUHhaf08eYVIcRlbLsmCGMNBozJvSLbmAzAcOpXM1a/NCFhCvijoSgUlrtBVHnGz70aPs=
Received: from IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::15)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 07:15:07 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:559:cafe::2b) by IA4P221CA0012.outlook.office365.com
 (2603:10b6:208:559::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 07:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 07:15:07 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:15:00 -0500
From: Honglei Huang <honghuan@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC PATCH v1 0/5] drm/gpusvm: share one HMM fault across per-device
 DMA mappings
Date: Thu, 27 Aug 2026 15:14:44 +0800
Message-ID: <20260827071449.520398-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 207273a9-b620-4c49-469e-08df040aecc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|13003099007|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: hbfVE4nUC9W2R/flRo0+H/wzojLpByCK/UEBnsh04K5qQfQZyEKlw+C9w5BZhgkZss4tPICteBViopnoeE8UFojfiY/GsaYkmsrqZ3Lec0zsZmc2VfnYD20aaCrjJydNJ9nlYXInBFv5YD7ZByVxfhb0qKous93m5HzdZOukuwZDqNKSYUDt9MgZwwpmK3qDTOwr6sSRjioifJGBhTxTZ0XN16DtnI7gR7W9LrhrhxNIauFAuy0VMghXs4CGRyzWys2E2Zf8d1rzVODnHHdm3J1Nqfu4b6yk1uapap49f42Eki8Mb3mvSUSNh9msKY7EcRW1j7Wwwm5lmbckhGQ8IuWvFodjzY/jsoxZzgz8rDQyyMvbL/uhpW7DxKotumUaQOIs8HgCpw/dfh+03fVdNOZ31ymcgdNduYB7zCSL+oDZBt0+XHNuAbRssHUyA2qoqYxRVr2JxgQGJaBaVN1sfg2C9n97rhEqwRLsZK23ZhYL3EXCIGlTYelqFPhfNjGlMQQaN4ed0bZ6qZR7kUp4b1pdrtDYXz4c7UggnnGt92FGge//2Y5zFxDtunTF0s7aKeZPnnTWsJ/04Q6XfgGbWIAfaFPas+dM+3AsonDd40o/G8qepMi/ImBcREHzCBsskB56fh9SX06zQlPrf9Or85rcZ4nE5VBrP5PSIl+ag4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +T9L3HVZJrFoI9QgAFIuVOQbbHU+c5Kd2LFuHA3VMNwsSYVyWXC/PC/QHaOChgHzKrxaXD3rynHxpOmrcTqzGBD+ttqNClYRlUvDhb9VT1VHxedDUbNpQ1roJo61HZGUtkEnMKAgihSaKCmYJI2EjmSMgD9/eKq03aCvP7r8teUr5uuPVATeQ/B5j4WbPhawy8mjHBpsKyehisFC5tnROjGB//9uUzhEf/O4fQSg/Dmffv5CwKKB9hs9C1tcivEjmNdUxUZ19UUDwPHYOH0dhPT28ngrCO9qc5Hj74EJ79/Xjux1Jnq8Jq5BHV6y9Soq/f4gRFcKJFTIq0hTYxGIf8O647htvbRiEl0CWpZiJP74RT+rbqzfjnRsEtj+Io0YYhakEl/boElwcvsBB2H59UvzQnbd2AmjvIh6Ph3obcK1J5SgRyZLOHgK28es4R+e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:15:07.7940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207273a9-b620-4c49-469e-08df040aecc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779
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

This series is a follow up to the earlier work in the drm_gpusvm_pages
decoupling series [1], and follows the direction Matt suggested [2].

drm_gpusvm_get_pages() used to do two things at once: the MM level HMM
fault of the CPU range, and the device DMA mapping of the faulted pages.
When one CPU range is mirrored on several devices, each device had
to call get_pages() and redo the HMM fault every time. Matt suggested [2]
passing an array of drm_gpusvm_pages plus a count so the fault is done
once and shared, while keeping the notifier retry loop in common code so
drivers never open code it.

The series builds up to that in small steps, no functional change until
the last two patches add the new behaviour:

  - patch 1 pulls the HMM fault, and its -EBUSY retry, into
    drm_gpusvm_hmm_fault() so it can be shared.
  - patch 2 moves the dma_addr allocation out of the notifier locked
    section, so the mapping step becomes self contained.
  - patch 3 pulls the per-device mapping loop into
    drm_gpusvm_dma_map_pages().
  - patch 4 makes get_pages() take an array of drm_gpusvm_pages plus a
    count: fault once, then DMA map each instance, one per owning
    drm_device, under a single notifier retry gate. The common 1:1 case
    passes count == 1.
  - patch 5 adds no_dma_map so a driver that only needs
    the CPU pages faulted in (e.g. AMDXDNA using GPU SVM for userptr)
    can skip the device DMA mapping.

tests:
AMDGPU:
  SVM:DRM N:1 multi device support is work in progress on top of this
  series. The single device (1:1) path was tested with the amdgpu SVM
  adaptation on top. Based on amdgpu SVM [3].
  Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 99% passed.
                    gfx906 (MI60): 99% passed.

links:
[1] drm_gpusvm_pages decoupling series:
    https://lore.kernel.org/amd-gfx/20260630102127.392396-1-honghuan@amd.com/
[2] Matt's suggested direction:
    https://lore.kernel.org/amd-gfx/aijdg7RWwrEDEMxC@gsse-cloud1.jf.intel.com/#:~:text=Hmm%2C%20this%20might,requires%20DMA%20mapping.
[3] amdgpu SVM:
    https://lore.kernel.org/amd-gfx/20260804094246.1719318-1-ray.huang@amd.com/

Honglei Huang (5):
  drm/gpusvm: extract drm_gpusvm_hmm_fault() helper
  drm/gpusvm: move dma_addr allocation before the notifier lock
  drm/gpusvm: extract drm_gpusvm_dma_map_pages() helper
  drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages
  drm/gpusvm: make the DMA mapping step in get_pages() optional

 drivers/gpu/drm/drm_gpusvm.c    | 339 ++++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_svm.c     |   2 +-
 drivers/gpu/drm/xe/xe_userptr.c |   2 +-
 include/drm/drm_gpusvm.h        |   6 +
 4 files changed, 244 insertions(+), 105 deletions(-)


base-commit: 04984fcdbf6876c940c01026a7404c1e9cc91ba7
-- 
2.34.1

