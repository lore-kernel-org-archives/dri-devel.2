Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927FD606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xOZH+A19
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D820110E3E3;
	Thu, 29 Oct 2026 05:21:27 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046AD10E3E3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 05:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJbkr5NFXLZJtq9LEIWknxGX628DJPPmZGd/dQRpxN7GMVhpaeC2hjgcFY/gSH5MbntN+9EPUQc5xukyQwY+nfMRve4Rwkly6cWguMCeAyPOzpCDtnrmP93R49y5D5Cwvnv39M5P9vJnwCfRlgbzHh49Lt1+CgFCir63smjfITjoanL5KbsjKcRaUumBYqQVaVDBOoG4J/9aMWLPOe8a/DYaw41FoI3aICx5lv9uEISFS6CvFhkJ7fyESnc/TOuS5PS8Er+RvXJWdiCVMsuu7GZBKxOylSGV3kNr48bisfkxSrQqI71L5Odt5WikiTCpe3jMwz54Ra26Xzx/onSQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef4FMabItDVWDHgPgGliUZzCc67xZgvCPwDicY74vqk=;
 b=rTsbbDYrXXwFB//ZJa4Fv0XTvHcJTUVPsQr02pXluiL06q2SjhwMlWzSmceukBhZNXIzgrGG+ZXDhcJGDyNpvM5j1a9aWu7u9pGKcIiUfFdEnH8Opiyj6Eq0C2i3qraXi8+9Sp3WIF6f3PXUKXJfd7NDgCMZjs2AjDhkh9Vez0E6boCuDHwETULaShArX3lBcVgkMr8uBUdBIzW8eu6Bvk7JQx0fN70U2Bm2XO1iT/izTn1WFF4qJeD4JFQM7qj/YfrsyTT+rO+y2fXNSa64L536oVAWAI9yA1MQpGlW+6eWi8BYRuBgSuFV23hYw7trHQBhb2MGF3KYb6yAudTqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef4FMabItDVWDHgPgGliUZzCc67xZgvCPwDicY74vqk=;
 b=xOZH+A19wqEHHSR6Ap7H3trps9dss2w+ajSAxIcj8xqkUxGQ99IIwCSXAXoX18qZENMlrUy9+SShdmh82XysnyqyekkYrefUDRdAxuGBypjfukFtnnBjG/QmrMmd37WXLnFPA9hn3h3wzNQ+zvdFzFMrASdSIHA2eeQcBGy7bUw=
Received: from SJ0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:a03:331::9)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 05:21:17 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::31) by SJ0PR03CA0064.outlook.office365.com
 (2603:10b6:a03:331::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 05:21:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 05:21:16 +0000
Received: from BLRJANAIR.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 00:21:12 -0500
From: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
To: <dri-devel@lists.freedesktop.org>, <zack.rusin@broadcom.com>
CC: <linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, "Jayapal
 Ashwin Nair" <jayapalashwin.nair@amd.com>
Subject: [PATCH] drm/vmwgfx: Fix use-after-free race in vmw_dumb_create()
Date: Thu, 29 Oct 2026 10:51:00 +0530
Message-ID: <48e6780670395107cc9853bf63fa7ac1d034cdd7.1793249917.git.jayapalashwin.nair@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 9beabadb-7e76-4a20-9f1a-08df357c750d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261028144727099003|56012099006|11063799006|261009223027099003|261022075727099003|261009221227099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YUVKROhTafEunpCtwj2WxEvm5vDmapYddeHkaYw7Fgbo3ZqWjF2suCkBpwtd5aHxZP9YFMlql0jjibxr8ILk5JLXQz6Wi6aC/GG6cpXnXzpfR1ASBvlRblGcz0OeGjfkze5swPs4jggSd2jGHINm4JxQzI0EtIgmCop2p54zKGTnYdSZqwBqNqD9J4JA0TivdDu0ViQ9WcVkmpYkKqtP9kteUaANcQqoNz4qlhVpYg5x9apcZOrsLX2QEK8VFC5/pmJbl+mc24SSw2IF6I68+niU0ZfpuWdZgC6dt5jvsCR3/+bVIxm4SVo3paJEmXJBndsveL2h54RJ9uSSV+ymrv/UODhGzvROD7gZLBBD5TzKqTbQjd/PfXXnpbe/OUVrxmZPkypRW/ZWVawJ2i5ENn+QklGoGtSgO5QbfFH3t/IhD5NG/KEcTa7an4grxN6DfLcoJbagTaFX0mJ4kjT9umSSC2hCzdbgsG+T3ZUrmL3ZmL1jPf6GxFnDFQnTWPClQtDTvjVLqdSHQSrHHYePeYQpDOUdMNBCYKUgHpFPbC10mfby2CUSmQTIkt+iIDfHPAL20kxPpSrED8q8yhngkCdAdu79GeJnraF8ppHny9NomgTgwXx/KfIJO8YhmZs3aEjot9gbhTD8fNqxTDQEEby47xrgJQZZ2ZdAQl0JZ+5/dVC22lKAuK5oCrCxccr/ya/0486IPVfR9f3YRXd1cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261009221227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iG5fOq51p3O35HfT/gOZ1EFNgMYeiKMczZSIk+dVFSpvhyYaW+UywcMd1gFjbXTePo1LolgNKHFig6TRPkGwI1gUMZYaqeUp/qxlAjTynbP9mNcTNH9LvZLL+My536gfFFhKm76aY4Cj7M/NS/gSlFU3bwFum1fazKHDWqS6XGwxizan7gNgv/NndbLELnHFoWs1jletGxt6bKi/AH1cKGIfwLhEEtZOcPdMyM14gYJoQWmQ19MvF8Bczc3UZHTQyqKpqntZqoVuS1dDdtB92+YqZAU4lIRnl2Uu2MGyCyOurl7xyU3ifWV4xMz96Q0hubdw0fYVp79dqo+pUhXc+Atsc7i0OOmKeLlKb1Gdu70fCpVqaKvzO5Hzg5b9ROlX6+B4aPge/nsmOCjsPaJ657P27yJQFodOs6zvk3MSWzf4tKBZeqEHAHH8No8Qggpl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 05:21:16.4676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beabadb-7e76-4a20-9f1a-08df357c750d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

vmw_dumb_create(), called from DRM_IOCTL_MODE_CREATE_DUMB, drops its
extra GEM reference on the vbo before it reads vbo->dumb_surface and
clears the user surface's refcount_release. After that put, the only
reference left is held by the GEM handle, which is already visible to
userspace. A concurrent DRM_IOCTL_GEM_CLOSE on that handle can drop it
and free the vbo (and the dumb surface) while vmw_dumb_create() is
still using them:

  CPU0 (DRM_IOCTL_MODE_CREATE_DUMB)      CPU1 (DRM_IOCTL_GEM_CLOSE)
  vmw_dumb_create()
   vmw_gb_surface_define_ext_ioctl()
     /* vbo refcount == 2 */
   drm_gem_object_put(&vbo->tbo.base)
     /* vbo refcount == 1 */
                                         drm_gem_close_ioctl()
                                          drm_gem_handle_delete()
                                           drm_gem_object_release_handle()
                                            drm_gem_object_handle_put_unlocked()
                                             drm_gem_object_put()
                                              /* vbo refcount == 0 */
                                              vmw_gem_object_free()
                                               ttm_bo_fini()
                                                vmw_bo_free()
                                                 vmw_surface_unreference()
                                                 kfree(vbo)
   usurf = container_of(vbo->dumb_surface, ...)  /* UAF read */
   usurf->prime.base.refcount_release = NULL     /* UAF write */

Move drm_gem_object_put() after the last access to the vbo.

Fixes: f42c09e614f1 ("drm/vmwgfx: Fix dumb buffer leak")
Signed-off-by: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..2dfbd914bdef 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2332,7 +2332,6 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	vbo = res->guest_memory_bo;
 	vbo->is_dumb = true;
 	vbo->dumb_surface = vmw_res_to_srf(res);
-	drm_gem_object_put(&vbo->tbo.base);
 	/*
 	 * Unset the user surface dtor since this in not actually exposed
 	 * to userspace. The suface is owned via the dumb_buffer's GEM handle
@@ -2340,6 +2339,7 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	struct vmw_user_surface *usurf = container_of(vbo->dumb_surface,
 						struct vmw_user_surface, srf);
 	usurf->prime.base.refcount_release = NULL;
+	drm_gem_object_put(&vbo->tbo.base);
 err:
 	if (res)
 		vmw_resource_unreference(&res);
-- 
2.53.0

