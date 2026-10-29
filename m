Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EA606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YtwdMDPi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB131123AC;
	Thu, 29 Oct 2026 15:21:29 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3DF1123AC;
 Thu, 29 Oct 2026 15:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4YP4/lwePS1rEYyE3liD4arJj2hXsuBw/zBkT8yUYeZzSrWsn/a1yKHAP/05W/NZI842PK7GmJLHRR0U45vZU+/35KvB6+1C1xO4MZD5kIiffxHSdwbzgNJWzLNCGTssPTXSCw1UYiqL9sr9bDdz28lpCNrvCWp67s2c1Wsf7l6arWRHqjXeGUuKO0MQ/zznUcZG1q4VCkZBWyu1AAswqhGty4i69GfK3vFAoNtol41VxeFJP3eW+XLtWw0z/30Pzo0U8bNCSG4RMNJRrudMm211WhRTovAM+ul8ZBSTsDCKa4mczbPR9zUz09GxPqIz/9aLuGotSbyNMQXmHCEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or9sGx34sYEbQVoqZBdzu8Fruwqd0WZOcGf5k4z815A=;
 b=vsrg/V/DppB95muiRIu7Ow6bE9A8AXQTQOoEOBUSeVzJ6zikrRqZf8+K5VrZaI0J3U1f4Kq8KmhiMYl5OPeq4CWaCkyDYOZznN1qqJ2DgPb7YFfrL7psZ6BaM3D7j1NI2dWYToCjxP4AYTiI7sH0y1QKX+ZTEIDVV8uRrK2xCvX+Xh8ExhOWWdQgidH3wnGgNXr6w5rIjXNOz8YRDoG2bvDE2emRgyjgYaHk+nVw3s0jFXeQ+5ayBib+dDce3S98MFZlXrV85rxRzA5exZGWhLnF1j1yAqwf4aA5dS2g8cmvd4jQpZx2ph4DA8LpoWPFQlbHQAsMGmufaU3pxhhcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or9sGx34sYEbQVoqZBdzu8Fruwqd0WZOcGf5k4z815A=;
 b=YtwdMDPiUL1QCFeqzwyPtSlIU9LxIQRbwXlETlNzJXt2j2AxMeVUU9fViWCeVSikYyT//C7mnHiTK1eLZ1Geuu7eO2wFir0bEH3J9PadWQ38mNDA1sr2tlXu3SuxYjp1ad3N/Mkg2yDKNdXxXAb3+VIX6uqv+JofAW6qE+0NZOI=
Received: from CH0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:610:e7::31)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 29 Oct
 2026 15:21:16 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::35) by CH0PR03CA0236.outlook.office365.com
 (2603:10b6:610:e7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 15:21:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 15:21:15 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 10:21:13 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] drm/amdgpu: honor gpu_recovery_enabled in
 amdgpu_job_timedout
Date: Thu, 29 Oct 2026 16:19:50 +0100
Message-ID: <20261029152000.22001-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6ca2a1-20de-422a-9065-08df35d04621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261026121527099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: a2fRw+rk1BKERzu84FCyER/atqtgMysk826ptUwuKU522EaMGf2w3f/AnvCvV1EACev0NW3Kf1JbMeCp1WOpOTG1QX6VkNvw9+SkVgo6r16dL7oHyIJPbNeWDYEEJlbaMRTRieRm246CVkhYtidh3bzXLsMgu25jo8/Lf6am8uVyabkF3IewyZcNCsVYHqLqU9kjtP11/gBHqdht7WZzzgm27daq5L0vuomdhfayFF5Sf9kQ/wD2S3VlTvMAn9Zi7mW1MDI1/BrIQRwwgtt+D4o7qzPmIE9b4yKgKcTbZdqLGLj3na/i9NlB+t30H1kN/kMzItYfzB+bJtmEWMrs/2zSOff7NVw10LmfcBQI5Vwn7BYEzsj3NHaCfJNfVv2un5MVXtEKplKSa0Fck5KQz2G2uI1bhXJOlgh2M1fY7dKH3twUN3FgbFdjboQOIDxdeGN5tZsn3gm3aiYFJQfJqu5dyeDWXJW7/NZBwexNX51B+GJG3RMfAlOnvD+f6tmvwc4eve12+O0qn0Ocdo7O4532zpgBF64q4zK4ex3TgQHpCPY90vritqCBZd8vOzkPK9OWVsbn0YJUHaFjyY0a2SUvmTPOic9ByBtJvMbS8obihJixllZcKhuB37v9U+lxT3/mZhlkmaXDnoKhbIrdK/QQJ8f7UZ2M6WT9amFBrSjZe+9zcszIpgONYkFhip3fSSKP2R1/NO/aVK49r5vyzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BZrJZnf6bhevxS18eMor+qg9FLywdfpAo7FOXdG0F8x7LwHBY0wXYv5buvwBTPpv1xIm0AEGJlU2BmL43aUktHQ5gWLkerkVRa0wS1jOtlOiHfcNHZowr775hNEK5LoT3QiYW3WRv9IBunrHQSc2tp2FijrMf6PBGj6O/o3kDT3SrlvTQ+NuawVZEHf1kQwOqnytQCEuGTTgNj2/J7egEGb9TeYN9XpLDcn5DWaCDxr51OGbLm7Xotah7HtMVg/FukxurlssPwHBFqxLrnJ/97OqB83o4zbwTssTJOqvNc3pbZUwWRAg+W+ddJe4JBYmEmRgra1PK9fOtzJWhPxWB975dnfvGhqZkM70z0Ga+5BzDcBp+thxnJtmcEYHcabgL1ltEVKzOdO0MJY0iPtXdUMHITucHRILPqbH5VNJiSZfdacaAigb2CcQOvxGEU7I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:21:15.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6ca2a1-20de-422a-9065-08df35d04621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The soft-recovery, per-ring-reset and IP-block-reset attempts in
amdgpu_job_timedout() were only gated on the global amdgpu_gpu_recovery
module parameter. Introduce a single can_reset variable that also
takes the per-device adev->gpu_recovery_enabled flag into account, and
use it for all three attempts instead of reading amdgpu_gpu_recovery
directly.

Assisted-by: LLM
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4d363bcfb6a5..0b8d0a79dd45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -92,6 +92,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct drm_wedge_task_info *info = NULL;
 	struct amdgpu_task_info *ti = NULL;
 	struct amdgpu_device *adev = ring->adev;
+	bool can_reset = amdgpu_gpu_recovery && adev->gpu_recovery_enabled;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -111,7 +112,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	if (!amdgpu_sriov_vf(adev))
 		amdgpu_job_core_dump(adev, job);
 
-	if (amdgpu_gpu_recovery &&
+	if (can_reset &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RECOVERY) &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
 		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
@@ -130,7 +131,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* attempt a per ring reset */
-	if (amdgpu_gpu_recovery &&
+	if (can_reset &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
@@ -152,7 +153,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	/* Attempt an IP block soft reset, if supported. */
-	if (amdgpu_gpu_recovery &&
+	if (can_reset &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
 		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
 		if (!r) {
-- 
2.43.0

