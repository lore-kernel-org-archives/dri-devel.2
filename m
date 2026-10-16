Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B5BCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9960E1125D9;
	Fri, 16 Oct 2026 06:47:38 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6881125C6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixSkzfd8oRhxvzpGTbIQXDJeTKdNnWj8mgOUFNmFljkb8XamdgSgPnSwEiV+nodUH3Xv4/BRGWPA8aESuSay/sl9wzwxdyptD+MUNdv0vmfwSmG3Ih+YO7Fx0wqpzPmEuGHa+2KWnCKAFUjusjQiA0wew7Eues7lTXXVUHLPbXRgs2DHtEcfS5psMXAY5fEFOPbHF6YZ2BU2VIdPop79BeXgWNZ42mCgkJPNjr2sOxu5MDl59WezivEKyQKWlBBfkeYuTR67XVr9sBnQI70jGtt/3iuGkmJ36isgc9xxT8XTVc8OVJduq4G29uTBz0ghluGG/QGpmchKNod7SaVxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYZkTdG9IXl95Hy7AxJPsoPqlMhkb0s6M4U928GA/9I=;
 b=lKq9Y0NPGhCkJcqhQdtRfPJnNPas5lAgIcf71rt8uxDIxD6K6kDSqNapxvqp2hBmkk5v1u6A4SJrgCrk4P9MUPKkyXBtwSbwPN9OF1RaQXBjBQJpZBaMlTR+S3bA8ge0YRXH80Vo3MO47Jl8SB1pVaTJZQfhRdqcKduswEX8t+qLa64+tUUgrDbduW79xWexLhn0utg3HE+IePj9fIPQKg5AeqsFexBneYJmfQzuqsMQmZbS9tjc+FQHr8KR8JITHQsGGxWVdmYz+ZnP4GvZ99xyzapINvmLmUwqJ6FH1R0RsM97mV1UXG/SR1ZC5aA43Z55p3V6hHj5cJhMJUVqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYZkTdG9IXl95Hy7AxJPsoPqlMhkb0s6M4U928GA/9I=;
 b=dpa8n/TSOBL6L/86PutThMgKag7MQeoPSUJUN8bRSN8Cjp+FOM0jO8+brbi/fsea90GIHMUsAxs6Hzb97zRskURm+J3XrFT/QXdwMDDpfB7dxYYzm6TK2XhwMYhqXUMW9UoajkvSmMX4cwiiijZJq6RIRskt5NjnA030yLa+HVYgacqyPJQ94bYMHUa83JK6t19aMnuTjtXMMiIH3kdn9wUM69fLeTwqszP6Pz7vLVhgmukL0cWqB7hUygcIasHOo9pyUjdBE8bnzugo3Ooejcm8wWsTkPPCnwWf9npFLQ54VQOWQucKfe0KkKI7oTeJO4z/FXpHYlY4y+GdGQ/fYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:22 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:22 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 16 Oct 2026 15:46:47 +0900
Subject: [PATCH v2 01/11] iommu: Add iommu_teardown_dma_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-1-b06842a01938@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f0cbf6-4aaf-4efb-1bac-08df2b5154d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|22082099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: gkTTCvzByfaMb0TL8pMD62szCqXLKmJWsH2stHDHx9s5KNL6Fht8hNKE20YANBIdOWAk1hzv3YF1GqRDydurQZG1sIcxBpTjSimFJQuW61DBI19VqJisQYi2kzTbIrxC7h3qK50i/IVWCDBStLzZKQoQL6eBCf/gjMitsb1Gt8RAygexkBiggWTXcLHHxS2iu/RtC+dw+OzEJEk1t6fx3dA6AMAswEG77iG+3cM0xVTzJ/jC1//R9AkOfalFWrgZbx21ODcb8Zv8lANAAFrnhOQ8dns9MGMkjt3aGJh/7MtOMnPyOngJ38hUMwDjSQWDr1wlUBFpnYSCTTQfh5NdC+VTEvSHR72pkwwtAPf05pNA3Gk/N14mXlI3fz8YlyyX8BKsHMloF5dacivcL4babdD3+T1BOWeAMyTln4GDyp3AEK/7fne0SIZorc9cwmHfwI3GJIWx91rTzo9bm/Re04d+7vWm/YRlmKZw2GmZFjYq6h28Jc4cf+oSrx9XzG/7DD4Gs/EXnTQaqtTyMTe5822m7dnePIPMH3YjcM1mh01vRdUDzdeXfeXVX7NfAh+Oq5+fzSe+0y8zyzGYYvt7qfifZzMAsa8FUicLCH4S8dTZ1PHz5KupRYL6LwwtBckd5fSk9mSGWM+KqLDPAinpxihVsFOP0GXJsveA9cDWQoL5VTq2RTygje/SlAAzMTrXj1GXz51PWolwFmkD5a63qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmlIN2swaHFiUG01TlhXQmVUSDBTeDRWNmhPd1pEem9aWWJTTkgxMzdpOGZW?=
 =?utf-8?B?NytXVWdPV3Jzd0FBTjBvNloyMlJzWUppcUJCUGRhT2RXdnd4enhxWVppcy9K?=
 =?utf-8?B?cm5nM1BmMm5VSm5rcnE3dml6dHVIREs3Q3ZqcUI4KzNpTTJDdEYxNkdhZGpo?=
 =?utf-8?B?T0lONEk1Yy9tTGlreVZ2VkxaS1lOYXk0amxSQ3Fqc0hoQlF0a0JMZXdFVDRJ?=
 =?utf-8?B?OC9ab1VEWFBjTW5rOHJnYkJzN0owWDM5a3NDVC8zRnpMaExhMmluWkxiRXA1?=
 =?utf-8?B?Y205N1FoZVR1Rlo5SWc5UDFodWtXZlNUSmN0T1hRcGx6SkN5eVlwRFBBdVlR?=
 =?utf-8?B?d3luNnNIV1hwUms0dERqbG8xbHp2KzVsSjBNcFcwQzVQYWV6MHZDSXhGU1Ny?=
 =?utf-8?B?eUZlUHFqNHhzc21CcGNhR2RNR1VvUXNEOFVkejdmeCtVbStZVTRDMk5lOW5o?=
 =?utf-8?B?d0xOWVdYVnN2cUlyWU1CejBZbTdVbllnWEI3Z2tNWVpYK0pIbFB4cVIvNWo5?=
 =?utf-8?B?bjFpZ3ZPYXgrRTF3MUs3cnRpRUxUM2E0bitsVDJjOXp5YXJHbkliZUJvek1B?=
 =?utf-8?B?ZTdYVXlxYjVpNy94UEhEQy9EQmk0RTFxWkZVZ2ZoNnNKQm1lbDkzKzVSRks0?=
 =?utf-8?B?bWg2a1h1VWdhb0phL0FIdXoxdHQ2ZXdOWjFyR0dnTlV5eW93QmorbjVhSU1U?=
 =?utf-8?B?VFdRZE1BMjB2Q3J0a2lSVDBjaXNkY05qOFJCS0xNZXQ5WmVCVVNsY1Q4eWJY?=
 =?utf-8?B?RG1tUEtLaENlMngvb08rcTAwS3dyRnpXNDBuRFlwTU54Q2VjblF5MU5ueHVn?=
 =?utf-8?B?VWE3bUE4WkZCdTU2ZnViV1RYWWdDVGllbEcxN05LZGU0QjVOTHpoSVFqand4?=
 =?utf-8?B?M3luNUlVekt2bXhHL1dkT3VKenNNT1lGK3VNck5paUM1Mjh2ODRxbk5iODVQ?=
 =?utf-8?B?Ykh3OGlNN2Z1NlQ3eVBWOTlRdVplclZpcFJtYXpiaWVSOEpocDllRG1CcS9H?=
 =?utf-8?B?b0xVaERNdlVNVnIxL2lBMDUwb0ovSmx2VlkrUEViWjhkc0ZOTDdMYVEwOXBp?=
 =?utf-8?B?RTJzUmd1VmNDRlJFNG4vRk9iQVdpbW9pZ1dJUVIzNEtRUExLUXN6ZE1HSWpT?=
 =?utf-8?B?c2N0ZUJZVGFsL2lZSWpSSkJzdUx0eCtpM0xVNXMyc1ZTQVBuMlF0OWxucm82?=
 =?utf-8?B?a3VCUzQrbE9wdE9UZzVaays4Um03eVlWZ2xISzRxdHBzMG9uWndnNUsxaVVW?=
 =?utf-8?B?UHo1eHNITkhQekJac0MwYWhZQ0txVkZCaklORFhBYzVuMjV4STd0YWtEa3pn?=
 =?utf-8?B?QmxLRGZuZmlQemNKTEh4aDRTU010aDB6Y2MvL1c1MXNCQ1dZZ0g1OTV4aDRu?=
 =?utf-8?B?cGpwTVJjWGdVcG1JNjBBV2RXaVppeU5kWHVxeTFLWGhRM00xb0lTVFFXUE84?=
 =?utf-8?B?ckxzb0RCYUVhN2Z1bzNDeGNsVlJ4T1lFR2VDQjY1U2E5b2xkWXVuZzlVbVA3?=
 =?utf-8?B?MUJSNW5McVJteEVZWXFaeFlNU2c0MUxiSmRUdksrY2pUeEZZdDlQVHRWb1Jt?=
 =?utf-8?B?ajEyN2hhbnA3WFNzYXNPdlpIK1Q2VHNhcVQ3MEhFV0lMUjgvaTlMTUVXUDlN?=
 =?utf-8?B?NGpZbnlrZ3RBV0dnMTdCN1lCMHl6YzgvOGM4UWdVTVk1M0x0MTE2L1FVUFd6?=
 =?utf-8?B?QW5FZUdaajc5VnV4S1piVnZGTGpQMmhEU2ZucThlMTF2STB5U0dsNWMxRmRJ?=
 =?utf-8?B?WHFXSnRyNkxvUEE1bTFNUVZZdWhOT1ZwSUpoWjNoR1lKL0FmV1ljcXZEcDdm?=
 =?utf-8?B?QXlGa0lWUGZSclF0ZFBBb0VxK0RYbWo1ak5yVUpFKzdjQ292aHdabm5kRlU0?=
 =?utf-8?B?cThhTW1kUXIwWHprWHZZc2lpeDFDVWxzeGVYQ1lsMFltK2UzRy9tVCtjYWtw?=
 =?utf-8?B?S1pINTRxS2xWbUc0QTJqb0ZrbndudlNpckRWRUxGOGFkeGtXcEFOdUVDTVpa?=
 =?utf-8?B?VmU1RmFkdkIvUUVKUWgveTdzaUtCTlArcGtUb0llNjFDa2w1SmVFQzlVS2FP?=
 =?utf-8?B?TGRIUlFzTjlYNTVCS3o3bkNrRndrV1dUWTZkZjN5aTJSaVBjQ3hqSkdzbWdq?=
 =?utf-8?B?UTRiT21EbXE0ZWg1ZlZROTh1UkhpS3E2OU4xUGxvU2I4UGhCZTdwN0poeVdJ?=
 =?utf-8?B?aHFpSTdkckgyMUJxMll1WlpnbzhOVXlHYnB1WUJYeU1NQzM3TlhkU1F6dkRS?=
 =?utf-8?B?UXU4T3F3K2lmVXhPemliR044dkdOM1NHZWZ6UDg5V2Q3Zm5YQzdBdlVoTzVM?=
 =?utf-8?B?VTNCckdhWEJnaHV2KzQ1eU92MVBDNnZDYTJMbUVLOFRONHBUOW5sdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f0cbf6-4aaf-4efb-1bac-08df2b5154d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:22.6463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+u+HEU8s1YuwpzV2yMtzVhx5HFZanR5OIQuL4I+yDCWzX1tvXIkRYH/f8Lk2DRqEuvmrIbzGxhxpEVgcSQB6w==
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

Add a counterpart to iommu_setup_dma_ops, tearing down state set by it.

Currently this teardown is open-coded in iommu_deinit_device; however
when 32-bit ARM gains a parallel implementation of iommu_setup_dma_ops
it becomes nicer to have a matching parallel iommu_teardown_dma_ops as
well.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 5 +++++
 drivers/iommu/dma-iommu.h | 5 +++++
 drivers/iommu/iommu.c     | 3 +--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 68ee57800fef..379019748a5d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2161,6 +2161,11 @@ void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
 	dev_clear_dma_iommu(dev);
 }
 
+void iommu_teardown_dma_ops(struct device *dev)
+{
+	dev_clear_dma_iommu(dev);
+}
+
 static bool has_msi_cookie(const struct iommu_domain *domain)
 {
 	return domain && (domain->cookie_type == IOMMU_COOKIE_DMA_IOVA ||
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d00252563..349d6a57e5a0 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -10,6 +10,7 @@
 #ifdef CONFIG_IOMMU_DMA
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
+void iommu_teardown_dma_ops(struct device *dev);
 
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
@@ -31,6 +32,10 @@ static inline void iommu_setup_dma_ops(struct device *dev,
 {
 }
 
+static inline void iommu_teardown_dma_ops(struct device *dev)
+{
+}
+
 static inline int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	return -EINVAL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..a5440ed5e235 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -611,8 +611,7 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
-	if (IS_ENABLED(CONFIG_IOMMU_DMA))
-		dev_clear_dma_iommu(dev);
+	iommu_teardown_dma_ops(dev);
 }
 
 static struct iommu_domain *pasid_array_entry_to_domain(void *entry)

-- 
2.55.0

