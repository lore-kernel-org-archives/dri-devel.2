Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CA606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SFggEYye
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354D810F9C6;
	Wed, 11 Nov 2026 08:56:09 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E7810F9B0;
 Wed, 11 Nov 2026 08:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suzLLdsCN9W+8B3Xmeq19ulcLl1Yl2iwdkPIHhnpWXApzR9JPHmoiVoN72J99IMyYQIBY3XHVSG90Xfa/XnVkVyuXAgjUMpaeli9DWelmxgbxflkjVzzMb25GZN01f0RO/dFPlMjNm202jjnScKLd3crlgfpHIUk8MnHlHB3RjnfUpX80vaKyIoAYqGuBDBG8GKXkzt4U8noc6Sn5sPX97B6Jds8a+SMagQXH667WJiCBFCwwgSM3Kim9kuRxSzgbyZuZR7pVAToH1tI0LCIKKXVOT96Ex177D8mGpruxTbE0neEgbMO0uCAsz8SsEz8jrv2HLn+a2sc7mkS39TJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2IqLVsp9Gscm1LKC6eC7skLzWV9fEDmE+0lebZThco=;
 b=wtW1sRYcN2VhTVmjTAsoRMgyozn2vvCjBwftcq34HR5zhINoXUw8VEFr8x4mIFcc6lJDUdwyQkmS8Uafsmxpwn8cK8OyxlGwTdeMKOvPWY/703EWKQp7VjJyHeI2//CbZHrmcBEdQvdS2kuG4E5xUjrr1Nci2b9gNq3ILoe1MdNGGgvsymfEnAY5NWqZAE8sdgF9tKjv5jWvR6W3n0l6vQIaBOa3UoSeVIobPbq9cG43Ci8+jjvfSLeZ2cUaygU5GjfI+cCM3N9mUEC8xuAjCwFA7hy+EV/LwC8hLApRukiu1cwZ0PT35TRJyCQOkq91VNP05DrIFC7XNXCHUKAMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2IqLVsp9Gscm1LKC6eC7skLzWV9fEDmE+0lebZThco=;
 b=SFggEYyeCPOr4i/jPNjSktwBKMLJufJfBxGeUTbBAtlZkYdQf5ZCGb1UNSVhfmVrTyhmsyQKloQS1o32yU66KZPBEt85HgyXqbJ7EYc3xuFhL9iW7oWYCTWKmgw9XFldh9bK0Yv0eESmLGi8LBbG6lQ88iSt5E9RXbk5Hkg/Ouo=
Received: from CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::31)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 08:55:58 +0000
Received: from DM3PEPF000265BA.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::92) by CH3P221CA0030.outlook.office365.com
 (2603:10b6:610:1e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 08:55:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BA.mail.protection.outlook.com (10.167.23.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:55:57 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:55:54 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, "James
 Lin" <pinglei.lin@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH RESEND 5/5] drm/amdgpu: keep reading the vblank counter in IRQ
 context during reset
Date: Wed, 11 Nov 2026 16:55:34 +0800
Message-ID: <20261111085534.514957-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111085534.514957-1-Prike.Liang@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BA:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: c53e1eea-89bc-4045-1a61-08df3fd19a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261022115727099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 84UUXHM95eDBeCoJo3BSzKw/fmdUoWuGXGw4AaboWVo1k4y2vx14Vk998TYEzCAHflj7EN8WtlpHtYWerzEiXR/5/hoVbVt/+1qfILw55tgMTRboK8SSdzqAnefp2myMHDYTPs9PPPNFQqaVWHKB17q5pTu7uI4eFlj526HlDjHY4Ve5JBo7/cmuCHOXPP5C7uhaysUJLJ3KqEDz54D/Nx192K1dvYNtijHPilNKo4zuu9hBIM+RLKzMytMMmDanS2NKNaEnu1v7PCNCP43RQaWeeASYm1kCnfYoSFArlgld2TT4fswQME8nWys9HKkc17k/TDwmMlDlBn40GT0mlQcf7UOTngxIyjIeLtvvMRq8VzK+Q495nueiTSVkifirApGMUblVf+/5zqbWGzaaeZj5i5dg9pLsDG0U9jiT7vHFs1lFclWaEo7Zpi7RW+rvCTvrZBzzX1HzYA6fgkvsxf3RnGh6bexEuHHdKE/zk4FwksB1KuQjsvHCwTKc+rSaAXu9e3Lfo87UMEJjK2e01x5gthBUmlDKWaB44e+FNAnfoTt+QqkuRy1bUsG4KZspOdpZzATsKzVBmJJhq5Ud196I2Di0s6fXauC8cYz0z9Oct5X44qQWtDyjROW1Cwpiwhc67UEeG2yUWuF1HrAMiC0uJRdRbcHH0+6Wgurz/4ToAOt3pw/IymvysIA+fqTEIO1RLu0eslD0BI2nHWmBuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022115727099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MP8f5dg1JiC+kT1W/L/rfptBmFYZYCAqjAtyhC/OIhP1uJGp3ug1oXhW5jj9sUscKwhwc8zL4zxbeS8iH/Rf4FqCfP3bI0oEDCAMIUQG4eSUh8VYFGL4mZyGT6/G+pHnxoqS43U0N3fI/KUu7w2LsPiTCtG+5bvQpfTx0rcB1FF6gQj66Cmz3qgFcldcpUlIZ2iGplgqbC1itnqpRsxlknPvpLlA2sf31kzXqAvdoG8uIb0v4CtC8/+vmVTAwPU9n1ZgzJuKAxOtX39K4dckLR2x3S6mtrJFUx6MW2UvsSDlc6IzM9XLbSVGRoNqjg7wx5bMOnOVpeKEXBgvwtfMIEbWordJ6gCus0CREMdAJC5BZ9rsGk4ZDlCgIOKOKcKEs2aSY2lnFPjA/uH1bpTru2HdnIYc0nzyvM81+GYYKHVbwIOlFmVDs00PsSofAdUB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:55:57.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53e1eea-89bc-4045-1a61-08df3fd19a4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_get_vblank_counter_kms() returns the cached vblank->last instead
of reading the hardware counter whenever it can't take
reset_domain->sem for reading. The vblank interrupt reads the counter
through the same callback via drm_crtc_handle_vblank(), so once GPU
recovery holds the semaphore for writing, every vblank interrupt sees
diff == 0 and the DRM vblank count stops advancing. The CRTCs keep
scanning out until dm_suspend() turns vblank off and stops the streams,
though, which only happens after the rest of the recovery preparation.

Vblank waits in that window don't see a vblank anymore. They only end
when dm_suspend() turns vblank off, or after a second with the
"vblank wait timed out" warning if that takes longer. The fbdev damage
worker is likely to be waiting already, because recovery prints
"GPU reset begin!" right before it takes the semaphore.

Vblank interrupts only arrive while a CRTC is scanning out, so the
interrupt path can read the hardware counter.
amdgpu_device_skip_hw_access() likewise only checks the reset semaphore
in task context. Only back off in task context, so the interrupt path
keeps the count moving until DM turns vblank off.

Fixes: f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads against GPU reset")
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: James Lin <pinglei.lin@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..06e539c4c3ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1692,6 +1692,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = crtc->index;
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	bool locked = false;
 	int vpos, hpos, stat;
 	u32 count;
 
@@ -1699,9 +1700,26 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 		DRM_ERROR("Invalid crtc %u\n", pipe);
 		return -EINVAL;
 	}
-	if (!down_read_trylock(&adev->reset_domain->sem))
-		return drm_crtc_vblank_count(crtc);
 
+	/*
+	 * A GPU reset is in progress and the display hardware cannot be read
+	 * safely. Return the hardware counter value DRM already cached rather
+	 * than the software vblank count: the core feeds this callback's
+	 * result back into vblank->last, and a software count lives in a
+	 * different numeric domain, which later trips
+	 * drm_WARN_ON_ONCE(cur_vblank != vblank->last) in
+	 * drm_update_vblank_count().
+	 *
+	 * Only task context has to back off. Vblank interrupts only arrive
+	 * while a CRTC is scanning out, so the interrupt path can read the
+	 * hardware, and it has to keep counting: vblank waits that already
+	 * sleep when a reset takes the semaphore never complete otherwise.
+	 */
+	if (in_task()) {
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return drm_crtc_vblank_crtc(crtc)->last;
+		locked = true;
+	}
 
 	/* The hw increments its frame counter at start of vsync, not at start
 	 * of vblank, as is required by DRM core vblank counter handling.
@@ -1747,7 +1765,8 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 		DRM_DEBUG_VBL("NULL mode info! Returned count may be wrong.\n");
 	}
 
-	up_read(&adev->reset_domain->sem);
+	if (locked)
+		up_read(&adev->reset_domain->sem);
 	return count;
 }
 
-- 
2.34.1

