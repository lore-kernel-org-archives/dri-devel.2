Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00569606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cfp0d7al
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B6410F832;
	Tue,  3 Nov 2026 20:33:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A8C10F7E7
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793738033; x=1825274033;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=48JLeor2FJN9qEyY3j6UBtOyKj57nLC2hkMDOGjy1B4=;
 b=Cfp0d7alFC2I36rfmuuDlYhd3jeKnmmGvwmtf8E37ut4apziq1JmwNha
 G7B9Wf0LVI7sEIuEaJlwA50WyfS26w3uwk/cPTwu4Z4d81AfyFj7M97ni
 gHjF9ezHX14BOKRkp66gigT3eG9lTHIhZ5XmhFD1rtePb1Fv+bILSH7Vg
 7csRlW1qS2wmtztlPBC6jxmmfJwWWLfxTLm7V73HRvZzCeUUcgQ6g70B2
 S+Io5xARmBKla75/KD32t5ZLtcWVnmX6vhPOY9xRjMXx5+E8VpYNL2Tke
 kBl6nwCxzXmJHbsJ6FwoyyTXqOXYG3XM81IuuEAoit/a7BzMT1pmHUcZb Q==;
X-CSE-ConnectionGUID: cSnIhb5RRMCIHqQAdYJfAw==
X-CSE-MsgGUID: aZO69WRwTPagzGU9z5ccrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2381040"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2381040"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:33:52 -0800
X-CSE-ConnectionGUID: A/rDyTHNRWe7rZQNTbE1cw==
X-CSE-MsgGUID: S81JclFQTq6VG5CjypeOYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6660948"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 12:33:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:33:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 12:33:51 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 12:33:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCPZmciSFYn7k59HX+vuIXIUP7H6qpkuzWwM0jfezt+JhTqWzZJy+Y1X6IKshNXM7TcqdI1T+HHn0PoGc0MIFaudreu6Tnttddd5pDS07GkDU4QQty+dxsi/BNbOP2tT8mJt9uQR/ofsIDwn1/R3cWkTVDLzAOVRpV5/5Z9ZxnGgqQqic5/Vs8x/9D5Q/AUAgQ6qVMG/FDlwrbQtY3T1gtK6Wp8vTAqpZD/4uNhXu7llBkm2TTfouV1jBREVXefJmd1To0wXceaBePl6SZrotfjWQ9Mgty6s4b595P9uZ/bk6RzSZfOELs0f7I+8Qj3BKN5CTVJlxI/2+MzOY/mMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6w/ts4JlNbe2NtaA9T+NOLoFStiPEd1Q5eH7B54/AQ=;
 b=DXVkerhBPvw90t9leblQYyfsBobHJRrSuBaZ0z4W50Uz5uxaJ7ix2Rwx6WutqZR0khLv8tVtG9veoyXe6lPoOl4ofFWu7b+Gv0jSis9l7pGMcVIee/pDzck2Pp+JihXOAnWNQwNuVzhY+951eBjrUFT0Zs4lB9VYCEwfa8PeSRwF4K4BzAG/mItBAgj/l+KUJ1VDa418yimC0MJY5+J9pVYWvGfzTVcZ7fYc36GZOSUcJugrV+oNXoKYmNygDOmzVmw433qR+r5dE8HX1yHa+kBb8D5YZkOCDIACp2n5JzT2KNzaF1POdo7apWJzq4YQ1cQPuFM58g/c4Zl9qGmGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by IA3PR11MB9352.namprd11.prod.outlook.com (2603:10b6:208:575::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 20:33:50 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 20:33:50 +0000
Date: Tue, 3 Nov 2026 15:33:44 -0500
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
Message-ID: <aupFKGpAwAiGXN0U@intel.com>
References: <aujZcJBUyQ7iX_PM@intel.com> <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
 <aujikV14tF6K1Xqw@intel.com> <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|IA3PR11MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: b270ef71-f249-462f-f06b-08df39e9c48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003|261022105027099003|261021135927099003|261022075727099003|4143699003|11063799006|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: R/9va0Mm5Fmvn1mYcB1jfW7u6ZDQVMzGj3tTfV5I3nsznk4iCP3dZOviLQksKCGLnJsBMhaFthc4/DQdyzjky368w/rxMqSyZ0W0JEDULVbYgvecYKPS85ivnUbYHhvNrrxxt2GP1VTKiesxxqRcpCDi2GpCGSXIQLGGgMiYILx5FTxLIYUUyJgjpwoWF2tflNNeQG4vr/wLocQ56m+fC14Uyj52waDEQgEhgdxOeldEja1wyLscnPTyCxXIvEQ/99F3QhJrgGFhaIj8ZNptYbu8jRkoDx9fcuZ91r5LRpbzpCfiAKU74wD/MARLN5WW6j1+H6OYQG10QshRWNUcm7aO1S41WwKpcJftOvwERnPUDczAuRW+CbIUJ3ELo2M2qeM917ufYBX339EK+Lp3O/+e7cCZlkxdwosw2XhlyajOR+/jHpxGdTjyn8ailBEnoJ0e9Ujxt1ecfYq+jyTq6EWke+Gokvd+y4mLSaMYUA4CYLFc1rLXLMFOKg3HD7uWIFDhtAProcdVnMODnaZ+AYGPy8Jd3pfkwq5R0/qJefd+21zdWJNbjVasOBzs81HfrNQ5SJrIldMMye8yL/gmbbwE18NHBd06XSNoX7tBk4jB099tu4FVq+Qz3ISzsn+3tt74h19tiXrcmCv4Fy1Y+ZK8z5m2Wvl3mcII4t+jEa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(261022105027099003)(261021135927099003)(261022075727099003)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGvtDoXuO0GfsHIq0KWtp/ArNKkZdzuqF9txKcNKVrAVdXebsgZi3A/qzFVY?=
 =?us-ascii?Q?bXcj/OgPlTBOepSHo+MwGI+kOWHSQXHytKe3p3dl1er9y8ZzWKzfYAM0Q+iQ?=
 =?us-ascii?Q?K30kxcRTVrNJ7tM5qzaqFoVhSIY8J3dAMPMpbrpF/SLBBt/SMQQ3zNSTuM68?=
 =?us-ascii?Q?SjhnGeXo2xG23r6NG68ZEx+BPR36Aau3E0YoqKCELnvrJVJUYD052PonGyoB?=
 =?us-ascii?Q?6dnBGXaesM3k98EBM2s3uDiQBeSeYQ+x8vWmZTJO7PaVypVim5t35FfK0sWG?=
 =?us-ascii?Q?0EgkzvDrmmt25Yo4imH15PEdEg2Y2xYVHg3gqoWH2JdXUcxTe7YppocrRstc?=
 =?us-ascii?Q?xon5d6IGMhPlZR4uZSKQjeNQvrcqKSCabDbklSN9+a4E2hRFEjU24Tg8xTt0?=
 =?us-ascii?Q?DNGFizO5j4Nz8Sk908gL7B9hmU6RbZRe2dwH/8qAFRjcJRoxSHBsgsjJYsaL?=
 =?us-ascii?Q?qboCM/R/576EvICqT/HrH56+uj0tlv/AwPTriggE/Z3aX6GByLZ5Z/cxC3UN?=
 =?us-ascii?Q?vdfSgYhkv+TOTzJWEwA6EwgeCCLEg8+wWGubl6vJldsBnQZXPIYFPbn9yTgF?=
 =?us-ascii?Q?F33nYOhpMwZT73CSOiTMa7QogNCcLyaEmQhqacM0eFSLyZk1mrhFNi+icGIO?=
 =?us-ascii?Q?dzDZflEMJgIngsXvoQuDQXENAeQxylREk9x+BcDJMUzYQtr+hAnTBxTpbl1n?=
 =?us-ascii?Q?MCJoyUHPrCDE+4XYJtrtH+WSeMT8UCncAViK8VrmoBicUcan76nVAbQ803KB?=
 =?us-ascii?Q?lteVtTPTCNtfXKw6AuVhk6UZSmqwE7AuGrAYWX1rk4BHQTWIIZVwh4qXJWQN?=
 =?us-ascii?Q?1FRkyEqEUNfEPvmMBI6eROlpq7pDQkUFE4eHg+//E7rvWWcxkh4rPjeD74yf?=
 =?us-ascii?Q?9YjG+eQTV7fLm+vfpZWgQErUqByWQVD0FBZ+AzCXfYDokmhEML2HZhI9bjf2?=
 =?us-ascii?Q?Z95HQZrK4XsMkDaNy3nCbUuFiVfzbskWTYpQKp+Wj6pSmt3g8hl3q9OeeKp/?=
 =?us-ascii?Q?I7qEqZ9pxevybINZYrckyO4JhHISrNGCSJ7TmWCQQUk73zUCw3HV9UJhg3pX?=
 =?us-ascii?Q?G+//YW29nW+zuEYB7VLk8UuZuZQ7LdLwbQF/k3fkldxfCyx28iVjdAk9lF0R?=
 =?us-ascii?Q?i7N5soWkj9xxUHTk+XU79BCTEo3unJLYNvRselzmO43X7kJqtu1rIkvRmatr?=
 =?us-ascii?Q?Izp9zphR5sWAeDogX44YWckFTNRb1wlJnJEer4rXQCgvpXC5TPJFuWzn57h5?=
 =?us-ascii?Q?y9mtP68ngvkpSzLc11sq4lW1dsjAJpvktzkgoKwYTgBu1q3BNJPM65l1g5za?=
 =?us-ascii?Q?xvev9qBR5aga4Gd41kHI0mmv2F6oreN3pSFR4O946+Wt4PLIR14wIux5q+fj?=
 =?us-ascii?Q?ufL6+CzTO2V0wn6fS4HrUNpGPpZiG/LO+HHJMBIw8O97GmW+AHxC/RBpaL0D?=
 =?us-ascii?Q?zA2ahSUOEVCoQ2L4I5mMmoUWJ6X1ZgoI1OaEvh5oInHbl/ec84VTS6fXCDkJ?=
 =?us-ascii?Q?0BQWGFcSWahyCL+FeRBeuiS27TNp1TbITxw4E8S0xzUHNvcL1c5ZhcOQEZp0?=
 =?us-ascii?Q?g4CWQeOzMd1sQWQglhDwv3vSByVlSA+LnKxyctp5WcpTUNYBy4xSeW/TcCWc?=
 =?us-ascii?Q?2Yr3QpIqepku6mOtU5bIQyfonv5E8ydQADhbG7Ay/z35HFuGNc5A6YZ/mvOD?=
 =?us-ascii?Q?UCcDQl/KUZ5seRwAt0qGjzxPB99oM6By3YmZ2+hNLR704pTWq+92Q315VFYZ?=
 =?us-ascii?Q?sJDovo+YKQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: rACACmC1MERFh1Ug1Dq6eXdvEA3kdX0NWfPaKonL/2Ow8LQ39yW+zU0nQZkD40uCWxd2l+ccTvDYgOEwWx/Zp2poAoy0u4rYhqRFwW/eI1GPj5rIZ/9UT3jdLkkB1KSnxeX+3s8E0H0vzcJ6anWvM3X+l4CsT12vo0e7v69vmXFQM84hQB4Q2PdA0/+OZ8qCSrwRvfw9NCcxyFd4fNXK7ZJTjYrH1Ifqd4PRoiMx3T+TUQ6cxQI+hAtf3KZ20pRwCYlFaw1IBTD3A1LUxuyQkAqFu8ml6f+ArOBoEG5jcBBZFHVak+8ucQGXLTjjBAdR99URra+2KE3uCEl18ZN1vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b270ef71-f249-462f-f06b-08df39e9c48d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 20:33:50.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz1Nk3R7iEfeUAf0cKHj1HPvEHWArtkBMm/Uo0zVF+DroeoGReDjRQzvQSJY/fteo7Waj6xPNtysZ8ZNkoaJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9352
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

On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote:
> On Tue Nov 3, 2026 at 3:05 AM CET, Dave Airlie wrote:
> > It might be time to pull back to -rc6 though, we could just keep the
> > rust tree in -next separate,
> 
> Agreed, I think that makes sense (I am thinking more about occasional cases
> where we may need a few days more due to cross-tree dependencies). Otherwise,
> that's an option too, but I'd like to avoid a special case; if we take the
> proposed approach, I'd rather try and see how it goes.
> 
> > It shouldn't cause any extra conflicts, but I'd rather not keep all
> > the -next trees in -next once
> > we merge this, otherwise we may end up with trees getting ahead of the
> > next cycle again.
> 
> I'm not entirely sure what you mean by "keep all the -next trees in -next", but
> just to clarify:
> 
> I'm proposing that linux-next only merge the unified tip/for-linux-next branch.
> The per-tree for-linux-next branches would remain as inputs to that branch,
> preserving their existing selection logic.
> 
> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-next merges
> $tree/for-linux-next, rather than $tree/$tree-next.

For this to work we need:
1. xe to create for-linux-next for-linux-next-fixes
2. amd to create for-linux-next for-linux-next-fixes
3. All maintainers to agree to move their -next-fixes on the same day that
they are sending the last PR. Or have a new dim sub-command dim final-pr
4. Instrument dim to have this secondary reconstructed tree instead of the
implemented chop.
5. Prepare every committer to deal with this extra build time and extra
conflict resolution.

I honestly prefer the simple chop solution. But it would be okay by me
if you take the lead and implement the dim changes for this flow.

> 
> I.e. the ultimate source of what is linux-next material remains to be $tree.
> 
> In general, I think that this is more accurate and probably less error prone

I would argue the other way around.

The reason that we are seeing so much escapes from next-next into linux-next
might be exactly by the fact that the blackout right now depends on 2 separate
actions to help simultaneously (last PR + rebase of -next-fixes). What most
of us are not doing.

The current proposal of dim taking care for us with a single rule is what will
make this less error prone and ensure we are all following the same steps.

> (unless all trees really commit to tagging and sending their final -next PR at
> the global cutoff).
> 
> For instance, let's say a tree closes (i.e. tags the last -next tag of the
> cycle) a few days before -rc6, it could happen that subsequent commits to
> $tree-next still appear in linux-next because tip still picks them up until
> after -rc6. So, after -rc6 those commits (that were in linux-next for a few
> days) would disappear from linux-next again.
> 
> Not that big of a deal, but technically they didn't even belong in linux-next
> for only a few days.

But well, this is a good catch and a bug on the current proposal indeed.
Should we move that to -rc5 to -rc1? We just need to ensure that everyone
have at least 1 PR after -rc5 and we are all aligned.

The only caveat is that patches landing in drivers-next during -rc5/-rc6 will
take a few days more to propagate, but it shouldn't be the end of the world.
It is still a couple weeks before the merge-window.

> 
> If we kept $tree/for-linux-next, tip would never pick those commits up, because
> a tree that closed a few days before -rc6 would already have switched
> $tree/for-linux-next to $tree/$tree-next-fixes.

Well, if you don't move your -next-fixes at the same time of your last PR
you are leaking that as well. And this is happening.
At least now we know why it is happening (besides xe and amd sending
straight from -next instead of having the -for-linux-next branches).

> 
> So, in the end, it comes down to whether each tree's closure controls what
> enters linux-next, or whether maintainers need to coordinate their branch
> updates around a single cutoff defined by tip. While the latter sounds like the
> ideal case, I'm not entirely sure if it isn't too strict in practice. I'm
> thinking more generally here, from a practical or organisational point of view.
> 
> (For instance, in practice Intel has sometimes sent its final -next PR a couple
> of days before -rc6 and continued applying changes afterwards; I think their
> cutoff is generally around -rc5/-rc6.)
> 
> > I'm not sure need to have that complexity for everyone, but if we need
> > to keep the rust tree as an extra then I'm fine with that for now,
> > until it stabilises.
> 
> Appreciate it, but I'd prefer not to special case it; I can see how my drm-rust
> example focused the discussion on that case, whereas my concern is more general.
