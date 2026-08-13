Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AB8C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B65B10F447;
	Thu, 13 Aug 2026 17:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLk41OEN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DC610F447;
 Thu, 13 Aug 2026 17:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSnxl5krt6aT7ZA7/9yu9HE0iUD07sGGU4Bj5rX9W/i5sZNwS7XiZN4KOKezeXLtq8C8rOGFJS755czsMJ5BWl+Hyd+MboFUdc4QbRhm6bqWPTjl84hLJIWh7RcAa3h11oVPh+J4S03/ZiF0dCMYRO1Vv2wLZcbGpmj3W3XLSROm1wpE2GrXW466N0A+vA2DhplGUmssTZT3XkaSupberc+Na6yOD1EwQMxIzilqY29Hh1ZioSVnbiXlNpJCw2uu44nOPyS8fkG5LN5yrg5G2uNt7CEnuqL6Iliz7bKrmjhA8W/ph1VL504rZ5EcjqB6/PSoeFPVmUes6PbM9BM+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEs//MTsU3XWZPySmch0+tUrpSCC6yAjAQ0VX52Pom4=;
 b=WtWni8Zwhrn7aexZA+DXDNnYzZJJ/bNBlRLSiL/1r0mpp25ogsSk/GdphQv0oGuNTyeQLrN3DTbvb4Jjvwe3eN/GpDorvqv9MWspFP3m2hPjwp5xyp2GdRHS/3il/qsQL4Viwy1SzHdR33+pRpCVEY2AZrWMYStK34ijWK6UOUzGRpYa50HjzsQqxu5/88S2KnoDi4Q5MFfR1IIaDlyKQFk0ThqR155LlSNnZGHyTNCjwoxy7XX8UPqENDsCgnqgGFXubfmZl3Rq+Gnwy6I6K3ctfEd+de+UsxEysIbbKCsQif6BG/IphCnzkDtSFgqjJv9y8UCfjYrCTo+Ksfkclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEs//MTsU3XWZPySmch0+tUrpSCC6yAjAQ0VX52Pom4=;
 b=VLk41OENB2BiBWUHoW9OA/zP3/KEQTZrmtriOutRZXYqJYWeMoGyOqMN+cEgH6kKAdrfkDdwa7C8KnDdn5/rTI2okBEn1EO2C94ejLGjXeORspyGQSSwsIGWIO3xyLjk1l+bTRmXAzgZrksBMuwsB8dvO2fJwzPRRRYe7jIeqHk=
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 17:08:30 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::2b) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 17:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:08:30 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 12:08:28 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] drm/amdgpu: skip amdgpu_gmc_flush_gpu_tlb_pasid if
 device is wedged
Date: Thu, 13 Aug 2026 19:07:02 +0200
Message-ID: <20260813170705.15745-5-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 291dccd2-df8f-45fe-809e-08def95d7fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Hqv2h/cGsKOU5o2qExn7ws+sz5v5XfpdoibBc1dknvKW35qVKBV3xg5IuTPL422/45HB0XHiia4rJb5ObYBNeOch0OzQl4mBd7bzcaFDhArr+2YQjjdal0sOkH0xi6Qas+PKwoJzfHQl0xQneJfWbd2fpSX0ipMxLlOOfRBI5Pb7+n0iRPVOSOu0LGb3Za4qLVIbjt3oiWHSZodo1SfBkVG2e5Fy2A+GSB7wfxHJALU4nCWeeZ1ZkGUlM68aGp1a5DCQCHqYDe6FdGqe11P+8pbAIaHYHBMzUFNq7rncrT0hezImuDlnjohyA9QRQD7fEfAxn/0HxjnsjmYrUjzPOUlsolY1Y7wbGrVggivib0M2aYHxG0AMdA4b4orMX9d7e/Ej6pZbyFcbxXxYHP55SZoACpKeWjK4yokw8yVZ2t/D4dFEIcTMHgk2oiA8zT9oXPWxHMle75zP6E3RHPumm99OqHELvyZccU3DGoBkoNCPBj8/nOrIbfUXotlLZ4MV5fKEPxIPiSjEzuJ854R7fgusXBR0/eGwSzVZNvgbjyLztPnyMiJBTCGMq3SNL7rqiKrIQXt7RfEJiFCtdcMSdqCJRxxKXWSshcNgrRLkmrBM6kq6qAXsT23Nz8CDURZ+ALRKSd7CNVvBxd/ppZcSOF+3xU67U7bMUYKfbeUi3x7DvtpScJeXygcbE7XUCo2QPsuPkx76nT86LZMnz6cBKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vi975aL7kZF3mE1lAilwacji9CqmVNSy37sJqUAOZffwLyZCP5XZicS8I2ZI81HTReDMBn7qbIbLK3bFRdM7p622E1eNDsovE6VNVbF2r3ESdLksv4Dcr2nHvPPXhqbyEOVwL5r0/6O1CyH5xjDgwlaicWHtiyoxpWMNHoG1dhZxRqX2RFzsKklYvpHOcyGGjNnB5NZ0mFLJbcxyhHB60ylGJDu02KubHEX43o+Nyc+albsDr4Brzza9QH5uqTNCFeEsvL4ksYIU082/oRteTib7Dkl4eBNjKAmoEsLtoo9c8wPek7IrTlNZqUYpl6hhE1ElcWObfZFsVGJ8ct8DjTRTsSkXkBaAIq5dWOOb51NeOu5obE6+aB1g98LsybcO50ArNq31n4EROAhvMC3jSyKmgFD/7zzjzk44/Bq85diOJEaPCM6pcW/tHLmAWttN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:08:30.6112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291dccd2-df8f-45fe-809e-08def95d7fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
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

Otherwise it'll fail with: "failed to reg_write_reg_wait" and we're
going to fill the MES buffer which will prevent the reset to succeed.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f43d85ba4b78..c33320a6413e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -786,6 +786,9 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	int r, cnt = 0;
 	uint32_t seq;
 
+	if (amdgpu_device_is_wedged(adev))
+		return -ENODEV;
+
 	/*
 	 * A GPU reset should flush all TLBs anyway, so no need to do
 	 * this while one is ongoing.
-- 
2.43.0

