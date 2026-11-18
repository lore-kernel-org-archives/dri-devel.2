Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C3606A883
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NO4lAztQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB0710FA20;
	Wed, 18 Nov 2026 00:36:57 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6953E10FA0D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz7OzdAa/l+e0KMWhgKD4G/sQFXFaf9jw0kWjYGunk7a74RFUYEcWCVQ2ePpLx9v9My2jrLA5PFiOM4pDhIH4hAmVt5NWnCpkyrlDrIqiktaBJWVuiEGHjPXcA047JF6b+jTcGPOCZme3kW6QdYxrV0KB8XPrm7QriP1QlzEfw2o79ShJp18aSaEtvo92PihAMU1z0xXg3Yh7dQI3v03rGnLHLYEXnTzg0ofKFHWRvDyo2VKaLDL7/znLJPwtsQ2dg8t1c1UC7rjSc6WExRow4ZErsSkMwW/C4o7NkRxuFsmlgFzIfFDgOqm7GcjxtGTg0dEgxctOoqStU1zitVRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmrdJ5Cybqs+cyAlyLT9wGgBwf6XfmTKP1GqXCEQ+NE=;
 b=uy8nuhSnqvYdbdQKQa+0CZuCxTcpcmVSv0NuQBNgbycJXgiRLLR830i2S2MXZXXnfJuILSi3yF2OaePwlEIv9xajYMGEz2uPZNLHYvq8EWf8z4g7/vHKKUd9kh/R11bt+axYak3QUfWoz6GkP7MybZKlq2W9faL3meWMezcc84CoqXcEwgp9td9l69xI5UmoONHgAUMZb0ldbDrvbuasXzH43FO4djXNwC2Tiu2MVPWUKLCp7F/JR1pC4HTEUatZFhW+5tCaq6WpF3Id58Mz/pZLBauEElzH9xUHu69s0KFfnclAK6Vdsd7hPFemtUlDhnIiNYRa9hRc1OvCFxuQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmrdJ5Cybqs+cyAlyLT9wGgBwf6XfmTKP1GqXCEQ+NE=;
 b=NO4lAztQNJCn1LpgmFNT9VB42GpmQiJF9i1vem3+2TLNNNzsTv0lBkKTPSmALffOrz0Pq8A8wY4IkTAOuNibGg/9TKLB41m03Lg7nnksapSZgO+pUCgCd9LONc5ZiPl8AlsH6neWrqZmC/AnA0AYdDPJj+52REaGz+mjF5P99a4Cx3G2pX0ozBS6A3xfYAMoKxmLRemyP6i5RaOI8wAm2xZ/8fJsLUormXtrW6Vkzp6+gCgMFb0WM0sapvgqb/gAeiHu/EMMGKElE6mkQ/SdU4F1gIo7dywyGrsRROfc1IFdjgYpT1FMlrOgpxLzQxm6SL6weJrKrd1SjQ4Z+02tYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:33 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:32 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:15 +0900
Subject: [PATCH v4 06/12] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-6-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0338.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: ed397c21-1049-4087-5c6c-08df450bfe4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261102130727099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: QG/TdAUCRuqoThlfymgM3yLkP0oySNBjY1abDhXuGMm7LVf/cjADXnYPNdt3x4UtV8iQpoUkqIhkJlw/zrNcVEHh9Ax0WtrJecgjts4j7EafiCilq9knbN/7ka8N/y9iACCaobP39tC1rbL0cbRUCbwQW0R6L3M9K/T1J8d84U5kIEZM3iJLKL5ordZeKiqE94XyxILP+RLN5EV9d6avnCYsCziEOv6wzRiR5IEbVHj7e6R1GTpPZUASlmCSmGb+r51/E0s0FnPCzT3+EIjBLATx7YqNCU6F9v6WGZ77pPl2GtUsKJB7IEtgmYsxUDVnzbf0KV7qwlwU9Uto8FaKeQggVIblTWfishG9ix6Fxo+4qf4AgikK4CYMlbrpLD+q+r2J5TdAENTBwRlTU2y2c6541zMXLqEY8qE41mI4gT/+kA3AoAj/ZMyspDYO8YFKfc9PSiEQuEhVK7w8UeVOYL8+tL0e9VBe9n7gWugqAnM+Pz0LXiNdWRYTE1zDMRWEdpsSWqHe13EKQ5T5TA7xLeDi7XCl2no3wopYWspiDl50+BR8pOIuQ4t9qh90BtkByGRpN13wdCSqIeApnzDKUZCgfYjydVF+/fICQdT0u6TG0iYSaVeE1T2HjOEJIDte4rvPj+r6slNM5AGNy+m9Xw1GzaWl2yW2hAUQNHQF3CT08Ml4ru79le7hFzel2bIDwBR3c1wjsdrrDpy2wT1A/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261102130727099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZIUkF1ZHlKWFZnVTk0NzA5NnBSRTdoTmV3QVIrbER2MEpIcmtOSXhiakVJ?=
 =?utf-8?B?L2M4K2g3ZDF0VkdKdlFISms1VUt1ZlBhRUJKMVdTNW5lM3crc0RIUTdpaEc5?=
 =?utf-8?B?NU1iVy9ZOFBMZmZTUUJZWHQwMHBsZlhQcE5VNVduRDNxdVZvbFA5OEkyNFZE?=
 =?utf-8?B?U2RrNUlSREh4NXlxazBKMnIyV0hMVFRRRkFJUkczNFZmN3Jadnh2RzFuQXFF?=
 =?utf-8?B?c0Mvb09jYlhjbWdNVnRjV29UMVpreUxrbUgwOG1zck5UUEM0RFFPWjhPQS9k?=
 =?utf-8?B?dGFxcEhWbHVnZVoybndsUmpkdzJucnkvUFNyNDJvVm9lanU2aWQ5OUpnNVVW?=
 =?utf-8?B?VktoTmdmdjJrSXRWY0NKbHlEZG02NnloOG91K3h5TEdjOGxEU0FrNG1VVFlR?=
 =?utf-8?B?QnFjQjlJK2c1TUszVVRHcjVCZUZkVEVXUkUrbU5ML1NIMGRCeTJrUGtzdHNC?=
 =?utf-8?B?OHN5TkRSa0JEa0VnU2s2VnZDR2VrZzE3cUp6ajZXQ3MxcC90dEEzSERBaVhk?=
 =?utf-8?B?aFNMSTZkdlRIaWZXYlJzREhpZURnclpPaDNiSGptY2Q3ampya2V0UmpUb2lM?=
 =?utf-8?B?dG1VcW5CSkwrY1BvWmpZTU1EME5sVUQ3azBab1U4QVZyVHp6VEpFRUlTUzMz?=
 =?utf-8?B?QXVqZFkyWWgwNm14R3l2UEk5OE9QT0ZyQTZzZmhrLzVYbExKcllyS0UyOFF4?=
 =?utf-8?B?RnpvaHVlNkpmTVlua3JBWHNFT29tMjBSWnF2bG9xeWV4S29uMlF3eU5VRFVB?=
 =?utf-8?B?RkVhZlF1aEM2ekNHUnZlQTVuZlhmdDJsdmhENWR3ZmtzNDBTVm5XWnZyY3dG?=
 =?utf-8?B?L1FtUlY1eEFrNHA4TkdVSFE5eUtDd251dStmU3BsV1ZpQVRjTjRnY3NqL0NT?=
 =?utf-8?B?V3B0cWtRZVZVVExGNDdPVE52eWRkVE5Pd2U1aHkrdmlzU25EeklPVjNPaGN1?=
 =?utf-8?B?eURISko3blhOV00yU0k3WURKNzYrejBETnBiVEQrQXhLN3RkL2ZpLzZ5ejlK?=
 =?utf-8?B?a0NtWnhlY0ZiWmtvbjdtTURkcmEwcG44ZS91cVZyaHhkSHlIV0IyQnA0RUtk?=
 =?utf-8?B?YTJhYlZiRXROaTNsMGtrY1FoRG1WWGovU2xYVnlGUVJBVXpEcVlOUjREdmdn?=
 =?utf-8?B?UTA0ak5JWFcxVWxYT3pvUVU5dzRXVTNIeDRZN1I1R2I3dUo2MVd4a1pXNFVl?=
 =?utf-8?B?NVBlYmxtb2oybk5lbGZvSm9oRnB0dXlIbTlBZGZ0ckdZK0ZsemI4cGxZZmxu?=
 =?utf-8?B?a1orUVd6L2YvN3FrZ2hFSmM2V1FxRHhCVzNUd2U4UjhXWVRZRmZXZm1CZGFr?=
 =?utf-8?B?VEJxQmpkaUdENys0WXVmZjNtTm83eG5mci90aTdSOVR2dHYzbERLY0dVU0Vn?=
 =?utf-8?B?Y1JHRE5mSnl3b29pNWhQbTZ2NmNHRURwRXMzMnZ0RnNrMHVTTFZva1VCR2JX?=
 =?utf-8?B?alBKQ0t1VEsydS9FUjE1a01MODVzMXJRVUlIa1JEUGZwUHUrRHp4dVorT3VV?=
 =?utf-8?B?Um80d2N3R2Q3NFV2NUxNN0NsYzR4U0dnSWFQVFRCMlFEam93eVI4dWY5dEVH?=
 =?utf-8?B?V3diV2JkRDFCcm1mNkVjYTNFd3ZiOHN0RUZKcDNmK1dWdlEvVXZUQXE4OFBu?=
 =?utf-8?B?YkZaYS90UThmVVhFZVczQ1F2cEZUYTZValQ1TUkwVGFEVnMrVGJQNEh0anAr?=
 =?utf-8?B?YkliRy9FaDU2SFozUSs4dFZ1czBENFZMZkRCbDFmTlR6WUZEY3YxQ3RlTXRs?=
 =?utf-8?B?TnUxZ2Q4ZWhybGY1SDQzbUtUTmlJdmpFazhoOXllOXEyamozMDdjQS9OSHpD?=
 =?utf-8?B?WTdUVmhrTVRDbGJWVUV2VG1kTzRabHJjOWNpZFQweUFQbk1BYjE2ZjF4a3Rh?=
 =?utf-8?B?d1ZMOUplR2pMNDhXYTlYcE4zS1NFc1Jhdk1sUXJxaUVCb3VRY0IwVzloNlNZ?=
 =?utf-8?B?ZXNlRW1nZExkcXhUVkdUTjd2dCt3Z1E1bVpLbTFDQVl3eWlvZGdHUHJBTTB2?=
 =?utf-8?B?L21NK1IrbGRqSmpuMDl4eGp1YTd3TTkrTll6dFJTVnlFNVllUXZpT3lpeWl4?=
 =?utf-8?B?bkNQNXpYNnZKQ25OWnEzSzBUTW5wc1hCaDBMaEl4WjNnSFIxS0twdkdYZ0tL?=
 =?utf-8?B?YjY3YzBtM0NsM2hUY1hPR08rMzF2cUZhd1lRK21yTXBSWUIxWDR6aWlndTYw?=
 =?utf-8?B?K21icHo5VTJUbWY1blNTTm5OZmU3VkxkK1lMVDNVanVFTVd0TUVhWU9ObmJi?=
 =?utf-8?B?NW1ONm13cTZCM0dSbG50QXBVYXdKaG1TMTlOMlA5VkFOb2toNS8rNXZMOENZ?=
 =?utf-8?B?VVkzblZNTnhVYktqZ3lNSEdyalRJS0E1T0ZPTXVyUC84T0Q0VDYzNnJzZlFs?=
 =?utf-8?Q?U8p4jmvbKgY3V2tkbawV6tiyPWFS3o1FYz5NzbZL6Kcr7?=
X-MS-Exchange-AntiSpam-MessageData-1: MN9zdrMwMJqv6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed397c21-1049-4087-5c6c-08df450bfe4f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:32.4451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPOrHRPElurx14rMpSS2TD8yEc14gC/4SOIP9blPM5iXv9KHVzANxhNWdB7Nyh1wDfVYKUdZrO7MZx4Tu3Y/Kw==
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

ARM's arch_setup_dma_ops / arm_setup_iommu_dma_ops creates a custom
IOMMU domain for DMA API usage, and continues to do so when an IDENTITY
default domain type is selected.

When a DMA default domain is requested, however, the core owns the
domain and we need to skip our custom domain management. Add checks to
arm_setup/teardown_iommu_dma_ops for these cases.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 01646521b5cf..e0faf7fba0e4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1791,9 +1791,12 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
 static void arm_setup_iommu_dma_ops(struct device *dev)
 {
-	struct dma_iommu_mapping *mapping;
+	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	u64 dma_base = 0, size = 1ULL << 32;
 
+	if (mapping)
+		return;
+
 	if (dev->dma_range_map) {
 		dma_base = dma_range_map_min(dev->dma_range_map);
 		size = dma_range_map_max(dev->dma_range_map) - dma_base;
@@ -1819,7 +1822,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 
-	if (!mapping)
+	if (!mapping || iommu_is_dma_domain(mapping->domain))
 		return;
 
 	arm_iommu_detach_device(dev);

-- 
2.56.1

