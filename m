Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45D1CD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 06:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D5D10E493;
	Tue, 26 May 2026 06:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJDav4js";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012017.outbound.protection.outlook.com
 [40.107.200.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CCA10E493
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myjtc4ZqgFjedB4wj5Ws87fwpPLSLQ4aqSthRzp+Px8KsLrD/5ivFvfzER4uMIOc2+7f4NeplmQ7zceCx5rdkS+uBF2yCSYVYgcb6cAjwpQu/AzWWhLTwkWJRzkO+mIP3wPj5vzrgkmQFRU10JDT0hpv0380nDgIbn+WH/T5yA2Nu8aMG2Htvcm9M7APvOVJy8mJJCY0uW0CPHu5Ayd0lR5OHULiAXIvx+wNeblX6tKNP9xyyytq6CQAOt96oGgQUdLMa9B+dniMGMPEnPSaCa3p7E6sU/bYKxXXdEk7b1lYCVhadppHrKcFkEJlWRr4imPR6cnzGvvSIFdhiTVN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAIi9u6pzYBzdlXWat6IlWrfo0xvZm/SRDOdc59gUAg=;
 b=aRl9MDRgkmSihx73Xml9cfdE6433lvgfyz7iCQNx2vQ9/DjUiVVZbhnD8LjvC8Hm7Y9VEvc2W2BpvLBta8VguReVHkj852r6Tz7m/ZkU7IscxItP8e+q4ib1R66ulYqduCirre9JZ/cUXteeDtLwN/9Mh8YqBFzFkWxfSsqX4AEueAdg65mtirpbqWr9lAsJea16dLXu/o8/BGyfQJWkpO38vJqA67zJKPJPqs3ryHPWv9CQQPfUFvqESHDy5okWDgRciP2+iqPEH13SDuupPrHgfRwDzz7mIv0ZTyu5cPCNaPdm56HxhUN0Fs7p3bvP7bgXS5ERR4nagqNQeW3U/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAIi9u6pzYBzdlXWat6IlWrfo0xvZm/SRDOdc59gUAg=;
 b=HJDav4jsrlTUk4jgROUvlOGFTiH6XXqv4MmSsGAU4/0ceUC82fSEdvvWRrvSZy4rCAowWi6LqTvHdN/BaAZWhv3H0ULXNwUHIiHOmfiBXhLv367QccF+yz6xcHSNsXirfb8xsdAvZH7JAQmJgblHp0fMvPFlnw5qW5Jj4XOydO1aFHVuZgmx0g3KyxlVzEjtoQdpfU/nr48Koha5fbpARGDiG2Xwb918rXbITj9/0Q2sHyHnqfxHPiSnSvGrrOofuzvOtyFE1kxp6DZfB7XWh1mMX9sX2cS8+rECDCtNQGfCU2t6Gn0hCVfoRjF8lWhs3Up6SS4X1Zvc5bJTrFEs5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by DS4PR12MB999078.namprd12.prod.outlook.com (2603:10b6:8:2fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 26 May
 2026 06:17:55 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf%7]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 06:17:55 +0000
Date: Tue, 26 May 2026 16:17:49 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
 daniel.almeida@collabora.com, acourbot@nvidia.com, ecourtney@nvidia.com, 
 deborah.brouwer@collabora.com, lyude@redhat.com, ojeda@kernel.org,
 boqun@kernel.org, 
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
 a.hindborg@kernel.org, tmgross@umich.edu, driver-core@lists.linux.dev, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/6] rust: drm: Add UnbindGuard for drm_dev_enter/exit
 critical sections
Message-ID: <ahU6HgCsXWxHlH3L@nvdebian.thelocal>
References: <20260506221027.858481-1-dakr@kernel.org>
 <20260506221027.858481-3-dakr@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506221027.858481-3-dakr@kernel.org>
X-ClientProxiedBy: SY5PR01CA0037.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::8) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|DS4PR12MB999078:EE_
X-MS-Office365-Filtering-Correlation-Id: 3132056c-6c72-4d0a-7007-08debaee8621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|11063799006|6133799003|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: dja0xiHmPFM8X4ILvfB01vWLyV+j4ObZYt/KZld2ICiPhQuvsbky75Su61DFjaXIzcviTBMWDJfnckDBonRc7lUr8yllrROvvQ4aq20on4fwk+Vp0NlQOqYpkJceC1xme4/vMtljRSzgD0HtFuPNDYiwPTA9gJcbYtoL5OXspT89SDlV3N3gVleLOHQt1QticX0IOAov4TlkGEhvt8tp15QcvJJxKLigO4Ey2AG5Ag8bTj/vrjMsgEakvFKZGcRtfyQDDCFLzl+lJjsGR7RG/Rdd7Ye1vj5SOGeEEYSPXu4sgG9ugkrCT9x3seWK/XJFUS9aLyyLBC++ehlu3jQLX1eA7BksfwMYkHKEEtntxbZhMBdOLEjMZAje3jvy6nn4uFxeyifo7Mz6YBx2kZ1jqQ7hpboU7TZpE+Q8/QBNZdXfAY8bVBgMYixIUeOK9SyaCMOnKlZ9HtcMNa3xMtfOao3s6NW41aAFMSxgnXSX5eWL4bFCtxrgyjpvZby489WT1c/ecQX29QDnZOdY+bihJHfchZ+OaGbjhY5fohkTh1/w+ShCPdU0UxKZWaTMfDL81dN1ddPbbC9JN9Xcb5OYbFr6TtDYcO9Jj6nHmWfpflTXXI3jPmqoo3c+2LS2SNBXKUkuwzNuglImQlNeRuZpDMZE8gZpuVQhm9ShrMX2Un98Ds2uqES39tvfQkJAPTT4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7705.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(6133799003)(22082099003)(56012099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXQQM2MMnM39LHlywaASWAOv825ydX4pb2QeVhaPIwYQAGpVlMujser3d96K?=
 =?us-ascii?Q?C94CDkBHnyYyWvgpMgUHh5KMvZOGkOa/79+HsayRcFyfzFAZ7RRjcSzbc90x?=
 =?us-ascii?Q?IRC78qF8NIrMXLpCbEY93iv8NFjxEeR0VPErOQBdfQuCX2jBm2ChB5n6o1ma?=
 =?us-ascii?Q?TOX0BhHLR/EbbJLhVevJCBGrVSBhLE6ap35GMct18QcrFElAjlIsi+dAr4vT?=
 =?us-ascii?Q?lekDJnr5cI7Pq4seF3o1mkZHZ7Bc0y4LjUfzmd9UR8HpQwWD/qINkXIgsQb8?=
 =?us-ascii?Q?4DaQrgPhUv3JRiJXD189TJ2AXm1xSv9smSKF+weIu7xMIhRJCCeIngvXjJtn?=
 =?us-ascii?Q?gyo+VClzWz3kZ5Oddc+7R4geKBBSZpFJ6H025/0H3bgArjKWAUgZqA/XXjni?=
 =?us-ascii?Q?UDO+a7B1UEdjlYGRJuYzJ2mAGi0Pdl/uhfgH34rxk/smBO0zmJ0pgM34wWcq?=
 =?us-ascii?Q?Q+q1rQP/G/fK0yDKCAI/usNxYL7HCLgTWci6+tidIgnPrL1fHM8GwQia886a?=
 =?us-ascii?Q?j/+UlSghd/g8xyfq9xOIZtbgeUTCmGGuZviphNCvGdLX0DyDvugz3MYwQDq6?=
 =?us-ascii?Q?3OX3LT2PNnRtPPSKTF6Hq8ZQNlP9K6N//CfRjX2iJ06eAKWlLN4CyBVg98vd?=
 =?us-ascii?Q?1ICLTP61vDqytMo699T4HQcWH7N9ymjd/POmmJp1gorRAErzmUM78AKNUZdm?=
 =?us-ascii?Q?ruYis7+L99FLwp+oPwXlGzs4DmDRf0p0J5+pblEt1HmF8HDKBNa68jpLUXpO?=
 =?us-ascii?Q?GEJD8eW/qCvMyv99LoU3tauUwYpjzZLZXYJtLwYr6l9a0tt7VqcI0gG8xhhR?=
 =?us-ascii?Q?6tBAPl/YBNlW6//2CgrkagtoNDFdoeI1frKIrx6NKiwj1gXFg7intnvpax5l?=
 =?us-ascii?Q?h0H9fc87GWcD4/G7DOp2WNrQg1sERy/gbNhYyy+i4tY2cCxobohme1luAFnk?=
 =?us-ascii?Q?wuLYySqO8kuoSs8G8BVOpqwmaLoWSRe6X283usTkUBb9yq68jdxbwXnAMXfo?=
 =?us-ascii?Q?VTw3/6AMe63IdilJ6BQ3OKoiZxcKc+xv+Z6dsSFTDRzf5cFREu50Vc2qPAn/?=
 =?us-ascii?Q?Fj06+uH+QljFxqPaW6xllV37G2BzPgoJgfYItCXMAdKI5U04cNLDjdRYHToz?=
 =?us-ascii?Q?+1Yb10l0XFhu0pItkuHt25+Ovkxi6oQP0L5U4FJLPK3mzC0rVpP+7zqI2RSN?=
 =?us-ascii?Q?actYxhK7I7XTPt+8XPwC6I37VmoUW3vM3TcPhDEg4qrVgHDF9zNWe+bIcgj5?=
 =?us-ascii?Q?tEE0x4x8G43cjbc3zPn1u3+xUAmAjdz2olRL4+ucWliuHWAgcHOMdBcSA0wj?=
 =?us-ascii?Q?46xrZCTiVwCuir5vrE1YrV3tudRqNzxN7dvbHs0EeOwU4UiR/urOri1ZQ0rU?=
 =?us-ascii?Q?Tzj6yds/VR4qlDc28WilayEobhm1v9lXUhp6bzzHPVGtCuK/GpfSk0UorKui?=
 =?us-ascii?Q?OfMP1TERffTv98JrWImPcXA3XtvuwmHLuyh8N39RgoXbkOQV11IYLXHfJTVA?=
 =?us-ascii?Q?G3sWAP0pYEQfDh5BQHnf+mN+Zi9rcjbGv225ZPrkuzaeZe9yNh1RE2hglAkF?=
 =?us-ascii?Q?px5Q7EI2+3958ipKNOVRBItYV7ojbQmcGp0383PhUwo0WtcgCbT/fQbUqh+t?=
 =?us-ascii?Q?As0C0G4G/FWPEAFSNrhUdCQR7P828uA4a4XGPcIh8FlKz2pqe4zUYex3FQ60?=
 =?us-ascii?Q?XQ1+zdFLLNx8nsU5s7rtiIsnGY2jEAPzpA4OfvW8Nps/Mqo/fMqAJ8tRWQSa?=
 =?us-ascii?Q?SGE+6/WjlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3132056c-6c72-4d0a-7007-08debaee8621
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:17:55.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25BmKkpn6PlDDZcnJ2ASJpIhztsee2tJuqOubc8ZoLM9+9cs/9JEZ3rYbPBG0I4m86LIgDBy/XB1cST015ojMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999078
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

On 2026-05-07 at 08:06 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
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

I don't (yet) claim to be a Rust-for-Linux expert but reading through this made
sense to me and it's been useful for some Nova development so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

for whatever that is worth :-)

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
>  
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
> @@ -334,6 +338,80 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
>      }
>  }
>  
> +impl<T: drm::Driver> Device<T, Registered> {
> +    /// Guard against the parent bus device being unbound.
> +    ///
> +    /// Returns an [`UnbindGuard`] if the device has not been unplugged, [`None`] otherwise.
> +    ///
> +    /// The returned guard dereferences to the parent bus device in the [`device::Bound`] context
> +    /// (see [`Driver::ParentDevice`](drm::Driver::ParentDevice)).
> +    /// Between `drm_dev_enter()` and `drm_dev_exit()` the parent device is guaranteed to be bound.
> +    #[must_use]
> +    pub fn unbind_guard(&self) -> Option<UnbindGuard<'_, T>> {
> +        let mut idx: i32 = 0;
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct drm_device` by the type
> +        // invariants of `Device<T, Registered>`.
> +        if unsafe { bindings::drm_dev_enter(self.as_raw(), &mut idx) } {
> +            Some(UnbindGuard { dev: self, idx })
> +        } else {
> +            None
> +        }
> +    }
> +
> +    /// Execute a closure while the parent bus device is guaranteed to be bound.
> +    ///
> +    /// Acquires the [`UnbindGuard`] and, if the device has not been unplugged, calls `f` with the
> +    /// parent bus device. Returns `None` if the device has been unplugged.
> +    pub fn with_unbind_guard<R>(
> +        &self,
> +        f: impl FnOnce(&T::ParentDevice<device::Bound>) -> R,
> +    ) -> Option<R> {
> +        let guard = self.unbind_guard()?;
> +        Some(f(&guard))
> +    }
> +}
> +
> +/// A guard preventing the parent bus device from being unbound.
> +///
> +/// The guard dereferences to [`Driver::ParentDevice<Bound>`](drm::Driver::ParentDevice), providing
> +/// access to the parent bus device with the guarantee that it is bound for the entire duration of
> +/// the critical section.
> +///
> +/// Internally this is backed by a `drm_dev_enter()` / `drm_dev_exit()` SRCU critical section.
> +///
> +/// See [`Device::unbind_guard`] for details on the safety argument.
> +///
> +/// # Invariants
> +///
> +/// - `idx` is the SRCU read lock index returned by a successful `drm_dev_enter()` call.
> +/// - The parent bus device of `dev` is bound for the lifetime of this guard.
> +#[must_use]
> +pub struct UnbindGuard<'a, T: drm::Driver> {
> +    dev: &'a Device<T, Registered>,
> +    idx: i32,
> +}
> +
> +impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
> +    type Target = T::ParentDevice<device::Bound>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY:
> +        // - The parent `struct device` is embedded in a `T::ParentDevice`, as guaranteed by
> +        //   `UnregisteredDevice::new` taking a `&T::ParentDevice<device::Bound>`.
> +        // - By the type invariants of `UnbindGuard`, the parent device is bound for the lifetime
> +        //   of this guard.
> +        unsafe { T::ParentDevice::from_device(self.dev.as_ref().as_bound()) }
> +    }
> +}
> +
> +impl<T: drm::Driver> Drop for UnbindGuard<'_, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.idx` was returned by a successful `drm_dev_enter()` call, as guaranteed
> +        // by the type invariants of `UnbindGuard`.
> +        unsafe { bindings::drm_dev_exit(self.idx) };
> +    }
> +}
> +
>  impl<T: drm::Driver, C: DeviceContext> Deref for Device<T, C> {
>      type Target = T::Data;
>  
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 9d06f8c5b2da..751a68bb27e1 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -187,8 +187,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
>  
>  impl<T: Driver> Drop for Registration<T> {
>      fn drop(&mut self) {
> +        // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensure that existing
> +        // `drm_dev_enter()` critical sections complete before unregistration proceeds. This
> +        // is required for the safety of `UnbindGuard`, which relies on the SRCU barrier in
> +        // `drm_dev_unplug()` to guarantee that the parent device is still bound within the
> +        // critical section.
> +        //
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
> -        // `Registration` also guarantees the this `drm::Device` is actually registered.
> -        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> +        // `Registration` also guarantees that this `drm::Device` is actually registered.
> +        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
>      }
>  }
> -- 
> 2.54.0
> 
