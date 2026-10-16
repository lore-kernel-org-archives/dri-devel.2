Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BD7CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84651125D8;
	Fri, 16 Oct 2026 06:47:43 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD05C1125C6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iswCzqGj4/XvS86OIGWv0gHOd6rgU6vusBaMCRk+ZBSO/RORvgqzr5PRIHYWpxll5ZquUtt+DCnglHeVXSo4Q9EFQkMHtm0kQQjUhYvBHpP5OH4nAs4HDyp5Zopz+7dZ5Wr9iP6aI9ssc/S2aFS8q8zLz36Wh3wOf/nxw0s0aUyUhvcpNMn6yJmSbG8zCmhfmPs9dBoUNnXMyu4H9yD+rD+0BrepEgNjwG2aI+sUCV9YbiRfkZ/Kp64W8in9r6A/diU3I+snhxMFDCT88LHI6Uobdarao++fRCmgygJUvxoHX4QDXPoePfW4kHscOqnN0+XlhkxjC+34RB7CTi8NEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAMF3VxY4NOehnn8O1eVN0nuNJ2O/LC/+LCZsDpMM5w=;
 b=vUeDiuwFbiwe4sybI8QjCbnXrfCczlHyvIEDdiKLzPIuefdQu5Ul96FhzujhrQsDGYVGkOY6k90i3EVDEXnNQvnNkZXwEgOK0ADfKmfKuVGIINRl6vTQydwVocE9FzB2NsA2qJnhKFOF2YrFs+xIXXhoKUW1VWBnaF36FMKO6d2ul/XvHgvVTKtDlG5g60iqXMqjv8+Fl4A3wJJdzQY1ALKzCYP6ut2f8g/XcDVIoUvfNHzFI7qmOIUF0ybI2Y4Gb5RfmGs2QVMBguZdVC3UftcnV2U2fJClH+RpiYij0BGTDFQtmyvR81APggEg46dCgRoh2jBsHwtiXpeDxXSh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAMF3VxY4NOehnn8O1eVN0nuNJ2O/LC/+LCZsDpMM5w=;
 b=aSdB1mvpfdKq4mLAhV6+1dbDmkrsJsjtnt0/n0h3kFHIXjSR5c7VuSzRBdpR4hR5Tlq0oy134pfVHnwoufwqK7//OEQEejNOZ5dTSSPKoKkMvWp/iMKwOliHBq4XRhFr1QbZSvr0cuUvEdOABAxgNFMthD/IPkuhz+S42eG2/uwlLcXs88PSbtwklTy6+L/2/AuBhOS5WPjvs0g5O1+KrYH3Ov7L/Gn+U3PZC3rjWtTcZIF2WuioYlzcZ3vt760oD2b+h4k4BvtHEI4oLmbMyEgpJRisx8iPgeSmGPyF42AVrfqkpxIx90FiZvsatkWVhvLQ9MyPlgx59h3STPPkkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:28 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:28 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:48 +0900
Subject: [PATCH v2 02/11] iommu: Add cookie type for ARM_DMA_USE_IOMMU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-2-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 63762cbd-478d-43f3-ec79-08df2b515843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: t8kYoL6HHp5jOFDhFE3vYSof18Yoi/tWtBaeyvHWLTjoS3K6YzVBi5STu40sxmgbrCO6uwpULxa0ysqNNva28oadWOzYJH1nUQQUQVi/iXFrw2/+4uqIlRuyo7ajupvOotUnwc3uXkFU09d818Y8nIbLlPjvduMMxfbrtsz/P77yO2AGVmWWsqyETFZA0/Fzs6JmzDQMvZoEXaukxtEPlfougDwDf+QZAyq7HWogh49gAV2JGyU5jUjVRp8PCx87PYO9ZHo0xTXFaGk89bVnBgkuKHAOtNZriK6RKBySLwzjKurPfxzmu3qES5YYe/NisPzt6sco4A/ediXQ3Izh3BDvC8Hd/brh2aLj4Z0/enebSsFQCRb1+0TalHgYBNPQwk67ho0cXDMHkfTO7PMJHyqd6wlQjk2Ud5srvgfaxM+bORhMo8kDAMr7TttKeRfCZirRyrZf/X0kDUsOD6cgAKNhAjqNU4edeC6do3bP/jLBtlzVbxezVWlT1fSusCTpexlxeQRE22IcbcTKyJ3cE/VXrWYm+uawWW6CWI758NEK6+Tlenohl3vE1q/pBvhAXUONbw8DrxbxaxP8cj9HQys+qrOxP31pdImbrmdE7JEuIpGm3ctroIzcGg8tugUI+XzRAWuxJg/b5K5n0B3T27MVygdPfUfGMGvumS0kyVo5uY+XkIEJW4SG66NzFnAkh9VpPhD/yRiWm3Wl7GWOJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFdBQzg5NUthWjRqK1JBajloWkxuTy83UVFzVjhhWlZrd3ZOUnIrSUQ0Zk4z?=
 =?utf-8?B?bVpXeDlZRG5XOUc2UjNHS3NIUzJMUEVHZk9CYW1MTkk5bENvelpZemtpeFNF?=
 =?utf-8?B?Mm1FUkxtbURnQ3Nkc082OGpYRVpJOTVyaU5zVitwdkp2dmphTUVyLzdRV2hw?=
 =?utf-8?B?cFBQc2oxVXdYRWYvd1lQQ3FOTEpndEg4Mjg0QXFUWTl3Qk9mc294T1cwR0lH?=
 =?utf-8?B?Z3I3SEg0ZUhaNjlTc0doQXJ5OExyK3JaeW9QdlRkQ0ZRcDNxZW9VeS9XRU5K?=
 =?utf-8?B?MEdSZjBONDI5aDgxSE8rYTlWN3lpWEZXd3BJTkhkOWt6OG1kdmRaMCtKV3hq?=
 =?utf-8?B?V01JSGdHWDRtT0tCK25qbnJ6eFVReU4yaWovU3d4YVVHcDBpeExyYjhaclVa?=
 =?utf-8?B?TVFUdWE4NzJEWW5ubGF3VkI4ck9sMDVjeUdWZjUvTmRFVFE4R1k0N1ROZEV5?=
 =?utf-8?B?eXJLendwOFJROUpyT045KzhVdmRNQ0syVGF0T0VDZlk5eDVBRVdhTGlmdjA0?=
 =?utf-8?B?UEtHc29veWhBOXc0SkprTndlOVlQZjhkbTJrZDZpMi9pdGJlcmJSWjQzaWhF?=
 =?utf-8?B?dk83ZXc5bjdJWGY0OWh0QkRzLy9iWFYvSkFac0FOb3hxMWlhallpN2dNbnNQ?=
 =?utf-8?B?cmNtNDJEL1Nray9jckpJRHNzTmRGeVZwUFptZjRrSG1uencyUlBhUzcweSts?=
 =?utf-8?B?RWRxVHVkSXp5aVEydDZBSUJBWDRFVExiaU5qYnM1b2VudjEvT3k0QU05ZkJ2?=
 =?utf-8?B?U3I4bU5yQUVwOGE3QnpQTnI0eW95d1BjL2RqY0JlcjhJeE1XWnBob3Mzb3VR?=
 =?utf-8?B?UVNlTWdSYTJmT1JFMmtxRDZLYnpHdHVYZEVEcDUzSVhONkZ3b0k3WGRibEV6?=
 =?utf-8?B?am0vb0RwZmlwcktmT1BQV1hPRVQ2Wm1tcHdVMVRROFh1V09NN3Q1ZlByakps?=
 =?utf-8?B?NktBWHlGVnAvSGJUd3lmVTI0TENKcjRWV0ZOenF4WkxTcjBLSy9oeGN3MExD?=
 =?utf-8?B?M0ZSMzZSSGN3d096NU11RWpkRE5BdUJSdVhSOXRqNEhSempueDgyRWNKOVha?=
 =?utf-8?B?c0pUZG1CNDFyOFNQVnBoeG8zNDZLZTlYYzNSUXViSUNudytDUG5uRW9CS1ky?=
 =?utf-8?B?cmRrSjlxZXV4WDRuYzdFZVRzcWh3dVFUZTdEZ1QvZWh2UFhhcjRLWHdSaWpp?=
 =?utf-8?B?QjNwN3JGdythRnU0ckh2eDZKL2d0M2NXMFY4TW9jSHN3Qlp3cWJCTmxXTEFr?=
 =?utf-8?B?ekdscjFtbmxSbC8rM1BEbTQwKzhiUDR6RG5TMERzT2pzZ0EyRVR2NmZpUzFU?=
 =?utf-8?B?NjJkNHdBRkR3ZCtFMCtJOWVXZXJ3aldUREwxenBVWEdlTDRLeThzZ0pTc2Y1?=
 =?utf-8?B?NURvYTlFWk8xZmdLRjN1R0tEUVpDZkZ1S2haTjdva3Y2WTJ4NGxSQ2hyY3R0?=
 =?utf-8?B?SXpHL3o3dEN6VXNXM0x4U0tJeVVQQ2pYVTVSYmhxZi9ad3BXeFhvdFg4dGMy?=
 =?utf-8?B?dkxoMlByVmdyRzlTVXdtTmtoM29wK3Z0ZVkrMGNsb3laZlNmTzdza2NVRTEy?=
 =?utf-8?B?RXducEw0ejZveDJMOGM1cjZXOG83enJxbUZRbGVwdlVNYWFRVldoRlp3TFJn?=
 =?utf-8?B?dHRVcHJxTXFUeEhuYlBjOXRHM2Q5T3Y1Tk81RFp0Z0p2RXlNTzFGQmpzMDRL?=
 =?utf-8?B?ZEd2SDd1YW5acFA5YTlROTY3U1BxZU9QWWt5cm5ZUTRJTU9KK0huZGplckhD?=
 =?utf-8?B?TU1BN2p4THdNRkIxWnNiKzNhK0lHVWZBb2o1K0p1K1hxVEYyeElUeVE1VzhE?=
 =?utf-8?B?TnhPdUVQM2d2V1ZvWXhNV0pnZVRWSXovZE9ieFRmejUyS0ZjVUR5TS9zbXRR?=
 =?utf-8?B?bE9qZXlzQ0YyTTR5YmFpQkROQ3hLNk9laHZsVEJVZitXa1BiZ0RXbWc2NE85?=
 =?utf-8?B?ajh2WFNDK3dON2tQOXB0U0JKREJpSXptNXNsLzlsckFpNDM0U3dQc2hWRjdJ?=
 =?utf-8?B?SzdSV201Ky9heGsxWmZiY1l1U1hnOURYczhraUl4djJOMnNJNWdhMzhNdC9a?=
 =?utf-8?B?MVliVHhRdkw0RXZxWXB5Qk9Bemh4QVk0a3VJK3JMSzgzeUhRSGtsSVVwWUIx?=
 =?utf-8?B?MFdjYXRLRlgxTlEvQi94MVNRM1lpYXBVbUNLTGVUYmdUNTd1RjZUOFRZcE5U?=
 =?utf-8?B?R3NOamZTc0xmV2ZwcHFlc3FqdTRmT04rOGc3MUJ3YzZVanNYUzBqL0w1QTBv?=
 =?utf-8?B?NmVTeW85d1Y5dnNEbUFWMlZhQVV3YWE2RUE1bk9OdC9OMEpaT0luUDVvR0pu?=
 =?utf-8?B?cG45cmZ2NEJXTmIzYlgrb1M0MDZTR25UZ0dKc2RuV1lLcUFoblc4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63762cbd-478d-43f3-ec79-08df2b515843
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:28.3996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxJO+0vldMm5Mej1wl/w42FxIVyQhCxToU5K2pdEPgYHJVmyGUdXzregPvUpdDqMULe5NxB2umlngHBhsVivQw==
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
index a5440ed5e235..5fbb76d44a1e 100644
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
index ac43b8b93f14..4b87625892ac 100644
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

