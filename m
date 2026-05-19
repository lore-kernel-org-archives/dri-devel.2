Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA695CD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0130E10EBCA;
	Tue, 19 May 2026 09:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ia97A+WW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D3D10EBCA;
 Tue, 19 May 2026 09:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYp1FR1vK0kwkS/+8SKswMUx0CSc5/2MQgj8sk1TBx6XzzN1BA+XxqORxaI2SoVVwQ/zwxPFqe1y8/G6UsQ7TQl4v19yCuZtl9f4+IxqHkQieHiGp7HZW2KSMhJnVwh/jhqmilqEXmOtl4JOiq9NSXdLPCXfCw46NUA7uk2zSAQNrS4QNwVoSwCV1v2vpYJcPHULZZ3CENL7x2IwyEdYDaOg7bxW763Ec+zP5rtw3wSwhiyaA2ZTCzFUS5oRrIUA8MFatprCI0irs16qPyizQ1bDpfdRa+Ipy8N8+0I/zW6JcKx7uAKcS5s5fgPA8SnO8XkRINbPYagViHg8MFGvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP3voPR+pNBY9SfgIDrleg3yHh7eJG4XflIEbg42HoM=;
 b=oGh/E7CVVhJoJMmgZx9wfjNWhf9nqJIP0H4zRMCDFSpBJ7i+C46RW9RxbEGpDT6IsjqamWqqcN5CKGZZRpA0nro68emDdRCjuKZXXSxIHFsz8Z3vEv+BHGxdEvRShY8wqoNHymox6PJ4LA0287o6fX8RrdhL1+iqBKCPREnkiDYRRti//AT8nFty00LYOeM97oexlYY3S6CGhpTYAqHqt8Ej+VQdoQWyM7Mm1qisDzNbIn4Kex/zdBLfvy0dslWV8UvCIeYI/+qQDGmZdXmJb3j+Wp7VnMDFW/KOItHwuSl+QzbloPNWQeMD73DcmLWbGWNMa0eXa2PhopzTyJ8cZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP3voPR+pNBY9SfgIDrleg3yHh7eJG4XflIEbg42HoM=;
 b=ia97A+WWfGoRj/xlxdtgDCm+Ik6xEFGViMdo6zyVwXMl91Wt/kjGv4H58Es2N1yOOhPgdUCXlE0NcfWHF8Lp9RysTFXnl6TDObBQUc0m4zpjVewGKDBmqeZSHQ2PU1OSKDfZUX0UJBuIh0gxKqqizgWR9e9xybJLxN5GBWufAo0=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 09:23:59 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::8f) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 09:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:23:59 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:54 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 6/8] drm/amdgpu: add xnack-off compute queue quiesce and resume
 helpers
Date: Tue, 19 May 2026 17:23:11 +0800
Message-ID: <20260519092313.3115848-7-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519092313.3115848-1-honglei1.huang@amd.com>
References: <20260519092313.3115848-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ba0b0a-58af-459b-0bd0-08deb5885bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|921020|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: uOanEIiWKr1qMPzdCBABq+jOOUB0LFibtveAeuJFuMvMKwXxuzFFg5HN8c99XEPsigas+dbLu6uibMzT0KkMOHARxEXiyoF3yIFltSDS5EgPVUXms8Hg0yOuBH8NnhxC+v50yeKmG1cOuGEfiz3WzxQi/zcpMVQUcjrbxve+OJe4f39fhpR0JjtaMrLXh9Vakub0wgaLzp8XON+uyPCBUpaODRRoL1jkTlz85wBZdoClu6WZOKSrWscwb3ngWTK4nGAb+vEnF8DYj0II6GxtR4YC/bMveblP2eSgQ7qS6/fC0zU+wTsEB+ogGpM2PcCnKmxUJ7v2y4xdcCPdNiisdV1rMQNhYB/HuqOG8i8OfkIdAfD9Yew27Rh64+vCWO1qMjrIrc8QSAakWFFsbtv6bQ8FEJ8kxknGpu9ei99DsNiCnodwqCaqzvJf1t1s1KFO4jybqjrqVNqMqpcIEvYDEIWk2uxSxg+VqphZh8yMqkGVHpQXyMXwGX42L9JFOPGri9Kp1UpkT75t6viuFwGEXEA+jdwGrjVU0hRVjGUjssF03hv9RPXIAvIG7bPaEVl1r3bjjlyGN5tyU7q+PExvf77x7CUCWXveWmFqrFQXtfzRWDQqXym0KKM5JtrQYLO/Lyjw+cbth8flt7+SL27c52gTYMPG0CZt7PliruWW0ImnDT+RBs5Y9od7C0Rrhm+MBFyhQtBtRIGVBaHJAtL/mtoYOgZar4+4jIaQazbXpYcqOsqURfLknBVj84WoNOLSuVgau8JO8xbLtsXxhpdfgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(921020)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0EdlAas/bSdMLEizHRA+vN3msoXZ1px6EzSrEHlPqIGaaa2Vo0xyTj3PgwLRlDfqmBDW2zK4uLNJ8b9JXh2+9T5aEWrmXwpMKzRT0VnlA5prcGZLnAlTgD+9aB0KpPbhIV/YQO3Dlw/XDXlHW9+ykeSb6jMTRlCveHUYDKIUDqD5jsC64DmjrIwENOWXpFD/7hC6KHNC2fMZW6ScTNTKuPPHEJC8AFWfjIBusso3gWBBmat9pZNOfdTAhH0+1vt5ettVCIpvKfYUr+MBQ/DFtGISLmNxchYxIdX1dysd4cYDRvC0fh4+p/0spihnSr6tQEj/9QWbPg3JK7IdWtVzQZ2Hoc//H4MZJD6TvnQL6lUyHCNZhv37GoNrrS5Kc3DzboKazXzF4B/sv58cUlsDN5tIQi7DOcYfBfzzKftEKm2aKstpSY8HVJ9THtz+ACme
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:59.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ba0b0a-58af-459b-0bd0-08deb5885bef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
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
index 0b02008be..34b3b4149 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.c
@@ -566,6 +566,66 @@ void amdgpu_svm_restore_gc_work_func(struct work_struct *w)
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

