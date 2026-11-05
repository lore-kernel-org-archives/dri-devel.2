Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D57606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mPG+sNbr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9218410E38A;
	Thu,  5 Nov 2026 21:53:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D946F10E38A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793915579; x=1825451579;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EjQ3EP4qNr3RP7S6SoycTKBRaMCtmme7axFYYDCdodk=;
 b=mPG+sNbrJT2sfuu6CenLcvnMaEcLMlbIcPkOmLN6p81CFevUYkFPiEPS
 Fc57fC4MVClkKUXP5Hc/cIbKvs3ktnhWpE1w6nmzWCgvnlXxGRa9FHvZo
 jOwNIDrlSK358rpzULgHbg0PUYUUivyP4w/RV9RWEg/f+wPv/jknmbxCP
 xexa8xC/D5clUi7zXHPT+nMUYN7JRU3ZRVaIlQidcjk/4y1/Tm4/At+j0
 bDIWPcyw0MsKStdIzmjkumwtHJyT0N1SAtBIRs0VON7qUcR/Qbw+CrCGn
 mxr0GK5cNzIFjXWiSDnL2vl/zq5o0XGg0v5vmk5verKpSvcOV/YsUb/hl g==;
X-CSE-ConnectionGUID: bgq2CqtdTAmnftegzkqRlQ==
X-CSE-MsgGUID: U3Sox1K/TRCRKzl58whRoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2625447"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2625447"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 13:52:58 -0800
X-CSE-ConnectionGUID: SSg1ZtVFReW8X5cPjNnKEA==
X-CSE-MsgGUID: bK7XpNJLTbOtpLoeqSZFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7453657"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 13:52:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 13:52:57 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 13:52:57 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 13:52:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVIfiBTGlqTfJkUN0ejeKHyvrwr9xy+dKH8McxLxYVi341UOvECNpTmHCKVG0s6wtXj43sY8pIhKVTKzNcsCYxZedEGJGthwzSNZaBetzSknQFTDnRub/9kJvhGs1XF/O3Ey83wgV6ejkb/5/gk7hsmlgEq1tYFtYKEmfVBromE7hL0afAcoBEUWKHYOtPc3ls+fvaegraQGNyuEFAoJKs9BdNw/CAQO2Rue3G9aosanEGZ73k6tGl6aNmY1Hbp0wwexlsp2zqyhCtO4VfvjFYieqeCTXHKeNxYV8ZdLcA+rxdEfQfOSgb3nv1wl73BD/8dxw6bq6Fk5KzxjMpEFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plPlynlNlVhtpThf+EXn66C+tddInPhRFccRKP4MOfA=;
 b=pnNWrBAd6h2AfvhZWqb4BLNEPj1q04bmMr1fWvRw/FrMUifmoQrqQWXP7HkE0ROT+UwExOe03QRzcBhg3F2Gw0YB5XU6yQO1xtTPmzJrjwELB16rfsWAWMserczX0H/MiazlzitPJ9608C7xa+WU+OmCu/k3JnRHDEYtf8frd1LWd6yC84CHXrFpsqTDAes0TVpmS9EY3Y6nMsogdrpzukmj9JaOpfQkYpvwcjRcrXtERW5kknNQdvCBjVWdhTogbUannyrSwHQQzNrxV7jX8xvsDAb9RKh6MJGko1a9BAVr57VKn1VQIVGNLQ6kon0bKnKeNexj3Vcsz4oediHyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by MW4PR11MB7162.namprd11.prod.outlook.com (2603:10b6:303:212::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 21:52:54 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 21:52:54 +0000
Date: Thu, 5 Nov 2026 16:52:48 -0500
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
Message-ID: <auz6sKjP98m3IoG3@intel.com>
References: <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
 <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
 <DMMDNQ0GD6AP.6HPRG6JWUEYQ@kernel.org> <autvCxZuSCxFjtgr@intel.com>
 <DMMS9R5JJ4ME.TBIB1TNLB3IP@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DMMS9R5JJ4ME.TBIB1TNLB3IP@kernel.org>
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|MW4PR11MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: a006e55c-917e-4805-8b19-08df3b8724ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|10067099003|18002099003|4143699003|11063799006|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261102123227099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info: z4NHfG4F+PGMga77MaMrPsQvkHtscGSGhU4UOhr/p4DAp3XS/DNV2zBKGpgqnLpBb2dlTioPbAAqBN8S7UGI0QTl6WIJyQBKr/bkjZFQEDi33YBjP9bwnUwf/ys2kQEndI2nsouNXGNXNjeoDGBg5LG/f5G2Iy4jZapxRjWjre75y0jFXj/EM8w7WvE5eK5/ycR3MdeygEuoM1bP39UPMj+ANWoiwo7GqtexTo+Q9RprPrcEvfsUrLPWe+hgRe11hsiJRN919Ekjpy2Tg5NTMmgGOX8NLl2CRjR25KU4qc+5MULSvp8snu5BN8YndxKH48bI4TJtQ4GUfv5App9MXWR0rcD/txB3d0rWGydtV2X9wZoOYj6T1xxebVaxwr3a+tr5M9QUZqNqPOwds3YbCq9gakAMFiuBFtxzHKWIfviPWEPXTDk+Qdr0gEzNqRex3lxuCNISLOWzs+IrGfg2leFaU1Qd15KbEi67W5RgwpkwrO33H0BBbz6ZCB1WJvF0wFzTUs/PGz0WW89q1CoRg3rzeC/0XoXAmIJigmScJ0bpSQGxNglFVEtbvPN96nCkistmZBedyRC4Lr1MYI24c0Hye80oUpp2dw4VnsVFZQGlgDYWoy10qf5wWD+opf6UuL489QRc+484UFpvnq6HW6spuoj0n7Oji+ao86mBkUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261102123227099003)(261026140227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szqDyap7ceGfq6iw7PUZUV0v4cD+9KPrDPd4mgXGuTyD9Be8h0okhSzx2vgg?=
 =?us-ascii?Q?X/xBIIqVCJVQb/BRi2tCjmso2R2ty5Rl56tVEzQLyxZQxH7A+BmGs1VtVJmu?=
 =?us-ascii?Q?Ti4TA6T53o8yI/K6PXxZBdrPOO2zbkqw/iTpxJphpZmEHwXGnTCHMWwdpsmd?=
 =?us-ascii?Q?N7feYql0nGLnJe2mGJ19c1mTaCyr8rvquRbw6Bc7pse5+DKjvlHlreTRhYMT?=
 =?us-ascii?Q?ld8rx131BblqpjhzxWLxg9PpOhC52dep9HSStuS9lGaPzoTjHnCWuyRnSoit?=
 =?us-ascii?Q?wq37I5t08BRIGVnEyOOGURyTpsYjdib7fjJwx6F6Vg5kXHUk7aTbpUsnkkjw?=
 =?us-ascii?Q?Nw1K+oYcbRgOnVlhy+3A8SHIUyCQmFEgF8Mor1nmBUyFXjw048gcVgeU8/RT?=
 =?us-ascii?Q?g8EdjbFaISFTMS2h406vwWtF3NZgrwpaKHWRFTAXaxl0KbH49eYJdl9asLrW?=
 =?us-ascii?Q?2c6hqMxIMXIpGPJhQSrjXgK/RdKOPs/Duc3ZyP6yMdHgqIYMtY8yIr3318wi?=
 =?us-ascii?Q?JNbMc/jVQyETwBjwIyPjObduKWqHG63+hbGboIYrr68f7Fb3eiPVAt1NVKhx?=
 =?us-ascii?Q?ixTHzRf3b9OV7KdXACDntbua8n+eO3eUcA0tLAXr/1m2jV1B7MOqODtOxQxz?=
 =?us-ascii?Q?4zVBdbUUpFpsfCKTAQxntxW9hIEFM3ejFxS5t9UZY4LBpCKCdtcUPN9k71Wf?=
 =?us-ascii?Q?7h2Du/+pmRIVzsunRhP5W9Uvs7yaYQ0ngsPsifmVmurs44KJQMRofmg4h6uo?=
 =?us-ascii?Q?GAN1fazSV9ikJKpnagK+noQo9r8i4ic+CiT6NFlP4pre4kt6NLNB0gqOdn74?=
 =?us-ascii?Q?WtjzgrQkP72Bin2PrcVlFNLlbvS9uTtd8PvplWsJH6+D+FpGz9yILRPCuEq7?=
 =?us-ascii?Q?eKFdq/rvzS2Lx8qas2wa7Xs+LBAXnpNtu2AZwXDpCP3J1sP9auKu2XnCnITl?=
 =?us-ascii?Q?GdVhYa9vLq6JIVt+udsy+P0YVqpINQvPYPljR2hIEpV2aGRyflkGUAOvCQmG?=
 =?us-ascii?Q?17r4L/CmUL5sAKC/CC/tedGCRGzd9++aR6I4nVPpfJnoajBhDU17y8f/vn/L?=
 =?us-ascii?Q?NVMsbm0pOEK8RtVL4mY+izs9++5m/SRbUAC2rqiGE/Csj8FtzzXw4Aq7uh/t?=
 =?us-ascii?Q?6FMu7vCBqj3rsuf1VXzO676NN5gR49Zr+dW6VxkPUSVkA0KEWS8HXnUTA5bL?=
 =?us-ascii?Q?at/TL+hxv8PHYNAAqF88jro6HIR9+QEDtC1BT7UjbRO2ar7acHG96NKOC4N6?=
 =?us-ascii?Q?52oXXBJz95D/9lReCDGZq4rwhE0oLEvC7wmTvp+ms03v3uBNQg1i+W6O5u//?=
 =?us-ascii?Q?YpZEt1kjHd6mbctVK4ELh217gdrizAwGH515UW12mBEH4ooFdmaJ8AiBwky0?=
 =?us-ascii?Q?+WPoq81pmzMxHfrSJXgy61NX4Ka+dK0Xt7S/Gzwdn4Pe5R7PegYHAWeOtM8J?=
 =?us-ascii?Q?TX0BmMRnkcTLKUvN3jOFPHe9xtavfQNsCH8DP85y8aSCGyUhYwcydX2NoS0z?=
 =?us-ascii?Q?I/EC58yUbk2IDSUvtWoCo+6RqDkixiUbGc2PHLXOyzbhn62g3Bo5gvwsKVMh?=
 =?us-ascii?Q?jEY/n7t2mFtVLC7zP6bSUdb4LN95mR7vOzCje5UxD8tVJSkw8sQUYSZoVwr/?=
 =?us-ascii?Q?lPMIy+DjIe6F0/ZLD52v9rN9dwtcfXXJWNL8Gx5rm6xWv5JyCDBrvfYu7u8C?=
 =?us-ascii?Q?imMBb+BZPe3AQDYf0D6u78IIo9R+cnbgrzBcEkbAeiydZcAIeRVYePUvU8VI?=
 =?us-ascii?Q?pfaRf4xZdg=3D=3D?=
X-Exchange-RoutingPolicyChecked: J9CIjULZ8mpefSqO1TRTJANkKgJ5VaJpGOKUQYl2Ru6e2lXMKCaA5++Jr/EyOHBPJqOBs6ubK5czIHcmRCkpE5xQ6gT+cBYa6XNV/YXGqlGpho63skjaELbSQU9HNMTxz3hHKnqWn0iJqnjGWgl0UpQ7RA5DwVaOcixYPu7WwE7XD4mjac8oIMEUmsQIdyQXdc04NPT62RAC4ENf22v0Ea/+luiRZbW+GYtMQYwsxBG0eGx3OsAPj2DXLDtKdpkRQxwt26uAFtBh9XCX8/g2Rd0hATIxcPWI39vzFI/ETLFC4AuDxBGlZrNc6xXSbHw002jDSCD5c2PLJbR0HRD7UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a006e55c-917e-4805-8b19-08df3b8724ff
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 21:52:54.0517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s4C3Yk06sY3Sqil5H+Ov60SVBO81QlilvM9w/OQorsqASLQOIn3EDHTAlmKO6bt7xom7Dji1x3PsZgMyWuTSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7162
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

On Wed, Nov 04, 2026 at 11:35:10PM +0100, Danilo Krummrich wrote:
> On Wed Nov 4, 2026 at 6:44 PM CET, Rodrigo Vivi wrote:
> > On Wed, Nov 04, 2026 at 12:08:08PM +0100, Danilo Krummrich wrote:
> >> On Wed Nov 4, 2026 at 4:29 AM CET, Dave Airlie wrote:
> >> > Yes this is the thing I like, while I like maintainers having freedom,
> >> > relying on them to do something manually every release at the same
> >> > time doesn't seem to scale so well.
> >> 
> >> I think maintainers have to do something manually every release in both cases.
> >> 
> >> The difference is between "everyone has to do it at the exact cutoff day" vs.
> >> "everyone has to fast-forward their -next-fixes branch" (which to be fair has to
> >> be done in both cases).
> >> 
> >> For the former, a tree that closes before the global cutoff can still leak
> >> following-cycle work into linux-next.
> >
> > On that I already agreed that we should move the blackout from -rc6 to -rc5.
> > So, the only thing that every maintainer needs to ensure is to prepare,
> > at least, one PR after -rc5 and we won't have absolutely any leak.
> >
> > And I believe we are all already doing this anyway, so again, there won't be any
> > special thing that maintainers would need to do to ensure correctness.
> 
> It doesn't change the fundamental problem if we define the global cutoff sooner
> or later.
> 
> To preserve both properties, each tree's transition would have to coincide with
> the global cutoff., otherwise it can happen that either stuff leaks into
> linux-next that doesn't belong there (tree state updated before cutoff), or
> you're not getting linux-next exposure in the first place (tree state updated
> after cutoff).
> 
> Making the cutoff day sooner makes it much more unlikely to leak stuff into
> linux-next, as closing a tree before -rc5 would be pretty odd.
> 
> But that trades the leakage risk for patches added after -rc5 losing linux-next
> exposure until they reach drm-next. That may be preferable, but it still loses
> intended linux-next coverage.
> 
> In a normal cycle this would mean that trees collect up to a full week of
> patches without them seeing linux-next, which is a concern for me as well.
> 
> More generally it remains that correctness is based on a timing promise about
> the tree state rather than the tree state itself (which is the actual source of
> truth).

The current way is already a 'timing promise'. Multiple promises in a matter of
fact. promise that you will send the PR around -rc5, -rc6 anyway + promise that
you will update your -next-fixes so the current fragile blackout check works.

> 
> I don't see why we would want to make this kind of compromise where we prevent
> intended linux-next exposure for up to a week, while the existing per-tree
> selection logic in dim we have today can preserve both properties:
> following-cycle work stays out of linux-next, and work for the upcoming merge
> window gets linux-next exposure before entering drm-next.
> 
> To me a fixed global cutoff in tip comes down to either one of the two:
> 
>   (1) Make a compromise where e.g. patches that belong in linux-next get up to a
>       week delayed exposure.

I really fail to see how this is a issue...

But anyway, as I told, please provide the patches to dim for the unified tree
with a more reliable way to guarantee our promises and let's take from there.

> 
>   (2) Require each tree's transition to following-cycle work to coincide with
>       the global cutoff, in *addition* to managing its branches correctly.
> 
> >> I.e. the global switch is automatic, but doesn't ensure correctness by itself.
> >> In order to be correct, maintainers have to do something manually.
> >> 
> >> So eventually it comes down to whether doing the correct thing derives from an
> >> explicit operation (i.e. fast-forward -next-fixes, or just add the --final
> >> helper), or an implicit commitment to push and tag branches on a specific day.
> >> 
> >> I think it is better to derive the tree status from its actual state rather than
> >> a promise about that state at a specified cutoff day.
> >> 
> >> > If we can't have the tool enforce what we send to -next after -rc6
> >> > then it's going to have gaps.
> >> 
> >> I don't think either option can enforce correctness. The difference is that one
> >> approach relies on a timing promise about the tree state, while the other uses
> >> the tree state itself to make the decision.
> 
