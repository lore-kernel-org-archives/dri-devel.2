Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C798BCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 07:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B16710E36D;
	Thu, 14 May 2026 07:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PvEVEimr";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4C410E36D;
 Thu, 14 May 2026 07:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7tzRUOPQ+tmPY93/kmo/E3kb41kzmSDQEQBNZ5Qv5Bb+WnvygVHeAj68Fcr18MGl0A258iR617BLaCzerNjbeWdZmxy8bXFd8FnfFnxnhSOymBQ39YLkg8kSltyJrGr8ZOX2kZcqtW2Qfo+iNT5kt6SwsKtNL05Ok7CKEMIAwRa2rb1fvTfpowQ2Gejtj6C8qx4IZ20h688CeUaydCpJl4hekB7Rc3sAMvmLi81m9eyEGOw9gwmU+VBT8xSb8/tBEeMYWBlGfkVcw9RwHYE2yegTw5aVzhMw4kmdMWq6H6f9uvdEDcTyLIn+uQATmjT0PNJNbWsdlYHTNnQAJDqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyEndAKgVlXRNu9Xd0EJb0kxMPwBMmkjlUwg0Mzus0w=;
 b=ASgS2yQL7W7ssbA5j1tFiKLLreo+1eAP9BLvg3dorq2t4QGspKqdBZ/mP2+aTRkSHlXROzm0n3JSkwAMjDiKIaUNKXbRuFuesmmllzmDhfzb8uf41c+1k51boMoQBASziBoC1qzSMpvBGRTSeL/QLMpy/HJSfi7SNrMCjoMshZU4x88KLKszdUwPGlasmARyj3J9wYNc8JIfo/OlXEKg0S5K26jtEzYua6n4ouc0c8dc3+9p6YMDym2lRtPvFXy4TjLT2lGxSNXbliukHwPzTVar7D+By73mNKbvce90c9USrdocAlqKaDHLLMjQxHTOAORIv9JG0AI00f5Te/fbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyEndAKgVlXRNu9Xd0EJb0kxMPwBMmkjlUwg0Mzus0w=;
 b=PvEVEimrLL4bj+YrEJPmITevC2QxkBx7EnC09TP12RMq62UAD3OOlamYb0msCp7zfMxKxxni8dsvxtb01+4ZbmewJonHjAGqsawlzQgNq9WcXeuhccQmzdkiNnvGVQW+de3mg796tKgbFaDn9l2DJX5wjrAV/qLBpn74t80zUaE=
Received: from MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 07:33:30 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::16) by MW4P223CA0030.outlook.office365.com
 (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 07:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 07:33:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 14 May
 2026 02:33:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 May
 2026 02:33:28 -0500
Received: from junhua-PC (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 02:33:26 -0500
Date: Thu, 14 May 2026 15:33:20 +0800
From: Junhua Shen <Junhua.Shen@amd.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, 
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, 
 <Ray.Huang@amd.com>, <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <simona@ffwll.ch>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 5/6] drm/amdgpu: hook up ZONE_DEVICE registration in
 device init and reset
Message-ID: <20260514073320.zlab32baqmazp3qv@junhua-PC>
References: <20260513095734.69598-1-Junhua.Shen@amd.com>
 <20260513095734.69598-6-Junhua.Shen@amd.com>
 <901369e4-9763-4477-a908-86ac8d77cb4e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <901369e4-9763-4477-a908-86ac8d77cb4e@amd.com>
Received-SPF: None (SATLEXMB03.amd.com: Junhua.Shen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e88383c-ae18-4583-9039-08deb18b1816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|4143699003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: lXI3qtJzb5tgs3PSZaqylEz/uAMzIusarLtw6OODGPBrv1lvdB+b4puT5OnWKqEP5bTwDkUVBowvOVUsxUcZvwFi0rTa4/JMDuLI6M2WuiuvZoC1w6e1rszPNyuc0afF2KMHG8RHfTQqGjFqF1VcPQR0FddwoYVp/yzKVebF6TCpq/cQKypyKRijqtJ0CcDl3TJ7XyniZHokoasfiQv/QAw+HcxwY9rNV3mgdL0tMaOG7ZRHFd8f/q5Po8PLgL5EOx14p6aYaDLvv8VI+ba57/V6ykgg5GzteEw4X8VRDMtMyjniDcmhjpKY0aLEjFIdNXTsntZzMp/EO16blHHa3k6jSKxSJ3OY2/DQIOiFnt8Z3NeaHf4CigChrKzAJ9aeWHoMfQBFaI9My97AclmlwycjmGAo6nuv/1cd9mnAZw6G87Kc59pX7ahK35t7jbwN/KBNb1pBi+EZrgYO5lwC8wzJbn9uzyeAsWY/Z1yDFJWcsWnrQvHDJeo9ebt5hrj+Lw4GJQbZiKuWgMC9yFfv1hSOKsXLog0u+yYY7YL9zvI39i83sbAVRODJpTM3D2B2LQb3NoPMhx2bifoEbgqcpF1X/aZpvk3wwJB8uKGqpAMkrbhOBMpDs2Sy07W08Ff/xhiAeeYQyKO/SXW2IIS1FrrTfkgNVU50Qs0m/q0Om8IZDN+IFyFWW8EiMv6InPy9ZuVGJTiwfM4Kp23k2+Zx4E3xSxLPABs4hmiV3DbXb0I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(4143699003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YYFxKR9XSVrCwE6Z+v3GmhjgsJW3nimTK66QvvE9YDYBxbm1qi18HcgtnnGON8GC4nS+Lqhb43kQXvxYeuNIE8mcfGo6BjtP72t/UsJUYPG0ry97WTiBZNJFXNjOkpB01OOBlTRRZjGXgYeHRL/4FkabBXTBZX3YzL7/1RaC0qD0lXK4nsWCVEsvtRnDxelf1hbdn9h0D4w8RDp1VKTxgMfl1p85kAeTVPgBYsKFhHq8Bslvjarq4mBU+eSP47e6vdS1uAZN8wtWWcZDzMyjDSAA6Q2Z+fwQ4a1+pKLjuS/xuERhGJcFME5pj5i+qRvNYEBuhwHku410ocq7dDqoiHBth5nF1nwcabuoBAAdsykDgTDB13eOv1+chcMuNR+ywh3PXYvj5aGoKC3ZZqkVvNKtUnZ6JZxtr3JcPsBd0hZe8LVWh/ckp5hHA8N0hm+V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:33:29.5182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e88383c-ae18-4583-9039-08deb18b1816
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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

On Wed, May 13, 2026 at 03:47:33PM +0200, Christian König wrote:
> 
> 
> On 5/13/26 11:57, Junhua Shen wrote:
> > Call amdgpu_svm_migration_init() in the device initialization and
> > XGMI reset-restore paths to register the GPU's VRAM as a ZONE_DEVICE
> > region before KFD initialization.
> > 
> > This activates the drm_pagemap migration infrastructure.
> > 
> > Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 4 ++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index fbe553c38583..3be51a2c0106 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -78,6 +78,7 @@
> >  #include "amdgpu_reset.h"
> >  #include "amdgpu_virt.h"
> >  #include "amdgpu_dev_coredump.h"
> > +#include "amdgpu_migrate.h"
> >  
> >  #include <linux/suspend.h>
> >  #include <drm/task_barrier.h>
> > @@ -4076,6 +4077,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >  
> >  	/* Don't init kfd if whole hive need to be reset during init */
> >  	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> > +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> > +		amdgpu_svm_migration_init(adev);
> > +#endif
> 
> Looks good in general, but just a style advise:
> 
> Instead of spread those #if IS_ENABLED() It's good practice to do something like this in the header:
> 
> #if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> 
> void amdgpu_svm_migration_init(struct amdgpu_device *adev);
> 
> #else
> 
> void amdgpu_svm_migration_init(struct amdgpu_device *adev) {}
> 
> #endif
> 
> Especially when the function is used multiple times.
>
Thank you for the style advice.

The header (amdgpu_migrate.h) already provides the static inline stub
for the CONFIG_DRM_AMDGPU_SVM case.

I'll drop the #if IS_ENABLED() guards at the call sites in both
amdgpu_device.c and amdgpu_reset.c, and just call
amdgpu_svm_migration_init() directly.

Regards,
Junhua

> Regards,
> Christian.
> 
> >  		kgd2kfd_init_zone_device(adev);
> >  		kfd_update_svm_support_properties(adev);
> >  	}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> > index 28c4ad62f50e..c94d43f3ab42 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> > @@ -25,6 +25,7 @@
> >  #include "aldebaran.h"
> >  #include "sienna_cichlid.h"
> >  #include "smu_v13_0_10.h"
> > +#include "amdgpu_migrate.h"
> >  
> >  static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
> >  {
> > @@ -87,6 +88,9 @@ static int amdgpu_reset_xgmi_reset_on_init_restore_hwctxt(
> >  		return r;
> >  	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
> >  		if (!tmp_adev->kfd.init_complete) {
> > +#if IS_ENABLED(CONFIG_DRM_AMDGPU_SVM)
> > +			amdgpu_svm_migration_init(tmp_adev);
> > +#endif
> >  			kgd2kfd_init_zone_device(tmp_adev);
> >  			amdgpu_amdkfd_device_init(tmp_adev);
> >  			amdgpu_amdkfd_drm_client_create(tmp_adev);
> 
