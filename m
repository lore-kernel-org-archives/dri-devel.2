Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402B0C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF6810E0F9;
	Thu,  9 Jul 2026 21:23:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CTCcxcok";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9134310E0D9;
 Thu,  9 Jul 2026 21:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsFw/x2sE3Qgfr4e9Jp1iU/jvHKxZ5wVlQZdS9uGbiuEjMIo4sYT1U+LKl3YxOJ729PFTpQ5mwxOXNc4e7ga6Uq9462y7EkKhYv2fPWNYxiUR8Dh4NK8Lzz96joUxUxycWEA1Cuvhdof93G7VA9u94FjDtHlULZEQtV4HnjnBn0dkOwR7KfCC8Fxqy+dAx8/+iNXk1BUcScIDRkbVklCkr3IR1Kg1YDnI2Q3+RvOYgCwpNBVnypjaR0q/2IvUQnWEbwf/6GxMkP+TbgfT0dJwUeubUsWPdW/HOoDn+rFAyglGNdbEAGpn1Ud9KgqV9qmPWr3hgzv598V2KbGLpCeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbEuhZ4l6D+XHtmfmdnCsnXXBJH61z7aa2C+l7rqMzg=;
 b=EQ3DUXBW7A2UOIbuTENnRZiraQQVZPOWKTe8Lir6WBZaNXMmklwNJwRGQVHMxCeOaQaO8kHjL2aDRACTwdm6Geps886KhNNwfKtLBFwPytj9Q8Mg4T1pY/AGEunS2a5Z5l+IU/LxCV/0k7+iPkYiNR3JzeBEjJYrfHRsYVLtXWYO9iMLHP3YByF367/bwPD9ifqioDG+7vAsNGgRE7F36bcMaQiKz260n/vn3ZDJnELrtMX+/bCBmbHJFN6G70728eS3WTofeiA2/SNa4z3BiIWY0GR99j27lNyYZXYykqphoMmZDCPbPGnMNQpGaAcruEGchkAK+W2QUtS6gqq+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbEuhZ4l6D+XHtmfmdnCsnXXBJH61z7aa2C+l7rqMzg=;
 b=CTCcxcoktg1eEPcaWHe1hXyCJypgBUjX4ed4eATY3z59sY0yitNKKPI3MowNvA1sAnPOYInNcmR8++e0YvgQTzL6xDc+REhV0uTAjrNPH99w+wo6SK/c+YgyY8wJi6U16XADBrIgHhWjinixtJ9DREtzXhfQsGXJ6Gxu+8BbaF4=
Received: from DS1PR03CA0002.namprd03.prod.outlook.com (2603:10b6:8:450::9) by
 MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 21:23:15 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:8:450:cafe::77) by DS1PR03CA0002.outlook.office365.com
 (2603:10b6:8:450::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:23:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:23:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 16:23:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.2
Date: Thu, 9 Jul 2026 17:23:03 -0400
Message-ID: <20260709212303.15913-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 706651d0-1af0-4816-fb4d-08dede0049b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ehs6Xh5mQ2qbXlUcQsX4xCHPChI5FeQU1WsQpt33eTDS7kCcwwctj9S5NUkCtUt+R1ErIkPN99EW8UuO5+Tu0WEM7/0FayogCN7ZjzmxQIJ1H8s+oq3UHcOJvfUEqs7QEMAg2vWlggzeOst0c4ehBZ3bbrRYExmHj8yXzTVlJbZA+TywNcNYgnb1RBMHx+XaqBMv5U19Wsvrm6K+88IZh/k/Z1C6XpiEiUvAN2RTyXgPxN5L8NrXCOKGSaFcs1cDhXyU9soAQUnW047s8EN36nKnSAQFI5dJkN8GXoe4vrzMmqEk9iS/eKvlZ6SVWyn96FkWUg060Tue2054IB2SW20K8CaRLXj7hRXjcGz++3eag27RqLtvG0fhzSwWT6/QZrIvJSnQnbnEXl1Gn8OHWrTRM9O3FnoKieJ9PlREoHckUrZ0+F6SaVDtXIcbvPT7ivhI+7b3u7Ny7RQBCI1s12Ktnob3M/lLqL4hMOlErnRXGrMloja69y/kIgo8G+Rpv/WIhu7w3RLzRrtlDXG1xqjaULPhc/W2rdtLKMg3a589XGKsiMGRpY6AROfgyTqqWMAqLW4G1cFGoTNvfqMwYuctjc3TM52gj92LZni2WFFv0X26f16qoUSTofv8ZaKW9KQDJbU/c45Fywm7b1UsNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 34cEVaaChiFy+ABYqNJZ1lIsMSODUc/n0LgzsY6yqXCVMv4NSHY9l2xqAgvQ5MnBIHmc6KwAvhRLArfLgVYsJY37IU6f8uoklbpSs97mzgA/pyU/HnbqKpS6g9Xx96S6B3vkQikSlttZpvIXi72QwS+CjSOhWi0WZ+7gAizBBb+fQhhG2mMuc5bqvxIWuxoX6VkBowwXMdl0/5q6oTVoM/GWg9KYlGYXuoTgIIFz78UMYQ7mxGtLlq/z5gZvHF8bwuWTenGNKbzqV+HJ8s+yqo/Fm6SRW10iCSot5EF25qiWJDVH4oIFuqzRedtvaVtzwaGAjXXXFxzQk5ubq2LSkuBM7ifMuidrACsqAZyJ+JHuZhBXGgOx10/5ymCLuMvLvElvAR+5aTv7bGsUpeNDEWmfD2pPFuXt0O0uLjbgQKCiMrmtViiXf35Qyy5ku1ga
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:23:15.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 706651d0-1af0-4816-fb4d-08dede0049b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849
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

Fixes for 7.2.

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-07-09

for you to fetch changes up to 47ea05f246bebc81c7796f56265cffd812cf0601:

  drm/amdkfd: Check bounds on CRIU restore queue type and mqd size (2026-07-08 16:46:53 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-07-09:

amdgpu:
- PSP 15.0.9 update
- SMU 15.0.9 update
- VCN 5.3 fix
- VI ASPM fix
- Userq fix
- lifetime fix for amdgpu_vm_get_task_info_pasid()
- Gfx10 fix
- SMU 14 fix

amdkfd:
- CRIU bounds checking fixes
- secondary context id fix
- Event bounds checking fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/gfx10: Program DB_RING_CONTROL

David Francis (4):
      drm/amdkfd: Check bounds on CRIU restore event id
      drm/amdkfd: Don't acquire buffers during CRIU queue restore.
      drm/amdkfd: Check bounds in allocate_event_notification_slot
      drm/amdkfd: Check bounds on CRIU restore queue type and mqd size

Jesse Zhang (1):
      drm/amdgpu: trigger GPU recovery when userq destroy fails to unmap a hung queue

Kanala Ramalingeswara Reddy (2):
      drm/amdgpu: add support for PSP version 15.0.9
      drm/amdgpu: add support for SMU version 15.0.9

Kenneth Feng (1):
      drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled

Shahyan Soltani (1):
      drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info_pasid()

Suresh Guttula (1):
      drm/amdgpu: Disable JDPG on VCN5_3

Yang Wang (1):
      drm/amd/pm: fix smu14 power limit range calculation

Zhu Lingshan (1):
      amdkfd: properly free secondary context id

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  9 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 25 ++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  9 ++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  6 ++++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  5 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 37 +++++++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  1 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 28 +++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |  1 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |  3 +-
 17 files changed, 94 insertions(+), 50 deletions(-)
