Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87548C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD7110E2E3;
	Mon, 31 Aug 2026 14:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yyid0WHq";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E5410E908
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8unB8aS2WKkzWMSvO3bNyR299U5dWuQlTvCN/OrcV56x5nEIb0XMwO4H2L120GWj9jnLWwSWbFGPAI5dzhZyzXkQ0kPiOhldOLXBmJLSzHQmSrx6xJyZH4o/dWfprSGORReXMpQS2sdvIjLs+ffLXxetAwXNqRajjyeK+av4m4er85jFG4TP/rNgMjaUUCddeOi2tJfuEok3rjjCq12ZTxMkCvZbiqnraApv7fojthITG/wT7t4kuVdZ6JH4fDubWHKfNsC/5zLFaNoR7FDGbJdLkDCRQ9DBR7wsIAKUixUl42B/5uHDIGVT4E3bQKPxsPq8VFjlOTO55rNuNm+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX6KLQq36hLZ4hgFTD3vl9QbjRpgXWViJ0glMGm0BVo=;
 b=DhedQZFonzQBkdzR3r+8ra5lrvE8F3jX5INZ5kR7BBHA0Bon3iY56GECInVlSr5zZIeFFceP28LgmvFi3BFBNXBu2q16hpT8eLD1P9I7VY+dIl+jQkecOVQVNaGhHI2eqprzFpRwYfz8wF2mNHVw0wMHJI3ied/9SdYNzTmJNoFuXkIfIIicxw6akYo8S+4nwGEqbHmVb40mTN3qSZJ9O5SokcNAJh6aTuJ629NVo9E6TdikM/hp45m9GrT/VqjFLzluiq983d62ZhaaiyTPS1iOx1jmBbFTJ4pkLGjwwdRHDaFLGmJlenOGAKo60kC1RuAnXlSZ9hcAH2Ty+P3fqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX6KLQq36hLZ4hgFTD3vl9QbjRpgXWViJ0glMGm0BVo=;
 b=Yyid0WHqgbfieFHDpJvYU7kPHBQk1sqtL6MrCg/cpxBvyeOmrFxlcyiARXOYRlm1+jYilDR7FqwOfqIDd0pea9xnifUkIqh09wfbp05T6qLOrJStSauH5rniSPq9lNE3DsOmUqOYzaLpyUmMNO+iFu1+Y2NUryIXMwY1Y12yEV7wIwtyqsO4CC4tz0ZJk0hT9y3oROh2jvX5aWc7w9tU4FKapBNLa2J69K0gXDLrG+bWsRSSTREOFI0yUy5+J7Yo2anHXV8Vrzn2FqxCfKmtQVV+J+NcJkrTrTMIPlnM0KfwSByDu3XeLbXKBIKauoKBXDpdezKoaAjbkpMxNq1W6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:20:28 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 14:20:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 23:20:24 +0900
Message-Id: <DL371J23O7I1.2BFFHIEFED3D9@nvidia.com>
Cc: <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: use kernel lossless integer
 conversion module
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
 <20260828-nova_num-v1-1-e21f17ba4127@nvidia.com>
 <DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org>
 <DL142442KXHA.3VFWP2DHD7H2E@nvidia.com>
 <DL1O1NFXUX6N.1LFASWF425I4Y@kernel.org>
 <DL2Q6ZZ1EK68.2SARDMRGQ19X6@nvidia.com>
 <DL354W1TVE2X.CVZ3GXX2O2JQ@kernel.org>
In-Reply-To: <DL354W1TVE2X.CVZ3GXX2O2JQ@kernel.org>
X-ClientProxiedBy: OS7PR01CA0169.jpnprd01.prod.outlook.com
 (2603:1096:604:24c::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: fcaa2580-54aa-43f8-37f4-08df076b015b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: PfrUfPaHlhNL6i0nrJ7kF/UL3OGqI/am/Iz2LOad7ZodvpUFzM1H2f4z1lzzh6Wzruq272AcKCMxd0cdFpVLSOzp4Ussa8/C554D9FZ+OEJJoSPsQzN99hwDTjSK82v9KY8Z6BgBetmgBbRq0Dg9Yr2mx/jYjCBRaWISuCQZNCS9bfs9O65MrYr7BSRuPfXaNQ1WVUHZpMi9aWr/2GEqhWdGbvLytUIH+XoZ3f9j2rk+HzOVa/viOYz1op8S1zuI1QYPla3Rs6kUbdYTaFuSvPR0y3JlsKdDiIqIXaE8UWHcgcATu1lZs9yehj1OQ7rYcAHjEbipTaaefh4PzsOvmraxbwUtmCRxEQHDa81I/i9xTp+E4v9fKfqzdjoX6pFtbz2hvA7ai58lFvQypLCgKg1W+7SXy1f1PWVOpGlqbcQHw8NT+S11jQEdXRK/StVmm9jMX8gSvVt6mSE8XZz1QihBdMc9VY1rv/xcgfub4ORi8szcEtfazXvwWAlE8L+5AmqX5/ltHjDt7AM5YE5D5QJ9ziU8udQ5W47oUYrI6lVtP3gMhefONGEd3Pvr91F9xajWFUocApf+N4mST0eN4TBNQ5P6MV/xS8g6foKtqKn/WlkUu3mldgyknpmOpBWGGfoc/siXk7vH553uPAu8EEoVkRP+fydcQAcmc8bR/nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9lVHJKWlhmaitwL3ZqRUhTYXJQT2EzaFhuZENnb29rclJIcm9vWTZIRlc5?=
 =?utf-8?B?SmcvSG00Tm9vQU9aVjR0UmFHT0ozSUwvcVBGaWV0Q3kzNmdYb0c0WERyRTUr?=
 =?utf-8?B?VzN5cW9hSDRVSVY4OGljOWpkYVZyTytjQTI0ZzlzY3lsNEZNUkdNejBTYW8w?=
 =?utf-8?B?RkFuS1YvNndmcHdJSEh4dW1RTHJyQnlTcFl6TFY0blovV1FnajRVRzVYUTQr?=
 =?utf-8?B?MmdMOEQ4a3FMZGc3eXRkdFkveko4UFNlbTd5UnpZaTltU0doM1JqV3pmYncv?=
 =?utf-8?B?cjNLb2NaVUJkMlA3K1Y4TDBsTXJ1U01yTFd1Nm1vcVRuMXZRaXNKNlN6cXd4?=
 =?utf-8?B?UjVjS1hZeUF6K2NXbFFwT0N3Q1haTjZFUmpsNjNSRHFxYVNQQWp0Qnd1eWNY?=
 =?utf-8?B?VnhnQXpZZGJEYm5pYUVrTC9SVmlzY2VyRC9WMjQ1L0VqWDBQMjVJUTU4NUZN?=
 =?utf-8?B?Wm1MSjYyRDNjQWIvV0lSYmxOS295TVlySnE4amxHUlJvSHE2VHpVY0p1bmtn?=
 =?utf-8?B?VVhTWlFVZ3d3emNydmNIbVpHaU84ZEM0S0E5Um9IeWphcTNKa3pmT0dvZHFx?=
 =?utf-8?B?UHplK1h1OWFHTWtqL0pyMituZlVlellCNUlqaWRSWUJjRnVYZm0vWTNJQU5H?=
 =?utf-8?B?TkhlMUtzcHhmSUNnc1ZVNmMxMXB4SThkcDB5ZnZlaSszb2VLd1pkRXRqSzVY?=
 =?utf-8?B?L1kvN0UybnZMWlpqWTlFMk5KcVJjK0xXeXdUUU8wUmRvTkl2TlNsNEZzZUNR?=
 =?utf-8?B?c0F3Q2hOeVo4emZISzYzeEpvME43T1IvNlpOQmtaSFlzeXVaUnp1bDQyVkRp?=
 =?utf-8?B?WHVYdGtUdEhmVmw0eFpxWjAyMzRwcDdxbVg2NENzS2VaSGMybE02K09jYUdK?=
 =?utf-8?B?S3dQOE5nQkdIa2hYRGM1bGU0ZTRQSkdYeTFYbFpZLzRsUzFwa3ppd24vMUZt?=
 =?utf-8?B?RFZCbjVsOXBPOHpseE9JdWprMXN3cC9MSHI3WExzRXNTSEdiRXVyKzRpZElJ?=
 =?utf-8?B?N0xSZmZ6ZVZoL25LRVVaclJjbDkxUDZFOG5kS2R2RjFydUkxNWc2c1lack9H?=
 =?utf-8?B?YlFKbFNSWVVxc1I4Z0ZTMDVNMFdUbnFJM3dWQkFlN1hhZWZldGRMLytuMEp4?=
 =?utf-8?B?b3FwRTVna1RvUGlBeUtIK1hGVDg1RG5OTXlMZmJBSGNTdXVUWmUrdmFyckx2?=
 =?utf-8?B?b1htSHRCM2ZEY0F2bTdsTE15QUNNOXlUQldEMXRFZjAxRk1FUWp1dFNKaHNH?=
 =?utf-8?B?NUVZZlZHNG02SUQ3MTBSd0c4cjdnQmdOdXIyaGdYQ1hqaW5GMDJGeXVyL1FO?=
 =?utf-8?B?K1F6em5RVkZGSFM5ZW1tdkhqbjB4VDBGZis3VkVpVkNLMGlVazVueDZjMUFy?=
 =?utf-8?B?NjNsc2JGaXZJNU8remhJZ29TblJDdUJFVHJQVlhBc0VWaTkrSjE1cW1uZjVr?=
 =?utf-8?B?RkdVWERvR1ZSVmkzbjl4dDhoZ2xUcCs4ZURrdFV4QnY1aFFqZSszWnlncmhh?=
 =?utf-8?B?dzR3Tmh4TlFvbmh1Mks0d2RKdXQvK1RuOVQzemd2NkpXZWtOVmhTZzJ2ZXNo?=
 =?utf-8?B?WTFVTVZmeEllZU1FTzVzaEdvbnRsNEJLakhkV1BPVm9FSVlpSmxaV3gycEcr?=
 =?utf-8?B?bDg1V3lFQmFvK0kybDRGM1ZnMWtkMDFJbFpHNEN5QWR6YmV4Z2JzRGpmWVRM?=
 =?utf-8?B?d3hzUmRmbzJOSzlTUlhqYmRSRlkwOVljSmZGM1FCWWhUa3lCUlhpOU9wV1dh?=
 =?utf-8?B?UUs5WTZxcnRBYWRzZHBpZ0Z3NldSRnNZZ0M4c0g5bm5NVlM4OTBZNDBZUk5u?=
 =?utf-8?B?VW8vaDVoYW5oR0dBb0tYWFFJZ3U4Slg3anNTTVV6RUpLbWdSQ2lBU1RZOTY4?=
 =?utf-8?B?Y09yZm5kL0g4eGYzQW52eitEbU9UNkU4cWVFVkQvMDdkdUY2U1kvKzhuemVV?=
 =?utf-8?B?T25jQXZZalM5d1ZkMjZrN3h4bnpja3V3OElUU1BBTFBVZlh0NFl1L3hUejdT?=
 =?utf-8?B?cjJzOElTNHN6TlNEbHNxZTN4d3gvaGlYU1dHcTBEVG1rM2NrN2IyVFVWRlA3?=
 =?utf-8?B?VU1EdHlIZmRncVhzRlUzeEVUUnhjYzJrZ2tieXpSd1F5Zk12b1F4YlFsb0xI?=
 =?utf-8?B?TExqdHBDbGlqczZBazkvK2thWXErYzRxMXUyUGN3aHRDSkJmaTJJSEhQY0Fm?=
 =?utf-8?B?U0JGVm81WFZmNEdDejRQbFp6UU42N2h2TXE2WGZHdS9vS1FZVytsZ1Q1Mlp1?=
 =?utf-8?B?MFJwQVQ1Q3Bad2F6NXdiRlcxdWJjeENvRCtSVkRqMzNnVmRKRDN3WTB2QU5T?=
 =?utf-8?B?RTdnejE4MUg5b296Z2lValJsa2xtcGtCL2tiWndqL0U1RFhTWWllVXhiWFUx?=
 =?utf-8?Q?BM7xLy9PcuOWFHb3hz4kS8Vdm9j+JAdcR7N6a/m6Wlwpj?=
X-MS-Exchange-AntiSpam-MessageData-1: FB+J1ZMuKIz29w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaa2580-54aa-43f8-37f4-08df076b015b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:20:27.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMUXu8ibjPmMLLePoUFRhB9XMr7ZhrU59/GgxX73VA2WVxUt34dI6HEKUcNpP051nz/+essiQDhMV5IzZ4jRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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

On Mon Aug 31, 2026 at 9:50 PM JST, Danilo Krummrich wrote:
> On Mon Aug 31, 2026 at 3:08 AM CEST, Alexandre Courbot wrote:
>> On Sun Aug 30, 2026 at 4:14 AM JST, Danilo Krummrich wrote:
>>> On Sat Aug 29, 2026 at 5:34 AM CEST, Alexandre Courbot wrote:
>>>> On Fri Aug 28, 2026 at 9:09 PM JST, Danilo Krummrich wrote:
>>>>> (Cc: Miguel)
>>>>>
>>>>> On Fri Aug 28, 2026 at 7:33 AM CEST, Alexandre Courbot wrote:
>>>>>> The `kernel` crate now features a replacement for our lossless integ=
er
>>>>>> conversion routines. Switch to the kernel version and remove our own=
.
>>>>>>
>>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>>>>>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>>> ---
>>>>>>  drivers/gpu/nova-core/falcon.rs                    |  12 +-
>>>>>>  drivers/gpu/nova-core/falcon/fsp.rs                |   4 +-
>>>>>>  drivers/gpu/nova-core/fb.rs                        |   2 +-
>>>>>>  drivers/gpu/nova-core/fb/hal/gb100.rs              |   6 +-
>>>>>>  drivers/gpu/nova-core/firmware.rs                  |   4 +-
>>>>>>  drivers/gpu/nova-core/firmware/booter.rs           |   4 +-
>>>>>>  drivers/gpu/nova-core/firmware/fwsec.rs            |   2 +-
>>>>>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   4 +-
>>>>>>  drivers/gpu/nova-core/firmware/gsp.rs              |   9 +-
>>>>>>  drivers/gpu/nova-core/firmware/tlv.rs              |  11 +-
>>>>>>  drivers/gpu/nova-core/fsp.rs                       |   8 +-
>>>>>>  drivers/gpu/nova-core/gsp.rs                       |   4 +-
>>>>>>  drivers/gpu/nova-core/gsp/cmdq.rs                  |  22 +--
>>>>>>  drivers/gpu/nova-core/gsp/fw.rs                    |  42 ++--
>>>>>>  drivers/gpu/nova-core/gsp/fw/commands.rs           |   4 +-
>>>>>>  drivers/gpu/nova-core/gsp/sequencer.rs             |   2 +-
>>>>>>  drivers/gpu/nova-core/mctp.rs                      |   8 +-
>>>>>>  drivers/gpu/nova-core/num.rs                       | 211 ----------=
-----------
>>>>>>  drivers/gpu/nova-core/vbios.rs                     |   2 +-
>>>>>>  19 files changed, 78 insertions(+), 283 deletions(-)
>>>>>
>>>>> Please see the discussion in [1].
>>>>>
>>>>> If we make this change, then the subsequent conversion to const_as!()=
 would need
>>>>> to go through the Rust tree next cycle, which could be a bit of a mes=
s, as I'd
>>>>> expect a bunch of conflicts.
>>>>>
>>>>> Alternatively, we could the the full three cycle dance, or have a sig=
ned tag for
>>>>> const_as!() and use it right away.
>>>>>
>>>>> But honestly, the former would just be unnecessary noise. If we don't=
 do the
>>>>> latter, let's just keep the nova-core num module until the dust has b=
een
>>>>> settled.
>>>>>
>>>>> [1] https://lore.kernel.org/all/CANiq72k+-fNWZCwGuQ=3DFTchxgm-X-f6WR=
=3DtG=3DErcn19ic1edQg@mail.gmail.com/
>>>>
>>>> Maybe I am missing something, but wouldn't the following work?
>>>>
>>>> - rc1 gets tagged, `drm-rust-next` gets the `num::casts` module,
>>>> - This series gets applied to `drm-rust-next`, then `cv!` (without the
>>>>   nova-core conversion patch) in `rust-next`,
>>>> - We wait one cycle for `cv!` to trickle down to `drm-rust-next` befor=
e
>>>>   converting nova-core to use `cv!`.
>>>>
>>>> Would that work? This series doesn't overlap with the const conversion=
s
>>>> that `cv!` covers on purpose, and it would have the benefit of getting
>>>> rid of the local `num` module in nova-core quickly.
>>>
>>> Take casts::usize_into_u32() for instance, drm-rust-next replaces the u=
sage of
>>> it next cycle, but rust-next wants to remove the API from
>>> rust/kernel/num/casts.rs.
>>>
>>> In this case rust-next would need to get rid of the users (including no=
va-core),
>>> but drm-rust-next will likely do different changes, so we'd get unneces=
sary
>>> merge conflicts.
>>>
>>> You can resolve this either by keeping casts::usize_into_u32 and friend=
s around
>>> for one additional cycle, so that all users we introduce now are gone. =
Or, since
>>> there's no rush anyways, we just wait one cycle and use the real thing =
right
>>> away.
>>
>> Sorry, I should have explicitly mentioned that `*_into_*` would remain
>> alongside `cv!` for the next cycle.
>
> Maybe we have a different understanding of what "next cycle" means. As of=
 today
> we are in the v7.4 cycle, so I call this the current cycle.
>
> In the next cycle, as discussed in [1], rust-next will drop casts::*_into=
_*(),
> and so would drm-rust-next, if we start using casts::*_into_*() in nova-c=
ore
> this cycle.
>
> I don't want this situation, so we can either keep casts::*_into_*() arou=
nd for
> even longer, or just never start using it.
>
>> The reason why I think it's preferable to use `casts` in nova-core
>> sooner is that some of the series currently under review (and that will
>> likely be merged next cycle) add more uses of the local `num` methods,
>> making the eentual conversion more painful. If we move to use `casts`
>> early we can at least avoid the churn on those cases that do not use
>> `cv!`.
>
> It would come at the price of adding cross tree dependencies and converti=
ng the
> cv! parts twice, which is much worse than one clean and independent conve=
rsion.

Got it - let's keep nova-core's `num` for one more cycle then. This will
make for a larger conversion, but the silver lining is that this means
less rebasing for the patches currently in-flight.

I'll revisit this series for 7.5 (?), although I guess patch 2 is still
relevant as long as it keeps using nova-core's `num` crate.
