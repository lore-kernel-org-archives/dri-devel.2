Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C205DC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747BF10EDA1;
	Thu, 30 Jul 2026 04:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XPvV7eDN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63BF710E100
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2Mi5w6UBbPvW6kxJa3C3oczkWWNDUjO3ztqa74Do7vxqaGsK3N9MnWrbL9rK7ADFuH3vbbzsjOiSWKK+kKH0Fn2wsq3CDd0wGRBKAUbvuBPL73UbBPZi7Ov5X4WGPy/9y0zdQGMEOLy/D8yC6eMTQjscDUjIsCJFC36bg1MckUvKC55ce0czhFUOsuf4IezNhH4bQLgzEQKIAjLXuBaFB1EKzqeutLJ3w94zsOQDs1i9cAx5E5AjS4yt9Pbh/6L8jScryXGAKE2djQGXHsxQ6l5yjd2fsQfptiIW7N2cCXSRDoAvtTO1k3Z+RoU6pLILaA/zfpD31s8lI3eTKSR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBzaR89UozkbHcMSXJCkCH6lbXVX2QqU/jYYk2zMrNg=;
 b=fCrJxy69wQlV6V9PV3YuWb0ENfVIYHgzevIl40p1jMgo8sxfLRApAtbhQupAHxh+9wxTMs0MTaGqOlrKU/SZ7ipQ7qBI7qJtqsBPIADRuFwQn8zz28smKtPdmezzSyq8pWFl+o3YqEQzzF2TX5g0M98ZqsVpJTwxw7vI1vm1S7cDa8kTkxyZKHCh3Na+g15MWuH/nV4/kfxt1AR0VF+9jfssCW608zMjodNoK381qJ0FqeuwbI1j0ZIwtYum/HpGX9JdNGL6P3dmFBweXMOAso27iUhQt990ITVYTY4LKyu5xS6C/dvYSI7Svwy3/oooco8x2FmXr9rVLXBlvpV6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBzaR89UozkbHcMSXJCkCH6lbXVX2QqU/jYYk2zMrNg=;
 b=XPvV7eDNr/TP0yLE6xkepD2vRvsRQP5zDeT9F4dgDRtbaaY5Z1dd184Jw0aiHNQTwA/4sLH4vdZctw+G0gMQkAwRrll4BCbaTO/0D6Iiyjb84fqcqtAQBALvFCEnRA1V6hQYlB6R6iKS2ICj7/flxuG+1tT934JzLh0/3sBzaYLLS0nSPhZSb4fJivbnbTsAciDeoscPKpeLfXkMQ0qfcfWUbyqYvw0EsjgqYOgrDTyQxeNF3sHSvvmMkI6FFIFhD045dC1RszwcKajEqCFwBby9q3uHngJN7p1gIiuQUyrWkIaYkzm+zpP92hXnp7jJp74BoDiHT8lwZlLD2l2AYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:46:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:46:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 30 Jul 2026 13:44:42 +0900
Subject: [PATCH 2/6] drm/tegra: Don't pass an ERR_PTR to
 drm_syncobj_replace_fence()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-host1x-syncobj-wait-v1-2-afa730410392@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: da9e43cc-3a2f-4370-dd52-08deedf577d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 16Jv6EE0/tSz1bmlTW7buHPFWmwzKtHpQ8Rq9I5wyllE6gPiJJpKNaTinSYXsxEEgZqOCaG5IZTfP2SB7JXWeztpt27WpRe5cz//l4i4LSEymPgAMd4ShwHV0kSIcKpsrEc1uo/0Y4B6D/ez8vtxXzhpe4p0JbmUvyenbAbEwIvoGK/S2vCIqCmlT5BcxPC7RF3+910ZicGd6M0kGZXJk5HN5pPWLiThF8MBgWNHkNqPg0gaCqLgeD0cYb0RS6pT9Dv9L/SWOhVGFzpF9nuQjrLJaTnYTyqdUJ1/KpYVi5l1+GNZ7bXQJs3L9EB6IrShgm0mAJQ6K/3/mS7SYCTzlN0YoO4zMkElXkYHJfetJbZQqstBxs/ZGfmnZHX8M2IRcfaU63ImXRfvvm71KLxk+GsREuG06JPLK9ihtCLHe2IjmyCsNJcg+yygreZvR92GI9+yAWsHlaWiTZVrI8smbNiO8IHpOwcP4EaKwZ31bbRb52aAG35DxjRR8MOkGDr+uCw/VFpbU5qytZdcsFRrhwDY++62RGXvDAi81vQzlLWoa1HrEGXIyJRNDU4Qzn42qiEQb6O9rw3KxdrhZX+vaOolO55nBuYgQj7rlxtLzGtcgLWQDD2GYfSFfoRu12HMcQpiNIO/Br+U9oZKrI5PB4DlNgMhCJcaR3s+lplY4ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amNLdmZYVEJOYTRIdGRtL3o0eTk1dE1PVkh5VGRycERnY2wyd05pOFFVa3Rm?=
 =?utf-8?B?WnJwMVYrUDNMQkFObk8wOGJFSjRYNUxpMTRCc2pvSXd4TU00WE9GWGtvV25V?=
 =?utf-8?B?Mm5waHRUWDlIM1FlNktFaDNuRG95V05pRGM1aTU4eER4VnhGQysxRG1zTkFa?=
 =?utf-8?B?UlRLbHJ5Y3NhQUlmY3ZPTGx1WXNFb2ZkWHQzeTVIYzFpY2FZM2Z4cTM5MitR?=
 =?utf-8?B?ZnRNeVdOUHp5c1Z5RWtRRHNQZEg1YUZKMUtmK1BqVXE0QjB4S2hIRnJlNFRJ?=
 =?utf-8?B?Q2ZuWWNHUGN0K3J4U2RPY0o2MGxndndPNmxsaG1lRnZZZ3RTbnVGOUJieENG?=
 =?utf-8?B?ZTB6bEJQNG1KRmp2VG1vNGtXSlJ5SnFlWUlGVXRyZE5Bb2tBTmp3Sm12a1l6?=
 =?utf-8?B?cW5SSFhWWkJDRGdvV3lmOEYrUGxsdVd1cUpVTENCMnAxUUZldm9KWXhYODVk?=
 =?utf-8?B?TnlqaFJjM01BR29zcXdBRXhzOEFDWEpVbUszQm1FRWZhRkJIZXQzOHpBeVNH?=
 =?utf-8?B?aTFMa2hmanJPc0dTaFV6UnBqLzZSK2xlTkVoVkpkY3dxRVZMRmJSMVdka0V2?=
 =?utf-8?B?YUxJYVNrOVo2blNtTTB3MWlsa09xN3IvZmVyM3dzRVFvdUp2VnpjN3VlWWpm?=
 =?utf-8?B?NVdhZlBSQzZybU9wdXIyUlhVTE5ycUJ4NHE3NXFoK2ZrQ0hoaGM3dk4waFNV?=
 =?utf-8?B?Wmg1eXA1R095ODNlc1JvNk5rUzJmL09pYmxyUkJneWZTRjVCV2JrSmQ4UjRW?=
 =?utf-8?B?KzVZWm0wLzJ0eU1Kc3FRWGtpcDdkZklRY3MwbkV3VysrZ2k3MWw4RG05bmRK?=
 =?utf-8?B?MGUvbHJoWXJRbE1pNHhsSWVmR09Ia0hmMGc5L2svUld4d3drU1ljNGRVQVFI?=
 =?utf-8?B?RFMwKzFNUnhoVlZSZHJYTHNSUS9XKzUwK0JjcnJMWmZzQ3JKUjFvbHhMdW55?=
 =?utf-8?B?R0VJQnkwajc5WXVHNlZkMXZJSUNuUWd5R0hCeXU5M0VNUVVJOVB3Z0g3Vk5R?=
 =?utf-8?B?aXl5UXRIRm16ajdQYWZYNWRCTzlmS01GMW5OZmRocXBRRVo2emRzdnJ5UVQ0?=
 =?utf-8?B?a2lhTlZUR1ZTeEl6NnhyKzJwZkpJR1RFNnFTWTV1dlJuSUp1SHpHOUtYZUdY?=
 =?utf-8?B?YS9yMTVtTnUvZXNjYnVIbnpXbTBNOFBoWXY5ejQ5dFFTb3orSms2SEhrcndh?=
 =?utf-8?B?RHNHc0VjeDA1T1BWK2NzNXdoTWFxZXlUMzBXQVBUNHgwc2R6TVBFWG81VFVK?=
 =?utf-8?B?T2NLd0VXZUJ2eENLQ2hxeTlTTVZoaXFqWU1PeWhnVFJZQjh6Q2tNazV6Y1Bo?=
 =?utf-8?B?RjlDZXpLNHdmcHp2Vzd3NWlhRTBPOWZGSnErNm8yU3NrUFRkck5XYTF5NXJN?=
 =?utf-8?B?SzRxVUgxbjBnTEFHTWRHaWduQ0pDQXowbDYzVWpBSTVFbXc5VFg5M1FiS3FI?=
 =?utf-8?B?VWFqQXBTMUZuMjM4bzV6QnUwYVZXOE90VmJmU2VDa1FRVURxZVVuSGZOem12?=
 =?utf-8?B?WG9SWDZRUk9qTi9lYUFEdVV4YVIzdHI1Njg5aTJWek1pOTg0MnFaRXF4R3No?=
 =?utf-8?B?Z3ZiZGhKcGVLUzdKQkFZUkVORWJrcElSSmVEN2ZDQ2RjTXNpdjRYS1kwdXdL?=
 =?utf-8?B?T011SVQ3Zk40YnFNZUVGNTIxaDIwVDVlLzkrcGxyUjJDVnpLLzdudFpVRnJU?=
 =?utf-8?B?QWppLzJaQUZaRHpnSndWM2RRQmRqQk9KTUxFZ1o3WGlYdUE2MEY1a3RwL0Mx?=
 =?utf-8?B?ZU5xZ080dm16V2ZQL3ZlL0dENk9zSnJ3cVdTWWsraFVvbXNWS2JoVHp4cWR2?=
 =?utf-8?B?enFsOE54dldVKzhsbEo1MG1Ibkl4VU15SDFRalI1b016dFdjMUhRRmhJTVhk?=
 =?utf-8?B?UlRsbmgybGI0eWwrSHh1YlBqZVBaRmh5d3BYZkNTNGIxWnd6Rjh1YlBnMkFR?=
 =?utf-8?B?bzB5Vkgxc3FJTnlRTTl6aUtheE9VdFNmZ2tkM3RLUTlITVI2cXNkTWhoT1Jt?=
 =?utf-8?B?QTRKTkpWbFVnQnNqbUZGM2Yzd0pEL0VOcHRkUmczU2Q2cjdxUFVMUWdrUUVO?=
 =?utf-8?B?a2FON3hwZWg2Vm5JL1ZlSFJRZXlITWxNaVNaV0FTaXBxT2REOUJvQ1lLNnN2?=
 =?utf-8?B?emRMbURrSlhRRE5lREQya0dyL3JrcEV4WEU2aVBUWk9mSDBOZUdTMk5GZ0hW?=
 =?utf-8?B?QUNnWGVIa3dhbTk0QllXWEdUdnA2RE9jQUs5WW1OdVpPQkZIT0RNcUpkYXlt?=
 =?utf-8?B?bTBlZlVtNVpvK1RTc1pCZ2xGKytXUXJ2RXUwUy9rUUhNUm50Q2s2MmtWa2VS?=
 =?utf-8?B?Y2RFakRNTDNPWS8rRWtHRVRkVnNVV3YwZm1qL3NrbDdhUEs1SThjdjF4VVhq?=
 =?utf-8?Q?LnBl5QoIqW7ianrOw3cmtu9dLHzoXnByQavp3rgDR4SIL?=
X-MS-Exchange-AntiSpam-MessageData-1: t93O016oSkdFUg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9e43cc-3a2f-4370-dd52-08deedf577d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:46:06.7640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nc53+qMfWxky0I+pqbTAAPgRk2tpjm1AFAfh9zL9ODKfE0rfLuSTmMUTiatLW1crAXsHMScycahzJ51cd99ZpA==
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

When host1x_fence_create() fails, avoid trying to attach the error
pointer to the out syncobj.

Fixes: 13abe0bb15ce ("drm/tegra: Implement job submission part of new UAPI")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/submit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 5dad6dc4eb8c..3f20b5a24447 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -655,6 +655,7 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		if (IS_ERR(fence)) {
 			err = PTR_ERR(fence);
 			SUBMIT_ERR(context, "failed to create postfence: %d", err);
+			goto put_job;
 		}
 
 		drm_syncobj_replace_fence(syncobj, fence);

-- 
2.53.0

