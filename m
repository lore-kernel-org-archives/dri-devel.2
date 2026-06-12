Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8471FCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E56910E309;
	Fri, 12 Jun 2026 19:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="z3RDyBfM";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020088.outbound.protection.outlook.com [52.101.195.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5C510E309;
 Fri, 12 Jun 2026 19:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVjDnzWnqF0BQcrpnNF5Ljz7XJKThfiH1SoWtCz8Gyh3YUTT8kD+YHlC6PL+wCFdbu85rtiGd9G6CUpGJh03rtnTckhl1CxkO4byo81qZyEOiEBsmvKgJMO71U6YvYxCxCI1lG47H1sycM6ww4quJO67B0r30d9rkr3IZtVewVSJeWYHun5TcOQz6UD1QAm/dz9Zr9Nt9d6M9Yzfo1yt0mu5/uyk4itJ30itkD9ethRe1ex//jdqu6VhY01MLmWk2lwI9WXXVPy90TIFe9H33FyI+Nk/6xqY41DgV1Hi+iTH8DbzifXAA0wUoSjLoPi/0x54cFMylnSbeoFOlmJ1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcn3UYHRGu4nlSzcnBGx2fAF5QPrS5x4bKyVjaflA1I=;
 b=lOieEOrg7jRh0fkezqetriHufIqcxN/yfdlSmMuGmNhH2h+ievwHFPZTOJJt7WMuA/Rlf4OiR5Ec2Vq1D9ow65YxdPYfLlORasqW3xZGi8+xWlTtyTtLEojD6CItkZtou6DnVTKW+1XsTfzqDRl+2Cfhh4lRm4OqR1iuoc0duOfyjlwZXcX06hxaO8Gmb+l57FXMz2Pp6m7z75nNM7NpshELimo04S1Pc0kk9NbUhnvBLFLU7QD9e3fB0hsEoT1ERPZwRNdGL4n49Du9MLL6WpKs4Gmo4tSOE7QwUc2duCGtCaHKvu1ryPiQccHVmcRw+rxlAbpGujCCdzDeLa7hLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcn3UYHRGu4nlSzcnBGx2fAF5QPrS5x4bKyVjaflA1I=;
 b=z3RDyBfMFo4d7XaSItzyddi99VSNTrw7KNTDSDPKTehdeei/Sa7/rC4QudNahVJTA1lr371ZOOhpHoDRylICETFbtcK8UrZ3r9MsGjVNYGDjGd37Ur3SKgFPO52QIgvPMjNVgn0yICvmxzDjx/ZDSEelFkYip4m8Ty48ze4lWkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB2832.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 19:02:11 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 19:02:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 20:02:10 +0100
Message-Id: <DJ7AXOH0W92V.1L1869KO4C1H9@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <driver-core@lists.linux.dev>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Simona Vetter" <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, <linux-media@vger.kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Benno Lossin" <lossin@kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Mukesh Kumar Chaurasiya"
 <mkchauras@gmail.com>, "Asahi Lina" <lina+kernel@asahilina.net>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v20 3/4] rust: faux: Allow retrieving a bound Device
From: "Gary Guo" <gary@garyguo.net>
To: "Lyude Paul" <lyude@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nouveau@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
References: <20260610162433.923550-1-lyude@redhat.com>
 <20260610162433.923550-4-lyude@redhat.com>
In-Reply-To: <20260610162433.923550-4-lyude@redhat.com>
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB2832:EE_
X-MS-Office365-Filtering-Correlation-Id: 80dd0634-cffd-42a8-4c9f-08dec8b51b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|7416014|376014|366016|18002099003|22082099003|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: R4PRSHqsaMe93FQDj/h3mGT6Uy/O85IwDJWokijxQSuoBC/WjU6x2+ffBHkTByDKD0ctIGE9NVxBeNoiQBJsJ/UhTw5qaASWN8KAkXAOGTvAusvh2tx/l7CN+mGr3OHFHp3FWf9l7qRhm1fJ/ekVGyMvYAvfrbg9l9wDC4/uJvy5KYnX3pZZM1RGJXonvlvZlfWOew1mD++fUEtkUuEAZEgoADWpRDxdNzT6m26awk8Z0JEFK+buU20ojKsOhNiwQZsuYyJSabGRn+ZOOMuOV/KIdBazQyL6zHI38UJJfuij6vQtYWwyEDpDgq9E/zY9xwJjrML2GAugQhrozBdcw1Nt4ExvuptQDILxzSQNX73UtrjY0G3TaRx+SYWtF9pKViinGRHB7PK+ey0DETtEQaH50Ij4yNxC4DcOrL55xJI3dby6rr9Tk4TV7iwYHaTCoDjJmtwhF9eCVjVJH+QoGKSmPzxHCta9xkqJe0fksw0UKjqgqSaQdj+1Tbl/9RYP8Dq7gmSljUIVH3QKm9TFdLTTKJ+e40JwKHs6mOYAQZsw+3HS3b4x84NtUxG6uM1Rak7IH08sMt87uxGyV62Dgs6yF70QoJZlvtRu0cwuXbPCO6Q03vn8ylsOl2JRrPAPR3jbrlpNNXeGY2rFJwMWuqrQWI6R7wHCmiUoYPcBLR9ZymcOpwc8KlIrAxUp8hEN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHAyMUh3OXNHaCtTdGNFS0NkcEw3SS9mYmRjampXY3pxd1JETDJSYkpGRkwv?=
 =?utf-8?B?VVIzQm5zWGYxT1VTVmIyUlduaHQ2dXdqS1RHYkdwYkRGN00vdFBrd3VQbXpT?=
 =?utf-8?B?NkVCUnloeFBiZGtNK0ZpUEMxNmYwNFdxelg2dllUcFpjcnBWbExaSFhXSG9X?=
 =?utf-8?B?eHJTRFhQMm9YMVUwcmZLVUZPY0cxcDA2a0lRSVhNem1ydVJMWTR4VXVWWTVH?=
 =?utf-8?B?QWE2WTNYK3czdm94RDVFekxnNDBtaDlJanByOGNnWVVqQi9lVFcreXYybFpm?=
 =?utf-8?B?aUlRQUI5aDUwajJPWlYvNUgwS0FNeTE4YnFhVzlLbUhBUGx4MkxaSFk3bkFo?=
 =?utf-8?B?eGdjSzk3Tmo5aWVGSlZDdlUrclY4V2JkcUVJQmN3aGFwaEJ1eGlnVkcyTG5L?=
 =?utf-8?B?SkhnbGN1dUd6cEpLSVMrSW5NTXphTHkyMDZLMld4ZjY5elhaTllvTjZwaWRj?=
 =?utf-8?B?MElKQzRaQ1JjN1FCVWlZTzdLRmY1aHI5dVVKNklFTHp4c0tTUlRjNmtuMVdQ?=
 =?utf-8?B?NHVCaG50R3NyT09KNVl4RDJDZE5sRitVS3ZQbmVrMnY3R0ZSVTVmV09kK3d6?=
 =?utf-8?B?cWlVMC9qNTVsQ0NDY09EYUkyMzRhUmFXNSt2aHgzQXMybndWbWR6ajk0elY2?=
 =?utf-8?B?SS8rc0FYN245cExoVFFsUEZiaHN5b1pBR05mQ01iSUNRWDJneTYydStLSWwz?=
 =?utf-8?B?SktoeWV3NHdYeXJrWW1mcTBlVXczYWthd3RCeUpjbjROSXFRSlBqeFh1eDZQ?=
 =?utf-8?B?bGlIanAwdGdxK0JqZmx1dWRyNUdaNXBEWEc1L0h0MjhBOVpVNEZBcTJVSTBs?=
 =?utf-8?B?aUxjajE2L3BoTEVIVnJjK2p3YlVseENUdzAvRGxwYUk5WlNiY3JnMy9rT2Fp?=
 =?utf-8?B?RExoLzE4SzdyaGxZTGtsOTNkMWZ1cFNNVWcvdktKa3Z2OE81T0NDN2Izdm1P?=
 =?utf-8?B?UnBHdUk3dksrSlJuNEMzbVJaTzVDTWxCZjQ5SHBGNFlvTDVOM2l0TXZRT3pi?=
 =?utf-8?B?U05mUmVQOStab0FoNkxLRzdyYWtNVVMraE5BenhkRXRsZGVMLzJxMWdUYWF6?=
 =?utf-8?B?dURVeXovMVpmckxBUUJaRXBGdWtodVYvRU9SL1BxVGZIKzhDUkptMk9qNjY1?=
 =?utf-8?B?VG1rMGpQYXE5b0NXSkFmMHFVb3o0RjVQa29pM0p1eHBEYmdKNkRFTURKRlhF?=
 =?utf-8?B?UVFqcWt4TTlHbHAvYm54Z2V1K0o4QXRxclhRQTR1OWVzc1NsNFZYOC9tMEh5?=
 =?utf-8?B?L0RNTEMzNUlOUFNBTmR6RkhENmI3QndzSTYrOTdjbHRhdnVQeTZtTU01VXpo?=
 =?utf-8?B?T24zdkNJR2ptS1JyYjJKVnNzNS92Njk0Sm1qZHAybHJOQndKZ3ZKa2Q0L21W?=
 =?utf-8?B?WER3WXhlSWk1UG1hSEVnRUJEdHFhb3NoODhOV3VzUVZNdWlFNmVsbENXZUk4?=
 =?utf-8?B?NU5hNUorN05teHZidTZ5WG95V2wzOTNNQ3lGTzRyemFkdURuTkQ0NWVMSG42?=
 =?utf-8?B?eE5JeVJEQzBQRUc0QVg0NmhBak5iVnpheVRKeDNZZlZ5UU1La254V2grQmZM?=
 =?utf-8?B?RWRuMUh6YmVGUHArUE8wOXRmb2U3NWhFVWNNeE43SW1xM2RRNGhIait5VDlM?=
 =?utf-8?B?WHNOY0l5NXRscE8rR3MvYnVwanNzQWJjQmZpRzE1dzJhZ0tpN0lFbGIvK2Rq?=
 =?utf-8?B?NnVxT2czZjJiNS83UGlRQ05sUGVyVzhpNFVYbEF6VS8zbnJpL0MwV3BnQnVT?=
 =?utf-8?B?d2JqVjc1S0VpVXNsdThDZHZRT0NpblJtZTdXb3dubHdTWDFCNHZmQ2k0TXMv?=
 =?utf-8?B?V1NsdXk5UE52bm1uZWdUUUliNVFGaXVVUEZWblNoWHdiMzU4cUZuOXBmalZw?=
 =?utf-8?B?b2YvTDRWRXFET3J0Yjd5Wm1kcFpoZlphM3JvaFkxZTFCVURpZFNRekkzbS9t?=
 =?utf-8?B?ZnhkM1FzcXlwdUYyVFhsMC9mN1VjZGlPVlBFcXNES21mSmdWVmdlaHA0UjNv?=
 =?utf-8?B?Wi9oM1hkdWxoVTlnNXJkRHRvQ3dlMTgwSUJ5dWtMYlZiNnJGdUF4Q0xnOEdm?=
 =?utf-8?B?NGFSVzdqcUFCYjF3dzFEMXpsOG9YcFRPVUg3YkQ3OE9heUVlckdSamJHcmUr?=
 =?utf-8?B?d3FKNmVYTmcxb29YVG1xeGdKaTZwQ3cxNDA5Uy9udmV4V1pldnN3RkJ5M0xD?=
 =?utf-8?B?YURnS2pLZ1lZeWVqMUEvaWgxdWdUZW5NSmZzcU1TMktSbzVaQmN1U1EwMm1x?=
 =?utf-8?B?Qjg4c1c3dEtZYkpMTDFQdUk0dlYweGhBWWFBZXdZaEhEN1pjTnZPVzVJeHNG?=
 =?utf-8?B?MW4zWUtSMTZYZ294STdFT3lmRWRqRHE5aFJkRERxRUhnbk9kVUI3dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dd0634-cffd-42a8-4c9f-08dec8b51b92
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 19:02:11.1092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gek+W2Q864mccp/niugAYqaP6ha03ewIQCyKfpAsG7IwyAbBoFzQOdt/RL6LPXP+QVX0/BaiVErIxAbC4RVPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2832
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

On Wed Jun 10, 2026 at 5:21 PM BST, Lyude Paul wrote:
> When writing up some rust code that used faux devices for unit testing, I
> noticed that we never actually added the Bound device context to
> faux::Registration's AsRef<device::Device> implementation. This being sai=
d:
> the Registration object itself is proof that a driver is bound to the
> device - so this should be safe.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> ---
> V18:
> - Add notes from Danilo to safety comment.
>
>  rust/kernel/faux.rs | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 43b4974f48cd2..20ab638885354 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -25,7 +25,8 @@
>  ///
>  /// # Invariants
>  ///
> -/// `self.0` always holds a valid pointer to an initialized and register=
ed [`struct faux_device`].
> +/// - `self.0` always holds a valid pointer to an initialized and regist=
ered [`struct faux_device`].
> +/// - This object is proof that the object described by this `Registrati=
on` is bound to a device.

Sashiko mentioned that this added invariant is not justified in `// INVARIA=
NT:`
comments. However, I think instead of adding additional justifcation there,=
 the
safety comment below is sufficient and this doesn't need to be additional
invariant.

Just dropping this hunk should be okay I think.

>  ///
>  /// [`struct faux_device`]: srctree/include/linux/device/faux.h
>  pub struct Registration(NonNull<bindings::faux_device>);
> @@ -59,10 +60,15 @@ fn as_raw(&self) -> *mut bindings::faux_device {
>      }
>  }
> =20
> -impl AsRef<device::Device> for Registration {
> -    fn as_ref(&self) -> &device::Device {
> -        // SAFETY: The underlying `device` in `faux_device` is guarantee=
d by the C API to be
> -        // a valid initialized `device`.
> +impl AsRef<device::Device<device::Bound>> for Registration {
> +    fn as_ref(&self) -> &device::Device<device::Bound> {
> +        // SAFETY:
> +        // - The underlying `device` in `faux_device` is guaranteed by t=
he C API to be a valid
> +        //   initialized `device`.
> +        // - faux_match() always returns 1, and probe runs synchronously=
 (PROBE_FORCE_SYNCHRONOUS).

Please quote all code with backticks.

Best,
Gary

> +        // - suppress_bind_attrs =3D true on faux_driver prevents usersp=
ace-triggered unbind via sysfs
> +        // - mem::forget(Registration) is not a problem; if the Registra=
tion is leaked, the faux
> +        //   device stays bound forever.
>          unsafe { device::Device::from_raw(addr_of_mut!((*self.as_raw()).=
dev)) }
>      }
>  }


