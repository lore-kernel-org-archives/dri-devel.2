Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743921073C8A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 10:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC00A10E5E0;
	Wed,  8 Apr 2026 10:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="psfcDaqR";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F0A10E5D5;
 Wed,  8 Apr 2026 10:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip703j+/KGwpMdLNFbUnK/KLaebr8K/sI7gEPEQXpLmGdWhbu47/lrTw1p28A8D6zJb3WZwPMxnsJ/Vz1o0GYpKHkgdq39b5Bq+wNZVJ68DCgYcGExfmFoM9lmTP/fBVm23zirhq5ctBLUOfcSgEWDT1onqT5S+dKqIy59+7MkxZ6F0voZgNzZ/S1GGUZm7ovUVypPrR9E0mxpe6fHQqQpS+KRpjE9PH9GyjibU0/YSUv1rf9iU7aZxZ16Ppf8Dcz6qbbgMv9AFJlgAbQLv4tkCh4sWAjUvQU2/bOrSpxMpsOT37Krt8ONgWcB9dpgPNi5qoNtN8rpWqvsKYKaoAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms5Lvp2gbaFLFJoaVe6HcD2iimxVdC0MoDXAMeqxD/w=;
 b=yXIttxBYGdV373R/5jo45csMpvj9oY/GW8li/QC/3+KH50vtPS40ugUGLyOm3rne1QLBB1pwgstE9C7SWGaF9C+NGpjgYLoqRm4I9beqyFtTS7XEYUB78VxjCGJtVoV8t8FZVA6MnfNFo/MBzNQ/p8YfWLyaxqYrEoJ1cFiVhDpdIHWWLkQE385NiTvFKnB/DfntI5XW3GPrqsoOfthA6X9w1t2TKoYFthpRPEQDSImZ3T+DhoHHJGI2qmfeZaDVEiiWktOmoId1Zj/I79SttWsj+HCguSMoBm+N5aGNfR5rRyyvJ69j4zV5ubFw5k9vmF5G0aJHIo8UQlgaRJVVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms5Lvp2gbaFLFJoaVe6HcD2iimxVdC0MoDXAMeqxD/w=;
 b=psfcDaqRJrDG7dAdFaAJT6/44nR7mT8msgJoVgif7JBrNKT5WEd9ONlWUhF2T6eGfjo6CeeLJuYM1IdlpxfIF2QSP6LWHAL4sNnV1mX7GM1jpk3o5ZYmyZumTk2KQfOwrmkZrFsqbbhPp4n3arLdb2DhsJbmS6VuToHql+7ovII=
Received: from CY5PR15CA0190.namprd15.prod.outlook.com (2603:10b6:930:82::8)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 10:07:11 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::c9) by CY5PR15CA0190.outlook.office365.com
 (2603:10b6:930:82::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Wed,
 8 Apr 2026 10:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 10:07:11 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 05:07:09 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/8] drm/amdgpu: give ttm entities access to all the sdma
 scheds
Date: Wed, 8 Apr 2026 12:03:15 +0200
Message-ID: <20260408100327.1372-4-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae7c09a-f3d6-4c97-8483-08de955699ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TwkT1Ynfc0PHIbrnpxCyk0pFFp4yTZd31DJLRf7SNMpQy5UHNMK3ZWUuAft8nCYoI+35fRLhFSHOvsnKDPJWo7lRs6baa2IuPHxxeBwopaNhL4ubydlSfGqb25NKV+FVHMFRLn8RKQfhPCbPk9NdXLFBuUca5kgKu6h1rVuILVVFe1tgDlpCM33sgN7Y0dmHrzTHXdvr1U3WmKcvb64vOnEHWdLG5IHnhMRRvcsu9xK5xsibUEjTFiymNNG7lPM5Q5nPCc9Jk9xaRKMuxps6+qqzpp4tGLBsudK7h5zsUhnWWifhAr2CuwR+0C9kswpO+xYnZBeequpyCXagTzZvhTIdDTxX9UJ4x01kaUa/UKhW7smbUva5LpmMpdQDdHO01sLerOUwdX03iUI09mnbbHHtnUm/VCaEE2P+Ti1Q/QN7md7oyF4IHf6G+jWRN0hs32Gg5zbLQiw2bqvAcROJlrWY1nuURQ8xFLw3equZoTStF2lwx5hekrciW5AK0k8hTuVy6KFX+V20LMDYY20Mp86o+PVl2Dcx2BcpTeqHiub224WFodObEP2bMNdy/sxxyT8psXbi9hcs4QIhcz/99iHsv2roFPWIISY8agDYen2thNehsqWH+P8FPBZHzeZfyND5R0TixNAqxm+aAfYTgBtZLHRePX8nZhcJk84/9BNPa5r3sQyCsjGK1DG8AkBmv0mJ8xjNhfh7CJDYZ+w8WR8edRHynBsmu0dLHOZThk3uOmgdxB2i2FcOT91Gnm91Cvg0cc7peQTJttbIi0si7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kccuKi7A2McG53pKf+Kka7aPc6mDEIDJMe2Mzg3gwLaKsaCxY+gKdxwEcxvG7XG5qGknaffavggx7E9umqmf5hdYNz/AzO2SWuE4a6rhvJbPGgt/PZWkuQAYzaKwOeK5ocHh6LF0ngHB/lu0CAL71s2rgo5kEuy91rECc7F/TOiV7D7DsbUyiHeXN+UTBQNQAGqjxJ+Qgv0kQxCYvEg62S8ZPzax7y4399r/+zEUak0q0L21X7O4SKUXpvFIYXEo1y/7d+hMGrLC1F+ZPA8StQVD9PQ9T1cEYwVOmRY9TxblVvSdrbDj3qmsf1ITpnPU7TouQS7VcqhTBptkQuKXTuBBn4klvYb+CatbRqkJZcrQ+6g3BXyW/im8bbUPjm3RmClWrQfC1ef+A0bC5QFX76gAqKH7mPdyZdDeEnhrkFT5an+jx2rto74UTUXOrisF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 10:07:11.5952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae7c09a-f3d6-4c97-8483-08de955699ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
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

With this change we now have as many clear and move entities as we
have sdma engines (limited to TTM_NUM_MOVE_FENCES).

To enable load-balancing this patch gives access to all sdma
schedulers to all entities, except default_entity which has no
use for multiple schedulers.

---
v6: add comment
---

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5d10c08fd989..7b92f240eea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2349,8 +2349,6 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 		return;
 
 	if (enable) {
-		struct drm_gpu_scheduler *sched;
-
 		if (!adev->mman.num_buffer_funcs_scheds) {
 			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
 			return;
@@ -2358,11 +2356,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 
 		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
 		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
-		sched = adev->mman.buffer_funcs_scheds[0];
+		/* default_entity doesn't need multiple schedulers so pass only 1. */
 		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
 						  &adev->mman.default_entity,
 						  DRM_SCHED_PRIORITY_KERNEL,
-						  &sched, 1, 0);
+						  adev->mman.buffer_funcs_scheds, 1, 0);
 		if (r < 0) {
 			dev_err(adev->dev,
 				"Failed setting up TTM entity (%d)\n", r);
@@ -2380,8 +2378,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 
 		for (i = 0; i < num_clear_entities; i++) {
 			r = amdgpu_ttm_buffer_entity_init(
-				&adev->mman.gtt_mgr, &adev->mman.clear_entities[i],
-				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 1);
+				&adev->mman.gtt_mgr,
+				&adev->mman.clear_entities[i],
+				DRM_SCHED_PRIORITY_NORMAL,
+				adev->mman.buffer_funcs_scheds,
+				adev->mman.num_buffer_funcs_scheds, 1);
 
 			if (r < 0) {
 				for (j = 0; j < i; j++)
@@ -2400,7 +2401,9 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 			r = amdgpu_ttm_buffer_entity_init(
 				&adev->mman.gtt_mgr,
 				&adev->mman.move_entities[i],
-				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 2);
+				DRM_SCHED_PRIORITY_NORMAL,
+				adev->mman.buffer_funcs_scheds,
+				adev->mman.num_buffer_funcs_scheds, 2);
 
 			if (r < 0) {
 				for (j = 0; j < i; j++)
-- 
2.43.0

