Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49795CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFA710E953;
	Tue, 23 Jun 2026 05:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="M7pNPP72";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D8610E953;
 Tue, 23 Jun 2026 05:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwyn6/knYHpp0XhViKE0zJSn4+o1dX3Rx68LFDfFIBfxYDNxTAH2Snk262tg1FJv/buYVynSlmVIFhhmv+OL9i+SNjgbN+GdFJR/cQiXLdapcDDlKGS2gJXbga2qz3EW++POco6O4vL/mEecCvKAg7noGX2fiiSQd2WMbIjJQ4E6Mkjcxm9WMq0zgr89Nu0S8aHRNXB9UckNQFn/3QZXTSybOKwFvUiGhyoNJoVLpQWmjC2oyEnb/8bHkCK9xiBS4ApOkq5XaVY+X48qDIqFlAFNw2Ttrp+nRC7HWtsB6r6FqBIN9AdnDHPtrx7HHtcThUBCVcjpVzccEP+u8nUKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT1WjYlARq7nqR7ctJBqu7VbYrVOr7gION/DzEkfQNU=;
 b=ZEzbwWRfu1s+usDn4aaQxZMglnPSfEJImF4TkYiCXbY2ZkBkhvIYLPiHz7ZqgPkDXrkAM3m/r2iCm2yWB8Zx0lvD7nGJfj3verJ0r7jc5jyNxjfubHw0dXgjtAthGp5xQzQik17Pk6qR5AsrVb/Sgu/yKs2+qR5g0UHp8ZIlfQ5B/zX9mTjbR3bKba6J0XTb40Eof3ScBStp8H5fenZP8OW1TBEpX2V8OgWBtbrWsNL92JvRcfux7Ris/Pj7m77NR3w11yFUceZ0xUqx6azMr9U9/OH3umcoF7KotZzaw9n56F3hN71Ouax44Rq4H7NYf0ch8v2gY8EdRLk6IJ1SmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT1WjYlARq7nqR7ctJBqu7VbYrVOr7gION/DzEkfQNU=;
 b=M7pNPP72IjDn/UnAkB692K30kGfW1npCkyeDA90F08DNqKV3ODOOsQIrom94rNTRuTFnHg8Ss7Xn8iexlXFp0hHC3RRv8RiFCUbEp7pNTNeENy0E2wusxyb9e1ob0Zb0q5kchLupIDK+33xQOgU4/Ih9GuicyUJ/fbduXlbWqp2ultkFhUgDK58FLc1XEcAOPVQkhMNqPjJRf1ZP+bvxtA7PjM7sk/xBEDATYx03DdDDAQ7DQoYSU1ydpetho6BU9guiqbNJp5MzzJfy4K5V4/vm+Hllmiuzm7TLkTX4OhbAYxo4TpxNOLEDVeyM2asTvfpwnU+6gAxV2+sq5G0LqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BN7PPF28614436A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 05:40:48 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:40:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:40:44 +0900
Message-Id: <DJG6S20KHJK3.TKRZLBYUPGG2@nvidia.com>
Subject: Re: [PATCH 3/6] gpu: nova-core: gsp: move boot code into local closure
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
 <DJFF1W6VGY4Q.2PV5MEPMFXIDB@nvidia.com>
 <DJFO5A5XN2EO.22B58J2O6D4JG@nvidia.com>
In-Reply-To: <DJFO5A5XN2EO.22B58J2O6D4JG@nvidia.com>
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec67916-77ec-4355-849c-08ded0e9faaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|366016|376014|7416014|18002099003|22082099003|11063799006|3023799007|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: AhkgnPsQ+XotbLgsJnzG2u/+q6RzkGi5jEzDn5380BxtFWIe4ihDb6VdeGxyPLHtzlEo6J2OxcNExOqdagqNGpL+j6qozv1l2DQ7sfR+gkyWLj9EpUw1u2VkfV4mmLMuU6C/uaBZ7CO6OUGdmgJXHzKROPCErz/aqdd9m8YYl64GNgQI2KD1SJ+hbJpi26Mt0Qz7Uib9Cz2Be399u2M4HgNg9/z71WeyRmcTpDlBO6RnKqRc8F7yjhmK2BNhbo49s/Xbesu0+38tZUPM0o+Jc5bC+ifbQ0MCpwqybWqdHRWe3iQAqrciN5/hejshsPrIT+FRp3ctJwvMF+5QiwkL9ZZCgY4Gg9ZHU86bXrS3jnnnlcg/C5tFeBY4EMuVsY7VbJxo67qnaSEjnwX3iARhRwCbMapif+2KYYtfFbS+pPGQE+4b9FsCu+u7WngnyNZFy6pMUSrRcz2jjOA6k50ZyoW/mH9ofeI6WwO/cL+ArXnmJDidNxtibYv8whno2oM8o/ocTM4/Gh8SZ39HRn1JO81Lxab3NuKR8bVjAV6IkrDuWQEA7aj16W8FORBvgbAarIUot7+WRxtixYZKyJFheu/OS3WsgIxnS+hrvYYRcKl++oLanx5Bff5q5RCkpq8b3uVjYGwnRm0JGzPBSWuve5VZfK9G6S2a7W+RYWZhcYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(7416014)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hON1dxQ3JaV0NWcUN4MTJBYk44WC9WbU0xaTNWREVuWmlxcU9BOExVb2U4?=
 =?utf-8?B?ZFIwK1NRMWRjbHRZQWtaNlRYZFNGaXVubTAyU2VtS3N0UG5Vckt5cnZYVmZ6?=
 =?utf-8?B?ZWJyRm9xc1lOUUV3NGZPMWtUQ2xqZWkyV3V1V0YyZExwUFpIRW50eEZtR1V5?=
 =?utf-8?B?eS9FWXlUK1NseUVPaUZLd2FGQ0pFc2FwVXhrZUlRVGF5TnUxd2FQR3oyRGp5?=
 =?utf-8?B?NmRHOFlUTWgzY3IyWTZhdjYvV25TcFE5UWlLNUlKdUc1WWg5TTRTM2lZZEV2?=
 =?utf-8?B?M2VRNUo2aXZ2NGR6M2ljaTZkbHYwSGRFZjRYZ2Q0NXprOGhaejh5WTJWaGtL?=
 =?utf-8?B?ajFFbkpDQTRTOWtKYWV5TjM4QU8zTmNkaWhudHZaZWp3NmdCd1JxYmptRElH?=
 =?utf-8?B?d3NwdHpWYjFoUnJhZlhNRjNFT0hxWUlTck8rUitWcVhDdWFZVUxzWmdnK3RW?=
 =?utf-8?B?enR5Y1ROTTh3V1JkbW4xM1RPL0p2bnZyUnNaU01FYWdjWTdmaTdQRnl5SzRv?=
 =?utf-8?B?MTNHMGJsd1gxclVpMW0xdmxMdEl2UUFoUnF5SXlNaUJHYWFYYkp6UHhBMnJX?=
 =?utf-8?B?aUFHSnJPRW85aWxBNnhYaGFHSGlFemJYUXR6TXVMVnhueGliMGZ6VkwxaHJP?=
 =?utf-8?B?NmpCVVh0anltRVlSandjQ3JGdGRCSzdjVzNFcGZQQXlSYU9Sa1d3SFdYYXll?=
 =?utf-8?B?aU1PU2gwamx3SDZCbXNVb2V1ZHY0dEF1Rm9iSEp0M3lreUU2cDFaWGV1K3B1?=
 =?utf-8?B?L3E1VXdzVGg5VWE5U0tsVGE2cFJEdHl3LzBzd1JsaFRrQTc5WWwyTkE3WEhB?=
 =?utf-8?B?M2N4T0x3Vm0rNVp4WlRKeXRwazZVSC84b3hPVEhtN2dxbFluZ3lpYXQ2SHNI?=
 =?utf-8?B?ekhKb2REVkVtVnFFUElQanZHWkgyTkU1VlVOZXBQZ2U3M1R2Z1U3cnVXOUVK?=
 =?utf-8?B?R2cwbTN1bTFac3Zlb0NSRXM1aHBjQ1YwZFcydytHRy9kUXVuLytFZVRzeC9X?=
 =?utf-8?B?djJ6MVoxZnpBNXFKYVpXa3BSZUdtWTh5V0w3TElTT0dOQk9sQXd3MEsrdGRl?=
 =?utf-8?B?WkVZTnN6RW5hb1U3eG95K1VQMEpSUmJJWVdUSVErVDFLVjlsa2ZocytyS3VI?=
 =?utf-8?B?QUhIcXlZSmg0bVAxdXR6a0ladFpoMkRnME5OQUZLY1ZlYkFoM2ZXd3QyQ2pO?=
 =?utf-8?B?emRXTGdqYXFFZzFqWEU0aW00SDhielh6Q3hxYVRQOUlhNEY5aENoL3VnK1A5?=
 =?utf-8?B?Nk12ZmZqbms5S2V5bGdod0Q1dWFEUzVleVJCS2RFRllvbXlhcE5EUk9qRGZw?=
 =?utf-8?B?Z1ZqUjdCOFg5T0p0Smg1SG1RbGpnRmJ6NzBEN2FscWJnVlVBd2llVUtEbHd0?=
 =?utf-8?B?OTY5a1o0WHFYUmtYWlBNQ0FQM01jVUFzSGxKZWV5Y09LNUNLOU1RNkliOWlE?=
 =?utf-8?B?TzBCcUhjMUxDdXM1NTFaNEk0WXp3NHdieWpoVy9xWTl4ZzdqY2JFZWlDTG9D?=
 =?utf-8?B?R0xHdEx5UlJnVGZPQmdKZ1g3ZGtEQ1dZVzBOYzhGbWhrWldOem8xZTlKRE9J?=
 =?utf-8?B?RS94SWx0cTFwSWxnYnBSdk81RmttRzJOVWxVeEZjaEV3ZGdtNmFFM1JDZ1J0?=
 =?utf-8?B?MVJPZktOVTFsbmtBL1FUWHIxb0NUclRHSGoxd3Z5ODVramg4eWpaTU5KTE1r?=
 =?utf-8?B?RWVYQnltNVFMVDdBa2s3WGxzZ0F3QWxTS3BMK1pZcWQxd255Nitnb1ArakVD?=
 =?utf-8?B?TGs3bmtxL3NRc3kyamtWSUpBSk9iU054blJEYnNrV3NhNTlQSW90SEtYandP?=
 =?utf-8?B?RFBRSVQzdFQvbUdxV0l0aDRZWVg0S3pCTmxHQ0dFQ0tJd2l5NloyZDBJcGlw?=
 =?utf-8?B?TkdIR0NGRDVUWk5kakI1VUtJT2xBUEZoMmk3VHhlT1hCcDcyb0lMaWJaekEw?=
 =?utf-8?B?bG9acXBLeWpobDZRd055Sjd0dEhLcXF0VWd3cTVVR015c3RyRU03WUUvSUJX?=
 =?utf-8?B?d2FEb3YzR010dHdiaExBWEVRQWtRMTl3SXp6T1RFSWVZWUR0aTF0MUNiVlYr?=
 =?utf-8?B?UmRQUktVVmtsQ1U5S3ZWZk9MUjJWS1pXWkVSdURLS3NlZTJJZ0JseTFERCtj?=
 =?utf-8?B?WUZuKzI0anNoTzk5S0c5ZHZFUXVlMU02YzFEM3B3b09hdnNKT3Y0Tm9WNDQ1?=
 =?utf-8?B?TEhhQTczWSt1YndJTU1DWnIrR1gvcGpVNVVNQlpKTitHUzNrL3E4RGRKOHdk?=
 =?utf-8?B?OEpRSWdlUUNiRTNqYmF2RUNBdCt3ZUNWcW8xS3BOZGhsV0I0QXg1NGRPV3VF?=
 =?utf-8?B?TVB1OUdYOUhqYysyYWdXMDVaZXBXV1p0TmFzYjJhSnhLYTh3a25vNWFlRHJL?=
 =?utf-8?Q?AYdVBsdSHYEoVJWyZKFqmfQRLU5VhiCco7WCJoa9xB+or?=
X-MS-Exchange-AntiSpam-MessageData-1: NtBGQV2pMqLPEA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec67916-77ec-4355-849c-08ded0e9faaa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:40:48.6319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhZyeiFF9O7HGlHUfTXFujpJYwW9X4jmm1HMRDezTEc+U3WhstoNFETkx6SeRYI0FePc2PFXUVGhX/ASnbTjuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A
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

On Tue Jun 23, 2026 at 12:04 AM JST, Alexandre Courbot wrote:
> On Mon Jun 22, 2026 at 4:57 PM JST, Eliot Courtney wrote:
>> On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
>>> The next patch aims at replacing the cumbersome `BootUnloadGuard` with =
a
>>> more local and less intrusive mechanism to run the GSP unload sequence
>>> upon GSP boot failure. Doing so requires running the boot code in a
>>> local closure, which changes its indentation and would make other
>>> changes difficult to track in the diff. Thus, this preparatory patch
>>> moves said boot code into a local closure that is run upon construction=
,
>>> so the next patch does not need to re-indent code that changes.
>>>
>>> This is a mechanical preparatory patch to make the next patch easier to
>>> read. No functional change intended.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>
>> I agree with removing BootUnloadGuard, but I think it's not great to do
>> a bunch of lifting into closures then manually handling the result. It's
>> error prone imo (we already had several bugs relating to this kind of
>> thing). Instead, what about just using ScopeGuard directly? This lets us
>> avoid lifting into closures (which is a bit noisy) and avoids manual
>> result handling for failures (which is a bit error prone). With the
>> `GspBootContext` it's fairly easy to do now:
>>
>> ```
>> let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unload_bu=
ndle| {
>>     let _ =3D gsp.unload(ctx, unload_bundle);
>> });
>> ```
>
> Yes, initially I wanted to use `ScopeGuard` but ran into issues when
> trying to make the references mutable. However it looks like you have
> been able to overcome these issues, thanks for taking the time to craft
> a patch!
>
>>
>> I confirmed that it's also compatible with the v2 of this series that
>> has the mutable Fsp - you can stash the context inside the ScopeGuard
>> data (then making a &mut reference to the stashed context for brevity)
>> or have a separate unload context type that doesn't use FSP or something
>> (could later be type parametrized along with Gsp, for example).
>>
>> For example here is a rough diff on top of this patch series (you can
>> change the Result<Option<UnloadBundle>> returns to like
>> Result<Result<UnloadBundle>> if you want to centralise teh error
>> handling of a failed unloadbundle although currently it can only fail in
>> one location):
>
> Yes, looking at it it looks like a cleaner approach than using closures.
>
> The only thing that I saw as a regression is that now each HAL needs to
> call `Gsp::unload` itself in its own `ScopeGuard`. I don't think that's
> the HAL's work - `Gsp::boot` should be the centralized point where this
> happens.
>
> But we can make both work if `unload_bundle` is passed as an output
> argument to `GspHal::boot` instead of being returned:
>
>     let mut guard =3D ScopeGuard::new_with_data((ctx, None), ...);
>     let (ctx, unload_bundle) =3D &mut *guard;
>
>     // `unload_bundle` is a mutable reference to the
>     // `Option<UnloadBundle>` in `guard`.
>     hal.boot(&self, ctx, unload_bundle, &fb_layout, &wpr_meta)?;
>
> The boot method can fill `unload_bundle` early, and if it returns an
> error then the `ScopeGuard` will be able to use it. Also, and that's
> nice, the HALs don't need to use `ScopeGuard`. But output arguments
> aren't really something we expect to see in Rust.
>
> Another alternative would be to separate the unload bundle construction
> from `GspHal::boot`:
>
>     let unload_bundle =3D hal.build_unload_bundle(ctx, ...);
>     let guard =3D ScopeGuard::new_with_data((ctx, unload_bundle), ...);
>
>     hal.boot(...)?;
>
> It removes the "1 boot -> 1 unload bundle" symmetry, but on the other
> hand it also splits concerns more clearly. And it removes the awkward
> return type of `GspHal::boot`, which come to think of it was another
> smell that things were not in the right place.
>
> The main drawback I see is that we now need to build `Vbios` twice for
> TU102, since it is needed both for the unload bundle and for booting.
> But the solution is the same as what the v2 of this series does to
> `Fsp`: the BIOS is a GPU-wide subdevice that is likely to be used
> elsewhere, not something to be confined in a GSP HAL. So I say, let's
> extract it and make it also part of `GspBootContext`.
>
> How does that sound?

I think that currently it's confusing because we have two concepts in
use with very similar names. We have "unloadbundle" meaning what we need
to run to unload the driver, and we have "unload_guard" which is for
running unwind stuff if we error. And for the most part these things are
the same, but they might not be (e.g. in my other series where we need
to keep certain DMA allocations alive just for the error path, but not
for an unload later, or when we are partially loaded). So it might be
nice to make these two things more separate.

I think that trying to build the unload bundle separately
(`build_unload_bundle`) is confusing because e.g. hal.boot() still needs
to handle unwinding its state in case of error, so it adds a strong
assumption that unloading in success is the same as unwinding in error.

If we switch to a model where the caller owns Gsp::unload, we need to
support prolonging some state until gsp.unload() finishes, e.g. in my
blackwell fixes series, we need to prolong DMA allocation in the error
case for `FmcBootArgs`. It's doable to prolong the DMA allocation
because the callee currently owns running the Gsp::unload. But we would
need to do some gymnastics if the caller owns running Gsp::unload and I
can't figure out a nice way to do this. In general, if we have partially
initialized hardware, it seems likely to me we will have to handle
keeping a certain set of resources alive until we can guarantee they are
not accessed anymore (gsp inactive being a clear marker).

Separately, I think it would be good to explicitly define the semantics
of what the state should be in after each one of these calls in
Gsp::boot. For example:

"Callees that fail should call gsp.unload(ctx, unwind_bundle) to unload
if it's required. If it succeeds, return an unload bundle."

For state that should be unwound *before* Gsp::unload, I think the HAL
methods should handle it internally (regardless of what we decide for
caller vs callee ownership of running gsp.unload). But we do have to
deal with unwind that needs to happen after gsp shutdown unfortunately.
It might be nice to make this more explicit.

So it kinda sucks to have to repeat Gsp::unload in HALs, but also I
think that whether Gsp::unload is required depends on how far we have
initialized, so HALs may not want to actually call it. So IMO it makes
some sense there too to have them decide. (e.g. if we only loaded Vbios
so far).

So concretely, IMO:
1. Keep gsp.unload() the responsibility of the callees, because they may
   need to prolong state until after gsp.unload, and, maybe we are not
   initialized enough to want to call gsp.unload yet and callees know
   this best.
2. Through naming, explicitly differentiate between unload and unwind.

WDYT?
