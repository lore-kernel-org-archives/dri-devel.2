Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C903606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b5jL2pyc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AECD810FF1A;
	Wed, 21 Oct 2026 16:36:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC8110FF20;
 Wed, 21 Oct 2026 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792600614; x=1824136614;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cs8fgOpY+KxSmCybG3FeeRKSprnNVJOpz2ds2xBWgio=;
 b=b5jL2pycaipyFO2i4TEzry7Frk1kLx+7K39ip6qLO8lYx2Mrkyzbc+rX
 H6AVIlwWf6KvYn1Cwmvi8urfj7qScQkxZrFv+up0yM1K3ez43iIpt61I6
 0Uh7RNUNLFCiVcX7H8pdrZo4xn59JWUx9moW8p9JeCr7yLDhi8xyb1Bfa
 Druu2PY+qCVec/fSoioFWVAQbmjqoCggGRHiU6DM0a0cuvAAD2t5oZYR1
 RvOTKbXBAWTZEAp5JUNo9F2w3ok00l2LkWlDyQqI3rJmWDrY0teu9XYMl
 AndSNcFyzvZpi/QsyNCHTDzHjnKMDtQBWEOQmVMppeGaJwb0Tl9XS4Alk w==;
X-CSE-ConnectionGUID: P+rENxLvRo6AiH2dykC9pQ==
X-CSE-MsgGUID: UlTTiBGMQQK7RQKpRFc5PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1346394"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1346394"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:36:53 -0700
X-CSE-ConnectionGUID: rDVFee26RDaQUzPOlHmDqg==
X-CSE-MsgGUID: awAjXLMxQIqNsvRuVb1txw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3246072"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 09:36:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:36:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 09:36:52 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 09:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmQ3yRcqWfOZ6irzr2ZToULsrwPDK71+HH+9F+LHsoL2LJqh815j6PI9y0C96FV9KFZafeFsRM3FRGPqxiejQUTcMX0SRwceMl2/W8ws7sjQXSGg/cJ+ZHCe8LhbplHhBgQnBAzqB21IP+oWnE/EGXH4WT4SDXRmREPN6K5f2WWGaHsX54jBkZpI6h+rVmJhKUpGTyUR/qxg8OyjpRXwesr7RZChR3Gs+2RBa4g2PPjfvQwbuF1bY5zz2iQynQRLeeLFNxVPoLz0EkV/52zkhe4i8SM2NfmwuHRVUtyPNxrXMhcG3bAwoUFjcwdIqwVnYmJuh8saTlMLmH3UAZ+qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt8qS9f5ikWmFof2wO6/Zh9sd65rcDkRt/JDxHiyQbI=;
 b=T9jLHASK1mLxZ0i4iLxQ6oIo8s60i7nz0JPDxOmwWuoTlOTtQaVKrf28w3UJxcop48nF5ZjpYu1PQPvLrta667Z2jlkbsJ1yEoKq2DAEZL4UqrmngnVIjzZJASLX1sZLM5ydlb4bQEZw/ujB/oSZNx4kU/6wq3DT3oh/Su/BAvQkhcb0nvAa34mZwwRKPh5Mg0HHY2MrTS7ZXRA1a8PaaMvde8oZJocQX3SGjwZl/zoD57zOkCXFwMvw6Btn0Sc84tmquRIOnM44aN5fXTLqavSLwE+wk1tTsCeK8oFPoTsv2AP4Hhqcjt7UdvuN9Qv1Aath7N/S0hfvcH4I8FZVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0SPRMB0020.namprd11.prod.outlook.com (2603:10b6:208:433::21)
 by CH3PR11MB525758.namprd11.prod.outlook.com (2603:10b6:610:34d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 16:36:19 +0000
Received: from IA0SPRMB0020.namprd11.prod.outlook.com
 ([fe80::289d:f5ff:d1f4:a9ec]) by IA0SPRMB0020.namprd11.prod.outlook.com
 ([fe80::289d:f5ff:d1f4:a9ec%4]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 16:36:18 +0000
Date: Wed, 21 Oct 2026 12:36:12 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Chris Wilson
 <chris@chris-wilson.co.uk>, Matthew Auld <matthew.auld@intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>, Andi Shyti
 <andi.shyti@intel.com>
CC: Linus Torvalds <torvalds@linuxfoundation.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "Tvrtko
 Ursulin" <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, Borislav Petkov <bp@alien8.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, Joerg Roedel <joerg.roedel@amd.com>, "Nikunj A.
 Dadhania" <nikunj@amd.com>, intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, the arch/x86 maintainers
 <x86@kernel.org>
Subject: Re: Removing __get_user / __put_user for good
Message-ID: <atjp_I_dCfw0tW0W@intel.com>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
 <664c8f8c979a76be18b3e6538a15d3c4235fb8ac@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <664c8f8c979a76be18b3e6538a15d3c4235fb8ac@intel.com>
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To IA0SPRMB0020.namprd11.prod.outlook.com
 (2603:10b6:208:433::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0SPRMB0020:EE_|CH3PR11MB525758:EE_
X-MS-Office365-Filtering-Correlation-Id: b18c7d26-cb07-4009-2474-08df2f916e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|4143699003|11063799006|261009223027099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: /uCYOBsKYdm5AS7ikuHJKiKqLiTEIkBzvLrRVP49Xm8QrI9tsER2J4A900Q+z3PFOIZ44MCDN9OfYPPI7Qmk2p4sUxm0bIllYuTNr0nkwQiPojeaClNvHCMKomikna/ofSw1lSpg54fdmqKrJFd6ubGyh3zqcNsNaAfEKRsWy9HjMxHk3j/gKedG+BGsilMKKRrTO6P8LEeC5rlSiEWYqWHCMpe+n5CsYeG7LJhbt/odz0rNNHf+4p0N0LZ/kzKukjaRJeEibJCOfO8lIuaQzBGYDEqxMoflZMBxEhvqsRQx0DrfNoHrMwPm4shWf6F5WbzsbH//fAMrJFEXiRnspxghykz+jUS7fOQ50hTopTV6Eiy/yEdN+6wGUCiCeUMP+Z111BjaVOtP/gILd7YnPM2DrVJvLQVshoQVTq+HlPW5GK31BMkct8G8xK+Gl2ODgpC8pPDQUGFvevg4K+WkFiQ717sjvd0DFrzOuoyaTu91L3v+nF1d7vvQTDiTrWeMlwBRMvOggbQZNlTx3UwBU9iNt9ybN1YryRr4XQZH/Vdee4RCiT9J4WnFvbm7IxqEB55eCY6JYOQwQI/Uv+BjVNkufEw291mImRfznvcZmZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0SPRMB0020.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ATpx9C+aNoqYYTNkDuPwZq5wB5cbK2I6xRzs7OMvyo8rq4ywEg7y/U5I9wL8?=
 =?us-ascii?Q?WZHXaCMpYHCdeajnrQqbgL/KcHhwvxncOJGayJ9zfKEnXAB46YeiYU/2oFyU?=
 =?us-ascii?Q?G0Lw/yUKxtVQ8aQ5keQxA2LuLXQ9eEcLT/M/hma3Poqt58GIMeBB36Um9Oc+?=
 =?us-ascii?Q?PS2VW8KVCtfmWNtrbzSt7zMPXeLxrlHyZfeiK/8yw5p3AAV3cJdpBwa2a4dD?=
 =?us-ascii?Q?cLN0ulWWfrqKEZ9bvO3Btl6RrYCKoVJw5I8rVfFhGcNVewh8OS/StAff32wQ?=
 =?us-ascii?Q?iYk4C0JCQhVMt4/hCJFY3QBxNx+W5WAfmryczyAutjGO0PM7PdQbNX2ozCGT?=
 =?us-ascii?Q?z1XbI0KIyxdk/sWCByao26KJwWz5WRmYWhWun891K6ZRTSvPn6RB/2y6EOJb?=
 =?us-ascii?Q?BakZ19zTAnojyEDPTf6XDLGQ7Ipa4Lh6uNyWYjh2wRYfLMcCKT3oy52LO5vd?=
 =?us-ascii?Q?bdU/dJ8jC+sz/XwK/uZP1qRJ0YyxjLA7Jhlx4P/oTzeqGD+QCl+BbJGJdqm6?=
 =?us-ascii?Q?cpIPwGCns4MlcFjfRXwXGyJ5FyHtteI9v777B3KM75il0We4PqbAo9IKX79A?=
 =?us-ascii?Q?uIX88JBtUMy3Ya8zMFQYWA+fYerUCfXgr1DsKYUYC4Grx8cfKceFfJwD+Kr5?=
 =?us-ascii?Q?x6oaBSPHsbh13aruxo93KI85Fxl3fIGbLA0+Un1YLV2c7LIlg8N8vvB4PB+S?=
 =?us-ascii?Q?hRDM3K3GxU35JnLou2T0Z2aC5AWm8WIiu1ys1rzs0Tx/GRQzCvjY5PtBYBEV?=
 =?us-ascii?Q?XTQLpzjQ11hBfzF/3tvzrVPmnxUYCOWF2E5P9RBnwGBi9p7+KhjaIBySm8c6?=
 =?us-ascii?Q?Q28JvtddX7CAynSdoAKQLE/Irm0fW01hV+hUhZyJeUI8wPSm42eM3fEXx2R3?=
 =?us-ascii?Q?k5TgV4RNYw4CzKpOS1MCc31rw0ZKPREKfclM7SMhb851NxTdRm6ZVoE++Pxx?=
 =?us-ascii?Q?5BjImZ1GOnT89EWrBS1IjAj91yVb1JsoixEGA02Ktu4iZ87sU8t+rMps6b8W?=
 =?us-ascii?Q?xTvo3QnoESMptdNqwB06HSikcpJSDKfSm/L+dyLDudFHW2K/XRvlp+jGvv4v?=
 =?us-ascii?Q?bA3X85331UJkeaiyLvsIYow/+ayeAS/UkXU4HD8r4bkXPTBQjX2FtBmOOdwD?=
 =?us-ascii?Q?CSPkfG4rB3ew1xkK57ndA1UFo/nrNFhE3KMq80A4lid4FlM0sgztphhMKdkP?=
 =?us-ascii?Q?RKfZYF5+yvzCvYVHw7/m1kR7hNdr28XDZQRlMjUJXKBB3UXhEWoGwFXn6ZUc?=
 =?us-ascii?Q?8RuWdvKPi5wvVyRFT25saVGoalNbDtIGZ5Vgcvro0TNmWCUX0Mu8yw98Cn9W?=
 =?us-ascii?Q?yI37KxpHi/OZBn9m9SqmoNnvIdHcGyXOz8CSsOdHWqUxi3gXx592Bak9pzQw?=
 =?us-ascii?Q?PqUjZVxv8LBVmkAfhiaFKVCG4VdJfwe57OztbxWo5Eq0WhsiIiAjDgDok4mT?=
 =?us-ascii?Q?7K5PBhfd20Xl7U3prnpyGIg9T8CdWigKg2YwJJaPhuTNEMOJgw8X/6mxEE4I?=
 =?us-ascii?Q?kGq7DCet4843IQKb48JNw8Etz5/pVQUur6wdSde9Kit/ohA2GsKM3I/f1wng?=
 =?us-ascii?Q?rSXt/2f1AxOK78wIXBi4rBZH6ptNmF+G9U7H6z+tYyOLQiTbPBZh7yha9Kd9?=
 =?us-ascii?Q?xrnwuj7MjRJ1j0HZo84N2cCrz/R20osv+abHImYjr7XnDAyauOM03hB+Cchc?=
 =?us-ascii?Q?iaonAyK+20S/AemzZKVv/JuMbB2D1mkrQnBBV67xZNiBQtmObJ3+wZDCyb9/?=
 =?us-ascii?Q?gBiPuFGb4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: DUW94P4lYrzkWz6pMi1kumVmuAkLqFxY6s0yv7FY/rMY88eRLplJCooGxg6nskeIGdLKqNNpLlheNFi2Kz0C/nRBHd3qHyko/pXfbZBAFpuHpOultoqdTrZx1hEL+r1HjL/eO6hstn7RuVM7EWlAvkqjl8K+R8KN720fzEqZbQAjE5BG9dn8N2bHD1qBVyMOkJGR2HjJK3A+9z3+9qOm75EiTfLN2UgXJyathg54I5s7xFuIsEXU7mXGvndrh3Ym/n4tf9f90eOzylYIRBfj1PfhbFSZvfRClS9fmfThG5MHh46VoOGGkZype+s8EXRHq4GHrbBeT701bs5Ujuoh6Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: b18c7d26-cb07-4009-2474-08df2f916e8f
X-MS-Exchange-CrossTenant-AuthSource: IA0SPRMB0020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 16:36:18.4026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+wr9B1XSS/e8/TzSQ6GnsTEehVxsmV133nY1k23WovJmMRtgsDkZMIJLific+HgD8/3kudQ59q9CNgkllSspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB525758
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 12:33:58PM +0300, Jani Nikula wrote:
> On Mon, 19 Oct 2026, Linus Torvalds <torvalds@linuxfoundation.org> wrote:
> > Bah. I made this branch of mine public because I wanted Michael
> > Tsirkin to check the vhost part.
> >
> > But honestly, the i915 side and the coco/SEV patches are the much more
> > interesting ones.
> >
> > So this brings in some new victims^Hpeople for that git branch to comment on.
> >
> > It's all in
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > uaccess-cleanup
> >
> > I haven't dared actually boot it yet.
> 
> I rebased it on top of our development branch and sent it to i915
> CI. Let's see if it blows up. ;)

The new commit 'drm/i915/gem: Don't fault on presumed_offset write-back' [1]

reverts commit '97a37c919f62 ("drm/i915/gem: Ignore readonly failures when
updating relocs")'

And this blows up exec_reloc concurrent tests that uses
mprotect(reloc, sz, PROT_READ); [2]

I'm not sure if this is a real use case though...

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Andi Shyti <andi.shyti@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Folks, can you please help here?

[1] - https://github.com/torvalds/linux/commit/03c19e449ac6e12a88ea4866331f2404668e22cc
[2] - https://patchwork.freedesktop.org/series/176471/

> 
> 
> BR,
> Jani.
> 
> 
> -- 
> Jani Nikula, Intel
