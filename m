Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEF606A321
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=oqgh8F78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B29710F53E;
	Tue, 20 Oct 2026 12:23:39 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020143.outbound.protection.outlook.com [52.101.196.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA8710E08F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 12:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPmhfuYglwblMyXuxBGVnvqXa8+6nk5aN1BUcMXvGdXGkoVfRcRgHnI4KvOTqbFHOPLgMPEOTw6kCTriWpQNaQMpxgjff+qTjUjRr29iiGF0TPILbtQDRRgxeKZveSs2pNcybiiHyGkcD/tTimLgfvT34AWLsn7aeBWRRXaxLSUZaOj6IwT3tCMV+R2VPqtYx+1yk88bUzZGC9TvHQioKZzNcUI9a73QIE9urZ/uXkt3Oesa1LNcZJdMG2jX+mQkkuPdeolgOWhXtgNQJeAWcYXMrQZAGAVs1jsDZ4ZRp1e/cruE3AwsYIjdTO+Xt6XAEdzOiNqyjegNTK7Tat9P4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW6CDfvsHHGQnfZ8ATVKzOi8OWIvcEMYsNbEVzS/vEQ=;
 b=FiJQoJEqG4ieY0wXffY0SPLck5PW9/F5bSZYKa+pBeY3oY4AMH6CFAG3zDjGOsmEFhxN17+S82BncZTps8ybuaPL9qiBt6Hbf4pWnknlWOUI8vLD9mxesN4JUAxKy+se4Ssl6Zp18lGg5XEC7OkyyxnfP2XwqpykJwDTecYk+c3fAqZ/HuFygdxcRGO5VJ4SWR2agaKMthIdgGzqaA2g5gactSKI5/Y69+oTzyjAT3AZSInv+bQAZFsvjACzTUvErQOlUQNGVQSs69rNcOOkCNM6JuXcawVSqN2RbAUc2fFYEIhnf2Mtz1DSmqfVNMp5HP9Te2N4sAMkXreVA2J2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW6CDfvsHHGQnfZ8ATVKzOi8OWIvcEMYsNbEVzS/vEQ=;
 b=oqgh8F78PajG1dJOi+ye/GyWZNCDTOzWSzmuMX+3mAZyeF3QUfFzXegnwSabipH5OGjeT6syYLCCgC2Wp9h9J1Obw4OIS93nIliOXdRX4n7FX0pb9OfIWuFt6o1Bk9S5T2LdSfeR5LBUJpcmmRAuKNyDS/v6Y7Rlv+ISAjXCrWA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOAP265MB8558.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:23:29 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:23:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 13:23:28 +0100
Message-Id: <DM9NV8ICWRKK.2Q6FSBE476G5M@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 5/7] rust: io: let I/O locations carry an access mode
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-5-93611b84b5e3@collabora.com>
In-Reply-To: <20261015-io-access-modes-v1-5-93611b84b5e3@collabora.com>
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOAP265MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de4bcd7-64f1-4f7a-4ff5-08df2ea4f2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|23010399003|376014|1800799024|18002099003|22082099003|10067099003|4143699003|261009223027099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info: ccvsCU4dthBJ8CbSvX8YcwSU8KUUgstwuvc5bgOvlAuMN7QhIfRm44/P+OaikypgcVS7wrYvXbdd0UaSAXQF8YsIYLbB1BAmar7QOpcxebmQ+w+aYHwqv0TsF2DxIQ4C5/iwCv5jmCs5jBrJyrwIvP1b4cfauE3OoEJAH7bASlmQwgrvml+9bx9NKya3PyP0OVnUjULwGkAom49pgy8z+F565r5c1bO8ZeTGwNmSTaPNSlQkQsOGq1VsRoCcvXHbH+7jqlSenTDCZX+uqfCwgBS2izWX0scyzyWjFiIdCDMiwg9xLDeuwDSn7nwWy2DzCoy4KXwBKqb0u7bgD/z2HvJrqKO2aqlde6tYDF30jBJQpU6GAqwc8T/UhezdmYfRP+FZ0kHvsT4PXiGyo5EKc0xYYXfq8gHMxkxF2bVxLH6e2RfiFFykjfpxgLHWau2fYNSd0aLtE5eLkYrtK9XUzH/xyH3wvnCWcRxXH46BXcEK4xzRkxx1s7F0EaTZsEe+uicpZz0vXmMfG0YFMH3czdWXCEZhm4oQFzQwwkBEG+OuMdopaPjrsw1ol9i5zBHIstxovAlbGfUAwwhBkCUVJewYeuoQVHZtSVhxG1a7bb6r/HJU+Gm3Wfkrhf90hoS6BIDycmYOk2X8pImzSnyrld11KDfwOgb9d4hh0QDhdDiJAt1HpKklPUFU5TSkhObI1cfrLYf5rM6fxRhObL66bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpWY21mTm9OWnZJWC9kcis4cjkvS2t1RStqZkYrKzZ1bnFHRlNWWmVySXVY?=
 =?utf-8?B?Ym1SSWpWbEE4S2JEU1N2VlFMTDVnK1RWL215SGx0THJiUyt0Q05CeGhoUGt5?=
 =?utf-8?B?ckhWNkwxMTJVNjRxaHQ1c2lBdzlMMXdHVzJwRmRYWWVEUU9RelhMK2NWd29z?=
 =?utf-8?B?SFRnM3dJSWhZTUg4RzJld0MrTktFc3FOSGprWVJIV2FNSkx3UTloZ1lOUG53?=
 =?utf-8?B?T1dhRnQxSzB1cHh2R2dLc3VaTnprZFJKNmhGb1dpUHF4cGMzZXA1dFh5M3Nx?=
 =?utf-8?B?UG9lSnp1bm1qRVNDZVZPZ3c4T0g2aTNLaDFweEo2YlFuai9MczR5UGNWUVBo?=
 =?utf-8?B?QzEwV2h6MXRoUVFVa2R6dm1pMWJBSFFwSUZEeElDWWlYTzBIdDVLUm9ienNP?=
 =?utf-8?B?NFRpdDA2dG5lRU5KR0taYURRSC9kbGVUbmljWkMxeXpaV2Zyckd3UUY3UmNj?=
 =?utf-8?B?T1pTM1NMRENqV2c4eFZUc1FVeFJoYTNzSjE0T0pzNzlEUzMvQnI4R0dOZ0p3?=
 =?utf-8?B?YVVzRng3V1B2Q2twb0xvanFtZkZKVVd1R1YycWUxWVFVcFE5OVJaTHVtNHd0?=
 =?utf-8?B?Q2VpNy9YZmE2eEIrV1JlM0RmMEw5Znh3RHpCUmhqYkUwYVZxWDZSWXdIZnN0?=
 =?utf-8?B?WFFJcTd2RnUvVGJWMGtqS3ZqVTBEQXFtTG9aMGpINjBXQUhQeWhmUTBMWEda?=
 =?utf-8?B?KzhzaE82UHhxZ3R5OFRKcHFhMWh3ckhtc0wyM0phR0dYMi91anY2ZUVUQnVo?=
 =?utf-8?B?ZmV4YURjalk1THZ6eThpQ3BIRHovMUE3V2M0blpuT25OYTVmUldsVTJkZ1RH?=
 =?utf-8?B?OW54alZ6OEJmd0FFNUhLRkRLTVBUSjJ6NldleGM3UzVGZXNSRDZ6NjZVREZG?=
 =?utf-8?B?UlpUd0wya29ISUNTUyt0QlJUSUx4Ulp0VzhGWjNRWldIL001L0xLYUg0RTNF?=
 =?utf-8?B?K00reGdiTk14Ti9kSEJBVHVwTGJTSmdKK2NJUG5RWStCdGNjQ1BsbFU0bzQz?=
 =?utf-8?B?ZzVWbDVJcWo0VXZzOXhxazJxTk5SQXYyNDQxNnZhdnVmZU8wOUVTNml0Y2pl?=
 =?utf-8?B?bWdVWUFSdWw0OWd2Z2orTUVWRnNhYlozMG00OW1VQ0twSzJ0KzAwdW9McFNF?=
 =?utf-8?B?MWx6d212UnRla3dMN29EbVNFemNpZmZ3WWlDVXk2Y2ZoQXFSRUlSSCtrRnlu?=
 =?utf-8?B?VENaNG44dVd4N09kZXNBdWJITUp2L2RERnJFU3o1aUFZeDFDZlBIV3d5Skd5?=
 =?utf-8?B?MWowZHdRV2V6WHlDUTB3dlBsUG9haVk4ak5LWGVSQnVWOVdjbzBSMGFXY3Ez?=
 =?utf-8?B?YkV2MWNSWVBXcE81TGpnZEZzeTlpWnhHZFg4UzdVaWJXUENqTStUc3hQdDdT?=
 =?utf-8?B?aFVnSnZPa2pTdE9nOGNFR2FqeUNEM0xDR2xpTDBDYldZUzY4SEdPRDZhaGR2?=
 =?utf-8?B?OENtbmQ3RkN5OVdKYVpuaGZ5ZGtvVUZ5M3Z2dFJNazhLcEM0Z3ZMY3FHclZZ?=
 =?utf-8?B?ek9iSHcvejk2Q1Yrbno0YkM1UHJENjNXVGFqV0dOd1V3QkIvUlhKOE1MODVy?=
 =?utf-8?B?OE5yN0MwUG1UZjlBY1BUVEdJSTRNOXFPZDd2M2JOU2JrdHo0U3hLSTNqajBa?=
 =?utf-8?B?alhJWml6L1hwN0Q2WnRJa3ErL3paZ2pFRlZ2ZzBaS2wrMC9zUE5kQ0w0YzdD?=
 =?utf-8?B?N1BTQ0tuL0NqeWttSkpCQmMxakhRa0RkWHJ1cnNZVklicldRQzlpYzQ2R1Na?=
 =?utf-8?B?T0dXQ0hUbVQzT0Q2TGgxUkI1ZVJnWHp4UFF6c3Vvem4vUDZ5OXpmbzUyeVdI?=
 =?utf-8?B?KzdYZlhrVmJYeURtOGtHUzRoMTlaeWJhNUpvd0VNYU9wRUN3dXBic1F1RU0x?=
 =?utf-8?B?YVVtNzNYRDRWb0NWV1N2VE9rSmdXcVo4NmduWjRvSDZzS3BkU0poVmppK0dG?=
 =?utf-8?B?YVdLT1pQTG5mQ3ZmZk8rRHR6ZEdFNGM2TG9OQUpnUEZ0cE9RVXNqVlhlY1Vp?=
 =?utf-8?B?WHVONkhvOHFjMGYvTUFMVXViRUpNTHV5K3JwTm1wc3pQSTlHcGlYL0RscDdo?=
 =?utf-8?B?V2tDaU5hejFyZ2N6TFNpQVJ1elVwZFlrNmEwR0ZsM1RUZE9kbXppNUd6YTZ3?=
 =?utf-8?B?YnB3eWM2Tm5aRFpKaWc5ZnZVdFpETDBOa3dGVnU2Y2czdjFDYmNSOVpzWnpj?=
 =?utf-8?B?OEpMZUpYeGZPK3RROUswWTh2VEpETDhqemFkRmhkTFhhMnpjVDkxakpSQ3Q3?=
 =?utf-8?B?YkIvQ2srY2M5YTFZS096Q2R2ei9lRkFKaC9uT2xlcmZzaEVEckU0OFZrdEJs?=
 =?utf-8?B?K01MdGtNQU80eTd3RVJTN2FaZTl0UzFHUGtacFhNRXhPcG9LMko2dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de4bcd7-64f1-4f7a-4ff5-08df2ea4f2a7
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:23:29.1375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZa6jtjUbpbVFcZgpv5wNAQE2iUQcnM+6y/cfQxrThw28TQakr7hGoRT2WxgOPUUgu09cZLu5pSrAr17/AYYBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8558
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 15, 2026 at 1:39 PM BST, Daniel Almeida wrote:
> `Io::read`, `Io::write`, `Io::update` and their fallible variants
> project the view to the given `IoLoc` and access it there. A location
> has no say in which accesses are allowed, so a register cannot be
> declared read-only or write-only.
>
> Add the `io::access` module with the `Mode` trait and the `ReadWrite`,
> `ReadOnly` and `WriteOnly` modes, and add an `Access` associated type to
> `IoLoc`. Projecting through a location applies its mode: `ReadWrite`
> leaves the view as it is, while `ReadOnly` and `WriteOnly` wrap it in the
> `ReadOnly` and `WriteOnly` views. The bounds of the generic accessors now
> apply to the backend of the restricted view, so a write to a read-only
> location, or a read from a write-only one, does not compile.
>
> Raw offsets are `ReadWrite`. `OffsetLoc` takes the mode as a type
> parameter that defaults to `ReadWrite`, and `RegisterArray` gets an
> `Access` type, which `register!` sets to `ReadWrite` for now.
>
> No existing location changes its mode, so there is no functional change.
> A following patch lets `register!` declare read-only and write-only
> registers.

So far, without considering access modes, we have a clean mapping after the
register projection series that a `register!()` macro just generates a cust=
om
projection. However, this commit makes it special again and this isn't poss=
ible
with struct definitions, so it breaks feature composibility. It is also som=
ewhat
surprising in the sense that it changes the base view type.

What about making RO/WO wrapper types on actual data? Something like

    Mmio<'_, ReadOnly<T>>

and

    Mmio<'_, WriteOnly<T>>

Then we can implement

    impl<T, B> IoRead<ReadOnly<T>> for B where B: IoRead<T> {}

and

    impl<T, B> IoWrite<WriteOnly<T>> for B where B: IoWrite<T> {}

ReadOnly will not implement FromBytes, and WriteOnly will not implement
IntoBytes, to avoid people using them with `copy_read`/`copy_write` API.

This way, the design works for struct too. One issue of this, though, is th=
at
you cannot project from `Mmio<'_, ReadOnly<Struct>>` to `Mmio<'_,
ReadOnly<Field>>` currently. However, I believe this is solved with the "pl=
ace
wrapper" concept in field projection.

Regardless, before we proceed with any design, I'd like to hear opinions fr=
om
Benno on how this interacts with the field projection design as language
feature.

Best,
Gary

>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/io.rs          | 42 +++++++++++++++++--------
>  rust/kernel/io/access.rs   | 76 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/io/register.rs | 18 +++++++++--
>  rust/macros/io/register.rs |  1 +
>  4 files changed, 121 insertions(+), 16 deletions(-)

