Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B07BC61DB7
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C24710E7EF;
	Mon, 24 Aug 2026 17:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dXzS/BLj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3C610E7EF;
 Mon, 24 Aug 2026 17:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVHyHPCDh1v6e+d5f9bM5MkvoivzUfCi6QU/qKF7ijaJJdP3ntgndD9jZ7PgpXteyTHbGcuKRaoAL05ncpDbp6yb6s8CaLSrQ1TNBO38349jXGHBF5wPuJK38RLukipPLdzKWz8XRCA4tnckXB8WUxHVNGW/A5g7jbyZijofSmBbojiPRSXe7TZaVqjdy4aqrBAKHS/49YMDqyB7kXzO8mvfRu6kZZaCGH/gRf+8BB1CHLE6xh7AY96HAzDMpG70j2gEN7aXHVniHLhhvZTLLTCM19Z3aPxYpLjjU+wnvtyhb6DIiCvv0VqicnLDGyzrF6q9sgxmLINuvzEszh3MEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8Dmm4FyCV4bRDNVnieY+xRGOlmS6+nt3F4a5ByUdJ8=;
 b=oYjpkVZz1wdhTcdGV+1xw6tNWRJwsV9rLe6RGN3Jge0LOh2Oi+6MOrLf8TPp2uAcIjVDRs/wsmew+RQwAshlEuDUNgCt28e+zKeAnFiruCf4G87pT+NLSeDtYErCqlzNbsEfpxIeEgpSgz3aa9w94yg5xPZYtL5Ouk7JQkRDzRG/Rk+Lg0YobIb4tGIg5J32oyoB3WhoJg4ojJGCJQMiM/jzmOniEDn9WPr1Q/dbH4it2XSDGnNTlxKTvA7bCqWdH40JppIVkJHwSCS6OCY+iPunOp9pTWltxB3zdWKvDrJD2vuSi64VG0vp0DpagJNKeLeuCx08r+JSZIfDPthcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Dmm4FyCV4bRDNVnieY+xRGOlmS6+nt3F4a5ByUdJ8=;
 b=dXzS/BLjd/gCpqzT4DxSEaJfjkeU3aDIGkeL0/yT0vKD2Wa7epWk1UoMG6eIPl2Oqhs0Fq9mHw+HpCptu9wkp+on7GAEOJUZiZ7n2f0F2qKJXIh5dFQjAECRSbeUyRd90P4MmgBc5tNr9LyXvvO2tmAYWJ0piXitl2go/pG8b8Y=
Received: from SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:02:26 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::4f) by SJ0PR03CA0374.outlook.office365.com
 (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 17:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 17:02:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 12:02:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 12:02:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Mukul Joshi <mukul.joshi@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
Date: Mon, 24 Aug 2026 13:02:00 -0400
Message-ID: <20260824170202.1764463-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824170202.1764463-1-alexander.deucher@amd.com>
References: <20260824170202.1764463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b0a189-4a44-4926-af70-08df02017900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2c1hEdn+ykuqwMeZt0TCTdDM7ppt5Mc9V/haNExg8NwakPAvn9w5O4ooUUDdOVSXglbxLHvkr5NXkYFja5iU5p1lB195DjFeRg5HBWEOZIHGS+1hN3w6UYjPuuYDGDNgOndc6n/4EZdSo7HDqU2nipSXweTH2S/0Q+igA+iDJ3dvZi2VE6ngk5utBQozrNhmQnZlusi7IyK9Pfhf6oR8+ei66+i3eP3nQ9X1aY07VzCZhP5yR1/GFg6s4LQlkwBqy0N9zGNJ2YRiApQHjA0JQ3byE7diZqQdU0MXirPTOiSr+T9whA1iab2An/QeEBK/sugIdVNfuu6Xp7yAq7GRARhWdczo2jH9wFZOqVuqK+JET6EjMR59Zu375lNCmx1JT8YPL3d9vSUaod7ZoLdQE8L54LQ7xVXDaFVG7IqBeH2KKYeMhUDnTmk5sTmx19nbWr9RMRChsjHvQrFPQMHztSCBZJFP7UFI2phDMWLvvBMa2KUQi9MKmPqSl7/FNVPj1XiqsNKFraHSs1TFIrSG7aSaT11Jxb6Iib4VTb6CE+UMLLFva+eJgDBlB5RxTzvaCsNYGUHe+4DBre5obfpXej9Xu0FGL3V4a83nqWEW7sFfySeaTPkCv5KawTA/qY5RJ2hksBv4wdal4Nb98jTiahj16N/zig/rXVkCwBpUmn2BKEhVMy9xrVvxRwoUSkXmGKf/k8jEksAMcoLTfBzhGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JmiDJ0uF1cByBGGCg8hoE/o4uKWJGymNYM2zWJ5oFVEMbCRdaiEviDT3O2GK1Jcw7f289rmXNad/qbwfUFRCRrQHoFdyFLFd9BDbKzMC0IPjpA5kQH5my/BFK+GrRaBXXMnC9o3VfK6H+SyDePsveyqHD8gt56DOkcfkBsH+EBScqLCzCiPG1RrHUzNtCKfJPmMt1lS+7JuzYImIUBZ6CfokKLAEBsDqa7IaFQCzEhmh8dJ/FwG6Y4gvC2KE7GNsP+gl53sMue6v+utRoKYq4CSc1L331KVwb05UXkud4QJ6ErsBPzBNUON8gQIy+4uVA7vXblIDFR/7E4YV0qojhzFd6ZoQ66betuvykh/Ce1mZPhKmZ00c6epmrtiYGdSyLUOjkMLt/ux94Wl0tuZu2c+i02bTyJAn74C+YxqNySnWtyEWs84NUNxAlf5vjjoV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:02:25.6940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b0a189-4a44-4926-af70-08df02017900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add an optional callback for driver-specific cleanup when the GEM
handle of an object is freed. This will be used by AMDGPU to enable
freeing of memory exported to other nodes in a UALink pod once all
user mode references are gone.

The callback is called outside the object_name_lock and before
releasing the reference count on the GEM object

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  9 +++++++++
 drivers/gpu/drm/drm_gem.c               |  5 ++++-
 include/drm/drm_gem.h                   | 11 +++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f754a4a3a1c22..0d579517c03ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -386,6 +386,14 @@ static int amdgpu_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_str
 	return drm_gem_ttm_mmap(obj, vma);
 }
 
+static void amdgpu_gem_object_handle_free(struct drm_gem_object *gobj)
+{
+	struct amdgpu_bo *aobj = gem_to_amdgpu_bo(gobj);
+
+	amdgpu_ualink_revoke_exported_memory(aobj);
+
+}
+
 const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.free = amdgpu_gem_object_free,
 	.open = amdgpu_gem_object_open,
@@ -395,6 +403,7 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vunmap = drm_gem_ttm_vunmap,
 	.mmap = amdgpu_gem_object_mmap,
 	.vm_ops = &amdgpu_gem_vm_ops,
+	.handle_free = amdgpu_gem_object_handle_free
 };
 
 static bool amdgpu_gem_are_domains_valid(u32 domains)
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e3ed684ddcf29..6a86bd2a0343e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -354,8 +354,11 @@ void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 	}
 	mutex_unlock(&dev->object_name_lock);
 
-	if (final)
+	if (final) {
+		if (obj->funcs->handle_free)
+			obj->funcs->handle_free(obj);
 		drm_gem_object_put(obj);
+	}
 }
 
 /*
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 8a704f6a65c15..95d8ae6f85df7 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -227,6 +227,17 @@ struct drm_gem_object_funcs {
 	 */
 	size_t (*rss)(struct drm_gem_object *obj);
 
+	/**
+	 * @handle_free:
+	 *
+	 * This callback is called when the GEM handle count goes down to 0.
+	 * It is currently used by AMDGPU driver to release their exported BO
+	 * handles.
+	 *
+	 * This callback is optional.
+	 */
+	void (*handle_free)(struct drm_gem_object *obj);
+
 	/**
 	 * @vm_ops:
 	 *
-- 
2.55.0

