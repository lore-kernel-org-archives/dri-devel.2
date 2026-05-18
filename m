Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B42CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A4910E5D1;
	Mon, 18 May 2026 12:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgW7hz6Q";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A81810E5D1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJyNJrAVZJaWOCCug34Bok56wFmhaLBp7qi8KNY9o65zfd+VKNO61Qw5udIgl+9H3mQ0WOiSegY7V0f6I4DebenLawWNqLT6dqmPRcZnrpuGni55b8Um4aLTlzHD+2qdIBDJxhQq5OUqN4/ZF3cFUNa/zeFT33Gaf2JKTyMTUZ0GT0tPTEIyNEUVL2CHuwqDvRiuLqgRKdSTnPWp85XzKSuB2iYzKX4ZkhOXGBGYJTpoGFQNF8uk2w1HEprRnuPHx8Jwe+OQXJpGDdZ5C1P6rG3KMAa2bJgWbtDWrD3A8VPaGsQ82ac1MYt5+FzATlbn+bHr8X/CPVND1fe4y6rMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGTJaiwgpjOkcB0VNjE9OWt3O5ViGmLg4l8Ohr7VLYI=;
 b=CeDygyisMiDB4nfvKZRovnDd6FK50cv7n7iz95t1/6US8Ld0CYvZBVaQlhXex9JWA+qhCarwQdSVc1KCHzsRgcdEMC6ehikDcLSnBNqD0yaEVIC0FrNiT6S1KiNsMYvlzadt6wdEmt/m+L722g7D+pfbMrG+qUXqpYh0eSPjbQdz6PSGE9a41GEZo//FlVnc0CY7JqkYyeNupOg6zmEWMp92xPlkvF414F2wNcCH3GFS9+6bVXuZ4R0xLXS/dj4+lURBfwbbLCqggqkG7Bfypb/a2sL3P3+PpJigVGe57hdFH2/C9Fc68otmt8LGPdp69g65JTBhqBhYoYyjAizK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGTJaiwgpjOkcB0VNjE9OWt3O5ViGmLg4l8Ohr7VLYI=;
 b=KgW7hz6QcvOXuvOEakX2HfP9yCuU8NXp/XZbV/aHdMw4mQS9M1TjeChFyyrQF9GdrbQVgwUINC2tijQUMjZ6XFK8OjNq6rIi4cRK+lo7sCH8dAHtUjnyYygNoCwBhma++Xambnd+K5hPjz8gZ0Ue8sc+DRZPcDVsNHTslIZ2+v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 12:18:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:18:48 +0000
Message-ID: <a9ee80aa-0c9b-4bd7-87bb-d3e228357b18@amd.com>
Date: Mon, 18 May 2026 14:18:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dma-resv: Define guards for context-less dma_resv
 locks
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
 <03a57011-e734-4a74-aef2-e3a6016e15fc@amd.com>
 <20260518111456.30ba9bba@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260518111456.30ba9bba@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fd6b07-5f62-40bf-408c-08deb4d79d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: y+4yVWkxGij0wKsbJqX1hgQzMNX0Z/tD+lHR1gjuyymbEv7Xc532p+EWoGdzG0eVzEVajgpNYRGJNj0ih8BIWjl7UpAAdP8PLCqvLK6y/w/WrGLrOd6V9X6ilQ19XXyMiS4n6QilsbCjDQ9vXWcW0tQ++8HH538b+BJQBezGuQl8qIc41rbwe6oi6vK8Gtszevj/p644I4/eQeqg1pIg5Q2d4v8NwWBY+qfBBn9Ca3NPVbqW4uSzHlXXOyDH1lIyT5fJTZ2IF4v/LJfAjFZ8cJiSAjd8Qs7W4hF1nUUoWk9aESS/sWwOKRWvRhuhDgsXpgHzsigAUwg3FMZzg3/XcDZ0EBkfEpv6lt5cUFJ3UXNbXN57gHqlEQZBorTqDcZlb08RimPxzthgMEMmnp4TBGMVaQD/ISTFpx5kfOiiVguP0xPAt+T6LuT7uPQzMfE6pDRC+TX+lshLcSBLpo6ceZKgq+WmwHP/Z5PIB7M3GfwyraS60oQI5A2oFkIaP0ERlBlIIgevYI8TZ5vMEfRXtAo2rGl2/TqVRLMMQiLPZWYhs2FK0P8synCLEb1f4aDbgeeUrdEsUnIbhQ5Zji/WLP4wsnWDcSwQCDj3xRZXjCmNMQ3aGHmNWiunlDukRfpBuTA7rUrKXuFMmJZhlVeEsyjD+uWyl17/ezSrw3plQIlvWyhzmhhSpZNgYTn7DQeX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01oR0t3a0hMbWlNdDF0SUpYZWhvTzA0Q2NSb2piRHphOXh2cUFZN0VqNWl3?=
 =?utf-8?B?K1dvSVVtNC9Od0NpT2tQakUxZ1I3UC9DWWtkc0hDaXRnVVREeTNxLzJsYW5Y?=
 =?utf-8?B?cXViSno5VDJVY1NrQTJ2U2E2ZXQwWGpXRlVZSkRkMVBORFdENnk5OXZveFVv?=
 =?utf-8?B?ajg3WU5GMkxPNFEwZENPK3FmQmIvZHNocFprZW11TnpxQ3YrMW5wS2JKNHBL?=
 =?utf-8?B?ODcrSStVazRGY0R3YUM5L2x6NVdJY0NaVG1TaGdBL2F6YkxNT0ZYeGFHbVJw?=
 =?utf-8?B?ZTdUME1mOE1WSDJMTk8xZlFra3QwUWdoM3laS2hFSUNISjBmNU82MlJyN0I5?=
 =?utf-8?B?cjh3WGR5cFZkL1Z0V1orZ2kxeUZiZER5bUtyb0xnTUIrR1NQaXA4T1RTejFM?=
 =?utf-8?B?Z2NVbHdsb1gxMUxBY3J0bTBwZlN3SW9UcXplYzVQdExnbU5EYW01aXhPZ00y?=
 =?utf-8?B?ZkI0dWYvUi9RMlVEZ2VuSzhQZVh4TmZGSTdSbDZqNm5xUm1QSkhxd1JrWnNk?=
 =?utf-8?B?WDc0aWZzanlsZjJFdmxueDl4TzdOaFB1TlJPSFo1UzJQeWdvNW9zSEVhZ3V6?=
 =?utf-8?B?TW9tZVRFTTl0RERncGdqNHYyOStOSVRUbjcxa05WVzFaVTcwZjFPc3F5YmQr?=
 =?utf-8?B?Qmdqam0zakJqaVhmMi9ydGx6VWgxYXVyajRGN1U2aUR3bVZzUmRlT1daM0Zr?=
 =?utf-8?B?L3JTUmdzd1ltQmlOYUUyMUtabHRnVmhHYnlaZ0t4Tm5SSXVtZEs1RTJOMGRR?=
 =?utf-8?B?UWEycWdrN2JUWVlHZWxLZU1FWWVCYjZNWElEN1JVUmhEcUxOSU5HbHRTYnpv?=
 =?utf-8?B?bjRDNm1uMmpjMUJIUHgvSFBkNEpsZ0dXb3NYaXRvWUs0RW5aV0tYOUN2N0Fh?=
 =?utf-8?B?aGVQekYrZHN2L3BxaDJVVW9FTGk1SFVCOVUvWW5kWnhhakwzMkY3TjZLMEhL?=
 =?utf-8?B?N3hPU3VJMmg3SnIybUN4ZHQySG9QZWJlbG1BQThvZGVDWlVUdXRCSnZLODF3?=
 =?utf-8?B?K0lZSThiMncxSlo5Q3BPbEE5d3ppUW1YcXc4d3FiaXNHRERwcjVXZUJXL1BS?=
 =?utf-8?B?Q3lPYTNQeVNHMS9QWElMTkxwajhmMTZmMXBZUHpXTE96b0VZanUrTkhNbjlK?=
 =?utf-8?B?alJSblBmVDFBRWl3VlBMeHRyclVicmUvbGowamlQMjE2b0tlTEdjUG9qWnNa?=
 =?utf-8?B?OXJEcUc3WExid25pOFBVNkZKTHk0ZGlhNWIzeEdCYTZYZUdYZlg5cE5HTHVT?=
 =?utf-8?B?SXkwNjR1amtvekVkZGs3MjZId1RndFhFR0NhSlpsZm1EWHJRR1phaURhRUI0?=
 =?utf-8?B?Z0x0MEJoNkNrUTlwR1dub3k4anZ0MVBWbGcrSW1GZk1xbHZXU2xwVTRiL1NS?=
 =?utf-8?B?YjNHNTlYTkwvMG43d3NpMjJTR21TRXA5TnBBdWY2K3NWTXRoSzBpc2RZZTho?=
 =?utf-8?B?cUlFazJ6Y2dkejJRbElLTjlER2lHWUpDUGxKYWFnci9mSmpTNkFnRUVpOHNU?=
 =?utf-8?B?c0RHYWZXTjFUL2dFcjZaQ3ZSRkk0WEpWTncxSmFoa09OZUVwQmtRdGRPZy9y?=
 =?utf-8?B?K3V1VU5JREZtQlBteFU4UkxnTjVmWHcvY016eG82SFMxNnlLUzVRbWtjcFBD?=
 =?utf-8?B?djFUSk0yWFl6T1g5SEUxZXc2WCtiWmJtQkhxSU03dHNLRU5CN09pUDFWQTdo?=
 =?utf-8?B?NmZEdndvZU9Dc0gvVnYxTTE4MmdWMGlZNEQ3QkRWSlhCSmxmeTA1dm1FN0Nt?=
 =?utf-8?B?d3J6VmlGWTlTWFprbU5KM0NHcVYxSjlvanVtNEpwTTAyMnRuUkMzcEFieG1J?=
 =?utf-8?B?a0hwOHZFQ1F3YS93c0Vpc0RnZ1RsK3N4VUpBV0lSbi9BWHlEYmZEbTVzazZ4?=
 =?utf-8?B?aVhUdjgzcXd6VGFKcm5aWkhNMkN3d2hYZVEwN3NPWGJXZ2RTQVlrcVRPNVkv?=
 =?utf-8?B?VmU5eEVmc1o3VFNKWGNHOGIxeVRBR1VyTWE5SWhDSklMS1hHMXRQQnpkSVhs?=
 =?utf-8?B?WGkzUmFJdFRmNWlOelpPV3A3Vk5zbVRwcWQ1cmtkOE1SREdESkh0dWtTYVNh?=
 =?utf-8?B?NnVRUE1maW1ZS2pEM1lDSy9WbjJ5M3pZZ0xyR2VJTENnU2NwSFVab1B4TU9j?=
 =?utf-8?B?dmgrcVBpZEFINUNhQWpwWXE3aXljUEJBT3czZzB2VFN6QTdqUkgxSFBRL2pw?=
 =?utf-8?B?YnkrSjhvNjZiT1RyZitaWUNiaDlYejJ0dGR0VVpRZVAvV3QrdWVGbnY1RlZl?=
 =?utf-8?B?cmdRZUN3dk53QTlCcW9JZmtRTWFBcDFFNGVmOHBnSVVtTnQ2MnFvK2kvaXdT?=
 =?utf-8?Q?bjScZpFyYo+KbNpt/N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fd6b07-5f62-40bf-408c-08deb4d79d56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:18:48.6991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42FeISb9jpApfc44XNsp3Btinm1He8tdCKCtbDzbmuZ70W+SqwijMihhX/3eGfhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

On 5/18/26 11:14, Boris Brezillon wrote:
> Hi Christian,
> 
> On Mon, 18 May 2026 09:10:23 +0200
> Christian König <christian.koenig@amd.com> wrote:
> 
>> On 5/13/26 18:58, Boris Brezillon wrote:
>>> When used without a context, dma_resv are no different from regular
>>> locks. Define guards so we can use the guard-syntactic sugars for
>>> explicit/implicit scoped locks.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> How do you want to upstream it? My preference would be drm-misc-next, but I think I can live with a panthor specific branch as well.
> 
> Everything Panthor related goes through drm-misc-next, so drm-misc-next
> also has my preference ;-). But I'd like to wait for more feedback on
> the other drm patches, and there are a few things I need to address in
> the panthor patches anyway, so it's likely to take a couple more weeks
> for this series to hit the drm-misc tree, unless you have a good reason
> to fast-track this specific patch.

Well the DMA-buf code itself uses dma_resv_lock/unlock and obviously has test cases for all the different variants.

So if you could provide a patch which just switches over the DMA-buf code itself to using guards I can happily take both into drm-misc-next even before the panthor patches are completely reviewed.

Regards,
Christian.

> 
> Regards,
> 
> Boris

