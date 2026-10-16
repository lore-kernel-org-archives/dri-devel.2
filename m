Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7609ECCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B50E1125E3;
	Fri, 16 Oct 2026 06:48:25 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEAE1125ED
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaoEGuDGxJ3o3YS+8ce4zfYNlmKbFJlltUoc92eKkoWKNzVIJs9FNV98Mc778c5vsPAC8MP1anSpLUVQLfZ+pLZP6Zp84DaTHbHgGjo1WViMF2aXncZxPyWojZmr5e1qr/Zg7HzlnUwBbB8N8FoWUdNqKHBgAJ1jyPNt+G+avAOzikIGJubqoJ1aAxGIYijSNLgpyseAF2gQeTbt8APJROYRNOwb+pwQ4lHY7U2xlaoXbR+fsA1S1XehrUQRhQJOdo72W9V+BZ/6q4+dBCp6XKEpzFjJCNqL1JY4QhO+IqWEn0apr9ibvRCiWPd70uWZYkrukt+By1JeQxMUguyPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv0R3sF7wsJgZU60VZ8/pRKkD+HZvrdCnXYpAuIDiZ8=;
 b=s45ZV7WeZsVvrq8aLtWAgG+ChsuzczplIy2UE4lDK+wPs8rNK8ftnBSb8oNJn+4ZTYqOkmiHU4DXqmUb2H36tlJBETR02HSVw/Kq+hWvMaVXCaFVkRZiQ+CpE5WlA9i9xdnfMSHJeY3ljFvB7+9dguLbTeUEwa5mXuYlyP7bk6C92e6xJSbLbklTc3Gp4UrlXOYuuyfVOsEMkVwJ4tT3zq7uUa+SGGCfDY21OxbnpD8Ll75CjI9K/fHk/ccQSPYzkQjGE8T8QK8QvC2hyot+FD7KfXmzuWEF0G0xJRC149LP2oEH66snZOs4/FnXoBZ19yui7S2Y6vqEsgIsCRYqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv0R3sF7wsJgZU60VZ8/pRKkD+HZvrdCnXYpAuIDiZ8=;
 b=gZhg9TBK3AasYcyu6CWcJEvQfKLsVFsNSvWYcuqNkclTvupjV5PNPa9CXPZNkJhoZbBbdNomzXJ8IcDSIZFoPf+GjL1fTF9BcDsXqCyIXSxCEpy58Z+R2h01JGnvGflMEel60Cai0WzkA7dFsmtJOil8z2yUjlgz/ORAN+EjjwXH4TWFEt5P3TPCPOmD3XEOi7IUySJJDdJlXBW8zrGrYhhPQY1aoBsQkW9N1sN9qqZ/FQTY+qJQLpWKua7wasrlpAFC1vZ0PFoUGc6YkDIPDIv9Up3NzTz9rxSIZ+dU6ebf+X6Zt7W4m1BgMfOJFeLUv43Km2V0wVYhy3mp1qPUwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:48:11 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:48:11 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:56 +0900
Subject: [PATCH v2 10/11] drm/tegra: Drop release of legacy 32-bit ARM DMA
 domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-10-b06842a01938@nvidia.com>
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: a321641d-1657-41b3-1b92-08df2b5171ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Ixdn6SFMffTjFX+Ypgypsb51WR7oBJ7r9nxLk5NnzVGPeqrQqUb2PEZNu21Zz3nY+ImgwG2lyJ8jYAShYRO0AWOwCjzB+fYcZ2OURt1OysG8P1ldyRlhz8gGuu2Bw8SCnSOWFgIllgiKssDzSY5D0KSF4hIzaAEmKlobuO2UtSmpJ09bgFRyeovoCd1VMY1alcltZFmbU+6Skcuzv2+Kq76Npz5P+x4kLPa6KFIs6xrVwhAH92DEpKlUwMXc7CqoBbBmnoFUJpaoDmlyMxvKnhbQ+SaLyBvjnmkTHhOreK2xiqxoEjANqSPvv15ErkClr3LG2LqJwyy+7dBiJK0YSqXeZJ75N8o/ppVak0dE3X2RKWcx3hxitvr4TXUnUrs4JEqLlX7q9xbRchZ1cuwulOfDW4U/LMJIsEoOL6wcq6+0Zw0GKFOjPkUBlHlqbDsNDzyZT0/BeB8b1FMaSAcbmS20RgfRgSViRYiEClYcD5L4bU6M6nNMgFoHe8OakK2+TmjKnTC6ywoeEEJOtYSQ+MMuEiYpTAToikedmMQmLka1VrudasHtS5DDiR9MoJvEKwDESpK1udy3V5S6ItTH7lNpA5LudJ1kbZtJnC9ndTIU5Davtd8HI3UUBGdZ+jD4yNesBGNrdv8duOd/ZvNL2vVlr9MlcDgBsNqn1dk6KrQZld1Lch2VpBcv0YaoR+I0OHDweOEDJNsr5y0d6jLTuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmxVd2NpdVVWV2hBQnVrWitOY1dqYjROU2dGMWt1aW5kU1dDUDNhTzY5RURv?=
 =?utf-8?B?QkxjWGFtNkpNc0Z4YU1NRDd1RkgzMk9OSU5iWWIrbmlEeHNoUXRBamZGemJj?=
 =?utf-8?B?RFVVUXc1OTZTY0luTXNHaGtpaXJUN3IyU0JKZEhOMnV4S3VOVkdnbjgxNHBN?=
 =?utf-8?B?R2piellCRGdmOFRKSHRhS0RSVXZSdG9uV2RobDF4TmIyV3pCTVVWTkw1Q3Vv?=
 =?utf-8?B?ZnJoZHVRc0F5cDNnRGVkN1R6Wk1pSjFHbFZjUWZsS0tYU2NIWTVOUnRLcUhl?=
 =?utf-8?B?cmo2RlhkbzdlZ3NSaTVYck9GLzRZd3JuSndYOC92NGRQWjgvbysrb3NlNnJD?=
 =?utf-8?B?azczQzhGYXhoRDRxZUNBMFo4RmQ1N0NWUktoTkc5cDVLemZhVGtvUmZ1QWpi?=
 =?utf-8?B?RHdDYWdtVFB2eG5VUHFvcnRUMm9DS1Q5MzZ1RExlaVRGdlFGTVhBckd6UzI4?=
 =?utf-8?B?UFdTcmV4V0F5UjZqK2FvMCtaRUFpVDdjeVpkMW1HR3IzMVB5dXUra1dRcFRx?=
 =?utf-8?B?SHFCUnBndmhZQTlncFNidDVGb29qY2RoVXprOHZFT2xGV0NxWjg1WUdSSk83?=
 =?utf-8?B?Y2tveEtHY1lJUVlFYmx2bzd3K2s1Qk56REk2WitRVElQaWVuRjZwMXZlTFRT?=
 =?utf-8?B?OUF1TW1DZmptRlRKL1FkK2VvUmg5K2F1Vm9WenNMbjI0dkNlajRNcEJjOGsw?=
 =?utf-8?B?dHVzTXhDdVRVaW02eklVeHc5VHYvVWgvNW1aUUNFSlBTS1RIVTd5YzFZY2Q0?=
 =?utf-8?B?YUNKK1NPbW1sVHM0RlhRbGZXN0U1cS81cENldVhSQTdRNkg0MUl1ajQ5RjZo?=
 =?utf-8?B?c1F4ZWkyWVZXekVSUXBrc0N3Vml5NXVEVFMralVSTVdDb1orbnNCRzQyR3lF?=
 =?utf-8?B?a2ZCOFlkWjdvOXZFYnFJa0VGMnR5ODRET2lxZkRQQ0ZXWi9iZk5VZjRMRk1D?=
 =?utf-8?B?VXE4dmxaREFOTnZaaHZibDFhMW9lTnhwWThOL0RVUzNjTDNvdThyaXYvLzFC?=
 =?utf-8?B?Vkd5ZFdyNHh0WkdXOFRoNlpPM0Z5djRKcmMxZlg4Lzd5N2RrblVwalZoM05Y?=
 =?utf-8?B?bU1xbEMrMzhZK3JTUGE2ZmlLNnhCSTE2RXluQjJ0dmVkRDkvSDZvQldiVkR1?=
 =?utf-8?B?NG5sVm1UaDBJZmtnb0JMVTZLeEpzdUhHbG04TDVpNzdiWkdGdjFhQThpU3Jo?=
 =?utf-8?B?dEY5dTZjMWVkc2pRY05ONG9nR1hDWWhvUFpZOWF4NXlXb084clhvUUxwREVp?=
 =?utf-8?B?Z1lxdC9kdi9Xc2J6akdNKzg2cmxYZ0FFSVVQSStaVjBkUnp2SklpUnhnMjFF?=
 =?utf-8?B?SkoyMDVUYVBseXpDUVVVa0l3UnV4dENTTnh0TXduLzVwU2Z1cmpqam82ZkV3?=
 =?utf-8?B?UzZYSUVFcXVqYzZDK21oRldPdGFXRTlQSmRXQ3NiUEM5bGhRa0hWY1V5dXdh?=
 =?utf-8?B?MlNVckM4UGhRdFprcm1tcld0MWRaaWxId04za2lYZjZxSXRFNklhdEdqUzZi?=
 =?utf-8?B?QjlnTFNSVEpuRFhXMitYb1crcjBYSkdJaXRhZEZDWVh6Y2ttVy9XTHFFZGpl?=
 =?utf-8?B?Uk5LN045ZkJvRE83cEF6NTlpOW9zRWpSbnJxa3VXNjM4akhqMk1UT3drSThQ?=
 =?utf-8?B?ZjlGaWhScXkvU2ZvZ3lYTGw5UllteElzTGdWL096S0FBSVM2QStsWDc1dysv?=
 =?utf-8?B?emdTUUZYeDA3RXRNOUMvMzU0Uk53UFJTcVJCc3hrSEl0Zm0xL1RPWXBwdVNx?=
 =?utf-8?B?ZURlT2tYUWs5Rm9YbjVqQkRoa3hBaHZvaU52My9XSkhxbk9iRm1ZMHpkOHQ0?=
 =?utf-8?B?N25QWGtTNVphZDkvYUR1UDBlK3RNRWVKejBGZyt0bHFDQ1lOdGVUbTkzVkc2?=
 =?utf-8?B?Z2VGZEZrRVNHaGtFdURnNWhVZG1WZGk2UlFvbUlaOU5lck5hUjVRSU5WMUlk?=
 =?utf-8?B?Q1ozYktabGZGQjMxTWhVQTVaWTJsb3RCMDQrdlN0bUVBcHFwTkJrdG9wTjl2?=
 =?utf-8?B?YUdkYVREaUlwUmt0WFVLN0JLdjJuYktCb0NhOU1WV3dVZWljaUg0dzhTOWV4?=
 =?utf-8?B?R0ZuUGJRY3M1WVFYSlpPeW5mQlNjWnJ0TWZSaXlwalIzOCtEMk56VndzYU4w?=
 =?utf-8?B?emZETDBSTmdkYzVTclU5ZTRDdi80ZVFxZlVBeUdqS2FpYzd1WDlrdmg5ZmhE?=
 =?utf-8?B?TElyVjh0V3ErYTNHUFNndEg1Tkl3SGsxOWJWNnhYQWZMNWV5TEFQVDh3ZWlt?=
 =?utf-8?B?Tk5yd2FzYnZJZzBqZnB4bENTZVhXQlJQU1dPSVpxcFNvUkJGUGhwOVRuVzlJ?=
 =?utf-8?B?dDNrRjg4Y1YyaXR4MWh3eWxxZ1lSMEtaYnlnZ1hRUDRnUEpIK25CZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a321641d-1657-41b3-1b92-08df2b5171ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:48:11.1227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoxdL1dktxupWO4Jh34jHjBO4QLuh0rJlbHDJvhnds8hOugGlhhEjhzkG7WDovgzkSMwq66r1EgkZSPdQ43jpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

host1x_client_iommu_attach currently detaches a possible ARM DMA mapping
on the device, since it would get in the way of the shared domain
TegraDRM wants.

We are about to enable default domain based DMA domains for Host1x and
TegraDRM devices. These will take the same path as on 64-bit ARM, but
we need to avoid trying to detach the now perfectly functional mapping
on the device, so get rid of that code.

Strictly speaking, the code removed here would not be harmful but would
cause WARNs to happen.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 324480c87fb1..627fb7f04f39 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -25,10 +25,6 @@
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-#include <asm/dma-iommu.h>
-#endif
-
 #include "dc.h"
 #include "drm.h"
 #include "gem.h"
@@ -947,17 +943,6 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 	struct iommu_group *group = NULL;
 	int err;
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-	if (client->dev->archdata.mapping) {
-		struct dma_iommu_mapping *mapping =
-				to_dma_iommu_mapping(client->dev);
-		arm_iommu_detach_device(client->dev);
-		arm_iommu_release_mapping(mapping);
-
-		domain = iommu_get_domain_for_dev(client->dev);
-	}
-#endif
-
 	/*
 	 * If the host1x client is already attached to an IOMMU domain that is
 	 * not the shared IOMMU domain, don't try to attach it to a different

-- 
2.55.0

