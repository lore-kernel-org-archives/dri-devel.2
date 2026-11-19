Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F8606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Af9cdEqe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEA210E5A0;
	Thu, 19 Nov 2026 19:52:22 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E7CC10E27E;
 Thu, 19 Nov 2026 19:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQNmURcftHBwXrn5U4JO/c9tc2AN18PlpeFyXbla4V1pmC/Ck79Zag4vZHErlZj8axdxk/9j7y+NwpaKYetA6iGhATDqLcdIzxlHFHShgsEItbLdtRuRJoSkQ4zeTnf56GnJEKtIeUu9hOlV5nq69TTXLh3TLY1ErFXei7RXfQ+Se0VZjiYyhC/Ancl3FAzzy9786zcG8OsdDDwV6jgNFobIH9pSvURx0FsHZfhbmGFEfAFNdEDaC8GXpg7mssdW4F1QS+NfeAOGGTvyUglCBwlvzH+UMe0VcX6OLJfLRS0hSIbkJOAoa07N5EoaOcVMgNqdN7oXaXVWpnHdatlzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0oP88Bnof/jqdy5M1dZLVuf+i5UBRTTdnGgXpDEIk0=;
 b=jaXYwWL1gSrIh8SahLvLjVpvnLnKgyDl+BrSdJdOR5QfnJWz9yR7aqqvqfClCzLyd3JyqbH1ZKMHZ9QBEN0FntLBahIgZRr/JyvvSyb64ViV3fYsBX2E6f8aCBEl4R1nzwRr5tOBJoHscmV7EBZ45H7b2y2lCmvPbcLAXHpfX6coasHjf0YjQ3M0efz8gg6xg/qu6zmslLPmLVJx9iDHuLwguiHLouosho5sp1TyrUyHm1wsv1FLGdXPDhLMNe/Z54tUJ9aASXgm+o+GuMJITYM2QZ6lJYQ7VpPH2TAxTg/j0yqvhv+euxXHRHju33JSyUS5K3YqZhmdD3+8Mi8tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0oP88Bnof/jqdy5M1dZLVuf+i5UBRTTdnGgXpDEIk0=;
 b=Af9cdEqeP7gf/xx47tayJ8SnkocnCTGomB1OU5022tQXCQ/FQ5GSnV31TG30GTt/ixR+PLDykn/xzIZaOFQklXMfsIqrEHoqqiZjzHQADzEToN1ZV5FIWK7JBKoSPNv73jtXefJTu+olSypi0v5LoloddfMYi1MWR+EZ6Rwd7Bk=
Received: from DM6PR02CA0125.namprd02.prod.outlook.com (2603:10b6:5:1b4::27)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:52:07 +0000
Received: from CY7PEPF000000F6.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::44) by DM6PR02CA0125.outlook.office365.com
 (2603:10b6:5:1b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 19:52:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F6.mail.protection.outlook.com (10.167.247.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:52:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:52:00 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:52:00 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 2/4] drm/amd/display: Use the wide curve for gamma 2.4 and
 2.6
Date: Thu, 19 Nov 2026 14:51:56 -0500
Message-ID: <20261119195158.2546927-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119195158.2546927-1-harry.wentland@amd.com>
References: <20261119195158.2546927-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F6:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: b192e565-0a4d-40b6-9bc0-08df46769755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|261009223027099003|3023799007|261021121427099003|261021123027099003|56012099006|261102123227099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: x/ikthyUw+i2YqEJwHPownFe/eMOZjF7tjrdR1R60yxXYS2c7bze0KckU7V5opEb/KGEKAeiOfwKDzhUrvndeJNx7HP6ncE9fHyrBlRG5IDgW/bKO2SztqkfUj/sqbtrLboDWczsI7UzGBlav2DCSrn4A9ThCfvFYTvydT5Cuawu9GMV0q+BJrnXe/p21U6DiP2EHJkleECzS0QESe+AeYuNsZJU0NHtXGRcf3nBE5O8ajyvwvaJGJxoR8VVhEYo0MIHzHcMC0sAIwLEUSe9aZfrzrBle+cANBACcbR8SnEuWD1tQrh4c/C2ZILyoYjbsjHr+UJKU8g6+oE5DLOiMSi2vQjh1FoBoDphF0IyudyTwK952OPsZAesdeVIP9r2T3B15OCWdQVKRhy51857rqDiBnm9e3V1h92SOBnzCZwHcesW4ZhOFf09wWyT+ZPLnPOzQZz9AQz+QtoUQSmHz7wcaqcSqsSbXce+1180VClyYgqMHWABgy7EjVjNqKdyMq44qseK5/MbkLxYeAfSlauOSDy6bi0siMkw+2EBhmTYOcDQ4GiakeYNn0kzVDlaSnqAsLclzalyTPWZAJMFgBl/Oc/bBmB6Z1LYlI+lchvjJL1ZiJo6Yoza2w8uUoasN2QJb05Rv8gQuFlEeXG59vCsPklC/4L3huk+8bR1b3jPc+BSN7qUpenNtGKVcHNbwJhR+BK0RDY9+qg+tB+1lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(261021121427099003)(261021123027099003)(56012099006)(261102123227099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ua3o5RD4lgCeIv95FsDpsf74Q47DNKl3truHDwZ3LSycKSoaSuRB36c9CiFxZWmH+o+bLvWziqxC530a2qPxEgciavKWVCkMLOuHjb3loZ+KVnYJXBiLbgDerW30BYmLOPBdDi/4adBDJEmDkmLx4rYXa1jaZPvJmtj4SJG4hkeUMr/+ZI6lihpLonZfKBG1rdvKQmGIJQpmHibvkuULtSss5Z3/Uoor4mHeG73QxSK6V+4Tf3yRUX7+NsbONsqQ7LSiO0+TsBXWh1ryY2vO2+bJfTIgTdna7Q9zJ8wmAsZNzWu//t+YwdIkVQB19tmLKZqRQXIiY+hL9YHIczLzxR1LWQCu9JCZW+Q+XvIUKX6FvRlIKCQl0DmokMYXKGOHJBDxebi+T3Q+nnz0V188B2X8aUvMgt+PJQyOWVetzXgIHhV4tRQG1bzZTlGSodq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:52:06.8050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b192e565-0a4d-40b6-9bc0-08df46769755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

cm3_helper_translate_curve_to_hw_format() puts PQ, gamma 2.2, and HLG
on 32 regions from 2^-25 to 2^7. Gamma 2.4 and 2.6 used the other
layout, 12 regions from 2^-12 to 2^0.

cm_helper_translate_curve_to_hw_format() has the same split, for PQ
and gamma 2.2 only. DCN 3.0, 3.01, 3.1, and 3.14 program the plane
shaper through dcn20_set_shaper_3dlut(), which calls that helper.

The inverse curve is the shaper, and its input is linear light from
degamma. A 10-bit code v becomes (v/1023)^g. That is below 2^-12 for
v = 1..31 at gamma 2.4 and v = 1..41 at gamma 2.6, so those codes come
back as 0. On a gray ramp the round trip then misses the IGT bracket
of 13. Gamma 2.4 needs a bracket of 33 and gamma 2.6 needs 41. Gamma
2.2 already uses the wide curve and its round trip is exact.

Use the 32-region curve for gamma 2.4 and 2.6 in both helpers. Its low
end is 2^-25, which covers those dark codes. On DCN 4.0.1 the gamma
2.4 round trip is exact and gamma 2.6 is off by one 10-bit code, so
the original bracket of 13 passes. The DCN 3.0 family path was not
tested.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 4 +++-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 502a2d9b155f..6b3cc0d81e34 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -355,7 +355,9 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	memset(lut_params, 0, sizeof(struct pwl_params));
 	memset(seg_distr, 0, sizeof(seg_distr));
 
-	if (output_tf->tf == TRANSFER_FUNCTION_PQ || output_tf->tf == TRANSFER_FUNCTION_GAMMA22) {
+	if (output_tf->tf == TRANSFER_FUNCTION_PQ || output_tf->tf == TRANSFER_FUNCTION_GAMMA22 ||
+		output_tf->tf == TRANSFER_FUNCTION_GAMMA24 ||
+		output_tf->tf == TRANSFER_FUNCTION_GAMMA26) {
 		/* 32 segments
 		 * segments are from 2^-25 to 2^7
 		 */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index eb299f7f9c41..8a76e985d359 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -133,6 +133,8 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	memset(seg_distr, 0, sizeof(seg_distr));
 
 	if (output_tf->tf == TRANSFER_FUNCTION_PQ || output_tf->tf == TRANSFER_FUNCTION_GAMMA22 ||
+		output_tf->tf == TRANSFER_FUNCTION_GAMMA24 ||
+		output_tf->tf == TRANSFER_FUNCTION_GAMMA26 ||
 		output_tf->tf == TRANSFER_FUNCTION_HLG) {
 		/* 32 segments
 		 * segments are from 2^-25 to 2^7
-- 
2.56.1

