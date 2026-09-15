Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBA9C88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2506289C69;
	Tue, 15 Sep 2026 02:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pxk1L5qT";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6247310F86A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SALIBZfs6sePRuemAYA1ONlzC2wFPpheX/DPFuwsJgrc2GI84zQbSHQy+tXIGx/NNyhtDXW2GOBOkVTapXNtQ6m2bTbIgMWFm8tg9RokmGnvfSvhAkuTWnDwccoY9l/rorGYZDbXGPYyNRCAXyYQCU+QNCRpN5O1W9gP3VejRj14VvIMeYXfAfW+UK1nttXaFBWXtsy0t0Mykg30kOoQ2f9QNEg2SiISm96NfnLQZcG2KaGkeqdP2DeS6KL8VrhP1D3F8iU18IuXOUENULX08hYFd2Lt7QT//BgwxsSlV+VsUf4WGxd4CaAzhzNI6GPhF33f+AAIQnydDtnUt1+RsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWqbm7NWA61Zo6gQtfmiSwsJCSj87sNn5fjdTEv55gk=;
 b=g74XgdYTOvTGfJ1JD+LmaHZ9T2+6sPm5ecUmkAx90xYv1LlcVvx5ExM+aSyZi2l0VxtvB7jVtQrvaREWfO9ChYk/VEqvPe6MfgGO8DDHy5surK1BZe0WiALoAVAN+wDxHQMvJ+hui6jkye3+U+gVePs/BT28F+QeihmUcjkaNPWgUMOkD4Bagfo8/MoWTr+6GsRkvFsjtanF7Bi2AHsm8CoPh40SjV5yq5XYfaCLqs8lxoPQWsbtBHliYGKVl3wee2INLSr0+gm5k8WvgezTRToWf5jubHPXrMTWApS4q4YmY/I9O7FVPSk19ZG5khpeP9+10g+isSfJZAhuCjCmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWqbm7NWA61Zo6gQtfmiSwsJCSj87sNn5fjdTEv55gk=;
 b=Pxk1L5qTW0+geFhmchgR5AhGigdgngXfsjDgcZ73AEByz5zOoZtdh/gpEM7wfblKdOHRWO5MfbUn3YtQJr28zm1LtQ2/2+whOaS8eNfjD7VLpmCxVajRK6BythrZsrRQNi3FyNvv/zgWAkAY7uRSJagJOwfngmtj1wwebslCFsBbNF8w6za0DaeNU3DSScSyH5xM7/yhQlTEGYOXn6FM39Zw2v8h8Rol9JxK8INQuxQhOPzRxX+xP9MCGWON37dWyJJskoGjnLWPA8biP70VvlJA7co2SRye72DPSRpTVP2k9f4ijZuFQ+Q+Dard0IY6zGm/AoNdO7er7zKQUwAatA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:16:19 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:16:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:15:05 +0900
Subject: [PATCH 10/11] drm/tegra: Drop release of legacy 32-bit ARM DMA domain
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-10-ba4f9d33a2b8@nvidia.com>
References: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
In-Reply-To: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PSBPR02CA0004.apcprd02.prod.outlook.com (2603:1096:301::14)
 To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 657f691f-c474-4301-e738-08df12cf5471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: agL0MD4q1PxWaj/RtR103cdWsLGqmcRjE3ATu5jpz2aTwwBBHfIjhRBvtxnM3Wz4CiRB2lWiE/EZdSudB9Vnhh1E/hnwWVVlGLupwb7wZAxFh+TCjxDvAtI6Kgh1prIJGHEYcj+aOFUmKKxELeBN4oyGmHV23HuXJbrrI8nxHGul7zbZ0FfB8tDavBJ5fM7In2hh0fD+EPHsQ/lgWifSAlqh1prRrXiq/CxEbN5aDXMzXAq26VfKBdO0x1M750Uqx1fhEmoWwP/1OPfEVknX2XBtJ48LRNG8LwN35KLx2hVeJRl0XCJnQkpgSN4iW9zQ3WcPdkk3tEQ59Ljvk+PMAZo1d94l/WjT/ILqO6tZvEct3xLgRHpPdsR5wm4JkixH7HKp7LTYf5hxtQRBDc1y4yek7yedn1uGueBLu8Ybq3agr8BjX/QDC5abcZ48rPqUouOJ7tmsncTlHjw+Oytq8KBgchp5CkYRVFpuYjUx1Gk0CjSipOH/boINU9n9LpJAv8KY0gGgyA6d8P8tVMsG9BKbzGvOhR7LFG1bYWU7nuGjXDLeiyxlfnIUWR6a7sMGVjxW/V7TAecUpqyePHhv9YzhUV+sCSnachql6/d/iZ20fKiohuZoBfZ/RCX1/2yiXG+4e3KtY1MdKDu+q7sPm/z3EeyrjJBVkl/BA4T5CzSiwN0bRW7DzDS8PjrGgpwBjvadcLMwbIlMA6yzdF7DLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZ0KzNUbE1EaHlyWTdiaFdCbDBGWFlrMEpvelVuZExQcWN5UjlOaWFGWUVi?=
 =?utf-8?B?N1JlK2UyQ2MvUERMVWhSM2NIZGw0bTM0ZmozbFcvcUVUWVBmRHBNZjhHQzZm?=
 =?utf-8?B?Z20zMVJJbytoNFZncUUvKzNyOEtDbHRFQmhHdk0wWElxUHBMcEFHMHRqRnRq?=
 =?utf-8?B?RFVTZ3gzRnJzY1lUOE9TU0QzTzQyeTJybk1JYVR6KzVycW80T3ZubjZmZVoy?=
 =?utf-8?B?Q0xQbWpaVjVHczBabmlhL1JXTU1USk04T0pmUy9tdWVCK3pjSk9iUXcreFpD?=
 =?utf-8?B?SWJ5bEFzTGRBZGRwRHRjTDBHQWl5TDVFOFBXMkhzdzdxbHJNc1MwQWtUWTQ0?=
 =?utf-8?B?dHRZWTg0b1pKekczZVFZeUZMQkVYeHZHWjgvdG5iZlA4NnJFSUZXOWFCR2Z1?=
 =?utf-8?B?RGNRWEU1b0Q5Y1h0czZFY0hYQUcweWdVNEtwM0JPb0FTSUdHQ2RyUEhsUzN4?=
 =?utf-8?B?bnBZNFNCV0JKYWNJYlZyTEpvTzJUSVgvd2Y4UExRSGpuUDZpZHFmendEL2Nw?=
 =?utf-8?B?RjJ3Q2VBOVo2R3A3TWExRW5iTjQ1WG11ZDVNWTA3d0krbEw4aC9nRml1Ulhq?=
 =?utf-8?B?U2l5RDNkOWYzc3JqNGlNUytNMjgrUDM2aWJlcVpDR2YwdFBFVkJRWjB4cXFS?=
 =?utf-8?B?NnlqcTRTekc1UVd6L3dGNVFoT3ZYbGZ5ZVNaS053QWJjY0tUQTZUWkpicW1u?=
 =?utf-8?B?dHYzMlRDLy9KMXZYS2o1dEJTMkROQTNXSVYxTXE2UEU3TnE3cmNETkQ0SWtz?=
 =?utf-8?B?ajJ6Ykt0U2xPU3REVGVlbVY1Z0xtcERna1VMem9LTTlhZXF6L2M4aEwxTnNE?=
 =?utf-8?B?cFAwK2p5eEVJSXRKaEVnQnJvQ0pGZjRKNnMxMHA1SEFBNXQ1dkovTnh3N2lX?=
 =?utf-8?B?L0o4S0RtelVld09DdjExM2x3aVYzOE5aUWFEcG4rWWxWQXowaVFMRmZpeXpM?=
 =?utf-8?B?dmxYUDFLUHRNTVZTSTM5Z3IyZ3JoZFZjYzBuNHM4WkQrYnpwOVFBNVlOQ3dM?=
 =?utf-8?B?ZGQ2aldSNWtGelQwNlBuMzBEVHVneUhleC9mZGJJNklUelBOU21sWitnTUlk?=
 =?utf-8?B?ZTdRb1M2Y0Z4VGJoSFRnanAwaHZPZThBVXRFa1Z2U2h3Q2FFc3I4bThod1J1?=
 =?utf-8?B?N0laWm10N0ptQWtOMnV3ZUlHQ0hwTmtpUGZ3cXBQOWYvZUhWdWN5ZXhHb201?=
 =?utf-8?B?bFNpNE5NUE9BR2hnZkNVVzZKT1M4Tkh1dlNxS1VVY0FSK1NwSENwb2lhdzZR?=
 =?utf-8?B?T05KSkc4aDllaVRDMjlCSUs2VzhrWG9qTW9GdmtJdE9PYTdxa0RXS2J4RHV6?=
 =?utf-8?B?SDFVWVIxQXdIR1BmaUd3WnR6MnVVZUUrclhtZ28wTElHL0NJN2Q3ZzhwZUF2?=
 =?utf-8?B?N3RuK1RReTVxVDBxeVF2bW8xd3pPeFlRQmhsMXJFZDhkVlZESkx0QThpVzFZ?=
 =?utf-8?B?MVJNZW9LZE9tRG5EMUpyUjh4UFJXbmxhSHZnY1BMd1N5UWZjVmFwcnNFSFg3?=
 =?utf-8?B?NmVGQ3pVNmxOSTF2QTZxbllCMXpQcUZJZEt3a1BqUEJjdmZpSjZxTXF0d3pE?=
 =?utf-8?B?ZVNCQm05Vkx5Y1NyYVo1aytnR1hWMitOaVFqdUZCWm4rR2ZKY0g1R0k0NW5y?=
 =?utf-8?B?S1JzWERmV1VueHNyR21YT1M3bmloRENneUViekdIMWpvSnF3QWNmaFMzNTBt?=
 =?utf-8?B?UnZ0WHdiSTl0eG5PNUp2WXQrNzNhR3Qzc0U2aXdLU0RoTW8zRjlpTjJoeGtC?=
 =?utf-8?B?TUI3UjZkTlFMcW1aMzVTT1I1bzdzR0U0amFZbjFEV0FxK0N4Rm40TFNKRGJY?=
 =?utf-8?B?MUJYZjVJYWp1RG50UDlmT09vR0tKZ25Qc3N4MFN1akxPL1dHWjBmOEkxcGdL?=
 =?utf-8?B?Vkh6aTFKQU1KVndkSXpFV05NcXMrNy9hQ3RUZmFZT1lXcnlDWkdPbkpySFhE?=
 =?utf-8?B?NGZaUnA1Y3U2aEh3bWdpM0Q5VmlPcWJsbGsyZWZGT2lqdlVJWFJ3UUNmQTFl?=
 =?utf-8?B?a1pGLzh3YUs0SmtwUEJpbThrWklUeEFNUjNtY2JPK2treEhXaWJzVTVzU3VV?=
 =?utf-8?B?bXpuZVZkT3dqMXRZREY4dFR4MXg2VjNtREQyWVpMSGl2M0lLWThYVWZJb1JI?=
 =?utf-8?B?dlZrdVp5ckJ4SUp5T0RMWmNrNVlnQXpyeVRYYkd1dFQ4WGdOcnhFODdGOExT?=
 =?utf-8?B?cCtoZHJYKyt4QkQ5b3BvWXZsdmwzQnhvUG9SdThGNGhseStHalIyKzB4YVl0?=
 =?utf-8?B?cVZzSnNYTjZPanorUzdrN0RHQjRsSmVaSmFKSHBwaHluTEtMOWUybXBRT1hk?=
 =?utf-8?B?N3NuR2k3NlB0YlYwM1d2NHlNNkVpY0pUZm85SGFEZCtHVlBWNXZSUEZDTnJ2?=
 =?utf-8?Q?/U1fSmXSAh3XgQj5cI2AJRbSW4TwALv8NN0FDlE+YYe2o?=
X-MS-Exchange-AntiSpam-MessageData-1: 3DjAnF2RJoYhdw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657f691f-c474-4301-e738-08df12cf5471
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:16:19.6287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJ++O9EUJiYWUCF1pRFAhlnr+CKPH3pVvx9Ceku8ppHLdwoyx8mkv33KHjNLRJAi4F74LBZkb5HizgegUGTNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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
index dd6c564ff408..39a271241cf0 100644
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

