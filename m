Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFF606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=U4vhPlcF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4295710FEBA;
	Thu, 29 Oct 2026 00:42:24 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE1C10E746;
 Thu, 29 Oct 2026 00:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTOcjqeYzswV5wUdN5/f1xDY4xtY3exh1oCotlP0ctYkqM5cmXlpLTeuTZcSIPAf9J9ApW2F4h3u56rQMvfYTQYEtUG431kMjuIpFsG6qsx/2LZDJc9qepOL+pXIZWc6smKrQ/Sz1444S9IzxnC+pg0xt3TZ90fNo8LaayGe9H52GUAL5eHhCxWO1qoZI6LWw5aac+EB9iDaQCOYMfxxnSmDx0d72PkJ60hU8GuBV61s7Fgtim4aeogRzedTIfB01yCvo/P70YdgmDchvQJ+qkyxspFH8n5iYDWhjVhumAcBxB0wkZumfN3N6Qa0h3px8RQ0lsUc+oi0WK4IUQqfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAdDS9MF42yYcSVdIDk4nT0i8Vh7R8eePjjPASzJHyk=;
 b=aHM9WxzpGf3MOewOaFZw60okvIqVC+67wppJep5GoUcv4ps3n4TD8dpo2crgfGK0rm/cKbtzffaFr05KeCdJhljI0izOVeRblM0ouKFZkgYgJzW1pWbeTDoZh8qdOS27vLpW+lj+fGK4Q6Kn1GdEt7z43wciEF+p978NDZ346Nm+ldvIv3P5lQWbVMWuc9p8lfkEqsHSFOEFOEk+Hcj/yTWHstqjFOKxkw5URG6aOlG/fTj7tDLl3qRttMXC9sINkMoSBd4qbBna6eW8hIvXbYNMl5c93gudfrVymydVCuGWmjq9izycJC2yYk9x7vFmSk959MPxLsDSpbkKuXN1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAdDS9MF42yYcSVdIDk4nT0i8Vh7R8eePjjPASzJHyk=;
 b=U4vhPlcFsx9DAVYrcy77AnQwmanZU+vxCvYx3ymQdM43ikirKDz7Q+d6E6Ip9kVaIv+B8b1YQfyiyY6gyUAGbjmFqdyfXiwf9dU7bBPClSy3+aFTfaG4BQhtalfxuDKY7gk82N1Ly1oBn1Uhl7uJhkFZ7en1eCj3WO8NvSD9yHQ=
Received: from CH2PR14CA0047.namprd14.prod.outlook.com (2603:10b6:610:56::27)
 by PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 00:42:07 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::a2) by CH2PR14CA0047.outlook.office365.com
 (2603:10b6:610:56::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 00:42:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 00:42:06 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 19:42:03 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: Rodrigo Siqueira <siqueira@igalia.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>
Subject: [PATCH 0/2] drm: Support HDMI 2.2 FRL rates from the sink
Date: Wed, 28 Oct 2026 20:44:55 -0400
Message-ID: <20261029004457.40545-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 22916a95-0296-491f-7280-08df35557509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|261009221227099003|261009220027099003|11063799006|56012099006|261009223027099003|261022105027099003|261009223327099003|261009221727099003|261021121427099003|10067099003|18002099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: V1LGnhRrEVbmrtyCtWibqm+OEB8ffysiIrXmSvrOADDPTCgP1jC0kNaRPtfH9yUFVGkQDXlDrBWK/FRLohMH+ixNoyOrwhz5pT0p3yGue99+eOeF3Ogr5ty9c083HKVxSA4FBcISCg6Lql2fwy57/oSpSXYEOD/PiDrVJOoEDxmmC70iAPMUMRXxasa4/LjpPueBWwH2ae9LyrGZzBGqVE7pyGbjSklfHzbh+hjyDpXOaARxSTNMO49tUxklqg++L8IoA2IuyUSe1O8hC5o9wZpoqQT8OTncc6eHYuyM1rsIU9URYPggKBvmlkG554PkweyZ9DA048BFlxgSJkFd+/EGab1fB6kRE9wzl3iyPytatidEGF7DG40sK445SQ/zrRwPIjzLDmK2NfUj25sWo7HP+XmKhvymUSCrPIMKDLabtsfnXmjImDdU8a2/PAd9QHL4g47Zsn0tsIHJrW3XBiSUNxpaRzdgU5DCtaHSZxAouElb6sG798mG2Mpb0b89wdOxfnGbMxgIj7tBpMefZQwcxpxK35l4F0OFBwYewi9XwyxIdLctzgZvu4SdZBpD1mLmzytQe3rpWdQM4ihU5w7YhDKD/2RS5tXEFLcScaSsP+lxhbrdJvEhOhw/WZI5odtlzePwtRcFh8O9e+tmzRsd90GTDYF/2jHzRCZmKQrG/d/yZeDpLa9a/2CqZQVtX5W2BZum+g5Se5H2tR2S/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(261009221227099003)(261009220027099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261009223327099003)(261009221727099003)(261021121427099003)(10067099003)(18002099003)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 24me5P29Vi0/g7Eu3K+6lI7mz0yyen6I28G7xPFOcavNBJvQoOlOZfNRTk1E6rwN6TGJ0syUFmjU2cT9LnNTbRsgva2YlK/Xl3hLttAkb0sOnwEXMjGinBsXuDaBVaeLKW4AHZQxs+qSptVDW4jk3AZeH/304i5eXqhwEw51/vcUEX65k9qwccpeLBGzRA3/g5OTzcrBEM0Lnlx9dnMO97jO52jaYZP9llEW9uwSW4JEcRWC8fFGHuSeUInzz9Zk0rJizeSRd0V4TfpLLIr2TOj4oRdmibfJIQBLBZJ0F78Y/Zw18em0hfsiKzEpZFErmI+KKO9T/p7VKVR5hVDKK1+dbfYPH1rOfOVnw8JWTUqkS4lviYDAsKN+mXh3GLMi/wm6/W5M2moSV0FSQw68/jSKY40TGQLmh0lGqTTx5TOekT28ZiEw5c1SRguzb8d1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 00:42:06.1381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22916a95-0296-491f-7280-08df35557509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789
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

The HDMI 2.2 spec defines three new FRL rates - 16, 20 and 24 Gbps per
lane over 4 lanes (Max_FRL_Rate values 7, 8 and 9 in the HF-SCDB). The
current code stops at the HDMI 2.1 ceiling of 12 Gbps per lane, so a
sink that advertises an HDMI 2.2 rate is treated as having no FRL
support at all and the link ends up trained far below what the sink
actually supports.

Patch 1 teaches the DRM EDID parser to decode the three new rates.
Patch 2 maps them back to the FRL rate index used by DC in amdgpu_dm
and extends the KUnit coverage.

Fangzhi Zuo (2):
  drm/edid: Parse HDMI 2.2 FRL rates from the SCDS
  drm/amd/display: Accept HDMI 2.2 FRL rates from the sink EDID

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 ++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 30 +++++++++++++++++++
 drivers/gpu/drm/drm_edid.c                    | 12 ++++++++
 3 files changed, 48 insertions(+)

-- 
2.53.0

