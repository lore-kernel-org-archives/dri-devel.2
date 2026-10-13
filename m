Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249F2CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8545210E71F;
	Tue, 13 Oct 2026 05:58:29 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D0910E075
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNk02vLaHc6Jyzr12vdD//DjF9sH0vax4zg7XQptzDd30tSdFtSiAc00aKN4tS1g2oA7Qw4GTqp3IIAbxqgHMtgpCtXga3NSFxyJ3hh3y57hwBhNkmnbHpx4aLYz0MK0n8ixQyE3HVCvR2iGCRjZsLUaH53PbKVY4CmB4IMk0H4mNaN+Z1mXJrRVAHCjajkdSdcOnfkdOWAdeaeyMB6O4UNJ+C5ECacCjxrm4y62zHCTJgefoBSlMDWW9ZHwifSyeWAVVzQxY8o+5dBQbUPck/J7Brws9bS3QfLwgUkB5t4OLCqIwhsJY4R0/l7EolzOBkDAgncRt8GWTuiC96h1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNL28p1esuwnMOxwr0atyPgIGZhhwqu8pdgFCYj9H7M=;
 b=oMjyQYE6sTQZyvbPYIPHBtFYZM/ySm8dkB8Df+uCsw0W5lN85PntcEoVvq/CjiOP08AY/DCunt6FFmvI2DexMuWFvxMqtm8u4CB9i5H+LKX0Ia9OBBCnj59DrpNXLjcUh+F64sveEpx+sMVp0GzFeC8s8/USqK5kOR7TUEWvOe3dLr8q0SVy5HyeK4mnxKaLVVaRelsTyuPMvY7YZoEinTFlMwnNcnNqH7zsGir9U4zRRz5kH5qfKy2pBqHLWZiFAjG2qgcwNoS/G5hjIa85m4SAQiLYlwFWcEmRfjlAf0vnJ0geNkllEQoPFN3cvgg1FKGL8gI5hMFNT9FhwBA9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNL28p1esuwnMOxwr0atyPgIGZhhwqu8pdgFCYj9H7M=;
 b=DgGDXumwqXm9XOeCBkR5MO3yldf4azk/Q74UHe7/+zmQ/PjlOok0A9SO4E/JHDlUWK+O040bTk1T8QTPf4doIeADrkbtQNeNywiW0OV5jFbhR0tGxOXPJ+PrmCv9YdCwj1wTyouHe1aNAjW2PWmOk+nd39HTaZl+sK9himiFwJef8Z/gnKJ9foUn9Smr+mpyq4KKplIv3ClPRBsLn1mGOnHVtERvLDxWKBLxcbnnH1Fu1Wh77diVUVkbME9i7CPQCWwPW1bQyVB763EGzbuWrRmlS9vR0H04neGivnsXOxkAxgjyJ0JYpX054C+c7JCQVmSbAzeEY/Hzsc8YCIZL0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 05:58:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:58:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 0/2] rust: introduce cv! macro for safe const
 conversions of integer-like types
Date: Tue, 13 Oct 2026 14:58:05 +0900
Message-Id: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOTU7DMBAF4KtUXmPkGf/EZsU9EAt7PKFGagNJG
 oGq3B3HRSKoyye9781cxcRj4Uk8Ha5i5KVMZTjXYB8Ogo7x/May5JoFKnTKo5e0SJ8NB4s9gSF
 Rix8j9+Wrjby83vJ0Se9M8yZ/GyN/Xur6fKuJFCeWNJxOZa7XIqQOEKIjk5MjhTpkHUn3GQhT0
 joapdCKbf1YpnkYv9vHC7Sx/XMLSCWNj+BV7smQfz4vJZf4WI81v+CfCQqawc0Yl8iFjDHzndF
 7g83oalQflLOBO4B8Z8zOQNeMqcaajnvbYWcs/DPruv4AMhtnv48BAAA=
X-Change-ID: 20260828-cv-8d4e952fc14c
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PAZP264CA0056.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ba9690-b628-4993-fa50-08df28eef9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|23010399003|921020|11063799006|56012099006|261009223027099003|10067099003|18002099003|3023799007|4133799003;
X-Microsoft-Antispam-Message-Info: R9WHiuMbJ7cMTiHEci6ODOo68RCsV6s1XrcgEc/QOQOPtjARATdmoBdy3Y8BGtBKIvD3BUO3lAWO1efYVDJA+KmYhgHnIX8BOLeKcCBoak8MZFpSJL3j+wCYTXN8lZiqYkai2zHeI+VcOur41o2OQFhveR6mCwQ/uW1M1f+YqSOuxvF9yoYWN86VP+0HTxs2ztRacjv02f3EjEzPkQLVCdcT9+AYZxvi/S7QM4/6bUZR3W+2VSCumilNPDhdNPSMguM6CUTn878e+rUzU5bxnt7bPHO6/XfCMozxdmyRUFU9SjdKZuQDnvn/ofqJMNt9aJChJz1D2xTvnkL6qqLXmonQKlHK7p/6Z79eZMfUZO161IgHGiKb0dSksm31/Uxv8ht/7YbHFdSc7ce/sUU8Ttv19RBJYemHWh9pxwl7k6ydC45wfxq1g67MkvYRocJWQobEUgdLklypL9t+Hs4HXe28/U5pCKVqEArPiE5/75Gymb69LnWq3OX3ZFlCWblyt6w+kWnBJRoi6AYmUBI+IDXulPBQiyWVYDzp6CbK9eblcvm99tN8P6ssC64dstHmmKYCIugngjOkQv84JZ13KeJ6UQQvPi7aBxOWyqi4ZHhH5N9Dcm1wR5oMgb2Xv+XDOni0fKi+ry7zEUlJPjcD6EQkWkNmwj8Gswtt4HTiD0cf+w7EwwonzetjhcIXJmLFHEHB/QKt26gqZWq7OMm3Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(23010399003)(921020)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(3023799007)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um9ZL1JoYTh5MVlDMG83VmdXTEdpeFhkUDhObTN1K0N1UFVVcy82RkdEVU5Y?=
 =?utf-8?B?MUJLMks1RzNvMjJ0cjNvRFQ3Y0dqa2hGbDRJTHBkUXdKMW03bkJON1V4ZHBB?=
 =?utf-8?B?Z1lWNXVGblZCcU1PT3p5QnlMVG5DQkVHeXpubFoxZE9ta3dGd2x4M21Gd29q?=
 =?utf-8?B?VkRMMjVUMmlTQTJEUzM1Rk55aysxWjJUZGx6YXo2KzdaNzdJYWJTRm4zOEVl?=
 =?utf-8?B?SG1QRTRqV1hjMlprdEtqRVdlbGJQUTQ5RWZ1aUdYd2xobHZUL2RNeVpxZmFV?=
 =?utf-8?B?RmROcm55aDJMTGp4T214UTVOZUx1WDdUSlg1MTFqMVNQUE00cFVLa2pZNENt?=
 =?utf-8?B?YUhvcnorTHZQcUV0TzEvTlAxSjRWL1hxQnlEZzMveFR4cTZhQk13V3R0K2xJ?=
 =?utf-8?B?VHQ3dlBZN1pVWWtRbkx1OFhsR3ltbmNUZFpEMmZnWmx3ZHNWcGtCRTUyVElv?=
 =?utf-8?B?TVpwcHU0bVMxZDNEZGJHZjhNMjJFd1BMTnBDMlVHRWU4YzhEelJ6ZFZ6MVFN?=
 =?utf-8?B?dTkxdzlkQ2lHQUg3bldIN0c4cWZSbmQxY3JuMGxIYjYwcm5ZTW1pd2dmcEI1?=
 =?utf-8?B?NmgwT0dSVkF2T29WdnN1NDJPU2tWcnc1ZkxiaHVqYVpoUUNaUFgxdzZVYStG?=
 =?utf-8?B?c09SV3J4UThodHpKSHBmcFlCczJ0eGo3SC9uU0piSVV4T3V6aWo4SDFkRFNK?=
 =?utf-8?B?TVc0enlGd0JhU3NBT1NyMWsvYk1Ra09LMytRdHRFcE9HajFheXVsK3VQQVBF?=
 =?utf-8?B?MkVZL1p5azJ1NjV4YWR3djRZajFtaDJDaVZHeTMxWmJRYVd5NWltOG0zeGkr?=
 =?utf-8?B?akZURkRLRi9FTk03VFZBQlRYb0ZDdTU0T2FBVU1MUC9RMm5JdVVCTGVzM2dU?=
 =?utf-8?B?endqS3hlNjF3SFl6Rmtsa3lNY1hXcFVzTGhrNEY3YzFhZUJzdlVrU1o1b1Vy?=
 =?utf-8?B?SVBpY0ZtYTBTdUJvU1NlM0RXZkhYWEd6WTRyNnFSYWVncG9QM1lKYkNPbU55?=
 =?utf-8?B?NFlzcmZEdzkwYWtIT3IvZGJlWHJERXZxdWJkQTBHem5CZFRVeDM0UWZ3N1Vv?=
 =?utf-8?B?YUZsZ0pGOWQvQWxPaHBFeHRtWVV1eU9pU01xdGdMMlVnL0FsS2hvZ0UxUlVl?=
 =?utf-8?B?WFA1ZWFIclhiL2lTYnIrZkx4VVdIWXowbmdTNWtMMkxLNU9vUGJvcHFBTE9W?=
 =?utf-8?B?N3h1bTd1bDB1VXhRa09RRDAzbCtTZVNRRG1UNlBlaEhjNEh6Ylh0QTNWSGJF?=
 =?utf-8?B?OXIvT2NNQW00SFIzRlpoeDJlT3FBbVdUNzRYdDFyd2NFVCthY1RCTGJCdUt5?=
 =?utf-8?B?L1dENzc0MEFNNVN3UHZON1ZTZWxENytUNFVOUmI2SjJjbDRSR1cwVWtxSjZp?=
 =?utf-8?B?dEt4QzdoUG4wUlhHZnJmbHVqbnUvOUFqQWNXKzJHVmxGRE45WHdjcVJSWk9s?=
 =?utf-8?B?cDJ3U0hCdlJPU0lkUzI0cWxpdFFuaGROU2dlSlBGWGV1SStYYy9CeEk3UXQ2?=
 =?utf-8?B?MHkrdERzUyttWWJDRnZhVTFhMnJhK2I1R1cwcmFFVld1OXlQNEhkLzcxMnhu?=
 =?utf-8?B?RWZHWFd6c2pwY0NvcmdwemQzRUIyYWt5a1BacWE2dVhNR2R3R0VobFFhd2Y4?=
 =?utf-8?B?VHN4SGNkM2l1RlVKTVRTanNQSUN3dHRBR1BKMjA4T0xYREJ4VkpsNXpnaG1K?=
 =?utf-8?B?NGZNVnBHN3gzQnZnNjYyQm1MbExONVkvZDZ5YVBuamlGTjJDUkdGUEhWZWMr?=
 =?utf-8?B?aEVlYXNJWmN6UWw2czF6WWxDazR4MUhQUnBhY0tkeWR4bzg4TXF1MW1HeXpL?=
 =?utf-8?B?UVlOUy9uWXN5bjU5ZWpLNGdxMUJvN2d3Z2I3SFYrZmlJS1dVNFNkNWo5RVdj?=
 =?utf-8?B?M1pBZlN1TXlxWHZjUnptRXZYNnp3WGNDUXp4c3drL1BwVjZGZklHMk1WMVlN?=
 =?utf-8?B?VUFVRGw4L1c4cmJSdVZlZGk3a2F6TVhQK1JUVVpBQ0JyeHdPczBVMnB5R2ty?=
 =?utf-8?B?VnU2S3Zxb3MwZVljbUZua3haVStUN1pEaUxzTStkNE5ZUzh5Uk5TNlMraStU?=
 =?utf-8?B?MFRFNDZNZGJqdUphOWgwYjR3WmlLKzhSTUZMNlc0YU95Z1BjejA4aThYQ3hr?=
 =?utf-8?B?VjI4NmpOZk1zd1hPcCtvV2lKYjJXUTZqVjA5azhWS1A5OWpIRk5heUZzd3Q2?=
 =?utf-8?B?akNIWE9pUlZTVjVJNHRTSlNUYnZPQ3RQQzI1YVRVQ3hBYVpacGJoQk1nelRQ?=
 =?utf-8?B?bTJPUmxBZHdpUnJjWVVuVEdTTUJmRjZ3TC9CcEJKOTlzODhjMit4ajBkTGJE?=
 =?utf-8?B?c2pvWXFSVEdFTnRCRTVGbFp1ZDRkZ0pPRktxRjhRUmZveW81WW5wcjFHdUw3?=
 =?utf-8?Q?mCN5qGuDzRV6GRFQpR9xZtxCrHkMw/n14x4WFN/PyMgEr?=
X-MS-Exchange-AntiSpam-MessageData-1: dZDARPT0srMpYw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ba9690-b628-4993-fa50-08df28eef9ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 05:58:17.1487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BS1uco9DeECIYNWRjEG2gAmv57svRGKR8r3dIhAjw2Pi2j+O/WlpGA1OOfwMBbKXNdWtqDlQ1JXDUIxvA7KZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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

This series introduces the cv! ("const value") macro for safe compile
time conversions of integer-like types. The syntax is `cv!(literal or
expression)`, or `cv!(literal or expression => type)` when it needs some
help with type inference. The result is that many expressions can be
rewritten into a compile time safe (no `as`) and less visually busy
style, for example:

```
- const DMA_LEN: u32 = casts::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+ const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);

- .with_const_msg_type::<{ casts::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
+ .with_const_msg_type(cv!(MSG_TYPE_VENDOR_PCI))

- data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
+ data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],

-pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
+pub const NSEC_PER_SEC: i64 = cv!(bindings::NSEC_PER_SEC);

-//! let b = Bounded::<u16, 5>::new::<0x18>();
+//! let b: Bounded<u16, 5> = cv!(0x18);
```

This works by defining a trait `FromConst<const V: i128>` with an
associated constant `VALUE`. Then each implementor sets `VALUE` to a
constant expression. This works around not having const traits. An
alternative idea from Gary defined a FromLiteral::from_literal<V>
function [1]. This version essentially moves the implementation of that
function to the const block of the associated constant (since it has to
be executable at compile time anyway).

This is based on ideas from Gary Guo [1], Alice Ryhl [2], and Alexandre
Courbot [3].

One (potential) limitation is that const generic types or values can't
be used with cv!, because it requires the const generic expressions
feature. The const_as! [3] macro did not have this limitation. This is
worked around by special casing conversions to language integral types
in the cv! macro (essentially subsuming const_as!). This special casing
can be removed when const generic expressions can be used.

Some code is taken with permission from Alex's const_as! series.

The structure of this series is as follows:

1. cv! macro
2. updates to nova-core to use cv!

For a follow up series (I've already written this, but to avoid spamming
a ton while we iterate on cv!, I'd send this after):

3. updates to various other code to use cv!
4. misc updates to other code to remove usages of `as`

We have multiple ways of converting - T::from(),
FromSafeCast/IntoSafeCast, cv!, *_as_*. This series uses them in that
order of priority, based on Alex's suggestion [4].

This is based on drm-rust-next.

[1] https://lore.kernel.org/all/DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net/
[2] https://lore.kernel.org/all/CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com/
[3] https://lore.kernel.org/all/20260825-const_as-v1-0-1ce712225fe2@nvidia.com/
[4] https://lore.kernel.org/all/DKYTZNAX6ON6.1K1372FFAQOF7@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v5:
- Explain the cv name, say compile time and mention const contexts in the docs (Miguel)
- Add a Pitfalls section on unsuffixed literals defaulting to i32 (Miguel, Alex)
- Fix doc links, comment capitalization and spacing (Miguel)
- Use the kernel import style in the doctest (Danilo)
- Rebase on drm-rust-next
- Link to v4: https://patch.msgid.link/20260917-cv-v4-0-547ef5727451@nvidia.com

Changes in v4:
- Squash the prelude patch into the macro patch (Alex)
- Move the new code below Integer (Alex)
- Comment the explicit primitive arms (Alex)
- FromConst to make the primitive value for NonZero, Bounded and Alignment (Alex)
- const_assert!->assert! in const contexts (Gary)
- Base on drm-rust-next
- Link to v3: https://patch.msgid.link/20260902-cv-v3-0-0f90659e711d@nvidia.com

Changes in v3:
- Add comment about not using FromConst trait directly (Gary)
- Lower case on const assert/panics (Gary)
- match instead of unwrap() for NonZero + message (Gary)
- Add reviewed-by tags (thanks Gary!)
- Link to v2: https://patch.msgid.link/20260901-cv-v2-0-446bc69d2ade@nvidia.com

Changes in v2:
- Improve error messages (Gary)
- Remove pre-req for Alex's nova-core num->kernel series.
- Link to v1: https://patch.msgid.link/20260828-cv-v1-0-48a180dfc4c8@nvidia.com

---
Eliot Courtney (2):
      rust: num: add cv! macro to create values from constant expressions
      gpu: nova-core: use cv! for constant casts

 drivers/gpu/nova-core/falcon.rs                    |   9 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   4 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   7 +-
 drivers/gpu/nova-core/fsp.rs                       |   3 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   6 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |  38 +++---
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   2 +-
 drivers/gpu/nova-core/num.rs                       |  55 +-------
 rust/kernel/num.rs                                 | 149 +++++++++++++++++++++
 rust/kernel/num/bounded.rs                         |  16 +++
 rust/kernel/prelude.rs                             |   1 +
 rust/kernel/ptr.rs                                 |  12 +-
 12 files changed, 205 insertions(+), 97 deletions(-)
---
base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025
change-id: 20260828-cv-8d4e952fc14c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

