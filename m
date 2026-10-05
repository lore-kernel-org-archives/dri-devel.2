Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90590CA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CE910EE4D;
	Mon,  5 Oct 2026 19:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BaNVPU7D";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8CC10EE45;
 Mon,  5 Oct 2026 19:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFRAqmfbIuTgm6a7pXYVCN5odF30rLSLzPsbDBDz1azFrx1vyvBaIJkwgPK1huMQhZpTOdMeJTDj38eeC34pbXsd9JdWa6aWUFoy3c+OAeZJLt0RKNVSPoIAsYCx4Vtw8TMRwdcMF4eMkNzn7EzluE7JMDnKYs0XD0pM4E75j4oVhTT06MKRrU70u3lHYI8fQ/GlAmbfsg4S4g2KNcYkoiKVzTRzKsAaaiAcpdloPd+BL3J6KZG4ofFUz5ZM+nasjmA4aqoEtU7m/qhzHnGrEc3ipjZx5TDJdiFTC63ny7nk5cefsSEw+17iaprWx5ZnkXGWQ2tdozCtJNJ1VDE2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6ZeaqVQztOir/axa6IcUCYnsEghRSzEtQLUfH4qmTQ=;
 b=adCeJ/ad1l90vwPXUp3GtFb3HSHV6l0ic5ceKyCvdj1vADzaagvb1fZrZw8MfdhKr6eecf2a5ZkDjvGqmcnziVXya1PEn8KgR2tWlPv6TjSaWG8toZMWOVpg+0ut6pf4DK7Asz4rMMmyIlNQSeDSjYZmzvbZ8tpJcsGg74K+R3XADoV5BxK2HX/GIvF0Ly77kszS6GbkzbPL7BUe2fN3T4GxKkKwzILW66ORCYxGEptqy3e3C/aXwhEhM9hIyB+LJJdkCPOLJTLmZ3unpCljiZ5deiac0DobdBoxhQ08Q1fPVjuST6KkfIn6AZ+jHzALMIA4/duNURZKanq7mD/b0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6ZeaqVQztOir/axa6IcUCYnsEghRSzEtQLUfH4qmTQ=;
 b=BaNVPU7DZo32BjGxv+ZTWQAAhNP3OxQkSVSc2EXgD5lnXh5jxlF8kAia4I1Gvf7eiGXn93IVUADvC4xj32PW41QvuVrAkrFI8wFtekVKkO7GMH5cbxTXriC+jMVg0dOHMmxFAZfPi7JtVmziGY1czTUdbxb2VTrqcTfOqGhXoVI=
Received: from DM6PR04CA0020.namprd04.prod.outlook.com (2603:10b6:5:334::25)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:46:00 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::74) by DM6PR04CA0020.outlook.office365.com
 (2603:10b6:5:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:45:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:45:59 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 14:45:57 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Curtis Vogt
 <curtis.vogt@gmail.com>
Subject: [PATCH v2 0/2] drm/edid: Honor overrides when DDC is unresponsive
Date: Mon, 5 Oct 2026 14:45:44 -0500
Message-ID: <20261005194546.1712792-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2654ed1b-4ee8-42e8-366c-08df231947ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: Jb8AKWXBWXTL702xCjc18klqd4hXCu2hvtq+suPyv3D9lT2WH1WMgjm9mTuaz9IYexFd6YaO/IsmVt2U58Uap7vjOymi+CbYFNP8F2juDo2OSReDB/7j6KaLZcr0vJQzQ4B04tE0m9BuafTvEIkNnX61qhRrjjbCpNKE/lLZBURwJf/gJ1rubwCDCshmZsjfOuMwvQRW0OyeRLlDvNYXUbB3usXhqv4H7oNUTStlmUGmWk/n7ARSqsEfiiO7gwoRo3qT1RKsEO5QpZfI9pCAdoWXoZnPgHNGxuNhOk4DZ+i6RtxwBIXvI9bZT2s9k3xjGWsWlxgmXr8qFKUimygriQ096Fshi41TbbyF3kO8es0s+d3avb8Xfo57EbZZr1a+2kC3bPlTa4PYHn5Wcbg28hh/iCd13moOlQATdErME1cUcpXQ9KzO3ROvrE3HLRDIAXyd+bX2kntBuZyTtkKy/gHrhLaFzUQN90lDex/LNEHOUuesU15rYNhGtW2nsOnkmzmsLGEnily+A30687H2eP7RVAM8jstOY64PKoTSYzKcNkiPVSRBbv/V4g+ba6kRgbzDgn3YGxsv4k4R5rJKRevZp2sHSI1Vcnt1pjSV+SH+d1wf6JrsjyVVP28Ppj2tUEzK3fe2IqogDNbd5/7MixyiwGz295mFnN5CiD3ZktSlF0cSw5JgK18+c718v/rDdmj7G3Mb/YnXF3FK5zNCKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BQ15jzib5cnouwYbWKqk2+m8LFcDSdFBvqzIv7UdnrGy4U8vLBRWHkBTKd+h9PN81GQvG7daaVfN5cMJDbwnX+M5nnkJHCbh/lzXfqujX54bG2pK4LYGGcci6Dq/CStQtNcoKjp8s9IiQEbXlxYFpwlDMA1gCReyWqVIlxTw1NnEBCWJ0jAlach4tMem6sJIH3QWOMj97VDjmPQSLa+xozHTiRvAyt9JJO6o7MOOFmYabeZEtMioyatxDP/ZQWVJBjfZNh23LGQXGt+m/y5SmrbVPyUdDs8TPP7ijjkQaon1xcP1W3FrE42yxlZJdfhLSmSNMiGnK1lvdu9mSLdHa2YwBS2CO3C4Gl8ibb6f5R2EGLa5FRVwKnwYELPvKp9LFanSe2mAevtg9om+ku3HCL/XUTfDnWdJx0VsGm62vKpOHLUoCAgitg3AtHONPcXW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:45:59.2846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2654ed1b-4ee8-42e8-366c-08df231947ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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

DRM's EDID helpers probe DDC before consulting debugfs or firmware
overrides. This prevents drivers with independent presence detection from
using an override when a connected sink stops responding over DDC.

Add an optional connector-specific DDC probe callback and use AMD Display
Core's existing connection state so EDID overrides remain handled through
the unified DRM core path.

v1->v2:
- Replace the override-only EDID reader with a connector callback, as
  suggested by Jani.
- Keep override and firmware EDID handling entirely within DRM core.

Cc: Curtis Vogt <curtis.vogt@gmail.com>
Mario Limonciello (2):
  drm/edid: Add a connector-specific DDC probe callback
  drm/amd/display: Honor EDID overrides for connected sinks

 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c |  8 ++++++++
 drivers/gpu/drm/drm_edid.c                      | 15 +++++++++++++--
 include/drm/drm_connector.h                     | 17 +++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0

