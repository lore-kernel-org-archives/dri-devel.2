Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7397606A328
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uZLYR2NT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395C110ED05;
	Mon, 26 Oct 2026 09:21:14 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953C210ED05
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5So2x7A9qXmdEBexZaOrbdxbwvCb6i7nwWmPG4FuCij0zBZD/Jtv336UUwmZLdSZ1ou2gavLdxZSkVegMNYId+s5BKs3n27mGJ2aZVtzk6PUJYwQ8Ue/Xudis6Uf+XrhqrAsCGMRi3LXdM1sXE9xdoSJronfvr5ShbsUzdLARP13XxELyanptPBC67GJMC2tvBH6MoFfvUxYlMgiadZswNdFvrpmyTnCJ8VfCxH1u81bkCdrGqYHY0JiaMSmr70b/Vn1yNVnkI5R+Z2gk/9p/d9pVK9RvB865Z4fVxJ6IP3703IQggaw4+by1jLRDyIM3bBG5fKtAZb6x4l1kmzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYZkTdG9IXl95Hy7AxJPsoPqlMhkb0s6M4U928GA/9I=;
 b=ZFFXlRBk6H270e7IGii8u4hwEc/fR2teRX4NmzmmzIgnSEYJbbcqHfLK629WlHxMATLPTfQ5UFYh9hJa2d21kcKhJVKA02kUHmLOrOYAc3iXdTWmWB4UXEgUoNguDdNc7iBI05zaELv1PI6RWaIRyB+M/BA8mUPHxLwo1StQBQTFYsAmKg7XqsAV7EJtdThjmdUoRdGnWWRcpbNhZun+qQC/G6LMfq8pmWGZvPWp6kqHSrKFsf7dAN2oxP5qLKX8o4n/VvGTdrrfxMDa3oW7CCm8NiM19Se8BdQLgVWw1SLXrFZ5wV+XSXp1mTphf2zTgJxyfCu7adz9xEAJKal0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYZkTdG9IXl95Hy7AxJPsoPqlMhkb0s6M4U928GA/9I=;
 b=uZLYR2NT+4U0i468OQ3lbdRahz0y95Wdx1DFEJxAhK8bnPoBNvhCoSA8HKuyagi6wUjLGUvdNmJ6D7lAvzn3jtI7DnrQ+UzFLfL3YQZIXdcKaFGU6CnIqlw5HfeMV7jceqrCy4zFLkp6sNCdG274wpsq76Q5peWJgoLGY3lIdzAW9nWqqFT+JfVAZ6D9Xe/tLRPg4S4AmGXuM5tIlcvfCV28CxGOi0iqzQLmJCqiBs0hVc79AR5eWDXr2o0pNZpyEEVKXXPIPfqYfdihmSCbJlg2GaoF3sWmwSJyvTybAknY2wIOfXcML3ASI3dZ3XhX/VpI6fCLyzZbpWHyI/b3Pw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:20:40 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:20:40 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:26 +0900
Subject: [PATCH v3 01/10] iommu: Add iommu_teardown_dma_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-1-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: b6de49dd-8e47-47a6-c630-08df334266ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10070799003|7416014|18002099003|22082099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261022075727099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: dWV28GSb/UYaH4pETpdNdP3Z0cS+zI25sQjkseqLMicRwkuYPiZZXa+SPmZ1rW1aBr2Khyc2VjZyqKPytITpqQECul0PvOL3JGurmY1aDA95nlW9EXmvYECzCh0pzhZSOp8VQkinNSB76V06xVVoBuwzplJUEJVa1qup1/vsa7Z05oUvUmIXBt2TE99bL8+j99cXN4PuDLkjsQBQQ39uydYqrenVmzMZI0qXlzF4u928B9a/H9ttDVQI7hU6fNYTr1oUA19SS929QGoqPgSukkzvwOga6g8KMd7n1wzBHYuJoSzaoxclOMW7Da+PScouQdNXUxbS8ubhCkL0TA7Zgndgvz6bS4z8P/+ALKS74ZzeCG69qG2piPdLIEcATe63dkt/R2ps3Do0tYKEXv6bIcaS+DbLNZDCeXGH1yaOoUAFpjTrfUCuesec4j/rPv2X4HR6+XU8wjAIvOV7lGObp8a4R2LkCWxbdy199/mzLdhCCkWGOGmRLQH/qMYudd9oyfxmEMpjfDko4PTHX5Q7JcFMx9DXmzNCOw9gDDlAxPrhSKiQrodd6Hv0X+4L7HxUsbdNQn0xl/Jrj0Y9uiDT72JzhfwECaXFCQtjOzbcbdvfofKyIsKskDPr/nxgS5yYdQ33F4gzT/mwkWBMuVoCDsg22B2gAmbYTrmt7PRcLqiPGvL4WIiLqenLW4TMtnK5aIrm5weZEhsIP6t17e7D9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10070799003)(7416014)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261022075727099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHFEMmRNZFJTTHg1aHoxc0IzSktZTk5sT205a3lsV1pmMEtRdUZtTW1qVy9B?=
 =?utf-8?B?YkdSenRrSm1uZ1R6b1hlZG9kNHNDTHhDNjdXQmRFNjdhTXBsU1AyanIyS0Y3?=
 =?utf-8?B?SERTNDR5eUN3WHhHNkVQZUhPWmlUL1c5RC9JSnZ0N0xtTHFRYWgvOUFsVFcw?=
 =?utf-8?B?UXNPMS9FQXRhMHR1TjBvb1BYekFkYm1XYno4NFl2cGN6OWpFVzVXTFIwaDBZ?=
 =?utf-8?B?bTM1eDNabG5YNFNOcU51Unc0MlJrb3c4WG5uRUtMc3VHZncxYnNoWW4xK3Zn?=
 =?utf-8?B?dzJxMCtDTG1rY1N5dFV6OENNajQzS1lNNUc3UlhmTGd5YkxVVTRVeTNQV1Jw?=
 =?utf-8?B?Z1RLcXgyVjlpUGxhbnJaVDlCOGwyRkY2UkhlK2NFbFN6dmFpYWtEY3UwR0ov?=
 =?utf-8?B?bVdFajJpUzF0KzZ6ekJuc3E4bml1K3JPaU9nZ0o2b1RBSnA5bnR1ODdQdTll?=
 =?utf-8?B?VGFKa2ttY0tkZFA4b1dpLy9aQ0JCR3c4M1JFUjlmOXJIbU51Um9ZbllYZ1c5?=
 =?utf-8?B?ZXZrdHFZUnA2R01PT1FGS2pmSmZqL1dtNnBmem5MY1E1b3FTTWpFa212UTMy?=
 =?utf-8?B?QVZhbjFHMWNhZHZSZUp5SUcyVUN0QjlpMklyc1RDb000SnpJZlltUnNDdWpH?=
 =?utf-8?B?cGFzeUdld09nYW04N3M3U3lJK2NtbC9pM09KZWZQOE9PMHppclE1UHMvV0xa?=
 =?utf-8?B?VS9vZzZMby91Q3d2Z1doZW9JWXJnVWluWlFSeksyWVhIWHRFYTJWQkw1SGZB?=
 =?utf-8?B?Uzc4NTFDeGN1b0dNUFUyODR0RW9MdHc5dzZlc09tZlk2ZlFjZHM1anBwVDVF?=
 =?utf-8?B?aWtUZ0d4bjBnZkFDOVRLLy9ieHYwa3BNb3VxYkY5NCt3WVE2Y2EwVjhyNVkw?=
 =?utf-8?B?UEQzeER0c3h1dXVHbDhmNlNKclhkUm1vYzhINDZPdlNlckw1bVBhb2dUWVZQ?=
 =?utf-8?B?T0hOS0JxRHhLd214SGtTdFVMcDJ2VE9zZFo5eEtER0lFOS93ZThOTjVLK2xY?=
 =?utf-8?B?ekZONUNvWFJoMElOYVV6WHorbmxMY2lDUlNua2JReFBkbGVZWVJmSS82c3Rx?=
 =?utf-8?B?Q0gwMng4c3IrRmNQK0xqdS94Y2M5VmFmcEF3RHFrVzVldTJuQU1OMldoTHZB?=
 =?utf-8?B?TGp6azZ5NVRyMGdjeUdRbjhZTnZhZmZWTHMxKzc1ZGdmT21VWmx4MDZFbVhK?=
 =?utf-8?B?TnhZOENRUnJEbnNVeE44Y2tXaERCME9PS0RtZGF5bmNwRkptVEo4eG9wNWlY?=
 =?utf-8?B?aEdJQWQzdkZ4UlpqL0tXTkpJcmUyejA3T0tBSUpqNXlscXRraHdQQ0Yzc3Jp?=
 =?utf-8?B?Mkg3MllHUTF3cHl1N2VBcDUrM3hhRkpXY3RiaTNZaTF6ZUNpQmc2d09rUTRx?=
 =?utf-8?B?TjNEMGpPMzZuOGNYQVdQZEFrQldTQnN2bXhRem8vTnRQRmRlK0VPTTFUVmlj?=
 =?utf-8?B?N3E1clBrQUk5WTdjOG5WMmNhOW5ZbUJiWTF1MDhwcnpoek0rZHZLMzVNNzRC?=
 =?utf-8?B?VCtaS3cwYjhTN0lHWDI0bnZEVjhkbUdUdXJDa3VFbStncHhod1lSTjVraVlY?=
 =?utf-8?B?UGphMlFlQWhycDBobzBMdVl6clZNRkJtdEUrYzVDQWpPbmpqTWliQWtsYlMx?=
 =?utf-8?B?OHJEelJYQWFZWU5ETmRETE1uZmY4cG9aY3JHTHk5Vk0rcWFBQXkzcTU0NmFN?=
 =?utf-8?B?VXQ1QlZXVWxBRWwvZVdFR1FLRDU4NGlHeGVlMzRrOG5EaFlmdlhka3lyV3lS?=
 =?utf-8?B?UWJQM3lDdEhrM2RSUTcvVjJaK0UxeVZwSDNTdU5SVlN4WXRhZ3JNanpjbnJJ?=
 =?utf-8?B?WkJ0TzhIMXVJTllyZDErbmp0MlFpZnRJUk1LQ0J0emhnb0NKN1pVbzgxUDVX?=
 =?utf-8?B?SXoxOG84L1lDMm1YOHdiQTlRZnJGZzR2Z0lNWm43eXYvbitJZmlpZXdCUmMy?=
 =?utf-8?B?SE40NlVKY0Q1NngrUmk4MzljWDFLNkxUQlRDQXNxajBVNnorMDJ1UE9xQm80?=
 =?utf-8?B?UDduVi9DOVVpNjAwU3Rmbm9FcURJMlh4dll3KzVLa1NmNHNDc2VLVW94SlFE?=
 =?utf-8?B?SnRKSjhZZ1ZwenFlVVlTeEE3L2pQZnBzejFXTncxeUtONjh4RUllcmdzOGg0?=
 =?utf-8?B?WFhvRkZsSFJiTzIxTEJmUU82Mnk4T1grMlVOYWJDN21McGkyT01ocmtlMEJR?=
 =?utf-8?B?WmVHR2RYamQ5eDdiS3RuVjByS3ZJU3YzTnZEdmhva1F3Ykx2SEo2endHWS9B?=
 =?utf-8?B?MlBHY3U0azBLb2lQQTVQSzF0eW15WlRaOWtYdXJDeFBZNUx6Rmo4ZStSejlQ?=
 =?utf-8?B?SlNSTm1BQjBhVDNDc2k5OW02bWtmTTRQZ3UvVUZ4aW5pLzQ1bk84STRRVEhH?=
 =?utf-8?Q?gtkBuOtCAgkmb0UMx3b5gPGfatKmHHpeinpHne8iq6MXI?=
X-MS-Exchange-AntiSpam-MessageData-1: UiB4w9Mx5BMAig==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6de49dd-8e47-47a6-c630-08df334266ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:20:40.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79Rproy/1zsrYK4RhRET1kcIVa+DAhvx2e4ntSx/uMES0ICx+ORR1KIBz+36wx8M6PG3u9xJ37F+kUxcNCApQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754
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

