Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD86CC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A07510FD1F;
	Sat, 26 Sep 2026 01:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tjiOEkVp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39A210FD07
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 01:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSlxvxQd3ojx3BX66+WPoipA6P0+NDTPcDIb9NA4TBozu8lPR1L7PfItGOT40gUAEjG5IiDuLf+AYhbWwEmCXds7ExgyBNMdqYsXC1RLuk2ccvi0DVcwtGnf0Axufm6pErJC45XlUhU8KKKVv6VT4deiI3fHLnUCqBQK03yVEhAg8fTuLTWXJTyy3ajSXusxvmdr2AHrsFFhl9BLoWByy+5+CkVeXPdHRT+TF3NANjqxGp2fjkzEwepmy4yK3/8cD316Y0s4OebdqzUqOoesaAwXg932kq1JVzvKGsLzO8LK0xyJgds0mfip3tzHpaTJ8yzJIeRiu5jmh1pwFMbtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AGXV3GXOTByUOrqUTYosgS9k9n4AHasVEoRtwXM2lo=;
 b=QKvUGH8xQVlrutuBJZMs1nmx+W6XZIWroO8aOhWwkHXVsIcevYHbad0O7XMGCBmEgQ9bN84TTyb/XF4J2AK0RK6xGaJCeK3PbMTwRmeuBDc/IlVmKBMOV9oWyMi1Vky2mqXQZESn81VOc1GFv3ucQr7L1JNrP1Lm5H4VZ8i6fk3RlSNgIGFyYdWWdMc0vV0YmiVd1yayrQAJKV9IbBJiq9SUKXzyrQl+3nN0630lh2vB2vRDcMEi0rwflvHWum2Ghl6dcnFq+jKZDacFQmbDBmjYTNtoLkKaEbmMqQZaI4FsqhQ9+HJhL/RJlfzqfDSXEavUFHw9VylD/GiJvdsk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AGXV3GXOTByUOrqUTYosgS9k9n4AHasVEoRtwXM2lo=;
 b=tjiOEkVpzG3AShVxhTRmSsqZibrs/DkuDX8RcOlQAr0XZt2vE7eHMVCy1PLF5Uga3QFg5GFWmhd4NGQ9PqpDP2Bl1UOijdMA2BOb3+cAsHPZ3IUcXNJnYVdyA3VW0YDb8vcCUBYg2Za1U6AOvij7CVqj3ygqidOzClyHRjazfNg=
Received: from BN9PR03CA0423.namprd03.prod.outlook.com (2603:10b6:408:113::8)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 01:35:35 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:113::4) by BN9PR03CA0423.outlook.office365.com
 (2603:10b6:408:113::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Sat,
 26 Sep 2026 01:35:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Sat, 26 Sep 2026 01:35:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 20:35:29 -0500
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 25 Sep 2026 20:35:28 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH V0 14/21] accel/amdxdna: Fix fence timeline name and context
 allocation
Date: Fri, 25 Sep 2026 18:34:41 -0700
Message-ID: <20260926013448.3840921-15-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926013448.3840921-1-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: b5352b83-d359-4fb4-3239-08df1b6e7689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Uh5mCN0M3tWxiS0XP0E/FQfbNYIQFhOLK8OaaK2MBnBgUatcj0eBpQEL1kGy9o/v80nryrRI38e+TBkaBxeEQHD1Wm7M7mwWdpo+dbcs1KJHWuETXS7tudT1ekNwL0neQ6n1a4T4Wu29qkYCITrYdC2fYBWpdb2N/H9oIcdrfKV+hN+oIYkbZ5bvx2YogW9GQU3Uc5c0+Y1s7x8UccGiFNwflMq9XSPHQ2yMFpr26b4u7PB4fG124Fc51KalvVSQDF/aQqZFyaE2Cnq0AlTBHG1gv6ZZR6B+08Y1FndiMEkR3mqT25N5AtRTKwBkyCgBb9zQOz9SPZj7Ow5NKfAQtTt7mZ0bI6DuCc8bATbQX2KtBOkEm7uCrRtCUJYgm40cKVYRbodyPcW94N0fY/FHsfK5dC46k8Y3ji8nU6BBW8E76HTCd/JhkFPVOXnliQ5WB/U8A2Q5K8W+9v6Z0feN3PP7uqqJOk4hv49SUfozrs/CMg3OAsiHLMmwqIam2CUaD0id7STXJFvSuadeu24pOPJWoPV8Qi5l8JytOoLkd4L4oHA7H+TVwgmD4IssbkamG/iO0AOdI3iVQyuexBjUOu3nmgd8ye9dMK2gvAOFTaxOWplQCq0Z+VoRWz7YMYuipBRjOfQVe6/Uzik5JS/gNyG/QBAoR5rvLaqqcBZ6KtRGAlAio59cg1yfXX80WgKfeJeMf4YfKTDst8M2zzPxSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7pfxa8Wm650LLhoXuhmPdcwHQpr5t2CbqVeWkSnCnrQJcp9qDKb4yLi3X6hcVnm/g+d0bqJSC6tpSZ+5Q5HBNqny0aT9gOsTudYqvFMjWX0YasDSv7qDAU4dZCzWY+ZVYaXsa6OitzpODGRQtBxBPUhb9AchZj6cMxza0yLuCJTAziG7zHwNz1nCz7gY1pnpj5OEMflKflZWf3vx2pbLQqfPuHjLOhei+LPLiYZ5Nvvc5+1s8FG2DKNqvC1dS2t8niGXvMX/WaK/S+/lzm60ZU9LonVQu1K2UBwtEnWp+eai21ctyM7W19yvh7FUgUxdKNkZ67KMDqbffsNvpUzg9YMUZa0doPNzRf1WQTD7UWIIbiOC35FH1JdoHjOBtil183CHZMpIJfoRz/ZGcf09f3HH4ctB0hlPpfwP5wSw7C77gvBPZnFK9LoH6BCz0/gL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 01:35:35.8531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5352b83-d359-4fb4-3239-08df1b6e7689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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

This is part of the fix to align BO reservation locking and fence
management with aie2.

Fences published into BO reservation objects via dma_resv_add_fence()
can outlive the hardware context (e.g. when a BO is exported as a
dma-buf and imported by another process). Using hwctx->name for the fence
timeline name risks a use-after-free once the hwctx is destroyed.
Switch timeline name to dev_name() which is backed by the device that
outlives any individual context.

Additionally, allocate a unique fence context via
dma_fence_context_alloc(1) for each job fence so that dma_resv_add_fence()
does not evict a prior in-flight job's fence from a shared BO's
reservation object when multiple jobs touch the same BO. Also guard
hwctx_fini call in amdxdna_hwctx_destroy_rcu() against NULL ops.

The corresponding AIE4 command submission BO locking and fence
attachment logic is implemented in a subsequent patch ("accel/amdxdna:
Implement AIE4 command packet building and submission").

Co-developed-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Signed-off-by: David Zhang <yidong.zhang@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 888e857ec558..6ca7774150d5 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -25,7 +25,7 @@
 struct amdxdna_fence {
 	struct dma_fence	base;
 	spinlock_t		lock; /* for base */
-	struct amdxdna_hwctx	*hwctx;
+	struct device		*dev;
 };
 
 static const char *amdxdna_fence_get_driver_name(struct dma_fence *fence)
@@ -39,7 +39,14 @@ static const char *amdxdna_fence_get_timeline_name(struct dma_fence *fence)
 
 	xdna_fence = container_of(fence, struct amdxdna_fence, base);
 
-	return xdna_fence->hwctx->name;
+	/*
+	 * Use device name rather than hwctx name: the fence is published into
+	 * BO reservation objects via dma_resv_add_fence() and can outlive the
+	 * hwctx (e.g. when a BO is exported as a dma-buf and imported by
+	 * another process). The device outlives any individual context, so
+	 * dev_name() is safe to call at any point during the fence's lifetime.
+	 */
+	return dev_name(xdna_fence->dev);
 }
 
 static const struct dma_fence_ops fence_ops = {
@@ -55,9 +62,17 @@ static struct dma_fence *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
 	if (!fence)
 		return NULL;
 
-	fence->hwctx = hwctx;
+	fence->dev = hwctx->client->xdna->ddev.dev;
 	spin_lock_init(&fence->lock);
-	dma_fence_init(&fence->base, &fence_ops, &fence->lock, hwctx->id, 0);
+	/*
+	 * Part of the fix to align BO reservation locking and fence
+	 * management with AIE2: each job fence needs a unique context so
+	 * dma_resv_add_fence() does not evict a prior job's fence from a
+	 * shared BO's reservation object when two in-flight jobs touch
+	 * the same BO. The corresponding AIE4 command submission locking
+	 * and fence attachment is implemented in aie4_cmd_submit().
+	 */
+	dma_fence_init(&fence->base, &fence_ops, &fence->lock, dma_fence_context_alloc(1), 0);
 	return &fence->base;
 }
 
@@ -81,13 +96,13 @@ static void amdxdna_hwctx_release_expanded_heap(struct amdxdna_hwctx *hwctx)
 static void amdxdna_hwctx_destroy_rcu(struct amdxdna_hwctx *hwctx,
 				      struct srcu_struct *ss)
 {
-	struct amdxdna_client *client = hwctx->client;
-	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev *xdna = hwctx->client->xdna;
 
 	synchronize_srcu(ss);
 
 	/* At this point, user is not able to submit new commands */
-	xdna->dev_info->ops->hwctx_fini(hwctx);
+	if (xdna->dev_info->ops->hwctx_fini)
+		xdna->dev_info->ops->hwctx_fini(hwctx);
 
 	amdxdna_hwctx_release_expanded_heap(hwctx);
 	kfree(hwctx->name);
-- 
2.34.1

