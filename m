Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE7FFF8867
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5328810E9FC;
	Tue, 28 Apr 2026 02:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuPavHym";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E15910E9FC;
 Tue, 28 Apr 2026 02:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu2mFh/L4SHptnH6mxgss+cmpwPam1Y3Ia3VSW5Eb4dF2u20fHsV9w69HilFtmKDsdHakujjp418SbPNncLJKD6B9wnW5EgKixneEGNVgL+97wwveFFfvJv/MJ9NH/+7bg0ZkOAqvqcK9Qzd/BoxOKvnIT14rvfPQvyZuv7kDQouDnmmOiZdTPr/uMnbtRtXKbPYR2iqRfTlTgHV3oeDW+5eZ4fEhtbJQgSIG578vKZppMvvkkf0+ovVZAAG6tOYcDowxGDsS5KTQKl9wBTc3hcGo5WAjLnv4c5FbSCmGHi5UbGPxXP4d9IJmhfwUMOVfJpQNjO/J0p30Qc6hLUewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mswZ9XIgqEvFPnMTw8GEKaRRnR8In/I260QHyCGjAPE=;
 b=mQzwecd1lpFMVNUNWt1vXX2qNeDDRD64kwjeQOJenwL93ADB8EEe7s64yHUfqNoRzmN2mPoPO4ZTFv9OYwAFxsi1UTCcroig8GMiPJsplxKcNNCee2kKnulErkbzAFOTJVjs4pZKE+N+/xqoBXY0862gtYs2jFl2GQFYUz9xl5pZWMhEF7iuU1M8YWoHDvD5XaawSf1P49Nng8XH0wjzJSkALQA8FZvCR+rIW8ps3GeywuRsuynYu1i3hwIvrTfm4beuJph0z62jhW+7Qq1/8AHUrxGru2RfR25mQERv2jJP/VWW5EDJiiW0YsyLSK/TX/L0VQSU8yUaim58GAneKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mswZ9XIgqEvFPnMTw8GEKaRRnR8In/I260QHyCGjAPE=;
 b=AuPavHymy6tG2Hmir0tYb0IZZkhg2nIWe9aUBzXnJ8DGxMnctJHGIUCwZ/GJYboiemB459mua5kx9ZEZ8uLUTFjWwUtUZrEAJrD/akaQydNauBUDtPPlcTnUogdboq2Mw7608JUxN3tKcS6N0oX0Ho/C7dMGI2d97fsNqtvWCQ6gZa+NXNLYzNFb1MztORw1bjinOieq/S5xDTL6YQCszdIhNJL9bmmZxhLfTNgs03Oo+AUdw5tQfCPyYd3KbY2hOefeVdE/sffcMhBGkQLYSNOJNJHvYW/1uXtfugEkMnXguG6zDwmWl3+upRp6uIoWbgJxFzri85XimaxV/Jf8ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 02:35:39 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 02:35:39 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v2] drm/amdgpu: use bitmap_clear() in
 amdgpu_amdkfd_device_init()
Date: Mon, 27 Apr 2026 22:35:35 -0400
Message-ID: <20260428023536.449877-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0980.namprd03.prod.outlook.com
 (2603:10b6:408:109::25) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fed187-1d75-427e-1051-08dea4ced5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 3tk70V6DS1uVdjkkl7XfSwXFd54uUEff0sSaQrng3Os/TvxLJYlxdpKitwCk+CCtm2+zDoahTCp7HLz6cSTZwlD9dNtWE05ax+QBIYZd2QQkaVks5k1XeFttxfETU4kUnm0IDfco6s3RdtfKZpNTrA8cGC1lifsiVPR57IRqj06c1C6Uwgdh+0fwKVU1HW5U1bWKwIGoQ3wSB2zZxT90rSodtOI5zIJuC4mkJrYyakt74GZT9oeUyxE2J0VpOe/JK1jxHKjCbAlromYBbeDxR75SE7/yZFPSDf0E4YXZQLv4+vXA9YC961gKKPQ/87qRNagU21HxsYhtWH/c1voPJi6sO9ST+fkCAKCJ2Uj4t8q7PCsBiqcSonx2GkQpAxLTQA3tNPG3Ro/5ujY6mIWZ1Z7awg6IY9jItqJCgfJ/W000txVTeGAfevjV8fKyoUXq/nnEglW8gSacVynzK1F4dLUBH+KcPOa+pgUlv7mrt4O8lbZEn49KcTZTKPBHjvZLolrfe3AdJP8ALo1hw8+53JZ+Pm/FStF8mwFF5BgTYa5D+lh3TO/YKyT8KXRqV5Tr6rlXmnKAOjhQ/Pz4xCWNKTHwLGWUNdTPJRQNrSq8xK5samuuSvDxPjCjpQs3FdK1yeNC9NflXRoeNDszSXTq4H0W93gReErcG8VrNRbIjEhq8tWQvBwhrrKheV0g5q0kK/SAjxb5CdvWPxbYXfUt0sfxpFQrTdW7/nu5fiZqFjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ugWNcJC46Ugs7ATZaNqD/SoASrImtM3EPTkXS8fK9e3MguyJJqTbTgA3DDnQ?=
 =?us-ascii?Q?p9BHMIGthnbt5yRSnOGnxgeAOLqo5Wjigz5P/i3amQaLBZU7zvr3CH7VV6W0?=
 =?us-ascii?Q?yNg/kvLw9bwyUBs74DxSqnBAWOyK2YIyRJy/TM0GIy60xLRdR2xOCi3yUrNz?=
 =?us-ascii?Q?7FvKpsZSyIDNL0WCRQx558uivBdozuoah7/c453EQXWdkS6jgJJNWqRA4oz+?=
 =?us-ascii?Q?aKKD90IPE+c0DS65KCszQMHKlVZJ3Vh/71z2RPQKqGFt6tFLSPvh6Kh1SUus?=
 =?us-ascii?Q?WcoBh5Ud95Wi5iVTXTJF8EtTxj8Z94jkYomrMJBwAKKsHsdgl7aM9nv3sYm0?=
 =?us-ascii?Q?koDrWhUdVolvXkd9yiAV8KhD56nR6PPBQKSQOORvmsNdz8fgPMqzrOfyhpo6?=
 =?us-ascii?Q?LrIyMh13p1nb71KsnW564RWrNra3AbZrm8ximFs6FheckiCW0z0BjvmR/OTP?=
 =?us-ascii?Q?KTqsKZgMgDqAqm4HUIToKp/qy4pAFzSMM7KcJoicQgpzXWIEnNqdT3xX8lJJ?=
 =?us-ascii?Q?mVrWYzdGq+PvVOVvPWtSa0+iGeHi9Mi6pF6/e6DR8l9YSsLMEr/Q87rKY+ky?=
 =?us-ascii?Q?RPcy7D5+EOoxdNXbvGHYqmIZiJrHpADdkHeOD1kyq2/CYRBXgvHGE/reMrrd?=
 =?us-ascii?Q?xRJWz4oWoBZaJHHVHZYuxGACyEzb3NcIDwSnlaCjDHBRSAPVkG7bkGSaKAon?=
 =?us-ascii?Q?62jEImUgAHhiGRLX1WLvNWDVzIpeE+ACxp8u5PjY2EMffu7Gnbn+IC/h36cg?=
 =?us-ascii?Q?bAwrnnq2LzcDyebqnHiNmpnHFJFSyOg2uwTUjIA1noQQoT6bsg/YQgmmi10I?=
 =?us-ascii?Q?GHRACrDzYrPxS36kvlE7Xk6kW1kqQk9SH8MzVPZwvHvBM8AjTOnqv6o2rcdC?=
 =?us-ascii?Q?GeDefvVLNxYp58wLbL9bNXapO7TejBhEdnAsXxehYXqFXNUA9mhGDv013mGa?=
 =?us-ascii?Q?PMGYPKjA/LDinMkDuD2tXQe5RhAvTCn426pRZTF+quUfBUSA81GHMfwABNnp?=
 =?us-ascii?Q?D4dA6yzzf5pieYK1c1tiwwcK1+z6Z3qLpbSg6fRe5UaEEDFEQaJ+4Wwgjblm?=
 =?us-ascii?Q?q81FsbZtaKnKeGk9dkyJy0DFOZe/ClMOVAPY2/rPBRfa3/fDMSpHWOwR3qmm?=
 =?us-ascii?Q?kWqrSi3b1eSruJWwCwJPoTNIw72L88oCzMFuNhXxkeFrJizVG0dQUQM0xzia?=
 =?us-ascii?Q?8yK1gFDNR7v+Kfl/vKMWBp7xnDoemIyyv5zvpweHo8anE18cU3XfG1z4/RT7?=
 =?us-ascii?Q?Pm4jmMxgm22uNdGB3LTbqbOPusHtsDImiltP3RwP1QxSDYjkyLdExFJSgK/V?=
 =?us-ascii?Q?B+LkKw26I0bxhZXNAVaCeRQwuediO6UKiqQC3pfiGSJjhYq81WaMyNaG/YEs?=
 =?us-ascii?Q?ZAygTkLJ0cg2Ih/k5UbMiTOE/ZBBq13AwxPQXPCNJ3zpgXBaVQ0nowvNIdNm?=
 =?us-ascii?Q?oweeh7iXNaNI5FFfvIpnwUuFClvFiXWCAYAI6OLuzMrX+6Pz7OK4lafvN1HI?=
 =?us-ascii?Q?80QeVxjyJ9pQdSUtksTAxIAbRCm4Xql9nOaag2nJXA++u6YCfvEeTnflmngF?=
 =?us-ascii?Q?z8je+W7oXM5v+/7E3UwtIXnZMOCg1k+5E24AdC16sejD3gRXpsGel8g/wTl5?=
 =?us-ascii?Q?TSJsiC9A8DgPzPQT1gUbYQMVs41TBBA2Ytd/fwDOn/2x+7L3ZQwog49cWrdj?=
 =?us-ascii?Q?BUOR/CU5A9kP1pQ5Seucj43aaz/Jw3dhKz0loDy+PsBZz7vhO3iJjD52+SBu?=
 =?us-ascii?Q?P29RdivpH3uPQqcP7CH7KWdLaqGVThxPPiGJUcrZrTo8N2fT/iYt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fed187-1d75-427e-1051-08dea4ced5b4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:35:39.0017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q5uSe77TtNPY3pfz4dBS/dQxGSXaFNogEA/QgW3Ea1bOjPeRwmEYAS5sI2H2gDyie7JYc2OBSEcW+NU3RDrcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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

The bitmap_clear() works OK with both compile- and runtime nbits. But the
comment says it doesn't work, and opencodes the call for nothing.
Drop the misleading comment, and use bitmap_clear() as it should.

As a side effect, the patch switches from a series of atomics to
a single non-atomic operation, which is easier on caches.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
v2: don't declare 'i' in the new implementation.

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d9e283f3b57d..500976d9087a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -167,7 +167,6 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
 
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
-	int i;
 	int last_valid_bit;
 
 	amdgpu_amdkfd_gpuvm_init_mem_limits();
@@ -194,14 +193,11 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 				  adev->gfx.mec_bitmap[0].queue_bitmap,
 				  AMDGPU_MAX_QUEUES);
 
-		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
-		 * nbits is not compile time constant
-		 */
 		last_valid_bit = 1 /* only first MEC can have compute queues */
 				* adev->gfx.mec.num_pipe_per_mec
 				* adev->gfx.mec.num_queue_per_pipe;
-		for (i = last_valid_bit; i < AMDGPU_MAX_QUEUES; ++i)
-			clear_bit(i, gpu_resources.cp_queue_bitmap);
+		bitmap_clear(gpu_resources.cp_queue_bitmap, last_valid_bit,
+					AMDGPU_MAX_QUEUES - last_valid_bit);
 
 		amdgpu_doorbell_get_kfd_info(adev,
 				&gpu_resources.doorbell_physical_address,
-- 
2.51.0

