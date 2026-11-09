Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4F60A2611
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AdpRzzJs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EED310E578;
	Mon,  9 Nov 2026 08:33:13 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F8C10E578
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivgGWMvowMaihdDP+nCaT5pvz4K3SIlM1x5bW0qWXaMoyYX7sBeY9Xk4Yc1OxaEGV16ioAHtcBea6qOxVaoJn0K6lB9/+Iu69yI2AcwKfFOUNwYYPDwKJrWqhD1bhVyDmlIjRgIcZUBexHonZJulpJllzYjU00Pu4nh6FsFB6FO839Q5XHl25qVeifHHTz81CiGqOWU/MI5sy6kbqthw15OZNb6Ly6cvXLfF8VEYeJRfE6kHrhT0BRSnQwm04aG9wFJrgKJwcTxlsGias2sdzPVwKi3eeAX0GIi0IRBAghikgVp5+w30MUgP3W5m202v60wzx6JOLeHz4vohywcCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSPRTO9raLr6rk/c2YZED+9nl73SatETp2FQOyiWX3Q=;
 b=NwqVEuKJ0MomSgYe8JCY46yNKt9M6kHLRM+pwRaqWjEI5X8zACIQmMrZUPvOweELmN+x90fsz4TcsiSJwdw0rvm98O2Ma0IIu9s9713Jr/A0FcnaXS6X/XGglOsrx8QcHkNUw22L5jbmJg7jzKFxH9TT9y9Oxw54V2XLJUZl2MByoNcWwtZ28Y97Jg+XAn5KJ7mNKvff5FwJiSBc8g0//wrrivPX3ugt6KjFH4m8Bnb2+a8d4FmFqI85eWpMR7nbkXXRPPyR7mjoQ0atSISlaQwwPHqdwWZ6yaPuk5A/w7KtuuBhRECr0UZEHbQKpC9KkP9zKUJtf7ivUqVmLc58OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSPRTO9raLr6rk/c2YZED+9nl73SatETp2FQOyiWX3Q=;
 b=AdpRzzJsxYkoBZfHKA6f5BXHhXxJFmjqgZ8QgjYEn/pb0DnPLu1zKqRdRSv8LC5et2trOt812ftHf+TOoj6DM8JIQrRjPu0Q3u129b/GMETc7F35mg/0iEId84sL1ToHuj9C4MCzhTktxyQLeHaFTb6wYoNIWbjej4Mwd6zvy8QMeoHqfiy2rtt5H6Mgzw6lnnNh8FQQqcgUuit2605t8brBVqmztuizz0qv7ysstHWTftgTZIbqExSZo5MxrnlXSkbvyEUFhTJyLChckq8P+lirHtiubOdcM7FHMRLfigxrJpODzwUhGA/CzSs7AQO8T/Pi/sSzIq+u6oREsDUfug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:33:03 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:33:03 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v11 0/5] rust: Add support for reserving of ranges of IDs
Date: Mon, 09 Nov 2026 17:32:48 +0900
Message-Id: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzU7DMAwA4FdBPVPk/DrhxHsgDo3jsCCxQbtVo
 GnvTrq2rCgcHfmzZcfnZuA+89A83p2bnsc85MO+BELc3zW06/av3OZYHhoJ0oIF19Iux1a41Hm
 tyEZLTUn96Dnlr2ud55c5Hk7hjek42Sljl4fjof++NhrFlDeXRFBzyVG00Dqd2EnjWVt+2o855
 u6BDu/NVHOUGyVXJYsiZdiwT0FFXym1VX5RqigJROBAyRCoUvqmnIBF6amXTxJsihQ8VspslVy
 UKcoSWkSEoJKulN2qdS5blLAQ2MQUTIiVwq3CRWFRnXEo2ero/unlNkquyhUVCDUhRpCiVv6mv
 Fq34YuC8v/UKbSUUqUE/DIBYl192WbZB0b2wkHQ/Heyy3w8PX+eyi0el4u6XH4Ay4c9HKkCAAA
 =
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
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d7b37f-e73c-4d23-df67-08df3e3c11d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|10070799003|376014|18002099003|10067099003|921020|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261022113327099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: dINAg9G+8eKlIR5yVzPjttu/gE2dVwGUTvsb+3uyc3IZPPIW4w+tx5ZOVDksdOfb+aVX1gDyAgnadBTS1YVNGnAViFL/PBv7x5KqsL5qkkDocedYmrk7quaYMfH2ly9KhJ24KziJKiD7fLUiHqpanXe7cMkCSfq+WaJw0qG5yk6tGwRTH7J41MuUyavuMBBTX4yZyDtYUCX6OoY5PcvsPeBN/Jado4+9YWRoQ550IOem7L4GoiILpU2AF6mbx4l+wBUaVApJt5MoNpvtxC/8whhxcHfnaMwVPVBmtlX79WuSnYq+5Gz1M+sAbXx3IsIHUomWszqyOMEAWQS2IDN85mnA0JKcMIymYWiJ+8VKBeShdorIP2xuyqxU7CatXn4n1S49ESeyl/9UMnznOsgJ++SmmCpBy9SVK7K4GhPRm93/ExJS12pr3xR7m/Dt9IZp4ghKZKlZl24QfXIww9W+0bbMMSafRTVczOnWCTFRieU/m/kpTKiltY+zsrsR8l7qgmZ6sCIJfG1obwq9pUMgF42IzItLc3f/9AyEo4aqdPFzEipfmX1zHRvGR5xRhtX0GPHwSf9UsCLlc9wyf29KB++FetrkGNdzeau9SRKpgMOSFdlNH/DakCvONrHReM4QjNln+asvfN+TTVa1hVCSb/5XWV93Jxs0aPw+n3PksJVhJMo1HutpxWZfKZKYHDmoCdAu3GjlHaJS4T1OZxUfIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(10070799003)(376014)(18002099003)(10067099003)(921020)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022113327099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3JSL1ZMazFteXFJcUF0Y0RmWGpTY3k3c2doR1NCb3gwTXJmK3ZTR2RFRTRn?=
 =?utf-8?B?eEtieWxnUTU5VHNaOHN1dmdjSmFhQVYxdVVhcFhHSkJPUDNRT0tnekZYS29W?=
 =?utf-8?B?TEh6YU5DMlBuai81WkozdUI1SlNKclZwZ2VqckpDdDBXZXk3TG00VkxqcnJi?=
 =?utf-8?B?S0QzYmx0Zy9SbGJWZ0g0MjBDWFFWaE9HSEFOV09Sb3R6Z3BxdTBDWkZyLzA2?=
 =?utf-8?B?Skk5UTVDQjcxczI2Wld3QVBLQUhlQ0c3RzVqQjV0RlJYV1EyaUpWN2pIb1hD?=
 =?utf-8?B?dnJiNkxGL2FZeURrSW9hbG43aWNPNHpKUENGWkF5alh4cUQzL1NrMldieisy?=
 =?utf-8?B?VXlvYWpxaGhybVFzNlNFU0JyNHRvMldvR2c1VDFxYVRvK2Q3Uk95dlU1L0JB?=
 =?utf-8?B?NEhFYUtidGN3aHRRMFN6Q3pEdTNkYzI4b1VMdXoyRTVYcjJKelNUNW9kdTJY?=
 =?utf-8?B?Y3lTRVp4NWRIVDl3VXdXNi9pV0ZwM3lyaTBJMjhFQVoyN0tLUkNLaExrc0o0?=
 =?utf-8?B?MWkycHhnMytHdHpUYWJET0FGdG1MRDN1R1YxWWpNTHA3TEN5bHZyTWpiM095?=
 =?utf-8?B?b21iK29KY1ltd2tkamhpR0hVekdmZnp6ZmFNRDRBaUViZ2luKy9leXZGNkFx?=
 =?utf-8?B?NG1jOW5WMUd4cVdza2thU2xBZHpJcEJUMmhrYmpWZ1Q5K2NUYlRVbDdZMk9U?=
 =?utf-8?B?cVorKzZrYnZIYXBHNzlBV0p3UUtaaVp0dmJRdlVuVklYWUExc1N1dzRvRVNp?=
 =?utf-8?B?dW9tR1BGSTIrVVo0MXIzVktJSzUva1B3R1g2cXg0THZwQ2t2dmtPbHNqb2h1?=
 =?utf-8?B?N045bXpwOFBQZUkzeVAyQUYxeElpd3VlQlB4d0c1T1BjTisyU3QzaGdFNExo?=
 =?utf-8?B?TWZVWHRDaXB3TEhMSHNWWGZnRUFncXZ5VndKMmROOVI3cnA1blBzVnRlOHZL?=
 =?utf-8?B?RHJXSUlMb25KbmxCN0FtT3ZWRTVUWDNTd1VKd1ZyTTNYMDhEOWtFK0xnVUlM?=
 =?utf-8?B?SWZ4SEpic3Fqai9HdFpZT1M4NlR0Sm1BVUVPQVdSRDQ3bGh3UitMSTV6VVJp?=
 =?utf-8?B?S1FEcHAxWFUxSXplQWl1TjUvcWVGN0VnRW1vMmlPZjNlVDJqTGFVKzNlVlZG?=
 =?utf-8?B?NjNoZVBSdk1GRlZVUW9pQkZMNUtHNFVETkF1bWViZG9EY202ODZteXhVVmxY?=
 =?utf-8?B?aXJxUzNaZk9BekYxWWM1TTVEdGorTWk1elMvYmUya2ExaTFDWXJHQUpBTC90?=
 =?utf-8?B?WjQ5SWdCQUFsSGZrcGVwcVdZV0t0NjR1akp6QjVvdUNqQTlRUytKQUo5ZXhx?=
 =?utf-8?B?ZVhrZWVDUE04d0FsSVZzOC9mNHhEUGdzOUhyWG5pY3RaeU1LcWlMTXd0dWlN?=
 =?utf-8?B?Z3Vic24yYzIrbEprQmxjNE9qK05DcEdxdXlTR2ZiRSs3dS9nMlBQa3NqTUwz?=
 =?utf-8?B?eHN0Z3FwdU9POVNFczNXWVh0TG42SWF1NXhXMitUNm9FQklCbTlSTjJyNlVk?=
 =?utf-8?B?eENKWUVvZG9yc0hoZENTd3pCbUIwNEZyeTlOSjd3OEJsNHFxaHEvbGkyOUMv?=
 =?utf-8?B?TC9CMUhzdU5hc1UvNFZ1QjJVcFZKL1hwUGdZWHQyQ1F1NkNLRDVpbzRWVE0y?=
 =?utf-8?B?RzN6RWtHSWIwMUlyY29PV3BtYisxcFlUNW1IdStrTnZiU1BhNndYUXVLVUIv?=
 =?utf-8?B?WjNZZGJ4YkQ3QkdwTzJ0dHdJanRSRmI2WTFlTnYzOVZHS1Q5WXF3UU5TRHRC?=
 =?utf-8?B?TjcySmJVdmpMd2EzNjQrdDdSOXJDVDBma2N4VDBmR2ZZeUdPZ3R6bVJ4QUNv?=
 =?utf-8?B?ekNrZ1RMVFIvNlg2NWp2OXdJWk11UFV1ZzZUMjdrWDRydzZsSWJENmkzRWJ2?=
 =?utf-8?B?TzlqdklvdmdlQnhxakRsdFE3MTN6bUV1VTlTWkNwMnA4MVNvVlF3Z1RPV0Vj?=
 =?utf-8?B?RHJWTWpJVFFVWFJHTmN1S0s5SVNsUG5DZ2I4bmljVjVqTVJQekxCNlB3KzRH?=
 =?utf-8?B?NU10OEMrMmV2SmtQanVpZzMxZEFIam5ycTJZcDJod1RwODI5WmFlZCt1bEYv?=
 =?utf-8?B?NjFTK1NPangzMTJ2N0F2V3Y0OWcza2NiTmVxNjFkUTg3bW5mYlZCNkhzemdh?=
 =?utf-8?B?UUduRFgwQzNQNjJXZGxYd2NhWFZNZjR2U3BQenNmeVFUajVwZGs4WDVOd1Zu?=
 =?utf-8?B?UTdFUmtXWVU0Mmp5clY3MVhyRlpDYVdJeTZRTjRaZkYrN09hRUJhZlBXM1Vm?=
 =?utf-8?B?YllCekZpUXlrTktIK1Q0SkZFUmtYQ0NlbnR6M2NzdlRzbEZrNjVSdWxPQit2?=
 =?utf-8?B?S0dwenR1UXVHNWdsQzE1TjVwK0l5M0JjTWZtVkYwYmNYdWVHVzdnaW1JbzAw?=
 =?utf-8?Q?u/Q+bnlVf8soCNthhH7h+1nOl9GDG5CN2c7PWNUXq2Gof?=
X-MS-Exchange-AntiSpam-MessageData-1: ZoxvuNg8bprMeA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d7b37f-e73c-4d23-df67-08df3e3c11d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:33:03.1698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRvcQhwDl5s+P5uRFpdi6fJWGzBApDntG/UIiCRsh3GN3kJ8cSeS9P6geCorAZwkPotJJthOLy+dMPV/qHGVNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for reserving of ranges of IDs, with a usage in nova-core
for channel IDs.

The bitmap and `IdPool` parts from earlier versions are in v7.4-rc1
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

This is based on drm-rust-next.

[1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
[2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
[3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v11:
- Rebase on drm-rust-next (pre-reqs are merged now)
- Split patch #1 by subsystem (Danilo). Just splitting with no actual
  changes, so I kept the reviewed-by tags on the new patches
- Add reviewed-by tags
- Link to v10: https://patch.msgid.link/20261019-chid-v10-0-67de9180b4ed@nvidia.com

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
Eliot Courtney (5):
      rust: io: use Alignment size constants
      rust: gpu: buddy: use Alignment size constants
      gpu: nova-core: use Alignment size constants
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
base-commit: 7ecd9ee29f7bfbe9a293952fbc83c3f8bd7205dd
change-id: 20260608-chid-18fa943c6d6c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

