Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D9AFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C39210E690;
	Mon, 27 Apr 2026 10:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xMztvorn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBDF10E686;
 Mon, 27 Apr 2026 10:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0Buuyg0e6SuOjaNKCbe/401j0cPuphHXieR4ZH/uOx/njzA0C/mGzM5ICmeeR2NQOvghrAulhAjeaJoC796wGjYMQF8RZ4P7GMS3bQ+mNHmEiAkpnFrGDxGoIpt6r4f6jmGNanSNUnPt4wQ3+19zMTY0VqgJkJ3WJ+NnEgDtZ/TSRYh1+szQ6NZtTi5ShpwYvlTRGKy1+kyJcxK/0/mDUz+Pdhh1HoEe/+330GXg51LhsdtAVxhjut4/fm2k14Nlcyw0PvTal0lf2Kx0zgujXRsxDcPN8nmR7PQQza+V9fHRWXLQObAxZ213xsOH5bNSduVp5Myo1VOAH4E90fzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8GPk0uf7qJGrZ4Xsu6rRtCSGcNukxXW09L9Nq4bf7Q=;
 b=lLv2NZbmyobksCZ1xvI+EV2+z4gou5ofe62Xe1VGrtGIdsS6cRy5cgtG2cavq2aQcj1MSfj72vojrfYAc91LIcITgq851WKF7d1UIhQ9Jacc/Y/GthLvCJFFIdn99p/nfbtKzk9CEvmo3dINxOJ9GtB3zbmkl5mpIpOi0Y/q3UgA+0yeObipfsj+0OphacJLJWuWHm5y1qEwzwqVv3bAXXXnGx7EALLaTtYXKquK+8H423MuCan3kWAJj/LZcVn1eng7Z679hePf65KgcnmpkA6rwaA69xhYyIJL4v3Um9zm+nxkXrVIsuBPqY4/O28QgHmKMdBcVz5cfZFmqd6FDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8GPk0uf7qJGrZ4Xsu6rRtCSGcNukxXW09L9Nq4bf7Q=;
 b=xMztvornkyfLk3MYENa+KPWxI5PPcWVgG0UjqxzFdlTcODPhD+zjA9vp+0+bwJjgulq0lAQl1jbb4vwFl0Sz9xPn+FQpVxP+ScKz5go50LheM0anaRM8GPd9WTMOzv+pR8N72LhR9T2YI/TpSNy3yGOu/7K1Fn7c6DIrnq0iUtc=
Received: from PH8P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::18)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 10:05:49 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:345:cafe::9a) by PH8P220CA0014.outlook.office365.com
 (2603:10b6:510:345::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 10:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 10:05:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 05:05:44 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 05:05:41 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Junhua Shen" <Junhua.Shen@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu: add SVM attr prefetch/force-trigger
 functionality
Date: Mon, 27 Apr 2026 18:05:21 +0800
Message-ID: <20260427100522.7014-5-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427100522.7014-1-Junhua.Shen@amd.com>
References: <20260427100522.7014-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3f3503-767a-460b-27fd-08dea4448e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: A/Og6ZT5rXDmUPusRUNP1lqQ4HTmGeMEyn13g9uHVCHLg5rhMkx7b0wSokti1AdFAxzZdzBK10Q0wfHpDXS9LxPpQlhe8rCgbTfGClSWqAVrMuxRwRgX4sSYjYE3t4ZBZI8P5rOaRp7ytREpiUfqA8K4YCKHmp0tVEJAT/CQWxucXL7il4DF9at/YcEUXiQ3cwKV+Xe3bh/qBfIcjEzPVR2oIwrmN1C/CmTFCQXQcgWAgS6sPyvhpA6o8DhSTJM5jXB4nlNQrTDXjDWkN2GDehrpLpSYKziUJMXSfwpry27PHK+mUGbxtr5gbx60nrlPX80qxbHC889eapVNgpRUvppBhSUgY5AZi1V0ARnYR7tlWjS0HpWTb2/s2O+rXaxEYwXpnl6c122PNyKOXpzv5ZfLyim0vrvDR1X4R+PKrl+oo+U/VAPS1NZCrqWDVLnn2/q7/K5VDgl2OOQvnhpYA2zeYvPDRwEF1QZq6E+OFjF6TEJIitwWQ5+uCaLqTNmzHwgHaB9vpZ2qJGN9aIiO/U2fGl47YBOkMumK2DQ51ifjClIMBJYD1ErcFrwRgFTwC7kxdX8SVXeMs1Rmls5uEfTT3lGQKAlgsJaHxHUur2qFzYzrSH9Obpzvnojry7fTO30TNOQks9ronvdF2mOCOOyVRvaWTY/pvA3bTxqukU3w2Jr9b4yA0deKcsUTi2WLdNPR2PmdRewR68j2mcRAQQxXEsLNAWpanGdxrNiSPxjvwmLkErLXAqNh8ujq1HQLBLSqTPrufPxGe3laKVeHKzlxBLVAsndjXXd0oWIZ+MM0wl83lUgE0BRF5uFfPyM0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 78nankL0kLYmFj0i+EpUBw5z6AvogdUhg66JzVdCrcKsoVF8Os7mdE2Z/ptrNEzrrdxDeWPeEm7/6dPqjY0n3U8GzbFQk9dMSAXS/N7bp66EXaayMLOQnBup3uqQdvrXtSFSl2ma1MFvOuFs0RUmPy6FYoTJQbaoMAJJygKwI3Gf07yr7NdFb6fJUNcWW7GaJk7bMoOs+U7gPeL63wK0XiP/UAerFMtRpG6NB1uUAEcOeqJzC1O2zW3ZXfN7fUjrt8X+xvkuSYaey2+V6A+MGhvmZcS9RVYUVdaAjUZx5MHzZfHIJWj+6rIJMvAm3h9sbeT47403tqeCROBvvu5tLNwfI4jI85yriv1RhtjVav6Q2hfk8jjDqlt2jGr5tkl21DT9eux6Sdd7MZlNznf6aJgoz0wCfNViG7pLdjKFqTzWr1r95GVGj3A9Z351aKqD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:05:48.6776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3f3503-767a-460b-27fd-08dea4448e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
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

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 34 +++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index cd972026f39b..52e402c18b0e 100644
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
@@ -477,23 +489,29 @@ amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
 	struct amdgpu_svm_attrs old_attrs;
 	struct amdgpu_svm_attrs new_attrs;
 	uint32_t trigger;
-	bool force_trigger;
+	uint32_t force_trigger = 0;
 
 	lockdep_assert_held(&attr_tree->lock);
 
 	old_attrs = range->attrs;
 
-	/* The attr layer doesn't store the gpu mapped state, and for align with KFD,
-	 * need force trigger range layer to check if gpu mapped.
+	/*
+	 * Force the range layer to act even when the attr value is
+	 * unchanged: ACCESS needs re-check on xnack-off because the
+	 * attr layer has no gpu_mapped state; PREFETCH_LOC is one-shot
+	 * so repeated prefetch must always trigger migration.
 	 */
-	force_trigger = !attr_tree->svm->xnack_enabled && attr_has_access(nattr, attrs);
+	if (!attr_tree->svm->xnack_enabled && attr_has_access(nattr, attrs))
+		force_trigger |= AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE;
+	if (attr_has_prefetch_loc(nattr, attrs))
+		force_trigger |= AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE;
 
 	if (attr_same_attrs(range, nattr, attrs)) {
 		if (!force_trigger)
 			return 0;
 
 		amdgpu_svm_attr_change_ctx_set(change, start, last,
-						   AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE,
+						   force_trigger,
 						   &old_attrs, &old_attrs);
 		return 0;
 	}
-- 
2.34.1

