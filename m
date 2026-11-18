Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E5606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t4xbOQVf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D0B10FA2B;
	Wed, 18 Nov 2026 00:37:07 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD49010FA28
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRxUEHZEcwe6NLyAK+uXgexKpXPwC3HfX0hmCJ9ugQdJaD5xp+/SJdObAmxNRM7nAl2NCDGVx8W1Ox4u+PxhPhS0KJmYVhY4q+ZtKAt3JA7sT7zCUphsIJySy7/IAHbiyd2uG1oi0LAkN6kGSWr28sGPLtPwthYy2icfZLPlBOpueNeRPgB2TKFUe4sdZsn9i09OMCqdFBREa4R0b8/JCzKJYLELIQ1ccB6IY+P3vUzhh3sHodSdCU+tepDaEYK7IxFQLQWtVK9DmyP/veUdvUUrpN7aCtEpnshGrE/DnA3PP1/oll9vy0CtEgiCAwNbcoZ+R/GSKLJR7ANJm5m5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPzZYjkqEkpeyLz3RbE9NX2cP0Fs/KowOfQ+b/NsuRo=;
 b=p7ui5rWM/NQXD/ZI/VwqD2WaX4VvngMb1lc7GInLsSmOI+0wsnWoNRG0uP4jMJtWmbf7aQNLJ2PwSw6TYzEO3WIZJDMtTAHIyC0W3bepGblu397bJcRgWDtZvTXfkDvsPjuc84OtA98ce2KM9yKvFFi8+mNvQtFzu07nai0+osTYDxOyuaeyTmz9N2VWpvoe1Oh1oKE9BEsv8YRulDiv5hx01+1Q+mJMHgpN0Fwpw9aSHAHvcMgHKHiV+528vbKGjGlbYYIlqhnOuYDGtiKzqLm7Mqmmq01BpjJ4XTLLYt32fxw6NgJqFqjM8kIxH8SjyQ0mFJdozFo+sm769HJlyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPzZYjkqEkpeyLz3RbE9NX2cP0Fs/KowOfQ+b/NsuRo=;
 b=t4xbOQVfLfFEaXFpH1NJWqBaBIBn71La6yELXiZzKk5pGHEIqFIKxPSN69/SyspG4734ZX+UupZxLghJK8MBRq1RJnZ+MKMKMRHFGU6z6yyU8a2iCldq654dI6234WdrHsrFlaXeYNhF37hETJhCAoVvgK08wlvuo39KT5oFxJ02e6mpOOuTM5Zsy14PAMxWX88HEAIguGUDX2xyLeYh3qsKXpSXO+39BRTx7OHaA4tVU/gvzUDg1K6WPSadA7COeUZjVb0yPkctxFmnf6MsWrJn8Wir3rJ5W00aJqlB5irygII5wN4OuFWsOMtcea+xI1ovX2vPNUvFZg43hN2+Zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 00:36:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:51 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:20 +0900
Subject: [PATCH v4 11/12] iommu/tegra-smmu: Release previous address space
 on paging domain switch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-11-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 7175a530-ccf6-43b5-8f1f-08df450c0984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: IuK8WZUHDs+8giG+M6i3OIqDHf1GuqK2YeglLAoMsh/DcolW9QUqJPL1+Gjsmud4wJVBk8jRwHxI9aoilzXu3kY9KZs2IIDSHJTeerlCJCi6nu817s1HKEqyxd9s3HIEuO+exhG1623FkVb0cunfqbMzr07CfRaAk9YHI1XAk9lJSoPE0PziJS8oK6segOSH/aTbfdJ37nMGZXI+XqRtssGxAFk/rn5VGEIBbM9Fa5h6y/VRaWu5GtXywK3rSssQVDatAt72QukCEvfB7uoOMfdAIe4rE/p+byoyJnim2HQ7m+QSTAcStASKB89Ohyq1nLyG215kIOmYarO26NeXhishmFLLN/5jUnv1CJZUn6Ax3PXjiJ/5ikXI2EDyee/ckV6vJxfeg9ZZbtskxEP2HnbRrLHrTCahkOlCHWgPiRxr3exVihY1BecqnlFGR4p0Py939sIpcstiI/z2l/5D4+79NUpw0I2IwXMCLBZa1ZH5k0BMAgj4kD9+9mdyK+oMjJJng/C5PJeMKn1yb8AqNK5s3j6P4YhwsLlIxXYrR4SdLevL2apzSQKaROoyp5u4IR91tV1gh9Z3bK0lic97/oUR9NB+SvpJ3JQ1n18j3Wj0/oKOMhF7qE6Spwd3a4eE3j1HoYLM9xTXb311b/Ggtu4h+mjcmJAOWT05MzOtyiVy05wfZ9osEZ6B689oOU0DGm3qYP6f32a5MpQVWpmq3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWNtMWJmVzBaR1FGWGxXY25IK25CNVRLd1liL3hMdXRxdlRoSXV4Y1d4R1Ux?=
 =?utf-8?B?TUhFVCtFdURYMnZ1WHl6TWZTbkhXL1gwbEZtTlRZZUJ0cmhMRWM3bFpuSXc5?=
 =?utf-8?B?MUk0ajFHUWp6QXRuNU9VQXhuRGNBV1BQckk0ekdERHFWMG9GeC9DSGcwYmd1?=
 =?utf-8?B?Mjg3RXQ2K1g5bU9qd3ExRkFVTFRTckp6YW1UMC9JbmIyUDVLbU1PUzlYOGdK?=
 =?utf-8?B?R3R2VEpkOWsrSFBsUHlwcUdGOG5IR0dmNUZkZHJZRFBwaU5pVHY2a0dKRmdh?=
 =?utf-8?B?WEF0c1ZPUXhtK1NYZDFENlJOYWlpOGV4ZXZyNTJLanhkV29COUtHbHB0QlI4?=
 =?utf-8?B?b2Rjamk4dHdid3lwYjQ4dDBLOTNFZ3BLQTVQYnc2bVNuL0FUSysybGJaL2dT?=
 =?utf-8?B?WUtMcDd6cmgzczdWdnNnNmRkdU03MHZvU0tOQmNVVE9ZdzFEQ0Vvc0Z4Slg1?=
 =?utf-8?B?NmJoWis1akY3clZ4MXVtTWpsT0t3WHlpZjdxdkcrQWhYNFUwVWFGcUErcW05?=
 =?utf-8?B?OXhGTktwd1I3bXUrUTErbzFLZStxendCWEo2cms1NnlIMmRyQXdBUER1dVVv?=
 =?utf-8?B?QlRNakZJRjlXbDE1OU5wc1hWLzVaVDRleWViS3lIdTJQc2hYWkFoYjFqMUNT?=
 =?utf-8?B?WFdVbzBwNHRRbEREWW0rTDluelhiajduR0FPTEhnbnlqd2l2dVFxc3FDWDBK?=
 =?utf-8?B?ZERTbzhjZ1NpQldPbGlyOFpYdHl2K2dPYjNzbGpnTFpvbVhLWmgyYTNOSHhx?=
 =?utf-8?B?Tk5tOXhZSFpYbkw1V1BnRkl4WS9qNlNEMEk4NU1kaXcrRGlSOXVtdUUrQlJl?=
 =?utf-8?B?bXVlRm9Xak13MC9UZU1xcjZ3VzRWYnBDODRXZ1hleDJkRU50S0NvUW1PMThW?=
 =?utf-8?B?amRFaVFlS1h4bStlemN5bW5WVzl6U1BPUXV2MWkzKytJdU5RNEVFTWxQdC8v?=
 =?utf-8?B?akRxOVAyYTU4R0NoaHpDM3VaREVJSUxteDllMWFDb0E5Q2xDZWRFd3hRMFJR?=
 =?utf-8?B?RTlCOG1oYzhwYWRWUWVYeW9odnNLbzRKN1l5TURDMEMvckkzbmJET1RFNkNH?=
 =?utf-8?B?UjdCNDVVT2hkTVRQTzhRMXk4b21QYmVqU052a2xpc3BPVTRpNGIybVB5Z1pu?=
 =?utf-8?B?M0hVeTlvSzVTRHVDOFdRZVRIdWNoL3Z5N2RMeUgzR3d6bXZtb3IrQ1BEdU1Q?=
 =?utf-8?B?OGFMSHBFWmxrSlpFbTZ0bWZpdGtZczFLNVFtaU9TTG1kRytFWnArOUtMb0pI?=
 =?utf-8?B?NFNtTWdTT3dub2M1N2gvWmhaNDJtelEzTVRzci9ueGpranRwa2VUK0kvQ29h?=
 =?utf-8?B?U2FuWG51UmdTWlVYS2l2VTZkak5xb0Rrdjl4RktobXdLQ2g1TXg4L1kraS8z?=
 =?utf-8?B?V1NJamJ2aUNUUGZkZ256MldvTlF0VXRrWERGREdLWG15cDR4dDdNd2h1WHV6?=
 =?utf-8?B?SnROVE1xQXU4WUdyTHVGVVJLR3VEMmVXQzlxOHNxU1V6VkQ1WmZIM05HYWVw?=
 =?utf-8?B?ZlErNm95akVGYjZNRU9HZm40Mi9rWkdaN0pJYlVpODdLYXRmZVFKbC9rdFpD?=
 =?utf-8?B?ZExLRUFtNDMrYUl4c2dPYjFkWVpSakFaQ0RWSU40bDdPZSs0d0U4dFpJc0JG?=
 =?utf-8?B?NW9NRGgwalJMd2ljTUU4TC9EQlIrU3ZVcFU1bWVlblFrdVRXampscDNLd3VK?=
 =?utf-8?B?MFBHNkgxMDNwRkhCQnloWGJDUjEydkVrMERRRkQrTDI3ZzdmeU1la3JjaXk4?=
 =?utf-8?B?NGJrcTVSWWlhdXJBM0FJKzJqMmQ4dTdNQkRBaXRXc2N5OXFTL1c0S0NnWmsw?=
 =?utf-8?B?QUdlWW41U0FsVTJqZGdTYy9wbnlhNjFhQkVyUjR5NzhGN3M4OUQrZURMTHda?=
 =?utf-8?B?a0gxY3hoMDVpeXdKcHpxNHpvckFIcVRMeGc4dXZObU50UE1adXJKRDR4elU5?=
 =?utf-8?B?bGt6eSs2U0tjUUhNUXFpRnBNR3NMOXpFc01IcWtWVThqd0YvUmVta1gvTUc5?=
 =?utf-8?B?T1pYUGxKQmw3czJnc01xeUZ4bVFZQlI0TEluYXhSYXh4VUpoWno1a1RlMXF1?=
 =?utf-8?B?MW9CbnJhenNFV29IaVFHT2hOU2ZBakxGTi93WVhPQ3BDWTYzOW9sdVVUcTQ1?=
 =?utf-8?B?UFBFR3FDdHpET1d4bXF5c0JDeVVQdkpOU096amZ2Tmo4RFRQenZtWXRmV2RQ?=
 =?utf-8?B?cG5ERjNLQXpUS2VZdEpTVk1rWW9RQTRrcW9mQlhNQkIrUXlpSno4UzRQTnZR?=
 =?utf-8?B?YVYwOW84Y3hkcDdXdVRaK29rUjg3YmdHTUpCMm5lNG1MbkpOSkJvbHpzSFVG?=
 =?utf-8?B?QXJtc1lCbGo3c3RTc2M3VUNRV29idGFDam1TcTBZbHgvZlF4dnFJMVdHNDQ2?=
 =?utf-8?Q?7/H1P9VdxvndSupfY52CtcSlAgeOzgGP3HUHS+ezCPpMD?=
X-MS-Exchange-AntiSpam-MessageData-1: w6Bm4g22A+cjTA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7175a530-ccf6-43b5-8f1f-08df450c0984
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:51.2378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gti4TisPG1w+0/7ZLiIdCmbSFiyrfJqHOuX6qXA2dwLa+ZgdS2sNbNApn16fjwvoVlcOGb2KzJe5dJmz3w6cPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tegra-smmu driver currently prepares an address space for each
SWGROUP when attaching a paging domain, but only unprepares it when
attaching the identity domain. In the present world without DMA default
(paging) domains, this broadly works, since drivers attaching a paging
domain will go from identity to paging and then back to identity when
detaching.

Once DMA default domains are enabled, attachments can go directly from
one paging domain to another. This leaks references to the previous
address space, keeping its ASID and page directory DMA mapping alive.

Fix this by having tegra_smmu_attach_dev also unprepare any previously
attached address spaces.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index d0d23435d5b7..0e8414d8a504 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -507,24 +507,27 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 	if (!fwspec)
 		return -ENOENT;
 
+	if (!fwspec->num_ids)
+		return -ENODEV;
+
 	for (index = 0; index < fwspec->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
 		if (err)
-			goto disable;
+			goto unprepare;
+	}
 
+	for (index = 0; index < fwspec->num_ids; index++)
 		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
-	}
 
-	if (index == 0)
-		return -ENODEV;
+	if (old && (old->type & __IOMMU_DOMAIN_PAGING))
+		for (index = 0; index < fwspec->num_ids; index++)
+			tegra_smmu_as_unprepare(smmu, to_smmu_as(old));
 
 	return 0;
 
-disable:
-	while (index--) {
-		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+unprepare:
+	while (index--)
 		tegra_smmu_as_unprepare(smmu, as);
-	}
 
 	return err;
 }

-- 
2.56.1

