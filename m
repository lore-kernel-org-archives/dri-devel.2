Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542FDC5DF9B
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497DE10E0F4;
	Mon, 24 Aug 2026 12:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lB6kT9re";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D33810E0F4;
 Mon, 24 Aug 2026 12:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpReKtuX7nCNE/4Lj+ZmNNtIX9byedzDg0FcgWSwGXNpIc3YgEfZGSRaRdacANYgefaLyBRWrq3hQgDdX25b/3VChh/pFq63DP7yjyXXXhWx5bMDkLQr9zrrbREbVVE8Y/SUKtPRSiQBSiJHSMdtYaVvpFmCZOaj1AVfPVdSOxwuFI9dU6xyoVw21ZIO8r5T/i4wB2a7gf0T0zWk+n0Aa+t49WS6DefkNhqpPPiCvr9YmMWlg2wgX1lqdU0f2LHzk9+Ebot9QuT9vEaj/tqOpoiSAEXZg6RKOPgJRgZprd307rYNMVomEvguoOZPBiyuyYHEh3m28wv3Hzyy48Phvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAdeqHJAIbnMJ3Z/wXLIZq7W8hhF3w3U83FHCXVUdnA=;
 b=uve060pAgbXOPNdYV4gVh0Hfj9twX/aUUqoN6vFOEyg+D0PSy5wK1C9zPWkqzBav3lIToqn4BMxOlKvG/NEouj7eoApkBzQJyVS+rXZtTAvAwH3A0h4nWkSctI3ND48eL/KwSHSz6SnGTbON0+YAYMsoODTZMzlsy/l7bpHV7+QVfkkoNMnLuqOxiLQ6xN6P7QIagOdiIAjx1T/4u6/Uc+uAiIl/WdjXv3jzPFAkKLZIIxsQAcTT2D955Hl69PDYC0s4MWRCpC422vbstfM0Szo7uHg/CegyP/idfV4M80dKLFBGn2rZV/LmjkWXvc6M+qr2a7eCUaBxq25SjzcW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAdeqHJAIbnMJ3Z/wXLIZq7W8hhF3w3U83FHCXVUdnA=;
 b=lB6kT9re4tzcVBmRLH41cLdmp3M7yGmzavysekabrnzcbcabJ6ZYj6PpFWVgwAz0lcdhlUK6JOTWg51y5sssSisrTftzHczk5fYVf623azXVg2pXiwckpaE/750D5LoZJmF7PtnpY8PriI1amfOhA19ZX7sLTitqw+0xxGDdT0zS7cH5zE9dKFZPVcs3uSPle8xShSe3XbvL8KUtisaMs7HR9KUH+POfkfj9xszQPpA5eyNXBV5hJ+MGiBPfW6rBo5mBQjYRrSuhBKq5sGquWKJXdcBbVPEPcpJinBPMUjEF+n8XvLVRMj0U5gu+vSSZn1FuADVIrXC8qjrKpQX2+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 12:04:07 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:04:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 21:04:03 +0900
Message-Id: <DKX5RB6C3BDV.RSOKNUP9FR4K@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "Yury Norov"
 <ynorov@nvidia.com>, "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v7 02/10] rust: bitmap: restrict bitmap length to at
 most i32::MAX
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-2-a5872e64d8f4@nvidia.com>
 <DKUG7JW3I90C.3F2JEQLEIV54O@nvidia.com>
In-Reply-To: <DKUG7JW3I90C.3F2JEQLEIV54O@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f00238f-77c3-4768-8dc2-08df01d7cbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|6133799003|3023799007|10067099003|11063799006|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PwMEW+FfSs/Iwpo5GgZGmLjwefoF5HrnIRbRSoHyyJSEpnupYAseHL7uJ3+XVH+i0tCaWH9uKegMAQAt9A3pnsqXUH3K7NNZ2EPEXBi39PbTOB8NfMJghpUAtNeyj2afHOtASNH6gTAqFdzF4qCO07Pu55H8BThhEfOOOxkVc1BRcUefcwu3PRdu+cnQykJUgSh9dgLwyApQvcy05cTG/5GmNp8Jn2VzaAOWoutzpnJUhsGXYuT0TUErH7veLRa2lIvCc8ofHIrbazqky7V9eymuSXit2ldaq6p2k3SvXSCSju4aYOpTIPVQ8X5aVoXZ3L/Z7zNeBvnzt7D6/rUtSqzHtjNonUEvUsRIqQrn/nbjZyYdpiTNpPfkKJs7ce/u6YM7do2jADHnrdqTE/d3CX6Gn0GOsvV1WRB5F7oFw09tuHfPJJM1GtqE2Onee2h0C0GdK9atjMgXIn1W+eAmkJZt9ZND++Uvj3rFpIse66haeM4NIgktH5RI588bfk6itf22qsWzdNulc1Wewg8uoBlw5kwOXCqwdkTtQf04iC6aeVfjPGLS0l6goeUy2PIABZ6NWl89UAd6UXXUYaz7YQewBgw/m853Sk/WHCmYiz+k2413/qBjPrl+fW3ghGdcAV768bppA1WYZRO2SOU7L+Y7gW8i2VEkxY8XTQ0PTrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXQ5RDlOTXJndXV3cStTT21SaFRKbXJEcU9qVVhUTENMbTlDMlo5N3hFSEhH?=
 =?utf-8?B?Qmxoa1Q4djh1UXFnNmVvOWhaRUZwaHZlVnh3MTVvRXNVVVBBazVJVFhMNGwv?=
 =?utf-8?B?aTJ1UHpUeEFiSlZFWEp6TTB6RU4yTU1DSHF6UjBrT3NCTEdMMUtMRXVFaHU4?=
 =?utf-8?B?NzZjcUdacFBHeVVCYU1QejltOG9QZ3FKdU5rNnVTV0NqM2NzaEgycFZHT1FB?=
 =?utf-8?B?eElPYTVvOWNNNi83TmdtNStiY2lRd3pnL0pEcWxtVncwSzRPQW1mOFI2ekJp?=
 =?utf-8?B?S3Joc3BkVkdlUHZHaHhoUk0zMWdNVVFCcnkxRkRWOXdyVTVQUUxuWkgwYU5V?=
 =?utf-8?B?aEw3c1VoR3poM1F2SmJjVm1VbDhUVzg4NWxvdHdFb3phVkIrdDlXVHdjZEJy?=
 =?utf-8?B?eEZCTlFJTnUyUThxSzZqN3I5M1BIN25DK1BYUE5uWXVjNldMMkJhS3VKUzRt?=
 =?utf-8?B?ZzRnT1dXYlZRVXVNUGdBdjNxYVRPQURxS0J1YzJzTVIrNzg3eG0xUXVPQWZI?=
 =?utf-8?B?OUtzU0FWbHRWd1R5WjdENHFCUmhyNGRtNUUrdVpkWTBlenJyK3JudGJNbm1W?=
 =?utf-8?B?ZGNHWHpVODBYMERqN2c0NDdFK21Jd3VrbUlselJJZzQvYS9hbTFqaEwvN0dE?=
 =?utf-8?B?N2l2Uk5CSlVoK1YyTzA2dm1aSnhoaXI5VWExYjRjU3dxcXZ3c0E2Zy9NMjZ3?=
 =?utf-8?B?MXpadys0RHdjdzRkNTVWenVGSjU2dHVnLzhIWUd4Y2dQTzJpUzNXNUhRMk8x?=
 =?utf-8?B?MGVaVmlOMC8wUk1FdHV2UnJveFkvb1N2Ti9MWTBwaVdtVUtadGRrVGxoT1di?=
 =?utf-8?B?NHhreFFRcWhxTlJGRlc2RlBldHFwcFpzdnBBS1ljL0k5ZGkwa1ZQWVBROHk5?=
 =?utf-8?B?L0tSQXVEK1ZzSW1jbndWdGdaVnYxWTNxMEg1YWMySFFYVG01WXVJL01kZytR?=
 =?utf-8?B?RWhnUjFqKzAzdjNVczVFVkMzc3orUUdjN2pvMGlVZE0xdGJvak1NY0dEWXU3?=
 =?utf-8?B?Y1V2NEJaS3pFNSt4Vm1VYjRkajZJSzMvY2gvNDk1QXUzNmNtRTNuVytWQW9w?=
 =?utf-8?B?U3Q5cmpWWmorMi8wTVpSWUc5WldiNmYvUkVmY3lsUVhPR2RYR0JIclA5dUQ5?=
 =?utf-8?B?VDNCaEpoVDBZdFJRUVJKN2huOGNzNm95UlEwL0lQUHNqZTN4Wm9ZQlZtbkcy?=
 =?utf-8?B?MW8yUk1lRXJMclQ4KzhiUzg1cmVHa3JWR1JjanJHZnVnVm5hNWdaNlh2MDRm?=
 =?utf-8?B?Z1FDdHlzYmZLU2djZkpHMUowTlNwWE1PK3dwakE1QnlvejlPa2pnY01yQ1lZ?=
 =?utf-8?B?UFphbndiZWRoUFN6RmpYbUdpb1BKanM1bmJKU2hDVjNMYmNnMlBzMUJnVDJY?=
 =?utf-8?B?MVRjMTRwcTBQZU5JdVVOb1UxdFphQWp1ZW5kN1FKRnV2bFhvaTdENGg5eHQv?=
 =?utf-8?B?Ulk2OERweVRqLzJlY2VLQW4zOGRCblR5UkdYS25sS1hSUHBHVDdGOGMwTDN3?=
 =?utf-8?B?QkFyZTJhTVM3dnlpRzY5VUtrVEFBbndxcHMxeUVFeTZsNThPZHZscUJOY3ZQ?=
 =?utf-8?B?SDBOV0RzMUZvNk51Ni9vd2RHYnVyMkxZWEY3SjcrUEdxVkIrRWxOWGhSeVRa?=
 =?utf-8?B?QkNNamM5cmNJTkMvS2EybzFkRnJCdGZLcXFMNDViMFV0bVFhTFBRRVJiQmRj?=
 =?utf-8?B?VmRNYlluanZ1SEJIZnRGWndiQW5jZXNZT2wrOEVDL2NILzh6V01Ea05TWnJy?=
 =?utf-8?B?NXRHdmh2S0FDdm42WUxSZjhMSHV0WGMyNDJVNytHT1RzVmp0U2Qyd0NCeHJU?=
 =?utf-8?B?Zmx0dURjckRxNE9GZEZ3M1RyUndpTlYxU05rN1Jib1c4SW0wOTgzUjhKVjhL?=
 =?utf-8?B?U28xMnp6TVRkRTkwM1lpcWljSzVhVGFyeW8yeFhFeHZmWldJYXF4Z2ZKclZs?=
 =?utf-8?B?UU5NcjlQSi9McFI3eFhCMDMrQU1XdktMWXBYUWpZSUVVWVpQTkRpY0p2Qm1I?=
 =?utf-8?B?N3Y3MEFQSDFUOVlXVFhoaWhHcERyUk8vR294WkpVT1hsd2cyQzB1M3NwSEtH?=
 =?utf-8?B?bmhDZTUvbGNPTlcxcG1pV1JCVnl0RFIwVk5mZlQ3dEJqMmNGSXJndGJDV2hJ?=
 =?utf-8?B?V0U2NXpVYlFuT3JHb2pRQUwzTW5UL0FYQW9jYUR6em1Gb2h0OXdoL3VIU3Fl?=
 =?utf-8?B?dnV4RUNZSE94M2NuaWsybEVYQVpwS3JkTS9xSXZhdUIzWEROaWJCNlg3SzNt?=
 =?utf-8?B?QVdsYXF0OCtrcjl3ckcxNlZqbUR6VmFuSWZmUks1SFV2d2psVFUzRzFGTERH?=
 =?utf-8?B?aU9XY0Uxb2g4dkkveEVoSis0SmVQN29HdEx6anFYQkRXVGw0N04wbjk5SFY3?=
 =?utf-8?Q?9oBINPeg67NBoEZWPCxDewRxKG9fdSdvdDCkyBX+TPo+X?=
X-MS-Exchange-AntiSpam-MessageData-1: hRO5PtF2G7LbTw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f00238f-77c3-4768-8dc2-08df01d7cbfa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:04:06.3841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CurJh5FcYbyCIeYHU7MnX5Q1Xzl5AmWrca7onkTDz1ZQ/B8TrxyAErqN14rsXSRDPmir69WlOluHI7hDtyR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

On Fri Aug 21, 2026 at 4:37 PM JST, Alexandre Courbot wrote:
> On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
>> It is currently possible to construct a non-`BitmapVec` backed
>> `Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
>> it is not part of the unsafe requirements. Restricting all bitmaps
>> (even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
>> simplifies a few things and matches `BitmapVec::MAX_LEN`.
>
> Can we be more explicit (if possible in the doccomments as well) about
> what "a few things" is? IIUC we are doing this because some of the C
> APIs take an `int`, so we can just state that much.

Yeah, it somewhat depends on which version of the underlying C function
is being called. The exact details vary between drm-rust-next's version
and bitmap-for-next's version. Here is a (non-exhaustive?) list:

- `copy_and_extend` truncates `len` to u32, which is wrong for >
  u32::MAX size
- `__bitmap_set` and `__bitmap_clear` need i32 for size and u32 for
  start - so you couldn't run these on a `Bitmap` with a > i32::MAX
  size.
- `next_zero_area_off` on bitmap-for-next can overflow without this
  restriction (we still have some overflow cases even with this
  restriction on 32-bit, or through `align_offset` in general)

I'll add a note to the commit message and doccomment about the reasoning
which IMO should more be about keeping the set of invariants between
BitmapVec and Bitmap the same.

>
> Note also (as a point to consider, not a review ask) that we could
> enforce this requirement in the type system if we made `nbits` a
> `Bounded<usize, 31>`. Currently `from_raw` and `from_raw_mut` are
> unsafe, so this becomes one more invariant for the caller to uphold, but
> would we have made them unsafe just for this if they weren't already?

I heard from Yury [1] that there is some work to eventually unify on
unsigned longs. So I expect that the i32::MAX restriction may not be
around forever. That's why I didn't do a change like Bounded here cos
it's quite intrusive.

[1]: https://lore.kernel.org/all/anELwosZSI5MZR4d@yury/
