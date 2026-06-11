Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5954CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF4610ECD4;
	Thu, 11 Jun 2026 05:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZF3AUrw";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EB710ECD4
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq58ezFJCJNFgxmVAJK/AnWS0nCl6MU8pjckp2bQCpEAh/d0bA4AzFCPbOIhzvgOkifD1NDGugFmQ1CO1nLT7HH9FYeL74I6s2pigtgoDlfdwo6lId7SA4mfAKVE6QdRipcagstTsbLgnjIePrfUnEiibJixxxbxHnJK6cFXT15By+1bPVAmStfErDDPshxUXyPJtxun0KWgd8kWIoa+gstS9yGEUV2gGu5AwnqEbTftUg+LrNqhu6dodvSSq+2EmDEQA9G/chCaa3HKgkqdWuy/8G9pfXHhEA9l0cTtG2obCQO6rQRgb4Z1C19TUaC/dBSTk1ACGnuNR6haau9L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8ZAyfmwZonDGwdz/8KraJAX9fFtHJ6l465LAjNGbVo=;
 b=uvAg105kGohwyKPKJ+k/PIT+e+DWyzaQZKoR2+ePf5PfSzE0pZjlJyq86HcM5TG+FwjSRjOsV5DzWXTNymmqC2KeJGsfIpKKwzRAtH7dERuUv2GDLXOpOj1UwI53kHHhzqv9jNi1HXFBhhGYZF8y1SnFE3iGjLq43KHv4+Dy+Buizvqiur6Xq7bBwv4nKwrOPp/xNHQNjQ+C4z4+gdcY/xWK0qFeRZU8fJHqVAYy999TSSKEShLzgxaFkH+mczsbiYdDhJCiQhAERxWgcdlHCE8xLZzEE5bYDNRPtaV8wphjfbhdHabfxgThLV1AxC3goSfMUW6Fuw7NW9YOx6afMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8ZAyfmwZonDGwdz/8KraJAX9fFtHJ6l465LAjNGbVo=;
 b=AZF3AUrwCiFvLAwqE9kvlf4ktDFaf3aFG9UIB6h6hJpcCS8zVeFt+dcoYmPpcfMZ9nQ26iuMM/eZNtkh7xBLFeDzq5n0X0ULiSjyiNSVWTucP+JHKqcvV0PHUy821vxDq9S4IIdStjrJbE0IiLQxB2bLvTtMvk+Q1M043aQks30=
Received: from SJ0PR03CA0125.namprd03.prod.outlook.com (2603:10b6:a03:33c::10)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 05:52:08 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::87) by SJ0PR03CA0125.outlook.office365.com
 (2603:10b6:a03:33c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 05:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 05:52:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 00:52:06 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 00:52:05 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V3 3/3] accel/amdxdna: Fix iommu domain lifetime race during
 device removal
Date: Wed, 10 Jun 2026 22:51:50 -0700
Message-ID: <20260611055150.3070216-3-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611055150.3070216-1-lizhi.hou@amd.com>
References: <20260611055150.3070216-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cf93e8-f998-4a00-509f-08dec77d92ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dz51QU2tml+47HJnEyweJwyFafPGdVFVcOrHta7wtj/9rrGVQdNmgZrPMr2loKsOwm87hzDMFwLz3hagPuU4W62kqwqwsicNTOywYS46dIkSmfcUfGY34RkEpmRlVWDPZdWTSHyM59GLWzEjmq4/Y/V6VhKu2/Vhfc6ia/tzD1VGoiHLWzrKdZQfma+FQKljsca6G2WC6y6AFU5z9s7SCL3kcuTCACs7OXU0bHYRJ/FdbgPPESYOySdvtNQFVJVHZPFOD6AilOw6hUMm9O5Wx7+O5NLMh87OAs7hjp7wX7cWqJYyzzgLtORI4Zc+qMs9bv7o+uQATRoky5/TKYrgTMpN+n/Wpt9czDi70Z8opQj/ARGAw3e7pQK4Ryi0CugVJUF2LiYE4jm/25Dg/oJU12M6a2OHu1u/ZSTtvbM1p7V/DE/no5guSaUlPlK9APYytfPR15cG3h2AQDhaxys5t1etKbNnb7deYZshU0his7OkIPFmA46m/h8UlwpQQ0bAh+U5iYU+BglPg8RM7ScFLoXMDAG/KgWXWJnOTTBGHPL5L3u6PX61v+woYxxyvy+t6LxwJgDr+cVUtCeu0OXrqZ3n4R4iTiR9txFs+Emedk1ur/RWCPCSNuooFX4nnmdLurRRefxyEWUQgcybtUxpFaeMfQqa4amG71woEeH0KN+uu72c7gx9Tzg6EYK7GbU4nRkLGQ3shC3TbMgaNuZ7Oq44pZXorzm+V8sbirNwDdA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SWIxMNldhbFVRdE2Pc3vaxfhnTxe/kOzvH4WGOFAJKsnO57bdGSLHHEkUXJ6lv7O3Wsg/WNKJVH72Kb9oWwd3ANp5qDN87PvZs+egXCg6MYAn7wSAVQ+4IlHP5/mOHTtkj2qUzAZfBCWPwHL0lfcRAMSU69yU+XYqbL1MBs9RFk7RwoySLZXKm8ZOuxbqS/lrR6dZ8q0srUce7TtrPtq1rVhgMZp5ZxwqDpG9Al6JhUUakxM8xCUKhefwNAWa7G7/QZ2r/JD8ILQe1JddgnHaX3DsXCG8XdCYsWB3kyBW7pxowSKbW4NMyLyhObBjINro26plsE1SgBBmvFySGkjWN6pxsi/thU+osMAhN2FrKWgPBaTeG2CH+Vuw4E46715sl1ZqchL75fAuf+uu82tJtVooaNihQz1vRpDjvMe7nwl5Z3RWWKd3czPJmaCdE65
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 05:52:08.0000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cf93e8-f998-4a00-509f-08dec77d92ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

When force_iova mode is enabled, amdxdna_remove() frees xdna->domain. If
amdxdna_gem_obj_free() is called after device removal, it may attempt to
access xdna->domain, resulting in a use-after-free.

Fix the race by adding freeing xdna->domain as a managed release action,
so its lifetime is managed by DRM and remains valid until all managed
resources are released.

Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_iommu.c | 43 ++++++++++++++++++---------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
index eff00131d0f8..4f245b969eef 100644
--- a/drivers/accel/amdxdna/amdxdna_iommu.c
+++ b/drivers/accel/amdxdna/amdxdna_iommu.c
@@ -4,6 +4,7 @@
  */
 
 #include <drm/amdxdna_accel.h>
+#include <drm/drm_managed.h>
 #include <linux/iommu.h>
 #include <linux/iova.h>
 
@@ -153,10 +154,30 @@ void amdxdna_iommu_free(struct amdxdna_dev *xdna, size_t size,
 	free_pages((unsigned long)cpu_addr, get_order(size));
 }
 
+static void amdxdna_cleanup_force_iova(struct drm_device *dev, void *res)
+{
+	struct amdxdna_dev *xdna = to_xdna_dev(dev);
+
+	if (xdna->domain) {
+		iommu_detach_group(xdna->domain, xdna->group);
+		put_iova_domain(&xdna->iovad);
+		iova_cache_put();
+		iommu_domain_free(xdna->domain);
+	}
+
+	iommu_group_put(xdna->group);
+}
+
+void amdxdna_iommu_fini(struct amdxdna_dev *xdna)
+{
+	if (xdna->group && !xdna->domain)
+		iommu_group_put(xdna->group);
+}
+
 int amdxdna_iommu_init(struct amdxdna_dev *xdna)
 {
 	unsigned long order;
-	int ret;
+	int ret = 0;
 
 	xdna->group = iommu_group_get(xdna->ddev.dev);
 	if (!xdna->group || !force_iova)
@@ -182,8 +203,14 @@ int amdxdna_iommu_init(struct amdxdna_dev *xdna)
 	if (ret)
 		goto put_iova;
 
+	ret = drmm_add_action(&xdna->ddev, amdxdna_cleanup_force_iova, NULL);
+	if (ret)
+		goto detach_group;
+
 	return 0;
 
+detach_group:
+	iommu_detach_group(xdna->domain, xdna->group);
 put_iova:
 	put_iova_domain(&xdna->iovad);
 	iova_cache_put();
@@ -191,20 +218,8 @@ int amdxdna_iommu_init(struct amdxdna_dev *xdna)
 	iommu_domain_free(xdna->domain);
 put_group:
 	iommu_group_put(xdna->group);
+	xdna->group = NULL;
 	xdna->domain = NULL;
 
 	return ret;
 }
-
-void amdxdna_iommu_fini(struct amdxdna_dev *xdna)
-{
-	if (xdna->domain) {
-		iommu_detach_group(xdna->domain, xdna->group);
-		put_iova_domain(&xdna->iovad);
-		iova_cache_put();
-		iommu_domain_free(xdna->domain);
-	}
-
-	if (xdna->group)
-		iommu_group_put(xdna->group);
-}
-- 
2.34.1

