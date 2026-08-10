Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08887C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8E110E1B2;
	Mon, 10 Aug 2026 08:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="txnKpPDd";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B17610E1B2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejb8awAeFUe40Qd729gAJX8tzJ+lmRAc85qNlnDchQdll+cYvpo7sqcFmacEKLcodt9xW3obU0nCEEVdtfsIAhkoOqMVjCUJivMHI0GntGLI00EEi1OaNJJZDslg3kYu72HLgRyeA0U7PdSXoOQUz/TYF6VVWKShyBYBtpbu4ErTqyFSKnHUCXk+WwI/hh0GEKxZmjjORZqGqFKHZO2zBgH9C08WnzdYc61uURZTNkxZAfoHzjmfI53+RLTbG4oWK+f4o38lsFs0uCkUrRGG7EVRrHNdHBGvoFz+p7zoo0v2nuPBmMWkzH1LyXbrfMNogN4Mdy3v0IyuVGhGN5eXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPYD/j1Rt/KO7Fysgkeu8ECXLR4fbGiMI9Uc3EwRb7Q=;
 b=Tj9b4eEsYxC4Bi1WSY+2K6mId7T3VFvaZdHODyJTJxZRHJL4yprM/ZJdSE7HifJFZ5K+ayk9WY+mQu/yHJeZwzsyrPXLh/Wkwu9FXD8fOzU1ASiUbQ4BVRSUJ6SYUMCn+whrJhmpL5XmVFiGXaShEyhIrnftRpkkFM9ld/P4xxUufGG9Hrsrn85AZ+GrxAIkfjGotiQUe1D1qY5OXebHPNqBxMT8zhn+Ont+nB/Qo2sYC+qNfPU9DCgjrcJ2WqWbA9a3CmpLE0D1pIPm8ev88yHqQS6ELmF6h9hqLmTJjMcJrSz9PqI0zyWUKOwporLw2l7wq/QEBHGx0vKIwFOBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPYD/j1Rt/KO7Fysgkeu8ECXLR4fbGiMI9Uc3EwRb7Q=;
 b=txnKpPDdqvJBhlo3UwbxgJmpoBtQSdsmzoGYA8AepipYTyXqXI1GgdGqcBQP5fjupbiuXI+htHS+6oKZc10VtdFH9Xj2FJTiQuMubYjCcOiTSsBG3PmmSNqLJdtaysvE6AlGRBJsx/mVvazOMQ3pSMwZPBBLszHo+9qbfaAs439OL7GY2XVW9k3zbZLwTUk+4Ypxlz2/iz2mldWZG0VgJ/MBpRgszgwAc19e7x2bBa/gxVXwJy2rnOpMF88NebZ8LnpWJUxdc8qGRzVAEQPgn7rHJ9Ct+asiFL82jbdPJ1DhKOZdypgMrUEc4/Lud8IXG2hEGNiwN69MDuELZ7WkSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:35:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:35:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v4 0/5] rust: Add support for reserving of ranges of IDs
Date: Mon, 10 Aug 2026 17:34:08 +0900
Message-Id: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WQy04EIRBFf2XCWgyvRnDlfxgXUBQ2JtOt0EM0k
 /l3qwdNxhhWN9xzoOrMGtaCjT0ezqxiL62sCwVzd2Awh+UVeUmUmRLKCisch7kkLl0O3miwyQK
 j6nvFXD6vmueXkdspviFsO7s35tK2tX5d3+ly7w3lg9BD2SUX3JmMTk0ejcWnpZdUwj2sR7Y7u
 7qh1C+liAI94YQ+R538P0rfUv6H0kQpASCc0CpG+ENdxgAVP060jm1MxWJoyOn+WDZaD/gYDH1
 eOnQJo7ApgjVaShUDuGwEnewnkl2+Adsa3wBjAQAA
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
X-ClientProxiedBy: TY4PR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 48919c05-a0e3-4cf3-d60e-08def6ba58c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: TSG6V81eCFIeTWrh0qOY/LXsY8ry4thF7Bz5cIwYXcR0tFIaVPGZucIUoSfxZm1aGnt84AosSjWj6wQjZIKrdG5bYZqwGl/8UG24JFpIhSz7OwbfRm+utLsPWioLPAEJUvha59xI0NoonuxbhH1XDESZYP8EzVWHZRsextQvS0Wv9Ox8StnrjZuiN+5d9Dqs7fxBZDGGZ+c4OBYRdzdgaKFkUqGppnSEzbrTUtSHWhqLC1mADfILBflvjvJ8h/kDEghybi9RLHFDjxGf9vZewG/lp6eqQa680Wm0/glptrOzHnfPGpIIQ3Tik0Vf5lgjKLF8ggVk2PvHY2nwzA4bIaUOYTxWqoG3cPwjWl6Yh8zdT4n/GOKirkPn7+4ozuWzS2lnoi+AXUOg0GeZPQtoDM+F/wkVcv9lQbFCTGZCLtSpLqkED4DOEcs+DgqizNUdp55Ru8zeZ6hhbLm1bf48DmZCtl+nulmmNTMTn7/gd7sE0hIgpeqw8QnrgmCR1Ft6nEuk4IoP4vl3AKTBkZ9G3j6WrXQ+tImKiTOnaN27yzlJjMwlpqrWuqtussCA9T+4Tt/rXFz8ULt1s1ALwS8/Y43k7sf9xCfW+U/O0AZ2ZZIVSBlSsJCvVgY9J7b+G5FXV7HmGQEZ1EWe6wg6r9uTjfQjoZ80hTtZXotqezRrHlsUHg/5f+kOBkSPApuvBahfMzpGL2uvrHQh+QeZQFHsJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm92emdvanl5eUlVV2tiUFFOZnh5ZGtsa25ka1RUcmxlUG8rWDdmbitCVDI3?=
 =?utf-8?B?UWtMeEQzbFVORDJwTW5sNDR3bVlEaG5POW9QNDdBZ2l0eWwrR29PVmx1ZS9L?=
 =?utf-8?B?Z1lwOUpPMHN3R2N6VDBpaDZsOGFZTHNjZkVYNzI1Nmg0dGlUQ25sOU1KYzZH?=
 =?utf-8?B?VjFKd2dIZ1ZXZmw2RjlWSWNhV3NXMEExWU5OU042WE80MmtwbTU5NzVLQ3hh?=
 =?utf-8?B?dXVCWEs5TDI1N3l5T3U1dXN3MlFHalp1SzFEK09ycjFZVStySVg4NUhpa1Q2?=
 =?utf-8?B?U3RWbFREeFYwNHNjdWJva1kyaGYza1AybGFRclYvbmRSbTM5RTVkZHpEWUw1?=
 =?utf-8?B?dzA3NzNyd25UcHBCZzUyYS9IN1k0V1BmUjU5REVQQXJSekx5S2ppOEtNMHhW?=
 =?utf-8?B?VjF0WXEwTHR2d2RTbVNyZklZbUMxdTd0NkNHOEd3TW1najk3clFKOHl6SDh3?=
 =?utf-8?B?TWZtdEt5c3hlb3lrRE5iMVRvemgyUFNuM0JtQ1E4RFRGKzhkSjlzWnVFMVha?=
 =?utf-8?B?Zi9iYW9CQXpkQnNoUXc0dStYSjhDQlNTMFNiNW5PNUhDTDNmeU4reXNxdWFj?=
 =?utf-8?B?L05HKzROME01U0FzOGNEb0k4cHA3OFpBcXVXazA1UXhJbDQ0bVc0bXcvaUZK?=
 =?utf-8?B?eE5HZWRiNkI4dFowSHNvQzg5Sjhoay9pdE5Gamd4Q01wei9LaTFjTHh3RUFq?=
 =?utf-8?B?cDhYQWlJd0VCRWV5SU1ReWFaMVdPc1FpRmU1bU5tR1ZGaGJBSVJKdjBxa0Q4?=
 =?utf-8?B?ZDl4N1ByeWFoV29NRGlzZFZvMDVpQnpUd1pSNTBNaXlyRE5lK24rVFA3NWNG?=
 =?utf-8?B?WElvS1lmNldNTzNGWFpRR1pZUWUzYTJMQk1YNUpLN2lkaC9YeTVvWE5XWGQ5?=
 =?utf-8?B?dXNrai9HcXNlazg1UmJiVmxYVmppWDdxajZkZU1GbXFpcXlLV1pEa3haVVpV?=
 =?utf-8?B?VlFQSEZLVm4vdGNzWTMxTGh5aFFZWlVLYi9rNHlwRWJqb3laVFZFOHovT2RU?=
 =?utf-8?B?bFFsTmZlbGI2dW9QMW1BeEdWYjN2SW1RQ0taUXVyczNiM3FvNUNDd3QxY00z?=
 =?utf-8?B?d091U0JFdXVSSjZmVmg1VlRpbExrL3pnK210S21BUno3MjZpVXEyNkNadWdn?=
 =?utf-8?B?MkRKM1YrWXl1aEoxSFAyN3g2eURxaWdieWtBeGpZeFNiT1dkbUlGbUNKeHJj?=
 =?utf-8?B?QXBNVFZMd3dyYUpIZnZSN0lWY2lZdlFYRUFRdG9zQndMOUlRcHZkNkFVZDE1?=
 =?utf-8?B?a1hJRnM4WW03bXFiUE9pYXdTcEl1eTZBT2VXODBxN25sNWROWWJUVFJiSS9N?=
 =?utf-8?B?NWh3ZnZYMjE5NjV2ZkpicUVEcWs5NkoyNzFwblNqcTBmMmVXV29rY0JrME82?=
 =?utf-8?B?WFkxcUc5emtweldnWVFVWjhhcnJub2hYUUFHc2pNUE54dDVkMnU2Tkc3Ymkv?=
 =?utf-8?B?enp5c0RzemdMY3daY0ltd25uNzMyVjJVVVh0U2JCWGpRajBoSGxCV1Nzdmtl?=
 =?utf-8?B?ZFljUFRtRWVvMFJhTkdNSTczWkdTUFQzSHEzTWJ2YUNibjR6cGFHN1kyNkRn?=
 =?utf-8?B?citqbW9OaTBrL1pRempueW43Vy9wajRUODBnRHJBc0hmTVhGMzEva3BFVzZp?=
 =?utf-8?B?ZWVyNnRWMkNiTUdVUUUrdkRDaXFGVk5OWTRscjVMdmVEblpocjhpd3paTDkx?=
 =?utf-8?B?UVJPVC9hMVplallhZ3pVVkY3aFh5ekJKZFY2eUJmak85M3NmTVdRczg3VkRO?=
 =?utf-8?B?aVpKUGgzS1NNdjR2TDFGeXZKcmhIdUpBdU1zQmlHNW9JMTVzMm5iODF5Unox?=
 =?utf-8?B?b1JDVUFRVEpBbnJ2anZiODIxVE5lUDUzOWZkT1B6aG9uL2k1L0xzWC9LSTNC?=
 =?utf-8?B?M1E3MUxxTHE1SFplczZLaWo3NG9XUngvZ3B1VHB5MDZHdWlYeG5IMURVTWVj?=
 =?utf-8?B?NkI1NjhIZzNBT3MyMWFwTVNOcjRhMUcxYWRUWDc5dkZSRjFaTlBwRVIrazFw?=
 =?utf-8?B?aDFoZkxscnZxakJkeSswdmdkeUxsSUpib3orVzM2QjhMaW5pZ0NVREFDVExF?=
 =?utf-8?B?cHJ6dENxYUdTUnhoSzdYM0psdURURFVWTTVhc1JBRWlYWStMejhiK0JxNmRn?=
 =?utf-8?B?VjU4R2l3NHZzb0hOK3c1TitVN1doeUFZZi9wM0h4dmF5cFRpdHB3RzBReThH?=
 =?utf-8?B?dktnMTVOSU1xeGdvWGZ6VUFHQmYxNUdkU1NOZnE3OUt3dTNSYXhTN1RBNnFL?=
 =?utf-8?B?UmU0Q21XWmhKOXA1MWZZWXhyYzBnRCtGVkZZUFZ3TEdwa0h6RXYxU1hJYk9G?=
 =?utf-8?B?K1lxejd5RUtweXVYekIyN3F4YVIzRHdENmhTUlpPVDRsdnlBdEdYYUlmaXhD?=
 =?utf-8?Q?reCgrYKICc8MMM4VEz/j1ENWkL+JhofFVyVfez2kWVyzB?=
X-MS-Exchange-AntiSpam-MessageData-1: qXx40dB21s9eyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48919c05-a0e3-4cf3-d60e-08def6ba58c4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:35:34.9334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLS/KY73PeSUIxX9OS/WJiBy7r6iVFO061Zu5Lmgk1kBWk4KZyT35OZddzqY3YVNx3+ZLGDQJFoWHtEXcQutgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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
 drivers/gpu/nova-core/gpu/channel.rs | 180 +++++++++++++++++++++++
 rust/kernel/bitmap.rs                | 268 +++++++++++++++++++++++++++++++++--
 rust/kernel/id_pool.rs               |  69 +++++++++
 4 files changed, 504 insertions(+), 15 deletions(-)
---
base-commit: 4c9ba407018e8deb06dbc643112bac8f40404f95
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

