Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB554606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jah6JpHG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED7210E757;
	Thu, 29 Oct 2026 00:42:18 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0DE10E757;
 Thu, 29 Oct 2026 00:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT+Iy2LxCYWcXhYljkxYISDRxD5FgLlTRSyWFStmUOxZo5XbK6AIMj+/8e8mFQV6itASVtF5kL1pLQOOG2vXz+x1KZQ/KA3PbXByTAFAGhciR19mddBUn97csUGM+OvmkTP0II/YixLHly4i/T+FjknHdpehCEK5bKXbqPjxPskxPzkSaIUQ2FFHQm9a+A1oaH/jccARlQfkQqLzv2eINvcZFU1zA5LfrwfC/cPUv6L5W6memG+kN42quxeRoLJfKH5QG3nk+rENbmR1fFeQsTepZLgnqFirTu6IGTa3utd2FGuDpx/a8xZ74Escd3wtUQNUWK1u959kmAR8rMpxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiaGS5p6gX473+7d4PjdYMHcO01BTe5fVRJ55dO4roU=;
 b=fgLeIZht7tNR9qHULbCjwfpynXfT97qrnoP4k6Hmc6SYX8MA0LyjXjYs750BVtSJUQOwG36Z8Nbrt87MTYdaRfbGwEqQbKqbuBFGREs57hjKbA9ZuCVuvOYgmWukqBDbnG9Bd1D7jh3tg+cmzlGcxmcD3qK7IGz7sqthcWSqs/klIfLOFf2/jyOkmK8f6vjoCPoQ4YuLEEmkvvlKXpOcjSuGjY0/YIxKMFTnGVqKsM20cbSEKTylLvvTS9TElcufepCTCAR+u9xd7JWVxrZj+NxaycBiEKJIySdkQXQxcwS9tHkeShPTMezeYDrUVSYhQI1d9SebGj2wGSZTXugeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiaGS5p6gX473+7d4PjdYMHcO01BTe5fVRJ55dO4roU=;
 b=jah6JpHG3j3s0vt+NbMyJW4X1ATUAxTXoU7nPy4QHIk+h5x8mUfLYJ0h24FiKzaPwGZCIYPE76M0HnTdi/UtU+4fjFEaVG/RWM+tYwkX/k0d3yxMHoW7Geqclk5FqC5fPJD00gxYbB7qjIE+5KiP43SojQWLyarEKUg45kqjXLU=
Received: from CH2PR14CA0051.namprd14.prod.outlook.com (2603:10b6:610:56::31)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.8; Thu, 29 Oct 2026 00:42:07 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::97) by CH2PR14CA0051.outlook.office365.com
 (2603:10b6:610:56::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 00:42:07 +0000
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
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 00:42:07 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 19:42:04 -0500
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
Subject: [PATCH 1/2] drm/edid: Parse HDMI 2.2 FRL rates from the SCDS
Date: Wed, 28 Oct 2026 20:44:56 -0400
Message-ID: <20261029004457.40545-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029004457.40545-1-jerry.zuo@amd.com>
References: <20261029004457.40545-1-jerry.zuo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: da53f398-8daa-4a84-91b4-08df355575f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|22082099003|56012099006|261021121427099003|10067099003|11063799006|261009221227099003|261009223027099003|261009221727099003|261009223327099003|261009220027099003;
X-Microsoft-Antispam-Message-Info: JvQbXD48OuigLfXKNJ8hz0fLVZPC1EtkPcs5EqDuh4bHm1T1/pp6H+eMgNfUY4uTA+bc7Wth3oKRFGB4xKW0yWRS94nxxBiNgdAO6J1+7oRxUENGPOVDzmLTpTn1WIipxkia4xjMHZDn2vmOKHtvKZv8ttb/pPeM//8cdIbcBEaBTJ6Vt2Vs5sC9CIDsybPPwN3ZR/7vDyutJFGKAVPqdprqjyVKMq0TiQtVx5gkNFGDdtTqJdD54vjv1YWJCmPhAXZ93RLf7oynV7xtO/yM6NrQ+OImTsqEy1t8U5lJFiniMCmN9RrG9nwgvtz7fsN9IXGKIEGICKO9vGb8wamT0niz6EOOVet/CkRIVR1VLw/XZL7kNjZ+E9v+ibojgNFgT7ph3cI96bCp9Qvc9+9yrlsWXayTEvHor2vTQZ5mRGVD5UD8WcizmTZlougpQQy+9RbRiZPL1izMOa/DTG/j6Tr9nT4Nrhx2oIwE6jgQCiQ5B6xY80XZ8gTt0NEy0qkrZKvQSBRdOloiabbRdy4JEyYTfzVm04rnD7wtcawTyTC/7ETvzKXgbfB6E7rRLUkA4n6rI1PBEuREDk4TaRz33+cnoR+x5kPbqhRH4Ok9wJAVJfDiht9Ih+BJACX7yXmB6oJm6Zh2YWkCxGz41PpereX7AtHW0XoYjBJM8Q2NSJf6nRiMLhfrmJTGoISuYV/q7IaxiZ4a+WG4v9FxoBfo4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(261021121427099003)(10067099003)(11063799006)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009220027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lzErkkhUXBfAOF9FJGydIkDCMSeW/IuhOqFS5Mmw2XMZsvaslR9F9wWPn4r8dTM4+NAOsX9ri5fRuRmfZNe862u8JJGZ2JvjjWAKEPhqi3Nr68ApH04LMq4VsBvyOoLAfGzkTY6j6nTL8/dOv30NDOBAsMD4bf/yq/EHDLuuocWthv1LATZHJpPOa/QCtzk16ho3ZQd/C2XkIB6xsNYNk5XXee7KtmjHtJrhmLl6k/u0d4m9ob3Gosy/ARO+maEHuVcGeN7ZIAqsRYbo6zoSjgOQzHjKSkAZGd31Jh8HFPxT5s2JzpctLVmBZ3ubeOk4lxtQ5rVtSlQzLkFyCWV6kH4aq+RbWPBHO0w1iQ5vw/BTeuA56XT9auNZD2hoF3LRW2oS6bALKQEBCyX4pFRNThq1cZDuiQjDUN7/62ZcCj4OhBgo1qHP3kZ31u41gQ1h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 00:42:07.7045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da53f398-8daa-4a84-91b4-08df355575f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
drm_get_max_frl_rate() only decodes Max_FRL_Rate values 1-6, so a sink
advertising an HDMI 2.2 rate (7, 8 or 9) falls into the default case and
is reported as having no FRL support at all.

[How]
Decode the HDMI 2.2 Max_FRL_Rate values 7, 8 and 9 as 16, 20 and 24 Gbps
per lane over 4 lanes.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/drm_edid.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 42f4e41c459f..48d5c4bd4812 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6193,6 +6193,18 @@ void drm_get_max_frl_rate(int max_frl_rate, u8 *max_lanes, u8 *max_rate_per_lane
 		*max_lanes = 4;
 		*max_rate_per_lane = 12;
 		break;
+	case 7:
+		*max_lanes = 4;
+		*max_rate_per_lane = 16;
+		break;
+	case 8:
+		*max_lanes = 4;
+		*max_rate_per_lane = 20;
+		break;
+	case 9:
+		*max_lanes = 4;
+		*max_rate_per_lane = 24;
+		break;
 	case 0:
 	default:
 		*max_lanes = 0;
-- 
2.53.0

