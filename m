Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44E8C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14C610F6E8;
	Tue, 15 Sep 2026 04:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7DcL1rY";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F4710F6E8
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 04:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lib8XDOmO8OPwndE4zWf9p+8H58dFCgzRuS9lz7WFCExRxLXoa/egxg+K6JoXHhP+gt6QoyVAC9M0a15uZfm/shEOJYDciGpH7BzTXaxfrmrOEbu28NJ6nmJ07Ebp51w8K/5Ad5yyoctFQcewCTgl2mRy0X+0UWnqRDNpKr3AayH3kqtT/GarP/TAxjPkB6FZ69kQjGWUU02Va1WuOmVrEOf//l+lGbjyY3+V91x9XSVd0y0hUkWDRJY7Fd8jx4S5ibAH1XzRwE3B5/BN7ofsppfLd+MV+xECQ5XVuP4TLG2KIYCMefE2kg3n+XKby4am3N6RXBNiE94RC2uV7Cv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hqbPRs/8dJSA4f0qBiKclYcjZqP7FEPUWNGbbkqr/E=;
 b=GGWyoBAlm+6M045GCOX4LqZ1NLwFYodU3CWrZIaSaorwtNVf/7hklMqMK4IzKBpUXKSAlBw3wJJZ80Nx5r3cXypRm3WuyniZoz9fVljEf8oFouc7PG+vpnMU3PCK4MjOVAoMNOzyS2qraOcIUOes9nyTcgt/Dc1xmAVpz3ritx02uin7E47fM6/pQXiV7Bvf9V2We9CC51gVmC5MSV8ZZHaVJ/djAcpltZQUiwz26fBfecLt8grqTCug417+aba85OfFMDtCV95FG+2qyhmc349XeOBmRwQsRxCtJN/YoZ1AEHse8RHWQ88FDM5hYnz8PNv69oIZ+EtXNXe9BRt++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hqbPRs/8dJSA4f0qBiKclYcjZqP7FEPUWNGbbkqr/E=;
 b=E7DcL1rYarXnlND1KvP17KzjEREvpganTx6gBC714i+QnfHByiln07I0kX+nrTybeWOjCq6eAQNeCWrlpvsU157YSL6mg8LxcHyWwU3Sxp5WH1USsRKzUbb0BX0tAbSx7Edxx8zSNu5I7Tfh5YwsX01ahYMvig0ojRM1fyiP0Yf2SlI/JE9c6ejOXMfUVo6e5Dl5MMdpeOU1eVzdR3TkmpDTehDoO5nFG/CHrudVOaLykiRgb7GGnQfbOtueffwHT5iWMMDF4Sea1mz+Iqf5J3djiyEMa0P7OxlX3zNPOfZ2UOt1UdAu9+8UhwI0zOVTw2MRVThTisySmPCexiMnyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA5PPFC3F406448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Tue, 15 Sep
 2026 04:52:36 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 04:52:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 13:52:32 +0900
Message-Id: <DLFMCWWIALSU.2RHGOMHHCOJS@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Matteo Kloiber"
 <kernel@matt3o12.de>, <aliceryhl@google.com>, <ojeda@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <DLFM6SJH6L3P.9YG5DXQPR3TX@nvidia.com>
In-Reply-To: <DLFM6SJH6L3P.9YG5DXQPR3TX@nvidia.com>
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: 168d0703-7cff-45bf-fcf3-08df12e52954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|23010399003|376014|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: djy+lgqyDfgX6I6hNf7B8yFmitB31UmrDUMpyIruM2V7fCT8LMlSGpMjx1Bi5LBOU1AqA54pFq5luleNL0bZjj93PEFn6JOUSWlE4L854fPDBUA7iCJWwgDa/2VqbgyCJAS7/Zbo5a81AduFo2f7d7tberWvZM49rFefjvfcFIklKpOoZLaNpBYXrWrjeJD2WuqbI2yRrCwyIGAh0ZyI2tSCEQLvAdPrr8MIEK6qroRsWxzjqSJGEl9scujlkUfR0V4VZT+7A/G9OvfqEZ0bsVOVp7wAaBo0wbi8T+GqYOttuzb/wOm2oMIigSbN2Z6fOUf1Xgszkc33UN4uPkkntrdMMfl76KNMySC8tJv+41VeNlRNaXXk+ZVL4B5LAySnw2SAFXUbENINwK1pa9G0jZgP9TLBjGML0LAmcdxKHAugT0xYS9Gy1xVLw8wjsKKJNWfK3jI07tdKoHd34mrPA+FSy2AJkzJhC/T8NSG3Cx+HTn1TW021NryU3HJdKW6RGfm9uXcPN6qCZcMw1rwIIKm2eo3Z1NTiw0qSKKbtpv2n2YHATNGUXmIaYT1DTc0t9Qxv4MqrjtU5l8a782hsyjd9FNDw6bFu37OaxauMWce7rbA5EqEwCJjuR49BH3Z0QeCBHEOssRVdahIXk9PTJugRdZnqf97Jrzgv/aooMJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnh4a0I2TG1iTWxCeDNieWptRGJTY2ZNa0lraWdRWTQwbHpGUEpQZG4wazBk?=
 =?utf-8?B?MGxUWkNLZ1BqZDVzM2RuYXFPRUFUNTAxMStTUWJJZW1BSGdqSXR3djhTTDho?=
 =?utf-8?B?NzlBWmRkSEhsOXlPSEJ5YlZsbW9iekJmZ3MzMURoTktnRXRNaWVEV3liYzFu?=
 =?utf-8?B?d08wZlhzQ0RvVFdrTEJRcUdRRHZJMm1lU2V0MThQclErRm1wUEw2N1pFVitQ?=
 =?utf-8?B?QzBkZHVKQVluWllza1c2dUl2Q2lqVzlYQ0d4TzRvTXZVbEcxaHUrczczNXhN?=
 =?utf-8?B?d1NFUjViVjdZMjlzR3Y1ZVM4SUVqN2FWd1RBUlhUb01lSlYzdmhhSXVxd3Rx?=
 =?utf-8?B?YStyTEEveStrcURIZU1PRjNzTVM1MklyaHNhZ3cwdy9EWCtCaXNoNUl2STlR?=
 =?utf-8?B?bHhnSnFaUElkWE9tUjRqakI2bTdHU3RVVldhTW5aWFQzN3FaQUx4QWRQNTkz?=
 =?utf-8?B?TmhZeFduQVZuT0k0RnJtZTd2Yy92YjJpTVRlakpIUHlDZFlCTDQvb1VkSUpI?=
 =?utf-8?B?SVZDTFkxdlRhYWl1ZFd6WlUwcXhsUC94SERpb2ZTNHU0ZzN4QmVmekZlSEJN?=
 =?utf-8?B?YnM4U2l5Q2F6dVRJZTgwRkRRRkd4VkM0SkY5YnBiTTZNY2VsSmlZZ2V6QkZC?=
 =?utf-8?B?blJOWjJwQk9tNTJaYkEzeENiT3p4RXUyaUFFVnB4c0FDUm9MV084aDY2RXox?=
 =?utf-8?B?ZlZvN2kxNk9jTkZXVERKelozVWg2cHZQNG5rSjc3L2loSGQ2S3ZMUHJkSkI3?=
 =?utf-8?B?M1hlZFFwSDhYOG9qRHdFbGhyazBWNnRPME9SMGxCQmw5M3FSbkVHRTlxSllV?=
 =?utf-8?B?dkk2MTVvZ00zeVhvRks1UVE3TWVKS0NiUGR0elpuY2kvRmdMeEJMOGNjT3BY?=
 =?utf-8?B?d3EwVStqbGc5aGVFNUxxSDZPeGQ4OGdxcGtORUJybkNuYUFkTW5YSFJwZCti?=
 =?utf-8?B?ZUJJbW1tQlBRUWYyYmlRRXl2RkZ1YnphUm4weHp0eUhVK25NL3l0N0pMc0Rk?=
 =?utf-8?B?aVhjUHVSeUdzYWprc1h6dk9rVE5RQzhsNG9lL0tYd3NHQXp3dFBGb2luKzhx?=
 =?utf-8?B?bDZnVGhGMU40YlNQVElNL1o4MFV1UG9MMmc4ckMyQUp2Zm04b2luYTlvdGpH?=
 =?utf-8?B?QWJjV1JLUlkwckREcmN4bDgwaXp0VlFnZUdIekhCSE1vRkMxc3IwRkpNbVdE?=
 =?utf-8?B?R1J2dEFjSHJ6ZWYxVTB3Z1lOTkRES2tGMEdKTUJxOTU0cUpLa0R5TFBqVGVO?=
 =?utf-8?B?OGtMeWdJc2xSV29MZnFkWXltdllmVHJhTjh0dVNkMEJkYktNRzRoblNjTzA3?=
 =?utf-8?B?QzJvaDFwUnN6dVlYZ3A5dXVBTFEvU3pGNm8yZ0RHOUNNTWZvU0drd09peVNx?=
 =?utf-8?B?U3ZkbCsveStiR0pocGtwSUIzb09PTjRoem1TQ1QvY1ZqQ0o0ZXZiUFNKeUp4?=
 =?utf-8?B?Mmg4RC9QVDg1Z0R5RG43Q29IZng4aUVwM0U3cklidWpLZExuajVFRzFMZUxa?=
 =?utf-8?B?dnY2djA0WTFLdmtSclltVTQrTHZnTzlYVGtteTR1NFZGSWRtd0VzcExYaEJU?=
 =?utf-8?B?eWR2eER5bjM0UXRBc0ZKc3NzUnhkQ042UEovSUZhV0dFU1RLblRyRjRGT0xq?=
 =?utf-8?B?bkE1U0NQVDhnTWtyVGJRblcxMm1WVWV5d3lrQVZuRmVsL2NYeHFJWUg3Vjdq?=
 =?utf-8?B?dWpIS0JEZWtpbjhnUTlEY3E4MWhjMTA1UFo5NStVREZkOHljYTJaWklKWnZF?=
 =?utf-8?B?bk84VkUzMHBwZi80UGNzK2Mvc0FsdkJRSUxGU08vTkROZEpRWGxPbkU1THFl?=
 =?utf-8?B?eTdnMm5TdzNIaVpMS2hPRk1TM3ZrY01DR0ROSlJxRldKUVdlY0Ywd3ZJOCt2?=
 =?utf-8?B?bS8xZVRtaWRGaUdNYWRLaWlxQkxlUWpHSUhNL1l4ZFFCeWRjSHBXVVk5S1ZY?=
 =?utf-8?B?b3VtVEhiaktRRG5lK1lyS0pEMkZkR2VjYmRqTjY1TWFHMUVUc3FxYTdZSllo?=
 =?utf-8?B?MFNuK0l6dFQybFdaVFY3amI5QjlkMC9IeitMMEp6ZzNoWnRxOFVycENRckhs?=
 =?utf-8?B?dGJpVUk0Y0hyaTRRZHJsWEMrQXVTTGc2cnpCd0dUU2FxOG5HQTczb1VLZDZp?=
 =?utf-8?B?bk9DWnRLaFVzVVhaY3NaNG54Z3BrcXBkQVBtMktyUXN5a3kxTVJoRldzWVhv?=
 =?utf-8?B?aWQxbUhndmkrUlRubjRPS2RzWHJiSW1rNlZ3WWtkdUc0RGRkQXhXcEtJQXpB?=
 =?utf-8?B?TVBFdStxOHZ1RGhHU0pacEVMNVppVWlnQ3FVeHBrS2hQblBYdElMQXhLMktI?=
 =?utf-8?B?YkNWeGtlUXg2VEhCMlZrZEtNUzJpQVMrWmM0NCttMThjelV6eld5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168d0703-7cff-45bf-fcf3-08df12e52954
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:52:36.1080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoBVpvfYb7OtD5KctVUXey2bnFOxq0XmFldZ/3pVWixw9yqhks1nRtcAi8WBoFX6SlLd018Ds+jiknUoagedpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448
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

On Tue Sep 15, 2026 at 1:44 PM JST, Alexandre Courbot wrote:
> On Mon Sep 14, 2026 at 7:22 PM JST, Gary Guo wrote:
>> On Mon Sep 14, 2026 at 10:58 AM BST, Danilo Krummrich wrote:
>>> On Mon Sep 14, 2026 at 2:45 AM CEST, Alexandre Courbot wrote:
>>>> On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
>>>>> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>>>>>> It also means that without patch 1, nova-core would split the firmwa=
re
>>>>>> into hundreds of 64KB SG entries, which is not breaking but still
>>>>>> something we want to avoid. The correct fix is to make sure that
>>>>>> `dma_set_max_seg_size` is called by the driver, and while we are at =
it
>>>>>> we also want every driver to call `dma_set_mask_and_coherent`. Ideal=
ly
>>>>>> we would use the type system to make sure that both functions are ca=
lled
>>>>>> before any DMA operation can take place (using a safe interface), bu=
t
>>>>>> I'm not quite sure yet how we can do this.
>>>>>
>>>>> This sounds sensible indeed. Should I open a thread regarding that on=
 Zulip?
>>>>
>>>> Probably not necessary, the mailing-list has a larger audience and is
>>>> the right place for this. I expect people will jump in here with their
>>>> thoughts.
>>>
>>> The problem with those is not that they must strictly be called before
>>> allocating DMA memory, but they must not be called concurrently with ot=
her DMA
>>> operations, such as allocating DMA memory, as it would technically be a=
 data
>>> race.
>>
>> Do they really have to be called *before* allocating DMA memory, not do =
they
>> just need not be called *concurrent* to DMA memory allocation?
>>
>> If it's the former, we can require these to require mutable reference in=
stead,
>> so the probe takes `Pin<&'bound mut Device<Core<'_>>>` which still deref=
s to
>> `&'bound Device<Bound>`, but Rust will require the shared reference to n=
ot
>> co-exist with the mutable reference.
>
> As Danilo pointed out [1] from a strict safety perspective they must not
> be called concurrently to DMA allocations. So there is not a hard need
> to call them before.
>
> But my point is different: until patch 1 of this series, nova-core
> didn't do anything particularly wrong but was operating with an
> inaccurate DMA segment size. Which is currently inconsequential as long
> as you don't set `CONFIG_DMA_API_DEBUG`, but will become sub-optimal if
> patch 2 gets merged (which it should be, otherwise more DMA-limited
> devices could start misbehaving).
>
> The thing is that every driver *really* should set their DMA mask and
> max segment size ASAP, but at the moment this is done through two unsafe
> functions that are very easy to overlook.
>
> And practically speaking, is there a reason *not* to do that setup
> before allocating objects?
>
> So I am thinking that maybe we could have a kind of `DeviceDma` type
> which construction involves setting the core DMA parameters (or
> acknowledging the defaults), and to which all allocations would be tied.
> IOW, Danilo's DMA allocations rework [2] would tie to that `DeviceDma`
> object (which itself would be tied to the bound device) instead of the
> device itself.
>
> [1] https://lore.kernel.org/DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org
> [2] https://lore.kernel.org/20260830193824.471089-1-dakr@kernel.org

Sorry, I typed this message while travelling (and offline) and sent it
before noticing there has been new replies that make most of it
irrelevant.
