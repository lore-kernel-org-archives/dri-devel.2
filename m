Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08D7F44843
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE5310E94E;
	Fri, 10 Apr 2026 11:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xeAqiDLn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DFE10E95E;
 Fri, 10 Apr 2026 11:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/neA60k7c/FPxJQ0P7R+WiXWm6f9S8yPEXAS1bLASZKSUl+qvH1tkcxdhAg0dxJCzjNbVdtrpJr6SHyo+VY9GCjXiRZT9cL+2dEfc7HBbLks2a/oXkt5/+9cJ2UMcBEtyk1tUbNAI8VdgLmD+KSqXmrJGzabVUqZYpQ3VPlMXxAm+4/kPRV8ZfHs7BfESgEqHRl/rcPI1EvG+ZAUzliKmnX82TL7zw6YNw0fqKDpWvHHKrzetHYXRYC4HCJTsS/qxkF6JfDscyMZ3OjqZeUUXTjc6hwdOOi4NJn/T4qp60PATB+8cDAjxop9nzNggDC5QPSFfLJfFtX2v4lzTqM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQM1Sug4bwGcw+pG1wf/pwmxNeY2eZlEuQj5yZt2D8Y=;
 b=Jz2ngFkt1KGd0UH6Yb1o9n/UBeijOqQgB+PUEY4E+WENpzRf20tRBRl/UiAinjz6bwO1BGAYq0CIIjot8L8VaqaUuoZZTurvnhEKQVAiJXeH/ENXqEmNjkoUDF/eu7RX6SeNnz0/NJYtQ3AFpeonI1ENul70MSf5mM1Emj1J7u4MdcaID/53VG6gTXHGsEKc1GOYB9k/Y5XX35kin0mEnT98uF8T/jqkym8ky1GMkbzLVzYQCMPD2OT9ghgF7zV1GoHwULteRthSJsLsSwsasCGg7sX9rcbRPuol/MeF4D/gJRR1UnQ17E1HiJ2UZIUMrzDNJ2aK34RFMP4cdnp4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQM1Sug4bwGcw+pG1wf/pwmxNeY2eZlEuQj5yZt2D8Y=;
 b=xeAqiDLnTtnpM0ePbbjBu0KGdhJ+wS6S1t3VD2R9To8ea6ToUNO4Z6tPyfM1qaUe3DVORzXzH32e9CRuma/o1PHa5PGkKeteuDaSRSMcQI6kpVhegJIzXA17khzXt3ejvDG0W/aZOEf1fLLs8TS+Yh77oynbTJqGmainqBMPkHA=
Received: from PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::17)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 10 Apr
 2026 11:32:33 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::fc) by PH5P222CA0003.outlook.office365.com
 (2603:10b6:510:34b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 11:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 11:32:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 10 Apr
 2026 06:32:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Apr
 2026 06:32:07 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Apr 2026 06:32:04 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH RFC 5/6] drm/amdgpu: add SVM attr prefetch/force-trigger and
 in_populate tracking
Date: Fri, 10 Apr 2026 19:31:45 +0800
Message-ID: <20260410113146.146212-6-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410113146.146212-1-Junhua.Shen@amd.com>
References: <20260410113146.146212-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Junhua.Shen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0c0cb2-34a1-4f1c-6d8d-08de96f4dabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8kf0WUXPjqoBk5xqwlQ7rr33vn3I2iPeQvhNpAxn3yplRISgyB7e6auYx0ZjK6JMpJxPlA1aNfiIzgvKtGlzdYEI8Hk0YAck3Oegqhce0BYPM7HXtn+N7CCuCW80/JGMoZtlU++qtxeIK7SyaO7HbH6sr8tGCn3+bOyuIlGXgOtrtsaOsApSSZcqwwu5p3XLehBeaKXq9NKtegTCm6EyFmRYx9FPgPk4rax4hS3b3RZEeN96DGcql0yWKJhr2hdZBBix+ZtC744y7E5zu0kas7gyozj+yZwOhGyh70gBqMRlIvkpNmBhKajMZr8BlLi2jSsN8A9Gswni9UzAUBHrbsbOSiyJrr2tp/UJmdnC2c5MiiJPxbjatJFovgLiJN5ah9UGJM8D87ydiEXJWsFUaQQ1tekU9l5auKYUv5zXySe3lzRC4h8opvF76udBn6LCLH7V1SWgi+NPEoC/HclyD/17hIxSQzimwDG1PslpT0ZNaaziY3oudKgfIgVG99akzdlxmpXV27EvbN5OBb9S731VprGPlfn0+Bg7/yU5DIIr9X8TXSZw85qeiXDPjAzNmCdYm9OQgPXz8vxUbu6DUocWs0OkHDRgAn2oMffNREsUlT+S/1PkPYP+7pvryBjyyKQYElPNvEPWw5DfRGYgD2fg8jIbkj6Ldr0X+ox2XPBLmRby/Ra7q0c/VFzZK4F5yP4R5ymdGxlh93AwdsJRK9qcQSFjzy3D9Rp1ccRGvECRWhJ6cg0njIXmIkaUa//anMi+R+DCzJH7EBFDLHON0lQX6zvFf5Ggh6HHHZ19Flkirsq+yl7+fCEtcBAf1Wxj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t/2+/yRTglsczYLwMJWA1Y7o1uzxotzfSWb3JXP/1ZfyoW/+4WSeYw/ZrObKFH75dybD8AkWBYRSiV4PfAm5A+ulWaeYHGguQ0/ZzvZ+17pWWUUxWmeZwgJnGc4cEwTVOIH5rbgGiqLXnGJL8nL+XNuC2CJCiwvSwBBSaLsCir/FqPD9Z9mDozkoLGrEOkxMhg9pGxL0yJq9v3mIDH37YEFSL9An6LV5TY7nEX4308pbGKNjQbSuGRtmtk6KnXm5cvIc22gGjqELVP1VHyiJlwI/R7q9BbXEKRtfqMbvT3ZmxtU7N3nfBeT4lv1H4Tf+vpZocgoOBBQMzRPlaS13JV30tGsz8Q7Gqv13ttD7GR8dlz59FHhykPZsWIfN0pGpX9swqS/5xcnJ6u5bB3YNPlgFICygeUbOrm1X577uxEn3L/KndF30F8w3Nw4xN8E8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:32:31.8491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0c0cb2-34a1-4f1c-6d8d-08de96f4dabf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86
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

Add attr_has_prefetch_loc() helper to detect prefetch-loc attributes
and use it to force-trigger migration even when the stored value has
not changed (prefetch is a one-shot command).

Refine attr_change_ctx_trigger() to only fire LOCATION_CHANGE on
prefetch_loc changes, not preferred_loc changes.

Add atomic in_populate counter to struct amdgpu_svm to track active
drm_pagemap_populate_mm() calls, preventing re-entrant migration.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 46 ++++++++++++++++----
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
index 57103a140164..05a94a790e79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
@@ -228,6 +228,7 @@ static int amdgpu_svm_init_with_ops(struct amdgpu_device *adev,
 	atomic_set(&svm->kfd_queues_quiesced, 0);
 	atomic_set(&svm->evicted_ranges, 0);
 	atomic_set(&svm->exiting, 0);
+	atomic_set(&svm->in_populate, 0);
 
 	ret = amdgpu_svm_range_work_init(svm);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index a1bfe8b47433..4ed19adb673b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -74,6 +74,7 @@ struct amdgpu_svm {
 	atomic_t kfd_queues_quiesced;
 	atomic_t evicted_ranges;
 	atomic_t exiting;
+	atomic_t in_populate;
 	u8 default_granularity;
 	bool xnack_enabled;
 	void (*begin_restore)(struct amdgpu_svm *svm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index cd972026f39b..0dd89908bf63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -159,8 +159,7 @@ attr_change_ctx_trigger(const struct amdgpu_svm_attrs *prev_attrs,
 		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE;
 	if (changed_flags & AMDGPU_SVM_MAPPING_FLAG_MASK)
 		trigger |= AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE;
-	if (prev_attrs->preferred_loc != new_attrs->preferred_loc ||
-	    prev_attrs->prefetch_loc != new_attrs->prefetch_loc)
+	if (prev_attrs->prefetch_loc != new_attrs->prefetch_loc)
 		trigger |= AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE;
 	if (prev_attrs->granularity != new_attrs->granularity)
 		trigger |= AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE;
@@ -187,9 +186,22 @@ static bool attr_has_access(uint32_t nattr,
 	return false;
 }
 
+static bool attr_has_prefetch_loc(uint32_t nattr,
+					  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	uint32_t i;
+
+	for (i = 0; i < nattr; i++) {
+		if (attrs[i].type == AMDGPU_SVM_ATTR_PREFETCH_LOC)
+			return true;
+	}
+
+	return false;
+}
+
 static struct amdgpu_svm_attr_range *
 attr_alloc_range(unsigned long start,
-			   unsigned long last,
+		   unsigned long last,
 		   const struct amdgpu_svm_attrs *attrs)
 {
 	struct amdgpu_svm_attr_range *range;
@@ -483,17 +495,35 @@ amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
 
 	old_attrs = range->attrs;
 
-	/* The attr layer doesn't store the gpu mapped state, and for align with KFD,
-	 * need force trigger range layer to check if gpu mapped.
+	/*
+	 * force_trigger: force the range layer to act even when the
+	 * attr value has not changed.  Two cases:
+	 *
+	 * 1. ACCESS (xnack-off): the attr layer doesn't know gpu_mapped
+	 *    state; the range layer must recheck and rebuild if needed.
+	 *
+	 * 2. PREFETCH_LOC: prefetch is a one-shot command, not a persistent
+	 *    state.  Repeated prefetch to the same GPU must always trigger
+	 *    migration, even if pages have since been evicted back to RAM
+	 *    and the stored prefetch_loc still matches.
 	 */
-	force_trigger = !attr_tree->svm->xnack_enabled && attr_has_access(nattr, attrs);
+	force_trigger = (!attr_tree->svm->xnack_enabled &&
+					 attr_has_access(nattr, attrs)) ||
+					 attr_has_prefetch_loc(nattr, attrs);
 
 	if (attr_same_attrs(range, nattr, attrs)) {
+		uint32_t force_trigger_flags = 0;
+
 		if (!force_trigger)
 			return 0;
 
+		if (!attr_tree->svm->xnack_enabled && attr_has_access(nattr, attrs))
+			force_trigger_flags |= AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE;
+		if (attr_has_prefetch_loc(nattr, attrs))
+			force_trigger_flags |= AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE;
+
 		amdgpu_svm_attr_change_ctx_set(change, start, last,
-						   AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE,
+						   force_trigger_flags,
 						   &old_attrs, &old_attrs);
 		return 0;
 	}
@@ -669,7 +699,7 @@ int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
 	last_page = (start + size - 1) >> PAGE_SHIFT;
 
 	for (i = 0; i < nattr; i++) {
-		AMDGPU_SVM_TRACE("set attr type %u value 0x%08x for page range [%lx, %lx] xnack:%d", 
+		AMDGPU_SVM_TRACE("set attr type %u value 0x%08x for page range [%lx, %lx] xnack:%d",
 			attrs[i].type, attrs[i].value, start_page, last_page, svm->xnack_enabled ? 1 : 0);
 		r = amdgpu_svm_attr_set_validate(&attrs[i]);
 		if (r) {
-- 
2.34.1

