Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C1606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CrmDVoRg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8466611260A;
	Thu, 19 Nov 2026 15:54:54 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA6610E25A;
 Thu, 19 Nov 2026 15:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OppMMicNZRf88HTnq8x3IaIjouY6lg5LMLZk5Yky8nGlfFrbGfxMMREWXXDPQkPbvRPbOe2FoRUJ/zCDwoRr2xuE7X8Z4R0AUYHHJOSt2p+EmHqaeqNcb0R1Txe3i7eeajnVi0HPgOjVuxsqtgs8eURSmsuUD5jFkv67+QeNaOED34YgY5HEhIyowfEvv+Eg+4/crde6TxUGcJ32oMRVUzd0yfmYhsAYwyJAN+qSEWUBevKO51mdQ6wE10WlbzeIJkbVETFe//QoixBWJK85Bh/AezRYe05TtNis7NMOskjhAS2xEuCsYnt//YsRHoiKGUWKjXoRcp4tylUlilnWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWOs5bL34zzd3LA4yORI+GFB1a2MZvLaIQl8EU2Un90=;
 b=QjrvGJIdMQSIOOdfxVPO3gE37ciziN2EU9eQ10Tkgy2S07zQERCJ8vNEqpWqGSQ+dvlW86OH3/JQCGAM1ChCYLJTKd7NHQnvWL+lcxQBNDRqoWwI7+5IQaJr0Y3bsndAzDiUJOfjdfyG6uJoDK/f/LXjPWAa9qbkNqJf6BzfYKExCIa+UWrc9hsP8AucvwlEViWinlyC7t50Yi6icH4eVFcRra2BhZccENurEvdBAMIjjefHnF903+1NMEd0Lt7jcFmRtTiIEhWWFVJ6Rv1gabfapPopOcPkIE8rlm2vqjUsQeQeHvkZEEZe+gUu1XPuFBo5/ruJBfqyMDAFDsWbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWOs5bL34zzd3LA4yORI+GFB1a2MZvLaIQl8EU2Un90=;
 b=CrmDVoRg2gdGOXoKDvkLDfUSc8P/pTxV7s8bc90BRAREO77Q6Yr1Soq7I/2bGu2TMFSbJes/9fFD00JJBtcCVFkiSFejXLzl/IsP6vKoH+a1T0Soqy5wZwiUi2lAv/O9XkjXuePhrOJ5bqHDj9kIkJH1b6PjNPqSBVViL1JlN3A=
Received: from DS3P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::14) by
 CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 19 Nov
 2026 15:54:38 +0000
Received: from CY7PEPF000000E8.namprd04.prod.outlook.com
 (2603:10b6:8:45e:cafe::9f) by DS3P221CA0009.outlook.office365.com
 (2603:10b6:8:45e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 19 Nov 2026 15:54:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY7PEPF000000E8.mail.protection.outlook.com (10.167.247.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 15:54:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:37 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 09:54:37 -0600
Received: from hwentlanrmb (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 09:54:36 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 2/4] drm/amd/display: Use the wide CM3 curve for gamma 2.4
 and 2.6
Date: Thu, 19 Nov 2026 10:54:25 -0500
Message-ID: <20261119155427.2494007-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119155427.2494007-1-harry.wentland@amd.com>
References: <20261119155427.2494007-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000E8:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: d5928a3a-4f7c-4cfd-8a5b-08df46556ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|261102123227099003|261009223027099003|56012099006|261021121427099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: uZXpM1hs83k3Hlf3gTWo0brED3qJhUFglJcZ3VmaujfcaxV6dSLHravnNqRhiriDaVJzTVWQkfJcoz6HuE7QsrJjmNlGLKEwuCi1FbBqqfcIOJXtfVSFP/fdQhAo8TosPUkiri81vxCoTyEH+Lmlec2UbOA+0bK9hfWcMXT1fwwrkZKQfcsIUvihCobf8GzVo4g/fy9wz27FmeuVJrxFG0sn6AN50HeKkUeCLaKsKMGV6Dh5OF9dsCQLj6WNTBoHBHIdS36SU0x8lhDOl7zXRh55IKU1bEQsg0ZWNOF20VFhIxbJksDYIsRTM2H0Cz/fHv6fwnzRDtMTG2X/7FF7XXyf6aaK3s3WDUOdHspOHejYsxrWdMS1pMFS5T3NYzNd7GfMH/akVszh76IsyjSDAio4CM0cjolrsoWOlhKry0SvGjnaPHCCQC9OrjPv2wz6qAxNFcLkWOSxXngtbP0yDQ+3vteknBZ7f68EAChXCXdDy6wXlqffnlIumt2IxChmnuqnoQlHT2bhPyGi3JlQp5yWDqCGjV33qMdnK4LMltTTAp9uQbvv6QHjizSKf2NPr02e8ebjvZupYMmtMbq8aC4Q4JWY7B0xMRuYJl2xa/w+IbzJjf5aPm3yAnsDpUU8cUw3D5AVJx6h+ZoHARiDrhkKTkL5hLxn86RcC5b5Wbd+1csDCCkxk8Jtm1OIq+iU/YHxd2zTZNPefVMSs/sVFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(261102123227099003)(261009223027099003)(56012099006)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s+way9hz0AW4SGzEJwmHRTXM41jqcbTENpTo94L3JrMFS3s640udSZ+zGd75cj4McAmT0JlYn5FxMaHuqcYS/kpaX6CNwUSjkHcmmZ3Q6RJbB5CwQwXrXYzGbx9xBvak7ZHiLnJOt4q8wIl/FwG+l62+gFSplAJVpHAfz1A5zS3LcNLilKjxKSaAHuwdDAP6DEUx4uEAx708IbEy9x/pE2v8HJVVsBc6GUTIlaZk+QSQrzt9szFI+/+sFLwTUM3rX6PbyZRMMbqQjKXje/9KIzm1uo5XHaCAmWdhf0VTZQuhP4ty+wfOD2+JME/tAJooTld9+J2o+j4H3q+ywOPUq7K8G4eaVbyBAR+bfuZYTQpDYWlrXoxngUN/tTsUmIXpz4egsjaxFwP0S3upV2IVjEt1ggvkHFHz8dHgGUnmAJxkJp3WRhaUM+mbzGa4WSYq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:54:38.5681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5928a3a-4f7c-4cfd-8a5b-08df46556ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000E8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cm3_helper_translate_curve_to_hw_format() puts PQ, gamma 2.2, and HLG
on 32 regions from 2^-25 to 2^7. Gamma 2.4 and 2.6 used the other
layout, 12 regions from 2^-12 to 2^0.

The inverse curve is the shaper, and its input is linear light from
degamma. A 10-bit code v becomes (v/1023)^g. That is below 2^-12 for
v = 1..31 at gamma 2.4 and v = 1..41 at gamma 2.6, so those codes come
back as 0. On a gray ramp the round trip then misses the IGT bracket
of 13. Gamma 2.4 needs a bracket of 33 and gamma 2.6 needs 41. Gamma
2.2 already uses the wide curve and its round trip is exact.

Use the 32-region curve for gamma 2.4 and 2.6. Its low end is 2^-25,
which covers those dark codes. On DCN 4.0.1 the gamma 2.4 round trip
is exact and gamma 2.6 is off by one 10-bit code, so the original
bracket of 13 passes.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 2 ++
 1 file changed, 2 insertions(+)

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

