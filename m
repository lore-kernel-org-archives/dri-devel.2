Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A24606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MvApR0Ub
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A1F10F7E3;
	Tue, 24 Nov 2026 18:39:37 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE22710F7E3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMQD8Cj9FipJCZEwtBRkLIts9DCpUzjXfGfhQBVcRo8bE6aLqLq1/KfO4i4ZOAKY3tyrpOz7Elk9VA9/3vyWjYHrdmkyRQyqepABXj5cMuTK7uqzkBwfqm3DTG/owDB5RSJKIuVbxtDISq5AsQr9hufB5xjboXyIx2aIfTsW6nt1SitAzp3i9gvJkNuwbShg27CmQ7gOH5EhgD+XvuM6EkgbuCqEgQtPfiqVI8tLjjw74S9B6FT2pl7pJC+s+wW72h2p7hhSQJA377tbVBF0Rm+mqndv1INt+48vEUiBXdClE/Pf8dBbJ5Eewl5QALBCxkaxhaddqjR6EB/u5nXhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgy5XjjkALoDzFe+PXNnhgyb98yMo1dw4iQi3LTBzl4=;
 b=n1zvlfTnLWBpRfkkQX5SIeb0/0OJbPT674DgYMYNGMrUPrgo9HBFbWj5ommtPN4+6ut9zIBX9M4fbhIC6gMFp3Ef+w1VTDqfVmm40rEu5aCEWsT09cBFSpnq2tMEZVEkMIw6zACFAxccHIFHcJYAYDdoyJ1PmBUPZfFOMJ070JJFGfiwC/X553ZREFJ0HBlimVOUkCYy+RfwFA1ETlOQ4NUClVTm0W7jhcDz38AJ3MIY5e0m7/OTr+g0s7DXxsmk6GCa+stNuvEUva2g7iZWM8hcMq37WFkZ1CGKoAJmyEzXIv3QPnW/HxIFWTYRwCf0D5zGXtw9BkgXGExIW1Widw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgy5XjjkALoDzFe+PXNnhgyb98yMo1dw4iQi3LTBzl4=;
 b=MvApR0Ub+rizmBWwIBg568biSHBHt9oS3z+S8DnvOHXhNBqA0SFz1hdQERSaYqRrVnm68bwhRz6BydLCXt7/Q9JrKUPfm1ZHyrFqS6Zrb77LXl+W45zP24krUFI8FkN/xizNVPf9f6E9io5UqPOqRaIkeQ/A7YKiOgCXpxxA5CY=
Received: from BN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:e4::20)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 18:39:24 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::43) by BN0PR02CA0015.outlook.office365.com
 (2603:10b6:408:e4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 18:39:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 18:39:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 12:39:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 12:39:22 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 24 Nov 2026 12:39:21 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
Subject: [PATCH V1] accel/amdxdna: Reject zero length user buffer entry
Date: Tue, 24 Nov 2026 10:39:14 -0800
Message-ID: <20261124183914.1955667-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: f80c4618-9372-40a4-11ab-08df4a5a425f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|261009223027099003|11063799006|10067099003|56012099006|261021121427099003|261102123227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: cEIF4q42qJRsGSlHYL0QvjXSI1a8wDRDhkzy6CQDFZ7pXz5NyqiaGu9OFR4i8TLiZAVVyOGkbC/4PiMdeagTjIJ4XDnpZRv1mgYl2EdtX9YiZq7qtjgCi5IvGBW2tb9jyr8NgXwtukbVt2fHxbSLdw8E4uLe6Ziq7285hTCWX5z4svEGPfkBokslEfBmSpyi2uS5oOHkaiHakePpHN2IPNuDAvYOkdHoYoHFJM9qo8ZnW5UNub5u5V4DcF/6BDRrhLTQzpR75gMquGquWUiyfG/Lnk7vun0fSds72MYnhKRrujkADKI5dCpkcTwMe70gvJshjpLNxLFlOwqI6XCbax9QIERqYfRMm3NBD0bcETm2wy56wtSF5kSvXrDsHyDURfWLlhcqvLCB544LMK0TGJkH8fYK033t5eI8Fj13eHKOLM1jbudnnM4APWjWfHEgZcXWeKfctAsCfrEGGX4WTgXboYOZBd0+apNyWHmdAuY7oKk/Mo9GvpNRCx3IjZbDJwFiRocXB2aMR9hG0W3sdsrJGSmN52nFG66R/1bGxu+TvBpDy+a3bql/rFqjtPb6aYlHr/5B4FK5AKbvPmGdalQEXXuV2n90lynExhb9DY/IXDCvhKYZBqr/+jliGpCEoZIi4g+AVgJiE0NbyfYBrDbkZz857tdJHfMlYtqpMYndM65N+71n3RyNfr2elhERg9qrUIoOloKQUM+Yvhc3KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(261009223027099003)(11063799006)(10067099003)(56012099006)(261021121427099003)(261102123227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /98ySDW11dQzBCpqoIYhH27k5WicQf8DXkf5ll1Lb65iAXxMHLW739jf14k22et7xY54hEeRmTy3HleFyuAXHI9qKaa66m7rWgwxW6HTynDQKCMNV0KdyfqsXNMzeKV0Fg/i0PFjq9uEsekpgcG/OeqHhHj5dPBfy5iPAdW+8EIDed8K1vIz5f+PciqvJUC+VhzKNdTk9Qag3kwklRH7OnPS2I2vUK6VGxzLiLhtlwuCy3t6GHfrR+W2Z0GWTg1h65zrLueT0spQxFR8TGOr7EMKQ9L1DIYtN5ANIlo9wVuk2cOw/Sw5OZUQzhVa4mr8jBMGPT9I91YEh6qyv9q8gKwodYym5vgTJpZLqR8Csq1Pobcz3Sj78VsYcUUko6wDsEXllv5xDvo5OpOag2kmqIJfM24DYuwxGLspo97TF3TwG4bhEQ7tt56F2CyFJf5d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 18:39:23.0359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80c4618-9372-40a4-11ab-08df4a5a425f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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

DRM_IOCTL_AMDXDNA_CREATE_BO with DRM_AMDXDNA_BO_SHARE_DEV_MEM takes an
array of user space VA entries. Each entry is validated for page
alignment only. A zero length is page aligned, thus an entry with
length zero is accepted. Such an entry contributes no page to the
buffer.

Reject a zero length entry in the validation loop.

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 0e0cd69cd1fbf..93b2b6496a0f7 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -111,7 +111,8 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 
 	for (i = 0, exp_info.size = 0; i < num_entries; i++) {
 		if (!IS_ALIGNED(va_ent[i].vaddr, PAGE_SIZE) ||
-		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE)) {
+		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE) ||
+		    !va_ent[i].len) {
 			XDNA_ERR(xdna, "Invalid address or len %llx, %llx",
 				 va_ent[i].vaddr, va_ent[i].len);
 			ret = -EINVAL;
-- 
2.34.1

