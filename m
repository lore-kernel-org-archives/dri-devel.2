Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BB5C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA9410E002;
	Sat, 26 Sep 2026 15:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="iaZ/OGag";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022120.outbound.protection.outlook.com [52.101.101.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F67910E002
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srisAkddEPRUBkc9B3fPTWg9Zyfw/sk+qM8VuWzMQu3AHTznzvHP/lB7qp9MLjwu4/EUmu3QVeDK14W0XnggrLh+uzFlV3gpH2MlCHMhBMxDWjKbhqje036gacx4vaZkTFybwJNEm3jHGZoiXu0D0Ar3+A5KgWJ9dvJg+4Mg971MHVtxEiVeYtrgVuJF/ghHxcZkBuYNCTCz5jqDTr0dpDVsugQOX1j0GPUs1IAT4BGekditIwdVsyXCqq4dUQFBUUZyKxje/woMp+Iu6C8z3wL+xoV9aWTEOoVHu+jNCOfrKWF8hJ+TyNR96Nq6rNT8UiSEVkzmMcod9w4U4NP1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj/pbXsmXu367V2ifKVap0nLlgU4MymGQbftw8IMlK0=;
 b=WvsGG1SNzFqe+QQz2xePh/Kp3J8G6dBt6bsfDS9GmvMgBUdGH80UzDq2ZsZ3PBHc0kjCz5uJoCD6jt36KpUZe+hSUpF5V11Opoz9I2buC+K6D5OTgNLmw12iYjDFolGkdNM2jeMMGOrkN98mh4eqV48Xj6kvGKXfhQqBIHYQAIjyW58ia3ruX3uDHQnBRlsn8s3Ow0S9uqNrgIHk05ZvelOjfbEexFfIfN/rjyqfKbID3Ivet3YBqRLvOJQLc4cIyIS8tFq4d5SHsqoKrORnrGXdbvIFFu4LWMOsIlDSUCnwKUeP+rtm0nmgsbs8HsMh9/8Ju161vAIamGGw5m/v0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj/pbXsmXu367V2ifKVap0nLlgU4MymGQbftw8IMlK0=;
 b=iaZ/OGagmICqxNIRa/qTbo3YT9YJcnL2C0/4BcxYcuXi7siZD0sBvjIFycMFdjv0suve1NH4TX+aXbHGTmGKP1xUEKDEqIq4xnwjY4iwT5bbVQRSkQ75S1Jxkb11FZit7JzHrnxUBWxk/WnAl6xfE2nRClXckMSGAnAzrhOZw0o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB8419.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 15:50:38 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 15:50:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 16:50:37 +0100
Message-Id: <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
From: "Gary Guo" <gary@garyguo.net>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
In-Reply-To: <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d11399-f4f3-42a3-ccfc-08df1be5e946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|921020|4143699003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: oiHG2rgRMGV3j1hEZwQq7iJ4OcJnIciAbVZZj59uRECmkZuREb4eEHHp5q1+bRaxeJP+G/cRNPcYAmXxEYlwwM78j71D2nCaExEpGFz5Yp8YmDPoM1F02ukokLhd7RYDMo/mBISbsL0bMk7KHsdJSdtRuP0m5U0fvsQ3+HE0p1rHY01arK6HfdYPFfJMl1OWLf62fC0UJpHPwkOjcwduHC9KmTWwMxjZV9oF9CEsk6fOfMCCkX+zUqZzqqdLSkfXhar+XlCsgKQ+kRB8X9ikTCDXTnlXrUDSJh4CdK1HHfRsvcpm53K1PgdQsCS9GDeaYpZ4TU4l80jtcBUGhY8b222I+2ujToE6W8t73YasVNwsl4lwqRdyg7MkiIl2x7/gNJCUTKNtioZW5E/cH1ilFicruiWsXqrnxFt8nFyD4ZXQGUFpT0BMax6wO5u6NL7jJEDnZR6Nm8pXwfjF3BY+BM2SeyqwdDlW3DGbwJTqZdyaqbxAtQcZf5puh1zATGz2R884A1x/ZPy2Y+tLe+2MFHbMfmXM1GzKBMvExW0/GWrtfcM9jee479Vmkn2KNRVrx+WwuV47KgmXa+SRnd+gvn4EESLFKeO5UX2H89xr764Ip6gv3A3rDrfD+WD7mFZ9IJZr0I7Mu0lhBeFJoEIBj0fwxHQ9ENYoigAwcWvqZ6hy5U1UktNYsv/Ehy9/TRnGf5LXFCauXfpJir3toFQt0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(921020)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlRrTXdpK2hoRVlZS0JFak80ejNVaEJuVE9Za0E3ZU45bmpXQU9zRjhpQ0xS?=
 =?utf-8?B?WFdyZmMvbXFlWTFMRnNkMG9LK3l5bERyKzFOclVwdWRER0E2MzllZCtaVVNx?=
 =?utf-8?B?NTR3OVdPRUtzUTNGMlpRZHgwaTZ4S0pnSGEyUFI5aEVkOXBnd25Hb2RVUU1H?=
 =?utf-8?B?OXA2QWd2cmRZNGhNSmhkSjNQa2c5Q0xKTlEzRkRsc0xoMEFOVHZvc2lDWEZC?=
 =?utf-8?B?Y2pNdm5URmNQQ0duT0c4NjQ5aXZ3RS80d2VTU3lrWW44cXFERXNKcXY5VnJ2?=
 =?utf-8?B?R05JK0ZGbTg5OXBVTTBFbEY0M3pHdk40d0xRMjFTT1IyVzYwdEgyZ1FWSmFG?=
 =?utf-8?B?R1lqNnlvK2RRcS9lWmVvK0JLRnNHQ1BrMkNmOGdVbjlDUnFQNWFkYnRYRzFx?=
 =?utf-8?B?aEs5VGUxQmp5WVZvVUpLU2NIRjdWYnRRZFJUQUdXUzdpLzEya2hGdjh6M1Vs?=
 =?utf-8?B?M2xqZmR5NW95VmF5azdZeS9OZjM3RnducmR6ajRET1lnNUphbCtyczV3T1Qr?=
 =?utf-8?B?bkNqY0J2WGFhVHltenEyNlJNZjZ0TFRoS3cydnFoNnJIMjBKRlB1TGFtZ0ND?=
 =?utf-8?B?SmRrbUFBQkRydys0dUJkcmtmNUc3Mm5Oc1VYT3JsVGJwdTRYTmFqc2Nyei83?=
 =?utf-8?B?bVpPbWtPS0dYVnJzK3ZCRTRPSHU2T1dmWHF6UTRXSlduVFBZanIveWlpQ3Nw?=
 =?utf-8?B?T2Y2RzhTTWlEbVJwbFQ4YnZLZFF0Ny9nTU5ybWFpMW5oUVJDQmdGUE1OOFND?=
 =?utf-8?B?aS9mL05mSTEwQk5RU2ZGc0w1alc0VlZkMWhDREJwM2pDZE5EMC9Md21XQ2Rp?=
 =?utf-8?B?U29OVGRweUlaZGlwam92d2E0aFlwZXNtcFNsUUlibmthdld0RDBpc3ZVaDNt?=
 =?utf-8?B?OG1TMmp1K0I1UjVjcldUMy9CRGFLa0lDdWtTLzR0c2xWNXNFV0FJU1YyYVZ3?=
 =?utf-8?B?b3REbGhLVUFCTy8zZmJaeHVxUmhvQ2RCbXlpdVdjRFdqMWdrUzRzMVpYbXpU?=
 =?utf-8?B?Z3E2M0hnZ2I0ajB3djE4aEU1aC9kYi8wdnBRWGpBQzZlZGFlSjNoSzRJK0dR?=
 =?utf-8?B?WTl6djNEZHpSYURUYVJQeFdFeFh6NHNWZzhLZHl2UTRmempneGNGeCtsVklS?=
 =?utf-8?B?dHF6OW9oTXZxQmUrc2d0OVdVSWtLeTJiOWwwQkhIMTJEYzFqOUkwbEJPaHJ2?=
 =?utf-8?B?bDltdWVxamh5YWQ3RWx0OENtWFE4S3MrTjlJOVBxMWp4NnJjcFRmOWw5YzQv?=
 =?utf-8?B?THRPMmE4MmM2ZyszaGVnTEJTb3B5SmI5MXJsR2MvbnM0a1N0VkQ3RmFxWjhy?=
 =?utf-8?B?ZzJ3UEM0R0JGQ1ZFV3BpVFE5aVNvVEp3WWZ5dUZmUnhVTS9lRVgrckltcXZy?=
 =?utf-8?B?Vjd3aEhrNmdLQlhmV1Z1d3BaakdpSEFuYm5YdkZnZkdnbzRrU2Fhdk50VDMw?=
 =?utf-8?B?U0JFRFNoTTh1czZYS29reUUvSzg3L29Udm82NnFiZ0l2QUQ5Q09LYVRJN0ZH?=
 =?utf-8?B?SW5nNXhQd1Z5bFgyRUZEbExNWXJFYUV0eFVTOUlWaS9kOFBHQ3BqV3F6aEpJ?=
 =?utf-8?B?MkM3WXpWZVFIUTZWMFUwQmhOcU02ck84cU5TbUNxdUp4Y2NsRjcvaGNKL1Nt?=
 =?utf-8?B?RGRrRnlBRERIbzd2bzVJRHkrYnh3Y0pZNXhqWHBIZVNWQWxIcVd1cmJja1Q1?=
 =?utf-8?B?c2RDUGM2UUhPR1ZGSWRYMmpXYUdXbHpwRHNObkJLL2Q2QVFocnVkWDY4UFdP?=
 =?utf-8?B?dytyb1o4L09maHFKdEtRYlNpVlhYNHRqeFB3a2JmNFhZMWNod2RVN1RxMUxw?=
 =?utf-8?B?THJmUlI3RGxwVEhkK1FwSGlzdmt3L0JadUpNdWs4RFlYRkdLVUJNOFNSeW56?=
 =?utf-8?B?TzdEb2ZsakxOQ1hPZEhualFYMzYwY1Q5b0NFM1ZPRlgzZVVUOENlb1JyQ28x?=
 =?utf-8?B?NzlZdldEbXRoUFB6TVZBbGR4emYyVXpSWHo1ZFBrWGlyYjRFelZ0VHYydW84?=
 =?utf-8?B?djRTaU5LR1loZkV2cTFSN3NmM2RUM3ZKaGZ1UzFYM2R5enV6eFNXK2NSaUVu?=
 =?utf-8?B?L245SmhjNDNZd1EzOHE2YzdZRXVPVFhBeE45ankvekNxd2t3S1NiVEk4c0RP?=
 =?utf-8?B?SU9DKzhSVFpKV3pZM2xKZittdERFeWhkRFRqTzJKaEJ4NEd0STRWK0xmUVg2?=
 =?utf-8?B?Qlg3cXcrQmdVbXBMUGVWM1JZTVdEVDIwc3crc1RMb0FON0cxTlNGWFEvblZZ?=
 =?utf-8?B?blZxaFJZbGdGZGdDSWM1ck9DNFd0TFk5T0NTYXMxQ01idmRkTUpNNjJhaUhz?=
 =?utf-8?B?YkJmVnR3V0hQdnRtWnVKN3BwWU01eE11MXg0blozUXBnTVd3UVliZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d11399-f4f3-42a3-ccfc-08df1be5e946
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 15:50:38.5961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1109GdeVBfL4rLwEypEaDw1i8Zx/Pt7qcrn9rUpVugeXYKW8xFeppGpyv+LsjZiITzf+EbN+mANQs3ERX8ajxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8419
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

On Sat Sep 26, 2026 at 1:26 AM BST, Deborah Brouwer wrote:
> Make the zerocopy and zerocopy_derive crates available for use when
> building the UAPI crate and its tests. Then attempt to derive most of
> the zerocopy traits for struct drm_panthor_gpu_info when generating its
> binding. This will be used by the Tyr driver that needs the traits
> IntoBytes and Immutable to safely copy the struct byte-for-byte to
> userspace.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  rust/Makefile           | 12 +++++++++---
>  rust/bindgen_parameters |  3 +++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index da1a7409d984..bf02a1efd6f3 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -365,8 +365,11 @@ rusttestlib-bindings: private rustc_target_flags =3D=
 --extern ffi --extern pin_ini
>  rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib=
-pin_init FORCE
>  	+$(call if_changed,rustc_test_library)
> =20
> -rusttestlib-uapi: private rustc_target_flags =3D --extern ffi --extern p=
in_init
> -rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_ini=
t FORCE
> +rusttestlib-uapi: private rustc_target_flags =3D --extern ffi --extern p=
in_init \
> +	--extern zerocopy=3D$(objtree)/$(obj)/test/libzerocopy.rlib \
> +	--extern zerocopy_derive=3D$(objtree)/$(obj)/test/$(libzerocopy_derive_=
name)
> +rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_ini=
t \
> +	rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
>  	+$(call if_changed,rustc_test_library)
> =20
>  quiet_cmd_rustdoc_test =3D RUSTDOC T $<
> @@ -782,11 +785,14 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
>      $(obj)/bindings/bindings_helpers_generated.rs FORCE
>  	+$(call if_changed_rule,rustc_library)
> =20
> -$(obj)/uapi.o: private rustc_target_flags =3D --extern ffi --extern pin_=
init
> +$(obj)/uapi.o: private rustc_target_flags =3D --extern ffi --extern pin_=
init \
> +	--extern zerocopy --extern zerocopy_derive
>  $(obj)/uapi.o: private skip_gendwarfksyms =3D 1
>  $(obj)/uapi.o: $(src)/uapi/lib.rs \
>      $(obj)/ffi.o \
>      $(obj)/pin_init.o \
> +    $(obj)/zerocopy.o \
> +    $(obj)/$(libzerocopy_derive_name) \

Please add these to `bindings` crate as well to avoid have it diverging wit=
h
`uapi`.

>      $(obj)/uapi/uapi_generated.rs FORCE
>  	+$(call if_changed_rule,rustc_library)
> =20
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 8402b0c93545..332bc8d6a9f7 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -71,3 +71,6 @@
>  # Structs should implement `Zeroable` when all of their fields do.
>  --with-derive-custom-struct .*=3DMaybeZeroable
>  --with-derive-custom-union .*=3DMaybeZeroable
> +
> +# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
> +--with-derive-custom-struct '^drm_panthor_gpu_info$'=3Dzerocopy_derive::=
most_traits

This is Tyr specific change and should be in patch 2.

Best,
Gary


