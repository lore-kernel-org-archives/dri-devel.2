Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF308CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E4E10F90A;
	Fri, 29 May 2026 05:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N7IptedM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B3310F906;
 Fri, 29 May 2026 05:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5eKV9YDH4ADj+LSgK8Gq+9qvhMRYliGfW7B1vEElOzacbpLRRr+pwaKLvqVSqqIwulEcXeijgUOo6FV3hqi9ONL6DGpb/qLRHEBxBTPS20phNN2NTn8Y17D8Kx03rwisN8k1rI0IooIoRkt5T0bESWBDfEWmCcErQvqCPitU5olTwkUVCENIuT/SNQFdNfZjXw2DR67wXh2TDZzmUZTR/FhTaQ9g6WPS/iZFeEKxj8ORyKwGiDl9yBpViO9JERIspjX/sPAtmS6sAVW18HQAb/UFBci3suCwItWmDLeOKd9J1g/42KtaaoGNLBicFCjp6wANH695shyYQsHKMdvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmLFLMrBwUCrVpft5hD0Y+wRL7Gjial7yvIua293YgY=;
 b=XwzHz1abTliNMXg9YCrHSi4T6r4P2DPEr/m8jVhYScpvYE6UGTt5G3jaPMnuRTaXWnZCIiHdpcJRo94nsxknqKvJhMUoYU4XZShcQ8rV0PE6XnmHo/bHuLUYbqvIuYnrJF1xVG83/flnTl7w5HaQ45uLYFbYcAV8ren37JQ9AqbFBvkHKpcRukmFdMv+Zds4YPQg5RegR0MP6HAEzAXY43FdWdSCWguGEFIb4ZINviQ3vVfZ2YyEk/vJkpkiPNTpVjsSBXbgSqnQ4smImXltFInub0momLQg4mDPhq9KMyVfjFTHD14e7P1HL3QMovkv98DKbFAnPcnErayB+kZfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmLFLMrBwUCrVpft5hD0Y+wRL7Gjial7yvIua293YgY=;
 b=N7IptedMzN0EBndyJ3vj1jd3VIlqiPpbeovnAUs6DIM6ja7mU6n/EA/tE7VtHBQNAh5/FVj3EV/qBdmm7oYqAI2Czaspq4F/gwzm/9S14XucSi+g4xfM7PkxyNqq9K1/q+ueAl+p3ZdfO5100TvYAS2PU/G05a0UOuaH8ST1GMY=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 05:50:13 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::4b) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:50:13 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:50:08 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 6/8] drm/amdgpu: add xnack-off compute queue quiesce and
 resume helpers
Date: Fri, 29 May 2026 13:49:26 +0800
Message-ID: <20260529054928.596825-7-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054928.596825-1-honglei1.huang@amd.com>
References: <20260529054928.596825-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3577436f-b080-458d-2cbb-08debd4626e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bPP9O+gMeRd1E4oQSqB3Iv2cVIdvBld94nVcXp1DKy3ZSFJM2TA5wYok9Jmqq29BubJG4m8LA1LhFNmTUSz6gKSjYAhdCVCrifLlRllHG5dpp5bnsX18AM4y5OwlX6/3oLZ//jTlvfqJxA3ibOvpKsMJTrOD0r5vEmRJTxZvW+zJHSd2EPzcFT0nSHJe2bhrB91Hr6fQ+TLQIRkvXRGeFqexnzw8mhCj4gJH/pDYmowbifBR3bIdsy/ti+MEaP3R+Qs3GT60LpLnD+Ye8b3MGm+JPoaK5bEyG9zQ+r3uhacBPSZs0yLYb0KHEr/F+dvxHO6pzuDDkDNYQ2/gkqL9P7dAXcTl9YmnTYr+zBtbbRVUVKSoByMIwzfqXUbdw9XgotE+t1eiIq5f9oOyxVCv9weXpumaGmy614+ljIGrsbNDYupNjd74HCSbS2rhlDWUnl2+16V/Vbnh6Ms1RldTtoSJVYjn0fzYb1o1J3T8rGe8kv0SbQq7IbGw0ooYhcsxmx1cYxbApvg1nxiZMWISDjbdQh9FwnUCcXg9GCek/bWTXEhLGWqegS6CgWyRVFWMOGNKmd0JL0kEocAz1I+1qYcGP+Vu2tbLHv0OpwMUpvA+qHrJWvCIpHTd4kTRP2ZJt+zVtlNBdYx/Nd4rAgMJ8nNhQTdhdmgYH4+wLb1v8IBRWfGLk1AlU4uXJwQNyPI4TAxD3wgkruKaIcwYODBnNEpy3DI4dXZZwWua2MVVkVeGbT0I6EddpkI+KPSQeledR1B6FbVQ7LCCGNeRdTsi2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q8/Oe4+vshVOToBelDpCegUTGHgOpMBtkmVsj2WpYr1QqEXat7i5jWv1jirqhm6giGJTZzmcoWI4fIvjf3TYGIGN9AaFLynjWQXTUVbhmzuU0eBCOmRToWtnQvylH3miGzhdWQomHhQ0HedYX6bTKj0X3BftFQnZFOg045DAREWK2PeHuUR4qTVOJUUseLrFdxNJxr1VUXeDimB3Ni0phr34/HddPhX2Y1cz4rorP1GaeNMtVRxQCtcP4D/PEh1e8En7HOCIVZ2iKUCVosJxWE16ls55N3GSL69MTsxSUpDRU9+5jP+8QbtYkzt3OIUyk3z2h5DnqC4Y2WE+TRIhaPdGo3ewGVE9mU2T9XbAGiR14v649I3Skebg9Lz6yFAviJpWES7Qm3I+ohgtbqyrgcJJ5OOz8PGEB8geNsrWqS51dotUv+NaOx2/pkYbyvfR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:50:13.0442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3577436f-b080-458d-2cbb-08debd4626e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
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

From: Honglei Huang <honghuan@amd.com>

Add helpers to quiesce and resume KFD compute queues for xnack-off SVM
restore. Use mmget_not_zero() to safely acquire a reference to
svm->gpusvm.mm before calling into KFD, protecting against races with
concurrent mm teardown.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c | 60 +++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
index 829e88635..22f19dcc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -584,6 +584,66 @@ void amdgpu_svm_restore_gc_work_func(struct work_struct *w)
 				   msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 }
 
+void amdgpu_svm_quiesce_compute(struct amdgpu_svm *svm)
+{
+	struct mm_struct *mm = svm->gpusvm.mm;
+	int ret;
+
+	if (!mm)
+		return;
+
+	if (atomic_cmpxchg(&svm->restore.quiesced, 0, 1) != 0)
+		return;
+
+	if (!mmget_not_zero(mm)) {
+		atomic_set(&svm->restore.quiesced, 0);
+		return;
+	}
+
+	ret = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
+	mmput(mm);
+	if (ret == -ESRCH) {
+		AMDGPU_SVM_TRACE("kfd quiesce skipped no KFD process\n");
+		atomic_set(&svm->restore.quiesced, 0);
+		return;
+	}
+
+	if (ret) {
+		AMDGPU_SVM_TRACE("kfd quiesce failed ret=%d\n", ret);
+		atomic_set(&svm->restore.quiesced, 0);
+		return;
+	}
+
+	AMDGPU_SVM_TRACE("kfd quiesce ret=%d\n", ret);
+}
+
+void amdgpu_svm_resume_compute(struct amdgpu_svm *svm)
+{
+	struct mm_struct *mm = svm->gpusvm.mm;
+	int ret;
+
+	if (atomic_cmpxchg(&svm->restore.quiesced, 1, 0) != 1)
+		return;
+
+	if (!mm)
+		return;
+
+	if (!mmget_not_zero(mm))
+		return;
+
+	ret = kgd2kfd_resume_mm(mm);
+	mmput(mm);
+	if (ret == -ESRCH) {
+		AMDGPU_SVM_TRACE("kfd resume skipped no KFD process\n");
+		return;
+	}
+
+	if (ret)
+		AMDGPU_SVM_TRACE("kfd resume failed ret=%d\n", ret);
+	else
+		AMDGPU_SVM_TRACE("kfd resume ret=%d\n", ret);
+}
+
 int amdgpu_svm_restore_init(struct amdgpu_svm *svm,
 			    void (*begin)(struct amdgpu_svm *),
 			    void (*end)(struct amdgpu_svm *))
-- 
2.34.1

