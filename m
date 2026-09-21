Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43540C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EDE10E33B;
	Mon, 21 Sep 2026 06:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GabOPv6u";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A309C10E340
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEFKCk1nFywOLlILUWOqu0HtQP3PF5MDXunddDZkBkELPWkKTeZUm7ezjMZ/gAN+4Q5XE65C4dUrRWjloGMTcmNaHyzjKg9hD2OKbUJfXYiAOqin5HDR8ts4r01Oql0CnfCc26uJ19E6TpAif2tXZwb4NKB0JC5b134OgI83/225BnnTvDDKL5IkiDR26V7+ZvWn5p/n3skgf7jq+IHIdzFyIsiVHtwR83DK84dxjDR2XheFaPFhXgcsl5v0A93vP+ez/JNEgImtO+VQvirVesF/OAYysKItgawURE0xvrj+Pd3VRfoVUOdwKBsQ3Bdjs2OYW4FvWXZnFd+U4oK0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRwqtyZpIlxH12E59U8j851c8nLUyhNFObHrQX129QE=;
 b=nKR73mL8v/ozmDiy4US1HPsyLBJwVKYUexFxHV5adrd6e1DJTKvrXwqvH4WPGpQdKFYLmkD1k40gSlbMT1QdcNSILlAT2M7WPQ2vCAV1cAjZIGREB++X8986vWvQKpLsM0TcQDK7bGxvjHySe5eKoR8ku/StarpMKUxPuBg0cXIBD+MnWwNn8cLuTX/is/O5taNWlDJK3+4Hq40haHa1AqqI/UCEo+OqI0BU8cibCx3+23nBhnjFRuLdkwxtyfgl5jnywlUTe2a/iQpiONUOi8gXQ97wkyIRz+Aevz1oXE9sfXHywWhpRp2cipThMjTlhmRfM9NpoDAXosze/3L7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRwqtyZpIlxH12E59U8j851c8nLUyhNFObHrQX129QE=;
 b=GabOPv6uNecGhmWEFJS03tzkICaZRS8fmPD1hyd6T/LKdp5VNQ9cOfh76oQogFoHoq7RSob2EEno9wu2qTn8+bE3WBwt6qGu2TfcHoZoUACmop8JeOZCj/LHdC44J0EvcWw8+DogrHzxzu3M1SWutawP0TwiyDOgWQ+6OvyZevQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 06:56:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 06:56:10 +0000
Message-ID: <d91e2d04-cb8a-4c34-9e7d-e8faf2dfe79b@amd.com>
Date: Mon, 21 Sep 2026 08:56:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf/udmabuf: reinstate a reasonable default size
 limit
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>, kraxel@redhat.com,
 vivek.kasireddy@intel.com, sumit.semwal@linaro.org
Cc: robert.mader@collabora.com, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20260919004222.4141024-1-xujiakai24@mails.ucas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260919004222.4141024-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d71c47-fb3d-4902-fda8-08df17ad6b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: isTtF52ATaDY7n04I1W8dkmysccSmmUdvrGZC+EqqwL9yNK84AyY2coE3vV7QBRH/F0exXAgCwNQgmrd09+Hq8PcKJA7fQceVogUZa+k5cwHluECb9cklKqL6CQrbBu5oQcRa2S0jO0Uw4PRgPhALr8goG1GD4spoNzq5OMldvTGlmETqHBjEPmge4TVagyP/rWpTqqR2dtoF0NZJMdzHG/307HqE8DUm668hd8M5sf9LFmtpnp0bqNdSj5xh8imDzrF2+0NXe3q6LFAlDHRkKYQLMKySkp4qYKDwKIZlF4PKuCwss7EtNN1SGZi1XvarCzyWVd6JPyqgeePbD0WBy08ahplxiisXX+d+/qG+V/pzzVFlqHteBXKVxb+u5jQ3Ty7PSrSZBtdN2uKXte5RTDKDYar0lDsHCao5nhf6xqZXoEnuZad5PMRIIH4lhhRaP9EblEj0vHKsuctl0j/+58/+tTJonIJX886We4dYTZ7vqy3FtXGiqhJqwZrhH5cFpi5iDTbW0vkFRX36l2QtdbpArFtcawiy9JeW1lvJim7E3GYnQPDLCzB078vheoQdjijkrqthvZ3lqw+YXctyq2RWByw2vNfrb6BSYAiskDVEOHQRfkktSpO22LbQMm1Sbv7Aucj1NQkSlIacPGsJzuLQYwQPRKpS+VGSE1pm/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEJRazdNRkVaNmFObW54QktmTEpWeWNwT1VtUU91cmtrdXRmamVtb0dINHhC?=
 =?utf-8?B?VjBNZGJ5ODVqUWU0QVVuV1lnMno1bEpWV1Nsak10VVhwNHFGcm8vNmpPa2ZL?=
 =?utf-8?B?enlPSmRhRUEyQnpidjkreGdWYTM4S3J1dGFOa3diMmJyYXM5MTlodENDTVhK?=
 =?utf-8?B?N25BM1N6T0FXSHJsRVozM3ZTMHBhZFpPZE1PSW5vMTNiUmlHa3EydDl4MWxG?=
 =?utf-8?B?TDN6OGM1VGh3Nyt3Z1g4YkRkME9UbHRnMXovRzVBQWxQYzNoY09xRUVRZGxF?=
 =?utf-8?B?Yk1qRnRxZWFaMG1zV0xjQ2FGRW00UFk0SE53S3NMTVpLR256WHhjT1FmaTVE?=
 =?utf-8?B?RytaR2NnclFxY1MxUG1URnRneWtyYS9oMjN3a0JGd0hESUR4ODNidVNHSk9C?=
 =?utf-8?B?TzFSNW1SRFIvSEs1R1JObEROSjlwK0tnU3Z1Q3FKUEtmcTZKT2ZWQ2xjY294?=
 =?utf-8?B?bDh1RldQNytxNSszeXh4b1dXcWk0MXJRRlU5ZWoxa1ZLUXBoNi9wcmU3U1Y1?=
 =?utf-8?B?L3l4Vis3bStWeGVmbUpaQzV3TWg0Q2tCck5FTXFBZGdHeTJ1bmthRlkwMFRi?=
 =?utf-8?B?RW5aWFpTd09NaVZWUUNFY3d1VzlMSks5VjBNd3hzMzRrZmhJZE5BNDViOVlU?=
 =?utf-8?B?M2xEaDNZbFp6KzQrK0hkUlNrWTRMSjMyVUhLL1dQeHdiTmI4NFJzbjh2K3Iw?=
 =?utf-8?B?dzQ3SVJrU0gvZStxcFF3WE1Vby9SbG9pYmNyZkRBVWFoa3ZhcWFyM2hIc3Vj?=
 =?utf-8?B?MXZyVmlQSlN6QUQwRVgzODRXSVowcEJuUDhJYlRnbHAvbTVsdlFDOTc0cFp5?=
 =?utf-8?B?LzcweTRKNHFjK0FVVVJSWkxiZnllZHRvOTEwd29xYlJUSDBDa2dQYStmZk9q?=
 =?utf-8?B?dVNOOTNIWkk2R1pxYnlwM1lRU2NZdVVJbStPUVg2TUpNRWpTUUNCZVNLNTY1?=
 =?utf-8?B?QmFHTmY4OGNYcXRwSHgrZ0lZWm55OG13cHZUYkprTlFDMUhQa25pODluK1hq?=
 =?utf-8?B?L3F3RFF5dy9UeFRGMHRrNWtJWnVIQ3VuWkJ1UTZvMjU0dHdaSHJ3cDQvbDhj?=
 =?utf-8?B?WGE4cHhGQStpUEpSVU0vRXh1aWtVd2VSZ0xxZ3JpZWxBbnlQTnN5V2hUMkxY?=
 =?utf-8?B?eDlDQ2xJWWlJdlJQUTZSY3RwWnI4ZmJ6cEpzeU5hazdJL3BSdUlmZHpWaHVt?=
 =?utf-8?B?UDVhcjdrSm9zYVNRZ1VxUlJiOVR3em9aU0JnUlRnZm5DRGpONlo5MnByTVpH?=
 =?utf-8?B?NzJpblJnSFZkYm8zVFdXZjdhQTZlb3BadXFxWmxnMW1ZVGJjMEZuQ3J6aU9N?=
 =?utf-8?B?VzgzNEorZFFjYU9pUVUvREJhWTBkZWFhTjNMV0l6NkhTa0hWV1daOUFnUHJH?=
 =?utf-8?B?TmlKdlVZOCtvK3lLdFQrbHdwUjJocFN1a0l0NzF0eVpUZlpXSVdObjBHZzc4?=
 =?utf-8?B?MEIxL2pCSU81UmpONDhaRXBrVGkrZlA5OEJ1bGJPNU55ZGlCR0dZb1YxZnlz?=
 =?utf-8?B?bE1nS29MaHh4UG5RWkxGdHJhN1JId2Rnd0E1NnlhenFqU0tRKyt1eE5iYTZH?=
 =?utf-8?B?eklpTjU0L1hQMWpuTy9sRjErSGs3emdmNE1la3FQVlNEVXRNUUtieFpCNzZq?=
 =?utf-8?B?VmpGd1JZczZkeVg3c1NjNW5SMHhlSUJIZ1krMVppcnIrWnpjMnpXbW9FUjQ3?=
 =?utf-8?B?SmNOdXpEckNzcVlud01kWVNhVVUvQnd6OEd2UDdYN3hVTG5Jam0yNi9valVN?=
 =?utf-8?B?M2MwRkFmaGNUbEhTd1pvb3loU0Fsb0RDTGtITWc2aUxjaWxVVW95Wm5HQ243?=
 =?utf-8?B?bWRGWXBGSnNVRjZYRU81MXI2OE1heFNVbzA2OFZ4Q0pVRDU2VjkzMFA0YUhB?=
 =?utf-8?B?M0k0RS9RUlM4eG9qaEp2YmJBMkR5cGllOXRKSWFLTkQwVkZndUR4SExrTkxa?=
 =?utf-8?B?SDBKZkZXRzc2bzI2R1c4K1l5SlZrcDFqdlg1SHJQS2oxRTZjcUhHdEJhYlpt?=
 =?utf-8?B?YlFJQkhDSW9IWDR3RTlid3d5U08yaXFjYkFHdEJZNzlyOGdyNEZxQURxbmJx?=
 =?utf-8?B?a09rKzJVU2RoMHhjcHNVUG15bkk4dXdYaDJyaDJ2UTlScjMvTXNvV09BQVVN?=
 =?utf-8?B?UFFpZ0VvcWJHdTc0VUJNdTVSOThKanFDR1o5dWovNjdDQUUxUWVRcFBvZDdm?=
 =?utf-8?B?MFR4STdRRnAzYzRaVVhMUnNCa2FtcmZDREd3ODZVaU02Y1M4TG0wV09UMmRk?=
 =?utf-8?B?QURRUHlNWHdPWnJEZzE4a2U2dHAzeEt2S0FhYVhNV0lTdm0xeUxWMEFya0RK?=
 =?utf-8?Q?FMMMBCqjEcC09FjNCP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d71c47-fb3d-4902-fda8-08df17ad6b08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 06:56:10.3819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIcx934EtdOrWME51IiUO5jWOh6oe6l2PBgAD76tTv+c95rq5Matx0iPtM8MMTxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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

On 9/19/26 02:42, Jiakai Xu wrote:
> Commit 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
> default") raised the default size_limit_mb from 64 to INT_MAX.  With
> 4K pages, creating a buffer of more than INT_MAX / 8 pages (about 1 TB
> of pinned memory) now makes the two per-page pointer arrays in
> init_udmabuf() exceed what kvmalloc() can handle: kvmalloc() warns and
> fails when the requested size exceeds INT_MAX bytes (WARN_ON_ONCE in
> __kvmalloc_node_noprof), which is trivially triggerable from
> unprivileged users through the UDMABUF_CREATE ioctls:
> 
>   WARNING: CPU: 0 PID: 412 at mm/slub.c:7021 __kvmalloc_node_noprof
>   Call Trace:
>    udmabuf_create
>    udmabuf_ioctl_create_list
> 
> Restore a reasonable default limit of 256 MB, which is the value
> proposed in the RFC discussion that led to commit 44e9eb5a7621

That is way to low, we want to allocate multiple gigabytes using that API.

Please make that (((INT_MAX / sizeof(struct folio *)) - 1) >> 20) << PAGE_SHIFT.

That should allow to allocate a bit below 1TiB again without triggering the issue.

Regards,
Christian.

> ("dma-buf/udmabuf: Disable the size limit by default") and comfortably
> covers the 8K video use cases cited there, while keeping the
> kvmalloc() request far below its threshold.  The limit remains
> runtime-tunable via the size_limit_mb module parameter for setups
> that need more.
> 
> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
> Assisted-by: OpenCode:DeepSeek-V4-Flash
> Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
> ---
> V1 -> V2:
> - Instead of adding a pgcnt check in udmabuf_create(), restore a
>   reasonable default size limit (256 MB), as suggested by Christian
>   König.
> - Drop the second Fixes tag; the regression is solely due to
>   44e9eb5a7621.
> - Drop the "Cc: stable" tag; 44e9eb5a7621 is only in v7.3-rc1 and has
>   not shipped in any released kernel yet.
> 
> V1: https://lore.kernel.org/all/20260918013434.1849135-1-xujiakai24@mails.ucas.ac.cn/
> ---
>  drivers/dma-buf/udmabuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index df6dd00462423..4d90c2cb14225 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -20,9 +20,9 @@ static int list_limit = 1024;
>  module_param(list_limit, int, 0644);
>  MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
> 
> -static int size_limit_mb = INT_MAX;
> +static int size_limit_mb = 256;
>  module_param(size_limit_mb, int, 0644);
> -MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is INT_MAX.");
> +MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is 256.");
> 
>  struct udmabuf {
>         pgoff_t pagecount;
> --
> 2.34.1
> 
> --
> Below is the crash report:
> ------------[ cut here ]------------
> WARNING: mm/slub.c:7013 at __kvmalloc_node_noprof+0x516/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013, CPU#0: syz.5.27938/167363
> Modules linked in:
> CPU: 0 UID: 0 PID: 167363 Comm: syz.5.27938 Tainted: G        W    L      7.3.0-rc2 #1 PREEMPT(full)
> Tainted: [W]=WARN, [L]=SOFTLOCKUP
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__kvmalloc_node_noprof+0x516/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/mm/slub.c:7013
> Code: 05 bf fa 2d 08 49 8b 0f c6 04 08 00 65 48 ff 0d 90 fa 2d 08 0f 85 4c fd ff ff e8 05 43 8c ff e9 42 fd ff ff e8 9b 86 0e 04 90 <0f> 0b 90 31 db e9 d2 fe ff ff f3 0f 1e fa 65 8b 05 8d fa 2d 08 89
> RSP: 0018:ffffc90002bc3cf8 EFLAGS: 00010246
> RAX: 0000000000000100 RBX: 0000000000000000 RCX: 0000008000000000
> RDX: 0000008000000000 RSI: 0000000000000000 RDI: ffffffff835e3226
> RBP: 00000000ffffffff R08: 00000000000028c0 R09: 00000000ffffffff
> R10: 0000000000000006 R11: 0000000000000002 R12: 0000008000000000
> R13: 00000000000028c0 R14: 0000001000000000 R15: 0000008000000000
> FS:  00007fc89ae45640(0000) GS:ffff8880f3de4000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c2ff305 CR3: 000000002b3d4000 CR4: 0000000000752ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000006000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  init_udmabuf home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:193 [inline]
>  udmabuf_create+0x1b6/0x750 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:386
>  udmabuf_ioctl_create home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:465 [inline]
>  udmabuf_ioctl+0x132/0x1d0 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/drivers/dma-buf/udmabuf.c:496
>  vfs_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:51 [inline]
>  __do_sys_ioctl home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xbc/0x130 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/fs/ioctl.c:583
>  do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x12b/0x350 home/zzzrrll/tmp/kf_src/linux-7.3-rc2/arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x590d6d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc89ae44fd8 EFLAGS: 00000216 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000611e7f RCX: 0000000000590d6d
> RDX: 00002000000023c0 RSI: 0000000040187542 RDI: 000000000000000a
> RBP: 00007fc89ae45010 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000216 R12: 00007fc89ae45640
> R13: 000000000000000b R14: 0000000000528d40 R15: 00007fc89ae25000
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> ---
> 

