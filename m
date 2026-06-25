Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D9CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C15710F306;
	Thu, 25 Jun 2026 15:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="c7cpKTcP";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020078.outbound.protection.outlook.com [52.101.196.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F5E10F306
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ipk/mTzeJNosewvTk/wQkM4QJqiRzXeBMvSZ1NfixITxG0sIfx9rmnsQbpcHuNUMIQUKC6cVMT5vwuB/Epz3n1smpYYBqSd6DRdgDYN50QXqgwO+m8uFh9LFGLpuA6FYVAl5rN+t3COG5xNGghSNztwAj/B44RY0kJ9cO4YhxRodWTQ8ssHkoGErQGzraDqaxCA5QKq7FBVvmafq0RiK3r2GFW5vgzAAPIQ3EVCZWjxprAyVxOHQoBf9BhZoH3L3wIFMYEnLbuWL+VBkkUVf8fOPYxuR8kIynu+9OLQ3uXJ0ncDhr7PEsoVJIIgZELnfWjdvzxUj0v0RPIYLsP0SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFaP7Uj3HL/fKy/Nf6zy+2RpwffAay0gLzFPyLDaxOw=;
 b=Z2zVU6tiTXsjnrBPiX7s4J/E/r1iGo5K0+5PV1FffQzin+ndKdq1oBW79hvFHAfucrL0m6ujX2agOctkKDJ3HPGqcpV/2soGNmHMDDdTGvTzuHWQYokuolzGJREIid7nxsco0wHYbePEZ0UIKDHqXxiwfoZdwYa9jfx3g2/yGQixPNOGxOLEIG0Q4tAdIhLTukBMUXVpQLDXh5HYk0JhCZDuZoL3O7H9ExA5kwSAFrBy/4mIqj7J1KPGVQ1fq1mUiZOsp5EjOI4AwvG4n/HzM7E6kjjUTFguaXGgLtj/o+Jm+DV4KO5PsqMAaTdVhylFuwHKruN/QEQyrKHRRZKafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFaP7Uj3HL/fKy/Nf6zy+2RpwffAay0gLzFPyLDaxOw=;
 b=c7cpKTcPJ5gg4bYWuHNaRQ/wPvyTuUopXHqUXqS1LN+S9GwlbbToZOjH21Bnk8rKm+Pap3b3Krl5Lg+dHtPstGbcwy2cyoo/rbRa5k1ocAfZRPIibXvdYnlU3Lvm9H6at43msEbeD7HGt/9aZqmcmkhzgX3j7tmevP0J3xqIk74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3307.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:16f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 15:12:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 15:12:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 16:12:58 +0100
Message-Id: <DJI879ROZKNI.2U77EST3OH7QI@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 14/16] rust: drm: Add RegistrationData to drm::Driver
X-Mailer: aerc 0.21.0
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-15-dakr@kernel.org>
In-Reply-To: <20260620184924.2247517-15-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3307:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8186c1-bdab-45d9-919b-08ded2cc3ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|56012099006|4143699003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: I4SK5VWw31fGyak7MpioyFQ/X65hc85SVAa3/QDco53Wa2yvoDBEpocVNsGSvkXThUGr3n6mlxDqY1ARpGyJtb9OxNrm4WIyfbZtyMkRQSJTF+UD00adU1tNnsNWw8aqbXXqbTZPrbjfYUBi5xlX0511F8IjTZHP+4ebWvrnJElPIrcmEL1McGSKKZpo6cFXaAmjxxvLmUoKCrdUpbqL+bos01mAiB8+QHeoSZcr6ckdatvP6jOo3vCP3ZZnxWPkkWrxN16gl6eQdsVlUs0tRNNLa3bQb0C+WEAB2ojMQ+MEvdWibrc0gz7jRv1eoeACjOOPBf62lUlICDcv1JyF3uPOr7jrSCp8Jwvj21ikzyvs2VJP41s5HzPcJmmNR9X6BpKuhGr5D4XlWu8oSLW4+utkLi+iF/w2gYI4bnLGasoLl5N7xYkjwr1zjFNCqfmbvbcY7lthNeOAUqv3sbkCTijM93tgDM5zyQ8MXE9b5/P3ZRVqVOOcucKOamEvc8ZQKwOBJ6oGPf4/ZN+ZoIP2LHJjiZNyptjIwCtysj9IZAP9izeXkjPfZWpUbqxA9Ez/8ePG4RHGvJQbSQbltUlW9lC9MMEILpCvgARRCNRHN3sp9JilqZZhkoLWyKSbtoBFKgPc4fv8kyeyTX18MOM9FFMyMgIqI72QAoyYp9FKRWigXCpeC0MjXH/nWjv1gzBpOxNWiwuhnjfL1jp2LkZUyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RINUxoczZiYVJHUzh6VE1LbWZ0Nk9qMnFlc2RhRE9wSFFoN0dhQkVRZ09N?=
 =?utf-8?B?QU5WcHFsbXNvaFZ0YWZGZVZwcFdSbDlKcmRSK3pOdjlCTG9lUTZTdFBMaEg3?=
 =?utf-8?B?MUF6cW1lUTMvR0RjSmZYTStnZHhOM0JPTlEwT0t0MmU1YUVFeDBoWXBjMnlh?=
 =?utf-8?B?ZXR1RytZMUFnZlNJSCtOaEtLTXZVSHRzQWM2SFYrak9ldysvNFRvbktuNzZL?=
 =?utf-8?B?MVF5QmpRcG0xN1ZwT1F5WGhwQllXL2lsNGFUd3UxK0ppMFRjYUpLWFlDWFRY?=
 =?utf-8?B?eGpCQkZMT2V5VGszSGVlbE5ramhFRGluczhOQ1hza3VRaDgvWmdXaEF1SW43?=
 =?utf-8?B?Mnl1cVNaMDk4cEFYN0xFdWUwdjR1a0lzN2pXM1hjZG9sQmNmbXppc1d2ZXp4?=
 =?utf-8?B?akxMM1p3UmJJejZYSmFrejJWWGp3OVM0enJBc3k1OG9FOTJjWWt2QWFMcC9L?=
 =?utf-8?B?bXl2SXRVcnpEM1F5RGo2cmxyVFZ0RUUrTE91OFRxMXNwRHhqMS9CVjBUQ0J4?=
 =?utf-8?B?VEVEVHRGYm5DVnAyQWpVa003NEdvR2l2K3BJcjY5dWdkaDJHVHhlS0RWQUUx?=
 =?utf-8?B?U25JOU16SnVTVzZpeWw0bmFTWDZZeitEYk5PWFFWWDZLNU9vdkpITytrQ21n?=
 =?utf-8?B?VjR5UzRCSitHSmhiOXA1d2ZFeXl5WUdLQmFuOXVENTVZNjNkeWgwTE9GK1Z2?=
 =?utf-8?B?WWxOaVFtR3lOYlFLUXdyclhtWFFBQWFpZXFXOWNKMGFWTEZlc0NWOU9KcVRY?=
 =?utf-8?B?WTVGdXBKVFlRaWE4M2l6Qy9ZS2pFbFdXRzlmWk5OY3lDVlo3d2pKVGNYbjQ4?=
 =?utf-8?B?TnVuSC90UWE5RXBRRmRzQS9nVUl3UnVNWlY5OEp6M3lBZWhpMnIxTHBncmk3?=
 =?utf-8?B?MVl4RXIzZmdDVnRRVnpmNXRFMmVyMDk5ZDN2S1k1OVFJUmxMV1FwSjNlQmxu?=
 =?utf-8?B?RVdOOFAyMmVBZVN6L1BnT2FQcElHUllQaFAyUG5QL3N2b0NxdWpVWnNIWHpW?=
 =?utf-8?B?aFM3b2dDRFVmU1Yzc1J6bmQxV2FyRnd1OFpVcDJHU3hENHIydFoyZkR4V1lP?=
 =?utf-8?B?M0FDdFJvS0d2M2k0UjgzckVacGo0b3c4MmVBaFlkWnRtM3MreHptMjNTT1Nh?=
 =?utf-8?B?dHlWdEU3akRsZVBOZVBtN1duNWtOcVFrZlN4d05PZVdrazFyNXVXc1h0VU53?=
 =?utf-8?B?VDJiRk1HR2VGZnIvMVpRQ2lsS1RGVDNtbGpLK29mUGZLcTZaNHN4NWEyOTVv?=
 =?utf-8?B?QzFNM0w5emRNOG1HMHN0N0R5aTllVUk0S1VWUmdsRmxOSllCT3hoRGZ3dGto?=
 =?utf-8?B?YnI3aHhmNVlZUitnbkZmTGtlTEQ4Nk0zUGZMWmVONGZ0Rys4SnpkZ2wweC9a?=
 =?utf-8?B?TDRpUnRTcjdpT2lUN29WRG5nZ1dvbHV4Y1ZqQjUwOGlHWmw2cFlVSWhJZ2dw?=
 =?utf-8?B?TzlBcGtua3JuNGFCcVM4YS93eWdHR2xDUW5jTnR0R3RHZHRISmQxNGdTR3BZ?=
 =?utf-8?B?K3AyaS8yaStGWThDcmxFYnhJbVN4alJhS0FZY3MxakNveUUxQzVlSTZrQzdt?=
 =?utf-8?B?VDJtZ1RWWjBjSmxFTVJ1YzlCRGplTWNkVzBmMElHU3FUV1p1eTQrRGJUbmQv?=
 =?utf-8?B?UXFlaXVKVVNxNktwOGJNM1pCQjB1MDZIaE12UXRkZDZvLzdKZStTYnVqRExN?=
 =?utf-8?B?Yms0UmhBbGkwRVhjTnhkUFdBUCtFclpocTBNSk9YWC9OZURCQ3JFNHJheWhy?=
 =?utf-8?B?VTNZKzVjV2oyN0FVOG9jYUFrUktjMFg4WWx0cyt4WGFWM1RJM1hNRVBqeUo5?=
 =?utf-8?B?bngwbEl1dVhVc0s1ejdjWldrSHVjREZ3S0h3VXhQbktleEtRTlAxcHZ0dWVM?=
 =?utf-8?B?SUtJNHRSaWpmZ1ZFVDQyeWNJclZXZk0wMU1BNXJzQ3pkTzBCeDRyaWpaMzZn?=
 =?utf-8?B?OUhWNXYwVmZtV1c3Q3FIMnJxWU9DNTFXRVJvVmJWTkdKTk5BVU9vOG9aN1Nr?=
 =?utf-8?B?a1JkVzl1MVZ4WHhXdlpQRllaUjZXa2swYkZ3T3JtUytFUU9kcnRSUnBPd0da?=
 =?utf-8?B?TzBvNHFvQ1AzRGl4TU1GcytxL3lxZU8wQi9uM0tYaVZZRVNua2c3R2RqbDJY?=
 =?utf-8?B?ZXZlYUpMQUovRnhvc1J0dWxVRUpXdE92NmN6b3kwREVVc3FGMmhXTEpsYng4?=
 =?utf-8?B?VW92eEE5elp6WXFoV09mSkVDTk1HMGdDS1l1MjlaM3YrMXVGQ0lQUVNwc1A0?=
 =?utf-8?B?T0QyQzM2SUgydmszUklpS0Z5U2VBc0dtWmxaMVB3a1RQc0lsL1M5RHNUYnF5?=
 =?utf-8?B?SFJVS2JKS3pzeTZtbytYcjVuRm50bGNiOXpuQmVna2Zva3JNUXYxdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8186c1-bdab-45d9-919b-08ded2cc3ddf
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:12:58.7357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MavhMJTxy4PQZDXxsD0blzJLOTaAUtY+SsI/N+YK6iFlm0vBY4zPGmxOCgRufkhf3GUCmkLz/d3Of6IUzFKbAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3307
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

On Sat Jun 20, 2026 at 7:48 PM BST, Danilo Krummrich wrote:
> Add a RegistrationData associated type to drm::Driver. This is a ForLt
> type whose lifetime is tied to the parent bus device binding scope.
> Registration<'a, T> takes ownership of the data via Pin<KBox<_>>,
> storing it with its real lifetime. The pointer is written to drm::Device
> before drm_dev_register() to ensure it is already in place when ioctls
> arrive.
>
> Device<T, Registered>::registration_data_with() provides access with the
> lifetime shortened from 'static via a pointer cast. Since
> Registration::drop() calls drm_dev_unplug(), which performs an SRCU
> barrier waiting for all drm_dev_enter() critical sections to complete,
> the data is guaranteed to remain valid for the duration of any
> RegistrationGuard.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nova/driver.rs |  20 +++++--
>  drivers/gpu/drm/tyr/driver.rs  |  18 ++++--
>  rust/kernel/drm/device.rs      |  49 +++++++++++++++
>  rust/kernel/drm/driver.rs      | 106 +++++++++++++++++++++------------
>  4 files changed, 143 insertions(+), 50 deletions(-)
>
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index ceb2829985c7..e42b48e5cad2 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -7,11 +7,11 @@
>  use crate::{
>      bindings,
>      device,
> -    devres,
>      drm,
>      error::to_result,
>      prelude::*,
> -    sync::aref::ARef, //
> +    sync::aref::ARef,
> +    types::ForLt, //
>  };
>  use core::{
>      mem,
> @@ -110,6 +110,16 @@ pub trait Driver {
>      /// Context data associated with the DRM driver
>      type Data: Sync + Send;
> =20
> +    /// Data owned by the [`Registration`] and accessible within a
> +    /// [`RegistrationGuard`](drm::RegistrationGuard) critical section v=
ia
> +    /// [`Device::registration_data_with()`](drm::Device::registration_d=
ata_with).
> +    ///
> +    /// This is a [`ForLt`](trait@ForLt) type whose lifetime is tied to =
the parent bus
> +    /// device binding scope. References handed out by
> +    /// [`Device::registration_data_with()`](drm::Device::registration_d=
ata_with) are tied to
> +    /// the closure scope.
> +    type RegistrationData: ForLt;

This could just be a GAT instead of using `ForLt`. It'd also have the benef=
it of
being able to have `Sync + Send` directly here instead of sprinkle the boun=
d
everywhere.

Best,
Gary

> +
>      /// The type used to manage memory for this driver.
>      type Object: AllocImpl;
> =20
> @@ -139,65 +149,82 @@ pub trait Driver {
>  /// The registration type of a `drm::Device`.
>  ///
>  /// Once the `Registration` structure is dropped, the device is unregist=
ered.
> -pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
> -
> -impl<T: Driver> Registration<T> {
> -    fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self=
> {
> -        // SAFETY: `drm.as_raw()` is valid by the invariants of `drm::De=
vice`.
> -        to_result(unsafe { bindings::drm_dev_register(drm.as_raw(), flag=
s) })?;
> -
> -        // SAFETY: We just called `drm_dev_register` above
> -        let new =3D NonNull::from(unsafe { drm.assume_ctx() });
> -
> -        // Leak the ARef from UnregisteredDevice in preparation for tran=
sferring its ownership.
> -        mem::forget(drm);
> -
> -        // SAFETY: `drm`'s `Drop` constructor was never called, ensuring=
 that there remains at least
> -        // one reference to the device - which we take ownership over he=
re.
> -        let new =3D unsafe { ARef::from_raw(new) };
> -
> -        Ok(Self(new))
> -    }
> +pub struct Registration<'a, T: Driver> {
> +    drm: ARef<drm::Device<T>>,
> +    _reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>>,
> +}

