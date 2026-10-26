Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4249606A338
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HP0YlOn9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF2210ED0E;
	Mon, 26 Oct 2026 09:28:22 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1584910E1C2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb3ZF88Ndq4M6dj+NLN8nq2Rmh1Bm6Cg/o4xY0kY/FKqUorG93WMzuuEraqQrcVJxn5+nxJXd+d4OKaxm0kbELBer5mvpHXK69RrsOXwhT9KuePEA9MkO/ibN3rashkPusJha/xwChu+mQ1nQVX4yOYX5bymjQLhUDzH3gmI4bgKnQChZ7ZayWSVfJftSSOo8cL/94CR0z1w3hXbAJkJzs3E5rn7Nnp22GNuoWnOUPaDe4kU5UvZl0g/UIUBdarOahUoTMXptvqhK3IOTuQDArty/9FMIY6PiToSWNGF8cn2KIhcRnXgXdhAjuurW2Ba7/YDtFcpuTY8Tzz0rKddfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8aNW+JrQr3DdX0aAyHVa1D7/8uW82vdiXIcvHNix9w=;
 b=e+77y40ZmNKXjxhsxyapZaVZI9lYLXrOPwiJFWwPFmB6nyVmS/mQTpfuct+X1n/k1pL94EW6lQOZr6HU5QlIJXwhmzn59s1tPsjuELq3UAjyd5ifsq7hXOd+PbA5qIi0xofvO8dkHicvdh3CodyH8x9yKci9+U5qcKS8mfuGfpgIgkFORbvovi2qrsrh+NLUDr9dOBTZqb2sSdK4XuLBURksf9gNCZxuJj3FTPoS1ROSqcUd87Rcp9CQ/ZqezhJ/F0RnWg0rHEQYhhsi51IfFVw7J2l/Xe4Fd9Fy3lzNMyV5xgEkdlMOm8//79cuC/RqbNrEZtPS/rapGP5TsN1hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8aNW+JrQr3DdX0aAyHVa1D7/8uW82vdiXIcvHNix9w=;
 b=HP0YlOn96lBcuslW2Scbo+XQFanrp7fcA/iJqI2Fxxe7Q8DzzwhfHN/XlScCZzM53u8oRpXexjIj9tdv0TsYaM8aXnZt57wrVi0wuTqBzGRQxaGJ9lxqlSMJJWGGGl3etC4fH1y5+uXybhFC8y6nctQ3XcVW97mS8FFbIS6rvJ3/D69t7K1fxwXB21U+5xsBMm6Z3N+gh3Lqc6KLOZd57V/BHChAEjxHoDtigsLdfyRbc4c4e6NjRd7OYVSu7IfesDOFa//nUAmDuKg40qsSZd7AcIlHD/p9LYzaiCZzjZzzWCzmjsSkd+C7+it60+RMU5ap5vDg1dvzbaU3dRhzOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH4PR12MB540976.namprd12.prod.outlook.com (2603:10b6:610:51e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:20:56 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:20:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:30 +0900
Subject: [PATCH v3 05/10] ARM: dma-mapping: Bypass the legacy path for
 core-owned DMA API domains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-5-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH4PR12MB540976:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2e0632-1d40-4624-6469-08df33427069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|921020|11063799006|56012099006|261022105027099003|261009223027099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iYgupMK4Nd5tPz/uGUzhRgTj78hfwnil5WOlCHj7nfC4an/r2xVo6Dr3srkm8BaG/+KF/tJXCWsRDHCrCjKD4OLddO8JOYRyFZ4qGlHowNEwmhTlULpmtgDxeEqlct4Zi6xqvw1w+1nPdV4St188qbbZJdc9J5yTIFhJmFWLb1D6l6a5TwHljyN6vrK9lULmy7cbrtgwY37wpa9J7unjyvQqrpRW3c2TudD3RVe80rQO2t/q7AWzlVLwQX6zF16dOdPE2q5SUbNQPMP2I3+NaweOQ48PgMpU8WqOVxFumGfW33M/C4jjQMMzrXGZTfNXR1MYxQlVN8d80L7zprl7GLYjAo8OlY7bkiUBqLYY9JKCrWbXfF91lswb6f/l2g7PU7sDFIpOMqfiLnTqrT4l/InyEdjCtB2A2Rh7HNW7XpEVcjX6AhvYjexaz9eA1wUpiSucmMNpBbMonKMNU2jJiHqs0JA4AEdYRoQ1ht4ZB3TSkWDf6UUBAM+sZtBuSWak8edfQGhJkRAUcuFwx6inM3THOZrOiS5lVVMD2zTPaRRsUyGFvBLpnPSJBS2u8OB+WusXF7zpjgQtMwuigeGBql/gUwYHTG/W/VQZLRk+KlPUih36XdP4On5opD8BV332W8zJ0nsdlbQzJ9NxuzCTy38/zYhMi9Wgsc3KMBMbLlbtOF6Nxjut9zm5jHgk+z1aWIhXCnkg63KPfvUK5ssarg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(921020)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVd0VTdhSGRyTXNDcmtTZ0dnbkxpcWJDaThXOWpUbXBtNE91d2poQ0tld3Bk?=
 =?utf-8?B?TE5KTmt5KzFSNmR4bmplQ2c0THBQTElyc2VJMUtGTHdnMkkwVDBEL2Nla1Bp?=
 =?utf-8?B?ZHRZc1BlbmJyc3VGNHBYamVnMFF3T2Z4TXJCbGt4clN6ZG5EZ3lyd2d4bm1n?=
 =?utf-8?B?WnNHSEJySXpXRHlNY1NBVXV0MkJ1ZGR5djdzTlhRTlNYb0JjZWlQeGl6QVk3?=
 =?utf-8?B?S2hrMFFNNURxZ1VFcWJ0ckljWGJFbFJ0Mlhpc2wrNTdWaTNaUW9BNHFSNE5l?=
 =?utf-8?B?WVp3a29XUFRaaGNySjNHdGJXTWlNZkF3Q0ZmRjFWdkgydEhzMTlnQ0t4VkY3?=
 =?utf-8?B?QlRtTWFmRS8zNmRKSDNzdWNoTUtXS0JPQ0NJUW9MQ0Y1NkJHcWJjbGUrbXdK?=
 =?utf-8?B?ZHZPYnZUbjNFQ1FWQ3FmQWhlTEJHRTBYUUZqM3R1dVNnMkx3WitJSGNwRmhJ?=
 =?utf-8?B?ckhFd2hTRGhXYXQ3eFNkSzJGKzl3ZjlwSlVaTE5NSDRlK3hhV3pNVzg5WW9L?=
 =?utf-8?B?dDJuZ1gyamdDK1Y0cjBEZTFWUzhUY1lxdUZJajFzdGJrVEl2K0VJbHRRRFNy?=
 =?utf-8?B?ZnRNMDBOcmdnSVVkSXVEVEN0ZTFjblAvVGhmWUNYendzeDQ3MTBNZEhjb0lH?=
 =?utf-8?B?V1hsVURkYXdUOUxOcGtsK0h5Mm1JQkZibDFBWVNpRGU0QjlIb2ZNMUVVTC9S?=
 =?utf-8?B?NXRlZWk0b0c5bGRsU3h1ZUpwMFU5Vjc5OXNGVitzUWFaNE9VN09IaTBuM0xq?=
 =?utf-8?B?cUEza1pESWF2bVRrRm5CcmZoTUxDQVdHT1hLajFaQzM4VkNVenBPb2NpdVZa?=
 =?utf-8?B?cS9Yc3dYM3F3TG96UG5KdDlMbUp5emZPdGw3WEd4THZyQXI2QjlzbEdjQkZk?=
 =?utf-8?B?ZE16NE9ua2ttNitnZEFNQk5rM2k0TlV6UzZ2NVJFWlBlSzVraGRVSU5OSUMy?=
 =?utf-8?B?MmhTaDJCRFdwNkVqQ1dRc244bFgvc3JIUzM3ejVjL0xKc2NDYmIzSmtHaFE5?=
 =?utf-8?B?TUVMY0hjTC9XWG50VTBKRmtRODlDRXh3Ymk4VUJuTUxMUUNaeDd5WDJRSDVr?=
 =?utf-8?B?eFR6dytINVlmb01LQVdGanA4cmcyaHJ0MjROU3k1alZjdERFUk9jR2hreFFv?=
 =?utf-8?B?aER5MG1seW01VXJubmg1Qm1OU1hPZlRCN2dYVzlsQnRpVGRacjZoSlV0YVJj?=
 =?utf-8?B?MDY1SVRNMWFnWnZGZjFsQTg5NG1Rc1VxM2J4ckVlKzZESGlsR3hRckZXY0h5?=
 =?utf-8?B?U2M1TEJ5elNqUFNEWWVkWE54SWIrZzdWa3ZCYTFwY0J1L0JGVjkrSXRzaXNq?=
 =?utf-8?B?dWVKamFEZmoycTRaeVZZeE5oRXB1TjBqODJ3cG9kdW5lSWhSUGVHU1BUbWls?=
 =?utf-8?B?VlBkRkpTa21GTjI1NUdpdTl6cVdwK3htL0FmVjdXT2VlaUgveVNGN0hXUXhE?=
 =?utf-8?B?NXhJbFA4dGxLN3Ric2s0blJFVkNKdjFTOEUyN3NsNkYwcFZnNUtxUWJaOW14?=
 =?utf-8?B?MGFhamhnR3cxd25CLzdtVjNnd1JSV0xYWXpVOUpIMGRyOTF1ZG0xQ25MNG40?=
 =?utf-8?B?bG9zNlkwcE1DeW1vZGRLSnJFb01oNkdwd2sxaFBPdFNjejNXTDdlVmgxbldP?=
 =?utf-8?B?VXpJUmNJdmtlUTlJdElNZ3c4VnBjTmh2M0hlMldwUnZFRC9lWEtsMmFsdEhp?=
 =?utf-8?B?blZUM0g4V3hMdXBTTU5pNzcraTNGUkRNWDlrclRCdHJZTjZseEJ6Rk1wZDh6?=
 =?utf-8?B?aVVJYWZYZGhhUDNuZ2Y0eDFaUExrWWJsQy9uaHd1U1lhRUlwUzBwYXhTeFlo?=
 =?utf-8?B?eXA2Mklmdkh2S1NKVTZESDMvRnBnL242a255eTVKYXNzaXJJdUVTMGs3a2gv?=
 =?utf-8?B?NTczMnpwNFJqUC8wN0hBelNDL01nOFB5VDFyVlFBbDg2ZXZGRHJ3SUpZVkcr?=
 =?utf-8?B?Wk1hc1pySENuU0wvRTl0NHZ0OEp5ZHF0eDIyR1hjWUFlakNkTCthd1R4dkds?=
 =?utf-8?B?a2FYb2grRmpQY0RJczBiNGZ3UXg5eGNiNzhzMXd3SmRKaTNqTnVVM1hZbzJR?=
 =?utf-8?B?QWJBTFl5aWxPWmRXdkdFRUltYWwzeEpyUHpLUG5ncnM5cnI3L1ZGL1BWVHdL?=
 =?utf-8?B?R1JJdTAvRys1NEdrRWZTMWN3aTR2V1dHM0RrRHIwRHpCbGljMWYySzl0ZEdV?=
 =?utf-8?B?YjdZOUVVUDJhV0RzMUxybG9oMWY0RHZXOFN0eWZTYkgvSDZidjE2dmtaSGxQ?=
 =?utf-8?B?N05ZY2Y5MWpNNlQxN0VHZnJxR2hBWGtORmxSVzVSMWxZcXplL2xJTnZGVkc3?=
 =?utf-8?B?T0x6cDB3cDAxZ0ZnK1NiMVlSQnN5ZGtOL1lOR0h1Ujd0QW9nRGNEd2I2VDdn?=
 =?utf-8?Q?kB9tzY8mdYevWBY5CEapUoYqjlV2Yn26j4BJmATUznEtn?=
X-MS-Exchange-AntiSpam-MessageData-1: R+d9pqOGyspYHg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2e0632-1d40-4624-6469-08df33427069
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:20:55.7838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qW4R5X0BDMZkGlwNL0IkWzJl0KoiDBj38l647iTZW+DfvNQCjpaWNSVWGoqKZ2CeEqgk2fvZJbaDT2vLvH1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB540976
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
index 48b9a9f26095..b82cf58f8bc7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1788,9 +1788,12 @@ EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
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
@@ -1816,7 +1819,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 
-	if (!mapping)
+	if (!mapping || iommu_is_dma_domain(mapping->domain))
 		return;
 
 	arm_iommu_detach_device(dev);

-- 
2.55.0

