Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E20606A330
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L+pethAH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE201123D7;
	Thu, 19 Nov 2026 13:18:34 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE76810E885;
 Thu, 19 Nov 2026 13:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/doceHlkHFx9syTLAqRPhOLaPNE6YPEPvu5fxRRVTMrRGkOnP/7+hFqAx6v+7LwpyXJq1yKnQBsrYLbOhaii6LqFL2bWP2IgIq09cLYjJSA15XzBHiPE8X7Yf6d05c6zCjsOIWSNmObOnr+HVYNFeIrmzJZZ2j6SGYOM6ixTew6w2FjjPI96e0f3fLKyEUGrh1er4fdiZB+iFGmWZJlP7w2TTLEOKqrn3SbetZQXPL68OjKiwenY/yjdJ+QrSDGOlhidVoku3U+8WVtDoQZan4Lt5nk27caTmpBVx5I+AM35VzLe18F/L/oae+cCyI7eJat04MEPFFkfIFJeXl0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycV+Wcu6rGsCYWCDDUPlqUVEgp25S4txTdejIjpIRmI=;
 b=mRKkKXFszpjxG0vPcd9WHENTJ1K2qaN3IzWFQfZmW5jvDocmRzwm3uV01fgZLo8QYzeHyRjj2uO8ZjBY2Fc9WZRIw3Zjk5fH8915u1QgVb/nWV033uwBQIefx2Hk71/Xr1naoDcC8F2GrSAvNbYEFzb/CZA84eY5E6pxV2HnW2JWX4cCsD7Xs/pR9tKonKgtvgwC6iKpCDox0CrKabi0PO+nu9V/SNBVT6L/h95u1lpCQTC8nofI45ClCgBD5S/EwPdgI5CWDLKYxVwe6dCbJBoylNDsj4oA4amtUVV+8DfG4LC2KYvsLv++lfOI1nQ/dtPZ5EEMTkVH3pxZtNbHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycV+Wcu6rGsCYWCDDUPlqUVEgp25S4txTdejIjpIRmI=;
 b=L+pethAHwVe0kis1e6hwHpBCAw1LE97EDw2apwSte6RYe300e53CvFOFpO7dDwzGAwhH2NS8UATB7sXfQ9NrJ2zZviJu5UPOKyFP0ALASq9FjMrZfpcKMTkWtX4bZt1llyK+TfC6KpLSdKr4ZHDyJAW4vn34TY+nqRT6XIKBJyM=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by LY0PR12MB903988.namprd12.prod.outlook.com (2603:10b6:404:214::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 13:18:23 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::54) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 13:18:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 13:18:23 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 07:18:22 -0600
From: William Palacek <William.Palacek@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, Sanjay Yadav
 <sanjay.kumar.yadav@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <linux-kernel@vger.kernel.org>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH v5 0/2] gpu/buddy: find range-biased blocks in the free trees
Date: Thu, 19 Nov 2026 08:18:08 -0500
Message-ID: <cover.1795094029.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|LY0PR12MB903988:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c5d73f-776e-4812-faaa-08df463f96cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|56012099006|5023799004|11063799006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: rrGspR7nz1NYh7jeq21Ig9+ODgZGqtCyqEDQPWk/rUPXwgbrLCkEt78KYZplrxj6+k/Vf6TwaPnSeJ4Ev8tXU/w96bzWVyqq2ja3TpYf4Wgx26DG9d0Q/zhswwO+kaBKXBtRx721BdP4ikT6o5cr8wGyQq0lkiBXjhauE78f4y1FlAwBXNW6eTlGy2gF/amcLKBTjfrvaEBr3aYB9gvR3ccXamW/gPsWkHbXoW9LJDeriIipdYZA1rhyd242afIUtO+t3fEpdVNEyGil26K6r2OfDGDE+yL7egy3yxWuxrdQpqyYgsAgrUI8eGSVF98XB2UyV8XPLWf8vgeahSMGgTFm6dmGUNEY1iyDJq36YaAvBcBmpjWVHBXOUhc7K1Jcuvwo1c8tNoFC4RtwIjWXyXza9LZWZwm6XC8RMqq9UgrvXoCtFtlFSCO5743Ilst5GDGZrOI7CgWcKsh0Igd+qGogyC4/wEfEp4yfVZXNyPEMvjIB2nA6h/4GYLWw9vlvfHrFqwx0umeHGkYcSJFWKO6xX9cZcBPqGGmEGgz4U9AlcGr8RyosgvRUea4Bq3Vnjn31OKsQ3CYvAVs3uuHAwbXLxtxqD1aZ31B0nGsfUeWIOuRrmC2r71mEDCc6pdMsIbIQh1kFjGF39npQlB7YbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JTp+UKghXBSNLSQvRhyhmqO6lCJ8L4FKC/HzzFgbes07vQMNWu/j7xO/0DfMspW1sda1A97CuA+PTtJTiWNetVFaZJtmlvtdAWeRuRM2Z6QAGvDW5UzgLSFKIXE6ulTZyDPpfBaPsKNsH4+A9IWL5pKpoct6zQmrYsCzOluJWGRwW2WkaXmawVLeBwYToqgQBUukiUJh+2LymahAFCEcJen4kiI3qTa81Gjih9sXIylbfJ0+Ry8KQBpS9YQh3qR03fHr3Iff17EI802GnL6BLY/hzQCIwFP4KoFO/urDkPYhx5Xx2JqQhWFqt8sxAm8uXGOS2DBg3R6/aLWdOpBd9BLKbosJWuhVRJqwwojU4G1TZM473JStsD8MkCbvg/X5NXjqXn1DbtXvJtLFMykCa/uW5gUyk0Hz1nVoF5VdoXvhNqecAwelwWzz4hvugcAY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:18:23.6158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c5d73f-776e-4812-faaa-08df463f96cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB903988
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

In a range-restricted allocation, the strict pass of
__alloc_range_bias() still visits every free block of the other class
in the range: a dirty request among many free cleared blocks steps
through each of them. amdgpu restricts every VRAM allocation to its
memory partition under NPS2/NPS4, so it takes this path for every KFD
VRAM allocation there.

Patch 1 replaces the walk with a lookup in the offset-sorted free trees,
on top of Arun's range guard code, and drops subtree_max_free_order,
which nothing reads afterwards. Patch 2 adds tests for an inverted range
and for the NPS4 fill pattern.

v5: squash v4 patches 1 and 2 (Arun); no code change.

v4: https://patchwork.freedesktop.org/series/178969/
v3: https://patchwork.freedesktop.org/series/178108/#rev2
v2: https://patchwork.freedesktop.org/series/178108/#rev1
v1: https://patchwork.freedesktop.org/series/176957/

William Palacek (2):
  gpu/buddy: find range-biased blocks in the free trees
  gpu/tests/buddy: add range-biased allocation tests

 drivers/gpu/buddy.c                | 334 +++++++++++++++++++----------
 drivers/gpu/tests/gpu_buddy_test.c |  67 ++++++
 include/linux/gpu_buddy.h          |   7 -
 3 files changed, 291 insertions(+), 117 deletions(-)

-- 
2.43.0

