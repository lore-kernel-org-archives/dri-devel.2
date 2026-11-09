Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80F606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ONf41gei
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134F410F467;
	Mon,  9 Nov 2026 17:15:09 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC87610F466;
 Mon,  9 Nov 2026 17:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS6z9Hobr3Hi0rQHKAfhixPSGeeH36GMyx68uSMLIeICNxSTy/blLq6pmWp8gQydPT6hOYHuaUHRUwmXnmmSvrBH4pecdYjxiRVsDNpzw8VyprCGRqX9tA7NhlekWCbVDio4vPj9jiOhOxv5y9lTzabEqsA0V5CxfRHF9ahnniE1AzvPcuoY29l75cSq61xWjjgBPmVPcZ3gSUzJo53Y2yL82Iafa4+T1VNtjUfWaFFfcdG6bLmGPYCBd8IgkD55eDxJeVmYyeNYU15cgcKEo3M3GrpdkHBQQcBhzxj+YorrLd7qIazmlm8EwvaEdcN+5hWqeeH1hnjNt00t2D6BOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY11V7UU59+wbRaaKpKNijTmmQZSAFZQP8DNLr64Z1A=;
 b=a5XW+t7VO0OtV1VLC4H68dzonqlyiyEUsoe9d/mJLA3e8wYJHITnBQ0o7vhsHJRASmR0A6Hu1Bn+EqETqmHOLmc/Y7pL9cgw+shsjOXDn2JTcr+yveWIeNMvS6LGEvaFEWQ23/vtrJH21HCO/19daZyZCdfCPdKVzZykWcmkNyT4WWQNLtnO7MDaFyDjfzx8/kFPd7mCL4EAG2LAgI/wOQVEL39ifIhk0WeXIe34XS5HzU2/BFhqvmgCPqkPgKY1wBiCEEw29WPH27RElKvgixUSG9Prqhl+akGVhWSbo8QggML6EnygFty/3iRaGTnijijBVO1pRN19HFvoiWyNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY11V7UU59+wbRaaKpKNijTmmQZSAFZQP8DNLr64Z1A=;
 b=ONf41gei38ieF41C7+2uP52iFliCsxP0TnpjG1cTbcyyDZIGsNQA/xQ+BuHEbdrV6QOUpmofB9XqTf+XT0E4lBtOmGQck1UqJGkAkdvfEcFbt5ETKUSSzDSvtpuy6h37vXGn3sJ16VFKJGSz0sKr3Q+0qlWGdNt+CpwKdXnJGNw=
Received: from SJ0PR05CA0190.namprd05.prod.outlook.com (2603:10b6:a03:330::15)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:14:34 +0000
Received: from CO1PEPF0001885B.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::99) by SJ0PR05CA0190.outlook.office365.com
 (2603:10b6:a03:330::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.7 via Frontend Transport; Mon, 9
 Nov 2026 17:14:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885B.mail.protection.outlook.com (10.167.249.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 17:14:33 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 11:14:30 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sashiko-bot <sashiko-bot@kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/6] drm/amdgpu: always clear stable_pstate_ctx in
 amdgpu_ctx_fini
Date: Mon, 9 Nov 2026 18:13:22 +0100
Message-ID: <20261109171333.4329-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885B:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d322b1-f46f-4e4b-8ec6-08df3e84ecad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261009223027099003|11063799006|261021123027099003|56012099006|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kcFBB/1XWhIq+uzAB9ReU3NsiOEiwPmzIIDqS2uySwq6Svt66SvvHf3/cB3Aj5v8TyhEVJjl06PlHZQSSIoFmQ3f7DA5al4RlEgMO7UWRGrTmk8ruFm79dK1MAIV1PNK0o82QMqiDaJeaWm81djJyl7Pl3Vxhc/5Pm+INzwXKSlmAJ49X9OGDYS7mdgbXVGJBtaqy/dKn6GDDbRU5koeSC65b7G2MRHcQsmtQ2B1TtXaUbU+WF3klVS9RQJ3AzCODkg7bxlWTzwo1vStdim7lNLjE2vnzTJaWgFzzXoAPWpY/HFnatSwLQKG8Zj4w50ZWrvbH7GLSJdpcsnBNl2t/Vfp6PhZxoC/HpT0BsAyR1VyCz7Y30LUVFFl5IPzRbwZ/qC2f1lJJVm9bcUyYRr6fYA1L5ntqbbV1rl8S/uz57D4ZneiFSxud4kGWzW2e/uDZF8prEIjo2VgSlc36YMZ//zuTO4DlnAxhmdZ7MQTgABiBSwiw5IuUsOiyCnt1qMTeI7mC+SBGQmF0XqHJZjKePSwsoVQj9VT8CEMp4c2UMhxp0SlCXpoKHAzFv/SS6yBRtiaZBHZQGZWcjh76j/l6Kr7QDFpuCF6wdk57RyT20c9AScZlQzCihOHktfk5k49xqvGMAqZ0eZV8/CnCLjutA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261009223027099003)(11063799006)(261021123027099003)(56012099006)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HoPyrTZkb93p5aybzc6D7eIMzp3M50Q4tvzLayCpEH4t632CZjFdR+WyxgZTkavSnt02NkveRNdY9o0ebm2q9TV0tUPoHbzJG3/KiYS4gC4/PwY7iq0Xeh89mOk+S2aWWgZG6vITlgtabVmmpqgdCS3HVoPIQY6PxyPCeqjdCpeOq7yvImmwZFnVtZHVQEsTHAuj4WeGLIG1FGWndNI0AaaoQETAiN116S2iP9C6Q5T/G4JmVTPyydTN7KlqIQzVtLLLN1eVGW9q1ug0yCWEtLuqbA0EHHARx5zvJYSwdQP0OrJfiNi1k3NDX2YGMgRan1CK8KsEQCWBplPL6/Rq8TqeTrT8FHl6GOpany3GGOzW1WwJeUXCYa3X7RkHLIw/DFQZVDDOA33fYxpHItw9C8eCIdTTFnldgib4gP6Oe0y++IdrWI6a0u+aJIvJO5vX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:14:33.5951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d322b1-f46f-4e4b-8ec6-08df3e84ecad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441
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

Even if the hardware is not available we should clear the pointer when
the owning context is destroyed, otherwise nobody will be able to
use this feature again.

Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com?part=5
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 25b1cf7dc988..2b318ccc9aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -426,15 +426,15 @@ void amdgpu_ctx_fini(struct kref *ref)
 		}
 	}
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		mutex_lock(&adev->pm.stable_pstate_ctx_lock);
-		if (adev->pm.stable_pstate_ctx == ctx) {
+	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+	if (adev->pm.stable_pstate_ctx == ctx) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 			__amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
-			adev->pm.stable_pstate_ctx = NULL;
+			drm_dev_exit(idx);
 		}
-		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
-		drm_dev_exit(idx);
+		adev->pm.stable_pstate_ctx = NULL;
 	}
+	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 
 	kfree(ctx);
 }
-- 
2.43.0

