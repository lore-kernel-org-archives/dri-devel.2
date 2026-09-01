Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19992C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2486410EC1E;
	Tue,  1 Sep 2026 09:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BTrpID53";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F80010EC19;
 Tue,  1 Sep 2026 09:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jakIO97u5yqFJUPAd3REP9bB3DgFgDoULfbVlDECmaoavdkh54peDqJQAH3DtC3P5YsHzL+TpVcJ1LUsGssnKLkD7FudzdaipDDFcdkQeX4Xuuot2K4bONcmK1bIGUlEor8yN5LDe/aOIkGH8K8SitUvWKQaEb5xpCGqY58bMGK86uao/VFdGHqtsOy+uRQVlnC48nf2JWX4l/evLvGLKcYL7hdXe3Bog1KNlAadjMWaArVlzxaXeKsQz8QFtxt8X7jIJkVeHOFB1wNp7910bz7ManDnQ/Aah3ERxYub9Z10ZxVD5TXrLHVgI9IABB8e01swcJSzb7ewLfLwu/Jdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY0fRSaMkc64CUA9pn7IfQTeGkjFqIsYd5KwNcfItzs=;
 b=CtzzWlQj5yz178H/YExfm3uGEdAC+Ytetfw8kq2b0zd4YfwOjZKPvLginUUD/hI+O0GloqcQUHIJT95vhVyUD+GRwqhLRsfyEVQD/XWnEAFwCThb3Mieb6f0ee/7phbfRbzWsBuOQ4k59zPpaeeRV7EZnKseagvh9rUIjVXjUTPiUs9PWGYZIHsRm4ZL0R1u20sVF+2VRCVG7dHM6hH9EsbXb7MJi1jjVpFmdiIyl1kGi2bH5NT6AVJ9O1xmfMJv+HSgfS3PFHfWY67nnL0nvRb6Mq7iP4CMpeQV1HdgRN7zk/RYEG/C8LT41UgTyQuo+1s+vPHxAN2ChqgL5gfvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY0fRSaMkc64CUA9pn7IfQTeGkjFqIsYd5KwNcfItzs=;
 b=BTrpID53OVBjXD/4PGHJ9y+K4uxsAhr1tqNmvcAPFWftIm86oOUqSAwZM6vGeouVpdVhl6aehDsqAD0/bkgxNqicyXHbjy6+4KiNegum7W4s7QIpSeT8NDbYRFMKmq6KYBzOjJXzk4zzJsjiEikXtpzOqFVpsYC1ZFEGr2bEAGI=
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:01:22 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::27) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:01:21 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 04:01:15 -0500
From: Honglei Huang <honghuan@amd.com>
To: <matthew.brost@intel.com>, <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>
CC: <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: [PATCH v2 1/4] drm/gpusvm: move dma_addr allocation before the
 notifier lock
Date: Tue, 1 Sep 2026 17:00:57 +0800
Message-ID: <20260901090100.2024933-2-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901090100.2024933-1-honghuan@amd.com>
References: <20260901090100.2024933-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 52811103-ae36-4ee5-27df-08df0807980a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PNpE9JdMotpCpXt1ypErr4HhMPCmaUBxSQ+D/CSSBokre2wSKjbV6BOtMcPohZtX2qc2j1+Y7xbcPXJ2pL1e5wLSBgXWIi7i8r6WUrwOyfltVDOtQR1EiKaiECzX/XfUkQ/dKiYmbiUVASX+zm70ors5RdaLSfU84yX5AdI9fEbDdR6UE2PFwvrPyunOLPSnCFkFa4Frj9AkPBH9eO7qeHDBsHnb7BY42aGj8z1kssENtcKBAehCbgXJeEHIVZZegS6yXi/AGAMTTCJbKWh4OzjeqAMVrajxg3gcsy5hUvxko8h9Pbqtv9I5kod3rld8EKkPQKLTJjn7OCU6ZWphqNEffcDLIUJ3KtMFMEWWZpPuGGPAEUBPtTL/gAhF3GVAkBYQqT30A2S4JgAh+9HtvKQko3NyvqYPqywfrKyBzMy9AlddOdces+6fwr2bU4BwA4IfGBUb+X21UDvFt4Feu0LrZoMBR7gH0bidKO4WE6GyA9CriAruunZMRkaMelsaDevnkto3ukjlL+DQcZRW6br0xi+mY1nq5bXB0Af1CDz39mWlRrpafWAoNKPYkjm9V/lfVoloedwCPW3HOOug8+5wQq2Eh1Zu9m8gcX2ZTHRDsl4wBBLlAgv2IVFfmklxK6b/Qa+l1dv8kadZgurB8EUv3fHIrU4O/jdxmJQDy7TM+NQhKIocllx9tkO7vRpOEAm3b9NjT2CJUrAsZmSOzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: itW+keLq9z2ufafwAkaaWmKczdVRkIEpd7BuOiFi3LIO9w3hwZvirQwM/Y7khFiQpPuHTW9DCtl8B+d3LBQY9r3lh4ilGAOOTv6wLxyw4VmJVkc+jlxQlJ9R66Nfx2pCrmm1CdRROjdlvgFra2/cB+IPXrueZlSSHVZBxaEMes5m5IdACE1ngNv3euaSfaXujueYXIFI2ROt0+308SbEgpHNWJH8zhcj4F8jEs4YGKcZHUYa/SdyDHWHCFYAIKRJUBed4e7qXmaz8JOYt+lIgJWTgwB6NAlV0OjhqfFh+GHBiLDSzAFmAOw3kLi9UX2JyXzi7qzPD96SoljwMqIfT0uhAYDxboGrzlCJ0N9FQW/gtXUIWkJsuqIfcqowNhHNBKYN2Q/IR2uhpptD8j1sui3Buu4isGBrTEaTPEyRgXJwAO7gqGr5lnnW7y0EC+of
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:01:21.7796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52811103-ae36-4ee5-27df-08df0807980a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
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

The dma_addr allocation was in a lazy allocation flow, it needs unlock
and goto map_pages. The allocation only needs npages, so just do it
before taking the lock. Drop the map_pages label and the relock flow, so
the sequence becomes fault, allocate, then lock, validate, map and
unlock. No functional change intended.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index a93eee7ddb9..b507de539e6 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1516,10 +1516,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	if (err)
 		goto err_free;
 
+	if (!svm_pages->dma_addr) {
+		svm_pages->dma_addr =
+			kvzalloc_objs(*svm_pages->dma_addr, npages);
+		if (!svm_pages->dma_addr) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+	}
+
 	*state = (struct dma_iova_state){};
 	svm_pages->state_offset = 0;
 
-map_pages:
 	/*
 	 * Perform all dma mappings under the notifier lock to not
 	 * access freed pages. A notifier will either block on
@@ -1540,18 +1548,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		goto retry;
 	}
 
-	if (!svm_pages->dma_addr) {
-		/* Unlock and restart mapping to allocate memory. */
-		drm_gpusvm_notifier_unlock(gpusvm);
-		svm_pages->dma_addr =
-			kvzalloc_objs(*svm_pages->dma_addr, npages);
-		if (!svm_pages->dma_addr) {
-			err = -ENOMEM;
-			goto err_free;
-		}
-		goto map_pages;
-	}
-
 	zdd = NULL;
 	pagemap = NULL;
 	num_dma_mapped = 0;
-- 
2.34.1

