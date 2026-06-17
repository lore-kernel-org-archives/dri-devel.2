Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA8CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C74E10EA33;
	Wed, 17 Jun 2026 13:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qg8zqNHV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DF310EA2E;
 Wed, 17 Jun 2026 13:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5az8ye8FSWy1prsGmoKBfLZlKtxKVjhKi+9kNahQha6ewfSREnabozn4ng/Ncq4IT2d+OEctn27Nh9Mj5A9Jtmt5KsU90BRBveEq8lmQNUzrayAiv5PKD261DtIKOvZzXQx/WKBJTesfbAzjdlDVLom7M5GMMapQua3jwdWVF5+M22NFLSYm2wfNraNluUaCeS1DyNvelASJ38JRQkzF2BXXl0U+CXDAIwGbz3lJN176TuEsG7qZUuJoYpS+YjxN0Gk4ATLqrIH+uo9RzB68YVrBQFDBxfeD5XFj+cFXIIh7SsuRI06WHjhxa8xqG5maGVpDxhfN7Pl+87CgB0LuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFOvzWvkEkpx6+YWpuwMp3KAlUiFU5ewvZOFCCnrSBo=;
 b=vVQlasLIpsXJ0sdcT8ZzLlVhVUDYg+EUaP8FhGOnFzo5UdLP/PlWD3+FqIhGpu1DyeZyRXKUMa7xZhOlsPAwF2q3GPjmxiqg5kAkeGPNSVhgCVa0qsKCB+6vfeEFtC/bvl+kNM3fbPs1XwJhPJ8XmyA777dYagjv3YYwtyyZoEQrzSVG+JgFDlk8T14eB18YxgFdpsN8bHhqCCj+bg6+SCY8PNfVmKP+Swd+cePsmeYeQSes789BUR7NVNfxE3K0Yk25Hg5NG53L2EwVhLkJ52pykNnbdc0QoPzjL5HRRGoNdHjHZ6/9fVtLy6j5XJ1lI/1hXN9fm85+ySayWwlUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFOvzWvkEkpx6+YWpuwMp3KAlUiFU5ewvZOFCCnrSBo=;
 b=Qg8zqNHVrlPZeEfy/WghY329njOHoWf3veNS6v544/Z9j+My6UefxN0QvZbUVvZr7XqKU8b83z7xfI9LLdUh7wblocIi8o7IIF1wQ6U2Sp9kilpIhPcW7cOLeo9jFBhDSRKgVE6/7G6arw9TO9wgECGjKlEDKClHOd8rIsR48Ug=
Received: from BN9PR03CA0513.namprd03.prod.outlook.com (2603:10b6:408:131::8)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 13:28:57 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::3a) by BN9PR03CA0513.outlook.office365.com
 (2603:10b6:408:131::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 13:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 13:28:57 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 17 Jun 2026 08:28:55 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] drm/amdgpu: don't disable ttm buffer funcs on reset
Date: Wed, 17 Jun 2026 15:28:32 +0200
Message-ID: <20260617132835.12306-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c20d73-de15-441e-2904-08decc74624a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wfN+AqBUREfP0+t2qjMCS040DvgDi767RPMQQDpDtnbq4PAReuC6eIT7JXL1qktzPqsvUyMYt8iT1G3+XI0AHrNZdJ08ngHIdyo3Jj9WbEawwn5v/4KxoN9eDg2ecTkmRHhd/WnrLtaEN1jNz2lwgfYON5MgV2W7muI3tFiXTxCXYDJ5MqitEH00JSWZut6VAsJyaNRQl9R6bnzxM+xb4vdrwiMMGwV43vKsT2lwptFb5ExRl5MUCZpJUSDoyvQPm0RFsWpuUE+wuTfbq/MOB0Kq9mPRIR1E8YBDnLXep6rHxi5v4Qku5ot7lzpE5dhcZ90Mc4ZHcbz6wKspw/65YH0jKloxuT4BVM2ltLu8EVduzFDCXoPc4BxvPn1DFJNXT21XawmcWLUy22SSlRl2ph7Pk1cD9GG7LVlISdWnqGU2gqQcrbaEo3T8qLLCetgVAG5l8uwJam//1e7FGWIPWQSrfaLXiUmxhejB3E1TPnywrm7NXW6kdIwEOGTr2igiZ3KMOxncIGx1rkWwd2qcKp8z5TcAPohMH32LjRD1UTxfC5Pio0cfM6yXKt4CvzCdZ/6FfbYFLHyUVmsp30DbAiz2XH6MO0zAzOO517qQ+tVT6+8kZUmSuZd3jNEexlVQsNuOxRo8/qMOGT3L72cFMk4Pld3k7NlvbDpwEE4ASvyoXXhtrTbLOBGgsxp2jQETY6FgqQK8PoeHF3KdKXHTq+Rrl15hTP1+QkF9z1k4k4Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GYjl30xxmKTLC6drD1dbOhpJaKqExWmucM8Ez/n+Ox5P4KS+Ssl08Dw5JOPyOHTpGo8uVgUEdHhfI1IJONjy2DBut5kInSsqSVYMOB74oN+y8A29DsoSvEqKolzSZGgptwz1meTRdS/fgr6WNp51vu8PESg/xzjnVfps36w+kddoFMx9kHT6QI1DqlvU0e4cEixwZxdfr1GlAyIMpk6hz7VygQn1IYNq+YyJdaIEeWy3RBBMouz6LTyBpZBlqYL/H+jpNZVNCehXKh3bgIO7hmLBlpLl07/NjuYakUPLSSkrCNhVuc96MgLVG2rkM6BpwUMdpzJ839uSDzGNd7L3kRXQDUI6+4FB39ALRyrg38vpyGpmwDmqcoc2zt/9dO6cIfQHhJJGacb4zo0xkZe1sc+agYWqX0tru45u+GD7XM0Y8z7piQaSfOmzfvImPhSj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:28:57.0052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c20d73-de15-441e-2904-08decc74624a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

Access to hw is already suspended so there are no reasons to
disable ttm buffer funcs.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6608780ffef2..57e10afb4714 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3167,8 +3167,6 @@ static int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
-	amdgpu_ttm_disable_buffer_funcs(adev);
-
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
 		return r;
-- 
2.43.0

