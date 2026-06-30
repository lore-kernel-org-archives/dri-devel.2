Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C783FC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37EE510E226;
	Tue, 30 Jun 2026 14:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C1ShaU4F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB7210E1F9;
 Tue, 30 Jun 2026 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782829593; x=1814365593;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LP8bVgJMJP8Jdoc6NCdL4rcL7SP+Z2zcrPi5adwit6k=;
 b=C1ShaU4F9WFMXlWrov1fzfCPoAH91e03lhY8dQh6kfJVwXnAA4fsyEeU
 aVEmsozOhgbu1l264yM4VgyoAAYtXDuty4zzCuWEOFAPTbwz4GgQJR/JM
 2FhnG/uNk11vPuJIY6xcD3Zo5TuEvo6I/XWVseH1RwVvG5JCvGO5E7ctI
 3uOI5jZXmS1xpanw/ok3jE8fDLYmXpChdRW7Lznr2gz1cO4whg6r45IsI
 dENL+5XIN2F1TV4n5YOWSeqLPfvJXCxXFZehz4IAqvT2kA6WUt+uIrxRq
 e48TDeW02nRdjjX+c0hpV96E/raKy00qsXlqAP6D4EaEpgZFmTfdc3bPp A==;
X-CSE-ConnectionGUID: c+r89lWQS/SWuNcjlE1dtA==
X-CSE-MsgGUID: Zte1aSxnQHqb6BGAa+dAXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="86093301"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="86093301"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:26:33 -0700
X-CSE-ConnectionGUID: Kks3qVaMTlG+zyY/SelUjQ==
X-CSE-MsgGUID: E2WMuwHYRjCt/HLi2NwXJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="257190551"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:26:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:26:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 07:26:32 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGv8HjdclLeeFkFnFmZTc2L5LP5h0gSRUiJEFLDLcoSRc6/mSCjkpY7mZcrGHrBuEEdiwetZSs/g3lMW1eXcHOdm4ycPMR4FzQH5L+4oCY0FK3uOsB6dsS9BXqniIrdKbeDMP/7t6DIM+W4Ay4oMjGWwJfnhy9aCjF8acStvKDlSMEJwOHYhTZ5EqLAC5UmidrXgNIvbZYxWewCpSHJ6jgHBu3z72RmFg1JKStLYAIfO6ssY9bW2kFRf2VnooQWmK4FEUXDEj/KnceY1IJFQpkZHL0Iv3QynctUV9P2HoimaetnOmugYU4O5FVPyCqX0b4Rjy1O9fxH17PaDvi7m2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAW+3QoZonaN9zfBCAI1iromY9Ya4D+GNXUgR/bcilY=;
 b=B10yLDZTwO5uyf2mM5rf5VasZdhqQtn7F3Z4wEMeLODWdGDFqIe+7eu6w7y7crFczPsTDJVKSxsuNSiIFbTRMxUI8x4CLFfVnmCk0lrkLUCbby3YRPV+HoWiWQ5jJxXqxSr45vMilK1XjGUGtnmAQC2g/U8gEJ8wnh9GZKGnEY9Rd5IzXxYiHzG/ElReGs3DwmGZymUJj+YIPCPXNL8uIofeoJpVqyGNMruJhVJEPG5ToTEg87znyTM2GfSE2r4L30jfKlsb0pKBzycfsAcm/A/TlURIzgIeXH3qBl42mb7cSJztYJm1KClH3pZRmFRVlyOvjL7ndU6Llb8WdMKopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS4PPFE99BD3AEE.namprd11.prod.outlook.com (2603:10b6:f:fc02::5d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 14:26:28 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:26:27 +0000
Date: Tue, 30 Jun 2026 07:26:24 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v10 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Message-ID: <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
References: <20260630102127.392396-1-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630102127.392396-1-honghuan@amd.com>
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS4PPFE99BD3AEE:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b27763-ddad-4265-e0c0-08ded6b39220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|22122799003|376014|7416014|1800799024|366016|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: mNmDRLaY4krhDAm3OXJV8oymdWm6FeZPL7lBlHo5EwQ39KXo7cMTixhMONkBZl8DQ8b/vwXzveW47mNFHlVXpNT/RibjeIIIrZoWN9NcQMoYEq2u0HC1cnGjH/y1ZmsnO0BAyCAoXD9MpENdS6BA6/Ixk9/+5DAe+v8WjO5RAVXsSnXqUn/M/RAdhFimn+sUWhl8QPO+g1ltlHERhn70qZial1h6Vvf7p+7/Y72LQDufKKT1DvrMK+KyUqcUag1ykp2kna0zbGMkh4TTgQdByAEPh1Giq1TRdHB9ys+WE1XZF79feBlJxtBEGqbWDjSAaTopEQgeudDUhJKzikh9tA1/97Nla/cboCUqnSR1gGpS8vtWDP3Hlh/mrxvTn7P1CHxs9i3paXTe7WXmxCLUyCDMHo01Crg+Nfq5RZFZ71e9Ijvc4KI8uymgegVka2eifR1Ov06vcDbPPQMeUApapyz6ZPR83elsDIjmrf16JV2VRwA2wKhSt99evifVRDeuaWgQ4HJK7NhnpL2f0qsYhUR8hXBtfx30FcsAHEtjwJEkNN9efrSa9pqBsnf6bzMI7b6Tce62Fi7jGWRbV12gz9X9W4t3yvFUGKQVjhCb2K8c9ZklVmlXPR+bcUdF+H5/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(22122799003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YBmJjJuaC4YHQBqK0DCA1iWNR3SmELzHde3Xbzep5Coqj7ONXyu4TYD/53iH?=
 =?us-ascii?Q?eybV5AD7+Nh9/9nQ4e9O8z+C/b9qtoGZ0dPmTU90V2mHknSQpr3fRQcpegrT?=
 =?us-ascii?Q?ceAScE9ROF6TZe4VtY8JcEcRrU5Ww0B4jYDtmb+WkHAyoAUTtcCk7QGjYBAt?=
 =?us-ascii?Q?mI/hoSMUiujK3Ggps43Mz75ElZY+ydT0N0o9vC9T3SUkE3oXnWvxhYA2bZEs?=
 =?us-ascii?Q?0iquurOvQld5QT9C1MrK9AY2VzKpNsL0RZWXx4krvXaYNflKcfSCXsN3/Du1?=
 =?us-ascii?Q?alMaTHAml0Hx4IVr9NF6iNCT6frU7TyKzYTGBcTqqdLfDDJuZiTD5eVN8puN?=
 =?us-ascii?Q?dxV6QbgdSvInedupKdvKJb4DccBPGDhgDu+A/10+DzZiq4lkAh6ULxlCIy1d?=
 =?us-ascii?Q?r3DKoFZv+6601B+kWPK9wrathnDdL0mHSzq8U2QQ68aMgDVvM/lyMYNHmbqp?=
 =?us-ascii?Q?DMR64rzrfbZkYLrgnQDTVnMbP/fpfGhSIQmdhE13KdFujxOFlMi23j5JNfpH?=
 =?us-ascii?Q?iZFXavDASvyERYtH3LyjuISTcvanSSI0o9D7karUV8VQI8j3qz005RUn41bW?=
 =?us-ascii?Q?4SFIEWBKLm0bzVczLuniuj2VsLRYd9mGJDWku9yqS7Aoy/dZhBYCx5OLAFnH?=
 =?us-ascii?Q?EVwl4/3/wEDg9f2RCNLnIADSRbOlJKN5am3I1Hxs/YgzW4nJkk9dnyxbHfHs?=
 =?us-ascii?Q?DUZzYDv6nJOabwFej/lXk60KG1b0CsUxc0nW25VOAqCMdJloAcKcLCL4bzzw?=
 =?us-ascii?Q?XcdVIfxi4997h19b3FC1V7YnEvw5dY4Ba5y9NbisCpn18UBryeNGhHzrAz6A?=
 =?us-ascii?Q?YTp+5lYU6jUpXAJ9SYP9pm6R9GQVEbM82OZyrMeHiUubWO77ACvE/QXWExJN?=
 =?us-ascii?Q?zYocUsyFNh6eEiM77x492gMx+4VdHmwDfQqtjFP7MxT/ZvXjvsvjPfEbyL/p?=
 =?us-ascii?Q?luWZmNt1EZwBF14/23JXNi+e2KF5ceguKVTa9GGe1qVCYi/4oxQY3V5cZ8Qx?=
 =?us-ascii?Q?C3jNjjcm2SHUEoJVlYylx1mOnHN1Dz7k6jYxMixyCEduH5WBNh/rJMLfKdc1?=
 =?us-ascii?Q?ad6jz+/NItNvzHDKnMOsvcToqQ5CgAGP9sK+xTLv/JEB1IUnl1vGVH2Wg4VC?=
 =?us-ascii?Q?zmxQUo73rNKc4vohbhpK1A/c8H+n/xEjKlb2nEYqXRtLtdZ0lRYQ8UYl7of9?=
 =?us-ascii?Q?Rw4+C+zpg9XHNnkM3sw1Z7EKyD7FkM4t8m7tWAf/bHERtGKUwxYsj1SBn7qL?=
 =?us-ascii?Q?zz0DwQRR+4HtIUkT9xQk4+E1LA7QuX2XX4peYs7KYRknlesK+xs9FvIqIR/8?=
 =?us-ascii?Q?jaTZRwzkcbBM9ilX1XHJ6VQFPQvpyWDbDCTuqm8E9W5RaFd7ZevEsf/j8yR7?=
 =?us-ascii?Q?THX7Fa+5JdJ8MoQZeh0qauEeK5s0s8lchgLJrgISCfTK1cBd4LzxRLoT13U9?=
 =?us-ascii?Q?/PlrWstwns7/OjfjD8kOGONKTYVgx+UWS0BUeS38xXE46zR8MO3Q2GvgHh0U?=
 =?us-ascii?Q?bwctUVRE0b/fiaU+CEnCp5v6mVQE1s7//fXO4Mo0YZLf3VRVk2kLkKkK1+LJ?=
 =?us-ascii?Q?DF2zhH1YDZzDB3bV2KZaEJJTfUiBWPSAKEQ4tcCZc+eQIUiVpzognbWvLwy7?=
 =?us-ascii?Q?a+cw/PpSoUXw0zDboebldZDmL9QBHdfC6nUeFCU9P2k4OPrV4tnQMlZZSvHY?=
 =?us-ascii?Q?2I8YlsOyAW5YNUF8krQ4FYjI1St7NL8lgR8q6JtWv7GYeraTLfyCtPk/4kb/?=
 =?us-ascii?Q?/fzmftuTPA=3D=3D?=
X-Exchange-RoutingPolicyChecked: WQSswNCUzQ/+RtKdWEOLcXjp8+nA2d8AAcDArZitPgL4P0NYB73g/fx3lm+E4u+lq3h9Uto6GGgt/UViHHgtAHP5XXQaTUJcXdb+iWRvL1asMEGDA7I+6NJkDGkkbuPbiDAixB0D1m4FrNzM5ByuuIaZgoBmCLaZ35ej4F0StLg3iL+CL2Ft9EK1jMma27LkaLFmIlnYHOfd4cKc0kzZw1oltZqGMkMwd7cC/RcqFjDT2PKCJ6tGQZc2lyJH/8NsJWRgKiPGFnpHmsiMqxvRSCISaRAEvBhhu1QqIATXZ60NSRwGNJpqYMIFYKt/85zHRjaXhN8WFZtQ55EJMboNtg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b27763-ddad-4265-e0c0-08ded6b39220
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:26:27.6670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rDQzV4Y5smJAkgMHaGIdS980TPpp2Tj2mEWDzdtozIy4FB20io2MwfsdeeUYfBJXn4VN79l1eu+npsOQtz6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE99BD3AEE
X-OriginatorOrg: intel.com
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

On Tue, Jun 30, 2026 at 06:21:22PM +0800, Honglei Huang wrote:
> The intent of this series is to make drm_gpusvm more flexible and give
> drivers more freedom over how they assemble the MM related and device
> side operations. It implements the direction Matt suggested in [1]:
> Mirror MR in gitlab: [4]
> 
>   - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
>   - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
>     DMA through it.
>   - Drop struct drm_device from struct drm_gpusvm.
>   - Have the driver's range structure embed one or more struct
>     drm_gpusvm_pages in addition to struct drm_gpusvm_range.
>   - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
>     drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
>     drivers to use the drm_gpusvm_pages helpers instead.
> 
> In essence the series does only two abstractions, plus the xe
> adaptation that follows from them:
> 
>   - range vs pages: split drm_gpusvm_range (MM / VA range state) from
>     drm_gpusvm_pages (device physical related), so the two sides can
>     have independent lifetimes and ownership.
>   - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
>     the device side down onto drm_gpusvm_pages, which is where DMA
>     actually happens.
>   - xe is updated to fit the modifications, no functional change
>     intended.
> 
> V10:
>   Fix two issues found by the AI review:
>   - patch 1: fix a KCSAN data race in xe_svm_alloc_vram(): read
>     range->base.flags.__flags with READ_ONCE() and assert on a local
>     copy, pairing with the WRITE_ONCE() in
>     drm_gpusvm_range_set_unmapped().
>   - patch 3: remove the DMA unmap in xe_svm_fini(): since
>     drm_gpusvm_range_remove() no longer unmaps synchronously, explicitly
>     drm_gpusvm_unmap_pages() all remaining ranges before
>     drm_gpusvm_fini().
> 
> V9:
>   - patch 3: fix the build with CONFIG_DRM_XE_GPUSVM disabled: move
>     pages out of the nested base struct in the stub xe_svm_range and
>     route has_dma_mapping through range->pages. No functional change.
> 
> V8:
>   - patch 4: add reviewed-by for Matt's review.
> 
> V7:
>   - patch 1: split MM state flags: the AI review found a KCSAN / memory
>     model cleanliness issue. Address it for consistency with
>     drm_gpusvm_pages_flags, set the range flags with WRITE_ONCE() on
>     __flags and read them with READ_ONCE().
> 
> V6:
>   - The AI review flagged a potential DMA free issue: the DMA unmap
>     step was moved into the range_free callback, but on the invalidate
>     path a range can be removed from the MMU interval tree while its DMA
>     mappings are still live, so a concurrent unmap event can miss it.
>   - patch 3: have xe_svm_range embed one drm_gpusvm_pages: explicitly
>     call drm_gpusvm_unmap_pages() before drm_gpusvm_range_remove() in the
>     garbage collector, so a range is never off the tree while still DMA
>     mapped, and document this caller contract in drm_gpusvm_range_remove()
>     kernel-doc.
>   - patch 4: move struct drm_gpusvm_pages out: document the
>     unmap before remove contract in the garbage collector example and
>     note that range_free()'s drm_gpusvm_free_pages() as a final fallback.
>   - patch 1: split MM state flags: return -EACCES directly.
>   - Fold in the pre existing IOVA/DMA unmap fixes the AI review found
>     previously sent separately: the uninitialized dma_addr[0].dir on
>     the get_pages() error path, the whole reservation IOVA free for
>     mixed ranges, and the device mapping leak on the get_pages() error
>     path. [6]
> 
> V5:
>   - add reviewed-by in patches 1, 2, 3, 5 for Matt's review.
> 
> V4:
>   - drm_gpusvm_init_pages(): memset() the pages to zero before recording
>     the owning drm_device.
>   - DOC: overview: recommend a zeroing allocator: kcalloc() for the
>     N:1 pages array.
>   - Rebased onto the latest drm-xe.
>   - The AI review of this series flagged two preexisting issues in the
>     IOVA unmap path that are not introduced by this series; they are
>     fixed in a separate series [5].
> 
> V3:
>   - Fix a kernel-doc/Sphinx warning from the kernel test robot: use
>     ".. code-block:: c" for the drm_gpusvm_pages example in DOC: overview.
>   - drm_gpusvm_range_set_unmapped(): use WRITE_ONCE() on the whole
>     pages[i].flags.__flags word to pair with the lockless READ_ONCE()
>     readers and avoid a data race.
>   - xe_userptr_setup(): call drm_gpusvm_init_pages() before
>     mmu_interval_notifier_insert() to avoid exposing uninitialized
>     pages.drm to invalidation callbacks.
>   - Fix per commit build of the set_unmapped() pages.
> 
> V2:
>   - Followed in Matt's v0 review fixups [2]:
>      - keep unmapped flag in pages structures.
>      - add pages_count to drm_gpusvm_range_set_unmapped() to set the pages
>        unmapped flag, so the framework can check unmapped status in
>        drm_gpusvm_get_pages().
>   - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
>   - Remove drm_device from drm_gpusvm_get_pages() parameters.
>   - Reworked the DOC: overview and usage examples to describe the new
>     model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
>     examples that operate on a driver embedded pages object by the
>     drm_gpusvm_pages helpers and etc.
>   - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
>   - Dropped RFC.
> 
> Follow-up (not in this series):
> 
>   - modify drm_gpusvm_get_pages() to support one time hmm range fault
>     and multi drm device dma mapping.
>   - Add no dma device support for drm_gpusvm_get_pages().
> 
> tests:
> AMDGPU:
>   based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
>   1:n is on going needs many modifications and testings.
> 
>   Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
>   - KFD test: 95%+ passed.
>   - ROCR test: all passed.
>   - HIP catch test: gfx943 (MI300X): 99% passed.
>                     gfx906 (MI60): 99% passed.
> INTEL XE:
>   CI tests passed in rev5 tests.[7]


CI full is in flight, but it seems likely to pass. Once it completes, we
can merge this; we just need to decide which branch to use.

The series does not apply cleanly to drm-misc-next because it depends on
changes in drm-xe-next that have not yet been merged into drm-misc-next.
It does apply cleanly to drm-xe-next, though.

If we merge the patches in drm-xe-next and pick them up via a rebase in
the AMD trees, that works. Alternatively, we can ask the drm-misc-next
maintainers to rebase and apply them there. Either option works for me.

Matt

> 
> links:
> [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
> [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
> [3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
> [4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
> [5] https://lore.kernel.org/all/20260627033325.3795298-1-honglei1.huang@amd.com/
> [6] https://lore.kernel.org/all/20260628061757.4093701-1-honglei1.huang@amd.com/
> [7] https://patchwork.freedesktop.org/series/169384/#rev5
> 
> Honglei Huang (5):
>   drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
>   drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
>   drm/xe: have xe_svm_range embed one drm_gpusvm_pages
>   drm/gpusvm: move struct drm_gpusvm_pages out of struct
>     drm_gpusvm_range
>   drm/gpusvm: let the drm_gpusvm core context purely MM level
> 
>  drivers/gpu/drm/drm_gpusvm.c    | 243 +++++++++++++++++++-------------
>  drivers/gpu/drm/xe/xe_pt.c      |   2 +-
>  drivers/gpu/drm/xe/xe_svm.c     |  66 +++++++--
>  drivers/gpu/drm/xe/xe_svm.h     |  14 +-
>  drivers/gpu/drm/xe/xe_userptr.c |   5 +-
>  include/drm/drm_gpusvm.h        |  67 ++++++---
>  6 files changed, 255 insertions(+), 142 deletions(-)
> 
> -- 
> 2.34.1
> 
