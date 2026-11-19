Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA374606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XXVCFFIm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0934B10F0F1;
	Thu, 19 Nov 2026 19:52:57 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3AF210F0DD;
 Thu, 19 Nov 2026 19:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gR/bMmBOJT0BI2k5IkogLfxkUmeQKcB6msAQZCJAnHQC5qXwWc+x0i3u17GTLIzoRsOK3QHuvaLuEQNNXgYeSeuhXVTCK1T/Zx3IFMgqd9gbYSGlHmTj5v4R3CyC9LWqndrtcLUIP9Msfpfx5cW3B76AyMmFmIO7kOy17/m4WRbPQsUBAkSg8SAi4g1BQD5rHN2gH49lCgG/+LTI1G6ez2QS08ozx2enRH3it4mB2iKhuB36ooFs9IOVmwzH359DvQhYtUDI3/qZmlVKF5CxccPnrye2P8GTN5tsLbd4Q/d+hoFAxfqOzWOKl+6qzdmFjNda641VqtGpsuQAbexrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW4ONGPablWhGsBfeIbdELadQqxmAJVdT8roEI84HHQ=;
 b=qrZLxPCrgYYW0okNUNFZPn9ASchE39iYBfNfnNBSCiwS9iIdj9puUvCtMA9qrEod1zYgDDMC23BepeN18WVMDraw9WUa+S27cusT24ZOOv3KbifIsTWK4lWTuCeiFr/y3YiI4If8CglQ4gXBeGmjEqfrg3DgK/R41/Idu7zmfhZt1uEslnXyugnl7ImtW6Ehw80bO8+ijo7B7ziwIvVCdMm45vjRSTlaLcT6BmBDDEl0uchqRY/W0L8CkoeZ4Po2l2XTc3I91LtQrccTQwmNhvKHNAlp7L7SbukKgUPTBH/dErAv+AB425+AreHwtD72mEx4D6NNHuXv8V6Xi/HYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW4ONGPablWhGsBfeIbdELadQqxmAJVdT8roEI84HHQ=;
 b=XXVCFFIm7sqNQyQd8SlIibxsGiHvLZN9IVQ5e938ikX5qcY8esr3VzBDRYsOZBRdT8uHzR50ZJiVAW9bg1SBtTscKJw+SvcwOd4zDQzeH5D2NEJRTGSbMxnkWqPDJylrZ25d8Vogkvd+C+M1WHGB6NiYDS4ZOaB9uqv5eS7Efog=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 19:52:06 +0000
Received: from CY7PEPF000000F6.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::2a) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:52:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F6.mail.protection.outlook.com (10.167.247.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:52:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:00 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:52:00 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 1/4] drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
Date: Thu, 19 Nov 2026 14:51:55 -0500
Message-ID: <20261119195158.2546927-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119195158.2546927-1-harry.wentland@amd.com>
References: <20261119195158.2546927-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F6:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e91d28-4cb3-4767-4a43-08df467696b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|11063799006|261009221227099003|261009223027099003|261021121427099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: rFz87uwu5VfCuh0mNOP4fqvnTnirp4BK2KB5cSvVFy47DEP18hHCDLGysxfKIZGXe2oZrAF01tm4AkMrqKYg0WkT2ARTuLuhOI4GTwusjDMF3Jvyf0R/Kv462FcwMIcev3rJL5nRRWEaQtGXfKLy+SOVKgeu3VSD6VoRWW62dOK0COxyq/44FX08mxC9OOnjW7GUSOXQMI75P9A713d/pGKV2dNn6vlc4gzM7bmZ5p/+ZIlJzPUkfm/qChwgf0PGMxJYDpg0mp9wsQnTWB5XFF8m2Fr4oIQ4ZTsFSGal2fUI42h9JSt9D1QPv4wjfVXeyXyNWxHKcLj2mtIJdMjVgLijmg4fJWzEGjkk5TXDe9hJoXe6+hUI6dNLaGZVsb0WL7pNl/BCaHljCusbPiO0lgrf2eJHdVQB3t7hnOV+dEXqHKgrNLZCEZFiOhpWeNieEcbLGCha43M8/rH3sZLzqjtFam4JuoGXat6AxX1HHZk26LeGc5IlywET8/hZRskNzP8KMIfqd3OjTVc8u/iCWZfyfbl5Xbtn4aYOJ/Zy7YSSwrMx4m/6TmMCPPhWCYESaZF0KKvaJHBfTd/pqVWu1ijRq48zzNZZhxKkTgNfNvTC5FzLp+JjfyTdN6hDh80ZZfxa6dMkLxwswqmssKbZYFeR/yhRJhNgst48/ij59vN9YqCwahY96INDzpph60p14bNvSX7eMWd+AMO6w2SRLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OgjyEkk/fBCq4w/dkz9ml7exmLW1uVwqTdhAy+v3CedHFBAAcAetoijs1CJf8UiD1+cD12yIKvFl4uBtJVAngSqPrHR9g4nnrhq2Xh8afcPpOFMOfQ2fNbjE/Cs4zNJLRXFIRbq/9tlICMPQpRbXpYHbMsREPRKzYwyHdM79DE3T79DQqehZ2Xl24Mh3goCjCXItd3jnjEIHSebuL0RELcycDuzkJqNCpivIyLJVnhHlI13h/E0tMZYi/ESmDvgx+30mDu5WpdcHb5Gn5ULtgj5ZHyZkMq2kL+d7Mc3q7G5ynm4YkLN02PjlQRUCN7Iz7HnPyEQ3aTNc9Lyw5iHnLRxc7rP1aCiLN8ket6drU2jM8VcW8D0Nhu9JP4ZlL2j81hYnLPUzfZBuvaq+YXJJbgct4Jm+gYXe1FcqAO1/SHrOwoKXNUHjfeLF7q90Xvp1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:52:05.7613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e91d28-4cb3-4767-4a43-08df467696b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add new 1D curve colorop types for the Gamma 2.4 and Gamma 2.6 power
functions and their inverses.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_colorop.c |  4 ++++
 include/drm/drm_colorop.h     | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 682fcc651525..d62153fd9c71 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -79,6 +79,10 @@ static const char * const colorop_curve_1d_type_names[] = {
 	[DRM_COLOROP_1D_CURVE_BT2020_OETF] = "BT.2020 OETF",
 	[DRM_COLOROP_1D_CURVE_GAMMA22] = "Gamma 2.2",
 	[DRM_COLOROP_1D_CURVE_GAMMA22_INV] = "Gamma 2.2 Inverse",
+	[DRM_COLOROP_1D_CURVE_GAMMA24] = "Gamma 2.4",
+	[DRM_COLOROP_1D_CURVE_GAMMA24_INV] = "Gamma 2.4 Inverse",
+	[DRM_COLOROP_1D_CURVE_GAMMA26] = "Gamma 2.6",
+	[DRM_COLOROP_1D_CURVE_GAMMA26_INV] = "Gamma 2.6 Inverse",
 };
 
 static const struct drm_prop_enum_list drm_colorop_lut1d_interpolation_list[] = {
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 224fae40ed2b..5c4c763da83e 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -126,6 +126,45 @@ enum drm_colorop_curve_1d_type {
 	 * The inverse of &DRM_COLOROP_1D_CURVE_GAMMA22
 	 */
 	DRM_COLOROP_1D_CURVE_GAMMA22_INV,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA24:
+	 *
+	 * enum string "Gamma 2.4"
+	 *
+	 * A gamma 2.4 power function. This applies a power curve with
+	 * gamma value of 2.4 to the input values.
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA24,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA24_INV:
+	 *
+	 * enum string "Gamma 2.4 Inverse"
+	 *
+	 * The inverse of &DRM_COLOROP_1D_CURVE_GAMMA24
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA24_INV,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA26:
+	 *
+	 * enum string "Gamma 2.6"
+	 *
+	 * A gamma 2.6 power function. This applies a power curve with
+	 * gamma value of 2.6 to the input values.
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA26,
+
+	/**
+	 * @DRM_COLOROP_1D_CURVE_GAMMA26_INV:
+	 *
+	 * enum string "Gamma 2.6 Inverse"
+	 *
+	 * The inverse of &DRM_COLOROP_1D_CURVE_GAMMA26
+	 */
+	DRM_COLOROP_1D_CURVE_GAMMA26_INV,
+
 	/**
 	 * @DRM_COLOROP_1D_CURVE_COUNT:
 	 *
-- 
2.56.1

