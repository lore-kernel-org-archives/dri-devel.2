Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5316BC98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6DF10F6AF;
	Thu, 24 Sep 2026 17:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3T/teDpU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681FF10F6A5;
 Thu, 24 Sep 2026 17:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS4rEp/AZb+Q8EYwzQNLI4fo7oTyPihNLLt1a4riBZNRQwpLXjsGyDSpFOvZzD04hJphDLg8v+FESvdk2KnC4VotTtkP6Nfyjy9atEEYTcYOuCteeLFxRiYwl4QgEJBf/s3mOYWIjnfckuE+NbbjongygEm+eH1Cul5E39DbHb99qsQFnYnXDyiiZBVJxixKh7lDhc3+meeCM6ejLrmxtWhfbx5yhT1lWlejrxAkcJBXRxTWHsOzTrCIS7uTIgJ7/2kImQkqGkB4e0gNyq/EtNFYBDQ9CZ5b/WBRs9Zi8aOq8v9ikCtZ5mfsY5tos+W8eTPfZPmoo1YVVspqDNxeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnH3vzk2Occ0Cv3InWcIy/3r8/hs4GWmxC9e1gBbI8g=;
 b=WF1+/FalJ4FjLD20OP9HEmOYBeLw9RyQ6zQ8c2gSFIbk7sF6PR/yTGiTOaoIVFNvEjXalpLbLJFyMfTKkw2uzr8aAUjMeYEXyCcFpliNvt+LEZ3k8WMRGuGZAltgOH6RGH18119QJFA54jBiJfRbppPRNSf9x9qOmTF/+/CHKnO6LD0xjVz93uSqcxHhX2XsTWw8ctuTUk6c8Mq9T8ChbHzI64MWdMglp2oQuMguG/7rVPsQPT80dfFI6h8I7GX39SUoq3DtO/x0SKPVruIYgS/P1c+H+n3SDkm0t/Iq+GH14olC7pRWp8EZYIDrl7bq+2Og1yoCi4FzxOzeDTxNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnH3vzk2Occ0Cv3InWcIy/3r8/hs4GWmxC9e1gBbI8g=;
 b=3T/teDpU80z7hV6kek2+3hK7GaW/5fF73nYgwyfqrK4NQUOf+mpWNuzwUG1qE+KgV9bxCyrwiLZa8RhWWxlfTrw3QNZmefQ/F328ox9/tn7fXJ2kXCjoGvtd3DqxX4WVR19cds+TY1mLSbPXkfXfRyTV12NMP4Sd/pOjJRzJc1I=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:29:54 +0000
Received: from BN7PEPF000000A7.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::4d) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Thu,
 24 Sep 2026 17:29:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF000000A7.mail.protection.outlook.com (10.167.245.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:29:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:29:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:29:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.3
Date: Thu, 24 Sep 2026 13:29:38 -0400
Message-ID: <20260924172938.634777-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A7:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7094ba-e037-4963-972b-08df1a61721e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|18002099003|13003099007|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 2GthES+/diPHSqkcJWT6RwmAl+jHbHcLtwydI+3/smXgX+nvn2JtHfsmuS8JQE+5Ga0mhynHPAPEO12fw+8roV+fAyxWejmTEx+aH4yQfLgWIUjC3Our99gsuoBfVdYmiErT0M4ZztGgXOhJ+h/sKYaMVyDEeBAwoZnH58xOLTqCMmHM8Yl6GHTbzoQJN90aKgMhjCtdGfr97G8ae2W163AgHTCXv/1GM39sJXSWdf6gQIyUwNZHTbiBeqNl56f8JWwSyq3MjDoMvHcIjQJwlZRbVLJk+xtgUExevePf9PcaNEIkgXgWg5EfqIvLahFN7D6w3lpVzbPI19Vgb+TTseBo5Os6By5D34kbkfFN72UPwrgRsFZu7zwFC0C+LOjN+HNPIcdj17FaR7eCBuZR84K6iLDNNq7+QXK7OB4duOH54nFg+A1kA15Jgd5cvLF3SJFlyAtiyfh9zza1PDh4Cg8bmGEorJy0uhPU3uQ8U4VggqdX0ClMoR419LXZQUYkKlmqKpB0zVLOJd7kmmvodXcMeeVzpxmtQBQBuxXCy/gGBnyOkZITKT7fKMeemEv7bsdsnAnPaEBoAkNzC6qq0izh/TU5ziMtCRPpQ2So6rXp8Kndr55pT1AiRcQOy7FPfHbobkZ4B9u35XOTbYKt1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(13003099007)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X3VxkqUyjh8eovwOB5rp+0HMgJ9zxHINJjG/v27j1XAejDhNjBC6+7u3YJl2W5QD2WV8xesTpHbcvdL9kcOkiDmkmuZwKDKi1Xsl1qQnivsvNi6fCynVNqHGZ4bD7c9B+937Zp+B9s3MLIHVa2Oiq6UsaBFYdi8IarOco27Pn/nHWNCllUaPMPnW2apeobfo9Hb3iMKxazEEkdeyBu23epUcMgiL++GlSfNXdIwf4HCjSMyyz5y4YmCZr7dfp58mbqwXSEvN03b7uwfwu34M3gUJbaWaU0inhPM4eyNxQTievmwDkybGUh6MHUsFIUYq/Lw6AzUd54fJkBNwrY5FGb6mrQDm21ILqlf7BrU8vaKCgFWa/F9vSf2PdKijBfUVwT+Bqw/hbqEoTRhDRooU2W0gLdsTRuc48p0YaGFJ5sH1bMos2VC008on/vRGI0cV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:29:53.8133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7094ba-e037-4963-972b-08df1a61721e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
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

Fixes for 7.3.

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.3-2026-09-24

for you to fetch changes up to 15814c01ac57643edf1662a076d2961332f277a5:

  drm/amd/display: Bump frame warning limit for all builds of dml (2026-09-24 09:17:58 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.3-2026-09-24:

amdgpu:
- Display ref count fix
- Userq fixes
- VCN 4, 5 reset fixes
- Fixes for various error paths
- Stack frame size fixes for various combinations of compilers and configs

amdkfd:
- Possible UAF fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amd/display: Bump frame warning limit for all builds of dml

Alex Hung (1):
      drm/amd/display: Relax DML frame limit with UBSAN

Asad Kamal (1):
      drm/amdkfd: fix use-after-free and multi-container gap in kfd_dev_mapping

Ivan Lipski (1):
      drm/amd/display: Bump frame warning limit for clang builds of dml

Prike Liang (1):
      drm/amdgpu: move userq fence wait out of signalling section

Sunil Khatri (3):
      drm/amdgpu/userq: fix double jiffies conversion in hang detect timeout
      drm/amdgpu/vcn5.0.1: fix video_timeout unit mismatch in jpeg reset wait
      drm/amdgpu/vcn4.0.3: fix video_timeout unit mismatch in jpeg reset wait

Wentao Liang (5):
      drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
      drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init()
      drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
      drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()
      drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 16 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c            |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 71 +++++++++++++++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |  4 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |  4 +-
 13 files changed, 87 insertions(+), 33 deletions(-)
