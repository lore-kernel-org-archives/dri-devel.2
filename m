Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA83CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873871125EC;
	Fri, 16 Oct 2026 06:48:14 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD8A1125D5
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPNfxbKCgGY8TjB/FOvZ9WbB3n4Yuv9aFwmvpnnPm6a1BIYbbT0RJXrw32K3EIdW4Dd6amsPr4beR3sg+bYj6/jPgX5c5UFJ5ZcFUtkKM4qlu2n+ZG3IhAR3vxAQlgQKIcMUGskSC7xlyRwXUaDbYQ995sDJ2+7ITJbnKZHvOQz5mXjoMJ+G/ACZujC8eSwla3vD6PkwPDENTYzNHTQ7ukiwW/biOp/YdGM+GzcbjT272BTwbUeq+wHuXeugJq5/6hbCMWrCMS26Msuat7yYjXlb2t3MPiH9HazWo1m0pbr1U70zm/qvoW/NEyUMjEMbnWC87TPb02PZQiDldm6CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULmxYLOiy2fmk3jwy72P4K/5hjpKCs9HpSMXMwaQYp4=;
 b=JgwXXFytU7asmRvOeYgxF9rPvVDWvocX94Sj0h7er13qysjuiIPdIZzqxJnJu/5SlodaXFCWps+N52VNhW4bA/5SSaZm8dk6wjAjLZUlSDPALg7BnOJyFy1aMSXU5zVfzfaB7Q035/VT/w8xFJV2F2yMvMYmrqRhS0WIvR/SIp+5wc6HHjIqEuIkEBROa62fYIE4Cruq/82ettsnl2hlEEDWnH/K7BQ2pnUi7AWpr4Ji30hqYlpFoY/baGFkzk1XLE+gnMtUX44aQVrdFrHNjRV8q+y+37NWJNoWJxkxYvPvosJjm5LIHIXdPYX0OrMaCWZK4JboKohZYD/k1bzl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULmxYLOiy2fmk3jwy72P4K/5hjpKCs9HpSMXMwaQYp4=;
 b=YupdcmsMomc1s5uJIaF9194XVBvMtyTln1be93rKEfRoOk3L6r73wH9nk+YeSBVQ8sc16loKzt8hXL+2EEaW5pQXOd0GQgJmE/FeGXNA4hmKAQZCrceOhBtAokYUuC+hXf9+Q4m6a3dmfSHCTTV69Bq+6Jkb7Kevt95yiTJFRHkzMc7TyDNrrF4iipoVzFHJhU8jt8DcCWFX6d5P8YCYcg9Sq8cfTB4LlcFEZfH8+5zpC53+jye3oVy/FqsroefpC6ko3gDBRrtuJ+0Q3JTNN7DWFJGAFimqk5j9855UC6YLJSXDl0DP3iQVKL8up/vo6gWufeA9/dmSf3icWDY1Vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:48:00 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:48:00 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:54 +0900
Subject: [PATCH v2 08/11] iommu/tegra-smmu: Defer display client
 translation to driver handover
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-8-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d546b79-5d88-4efc-7c04-08df2b516b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|6133799003|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: +NXFmm1/kcCROTTE7A/NBfszT8f8sh0koTBbG6zVtdNUCS54h8ZvfWdqKPI8ZVcMH0OPszAwhsTZoTpzJmSbf88FNI51RLv8rKaEXcHfH46guVjhxrTSu16ouWwQXTjzj0+JB48KescooXd53XY6t7uljDLoeqWYSOatYcemUXglc/1amBRySK1gms4NKuBRYB2Zv0OL/DuADv90ATHRYyFdkddtEpWxnqf755JxWw2W2Y9c89CKB9WuJNhd/bL2uQEQSHnu/L6pPavpz8NyDsv/bJnVfYdWTEIpRrprEPNIx27yi+LqWIrjVWXTAmCCDnKyv9npH8n4bp59g7Sp7Bh+y8qvnJlnqYdhuxo5iiRX/xDPJwgiJs8UzRqVrtjU/6CldYUWSxBp65u1CDdMUYaWAw9Um2dyQ37dfRhXVn84sVhkUiKE1+4Cd8Q91vul+xF9pqhOHToUzhrC6jHx5jG+MgKZkKZKO2Q6Sf/Qm5KDIzU4y4Z0gfS6VPZhL0uRnTvGl/WH3ywaBq0IulcQ7KR4CxlRIweGkOxz52we9AJgIGYu8j3b+w3CK2jDg2Gsl+oT11k8y2Ex43Kjhkbnd81HEzb1kI0zDoPXpPTF3wvHbws3t5O+lHIQwDWURlbk/x3739VcYj1pSdoqK90dflGjXLzESfjQ2Zy0yVjlKR5R/kiwQheeNFPZeuUtdV52Cdo/V/GqEEdudlMLzwDf2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(6133799003)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkp6RFFQa3d3cUp4Z3p5eEVxMXlwUjlXOHp4QVhQS0pGUDZSeFJKa0hucFI2?=
 =?utf-8?B?d2wwNU1VVU1DNHJSZWl4U2IzRmdtQWlaWW9oSjlSQ0NLZ2E2T1ZRZGVZQ3Nt?=
 =?utf-8?B?ZU9ReTJpWnIzWWN0U1J1aEhBZkVxRTNBakVEK0hPNXh1REdEWHF6ZHFiMjlk?=
 =?utf-8?B?VElGWnM3OVNBY3ltMkZOa0h3N3cycFN0bUtFT2NnbWVXSmExLzg5MVQ1Z3Z5?=
 =?utf-8?B?emtCTDh6QlNCTzNXVjE2RWlsbjRZc1lhWjZqVUZyTW1UdTV3UGZjYnJHRFFh?=
 =?utf-8?B?dnhhajJLR2hHMVVMWm9ES0ZPK1hOTjEzdWxWbEZMVWcybWFGTXpFQk11RjJG?=
 =?utf-8?B?NnZURWxNT1psOE0xUm1nbTZnd0hzcW5GWnd4aXN2Z2RNR25XYTNTOS9NQlRT?=
 =?utf-8?B?VE1ZRFM2U0FoeGxNdGxGQzZIRHRzd3pSZWZEQTZZcWFUY1BkNXprdmppUmZJ?=
 =?utf-8?B?dEFrb21lZGhnUFA3aGFHK2hXSzMwbmlNUlk3THh5d29rUkdkTHNqWlhMcEFs?=
 =?utf-8?B?NGxva2Q5RTFFZ1lnMW1KRUNKS0lzK1hENi9tM3VPbVpCd2x5cU1IdGZHb2VJ?=
 =?utf-8?B?TUJJQlRjUTRxWmFFZzRQRG5LTzg4eUEwR3U0MEpBaVFSaGRNWjZFb0tEeG5F?=
 =?utf-8?B?ZCtLbHdxZHdaN3crbHBKVnU4S1h0QzJPNEJibVRrUjM5S1ZNaXNuMDhVZjZy?=
 =?utf-8?B?UWxVUjV6WU9ibE12c3g3QmVtMTVRY2ZBMzg2L1JDVENWTWlFRC8vblJrWVJ3?=
 =?utf-8?B?SEdMdW1OMWF4S3FCaXdPOURIWkdidXE1V0Uvb1VuTjYvUEcrV2JsUm5RL3NC?=
 =?utf-8?B?dk5lcWFYR3RHcE9qdjBVQVJpN1pvNWxrU0wvbmRXby9WZzR1Z3NUMk5qRlV3?=
 =?utf-8?B?Y2RlTEpTYVJ2TUVSbzE3MmxHcitaNktRTXQxaENRZGxyQkRvS1RqQS94N3RZ?=
 =?utf-8?B?aU9heHVTdnRieEpTNGQzRUFHU2tEVUFQek1OSnI3Smsza2hIOTRnRCsyaGxX?=
 =?utf-8?B?bEdWYXFOSjhKOEVGYWF3c1Z6bGk4S0pKL3laRkdpeStXY3hSVnZLWm02SlJw?=
 =?utf-8?B?VTJjVlFhOUFqMkp4UjdmblhpRkxRNzEvemNNSk10YUFBUWNPTThZMTRrSHFE?=
 =?utf-8?B?cnRpaGxidTI2bU9rVVU5OFFSUzJzYndrL1BiWmZsR2FINXFzL2QvWVBaeFhY?=
 =?utf-8?B?RWZscTduWWxtZXhLUktjSTdQOWc0MDVVUDNxT3ZLM3NjeXVURHZoRXNwWmFj?=
 =?utf-8?B?bnI1dkExSkI5ZWg4bFV0YkVIUFBab1pCYWxaSnNVVk53cjhDQStqUUQ5NVcy?=
 =?utf-8?B?UUROUmFBY292KzcyQ3lWQlVUdkJGYUthS3BGWFJHY2dIVllTZ1YvR09oVm01?=
 =?utf-8?B?a2JkdGFCdDRxcXdCblhQOEVneGc1TVlIV0hndVlER25FZElxenp6eGhIY0po?=
 =?utf-8?B?T0dRVTVyc2tmK0dSejRIYThNQ1kxdDMvS0Y5c0x5SWtCMnlyc0RCckRIdTB0?=
 =?utf-8?B?TWpCL3N6djFFWGJCamhCcmtTZ0FaR0lBT1NCamJVNzhOUitXNTVJaWlwTEZi?=
 =?utf-8?B?bjVqTEk5OEo0SEpSNGZYTU1TSklKN3pCbDVzSXVXQ3hsaDYrRnEzOTh4V1lP?=
 =?utf-8?B?UWdwV3hqWFEvM29PZytxYWgzZ3Q1WXRMYmkweHVBUXJMcmVPVy9yYXcrcWUy?=
 =?utf-8?B?RW9hd0NvZk9ZcVVKeUd5ZkprR0k2TCs0QVZyc2ZpZXJMTTBZL05ENlJOUWVr?=
 =?utf-8?B?QW5XNzhuMU40aC8vUVdUdUxOZ3JUK3MyUmJ2MW1sb1BVelRxOEdseWZWRUNw?=
 =?utf-8?B?ZFpOUHdrU1JPRHhvSi9WSStmNDdkbmtBM2NYNVc5ek1MNCswMzNhenNPRWwx?=
 =?utf-8?B?ZTBtMktHbUdFNGJ2NklEREJKNlRNRkk1QnVMWElEdmtwdmlpbEc1RCtqOExo?=
 =?utf-8?B?VTRPdDBPZDl2WXVKcDl0dkNrZXVQN3I1MEFBS0IrMWViZk5oalQ5UEhuMzFa?=
 =?utf-8?B?bWtWcmNoUHFQZExzM3JCU0w2cDUzVlNyQktza0tvb2s1V0JNZGIxdEFSZWth?=
 =?utf-8?B?WENJc3pkWXJNYnF0MGp3UkU1NnA5cFhPMmgzS1BISTZUdFdLY3FwQ1NOdlNV?=
 =?utf-8?B?NVdyaFFWaFVFKzVhY29selkzZnZCOGJUYWZQMXg2b0wxZE9xRmo0QldnaGF4?=
 =?utf-8?B?UW83cndxVjE0VmN1QTZ5amNZRklWNzZXeU5WUXNndzlRUkRjL1JleUdaYU1O?=
 =?utf-8?B?UFRackFXTmpFVUtuYXBVT2JzaStDNEYwZFRJRzZXVUlCSEJDaXZwbUFBSVo5?=
 =?utf-8?B?UDlVbjBIS2pBM2xESHh6aFVXaGFVVCtQRXVXZTJKREErVmJRTm5nZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d546b79-5d88-4efc-7c04-08df2b516b72
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:48:00.5813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wb8uANgkZHGqo0Bjyg+eQyE/dy5ie8Aezsj/c+dx0YB6B667l6Dah10vriduW3oBBtoPKqOyxbrN0srcGPagTQ==
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

Bootloaders may leave display controllers scanning out a boot splash
while the kernel boots. Enabling translation for them without special
care during that time would cause translation faults.

Because of this, tegra_smmu_def_domain_type has kept every device on an
identity domain at boot, and TegraDRM has parallel custom IOMMU domain
management code paths for these clients.

Mark the dc and dcb swgroups on Tegra30, Tegra114, Tegra124 and Tegra210
with a new defer_enable flag. tegra_smmu_enable() sets those swgroups up
as usual, ASID and per-client enables and all, but leaves
SMMU_ASID_ENABLE clear, so the clients stay in bypass. tegra_dc_probe()
then calls tegra_smmu_enable_translation() once it has asserted the
display controller's reset (and set up its final IOMMU domain), at which
point the hardware is guaranteed not to be fetching and translation can
be turned on.

If the display driver never probes, the clients simply stay in bypass,
which is what they do today.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/dc.c      |  8 +++++++
 drivers/iommu/tegra-smmu.c      | 51 ++++++++++++++++++++++++++++++++++++++++-
 drivers/memory/tegra/tegra114.c |  6 +++--
 drivers/memory/tegra/tegra124.c |  6 +++--
 drivers/memory/tegra/tegra210.c |  6 +++--
 drivers/memory/tegra/tegra30.c  |  6 +++--
 include/soc/tegra/mc.h          | 13 +++++++++++
 7 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index fefc3761a4bc..caf898e3db00 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -19,6 +19,7 @@
 #include <linux/reset.h>
 
 #include <soc/tegra/common.h>
+#include <soc/tegra/mc.h>
 #include <soc/tegra/pmc.h>
 
 #include <drm/drm_atomic.h>
@@ -2757,6 +2758,13 @@ static int tegra_dc_init(struct host1x_client *client)
 		return err;
 	}
 
+	/*
+	 * Enable translation now that the final domain is attached.
+	 * The hardware was reset at probe and has not been programmed
+	 * since.
+	 */
+	tegra_smmu_enable_translation(client->dev);
+
 	if (dc->soc->wgrps)
 		primary = tegra_dc_add_shared_planes(drm, dc);
 	else
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 67e7a7b925f0..6779528a9e7c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -368,7 +368,13 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 		value = smmu_readl(smmu, group->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
-		value |= SMMU_ASID_ENABLE;
+		/*
+		 * A deferred client is set up completely, but with translation
+		 * gated off, so it stays in bypass until its driver calls
+		 * tegra_smmu_enable_translation().
+		 */
+		if (!group->defer_enable)
+			value |= SMMU_ASID_ENABLE;
 		smmu_writel(smmu, value, group->reg);
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
@@ -1190,3 +1196,46 @@ void tegra_smmu_remove(struct tegra_smmu *smmu)
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_exit(smmu);
 }
+
+/**
+ * tegra_smmu_enable_translation - Release a client's swgroups to translation
+ * @dev: memory client device, already quiesced by its driver
+ *
+ * Enables translation for swgroups which were left in bypass at attach time
+ * because the client could still have been running from a pre-kernel
+ * configuration. Must be called after @dev has been attached to the domain it
+ * will use. Safe to call for any device, including ones behind other IOMMUs;
+ * clients which were not deferred are unaffected.
+ */
+void tegra_smmu_enable_translation(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_domain *domain;
+	struct tegra_smmu *smmu;
+	unsigned int i;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!fwspec || !domain || domain->owner != &tegra_smmu_ops ||
+	    !(domain->type & __IOMMU_DOMAIN_PAGING))
+		return;
+
+	smmu = dev_iommu_priv_get(dev);
+
+	mutex_lock(&smmu->lock);
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		const struct tegra_smmu_swgroup *group;
+		u32 value;
+
+		group = tegra_smmu_find_swgroup(smmu, fwspec->ids[i]);
+		if (!group || !group->defer_enable)
+			continue;
+
+		value = smmu_readl(smmu, group->reg);
+		value |= SMMU_ASID_ENABLE;
+		smmu_writel(smmu, value, group->reg);
+	}
+
+	mutex_unlock(&smmu->lock);
+}
+EXPORT_SYMBOL_GPL(tegra_smmu_enable_translation);
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 2cb153091228..2883c4f91144 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -1028,8 +1028,10 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 };
 
 static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
-	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
-	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "epp",       .swgroup = TEGRA_SWGROUP_EPP,       .reg = 0x248 },
 	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index df87c5038625..a38fbf2baf6c 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1070,8 +1070,10 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 };
 
 static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
-	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
-	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "afi",       .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index f58f3ef6f681..92e809cd7c26 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1166,8 +1166,10 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 static const struct tegra_smmu_swgroup tegra210_swgroups[] = {
 	{ .name = "afi",       .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
-	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
-	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
 	{ .name = "isp2",      .swgroup = TEGRA_SWGROUP_ISP2,      .reg = 0x258 },
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 8389e3af0121..0ee4715413ba 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -1139,8 +1139,10 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 };
 
 static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
-	{ .name = "dc",   .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240 },
-	{ .name = "dcb",  .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244 },
+	{ .name = "dc",   .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",  .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "epp",  .swgroup = TEGRA_SWGROUP_EPP,  .reg = 0x248 },
 	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c },
 	{ .name = "mpe",  .swgroup = TEGRA_SWGROUP_MPE,  .reg = 0x264 },
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 25d465d70493..ea67972fd585 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -70,6 +70,14 @@ struct tegra_smmu_swgroup {
 	const char *name;
 	unsigned int swgroup;
 	unsigned int reg;
+
+	/*
+	 * Set for clients which may already be running when the kernel takes
+	 * over, e.g. display controllers scanning out a boot splash. They are
+	 * left in bypass until their driver calls
+	 * tegra_smmu_enable_translation().
+	 */
+	bool defer_enable;
 };
 
 struct tegra_smmu_group_soc {
@@ -103,6 +111,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    const struct tegra_smmu_soc *soc,
 				    struct tegra_mc *mc);
 void tegra_smmu_remove(struct tegra_smmu *smmu);
+void tegra_smmu_enable_translation(struct device *dev);
 #else
 static inline struct tegra_smmu *
 tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
@@ -114,6 +123,10 @@ tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
 static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
 {
 }
+
+static inline void tegra_smmu_enable_translation(struct device *dev)
+{
+}
 #endif
 
 struct tegra_mc_reset {

-- 
2.55.0

