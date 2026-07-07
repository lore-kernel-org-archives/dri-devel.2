Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2521C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EFE10ECC5;
	Tue,  7 Jul 2026 12:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnYxcjGW";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4A510ECC5;
 Tue,  7 Jul 2026 12:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mewVFLXlAdYgtp29AjiQnt8ENuw1GOJ3weNrsJ2wktt3P5TH1XctRP8ZS5WmQrdbkr6L/csIvEiiogPKVlMgmTn6ACwEvIQkS4l/wCmEo7TFuc48NLfYfcGx5SrhKJIgGOug+/Cq5SUmDjHaMhKNJFqO275hz215cqHA6NxNJOdwIMFNYAzsQTeqazpHu3yOUIrsBVuEhkc79T5914MmiYuKAzKz1lukPLWGlWT30+XxfZmGaGdWJMOYStr7ul5NmvtAEm1vCqZNlTLyEXsQLw/idg1PtNMiaXD/mKk5L8rjdClc3kv8biYOwI0LYuvs7ErenyX3I5NppAFFCX5QOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4QWmduydawm1NLJUQm5JsiQbBeF5tHGmZD1BNFakBg=;
 b=A+ejyzeUV/yaVlLFqvKoMKDywoClIyd/bOT7I2BILZoyyldguJDKLwojz6HjEK0WRFQ/Pfsm51znIzt/+Iog64u4pmgOQaQwBpzuZA92Xjqvg+412cBp0cJRQjYSF7FFYp3PPWB0yJkN4Qpi2yeFfCOlFe2kcMSGa2gaTlXkNynaMfg3GCO2phlWGkpm10bXMKiQj0of8CBimEJh9CuMh2e0D9kXArrLCc6eLlNT6pjv1EiCBWopb1NaZxp05nIncrNj75s+7/dty+HKydhe3KWiUUzv4if57Ycohiz8VOH7/uRsHooioNf9tiU+2mTheuIFTi35TR1w1G7VjLvg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4QWmduydawm1NLJUQm5JsiQbBeF5tHGmZD1BNFakBg=;
 b=TnYxcjGWjUcBBCXtRc8V2PYIPIWqsEwdGdeLz/FCdAXVBNwNq6ar39xlg5R2D7x47nit34MCl8BgabcB0p+6cZxM0muBU07Ydh1FylXQ7mLsW+JrMTn2vvi1LJDykqYnuLdNQgbYWj0EuV5Xkdl+MgaopZ1z174VhG3ZxkoLMytQBXZVny/17gdDOrddOXE/8Vef4OHVyhXuAIpW70/kTbxdPrVv31Dcdofhcu2ESZUbrR3bNKvaPPNeUJpAhbHiaJ2jk42rsFnUep0ezL8bF0YB6+jhOSOScnB5j9VwTM3lPUmFC287BBGhLVcccqRfznx6SXq0VhFBUArCj+9ZEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 12:56:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 12:56:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 21:56:50 +0900
Message-Id: <DJSCTKZ97STM.2D8YP8LIVELH2@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
 <DJS6M2YBO8RS.33T3S32EFHL1Z@nvidia.com>
In-Reply-To: <DJS6M2YBO8RS.33T3S32EFHL1Z@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:405:370::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: aa58e7fb-57f6-48b2-a449-08dedc27386d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|10070799003|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1Dw8ogn34uXLjKyBaVTh7SmvpLqsx/JvRKip3eH5Nsr4JVX0ioParHxlyHAKNCMzgXYTKn88fsQvSt/fSjpcIkUFdNf+fTF+x51vHNTTBsXjACPIAQqV5d0iS4XZp8ano9TDB7NUNpFWLT+LStthAlC8uf33Q9EhuGDu5oO0kgkZ7iNmim/3ErDS+zCNYtda0XWWSMFNH4qqXMrbkZLZkAV78LWdfvIoM7EseVq1wu7E9Qn3Ond+fAR8l/kd97os90er90BW5CYHp1cduBE0GhohbdZd2FUzDaMaGXZlNREGs/+DgDYIP2Ej0qHQq6m3DBnoDY/9Vh7YVSSft9M9/B2p43Qo5HATzDJurWxpkAX4DCMkuQu13uOvI3AN/g7vj3NMjMz/vvshJqf2LAUHUAP8bms8rjMv/8a9q96yH8JAaqUdwo7wFGdRGgL3NEaXMrLZ5yXbN6M98nuNVS9eHWICD0pGWwEp9Xvldz4TqCFUhmUdGf1lqXAtYZXovlteOHW+pqXMeUT8hN7DqRdjJlVY6lTDc2a/iLNp9GkkYSlXeonKQyMP/ZyfGIVr8F73e5u4pKzTTqxiK0HbrDmPxi+sodhISS8KPSiv8ayYc9lSam67wgUcf+8XjA5DnZKpLQ6RcMpzn1SqbnXRKQ7ZXMfzYYJcVBftFjJwN51RCi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10070799003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRMTVEzK0NmZlQ3Mm9KbFhKOXM5R2twV1NlUFVaTzFTZDJ3NVJvNEk3UTVs?=
 =?utf-8?B?YW9OS1pLQUNvaW44cXZYWDlpR04zODRtc3ZvTmpLaGZxL2thdmlWOFhNaWZa?=
 =?utf-8?B?WFM2RlJwVlBWdHFLREhWLzBpeUhmNXdqMUJNSXUwUE80SlZYRTc3UUlldmhp?=
 =?utf-8?B?NWtDaXhLQnpBZzcwQ1ZrK1NBSy9LWXRBbjdoNXY5TjlNRlpwMVNSSWg4RXMz?=
 =?utf-8?B?ZjQ1anJlL2VmYUFvVXg0aEQyem5CNHhEL0hTUmJhZUtJZzJJeVBBS1ZPZE1l?=
 =?utf-8?B?dzN5czE3b2ovNm1lNy8ra1hlMHhnaTN0TnIrRXcyK0pzMGQ3NEMyVlc4YW5y?=
 =?utf-8?B?NXFtSlJ5RHJQcU9HckJnN0g3ZTJ6VDNBUVhpMFZXZWl0anZVOENmczZ0Qm1D?=
 =?utf-8?B?UlZOMjFQczJtYmVYbDRLcUs4MXJMbDI1aGZ1YVpSOVpQT2cyV0lBZ2VZbDJ6?=
 =?utf-8?B?RnpNa2E5bzJtbVpBOWVPOTM3NVZHSWxpWWxlNkpSTDZKQW9JZ3lzTGUwamRP?=
 =?utf-8?B?QTNDVnpleStuQTF0OSs2ekJFKzZDRHNzNzNxWnZUR3lIOWI1K2J6RE5zUTNY?=
 =?utf-8?B?cGMvVnBJbmUvS2pOVWt4TUE1ekc4c0ozbmU4U2lULyt3bzdVRW0rS05NUHcr?=
 =?utf-8?B?eWJBOGlSeEFXaUJIcmpkOWtGT2Npc1VKdXpnT2dQQnozUWFLRHA1YzdGb1h3?=
 =?utf-8?B?aVFGSEtBQUwxdnJZNmtNcXJrZWkrcjNGVFl6Ung2a250S0tvM3pqV1dHVjRs?=
 =?utf-8?B?bGljb3FNYjZlbFczT243cFNkUW54SGtlcllkOHlIZllVMGtuT2U1Z25EMFdS?=
 =?utf-8?B?Z20vY2lzY1RPckRyTXFqM1NOdHhqRVBtS3pVNXlscEFaRjF1ZjJJZ1c2clBI?=
 =?utf-8?B?M3ZsYnpVWjY5NC9kZEhibG9jcVhCTzlFemxPL3V4NVlsaHNtUXlpU2htWFF0?=
 =?utf-8?B?WldTQVk2U045bDNFRFFoRXRPYzB1TmFoelhKZnRHK3c4M2ZQcmZxQ0FHOHdQ?=
 =?utf-8?B?aWF4dVBPVGpTNDllVEx4N3dvQ0JBcVJjWGFQNVhiRU9sL1ZxS283bUhWbG1y?=
 =?utf-8?B?a1hxVDg1N01RSEo4ZFI4NVVRSHZUSW8xWUdKa05WY05kWVNlWWgxYTR5ZFdu?=
 =?utf-8?B?SnhCcS9nWlRWaVppQ0tQUDMzaElwNXBBSThjbU1OV0Zma3Bta21iblFreDJH?=
 =?utf-8?B?WjhBcHRTazVjMjEvZGJnMHNmbWsrUEQyUjRiQm14VS91NWZHbW9RU2pxQVAr?=
 =?utf-8?B?aDMzR3dUc2FHcUJmaUNHb1RSUFVvZjdaRW9lTklNdTFBUXAwOEdXYjB2QWcw?=
 =?utf-8?B?UnNZOXBuZHdJUGpucUVhd0xjRmdGeDdZLzhWOXlHSDFONDNiZlhVRUR4b3Ex?=
 =?utf-8?B?TmNrQndkblhnUFhYb0N0WXJSZHk0UkprbkZ2ZGxTN1VtZXFkNmM2V0RLcXph?=
 =?utf-8?B?dThMKzRaTFFDRXFlZ0tvNHZmWDhMclpmTGtrTlNuSGRvODcrMVhUOUZaNStB?=
 =?utf-8?B?bUZkZXQ0bW1mc3dHRVF3eHFqUnViR0t4azVvb3haZmFQeTNzYStQekNXU25i?=
 =?utf-8?B?eENCZE4rR09jd09wMWk5VDVOTWFMakErT0hjUy9WbTBZQzMxTnFSSVp3eWR3?=
 =?utf-8?B?aStCMjZpaVNVYmVMQjVTUUU2Nnh1cEdiSytOclp3RUNaUE8xdXExdmtWK3Vy?=
 =?utf-8?B?SUoyZExNM0dvUy81dGN1UkVacEExM2lpUDJPcVZOZU1pODdVd0phSVJLR3pQ?=
 =?utf-8?B?dzlKWTRnQ1hDMnNRSDVLRnM2K1Eyc2lzY0xzRC9lbG1RY1RVaHU2VjZkdnpz?=
 =?utf-8?B?VmR0alRJQzAyQS85aDZyVWhSWGg4NVorS0oxVnR6b3RPbzE4WWNDTDJ2VElT?=
 =?utf-8?B?UnpMamYxdlgwRGZYbitoYUdTVzN0U1A4bUhOL214ZWRuYmFKcGdoSzRwejFT?=
 =?utf-8?B?bTI1ZExzME5hOFBjS0VJWSt5UnhCeHdlbHcrNERhMXdiejY3UnpmVGNBTGdR?=
 =?utf-8?B?eHFoM0FlZnJtYVlEak05a0grSmFjQ0RIYzVkSnVKYmVWa3RkYlRkTWIwQzFa?=
 =?utf-8?B?d0JkRkYrNmFERWFoZ2t3dDJKYlNRdSt6M01oN2Fwc0R5K1c5VnhKY2RROWY3?=
 =?utf-8?B?NmJxZDdXZzJZdmx6TDlkNVRqQkd2eVpJSEFUWEVJTmZzRUNVS09kVktOTFBy?=
 =?utf-8?B?UjNwYU4xUk5TZGhoMzRwSkVzd1ExdW5kODEzdTl5bHZ4WFhYUXRkRWlNcTNH?=
 =?utf-8?B?Y2p6V0ZjZFhjby8rU1NsZDBrNGNJWkR5ZWhSOUoyM1RHNDB0MWlwQVltRUdo?=
 =?utf-8?B?eE4yNDRhL3ZkdXRJM3I1cDZiaHMwSjFQMmpNTk1XVlorR292dDg1eVF5S01s?=
 =?utf-8?Q?5LCGU7bt0UlQ9vW8p8wNe8H/JoDF15ua2J+f8VrbTnF6N?=
X-MS-Exchange-AntiSpam-MessageData-1: zzOkViJyxdxpww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa58e7fb-57f6-48b2-a449-08dedc27386d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:56:54.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABBDddE+ZIpcXmasdXQGajapHRd7O18lSK2dPIAeHp1BNhOAy3eLdHptKv47b/him40mV1D1wrv4gD3mMmGfBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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

On Tue Jul 7, 2026 at 5:04 PM JST, Eliot Courtney wrote:
> On Tue Jul 7, 2026 at 4:21 PM JST, Alexandre Courbot wrote:
>> When adding the GSP unload capability, we introduced `BootUnloadGuard`
>> to automatically call `Gsp::unload` whenever an error occurred during
>> the boot process, in order to try to reset the GSP to a valid state.
>>
>> This approach is not well-suited to the errors that may occur in HALs:
>> by definition, an error occurring in the HAL means that the GSP is not
>> booted; yet the first thing that `Gsp::unload` does is queue a shutdown
>> message to the GSP, which will inevitably result in a timeout when done
>> from a HAL.
>>
>> Furthermore, `BootUnloadGuard` is problematic because it holds
>> additional references to the boot context, notably the `Falcon`s. These
>> extra references stand in the way of making some of the `Falcon`'s
>> methods mutable, since those methods would require exclusive access. As
>> this behavior is only needed in one place, introducing dedicated types
>> for it is distracting and unnecessary.
>>
>> Thus, remove `BootUnloadGuard` and adopt a two-level error handling
>> strategy:
>>
>> - HALs are free to handle their errors as they see fit (most likely, by
>>   running their unload bundle if it is ready by the time of the error),
>> - `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
>>   GSP should be up and running by the time `GspHal::boot` has returned.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/boot.rs      | 67 +++------------------------=
-------
>>  drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
>>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 31 ++++++++++------
>>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
>>  4 files changed, 44 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/g=
sp/boot.rs
>> index ab0491b57944..536f2e341c01 100644
>> --- a/drivers/gpu/nova-core/gsp/boot.rs
>> +++ b/drivers/gpu/nova-core/gsp/boot.rs
>> @@ -30,66 +30,6 @@
>>      },
>>  };
>> =20
>> -/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
>> -///
>> -/// Stored as their own type to avoid repeating a long and tedious list=
 in [`BootUnloadGuard`].
>> -pub(super) struct BootUnloadArgs<'a> {
>> -    gsp: &'a super::Gsp,
>> -    dev: &'a device::Device<device::Bound>,
>> -    bar: Bar0<'a>,
>> -    gsp_falcon: &'a Falcon<'a, Gsp>,
>> -    sec2_falcon: &'a Falcon<'a, Sec2>,
>> -    unload_bundle: Option<super::UnloadBundle>,
>> -}
>> -
>> -/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
>> -/// [`UnloadBundle`](super::UnloadBundle) when dropped.
>> -///
>> -/// Used to ensure the `UnloadBundle` is run during failure paths.
>> -pub(super) struct BootUnloadGuard<'a> {
>> -    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
>> -}
>> -
>> -impl<'a> BootUnloadGuard<'a> {
>> -    /// Wraps `unload_bundle` into a guard that executes it when droppe=
d.
>> -    pub(super) fn new(
>> -        gsp: &'a super::Gsp,
>> -        dev: &'a device::Device<device::Bound>,
>> -        bar: Bar0<'a>,
>> -        gsp_falcon: &'a Falcon<'a, Gsp>,
>> -        sec2_falcon: &'a Falcon<'a, Sec2>,
>> -        unload_bundle: Option<super::UnloadBundle>,
>> -    ) -> Self {
>> -        Self {
>> -            guard: ScopeGuard::new_with_data(
>> -                BootUnloadArgs {
>> -                    gsp,
>> -                    dev,
>> -                    bar,
>> -                    gsp_falcon,
>> -                    sec2_falcon,
>> -                    unload_bundle,
>> -                },
>> -                |args| {
>> -                    let _ =3D super::Gsp::unload(
>> -                        args.gsp,
>> -                        args.dev,
>> -                        args.bar,
>> -                        args.gsp_falcon,
>> -                        args.sec2_falcon,
>> -                        args.unload_bundle,
>> -                    );
>> -                },
>> -            ),
>> -        }
>> -    }
>> -
>> -    /// Disarms the guard and returns the [`UnloadBundle`](super::Unloa=
dBundle) it contains.
>> -    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
>> -        self.guard.dismiss().unload_bundle
>> -    }
>> -}
>> -
>>  impl super::Gsp {
>>      /// Attempt to boot the GSP.
>>      ///
>> @@ -107,6 +47,7 @@ pub(crate) fn boot(
>>          let bar =3D ctx.bar;
>>          let chipset =3D ctx.chipset;
>>          let gsp_falcon =3D ctx.gsp_falcon;
>> +        let sec2_falcon =3D ctx.sec2_falcon;
>>          let dev =3D pdev.as_ref();
>>          let hal =3D super::hal::gsp_hal(chipset);
>> =20
>> @@ -118,7 +59,11 @@ pub(crate) fn boot(
>>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::=
new(&gsp_fw, &fb_layout))?;
>> =20
>>          // Perform the chipset-specific boot sequence, and retrieve the=
 unload bundle.
>> -        let unload_guard =3D hal.boot(&self, &ctx, &fb_layout, &wpr_met=
a)?;
>> +        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_me=
ta)?;
>> +
>> +        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |=
unload_bundle| {
>> +            let _ =3D self.unload(dev, bar, gsp_falcon, sec2_falcon, un=
load_bundle);
>> +        });
>> =20
>>          gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
>> =20
>> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gs=
p/hal.rs
>> index d3e47ef206de..851d1f24c137 100644
>> --- a/drivers/gpu/nova-core/gsp/hal.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal.rs
>> @@ -24,7 +24,6 @@
>>          Chipset, //
>>      },
>>      gsp::{
>> -        boot::BootUnloadGuard,
>>          Gsp,
>>          GspBootContext,
>>          GspFwWprMeta, //
>> @@ -51,15 +50,15 @@ fn run(
>>  pub(super) trait GspHal: Send {
>>      /// Performs the GSP boot process, loading and running the required=
 firmwares as needed.
>>      ///
>> -    /// Upon success, returns a guard that runs the GSP unload sequence=
 if GSP boot does not
>> -    /// complete.
>> -    fn boot<'a>(
>> +    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use w=
ith [`Gsp::unload`], if one
>> +    /// could be created.
>> +    fn boot(
>>          &self,
>> -        gsp: &'a Gsp,
>> -        ctx: &GspBootContext<'a>,
>> +        gsp: &Gsp,
>> +        ctx: &GspBootContext<'_>,
>>          fb_layout: &FbLayout,
>>          wpr_meta: &Coherent<GspFwWprMeta>,
>> -    ) -> Result<BootUnloadGuard<'a>>;
>> +    ) -> Result<Option<crate::gsp::UnloadBundle>>;
>> =20
>>      /// Performs HAL-specific post-GSP boot tasks.
>>      ///
>> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-c=
ore/gsp/hal/gh100.rs
>> index 1d06405a32f6..18c889f9f413 100644
>> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> @@ -23,7 +23,6 @@
>>          Fsp, //
>>      },
>>      gsp::{
>> -        boot::BootUnloadGuard,
>>          hal::{
>>              GspHal,
>>              UnloadBundle, //
>> @@ -143,13 +142,13 @@ impl GspHal for Gh100 {
>>      ///
>>      /// This path uses FSP to establish a chain of trust and boot GSP-F=
MC. FSP handles
>>      /// the GSP boot internally - no manual GSP reset/boot is needed.
>> -    fn boot<'a>(
>> +    fn boot(
>>          &self,
>> -        gsp: &'a Gsp,
>> -        ctx: &GspBootContext<'a>,
>> +        gsp: &Gsp,
>> +        ctx: &GspBootContext<'_>,
>>          fb_layout: &FbLayout,
>>          wpr_meta: &Coherent<GspFwWprMeta>,
>> -    ) -> Result<BootUnloadGuard<'a>> {
>> +    ) -> Result<Option<crate::gsp::UnloadBundle>> {
>>          let dev =3D ctx.dev();
>>          let bar =3D ctx.bar;
>>          let chipset =3D ctx.chipset;
>> @@ -160,10 +159,6 @@ fn boot<'a>(
>>              KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadB=
undle>
>>          );
>> =20
>> -        // Wrap the unload bundle into a drop guard so it is automatica=
lly run upon failure.
>> -        let unload_guard =3D
>> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon=
, Some(unload_bundle));
>> -
>>          let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
>> =20
>>          let args =3D FmcBootArgs::new(
>> @@ -174,11 +169,23 @@ fn boot<'a>(
>>              false,
>>          )?;
>> =20
>> -        fsp.boot_fmc(dev, fb_layout, &args)?;
>> +        // Keep the result as we want to wait for lockdown release even=
 in case of error, to make
>> +        // sure `args` is not accessed by the GSP anymore.
>> +        let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);
>> =20
>> -        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params=
_dma_handle())?;
>> +        // Wait for GSP-FMC to release the GSP lockdown, indicating tha=
t `args` is not accessed
>> +        // anymore.
>> +        let lockdown_res =3D
>> +            wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_pa=
rams_dma_handle());
>> =20
>> -        Ok(unload_guard)
>> +        match fsp_res.and(lockdown_res) {
>> +            Ok(()) =3D> Ok(Some(unload_bundle)),
>> +            Err(e) =3D> {
>> +                // Wait for the GSP RISC-V core to halt in case of erro=
r.
>> +                let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, sec=
2_falcon);
>> +                Err(e)
>> +            }
>> +        }
>
> IMO we should just ScopeGuard here too (after args creation) to run the
> unload bundle. It will avoid manual manipulation of results which is
> error prone (since a ? added later will break things) and also halt
> happens-after gsp lockdown, so it's a natural sequence point. Also I am

ScopedGuard here is reasonable - do you mean only for running the unload
bundle, or would you also duplicate the lockdown release there so we can
avoid using `and`?

> not 100% sure but I am not fully convinced that
> wait_for_gsp_lockdown_release will correctly detect all errors if they
> occur.

The failure path is a best effort. I don't think we can guarantee
anything as it doesn't appear to have been designed with recovery in mind.

>
> With ^ change,
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

Thanks!
