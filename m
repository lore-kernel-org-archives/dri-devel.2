Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29184C61DBE
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513F510E124;
	Thu, 27 Aug 2026 00:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOLEemFy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3D510E124
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 00:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MioIPVx5sMsT+LWNKXsPjqeQEkENmI93tHdqDqKoc5fNTREtijFoVeWwOpaZMGoTnIXivL4vf3Q+Hp9+QUQTeS4tPKoxOnP2XlLX0G9nizyk2dbilOsm8O3RsEDuodoWd/MQr2lyTqe0P28d6pEp9CCUBlJpaL33fA4Wq3Wil1gN5MdVTcyv61LxzQuxFmojqsbYyPepJ4ExOhKEqjQbz79+7rPAhw1Tfv7F6UWHB8biDvsl6JHltetCt8BhWWl67RaxTQi1DPi0WJ8D2kgJv0hhTCH3d9MxKokofSDHvmYC3LNi+po+K8s8DeV1WYiHm5uQg+eN54OGeaG7xstzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN3mt2w3egd9vQ1O7U7pDdnGu453OBb+4tgEr1dECfs=;
 b=iP5UZKwRjnEFEfTj2dntubu5O3gzFuEU/2S5KNhKPXEBKELE+5to+kvp4EZEqiXYd6BvoRQTnqHPixPVA3plje+hslDVahpOknkjclTrCSbKyeV0XdGO3dvxtxEpOuTu0OCcre5fOfMLecjNtKwI0UgY+A4G9wc9QE063oUGkNrw/ur2Omia33lbG4JaGpwSnJJtloqEnWjkUUoPpNCNXIg/kcjUnKPYITyr5reNrKSP0vEdxH2yDql0MJoa5TLGC65zwNjkxE9a7kb5FgnZ990JxMKb7U7E8zgsvbLEJSnuQQCKEmHgti4pPvfYBXe/+wdiHuIghmRtiOQAHeKa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN3mt2w3egd9vQ1O7U7pDdnGu453OBb+4tgEr1dECfs=;
 b=cOLEemFyrNv3tD9+n3XbG7Bwb6gpzEpfaa8motuciBRNJkBVneWKtMAsdaCPBAy29cR1Qh5P5s1pJYBBt0OX0EqaE4YGX1TEKI7p5qsDuLhZIS7A2TwiCPOvcdJXfC2jSf0KRCNyvWwxoLmXl0HSq0aTDi6OpeUtjPwJDHGcL8Te/zwiJKWxKMTiwKWAhUKNPQMLGj4sOCZCVgK5M3qpvKyfZf63gyQgXUb+O2DtPayqZPYWW98/re66+owbBTMbsxRiFVpGdhTWvjmPs9vB509akGSp+RT/wwYc7ZwHfkjKtEL/XFC5xwdUOmtI76VWLvl1kyx7U2jskhkY1As2DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 27 Aug
 2026 00:03:56 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 00:03:56 +0000
Date: Thu, 27 Aug 2026 10:03:50 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
Message-ID: <ao6gDTdk49aoSRhh@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
 <DKRHW6G6P4K5.15H1A4DGR6672@kernel.org>
 <aofWfMSZtV-bNYrr@nvdebian.thelocal>
 <DKXETHVKYVV4.1P8RNJ6AXV3X8@kernel.org>
 <ao1AnG7fUhJ8a1U-@nvdebian.thelocal>
 <DKYDUOFB4C8P.3STNQMZY571XI@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKYDUOFB4C8P.3STNQMZY571XI@kernel.org>
X-ClientProxiedBy: SY8P282CA0002.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::9) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b73a52-cae5-4076-b4b4-08df03ceafdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|10067099003|4143699003|56012099006|22082099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: O1K+y0ISqu/5HBSeX7PBL4t8hER70I9EVdFSdzo/bGNFtCcnqOGRMjKDG90x8ouBtekufo6UkXUdYWQar1sXyMfxghJROokKgmfOR3gnq9WHjhSH/MKIBB136tpal8KRwjWbewNOPGvSrvdZnQIOqYpzg+oIbA+Jyd0jaIxfSEJEIGDi+UwRvYgQ6QvueoIO1vvCHN4VrBGJWGz2YUwmsrEP4SMCWDVlaK7cW9df+FCwgxHad80/KCu2haEbkdgBxPntsdyCbUPdEtPxnq3GiXp90BZ6oEKmN/xxQ9Sds6vCh8NkhZ/4Uan/87LZ1BtIx1U2GZce1Stx+nm1XfKOFEr6Ezbr9WFAajLgsiFdm8fgtgD+G1qE+Tl/etmtAp6ukz4LfnDsO5n95lmLfLwIinNEkHrCbs1Mxg+YFyVBXzLD5OgzuKLmKqBHkQL6Qr+4Pxtp6vqlW/1EBIUXqW9hCESNPsDcdHLF5fB+O5ttPNfsWKtikCYHY4n2wgyXY3/7/o6xFZDSib1b/XBgFfjbQME6Jxc7eqg3TgVAJJd7ENYmfh4meCBFVInWAmGQo6B/3uF3WADw0y5/RDAEgC/IgMSlQKk8vAA7odYx4kMz3VDEef+sbMGwktJlAjpx7rFCaHa7T79ZZaP9TvLfefcBUEFCmakvW8kJywR/tzGIPck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(10067099003)(4143699003)(56012099006)(22082099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1G/lLGTdJ7PN+gFKBZ8s50u87sq2lIQlv93rK4XD79r9goCSp7wPN/V7C7l4?=
 =?us-ascii?Q?Ab4yJFHqeDR/QjneoSyr/14EUVqkpnuCSKouUEe2KzoyI5Y82FTP5CbEH5fj?=
 =?us-ascii?Q?D+ueuSovhpI6/R2Im8vKgI/sIvTUSEhr9NNg6A7awpxA0KqGnFhrsy7sFe/s?=
 =?us-ascii?Q?TdNL6a4x7WQPNcP90oJ9fgU/eCw4JB2ypB0I1WYWz3uWreDj6Ej8DIdoKqfT?=
 =?us-ascii?Q?Wqp1yfJNLlBq+0VicZwSJcAeCq88AFnakMIx85EZKCj8Tt0OUjp8sp8DtLBi?=
 =?us-ascii?Q?j9XcXa6mVrweHO/yp0/Edg+wBZiag3OkOdDui7QGwmyi7oVYz/YGNUGh5Ytl?=
 =?us-ascii?Q?ZasrLDRLkD0GSIbsPmzzQsN/NuydPnYFAOHICuP1/W38OJcASdvNo+me8xsK?=
 =?us-ascii?Q?JCI0bZagotX6nDgBER55UWUWOgJvAqMmrjJs6d4vm0XiJ4voXKHwP1LkEAza?=
 =?us-ascii?Q?oSM7ck7hEiItD8WR8MDI4Ej5QR0VMku4cZvr4/Y7CZII9NE+Hnob4xjONUZU?=
 =?us-ascii?Q?Uejk8QONVetBEevV3CQoZBXxUKhsCPQHE6v+TSHoLIGel+wz9nknqTo9xhZh?=
 =?us-ascii?Q?ddY/9w3FtunMkpb686PnvNIXQY8q9JI1Wz/qwln5mcXYRS7UpdItBhylHWaQ?=
 =?us-ascii?Q?cDipYfFfDhIK9hR63kUexSijJNcDjF1C5VO86UBY913VSk6TsWgi3+Xb36QX?=
 =?us-ascii?Q?MmR0CZ6l91PfjIgrHUj0tBwYlOiELTiNqm37ygTx+VXsC7szJ4fi6ZCGShCj?=
 =?us-ascii?Q?Fnvhx5nftHFpdEE4y+6UDsZkeLhsHPelrDeCZwHXfhlTDWfRv98slW8he560?=
 =?us-ascii?Q?IPtqjq/E0GpYz73d+PXitvs8cR+HT5hjFnpTcX74ylF1CMfpau95NAJg2TlF?=
 =?us-ascii?Q?8692DEtcHFoLy8r+IFyhpgbUTizZC3PRNATncjsPpH+FchPzX2gT1mMdCg8b?=
 =?us-ascii?Q?0K/FLTk3WCn/bJk4YzcLKDgQtxoNEOR2Bf+KD7nqr1FYMhPXMfmCs1vANidQ?=
 =?us-ascii?Q?yI5SPRpqhWxmLIPNTkQKNfoiySLClOvyXDunfCwkoLLRB0qZBna/xRN9cXjq?=
 =?us-ascii?Q?dC//XjrMYNI+ym0a7kY/usK6UdwD6dXpJdMoqw2a6tL4apYtdvFpL5H1qYhl?=
 =?us-ascii?Q?kvQIGRTm1Vmjr3+kVM2eUO1btLbDvi14J2JsghfZmdE085UNvhzRQxy8P6wZ?=
 =?us-ascii?Q?zIylJ1HaFqksJ/QzmpgGqqlqWl5ketmPjOucCn79cyyHaEDM9e9uammv/2ZD?=
 =?us-ascii?Q?VNjN/Rn6fdNtnXQGUCb5bkENzDf0uxCD4WgxdQSZEh0pg/8U0jRZcI4u6eaF?=
 =?us-ascii?Q?RE37GWtNdDPG8yDAv1Xqd4IF0lXEpDiRnpkgvxsQWPh8LaTWRoBcpu7Skaos?=
 =?us-ascii?Q?BO8MiIeEBgibqz2Ei3AyBdYkbXtvcYo6Yw66xABq/C6N0fGzgXbsk0i/7MUE?=
 =?us-ascii?Q?OFEX4pkgVBUeSmfkuE0AzKrHfeyZ68S4otSePDLtJyH8+SnwhiuRgvctZq3+?=
 =?us-ascii?Q?dxPnD7B5jAfUK0LVaX0/L0MHzF/slqQe1MeWHVhA9BIiWeYXqQHokS+ScXvX?=
 =?us-ascii?Q?TtBqPZZxcEwJZJLkc6VCMij8vp5pLD9ajSesXkrIzsZc6yXYelyXgpNQLoqB?=
 =?us-ascii?Q?atFVbW4fzt/osID+IZhjBOAhH5+ynqMnVLLJjzUU0fMOWYSMoZKsRYqGNf9/?=
 =?us-ascii?Q?PansAxNP9HoQqtkBvPRdkGwFNqq7liRceiQqrM3qy8p1BvIqiezgxsLodXOR?=
 =?us-ascii?Q?pIt+vL8Hfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b73a52-cae5-4076-b4b4-08df03ceafdf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:03:55.9989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HC/Z1RXBPh724bO90qA2JJHQ4BYY3Aau+zwdPWTBpge7kvImarIaLTpMFM874A9R98XeZ85WPbEcgZfS5loAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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

On 2026-08-26 at 08:37 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Tue Aug 25, 2026 at 9:32 AM CEST, Alistair Popple wrote:
> > On 2026-08-25 at 05:10 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> >> I don't think we are really concerned about running out of ioctls, but it seems
> >> cleaner and more self-contained than having N ioctls for different info structs
> >> and in the worst case having v2...vN info ioctls.
> >
> > But isn't v2...vN info ioctls dealt with in the usual way by extending the
> > existing struct and bumping the size? That seems like a pretty clean and
> > self-contained API to me.
> 
> To be clear, my main point is that having a single info ioctl with different
> info types is more self-contained and provides more flexibility to introduce new
> info types whenever we think it is warranted. Long term I expect it to be the
> cleaner API.
> 
> >> It also allows us to define a new info type struct whenever we think something
> >> is a new logical info group. Making it per ioctl will always raise the question
> >> of "do we really need a new ioctl for this, can't we just fit it in X", which
> >> over time tends to get messy.
> >
> > Doesn't that question also apply to adding GETPARAM N+1 though? If we're not
> > worried about running out of top-level ioctls I don't understand why they
> > are considered special enough to warrant the extra complexity of creating and
> > decoding a hiearchy of sub-ioctls.
> 
> I think the code would be rather trivial:

Yeah, I agree it's nothing too complicated. It is still more code though, and
therefore more code for people to grok and more code for every userspace user
to implement (not always in Rust!) rather than relying on existing code. And it
does add another layer of semantics to understand, even if they are similar, so
in that sense I regard it as more complex.

But it seems unlikely further discussion will change much here and I'd like to
get this merged soon. Obviously you consider this worthwhile so I'll just go
ahead with this approach for v5.

> 
> 	fn write_info<T: AsBytes>(info: &mut uapi::drm_nova_info, value: &T) -> Result {
> 	    let len = size_of_val(value).min(info.size);
> 	    let uptr = UserPtr::from_addr(info.data);
> 	    let mut writer = UserSlice::new(uptr, len).writer();
> 
> 	    // Note: I made this up, as I think we want to add this method to
> 	    // `UserSliceWriter`, to avoid having to call `as_bytes()`.
> 	    writer.write_truncated(&value)?;
> 	    info.size = len;
> 
> 	    Ok(())
> 	}
> 
> 	match info.id {
> 	    uapi::DRM_NOVA_INFO_GPU => write_info(info, &uapi::drm_nova_gpu_info { ... })?,
> 	    uapi::DRM_NOVA_INFO_MEM => write_info(info, &uapi::drm_nova_mem_info { ... })?,
> 	    _ => return Err(EINVAL),
> 	}
> 
> Honestly, I think this is even less complicated that adding a new ioctl for a
> new info struct.
> 
> And on the userspace side:
> 
> 	fn query_info<T: Default>(fd: &DrmDevice, id: DrmNovaInfoId) -> Result<T> {
> 	    let mut value = T::default();
> 	    let mut info = drm_nova_info {
> 	        id: id.as_raw(),
> 	        size: size_of::<T>(),
> 	        data: ptr::from_mut(&mut value) as u64,
> 	    };
> 
> 	    fd.ioctl(DRM_IOCTL_NOVA_INFO, &mut info)?;
> 	    Ok(value)
> 	}
> 
> 	let gpu_info: drm_nova_gpu_info = query_info(&dev, DRM_NOVA_INFO_GPU)?;
> 	let mem_info: drm_nova_mem_info = query_info(&dev, DRM_NOVA_INFO_MEM)?;
> 
> (I pushed a few cleanups to drm-test, so this code should work.)

Thanks. I've already taken a look at drm-test, seems fairly easy to follow.

 - Alistair
