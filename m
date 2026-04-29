Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5BFFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E2710E298;
	Wed, 29 Apr 2026 11:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BZsvSBG1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163A510E298
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDx18UhGIV80tHbZhB2Ss7IoMcrwvx+SGXiCa1/l91rWTFTLqXtH4J63E8KFExYQVGZ3f3z/ur74HelPiue0DcJIvfst43uLZOZNieSiWtr07Q3Q7UuI8T/WRlSoYxcE/CVsQDf28h5TrbwSVRnr/4sCql097TOpyZXGoJ+kXW0ILNNPBwiTQ4xmtuoIUZqn5fP3nrA4evJd+u/GagEBFFptnORIN8IB1zWnPAa+Kno+/XvcMKXA8Gr6/yt0x/B0sXbhfS3oYz3vJGGRcH88vTLlHxvVAOzU+sBr8tUanjO35dW4Envn6hsoJX5LJIjlRWgG3xns6kvxqTJLqkiyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4/vnTPC6wX4mpJ2eRRHYyR+U7g9gw9r5PlpYPQEOgs=;
 b=wMiELq9Kzncd672CazUjkLrIstvJLS4TpdmzXHL5uR6QfzZ3fcvfGvsn/CLQsR47LYCMSH8La4uH25LYfIdl3p0f9tzP7zeTQ9muatoQyJAkMhzHzpgY5HwPn6IRFrCyLlvwLaeSVC8Ni/kQGD5QNymsdZz7SBwyABYq/6ERDi0TE3z3yTjDkLOcEn4cBIo8QBJRWWLs4GOu5MK0zcfzL7ABYlc/TdWG151b5+SLZ3TEX/tA8eSF+Sx5KrRobkFpeKmDWEnZNedwm/6V915SiFrGJMxw4Toc3z1MVmfoyBs/skJYqcZOutQQs0UI6IHRSPwsQ7+f05IlWZpEBJfW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4/vnTPC6wX4mpJ2eRRHYyR+U7g9gw9r5PlpYPQEOgs=;
 b=BZsvSBG13+iofgD+MzQmzclwaZk7+nNCK9m485qoYEp0eckik1yQ8YCgw+V/sjcWfx2sswyZ1jnCWVCB7CPDxt9Ye+fSn69IU43sv8RcACwB6hMactmUM/M5z80FniZeNBUMN3mMAdUGg1THLvc8+EQjxgKsYTrfLE2ail31Nhc6wAL8BqvzeXYWg1cGm7N6x7B57yrjOIXdsHLKMGaTyBwY3f4xlzXX9yB6n+PO+Dd6PM2gCplJd1Z+9fMy2t+eqcB9muhk6Zk4JPto9fV4BbOEsNM6/KHsyXyiXTpBzS/LaPMX7aInrugPJYNnJ5DPN/kk1Fqr9lw54/d9TY36Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 11:21:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 11:21:27 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 20:21:23 +0900
Message-Id: <DI5LKWS7J1D7.1O8GCHRV28QZ2@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org>
In-Reply-To: <20260427221002.2143861-2-dakr@kernel.org>
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 803add6b-f30d-4ed8-3bbd-08dea5e17432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GDH6oqA4aVaVgZx/8aDmO5YWDrpnhdF06ufwtto2vbtbj2Fh+Na+oQAwdVus0rx5Tq6nOgRzM1RkHChEbxe7n/qwrKk6GZSge9i0f0BeQTC3ulLe4iqvG/MfDHM0mYOFYBKPVXqWIHs2cKxHgjOJRRLnoUPdst9iCx0ZmN9unxwM6k0LCug5K76ljrRQi7brYCV/VC+tDJU4vkQ9Q8NUSZV1rGt6Rc5Th9+epKI5oOjO+pMFupf9O9g7YnuQYwdSlmwnWXrZyUSSV2AWQqNChhRTGrclghlCYtRcN03siSCBxMujLuOjiCJizX2GpBjFiw6d97WDa+oztNyOOeXXWmfgZbb1aIUqA/ZMxNFeSa5HGuROoa7gCRhF71tIRxe70I5H54QbzKbRqzN0Wv2JltgYp1inzSgPUaimWu9QVXj12aYWzHoJUYWI/cldrGbnS5Ytm3poT3Ou1EWBQpkbK6xPsD1ZlpT7ax/8aaRqP+/Qtp3uoHgshIurbCECR2xr6G+2PY6NsAZNKkXtc1o3N+Wslyk5zuYtzH9E2X36jCQZC2xpKyOMpR0HtAKmps0yZPuJj0fcC7u0mzENXsj9lE0+SOWHYUxKl9JR+8IxMitFnw7g1XMlnAqzFuElc6jOt/En7VWiOsNk1A/5ZGJBHGWhEnxleetqURxxWObi8ZsMCTDhOULk2WZ2er7p5QesXMQWEGkrJmzn4WNvZdqZxRnNHlpOkOEB+D0lNJUcxeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRhcXo3VUFVVkZEWHRiQnRDUDlkdlIrc1FaVHpOMXlrL2EwS2wxVENJaUty?=
 =?utf-8?B?K3Ftb21ETVUzejlLVUY3aVB5ckNVK3NGTjU0TkVLY2FQN3Vaa0VLV3Q5cHJ5?=
 =?utf-8?B?czNtUW1TK1llWlhabUlrUHA0STFhcUQ3ajFaRmttVlNZd1d5MjlQMU0vMDFh?=
 =?utf-8?B?V2VPM3RZVkw4a2tCclRwWkpsNmdVWmtGbXljSFhYa2NvdlZvRTBRUXdhN09i?=
 =?utf-8?B?cUtZZUNLeFdxQVlZMTVKK1dHaFFXU0I3N2xQTVYvMm9GZVlWWDM4Wi8vWDFN?=
 =?utf-8?B?MHN1QTNZKzJoaHczSjNUbzhwcktuYm5Td2Fvc096VDc0cXIxd255V3ZsTDVW?=
 =?utf-8?B?dUJ6Q29CZnhDaUllUllCTjliTFpWbE1uNjRkMktKVVQ3K0xsSkhmdFpLc1Bo?=
 =?utf-8?B?dC9vdVE5ZHBmM3Z5b3Bpbnl3czM1K1loUGdCbTRIVWlXMm1OMTRQMVoxaXhk?=
 =?utf-8?B?czcxSHkxOWhiRkljWnpSVi9penVWMlAyRHh1a2JCaS9CU2l5Z1B4OVNqM0tU?=
 =?utf-8?B?K1VWekFXWTFLbGtSSWVNeERneEJya01SbGNaUy81eWgzRllmd3BHNEpJZHp3?=
 =?utf-8?B?YU1ZM1VSMjJ5cVFtSWpVOHo5ZXBsQklPM1VoN3ZURHBPcnpzbjJUTTEyeVpk?=
 =?utf-8?B?Q1NoYStRY0FtSHJVQkxKT2wzTnIzYXI1VmY0M0tOZVhBZ1JBdHVsYVZQSEhL?=
 =?utf-8?B?OEhrSHZBRkg3MHJNOGNNYlFqSXowMkFmd2tnL3dxaWhwQlRJZEhpYnd3VlZW?=
 =?utf-8?B?K0FKcWFCOHRhUVRiQXFyYWhyUEJta2tjdlgreEdFQXdLQ1RHcVQyMDRVSXY2?=
 =?utf-8?B?WVpZTlR4YVVnRExib3RmNGNRa0xQcisyZlFaU1N3eHlibzVxTGtiZ0tzVGkr?=
 =?utf-8?B?SGdOS3dQYUt6dnJmQnNlaG0zMi9XLzlsN2hYL2kySGpkdDZ0em15VDBqRHhO?=
 =?utf-8?B?dzRmM3poQVpLM1VFeDdCQi9kOTB3cU1tRUtMNmxOUmdwanl1eHFpNjFHbzdN?=
 =?utf-8?B?YkZLdmdhTU1lRWRsNHAvSWN2dHFPbGE4SmlOanVmTmlyd2JGemswTXBKVzVw?=
 =?utf-8?B?Z2pSc2I1dXVzT2VIK1kvMG1xY3NwMXVYV0lkb3UxdlBVQUlyM1VldHRXbmZO?=
 =?utf-8?B?UjVTVXdqaWg5blFzbm41b1ROZ1h5ZTRmeSszM2x3elRIbVFTK0k5L0VPcmYv?=
 =?utf-8?B?WnB0UFdRRExmZllyYlVnMmZ6TkVnbnJ5ZTJaem4weWhTdVRPeHpZblhKK1lJ?=
 =?utf-8?B?WG5lc2ZSWUhNVFkzSmU1bDcvVmxtdzVONU1UQ1FGek01anJDa3NpaHl2TUtM?=
 =?utf-8?B?emJsRVlKUEFQWU5PTDBWYU9aRUUzRVNydTJKOGNGMURwbGd1RldpeHIzL0dM?=
 =?utf-8?B?cTZ5VHpRUmVENGdQVGlYei9aUTJFeVlzY1JnS0VXR1h1bXJVaktrNG1qTkY2?=
 =?utf-8?B?ZHpYOFFmUjVoZnd5WkZLY1M4MG5TM3V6YVNCRERUUzVrbDZSbm5kS29JVE5i?=
 =?utf-8?B?QVhYRmNsMmZyTkRnZ1NUd2hNZnlrQWlBenhHemVqNnNBeXNKc1BVZEd6U2tt?=
 =?utf-8?B?cEFmODlsSUVmN1VkVExUbGtCb3VpSzBGTEVoaXhvNFR3aWo0anNWdlQrTW9K?=
 =?utf-8?B?WEJWcW1Ock1ZZXBIcjEyZi9GWDRKM2phMDkyTEhLWnRSN2pDMEVvKzJGR01E?=
 =?utf-8?B?Z2NEUUR1Yjdhb0pNcVRoaVRqRGFYaUxFbmxuS0k1ZHhFYTdTOVBrWHh6Njlk?=
 =?utf-8?B?ZFpVZklieW9yVkVDK3l5MkxocDlsVnBmK2JQRGx1TXExTS9xekF3enFWVStX?=
 =?utf-8?B?c0pUb0FEWXl4aTNZb3pwenhmOUN2V2xtQ3FxZXVoOHlrRCs5MnYyMlBuSkdu?=
 =?utf-8?B?RWl1TkFRYXd2TzN2c1Z4Ly9YdjBQL2U4ZWl3bitJNmlGWVJqM0dZeGtUQXE4?=
 =?utf-8?B?blllbnpFZU5jMktpS0xOclN5WktJRStqV0tQTHdBa3BZRkpUZUZJZDZHanUx?=
 =?utf-8?B?alErOWgzVVRHdzRqVTNnT2JteGppc3BzU0laMmlNL3ZQNlQwV1FLeG5UazBP?=
 =?utf-8?B?ZVRUYWtDTGNwdFllemViMlhlL2I0MVY3ZjNyRkd4UzR1TCswRGlSYnFBWlJB?=
 =?utf-8?B?eXVIRkZsdXVFd08yMHc2YllsV2lCWVRlZHR2czR5VkQ2UVovbmhKcTBVVFZC?=
 =?utf-8?B?V2JpTjlLYmowMVNZRDd0VGVqUHRzc2l0elRFamtFa1loVDVUZmlMMjBzWTZh?=
 =?utf-8?B?cklGVlc3N3NJdERSTEo2QmdSZU9Ka21uRXRPbUZJN0dUOUFLZDBMT1BuM0lv?=
 =?utf-8?B?bmgzMlg1bEVsL09pUnVOZWJnZUN2SEVXOTFCUDQzZ2dPWDJZQjJtTXFKZG1n?=
 =?utf-8?Q?br/bkzGMYL13hsMQARUwlM26Tfeaw3BxsR4oolz72NQl+?=
X-MS-Exchange-AntiSpam-MessageData-1: MXFuoQHTK9beJg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803add6b-f30d-4ed8-3bbd-08dea5e17432
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 11:21:27.1280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwlUC2kVbOF7ggxuz20aLtAm4nypCIJDa53PasTe8h3JAeqMXi863Jcz3FrVJksRQhGqlHGISnyZzOepVsymcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

On Tue Apr 28, 2026 at 7:09 AM JST, Danilo Krummrich wrote:
> Add a registration_data pointer to struct auxiliary_device, allowing the
> registering (parent) driver to attach private data to the device at
> registration time and retrieve it later when called back by the
> auxiliary (child) driver.
>
> By tying the data to the device's registration, Rust drivers can bind
> the lifetime of device resources to it, since the auxiliary bus
> guarantees that the parent driver remains bound while the auxiliary
> device is bound.
>
> On the Rust side, Registration<T> takes ownership of the data via
> ForeignOwnable. A TypeId is stored alongside the data for runtime type
> checking, making Device::registration_data<T>() a safe method.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

This is indeed much, much cleaner!

> ---
>  drivers/gpu/nova-core/driver.rs       |  10 +-
>  include/linux/auxiliary_bus.h         |   4 +
>  rust/kernel/auxiliary.rs              | 208 ++++++++++++++++++--------
>  samples/rust/rust_driver_auxiliary.rs |  40 +++--
>  4 files changed, 180 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 84b0e1703150..8fe484d357f6 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -32,8 +32,7 @@
>  pub(crate) struct NovaCore {
>      #[pin]
>      pub(crate) gpu: Gpu,
> -    #[pin]
> -    _reg: Devres<auxiliary::Registration>,
> +    _reg: Devres<auxiliary::Registration<()>>,
>  }
> =20
>  const BAR0_SIZE: usize =3D SZ_16M;
> @@ -96,14 +95,15 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdIn=
fo) -> impl PinInit<Self, E
> =20
>              Ok(try_pin_init!(Self {
>                  gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_re=
f())?),
> -                _reg <- auxiliary::Registration::new(
> +                _reg: auxiliary::Registration::new(
>                      pdev.as_ref(),
>                      c"nova-drm",
>                      // TODO[XARR]: Use XArray or perhaps IDA for proper =
ID allocation/recycling. For
>                      // now, use a simple atomic counter that never recyc=
les IDs.
>                      AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> -                    crate::MODULE_NAME
> -                ),
> +                    crate::MODULE_NAME,
> +                    (),
> +                )?,
>              }))
>          })
>      }
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.=
h
> index bc09b55e3682..4e1ad8ccbcdd 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -62,6 +62,9 @@
>   * @sysfs.irqs: irqs xarray contains irq indices which are used by the d=
evice,
>   * @sysfs.lock: Synchronize irq sysfs creation,
>   * @sysfs.irq_dir_exists: whether "irqs" directory exists,
> + * @registration_data_rust: private data owned by the registering (paren=
t)
> + *                          driver; valid for as long as the device is
> + *                          registered with the driver core,
>   *
>   * An auxiliary_device represents a part of its parent device's function=
ality.
>   * It is given a name that, combined with the registering drivers
> @@ -148,6 +151,7 @@ struct auxiliary_device {
>  		struct mutex lock; /* Synchronize irq sysfs creation */
>  		bool irq_dir_exists;
>  	} sysfs;
> +	void *registration_data_rust;

I'm wondering whether we could avoid introducing a Rust-only member
here, either by just allowing the aux device private data to be used in
C as well (which might be as simple as a rename, a couple helpers and a
bit more documentation), or using a wrapper type specifically for Rust
drivers:

struct rust_auxiliary_device {
	struct auxiliary_device auxdev;
	void *registration_data;
};

Although I am not sure what the implications would be for e.g. a Rust
auxiliary device spawned by a C driver? Is that even doable with the
current code anyway?

>  };
> =20
>  /**
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 93c0db1f6655..467befea8e44 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -19,12 +19,17 @@
>          to_result, //
>      },
>      prelude::*,
> -    types::Opaque,
> +    types::{
> +        ForeignOwnable,
> +        Opaque, //
> +    },
>      ThisModule, //
>  };
>  use core::{
> +    any::TypeId,
>      marker::PhantomData,
>      mem::offset_of,
> +    pin::Pin,
>      ptr::{
>          addr_of_mut,
>          NonNull, //
> @@ -257,6 +262,40 @@ pub fn parent(&self) -> &device::Device<device::Boun=
d> {
>          // SAFETY: A bound auxiliary device always has a bound parent de=
vice.
>          unsafe { parent.as_bound() }
>      }
> +
> +    /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
> +    ///
> +    /// Returns [`EINVAL`] if `T` does not match the type used by the pa=
rent driver when calling
> +    /// [`Registration::new()`].
> +    ///
> +    /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
> +    /// registered by a C driver.
> +    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
> +        // SAFETY: By the type invariant, `self.as_raw()` is a valid `st=
ruct auxiliary_device`.
> +        let ptr =3D unsafe { (*self.as_raw()).registration_data_rust };
> +        if ptr.is_null() {
> +            dev_warn!(
> +                self.as_ref(),
> +                "No registration data set; parent is not a Rust driver.\=
n"
> +            );
> +            return Err(ENOENT);
> +        }
> +
> +        // SAFETY: `ptr` is non-null and was set via `into_foreign()` in=
 `Registration::new()`;
> +        // `RegistrationData` is `#[repr(C)]` with `type_id` at offset 0=
, so reading a `TypeId`
> +        // at the start of the allocation is valid regardless of `T`.
> +        let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
> +        if type_id !=3D TypeId::of::<T>() {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: The `TypeId` check above confirms that the stored typ=
e is `T`; `ptr` remains
> +        // valid until `Registration::drop()` calls `from_foreign()`.
> +        let wrapper =3D unsafe { Pin::<KBox<RegistrationData<T>>>::borro=
w(ptr) };
> +
> +        // SAFETY: `data` is a structurally pinned field of `Registratio=
nData`.
> +        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
> +    }
>  }
> =20
>  impl Device {
> @@ -326,87 +365,132 @@ unsafe impl Send for Device {}
>  // (i.e. `Device<Normal>) are thread safe.
>  unsafe impl Sync for Device {}
> =20
> +/// Wrapper that stores a [`TypeId`] alongside the registration data for=
 runtime type checking.
> +#[repr(C)]
> +#[pin_data]
> +struct RegistrationData<T> {
> +    type_id: TypeId,
> +    #[pin]
> +    data: T,
> +}
> +
>  /// The registration of an auxiliary device.
>  ///
>  /// This type represents the registration of a [`struct auxiliary_device=
`]. When its parent device
>  /// is unbound, the corresponding auxiliary device will be unregistered =
from the system.
>  ///
> +/// The type parameter `T` is the type of the registration data owned by=
 the registering (parent)
> +/// driver. It can be accessed by the auxiliary driver through
> +/// [`Device::registration_data()`].
> +///
>  /// # Invariants
>  ///
> -/// `self.0` always holds a valid pointer to an initialized and register=
ed
> -/// [`struct auxiliary_device`].
> -pub struct Registration(NonNull<bindings::auxiliary_device>);
> -
> -impl Registration {
> -    /// Create and register a new auxiliary device.
> -    pub fn new<'a>(
> -        parent: &'a device::Device<device::Bound>,
> -        name: &'a CStr,
> +/// `self.adev` always holds a valid pointer to an initialized and regis=
tered
> +/// [`struct auxiliary_device`], and `registration_data` points to a val=
id

There is no `registration_data` member in this struct, it this referring
to something else?
