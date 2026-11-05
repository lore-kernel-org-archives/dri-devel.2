Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379A606D824
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4k37sL2B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDFC10E09D;
	Thu,  5 Nov 2026 10:03:34 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341A110E09D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilWJmmqP+r/aLpLt/YxRcG0cY7e7mfvOV9XXoygd4X9hsemf6fqj0AIdHd4UljzJmlYuVppizIAnqirApMfI9LOTzJ2ws/LpoxZKkLqcjSxWwFYyYckkX5hIfWNkwDR8K46F0w6mcEQifX41IXQpbmFSNTMg0WvfK/OonwtBG//7774mgdJ/lNaV4wzvXHGHspBTUaTgZcde1GGnNa6mLIyTAEQlhz8MMoGEkZVNzNicHg8g/z4l/MiDZQkHMRF4i6R44T73pLesAAUqsvxBGkxYKAF/bRmqPRQU+g4Q7ZYDmhK1/3sl7T9cxEgLJdghvxCq2xLPUUceXvrLjdT+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm57Gqgiv85Pefqh/D2kJBUE8d4L8laOJpvnqOY4kuU=;
 b=xyMVM8HMkQN+iTutA9qWsNKGGnTVtfP9wy7X/mwJB8IOO+wIM9dp7m25cfLFJyOz+15z/kVajVx67x9BLCPJ4aeGHa5rO230yl0wWZQu5xSYfxxGpaNZOJzW28qqJyK8YUEtKSO/vEL1xlHMquK6fymbAEd5P/+LCat71dfRPIr7MM1m5E0KUSu/M1iIWvzDDt9ldtzJVTUdX9BCD+BJ5+o2Sa2iwNVmpe7KUFMlH/r2g9xzSNF5iBcktYw4faNhidh7W2M8OhLiJkh3W9Z/6KBBK1FyW3mxqTL1bVpZgGP4+MfK7D1tEDY2WcZ1o13Jz7vwOgrksM+cwqGVvYU6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm57Gqgiv85Pefqh/D2kJBUE8d4L8laOJpvnqOY4kuU=;
 b=4k37sL2BGuaFi2B/GPekBWSSYIO1k4/4L+mGu4oHqxjpxK4LsFygLVUFWy7syh21w0DVl75iS3pJ7K+YpBX4CsJn2fw6R7AG/VMMP985t/yXSE3OyyoyQ4JNoaxDitJ3JXN/+NYwCZnoaXthQmMzYoVBDfo04O5F1OS6GgXcH2w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 10:03:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 10:03:16 +0000
Message-ID: <ad203438-ddbe-4445-bb3e-9632e738c1a5@amd.com>
Date: Thu, 5 Nov 2026 11:03:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf/sw_sync: Optimize the retrieval of fence
 reference counts
To: Edward Adam Davis <eadavis@sina.com>, sashiko-bot@kernel.org
Cc: media-ci@linuxtv.org, sashiko-reviews@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 sumit.semwal@linaro.org, phasta@kernel.org, robin.clark@oss.qualcomm.com
References: <sashiko-outbox-198550@kernel.org>
 <20261105052707.55911-1-eadavis@sina.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261105052707.55911-1-eadavis@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: febb2e17-70e8-4f95-4d53-08df3b2402e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|261026121527099003|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NTAMNDSJ1MLTVZ9uKPCjF7JRxEMBk583goWW1C+BLKFcRFn8EGAksPro9W48J//cWPVS1apsflpJW9t1ve3XX9oaVMwCYfvM7giJji/DgReRPjrbwMfQnSaL1EVgbZuEBZ+dWIUx38hqmF6Y7ILHQKxq+WW0JX0S9GYfrNL2sj5gPheKDYyGiS45BVuwz0PdlcHf60oucOSR8AMTWERgXg0GD4kBKVS+jFGrztu/AOQ7yhY55mRh/g/le5xFTIxbr2a4cOU7HsK7OE+WCzo7XkXRsEnwjVVP90aSYhHKvQ6g4lUGFZBfjwX/y2wowVnT8R4hrViW83G2+t2ywrBhENJZBiNy/CTuB6v75tRel7V0jvmHvdzLzZK18JxE3dhkvK3ZZehkLD8yt4tVxp0GDpztQRTJkmkLKAeDEQhPRdww0yfObQv3ODSqA9FItkA8nBQ2o47bdhFWsRaeb0hzBvOk6q7lzVA2vN51ss9PBg94SI7xPzveA6NSFB/mVCYfXktE0VeM3bptfXRVjX/u5Yolvyrs0F9XZ9r8Z/OTRiIBqmW1tmNYHXie5phR4Va/maRAUTeXyEQxm06evAmOAzlJ3Ds35Ta6ztc60xqxZeOZzA/QWKNfQuulfwxiTlWS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9HczNCcTB3VDg2SzRqTElFWUFiK3Bib001Z1RTTEpIWFdDeDBqK0kyNlBQ?=
 =?utf-8?B?L0xHNSswenl2UU82am1EeHBhczdudGFiQ1JoQUxmTXBoZGhjcmhZN1FDdjRU?=
 =?utf-8?B?aXdVbVAxZDlJVjlaY3FReDFvako1U0YrTjZMTHByWGowR3o2UWppakpLSzhP?=
 =?utf-8?B?dE9PNlgrME5HQytFY1p1K3UxTUFkUjRNREt5QVZ5RlZMb3RVeUM4a3M5eW9t?=
 =?utf-8?B?cGh6ZHNPMmwzUVloc1RWaXdXb1RRRkN5SElCYUVKRWFXRDEreFdxbzNsK0xa?=
 =?utf-8?B?c09ZRmxZTCthOGJIRWF0YWxkUldQcmtHOVpwYkRGWU10MkhHV2RQTjVhTzYr?=
 =?utf-8?B?c0I0NWhHSlEwTS9PUEd3K0hubHNRR01zbmZ6Ky9iVWxlK1Q3SVh2ZjAwZWtO?=
 =?utf-8?B?ZkFuZThyNnR6NWNIWDN0ZW0yaWFEZTYrUG1kZUZpSzVTYlEvTGdySVNxQUhK?=
 =?utf-8?B?dkhLWFkrSitDbTFZQlFTZks2d2JBelVSR2c3K2loaCs4bHRBMzVWeWF4RlEv?=
 =?utf-8?B?aTc0M1pLM2JBTFdGOG9qZlhQTS83NURYa0ptNlE4WkwvUmJzREhDUjJPNzk5?=
 =?utf-8?B?L3NHc3BoMjVxN0w5VkdjQVgzYlFOckJHZFZVK0xkQVFHVmZ1RDlxZUJlbzBw?=
 =?utf-8?B?ZUxCbGkvcHFyVDRVQ3A3ekdSdjZ6bXVzbFhVVVI3MmppSFB3c0ZQcVVHRnNz?=
 =?utf-8?B?Wlg0RXorS01lanBYWEVMQ1N3Wks5OXNJaWV4WFJub2FvRHQvNkJ3ckRtQVM2?=
 =?utf-8?B?VHBpRU1mQTBJenpFMTIzc2VwUkNqUGZhUFVzbmtEMTJxTGJ1UnN3TGJIbjEz?=
 =?utf-8?B?YlZpeU0xWTRZb2JudG9qQWF3S3RsTDJJdzR4dXdjZm9maW9Vejh6Tld4Q3pX?=
 =?utf-8?B?ZlBUdnoxTlUrSzZGSC9uZjJnVlVGeUR0WnBhM2hkQ3RHQkR5a1M0bzgzcHBS?=
 =?utf-8?B?b1VWcEtucFhMeTBZdGJaa2dWTUlJQWxPUXRjeDJsVXp0SVRKNkRtajh3ZStm?=
 =?utf-8?B?VTZ2SU5WMjV1WlNpV2pLSDNHWmZpNkZPUlBZYTdFanlEMmdrUnhOTkpDMzRp?=
 =?utf-8?B?THFtU3dqTEUrRzVuVVJVcWR2Z1BabzdyRjRIa2twejUyeDk4QzZhdzB0eHpL?=
 =?utf-8?B?OVFWN3djcTlTNFFMN3FkeGVHZDlDVk9pdjBnempKNUxicFZWNSt4V3pHVGdt?=
 =?utf-8?B?dHNyS1hYa2dhcVR3SXdhN1hZeERvaHFwcmhITGlGSENNREVjbitaQjJYcjBG?=
 =?utf-8?B?cUZWMmlyVWM1eFJTSW1hbnNvR0NlVmttbmlsOEJpVkMxSlh0YmloQkpqSS9p?=
 =?utf-8?B?MUFtY0pLQ1VRWTFLa1JrUmhuc21KLzF4SjhJM2tCMjFVZ0RvTjZrQnZobzFJ?=
 =?utf-8?B?M1Fmams1cW1XcmRkMUExRUlIK3JJR1U2RXd6NHpzeFZTc3VzdkdRbGxvQ05s?=
 =?utf-8?B?OWhNWDFEeGEvcjNhSjBhSW5mQUlwK2d4U0VBa2VEZ3lOTi8yYURxTitsWWxM?=
 =?utf-8?B?aENvZjZLMlhkdmFJeEM1Y2liOUl6dXNaZDB2V1U3Uk8vUnJUcDFQNzM3clNT?=
 =?utf-8?B?czZTMlBJZXZ4VU4yK3IySnZ6L1JjajdpRW8rVHNYSkpFcjdETjFOOG9qUEdL?=
 =?utf-8?B?ZWpzYWJLVmsrYldlYmRZd3ZESGhsaXZGaUJibytmdFFuWHVjRmllUmU2WFMx?=
 =?utf-8?B?bENpOWEvR0tBcDYxc0luTmFrY2R5c3dVT1RJR1JVMFJ0aU1ybWkwZWt0MHVS?=
 =?utf-8?B?bStPeFcwb1BDbko3a1ByOTJRRUdQVnYxaCtBNUVpTXJCbkl3TVBxdUpIZlVQ?=
 =?utf-8?B?VW5hcTJvRXlJQnUzS1dEK1g0bHYxbVVCMUdNRjdqTVBCc3ZCV09jeWFXWmtE?=
 =?utf-8?B?TDZKUGM3SmRpV0kvMGI1cmVZa0Vya1ZNdE10UWpKd2gyYTkvUUE3MWI5TXVs?=
 =?utf-8?B?R2NzOWhoVnlCZkRYSVEvUDJUWFhMMnNwbmozZUdhNzJSUlhMcXNES1pCRVpR?=
 =?utf-8?B?WFNjeHpjc0djd1RVRGMzMnNtOGNTZlliNzFvSmI3MWkvN1NVL1EybXJBN3VZ?=
 =?utf-8?B?d1k3eUdVR2FKdTkrN2JLODE4dVFUYlhYNGRHMWtEQllVZkFjcklOZjJKZkhR?=
 =?utf-8?B?OGQvdXNWczZId2UrQU11Z1E4aXlMS2wrMjh1RUg5M3AweEdsU2FqcVBseHc3?=
 =?utf-8?B?QmVRSUpBaTFyYUVlSzY0bmJibDBGdnI4Z0dza3Fva3VEYnBNYXNLb1RmM3kv?=
 =?utf-8?B?ek9oYzNwVkVjZVkzMUlzVDdHb0ROY3ZRZUVIMHo2NTlQLzdTSHJEc2dZUXpu?=
 =?utf-8?Q?JqlrbgDeanBjgy2jUU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febb2e17-70e8-4f95-4d53-08df3b2402e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:03:16.4711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oU1cmOYCTZv5QEZx3mekmIFblCL3qlNvLwEOkQLtKEDpfkS8OMhLDmdCM/91+0Fc
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

On 11/5/26 06:27, Edward Adam Davis wrote:
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
> Use dma_fence_get_rcu() to replace dma_get_fence(), if fence reference
> count is 0 then do like timeline fence release things: remove pt link
> and erase pt node.
> 
> Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during fence signal")

Please completely drop that. This is not something which has any justification to be backported.

> Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> ---
> v1 -> v2: use dma_fence_get_rcu() and remove link & erase pt node
> 
>  drivers/dma-buf/sw_sync.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..261bc98b1ed6 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -221,7 +221,11 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
>                 if (!timeline_fence_signaled(&pt->base))
>                         break;
> 
> -               dma_fence_get(&pt->base);
> +               if (!dma_fence_get_rcu(&pt->base)) {

Well that is at least better than before but still needs a code comment explaining why this is possible without holding the RCU read side lock.

Something like /* It's possible to race with timeline_fence_release() here */.

> +                       list_del_init(&pt->link);
> +                       rb_erase(&pt->node, &obj->pt_tree);

What happens is that you race with timeline_fence_release(), so that here is superfluous and potentially even harmful.

Regards,
Christian.

> +                       continue;
> +               }
> 
>                 list_move_tail(&pt->link, &signalled);
>                 rb_erase(&pt->node, &obj->pt_tree);
> --
> 2.43.0
> 

