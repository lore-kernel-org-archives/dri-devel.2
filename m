Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACF1CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377E710FC8D;
	Wed,  3 Jun 2026 11:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="kUne+tCS";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022119.outbound.protection.outlook.com [52.101.101.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D7610FC8D
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 11:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvTN2fhUY+Bhu8sGdo+vlRDSRfFjWtbsptPD4r+nMQDT36uXKuM2NVaWTBqsmGjeC2m5mGzYxMXp0PsSrNBFGN1Mst084mnVEvLG0GoVVL6YKANYMjLO1Hz1zsj+NUdOi7JhzXXxOsjZQIG5GTKz75sayW4pNwzfsYrPk+A54YmcjGXJHOmlRszESSG92F4tfvavZBVXcZU3NpkHDtgmbNZgC7bBhE++kog0E8YfJWhIg0qN7TeXDIT8JJA8MvUUgtdTRltpsdhB8prPbm6bzoUKH6yrMsND4yCZN/HX0Q/xRBGTV/T21Sqi2TlvaftjnD3Jhy4yk8cNn3MoVT3WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWk+MeasLwTLrk9XZ2rV6taZGrqC/ozxMb5zhhLA4Kk=;
 b=kkpTXu1Biay4Z2sls4+1006Ty4pstUFOQG3UldjoeGrP8A3WDtzBP3igVu7JNRd5UUFDVlkod/fO1Q8ZVrFStfG9F37RbEbI9GlVfoeIWB38VZAYePQvK1YXvPThpx1GVPsU7pfzvP8g6JS0582Q3VapBSsqsW1zvcryjpMq05yBUcZDbxCVYzUxtEJQa+VnM0aUZI8N8PZjairsXYbUX5tgChxW+9Q5I94Xjpuazkhlo/XNmM0Xy7XtQP3T3ku/pkn/NdBhfSdKTIInvrHzUI+poL1t4ygvlzR24AWjRsm00qp0BlZ2yiN8vc6mZjJP1BW+LfF8/E9GjOz7TSWpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWk+MeasLwTLrk9XZ2rV6taZGrqC/ozxMb5zhhLA4Kk=;
 b=kUne+tCSENbzGFhODtjEpr1xUThs29Bb6mPhUDHNFx5RveWriRC5WIz3sa5izzAJKezi8uoehUXdzEZPjXMYIq34y+pfoZtdDHrd1HPHSjcDPQGX2J7h7XM0B37rj37t/C7Qr1diptvwA6H43Cur/8NBiXQwMkB5K3tSWgCPpxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2695.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:88::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:47:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:47:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 12:47:10 +0100
Message-Id: <DIZE1Q1S6P12.1CR1VVBK2CN64@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] rust: drm: Add UnbindGuard for
 drm_dev_enter/exit critical sections
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-3-dakr@kernel.org>
In-Reply-To: <20260603011711.2077361-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2695:EE_
X-MS-Office365-Filtering-Correlation-Id: 087250ce-e5dd-4339-f78b-08dec165d95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7416014|921020|6133799003|22082099003|4143699003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZzGTDKPq+DpvEtVMAfrY8nlmXQ6HMsRyljfjhbVU0q6z5NuiAbmlEj3Iv5UkMP06dD3IXIwURdVkz3ia2EHD7yXXeUL6bzQQN+Jyva1CK0J/Miblf7g5qQ3jyTvFo5wegd9UInmTWcpXBY1Zy3leXnKIvP1L74qko4TuqP1W+elhI9F70hLYe4vXEwKnzzVB/K3jXpclWQx0ejpqvjzwNYzPRp+FzYdq4dOxVKJTyDIeh9fa/NeELvzHRYUqz2/XoDshmqr5E0oIjqAzjZdHZZWUHi0vjW6a+LDFlmF0P+jumN7DJBUlpn/XTnmT791Jc0o8YpioudAZjT8EATPBljzLJPo1HXJ6vMcID2icsC5cHW5N8XQABwgm8M5mNq6rbOJysEgvRVxpe02AefoSNmT53qF9RmPAs21uB0MdKiFVebN7KeSDMXYY8AYZGuBA3j6Bi0UATrW6I7c/HAhllK7F4HUZGPk5oOKEa9dDvYoyYUOtMHhmSoYfyKRWMiTzl6DSBU7blN78u1wWG9m4DjVM5l7eo8BwnAWXjI60MzXG3qY5tH1640V4OBzqFv/FFqIEnFZCTj+hxWAr8qh6AH7VYfPiz8/IquxKQDWTEtDe0NpAcAr9Nd80gudJlzMbpUOVd5xl1hs81j6Q7JGXzulug0kSEQIaZQQso8bUsXFIwKV2RWdx/hM6zJmPO8gn3hjrF7SCf81nAOcc1m8edB9wf0yxYRH9WYVo2RdgunQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(921020)(6133799003)(22082099003)(4143699003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHo1SFp1R1JZTGJpUnJyNEhscHZXZnNxUi93U3JqYnNYcFI4MHRUVmZyT05B?=
 =?utf-8?B?UmtBbFBJQ3BkdUgyN3o5ZE5VWjlWMEJ1QWVwOFpod3VvTWp6WEUreGpyTm9C?=
 =?utf-8?B?STBGUTJ4SjV4WnhCNEY1Yzg5UndycFRLTVJlT2hQOFFFT04vMnlseXNaU0Vo?=
 =?utf-8?B?SkNaT0NmQ1NtMlpGbWZNRFdKVjgwSys0M1o2LytlUlg2YjZocStPNjlLUnM1?=
 =?utf-8?B?V1cvUkI1SlViaUE3U3U4dzdOWkVwdDU1eS9memorS2FWSnNOSFV4TTlJZXE0?=
 =?utf-8?B?dkVtSUR3ZjUyMjhpbkVxWnFsRkFrYytVWHVSYVBGZzIrMjQ5R3pnY0lnc1oy?=
 =?utf-8?B?eTZFaUpQTVpWYkNxd2FNb3FqZ0JsVXhGb1JMZzRYUC9rNzVoVktoM3lwYS84?=
 =?utf-8?B?TE8xWXY0ZGE5OURJMWxoNWUvL3VwTmxDY3ZSbmJDNFhmTjliN2JCOFQ3elpo?=
 =?utf-8?B?dkVyNmIyS2F4eGJxcFlZWkpqNHYwTEJPcWhvT3h4NWVhbWxtYzBKeXBua3RG?=
 =?utf-8?B?aHhzZ1NKQXk5ekxMbHQ2VUJtR2krNkJNcGtTR1M5ejArVlZidW93alA4Mks4?=
 =?utf-8?B?K1pnck91dDI4SWJ5VzlGSjd1azRLUHpqOHVRT2J0cUhjM1R6bUtGZ3VlK0cx?=
 =?utf-8?B?dkNJNGZPSUlqZmZJNmF6R1pkczZkZE1vR3M0cDVRcHNyLzcwRyt6WlBTS0hX?=
 =?utf-8?B?UW1zNjIrbUVQZ0YzWVk0cDFaMnlHbnZ2VjVBcEFSSGpVMDZqVlVBTUdRVTBt?=
 =?utf-8?B?ZmlBbis1VFM3ZEpEdXpWZ2FqYVFJaFpSQ01GVkVJUmhJN2pDTE1yT01pOTIr?=
 =?utf-8?B?VE15S1V4WER1dFRndHVndWxSczg1TFNjRWNjMEFQUzUzMGJKOWxhT3FiMDIr?=
 =?utf-8?B?M21PR0Z0MEFrcUx5cmdrVUtCdXlITmpwL0FwTVF5STI5S2FYblI3Wk9RRTNu?=
 =?utf-8?B?ODVUaFFqbnorbzlpdWRsMTdFTDBIL1VRVDNNNWdTeWJVZHZlNk40MlZxZ1o2?=
 =?utf-8?B?VG01V25naitmc2VvcWVrd1NKaGxGbzhMZDlnUG1YNnc4THQ5blJDbitUbndM?=
 =?utf-8?B?S1lVUWFTbkJiNjVKb015dHBPU1pWVU8xSmpxcXZDRm5aU0RIaXdPTmdEdVYz?=
 =?utf-8?B?Nk5zV084NFVlc3Q2Ync1eU9TVG5JTkR1SGxxak1nOEpta2M2RlBtS2hlajE5?=
 =?utf-8?B?VDhidHFNaXFPZFpGMmhOdlhjVGJrYnNyWGgrcXdDV0ZzUTdaK0N5dGhxWWNk?=
 =?utf-8?B?VlVwWkNDTG9kZFZXVkhOMWsrUCtSd25ZM0Y3bUtkSnZMMVhpUUkyZ08wL2th?=
 =?utf-8?B?cWp2WGZycTBOcGdZZjdvRmE0dGZlUGx2Sm00R3JZRnp6YTZNWWxRK2NVbWF6?=
 =?utf-8?B?R3BSYnRUVmIraGpTUkU4dEtjZk9Qb3A0YTZTTVhtK3liQzFFTUhlS0N2cTdq?=
 =?utf-8?B?Tkt5bTJCZXNVZEJyRk0wZ2h6SENTZ00vRytobTg4MEVjNy96RTdaMVhmVHNX?=
 =?utf-8?B?QmZFYnVqdDRrbCtUSVd5dzc3Y1dBY1VrK2pDbUhFWm9zd3JzZDA3REdyQnRm?=
 =?utf-8?B?ZWYyWGxUWGc5cGthODR4MG1GTnJNZXc3ZjE5K0tOcE51SVhHTkx2d0theFl0?=
 =?utf-8?B?UTd6YWNub1dObExBcWQrZ0dhZk9MZGcwdzdYYVpUM2NLd3drUkFNNEtpT1hV?=
 =?utf-8?B?ZW1pUkovOVcyOThyelg2cHRsZmN5S3JwZ1RVWmQxam4rTC9LV0k0ZjRvbnEx?=
 =?utf-8?B?VzBKT1h0ZTZJcldyWDgwTlJDTyt3dTZ4bG5HVk9GZkZXNGM5YnV1ZXI1ZU5H?=
 =?utf-8?B?cmthZ0V5a2ZoNDRDckoyMS92TVVGN0c2S3VnS0tkdUdHVUpUWGRNTUNqb1NJ?=
 =?utf-8?B?V3NuZUREOUpNYk9OcnZSKzRZMmdRT1J2MTErV1pPUFBhSm1xWGxTL21ldDdY?=
 =?utf-8?B?NVh0L2tic2RaOWNUSmEySXRMSHhOeEt4TlZlUW8ySlZFcy9lR0ZtcmVvL2Np?=
 =?utf-8?B?cm9SVkh5TWZLdUJ2dmszZFVXZG5YM1d1TWJ4dDF6Y0dtVGJDbUFTWE9BN0Nl?=
 =?utf-8?B?UW9WUmJWd1R3T2JQTFNJQ1R4ckJpelhQN3E4THN6TjlrK2JKbW1tVnM4SWZK?=
 =?utf-8?B?V2hlRzllb3MyWXFmU1pkUG55WEJqSVVaaHU5Q012ZTQvN2o3U3Ruc2J6OUlE?=
 =?utf-8?B?dkxDTzdLNHlYUngzZmlJMjNYa1hSSGl3TVNiT0FtaFZ4N3FWazNGcWpHUWNo?=
 =?utf-8?B?Y2IzejNTRm1YbkN6a1dFQmsvQit0OGdIQzh1eFBIdCtXNDJ0T2NhT0xUdFpv?=
 =?utf-8?B?MC8vZ2FyV2pXdW1XamNPZWFYOTBQdjQxRWtzdklNSWdFNDUxUXdYZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 087250ce-e5dd-4339-f78b-08dec165d95c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:47:11.6862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2VkNd5T3w2qN9Bc+MgGTf5aLR9/Gi6pNsX/dOxldU6FojT6L/WXoht97tw4sJZTH3qooJwEfcIyz0lhImbBSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2695
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

On Wed Jun 3, 2026 at 2:15 AM BST, Danilo Krummrich wrote:
> DRM ioctls do not guarantee that the parent bus device is still bound.
> However, since DRM device registration is managed through Devres, using
> drm_dev_unplug() on unregistration ensures that between drm_dev_enter()
> and drm_dev_exit() the parent device must be bound.
>
> Add UnbindGuard, a guard object representing a drm_dev_enter/exit SRCU
> critical section that dereferences to &Device<Bound> of the parent bus
> device. The guard is only available on Device<T, Registered>, ensuring
> it cannot be used on unregistered devices.
>
> Also add with_unbind_guard() as a convenience helper that executes a
> closure with the bound device reference.
>
> Switch Registration::drop from drm_dev_unregister() to drm_dev_unplug()
> to provide the SRCU barrier that UnbindGuard's safety argument relies on.


Conceptually the actual thing this is guarding against is not device unbind=
 but
DRM unregistration. Currently we force DRM registration to use
`devres::register` so they're the same, but with patch 3 you're adding
registration data and `Registration` is now something that lives in parent
device's driver data.

This also means that it is *possible* that a `Registration` is dropped befo=
re
device unbinding, so I think the `UnbindGuard` is not the best name for thi=
s
now, something like `UnregistrationGuard` reflect what it does more.

Best,
Gary

>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/drm/device.rs | 82 ++++++++++++++++++++++++++++++++++++++-
>  rust/kernel/drm/driver.rs | 10 ++++-
>  2 files changed, 89 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 858272fc2164..828618ae19af 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -7,7 +7,10 @@
>  use crate::{
>      alloc::allocator::Kmalloc,
>      bindings,
> -    device,
> +    device::{
> +        self,
> +        AsBusDevice as _, //
> +    },
>      drm::{
>          self,
>          driver::AllocImpl,
> @@ -355,6 +358,83 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContex=
t>(&self) -> &Device<T, NewC
>      }
>  }
> =20
> +impl<T: drm::Driver> Device<T, Registered> {
> +    /// Guard against the parent bus device being unbound.
> +    ///
> +    /// Returns an [`UnbindGuard`] if the device has not been unplugged,=
 [`None`] otherwise.
> +    ///
> +    /// The returned guard dereferences to the parent bus device in the =
[`device::Bound`] context
> +    /// (see [`Driver::ParentDevice`](drm::Driver::ParentDevice)).
> +    ///
> +    /// While [`UnbindGuard`] is held the parent device is guaranteed to=
 be bound.
> +    #[must_use]
> +    pub fn unbind_guard(&self) -> Option<UnbindGuard<'_, T>> {
> +        let mut idx: i32 =3D 0;
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct drm_d=
evice` by the type
> +        // invariants of `Device<T, Registered>`.
> +        if unsafe { bindings::drm_dev_enter(self.as_raw(), &mut idx) } {
> +            Some(UnbindGuard { dev: self, idx })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Execute a closure while the parent bus device is guaranteed to b=
e bound.
> +    ///
> +    /// Acquires the [`UnbindGuard`] and, if the device has not been unp=
lugged, calls `f` with the
> +    /// parent bus device. Returns `None` if the device has been unplugg=
ed.
> +    pub fn with_unbind_guard<R>(
> +        &self,
> +        f: impl FnOnce(&T::ParentDevice<device::Bound>) -> R,
> +    ) -> Option<R> {
> +        let guard =3D self.unbind_guard()?;
> +        Some(f(&guard))
> +    }
> +}
> +
> +/// A guard preventing the parent bus device from being unbound.
> +///
> +/// The guard dereferences to [`Driver::ParentDevice<Bound>`](drm::Drive=
r::ParentDevice), providing
> +/// access to the parent bus device with the guarantee that it is bound =
for the entire duration of
> +/// the critical section.
> +///
> +/// Internally this is backed by a `drm_dev_enter()` / `drm_dev_exit()` =
SRCU critical section.
> +///
> +/// See [`Device::unbind_guard`] for details on the safety argument.
> +///
> +/// # Invariants
> +///
> +/// - `idx` is the SRCU read lock index returned by a successful `drm_de=
v_enter()` call.
> +/// - The parent bus device of `dev` is bound for the lifetime of this g=
uard.
> +#[must_use]
> +pub struct UnbindGuard<'a, T: drm::Driver> {
> +    dev: &'a Device<T, Registered>,
> +    idx: i32,
> +}
> +
> +impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
> +    type Target =3D T::ParentDevice<device::Bound>;
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY:
> +        // - The parent `struct device` is embedded in a `T::ParentDevic=
e`, as guaranteed by
> +        //   `UnregisteredDevice::new` taking a `&T::ParentDevice<device=
::Bound>`.
> +        // - By the type invariants of `UnbindGuard`, the parent device =
is bound for the lifetime
> +        //   of this guard.
> +        unsafe { T::ParentDevice::from_device(self.dev.as_ref().as_bound=
()) }
> +    }
> +}
> +
> +impl<T: drm::Driver> Drop for UnbindGuard<'_, T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: `self.idx` was returned by a successful `drm_dev_ente=
r()` call, as guaranteed
> +        // by the type invariants of `UnbindGuard`.
> +        unsafe { bindings::drm_dev_exit(self.idx) };
> +    }
> +}
> +
>  impl<T: drm::Driver, C: DeviceContext> Deref for Device<T, C> {
>      type Target =3D T::Data;
> =20
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 802e7fc13e30..f68a17d8939d 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -199,8 +199,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
> =20
>  impl<T: Driver> Drop for Registration<T> {
>      fn drop(&mut self) {
> +        // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensu=
re that existing
> +        // `drm_dev_enter()` critical sections complete before unregistr=
ation proceeds. This
> +        // is required for the safety of `UnbindGuard`, which relies on =
the SRCU barrier in
> +        // `drm_dev_unplug()` to guarantee that the parent device is sti=
ll bound within the
> +        // critical section.
> +        //
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The =
existence of this
> -        // `Registration` also guarantees the this `drm::Device` is actu=
ally registered.
> -        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> +        // `Registration` also guarantees that this `drm::Device` is act=
ually registered.
> +        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
>      }
>  }


