Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE96CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C559C112153;
	Fri,  9 Oct 2026 13:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="imqOq2YW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B17112153
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFfk/ItdoBHcVS8jKIuelHU8yQqLEFZr+JwoMmB+gjmXZhtCW+M5DmkHHDWZAxa471duYMfcVBoc2DRY0kBRpkoOPdQX1d+cff/fuwf2nl3dOp4oosPZ8l3whTTGc4cS4aFlDMO5YlF8BMvohD16GhVMPEBPE+vYwm/8yJCQsFwcKmjbcdc8FMkMrAKNVne6X9uJYzp49C4IH0m8ANIynU3RsVLQRQPljKNHH/E/pCbPdNoaN/tbPfHcGLGbMSEdcXnk5OJohaAA+K69QUCJjG4VxbfUBgm8KZFrOdNdEiRywaco0dKSd0bEsN1r1kAwkRdSnsrnI+osPy91w+ayBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCuJvZv4wBDn/SHbwVVFdrJYd8e/49U3WMllMyF91wU=;
 b=Dz9HII51/Vgvd/X3k11BgOkpNoLkxghirGDmjP53qaEkkm+veaqZA17etz2zE1Bo/g6pcLb58JK11vWw86SvUzAZTToU2wrXWm2G48sw05eaMsddkJ5JWMSJFbJcW6pRfjMT5hthmwVLjEkMWdRlxZMVuWrh0i9nH/1vZL3nXcIGBotWW7wTTQQ3pe8ZCI+To1uxb6IRNeEDR8W+sBqk4cC44HHd0squCHlFL6Hhhq0Lz12bHWKbNPfIqVKjbuuAlOPtpugLMAtV96MpCHDZzKk/wSh1Y0Q19bewEdNVkKeFKEwqgQlT/aaVbezo9/990qYO8ADXLQazKtYYwtZI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCuJvZv4wBDn/SHbwVVFdrJYd8e/49U3WMllMyF91wU=;
 b=imqOq2YWK+ab3qAiggJtPOY6uGZsDmUT8UMk8G8oN/83s+fwVU5Q++1e3J5EUcMVBq/re3eCC17MlVsgnRvv0tIvijnpvtHmkKsM0gDZ+URAkPoSP5FWGFkoov+d63Nc7jae1CWYtALAWKajEtxwoZMBn00HvzYS9tJoYx+FlcE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 13:29:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 13:29:53 +0000
Message-ID: <087adac1-7d85-492b-a46c-47a6072314c4@amd.com>
Date: Fri, 9 Oct 2026 15:29:48 +0200
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
X-ClientProxiedBy: MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: cc71c830-8b84-4fdc-34fc-08df260966a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +TUvWi5Jnux6wBNAltZ2pb2ipTDa8PEMySAoEFne0uEIDNMM67uW7tYHhZb0auDD7GNK1UFknHmOKXrwJrCxRLWu8sxbERPLjLRU6kMCpXYRvwDmfyaMhHf+VZ1maxwu9bfdBfgRj09ervF3rlFs9/tCVwQ9ug+oCCbKAn/bZ5W7QDM8BqmfPI4kXec5Zz1k/r3ntMOAPxSSDgTX0qn+BvV4xt6ZA9ddT309hh95eZKxx1h/2Vs5wP8hofrZ/xVchjt9ecK29FMazdWF9F9apcpjvYzQdUHGNU5BFZ9W6I/BcDtaaFudF5CVV7VOddDg6CVyJcr2Vh2P8HbXA7igu0QrjprBYP/418SYGFbkMaR0jL02CanQq4qJ85tz89ZNDqFpg7FEwfydPRhYutUM6enuB+qxnyAthHj3CGjcd7B3YkQhEstxI3Q1ioyJZWFeGgqMtXlJ83EFxYOtYXc/AEfKaZyNBnQxqk37to2sXpEajb3EUU+fQ+jCL1LImbrZ3kxKEtSi8ORo8gqKOqngoadMRTg85RvCzzBcQFmryznVbVVP+3eacy2gknL7AFWDQ/bFJ71YlOEYEne7v+FcJFJ7wE+VnNm9CbWP/Cfq/MXbUXe7hsx2aSJu2xxkGeRJQsR5AO8Po6BkFlmGYTf4Rp0n2JuoDUMXB5poZj5/d6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmhXRVNMTW41WFc2cG05YWJhTmFnNCtiNklmaTg5My9kdklOS2NuTjR2S3Vo?=
 =?utf-8?B?NEZzRE42ZklMWllaZnBLMm5najA3TEw1TEZPK0lEdVdpYjZFMmQzSEhUS0ZL?=
 =?utf-8?B?TW9OQW9nN09TSzdGbHV0TnZBekF4L1JDcEQxVFRSREtOcDFucERORUY3VUhi?=
 =?utf-8?B?MzNMWllkVkNRdHA5LzgrVDRrelJ2QlREakdOZ3pKWndyUWtteStBb2ZYWWQr?=
 =?utf-8?B?aXJzbTZKaDA1blJBVko4OGlSY1lDRzJtd2xoWGpXcisybnFTd1FOY0ExOG8w?=
 =?utf-8?B?QWZURlQ2YzhsOVJ6VCtNbWdiUEZVeUxmOFppYmh4QVBONElYc3FlTDcvNkV2?=
 =?utf-8?B?QzFaSTN4SkJhYzU5bmZEdm1ralN0aHNISi9IcjFRR013VC9aUTNZQ0x6dE5X?=
 =?utf-8?B?bERHWU9KUlBxUlMrZXp2SFhBK0FSQTZLUU1oVjJOYXFlZzVreXZYZ3I1OStC?=
 =?utf-8?B?eTE5U1ptR3MvNXNOalJGSEk3dU5adHJqWkkxQjJEcjhpOFhVOU9QZWRzNWdi?=
 =?utf-8?B?YndEZTZsUmVObmJyRmRrR0Zrclp2Uitya0NCMU1RNGZwQ0dSNThldFQ0UWtr?=
 =?utf-8?B?SFF0ejlGTkcxKzV6K0RFUjBlOUxIajN1R2dmaWhzejhGc0tmSnAwZnZiMHJj?=
 =?utf-8?B?OGxrUnhmV0pROU5XQzA4TUtlZndyY1JJQnNXY05NNjlzNDhrT3pjZGtOYm1m?=
 =?utf-8?B?cEo1NWpZYnRzTHBySVJWWmhySCtoNTNsNlRTd0RPWkRHdUJrSEZIcmJKMnps?=
 =?utf-8?B?SU9qWlBFZGd6SHdxeVdMMWcrSmF0azdCN1J6ZkI1NjlOYmhXQVNzTWY3cmNn?=
 =?utf-8?B?MHNSZXZaQjdvM2pEclVKSjYySXo0b1MweVhtV1ByNXZteUdpdHRLMy9lMzNP?=
 =?utf-8?B?MFFadzJFc0dhOHNnN1hvOGZ0aTJFTnJxeVNVb0RVcDZYdEFETDUvSVhIZ3Nm?=
 =?utf-8?B?eHVxSXhkTTM3MzYzZy9zZm5wS0xGV3BWdHVqNGp0M2FRaEpZNmdJeHM0RzVo?=
 =?utf-8?B?d1dWOE5Cd0Jnak1KKzFldXZLbmFvUjhpbmhGMnhSL0h3OEJaeXFzZHU0SDR2?=
 =?utf-8?B?WHE1YmFFVytnbzB2bUcvTUxRbmhHUTYwbGRpcmgwM3g0aGl6dTUyZUtxRTRa?=
 =?utf-8?B?aTRESTVHZGVVWWtrcVhheERLY1IwWE5hSy9MSmFGRWh0UFdJN2dMb0R0aU8v?=
 =?utf-8?B?eDRMeW9xSnBvOWVRVytXT1k4T0hwM3lxRFJZbC93S0RGTXZoZTVhTEZjMklT?=
 =?utf-8?B?RElUUGdhSjkvWTVadmxoN3pwbm5TbVVmZW5Jb1FMK2FWczBPL0xKV3llQ2h4?=
 =?utf-8?B?bEhSMmhxeGtqVHBXQjVLd1lESkZnSWtrRStTUGdLNzhrUmhqSlgzYVRrQXdV?=
 =?utf-8?B?VmljMTIwS3ZoNlRINHlwQ3VISnJUQ1lNWUdXNzhXWHlCcmtLWVMxeTJaWXBC?=
 =?utf-8?B?U1N5clY5VGhvWkRhQlpGcWQ5OVNwdEdyZXhESmJhdldGS1lPUWxlZmJucWtj?=
 =?utf-8?B?K0Y1MHd0SjJ4NHNwQnNjR1VhNlNrUlpBMkxMT1VLSkVCblBhSVFKUWxSOExC?=
 =?utf-8?B?RnBGcmhKNWFBbENuYlVUNFdyc0lsdDg5M0hrNkNZU2ZHUm5tdy9jdHZxZjJ4?=
 =?utf-8?B?UnpCQlhhM0JjRS9JVkNMRlV4UGliNW5PYi9DbzRlZm9pRkZFRVV6dTZSU0xq?=
 =?utf-8?B?aXhqRUp5U2g3YmUrWUtsLzN6cFRZUElZVnVSNSsxVWk3UEp0d2wyNHhaZW56?=
 =?utf-8?B?VWhzb3Vtbll5TURydDFvcGFwMk9rK3ZCTDg5MkpiWjQwTmY4QUNpdXFIdTlK?=
 =?utf-8?B?RUdXY0ZHVzN6Qlk1bEZoRXZEMm4xTnkxcnVkZ3gvWmFzYkllbE1EN0ZyQW9L?=
 =?utf-8?B?R2hBMjRoVzVFN1RoUUhXVUhDSkIrSXBQZmpSWkxDb2llTGJXb1FQQXd5aXQ2?=
 =?utf-8?B?bHBieURVaEhIYVdDa085cmo5SGlSVFRjVVpQSzA0azJ4VDJNZE93UElUaU5q?=
 =?utf-8?B?VW9HSnhDTkJEV09NOHdHNWFTOS9lYTM2Q25KT0w0a3JVajVodm5XSnFiRU90?=
 =?utf-8?B?bHg4SGxXU2pVZzd4by9yK2loTGEwYW42N3AxZExzVTV3dUlqdFl6N3d0RS84?=
 =?utf-8?B?ckZOczJXeVBZdkNIbVlqbnF6eUJxUVFNOERpUDg4TTl1ZDRyaXJMVU4vVFpW?=
 =?utf-8?B?Y0k0UWMwL1h5MXhQNlNObVIwZ29OV2c1bVVnem1EOUlBQzNNQTY4UmZEUXFK?=
 =?utf-8?B?K05WSjk5OW43SU1tL29PUlowSEN3dW00Vlc5bnprUzBLdnRFMGNhdkdZem8r?=
 =?utf-8?Q?4Xmybpbp+ny9Fzjnzt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc71c830-8b84-4fdc-34fc-08df260966a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 13:29:53.0255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvY07CLZP0XQMZ4U/0baFDAftTbjGd9gJa27EN2zwMwyeYcl2yv0u9VRNXb2ag8E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915
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

We should probably have a WARN_ON_ONCE(sg_dma_is_swiotlb(from_sg)) here as well since some importers/exporters doesn't realize that this combination will usually not work.

Apart from that looks good to me.

Regards,
Christian.

> +#endif
>  		to_sg = sg_next(to_sg);
>  	}
>  

