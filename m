Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4C5CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF8510E715;
	Tue, 16 Jun 2026 07:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gEeS7Hnh";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 678F310E715
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 07:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6FGyOpTkES5iNidYq1h8fdZKebSG1J0wBcsS5YY4NiZgYCQEojO53TtClPzW8v9PwqufwXu2qgfupBYwSj41CGIcEonKUW4jytjXrV7lk/sQhfofUKVu6hWxBUW/TIxU8Ew8meskdaO5gYTB4cSXZEJxWR+p2sgGrIWuwwf8qr4DjNDU7Dmhp49ND0wDjMIWF8lvL1CYq/Fa8wmGMjMcb0hFFkrzPTPcI/R5qI+SdkfHmFGBIZgZGnz89Vr1QtEwpEE3849RE6L5Upwv9j/WuQkXj5OVfbDKW40Ezc9NhRjIFdm/4orxXaTly2oIFL7p7SlgWs4Zh3qbtbgCxaEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbxCPs4dkSLZJGLSV90pdGg8Y2tOgre8hyjMw9gk3fU=;
 b=JIt+aPEOgv4NBMFatILo2lZ8GxME2pPvlxRLY0yfd6vpt3Y71ljm4niJPFxuQWaH6uKmZxhn+W5jaPTjDSxQlw0a95UmkVlVTaVVOL9TihzOjRopy4vztrPvnJMyfcJric1b6vxM+7+k91ci2dMTVdTXP4c7kO45wzJQ+SKz2HYL6a+1fieO7K5ej3aPIJahVRw7m17Ir2RdcNLz7FtNIYlUVsFuT7P5s/0vPgPoGqmVoZxUIf+wD3ZznafXtW9VcsbZOCipe3bNuIJoZOKR9yGLLpyYWnByCNXM0FyGq0krbXfv7u6taXf+sWotwWdxv7Qp3xbQZ2CpSpAdB+czBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbxCPs4dkSLZJGLSV90pdGg8Y2tOgre8hyjMw9gk3fU=;
 b=gEeS7HnhRedTH9OmnfSb38oKE5N3a6tA9xSMJvvqlPqO79i8TscBkzk61eXNUgWRuT7hik6h6QXLShYxLXgMaFv5IxQhibQbcXlR+s5jv4ssTq3C2OJsZ98rpEdqVneXpV1ZuOSffHXKd6O6Y0Wcg2gfLJ9AU+2OGpkHGaj/JI8=
Received: from SJ0PR03CA0269.namprd03.prod.outlook.com (2603:10b6:a03:3a0::34)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 07:35:59 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a4) by SJ0PR03CA0269.outlook.office365.com
 (2603:10b6:a03:3a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 07:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 07:35:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 02:35:58 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 02:35:57 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <shuvampandey1@gmail.com>, <karol.wachowski@linux.intel.com>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
Subject: [PATCH V2] accel/amdxdna: Prevent PM resume deadlock in
 hwctx_sync_debug_bo()
Date: Tue, 16 Jun 2026 00:35:55 -0700
Message-ID: <20260616073555.3548595-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: d30df2dd-e3be-4d6a-7b87-08decb79e8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: +9nkEkMtXJpK0aaAtl4g1RoA1SbiFoBntFO3gzyIMuOlPlylbr4y7Zef7NsqurYBQ3PPYgbecI7qDBwDkO4DnQd7/OMhS+ep6Z3+8xpTC3+2huwtJmj9QOMFybGJD8B77MMzfEFsnfz+76JIzWaorR95JdlBy/V5vHMR3KlStjhmwT2DYT5CjbpBwdqp5tLQHikY+YQnxAcsmAKKqdlT80o+Lo2G8PzxN7MMJspou7U5E16Wg7w6Ua/5BkHNnR5XMlLIVQKYcCzDKlpXdUCQsXO7dLtAN6SkyJeBS1YkL3QWpPtvcmnyfJI5/HIeqHQ6DhXi6BAxnAussyauc3vRG7Rf2NGIDk0lZ15T3pENWJQNZhHibvip11U4Mn9aq2a+cnhxEiV00lJDGCdGAlDOoYdQm2zoKIkl7j1KFkpmcb0HwAa6n1j/ogQa5QYmIKiDTo/ZBBxgOVx7erCvQk07xMJT4l1k81JmeFpSQaZKslMiho7VnpcY/62rKBsSDUP8R5IUEweymeILuNJpgAjfqUU1aqY31cavX5Ygvr9Gh2Ovwmi8HVuoFEPu2rXqe6hn199V6IGBveWBOUiRVPznscSnarxBCpaozC1Ux/4iFQSYuQ/KTeHgLYL5XOtfgWlInyC6RlZ96fQ4AegjqTPLbxsBHL0TPthFESMr5L77bVJbBzfdnKKkRxxQIz9FyrCehKK2jLXK1sOGRmuGA4JJcC+RjP9ZvrV1LelRnktMAFA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l7PYZ+i9r8Ykxjkqk7hFHYF0Y/bNQvkiMDzKyx3Qm4U5iHrPfDYt1F8Izn/f1k3nFMWD/07VGuY14pxSTyxlMvmmFBLw1E4Ae3OwSfPBz6NqdSQrjxdBkuFcnHpeqU01OwsiZhZxsIrQ7RPWZueAr+K9sWsIxVvIG2kvG3xHX7puUZ0Mjdb0OkHCXVrhT8CKRXRSE+3pI990KD34PzVzBhaaQay3HadIp4GKJPoeU+k/ROxjkHOQsxxs2dEaVCftSey2ww7Pdki+pbs6ezbfPdeAOeFUnQIGawFQ/TXgvGsRZyKa7jyaLPfHUqVnR4gdmxsOL1cP/7JeDhhwPafGUzby/Dv21NdU7aeCaeDyVL+2z7DgTugMNPqj6YdZFaDM3RcsjurZQdCbjrxGVxVUUFG2UEZXP0FOAVlA2toqtWXNOmE9oamU/XgBHU2d8hv1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:35:58.8164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d30df2dd-e3be-4d6a-7b87-08decb79e8b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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

amdxdna_hwctx_sync_debug_bo() invokes the hardware
hwctx_sync_debug_bo() callback while holding xdna->dev_lock.

The callback may call amdxdna_cmd_submit(), which in turn calls
amdxdna_pm_resume_get(). If the device is suspended,
amdxdna_pm_resume_get() may synchronously execute
amdxdna_pm_resume(), which also acquires xdna->dev_lock, resulting
in a deadlock.

Avoid the deadlock by calling amdxdna_pm_resume_get() before holding
xdna->dev_lock.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
V2:
  Fix jumping forward over the guard(mutex) declaration.
 
 drivers/accel/amdxdna/amdxdna_ctx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index ff6c3e8e5a15..2f3dfb155d1d 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -386,16 +386,25 @@ int amdxdna_hwctx_sync_debug_bo(struct amdxdna_client *client, u32 debug_bo_hdl)
 	if (!gobj)
 		return -EINVAL;
 
+	ret = amdxdna_pm_resume_get(xdna);
+	if (ret) {
+		XDNA_ERR(xdna, "Resume failed, ret %d", ret);
+		goto put_obj;
+	}
+
 	abo = to_xdna_obj(gobj);
-	guard(mutex)(&xdna->dev_lock);
+	mutex_lock(&xdna->dev_lock);
 	hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
 	if (!hwctx) {
 		ret = -EINVAL;
-		goto put_obj;
+		goto unlock;
 	}
 
 	ret = xdna->dev_info->ops->hwctx_sync_debug_bo(hwctx, debug_bo_hdl);
 
+unlock:
+	mutex_unlock(&xdna->dev_lock);
+	amdxdna_pm_suspend_put(xdna);
 put_obj:
 	drm_gem_object_put(gobj);
 	return ret;
-- 
2.34.1

