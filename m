Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74568C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC7510E686;
	Mon, 17 Aug 2026 07:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ek5hOSaI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D3910E686
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEysfLcfNKX1YveFrsSJq3hxUZ0l6pP1GGpHWgVghXiPG+tBN4ggrY+meZt8yDWd8nKdtjfmwzqjJsF5Dv4HYeqpS1Cu3D+huWL91nIW3/67xWaaKUsmciQUKsDOuHSDkMYohStydCUa/jjpOextgyHEzYfMFg45O+pJVKbZvkuVjAP4nG9AbZFmbJ5qRe46jeP0bKp7PKEhU0DWJ0sGUU7lzvL+KFvriKVooqDdWDBLp246nIKf10/LpLOL2K+Uq7X0njZHspxYIKzKVWmGPXPZsKWZcLBpWuWCNiikgDuhF9kCwVRn+H8LRXuRmo7W9fEtuuff6Ar/saESzmZ3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zpZ5S2aQa0d4EooqqaOn2AZ3c/mK+z1vxWFFJq0ca8=;
 b=ANDvbdHdRlO26EsvIcpLAsNmKT6tkzUVl3AxKJv5DosKJnGyaTDLFkDm4dGv6iHZ7Yz3yomT6aApd/8Wsv9vK7s906BcQo+L2r0B7Pd2tRwimF2YVbNL3ErixFVeTImrOX7VX5ia2w1+druQ730ZzBXpATIXKi2imoSZ6RyvsKpKO9x7Z8XEL2S3gyw5PFGa+luviyaFMHEX4AAG2bF0dH4uzYbwl8vi4Zvypl35Jjj5BQnTa4sjYESHVN647Z32pNaZKfyubAVYUImWpCvVRpbQQcJlmQ4c2QO+SCvgZ/4l9vyOnr8yHzIwbDPyXqgRlvFdFnh9o4M1ZCFKo/nZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zpZ5S2aQa0d4EooqqaOn2AZ3c/mK+z1vxWFFJq0ca8=;
 b=Ek5hOSaItbsYlWWl33bAK4h8Bvstba+MzBOa/GONC2U4QObcjWiXkPP+b2sZMeT5CrxjFzB0TTVZR1kLYgtdefOLVrcjJX4OjWrXmRiDwP72P91fMkOFATXljdtsBdcZS+IqKUSA/O5ZU4DUwl78l/uiDTwIHV23aMK+bMGOiqN0e+T8Ck1SwGROslowFaTSqc09YEeo6YGnRSPnGSVMpWh7DxckMv770zPIRCm7AEmsbdBcz7o4qkaf7AZ5kKvsC7q21uOjnmSPHAQhWode+JBkoCFkYeQ06wV1RCERhbQ9tKUK/MhUWBALMwMAJcoKP79CpCyj4v4gy1jIoL+XOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:22 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:22 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v7 00/10] rust: Add support for reserving of ranges of IDs
Date: Mon, 17 Aug 2026 16:04:14 +0900
Message-Id: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XRzU7DMAwH8FeZcqbI+U524j0Qh9pxWJC2QttVo
 GnvTrpuoqjKyYp/fyvORQzcFx7EfncRPU9lKN2pFv5pJ+jQnt65KanWQoFy4CA0dCipkSG30Wh
 yyZGorZ895/J9i3l9W+rhjB9M42znjkMZxq7/uc2Z5Ny3RHrQS+QkG2iCyRyUjWwcv5ymkkr7T
 N1RzJmTWin1UKoq0pYtx4w6xY3SaxXvSlelgAgCaIVIG2X+VJBwV2aeFbMClxNh9Btl10rdla3
 KkXfee0CdzUa5tXq8y1UlHSDblNFi+qeuy4p7/jrXDxuXvQtsB27q/bGM+52hiK2p65WBQ2IEl
 5Cc0VIqbClkA/XkaGvY9RcFyOuWBQIAAA==
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
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:405:370::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: dc82525c-d9ae-4d44-7a20-08defc2dc3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: kbxbTGqop0JRX46K+gCpVN874pNsOmpc6ral7+iD5VGyd5hDm+pg6lVj42I9+PS6Qt9DjyAzhKmj1NSPCpvwexsI22NphN7fxND0VjG54oITuLK8g7CqwScmsOFho0Hc6HyLuR5lkgkd7lpJQYuZdkASYdUyD6oEXDq4s15O9rC/+vPk5kAxgH1J5nTZshbq7hdtn3j6t0AK4IzDyxxgVqBqRCrp4SWXdL0efD8q4CsymTVRfpij/tX/gf6GSm+8TiXjkvc2MCp0fd1FdK2eBoQHOTkWkkHTi5Hn8WjCJ6Q107FA7oeZ4rB0m20y5P4AE7oooxCKR/jiojZHaho5OzwHCXNTT4GG2mbabitJ4nHwHhCYOYlDKUBP+r2QCTPPoYWoiv7EesxDuL1A0vD2moYbnBFxfQIhd75qvEJnIVUQq9fsrY5RdNc6o+NDQytw0rj88Bd8FiQOD+LnFuUWNC2J6st3kCrk+G5ermhDy0RzBCBji2FsL4IkQOlQtwqVuvnfOZF3WNwSfCZGDEUsx2gl6l6/P76GL63YP9uk0mvmr/OgeCiLrRpX/GgB+tO1/C3/IBzs4zeu12i6fk3beAQ+KfB8ehxiVv8DLR6+SrVJ9FXSusD38UURXwAZFlFUkYRkyoLmRDB7xly5mtazR/Vn3fsEnhKpBAoytqC2X1MUlcLrQjCLaE3XwkIE0DJ0rwIponnuHAqe5JEvxnB0Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2Y5UHlOTnF1ajZpK3FUWGMrV0QzRi9tVTQ1WWdaamVYVDhKYVd6MVQwbUtP?=
 =?utf-8?B?a1A5MGU4S3RSU0JtaGlwWlZ4UzlqNll0V29LTlNzY3BwNkJiakRiN3ZpVkRp?=
 =?utf-8?B?ZXFRN01BZmlsQ3ZSc2tWZ0VxNEdoNXNWUDlOdWxuUThVbG1xMTlobmtVeHFo?=
 =?utf-8?B?dDJ6VlQxVDRRdkdxdWREdWljMVAwcGsxUm5QYnpxWFJ2WE9iMzhDRlU4ZUFJ?=
 =?utf-8?B?VG1kYkVtRmFnOGJqd3BPRHpxT3hSY2Q4WGZhZ3NQV1hjeUxFeURJUjRISndy?=
 =?utf-8?B?R1VWQWU0UWxFeFVqOVJ3YUhkYlp6NXN3ajdzR3BkQlFyQzNPSnRVaHVVZ0o1?=
 =?utf-8?B?Q2hocG40c0FsanRidHdaQlJ4TzlTd3JCbDFBMm5RZ3F6c0NjeEhOVitNQmVB?=
 =?utf-8?B?WUlFM210NitjMC9KUWJRazBSZFJDRmJJeWZ3ZnhnVDlRV0ZmTThObkJ6blZJ?=
 =?utf-8?B?ZG03R1l1Yld2SWlKaDZyVXJlcHBJL2xHdTdyTnVNQUJaVFUvQ1JnOVdkSTIr?=
 =?utf-8?B?NitTWWV3aGszZHp5VDRXRDJ0dG80TTBTL2ErY0pjVWtzOHhFSHA5bllVVkQ5?=
 =?utf-8?B?N2dvaVBEL3hxbDUyWWxjbGpPSE16TzU3SmtPdHBRMUQ0N2RjOWVmRU53Y3Bi?=
 =?utf-8?B?Y3Z4NVpyL1QyZWM5bDhHSGdoSCtYMVJTZjlNaTNsZTVyTWpMRDlPQlBTbTcv?=
 =?utf-8?B?YlBvejJzM1NTakc0OUtubXpCZ0oxcHdTNzhXY1RnMlhSSTJidEYxYzQxeUxs?=
 =?utf-8?B?RVdQc3h5LzhkTjh2SHo5NENiV3FXbGxjelNFR1EzNWViTCtlTHdaYjJJZEdh?=
 =?utf-8?B?L2p2Q3dvdzYyb1haTHZwN0RDc2RuUVUxQjFnZkRmTjFMTksraVlXRit3RG85?=
 =?utf-8?B?YkFVRWkwSFNocEZqa09yU29nN3pFbk9uUjJrSWdZSkFlRnRnck9jOW0rcEdi?=
 =?utf-8?B?Nyt0MWpROE1qR2FFTWpNb2dWbXArSW84dzZEMURqSVY1REdwOE5JWFduTFpK?=
 =?utf-8?B?YzNtem04TURnc3lpUTNNOUMzcU1vRmlwZkJ4amI2dXlabWtuNTQyOGNSQ3pH?=
 =?utf-8?B?Tk9iNUM0cHhvK2UvaWRuMllROE5PRi9ZYzNwdWtzVkoxTzRUdnN6bzhnbGF6?=
 =?utf-8?B?ZHJjeFg5T0VzRW5JQ2MxZDhrSXN3bDU5SWt6UGJadU1kcnlrMThoMUdEVDQy?=
 =?utf-8?B?UnhMTURDVk5WaE0wR3J4S3pSTXhMRjkyYzQ0Zzk5Ny9mNGhjMzFIR1dhMVhN?=
 =?utf-8?B?eGRWTDdKbDRSSUpJUXE3OG9vYTdtWEJlYWJFYnBWa0VodXFkWHYwUEoxZkNZ?=
 =?utf-8?B?QS9ueVF1SkNMTFdGNjM1cVlMTmVRSGpVWmZoS3JUUElwSDB6c3FwVEluL0Vr?=
 =?utf-8?B?YmphSDEzR2FvN3I1bDNKaWx2cUVxU0dHaWZBYWl6bkpOcWgzeFJiZm0zWUdl?=
 =?utf-8?B?bG8yUE1ncVlLRkZYQTJ3bVFpK1RMeGhTU0dGeGdPZ0pEWFcrRVMzellCb3JK?=
 =?utf-8?B?V3lWREQvdnpMQ2V4U0IyeHRUakRDdGZDdmN1MDNIWnBYajk0bThxckZuMU1s?=
 =?utf-8?B?a3pPWEVSaytTbHpQMGFveE5yWXFFK1ZSMnptTEMweDZ1Vm84V21kNEtFS2Yw?=
 =?utf-8?B?aFA0YmpIamNnU25iQ3l0RDJCMjdRbldCdlBCOFdQaWJCZ1pZTnJJU1hYTEh2?=
 =?utf-8?B?NCs1a29mRE9PZStjZ1ZycWpHSlhYd2hLTEJQTk03bmJFMUNxbzh4L1hMbGpK?=
 =?utf-8?B?VjVoMGlWcVIwaHdyZFdLdzJSZi85VmxkcVVYdmd2UVNlSXA5VHVxZUJoR2ZW?=
 =?utf-8?B?YWdVWUN0UHZ1R1gvMXR5aUZVdVNHenp3S0RQZHhiTnlZSTN3RDNKcyt3RnYy?=
 =?utf-8?B?MVhaeXNYb1phYjBJV3ByYTV1Q0UybTFHcXkwMk5jME1oWDcwb1NZUHlFMEh5?=
 =?utf-8?B?dVh1bG0rQ3VyUFZMV045elI0dE82L3p4R0lsVE8zUTFaN3BWNmJkMXVHellm?=
 =?utf-8?B?aXhXMjRIZUZrNy8vR25FajJCZ1kyZHdIMjhOUmhZOWk3S2VHci9XaFdVNjFw?=
 =?utf-8?B?RUJJUnRCcEdGN2RrMytVWlpSSmR1ZklVNEYzM2hxRWNvcHhzRGVpY2RTcTdX?=
 =?utf-8?B?V0lDS0oxU1BIWGZyNGRHWEdaMDdMMDM0a1Z2cnRPQXZqYldhMDdhblBteEk1?=
 =?utf-8?B?akZFOTJCVDNiQlhEbzVoRkxHOUZLc3FJR1lGbnk1dGpYVkt5K2JoZFZnNGw5?=
 =?utf-8?B?MkxTWW9XaXFKR2ZSU05OekU5TjIvRGdtM1JXWnNrcjc2d0dESE42UzZqUGlR?=
 =?utf-8?B?d2hra25jYzllaysySlFnWTY5eW9ac2xGYXdJK004am4rT0JXeTVXTG5kWWor?=
 =?utf-8?Q?79Z378dLyHkOjpl5QMxFRzb8SdvwlW4/wiyaq0yC52lkQ?=
X-MS-Exchange-AntiSpam-MessageData-1: eJpfXaHWU4klfA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc82525c-d9ae-4d44-7a20-08defc2dc3ae
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:22.2284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNT2RG41YS0mMYm9g0Eq4L3oqm03nPv10im2ZhoxPRLaKZ1BNkbnEl2yJ/i4CdZtJo684lmRV772Vy5u7mNgNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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
for channel IDs. This entails adding bindings for the C bitmap
API for ranges of bits, then users of that in `IdPool`, and finally a
user of `IdPool` in nova-core, `ChannelIdPool`.

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

This is based on drm-rust-next.

[1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
[2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
[3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
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
Eliot Courtney (10):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: restrict bitmap length to at most i32::MAX
      rust: num: add nz! macro for compile time NonZero values
      rust: sizes: implement SizeConstants for Alignment
      rust: bitmap: add contiguous area operations
      rust: id_pool: take a NonZero capacity in with_capacity
      rust: id_pool: add contiguous ID reservation
      rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
      gpu: nova-core: add ChannelIdPool
      rust: use Alignment size constants

 drivers/gpu/nova-core/fb.rs           |  10 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs |   3 +-
 drivers/gpu/nova-core/fsp.rs          |   4 +-
 drivers/gpu/nova-core/gpu.rs          |   2 +
 drivers/gpu/nova-core/gpu/channel.rs  | 201 ++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs       |  12 +-
 drivers/gpu/nova-core/vbios.rs        |   7 +-
 rust/kernel/bitmap.rs                 | 335 ++++++++++++++++++++++++++++++----
 rust/kernel/gpu/buddy.rs              |  26 +--
 rust/kernel/id_pool.rs                |  53 ++++--
 rust/kernel/io.rs                     |   5 +-
 rust/kernel/num.rs                    |  23 +++
 rust/kernel/sizes.rs                  |  47 ++++-
 13 files changed, 644 insertions(+), 84 deletions(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

