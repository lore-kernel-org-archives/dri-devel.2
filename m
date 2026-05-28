Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568CBCD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 21:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85A510F621;
	Thu, 28 May 2026 21:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0T0p86f";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FEC310F621;
 Thu, 28 May 2026 21:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEGaBXwS4nz1KU/4f9Y1xlN0AJwdxPbg13S4zW4NIIoOhb7Aa9SyPr3b95npEDDekIPAGBJXTFX6JwbVj/4oCuR/2vCSwCBWYhZCvVbRVVSicXfht9wMsInCyEnCtAwggExW6mG4mfmKe8aDeYLav/Ntp1jyh87SAGnADhekZ4ugDMmQwIomkTBkgKbEnPbVFgnEH9f6IJeL5H9vLnTLwXVCmnFilpigKstvGMf+msGnrlvXgCmCgJxeP4spMUq5AI/L109quz5fpyNf4xwhhjnsvH5etKcJERqbTVdrt+WKFqKpjEezQciTQWyCa7nK9GbRpSpfu/DWaru4n50ofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzgYL1pbkOedZKN7KPENcJCLWIhm9VoulxY0tYDNw5U=;
 b=YhcrFq4CJO9r7+ks5Ak6xenkSkzGLbTkY0OYgTEx1qSYb4NZQECpZg0Ru3z0KSBXFnV49QGEMIQR4V7vzZWE4OPJNfPWGAatTaU+rzEwUDs3v4FMbPhqpwKD+a2Gs+hWdxZtE6sbE0bQfpXzstociUfCfsJiVf8BAy12+L1JaW+DKw+7bPZkwWhvlHIW0go0v/ZWuxgQAiFN7yaR7LjuATEeJrFlr4BHtov0l5TmjfCiSv+vyyDLvABVknoADwnqWyDxGs/fHs08RH8kvtpZO8qACCQsvrkpYYUSz+YJe74YfyAqN+gdSpFKhWNW0BDN4MayJW5gUnCHsviCemfdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzgYL1pbkOedZKN7KPENcJCLWIhm9VoulxY0tYDNw5U=;
 b=W0T0p86feY2/apL0iqbUQic2kHmNNLALPaME4F/v+fb9YRYs3BfcacnzTb72vbFIFX3fkmUlTujSz0KZ8cCvzFSwgByClWorKMdR8pmAaOsuHN7fhYmGKEG1HbrUjD/T7aZmAD8HDTDBfo7oFKNDCrSeDIbWS8wNu823Vm3n0R4=
Received: from DSSP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::16) by
 IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 21:18:52 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:3d3:cafe::70) by DSSP220CA0011.outlook.office365.com
 (2603:10b6:8:3d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Thu,
 28 May 2026 21:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 21:18:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 16:18:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 28 May 2026 16:18:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.1
Date: Thu, 28 May 2026 17:18:43 -0400
Message-ID: <20260528211843.893681-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bc5fae-7f36-4948-027f-08debcfeb76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: P3lrDFUafbyCZt1l2CEo68PgE/4UjlLEIUKtE90f2imaHFL4DsUQa4zfrtizCjvBOWn1cFkuUJm+on7nEpfNEeEn4fnP64d15yzHHoDp8gq93ihgx+IUKBFK7D+CAEb4gM53lUO1YRPsvnbPmK8Q9gdujtB+DkQft4f4ALJ+2U44YiAtVC3ioAQKIvE5aAFfR3mum6++Rdk9/XPa1N8tTUNcmfUhBxacg34LrG1X6fyAxCEo1za3wJHYq8t5oS1Cm+JDuitmBZCRhpM2jl7K59U1kZ7G6b0Q8XT4Ib/lYOS2rENvqjqJbRYQOqllXYb17jmm+iD036ciBCFnrFEOGH+waUc3xpT29aD8fLuQUJJc1LYCHID1OvWcjUDLozRWcJSx7prOwLTaXbqQKy44ceuXZU0nkaGjxkz6iU8gscXVEuxVInQT1igeF40gltvjAXipjDYIHJwJqSGFgtHypdHCoZMgnRaO5phbcRPegPdJ3UYeV0A6Q5pBo3GxAxl/yHoDYLHN9rPatgH+0FAnQirvlyy+TTxML3FSwD9ff4whfZaxRAdEw0kXkMaLWy5SERxAzQ12ITXcFfawi9u1yWeuHY6xZ/bqDxtViJnetjVaBdwFT6xpxMb7YLChUYyBfQnZ1d9SyUPfy16yJS2BKAxzVoXJbSs2JWqRLBixoLKiuiICqxqBPA3qBn/mMAvJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B3mqxOcuWuzdjwA6i++WSVqVhL1Ae54cT9WEAkr7pJSJA28ZRY97co148jmIVoWDaHQ7UwwhNNfflwiUbA5iIfyF8dYDGu3BeXnmzS10Ld5guVI1iqMZHbC01t5/LFYXvFD2IfL98ZY4KRKhE2ZLrWihHLKYpRK7qgd5DWOHAjutBq1jJJWiUDZodH1YCitlOIoBohCsF+wQ+6F3PdzITCjQNUlxNpyk7AYasxUW2m6jROoocQpjmeU3qA0zPJ1Kzhj7BddNY6cJPm2Wxq7y21lstiPpsradA6oAkeW0NIMgSEhrIiUrEdOTiTnnQ6xEMS8EPqCfsoyuEvEi3gf7QRidIlZt6GxJC4ZtklTpAz+teDJUfMytLXz3auHN0RXaCE6zIN3/MVVt6YSdJ0KPgCc+3EpXR3Cnl1Z46c58hgKVwv+26rCkxa5z0UYCBx2Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 21:18:51.7704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bc5fae-7f36-4948-027f-08debcfeb76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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

Hi Dave, Simona,

Fixes for 7.1.

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-05-28

for you to fetch changes up to 1c824497d8acd3187d585d6187cedc1897dcc871:

  drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx (2026-05-27 12:06:26 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-05-28:

amdgpu:
- GEM_OP warning fix
- GEM_OP locking fix
- Userq fixes
- DCN 2.1 refclk fix
- SI fix
- HMM fixes

amdkfd:
- svm_range_set_attr locking fix
- CRIU restore fix
- KFD debugger fix

----------------------------------------------------------------
Christian König (2):
      drm/amdgpu: fix amdgpu_hmm_range_get_pages
      drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx

David Francis (1):
      drm/amdkfd: Check for pdd drm file first in CRIU restore path

Eric Huang (2):
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
      drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger

Ivan Lipski (1):
      drm/amd/display: Write REFCLK to 48MHz on DCN21

Michael Bommarito (1):
      drm/amdgpu: fix lock leak on ENOMEM in AMDGPU_GEM_OP_GET_MAPPING_INFO

Stanley.Yang (1):
      drm/amdgpu: fix potential overflow in fs_info.debugfs_name

Sunil Khatri (9):
      drm/amdgpu/userq: Fix doorbell object cleanup of queue
      drm/amdgpu/userq: Fix the mutex_init cleanup for fence_drv_lock
      drm/amdgpu: simplify return value in amdgpu_userq_get_doorbell_index
      drm/amdgpu/userq: add amdgpu_bo_unpin when amdgpu_ttm_alloc_gart fails
      drm/amdgpu/userq: reserve root bo without interruption
      drm/amdgpu/userq: make sure queue is valid in the hang_detect_work
      drm/amdgpu/userq: remove amdgpu_userq_create/destroy_object wrapper
      drm/amdgpu/userq: move mqd_destroy to later stage to keep core obj valid
      drm/amdgpu/userq: use array instead of list for userq_vas

Timur Kristóf (1):
      drm/amd/pm/si: Disregard vblank time when no displays are connected

Ziyi Guo (1):
      drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 207 +++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  31 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  47 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  10 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   3 +
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |  15 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |   4 +
 12 files changed, 150 insertions(+), 213 deletions(-)
