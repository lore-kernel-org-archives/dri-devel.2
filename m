Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F0606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XSVT577x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF0E10FA5D;
	Thu, 12 Nov 2026 08:23:59 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A4310FA5D;
 Thu, 12 Nov 2026 08:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRtm/TZhdeGhDR26aPXug+KHl7KE1rhODNqFfKPT0do3t6qm70Tvkh42HrUI9jFsCdyq62m6997iOLZZbyd7kiUtT8yfwKdxEHRjk8wbJaSAXDAFEruDSsFaT1JJSWSM0MVYuTV0EAa50eNkSkASZU4w9fQs4mcmnZ0D/Am/opOkAE8Kh5QPtmcnb/3z+PEbw6Nr/paNlA64vMBCQYD3WquqAmS0tktUuVCFyQDs610NMWINbPTorDKpS/T9r1+Q/6hKcF7LCRpdZfN/tqQBmYI1bgFttYhA7zBlwYEG06viqQfT133AzjGvkxuqR5+hhZUmF/euSBKC68z5RJa0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT3R9VfaM63vNG3uI/f+9UoutDIZA3VyDKPU/SEh0yg=;
 b=DKIKmY+7wcZfsj4q8TvYadGVin9sY8wSqtVl0zKXGbjsgak/3G0mn0RGF5FUBLTYxX/HYsXgqJnAcEIz1JnN9L23QhrmRRLHLI0h+ERbjLwA2RVe+P5mvTxUdXKKhgDsqGpSQW0wQqnI0QyyBLahq9uBfQXm0c2u08gN9huqcVox1BcMDcTrx04GewilqyMBIH9DIvWISlEWZA6ZUObe3+Cbuls4pZfY59UtBAsxCkFFkxUlkBcldjphuIu43wgYzKbrTGdjWRtnyOlyuJG/WjdFnnsC6cWwj4jDkHMXTqpJ6IgmVEoKHWj/6oxLrFyGIussPdWwE4UNVDseIkeb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT3R9VfaM63vNG3uI/f+9UoutDIZA3VyDKPU/SEh0yg=;
 b=XSVT577xG338zX8U5VXeFOI8lXA/Anr4NvnHdOwuERPPL1e9mb88zEIYXFIwfMMzPtYvlkl3TsKmhXRuQKXfCQ890HuT/5Pxm558qwxcMdO03RnVT8/rpI0yp3y2HqugErarRR6ZZ/G1CpPvZuTKhkem2b+4BvNKyNnrVaTi/ww=
Received: from MW4PR03CA0342.namprd03.prod.outlook.com (2603:10b6:303:dc::17)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 08:23:04 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::2c) by MW4PR03CA0342.outlook.office365.com
 (2603:10b6:303:dc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 08:23:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:23:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 02:23:03 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 02:23:02 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 02:22:59 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, MuXian Chen <a18165943161@gmail.com>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <simona@ffwll.ch>
Subject: Re: [PATCH] drm/amd/display: drop RGBA8888 from plane format lists
Date: Thu, 12 Nov 2026 16:23:58 +0800
Message-ID: <20261112082358.3995494-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030164327.8461-1-a18165943161@gmail.com>
References: <20261030164327.8461-1-a18165943161@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a679e5-6fd0-44cb-6098-08df40962c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|22082099003|261009223027099003|18002099003|13003099007|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261028144727099003|261026140227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: LVatbrYZwhRlMHM5huu8Tzkd7rstyN4VB6AyVZimKxBqTYtLPkxWw4IgiUR0dvF9LyEr72o5tdCDinmdDPQnRE9G84RJgHLJ17ytWGItGGJKLHxHUQfcqsfBwGF9KR9hhHJpc380ZGjlW8PBDv1zZKeuM1jBtn/gCw/AN9myPW5ATMftEM2bbVSCBSIwjVVpVc8tD2R6CAbtMeYcoCKZbWN2308HZ+HCwk5/ce6sXCp4+rnTZwNQdj7/+HVxzAhS/TSouDSxQDtq0u0gqAnsuzfetWwXNC71cGEr5Ry9cnGUGqVA6J3jcoG7hhWoWMZlsl9AM4u0wotBVJ8GqEq8yqxjcMvZZvYpxWWcsg/IrcJ9jvMqrbfQScKWVQlbJD95VQukIY3L1muXciXKjELyVLwrWnayHQo1bbcn2UhAgqky1kdnLMMKYr6WzhkiW2jkdLQ9vqkF6ZqV4U22gUZCvrS3Cg3kekpqAc76GQJR/PeFIQuLqQlSjWFYmkI+rnOl3PhDElvYqGqlNilHIbO/kuzlTVd5Ame11u2ur+1U7CO2hgzxwrKX9MaUL484SfOEuGQZh8upbCguAFtSVK/MdN2YpLDwZivQmfpxM/lRX9xM1Q8ejauXZz/z+Y0xtROH6CNL28fhHcNvfNFOleA6TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(22082099003)(261009223027099003)(18002099003)(13003099007)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s79B8Y2hbUlO/Fu1eSJc9EJwxvzgjvXwQfN1lOXnGwh+sD0rdY+zdO4fUixk/l++05l2LJEH/ryirsXBTZq3NWskpRBiNhhjfokBB8r/eYZvCul3kU+54iHSDlbsznvT6a8WyR1vV7kjF1hIRZbERmujzLdYZdUxz0e7vRu2dvP78/Xl4Pvl9chz0ASmr8fPxX6mlf1CxEDnTy7U+Ep5Okg7pGF9wTVtLVyXLBK1pi9MEanN9pqEo2D30M2y7A4BVrAueNq/Jmxd+ol2FJgcoixgGVP0I217vzcSWIm+ebCIyG0oRw58Xj2Suz3kZDBgVdbJecVXmphdEAQUyKSFkCP5UBjcqOSAgdvbnhvKUZuviTJoT5yZJLNHnSEhHLMLCxf6UWEOuK3Yxg4vdMxTCdEdnFiTsSvD7yYi+xFVL0xdgdfTP4p3fYyjHkHBbc8d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:23:03.7547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a679e5-6fd0-44cb-6098-08df40962c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 31 Oct 2026 at 00:43, MuXian Chen wrote:
> DC's enum surface_pixel_format has no RGBA8888 (memory order A,B,G,R):
> fill_dc_plane_info_and_addr() has no case for it and returns -EINVAL.
> Yet rgb_formats[] and overlay_formats[] advertise DRM_FORMAT_RGBA8888, so
> compositors (KWin on Wayland) pick it for layers with alpha and every
> atomic commit fails once per frame, flooding dmesg with
>
>   amdgpu 0000:06:00.0: [drm] *ERROR* Unsupported screen format RA24
>   little-endian (0x34324152)
>
> and forcing a fallback to composition on every frame.
>
> Remove the two entries.  No working configuration is lost: a plane that
> advertises RGBA8888 can never convert it in fill_dc_plane_info_and_addr(),
> on any display generation.
>
> Tested on Raphael 610M (DCN 3.1.5): before, ~240 atomic commits per second
> failed with -EINVAL; after, the plane format list no longer contains RA24
> and dmesg is clean.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5339

Hi, 
thanks for the report!

The corresponding change is in
https://gitlab.freedesktop.org/drm/amd/-/work_items/5339
and it adds support for DRM_FORMAT_RGBA8888. We would prefer to drop
this patch.

Thanks!

Regards,
Wayne Lin
