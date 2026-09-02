Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860EAC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF94F10F30D;
	Wed,  2 Sep 2026 18:10:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FA6urU45";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7126910F30D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 18:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfDTyhS0QQqZscR0B80Vor7j4b6Mht7NibiO+qJETyoTJtG9k14XSmH9bs8/oIDagDdi7zKgqqPOOGVoGqbO/Fa9oxf04l+AIC92djcOMmS6088zkRBcNsZqn9Br13XUPZEiCP7qUmfk6sJJuTEpxLHiO/kRRQ+/CR5PBv/5HR7MRiOmfZ1hKjbsFZP2BTHAwn92CHw1IDJVzqTirhiNe4+P5ZEx9rJDKEJoZinYxDJfxsH/5exfNv9Et8rO+5+IKHZtYi2x8oVfuarBCeNy8b1Pm3afEjPGUzL0krc40sw/8TeaOScW6jmM5TmVDMsQSKt48BLJsYESheOyi6winw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5/XYFduN/9sQwQGYmokYMkQIiDy/Ri/bVO8gzgmtOs=;
 b=H2wjkxhvQESbpSMiyfRSG0hB0Nju1hq21H/emgXWp9Vk81Te2pf+iVLmf2z3piSkr9de2Opp/Q+080nCcuTKK++xeJIjfs7a1Ue4WCfx5E+dpHU4TVQ7vRvwDD6gLioYdDXcowPJGRF/X+d6Lz08+f8bCmuUFZX/Et2Hl41hcK2x/87+kSqXnltcLSe0ucQ4ntz+bcCcnm2i2g7oZ/xnAyPniW86c8hEVP15iA1amCROrABqSTqGETpyLza1BVoTX4md5bzE+1NWj+5sbRImIMu6bc5i90sIC+TwPJ48FxKFPagJPMjVQYTz4P9JPm8zt1DvfVYnZ0ZU1SRHRTt5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5/XYFduN/9sQwQGYmokYMkQIiDy/Ri/bVO8gzgmtOs=;
 b=FA6urU452rknzFrU7sRI5Mcn6UyszWackphx7dGUwcClWrOGZqjZv7M43rphNCD+PmzmJ8DLlXZ5V6O2X0s48uZh/xb6j1BMOVVO+WDhp8Tm+R6Bnzcjf523VsJosCVvdQjwtt43Ux2KZ7qWmVq4bTDUW2mRXLbglaxr8gtLveo=
Received: from SJ0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:a03:333::34)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 18:10:07 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::25) by SJ0PR03CA0119.outlook.office365.com
 (2603:10b6:a03:333::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 18:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 18:10:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 13:10:06 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 13:10:05 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1 1/2] accel/amdxdna: Disable BO import via flink
Date: Wed, 2 Sep 2026 11:09:54 -0700
Message-ID: <20260902180955.3999242-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: d961c5d4-f2c4-4898-6853-08df091d6b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: hSOCYHPBR7Jnljhti1SN1pP2luEf3QeI3y3oKMMp1AmkOwiW+Vo3DVsuqXKPJKj93FxiyLcdiJinH2jd//eqXf7DgOB4TZtDo9LD3qTq1Uyf7oSMm0/pA+INSOb+Caleeh2a6aploUZqELP46CNqcNncxswp1+Eu//bz8lFrNLt0g4Z5HEqgXfKkXOCpI37ekbPL0f1OpteQUfyEEUDpHTk/tOMaYPtGajbvHIaYa2ng3SRo4fqtQYTfeKfFHBvd76Ce9zNx7H0csgMSNButTk2j0GHY4iWvM9LspCede1uFSwesZXnqeCBSBl4/1NZ3fxm8FQpsbGlIgKSkxl5cud2eTiqBlEAv56MasnJmc8onYh3oEDKuwvxElmbh6W0ab/P1f4wHaADUTg6LrYsdX7YWYHOVKor/uakS4YXXESMLtHYhkzDzOu8QkdZBCtklb2QM7udfLkm9T5Z4UzTs8XWM1zyTquMKlhXnUHwG5XeXsjtXum/hEjOIHLEvN/qNd7Zhyn2T5kkZNuWwr/2Uvn6Y0IWbLsdHIcERNCpvpAzSsmel/elvB2MkaXVTfO8sYaGylty8Q1um4JsY+rZGYE30WKrJaw/m/meiywwRYLScYl9txm4yMaM/3nSFViCoUYmC9RJneRUchkT+z50tpThpiDU86/vPdKAKdvUfT0tTZfprRpUL2kIDxVsTLNHL+3S1SR27/n7vcMUDTZfE3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OeYTYVknzXuzcAsFsAnnAEjRn+DD7BHiNto3PpaDvHd+pUxkhVjCQ401S3k5cADmxLFKsm+9kGPb/X24XxFI4T9TdV8FIawcyKYQ/b+hu28eOsbDehA9AoMy4guOQtGicQWjaYVuB5y/SQcXrGa52cbjV+BuPZIaJbXoPNqVBL7pb9I8LfkNKgqGdBTuQruXAJZORgKmnEPCGgffXX6a1x4QgB3xXInh6O6naf5L+pq8Cs5BoOZhhc0yCe7Lm6Zgpu7YBStpO4lcLHI/D+0S9HhzrDyKIYeEkTzfyod+8zyW/7+WIiMvKGKz+9Wcb53SiFQwl+wgrdWGLWP4boT3B3IIhNLWVTo8Qm4jH5+68ovymZlh0jnZywu4n/XwqCPCP17Fy8d3GhiiqN+Ga5PnAZ92w7BichHDP2h+v42UxwUfzBn9gbX5ALYFWTZnNoE8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 18:10:06.6611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d961c5d4-f2c4-4898-6853-08df091d6b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
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

Accessing abo->client in amdxdna_gem_del_bo_usage() may result in a
use-after-free when the BO is imported via flink.

Disable flink import by verifing that filp->driver_priv matches the client
stored in abo->client before accessing the client.

Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for non-IOMMU systems")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 476649685e5a..1353393194e2 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -697,6 +697,8 @@ static int amdxdna_gem_obj_open(struct drm_gem_object *gobj, struct drm_file *fi
 	int ret;
 
 	guard(mutex)(&abo->lock);
+	if (abo->open_ref > 0 && filp->driver_priv != abo->client)
+		return -EPERM;
 	abo->open_ref++;
 	if (abo->open_ref > 1)
 		return 0;
-- 
2.34.1

