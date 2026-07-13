Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C469C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFCF310EAF2;
	Mon, 13 Jul 2026 20:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="0f/KTMhX";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020073.outbound.protection.outlook.com [52.101.195.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D499C10EB09
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHpkP9Wgv+yfxDHp1u375nq2+G2axZOd46Mtmlw3x8AH43GjWHyHVWt2WQNs5OxO3U4jqFPcXVMVzeiwlJDhI8C0i2notpTNlSNFjCpuQbGD+WCbaqtXUXzZhniQyRQ74pmGF8OwUEhjGsqwNhVZxTy01V3Sen2I5nliIckY/E1B2dKSnSk5sJG0A5mCjBxqAj7/RNBUdB9lLzqlO3E5wuoRfCerYIWB+pcezhyjYLJxKxFrCoD1+7GTDb6WvaZO8KudnvXL0eQi1mbDCsEIh5v4ClTQZU9Qu+7LRR/e6HGICxCzbkKX/gXxJeEsfDl62ccdZap66yR32erIvPoD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/EtqttSuAsXrKqrV+g+jf1re6nZzwEarvHw5XREnp8=;
 b=eAiilOCuoZ+t5rdF/oiktKNLooLlNBodoDBOfUjQ0AQVpNCjEI8TASS5jTIj+7U71nr44UKjhCwASYa0CoNS//FfUrJKTl1vfbOm0WQpXBbWdryk1OOt93P9fycqUDP1R5UVhafLb8hjK91iNMCjBmONhNRnQXwN6tsd4CTTntxeb5PJdzE1gS7VLQSzCcPgCcMPMrEGpHs1Gp+XWV+IxyAnJ7oPphnd7Xesn3c5UcuwaumEcRrr8F9UwqsycK5LkiDdhygZiacLdL80/Gd44bmgwCsMLt66jbqpOwNBcnt0GMRtv2goe4Ci4GCUVx7K3H5L+wp8xEZAkrNZOdwclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/EtqttSuAsXrKqrV+g+jf1re6nZzwEarvHw5XREnp8=;
 b=0f/KTMhXlQXxn4Blg5m4INl3PSJnlXvcP3Xj7EamSMY4uHITjICcfeMt1e96V3WnE+ehu9wk15Mpdy05CYJ+qhdJQMGDrcT4ebO0kGeRj1MgM8X3CTjuIf1ZxtYZG6BcrSEM+c7pA8bZFgFTRTZvQ84vRqTZ33QjpwxyxS6r2z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2501.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Mon, 13 Jul
 2026 20:23:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 20:23:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 21:23:48 +0100
Message-Id: <DJXQ32PBP5Z8.2ADOOIWKYOLP5@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: device: make lifetime on `Core` and
 `CoreInternal` invariant
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260713201455.640151-1-gary@kernel.org>
In-Reply-To: <20260713201455.640151-1-gary@kernel.org>
X-ClientProxiedBy: LO4P123CA0378.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2501:EE_
X-MS-Office365-Filtering-Correlation-Id: 45614c45-5fca-4309-b3f1-08dee11ca5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|921020|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DdHAoLPEDNghHPl3uckg8Z/NOGAhbR+/7J9Y0ajVfdu9xBDJG+jOmcuVk+PKDTTy7bORWC2C1qIMXPGxxih1r6kTYyG6UejRHbmrUKIhuLexzm408aPIFUWsr+jB5tXJk0sQxMriWqQslVnoEnq5iEipwNYJ1vYd4kfps69af31W41LOsG0pQIPflw153frElkuO6fFFD5r1Kzvn42VGm0T88KJZXPvi+MRPMxeamfPW4gLInYcwJroDUwLukz/Pz3/4Bbat5zSsJzfcD11QS8S6xZPdWDzLlTb3vY8j+Rs3AQulXoG1Ngk2slbBKRO7B4RA5T3rq3hkUl7p6PQPHEmMSUAbRQQT9dZJ/NSsdold6maVTfTdsDqBbSi4lXctQun87vXsOK3CZ07kes5CzjQJj1NNAlFpaAZ/lHEf2OVKbrwSgPhgpPQ/FkSKyiwcgc3hHMa55b276nHBmgGR3nmdmDBw88Pm6nGh817NcFuQhcSSONzGRMULuDEXp4+ogOSpw51ts3DCGcWoxEtotqVnrBK40fXpMJy5hhSKLCEiT6mIEe88m2g8b3EzYYr00K9ZNGnbn0MXffZlRZMCEY7q4TVPkO6Fb4yOgLeCPL9yJU9tU6HfKSGLtQWZ6Xh8ujiDC9mkex3QFqaOeGVpygahEVhfSZbuW6ClXoeXSXKjkIbZ0aEiK7DjEvfGmF3U/et1675wjaJqM9DI1D0+Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUw5S3U3dnlXdit0MmdweEtlcUlWT05oQTUvVXp4UVVVMGdjVkRUcEtxUHdx?=
 =?utf-8?B?eVBMc3BDN2xtVHNmUWFSUDkzb1I1ZEZ1dzdxYUxJdjZub2NPK3BQSy8zYVJN?=
 =?utf-8?B?Ykw3SHR3TDluVWpCV2IyclBOUm1RSThSTFA0TmhkNkxkbzJnZkd1RmEzZXpF?=
 =?utf-8?B?djk3UmRvS3lhY0JnUEJUK0JocUdFWFd0QnZ0dTdtWklyUmdpWHgzT1ZzNXVS?=
 =?utf-8?B?WGdrUWZNbW55NnlvTHlSWmE1N0tkYmIwZkYya25XNmFUa2VpaFVGa05odngz?=
 =?utf-8?B?Q1JOZW92SnZMemlzQUtVd01UMndaaUszdElLUStBQWEyQktQb0lkVldxNXFv?=
 =?utf-8?B?bTJKQWgzenFxNVR0aS9aL0p0TU0vbTNxbGg1eGVYa09qcE1qWWs3RWlyV0VC?=
 =?utf-8?B?aTVPWWEyWnJZYjg1YmpGcGd3RTdZSUU0NGZJUnk0VzcxbU1vaXJHRnVpdjdp?=
 =?utf-8?B?RnRZMUJlajNyYWdHQUplREwxZTVNSFZWK3VTaUZhOTdodzFMdmIweGJSM21J?=
 =?utf-8?B?ZkRiSGZldEl0L053aVArT2I1dk9zdUNGcko4ZFkzdE8xR1R0bmNLcmhhb2t3?=
 =?utf-8?B?MlM5TWhvUjF0UUUzQ0lWR2kza0hhWEVhemVNTmZrT0dVbUtyd2JSYy92NlYv?=
 =?utf-8?B?SHdsRGJFZk9KcEVxZWp0Z2NRRFNHZXdmQVdiR1hxbld0b3VDamR3YWdIR25Z?=
 =?utf-8?B?OFRqMGhRMURLVTBGUStlRHJZWGdYUHVGcFFzTkJRTHpPcEF5MXcvci9DNUxB?=
 =?utf-8?B?YXJuTXp2ZENaS2dQY0owWngyN1hxVlhFeFg0akZEUGJ3VFFTZkd2L1F1MEVL?=
 =?utf-8?B?U3NBMTMwTUVzeFJmeTFkZjRRZ3ByWHB6dk1RQm9YMlVLb2FJMERhTzB5OEpU?=
 =?utf-8?B?RzlzbXJPNmM1SG5GTjNoYkswN0YzYTJBNHdHOWJBK1NpVFJOeGM3VjZpdk1V?=
 =?utf-8?B?TVM2RDdYUGpLSzJwTlpXeXFHWnYzNERJT3lSK2VuRkxFOUc5TXNvL0lwVlF6?=
 =?utf-8?B?MXlNQ0w2djBJSVZoZm9MNHVZcHo3RjEyQVhFbUF1dVl4UEUvcG54WjdoZTdM?=
 =?utf-8?B?bG14VWN6UzlnV25ZTWNCM1R4Zkt2cUcxY0lLQmFQd0xKdWtmanJ1Y2ZnaVBy?=
 =?utf-8?B?WXluL2ZjRnpMZ3B1R1poUVJLM1RqY3RGSHd6K3laRXc1RStGalhkd0lJMEZk?=
 =?utf-8?B?SGJONDhVMUZNVEVoenRiMVpTaExGQnh5REQxYzlGaDAvTDNLc0dRSXY4QWM1?=
 =?utf-8?B?cFRQNGNudGg4RGw4azJjcHJMYnN5OGI0SzJhcmtjQjJLRHRJRUl6d2EveWgz?=
 =?utf-8?B?NlRPc0NiSlBWZnlRbTlNT0hXUFNhMDYvcXVUYVloVXQ0NC9XaFp0U2FOVTFP?=
 =?utf-8?B?ZjR3UVdOejNmQzREMzJtWWhjdWh2aDdZYzkvcWl0NUVUSURCblZuTHpzYmlo?=
 =?utf-8?B?ZWFNY2JvbnFrNVZPRHg2RzhMR0hoSFQrMUhrMmZ6L21jcHVnQnBEbEpFRnlq?=
 =?utf-8?B?dzhFYWtvTERUZGRXTGNhakluNjZQaFhacUJIa2RiRC9ZejN5OVJxVE9FQUFW?=
 =?utf-8?B?STNtanZHSkEwWVdRRUowem51UjZkUWZXM3M1WjhkWWowQWZpOWlwVHN1T2x5?=
 =?utf-8?B?ODl4cVhIa2oya1FkSldlMlAwSFJ5VW5Vc1pFYkdReVBhRDZDQlRnbGpiRXVt?=
 =?utf-8?B?M2pRNEJ2dCsxNHNTWUc3KzhGK1FtN0I4enN4ckRrMGRmbkg0SG5ZelB5Uis2?=
 =?utf-8?B?ZTVOa05mL09HanpITm9pVlRjM1JzdWxLa0ZSeWRZZlNPcGZiZ0M0ajRZc2wv?=
 =?utf-8?B?UHdockxpZWJTWDhhRHUwZmtwK29LOE96ZFFTNXgxalNYSGVtbnh5eGs4cHk5?=
 =?utf-8?B?ZWZ0Y042cXB0L1Q2SjdCRVZIT21hL0hCSk5OSDF5T2dNSFE2VitRSmo5alZ4?=
 =?utf-8?B?aGhtZDJTaE9wSHFDRURwWEdPaTRmMExMZ2hUaU4vcVl4dFZHVDU3RTM2SHAr?=
 =?utf-8?B?NkJMaVZ1bGtVdmhneXBVUUovQVRrTVV0eXZGQUNtQTE4ZzlRSHp4eENsU3dB?=
 =?utf-8?B?SEdsdWNIZUlMUVFSdHpzeGZNQ2c1TW1mUTZCZkdkZU5sY0U2bHZTaDRKNS9a?=
 =?utf-8?B?aUNCVVE2YjNTNVpjU2UwKzlSYlBNSGIwVXliYlBrMXIya2dBZXlLazFTaS9B?=
 =?utf-8?B?WG9RWjNDTmYxSTZMcmo0c2M1R1cwd3g3NVc5WDFrTE8yalI5dkZkaHBJWHo4?=
 =?utf-8?B?T1ZDN3hRUGh2YXJWZHVEL0NrVVRpbkdEd2ZTN3ZUajU0ZGF5dnFaN3UwaG5J?=
 =?utf-8?B?KytlY3gzbjllM1dHSmJKT3ArTDRhNllxUTJiVXdyQXFuVkJOTHp6Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 45614c45-5fca-4309-b3f1-08dee11ca5f0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:23:49.3457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6drej9yHWq7E7QXTcfHewUHoxaC/lAF0nXFNx1oF+10EpW9XYV/VeWd8k77TuNl5qjP14SEYcu3ZNguZ65gq6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2501
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

On Mon Jul 13, 2026 at 9:14 PM BST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Currently the lifetime on `Core` and `CoreInternal` is covariant. This
> means that they can be coerced into shorter living lifetimes. On `probe`
> function, signature has `&'bound Device<Core<'a>>`; the type's wellformne=
ss
> would imply `'a: 'bound` and thus the type can be coerced `&'bound
> Device<Core<'bound>>`, defeating the purpose of having the lifetime bound
> to prevent users of the `Core` type to escape the function.
>
> Fix this by making the lifetime invariant, so the coercion is impossible.
> The lifetime here only needs to be "branded" so it does not coerce or uni=
fy
> with other lifetimes, so we do not need to ensure `'bound: 'a`.
>
> This requires modifying `nova-core` which relies on this implied bound du=
e
> to pre-2024 capture rule. The "use" bound can be removed if built with
> edition 2024.

Actually, a more proper fix is to make `Device` invariant over their
context. It would require touching all `Device`, though.

Danilo, let me know if you'd prefer that approach instead.

Best,
Gary

>
> Fixes: 24799831d631 ("rust: device: make Core and CoreInternal lifetime-p=
arameterized")
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/nova-core/gpu.rs |  6 +++---
>  rust/kernel/device.rs        | 10 ++++++++--
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index b3c91731db45..b603b0bd2692 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -285,10 +285,10 @@ pub(crate) struct Gpu<'gpu> {
>  }
> =20
>  impl<'gpu> Gpu<'gpu> {
> -    pub(crate) fn new(
> -        pdev: &'gpu pci::Device<device::Core<'_>>,
> +    pub(crate) fn new<'a>(
> +        pdev: &'gpu pci::Device<device::Core<'a>>,
>          bar: Bar0<'gpu>,
> -    ) -> impl PinInit<Self, Error> + 'gpu {
> +    ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
>          try_pin_init!(Self {
>              device: pdev.as_ref(),
>              spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 645afc49a27d..db25ed1ae8e5 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -511,7 +511,11 @@ pub trait DeviceContext: private::Sealed {}
>  /// callback it appears in. It is intended to be used for synchronizatio=
n purposes. Bus device
>  /// implementations can implement methods for [`Device<Core>`], such tha=
t they can only be called
>  /// from bus callbacks.
> -pub struct Core<'a>(PhantomData<&'a ()>);
> +///
> +/// The lifetime `'a` is for "lifetime branding" purpose. Callbacks need=
 to polymorphic over this
> +/// lifetime so the `&'bound Device<Core<'_>>` provided to them cannot o=
utlive the scope of the
> +/// function. For this reason, it needs to be invariant.
> +pub struct Core<'a>(PhantomData<fn(&'a ()) -> &'a ()>);
> =20
>  /// Semantically the same as [`Core`], but reserved for internal usage o=
f the corresponding bus
>  /// abstraction.
> @@ -522,7 +526,9 @@ pub trait DeviceContext: private::Sealed {}
>  ///
>  /// This context mainly exists to share generic [`Device`] infrastructur=
e that should only be called
>  /// from bus callbacks with bus abstractions, but without making them ac=
cessible for drivers.
> -pub struct CoreInternal<'a>(PhantomData<&'a ()>);
> +///
> +/// Lifetime `'a` is invariant for the same reason as [`Core`].
> +pub struct CoreInternal<'a>(PhantomData<fn(&'a ()) -> &'a ()>);
> =20
>  /// The [`Bound`] context is the [`DeviceContext`] of a bus specific dev=
ice when it is guaranteed to
>  /// be bound to a driver.
>
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa


