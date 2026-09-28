Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF4CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 02:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6685F10E718;
	Mon, 28 Sep 2026 02:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qye35+kp";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE9310E6DF;
 Mon, 28 Sep 2026 02:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDi6vXJw0R2bO2iCloBQJkT0Qax+XMAtFj/eyI580GXCyZ87PZmbKx2TM5HGv7Fm2Z3EV9gBfrAwd3XwNJ3LzNBss/cfr2iV7bwnHvjwzVsvzB/jCEroKFBQvjT8CO9Vnj/Eek3gXlNNhtApf/lFpEjESLaISZ0dY77amkA5Q7nLl34wAMtHGAknhfBDUBmxx3ofLfhAkA9xLq1kj/UMDYNH16m3uszOfy2bQNabN6kD0EdTCEa52QEDKbUFCkN9XKw9yo7mYvA5b0cd1VzLrf6oGCsC0yeve7sg4UjS1Z540yCHn5tYQULAHCL/XxUNQ40raiUkkE3uN9M/jw5K8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCs5MT5llr3zTqrn7Pj/IU27DAPEicr6L97N39DBMvA=;
 b=gXo6GG16B6UOkGS0A7yl5gbr52adELgnqMIZVbK9R32JHxlfmGcmDjl9U5WgUOiPP2XdCv2ygzasJPv//1ZudPpMcDE2XDlpgfzAmeNZ1gh4dEZwLroaNTRKr/8FXUug3/l61Mcp6EltGm/3SU/3UCvxiUMUDjgKD6g8tMNA1wXTE49TuwROk3DCIBjb2tCKtNpGomEixvSh9/FLiM6A1w5l0l5PUvtxKDa0BVUgWyiep7Nh7Fs3JQq25rqt+FVv68kX+kG+ma9KxxX0ZffJFHvH4ei9BLIuwVAIFEr2kiQY74JilrK+vgtc0UHgrP8ujWPRr8IkrPvgmFl+DHvFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCs5MT5llr3zTqrn7Pj/IU27DAPEicr6L97N39DBMvA=;
 b=Qye35+kp6+MHRupVsy1QcfVNr8U/ud8MdvoJtxGOZ6LtXvxl8utuRCYrxgblQk9+Wkpz9SJPWUOE9/rHKx0g86/NlISKlBGwfKtzWUy6FJj9rSkbvPF2RWn5UeFE0g1wUUOlYhFEHmpwHH9zhLDF50CfsUWyKGL3WcjJbAFkx5A=
Received: from SJ0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:a03:3a0::18)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 02:00:27 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::6d) by SJ0PR03CA0253.outlook.office365.com
 (2603:10b6:a03:3a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 02:00:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 02:00:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 27 Sep
 2026 21:00:26 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Sun, 27 Sep 2026 21:00:25 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Matthew Brost <matthew.brost@intel.com>, "Danilo
 Krummrich" <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/2] drm/sched: keep the current runqueue when no scheduler is
 ready
Date: Sun, 27 Sep 2026 21:59:02 -0400
Message-ID: <20260928020018.120503-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: de67f9f7-4836-4241-f7d2-08df1d044458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: NmDPw0VhBZp9QjXnsrl6df6ouY0gfOgDrkq5Q/HarmSsYQ2H75KgR0sz27ati72no/nvX7+kkdP2/IXo3QiXVjg7cNTj6E+pU+/mEaxbHHGXGb9CJPRDTXVyxbaxV59wMUTXjnCKAen5GxEnaACGwBEYng6gX/m9b6cJO3BypmlWMzYo1793kCcHllgbfJFOFnPmpU8GP+GBei3efzvlppfj62rxQDl3zEnVn6G4IqOw65arsmhkNUG96fVI2b4zpWq9RBYpCoHiFjofROVjj4TnZj8Txzp7mmd5ROVZMswNRDwzjNw0VeoK+sgMgPu2gpcYaUNgRtsGQzwUFitrs7IIY810dXLK9GWx+RfI02t3PJa4eRxA1LpeAUfXKfPLqAxdeRHOYejbQzCg30m3SA+4eksetVGPCKtpoFU/1y7TKmHB45v8Ven/jKbbgEEezKVuwxbFpSKWeM/rAfKYH1s80pcvMT2WJY6v3RpXdFnhmK6m7m6S2DwaijRZsMdvKizracRB7eZ1rOxtg0hr6A6c7Ho/9s3iaI07v5I4euGS4aO9wv0PpKEu8AKc9c6Fa6lFcZSVfbq/LPBdf5u2ZkYECeAWDuD/lOHFwy/UBo8fErVWhyeK3SireSc7SrM9GL519ZxGzN2EM1CyTHMqkGU6m9ubZyGe/oKXpuNjBoyth7yEa4EXeDXQsBkiDU6k9GwxTmS7PN5n8Bco1TmHzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y0j9COCfuS5wPdpiqq2UEAnOWQc31ObUEOFCsINMyNtA9atrg17sJ9oa5BRVTc609qe+TikepgCO8xLrAEmxIuu0/fBRorF4x2K6KDFCPvvptr65eFZae9DHoRPbfL9W25YYFTIvXu9RrePwpNkYYMrbtYLh5Qc1dV+ZhsIz1ghfFjwQ2bL8E1YTo8a7pdYPp3NcXC4pQ5ePgXaj3KhsE24Ha/8hCdk4kdkyQISRh9R1AbXGkg+S7AvAZRLwaXEse/oqrlTa6NIhj1uEivfVEv0dI+p3g3IrKcYwpJ0VeLNfwhz7OShF2IuBf3y+pWB+LvlcB7u1FEqTgfdyEBe1OAcuzVe3i6RzkqOurYnelVmwHHO42E2nv3lrG//38q4ZGElJkZjCGcnPUYg2QxQl3DzUZuUynUSHf1S332HXRus79rNM+VBWP20QksU4vUTe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 02:00:27.2974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de67f9f7-4836-4241-f7d2-08df1d044458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The IGT amd_dispatch test exposed a NULL pointer dereference in the
AMDGPU CS submission path when the GPU schedulers were not ready.

drm_sched_pick_best() returns NULL when every scheduler in an entity's
list is marked not ready. drm_sched_entity_select_rq() then replaces
the entity's existing runqueue with NULL.

A subsequent drm_sched_job_arm() retains that invalid runqueue.
When AMDGPU CS submission calls drm_sched_entity_push_job(), the
scheduler pointer derived from entity->rq is invalid and the access
to sched->score faults. The reported oops shows the sequence:

    [drm] scheduler comp_1.1.0 is not ready, skipping
    [drm] scheduler comp_1.2.0 is not ready, skipping
    BUG: kernel NULL pointer dereference, address: 0000000000000268
    RIP: drm_sched_entity_push_job+0x4f/0x2b0 [gpu_sched]
    Call Trace:
      amdgpu_cs_ioctl+0x1e9e/0x2530 [amdgpu]

Keep the previously selected runqueue when no ready replacement is
found. This prevents scheduler selection from turning a valid entity
runqueue into NULL; it does not make a stopped scheduler ready or
guarantee that the submitted job will execute.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4ebb513255ed..b11e1dddabd0 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -584,8 +584,8 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 
 	spin_lock(&entity->lock);
 	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
-	rq = sched ? &sched->rq : NULL;
-	if (rq != entity->rq) {
+	if (sched && &sched->rq != entity->rq) {
+		rq = &sched->rq;
 		drm_sched_rq_remove_entity(entity->rq, entity);
 		entity->rq = rq;
 	}
-- 
2.43.0

