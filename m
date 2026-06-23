Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0E0CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9B010EC19;
	Tue, 23 Jun 2026 16:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w/YP/Oqy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E1410EC0E;
 Tue, 23 Jun 2026 16:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elrxe5lxGVQASLtHIYfK64cRtTqU0GHLT93FLg5TvLis7K459Qf0zYhlEUYCMDI78X1KE68tIXY9It/8o3apkg3//0wahCzyjaOptGsmF6bivpFAWeCc8bpzz3BYnvyQTORDor5lz6Sp9kn2vmNOmI7nIaN2+5zDEPG7PfSvLbtqu6WPXVjcCof5VPkSM1hBftpKVNZAzEbHXMobOZU1zawBQWsjZaiNe19NI9RIohEsEv9dIyYS22fr1qxhaRzZzeh/Vz5DJEAnwX1vYtcPp7rSRL4Mw59o30uZT/YMv5aHSuVtDAuekWZ/4r7ETWHAydDKGD8sUE/kki1NQwO+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVS0nHS2m5ZMlJacanwPbSxRAG3vONxGy/ldf6VJiZE=;
 b=tPo5sg0lIYIlfK5vM7h2WyOhHj33GBWZRQmOsynAuslq9KGNPFWLdwYAIxtWVkxvPL7GhjWPH44RM1K3vE5nLZlDuRsSp3acG6gkSUEfd3UZpmMXGvwoq5fuoszMlNTpiIHzPb9+lD+zgDo2vaYrurT92VdJepbU2Sf3m5cF6DcgPOmHJ+1YlIV+cMlMeNDB/8a+r07fHnkOfjQqMav7xdpdVBudF8J3cSeRbqU33dvzSc1FArO3R3d0M6e5WBNenCGSAeuz/gRZw/r/2vkXGkV49FiKcR/HWF4VnAmLrtrpUae6MIggurQ6YvwknYMXONKPGHZhZpGJDZ97hTaYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVS0nHS2m5ZMlJacanwPbSxRAG3vONxGy/ldf6VJiZE=;
 b=w/YP/Oqyjv99lnPEexK58jS2nea5eKvSYhcP+S4Qpk9dzsDZZG7v8UGzMsmEb5g+7r5DAOs7gNqsuyA8JK7Qj6MQm650fCMRnbuFmztBVBQ1rYtV9GPAO68dI/yBszHK/ZQzIIgE7QtIIFxmGDSa4pJTxGvGgGfSSU9xXvlUPuI=
Received: from BY3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:39b::15)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 16:48:27 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::4c) by BY3PR05CA0040.outlook.office365.com
 (2603:10b6:a03:39b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 16:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:22 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:21 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v3 09/11] drm/amd/display: Set color_space to plane_infos
Date: Tue, 23 Jun 2026 12:48:10 -0400
Message-ID: <20260623164812.81110-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de356ea-2208-4ae6-962f-08ded1473fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fQ5C45zcGNpXjXoOxZW5VpiFGRdYtIrfKpvf+ZCye24GzIYWqnWGUC33wWRWt6qvByleB5MVLa2RBPnBqjwIh/kU35Flf3xKbCiTujeCW3haKr5weedAxjlzntDMVgMbFYNrV+TAMoP3BaJ54/9dkpk+mVc8rer9HJ85BubSWyH78XvCQsuz++/1wVb3qPKVSLffO/frrBg3GVhSRP1+GAJVgB+5aIU14J3p+lPipjLD7CDfYzAv5rs3wYO4TPG63ryUyqFbL4c6nFNqnLZHIQit7dWHihK2q5fkRJvPlT5cXZfa+lPrJGoK8+7jvRZ846wrRuM7pdOe6LDuprciO5qkuMXPctwsAq5CQNQqENxR+lz8iL8Gjx+1Wi3Au+DhrWX7rPjsieWd7pS6/KzOV0DllBwZ78cBaFI7udsyW3R3Mkc7GkMHl39XwJ12mwfr8RXPG+Kf8O/k5aiJl5wrkURZ/Wp5eOghJf5dK8m4+9wEtH7WHnl2OaOUjNvRELMeF7hgodUMYod0cQjeN6afI44g+IxmzNdzVnvnCNTMCDSn2XqUI2DVm1qQf+jkr/TU5nrG4BinRwffL5N7Xs6YuGid0pxeDNkpf05C/A4jzRTD6DWcotreJE4jHCOKd/lS1homGmAhrdB1TpoOoVeCtmRZVbJaAvG7ewSUkf5tXcNoyDn9J3VVm4FfuhVE9Ws1YDF0FXzee6pfzTmqpYBHUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FqWf97wfKemytKVeF2BQ+Hoimx/+wYsdgivXR4y1bkaPbqVlMGquVhc67iNN5eGY1CL5uCutKp7xKg3P0imHovxFl1iVTC0VzI1FEveDu8xjoOOIjuX0g8/t8ZRyHV3ipQVUcYiQVwEv3fK2heKTb//rdyiFZgTvA1tg+HgznllYBKEf/xxG5aPyGfwGuOwu6swdfK4YsIPy0m+OilurygONJXSZ3eKR41xN4RrIN71e6iwhMr+QvtuAIa42uRoW4o46My9xNs0iAJHo1qvCF0jeE7ztvh2O0miDuYQDPYYcYOTpO10jjq4kJb13DMxGbLaz3rpwzoCT+ABl8MkXEDNEkAStANQThKIKNExwUqubpHAQ8xc+fl047SOuOYVHaBTp5eF5bpWr78N5C57afthwH3aCIrK/P5682IRKMpO0LapyYswKLTnv9JLcEyVH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:27.4502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de356ea-2208-4ae6-962f-08ded1473fc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6d0e3d699eb1..50d65f2f34e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10314,6 +10314,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
 
+		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
+
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
-- 
2.54.0

