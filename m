Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160160A260E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gltsercH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C9B10FC6E;
	Wed, 28 Oct 2026 13:59:27 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BD810FC6E
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gi4oxw6XkO7bkdBCmuZwJdMCuZFonsBjLzRzCe8rYLWZvW9xoaoDZFcvs3cEAxaNAnXDG/14b/sn4rs1STYdEBzL1FgKc8X/nzO8e+9LdmwalIVJMCqGv1akcGNimfI2u5+Ktm1yfNaeNkkTgMierhQ8XmbABlPKFwKLNio/UICTNHfCMnqT5OU6W/PI4TwUn7s/z/6EMEsTS2V1rc1frr5zgQRtNLuGwhL0hRqxmgvrDmNjazgJpftlQ/0Ms7H4La0XHBZTplk6zbQC8q4J1HTGSRlaGAJDNCnY8wKqiSNle7jded7MTdzklVhN+lU57lnbpwK6jJkBZKOo1Kbz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfCcBfLLmO22SAY14xsz1EtmDRcxQUWN4mwOV1ROs84=;
 b=xGgbtaOx5D8eWNRnYkRJg/3Y2wDgzfxnzbrMN/gYjop//xTwAF0VzdtOWshxe+qMLI/YcE2KuXV0Ve14CEIMi6Yvp3GpL8NpQ+zx4J0y5OAHdsjVDESkTuKQQx8MontwkRri8AYjh2WWRFWFNetRig1iz4lsamH3L10MMGb34HAq01LxItexJ4a3Z/mZlKi+O7hQjyFdq8wAvMoyogBOXHVIzN80ZUu++MkhiYkpVomOkANGvJXAkrAfFtMiXPiSV2/Vm4nwAk/nlcn/6cYplMXSa+Sr8RmnwJVVDn0EYIRGOerlJ2BRnIu6MKk57G7sNpVugcEpdgCtaD5k4nER1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfCcBfLLmO22SAY14xsz1EtmDRcxQUWN4mwOV1ROs84=;
 b=gltsercHi1cSmKEnVk4aUmcS0Xm7lfTVKeCmHZrV4dd7eAXXJnkLBZ7OrKxXHlmgGSdicmVffWnBmv0WGBYcrrNBf3bfIZsbgXALdNIy6MuIIpPReWdt5kqbVKNkZkMAV+1okPP3JUIKEVU6qiCW+S5imXPDcysvcdeWg4C4wm8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 13:59:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:59:17 +0000
Message-ID: <4b49a7ab-efe2-4750-a917-cec4112916ca@amd.com>
Date: Wed, 28 Oct 2026 14:59:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] dma-buf: keep the DMA flags in the DMABUF_DEBUG
 copy
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <20261005064133.7305-2-kmehltretter@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261005064133.7305-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6cb29e-b198-492e-2c45-08df34fba7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|261026140227099003|4143699003|11063799006|56012099006|261021123027099003|261026121527099003|261009223027099003|261021121427099003|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fTlXPW68xloQybTPwuzP67VPBL4+JvYOw1lVxzVxCojCCg4Gt8CUpR0JSEHtVnfRC4k4sgHMc6lyPDUHEJi6hlykydBM68aLQCcwZdTQWOl0PtWePe0HITxmQGo5DYQHfrBJMYOVWj1opV0xQYpzIpeTWpts2AFx3gBWAzSDQC5A9nLTg6EbYHyvIyWKjWMUWBQCtkHdVL24SJO4LZEgby3dGt4nbgP8mQGP29cir1R1BpShBtrRaNgMeCVwSg7/dAXxU5HhiC6hgD/WMyPOyncgiW+5+/1Fy4V3iShj1qHXC8WA82zKDAQJ6N/dEceDZCIUxTDxdIJ2h4u0ZkeDEPqGs4QE0qXbaUOqZ9Bcv/0oxBr3LXMXcfeqqhYOSZKqVSqMBnHRIlN+QIFMkmMS4mYf0vH4ytL9uHvev8Wn4msKmZmveDFBb5q0nBekQ0tLzAbP3UgHOBCuK+Z83Cz6Z4a3gxzUIQ/3bd4+TyxMOi6K9W/7n4K8vZin312r5Oo96+sdv7Ca5feGmr4nru2/oj5dZ2/PoN4gPg9LSt6iaO3Q/7G36CIyYZYQoB7/IPtkR1I2YnuevvJp/SHcA0RdvrXmU8kmyOfJnPe9S6xUaVqEXc1ia+Yw5jL1D5S1Md6Y4Cxszq98dFaMktCUZ3rCMbvUqVbkCMIyB4zPPcw1jAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(261026140227099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261026121527099003)(261009223027099003)(261021121427099003)(10067099003)(261022105027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3lpSFI1QzdraGV0Y3RHcW5udGRROXM5TEJRa0dUNjB2aEFteHdIOVdWRWxS?=
 =?utf-8?B?V3pwWDJmYklnUFRTaUZTdklGL2FBVzE0MEpkL3ZrdkwvZWl0bU9FSEQ2M01D?=
 =?utf-8?B?UFNGcnVIMlFBbTMxVmJKZVg0S1pVMGFkR0k0U1A3SkpPd2grQ0ZjeEtIV2lt?=
 =?utf-8?B?VDRTTk4rOCtPZzlaeXFQYkhzRm5PdHQzbnlzaEk3UnJqejBzSVVXSzE1OHY4?=
 =?utf-8?B?Skt3cVVveWZQQzJGajMrbWlxVTRobC81ZEhNMExGZjVYbEJRb3dvRDljeWNk?=
 =?utf-8?B?bjZZRGwzTExWMkhMbW1iSW5ZcEplL2I1NmdvZmtCZ0VHWFE4Z3hXQi9zQkNu?=
 =?utf-8?B?SlFYc0N4NnZBNnp4bnZhWWFXRWw3VVVxdkhJSmFIeEVXaU01bVd3cWlEdmpW?=
 =?utf-8?B?Y0poNWZoVmRJaFc3L1Z0QXEzTVFLL2FmUzBKd1BKSU9HQVA4aG1jbUpWQTd6?=
 =?utf-8?B?S29JSyszTEdrQjh6c3EwcEZnSnpMc0NxWmlPTndMSHpvVGFBMVFaWkNEUWhk?=
 =?utf-8?B?Ynk4a04zS1duUnpmRlFjcHZPNnV6aUJkdWY3UUxnZGFOSHFhOEJUc1l3QmhR?=
 =?utf-8?B?SzE4OERRTHVLbFVQbEVyejVvWWtQbjRhQnc3SjNMVGpqUU1ENkZ2VzE3M2VY?=
 =?utf-8?B?Z0xRdER6R3IyOXhVRHhTR29aNG9taVVlaEl3dzM4YWhaWDUraXVONzRBclpi?=
 =?utf-8?B?SFBHZEJzMEJUcmlRMFNSNWY2SG9nSGRKNlJMdGRWUlJuTExWeEMvQnhUUDdU?=
 =?utf-8?B?RWxDQ3g3TVpMZ1lveWdidmVoMkFETjE3VjZWdlg3dnc4S1JZRmFqQUEzcXNk?=
 =?utf-8?B?VitMOVpzS3ZhcDJKL3ViYXQ0RnhjUXF2YUNPRy9VK2dGTkl6MUhFVVVyekxk?=
 =?utf-8?B?VjVnZFZSdGVkMmNkNHIwajBqRUN5OW9VNFhESUhHS0E5N2NaWkFOd01iTnhV?=
 =?utf-8?B?RjUzeE8xT3k3NXZLRGplbUpiMlVua0hkTklEQnRqamxUR2FtMEZqczk4MHBv?=
 =?utf-8?B?Vnc1NFpGUjVJM1RQNis3VW43cGJQZVpGS043UVF1c2YzZUx3ajBjdGFyb2I0?=
 =?utf-8?B?MEE4U1A3UmdGeVhrWDA5ZkJ1V280YWt2WmFjUjUrNG5wdFZuV3VVTWczcEtC?=
 =?utf-8?B?dVZOb0lZUDdXK3NKTlhJVy9YQ29INExDYjVXYVAxWWNtMUpPWWZkZU5JSkZo?=
 =?utf-8?B?cG93djFvbkJBeGNub3ZtSGhnalNOUitvZXNadDhyc2NlcjNFSjNRT01QYUxa?=
 =?utf-8?B?dUlWK0V6T3dMdkptdkN5Z3BmT2FLaVJsSENDWWdGNXdlTWtWZGpZTUlYTlZN?=
 =?utf-8?B?SmkycW1tM3FwMjJ4R2plYmVRU0JqUXNkZ0FBK21mYnRNeGVLSmZGanBsNlpO?=
 =?utf-8?B?UDBZNkNJN2Z2NzY3UC9TTGhkRldyT09KNjhJVkIzb1hWV2s5MTh1d2puOEkv?=
 =?utf-8?B?TkNoNStxOTF6ZmhyQm5naWFCZ1NMRVZJV0ZnTHB2WnIxREx1V2VMT2hvVFJ3?=
 =?utf-8?B?dnJxUitvZURkZFlSMlhHTUtPNFAvRGh4WnlsbVQ0ZDFsRExNSVpyNUlQbm5J?=
 =?utf-8?B?YU5XU0FsbG1PcnJwZXMvRGxJVGIyWXZUSWEyWkpLdWZVU3lERGpKaHAxYWZH?=
 =?utf-8?B?bFNCbGZ3WGQ3QnIralFQMkNKdjJMb2ZrWU0wSWlFTVZML3VCYzhJQTdZY1h3?=
 =?utf-8?B?TnBNU3hXVmpNNXRKNjJraFU1b2pwM3NoQXdEbTZwaEZRU2NmVTBvekN3cXln?=
 =?utf-8?B?UVRHM3dxVUJKaWJIQmNMZEwzcC9hbkJ2U0lVTXZXS01aYnl6VmF6RlpTOUQ1?=
 =?utf-8?B?MGQ5K2RSRFdidmpYWTNENFRReStMelljK3ArNUhjSUNTZU1TTHZic203OWVx?=
 =?utf-8?B?Z2ZEbUU1WlBqSGVZVDR1LzdBMlJWSndhOWNOQ0tJUE56dFNpYmljTlY1dThC?=
 =?utf-8?B?VVkzbmdiTVJJaFZONDU4VW1iQVBwTHF0YTdOMFVpTENJS1dkV3VqQXdIcTZm?=
 =?utf-8?B?eW00SXFsajhKMnIwcUdKSjNCZUdLdE5WVGh4ZCs2alJPeUd0UjR6eCsxR2Qx?=
 =?utf-8?B?M2JrMmVxYUN6MEgzY2YzeWprenVxZ0kxcVltQlpzOTRDemYwaWtjWTJQdWpO?=
 =?utf-8?B?TTE1elluSnp4UFdrSzdhZGtaSXJXRVBlK3h5Ty9CK3N1alNWZDVSL2s1Vk9H?=
 =?utf-8?B?SlFwTDhkcE1INHJUcStQWVUydTJtNEYwR0xOM2FPWG5MUStIUjk1cFFBSTFT?=
 =?utf-8?B?ZENMK0k2Q3hrSi9NS0pVQnppcjBHZUFHamY1UmQ2bUhGUE1NWEhhL0M5NXZV?=
 =?utf-8?Q?Wold6EyMreW1gtPPMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6cb29e-b198-492e-2c45-08df34fba7ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:59:17.2314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCfY+T0vBSut8tNwvAJRIQJzueMdMztti0kx6YMLpMOrfr3ADgVrTtT1Ca1wA/0Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/5/26 08:41, Karl Mehltretter wrote:
> With DMABUF_DEBUG, dma_buf_map_attachment() hands the importer a copy
> of the sg_table that keeps only sg_dma_address() and sg_dma_len(). The
> dma_flags (SG_DMA_BUS_ADDRESS, SG_DMA_SWIOTLB) are dropped.
> 
> The flags describe the DMA side of an entry, which is the side
> importers may use. Copy them as well.
> 
> This is not a bug fix. No importer reads the flags today. Their only
> readers are dma-iommu, dma-direct and iommu_map_sg(), which are not
> supposed to see an importer's copy at all. The warn mode added in the
> next patch keeps its marker in dma_flags and lets importers that do
> get there continue. They should then see the same flags as without
> DMABUF_DEBUG.
> 
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

I've reviewed the patch and pushed it to drm-misc-fixes.

Sorry for the delay,
Christian.

> ---
> 
> Notes:
>     Built alone on x86_64 with NEED_SG_DMA_FLAGS=y (dma-buf.o, W=1). The
>     KUnit test in patch 3 checks the flags in the copy. It passes on x86_64
>     under QEMU in strict and in warn mode.
> 
>  drivers/dma-buf/dma-buf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef..b3d311acb883 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -904,6 +904,10 @@ static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
>  		sg_assign_page(to_sg, NULL);
>  		sg_dma_address(to_sg) = sg_dma_address(from_sg);
>  		sg_dma_len(to_sg) = sg_dma_len(from_sg);
> +#ifdef CONFIG_NEED_SG_DMA_FLAGS
> +		/* the flags describe the DMA side, e.g. SG_DMA_BUS_ADDRESS */
> +		to_sg->dma_flags = from_sg->dma_flags;
> +#endif
>  		to_sg = sg_next(to_sg);
>  	}
>  

