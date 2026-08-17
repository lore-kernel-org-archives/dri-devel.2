Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EAEC5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DD310E3BC;
	Mon, 17 Aug 2026 12:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i5ClTi/t";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F56410E3BC;
 Mon, 17 Aug 2026 12:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cio8FWPihkWS/jJVVNvC9MMw9kI4bE0pMjlTUMbx/B/o9+ig0AovbuyggR9qQsuFMu0MvONk2Gd6kx0ZzFQzBiWfnxs3bQWOZcvK+6nfFtRwZQFbQuJcQw1HCQUHlkDWyCSSExN39ExWGZoCaUhEV4dgiJ5tDx5qZ3vQcdxVd2S9RqYKo4+AI0MTS4UNOVElpV2j4RKNZxFRzan93M3cREY9KGC0VpfGAxEy8+9Knpyr2k804/LnOR9TvoajSWsJBAdUOTztDZ3JFhY5JxEXXQ2m3YCmNB17Am0+y9FDo7tIkF6SMmupXkqoJ8gUvGmZB9jktChSq/9ofLkAIcLzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/Q4uk1h2CgpK14SljQ/E+fCGjmd2Y2q2ztjLHMl7mw=;
 b=C+t/MogZAAgtJCkseVrHiBsp4mzUHTI71j93NjUKsS3UTpkA4DZbpjgXNLIV8/hpp/Z4p225q6dYn0GvUieqy1NfKFetoro3PyW2mvFuqw08A+waMTP7zHCFRi5EN+1NnhuERSyT65kuhzxiJAFNHizn3rAfLwTAYNWv7F/GJ3qweJzTvZta4soPb24qY3SnfWnECQZWuWskS8+ry8De5jkzFyIXpu0V8UkzkP1jHbhYBQS6bOtq/TVG+BX/FQOtyOsRFUyqcfglvW7Do86Fz2SzQJYz/AZhZQac5ha+UU5FxGgPTSqnGEmYhweEKIs10vbkf+YMpSId3931MZfkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/Q4uk1h2CgpK14SljQ/E+fCGjmd2Y2q2ztjLHMl7mw=;
 b=i5ClTi/t9b1WvJPzsflBsgtpwmBvTz9pYCfVJ0zfbRpLYHaW/KJSYEw9uASYAYRNjZ7zlxLB9mFpp2FtdpEI71dfGXA44RgjHUFc1QarpzKi6xEYOXhN7CzH7G+s04D9YyQb6z0nl1BdC+fan0PqhI+zx8RE1++aYRyaMIwpBr2Q8ZPywTZ6QDSJ+89H4dK81cY7j0zFXvsHfBlf7Q1mlTXHjfI+fv987L5E153nQEvkO3hRsAHFdrVNyl1r7P3VnQqtns11E1uoMmJNSjgOZezeY/vM2E5Sc03bir5KJQRcUXLhSewMwcvx4X2AsRKiqvQFUnVzMMj9UU93CFLVxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:37:28 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:37:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 21:37:24 +0900
Message-Id: <DKR831I268F0.38IYGHOPEZ9PR@nvidia.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "Yury Norov" <ynorov@nvidia.com>, "Alice
 Ryhl" <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
In-Reply-To: <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
X-ClientProxiedBy: TY4P286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea5313d-a142-4a02-a794-08defc5c4c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4KVSItoW2o90bXJGQCsuoYEED/ZDQ4atBBC+EX+wrf/mpKuh89qVX0WFC9xRbThTINj7K46NZfZZOz6NRWcvX4yEm9+w9xbausRuot973kqlB6gv08VOuvytc3blkq9LVj4wvAcXfsQ8IO3XQRmnBP2fq9Ty9Tas900uRiYeX8CMPMlCjzbtXYXFDqT0NRcaTcd2MtRRX1P5M6vLx2ALRjXISkXRlqOTuxRilYKpg1lsm5N5X7CoRX9aEZPhhct9LH04vFbBvCsVl4v9WFjyUD0M1D51mqqSOQwRxqRfslpyRo0bLlmWyXTSURhCXIQ7hLUNkcPh3l+wXXqT8WN/jyRqtBYL5cSk2gi0aQzCMlHMcorWib6QHBKRx7mfLC21dP4TWXJiDiM80kSFrFg2fgbE0wAGTqJ9FV1iMAJQ4Jw7mhlHdmQgwWoXy5Pn078LEaEN8+djIsNK1BALLDYEeW8RuOIbDfK0usHGNlSHgNXZY7seBCamtJ9y1zy7N2CRMVB0mMTzYPpp1o2Mp3t/AU78l4MouOsVnXcmN4OmD1X8V/kMr0WLFkjvYjCMvk/vlhJbIK/SQeCv+ZMKyS/qgZ9vRJSEvLWnn46yZTuk39sJryQNmcwNIH2W5drIEdTaCmGSNPpAaplqGPvD7Y6bAdTIIdYI0fjIOjDAoR2GC+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFpTnFHKzIyNzZYdVhzMEQxbXNpa0lsOG9YaEJCci83ZUMxS1JadnA4WE9I?=
 =?utf-8?B?U1Njb0orQm5QUWFEU1FJYUFpd2d5S0JGd0VtR2thY3ZHNW5iOVlMbHcxNDVx?=
 =?utf-8?B?SkdzbWU5U2hwb2R6TzNSWUpvcmExQ3F2YUxtSC93Rm5DWHplaGh2RTZaTjNw?=
 =?utf-8?B?TEtQTHBhVWNQL1JINldtZlRsNmp1TytncG03YjFYODBPODRtaFM2TExXY1BO?=
 =?utf-8?B?b2FjUXY1NVlLZXE5RkIxNk41ZXp1bzRaQlhvSGFIenA5TTBhWElMTDlUMjZK?=
 =?utf-8?B?aTJOblNZK3hTSkJoekNvS0tlMXhXNGozSEMwa3JMV3JBOVBLak9Uc2ZHWnpv?=
 =?utf-8?B?NzVYYmU4QW9kOTF1OVlVSE8reHUzU25JTVhuV2FiOFRXdWl3d2Q0WHpzVDZM?=
 =?utf-8?B?OHNnUHk2YU45Q0NReUdHb0s0R3lOcWorTkZyWXpwSU9GS0RDbklTWmJLLzZ4?=
 =?utf-8?B?cWNReHdmVVdUMWFZSks2MHVCOENPb1ZLWEY4MkpxZUtMcitxRm9KTUR0S1hI?=
 =?utf-8?B?c3h2aExIeUVIVno3U1RYenl0dmJFa0FEN2dJa1AxQVk0bnd6T3dnZklxRHp6?=
 =?utf-8?B?R0FSc0dJRWxra1pzczZib0RiMy9aVmYwVGtYZWtWemVrSnRDQSsrQnZOTVFq?=
 =?utf-8?B?WXF4VzYwclltcTlnNjBmeWorRGN4dHppc3lTYUhpQzBQZzB1VUVZZXZ5WUwy?=
 =?utf-8?B?NlRqWFBsT3E1NFROUHNmQW5PUFYvVk1VTWdIbVpZa0FQWitFK1hIODVhQ3g4?=
 =?utf-8?B?bEQ0OFB2Qyswa3lkdGFkVWhXZVdFc1YvR0l5YWFmNkxMWE9mYVF2aDFNR3o4?=
 =?utf-8?B?YWE2Wk9tbWRGOUd1cStuem1WVndRbDJMYTN0NWJmelBsTWdaa01UV0lmdmpr?=
 =?utf-8?B?d1AxeEdWbG91dWFMSDFITE1zOWZleU1lSThReStVRU5uRWVPWU5YSjBoOGh0?=
 =?utf-8?B?WWp0K3JaYmhScmkyNWdINEMxVDZkT0tmcFBrdWVPMGlkNjJPdXZDY0QydGZs?=
 =?utf-8?B?QlR6UzVkWFI4bmZodEI3ZjRJNTNVbDZrU1A1WS9ZQ1FDN0U3anNpaDFPY3k4?=
 =?utf-8?B?Y0lXbndSSFJQRTFaU1FlSTJNWStXQlpwS3g2a1pUMy8zUUd0Q2dITFhnUnYz?=
 =?utf-8?B?Tm5RMGdzM1JTeThlckpEVHhTZ1lSc1FMNkJabFdQTnJWNUh6NHREWDVBS2hV?=
 =?utf-8?B?ZVVuaDZUK29DbWxXbzlTbkpqbmJVeWZZUSs5SUZGRnA3cXk5L2tKRVJPMHlM?=
 =?utf-8?B?ajZIa05YUml0WC9XVlVXNEVVa3cyVENRZDQyazRVVnpGd3Y3cHRrQXVyY3h2?=
 =?utf-8?B?TWRlbnAwZkw1cEgycDZPWVFvNFZ4eExwTXBKcHN5a0xWcCsrTGJqeDRNRWtn?=
 =?utf-8?B?bFBSWmgzc0dWSGdQeXI0OXhtcldTS3c4SlZtTlcvS1M0ZFFBT0lvSHU5bHdp?=
 =?utf-8?B?cnVkK253ZG5QRHZ1OTM4cnV4cDR0b0FqU3pFaldwU1M5MENyaEJCK1EweWp6?=
 =?utf-8?B?ZWNzaklxcGVMQWZxMmJNbXF6UWxYZ2MxaEZaaEFwRnFCTjJ5NW9ncUhiWWU0?=
 =?utf-8?B?UW5jYldNcUpkb0o5d1pHUTljeWUvMVBBYXZHWnIvaGZtS0F2ME5EK29YTkUv?=
 =?utf-8?B?SVl5aXd3YWZ6TDFjZHRGU1RzVG9RUzhWdUMwVTRnSU02ZUJxVEdzWmxWUURz?=
 =?utf-8?B?UTRPK0c1c3RHYVJaZDI2NzZjU2VCOTZPeWZCWTRLdHZGNjVsRE9RNmdLT0lY?=
 =?utf-8?B?M253cnE5TTEyUUFab29GckhDMXQ2SDBGcG5wd2ZaWGVVNkJNWFhzTy80b0hS?=
 =?utf-8?B?WlZVRE9DVm0wcUFWYUJFYW9jQ3lEYzBEaWRneFZ1aXFOOTd1alIxZFBFUnRk?=
 =?utf-8?B?UDViU092b0U3K20yQUNXSXZxaHJtTkFRZElabXc5bjJYdUNEWXNPbmpSYkt4?=
 =?utf-8?B?UXMzSHRtaUlFNVBmdFdnZjlhR3RKSXpBMW1tSDNSSEEwSkhydEZuOGJ2R2J2?=
 =?utf-8?B?aG01eHNOeG0rUnhubVBOekNEMTB4bDlja1FGUzhaS21LRFpVTEJyWXlDL2h3?=
 =?utf-8?B?aVNiR2krekN2eWFlTWZJSWlkdXVDRVJsWEMxKzFmOG5vR080bGs0emZOZ09k?=
 =?utf-8?B?K043N3RHTVpsSTB0aEZoeUExSkx2V21kTnRDQ0FhaWZ3R0Rjb2Qzb0EwTGo3?=
 =?utf-8?B?d2dQTnhuTTJQRVI5SElWUkxiRi8zMkRWRGw0TEQybXBGbzFWWDZkaGhVckpr?=
 =?utf-8?B?UlRwOHQyV05JV3dhNjk1SmJER3ZCVkROdDMxdk43Z2FSNnZ4TVhsRmlWM1Ay?=
 =?utf-8?B?elZFdGtkajd2VVpzK2NkS2ZPVHY2M3hGSXVuL3NtS0NkaVIyVTMxclRsMjRB?=
 =?utf-8?Q?rNwgZabyP0gdzxXIlQoVPFTxx7XwK4MvB/nNcePeNJ4aY?=
X-MS-Exchange-AntiSpam-MessageData-1: 4vE0N7Wk7dlicQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea5313d-a142-4a02-a794-08defc5c4c49
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:37:28.2124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARkRm2xgwRJtSGh43UJdVk+gWpN0pgsaySb0PG6xzkTzb2rZNr1XpXlkoOHKjklJoded79bH9une5CVVSYJzag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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

On Mon Aug 17, 2026 at 9:16 PM JST, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 1:49 PM CEST, Eliot Courtney wrote:
>> On Mon Aug 17, 2026 at 8:18 PM JST, Danilo Krummrich wrote:
>>> On Mon Aug 17, 2026 at 12:54 PM CEST, Gary Guo wrote:
>>>> IMO we can just support zero-sized allocation by always succeeding, si=
milar to
>>>> how ZST allocation is handled in memory allocation.
>>>
>>> Probably, but in contrast to ZST allocations it wouldn't be very useful=
, so we'd
>>> silently succeed on something that never was a reasonable argument in t=
he first
>>> palce.
>>
>> Yeah I agree that supporting a generalised zero sized alloc is in some
>> ways conceptually nicer, but I also can't see any good reason why you
>> would want to do it, it sounds like a bug. That's also why in the latest
>> version I made IdPool also not allow a zero capacity [1] (incidentally
>> required to not have to change the grow code to avoid trying to double a
>> zero capacity thing every time).
>
> (I assume this is more a reply to Gary?)

Yes, and so was the below too kinda. Sorry for the confusion.

>
>> Tbh, I feel that NonZero (and Alignment) is hard to use currently
>> because of these ergonomics issues. But I reckon they're useful, so I
>> like the idea of trying to making them easier to use. Maybe you can make
>> an argument to not use NonZero here, but what about all the other times
>> we will want to use it?
>
> Personally, I don't see the argument for not using NonZero (or Alignment)=
; the
> invariants required by the API are expressed very well by those types.
>
> I also don't see a reason to step back from using those types for this AP=
I. If
> we'd do so it would question all the other new types we have over primiti=
ves
> carrying certain invariants to a certain extend as well.
>
> I understand the ergonomics concern, and I also see that for compile time
> evaluation turbofish syntax is not that popular, but this can be improved=
.
>
> The fundamental value remains that it nicely separates the invariants cal=
lers
> need to uphold about certain arguments from the API itself. It makes the =
code
> more maintainable (e.g. we don't need 10 different variants of a function
> depending on whether the value is a compile time, build time or run time =
value)
> and it makes the code more readable and robust (e.g. the semantic meaning=
 of
> arguments is very obvious and confusing arguments becomes almost impossib=
le).

