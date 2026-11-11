Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a21Wlag8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11BB710E9B2;
	Wed, 11 Nov 2026 01:12:00 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BF110E9B2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tamvwrhwaRuu2teG+uEoExDyyRtqgGmpvidpEIvKUKufi225zkO3vyBXe2XUvDWD+hIoYT01o7r2FxiWYPhY1ntO4nCpDQ0tAG052rLigWdlH6EhYdQfUYlEkMwjTHjwqiSRVZGsKcN6P3tzWK7THAfGXnaHSyKh8KYg5UUoeK9G+AkbP6htiOnGrW9t9SJjgZnLxMTklrFuzfefXqFodjW4sGlHtwySoiTLtw+bHFV89XNiTUhMuvGV9jMXmywpKyMT7vqlttqUeScL4hGwXP47CM3rmo5JMX68Ii4aRiR92LCn21vPSwGQI9Oxgo6t43ou1Y8auRrrBy4YDWrvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klamGhN65K8ipUBLWt2gDGRDqctZ8vVDMeAW1wCZ4bI=;
 b=EMEqBVniqHC2fA988i8p8pAeGtgUfsOXixSWAF2J1SC8xwXyquvz+1EcoJ8noQj8Ldi8Mu8/zFUJdCtkCvUHC62awx/vm9hr6HANNsIm0vOyXkNPsfhMQrqmZPysVYQApIwxjuDd2yZ0UsJMG0D3tHUpqrt+/kKfjQedyzJabMCwwIesGU4O7I7aWC/G/iQsR3uOZT10ooXfy2ekWCY5MFfc/C2Cw0Q7quESmiotUo3InqiM1gb2RB1gO4WX0k0b44OpOk8YkYGE+W2XpVBZVOEiJMFAYhwm+F8CWj4Xb287/jj74tmzHwgKULJpKBTq1S1SaVr3Y2VOHzf6Q7hklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klamGhN65K8ipUBLWt2gDGRDqctZ8vVDMeAW1wCZ4bI=;
 b=a21Wlag8AweDYOCP/3AnRgMjAMYPMQdvcFFQq7mt9x7I2HWBqHINe/GoN7Oi4kEOumNLpDdKJSDboSVX/q0035nZOBbb8M6IAgUPF+sv6snzuRL7JMBgCgASbxyIvCo83cQZial9rdc6Z2WNQ3/LbIR/j76Uh9KvTgbD+jmCf+Bgq6ypa1nEXBboXJsXVH7E+WUUrP8h+QMuro3sajQD1jDc86frNxQ6j63kH3jro9eATsL1py/T4MZRwpkGcnFouqL0WM3S6JqYBb1coopRheYARZ1EfYvchlg1p40Nwqz3bep2W2cgefS1rx6Zl5s2r8munUXrrSN+6zWaJZSPow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:11:47 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 01:11:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 10:11:39 +0900
Message-Id: <DMRZCU0UJL9Q.251K7FN6X4GTW@nvidia.com>
To: "Sami Tolvanen via B4 Relay" <devnull+samitolvanen.google.com@kernel.org>
Cc: <samitolvanen@google.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Lyude Paul"
 <lyude@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: gem: shmem: do not leak pages when
 sg_table() fails
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
In-Reply-To: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
X-ClientProxiedBy: TY4PR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:372::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e09c75-9717-43cb-3eb3-08df3f90c20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|261026121527099003|11063799006|261009223027099003|261022075727099003|261021121427099003|56012099006|261026140227099003|261022105027099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: eozQps1KACa+v0PVYnR3I32+DvfULPoNsGNqTK2EwvIs5epXDZpuqPiwH03Ao9qmESlWY/BQmjKSXePrVe+GQSgPb2XFyH7SkiQ9KwDdLUnDBs6LAx4uvNMrPvHATSSDnhNaMyzbqjuK5Meio7uzq14F9JANjgUu4EGxSesjvY+SQMsY8Zcu/LvQPoAIVxh3dDdaxjal6XAWoTEJVMt8JnxF+sQcEohS7sHJ9qzTdGYFUKDBBoPReiBcszICK+FaNSmj4H+DAdzmiBxXIZKAjLsFN5JpaGSP3ncL26j283ngThx5l29lC+5UUgE+1hnvgT/NdoXXQ98ps1RB7riTWJQXeVckZZiH4zfKCancKhRLX2mDYJSa+0bfQh/KnaAm72+SmsSWHz03HBRyTJZKFHCpkzL6DwatNxFFOaBL0X1CmfegMU2QXsKh3CzvXVF09TclU0mDllfP8L3d0jiuXahMhYlg6IteBwnNfpNf9QFwdApqOp4Ws1yMAZ0zmRd5qLnD5msMxdfKNkTsZVr2Vxwak9+WoStVI1rNky4C0wtiO+EjUJ08OhtisnxheaSHXbXUMXBNe8G+tdWDOjXmUM+CsbItZFpjgrPhpkBvXpZWsCyzHyfwULRkrQYKxTe7dU3imLyPFHdfqJY5tPEP6Y3V3FZA/uQgI+M0uNRTwjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(261026121527099003)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCs2c1hVdVkwd2tUbFIwbUdEaU1SWk9tdXJrNkwvdGQ3Qm01U1VxVVdlYkNF?=
 =?utf-8?B?QnNYeEw1dXFkb3YwbjBhSnVsdjVId0JVYkxrMWpja2h4a3lncUVGUEFGUlk1?=
 =?utf-8?B?aW9mTG5zcU03dHR1M0RRSlRyN1cyU3FmOGkzRTh6cG83LytkQjJleW5YcHZS?=
 =?utf-8?B?bFhUUVNhRk5WZWpLYnlFTE1ZOHJrY25oUHkxcUJVZU1nZHd0K3ZvSHVlVnQx?=
 =?utf-8?B?cTlIVWpVeGk5aFhUbEd2QWdSTFk3Kzk2N1UwUGxQaEJ6OHI4UFFkcndBV0xw?=
 =?utf-8?B?alliSElRaW13SjBWYWFOSnZDbnR0T05QZVVnaHp2Ni9ZazlnZ1c5TW5zQXBm?=
 =?utf-8?B?dGNJM1AxV3NBNEsyTktOM3JqL2RQSnZJbUJrRHRUalZYZ25QZlQ1TTV3Q3Qr?=
 =?utf-8?B?ejE0VG54YnVkM1VFNG9pczAxTFRwYnRuUUFzQlpnUVhxdDMxQnJVSUVyeEdz?=
 =?utf-8?B?MVlWZG9DSlB5T1NFQTd1RDFLQnpuZktnZFZXSXZRejVzNWF3TjE3eE5PaTlL?=
 =?utf-8?B?NlRaeUZwZjQrbmxrbGpaSXZ3eEptc0pPaXo1UVg5SUxGTUlKRVgwcHpIV0tS?=
 =?utf-8?B?K3lBMTRxRTFvWkR5TkY0UDhXaXp4N01NYk9vaUFQb0lqVUhua05sSHdaN0FG?=
 =?utf-8?B?ZXdweVNhcVYxUmYrOG9IdXpvUFpHbFpaL1daUnpGdVh3bnVtN0pQRVRpU3Bu?=
 =?utf-8?B?V3JaQllMclpXNDNOYUIwc0t2aHhQc2xJNHpNamwwa0xzTzQ3bGRmaWgxZmdB?=
 =?utf-8?B?R0FzdWZpYnNjM2VQTnlXd1dLU0pwbkdEODg2UFBKejFTcEF5a0FRWS80SUJj?=
 =?utf-8?B?RDFiN1hsaUhLVUl4NlcrYXhYV1RxQzRNSzAzZlJmdUQxWHRZZmw0OFB6eFI2?=
 =?utf-8?B?NnFSNHR2NWZ4bEtRTHprcnVhMHBxaVNhZEx0SityTXN6eWpTakphaWJ5SDZV?=
 =?utf-8?B?RWtpWFJITzZaaThyV3I0WHVSRXl5UGdhTHRMdEtLTVF1N3diL2hUWDNrTjBi?=
 =?utf-8?B?SFhoWHFuSERKd29yc1Z0SlJ1T0o1SVZzTTVwM2xMVW5VVTR4T0hodnorVGRD?=
 =?utf-8?B?Sjc4ampHL3FmN001MVcxWmhkTEZhWElJZUZWLy9FTThqdVhISEQ5dXdvSHZ1?=
 =?utf-8?B?bW1FakxyRSs5ZWVUekxVdWNnak1hWmZ3Q1pQOXcxbXZ5d2I3bVB6TjJzb2ti?=
 =?utf-8?B?OUVXTmdKdWpucEIyWnpVczRkeGx2bndGQkl6Umo0Q3ErRTVBNXhaenFET2tt?=
 =?utf-8?B?enJtUXVySzM0UGdlR3hGWUdjbkZwU3pSRTFZcHhQN1J0Zmd6WlcrWEtqY2l6?=
 =?utf-8?B?bXV0aHB0STlLZy9DVnNMVW9nQk0zYWVZTnJTc0ZQbEpiR1BWWFZ3ajVxb21D?=
 =?utf-8?B?bVhIN1JDaG9ENGs3elM5M3pZWHFRRWxSVjRucnlXN3VZbC9HdGpnUzJVakdE?=
 =?utf-8?B?RmhqQTlwY080TS9HWDRYZjZXb25YVDhhd1FuVXh1THlnRXlKdEdqckpDNmdx?=
 =?utf-8?B?WnkrVms3dG5kTkFXS1lQWU1HUUVPZm0xUEwvL2Q5Tmw1TkZ1VzA4SEptU2N0?=
 =?utf-8?B?b2krSE1tbTFnUVBEZnV6NHI1cVArOHFMOWFBNHZrazFKbnQzeXdWUVdaRDJU?=
 =?utf-8?B?YlhLOG9hUEtJR0thbkF4V29QQk5nYjZCdW1uekJPMGRqZndla1BFejc0N3pv?=
 =?utf-8?B?ZU9GYlBmNi9xZWpvOVgxL3BNN0hyYUtDZVlrTWtFZ0NJWnNQQlNsMFZQYnNo?=
 =?utf-8?B?UDVWOVVVZHpBWW54dC9veWxPd2hKRkVWQktCSDZ5L3JVWEp3Z01wM1o1SGw5?=
 =?utf-8?B?MUpFdkFwOWRjN1FqS3JhWVRJdlZLWnN3REU5VTBGYkNKbm9DUkdtczhyV1dQ?=
 =?utf-8?B?Ryt0YUZObkgxa1ppc010QlJTZnBJM3ZQWEZ0YXlUTm5NdmZyZkZtWEdjSi9J?=
 =?utf-8?B?Vk00czFYdm9zT0NTc2hGcXd6NzFCWVpHb2g3enhYMEJlb3hIYWlpc2tIUzRj?=
 =?utf-8?B?Z0ZnaWxUamhkdVZoR2syK0RXMWtUTEtINE5FOTBxeDNlTWRURVg3dTlxc0po?=
 =?utf-8?B?Q3N6RXlSWExzNkdoMTBnWkRPditmYXJNRE91WUxHZ3ZXNlc3YXlTZlE3Umpt?=
 =?utf-8?B?eDd4blZ5OUJQb2xIV2xienphWHBHVXZHQ0JBTFI1VWk4VGN1K0g5R0dVcFVO?=
 =?utf-8?B?U0pOYnlCWDBIQ1BiRHNVQmpFT3A0dWdCWVdDNzMvWGVuYUFCWitkNmlaK3VJ?=
 =?utf-8?B?L3owQmR3ellIRXJ2VkN1YndDMGJVZGcrMmlqUi8xMjY3ZXl0clM2bHIzZDdv?=
 =?utf-8?B?d1BqejFZS3VQVmRyM013QzVnZmE3NzRXc2ZoczZDK1NCb3JjclJNWVBZT0Ro?=
 =?utf-8?Q?plsrgLTSAXbsiqarCAsS6fsQwkEWa5Kl+0nMkJvNY8YMB?=
X-MS-Exchange-AntiSpam-MessageData-1: 7WmebA/QcdAK5g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e09c75-9717-43cb-3eb3-08df3f90c20a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:11:47.5102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai4RGfJuVSgJNcjc1Ve8MOvqd0airhnN4WTf3Zhm+OcDRMiD4G5gt+hHXrP8pw68Y1pZIAHpc370/87ezUKXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 5:21 AM JST, Sami Tolvanen via B4 Relay wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
>
> `SGTableMap::new()` takes a pages reference and maps the table before
> `Devres::new()` allocates. If the allocation fails, dropping the map
> frees the table but keeps the reference, and the next `sg_table()`
> takes another one. `drm_gem_shmem_release()` puts only one, so the
> pages leak.
>
> Take the pages in the initializer, after the allocation.
>
> Fixes: 616c229ab010 ("rust: drm: gem: Introduce shmem::Object::sg_table()=
")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

As Alice mentioned we probably want a follow-up that makes the API more
symmetric (by calling `drm_gem_shmem_put_pages_locked()` in the
destructor?), as right now SGTableMap's Drop implementation doesn't undo
its constructor completely.

But this change is good to have regardless as we want to acquire the
pages after Devres' allocation succeeds, otherwise there is not point
returning an `impl Init`.
