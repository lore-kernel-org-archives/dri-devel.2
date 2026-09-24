Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EE7C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5147F10F4E0;
	Thu, 24 Sep 2026 12:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U7kk/1tn";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D5910F4DE;
 Thu, 24 Sep 2026 12:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJUoo4rxepl//PY+da6SkitsPdQVrMlC1WPqmSgM0RFBJddL12nLhzkhz4F7lpW2KWD8w5sAZ41xRn0pP8ph6t8sgu/oICfoOqksoP5a0rcINS5JX4YcmE0wrMeYZAjcP8AcKkzR53ORXhD668XsISYSfWbaT4mQwu4xXynfsEcU2N58oWCdpx4mFnQnuw0yeW1cmaGL/JegCK8ifmLMwa/LPEdEh8F0LY4vkVYRF2QlYZczZIFHuufht0x8pmFrWIyi6hjCLHDN6qmiWppsWSPvGMPEEbHITrZq0DFSPIdKJ3NqxXXBEOG+d7M89SRy+ncjMr5B9331D8HbyHuS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txaloN1Z9Ghcn0YjkxYTVYPOPU0NtdrX7vpew3AfOQE=;
 b=S2gucFvyCyPAEjMsHjlRNqthRpmqncVFUlPHOgTv8xN/uNLnVL3WqZa94Uex6x3fFAQMRULdMpPc8kI6SScikx0cokTAKEHWX3lMwowiIRK4wux6fSNlJ/oYZMOurUe7OqCUgJCoiEfElv++Y3tyrkZgfC3hvDw/ICMboTXNDdB+QhDivpAbri3dG6X+oYIoFUDPMQ+jiX3PnWqU34TbUqRz+q5QDLdNY5Ry84nz/7eXfyovARbCyL0SstQwGOSR1YIL8pVJoveJLOMyzPubYOlBZiZ6tKYOqrE1hsL3cxuA/Y9kiZrd3o/ni+D4GMazqle2QuDng86Eo4EZA9j58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txaloN1Z9Ghcn0YjkxYTVYPOPU0NtdrX7vpew3AfOQE=;
 b=U7kk/1tnHoHu8fO3z8gJlFcWMmjp6qpaEasZHdPAUpZHGfXQa5SjqJo8nbKVZ+SXnTC8pXlxbulRLlKMeKA6lvZkmxD8+YO6tJYtopZC+CWIkIgHr2Na6thCFKSpYb9fjBn/uh5Fi9hnbfV+nMRSHpDpWiifBfghq/XkRYxcmks=
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:43:53 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::70) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Thu, 24
 Sep 2026 12:43:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 12:43:53 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 24 Sep 2026 07:43:50 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] drm/amdgpu: implement workaround for sdma dcc corruption
Date: Thu, 24 Sep 2026 14:43:18 +0200
Message-ID: <20260924124319.1895-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: b37fb9a4-2e62-4bfa-7abd-08df1a397db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|13003099007|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: JbHbTKU2U1idY1h/FvLPyflHl4ct2bAseyq3OlDIf9y6HJe5HxbPv/oIO4B4o3hq+uj4uAgJNBH2GxsY0fM9VSVZYtLt0hyoE6sdmXx6E08ZvkblrFSSRzmN72AWPveqV1zQ2N0nqBR9PxkxtLqZXVpV3r9U8cWj4rgKiUOhQk6a6bRL2bBkKL1NbuamCBVN5vpzsGPM9euajlvfYSCeSkMnt6xekUn2QAeSlA0/5YzAIsvtjmqY/gb3g3VCoxaBt10Q79+Uk/Sn45N+YtdhIlnj1J+ZUZ0kSc3x8sOCacZYB0z9PpEOTwcsZbO27EDqVEeD+pd6zK+AbwXgAxEBxmQL4jpprgzp1vLpjRYj0uceqeuyOuPWAFSF0GVj4vThdjuOxC201IZS/nQUmFcVDRa/onltVCmU/RE7VByJPVzTIzxp7Iv/zfDfHMfddmRY15MByQTtv4CV2esRXNRc0q80Qg8kd2Mce1wFeER60wdHmfD57hCScF/AQiM4upqSkg15mD23Y8OJ8quwgoG0K2H0561Mj7f3bb2+NDW4yhoWVZWnyYvggs6s8BnbLi0I2U5gzbBu6DSC34ZREhwbszIdWxQo+AECE2f3+BQ7x1u5/AG3kGmYLneuUf5rc6CvyYsNM+bd/0GfjCS1VKrrbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d0bUQqMzgdCtYekRDIPga7H9qdPnEfQfiiF4hOzU21RIgTMzC4O93SdcYVa7iDblScsF1u72cK6LZghQaIralV32x/GgdVllv+F6NapicT/bmE2O505biIRqkwZtTRFcCwDD3O6QEftgIZ7sU1V6ax6mTqoW5H5N4eodgVbN1nNTPduwM3FfYDDw+UBHc4+Hbsx0fwUxR4Tv9qoPFssCsyZA5GjBUuvWPmIjLyO8V5jcTG+N8COMBgLgUvZSPtN/dgwYlVJl8IhAVdj1oCPtstDHXNcwwbrL8UhHY53Do9enRSw8OdH9XNW8zTiD1VcPrBzEvuof7kSgOJmRyIajzVDZO/ziEGWfUcVrDYHgCA2wWJ2vdSmmqvWB5PrxT0JzdXbM4N8abZD60dmdUPL8LIEzSWyI89P3SvFmC10LJ37LADsuv3q8b0vehAAcJgtW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:43:53.2737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37fb9a4-2e62-4bfa-7abd-08df1a397db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774
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

For unknown reasons, on gfx12 using multiple entities can causes
random corruption of BOs with DCC.
This workaround seems to prevent the issue until the root cause
is understood and fixed.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5663
Fixes: 3a6f6eeb3db5 ("drm/amdgpu: give ttm entities access to all the sdma scheds")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d620ec2937f..a826e091ea58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2392,6 +2392,11 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
 
 	num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
 	num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
+        /* TODO: workaround for DCC corruption when moving BOs from multiple queues at
+         * the same time: use a single queue until the root cause is identified and fixed.
+         */
+	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, SDMA0_HWIP, 0)) == 7)
+		num_move_entities = 1;
 
 	adev->mman.clear_entities = kcalloc(num_clear_entities,
 						sizeof(struct amdgpu_ttm_buffer_entity),
-- 
2.43.0

