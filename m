Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C42AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A24410E092;
	Thu,  9 Jul 2026 11:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O82Ilyws";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C63D10E092
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783597572; x=1815133572;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=sAVmwdugtQTMm+a/PxlbgsKBqWsL0n+nGzBg7smUHyw=;
 b=O82IlywsAle++WpiXwgGRRf0z6/6LaJ+ajS6yq8qhMSioR0DlUKAd6v5
 qldgQakVfRx+nU+ffNCCpDMygX6I40iMDnVj6nSs6BTJwgI/BWobWDHu7
 gqjvYN104QP2EE9jxQL+HGFazKWNDG2jetxqtSWe0Ml/5WihkyV7if05p
 /41PsRox9FU9XCBkaSIA+dqZ/UQSyjDM3MHpWCbXsopK9VEo4RydBjapx
 eRRubcFbk/MyoLfxLZLodV1HEaSXqgdqK/Y5KSeZwhKPkvcEQa+iOgHio
 NDSr5cl3MU5liNZE9hJTpVVqlp5JzGbNQQbwGQF/88Snp1fQCOcyGtCSO Q==;
X-CSE-ConnectionGUID: goHaSyW/SYWvOMC+hTbZDg==
X-CSE-MsgGUID: G7O1aWwNRBu1H1xvSO+iJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94922156"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="94922156"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 04:46:11 -0700
X-CSE-ConnectionGUID: pogzGyHgSz+IEqAz/EH/SA==
X-CSE-MsgGUID: V457qttpSLWYDWO6np0kmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251201960"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 04:46:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 04:46:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 04:46:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 04:46:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfGtHTtTChF1ailEktSoFU9jxWqt65CnE0tn0kBh4tqaxnbPfwKrfmh5P8t8HtT2L1u4i1CC28dXnHpy/PEnXje5/ASYTiEgrzBQs+NqC7TtUpWTTPaqqvttDxHHTKgHlxvnQKa8n3SOnyHj4VwhHotGiB2k1buVlzFAsdTE2XMHvV5jbZJi/xoOTGJYr+ZAp08fh8IdPOEmZf81jbzb2i3tIke68Gf/TZipFmZEkdS+zt+5j4M9CFiy/DzMrkxOaaKX5EbPyhWuu3R1CfpehBOsMBmiavbej2ZVp27E5W8epjaQ5E4Xak5HDcJl2GJ6hdlKfeGwSbG4Szj4ZrLK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUpZnPvTJ3vfJ3lzh/7obI4sg7phHVZ3o6NuZAZNVKA=;
 b=Qba5cF4Qu+JX2S1IeltkKlep9ddLKqiZZOg3X6ESznmRbJGJHEoEBb/QVaFta7Xu2m0vq5hAOtIu+g+sfCDALDjMD2fuvm0EHfcF/p4rt3Yx0IdY2jptXNIFHmESEnM4CmWf49mx+KURq38ak6hkaTCEHM6vCJhMgjsAxeHdhYwe4+8JZFsy+FlnbEycAJEw+RI6KFvRqavUVMQ/tUhyay5j8Ec5DeP4SMF8lySu7Qt/o2VbLiswp9NJCoEjIZQLQXxzWXdlujFDAa7Q12AwFmKr7ipaXQ6YoRUaefbjtstyZajm396y7wmO3Tjr+iyxyU07c+0RyXMnl2cHFBB5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by CY5PR11MB6488.namprd11.prod.outlook.com (2603:10b6:930:30::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 11:46:02 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 11:46:02 +0000
Date: Thu, 9 Jul 2026 04:45:57 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [RFC 4/8] drm/xe: Convert to per gt scheduler workers
Message-ID: <ak+J9bzWeXkWhJR9@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-5-tvrtko.ursulin@igalia.com>
 <akd7iFDLUgwhj6+H@gsse-cloud1.jf.intel.com>
 <e15d223d-21d8-42f1-a37b-52f515d1e86f@igalia.com>
 <akw2yy1WHW5q9u8P@gsse-cloud1.jf.intel.com>
 <b3c9dbef-d0f9-475c-9b5d-fd8733a3e364@igalia.com>
 <ak6l46v6wT7whkIM@gsse-cloud1.jf.intel.com>
 <38ae2d67-d079-4175-9ecb-5972366ba713@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38ae2d67-d079-4175-9ecb-5972366ba713@igalia.com>
X-ClientProxiedBy: BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::8) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|CY5PR11MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: dae36f49-2f38-4759-df8b-08deddafa650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|7136999003|11062099010|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 4rYHi3miPOIgRsrSP1WkY6eeUAFSJc1H2IMbGOSDwNGza/82p9eGr/+pdvCpYp9tHJEx3r1rm5EwAK7r9orH/AFsMPDLVPdoZG6FBCpC9vo7NTOHa1ZK31mY7pe/vhFaY3Avev35+4zrgSQGOyTAPgMOiEusfZGj/n4ZzmQgp6orMbB4DVmz03OZXbW0w9bgY0QXGRxMU40HqcmtQQ8zhBhF4dwf4oQgH4J8gQmUHHA4WvaCvX8l5bMkH9r4L7+FzdrjDp77CtCWJc37+PxV6k01nzfw6GXBovmqPPTl1Mt6h8hRmNoU2WX648gyx5ELVwlJLJo6oiT7B44U8rCXyl30uv34eWyfbMwSAy1ULA63l7GHZy9F/2yTXC3D1PKDH6OhRZM60I2ngUfFGH5mscuJe3A5KVI3494j9hMwznGqKGGvCZRlpjm8QQU0n+RWqOrDZpibAGe8jxv65LITX/WgXWDnjHTEEdnDQqloYf/ZMxjOFgbNUXmRmO1B6wNYM+FV5SWyditMEj1+iFBwJtyTS8WoOiALSqq58CEmVP0Jf0bouwZXmoW/mDCzNJB3GW6/yyUI2wqQLw6rjEYlLoeo7LCp6KypDiO5pUhH9jOBsgXpI/nlmRI2fwQQ6QRFg1mYtToUjewkLdK3coH4aDxWc+1SpYaqR/bJgR6ELYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(7136999003)(11062099010)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CIaNrE72zYlgLaY8H0vim1Lyt0yGfctbxoFtIX6O4RZiKh/7hwtC5rg+JJ?=
 =?iso-8859-1?Q?aLD0bjw7Q2bXIpulcJyuwcsh6iPhuvKuynfMboKxKnG9h+QtPFXmv1f9UQ?=
 =?iso-8859-1?Q?hzlnpzIcQftrSlkwbLXNfqfKqLX1Xz991cLOztli+tCQyHAbry+auEvK91?=
 =?iso-8859-1?Q?es46Z+FdF8Y9JllYWeXFABepO+5tJG4KqcNMtVBUdUi6jPK4VGyRwLJckG?=
 =?iso-8859-1?Q?L7z3gyr4TPdjTGPUkFDrt77J+5p6pGuSy6N2N6W9IvrkVG1BPrIx9a2nVh?=
 =?iso-8859-1?Q?XOwlc027OArdwKZzB6A7bBCiCxWKOmdZo3zXWS9/naWP97q2Py+cEhWhcW?=
 =?iso-8859-1?Q?aAABxR2B3Iy4BD5UyZ/HACdp4ftsAkzhgGPaBm153cxnacEyZINfKLUfW4?=
 =?iso-8859-1?Q?wDMcO7T1YzAkux0GMA0AS1DG1tmmCRhoRC2xieUWY9ea5TCfyy8uk3mtwD?=
 =?iso-8859-1?Q?H3T6rGWj0Emwr2UFkMb9+O48eHvUIW+AI9jX4NwE4V+vBRipAvDbXnRkRM?=
 =?iso-8859-1?Q?06hKimq3jdN9R0+l7/FjbZUK3b/jagRrliBRf0y3B3n/aek1EOzRZQ6OxH?=
 =?iso-8859-1?Q?6KBW0HTK1fUopqVUcUZOZwpnGuy6UI9387+zxIaYUwzZikLltgYnZWZePN?=
 =?iso-8859-1?Q?EGSyRjxQPe1X4t0hlA9wr1coWElhYclIqd7FmLtdHL/Mp96HXPtrD3RMQn?=
 =?iso-8859-1?Q?Kt/fYoTxcQLrYSS6gF+gptgbfZCDo67kHS/yCjVNNJ/Kvjw3ktWWJwe2u2?=
 =?iso-8859-1?Q?yJENWyrcu5gWcYJhgGhGNCGXnTnW1dSKbtvaJ+R+oBuQVNKtSx4WGRh+wq?=
 =?iso-8859-1?Q?kIP8c2Fd5Tk4h0DLJ7iK9IfMp4o0srLcbmYsdrLVqRWUKmYld+rxBTxPrE?=
 =?iso-8859-1?Q?l6pln9TM5oihay69uj/mHgcmS4E2uNDZlLxHFnNJycm0TrD1gB4j8ydakH?=
 =?iso-8859-1?Q?gP3xqoFvoMe16SLLz36poBqW3WBd0LXRZcb12prSJzrZLAa8gfGcuvmUvd?=
 =?iso-8859-1?Q?Yyfy4ehGeFkAvhuyl9vCrT5EJRRyKZC7Se+AT9gqvHGr7960Fp0Zs74Knb?=
 =?iso-8859-1?Q?Zwc4+9L+BkB/fMRcWjHZfOnJWhUUrwnegGBSFJfn5PmqTf04TL4fFhKH59?=
 =?iso-8859-1?Q?s+pFc50BHlnavMiBipWKGGJeJFRBAcvn90tWt6LfrisC2n/uinpyHeYe2S?=
 =?iso-8859-1?Q?6+vmGokHI4onjmedneqjXadd4BHX8SD5muOXyn3Dr/cVYQCo0/OHezeOmq?=
 =?iso-8859-1?Q?rfPP7x9uF4ZraO1AfjuBdBYJIVI0zJR5HghgozVERYPv/wznz9tMGwCRkW?=
 =?iso-8859-1?Q?RyAF33bUqBe6YppF4aQOUEcBXbflLPfFdWC9C7/rMNMQ522Vehgc5fb1KX?=
 =?iso-8859-1?Q?g3X83ZE0CY561spj29BjvrRRcWN2L219sUvydQLakvZW2xn2tNyAa3tCCC?=
 =?iso-8859-1?Q?JEyFNOJTrFzulGbZ9D+mfcXYDCI6wEigrZqo2y3QJtbzqWq5SVd1qZouKv?=
 =?iso-8859-1?Q?M4W5txwfxyF37LfWgrxKiakkF25lWIf6RuQsLvsRj120rYwoDTAiQeLy0P?=
 =?iso-8859-1?Q?DCRizFxDm70Ty+nAzKeQ8KawXZWSEPKxyPB7Z3BVsKN10pHUWE3vkuxk5V?=
 =?iso-8859-1?Q?Azy+ARYlGa7nyEiCKeOO6a13Se3BAbRZ44uy8Sob3jIQeddd8KIxnbu8SX?=
 =?iso-8859-1?Q?CaetiX0NoJ/DQRMY8JNaU3MizFUzAq8Uq+nFC+XDdHNq4g+TQ66Q5lBgxn?=
 =?iso-8859-1?Q?AQ5FfaT/+1PLyUOYW5adcZEBbLC92fANPrkCIBiq4sJSb2im+sS5FG4wWK?=
 =?iso-8859-1?Q?u67ZXrEJnQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: A5NwJP5QSg6ijsgW7Uyvu/r8DuTyY3aALfiA8kVBzgqswkZbWqc7kMKl5wNKuCLGFi4ij746psZOIiMa/XxYy0+tFLMyHX17YBDUL+h0pLnqZNqRj2I5LL+2prrj6360V0hpMPpKonvopsbKVdjCjPy8cNbL4ZwaCKKgxD1NMU2pbTPV/uXtPpQpSYQcT6kL9xz7Atf2sFpd44aU6ExNvHCjzzJeJhs210+JvFE8hhjrBUTK6K3bFFGOdOtpdjuKx7AzfW8SzcGrUnY2+a+1txWjEE6dL2iaqrlNISjhk1ngeWA39Fz8sTC0WA3SD+Im0fGLCebryvm/TM8jUXaN3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: dae36f49-2f38-4759-df8b-08deddafa650
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 11:46:01.8073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqnanxDu8JDo3RHMVtJUPnn4ls2kqozP7Dy9siKkpNAu6xuJDgVI20Ak7cUeWmvjzccF5XkIaYQ+OyM0N6jzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6488
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

On Thu, Jul 09, 2026 at 12:35:43PM +0100, Tvrtko Ursulin wrote:
> 
> On 08/07/2026 20:32, Matthew Brost wrote:
> > On Wed, Jul 08, 2026 at 05:35:46PM +0100, Tvrtko Ursulin wrote:
> > > 
> > > On 07/07/2026 00:14, Matthew Brost wrote:
> > > > On Mon, Jul 06, 2026 at 01:27:46PM +0100, Tvrtko Ursulin wrote:
> > > > > 
> > > > > 
> > > > > On 03/07/2026 10:06, Matthew Brost wrote:
> > > > > > On Thu, Jul 02, 2026 at 03:37:41PM +0100, Tvrtko Ursulin wrote:
> > > > > > > As the submission side of xe is serialized by the global GuC CT lock, we
> > > > 
> > > > Profiling shows that, without backpressure on the firmware interface
> > > > channels, guc_send_ct throughput is about 4 H2G messages per
> > > > microsecond. As such, the serialization here is very likely just a
> > > > spin-wait on a short critical section.
> > > > 
> > > > The work items also perform work outside the CT lock, but in practice,
> > > > for the non-waiting CT-lock cases, it may not matter whether we use a
> > > > single workqueue or multiple workqueues give the slowest point is likely
> > > > the GuC dequeuing H2G.
> > > 
> > > Yes, and how fast is the GuC MCU vs how many main CPU threads is realistic
> > > to spawn to feed it. The number is maybe not one, but maybe it is also not
> > > that many more. I know we got to this point because it was the easy way, and
> > > I think it is also okay to do something completely different like split the
> > > scheduler better or write a new one. Although both those options need buy-in
> > > from the DRM scheduler and DRM maintainers. End goal is simply to provide a
> > > smooth UI to users.
> > > 
> > > > We're also looking at doing ULLS submission in the KMD, in which case
> > > > there would be no serialization at all. Likewise, if we created
> > > > doorbells, we would not need to serialize either.
> > > > 
> > > > This series seems like backing Xe design into a corner for a problem
> > > > that compositors / RT submissions have a pretty reasoable different
> > > > option (bypass). More below.
> > > > 
> > > > > > > can easily afford to create our own per gt work queues. Whereas before
> > > > > > > kernel could create up to the number of CPUs threads, we now create one
> > > > > > > per GT.
> > > > > > > 
> > > > > > 
> > > > > > This breaks down for any execution queue that waits in a scheduler work
> > > > > > item for any reason. Long-running preemption queues do this for
> > > > > > time-slicing, multi-queue registration, and possibly a few other cases.
> > > > > > 
> > > > > > I've looked at this before and rough divide is this works for 3D but not
> > > > > > long running.
> > > > > 
> > > > > Hmmm curious. Could you expand a bit more on this?
> > > > > 
> > > > > Where do those wait, in run job or prepare job? And on what ie. where is the
> > > > > cross-dependency?
> > > > 
> > > > I think run_job can wait on multi-q syncs if a sync is outstanding for
> > > > the group.
> > > 
> > > Not sure I understand. A synchronous wait in the run_job callback on
> > > something not yet submitted? Because if it is already submitted it would be
> > > ahead in the queue so it wouldn't hang, no?
> > > 
> > 
> > It is waiting on a firmware control message as part of the multi-Q
> > registration process to acknowledge completion. Typically, this is an
> > asynchronous fire-and-forget command, but only one of these can be
> > outstanding at a time because the submission state machine can track
> > only a single instance. As a result, if two multi-Q syncs arrive
> > back-to-back for any reason, the second must wait for the first to
> > complete beforing issuing.
> 
> So first one has been issued from the first run_job. Second run_job arrives
> and waits for the firmware to finish processing the first one. I still don't
> see the problem. Is the completion of the first multi-Q registration queued

If this happens on a GT-ordered workqueue, a single queue waiting will
block every other queue on the GT from making progress.

A single GT-ordered workqueue also limits future possibilities, because
anything running on the scheduler workqueue is effectively forbidden
from blocking. That's a paradigm shift I don't want to introduce.

Matt 

> for processing in the same scheduler submit workqueue?
> 
> > We actually do this in a few other places as well with various GuC
> > messages. Could the state machine be extended to track more than one
> > message per class? Sure. Would that be significantly more complicated
> > than simply waiting or sleeping? Absolutely.
> > 
> > This state is used to rebuild the GuC backend after various global
> > events, such as power-management events, global resets, and VF
> > migration, so it must be 100% accurate to ensure proper recovery from
> > such events. This is also why all firmware control messages are issued
> > from either `run_job` or "alien" work items. After a queue is stopped,
> > these global events have a stable snapshot of the queue state, allowing
> > them to take the correct actions to rebuild the backend.
> 
> Ah so the answer to the above is yes?
> 
> submit_wq:
> 
> run_job A: queues multi-Q registration and submits job A
> run_job B: waits for multi-Q registration queue to be empty
> 
> <Irq arrives>:
> multi-Q registration complete
>   -> schedules multi-Q queue emptying action on the same submit_wq
> 
> submit_wq:
> 
> run_job B: still waits for multi-Q registration queue to be empty
>            submits own multi-Q registration
>            submits job B
> multi-Q  : mark queue as available -> does not get to run ever
> 
> Is that fundamentally it? If my patch breaks it why it is not broken even
> today, if it is the same ordered worker?
> 
> This family of functions:?
> 
> static void xe_sched_process_msg_queue(struct xe_gpu_scheduler *sched)
> {
> 	if (!drm_sched_is_stopped(&sched->base))
> 		queue_work(sched->base.submit_wq, &sched->work_process_msg);
> }
> 
> Looks the same submit_wq as for run_job. Which is DRM scheduler owned so
> single threaded.
> 
> Regards,
> 
> Tvrtko
> 
> > > > > Is it related to the alien work items xe "injects" onto the scheduler
> > > > > workers?
> > > > 
> > > > Preempt fences inject suspend/resume messages into the scheduler queue
> > > > to toggle scheduling state and wait for a suspend timeslice.
> > > > Additionally, if the state machine that tracks asynchronous firmware
> > > > commands is in an unexpected state, we wait for the firmware before
> > > > issuing another command.
> > > > 
> > > > As a general principle, we've accepted that it is okay to sleep because
> > > > this runs on a dedicated workqueue. We could rework that, but I'd prefer
> > > > not to, as it simplifies the code considerably.
> > > > 
> > > > Matt
> > > > 
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Tvrtko
> > > > > 
> > > > > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > > > > Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> > > > > > > ---
> > > > > > >     drivers/gpu/drm/xe/xe_gt.c         |  7 +++++++
> > > > > > >     drivers/gpu/drm/xe/xe_gt_types.h   |  3 +++
> > > > > > >     drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++----
> > > > > > >     3 files changed, 17 insertions(+), 4 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> > > > > > > index 783eb6d631b5..fb2db9eff341 100644
> > > > > > > --- a/drivers/gpu/drm/xe/xe_gt.c
> > > > > > > +++ b/drivers/gpu/drm/xe/xe_gt.c
> > > > > > > @@ -706,6 +706,8 @@ static void xe_gt_fini(void *arg)
> > > > > > >     	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
> > > > > > >     		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
> > > > > > > +	destroy_workqueue(gt->submit_wq);
> > > > > > > +
> > > > > > >     	xe_gt_disable_host_l2_vram(gt);
> > > > > > >     }
> > > > > > > @@ -716,6 +718,11 @@ int xe_gt_init(struct xe_gt *gt)
> > > > > > >     	INIT_WORK(&gt->reset.worker, gt_reset_worker);
> > > > > > > +	gt->submit_wq = alloc_ordered_workqueue("xe-submit-gt%u",
> > > > > > > +						WQ_MEM_RECLAIM, gt->info.id);
> > > > > > > +	if (IS_ERR(gt->submit_wq))
> > > > > > > +		return PTR_ERR(gt->submit_wq);
> > > > > > > +
> > > > > > >     	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i) {
> > > > > > >     		gt->ring_ops[i] = xe_ring_ops_get(gt, i);
> > > > > > >     		xe_hw_fence_irq_init(&gt->fence_irq[i]);
> > > > > > > diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
> > > > > > > index e5588c88800a..175c42672546 100644
> > > > > > > --- a/drivers/gpu/drm/xe/xe_gt_types.h
> > > > > > > +++ b/drivers/gpu/drm/xe/xe_gt_types.h
> > > > > > > @@ -248,6 +248,9 @@ struct xe_gt {
> > > > > > >     	/** @exec_queue_ops: submission backend exec queue operations */
> > > > > > >     	const struct xe_exec_queue_ops *exec_queue_ops;
> > > > > > > +	/** @submit_wq: ... */
> > > > > > > +	struct workqueue_struct *submit_wq;
> > > > > > > +
> > > > > > >     	/**
> > > > > > >     	 * @ring_ops: ring operations for this hw engine (1 per engine class)
> > > > > > >     	 */
> > > > > > > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > > > > > > index 9458bf477fa6..858f84dc8fed 100644
> > > > > > > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > > > > > > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > > > > > > @@ -1928,11 +1928,12 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
> > > > > > >     	struct xe_gpu_scheduler *sched;
> > > > > > >     	struct xe_guc *guc = exec_queue_to_guc(q);
> > > > > > >     	struct workqueue_struct *submit_wq = NULL;
> > > > > > > +	struct xe_gt *gt = guc_to_gt(guc);
> > > > > > >     	struct xe_guc_exec_queue *ge;
> > > > > > >     	long timeout;
> > > > > > >     	int err, i;
> > > > > > > -	xe_gt_assert(guc_to_gt(guc), xe_device_uc_enabled(guc_to_xe(guc)));
> > > > > > > +	xe_gt_assert(gt, xe_device_uc_enabled(guc_to_xe(guc)));
> > > > > > >     	ge = kzalloc_obj(*ge);
> > > > > > >     	if (!ge)
> > > > > > > @@ -1964,12 +1965,14 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
> > > > > > >     		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
> > > > > > >     		submit_wq = primary->guc->sched.base.submit_wq;
> > > > > > > +	} else {
> > > > > > > +		submit_wq = gt->submit_wq;
> > > > > > >     	}
> > > > > > >     	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
> > > > > > > -			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES, 64,
> > > > > > > -			    timeout, guc_to_gt(guc)->ordered_wq, NULL,
> > > > > > > -			    q->name, gt_to_xe(q->gt)->drm.dev);
> > > > > > > +			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
> > > > > > > +			    64, timeout, gt->ordered_wq, NULL, q->name,
> > > > > > > +			    gt_to_xe(gt)->drm.dev);
> > > > > > >     	if (err)
> > > > > > >     		goto err_release_id;
> > > > > > > -- 
> > > > > > > 2.54.0
> > > > > > > 
> > > > > 
> > > 
> 
