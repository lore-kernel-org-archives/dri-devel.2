Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D9606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oaR0UPlg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E32A11260D;
	Thu, 19 Nov 2026 15:55:00 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE171125B5;
 Thu, 19 Nov 2026 15:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWfThiQS02wL/6LvmSWSknrJO3FEjQCXFowE5J3RR4GQWZg5Xd+LJdNDf3twrSeIMldCBubxl91b2/5ITjnLsqoazjCeUpBUSi2VOyzK46YD5MNf1MJE9ecN6BZlsUbprUn51kk9n1deGDJNd5tYZDfML52QYphq1DYjgh6DlFf8It//m3rouBco3YZiPVDcxLoE090VxRqrHh0wFKAIHH21MxWetMYfyD/Gp51W52d/QYh/DLYEl1oST3QWEbp+yF4vc5t2TKIkl+MsjpEWXvAFNsXkUURr8i71HxaWfmMp2E57OJvGw0JeCaZLES8CEYmylLSbED6ouetRslI3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFu2kUlqlBkqWWRMivLzqWQFRFkUpNYaiXbWCSblNN4=;
 b=KianVLNqZgLpBRQWNX7oUw3KFiNaWach114IBo63cLn+jZSHvEU+3jKebhZQLoc5at5fILjCBmzvmyPP9Vg7BWhE+t7vtCrXvF81ZA6rlNaBXupmT+6U0nWvEuIfZC7jBRly1TFsl/L+TtRc2oy7ews0vpRzbex0n2FIo73y1F63nYU7qs4DV8n/jBYqtlAHcWFgHgsnKZkN5zNPJnpnKqQFvJijzGl535qDna/yfH/rF1dbhLBWWbBc4gPrww/L1n92npPzg77FQld37w2qhrRlX7cwQYTYpS7wFiZnFv6w2KWJVNI8Z/XxtCB8wenH2ecqdB/Z5EqXwbdgsW6kzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFu2kUlqlBkqWWRMivLzqWQFRFkUpNYaiXbWCSblNN4=;
 b=oaR0UPlg0jzmVew9U8kZGRj/dkbU4GxbF96TiEE6dIHCDI1N4OuImlWLjMwiAh3vzhFxN3kzeURKMH3t8bIICjZSsrCX1e8zDkQJLDYLwmTadk60brLj8mdBJAYBN6xEtm7QbRkIP1lS8b6dx9P67OXOuvqd04QaMrVrAyDlpJE=
Received: from PH7P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::33)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:54:37 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::66) by PH7P221CA0003.outlook.office365.com
 (2603:10b6:510:32a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 15:54:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 15:54:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:36 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:36 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 09:54:36 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 0/4] drm/amd/display: Add Gamma 2.4 and 2.6 colorop support
Date: Thu, 19 Nov 2026 10:54:23 -0500
Message-ID: <20261119155427.2494007-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e948244-437b-4c71-495e-08df465569ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261021123027099003|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009221227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: OPa1FjFbRQi+mzmNc512brzQkZ3LMU9vkz77aExLIXpn8EfzLvL1JshQ4guZek4Apl1nzls2zjAiAMOlhu9T9Z2IQ4Netc/fOVmm3ZMI3JOoQ0I7xnXjWr58QvjEyQtVPfyppU2kYjKllrRxzUOw6Cr+Xu7HuvDYaMuR2s512tJG9oktNCFzAtRmhiLxD30pbOmqa+MkeSzSD9gRoRqjkEW7y08/aQbjWn8PO08k22LnLI9fdSvpImPgRFo+PuveIvh21xCsuMhhnepXXINHtlYdtXqigy7QwhXmMEVnckVyRWq8WXadK8SWPnmkQxkJx7imMr5CPYRgKET3zWbVhKYUx/g9su/swk7x+N+ThrlQ9tQVt5hhAy25R9fiafyoCuCFcS6JCmxZl94KkFSVb4RudI7jSUBfmqaiuQolIVulNGZNRuGj6CEQPO9/FTlXPHsKtlktsd9xPCM5KLeIGPWCd7+h0CmHMybb22R+wZusJ/mRTlAPpHmLbuPF5yZhXzEIX89eNcGUGpbSY9HrtqZujuxn3+ptKViqLrWDf7hhJxqZnH7NDm2C9cDHztSB0Et3+zOwTvn+izIRLnob3lRTcxpYroXlOCptCBWB9ZHV6ALWI98PlSZxUzzqGi70OqvxG1mJzuHlq5u2aGEim0i+Yk2C/aZelT/761S24L1hyN2xn0oRGozdTZ8abL6GMJW04gVq0HnprrUesYbDsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261021123027099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eQ2/yf3PVd3++Ad5bRH2p9yUKm4MgeryHKY7PqmceTsRizHDgsav+i5VC89a7EtxxHOaZJhm7TaM+4dDbz+0fYnFEkmXQ7epCvrqmKN7C7zLvALFGoZ5gRuGRn/JvLtCs13ULOg1CuYPraqTuE9z3ab1TNkebYk+0B0qcKmXizAKTGRDDDQDdrB6VyquPDH+xYnYie8oSPtbLXH+dtVH1sXeEheKifAy20a+mg6FYXYB733ZgSEMIjxW8IxZHQ8VR11xCYKwo9BD59niiDfjGIlm4BpR8m8q5LOaTZUpfFLqKIU1HhpXuoo9eYMA6/xkdM9aPgat9uj5UTnQi0cyYj/R3yNoOv9Bpz3l6QK0oxXcsdWSW3RtvjqBVAx01SD4EZIgaC6XeLb9F5pjEU284wAicMRaVHT/qzpOQwOVrzWBK7QT7t3CQPSykyZNesih
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:54:37.2065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e948244-437b-4c71-495e-08df465569ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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

Harry Wentland (4):
  drm/colorop: Define Gamma 2.4 and 2.6 and its Inverse
  drm/amd/display: Use the wide CM3 curve for gamma 2.4 and 2.6
  drm/amd/display: Add support for 2.4 and 2.6 Gamma and its Inverse
  drm/amd/display: Add KUnit cases for gamma 2.4 and 2.6 colorops

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  6 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 12 +++--
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 18 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 54 +++++++++++++++++--
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  2 +
 drivers/gpu/drm/drm_colorop.c                 |  4 ++
 include/drm/drm_colorop.h                     | 39 ++++++++++++++
 7 files changed, 129 insertions(+), 6 deletions(-)

-- 
2.56.1

