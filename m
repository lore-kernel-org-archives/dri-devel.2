Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54653FED9EC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C7D10E701;
	Tue, 17 Mar 2026 16:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IP7uO2uv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5AC10E6E6;
 Tue, 17 Mar 2026 16:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt6bEZgS+OB/3rGbRZD0GYkoF9bqq2DyF/3rf3+dFLc7VkToKdE2B13fv35OebB0SFWiAbKJtm0CoWMqQkAc5cGvFasq1MmnaH0EeZPkpynip1+k//GY/T50/faDYp6/vTi/KG1YMlYeP/HUAkHr8i9Fe4kD48S3Rlrj1J/sz/vNblC30oV5kJRkE5fTifIOJEkDUCxmKm+vIyeBQ6cHLvjpqijtk5LHLQ64NIXfT5UrR6LaP1lHf972YAHnIDYgi2RRjNxVTMs1TzWA2OuQNzz8rzHX1DwM3iI4U8yGsmAJk4RCFq354wmTLdEEKSRDo1DePzaFt2ZDe+rOBQ9BBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EKJO923QhAmtJx5lhT3Ds5wNCenZPAicptDzXbxQd0=;
 b=KjTKjD1TMWNYF6ReXRFfnSIWH8iSKfV2iL5pSu8jaA9HIqeNmRAjYh00OmEdpNjYC4jEhnB7hpD/Dg8vS0NYLa4JCT0RzaGZNfLHsRH+FECzqfv/89GrGpUMVVlQKzlfFcdzqtiYq/A7GrRE0J0zLon/WSRuTPxleH3A3oU1VfAsH2HR/jkRHS2ZMAl5Dd38JGtI/b4gCdNicxHb+RkcxR3PBXaMcODyVqojhAONUMAQvejWhkLYcBhGTAt/nI+Y8OIGK0yVm4YFvVrd55vBoNIRS8pwtc5RZqUhwprGqSC39050YxYAEJ1JC4/et1mfv1/jAJW6fxcJNnuPgXWyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EKJO923QhAmtJx5lhT3Ds5wNCenZPAicptDzXbxQd0=;
 b=IP7uO2uvuFE1qf1w6NSMA1vUNK9QhwsUBmPdIFQcGeGiH9/++9QxA/LEBtaZxE330l2ATOGepeVHg/xyGjs5+mZmESx9/N7YHEgqqYZrZncmCEK6gV1yNcIdBpqt+NG2eDDi4hlALfuUkUMcGL5NaVibKAPknGXz7UyLGX6KPss=
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 16:04:21 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::f8) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Tue,
 17 Mar 2026 16:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 11:04:06 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:06 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 10/10] drm/amd/display: Set color_space to plane_infos
Date: Tue, 17 Mar 2026 12:03:50 -0400
Message-ID: <20260317160350.229028-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4888c654-bce8-4080-ee21-08de843ed9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: AwxaRxNbNmaWjgtk3R9oPIN86mwWM9VczT1HhDWtjBo7m8Si7Fv6fFUur/MYcELsU8itsiLT5H8Ie1I4QS8rU5MUWIG0+xZBcsVGMh+mmFZWZryLpN5b8v7vCfrlIbXwBU1AnjM6WGlO8qsI6FB4RIeSMReD5pu2g7KJM1lnKgKpSbU59Kd7oDHfO7R1FV9tgJi8HcmGs9meqUHcoTgeVw8d90oNMRRfCRUl9Ei/4C3DqK1Let5gcHslaTgOENKz3PvH82bkiG9qaJnVRUwKUl4NOT7rZn6johztB2IilRR4dXI7qPkfGsB8+5w5dcFpEz5EW39fgycQSHzx46qyp/wO1/B7UeNU85uUNqbFN1JQqat9rwGroXm1/xZ04u1tEBRn3VKiIhBsCMsfVr5FuwKVPvBXZMppp0e+ewGFR/wYtGYHIEMuQCA2GTb6Riu/s/D9oEwbKVAdJNlppDIoz9Cru5yGDbzjn4VL9t+cYJokKqBUJzCFrovhxaXQ65i0J9WujFEpph4vdtcEEqoPURNP6N7cxgZscAjC9cqB5LSD4nMb9ffS7HeJHh+c+3VGFbpfIfojZ6w56DDLm3H3/qLnt+IAjYM/UpHBOWqf+5YeH+K1wr98YLKuqzgZCS6Q+6y98xUTA8Xst7GFvUAHq1GzvXJ9OB/1BcE9VDla3jNYxXfvgDEK72gezHOoTwGIvsILwVsWhntkCa1tgy3pCZpYVuHmGSbaQTzOFEJQu2DpX/lP+QRudln7siny5XQnAITF0np02/ycFZENwRL90g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FYJXTvLVJOjRuBbML/DksiNZ9guHDAzhzT2ZSRKmD0G3LHYDH4t3PrpqpbPF+XaOCcwKAX4mbdW/KmmHAoKBODTHTiGUXRPYE7PH3dCbOGZ/6zGdsDnLlNDk0Maf4RZLn7ZC3VrXtY0eLuTVkwDJlY7vPRfoPSmmqoV9fG3TMgCCWKCo2+jJMfrOh7eUNVKQ3zmjFw5j5KO4oDEJZ4+4zS0xhm86fpxhUp0xmyHLjE67aRtgI280Qtp1w2iJP4oKCzkrsGbqLFrjUi5NGZ/azuGFMGdLmsjqumcE/3+AO8f1YG3YXHvnumeecXzMOIFQ5YUWMxGJpJwvR0L9I0zXWrqwz0bm2mt6BDkaQEAaWaigvGOH7fA8k+RSc6UxxnURps6BI0RG7nXBIn/OyVJyI1iT6o2FJIBbAW2AVLVpC4hH+u7VcWzkeRIUAYjjXxkn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:20.9807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4888c654-bce8-4080-ee21-08de843ed9d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093
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
index 24569633cb4b..20ccff796d48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9989,6 +9989,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface);
 
+		bundle->plane_infos[planes_count].color_space = dc_plane->color_space;
+
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
-- 
2.53.0

