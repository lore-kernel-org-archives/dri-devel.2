Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686B7C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC14E10F320;
	Wed,  2 Sep 2026 19:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Uqq8ntTl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B407810F31B;
 Wed,  2 Sep 2026 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788376910; x=1819912910;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=6P3nqSqbDvNqM0FK6w4rjrez8rKcIr0j8UXtCR3bFpA=;
 b=Uqq8ntTl8gaPelhvN4JlXc6S7ecjq/bQQkhATrfmrxzBFdBUeaOn0Ani
 uiyNzTG3dPFZEcITBXIOWNPr5K7SNRBGmtpJuCGOlJHHygzcNfyg+m8Wj
 g5M8C2PdP8FyYW832JqxKM+13BGY88o5LEdPT/fyBoAbSY+jfcC7D2NZ0
 uavI1FagGlqJ9zOmw0Ur2nEP/JdCmfDzrbLjv27GA/UJZbDQDCbBbWTqT
 6cw+R+cCUfchOdQrbpPcOP9L3ncR7MZCdmO9jqLMg0b9KbMuwOH3J7bOv
 gdpd5Nu2LtB7R61GMQ8x8nIj92k+jFKaEVDON8Z6VAm675CpEn28cr5q4 Q==;
X-CSE-ConnectionGUID: G0GaEU0wSJq1Z2sJBVdFzw==
X-CSE-MsgGUID: KgynzkRyRr+Z6ggGSbIG7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88772037"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="88772037"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 12:21:49 -0700
X-CSE-ConnectionGUID: 76SB4XnhSOa3nqoyNaC3ig==
X-CSE-MsgGUID: SVa/EzFAT4qVWD1bTx6d4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="265797780"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 12:21:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 12:21:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 12:21:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 12:21:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsRvHEVB3SI/NHnsv9ItLI22PTbvycwOofzTM080aFazk81X7QB/Ea8Hj2m/bIy5AsA77qhPT+5YfC/5zfO1xB3pHjaggx7at7MSTw0pOQYc0DcRHxgLRhYDiOA55xAg93AXIjnFUk8aS7Rhvecp0q8eHxYC+sKZhnRl5twBtANu82512NXaFGtqu+lH7iFoWoUvD8caV2hCmZc1LfpmzHZIQEQac7YleRxMsP1tsu5tzNEZxtpYxAJaLY2UGjQ1OINRoQ87qFfidglHoA3/ymDZzgmxQ/4KErmpkfLQivfTpnj/G7pV+5o3y7gHGnoDf6Zu8A5pHeT8U8M3uwfnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMQNjM4vigxX8nBMbyunn87mfdURlKFQDXb/k0b6aPE=;
 b=Ot7u2k0wbdElyVEbJE/i2ChUgU/GVVjrTTLlua3o49QA1ifBmnrxfMlopIIpx3EJSpL8/UpG/YurnzhgcGd8zY+0S71iT7LF/lDYoYI7v/we1aPCFLsi379BTrOtX+tR7Tc4+TUMaWr04/WF0oqHtMOAO8IYqdZ+0DWopl6M2pYxgQktzqmt7BTVI2qD834+Feu0iYhRBCiVZmVmdp0ujtooR/viPdiKq65nmjGwY0bq9Qg1mltoIiffDdvsSmRs5PFH6Nlh6JrPqFGzje7Smq74i29CNb9SYmnrf1aKkqRlv8NGwTQfBGSZzIe/jJfQrZEC8vlD45twiV6qMbRv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by PH3PPFB8E59DF50.namprd11.prod.outlook.com (2603:10b6:518:1::d44)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 19:21:46 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 19:21:46 +0000
Date: Wed, 2 Sep 2026 15:21:42 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 12/13] drm/xe: Skip PM notifier preparation for wedged
 devices
Message-ID: <aph3Rr93T7VxLC_J@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-13-arvind.yadav@intel.com>
 <apXrVcABmFQbBQOX@intel.com>
 <c69906b7-e72b-4ee1-ad90-19b039b57b36@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c69906b7-e72b-4ee1-ad90-19b039b57b36@intel.com>
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|PH3PPFB8E59DF50:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6f18a6-3d2a-4482-f003-08df09276da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: P1x802gTQy7ZrH8xf531KbompcLYcDqOTREVZDOxQ/JU5b662DH0vEOjYs7nV0lI7m+NeZtnHJ7Kz5pumHEHIeQ/XL4JmsoBi6PlJ7JXhUs0xyohp3N3uTnm/+vUciYg2qVEsILAjIzAfPVq/gZwk8SSFg7hLorPWKurMjwhEGAp3BcMwNq7+Mtb4JocbBgRJRM14p/EMSxsg4a6OvafQBjk3ud5CH1JHw1EqR6oLyTbArUdr491Ham806gIwoe2eZpwYGAyZyDBMHhPJe3xuBmj8N2zTwNyKvuGcJdmDANSAte4vFa7pkhw4d9S4ASOGHtjyoBWZQ2fZ7pZnFpmljh33ESNYiutHU6VxsXsu679K6UWwsnx9RWAulcziGoauHe9cTmAGUw1KkWMGcTqFXgoHZXgfodlCGIvFCr9FUFkUCX4oYSQvKjltcnj7kRtFsUSeYyAOPerJz9EMj+0NuCZpyrSQqdYwYpcpkxlgsrZO8pZJvf0AenGQlR4InaYPpH9oC/VBXHnQUL6lX3gow4tS2FX8w1hY8ayh3eHA7TeqFDnkczrsh+sW4sgl1yOBexUn0yoR2m3D9AXkFNOx/F/qo96luP4U2XHiUlhpWjo4VUN60A95MpXkBWYW1FPZSFKxl3mRzcw0LSlcfxyox/h3Nnwi4WpGgZ3NJ1M/24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pepZXpKw3NeZYYk3i+6Aaux9VmvMIOdsb3TlZ1E2hovnmQZWSFkw7dT5jQ?=
 =?iso-8859-1?Q?ralaaHUfoc9SYV6QVZIy/8dYE26s2xaykj6GmZC4yAjUEruRFDTNEkdMf4?=
 =?iso-8859-1?Q?dUgQ5n+CZDh0Vm9A0NlsfSBXrJ8b2E/GA4ox1gevaSi+eN9sQUmyeWE/2z?=
 =?iso-8859-1?Q?VkVw0IF3n5E9IRlzabTFHGwN2iblqgc3Z3pZodIkbUj5EMP6BW4LHNpoVN?=
 =?iso-8859-1?Q?M4LuKrOTQDlyrGsC82Zc1qgsiIOuHOFf0c/o0EC8ioh4JBXrXHNXLcLqEv?=
 =?iso-8859-1?Q?Zc1sYNG9gzFHfKlhFo9K2/Kp8zfn0zbbwMbv1AWkt2H1wjDZihp73kQAgd?=
 =?iso-8859-1?Q?aQI1/jL0wItzhwVJCn/Fb4QZWmBxFsVgEjZeUqY9q54n7qxaqkmDYlIYGh?=
 =?iso-8859-1?Q?hoxjETNFc4akGN2EvoukvkeyjjB8MhOKQ10FvJj0DKwOE+WwZGbDMGjDfm?=
 =?iso-8859-1?Q?VKolWkLVnUSaY4wjC9hzqprNSPNNbL1TXfsAsrGlQJ4QGqz9nHwQJs1AgE?=
 =?iso-8859-1?Q?1yeYUYExI+rOQwCtdSwWDGqSPzLuK+1hn2jTN9yyhZx7417fY6R+Mj95SM?=
 =?iso-8859-1?Q?ACuWLaS3gIaqyMnyBvuJjIgt1W2eVD3STGTNJtFdQ3jz/P0wD4KskyQB9w?=
 =?iso-8859-1?Q?f2bpap7vr440Pm9pawhEiWlUWjqc51qnFkHOi1IUQLccsk+r9BSo/vU+8H?=
 =?iso-8859-1?Q?Jc4l4V5kZ14W4lQSk6/TDrDDFuil99hsbHcEaAAmnVHm1J8wfr9TA8HEEE?=
 =?iso-8859-1?Q?5V9U51D6TRi8IBrXMHsxUt6sxkhZLiAwZeufb6jXqTE5ukRj8N+3oI1phS?=
 =?iso-8859-1?Q?LNIw8qIhNehJxmYtKGRR7RQNRQNicPH9nMtNX2zAohboMhXlKsLQ84RLLP?=
 =?iso-8859-1?Q?sX/dDUygnxyjEd4MjyOcN9drX9DObxtYTqeD8IP0Yg960dz7S1qR87Uc56?=
 =?iso-8859-1?Q?ShZe9vt3AHc0P/o5ucvhKedc4+h1E4FQ3NdFHMOZZ7TdsczNHJcmpfJX2B?=
 =?iso-8859-1?Q?aig9yBg33Q2F5hVKc3pFour0E+wtIY29C0HeRB9f8S8Fc+7I4cdTGw4WCW?=
 =?iso-8859-1?Q?CGJck4dFxIdMn4uWCahnETgLz1DR2Uxavhw02BYAd1v6TVWbazCewNY2s5?=
 =?iso-8859-1?Q?6saCnY+2ZC9QCnpxo785mGjsM+knwdzrdYuu0wxdOXvLdpD/Gsd1H3N+JE?=
 =?iso-8859-1?Q?iw+e9UwAEdLlSPvCcZ/7tQ6cbuJmEbtWZv/RFOQ7CECUo/y8me1ltJtsMw?=
 =?iso-8859-1?Q?LJg01jJDht3LQL/V8FLNHV8e1ks8mxnU1tuwn+a7Ugh/546pRHSTNb+ZrD?=
 =?iso-8859-1?Q?RQzAjhpb82YzCEC34sx/Ah6uKFaMcoR4ZbwsREVyblR0W8Z22YC7k8ZOPS?=
 =?iso-8859-1?Q?D4i0M66PVH0hI+W+WCeTWSNrlwxHTZQgIXg9TaajYKyuohn0oshtk0X8PL?=
 =?iso-8859-1?Q?yrmUAwtHG9fhkdmHgqrrd3ay04PsYFz9lwQjHo4DvDSFKauBt9om6bifCR?=
 =?iso-8859-1?Q?HwpuDX7L86ntNuETXfj1cYG2QIehXNa5dSF0SoqvMp5f8/vCXq1u1gM4qw?=
 =?iso-8859-1?Q?gNGr061wM44U1TS4V/9UKy6lAKOgvAavKGVoKgBEBGzxO1xmGwrVr3G3pd?=
 =?iso-8859-1?Q?ZSUqO6OZENcuXLguU2iqh3uFCW5hGmOdz/uhnTWcfcoTAgCeyEsR8lXpKZ?=
 =?iso-8859-1?Q?B3POaDXsdjMGvrrkJQXQ5uI6AOBXMRCozw+mXAxq65BfiPqQxhamxc3sLR?=
 =?iso-8859-1?Q?lOrxaXvVP6JRPP5bRAehfuYV/UH7B59EOTPbeMpiF2Md5slhjzsCLSvYoa?=
 =?iso-8859-1?Q?gsqdVLHVBg=3D=3D?=
X-Exchange-RoutingPolicyChecked: yosnTReJWDTVy6VM8mR/l851eNsbJ+No97LHHzaM2B9jeUTv5fHjDiTtdikInGACbENbK/AlHYts99ICCK+9q+YSvVlIdfdA0MYRES54rUnyeuuc08HoRDt+rczLwvfPnplzZoS6SkJ80pLWO0NCtiZv14vziXgZXgnb00OuyW/iWPVvRqLT4BFjYFPAPULMAMJqG8y9HLpt1+VswjUCHO0dpJkxAO/cuB9hxn0ZMgAeWnhX3kcsgibaozBLnap1p76XT2+dlQTPOTUYszSvpPSERu4vsEaM3SHOMXYVPLxIbJ9Ew9IetOtLRJqjm0xRftgJwrLwrU7Sk5hoXOeRmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6f18a6-3d2a-4482-f003-08df09276da5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 19:21:46.0504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oY7f+BwxRMN3WYwzbtA+EWfMTLroPmtd8dZiUReLMIaoFWDCGZVZ3laaGnSYkqupDFiM035uJA5PVE4Mcfcb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB8E59DF50
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

On Tue, Sep 01, 2026 at 12:33:24PM +0530, Yadav, Arvind wrote:
> 
> On 01-09-2026 02:30, Rodrigo Vivi wrote:
> > On Thu, Aug 27, 2026 at 03:48:00PM +0530, Arvind Yadav wrote:
> > > The system PM notifier runs before the PCI suspend callback and may evict
> > > BOs or submit migration work. This work must not start after the device
> > > has been declared wedged.
> > > 
> > > Skip PM preparation for a wedged device. Track whether preparation ran
> > > so the post callback only performs matching cleanup and releases the
> > > runtime PM reference when needed.
> > > 
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Assisted-by: Claude:claude-opus-4-8
> > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_device_types.h |  2 ++
> > >   drivers/gpu/drm/xe/xe_pm.c           | 10 ++++++++++
> > >   2 files changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> > > index 508ba3872e72..c9dc417878e7 100644
> > > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > > @@ -471,6 +471,8 @@ struct xe_device {
> > >   	/** @pm_notifier: Our PM notifier to perform actions in response to various PM events. */
> > >   	struct notifier_block pm_notifier;
> > > +	/** @pm_notifier_active: PM notifier prepare work was performed */
> > > +	bool pm_notifier_active;
> > >   	/** @pm_block: Completion to block validating tasks on suspend / hibernate prepare */
> > >   	struct completion pm_block;
> > >   	/** @rebind_resume_list: List of wq items to kick on resume. */
> > > diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> > > index 720e083cd279..dd7fd170bc94 100644
> > > --- a/drivers/gpu/drm/xe/xe_pm.c
> > > +++ b/drivers/gpu/drm/xe/xe_pm.c
> > > @@ -457,9 +457,14 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
> > >   	{
> > >   		struct xe_validation_ctx ctx;
> > > +		/* Do not start PM preparation after a wedge is declared. */
> > > +		if (xe_device_wedged(xe))
> > > +			break;
> > perhaps we need to return NOTIFY_BAD ?!
> 
> 
> Thanks for the review.
> I do not think `NOTIFY_BAD` is needed here. A permanently wedged device
> should not prevent system suspend.
> pm_notifier_call_chain_robust() passes the notifier result to
> notifier_to_errno(). NOTIFY_BAD becomes -EPERM, which will aborts system
> suspend.

ack

> 
> ~Arvind
> 
> > 
> > > +
> > >   		reinit_completion(&xe->pm_block);
> > >   		xe_pm_block_begin_signalling();
> > >   		xe_pm_runtime_get(xe);
> > > +		xe->pm_notifier_active = true;
> > >   		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
> > >   					     (struct xe_val_flags) {.exclusive = true});
> > >   		err = xe_bo_evict_all_user(xe);
> > > @@ -480,6 +485,11 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
> > >   	}
> > >   	case PM_POST_HIBERNATION:
> > >   	case PM_POST_SUSPEND:
> > > +		if (!xe->pm_notifier_active)
> > > +			break;
> > > +
> > > +		xe->pm_notifier_active = false;
> > > +
> > >   		complete_all(&xe->pm_block);
> > >   		xe_pm_wake_rebind_workers(xe);
> > >   		xe_bo_notifier_unprepare_all_pinned(xe);
> > > -- 
> > > 2.43.0
> > > 
