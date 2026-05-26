Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D69CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 18:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F8D10E4F1;
	Tue, 26 May 2026 18:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UwMMZdrb";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CEF10E4AC
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 18:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYmchm1XsajqGlx9hI/IDUEybSwgHNaS49WQVwE6pUVEhDM8Eq924Ps3A2+9f7n6h4Mp5y0dphrqgQrbn4huj0zMKsG5qNVn3gdrIyAj0zDTVGYWh9dGizcjC8nH6MYa/IB82TrR9mH1NBhaGDSF+a1MSbj4295vvIE5hwgEJwAyOshYdec41jjhr/9Yx8h5ecYaCl//b+nKWcdWlKGvClL2Lw49jeMeEwnuQ2uDvONSMre/wsGcohzTAbF3lcM0rpD7zAK8ffQg/v+xWRU17I/D+gV+67G+uGTc9PVKzE0h1iNODBnFZY9egiU7oeYAZbPOw+CNE1oh/D4zLxyDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1+Bp+a6tCVksMePIUJPQ1hCX9oRx7+MXlj82rnres8=;
 b=ko64YkYMTCju3fx5aHp18vOdM3vLhvuVLrG8/mUykQ3pLy3JKsjL5mwKbUQ8IIPnoJuBQHbMw60LefQ6SbrxeY2l/pHF0CgyCuTWOBtiYKf3S37GvqVNK6Cf3f9ymmegpquQ/BN0/F/44oOqbHZSaXZ+ggcDZCIIUPhRAfOXz8jQUrBdbNAgDGC2RW0AtsNlnwDhqEKrWHEMntKo1Ghw7fllCjnWRPmizqIqc5tKdiJsWkwykwZm58+zxu0in6mQIe8mw39CBXi0PjcBGU8rILWgv5ArYgLb2fbd0MnfWx1gwEfWGSlBhqJNRVXu8sj8ubd1l85Yv8RwbSZk+mHwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1+Bp+a6tCVksMePIUJPQ1hCX9oRx7+MXlj82rnres8=;
 b=UwMMZdrbx27ZEb/Q+m2arOXkPPrqTahBkj5m9Jx8D/2i98tXHPPliQcWTpx2Kmo0CMqxIARatqXuOrIk4Rh4oHJsO2dulwZ5XGjcoACc4LWxM1ePUxvCDM4bPaG+VN9ZIhKRuPKNpOw1D1PDumx1fR/7lWcK5k/ASDH2Bv+yvsU=
Received: from PH7P220CA0179.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::27)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 18:51:09 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::5) by PH7P220CA0179.outlook.office365.com
 (2603:10b6:510:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 18:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 18:51:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 13:51:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 13:51:07 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 13:51:06 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Disable device buffer exporting
Date: Tue, 26 May 2026 11:50:58 -0700
Message-ID: <20260526185058.1780869-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: c445ba81-3757-46c1-03ea-08debb57bfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZtE2SzJ/zm4UJxRJA37lhGI1Vxre44luoCCfxH2YQ9Bz44NVYEVnh4nqMfB7VdciN64Be4jMoKO7o2yJjmn50j6ccTZb8sG2FRHvmJBR0/iQe0CZRLcpeeZsU0fLRuRtbV78T3wzcZ8F9a1DmdgeJyhxGRwRE8+WC9Z2nBVVQOT2SADGAWw6gcFRbG+/0FSWIzivgSvn2UTdiTvj6XJKJFw8mtC1bICmYZzfdfKtnIcyKVjb4O5jhB3lutiqMPPcGAPmai6vDly7hyAM+oT62sfzzMuGqMpD4W1BKS4Yc/5ANZhBpTPqTycz0Wc0tRlCWE01XqI6tAKGjCnzpNxhJ/uKtjXsFscOxCKDWIfEP23gtT8tLyhzKt5UFMW6oj4C2Mh6JI/zVAonIYFwmIMyt0aP8GI0so2ruIiY5xstSeAQ6D3OCUcUim+yT6gcPdNM4HqNTF1G99ItOr9es3XwpZQb6gIGB937mHu538IQh9bs3kR58qUsSmP5Xzpk0gM4LJf6OjP3020EO80+trOP1nv0AP6oPT8ezDHWwXvyurqNHBTqKyuESM13rPBfaFUcTcHkn7vYwR3bgmEttktQxK0uj05w8JeeZAkcz7aMS/k1Fo7DhdNWpnD+jdcrzVUzjKppDbtIdJcC9cFqxVcnIjWo/Lof3fONe+n4DvUdbxHxUpyEOQADoge1rhgTDQBZ1G07TQWfWPBjDC6bJAQkE6JRqqLtwCtlVUpOGYcdUtE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BG9Iw/KMFy+wnM1KSCnD9QoyM9XPDgCLAANPvwGATJS+RNRVRb0xuwQHZVoitkYYUVCJHPzGxnJKONl2+lTjY51p+AIeHOTn8d6FCCM2Am7owMALx5DnIkPzF81wTlC9OXObXqi2B7Ww359VYNILjMti8SSjdjZbnTLuToSpXMHieyXgK7lZO0SlFTQdH3q3CHNi5UiLlJvEeZ1TqB5eT91hPRTx2GaYhItz+Th/kcTOcqAZR7YeHNV1RujRF6MAn9i/Q+PsHtQa7ar2uhLHOE2dfmslhnRk4xcwBfRcYd0rRWt/7EBXmBP1gte0grfQgA0chcyMsiw2PjwpfB9OnMe27OWA8YZLenrAlEXusUoRKS4noRfhWokCcQLgtBkcg8/n69nT++ZXj9hBlNUgJMq3GnEVrb1hGPSi+sQ9hApzBTNTwvr0sKMKAd2WysiW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 18:51:08.7069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c445ba81-3757-46c1-03ea-08debb57bfd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640
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

Device buffers are never intended to be exported. Disable exporting
support explicitly.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 2dfdc56ba91d..2727e48afc0a 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -725,9 +725,15 @@ static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map
 	return 0;
 }
 
+static struct dma_buf *amdxdna_gem_dev_obj_export(struct drm_gem_object *gobj, int flags)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static const struct drm_gem_object_funcs amdxdna_gem_dev_obj_funcs = {
 	.free = amdxdna_gem_dev_obj_free,
 	.vmap = amdxdna_gem_dev_obj_vmap,
+	.export = amdxdna_gem_dev_obj_export,
 };
 
 static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
-- 
2.34.1

