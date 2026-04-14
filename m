Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F2EF9D0CC
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEF110E5E7;
	Tue, 14 Apr 2026 12:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1/K/v83T";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1007010E5E0;
 Tue, 14 Apr 2026 12:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFtLyHcf5+oF3QWZdjjCn63HVxOKgdhAkvZ3059XQ+uScuil7GhtlaXSjWvjh1dfT7JlkkUzokTB7TdRusmY+LjXatZRgDBF8bCxwchVZkLx04PxbsCUPfl2q3bPtrTL5bZaJ6hECkaSp8PyvDHWPKTzEOe66DTP24c8xlV6X5hTT9bhCQtVU6sjNIyCc5sb28wVeFdsbg03S1YmYaCSYmZAYRR2S1VIOOuFkDxUgN5GdMPM5aMMUBnYXvEgJJOIk7Y7qUa5j8Vy5N2VuJ4mDZV5kOVXy1zqEG+gn+n5p3uJR/OeIk4apO5Y2qd/cPzYvjrVr4V3AC6u23j+7b1AIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NXQqEVtRi5V6/vnq5FbRowe0wQB44cY29KtoCawaSo=;
 b=U7yKyhsK1JInjJK2+UYZCyRYxtXUIm0jgLMd8H3nsf+eDckcvWP9LHjPCLQWNBZ5R8/T+fY1dWS/TnkSQ9LlZ/62XkomvJj+CYOnFhOYxrb1vVGDh2mzhXLVEnH7OjA7APiIKKL6NeKiEI9UJFUJvcFw3bqndTPGqQyzp7qAJY0WGQ7NgFvOPBYnWRzQETCj1wren67/CjmesbBFtZG5K6TgTi3RlYRyNwe2umNLYQuPhJVrd1pX8xkAhCcEe5M2Lku55xKp4N8DqECg+Ti/7bg6OQjOvbdQm5IUiYJes4bCsvgzA8ENO7ZWa3sP7q+eMqjVkvykpuyCdXXnvIOBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NXQqEVtRi5V6/vnq5FbRowe0wQB44cY29KtoCawaSo=;
 b=1/K/v83TPJP7Y5YkJnj+xkna2oPgo739vyBK2jsRhCwMK60C6EN9UD5X5Ef6ZaQmRqkgdD+htqLfnI65hdwOS5rkuTwmfofSJiyJJnbHkid/pG6qlhGqcZ/2L0EfCVUUZYyoZtNvXfq2hRnCRkjT60BsBwVW1QOwCr1Li9CZ07w=
Received: from SA0PR11CA0172.namprd11.prod.outlook.com (2603:10b6:806:1bb::27)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Tue, 14 Apr
 2026 12:25:53 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::1b) by SA0PR11CA0172.outlook.office365.com
 (2603:10b6:806:1bb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 12:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:25:53 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:25:51 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] drm/amdgpu: fix root reservation in amdgpu_vm_handle_fault
Date: Tue, 14 Apr 2026 14:25:22 +0200
Message-ID: <20260414122523.3645-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a7ecc8-8c60-4a23-4490-08de9a20f89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: plnJVRr6qPfWa30oA2nrEgU6pHXHTsox1utbSZ4+UWAAYXiwCL4k/MZGYU20FiSrL9i9/d0qQPNsfOJzxEVJQs3XmmiWLy3LJ70/HzzMJmZ9ylJ525nQRbS7CWw6oWKso2Q6UzYNHThzp6eCAGFbk5wBEigzrbGN0EPyAmWAy6+I/gaTcMgJOERDzkBiNDoeBrZ5ykIOD+R/htPdKfw4zxP7VJQGBudwV6qgYe0OaLAgjYWqq0ZzRCQY033fTWRplhyIMOVsEZP7+ZcKJPYOC3jYUH6A28VmHkwgrvtbMcaG3/WEYriba3cGqSfBVgzuqD8GQaSavovbdqvcCiXD3S2+BkZNkSxth8mkb1Z6fhQMJCYOPKeWr+IRLnmqPCW2UoTwmccF2pYq3ZrMjlf9pDpCA6sP1yJRaHj7u9rAiBOOxBLID7cWZTgE0n84LtQ49hTsEWdRbf8Y57MjVylQdSX3OdrPZAaKGEZ2nvzeLWFE2mEFv5DJJAm4u2qH4W0t852Yh+pqLcfX8/0P/a5Yf5GpW+OsDysTxBc5kAUv5dshe/gIft1dOTa0n8OdEfeMKclkB4S5GhQt0i7aXJzPIVDWMVSKD38WEiO0CEe9158T/vlBid68N+Dt0kw41mi0vjHjwtieK2Ikup4Oj30LAIXSpnpxTuQzi7Vd2DXDDb4TznzAYrPSuJZgCV7PmCSo3orL90/4QQOj5rnZBYsj6BsoesQLW3uG6bMg+JCj7BWJuhEESXUzYTOySMuRsNOm7UALnqvCTHY7sar64Ql3ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tLId/+Emt2NDNm/PPuUinSNhzVGMNpm0JF56M7bQSf+1T8r8mF9b504TEx1Tj0edYXQG3wr77ABwhtX05hAPHEE3xKI4aYGoGLAtkR4FSM6de323n2QCTRtVuEYQKn+g5h3Z5aWTb8LNAj/wUQ1NoZEkb7hFulvfQLp5l694K+8wBeyj2FUv1DphbRjMOLU8rn9XPzlDjROnalKzT480EPeUXQhGrCsfVrmSkCBE9i7dC5y+PGQlK7BtgzaRWDDMQLrbNJEM0VdKzY05WGJfjU0Cn9/HAKI38+xJDbQgUIzZeaJnixq/sy3/YBDrwTjesH46v/kB58L33YD98CJhdPcUbxqEqG5idGUGjtVI+4m8EZGjBzjMLOpeyCwW4lUzZu+9TeQLLE1C5zJMieuttb9dQs5n/meVTbJNImRXHfws2hDtXY9NxnkGVVaJjNSA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:25:53.3091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a7ecc8-8c60-4a23-4490-08de9a20f89b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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

svm_range_restore_pages might reserve the root bo so it must
be called after unreserving it.

The code checking that the VM still exists can be moved in the
"if" block, since the VM can only be removed when the root bo
is not reserved.

Fixes: 32b486e8541c ("drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_fault")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 35 +++++++++++---------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63156289ae7f..d86be0108913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2975,25 +2975,12 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 		return NULL;
 
 	r = amdgpu_bo_reserve(*root, true);
-	if (r)
-		goto error_unref;
-
-	/* Double check that the VM still exists */
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm && vm->root.bo != *root)
-		vm = NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
-	if (!vm)
-		goto error_unlock;
+	if (r) {
+		amdgpu_bo_unref(root);
+		return NULL;
+	}
 
 	return vm;
-error_unlock:
-	amdgpu_bo_unreserve(*root);
-
-error_unref:
-	amdgpu_bo_unref(root);
-	return NULL;
 }
 
 /**
@@ -3026,11 +3013,19 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	is_compute_context = vm->is_compute_context;
 
-	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
+	if (is_compute_context) {
+		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
 		amdgpu_bo_unreserve(root);
 		amdgpu_bo_unref(&root);
-		return true;
+
+		if (!svm_range_restore_pages(adev, pasid, vmid,
+					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
+			return true;
+
+		/* Double check that the VM still exists. */
+		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
+		if (!vm)
+			return false;
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
-- 
2.43.0

