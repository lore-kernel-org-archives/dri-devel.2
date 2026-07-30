Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C773C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64ABB10ED84;
	Thu, 30 Jul 2026 04:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yq1NMbMS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F77A10ED84
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6HuLILTi88C4B0uhGUo4llR0/21F7V38XEP0p/E0lUXHGH25n2RAchUIXCgy4mj34W5Iw/gDvnyiY8MA7oFMllJjUPB79jAcGkz9s1pZSy67/NZTHB6FlTNuoeyWeNQvwmxQzIO13Imzcqh61lOsICGNv2yokDTLXIG8yXX7sp1IGoRVXxkM00MteichB2FAj3OoO9CpCFCSU2pKnHdeq9KWNyQEg+7nDrS7kbZ6HUpwvGSMzMw1lzCNkDL98Meny2OUCzv0+cxks2k2oe8sS9T+mRNnFK9CgkmO1wQGqDsgbNSofRsy/8RTer6+TD8L7K8IR/XKkM3pSz4X1HivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+H9d+1LXHVCpJ+mB+Ara8aN17N4vpuZ4Rr6dzN1HsE=;
 b=rB6nTMhUchUiXmpZ1tA2q5LZ2P/yDDL9kkvzKPfmc1a6iY7Lf6Ju2zN7NIrjMtPrVLVfMxBanV8Ol0Vx3GUdNRDQNIL3o27+k1Zi0eIJ0Rvm1bNKnnKMn4PIIK38rGbmS8KXFMtJdKtyIGLaRWlqLowaAC8kbOJsGY9TfprtBdMgiM+Y9SzIs8O1FRZCXkkmMPGzidfYDy9ShkGtoBPEeHmIvXpv+5l/bIahmTvDOUmJXlmllwrpvUrW6C8d+2pxy+E80G7g6o/Fx2ZVQzU58EsNG9Clx6oMEyJycHKEMD6yIAH3WdZftNWLC7i0q5qO9fGE5zbBURrH6XDGrzOluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+H9d+1LXHVCpJ+mB+Ara8aN17N4vpuZ4Rr6dzN1HsE=;
 b=Yq1NMbMSKZE0IyvD1UQ6zg3Eu8p+IulhG2xfWySM62AgUILf1X2sDH7OZzFvvNt9s35r14evNphVLWzq7aLdlJ0Ey7hVJVhOjRahIk8BxL8xu2ImCry7ReNM5L7bVs87CrpfuWOFHa1mmyeGgrYShO56uXAKzmUbevTaxYTm/lcnx6dQgImBXVEcyjW8tVwBSnD7gRKYV0+NlkQ3gU0WyKjsdyrpp4PeGuSY5+m7qHrDbFBXkX/qPno7Os+yic2jrhR8R6IREyC3eOhR3t6TPmzkJrO+RgPa7mE4DB4IaRX6XCIwyNv2SK26VuxMKGTBNluqpUB3I5Cpc+lml/o+0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:46:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:46:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 30 Jul 2026 13:44:43 +0900
Subject: [PATCH 3/6] drm/tegra: Drop reference on postfence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-host1x-syncobj-wait-v1-3-afa730410392@nvidia.com>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
In-Reply-To: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linux-media@vger.kernel.org>, 
 "moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_?:buf|fence|resvb"
 <linaro-mm-sig@lists.linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 5426b17a-5bb0-49b5-a940-08deedf579d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: AzTU7D+/spA+bvBzgb5qgjQeZJpeJOb5utEg12mi6EmnZBfMtAGQXBvslLeZ+vb/T8BTXRFGD6aiXbcobXKQcHEZJsxATqJVidAmqqrZDZKdU/VA5P5JHPiNI/Z6xYN0vO2Kp6mrAYYfDyXoxC+aIb1SXhRhruS3BHEUN66BCfFb9poSXeW2i6LKX1MHZtAXyaQMGEchkNVJx8/fkNcvvAyqH9BMf9CKF6r4GuFrjj6sGA4ok8feynOyRmFHjecWpI0ZcqoR10Q2uuGjU9K2x/2/RlzlQsFYwtzbTU1GA12QClLHa3al/qUt3awRurwRsUhCezxkCWAgEebDWL4QHkv6zgOEiMOyKaIEuTtKXJ+Yjt/bW0ed9svvWyYOM/CF+2hm1Prbhg5/zoRgCqOdWeYn8bub77njf/joY4kLZycduKaqfelz6KbraGQgkdkORNEbHs4xiFG3opJYcXu+VG9eQ11jMK6/dcqDa83eyMtAbsLYkiFHH1xUmkglDcUtQxJNxfTXPnEPjs9Gq4KqZEGhMamd3m9YlSp7cWexVXEx8YKrUCzfH9MHFsPKkI7l+GZVDulSCLS5dhWY6afAMTBjzddl3glDCrgrZF+8Uwn/6elb8EQQsDEOxOxprIMzfL6SKSF8/JbGqBzzxhxWYj4Dn532ZaxT1aBv+0r5cGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVA2VEh4VmVxdUpvQndZYmVsc29jNWlMS1BPUTAzY05ZdXZmZDF4ZGNuOHpB?=
 =?utf-8?B?ZjRlZ2tYRzhpZUVOTkNMK05GMWZYK1pSTW5neWc3RGdQN1UxMmNOeGtCTDJ0?=
 =?utf-8?B?NUJRcnBZOTVVSVVlVVRpSGhnZ0dJaFMveFhrVjNBWEJlTEZiNmF3c3lUOE1h?=
 =?utf-8?B?QWxZU080NzR2YmtKSWZRd2VvUm9mSm5aM0dlTjBETkVMYysxTzltT1NLc0Zy?=
 =?utf-8?B?dzdWSnJsVURyWGxTVk5MSlNCRHk5eU1sVk1hc0s0WG83VTZSdGQzcHFJeVYx?=
 =?utf-8?B?YWdVZzRMRnZWZjFhQVVKVkJGRE94aTIra3Q4bTcyeVBoRDE1R1NYdllJU2tB?=
 =?utf-8?B?Z3VrbmxYaWlRdHQrZWVPVktCQTJRMXVHbEVvUTZSRC9rTUhpNnlsV080Vml4?=
 =?utf-8?B?Q1Y3bW9lSDh0QlJnREtMbG9XMVp0Y3dybXRhUG0zWkhBUTM1RU1WWGN6M2Jn?=
 =?utf-8?B?eXh4U2pwbXpnNEJnb3BNM0krcXpqSXNYczJZeXR6a3dDWG1vRTE1MTFCNCtH?=
 =?utf-8?B?VExLbmpsdjBFd0grSHorRHo4UURQaTVNK1ZuNndaTk02N014Mm1xSk9GeFNO?=
 =?utf-8?B?dHRyODRpM25TS2lzSjIrU3AxK3RIQ05TVG5ESGxVRTNBYVVxd1psSG45cTVI?=
 =?utf-8?B?OWNCRHhOM3oreFo2WC82TTVBTEQyTk9qTHZkUUhJVlZreEI0bU5SMUhDSC9I?=
 =?utf-8?B?K2xkYXFWRFl4LzYzbmdYRU9mS2Q2MVV1cjVna2xEY1IxUzEreTU0R3BIcnFO?=
 =?utf-8?B?T1VwdndDdzZNNGdXVWJKdzcxVEJCcDAwemE3eVRuaEczUXFSZnRXMFJGRUlB?=
 =?utf-8?B?OGI0VnRsZ2FDbE5ZZDRPbytrak03NFNhZWtZQ2dwMys5VkZCeUg3SU5Vdk1n?=
 =?utf-8?B?bkhrbFcwdXlUNWEvNVBXWlU0NVdQS0N3MFdGcmZnT0JqKzBHdzVrV3AzMVRq?=
 =?utf-8?B?TSs4dkZJQWRDRWNSR1lkemFoY1VoalhGNnFCYlJGYnZ1RUNsbTBTSm1BbU5G?=
 =?utf-8?B?cjRHaVhmc3ZNd0daam5uYWFleW0wTjAwaloxendTY0ZibnJqK0loNlg2MUwy?=
 =?utf-8?B?MzJtcWVZbEZqR21lZFgxSEdibDdJa0MvU1RpQ0J5dHcranFYSnUvQkdNazdN?=
 =?utf-8?B?ZWxqeWc3SFJsSks3RUk5dmtxU2hyRUM2NmM1M282NjFZT2VMc2dKMUxmOUlN?=
 =?utf-8?B?NVc5M09qU01HWDhtQ3V1OVR4b3R3K1hDaXdmaDBaYVJBMVN0TmpsZzNrZzMw?=
 =?utf-8?B?QmVtL0srbFk5QkpNQU5KOHYxV0IzeWlDZ3Nxa3F4YWtrMS9pS1VQd2NKaGln?=
 =?utf-8?B?UjJuNzhmMmdzWEF2OTlsbjRFaGlwZVdvLzdzTXU2RGNGMGh1aDRCZkxiQTFO?=
 =?utf-8?B?bGhwNEQzWDlENlNyajh0OUtjMnRBTkNVbWM5b3NKR3piSDBoZWMzdTBSWjdY?=
 =?utf-8?B?dVZueFk5QitWS3dhekY0RXZidG4yUzBpWTR4d29yaUlnWTFhWU5zMU5IYXZU?=
 =?utf-8?B?NHJ6UU1SYmNZZ3RpNE95Q2xnWnlFYXVnQ2VMaUZEQjZPTkR3WXBDc3hvOUEw?=
 =?utf-8?B?WGxxSTBxSHVTVkcyOXVTRC8vTkVuUUI2OXhiWis4K1JYZFdDYkFMYWdNMWlF?=
 =?utf-8?B?V1lKVUFMa2YyaENLTjZhLy9uY2VSMktOdWkxMHY4WTJHdVBvU2cvSGNHWUlM?=
 =?utf-8?B?WDNZWXdFT1ZVdXdLMFMyT2VwQzZEQmlzTVNaRFpKUFNkcjRjaUc0MTBubHZa?=
 =?utf-8?B?T3dnQXlvc2VxWlcrQ0M0U1lZVWtjWDhMMU9FRGc4RytSRUlLc2E4dldkTWEx?=
 =?utf-8?B?RWx3VzRJMk90YU5tbWVFMkhhVi82UVdQRFBoeUl0TXEzT2lxR1VFbi9aODBQ?=
 =?utf-8?B?aUtLUlFsN1VMeDhZOWRmUjJJMnZPZ2VmbE1FbllmY2pDNHZrTXMySEFGYndN?=
 =?utf-8?B?eURDSmZueldobUZ1Mld0TERFUTIwRytNbnFMb21wa2xaRytuanVTMjBFVlAv?=
 =?utf-8?B?T2ZRci9BelFCbXoxWG9MbENEcW5LcUwwMFpVUGcwN0JzWnZDMkREVlZPRUdT?=
 =?utf-8?B?MVdWTjBjMVFoRmE5OVNmbTZWdk0wY3JBdWpIQm9mUHVrZ3BKUEZsLzN1L2Zt?=
 =?utf-8?B?RlJTaE00dVkrTTlKWHIxbEtxYU1IcXVhZUgvR0Fubm9OZjFqOExHd1l6blky?=
 =?utf-8?B?MVE0cStRbm9vZlZzaEtOVi80enUwTXk5dC9LK3RIWVVPNVVicXFQdmVXczVW?=
 =?utf-8?B?eDlDSW9PaEkvTFJHelB0Znd1WEFVNWttemtxL3hCblJNL0F3UXJueERvd3Ft?=
 =?utf-8?B?MmE4aVYyNllyZDB0L2Zsa2JSUDFoZlBQWDhCMFJiSW9xNzNnUmdLOU5RbDFW?=
 =?utf-8?Q?9TzohZZjUX9UIxGTL1PNyP4+rSP39LEnewQ6AWe6tT0sf?=
X-MS-Exchange-AntiSpam-MessageData-1: 9daLpFFh217y0g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426b17a-5bb0-49b5-a940-08deedf579d7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:46:10.1918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYarE2F0C459FH8jrfX8x2xTyNWwAmJevsjwLmZDto5I/cQ6f33162FS49HrSPANXVQBQA8iHHnlOFTExyCL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

drm_syncobj_replace_fence() calls dma_fence_get() on the parameter
fence, so we need to drop ours. Add a call to dma_fence_put() to do
that.

Fixes: 13abe0bb15ce ("drm/tegra: Implement job submission part of new UAPI")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/submit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 3f20b5a24447..658396f2e954 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -659,6 +659,7 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		}
 
 		drm_syncobj_replace_fence(syncobj, fence);
+		dma_fence_put(fence);
 	}
 
 	goto put_job;

-- 
2.53.0

