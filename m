Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF06C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0686710E7D9;
	Wed, 23 Sep 2026 04:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZqhvPnDo";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1826510E06A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 04:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk/rSNYMc7gVxLbrSfGLrgEhDwVko8weFGvSqGt+B5D4bmJMIUIX9mvZeKg1BoLe3MIBLkR2qi0V6HU5Mjy5ENzsWihIjx74LpCz5+IyK9PpSPsjAqq2ykctqodSIR/PBfss/0HGk6a7CU312Cq8+2uOkzoaLcAwtAFRBk6DqP6lVHBDZg/UCJpcRZD42HOlpUaRMImVUWbiP7vwKtDp+NHFvfOaOm/+Xzz+V03RT16YIc/sWd9nXf7ByXUWSuJYOQzZ+1lY9t5UhiUZ2OncNnHP2IlqQ03ErZWu+H5YI3GenYAsOcx/piM705QbxGHquEfmdD42tMqehCbuBNFKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU+uVd+227+xF4/+8dn+gEr+uR9xnAqyc332ULoR3ro=;
 b=TE3znwThTYi/u/RQotSg6fGXeop1Pk8pPEuXDsz1uJKbrg1iLLwc3w8lg1/Y0zXEWPZG8iADCQ8eQlnbovQuAwQTbF+7lte2Vmpwyl9aDpJ6ABGvWHogDbhxiaDvm+ov88LRTgG8BvEZapKVvDgcnx6LXmOZm/AtAAzl9pyNqJbQFLLtvc1HxnGGhfW8bPgk0uEs6EUlTI5IvPgULeIZ1AJpY2Wh5xNE01mKC818Pd0n2+PM4N71x/BWL/KRKJ92Z/Qy9NVQWZD9+e10fQF7LhOQSMURIB+4DMCc9fmavU911uO/NcnPP8+m7iifYr5ksPNqq+Z/RK8Snbui7RNIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU+uVd+227+xF4/+8dn+gEr+uR9xnAqyc332ULoR3ro=;
 b=ZqhvPnDohIARTcg0a3lurG/klqWgGMUEwegGiHOX252Bb15qPIdYaiNIFlljNykAde5MDVQR52BnWpXX+cPp/Ir0nL+XFHT9tPx6s2tKna7e6cnDp6E9d5A4bnZAqAQVBTTdzcIzyqs3FSoR5w6QUm7cqvobF5XPLHx1nweP1uU=
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.20; Wed, 23 Sep
 2026 04:50:27 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::37) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 23
 Sep 2026 04:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 04:50:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 23:50:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 23:50:25 -0500
Received: from james-PlumDAP-MDS1.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Tue, 22 Sep 2026 23:50:22 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH] drm/atomic-helper: Skip redundant disabled plane commits
Date: Mon, 21 Sep 2026 22:30:11 +0800
Message-ID: <20260921143049.46985-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8f30e7-5c4f-4ec6-edbb-08df192e2f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: WQWMnaXPH0qusHsKNnqKOYsQOJx7fahN/JQC721whyItj5ccnJl9YeQlcX8m+pXw389BAha7EGa93ztjs8XLU5Hq31JB/ygr/9pqShhrHcbVh7I18j790rpawHpC1+Tr7usdQvrss1fElu4cbTpjPBXKYUlxDvAAnmyyrBBP8qGxQ1ugp7JqoOFATChJP12VpCwc8wIky7GUdyKqLzxQCTO827vtWlnjatEoJg4etNErlhaGl4sfCaofrJWEEgQjxW1PgbhNR8Y9DViKB6ITOZC3LUCXorEUjiiuRajbyoblI2GdRefvSGX7otS+BDtKns48ZUWdCyyBmDOtmfKSdtcd6m7n/TTqNnbLW5k2Ya4/iKWYemfUr0Mmk6lE7jo7tUzV8ND7+2iNKTbaQggn9/S+0+EhJIyyetRQL2pAsQulLBg2HvxCceLBXiLlfBYngbZvH4nv7/1bysDY5+/icGm/w7pLs+W58MWgaRlPjoBggzL4mu+Y0/LsiMTdT97zGabQglra6vU02J9WeMsDjuJAVND3YkN3BDpme2lgY/uwEbXOKafPvGlo99ebil9ZZ1Dqmjdd3xrgxPbwwlc5V9xFK7plvJC9P+pziPo7iKVf6jVlqiBlSn2l7IAAqoB3E0dritm00ure62uHJ6dcajuQ8h+S1TSMMJSzq8VkUyPsIchXujuDYuAv5jkIn34vCYjlWbmQYTb08r4B5GdavA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZTOJylakARjW8f9nbVnCruXPMrsNfB7tl2HBnQCP+ORa9O78VF7aX6Ps6Rm6Oq9VsdvIxXTgXwKMTDhJtoTiUh8LOgCscVVtOJyhE6zQHxxVFBOXCphOiZEWwNevSwnoumSPZBW24fdBf7o2XPb7U9PMpYsfFGiyxw8dzyrYPWVbe0qSwV0Fzi10Zpbi/gqaLWTEZimRRFvoWqZbev3MsQNNKtQYMq/7uh2ccAZEWgIQ4GhWpicPFzj9B56Np1WlR4+Kh5fUfj+ggTnivCyitYMG3BNAbQOuFbAkYiQOldxwXARnsPmdk/0CaO789qzzaIBfCEjlzuZqsqrEhmReCe7kd8HjQzJeHia04sNeUbAOSkUkyk4O2XYsQrf2dInhSI4FFDneIGPgDf3X5ArYXi7YyRk4mxFqFq8FnS9dMg9tyMfcWoYxqziEQcS5M9Wj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 04:50:26.7127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8f30e7-5c4f-4ec6-edbb-08df192e2f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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

Return early when the plane has neither a CRTC nor a
framebuffer to avoid redundant disabled plane commits.

Signed-off-by: James Lin <PingLei.Lin@amd.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 51f39edc31ed..30cc9c07f455 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3470,6 +3470,11 @@ int drm_atomic_helper_disable_plane(struct drm_plane *plane,
 		goto fail;
 	}
 
+	if (!plane_state->crtc && !plane_state->fb) {
+		ret = 0;
+		goto fail;
+	}
+
 	if (plane_state->crtc && plane_state->crtc->cursor == plane)
 		plane_state->state->legacy_cursor_update = true;
 
-- 
2.43.0

