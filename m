Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D87CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A287A10F905;
	Fri, 29 May 2026 05:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ayQLDmX6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5FB10F8FC;
 Fri, 29 May 2026 05:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ82p0NYOMnLLS5sYiYQZDlybtbQeNPjb9r/3zM9SBcmhZioN9VrOyW1PtumWDzwM2eCPKJkL/S/eEj173zXCLrtF5j8pEmPwcrqbTQKsMhh4f5jaauP7S+iWITpoarAhkon6uBrtZpBFs/gn8hkOJPanqHpUx0SInFKlMI1Kq8A7/Tdub8R0DBRV8ouHDqOLk4/6K7abKwONp1dK5ayD4ZyVrFaV/EdQ8AkUK1D7otoYwZ73s6X1MkVD1AvO9TSF9w50D6M1MxAPe1UZiDDXRqjXskj7Lzkg7/NrVm5MxL9H+UXySg/vytzCFy35LURvRMQcLFmdQYRLgxNK0N19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEUDRwLxtFvEhn5SI6L0iePmWyricQq3fvzj5e5LF6c=;
 b=pubMQrJ7MNyqjwH68otZXsE7KDDoPPHuHKHH3rjtIiOrRWAMfoLTtzskETYmPQZN3mrpiCH7d/nI5s+uB2/wC4gRjTbjlj8dkXajHjfuiNY423V/0/PlCbGxGehTopMi9lp/Cl8CEofJhVtP59dhakJRwfmNqAazse2jezIkYNSMy/MJqSwh1bTeawBEeG04qKqB7DT4oyLgAzBpfJ0N4CLfiob5iRBJn0quLcIyJbfpwyAT7Ew/tOCKVNE3FhoZkKLVNGQx8N5Jgp69ntI+M/x026nxrVgHBHVgXz0nA16lxTifEtreRdjJLCfC4RiKyhYF/lrVYStOVOZ5MR5Itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEUDRwLxtFvEhn5SI6L0iePmWyricQq3fvzj5e5LF6c=;
 b=ayQLDmX6R6cPz673zbxBej28nZ3+cuv5bv3ddnskwAIwD5JjoR0egkGMH+CJi3XtyoIBoKc4NQ6MLrLHNrvHnxI0Gv2GP8zDAYsG9tTDW9V4wGH24C9XrGOGbJ+J4xeJgK+LKc+1o5ydnPxMw9scJEbA6sfjxZUzr7cynTaAnHU=
Received: from CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::25)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:49:45 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::19) by CH0P221CA0041.outlook.office365.com
 (2603:10b6:610:11d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Fri, 29
 May 2026 05:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:49:45 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:49:40 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 0/8] drm/amdgpu: add xnack off support for SVM
Date: Fri, 29 May 2026 13:49:20 +0800
Message-ID: <20260529054928.596825-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: bde950a6-559d-4557-95eb-08debd461656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|921020|11063799006|56012099006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: oYWJli+N1JRCo9ClY15PZXPTU2F2RBYfmI3LWZIgj0iQU1oaGNgt2h9FhWa7AiLCNacx0bA7r9yI6cqLq2nfOFhwYxmcpLYSz6LCEMh9/zoTGyDKXAB5wMlKUqu9B5UZtYmR/64e0rRQOA289lG7z5Gs7/xulvIMBfTmupeHtUm1BWHsFH3/aLBDkbt6lfLCD++/8xrppNBh3p64UpVo6iCkbz+93ik8DEMYwyTRvQsHpSaFGn9Rkgk0YMqkQnwMDvqd9F091x/xKvP0hg8zxVTsdiq9Xjk7Fr+TW0SVyhpxC4HGVLaZrfl8X7Psnk2Thzkc53CgMZVM1XwnZVIQt35cncd5iqnDQByeTiNK0SjvebAH5rSuTYreAQ/oHYbcY8J95Tb4SKuHXqbRwhIMu4aaE1JxO1qVMgg9dILnS9+Vcahuv24nVxwrv4TTsv/fE+02v0k5d3UYlNFzn0ne/igtUwGxVEfHbUozRq6kmXbRGQA+JWzK0UbhFNhITW3qAlUtm4J4CmAJ+xQINxaorZCrnvdS2sGMngsmIEsomDhidkOZrhUQbGrtm0+/7RbB6RoV3eh6/hVp6qKpB0KW27sqPdNh76vrZiUpsQKXhGoSZo5zZxq+HCJ4rZVmcus7rYqFuRB7+BhkvrDpjORNPVLWj0DMNd1TPlSqCwCmcNm6FALA8lQqlgBg9gyILNcc/bnr/sQKZoXWpBswCam1KLFQtvwNHgTWrTAqKw1L2IyssF79MhcNbsXCSg+/83u0x+C/g5ur+Jda2a/cR5cB+BvhIqgTV0Ns4RkLykP6O/w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(11063799006)(56012099006)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TAxvPcsFKPGBSuQiy99PzchhImp07lDqxi9925aAyNPGyF335CJcGoKyovoaZgzYjTiJHVF923pMDJAOALfu/Jp7wakjGe0nFtIzOHBtV1YJoFFzBkR1JYXC8TrN++4xGSjGh2heorl17RaWzWxavelzpGJ0L4qGmLUJnd77H1TepLAVsR1Y/yWkLoVK+Ec1suU5yDKHPLT76g8qA/nvnfCETZaQHGvy1GC5nKiHmj755F3JuTQNM9iO2pGVsah0eVwhXWpnVBxemRyjv/HhTqtjQT/uNPUjl5v+CollnVm0SDzBbZBN3Puh3FWqu3a1gddAKV5YZrO/Rgz3sQYpxUhD6wzVEjT0r7qzFphXy4tAGOi37FA9WqQBz8Km8SxdDuqBNwtjCaHELp9IIcCkS6GbPp1pUOZbzdhZiifMXbrX7S4UcArUBV861Dgbla1N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:49:45.3045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde950a6-559d-4557-95eb-08debd461656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

V2 of the xnack-off mode SVM patch series.
This revision introduces a centralized non-retryable error classifier,
reworks the attr change path with proper NEED_REMAP trigger.

This patch series implements SVM support with the following design:
  - The notifier invalidate callback moves ranges onto a
    spinlock-protected invalidated list, like the __vma_userptr_invalidate
    in xe_userptr.
  - A restore worker iterates the invalidated list, calls
    drm_gpusvm_get_pages() to re-acquire pages and GPU
    mappings. the same get_pages + rebind flow used by
    xe_vm_userptr_pin(). On transient failure, ranges will re-enqueue,
    following xe_userptr's retry on EAGAIN pattern.
  - Lifecycle follows the same init/fini/flush structure as
    xe_userptr_setup/remove/destroy, with flush ensuring all pending
    work completes before teardown.

V2:
  - Add amdgpu_svm_nonretryable() helper; restore worker and GC worker
    now share a single classifier for permanent errors (-ENOENT, -EFAULT,
    -EPERM, -EINVAL, -EHWPOISON) instead of open-coded checks.
  - Restore worker drops non-retryable errors instead of infinite retry.
  - Add AMDGPU_SVM_ATTR_TRIGGER_NEED_REMAP macro as semantic alias for
    NEED_INVALIDATE, separating xnack-off (force map) from xnack-on
    (invalidate + fault) intent.
  - Rework amdgpu_svm_apply_attr_change() xnack-off path: force mapping
    when range is accessible, using NEED_REMAP trigger.
  - amdgpu_svm_range_put_if_dequeued(): schedule restore work when
    pending restore ops remain after GC dequeue.

Related work:
This series depends on the base amdgpu SVM series:
  https://lore.kernel.org/amd-gfx/20260519083057.3108087-1-honglei1.huang@amd.com/

Test results:
  Tested on gfx943 (MI300X) and gfx1100 (W7900) with XNACK off:
  - KFD test: 95%+ passed.
  - ROCR test: all passed.
  - HIP catch test: gfx943 (MI300X): 99% passed.
                    gfx1100 (W7900): 99% passed.

Patch overview:
  Patch 1-2: Define restore types/states and integrate into core headers.
  Patch 3:   Invalidate callback - dispatch ranges to restore or GC list.
  Patch 4:   Restore worker - get_pages + rebind loop with non-retryable
             error classification and selective retry.
  Patch 5:   GC worker - remove unmapped ranges, rebuild partial intervals,
             skip non-retryable errors via shared helper.
  Patch 6:   Compute queue quiesce/resume helpers.
  Patch 7:   Attr change boundary realign helper.
  Patch 8:   Wire restore into SVM lifecycle and attr set path with
             NEED_REMAP trigger and eager remapping for xnack-off.

Honglei Huang (8):
  drm/amdgpu: add xnack-off restore types header
  drm/amdgpu: integrate xnack-off restore types into core headers
  drm/amdgpu: implement xnack-off restore core and invalidate callback
  drm/amdgpu: implement xnack-off restore worker
  drm/amdgpu: implement xnack-off GC work function
  drm/amdgpu: add xnack-off compute queue quiesce and resume helpers
  drm/amdgpu: add xnack-off attr change boundary realign helper
  drm/amdgpu: wire xnack-off restore into lifecycle and attr set

 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |  56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c   | 907 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h   |  68 ++
 8 files changed, 1045 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h

-- 
2.34.1

