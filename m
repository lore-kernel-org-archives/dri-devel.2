Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7D606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=JwIG4zFE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8999410E4AA;
	Tue, 20 Oct 2026 12:31:14 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022125.outbound.protection.outlook.com [52.101.96.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0674210F542
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 12:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8WvqGCTywxl744jPEMwNrAM5KHZhkypjYhHiFsD9UnDd7yXAPRwlgapsKu+Ld977VxWQllnWdFvBjH+ntxQCpiEBBL0ZyuAVDIzWW5eVO62djMlutsqgVuxGpxwIospnD+L/P9hsvIYJFoo2l3b37Z8/kl6QgvjGFEdyVkgdJWZyeQu7/KLlkQcQ/RcB6XQQVLz/GTv3i53SI3xKkloJcFMd88jJ7E08c31/5LCleKS2Y/Mmplwvgcmr4Nb7qZSp3smVutOdktmSTTGha7sGmV4y76ohmx9q+6oLzylBBLgeRXyYP3O75JC+ZLUYTegBLifO1brmJSPAehDNys3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izr1WTaXhNiPHO/7L5HZmaUpwDQ6br2cj7eXARkXX0A=;
 b=BeqyPVhjVLxaiyNg9QB2Clx7OBZypYzRKxX1OfDFiMBOMXnjoywHo5mWGEp5i7PIEb7XmFa8H/z7/zDzD7+G9YWnxkb47cbVoSPvJ/tJnVhq8OXPCC1eSIzZD/ptF19T3Z+WooRQiax/vDT8yfmEVGj8r1gr8vvAP9XbtPFnwc59MvWoHjlDowM08NwA+XKcGzC6qfNsjDjLo5fpz22EoKHhkCGBTS8ZScubUeh2ft/QsUmDO3EGZy+kzwT5LLesqjRAbedHbBJ+o39f6Tz1TSy/jeNKthPhUYjP6nFohihrCIyNGYYncpXPyN4Y1jheO/ceCq+Q4hAtd8Fjpz1/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izr1WTaXhNiPHO/7L5HZmaUpwDQ6br2cj7eXARkXX0A=;
 b=JwIG4zFEwJyx82RbeDTnuRiW5SRynLUOIJhvhP7eFsVquRxxWozm7S/AtcN0g2FKu1VqstKi4ANmEfwADzkG3+RJlqhKsUc02w+0cSmh68FMC9y4ME7uTZMNahIDIGtDNpxJ4Ik3pZgvTMF/cmBTg8A5nX4cUXN6eHSdmS7lTyY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB5187.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 12:31:04 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:31:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 13:31:03 +0100
Message-Id: <DM9O11JY63Q2.1U3PB5GL0JYOQ@garyguo.net>
To: <samitolvanen@google.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Lyude Paul" <lyude@redhat.com>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: gem: shmem: do not leak pages when
 sg_table() fails
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
In-Reply-To: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
X-ClientProxiedBy: LO4P123CA0297.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: b3639d91-0a45-4c76-3dab-08df2ea601da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|7416014|376014|6133799003|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: wbfEP3ww70YkKoGov/Ati+9beVWSM5tW3d+zbwVvvjBzlSHDSTfL96SasI/QFO0KePOA+vqDyJZdATn8IvfV1GXKFu0oWs8tWCi2THsF7mZXblrQcVi2kDdmH45lIAc+pwLeREcd75uC+OT4xmj2GVOrX/FxfrUXEZg29YFnGGDimIKY/rZvXPyVvO+SAilVIRR4MR/AGGe+1uGuB23q58qn8nrpTxp5l7UoUUYLcxsKTGEKFYLT0ny47gd/LATlY+EUXZATjuM9G2lKE8n7BnA29lg8ttL9C0PPnbIbZQxHBOxEARzvl9d0QE1uu0L6G8lkMEp7vT9eWL885IseOwAuRKdmbaRREdl3iiSrb11Fd7cm0QaUBNuEolCO1NzCEZeij9f96UaOguGeqNe16Q8Y8km03+K2586rzxa9i/leLopyRaMpAOKNxhCj9sgUSSTu1J0YWurICBtotXUn6J0PfmkEUaf8N7k2NHuq83M5j5P0L4C4IT9yd8GcYELY9H6Pl2ZprfuNP0M+9Ycg3jOAHv0S3h211w0vMbfgpZlsjPIOXWwMfm3r/6op5OIF5p1Mr5S5BhFaXwVF1alw6YpuxVghL1Ta1fSaQQBQeAUl6XbSY0NQgXA/61LVydL4bIRMUUtJjGxNlpT6VEMX45x3wpuCagVUXat4GA7y0bO4+IbM79yjOKWXu6pad3Qus7ITccpQzWAfZmFUjnzLMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(7416014)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEpyamdtYWJDYTFNVXBnZ1UwdnJrZ0dMUmJMcDlDZjZDMkUrTFRtTmlpSnZw?=
 =?utf-8?B?aG5TZ1paZHYrZ0lMeGhsTU9pNXJTQkg0TFRVUTFNOTV0bm1hZThDZ2kvNnlC?=
 =?utf-8?B?b09KQ2srMDVJME9OeVNUWHlyRC80ZW0rVTl4S3EvUHhCTC9VWW9CRk1XNW5z?=
 =?utf-8?B?Zit2VHB4QmdRbk9YN05zME91S3ZsNFlocTlQamtLRW5FcHpBQThkY25renFO?=
 =?utf-8?B?VVg3ZGJTajJ4ZzdkQmJRNzg1Mm9CWGtSemtyYzNBS201U0t3Skw2djFmNUsz?=
 =?utf-8?B?TzU2clVhM3ZDUlVRcUFtemRrenJRRWR5bVIvUkVsaVB1YnRDS3R1YS9JdFlR?=
 =?utf-8?B?dC94aytSa09UaW5JUzhxSHNGdjZlSzQ0TiszZU1WZVRWT2cxSGdUQThNWXdu?=
 =?utf-8?B?WC9QVFJzbWV1aUI4N2pMOElVazZiY2NrYXhxYUx3eWVzcnVZcCtNcjBHenpN?=
 =?utf-8?B?S0Z6aFdjdDhxUW9iblNEdW5Lckw5Tmw1MG05aDQ4ZzVOMEo2R0dQeXU2aVhC?=
 =?utf-8?B?a3dLSkh5Z2xMOEd5TzBBNUtwN0I4OFJoamUvVHgxa09xaWpGdDVKR0lraTF2?=
 =?utf-8?B?NnZITGJsalB2RnBnbURUT0VNWUJvZExHekpJWXNtSnphelN2aVhxbittVmdL?=
 =?utf-8?B?UVFoY05jSFVwOVdMaEZvZHRDeUVST2NObWZrRVJFZWY1Tm55NlEwdS9CQWcv?=
 =?utf-8?B?MytjTDRTWXBhQ1F6d091dGpSdGlWbWpCYU5LdldTOHN6Y2ZsYWJGalhDTDZY?=
 =?utf-8?B?MFpxZkxxbENMUFpVL2tZcHcwODdMNk5NM3lCekFSeE15Y0hhbm9ibVhNNTBj?=
 =?utf-8?B?WHovSVVlMFE0NG9mbzNRNWpDUnI5bUJqQSt6VnJ6U1ZJanV1TUMvbUloUjhk?=
 =?utf-8?B?RzBZWDdTZGxadUFBdHVGT1BIOGk5KzJMK2NZZkxoZG9TNEYrRGxKRUw5YnM5?=
 =?utf-8?B?azRjODZrZkVDTWJRWDVMbnQrc2hjU054S0tzL0R0Y0VDQkt6citrWkFBMGtE?=
 =?utf-8?B?alFZVjZhTmFySnpzMC9Ob1REeHpmQ1M0MWIyNEJ2cGpXTEUxRTdCWG1Dd0xT?=
 =?utf-8?B?SHA1VENHZkpsb3J4TGt2NVY1WlAzd0FJYVdZbkVXUnhuYW1FNlV2a1lHcHgw?=
 =?utf-8?B?MVI5Q1YxcFZ4T0dkYnE2V2QwSmxqazBaZFdwS3hUV1FCKytjN3ZORldEV2VG?=
 =?utf-8?B?WHh3bTB0bnJtNHRGaDRZOGFSRS92WTRQcWpNN3pxdzkxU1gzSE9jNXlIbHFw?=
 =?utf-8?B?Yk9RdnU5R0NGOGprNSt1T2lkVTdIdXIwSTJTUm5rVmw0L1BHZXhFbnpVTFBq?=
 =?utf-8?B?OExuUXJaL0l3K1RjbERlZEtYdVNhV3BJY2thUGQ5RXJwblovRWxBMFAxUjBH?=
 =?utf-8?B?RllDWnQ4eTRHZWIwRXpvYlQ5MFBwWmorbXY1MWNPZUNhTUlMQW5aTG1qanVn?=
 =?utf-8?B?Rk93akNKdjU1TXUwZkoxZExtWU1PeVAyQVNlZWtta0dpRStvR3Z3eWZJNDg2?=
 =?utf-8?B?M2w2UHRzNDErNlBlKzhUVGpmM3VaczRlZFZEYkJ1RGhpUzdIeHcrOGVmd2FK?=
 =?utf-8?B?ZERya2M2c0xweTJlc0tYbWVEaE9OcFZ6U1ZRSndjdjVLaHIyOXVjejE0UGVk?=
 =?utf-8?B?ajJWamZ4NXBFdXloa2d6U1RLNTlaNDE0Z1h6dFpmcDhhQ1lvdDg4UG1rSzlr?=
 =?utf-8?B?bExIdkNxTTR5OFdHK3ZqRlFoVTlkcEpFd085TW5JMERzUGJtUnJWem1BN3lX?=
 =?utf-8?B?ME5XbjVBOThkTTQxTmF4azlueDlQL2FrOHNtUUN2aFpaVFhiaWQ5QjJCZW5q?=
 =?utf-8?B?Q1Fya0daSGV3cFVWVGhseXdTY1RkWjFZMVBYZnQyUWd1Tm1HSzNMM0l2TCtP?=
 =?utf-8?B?aTgyUkpGWkpJWVJxenIzbURjU0RKSE1IZEo4RC84bVZ4NWhxdkcrUDJJYXpt?=
 =?utf-8?B?NTFEV0pqanppbVc2bytwc1RFdGRDbWs5MndsNUt3RDhaVUY0a2lsUjJjbnVj?=
 =?utf-8?B?b0UraHpzd0pWTVJ5Qy9ROUZMdDYrWCs3MEhkYTdqK3lEcEJUMFQ3QmJYK3BL?=
 =?utf-8?B?Mk5taEFmUEZxRTJHTDVWRVc4MFVuREE4akxucnB3OTg2QzQrRlFXaVZKNTRr?=
 =?utf-8?B?S202RTNKdlRKOFlqbTBtUlJLSjNYaC9FWG5rOVZaUTg2WVd3U2FNeUp4aVlJ?=
 =?utf-8?B?QmpGd0tPbGJMYXVYWFFWRldYMmFwZzR2RnNzblVSNG9JTXRTNnVBVk5sWGZC?=
 =?utf-8?B?cGQ5anNqbGE1eDBDWmZlK1RpeUU1TkplY3VDZGFSZTdvYzJPSnZCQVFudEF4?=
 =?utf-8?B?T2dWM3pUb1lwTi9pRjhQWjRJOVUzQ1RMUDNwVnEycGxHMHRPU0NNUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b3639d91-0a45-4c76-3dab-08df2ea601da
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:31:04.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBYYo3do1yhMDKB6ZfC0E3hOsOQCMeTvntqoKmfhLleTv8dhwQ/Ljax5D97n378K3LvRExc0pDdPCW3X054kWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5187
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

On Mon Oct 19, 2026 at 9:21 PM BST, Sami Tolvanen via B4 Relay wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
>
> `SGTableMap::new()` takes a pages reference and maps the table before
> `Devres::new()` allocates. If the allocation fails, dropping the map
> frees the table but keeps the reference, and the next `sg_table()`
> takes another one. `drm_gem_shmem_release()` puts only one, so the
> pages leak.

Sorry, could you explain it in more detail?

Creating a SGTableMap and dropping it doesn't restore the state? If so, it
sounds like an API design issue.

Best,
Gary

>
> Take the pages in the initializer, after the allocation.
>
> Fixes: 616c229ab010 ("rust: drm: gem: Introduce shmem::Object::sg_table()=
")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  rust/kernel/drm/gem/shmem.rs | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index a687d46d170d..72e4af3b0503 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -555,15 +555,18 @@ fn drop(&mut self) {
>  }
> =20
>  impl<T: DriverObject> SGTableMap<T> {
> -    fn new(obj: &Object<T>) -> impl Init<Self, Error> {
> -        // INVARIANT:
> -        // - We call drm_gem_shmem_get_pages_sgt below and check whether=
 or not it succeeds,
> -        //   fulfilling the invariant of SGTableMap that the object's `s=
gt` field is initialized.
> -        // SAFETY:
> -        // - `obj` is fully initialized, making this function safe to ca=
ll.
> -        from_err_ptr(unsafe { bindings::drm_gem_shmem_get_pages_sgt(obj.=
as_raw_shmem()) })?;
> -
> -        Ok(Self { obj: obj.into() })
> +    fn new(obj: &Object<T>) -> impl Init<Self, Error> + '_ {
> +        pin_init::init_scope(move || {
> +            // SAFETY:
> +            // - `obj` is fully initialized, making this function safe t=
o call.
> +            from_err_ptr(unsafe { bindings::drm_gem_shmem_get_pages_sgt(=
obj.as_raw_shmem()) })?;
> +
> +            // INVARIANT:
> +            // - We call drm_gem_shmem_get_pages_sgt above and check whe=
ther or not it succeeds,
> +            //   fulfilling the invariant of SGTableMap that the object'=
s `sgt` field is
> +            //   initialized.
> +            Ok(try_init!(Self { obj: obj.into() }))
> +        })
>      }
>  }
> =20
>
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261019-rust-shmem-fixes-3a838ada39bf


