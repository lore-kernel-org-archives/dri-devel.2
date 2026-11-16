Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FB606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=LxM/x6Sm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F7210EFC3;
	Mon, 16 Nov 2026 12:08:08 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021085.outbound.protection.outlook.com [52.101.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AB310EFC3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQijg9EAHzO2LSe0cyla5pBhf49ht0rl/zALv0LCn27MK+mcdSPg55KHft3NZOSNXgwiiwYwy/QhAKd6BDA/xhAFe1pl7gWvT3MWW6qz0V9jhHGRW+Lnegt8YxZdWPpV5dPDTR/oTn0pvW2Fut3D1UFqC5PNEy6g8ZL0otziyEfXbr5d+9020AdGDWsXUOL16lvehLOXvF8SBoaRJp8m7ubbeVoDnBLFDj07D4R4dAPHmRNZwz0DCjYKdOGDPQRLrH59PJ8wZ2GszzaQrSnF88vh0GEK8irCJqkhhpQP/2Zzt1HTdWCeY1dLgMiNPgID0+BWmZOWiCZHM5olvmEUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kelrYgrvywo22uHR7hya4tdY64YmoC1HBo9FZ/1sd9c=;
 b=IAYZvrhjqYNpru/brLxi7F3SWewefYfOuLGW41ghcbQK1m+iyPZWdwwxGRoCjpiSWEGNZJK12Fn3/a6/3RP/ZMbayFeOWqZq5UkuE48i0ZyVCjB5NP8BU+VL4u+23W9T3yvqlPs4MY3XcPnf0F2rJafgDf/vSYhYFBO8XC9cVTMpkigZS7/+uwa9c7+EA3v5a+XVshFjGNp1sFvJgLQ0/uqxHG7Y6N1cB1YSec6Zssjw9uppQDcGkqoxPQa3yRfs3SS9mczBZxCiAPJURK2YIdqMCgPUODb60lBB4kxEbLnegD9esr0FAMpF6qS0jnmpE3UkKMg/XElmxxzJCXa44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kelrYgrvywo22uHR7hya4tdY64YmoC1HBo9FZ/1sd9c=;
 b=LxM/x6Sm84O9SW86d1fIhDiArUZgJd19hSARJkMFcU7cToVU3APTL6PKTqEpFZJsaM3E+2svOMH/ZUVD3GueOLjyH/X1YivU2kkxRopHQHUmxP7KRhGeEeoNMS9UNjcUhGRWefPdCfMpaGXqJH3T8eMnWLiunIPFrmZXbNSh3GQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO8P265MB7781.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:07:58 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:07:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 12:07:55 +0000
Message-Id: <DMWMG16XGPYB.W659Q8DBV6F4@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Ivan Tverdokhleb" <mbkchelofficialdev@gmail.com>,
 <rust-for-linux@vger.kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Matthew Auld" <matthew.auld@intel.com>, "Arun
 Pravin" <arunpravin.paneerselvam@amd.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Waiman Long"
 <longman@redhat.com>, "Lyude Paul" <lyude@redhat.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: sync: lock: allow fallible initializers in
 Lock::new
X-Mailer: aerc 0.22.0
References: <20261114200703.33229-1-mbkchelofficialdev@gmail.com>
 <20261114200703.33229-2-mbkchelofficialdev@gmail.com>
In-Reply-To: <20261114200703.33229-2-mbkchelofficialdev@gmail.com>
X-ClientProxiedBy: LO4P123CA0187.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::12) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO8P265MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cc512d-3f93-48e8-d85c-08df43da3f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|376014|7416014|10067099003|56012099006|4143699003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1N31fs1g541M26c58ncmGA2neruFWOiXFXewsHl7RlDzMFwnp/dDjyvtzfBpAVvEavdmRAtzr3N1LCytN6G2pMkDxBoruQGshnImART7BQwyGu6nmXEbK0JbNFLP9yGNvjqq00aTE9HaSNEe3sLn01d7XJIFbf+DK7frIq4/si3Xwu7T/Biy2ww7aL8Pa5iUIaopCy9nAaicoPNR0JPRyaMuG8qF8ZwQrK4WQHqubjxnNqTNvbjwZiN+cUy0998jTP3LOVtouwxLIgSvcHke26WtjsIcXvsyhfKV+IGscKe4VGzhe0XloVgTA+FnX4gWtTj55iOc81Rfe2xq+7dRRPV5cQ19klxEG/T/8XEmOKUrXsoHYQI6IXnLMfDXaX+7P+R1LHSeoE6/nFfH73MEH5jfM1NBJG9N3xI0I4vwuaObO5DBe307HxPeqqc3qxKLT2m9Gp7E978nLvNIH+rNbyiqROYn2C+yyuAewTTJ02lr0fhscQYgJp738yiae0XN13V1U7kV430lmEVFQeCt3GI56dgOmQI8tfOt+uLBALgNvCm0P3/hvdkXzWbVJ01YJ9BEz8ln8RbntAvN/9PlA+kvNlHb2G0jBhwbeAeXFPcbYI4g4davmtmnNpQUvdsk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlvRWh0bUpxUGJBeDVDa0dyRThDMmY1UFRYR3ltWVJiK0gzZmVCRVVqV1hK?=
 =?utf-8?B?VEM0WkJ2cXZZQ051Skd4ZXBZL2VZcmlaWUhOSmxkZUxoZVdmSnhnMGNvTy9m?=
 =?utf-8?B?MHh2cHM4K2Vqc3FtQXZzbGpQWHc4UW5nOGhHckZJSlg1aTJCODRnaFY3YnBw?=
 =?utf-8?B?Vms4UUJyT2RvTy9ZOW0vTjNOT2RwL28rU0VjcSs5dUxZN3ZPSGtaeCsyaEI0?=
 =?utf-8?B?NTZ0emZoQUNqRWprdGJudU5xVG1RcXdFQ3ZudWZuQ3NvYzFTdm5mWnkyRVc3?=
 =?utf-8?B?eThtYkIzdjRRVWY5cm5ocjFWc2trZXRvblZZbjZVWnpuaVRNTEtrTFlzZ3U1?=
 =?utf-8?B?a3hEMXlBVVc2VDRxMU5rNndCZ2xvOWhzeWRTLzBUTFZoL0ZPMDdGaVorZUpt?=
 =?utf-8?B?Sk83L1FhN0xqdk5LYmJTWGxicnV0bnFXWkUrM3MxLzdYMVg0YlV2Wm0vWHVw?=
 =?utf-8?B?a1kzQm40SE9nbGNrWmRiQVl0ZHlJd1h3Nm9LVWQwREx6T3AwZXdEQWRPK2Ni?=
 =?utf-8?B?Ym1GdmxsK2JJM3JrZ2ZycUhoYXNXMUw2YWh0b2prZ1BsUW80K3BzeG5CQkJQ?=
 =?utf-8?B?Q2VRNWwxbDlHS2FMQVVWbjVIeDNSZ3Q3TU56cmJmdUZ0aWxYa0xNb0w0VFhv?=
 =?utf-8?B?OWVuVTJpcXp4bVJJbnN0cVhoczhyRjVjWFlESDdiMlZDbmk0NCttdStzVDNM?=
 =?utf-8?B?bTJ4aUdaQnlRSXNTMVVVaUdBUDVycmgyVU9IVGhGS2RscXE3T2ptV291YVNJ?=
 =?utf-8?B?SWhHVWJhcHl0STdyaDNld0RoOWVobHd5aURTT1F3RExCMk01UlNIS0t0Z3lT?=
 =?utf-8?B?MEpTSUNuT25HaDNQdWEraHpJSW5XcmFaN05FTSt6ZmgxS1RzaTYwbHhOUHpx?=
 =?utf-8?B?NHBtbXJwbENDZ3pMazZocHB2MEpjdkxKR1hXNUs3SUF3Tkc3YUlhMUU3S05s?=
 =?utf-8?B?bU5VMENYbE8vdFpGdUFJMXdlVjZkNmRSVkFCVXk1NWhnRUNFWnlGRll1cWpR?=
 =?utf-8?B?MlhwajZHRmpxVnJnVUVrTDJ2OEZURExOcXFGNHdoei95c21oNm9QWk05WUZn?=
 =?utf-8?B?OENBeFN1TlhrOG5nNy9yZURDWmYwMDFDRjlrS2NCamV3ZGloeStJRmJWSERR?=
 =?utf-8?B?TWV1MDZzeEczb0ZFNzFNTlVGaGFMQ3FJZXhXMTJmWWF3UjUxcEkyVzBzTE1i?=
 =?utf-8?B?RDUzQWxjRUtlZzJxWER6MERpbmF2ZFk3eGxGYk9tN2tUMHROa2NVQmdoR2V1?=
 =?utf-8?B?WXVMVGQrR3Q3UlMzREthaUpDY1NDQ2poMFFqb1JyOXpDQVM0TVRZSkpMV0d0?=
 =?utf-8?B?Nk0zL0RlNzIwS3pDR044bWZNWURPNkU1cHdWY1R5Ujg4Q0VpNzEwUTZEQjI1?=
 =?utf-8?B?UitkekUzaDMrS2JnaFRXdyt1bjFqZk5CQ0xVTmxMc3Rwek8wZkFuRTBTelB1?=
 =?utf-8?B?SlEwdTgvSmFrcWl5c3JrdTF4UG9POXBRejZmNi9Femc5N3VoeVN2R1FmSFZu?=
 =?utf-8?B?UDJRVlFJU1ZzK042Y2YvemgrbFdPTjJHM0M1UUwzbjVFSzB3S1U1L3pibkhC?=
 =?utf-8?B?ZG9zQmhXbW85LzJZa1VPakZjSGJucHZHWVN2d29EVklNMlNBUS9FLzhqN1dW?=
 =?utf-8?B?UW5XRVV5LzRBTU5oWVpVbzk5V2NEc00yckRIRk1zTEs2bmNNYkJEdVJvTUdi?=
 =?utf-8?B?YktueWU3YXJ0dVg1TVg5L1IvcG5teTdSb2FiT1FUNW1UUVQwellaYTIvTlFq?=
 =?utf-8?B?Q2x4N05sUTFHdW9BZTgrK0lSN3pHS3IzSjZoTHgyZUtiM0t6OFNUQVYzdnph?=
 =?utf-8?B?a3Q0VGVDcjNUSHZJUk1RSGs2MmJnZ2Y4V1ZXNjNNUHFtVHhXazZkbjNCTFB6?=
 =?utf-8?B?Sjdmc0pmbmFib204Z3NhRGxrekdpREVIbGl4Sjd4bnVxejRyLzVsSi9vamls?=
 =?utf-8?B?eVFyV1A3Q2EzS09sRXRMNTNpVGJKbGl6d2RUYWYyL1ppU1ZWQUZuaTJTdlZZ?=
 =?utf-8?B?bGhyV2s2WThPMWY1MWVCRFRTMGV4Yk1OK2ZwV2JvTk9ITUEvYmxKZ1FRTFNv?=
 =?utf-8?B?aCtFdW9GWkZMYm13Z1pTYk9nZ3BnTW1wZG9oSHVrUVZ6OHB5emlodmZMUnk3?=
 =?utf-8?B?aVhqM3N5SVNhMFBtdUl3a0RZWmdjZkl0dWFuN295NjhhMVRKOFpHT3RkUHdC?=
 =?utf-8?B?bGdrU2NtZWRNdVJpYURiY1JlYlUrL3ZHamVocCtvS09GQ2E0cGNqM25GS1VF?=
 =?utf-8?B?dHI4SjJNdklUQkRNYXBDZ1JyQXo2RFBhbjlpZmZGRmNFcmZZeHRaNGEyOFBH?=
 =?utf-8?B?WmIyREJCWmxaM0c0MytUL1ZFYVdUQnVJcXpQNEN4NnFhR3lGZlZydz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cc512d-3f93-48e8-d85c-08df43da3f7e
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:07:55.8172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8WDuIhCUQaKIrar6DAFqlil6RO7xRgjnO79VHUAaPVpwTFY7m7bke/+3nGn/mtvNAXddjS0bF5HSa5lxAahuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7781
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

On Sat Nov 14, 2026 at 8:07 PM GMT, Ivan Tverdokhleb wrote:
> Currently Lock::new() only accepts an infallible initializer for the
> protected data, because impl PinInit<T> defaults the error type to
> Infallible. This prevents wrapping a fallible initializer, such as
> Opaque::try_ffi_init(), in a Mutex or SpinLock.
>
> Make Lock::new() generic over the error type E, so that it accepts any
> impl PinInit<T, E> and returns impl PinInit<Self, E>. E must implement
> From<Infallible>, since initializing the lock state itself cannot fail.
>
> This is needed, for example, by the GPU buddy allocator, which has a
> TODO to move its gpu_buddy structure inside the mutex.
>
> Signed-off-by: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>

See https://lore.kernel.org/rust-for-linux/20261022160725.2215244-2-phasta@=
kernel.org/
which is already in linux-next.

Best,
Gary

> ---
>  rust/kernel/sync/lock.rs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 10b6b5e9b024..26c071088b02 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -128,11 +128,11 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for =
Lock<T, B> {}
> =20
>  impl<T, B: Backend> Lock<T, B> {
>      /// Constructs a new lock initialiser.
> -    pub fn new(
> -        t: impl PinInit<T>,
> +    pub fn new<E: core::convert::From<core::convert::Infallible>>(
> +        t: impl PinInit<T, E>,
>          name: &'static CStr,
>          key: Pin<&'static LockClassKey>,
> -    ) -> impl PinInit<Self> {
> +    ) -> impl PinInit<Self, E> {
>          pin_init!(Self {
>              data <- UnsafeCell::pin_init(t),
>              _pin: PhantomPinned,
> @@ -141,7 +141,7 @@ pub fn new(
>              state <- Opaque::ffi_init(|slot| unsafe {
>                  B::init(slot, name.as_char_ptr(), key.as_ptr())
>              }),
> -        })
> +        }? E)
>      }
>  }
> =20


