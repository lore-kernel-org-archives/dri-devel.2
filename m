Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B9FC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199F210EEE7;
	Wed, 12 Aug 2026 08:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAWCPVqV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFC310EEE7
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1aeDO9EsjJZx+n+nZQFr7u41J+wk5/339wACVHHsG6TNuif55L5EeuowfJCIz2bAElanFPbdNixYSr8y6QOa7y0z91xlzhknMLe7z081cVVI7PIG7CsSOTNMp4q1ZAdb79p01gfVhNW+NW0tGt2n9CPmL6eWJt9O7vAdKeb1agKucvt7l2RSq9BMESRl3nutOjpeyReQrWO9iB/tUBRbTi59/NoMarK6uthGPY6qSemSXHgleoDipjA/MZBD7IcFjvmddfCsb43MQZLGHht/cU2QUSwAiWO+pKrfqlfTsd0ZKtxuG25L+zU1tFN3bpCi66NjpqM+kY/Uhu1kCgtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzChkQrjcv7pnTwa46dApjM2OKsjlTBmiZpRQ/o6Jv4=;
 b=JPvuWtKntocCFNdKxAK7IRKhCWkVXIRq1nRfj+M5cMOfDeO0AhwSJ8UBLaabfbrrbF/NwK4ZbUpURE5/3sw0eTvzIpAx9Ap+9A7ik1yvxlrxqa9nFNunJgbyEbuipcg0bVlDJlai11mkIIDW6stjF2QMWWJ6jy4wvKVidartk0XK0U4qUkR6iFVsvNeQTaWwnBC5hMciP3iYTTfHXAl5JAul8VoOfAIfw8AbRoe7nS+Yigkq8P+1yoSkeJRI32UyXzimJTT4P0L/sut1r1R2ri+EFdXH5aORExU9TnOfmPEOrrerXKffgJSpidNo4NXZB+DtRHnFd6TMdkEEEqoAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzChkQrjcv7pnTwa46dApjM2OKsjlTBmiZpRQ/o6Jv4=;
 b=gAWCPVqV6yMVr8uYkX1G2cNNGEnEToMIldyhRogrogweYVuQQQt1Mz0ZiwZDXRiYPr05D7+xhd7TIpgMj7BTU1G6Q+T2D5ZJQ+FPbePq5R4HTec8O1GthPBmvVm6z18VrH4XH6B9fgoPqkCr62HpXMdSssxxftPoaI9ghcEi6oNMKeWr6AbgPJw/VnDAkKDaGYU5M+W5LICG2ItwWLhkxgunpe6cnir0CveArYqW0MKns7Y3uN5UucJLZoYYELBTCJDw0MI9vhZGRRU13iUqvY7KiMa3o34K8GWgvYcaNFlCh6QzqAvEf7goHs5QdDcz6sRb52DHSs+7AE/Am9gUrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:51:41 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 08:51:41 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 0/5] rust: Add support for reserving of ranges of IDs
Date: Wed, 12 Aug 2026 17:51:20 +0900
Message-Id: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQzW7DIAwH8FeJOI/JfIRCT3uPaQcwZmFSkw7Sa
 FPVdx9pOq1TxcnCv79ln1mlkqmyfXdmhZZc8zS2on/qGA5+fCeeY6uZBGnAgOU45MiFTd5phSY
 aZK31WCjlr2vM69tW11P4IJxXu3YMuc5T+b7OWcTat0XuQG2Ri+DArU5kZe9IG3oZlxyzf8bpw
 NbMRd4p+atkU6h66smloKJ7UOpeuZtSTUlABAtKhoAPSv8pK+Cm9DrLJQkmRQxu909dtrULfZ7
 aEeftFiz4Srz9H/K87zS64HVbWViykQKYGNBoJYQMHm3S0F5yfQu7/AB8XGuumQEAAA==
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
X-ClientProxiedBy: TYCP301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d78f90-b041-4a08-4880-08def84eed8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: QTQHln+Ky/jsM7O3nJ3PKEnOV0/wenF+auIMFDL8YOQXw3nJjvrOLSmUUHtAXlbV+h0UEY2/7m5nWm2BuQDRzMNgJihtG7TdmLMtd5ae3kGzXaboibZ3qD4Vs2ZCPKZqXk7lgEJVI3t73vQ5bvEqGjnMalWuc6n4UzA/KbrwSrt9AWhQn85SW/zYqCI49Dli+39gaqZt/DkyAWE9b43Si8ERgDLHF8hcVZtFJnuBVUiyvlvIE4psScLvckwPh+kBsc+X4/4HswY4JGYqExZHGYlm1n4dKKTE1XQp0AEen6f7uvQ/HsbaTSoZzlyj68oh9mSt/gow+hGPrrZmDQLSnYPe01uQT7toANqjhxruAGZMhJVPwSlxxtlUc0AzuaGgWTG9A/BYNHDbB+hK1CP+vKlhdShvkh7IyK8NeDd7naW7E9DEYA3UmqZa5FWAs4zbj3yc4MyNDU13GqicaU7Axm7qHIXsFXGw4G0BtreyWdXrzoqLdIU5jpkMjiRjU5GPRsnMc6Nc1Gnf/bEcQ0/emJ5wggOqEzDwOznd7nNKP7odDzYl6QCK70KjkLWMihYww6frzS/5j9jvzsTmP7KU7MJJtNx+/juiSfoHATC6OhcFN26L90+kkjZRqETki1sP2P6qEgHbaBtwx6l6wdHbxrymDeiQgDo+uW+Y9W7eBSoOmRCYRFNWbgqcEDeljRz7ChZTtwl9l4fRKVwouBIv1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtyL05UUDBmK0tyMXkvSDhKQXhVbUZXOGJHcE9RUjMvdUp3ZEFjSXovSjd0?=
 =?utf-8?B?bDl2ek9LL3hQSTBTa2hWRzlPWjJlTE1PQVliM3V6MkppQ1ZYOUpyNGd2aVM0?=
 =?utf-8?B?WmlVQUNGbWFoditMUmdjL1c4WlBwRkJjVk9lNmVhY2NHdDl3TUZDemVER0c1?=
 =?utf-8?B?dTMzejZFMElFckROVmxvUUhyNXFydmNlODNydjJKWEhycTlyQzR1d0pxVGxQ?=
 =?utf-8?B?MStVcGlic2lEb3EvTlgyK3JGaFFtOW94Qmp4YmJ6akRsSFlFdzZlY0J6YTNN?=
 =?utf-8?B?dXdUM1c4c1QyaXpyNHdBTVlOaVF5dVJ4TmFkSEFjVmN5NG0wZGpTaTBpeUFW?=
 =?utf-8?B?c0lJNHp1Tm1BTkttNWZLcDkxaE5vckRVRGxQMVJPSFFaNStlMUsweUplSC9Q?=
 =?utf-8?B?WjlRd3YydVQvUVE5TFltZnB5U0JGV20xa3pQRVk1TkY0QWtJUHpZVEVEMGMr?=
 =?utf-8?B?eDR4SFZOYUNwamV6NmVYQVUrRTdvNys2NmdESTV6Z3V0K3dabHo2YU5IVEpJ?=
 =?utf-8?B?eW52U0toM3RiOVR3Q2JGTnVJZkFyQTYxS3BQNzNiUHFmdEpXcU51S0FodXk2?=
 =?utf-8?B?VDhRNVkyVVZFQ1c4ZHZQZmo1dmVSZTdGVlRlWS9BczM4bnQ3N1J3VVZMNWFJ?=
 =?utf-8?B?YlY4MTdIMnRwOGE0NUI4NEl0NVpiV3Y3V1RXbkxmTnRLbkpaVjhtT0JTZGl4?=
 =?utf-8?B?dDVoY1ZmVkp5SkFmR09YekxDb3N2NS9mbEdGbm0yaEs1ZFpta1JZMUF6TzR2?=
 =?utf-8?B?cWU5bzB2ejYrZ3h3SUJoZXJwc0IrZml0eVYrK3Rqb1d2WFVpbGdlcFFLcklr?=
 =?utf-8?B?WjFoZmUxZklzSlJIbVlaTE10TzNIZFlEbHpyM0ZvUUtybnQyNm1CTk5UaG1s?=
 =?utf-8?B?RmQrS0NUNEVnVm5Bdi9iYWdRQkpOMVNURHV5b3VCTVFFNDhSNFhoeThzYjN1?=
 =?utf-8?B?RUZnQ1NETGEvdk1CelBnd012aHk3UGtEOWtyYXZmS01WeEMrSTdoQkxXYmJv?=
 =?utf-8?B?RHRkZEM0WFlCMG9YR2NjVzlKT1d2ODlhS3FxajYwWmNKQ2I1dStsRWV0TTlP?=
 =?utf-8?B?QlpGNnNDU05OZy8zOWdhSUFnR2Fyd3B0M1h2RGw3akhIMjBMY0owV2JIRWZV?=
 =?utf-8?B?dGd4K2c1SnNJbXFqQ3V4RG1Oek5wbVRYK2l0LzR5eStHNnJmUUV2QzhGc3l1?=
 =?utf-8?B?TGRKWS9mK3lldUZjdUVmdHJxU3UzS09MQWJ5RWRJRFZqNGp2bEpRRG9QeW9K?=
 =?utf-8?B?NjVmbXZYcHBGNXAwUlNXNEQzdEoyZS9CeHhRWkN6ODFLa1cvQ0NHVDNNUEhi?=
 =?utf-8?B?ZUJGVVRFQVZSRlVvZk4rZzhSaVpqcitiVHBnZlExN2M3UmFERGRoRlRsd0VZ?=
 =?utf-8?B?dkNEZXJrMk5lMXVxd0JiYm5NZm43bFVaMm43TFhnZXkwVlJKcERnQkNvQU5K?=
 =?utf-8?B?YmhCTnJHZHk5UEZFOWM5VU56QWVwcktFcmxCYlMwb0tXeTJsWUZXNkZCRUc3?=
 =?utf-8?B?dGVQaW5yeS81WnYwN05QZVFiclZhZ1ZQelBBMGFWeVVjMmMvYmxIZzhyV0VY?=
 =?utf-8?B?VHVxM2QwSmV3V2phVXhOdnl4MkgzcnFaWDJLbzl3cTU4TXh6bElpTWErb0tL?=
 =?utf-8?B?Z1l3L2duWWQ3a1Z6R21oUllaMW4yaEdMcENZNFZnQXRKbnVSaHBBSUwrdUpX?=
 =?utf-8?B?SnBPZVhpM2pxbWhwUjhHZjBBRSt1dUxiRURmd25qTFIyVkdrT21oUmt4VGhy?=
 =?utf-8?B?bUJHZWJsWEVCSUp2eGFTQnJ1bkd6TDJHQWxsOXR2ZjN6RGcxVVpVSnF3Y3Av?=
 =?utf-8?B?RmUzQ0NNTVpZWmpnS3BJR01OS2orZGtUYUF4ZmJzLys4T0lRbjEraGtTc2Vw?=
 =?utf-8?B?ZnIwMDZpQ01UcCtIZEllek5MVjh0Y2JRWTBMaExiRnlzVzVCb1BzVUxEWnVL?=
 =?utf-8?B?ajFCSFpvTGxEVWtCTFF1dElMWmI2T1RUVEtMaXN3cGN3SHNmRnNVQnBjZ29R?=
 =?utf-8?B?eHpKUXZXZDB4UXZwVGRKSHp5NCsvWFFvMDJ6SGY3cDVrSno4enJWaWZpazZp?=
 =?utf-8?B?eXJ0ekRYdTlBNDRwanRaL2x4QW5Lb201N1NoNWY4YVhoaGxodjNLUTl6cW16?=
 =?utf-8?B?bWxWZGt5ekpZb0dtVHU4WWptZjhPeGlRc0E4UC8vcTQ4eVJtVEJYT1Q0SFMv?=
 =?utf-8?B?UWQ4blZVRm9BempjTXRLamQwTkJrYWJPSEZTOVZLbjlTeTZoazlYSTVlMVNj?=
 =?utf-8?B?QWh4SGVRUWE5a3lSMmNHMGNPZTdDajlVUmo3eHF5Ymp6cWNrcEpTbUZBZXVZ?=
 =?utf-8?B?WUF1bkowUlUwT09UdWNRelFnQnpjbHFMYUxlOVVkWWhwQ2pFRjNpblRtSjRt?=
 =?utf-8?Q?tOupJUonialifFvtsxj5YyKR80dcBSpE992mD/qdTmJ77?=
X-MS-Exchange-AntiSpam-MessageData-1: 1QjGNs/ftb5frA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d78f90-b041-4a08-4880-08def84eed8d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:51:41.1184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fPaZCasJGWIh8dxac65KSEUF+ogVEJym6EIJi3Mt/Lm/WvAwKlBQErKc1912pF/lms0//aDPg+DptjFfFKcMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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
Eliot Courtney (5):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: restrict bitmap length to at most i32::MAX
      rust: bitmap: add contiguous area operations
      rust: id_pool: add contiguous area allocation
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 180 +++++++++++++++++++
 rust/kernel/bitmap.rs                | 329 +++++++++++++++++++++++++++++++----
 rust/kernel/id_pool.rs               |  69 ++++++++
 4 files changed, 545 insertions(+), 35 deletions(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

