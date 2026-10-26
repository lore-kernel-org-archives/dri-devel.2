Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4F606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XyrWckL3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F52D10ED12;
	Mon, 26 Oct 2026 09:21:33 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48C310ED01
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C94zzvTjD05Gr8WxuX64Ne2FXmxl78gBgxeHcFQ8BsxK05c3Z9p7NTjTV3xZ3LvRE1qapOZeJJ7/WQjNFLCYylOvDqme6IpicXRKFb3jUzWVId9hvPx1pFINrnLa3FQgqgeYemoKEk/WbnzlyCwYjErsHam3nuqMDR8aHPndrKoTkvWsP+pChVANeA1Zp6yxD80N8xkOxcajFy4iuHlw3odXsx16pMcn7HPFr+gJLm3GE/AUOZlRh3b7FIXK5BQTEqNeFFuBxfiMyX9pxpxmUjDxqmj/PYLrir4cT4IIjhhwp7+0seZO0OeJrjo9esaiBgELDYFbf8t2qf88WLNPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULmxYLOiy2fmk3jwy72P4K/5hjpKCs9HpSMXMwaQYp4=;
 b=xZoq8zycjFj4+7SYxNEXE7ZEcHFY0TnTfs2+XqOgwdCrNpoG5VMMkKbuQzvuHL2ZzEmOdstZN6adpK6e5eXg0bUzhIzNzBwJYJ/3/IIbYgqE9LoFTJBKDVrY8NC45AgLBn0+TD89LcBVdcCXZBF2G0CIimyKAEkyo5/XiNOVMBu3XDgXHHfkg7bRqq8/1+/4Lwh7TX0sML9m7dvG2JX6/HL3ISQA5/WGn1od8RcsF89EzLLhb1bkK3fu0VwvEUQeECs8rwVosjQyKSf4/4KTwFRfmht4aex9i8Z8j1qNtr1JzmQLcLvCAB4poVV/NWPYK6w4/qdBs2+2I3uvWOphfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULmxYLOiy2fmk3jwy72P4K/5hjpKCs9HpSMXMwaQYp4=;
 b=XyrWckL38IXDL3wTCFCgbgnsfA+5+pjNpAfOLMEVfwIKjuTsLE9hODPb4blpYgfKNlXj5mD2Bd+TpkgoSI2nZYG5pt1pom4nZtD14bUUqi8sqtUKbv+x08imTD7GgrxdOJRWljmZvSEwWCgOybzLlz4gh30Q9DixDsJr2pHCNm+XwpxsR/SeZ3AZ3rPxF4+MzCiebzfdepVXC/+n3K+uvXn28t9fn/45mCZrZz5JW+Az013O432PlCv9NbVb8hrhIINWJHza23FPl2j/g4MKXlrbvEC74xQ8rFJa2ZKaMMkhFz9gqzkRW9Hj/6O+7vNzKWPiTMwa3f4ljyoLMkb41w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:21:11 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:21:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:34 +0900
Subject: [PATCH v3 09/10] iommu/tegra-smmu: Defer display client
 translation to driver handover
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-9-3901d74b1ff2@nvidia.com>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0334.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac4cb8c-4dd1-424b-7815-08df3342794a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|6133799003|921020|56012099006|11063799006|261022075727099003|261021121427099003|261021123027099003|10067099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: YfgpaTotALWe2+ZCCrz0xiMYQm6qrfKqI2aCRSkd/lCOINSV2t3uLoOTApePsO798kiITN8NtZIDNcA6rRqsxYT4VDDxSr1Jq92d1gzmPtgy8fFpKUOtQZbX4r5Xb2ToPRepk4EdCw1Cn0cZYGcybgTCKqJDni3R7uZJH6bnFiR1lR9AosLZZ3j5G1MKsxo01WYhFCShzUHdS0NR59pxEkhYnyayqKb4IL+8S7sYDrWytWWIveN2RItUXXYw/YGaB7ufzYEK0ZSFJ5lml4PljsctsvHcBZVCfV+kLDkdxJMwWtCxsCsVoStZpeYYCAQLUZnDmiEPc7q4A1dGjSvIW6OQUso7Ol8iPykbgy0KZynfa418g63dQvuEcvYnHHRPK5aQvUMQtBN9NKSXVKAx7ted6pXzZQ8tzcFmE0XemJdZcANq9ZQ5jMxWuHAnnoVfT9CkZH5ZYDwT87Y80YDek5MxMKwDm831loWXrKoy8iWzz+j37TyjTno1r5mBHUPWjOgef/31u0RsBz2unCA5aEs/QI6Q3iP/s0yVHzjxJtWjEZvCCTqdmz0g8zUbQyKXQUJq0rR1hVjpaqr7uJpqu52hjd1FoAmHkgXqcBXvu6n2AobQyKShYc2UuqwJ1ubdHQk5ut1I6vtf5zC4aO8OpRSwheD2pudBHdNwFBFHQjS8WEkYyyhIE3sn/xHloFjZDogNYEyC5MhL5UmZBPv+Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(921020)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXM1VzgzUlhhcWhEUlRIY3ZEZkJhSnNSN2ptVVAwdE1SMmVrQ2hIZUNYeXFE?=
 =?utf-8?B?dWxaVGVvbTVxM0FoRExyWFJjVEI1VEtaenlla1ZzUHRtcGVib2ZhdVV5eVZh?=
 =?utf-8?B?UW5pN1lMVmk3Z0lkQnVkV0tsajB2M0c3NkNhTkZmRlgrbVlOamdpWmpFWkd1?=
 =?utf-8?B?WmlkdWxnWGp0ODE1RnQvL0NDODVLNW1BSHY2dGRPNUNGVVdtMjZHUm1KdlVH?=
 =?utf-8?B?b1FHOFd6bVlVRHZVOXBQc1kvTE9xYlZrMDZnYWN4Z2xBeXZHVlBvY0hac0Vu?=
 =?utf-8?B?MFlsMTZjWVJ0d3kzNXRnbmFqTjN1dzk5QytIWWlZYTJ2ZGw1WjhKd2g5aUp1?=
 =?utf-8?B?cmQvbUVuU2lZbyt1VlkyeHJISXNrZXpVdTY1SzdLUndNU3Ird1lra09kZzNN?=
 =?utf-8?B?ZlBNNk4vMlA5S05pTmMvSUF4U200RlE3R1ZBd3RGS3VPWmNYTFRvMytDUndX?=
 =?utf-8?B?QWRTWDJ0MiszVHpOOGwwMHJ5MmtoeTJ0bXFNSzhXSmtHdEV2SDNCOE1Rb1pi?=
 =?utf-8?B?bC9sYk9HUmEzMmhJbktQeEx2M1U5VGl1U2pzV3ljRlhIQ0VQY0tHengxY0Ny?=
 =?utf-8?B?ZkVIZmpwdXlGMHJobHFyWXJ2dXZWUUJmZk9Edk13RXZmMlczRzFvd3dlMDc4?=
 =?utf-8?B?dWhuMzBkVEwzd0l3NkFBc28yUngwQzExcVovZjQvODArK3p5SUFRYnNiN1h0?=
 =?utf-8?B?NlFyWWFTYkFNaUlId0h3UDBQaG4raURzd2cwK3FCSXRJcGh0enRxMVRIV1By?=
 =?utf-8?B?Y0VRbnFQSHFmb1BOYnR6ak04SHZoM0U0L0NManNxenQ4NGJOMTF3M0p5TEt5?=
 =?utf-8?B?WkxqbzNXS1EwK1JmMURtVXFWcVhaMHdSS3lPcXFHRVdySFBvV1hxaUloVDBX?=
 =?utf-8?B?dmxzQ25JcVVGVkhQZGNVTzRhODJ4UWtra3Erd1pJN0E2M2FXTkdiVUR6V21x?=
 =?utf-8?B?eG9kRUszZGIxcWdnR0djSG5zTGVzeXRxOGFkaUFENGZsNXlSTkdHY3JhNG0r?=
 =?utf-8?B?MmNublMvK2I1SFhMRWJ1ejlPUk9xTUdiVzBOZktEODJ0c2RzQUQ4NjRxSXFy?=
 =?utf-8?B?RDBoUTJBZ2FtV3ZrQzV4RzN5a2VqdW5UWHhaYTFpdkZGcHJFVWUxbHpJeGUv?=
 =?utf-8?B?ckJjYkk3bmFvVUtXTVZWZWFHeUc4UzlydlBsK3ZyUmpvU0w5TkRZekxFR1VM?=
 =?utf-8?B?bk9DU2Q3bkVGQTVOa0VrMmMzS0hZOE04THg1RE04L0wva2tpemF6WXVsZVlI?=
 =?utf-8?B?UUFKY1RORXJaMmczTGp5dGVZWkUzcFk1Q1JZcXFUaEF4d1YzR0NFeUhxT2pv?=
 =?utf-8?B?VGczV0pmZ3dBaUxMNkRxWTVqL1VBQ2JtMnVQZlNTVXdHQ3BJaEswZjRKK09t?=
 =?utf-8?B?M0k1L2xoQ3FoTWtPQWJ4V0ExWFJlcUw1elJPOE8rN0xyUVpzS3ZNN3d4N214?=
 =?utf-8?B?amxyT3pPRXZVODQrc08yWWt2TmlmNzArNXJzbDZ5TFBWQXQ4OVZCNEZmR3lX?=
 =?utf-8?B?TFZRbXFNU0pTVUlxaTltaHc3c0txZVMvUFhCLzAwTEMvcGMzZitVUlUwNzU0?=
 =?utf-8?B?bDhsUHg1Mzd1ZTlNOCsrU3VobW9WYlArejdqYUVyaUU4eHA2S1VhdThobTMw?=
 =?utf-8?B?SHUrTkRlZ1NNbFg0eWJRSGpWN0VaUG5LdXV3blJrTXJZbHhlT1J3cmo1N3ZF?=
 =?utf-8?B?a09QNlpEczBUNUlTZFNpb1YrSjRRNkZmT0ZsWjhEWTQ3UGFSR3QyZTdhMk0w?=
 =?utf-8?B?emFKQlNlYXJxMzk5SnlWUUJuQnJ0VmZ1YkRmUEI1T2RGZ0VsckhOY1EzYVJk?=
 =?utf-8?B?WGx5c21ULzYrbEhXMmdNMG5IK2JWdGVpYldZR2p0ZVpNV3I2M1poSXp0U2dV?=
 =?utf-8?B?TXViT1lQdFhPeUowQmIvY1hOUUhmQXNZWUxqS09yaGpKNWlyM0tWa1dTTW84?=
 =?utf-8?B?SlFNcFB6QzVVQmNQSTJidGtkY2UvaDlIOTlFWmM4WEtUclZncGJhMWpWRWdG?=
 =?utf-8?B?Y0N0STBub2VMK1RqZHpoTXJRRVFiMXZQMGV4ZG84N3ExQXY2Wjl5Ni9tbVpu?=
 =?utf-8?B?eGdTbTZQZVJPTWF6U2FpbHRhTXFSSWNDQnBoc2VLVCtYaVFLVnZ1eEExblgr?=
 =?utf-8?B?REZiM3J2dlpudG9oZE5LeWVHOVJnak0zbWtYSW9hODRIODZ5WXpOMXV6dUZL?=
 =?utf-8?B?UzU1OXZmZktYcG1ZbHNEaDNRUEhCSW9HZzlYRW8xRWlyTUI5RFZoSURoRTJP?=
 =?utf-8?B?SWVzNUNLbys4OFFqZ1Z0clAwemRWcUIzbThLU01GZHU5blFMcjdhYUx4cExE?=
 =?utf-8?B?ckVHZ2w3SWZvVWlENTU3dHc0bGpCVE5IRFYwZjJYYjBpMnVoRTFUWW1ZNTdn?=
 =?utf-8?Q?bgoBm/TULBJ6bBdBzIi4yzTwa5Bk/vFYXJCdD3S6/71/m?=
X-MS-Exchange-AntiSpam-MessageData-1: +dlCTDC3cYnMZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac4cb8c-4dd1-424b-7815-08df3342794a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:21:10.7167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG8eFruaEd0Dp5pvEzD4JEoZ2RrdJoWtwusPF4jzH47+sTIT6Btktd2vaIBPXVm+tpCcxN+ovx7M30Rx5Yu/Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

