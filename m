Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A31ECCF2D4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538BD10E343;
	Mon, 19 Oct 2026 04:29:47 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7892E10E230
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi1Wu63WrSRgEC+jrKUmVuKL1+89qFNcdvWM2qmfi5MJiyNMIrnVM3k4rkLZjDFLBXtTNupG5+DZ2n0J7k7t7+xHepAzH1Z5/3+HRedJwn2leuw4bQIYzm3AeRhusA6qwhL6XgYxTda/Scwi/vmTSDhVD0qPpNh0svh6rH62iYb0L6CdllK+IUUd1JTHyKrIDnLeQtvnv+77IqwKtLSBGR2pcDBbHYpZ7gaxThn553CI+vvWgZ8YC9Kgvq+ZdI5EkS42J6WRQIQTwq5gSYaQbLuzmefO3H786PRQAzwuh5qTX01V8HE05SnLRtxFoybrNj8Y/rFGBLm3wru6qfq40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IelIj28Vcfk+/MlBp0yDbtvEF0yhlbpgeWNEOkph33I=;
 b=UXaOox2U9W62lU6oj+MoBhkxAWav04SAkA0U7J7xn3Mg0Cx9Jeum9a4Adv+uSnoBcee7wdj1es5MxA7nMdvjb/LSMvohlagF4GpQNUfD8D0dKveFyzzpAj3UDgVD/W9pxmvKCpJ9dlLHiLJQNx9BF/Ir1Tl782ij58MCCkA4ahEXnOjepigbjO98oIvy5gU/eNFHOe/G0y0eZs3Z955xtoJ1v7DMvuZR+8PJpuRu16e7uLJ1mWzDWHVjB7jlu/SZD+vEKEPhGMSOZY8D1BApy6+WmxWKfbKQ4GrggPMfO7CQmwwa7Y20eQ1drYO5UPAJQNMxZ/0WxYrCsdiRaMJzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IelIj28Vcfk+/MlBp0yDbtvEF0yhlbpgeWNEOkph33I=;
 b=p3UHK76jp1URQm6V0R0KwQdh9q/BRNI/e+Igu5n7tusYappmFL04kp9jowVKKpZem4gRvE/6IgFrSeCXjOTQ19wb9UERv2Rpfq5p1JhF8NJXEo96nYANgbbSEUOGQOT0MpQDohDCGUfN451SNhwvcapDWyNwAlmNnX2Yy31Xc3KBYEAXSkXZPPE1dFAls3i7h7EcNcmXomIgnS4e/2vPA5gvAUEqygEjjslQ4RIbsx8xIc5wcsMmJzQ272/6dxapawpQo3H08SqhkjM62JegOXkOJ0xPqnjqMGXbDdxk4YjJ177YQrT57WOK64CVZ2qSIiIszSYTnXDxWwa0Ci6LSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 04:29:34 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 04:29:34 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v10 0/3] rust: Add support for reserving of ranges of IDs
Date: Mon, 19 Oct 2026 13:29:25 +0900
Message-Id: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23S207DMAwG4FeZek1RjnayK94DcdE4DgsSG7RbB
 UK8Oy7ttKJymcifncP/1QzcVx6a/e6r6XmsQz0dZaHV3a6hQ3d85rZm2WiMMqBAhZYONbc6lC4
 6S5CBGil967nUj98+j0/zerikF6bzZKeKQx3Op/7zd9Cop7q5JSo7txx1q9rgCgfjIzvgh+NYc
 +3u6fTaTD1Hs1Lmqowosp49x5Jsjhtl1youyooyikgFZU1KtFHupoJWi3LTrFiMgpIpRdwov1Z
 mUV4UEAIiqmSL2yhYq+u9QJQGldjnknzKG4VrhYtCUZ0PaBhcDv/MCitlriqISoSOELMyeqviT
 UV7fY0oSsn/U2cRqJQ/6nsOQc/vF8nUeU7GLVH73XIEydPYhuw4elNIO9rLI4pN3cCtdHqt5/3
 Ouoidk58Cl1R0nDLoFBJ6r8FnD4w5ZrIoY79/AGCTyWzSAgAA
X-Change-ID: 20260608-chid-18fa943c6d6c
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: e92543da-054d-42f3-46ab-08df2d999388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|18002099003|10067099003|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PCn/LlfG/ghTEx5m8ONLpjzz5zv6RA5yRR9pHiNN3oZNizct979LnKtw+dj6hG7cHIwukUABuKyPF4w8HYLeSoxe6k/exFwyW/nzhORdUEEME/1IG4pE1lmXsh0yd3PAG5SshIb4MNqbqt0z+mFLabExtoeWTulgGFn2ZJxSAKWiJT2LBV4In/ozIxHxiVq4Aq07ONKBVPM1H5eX5fnIJUP3I0M4aLR/jxUdJIubBUiqI+lOh4C+PteAjuNyrpD0FwZvgv9P5/MLbfMIioh+f2WQ29Lik4TPrBaq39ra0+/W7MeXA+cKdeVZR+nrH9FB12jcfsyrbtWR124nxxEzXeUY6ceU+OizGm0ciyyBZ8YCibVOZlQRsejceDdzesPUgT7uI+t/zSxNQs+mRESTRWUVrOb9gkVx913Ip1A3DzGAcXhBNFwym6nkbjELAW6q0PsXM3RPjo0EagwKvQ2fU+Er8jxxvuXBHy8F7/pmkyjK5zUmcK7C+Hgauk8t7AJToF4UrCKWQmFGaLXbOrh5kBY+IDnqY2pwXRwGhfuigpEcl1w5XIM0Dlyk4tyVKlWZMNFyh7ECR/fg1D77b2VriunzroRuNfV7mJnKhtm2peh2xJSSYgYJSTka/ZAsM/Yw89drdTyLRUvDt4C+7KL5hUdqQWIQplNIqvX/XNkSL9Bz6Mpg/lN6/GrheGU4ZyFO3/OqUH7WBcOkLI0hLATdNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXNWTWlFcFA0L0Npb3RPT0dwZGZ2bU9RbUphUU8wUnBQU2RMdFk1T3J1OG53?=
 =?utf-8?B?UjU4WUE3NUpnYzYrb2c2ODNjZWl2Mm9NZWhnNVJqV282RWJISUlJTndoN3kz?=
 =?utf-8?B?dUhjSGhMeE0rUjNnTmkyR2NOUUprQm0zTjQ3aFJNdGltZjVkQTNuTXZ5Tk04?=
 =?utf-8?B?MnhMY0ZlMzZIVXBXaTZmTlVPVXJBdEw5MEFzSmRYZXFlUTBXTkcxdWIyMUNp?=
 =?utf-8?B?UWJJSzdkMTZNdGt6T0ZET0tuWXJuaG1TdnNlSXpsZXFwTFZlbkRzK2JCN0VH?=
 =?utf-8?B?WkxIWThCMVNqdDA0TVhOdExRYjhwNGNyVSs0LzFMQ3IwNkhydnM1QWlvMWRO?=
 =?utf-8?B?YWhTYmd5VHg4c2RWMVRBWVJ0WXJMQ1VRTFRSdlRKVmlHa2puTExpakwwSUlq?=
 =?utf-8?B?bnNQaDRHUmJZejlFZGhHa3BBR2plQTQzcmVuNnNma1h0VThMVVZkdWdWTTk5?=
 =?utf-8?B?eU94WFhzUTQvL2h3aTRUdUJmOUJON0krY3U1TmZCK2x5TGNuVC84UFR0M0Rh?=
 =?utf-8?B?T1pKQ29WRkRNb015NWJHV0VpZXJzNHF2WU5ZVlVnUFdiMFhtMFRTc3ZPWWNj?=
 =?utf-8?B?cE04ak5ReDdrcnBCMkVBbUxja0ROWVpIUmdXSDB1RzRWWkpoR2JOR3JCeWls?=
 =?utf-8?B?Y3pSODBQdmNEZGsrd1JBdlhoNGdTcU5BYlRIOS90N3k4cGNZSURCblRFUnV1?=
 =?utf-8?B?MEo0S0k5ZzJYUzFXQmE4ZS9rNnRPUWIwWXpLQWtwaHhGa3R2c0FOK3ovWGZr?=
 =?utf-8?B?cnFZUFR2V0x4UHNzMHhPVm9ndHl0VnR1VFJscVNkRjAzam5pckovM3JjL3pT?=
 =?utf-8?B?Wmlad1JObWRHZHF4NW1RbGNmV0lYS2xzVDg0RGVPb1h0VDBMaFF3TXR2aWRZ?=
 =?utf-8?B?NlNieDZ4eW53MW9iRUVGcVZ1czcvcXZ4WjYvVHZKNlBJbFh1NTFMdkw0OGNB?=
 =?utf-8?B?alNkU3RQTzNTdUVCZmRVQTlBWGVKRzZIYVVQQk5HYlZVS0FYTXFPQWJXMmd0?=
 =?utf-8?B?YzB4TWE4UlRsWTJGc0kzU1VzeEF6SXhBU0Fobkx1bjZqRUFub3o0bjNhL3Y3?=
 =?utf-8?B?N29WT05pdC9aTVlQUXpaTXBUbGxlRHFaQ1Rwc2lxUVYvT1c0a2doUHpmSWJk?=
 =?utf-8?B?NGdYUU5SODE0L0VtS3dIT0RyZDFXdHpGb25ZY2g0bFdsemViclJBcERMOC9n?=
 =?utf-8?B?VDQxK3NGSWpHdkUzNmhCcERjQWVmSkhNa2dPOU03TUdlNXpqSHo4UFVndjZN?=
 =?utf-8?B?ZE5UMWVkbU1UZmZQa2tZVE5tN0xHTjFtYks0eCtDNS9USGs4SG1nSmRqdUV5?=
 =?utf-8?B?WlJLNkRYbEVDOWRJVTdxRTEvSDg2WDZYT1NVYUhwczIzTzI4VmEzVHp3aHk4?=
 =?utf-8?B?YWszQkphNnozMmVNdm1FZUZXUUF0N25hanB0aXdFd2dUcHNrQ3NxcjVqb3g2?=
 =?utf-8?B?RlV4RkFQT1B5UUcyby83a3JNeVNaczdRajhtcE95bUdsSWNGQndHTEkwaVY5?=
 =?utf-8?B?ZVVIUTlybjlXT3ErQ015V24xTjd4UmlqaGd2TWZFVC9sOEcrdGIrb3JLRTdr?=
 =?utf-8?B?VU5RSEF1Q0ZVYklWNHA1YWpwM1ZibkFkWkF1NytaU0l2QWlTdS8vb3NhUUVn?=
 =?utf-8?B?cXIrWkZ1clg1aHdjTlRyMEp4dUYrc3dPZkErUHppQTMvRytKNlluaWNXcmhw?=
 =?utf-8?B?cjl2aEhabEMyZXd1MU4rZEdtN1hxVWdpK3dkNmZGVkVQNXVWYko3MUVQbWxG?=
 =?utf-8?B?MVl0bkl3cGI1ZGdySGpMNW8yTjExUE8zUE1RYlloTE8zTWRHaUNwMGJhV2JE?=
 =?utf-8?B?QUZsUTI2aG9CTlZ4cEIrT3pEdkwrRzdDL2FUMk84N21aVHFSeWxLbjJJNG5S?=
 =?utf-8?B?bFNWZ2NlaWNhREZLOTNHNitkVU9QWVpIRklsZG14L09jTURqak1tSFphUERV?=
 =?utf-8?B?bHVtSDU2Ny91dTR1QmR6ZjE2Z2VDM0dCZktTN293L3dVSlp1R09NNy9lRU54?=
 =?utf-8?B?T0IrbUtBSXNuUmNrLzYxMVhyaTV4aSsxQjVHL1lWekIwUlA4NDlzOVBuVXFE?=
 =?utf-8?B?VFVBN1MrL1p6MGFTYzczNFZPdGZNT2hudlpGM3orOWoyZkJhYzBJSVcvWWtY?=
 =?utf-8?B?VURQbFlRZEVoWS9LeUtjZFJqdmx5Yll6YTFKU01IV1Myb0ppaVF0emtDeEpw?=
 =?utf-8?B?M2NNT0RwSlNzYXdkQzRLN2VYTnpjRjB6Uk9MU3phT1FCK1RPclZ1SHhCU3Vy?=
 =?utf-8?B?ZHVCSEhzek1FMlpsNHlBQ2tWdHdyVXB6WTRId0R6LzNFL2ZxdFh2amZuUDlj?=
 =?utf-8?B?UDBjMCtOeGpwTGRFelZYTG5YMENJMlVLaUxPZDdYWVhBZndLR0kzb2lGM3NX?=
 =?utf-8?Q?3X8aXUK25/PiOEkYNVLf5S9kFeJfcIT/EQsLkchWC3any?=
X-MS-Exchange-AntiSpam-MessageData-1: u67aE2ZCpHPOVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92543da-054d-42f3-46ab-08df2d999388
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 04:29:33.9669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKdxxa3diffBPZPoGSPv9ujXLzQzlv4nN5gzZPxM9i4CYsMvRPCaaifiTalNcCeEC/qkFcaBfHhJWZtSn+XazA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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

Add support for reserving of ranges of IDs, with a usage in nova-core
for channel IDs.

The bitmap and `IdPool` parts from earlier versions are in rust-next
now, and this version has the remaining patches: using the `Alignment`
size constants, exact `IdPool` capacities, and `ChannelIdPool`.

Channel ID tracking is needed for allotting ranges of channel IDs to
vGPU guests, and later for regular host channel ID reservation.
nova-core needs allocation of a contiguous sequence of IDs with a
specific length and sometimes a specific alignment [1].

About the tradeoffs between different data structures:
- IDA/xarray do not support allocating a contiguous sequence of IDs
  (ida_alloc_range() allocates a single ID within a range, not a contiguous
  sequence).
- A maple tree works, but is not as good a fit. The ID space is small
  (limited to 2048) and aligned allocation needs an alloc_range()+erase() retry
  loop (plus a Mutex around it, or new mas_empty_area() bindings) that
  essentially reimplements bitmap_find_next_zero_area(). See the maple tree
  version at [2]. For 2048 IDs a bitmap is also considerably faster and smaller
  [3].
- The bitmap API natively supports aligned contiguous area allocation
  (bitmap_find_next_zero_area()).

This is based on drm-rust-next. It depends on the v9 patches that were
applied to rust-next [5] and on the cv! series [4].

[1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
[2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
[3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/
[4]: https://lore.kernel.org/all/20261013-cv-v5-0-113a538dfaef@nvidia.com/
[5]: https://lore.kernel.org/all/CANiq72kohkx1-9iendYSD4gML8wv5bF+HrY7RO2vagLhtXYSKQ@mail.gmail.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v10:
- Drop the patches that were applied to rust-next
- Rebase on drm-rust-next (plus pre-reqs)
- Use a capacity of 1 instead of 0 in the grow_request() example in
  patch #2 (Yury)
- Convert the remaining Alignment::new() users in nova-core in patch #1
- Link to v9: https://patch.msgid.link/20260930-chid-v9-0-0d6cca376cff@nvidia.com

Changes in v9:
- Rebase on drm-rust-next
- Moved cv! to a separate series which this now depends on
- Reference Link: tag from the text + indent code in patch #4 commit
  message (Miguel)
- Add reviewed-by tags
- Link to v8: https://patch.msgid.link/20260827-chid-v8-0-bc74c77d0214@nvidia.com

Changes in v8:
- Clarify overflow cases in patch #2 (Alex)
- Replace nz! with generalized cv! macro (Gary)
- Add cv! macro to prelude
- Split SizeConstants and adding new constants patch (Alex)
- Move alignment size constants conersions patch (Alex)
- Drop NonZero on IdPool, fix grow_request instead (Alice, Alex)
- Add shrink/grow doctests (Burak)
- Link to v7: https://patch.msgid.link/20260817-chid-v7-0-a5872e64d8f4@nvidia.com

Changes in v7:
- Add nz! macro for compile time NonZero
- Implement SizeConstants for Alignment + add sub 1k size constants
- Use Alignment constants + nz! in this series
- Add final patch converting existing callers to use Alignment constants
- Rename alloc_area/release_area -> reserve_ids / release_ids
- Link to v6: https://patch.msgid.link/20260813-chid-v6-0-160be5dfb5bd@nvidia.com

Changes in v6:
- Take a NonZero nbits in `next_zero_area_off`, `set` and `clear` (Yury)
- Remove `UnusedArea`, `IdPool::alloc_area` now allocates directly (Yury)
- Add patch: take a NonZero capacity in `IdPool::with_capacity()`
- Add patch: do not round the capacity up to `BitmapVec::MAX_INLINE_LEN`,
  which also removes the bounds check in `ChannelIdPool::alloc_area`
- Add more testing of Drop for `ChannelIdPool` (Yury)
- Link to v5: https://patch.msgid.link/20260812-chid-v5-0-6c767770b3f4@nvidia.com

Changes in v5:
- `bitmap_assert!` i32::MAX length for Bitmap::from_raw* (Yury)
- Only run overflow check on 32-bit (Yury)
- Link to v4: https://patch.msgid.link/20260810-chid-v4-0-c9f206fdcb97@nvidia.com

Changes in v4:
- Add `next_zero_area_off` to match C code (Yury)
- Replace overflow checks to match C code in bitmap-for-next.
- Tighten `Bitmap` unsafe contract to disallow Bitmaps larger than i32::MAX
- Link to v3: https://patch.msgid.link/20260729-chid-v3-0-20cc08032bbc@nvidia.com

Changes in v3:
- Use `Alignment` type in id_pool and bitmap (Alice)
- Remove hang check on the basis that it's extraordinarily rare.
- Link to v2: https://patch.msgid.link/20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com

Changes in v2:
- Collected Alice's Reviewed-by on patch 1.
- Address Yury's comments w.r.t. using __bitmap_set etc directly.
- Address Yury's comments w.r.t. following the C names
- Additionally check for an overflow case that causes a hang
- Added more info to cover letter + patch 4 w.r.t. channel ID allottment
  requirements
- Add align parameter to ChannelIdPool::alloc_area() plus an aligned
  allocation test
- Add missing INVARIANT comment when constructing UnusedArea
- Link to v1:
  https://patch.msgid.link/20260703-chid-v1-0-84fe8259e46e@nvidia.com

---
Eliot Courtney (3):
      rust: use Alignment size constants
      rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/fb.rs               |  10 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs     |   2 +-
 drivers/gpu/nova-core/fsp.rs              |   4 +-
 drivers/gpu/nova-core/gpu.rs              |   9 +-
 drivers/gpu/nova-core/gpu/channel.rs      | 198 ++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs           |  12 +-
 drivers/gpu/nova-core/mm.rs               |   2 +-
 drivers/gpu/nova-core/mm/bar_user.rs      |   7 +-
 drivers/gpu/nova-core/mm/pagetable/map.rs |   7 +-
 drivers/gpu/nova-core/mm/pramin.rs        |   6 +-
 drivers/gpu/nova-core/vbios.rs            |   7 +-
 rust/kernel/gpu/buddy.rs                  |  26 ++--
 rust/kernel/id_pool.rs                    |  38 +++++-
 rust/kernel/io.rs                         |   5 +-
 14 files changed, 279 insertions(+), 54 deletions(-)
---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20260608-chid-18fa943c6d6c
prerequisite-change-id: 20260828-cv-8d4e952fc14c:v5
prerequisite-patch-id: 26927fa5f94065327024bc2b0c97272f8c0ccc1d
prerequisite-patch-id: 01ec2e5a44b393a7ce1ee820654750dd4743fcb5

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

