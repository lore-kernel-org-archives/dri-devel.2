Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B892FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 17:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BCA10E137;
	Tue,  5 May 2026 17:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ALmoEyP";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E513410E137
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 17:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ8s94ymuPL1T2PYiedZu8Z8yQ1Yf3FXlmybdGE4jXJwcG4zyvydqlybPvX/A+W8RKioKSevbsEd41PQ+ABBTxlBgLYuMu4I6vNYEWQchAGhMkJMn8sjWeCm7ykIpslIMfkoB7nyxVisL6QNFqPo48fnNLaB/SSA7BxWeFp9dgbB5pw0Q6ynTYrM6DLvmsFBWZbr+IMemmtcakJyHNBSoxqAKkeovlhhCjmnK5ZA+XYTcVgxciKaiG6fYeC3/ArcPXBlbJ6MMim8XlpSNqbIFL89DugpWZKZgqSYyz3T8DqbX0IpicryWd7VwJgi6cJEI3s8qruTBB6BJjJTuwzg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nER72K1jAbrGqSvb3B1n8g6VDrEtMDCGp55CYDDE0Jk=;
 b=ctgPwoVC1DD3yWwdrNHRIvlCjSqUjGk/GApfWIxHWVntNF5HmWcAcnnsSD1iDTOTtIWknyV/IaQ0dnZpF2YIkHizmIAcQiYRbqaOXG3Z55cXw6eZh/k126iictAaLpKkWLO9A9xdMFqf6Bpl2h4/yAgqo7sHOsLoFxnKPjx3hSvZeb1rbCodYcqKEz+Oy23W2yHcEuQ0w4ILGLKaVIdYbalF1Cuy6e7vDHuyRo3dStCl7wLnmDm170Y/PL8h+LIjewiExU3gws5Qw/r14SvX96PM887//R2AmtTnZUJ82eDSfuWS6Mkr7Lg53S2f6XKGsEJZOTtAXSfWvf71h/BwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nER72K1jAbrGqSvb3B1n8g6VDrEtMDCGp55CYDDE0Jk=;
 b=4ALmoEyPc09biFLGijl+63QVvcPiw/hWG4F+oclYmAlT6MjWCaRF8E0uydaFLWSaBsM/go0BK1JEBlQuhTGOxZPxX33+P7cj6q8h9hN9s37zUzSiABI1gWGLuD8bYlU+RZYdhcZtKljUwE7OEtkzqDVLDvl1GpHRbFO1+ett5mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:14:48 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 17:14:48 +0000
Message-ID: <0399e649-4759-412e-b89c-4759d1469fad@amd.com>
Date: Tue, 5 May 2026 12:14:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 5/6] accel/amdxdna: Add AIE4 metadata query support
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
 <20260505160936.3917732-6-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260505160936.3917732-6-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0548.namprd03.prod.outlook.com
 (2603:10b6:408:138::13) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d10f6c7-697d-4942-b493-08deaac9cfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WK6zAdHuJ2eNavObNdKT/QARcXM3PdFihc61XUQ51mrvf/lHIL5isnWQFbtbv9tx8DPkopzUgdfe+GXriOUhFafxKskHtRAzPofvjlJaVflom8RtrfdQq3TRnvNOXN0EL0xG3NfGoS6A3TCCjjA2nLy5SJJeaBS9jwyA4W6mxzbnmIRDCBHldi8ITpI2HSyssGhvYIO5jOFDH4ngAcHnBcuCbsvXDPZ+yyYFR4P+kR5YrITpRPngQd1Ce1DLWDzGJEiDI+yZa0NwH9MErlHlJYjjpbigdyRXqX00vs7J1fzMhK/uUsTs5lGoj2yiHgulGC70TbfN21VXAYRi/GP1yUuLstEmQEaI+Idt2XbIlNFZ3MiWsyq1W5qThTkxBLjksyZ7ggXiVHrSv7vRmC4l1HWsY+Hwa3yMUsN9RHqtuqlnPVsMpovE2pKSel1ZeVxThvJN9icmY5XQzO2PxOdbBWK+83a77Sk6NimEZyFTyI0v+M212eSai4Y86EVLgXWfxX8g4mZpUje4rDefCv/OcFk0HtQtNgKwZtvnUACPiNIwHyJ97On4pK/9GPABUknjQHZ+PGHy8APawWdlqT40bX2ACdgOPsAC6RDMUmZPiz1oeTTvAchbBOmH00Wl6rY07XA0WiCVgqO/wJzIHC6P5ipQ2b6Ezuzr+AtatN1sOQRlzQScC4lZ1wPY1McnjDjz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnlPellPcTI3VXBEUWQ2Z2d2VTQ3Rk1ZSHVsMlZsNGhPUnoyakNGeUE3clBx?=
 =?utf-8?B?RnRsQjBMZjYxVnBYRWptZFdXUGNvaHhnMHlhTTVNMkFHdG5ZZFdReTZhbFdz?=
 =?utf-8?B?RWNjN3pSY1hQTHMvR0FOUEZ5VDcxOUpXelJwcm9TRU5VSnZaRUxXbDRpNzlr?=
 =?utf-8?B?K0tRYTlteEN4b1BJS3NLSUtOaDRIZFpOdzZPNTY3N0V1ajNoemFxaWN1eGNt?=
 =?utf-8?B?LzU5Z0s4b2J1NmxSY2RiV3BocjAxZzJ4Q0FuelBtYVA3K01PV0hjWE9tSlJo?=
 =?utf-8?B?ZEpWc3pFZ3pleXE0TWVKVy9RblpEeXNsamo5REZZZVUrSWp6VG1vVklJUk9G?=
 =?utf-8?B?dnRHeXJpQ2drbTJ5cUtCSDlnSjEvOE5OejlOSXpQZThsOFZGMWVZTjU4ZWJE?=
 =?utf-8?B?dWJacGcyWldaNmFWTmN5dTNYT08zWmFjbWJhODRaTVFNRzNkYnVzOEkrOEp4?=
 =?utf-8?B?dVgwQ1UwbnZFT1RRcDJBZW1sT2lJcnMwMFpsNHFDZmNFTE1VU050OS9LY0Nm?=
 =?utf-8?B?ZUxmSnRxZUF0VzdaRkVmY3dZc1ludHNtQW5ZdEtNTi9IUlJXWkRyZHR5YVZs?=
 =?utf-8?B?Y3lPTXQ5S0N6Z3BkOThVY1NoZUgvUlM1blFaR1VhcU9WNGpLUW85N1JZbDNn?=
 =?utf-8?B?MksxQ3NwRXo5MHUvTVluaXBuWlhtNGpaRThsMWtnOU9qK2RNSmtaQUlGYmhY?=
 =?utf-8?B?S2Y5YUl0S0lyckpoQWhmYUJFL0RHL1AyaytBclVleUZUdWZxNWt1Z0lCTG9Z?=
 =?utf-8?B?bEJSU0ZYc1NCTkpFZXExbFhaSE5KeTYrN1ZYRXlWK1JPN2xpU09pUXRwYi9X?=
 =?utf-8?B?NUxYZHZLNDJCK0Z3SDltaE4xNTFBMkxyVzhWTlp6bDF1bDFSYTh2cE5ZblVR?=
 =?utf-8?B?cXJmczF5K1ZxUGs5M3RiSGtLWmpURVIxOG1Jam5nU1hyZzQ1cjhVekJ6RDNP?=
 =?utf-8?B?T29wTkhiY3VIOE01Uk5sME90RWpCd3UzbkxnUkZ3ZVZqSlQySWRCUGtnMFVS?=
 =?utf-8?B?aWdSUWRreVhGS2lnb0ZhNWdXMDRZQnpGYU14TElYUFIwenlGbytnQ0E5ZWRt?=
 =?utf-8?B?RHhMNW1ReXAweTZxVXA4UEVjdnUrcjRTNTZtRjc5ZHNNcWlsMlNYS3kyMjNs?=
 =?utf-8?B?M2hmbGxYM3FGMXRnU001MTdwSERhRWdQZTFSVlByL3YrY1o1UW1TTFgxRkNk?=
 =?utf-8?B?Z1F3Z0xXclJQWVNSZHBVc3Vzc294WENaakFuamhKMTNOcVVTWWxpdGlENzkr?=
 =?utf-8?B?VWNublRBa1VMRWVSLzNGWVY4bTlUR2FnSUNpRURqYStieHdSejZVTWg1cExn?=
 =?utf-8?B?ZTRlWkc1Yy94THZlOElzZXlzUURBdENMNTdJNW9INkp6WFhhcjdTUVF6MGk1?=
 =?utf-8?B?dHNaU2ZyUThjVnNQMk9GOVZzazdSNHhPYXUvZ05lS1U3Rm0zbE5yRWRHTzRT?=
 =?utf-8?B?aCt4eXhyekxXVEsxejljaWJuN0t3Vm9xZlhHY05leFV1dTZnZlg1WGIzVThB?=
 =?utf-8?B?ajRTRzgzdHN5U2o3Y0NFaGs1Y3M0ZVpXODRzNTBzYXhmOEsxajVMVGlhWUxl?=
 =?utf-8?B?WGhJemVzdzJ4Q1pMZ2QvVmZlbDNaMVJYMWFONC95NEJZcHViVGRCUEkrYzk2?=
 =?utf-8?B?TXlXV0hDaXEvK0VNZy96NFNJZXhIc245Rk9QTmFpMWVaVXdIaXRUc2lmTWJn?=
 =?utf-8?B?K01LOFByYXBEdW80NjRXUVRRZEFtSHREZnozQ3RLOXh4MDNZZ1IvWXFWTnMy?=
 =?utf-8?B?bzVYd1NzZjFXa1A2NVRtcTJGTmx6UEJvTVdxeGk0MmJ3Rk5ZNWxzK0wyZ25G?=
 =?utf-8?B?M2ZWMFlxa3FtMGpzSzVOQkxsN2VsNUdDMzl4bG5uSnFRaDgrcG5LSU51MUZa?=
 =?utf-8?B?eWc5TWVCajZxZHY1TG81NUEyTzRZdVNBQ0duOTdSZU9ZRDc0NUVQSUdGa3Np?=
 =?utf-8?B?VWVqdUhoVEFkSUgvUkZ3d05rdW1Wb2pmbCtnWnZ4Z1NwSzZXZVpRSTlxTVpB?=
 =?utf-8?B?MXMrU3VkUkl2K043YXR5aUN4OTI0NFhGTjd2aWd0Nm1uN1hpbG5NRExRajJF?=
 =?utf-8?B?bkNxYkc1T1NKbHNsMElKMnh6TjE0ZEYwa0JYZzZIK28zUXM2NkFWYjFNTmRC?=
 =?utf-8?B?RnBySURGMTZ3SE9vdjNUUEFGRE1IQ1FZTDZMc0VYZjNscEExeVJYSWN1OXRP?=
 =?utf-8?B?OFZzMjk0L2ZGaFJZOHBwY1FUNkRZNit1Ly9aRlVId2JmaitGdFdTbG9FZ1Zv?=
 =?utf-8?B?NlVZR25lNFVVRkJjdHdXdnhsOVhxYktqbHB0WFlMSkVxU3NvMVN5cjFMd241?=
 =?utf-8?B?TytnQkNEM1lta29DN1NIUmZHSVNBaGxCSTBtbXNoc1BwaWJVTE5ZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d10f6c7-697d-4942-b493-08deaac9cfd2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:14:48.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY0oxnbxI3ZdXBq+rAv2mO5YPCS/TmIGycoXGUMZfLw0Rfm8NiA3gynFayJvEoSNNoJ3Una/FaeVeq/MrXNmyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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



On 5/5/26 11:09, Lizhi Hou wrote:
> From: David Zhang <yidong.zhang@amd.com>
> 
> Add support for querying device metadata on AIE4 via a mailbox message.
> Refactor aie2_get_aie_metadata() into a common helper by moving it to
> aie.c and renaming it to amdxdna_get_metadata(), allowing both AIE2
> and AIE4 to reuse the implementation.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie.c           | 45 ++++++++++++++++++++++
>   drivers/accel/amdxdna/aie.h           | 27 ++++++++++++++
>   drivers/accel/amdxdna/aie2_ctx.c      |  4 +-
>   drivers/accel/amdxdna/aie2_message.c  |  2 +-
>   drivers/accel/amdxdna/aie2_pci.c      | 54 ++-------------------------
>   drivers/accel/amdxdna/aie2_pci.h      | 24 ------------
>   drivers/accel/amdxdna/aie4_message.c  | 37 ++++++++++++++++++
>   drivers/accel/amdxdna/aie4_msg_priv.h | 34 +++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.c      | 30 +++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h      |  1 +
>   10 files changed, 181 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie.c b/drivers/accel/amdxdna/aie.c
> index 66849ba9026a..a31051cc1ec8 100644
> --- a/drivers/accel/amdxdna/aie.c
> +++ b/drivers/accel/amdxdna/aie.c
> @@ -117,3 +117,48 @@ void amdxdna_vbnv_init(struct amdxdna_dev *xdna)
>   
>   	amdxdna_update_vbnv(xdna, info->rev_vbnv_tbl, rev);
>   }
> +
> +int amdxdna_get_metadata(struct aie_device *aie,
> +			 struct amdxdna_client *client,
> +			 struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_drm_query_aie_metadata *meta;
> +	int ret = 0;
> +	u32 buf_sz;
> +
> +	meta = kzalloc_obj(*meta);
> +	if (!meta)
> +		return -ENOMEM;
> +
> +	meta->col_size = aie->metadata.size;
> +	meta->cols = aie->metadata.cols;
> +	meta->rows = aie->metadata.rows;
> +
> +	meta->version.major = aie->metadata.version.major;
> +	meta->version.minor = aie->metadata.version.minor;
> +
> +	meta->core.row_count = aie->metadata.core.row_count;
> +	meta->core.row_start = aie->metadata.core.row_start;
> +	meta->core.dma_channel_count = aie->metadata.core.dma_channel_count;
> +	meta->core.lock_count = aie->metadata.core.lock_count;
> +	meta->core.event_reg_count = aie->metadata.core.event_reg_count;
> +
> +	meta->mem.row_count = aie->metadata.mem.row_count;
> +	meta->mem.row_start = aie->metadata.mem.row_start;
> +	meta->mem.dma_channel_count = aie->metadata.mem.dma_channel_count;
> +	meta->mem.lock_count = aie->metadata.mem.lock_count;
> +	meta->mem.event_reg_count = aie->metadata.mem.event_reg_count;
> +
> +	meta->shim.row_count = aie->metadata.shim.row_count;
> +	meta->shim.row_start = aie->metadata.shim.row_start;
> +	meta->shim.dma_channel_count = aie->metadata.shim.dma_channel_count;
> +	meta->shim.lock_count = aie->metadata.shim.lock_count;
> +	meta->shim.event_reg_count = aie->metadata.shim.event_reg_count;

Looking at the code the structures for

struct amdxdna_drm_query_aie_metadata
and
struct aie_metadata

Look identical.  Rather than copying every member, can you just use copy 
everything from aie->metadata to args->buffer directly?

That could let you save the kzalloc/kfree call.


> +
> +	buf_sz = min(args->buffer_size, sizeof(*meta));
> +	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
> +		ret = -EFAULT;
> +
> +	kfree(meta);
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie.h b/drivers/accel/amdxdna/aie.h
> index 7a68b114f235..4bb3719ee0c0 100644
> --- a/drivers/accel/amdxdna/aie.h
> +++ b/drivers/accel/amdxdna/aie.h
> @@ -14,6 +14,29 @@
>   struct psp_device;
>   struct smu_device;
>   
> +struct aie_version {
> +	u16 major;
> +	u16 minor;
> +};
> +
> +struct aie_tile_metadata {
> +	u16 row_count;
> +	u16 row_start;
> +	u16 dma_channel_count;
> +	u16 lock_count;
> +	u16 event_reg_count;
> +};
> +
> +struct aie_metadata {
> +	u32 size;
> +	u16 cols;
> +	u16 rows;
> +	struct aie_version version;
> +	struct aie_tile_metadata core;
> +	struct aie_tile_metadata mem;
> +	struct aie_tile_metadata shim;
> +};
> +
>   struct aie_device {
>   	struct amdxdna_dev *xdna;
>   	struct mailbox_channel *mgmt_chann;
> @@ -26,6 +49,8 @@ struct aie_device {
>   
>   	struct psp_device *psp_hdl;
>   	struct smu_device *smu_hdl;
> +
> +	struct aie_metadata metadata;
>   };
>   
>   #define DECLARE_AIE_MSG(name, op) \
> @@ -94,6 +119,8 @@ void aie_destroy_chann(struct aie_device *aie, struct mailbox_channel **chann);
>   int aie_send_mgmt_msg_wait(struct aie_device *aie, struct xdna_mailbox_msg *msg);
>   int aie_check_protocol(struct aie_device *aie, u32 fw_major, u32 fw_minor);
>   void amdxdna_vbnv_init(struct amdxdna_dev *xdna);
> +int amdxdna_get_metadata(struct aie_device *aie, struct amdxdna_client *client,
> +			 struct amdxdna_drm_get_info *args);
>   
>   /* aie_psp.c */
>   struct psp_device *aiem_psp_create(struct drm_device *ddev, struct psp_config *conf);
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 139825ac8515..7d6094aefb6f 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -489,12 +489,12 @@ static int aie2_hwctx_col_list(struct amdxdna_hwctx *hwctx)
>   	}
>   
>   	ndev = xdna->dev_handle;
> -	if (unlikely(!ndev->metadata.core.row_count)) {
> +	if (unlikely(!ndev->aie.metadata.core.row_count)) {
>   		XDNA_WARN(xdna, "Core tile row count is zero");
>   		return -EINVAL;
>   	}
>   
> -	hwctx->num_col = hwctx->num_tiles / ndev->metadata.core.row_count;
> +	hwctx->num_col = hwctx->num_tiles / ndev->aie.metadata.core.row_count;
>   	if (!hwctx->num_col || hwctx->num_col > ndev->total_col) {
>   		XDNA_ERR(xdna, "Invalid num_col %d", hwctx->num_col);
>   		return -EINVAL;
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index 6e98af7b74db..f555ffecea6f 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -375,7 +375,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>   	u8 *buff_addr;
>   	int ret;
>   
> -	buf_sz = ndev->metadata.cols * ndev->metadata.size;
> +	buf_sz = ndev->aie.metadata.cols * ndev->aie.metadata.size;
>   	buff_addr = aie2_alloc_msg_buffer(ndev, &buf_sz, &dma_addr);
>   	if (IS_ERR(buff_addr))
>   		return PTR_ERR(buff_addr);
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index f0ddb843eb21..6c8a0f70b73d 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -219,13 +219,13 @@ static int aie2_mgmt_fw_query(struct amdxdna_dev_hdl *ndev)
>   		return ret;
>   	}
>   
> -	ret = aie2_query_aie_metadata(ndev, &ndev->metadata);
> +	ret = aie2_query_aie_metadata(ndev, &ndev->aie.metadata);
>   	if (ret) {
>   		XDNA_ERR(ndev->aie.xdna, "Query AIE metadata failed");
>   		return ret;
>   	}
>   
> -	ndev->total_col = min(aie2_max_col, ndev->metadata.cols);
> +	ndev->total_col = min(aie2_max_col, ndev->aie.metadata.cols);
>   
>   	return 0;
>   }
> @@ -658,53 +658,6 @@ static int aie2_get_aie_status(struct amdxdna_client *client,
>   	return 0;
>   }
>   
> -static int aie2_get_aie_metadata(struct amdxdna_client *client,
> -				 struct amdxdna_drm_get_info *args)
> -{
> -	struct amdxdna_drm_query_aie_metadata *meta;
> -	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_dev_hdl *ndev;
> -	int ret = 0;
> -	u32 buf_sz;
> -
> -	ndev = xdna->dev_handle;
> -	meta = kzalloc_obj(*meta);
> -	if (!meta)
> -		return -ENOMEM;
> -
> -	meta->col_size = ndev->metadata.size;
> -	meta->cols = ndev->metadata.cols;
> -	meta->rows = ndev->metadata.rows;
> -
> -	meta->version.major = ndev->metadata.version.major;
> -	meta->version.minor = ndev->metadata.version.minor;
> -
> -	meta->core.row_count = ndev->metadata.core.row_count;
> -	meta->core.row_start = ndev->metadata.core.row_start;
> -	meta->core.dma_channel_count = ndev->metadata.core.dma_channel_count;
> -	meta->core.lock_count = ndev->metadata.core.lock_count;
> -	meta->core.event_reg_count = ndev->metadata.core.event_reg_count;
> -
> -	meta->mem.row_count = ndev->metadata.mem.row_count;
> -	meta->mem.row_start = ndev->metadata.mem.row_start;
> -	meta->mem.dma_channel_count = ndev->metadata.mem.dma_channel_count;
> -	meta->mem.lock_count = ndev->metadata.mem.lock_count;
> -	meta->mem.event_reg_count = ndev->metadata.mem.event_reg_count;
> -
> -	meta->shim.row_count = ndev->metadata.shim.row_count;
> -	meta->shim.row_start = ndev->metadata.shim.row_start;
> -	meta->shim.dma_channel_count = ndev->metadata.shim.dma_channel_count;
> -	meta->shim.lock_count = ndev->metadata.shim.lock_count;
> -	meta->shim.event_reg_count = ndev->metadata.shim.event_reg_count;
> -
> -	buf_sz = min(args->buffer_size, sizeof(*meta));
> -	if (copy_to_user(u64_to_user_ptr(args->buffer), meta, buf_sz))
> -		ret = -EFAULT;
> -
> -	kfree(meta);
> -	return ret;
> -}
> -
>   static int aie2_get_aie_version(struct amdxdna_client *client,
>   				struct amdxdna_drm_get_info *args)
>   {
> @@ -1039,6 +992,7 @@ static int aie2_get_preempt_state(struct amdxdna_client *client,
>   static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
>   {
>   	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>   	int ret, idx;
>   
>   	if (!drm_dev_enter(&xdna->ddev, &idx))
> @@ -1053,7 +1007,7 @@ static int aie2_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>   		ret = aie2_get_aie_status(client, args);
>   		break;
>   	case DRM_AMDXDNA_QUERY_AIE_METADATA:
> -		ret = aie2_get_aie_metadata(client, args);
> +		ret = amdxdna_get_metadata(&ndev->aie, client, args);
>   		break;
>   	case DRM_AMDXDNA_QUERY_AIE_VERSION:
>   		ret = aie2_get_aie_version(client, args);
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index f12073175676..c884fed610f9 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -77,29 +77,6 @@ struct amdxdna_fw_ver;
>   struct amdxdna_hwctx;
>   struct amdxdna_sched_job;
>   
> -struct aie_version {
> -	u16 major;
> -	u16 minor;
> -};
> -
> -struct aie_tile_metadata {
> -	u16 row_count;
> -	u16 row_start;
> -	u16 dma_channel_count;
> -	u16 lock_count;
> -	u16 event_reg_count;
> -};
> -
> -struct aie_metadata {
> -	u32 size;
> -	u16 cols;
> -	u16 rows;
> -	struct aie_version version;
> -	struct aie_tile_metadata core;
> -	struct aie_tile_metadata mem;
> -	struct aie_tile_metadata shim;
> -};
> -
>   enum rt_config_category {
>   	AIE2_RT_CFG_INIT,
>   	AIE2_RT_CFG_CLK_GATING,
> @@ -178,7 +155,6 @@ struct amdxdna_dev_hdl {
>   
>   	u32				total_col;
>   	struct aie_version		version;
> -	struct aie_metadata		metadata;
>   	struct aie2_exec_msg_ops	*exec_msg_ops;
>   
>   	/* power management and clock*/
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index d621dd32ac40..ac89a9a842b2 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -25,3 +25,40 @@ int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev)
>   
>   	return ret;
>   }
> +
> +int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_aie4_tile_info, AIE4_MSG_OP_AIE_TILE_INFO);
> +	int ret;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		return ret;
> +
> +	metadata->size = resp.info.size;
> +	metadata->cols = resp.info.cols;
> +	metadata->rows = resp.info.rows;
> +
> +	metadata->version.major = resp.info.major;
> +	metadata->version.minor = resp.info.minor;
> +
> +	metadata->core.row_count = resp.info.core_rows;
> +	metadata->core.row_start = resp.info.core_row_start;
> +	metadata->core.dma_channel_count = resp.info.core_dma_channels;
> +	metadata->core.lock_count = resp.info.core_locks;
> +	metadata->core.event_reg_count = resp.info.core_events;
> +
> +	metadata->mem.row_count = resp.info.mem_rows;
> +	metadata->mem.row_start = resp.info.mem_row_start;
> +	metadata->mem.dma_channel_count = resp.info.mem_dma_channels;
> +	metadata->mem.lock_count = resp.info.mem_locks;
> +	metadata->mem.event_reg_count = resp.info.mem_events;
> +
> +	metadata->shim.row_count = resp.info.shim_rows;
> +	metadata->shim.row_start = resp.info.shim_row_start;
> +	metadata->shim.dma_channel_count = resp.info.shim_dma_channels;
> +	metadata->shim.lock_count = resp.info.shim_locks;
> +	metadata->shim.event_reg_count = resp.info.shim_events;
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 7faa01ca3436..69e220e40900 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -18,6 +18,7 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
>   	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
>   	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
> +	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
>   };
>   
>   enum aie4_msg_status {
> @@ -96,4 +97,37 @@ struct aie4_msg_destroy_hw_context_resp {
>   	enum aie4_msg_status status;
>   } __packed;
>   
> +struct aie4_tile_info {
> +	__u32 size;
> +	__u16 major;
> +	__u16 minor;
> +	__u16 cols;
> +	__u16 rows;
> +	__u16 core_rows;
> +	__u16 mem_rows;
> +	__u16 shim_rows;
> +	__u16 core_row_start;
> +	__u16 mem_row_start;
> +	__u16 shim_row_start;
> +	__u16 core_dma_channels;
> +	__u16 mem_dma_channels;
> +	__u16 shim_dma_channels;
> +	__u16 core_locks;
> +	__u16 mem_locks;
> +	__u16 shim_locks;
> +	__u16 core_events;
> +	__u16 mem_events;
> +	__u16 shim_events;
> +	__u16 resvd;
> +} __packed;
> +
> +struct aie4_msg_aie4_tile_info_req {
> +	__u32 resvd;
> +} __packed;
> +
> +struct aie4_msg_aie4_tile_info_resp {
> +	enum aie4_msg_status status;
> +	struct aie4_tile_info info;
> +} __packed;
> +
>   #endif /* _AIE4_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 9ff34ce57fcb..8b5eff0e45c1 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -269,6 +269,11 @@ static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
>   		XDNA_ERR(xdna, "partition fini failed: %d", ret);
>   }
>   
> +static int aie4_query(struct amdxdna_dev_hdl *ndev)
> +{
> +	return aie4_query_aie_metadata(ndev, &ndev->aie.metadata);
> +}
> +
>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
> @@ -308,6 +313,10 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		return ret;
>   
> +	ret = aie4_query(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +
>   	ret = aie4_partition_init(ndev);
>   	if (ret)
>   		goto mailbox_fini;
> @@ -535,6 +544,26 @@ static int aie4_doorbell_mmap(struct amdxdna_client *client, struct vm_area_stru
>   	return ret;
>   }
>   
> +static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
> +{
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	int ret;
> +
> +	switch (args->param) {
> +	case DRM_AMDXDNA_QUERY_AIE_METADATA:
> +		ret = amdxdna_get_metadata(&ndev->aie, client, args);
> +		break;
> +	default:
> +		XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +	XDNA_DBG(xdna, "Got param %d", args->param);
> +
> +	return ret;
> +}
> +
>   static int aie4_pf_init(struct amdxdna_dev *xdna)
>   {
>   	int ret;
> @@ -581,4 +610,5 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.hwctx_fini		= aie4_hwctx_fini,
>   	.mmap			= aie4_doorbell_mmap,
>   	.cmd_wait		= aie4_cmd_wait,
> +	.get_aie_info		= aie4_get_info,
>   };
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index b69489acd53d..1886cffc62db 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -56,6 +56,7 @@ struct amdxdna_dev_hdl {
>   };
>   
>   /* aie4_message.c */
> +int aie4_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata);
>   int aie4_suspend_fw(struct amdxdna_dev_hdl *ndev);
>   
>   /* aie4_ctx.c */

