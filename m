Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC03C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAE310E323;
	Mon, 31 Aug 2026 17:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="IGS6sDdu";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BB410E323;
 Mon, 31 Aug 2026 17:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS1pWB9iZn9VaRK7eE34+vaBJwq5WOJicTdBel+xcdftjQXMikwTFyXg015SHrV4BecdEWrx7WSa+0tcsYpo7KPzlbKc1OKhi1+9FjMet9nmVE6OYWgjqjPPj0IWjF74xWdNVCCOcMof+yh+pZTqbPF6+UnsvQTZhtKNboZeDIakNH1niYx2cZr6i4epKc1la49w4fIjxaaK2uDvNzMxziFLqT2X5Nv5xImYqFizcJjUqFohAt4xxbqYWa0wpYKXhypT8pmnSliVwutKaLH37H6n4oN8Ah3MfMrQj9kUpUlUt0reX2m7RAx8vt+KOh6jOgWpaMCyhpPx3df7bsG2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKo7jitwcDUuYbyG1EceDSz1K36FdaWCgACR2ncRedY=;
 b=BBvt9ky9lMECjYSgYpMALQx0H/7onPrM8CINGLkKY5rMQrQ/X54ab6qJXuuMqMqVgrXakDsuXF0W6MlRe4lfwWCXbIyrxFFHyyUCdzorSjVAF7n85vlP/PEYxr+aAU3cED++4AMXW5fLuF9TJ88Oz6zK288vKTMhvjktU/3RuBdMTWzz9H9gpa2fx7LVQW7IPFWe5szEoRrwCZIcMKIUpauR9ZjDzA2Lq1K0PwtnRVkYyKB80bVRw5nwbZy/rMtHTWssDxb8FzizXV2+rw4mwUllIqiqxmP0NXHI5RyZfm0570rBmMvXaWS5kpO8/f6y2kT438fxir9tm5h+Zrvnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKo7jitwcDUuYbyG1EceDSz1K36FdaWCgACR2ncRedY=;
 b=IGS6sDduxuYEzWDIKJgv8BEp5pC5vhR67BinM1DDSi37+OE+KRWDLxfuEXF3zORqfy0ozYN1qMH8HuFs7lGaqwJQcswG3xuz6sQycFCVXLgww1s4hAa0SJs6sG+0ef6irhKH0IF3VaaOjsprDTO+0wI7KoDezXbxSoqFe33N7YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2481.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 17:25:03 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 17:25:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 18:25:02 +0100
Message-Id: <DL3AYW5D121E.29D3XI699XMKN@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Gary Guo" <gary@garyguo.net>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
X-Mailer: aerc 0.22.0
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
 <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
 <DKX6R86RZJIW.2HMS6X0NUP15T@nvidia.com>
 <DKX6VRIHFF71.1KWPD0ZQM2RAB@garyguo.net>
 <DKX70RBRWHC2.3KXXJYL22T8K@nvidia.com>
 <DKX7400TO0RK.1R05PZKS9Q33F@garyguo.net>
 <DKXLSOCZBYYX.1OE2DF4LYRMV5@nvidia.com>
In-Reply-To: <DKXLSOCZBYYX.1OE2DF4LYRMV5@nvidia.com>
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2481:EE_
X-MS-Office365-Filtering-Correlation-Id: a092d639-4243-4429-865b-08df0784cabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|7416014|376014|22082099003|18002099003|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: Asm2ahvwIFGwGz9FxaeKVtMbBPdOQISXeRVG92VlJG8ZTQsqe4xQ24sg99H+CjxKtUITvsCRDmm+s2KY56X1NdR00D4L47rzNrzKvL82/XgrloqnpDzSPx8dwbvSt8BlUzARcHt6CRrwl0JaGAij6zJR0HNKQ1xyzJTFKrsCXHVn42Y7ClmThaxbd4sJYZ5q2/fN1G9rRRwd0uqXrkjVt1TGdkLEl4IJggRDIv2X6wLcD8fNPEEAFsG+YT5zd/r52kZ4HqWjbzeNf8Z/rTXp0MAd1vf4ffhFDHPLZfidOYy2Q2LW/4Gecwb9H+WjQ6Bf6KQONMDEebt94eO4+vPv+Aupe6lSnEGN1ukw3qa7Td4G84GT33kvgpy4Jlm3WAzJD/Wtu3qyNxUymvt7nH1REnSNf4ebVDmon+w6c/LiTY4/eARlPJA9XzDEZdz1giScGsnKHINNaq8glEWZD4BNtc9lNqcxBxl2kokY5XZNo54th7h7kA+HESWwU+cUCltTedf3FJqGT95hNIFeLmJCAn/9I5/cRIE15MbtJMo93JCf3JajmvbXJRvSNZpBdXWO8q0h0OPBdd/u/1CXxBcwngkkHuuePGaePT0aT5k8ii/7e2zoqcYeYOqHf3zQEEu0fwLmq5pANIqW4itnyY8wOPgBskjjZySjbgeN3g7pdik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snp4SCtDYlRIVUM2bzRKczluaVZlK3pjMWRaTnFkb3hEL2FRNUVMTlFUZkVr?=
 =?utf-8?B?dmxpMmRENXc0UWZ4Qi9QdTlzOURObHZJUGFBcnIvb1pacVZUSkU3T2VjTDBN?=
 =?utf-8?B?ZzQ0R083SThFUHI4cmtqamhzTmxUSXZrY3d6NGVZMW1odmtvS3p1SXlKVE81?=
 =?utf-8?B?cWsrWGkvMS9hYlp6blpYMGt0aW00QmpjM0h6KzRYNzFsTlpxN3A5T0VqQThM?=
 =?utf-8?B?U3M0aG01QndXZmVpbTJjMmN4SEw2bmtLSWRPVytkaVZFV1VBdHB2cXpjVEE5?=
 =?utf-8?B?V2ZSZ1FldGFIVDQrQkl1VVFPbDVPVUtUZ2ZmK1RvZ052WC9qMW9ZLy92SmZO?=
 =?utf-8?B?MVZ2enVCZktHQ0F4SndJbmNTVzE2SEhIbzl0OUNPUnhHaWNMVnRuV003bzhl?=
 =?utf-8?B?UkFYKzdpWDQrcnBuZVlYVFdJc3RSQzQyOUxLNFlOeEhYNjRMTWRZTmRFVytG?=
 =?utf-8?B?UllBL0I1aHNHWkxVLzFXVjFTZVpnc3Ryb0kwZVN1Y2NBeE5KRERka1dsa0VX?=
 =?utf-8?B?YXFTV1ZRWFNwMko4Y0ozbFZYK05TNUwwbEdYR0FLcFlNVmxiaHJTTmdJZWhq?=
 =?utf-8?B?NHVyOTVPS0xXcm1BRk9EbytoY1BDcmtzVEZwQUVCQ29MeGQ4SnphWTV4U2p2?=
 =?utf-8?B?V05PRDRXTVh6SzdzL3UvcE05M1A4b1o4bGFXa0FxUDFZVEI3bFFlUWg2NjNv?=
 =?utf-8?B?Z25XWTRacy93MjR0NEd6VTgrYWIvWmF6SDZkbEpqV05qRm1QdmU4ODRJZjhq?=
 =?utf-8?B?QnBSMklSK0hmZnkxeVBHVTZjR1JXOEsxb2xEbnQxcnJtQzNZb05vWmI2NGtn?=
 =?utf-8?B?ZDdzby9kMDJTM00zbGRaSnFwZ3lXMVNoM2RWSVUrcU9VOUJ2aUNGclZ5V3Fy?=
 =?utf-8?B?cU5ha1AzRXZKdFJudjBjQXIxTXpvTkVoMEh5eEM4Y1dZcUFwZmEzQjlrMGhW?=
 =?utf-8?B?WUpzU0hYZHpDeWlFRWJjOVJDbWVoSjJQTGNreEViWis2UkpkSXJ3dXhEc2RU?=
 =?utf-8?B?akVDS0ZHVDVBTkllcHFaTXBJMkdaVDJvYjVSZmQ3cytvVFUvNmNWcCt0a0RF?=
 =?utf-8?B?RFNmWVVEcTlIanVzM250QWg5RGZaTXhkSFkxcGtrbVZuVHUvMThqK1A3aFRZ?=
 =?utf-8?B?WkozRjdaV0xVMXVsSFJzTFRrNzV0U1RBYnhKUFR4RWNOQUdHN3JUZ3F2ZjJn?=
 =?utf-8?B?bzcyeUFKaTg0eElLRU5BdkI2blFQU0xYSDhScmhUYUZkZkVnaUlicTdteHFC?=
 =?utf-8?B?Z2hHcC9TendYV3JyOUFma2x3MGliSmRPeXFhU1JwTElPS0VRSVA2OTdUWnlz?=
 =?utf-8?B?UGZzMDNVNVg2d0pHRXFXdlNWZHB0TU1RdmN4NFVlTHp4Q2cyb0twWThHb2dq?=
 =?utf-8?B?NXhqS1g5V0Y1UjU2Uno1L1ZtenYrbE95VG5UaWZNS09GNFdSZDl3aTRrUkRy?=
 =?utf-8?B?dHpGR1Q0VGV3MGdhVll1WGIxamMvbGlnSENmaVdJZWNvS0lFNVdWeWxGN2FB?=
 =?utf-8?B?L1hFMkthMFdLVVNSU3o0VHBhN2lOSmR2aTRsUk54MkNIWWdsV2tnMXZqelVn?=
 =?utf-8?B?eVFoQ3NaV1lNZ1hreUp6N1pFOWVzcGh1MGE5Z2VFeGVnd21jYmdadjhmcHBn?=
 =?utf-8?B?a3ZFV0RkTTc1OVB6b05MYUUxVEJmUHo5SFRyVDQ1c1JjY0JxTmtCWmttVk5j?=
 =?utf-8?B?UDNMT0Zzb0plTlhRVjQ3OTRCQ1R4V3A1UUtyN2R6dlFGSSs5TVpmWVplMWc2?=
 =?utf-8?B?YUZVdWw3c1hmRklyMzdEV0E2cGkrckJ6UzJyRXRQR29rNC9OSWpsalB5ODJ5?=
 =?utf-8?B?aE85SnU5emg1bEJMeDdTVENDMzlNT0NtYm16SVpqWEpqaDBRaTMxVk84SjBm?=
 =?utf-8?B?QlRhZitMVFg5Wmx2MkpEU0dNMGlvMDEvNG9xS2FqcUdiNHkzUVUrL04xWXE2?=
 =?utf-8?B?UWJmYXJrczZEN0tIcjdHdmhSTUFUZzh6dVNUdDFvWHVxbVVvbHllTHVsb1di?=
 =?utf-8?B?ZG9PRFh0R0ZWZlNwRVlzWXY0YTArM3FDNHVCaVdDMFBsMWNtMldJdjROcmxD?=
 =?utf-8?B?dnZyT0FLeFZ6a2k4STZ4NmJHYWlBcC8xem1GYk1Vc0lKSWZYUEF1VDlyWWxz?=
 =?utf-8?B?R3ZLWm5qVzNZQW1pL1VqQkNKWENaWXNFU1A0QlFPVGpnN1lyai8rMmJUYzZs?=
 =?utf-8?B?MFVJeEs5dUcveGZIU2FJeTVlRWFCWjdSRVBmSnM5dDB4b1FkeHhmMWxVWmlV?=
 =?utf-8?B?Wlc2RmFNSktYdFErMVovcE8zYmlaelVPZjFwOXlMbWxlY2wrMUV6b3BVc1ky?=
 =?utf-8?B?NXlsYlpsbng3a1ZRbzc4UEJlbmtFN21YQmxkdFg5NmJEMHRFTU45dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a092d639-4243-4429-865b-08df0784cabd
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 17:25:02.9447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx12oUHSWgR+WDaMz/k9lZELtfwSfaZas67+fIaY4C3Uq7ZFD22Gj0AbViJiVcPLjL7uDkHurd+nsK+m/WjUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2481
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

On Tue Aug 25, 2026 at 1:38 AM BST, Eliot Courtney wrote:
> On Mon Aug 24, 2026 at 10:07 PM JST, Gary Guo wrote:
>> On Mon Aug 24, 2026 at 2:03 PM BST, Eliot Courtney wrote:
>>> On Mon Aug 24, 2026 at 9:56 PM JST, Gary Guo wrote:
>>>>>> @@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<'=
_>, command: M) -> Result
>>>>>>              dst.header.length(),
>>>>>>          );
>>>>>> =20
>>>>>> +        // ORDERING: STORE->STORE ordering needed to order `cpu_wri=
te_ptr` write after data write.
>>>>>> +        dma_mb(Write);
>>>>>> +
>>>>>
>>>>> Is there a reason this can't go into `advance_cpu_write_ptr`?
>>>>
>>>> I think it's more clear to consider `advance_cpu_write_ptr` to just be=
 the
>>>> pointer increment, and the ordering should be visible in code that per=
forms both
>>>> memory ops.
>>>
>>> In the second patch, it looks like you're adding the memory barrier
>>> directly in `advance_cpu_read_ptr`. So we'd have one barrier directly i=
n
>>> the code advancing the pointer and one not, which seems asymmetric. I
>>> think it's less error prone to put the barrier in the function so it
>>> can't be misused (and we already have evidence the barriers are easy to
>>> get wrong, since this code was already broken).
>>
>> In the second one `message.header.length()` is read, so if I move the ba=
rrier to
>> before the advance it'll be incorrect.
>>
>> Best,
>> Gary
>
> Yerp I mean move the barrier into `advance_cpu_write_ptr` not move the
> barrier out of `advance_cpu_read_ptr` - I agree that'd be incorrect. On
> clearness, it feels very odd to me to have these two functions
> (advance_cpu_read_ptr, advance_cpu_write_ptr) where one controls the
> memory barrier and one doesn't, purely based off the structure of the
> callers. And I still think it's less error prone (for future changes) to
> do it this way too.

Frankly I don't like the asymmetry that the advancing code does the barrier=
,
while the pointer reading code doesn't have the barrier. However, if we mov=
e the
barrier to the pointer read function, then the `driver_write_area_size` wou=
ld
gain a unnecessary barrier. (Actually, `driver_read_area` code have a simil=
ar
issue, a failed pool would execute an unnecessary barrier).

As an alternative to move the barrier into the advancing code, alternativel=
y we
can pull the `message.header.length()` to a separate line instead.

I think we should either always have barrier inside the pointer read/update
code, or always on the user side. Given the former would mean unnecessary
barriers, I am erring on the latter.

Best,
Gary
