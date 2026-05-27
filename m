Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6906FCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 19:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A4D10E992;
	Wed, 27 May 2026 19:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="OZ0BwziO";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020143.outbound.protection.outlook.com [52.101.196.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4662B10E992
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 19:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGQ8dNvFZIJnVqaKp48jFpgpE3N3QEIyyU85CpY8iT42MliFVYMeIc7x0BRihGvoKWroEnxIWd5R9qWlRuIceoZxobLG/xCNt2r3bvqfiU30IZJKvn7u9SoOuVyg/pkBsLUz7UWeGD6cQqZBAuh7hBLzv4zyDDRvUkAfFs9LadAg0wEyr+m8LpAxHPNzEk6tIhDuajTgwt/1MNwSTneRZY5U0jMSdv48sdbi1jvvvoaf0ZIXbP6DHgf7I5KUCdVMwcFsgrNu3XxwyE/SnXC+5GWRpr6/lmv0ofAPxQajIr3GK9u2bm4Kzk1cuSk1dwWHjgmNq6D3ANw07a9NBp5/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un2xb52mCV9hns2EPtl5/M7Eg2SBJnH4S53D0USZo8Q=;
 b=DAlkPgBr2at9ZL+w8unG7xzx42XW1+/mFjWAJK0Ty0VrwpvNypXzZR1aqjECrqXOSccgkg+0Hlzs645FYnN+fovRNAdda7vG3lcUr0fihsgKzwF8Pr2ujU8ZbGXbgTurwWjFEHEluKTIiG9n4x1pfYK6nIPUscpnMt/VqZu/rjrfkZNiyhcavuuZcrT65BhDy5I0ArqMuysmRc2CKl5+73uM/Y3REscnH7yLMuqyRS7JimeO/lDIB6Pt3fQ4wn3pDxO1EBbBv4uW0InSGzUG32MBuVXaPErb7hsuO1mQMmd00ZJ9pRk333CZ4aPvrsEDTtGJBBT++1F2h0qNb+OMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un2xb52mCV9hns2EPtl5/M7Eg2SBJnH4S53D0USZo8Q=;
 b=OZ0BwziOqFpQnXA5IC+7mhV1bDL7LfhnU/8UTt2awN88qg+HXeTnUTg243HzXGAKELkUOms2aemMKYhLZrEOWmwS7pAUAPYWYEmJ9kB74AQnlEz03H8nEiBDqjW6W6pxashUuX/7GbW8+N+EDvDyLa9GoE4tRptTNY9fTo2zSRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB7041.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ea::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Wed, 27 May
 2026 19:52:57 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 19:52:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 20:52:56 +0100
Message-Id: <DITPZU97DT7V.269YEZ9S2ZIHF@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/6] rust: drm: Add UnbindGuard for drm_dev_enter/exit
 critical sections
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <apopple@nvidia.com>, <ecourtney@nvidia.com>,
 <deborah.brouwer@collabora.com>, <lyude@redhat.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
X-Mailer: aerc 0.21.0
References: <20260506221027.858481-1-dakr@kernel.org>
 <20260506221027.858481-3-dakr@kernel.org>
In-Reply-To: <20260506221027.858481-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0653.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce90067-a74c-4a99-1cc8-08debc298cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|22082099003|18002099003|921020|6133799003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: oHp8SUc3D7RM70522oogb1h157uhXYt2XYtg3/nou4zrKXx9y9WDBY+oXXSXe0xUJRaPHRgy2x723fJnCH8p8PzLDIpKjY5CRaZ4BpvMUD0O8aI8Q4z6ch/V5KHloaP3QUXoFV3/TkfxNVNL1fENaGmnPad/2NER9H7TmhgIc0VSM5gSvMGHSuqTXqlR++LTbIMtfSNaUg3aRh+3f2f101xGnAt39I9I14J9e2ZFbK6ZRj4fBsqA85+BykuZ+CZlG6GCPHmlXOWDMWaT+hoo/GoPdG8ldF6lUb6zIFEjlSfVmxCCZuZWvfT0RmhnNLyJcdo7vostL2zophhxs2iV6Jfro7OgfegG0Q60VD/jSAqIdlQ1m0hI70k79biW6k4MnFAl4Hn7/peHxkHLMa9YmgcU+fkBSnr0NunNGfzhw4M7qWVuMR1OiQbM3X5ZSZ8hqcAxtJe88+m875Jv1OkJeb0Bn3AUsNnM5dONQPsOby23/iiif2ChvPhq0+tHFn8wVpG5eJZnawdCZSqK/C7U1ZS9k0Dd80qwZwEpr9wD1Z6YLzti/eDR0/fWQDSEyOuyYOG4R21pMu5KRZTRSLbawWgl5Tgjy3vsQGr30B+emtVDddvw9QwgD1h/G5QMkZSnwtpunNnayUNuwqpuKU0pAbqonrVSAl5MaujoLNxh0i9d92H5YZwSWqDP3ufF0n2s6eUxMU9qJjT1Nf2slCvRDajzaROI0yQWR/BoIpa0a2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(22082099003)(18002099003)(921020)(6133799003)(4143699003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9TRDJyQjQ3ZCt1dFZ2d0dWeEtFZFB5UGEwMW9kTFpGSWJnOXM2ZVZmdEp5?=
 =?utf-8?B?YzdjajJJL0pHNk1OOXQyTTRMYkpzVXplbmJBaG42dmtHaGdULyt5WTA0aWt0?=
 =?utf-8?B?WkRzQ2RmdmpSQ0hXaTF0enRxM2daZ050WiszZlVsWmNFT1lDRFFwTUY3ZEV3?=
 =?utf-8?B?bnJTTCsrTVc4VHhDWDNwb3NmQVRyRGZTNDg2NlF0VG5ORmhBRGMyZnh5WmJ2?=
 =?utf-8?B?cU9kNnhoMVdiMkZySm9qU2toYzdSemwrNVo5QzJ0NjUzL2Q4NWJTU1hEYVpI?=
 =?utf-8?B?Vmp6eGoydU54SEdqYkhWZVd5WDFqS1FCdGxiU3NBaGQyM1pjd1Z1dWExQ1hN?=
 =?utf-8?B?VUFtMjFWYkd4aDduN2czOUZwNWlKdHJJekhTa2JRK3U4QVFnZEZsRmdVRWNv?=
 =?utf-8?B?aXBtTlNtM1lrVVdwSUhOWk0zTVNXRVBtNWhUQWt4QmlYd0RlRGVLNGJNVzM4?=
 =?utf-8?B?UUFER3ZxcVpnU2ozNXFGenFGZkVhUzJqYWFoeXYxV0ViNjY3Zk9pbS9KalZa?=
 =?utf-8?B?ZzcwZHNYcmM2SGNzUC9NRmM4dkpqNUozbnBYRStSa2s5bXorYmZ4QUdDVnhT?=
 =?utf-8?B?a0QvM0hxYjU5Z2JwQjNmSldGVFVXTXQyNTRFQ1FyNFp0RGVhT29GVElENmVQ?=
 =?utf-8?B?MHUzeFd4WHF3ZlFvTW8wS1lmMEZPVGZpTmxQZE9BMkJPY3NsUVNSNS9pQzNw?=
 =?utf-8?B?U0NiSDdkbU9udXF1OWI5K1hteEdOZ0FJelFxdWpqbDRHQjZqKzVFUmpuVjRZ?=
 =?utf-8?B?a1Y5eUxGYmNndXpobjAyRElrUUpvOTA0eUo2Q2VBb29ka2doMFVZTHRwdEdD?=
 =?utf-8?B?ajJXd25lNzFRb2FJT2tRVjZJa3JkNHZwZUI2TlhRN25hUVFhNkg3aVVUWFkv?=
 =?utf-8?B?eGJTYk1UMXNaV2wyRTI0dTNCem0reTFjSnA5SVlhcjN5UE5OSnhIWFlKOVBq?=
 =?utf-8?B?cHpEMktHa1lnRGtkZjdqWjA2d2ZqNUJ3S21URUREN2RMT2JHY2FiNmp4QmJs?=
 =?utf-8?B?THBXcDN2Q2wxRG9XNmNuUU5kaDZZMzdUVVZxbjhHS0JkZmpKcDR0MHN2WWNW?=
 =?utf-8?B?MCtJRjZ5azk5cnJKc2VRem5wRURZb01pTllrS1NMcW9aZmtId29QQTV3ekEy?=
 =?utf-8?B?b2IyUmtDNk1zKzJJYmVoUzlxNE01NVozQ01LUzRwTEhNVThKamRsLzMrMFdx?=
 =?utf-8?B?UWd6SzFXQ1k1dXZlbWdjRjIyRDRVV0h3NmJ0UXBzbThaNGY2bmtCanBkWUxz?=
 =?utf-8?B?RVZpK0hrY21qbUo5WC91UzNMQzlGa3JveXFDUnIvK1FMV1FOb2szaHhXZGp1?=
 =?utf-8?B?SkxHVG8xUk12S2tyenZMSG9TZlZSVVdpdS9tVzJmMmpkaEFFaEFhTjFDUit3?=
 =?utf-8?B?ZStJS3gwN3hWT0NZZWh2VVRRc0tVeFU2eERobjc1WWhFSnl1ZTg2MnZablNY?=
 =?utf-8?B?ZUxGYWRpYWVKTGVad2N5eU8yeFVmbjBXV1Fhd24rQ3FMS21rWWtTeWVQazMw?=
 =?utf-8?B?QzBUQmc2UmhjTHUxWEJSUTZ3VGpjbnN1b0EyQzlxNFVseEVYcjY0N21SVDVZ?=
 =?utf-8?B?VUZhTFFUMFFhTFFQVlRkYlYzRlJ2RE5YNFIzdUx3eTZtMG1JNWpiYjk4b01C?=
 =?utf-8?B?UE9CY0p1bXdHS0hIMER6NWZjL2plV1BIazYwcnNvTzl4a3d6TXNIaGEyWTUr?=
 =?utf-8?B?cVg3NGY5WmxaSE8ydTNWVGlaRE1OdVdKcDRXeWtBcGpSRG5iYS9xN0xGVFpj?=
 =?utf-8?B?R0FPUkZJcVB2RWdIOHZzc1FjZFJIOTlvRk4rSW5UNzFucFNHL3JnOXA5THJk?=
 =?utf-8?B?c0ZKamNDUlpnTHI2Q2hIWHp6NlkzaXBwUkdxVEtrWU5VeExCQUppOGtDbE0v?=
 =?utf-8?B?REcyR2tCdXl3T0Z2azltMTBKa25DY1NhK3gzME13TFlXbUJzYmFzU2FKcTd0?=
 =?utf-8?B?a3hwZVJia01pWXdlYjJXT1NvVTFqRGhDWEVDMktra2M3U0tBZWpYSTl2YnJr?=
 =?utf-8?B?YVpES0plem5yWUEwWTBnYTJRSDNJMTViSE1xNy9vbi94WmJSajd5VE4vVEps?=
 =?utf-8?B?VWZMenhuMlhBSVFJaHFKNFd3NTdoTXNna0VxeWJoSkpkTUthUUtvL1lwNkFR?=
 =?utf-8?B?RW5ML1d6M3MzKzZRT08wSkg3YW51dG8xdHp4YWl3UEhzTTF1R2ZTRW5za2dy?=
 =?utf-8?B?U3E1Vi9XVHg2bUVQSWtWNHZBSTBoRzZrWGZJd1FOeXcxUzlsSlhoZkVKOVBO?=
 =?utf-8?B?VWxQMVJ0Ym9LV1kwRjNWNnhoek54Q1VqenBHYmo2bHY0ZFl1a0pXR0NDVnhr?=
 =?utf-8?B?K2x4R0RMajhhZHY4L2Y3ZUhLai85NE53Mjg4NkVWOEdGZWdYQ0dBdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce90067-a74c-4a99-1cc8-08debc298cba
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:52:57.4494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iid/Y4fcH+NYtm575bxTX6Ujyi5K5Pu88Q7TFs8mVZ48Q6JJnAHbfYhtVzAOH37Qx8h624HgB8zfMlsa38lglA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7041
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

On Wed May 6, 2026 at 11:06 PM BST, Danilo Krummrich wrote:
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
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/drm/device.rs | 80 ++++++++++++++++++++++++++++++++++++++-
>  rust/kernel/drm/driver.rs | 10 ++++-
>  2 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 492c2f2c7ca4..bb685165032d 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -6,7 +6,11 @@
> =20
>  use crate::{
>      alloc::allocator::Kmalloc,
> -    bindings, device,
> +    bindings,
> +    device::{
> +        self,
> +        AsBusDevice as _, //
> +    },
>      drm::{
>          self,
>          driver::AllocImpl,
> @@ -334,6 +338,80 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContex=
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
> +    /// Between `drm_dev_enter()` and `drm_dev_exit()` the parent device=
 is guaranteed to be bound.

This should propbably say "While `UnbindGuard`" is held, the parent device =
is
guaranteed to be bound.

> +    #[must_use]

To aid search you can add `#[doc(alias =3D "drm_dev_enter")]` here.

> +    pub fn unbind_guard(&self) -> Option<UnbindGuard<'_, T>> {

Would it make sense to have a dedicated error type that converts to some fi=
xed
error code so people can use `?`?

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

#[inline]

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

I suppose you could also just store this whole thing in unbind guard.

> +    }
> +}
> +
> +impl<T: drm::Driver> Drop for UnbindGuard<'_, T> {

#[inline]

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
> index 9d06f8c5b2da..751a68bb27e1 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -187,8 +187,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
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


