Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7E606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XSPjxG+7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8068410E270;
	Thu, 19 Nov 2026 19:08:25 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DB510E270
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUNllb902R9V81e3xTOn17lS+CjuF67G9VEnKFaAoCKkvoD5A7JztFVjVZOXdvYzFejB3cemN3F2CKTa6MAas/ZcEBf3cOkHR/p0aO7ZzBbu3AKJ0gr6Ezc3qLWJtS+fL7UbN8Kky954iKFyqE7ZinVUUWkI7vxbKWeyvw8MLAmmhPoJTXLy8Z+ttRTjOEadUUMTRzUGDq07KJv4C7kSlr4fgOBE2Nni2yz7+EjO3ezikR6CjQOjRWSBOowH8StcROwHOXGxUE5xRR23x0Db8zTL9ZfC/prq0fvf2SkVvv3WW2AqXJRpDeLIfSE01vh+SmJiSt0Wx4OTbefWD/rOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV4z6iNbrbXClx9Cm27Mp+PzYUYPe71pKXKrREwGJhI=;
 b=Lr3gqai/BSdfTwV4qGRm3OAR+8xN2oc43/He48SfOAajTKGwIKmGhJB0ivCeUbp4Xbr+PNJI62uNMXRQo5hHrFvib27Judy68dpB9NAOVYnTAR3bFmVASDgock9s6gbIwjG3ga9IYYfptvLj3V1fPeik1e5h7lHhAJcIRxajg/0z2B2dfc6Hs4pbah1iYVk5U20faSTTP/XesuTNYci4X3NChoaTVGjELNy3RWpJD8/KzFbmJu+dwtROx7frEuwQqE2bSC3z39Z3DYPc4e5WaZ2DPHLBexUd366fXW8dGB3GuzXcbQDgg5YTO9K/DNXGU4KVVMZM2lSS8g/O5mq0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV4z6iNbrbXClx9Cm27Mp+PzYUYPe71pKXKrREwGJhI=;
 b=XSPjxG+7W2G8Nz7Jk2ajHE786MpzLIY92JQRlYd7dwG7pEzV6RZiLr9bzgYTcFAqQAp1ysaaJZT3PCng8CT1iEdd9KNTnwzhMM2dxL94h+NVfz7Z5Rr4VafB+vWg5WGdYTXUL7iFLQYOTtPsiXImG/6Jj9dSZPJdVDWOwUpok/A=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:08:05 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::81) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 19:08:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:08:05 +0000
Received: from BLRJANAIR.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:08:01 -0600
From: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
To: <dri-devel@lists.freedesktop.org>, <zack.rusin@broadcom.com>
CC: <linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
 <maaz.mombasawala@broadcom.com>, <mripard@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <jayapalashwin.nair@amd.com>
Subject: [PATCH v2] drm/vmwgfx: Fix UAF race between dumb buffer creation and
 surface unref
Date: Fri, 20 Nov 2026 00:37:05 +0530
Message-ID: <20261119190705.11305-1-jayapalashwin.nair@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: b31ed24a-af84-4904-96e4-08df467070e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|7416014|376014|23010399003|82310400026|261028144727099003|261022105027099003|261026140227099003|56012099006|11063799006|261102123227099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: p79w5Epa6nNcancHYYPAh9dSP1x8scu+syjyKr5C5bA+GmRF6TLRUOAglO27CaSyrdmmNIjctYCIO1CfrKTixaBQBhzzvoj8W2MeXbBjdzinuIrc8ydr3IUm3rjpqhCIgHCgrEtzxdDpGCPkXYJoNS6bw6wjX6odbfDTA3wlLMR7c8VeGYNJTQ6P8CHyESf7IBr/GBEqtJY5lIFDvr3MZ4m45bSal2oOAINqZQOcI6HBEByyHCBi97TE2o1w4krr9Lct9evvngyc0dmxBLG1aNd6rpqN7K6woB+N5yhiJpbS2+88rhJDXitysIsSN7O4Xs0eWejnY81O1yRjuLDRW335eYw7GX8dgZarK2EdeR5YBrsfWallG7i64QRleiHoOT1sazzN9FYJwBeEbfIggVW5S9h5TP+QkE3SJG5JNT5NFys0Kp8h7esY5JyP3obivuzNgqiFQt9+YXGWtgu9EhiFVdq7EkEUztwD3c6gSzj6odb4RBvbI7k+9REAz1uNQdPdOgrIWUm4gKzuzOifUd3cniSYuCXPh5IEu06F8DwQ51DHjK+k0HmDsxqcp8fpAFTcU7hBHxv/g6/fUFmZa2DAQ0/jmT1DQDPf3dridjBSvUP+2bFGhU6uGrZLF4fm3CBBKpFvNy5KUsLknQEIiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(23010399003)(82310400026)(261028144727099003)(261022105027099003)(261026140227099003)(56012099006)(11063799006)(261102123227099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q+Yr0G6O8jheRmhVBTi83RsJZ+5/dLxGR1azeMPLwATbZuX41mnzidyjbSIU0UZIus5QsHQ41mVEkjEexUcxVWRolSROES/xEOxV83XOSvVU22sTLY9y3YEtMl8Q3Lqy4hmZ0SZqnFEKP1ydEDl7JVciXV6d5CKuvcTakjvKI4oSb6OkMZ0PWe6AWi0efIYPxEF2DU4aJ6JPK1L8IGGWZp7OuNYaRiKyMN/IgYmOTwu+jSiM6AIbMhQ4Ank3+JNT6PFJJnGbAP07QLQVNU0rTV94Xgd98H/I8N4P5ZuLz7zwciK1nI7TIYn4AvQ/ORdMJgcLdr3rgb+s+on8YXOLVJkOGuQE478Gq0CUQLBfrOxFPHoTNsZNnOQVWYnNPh+sTahzCw6flKG7HOa/MoSK5E30CsZu8T1nvfm1s3TAx1GjZDqKxZhyDq37ABhXrPOl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:08:05.3106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31ed24a-af84-4904-96e4-08df467070e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
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

vmw_dumb_create() hands the surface's TTM base reference to
vbo->dumb_surface by clearing refcount_release, but the surface handle
is already visible to userspace. A concurrent
DRM_IOCTL_VMW_UNREF_SURFACE can release the TTM base first, and its
destructor drops the reference the vbo was meant to inherit:

  CPU0 (MODE_CREATE_DUMB)             CPU1 (VMW_UNREF_SURFACE)
  vmw_dumb_create()
   vmw_gb_surface_define_ext_ioctl()
   vmw_user_resource_lookup_handle()
                                      vmw_user_surface_base_release()
                                       vmw_resource_unreference()
   refcount_release = NULL
   vmw_resource_unreference(&res)
    vmw_resource_release()
     vmw_user_bo_unref()   /* drops the GEM handle's ref, vbo freed */

The dumb buffer's GEM handle is left pointing at the freed vbo, and
DRM_IOCTL_GEM_CLOSE on it is a use-after-free.

Take a counted reference for vbo->dumb_surface and leave the base
destructor armed, so the base and the vbo each drop only their own
reference. Drop the WARN_ON() in vmw_user_surface_base_release(),
which no longer holds.

Fixes: f42c09e614f1 ("drm/vmwgfx: Fix dumb buffer leak")
Signed-off-by: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
---
v2:
- Rework: take a counted surface reference for vbo->dumb_surface
  instead of only reordering the GEM put.
- The GEM put is still the last access to the vbo in
  vmw_dumb_create(), so the v1 GEM_CLOSE race stays fixed. The
  ttm_base_object use-after-free Sashiko reported on the GEM_CLOSE
  path is also closed, since the base now keeps its own surface
  reference:
  https://lore.kernel.org/sashiko-outbox-188756@kernel.org

v1: https://lore.kernel.org/7a822adb-ddb5-4338-8949-3ccb0942e0a0@amd.com

I plan to send a separate IGT test later for the unref and
GEM_CLOSE races, thanks for review and suggestion!

 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..942d2f39332b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -666,13 +666,6 @@ static void vmw_user_surface_base_release(struct ttm_base_object **p_base)
 	struct vmw_resource *res = &user_srf->srf.res;
 
 	*p_base = NULL;
-
-	/*
-	 * Dumb buffers own the resource and they'll unref the
-	 * resource themselves
-	 */
-	WARN_ON(res && res->guest_memory_bo && res->guest_memory_bo->is_dumb);
-
 	vmw_resource_unreference(&res);
 }
 
@@ -2331,15 +2324,9 @@ int vmw_dumb_create(struct drm_file *file_priv,
 
 	vbo = res->guest_memory_bo;
 	vbo->is_dumb = true;
-	vbo->dumb_surface = vmw_res_to_srf(res);
+	/* Owned by the GEM handle, dropped in vmw_bo_free() */
+	vbo->dumb_surface = vmw_surface_reference(vmw_res_to_srf(res));
 	drm_gem_object_put(&vbo->tbo.base);
-	/*
-	 * Unset the user surface dtor since this in not actually exposed
-	 * to userspace. The suface is owned via the dumb_buffer's GEM handle
-	 */
-	struct vmw_user_surface *usurf = container_of(vbo->dumb_surface,
-						struct vmw_user_surface, srf);
-	usurf->prime.base.refcount_release = NULL;
 err:
 	if (res)
 		vmw_resource_unreference(&res);

base-commit: 07940daf7b231273866376cc9657c09e47e7cef6
-- 
2.53.0

