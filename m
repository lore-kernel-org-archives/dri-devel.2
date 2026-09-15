Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0B6C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFA710F85D;
	Tue, 15 Sep 2026 02:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCTvP5Dq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2517B10F85D
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9CVLfBdIhQpHu85t0ei40vV5d/wN6gHGI36+UDvZiLl679gqCG/raO3uvS0c26K54rtWhTMKMGE/kvHy8zgFiQBBHX2xZuxtqSnhtaX6FfJBn37Ibus+LB0NW5eJcYrBj89T2gEaXG17NFdRQCZT4/gA+1XMbhH7D+9PBQHlf5wTGdo3Ot9N9+J9R6oJjyuI9ABQN9/EsuPUdHQ8VSGAhASP9IzT0Ojxe0KbCohYxQnktlnROHoGONn5JkxvqoqLEOuc3giMpThYtiKoidDuDTSCc22NcciHmTSmILY5IqfOuUfL3kcj+mjp6OAa9hAscJqhEFdS6X7rNOJ35R8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxWtAtBnrxOCJ4na2exSmiI1J692AGMY7qUpkjah1gg=;
 b=xSMaSq6nqw7SMdYBh6l3rRPOEU4NGB6qFQt1GkMlJLFoxuX1E7RecJplKKodTCQGhANWeCo9dUpmsogNHQpuOQwU5RtyeFjvwjp/9xqbKUiT/WNxfte9xO44I+yU/IRQBnlC3DWhwc7sbCSyLUx/G2TpJVaKY5t3Mhh7oYZ75PcgF9sqSTmN2RZLozB6wHVpr1fzxfUZVaJ7CHxcDrN9Yn2ZBqPomjOWrLIkROFOnck2wt2ozY08ncRm8oLdz6u1w4jo2iCcNi+fy506fZ4uaD80nD3w7MgFg2kWD2VjBX6X9xY0gcCJ9Daa2jD2ITnyD3aEagit0iq69e6SYiB+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxWtAtBnrxOCJ4na2exSmiI1J692AGMY7qUpkjah1gg=;
 b=oCTvP5DqcGDZ1yCu6gmT+QjwXDVvCCZ1hLOWWiwktcx0rzoTFsY5HLHamKOd253O22TPWDCZLQX8mrubCbwOwnjjYGLkoMRuCjHOeqIMSGz8jFSoOQs6iMCR5rlUEz2narRiDPgYU+mWY9wvQHYt9qv5Htl1SnCsnptH2Dlv+ZPWqUJI7XWfamoDfoSL8jAjUdXZUcIjgzPZ1DUst7LLyUl6pnvErc6Oz/FKG1RUQyOUuvnYvGs5d44MJFXA+Gk0IFkJmfQtjkM2nE5ThcqbZnGn0Z+27cOyuabafooy5oDL+jO0Tj4qWOjTFz4GmQwdu2guhzlzDDJbzGyXDc47jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:15:44 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:15:44 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 15 Sep 2026 11:14:57 +0900
Subject: [PATCH 02/11] iommu: Add cookie type for ARM_DMA_USE_IOMMU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-2-ba4f9d33a2b8@nvidia.com>
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
X-ClientProxiedBy: PUVP216CA0006.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16f::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: fd59af45-3a25-4101-3e15-08df12cf3f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: AriqQeAzS7aCR+D9f8kfm6GNFXFjawUHBKlUn3ZxXEmq5f0NHxKm3ARCgih8Q1x4tTyhwsbI1rf07uTFxr7fXx7HTVZ2FHP3uIGtGE8LYabIk1oLjFRssKvi79j0EaWIo9dUSBzGfjoN7Yn+NHjF1c4UP9bpggOep0cOakUoXxndc3EX45ygCw/O+C+uBDq37GNd9L7x6rbcno5x3c85nduVSK6cRt+RLJ5ERQpOEQLyFQwcfK0h5kzqaS4l4jXU+8ZeSr7PvvHOmJBathBEy40TkNrtg9vhQdzIQTmwhDTvoLudzefGZPl220Sdh2EPnCt2yjWcnKVcuakRDzdbNrHqcnjlJW36XfRNCsrIwWwynDdC3FlPHrvEXIuLjgUVl6l0uHZToCdMDR+NF6cZfzYOHkAaCaKYciSMMiFpHiE+RcE3qzL7wJW4aavAiz0vkhktVlr96J1JAdNEutP2gy3AS72Wk4EAdfLYiVJlHnDC0AIcROza6/abERczmQ0/4NnJDSRYgZW1M7YfUcTMkFkTySDEpQeN2IXhPEWtCD4OwXxDCxIG7murckwssiUFgyrnBqBnAsFH/8mTe9BcKNf40JJyUbVaZDlgTPSM7y9+IyvBgUs16ukEgCi1N6bT+L7ibBmrpRuuwb+kW/UrwhjuDWXOOzUwoia42b4mo/pd91O6/M5Gl/heAXEftJ2yicgQHOSgkEO4cSYun4cKtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dEdUVpTjREeXJkYUsyYzdWL3F5L0loM0lYUVVnUFZRazVORFhkMjlWV3Q1?=
 =?utf-8?B?YThUdWVNWlFuaTkraWUvREdUeVVmWnJZL0lIMFNGYldQdlNUYjRrN1BycHVM?=
 =?utf-8?B?NERaRHJRYm9oS2IwakdmcE5lb1lnUzV6cnc1VXJLaUsxZm15YVZlSWRmYWxv?=
 =?utf-8?B?d3FldlRyZm9FT05QVHhMR3NSTUhkUjhvbFBJQmJKeU9wRTFSTUlVSG9hZWtF?=
 =?utf-8?B?cG5RcnFwK1N4SDQ1YzJycnhXRzRVWDQ3YzBvMnFvY0hYN1lET1JRSzNIenhI?=
 =?utf-8?B?VmFKVFVuQ3F3Z2JGTmdVOXdTVUtMQ3JPbkF5bktiaUFPMVNMWm5TWVUvdU9K?=
 =?utf-8?B?cVNSa09rYll4Ym1lNDF1UDAzaHRwVVM1SXBHK3VHNXlVQTM2U0szbnM3WGcv?=
 =?utf-8?B?eHJJem14b1ppbWxtRlEyd2tWNHBva1hWN1ZzK3VNV09QZmRXbnNaaHl1bVdz?=
 =?utf-8?B?VEkraUg2c3BTMTdxL3ozeEtTa05jV3gyVnZYcTd1bEd2VVJEYlhvZ3JYMHR0?=
 =?utf-8?B?bG8zakxYdTdxanA0a2RNNmxKNjJ0a04vc1ZlR1E2WlRtV1hzdjYxWUp3Sisv?=
 =?utf-8?B?eVEzUlViTjUvUUZnZFE4WVFiV0ZYbTFLSHhURmE1YTl6cVVPNzFkRlJVZHQ3?=
 =?utf-8?B?RzREbGlxeXRvNGliSXl4Z29GNFd4bjBvaXVSdzJHOGN1L0FhNm5QTTJ3UzY2?=
 =?utf-8?B?dTBKV0tXUzVFSnhRejlkQzdQTVMxNHk4RUtuSVhkTG16L0s4NCtTc3VIQXli?=
 =?utf-8?B?eHRHK1djWlNlMTNuYjNoaHpKTTFNcEs3c3NmVDB3cnVVaW04bTNzNHRzVlhE?=
 =?utf-8?B?NTg4aVRtMmViZ1B5em1ySndEWHUzZjJpM0JkOWNyZ1dKVmNSRjZsSmZFSUgw?=
 =?utf-8?B?QnRhdFU0Q3dlQjh0UnZEcmZxamxRSVl1cUx4U0xuenNkODN2NXM1TzNMRTUr?=
 =?utf-8?B?MWlvN0pQSkZCcTZxZGN2TjVNZjNGeVFLcGhpR2RpUU10SncxYjZ5WHI0TlJk?=
 =?utf-8?B?TUYrTG1NaGcxbWhtUzkyTXFJZmVZU0RYK05LSUdzTHRsdm1CTzBBSmFRN0gv?=
 =?utf-8?B?WDFvSzIrdVhIZDYvVzVyemIzUW1UZ0dEeHdLbmxqNHhGQVc3emZnSmd4K1hD?=
 =?utf-8?B?SXE3VXREcUs0cU90dUJJaERvOHBLaFBFK0k0YTkrMG1ITlR6ak9tVFFjazht?=
 =?utf-8?B?NkpOM29zVHZYWWR4Z29EV1EyZWJWcHlSZXNrMmZpQU1GT1dhK3Z1b2pJTm9N?=
 =?utf-8?B?VzF2cmdjVXFQVXFFdytkeUNwcjRvU2RXa2I3eFpGM1E2Y2VYbGJzdXYxYnJ1?=
 =?utf-8?B?RE8rYktEemZ4NHFXQUJldWZlVE4vcHo3WEFUdVVGZGV4b01NTnRGM1ZIaUZL?=
 =?utf-8?B?ZTBLeVlNRzltM1ZOK1VDZ3pQMnhBWlRwL3RXKzlLTCtRTW9SanRCUWxjMnUr?=
 =?utf-8?B?c0Fja2Z5NkdTUjBaM3NEdXZjRldJdWtzR0txaXhxa3pCOUxnOXZ2R292WFVl?=
 =?utf-8?B?UlphR0x6K241Q0RwMGFqdTZOWWluT2FmUExOckdndm1zZElidUs0cTBMWi9Q?=
 =?utf-8?B?ZzFTNjF1NUYrSU0yOWw5Q1NMSHlyVFZQK3hOSldvQzU1NlZRanpoSVhJODFs?=
 =?utf-8?B?cXVyQXVJS1AwbERnRjdhcHFlWE5qdXhrZU1WTnJqUXRPVlFUMXNPWG13NVF5?=
 =?utf-8?B?eG5PZU5aL3dNTFYyUExmZGc5eC85TGZjdm9Vb0ZzY3NWN2Jyd3B2QmkrdGZh?=
 =?utf-8?B?Y2pMTU02Y09xN1Ezc1dKajF6U2lmblE2U0U0RVNRa25BR1NVUmxrSzlWNGRq?=
 =?utf-8?B?elF5MlRpTi9Kb3FERm4yYWp5NEpWSWoyVEZ3Ujg3WUNPTUI4UzF6ODNNd21Z?=
 =?utf-8?B?a3BneDl5dlNxUDRuak9kVVFIMEdKVGovMGdUTG80Y0w3MisyVXZ1N1YrcDVD?=
 =?utf-8?B?OXE5VzRZMFZ0NjZhS1pVYXdGdW95b2thbGZxOU9iNkRDMWVuZU53UmUvaWMy?=
 =?utf-8?B?OENTaXB3R3FWd05PdjQ3Uk5ZYml3N0N4VWJtQmJrYUlMYnBXWUppY3ovYlZs?=
 =?utf-8?B?ZmFacXB0VHRCTmZqcEU2dDZTTStiOTRydENXbU9MdnZxcldhVWFnSm5aeW9K?=
 =?utf-8?B?Q05MVXhQM1ZSRDNaeHdadlJFWElmLzh5S3I2QUZYNHRoWjMrYlRFU0lCRVp1?=
 =?utf-8?B?S25wd0Npb0pJQVlPbUxPcWdhc0M2NERNNStzakdTT2FDT1hVODRzWlprREFO?=
 =?utf-8?B?dTlkVXNjYWg4UWxmZ1JKeWJkNDliV1EwT2U1L0J2KzFXUi9GV1dFa2JGcng5?=
 =?utf-8?B?aWxwT3lUM1RaTmloNXQxUUhYMzJWT2VVbUlWdVRDRUZqUSt3K1JyOFN6OGgx?=
 =?utf-8?Q?XNnOO6hUce8qsH76C/kilfDxdJ5XtLgWAonXheiDbsCoh?=
X-MS-Exchange-AntiSpam-MessageData-1: Tk6RQyZdoW48HA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd59af45-3a25-4101-3e15-08df12cf3f47
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:15:44.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVe0f2Q8Zr17iWZ3St7dDedMhnVEZIrmy3gbLoyfQ0KXJUpvuKmYFtpbdR4rth55nyCf2oSNeHDxX4E9wSuk2A==
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

The ARM_DMA_USE_IOMMU DMA API implementation keeps its state in a struct
dma_iommu_mapping. Currently that struct owns an IOMMU domain -- to
allow inverting that relation, add a cookie type pointing to a struct
dma_iommu_mapping, more in line with how other architectures work.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/iommu.c | 1 +
 include/linux/iommu.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 75687d1aafe9..43dd69662fac 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2127,6 +2127,7 @@ void iommu_domain_free(struct iommu_domain *domain)
 {
 	switch (domain->cookie_type) {
 	case IOMMU_COOKIE_DMA_IOVA:
+	case IOMMU_COOKIE_ARM_DMA:
 		iommu_put_dma_cookie(domain);
 		break;
 	case IOMMU_COOKIE_DMA_MSI:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863a..e2f8513d2067 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -43,6 +43,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_dma_msi_cookie;
+struct dma_iommu_mapping;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
@@ -174,6 +175,7 @@ enum iommu_domain_cookie_type {
 	IOMMU_COOKIE_FAULT_HANDLER,
 	IOMMU_COOKIE_SVA,
 	IOMMU_COOKIE_IOMMUFD,
+	IOMMU_COOKIE_ARM_DMA,
 };
 
 /* Domain feature flags */
@@ -234,6 +236,7 @@ struct iommu_domain {
 	union { /* cookie */
 		struct iommu_dma_cookie *iova_cookie;
 		struct iommu_dma_msi_cookie *msi_cookie;
+		struct dma_iommu_mapping *arm_cookie;
 		struct iommufd_hw_pagetable *iommufd_hwpt;
 		struct {
 			iommu_fault_handler_t handler;

-- 
2.55.0

