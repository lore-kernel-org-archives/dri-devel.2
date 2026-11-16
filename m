Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15845606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=foQxsjoV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F10210E3FA;
	Mon, 16 Nov 2026 20:16:04 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6160210E3FA;
 Mon, 16 Nov 2026 20:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGSP3pPixZWgAXAy0uC9KxfCT4HsaiLx9EPxqBys6Lhvz9sTGgyERSeo5uRKkKkMCexBMPNiRZ6yhBvr6ObLZh/nLuBDqNT7qaHMtgiq+UGuL+CEQgfYFdQ0w9r0rWP/Q9jqQT2p2v5AJTF0jXvVNKH6U9zuAxnuQvYkg90fVjugYC0yMBZVzT2bkvHwOgq7228FfbqjE/1T1TweaqczdtKHX5MmsPHr6EXG1KOy4PYgMpEYBLgZeX6dj0NBgcaA+pKtzSAC01fvtsgbrbzk1HvAPsM8F50bA7W3UhTNkihVUQHYAhe7ufXbZYh+N4j3Be/RBcXTp83Z5EuDgltCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzGHpUekxn96lQ+rwbvn4r7UshWjO8c3qNckj6YkFwA=;
 b=Vtz12T/fnu9GiIqQCfdy78ovccdoRGTxxSrnkj3wDKY7fZzGK1Gn+HI3CLnGDdNjsBjTSp5NXo9CmWw9QHPoT+6zE2xNYCaYYVG8YTtJldVypnXtLE2pXV9ISRu0v3VZzM7qxkPMMGC/5cT0Uw/JzyplByM87h7wCbvSPAXBcuSp/QfU/Sn0PYhnzq/u1qfazu2XRpCuuDny1hKqFrfFRpoW6ylSKJzqRMMZvmvH2i2fmGyBsl0l5TMmHWWI9tdD4K/s/lssjHc1MQA/HVlABHO++lxYZCdxtibmYxcDhFv5lHkcjUHa8bvxmrxh4348K+vbIUwvv1DljdtYdikkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzGHpUekxn96lQ+rwbvn4r7UshWjO8c3qNckj6YkFwA=;
 b=foQxsjoV6G6lg+3Eg2womZmT2mC8NOVMdY+eociOr6fQzEv2ItfXKlwhmb3roVcvgOyQqjJDu58o940YhZL9IHe75AYuBaUNTDJF8tslpIBmlDr3PCnYuR42AlNNY5/pr4yACPALtouKG9n7UetzYJsv3MhQq4vqQsoUYr+K0OE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 20:15:49 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:15:49 +0000
Content-Type: multipart/alternative;
 boundary="------------kJhhdFXCA8yinUmjZWVnErTX"
Message-ID: <6095e067-58e6-468b-8145-275d04187df9@amd.com>
Date: Mon, 16 Nov 2026 15:15:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 5/5] drm/amdgpu: keep reading the vblank counter in
 IRQ context during reset
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "Lin, Ping Lei" <PingLei.Lin@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <20261111085534.514957-5-Prike.Liang@amd.com>
 <df5654a1-f048-4023-9a73-fa8a316a1de4@amd.com>
 <MW4SPRMB0025C35E028A75375305BB21FB7C2@MW4SPRMB0025.namprd12.prod.outlook.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <MW4SPRMB0025C35E028A75375305BB21FB7C2@MW4SPRMB0025.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::17) To DSVPR12MB449095.namprd12.prod.outlook.com
 (2603:10b6:8:4fe::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB449095:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: a6eb726d-ba7d-4613-8a37-08df441e67f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|11063799006|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261022115727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: 9X7Nk77afEDqpjwSInALKZjNJgcnrckgS+oppbebe/E0j+InjhsKoCfzSzW7kzpKIwm0GLPXPbH5aCBo5cNjr+FYkZZlhPKMpr4yNicczPDC3WIvkM+qoPbuTaSDarMEctIdH4y+oYi0zhosDogIp1Hxe/mh+OkjmnK6rhcxuYSbh9RQD9i/e3STkSIi6uDcCgjhyW84InidLOQOYvU2WMQy5myqXZbOR3zgGy85gvMiqZrL1Eo4HfT2ZtWoCy9dT0kPTGNYkBP/czZ9BpLyv05ZwxW/0PvGwSbky0FrR3w6wxpSJ+HzlreeeertWFoxbi1SdHfyTQYD1uF3sKPRO/xKzWCTRFrDxs2eEmpOILraximW+DFNVryTn/Yk7wPE9mJffpWzCtZzD3dxqFjgVNvetG3wvQmdO6k9SSd5JJg3TCvP/1nc6MJpDBy54gLdG/nPxKCCTF+bdaeWHsMTG1POmehuQOGJErsF0AUcCtmpEQ0JLGNWW8Whqo5GKkOSnL27DEmUfWXPoFdPJefdom/y77xWKbNH1dcniM6wM64pvSqwNjYzROCta6jE7iwBQdp/7rQXjGFhBXcdmfaeI8+qy2ygeT2tcKL8X8vg6n0/9agnE6iCIYiqcw9ruduLVzyqC6JSNd2Wyhae5OkffgG6YdonAEzlXe7GptqkQFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261022115727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhja2pNOXA1VDRhNjlmamozejk5UXZPZG9RUUppNkd6VW01aWhkYkprVnli?=
 =?utf-8?B?Yng5WVRIV2VlQXhEUCsxcENKZEhmeFFyeU14MXk1QTBaYkR5QW9ydVlnU3lU?=
 =?utf-8?B?QzNsRE1sWnVHRWgwVVBxMUxpZk1yOG9WcWs1dTdubWR3VDg5Mms0QWFiMEVi?=
 =?utf-8?B?UEtBU01FUmo2QlZNeTMzYnRCUkRnVVlocERpbUNkdXlVVE43WGh4TFdoNzlP?=
 =?utf-8?B?UXZkQk5iMDEzNDZqOFM0eDRrMWw4NEZaWnpLVnE5Z1Y0Nm1Kamk4bkR5NkFO?=
 =?utf-8?B?emxGN0RTNmhhQUlSY0RHUEJWa0xSa205ZWg5M29IS1gvazA4NGt1bjJwRnR6?=
 =?utf-8?B?ZmNXb3VXcy9ZVzZ2Smp6V3lqRzVILzNMWFlBVnNoYmEzODJpM2ZnakxpSnZX?=
 =?utf-8?B?MzdWbVBSVEZvUUpzdnRXcWI1czlmVHFmOXNEcUEwOWMrR3hYdnFFNEEvK1NN?=
 =?utf-8?B?K3RmbTc3eUl6bWdVbjhuQzFHb01VeHd1V09SNnk0Q3dMTWtaTWJWYzlyV3p5?=
 =?utf-8?B?czR0Y3dicVBwd3RIeXpJU0RlelgxUUVFQndsSXQ1NERNRU83aEpWU09XLzNN?=
 =?utf-8?B?Kyt4SXdOM0xzbUZ1TlRQWjhjYzB4L01qUzhPc0p2T3ByNTNubXo1bEptK3FT?=
 =?utf-8?B?ZUpoM3BtblVrVGIyZ2d4VXg1NENXRkFrQmk0bGxiZTRuK0RsK3NWaExlSjhJ?=
 =?utf-8?B?S1BxNjE1d2ljWnIyS3FPL2Z4QU5wcHE2K3Z5SWtUNXZ2RWhkSk04NG5pYlgy?=
 =?utf-8?B?c2hnNThXRmRsTXh2cXZFb3VHalNROGVRaUNNc0lwNTF6S0VlaE83TDdxQkVM?=
 =?utf-8?B?UG1QRXdmVDdBbWIycmZnNjRCWC9pck9GaEVhaWgvemxST3BiZURlQXpNU2Ra?=
 =?utf-8?B?RHpnbllTYlF6eE8wNFZnbUhkSzNjRUJyZU16aUdNeGNmSkw4RFFPMyt0SmJr?=
 =?utf-8?B?U3czMUltYXZsWmFiWGtjVGRPNlFjQm1ycm1pR2lybGwwbUR1RzNtWXRhL3or?=
 =?utf-8?B?U2JrYzZ0ZGRGaDFSYWpzeVl2VmR0blFKOWk1cTJtdWdEclQ4NWZSTnZRNllk?=
 =?utf-8?B?STBwQjRTVlFrZ1h2cVEvRmhnVjQwWVFCSTFEUDdKRDd4Mks5ZlpMU3RzL1dJ?=
 =?utf-8?B?cEgzSks2UkxER2FVbEZqR2l5VXpESFprcC9XZHFlbC9QMWNRV0ZkWFI2cUdM?=
 =?utf-8?B?dm52VkswRmJtbVpVU1ZNL245TUtIcjBzTjNTaFNCU25OYjcwN3g1TFZCYWJU?=
 =?utf-8?B?QWJuNW4wVDJwbEFVdjk2cDJTSWNlTDVUalN3VFl2Uk9VUXBxNVBURWNOK0FE?=
 =?utf-8?B?R2RMSlNDa0N6SkNMZjcyeWJOMWhQWVg2ME1qVkorajY3VHg4SFVVcTh0QnVk?=
 =?utf-8?B?QnNCbzdHbXVqU1pRcnRRUlQ3OGNNVW9pRndLald5TG1GaGJabWFYTnpkbzY4?=
 =?utf-8?B?UFJaZmJZaHN1MWZQYk5Gai9USFZVaXRUUktwY1hrMGFpSysxN0NzUUY1WWlV?=
 =?utf-8?B?b2x0bHNKbmdqY1haVzc2Ym1ING0zUGJqQkRVMTdORG9QbGhxZnNJdUpjVlJF?=
 =?utf-8?B?K1k2MEhxcmRQNzZmUXJaVDI2MmFNS2oxbnhhUG5DaEQvRkpGNzR2STVsTi9z?=
 =?utf-8?B?WENVL3ByMlVheTNqaVl4ZzlOcG0yblR5bUorR0twcGN6cy9IcFRaUURLc3dP?=
 =?utf-8?B?VC9DaWp6TnFXK09KVGhYcGlMck9nanRTVlJMd1k3MzBtWXBGb01RNUFSUkJG?=
 =?utf-8?B?aWxwVE10T2VPejV4NWZvb1JuYXBiM0ZuUDIyaTg4ditJOTF1aXNFYlBBNEdO?=
 =?utf-8?B?bnpyYXNoQXh5VVlpSitZM2xqQVRxREQxb2N0SkZhUm1qa2swNDduc3F5N3pC?=
 =?utf-8?B?dTgzZHVDTXk4KzRta3JXOGtUdTR5NG93R0RHeTBzUm5JeWhkanJSb3VoTW5j?=
 =?utf-8?B?c1d6eStVMFhBN2hRanU1K1EzTGdKRnlHREx0RHNwNVV4bjNBVmFyMDhNeGJE?=
 =?utf-8?B?dG1qSXJUbEdWRG1tTFBFeko4dGtFbjVBeUN6R0FOdUNRMlNaR0Mwa25BcW5q?=
 =?utf-8?B?V0pOMHkydjE2M3dxVUY4L0ZRdmY1M0dwVHlyUjgvZlAxNGJwbUYvNndyeEE4?=
 =?utf-8?B?MzV5cW5mejBBbVBFMytJc3pRazFzemhIQWpLaldWbkpXVUJsa21nbW5TODE3?=
 =?utf-8?B?Vm13bFZPV252Qy9vTkR4WFhrWGY4OTFLK2J2KzJSeFV6dmM0MEU5MWpxRkdm?=
 =?utf-8?B?Sjkwd2M3MWFHa0M3b3o0RUxyWFJoZWIrZDNEQ2p2NzVRSE1yTjNDc0kzZVAy?=
 =?utf-8?B?OHlLeU5wa3AwYkdnbFV6NzhiaGNQUWJNRGJFcjhESnRmMTVRclZrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eb726d-ba7d-4613-8a37-08df441e67f0
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:15:49.4827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJ0AGx+VqBjJ8X8UwqxqeUwM9UUhGfRETXeKvR1Su0blmDXaB2uPCMK1/NduuLYs0T+tA6xxGXW6WgAiHJx/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------kJhhdFXCA8yinUmjZWVnErTX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

That makes sense, thanks for the explanation. Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

On 2026-11-16 08:25, Liang, Prike wrote:
> AMD General
>
> Hi Vitaly,
>  
> We should only return the cached VBLANK counter in task context for get_vblank_counter(), based on two key considerations:
>  
>
>  1. It ensures the reset rwsem is never acquired or released from hardirq or softirq contexts.
>  2. It allows the VBLANK IRQ handler to continue reading the live hardware counter even while GPU recovery holds the semaphore. Otherwise, falling back to the cached counter on a failed trylock would cause DRM's VBLANK count to stall.
>
>  
> Regards,
>       Prike
>  
> > -----Original Message-----
> > From: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> > Sent: Thursday, November 12, 2026 10:52 AM
> > To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org; dri-
> > devel@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li,
> > Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de; Prosyak, Vitaly
> > <Vitaly.Prosyak@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>
> > Subject: Re: [PATCH RESEND 5/5] drm/amdgpu: keep reading the vblank counter in
> > IRQ context during reset
> >
> > Hi Prike,
> >
> > Thanks for the fix. Would !in_hardirq() be better than in_task() here?
> >
> > The vblank-disable timer also reaches this callback via
> > vblank_disable_fn() -> drm_vblank_disable_and_save() ->
> > drm_update_vblank_count(). In softirq context, in_task() is false, so the proposed
> > check also bypasses the reset semaphore for timer reads.
> > Using !in_hardirq() would protect that path while preserving the hard-IRQ bypass.
> >
> > What do you think?
> >
> > Thanks, Vitaly
> >
> > On 2026-11-11 03:55, Prike Liang wrote:
> > > amdgpu_get_vblank_counter_kms() returns the cached vblank->last
> > > instead of reading the hardware counter whenever it can't take
> > > reset_domain->sem for reading. The vblank interrupt reads the counter
> > > through the same callback via drm_crtc_handle_vblank(), so once GPU
> > > recovery holds the semaphore for writing, every vblank interrupt sees
> > > diff == 0 and the DRM vblank count stops advancing. The CRTCs keep
> > > scanning out until dm_suspend() turns vblank off and stops the
> > > streams, though, which only happens after the rest of the recovery preparation.
> > >
> > > Vblank waits in that window don't see a vblank anymore. They only end
> > > when dm_suspend() turns vblank off, or after a second with the "vblank
> > > wait timed out" warning if that takes longer. The fbdev damage worker
> > > is likely to be waiting already, because recovery prints "GPU reset
> > > begin!" right before it takes the semaphore.
> > >
> > > Vblank interrupts only arrive while a CRTC is scanning out, so the
> > > interrupt path can read the hardware counter.
> > > amdgpu_device_skip_hw_access() likewise only checks the reset
> > > semaphore in task context. Only back off in task context, so the
> > > interrupt path keeps the count moving until DM turns vblank off.
> > >
> > > Fixes: f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads
> > > against GPU reset")
> > > Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> > > Cc: James Lin <pinglei.lin@amd.com>
> > > Cc: Leo Li <sunpeng.li@amd.com>
> > > Assisted-by: Copilot:claude-opus-5.5
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 25
> > > ++++++++++++++++++++++---
> > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index 14a72a406d37..06e539c4c3ea 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -1692,6 +1692,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc
> > *crtc)
> > >      struct drm_device *dev = crtc->dev;
> > >      unsigned int pipe = crtc->index;
> > >      struct amdgpu_device *adev = drm_to_adev(dev);
> > > +   bool locked = false;
> > >      int vpos, hpos, stat;
> > >      u32 count;
> > >
> > > @@ -1699,9 +1700,26 @@ u32 amdgpu_get_vblank_counter_kms(struct
> > drm_crtc *crtc)
> > >              DRM_ERROR("Invalid crtc %u\n", pipe);
> > >              return -EINVAL;
> > >      }
> > > -   if (!down_read_trylock(&adev->reset_domain->sem))
> > > -           return drm_crtc_vblank_count(crtc);
> > >
> > > +   /*
> > > +    * A GPU reset is in progress and the display hardware cannot be read
> > > +    * safely. Return the hardware counter value DRM already cached rather
> > > +    * than the software vblank count: the core feeds this callback's
> > > +    * result back into vblank->last, and a software count lives in a
> > > +    * different numeric domain, which later trips
> > > +    * drm_WARN_ON_ONCE(cur_vblank != vblank->last) in
> > > +    * drm_update_vblank_count().
> > > +    *
> > > +    * Only task context has to back off. Vblank interrupts only arrive
> > > +    * while a CRTC is scanning out, so the interrupt path can read the
> > > +    * hardware, and it has to keep counting: vblank waits that already
> > > +    * sleep when a reset takes the semaphore never complete otherwise.
> > > +    */
> > > +   if (in_task()) {
> > > +           if (!down_read_trylock(&adev->reset_domain->sem))
> > > +                   return drm_crtc_vblank_crtc(crtc)->last;
> > > +           locked = true;
> > > +   }
> > >
> > >      /* The hw increments its frame counter at start of vsync, not at start
> > >       * of vblank, as is required by DRM core vblank counter handling.
> > > @@ -1747,7 +1765,8 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc
> > *crtc)
> > >              DRM_DEBUG_VBL("NULL mode info! Returned count may be
> > wrong.\n");
> > >      }
> > >
> > > -   up_read(&adev->reset_domain->sem);
> > > +   if (locked)
> > > +           up_read(&adev->reset_domain->sem);
> > >      return count;
> > >  }
> > >
--------------kJhhdFXCA8yinUmjZWVnErTX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>That makes sense, thanks for the explanation.
      Reviewed-by: Vitaly Prosyak <a class="moz-txt-link-rfc2396E" href="mailto:vitaly.prosyak@amd.com">&lt;vitaly.prosyak@amd.com&gt;</a></p>
    <div class="moz-cite-prefix">On 2026-11-16 08:25, Liang, Prike
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MW4SPRMB0025C35E028A75375305BB21FB7C2@MW4SPRMB0025.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from rtf -->
      <style>.EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; }</style>
      <font face="Calibri" size="2"><span style="font-size:10pt;">
          <div style="padding-right:5pt;padding-left:5pt;"><font color="blue">AMD General<br>
            </font></div>
          <div style="margin-top:5pt;"><font face="Times New Roman" size="3"><span style="font-size:12pt;"><br>
              </span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">Hi
                Vitaly,</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">We
                should only return the cached VBLANK counter in task
                context for get_vblank_counter(), based on two key
                considerations:</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <ol style="margin:0;padding-left:36pt;list-style-type:decimal;">
            <font face="Arial" size="2"><span style="font-size:11pt;">
                <li>It ensures the reset rwsem is never acquired or
                  released from hardirq or softirq contexts.</li>
                <li>It allows the VBLANK IRQ handler to continue reading
                  the live hardware counter even while GPU recovery
                  holds the semaphore. Otherwise, falling back to the
                  cached counter on a failed trylock would cause DRM's
                  VBLANK count to stall.</li>
              </span></font>
          </ol>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">Regards,</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Prike</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&nbsp;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                -----Original Message-----</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                From: Prosyak, Vitaly <a class="moz-txt-link-rfc2396E" href="mailto:Vitaly.Prosyak@amd.com">&lt;Vitaly.Prosyak@amd.com&gt;</a></span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Sent: Thursday, November 12, 2026 10:52 AM</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                To: Liang, Prike <a class="moz-txt-link-rfc2396E" href="mailto:Prike.Liang@amd.com">&lt;Prike.Liang@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; dri-</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                <a class="moz-txt-link-abbreviated" href="mailto:devel@lists.freedesktop.org">devel@lists.freedesktop.org</a></span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Cc: Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Wentland, Harry
                <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com">&lt;Harry.Wentland@amd.com&gt;</a>; Li,</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Sun peng (Leo) <a class="moz-txt-link-rfc2396E" href="mailto:Sunpeng.Li@amd.com">&lt;Sunpeng.Li@amd.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:tzimmermann@suse.de">tzimmermann@suse.de</a>; Prosyak, Vitaly</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                <a class="moz-txt-link-rfc2396E" href="mailto:Vitaly.Prosyak@amd.com">&lt;Vitaly.Prosyak@amd.com&gt;</a>; Lin, Ping Lei
                <a class="moz-txt-link-rfc2396E" href="mailto:PingLei.Lin@amd.com">&lt;PingLei.Lin@amd.com&gt;</a></span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Subject: Re: [PATCH RESEND 5/5] drm/amdgpu: keep reading
                the vblank counter in</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                IRQ context during reset</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
              </span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Hi Prike,</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
              </span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Thanks for the fix. Would !in_hardirq() be better than
                in_task() here?</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
              </span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                The vblank-disable timer also reaches this callback via</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                vblank_disable_fn() -&gt; drm_vblank_disable_and_save()
                -&gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                drm_update_vblank_count(). In softirq context, in_task()
                is false, so the proposed</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                check also bypasses the reset semaphore for timer reads.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Using !in_hardirq() would protect that path while
                preserving the hard-IRQ bypass.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
              </span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                What do you think?</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
              </span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                Thanks, Vitaly</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
              </span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                On 2026-11-11 03:55, Prike Liang wrote:</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; amdgpu_get_vblank_counter_kms() returns the cached
                vblank-&gt;last</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; instead of reading the hardware counter whenever it
                can't take</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; reset_domain-&gt;sem for reading. The vblank
                interrupt reads the counter</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; through the same callback via
                drm_crtc_handle_vblank(), so once GPU</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; recovery holds the semaphore for writing, every
                vblank interrupt sees</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; diff == 0 and the DRM vblank count stops advancing.
                The CRTCs keep</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; scanning out until dm_suspend() turns vblank off
                and stops the</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; streams, though, which only happens after the rest
                of the recovery preparation.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Vblank waits in that window don't see a vblank
                anymore. They only end</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; when dm_suspend() turns vblank off, or after a
                second with the &quot;vblank</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; wait timed out&quot; warning if that takes longer. The
                fbdev damage worker</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; is likely to be waiting already, because recovery
                prints &quot;GPU reset</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; begin!&quot; right before it takes the semaphore.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Vblank interrupts only arrive while a CRTC is
                scanning out, so the</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; interrupt path can read the hardware counter.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; amdgpu_device_skip_hw_access() likewise only checks
                the reset</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; semaphore in task context. Only back off in task
                context, so the</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; interrupt path keeps the count moving until DM
                turns vblank off.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Fixes: f2bc71d16e73 (&quot;drm/amdgpu: serialize vblank
                counter reads</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; against GPU reset&quot;)</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Cc: Vitaly Prosyak &lt;<a href="mailto:vitaly.prosyak@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">vitaly.prosyak@amd.com</a>&gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Cc: James Lin &lt;<a href="mailto:pinglei.lin@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">pinglei.lin@amd.com</a>&gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Cc: Leo Li &lt;<a href="mailto:sunpeng.li@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">sunpeng.li@amd.com</a>&gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Assisted-by: Copilot:claude-opus-5.5</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; Signed-off-by: Prike Liang &lt;<a href="mailto:Prike.Liang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Prike.Liang@amd.com</a>&gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; ---</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 25</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; ++++++++++++++++++++++---</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp; 1 file changed, 22 insertions(+), 3 deletions(-)</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; index 14a72a406d37..06e539c4c3ea 100644</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; @@ -1692,6 +1692,7 @@ u32
                amdgpu_get_vblank_counter_kms(struct drm_crtc</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                *crtc)</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev = crtc-&gt;dev;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pipe = crtc-&gt;index;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = drm_to_adev(dev);</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp; bool locked = false;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int vpos, hpos, stat;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 count;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; @@ -1699,9 +1700,26 @@ u32
                amdgpu_get_vblank_counter_kms(struct</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                drm_crtc *crtc)</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Invalid crtc %u\n&quot;, pipe);</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; -&nbsp;&nbsp; if
                (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return drm_crtc_vblank_count(crtc);</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp; /*</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * A GPU reset is in progress and the display
                hardware cannot be read</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * safely. Return the hardware counter value
                DRM already cached rather</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * than the software vblank count: the core
                feeds this callback's</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * result back into vblank-&gt;last, and a
                software count lives in a</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * different numeric domain, which later trips</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * drm_WARN_ON_ONCE(cur_vblank !=
                vblank-&gt;last) in</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * drm_update_vblank_count().</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; *</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * Only task context has to back off. Vblank
                interrupts only arrive</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * while a CRTC is scanning out, so the
                interrupt path can read the</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * hardware, and it has to keep counting:
                vblank waits that already</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; * sleep when a reset takes the semaphore never
                complete otherwise.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp; */</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp; if (in_task()) {</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
                drm_crtc_vblank_crtc(crtc)-&gt;last;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locked = true;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp; }</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The hw increments its frame counter at
                start of vsync, not at start</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of vblank, as is required by DRM core
                vblank counter handling.</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; @@ -1747,7 +1765,8 @@ u32
                amdgpu_get_vblank_counter_kms(struct drm_crtc</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                *crtc)</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_VBL(&quot;NULL mode info!
                Returned count may be</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                wrong.\n&quot;);</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; -&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp; if (locked)</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                up_read(&amp;adev-&gt;reset_domain-&gt;sem);</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;&nbsp; }</span></font></div>
          <div><font face="Arial" size="2"><span style="font-size:11pt;">&gt;
                &gt;</span></font></div>
        </span></font>
    </blockquote>
  </body>
</html>

--------------kJhhdFXCA8yinUmjZWVnErTX--
