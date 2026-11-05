Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48B606CC5F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4TGZCA/r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA1610E119;
	Thu,  5 Nov 2026 09:53:42 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6F21122C4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4omAFbXuiw0ozPw7mB3kWXa5NkzDsX1R60uSW/B+ZqaWGt6xAE8u/LFvTz0nsFa8zV4x7ZU4X/9ZMxH9iV3F4ssy7ySwUWt2H+IVrBfDmzsjuMK+4JkebSermwwRbY419KBUSHNrZPfNvNAVRewHdDCi0b4QuRFzuYfodpgNFsw1EwxeYXq88wQFIhALvg/EL0IJu4ALfDwnkJLlRdhUwLo+s4ztv9p0DXaUlwteE8QnHcMIGx4FBwTTOsyPcq8YruDWn0epZZMmjB804aVVWw7XWs/Wyl2aJ7BPQZO6Jj0aDDum0FwR0eyJJUk/RMAjHoLy9zPSPu/mrDDyGfOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g26iQERvxD3+UKLc0m0OCytuhHQ0kbDsf+2N+szuAV4=;
 b=o12yfeX/qfH+XZ5YNeSTXs+oH2GfuY0rzU8y/aKSbgdlLcb5Jt2guS1+UlK/PV5kUMq6AprG2UYXBwwCinpCtgBP/bzywqBaC3mihk02O1QuRSY6cAI/BR2RSBCiWjM+DzjjrJ5t+foigIrapsgTVjz1sKyMLSBHIEuks3mSijuE1nCDe9F8jpfchMkHNHkiQLYU7AwGuqfc9CGso0ABsYuBLYkQ472w3ruLOLK2Vc99Hm/ru+PAEQwi4EEwycczPYk/7Z7usidEQQacTTWe++ILwXvNTsupId5I85hm8tFYvu5CxbGHFfP7SuJjpKYLbd1Foja00AAdlHsJfuQOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g26iQERvxD3+UKLc0m0OCytuhHQ0kbDsf+2N+szuAV4=;
 b=4TGZCA/r4ORGC0eiIOOVN3uldzEBmWkvyRCb12scUiFZbznhlgPLbmLBJOs3TtnYSIy71K25FZbqvRuLs6PZ6t3xOz7v05/BsM4ExtvgumaVDJ/3CiGIq9egoXk8YbiFgnNhHsd3Zoq9ZhaUoyycXmyV+Vz8PNl5Oieu9WhBMCE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 09:53:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 09:53:32 +0000
Message-ID: <62ccc693-3923-4587-ae4d-aa5167f59c33@amd.com>
Date: Thu, 5 Nov 2026 10:53:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/sw_sync: Optimize the retrieval of fence
 reference counts
To: Edward Adam Davis <eadavis@sina.com>,
 syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 sumit.semwal@linaro.org, phasta@kernel.org, robin.clark@oss.qualcomm.com
References: <6aead2eb.3c6f2eba.20048d.0000.GAE@google.com>
 <20261105041446.51979-1-eadavis@sina.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261105041446.51979-1-eadavis@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 09782fb1-708a-46cd-3aff-08df3b22a700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261026121527099003|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AiMf/Qbw7FiyYG+8NGUIFRbXyZVBtO1OZpE/OjQq924QX+MwWqiB7/Du/86aJhzsGbracgzjhA/Z0UTFgbHlpD/vfAwU37A0IvaP9+5+EbERd2OXwiACdxckP5Q76ypNcLp2GflhttrBwYiW9qrys926PXHCmZ/T0rKGvTslvRmB7FZ6B6hZixpKoE9IghSUTfg+OcsikDRykQs4umscv1eqoVj+fc3Y4FLgzXNmVbthqNP9t0OU/75GUG7FSmAkY8kd5fJULv8FY+BOZHhPajNzN5W0qhEsma8cPittJNejEXUmx4RcZaODzH2Xfw/HDDm0uRHlSeHPVpk9Vjo3fvIqg1yASLT1AOAeMExYK1JDwyqFJuFW7z0amwyIlaWMF8r6eHPE6BbeBbvQ4VAiSHwrihT7W27R/I+x7WkshSItXdufYiBlZjTELKLl2Bdfmftp02MaoPORVYGfbgvij4jfOMV82pAWFMIoJaPZUZivCJL1jrR67hiH3qVg4GLQ+8G9qdPaBOKBmLiNk74szIEDeldZKhQ7t6uUXl+it5oyau2SrIj7nb0BdmZkoguYa8f/Llecp9lZXYsqZMABUoyASRNtPx14GRs2FNcro7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S281NEtXN2pNZ0NiOEpTN1owUW9EZ3hXQkh6N2RyU3RCWGxPMm5jZWRMNVNn?=
 =?utf-8?B?a2NEWEcrcE5HTHl0ZVVMUmwxU0NwcGxiVlpJSWdQa3h6UEpZdnkzd1FoNUQx?=
 =?utf-8?B?eVhIRU4yeXZJVkorNnJLMXhWQ2tNUnRiNHhpNGN4OG5VczRQd3U1WTJGallS?=
 =?utf-8?B?V2R0WDIwNURnNHNGWUNBQlllZklpeFdVOWVaNkFqdHRlWXB3VWEwSFFjSWdp?=
 =?utf-8?B?OG5KcUhBY2plNUJrU0JqdXlPNDJVMnFzY2RIRVFyUWlQRmowS2d4UlJqaVJG?=
 =?utf-8?B?VlpPNy9kb0JLY1A1a3NPdWlKbU0zWFdWNnFTMU8vRXRpOXN2YjdYUmF2cHBL?=
 =?utf-8?B?YzlCemd5c1BhUldZc243OWxqSllUNU5CK1lIZ21zUExDcEcyYXI5eDF3VkQv?=
 =?utf-8?B?TjBKSXc5L2x2TXZVcmxFeEp3VlFUVk5lZTZHVDVQU28vbDNURmtyMk1TbWFX?=
 =?utf-8?B?bk9nSHFsemJYN3lhQXRRSnRBcEg2YVB0T0xxNjh0M3hRVExjeFUrVW9RMW56?=
 =?utf-8?B?UzE2MHNXMDl1alhmT3NMUnRxaGM5dmhRditlZE9XanRGNEJ2RmM2NFQxS3Rk?=
 =?utf-8?B?UjZtcWxzRjB4S3JWR3NSRFJlOGQzVnBVbTczNkhnbDZ1eThWemFIWWRSTUx0?=
 =?utf-8?B?K2RaK1hBQUhjbms5S0ZxNENxWUxVY3NvSkp0Z3pNK01EWXVTKzcvZnltZDlB?=
 =?utf-8?B?elR0RW9aYW95dC9sQW9hN3M1dWdMUTZEVzdKL2pJcHdETUJNQUhYRTlmUHhF?=
 =?utf-8?B?WmE4SjBGUFNYQWNCK1hoUGxJV0trNFdiRHZza0ptaWZvN1MwQ1ZjeGs4dFVi?=
 =?utf-8?B?Q0ZYdVRsRXVxY3ZaK1hkdGdNR2k1Yk9EWW44dytSZ0kzNjNYVy9rOVRsQXVl?=
 =?utf-8?B?cUFWSktMY21lckdRUGkvdmlMMkRSM1pqUFNibDQxeUZuWE5DV2NIQ2xVNXZw?=
 =?utf-8?B?bCtlNXE4d0U3TVFUbXRrWDN4cXFzakM0cm5CZWVuYzhSbklLY1hManhTWUE3?=
 =?utf-8?B?WDhvZytaVkRoTG14ekNlR0FaOUV4MmhpOUpSTGNpQUtFTTBVRnBheUFHQ3lX?=
 =?utf-8?B?azFWZlVNSGdPUVU5bVNiNHNwb3B2dGg3WVlSZG5iaEp2YmtpNTE0R2JsTElW?=
 =?utf-8?B?dlVlQUdLTW1Tak8wZ2pLSG0xaEFNdEV5bDF2Z3crQnBNazY2UHVnamxkRGt2?=
 =?utf-8?B?cGFtbitUWVVhU1ZqTTlWb08za2wzMkdYdVNIQlF2MUxOZW1mQnVNR0M4NXJW?=
 =?utf-8?B?WUp6bllwRjErd01OOWZsSkN0YXh5SkpYdUc5VFI2U21COElFeU9DWFJ0Q0dz?=
 =?utf-8?B?LzQvRnpFamcvdnBNRG9QK3JJc0szQ28wM3gxNUhtZ2Q4M3BDdmcrVVB4L0hB?=
 =?utf-8?B?R2NNOE9KNWFydXprdkI5OW9LbnVwdjkwb1hOZFVFRStSdjJnM1h6d2xGajZ6?=
 =?utf-8?B?NGlJRjZrcFNOanIyNnhRWTNwby9mR1Fzd3FvZGlGbkUraDZCeEYzUHR6S1B1?=
 =?utf-8?B?OE5oclRDeWNoR2pwcEZ3YkFlK0lidmJjalhZeU9QNlVwZ044YVpPZDdQTWVN?=
 =?utf-8?B?NUhZWEZOVjhteHVuQmdJdGpRYzRPWFF5YVVRR253RlMyVzhJb0x6WTVvaUdE?=
 =?utf-8?B?dE9UdlFZNzJmRURJK1JoNW5Cd3Z1c1ovb2VLKzc2aFhLNlhuWjB6RFNURFNp?=
 =?utf-8?B?MzZKQkJFSzc5MkQ1YnhRZENKeWh6bTA1N1lFK1dYeXBRQzRFTitxU1pRZDlo?=
 =?utf-8?B?bWNPSVBRUmNHSkpES2tmTTM4dkFDdWszU2xtSVBrWEtkSzAzZGk4bytkQmJM?=
 =?utf-8?B?Q004MjdVMDhzSDJHdmcxeEo5eG5ua2xFeTlwTFhWT3pUdUVLRG95Q1EyUi8r?=
 =?utf-8?B?b0FVL1NDUzRtL0E1VVUvYklic2RLUWVHTHIwUUJCSDh5cVB0aUp4YUZ3d0dB?=
 =?utf-8?B?cXVBWllRQ2pLSHJWSGt5VWUrMmtTTUFGR3RvLzg2MkJiSmlyN1R0a0VGb0VO?=
 =?utf-8?B?bm5LUE5sMklnc2tORktjbG41UHJMNzVDQUVrNUNhM3gzK1NvVW1kZmkwdU9Q?=
 =?utf-8?B?N1A1cE1zZFRMVFEzK1hlQTA2WDNzYlQyNDM4TVlhajNGZVBnR1g5RXhPbHZI?=
 =?utf-8?B?T3JQYXp5TStWRDlJN2p0bGkxRmpJQWZ6MEQybUlHRDQ4RHk2OWpJUTZRWlJ2?=
 =?utf-8?B?emhpR2dkN2ZENlZaTXJpSTBjdWdySjh3ZUhDdGJpQk9VYytnYkR2MHdMZi8w?=
 =?utf-8?B?U1QwWUtVUU43Z2NnYlN4OElydXlaaEVvUGxPVk9qY2dRRy9zb0NlUDl0WVNw?=
 =?utf-8?Q?8wzZ4Sp5gHL2fUpq4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09782fb1-708a-46cd-3aff-08df3b22a700
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:53:32.9293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpnNDY2V7Jj1q/IguopQWDUSynxvoD4bWaVC//rKZsL4Hy7XZQ/tGXFeyq2iv5P3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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

On 11/5/26 05:14, Edward Adam Davis wrote:
> There is a race condition between closing a sync file and the SW_SYNC_IOC_INC
> operation on a sync obj. When a fence is created via SW_SYNC_IOC_CREATE_FENCE,
> its reference count is initialized to 1. When the sync file is closed, the
> fence's reference count drops to 0. A race occurs if SW_SYNC_IOC_INC accesses
> the fence whose ref count has already reached 0 before dma_fence_release()
> calls timeline_fence_release() to erase the corresponding pt_tree node from
> the sync object, potentially hitting:
> 
> refcount_t: addition on 0; use-after-free.
> ------------[ cut here ]------------
> kernel BUG at lib/refcount.c:34!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> Call Trace:
>  kref_get include/linux/kref.h:45 [inline]
>  dma_fence_get include/linux/dma-fence.h:323 [inline]
>  sync_timeline_signal+0x6d9/0x8a0 drivers/dma-buf/sw_sync.c:224
>  sw_sync_ioctl_inc drivers/dma-buf/sw_sync.c:405 [inline]
>  sw_sync_ioctl+0x7b4/0x13f0 drivers/dma-buf/sw_sync.c:470
> 
> Use kref_get_unless_zero() to optimize dma_get_fence(), in order to avoid
> acquiring an object with a reference count of 0.
> 
> Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during fence signal")
> Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> ---
>  drivers/dma-buf/sw_sync.c | 3 ++-
>  include/linux/dma-fence.h | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..ad60ad5e5cd9 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -221,7 +221,8 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
>                 if (!timeline_fence_signaled(&pt->base))
>                         break;
> 
> -               dma_fence_get(&pt->base);
> +               if (!dma_fence_get(&pt->base))
> +                       continue;
> 
>                 list_move_tail(&pt->link, &signalled);
>                 rb_erase(&pt->node, &obj->pt_tree);
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..4d885c8e1d4f 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -320,8 +320,9 @@ static inline void dma_fence_put(struct dma_fence *fence)
>  static inline struct dma_fence *dma_fence_get(struct dma_fence *fence)
>  {
>         if (fence)
> -               kref_get(&fence->refcount);
> -       return fence;
> +               if (kref_get_unless_zero(&fence->refcount))
> +                       return fence;
> +       return NULL;

Well we should have an automated filter function for nonsense like that.

First of all we have an dma_fence_get_rcu() function which uses kref_get_unless_zero() for this use case, so modifying the dma_fence_get() function is a clear no-go.

Then SW_SYNC is a testing functionality which can literally be used to intentionally crash the kernel with it! There is a massive warning and tainting the kernel when you try to use it.

So a race condition like that one here is completely negligible to this and so there is no justification for any stable backport whatsoever. We could of course fix it to improve the documentation purpose of the code, but that's about it.

And all of this is either obvious by reading the three lines of code below the ones you modified and/or the documentation of the component.

So please before you send out anything like that take a look around and thing for a few seconds if that really makes sense or is just a waste of time.

Regards,
Christian.

>  }
> 
>  /**
> --
> 2.43.0
> 

