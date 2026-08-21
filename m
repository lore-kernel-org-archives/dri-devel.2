Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6E2C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A33210F4CC;
	Fri, 21 Aug 2026 19:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wT/KLtdB";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DC210F4BD;
 Fri, 21 Aug 2026 19:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXAtvC98VHUhJ9DaA7R6FTybhScQhxRf8cZ/8fBbuieOV3uJ2gTkBqUnuLWxPZk6jOAieE7bfyOsZjXjC1qjGb0WjP56ohXKgOT1TSq9YgNRbVEr/R/1GamXRZyIz1dXZBTaAoNDtdfEqusob3G/tgzJtI5n/nBLkrHvLKmZiAs5CgwZTbfLRhLWwv1eXgeH91uxLak4D2lK3Io1oow2t10bdkFgVWCye0bYiASvblIkcwzSb5qQme1KPRYJVvD0E6tuYgJyMNT3oOlaWMKVD5LA1wI2mPLZh1o8w6YTUcsV7TKymBWqjxkoN7V7B/dBAMPUWzRehzq/AnnIU5KyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8Dmm4FyCV4bRDNVnieY+xRGOlmS6+nt3F4a5ByUdJ8=;
 b=MtuiRS3BpSDuDCIOvgHofu7o/0tYciFSJSO1F52RGgo+P1PI7YB5mp9Haa2CZWz8JKIVJ3NdaPpLJBxKB9qm53KnsLXGELPgwrIK6yJMEvPXhlRI1Gc0iwfqff/9LSnG+HBEOZHUD9knyUORH3g/BZmUFGphvY/JKvUUNsIepNcCZ31rAvE93/eAVWW5auIvh7tCaDSL8VJxt98m1LoHfKm8rrcOIM1+3HMa0nyt/zVUbx65eGBCqCTzyu6ykQt9l5p1GGrb60M1FLrOpSOmZhWyWB8xSE0+tWWVvIvBtFo6MBaFJXojaP+pGM1W3C8mno+jr9ih3wgTYLfQVWJb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Dmm4FyCV4bRDNVnieY+xRGOlmS6+nt3F4a5ByUdJ8=;
 b=wT/KLtdBphc0TrcMV5/lOeJerQmHqoMrDydaK/8YqdqSESgFNqtbGgBi7hyPY2EFEkeRR3cAvrw3/Xxz0rlJg4zA904RMsCJx+C3MtrdHWHJMckM4RnkXdF4SHQkjoij0g5sdC0ij3m4QvoXfr8a6icYi8W9t4oCy4nQ/e8wm/k=
Received: from DS7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::15) by
 PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:52:40 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::3f) by DS7P220CA0008.outlook.office365.com
 (2603:10b6:8:1ca::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:52:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:52:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Mukul Joshi <mukul.joshi@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
Date: Fri, 21 Aug 2026 15:52:22 -0400
Message-ID: <20260821195224.809173-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821195224.809173-1-alexander.deucher@amd.com>
References: <20260821195224.809173-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e90476-1b4b-4521-2b0b-08deffbdc1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i6LRKNeeKBgYeOHb8bR8MD7mqg9ePO0Tkpm9WbnVB8onxnlr5qAuUWs5Hv25tcJmAJwStkMXIB9M+tz2POX9crOJZUcaT4PtetVsCNTyPhji2pbow3L+rJ1Td6srnjQqDubRuUYQX2JHDzLUXgxO3Dij0qKcQKDHakRD4Xqcl9/WRkpAMQicT22cH3SLQ9dXLS3P54edQ8F7tWIQs1/ZQ9alOwnWkE/bRxzW+UoIh/Cxc1VR9ymO6XJYuysktB2zavuXMCNewcyjSZZ//kHncnUncF7Ii14b5rdxOL2wKzEV0D/jRk8zbH8pPnDvPzu5NbpL0G3NR3l7KHPM+chRETcFYa6k9xXoeDijBsAv6TVMSn/Vrky/BQjHaJphNWRg2YXBNss+0TDWXCXP6uXy2rqveOu1oYhDAelXVoTLc7qSxqN2wkK5RXK0crB45vkAcWO2yYoZNNV6hC1iNWfo7f5/SwLr9QTYsIy2AVt7DVqKA2Z6+iyUIQrN2H7K6mU1L6wKonwEGS7r/Cy3s4eugKua1ojgEokjGWq1osE5O/cM3fc8jp/f8DoEq48t09BaIfCNMlD3m9MuCWbTHTmXS/MdcYb6VESTggmoUk22dnmOaKkW5/cdh1X9MmAELeQ9S2SyIBk5//khJc8Y0Odml5bS/QEmbVSrYL5ARU86wOnh/vPYY0Pgc6NatXg4YZuY3TiF/YvBs4mN7tXq4zKqYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K8Zu3MpPmM943Qcf3+Wjk1kCuLCvRs9OdKQlTE4FW8Cld2PPOAgXWTT9wIvBsXMYAyMi5MN6nhvv/pY/CXn8OsX4zV8XPZq5JVPqmBQUyZxqQMt7Mm3TpU+JWCArGS0x8oBOL0qzlzBk1N1wj42DBMPV/7ofPBVo2wzcdi6yZsavq0LoX0WxgYXTUxTctEk1mh09Y/X1tfpr4P+3DKwhqeyELMk92u8slXvavDM5VBrfWxWN5t8PpCv9Q59VRzvtd/yhHsqqWkCe4gO9qqXcxy+fm2EOr6nSetyidm3z8mAM547WorJGP4HQd/leTiW6qiZQP04O/0gOno2vgJpDYXnbTlSaC6s73dlSP6I1QesUCceMDQleeH6DcT1U9Ql9sOJhDqgSOvOjkp3ERSRBLabXwH0XFf/IV9HGq87zcldCgeI/ICxQuaVGGhmyMfYn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:52:39.6919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e90476-1b4b-4521-2b0b-08deffbdc1c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762
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

