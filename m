Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E60FDEE28
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FFA10E0C2;
	Fri, 24 Apr 2026 00:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="j42OZirg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC2A10E0C2;
 Fri, 24 Apr 2026 00:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7jbngqpXcWXOWO4wcqRapj+2BVMWLP1A0yj8qyrFZlpqjmOjqRH4YypU7e9c3FedBn1qkMQZwC5UYHE5DxGhuuLOgwE3B6/E8gxpTc+7zI+0HH4fIx94sMZNoKWDS4kn7v5KJIt5Zv1dFuGxi4xL13XRIB+TdIhNdWxHFUsYuN2w7ILeri6DdqoIfxO9N+aMuxYjlFHkKQCMCCPplvIJ063Dip9pwRz//OYcsZZpudICr9oK/GH64fR60WzOW5L+Z0KPBvgsiCFsdXqPQntL+5yUCkcq7PqTibygMXtQLQg6vaGFLH4X+8Y3S7OBcI1QCVHchb7374ziDEOUFv1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBkmgSbG4mxuin+xasBvpIbEpkC5uFmR5CqLkX7emiQ=;
 b=wHUqqLf03U+i7sUjHMp+B9vXbKHCDfiqCybr5hsX/svbvSsAveAwhDEfaWcAO/R3MLAcWqj8Wr759M++tTpbgwflFCqC7w7GktMob8wmFFeJL21yIOW3MgCB49ZvObtx7U4fXNg+LF0dL2QZc+gdpCJHF0O8etfHBWqD0w2b+oIh9E7K9YOphx3ol1EIKEIfhg2rDfHScJspj/k3gRFsy38iUHOWqtbbyD/2CI+3UU23ZPn3milKwgZPJ2cbWdSbaSOcYzesm/xhE8p/6ijAeqUV/gNnzHvbbDv6WMD1HVnZ5g4S7VdZDBh3r5I+OP+siv6xMJKX+wt5+vaHNS4eZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBkmgSbG4mxuin+xasBvpIbEpkC5uFmR5CqLkX7emiQ=;
 b=j42OZirgAthwD/vgNHovgk51qDYxXdxSJMZukn+dHAPzgtknDzqhfNFJQjXJHfIH3/HivhJ9JP7Nz9gw1dnltL4oni5aAyY2C2+/Z4Mzaa27yq4717ktfMtB+/4xwjqs+ASTVferXd7PCXZf/O9XYpjFfMD9mrn/uI1j/qW3V8gx5CUEwdxnEE2Qip9xaJGn+uV7mPrPp4iBjshJeiLvgyO3JzuIyVkgJwIReQBB10YbzQrhT0eSqKBord+TahSVI23VsYvT3+7S7jFCq3IcNm+wVk+uUO4eNf9pnTNuXQhEQSzMkiHi3u9hUzLWrfXW++f8PGXYGG0neTIWf++Fug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 00:52:22 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 00:52:22 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH] drm/amdgpu: use bitmap_clear() in amdgpu_amdkfd_device_init()
Date: Thu, 23 Apr 2026 20:52:17 -0400
Message-ID: <20260424005218.147961-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce5ddbe-5697-47a2-6092-08dea19bbe76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: riFgHJu6w9sm005REkGLI2I9wSbhWVALd8Hnmf9lOeBMerk5H+w31FedaccSMOmNhwA5ebEIja2Y1+A9z2FyCbC/e1HDUTVJv32+NtiH2z7w7TUmaqXSWDqpMMApd9TZT7w2XHFGcGtxB81A5gNr13MzdUoBm3PMUsGu/bJxArE4cYljCy6RhWF4oOEzmke0/eWTVohv5CJeZfqwT1nVDlkLT3gR7GOWpONBDncXOVeBI6cXrizJWx6hVbPk2ra+Li0dulCrYh5e3+sOkc0sX6+osZRUyWfE/0lQqWkqHaqMlngvKV3g483xtvzu83BcR25QIEdke+yKDcjV6e2PQccaOPDfUnzX2cThMqYH+m8+K8Tg3hiWbLyddYHAU2tTI3WssMIwWHlp17BXQKmUwz24xTAsB9cspo+X6Gd54XQ7lnUdFpjKPq75/UOFVOSeFi2ypx0iHClz0RuAiwuEzXitFWP2LespUnpChD8Rg8+ocF7c8ocLQoLDkBNlPxRpzXA+DumZ1q+IDKYUYlulassu/hNsk4jAPaSwRzlAg1G1gecSZCBbclHjloQt7F+kahCGOnhstpJSf0E3r/6y45VI2+mvZL+XzY/LAy9x3fjizoW1vKC+USl1d44HJe5N31obULMOjpKTCcOiIqGYk4LTZBy6m4MxsNXC/3gU5Dltyat4ExzVGP8QQGlgpk4s2vaGEheHipw1iQ4+lWu0YJw64/3RPSBQY/Tgq8dM5ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3PsPIYSJaUfHbB8RH8Irsm8R0BXHW3EXWJ+tbT+UIkBdgvQs+BNgPYqTP8B?=
 =?us-ascii?Q?ocyQQOJVp0JOlDX5jv3medQ4prnphRr+S6SkTNS8dzU9+j1IgcFVBMNtZykK?=
 =?us-ascii?Q?Rk4W3V+Go4sMPfCd8O1BVzU3hb/NVox7kGjJPupeB3AhGTEanJh5NgT1skrm?=
 =?us-ascii?Q?yVyVwLLFypMIZq4YVV1Zwpe+V4qa+MWL3lgZH2DpG/n1Xn7j3BXX4mchqOJv?=
 =?us-ascii?Q?Uv7aMqDD/JGB/4HU0K3m97n8TXzMIujLWYMWuWDbvu0KdpPyFCj56upkmeFz?=
 =?us-ascii?Q?8J1U4600jIpmmUOk033D4sU5KAKn3lzw5dk4mZHhkASw2urinRILGLU23hU/?=
 =?us-ascii?Q?yOzq9ElWtLWAW80NHZarzOY2XNSGnqQCVAMEfO/g8Lb2SbuutiD1yL1qIgs1?=
 =?us-ascii?Q?Lr5WBayqZOfst8jn2cQuO6ppZP3kM9ITshupM17bH8CoL2WLYYgpDmaj4XAT?=
 =?us-ascii?Q?R40Z5t9hbALcqJtIrxbcGgeI24ERlbLft3bTau6qfqeqk3g//X0Kxe7KN0ay?=
 =?us-ascii?Q?M2bIckj6SiSJzYv5VnAsxSnJb8nE85Mnet8IcvmrcFM01tbtoF8DH62NuLQE?=
 =?us-ascii?Q?0HEVbRA/5DnvDBokJ2DfA0DdFdXMpu+cpwMeh/X0k5LwExfXdSOq/7Pv2Zf0?=
 =?us-ascii?Q?6lH8ZvLq9oQFb5DQmp/H3R7qWaLAUmWEi2bQLqHcGv31+UU69qOlNDQoBbWr?=
 =?us-ascii?Q?C+rZSKut4lR699sQLFjkiyYUy6RZJE91o1V8wL/vfyVX6d5niE1HOOJ3d45i?=
 =?us-ascii?Q?D1uS2AFNgqjkGRRRBcnVz1xgsxT/ywHdg68wNau111IPxbctlK4N5m38Luay?=
 =?us-ascii?Q?g+VEUsHSTjRhwJthTCUf4C5UG0DUoOZ9yHMU0aSB4W/UC3j3HB9a/7yb1VPv?=
 =?us-ascii?Q?ZSyws4ETmPk7aEHbL8eRkdotgZr9jMal39F2LW9erwfbZsfrVbqzDIoqZvOt?=
 =?us-ascii?Q?vDqNrz5H07dbRoj8uNnzsRAnY/YN2hjL3xSe2pc0JkVMPfDgyVaoCUNJ82Zz?=
 =?us-ascii?Q?d5tC4mIrm4S1Q0eZsw0ybdgTiGSYUmAMaJuTRm+1QyGW6XX0TfZvWg/Pi0sm?=
 =?us-ascii?Q?dXFwIs6Qhx4kKJ/LCWH/bQ6JEsq3moz/bQHS+mkuTRqWDg7+qX493/5sg+X8?=
 =?us-ascii?Q?kzrFvjYrLoog72N7l5addRJbvHHlcOocYk2+cmUAQo+9VGqYrgyACkAFTX2l?=
 =?us-ascii?Q?lIJywUG2VVU+OiWJPIidJ7/n7xxfVue2ep7aZNE584Zw8IMQCe+MevDqtyUq?=
 =?us-ascii?Q?+Mdmdk2Q6pdyPQJbwHsd+0AskTASubJC8HcMYNu79AfkRIy0LyYVIxi0jp3P?=
 =?us-ascii?Q?n1AdFVQ6So6UHbukdg0KoIHRMMCAmGgX7WrW4WUHyka4kK/6nLZksm1ZHAr2?=
 =?us-ascii?Q?UOpj7hJ0EPq9IfVTUoSnYHN8nJWeJzbqVFF5lTvWxdTGMOVwyDbC4gFnWk2y?=
 =?us-ascii?Q?EG/ChaPK5AkTqoJL+fegYx2XxHfg0z0cbcATFu3J1TUvEfIRlMbtvP2ZMegD?=
 =?us-ascii?Q?irTmwh9i8CyzXBckN3hipxqzVgnMd3xfUVWxDZQcfcUBYyYsy0rvHI/MjYEe?=
 =?us-ascii?Q?rQnDf7Wuld7rdnQq1I3oNWLqdGz5BGxlTbMmpJIyb9sh6+VJaWSYFWbrGORM?=
 =?us-ascii?Q?3XevnzFV0EjDkPkLwC8p5R6Rn82rQsuGY5V/lcnUHqcAHXDKUai5/DQVsOoU?=
 =?us-ascii?Q?Nro7NO+xAUuzDIjnhnAcUDiFCK+11h8z78b6ZSz/LLfe10iw9zaudQNIHs+s?=
 =?us-ascii?Q?wxkiVylbmrfmnw4//qJrR67mNqC3qM3Ckw9Fz2kutO7uqLo8nAU5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce5ddbe-5697-47a2-6092-08dea19bbe76
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 00:52:22.2588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izkTSybxphkgbk1VSfhOFMm70Uq5h3Qiycq+FoVi3PUod3BlbnCOZNF3uxOOiH3h1sicFlukqq7ZCsWyGDDzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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
comment says it doesn't work, and opencodes the call for nothing. Drop
the misleading comment, and use bitmap_clear() as it should.

As a side effect, the patch switches from a series of atomics to
a single non-atomic operation, which is easier on caches.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d9e283f3b57d..47d52cb2f1ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -194,14 +194,11 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
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

