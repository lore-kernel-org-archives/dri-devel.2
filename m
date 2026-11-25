Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873E606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jmt+uw3t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A709F10FC5F;
	Wed, 25 Nov 2026 13:43:07 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A2310FC45
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRIuBIrI6Aciz2dbvS2/RB/ThGDUUO+fK1msFpGRwN0+hZm8zyUof4lR4YvdoC9AWcBNDYjCaQbdBfJxCRwJkm7pwHIR0n7lZD4WHbqiu+Xpot/sMz4IKwOCtWzB6v3QyVOJizungVg8I1hZsXvgQ4bfMcQvhftdLCnEIh1LVxFZLLfIDRSqiS9fHsc/ijwejfNdIcuiKbFYupyUKRsPDngG3NfK3MRM2Hk6ZUePp0OY7BYyHscXzMyDSlyx9D5Mhp//1R6tayvfGslG2qJ58TxqGhoSUIVoe1h5YkE/iie8P/cMnbf4YSzIZ1+Jh8j5930/9tLTLX4YFNbAxsO/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgCRRUFc2Qez7hqiwKEJBVLPWkCQWx1Y1Na7h0DyiZg=;
 b=yyA/XhmCdeGuWM6vJ/nDHB88A7R5vTnSk60r+jM5kzkf+0L1YOLYe4HNOzPPaVSmL6XNRpklTwIAAOocbKRuzQ+uhcsysdi9G6vUEc8f1wKRuF20Bc5tqt7hJUop1kOOmFdzqKfNl8YIC3evtO3qmD3dqpmfy7AhxLvTTkegggWWTj4DIGL4UTYJ9Vx3jyBjJ1PGBn5ur7QSpTrElRvcynvSXur1r9I/tlg6noSVek/e7bZKfjfPfeT3V4Z37R8EqwHyQrPkyIdg1sat/eYoNZERa0kmfHO1+QcyTmMdZnspL90peoFsvpyNyLbsA2EyZ7B7cNv2NgFaJ6BZM1dAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgCRRUFc2Qez7hqiwKEJBVLPWkCQWx1Y1Na7h0DyiZg=;
 b=Jmt+uw3tPaaaqlhqKx/UQGd59df9tzDCk4r8eqwMBsWeRQ7uiLDscWckJjAQSN4wahlwpxGXCCpO+7UEOCZKewST62yY4beEx0HHqcKnntA6m78+1xES5krzPE9A9dfk7nPT3ql329WZvU2EL5WAvbk3Y6v82dlh9BlRxLp9mb0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 13:42:57 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 13:42:56 +0000
Message-ID: <ff640424-cc7b-4a22-9086-a0e89b07a478@amd.com>
Date: Wed, 25 Nov 2026 14:42:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Allocate a scatterlist per userptr dma-buf
 mapping
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: apopple@nvidia.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dawid.osuchowski@linux.intel.com, sumit.semwal@linaro.org
References: <20261123102644.627963-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261123102644.627963-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::6) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: dbde9f19-d347-4ea8-9ab4-08df4afa02f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|261102130727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: xsHFHsop0UlzezSljTDT41YtyDvwoka7fmumpRg1UgTT0FjoxACcYTEuGAHXEvg1HVTJhZtFIKXwK/T6Z72AGaBzJDpynQ9wj6m/eyUXaUidDdI2jVgR0KWqOQVbJ2F+r8Za9Tns4mgIxdrHm680iZX3tlOBDjkklZ/vQxG7KSBVz2mREVSVZ8PsnSFLZvSR+9YOpFwjLOOky1bjjm/TThdx8YICjQFREJ3KLDPOKqEIj0P+pgQ8RdyYiDxxF1xa/+ifgPH8eCEr/evkl43DWd5mRtvYBYbNZA7FprX2S3AQPnz8IPXUwS+dHcvy6ZUYdRe8cYSq3fJLjAHc1R42xPYqUlP0F8+P1nduZzUyJuKzRYnWB6WMhOql3E1tgt4csZGn023fAvULI8H/ecHRXoNni+wUcHPWfNSt5URhbjhGEOfBSXok0YipHWU1KLUuSXwwfNnxzxfthGVQR1YAqbjow2ALP9vnD8YObw2KYTA46bCGZclWxnZ89NEx1GE40ObpuuJW6h06Z7Fe4rFkvp+ReKgjJApVCv+U16g5LCV7/y9FhXySXjTkN4oQzmBA8Cgk8+/rXhm0RUnwpUdzo+LyATO+GImMw6CE7ixR3Cr2+1igEpdtTNZgOO9490ie
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102130727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxGTTZ0WEZoRnFNbExYZTdydkZrRE5JOWRtUDNNN0FnZWtjTG5pY1N1L3l3?=
 =?utf-8?B?cDM0aW54UHNhWjJBK2JPQXdrTjhtSUFJNTUrZkhCNzltblN0cWcxVi82ZFM0?=
 =?utf-8?B?SllwN3hMTnR2c0tWWHV5czRaKzZub09pRG5ZYy8vUUtITXI1aW9CUWlTUTBv?=
 =?utf-8?B?L0xiS2d2VDdmdmZwb0JONEpjTms1S3FFQmhlZUFhQ0pwTzVIckljb2xlYmRa?=
 =?utf-8?B?NzhDY1pkVzV5Z1FOb1pxQ3lWNVpZZGx5L01yejZqQTdUZ0hQUk4zNm5DWGxz?=
 =?utf-8?B?Q01QMnN6LzBPVVdUN2E5Mk9yY3VpL3JLYnhsSjE4aE1kSkRUV3AvRGJWVzF3?=
 =?utf-8?B?dUc3RFZKbkJ2Q2hWZjh3azhWazY2akx3dWYyZkdDa0VySGJKNnMwc3dVVC9h?=
 =?utf-8?B?dkwwZlpHcldQNEtqUER5V1BqY3Nxdjl6cUFnM0tZQ0tJNlhPZGI2Y1ZtU04x?=
 =?utf-8?B?YVFiZkpOUEFWRzRqNGFROFV4ZmNpMTh4QmY4aGVscEc5VVpqRmpjcXNpZkho?=
 =?utf-8?B?Z2NFVzJKRjdNSGlONHplOCtWQWlLUTBwNXB0em1oUDhyeTlRK1NGekdLRmtv?=
 =?utf-8?B?KzhhaXVKNlJLTHJqcVg4Z3F2N2RDNi9KaFdYSk9TU09vblFnRWtRKzZtV3Bs?=
 =?utf-8?B?eGQzdEdsb3E2N251OEZsekVLS1VOY3VBU25JSVhZQm9TWk5OTmRMZTVSRDcv?=
 =?utf-8?B?SmJMYm5JLzIreHplZXBOZzlBVC8rS04vdjdWdHpQdkIxUi9UZ2x5VVBhWDcx?=
 =?utf-8?B?OEpmejhKN3VOTVJ4VVNKRnBxdGhIdkFkb3VGUEFhVXdCL09VSndHcjFlRGQ1?=
 =?utf-8?B?Ykc2Y2QwTmJiZVgyL1R6RVViN3h3Rm9qVnVlZ2I4dHFqTGNRb2dkS3hJT0t0?=
 =?utf-8?B?c1BsOWtqWGZ4bFNCRzdFbC9QR1BFQkh1TjFicUFham9uKzFhZmZ1dTVFSE9V?=
 =?utf-8?B?OGRack1hakx0alR1WlJsbGZJWnI2aU9EY1AyMG9tQWJZS2JraUtZTnlEcHRP?=
 =?utf-8?B?TCtkbHc5d05BN2RvSUdGSWZGOXRLb0tJN1dteGJzUUlldUtOMzlXYXdDbkU3?=
 =?utf-8?B?eElueVFldjEyeGpjZmZDWk0xeDY2Q3dKK0g4QUNNSm5qQUx0ckM0WHNPUVZp?=
 =?utf-8?B?NEhncit1VWdOcUYxcnM1UTJaL1JpM1ZBb0xCOXV4eUdnWS92blZ1SHVzZmlh?=
 =?utf-8?B?V0xXb2V1RzdJL1JFbmgzQm9rTnhLc0crQ1RwREN5S2FSWjg2NWdFOHFEUHhO?=
 =?utf-8?B?cmh5M2hYODFjUUJoazhhb3NvK21icGtLZ2l0bU85QzZoVVp6RVlpQ3p6SHdZ?=
 =?utf-8?B?MW13YkZGZ0lQQ0Z6ODVjV2h0Zmc5T05Nb2d3Y1ZtMXlXWjl4L0o5MEEzeFVF?=
 =?utf-8?B?clN5U3JaQkRqWEdtVXFiNnBIMjdpVUREdHJHcGgzRVIvK3g0b3N6Unl1UkVP?=
 =?utf-8?B?T3VMRWVBazJMVE1SVW92TWRrTzdsS3pIVEdnT09mZmJzS3gyaitkN2ovT2Jl?=
 =?utf-8?B?VUl2Zjgrb2tjZmJ1WFBrd2VWQVJjSWplRzJVRWFuNzRYQ2lTamFBem1oeVha?=
 =?utf-8?B?a1NQbFBjMy9OelVKYjhmeHJGYzNoV1ZyTzhXeW1Gc3NUT3M5VTJ1bTFLSlB4?=
 =?utf-8?B?aEFOQnhEN0EvMmQ4Q0tUeWpWSnhxc0xueWZLeVJiQlh5dzgxMTBTclVBTGVV?=
 =?utf-8?B?VmVPcmgzNzBJNWtPcUN4NjZYZW0yaGR0aFlLSjNpWncrQXZWQkdpODhUQUl6?=
 =?utf-8?B?OUxDOHh4M2lYTmRNQnF1UkxNSnFneXZhcDJJNjBzNWVrL29FWjFGYTNVdDY5?=
 =?utf-8?B?aXZrd1BMa2xsQ2VVYlgzek9HNHkvUkNDM3JOQXhOZ2ZDMkZFajZTaEd2cHdC?=
 =?utf-8?B?N2Q4MTY2VWoyc0txRDY4Q0VSVUdnRG40bUNoWklkU0pWWWMvTXl3N0V0SDJi?=
 =?utf-8?B?RGJKL0dKbXJPNVpZOURGUmorQkZ1Yk1wc2dtcVlYNFBOSjltMnd1MkNNNHBh?=
 =?utf-8?B?WlduN2QwSFBHZ3dpa0c2MTBnTDNzU1orNTUrN2FYRXd0UlZjRmxSeCsrMUc0?=
 =?utf-8?B?WmhxY3piTzl4S3F0THZKZ0NOMjVjV1ZrSGdBMzNBUE9rRk5sb0xlWXI4MFZF?=
 =?utf-8?B?MHh3Y05MN0tISnc2V1BFdVNobkFyYmpVem9yTEJxeFFkdEw3TllOL2RUOXFQ?=
 =?utf-8?B?OU9rRlNWdzJ4SC81d25FaG9GYVU5Zit5MFNYdzJqSGtINFFRVm9qeWZnYjF4?=
 =?utf-8?B?ck5SVGF0K0FmUWtiWDJ2QUZXWDBiWXlQQTBoU0Y2aXdZTVZiOFJ5N0dicXA0?=
 =?utf-8?Q?XBaweY42zyo10QVYvF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde9f19-d347-4ea8-9ab4-08df4afa02f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:42:56.4124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXurZdOv2x8Z7SCnQBF6hG/Pbf0yHaoNNTVxQJB9PQ9rNaxjty33NEbt+nQB5cih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 11:26, Karol Wachowski wrote:
> The userptr dma-buf DMA maps the same sg_table on every map_dma_buf(),
> so a second mapping would overwrite the DMA addresses of the first one.
> It only works today because ivpu is the only importer.
> 
> Build a new sg_table from the pinned pages on each map instead.
> 
> Fixes: 57557964b582 ("accel/ivpu: Add support for userptr buffer objects")
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Stuffing an userptr into an DMA-buf is broken bejong repair in the first place and we just removed that from amdxdna as well, see patch "accel/amdxdna: Drop dma-buf wrapping for ubuf".

The only thing which saves you here is that you don't expose the resulting DMA-buf anywhere else, but I strongly suggest to remove the DMA-buf wrapping here as well.

Regards,
Christian.

> ---
> 
> Notes:
>     v2:
>     - Use the correct upstream sha in the Fixes: tag (Sashiko).
>     - v1: https://lore.kernel.org/r/20261123085935.623564-1-karol.wachowski@linux.intel.com
> 
>     Alistair, your DMA-buf mapping types series [1] noted this as a
>     pre-existing issue in "[PATCH v3 15/24] accel/ivpu: Convert the userptr
>     exporter to the SGT mapping type" [2]. With this patch applied first,
>     ivpu becomes an exporter that allocates a table per map, so its
>     conversion reduces to the same pattern as "[PATCH v3 07/24] dma-buf:
>     Convert exporters allocating a table per map to the SGT mapping type"
>     (e.g. amdxdna_ubuf), without the shared header copy.
>     
>     [1] https://lore.kernel.org/r/20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com
>     [2] https://lore.kernel.org/r/20261120-dma_mapping_type_v4-v3-15-c0183a409bdf@nvidia.com
> 
>  drivers/accel/ivpu/ivpu_gem_userptr.c | 65 ++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_gem_userptr.c b/drivers/accel/ivpu/ivpu_gem_userptr.c
> index 7cbf3a4cdc73..cfb2894b572d 100644
> --- a/drivers/accel/ivpu/ivpu_gem_userptr.c
> +++ b/drivers/accel/ivpu/ivpu_gem_userptr.c
> @@ -19,18 +19,39 @@
>  #include "ivpu_drv.h"
>  #include "ivpu_gem.h"
>  
> +struct ivpu_userptr {
> +	struct page **pages;
> +	unsigned long nr_pages;
> +};
> +
>  static struct sg_table *
>  ivpu_gem_userptr_dmabuf_map(struct dma_buf_attachment *attachment,
>  			    enum dma_data_direction direction)
>  {
> -	struct sg_table *sgt = attachment->dmabuf->priv;
> +	struct ivpu_userptr *userptr = attachment->dmabuf->priv;
> +	struct sg_table *sgt;
>  	int ret;
>  
> +	sgt = kmalloc_obj(*sgt);
> +	if (!sgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = sg_alloc_table_from_pages(sgt, userptr->pages, userptr->nr_pages, 0,
> +					attachment->dmabuf->size, GFP_KERNEL);
> +	if (ret)
> +		goto free_sgt;
> +
>  	ret = dma_map_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		goto free_table;
>  
>  	return sgt;
> +
> +free_table:
> +	sg_free_table(sgt);
> +free_sgt:
> +	kfree(sgt);
> +	return ERR_PTR(ret);
>  }
>  
>  static void ivpu_gem_userptr_dmabuf_unmap(struct dma_buf_attachment *attachment,
> @@ -38,21 +59,17 @@ static void ivpu_gem_userptr_dmabuf_unmap(struct dma_buf_attachment *attachment,
>  					  enum dma_data_direction direction)
>  {
>  	dma_unmap_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_free_table(sgt);
> +	kfree(sgt);
>  }
>  
>  static void ivpu_gem_userptr_dmabuf_release(struct dma_buf *dma_buf)
>  {
> -	struct sg_table *sgt = dma_buf->priv;
> -	struct sg_page_iter page_iter;
> -	struct page *page;
> -
> -	for_each_sgtable_page(sgt, &page_iter, 0) {
> -		page = sg_page_iter_page(&page_iter);
> -		unpin_user_page(page);
> -	}
> +	struct ivpu_userptr *userptr = dma_buf->priv;
>  
> -	sg_free_table(sgt);
> -	kfree(sgt);
> +	unpin_user_pages(userptr->pages, userptr->nr_pages);
> +	kvfree(userptr->pages);
> +	kfree(userptr);
>  }
>  
>  static const struct dma_buf_ops ivpu_gem_userptr_dmabuf_ops = {
> @@ -67,7 +84,7 @@ ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
>  {
>  	struct dma_buf_export_info exp_info = {};
>  	struct dma_buf *dma_buf;
> -	struct sg_table *sgt;
> +	struct ivpu_userptr *userptr;
>  	struct page **pages;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  	unsigned int gup_flags = FOLL_LONGTERM;
> @@ -94,39 +111,33 @@ ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
>  		goto unpin_pages;
>  	}
>  
> -	sgt = kmalloc_obj(*sgt);
> -	if (!sgt) {
> +	userptr = kmalloc_obj(*userptr);
> +	if (!userptr) {
>  		ret = -ENOMEM;
>  		goto unpin_pages;
>  	}
>  
> -	ret = sg_alloc_table_from_pages(sgt, pages, nr_pages, 0, size, GFP_KERNEL);
> -	if (ret) {
> -		ivpu_dbg(vdev, IOCTL, "Failed to create sg table: %d\n", ret);
> -		goto free_sgt;
> -	}
> +	userptr->pages = pages;
> +	userptr->nr_pages = nr_pages;
>  
>  	exp_info.exp_name = "ivpu_userptr_dmabuf";
>  	exp_info.owner = THIS_MODULE;
>  	exp_info.ops = &ivpu_gem_userptr_dmabuf_ops;
>  	exp_info.size = size;
>  	exp_info.flags = O_RDWR | O_CLOEXEC;
> -	exp_info.priv = sgt;
> +	exp_info.priv = userptr;
>  
>  	dma_buf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dma_buf)) {
>  		ret = PTR_ERR(dma_buf);
>  		ivpu_dbg(vdev, IOCTL, "Failed to export userptr dma-buf: %d\n", ret);
> -		goto free_sg_table;
> +		goto free_userptr;
>  	}
>  
> -	kvfree(pages);
>  	return dma_buf;
>  
> -free_sg_table:
> -	sg_free_table(sgt);
> -free_sgt:
> -	kfree(sgt);
> +free_userptr:
> +	kfree(userptr);
>  unpin_pages:
>  	for (i = 0; i < pinned; i++)
>  		unpin_user_page(pages[i]);
> 
> base-commit: 5ffdc8f8361387a1b11553e5c95cd589c67a51f2

