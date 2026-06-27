Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D22EC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95AF10F755;
	Sat, 27 Jun 2026 03:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fb7zSISk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D81410F751;
 Sat, 27 Jun 2026 03:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBhTOvZz+9sM7StEE8jBuCxdQAUuHSRvqAz+1m+fex6RprEi4dOCnHIB/VvaWQO4T0aWPqa+CVfZLX9EKPGcP0G8J9ExreBL+bSHPfNq/DjPXb7j3usCyMmNPgbHRY3DafUx01ybVzFJJ3py/hPQNd+YC5kBe0IKh8nubhlZj2hZXMw38x0R90bxzTBBjAVXbK0doyfDbN/dF0bd9aUUzEPHDEM+89kp50b4bU5kecrsihUS4qOzCF0Q2/EYFUOuEKrEDNlF8yNpBxlummvLmpT/nSSUwjz5NXI2hpWTWbkcv41kt7eK/YFFOM7J3EM9WZyh8HSriNBmiBI+t2ypiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZvoOaL9PS1Dcg65KRA9qq9b5kVN1mV50oqrVcM2DEY=;
 b=boET7hHCLW+Y4pgPBfGX70+yYs6f8SjKyv72g1LCwym5odSD0IuRlX6KXmH8eKq0wnxq2+FvX7hotV2h5s9HIhYuxNq2VgRMBLjw7LS7+bonxdGdJamY/zw8JO+dt07WZYVIS7EdolWd16IkUzsd2I1/rhi3ysTN247jt6qynIyWQNeGGPen4/gV7ia0GrrYZYM+EdtcGRnq/rD/3VIHEsFjmQHhw/PotaefpJKynjweLtXm+hsNeCjc8FJfXjAQS6L2rgIZDPbd3qhF/mc7bEeZXjyWbt5J2KkZ9uPuhObww9gQ0JJuVAmHWT3JiNawuF9ASrhn2cwL6Ki+swQUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZvoOaL9PS1Dcg65KRA9qq9b5kVN1mV50oqrVcM2DEY=;
 b=Fb7zSISkQtGvJ+j8zQ8ZpXlzjoGrIm2wtl9Gmc6YeYwOAvBb7KvV5vP0KfH4ysR+mKmIn61BxLWRpza2riAVL4WxhEqaQV/1XS9cjUhq3Q4D9UPEUbrDWYXepWgmUsRXvOJmNwtxxlnFkTn1qRhsNXE6EuhyDQzPNskHTf+VDHQ=
Received: from IA4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::14)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 03:33:44 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::62) by IA4P221CA0011.outlook.office365.com
 (2603:10b6:208:559::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 03:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 03:33:44 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 22:33:40 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>
CC: <Ray.Huang@amd.com>, <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH 0/2] drm/gpusvm: fix IOVA unmap path in
 __drm_gpusvm_unmap_pages()
Date: Sat, 27 Jun 2026 11:33:23 +0800
Message-ID: <20260627033325.3795298-1-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 215bf788-2e70-44ff-8e87-08ded3fce3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jiJJLN3RaawwC6xZ8wB18rORAiYYvLscL/0ElzxYMerWtF+3gHexvvDZ+AdQOp8pcVysVaNdLd5dhuUyJpxs0t6VmucOnipa5MlHqxPPZn4XB5jlYamyONWL5f8v0Vu9gMt3fyowAYcZJ0wggrXq64aH3wxF1ooPAsQFEXP/hjiMrMz60TE8waB8tLJxfaFlmt+ixX+ApkcFXiDaFFdCnvtdGNQaNIfR2dNfU/GkgdFoP+7uQKhU11m571mEHCq3QBBf0bQT2tywLFNxfKnlwJmbwLc4x4L7GWqmEgJODVJEt8BMZr69Q/LcrkXjBcvpmF5N3npWfy/ehhdvDVbJP3e7GGj3dT1hY53TzdTMqva0ycu1sM/g1RHlw9mLJV3scqvhC5/pgWLPryC39EaO++iFIgULwR9T2LhLmVvYV8ogISwsA4W+disdKA/1ny7iZ9QaFIliLwr30qnmOlWmdGkmQbQE+JtHP03QDtfBcKUr1BJwmKr5+6tPuQZhR9PlTZAPXQ/YthuphE9p+BH+YHCaa1C8zG3e7z5FHO+PlQNPJ7SL1GZppe2Q567WTPBPRdGDhBUFmcNctfjlyZAKMNX4CjqWXFyCJHNi6EqtdIqt65vkaK6SvRpOb1axRybQYOUQUrbpEOjV0aTQUB69r6lkLNrTCgf4KY10EIbUrrbyXhVUzX/B9w1YNUH4T9eAAYa5tnx1V3pKdxojOQFwpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nu8MAt6BPPbWvgCRoD7d2szjts+dK6Z5RkWoEc10gRFfp8/Tbq9pdMTXFprlUFCCRF8AhJvuY4sQBVaQYEvspsSU4Axs3u7j2v3hfbJ/8GfGYSKkw/jW58c1T+jWODRIAr9ld3rfa2GVbopGpOSxPx6HRaOI2ppggz/8gnzhjW8ELke61IHHFVDIbRkOtJpU7NzSGGDrl5RnQG48XZsHscB16mDfMVMyBC5tG3oMEWEB8i4hzU7ybVTs45v38nbaRgAUXk8oBttd8hnJojI6iYRUWVTr55/vw5BAqauZqCZGkvMhWnrguKwY8oLsIbDD4SbMLV7UZKZ8tywa9cRFD+hvKWDEMcknhUEf061sA70DVBb8y9275Xk0f4zhl7xlmxoWjWG7VYgSMk9+ozmk6IZ+wCaDhjICf8uf1BG0uDgVve/ImKnI3HjdZWyHBMsb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 03:33:44.0140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215bf788-2e70-44ff-8e87-08ded3fce3d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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

Two small fixes for the IOVA unmap path in __drm_gpusvm_unmap_pages(),
both spotted by AI review:

  - Avoid reading dma_addr[0].dir when no pages were mapped (the
    get_pages() error path can reach unmap with npages == 0 and an
    uninitialised dma_addr array). Use a zeroing allocator and guard the
    direction argument with npages.
  - Do not route system pages to the device_unmap() callback on the IOVA
    path. Branch off addr->proto so system pages only get an explicit
    dma_unmap_page() in the non IOVA case, and only real device pages
    reach device_unmap().

Honglei Huang (2):
  drm/gpusvm: avoid reading uninitialized dma_addr[0].dir on IOVA unmap
  drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap

 drivers/gpu/drm/drm_gpusvm.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
2.34.1

