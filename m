Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDECA60A2603
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z64a2Km3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D8011222D;
	Thu, 19 Nov 2026 23:28:01 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E0310E094;
 Thu, 19 Nov 2026 23:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVmTj3JtvOFHxK6+nfpe3Wk4U/3P743l1hz44Huj5EiGXFa3NWwlzkStYaQUFS9gc9QDGeWiryqdxSQ017DHx9o0rnoJXpWuPNaBAQsmby6cSDnfiByWZyvdDe5O9QnEdpPIZM1rVpBPzB0B7FbxQbFfvcKjKOCCsI7aYnbrm1wSEweq3apQw/iSRHbREYT/fHc5xsNfIRUXGhFXc3f9Pp5CZzPW/81D2VcAIqUBfGXnZdnx2/NZcYoIbmfR2yDbMqyoXgq56G/2qXP9tdBrTmL3CFFsmT4J7eJYPrxuUPbCmEKUjG/6lMLoN53W/0CCoAXnV2R2dJPZBVW09aIFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBCW+JmkcWqj0kKUQJbD/e1wAQkuFZ919I0bJV+g5YI=;
 b=Y67OOH9uqtJ/dlJiEEAWV1t97lV9pCR1rYrCJHwRp0P66qLXyy1azIomH62cYDt7+0+Q29JZy+9viA0Ysm0wbxsfsnTare29uRfzNFFP1TrOVBn7tbv9hJzeNvlZkTH6H7bz/rluqDw0ZWl1yJZ3Plx+/FiO77hrAwfcc0nGXGWK9eDyQENUm/iX7HmF0aKSV9fWwp/2xK99Hq2e5NDo3neMtFUBLIWBBNs7GxJIr6uhCxNsFF6J9hCtXkAMctmi9938wDJU3oqpEoOITu0h4CR4ssftxXGcH4dO1EHR0WYf6sYS9pQ0kyRBueD8QmujDlw4/SopPtrPIKLKNkkwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBCW+JmkcWqj0kKUQJbD/e1wAQkuFZ919I0bJV+g5YI=;
 b=Z64a2Km3Pps6UF9L2Q2upCDMWQQc9nlxUHPOKAZrvR6z11nu7qDKrfVpvSm4h8Z/KbVTaDqiSzYgNB4XSQinfRW/mC3gGarC55j2XdeW52mm85IxmpuRDL+Do7HZ/N/uD45RfmwTvLGCBjaQF5dYIWbIjgSqEUvK5JI0+7AtFj8=
Received: from PH8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:510:2cf::25)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 23:27:46 +0000
Received: from PH7PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::56) by PH8PR07CA0027.outlook.office365.com
 (2603:10b6:510:2cf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 23:27:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000A.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:30 -0600
Subject: [PATCH v12 03/12] drm/amdgpu: Check bios_scratch_reg_offset in
 backlight level helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-3-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
In-Reply-To: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
To: Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>
CC: Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000A:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f9951b-fa44-48e0-d3f4-08df4694b7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|18002099003|22082099003|261009223027099003|921020|11063799006|261102123227099003|56012099006|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: dUi2pFAqjz0lwcVcG0IvMLnYegQhVvuOtT4BkJd5Ks6yURJCkF+VooNe/Mapb7fCRXkCzxGD01jxOlqlwCNuW1xVfLcl7UPqdUk9x92eBlU0e/m2rRaJmckjJXDo4mbvGs99m4iv1EscV1vOAz+56GTrrhF42+Dm4jX5UilVu1T6bWtp+HpuqJ5b5k7QS330BenzkxfQ/vS5L5MbqtsvfghQWX8g7jjwkivXGFtLugbBB6tMwN/e9iyfyDeVTCmOYVXXSZah2Bz8IZDa6oQdPll2lwxS/I7ksH6o9A1tBDbU/E+2HNB36TIqHIJAylKvaqJClW9E+yepSwmanJpvTyn7t3AueyMHs74B49RRd/VqzYLfwIn6NQLtLihFwGn1MzT+pd9WkPqlvEgrdm32Z6lbZ4H8nueinY19ED2/olGwnYmu3kWdmtIvU+1D1SgZWl1f8ef9CpSKieon5wsCinKnC7gqSOnvBIeD0XlKaZJRBHzkkcte+cufmFYNHs0EFHthb/eZ1H+PmEQydYhbdmhxKzGsnslUylY5WSndfZ65sti1hqwoFpoD3XFvW4zJUpMDoSQnOnoZwp768uiKPZi5YjhqE3eo6Yck+DrmTrrGthHKOWxUWmPfW+FADOlKcp3KYrCzcEJqUirZQ0aqmAfEeJDjPjpvVYfHro95xZkJtQ3zlkdiNE4siIwH1DNsQN4eHhQSljzebmrzlj1eOj5MapV3y0sXH0DxrpCCAWJhpw5b2hbV63ZYzobTZkwp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y9Vi2bvRj+GXzJHcqBDlOmeXfqEIgYaYDGa+TCqMRvtGftDwkSoz6gkRlQc25wuDyIOGJEQcmrvsHBXoYblzC6UZ4u1R0S0DLkLAR+EPJPfC7ov+e5PlN7oMrHgVndNS7xDny6nubSqdzQZ1kTVAqyBYLQDPwhp71aSoj0N3dGcTO7JHRlPDpfD3kimDwwwCd1YpQN4u218hCc3WTtLvwvrJW9VMbfdYO7kMVl8UYfNBzh56nYREr31t91EAqHo3nJTVbWCiyU0MvUr3b3n2MCaKr2cM7LruY4JlmUSAhZlzWw+1vX8hge/1ArhdqwiHq8n/ktbdGF+nPLGZ9p5kDjZfiJWiLb4ee2jgnTgD8h+0fmQxR8hc8ZfH8J0VDz2xzZY/1Zds3L+Fltm/ZLyV3IkQlP1f/c3helxAEYrOKSXxkp5GZrIuECX1KxnuBajc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:46.4810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f9951b-fa44-48e0-d3f4-08df4694b7ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

Ensure adev->bios_scratch_reg_offset is non-zero before accessing
scratch registers in amdgpu_atombios_scratch_regs_set_backlight_level(),
so they are not accessed when they were never set up, such as in KUnit
tests.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v11:
 * Clarify the commit message
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 27c0dc8f6137a..2d8c2ba04e670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1622,7 +1622,12 @@ void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
 void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
 						      u32 backlight_level)
 {
-	u32 tmp = RREG32(adev->bios_scratch_reg_offset + 2);
+	u32 tmp;
+
+	if (!adev->bios_scratch_reg_offset)
+		return;
+
+	tmp = RREG32(adev->bios_scratch_reg_offset + 2);
 
 	tmp &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
 	tmp |= (backlight_level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT) &

-- 
2.43.0

