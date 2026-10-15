Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27F9CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC5510E8BD;
	Thu, 15 Oct 2026 08:27:15 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F8610E8BD;
 Thu, 15 Oct 2026 08:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAvnUs9iBglYlCONiL0HxY6PwLEaQAZYfswuGEcMdIeIsyLlZNgkwvFdLuqXSapRtF8Emsn69F4Mh9SAdI8lsaP55X7KsI8/pu+LRDgnxcmuxs91cJBfplhp5jEiEjWsJFkcQke9n6Y8FMkk2Q2DCOo+lYv60A9zZvTtPzPVf0Bd0MZP+wWL8HxNuM5jX5r+SB5nrx2GSNp951Ad0Ds/hdV6N7zNVI+h7Yt3RLnhGifha98U7NN1ostdJMZgTzPz1wWEJB2eeDjmn8YbXkEerFdTTcAapEmbY145VizdMz5D3+3nlduwC1av89EArzWQy6GBtGk6TOMwtFuXAMUNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJmnOzEXO+vhAe/hGFvli/CIbp57HmZI/zRr+9Owf9w=;
 b=zSR78Y9yEA4mG9r/GBGEUuKsYGSOoO1S1V7JCespfu1pjVuZdBL+Gei/8qGF5uxGR73kmCxYwGlMAKFq2xZ5HzokWDLhD1qbvbybKk/hZBqcManh6OdXD+9JHQZwpbfEOUmhUaIh15A5aag4T+3g33R2fLAlI6UtIoaEqWIq1dRHe47YGrb89rP58Vqe188A66JVfWSCRCJMDqTRaaGO12QtMC2NBCz5QTmbiqQJorFMhPawt3zYNESYutNuDhpK/NcajhYIo2+OLUs3DCgY9UWacU7yPTINx2vcc2032Hj+8yPjk+77IPvCtV9YaHnA3lnaQycLLp/pqojxsWEszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJmnOzEXO+vhAe/hGFvli/CIbp57HmZI/zRr+9Owf9w=;
 b=Alt6//AQoe8EingjyXyVuoI/DY9r31BcAz8uOb4IQgRw8CpqqSe1jyr6XrH6ebQW6cSt3Ni8ZGVyaAm6p0NRQ2AwotYVOcke9ul60bcnFzVsLMu8JnxRabe/3r/1VXNDLXhVpHRpRi+zkpWlwEUx1kdeWnVtjehe11LbzpJpWY0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 08:27:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 08:27:06 +0000
Message-ID: <b6ce551d-b37c-40a7-a2b0-07eae754a156@amd.com>
Date: Thu, 15 Oct 2026 10:27:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix out-of-bounds write in
 amdgpu_debugfs_gfxoff_count_read()
To: yaolu@kylinos.cn, alexander.deucher@amd.com
Cc: andrealmeid@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261015022024.49233-1-yaolu@kylinos.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261015022024.49233-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2ad866-a4ef-445d-51f6-08df2a96181a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HaxDl/c3ObodAKXf7//ur2EmzgCX0rikdtsrki0EcMbTKYoFaTW0ZKs32nYQp0qZLbTGEm88z+MrY45cQvRXpg/kbtrt0rC9uZrHoTx3/t7YCPZtkK18TOvMk3nnv5RqJpzMD/McTqSpdekLE62KFjyHUmeLOfLYQRrJFgvL0vuJhB2i9tJ4SAAXTsftz+qfLTlHOm04arCnarjqkS+FF5+GWgwrNSdfQJ9WS7kCPfpBW6rIOp0lCdoXz5aZLd6sYt1+NWZlp7HFB1EvE7V2ljh3vSpGWL/Utoh1WbLywkTKQr73tPah2W1QQOH/KhJE0b95kYPK3vzphwXyWfr78iQUoWKO37HhAMMigyssLX9OqsJh4CmsV0EZYhLeRPnz9vN5gBPqFHvzoIzYH1ePjhCZcjQpRChh4Bcu4YFnrIOjr5ec0pfKOo4afhaYOflmLolZOpPBs0uAsZ/i8Y6eBtrKwCt6XlCSfFmfahwIHFQ8g/OT1OiU5Mb6ygrTYvKk1UQ3MP9rkhCWN/hQ92mXjfNzv0kvvJTII2uIeUHE059QX6VrTfqYaNVVRrOZckz+Sij0JJ0iYuLP73781b7OaoVhY4G0ps7AkkMBuuT226KnvN0hNUe862dcBGFS/rWfsFpoy3YyU/GP0j0yZzQ4F2AVVB/GnXeJLguA+jl1Gz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZxbElaVndvcCsza2xFMUhKYjlycWpMUDUxRGY5TkxHeEZSMHpWRWJjUWh2?=
 =?utf-8?B?ZnJqMGFtdkpwSXB1RGhNY0E5VW9tSUVUeEVQVC84alVTN2dVcjhvN3FBQWcy?=
 =?utf-8?B?djU3b2hQbTBTTHlLRDZuRjFDUW9QOWs4R09BZFI0YXlnZjhvUUlSSUdBenlF?=
 =?utf-8?B?U0JsTU15MWdaMnYzR0FlajZwV2Evc25lY2x4R0hyOWQ2akd5cjJwWldFZlNU?=
 =?utf-8?B?cnhKNUlNM0xjQSsvdVNIWHlUYWZrSW9rcXFVUGRVakt1ZnI3ZEFYY1ZERUVB?=
 =?utf-8?B?T0pvaytGTDFEM0hPZUpMbjR3WWNJdkRVcHF5bTZ6aEJreWp2YTFyNlhCQTNN?=
 =?utf-8?B?UXloeUxPdERDVG5iZWdpOGtFRmdvMzdqdVRxQStlaXZaRE4yQ3BnM1dRTS9K?=
 =?utf-8?B?Q01oTUxidlRGRGN1cmgvcHJFWGcvd1o1cUZBcHZKNThJQ2FQVjlmT3FSOXM0?=
 =?utf-8?B?cVczc0pmMmcrMTVHckFpaDN1emk0Ni9rWE1qWjdrYWxxL3hoYmE5a3BwNlRD?=
 =?utf-8?B?MlFUdHQwbTNHdU5VQ05vTEJ1QzR4SEUvTStpVjVKSXZpRTR4dlZOK1g0bDBy?=
 =?utf-8?B?cEE4d2xMVnByU1drVWdCbENjQlNhWWNrcFJsRWpTVTRPWG9DYkFHcExOKzNZ?=
 =?utf-8?B?RDBlUXQ2elhFNEVRbHFZVHBOajd3Z3NHS1hPaHI3Z3VsdkU4Sk04Yk56ekNt?=
 =?utf-8?B?Szd6LzlFUzRRa0Rkb3pmekFiNUdKeWZKeWwycTM0akU3cDVzOFk0eUlQczhM?=
 =?utf-8?B?U0xhWUtzUjhvVDk4ZG5qeS9vTDc4Vm4wdXFtanRKWUd4S2tSZ1VMWUszRy9M?=
 =?utf-8?B?aHUyWndWeWxBQkFxRHozNEc5eTBIcFFwTXVNYTl1bk56UjNTUzl6QWlTRmhn?=
 =?utf-8?B?S2lrQnMzTnFBWjF3K3hwNWduejhSbGczcWpGUGlQdkRlYnR4S01UUEJVMDY0?=
 =?utf-8?B?eEpWRHhFRWErcTRjd1lLWTRqdVU0TUszSmhMWlQxcE1JU3Zad1BGMkhUY1Vz?=
 =?utf-8?B?MFdHS2xmU3NSM1U3alRxYkRNWlVxV0I5SDBLbUF1Qm5wemtzYXRvWEV5OHJN?=
 =?utf-8?B?TWxnSW51NnAxOXF6dVYrMmIyM3dVVm8weWM2Q2tQWEVHYnR5akZaK1RweUVh?=
 =?utf-8?B?V3RpdjZiTFdTeUVaSE9uMERFNi9iZ1lURU1sS0VlLzFpb1FkbWpoUzlhWVhz?=
 =?utf-8?B?VWkrL3VNS2YrNnlHUm44aCthMDBFQWc4YjlNSWJ4UDZWcG1Rb1RMZm5BOGVv?=
 =?utf-8?B?QkJsUW16UnZlZm9HNzNOTGFuRC9UUUMrUWxvTDlqUDRBQ3lNeVR3amcwTnJy?=
 =?utf-8?B?YlhteWZha0hINE5YWFcvSEEveng5M2NnY21tQXBKM0FIZHlOMkRkZ3paU0NG?=
 =?utf-8?B?T0hSc1M4NXBjdUczR3grbzYrbStORW50RTN2ZlFVWUlHRXVwY0hEV0FwRU1Q?=
 =?utf-8?B?YSsyQ3hMa24vQzVRTkgveU1LK3YyOEp3MnVwSlI0emhyeVB0ZFJDVk1tQjFG?=
 =?utf-8?B?RjFlOTBZZGhHQ3RoZUZMRlZOTWZMLzVjbERjT2JKSGt6T2dDcFRDOFI5TStS?=
 =?utf-8?B?OVlFRWlqbFRmdDh2VzA0MjFBYlZKU3dCSkVjeDdoODBleVhiK3N1YXl6SzRl?=
 =?utf-8?B?bHRCdktnV1JoNUpFSm55TWlxVDNQV2J3K0E1MHVuc25mZEpEK3hBcUpDRG1C?=
 =?utf-8?B?VFU4ZmRJRE81QW1VUnhsVVFnbHpydFBsMTdKMmNFa0d2OWZQNWVabWdOY0NU?=
 =?utf-8?B?ZjFCY3I5eVpjaVlIT1FoZ01RbEFRV1lCeEdDOE45TmwzY25ReGZRU3ZBdUxC?=
 =?utf-8?B?d1FRT2xGYmZRL1lNUktGWlR4cTJpL0FDeXNFQ1dFMkZvSFdGcjBqWGIyUFo2?=
 =?utf-8?B?b04wUHNZSjg5OHh2OWFtWWtkQXBib0t0QTh4andhamdBU1NpdGFKVk9oRVo0?=
 =?utf-8?B?YW5Rck9GaDVnbmxrT015M0cvSFFsQlVOUzBRZzNuV0NobDl2Yjl2SkIrWGNi?=
 =?utf-8?B?dE8zY2IxRWdNazdZcngyaUNvUDVoZjNoaS9oeHJ2WG54MzJWWHduNzdyd01n?=
 =?utf-8?B?N3dvaERmSmxGVmZLOTlFY08xRmFUeUMrSTZPQ0ZjZ0hGRklCUG45YzR3cU5D?=
 =?utf-8?B?aEYyRkdpbDZrWm1kMnJubVAzVFQ3c1lUbm1ubUNUSldkMEpPUWFYL3U0MDdv?=
 =?utf-8?B?bXdkNU9IZzExTkllVFpNNlJ0ZVUzamVuT2tDMFc3dnhnbWY5TFhER1lmSEVU?=
 =?utf-8?B?R3AyeTNGZTJzbWpHZEtzZC94MFh6KytjengyWDV4QkZrK2VmZnVEVS9wMmhC?=
 =?utf-8?Q?pT28wsDoRuVPMTCGHx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2ad866-a4ef-445d-51f6-08df2a96181a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:27:05.7556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AAFGkGPWmUcsngobBxLHNGQYj6V1X5p+tM/60ETynEpQwEX+jsQaB8w8220Kyb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107
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

On 10/15/26 04:20, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
> 
> amdgpu_debugfs_gfxoff_count_read() stores a 64-bit GFXOFF entry count with
> put_user(), but advances buf/pos/size by 4 bytes per iteration.
> 
> Fixes: 0ad7347a64ac ("drm/amd: Add detailed GFXOFF stats to debugfs")
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index ab7ccfaea22a..aa44a3f0cdc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1451,7 +1451,7 @@ static ssize_t amdgpu_debugfs_gfxoff_count_read(struct file *f, char __user *buf
>  	ssize_t result = 0;
>  	int r;
>  
> -	if (size & 0x3 || *pos & 0x3)
> +	if (size & 0x7 || *pos & 0x7)
>  		return -EINVAL;
>  
>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -1471,10 +1471,10 @@ static ssize_t amdgpu_debugfs_gfxoff_count_read(struct file *f, char __user *buf
>  		if (r)
>  			goto out;
>  
> -		result += 4;
> -		buf += 4;
> -		*pos += 4;
> -		size -= 4;
> +		result += 8;
> +		buf += 8;
> +		*pos += 8;
> +		size -= 8;

That's a good catch, but the code is a bit questionable to begin with.

Why are we reading the value multiple times and in binary instead of text?

The same is true for the other amdgpu_debugfs_gfxoff_* functions.

Regards,
Christian.

>  	}
>  
>  	r = result;

