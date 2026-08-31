Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6A2C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31BE10E78D;
	Mon, 31 Aug 2026 18:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i1R1egZe";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C65310E984;
 Mon, 31 Aug 2026 18:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLTisobSWhG8q46ZIjvGbMWFi5x3euAai6oYBca5OYfzitrSZf9bFbOntEKQN88PadJ74sxj4L3EqTjRtOeSmw1IxnYrzM9NxQTNSzeuUbndg6gVxBv5fLMxF/qyuT4fDT6Or3Qy5PoFl6jYrxWCPKdmNpd/l7srUyQrnruqMqj2j9Uv74qNhkPaVlm2n1H+LjC8EwNp90sDKn/xCcPDZEwJGaUWTIQ1hvKOGK86ktAwUw8Xtculcl8x0ahLxfbvZJXc3A1TzBps/d3q+nMBK7xfnPJwSs3fpMIWlWK8aF1SzfIt04uF7Ka+nSK5mrV168qfJTqXBIV+0IlujIa+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8Dmm4FyCV4bRDNVnieY+xRGOlmS6+nt3F4a5ByUdJ8=;
 b=YeOnKaTiqrdGR5kCOy3MwNFKrKoYAkAdpd6rw1m3K0cdBpQOXS68psn7Z8nvKEufc6bZeyjIurEzJrGdJpUwJgproENCB/PsRgyV+2pqtzmv1sgFM+1ESjnF/+icU8l8o3H6L+KGzyemOVh/cHncOHjUF1aQwgmKdq+6hu6o9AXppifcVvYBhlJga8HE2vbnU5y8PZl0NmrUWwf6Tyb2bMzgfdfa/pvxJyz0QusakkgtwtmVS62NoiaRjauPHomG7SDjpMXhsp6+xRMW83JyC/Dq7OeagUBNr6W7jadhG+qKoTYz6gWjUzbYOJLNP7F+KDVK+e3kTFyby9fw23Odjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Dmm4FyCV4bRDNVnieY+xRGOlmS6+nt3F4a5ByUdJ8=;
 b=i1R1egZeZTVDBQjIEevdNL6wFfycZ/NAO/EglLRjSbqqBx4tUCFjQZExnoIeBiDM2jT8D5fRmT0ZWT1CFFm0QisRDDwAJIT49F/w6Pq1Epl7Yr45Z8KE8Nwyf5038M6rKQi+1+9qjH08R1GWyV/hyjS3BQp2TxBvIdn3tQ+xLQg=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:33:26 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::1f) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:33:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:33:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:33:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Mukul Joshi <mukul.joshi@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
Date: Mon, 31 Aug 2026 14:33:09 -0400
Message-ID: <20260831183311.1090131-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831183311.1090131-1-alexander.deucher@amd.com>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cf03cc-fad3-4432-5808-08df078e582a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: jppH94C8CSmIfMvZjZsP4o3W3o+wCsBQ/NHdtxC7CuRUsBSan/s5G42dex49KK3yReHzNCUq//qcrIerm0bZ/tuDxxXLOejGabZm5EDKlkA6vFWZeSPAlJ7GxwYeUqsGt9y/IT6INJvAKUIu7S95gjGPUx1rOH+nTzcjs2AdKW4B6SCODIS81qVJQSHpliUe9m1ZuWCUwavZSZu80yUVqLcmnRfd574SI9l15jqDNMpwaGdbA6jyrDUuAukpXyHA1TNye3lCt5WoaQbI4NVVkqxf8kV2Ck2C5KdcYoLOFZSh1VayPmX4kQKBarqBTo63e2vzKAQN/l3if+2r9B9AU6l1Sf3u4aNk5NJ/DsDVQZxBfpC20KoW36aFsuQvdtykrVeNUqmU6rDYcH3ClD50nqSHe/kF2dpIwd/ySn4qaOSEKbQ1FrA9tIgbYbvLUpuJFE3DHvA5T8zcuv/jBmxTAa5ohxIln2vtQ5C9tBb9zbmCgotOFacBIpqKx4KJz21Xe6LFu1krojD57VB2AZ0je4H0WhmaZprvLT1AWlpGSIQ+WK7zNf0J3yKq+MvP5Bg2iW8jr6q4iHos8/eNxKpY6+SI/9J8F04csXWNyjJMJKQ0jQNuV7/3cJ/xHNZfs+rC0/jSVRM7E6iSOfXYhiTjSCpGH97T/ro7CkF/aA+leEQNvZjy23Hn0UuH6D9gvvmXe3nahG/pYcOEGkCCM8WlSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5hRA9b7qbnWXL2bVDtpuiJPsqgTKwKFX/WyEJCoK1JGV+lDVKaiS15csAZWJQdw01znlDr5BB7A5AIGdodoKIq4wgs4/6T0tcOWLLPJMS0wdfPKQNC4P87YZvcfCmVfwv+zVzVjjO1skzPm9Nm+Dit5UaIvl2m6aqLuAm6PmxtbNmpKKyqaI1MkiTOT675KvJyP8/TteNQ019IaByNBAttrPua2hBlW4FF2o77nCXVgwo/XiduWdNvjMR4s5TXk+QeHr9D5zpDejYkUh4yofrKm+8S5FXV4bZLnlBalvzIQQp6xXjCLuUBZiwa0gxFLiijQwbxsXzJH2hhXK2jYvtZYS3OvzTIofwDEXt0RsyubG1WSE36TAxW/JQri0a8LpGHwT+/DYFXM1ifeFg7b0HuGVjoTS+qqmTmsmBlS4l1QyXhBSrgD5QG/RggTABuCq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:33:25.5396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cf03cc-fad3-4432-5808-08df078e582a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711
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

