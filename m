Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2BEC5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B0410E948;
	Mon, 10 Aug 2026 16:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kmBTHA04";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4DC10E945;
 Mon, 10 Aug 2026 16:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyUrLhydqKjc7RZfc07TMzUg1ijqY/G0bALGifTbCjLfXnuMoA7bgwM3+88uzLSk4YhhzfyGucg7h8/qcVVH21CAIwenfw+57W0TKUag7D1+cK/s7HJnhi1EI9PfAerLpkGB4S5MnZbThsyY+6DuF7vzeTnVM5d4Z+uiyEWhXqp0VPHRyoas1oz3i71Mtuoa/H4I7tv4q1sZG/ctjWzoPOnDhiIQyt2SawXBt3+OsTsioQMgVNP0tUgjabsf7CXGAPC+uufH3fgWwe+3WU6cKSZt7uuy4WRtTuDs4yxWECcr9JCc/bPnnFXdC94qQTgd9xDsMp6pOO1rwmmG3GyfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7BwgFymEHSkoa/Fq+macxA65v88Nxc4I5taXdFnc1c=;
 b=Ljs7ilRRkUXtd0hwGSxBNljpHcYWnPNQMF0mHpzgD761cqPPKM/gNR0eLseEAFBfaJanQOpXLs8ilNjiiOjHhjXWgLiC2mAcwTfCrk8ipL4h0MDaPN4fk/VtH5xis0JAZEWCCXpoXFECOK08JSlA5fThP2pRqqDnyMkxrkyjEtAY/1Kaz+N3qOfGYbsH6JYMm+4Swn+Ls4QQYliI/CpWg2MvVjaZcJqfDY6766cr98CpxtmVjOPlMlEHh60wiTwa5GtiTzJFVc1hblyIJxhB0GGGQfJxJq7hVL300j8xcU0gHVf0XnKE9iGI3eQd9vSqr1yJItfpdNSLiQkI0nQgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7BwgFymEHSkoa/Fq+macxA65v88Nxc4I5taXdFnc1c=;
 b=kmBTHA040IfPCXbSFy7IXUCZXuiwTHR5DyzptV32I7Jl1JACo0SFwEDWYYV2cOHk0bSAGK/y2QsSkKYG8JyqyuYIv0ve3AufKlkAxlZfyKN49OyYFS+P/Z6d4prWe5gKvJRuo6VqE8xLhldbYLg/Lna1e66csvOH5ncuv8TTImw=
Received: from PH8P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::15)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:54:40 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:345:cafe::66) by PH8P220CA0009.outlook.office365.com
 (2603:10b6:510:345::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 16:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 16:54:40 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 11:54:37 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] drm/amdgpu: skip amdgpu_gart_unbind if the device is
 wedged
Date: Mon, 10 Aug 2026 18:53:19 +0200
Message-ID: <20260810165322.24682-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 11887bc3-5edf-436c-21e6-08def70011b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S3ddrpl2WNqS8ILpFnNa4VA1f4r+7Bv8rb0+FfOFnWoCkFUKbjKJizYY/5Bz8ZepKbFHl43al7xNypFR9afW/pRQym/m8RNgS8zkQVVfs8zxBCIV8Rp+ZNtJpSP3IL2K68z5xr7nbrlrpXR4gIIrtErr7vn5xl6OgnWOYHUT0TtdkzKeIiUYKfuoON54D9APaSFCXoI0h2sVDGR21+7UyZJm4OpusiJjBa0aGXIU/ii6gzLl7++aBUuUTc4nxdr1DSfFCeajQSguQBJ278RsabhNr8x+poigLTKNexlJTffqhCoC+MKkjuPwUraz22Tvfoz1KHqI3cFcChn3wS9dVkpzT/stBh4Xe2e2WJubDFuMxc2ClmnZmld34khkbwgpiC0QvCwGHMFRTJ/Txo+AfxWVYT7hnTdSOMe+2YhOB2jUsHl+n5zbCGNRh2m4RDwFe3GUwn3op0jHhQ9JxjJemsHzEedO/NFE0A7WMex+qBAaTY7e2e2XkKpw18IqY0dpvsNCA48eG703ib8nS3TivYx4QTxDO3Gp8BUklb9gh5rqxokKMN4aSTZLAyrhlVHwb0vLRvBVu9yjAvQ25zZkhOoostUc9DHS6TrGwMAnKXzlWGoIUDYvh0Qdp0rPpC2t6aqj7wMjLWosVIlrp8XxscMytmZgBHufTeXL4KvYZpkxWOc3EWMCfa5olwFpVYfHF4HXIQjvK6jtV7aW/aF7vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6gsmDM+Igvaz431xNJo/d52KHrzXKEuvreg0mTZKfDo59ucpR/Xu6Vbfd2A/5ePu/YH4sW6Ox0lb+Rxd25wxkadonWwbjLHCnlrm73ibiOFsvNeO1cAO4CfTArVV8W0oHs0lRXyevt319F9v0vS8rZY6jFaIWYGHQ7DRklxrm0rfIGxEj/dzo2D+q+xaiJ31YMty3kXCZm4hM91XDTJ9VHWULV38crX5K/5bhQiOtFmSNC/sPBnj2/R/4+dO0Qv+IJptllJdN6UPMWctB8e30awWAl9h1BjoeMV3OjhJWI6DkC26IB9n+s3OKYyQtZ8CIXrEXiGdTAovLKyRMNBca/5Wuug7R7XscJV7OQMLBXjWff07UaOLWQdUCK5j/0i9T7IbzvjcgEFX9GVQlyDZPAih8qIVz08ZR888NrKM5EQHWtQxRKL0wq0w8LXgTNFq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:54:40.1118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11887bc3-5edf-436c-21e6-08def70011b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf..09ddfccb8174 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -315,7 +315,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	uint64_t flags = 0;
 	int idx;
 
-	if (!adev->gart.ptr)
+	if (!adev->gart.ptr || amdgpu_device_is_wedged(adev))
 		return;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
-- 
2.43.0

