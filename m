Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0EC60A2605
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jcJBNuGw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C6D10E950;
	Mon, 26 Oct 2026 05:38:22 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA62110E943;
 Mon, 26 Oct 2026 05:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL2YvXaroiCt049iYkqHeMqDIW7+1BSo1VlkQ1U906xkrGypPwVO6s0cJ70bvDSJKVnmOEIfq+bwUHOM3n7eLZsT20KOnThyRM8X+Jj4sehBGj7zL/0qw8MjY7E9P4illc7O/3IGcFd4zKJAzRJ2m4VXP7vxmELG8eD8JA4Sbuc5a+hd2X+q0aRiN5mhM7iJ3B0M77p7KLkOKCGzpsB6wZc4Mx3gd2Yfe4vUTFsnJUfppo7tjuV0bPtwpmV2iTRIHSS0rIRtt+vlBoahIiFV6/diR29EbvfhnnOub8p2E3t5OYSo2KIptywhZrsCYR7DO54dxtOVS1DOgykXHpaRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjx6I8zHKfga1pa+AT1b2xjUdA07+3W3Zea8OpnoXBs=;
 b=tu2yp3fqhxqed6xilUyN1zfKvKTe/KIPseaSsBnVqUoTmowLpothk8ZIa1dnzh0JkRvweVA+5ZhX8D029rv5QvgV+6+QJOQ3hArxk5tgyomgZr6OEwQjF2d/wrEAvJvSDy/yh0hxinka422qf8yn1kHvVB3blF6R0dUBZBnrl+c9Wtz6KS1NkBZqEKbzMESy/TUUypPVK9mBN3PwHrzG6HeK2hpW/r/fEqzemcBw/iL39RkeUtOdqM9R6+Q2g/MjFHZvhkiYzXMRBkreinMmB+9gfyugkTV0NTVZjg3/XcZ5pcnYIZYI0rkYeXxoZcjADO6VieSK2wV00n2dQFcpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjx6I8zHKfga1pa+AT1b2xjUdA07+3W3Zea8OpnoXBs=;
 b=jcJBNuGwNKsk4SoRcxIAKtocjs+p/PKAoW+SkKrp0oMyxMZUCUCZCzo1kgX5jKVz0ntdJik6b0pI5I00gjS30rPyCu6WTaO6VZHLg0ochh1rr9J4YKjwOFySBQkqvnpnaOZZ9LGusWE/ykihhcCeyxSRHs2x3ePXEbJAxBFi5e6YgFGHlRMEgETHU8rI3Edp9Vv3OkVbxBUO+u0cQsxU8knXA389+RXbAI8BpkfVibqP5ANH8CIBKCFKDRf/i8MxQOA0elkEZbSIjhTYBoVoO0qYOeVCAsguSrPhnsoFylAKlzgiuEDMc8lma61u1A6x2QsKDOQNqnot6uE2nk2/nQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SA1PR12MB7442.namprd12.prod.outlook.com
 (2603:10b6:806:2b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 05:38:01 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 05:38:01 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
 sumit.semwal@linaro.org, jgg@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com
Subject: [PATCH 17/26] dma-buf: Update dma_buf_phys_vec_to_sgt() to use the
 SGT mapping type
Date: Mon, 26 Oct 2026 16:36:08 +1100
Message-ID: <20261026053623.202642-18-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261026053623.202642-1-apopple@nvidia.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0148.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::12) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 549857d5-3a94-4902-62a1-08df33234ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|5023799004|261021123027099003|10067099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 53GCwkmxQkzncfyx9K0aA97/rUFfOdkJa226BpkrQ8nenWl4Ul57pAm5lT2NZj+QTDL3FfrHzqDTpTguEip64cisVBw/TQtbtInZCk7yv22ILgVoxDg3aCbTxM/+/g/UOzPdO7nLu9B6f+B3r8XSTmQcUa0A/2sIEb4xg81XFDmu8yK71HU6/9/giND758tj2bmGd4kXnt0g2pQ93ihJtwRTp7hcusSpfa9gbH/0dsD4ZC8/mku/wZC6/45sgcgUe6yC6TNHbmJuzJWyAodXm6H9nX2E0rWCqOZe8uL8akpWNlVYoH6sLy+nSLl0DC88od5fbm471LoUWC4G1W7k82oV+EazLqWnbdyayhwTdRtPdRYvwiRQj1vgK7KJfFgJmwRus+R6oUthEkbC3G9NcFPPDmM9k5MXaeM1t6e0WrADXsB2QHz1AOJBxrr1+vyiXQRL7+LFi1Mk4yhcu35n4lLCl+qIYEPrZ1ELbt7Fbeqx5rD5lRWTipl7mSiPM8ah1xHgTEOUxGB0XCffHKQGYleewcpTVgUToxbmeksjHgVIp6PX12t9Emicywn03BgFdJuqOEl5JnGRzMR0IIgryZi3DYZtLTQ/gMAvVGEjDUfFXe/pecazAXw0tQQgT2pbyrUDfGgTXbB7lbnSPqgxGkjY6s0sLKVHSw1wBnO68NM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qBnwsIlFz4eh2WKv9FJOqK2Jy1yAd2Q04vdyBHKUx+KZ4jEY96TDumaBiUfW?=
 =?us-ascii?Q?vOo92gb5Ir10j+3iqlA+zfcssZm/56TduFMqe39jHb0hEb5ZWXmsW0L22v1E?=
 =?us-ascii?Q?jtD7QSMzS8Opu3+a5WH0RNNAdU01QSEIjc97vughYmPVx8uXwx7U9ek3eGsq?=
 =?us-ascii?Q?+1CZy2wiCHCcqnKSiQRYiNaKRnLYJ7cLqBTkwkyBTvMWkJvpH7uhSZeAH35u?=
 =?us-ascii?Q?HgRk+GOSXLOpJld+YC/uBNhC/bFCTprrtroG7nfC3u2dJIJszqdYvLlH5YoY?=
 =?us-ascii?Q?sEP4O/PIGfouYSrw+M3B8HhzHmvYKQEe5YiowTxzUeBUgtgO/gT7h9hI9rSP?=
 =?us-ascii?Q?rKWSl50XLYAWTYyFBoInnDDOZaeWS5BWrrDGST/ts8VqAkcpqtC2W+6kThh9?=
 =?us-ascii?Q?ZMfPAI16d9WH+SMxcJPZ24OWn7R8l8lOLKIEEByIzg6tZNgGZmUbUYkfo5PA?=
 =?us-ascii?Q?6FmLu32XH0bG/T4OBGwy+a8Sir1SLLhKdKq2G+v8Q+guCyx7GyvnNwIJjHou?=
 =?us-ascii?Q?ksgNGcsN3GdMvzSdAILFkRk9Jxwd4MWPA/yszyU3E4MQXwxjMiayn2sHUpPt?=
 =?us-ascii?Q?SA3mxXQxA7l+ebkwB62oRksN3IrbKGG9NNAmbdbnEfeRk0l+UVH7QYkTzidG?=
 =?us-ascii?Q?r5327rloEwupMau2mSItRMXcDjExL/Ty6LRBcNxA/wy258eDYuYAFOtLhY9B?=
 =?us-ascii?Q?oDKoQlsBwdzKHfQY3sdHQKYXWuymkdSQfoyMKaOQl7ESDZdP+vjDqOiPuRaZ?=
 =?us-ascii?Q?TCrLi9rHNDXWxVnK8847R0O1vW0wOujGrV+HKxJElSk5/fjHMnLXejIpjSBD?=
 =?us-ascii?Q?KhPC97Co62mKPvNg1nG4cfvagfGGDfBT8vP42aVw0mw2o1D7YCZ8cUFFn+uF?=
 =?us-ascii?Q?5XMg3k6dtIKzghkFQ7pWdUZn4wn9DwCeTZp9Y4YADQw/JeXNg3vOEXtSg9SD?=
 =?us-ascii?Q?cPUu1DVHeWpac4k0UguN692qf89duk6Sm233sFIH4pZioEOqA44btIaYAa6G?=
 =?us-ascii?Q?wHQwby9MtLAxRQM7e9Qt5dpocKbKv7vAwfO83Bj1ebJFOtcmPeaS0KeyBSMT?=
 =?us-ascii?Q?fLxqveNuRQ0DVVZtQdxBWGl/17JGHoTcvN9J7RCNxgT55gP/iAi8GXQU5It6?=
 =?us-ascii?Q?yMO1dXvO5vc6fkoKlQO1H7z1BiGi3SajVWqU1XzSyCjPClAk9id9JMAw2nXv?=
 =?us-ascii?Q?tlO5627Hx2Oj+cBOVC5ax81H9+WOnweQybJnfQNaeElS7vfjae/c0WZPiKGI?=
 =?us-ascii?Q?bCSW4hJtfMYrSMKJOsmhB23sOMUgJCpJrClWLOwZPI9oqfICi73sbQyEspMi?=
 =?us-ascii?Q?Y4SHoL83wsmkG0lCql9q4RyFOGGfNd2XEnIFjlCYNecuvbcnvP2OlIBaFhHP?=
 =?us-ascii?Q?BIekiQBzsM+3jdHtBigFAJ0YLQL7q5b1S1LqOAR1DkBhI+HysujvzrMB0ZMp?=
 =?us-ascii?Q?kwEbJL30EfQbN+if9Psffggn8l2L8nR5HIzPOGQDC/URnabFixzAlmlrKPfQ?=
 =?us-ascii?Q?+QABowVAH51iwsVQuPT5olLMvOGRSuBlAG5OX/ga0dAnHboOJJsLUc/Ec1FQ?=
 =?us-ascii?Q?y+I843T/pG6POi4ho3j4+Tx3kHQ/mMBFpatVvdwxHE79cxa4Tlg0OTnf/pMj?=
 =?us-ascii?Q?u2SgnDAgNiSpAI7AWiG7Q7Eg9f1Xf99zL8C5JT9lYMlrjWXapu5XgCHtlV9x?=
 =?us-ascii?Q?15llCeVfu/YUiMotm/gf9sjGek4KDT6npb0O78RHUeycZMLZWRw/AOGU0y08?=
 =?us-ascii?Q?wPVh4PZ3XA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549857d5-3a94-4902-62a1-08df33234ccb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 05:38:01.7234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RURsjRXx7MsJJRT0oWOViI6P4tD7vh7bxrcMi3hjbAHxXJF/1GMzMLT8o0fwhUR0TDJ6UHXUp4OtdgmJ1RbDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

From: Jason Gunthorpe <jgg@nvidia.com>

These helpers only work when matched to a SGT mapping type, call
dma_buf_sgt_dma_device() to get the DMA device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/dma-buf/dma-buf-mapping.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 7a5a379a372e..7d20979af7fb 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -105,6 +105,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 size_t nr_ranges, size_t size,
 					 enum dma_data_direction dir)
 {
+	struct device *dma_dev = dma_buf_sgt_dma_device(attach);
 	struct dma_buf_dma *dma;
 	struct scatterlist *sgl;
 	size_t mapped_len = 0;
@@ -123,7 +124,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	if (!dma)
 		return ERR_PTR(-ENOMEM);
 
-	switch (pci_p2pdma_map_type(provider, attach->dev)) {
+	switch (pci_p2pdma_map_type(provider, dma_dev)) {
 	case PCI_P2PDMA_MAP_BUS_ADDR:
 		/*
 		 * There is no need in IOVA at all for this flow.
@@ -136,7 +137,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 			goto err_free_dma;
 		}
 
-		dma_iova_try_alloc(attach->dev, dma->state, 0, size);
+		dma_iova_try_alloc(dma_dev, dma->state, 0, size);
 		break;
 	default:
 		ret = -EINVAL;
@@ -157,7 +158,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 			addr = pci_p2pdma_bus_addr_map(provider,
 						       phys_vec[i].paddr);
 		} else if (dma_use_iova(dma->state)) {
-			ret = dma_iova_link(attach->dev, dma->state,
+			ret = dma_iova_link(dma_dev, dma->state,
 					    phys_vec[i].paddr, 0,
 					    phys_vec[i].len, dir,
 					    DMA_ATTR_MMIO);
@@ -166,10 +167,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 
 			mapped_len += phys_vec[i].len;
 		} else {
-			addr = dma_map_phys(attach->dev, phys_vec[i].paddr,
+			addr = dma_map_phys(dma_dev, phys_vec[i].paddr,
 					    phys_vec[i].len, dir,
 					    DMA_ATTR_MMIO);
-			ret = dma_mapping_error(attach->dev, addr);
+			ret = dma_mapping_error(dma_dev, addr);
 			if (ret)
 				goto err_unmap_dma;
 		}
@@ -180,7 +181,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 
 	if (dma->state && dma_use_iova(dma->state)) {
 		WARN_ON_ONCE(mapped_len != size);
-		ret = dma_iova_sync(attach->dev, dma->state, 0, mapped_len);
+		ret = dma_iova_sync(dma_dev, dma->state, 0, mapped_len);
 		if (ret)
 			goto err_unmap_dma;
 
@@ -207,11 +208,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	if (!i || !dma->state) {
 		; /* Do nothing */
 	} else if (dma_use_iova(dma->state)) {
-		dma_iova_destroy(attach->dev, dma->state, mapped_len, dir,
+		dma_iova_destroy(dma_dev, dma->state, mapped_len, dir,
 				 DMA_ATTR_MMIO);
 	} else {
 		for_each_sgtable_dma_sg(&dma->sgt, sgl, i)
-			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
+			dma_unmap_phys(dma_dev, sg_dma_address(sgl),
 				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
 	}
 	sg_free_table(&dma->sgt);
@@ -236,6 +237,7 @@ void dma_buf_free_sgt(struct dma_buf_attachment *attach, struct sg_table *sgt,
 		      enum dma_data_direction dir)
 {
 	struct dma_buf_dma *dma = container_of(sgt, struct dma_buf_dma, sgt);
+	struct device *dma_dev = dma_buf_sgt_dma_device(attach);
 	int i;
 
 	dma_resv_assert_held(attach->dmabuf->resv);
@@ -243,13 +245,13 @@ void dma_buf_free_sgt(struct dma_buf_attachment *attach, struct sg_table *sgt,
 	if (!dma->state) {
 		; /* Do nothing */
 	} else if (dma_use_iova(dma->state)) {
-		dma_iova_destroy(attach->dev, dma->state, dma->size, dir,
+		dma_iova_destroy(dma_dev, dma->state, dma->size, dir,
 				 DMA_ATTR_MMIO);
 	} else {
 		struct scatterlist *sgl;
 
 		for_each_sgtable_dma_sg(sgt, sgl, i)
-			dma_unmap_phys(attach->dev, sg_dma_address(sgl),
+			dma_unmap_phys(dma_dev, sg_dma_address(sgl),
 				       sg_dma_len(sgl), dir, DMA_ATTR_MMIO);
 	}
 
-- 
2.54.0

