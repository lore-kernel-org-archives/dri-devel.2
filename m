Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE9CCD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C234E10EC79;
	Tue, 19 May 2026 11:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="xJG6/D3k";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C448910EC79
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqKWmOR1/h7/KKQJEsIhccKu1gyma+92c1JC4Oin9FS+/ICfb9Df5I0LOZa7RGc/xSkKtPbWmwYGlyPZU3/HUYOokaKuoxqAbDk9l1FhAjcEk6n3XKe4FJGWRXy1S1Ge+DxxNZBA8gjcTf5FxfixSwi/QTd0UpuOjikOanV/XFSl8G8ZLXVkM11UtRn/O1IC8mM2U8aZ7Jqk/nAVD0+shxTJPZKgpNp1xih5JPMNwj93ozr0b6AvwYbn9luLXHANahIRkkI7s5h1sZst7z9wu44hWFQx8N9tTcSNK3kn6HUZ09Ri4wqaFxzfG0rqNUqjXyNzOJmOcfCDY+wGyCuqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wILCKVeuJ9MROrocp8UynItCP5TcdZJwetnqeR3Y98g=;
 b=k2VcYuAT2xzqIAKxLyP9lJbbCYU4r8u6QiYlvY6+fN0KZ+HAP9Uf2uF52dr+4sgfdaFC8DjvKOQl4by5A3Iei+c2o1jAZ8ZsWFkQFYb+tAzr8icO+t/9jKlqGk2YhW8ImvWix1xSFE16Xi9dH2P6ILUkUtDXLQrnThMXyAcQP7dwsRoGRDz/DPNkRr7ggxNw4i4eJtra5OZTgpTi/ws0GijemT9dlrmieT5bV1AfS2SmDysF5c6voF9SR5r/ATJDM66/D20SYgb/m5sp4JXQOLZr8JL86KqqRMif/ZKWTpgfCXRI7YZYaX6KMlXA6X6AAAcmvAh6KZRNFqw1kQ8mVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wILCKVeuJ9MROrocp8UynItCP5TcdZJwetnqeR3Y98g=;
 b=xJG6/D3klr1NmVc+stHeIkehm4NmPQ9UTWWLv83FscF1GUDnrlN47UXSvucTywTLxzic2bJeXV1t45IICjfique6e+GmuT2+B5LK3fIUSFxv1LoRcg9J0aOfH6B+53+fTNXB1UBvU0P3t1ySEvZ4CHC3E37RuwNiA1X+yn3ghXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7552.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:216::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 11:57:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:57:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:57:06 +0100
Message-Id: <DIMMV5AQECQK.68QNZS7YCDOF@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH 1/8] rust: module: add `MODULE_PTR` const to
 `ModuleMetadata` trait
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>
X-Mailer: aerc 0.21.0
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
 <20260519-fix-fops-owner-v1-1-2ded9830da14@linux.dev>
In-Reply-To: <20260519-fix-fops-owner-v1-1-2ded9830da14@linux.dev>
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a811ff5-9389-4a86-0987-08deb59dbfdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|22082099003|18002099003|56012099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info: 30eTeow1+MpwbGF4/fOeFadJc18z8+hei5Njm3rOon72VcUjU6CYeY0cjo/C+2GSus7/jndxXcdWXhax7o6fetkVdPo5DpxEonmLZ4W5RapOFixXmBbEBGfBVvsAi30Grmeg6H+H45Hh3vovXHpU8XgyCP7dXRFCVbj/gqFfUeuQCuwHf2cUuLBffFVpFgfpvqAZpIjxf8tA0XnY1bqqiBnmqA9Y5DvR5aPgaE4MBRGF7YKUAn7rqn3a9yF00KVa6vayghNZnXKmxVChWfJp/ZIVjDXloKtqL1d00YaBwH7vKRzVJFy116RyJOQA1DMt88tQlDsniun7kzBb1FvtOu9aHQeHcevmYXK6gQcwSzJc+CA/TK2Sm6UyKxUQHmTC7PkTTxaB8HcPsr3rkAwB82y0hXLnUdNFxHjHjZU1joL7XTjAaw+wBDbQTzzTBkk3bVMf711VXTrvElXDZe6SzZq1Y8TO7pavhS8F6O0CAA1hORrxjl4BgmzcBNSwLG/sQ9UC2bpt8pWxwLU6yq0QQ8I5giTfeUQRpx/8uxHl/Xu89xAkUgAnhiqMIlFh9PuT8JZhP7Fe6cA49aNgR1aIQgjxOZLqGQ3iG2CrTASw+j0ifghZM8EI5l6hCKut+H4BlNqtzw6aYEO8lz/W+KVxVO6MEec0bdaa2mA97KU/kAPD/oVwmYWeQppgpzSc6fBd1wAlLFDZVJ7DYB+lMTB69wo8h5A4lD9awDTUXHTp5eA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003)(921020)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWk3VVRSaTU3YldGVEVaRGRhdDMvSE94cHUzV1ljZXVBWnk0MDdzRDJNdFU3?=
 =?utf-8?B?WXB3bHFyb0VKYTJBazBWZlZHbjVjZld2Q3pSNkR2c0x5azNaSjU5QWJVWkNl?=
 =?utf-8?B?ZFhjYmplSllFalF4dkdVWjNhNTMxbStzVHByVEExOW16ZnhYT1RlOGdEV3hM?=
 =?utf-8?B?VjlQaGI5cFg3eUVwSFZKa1AyVDNISU0rRDlKbVJlSjRlZHpvbHZaVk5JNCtq?=
 =?utf-8?B?dGF1Rk93MmFlaXJ2SHBOWXhrejhUNzZaVDlqVWtrcVlvR3F2SVVFR0JPS1pE?=
 =?utf-8?B?dlVkVDhjVEx0MVdqWm4wayt1eWUvWTZQaFhFVERBWUxaT2dpd2VmRFI3NmlZ?=
 =?utf-8?B?MEFqUW5Bd3czd0IxdjQ4VjRVVEN0OUZ1L3phU3d3QzZHMjNuM2J3MS85VXBm?=
 =?utf-8?B?ZENrZGxlSVA1ZXNidmFvT2sxem1mTGU4TUxpUndRS3FtRWt3VkxRZ21nU2RE?=
 =?utf-8?B?cXZ5WldMa1ZSeE44aktDNkV0bU9TckRIQnFGbGx6bk9kTHgyUW1iZkhFVGcy?=
 =?utf-8?B?bkl0OUJNb0FiS1Zha3Q3Z3VKVzM2UUMxcjltbFJqNTlWZVhOdCtseUl0VFEw?=
 =?utf-8?B?K3VobnJobWhab1pKM2FFb1IzS1k4MW1QYWE1S2pSOWoyZnowaVlVQjYvRFcz?=
 =?utf-8?B?ZXVPZVQwdWxrczl4Ris0NmoreHVxc1ZxMStjdExuWnZWQTkwcFFmdjNYZ0Vx?=
 =?utf-8?B?cFN1RE1WTTc5YUMyOXFWRGZTYStxbkxSd00vcUZLb2o0ODU2cEQyZEFxMkJW?=
 =?utf-8?B?NjltNkJlc0NqV3daZGlFcldiUmExTkZlanNmbElReVRrZCtNSXY4Vzh4cHFD?=
 =?utf-8?B?NVJPbnVVWTE3NTJPV1gyMVNNTENiWVdLWTgwaEVtdFhZTW9NQXRnbEtNWCtM?=
 =?utf-8?B?RU5qMnNuSzNyaFNEdGxsY290eGRWRG5JY0JKS25veHZlZjRxODhqbld3T3FY?=
 =?utf-8?B?V3dEQlNXQ0J1M0FnbFJDcTVkVzRCTE9ScHZieldQRXZhaDVNNTNXMzhoS1Ji?=
 =?utf-8?B?ZWF5ODh3ZUJCa2o1RlZtNS9aVXFlS2hVRFA0dC9zdDM0K0RCRHBwdmNiNWVs?=
 =?utf-8?B?Q0ViZ3J1M1JRdGR1UlV3NGZONnd6QXNma2QvK2tqMitjUkRwT3pvRzNKYTlD?=
 =?utf-8?B?cjY1YVFDOUtjcjQyWW1IdTN1WHUwMzRSU3RtejNpTFNDWk9INU5tVEhFT3U0?=
 =?utf-8?B?c2ppZzNEWEUzRTJkZVNHTFFSeHhuOUw5UEc1UkZyNTZGTG0yOVVXZVQ3Tzhn?=
 =?utf-8?B?a1VKaEJaL056TVZLbUhaS01jUTRBMjlCR1RGZGJ3dlYrRTh3NVJGUzA5UVZl?=
 =?utf-8?B?b2t6enNhSzZEL3VBU3liZ0hMcFJrVzc1YnhZbEFkSWhGSHZpV1ZIMXhBaE9a?=
 =?utf-8?B?MmwrVXkyYzVlcGZleEJkbDRkV2doeGVJS05vZ0VzS29TQ1JFL2Q3VVJQN1lp?=
 =?utf-8?B?ODFlYXBNRVh1ZERYUWsxOE8wU2ZvdTVxYmxqZys1L3gySGhxRzM4d0dDaExk?=
 =?utf-8?B?YnVJanl6MVdLbThuenBycHgzamxDMnQ5TWZScnVwSjAvL0VQeXlSeWRaNFNh?=
 =?utf-8?B?bFBIZWZQUDErUkRkSEJPSlV6aDQwTis1amNTV1FoemtRQldHejhDZWpHUXV5?=
 =?utf-8?B?TjlCNUdBdGZQVWtUb3VRdjJvMVdJb3Qxd1JVOFM1NkNOa3g0Q3J3anA3U2FQ?=
 =?utf-8?B?bUJtWWFGNEh5Tno5TFFsa0Z5MUFnakVCRnBxMjI3ekpxaE1BeVcxVW8xNG1k?=
 =?utf-8?B?cWZGY2RTSG9YQ1lqMlJyL2IzRE0ySFJzRVNSWVBoMmcxN3dnOU5zcHB4bTRW?=
 =?utf-8?B?cnlzc28zTVhXK1RPeVgyZTJBb3pwbEE2YlppZ1N5ZEszS250eWlYaHdUNmpi?=
 =?utf-8?B?Uzd2OHc2WEh1YTlwVGFTWmI4eEJYUFBYUFZRWkV0ZDJpa21UWUJwUzJiWk9B?=
 =?utf-8?B?WVNZMWFNNXBBTHBlcTVCRVNGT1hQOEdrcjc1azUzTC9PRW95UHRtVDJub2FP?=
 =?utf-8?B?SjFoTFA4dVhRT0VYVWlHMVZickdXa2tBeFgzWkhFcU9sRHU4ejhFR2s1djlj?=
 =?utf-8?B?TGNrdzQzVldDN1psZ3JocUhVZHhCZC9HbTk4Q3NFWlZwUG9jSlU3MnU3TXo0?=
 =?utf-8?B?Y0tOSHZyUVdpV2wwWWJyRThaYUVLRTlBSWZENmFEaU5yVWlWeHFHSXZUTVNj?=
 =?utf-8?B?dk0xOEdWUzlDalRkQ0dDb243S0o4UlN5L1hVZHg5UFJnME8wUkVLMmozaWxI?=
 =?utf-8?B?WE5aR2QxZ3RYUUE3YzF1QTJWRkVSQkNReWN3ekZQN0dZb0M3RTU4WS9JMGl5?=
 =?utf-8?B?aTYzWE5wTzA0L1haS3dvUHBrVkV2Z1JucUQyNEhzYTRmSkFOcWF1dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a811ff5-9389-4a86-0987-08deb59dbfdd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:57:06.7457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1Zuzu6azrzvCY4uuU86bXFKVTw9vGmnpwKFTK0fxNJx5v3trKc8s0HIBpZSWkNwJYBOvHLOO5fzwHY3FPnFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7552
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

On Tue May 19, 2026 at 7:26 AM BST, Alvin Sun wrote:
> Add a `MODULE_PTR` const to the `ModuleMetadata` trait so that
> modules can provide a constant pointer to their `struct module`
> usable in const contexts such as static file_operations.

Please design a consistent API surface that integrates with the `THIS_MODUL=
E`
that we have today, and avoid two ways of doing things.

Best,
Gary

>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/lib.rs    |  3 +++
>  rust/macros/module.rs | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b72b2fbe046d6..c7e809636e1a9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -184,6 +184,9 @@ fn init(module: &'static ThisModule) -> impl pin_init=
::PinInit<Self, error::Erro
>  pub trait ModuleMetadata {
>      /// The name of the module as specified in the `module!` macro.
>      const NAME: &'static crate::str::CStr;
> +
> +    /// The pointer to the kernel `struct module` for this module.
> +    const MODULE_PTR: *mut bindings::module;
>  }
> =20
>  /// Equivalent to `THIS_MODULE` in the C API.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..7204fe604f24a 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -519,6 +519,20 @@ pub(crate) fn module(info: ModuleInfo) -> Result<Tok=
enStream> {
> =20
>          impl ::kernel::ModuleMetadata for #type_ {
>              const NAME: &'static ::kernel::str::CStr =3D #name_cstr;
> +
> +            #[cfg(MODULE)]
> +            const MODULE_PTR: *mut ::kernel::bindings::module =3D {
> +                extern "C" {
> +                    static __this_module: ::kernel::types::Opaque<::kern=
el::bindings::module>;
> +                }
> +
> +                // SAFETY: `__this_module` is constructed by the kernel =
at load time
> +                // and lives until the module is unloaded.
> +                unsafe { __this_module.get() }
> +            };
> +
> +            #[cfg(not(MODULE))]
> +            const MODULE_PTR: *mut ::kernel::bindings::module =3D ::core=
::ptr::null_mut();
>          }
> =20
>          // Double nested modules, since then nobody can access the publi=
c items inside.

