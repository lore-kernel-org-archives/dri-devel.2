Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B33C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FED10E9AC;
	Tue,  8 Sep 2026 04:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IkCakQCO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5369D10E9A7;
 Tue,  8 Sep 2026 04:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q70rxk1CNO/2TYcMsMSIGAer4h5hG+HV4Cy8ZKtBvmZ5DoBSbaDNBGi1p0WCS6y5DED49q5E5XgtUkQm5Fmka8zQWK4OBlCoU0l8Do04gBgYSJeXZYC9/PS+Y8sWDVDdiljQ0w07u/Jusr7ZrqbzKCezQSOfBKMoQYW+6lc8eszit67IUT6bRHo7b4IJOQ+xEFsRi4KY9Das2voX298mUmqrcPwbXC5BL2A/c6rMQ9jQjB+Ck+q9xli9UCtCwxAidLTpiYKMeY1AARs4DRNSxoCon+PIz2LhwcikbF/vCEEVKwTkQL22feCJ/CBQPLZ5pPGzN++6/W1IZDvV0Tfr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPY9JUjqg8N6RqN67C96w/MuqWqqIUQboaiUiQeRuDg=;
 b=OtpO3j7UiJYpCCIGxHNY4UT8PeC3BbY1NsZXEAkIFlO9T51XrAWHqpOvEbsm0t58MicH5tbvpNn7OUKRTWZCgeFP+MKUvuhC/opSy2A2HMTs8b37FgVJ9g/++7JRqXaGGq+Ea6DNrIoZ25Osgwwd007RRdHAmTuRtoq+9n5RzZnXo08C0WK5V62ugnbQiQDV26t8jIk1tZzXq+FNC+Np7GHdVDqeszRplu+0MWaOkq1trMFpYq7evEYmDKjnS3MgoT8E/zSOoGAzK4p09KSPj99R3yA8hYFDBwlpdgth3lWofubmItJQkrtCxMltEHdzGupndJnp9HrM93oqm7ii6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPY9JUjqg8N6RqN67C96w/MuqWqqIUQboaiUiQeRuDg=;
 b=IkCakQCO+V4qMxiNpupV66UWzpcNUnMMMzbX84+nwgA0tqC8Gr+TfH/9h+n+NcA/BC19NfBe7jyf2cVNpY+bstbE8uK1BibmBFyfgOZzHQu02bmAInyx99FUel5m/rBcedSonWfXUso+AnETB6UCaw1PAcwKzT3bWw7y+UVFMD8=
Received: from CY5PR15CA0024.namprd15.prod.outlook.com (2603:10b6:930:14::16)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:41:04 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::44) by CY5PR15CA0024.outlook.office365.com
 (2603:10b6:930:14::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:03 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:01 -0500
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
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v8 07/14] drm/amd: Indicate driver supports luminance
Date: Mon, 7 Sep 2026 23:40:28 -0500
Message-ID: <20260908044035.62093-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d97a0d8-4ebd-4d4c-ba3f-08df0d6363d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|7416014|36860700016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Zucu0o7WLwVo91FJPYMGEWL33cbd5IfQSoFT40p+jRyXKLfEOA36K4EsUkR0YZFh/kG3CjIF0fpFPinE4dwnoH0ci4dJLT0LKX1G5iP26Zuu9Jvz66cR/NfowqtdMwgL7mJvgSvT8L1snzXae1v5t80PrpduE3nx/3lg2/No6TS+oSHutd+37QNU59aTcyB0cDoWJX92FaWIMDnc5fp6LGQK/2GKGrRdmpyNtEuV1jhnoLgrFhfsWalE/Qk2tvSZlmQYVCeGEvPCj2DOu2eiG0/nYG+kB2d+Cq7vWbBxOdIv+xg9e14s8jOLsdKQSmNwi6jHTPjLfidfZ4IX2zJExvzfZBIKdREyubzoHGKrKMi3GUr4e1rROq7DYO3TW8uXOSY7NXZgEsdKb/GsMqfs3m0jgTmvfbsqHKf/pHqDLu3phe+S/C4BBZPoVEkTOGgzy4ES9PF03Ce0Ei5/jenV6aZX+U0VaTc+GS0vFBgluWqdqvV6vaJuKQZpBeAknsas9hr0QjFIfK1odqRDyI4OWmwZkiZPM7XpnK0Wa6gimRqpGUkY53A3ZgOlmwE3TtFBkXMAqaWQXSrsntaddS+iANF4FoY/w//FoXz+0LtXbTHdHeimwpuHZMHUYdm0zagkYeulEWFNfyLpK/Uf/Kbi/9uHwtrLYoDVFwZLxgKbtK02sdBJnvcXQIM4Ars2DtgjLMkDXlJMpaSlIITbjjp+8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0BrYTAnb50H/jpGgbLeLoNovHPMkLXLhdKOT+q3D1/WGAHtUMui7FTCqwsJoC++EdbLnoqvA+6cGJKv7Npv7uHXJK82CeRtxnMmWeKycLMT6TM0zoPkpSbprpL+zfLFCTf8CJ/KYRbYakufJQxnYq00lnXsM/Hpvk3a3qZXavYJPzBkC5av50uIlBxG35RAPaKq6dE3ZcK1Bw31JPtiFW7Fla+EaXKdQFFf4xnFh6OB7Ss0Mx5ldft7Pp5ngXWIuD9mfHUl7LBE4VZJZJ3mzzoUoC3ql+Ceuf4Ffb5L+GnczmXktZbyLai0zQu3hqIooodv94Yb9pWRdTeNTeE1Ejql/pBuYrGhODHhCuFrBVt4d6hqAe7/S/i5t3mvzziJ5fogpYqb+kRn6abek/mUba5XuY816M2Tk7bifKEa1Y+xzKk5gGWvaIf/Bk1BQF+QK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:03.7070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d97a0d8-4ebd-4d4c-ba3f-08df0d6363d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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

This will allow the connector to show luminance information for
eDP panels.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3ca98091ce487..7b54ca8beeb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3124,6 +3124,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	    DRIVER_ATOMIC |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ |
+	    DRIVER_CONNECTOR_LUMINANCE |
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.open = amdgpu_driver_open_kms,
 	.postclose = amdgpu_driver_postclose_kms,
-- 
2.43.0

