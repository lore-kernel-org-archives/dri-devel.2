Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AC6C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAB610F3A5;
	Fri, 31 Jul 2026 18:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0hH9jI1m";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A2810F391;
 Fri, 31 Jul 2026 18:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAk2F4SsQnGAydaoVCOy4jAJXDXTwaDMnPnA/eICYrt8kECPEPHf4Yb4Kext3/OPB2cLoqSQLKgpkNlEnh1mIWAmUb1aSLCIUT8bGUWrGZSFso/gKu9oJfQbjUqlzze8E48wCfoXr11NSPRLNgLPiogXU831b9uHm917vl0O2s5y5ok/c8wZG4x0AFlGCeKPpjxJi3IVRs7MGdG/LJr9SSIklVtraOJLQ5UHcsD60hmXGErfFkqJhmr/VNiAy0pFoD38JBIIY/qbIlmn4WDcrLWEncPSpf/OmHRmkGDt/fubjmNfOF851V3BQxBHm2kkRt/5v3JYiNsDI0Uqh5TsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO8IosRzYhNZ1Gukv51gmUdHlkuMUu4ql+8VgJTgrKU=;
 b=PZpFjQSVcQhIhBn4a6cnZh0ZAPKbe2isET5/RN9orkXGuBUsdayrGYAT6oMzfTLOt1QToA8wkDIH9sW7sV7w8QBgY4pZrSNZxsWPJeFSEP6tBSlvhsj06Jt1TOqndiXrDrzjYhdPs1vh+gIliECC5Ck4yKbVGu1EbmhAdaEJWm0xYrOtS/Ey4LS2ekdprLfh0VOL0aAKjoSAczLjLIyfTBhGQZQMz/K6VV4hzfLluYRmpj3LYXXld3XWhK5CKBluUUrSWdDB5IRXzVc1F7eq/anD75WO5LhTAKaHP7sm/Vxrt1s2Zyg3vSfUO7OvkBsP85arjMPL00agG5n0zw5zxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO8IosRzYhNZ1Gukv51gmUdHlkuMUu4ql+8VgJTgrKU=;
 b=0hH9jI1mYVQdZkvgXt50u8sgZaJZzLMuak6WjGVRy3JjzwQf8kY/TpVjdsWs4j+PSCgdYZzx4eS/YO7qpDdegrroTdKwHuXRWK3EAW2JXUXDWqknxR32e54Mm0i4TtOSnLvmlilyCHFT2rh9aM6DUMmZXFSg4BDSGVIvfmV1sII=
Received: from MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:15:35 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::8) by MN2PR05CA0049.outlook.office365.com
 (2603:10b6:208:236::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.11 via Frontend Transport; Fri,
 31 Jul 2026 18:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:32 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:32 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 09/10] drm/amd/display: Set color_space to plane_infos
Date: Fri, 31 Jul 2026 14:15:20 -0400
Message-ID: <20260731181521.681990-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 5625be4f-b704-46de-c4d0-08deef2fb746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lur+k/3W/sLLqHTtlMvNypshJcGNf2IQi2BWVCJ+L/Gy5jP0QglTG+LvgWLFYlowSF7dEfsTyfqyb7b4fNRlc5k/WjbmHgW6k9za91WP0URM4mwCIRmz25eO+9nxBW+S+/X0gtIKoQrNtLgLEwSykGQ3UhXQWXg557zXm6quEthEmsoBBcEGavcWJzVOxuEe5rJetliZkKo/5dtsqxP3qUN43SIzW2H1imoKALjdpqFVmhBStleHmmLvIx1rsfbTCFeI1dt0AvKDC9gz1TvwwUjodwZJCJaM9A6pKmmQuqmZL+IVcQU/rnuu6nTHpglzqmg8FT9axpEaSWt0sEhYt6hHW7bSWJJFvM0iQ/nNGvYBHHXyUfsnVdszkg0eWS4t5JE8ixeiBJ37pi3BGXvuN2ONtVxLm0NdVZAzBWl+3pBzaejTzx4rBPvyq8C8qZnbx/yMI6YxUQRBziSOUgvU3RGm209xtfGVqXZ2qYsyouT/qHKeFk6Wd83A4GWrVl9YYptqivsmnpBSbXtLZWOdEKyVinQFPzBLnZeosDW3EiYTb1bT4pX+zyadeqb6HrnK9ZxfvjQyBrsIV9dk3vIXohxRw+gRY8vAvPow1X83/f/Oe+pmtS+B3TNTSlqA/QzwLxFoCU/4Xmy42ZqHQHYbmOriiX9n20FiJ6WazYZfgWxzfrv4oCn/M/kIhgKLeWvXnzKyEu4K5EmcsyKoqcBIjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kQ/DqJpuxqf8v9jmANE2OM2fTSp1epKsKaHYBsLt3u95VdamDFH9gzqSeGVLLbUeQeLhno3VQJ1OK+w/VWat7J62dUCB/kYe8QBj8F7ulABRHkI7Gp0AMy0fAuuz8/W/h55V3iRAEz1HAwpdx4R5eYH0lgmfvZuhVeA+dg0bqegbEGE/qKT4XMnlTg3YVwxZiZGv87Sfi1vBhVZKKEUnjNlupI9rti2CQbRnJ4YmkdFnq+JfvH8dQggaQqinrnB7otL828GT6Ds/c7yGNREfWnhuJpd/7uX+kTGtnJ0Z7002sjrmljkFlqxQ430Dz+wUnJH2vYurlZ73t3Y2xAg8OCOeq/B5AaCF4bu5ZwMC4ZyUI0Nr4Cyx0LC78oDTtu3QEaxmPGRg9nJeBYsjtIcN8vivgcs893ZkuJpSrib8vXfznOYv+1POrKvlcj8B8CTo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:35.0132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5625be4f-b704-46de-c4d0-08deef2fb746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

DC looks at plane_info structs.

For legacy drm_plane COLOR_ENCODING and COLOR_RANGE this was
done in fill_dc_plane_info_and_addr's call to
fill_plane_color_attributes.

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b7d815997753..f5515ba64ca0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4234,6 +4234,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
 
+		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
+
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
-- 
2.55.0

