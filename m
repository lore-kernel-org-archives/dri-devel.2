Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B53DCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 06:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C6210E36F;
	Thu, 14 May 2026 06:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hNfwnrf3";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800A710E364;
 Thu, 14 May 2026 06:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndR/tY6X5SiVcdRlWNSVeCSWp463m9igRYgmhYD51kf1bz1ijXH+oFTbJG91UP6cQ/wT3HXOPKesXFDvHavLD16mrZ0xgTPiNNxrf3Alh8RwUWvCRPUjpQlw19YJTGCipUh15qjI/BUcx1eLhBx8V4xPYxUf8HGQMjHuopt5VN1KWF5OE+J82huF9k0o8iE1gv2HGixQc5tCHt9eL7VU+z9NqsAxU5/SkDduD5O0MkXIKWHx0jjRnjDGdswoO3+IpieH4JYNOHiW4y6WJvPQ/FBOkW4AzMrTh/x5oG7YBaWanZPkWNPZN+1KeGSlcwE+BZBB8/3rULYJ2T3ll1UT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=623FrJwqbOUdmp3rUBc/uguV2xq2olppwu2jDgApUcI=;
 b=C72poHPLBN48xhUVWy34fn+RlbN1ml6PkeISS4a1Drr5yZcborwy6hv8rgfpH9UytRKq19gU/ljMlGiAuBxtIz51zykZgg0Xz5fO7NETJZo3y2qVfk35cL6WhWdnBHpELguFaD1ZtYSCvBzMDHGOW5xZPGizB1a8RhUIImIk2ubYe2dodsQiU/y2gkWuMb7yw47LUxtSu/h/sW7ZpgpUEsAecg90pdv+Pn21RXytNscqdvsXSVXOg9W2BCQxUtP7eeGbR6JV3gLAigrliAo+mSMqQ/y+HmBUpvoRDF132cTQnrXZidVqmuBJUf6urqTH1fUoiJqVl9Ck0Mi+wB4SIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=623FrJwqbOUdmp3rUBc/uguV2xq2olppwu2jDgApUcI=;
 b=hNfwnrf3EAnnoAr2Kx/P5ftylWEHqpO/MqTuXg272uTfqGh3/Ox9Lb1KQCXMhlfdl0Ke3CBpASpdOLa2cf+InAMQhhZDmUcYhqBfmFD4X25qyg8s4qnJ5uMd+IPw+MwbLcoLltXO8H20KPUwaNGIi8rmEC4+dw3BY8hw7JJzdc8=
Received: from BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 06:56:13 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::7f) by BLAPR03CA0107.outlook.office365.com
 (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 06:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 06:56:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 01:56:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 01:56:11 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 01:56:09 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Ray
 Wu" <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 0/2] drm: detect panel type from DisplayID 2.x
Date: Thu, 14 May 2026 14:54:19 +0800
Message-ID: <20260514065606.1151834-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a97f4ea-32ab-4c2d-1575-08deb185e28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: i/IzrInhN52uGopiAG7dK66s5uKW9h6y9MfMq458MsAkZywxtdMALw6l7N2YHQ3TRERfzHH878b53nZLzP+wv/eEZTSCX/z0SHsan4xKJceotrwyk0rE4sNgOxmUI5wz2uj4p1XvEZOu+xgg5+LU1GJZuZqe++RVPkgTrPx3uKfiJtAWgrik8GG1ZrNGrjqkmIE8Aqq51TEoQIbOiQMc/vEo3Ic5Ce9RfmJK0+iCV2JOHaCLwM6pYjjjacvSEodi0o8cjA2nnkarlIVCjpK04XvKDzGDAUGDVPNoZdruf9Nzcj/aFdbU+9jqyfd5pFUTw/xz3j+D6cBYAE+CYvvvhVDxzphvyoVcDtSbsqPqWLMsRisFDEV5evQ6wBGDDYl/2tiseT6N0XM3Oour9NPoUjkVENKMXFMM3GBFW9feT4SJ15Uw/Fy4g3JZ8Xmq28Yv9T2sWpuaU/KQ/dzhmQtMjQ1laRBbeHnop1fJsbUaPyCSAH590cwsAWKftb/aZg9jseYI31ovrrZvW9P0l8Q/2UpZZRUZ6E96c1JeqWpnx7X2jmIfsaXUzo/N4/MKpZwZiECRe0b/lvXZ1PqndHbCAg8fTFDk3V9QIzs9QCQie+KTdWu5/cdCZTKHtyk6M66vPiAIJeruzJsVg0lbVH+ow4rDZ8Sbqatf5tLacMILK6eQWLQrei1jPUw3Jkpmj4+zRsnqWlVxpkHliBYZjkcOVbiXCQjYFx/oSGOpSrLspE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vpNhWdu+rzug01fDwzLERViRAfA9+PHz/uHPqE6jGp35PrMHLljMEuMTMYOxxcawlvkfAj1ZcUiltkmOVxVMNDz0Bv6aDUOFq8XglL/JYUmFxw4nSHJRDjwUtkrefqe2v/ElIHZmhlpTWH8GndlRWTx2H21wWDtg+lhA7JgEFZpEtXUtNkxny6GnEIoXVxdwDbnYwSXoO7Oorb04Xsu9mgFOmTHZd+DQ1V3ovNwym7GcTYz6ht0M7VGHw6wM7QwhJbvDKMQRc0xx9kavpekTKplyhfNFA0FFNSfX/A2a6IoC+qehhdcgmwCNVYo2/wnonMkuGLbAliVquseJ4g87eX45bNh2Lj4Cs84K2vl3i1zLvko+j7PinkyxTwDHOhaCyhQ6vSuZKHabFAcyi/IcdSURFQkGqvXL2pRzRZJz1GYMNk8kJFqH/r9jL9AOZ/Vt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 06:56:12.2420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a97f4ea-32ab-4c2d-1575-08deb185e28d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Parse the Display Device Technology field from the DisplayID v2.x
Display Parameters Data Block to identify LCD and OLED panels, and
wire it into amdgpu_dm as a fallback for panel type detection.

Chenyu Chen (2):
  drm/edid: parse panel type from DisplayID 2.x Display Parameters block
  drm/amd/display: use DisplayID panel type in dm_set_panel_type

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++--
 drivers/gpu/drm/drm_displayid_internal.h      | 25 ++++++++
 drivers/gpu/drm/drm_edid.c                    | 61 +++++++++++++++----
 include/drm/drm_connector.h                   |  6 ++
 include/uapi/drm/drm_mode.h                   |  1 +
 5 files changed, 89 insertions(+), 16 deletions(-)

-- 
2.43.0

