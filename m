Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599B2C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 22:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A757510F747;
	Thu,  9 Jul 2026 22:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UhXB8pRW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30AD10E2C8;
 Thu,  9 Jul 2026 22:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnLcZE7MgVGHHKcj2jq1L6paBmSPZadro+3cZE4IENrS+A9DOnnyDwcVIAkdLttCgLtAoIsPQfR0uRXxFRb8RWpQf1qJfOsb9eHVkZVA6oZcP/v3EmUCigJX8C+i0mslAUN6gYUywyF0A+L4o3T7QeDeHqJgp9aE1/piYz6PvA6YOoT7F/7nl1/6RXsbn+MHZkg2TDnEYFieuxG+EASXZPGehLw+YQ05iciC8oL7V8D64VICaMQ9+ccVhvyB0ZnE+oYYAn/QJZBnS3juVk0SKj2Zj+nlcdKvNMMIdkoRkZ7Au7MpN9Y+HdGgoBL00wIJfATbnrR91VsoUOTdezlO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8MnH1sR+80VJ2GStpk2oiFtiZEpM4fp8m2PvW+e9gQ=;
 b=PLv8QJ7wozAz8fn+EuQQmU4UOLJlhMWVoWEVhh959JPE/IRPfzNWq9PZHFWDJjarfRly2jyjaPdAPXpS5doOgkUgWKNqty2HifMDHejZP681+1L/oKInTiVwAYOemEOl26Qwh+lTA8rIlhCGX6FkYkvTca7SZonMY1sepG+vEclzfPuo5YP3TQFNnFIxwthSpWZWWzmyDmQEUBaPpwG6nnjptfMTk2YXeo17rEIQsd6RtajyNn10rpZ5gAaapdDByjLdND/X+KNrLFI3nBzG0xZt8bH7HSzjhPAZu0u3/0/4tUIF7j1e2nZ14QhKV7PJ1aYeVJzgnfeNkh/QxNdMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8MnH1sR+80VJ2GStpk2oiFtiZEpM4fp8m2PvW+e9gQ=;
 b=UhXB8pRW5EMCfNNIlvO48WUOiF6CQLwtoLw05pyS5mg5LCofqRuLrSPDYNETFxQTN2mCu7+QWEO5C+5fgLNKB12jkJM2AZ7KEPfNJgAWmtD5nT8u3Kd6u2BaA463I1vEssZX3Vx8C6X+/SumtGE+r/m7maz5MfnYNdm0BIuLZwY=
Received: from BN9PR03CA0629.namprd03.prod.outlook.com (2603:10b6:408:106::34)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 22:43:08 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::5b) by BN9PR03CA0629.outlook.office365.com
 (2603:10b6:408:106::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 22:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 22:43:08 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 17:43:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <YiPeng.Chai@amd.com>, <Hawking.Zhang@amd.com>, <yunru.pan@amd.com>,
 <lijo.lazar@amd.com>, <chongli2@amd.com>, <xiang.liu@amd.com>,
 <harry.wentland@amd.com>, <alex.hung@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] drm/amdgpu: Pack nested ucode_info struct
Date: Thu, 9 Jul 2026 16:33:12 -0600
Message-ID: <20260709223312.475563-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709223312.475563-1-alex.hung@amd.com>
References: <20260709223312.475563-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da82ce3-2f1b-4213-52be-08dede0b728a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|921020|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: BSKA9lxsptc5eDCm11dPkeIr1mtogpPBLsADspA1o34Eb9hjsbmc/m+MLzi71c0MJLsrd14T7D2ufdPmM/wqWYf15XVyO4eTMF8TlEUVnCa0BzhcdyeBQ8OAMgu89HvIjRUsTEmmAj+L83NR5kC4mC9viO+lGzFWosrMRwGRkvimbETu1h76Fyp/IYYv7co8vB100HUSkTzdjN4pNEMbuUbDsyK6hJicioUvdyPK1gzrVJR836svPb1/2vu9C73YVNv6pj4HHBKA9yd0ceNb138U23eindrph4FADXE+UJGatCYFfhdaHMCLe97lhUevOLJGiTWnvYF3gVZ+NGM3XUkIaefwAbe/cX+hEp2RMxX3hl9ZocDy0AoQO+WObU9vRC6OHtnwKEKBBsLHU6z86oHLMIiDvxm/fHi9HiLM6PHYEJVux956T34TyM4MqnFh1NvKCgfnHz9+Ugbv2qsKjVBSlCA84zK8x9ngjVg7oqxhY06wbRXkxTgpVSS7qJc/5UWccjcwuyfPLJINn9L7uqn6iH552KoxmJdDMonvAe/rkhjFqWQTGvDHcV6LLYPQSZAleJXaYkpsPZe94aRN+v4N0JvDJGdUqUhEEgsWyxrFyhtalITBM7cPLhAZhn+F8Ua9N5uaVHYPQymlwd3iqddWJMr0uV7GDVgqJGp4qegvL8vGJdywo/oPcH2pFXr82mXUIHHsMY5mLIuZ2/xUbVHCDj/cjare5dMztTMGfjXh50vF2Eppf+ntC598haoa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EM/Hqi/bDZ34uXlBymU0q2Hf4dq7LXPJ2oa+mbuZgmvk8/YTNZ9glBNuN6490QBv1rJajwqaTi1yf2PHlLCge+fAr45tljyyzoPnK/pmL6IJTjdGb7s6gBiL8RwyoKaG7XNejTKOcdsSLP5OYOj/S9vE1Owr1m8pBfKKgnI/+ZHma3078dr147OO7rZ8FElSyrrtVfgJvqfjTGneYMiuKPMO6JdSUSqXQiLJ3DFU2pac5yjygXvQd1bg1vDE4USf94o4aIqd1y0OuKVHBt8M+8DiEIVCgk+lvC94TsbqpsLbEZPwjznSlgk9PITAG1TeAsQPCG9FwXXr3vZQTGoA5ubikFUnysfRJVsGJC0GAtRZchSDInYwirBOtt9/huxiJUJEt/7aFW97KUizLQ2nvv13YgQmTeuVPneiwUKjavK9arqxvfkNOMpw7Zjsc6S3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 22:43:08.0444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da82ce3-2f1b-4213-52be-08dede0b728a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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

Building for ARCH=um with W=1 C=1 makes the "amd_sriov_msg_vf2pf_info
must be 1 KB" static assertion in amdgv_sriovmsg.h fail under sparse,
exposed after UML builds were enabled.

Sparse does not honor #pragma pack(push, 1) for the nested ucode_info
struct, so it sizes each element as 8 bytes instead of 5 and computes
the surrounding structure as larger than 1 KB. The compilers get this
right via the enclosing pragma, but the annotation should be explicit.

Fixes: af3f2f5db265 ("drm/amdgpu: Remove UML build exclusion from Kconfig")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607091659.SHEscT0c-lkp@intel.com/
Cc: Harry Wentland <harry.wentland@amd.com>
Assisted-by: Copilot:Claude-Opus-4.8
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index d80f01c0e754..b02561f41b58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -379,7 +379,7 @@ struct amd_sriov_msg_vf2pf_info {
 	struct {
 		uint8_t id;
 		uint32_t version;
-	} ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
+	} __packed ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
 	uint64_t dummy_page_addr;
 	/* FB allocated for guest MES to record UQ info */
 	uint64_t mes_info_addr;
-- 
2.43.0

