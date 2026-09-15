Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5E2C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535CD10F866;
	Tue, 15 Sep 2026 02:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzH+JjcV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6966810F866
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:16:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCh5wW8fZntPydlvkned83O0nRM12m+eH7k4Nrgs4crdhudymtZgyBd14OwIR2iNqYCcp6Sdyq/IzlSt9oD6AYL5ciiQmLDOD71oWKJQHqPtGtXwKponSBMEDrtd48jJdwNv8I0buA93Vpnr5GBPOehca85fuLJqxTEHeK3X50kPmf7zbxFGCvZHzNKwQCDvOMinkiMvygHMes67ldm5L1cAolIlGS7gkvt7YpIxEh5/+w6lyz9XymUuzf7W8ZxVts5jNhqEDWrv7lDkyC3pR3qswxS3wLFjlY7Gyy5tLafdNfUHlwM5Wbj62lvzKmmYlMNJlQjnsuxXcTytObNeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzizPbnY7G47c4uSz2Lcj4HYK1Rp+NXTywuELPFlTzU=;
 b=rph44Z0ciKpJiy/9STdNWQDFz5FVJCtKK5MTVjUt1MMPA0x7ILZ5EacXCnwTfMBzIrNUmVoFp07WF7Gepz5SE2jL3nYXpNB9cv84YAi9OmoOuqbDhr4IbvNamZZv1ZRhXiEUb+lU+ZxtAHMcc9UP9ygE6RSFUHMe+hYg6banZiiLi7kVC5C2Wl/RxiOOvNE0KooqVTUWBHCP4+ZUxzoo6el0RTDMqEJlbVPQn3r8JR1Rx74PcVlhMDtOnZ3jtwD+UUydOpnhLfTP8eWljbyrrJCSWIWP5CHh1ULo0lHw6MlSSPp8M1se3fxwihLu8EBB9rfX6BIkZ75Q2WPEokQCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzizPbnY7G47c4uSz2Lcj4HYK1Rp+NXTywuELPFlTzU=;
 b=tzH+JjcVj8cUaB6D2TFCO5ggqIW3Qu7sVHkLA/8x6s8eALRcMy1feWcw8uCAlFkKmneJeEWS++Qlhg9bVq4/+sYpIpwcRsdFaw5mnzxWBVEmp8TS4cSTQD9v/mvDv7sXH/ZdSjiXiv2771un4imncF/4o9PjW3hpjWSksmN92dSlqPtvmdc1vEgEVSHRZiC2zoOwAngsYW7CnlLq7fpxZtE7wQvqno+jNhHJKNfNdCqdKu4qxgyJIGfGJw1JEPHvPXseezjY6yPqeq0whQWvP3+ufbitEOZE266BLYx7/g6dw/GZmF4foc5B7u1QM+sxAcVwApCq+H1xa7I6e1wr0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:16:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:16:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:15:03 +0900
Subject: [PATCH 08/11] iommu/tegra-smmu: Defer display client translation
 to driver handover
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-8-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PS2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:300:59::24) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fd233a-4678-4ea6-0e1f-08df12cf4f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: BoXAw4SgnTvqSnsguCq1MUluj5bJ+orItX2QcGwYM8EHyOXhWRI2XPw9Ta/MK4lVVyDt38EvXg1xSUV8ldY4fLgKGB9MS0UBxXtHb46HCsAwxt7H+CKNIV9DpOFX0zizHwto3k0ujgpzSgMIxiPp548713+oxEX56vubFydc0y/z+wWrJRrS4SxU3FDh5qUK1xuLXVyF5uyg4IAf9A6wIiPXbwIqiSeXzieaX/Mc9qfPsheA9qcXPUcIF1r/3y9p1mGxT1OsrXk/xWh3rG1VujRSHRs4ZAnCHrVfB+OtzvRw7f7qSOv03hMabC6YHuhFhqq+kEmaIykw2cdpXeOL4eSS/PEJWiqigYuweAZ0A7q5oMMl3LwsWwaU3GHWaE22bCvf90VLZBGcImHC7Bmlnic5W/uMhPteuvBGnZNEKBYYoHGHuK9fSqLtINUoxAztw0/UQpE7gYtlZoiCxPgLFq0QNIfNkOHbhQUpXXL++qzaO800sWrfHdQgCe6F87TgTKr1qOISbhEKNlCo6PPHRosdFU5ah7CnM4Sj5odOMtnoFsf2d+5n7vZE0v7H0QFkZIb7K14bdaIxHMyIrRt2kXg8EG8bzvkPfvIkrKCGI611C8ktxe1D9gW8MIQwRp8hSFrTZE6gPlR4vcpPYrfeMg77SXdRCdETvjS87tVhgINBxSLupB37121SC9BguYWp0bEQOzk6kOWKo85KzbSWmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDFJYTJzY1lIZmJHekkxK2Y3KzVmcFlNczZ1NnNSdzBoMW0xVmJ5amNTNEZy?=
 =?utf-8?B?dXcwODhLQUxiMjFCUDkveVVtNFhmZ0tRNERNWk1ua1hSUGdwZmtmWjdyaExp?=
 =?utf-8?B?MzNUWmxmK0U4WEs2eDEvTG1TM0xuRWEybzBldlA4ZHMyVUs5cGNzUlNHZnlw?=
 =?utf-8?B?VXpDd1dQdkJIRWNNV2JUdytEODZodHY1cEdxdTBENUNLdERVTTVJYUdIYnln?=
 =?utf-8?B?aE9oSVJUTmxnWGZJSkRWNHRvazZ4NkoyVzRUSnArZU1NS2RPNW5TLzNRNk1r?=
 =?utf-8?B?bjU2V0JZNEJhOXhETFFXYlI5OGlrK1E0dGtsczNZS3k2UFppcHpqaS9qWTVG?=
 =?utf-8?B?cVVGc1QzNVFPcE80U2hnMnBxTlFoK1dMLzZxU1VtYXFsT0g2T3p6RjhNMzhM?=
 =?utf-8?B?M3F4TlIwMkxJUUV4b3ViRkU4Q2RyYXZuZVlPemVjbktPa0poSVI2eHBocTN1?=
 =?utf-8?B?cnl6UUtVWmp4SjJobFd2aVBON3QrMFJ6MUExMG1WV1I1blFnSVpmSUtqQ0c3?=
 =?utf-8?B?eEhpV1czYXl1c3JPQ29FcU1nMG5NcUhWMWk0UWowcDJFeXZka0xCeDBnMDNS?=
 =?utf-8?B?UndxMDVIa2oyTm1ySTNoR1JGc3VIaElpbFpxY1F3WERXK0ZSeHFrN2I1Wnd5?=
 =?utf-8?B?N2xQUWlLVmRDM1JKSG1mMEhhV3IyelZXejJIc1c0QThBYWtPMzlvWkk5RGhD?=
 =?utf-8?B?SWp1Y1ZBR1R0SE5heVQ0YWVHWTJrYmxCMkdnRFJRRlZPVjZ3Y0FlWlhLVHhE?=
 =?utf-8?B?UGN4S3ZXeWJ5WW92eU45aS90RDNRL29PUncxZFVEek8vZDBqVUxRY05LS1ZL?=
 =?utf-8?B?Kyt1N1o5am9KTnh0akpnd3pKc1NjMHluc3ZVUFdKVjFOSXlWNEdwQzRObFlI?=
 =?utf-8?B?cWxjMGF0VTJtRzRib1hZYlliWnhEODMzNTgvVXRYUTZObVdVK2RIcG9WZ0ts?=
 =?utf-8?B?MmUxdGpDWHNudkk3TlJndG9nNzF0eFcxc0hUZlMwMDZlY2psTExHMWQ2N3cv?=
 =?utf-8?B?MmpGRko3L2xLaGtEM0JIamhaczlGYXhXWVBMZ2R5cE8yNnVuUVVPbm9qbStF?=
 =?utf-8?B?bHVWRXAwUjdQZmtoU1Qrb3RPdzNNUnVodGkrbVdYREtNWVFuR3h5Zm5YMmhB?=
 =?utf-8?B?OG9oeVFYZ2d2U3dSdHNHNk4rUXQxdDZkRFFuQ1cwbmJ6ZWY1dGZEQ1NNL2VX?=
 =?utf-8?B?L0k3dzM3Vk5LVWhRUzhUMkZ4SXFRdkc1S2VtOWNVMUVpM3pmdHl5NGlHOExL?=
 =?utf-8?B?dFlDYllBdFkwcFkvclBBRlhVd1FrUHN5Zys3RUM2aElRcmRza24wcmJzaEto?=
 =?utf-8?B?cDdFV1MxOXpvNFFRS2hVZ1pBVmorMnlTdU54bXB4eFhYai9CNDNIVnFyNWhF?=
 =?utf-8?B?ODMrWld4c3lvNGFONHZWTDc0WFlYU3FKRHVuc2s0N1FlTC9ZRlIzaWMwbHZl?=
 =?utf-8?B?Z2FIY3pMN0Vkcm9EZVcraHZDNmZ0RE81eGt4Tjh1cHdmKzc2NWltTmFTcTBx?=
 =?utf-8?B?RVhGMHBxQzZZNkYrK3ZXQkZ1azNlZ3NzL0tZeUxMUDI1eDVMZGFiMHRXRWgv?=
 =?utf-8?B?T3pYMzQvZklLVmhyZ2lJWjQzZWlXR1BVWjBNMFpqWmp4WXBsYWpwL2NmYmJh?=
 =?utf-8?B?Yjc1WjNRZEc3UXVoSlFxSkxReC90YldwR0w1OWplWkp4UWY1c0NyeEwrK1VN?=
 =?utf-8?B?TXFQZlE3d2JzWDFhRHNiVVpIYU9qYWFLb1B6YmdKQTl0QWtCd0FPU0E4V0ZF?=
 =?utf-8?B?RWhaalFndkNyNVZOVjdYZzNzYzNpVDJnVG8yWWQxQ3hpVUdIRE55YjdHTllr?=
 =?utf-8?B?d2dSbkVtTWNWa1pnb2dQSXJtRE5lR1l1cktzQTM3WFk3SGJRZ1luOGtNdlE0?=
 =?utf-8?B?RUZoOXFscVpoa3E0WGc2eDR6VDd5U3ZGU2J5RUNLWWJYcHdBOHRpR3pWODlp?=
 =?utf-8?B?VVNIdFYwYUVxN3RCMHlickI0TXZKSTBsU21PcWdPdmk4RHFEZDBGK2NzL1JC?=
 =?utf-8?B?ZW90ckljUVcxNWoxNm9sdVJzUDdzS1VZR05EK2RHOFJzTzBJNDIzMEpmN2R0?=
 =?utf-8?B?cUJKc1FVTjNORXJ5Skl0UlpGM3hRZnNvU0h5ajN0NW42Y2pMRTA2d2tWbVAx?=
 =?utf-8?B?MjNpNlhsWjFQdXJKa3FhMVN6RnJla01CRTZUODhMRUNFeFVJV0I4S0w3cFNX?=
 =?utf-8?B?TnFuSFpPVlFoYnd2V2dPMU1RUkZMZ2dyVyttNi90bFg3aldUakV6a2N4YWdD?=
 =?utf-8?B?TFUzYTdXNjZwa05CVzdlL1F5QnArYklWN3IzSGhmVWRqem05aWVERWp0c0RO?=
 =?utf-8?B?MEFoZzI4dXVUMzNuOGlrOE10Y0FCdldUQUtwbGFtTHUxeG9mZWprcTNHS1Yv?=
 =?utf-8?Q?MVYrvp056cv7Y1AkXwZjcj8SMhWIqPFfo6CiLp9Z2TWGE?=
X-MS-Exchange-AntiSpam-MessageData-1: Z+/hCYx+EMTxzg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd233a-4678-4ea6-0e1f-08df12cf4f32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:16:10.7753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AKzIfK+G1R1PfhTEE/OsCqN+oAwq/kOuEnnwh1k59aisPQboAkiNfldm+QllFutAnRdvzJ+rtQF82AfyO9nqg==
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
index 0b3fcc7011b3..2ae4da07bbc9 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -19,6 +19,7 @@
 #include <linux/reset.h>
 
 #include <soc/tegra/common.h>
+#include <soc/tegra/mc.h>
 #include <soc/tegra/pmc.h>
 
 #include <drm/drm_atomic.h>
@@ -2751,6 +2752,13 @@ static int tegra_dc_init(struct host1x_client *client)
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
index 67e7a7b925f0..6636a044905f 100644
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
@@ -417,6 +423,49 @@ static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
 	}
 }
 
+/**
+ * tegra_smmu_enable_translation - Release a client's swgroups to translation
+ * @dev: memory client device, already quiesced by its driver
+ *
+ * Enables translation for swgroups which were left in bypass at attach time
+ * because the client could still have been running from a pre-kernel
+ * configuration. Must be called after @dev has been attached to the domain it
+ * will use. Safe to call for any device; clients which were not deferred are
+ * unaffected.
+ */
+void tegra_smmu_enable_translation(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	struct iommu_domain *domain;
+	unsigned int i;
+
+	if (!fwspec || !smmu)
+		return;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
+		return;
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
+
 static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 				 struct tegra_smmu_as *as)
 {
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

