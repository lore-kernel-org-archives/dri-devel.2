Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF8606A335
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0a6oXuic
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435D910E92E;
	Thu,  5 Nov 2026 11:33:45 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AB9112372
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 11:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkgi31bhnPgMA44qVcXg3/VEeXzAh4VGyft5JZftORGW8i9vU5cJZbPGoRZWWSFTGwXqI02dGJSzjfPdEB9S1JMVY4ZvKzN5LgyL0iTya2ub+jpu5ZMothqOtEXuB4oF8SNEuy5HDt2xrpwxA/vXRlsZFceyOUUz23PkHldT2kfRXByMznsavBGbemip+rOG1S7Q6wQrSy8wzVSymjj7ScxbbG61PEg2/TcyH0ixdzHV5SXUMKEFJwn9exTNptUU1iO3o7eohLmDts+0HpJhUIx3fvHum3/BEITnF2HgCMRmiRE5PW9sWtdV5P8Rjf2U6pbnNeDj13dnlpkOYgymBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKHcQJkp+AYBaYt8c9Hl8GhuRZeCaAxlB11XwO+LzR8=;
 b=NVqI31E8x0qd7FhSJ5I9iXO15lajCD/KAepGOnXO1PuL5q9FkwXSGD0OwYpCHWEm8YDOujBe7p0CLcSmzvXUJ9Kukp+KDlacfey0yPT319Wo3WZ955sTpyWOiJjeJKBudQiVPSxf8QUndKKGlvyTIJfADcj/Xd20Mb9+JZYTe0B2E9a4LFGGfJxk9ft5C+qtThQGM8uAg2l4nP8NjPg9ZjVny6cuwYenPxCip7IgsSRzdmEj0TUH3G0GWrKCaV0dSRTCxEoNvNs2e4mkNjdJ/d2jhoZyWDmkf2wS5/0WLXv1ammrnHwCB/AKjJfBBeREMZfgg1mMPygZwnBne9jDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKHcQJkp+AYBaYt8c9Hl8GhuRZeCaAxlB11XwO+LzR8=;
 b=0a6oXuicDTzNQIYJPlo9NxuX/Z5wCr0CxBXMpbCl3MbBI4zWX5MftmFlYn3BS8n7rCFpMPWcW7L3BzYJOGMmkOXpaZNyob0RM/UNrc8p2l3DBMNNLt95DOsmrsyYd0UmKIK9vGcqQca2Djo5b8nm8N6/vDTUfmot+YROIkxz65s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 11:33:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 11:33:34 +0000
Message-ID: <e70e62f1-08bc-42cd-9cf8-62ce54cc8be6@amd.com>
Date: Thu, 5 Nov 2026 12:33:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/sw_sync: Avoid taking references to released
 fences
To: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>,
 sumit.semwal@linaro.org, phasta@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, syzkaller-bugs@googlegroups.com,
 syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com
References: <CADZg-m3A_i_X0L-UBi=eMEx7RzhR_sqU5NVLrQ75JJdR=2ASKQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADZg-m3A_i_X0L-UBi=eMEx7RzhR_sqU5NVLrQ75JJdR=2ASKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:408:113::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df37a57-645e-431a-f5a1-08df3b30a038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|261102123227099003|13003099007|261009223027099003|261028144727099003|261022105027099003|11063799006|56012099006|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 8+S1rOB1/KD4WXTAZKwX/74fOOrRce/NNJytYlD/NnkAfEr4KL4NkHrF8LiO79L629+aWU0yqfsA4rlg6O3gp3nsIaTtBgvNdG4ES6b5xClvfNQU0bwauYGwLJdL28stC6y44boxg4771XdYQOyzRKy7LuokFdSXxA3ZQVgCx0y6quPaUanFrQ/a3Hd03iqKlEEN2P3uTvyc6c8ici48l0+15Ina2sOGn7Myxwg/HnhMj8XqOdr5u4jFy1YsxjhePugW6UMj9y4/t0/f48VkRe+beYiiUqcLjIxvIxLtR/shYjvD7Jvf1Dcuenbg2dwOfv6Hn/5wXnc01ym4P70w0xmbr2rDWTn0GyF8gX+VkE4VSaMBfFZHpmtvSNnv3SKXyEjiLs4FD4W3Cg+LP1KK1IQPj+GU/tJkgFw2NPUSjLyjYFDsO8MDWcOtv7Et0p0gG83DWPxfuiLR9v2IggIEJOBhQwmxZhm48oRbofzym+v5d23RO6ihoFjAP4lN4eSOeO70Op87SScKQSkhuP2+lff2XFHHKy0QjPMY8YfELQTPhJQSN+1gpsmZFj+EwPEUag3A2k9oYraHLAdnVonWF0pZbzT8iwK1Eil14n6DrP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(261102123227099003)(13003099007)(261009223027099003)(261028144727099003)(261022105027099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNERC84WEl5T3BsODJidWVCT2k5cUlUaGVuSVBUS0oyeCs5cCt6dThxNnhx?=
 =?utf-8?B?cGZGU0hXcTBBK0hLczdDSXNXMDNtL2lJU05sRzdyYXpEcVExYVNVWUxnV2cw?=
 =?utf-8?B?SHQvUnNIb29ROVBaL3MwZW8vcEJyVnlEZ0pOTGtKa2lxZjFNblBsWmVITVNr?=
 =?utf-8?B?Myt5VnFjZ2hnZzVwc1RnZGFrN2RJZVFNbkh5N3hxcGd6SUFzMEp3dVEvV3Vk?=
 =?utf-8?B?NGRScVlEd2FEdko3NkVpTGw5N2NNN3dqRThHMDYza0VqZE0rb1locVRHVDF2?=
 =?utf-8?B?TmgraDRITm5ZN1lNSjJMQlZUSzhwVWc5dGdydW0xdlJGbkh6MjVvNDlERXNm?=
 =?utf-8?B?OHJnc3ZHaW5MUUpBYXZXTDYrVC8zVFRzK3VsR2FPWXdhOHNBUHVhaXJteVdC?=
 =?utf-8?B?WEE0cTZlVnJnVHdmZDlpM1pjckZIZTRxWmhKKzArWnRJTjRUcms2dm16Z280?=
 =?utf-8?B?eWVha2IxcTRqOG5WSjVXSE9FK1c4MERJYlZ2bVl4R1BqWGpKcG5jNDNrQnlX?=
 =?utf-8?B?OVFnbHdKTFJZb21KaFo5YmtCem9PNktZdVd5eUF1MlJ5WjNhTENvTExBV1Bq?=
 =?utf-8?B?ZHJHTUxJcXNoQWpwYkpDT2VNQ3EwdTRaYmlCVzJUa1JTZGxtczE1TVdocENW?=
 =?utf-8?B?WCtnV1FTR1AzcE00a1ZJMzU2bjBnQi9nNHRMWkZhU0lFa05FVERZRmVtSlJt?=
 =?utf-8?B?WWZJeFBqenVVMHNKR0RlU2tnaENmWlk5clV2aituK2E1dUtPMDJQcENQeUJM?=
 =?utf-8?B?eHJOUDVGVmZoMDMvcDZwRzRlVzVmMnZoUm9Jb3RiZnE4SWQwODA5Nk9lcG9M?=
 =?utf-8?B?anpDK2dSeDh4VGR6OEVVTTkyb0hKc2tTR2lDSkwyUm5UQ1NHV0FvclIzVjF3?=
 =?utf-8?B?VS9lU2M0MXJ5d0RQYUNDVHlGQTNaWXNNak9FWnhMRldoQ2tWcEZJRjB5Tm44?=
 =?utf-8?B?bjJLcUNINE1Qa3Z5b0w1TXUxNUlRVklQTzJDWVlHS1B0c2tNekdpSGtQQlFX?=
 =?utf-8?B?SzFEWnJyaDgrakcweXQ5TGMzSWh3VTVBdUdERU1aaXZab0ZIUWtxZzBPRzZ4?=
 =?utf-8?B?WWlFTTRUd0RVL2ZNeno2UjdnVUdacmRnbVE2TkhPeTM4REFzME55d0w4V2FF?=
 =?utf-8?B?QkRFQVUyM25xTjBwa1g1OGx0eHhmbmhYNUt4aVBiV0xkekZraEltN0FhMXVE?=
 =?utf-8?B?cDlyVUxoY1dpT1AzUmZiNC9JNVNES2pRSlFBWDdWSmZ0Z2NESngxQXlZeXlU?=
 =?utf-8?B?cXBrRWF6OFJmVXdpTThLLzVZK2NGQndOUDlUbktPZVNGQ0FXdE83NGIrdUtK?=
 =?utf-8?B?WGtGbjVITGxOTGVSaGZiV1JGK0pHM1lacjE2Y0Z2MlNvVGlIVFN0VGN5anV0?=
 =?utf-8?B?Y3BaMHVKQzdLUkNWQkYxb0hmVUQvSnVPQWl3c2hvdmluNVkvblJpVEFSeFh3?=
 =?utf-8?B?Rmh3WWErTFlsdzh2dWc2NUU0bTFjYWVBUzhMSE52aTQzdzNFMnYvNW1JUVRF?=
 =?utf-8?B?bnlaWWEwUHQxd1JQeEsxR0JhakZGZjJ1WE1IK0pUUVh3d0RDZ29XYlI0bzFy?=
 =?utf-8?B?MzJWakQ2L09ERDZuTmVOMTFQUlhVNThWOEdoU0FqR2pUUEc5U2ExT1RRcjRt?=
 =?utf-8?B?c1dwa2toNERobmoyWlowbU5uYWxicmNLQW8raXpvTXUvR1BPQWJMdmhBVFhy?=
 =?utf-8?B?bklmbnRyYjQ0YnlRbGROTUd1a29rOE8zbHNkRU1Xd01XVGozNmlMS3hhVk9n?=
 =?utf-8?B?bnlPTmJBK2NGMUVCbmJIMUVZZnJFL2Nqa3A4T2FwN2l5ZXJzL3d3QUtLdTdh?=
 =?utf-8?B?cy9UL2tQbzV0cHk1TTVrTlNZcExsNDNOYmg2T3JCL3I4bVdpL29tWGtacWYx?=
 =?utf-8?B?UzM2MEJHa01QRm9KZ1lYT1ZLTnQ2MndDd1F4TWVBVzNacFh1UlU0SzBWY0pY?=
 =?utf-8?B?WEpvcDg2SUV1L0lQYUNCR1UzTW9jc0JIVkNEM2JGR3BjZGxBQWh5Q1ZLUWZB?=
 =?utf-8?B?WmM0a055MC9GWUNvOXR5bzRMSytGMmhIVytZV2VQQmMzWGVtRVgremh6ZmM3?=
 =?utf-8?B?R3ZBUUlpUHJNYTRYdkVlZ2NJaVIvNFlJZStDTXB6SUxwL21vTWJSZ014VVJ6?=
 =?utf-8?B?Q21TcWtLQWFqQVNQTm44K28wYkx4QnhyWVMrZ3dSWmprelJsemVBSXg1Qzdj?=
 =?utf-8?B?NzBSS0R0cjJhZUpqcE5RTEcvbGZxY3ZacGlnNk9EcEN6L1NkN0FmNFJ3a3A4?=
 =?utf-8?B?TkxlMFBjV0NWU0JaWHhNVHFSTlc2aDIza3UzNU5nOGZMT29rTVhRK3J6dldJ?=
 =?utf-8?Q?Ieu4VkavW5DRQve0fI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df37a57-645e-431a-f5a1-08df3b30a038
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:33:34.4168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwAD0r9NyzQKR4synhv7+gEcu/pkCKBFqi1p1l7e07lTwXd3TN/Z2ZJyVABL0Ctm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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

On 11/4/26 23:18, Kirtikumar Anandrao Ramchandani wrote:
> The last dma_fence_put() can drop a sync point's reference count to
> zero before timeline_fence_release() acquires the timeline lock to
> remove it from pt_list. If sync_timeline_signal() acquires the lock in
> that window, dma_fence_get() attempts to increment a zero reference
> count and triggers a refcount warning.
> 
> Use dma_fence_get_rcu() to acquire the temporary signaling reference
> only if the fence is still referenced, as sync_pt_create() already
> does when looking up an existing point. Skip a point whose reference
> count has reached zero: its release callback will remove it from the
> list and tree once the timeline lock is released.
> 

> The timeline lock prevents the release callback from removing or
> freeing a listed point during this check. For a live point, retain the
> temporary reference until after dropping the lock, preserving the
> protection against recursive locking from signaling callbacks.

Please add this explanation as code comment to the patch.

> 
> Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during fence signal")

Drop that here. SW_SYNC is a unit testing functionality which can intentionally crash the kernel.

You get literally tons of warnings and a tainted kernel when it is enabled/used. So bugs like those are generally not backported.

Apart from that the patch looks good to me,
Christian.

> Reported-by: syzbot+cba1a1f459230395a076@syzkaller.appspotmail.com <mailto:syzbot%2Bcba1a1f459230395a076@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076 <https://syzkaller.appspot.com/bug?extid=cba1a1f459230395a076>
> Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com <mailto:kirtiar15502@gmail.com>>
> ---
> 
>  drivers/dma-buf/sw_sync.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..7f1eadee4cdf 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -221,7 +221,8 @@
>                 if (!timeline_fence_signaled(&pt->base))
>                         break;
> 
> -               dma_fence_get(&pt->base);
> +               if (!dma_fence_get_rcu(&pt->base))
> +                       continue;
> 
>                 list_move_tail(&pt->link, &signalled);
>                 rb_erase(&pt->node, &obj->pt_tree);
> 
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d

