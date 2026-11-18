Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F8D606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ROlGTxow
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E56110FA2C;
	Wed, 18 Nov 2026 00:37:08 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F5610FA1A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVi8EguGaCBePXkpFclOUCCiGDus4o1b2VnnQYO1g4OuAGKn0fY9gX2NBD3q9YZHmxAnfwN8JYJ9z52MDvUguRDhTa7FFtFOaIRmy2GquplFr0YAfZs5V7Iqquf2bJo+1TXHtjppNWV03D4IXX8/GmFg2l1F+FPVCDY06ASxWmvuKK5dFu0G4hrFqdysOeYn/a9G+9gUbicQ/njgrtD+At+oN4WstkZSvU07jg2Dp4AerqaCDRM7J4FQb45BCzZHBQ4uabg0iYBhM0fhQ0EsfES2RIoT3CY26Dj38FqEbkke8FSycHxaFzWZ79i59DjLAUp0y2IFUorr/FoO2es22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml0cCLOI45CGsjPlReCVjhBRqAbS6JAtpwtWNkncgi8=;
 b=PvVlI1zGEynuhn4NOa+dFXgzxoBwCsSDWPiyaDSDO3i8+f+0Zbck3JLPN9LgZg06NxagGWDEBqLIpweJBL3A8J3vpmSUVvzEcPdpg6RwRrPOfnX5rDZMIlGXXCBw+VU6tFQ1G1tZqYT46Fp3/qpnRwQxUEya5VvQrk27PlS9C/xEwcaVk36BwEc2F5e0LuiRgzumXu8KRbLRuoJTgBDm2XeNu3y5/ZzNSjdAOe+//hyH+12uv605ONADxnxHPorjoJJ9TCKIyXgq5N/oJ2kwWf8NkW8sjeSo/GOlKv2Ltdv9w/M5c7v5CWmR1VDlFyJNoG47y5be0tJDSyGUSYqwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml0cCLOI45CGsjPlReCVjhBRqAbS6JAtpwtWNkncgi8=;
 b=ROlGTxowKPG0wMd+zhOON2yHt+RXlOTmHzAsQi7xTzHGXg3oIeNqqjr2FCypCzmmK1Y+O/3vXVU4IVn5qEM+cAjK4nQPBZ5FbxWUzZzXAni8f7VTOxlbpiS9qU+0eMrMrNVagNtGuBWH4aoZiYX89S0EUc4bWrDUK5gSuHBQDQKQH2pVH3iMXLGGbQdfL9/Qb0cxJhAj+NFfKPNnqIj/p6Z37/isVzI5YUERAyT5Zs2F/mUmHIGXcv0/rSiMuNGPpaYZk8v7huGkRVk3fdgU5M83JLRBsgQyXrCrvo0steFftKXiYQAW/dZkmtAyJz3Qtr+XvDlOUY+aYcpbtryscQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:40 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:40 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:17 +0900
Subject: [PATCH v4 08/12] iommu: Enable DMA default domains on (most)
 32-bit ARM platforms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-8-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6d9d8b-1fda-4e43-c165-08df450c02c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|5023799004|11063799006|56012099006|261102123227099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: f8ZgHaLSihrFm7Me8At2h2BsmHv6I8ZB0IHV1E+H1g/WO7wsqjZQrxMr9bASx7d87eQ/eEG+TkIBpaalWGzxTZ+R0Bmv1paADrdkbSB+lac3dByqJGSJ1B27DvXhOWOlL163Y5NlTyDX1E3pBvLfQukGZeTdx3BkYbNfli8x/ZaCdVSCMf78keqFpGJrij1aHSBtXuvJtkQZ0DtiZYmFHU+UaQD/EDC2vpZT/9v7SC+CfMX5ZKdqCy5BqPsU/gbANnIwEXwRg2+MBE69dM7CcyWSxT1Zh1gXTkSJbbhCbHDfsKWsCtxJMxMqzLIN/DjF6x6ragqKctFc8dIpaxD4BFCcOx0rob6EjSIAXCSRVeBrjUh4burvimT5vpG06KQNByntbZZyhWjSGtSd4Y+/UKRSdOdcS3DM/azON9MutU9xYtKTtW1BhT38Iu0pTuRiaaCtgWNlBB7oby4KR2OB0xJAps1HjQE+Y9BZKW/5xgN7H0dUPJU9a1SFkaDvsTNPl6scvGxdaMBSCv0d94X69YnujGWQ0VGJfdYRLpRT+IDWH/7YAY1u57PgbULhmgQZeqYhkmXwSgQiw7pslYSnaUGXxSgaqfWDPBMpbnLmshTtz5VtUnq+FpDDbwjNGmaICUHAjZVLj+r1VT4GhwVkRkm33cesFQMCqrj2n5lWKe6nszGqH/2ppLrIbY4Dgx/ctp8XEmDUnYxTlPyF908Khw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(5023799004)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1RlWG9TMGNTTHJ6UUM1NXZOVjJyZFdxTzRSeEV5REFEVnJoNFFBdUMxclJv?=
 =?utf-8?B?UEowcUQxUkRXdTNXQnRkYlRaVmRLYW9iTTc4b2greEVwb2lqQ3ozck9zcVVR?=
 =?utf-8?B?TEFkQTV6VHZxWlE1WmRNY29VWHFNTklXRndsdFRYY05COXN6VmlzeXBhdFlq?=
 =?utf-8?B?UldmWkt5aFVibEE4ajNtMkkzRDhpU29jeW52aWQrOHNlcHNtWnd6NmxFNzhX?=
 =?utf-8?B?QWMvVzdBd00zbVpEcS93VmZ0VlpXWnVMcDR0MmYwOG8yOENKVU9iUFpPWUNl?=
 =?utf-8?B?elM5d2RVeDl2ZU1waml1Qko5ZGRFWVlsTGJvaFVVVmk1TnVTclVkVUp6MzUz?=
 =?utf-8?B?Rlo1RS9ZVFcxK3REUHQrM0F3bEtFSmMvQUJLbndRTkRLYWRHbjBBMEI0UlRZ?=
 =?utf-8?B?em1aVHA0Zjd4QkNMeGkyc3hZNXg0eXgxVzA1clh1UjREWkticWZ2cjlyYjc4?=
 =?utf-8?B?SDJ1dm9lTDk2RHlaRkE1UzBzb2Y5eFMxVkk2TTZGSi85bG1mREgrZnE0bkYx?=
 =?utf-8?B?VVVsbGlOeTdDcnA2WEt1cEkyWkpXdDMrWEpSWXF0UWY2T2oyc0Q5TkZIb0Js?=
 =?utf-8?B?bmR4Zk14NzJleTVRUVBvVDZjWS9LWmxtaFBVMnR3R3l3aTVaaTlmMWhvYkZj?=
 =?utf-8?B?WlRzVWFKQTdDNkM5VThINEhsTzFzT0h3WnR4OVpCRWNzREh0bW5NSUNkdVhi?=
 =?utf-8?B?Vk9NZml6dVBwaEt1UXl2VGVGYlhHcytTYUVLbGp3N2NYbkdEZVVtQlhuYVhx?=
 =?utf-8?B?MHAzb0FiOFpkaWVLQkluSVdHUER1MFc3NisrUUFEalRWNEFKS2N5eVpvdGhK?=
 =?utf-8?B?d1FBM0ZBUklDZGZ4NHFkVFdRYVRSaHZ6SGNnWmk0dlBNcnl4VDNVUlhpU0ZR?=
 =?utf-8?B?T21XbWRiV2QxOXJMcWRzekNIR2VtS2UzSmF1aUZzcFpYNUVMdWJXaVFIV29k?=
 =?utf-8?B?NjBZWHk5d21abnRXdXQ4VVdQaWU4VEVBSXpCdG5EU1E4NUpDRTJtOW05TzI4?=
 =?utf-8?B?N3B1TkJqUUFtWW51cURuMExwTCt2YzdkTFdZTGdYMitpVkx6dW80TEhKK0dR?=
 =?utf-8?B?bm1DNEhlYnBINDdMOVUxdHkwMkZNY1ZXTGx2SUxUSWtKblRGK3I1ei9SRTU3?=
 =?utf-8?B?UlZYSEhRaEdwb0UxakUrUk1ha0VsbXRXN2ZnQkIxSTl0ZE10M3RhT2JhOWpI?=
 =?utf-8?B?UGJSNTlSWi8wc1FQeHJ5S1NPRk0xRlJLelJHbGFpOEFmekNabUl3aUdlWXlW?=
 =?utf-8?B?UXRGdmtpNVJlcUVQZnRJeGxuUkFHbm1SekR5ZGpJQktGWmtwbTROdHZkbHA0?=
 =?utf-8?B?Z3BhcFpoMXlNb3BmK25XWG5BNWZ6S3MxUCttbnd6OXBiamJYMVFneGJaMkRO?=
 =?utf-8?B?RVdObXZEeG84Y0tsU0VnZldZMjVYTjcxWEVieUJ3cDhjV3V3ckUzMmc2WWIw?=
 =?utf-8?B?ZlcrekxRcmJ0NE90SG5zRTVqNXMzT1NOVGU3TWdMcHJOSzBhbGpYMmJlcGUz?=
 =?utf-8?B?QURMTm44OWsvQ0ZNVHlLc08zbWJxdEFKMlU1VmNrUXdrdUJmQWtJd09RSXdN?=
 =?utf-8?B?SWxGcDFuekROMHV5V2FCclBGVXVFaEVhSjFuQVAyR21MVXA0azVTdkJuN2gw?=
 =?utf-8?B?UXRrWHBzc2lqYjNwRWVJU0ZmYXRDRHBHS2V2Wmd5WENmS09aRnBXVlkwTENs?=
 =?utf-8?B?dTZUWURsVEM2R2ZESWdRWm1hRitIK1NRMm9ISFdiTlhDNlRkMjZQekpkQmFH?=
 =?utf-8?B?ZnU0cEU5ZTNZMXVqUmEzR0kwRzZBM1hTb1JUbmErQUsyWGVNNXJjODZiVS9J?=
 =?utf-8?B?d1l6OENWSEZIdXpGMFRmelU2VHl4cWhqclVIU09CeWptUWpzaGhidStyYWVi?=
 =?utf-8?B?S0dNV3djVjVlOExuTTFsS2ZCS0kxeERndWtBVXMzUmZGNzM3OGFUU2VaSVlI?=
 =?utf-8?B?bDN3NHBCOWxhek5jZ21YZ3dxUnpYRzZjVzdLVW51NHZmNTc3OXVMTlVPNyt3?=
 =?utf-8?B?WEIvKy95bnlGbUIrOGtZMnc5TFdYWFc0bVRveDdHTC9SZExGTlJxYnNvYVRp?=
 =?utf-8?B?Ny8xYXU4WS9nbVpoZUFua2tXODdmSm14amxZbCs0eDY0eWdUVHBLWXlFbkFE?=
 =?utf-8?B?am8xcndUZENxeXdiY2h2c2FpL0JyODRrLzU1TFcxNk1yNENSaHFGTzMwSmdh?=
 =?utf-8?B?ZHNoN0pUVE5hbTNyL0cyUDd4RmtyYmREOTF1S3k3STVMaVhkanc4empTUDdn?=
 =?utf-8?B?Rkx4MWVpcDVSdVkrY1NWOS9qZzU1dndUSmdURXlKSzVPcWdycExxWktLNEFQ?=
 =?utf-8?B?V1pSTXRTWjJDc045UzlpZXpoNm5nZFZCdU5DTC9OMm9HMllXaGoxcDVZSzVZ?=
 =?utf-8?Q?qZGk9KKlEZjA9wQqD/FnzbVoR/j3cVPmQmdb5vrlfgDFs?=
X-MS-Exchange-AntiSpam-MessageData-1: wmyZJS9f70Cj9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6d9d8b-1fda-4e43-c165-08df450c02c5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:40.0601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czs/RbbdjpFNENwjGWXs8SMddas+7onLfTKTBVZQ501JjIX0IaqMqjPGKEXaC7CwOyWhj8SB6x5gEr8MBEyncw==
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

iommu_get_default_domain_type currently forces an IDENTITY domain type
with CONFIG_ARM_DMA_USE_IOMMU because the ARM DMA implementation
traditionally installs its own UNMANAGED domains.

The ARM DMA implementation now supports core-owned DMA default domains,
so remove that override and follow the same logic as CONFIG_IOMMU_DMA
platforms. The static assertion making CONFIG_ARM_DMA_USE_IOMMU and
CONFIG_IOMMU_DMA mutually exclusive is removed as both now implement the
same callbacks making the build fail anyway.

Based on LLM eyeballing, some platforms are still not ready to be
switched over. For these platforms, a def_domain_type callback returning
IDENTITY is added unless it was already there. Specifically,

- mtk_iommu_v1 only supports the domain it internally creates via the
  arm_iommu API
- ipmmu-vmsa creates its own shared ARM DMA domain. Also creating a
  default DMA domain would exhaust contexts on configurations with only
  one context
- omap-iommu among other things due to the omap remoteproc driver,
  which relies on detaching the legacy ARM DMA domain to restore direct
  DMA ops
- msm_iommu expects previous context assignments to be released
  before attaching another paging domain

These drivers can be migrated later.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/iommu.c        | 20 ++++----------------
 drivers/iommu/ipmmu-vmsa.c   |  6 ++++++
 drivers/iommu/msm_iommu.c    |  6 ++++++
 drivers/iommu/mtk_iommu_v1.c |  6 ++++++
 drivers/iommu/omap-iommu.c   |  6 ++++++
 5 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 31c5e336dac7..2eaae4818913 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1887,18 +1887,6 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 
 	lockdep_assert_held(&group->mutex);
 
-	/*
-	 * ARM32 drivers supporting CONFIG_ARM_DMA_USE_IOMMU can declare an
-	 * identity_domain and it will automatically become their default
-	 * domain. Later on ARM_DMA_USE_IOMMU will install its UNMANAGED domain.
-	 * Override the selection to IDENTITY.
-	 */
-	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
-		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
-				IS_ENABLED(CONFIG_IOMMU_DMA)));
-		driver_type = IOMMU_DOMAIN_IDENTITY;
-	}
-
 	for_each_group_device(group, gdev) {
 		driver_type = iommu_get_def_domain_type(group, gdev->dev,
 							driver_type);
@@ -1915,11 +1903,11 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 	}
 
 	/*
-	 * If the common dma ops are not selected in kconfig then we cannot use
-	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
-	 * selected.
+	 * Without an IOMMU DMA implementation, force IDENTITY if the driver
+	 * has not selected a domain type.
 	 */
-	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
+	if (!IS_ENABLED(CONFIG_IOMMU_DMA) &&
+	    !IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
 		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA))
 			return -1;
 		if (!driver_type)
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index f32dceb32237..c165b4431686 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -873,8 +873,14 @@ static void ipmmu_release_device(struct device *dev)
 	arm_iommu_release_mapping(mmu->mapping);
 }
 
+static int ipmmu_def_domain_type(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) ? IOMMU_DOMAIN_IDENTITY : 0;
+}
+
 static const struct iommu_ops ipmmu_ops = {
 	.identity_domain = &ipmmu_iommu_identity_domain,
+	.def_domain_type = ipmmu_def_domain_type,
 	.domain_alloc_paging = ipmmu_domain_alloc_paging,
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index d79d5ff2a551..ea3cecc6adcd 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -691,8 +691,14 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 	return 0;
 }
 
+static int msm_iommu_def_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
 static struct iommu_ops msm_iommu_ops = {
 	.identity_domain = &msm_iommu_identity_domain,
+	.def_domain_type = msm_iommu_def_domain_type,
 	.domain_alloc_paging = msm_iommu_domain_alloc_paging,
 	.probe_device = msm_iommu_probe_device,
 	.device_group = generic_device_group,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 66df5bb67a47..12b9168d176b 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -578,8 +578,14 @@ static int mtk_iommu_v1_hw_init(const struct mtk_iommu_v1_data *data)
 	return 0;
 }
 
+static int mtk_iommu_v1_def_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
 static const struct iommu_ops mtk_iommu_v1_ops = {
 	.identity_domain = &mtk_iommu_v1_identity_domain,
+	.def_domain_type = mtk_iommu_v1_def_domain_type,
 	.domain_alloc_paging = mtk_iommu_v1_domain_alloc_paging,
 	.probe_device	= mtk_iommu_v1_probe_device,
 	.probe_finalize = mtk_iommu_v1_probe_finalize,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a..56cdc4c670c0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1712,8 +1712,14 @@ static int omap_iommu_of_xlate(struct device *dev, const struct of_phandle_args
 	return 0;
 }
 
+static int omap_iommu_def_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
 static const struct iommu_ops omap_iommu_ops = {
 	.identity_domain = &omap_iommu_identity_domain,
+	.def_domain_type = omap_iommu_def_domain_type,
 	.domain_alloc_paging = omap_iommu_domain_alloc_paging,
 	.probe_device	= omap_iommu_probe_device,
 	.release_device	= omap_iommu_release_device,

-- 
2.56.1

