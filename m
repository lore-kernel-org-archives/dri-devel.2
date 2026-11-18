Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C6606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mAHvxTTG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375DA10E16E;
	Wed, 18 Nov 2026 00:36:26 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BE910E16E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR+B9aM0+M0Z43/nueXoglqL6IYrD7F8GKR327N3Qzhc1WZq4FS+9gG/af50veUOXfjDVo40r0UU8cZelFL1DYKOj0U0ER9QbpHVL32aybic3dkYGWRlQv3tvYJ/tGvfzjfEf1pH71qG5jtsIw1DqSw45oxwvbXYDMk9vW5sI0aaIuYhO7gnm39Kifur3rn7gQwW8qrY+AxdD8Abgg4LKsy6r/YTFz27STnUynrWhOymj7ofFVxiEdQXIJHQXtmP7ljLFRn22DJXbAFu3hkqCIExdvPQg3tFWwQ4OyP4sSAKJ236iUtjW98UdRhfaidn5jQQwqF/6HTMN4LWigofzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhyX7Pq8rupwZiOFNLenV0by4H0jHLYIfRe+QYUFJnQ=;
 b=lbfubJldT+n6X8JYy44xL3YiNJiiGHIe7CQoKf+TOwgQirHS6p6p5zV/pTiz6HRUASZfV9izMZVY5fYuGHlBqHVfSKviP6ETnCDSfqX0oGU04I9ih4PbuLjw9V7RWDJ97gwkX8vq/oeoFhi6lGJb6c4ZDpEF8owdQbPKOWuejJ9jB8poYDqDiq707bHySO9rJGCG9bv/stj+00BZd+kRm0EYeFN3+3Or0Va4ZeCTyV3xtZy+X/CREGjYpSkyOysuxlhPdfM0MMM/2AFbEilrekIe+0cPlTnHW3pQ3Od4BQXzCdlZa26nfWW0YNa5i2vOvoUJEVPjw4XFILQIpEOz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhyX7Pq8rupwZiOFNLenV0by4H0jHLYIfRe+QYUFJnQ=;
 b=mAHvxTTGwL491zv1zvsVpIQOLeGFuHduR0VlmtlFFN3al5GFXf1gxrwL29ocLwJhaGC8LlmWuN+iHNHSDOHnSOHj47tjdwrayB7ijCJTm3pSgd3njK5340JBJ8d2POKicWhZCIFXuby8oexTcdeNZQ+F9tmh+H45Yk7+zqrA9yteB1PbomIlkf2j2tkHSZBDTUTGUNy6d6wLu09beNuhv2WwAnRm3zP+1USswRLcG6nm3ECNhNUGP6Aiom8eJtVJ8IM7D0eus7UgKjHGcGtf7bVdqkGn2nNKuPaWc2YY5vMrAhnzXbvxFE8VZsmLybT8KcU3H6js1ntL0VSganNffg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:13 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:13 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:10 +0900
Subject: [PATCH v4 01/12] iommu: Initialize default domain policy at core
 initcall level
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-1-0c5561288e22@nvidia.com>
References: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
In-Reply-To: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fa8c09-9cd3-4f37-dac4-08df450bf327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|11063799006|56012099006|261102123227099003|261102130727099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 5m5pM/NhCqRw2ePNoqa6k7+ny4umDWovaQWxobOQBLjgBbavFr3A0Sua1EdQVbIDQbvohNrWyeEUsUFFi//3DIb3w9tX2QA+cUBYnH8HYKM0fdm9FvhzWyI3PheNwR+ySMO60Isv/E1RsA0Gqr5tPd7g4x/8iEiHByrqx1swGnGD3tTnuB1+XqaOyZ6fHeLgbKSm+2M+pRJ+49K3/RCMCf9sohn5vRBpOgdctDBZhzRM+TiWsSd6P1IUNn4l4iHrg3pVXIBJrkQb5noEpzV1HIOs6GpC99moTQuINMWQNnkmApI4xs8Z2t1mWc2Uyn0Uk51xgd4uWpgONUfzNUFwXMwNe/SP4JUHh856PeS8xXMe2iE8Kdn3I8QxipCaT+eluClmWeqL9KXvEvDMFv91DX+ZuoLmRB6Nm2k3JS7+lFD5nxWNwSIwqi0fdeCdFLeGUY2TzHdD8L6ENDpZxNqPDx1SlfhVyk0Rdh3Wp4Z6QOwGqeAinDTDcVKajOyqP4QoIPMYJLtUZLB94XAWqW7lUX4MOx5W6IHwSZYUIi/hQa26hxEOrDCcDCVjfMmHFhCwxmNrSJADzAwh459Lw4k6lMWjYFm8g1KIo94RjD2JWTqtQWLDyHcloOpeXYUUxzmqI8dfqmHGSint0ToXKdKFcMkL+NOTAV9YgvEpLJy6WFeN+97eUKER+xkfAPVD+vxLCceAifcSnXmuYMMltrBLKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261102123227099003)(261102130727099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NnMkVXdm5XT2lYd0lnTHBqR1dIWVZKc3hxNUczcHBST2lTSm1UWDcxYVhY?=
 =?utf-8?B?bHBETTJLNDFXcVdNcnhGVzhEOFpKRUlWN25jU2o4aHlyNUo5bEJRTVZRSEVT?=
 =?utf-8?B?Ni9GV2FaSmFRU050L3B4N2ozK1hLRWloNkFlSC9RKzNhWW1DZHJwcDNXcUdx?=
 =?utf-8?B?d2JldEx4NUwzMDI5dktaK2VYbW91L3doWTZXOUVnU1F3OXR0YTlCZVI4czB2?=
 =?utf-8?B?VEZzc0FaT0xDZHZ0VloremFOd0laNkZtUUptTTlrRkRxQzNqS3Y5L2xyYzIv?=
 =?utf-8?B?ZkFNbm4yRkpla3FLdzFORGx6NFNDVEtHZnU5ejdNRHNsQktXV3BkbC9CblNv?=
 =?utf-8?B?Q2FSaWltTE1GbXQzUFA4SUJ0RjdmN0szaStPVGU2aDFQQW9VL0RlL2IvTlNL?=
 =?utf-8?B?YzlNUXVkSGhEb3NjcFZROEtXem5oLzJJd254c090RnVEb3hxRXNUdTZQOG5y?=
 =?utf-8?B?NU85Y2krcWIrUjNVTUN0eUl6UERqNTlwU3FtL2thdEVEZ3I3bXMzT3QreXZo?=
 =?utf-8?B?R1hxR2I4dmpqRTliVVlmUWxvUnlPV0pKY0VrdHdGL3JoTVRrYVU3WUJZVytX?=
 =?utf-8?B?aklVejZNQkRrM3VpQVBqZWZlRUVrL1JKaXJrZFc5ekxZVC9BM3ViZEEvaWli?=
 =?utf-8?B?Q3c2TW5aUDlodU1USmFPQUpiTWNIT1JYWXNnZllsZk9KbGUwNkFjenJkdWZv?=
 =?utf-8?B?UXdpNlpWd3BLY0lkWUNtLy8zYWQzTGFtV1U5Umw3VHB2SVcrREJxdDV4c2pM?=
 =?utf-8?B?d0UxbDNOOHEwM29UaVVjS3FWaWcrdi9Ca2pMVHNTeStTcEp4S0d4YXV6eDlj?=
 =?utf-8?B?ZWNOZG1PT0d1bGxTNzlvWmRYZnlYK1BuRkNLS2U3cmYxbjlocE1JbUJvSkdU?=
 =?utf-8?B?dEQ2L2xxWUZZOXpldEpXQTBnTC9jQVplZjRPMU84NXVXT0tSd203TWxSSXV4?=
 =?utf-8?B?M20zWUphUloyUFZMSmZHa0lMSHV2c0VHaEhRYVZocFBXb2tLRE5KZmZIUlQy?=
 =?utf-8?B?OVhBV0ZpbUlvSDlOenJmYjlQRkdNOEdLQTBqK2VHRDNhSEhPRzNON016Vk1a?=
 =?utf-8?B?dEw3TlRZK0dXTVprNktqaVN5RExLOFMwZ3hZNDI4WXZtV3VSV09OY1RjV1Y1?=
 =?utf-8?B?Q3Z6WmkvbVZXaHBOZnZldzhZNHBMcUZla0NBSWY3UU1NTFIrNTBMdjJiV2lN?=
 =?utf-8?B?WGpQdDJsdWRKUHE2dXNRcXgyQktseW9PR00vTFZkVlc3U0hjK0RBMjBHUWky?=
 =?utf-8?B?eW5HNWliS2lRNXQ0WWRuWEFwVDdkQ1ErQWtzYmgrR2ZkdnZHNWZ4cy9DQjR0?=
 =?utf-8?B?Tm9FdU9HVVJJdkhEdy80UDdsNDlQRlhUMUtXbVNqMHk0a0gzT2g2UmpWYnBD?=
 =?utf-8?B?V2RPc3k4amo0S3E2elpGaW9LOXR5dWYxZm5BOHFqaDBISHVZU3d6OUZjUmVO?=
 =?utf-8?B?S3JKc0FlbzF4NFh5bWo5S1ZYaHp6S05UWEhENFY1czhtSTB1Z056NWhZN01p?=
 =?utf-8?B?UWVaQzhhYTE1ZEFtOTBjbEVEdS9rRUlkRVRoQjVicTNoQWczcVFqTFZxVkJQ?=
 =?utf-8?B?QXZoOGwxYzZxd3N0VFArSzJKR2VYbEtKUzVXN0NsYTY1cndxNDAzQzltVUpL?=
 =?utf-8?B?Wi9xbWh3VnhVVXd4bC9ubzVpZm1wRVVvWWV5d3NmdENCYVMyTXB2RUc4SVNt?=
 =?utf-8?B?enBZTkVaajJKcXliRkJBTmFuZGlDZTA5T2tHT2ZwNElINUN6ZVVUY3ZGbGdC?=
 =?utf-8?B?T3NIaEJwd2NQdkx0akdtckR1Y3BJV0xJMXlVTGFzTWV2NGZONDFRMmhja2xJ?=
 =?utf-8?B?ZjZwc2lIc2QxQlBjeVIxQU1VMmcvbE50R09LL25rajViR1NRY1gyeVJsY013?=
 =?utf-8?B?SUdrZE1pZnduY3dNdXNYZnl6Zkdtd0ZPN1NiRHE4ZHVOY1JQQ0lZQVp2ODJZ?=
 =?utf-8?B?TGs4d1BHWG5zMjR3a21rRnE3NEU2dU1mTlRNMTdPdUhmVk5ianhLVU5wUUxB?=
 =?utf-8?B?UkVwVDc2N1BjSGw1V2dHU0UzVnZXRTNYSkJvZFRHbUhQM0JzZlhuZmx2WjJo?=
 =?utf-8?B?MmYwTm9laGlVbXZrcXNGVWJlOGl3V0Q4eUlDQVN3dDlFNWp0T3FXUFFlVGpu?=
 =?utf-8?B?SjRBQXZnRnZIMGhKeFZaTklUbHRZY2lhaExzQlJ0a1VMS0NzVXpZTjQ0KzNW?=
 =?utf-8?B?L3JWTEUxQ3A4aXh1L0RHbVpuQ2Y1aEIyUjQvMGVRc0Y1SWI4cFBIRHVZdVRN?=
 =?utf-8?B?QXVCOXBQeTV1SHZuaUlGRnA4SFlSMGprVU8rYjJRWUE0NFl5MUJYT0hhTmZi?=
 =?utf-8?B?bkRrVFBHbGdVUjBFT3NuVHdic3dEZTB2VkFIazJiQ0x6OE41MHhaMW01L1lG?=
 =?utf-8?Q?camBpx3mVdQI+z+CMgxqatG8fX9lL1LP8b3arzrV/hxnP?=
X-MS-Exchange-AntiSpam-MessageData-1: Yu8D5CzhU1gBtA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fa8c09-9cd3-4f37-dac4-08df450bf327
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:13.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHm0EbYO56CuKQF0mQcrWRbhElVZM04ofjeMCHW++vX21gD7h+L4Zo5xhCqQmupUd3qmuYgVjZRhL/NTsWVC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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

The default domain policy is currently initialized in iommu_subsys_init,
but IOMMU drivers can register and create groups before subsys_initcall.
If the default policy is needed before iommu_subsys_init has been
executed, a warning is printed and IOMMU_DOMAIN_DMA will be used. Marek
observed this on Exynos on 32-bit ARM after a later patch in this series
removes the IDENTITY default domain override for 32-bit ARM platforms.

Fix the issue by moving the default domain policy initialization into
iommu_init, which executes at core initcall level.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/r/6fb3327c-766c-433c-b49d-dc62470d7102@samsung.com
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..35edc2097996 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -225,10 +225,8 @@ static const char *iommu_domain_type_str(unsigned int t)
 	}
 }
 
-static int __init iommu_subsys_init(void)
+static void __init iommu_init_def_domain_type(void)
 {
-	struct notifier_block *nb;
-
 	if (!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API)) {
 		if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
 			iommu_set_default_passthrough(false);
@@ -254,6 +252,11 @@ static int __init iommu_subsys_init(void)
 			iommu_dma_strict ? "strict" : "lazy",
 			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
 				" (set via kernel command line)" : "");
+}
+
+static int __init iommu_subsys_init(void)
+{
+	struct notifier_block *nb;
 
 	nb = kzalloc_objs(*nb, ARRAY_SIZE(iommu_buses));
 	if (!nb)
@@ -2951,6 +2954,8 @@ EXPORT_SYMBOL_GPL(report_iommu_fault);
 
 static int __init iommu_init(void)
 {
+	iommu_init_def_domain_type();
+
 	iommu_group_kset = kset_create_and_add("iommu_groups",
 					       NULL, kernel_kobj);
 	BUG_ON(!iommu_group_kset);

-- 
2.56.1

