Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324C7C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D48010E5E8;
	Tue, 15 Sep 2026 11:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="t7k8skQR";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021127.outbound.protection.outlook.com [52.101.95.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E2F10E258
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJTarhjVuKeZvgXMwqU0ggJ95HnGq8Ssl3evxOn1zv4hzIITY7s7/UD2B08UG+m1LqTx1LSLdeF5u8IOlnRhdyoks05p9uUZNxyekpwaqJYfz1G2ANDiNezwcblisyMpt+pS9WHHOgwRG8cbEZ93z2YKy0DOKPubmg68qPSeubyZM0CO1OtbwRbsPdFVonfJdrN1bOkMX0vz86k3D9DV1tWWTHPWxO9LX6WVrBIcL1czTHUFI4plfYyl0Xh2nAWpGNIWB1mDpBZrscfVy8F21L3lXBSRFyq0Zu2kJpsJ74ehuGpkMOrfvjuFtrcR7v/q/YLgpShEgPV6fQFDzIuodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW6PjGWYubTg6PpRd0NhRdjO8jdZUqdrERa91pkki1U=;
 b=U+cKqCYBLhhEE14e+15BwTm/pxNFqLSIt6nDcnYBzRByVkwoM/GYnwXGtY+Aix51ZXH30HZElZp9OH/mUcU9xoQ3T4b3pyVeHX14H/TH0ZlBDtni7TrwcQzQ2mVMSoP2g98JQKq4jheCPsc0iOL6Zq308fEOd5/TTe8tlZdcZhLwKy1d8mO6x35G61qVEM1Pr4/kPizO5MzO/DYBsAuh59ipA8RfxVtwzCCCc6xjeuqSHg20W89rYxgRyMoN2tqUpSh8/rRgzO2KqVnzIzHdZeFaEqfuOy7maJ02dfxXMawqboxssScOyEcqwkODlivowpkI1vJunhzpB3f9NSt9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW6PjGWYubTg6PpRd0NhRdjO8jdZUqdrERa91pkki1U=;
 b=t7k8skQRmLpo0y4Ucx4QyzQ/HqGSCGigu776J2rpLe5kWafcwTZ3EamC+h6nfIIR3BiYNbT6PEtKPI1Z2a1LbjYUcXflc0NwG0jF0U7a9yoXUyV0+koH1gnVZqdj6E5bhERCbD9fSSaQhKBTj2HcUXjTQPwv7asPuvOzDpNNFzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO8P265MB7508.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:18:50 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 11:18:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 12:18:47 +0100
Message-Id: <DLFUKN84E2XS.33S0LZHBMAWH2@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <kernel@collabora.com>
Subject: Re: [PATCH 2/9] rust: io: drop the CONFIG_64BIT restriction on
 system memory u64 access
From: "Gary Guo" <gary@garyguo.net>
To: "Laura Nao" <laura.nao@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Lyude Paul"
 <lyude@redhat.com>, "Thomas Gleixner" <tglx@kernel.org>, "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>, "John Stultz" <jstultz@google.com>,
 "Stephen Boyd" <sboyd@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
 <20260915-tyr-interfaces-v1-2-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-2-5d28f1f75aca@collabora.com>
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO8P265MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8d4158-84e7-4e79-ace3-08df131b1e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qUrV5mvbTc8akPxBQ5klY8beX0GujuT77j6+KSJx4RyVWTfff+6MOp3YLpTI56eQkv3PaLoZP9GgNynfPSGxDYvmTn5LlTqf5whopz2MuLUMxYHGzG7koTPMmziGrFCbaVlMARzm1kBBhbxNycsVQitiBjWK9lmbmnoZHCLEkNqanGvO+dNUEhk/UoUsEG5QbierGABM/Upk2wWjUCu6XirghrCVNtTSIM6Es06khTgdKVu61Y1r1RMdl6JBp8PbaRy6sg+FTgCGK/qfxcA+7t13hyKx126spI3vVNL7MZPRY5aQEss6MXIqu501ePHpNBTUFwl+mEHvM1ELc9fXbElepuDobYskAyQLui/+70txz50CISbxFeSKDkYFGb+eSLut/APvACMkpI6+segEuP9UjsZgkEaVpCxhltzqtUUWtsEc6HHHseE3jTxQDaD7lD56E2wW6TanqW5cQQP24GJltB4ZvcEmz6z2sogZlKEmvHCtq5+8jfWyOB9zBbEEsaYcsaZh4R6Uo6jwW24nsm8Gd8ietx7+jsF3X7CJ2JCslI8vWJlIqASTxm7lXm+3RQkvmxGm94+srFTuuQSt5U14h338lOY5oTCtu54pC1u7LZ5P6gWGKbyRIc1f2jKY58hJ35Kd4wJYlsNdre5I+bTpADOvRF85aVK7cnFznFi9kihl9OmdPhROm9I4pG8G0fa/VdW/PmPmKfMa8aA9NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXRjTUZzaGxaNnVPVWZCVkhpcEIvVXFnM0VQV2hzZm4zRVhEQUh1ckIyczRQ?=
 =?utf-8?B?YzNTbTVvdWRnaEpjcXJnK01ZKytIL1ZPOHBkdHV0WEJKVnBlRHBCSzlQNkQr?=
 =?utf-8?B?aUo1TS8zbHNIdFZyaERMR1RwRlZVbEVjM29aZGw0OVZKVlg2M0hxYldkNnlX?=
 =?utf-8?B?MDVrWHd5UGFzby9pQXUzUFVFbVZaRURPa2JXU0ZmU1NKM29IWTJHOHVQcHhy?=
 =?utf-8?B?NkIyRFpYT09FSzBvc041UHNFMENneFVxY1hONmYyTGVmc2h1bGxrYmlQRlA1?=
 =?utf-8?B?T0FLWmNrYkU3bXNlQVVwM0VjU0NIMEt5d204a2NXVXhMMm04MWRoVmZaakRt?=
 =?utf-8?B?Qk9uazZGMjVHUmlTekt1eFRjKzRBTHd2U0ZhV1BhZ2Y4a2duek13eWVaMkVt?=
 =?utf-8?B?emZhUU1xV1J2TkNJdnVnSG1wZU1jd1hrU0lqQVdGb3lXYkhCcEpka1VNZDAw?=
 =?utf-8?B?eUNtaW5LMkVkZ3FVcnFBYTRibFlubEpmcmxzSHRoM3laSHl2ejhEcitFeXAv?=
 =?utf-8?B?bGJkcDVpS2xLNkxMWTVtUzFOdTNWVEVYaDF6N2NuS1VicXlreEllMFlLeDY0?=
 =?utf-8?B?eG5zaTR6RlJzZUt0eEhBd253dEkxaE5Zbnh2cko4ZWc2OUUrQ0w1dkJyNGVz?=
 =?utf-8?B?bXhOTWZXMjlYMHhib1JOdjhTNHBOaC9ILzF1c1I3aFNrU0xLWndkQ25zbC94?=
 =?utf-8?B?RkRTWUlrTlZqUGJKc3Uvd2tvVWtzT1hyRTI5MFFrblpqY1pPVEFaYjF1d0hu?=
 =?utf-8?B?THJSd3NTc3JQeGRtSy90TFBpS0ZMQ2dNaGhmSWNva2UvcnhWMzRFaUVHOWtt?=
 =?utf-8?B?TUNOZm45SnVOTXluVWNDMXZiVWFpRDVtYkV5bm5qYjFERG1LZG9hOFZLNlZS?=
 =?utf-8?B?U1hrdGQwaWZxL2ZCTlJrOU84aXNSY3dvam96SHV1UTdQQnFmNm5yZXJETldB?=
 =?utf-8?B?cGppdHRLZlNxRnZMeWJZalpiZjNIZW1lR2R0Q0hvN2FsNkFweHlRVi96bTVm?=
 =?utf-8?B?dlhQbHJ5dk15MElzQnlMaFJsRXd1STA1SnJGNTVycHp6TkFheDVza1lVR250?=
 =?utf-8?B?UlU5VDAyVllMVGJuZEZ6VDR6bVBmTlVJR3lqR25oeUZHSkxyN2dEODY5ak5n?=
 =?utf-8?B?R29BWEZBWGt3NFRIZW5rMEVoMytqQkhSZlJwV0YxWHNYUVpMVFNqZGFlTTFX?=
 =?utf-8?B?OTJjRmk5NjRsWGt1VHVkOU0rSTQ3Q3VVdWtGcVpyeTk1Y3dmdEtKUDNtait5?=
 =?utf-8?B?TmNpTW81ZmVZWWptZ2ZtMzBTQjRmRGV3a1U0aTFZMmd1R2JHR0g0RHIxQ0du?=
 =?utf-8?B?dytxS1h2MGtQTVdkRE9Vc2ppS2lwTE5Db0QxUGpSKzJKUVBrNEcyZnBDTWta?=
 =?utf-8?B?WEJuUFc2VlRKU0Ftcld3dmtZRzFpckdnY283TGJRY3NJVWZ5UUdHZDlPZkJx?=
 =?utf-8?B?SGk2Mks4QmdidGRSL0M2SE0wek12bDJPMXNKZytKbldHTkNYZnQ3ZnF4NUs1?=
 =?utf-8?B?VEZuTTVOcGF5R2M0c0hwbDM0SUthaDhjaDY5UGJ6K0paaE9kb2UzUlJxbUVr?=
 =?utf-8?B?TDBmTUxzZFg4UHB6emNjVDF5VG1kdTA2WnpuT2hMR2FteVROSjJxcHVJcTRh?=
 =?utf-8?B?UmVQUDl3KzEyVFRRaDVzQ1RMekNnL215UzhVckNtTW9ZS2ZXRE1xMmpidDhS?=
 =?utf-8?B?QW1XVzRPVzBqOFRZdUZhQmRsOW0zL0prLzB0eWtIREFPWEtuM1hscGJzT1Fj?=
 =?utf-8?B?RW5jYmhzcUQ3QkxHenEvbjcySVdIOXErbXpuMGE2bWpoMGRiaUtOZ2kydXRX?=
 =?utf-8?B?VGZMOUpjbUg3U0FYM1pRcXM0MFZYLzlWUGFvQlNEOEhzc2FQWVAzbjFZVkVs?=
 =?utf-8?B?Yzh1VllUTDAwZFFxenNsODBvK2VVODgrdVFnVm90NDZjR0trTmRPd05qRzJm?=
 =?utf-8?B?Qm9hdEFpVnlKTUZDanlFSGZpN2dVLytyMDMvM1FZcGhZMG5uMnVTcTBVSSts?=
 =?utf-8?B?TzhkUnBHQnpLc2xjcFh3TDJ0cjViUEgwdFBnNTF0b29YRnlxRmlsaHJBRHNC?=
 =?utf-8?B?TjJEQjEzSzFwVlZ0SmVXVEVoQzA5elFrWjBlcERKVkNLSHYwNFg4ZXdzQkhx?=
 =?utf-8?B?Wm5ZWGNKMzVaZmVudlp1Qno0TXdTbmk2d3FaVFlUekh3UitHS2N6K0MrRThq?=
 =?utf-8?B?S01aZ3BTSXQvZ2tnZU1EZ3o4TlJmZUh1NWZjeHRWOWllNkkzcFl5WVp4MFox?=
 =?utf-8?B?WmRaZHhKa2d2TVg5K042NUdSOUUzVEZYTXFuRWQ2MmV4NC9OckNnSXZXWjh6?=
 =?utf-8?Q?grDFQqgw4wVvP/OzKS?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8d4158-84e7-4e79-ace3-08df131b1e4b
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:18:50.4328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFJGkwE+sXPl5lQ685K6t32BoMd1wcnO2EjeV/Qj567+3xPpR3T2eR8Lf8oMJnIsWbYNHtqROT98liDICUDlHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7508
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

On Tue Sep 15, 2026 at 11:57 AM BST, Laura Nao wrote:
> SysMemBackend's IoCapable<u64> impl is currently gated on CONFIG_64BIT,
> copying the MMIO backend's restriction. MMIO needs that gate because
> readq() is not available on 32bit. System memory has no such dependency:
> a u64 volatile load/store compiles on any architecture, it's just not
> single-copy atomic on 32bit.
>
> Drop the gate so u64-backed types, such as bitfields, work on 32bit too.
> Document the non-atomicity at the impl instead of enforcing it at build
> time.
>
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

No. If you don't need atomicity, please use `copy_read` to read the value. =
It'll
compile down to the same volatile read, just without atomicity guarantee.

Best,
Gary

> ---
>  rust/kernel/io.rs | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index de8ef8e2aec4..a85ddd07cb7f 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -1428,7 +1428,9 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
>  impl_sysmem_io_capable!(u8);
>  impl_sysmem_io_capable!(u16);
>  impl_sysmem_io_capable!(u32);
> -#[cfg(CONFIG_64BIT)]
> +// Unlike MMIO, that needs `readq` which is not available on 32-bit, a
> +// system-memory `u64` access compiles on any target. It is just not
> +// single-copy atomic on 32-bit.
>  impl_sysmem_io_capable!(u64);
> =20
>  impl IoCopyable for SysMemBackend {


