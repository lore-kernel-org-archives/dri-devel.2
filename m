Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE772606A328
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EY9fb3mw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F73110ED00;
	Mon, 26 Oct 2026 09:20:56 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAF510ECF1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLV6kkx0BEpkZgNaWVMU13pNxIJkr2Xyt2j4cOBVZd5HQDx2xuJQzpJYQElx0lTa4Q+cyH7S6I11W6QUauWaQnid9rms0Dre24YaU3rtBjUgQufoGz3aCuKt2DeNKFPp+C8MM7VIVTviitleKLZ781dQO2F3LbftX2n4kI5x4iA25DlDd2Pr4nrHqYdvbGaucJINgqYPAQXJoiFfcrB8gXhbbzkDSKs9COW9laDivNsJ/R5XBpb0Lk04qC8z3VbikQpxnDvyQHxKsAZ/vda5/93FrEIrezuPx845X4khV4hjM4Omt1hye7XvRLpRBwrWOd5Q7LrVtUvKv5YXwwcSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAMF3VxY4NOehnn8O1eVN0nuNJ2O/LC/+LCZsDpMM5w=;
 b=IdThlf95AcBO1WOjEs481P6UjAQEw37opiFZCsisntR9OyupU5oiBfrw82WMRsYvzTm21KGW+EIAtPTAwcVZinAmcSEDKWbGNrV2oMIuFGY4tMjmFAM2MKKHSKMKmEC3tnk/KfyTquJifPDWK4oCXwwiwWyWVyKd97VZhyKuqAlMR1J8+ERPtPHMdJHQ56pNZ2nXhyY6kCycN7hH1lzBCrpHlPSIjIdZrO512hbWFkbG9qOnhq6SHBAE/6weTpuC92XoMTvZIRfYxf9VubJbJa1HtX1QPWF0zK9kvoMGAO/XSRQu/OBajfguP/j8rQM6J3d4o49+aJn5TYnXXhe5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAMF3VxY4NOehnn8O1eVN0nuNJ2O/LC/+LCZsDpMM5w=;
 b=EY9fb3mwiPFg/HNhyp5X2rjjybHgUYW3eYtInKwX+NUtHRJAGKghIpChr21OhDkOBAcmvQMx9Wp4w1Wvw8iW7+ax8VFMNrOd+8W+asNrcaZzv3pXjmDlLRmiQsd+Rw1WK+i9m748oGORhPZz5Rnb8PJXlfDpWbxT84kwJ8VOpA7DdFbh7TIUs7WFAlUfL0tt5MNVg7p2UFnMJKNIhSYWiZPuBPmTr4UzXp9EiFyEZWIPHGlxqkuPPJnHY5+Ys0RjCPNBKljtZEDrfip2yBpZavDhXOkb9KgEgtJ4WxXCj/Q7WjX1FttPHByD9RXGk6dd+D3xuLqeSUpCGcN0XLCryQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 09:20:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:20:44 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:27 +0900
Subject: [PATCH v3 02/10] iommu: Add cookie type for ARM_DMA_USE_IOMMU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-2-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bf2253-4dde-4716-6b71-08df33426996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|921020|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +sUpiKoztMuS5SgQu3Wur4VC85gE73QsaYW9gXkI2vKUim2bmRP2+KPGspQ7HnOcxrueKsnzdj5kQBQ9Bi2CsV5GEG5CySBrdVXJNVcm8eL1jay6MhXSzWSMgKe8a24mWrs1IbeS+h/d5SYVXwELGavgMFB75k0zZinXa8Z6ZgzRuDQi4z0YSLvPuqtod5hTOeyn1t/5mQJ+uB540l9rn3kSRn3xUD0w3wH9aUVJN5K567pFWN11pjKtKWVctJzN3OvOqE/spXrU4fzzjH8eEFjtiOwNqtfH7zN7YLU87/bDuRQTdW23cOYCVPdyvN80AFJEdHotdC0Wsp1UzN+ba7Z8A7xE6XFT8A4ZmZyMEGiLFkr3Ltge/9zhVSXuVIuoutSo9JrXFaSOS4bG6K/DCxAByPYX6qTb9EAJVZ2We24cPiRGjGazGl9dIHXjZmINqlWTwx3FwnT1orRMjZNa1p46rduiqBgesG9NRALh6jd4TDVKF3YbqXgH++LLCsVq8cuSp1Mnt7dyFrYKbJD8SZsStQ5Qib009FxoBbeivYsc0Ey9nyZEy35dA6VlLrZ1dakvmjvPdFMr2PAHNfCmYMQdT23OTZtP4Rny07dUCD5Z6N3eTBZILLcwzbtzIbSPssq4DSeKRy8z5OKWrvZ/6P5nVbGBPB+KHXiKgznq4h7NGI8XPbkFWSVW3ujwafSkeVP3Xn17jTlcwiutugVDaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG42a2l2bnNBWVhrMGhITTUzWTZRSTFZZ3I5VFBzSno4MVlHdFZXYjZDK2dy?=
 =?utf-8?B?RzJUTVREZ3ZmNXBSaW85RU5QRDE2bkNZakJ2UEZSVklIQjdNR0c0L3UxYU81?=
 =?utf-8?B?dU00VnhMekFEZ0VCZXMwMUZJTXRsVGJJN2FjcmU1OEVQMUU5MWxSL3psbnkz?=
 =?utf-8?B?RTV0ZzVlUkEvVzlvYjMybUc4Nk5rRTdqa1lnZWZTTzhvVVhSWjV3TWhlWDNk?=
 =?utf-8?B?Qmp6bHlXUXd3K0lDdUlPdUpNbElseWZtcjBublRocFd0bld3N0VWaTVpa05W?=
 =?utf-8?B?OGN2YnljYjZjSmlydjdGQmxJVHNBa2ZvZFNpaFRIVjdpOFJlalVoV3M3c1Zw?=
 =?utf-8?B?N0V3eW05NS9haTFkcTB3QlY2TVlBNjNQR1oxa2EwZlh4ek9yVks0TXBPY3N2?=
 =?utf-8?B?SVM0RHIvb01vQ2N5SG5ST1FLdElxMjlEVHhYN2hYdjVnQmIrMFJFbWROQnpV?=
 =?utf-8?B?UUg2YWt4Y3NPd2JCbHNRY0wxUm5MRWNMcGw3T0ZRS1lLT2JFenN5Zng4QWRh?=
 =?utf-8?B?cGF3bXhNdU5MNktzak9NdlpwM2NyL2ZjQmYrRUt1RVRKNXpvdllLYTl0cVkv?=
 =?utf-8?B?K0p1akVWZnF6MlkzK1Q4bU1JN28rNVNLckZ2bE5QdkYzSU80dDdHUXhzbmNh?=
 =?utf-8?B?SGt5WXgrdXNxTFpIU3EwMlI3QktJUGdtc1ZnVFNxUUZkN2RVeS80ZzZvTXNm?=
 =?utf-8?B?bkkweFoyWUw3dnpMTGdZbDU2QWY0TE80SWxueS9oQnFGOEtSSFNFMGdveWRV?=
 =?utf-8?B?aVhDeC9Pc214SVRSaGdXV2dPNnY1cmNyMDlCbkgzZVpmdC9mc2g2L1I4WUp4?=
 =?utf-8?B?MFVENHVLc0lsV04yN1pEYTNscmg4RGcrTDBVRU16Qm4rdk5IckZxYU9BY2lt?=
 =?utf-8?B?UWVPYlV0UTYwSHIxcjF3aHJWWlYxRlM1a3paa25sMEs3bjJTdmhOdmhRSU5H?=
 =?utf-8?B?RGxUTU0rQzVLMHlPYTkrUHBCTFVTeWNpZ01VSko4T0E0ZXVxTU9BajBzZjBs?=
 =?utf-8?B?T1pnczcvRmIyVDlCdEkwY01tT2REb01tN1RJd2d0RVI3WTIxeFNrZ3pEbDVP?=
 =?utf-8?B?MlhtWVhCVVdyREJLVWNFN3NROWhqNUQySC8xb25FQ3orRFdIdDRBVUlXMEdU?=
 =?utf-8?B?dkQxMEpxV01zUU0vZVRmMUJSL21YeGcvUFdhek1EdFdXTkFiZXpXL1pBVUhm?=
 =?utf-8?B?cStBUGtGdWwvOC80YWtVb1VheGNaNlJqNHdzT1o3Zk1qSExqMTFqRVZxS1pn?=
 =?utf-8?B?UHliUzRZY1dhQnBPc0xHaTFHTENjd1A1MHZMaDFodU1VcTZqeTdrenlIY3Nt?=
 =?utf-8?B?Qm9jcjJXdVA3RmQwRTRTT203ejdnYWplVjBnMU1id05tOGNKNUdvUVpTVGR2?=
 =?utf-8?B?dnRzNzR1OWtyVUM5ZWJyWlgrckgwWVdLT0k3OHJCeGpIOE9iRnB5OWl4dEF3?=
 =?utf-8?B?THkyazBFOUZSL0FEY1BRa3EzQmd3MUVQZjFhbWxoeFpHWmt1SkpLRlFrVDRB?=
 =?utf-8?B?dW9CWUtCY2JzWXZBS2h6TzRENWZLQ25rMGF3RTMxRlVIbE5NTlROYnNiZEdr?=
 =?utf-8?B?ZlFaeThGNy9JSGdpKzRhcUg2YU15dXRnc2tmRWE1MHVWTE13K082a0YzUXhp?=
 =?utf-8?B?V240OFhqOEFHb1JlNzZ6U3gxODVTRzhRYjVWb05BWlM2Tmo3U3pNMGZBbmU3?=
 =?utf-8?B?dGdNM3d0ZkRldFhZMzVTcXBlVWU1OCs1M3NmM21UQmlrNTNNaW9NZFZMWkRj?=
 =?utf-8?B?cXM4TlV1cW9ERFgvV1JTdXZtSUorYURvQ1BPQU1XZ2w3SWpkdVpuSTVBWUQ3?=
 =?utf-8?B?QUNtUlRNQVh4dTJGMXRXQkRGY3JHUS93VVdlYlJ5Q2wwU3EyUkk0WFl2V1Fl?=
 =?utf-8?B?cUJDMkYxVVdXbXYralQ5RXVRRkdndXdjVUsydjBZRnJ6cFU4dzNjUGF4S2xK?=
 =?utf-8?B?TVpWQVErTnBISGo2QXZwOW1BSkVTNW0vck05bG5VeTI3Z0ppU3RFRkNIbzJF?=
 =?utf-8?B?RnZ4Uzd5SVZlcnF3MlRkVzNlaFpSdGxLSkpDOEVDYm9iaG1PVm9PNnRCbXFn?=
 =?utf-8?B?QUNOY2pKOTZFNkt6b2Z6cTFBemhHODFQeDdiaUlzekc1anBBZkt2ZzhaSkFt?=
 =?utf-8?B?cWwvRXg3ZjA1RC9iYlZIZTVzQ2l4Y0NnRDQ5d1dmOUlNLzJ2bDMwc0lESEF4?=
 =?utf-8?B?ZHlOc21DanNCU2NYRkJjZitzSXB5WUQyM0FGWmFqL0FDRjZMS1VxZ3NjU1RW?=
 =?utf-8?B?ZG5OdlhaU1NtZnV6eGN1UmFiL00rVFlQS1JwRWtjNTJRekNneWx5N0NXdGtE?=
 =?utf-8?B?NENyL2dUOTUwdXh0S0xLN1d6YlpWbXk5Mm03NDljRHBzVXFTTk1wOGxybDc1?=
 =?utf-8?Q?zhmQVyMp4SOEPvsgWLDcjx3gbB2izWxMeo6CYHLAAvVbL?=
X-MS-Exchange-AntiSpam-MessageData-1: ClaCgbzLORQAvw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bf2253-4dde-4716-6b71-08df33426996
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:20:44.4453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IcezX9WiFm3tMbpZmPKuu9cXWy7DCFKfBIUxEK+mfMav52s65JSrPHCMcw02bXPQz++DbiS3XdJGcWEEGSgrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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

