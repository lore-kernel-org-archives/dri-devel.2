Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B3CD5BDE
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 01:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379A110E044;
	Wed, 27 May 2026 01:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZbVYGNY";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B4310E044
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 01:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1ZMjYCGO61MtStugfnncuelWVaAH00bzZh3p0rq0pXxkvf7ALHgVydvZM67nf9mv+6uZCB1wcQI+tn5VDT/XtvPFIXaOYmHTwMMwk6AcgXtWPL5r/zn14cSnWd117lCqoqW7TRp5NED90RWN4UxxxMCiyABu90xDSUTlALddHVPCXpfNd1ywcSOJq/nDXLhIKIYIFcP5R5Qc95i66c9SHMzr9kzalgp13VvMHf+4F+aVj8miWpIHXSB+8gIQs/D8AlDDJ79DVn+LYeA9l2GjrzhRgRQaBduhiWEOgZGbSUu23vBl9i4gg3nqqTahvm0ROBjnzOLxuAFNIlx40JPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//mo3MB22hL8wjit5cnvdw4bM9frEzdVrgdBnUKDeuE=;
 b=anWzliGkSTVx99vKXLJfpdp350CBpd7eUYJjO7LAnWbBkSZPtl+9YpVI6ZIRpVI+ysTj8nt39/UIbhc67DbK/1tqxOoxVjAgcwYXJljdqIkdSFO3Am4T2+jwzJ9rQ5LCoE8/AuZ0S2AJRJ8h1jjSUaNhjSbqENhssd+GV5HxvPw7294swHqx1woZLy4cITTlKh0EPiLAhageywvuAPEcAdz1LIuA9GOJ7BQGaHWD/wZpKvwEYujB8N0NwHDkXHNRn+rG2METiv3EX3Vb7xr3fgqy0fkm3L/xHKSg6vtT0ZcYxQj5LfYaae+VfmblNukr4/9i6sdeB8xmov0NagmbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//mo3MB22hL8wjit5cnvdw4bM9frEzdVrgdBnUKDeuE=;
 b=DZbVYGNYMfkeMG1b6E6L1uxJ/sohpXzfN/Z0bmFpPPAWgwe3sArD8WrmOhEEd3depmDgGPBN95jkL8MMgeGeXjbvlY4V4UpKbN+aDDCOmy96PYklKpTBeJvrfad1FX1E+8o48PCaBMnXf4LfwCoohxOHjiJquHf7aVuv47Bw/iCkzjUJwPzMBpYyf+KX2ScoBFDJ6h2mL0ChiEqPUMyFzAuFXsKw+9ke4cvrRaw5Nk5tu9pYo7QpcNTcEm+br+0NaTp2UCG0n8LXSy12xAeCWQwAaGNdajVy9De8ChVdRuKIx7Z3AR/p4U4X1GrWR1bsn1T7+Tp1CSMsyLDAOxckmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.18; Wed, 27 May 2026 01:03:09 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 01:03:09 +0000
Date: Wed, 27 May 2026 11:03:03 +1000
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
Message-ID: <ahZBOXFh7rb7vxzX@nvdebian.thelocal>
References: <20260506221027.858481-1-dakr@kernel.org>
 <20260506221027.858481-3-dakr@kernel.org>
 <ahU6HgCsXWxHlH3L@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahU6HgCsXWxHlH3L@nvdebian.thelocal>
X-ClientProxiedBy: SYCP282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::28) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f17ca8-c288-4de5-17c7-08debb8bb77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099006|18002099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: gI9k0xkBZgrF9Y6rlbT2rbHq4dJp+UBsTwXQuzEDt81JfaKot0+Jgfp0eWXvFM7HUl1mGPbkj7D9j/fE1m1qBL+ogZJydIEKmcn8/f6U2gpg6ztPL4KVdJgDwgBRR3GDfZHrgVY7bVvy59oCRywTx+KBnwA70KCziYGo2PSr9AEtAiv53gyPZvhhYELlzmcjHqhvpEHAHou3SskCzUh6fOe+k63suSkb5mVST/ZSlqOez8a2Q/ovKUtXuymQ/qpHiQ/7tbiO/lXUoo66iX697ynjLG2o7zbP9N6+jdkXEzVFK/TF33FjU79IPV5Vmhy3Yaky1V9F3Vhi8dJRRExEeMgTpO8ZDmGFWia+3STW74WBZkF5vsMjuD1C8u3APB8nr0J/DmAIoNh3ZYDRbfZXCM5e2Cp5RDpw6SKwQJ5z1KI5cb2c7z7zh/URNMmI9Od7njCnaSK9ZJvZjjSlLrTJd+WhCCWzqIZprJ634son189HxOWZ56XG5dLBNjmrSzJwweSm9XDevw2vUc+Ufnd+pbtV1hX9R7gtNfJI2PtXjS4ZoCvTRTtlbJwu3nfrXngNAp+Us57ZgGjyUJbR2H/penCEbwL/F/t8GFx+9W0bnNJLTMPiHJdaHy//oAyo9Ue2HBZRrIFO5yxGgz0ApUyf4Mu1deKRmrYtPTx+HmXMUxWBasRJAxO3CfjmLscqEN7T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099006)(18002099003)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2XlLdVYs2WuGZob1j5otA82vP8R5GdTy/OAdv+CT6YV6WueAtQfmuwaMpGv?=
 =?us-ascii?Q?bkDvT8z0ihVgJ9cXt1b9B0+iTo/QL0GU8ze6n3gmOeJI+JrAWxh8qMEGhs2F?=
 =?us-ascii?Q?TCOKCtjLJF8UdjJHOPEzaCUa22mwrrbtBbgm0qHzRu+LlMHjpSgRD8G1gO50?=
 =?us-ascii?Q?25Pd8UK+XPyqnEw5XwiEnUQ02hmq+LJ4xS6sBw/tQYFAft44UN/FYjE7s4ix?=
 =?us-ascii?Q?H4AFzK1WxSRmZ+ib0yz1cFkwJ0tpFAfRYaA+uMyCv/nw7MDhNOP7QywRRy3I?=
 =?us-ascii?Q?mC4on7wXGpPDmDrfE0VU2JTsJyd/iKTo6tBuWwGLFeiyKJsi0Obey8uQSyhZ?=
 =?us-ascii?Q?BYpSSQRJoCzFU4oN0fyAJ/SMe+LcwGMAET+oOrhHIxj//6MavqG5D01oy+NV?=
 =?us-ascii?Q?ym45BsNhq9nL/iM9fXG1tvlDfZuYCfabGRpFEHxz2NYjjPheHXEjIy3C1ncO?=
 =?us-ascii?Q?jSyJiPQ9D1wyT9do3+/VfsfpCmk2Oj2xhNZjeF8ZsDN/i1a5/Hw7Rk1nf8Bk?=
 =?us-ascii?Q?VBrYf0pf9iMHYnltfLaR1+yMHi1Ts3BB3mEdhqZ3XoQlXqTiCCFdojHB/DPa?=
 =?us-ascii?Q?12/RXFs7sUkFl9o+6olUK9VFfxO3WFf0U4e01TgkFpUrEVU5eNqycdfnj3gH?=
 =?us-ascii?Q?p0Yx0phKD3X0yyHd5QVyFaDg/2nO4rjAeS/GOKQDz0VyEpLeKH9LBDiKNVpT?=
 =?us-ascii?Q?h9nzVYK4pcoFG0U7dfXKvFZaRd+KAL1oywTJiWI7MAbYYDO58MjWNPZsBkjD?=
 =?us-ascii?Q?rsX0MTDjhiz4wuh8AU4c5RSryRffkXS5Bie1yIByTkjp1OHul5Y8muM6Y4mR?=
 =?us-ascii?Q?nGhUsg5lT9NSd066l8OArIUMVqzz8VyLvmpXhl5k+99+ZyZEqMkqeuqPWZ71?=
 =?us-ascii?Q?T9u089jflokIans4s++sJbMw4AYDGqMzxA7QsoQ73SAfhDwdGp1XrriOufSK?=
 =?us-ascii?Q?35w8Y29eUzuBCuyvQq5tLnRMf4GPgvSvWjK/VoJuMGoEQe3GOBlrIMTSCTUy?=
 =?us-ascii?Q?nFFb5jjNi0CM6XMMPvMeENc5FchbzXN87RE9ros0sg3UUECIzqQdxb1NvPBw?=
 =?us-ascii?Q?F9yKSCA/daB03MMS9ya+7ujcn+XCmqmoz6E+uCE8Jo9StUaKcvDgudfeLxjV?=
 =?us-ascii?Q?awRqWsD32Oq5HU6ozbkdCUdixNL8sgFCjN1BoKZmY8Jo4xYk+rGlT9ubNoi9?=
 =?us-ascii?Q?ABB7IZ+m4+EUpNEmDniLTk+qbthF3rtVibI7g8gRzKEpCzO+rcOVi3qRp2hc?=
 =?us-ascii?Q?lFrGUY+OXV/YOujhUE2NV63fKLoNZMiOnIwzz3WEVwxoo2BlODmdycK+1GxH?=
 =?us-ascii?Q?bfp5yR9ALAsUwW/qXVNRwyG5Eb6vvchoguFRGdnU7YpnRgmKx+kEcWnSRToU?=
 =?us-ascii?Q?7LCpq9UoIYAFgeDHcywpXC9ROu4ZQlhgGLb7alenlrfKfpMLMXjUXy82Jp+H?=
 =?us-ascii?Q?MTN4k4ix9F9HqTDkcTVvTUFtEhJMh3UcM8BYQUU/MDo+zRRfzH3srDP7Wat8?=
 =?us-ascii?Q?TAqJh1YBRLwYlu2e6hnjANl1mh3yNdSw6RJttfBVMdQ5esOxkqSmLurAfDVx?=
 =?us-ascii?Q?2S2eEJwt9epviHhzv6cQsuspY7vpz93k39oihX2AyMCDFpbH8XcbfLDI3MpY?=
 =?us-ascii?Q?AxyrD6+EgkO50RWBsCcoffTerP7WytkA/peVrqCooPlKk7wV/7ytGoX9wx8o?=
 =?us-ascii?Q?e0mgc+2Os0/MwBzk+Axis512kDhGQ+2tsW50JOcWR8PJsR/CD9JLTwujt8kS?=
 =?us-ascii?Q?UgLY+A/FlQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f17ca8-c288-4de5-17c7-08debb8bb77e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:03:08.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DAvNfaxooclIeVyOfCwiihAJrJ/RYkU/I6T3StTDf+QqQKngXJOdALt9fp+X2N5aU25dYiEcwQJtuwnQPQisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

On 2026-05-26 at 16:17 +1000, Alistair Popple <apopple@nvidia.com> wrote...
> On 2026-05-07 at 08:06 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> > DRM ioctls do not guarantee that the parent bus device is still bound.
> > However, since DRM device registration is managed through Devres, using
> > drm_dev_unplug() on unregistration ensures that between drm_dev_enter()
> > and drm_dev_exit() the parent device must be bound.
> > 
> > Add UnbindGuard, a guard object representing a drm_dev_enter/exit SRCU
> > critical section that dereferences to &Device<Bound> of the parent bus
> > device. The guard is only available on Device<T, Registered>, ensuring
> > it cannot be used on unregistered devices.
> > 
> > Also add with_unbind_guard() as a convenience helper that executes a
> > closure with the bound device reference.
> > 
> > Switch Registration::drop from drm_dev_unregister() to drm_dev_unplug()
> > to provide the SRCU barrier that UnbindGuard's safety argument relies on.
> 
> I don't (yet) claim to be a Rust-for-Linux expert but reading through this made
> sense to me and it's been useful for some Nova development so feel free to add:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> 
> for whatever that is worth :-)

Which is definitely not much :) I just realised this has been replaced by a more
recent version of this series with 24 patches, so will use that instead.

 - Alistair

> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/drm/device.rs | 80 ++++++++++++++++++++++++++++++++++++++-
> >  rust/kernel/drm/driver.rs | 10 ++++-
> >  2 files changed, 87 insertions(+), 3 deletions(-)
> > 
> > diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> > index 492c2f2c7ca4..bb685165032d 100644
> > --- a/rust/kernel/drm/device.rs
> > +++ b/rust/kernel/drm/device.rs
> > @@ -6,7 +6,11 @@
> >  
> >  use crate::{
> >      alloc::allocator::Kmalloc,
> > -    bindings, device,
> > +    bindings,
> > +    device::{
> > +        self,
> > +        AsBusDevice as _, //
> > +    },
> >      drm::{
> >          self,
> >          driver::AllocImpl,
> > @@ -334,6 +338,80 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
> >      }
> >  }
> >  
> > +impl<T: drm::Driver> Device<T, Registered> {
> > +    /// Guard against the parent bus device being unbound.
> > +    ///
> > +    /// Returns an [`UnbindGuard`] if the device has not been unplugged, [`None`] otherwise.
> > +    ///
> > +    /// The returned guard dereferences to the parent bus device in the [`device::Bound`] context
> > +    /// (see [`Driver::ParentDevice`](drm::Driver::ParentDevice)).
> > +    /// Between `drm_dev_enter()` and `drm_dev_exit()` the parent device is guaranteed to be bound.
> > +    #[must_use]
> > +    pub fn unbind_guard(&self) -> Option<UnbindGuard<'_, T>> {
> > +        let mut idx: i32 = 0;
> > +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct drm_device` by the type
> > +        // invariants of `Device<T, Registered>`.
> > +        if unsafe { bindings::drm_dev_enter(self.as_raw(), &mut idx) } {
> > +            Some(UnbindGuard { dev: self, idx })
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +
> > +    /// Execute a closure while the parent bus device is guaranteed to be bound.
> > +    ///
> > +    /// Acquires the [`UnbindGuard`] and, if the device has not been unplugged, calls `f` with the
> > +    /// parent bus device. Returns `None` if the device has been unplugged.
> > +    pub fn with_unbind_guard<R>(
> > +        &self,
> > +        f: impl FnOnce(&T::ParentDevice<device::Bound>) -> R,
> > +    ) -> Option<R> {
> > +        let guard = self.unbind_guard()?;
> > +        Some(f(&guard))
> > +    }
> > +}
> > +
> > +/// A guard preventing the parent bus device from being unbound.
> > +///
> > +/// The guard dereferences to [`Driver::ParentDevice<Bound>`](drm::Driver::ParentDevice), providing
> > +/// access to the parent bus device with the guarantee that it is bound for the entire duration of
> > +/// the critical section.
> > +///
> > +/// Internally this is backed by a `drm_dev_enter()` / `drm_dev_exit()` SRCU critical section.
> > +///
> > +/// See [`Device::unbind_guard`] for details on the safety argument.
> > +///
> > +/// # Invariants
> > +///
> > +/// - `idx` is the SRCU read lock index returned by a successful `drm_dev_enter()` call.
> > +/// - The parent bus device of `dev` is bound for the lifetime of this guard.
> > +#[must_use]
> > +pub struct UnbindGuard<'a, T: drm::Driver> {
> > +    dev: &'a Device<T, Registered>,
> > +    idx: i32,
> > +}
> > +
> > +impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
> > +    type Target = T::ParentDevice<device::Bound>;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY:
> > +        // - The parent `struct device` is embedded in a `T::ParentDevice`, as guaranteed by
> > +        //   `UnregisteredDevice::new` taking a `&T::ParentDevice<device::Bound>`.
> > +        // - By the type invariants of `UnbindGuard`, the parent device is bound for the lifetime
> > +        //   of this guard.
> > +        unsafe { T::ParentDevice::from_device(self.dev.as_ref().as_bound()) }
> > +    }
> > +}
> > +
> > +impl<T: drm::Driver> Drop for UnbindGuard<'_, T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: `self.idx` was returned by a successful `drm_dev_enter()` call, as guaranteed
> > +        // by the type invariants of `UnbindGuard`.
> > +        unsafe { bindings::drm_dev_exit(self.idx) };
> > +    }
> > +}
> > +
> >  impl<T: drm::Driver, C: DeviceContext> Deref for Device<T, C> {
> >      type Target = T::Data;
> >  
> > diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> > index 9d06f8c5b2da..751a68bb27e1 100644
> > --- a/rust/kernel/drm/driver.rs
> > +++ b/rust/kernel/drm/driver.rs
> > @@ -187,8 +187,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
> >  
> >  impl<T: Driver> Drop for Registration<T> {
> >      fn drop(&mut self) {
> > +        // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensure that existing
> > +        // `drm_dev_enter()` critical sections complete before unregistration proceeds. This
> > +        // is required for the safety of `UnbindGuard`, which relies on the SRCU barrier in
> > +        // `drm_dev_unplug()` to guarantee that the parent device is still bound within the
> > +        // critical section.
> > +        //
> >          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
> > -        // `Registration` also guarantees the this `drm::Device` is actually registered.
> > -        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> > +        // `Registration` also guarantees that this `drm::Device` is actually registered.
> > +        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
> >      }
> >  }
> > -- 
> > 2.54.0
> > 
