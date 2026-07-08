Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C44C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C3010E65A;
	Wed,  8 Jul 2026 19:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BmLKtiQx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B55A10E65A
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783539179; x=1815075179;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=9z/yjfy+Zwrr4uU9aquazXwA7QrI9Sc4sRopOoDRygE=;
 b=BmLKtiQxcab4XNBRK9Gi2JsvBPti/Kvaf+bZyJKfmv9M0+7Wwd8BZ9In
 v2JcQiTyBE2PsPeF7yUEJ4EOmC/ttDBjjOe886OOyxzcz1n28KL81/49j
 E6GXAp7Z6/jKf3qPSXCaSSvOcIRb6tpPZ7Mg8asLGt5+gh2B8FWHL8BHJ
 kmWP6K1SJ6GU6oO9boJdt6IUK4zp/DiGGTh5dqK5stpTaZmXfXMP06p88
 pt3OcXbMx+vX6DoFBvMQHFrPXC0gUJ+N4oMn4ZLuv4CDy6iZSnHUjI6/D
 Ok/FM/KCQnGoSYVtn3nP+0T1l+BRuh0PLZ9Oic68j3UDg/9H5yo1lTR45 Q==;
X-CSE-ConnectionGUID: v0E4I0gXRdCqRkvIog6siA==
X-CSE-MsgGUID: vvdjMkOtSgSMQviwhTzjcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101640660"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="101640660"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 12:32:59 -0700
X-CSE-ConnectionGUID: GUOsyJn5QZKgjkj0kgJtEw==
X-CSE-MsgGUID: 28+EjseoRSy6iF8Su3sYzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="250378790"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 12:32:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 12:32:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 12:32:58 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 12:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9TqJW6UjMqaklEtbfXg0mHxHxXxFz9kvgL/b7VE9R2f6UNdq7h9nu1pF9X4lbS6eS+GodCvyW2d7fq41mWtJdZ9qXzV3AUtzkqFgGYGYo+OYjaqh5wmAdPEHBbaLNMzBI/H7jAEOUJMyZ+mGpKb+OFa0BAgV1XrWCenkDtFxkeclhlJdYWl0elurgB6YQs5WSxG/XSRnmClsx5WTSK2CqqUeTYwC6Gus+Yt1nRnSDMXscFyHydU2YVOnhVkDebe0QI6ckF86CPXIuH/lY8pM6RteVrhXYJ2aI/p7Hnyg8tcdzBbM0ZbTB/uiY+fxWtv5wIta+H/d1BOMuarxOkvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnmfK+EFGMa5R0ONOUW+XdKFcQf5sjm04k3zbDU1PVM=;
 b=AqnpTJetV5OFpi+mOjRs49QG6/Z7LFcheK1Eb+DrptwhXqSDMChv1THFXhfA7rM/o9qJKuW+/7HywhJxVBwdBXsSqDI/T5LGEkEFu9dDYpRF+SzEhz4sVC3L8zy0uefQq8NOwCbo3pskTa0R20x57+5qgcTkyJWNEjWnWHA8opDLx2gEgQVbaVP81+01POfUmbmrDSCcs6LtK7rGa4Tv+1sS2RAb4yS44HK8jWcOfDx695t0HlsdnldUoGB/hPosAwTJoIme5VMeHL1R7VIfHQiU+y3/uX0W/apL4Qji5YCbIq/86oUs6GrjOA8UOXxtV/0txLnnmM9CvjDtoHVBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by LV0PR11MB9840.namprd11.prod.outlook.com (2603:10b6:408:383::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:32:55 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 19:32:54 +0000
Date: Wed, 8 Jul 2026 12:32:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [RFC 4/8] drm/xe: Convert to per gt scheduler workers
Message-ID: <ak6l46v6wT7whkIM@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-5-tvrtko.ursulin@igalia.com>
 <akd7iFDLUgwhj6+H@gsse-cloud1.jf.intel.com>
 <e15d223d-21d8-42f1-a37b-52f515d1e86f@igalia.com>
 <akw2yy1WHW5q9u8P@gsse-cloud1.jf.intel.com>
 <b3c9dbef-d0f9-475c-9b5d-fd8733a3e364@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3c9dbef-d0f9-475c-9b5d-fd8733a3e364@igalia.com>
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|LV0PR11MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 584b537f-fb74-4f3e-28b2-08dedd27b524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|11063799006|4143699003|56012099006|18002099003|7136999003|22082099003|11062099010|3023799007;
X-Microsoft-Antispam-Message-Info: D+E0sOKRedK5q2nsCHxumzeI3sCiOWbcbOy8JrFi7ZQmbmVcecM7MOQYP5tnzpLrc4XFtFR4QoCfqem3BGZv6fEOBmmKvdgEjQwSAG4gFHrwnDijS25AGe1u6rxxZPAITLvchZe3nrjj5sEjft4CDy9+rWHTl7FnGFw2gwWnrCqR3ZqQzifTxWxEvOjSBfTQRO0fnCT9vCFHm1i3X9nCUpkCr+HwlVfZGVVmKyamXOpooB6Yc7VPnTDgoKxj7bsOhPs6VgGTrnMA541SLy9INS4qzytG4Drqm8EvggeXLIzMKvoPMb1Y09SDUZrfZlNdVKg35+pLJDB01NTPReC4t6pyrMCtEj4yDU3Kcmh5x7UKEfnhEfTaV6UARzXOQeKjv61pMw/IqBJznXLkOUIv7TpPvkoGBwbtS++5XycIkV7MTG7rC0YrFgA6uyVZvYb5jJUmTybvhxCKqaxqrtDQVGF2A1gws5SM1RSC7jR3HjqrcwODIUBmWqq1dnmAQ8dNCXhhI3hD1+9jCkHMvAmyBLJu60mRBB8ZfAZiBX+XeP9B8fvMnryLeI/YOY71mfCke642xnDHS/JnE+8MBMMo9Z+CgTwzFwojxFW+No2UYjuwACAtjg1vs14GQxmrjsdQh9QknDXYfZnN/FyIR6ispFiemxu7Vc2c/j7sElQ9Zf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(18002099003)(7136999003)(22082099003)(11062099010)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nKM2W4wctHrSOXoYx70wS9PJMN2wl/ZjlA2chhVnUbIGMn0THdNJdcLJNs?=
 =?iso-8859-1?Q?kB/0hMxDIAvqCTXC3Qn/5LoCqkXtPsKdGMlWiJA9W5/Or0NgKEDbzPjuEb?=
 =?iso-8859-1?Q?lTjdp0dfS6DbFLRapS0K7YoNAybVZyCC1LEGaAiCEFqOZ89ZOs98GPby8c?=
 =?iso-8859-1?Q?L671pvyg/PhuFMTdabEEh3XBt1kkY3HGHNgbi815UHRslX0G2X17DYolRw?=
 =?iso-8859-1?Q?8s8QZpDztR7nlWFbhTTCnJnBupXbTbEphVAuf44FyBjqUI90YkaGw0x/pH?=
 =?iso-8859-1?Q?l9sVc4Nn3TNFJYOpxCW9oAl4Od2t4PsJd96eAv//sIjprWUNXs2Aw4mbv7?=
 =?iso-8859-1?Q?QQG6Tgjsp2LHNtrP/z6OG2bUlVHwjESdpCADEQm4xjGRf+0Fcw0BGHf0XA?=
 =?iso-8859-1?Q?u1hHIi7/IX9pvL2w693yXs6xVRztlyAiPcXh6JLZiLPFD94faPYsTqfHxI?=
 =?iso-8859-1?Q?q9CDtHMxvgzYV9povc5WhA/y74OT1b8ZlIAzNJpdVslX0X8qh6UnV47KGg?=
 =?iso-8859-1?Q?wt9vqj5oApRZnOyk8zp5wgC+5h9yS1p8V2b65KUos4MxY0kMjux7doAelB?=
 =?iso-8859-1?Q?QjuFGtmEjAJFcWo4EE+GaQa1r4xSXF7GkGlXbwO9WOsHhNx6P3z8kzZJcU?=
 =?iso-8859-1?Q?NZnC0zpXNAvg2DyUnDskOJbv24vjWMHhPoZvlXvHvqRmCf6xxXVJb4WFVd?=
 =?iso-8859-1?Q?sLzQsQkzrC8y2JCYLArvKKhzyY0nyjoTobXvyLy9Otea+GsiC51+PVTmG2?=
 =?iso-8859-1?Q?VUQJZJXLhWW+k/OnbNLsUm/0tORvvXdY1Hq4UccggzQQDi6yelGgitvTBA?=
 =?iso-8859-1?Q?tYPnKc8H6TPTQKxsEUhUw4qUxWjj10VjHM4HYfgLG98Sne4i6IK0GttPD5?=
 =?iso-8859-1?Q?mG74r/GiOE58BQYL5fQCMCa1MqnlPE6/eDOnRlBU7CM15OpO3lIzckXARj?=
 =?iso-8859-1?Q?ZjZ9pK+3oLqLe8NnAqwQE+LtPuFnnEosSxQ5lYqx3EfVeqCHfoV/X5Dvzl?=
 =?iso-8859-1?Q?gqk6ajF6zm0gbUOSK8oyL/7ccc8SSKBSIxH29NH+LOBGYDFqkCdYj+fJd9?=
 =?iso-8859-1?Q?fc6AL24De7oEFUKCgiYIUBr6xon1DzQ7wrfnbJy/2CuIkkdKasiVqp6d6I?=
 =?iso-8859-1?Q?sPvqtixlopfXjCobfxRiJC0dlNafKD5q/zaePXziF1beQdWAi7ZrhEL9z4?=
 =?iso-8859-1?Q?MEAm5v+PXAQrqsq9olj9xxi/TCt7fVln4bnlxMs9vgHVrbHKaPXwYFL01H?=
 =?iso-8859-1?Q?9RLTE2sL/GK2RUxOdIypa/OTRmPS30wXcTAHVoY3UL9yP+fg4lcw7jYS1u?=
 =?iso-8859-1?Q?Pt6pOj0qaUWOz/Nxz2J23M194icqReGUAU28Pa+iyIsot+et+jez79JT7J?=
 =?iso-8859-1?Q?pO5OZCTAtVK9GNoUgnjRWdsVqChhjb1Kyr4P/7EVGgLnFk9Nc1WY1FDeYu?=
 =?iso-8859-1?Q?WP+0mHrG0WhRse/t0LVksK3qcxK/dK70H5mZi5MB3CvngX8i0YhyoshGAr?=
 =?iso-8859-1?Q?5qACdTSLFZ1MeoL7gDkOhfs59JkQFVYngT00YCbBV5QeJ0IumqAMsG0xIX?=
 =?iso-8859-1?Q?Dh22fPbGGzL6a3vreHf1GgASImsbp0wrUJQAjay3I+sdZ5Xi/3vK7BGXtd?=
 =?iso-8859-1?Q?o3yRhezXFq3t5mHfnJhiLJCw/TzCOBKr8j5xwlMY/Tl5pdCUU6M9AOkcoU?=
 =?iso-8859-1?Q?TwdYMlTrU4m85Cg5fWTMu+yx4makZZinYN3bs7SDlVDsHamIVBJadNZNFG?=
 =?iso-8859-1?Q?DOIaWa/6EgrUfx2Q03JiHLxbN9Pi4OcmBC0NUwny6V6KRe74yIn92hxppK?=
 =?iso-8859-1?Q?izBtJqyAoQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Uo6VmhUYNwSUMblZNiIdTaRZcRIRqxlEBOEo2MVDEWNCYmEuXAESGNqXXzn1I/t/73bbQdQNmwkUt8U4KX7CP8ZP3O5MArakwHNFce2FxUgR7lHCQWKFawheGQGyVZG567L8y+/uzZQ3y5+3kPNzP+dBIebh1+UqTB2g0bfBuxbH3NcT/GCX3if5Jb1mG5GZ+77MOVxocvbUv+n+9F2W4sEPAvAKcjoaCvloExNRJZfgBAwZBXKUo7/YQpNOc+tokHND9FRJuSQIP6GFsR80+ern4lx3q4VHCZ/RvVknvLGBUwJLoVZmB3efRZnd9Pb5rKAq/5gUNjgD13tDkIq8EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 584b537f-fb74-4f3e-28b2-08dedd27b524
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:32:54.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrPxFjLsmzhDEuJ/ARcxSO13a71QiElR0H+lihAgWlJxoqmjCAR6/zFsbtIpz+wsdt2eCjc3ClX93bSBuSHZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9840
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

On Wed, Jul 08, 2026 at 05:35:46PM +0100, Tvrtko Ursulin wrote:
> 
> On 07/07/2026 00:14, Matthew Brost wrote:
> > On Mon, Jul 06, 2026 at 01:27:46PM +0100, Tvrtko Ursulin wrote:
> > > 
> > > 
> > > On 03/07/2026 10:06, Matthew Brost wrote:
> > > > On Thu, Jul 02, 2026 at 03:37:41PM +0100, Tvrtko Ursulin wrote:
> > > > > As the submission side of xe is serialized by the global GuC CT lock, we
> > 
> > Profiling shows that, without backpressure on the firmware interface
> > channels, guc_send_ct throughput is about 4 H2G messages per
> > microsecond. As such, the serialization here is very likely just a
> > spin-wait on a short critical section.
> > 
> > The work items also perform work outside the CT lock, but in practice,
> > for the non-waiting CT-lock cases, it may not matter whether we use a
> > single workqueue or multiple workqueues give the slowest point is likely
> > the GuC dequeuing H2G.
> 
> Yes, and how fast is the GuC MCU vs how many main CPU threads is realistic
> to spawn to feed it. The number is maybe not one, but maybe it is also not
> that many more. I know we got to this point because it was the easy way, and
> I think it is also okay to do something completely different like split the
> scheduler better or write a new one. Although both those options need buy-in
> from the DRM scheduler and DRM maintainers. End goal is simply to provide a
> smooth UI to users.
> 
> > We're also looking at doing ULLS submission in the KMD, in which case
> > there would be no serialization at all. Likewise, if we created
> > doorbells, we would not need to serialize either.
> > 
> > This series seems like backing Xe design into a corner for a problem
> > that compositors / RT submissions have a pretty reasoable different
> > option (bypass). More below.
> > 
> > > > > can easily afford to create our own per gt work queues. Whereas before
> > > > > kernel could create up to the number of CPUs threads, we now create one
> > > > > per GT.
> > > > > 
> > > > 
> > > > This breaks down for any execution queue that waits in a scheduler work
> > > > item for any reason. Long-running preemption queues do this for
> > > > time-slicing, multi-queue registration, and possibly a few other cases.
> > > > 
> > > > I've looked at this before and rough divide is this works for 3D but not
> > > > long running.
> > > 
> > > Hmmm curious. Could you expand a bit more on this?
> > > 
> > > Where do those wait, in run job or prepare job? And on what ie. where is the
> > > cross-dependency?
> > 
> > I think run_job can wait on multi-q syncs if a sync is outstanding for
> > the group.
> 
> Not sure I understand. A synchronous wait in the run_job callback on
> something not yet submitted? Because if it is already submitted it would be
> ahead in the queue so it wouldn't hang, no?
> 

It is waiting on a firmware control message as part of the multi-Q
registration process to acknowledge completion. Typically, this is an
asynchronous fire-and-forget command, but only one of these can be
outstanding at a time because the submission state machine can track
only a single instance. As a result, if two multi-Q syncs arrive
back-to-back for any reason, the second must wait for the first to
complete beforing issuing.

We actually do this in a few other places as well with various GuC
messages. Could the state machine be extended to track more than one
message per class? Sure. Would that be significantly more complicated
than simply waiting or sleeping? Absolutely.

This state is used to rebuild the GuC backend after various global
events, such as power-management events, global resets, and VF
migration, so it must be 100% accurate to ensure proper recovery from
such events. This is also why all firmware control messages are issued
from either `run_job` or "alien" work items. After a queue is stopped,
these global events have a stable snapshot of the queue state, allowing
them to take the correct actions to rebuild the backend.

Matt

> Regards,
> 
> Tvrtko
> 
> > > Is it related to the alien work items xe "injects" onto the scheduler
> > > workers?
> > 
> > Preempt fences inject suspend/resume messages into the scheduler queue
> > to toggle scheduling state and wait for a suspend timeslice.
> > Additionally, if the state machine that tracks asynchronous firmware
> > commands is in an unexpected state, we wait for the firmware before
> > issuing another command.
> > 
> > As a general principle, we've accepted that it is okay to sleep because
> > this runs on a dedicated workqueue. We could rework that, but I'd prefer
> > not to, as it simplifies the code considerably.
> > 
> > Matt
> > 
> > > 
> > > Regards,
> > > 
> > > Tvrtko
> > > 
> > > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > > Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> > > > > ---
> > > > >    drivers/gpu/drm/xe/xe_gt.c         |  7 +++++++
> > > > >    drivers/gpu/drm/xe/xe_gt_types.h   |  3 +++
> > > > >    drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++----
> > > > >    3 files changed, 17 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> > > > > index 783eb6d631b5..fb2db9eff341 100644
> > > > > --- a/drivers/gpu/drm/xe/xe_gt.c
> > > > > +++ b/drivers/gpu/drm/xe/xe_gt.c
> > > > > @@ -706,6 +706,8 @@ static void xe_gt_fini(void *arg)
> > > > >    	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
> > > > >    		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
> > > > > +	destroy_workqueue(gt->submit_wq);
> > > > > +
> > > > >    	xe_gt_disable_host_l2_vram(gt);
> > > > >    }
> > > > > @@ -716,6 +718,11 @@ int xe_gt_init(struct xe_gt *gt)
> > > > >    	INIT_WORK(&gt->reset.worker, gt_reset_worker);
> > > > > +	gt->submit_wq = alloc_ordered_workqueue("xe-submit-gt%u",
> > > > > +						WQ_MEM_RECLAIM, gt->info.id);
> > > > > +	if (IS_ERR(gt->submit_wq))
> > > > > +		return PTR_ERR(gt->submit_wq);
> > > > > +
> > > > >    	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i) {
> > > > >    		gt->ring_ops[i] = xe_ring_ops_get(gt, i);
> > > > >    		xe_hw_fence_irq_init(&gt->fence_irq[i]);
> > > > > diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
> > > > > index e5588c88800a..175c42672546 100644
> > > > > --- a/drivers/gpu/drm/xe/xe_gt_types.h
> > > > > +++ b/drivers/gpu/drm/xe/xe_gt_types.h
> > > > > @@ -248,6 +248,9 @@ struct xe_gt {
> > > > >    	/** @exec_queue_ops: submission backend exec queue operations */
> > > > >    	const struct xe_exec_queue_ops *exec_queue_ops;
> > > > > +	/** @submit_wq: ... */
> > > > > +	struct workqueue_struct *submit_wq;
> > > > > +
> > > > >    	/**
> > > > >    	 * @ring_ops: ring operations for this hw engine (1 per engine class)
> > > > >    	 */
> > > > > diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> > > > > index 9458bf477fa6..858f84dc8fed 100644
> > > > > --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> > > > > +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> > > > > @@ -1928,11 +1928,12 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
> > > > >    	struct xe_gpu_scheduler *sched;
> > > > >    	struct xe_guc *guc = exec_queue_to_guc(q);
> > > > >    	struct workqueue_struct *submit_wq = NULL;
> > > > > +	struct xe_gt *gt = guc_to_gt(guc);
> > > > >    	struct xe_guc_exec_queue *ge;
> > > > >    	long timeout;
> > > > >    	int err, i;
> > > > > -	xe_gt_assert(guc_to_gt(guc), xe_device_uc_enabled(guc_to_xe(guc)));
> > > > > +	xe_gt_assert(gt, xe_device_uc_enabled(guc_to_xe(guc)));
> > > > >    	ge = kzalloc_obj(*ge);
> > > > >    	if (!ge)
> > > > > @@ -1964,12 +1965,14 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
> > > > >    		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
> > > > >    		submit_wq = primary->guc->sched.base.submit_wq;
> > > > > +	} else {
> > > > > +		submit_wq = gt->submit_wq;
> > > > >    	}
> > > > >    	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
> > > > > -			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES, 64,
> > > > > -			    timeout, guc_to_gt(guc)->ordered_wq, NULL,
> > > > > -			    q->name, gt_to_xe(q->gt)->drm.dev);
> > > > > +			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
> > > > > +			    64, timeout, gt->ordered_wq, NULL, q->name,
> > > > > +			    gt_to_xe(gt)->drm.dev);
> > > > >    	if (err)
> > > > >    		goto err_release_id;
> > > > > -- 
> > > > > 2.54.0
> > > > > 
> > > 
> 
