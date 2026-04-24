Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2B6FF8850
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A459E10E414;
	Fri, 24 Apr 2026 22:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LIBrkQma";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8B110E414;
 Fri, 24 Apr 2026 22:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9n/dcxiWl4CWBKoCKaRTrodqizSV1vb6lti+KrxGSdJilMMer8hFI420Y53R/0c0M27AuD24KTzKml8i7ZwmFWcUYIZy/4Lf95yIKP7Bh9e1VtqLrZA1zcn/C55/Z1Z1y4SCztc+PIYEEpbw135XwERToH8pT3u4MgOlfLzrn96dmRJ1n7KdMaZI4MUjvJTTZXwlKCpNGpfOtXzKj4qYh8vz6yyeKlw4ZLeXzmnleoOJ+N4GnbZA2oAWSXYQwE5UvR2Ncgk3OymSOgfVtWab7IfwTUQgfgFbe3KfQ1YAYQyAuhUdHx9/OHJhKQvI3y4uKsmsXjfOmXaLRdfXanYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOl7frWSoqhphYVZPT8obMjZyyl5iCjcNpbXMV5abVg=;
 b=ne4s9DMsFhVgHa95v1P6kQFcZqJb2fxliIY7jy2YD+xzhB4zL9ULsUZKNWWlGuxwqauDbdMOnGrprvPMQ85Ew8/Un4uwrf20G5d9X7sA0wUlmm6GYu6ll/1xV1pakWaeQDFJHI9+rfhuD571fp+Ow+2gpkxznKz2XIm0szd3lQ+uJttq/erILiq79YPpPVbOM7hgTEfjv+iURS0XeXRYheojb1QgSCoDlu9BV4mDgGOd/wKKjtUMCHZmkCypuJIGRQemwafhpWTYqldlR47LU8f7OOuLXdpNZeuH6eHsW26ytfu6GAHIK1l358+Up23WvdSC+L/YT7OWnLt2m4joPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOl7frWSoqhphYVZPT8obMjZyyl5iCjcNpbXMV5abVg=;
 b=LIBrkQmafSNeVGid3Jv2cXA5mLYa7+T4F0JF8TzzxYhDT9WG3uIqcRsAlNN+SOCnIKKo6z2Wkkpv9iHgrCBLx6dKcmEzpuJmR95LRgEW4WcbA1ROKE6eBL43xTPrek85PjE+xmBeR0D2U8fFjdWBGbQunnJ47tT/GcZGW7YT39M=
Received: from CH5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:1f4::29)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 24 Apr
 2026 22:10:18 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::97) by CH5PR04CA0018.outlook.office365.com
 (2603:10b6:610:1f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:18 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:17 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v3 6/8] drm/amd: Indicate driver supports luminance
Date: Fri, 24 Apr 2026 17:09:51 -0500
Message-ID: <20260424220953.167058-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d6c9e6-4d5f-4967-f8d4-08dea24e4538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: j4GzmTp7meQ3VTlMkNQVTrmjYcDbrr/JIO9dPzz0n2Xkf7yqXBEEMYrrNArv06KPqPzoRnUws2OsvlXlMIdxcPkjCOFGWm9f4X5DVq/ru6KSQf65k55rM5irDPLphyhOjsUXEIwrKhF7S+VTZSe3g7i87fBMKLbEqwG9XnP6AQ+qOBLSWbMzKtlIkk3twSCrrTKpYvorErQte+eEDxtzzxO7lqrQbh3WVwdBDdSRTUqEjYN9kOfGCrozT2TOILRV/BG9cwkhtu52TptEuQuQAbDppWSZkw6r4wirQxMQdpQlUjJFHqQ6oQ3HrseXInjvps11Cttbkn8pTgVlstZB5FowoTXzp1Xi2zs0hBE4g3GA1NpMUA0GTyG7g2crzWx7vbKtdJnRZeCZZ+j2IiNMbAbzYHVBqDBLGVfSZtn4YHATZBAq9rVU4PBwWkngUXeyEYdMKD3KcpIrmvdhDxoBKASe+RtW2uKMG2T1n1AsSPHrzAzX3vZ5PAixVJ4jG/MCqTOkTPmVzmuu0q8//Jc6Vn8Tqnk2H56W+UvTTiA6WvboDimhirtbvtZZmmZwLAJ8NS2cQ96LTEAKWBOpIAh77EnKqtVphvUN3ZhKz0+83RfAYFsCHnWedveC4yCZNng9lR4XEwcjCfS5h4YTDjmFxQ9nfsDTb8u40zvN0s4pjUE74s/k/cQG4oSkOn+dljpHtHbeUXqDjIa4jBRPk0+uNUnXAOnr4a7s9oTX8cKmWxVkzbTu0sebKAWiQ6CBBMMHj3ZNVnuJc2cOaVe643CXew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 66NmL9tPTlU11zRfcmpGv9BeIpE2puZlefO2IaA1vvHc27HxV3u4z6C1eiVE89DfuGvYW/4fuCAtO8UFedoB2W3i6DDOxZQWwjAlRUKVZWatpeTKyZiUjnREvQ7U8W3VRzRRa/XS9iKhZV2g5+846nsLP79KazuCmRB8HPEUr7TDlJclAO45HiSVheiW0QyFlDI5HjAdztuYYHylQk/vqy7peEgJOr4jOO/5oU9frexBmx1JLZcyVUuaGO538W6lfgXrl9BKyIDdO9aSWPACWAPJtoVTtT8lATMaDT4nAa12aQPyWGpkJbCsSXjQeyLKQhDIpvz036ZmaJGv/6JTJaw37XeKFZkDA+WpO5V8oChOvs7w4fKORPLwPJ0jwNDSjIEe2Zbk720jfJksHY9/f+9lQkvzPVgZpKlS3owa0lRebXfeh4EL5CRzqLABvuhQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:18.5394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d6c9e6-4d5f-4967-f8d4-08dea24e4538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

This will allow the connector to show luminance information for
eDP panels.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e47921e2a9af2..fa38d9f02edf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3072,6 +3072,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	    DRIVER_ATOMIC |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ |
+	    DRIVER_CONNECTOR_LUMINANCE |
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.open = amdgpu_driver_open_kms,
 	.postclose = amdgpu_driver_postclose_kms,
-- 
2.43.0

