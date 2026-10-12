Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF2CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD79310F352;
	Mon, 12 Oct 2026 20:32:38 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9212C10E3A0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyQdMW/8XsPd48nQfc9JOlI5b+MpUx4a+xc0K730+DuBud2LbNvAE1o7A8ZPr1WrZl4TDd2dfPb2KYuqCE6gQb+fshdH96R79ey56N6mkp3eA8KDNNDiYlCgRs377sHGeZlrX+0DF9fzE/b1V9/4fBKQUYbf6UnwYb+bW/Me3FYhYDXwzy/sZFmbz30ENEnKg1i4gYNPUVsHKL6ZwCYlxKqC2oSszukGw8J923KHEtZ8eU6Zg5P7VD3K5XJs2wJI296MkAehBacPQ4VuyJyzMiPt2qlvK8FGmDeHM84r+T40DIQmq31sLQoGCtxYlh+XqyWSxpRqqDQwaXGobXcsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UgQb66GPPvIHEjQ5C9TWh419/KexlLC6rMO191owDw=;
 b=fBdEYV/IXZ6PrWrgHLM10qsCr4oL8iwf2XmcASdjv6xMEXeeMtw5o9lFw8f741aeeIo4cp2L4jUcLP5g8kFgBVELUzFvuliTf5ljjZnlGzCtWmWcGFHHXEeBMt0O5rqp/oW4R9GSSSp07LPjy06+ohfx6lwNciEWZ0/8bxPWtn1C17Kspa2f8S2aonWPH+5rrpO1OLjuL/fGoKD9N29YJWnZ211IrtGYc6QEGW4RPQgB4EKojTOeKG6WIf6npZMSo701L0xAIzlYm6UDWuanWCSWadqGDf6U4lFsRzyvA2bb7Q/t7BqWI9DoJLEJTtdStI+iqaw2o+xc59KXzhFTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UgQb66GPPvIHEjQ5C9TWh419/KexlLC6rMO191owDw=;
 b=MQRStZLIup8awN+GsuR8YScbuHIVgTV+vAMSjB4gG0L27OIns01IdPehUtfpux/vBIvP/ahlaYATqjLd5tZRYALhokIjjlaBQpChz1Z+mpVyLZ+7na2rzW5X6QHYltXbOU4XqPZfK4/GbrbiBATDhsAVlCjH7NhyEOjjqv0ZhSY=
Received: from CH0P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::7)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:32:28 +0000
Received: from CH2PEPF000166BD.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::3d) by CH0P221CA0029.outlook.office365.com
 (2603:10b6:610:11d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Mon,
 12 Oct 2026 20:32:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000166BD.mail.protection.outlook.com (10.167.252.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:32:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:32:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:31:41 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 15:31:40 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Serialize HMM range faults on one umap
Date: Mon, 12 Oct 2026 13:31:39 -0700
Message-ID: <20261012203139.2573687-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BD:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e86af0f-435f-42e1-69e3-08df289fee4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: nxY1N9PbtC/T67xDgTz5HX9QabCY/hOcZJmoCBCZryir4b5PwpGZbicMGbDKSm/D8kS6eOPAqE4KAPL07smFwVjYiOSOrTxvuuPjtB0fms0VekvlRoYRg7LvDE/eEkBUe4CuxG9IzKpKUZT0S4ZAMPPq2Fq989Fp4SrlEyulm4L5tJii1zlP24pdgDTPeAhhnYxtZECjFMobCWH6EYeNqKLOSGJmms/9rarnhwtRmgt2eTApKNw5WxOEDJ9oWHZt6eDBQVqBWtU0F+DRdNRIWs4E3oGvhRNfWfcbdSR77fvI9M8pFvTkGEtb0t68Oqf5AFdw7WM8w+r0C9i1E4R48WWOtxV3EYwRI3OiyYwXJuX+9HjWsryyPJQJrF43Zylj+czGniztbguHjJ+44QwdeovtV3Pc3oC0vOz3b5CEGjTEu3I86NksZOf9q8rfHptmzK0oTVVo0eN5joU+U924siogW6K254eT8jrIKe2ccaaza0Pv5NbkdXmFEsPtcdCijoGtGSCi0wHJ+6lebT5mmKYWCe9xffPw7sYafPHiYhNy/9yAx4CbOlVVRts6T4CB+tbJW3rvd4xlJ7cUjp/I6oQ4tPRjUQB8KngQ8/b9LjCx4yoXNebt4idCtad+r+kMf+qcrw4BJbno2GobrbQ+yVexMzRdpGOP0FskONUmZao4OV1zzXnBUFklldBZ620HgQQJ+MEO+JnKdD/NrM9KhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YXwEkJVEPH6XrT8Ww02qKJlTVZv4oy92Izws9GpX/++zv78yr8hdR9QqXB0Sdt/K2V/Gl1S3jmhrNGi6eI6CY9mB5zqykJk4cRfJibJrVZmMPzxRHzxJkUIuIZp8/yKmmQq8St35HBnxDNMUYVlKVWFqqlOG7x6E259szJfj5Co7bLwhdaclWZsAoA5lhsaFDDaZ/gCU0531l7ApCGMO5BVNPfhMYQUThh6USPnezWolmlRez9Kuisy6ANAo/0gijEeUgyv1Xjz9+/1ojVGkO+t2LR/LZTvO6vAs7d8ZSZrPgPLPcDm+XJri6m5PtkQgVMys4mIO00K6bDtxFGxI8bzE+1UXsqnkJ+5y+M+r0g0OCKK7Y/tZWoY6wCEqqtrevZvlbqjMUItO9WmYP016o2T8PmGOl3yINEjJ7MIwHkX9fBGyQkwBbbDH9aNOu74o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:32:27.2589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e86af0f-435f-42e1-69e3-08df289fee4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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

Two hardware contexts can submit jobs that use the same GEM object while
a user mapping is invalid. aie2_cmd_submit() drops the reservation and
notifier_lock before aie2_populate_range(), and that function takes a
reference on the first invalid umap without clearing invalid until the
fault returns. Both submissions then call
hmm_range_fault_unlocked_timeout() on the same struct hmm_range. That
structure is not safe for concurrent callers. The calls write
notifier_seq and hmm_pfns[] at the same time, so mmu_interval_read_retry()
can see the other call's sequence, miss an invalidation, and clear
invalid. The job is then pushed while the pages may already be gone.
Give each umap its own mutex and hold it from the fault through the retry
check and the store that clears invalid. notifier_lock is dropped before
this mutex is taken, and the fault drops mmap_lock before notifier_lock
is taken again.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/aie2_ctx.c    | 7 ++++++-
 drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
 drivers/accel/amdxdna/amdxdna_gem.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index d927c8c9d557..4db67a789c34 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1155,19 +1155,24 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		return -EFAULT;
 	}
 
+	mutex_lock(&mapp->lock);
 	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&mapp->lock);
 		goto put_mm;
+	}
 
 	down_write(&xdna->notifier_lock);
 	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
 		up_write(&xdna->notifier_lock);
+		mutex_unlock(&mapp->lock);
 		amdxdna_umap_put(mapp);
 		mmput(mm);
 		goto again;
 	}
 	mapp->invalid = false;
 	up_write(&xdna->notifier_lock);
+	mutex_unlock(&mapp->lock);
 	amdxdna_umap_put(mapp);
 	mmput(mm);
 	goto again;
diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index f14484bc31ec..37bfa5058095 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -318,6 +318,7 @@ static void amdxdna_umap_release(struct kref *ref)
 	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
 
 	mmu_interval_notifier_remove(&mapp->notifier);
+	mutex_destroy(&mapp->lock);
 	kvfree(mapp->range.hmm_pfns);
 	kfree(mapp);
 }
@@ -402,6 +403,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
 		goto free_pfns;
 	}
 
+	mutex_init(&mapp->lock);
 	down_write(&xdna->notifier_lock);
 	if (list_empty(&abo->mem.umap_list))
 		abo->mem.uva = addr;
diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
index 9b4aa21a37c9..456a537eb68c 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.h
+++ b/drivers/accel/amdxdna/amdxdna_gem.h
@@ -19,6 +19,7 @@ struct amdxdna_umap {
 	struct kref			refcnt;
 	bool				invalid;
 	bool				unmapped;
+	struct mutex			lock; /* protect range */
 };
 
 struct amdxdna_mem {
-- 
2.34.1

