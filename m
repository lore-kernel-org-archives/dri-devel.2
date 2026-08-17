Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB52C5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7362910E32D;
	Mon, 17 Aug 2026 10:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="yT8vJ4p5";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021081.outbound.protection.outlook.com [52.101.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E1A10E32D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 10:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckUO/J6fHu0qWvq/RBUwAl3an91I+Csfy+xsIiYLjlw5VsJ4ynpG/3fEfrIE1lIrrOtcj8oUV6+GjwUcuWV4xJxS7rUmYc48TnKYErLGGo/vveWPrzc/pmju15zJKlDgSYy7KDKygGZqgVjA48ARMKFE2dqGhn/DP1hXNoZ00DzMxGUJuevm4UfhFOL0iJXAKvbpm0d6/qxUba/ZAbcJ1tRzZeI5w4O3wqikrpNXceC5iQYMgLU09EXXvsgvu3hpM50FOWXJkbwHfjEWqY79St51GlTr4RufYb7UXOX0+RMO8M8//jMNN2wtYDFrX1fhgYzSXdBNx90JuKbdNzXKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apmGA4hIUP8uTYx3choU5CABx4jvZDa50mvde9/9ZFg=;
 b=M5m1VQbeWo13UZPHzSC83ds+r2rUduhUpGyLibj9IeJPwWdL88M6aHClqr3lukecyRZuIapia37cRSkT13LsSfBcZqegX7x0gjtASsM4uRnwKBNj1lS5XZZ3r5ygkKwwDguW9kASUU6OCsHmD/YZ0TTMS+y3xdcmgueoLkgM144MKya0UYbRzlROvf1Iq4DTj2HEOjA90LqFMBmTCQnq8dDyT13j795T0WNKAjSArwzxVeq2nFIkpK1O5mfTXy+j2suUyy0SP3UfFAJwDzkh32fSr3a68KnCeU4UW58s1MH0QXkifv0hd9OJDCqUbRbW+fMFjBUIbHEaRbX5VdgHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apmGA4hIUP8uTYx3choU5CABx4jvZDa50mvde9/9ZFg=;
 b=yT8vJ4p5ygjkNA3wCKq+QAxY7jkXzyN/uPbB/eB8IijMxy6+TDZEEpOrfvMJDV8HFlZMmDuj4/eYaJyIpIa05k8tWVPDcYpQTUmfV+aH6LWducTjp75RUDwvoRKiquKaB1j9HH6Oe/FU5qyha9rHdP/ctaY4Z1eRcm7UPr8r+cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7177.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 10:29:24 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 10:29:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 11:29:22 +0100
Message-Id: <DKR5D0EQTMIG.15W9AGBY0I7YM@garyguo.net>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "Yury Norov"
 <ynorov@nvidia.com>
Subject: Re: [PATCH v7 01/10] rust: bitmap: use function-level cfg on kunit
 test
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-1-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-1-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: LO4P123CA0415.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: d653f5ab-65a8-47fa-c43d-08defc4a6808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|921020|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s9HtqjT1K7gc9YHGmybmZFlP27qxExOhMD+OE92HF/pgI50z0F6DbA0HGsinEjc9Y7XwWTyYT4IVVpIqutYpeAR9Jk2ukeFmV9OANJMtKQ5gL3mR57UELDv2vKfVg2U6ITi0pS9HLA12tdm6CFm0d8mtPPekTikX7OchYqz9gjCsnzB8YQDLMoyBsT8QzMEf5Qy3gEVMzWADDNj7ZqFn33SVDeFPuo9wBQHcDHyDgn8oCbeCM5DVMLQePwu3rYdw8ITSAlsqjfqT+Ca7PXwgh/ML29VSLMBWlRXK7QVd4AZVfAE61ep2j5ZdDRQ75GXZh52FPhmPMOFLLCzH5mjy4WJ6eZrk2Oyk3fbzqhGXwQ3qRtc+8NhTBJY2Lp9MTEm14vaKDnlUt+PW/w06wZozh/+OqmZyYjrZ7V03bk41y5XrbpebSzXgADeVd4zkp4KnqlLijXd02xDFuY4gdYoq769mXMzbXQoTxiXlaJz+GHwmepJmj1n3hmhBergLKOR0eH9umFczSwclTXW46oVPa378HBpDht0JEZel8lzK89BC6rZdRvGqyNcwe+O58YKO0RnCY9QWcB/G6xv4vUvxEeHZ+xnrxfxCahza5+CQAdzWJYo98UcGYKuqk3t0V8CuVLM0l8qD36MkF0lgz0cbyBLlfyY9McUzRDf5ih4Gok/MyQwv/Lq/XNdJ9aIXy24LyVQC1Ys+nFBCalB4yu2Qtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZ1ZTcwcVRwdkp1U3pPN2VFZzExUlVaRzBRajlGaldWRFVUZG5rZEE1MkNO?=
 =?utf-8?B?U2l6Y0U5b2ZVL0NqbHBXd2VoUTlVeXFUWDdsVkVwaUlOblZVNHp6Z3puRTc2?=
 =?utf-8?B?a01TdHEwVWRiNlVVQnRYdVRQdXZ1R2dJbC93ZHc5OTl6ZldQQ2cxbG5mVmVs?=
 =?utf-8?B?VDJvazJIYURBSGRZQ0x6SEVUVjNWRFdQdHA5OFlUTEJmQjh5YS9CckxHb2t3?=
 =?utf-8?B?Vk1SMGwzTjNaNkV1NGFNQThvUCsyUTdkT0FQSWFGNGJuVmlaajhSanVWUXdR?=
 =?utf-8?B?OU1iY1piTVBxWEw2aFRacXczSnNQaC80Y2t6RExIMDFvanpCVzdhVjVlcXQy?=
 =?utf-8?B?Q3pmZVJXbVVCMWlEZDJ5c2RHVFVRUDM3UzdmUU15YmVqdFIxWC9aancwTGli?=
 =?utf-8?B?RWpRQ0NMS094MUlTOVlrcC9Ray9pcjFtemEyVC9rZldQbGtxR0tNRHNWR1pt?=
 =?utf-8?B?bkVxeTk4U25OYWU2NkpncEpoeTJhZkdHQU9xTWFaQm5sRk5jMWFRN3hYSlU4?=
 =?utf-8?B?UXdOa01oSkd0Tm1CN20xRUtrcTNuUXF3SE02R3pJSW05NUVKMXY5ZFdvTGo2?=
 =?utf-8?B?YlJOazhMN29GS0RHQWVRSy9WT0N1cDVublBaR01QMlZTUUgvTDR0QWJMMXNO?=
 =?utf-8?B?WGhxVzIvaHdQQXQ2YUZsemxuU1YwV2ZpNXZ0U0hTdzhpeWpjdndDMFZQV0Rh?=
 =?utf-8?B?akxCVko0Z2pvKzQwTmNmY2daRXh3UlFhWU52SWdnTE5ZK1VsWVMyQXp5N2w3?=
 =?utf-8?B?eXJEN0RzdTFZUXBEMDErTmZKelhMVkZvYy9wZjM1ZTlqdWpyTjQyQ05aSERM?=
 =?utf-8?B?czJUQ3l3NHEvQ2ZWNFZMemZhbG5uamx4UHBZTXJYY05qZnJEOVVRdFFsUXFT?=
 =?utf-8?B?bVBDTHM4ZHBTaFV0bFlML3BVaDYxSTcyYm9pSjZVMnRLSnlYQldkaGxJQUZx?=
 =?utf-8?B?NGZGcVVQTEpyZzZhYi9QdjhtcDhRMTkvaks2eHoyYnZzWlBjaWUyUDgrQzhq?=
 =?utf-8?B?VnpiVGdQZXJIK3V6QURMdjNQd2pOVDRSMUp1T1pLeExLSVFOSFdWZENmL3BT?=
 =?utf-8?B?WllhMEEyU29JcnlmWnF2TCtvekFwRVZDdWMvczZlYjhTaVk1c3JoZ0hVOFFI?=
 =?utf-8?B?REptZGNhSGxRcTd6WnQ4SWxwVEc3RHFRRFNRV1RmenhydmVqS0xOT3FLT0NR?=
 =?utf-8?B?bkpqaTV5MUlsQU5VNWZocTQvbkU0VUExWW5TR04zLyt2S3UxdWRtNE84SXZ3?=
 =?utf-8?B?alJacUd6MEErdUM2eE15Y2JPN2l1QUZIOStSTE0rNWdZSkRiOHJ0MWNHRHRX?=
 =?utf-8?B?YXR5cXNkMGQ4bmJOdmdFakV5ZE1qL2hsOU5ZZFkva2twR1FRbW9QSi9EN0Z5?=
 =?utf-8?B?ZzRoanQ4TEc1Y3gxOEN5MWprZEhPOVJadGlpWlZSTUJKYi9OVmxsaVdyajV4?=
 =?utf-8?B?aVBaNjdDVUV1Q2hjTkpzM3ZwRjFtOGZaVmFHbG02TVVZajdtUzllV1JqUnVJ?=
 =?utf-8?B?RWJ3Qkc3ckEycERUejM5aGo3RGtMV294SER5bEswcHNZT3dXWjBYL29pakpD?=
 =?utf-8?B?UTR3cmxhOTBZWTFjU3AxK0lMNWxGUEMxd2tVQjVoeGZ1dlRhdVhlRkVVQmp4?=
 =?utf-8?B?WjA2eGx5RkNLMHBFWDlSOHBCV2lycFBESHB0OGpBS045VnNpUzhlbEdXTEwx?=
 =?utf-8?B?QVFiVDdJVDNNVXp3Tlc5eWRrd3YySW1BdEVuSlV5VS9FdU5oZTg4VzcyQVJU?=
 =?utf-8?B?OEsveGtLQ3ZYbjFmeCswdmpIalJ2OHBRZ2VhLzNQWE83ckhRZEdGZFJrOUZu?=
 =?utf-8?B?c3BXRE41bC9MdDdxQXhqUG1SSGRlQWtoQ3o0eThqU2ZwVlNnK0NBVzVKaHhy?=
 =?utf-8?B?aE1rYjBrS1FJQkpFU1I4M3FQc0hGbVhyYkFXb3dGcEpZRnNvbURVaktTeXJz?=
 =?utf-8?B?WWc0c2xVNndOaThZTjIrdVJGWHVmMGNWd2ZxdEhuRkl6QW5OVnlmSU8xbVFO?=
 =?utf-8?B?MmlWRXNQTVBaTHIzbmNReERJeVhHWFh1bTFUaGlDVHpJN1ZTdlZNVFRUNzV1?=
 =?utf-8?B?MFZZRFF4SW1Ud3JaLzdPUFVHbG1zOVhzR3B3bWljMzBhT1hnSGRsdHZKajdQ?=
 =?utf-8?B?NVg3NUFFMmVZMkZNYWVwZ0hicjVsYmFjVlQzWktRUDhxRHVLd2tBbW9aRHQ2?=
 =?utf-8?B?YWgzVlYrcmh3RXJUUWFNU2o3eFc2cTZ3OHREV3lja2hPdG5HMzdML2Y4aFhi?=
 =?utf-8?B?TUg2czA4UTRCWFVLSHBSVUtGNWJVTlBwWjVMQVRaMjFRd3Jpd05ucFVLTVUx?=
 =?utf-8?B?R0tEODFoUHpOcE1LZFBFSWoyVThsVEp4MGNqQno1UmoyUCtNSHJCdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d653f5ab-65a8-47fa-c43d-08defc4a6808
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 10:29:23.8974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1ZWwv2v9tYbf4XpKacaVqq4iWFVEhqgNNiZUY91N7OrP4B0go9D16QI1I75R4ruibQ8OWhGzwsej2MeTYT7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7177
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

On Mon Aug 17, 2026 at 8:04 AM BST, Eliot Courtney wrote:
> Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
> we no longer need this workaround.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/bitmap.rs | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)

