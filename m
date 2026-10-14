Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BD1CC6B24
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A877110E109;
	Wed, 14 Oct 2026 06:52:30 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2541910E109
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7yut+b49BN5moFI0qal5Pe74XsoJHYFw6BIudAYZWMftWK7cnsfMuuNII5RZ29RTy7UMdYq1cNzfvgwEG0dU/dsQ2ZwIfTRtKkJ9SL13dgXCalYjnF4WC+oMw6dUY9w/N3Cs5wApXfWIbvUiRb/OXENU4TsqnEeS0YKklOnARXWXeqLgmSao6IAPziq2oiostI+2p7lKbWWf50vjCuLOnKMng9MhskgctdrXVAO0WRwX9EUsuE8gXEOUpQYuxaCmdiUM9hc3n31Tbne7bxeYw9sbEyEdboM+V2R3e4X96PUUuI82sFR0JzJhW+06PemMwYeN4xh7PKRlW4GcY0pyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDPlK7KJNjqc/RTKUoRPt67DLEC1hdtQ23nBHSNDc8U=;
 b=UP2TJPGkskOXHecsawExjFcPu09c5nqpUAVaZ+pKHT6w6irpFQVW1c/pL1ERlYsYpUxK6GrWKy975AY9tNoWR6mlGsFxqGaO7oVOObPXwDi0Lt9HNKHsRH0QcDZ2mWVnMEBkFBH9s5pPNAsKrlL6rwcOc29gZmBMV1/OFJG82426pltxF3zJgiicmb9KrhyQ6tVFyzNBNhK64TjGuVIDtaQdaILBXeD6WcTTSHwRo1gU2xTzhJlBnzHAz1k7atuavvNdKF1zwbfzsyTr0yHz/FWnWU12U5tpoItzACY8swUDeYfXcn0pvDKQI+uoq47pkNyDFr7Y2F6ex9w9QFAlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDPlK7KJNjqc/RTKUoRPt67DLEC1hdtQ23nBHSNDc8U=;
 b=aa8l+2MO77SigGN+Bh3JMBIvTlbfr7Wgu3UF+EwfMyck1bMKbj7hmFxjYq/0bKFqerYIA/iKaD3d97znyQN9fpcpO3+V1YoFhu5BZ9WSzn562hxoNEx9WWpXnvqLWdUrzqmhtCRmMRyrBfp/85is/K6e4HBTMXVXXXZIqdsB9wk=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 06:52:16 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::ae) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 06:52:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 06:52:16 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 01:52:01 -0500
From: Honglei Huang <honghuan@amd.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Himal Prasad Ghimiray" <himal.prasad.ghimiray@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Honglei Huang" <honghuan@amd.com>
Subject: [PATCH] drm/gpusvm: use literal blocks for the indented code examples
Date: Wed, 14 Oct 2026 14:51:53 +0800
Message-ID: <20261014065153.1562717-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ad3446-ba60-4049-57c4-08df29bfaefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|13003099007|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: I6k08FRUn6L4BiRjdu3Qus94hpyNnjBxmY/4aexfyxkCvRKAY+rY6TXQj6FLVzbX/v+BwIPMpF5J9yAfPNgghF860cPvB7Sd1wNWPCkvJSmnUh4/CS3Z4ihdKpBEkYK5X23R6M6/om8pbP4Ud5FrWWU8slj2MqCAk1jkwXjmBu1JQmnDKWjcebSG8syoeauiQzM9QcNkmno1exo4mjerh+Eq/smRiDkDDC46k9kLqOwexO5fWAfTD2JlNnsqQzlgErfTIFqBLKj2w3IJcBgR7R8Kr+v4vklWsvLN+ND/WKGWaS8fFNm2rqq9DcWYl2WQQvBZArD6sk5V4ogSdXG0VsCdWrfyPTYopiYNh96/qNjZUs9Ik6QuaEvquwEI0Kk2YMhooAqvEIWa+GsfsfkwjgqFXZcyzeJmmoi++VyeUaxvzSusMV1Ee8LFMtTB6K6a8oUC+EkILNESph5NabcJxyQPc4C061Vb5ghWmB7auslIPGv8KYJ1M1m+JInQUuZJsRW3PURAqm99O4UHnO5nUJmG2lRtPJx6JWij+CwQH0+Ualf48CusQLAyB2ClRG4pKCIF6hdCiwBcI60BKzUUsJj6NjS79dgHEJH6//F6VBrOsXOdddr0pgjQPa2iRVRR5Es71O0zOQ2IEw3kZa9wassBfNVEuliqMCznTQDmadM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(13003099007)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SCVCeKUzXrYTDciU9sMPpT4dYULBEAfoH8TasLXOTOGdb5wAuQzTk6TjuShQcniLdG8y2NKdutpW7c+TfQuRxcl7UBwk3H3L+VwkCcS+rUgGkFXjyrqX7A3XV/yMlDVWXA8/uxIsHDCzBIXGnOgjNrisFwvJ22Hy/cKoLdofRuVsOi0uWsFi8KOWDZBzpPkib+yX3OHbGOQlslh4Ww3hMoAU7UD056omWh82fa8ICx7JB/Gfc3SHVmQPvgLEEjYsgW3HJB42GqLLJEsXpl0o1jiBSXdNI6mrCSXpvxYzDsGLWqD/2eCUr/oJFNbpG353ADE+TsIsst6zuDaSYzVqIzPzJ7XHiumpDhZRnazHkW+RGgzTQij3HW67l92EUzLBkzb6DWuhiLnK311tTO7FTu9JGfnpCPxELzNSdapS6B5uquUEEAD2qQ8xwSXu5mVY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 06:52:16.0807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ad3446-ba60-4049-57c4-08df29bfaefd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
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

kernel-doc only recognises ".. code-block::" at column 0 of the comment.
The two examples under "- Pages:" are indented inside a list item, so
kernel-doc treated them as prose and rewrote "&drange->inline_pages",
"&range->notifier" and "&ctx" into :c:type: cross references. The
injected backticks then make Sphinx fail to lex the block as C.

Use a plain "::" literal block, which kernel-doc accepts at any
indentation. Syntax colouring is lost, but keeping ".. code-block:: c"
would mean lifting both examples out of the list item.

Fixes: cc2a6cbd6823 ("drm/gpusvm: let drm_gpusvm_get_pages() map an array of pages")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610100125.d4Kk60aL-lkp@intel.com/
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index b6c9d3a07dc..7b166bcb0d1 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -67,9 +67,7 @@
  *	sit in contiguous memory so a single drm_gpusvm_range_set_unmapped()
  *	can mark them all. A driver can keep one instance inline for the single
  *	device case and switch to a heap array only when more devices join,
- *	e.g.:
- *
- *	.. code-block:: c
+ *	e.g.::
  *
  *		struct driver_range {
  *			struct drm_gpusvm_range base;
@@ -99,9 +97,7 @@
  *	The 1:1 examples below pass @num_pages == 1 and &drange->pages. In the
  *	N:1 case the driver instead passes the whole array and its count, so a
  *	single call faults the CPU range once and DMA maps it for every owning
- *	drm_device, e.g.:
- *
- *	.. code-block:: c
+ *	drm_device, e.g.::
  *
  *		// GPU fault handler: one fault, one DMA mapping per device
  *		err = drm_gpusvm_get_pages(gpusvm, driver_pages(drange),

base-commit: 34081b8bbbbfb9adbe04f764f718de04df23a84a
-- 
2.34.1

