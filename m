Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E548BC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2775410E02C;
	Wed, 29 Jul 2026 06:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2wPpmg3";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6C410E02C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u30iDAwVPGA6jPChRvkXhFl6KNCSuQxlxVvoLM3j9Ts4jTEm8OvuyjNFIg3WWo7gAZH7O+h4iy4lfKSI1SOl/gX65+7ncyBAldhcoB4laClf0juYcdEWRZLyNW9X5qMv+O7NC6FbhKkbzmZ+h5MUk6c22rvPt5muv1bh718STeoA3l622AgQe3RQujTBNDNiWztvo4fRGQLJcMh0MAt8jQli1STY4Q3j9uDaLRI+RbmjV6gBxfOwpul8i7v1zyl95S0MjUZhD2Be2viOP7SIvCwVVMlGgFD08ZN6ObmZj7jZ08pqZXeZAFLG2nRjmZG0PFMbbm2Jj4qCTkAeGkLkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JYhpiUOAaBgtNNpm1XTSDgq3/8oX2SLLugeV7mh1Pw=;
 b=tX7PVEqxpuaQh01EbCENeCMtrThBpAvglP5RrjriyKBTBrM/iO/Lz7HwcfOqzzp/8JbWAN2KyR5g39RjEihbdQn/M9VwaEbG3VYVdyBwt+ruNJkqmHymtOiEWdHuC39EaLQ/aWlmHLUuxoA32PdvV0ef5jAsMj/ZkSY/4bQOuW2sL+/XgWqhERuThjxzZbIKKwlpqZrHFI4Kq9uYl9sKrfAylkO8zwhvhhaf/chPN8JI4rsLOIHXFrXbLnYazzWm+qxD8P1R+sOn1k3PxnQmTRoPRQW3JEr3WTDWNEgbgSNWjQZ8jmsXH/ZycyG9OaYRvaCcmBsMaYacEa3Gnl8pTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JYhpiUOAaBgtNNpm1XTSDgq3/8oX2SLLugeV7mh1Pw=;
 b=g2wPpmg3kKkdx6cUBfahOr9RX2rweakwGDm6eg3HRmuSt98R6eyWAKGbOuqqVG6FeGTSwzK+3LAMsqEHEXWJrtr53Mlqkbb+TMXfpEnjojTfOlX2l8tN4WNx6+sNiNlg63q+JlSHhRSOY7yLkd+OU0JxmtOiOi2IkaOOigS7zIzHgiXifGDnB+o9L7xlubAbMa+gfa0cCy+nE9SZZzxfhGJcl/SsRqsyr1BXla1Y3PpwoxSCCruS5cMlefF+9kJSby0cTpCjUnxNdj+Uj8p5Vjtn/rRzRH0kkmvJoUr7ieleT1BjVjb+ouZyPs1QNTJRah15CHxzAa3DDzzcdud3Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:54:22 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 06:54:22 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v3 0/4] rust: Add support for reserving of ranges of IDs
Date: Wed, 29 Jul 2026 15:54:11 +0900
Message-Id: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ7CIBQFr9KwFkOhRXDlPYyLFj72m1gMVKJpe
 nehjYkuJ3kzbyYRAkIkx2omARJG9GMGsauIGbrxChRtZsIZl0wyRc2AltbKdboRRlppSJ4+Ajh
 8rZnzZeP47G9gpuKWxYBx8uG9/qS67LbkgYktmWrKqGocKN5qaCScxoQWu73xd1Kaif9Y/Gvxb
 BnRQgva9cLqP2tZlg/0SXvO4QAAAA==
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
X-ClientProxiedBy: TYCP286CA0222.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3b186e-a42b-4e2b-3ec5-08deed3e3854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|23010399003|366016|56012099006|11063799006|10067099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: /Lv4i4wMFaBz6L3PChAELwqi/q19DLtaBav1K4K2FnvI+4B3P9MXo6c26AioFTuV4E5VVn6wgwYKSOp7O2AMlhuf50yPHJemZmIv9iMmBsheOoUGy/vNzEnXzMpp5ilPHqzvDQcxunZuUy/k+GZ1+EBxXh3uu7FhjjhSeDU4b2QohuueqK+T2JtAJHw1+DglaACby7Xz4Rhz9ebILsjzg31Ab9f60zrwrVWBMNNP8RoklkbXjYUloKbzhqfXNcm5+7IevL3EJJHEm4bqmAMtdrOKE6sykyCzNlU2eQYqENBeB7m59/BTaxFThK/C6WIEQWGKMZn6oMmHj9tmtm9lWTPkwMH37hNFMBFMdmrNtdhB8vO5CcE7FuLvAQ7zgLe5822/RnqGUoG0F8BggKPdIAB4+ipEupVYM3+FSaVOzjuu95AzAFY0HHIY2CL2okvYSlJZ20OF6TcO+Zp2LW5CEaPgqVTEkiOiZLVgjWV5aBfDHfR9LKPtWU3XSoxC2HNEOpSWad2/23SOBf1KkTLl1oKCi5hHudR148Chty0AJzCIEvzgogomeMYGh3h1vXW3egKosLVCOaiFyCzdVUeFl3t3ABmjEH1mmXEDf8amYMLWV9WqD3MqGP54IYG/DaMyqw6/3qbaxaA9xR/Wt0r38Idw5aS0DCCf6pZm58BA4ZogaaMsUY3MpAUl16De5JnoN5URTZlJh6MD8r7BLU1a6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdoaGdCRGxBR1gwWVptcmxtMURWa0dyNkIxS3NBRjJVeFJDQzNlRDQ5SUtr?=
 =?utf-8?B?Rk5aVGMyb00vaWlCMmJ6bzVXbEVEQjc5Wm01UzlEZFp0NHEvbVY1aVJhOEkv?=
 =?utf-8?B?VGw3dzVnZG80cTJyV2puRThEbWJlRkNXS0RUT3pkYURFckRud1NjcklIVGlw?=
 =?utf-8?B?UHRHaGVhdWswQzQ5TlpGZWVlYWhEdzFtSEpOUGRwd01QU2l4T21ZeDZrTzRx?=
 =?utf-8?B?MDdwRWlVQ3owYmNzeURRTEtsTkdtVExFcG9KV2RVMTltVXZNMkVtT2VNKzcr?=
 =?utf-8?B?N0xuUk4rNzBqc3ZEUVRHeFpMaXdlZGk5RUtPbm8xM1ZPT0VBZjNaam90VmZk?=
 =?utf-8?B?YTJIa1dPM0lKdHhEUk8yeTN6TjF6Q1JFRzU1aWl2K3BTVUxMbnkyaG9hZlJy?=
 =?utf-8?B?ei9ZVEw5b3FSVk8vcEM5YmZjRzUraVpieEZOc2txYTNUejR1SHRrRFN3aEdj?=
 =?utf-8?B?TWZIQnFnS0U0dUdIb2VCTzlCdWprODBxK0JTd3lQOGhnS016WFlhc3paSHdM?=
 =?utf-8?B?blU0ajN2VDdFWXBocjFUby9hMEpHd3ZsalEzVlBob0lCSy9FaXdiMzRwSFlR?=
 =?utf-8?B?MTJNaVVlVy8zUnRUQjlhcm1ndnM0N3R1U2ErSnpDNytXR2ZpWllsTUxPZHRr?=
 =?utf-8?B?azdmR1NkcVEwbVIzVWFUdmF1V0diU3c0VWRWck5xNmp5aUVTUWNEOXNVZ3hH?=
 =?utf-8?B?bis3MHlRNVo3OXRRUXJ5L2FLL3BhdUNtdHN1UnZmQysxbm5WcUtORnpIU3Fv?=
 =?utf-8?B?VEdOMVcrcDBVZkJNRGpvUFlONWg1Q0NsN3h3ZEw4VW5EalhzMGFteDUvN2JY?=
 =?utf-8?B?U1l6OUgrNjdjUzllL1AxTUYxcWhJMHc1cE5aMXNuZ1R3WXQ4dmtCbFpHZGxm?=
 =?utf-8?B?Q0Q0aUxRR0hkWm9jY1FFaktYendpckVjd2xQdlJLdWFxT0xJZkN6cUlhTVFX?=
 =?utf-8?B?UXNwelZ3VW1WcFA2QXhEU3BmQWM3UjQ2aFl5Uy9TUzIxOTJxeFNMWnBlWXdX?=
 =?utf-8?B?YUJKRUpQaGw4SW82TnhTTkJCRXYxUWxhZkw5VDBnY1lFeTByMDhyUHk2dkZ4?=
 =?utf-8?B?YVdmemtxMkh4aVZJOXlpeDdDQUhqT2Nja3Y2TndwTlZJZjZCMHpqRG8xMnJC?=
 =?utf-8?B?SlpEeTh1clMxWi9UYnBDaVhXbjVrQ2w3SmFTNnVqQ1pRbS9iOHc4bE9KQWh5?=
 =?utf-8?B?dldPQ2VMTmtMbjE2K05CK3ZmRFZCSGtoMldMbW9iRHpkRVVwMjhESU5WTDZZ?=
 =?utf-8?B?dHFUVjRuSXQ3RnJaeXJOWHFBYmxBTEx1VjZ5Z3AvV3QyMFBrSVVaWFBxSFZ1?=
 =?utf-8?B?dmR5R3VJU3RSOGN0RnExNVpxLzdDYS9hMkNTUk40RFhIRGxwRkJQc3lMVGVQ?=
 =?utf-8?B?RG9TUjBDWmI3alNqeUphZXJXMUI5WVQxM3Z1RVJXT3krVFdyNmlpcExiRXZT?=
 =?utf-8?B?ck5qbDFKakphSHRPTzNqUEFLcVFnMUVVUEpUOXBzYTBreHRoM1F0NTVPRFdz?=
 =?utf-8?B?V0JxbjdRQUhxc0pSOWo4RnlXK2ZmeUphREdybm9mU0NuVXE1Q1B4ZGlPRnZL?=
 =?utf-8?B?dEd3d3NJbVNDaTdiYlpWUWliaElmU3lzUHMyV3ZPUHkvZitCanBBZmxSQXBt?=
 =?utf-8?B?bGFMNC9KRmlTd3pLRzJLaklqVmY0T0M1U244d3RpZ0N5aGpaNFF5N2JyZytK?=
 =?utf-8?B?dTd5ZXRBMUt4dlRpMFRWdnNNdGVzWXFlNzV5RFRUcTFldHJFRkg4MjN0SUFR?=
 =?utf-8?B?Qm9DbSswZ2FsVzFEb2dMNFk5b0NpeDEwcTdZeGk1TnZ5bm4xSERvaVdIRW44?=
 =?utf-8?B?cXNWZ2kxZ1ArR1l3eGtIRjgwa0NXTHQzbjJmQWRmcGdEaWE1VjJHczZ0blBN?=
 =?utf-8?B?UmVFYUhaZGduRVl5MjBNTklzcVM5cHR1Y2RiWnE1THd0eVErVmo5bUEwTzcr?=
 =?utf-8?B?Q2JpQWxub0ZDeUZmQkpaWk5XRThSS2FwTElyNUdUbnJ4MnBGL2RWMC9YWFMw?=
 =?utf-8?B?TDJ6bDBZVkpxK0l5VGp3c24xalY4cW9WRzNubUFONnhtREs3eW1uRllZdWx3?=
 =?utf-8?B?VVl2OUlNZzhYa3BNa1hXZFJHZjdsblFuQm0wNDRQaHc0eE0yTk00RUFOeHln?=
 =?utf-8?B?RHRkWThaTjMzYnN6NFgvYlpuelE2bzBRaVlpMmlJYjZIWTNuSU8zRXY4dk51?=
 =?utf-8?B?RWlXN1kySFdnV1pWa3dKVHIwaFVkemt2Um5wWnVZUndGNXFjVGtWVkNiZ2Ni?=
 =?utf-8?B?WW5JRmN5Vzl3Y0Y3YWUwWjUxaGgwRDYvM1FTMW5UMmc0V2JHTi92cytrTmNj?=
 =?utf-8?B?bkRkcWwwdkhVV3d1MjZBLzhsMHkwR0luVk5VbkJtOWc3V0lJcjBuMmRDSjl6?=
 =?utf-8?Q?eShio33Zvj5Bq6LAze9n1iPXcdx5D33uQxHbvAytypOZw?=
X-MS-Exchange-AntiSpam-MessageData-1: DEGEMZNAlfInLA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3b186e-a42b-4e2b-3ec5-08deed3e3854
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:54:22.4861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXU/kEhU08ATD7wgWOMRvQohsmXam8bnhH950B18Y/PtYvUgi9jOdA7QxDjuQ2/r+1+23ysRUaGSrxhqax2RfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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
Eliot Courtney (4):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: add contiguous area operations
      rust: id_pool: add contiguous area allocation
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 180 ++++++++++++++++++++++++++++
 rust/kernel/bitmap.rs                | 219 ++++++++++++++++++++++++++++++++---
 rust/kernel/id_pool.rs               |  69 +++++++++++
 4 files changed, 456 insertions(+), 14 deletions(-)
---
base-commit: 6dcbb4b1320fa91fee349462a52bb69135f2e45e
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

