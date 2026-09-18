Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8497DC982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCED10F2CB;
	Fri, 18 Sep 2026 10:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nEa5kcFA";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0C010F2E7
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8iJ/2a7dv1ihJXU+EhJ28NEidNWpbY7u+Xt1pxf3rBdqIlZdwy/9+TFreH956MCVqg5ycdWOABoAw+1CS+LZduisIfb7psXPwQKV4rCicVJlfS+WjWJ7DKAjYiMXSatBNm11pB88siyaLaezvaSZUJae2WkZIgxLnl5tWqA5zXexiMXmpAamQk5PFTy86fUuxXcYKC6Pp8FQwe11NwqJsg77SWyqnL9ommcZhl9H13cot7vDvpSLs3u1biZEEVtbdfF2CxBQilFAKiC9VfkzIUvgQszcG2my5TZl1xYKRUYiybjsnoOK5AUWlUUEFvi5H+V7c72MgOYz1L5g+gQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Feqrde7+ggaNMunwruDbVaelRY84nC19U+LFWW7yEZ8=;
 b=EVnkW8YeVxIQRv0GN/XlDtMP/pSoXqNuxtVtVs8cY4dPEdb0P0IwVLZNSGxMtpy2e8Vit/Uv/pa9aBBUjy+TNoZxUVLjlvrWFCB2G+cXIRkMXA56OGZaGpoKCOFS3qs9Ums8grXjzNbnZVTVhh9hPolY8P1YYBdEq/Yk5Wpg8flOqbXDW4r9IkRexvu8nA1cNGgb//oycmAbIDqyQcbvkHmwgdDbogIXcYHqDfbZ+0cDbOQLJ9Cr9UtpxfHZGh3XN8QIXYHHW74wS+hu3332o8IelJJhzxMn9tSL0Te4Ta3M7WIRbqwI32p455Br/tpjNPpPvso79tIUrkVGpnjCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Feqrde7+ggaNMunwruDbVaelRY84nC19U+LFWW7yEZ8=;
 b=nEa5kcFAB7oW1F42kyB9qCse82LZEE3QiBE9rhL6n6qGMx+7HD60oPXRFQV60KFboFYHUKwxluBsWjr1lEzlzAR5SDdeaLCkVd+ztck3XknEqKkTjTaOuln8lU+BXIxFwKrJOmfobcrZPu9aVeoh78bHQq+yK9en7J1dFe8tBH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 10:17:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 10:17:33 +0000
Message-ID: <a35cd398-4e98-4d19-bd6a-3c7ec0feeebe@amd.com>
Date: Fri, 18 Sep 2026 12:17:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/udmabuf: avoid oversized kvmalloc in
 init_udmabuf()
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>, Gerd Hoffmann
 <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Huan Yang <link@vivo.com>, Robert Mader <robert.mader@collabora.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20260918013434.1849135-1-xujiakai24@mails.ucas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260918013434.1849135-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f045dcf-f3b9-4889-35e8-08df156e0d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U0Ocr5D/K/duXc/Ovf+X7dPjyxxSq3RtDGlqxWidV13SJFnB3MU9PLhqioc+tqRHJT0N/5wC0UBa5TuuO2sVi9EsPUL4gQmESiK1rkgnjtDDA9ODYYFLE/Q8v5fX5kI+7fVK5CcgYG5bqbua3yZqPBWkYlNNX+KoKNe1mHM1QyJscZX8RPc7rOI1R29BJKmd373eKVBXv+XlUL+fk795mcGeiSwt2RG0QOhKWQr36TUo9tW3YU7xkA2f/XGZqeqdquLVpd2kKEr4yHzQPHohgKwKMv0eTIi+jCJUsHGdQWFIewjLEgoTRi2gn1EDenTwqCgvkOGhd7qnXFSLcxGJmgqx5a+DxTxB6hE+UuNKhugG750HaF8z+4YFpwRnCM+pcKIC3eCMukBv2Jls0AEUg1VbyA3gydY9oi11VddxSdd9zuCTxVkBC1DmwDy0ZmpsxgFF3w3QPqP7G7TnyvGvxtyyjZAaGuhrs7682dR+Kmr3GRMyc0Kct0qYjMQHtxx+evNyCuGr5FefJHXxNfGj9jmrBDZ5Fvulx1/CdmV62xZGvgeYcm4xbZYHKlR34tfohL63CbYMf28fMf8yUuWtVmfmolPWYMgTfgKPeacRyo3c0Q6p3kWEtxkCUnHmTYqdL5grLNlu++I0E+7koeNv+iJ5Fd8LhGczg1GOUX7zaKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0puaGJMbmd4SmYwN0YxaXhnZllJNmFPeW1jSlY2dzZZZzVNcDd1V2UvWVRS?=
 =?utf-8?B?K24xOTNCa1hWd1pNTFBWK1lUbFo1L0xLTzcxTlVvWDd4S2tlcWlUZ05pdWw1?=
 =?utf-8?B?bzlSQkZUWVRheEFMbC9nZlFGcDNVMDI1aHpxV3gyNXlmL3l6ZnN1cTkyRmdJ?=
 =?utf-8?B?eExyenNRY25WdEMxdG9rM0hCS2hPNWNWOFFxOUUvRXJaVnRraFFSeWFBNjN0?=
 =?utf-8?B?WU5IRkRNMWh6QmVZUS9hQXgvV2ZqSFFQWlFTYW9YQVJHM3NKMEJZTEZLb1Ix?=
 =?utf-8?B?WFFuMmpEV0xZTE5UTlhLOHV6UWxjb2N5WE1BbUFvb0IvUWl1MGVkS0VLZ3dm?=
 =?utf-8?B?QitjVDVPWXZWWXZaRmVncm44UmpTTy8yZDNZYktyZnNWV2JwQ040c09oZkF2?=
 =?utf-8?B?ZVQ3T0FZS245aytFT3lZcEpZaWR5UDJ4VmtLcHRnVzhLdWUxNFNCYURnZE8v?=
 =?utf-8?B?TXNkejBVU2RLZEM2MGtnaUk3ekZWQTVGU1Mwemk3ak0vdm1ZRjhTMUFTQ2l5?=
 =?utf-8?B?aEU0NTRqTTFYRTFKMS9BRnhoNEM5bUJ6TVhRS0FqM2VzMHkwYXpPaC92M1JQ?=
 =?utf-8?B?VGlQanQ0T3ZTSnJUOEJRUjJIeEFJckN0UVpod05DNkt6US9GdkhOa2pqSUxv?=
 =?utf-8?B?WFF4OHAxQy9EZkNUbGNzMkRHK3lJc2xuaXY2bytpM3N5TGUvOElEbDNEVEhp?=
 =?utf-8?B?SjExNUxCWUVyWEoyd0grRXpTdjkvRkFoZVg2WXRUcnl1TmZtVTVRdXpMVVdx?=
 =?utf-8?B?L25WZGZRaW41SVgybnpqaEJnRFZySE41YmswUmVGRU43NHRKMkJBLzdxWmZj?=
 =?utf-8?B?ZE9KTUVjdzlscDFnWVFMcWg2U0RZL1hncGM5YzVUR1BUeWdSNHlKMmZKbTBV?=
 =?utf-8?B?cmlTYTduUGFlWGVpbm1tTk5yRHlPdjVrTE1KS0ZYMWdESDgxMU9NYy9pL25x?=
 =?utf-8?B?Y1NNSmZaMTRUbXZQSUlseXFFT2NkT3gvV2VIaFpzQUdJb1dxNVZZOHZlVUd0?=
 =?utf-8?B?U0NIOGZPTWs3eVF4QlFRaVJ3bUFFWnpNR3FrQzVlRk5tRFVtYWltMm1rL1BB?=
 =?utf-8?B?cUxxa2pNendBVTlXZ1JTWUN3dmdKbHlSL1Z3MHZKQ0kwbWIrcGIyZHJmbGpz?=
 =?utf-8?B?NnM3SUJiY3loejNoZEpNL0lSelhVcy9SVjFmcmx4d2EwYjh0cHJIODY0aUFZ?=
 =?utf-8?B?QWVMUkxzcUNVRGhWck40YVAra3B5R3E3Vk1BNHJIdlpFN2dXZlVycnVBTHJM?=
 =?utf-8?B?L1pvOEdJZklybGRuNk4yUTU5SlFSL2tHUkErdlFRZnRVQW5Odi82SXN6b0l6?=
 =?utf-8?B?dG0vQWt0M1JTVUs5MEI4dExNSFVlVkQ1SS9WeFZVT21rUERzSEVTbnNIcXQ5?=
 =?utf-8?B?Z1hSdnBBS1VIbzE3K09qREJOb3MwTCtUUXVRR3pFVm9YNC9DaldGTW5wR1Q0?=
 =?utf-8?B?ZVJ0K0VIeVlWRis3RjdEVmN6Y0FaYUlsdEdMeTYwSEJuVUx0VXNYT1NnT0NB?=
 =?utf-8?B?NzNLNjNIb01IbVNFejBGWmwwTFJ5d25mSXgxbjVqYld1elVRN0NHRkUyajlD?=
 =?utf-8?B?MFFUWnVRc0Fya3hiZWRUaStGRk5WRDFWNVk5RExadTBxZkM2cThRU1N6NW9x?=
 =?utf-8?B?M1hlTUVFTUh5Yy9ramJtczMwcFEreHRaWjlQdTc3c1EwYzV5NktGU2ZPNzA0?=
 =?utf-8?B?MXhBVDZsa0VRalVva3AzK2xHTkorYVhvOHh3dnJZc2tuMW0xeUhxK21PVHMz?=
 =?utf-8?B?VFlEQTVzVnNWbHJ2WTdydlRFR1JYRk01ZkZ1NlVZZ2dycW53N0dydC9UbFBp?=
 =?utf-8?B?dmRLVmF2YjhzZzFWWEwyUGsvVkpiNDdjVUxWWENVQkRsZTdBZ25IYlFGR2lz?=
 =?utf-8?B?ekpFNlMxaWNIdElxZW5lZVFYMThCT2xCSkpzclp1N1N1dVY3amc4aGc3clUr?=
 =?utf-8?B?M29LMWdLNUJsb0lmTE92WkorRVlzOWJBbldTZi9Jak1wQWVGZTM1K0dmWUkr?=
 =?utf-8?B?RldhdDFmSVBlTk0zQXp1ZjdzL21hRUlHV2U2ckE0ZDIyMXd1YVkxRE8ra0hs?=
 =?utf-8?B?Vm5URm1VT3FTY0NmSVJnQjVyWlZ3MWtrZWZGMG5lbUc3Ymo0bE15WU1RaDky?=
 =?utf-8?B?SHl3TmlVRTZqdWZiTW11ZXVvQnk0dWRJRzRUWHpBRTE3R29wWTVxdzVlZ2dl?=
 =?utf-8?B?bGhwaUpvS2M5U1N0TjZvazRZTE1sVjN1Z3JKSGZIMktzdTllZGFqV0R1akpZ?=
 =?utf-8?B?aVFsaDYyTUJMQllEU0lnRlBpdVpDdjdoUXlPbkkwb0owZ2FKN2tRczEwYlNJ?=
 =?utf-8?Q?ICytXV4NC7RB1Gys1N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f045dcf-f3b9-4889-35e8-08df156e0d87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:17:32.9078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrnoLlhA+hhhSScBrJNDuA48aTFNb+TOTglu1Y6T6pX9TdSUrP5mIKm3y5gQStdM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
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

On 9/18/26 03:34, Jiakai Xu wrote:
> init_udmabuf() allocates two pointer arrays with one entry per page of
> the created buffer.  Since commit 1c0844c6184e ("udmabuf: change folios
> array from kmalloc to kvmalloc") these arrays are allocated with
> kvmalloc(), which warns and fails when the requested size exceeds
> INT_MAX bytes.
> 
> With the default size limit of 64 MB the largest possible request was
> far below that threshold, but commit 44e9eb5a7621 ("dma-buf/udmabuf:
> Disable the size limit by default") raised the limit to INT_MAX MB.
> With 4K pages, creating a buffer of more than INT_MAX / 8 pages (about
> 1 TB of pinned memory) now makes kvmalloc() hit its "crazy size"
> WARN_ON_ONCE(), which is trivially triggerable from unprivileged users
> through the UDMABUF_CREATE ioctls:
> 
>   WARNING: CPU: 0 PID: 412 at mm/slub.c:7021 __kvmalloc_node_noprof
>   Call Trace:
>    udmabuf_create
>    udmabuf_ioctl_create_list
> 
> Fix it by rejecting buffers whose page count exceeds what the pointer
> arrays can address before calling init_udmabuf(), returning -EINVAL.

I was already wondering if we won't hit some allocation limit when we drop the general limit.

Please don't add any new check, but rather give a reasonable default size limit.

> 
> Fixes: 1c0844c6184e ("udmabuf: change folios array from kmalloc to kvmalloc")
> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")

Two fixes tags usually doesn't make much sense.

Regards,
Christian.

> Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
> ---
>  drivers/dma-buf/udmabuf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index df6dd00462423..25984e75d7ff3 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -383,6 +383,14 @@ static long udmabuf_create(struct miscdevice *device,
>         if (!pgcnt)
>                 goto err_noinit;
> 
> +       /*
> +        * init_udmabuf() allocates two arrays of pointers, one entry per
> +        * page, with kvmalloc(), which cannot handle sizes larger than
> +        * INT_MAX bytes.
> +        */
> +       if (pgcnt > INT_MAX / sizeof(struct page *))
> +               goto err_noinit;
> +
>         ret = init_udmabuf(ubuf, pgcnt);
>         if (ret)
>                 goto err;
> --
> 2.34.1
> 
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

