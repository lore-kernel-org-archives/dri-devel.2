Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FC9FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C414410EC1D;
	Tue, 28 Apr 2026 14:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="snChwm8/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2B410E110
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 14:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oONUpAJ/IkLx1ZRUDVaCRkiShIHF00GyyVs+aqqK8UyzTYL2lmcztrUjFrYA/xDhoxTmjf7nZO+6EYwh3K6LBmUW6hefLLPgVLlhohzCzSVXC1FTpwwhlyhaOi5SEgCVJWexc/IPigyyHy+V/JCv9Of+om83JW8xBziXAL2L2v9+Hnd/TRVL4Y6N7sSxHcip7NVYBWk7J6wITHHflyzjQZbAxlMpeSq8xZ1e08VToGurBkJ7cSN9x/+SdVuTBZP2W3Dww7FZGyd6CgN+JZzsuBnBWPgIUuLVVr4mPEHcJqoIKvJSwtKW/p/HDEhwiOCC95nYb8dDr6+6oPfDv2zyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JISOuXFUFeYdIwH3bLoxBOK88ZZ5I8K9XY54ydtK4OM=;
 b=HB42Xpfpfiif1YEVK+wgJMw6X058/yTxxtPq/+ODCyDmKNfewOVojnwlX1kMdJ5azvM4VF1+zeoVbGkRd8RyxnKcbMyTwBSxvEK8a3l2AYYcMp53wQ92YAoCNCse2fLRCcJJi7KzYzvDVXo/nKIaM39+C3lXQGQOc2xVg7sk9n+RDYPU+OiPGJT0rv+M7J3yPBC+hSvOJe2AwCSXTwFKBcCaBerk6/51Sm/SGKPZZt54H8L5YwdRKpzEJ60ZDti8On+/fJ8kWy+XpFTMgxfSg6NFoxEukhT3XxUUxrhdzol+Y6rJcPEJGOF7iRlzP5httmYsVDlgy1bsQyLIUrdpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JISOuXFUFeYdIwH3bLoxBOK88ZZ5I8K9XY54ydtK4OM=;
 b=snChwm8/dNCm9JmFX9yUGEecUVlEmPBBBPE9vHnweK/nSxgpLJ11sDVerNUuYvvYjPDGpLZoZ+wajWu4sjisJGa/skezq45BaM9idLyvk4ArKHxXJxnRqlo+LVQH+y93iadzPgAB8oCamlV3uCXV116YrrCt6MiyygRIUcsQQLw=
Received: from SA0PR11CA0072.namprd11.prod.outlook.com (2603:10b6:806:d2::17)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 14:50:03 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::50) by SA0PR11CA0072.outlook.office365.com
 (2603:10b6:806:d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 14:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:50:00 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 09:50:00 -0500
From: David Francis <David.Francis@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <simona@ffwll.ch>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH] drm: Preload IDR during change_handle
Date: Tue, 28 Apr 2026 10:49:46 -0400
Message-ID: <20260428144946.318274-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: e390b5f3-ff9d-40a4-8746-08dea5356cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cWFtussfIb91Y4LhVeSzP8DIbomb6uCBb/MFUccVEqdEI4HU6wpICbsH99yNI2SioZ71qMoezzcZScjk/aegQ4wIGGGkHgIKSPEGJeykgltNHdMz4bst8XJP8O7jQqwaWomWDB4fhk29It8Pp1FOY2Q9MViSng4+VZRjfqB/kK7UwqXP85IAp3oAEsB1vZpaO5+Ahh7pRuYwMNaruf6ACu+GYA8V8YT0kribCumpejM5XknEI9AlAjf/FYHlKBo/q9Cfjb0u/nyq4zc4RLWIThWkunlykCvemvVYbrBdOe/O+C8KwLuM88j928jE5O4/IMXLt6k9kNtbAB4+xiQFWmV703RW8/EouCrhCHLQYtZk5FDYaV2NkOuR6IF7FQbIOyipWmhjuyRtbjCk9XAXwk0vSYKOHtDGmTyVEh3ExV+23TNpeoImMwPka1yMS5IOTOY09cJvUS1f05adBG0WroEglVrSfx24JXCulxrgB7X/l0jnEPwobN5fjwZj3wwG36OO7e6YTyUMzCGTOlH8sRFdM9h0pJKpjab09olIHTtOq0wo0xysZKaGxfTx/fBCR1aAaVOMuV8U50jqZ34qlHUM2dDKPBGdSGCxwRwSDDfII3KsI69BbJzQYru3wJUAPbrEekakXBtNUkKFiVdozYoqQhiGF0wwX1proDx0xJXbQwVLtMAHQ/grVEItg9Hc3ExfAAwM47OFBRe9IvkqCUWuFP9uPKcc+ehKdIQFUIp2p93J+JfTWvu4H5SP2l9xMP0GbsPLMK4xhofCV5P7NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WjGqtvDteBK4zRcUfBTbA3/yDeuQd4mXT3KFbcxuCAksDYQ4woBd7kd1Q5RTT0CgaVzJMELeOehXNk+YaxEL+gqH1ssiUpNTYukgIwk2OUfJnftjXBegEloH5cvzLsNRVeFet0YogbJXfdA9rmi8vpguZYyTz2HdmAEPvFZbWaYTz4Ibybwp2+2bJTXifQnHFB6xti6a7swGKorVot+bHB37CwdjJicwwZDWEYPCPc6wTJ3ziVArqn2tqPZR2u8MRP9xinpuMZRhp4xNR0tCPhRrB9hUroFTOdfLte25Us0M6KIX2pXYSqzW+YdvOP8gsTPuiZr2DMZVxAuk0MWGJ9BJqHA5fxc09A8WB71Qt8/9WsoL1hySDhS+v3HU4HNqrjMmqSHRVI646ZORdeGoubzO5wVGpdubCBe5SNKlt4Dpg1463K5dEK9deSax9A/f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:50:00.9138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e390b5f3-ff9d-40a4-8746-08dea5356cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
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

change_handle mistakenly had an idr allocation using GFP_NOWAIT
without preload. This could lead to idr being unable to allocate
needed memory.

Use idr_preload to prevent this (as in create_tail)

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/drm_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 3985def993af..251048d3a3a7 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1039,10 +1039,14 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 
 	mutex_lock(&file_priv->prime.lock);
 
+	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
+
 	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
 			GFP_NOWAIT);
+
 	spin_unlock(&file_priv->table_lock);
+	idr_preload_end();
 
 	if (ret < 0)
 		goto out_unlock;
-- 
2.34.1

