Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B89606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XTQPQwcl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E0C10EEBF;
	Mon, 26 Oct 2026 12:12:39 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9C210EEB4
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOkIMk2ysbu+era8UoCW1SxtXSCrjgxxIHA6r0Ww/OsdKieMKpTV7yaCqf/GXFrvN6b7u1cmnoDw5CuMcvNeBQu2z6ILALABPRESUJHtNYs6Buv9iGPo3+UWFh2Tev0U2jBHeCDE1tOh+8TJ7137G2n2tLzZ6aXcaLbU3Ktj8QjU2CpcfqdLJ3/0TDtLzTXOnMYm3PUTDpaAKtuPUN4i1tbCml2uY3h0y+PCeA6FpdY3XrGr8VRzTPNsztAt5d8T/NR8FCE3f4XSdev1YWorwZOxGoLHJJQNPO1crtwc+WPEC8sqI7seUKrU9aB+5Z4dvY2mnDEvp+GXNmKMIj4wTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEwPdeMbxdoAuOZqLsXXABnbpCCVYFJnIF9CBlK5/Hs=;
 b=pjVQBIHbh8JO2hPhV1fStFRhRprXl8IvmYmLZ1jpmIELuRjrPF3IlSrwXT7Pq9SBPxtA32tI6POHPeuxO4Unde7WCnGbV9y4g0jcVaUMgb1rkPpWL1ysv5kh6b4REp9WOwTflptQkGt4ouaB3ftVAUA9zYK1rrDK2TOOytCK1ULQu7zDwTL7eUgNcMAUHy25iZO3Pb1Wai0TDU+UDeuU1FeWv8FsVP4zfM99NIoXO+ZYTxf+0U86jwe0anPH2qz9xYubUyp9DF7zKhibXcP2Pon323SfSPXsE5zTxR0M380mVD8Hq6ClShKlbjyMmC+YnlsURt20iiCEUAbPmprbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEwPdeMbxdoAuOZqLsXXABnbpCCVYFJnIF9CBlK5/Hs=;
 b=XTQPQwcllwzGiQu1aF1lLed2jlWbq9mf0guI2H8DOenDmpOPIQNpz3kvKNunWEO5MurpfpxjGP2eRxZYia4got617tgEq+t1PH4LpqNTo2smugjk83+S9bFH6G1n2jLDcqwBUWSSN1u2U2Ls8DRn9dH67dMpnj9GOtqbwpzZjgzu5qNuwv5nrNHs+f7qZAck90X5G7PNJ/DO1kWHKzJYpJ6ahY7oS/xMLffgrXWTP4nxinu5NJM3HuARejGNxuntPsMULaqJvSTzG/vv/M5MQEo9DjitkBXhI53bb9SNux35YEbsZ6GqFdK8Zm9C/iM6apu0o++3x3t+NwNIrZlQYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:12:27 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 12:12:26 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 21:12:08 +0900
Subject: [PATCH] drm/tegra: Use shmem for DMA IOMMU buffer allocations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-tegradrm-allocate-shmem-v1-1-eae07ab827d6@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDQAxA4atI1g2MYkV7FeliZoya4h/JtBTEu
 zfVxVt8m7eDkjApPLIdhD6svC6G/JZBHP0yEHJnhsIVVW5hKDHRIL6TGf00rdEnQh1nMjrXuNC
 UdX+PYINNqOfvOW+fl/UdXhTT/wjH8QNXhR42fgAAAA==
X-Change-ID: 20261026-b4-tegradrm-allocate-shmem-a0090b948f5c
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY6P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff79cfc-e5b5-46c3-7708-08df335a65e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: +GyWSf6Apd/yj68MH6UcBm4DHVwK0yNcL4k29cNLnW1/xDg1X6hl9qbixm0tkh2I2zHHZKsCSJb/09v2BddjPvZH2Xkn9EInNGKBX2+cBoqUd4pqimJXFPB6S54zkDUqH7O8CnlGtOTc3rYjs6doT/1Ss39X2cCbhn+Ye3fzBzmNW1ZErFtI7r8LgT64vhVjeCe/AebsbNYQVq2AzELf+lb7URDoHAwCigmF+5Uc2xv+6WxHqpeA+gQhNcJHpZie+1oR/iK77NIlptmS55gV5IBmGQTFdHOwqFDO5NdgX9BIGHN+8K8sChi4epgpv3CVnmLT0a84/11rZJqzLEW0KADE2qMBmnXRNE3pkjUNgBflL+wzhs+wrni10KFZOOT0WOQFIXo+gU6e4Ul8mMmGhXGMqtVlBy04fhXuNTnAjFijwvPyHHpo7MdDEcG3zrqW8CEEwSff8y9EwSdUIMskGYgqKqtDwaQTr+nDdSgo4gcV4nIymVypGPhHZj+RJvRbISxB+VwJ74nfamWLTEdwZPM0bxvdvJQijKaNawIE+OzPyqiKuYwkn700lqZu1fNCd2asIt1xceLtCd1XL0EG9H0RS7O2O83t8wSlO+mRfo11bh/83pVJ7h436AP7mPZ0Dqtrey0GN+igBx6T5oLP8y+KvLF6BRZEGAgGxhUpj4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5zWE5mK2NTMStpeS93a0JJaG1yWW5UZXVMYnRGcEJnYzljZFFIMEtwSnlO?=
 =?utf-8?B?N2g3M3VYWFRJZ0k0M1ZvcmZhenlRSlZrYSszRUhlRUlaMjZoR1d3L1JRVjR3?=
 =?utf-8?B?U1ZCUzJPSDNLTzRWekxnOUZvNkJ1QnRCTHlLZXlFeTZrTFcxd3JNcmpZQU9S?=
 =?utf-8?B?ZXkyY3VwT0dFWTc2b2tCVGg4KzAxdVk1c0p4TFlBUzZrV1dRQVpRZk5uam1T?=
 =?utf-8?B?SEJrUEg5aFd1OFYrbGhPekVGdnV4MmJRZVgxVUkzanRTMzFNdEVHcDNQN2dt?=
 =?utf-8?B?czVScE5xNVhqS1NPdy9kSTNRdTlqbUFObnRYNFZjVVA2aXlwdkRIemJ2VWNG?=
 =?utf-8?B?SEJMRXIyeWVGa0dIRE53Tk1iczlSUlVEUWZiS3RMUnVSaXVxeG8zeGJnNS94?=
 =?utf-8?B?S0V0WUpIdXR5UGFPSURKMzNqTHFIWHdURXNLelpRN2pQUll6amw2THFld3lT?=
 =?utf-8?B?VjBKSDRNcEhSdXFPU3N3VmIzalU4dEhlV1k2Y01wbnB6VGxwYjlrRXpOamls?=
 =?utf-8?B?T2JodGZUejEwQ09zQWo1Sytlb1ZISndidEN4QTlOVTZERVlSQWhjZXpUaE9H?=
 =?utf-8?B?OHdNcWJ2bytkTGJ0T3A1a3ZQR3Rwekp5WUR5WEJuQXBEVXdBaXQwS1o3R1M2?=
 =?utf-8?B?TlFLZnpyQUU3c1c1a1AzbTZiKzRhWUdEWVFnOXVmMmxjSHlZMStvU1huREpR?=
 =?utf-8?B?NnRzL1pOek5OdXpWaVpuSFBHVVh3KzdDSXBRNERNL0ZVbzZUZ2FzMlBGd2Nv?=
 =?utf-8?B?WTdXRWpCaU9NeFlyMWJ0Z0VpQzhwaEVRclgwbFZOZmx4cCt6UUh0V2o5T01T?=
 =?utf-8?B?RzVSWkwxZVFqVnlJT2xtbFNuT3U4bWsyNlh6TDErbjJRRUViT3ZrQk45d2hw?=
 =?utf-8?B?U1RlL0hsbTZyM1E4MFpIaFpqOTdzeTlJdWdPWjYxSHBvK2xLV0RDZldKV2hV?=
 =?utf-8?B?dEY2eUlqaWE5Q0ErZ2lIaHpFcW5zbzdOZGV3QlY5UzBYaXRCTlVGQXJPYVZp?=
 =?utf-8?B?cGJwaGg1alc5M1QySnpwZU1jV05mNFlnbVpvc2hhb3ZlSzFUdzNrZmU1cHQ4?=
 =?utf-8?B?ekpXY1dHVTZDQzU0QmRlMkk3OTJHckNZdk53Z2xheXBIY25sVWVWY0U4M0pH?=
 =?utf-8?B?WXN2c1AxemFsd0FJcnVrZFlYc2Y3M2xPaG9xQ3JDazIrUHBGSlZsemFmTmtz?=
 =?utf-8?B?M2lyVUdoUVlQOVFYZzdOUUxnNklWNGtHQlM3UW42U2V0TWFuajJpUnl4ZkVu?=
 =?utf-8?B?Ly9pL205TXQ1dGdiZTIwNERlaXBDNVI4SGZhZ3RzSkEwczl2ZnA5S1hBbE1x?=
 =?utf-8?B?Q3lPdGRUenpBTVY3LzZkNmN3Wis1SkxtTFJjS2t6UWpiRHJ6YWZLZGVYY2Y4?=
 =?utf-8?B?bEhGVitEMFN1Q05iOFZQOCttYnB0dUhEdVljWjRUdHdDU0RXUmg0YkdqSWwy?=
 =?utf-8?B?RTJEY0NaWFpnM3JvZmcxTTVXVyt0M2hBNi9aV01TNHBsOTNUeUdjK0NzZkdm?=
 =?utf-8?B?dStyOHBzTUh6aHJpcXExcjd3bzBMMnpsdlg0VzQ2c3JwaFVTY2NIeFNTNlFw?=
 =?utf-8?B?aHVzUXVEd0tlQXZta3lZaVphMEo5TkUwa1lvVXhnNUs5eE90MTZtQ2ROVkRF?=
 =?utf-8?B?UjFsQ0NSN3hkeVVNSFZxdlpxOEc4bGhCNGk4dXo5cXJKT1pGNytLMzJ6Mjcz?=
 =?utf-8?B?QzNRUk55MTJhUGFjeTFRS1lWNnhiL1B4bExSRFVVNlgzTjVLZGJPMWEwMUZH?=
 =?utf-8?B?UEMyQUgvRHRTU0VxYVFyek4rUEp0eG1vYms0OXJueTk2OXhpSmV2YXN0Zk1l?=
 =?utf-8?B?ZmxvNEdxZThDWmc1bjdaSlM2T2ZNeDQ4T0VVVGZwVUZDM08xNW40MEpNaU1s?=
 =?utf-8?B?cDRVaXZHUzdOQURHMmIvcElpbG9GenpzMDZXUzk0bDJ5V09BMGVZMSttN2Mz?=
 =?utf-8?B?cTY4N0dYemFjU3ArZ0NvKzR6R2l6dmV5NDZBOVo1elFWbzFHR0FtaFlMV2p4?=
 =?utf-8?B?Rzloc004cnZBUlhpdUJSK1VkcHZRbEtyQ1E2bUttaWhjREhZWk9nTWcwaklC?=
 =?utf-8?B?KzZqQ2V5dzkwNkhDQTdzbmdmNURKdlEwNXV0Ukl5bW5FRi9jeXRva2YzWFV1?=
 =?utf-8?B?THY4QWY3RmtNYk9nNGFQMmt1QlRza21CM0pMZStpSGUwWERDblpnN0VxeFhN?=
 =?utf-8?B?YWhuT2xyU0k4R2JIK2pxeC9GV05XU1hMa3I5b2FmcXRjcTFNTmh0VkNzM1Nn?=
 =?utf-8?B?NmhoSkxPU3VRRlpxMkk4SldVb05rNWdieVMrR0VPakw1d2xXZituaXpKNUo1?=
 =?utf-8?B?M0w4ZTdROEtLb1g3M0tld21KUHZQREdCYU1mOWxpdWJQRCt6REtHaEkraytX?=
 =?utf-8?Q?rwjg+m3/+HA+B/mSCoby+nNrfkYrzkyotlr4q2btTAwig?=
X-MS-Exchange-AntiSpam-MessageData-1: qdw15MNPKZuFDQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff79cfc-e5b5-46c3-7708-08df335a65e4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:12:26.1166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyJ4G1tFjpYz8zfj0+hol1DQ3ipMl4SkzLwuiCnrNO0h30yZ0IMPzEfgdnzEvdk/RFnR5HjDu16j1ZJkaDBwlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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

tegra_bo_alloc currently uses drm_gem_get_pages only when tegra->domain
is set; otherwise memory is allocated using dma_alloc_wc on the drm
device. The latter is correct when clients are not backed by an IOMMU
and they need physically contiguous buffers, but the path also gets
taken with IOMMU-backed DMA API, as tegra->domain is only set when using
the explicit IOMMU api.

Record whether clients are attached to a DMA IOMMU domain during
initialization, and use the drm_gem_get_pages path in that case.
Initialization for all clients has to finish before GEM allocation is
available so this is safe. Typically all devices should be IOMMU-backed,
or none of them. In a mixed configuration, fall back to the physical
memory path since we don't know which client accesses the buffer at
allocation time.

The drm device's DMA masks are also changed to DMA_BIT_MASK(64) when the
DMA IOMMU path is enabled to avoid bounce buffer related issues when
mapping the allocated memory to the drm device for cache maintenance
purposes.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c | 23 ++++++++++++++++-------
 drivers/gpu/drm/tegra/drm.h |  2 ++
 drivers/gpu/drm/tegra/gem.c | 16 +++++++---------
 drivers/gpu/drm/tegra/gem.h |  4 +++-
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 324480c87fb1..1013bbd662f8 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -958,14 +958,10 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 	}
 #endif
 
-	/*
-	 * If the host1x client is already attached to an IOMMU domain that is
-	 * not the shared IOMMU domain, don't try to attach it to a different
-	 * domain. This allows using the IOMMU-backed DMA API.
-	 */
-	if (domain && domain->type != IOMMU_DOMAIN_IDENTITY &&
-	    domain != tegra->domain)
+	if (domain && iommu_is_dma_domain(domain)) {
+		tegra->use_dma_iommu = true;
 		return 0;
+	}
 
 	if (tegra->domain) {
 		group = iommu_group_get(client->dev);
@@ -981,6 +977,8 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 		}
 
 		tegra->use_explicit_iommu = true;
+	} else {
+		tegra->use_direct_dma = true;
 	}
 
 	client->group = group;
@@ -1232,6 +1230,17 @@ static int host1x_drm_probe(struct host1x_device *dev)
 		iova_cache_put();
 	}
 
+	if (tegra->use_dma_iommu && tegra->use_direct_dma) {
+		dev_warn(&dev->dev, "Mixed IOMMU and direct DMA clients, using contiguous buffers\n");
+		tegra->use_dma_iommu = false;
+	}
+
+	if (tegra->use_dma_iommu) {
+		err = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64));
+		if (err)
+			goto device;
+	}
+
 	if (tegra->hub) {
 		err = tegra_display_hub_prepare(tegra->hub);
 		if (err < 0)
diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index bc720ae8d95e..63d99d3ff422 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -36,6 +36,8 @@ struct tegra_drm {
 
 	struct iommu_domain *domain;
 	bool use_explicit_iommu;
+	bool use_dma_iommu;
+	bool use_direct_dma;
 	struct mutex mm_lock;
 	struct drm_mm mm;
 
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index f76af733ea79..bb8d9f9e6453 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -111,10 +111,6 @@ static struct host1x_bo_mapping *tegra_bo_pin(struct device *dev, struct host1x_
 	}
 
 	if (obj->pages) {
-		/*
-		 * If the buffer object was allocated from the explicit IOMMU
-		 * API code paths, construct an SG table from the pages.
-		 */
 		err = sg_alloc_table_from_pages(map->sgt, obj->pages, obj->num_pages, 0, gem->size,
 						GFP_KERNEL);
 		if (err < 0)
@@ -378,15 +374,17 @@ static int tegra_bo_alloc(struct drm_device *drm, struct tegra_bo *bo)
 	struct tegra_drm *tegra = drm->dev_private;
 	int err;
 
-	if (tegra->domain) {
+	if (tegra->domain || tegra->use_dma_iommu) {
 		err = tegra_bo_get_pages(drm, bo);
 		if (err < 0)
 			return err;
 
-		err = tegra_bo_iommu_map(tegra, bo);
-		if (err < 0) {
-			tegra_bo_free(drm, bo);
-			return err;
+		if (tegra->domain) {
+			err = tegra_bo_iommu_map(tegra, bo);
+			if (err < 0) {
+				tegra_bo_free(drm, bo);
+				return err;
+			}
 		}
 	} else {
 		size_t size = bo->gem.size;
diff --git a/drivers/gpu/drm/tegra/gem.h b/drivers/gpu/drm/tegra/gem.h
index bf2cbd48eb3f..da43bef546ec 100644
--- a/drivers/gpu/drm/tegra/gem.h
+++ b/drivers/gpu/drm/tegra/gem.h
@@ -37,7 +37,9 @@ struct tegra_bo_tiling {
  *
  * Buffer source  | Mapping API(*)  | Fields
  * ---------------+-----------------+---------------
- * Allocated here | DMA API         | iova (IOVA mapped to drm->dev), vaddr (CPU VA)
+ * Allocated here | DMA API, IOMMU  | pages/num_pages (Phys. memory), sgt (Mapped to drm->dev)
+ *
+ * Allocated here | DMA API, direct | iova (DMA address on drm->dev), vaddr (CPU VA)
  *
  * Allocated here | IOMMU API       | pages/num_pages (Phys. memory), sgt (Mapped to drm->dev),
  *                                  | iova/size (Mapped to domain)

---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261026-b4-tegradrm-allocate-shmem-a0090b948f5c

