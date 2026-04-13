Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52968EBFD36
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A6A10E3FB;
	Mon, 13 Apr 2026 10:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="muNbI2dO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C0BB10E402;
 Mon, 13 Apr 2026 10:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fX8AY0FgamSISrYgmmZwFtnT1YBfaDz5snUYdQNxKoOt1FGDByL4RFTdl+CZeq5oWQMci+1NLc7n9CyZXXUFwTQRasQidvPLo34EqLlwwxcN6E6LjNLN8U+T87Tb/U0OlT69UGz9PQTgnKioFpbzOhSnbXoQ5h1ONdrD7OFw7CqrxUqNcCV76CqLIJpOuRq/V0QGXxLSAJkoJax4FDNIoQ0mSBZQXl7XkU1+Ve82sFXO+go6mZu3Airk5VNOYgJBRaPyNhpHIF1DOy0jD64MCGw7PhCd1e7ff/NktVCi6hZWAV6IOxcutwoDkGkz7GpUa6c4j/rQbyMgEz5EIC7TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFz0OJ9F61UM0hi3MJLKTlihuwI6gQzmI1K2yrzpgv4=;
 b=hN+vksHrD59VP36icZPsDy514Ms6nEKnJlvqNjBo5M9UnZDMiHQapUw/fwttjAAWWnA4ONf0rAELJfarWSVpH5Z+nMBcqzAXLLwMI17Fv9Cal/IAgzOoR+JmzxwavbBeNQhgQMZazM2WdioiBi4/ahOzUFlNRyOU5EqifuJfTHUaZrxCx0AWuAxakFAf5t+BQ+6BTR+HOtVg/wc9Br2JFM23MmhK1ch2VP3SQP9ak4plSQgSVfYZElxU9+Ahfm47DuZKu/ltJpHTpeNUAfKERPwNnEUAmjM9+9z7jsJ5WRTICzFg5whRRYmZrQIyu4AA1281TVnz+xSQ74v4nggZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFz0OJ9F61UM0hi3MJLKTlihuwI6gQzmI1K2yrzpgv4=;
 b=muNbI2dOBlRZ4yRNKPF/t1yE/gJAyuKOz/Tz7eg7NbEjHpliO07wxmK/ZsLX6+BzWw+/VbsjLupXeLwPxr/GztVGDfQDR3yFLHbU3KhO+UjPVNKVPRM+Fe5N3Z9XmuIaEZxmnnx5yThjgUmN9OD/5ubG3kf6Jee/RtdzvkVqaW8=
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 10:30:51 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::4) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:30:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:30:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 05:30:49 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 05:30:46 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu: add SVM attr prefetch/force-trigger and
 in_populate tracking
Date: Mon, 13 Apr 2026 18:30:30 +0800
Message-ID: <20260413103031.181953-5-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413103031.181953-1-Junhua.Shen@amd.com>
References: <20260413103031.181953-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fb7df8-1dd8-4d1a-5544-08de9947bbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yKPI0egfUrdzxsPkkjsfvudP8AQCKOfTnOj7EKKMv4WIAc/j2JGF55DCoJ0gjv3sANJmU6fvL+SwhQNB+dCRRDw3H7cFYOmuw2OtrB6RU+JEdNTpJ/QRRKk6sr9l/f2KJtF/j5yMvM/wtHejHRv7BvFMv0Ta6/pkwDRHS+Pgs5TaU8PimSBGtqM5721zQYN1+qse4fk1XC8qgZvKW//glQ3hdeA6qGRLC3yzHUJ2phRjNK20qFKs3dFIUUtkx+tG/tl/kJ5dYRiy7uBTFHvOkOVNXB2to4OjJasrcTWa/8Yg7nN6f9qJTe6k8TYE8WAtlVHyikEosO0rzQE1Yt5VrsPTHtWC3i1PjvDx2ouQ+MG4kGQb5+p92DJ15wjFl/ycoceIpSs3Rfd+MiUUgENimOASzjbgHTFsDJoyR61YChUBh58SC/GzOWmC4K51LEBVTSo8Fz14XVUJu1qxnsmGlFUZuuoFV3lo4EpCpt7z5iEyqbobxnbXvAqSaINKj3Vdo+HapfebB6+wiX382IPxS4JaKEFYQGEOW/Kmuysr6FcG1Me/ZAapC38V66cvlWbhd1cMIeh4zx+DQGPkDn2X7fk4dRJY7YP4GEnF1f/GgPYznHo0u6oiL5EujPyDtiJGlH+Vd08uzCIjmxfojmAYK0YsLGBBCwsoMT9jQk7C6sVChnQ/Cuj6Re7NLfl6NyPHSp2Y4VccW3dN/tHM6fn8uvkaj4D4jRkvwf1RcPtqp/RK5BDTm8mmqmJMNQ432Z74h7L6GIJXkXXPcXC5ZSFJFm4PVux7HKP4XvZv2iSNiX0ZqJPLKg0FZQk/xi3LQdvi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eHuuIP76J3Bvw0OiJyswvN2kKTi1OQZJ2vXdpKAGUP2s7uqi98USfn7ZkBHwj6XgE1nTs0QGCgQ1gwkM9UbjiQ00Dann/iviyT/kuoJEbplUgVx+UrvJYuCgKCFILDt2IB3NA6m2dDePfC06t5uyI6YPuAsCOxtw7Iz7eLp9Ci4wQn0Xs1pXmr3xGoYItL1b6tWixzvmNIxEN4Jnb/vdUoSRcnqo9qGIpCydJfpUhL5pGwjfpvmB6BDcieNKqQrPHEZ2qY1Fng1uaalGnT+lVSk+LaQxLCEE1ilv1FQd0VxZ9zn/m2bghJc7GFjsw6SbX4aGc8dGfoK6rK5yDF/0ul8m5J3aLJuFIimY1B2vS1CSUJpg8brDsoMABpWjUjlPMH/CC5Og2RfNGrEQJ9pHINno9iBgWO9pwyWWvAhaydJdlL8Nhci2nq4WDjgwc/qG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:30:50.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb7df8-1dd8-4d1a-5544-08de9947bbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 44 ++++++++++++++++----
 3 files changed, 39 insertions(+), 7 deletions(-)

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
index cd972026f39b..7fd44e6aaf24 100644
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
+				  const struct drm_amdgpu_svm_attribute *attrs)
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
+			 attr_has_access(nattr, attrs)) ||
+			attr_has_prefetch_loc(nattr, attrs);
 
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
-- 
2.34.1

