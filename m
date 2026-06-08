Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A8ECD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5AC10F6A1;
	Mon,  8 Jun 2026 16:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jp/rmcfQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DF110F6A0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr1ljTsfC1Ao4ZzyuflPT9C70it0JsljdGBPnU4sM/o3PkKiz9Jx6CNU+Z6U5jK6LACsIacQhs4cRQWS1k/0FXuWjEd2sKj69oPhtTxAkPmAICQnQtq8a8zcaxmb9SEGnvOesTd72sVblqdEaOlLpf2JHKXjVCpsmqgdew93ElCOTLgQLV+xK6LHFRCnBuv531VANzwP9Wm/8jTicasU/EUjuMoCkhdL3zM7Xqu6MZwTmtTM8IDq7SQvPL3xmKxfDFxrftrcMJ9LOsCFYVZPoynjZZvzOW3JCmUBUalUFIUqDxARSrJr2pn8yWO9k5idx2KT549Z+Yk8gyQ+Q0nHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtE7gUDkrmE5txvYqdHH4aItwrcC5afZotfP0zUjdOM=;
 b=kHOfosMnVDSZQb4Ks4JHMEa3fvOz86AYKRm9RGJpMBuaqxD2Ken2wJspw1D57VYFt243LvBGeOSMyZ1IMRfn2JGAOkhtgXgcWKDxd2Arn7g/3xtLtWI1n+Gw3pZq00wJm4/j2h4SM9S3nvtOnWJtwtmUUwZEa+Xpx11r0OV1P2D9WmWqsErniTnFgvsRhUBMk9Jd/hkGivZGN6Xpm7aTNoq/Pot41/hHlR0HeO5QDMPlD2unSdQjXOMFGvL6iUMlrvmZjKgJxkcmH/OUe8HDgBmk6Baebg8M5liSgdGa554eSE6yesTmsy/i59BIMCzGN0gThM9NPekWRrzuFMQtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtE7gUDkrmE5txvYqdHH4aItwrcC5afZotfP0zUjdOM=;
 b=Jp/rmcfQeBDUt9yeUO9uaMfn7s8VhxGznz4D8XcUCAPyLiTI9FwRtn+H2vxSJpw2cvocpfIzNVEZr8sZ4lSqr3AEaxu1lu76c81F92wT9WDEUeRYK63Pjt8nTEUo6nHP6imP5nBjvCw3DBI0h6+LMpmN7/gsQAeEm2WqGtZ1n+c=
Received: from CY8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:930:45::23)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 16:14:41 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:930:45:cafe::24) by CY8PR22CA0014.outlook.office365.com
 (2603:10b6:930:45::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 16:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Mon, 8 Jun 2026 16:14:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 11:14:39 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 11:14:39 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2 2/3] accel/amdxdna: Fix amdxdna_client accessing race in
 amdxdna_drm_gem_mmap()
Date: Mon, 8 Jun 2026 09:14:17 -0700
Message-ID: <20260608161418.2748988-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608161418.2748988-1-lizhi.hou@amd.com>
References: <20260608161418.2748988-1-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8e0653-8d5b-401f-e42f-08dec5790b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: F+21ZZYxpqr+R3HfTwXB4v5mx1XwQ9w1EkvGwxjF+5ofk+whhqA9PTpDjHoYGahMC3Fnrskv9gmWMEPA+V0KBZTJ9Z6Bvpro5EGHysbuqfgnrt21ad4HGapvrofzs6QMr36mo9QRF2gBkqLuHLI1Ikh0s2ndZFiRTF7UdJhMm1MA4QSB0Wv1lIrMI7OlUFvklS+q/5DHrdZROmXPHbgemIFVx3kcyG3ilpF0UQc6HDBbRBoh++ZKasesQxEVChDE1CjUmb1y9KeEk/fYnuqfAHbWnDNiPk6nw3/ENlz8agTIhq4IJq27JTwfY2KhdvfK/W+DSFetryGCBQ63HA6/V3ZBFqxIsa8pAlwBv1eumcdTmGob9RUnowdOwNzN4Q6qNnZlZOi7VhjC2EtwnRTBqW2wZlVT1mYD38gND4r9uWoUuv8+b6TMvxMG6/J9RbJFZJYhDywk2/6Cr/r0chuCw0yzmAbi5t2kfMfeF/JVR2O5Bbq8pf93eNO6XbYOXv8ah8Xp/GsFSaVYfOWD6/7z+4b5nkZ4TByAXyQgK1O6F1lhwC92TCaoWlDY8dSW9hybjGbPBVjKKGJTsLW6JbBy3DHfcJx3xJ5SmSyYGcEPuQUQpXCzcwGhsq13wfIKidi3mqR6+xI4VQkP8hd9RgxbN0JsOpluZBuZZ1YCDFnwCtxFC9Nomi1+fyaVI7mLO31BzeX5jqPpD8sKB26dcHBicq/9DZY/nluulRSq9VS3MmA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9WECwbTNzo6bRSWVQzscl8H3O2h6a5QUPTpDYJKJUyCPvzJ30Go8tnsOwTW+/bi5LY7GpD1CwltMoDDnznhm+p5ZcQYEw7tsuvSFO3gZdK9OwjYkAl6SXc4lH9VUVR6hOrL9m52iLfUNuokrShmbBqCTqcfv7gbUkZ8UAlbHtGdX289iugzS7LWE6eRrHoPD8ubyO2g/teQ7EoO1MvDOVaWL6vf7v+tH63Kd8lwVQfNYJiptg9f8kfm4+4qBlna8PinH2RpLBTIcykpTvJqk+6Z2Lh0Y9wISLS6PxNY1z5/Sdi+2b/Q5w9B5uyffk7dKV+dNjU8FUUJZio83+NCtI1n4BmxFASOY2B+lQ6Wo+m4EUjoz8S9J92ehho9NJbGsEPdB2OzHvZH3X7c/ixD1vF62JZGZh1mYW5MJ7CFyhsCCAlUfS36p6WIPwUUVm4+r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:14:40.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8e0653-8d5b-401f-e42f-08dec5790b1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

amdxdna_drm_gem_mmap() can be called after drm_dev_unplug() during device
removal. In that case, the mmap path may access amdxdna_client after it
has been freed, leading to a use-after-free.

Guard the mmap path with drm_dev_enter()/drm_dev_exit() and return an
error if the device is already unplugged.

Fixes: 91f4da826c08 ("accel/amdxdna: Add command doorbell and wait support")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index a22c986f1b33..c18ddad9f645 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -253,15 +253,24 @@ static int amdxdna_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *drm_filp = filp->private_data;
 	struct amdxdna_client *client = drm_filp->driver_priv;
-	struct amdxdna_dev *xdna = client->xdna;
+	struct amdxdna_dev *xdna;
+	int ret, idx;
 
 	if (likely(vma->vm_pgoff >= DRM_FILE_PAGE_OFFSET_START))
 		return drm_gem_mmap(filp, vma);
 
-	if (!xdna->dev_info->ops->mmap)
-		return -EOPNOTSUPP;
+	if (!drm_dev_enter(drm_filp->minor->dev, &idx))
+		return -ENODEV;
 
-	return xdna->dev_info->ops->mmap(client, vma);
+	xdna = client->xdna;
+	if (xdna->dev_info->ops->mmap)
+		ret = xdna->dev_info->ops->mmap(client, vma);
+	else
+		ret = -EOPNOTSUPP;
+
+	drm_dev_exit(idx);
+
+	return ret;
 }
 
 static const struct drm_ioctl_desc amdxdna_drm_ioctls[] = {
-- 
2.34.1

