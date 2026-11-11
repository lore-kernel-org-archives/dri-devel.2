Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C7606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=smhccade
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4062110F973;
	Wed, 11 Nov 2026 08:36:32 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB1910F973;
 Wed, 11 Nov 2026 08:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzPGGQERdl2tPMofCdTjDr+tL7IXCIMG9rw21v+G7tqsp47/IJCWqW+jchFVYulDz8fA7mQ7oA+NXzlcmYC52L13PY8fui1g+fG74Ri/cgSsKMvZSa1NYWPM7krqvO2cBb0DJHU+jifWI3pxA4uW9em3AlIkej6saXS6UbU2x7SFnxRVLs1ZXoydSsX6u/CIXp30fafDOmL/P04vzTPO05iF36mii+IS6xtNacpI23YLxAepFb/3egTQjSrpUMk/0DAfay6AldrYP1qSPPaFNa4yE7ye6GNaY+9/O1FJgar3xoUoBCvK62/SZL0CXH25R3BJtwgwwgOima4k4Xg1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGhrfv1DhRF0rMLmc5bFUJW/txlS1A3QgKyxa1zbOTY=;
 b=f8Bp3Y4ErDXZQtBGuvHLKEn16pn+282dohfyQyKoHsRZzjE88F+qZ2c6N7KvSn+/TFOjJdFW/uCwjWOcTfReI8qZPQQWSv4KY0rJ0GCZ7H3bdir4MvUsxZSymZXSJcamk9Zn4e7M/Mur3ai+vHjmXpsHa/aA+ik55+uvUY6YK/qTdT0TKQxA2mxtB++9n7+DOEgweQ5AGRba/35GrY3F1iDCVDjKgxaeRigMIAZ71YGhoHMcvcYo07EIPIGuoirL5wgHjfGTHFvCYxSaerFEIpTm3LJEZivSh7EgGktQRYtHUHAWvtRn49xKLNahdWKweZaeOKEyF7ysmicRfO2Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGhrfv1DhRF0rMLmc5bFUJW/txlS1A3QgKyxa1zbOTY=;
 b=smhccadel2IHqTuog9hEjN3u/OdyS31nSfkv0m+mVYhqys/tU0n0v61su5tFI4cIoG8nawbbelwLD5IY1XKJQvhoMBlPWDx0JK++ICui/fuCrKo0MQzF6Sgnis4h2bbXyJ8ARU2Jya5BzRTZSHEm+S/7NqzDrMPIyJF37Kk6du4=
Received: from BYAPR21CA0015.namprd21.prod.outlook.com (2603:10b6:a03:114::25)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:36:13 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::14) by BYAPR21CA0015.outlook.office365.com
 (2603:10b6:a03:114::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Wed, 11
 Nov 2026 08:36:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:36:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:36:10 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, "James
 Lin" <pinglei.lin@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: keep reading the vblank counter in IRQ
 context during reset
Date: Wed, 11 Nov 2026 16:35:34 +0800
Message-ID: <20261111083534.514290-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111083534.514290-1-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e844df-05c1-4969-6787-08df3fced825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261022115727099003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V608JylRnuS2+0Bux3rXUIm3TR4NFJmr0zMAoeH5jyO8qILlbfTjGENr+BmfY8ABkAOfdkYF90Fl9O+JEpoGVN/t3pHWzYn7fMpU9BUEEZGlgAVo3L5RlJ676Jeg6ZLtyJzJ4GRIiQJ0hLQgMaEBUTgANj+pzMSBd9NJqLe1C4ZQ9W7Hekq3u3896qIIDe3hLM7zVpMgor/TKcsoj7a9y+/cgCee0Lm+JB8p4tBAL6mNZLeZpFsTBsWY9s9LrmP7KtEMyB5tUJTvUJfSBisKzIe2xPSTNzat6K0ZoAq5Be9C0jZTwPO2ZFJzqdWgykVWbxBvBPOsADU5+swzq6PuVQgmRBSMZOMkK0+kJP4j2qVVIokRP4gGQb0gWNekBIJiLK+YeffN/z9ZfP+I29MxyTeRJ9TpIUJ9ihWqRxPFPBLN6iLaupFZ6R8kqCONkoP/P6L5TolC4j0OYUk2xF6LilkgGf+3duoFJksXFq6/XczoammkVvCg/56DNgnhPddIqe5kgMv5I5y6QqN4k+cqWj+97PQ+c5ipViPSoQ4lKlJ2AC3qWXH9qbaqf67Srn986bZB430DOedtCMfYwVo3YsI87Wh0QwLBLzXB4rBLOlQAwNGCAMSznLtQrDENQVWeOyhvGTk2oumWWittxEE9wNWPrAuev6Pq6VyBcoGtBYrxZwCqPR83YiSScTuSOMrOAYoOke3eSCcQvvfQpiJzVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261022115727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oVZuMqqHFbkPuRjrNJ3gCQvtbbZ4RUJKOJbiSRmdhTN5VZwAP2gjKws0B9mbVt21KNN2sL96RRBOUY1tJ0bKj/VyDS2HTybA0IVq0btJJzPULJJvz56wraeCE6u1Ie9aAyF9DSdTtP7dkh6n/cIDiUy7Od2clsKqvtnyJhxHE4HSZzqctWPEbUawhSQ6HlGlspkHO/vadkoL62fJ0lkUI5ZBC318iMjxBrICSNb5mA5DmqNUCh1vQgNuKeMGxnlxy4C2BpFvDmF5lP8TfkUYDL4ArYC4JaeoUAW90o77heipDzQjjrVjorkGaEkGcTBeByUYN2oXNWpj7rlIeu/28KW6EFlPl38j+JC4dEtpvvBAaDlzXp8vS/JVfhTECHdlhKAIoltr5x5IgMSDBkb0FJDMMLUEofA7bdK+XDmhSpnii2l0c41TKnF6/vAI37JR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:36:13.0641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e844df-05c1-4969-6787-08df3fced825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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

