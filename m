Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194FDCA6011
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C37A10E103;
	Thu,  8 Oct 2026 17:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VrTKzL0R";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A98110E103;
 Thu,  8 Oct 2026 17:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niZivirqDBFAitFEilDpohViXwKYis6cF75pFjtZ/h/zjD6dhg/toZz+JKTUoa6R560+gQwj66WGek3FAFwGc9Mo4n2P4yEWBmjJAisu2EhnEbyJVlET/8yLKaTCSmmAfXGaj5WnqbyzpDvPnChtDhptKt4+O3UVRDoibSsBjm8EJXQysUw1JFfr1mwhz27xiw/NS1YCMsC8HJ0TxUeJZNNO300MpS4R6g8asxHHS+ks2mDyKSIjl+a99J135n0rneh5mxSMk/iZO47WOGABq/I4G9utawu/oDZ4NXoXytN9FMGjiC/XwiDWwH26AmAZk45IsnGQIv+4waxr7OMSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoJMnXH+jkaBvwHeUc46+tCUZ7fVAzzWCMso6WTfXps=;
 b=oFEjyzn4W5ff+wDZJQSpybonnSJBe9aFL8teyXeIy/zyWDYxpA9uosT/pE/d1eE/RGpsNmJcHr02MW6qi/LJV7ec+/4yeRze4yBr6a/dC9ONisMQ4L1nei8Wnix0QEY8UwrBPeozFH6KSV8ADpsoONWX+P/wNeyL6yKjBYQESjKuquMvfC6Rm13bveoOD499uV9o2ixSrBPObKnlSh3mwfBIyhscoBIKrbBjuVhQMOpg/WcOWskAnoSZTC9uBiBcqv38JoI1DkH+Ed0WWlC+JitZynaWt9G+UqZmHCdLzls3GoxfO6d9icw5EegSVp1rf8SuLyNm3bNkGh1XialfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoJMnXH+jkaBvwHeUc46+tCUZ7fVAzzWCMso6WTfXps=;
 b=VrTKzL0R/l9IwZMzpAcrRHzisjC/5H156VZOX5NGfI2WqAKwhs2rnVxcwNNDqlYsfyEX63dVLtD6wsXB8ukEcpJ0H70S1IHBtqNAntp4UK6WUI37r5AztXHtSyd9ckelp8++LOC3qCNca6hBlfaxeyNWSo9zipQZqaD1a9K9haU=
Received: from SJ0PR13CA0052.namprd13.prod.outlook.com (2603:10b6:a03:2c2::27)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 17:47:12 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::5e) by SJ0PR13CA0052.outlook.office365.com
 (2603:10b6:a03:2c2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 8
 Oct 2026 17:47:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:47:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 12:47:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 12:47:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.3
Date: Thu, 8 Oct 2026 13:46:58 -0400
Message-ID: <20261008174658.2506431-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b3d5ed-ecc7-4de1-6826-08df25642ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|10067099003|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZGCtwgicHHL/py5aEQ2jPsN+rfbqoMsMNGwpBy8J7/zozxAhpxNl6scOunM3SUWax6ivNofEEs/5I4N3f1A3+0nSvu4lohjNZgrjPqvADFZOAXfj+PYVfloVCwWLu3WCkqp+fSX/g1+I6opIvWDtGDYQ/WHUdRKbXK5jXl8jVZX4uSqv5cyOoeNgONmoX88HvVwmbjeLGVS1KcjW/ZXOzGPmk6zxvKgKdGLGDzjNwZOPci9eFq6zXgBsPw+aLAl9NO6XIwrRLTrAGp/A0eGAouBOLD5dMYVRqdj4csoAyY7utkAKXwEPBGHKsWrgOwilDqI9GOgoDNhDb8Pd7Pc7/WZhK1HPz9LWhlWokRb+OM6LqqTo4WYd7lH96KULjSafCVhOlU9gnQT6KKfbvLlhoPvbKs6WtGGH1ruMqoIei9CMWZuiFJwTdHOQNwsvWZnxRxhxnNrfQTgnaL2oG4BffdMcf82JJeDGWvZbEZHTZaxBL6vGX4w+jp3YFyoEQIuIh9aHOy8JDjySg7lh02h+yIdwUGMongCAdkovzJWaHMexLTaVQWk2eKAsyafrD0RkTqhZDIYGz0SF2k2VDTGaXaus5jnaoFXb2wuCVt81yfQYwRmAyIfnQ3AJa6Jq7Tq5WajkkUDIqoXrZiaKGWxpAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(10067099003)(13003099007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YHZqbGMpHledWKTehyUZswPKXR7rGDds+NaCnetNpwOatGvAow+/zMn9BO0N2yZBRsokjjd6YZ69wbDumYTlQMtUKmhV2kPblG4M9/hpstYd+BB6zYhKKcVf23fgnyifTUt7++2AgAmmkOlob2E+vP5frh7+12NBSuAK4MGYcDW2t0iLf0ii+J03WSe4n9ni/1xYaATRYL8XHj+LPbjVIqVWalZ4Bg605++kXplND4iITQutLmX8l8zfqPHOhR6o2SSAW4dWRWSve5JmDiGInWigQRar4wlxCwtzD7DPpBOSpMylfNiljvSz8cfKUHG4kErTyMFyBVgqcT11pzOLXyWcEAdvK7z2tDk/V1G+DmlRaUxmivTVy3BsvxWeCyaoqT0d0A8XdkQFaHcAcjQg8gtQ+cT/hDuluhPjmJhvXd51rfZo3KpNzbRawsSXd01m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:47:12.0970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b3d5ed-ecc7-4de1-6826-08df25642ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

The following changes since commit 5da1129613f27b5fdf7f3a47235e0fae71fa99ef:

  Merge tag 'drm-misc-fixes-2026-10-01' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes (2026-10-07 21:28:21 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.3-2026-10-08

for you to fetch changes up to c7f44ec5c4ec760e74351f1843dcb8322f67cbf6:

  drm/amdgpu: make Mac FB workaround generic (2026-10-07 13:14:55 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.3-2026-10-08:

amdgpu:
- Fix direct scanout alpha on some DRM_FORMATs
- UserQ fixes
- Fix tearing flips with PSR
- GPU reset vblank fix
- Debugfs register interface fix
- Fix display mode patching
- Expand Mac reserved memory workaround

amdkfd:
- SDMA doorbell fix
- Fix dma-buf reference leak in error path

----------------------------------------------------------------
Adrian Betschart (1):
      drm/amd/display: Don't replace a sink mode that shares the native totals

Alex Deucher (1):
      drm/amdgpu: make Mac FB workaround generic

Haojie Li (1):
      drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info

Jesse Zhang (2):
      drm/amdgpu/userq: only accept doorbell BOs as queue doorbell
      drm/amdgpu/userq: return the memdup_user() error for the user MQD

Leo Li (2):
      drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs
      drm/amd/display: disable self-refresh on tearing flips

Mikhail Gavrilov (1):
      drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks

Saleel Kudchadker (1):
      drm/amdkfd: align SDMA doorbell base for shader doorbell writes

Vitaly Prosyak (1):
      drm/amdgpu: serialize vblank counter reads against GPU reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 77 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            | 17 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 13 +++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  9 +--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 32 +++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  7 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 19 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 20 +-----
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 42 ++++++++++++
 12 files changed, 180 insertions(+), 76 deletions(-)
