Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A0CCCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA78F1125E9;
	Fri, 16 Oct 2026 06:47:53 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFFE1125E9
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzIRn/i5a3Uefo5kTuL/N+hbT9RSvugAk5GmjfGmbDmM1hdgo/KjQ1TPw7pm8cXPuY23GZMJpVtzIHZgzHH/EFKZyOnTI73DbvKS+3CRyuSyv9f3MGm6cMNaG68RoTtxoeEbUVqyg1Bb23BWyPDqrOfXNbJY6FVtLlFACgmA4gS37FJEMIGihpUEdci470VDxiXn95r29chcuuSwvrgz/VeuSNupdsaR7j9Xi7TIcgGp4bq/OwAW+EgUNkeRia0r0HpQtApDZAv90+W2CfcCBkX70xlufjDpPPT35xNWERN//cKvLWTZp8tpNMour9sRnj1FvaGyMZGBui4BtgUPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhd7n89MMwo4gqI/25h4f8Tzw7JJGGhGtkUt6AgwmTY=;
 b=oadmQ30b7WTjFG2Tfklxjzh91NUVjZb1H/cJvaCfutJcKLzNpA21FF88cQ2kBwu4LS7gf3UgNzC58wyHFVA2al+bEy5IAq9Ccs194xgqAxOUipITHwzE925GyDPHxodVVx4q4uCYxwzVYazkjNq6TucvJeytwm2Rt2xn+wCKWUcATRztsYi/9Ag2UDhqqSXAyvUp/ATo7NUON6ywp34uUSzcZ040jfP0LfWkEKYoskIKQXvNiyH7rwNoP3ka0HMv6RtbsbZA7AIfLkhWtgiFm+wU9KP5ZWMB0mimJzSjag897KiSO+H7Qlb1o4vAHm9rt13XG4xnOlSUlcFi/fDRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhd7n89MMwo4gqI/25h4f8Tzw7JJGGhGtkUt6AgwmTY=;
 b=IpBRiJRHh/PSPDYiiGHjfU83/JWkmB5x3RlvGCbA7PHpaTyfjQeHGizFFZcmyX6zmJWoQWEl0OTxT39PWvTtTgldTnyB3Gg57Zdmr5Ud1Epnjx49WUBamnfSvRgH61bZMRQeo7JAvukfXU79mUrVl2Lhwqa870vzVarCQNLRlBZEsCDCHQYQhjIF7Q1rsDDbrWmTLSG1MKkaHUJQWC/0rbqszMt4e91VEyLWJ7fYNtMAPVa0IkS0GtZ3/GMAlEt0TNfefyCmq8OYqWfXBpek8RSfAwbSBnk8LEn0rUjdcSF2EBhLbcyYT8F8YN4bSizLJIUAibtaJqmRga/64NTKDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:39 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:39 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:50 +0900
Subject: [PATCH v2 04/11] ARM: dma-mapping: Implement and expose DMA setup
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-4-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: ac48d3ce-5914-4918-9338-08df2b515ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|6133799003|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: myDxq3DcSR7f+Y6h2wtj87IIEY25mFRnOztqtRwK12UIl6Z3KFW9910V1shI9OZr+dswQ2Yvhj7Pt9SgYcFcn/tV/INf/dHIx+z3Jw3B7xnDluqGSc8FnhGCtYZYinPsdEdCpZvs4CNrmhQ8In9tWpq2E+1f8vGckVqB4+uEnk1ZOkv7JdYCZy8W6pNzcWBMBZAvW1riOKK5iyw3ZF9Fqh1LHg5Rd8VvnifZ7L8jsOTcBR85/bkGlfZSJQesG6jmVagmTfPEq7r35ceWVQEEgrWNei1cuRHykrNMuUUJkgPRPAH+AmGkJfdIWYAeIqg9aP7hhJjjoNrif0qQPnpbCa1SM3xRDeMbmbxlIAqpAr5ptaNG9i5d3S7CoTfq51RIQlEp7DVLUxVQGP5dQnKjH3ykY5jw43Keu/jg1NhUNiBJIHjRR043v6K6AA/mrTjPy9AvsCmeccjfGkEV4RO51laMbRWRI+hHL+MZkFJ9FMsCMtG4scj00ZHnBeP/xMNmhLLN6XyXdy5D7qCnnZug59AsuFv4GbH63RarjOCzJPwE3eo6R7dO/uBHYKAUBuYEUzScq4Bh8vO7mopHiDe5joupAu04sg0gCcyJV+KFZbS2M7pYd04v66c+YuXHI1RTAo5Mb0DcJ9S+WW6Z4z5fh6Gc33CEBpIuqiYHeXhdGN0oGTJTA9X/hWz6AamJwTwyNV+CXsgNIwj0//qHkNZR5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(6133799003)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdlVHJOSVpWVGdkdXFjcGJLYllmd0FRd2R1WGM3dUpYT1QxQXVIeFU3c2c3?=
 =?utf-8?B?WXJKQXpHL08vYXh5UTVNaUp1MjJUNXZZYzQ5YlEzMWdqaEJOS2JJbDRTT3lS?=
 =?utf-8?B?QkJKQnJEMWlVTVJRUlJsS2N1NDRsdFR6SDBzdXJLR3JFaGQvaDNraDJ1NDdw?=
 =?utf-8?B?Y3VKVHYvNVhhZmVOL1FpM3JPQ0xENndBaGdTU29CbjFHRmhQcEZ6S3d4RGlI?=
 =?utf-8?B?YnEwa2dLc0pQWmFVWGNLS1dZdTg0dHNLQS9mamp3TTRGaFNSYmczRjRsclo4?=
 =?utf-8?B?Tm9pMXZqbng3cGdaTmtONkdodkZsMm40Qmc3VHdaYWVxTnhHRUtSMWdqOXdL?=
 =?utf-8?B?YlI5b3V1eERWVXNKMDc1KzBzNVVMRktEbGpXVk1PS2F0eHBBRmpsR25vdk94?=
 =?utf-8?B?Y3dwTTVEaGp2dERSVXVWRnVzY2doUnRHNDhqUHB1Um5BT0s3YmhPRzhQM0Rs?=
 =?utf-8?B?V2FuU0hjVUdtY3hDT1R3cjF5REs3Ui9jL3pTZVZoc2ZnamxJRHBzVmNqd2F2?=
 =?utf-8?B?L29JYUhEOSs3eDMyVDFZT2xlOGJYaml2OUd2ZnZYQkJQWFgyTkc0eld0UjhE?=
 =?utf-8?B?TDhEcnAydUNkVmZkVUJpS2xxaVh3SkYrQzlFQmhKVXUrYzlybGdMYllBTElu?=
 =?utf-8?B?amVNUVhQak9pcjA1MTNzd29SamdIeVBVVDNCUS9aQ3o5ZkVTeU9DYUIrWGM1?=
 =?utf-8?B?UGpYRTZZckRtSURKTjErdHBsL1FsSTZqVlR3NUVKTHZoM1F3ZFpraXpFZ2Zu?=
 =?utf-8?B?SHJCcXd2bldJd0tLS2tkcnBCN2UyU1I2aDZsK05iZzBIdkM0M2s0cDFjQmxk?=
 =?utf-8?B?WFNicThqcUJndzZ3bWtFT1FqSDgzUjNaL0d6RnQzL0hvdmZrZ2YvUWtyYXE2?=
 =?utf-8?B?UjJTMGlOTktmejBhVkZxb3FzUXIyRGJSZXA2Z1poTW5NZnZXczl6eVFTeUx3?=
 =?utf-8?B?TXpmTkc3OVFIZzlrZDRYdWVrcE5GMzVGNjc5YnROV3N4bjFWcERheStLM1VB?=
 =?utf-8?B?WVlKODY4Wkh6UURONXU1aFN6QjhmT294Z3oxU3dXSmZvOERlNUdnYnM1ZXd5?=
 =?utf-8?B?cFVyemFSSUZNaUZ4UjFsSGZZbVJQVGUvVm9nQmZXOE5LSm1WNEtsQXlMclhj?=
 =?utf-8?B?SnR6WW5TbmJDM3cxU3pRWlljbW1VdGZFOVhTUkJZZE9WeHVPNTRlRVhMajVB?=
 =?utf-8?B?OFFJTW95cG41ZTN4Z1hlNnR5NzNERlgrL29LOExSa2NpUTB1WEN5emxyTnY0?=
 =?utf-8?B?dnlHSWVTREZQaTFaQ0lRdERIUVcyVkF4WkIxZ254RndmWkRxQ3lMZnA3Ty8r?=
 =?utf-8?B?LzBsKzVaT256U3dFSDQ2aFlncWIreEVDdjFMcVBkM1MzMW9LMmtvQWJLVlc1?=
 =?utf-8?B?SzNQSE9XQ3dpNk5yV016MEtDYlNlM1JvZks1V2IxTTFSb1prMGEvWmFHMVZi?=
 =?utf-8?B?MXMrSGtHY09FWnJnV2ROU2grelhWSjZiSGs1bXVtVWdHL0VVc1VGWUNTNlVE?=
 =?utf-8?B?QzA3cVhFcmlmS1pKUDdhNzcwVHRhMnMvaW1QbFpGaWRGaXFDVm5EMy9SbWdC?=
 =?utf-8?B?cDUvQXBiejZSR2VmMXMzQ0RFeUhzWTJoazJkanl0MGxpZkJJRGtZODR1ZTFH?=
 =?utf-8?B?c0UrVU52eXZJK3dRTmFxN1lwUjVkc3gzaTF4VUxrSDRwcmNrNlBsVU1WcjRI?=
 =?utf-8?B?WUlOeklFdDMrVGZId2xKNzRBREUyd2UrS2FIZHJ1K2tqMDVoYU5YUW5GNEVR?=
 =?utf-8?B?ZXloaG1VNFdwbDVVZldaYm1zaGI0Tnc1R3VlbWp6djVPL1MraDZlR2hLY2lP?=
 =?utf-8?B?dHp5cmJUeWtkQkp3Ymk3UFlubkc3WkxLT0hObXk5S29HeDJjOUlsVm1TV0V4?=
 =?utf-8?B?eThEZG5xbURIaUNjdEQ0eEVsOHdobkxoMlZWbjlxeXZtaStyM0tuT3RIV2hF?=
 =?utf-8?B?T1poQ0pPT29JVWNMVmtjV0dwaXZONkJDeTl1QkxkR0d0QVlCSWsrN2xkTHpv?=
 =?utf-8?B?dXRIMVcydWxybWp2czYxcmRVYmdwRVdrSDlPcDd6d2pudlFQUGt6UUxrWHF5?=
 =?utf-8?B?N0xQdUNBeUxrdG90NG1VMVlsNUVubHRMNFVoUGtlTlpMbi9HQU9uTG9Sem1s?=
 =?utf-8?B?RjFDSXdsUUszdHJmSnRHdTBEUnBkalRoeU9PNzJqclBzTVVCMXErdDdSTlov?=
 =?utf-8?B?SDk3dFlkMi91V0hieFF5SUNpSHF5RWpyRmpVaFhZQm1SazJFMWoybEhta296?=
 =?utf-8?B?aXpqdjhzSDcvM0k4MlllMktQUnFNaG4zdCs5TEczV2ZVaWk2S0JCOVIxS0w1?=
 =?utf-8?B?VWZBUkp3MFFtbStoeW1SRENZNlp5dUVPb3RySVhJT3A0N0RpZUVNUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac48d3ce-5914-4918-9338-08df2b515ef2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:39.6151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAyz4767llyjQWNYBIwsiYbRPdYAPG1F9W0nDOfFt8HQtNTitoyswY/pM8FszIoRxqj5q4aALpySK6GCOlv68Q==
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

ARM DMA domains are currently allocated by the ARM DMA code, with struct
dma_iommu_mapping owning the domain and the IOVA bookkeeping. To allow
the IOMMU core to own DMA domains as is the case with other
architectures, we have to allow that code to allocate the domain and get
the cookie from the ARM DMA code.

Implement ARM versions of iommu_get/put_dma_cookie that create a struct
dma_iommu_mapping that doesn't have its own domain, as well as
iommu_setup/teardown_dma_ops that set the device's archdata.mapping,
allowing ARM DMA ops to seamlessly work on these devices.

The code is protected by CONFIG_ARM_DMA_USE_IOMMU and mutually exclusive
with the same-named functions in the dma-iommu code; and not reachable
yet.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/include/asm/dma-iommu.h |  17 ++++++
 arch/arm/mm/dma-mapping.c        | 118 ++++++++++++++++++++++++++++++++++-----
 drivers/iommu/dma-iommu.h        |  50 +++++++++++------
 3 files changed, 154 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 2ce4c5683e6d..85cf9b05faab 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -19,6 +19,14 @@ struct dma_iommu_mapping {
 	size_t			bits;		/* per bitmap */
 	dma_addr_t		base;
 
+	/*
+	 * Set for mappings created by arm_iommu_create_mapping(), where
+	 * @domain is owned by the mapping.
+	 * Clear for mappings that are a cookie of a domain owned by the IOMMU
+	 * core.
+	 */
+	bool			owns_domain;
+
 	spinlock_t		lock;
 	struct kref		kref;
 };
@@ -32,5 +40,14 @@ int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 void arm_iommu_detach_device(struct device *dev);
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
+struct iommu_domain;
+
+void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
+void iommu_teardown_dma_ops(struct device *dev);
+int iommu_get_dma_cookie(struct iommu_domain *domain);
+void iommu_put_dma_cookie(struct iommu_domain *domain);
+#endif
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4284950a9246..f2d3e8ec3487 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1531,6 +1531,79 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
 	kfree(mapping);
 }
 
+static int __arm_iommu_init_cookie(struct iommu_domain *domain,
+				   dma_addr_t base, u64 size)
+{
+	struct dma_iommu_mapping *mapping;
+
+	if (domain->cookie_type != IOMMU_COOKIE_NONE)
+		return -EEXIST;
+
+	mapping = __arm_iommu_alloc_mapping(base, size);
+	if (IS_ERR(mapping))
+		return PTR_ERR(mapping);
+
+	mapping->domain = domain;
+	domain->cookie_type = IOMMU_COOKIE_ARM_DMA;
+	domain->arm_cookie = mapping;
+
+	return 0;
+}
+
+/**
+ * iommu_get_dma_cookie - Set up a domain cookie for ARM IOMMU-based DMA API
+ * @domain: IOMMU_DOMAIN_DMA domain being configured
+ *
+ * Allocates IOVA bookkeeping for the domain based on the domain's specified
+ * geometry. The aperture can currently be at most 4GB in size, otherwise
+ * fails with -ERANGE.
+ */
+int iommu_get_dma_cookie(struct iommu_domain *domain)
+{
+	dma_addr_t base = domain->geometry.aperture_start;
+	u64 size;
+
+	if (base > domain->geometry.aperture_end)
+		return -EINVAL;
+
+	size = (u64)domain->geometry.aperture_end - base + 1;
+
+	return __arm_iommu_init_cookie(domain, base, size);
+}
+
+/**
+ * iommu_put_dma_cookie - Free domain cookie for ARM IOMMU-based DMA API
+ * @domain: the domain being freed
+ */
+void iommu_put_dma_cookie(struct iommu_domain *domain)
+{
+	__arm_iommu_free_mapping(domain->arm_cookie);
+}
+
+/**
+ * iommu_setup_dma_ops - Record a device's DMA API domain cookie
+ * @dev: the device
+ * @domain: the group's new default domain
+ *
+ * Records the cookie of @domain on @dev, or clears it if @domain is not a DMA
+ * API domain. The DMA ops themselves are per driver binding and are installed
+ * by arch_setup_dma_ops().
+ */
+void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
+{
+	to_dma_iommu_mapping(dev) = iommu_is_dma_domain(domain) ?
+				    domain->arm_cookie : NULL;
+}
+
+/**
+ * iommu_teardown_dma_ops - Clear a device's DMA API domain cookie
+ * @dev: the device
+ */
+void iommu_teardown_dma_ops(struct device *dev)
+{
+	to_dma_iommu_mapping(dev) = NULL;
+}
+
 /**
  * arm_iommu_create_mapping
  * @dev: pointer to the client device (for IOMMU calls)
@@ -1541,28 +1614,32 @@ static void __arm_iommu_free_mapping(struct dma_iommu_mapping *mapping)
  * IO address ranges, which is required to perform memory allocation and
  * mapping with IOMMU aware functions.
  *
+ * Unlike a default domain set up by the IOMMU core, the returned mapping owns
+ * the domain it describes and releases it along with the last reference.
+ *
  * The client device need to be attached to the mapping with
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct device *dev, dma_addr_t base, u64 size)
 {
-	struct dma_iommu_mapping *mapping;
-
-	mapping = __arm_iommu_alloc_mapping(base, size);
-	if (IS_ERR(mapping))
-		return mapping;
+	struct iommu_domain *domain;
+	int err;
 
-	mapping->domain = iommu_paging_domain_alloc(dev);
-	if (IS_ERR(mapping->domain)) {
-		int err = PTR_ERR(mapping->domain);
+	domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
 
-		__arm_iommu_free_mapping(mapping);
+	err = __arm_iommu_init_cookie(domain, base, size);
+	if (err) {
+		iommu_domain_free(domain);
 		return ERR_PTR(err);
 	}
 
-	kref_init(&mapping->kref);
-	return mapping;
+	domain->arm_cookie->owns_domain = true;
+	kref_init(&domain->arm_cookie->kref);
+
+	return domain->arm_cookie;
 }
 EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
@@ -1571,8 +1648,8 @@ static void release_iommu_mapping(struct kref *kref)
 	struct dma_iommu_mapping *mapping =
 		container_of(kref, struct dma_iommu_mapping, kref);
 
+	/* Frees mapping too, via iommu_put_dma_cookie(). */
 	iommu_domain_free(mapping->domain);
-	__arm_iommu_free_mapping(mapping);
 }
 
 static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
@@ -1595,8 +1672,13 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
-	if (mapping)
-		kref_put(&mapping->kref, release_iommu_mapping);
+	if (!mapping)
+		return;
+
+	if (WARN_ON(!mapping->owns_domain))
+		return;
+
+	kref_put(&mapping->kref, release_iommu_mapping);
 }
 EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
 
@@ -1660,6 +1742,14 @@ void arm_iommu_detach_device(struct device *dev)
 		return;
 	}
 
+	/*
+	 * This pairs with arm_iommu_attach_device() on a driver-owned mapping.
+	 * A mapping which is merely the cookie of a core-owned default domain
+	 * must not be torn down from here.
+	 */
+	if (WARN_ON(!mapping->owns_domain))
+		return;
+
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 349d6a57e5a0..71b23cb698c0 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -7,25 +7,24 @@
 
 #include <linux/iommu.h>
 
-#ifdef CONFIG_IOMMU_DMA
+/*
+ * Both dma-iommu.c and arch/arm/mm/dma-mapping.c implement functions to set up
+ * IOMMU_DOMAIN_DMA default domains. Only one provider can be compiled in at a
+ * time.
+ */
+#if defined(CONFIG_ARM_DMA_USE_IOMMU)
+
+#include <asm/dma-iommu.h>
+
+#elif defined(CONFIG_IOMMU_DMA)
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
 void iommu_teardown_dma_ops(struct device *dev);
 
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
-void iommu_put_msi_cookie(struct iommu_domain *domain);
 
-int iommu_dma_init_fq(struct iommu_domain *domain);
-
-void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
-
-int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		     phys_addr_t msi_addr);
-
-extern bool iommu_dma_forcedac;
-
-#else /* CONFIG_IOMMU_DMA */
+#else
 
 static inline void iommu_setup_dma_ops(struct device *dev,
 				       struct iommu_domain *domain)
@@ -36,11 +35,6 @@ static inline void iommu_teardown_dma_ops(struct device *dev)
 {
 }
 
-static inline int iommu_dma_init_fq(struct iommu_domain *domain)
-{
-	return -EINVAL;
-}
-
 static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
 	return -ENODEV;
@@ -50,6 +44,28 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+#endif
+
+#ifdef CONFIG_IOMMU_DMA
+
+void iommu_put_msi_cookie(struct iommu_domain *domain);
+
+int iommu_dma_init_fq(struct iommu_domain *domain);
+
+void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
+
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr);
+
+extern bool iommu_dma_forcedac;
+
+#else /* CONFIG_IOMMU_DMA */
+
+static inline int iommu_dma_init_fq(struct iommu_domain *domain)
+{
+	return -EINVAL;
+}
+
 static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
 {
 }

-- 
2.55.0

