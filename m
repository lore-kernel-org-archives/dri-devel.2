Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B17CCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFF310EC49;
	Tue, 23 Jun 2026 18:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/m2xIFf";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5852010EC41;
 Tue, 23 Jun 2026 18:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQ6dah0ZWgBH9Pxar2WPuyamylMPgxaUFE5KHWBRSGh1QIBpdJzJkDOFVJpucZJEUmcwwkF3bojkhHBYCRHxlBbDxYVf/qB+gj1CnZthOTo6ZkDu1z7cb0c9aRg5Z6W8AVTkRlYY7dXEbPy6HaGnHixDgMpgclturIa6dz0/AUNbHkObIRqPDbXGs6fw3RO+jwlw3OLJmX0e+IC955/v/IV02Tkbd8Bj6iskuBVrjTjG16BddMlLFSl3GROwz8viYjcc1TgEJizGcwMk/zfzGayY63Vg8g2izOFJsvtLmPxS4Ak36eckhaIapS+gZsMN3QSorccu+OeB2H46mVLXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZhQOP86MttbDqHhD+RX7gl4kEcvIiJdcc0Fuf3Pazc=;
 b=WU5v286DLil411kgWqKKYlP78GLz7kdyKHqrf0S+poyNGRLcctdAqfjoRoRu8bmxGlVHIy7ny2v1Sd1QiZ5zMApKF9qZD2LdsJq9Gx/Me1jkSxnCXQu/VxsfG/QTkG8Lr4Mn/A1GdPI3hpg48dWEbR3bOJICQUPyLB1tMyMrUf2AuR+KXLkqE3R9op2fMb8j8dhCzG7cc9P9S/FY3xUWAwYlyMWXOwSM0YGWz245EX1MlShBTfYeS8RQcDPH/7KdD6OUlnN/oABU+fk+BTrfobMKp8UPEkOqqKrGre3/ZjcZkZmjJu72fyF8YOE4mrMB1nILWSNFzO7lHZDkqUhCdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZhQOP86MttbDqHhD+RX7gl4kEcvIiJdcc0Fuf3Pazc=;
 b=B/m2xIFfgAQAIlBLCQhCIwwyRiOz1bHomjkrSfSkRAMCs1vsycj46mh4aZC0RxKdBHm+Gnxl48LUNk/TA/746D+3rNw4KSkr/dyt3Sj6j/HRe0XXBlcG3Z+pNPSEfjRIsgnv/cfFJFjpTP2ZoM3Yc80xd/usAhOaxbYuZkGm/Vk=
Received: from BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::16)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 18:32:01 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::65) by BY1P220CA0040.outlook.office365.com
 (2603:10b6:a03:59e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 18:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 18:32:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 13:32:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 13:31:57 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 13:31:56 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 1/2] drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
Date: Tue, 23 Jun 2026 14:31:54 -0400
Message-ID: <20260623183155.212394-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623183155.212394-1-harry.wentland@amd.com>
References: <20260623183155.212394-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b794de-a8ab-4347-1440-08ded155b76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 4VemgqfeUPqvXjN+HSf2ysa2D4m9QVIcjgprSJrZsJRx9rZJGPjrxGfx44Xm0uhjY6AHx+6cPklVj4LlWjV2Unxv0zlolIJ85d4lJ+zBm8LjerjGW/68VQ18V9k2acjBgVcBr2iWFy0U4uJdeT4o7F2RyeYALUi21LmSakgmqsbq0oVXHi5HA1nDvQVQKESKBGJrYmfqSnFL3wAJJ2reqLcSm1I84EGWMaFdC4Z4tLb9HXrphVzBXxbUl+Cga5ls8HSSV6LMygwRts4es09+HmcMsbTCIx233GdaHUIzbnLF8KmYUkmStsWTfXBCI4eDUNSD12CAViUd9ANFrsLiChkiUW5vRXl1uzMu3wHWIU/OT+ouB0WOWl4kOrlvcdn6R9XKbUKOgwPEvYnrZ355FPDWG/H71D1BHqejsl9mx31KUNcZJobyn7rOEoDUniOo40ZO/zUEOHmr+QECzseJD/JBQd2zEui0qzUQXXpfUVkz92dYHxAbXD2j/eAgqDjs/lyqdgLrcJJivOnZHw5ooxZG9bWsiEtbBAq44cFFuum23Zly1F30Z+3lIW5QV+58POBQswdi/gE5v5SckRz4vqg1FhGyikdJSBlZe/vch+R6v891es90cBTVE4JIraDx7s8yyMKNTmDANEJPJ4ac+s+wq3hxkMZ0wwlTpXcLahNdsBi8rLDj4HJHU9llzIyPmdCqVJLFtw8Q3mIg8J8g/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xyDv7IHN0/SrufFgul/IeEpyKBm0gVwgJugB5CXoFbsq8hanZO3yjbDTeh8xSpJrYaO4mWU0ZRrwOngUOHCScwf6tMzrSrLEbU18mG1NPVzLiDf6DDalZ4G8W9dTDWFffbGtUXzTYg6fhBHUUosgYjxheG0vMUuD18gefz3kowM+nenX5F6qOOi6okMA3hWxrqvO7VVWfaBVOTy5nqkHisM1PgXN062WC5YqFdkGcFL0ULOpq92bm3cw3b1H+6CHSnWCyauHkxMULq3OxQqZtq9JyXRaNODfxMoaR5Ktq+NWhQ1m4hqp2vRgsNLkJl+CyGwSCkf7YjXWEBz6EJ4a8cFlb9Ej7Gg8WpB4izcwqP04HX6SJoq4dbIzyOnrzGMpnCCUFSAiJo+cF1f6KXTKYqzy0v1iRMFIefqAlKIK7ogfyexDzhzeGSPA6Whg4K33
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 18:32:01.1693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b794de-a8ab-4347-1440-08ded155b76a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

Add new 1D curve colorop types for the Gamma 2.4 and Gamma 2.6 power
functions and their inverses.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Assisted-by: Copilot:claude-opus-4.8
---
 drivers/gpu/drm/drm_colorop.c |  4 ++++
 include/drm/drm_colorop.h     | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index c0eecde8c176..54a338312ce7 100644
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
index b4b9e4f558ab..a999d9bf6507 100644
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
2.54.0

