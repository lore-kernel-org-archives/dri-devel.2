Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34CBC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7F310F7FE;
	Fri, 10 Jul 2026 07:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WHQsDZVi";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5127010F7FE;
 Fri, 10 Jul 2026 07:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avhXL4mzD9QA0SwsAn3FhzXhDclpIpbaZF8+bu2HL4CvlmZEJpubHkSIe7hcXfswp33VSHavbbsu7335T+tWXkBn0GNnpD5QE8PaX7fmDBnLOqBS6imnclnenMxA9kRQsGsE6S1TdS/knULxKpk+HhKrREiA5E7DsLNNQ3CUMNHowWD4MZn2nrL8WAVE/mvy6HCy65CFpyEgbEGkjg7P0TMjeClxfVhfLwWo8f1DkBoAMAEQ8Xq0cIJFt4Fpb0hAPBZFUEfh0fRijUZ1AX43pyq8afDH9MSYfL4N3dRH7h0muwGOHnWm5bBd6QrXs9d58a5aHHt4tIxMGtQfLZ9ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HVAQcY9dAU5PGZAeL0lRH08xCIXb37Hze0ydrV/7iQ=;
 b=CnJYVhsV6OyZeNLQBqWm/r/ARBWJo+4SwKP8MGTUdXTUTY7SkmUqhN3AjykPoc0OyQmKXJzEMwvcE1UqH6e0AWvRK4K+slfI70bq5aJfxIkwHrHCS15oOpp/7V/1vkpynveoiUE8ly+pwz8XLazhrlBs35kfYipSm/AwgbWwfwLH+byemc0++z+1LWMPE2sq+o/n5tjNCgHoisI+FZTn+QrHZ9Cg4X+DQBYDOttnZI9dEcAyoxzWCEsjsSFPFHOKzLuz1+zUSqLIxQGYnhTrpc2uxBa4nXS6baUbotQ9yKohQc92g0qqpN7g6FmBfE4qdJ/gdddRnfBRfXelkEhCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HVAQcY9dAU5PGZAeL0lRH08xCIXb37Hze0ydrV/7iQ=;
 b=WHQsDZVigNNzB0SYTT3xdN3osDXZ/x0v9Yo1NL3Esv1dgdXMkKn9C1isn7KL6/Ts60hoeDpDC62em8n9FxAJGOFnyCkEphpuZnzlbTH7zPV1ifbXEaDxqgxWBFWSWpKwbgJYWZ7FuNb3iGD0MXkoe5uWFDxouq+yTiWeqBOf6kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 07:59:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 07:59:05 +0000
Message-ID: <4a8e66df-b397-4480-8708-ef8ed7255295@amd.com>
Date: Fri, 10 Jul 2026 09:58:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix __rcu fence pointer accesses
To: Alex Hung <alex.hung@amd.com>, Felix.Kuehling@amd.com,
 alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 YiPeng.Chai@amd.com, Hawking.Zhang@amd.com, yunru.pan@amd.com,
 lijo.lazar@amd.com, chongli2@amd.com, xiang.liu@amd.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>
References: <20260709223312.475563-1-alex.hung@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260709223312.475563-1-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4b1c76-b40a-488b-fb2d-08dede591cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info: sRsnup9gluXqozpyI7XlCRt++p6IicWUkwekYGrUW7TqDaGtfuknxA/wPamX+y3CvRKA4QaJiyQsNJWqSe6uoje9Gz/xoctEokMUwKmYkvkCInp41Ux+L6GTD8eCC7loOqGNaomYJLqhnKpNTru0WFUqik4SCmYfPYg6kk5R7zE4K/cez4UcaueSw3ATuSy4wedS8KXGaKn8lWOhioaMfxo8d1rpUBpgMoGiccfwTVzJ+KYtOci8XxU1M4XlD3PcT4ylRtlRsjQm1YrlJ9FEwVj56cLeIdkT7P3wEY/qCM760xauumar+pfQo4evkQLd4MYZICDqSTu28Ma+EWF9aT5lvDkorErilSpAWpxIVyZsgIiyzPv9nQRddfH0iepsL4O7JBDYTVOZcogROvhYb3lNq0R+JIkkoliLgCmR6mCErkBlSdFg/I9c6Yl5deM3Z11Un51kYwHSfofaqjTpemSDYtkNSULwPiZpR6vq4XStuyTajOZLO91qd8KNwZVzEUsDy51qLszxr9kDjjK34Zc7DAGH/QTdkz9p4nW1/bwgkWC6Mxp8d9QDT0I2fMpsCVS5ij3m0/BiOQjXTeftBphe2kZj2i6Q+D7UvoEwxQW6EpCS6DjJpRkHkG7lOkZfQ8SoJezd5F1EHKJovyuBlO3l5rT1aK62u6qH4DHSmvO1tFMZSoixCN1AUJkOpmBdwerk1vyKiADYe6KG8OdI1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(921020)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3FjZWRBcVludUQxU2FHakJNSGg5aHVpbVJwVkhxazVQUXFoZWRCYVh6eWVu?=
 =?utf-8?B?ZW1YVENSa0l4cDhNZmFtN0EvelZzV2E0aE1xYmUyOWdNblFsNWNaMk1zYW5l?=
 =?utf-8?B?ZTVXN2VXSlZpN0IvUEZYd1YvbGRJNEFmSUQ3YktTMXFTb3c2dUMrMFZZYm01?=
 =?utf-8?B?THhNa3ExUGttOWRzeDhISXhSeU1VQ0VPWUFzNjI5cVlBK2N0end2c3k5cGZC?=
 =?utf-8?B?aU5JMFMwZFluMExmTHZ5RkFsWnB5eEFnUFZLKzFDOTU3aUpPc1NTSkxsZHdq?=
 =?utf-8?B?QW1Fbm9ta2hyYVpGU2NsZXZ6c0ZkRHNiSTE2WmN1cjJoMUZIdWdEMnBnWFp2?=
 =?utf-8?B?WEJSTy8xWFRKL1ZsMW52N3JkeU9qb1IvaGxIWTNydC9GS005TXk1T2c1ZGhR?=
 =?utf-8?B?NVMxRUZRblBCZzR3aWc0aGkrTUxvY05BdVU2WURhSEh3Q3RZZHZNa1NZTzMz?=
 =?utf-8?B?V0dOY211YVZ4SVFqaDVxM2p0ZGNWZUhqZGF4a1hwcEY2OENxcGMwTDRaeXRM?=
 =?utf-8?B?Ri9xM29hd3pNaTB6NnNwenFLUlY1b0dZcGUyUzFteDZtc1owS1hQUDVHTXlp?=
 =?utf-8?B?T3hscWxFSnpCc2Z6MEpqQ01SaG9NK0p5VWRqZGxOaWFrcjdod0RRaDVicm5I?=
 =?utf-8?B?aTFmenc1N0RkcXV0MEpsUFZLTy9scTBrbWZmU1Y1R3JsSlhla1owSjVMSE5j?=
 =?utf-8?B?d1dudFRHSVpkN0R2dG1SRStML3kzKzR1U3FRcVhBYW4wV0tUaWt2WGEzcUNT?=
 =?utf-8?B?enQyNit1M1ZRcU1FTzlTMEd2WTRNVVFOVStqemxoeVFCTU0zUjhrcmZKNzlY?=
 =?utf-8?B?VENGMitXQ0FlN250Y1U2SmNraDczQmZlTEFyUU9zQ2ppQ3hMekk0MjQ2Q1o1?=
 =?utf-8?B?Z2F0WWZRenprRndOdjY1NHRYczJFV3M4VDZtckthWEZXVndPNkJvSUtyQUox?=
 =?utf-8?B?c0l1ZWVyc2N6bHhrWHZPV1Bja2Y5dFp6aTVJMEZ1M0dDV3RGNmhwdktHQzJh?=
 =?utf-8?B?QVp1SjFWeFZnT21rTS9kajRkY2RIdG9rWGtkSDVFcHpMMGROR01QNVplWnZm?=
 =?utf-8?B?aE8zQWdkbmREM0pBTWNrNHZZSTM2ajZiVEhNdG05M0x0Q1Vrc0NvQTBSRDRH?=
 =?utf-8?B?K3pwTnU2Q3gxaDJDMmxOWEhtdEI3Umo5SklUdHVMZmxkcEl4Tmo0OVc1bXZZ?=
 =?utf-8?B?WXZMVzYrWlBRNE05NG0yeWVad21XUlNJbm81OFUyOGpSN3UyN3lZeXJtZjBQ?=
 =?utf-8?B?S01Qc1JuWFR2Z0E4MlFCdGMzejU1bjcxT0xpRXFQdWpvUXZEdlFNMGpiV1N5?=
 =?utf-8?B?c0hJYXJvOXFRUHB4ZFlYVzhORmozdlJ0T0hkcUpORzdDU0FBSjFrVFBYYXpD?=
 =?utf-8?B?MVZjeEpBbVp5djRkckxFcUhxdFpJRjRCSXBFTHo0WjJ1NjBUK2hyQkRuRUcv?=
 =?utf-8?B?aGxQMEFIa1NCa01aV0sxRjc1OTZNWlh1ZVd2STZMMlBRK1hQZW5OalQ1QkVi?=
 =?utf-8?B?T3ppSjJBSWFOYjRGVUFaQ09LUkwxQy8rYlY0Q052bTI3UDJSdzJmd1o2RkxP?=
 =?utf-8?B?cWdOMHB1eldrVUF4cXdBbHh5aStMcm4wdkhBMFpNNW1GcngrUC9XRVhIMHY0?=
 =?utf-8?B?M1VrYkxyUFZCc1M0ejJldUpqNUJJVzN0TmZwTjEwRkxrV01uNlQ1eE10ei91?=
 =?utf-8?B?K2trS3JvVGt3b3BwYlB3RUIwdnZzeVFzSVYveC9yQVE1UG1VaVFTNTJqNzR3?=
 =?utf-8?B?MGc1RWdLeDdtWnlsdVJtUXE1cW1OZmhVd01SYVlCclNrTURMeFFOL0xseUgy?=
 =?utf-8?B?SGhCejEwYS80ZnNBcUlEOUwrU1AxZlZxYTgvczJEWFdBcGNKSUc3WThybnBh?=
 =?utf-8?B?bUROdHZpYmpRb2x4RTFITjVBTTlXeG5rdGNWN29nR0lpZUttL2krK3VWMUIz?=
 =?utf-8?B?aHlqVWRieGFpemczS21pZXptUndrMGtFdzdLS1FaYnJHSFhtS253SHRCVzgz?=
 =?utf-8?B?a0tzMlo3bFIzN2JFTExySEdMUk9OeVY5WFVCb2VDRHdRVTErYUY1S3JjbFdl?=
 =?utf-8?B?RkRNKzBPV3B3b05XdlhaYlpJRXFIREFYWmowN3YxWnVVSEp3NGZ1VXRzclE4?=
 =?utf-8?B?TXlXQXo1bnRFVXVBdTlaTm1iM2VPQi9kKzlpR0h5cjdZMnVIR0NuNnpJTzEz?=
 =?utf-8?B?bTY1T3R5YlkxWUFUYmxhMzAzcEpCUllVQVBYb1g1SDViTUIzYlFuUUVNZ0ls?=
 =?utf-8?B?RVcyQTUyei82NGlvSXhtMWp2SHpKR1k0RlpocE1xMk9sR1A0T1BEOGorY2FQ?=
 =?utf-8?Q?Js/Nbq3ArLbmLYUbe9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4b1c76-b40a-488b-fb2d-08dede591cc7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:59:05.2984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7+REGyx70Okw7lqJQf0yAv/vLfkZ/zm8bP9e0BTEdovIz2Kl/caR6vq8aquQYhy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

On 7/10/26 00:33, Alex Hung wrote:
> Building for ARCH=um with W=1 C=1 makes sparse report "incompatible
> types in comparison expression (different address spaces)" warnings in
> the KFD code, exposed after UML builds were enabled:
> 
> - amdgpu_amdkfd_fence.c compares the __rcu-annotated dma_fence.ops
>   pointer directly in to_amdgpu_amdkfd_fence().
> - amdgpu_amdkfd_gpuvm.c compares the __rcu eviction fence pointer
>   directly in amdgpu_amdkfd_gpuvm_restore_process_bos().
> 
> Fixes: af3f2f5db265 ("drm/amdgpu: Remove UML build exclusion from Kconfig")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607091659.SHEscT0c-lkp@intel.com/
> Cc: Harry Wentland <harry.wentland@amd.com>
> Assisted-by: Copilot:Claude-Opus-4.8
> Signed-off-by: Alex Hung <alex.hung@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 6a364357522b..b0299d861903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -92,7 +92,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
>  		return NULL;
> 
>  	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
> -	if (f->ops == &amdkfd_fence_ops)
> +	if (rcu_access_pointer(f->ops) == &amdkfd_fence_ops)
>  		return fence;
> 
>  	return NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 35fe2c974699..f0f516a79424 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -3096,7 +3096,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  		process_info->eviction_fence = new_fence;
>  		replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
>  	} else {
> -		WARN_ONCE(*ef != &process_info->eviction_fence->base,
> +		WARN_ONCE(rcu_access_pointer(*ef) != &process_info->eviction_fence->base,
>  			  "KFD eviction fence doesn't match KGD process_info");
>  	}
> 
> --
> 2.43.0
> 

