Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1FEC79F81
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD3110F74A;
	Thu,  3 Sep 2026 19:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C01Jh/8I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C37610E504;
 Thu,  3 Sep 2026 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788464302; x=1820000302;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=k4HvpRSxGItfF7/G79HuQBV+XCndDMfepEtuhiT2+N4=;
 b=C01Jh/8Id0uGIPD2mXQhBHSUjob0nhGWEyR0iZD+NUgD3doGbW0ck+ug
 lS+1NYd0Rm6dFoOd2rwOVMyv4BxUq09Zl+IblDJAdkMje8ajC4UlbFN5W
 8w7/3it9bp4Qd4R0z6eHBSBQ87bdadOjd54tyDfOh7oacWGU6RZ/Kfri3
 gcWSPsqPk/fCub+TsyiiqWJfRugJBCAYIjvwsBF8Ci09vRAwEbg62QYXj
 9p2rOl1EsZby4ShHRREn0yq3rFICHydo9do9ghtaOQwA+f/RrSrW0l9zD
 Cg4i29zW44aOSqx4jI0k+jeV7fWsG2Aj2QgCu3s5xTQJ6g+NEFC4nIfd4 Q==;
X-CSE-ConnectionGUID: IxdrhQNwRLa0Utsu+rsfcg==
X-CSE-MsgGUID: JrcnZw6dSae0BROP3MfAdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88099893"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88099893"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 12:38:22 -0700
X-CSE-ConnectionGUID: cJx+a4LPT76jIggItwVx7g==
X-CSE-MsgGUID: d0dPmxMvTu+CdiZEdu4jSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273341086"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 12:38:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 12:38:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 12:38:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 12:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daRGGgkvv9rKSfha4Hg2v0AOF4o5FrHTU+e273Rs/U8QMBdXhScJK/vrZFDqPDdWkgW/biDvEvMHxQgrvqj3K63eP6uTpQOB1CdEHBLGhhjq45EJnqE/hrkjN98EQPjV25a5i/3iIEnI5ttogfJ0FcMWzgbfyczdORFrnoQyE4xr5shhqm3QHsVHrNoGFxGVujLvy4ybwIUJDqKaXnyZFbQp88Z3wbUTRHU2R2PcZnzMgBEl0RHBDt1af8c/doCEKDHVL54/v80PX3B+kJNYp3cjZI6QlqPp4Jk5L9Fk7gDPOdmx0OBJ4WaLdyCS6nQZIQvEnakKiYXrxTSyZ89miQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3+kreRBp472GNdF9A4EM+cL8U3dePQ7f23Zbb3LPFk=;
 b=kVuBdfMvH3Ef/eDn/UKNgKnJLF+WXtWiD40rRrPcoPpOLGOc0rIklhcR78rgnVGkO3mBp2XYSXy150Lx3RRsbBQsADK6wLB9isUJMrSKvtu2o6gK6uEwkedEH9j/mTO7bEFLH4/pQ76HIA8KOYpLy/E8xFCA4PQ7C1stiKBT4X4kAexiTL0oNgmHakUtHQXv19xIDJvnppMOw878y2LptZuD0XKOVXWJrQS8S2K0RwYpGlvcI45F6SYp1aKbr1cMZG2Mqr+ZW7M5E71Y17d34gIm+FTzt6IcCQpQOBu31BJv6FbMAw/cQ9l3YzpwCYiAEoohtGbqwAb5sEtTkLjBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SAWPR11MB9571.namprd11.prod.outlook.com (2603:10b6:806:4e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 19:38:14 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 19:38:14 +0000
Date: Thu, 3 Sep 2026 12:38:11 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <ecourtney@nvidia.com>, <nat@pixelcluster.dev>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: Refcounting dma_resv v3
Message-ID: <apnMo3x9nT/unjLE@gsse-cloud1.jf.intel.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SAWPR11MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d6adb5-0c53-4a66-9ac0-08df09f2e532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gya0ZfagYZkGjn5eC/kc2uA89grtyiSG6eQCM66DfN0u1pukg79KUYzg96WK8MCFJyW/167JbT/lALbFcCfYW6XVZqUn7mju7/HZc0n4Y7mRt7jKwhZbsrcXs3Ah/L0w3a36BfGvkQmjMuHEc3/pPsVukGqMbFWgy5rpp9fsG95wRYWPYw/m9fgEOmzaDT7Lt0FhVKFzHtpsgJJyYhpby/9ZrwxYWxjpGYXfhYy2JlwVQol3/TildCvs2p4HjsFmHflnQLKllilTt6jGJPfrkXXJuHDy7pzLagpVE5MtJ5/sABDfhthBWtJj3MkRFVFlvb6z/Ky5NEjXbu4nL6vR8KA4aq1THB91/dtYWIH/aiOXz/ALdgJt645xfr50iQHjWMmusiDbJa/S/p9nkYlNqKgLcuTunMt9l58vX5OOJ/Q7ITf4GLYzADIHl1e8WDrjnj+4YwjzJ4rYikjGHGneKPEUqVnmryB9/FdiWEHB6bHIaj3uiAcMceKbfBNV24yBbC/Bd90k1aGHXTQ02PTU6ntytl4ZBKNQMzOy6/xbqAQrU0FEYmRdoLg56h0vajF5MY4dz2XSUxMUVF/t/9fkEgmLROKQgstqXJzdaigHBU2t4Xe5UZAgxJPCHTkWUvvp3M5R8t2Qw1Z27dEhuNgp5FMTbBOOqw/06iG8wH+BFQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lq5/ReGwUuReeDWI21w0uYXO+gLKt233oql8CTz6J6GDOKzfSettd/YNhu?=
 =?iso-8859-1?Q?6jbmsWAaIw3U7ksuQcKV4//nVnipts1cc1nkvNesrHM0BCumdcu/6hWJZc?=
 =?iso-8859-1?Q?JYfITTOX/w2I9Colbz2Utoyr/RafLgFztI1w6Q45R2AID3/RNOiJQA8AtH?=
 =?iso-8859-1?Q?SrF31XKN1TiYy+mRhvzUMLXovms7fr8j6s5ObudkHhWLT6qMeZPnQavjJ2?=
 =?iso-8859-1?Q?QgE1/GGjaJ8h8nEDsg4tb7jGzYwSM9AkzUQou1daQVXecHOOz3yzNI2V7e?=
 =?iso-8859-1?Q?hrlr26+rLQC6hMM5XqOenaFNo8qCj2ToMmyeYxpGYftP/16n9T3/m0n8hv?=
 =?iso-8859-1?Q?vaFC1UVqGiJLjhDYZaP+/OJMx4029fJo+z/McObt8k25xWH9uFZC4aqVAL?=
 =?iso-8859-1?Q?vBkzUIrIXGUaOrJf3YqCGA/k9GgfFYWJECu00poTBP7ci74DUAS4aQB+xi?=
 =?iso-8859-1?Q?tYSZaoVYlNI3rD+pA9oOx2Nlg7Vtwd4HBAXS2rAcN1JzOJWWIR/L+2J+dT?=
 =?iso-8859-1?Q?oZPOKRf2Sgv3u9pmU6h4Bsh9v3sL0jeFyW8LNMh2BKO7RwX2X+WLJsy7GF?=
 =?iso-8859-1?Q?4soKLjmQvC7TMjqechpCCfLx+LZXs9S31e/Pfvr/tn+TGT4vxuBP9y6VC6?=
 =?iso-8859-1?Q?x4IiOS7A7dHyFp33fkntCZYwvzUnqqfxNcM3hRvbEFo6Wzto+uu+o3i0O7?=
 =?iso-8859-1?Q?nwkoRSp9LfzT7z1pBX7vFY2Dbf3Pc59sGrFSrc3BBGIosLGkqWzeReLgib?=
 =?iso-8859-1?Q?Ryn+kkmBBQNWdV1YY5z836WLlQSnzCZ5unuYrIgmf9eaJ6XxF8kxePDXpT?=
 =?iso-8859-1?Q?5Ea/fNM7tS9gEXlw1tx1JcF4Ng33ugDlI1Ji+4HMF9MLIU7dZshraeQ3ts?=
 =?iso-8859-1?Q?dyWJvZtiyI4apvm5SOi40QTv9oBBSu4I+oLOKbFWH3vGRmxyz6VJssqGht?=
 =?iso-8859-1?Q?ZBsiRbkUaHCygh+dj/efDrgwySx8MJS065PylRGAhA1NXY1/fnvs/8HWEQ?=
 =?iso-8859-1?Q?UN4N655BlYcrV1L7fYL8Qb8sd/bqHsysI7JoNv64RZ2pl8LlYlyCoLTDai?=
 =?iso-8859-1?Q?BMfv4jdKJZUsW1GM+YF6RAeGA68KiCFaGJ/gpl0ji9wL/2wnP2a43iHvCH?=
 =?iso-8859-1?Q?uWztptVWRRAsbKf0Bal6b91vEwd3GEu1JSMroKnUOWc2OK6aYyLku/EaZ9?=
 =?iso-8859-1?Q?dfsqWORYkR60tRR3161dt7oclFhqQhVI2AZ0Y9aSWMmormAbvDrPLyyBVe?=
 =?iso-8859-1?Q?QC01Hr0PgzjT6amxLBb0yiN3HQHvl+DklP0d3xoKpU7A3qohu74b5lRUOQ?=
 =?iso-8859-1?Q?0l99OW/PjMhp9TcOcOpZI1cA13fgddTrrVixAHk3G389b+ETFRAdbs1/kN?=
 =?iso-8859-1?Q?CC/Dwg3d7AlhkYUsNZDgUyrtk8vou3zPAhhAON7ZkeCwEma80M1qeXCoPp?=
 =?iso-8859-1?Q?Gy3bkLYzEt6I5yv7kZeMy/ot8sxiSjLcdgj7mYTLxPP2Z83TZ8T/F8QTOa?=
 =?iso-8859-1?Q?Rx+cdeKH68vScocMTGTXH3M+Pa7HZBXfAiCle9pKxuPfJdeakiTCjLKdZ3?=
 =?iso-8859-1?Q?PKYWdKAwG4M1QflCY6YgBmbXa5gkTFpBxoHPReZJ2ZASGiaS6QvGBQHk5Z?=
 =?iso-8859-1?Q?UNj7WbwyytkrPuLPXpfbcPfnOrKW1L/jVeLiBr/foZ8NIx3h9Ahn+AoVsY?=
 =?iso-8859-1?Q?DeRF/OZcFp0j0d8eoQZjml6SZoWTm90xgw8Q5xarQYGgUMw13tbILQhjfJ?=
 =?iso-8859-1?Q?w1iR+LewmodHZ7M7rfSMs3GppSekA6+ZJE5Hp+e8ZWNEyA+Tl3Aiq+Rm9K?=
 =?iso-8859-1?Q?IzTbntHB4iCtKYnxpQOzMlIWT2umhwU=3D?=
X-Exchange-RoutingPolicyChecked: pNnfRvzbPDu+VvYpiEdkfbH2p0A3BPWak5zwYtl840Bw0edDWHhEjGh+MQECNr/KeW5HNsLCEVUS8hhq0BCxyUxMuZO9997n8RKy68eO6uZLoTt8Rn12UhTFZyMCRG+lyTUa7gjsAyfq7FfulNVtqFj9gxX6NzS1JtW+c7Ulvc9xZdpBTRT1obdgZPwE2d6+Pd8d0atjotQSep766UHlr2c0payV4tkyAN03WOkdw9CJwEPObPa6P1l3FS6Po9Abpc5YHYjWuadA7u9TwAQKqnx2CpJPtZBX30OP4IgXWnBnKYsgW4KN55vvDAS4SFTZyilJIzn0vDlWpYx8xvToSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d6adb5-0c53-4a66-9ac0-08df09f2e532
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:38:14.3132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ9qXwTbrWCQyjLo9njOS4+iX6uX/UTuSFzjj72tnncKRFJwzBkH0BtVc6QsMpdghs7WJMZCy0WPEKNEc8Urwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9571
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

On Thu, Sep 03, 2026 at 03:27:55PM +0200, Christian König wrote:
> Hi everybody,
> 
> The idea of ref-counting dma_resv or ww_mutex came up multiple times from
> different people, but so far at least I have abandoned that as to
> complicated to implement considering how widely used that object is.
> 
> Thanks to AI I gave the task to refcount dma_resv to Claude Sonet 4 just
> to check how horrible it would look like.
> 
> Well turns out that this is actually a cleanup we should most likely aim
> for and I'm really wondering why we haven't done it like this in the
> first place.
> 
> Not only resolves it a bunch of issues with dma_resv instances shared by
> multiple GEM objects (we just recently had a bunch of patches for that on
> the mailing list), but also allows TTM to implement it's delayed delete
> handling without any zombie resurrection or similar hacks and DMA-buf to
> have better contention handling on map/pin in the future.
> 
> v2:
> 
> This patch set here is now the idea full flashed out. I smoke tested it
> with amdgpu, self tests and checked everything with kmemleak and of hand
> it seems to work.
> 
> Patch #1 introduces an interim allocated flag to allow switching users
> over to the new interface one by one. Patch #10 then removes that flag
> again after everything is done.
> 
> v3:
> 
> Well distrusting Sonet proved to be correct. It turned out that the AI

Drive by comment - I generally find Sonet to be very bug prone for
anything beyond simple tasks isolated to perhaps a single file or
function. Multiple times I've started on something with Sonet and it
continually makes mistakes or misunderstands the arch I'm dictating and
just start over with Opus (or another flagship model) and immediately
get better results. This series I believe falls into a category where
Sonet would get things wrong as it is a subsystem level change.

Matt

> missed tons of issues. Most of them are hopefully fixed in this
> iteration of the patch set now.
> 
> Sashiko-bot on the other hand proved to be extremely useful. It not only
> pointed out tons of stuff Sonet missed but also a complicated pre-existing
> bug in i915.
> 
> The first patch in this series is now fixing this i915 bug, I've send
> this to the relevant mainatiners separately and only include it here for
> completeness.
> 
> Please review and comment.
> 
> Cheers,
> Christian.
> 
> 
> 
