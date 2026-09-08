Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D77C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9846010E9C2;
	Tue,  8 Sep 2026 04:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WuMhBf6V";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAB910E9B7;
 Tue,  8 Sep 2026 04:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdA0KsgJ/W88g8+vAYrfZkx6wpxyF/DmYwvPTyu4BGsKITTALPEfucKKDX3qkEjCWdmN1peQYdQb8TFNtCV21H4hGxwg2tUg251uICtefG3Dchjzq9fs0f2dGg2D4lLxLeaKcfhJM3+n6qnrBMJNOT8xjY3feqSgkvVde2n0H2dJv55qGj6j5L69gXD1mnZD19QvKdK+9NX5JhJjqvuViZ6lI4l5atjUugINLmkNz0c2EL3yjQo8PelOuVRNCVsx8X9tOl4QAW1KOgQZNMz2MujYv8DYjnq5ECBT6D1SPD62PW0/03tuO2uoW1dY5EyLZtvPYJR8HdXD3w45dHi3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vJSDdOePGz0qnN8MM+dRFUMLeXP7UvewTjTzQ04kro=;
 b=CEWzFoXtwJx0DBfAx43N32IIEUH3qBhdSE7iHEq9BIBa1rC3py0yWrcZazqkBw1TpOBmzlVu7Xh34Cg6eHRBz0RfFA4ITWaFydERCNpVbjc7KgDSKrMS8OzRS8Xl5oS3yVEiNBWrKvgT7xyH4YXMjtu9V0Y6FkBpqL1TQBDM6WdjoH90vnwF1ARF4wcUYmaXwZh7NTHS5KJsdiYWb5mOh30l9GkqudgKi2IJeob5ja8qjty3VIMJEX8AXW6In0uQggW1QLfyzGumtyp6VwcuZ6X93Db8X1EY6k8+xWVmLzkXoJmt1M/2xBy67cR1of3yn013xHYvI9GdYjjcq4sR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vJSDdOePGz0qnN8MM+dRFUMLeXP7UvewTjTzQ04kro=;
 b=WuMhBf6VUaBT6/xmm0Tw5FUmH+aHStIhmorMAQDTaDF1mIz0OeioPd5vaWHCVSZRYeeT+0sKvr5j+3loEDtjmQjUBNIOFyh+idtep0AEYG7UsHxgX65zbG4ULR/nrENqcsosTGTwWQF2pdcFfxqK+Vm3UFUcq1Hj/iVqx8Ma6+Y=
Received: from CY5PR15CA0023.namprd15.prod.outlook.com (2603:10b6:930:14::25)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:41:06 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::73) by CY5PR15CA0023.outlook.office365.com
 (2603:10b6:930:14::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:06 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 09/14] drm/amdgpu: Check bios_scratch_reg_offset in
 backlight level helper
Date: Mon, 7 Sep 2026 23:40:30 -0500
Message-ID: <20260908044035.62093-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb351e2-349f-4f15-0cd9-08df0d636562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|82310400026|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: OBNEOx3lNKeZBRr2EdDv0tCeZnG27gP6fSPxO9OpkEWqTGb21yQMnN5mbZ4tVB5XgoRsmIp73KSZpedhS+ZDDYmF2O7pcNNGqbAxlWb5oEeysi+M/vucOcd8+rX/alZc63tGREHkiBUc6RPMo7rUfbpHpHrLDXGGafWrMvqZWnLyEKPtPdzXXgLRoT7/ewMAqpFmi7zyNvYw/CjA6X7Av05Vav1tqfb75eZgCbKIs5Iqqa2yNJC1gAncY0XHDrdmcP0ZTc6LtBZm7HvYfmbjzCjeM3n8oqqZVV1whIq8DqDmRfEn5TzXxUrQL9WysxUIZBMQsCoVbL/UO3Z+vpTbo/3TMtinGcQVIKMgY71wvS7qTGK4CuASosgY1OoQYX+rBp0CUxpW3GAQsgRqvwFAUujCZev66tmLsiHEPPH4BKDFTIH7ZgeQRh0Dye2j+ebLY/zAoOSHul8Rr9nsY7PQZqcinGRI46jv2oz0w2mqPg4FzhIxioVxJkfmpVTOVa3ofbtUwEodGPW9yADQQQskRtTXk0LaNqjs/XMG2jFejF0wM8qEonQqMpgPNIRmcFMHlApqcMyx9Sb7mz0vKy+tXt/halt4+Zrju9YdMdngHqs+fXAJK3sH99m/wjmcgG/ZTymQnIbN4962qEOprNHNKuwuZgz8tVNIEFMnIf3l+gvoOBJ5WbC5zxAW4Iwv8rsFBL0+dpc3FYi2rwTM9BXIbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PGvpbUZMgog0VNWrIOtqKA598iLXAwReSVN9DlGd+MZF3CC6Mhx7HcBbAby1kyPzdL+AocMbzqfC8qk2IjWw5FIkjyjQUvNCtrDld4Y8zfyj136GHxKoob6d3vxzERwGeJUBAPkm8lKoSkdBy/y4Ac2b4Qo2swFpUw9qu5CwCeNiSHMfDkk2KxOk3TlDi9eIofWqZPjU9lt2JYab/utFdVaPENUOvhwy3FDcxTv8bJcYJm8anywvt5RfoopjyOpr6YpAuTqueuCQdZcnmnH1+87GE52iwIlCg3I4A0pNViGcxUSwe6NOfPH4JEn5ysnoVroRuJBhq6bGINAlHEPdW8N7ceWgKl5m9ROl8djSflpmsWnkZzkrOU9ZE5YMyO90UoMlLEKhGpqMIfWtwe+MS1TjmQmjjeiY2xZpzCWhTCcXSzg7m0SewL7nyq9IhzOm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:06.3114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb351e2-349f-4f15-0cd9-08df0d636562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

Ensure adev->bios_scratch_reg_offset is non-zero before accessing
scratch registers in amdgpu_atombios_scratch_regs_set_backlight_level()
to avoid dereferencing unmapped MMIO offsets.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
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

