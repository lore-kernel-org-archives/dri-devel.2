Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D7CC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D64910E54E;
	Thu, 23 Jul 2026 09:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pdbncyM+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D6510E54E
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq4uPQBRAvDPeIsQRg2Jbos/j2dgIcYmzL9S2MgBC2m3a+fJ/MMXxC+OQyKPbvj6xdzliNiKlmu50JrdUWttUFIusfwDEv65vadCP+5VZoD/P3z4URIOyG5DdEM9lX1ua89mxFanCDDUvzjCNjIK8qaisKxeBXsIz2QY2KrESLJBIi/F1es0rJJG0eF5BRgN2tjnNHzhz3i8nnY177xzSZXqhxBc0KA7OXPHdAxM7/LZKw+2xblncWNzJDLSejIKi0PugWM13GEJE+GG1CZDADj6eViUsP+kHVsbEwmCNjduUR/rkMSdOXSsRgkhQG+2rKrxFaYIuqzENH/uZeyGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc+VxFCpasvl02BZPQqee0qBh3/fYV+KBchzooU4Lzc=;
 b=qQN72KWMggJtt26IVt2GuH3RcteN57S8EVzH/fhrdqnK+MSdT5DFPhIob343Cg+CPYnzpD41pV8kCXoQnXIuAnniWqcIBQEvoTXG+/2kCrW8NZQ9VUv4SWnfrhYc7wWFUmeO9e9i9vTsyTmN0E92pkBw41xoHNKYuyM8bh3UA2QOX/l5I52fjSmdd/WhQPBE7CUHxmh0KBfcm/HDNitHgj7vjiqnJkNH4mmbijso59c7BQH49MrOl5A+vkydCAwKugUaH8sWijiyq05VAZy0Rax161Ebvj8IX/g0rCoQYecY6RSCruBAZV1muKkhpRgk2npm1AbQDhurDMXpOG/7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc+VxFCpasvl02BZPQqee0qBh3/fYV+KBchzooU4Lzc=;
 b=pdbncyM+T0gJjxcLwjlxkrjxeO7K9NW6M+u+qkoyAULwkxbDTS/LOMxiehl8HdC1mcX+BhJLFFK75s9NyDJrluiD4cbn3tHBdc6XhS8wcXeLq9V4y6ppag4sL5LbSIyB/esuz/HCoPyl1cxBqxuuRL4XlXJDfhvracTNQLE0r7PCESWbYxPGTbFduLnxjL+aAjnicdAVKkqdiegxMsu/id3+3G11cchNTmu8ruDajgJUoRAbqAM0n1mn2C2RD68mFDKcUKutYWOvnyoJDUKQixIKqnbaFHvgCmnH2IwHo+G6PzdQj5wLcIrQB/RcsdHHT/+VUuVAp9srxsG6RL/ICw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 09:00:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 09:00:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v2 0/4] rust: Add support for reserving of ranges of IDs
Date: Thu, 23 Jul 2026 17:59:09 +0900
Message-Id: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQ7CIBAFf6XZsxigiNST/2F6qLCVNbEYqETT8
 O+W9jjJvHkLJIyECS7NAhEzJQrTCvLQgPXD9EBGbmWQXGquuWHWk2PCjEOnWqudtrCq74gjfbf
 Mrd85fe5PtHPdVsNTmkP8bT9ZVG9Pnnm7J7NgnBk1opGnDpXG65TJ0XC04QV9KeUPmgrrKKsAA
 AA=
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
X-ClientProxiedBy: TYCP286CA0308.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 523e535e-70a0-47a1-d27b-08dee898e55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|18002099003|10067099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: hn7/sfA+a4sm6ocoaOzqBNHWQypOruDqgleI/TcFE8xXhUeiICoxYAwpFA7Qqf+Gb76Cqh2TVBZjvRUYtOTZiqxu5k0gbtwSGi0kmKLCrCQefzA8RCiAZDG+kPsJwi9swvW0Mlvtnh72o8GYQa2aPub5akY5aGv6Z6MoIXnQR9sslyg+yX72drGLVtL3ONNlS/pUslpOYyHMgYPvmLlsQEjL2O9G6zW4Ks9FrLkIIf8keELr2NHdO7+BoUc4rJK8saEV0mLw7kfk6LdFAMTjEeLZIi62rHDpJwn4RYa8A/p56IzhtfjX+yTedaSl7u0CNgNXdmYUfYh0R41P2CFs0+r1mkWkEBgZB44ou73vMI6yHMYb9GvZicQSH3k7eKwS3oaU/vGjUhquIPrwypBTIuFO7XnGR42uqvnUcqydc3f6ERu8QvV4bYy4AydnAJhYnFIK/jlVK93TC/S7C1RKLbcI7Nj6J7YU4kXXNDKsgKqMrLW3psoKTBDS6zGZI2FKWcdpShn+Q3aK8fXmiJhFdlpWiTgzo/65AAdFNONfd2mdyEI65RR0A7YHpt/KS7TooKt0a0BLzdfQIEMRVpSYw0jURjAUv0knBJG9/yHI2ovSiDSYu2z4vTwl73u393hYHd1DIlN06Xxon3u27MhLYvIbBa+8PPA4BSXCAeetv7LapYWJNwz5bonAi1YKb+xZaJdhVn44ZAgXZQrhmnBlnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(18002099003)(10067099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VMbEZSTmo2YllBdTQ1TjFMN2IyRGtwSkY3WDlWMzZxb01jaXVOM21abm0z?=
 =?utf-8?B?bGVLT0Z1SHVxTTVQUTU0ZUJLWDg2ZUpSbW10d2YxRUF5bEx3V0gzdVE4NUlr?=
 =?utf-8?B?RWZCWGRwVFJyUlNtTDZJcHpVWkU4bUdMaHlqdTcvMmhsS2tGZ1ZqZjVSY1Ft?=
 =?utf-8?B?QmRFdlEwM0IwZVZJajgxbEwyMDFqamZvNVEzMFhNZmpkRWVvZXh3Kys1OEFx?=
 =?utf-8?B?Q0lvWmgrdGxGanpOT3NEbHdLRWtzcDl3MmpsOGpCcEliSGxkVjM0ZXM1VlJ5?=
 =?utf-8?B?RmhBQ2NreUZZT2JWMWhIT2xsK2tIU08zVjMxMGRyUjVReEhYVHpwWEJrbFJs?=
 =?utf-8?B?eSt0MXMvajhiaVltbEpHdHNHZmVDbUJXOEwvdGlyczdDem5mbHQ0MEJHRzdX?=
 =?utf-8?B?UEkrcTZxTGRwRk50U0F6dWRLUkIvNndqcnhoQ2ZFV2tDa0o0TFBkMW1kMCtI?=
 =?utf-8?B?d0JDVnlQMkxlbElnRmRwNlVULzZMTGZGNDBlT1BGaVdIb2VlZnYwcFk1TmdL?=
 =?utf-8?B?THZGeXhQRVA0anpoTnFVSm1jZllqNW9relhyWGY0cWs3YnhJZDBHRjVoTmxK?=
 =?utf-8?B?cldZelZlYW1FR1puY21MWXZPU0FQeUZONUh1UG1UbW1EUzBkK1hFd09VZkQ4?=
 =?utf-8?B?Y0xzUmdrK0VFT3JobEFVaEJKS210UTBRcWE4bitwNU1YNTFydWFjd0ZVQUhB?=
 =?utf-8?B?dTRHWTQ2ekoya3NlK1M5WHJ6NGpYcFo2N1Z3UXF3amNkOGhrcTlBSWg0eDdO?=
 =?utf-8?B?TEN6cUdGakRzeWxPTjhxSWF6Y1FybmY2bjJaNHo0bUdicVNBZFdJQis5ZnB2?=
 =?utf-8?B?c21mamNhbElWaGtCUHNkR0ZwcFYxU3YxYUZ4VWZSdkl3ZElnWWk3SlZQMWtR?=
 =?utf-8?B?M21aM1liUXB6TGt0NUNlMDhST3h6SWM5L1hLRmVtcTFkdkhlMGtXY3YySlNi?=
 =?utf-8?B?OFRrVVVXeG5SNjllTVA1cU5qSFBTemR6bVlQdVRRSVUvOWlHQUNRTDZXWXpK?=
 =?utf-8?B?bUNJUVBJdGJJZkJSd0VNME9uYngzZFRLVXMxZ3FJamJKR3VtbzJkNUdEUFlj?=
 =?utf-8?B?dUtRTitLOUk3UHBrNCtlaTJPUElXeCtSY084NFB1NktibG9YSVFvZWxVd0xr?=
 =?utf-8?B?WWo1UmIvaml5ZGxQWlgxeGloTHNucHpqWmZIbmVSN1ZZS0k5Z0pyd0RqemNC?=
 =?utf-8?B?VUc1NlF3NnloZUdQMURoQ2FXUUkzS3BObkRSSHV1SXZUUVVHZFVCbjB5TjM3?=
 =?utf-8?B?dnNYckUzNjZJc3BVemJtZjdVeWl2eWxDSHFPYjdJUHNtUnFKR2FVbnJlVjUz?=
 =?utf-8?B?OVhSUkVTZUtIeHlTZzR4aXErY3IwNHRRNkYvbkxjaHcvbml5NTNPTGNCTU0z?=
 =?utf-8?B?RzB3Y005L29Hd1JtUjV0ZGRWUmlBbnBPVFlCdzBkTzRmSFlCM2gxQ3F2RzhE?=
 =?utf-8?B?ZlpwTVV4QzB6dHMyUjJOU2dLSmpBMXN5bzVBWjhqRk41TEZmdTU0VWVnd3BC?=
 =?utf-8?B?SnVRQnN6K3YrdWhzL3JOTGI4TFZQMmdwdTkxVHBJb0J3QzdvZ21hQVdoa1cv?=
 =?utf-8?B?OUxEdFBMZktOLzlhSHNZUlltejRWMGNSdTJLZWNjVzRuRkVqLzAwdE9wNXJy?=
 =?utf-8?B?OGJEempBcmlINDdET0luek1RcnNmSFRhTkZiY2RPakhqMFpHaktoSzF3eDJn?=
 =?utf-8?B?YVFVUExPUXVpZGVheG5yVkhISEFITW1Cc09Gc3NnNTRMWnZYQzhhT1hFa0pm?=
 =?utf-8?B?dXRydFJQcW02QTdhajl4VEJ1ekdlODkrSHJDMHJpRGFuTi9DSVh0Mm0yalRB?=
 =?utf-8?B?eFlOSUxDNlNPall3dGRGS1NSd2MyTW9NaVB5MTVhM2hrTWJFdWNwYlkzaE5B?=
 =?utf-8?B?aUU1RmVha1QwK2lmNVl1akFuOG9YUE4xMG9YRlpMOUpka3dJdkRxUmo3c0VC?=
 =?utf-8?B?OHJPWmdwYUtuVWdLSFRHQkUzRUQ5K1FkSUdHWXNYcTgwa2xvaUV6NUdicTVk?=
 =?utf-8?B?RlROTnZZTVI0ZDdqdUZzMjlkWUw4NlVhUHovblA1VHNXdkJwUFNaaXhJd3l3?=
 =?utf-8?B?K0N2T2JZakdVQitZWTR3MFIwQVdDVERXOC9neW1MWDlmVU8wOTNPWWRSVGpW?=
 =?utf-8?B?Rjg1TWNabXkzc3Fucjc0UzgvN1RURnllbXdHZmxvSjY1ZkE0YW5JUzYxL1RB?=
 =?utf-8?B?STYwclpxYjhHbHU4RTlNUUhaek5UNEJJT2JNQTdnT08vMFNmeWpUWXJCcFRk?=
 =?utf-8?B?ajh0d3JzZnBXdGN3RGJodGJTK0pRSmJwczRKZjFrV2kySW9rbUovcnNBeEZh?=
 =?utf-8?B?YzkwdmJwQVl0Z1hFTHhsQUNVZUFXYmh6cGI3T2hNaERpbDRtRnphb211dEhM?=
 =?utf-8?Q?s4aEMc2KgNZuvmU+QZPiRmDrmLTpUKuewN7/gc3+d2dyb?=
X-MS-Exchange-AntiSpam-MessageData-1: sSVe2evSyGNozA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523e535e-70a0-47a1-d27b-08dee898e55d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:00:51.5185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PShhOgper2BXeWG4y6bDCDbijP9aF+CZhNIs70iDN72CBFfHoIqCDp+YHaaOb0viKpd2+37VE1VcejDNXj+NGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
Eliot Courtney (4):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: add contiguous area operations
      rust: id_pool: add contiguous area allocation
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 182 ++++++++++++++++++++++++++
 rust/kernel/bitmap.rs                | 242 +++++++++++++++++++++++++++++++++--
 rust/kernel/id_pool.rs               |  69 ++++++++++
 4 files changed, 481 insertions(+), 14 deletions(-)
---
base-commit: 71d4e7233f235871b13553e504e591ace6b54373
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

