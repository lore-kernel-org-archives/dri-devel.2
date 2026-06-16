Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A87CCD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8051210EB75;
	Tue, 16 Jun 2026 12:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iXozbAkS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB8010EB75;
 Tue, 16 Jun 2026 12:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecwz5KwOS4Yp95l0zK+W09ef7d1JLYj50rCVWCtDmhWX0QPIf0SsBn53wbiy7kcdXE5Ih0yh2GD6v71m8ztGdo3oelAUmTbRbo1KLAnvjIB5M96poDtftBKFN+lND3HvFLegjy+ycxZb7HIsBzwwiFfJSMcXTPTvyaoDEdxQdwr08PTZAUTgZgIn96WuzJutSvRZufAt6Ylu2juaHffGnaM8bwnOAL/r1Tqee+QqtRcLtQnMtpSlX/SJm+oUENrjqLM8JzfdNsJw9fS3R/I1X1uF19KZn0AWZOFriV3lyMtYp1iqU35m1qxQG+SQiOevB8yYgK5off8IsDVa2vWmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guqQIT+HyZ0gYeYy7hlDEQUHdsc9YW1G/FzcjN4tOiU=;
 b=QCVPBSlip5QaRAYrU6C220jhHFAuA6/j1mclGas1k8CY/Bt5FA++eNHgCjsJ2faaJdOp+22Y/x/39BdJjozEZtHtUJiWDQnfAg7eWnmj0ZgRlFeujOxxAiw44brZI0CEuAwwOlOpfutcJBo7oDZ9Vq9cdc89mFWB/raa9G1AUD7KW3IeDcuvQ1KpjwN8Zt/6hd30qDx7uu2Zi/YrAj/eLgKC1c5FYn+IdNjgH/4x5NaHJnBzq63WxctRGuWODRcWffbqFOi7fx/ObEg4Jy+ixD9UYcBAJvwnOsK5jCILCnaPLm/1bnPxX4m9SSGXum4CVWaqungBTFq8FGZLdY8lXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guqQIT+HyZ0gYeYy7hlDEQUHdsc9YW1G/FzcjN4tOiU=;
 b=iXozbAkSG6Wf7RYLfNllRCnAOrszIrS0f0glSIjlo1yioDR3t/ER2sOpXiXO+MdFfQw+Og0bpb2+A+isvH+EPxba5UZl62d1/wy58LESdh+tizK+6+3ZhpnU7nf1fE6ond1bwYssrrGBLtacw6+9Z210h6ZeaBqoxYsgF9XocF0=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:00 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::90) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 12:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.0 via Frontend Transport; Tue, 16 Jun 2026 12:51:00 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 16 Jun 2026 07:50:58 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] drm/amdgpu: don't disable ttm buffer funcs on reset
Date: Tue, 16 Jun 2026 14:50:38 +0200
Message-ID: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 278ad745-d622-464e-1511-08decba5eb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zJKe07cVK2atjXzsuSHolZkSlvNWor5AbCvvCMD32QBt3hJIVJlwt1f29j4bcSwiqkgaYgt+uEodHLdYobkAfPh+0gcJwnPHzjj9QNDvMrhWwbRGHPgaWndH4uQU0jpzzK6OXzZ8u5yNKT9frTAUo2DyHvqKdquh64xItEi4Yxo7vH6/m6QjNy2umUv8teVg6uJjNsrdOVxS7oox1OSH9QPjmocSPRSwVV1/CQG8khwpx8H2+yDCXfYnHwF4/q3YgVoWsIhoeiQkP2iwqvhM/hU1aqLFezS3zPY1PxgYleFwm3wLcDG+IEAotbLvAaXvYaxAJsObn5NWoa6QEknI3kPYQyq2vLH2wzHBwh4kMnjor/ze5zAaWaQNNwuUh0bZnOjpzhc8muanACdqdnpzcsgRhfh70IU0Eat3Mj2z2boxV4ACpmkI76nPFC/PC+t5ND6eL1DOIu4de/gPLJrcVxvfV0+u9CkAxT0ZbBeoDVx5kkffRKZ9ubfrp2HbdnwSLu4TsehaTVKcPVefYgueUDjN7Bj6OGCO9fGjyozRdG3POYsa+NrfB8N0IYkKDN1GO3pxANVHtW3rsxS/PiSkS6s7w/1wbsgUzAUibL5JIB5ykNKuwK8PaOA19y+rOKYFTtrnGY3G0VxsWgUgHu7HvXUSvyc6gP8m33WzkxUBimOjNRcUCwC8yJGReS9NL9lxppTsbh2e5DLTVD3488BdNZqhgaMJztshOFmnHAVObWE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hBgfMIUzMalitEOVIW7ITqvSxc4/EjV/Xbpd7z5KbYdv/9NkhHAB2wkBz1+C221NxcSIQZG7oYdD8kM3+QUWfy6cjX1FVM+lT/JxWK57vKZNJPmMC6mfCNoHLdqab+Syt/hbKQTEFL0GzDDW20Fxi9+A/Xuij0VVpP36b2r2Oa1kvu71wswoEAHkLw1S1RSlXrLslICxMGkY0LD5TlBlMPcDLk6CzqLV3/OHUBvCJ+p5I55s+HnfZEO60gl9+wylyXtk73qcbIPRBQGcV8G74L2GwmipZJsS2ZsE73AWThiAEPOXxZ6sJGF8gyPewjmIZq7GtQkt3MCyCZllgg7fQqElPyV8gYmMhGZCDBAe1FpuDOO3H71I+X8c+opDIIgrnCETfWrbmpND2gnOSMV4UUH3/4l/dz8BL6D+HyJMz92dcwVvIKgQT0zGtOJXMX2/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:00.6529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278ad745-d622-464e-1511-08decba5eb15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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

