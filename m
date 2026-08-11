Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DEEC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 00:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16F810E1D4;
	Tue, 11 Aug 2026 00:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dSM/0ujh";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA3410E1D4;
 Tue, 11 Aug 2026 00:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7Mz0Z69l2rXYo5UoE8huLqcAK3uxdvcKWkVkCiOVnQa3M2KGg7iXSLE3c5ODdBXS8nvbkJ+FcSUcA7M2PNazc5O5FpBJFyESCsV7+ffvoGADPpHNqu/KlCQNx3EXT5nyp/ru42xDVoTHtG0Eh9mcOTMG/bC7QoNg1s4Z+RAZPHjlT4oayLNtmY2S+AHNJjfROlqBSP0dnnMwY41WSXX6vwDOE1/rHhP0rFDFmm1eDntppgsyESyyxSu9TPNEA9CWUjhGPR4VLOAqKFdQT8q4SNS+ASuEONDk5EknP1GB3r7smIHccCcieLVYOM8Z+3KzDcA5/ZCuLQeISCkZxujnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv3BnUX6LAV0n4YPzgn+u6IfAE9FF/w4e6zfEvFJ6pM=;
 b=up0dO8ukrIjZXSYkqy/s4YVtzpxy7ekKoRboX98L5S01hJECyhveHvIbjwg1+uzxtdNigbrDxp6Bbzb03/5p16yjdpv/dBMvY5h98J18v6Jp/YKCfLMO85DUTthzVS1ok/yP/BwZv6oHLFGYSwmpPKit8mYwC2XhXpFH95q7PmSfMOE8TDOKKDl7lF34itp4k+JL8OSPkoEFOf4N7BEIzc4LAZ2LG9SZ4oVD9FIlTmGl/doULKG6wdr1/7MsG2HsrQbN537QgvwQOnCwe5tm3e4phCok/0+BMQKXEsQafvEMAJWJCyu4oN7edoyeDxdv0IQUBQ9eCjDSrs6G+gI2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv3BnUX6LAV0n4YPzgn+u6IfAE9FF/w4e6zfEvFJ6pM=;
 b=dSM/0ujhViThJ3E+WYmGD/eUOV8tQT6ex2NSQvU7QWPLpkiaYO084zmI2dihBt5EtzL4PeSdFOc+IKyNRfWdlJRaO1BHndNIja/Vp9XBnGO/39RvpN+o1gYO++sSpANOiITbJT8bE3Qrii4IKLYHuvGmccOZDZ0rr1tBqH+223Q=
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:38:42 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::36) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 00:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 00:38:41 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 19:38:41 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Harry Wentland
 <harry.wentland@amd.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>, Fangzhi Zuo <jerry.zuo@amd.com>
Subject: [PATCH v3 0/4] HDMI 2.1 VRR and ALLM support
Date: Mon, 10 Aug 2026 20:39:17 -0400
Message-ID: <20260811003921.1398292-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806205449.16806-1-jerry.zuo@amd.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 11def932-d44a-414a-8e84-08def740e488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: rpc6EYNIVtm6dOn+vVwLSdonSAIFo/+/NG9Jh+NyyAtSUlAvGFhUgwok1MogFBVOkWieLOjA/mxujm1S1dWh4ONfaEF8kYkjb2PB15tWgDWkXuXNeNBs99vynRfEiLKNwYSkGkIJKOla+pEDn4RTF4yXT+KOmSDNmG6duNVVgYklfjT/jW3i4/4EyeYke3hm5AsDK7K3T6T4RkeagZcepE51mAqExKY1xJw48bYNKUHV3HINclt1LBRnS3Tw7ti2xrZDnYeQY+/H9YbQ0pCxiTd3R+EAlQVKC2LmJ29HrefVLstuMPB9Cd6sU/4kct0VM/lttrpnBO1mG+AayyDfMGAN6JZ4d6eXS++vGdQWwogsjSa0w6Wb38owLEk3dSQWJT5KQetaUeqIUGzs2NlzGl9O+O5wPUOAKZgI7K6bgEnOfmVoOywsZKuxQ9YdDS1MIWXaxFWFejZqnlYPQwHG69MfGsgAdqrGbk8wS66UjRMZ+zVmSdP9aOtJEw8edFfrABGmzNhJ0ELvmtAtXBSKYBj4yafqRNHFbzwwyjlT13993b5nXj0PQAn1H5MDw7wSq0Gx830rch0RuzfbZ43AorttcXLMRzpLYo+5fWIEGV4pD1e2fopO0sizT+fybe52qxqaaufxLb7NstvgaWhmd12LecYQnoOYgoNbIEdWB7Fal7xiVGIab2y0t/FLfOkAh8PhLdt2UP1EYOMgRmfHRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7gn2QMYGwSFHoU/lGqNhv8/KukT79kFfY8O8qECwjhzZDYjktXEQzKvv6DjfLkpZk7pzccRGweBF88wfxcbRCUth3HM3wz0KQ2Zgv23vCdHm8bmpdAeAMltTKhby+n+hIwlMpzNCSVO5XuS2xU9VIgfd+arjq+Kh9L0V5m4q7riki2mccU6YVpo50F7AI6AxlFSfsD4wyzPQVFKn65DIN3NTNW1yPMTJLJ83LDb31nQNlvIAC0AndP2C0eNX7aELpwAx+bV84Ub0E7kqz3vNflFRgYsy8cEH55JzguExMiCNz8/++R3iaIifwvzZFWqERRMDS8Rf/uEwvg3PHCSTmPPDBjU6gDpiJscWjR9ZCpK9l5jSqIEsyFfZBf3NHZfXMKs91UErQIH24vdvFhX9kfLGCpsISWdwu/7q0oMY6xPKu6s0Q7EQfho4cJMeARf3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 00:38:41.6564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11def932-d44a-414a-8e84-08def740e488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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

This series adds HDMI 2.1 gaming support to amdgpu: Variable Refresh Rate
(VRR) derived from the HDMI Forum VSDB (HF-VSDB), and Auto Low-Latency
Mode (ALLM). It builds on a drm/edid patch that parses the HF-VSDB gaming
capabilities into struct drm_hdmi_info.

  - Patch 1 reports FreeSync from the AMD VSDB (existing mechanism).
  - Patch 2 (drm/edid) parses the HF-VSDB VRR range and ALLM bit.
  - Patch 3 enables VRR from the HF-VSDB when the AMD VSDB has no range.
  - Patch 4 signals ALLM_Mode in the HF-VSIF for Game content / active VRR.

v1: https://lore.kernel.org/amd-gfx/20260730171754.704049-1-jerry.zuo@amd.com/
v2: https://lore.kernel.org/amd-gfx/20260806205449.16806-1-jerry.zuo@amd.com/

Changes since v2:
  - Fix coding-style issues in the VTEM info-packet code.

Fangzhi Zuo (3):
  drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block
  drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
  drm/amd/display: Add HDMI ALLM support

Tomasz Pakuła (1):
  drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  89 +++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  43 +++++++
 .../amd/display/modules/inc/mod_info_packet.h |   4 +
 .../display/modules/info_packet/info_packet.c | 109 ++++++++++++++++++
 drivers/gpu/drm/drm_edid.c                    |  42 +++++++
 include/drm/drm_connector.h                   |  47 ++++++++
 7 files changed, 335 insertions(+), 4 deletions(-)


base-commit: de2622bbc20276eaaaafa8fdbd374ace1ced28dc
-- 
2.53.0

