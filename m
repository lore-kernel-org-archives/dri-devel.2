Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8521F1061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC54910E69A;
	Mon, 30 Mar 2026 15:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e9hGjifE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DC910E65B;
 Mon, 30 Mar 2026 15:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9XK5p4x6GpbJeA2pJa6SAvNNsxMMr4aJqJRqUuiRwzGAAwcTtJhEfIrTqkaCOHHigFyD9OU+fMr8usso22w+PjQXFcU5ACYirWqb37431lzg1s9zUCDbB3WH3G0ScXrd3RZMWY2ATjHngCxkrBn9jltw6hse3JuaK4RScAfXsBBpNcHVXNkVIlyzJOBeAQsGVrcQxf4P8bOrn9I9hlke6MOmEg0/nOifk41l5h0rDz/AaHbng/Tpvx9pTjwvITZKcrpS0hqIY//wtHdXg3CO8D4JCU/Z3lyZyPcChOe8pzNmnbsULmajtY0dLDQlYaMOFBjGTz6ugNzBoooPYijoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW3zyhOwr6G+mVkNqOwwblwXRYtaQ/kU1TpkpcXu4do=;
 b=sG/2t9cCgKRyFapXVj2Qlc/EkBwSSBTgK/9QpkeBc7+pQewH9T6/fcmGvP2lEWL66h+g6ARn6I2WtQ57XQG8Ib6YWwHKi+N0MDnAuNTpngHrg19otbUVcQV10Mqlf5TIkMw1VsdqkUENnteNXEE8uhloz9RGnIyieBNOh+JXBg8ikfwQyC8FHuF1449sGrZdGgWl0wnrigltT4SDi0rDKPsIcE7hf6k4jRn9OUn5E+coPyl5yHI9qyxVpnW0nIMHzBKd24WD7gj57LqlDEwNFFuvo/m8wzc6EwJ+MJmH/ZKrFV37E2wpoFAz0vWmwK46yt9wKytpdqOEsinM6ZX0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW3zyhOwr6G+mVkNqOwwblwXRYtaQ/kU1TpkpcXu4do=;
 b=e9hGjifE1FxHOW2I2Nc2Kfkt/qG144kdsGT9yJlGZ730SqC0TpEXT9/ye3twe/uf0XXkDL/6L1La5DRDQKDG6LTzZ8tjXcwQzsW58dAGP/jNX/PJiOHoTpVC6vmq/QJBR+zDRU8YMk3qMPpU9nD8CmQJM1rwNlGv/38wxSUgxno=
Received: from SJ0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:a03:33e::19)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:35:10 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::85) by SJ0PR03CA0044.outlook.office365.com
 (2603:10b6:a03:33e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:35:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:35:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 08:35:01 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:35:00 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v2 9/9] drm/amd/display: Set color_space to plane_infos
Date: Mon, 30 Mar 2026 11:34:51 -0400
Message-ID: <20260330153451.99472-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
References: <20260330153451.99472-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7671893d-aaad-4e6b-155e-08de8e71edad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: fl64c2qXgAddZGEKAYKW801Ts8W880MKAL4dPEg0piGtn6u0gcCk2W4Ba/7+MUD5/THPMW/6mXqMOsYS0tdPND6Mq/bsuEpWZmpOhqo398b1eFXuMlgLJUaPeE2vEIDfWvHiHvQJCoMYPmtTzXdcGDImhOwsL6gCJvh2Rhv90jJZmSLQOG28xRKzN86ZJRcj4r6QykAYfctLoxeodOPBMPqjxkoq4dluNNFbQiM2+pLzXWWd7EEQ9GsC7pzBzDz+4kGPYEcTwe6YOhLCkT2Hl7K0RAy1F5ATGsMOjWsilzwxn4g24ZuhIQavTP+CK2Fxhph/Lv5fLh/JgBSLy+ikP7mLuHwH3Ce9Zupgho4adjEJ9kuOIwldDXBhArnU9h2zltKxQKfMe/hmaAagFdaGL2isAL8fBi0qwNzr2rv1z8pDzuT6j3St0NKMatqXieQ2BLuHI6Csrnd8/cYqRpM59exQNEwE3cMynxYpwPoqinQ8UGBbAogPNHvpoXqqYVwjGlucpNd3zswTXepkjzHE08EHr97cfpPknSxOaJZKcN6SjrzeZX9hE2SWviNBC3/fj/831GN+w51lzyYQoppJq+E+qsKNhdDuB8gCFNqSeFJrOYwz5Ong+1FBlKknJGH5qA4LFhgsX84MezcFLfK+oyZTXH7lCU/j4f4jZ5t9L7wI9HtNqrnrxb8/eiZpv+Sr1PT17dBvy15CBc5DDFeMdXYYKe95Pn+eAfsPwfJPWnM5+yI+DQMsBxpof9OZl/XuparzzZDxUU/DhrEXAqAifw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HUWn2CR4hlvEfCp0Njb9F30vuNy7Co/7YCkxgYVkwOD4aMuBwh+SMgPacwkp1TUZXkGJX/62ZLXEjhmTebokKl6J2jJ6ovhR+1+F9747U5Bp1B1GKRBn9qqHvtlDZu7zNegGhXkexmQoG52HAf0RP70Od4xLzemwusA+CY2aRsY42LRKSue0c68jGI/YXMJd4c6jrf9n17KUu5gq+/cym2Al9nfaUif9Cl/9pDqOHaAUAAD87UCf6aZgW0K17c5r4VfdAF5UbawPoM0gOpB8A2fdYwpgKEwpyqQal1wVRyZKzN9W8IbSG1W/zwdRG4DeP6HwIWICMviCsKmaFPF5b6CU4UwbJUuaSUiKup2ut4kbkyruzj5pcio37s7u4EPCGAaXbJt+WSjnNQlLnUzhWysTNIpLVtQTsCKfq3U3QT80/HTJ6zOtBSjkQbW+o6B7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:35:10.2074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7671893d-aaad-4e6b-155e-08de8e71edad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

DC looks at plane_info structs.

For legacy drm_plane COLOR_ENCODING and COLOR_RANGE this was
done in fill_dc_plane_info_and_addr's call to
fill_plane_color_attributes.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c3c6211d15cd..43bed6b37e35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9992,6 +9992,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
 
+		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
+
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
-- 
2.53.0

