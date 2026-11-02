Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25580606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KWDOIfjK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954C510F1AF;
	Mon,  2 Nov 2026 19:21:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77EA10F1CB
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793647277; x=1825183277;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eqQI79ewcrF64lM6J5LDgu3FWesfHK2AXwru7T1/X0o=;
 b=KWDOIfjK+wC77E1CnpPruHRClEIx0DoCstLpSE18TjOkElVidbRNjaMm
 Bj+9GQ8Vk3vNjIEZTIEiODj/7b5cw/i32mO3/HK5vYKHLuhveSt8CXJtV
 Kj2KmSZim1p3RsxW058YGX/A1I5ICRq3qk+KJBT4x0c4yk21H+BeH6EHx
 +7VZg5E/oRAwK+fROn2RDw1yGt46WAnlFaF8l14UbfmDHRCzdJffac8iS
 deZshB2RtXhqf1hNZ7sKZVDV70AK3KnX3S1RSuVhV8QxddZt+yfA0pugZ
 Uz4P5MMgkXNIJJzZtCkH2B82rqZftYAf/+idjWSQqR67BfpLVxUAQKE3A A==;
X-CSE-ConnectionGUID: zVf0h4CeRv+M18fg/njGHw==
X-CSE-MsgGUID: fccj65KAQfaVLgBejm2Dzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2384154"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2384154"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 11:21:16 -0800
X-CSE-ConnectionGUID: mcvDM+S0QZmQHj2siRttUg==
X-CSE-MsgGUID: dKd3nNxaQ3SxW5WiskBUsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7982635"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 11:21:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:21:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 11:21:15 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:21:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVukEB7ViQp60vGGUWU8pMejqk6k1Jzpb3t4dzAWJM8eD4l7eOU6OM+lNxNzcdTpq6FTT3EcBZhmHEUHHCbMJ/xSyAWqIMtUObuQmHVgqzNXGN00u8/mOdY8zmOQ8uLfaLI2TZ8rdtYBKIDqn6uMr4Jm78+hl3AjeKoS4Dh5CarQ6s7ZX35rCftL/p3T+vjvFLe5juf8O7QLniKQmfgl0WfLU5m590rpvUtkHCEVDXkxz/Fb4lKJNbJFRhPur5zqeI7LqTpJ/PZFaCPXqByYvxiQm0KazJq6l8+6W2jP0fsqkXZCe5C1NdF5S8QUYFbKXMI+NKQe9YTFobPSbRA0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRo7uJ/EtKMiYaQhJZRFOjT/Dj0QKFkSaBucrgjW6NM=;
 b=NaniL4yR6wEPY5R3e2NpRQBmzFMMGfli+vetvK9PexJtVwY61J3M5sJ/JQ8d+p+JD5u8mNkYNGJbEtYDZr+Nulb5jBX9PY8IBe/izOZriT9Z1QxggRAefA7BGTaOfje1uXasQMEWH8uqUKb0Lv7btdA0N5vrABmWAP++zG93FfhCwiH0VvWx0qwNbdHHTwX3F1/6MV6QZoT0XTW9bpd1ZKJ68EJBDSHyaoP5triM4kLEIy84kRI0XoMXgeXmbTwEDsFYBnzgzns9HNiE71ryp3NO1CjSATfHii33GWTB0zCIknu+/7NE4jbpHg37CZYREaqwF1a0CdT4ruoP2jK1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:20:55 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:20:55 +0000
Date: Mon, 2 Nov 2026 14:20:49 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, Mark Brown
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <aujikV14tF6K1Xqw@intel.com>
References: <aujZcJBUyQ7iX_PM@intel.com> <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fdb0ee-77c0-4db8-9283-08df39166a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|11063799006|4143699003|5023799004|56012099006|18002099003|22082099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: k40hOXwJUVPqOfyqLrTfYNNQdd7b/iRf/MGm27zf0Tdl0dsPGAPjHYT4pxbOrHM55yCKjX8ZfqLkq4ap2kNGpc6Xhwl9mR4OSfzgAW7gVnYIEzNb2tjuB5bynm0/vX6gb4ptCAf6BPcY7HCEaSVK4YxUhY/T6ojtnkS53Z0T2Uru58npY0XfBpogqz8Njt3HxbOxgI8aovUuQ6fa/HSSohkpnPqBUQ5be2r9tMZ/MxAl0JY1C6RIPtc64rl4xGIfYCsy1RWBxcvbFNblKYbJDtFtHDJqshWpYIw4rQWOHnQutmcKPYU24kgtgysrtBkpl9igYqGV+FT1rbUj3d/KSVr6hXJ+2Og6B8zENhiVe01u5zg+tAeHVO3oLr6WU3KB7PJmkZsmPkwg8KxCaSKmQeNP91bvYFnpk6OWE7whncwed3tWlDDMBQDTgXeJ5jwLjIVYPKqzUxV3Vxiue2Oj0fsvDfFhMVp0XCzn22vppoJgpdc/fbI2E9Ny9wU3/PqM5BAlgauhjIoWogy9mxkI2L5PjHX/n+hSsALG9Pv6MnXJtqQTEoKjlChQ8WDvx+W/tiAAr5WDqHVHA4aOnTFhR0sIvJ6WUrLhTr5R3E0G5Nj3nUlcrtpv0u8oCiW5iY9umWWvMB8hFx/jhhpvxd7gxuKezhx56sNyim0jYMaxk+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(5023799004)(56012099006)(18002099003)(22082099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jO6m5GRYh6McfN1KpEwzMi+3/KjUcXYAbmw5LMScJHPdUQszMV5tSk5MgfWs?=
 =?us-ascii?Q?zzHBc+uLKC7G9yk6EcVHn4UwrTWcvtB0Rtop/EU7Iz0cZDPxX/Pb920JFu3k?=
 =?us-ascii?Q?ucaDgntg0p/uC8T41jATQSiH5MNMzRo2FXVAboVIx/Lf4fsgBbX2EqKqA70c?=
 =?us-ascii?Q?Ox7oyujR98RD0IHiZIFk874X5JYArcIGQMIqkU2gRJYTGbTDo6aA6+V2yCuh?=
 =?us-ascii?Q?4OnkWkxCq7d9TIYI4DzD2flDSS91BD0YsOZTzb0WJZ+fBO4KR4B7/K0uFnK3?=
 =?us-ascii?Q?GE9Z2W336DZCXLAPQsZGI91RA4DKePWIetsrEYzW4CRZkTyZBfOmoMtBFjNa?=
 =?us-ascii?Q?Jye6WBvYcJqwLWJD3Vdgw1y/1q+hSJwXH7tuEY5SwMsUx7Y4lBB7QZCC8a2x?=
 =?us-ascii?Q?AVWZ7MPIct2ivuX+uL/i9szw+b8HnQU4h1zH5JEBXbpffAvBJDDtUloOO3vi?=
 =?us-ascii?Q?p6cVunWOsYkGwHQDX0Rvxw5wmsVt4K4QDktp2mwXQ6yc0pqBAIixPcSwzP4O?=
 =?us-ascii?Q?gU/AM+8f3UEOeRWXeljbHCICu2jnADeXR+C/FAdgzV7T/W7W2hPSpuCFp0fJ?=
 =?us-ascii?Q?PAl1/GMMwd3WZTdfqRcI9BLjyKMyUTreUNlhdsD+A9EyShR6OqUYqCHEIWnj?=
 =?us-ascii?Q?HDZKZtngR0gsJauLYMG5u4B55wY2QuQ0JKP1uC/dku6As6E6djl9IQvCQWnn?=
 =?us-ascii?Q?d8h+zxFBn5+NI4uYcwTxkpr8lbAIXRm5w1I/JdSK3k8J8KVNwFamd94eLuWD?=
 =?us-ascii?Q?fA3eFir3O/2W7JalfCd9lJftzCAe/MZ6wESKBMbH/3qhLFpvQiHMzSPHP1OK?=
 =?us-ascii?Q?TRlnorIdmENNWAadYrpIye2B04QrbrxZPo8kyZeSj48uD4+Vxq0aJVaBDGn/?=
 =?us-ascii?Q?01r2bZ8UFuNJswi72zPxLy8CSOJfpJhCbF2WJqKhfHfhmtO1hCDhKZUrP9bR?=
 =?us-ascii?Q?/oOQ3a5OpVyAsks+UEqoZwQ5GBAw/dQtw5acAlKMsWsvHHiOwkereYCsnnug?=
 =?us-ascii?Q?I6lixNmRcGMBd//qFDvazqVvsD2WUiAWSdMmSqOgqZ1Xm1dMghq7JRb6CZQN?=
 =?us-ascii?Q?XzhuHj6VNJRDLOJ80nG3kDYvaFl/rLsu9ZXY9g3NP4iYQP8+oPs4bdLvCXph?=
 =?us-ascii?Q?WE6f+hIvy5QcXXLo6Pu1koZetcSBsD0XD3NMdb8E4mJ/7vfit1vpRNKp8THQ?=
 =?us-ascii?Q?59c1EgOVR+Z2hXP9KuDokM0C7YBB8uTl9IAV+8E4rCO4jXtywV9YsuJlANB1?=
 =?us-ascii?Q?XVsvaxOgwr0zSIek8vP1atz3jbyX9Soh2npKlmMn2JyuQhw/5Dj8VL+K3SxZ?=
 =?us-ascii?Q?huHbO74vz+qhzXoZ0/HcnYjlKbNKpX0fUdIKLuTrGY8cJRl83G4sg0MlWLbm?=
 =?us-ascii?Q?OJpwHZIw+b2KX0TJgW7YTXSeC34c9EpozJZi5116UPcyg1cjh8hfmzZNRTpC?=
 =?us-ascii?Q?B/cGRs01oOTqOF2shawqAJidXCJ8tIKFkRGo6db0bgcM8se0i/pl0rIWKtAJ?=
 =?us-ascii?Q?tH1MqPvbj/38oT71adLYUHVrXqUL59+UUYLtHd2QDMxoxyJlV7i5JuayC0pl?=
 =?us-ascii?Q?upC5cRXd4BKt/rYhs4ShYs4azpP9D455LBM8/bQ5GwHgEILZiTrZYgmCrTva?=
 =?us-ascii?Q?suLfAB/cDxoqRIxKSIK4Ahpioj40naKvqtPLPZtS68b+4lcK4oWk0SId5DO7?=
 =?us-ascii?Q?7i5EUIdAbaWVeYcgNuA64xf/uDukV9GGFTCogYjhuPEI9ECPVjUldWJ/ONn6?=
 =?us-ascii?Q?uo08Ff+LLQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: rouss71FpsKTjgC0qmDGlRqOgVdZg3DBGGeaVp6OLwaGMrrbXsZfH/zGfB8l9PcL0PlyS2Fk+WgNaOAqRbBjgMgDdg6c4iB1AmrCDdE+wSm9gUC9nc1mnAiPVuuNXBJktKwUq8hrnJ9gRL5VdSVogWEzaWtVt1yrg9rT6h/FyM7MwXcqzIBM/IM3tPx6+iv5JPjWknrjRoU6o771egwMtF6KZayu6eKH1F920hS1VeNUwbp+IJFD45pYgJAtRLi4JnPH6Kzp479s4FYCgVVnB0xcY7cnN2DvF456WBA+I0VC0GizZ9Dt9vIpmWvisGA9j1rNGUOXGrxVrxhuO112Aw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fdb0ee-77c0-4db8-9283-08df39166a8d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:20:55.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFG8qG9lZ8H8O7xgSoyybVEaB/6Vyl+4DWpxfYtfFK6Umff+sjol/kxVPf1zmpJM3lKPdKpR+loT2teLSK3g6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 07:51:13PM +0100, Danilo Krummrich wrote:
> >
> > The unified branch is rebuilt by dim together with drm-tip. It has all the DRM
> > -fixes, drm-next, -next-fixes and driver -next branches merged, with
> > the conflicts between them already resolved on our side. From -rc6
> > until -rc1 (per Linus' tree) the driver -next branches are left out, so
> > nothing for the following merge window lands early.
> 
> Seems reasonable; I assume the logic for individual trees would remain? I.e.
> -next goes into tip/for-linux-next until -next-fixes is fast forwarded? IOW,
> trees keep control over when exactly -next closes for the upcoming merge window?

Well, the flows of -next, -next-fixes, -fixes keeps the same. No change in that
or in our PR flows.

As for the mechanics of the closes, I'd say that for drm-xe and drm-intel, there's
absolutely no change. We consider our closure when send the last PR on that cycle.
But perhaps this was anyway a gap on our side?! to ensure that our -next-fixes are
in sync with our last PR?! (plus the gap of xe which was feeding with drm-xe-next
directly).

For the rust and others, the honest answer is: "not exactly..."

not exactly... The per-tree check goes away and there's one global rule:
the driver -next branches are left out from Linus' -rc6 until -rc1.
But this is the cutoff the drm-rust docs already describe and used by everyone
anyway.

So, the maintainers are still in control on when their -next is closed. But that
is their last PR. around -rc5/-rc6. And if they need extra PRs after that, it
is also fine, because drm/drm-next is still feeding this unified for-next.

So, whatever Dave and Sima accept during the blackout will be covered. Regardless
the state of your -next-fixes.
And, in any case, -next-fixes is always included, even during the freeze.

IOW, when you fast-forward drm-rust-next-fixes at your cutoff, that content stays
in linux-next whenever you do it. The only difference is that drm-rust-next
itself stops at -rc6, not when you fast-forward.

Thanks,
Rodrigo.
