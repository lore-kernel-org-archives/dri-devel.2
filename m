Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC971CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1404410EE8F;
	Wed, 13 May 2026 14:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XEzHpeFv";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F81510EE8F;
 Wed, 13 May 2026 14:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqPI9SMNeXZ6Y9K7FQdP3hvWlIo7E/878bG9/LTmqf5eqgQYg7LKEi2oBpgXPNQ/m6u99nDD1GYcV7BCOtBu/2lZB+1F4SqtzbsRCmS7hBmj6xdYge5/Bua0gQWP7Llm/wKtuUyAP2ETebuOMvYRWoCQ4/361a34glicTE8YKeM5Sf21aG+NXXXKTfEYOVCX6ET+wrOnVcKi0j4YDibA1WYhQH/gR562e8+EPvOU1HTZH9GWxMLLoPwEFRe2QOv5dTPOq5sSkzk2xDKqqm7oeych69mBE1Z7Q7Y3mptUcWl/DBMu9iJDIHVMYdEFZvGlCpMgmOJTJI4YOHS0HGaPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YlMveEwkwaspnkXz3Bj3pv4Ku91Y1VuwJvjza1E23s=;
 b=JpyvHbkLEIybt/HmAPHL7hbvD6EMv7HtQTK/b1PUkAjZH1j+2t8/IIkyFqW7Fj7bVFjFWJBm/eUvftrnkbEn4ufSJ9ZdKBu3o4QrwuKsTOu79SI4yqxQ7JBiy35keFLsuuWI97BWC3Xh95oVHNxGOtadTj8dXbgPIH9GG/ZMcL89fsthp00LQNyiF0YbIFf1P/I5GC6hjKeWwkyL1OwVZ1VWgnXEeQBdDJOOxmlEhMHL3+xV0cUtfE4vDbt347Ayv4C1usQu3rkitwhgtNd/Sx3L+B1d26lO8J/qdYoWTtgZCgPUo5REarwd4mPjIneLT9H4N4YCyp0RXmb8bliu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YlMveEwkwaspnkXz3Bj3pv4Ku91Y1VuwJvjza1E23s=;
 b=XEzHpeFvRBwN+7A3UfmD1wWiYV0mxz5D56/DaHswFnDhmOIc/lbgIXZx4LAEIxXhhSHBUFrR6aIVbNUszlt8dGWEb9zueXnoVNAKZ2q52BA7dAXZYgPAD8k+4nyBFgNQTOqIm19EPoYXAeQuTGXDOMHNaztHvAL72OKQ37L7+rs=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:13:16 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::1a) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:13:15 +0000
Received: from MKMFKUEHLIN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:13:14 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <christian.koenig@amd.com>
Subject: [PATCH v2] drm/ttm: Support 52-bit PAs in ttm_place
Date: Wed, 13 May 2026 09:12:53 -0500
Message-ID: <20260513141253.20410-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9c6e9e-1405-44d6-504f-08deb0f9c669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: To6rOET5niH9ZrzLrckslqCg5K2u6r9PeeoGByj068fLBJ8TI5UtlE9cP8PkKwlaSLcYVolJgjunffEVEKdpvNQ+A3ynklCxO07zIlKbov+dSsg/Zg+MIsxxMa3vIoy/JepfvGvMh3R69wUQ96O+imh9gfZKFBoFX9S2ZT5k6PZRy5Piyt6fEZwd9ABbkc9dt0WbsPGSv174aU6iPbG3gfSRqK05m6WiwWuesYzcJH4pdhNP6jD3rsgsqCjEPo2j7sTC7WNL2dZsDCxJlpNE+Mxxsyb3SoxVcuT6WMPPhSj93uQhY8QL18rXscANf2fKw5DXKLQT4q6f1GkRyMaVtBSfYlXxUOCr0szpsZt02hdTy7i+24wsg5Z7r8GNIqtyUnC/F0LxD2H5pGbd/Dck5QdvVEYb5SZ3p4Hq3Z8RpAshiBchWXRVuM/KTe1WZ9QacDe422jC9jVEW3Dy+dEAWAp2Aitdmx7W2DqSGPRv3fk3H46y6XqMqiE1hHB8MtPNf70HXVkGsWu5Vw4zBmJV7zVPKUYZmIvx3xa414i1tDbET4BWtJe+yv4eqCsQprclkvOuoPxQPdczYH9Q5XNUVrd4i29Vs/qBEDZZPLcuZuPqRS/91YD/oTrKbJlQwPsoSAOunMRdlSRsdO9tAAFeYKNp2yBdMGozrJu07xysRdJfiIaHBEQ872fTMMtWDfsgai3bdm7Wf1nOIPAr/sRDzIsEW062BH4aKanEO+FmVmU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AtK0xCLAgf1EFVJS8mwgAUyzImygymlnxW0BmdHwQbtkBzc7I9FhKNUV7thMGL3DiRoGxlYBlg/b0C2HoPpe+RIwOWYU5gwwHc1+Ac2Z/oq2/dSQOetGeReAoO6HnKiqJlHE/hQb/dHiFDCeoMmwHfemVs5DOfpOhnWqKx0W/OcQAgq4RArzKphVsj71cOiNZSK86cZQJ+id1CVlQCpmPRv5pFJK5wUsDWyRyivBs8wKkxSRugWTrzNkmw0K8ZS5aXoABa2Z9kKbpYIt9taiBkXjqcuA0gEhy3qAGGSq9y1u0FrYQEH6kYZolgjLBlgk6yQehdKLFbQWTUeXm0hL8hQfc9u/OZIRsCL7iRyYlqRpucqqryeDc9t/LTX7Vem1qtTB0f1Zl9G1dur1B8iYpvtUwyWnuIuN9QNW2ZDJEPFLBRpW0hk0kNSuzFA/At9M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:13:15.4911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9c6e9e-1405-44d6-504f-08deb0f9c669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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

fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
size this can support up to 44-bit physical addressing. Grow these to
unsigned long to support larger physical addresses.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 include/drm/ttm/ttm_placement.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
index b510a4812609..ab2639e42c54 100644
--- a/include/drm/ttm/ttm_placement.h
+++ b/include/drm/ttm/ttm_placement.h
@@ -81,8 +81,8 @@
  * Structure indicating a possible place to put an object.
  */
 struct ttm_place {
-	unsigned	fpfn;
-	unsigned	lpfn;
+	uint64_t	fpfn;
+	uint64_t	lpfn;
 	uint32_t	mem_type;
 	uint32_t	flags;
 };
-- 
2.43.0

