Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B25606A334
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=khovQZ6B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627E410E281;
	Wed,  4 Nov 2026 17:44:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC0610E281
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793814293; x=1825350293;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6RQQJAcMkzm3oPy5wGV0ef5ITx5LYyl14lYQ1hiK6wE=;
 b=khovQZ6BSyFL58dgkOEfe1NzKpGSP1qcNQN0fsg3CF/TeCtP1hEmAvLI
 D8xpQs2/4KKPJh7S56yVOYKkfohyIWRusQ+Y2y5xaxoZLHrJIFIerIY8g
 IpT9R6r8FHYpWW82wzTnbpm2D1uApHlSmdvnUUtT+ahyMI0T34as20ZTm
 tU29sQwkuZE7VpiG7pDpX9t/3vpFlAD+u5l2AUv83xN2yAEc4Upmcy5nY
 22aqp45Ib8kN5Y4EXgPXVJYU6v+E8oQ3FDUD3dBVoy26j831lOCnZkIM0
 WMgvZgxFNY8/Xs60iC44gMqRK8VU/pKvry2zA7oLy58GlvGS9M7N7EPcv Q==;
X-CSE-ConnectionGUID: SSYUzALAQyunCOPbMwlQ4A==
X-CSE-MsgGUID: 4yR0pghuRZeYFM3Tr5bofA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2583404"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2583404"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:44:51 -0800
X-CSE-ConnectionGUID: TnLO7JySRROT8O1mbzZabQ==
X-CSE-MsgGUID: xXDmdqrHT/2pNga5B9JA6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6929848"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:44:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:44:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 09:44:51 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:44:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTLdKJbBoQw+3HUbXXS2bon71D1cksLi0X9HJtwV6UJxRCp9jVFD1o5ntKHlxp2IglxAekez6TmJ8sovAjLQflSm3iT/qL6eBPXVuM8gtddeTmHMo1trFIS/qn4/+4qKWDdfpW+pr9OTwi0LrnN7NIAHAslm+/Yr9HKUEIivezbClDIuKp3Ga6wfOzMP9b6RQZNocvm4c2R4TdrbwAuoPO0n6/6hkoRHlncXDyMCfAYQUNJEMiY4uxM5MY4LmJKPRDb71aJomEi+Z0qUx0K+zJb9gwE7wQJJH4vtKOZ8HNxKhtdiT1tOAX64lpyuuMsLCiYgQaUmV6Xe5nr6OLT30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5X4a8jXsbkCDTXo3oTml3CbzW19JsFnGLD8mFW0KLI=;
 b=eNVm++nRe26BlnttBfTO7CztpvdhszzFg3u29xwRj59LOkB40oirfcnCFQCCwHr71tEv1tPkQt8oYxKfmdX7xRmIeFMhAwfK52vYAHdj9hSkfXJT+u3bAt66U7cWuX9qUBEuiutljkIVenbk2UR9nXIN/QpTedPUUilqMZM9OLB8/9HVdLNZjP5DJI+LsRfbwU/LrKzVN7oDu442wtov7TcmNAvkVgRO5sh17fEDWqcJlCD7QXsxJPyKBw/qyYEtcG2PjKfg0mrjnkIOZvsoBbsqQiLP2NzoH5iwaMuas+DMLTjWijo0puPEnrbC0VD4S+uyUmyHDMEXuZFmYAleFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SA9PR11MB009530.namprd11.prod.outlook.com (2603:10b6:806:a5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:44:49 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 17:44:49 +0000
Date: Wed, 4 Nov 2026 12:44:43 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Dave Airlie <airlied@gmail.com>, Alex Deucher <alexdeucher@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, Mark Brown
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <autvCxZuSCxFjtgr@intel.com>
References: <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org>
 <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
 <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
 <DMMDNQ0GD6AP.6HPRG6JWUEYQ@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DMMDNQ0GD6AP.6HPRG6JWUEYQ@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SA9PR11MB009530:EE_
X-MS-Office365-Filtering-Correlation-Id: 6100ee2d-1e87-4eac-0dd3-08df3a9b5297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|11063799006|4143699003|56012099006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6qcfj0M3hxKszjp149EyNiXWKE6fvH4iL41EukGbaQb8f10RSXfNfuKePQUx80G8cxHJVlpxUOpnBD4YriRi+x7WifompULHPjecO2CTIzjux/3wnyG59Hmn+v7T6Iy856S2//XevZXyKN5omvNq5nRBMcbiKevzNh7GoKpHpOvBl/KldYn123s9rt75a/N9dvTtVBKvHLGFPmocToXm/FQMgiwLFHeexcXF9zIAFUV7htDZJa1BpUNlMmj7Jk8yZadMEd/vd2fJWaCwu1o+kcLYlVFQsjg49ZSd55Mo/7OL5+2FertWH4gFSgtj1VskbcFAKHS08jI8lvgfc1imD7AHV7Ol1wga10P/N6/it+Xypzz7xhgx+JbvajdnSUpMzL8GgIBf+z16i+MyDynN8fVjvciVR3VtcAgYHFGCHP5zNolIlgG0v1PDge94MGvsgDzDuUevwMJ2LutPdDNFBbMhfL14Sb6UxSMYBimgQc1/qyKSortttJeiMnutH5/UjLmOe0PwBY8bnNuSuTMJrCcMJtyUZ0BfeTEf1kiS78jLChllnqTGZHB8E+f2eguMdBWKV+VXXbxxkNX6GLO5sO6vdzcpbD9dua94BS3VRyUeHyrivSbousqcovRPlsfcv+OSATW0+nMm/6EfjV3s1rhIb+/k45QVqUx1JgXA/90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4eCTRg9LFV87CJKUnvlFmi5thiwGme+SWigE7FKQDHi2+EcBF+YP8skTjpX?=
 =?us-ascii?Q?7riYMBYuRnykic0juvq/coL7mRwHpZuE6Ss13k2sC6TNOFq7pNGXbpOaKQOt?=
 =?us-ascii?Q?wrwBVHLecyBKTGwqh7qUI3DPlZ0RiZps6316gMb97qQfJhlFhyjVsabkEfjB?=
 =?us-ascii?Q?UHIDtUTjKfXjWqj7E4/Kpqbc6HKkh7kk62cDyPa7gVByVcfjggDwBcAaD1g9?=
 =?us-ascii?Q?+zVXgXS4LuBiHqe8RAAjKRzdmBmfes2tRiZZIUEC9xvADEBognCGFdLJ1Z5n?=
 =?us-ascii?Q?TEglV0Nar4mcLoPmYaVMfg1J+m59zmd4B1kviQOwF1LVq3wg28O8XK+i2Frm?=
 =?us-ascii?Q?80FZjvfBZ8aa2hjN7olrsrEQr9vBeuQZMd8IZF/7AR85cLQjypxcOIrWXGKI?=
 =?us-ascii?Q?Irv0O+7QYerF9UycVt+k3tq8BLOE6z9k2fujd5Ig7qjZ9nO6x1BXmZ1hkA6T?=
 =?us-ascii?Q?QvcJHBre8kT7bNQNXutWQ+7bEGKW/GzY+8FEZ8jzddiPeNGxlaadFPr8On+O?=
 =?us-ascii?Q?XcEM7oJ/mklkd9lYR8pX10CU/E6oS5tCLmAqe7cSdUbBtPmQbfpYgf+vseO4?=
 =?us-ascii?Q?Z4Z4K85rlEwB1XPgbPakoq+BiRiuBRSF6rCLROhb2fS1+9sPxLxoUyTKOiHH?=
 =?us-ascii?Q?IgUtlBobOg7G3w2gsvKMKLKCLiOb9QOAbe5tbfe0y8It0QponSamFzAhZMwp?=
 =?us-ascii?Q?EHcCfpBkcwLLcbiQ4TI1MBBI5Qyh4bZCCnB1Jxpq+wVdNh4fYOnDIyal06KN?=
 =?us-ascii?Q?7Oy/LKi+tGoGDk9R/jpWWfpnFAuy+aP4luVSgv05A5y+yCm8zhV9GKC1jgtW?=
 =?us-ascii?Q?mouW26ZeZ+O9i2WbtnX7OnshoZxtSpO2qOVJeQSqCKon4kTtuBjBmTwv3fKy?=
 =?us-ascii?Q?n99u6re/BOHj1Y9DI0Af1BwV3UpRHx9zFp0IByJ4mP5jKwkiX1luYvmFWp8z?=
 =?us-ascii?Q?XS8xwTGCQ4tKeuLsQwoJCe1rvSZ0iE0z0jVO42HBcdjwjqtjYGcqK0QyGHFK?=
 =?us-ascii?Q?9yC+mNToAQcbGznCtZNhfNEPtvHoaPPfz4Wc6nClsbSQEBuv5B2ntRy82KFl?=
 =?us-ascii?Q?gTACYEU8s1Ywdmt2UPImSlEmGwJtNq2X666NeDrFo3LB4j4WV3evBCmgPCFH?=
 =?us-ascii?Q?lirBlJi6J3Sq8l7s3DFUB6h7mtV5vPJYtnt/8R/eJF9dCNRNrYS8rGveAz/T?=
 =?us-ascii?Q?oMr40LVfNGS7b4OfYNDU+ffQJ4t0rRHQ3ri9NmkIoOnbXeF3e39W0U0B2YLt?=
 =?us-ascii?Q?ISG/spM9kDvHRNbnNyhxkl8h0j7C+t4/wUG1+ueDcZ1mHgJOLOy4oWHC3RtR?=
 =?us-ascii?Q?QR9zgQnjb/L574NT+Kk95rsZ7COHRMJq9HKQF4M3gRGmGT4ZceAs9TUZTcUG?=
 =?us-ascii?Q?NV1YfQpfzMpEY4Hjm+Yk5+1Jj8VlswLZmCL6B0SBkUfwIa9eUPylByRj5495?=
 =?us-ascii?Q?gBcyJurw5CbFN7bOhxQlDYZqOqVBu1W8AyYcNTyw1JyzFlHxLoq0eu72iHkG?=
 =?us-ascii?Q?7Yfe9/v4RuhQW/45a0v1F92zfI8ilglgk1qqpdosyClH+Uyk1BvkJsi93wqs?=
 =?us-ascii?Q?JHKTwkBJ/sm9OPVTdXaFH4CeI2UmvUjmW1g9CLP1hi7wX8oube4f2lqQIVG/?=
 =?us-ascii?Q?scT3KUoNX3RYY4t8cquALVcbeYoY8637d3kOtGw8cpiW5scr/LoJxS9o1+y2?=
 =?us-ascii?Q?8exYJdisVxVeQ20OcuIqX+xDjW9QrNxsMSgUKZ5zSPwE2JF9xOfYrzbQhrN4?=
 =?us-ascii?Q?onD7JrtmsQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: O+aRrEwdtXwJCDfrYZlmWiC4PR0AjNIyrS8UEc1OCtTGlbB+EsYV+HJh41BI2wRU7fmJsLqOjga1g3pdT1fcg/hS/P3f8yhHz3wUzh+99IMYkY+Agex61m8mGyHUTomDNrSl/EnuAw16S1ccJIUzZHkjk7AIXs6OHP9u0rtua99MO+54+oxKN+pg/g5yqJ8gyQkPlXkcfAEMqCkG7ZbNVCt/g+63emT74x9ZrnoYaMggvKUiI66xnben4jcMdR8kJxehpsDRBe+C7ifcIs2LaEShOCH0iVYhBAr5i4Xlj8OveOVpCVeAJHzAscVGFClfLnaJCRhzEeGEUvH0G4xVZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6100ee2d-1e87-4eac-0dd3-08df3a9b5297
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:44:49.2503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZAGf61btDaxiObrdV1wEu9v2QpIXuEiKypDKZEwENvjPwdwiNlVreRWXRpoIfWd8x2Q44AIROGaf678voS2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR11MB009530
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

On Wed, Nov 04, 2026 at 12:08:08PM +0100, Danilo Krummrich wrote:
> On Wed Nov 4, 2026 at 4:29 AM CET, Dave Airlie wrote:
> > Yes this is the thing I like, while I like maintainers having freedom,
> > relying on them to do something manually every release at the same
> > time doesn't seem to scale so well.
> 
> I think maintainers have to do something manually every release in both cases.
> 
> The difference is between "everyone has to do it at the exact cutoff day" vs.
> "everyone has to fast-forward their -next-fixes branch" (which to be fair has to
> be done in both cases).
> 
> For the former, a tree that closes before the global cutoff can still leak
> following-cycle work into linux-next.

On that I already agreed that we should move the blackout from -rc6 to -rc5.
So, the only thing that every maintainer needs to ensure is to prepare,
at least, one PR after -rc5 and we won't have absolutely any leak.

And I believe we are all already doing this anyway, so again, there won't be any
special thing that maintainers would need to do to ensure correctness.

> 
> I.e. the global switch is automatic, but doesn't ensure correctness by itself.
> In order to be correct, maintainers have to do something manually.
> 
> So eventually it comes down to whether doing the correct thing derives from an
> explicit operation (i.e. fast-forward -next-fixes, or just add the --final
> helper), or an implicit commitment to push and tag branches on a specific day.
> 
> I think it is better to derive the tree status from its actual state rather than
> a promise about that state at a specified cutoff day.
> 
> > If we can't have the tool enforce what we send to -next after -rc6
> > then it's going to have gaps.
> 
> I don't think either option can enforce correctness. The difference is that one
> approach relies on a timing promise about the tree state, while the other uses
> the tree state itself to make the decision.
