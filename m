Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F845606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GzcGcMOq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E60110E85E;
	Thu, 19 Nov 2026 19:52:23 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9789010E255;
 Thu, 19 Nov 2026 19:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpHWebWUwuHqJKpLA5VPa5702PrTpB9n4vCjGtTYl6jIzGAiSHPWAtJiEak6r5EGxwnQOPzhYsIvR7LYvRdZFk+YjaJd/WeWOOJqM78+DEVH2VnxIV1qez/QUXA4s+PLe+ga8iw/XHLd76JJ6TN6TdRE5eociDNxAZcIKDN4vgWCWdMsWCNiVQFcWqLeGHO48kJ8doN+lZcBlEZAdY5bm2yzlYSwv6Amb+mbBtJlsaFMyLDtwgM9143ZZ07iDZiVS0fhH6Pz0hPek2WVzrswqRV8Aqx2ovOCVh18DK8xiCKdlNUlEOba/wpfbzD2yZJ5oH6pzVHngVgsxF27p42FVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX/Y1xk9hKz5n2BO9WVZSTJo2pw3N3Jp9kM0fLSXwqc=;
 b=fVvXlQleNkc6DeFt9UYriY05RSw4QnnL3WMhrU/D6ldfDlITm+R/0Xd8eOQj8DMPr4Ga+5go5+iZ9APFbRnb8O4TNIZOAlzaNO0kLIzzYrAagdc1z1vK4j5m+0eASe4qbQr/C1m8Tm4KRvKkm1lOXa3FScMgPo+GZmk96rBB6syI+b0k+5FeCLUONrrqLmZTBCqF6SHzP6NfaF/mBtohhvkipnomPqPzBsV2m0/hlAWI4hZPI4PsLkf7IWRdP3l1Ls/ulzhGc7quaSZP4msJEB/AqUYl3Col7zhXF8neAeASt4b/T0zdbJYTeuSUAEiLfY1a9IOKTURdzJD2Eau/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX/Y1xk9hKz5n2BO9WVZSTJo2pw3N3Jp9kM0fLSXwqc=;
 b=GzcGcMOqQeAtHWDrzFHD2x2M3oUmU7hBXLP1BzQmtCeuyWKbnMVt2lUqeDDkUmsQFtWh7PUjZFc7/qU4cf5Irp7uBz41pShTsFsQ6lb5SiXMaF3NmmpRWU1DzBj7Ff4L3UvPSGJjMeCNbMK1tbVhSKWUkKIIpvhF8rOjSMZcbKc=
Received: from DM6PR02CA0114.namprd02.prod.outlook.com (2603:10b6:5:1b4::16)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:52:05 +0000
Received: from CY7PEPF000000F6.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::2) by DM6PR02CA0114.outlook.office365.com
 (2603:10b6:5:1b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:52:01 +0000
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
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:52:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:00 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:51:59 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 0/4] drm/amd/display: Add Gamma 2.4 and 2.6 colorop support
Date: Thu, 19 Nov 2026 14:51:54 -0500
Message-ID: <20261119195158.2546927-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F6:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ee47f5-d40c-4ef0-3502-08df467693b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|261009221227099003|261009223027099003|11063799006|56012099006|261026140227099003|261021123027099003|261102123227099003|261028144727099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5puzc0c7I1d4CBJvKIm7YYq7ZFTr40ll1c+wPTi6GqyzvVzBjZwGQetn0+ugLfDjAhA2bbI+3HX4E9A3Rm+BJz4DBKogx7cAdYUa80I+q5mWZwkIrjzRlDjk0Uptig02k49e24MM4c40B5qJvWvt3zbzK4O3XKOCnJA05OVRAW0yS1SQVjQM+lqFAbtVuQ+cUuRKFrjZHrkPjUEYs5vwZ5bopjQ3ine3D8Qd1aSCmCJt1VulSbLZ9B9rUl7FCGyno8ScsgMtoTbnHKDSIly/H6Oy2IjJBvlqr/9AwKMIcrE53bEZMdaPGxEyYdnoBczr8glfYwWL1auqlA6O5NudkpaHM/VrGVfd6QU+WOHaENZNbjxQJzA8cnpRk8f1EO/Oh6bmxjb80AsQXeMaDmxrvfEF8Emu9o6hKhMAZmyeH1bCIPPKdF/oN8G0xfleKwpaQITHzZT2z1v7280K5YH9NuJu9W4vvAsvNRH6ZdmAHPGsEtx2B+nWNmdByRRSzmHIuRjWcWpeGOR7/Zg8jGQfD0rxTWwS5L74TTAsflF53jU2iypvpAbxgA9FQ6h1flkmb0s2pSpQ1qzTN1IQKjCSlsw7Jr5Nwk+t6YbptgMCRvgbRFxXKjhAw1Rd/3+FqY9HPJdecxC6nJ2ZN9LZuZ4JpkjrKWXijEh3+cdrXn9nMi9jr7OLPfdLCM0Kssr6cvDL6FcYjN7VJSxD6dKMXPJZHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(261009221227099003)(261009223027099003)(11063799006)(56012099006)(261026140227099003)(261021123027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X9HEwP2tdWtrEI2291ES8HW5ovq5a9EkFK3cALMpsJ9H2fxOhyrVhHhNsmWidi2IXkGfKX1JAucWEm1hDYSMXAKvLrHAp4e2dA7wC+nqu95IXPDncaIpAlwsZWOu+3zNCS44tXPwPOpLi427gqz/dp5g2coAvAussYEy9MVSAusuvsn5ryh04AJI224X39zzhxP95I4emIAskzO8Fm9GvuEqUtoAVJrUguKyLJvEvGHuD94vHJPWd6QCwRiC0Y5a7KA2DYgE4+TeW0Kwb3Up8OfgVH2FDk/0rPmQi7fuE5Ro6kEDOMlpe0Qh1FH1Dk/OJUs8MuXpjiLnW5MzSaXW7BLED3RJPxZb758ofTjY0wGgmOmoWb9N6k+oFkdgdWCb/sdJ4p2GUmy69pkjloVs37/Jt/NevP9ZvQSXRU6SayLruuBLyHfnW/GFSS9LTrqj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:52:00.6887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee47f5-d40c-4ef0-3502-08df467693b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mutter needs a pure 2.4 power curve. The color pipeline only has 2.2.
This series adds 2.4, and 2.6 for completeness.

Tested on Navi 48.

IGT patches for the Gamma 2.4 and 2.6 tests are on the igt-dev mailing
list.

Changes in v2:
- Put gamma 2.4 and 2.6 on the wide curve in
  cm_helper_translate_curve_to_hw_format() as well (Sashiko).

Harry Wentland (4):
  drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
  drm/amd/display: Use the wide curve for gamma 2.4 and 2.6
  drm/amd/display: Add support for 2.4 and 2.6 Gamma and its Inverse
  drm/amd/display: Add KUnit cases for gamma 2.4 and 2.6 colorops

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  6 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 12 +++--
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 18 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 54 +++++++++++++++++--
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  4 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  2 +
 drivers/gpu/drm/drm_colorop.c                 |  4 ++
 include/drm/drm_colorop.h                     | 39 ++++++++++++++
 8 files changed, 132 insertions(+), 7 deletions(-)

-- 
2.56.1

