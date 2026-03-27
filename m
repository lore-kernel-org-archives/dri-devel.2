Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB97310BA43C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F3210E330;
	Fri, 27 Mar 2026 08:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3RPHKK+U";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460CD10E186;
 Fri, 27 Mar 2026 08:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH/j7pe/pta/xpt9NMD2ZAFj8avBUjKz9b7IS1NWDoNC8LWdVZXRQ6mlztfKB34G5w11H1n8qu1ULiHFz1+A0tm/qATEWAPSm0HTD7SQa9bHOc2dLgCqb3dOSJukwRnz5XnMJ82wDXgi1jG1RTuhO6ImMmQaMwx0CWOfY3B+x/E6sQKX07WvWGmt3w8LPxz/LT1bSjFMH5xeOHeD3x3W59q+HyJUacqiI89D951KygkgKFDDovYsKnPLFBV/cgHpadEAXAot2BQOUG96YcxnqcFLN2dH/eAOWnuoGvJae4OKuP1q/2h8M7VD171YDAB5wGWFsiudAjhe279TMVO4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ywg4aZXzdvSDuL1KY35DamW00mUQ7DmjB4I/hf4Auw=;
 b=gUFETCLWtlhiqMPTyvPcEFiEuBtKwsxBbJKaw8ZIRTy5WABku9bTrnt3lDJFQsDmYalItWybZJcO0NUcJd5wGVsz1QsJJpYNu0G+7sBZ3dF0dl21yJIw77QxaRBGj5VY2FH6S5F+EV7Mhxn4V7Nv4dE0WNjURk2LgAF5D4iwUOCSrk71V0Ih42QGwS406O//7SSCbruFngN6TrKhY/eJmSJqQxAnT19qS7MY2GR3JP3Ty55z8SVm6LiTHVlm7McDDbmSrAicox793doHXUcFPor0Jluo6SLXRYGlYS/05T8Q1kCYYQeiFxQEfBFdQHybf6Wk+q3mCxVGPr8Pon6ydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ywg4aZXzdvSDuL1KY35DamW00mUQ7DmjB4I/hf4Auw=;
 b=3RPHKK+UBhS5tinoD72aXNI7rsFGsjmS7nGqS6PK1GVo37RmVuW+mOosN2OEAunHgKj1BCYbrlhL45er5jfQ9uWPaUQpBDq4DtwS+AizH6sI+JEZKUiGOgoSeryW8IzfFTarSWFhEbnaXGBB7og3kzCQQr5Uu8I0czigUsWfSYc=
Received: from MN2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:208:23c::28)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.7; Fri, 27 Mar 2026 08:24:02 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::12) by MN2PR18CA0023.outlook.office365.com
 (2603:10b6:208:23c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 08:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 08:24:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 03:23:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 01:23:47 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 03:23:46 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Limonciello Mario <Mario.Limonciello@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 0/2] drm: Move AMD VSDB parsing into DRM EDID core
Date: Fri, 27 Mar 2026 16:21:57 +0800
Message-ID: <20260327082342.1286878-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a6350a-e72c-4c6c-774a-08de8bda33e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ma6FDAmMB3ixpGlnJjJbt4plZmd45+2gk155mIGAP+yd7cVasotRLXUEZjPdaNaqXI3jChuhC69nlXP4LxsMXrcGREufOGsTATE7E7uDG848Dp137pnRFew35nnQcUyuEHCA6hi1jTf4GR+vi0aN/npqr2RUVVXGtAWxCHPv0rUrvk4lJ4G5PzeqLALo0IiR2VvxeX8F5zEakj8+1QGla0KDGPql+SS7r4SGjOQygUrbbmvDscUaHFnO98Vcnz6OJXeGG/VDh2mF5KZNInVPj2i7xxqgwU5ZIqqWK7iAJzL/w0an4vXJfLWqbLIkQWQT/KWoOX6lJ/1EshF4MuQxE7AkuZEyJRzq5NnanSW9yGKpy3HEpOQKeuPPx6vjH3/DG5sF1fVJ1xQf86973y7nROvADfBHPD46/JILTvxIJJuQwzy9AZqKRZt4lFNmFjlrrtjPwhUeOIRLkLUZbS9/7We63oXbSuncF5cfdnepo9IRAO23KPPo0zx3HXUXIuPkiw5CFlLZhJHt7ZKNFU+XImIBjCPF8fPvwGlqNEnf1XGsGxv0bRwNd+pWP5DeF1vpQk3xVpLNHAhnT4hdjpAV6BKfyVireOcDICSAFGCRJVwhZIEzW3HLdRwABvSQ2++vQ8N1M9kPg4Bgp+Nl5EyMxwrNWxCP4UW31ef+lL0n1KXP30la16tHRtadhqfU8TQmZmiLy6wZctWbrU9qSGVHZfos4gg4RoZu5aWyU4TgilTWOuM5OvyVJ/WqSact6xVkr9ls7RtiLKGhAR1jSZDAOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TPm9dnM3Icx77jHqrMVIINBRe0D9/QL3bGbD+GRVSgiE4o6S5USBDWjaMNJc7ogdZzUWdmpatp4C5ruk5rd+LgSTm3ohhpD/Pkak0N/DYnwIgZjbbxjysV3LGdUchmaRK7ewRfaHNXK9o2QUuhJgfjP0nBh1rJxcZEn6rLEwNScp8AK6QBJXJ9Hg8zU7/YJronaxHT+9krT0dtuFD7fqLBEQer2nQFCrfHhURjQ6fKuqtv5x/d2pUOMJfXBuV4vuF9uKnC89gm6EB0dUmMy+zTypU5PguqjgN15Rg+aIBOZ4jmEdikqZgqjiW4JVv6G3Egw5+3cZPI2Krj1MZ/386lX4X4uWKg2BxJSH1uVirQcQJvAXowqAiKxEURYE4+fu1B3429ao4iz21VyzVewDTvMzfh7lIH/UcZrokHj4yK9zjByvezZ8TZ5pUmqhOQPy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 08:24:02.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a6350a-e72c-4c6c-774a-08de8bda33e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

The AMD Vendor-Specific Data Block (VSDB) v3 parsing currently lives
in amdgpu_dm, using raw byte-walking over EDID extension blocks. This
series moves the parsing into the DRM EDID core so the data is
available through drm_display_info for any driver.

Patch 1 adds the parser in drm_edid.c and the new drm_amd_vsdb_info
struct in drm_connector.h.

Patch 2 updates amdgpu_dm to consume the parsed data from
display_info instead of doing its own parsing, and factors out
panel type determination into a dedicated function.

Chenyu Chen (2):
  drm/edid: Parse AMD Vendor-Specific Data Block
  drm/amd/display: Use drm_display_info for AMD VSDB data

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 120 ++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 --
 drivers/gpu/drm/drm_edid.c                    |  72 +++++++++++
 include/drm/drm_connector.h                   |  38 ++++++
 4 files changed, 178 insertions(+), 66 deletions(-)

-- 
2.43.0

