Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F84CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1B8112603;
	Fri, 16 Oct 2026 06:48:20 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C953E1125F5
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnyXd1tE+7yr7DBRBN52zRrBBP27vdEinVMuJinDpIbH/LQXi9nGLlBqMNLOegooYfaeD6tTnlFX62fa2GqhFZGFkjvmfecBXEvZHpt2SVGATmqUkZ0a496OngQyCKMajl5eEFFdoDdQblLTIn9A+Q7irwUJctHr3nN7MWthoYFeI7rOphz8raqpkwJvIOEcESTclM1DB8r8T18jSLWNQeJ3NuZo7dL1vT3lhYuBDY9RpgiF6WLhB34bPoC6s+BC8SKupEXH6SrtgCUWq2qe/RiINLrjkMMQXJranBCVodxBXrDadWK24BdF3xQFZsdiVUL0wVjWppnB2xn9RXtvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/BGTBmA7EOLtMV3zQj3QDcnMH5+WPQymFEz0YZtUKw=;
 b=ey246+1C8r+ZyLXu1DbD3TBoiqQXiW5Tty7412vwEdCK8aDKup0qge5kisXS9SSFsHKzbW8qU65CFyJN+Um7KY+nLJQii2MMHyZlaHrQWzJA1afCN3Evx5DJzAzOR+FbSRVBletyfgkQvj4WZKr4inQg7inn2NRrvRjpHcMxxuUC3uARwhun5E6SM8td/wo2TK5u3AZ0pn2C3FB6nKGmpOXYz0S+eaB+Pyl4E+QC0JvnzlNQE5vhM6jCbh0a/akchWHZa4JFAJuVcq0sWDvrBZzQ8mPvn7pKlLJdbSLyVFSzYKbADgfsY3+hIJuPnB2Dfw346McJhdLWl4Stmgz7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/BGTBmA7EOLtMV3zQj3QDcnMH5+WPQymFEz0YZtUKw=;
 b=jdmkAELYRV5xxMhpajFLVYdKUc2m2bl5GqAdh+FTlpb0shsPeoHapobngaQYCDVYjVCVxJ9eWlx4H4O0OJLqxRnDvLu6Ugy9BnjapM4wkq0CQJRdzzum2xlDzBZw5k3CH8DOvPKYE9tXymU7Q8ge0HHIE3DBbKCwtb4Jzx+/gtVssH+VhnxOdWEjkn6hkMGdzrk4RkR4JRdQVfAUX1BMKbqvqwFUKZZiTUoLs9JgQ/Gx6UfVG0bUJ+EMFXyvCYDJZQL36tjVaMW1nQjti3/YM2mMeWxkCUghtXTOzwdmJX8iLGXPKd4P3t+MjoXENQbtpnCNzX7ZtB3OlP3FSWkGQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:48:05 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:48:05 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:55 +0900
Subject: [PATCH v2 09/11] gpu: host1x: Drop release of legacy 32-bit ARM
 DMA domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-9-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 401e96db-24f0-4924-412f-08df2b516e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 1g//LiHqQVaYmt/+xqS6cbxS3Ba8aK4PDNS5J03LXyVNLGwJ1aZ3FB9fE67BpzGd17PESG/Gm24hXxMFJW/zk9T5BTkEMuM0C9k23BJHa0kVZgrY5OznfuMuNV2CwnuIrLIXc6HgLgXXpGUOvkMSb7kd/e3ZVZedobciSk+SE36hY9FnHORc1SarDmOhQXWJVyk3TD6R12nnbyb5+BlIo9B/aNyeES1b4bf3kYW/6QDLMduOu2QcjghCi6//SlnTOijVA1mSM2kniCeuHic4vu4y19UQJRJRTuRroaq6fAYs0puAWYmfgykoHqoVGKVLrHHNaPbMq3a0iUXgnXSd9O/f7LgrriujW6BfhlVuPq3jBPNEyIq/JwhWr72Xdy1Gh4r+r28rsFcPnKZwUdpZsInYfUXhcrWFZsG9dbbHpgvHveKOwKkZD6vMiKSg3+CzandiZ/07EBg6nnX19V2UxO2aWil37u5Gp3isV+dtsKu2gnnRYCR2jN7KE8uyxLgUoSg1Bp7RpGSUMgQLBq5l7tQ5fyeQtSdXwZT0vc26aozqH/M8yxTfflpHJBZC6JnUE4bmAWIbCm8uFbKXRrABkj8uuR4t5LbdbUjBMSQrb62xMVAfehfJCmM+BNFIRaco8//epClxzM87AKJ78byXgf7G+f5iynCTxlodBDdKVs/tjtYkJwJq2yOSMDF0gbgT3igRTFQk/wufVLTzj/kZyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2pGZ24zMVphT3hjSUtZSlN1ZEpVbzBiRzNJTjVZUnJsclFvWWR2S05FN3Fj?=
 =?utf-8?B?OVZtcEVqU1dTNjhUaVR1enA3eHJiWlc2eWJvRkJ3aDYvbk44cGhXbmd4bTlK?=
 =?utf-8?B?UG1yMWpaWXFhRGZMWnBBdmk2RmNmZnByTWRaVlZtbHIyOWlBT2dSMUg3Qm9Q?=
 =?utf-8?B?Vmp5ekJVcVhLclFYYk42cXVpdFlFZ1hvRWRIWGxtZncwV0ZuRlVJMFVudGQ2?=
 =?utf-8?B?WnBEbkpwUVY2ZStFaGtHMVJVdDVIK3FLdndNbFdZMnZmVEt2cExKT3RHckI3?=
 =?utf-8?B?aDFlTUlZWHdKeWNGek9paUdzZE1kSnhYN21raHJVSWxBZGMwSmtCOVR1bXhQ?=
 =?utf-8?B?WU51SnZ6TDRRamRVVm9ZekR3RFNZL0FWeTkvS0o2ZnZGZWlrVktBSkhoYk91?=
 =?utf-8?B?N000NnJ4cWNDOWVkYWVEdjl3eE11VFJ0M1N1ekxPRFM2cDIxazIzUGVnMXkx?=
 =?utf-8?B?b1BFVS9WMXo3djRzQ0VRNHNyRC80UGtGTmJQOTJmSTlzZjNhNS9NVjhGRUJ3?=
 =?utf-8?B?aStJd3VybEFLdkkzdnM0MTI0TnIvbzZtZlFNWVFaY29obndrYkRQZ0tFK2Za?=
 =?utf-8?B?VGNMR2hzM2ZHSnZzeitCUE5VNlEvTUxHdTlnM2tFV0ZualpQMlUyQlZwb0tr?=
 =?utf-8?B?V1NBRlhoODRSbThKcENqVE1LOTJjaWZJUXU5azA2c2ZQRDRaZnUvQTNORDZS?=
 =?utf-8?B?MEhGbitWT3BsNENZbGhvb2ExbzNrQTRsWmJHV3JmeGlkRWs1cWo0YTdEeGRa?=
 =?utf-8?B?MVk1WVkxdUZqbkpyTFVYTzkwT2czT1kyRVM0L1BQWTRpWDFRRVFmMHV1Q3Z4?=
 =?utf-8?B?WEpFQWp4NlZVY1ZIMEZqNFRqN2lzbHB6NHdtcHJ4cXJzSWZjUmErbjUzVXhZ?=
 =?utf-8?B?MlJ3c2MvOWt0MmtmeUZXRTVoZC94UUl3WnFjL3lTK3RVUjViSEc2T2ZXdDUy?=
 =?utf-8?B?WG0wTDByaTJ6dExvMHhaRnZ3b0U1MXFFaDBxTDh1YS9xQ1dSdTZDT1RpSVFj?=
 =?utf-8?B?NzJ2cDg3Ty9rZ2s1bEFsWDRaT3lVbTMvaCtndU5rWldyY0ZpemVmWmdFQmVo?=
 =?utf-8?B?SkJjblNPNlRmYzJ5TEVXMmFMbHVzUDNESFFjdXo0UEQzVE90SzdzdmVuZ2l2?=
 =?utf-8?B?STB5Uy9kM0RORVRHcEJIQWNqZUdLaGQxVTVhTnhTdUNHZTlleDZDa0tNT3hp?=
 =?utf-8?B?aWo2aHVqem9rcW1lS0lYb0h6V21UYWxRcmtLSXRjOC90UmJyc294ZGlVQnBP?=
 =?utf-8?B?SGJLNDNpcXVwaE04Si9TYmhLb3UvQmkyT29WaG0rS1VudjBKcExmWkJRdDRo?=
 =?utf-8?B?T1c3UDVmeWt1b2FvVTVBU1dpM1JMQ0RSUm9XbnNxaytvd1kwc256ZEd4Z0dr?=
 =?utf-8?B?bHVJNTdqaUlTS2dYTk1YM1FjZXZzandDM0ozUTM1empMNys2V05FeDdSb0t5?=
 =?utf-8?B?b3V0amdXbGtKVHoxcUE0MHBCdmdCQ3J4Z2UxWWZZOGg0bEFabGhjdUx6NTJp?=
 =?utf-8?B?K2o4cWN1ckVDUjFHZ1pUbTFtSFlndllsOGx2M3BseHJWeDRQTGJqNWFYV1B2?=
 =?utf-8?B?T2twQlM4TERIZ3M4MDJoUE1pMWxCRkoxQW1sVDhEUzhZRlYzZTdkVW5GTjZZ?=
 =?utf-8?B?TWJGaW9CdlJkbG9ZbDRRaEZtUzNDelJiZ1VYMnNLdjhjb3ZhdGo0dGVCYlBi?=
 =?utf-8?B?TkM2aDRzTDY5UGx0VFBqRjk3MUlJYnNxcFJVcEh4Ni9NS2Q4eE5xNU85WlFJ?=
 =?utf-8?B?c1BEL1lzUnpSTHkxS1l4YmpIREVOa3hFQXNLLy9mL3laMlduR1ZJU3M1c0FU?=
 =?utf-8?B?VkN4clZ1SmllNmpYemxNSmo3LzR1Q3BLMk5lN3R6WWR3VFJrZjl3b2RKd1BK?=
 =?utf-8?B?OW1Ba0pxOEdhKzM2d1lUMFVBZjdBYWgwY2RzTzVZa255U2NmdkhtdUVNMENa?=
 =?utf-8?B?UC9TNWVDUlVzK1RSNGR4b1FMejRTTVhRZXRZYVBxc3Yvdm9JK214a1hKTVpF?=
 =?utf-8?B?TTRrQ3hzN2FYdG45Ky90dTZtUHNTKzdhRng4d3lvSkJnYTdHMWtZbUJYV3Ji?=
 =?utf-8?B?d25vZHo3OWRrMjFsSVZNTnVOMGh1ZTNYQ3JNV1FvWXRGMnZLam5YYmJRdWVB?=
 =?utf-8?B?alMxcE1IMmRxSDRBeXRaTVI3aEdwLzlGWFA3c2RpRGNXVWlWOVNoVkF5VDhx?=
 =?utf-8?B?cFg0YzJseGIvbkdISlY1ekE3RjBMZnpvOU0yNVdqTU1lUjA1eHltSUlWakl2?=
 =?utf-8?B?NzE4d2tiYXF4N1paTHBVT2ljZkxIbWNla3pnZXJJRVVxTTg3RnB4Z2pRNXB5?=
 =?utf-8?B?eG43MDVBYWl5clF5c2pFQmlGR3J5cTVXWkxDYUFEeDczQm5pK0lVUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401e96db-24f0-4924-412f-08df2b516e76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:48:05.6445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aBxBjmmwjcCNxIKkHTDU5oCbfjN99IWMlaU+X0QK/jwk+dmhx2QjdHCmwbkT8AYEmbbaQgp17y2R58VbwTOFA==
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

host1x_iommu_attach currently detaches a possible ARM DMA mapping on the
device, since it would get in the way of the shared domain host1x wants.

We are about to enable default domain based DMA domains for Host1x and
TegraDRM devices. These will take the same path as on 64-bit ARM, but
we need to avoid trying to detach the now perfectly functional mapping
on the device, so get rid of that code.

Strictly speaking, the code removed here would not be harmful but would
cause WARNs to happen.

nouveau and tegra-vde have the same construct, but their clients stay on
identity domains for now, so those copies are left alone.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d2c64728f804..926553b2326f 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -23,10 +23,6 @@
 #include <trace/events/host1x.h>
 #undef CREATE_TRACE_POINTS
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-#include <asm/dma-iommu.h>
-#endif
-
 #include "bus.h"
 #include "channel.h"
 #include "context.h"
@@ -420,17 +416,6 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 	struct iommu_domain *domain = iommu_get_domain_for_dev(host->dev);
 	int err;
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-	if (host->dev->archdata.mapping) {
-		struct dma_iommu_mapping *mapping =
-				to_dma_iommu_mapping(host->dev);
-		arm_iommu_detach_device(host->dev);
-		arm_iommu_release_mapping(mapping);
-
-		domain = iommu_get_domain_for_dev(host->dev);
-	}
-#endif
-
 	/*
 	 * We may not always want to enable IOMMU support (for example if the
 	 * host1x firewall is already enabled and we don't support addressing

-- 
2.55.0

