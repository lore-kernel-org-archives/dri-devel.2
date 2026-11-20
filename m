Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3464606A335
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5O5vTBk7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C064410EC4C;
	Fri, 20 Nov 2026 02:36:24 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAD410EC88
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjrzKfM8tUYaTsprbhHzfXC6G2UQGCVlGCcw595YrBetdoAXCpnV4fGib+BmPYo7pvUS94RiNcyw+uUs13as+xgy1Qq3GaoFe5ZqFhAsAI9vo9XHedSLvZo2E/RTPiYeFJBKx5ey3ZGo+T7/x2sQ9nwwvecgG6OEZZBrm8lA+17t7NhJ4Z8UezAV/3kYUm3vEKXKYi1Od8S170Sv2WZuz1ljTRRh858zWewxqBsoHQ69Hm9hoYfUHGKwkBGHIG5XqOPo/x/CBc5kWMBmItwvpzfAE9snWpLBmIJ96EP+YW6P5Re0UjsQs1x5P7B1w6XiWYstQ730hTdRv6oJ16hx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HNiTxFvfoUCPr4e9tvsdhmnMKPupztmudlbX8ci/3s=;
 b=apSkTEcskBE/fJVd4fbKM+U9a9ov6WP9r34CiXoZyX3Lrev9XRqq/EvUVysBlc5pygM6ENCg8jdUonIu5t1kjiZatpeOB0FZUs1l/1+ZN4NfmN2UGU2M1Eq4OlmZmXDXX+/Ox3NUpjlpJYCxD8Z9nO6PDBrSLUJPcCWuEagT3YuZU+T6BKNtyRD3SYMDDfwItFDRU9539DEcXMApz9s87r7iZE522sTHFIfPiG7qJ9sEXS4x3FlN5n/RQn4IZST7RhIXkq/KOrNNbre/CP/7IfNHLlK1rx6h3VSDVFlg/i/P7aGjkMzfWzdDHe8cbf1BM/yvbMmR215G0PTqe5SR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HNiTxFvfoUCPr4e9tvsdhmnMKPupztmudlbX8ci/3s=;
 b=5O5vTBk70yEZbSPR00t+eodfi/69C29EOjo0Bv2rlmoFScHvRFaBe92Y5pV0hqz8+LrPmMkT0p7oc5MrT6jQr5ikin2e3ftIajeY9OuPDJmti16B1k1dxv2VeWTPY8sUxKJRp4Qf5LTi8rHRnduIGmvI6rcrPJTWp/gtCEUqkH0=
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by FT1PR12MB777854.namprd12.prod.outlook.com (2603:10b6:170:24::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 02:36:15 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::5) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 02:36:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 02:36:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 20:36:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 20:36:15 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 20:36:14 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>,
 <christian.koenig@amd.com>, <linaro-mm-sig@lists.linaro.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Reject a zero sized buffer in
 amdxdna_gem_prime_import()
Date: Thu, 19 Nov 2026 18:35:40 -0800
Message-ID: <20261120023540.888381-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|FT1PR12MB777854:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f682e6-dd67-4d66-74d9-08df46af0cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|11063799006|261009223027099003|261021121427099003|261102123227099003|261102130727099003|56012099006|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: p6tYhiTDr1ykDYpvTPTJWZTXwM8Fa7qIcCitOedNajZ4LBQXEgp7EI+4aFkkO4lAI3K+Y6l7GyCjAAifC3hU8cygItPi4RoqDq24i/43LQEJgUL/DOf+imVtiAzJT/rrIoiv42gqeRTG4+DW/qzkyNnOimLVcv43ctKbkKy4s01F5P1Sdm0dRcyJei574YC6TSBQWpI7kCJEVENk8vmn70FQKRFbBoBbTg36L+9tp38k4SJxXB0fD1bgp7uzwFN5eZHikcg6+ugStyyf4PogXuVjXcWyb/BQvCcC8nZzVzorJ9l18N0+TfMM2XFpvCbwvQf/SMYFvXyj+15nG+5mf1YLSJMD3IfloHQwhPuHDnmTUyLFguSsufbrCD/HxCI7wgKXHI0H0PTf+aqWP+jc4xJMMvqoHsXjD5llp+1etQ6o5r7rma56qtKGcyy8yG6Up8WBBgQxdaeNo9gTeEm9DN/J8tF06qorQ/M/sNo/V9IPigMdsH+TMgzlS5lKne6oVJmX7/Q4oBSoVO3gH73by0WPjiOmYX4hpRH2erQjcKPXoHYbEcw+WH/+Bb0wa5Irq2oi/rK9KUzG078ibsmZGRYOGBkLMIoCknGRHCjqnifemHSnEOEP8HY9eg0Qg1hFl890XNazOp6aZShPp8jaLNx9foP8ZZVlvrcXUPwLF0jMtE6d/OK+Fz6C7Kd9m4YVU2pnUSobmIZj82+9fXjqlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(261102130727099003)(56012099006)(261026121527099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1th8wmtUAxPoXuwNVKpJiRoDZ+BHWQoWwK1XbNLsrtS6CP+yhyYVRDSC1znyrElYh0ctOTexFhT5IqQqdblnGBINg37dk0hPclSzwH9gpJz44/j8l9uZ4psSj1Q5mZeHmHNsXvJcZHDWT8GTcoQYTq2LnEhmx37rv7d7uE+RBxAgA0jqgsB2Ckvl1Ig3/+i/r41eyjKQOzGwHd5COMQK8hjSpnJeJ3CXSboD9tL6soMV6GO+b/znfeEM9/GMS8CQLFallPBGJWNHJP+O83V93fbeacL4XRyVxgKeOXX3kISkOX+PB9lqEesJhvwhc/y1l1CXh4uV0ySzb0wb8hzNnFEN/ee35Drw8d1SfncLHcMwT+aLBVQJ56ORaMUyPbFfIhjOhnTxXQQ3LO6jAujw0v0ZjS9iIuxotAhASVSSBo8/zu6oTKxqirCo6x9cqrgj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 02:36:15.6289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f682e6-dd67-4d66-74d9-08df46af0cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB777854
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

Zero sized buffer is not supported. Check the buffer size and return
-EINVAL if the size is zero.

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index ffe12a722dfe..4d7f3de88cd3 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1133,6 +1133,9 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
 	struct sg_table *sgt;
 	int ret;
 
+	if (!dma_buf->size)
+		return ERR_PTR(-EINVAL);
+
 	get_dma_buf(dma_buf);
 
 	attach = dma_buf_attach(dma_buf, dev->dev);
-- 
2.34.1

