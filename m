Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD34C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 03:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A0410E2DF;
	Mon,  6 Jul 2026 03:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSzlIjbz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFE110E2DF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 03:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfJx4KFciKC7z7A7gn3l+7c8mN0TFN08li4vJlKqTS3XNCR52THJuQU65zL1qXrSxtHkHRnbATtXRMLaoJTZdfFIdSdNnpQ4ckWtlMZz6UpksRkV0HdXAqJUggmtXYcNuBxQ/a50smjooL0vE9Hrao/0DAFXHVvGSBFBl416kRiGlCNWdyXEkztWSj7aiyU5v14YpgKbOXo9Iv1Xdf/A7SPi/On5+2OcxnGplmZfJ5gbtg5CLwlRvbRap2IEWG6i25JAaqOmIff4+08D7oi0wVpAqIFYf9atO0VwDvuQaS3rDeMspI2+4Tew3K8CUhBMMrBXM5l2vMSRFyZqzIWQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBNpFYltuV0G6KVgGn60lo1inUQPA2wHZu1LlSNPSUU=;
 b=LeDJGFF7BG2/zIy99E2CytcbMgpNWJFALxMOWnpJgMano1ZCNTecF2kYoBK/wb16a+A9nb4P1ADnXq5GsllCIWicEoH1gZ9eg7T3sowYUsA2v9Fk4KI7cR7v9B451efUARlEj+0FNmSt60yDTONnrEsyKWLi45pD/kjI9KrQ1swieZPbntIHorNOoCk0S9hXh0U2Z0cM3ovZcybkK8XhE+JIecpJOKhfhF8amZyMwWBs5dYl6KNppndkg71GN/bqD8eEPtYmcAFRa7RzwfEnts3yF5tA8HuQhrWjAaGEv4S0U/ZzMtQFeioX+V0KaUx62iQxwpnyQbg6pwLeYGJdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBNpFYltuV0G6KVgGn60lo1inUQPA2wHZu1LlSNPSUU=;
 b=JSzlIjbz7Tb9VSpCAkU1gqUxi/yTrTHksB8ty95Na3qS0hU753jkHZpf8ccelq2HZIq6BkmQ/T7JFZ6cG0wHWGzfLG6QJ7oNrQzKssIfrGF8RbP1fGxWgIGZqnyAfgTBQuXIWuY1ODjbLJLXbtrtJOlcAs26+HHMnGiPQAmiciceQPNicTDt48QyILx+HRUimj4kiC3aB1o6V/dTS0F7oJc04GwSD04WSAyimMRre9IEKPnTuleTLq6BIp/lcha6z7s1zdou5He/wURXdSASfF/odml4RgBbuY9BrKvbCZ9RLTH9MyvOLd+ZweeRj9F32ZDR0OuDxRCpJo2tOxisPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 03:20:33 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 03:20:32 +0000
Date: Mon, 6 Jul 2026 13:20:25 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC 1/3] gpu: nova-core: Add auxiliary bus registration data to
 nova-core
Message-ID: <akscbqrSBTtRpWV9@nvdebian.thelocal>
References: <20260703064526.3630668-1-apopple@nvidia.com>
 <20260703064526.3630668-2-apopple@nvidia.com>
 <DJQNN9FRZN3C.3DQE4H9HAZ8W6@kernel.org>
 <DJQSY9ZY5M5F.3VI537GS00E1G@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJQSY9ZY5M5F.3VI537GS00E1G@kernel.org>
X-ClientProxiedBy: SY8PR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fb9185-0e3e-4e0c-3d98-08dedb0d899f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|3023799007|11062099010|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006|7136999003;
X-Microsoft-Antispam-Message-Info: SzLB6sh7i2jwNLf6i6gNxIrsiluUDXvsQqfd9MBtlYtAAfE9EZN3wXGHL/hxh1cj/GIlcZZ2nLiVDKZE3ZMSfbSCIOHOmRtHKEFS1JFX573lIyrHJLsRKMkGF0P8LwVZemt4qFeMBY6loLLogXQLVYKKwak+zAGmhJyixaJEccz4pYDFSyUZwlTg1H0NLlrJYfmf7HwCdPOTIrnBlyUnpBD2yFUNZledcaVv0nPRc90fLopk3RrxKpbsXf52xdID+5m3tb4FA61wyOyWP5jXOSnDH9dZGdxUaIpappvLwdLd1qte5dB5O/EstHHZ3khlqWCSl5kDIlfuPKr26tupI9TIAFs4MaGqsjlYQiKHUtaiXI7KUV3KZM29j6scgvrfgi/nQiSUak0LYQQNPpOljP4sjETBR4y7UBP62oH4g+bsR0nEJcQx1ME58vLAFS/bD/pDh7TnsSyXdqNjdIbIZlAr4QesYNrkxyOt6UuUd6j7hAJvvtklUOWlv1cyXJhJfxQZTTuRIUcrepCH6rE2GiFCQ/mJxdwTx6lVjVF0fRPmNJJnp5ycVRz4se8Azh6yCJ7/sU6VTCnwlVTXFBI/4PCYmPid8jZ24ICWojtrPa9S1DsGZBLbfdES5NWcQSGvVjSy66qS7rB8kHIXSRGygIk5HfYS9yo7KnKxrsYOP04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(11062099010)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jPCkFpbutAu59hanKJZ6Gi64cxQr8RJaqHZC7brqOVXk3c1weEqr5PCXr6AD?=
 =?us-ascii?Q?6vmzFgmTCEuWzOy+d7ImtRpjYcXSHfJtB9Scbon2KQEHPSZFWwHetSn1Dwlz?=
 =?us-ascii?Q?QpB5E3j8ZwAu2t0d4s2oHYYLgLjM4Cb/sHT1ap5D5GwT4HmCSpnCZTuoFvfB?=
 =?us-ascii?Q?NBq+SyUszCG4MKy39qjMJA3JG0elCW2P7SmRRfCWh8IQsIhLrr7qMWl/FL5w?=
 =?us-ascii?Q?LXFu5F8D1emZpl06Px66EDJBHId5RZAuHec5giECGsAqI1eJoWB12UijxFTB?=
 =?us-ascii?Q?HHcSrjDwKEPRPmBYXHagT6Li+R4Mst9wROtNca1o62tykXSh9gv+rXMWgEQ4?=
 =?us-ascii?Q?C+8m9xaFKlCukJ68MwjTrmloiLsSVZv2uSZjIVnrM+T7Aih5f8HBwBANiKVN?=
 =?us-ascii?Q?by/8d3pI4S+7eU3KXdvpIKT70CpGo+5yS8EzL2Kor4qr87xkDIJPr0vmMvAr?=
 =?us-ascii?Q?iKV7FiCv6Fn+N3KIFh5KnaKoDFfvqBFRJsRReoEAZ/LpYa3QxiIpervPgex3?=
 =?us-ascii?Q?HlveR4H5HDIxBMf1CCE0rXGxs1kykZQjh4ostsjH1Ue/0dims2CACO8Yz1Na?=
 =?us-ascii?Q?0Z08fWkyZ0yeuvYQbwD81IDVvvzw/F6cRnhg0F8Vgug6YZ9HUjauy2hyexCk?=
 =?us-ascii?Q?83KW5fsrPfDwXHPUbjfiM7fFCydj/Z5CRpVStRVaylKdt1rxoBRfCwNcbVIF?=
 =?us-ascii?Q?Z6kE1FOrZgLB6QyWB/vQ+CsbLaNQUnW0GofpjbjxrvB3M/4dhLo8nCS0ju7f?=
 =?us-ascii?Q?OUiXQHYohcuHA1//6p7TBDHnFMLLIfUhERQFiu5YNyhZ0D117N+n/KfUaz8/?=
 =?us-ascii?Q?CFiZT2vM174/LCkyEG5Rr5i22W0CkwaLDJ1cX0ViQmTjJ05FyVr8KzbFji9M?=
 =?us-ascii?Q?xpsaviI4wm3M81a90zWORUTDyGuxWRR9dkDuRM7RroPf9/FdvBVbBBQ137i1?=
 =?us-ascii?Q?lZzcFCQ3wu/SHAy0rFxBkVInhTx8os+TkvH03GdXxExIQyaqEhQs9d313Yg/?=
 =?us-ascii?Q?JsKFoaAnuLjTtEJV2G3Kgls1/gccx2FJxOoeBvIgiBW2xunWEe3mkvwQ55nS?=
 =?us-ascii?Q?HznGrDZvMlt5/uaukvVQEF4T+0HDRJvGoru/+/shDopLVsewG9xaxI7ehTsw?=
 =?us-ascii?Q?5rx00PrhPdjdqhGfxX34hOEpOtBqw7OTEdicEQN1EliV/yFiSSC5jtDV5cZJ?=
 =?us-ascii?Q?hI2An0lF7xgT1QqqxHruBUQYcWrlHIytNLD9ozJxANo7CY6d6VweLWBikwsk?=
 =?us-ascii?Q?za4FfIYvreoVvastRoIkxUhdDzs6K1Wp9m+d27sJEYES38Jtt4YildebDiBQ?=
 =?us-ascii?Q?3wVxfFiuVVevW7al4Oa74IHeGLd1axgv3SyZCQEw2UlJdqsgtCDRwHZYu856?=
 =?us-ascii?Q?YXGQ3u3fzpFSSWOMxbNxQ88wq/AWdnXHvweajIylmnJBvD51YGClAa/GyYOZ?=
 =?us-ascii?Q?rf6a1iChcHJwHT89Du9MO3XqUduRJNf+evNWa9E9v96Rga473z92OWp8dS8B?=
 =?us-ascii?Q?a48lOvrRL9jqZG8E+iwsxujnuGM6RNpHAz3KMgy9gPCjgbBYEhlBtIiFDYjG?=
 =?us-ascii?Q?98m469LvfP76giHrgj/qk2dTSGuu5YHCHv9gEP+YOdGihGG9bh7DMcN+X8FS?=
 =?us-ascii?Q?KiVSyBOzsjtH4RV52Ow83FuHGZKVe9WR8GCLEHh6sLovdk9oZF017un9FY+F?=
 =?us-ascii?Q?j5FdR7FUTC9UEa5FYqc1DsdUTXC00MWd8mY9gxtaJw5LK89Pep0z3EZorsEp?=
 =?us-ascii?Q?5x/kVAeVew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fb9185-0e3e-4e0c-3d98-08dedb0d899f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 03:20:32.8376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZzJiyVGHVv+7YRdohlBsTnUzfWNI5N/hSDO5D1jN9dn2PqE42IJxaZV5XxqLjFDa5459OOPYpCzc2w8HzDJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542
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

On 2026-07-06 at 03:09 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Sun Jul 5, 2026 at 3:00 PM CEST, Danilo Krummrich wrote:
> > On Fri Jul 3, 2026 at 8:45 AM CEST, Alistair Popple wrote:
> >> diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/auxdata.rs
> >> new file mode 100644
> >> index 000000000000..266b5ce4ee89
> >> --- /dev/null
> >> +++ b/drivers/gpu/nova-core/auxdata.rs
> >
> > I think it'd just call it something along the lines of api.rs, as this is going
> > to be the file where the entry points into nova-core will live.
> >
> >> @@ -0,0 +1,12 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +//! Nova-core auxbus data. Contains all the methods used by the auxbus drivers
> >> +//! to interact with nova-core.
> >> +
> >> +use crate::gpu::Gpu;
> >> +
> >> +/// Auxiliary bus registration data. Used by the auxbus drivers to call methods on
> >> +/// the GPU.
> >> +pub struct AuxData<'bound> {
> >
> > Since this will also be the data type that will be exposed as an API entry point
> > into nova-core, I'd rather call it e.g. NovaCoreApi.

Heh. Yeah, I didn't expect this name to survive :-) It was more a straw-man that
I forgot to cleanup - NovaCoreApi works for me.

> > We should provide an assoicated function NovaCoreApi::of(), which takes an &'a
> > auxiliary::Device<Bound> as argument and returns &'a NovaCoreApi<'a> (at least
> > as long as the type remains covariant).
> >
> > This makes it a bit cleaner since it keeps the type assertion local to a single
> > place and makes it transparent to nova-drm that this also is the
> > auxiliary::Registration private data of nova-core.
> >
> > (I'm already working on getting rid of the type ID check, but going through
> > NovaCoreApi::of() is cleaner regardless.)
> 
> Thinking a bit more about this, I'm still not convinced about a design where the
> auxiliary::Device itself carries the type information. However, I think with the
> new lifetime design this isn't necessary in the first place.
> 
> We can just call NovaCoreApi::of() once from nova-drm's probe() function and
> subsequently store the struct NovaCoreApi<'a> in the bus device private data,
> DRM registration data, etc. Such that the only fallible path is in probe().

I agree - and passing a handle to nova_core to access data was my original
instinct and unposted implementation. Of course prior to the higher-ranked
lifetime series that obviously involved some unsafe code (and possibly actual
UB).

Now that we can safely store the handle in the DRM registration I think this
looks cleaner - I just couldn't quite figure out the mechanics so thanks for the
pointers. I will incorporate this into v2.

> Please see [1] for reference, there's also a branch in [2].

Thanks for doing both - I appreciate seeing the proposal in the mail thread.

> Note that this only works for a covariant NovaCoreApi, once it becomes invariant
> we'll need something like this:

Yep. But for now at least it is covariant so I think we can avoid doing this
until needed.

 - Alistair

> 	/// Closure-based API handle for invariant registration data types.
> 	pub struct NovaCoreApiHandle<'a> {
> 	    adev: &'a auxiliary::Device<Bound>,
> 	}
> 	
> 	impl<'a> NovaCoreApiHandle<'a> {
> 	    fn of(adev: &'a auxiliary::Device<Bound>) -> Result<Self> {
> 	        adev.registration_data_with::<ForLt!(NovaCoreApi<'_>), ()>(|_| ())?;
> 	        Ok(Self { adev })
> 	    }
> 	
> 	    /// Access the [`NovaCoreApi`] through a closure.
> 	    pub fn with<R>(&self, f: impl for<'b> FnOnce(Pin<&'b NovaCoreApi<'b>>) -> R) -> R {
> 	        // PANIC: TypeId was validated in `of()`, cannot fail.
> 	        self.adev
> 	            .registration_data_with::<ForLt!(NovaCoreApi<'_>), R>(f)
> 	            .unwrap()
> 	    }
> 	}
> 
> We can still improve this a bit from the auxiliary API side, but in general this
> should be fine (added this to the branch in [2] as well).
> 
> With this the access patterns becomes
> 
> 	// Once from probe(), calls NovaCoreApiHandle::of() internally.
> 	let handle = NovaCoreApi::handle(adev)?;
> 
> and from anywhere else
> 
> 	handle.with(|api| api.chipset());
> 
> [1]
> 
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
> index 739690bc2db5..89da0f6c3ba5 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +use core::pin::Pin;
> +
>  use kernel::{
>      auxiliary,
>      device::{
> @@ -17,6 +19,7 @@
>  
>  use crate::file::File;
>  use crate::gem::NovaObject;
> +use nova_core::api::NovaCoreApi;
>  
>  pub(crate) struct NovaDriver;
>  
> @@ -26,6 +29,11 @@ pub(crate) struct Nova<'bound> {
>      _reg: drm::Registration<'bound, NovaDriver>,
>  }
>  
> +/// DRM registration data, accessible from ioctl handlers via the registration guard.
> +pub(crate) struct DrmRegData<'bound> {
> +    pub(crate) api: Pin<&'bound NovaCoreApi<'bound>>,
> +}
> +
>  /// Convienence type alias for the DRM device type for this driver
>  pub(crate) type NovaDevice<Ctx = drm::Normal> = drm::Device<NovaDriver, Ctx>;
>  
> @@ -59,10 +67,15 @@ fn probe<'bound>(
>          adev: &'bound auxiliary::Device<Core<'_>>,
>          _info: &'bound Self::IdInfo,
>      ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        let api = NovaCoreApi::of(adev)?;
> +
>          let drm = drm::UnregisteredDevice::<Self>::new(adev, Ok(()))?;
> +
> +        let drm_data = DrmRegData { api };
> +
>          // SAFETY: `reg` is stored in `Nova` and dropped when the driver is unbound; it is
>          // never forgotten.
> -        let reg = unsafe { drm::Registration::new(adev.as_ref(), drm, (), 0)? };
> +        let reg = unsafe { drm::Registration::new(adev.as_ref(), drm, drm_data, 0)? };
>  
>          Ok(Nova {
>              drm: reg.device().into(),
> @@ -74,7 +87,7 @@ fn probe<'bound>(
>  #[vtable]
>  impl drm::Driver for NovaDriver {
>      type Data = ();
> -    type RegistrationData<'a> = ();
> +    type RegistrationData<'a> = DrmRegData<'a>;
>      type File = File;
>      type Object = gem::Object<NovaObject>;
>      type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index 57df54ba27bd..2488825c78cf 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@ -1,7 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -use crate::driver::{NovaDevice, NovaDriver};
> -use crate::gem::NovaObject;
> +use crate::{
> +    driver::{
> +        DrmRegData,
> +        NovaDevice,
> +        NovaDriver, //
> +    },
> +    gem::NovaObject,
> +};
> +
>  use kernel::{
>      alloc::flags::*,
>      auxiliary,
> @@ -16,9 +23,6 @@
>      uapi,
>  };
>  
> -use kernel::types::CovariantForLt;
> -use nova_core::auxdata::AuxData;
> -
>  pub(crate) struct File;
>  
>  impl drm::file::DriverFile for File {
> @@ -33,18 +37,17 @@ impl File {
>      /// IOCTL: get_param: Query GPU / driver metadata.
>      pub(crate) fn get_param(
>          dev: &NovaDevice<Registered>,
> -        _reg_data: &(),
> +        reg_data: &DrmRegData<'_>,
>          getparam: &mut uapi::drm_nova_getparam,
>          _file: &drm::File<File>,
>      ) -> Result<u32> {
>          let adev: &auxiliary::Device<Bound> = dev.as_ref();
> -        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
> -        let data = adev.registration_data::<CovariantForLt!(AuxData<'_>)>()?;
> +        let pdev: &pci::Device<_> = adev.parent().try_into()?;
>  
>          let value = match getparam.param as u32 {
>              uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
> -            uapi::NOVA_GETPARAM_GPU_CHIPSET => data.chipset() as u64,
> -            uapi::NOVA_GETPARAM_VRAM_SIZE => data.vram_size(),
> +            uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
> +            uapi::NOVA_GETPARAM_VRAM_SIZE => reg_data.api.vram_size(),
>              _ => return Err(EINVAL),
>          };
>  
> @@ -56,7 +59,7 @@ pub(crate) fn get_param(
>      /// IOCTL: gem_create: Create a new DRM GEM object.
>      pub(crate) fn gem_create(
>          dev: &NovaDevice<Registered>,
> -        _reg_data: &(),
> +        _reg_data: &DrmRegData<'_>,
>          req: &mut uapi::drm_nova_gem_create,
>          file: &drm::File<File>,
>      ) -> Result<u32> {
> @@ -70,7 +73,7 @@ pub(crate) fn gem_create(
>      /// IOCTL: gem_info: Query GEM metadata.
>      pub(crate) fn gem_info(
>          _dev: &NovaDevice<Registered>,
> -        _reg_data: &(),
> +        _reg_data: &DrmRegData<'_>,
>          req: &mut uapi::drm_nova_gem_info,
>          file: &drm::File<File>,
>      ) -> Result<u32> {
> diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
> new file mode 100644
> index 000000000000..ba99d5a27805
> --- /dev/null
> +++ b/drivers/gpu/nova-core/api.rs
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Nova Core API for auxiliary bus child drivers.
> +
> +use core::pin::Pin;
> +
> +use kernel::{
> +    auxiliary,
> +    device::Bound,
> +    prelude::*,
> +    types::CovariantForLt, //
> +};
> +
> +use crate::gpu::{
> +    Chipset,
> +    Gpu, //
> +};
> +
> +/// API handle for auxiliary bus child drivers to interact with nova-core.
> +pub struct NovaCoreApi<'bound> {
> +    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> +}
> +
> +impl NovaCoreApi<'_> {
> +    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered by nova-core.
> +    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
> +        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
> +    }
> +
> +    /// Returns the chipset of this GPU.
> +    pub fn chipset(&self) -> Chipset {
> +        self.gpu.spec.chipset
> +    }
> +
> +    /// Returns the total usable VRAM size of this GPU in bytes.
> +    pub fn vram_size(&self) -> u64 {
> +        self.gpu.gsp_static_info.vram_size()
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/auxdata.rs
> deleted file mode 100644
> index 0a07a10da327..000000000000
> --- a/drivers/gpu/nova-core/auxdata.rs
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -//! Nova-core auxbus data. Contains all the methods used by the auxbus drivers
> -//! to interact with nova-core.
> -
> -use crate::gpu::Chipset;
> -use crate::gpu::Gpu;
> -
> -/// Auxiliary bus registration data. Used by the auxbus drivers to call methods on
> -/// the GPU.
> -pub struct AuxData<'bound> {
> -    pub(crate) gpu: &'bound Gpu<'bound>,
> -}
> -
> -impl AuxData<'_> {
> -    /// Returns the chipset of this GPU.
> -    pub fn chipset(&self) -> Chipset {
> -        self.gpu.spec.chipset
> -    }
> -
> -    /// Returns the total usable VRAM size of this GPU in bytes.
> -    pub fn vram_size(&self) -> u64 {
> -        self.gpu.gsp_static_info.vram_size()
> -    }
> -}
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 8b0bebee0bdf..9cb2eecfae1c 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +use core::pin::Pin;
> +
>  use kernel::{
>      auxiliary,
>      device::Core,
> @@ -18,7 +20,7 @@
>      types::CovariantForLt,
>  };
>  
> -use crate::auxdata::AuxData;
> +use crate::api::NovaCoreApi;
>  use crate::gpu::Gpu;
>  
>  /// Counter for generating unique auxiliary device IDs.
> @@ -30,7 +32,7 @@ pub(crate) struct NovaCore<'bound> {
>      // device before dropping `gpu`, and drop `gpu` before `bar` because `Gpu`
>      // borrows `bar`.
>      #[allow(clippy::type_complexity)]
> -    _reg: auxiliary::Registration<'bound, CovariantForLt!(AuxData<'_>)>,
> +    _reg: auxiliary::Registration<'bound, CovariantForLt!(NovaCoreApi<'_>)>,
>      #[pin]
>      pub(crate) gpu: Gpu<'bound>,
>      bar: pci::Bar<'bound, BAR0_SIZE>,
> @@ -82,7 +84,7 @@ fn probe<'bound>(
>              pdev.enable_device_mem()?;
>              pdev.set_master();
>  
> -            Ok(try_pin_init!(&this in NovaCore {
> +            Ok(try_pin_init!(NovaCore {
>                  bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
>                  // TODO: Use `&bar` self-referential pin-init syntax once available.
>                  //
> @@ -105,14 +107,16 @@ fn probe<'bound>(
>                          // For now, use a simple atomic counter that never recycles IDs.
>                          AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
>                          crate::MODULE_NAME,
> -                        AuxData {
> +                        NovaCoreApi {
>                              // TODO: Use `&gpu` self-referential pin-init syntax once available.
>                              //
> -                            // SAFETY: `this.gpu` is initialized before this expression is evaluated
> +                            // SAFETY: `gpu` is initialized before this expression is evaluated
>                              // (`try_pin_init!()` initializes fields in declaration order), lives at
>                              // a pinned stable address, and is dropped after `_reg` (struct field
>                              // drop order).
> -                            gpu: &*core::ptr::from_ref(&this.as_ref().gpu),
> +                            gpu: Pin::new_unchecked(
> +                                &*core::ptr::from_ref(gpu.as_ref().get_ref()),
> +                            ),
>                          },
>                      )?
>                  },
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
> index d00c8804269d..9463ae038e81 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -10,7 +10,7 @@
>      InPlaceModule, //
>  };
>  
> -pub mod auxdata;
> +pub mod api;
>  mod driver;
>  mod falcon;
>  mod fb;
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=nova-api
