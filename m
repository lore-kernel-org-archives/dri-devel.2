Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2FACA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 01:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA44A10E22B;
	Fri,  9 Oct 2026 01:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAGI83C7";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E9610E22B;
 Fri,  9 Oct 2026 01:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5AJ/GR8c194URm78i9C3vJn3Cttwvatb5GxAbciI+6P9QyO1smUtx0XUeGs0WMBldirVsTxRb5T1P1fJiTsRixmseCNl6s8fx689sVHs0E+EPQvRvrrU9dDPjEC3eebjGXy1Q1bT94qeiivWKx+gLfnui32a7dCE0fpcXBpcyiZw0F0fZ6SxlHfeRdmEz/oEECI8ZRSQiOvg9rXQF7sbio63TBevY9H2DrNqEDAs/jwnKMsBbb82RtXMo/nBgBZ5mVBUdNa4S34qTC7hIz5ajoH64m9GK81SXSjhHdQ+34kKHjO964LjjyWXxqBd73NP0kE5cze44F2FY1Z9T8O/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gls0ZQHuhoRViMR6bsJZEvXPkbAcakzernBkIPQB1F0=;
 b=qlxIsVJD6xcSoSn+SnM2wGPo4YCsATUKddJXrhg7z9q47NRWmCCQFxgHbMFU69wDJlxEqyoioPOx3ITuno9PWdSYwNyBxbNlsoCJ5IlKj3WcZfvJd0yyzj1bGLTtrojAcQNT/hLDN9LyYsXdg+uhugypCRugQHW1DOynmE7ybxsZ67vCjaffTuGni2UA9GEyDXTEEXMXVpibLvIHy9C8GvSVP8i2WE4cj1j3feS85zgeOJiT62LuW2Jo5S6zDPSrfucrd9+4FKktToiVu9w1L+1hrSZYNWEJu3sHvnr0jrIZPCdSTXW/APEuQY9/iLB+Z3oYyMegf3Kftw+b+V76+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gls0ZQHuhoRViMR6bsJZEvXPkbAcakzernBkIPQB1F0=;
 b=VAGI83C7IwwXYzT9gWq05a76qKvH7hAQK+ZYftG6mZ2L3Hbuuh4CxhutEaxWLr+Mw+cNVA19WZ9fgXVRjpX1DU/RNiXTrKL8ydEFqHyYaj6Kl/uMaTNfhUWS99yey8uuBzREddKzyium/quVpA62ZtHmuXeBwpQiOB7UHTDcLz8=
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 01:20:05 +0000
Received: from BN7PEPF0000009F.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::92) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 01:20:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF0000009F.mail.protection.outlook.com (10.167.248.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 01:20:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 20:20:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 20:19:53 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/ttm: return an error when kmapping a BO without pages
Date: Fri, 9 Oct 2026 09:18:35 +0800
Message-ID: <20261009011952.3925146-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009F:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c108ed-fd21-48fa-548e-08df25a3734a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 3bROUvCLqlna0QEqCoBnL/3ef6xhN0/pBiEUXXSBxt8KT7k31zzIXgHhNXAu1yamdOdsqCd9oS7bBQC0hKLRzpwjfnFoLHI+0EnsJpWeQJP8Sfd2yRYWkyXBjT0lIoyFDFVf1K8LceQTPnLpV9fMVh/x1JZGcb18P4OLGmbcWs3TF3mxb4UgIoim9zjG2Y58T7KbbkapUDLVhNjBJlO+DZnbiP5y1dgNqCfbWBP9Ksgr4Cs5cm5PJJ6/YjuSYNZcChHzzRIBEScCfA4OsBYQLFMtt1L/D7Ia6xxHIxH6dZTAv+nFZLddkh2ar9uFGSBanN0l0Dy277LaNO/iNHODyupj4qt1rOGH9cIPkZAH3HN90fv9R9YQ53nvHK202dmi4V+BUqDx3+2lYiQuLXQJ3TAKimKmS7wD+a1KXESGB+q01E6aF+uKeSQ15LIBUznikacXVLmM5nIWv+ReFpuH4d2WAqguwhotWzCStPCFhFxs9nSvfuvc58VLPctamDvPLbqWw8/RCkwfypGlxF0qkug4Zb5aKmGMJMiQY38UsJlDkc57nmo9i83e74o/etdD06rMdlQLs+cU3YVfhoKJ0Dgscryk43tHaE4szY+ATYtr9jf47HRPDfSFviDMHCcUtllOeJ9VqJSBQrpheTUGyeW4GiJsjEslppF+L+Ll7etXbZHjxgl7FRfMgJksoHxyxWnFglRJAIfmPG236CJ/ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AoVi0biXoKraHX7ucVMRqLFF9dUb3NZwNwqXKL8sugfiBEoY8qaxJlVe9CWFb4hsMW6CVF3YeMMImssLCfPKXuJ0StlZPdqDLNsE8fO8azpl6ChDb5eHKnGaw3GZ9MijYb4Rz+l+qi9+9UBipyznaTPNoTc1dXtZ+vEizAl7ywaVUk/AGzWswbxpnyIrVodfji0vC37mVbnfbGqr05mUPGsy6NQU3FxVDi5uDffsoRqQRLq+IOSI2Ku9hyxRAtgsSPLy+Wkq2BXbbGdbbcCnVHpbdM8rc4AJwwNNnqm6fz9wdZ1uFUP2nm8PPNH88U5vEU7fpu3/jTcMnLGAk1p5i59Hm0kbX64h/9oszR84Pr9Dkl4dq6oO2dfH/RJrELzSCKWkV1xkfibb2CvfiaBw2HZU5aqO2ETcKQjl/tzvjNUk5AOYk/2g88zs2/wCxAVS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 01:20:05.3616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c108ed-fd21-48fa-548e-08df25a3734a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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

ttm_tt objects for imported sg tables (ttm_bo_type_sg, set up by
ttm_sg_tt_init() with TTM_TT_FLAG_EXTERNAL) only have DMA addresses and
no pages array. ttm_bo_kmap() and ttm_bo_vmap() still dereference
ttm->pages for them, so a driver that tries to CPU map such a BO oopses
instead of getting an error:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
  Call Trace:
   amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
   amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
   amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]

Return -EINVAL in that case, like ttm_bo_kmap_try_from_panic() already
checks for a missing pages array.

Fixes: 75a57669cbc8 ("drm/ttm: add ttm_sg_tt_init")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 3e3c201a0222..83142bfa3bc1 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -356,6 +356,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
+	/* Imported sg tables only come with DMA addresses, no pages to map. */
+	if (!ttm->pages)
+		return -EINVAL;
+
 	if (num_pages == 1 && ttm->caching == ttm_cached &&
 	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
 		/*
@@ -419,7 +423,7 @@ EXPORT_SYMBOL(ttm_bo_kmap_try_from_panic);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_kmap(struct ttm_buffer_object *bo,
 		unsigned long start_page, unsigned long num_pages,
@@ -493,7 +497,7 @@ EXPORT_SYMBOL(ttm_bo_kunmap);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 {
@@ -537,6 +541,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 		if (ret)
 			return ret;
 
+		if (!ttm->pages)
+			return -EINVAL;
+
 		/*
 		 * We need to use vmap to get the desired page protection
 		 * or to make the buffer object look contiguous.
-- 
2.50.1

