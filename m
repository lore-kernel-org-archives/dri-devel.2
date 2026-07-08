Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBEFC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC1510F327;
	Wed,  8 Jul 2026 22:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aBHsHdP3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0619510E374;
 Wed,  8 Jul 2026 22:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783551390; x=1815087390;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mHZVpk3Y8GVK9IK91kxRlbtm9PMZ8rwB529pN/PdpVg=;
 b=aBHsHdP3XpqXTGlfNZUCgQXYxQ7/WqAedYntF5VS76IbGZcyzyvvBfu0
 tlr6GxviP0qssH8CPEn5BJ/zTIqyfv+n5bZBFJVtKrjy0W1qhmN73myHO
 e4B1TQwubQDFVDkDgWEB4L/E2UGPUCGwYjAR8iaaEQYhpuOl8jln6SizL
 pq5ro6Pa4wKrgg+q/w54fz1joayd/iA/Djez/p0lg1XFNJ0IImHgEEJ8E
 PY6QJCUiWuPrF1k0iVf3ufPl3BR48bIZU4JTU6Oitxxm3wKKODT5kZQY2
 bPAsKNucn5W9mqwRFe1Z1WrM/Np7Hhn7LANiv5oUJa8qURu/MXCJguWEf g==;
X-CSE-ConnectionGUID: QGuJMHu2RTGUROXs4YMItw==
X-CSE-MsgGUID: 6hcsXZOnRaKFJO9cJIHVLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84009251"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84009251"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:56:29 -0700
X-CSE-ConnectionGUID: UEildSTfTT6cDO+i6w2HPw==
X-CSE-MsgGUID: p0z9zK3VStqoHo12pD/8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="255066074"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:56:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:56:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 15:56:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7E5ae9VCM/7BoeWSiid/nX3wGIYT4Mul/JDI7808TOTbhG2uOtNh4fT39QDVSQuy9FEd0ePoQ2ThG/ZpVzRI570N0Pb/15vQQMZ5DCl9olVBn6CElslZK43BAhneITDXDoBftBVS6QVa4egplvDl/Iw/dEMXx8cyildN4IPsk1I8cq3I4roLhraMpvfYEnSR3CDTnB4nsJ4cBIhLsQbezJaDsjOtN8VwiluhvTcYC5x0OUDRuCUHmyJW9h5p/pVbqkLn/+enV49e/5FC8gq4FN33dASkoLNeBLadb/Eviau34xYLHgOSi6kdH1MGTjbCtrj8YcNLopA0gHiwldHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmHY4+eeK69nOhRxtXvR8aK75nPn5y13DdziZBgkGx4=;
 b=Rmg0cGJL6pq0PDR/uwJxTg/br/f/p8rBXNX5HIT5bHJLA2aDj8J9T4LeDK87OpMQIE96ffxz83NlPh9yWSpUWQ0NPbG4Tt9l80mV+lPSboDMZFMi1Q1XiBEa9VjvSgDQLMCI+KfprGeXRiq4NfYloncF47lfmvELErwx7F0Ufbes2CjF30yaBRa1hG1dbHLtreqWygC5fO+1N41F3ouqzRo0rdnWVZmE+2a68HfwxJ0KXqM6IgvQ+NCrVwL+W9RKXZDsDXSAqgNgSuvZ945aIetBuZc5869q4gbRPDoNf/Qju0A2YHJ0o/IFc4pgOKVdzrIOIekhlfl010t9hclDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA4PR11MB9300.namprd11.prod.outlook.com (2603:10b6:208:56e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 22:56:25 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 22:56:24 +0000
Date: Wed, 8 Jul 2026 15:56:22 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Huang, Honglei" <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v10 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
Message-ID: <ak7VlleUwy65QLtg@gsse-cloud1.jf.intel.com>
References: <20260630102127.392396-1-honghuan@amd.com>
 <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
 <4c0d3658-9480-43b9-9c33-667238697d1a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c0d3658-9480-43b9-9c33-667238697d1a@amd.com>
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA4PR11MB9300:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e79841a-77d7-4276-db4c-08dedd4422d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|22122799003|366016|7416014|1800799024|23010399003|376014|22082099003|18002099003|11063799006|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: w9El6Flrdk9Edv+j/7aCqQNgK1FDffprmRGz//CTeVNKyVEJenTNMyDD7SGXZePNRjx8IBxjcSayZiTtx4uxjV2wt9aYHmS6rlEc6F+XMCLCTTNXGHAAo60WVONSLtwDDrxgn74AE/kZpMExXK94+Wj9C++yfkv0gG5JkXXvjGIzZ+eoFKWLAitz5HQeonZ6vgMVsSk7hT4CmZ3pohSyuew5PIcXhQJ9PLonlEUa1keXVPrnyfHKokE+vKq7R+AlTukYRXk3z4z2ZKa3Bg9nzEcJHSnLhZSaC+A8S3t42B1d7TbLZBsMlN/wax1PLlW715r3MDB5xF4DppPnk4CwrNEg94A0k3kdlq0axbL0W2aTHoAdewCFhkjanWiuPv2QF10SsjlCH8hiNT3fGwTEzoexit0GhzumKdOmiZySu6/RU4OVkLgHGNREFsdog3H0fXOIr/HNHY6h4waFgAtaDzYWz6Ld2IxdJDd3EyrhinBDYYaK2azW0CGZ/mdsPMGEWe6daJXEwhpclXh6o+YnSF1qthmIZ5BtcrzAKA6limQSxF9prKk1iMTxHbd1PzVkkp7aYVi4/GzcX7qZNzfbTJZBZsUhahTvjfNeFuOzV6Ng2JxtNcdUahWLF6J3tprD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(22122799003)(366016)(7416014)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0/r4qJIPPJWurwrOlZUKnEcVrDXu1rluFyxTV+ahF6nD0T6KidNYM9EyWtV?=
 =?us-ascii?Q?d0pbGisD+HKtQPTjEIdm0MjAQTM0ZvQCO0r/BUM+qvEcjpG/HOBuwSweXxE7?=
 =?us-ascii?Q?T9xmdDVfFH725rzTGyrX0AMFFDcX7aX8ab8WfeIyOAXd5L+zbML/HgRbzYlV?=
 =?us-ascii?Q?xrMSj96F6jdgfS4gl2wWRn68iA4ob/brnxc+7spF65sDe1KQ1W18pTrPEJ3h?=
 =?us-ascii?Q?5G+nzbjHC/DgsgVSr8OHFulYgsaapR4HmMSZiW2tPOzA7zr1srwUghh/aAwo?=
 =?us-ascii?Q?lykQFapFfWbMHSf9SAq+AR+z1NuuYPKkWMofnj0/snx4yMPgLmx5z+oHycWi?=
 =?us-ascii?Q?4cV/Lyo5e3v4KA0nIztRZnQDhUjilMPWChs0FV5NRgwkShuKK7pUG8jAedV1?=
 =?us-ascii?Q?xuXDEZjhaHSvX3FW7/mMgnPTC/Y3yaupbn4eIBQCksHftIUyoEmfjBFZnQn7?=
 =?us-ascii?Q?90fAlbWcaGkvaLZ1LJl8JfQDd4WXIhMOKH/Nhen43Dd/Id8cCG8bnLrWFC6j?=
 =?us-ascii?Q?ULj7bNpp6HYEIfPOxTvG4LthtbVgBHMbIWPiUqrokZzdFJnze6tEMSd8BxXN?=
 =?us-ascii?Q?FVL2NTY8CpNmJ1mYOWb/D/ULK7MY5hTecRsnQDQasLgNGg3aYPIMfLBM8AUM?=
 =?us-ascii?Q?s430Q5RZ+W4WMCLHBhdedpogTzw4wocDcF0oRtchJHLHNS+Zj9ab3sde/6fY?=
 =?us-ascii?Q?kAtIcsYyrR37j0jtnYBtaAg6eQUdJgs+HcQzDGxCgbD6ncBcyCysvOrnd79Q?=
 =?us-ascii?Q?mW8JX+flkhq1DYFEFb2qk+Pfafw/xUuaBY4eRQu8NMtMu1WNJJ3lR2IT4jKq?=
 =?us-ascii?Q?ZOAtI3z0uD44qH7mo3YD1rqyGVIm0xIJ9JBBiVlTQwb4ZB4F4RUP3kYcZauL?=
 =?us-ascii?Q?h0vQFnubcNImOBjEcf6r7o6WL3eKlrnXZHplPtB6XXHQBuN7+VjX3tdKGYIz?=
 =?us-ascii?Q?0D2iZlOEwhN+h8CPLntr7FrVZiEmraFQWYF6pgIrZAEZhPIstlVSCE0J4Uiq?=
 =?us-ascii?Q?kv9FuoVevG5uzVAPwEhyk7N7oLqxlrkACoOT/eAPfMdv/5nPqqANynFYXqST?=
 =?us-ascii?Q?LHYliVUoagMTWnfro2wdSc//ca7s7bvYWSsipJUbLa18COIxDvaTLUqUHhkc?=
 =?us-ascii?Q?Aj6GvuAvq341r4Qg2JIcgQxaqkoXi6D2pWIVeWUieqb/+q06EN5cYkucc5WH?=
 =?us-ascii?Q?N/x2PBp8pjC+pl/8o14xHMVCUwPyJZbsd1wxlAdO7/9afogorp61haG//Vou?=
 =?us-ascii?Q?1JktFD7zZbv5e5PMuQuKcGs7m+IsYAyhLWEIN/xfCdGHVKfwuoQOK+lrPtcD?=
 =?us-ascii?Q?e4v8gm9U+gOwYNwCITYnTC3ExegBBJEx+YCJRuo9UmCT561xCaA6+H3FV3Ts?=
 =?us-ascii?Q?sEQus93gZeHckG5vqPiqf+Giw2iF2z94NX/EyTBeKxy/3XaMR/DRqfmoqyQL?=
 =?us-ascii?Q?K8NtGJObzZ5+WI1e/x6I4L1G7R4NuhXzhg1has/AJsypKslcWMBSs3jzUkS4?=
 =?us-ascii?Q?KpP+MSS9/va+4Bmw8aR1AUFPDFU08bPl3fy9AlyS0pbNQc/wl0ZwsxKT2Obd?=
 =?us-ascii?Q?o3NS8Hbq0fs4mFbWWEGqNqOolIKJKcPZwLVL+I+vWF0isqRCvXmLb1zmA/4U?=
 =?us-ascii?Q?1TWjB+yYcgix3i5+wUoV9XBbw0BjEfcsgZ8z2aIiGs9RYGgcDSBSDeQgCbml?=
 =?us-ascii?Q?bJ5Sv/2Bx7aBLlFFHrIo7GeWZrsqK4oQA4zVAYeGuPhpTnSCsazDHxh5MwoS?=
 =?us-ascii?Q?3bQpfaGHzg=3D=3D?=
X-Exchange-RoutingPolicyChecked: dmYwxJ+BZgAPO/gVK//S4HOS0l0Mh78JvSTQUfveKhcaSfYR2ddIBYFbJ4pLILvDYKAx9vTdqYjoUIJBGQjmDk8gXBHk0wUzBhWRfUtAtYfLZkSSX6ZNgXMV+XrZnEQVybGY3lUPAyOEQYeNBYmaJNKxGMSeMWSd60GkEoRg2W4XeE8XgkHO5cZqUFh03ugKCMy7RNt7NR5IJb//tKbU5WOJT86XBsfWzCPBQdckgoUmrsjxgMA1+LTg9rK7prpz9nlHOYaDqGX5nur+87hG9hUtBsK1MbJTDB3cFNnNfRJbsxPm6l8ogxhwytFylrkjeZXhsN+HbGg0ixHnt113fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e79841a-77d7-4276-db4c-08dedd4422d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 22:56:24.7440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ly9+rSvcIU+VUnDanefdkpiUYDQ9RJwhtlyTYXxQswKBQcZYRZC09ah+nw/6JXM1Iv6XSSWkpx+HeXwMp98YXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9300
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

On Wed, Jul 01, 2026 at 11:34:57AM +0800, Huang, Honglei wrote:
> 
> 
> On 6/30/2026 10:26 PM, Matthew Brost wrote:
> > On Tue, Jun 30, 2026 at 06:21:22PM +0800, Honglei Huang wrote:
> > > The intent of this series is to make drm_gpusvm more flexible and give
> > > drivers more freedom over how they assemble the MM related and device
> > > side operations. It implements the direction Matt suggested in [1]:
> > > Mirror MR in gitlab: [4]
> > > 
> > >    - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
> > >    - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
> > >      DMA through it.
> > >    - Drop struct drm_device from struct drm_gpusvm.
> > >    - Have the driver's range structure embed one or more struct
> > >      drm_gpusvm_pages in addition to struct drm_gpusvm_range.
> > >    - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
> > >      drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
> > >      drivers to use the drm_gpusvm_pages helpers instead.
> > > 
> > > In essence the series does only two abstractions, plus the xe
> > > adaptation that follows from them:
> > > 
> > >    - range vs pages: split drm_gpusvm_range (MM / VA range state) from
> > >      drm_gpusvm_pages (device physical related), so the two sides can
> > >      have independent lifetimes and ownership.
> > >    - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
> > >      the device side down onto drm_gpusvm_pages, which is where DMA
> > >      actually happens.
> > >    - xe is updated to fit the modifications, no functional change
> > >      intended.
> > > 
> > > V10:
> > >    Fix two issues found by the AI review:
> > >    - patch 1: fix a KCSAN data race in xe_svm_alloc_vram(): read
> > >      range->base.flags.__flags with READ_ONCE() and assert on a local
> > >      copy, pairing with the WRITE_ONCE() in
> > >      drm_gpusvm_range_set_unmapped().
> > >    - patch 3: remove the DMA unmap in xe_svm_fini(): since
> > >      drm_gpusvm_range_remove() no longer unmaps synchronously, explicitly
> > >      drm_gpusvm_unmap_pages() all remaining ranges before
> > >      drm_gpusvm_fini().
> > > 
> > > V9:
> > >    - patch 3: fix the build with CONFIG_DRM_XE_GPUSVM disabled: move
> > >      pages out of the nested base struct in the stub xe_svm_range and
> > >      route has_dma_mapping through range->pages. No functional change.
> > > 
> > > V8:
> > >    - patch 4: add reviewed-by for Matt's review.
> > > 
> > > V7:
> > >    - patch 1: split MM state flags: the AI review found a KCSAN / memory
> > >      model cleanliness issue. Address it for consistency with
> > >      drm_gpusvm_pages_flags, set the range flags with WRITE_ONCE() on
> > >      __flags and read them with READ_ONCE().
> > > 
> > > V6:
> > >    - The AI review flagged a potential DMA free issue: the DMA unmap
> > >      step was moved into the range_free callback, but on the invalidate
> > >      path a range can be removed from the MMU interval tree while its DMA
> > >      mappings are still live, so a concurrent unmap event can miss it.
> > >    - patch 3: have xe_svm_range embed one drm_gpusvm_pages: explicitly
> > >      call drm_gpusvm_unmap_pages() before drm_gpusvm_range_remove() in the
> > >      garbage collector, so a range is never off the tree while still DMA
> > >      mapped, and document this caller contract in drm_gpusvm_range_remove()
> > >      kernel-doc.
> > >    - patch 4: move struct drm_gpusvm_pages out: document the
> > >      unmap before remove contract in the garbage collector example and
> > >      note that range_free()'s drm_gpusvm_free_pages() as a final fallback.
> > >    - patch 1: split MM state flags: return -EACCES directly.
> > >    - Fold in the pre existing IOVA/DMA unmap fixes the AI review found
> > >      previously sent separately: the uninitialized dma_addr[0].dir on
> > >      the get_pages() error path, the whole reservation IOVA free for
> > >      mixed ranges, and the device mapping leak on the get_pages() error
> > >      path. [6]
> > > 
> > > V5:
> > >    - add reviewed-by in patches 1, 2, 3, 5 for Matt's review.
> > > 
> > > V4:
> > >    - drm_gpusvm_init_pages(): memset() the pages to zero before recording
> > >      the owning drm_device.
> > >    - DOC: overview: recommend a zeroing allocator: kcalloc() for the
> > >      N:1 pages array.
> > >    - Rebased onto the latest drm-xe.
> > >    - The AI review of this series flagged two preexisting issues in the
> > >      IOVA unmap path that are not introduced by this series; they are
> > >      fixed in a separate series [5].
> > > 
> > > V3:
> > >    - Fix a kernel-doc/Sphinx warning from the kernel test robot: use
> > >      ".. code-block:: c" for the drm_gpusvm_pages example in DOC: overview.
> > >    - drm_gpusvm_range_set_unmapped(): use WRITE_ONCE() on the whole
> > >      pages[i].flags.__flags word to pair with the lockless READ_ONCE()
> > >      readers and avoid a data race.
> > >    - xe_userptr_setup(): call drm_gpusvm_init_pages() before
> > >      mmu_interval_notifier_insert() to avoid exposing uninitialized
> > >      pages.drm to invalidation callbacks.
> > >    - Fix per commit build of the set_unmapped() pages.
> > > 
> > > V2:
> > >    - Followed in Matt's v0 review fixups [2]:
> > >       - keep unmapped flag in pages structures.
> > >       - add pages_count to drm_gpusvm_range_set_unmapped() to set the pages
> > >         unmapped flag, so the framework can check unmapped status in
> > >         drm_gpusvm_get_pages().
> > >    - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
> > >    - Remove drm_device from drm_gpusvm_get_pages() parameters.
> > >    - Reworked the DOC: overview and usage examples to describe the new
> > >      model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
> > >      examples that operate on a driver embedded pages object by the
> > >      drm_gpusvm_pages helpers and etc.
> > >    - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
> > >    - Dropped RFC.
> > > 
> > > Follow-up (not in this series):
> > > 
> > >    - modify drm_gpusvm_get_pages() to support one time hmm range fault
> > >      and multi drm device dma mapping.
> > >    - Add no dma device support for drm_gpusvm_get_pages().
> > > 
> > > tests:
> > > AMDGPU:
> > >    based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
> > >    1:n is on going needs many modifications and testings.
> > > 
> > >    Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
> > >    - KFD test: 95%+ passed.
> > >    - ROCR test: all passed.
> > >    - HIP catch test: gfx943 (MI300X): 99% passed.
> > >                      gfx906 (MI60): 99% passed.
> > > INTEL XE:
> > >    CI tests passed in rev5 tests.[7]
> > 
> > 
> > CI full is in flight, but it seems likely to pass. Once it completes, we
> > can merge this; we just need to decide which branch to use.
> > 
> > The series does not apply cleanly to drm-misc-next because it depends on
> > changes in drm-xe-next that have not yet been merged into drm-misc-next.
> > It does apply cleanly to drm-xe-next, though.
> > 
> > If we merge the patches in drm-xe-next and pick them up via a rebase in
> > the AMD trees, that works. Alternatively, we can ask the drm-misc-next
> > maintainers to rebase and apply them there. Either option works for me.
> > 
> 
> Thanks a lot, Matt, for the guidance and the reviews in this series.
> 
> For the merge, happy to rebase onto whatever base/tag decided, just
> let me know.
> 
> And will work on the follow up works.

This now applies to drm-misc-next, so going to apply there by EOD unless
I hear an objection.

Matt

> 
> Regards,
> Honglei
> 
> > Matt
> > 
> > > 
> > > links:
> > > [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
> > > [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
> > > [3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
> > > [4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
> > > [5] https://lore.kernel.org/all/20260627033325.3795298-1-honglei1.huang@amd.com/
> > > [6] https://lore.kernel.org/all/20260628061757.4093701-1-honglei1.huang@amd.com/
> > > [7] https://patchwork.freedesktop.org/series/169384/#rev5
> > > 
> > > Honglei Huang (5):
> > >    drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
> > >    drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
> > >    drm/xe: have xe_svm_range embed one drm_gpusvm_pages
> > >    drm/gpusvm: move struct drm_gpusvm_pages out of struct
> > >      drm_gpusvm_range
> > >    drm/gpusvm: let the drm_gpusvm core context purely MM level
> > > 
> > >   drivers/gpu/drm/drm_gpusvm.c    | 243 +++++++++++++++++++-------------
> > >   drivers/gpu/drm/xe/xe_pt.c      |   2 +-
> > >   drivers/gpu/drm/xe/xe_svm.c     |  66 +++++++--
> > >   drivers/gpu/drm/xe/xe_svm.h     |  14 +-
> > >   drivers/gpu/drm/xe/xe_userptr.c |   5 +-
> > >   include/drm/drm_gpusvm.h        |  67 ++++++---
> > >   6 files changed, 255 insertions(+), 142 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
