Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6FC606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nW8CcKYQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2217E10EA40;
	Wed, 18 Nov 2026 00:36:20 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32A010E16E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz9yVntK0iccZAMQicX/mc5LnQQXOL+6EAamE2Wp39/ei6/cWGtk5I7THaEnQ4coZd2S/Ru36nUyAmTm01JuVnpaUtA38LZVOdlnWRDR/keyn4/xGPZ3UWsdQAkEawPjTRLQ4LHe/mwpX/QU1UFKjJEGxq4itg+EqIOlY+QjoSsvFAblzBQrdiH57TyHvnVPYPAb3u9qoaZAhMT6/SMdoH8DhQtTSAv02/JeDK0XMaVA4Iziocb6mxZYM3BfEyEoQVaFqTEPG2BUbpUYhUFYG3F/4frY3EGrWoGKJA79Bvj6kzELkPrV5a+7oeZrGoVcn/vrIe5dU0xEROdlng+UTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0DFVzl7zvYw4+1S7jlw77lepDC7W1GKuqCxL6UVrc0=;
 b=Gg2y0u6o8R8YUbARGv8Z7nOdWorq518hyJwzdRuYTwtQB4ox7nrCmUuIeIRLQ+KwojFqiejOty8DAGk6o4cWoVJESQNnrLXImPFmk62/9XkpGE1Fz9Lb4gJLPbSnPwnmiASVNjmE8I5U0Qx0UseJPrZVw3z7dbqmR0XiVDQ6Ej2zjs9+XA1D5+4qFl4UUHBWJ0OwUd63Y2hNNrskrPBq9MYU17wp9EvtuqkO65rm7BwS0aYAXzltKT54s/zPSM1NkVI3e1vTRlS5kjh0y3bNwSU1RYwC6D4cLkmjfQ+pplm5ZRq1mLg2l0leUtMdH0wEQa6hGbViS4XcLVG4CLl86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0DFVzl7zvYw4+1S7jlw77lepDC7W1GKuqCxL6UVrc0=;
 b=nW8CcKYQl58ErfcRxZRQUz8kIcekjzpNaStzj4FnL0OG90/SJUX892wG/Mteo7uG3Rsc04XoFr+yVZeXI0xDYIqe1Rc4dgyF3CJDjIskHuaT5M1hhpItQ1zOU85lxEcahA5n3R7IB7Kl2CzKNBpGV8/IkoqsDYoKYmFAwRYC9SRnFeAcUWdB7G5aUE3/2xZcTZGQRplQ8LFAgnlRBSb3Hm/rfRiGM8nZD8ssQWUlGrMVFWqR3LvGyVgN2hUlbCAH24VT/xmG6sYRq4wzk11fuX1yBDkFZkWFnlEyqSnqrD/EPJdEpyS+R4MBKQqSoCr3QXrOFtOCV6tnsGeJz/1tZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:09 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:08 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v4 00/12] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
Date: Wed, 18 Nov 2026 09:35:09 +0900
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwWoDIRDG8VcJnmtwRrO75pT3KD3oqs20uAZNJ
 CHsu2dNoLQU9vjBzO9/Z8Vn8oXtN3eWfaVCaVqGetuw8WimT8/JLZuhwE70OHCruMlRIqcU44W
 7aPiY0jd5LqEXXvRBA+7Y8n/KPtD1ab9/vHa52C8/nhvYLo5UzinfnvEK7e7V0bBb6VTgglujg
 nZSGrTDYarkyGzHFFkLVfyhQEC3RmGjRDcoNAK0/E/JXxSuUnKhpBbgemUhBPxDzfP8AFf6AyR
 rAQAA
X-Change-ID: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125
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
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e18f96e-855e-4fad-5a49-08df450bf02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|18002099003|6133799003|261009223027099003|921020|11063799006|56012099006|261021135927099003|261102123227099003|261026130827099003|261026140227099003|261028144727099003|10067099003|261022113327099003|261021130227099003|261022105027099003|261021121427099003|261026121527099003|261022115727099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: kgju5l7AotANbfl/s0WHb2bM/z8hlXN0w1w9WPxfW40XZkI27DzkMH0nKj20nwaSkvvTLh/3BC13/tTFqiLyLPkxb/pyBsjOgap/fhnYtcZ5teGlGRPJJnBV4aBm37IgmHppcZFdY0kx4TfS6GpmlDtF7UvgK1+cHcBz0fSC9srT9DzZVJJBOtl6RkUMuuJ2QWAEubRki4REcMq5DA6YwCA5aYWV8NXZ8aYeZkKctjwnLW5w3snCTCMn3+GBSssF3/mPj3UldRl+KybbTwcL9cfqc8NoPhd/B5gIvwsWVRRVZQNH+wWrS0PAycVeeZun5pd2CXgdEEDmkLt/W6lANVwH6s6bhJHcJmfYAknQIQkymd1YDS7OdryyTyshAoUmwJZ3v5mCIs7paDFIMv4ktniniXK0U9eUutdqrnyikz6RPQa2UKWKda2TDATEnVgnBmVJsItg/kSAQ7jK0u6zCINGemvGFvv4T3ROBoj1HPGlHkoyISGdNEbpudY80UWhjq7AxmfCu4Mq2WnzPxh2CNG1BIeaedfXZPqNk4w05NQoAzoTx/kgejU6Y8HDsdzYW3j2GsnEYg8gGzIEmvPpaPAda9MYgkEUS2QxDQeiH5NQcpCBQIYt+U+SX0eIG8GB//WjrMphkEPPVfEo2rwrHee3mMIS7hicRRHsgXBUfKIRQ2Ttpqv1CtdOB3Ldo7dPihhZKCdFe5WvA5n/gl226g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(18002099003)(6133799003)(261009223027099003)(921020)(11063799006)(56012099006)(261021135927099003)(261102123227099003)(261026130827099003)(261026140227099003)(261028144727099003)(10067099003)(261022113327099003)(261021130227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261022115727099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckx6eVhxSTk4aFc5V29pM0szS25Gc0QyMk5QRHlrbWNNbDFta2xBNGlGQ1Ni?=
 =?utf-8?B?TXc3VnlnOUF0QXk0L3dGcVR5LzNtNVM5cjN0T1R6TU9EZjhvNnp1Nk1kRktv?=
 =?utf-8?B?Z3ZTWkU0RnJzMkRJWjMwMU5ENkZsU0srNC9lNHRIcUFKVjFUaDZCMlBSYmtT?=
 =?utf-8?B?N3ZmNmZxYWVzYnVPOERRazA1Zy8xLzB3MnlFeUh0alBxN2Z5QldqYVh6bEVj?=
 =?utf-8?B?d0dXUUVOY1ViYXhDUjVkbXdnZFNUTEZ6TDZKbE5kSHZ3SEdMUUpRS2tlNjh6?=
 =?utf-8?B?V0VQMittT1VRTk1CY0ZzZit4UU1iM1hhckxpUWY2QjNJbXlSUkFqMlFidnJp?=
 =?utf-8?B?NG1sNzJjSm9FdThKNDR4S3hVYndWK0dUZEI4Wmp2UTd6UmRVRnNickI2UkdF?=
 =?utf-8?B?aS9RTjh2RlJhWTNZTGRPd1pWdVJHbGw0SVhTaFFFanlJTDlVVUxVNXIwOW03?=
 =?utf-8?B?L1dTaXZuVDgrT29uMXBFZjNpdHU0NHY3RHdTZzhCT3J1eWowNlJ5cXVyT3FH?=
 =?utf-8?B?WUpQZWdaanNJeHpPWGlrdW8rcEkzRTJYalN3Z3VqSE1LYTBFWm9id292NEYz?=
 =?utf-8?B?K3o0cU91T1hOV045UTU2eXlJeHEyS21ZQ1pJbzcveWF6NExIVms3d0NDbU1R?=
 =?utf-8?B?cm5qY1NtSHkyZGFYYnFxdDJNc1JNWmtuY241c3RsZk1CeUh2VlFtVHlLbDFU?=
 =?utf-8?B?b3NvOE1EMlhMVnArWDM1UjlMWVJDYTZpbFNoWnVoTXhuUDZFL3h2VUdKMUNn?=
 =?utf-8?B?djJNMUFpTjU0WXBIbi9tbkVvQi9aekJtUG1yRm1tWlQ0ZmF1L2Y1akxvRTRG?=
 =?utf-8?B?b3F1M2d5bW5zWUp6M3JFNUFBT0FBVHphWXBUci9qWjkvU2VhdXczUWc5U3VP?=
 =?utf-8?B?R0Q2RldDQjZsTFBaMUx2c2U1QkVXOEFmYWtpL1JDOVMzZUxoVUZ5dWF2RFg0?=
 =?utf-8?B?bkhkSWJjbzdxbnJobDJIVlZuOW1BQ0ZCVXdqL2poZStaVmNBKy9KOHpPRFYw?=
 =?utf-8?B?bjFxOFZmVFF2d2lXbUowUUhaYUdxQ0F0M3FKdjdZYUhGU0FDMUVIRlpSQldB?=
 =?utf-8?B?QTJHTEduN2hoSkQxSTNQNm1kYzdoaTgyczJEc2tSbHM0eWg4aTVzdEIvSllx?=
 =?utf-8?B?SWdNbVREWE11VVVEQnJpTUNNSDZDYVhEZzRlQVIxS3VyaG9GS0oxbFFldHRR?=
 =?utf-8?B?Wk8vVHdML3RjZnkydzJkaEtQL2pTQzlzMG1zN2FRdDBhNXgreDM2RmxDdWVs?=
 =?utf-8?B?ZTV2ZzZyMkVyNUFHb1VUVUtjaWFjcUdMY3BLTzFxQWo0UWlKQ2tOTmg4REti?=
 =?utf-8?B?RDY4OWpId1lyQnVmSVcyV2pTbmEvQ2p4V2xsL09GRWZRRWtySllMYU5ZWFVU?=
 =?utf-8?B?V0Z1Zm9KUldDNHBLTU41K3pac3h1N3VrWVVpSmgvekwwTG1jV2V3SHdmV2VM?=
 =?utf-8?B?am5Ta0Q4eGFpT0FFd2RuODZaL3JHM3F6UENQRG93SDNFaXpqMkZFV0hCdStq?=
 =?utf-8?B?US9YeEw3Z1JkN0ZZMlpzUCtrUW9JT0FGdkhzTmhsclIvZ2xmamJiWXBBRk05?=
 =?utf-8?B?TjBqdnRKMXNuMVZsUmluYkE0b09oUFJGajk2SXE2YS9jS0RheGhmeEgvbmJU?=
 =?utf-8?B?b254MTJFTlZkWjlpcFJNc1NKVkJaaWlrRks4QmdEUHhXaWRXTkJ2Y2tjSzJE?=
 =?utf-8?B?ZDQrNUhnVEFuN3dPWEMvZ1hhQWNOSjRvR0hkWTFvT3FxRk16cVNLTHdEUm9K?=
 =?utf-8?B?K2QxbmdJMWhmNGlrVXhXS3NvMTNjK2pIQkZyeWV4UHhXeFFISEFTTlZOYTh3?=
 =?utf-8?B?RHdXZytzVUFkdVhOTU1vTHpiRDdUbk0wUytOd0lKdGg3SlpyK2t2OXE0cERN?=
 =?utf-8?B?YmFIaFBwaDlHSmVFemU4RDVsTHRwTFZ6bW9zSFR0SzlGbjlKMGJ3d1pHWU5X?=
 =?utf-8?B?bm5JejhyWmEwcXljdHB2SkR0eno2Y3lxWWp5ZmdxdDVuVFFkZGVITmlsaitT?=
 =?utf-8?B?MDNQOUFYajRqWi9wSFdEdGNUeWRHMmJkWTdaM1lydmhqY2F3anlPK2hzSDlK?=
 =?utf-8?B?V0JPeWwySEVuUHpReGh4NE04VDFSK3BCNUhUYUcrazdSL1ZvU3EzempnYlE0?=
 =?utf-8?B?bjlhb2cyeVhLWjViaFlzNTU0NnBvR1pWUGdnZWJQL2ZpVmxURDIyNVRFS0sr?=
 =?utf-8?B?c3NZY0hWTGZuaTJCQm9JSzJnR1J3bE1RZHFsMHlEbEVDbU9rM0VqajNSVWNt?=
 =?utf-8?B?MS9pSnhyZXo3WE55SHU1TnRtdXlhWkNFaEZpeTZMcHBBQW1JR01FMnJxS2Nl?=
 =?utf-8?B?ME9xSVVtWURKcGY5RXVId0xPUlVmUHpFbDlsRmduSXNtK3k4V0lkNXhVYkxZ?=
 =?utf-8?Q?EfhBKzLLwYjmolniHcgKypW2eixrUZk4tnfBgE7coa+Ou?=
X-MS-Exchange-AntiSpam-MessageData-1: zJSKri3dop3Fng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e18f96e-855e-4fad-5a49-08df450bf02b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:08.8183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzv9mrpqsPntV1k4rq58wQHvSyBhpxLuqzsUJH1RSmfbM4LbvSaG++hZEYBFb1YO4cCdzQkqzAv27PlhHZ42Qw==
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Depending on the probe ordering, TegraDRM does not currently probe on
kernels with CONFIG_ARM_DMA_USE_IOMMU enabled, such as with
multi_v7_defconfig. The Tegra SMMU puts several display and 2D/3D
clients into one IOMMU group, and the legacy 32-bit ARM DMA API path
creates one UNMANAGED domain per device and attaches it with
iommu_attach_device(). That only works for one device per group, so
every client after the first fails to attach,
iommu_device_use_default_domain() rejects the group with -EBUSY, and the
driver goes down with it. tegra_defconfig is currently working by virtue
of not enabling CONFIG_ARM_DMA_USE_IOMMU.

Robin suggested [1] that instead of teaching the legacy path about
groups, we should explore modernizing the 32-bit ARM DMA code a bit by
making it use domain cookies and have the core code own the domains, as
is the case on other architectures. Still, ARM's own DMA code is kept to
support existing drivers and APIs that expect it, and because dma-iommu
is considered too big and unnecessary for 32-bit ARM.

The series is in four parts:

- Patches 1-3 are preparation in the IOMMU core:
  1. Move default domain policy initialization to core initcall level.
  2. Add iommu_teardown_dma_ops, counterpart to iommu_setup_dma_ops.
  3. Add cookie type for ARM's DMA domains.
- Patches 4-7 implement the DMA API side on 32-bit ARM:
  4. Split up mapping alloc and init (bitmap alloc) code to separate
     functions.
  5. Implement parallel dma_ops / cookie APIs on ARM side.
  6. Avoid domain allocation when IOMMU core does it.
  7. Check upper DMA range limit during IOVA allocation.
- Patch 8 removes the forced IDENTITY default domain in core IOMMU
  code and adds explicit IDENTITY defaults to a few individual IOMMU
  drivers.
- Patches 9-12 convert Tegra:
  9. Fixes device parameter in calls to dma_get_sgtable.
  10. Allows deferring translation enable until driver handshake for
      selected devices.
  11. Fixes refcounting during switching between two paging domains.
  12. Switches to DMA default domain for selected Tegra devices.

This moves 32-bit ARM devices from the unmanaged IOMMU DMA domain to the
core-owned default DMA domain except for mtk_iommu_v1, ipmmu-vmsa,
omap-iommu, and msm_iommu. (tegra-smmu also stays on the legacy path
until the last patch in the series.) See commit 8 for further
information. Existing drivers are intended to continue working without
changes.

Patches 9-12 are provided for demonstration; we can deal with them 
separately if the rest of the series is accepted.

Patches 1,2,3,4,7 are applicable independently.
Patches 5,6 depend on the previous patches.
Patch 8 requires the prior patches to be in place.

Patches 1-8 only touch drivers/iommu/ and arch/arm/mm/ and associated 
headers.

Best regards,
Mikko

[1] https://lore.kernel.org/linux-tegra/910d1492-ad3b-4201-93c6-208be1dcde7d@arm.com/

---
Changes in v4:
- Initialize default domain policy at core initcall level.
  Fixes warning reported by Marek on Exynos in v3.
- Add tegra-smmu fix to correct refcounting on transition
  between two paging domains.
- Rebased.
- Link to v3: https://patch.msgid.link/20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com

Changes in v3:
- Removed the forced IDENTITY default domain workaround from IOMMU core.
  Explicit IDENTITY default kept for a few IOMMU drivers.
- Keep the arm_iommu_* APIs usable with DMA default domains. Drop
  related Host1x/TegraDRM cleanup patches. Detaching an explicitly
  created mapping restores the default domain.
- Install and clear DMA ops in iommu_setup/teardown_dma_ops for
  core-owned domains.
- Use iommu_is_dma_domain instead of custom flag to distinguish between
  core-owned domains and unmanaged DMA domains.
- Allocate IOVA bookkeeping in iommu_setup_dma_ops, after attachment
  has established domain geometry.
- Add an upper-bound check during IOVA allocation to replace setup-time
  dma-ranges based check.
- Remove change to arm_iommu_get_sgtable in favor of correct fix in
  TegraDRM.
- Simplify tegra_smmu_def_domain_type.
- Link to v2: https://patch.msgid.link/20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com

Changes in v2:
- Addressed sashiko comments:
  - We still don't take device tree dma-ranges into account for the allocatable
    IOVA range. This is closer to arm64 and only some OMAP5 devices currently
    have dma-ranges where this would matter. A check is added to error out in
    such cases. As in v1, this code path is only active when enabled by the
    IOMMU driver so there is no breakage.
  - Added a check in tegra_smmu_enable_translation to return early if the IOMMU
    attached to the device is not a tegra-smmu.
- Added .release_domain in tegra-smmu to handle address space release for DMA
  domains.
- Link to v1: https://patch.msgid.link/20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com

---
Mikko Perttunen (12):
      iommu: Initialize default domain policy at core initcall level
      iommu: Add iommu_teardown_dma_ops
      iommu: Add cookie type for ARM_DMA_USE_IOMMU
      ARM: dma-mapping: Split mapping initialization from allocation
      ARM: dma-mapping: Implement and expose DMA setup functions
      ARM: dma-mapping: Bypass the legacy path for core-owned DMA API domains
      ARM: dma-mapping: Bound IOVA allocation by device DMA limits
      iommu: Enable DMA default domains on (most) 32-bit ARM platforms
      drm/tegra: Fix device parameter to dma_get_sgtable
      iommu/tegra-smmu: Defer display client translation to driver handover
      iommu/tegra-smmu: Release previous address space on paging domain switch
      iommu/tegra-smmu: Use a DMA API default domain per swgroup

 arch/arm/include/asm/dma-iommu.h |   9 ++
 arch/arm/mm/dma-mapping.c        | 297 +++++++++++++++++++++++++++++----------
 drivers/gpu/drm/tegra/dc.c       |   8 ++
 drivers/gpu/drm/tegra/gem.c      |   5 +-
 drivers/iommu/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c        |   5 +
 drivers/iommu/dma-iommu.h        |  49 +++++--
 drivers/iommu/iommu.c            |  35 ++---
 drivers/iommu/ipmmu-vmsa.c       |   6 +
 drivers/iommu/msm_iommu.c        |   6 +
 drivers/iommu/mtk_iommu_v1.c     |   6 +
 drivers/iommu/omap-iommu.c       |   6 +
 drivers/iommu/tegra-smmu.c       | 122 ++++++++++++++--
 drivers/memory/tegra/tegra114.c  |  15 +-
 drivers/memory/tegra/tegra124.c  |  12 +-
 drivers/memory/tegra/tegra210.c  |   6 +-
 drivers/memory/tegra/tegra30.c   |  18 ++-
 include/linux/iommu.h            |   3 +
 include/soc/tegra/mc.h           |  20 +++
 19 files changed, 486 insertions(+), 143 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125

