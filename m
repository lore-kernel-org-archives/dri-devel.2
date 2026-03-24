Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE09AF54ADD
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A8710E0FA;
	Tue, 24 Mar 2026 16:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ATtOTNoP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A453710E0FA;
 Tue, 24 Mar 2026 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774371127; x=1805907127;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Wrm7tn6K6fgmyjB/GBnyrnXwSOdfyz/ICypc4wC9Tew=;
 b=ATtOTNoPwDFtuM6sxoMxjFvkNVfz7qkp66ra7hdD9eQp3izjN7CqlUEA
 t9gdMU6L/Mwl2NoGEO3Xt0JSg83CCktQf76Ne1FTYnQV4JGr4NR0yabpu
 CH0dU44hXFLEwIXg6Scykj3uIQUE+CmVJhYkt0lfB0qri6CA3DX2PtEXA
 uFI0kM1Qu4SKufKodaS9lu394K84wZNEamc/58ztdH8VTnw9Wi2JyT1ui
 /284qlBcFhsq5x4xQ1wrYKbS+SiwgHz1UDKW52hgj0xa/oKY8asRyAAsw
 m9v7Q3x97Strs4wsuNb1Q5RzuHKgVPWHbPwmi30vOhZnQO/qKcv4CmX1g A==;
X-CSE-ConnectionGUID: CaQ3GyCRRMmWg3KYV4iINA==
X-CSE-MsgGUID: 8vnrwWCYRNuKDHzsqsU2pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75587251"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75587251"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 09:52:06 -0700
X-CSE-ConnectionGUID: oW4modzbQh+2mtP9w4rQmg==
X-CSE-MsgGUID: 33lqFoYyQ4qDMqJr67nqfQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 09:52:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 09:52:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 09:52:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 09:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TE3rSgeEEIsBSvvwEcwcMzo1X8K7qDPlVRJZH17i8xAr6PyTGzXeqUfrtElor8aiLC4VMRvW1gHnfbLfUbE7mNe9sQoTtU2FBFqEz97knU1SpRKbs/qYPzz0w0VNDaOP5g9AxAzW8FT5nBZbU/XQ2eyj0hsY5HOL6qtlHrZZrVbTeHhM6bkmO/VEZ3rEV1lRNOEGzWhgNDobqDnaZG5MFtQswQaAAki22wjrzyMY4dWZXaUyhithmZKn8r+aIWSJRkoPfA+EfR5odE4LmWK+cA7BJumG5D42FnceTd1izR4ebb3nLxWWtdMyGvxWkv5Po6zQrlJYhu2MlRqK2pmKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tXICke8pfcIF+hQopAgVMqQ3wc5qcPFC6teCwf0FLg=;
 b=QJ53yTdfSE2hcugIZvx0epO+MB36COc0BOViw8kpRWqm/QKyzTiAKET8DLRLrtcL+ENQktCF/HJbXT+Mv3lSG/9CI5b6zVOyuE/qJBM4TOQ6zJgYLg/wn9PCNmkSnTKnHFV/n8LgAdKxdehmOqr/U8MV60FVRPX6Ms+j0QLL8KWvyy0xtMapfqjQZcASzPWcIZQEK9nAONyhAn6y36lwijqtGG8mVPkGpDX+X/WiJ+5SKz4e745aQd7HuT9VNd2+FmVl6/hFlrbnRV+zWgwr/MGoaTEgLIZRRtePwcYK0BTxb+R44n6L65aulo6smLd8NFrBKx9z6/9N9Ua13VFpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 16:52:02 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:52:02 +0000
Date: Tue, 24 Mar 2026 09:51:57 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
Message-ID: <acLBLeQivtPJ6bqo@lstrano-desk.jf.intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <20260317155512.7250be13@fedora>
 <abs1Da8ntfAQISL6@lstrano-desk.jf.intel.com>
 <20260319101153.169c7f36@fedora>
 <acDGf9BYQj6KwRIX@lstrano-desk.jf.intel.com>
 <20260323105504.2d9ae741@fedora>
 <acFzpZruqlZQnQNk@lstrano-desk.jf.intel.com>
 <20260324094957.0841801e@fedora>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324094957.0841801e@fedora>
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: c67189af-11c8-4698-06af-08de89c5ac01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2ZVdw7UL1HSOKzOqapGGg03Rrl3Rf/hzlaxyw2ACOH1UlzHxZFX8PnG2j96pJ6I1qAJQYiJ2+D3WtnI/EOj4zsiEDZCi2abKQiRQkdTeK4LzcpsZkqz/rKDkDjMrzu3OSonCXx8+QM+NXxVlnGEAFmDrnCFP/pIGI0KyGFZbANYhX+8PxseohFkfr1VS76/vANMo6SPt7n0nEihtBc0iHlgrO43SCUFxWMygeKlABO4CdnT9FtmFYqSKAR7O952rXU1XBNWgGfFqn1tE+hJ93sXGcV1gQxxCFfqcdeifqo4EYQLDpSwoA5KN/mOTVx1FodujWfJUBNiPJizvcwSAcu6K9IaiuWDJBGy7ZKtEf+XVeFo5vbH2vtvBSnivrFOP8UozxIGMOyAsn0TCaZaAhvj0U/VtxKVRjPOihfmMFrBhlFV272wW1ZK/qzfoReNzhWFBTjFef74QKPH6vqQF/cMheC1ZjhkJvHx3kXhIHlbDW+Lyudjk0oaui9X+PKh8/9k4UyTE+lx+ffvQ501AP+7gKpA5VHYPcw/+ClfR/i3pDC6DyHf/QH7uG8/TqDaye5Asmw/NpWoe1/0XpQu3QEDjEYLkJFftsbKVOsaGlq527pMk8Ak5fP5vrsGWe6oA21egW3+NtuofifS1tLUjC8jsEPWy74IS4nmYHJmCwMr8Zn40xawNZSFrzRrTFkX22hU/QEsf4sFFT2ViDm4oDsP+EuwWsD4sw8MiciK0udk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRVOUhvU0JKeC9qVGNWOGREL3FiMnVHR0xQYXk1dmlwMGUzZGNlaUpKazJU?=
 =?utf-8?B?cFZkOWdLb2k4bFphbVFUQ29wenVzNWw4RGxFNG53VTJDQytndTkvd1dtRGxk?=
 =?utf-8?B?MHJUUHAzMzVVcUhQSUt2QVhBNmwrQytadUlPbkIxNnVOM2NlUGR4YUdnby9y?=
 =?utf-8?B?T2xkeWRpSTFlTlo1Sm9LSWk1RFFhb1NDODlyK1NKZ1hKUkgydHZLeFFXZTAx?=
 =?utf-8?B?RGV4c2tnZVNQNHlWczR3aU9xd1cxbEZoRW00aTVWYlhDWm52dDhZbVRRSmNY?=
 =?utf-8?B?MldhRThZUXRhc2M0akQyaXplTllEaWFSWDVpQVR4MU9SeUd0TTY1R0JyM1Zi?=
 =?utf-8?B?RENCeWNzMHZKbHo4cCtlLzlaVFdPcUJscndGRzRJMEFWSW9zYk1QSG8vT0ZI?=
 =?utf-8?B?QkhNdGlwVThFcDltYjYwUngxVHN4L1UzRnB3dGtjN2ZqakpXelFlbTNPZ0gz?=
 =?utf-8?B?N1JHcU55V2xIK1ZHYzlNVlFDTTlSQWl2V25FamFpRHd2YmNDaGo3emZxN3R6?=
 =?utf-8?B?Qk1UT3FNckdVaGtwVjF0bjZId2t0QlVRSGxEWlBQQmJ1RjdvZFN5WS9oWk5O?=
 =?utf-8?B?dUZHT2YwS1E1SXY5UTZUbVVYczRHWG9VeTl4dnkyZDZ1QWJiaTlWQjIyeDVz?=
 =?utf-8?B?c3JDK2JHY2V6aTRBRzROT3NHT1M1NXVuU05seWlzYUJKdWRRNHB5ZXFMdU9V?=
 =?utf-8?B?VndCNHBhVktrRFJta3A4ZEN0dnA5end0dDFlL0dLVTFMcFFVUXZYeFFld3dP?=
 =?utf-8?B?Y3puR1lrKzZ5MHpDbXF1UEM5S24rMXZ5MkJRQStGMHZZeUFrWHZYNVJiU3Vm?=
 =?utf-8?B?WGRCTEt5dlZTZnlzMVNoQXRSZ3h6ak0xeThTamcvSk9DdmZOOWFSckNUU0E2?=
 =?utf-8?B?b1pOSjkrWklZeEZSbnhkVjViWVBzbXZxZ1hQT3ZybUtKM1hxcXgyOEtqUWpr?=
 =?utf-8?B?MWxZV09HeUZ5YUoycjlzcjE0cmVHN25qajh1SDU0RWRoYUVSbHFML1FYYm9V?=
 =?utf-8?B?M2dCTjZMR2JOb0Z3VERIUkZ3dzZEUmFvTXpQa2hwY1FCR1BuSFhNSDhnRi9j?=
 =?utf-8?B?bEdybGlmc1BtM2d3YWxmeEI5ZkJTclBXckNhcXFHdWdMMnJ2NTVBSno5eWVD?=
 =?utf-8?B?bDQ1OHY5UnF0aStHaGlhUUUxd1dnVE1lNWNOQU5lQnh4OWYycW5PcWI0V2Zp?=
 =?utf-8?B?Z0xyT0JtaVE4bzFZMnFDMU0weThhYis3d1kyM01SZ3B1MTUrVVJuSTJield2?=
 =?utf-8?B?RHpSN04rNXhzV0JGdG02SjFqaStaTFZvT3FITnB6ZTdRaTczb1BNRUhXU2lk?=
 =?utf-8?B?N0MzUFlWSi95UUw0Ym4wZHRFVVEzUStFcVRzdzRjSmF5bXRyU0JFL0dSWERx?=
 =?utf-8?B?emtaTlAzeTdpc0tCMTAyOE1WRFVhbWlobWp3enF3WUpncEFoL3o5ZWtvRDZI?=
 =?utf-8?B?MUJBdTlzTnlnU0EyWEsvNm41U0ZORXRCOHBqcHJuaUU5K3A3R3YrVHVOYm1m?=
 =?utf-8?B?NmlERWNQMTNCZ2k5K2ZleTByRjlvczIzMUVrTkdZQk4vZkZNS2pNMjFYblBq?=
 =?utf-8?B?UkJ3SDdsU2hnZFUyWjZONk5zZGdMQlFXY1VadjRoZDFYSmo2VDhGNFl2NGQx?=
 =?utf-8?B?b2tNZUdMN0prQTFBQis1bFJoL1NQOXpLdzk5dGt4Z01LbkEyYmZwUXZUYWJP?=
 =?utf-8?B?TmRQMnFXZmwxOHZoZTY0UlZOMXhjNHlLOGtlWlNTdDc5blQyNThhb0tudlg5?=
 =?utf-8?B?bjRwTy9pV1lidTlYeGdxdWcrM1hmdmxEQ05KckRtWGFVbFlMSUZtVm1XTVZ5?=
 =?utf-8?B?RVdLZDN0UythcWk0aWtJd0g0WFp4b3VoUHMzT3dUTkMvNHZJTDdYcVhDUEZ1?=
 =?utf-8?B?Wk9CY1R1M0FYVUZhTWlETjFSOHBDN2xvbC9LMDJHUTIxQ2lHODY2OXJkUVRR?=
 =?utf-8?B?ZzRpMUJsSVA1VTBtVHJNMFF6aTl5YTlBUHQ5YS9KbktTSEpUQ3dYL3lSanpz?=
 =?utf-8?B?Y3JXSHBaeXltWnlKbnM5aEtGM0FZME9sQ3Z2ZmtGZzB2Szl2QmlMZk84WUhG?=
 =?utf-8?B?MGJuRHppRjZueGtoN3ByUUpLY2F0czUwZm4rbVFmdnVPNlhKMjFYdjlrbW83?=
 =?utf-8?B?MzVGS2t2K0Qvb0tHRUdGUXhJMEdsSU1VZmhBbU1qSVhydWRjV3g1VEVyazFL?=
 =?utf-8?B?aW5wRVVKNGd4Q3poUE5vc2x1OUJ2cXp6UlRtS2hSS0FUeXZ0amp5SUVwYnd2?=
 =?utf-8?B?RlNwQ0luelhGWURseGJSVDRsWkhTa0JhV3FoaFV3K0FZU2VIZTJpRUNXQUMx?=
 =?utf-8?B?V2w1THE0YmR2MmxzODduclQzTmJqRnF3bURjN0ZGYlA1ZU9JRGRGQUpNazAx?=
 =?utf-8?Q?oQ10hE4Q2Ij3IsZA=3D?=
X-Exchange-RoutingPolicyChecked: h5BZsx53gkAk20WtG/KFz2nsWV+9cwd0j1mZxju/dQ8+IZ5vI6BMvsiiocHiFmox5DHGNdDIgx9lapE3PUiVv99tO2Np1FVDq3b0BqLTK7bDsh2+voTZdwSeRM74c4QJdw9SXomeQdO7MlbCNAPtPN+KNg4dqO6oNxNzVZrg+kAqju4lmNVpi5lETgNkixN6RWpyVPuyOtCYIpLsHBMLKBVZHp4sG7/4VOhezg6lAPb/MidmK8Yaf3LFeyGNdvEixw1tdC+UEQM+p88Wun8Kmlkk5tHXQrUNyNDIb1HzkGkYoxwZQclTOg17W03EUTZmCHDCkb+jg/vIAi0fRCx7Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c67189af-11c8-4698-06af-08de89c5ac01
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:52:02.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC1r5qOXCrPh3bXtIVVOZjog++tfgCYlEoAzdVBFKvPIae7mQNzZjSeZCdvvFvn5DDUgL5zuryhLTkO7LV5Slw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
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

On Tue, Mar 24, 2026 at 09:49:57AM +0100, Boris Brezillon wrote:
> On Mon, 23 Mar 2026 10:08:53 -0700
> Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > On Mon, Mar 23, 2026 at 10:55:04AM +0100, Boris Brezillon wrote:
> > > Hi Matthew,
> > > 
> > > On Sun, 22 Mar 2026 21:50:07 -0700
> > > Matthew Brost <matthew.brost@intel.com> wrote:
> > >   
> > > > > > > > diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..2d012b29a5fc
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> > > > > > > > @@ -0,0 +1,675 @@
> > > > > > > > +// SPDX-License-Identifier: MIT
> > > > > > > > +/*
> > > > > > > > + * Copyright 2015 Advanced Micro Devices, Inc.
> > > > > > > > + *
> > > > > > > > + * Permission is hereby granted, free of charge, to any person obtaining a
> > > > > > > > + * copy of this software and associated documentation files (the "Software"),
> > > > > > > > + * to deal in the Software without restriction, including without limitation
> > > > > > > > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > > > > > > > + * and/or sell copies of the Software, and to permit persons to whom the
> > > > > > > > + * Software is furnished to do so, subject to the following conditions:
> > > > > > > > + *
> > > > > > > > + * The above copyright notice and this permission notice shall be included in
> > > > > > > > + * all copies or substantial portions of the Software.
> > > > > > > > + *
> > > > > > > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > > > > > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > > > > > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > > > > > > > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > > > > > > > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > > > > > > > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > > > > > > > + * OTHER DEALINGS IN THE SOFTWARE.
> > > > > > > > + *
> > > > > > > > + * Copyright © 2026 Intel Corporation
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * DOC: DRM dependency job
> > > > > > > > + *
> > > > > > > > + * A struct drm_dep_job represents a single unit of GPU work associated with
> > > > > > > > + * a struct drm_dep_queue. The lifecycle of a job is:
> > > > > > > > + *
> > > > > > > > + * 1. **Allocation**: the driver allocates memory for the job (typically by
> > > > > > > > + *    embedding struct drm_dep_job in a larger structure) and calls
> > > > > > > > + *    drm_dep_job_init() to initialise it. On success the job holds one
> > > > > > > > + *    kref reference and a reference to its queue.
> > > > > > > > + *
> > > > > > > > + * 2. **Dependency collection**: the driver calls drm_dep_job_add_dependency(),
> > > > > > > > + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv_dependencies(),
> > > > > > > > + *    or drm_dep_job_add_implicit_dependencies() to register dma_fence objects
> > > > > > > > + *    that must be signalled before the job can run. Duplicate fences from the
> > > > > > > > + *    same fence context are deduplicated automatically.
> > > > > > > > + *
> > > > > > > > + * 3. **Arming**: drm_dep_job_arm() initialises the job's finished fence,
> > > > > > > > + *    consuming a sequence number from the queue. After arming,
> > > > > > > > + *    drm_dep_job_finished_fence() returns a valid fence that may be passed to
> > > > > > > > + *    userspace or used as a dependency by other jobs.
> > > > > > > > + *
> > > > > > > > + * 4. **Submission**: drm_dep_job_push() submits the job to the queue. The
> > > > > > > > + *    queue takes a reference that it holds until the job's finished fence
> > > > > > > > + *    signals and the job is freed by the put_job worker.
> > > > > > > > + *
> > > > > > > > + * 5. **Completion**: when the job's hardware work finishes its finished fence
> > > > > > > > + *    is signalled and drm_dep_job_put() is called by the queue. The driver
> > > > > > > > + *    must release any driver-private resources in &drm_dep_job_ops.release.
> > > > > > > > + *
> > > > > > > > + * Reference counting uses drm_dep_job_get() / drm_dep_job_put(). The
> > > > > > > > + * internal drm_dep_job_fini() tears down the dependency xarray and fence
> > > > > > > > + * objects before the driver's release callback is invoked.
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#include <linux/dma-resv.h>
> > > > > > > > +#include <linux/kref.h>
> > > > > > > > +#include <linux/slab.h>
> > > > > > > > +#include <drm/drm_dep.h>
> > > > > > > > +#include <drm/drm_file.h>
> > > > > > > > +#include <drm/drm_gem.h>
> > > > > > > > +#include <drm/drm_syncobj.h>
> > > > > > > > +#include "drm_dep_fence.h"
> > > > > > > > +#include "drm_dep_job.h"
> > > > > > > > +#include "drm_dep_queue.h"
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * drm_dep_job_init() - initialise a dep job
> > > > > > > > + * @job: dep job to initialise
> > > > > > > > + * @args: initialisation arguments
> > > > > > > > + *
> > > > > > > > + * Initialises @job with the queue, ops and credit count from @args.  Acquires
> > > > > > > > + * a reference to @args->q via drm_dep_queue_get(); this reference is held for
> > > > > > > > + * the lifetime of the job and released by drm_dep_job_release() when the last
> > > > > > > > + * job reference is dropped.
> > > > > > > > + *
> > > > > > > > + * Resources are released automatically when the last reference is dropped
> > > > > > > > + * via drm_dep_job_put(), which must be called to release the job; drivers
> > > > > > > > + * must not free the job directly.
> > > > > > > > + *
> > > > > > > > + * Context: Process context. Allocates memory with GFP_KERNEL.
> > > > > > > > + * Return: 0 on success, -%EINVAL if credits is 0,
> > > > > > > > + *   -%ENOMEM on fence allocation failure.
> > > > > > > > + */
> > > > > > > > +int drm_dep_job_init(struct drm_dep_job *job,
> > > > > > > > +		     const struct drm_dep_job_init_args *args)
> > > > > > > > +{
> > > > > > > > +	if (unlikely(!args->credits)) {
> > > > > > > > +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> > > > > > > > +		return -EINVAL;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	memset(job, 0, sizeof(*job));
> > > > > > > > +
> > > > > > > > +	job->dfence = drm_dep_fence_alloc();
> > > > > > > > +	if (!job->dfence)
> > > > > > > > +		return -ENOMEM;
> > > > > > > > +
> > > > > > > > +	job->ops = args->ops;
> > > > > > > > +	job->q = drm_dep_queue_get(args->q);
> > > > > > > > +	job->credits = args->credits;
> > > > > > > > +
> > > > > > > > +	kref_init(&job->refcount);
> > > > > > > > +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> > > > > > > > +	INIT_LIST_HEAD(&job->pending_link);
> > > > > > > > +
> > > > > > > > +	return 0;
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL(drm_dep_job_init);
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * drm_dep_job_drop_dependencies() - release all input dependency fences
> > > > > > > > + * @job: dep job whose dependency xarray to drain
> > > > > > > > + *
> > > > > > > > + * Walks @job->dependencies, puts each fence, and destroys the xarray.
> > > > > > > > + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentinel —
> > > > > > > > + * i.e. slots that were pre-allocated but never replaced — are silently
> > > > > > > > + * skipped; the sentinel carries no reference.  Called from
> > > > > > > > + * drm_dep_queue_run_job() in process context immediately after
> > > > > > > > + * @ops->run_job() returns, before the final drm_dep_job_put().  Releasing
> > > > > > > > + * dependencies here — while still in process context — avoids calling
> > > > > > > > + * xa_destroy() from IRQ context if the job's last reference is later
> > > > > > > > + * dropped from a dma_fence callback.
> > > > > > > > + *
> > > > > > > > + * Context: Process context.
> > > > > > > > + */
> > > > > > > > +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> > > > > > > > +{
> > > > > > > > +	struct dma_fence *fence;
> > > > > > > > +	unsigned long index;
> > > > > > > > +
> > > > > > > > +	xa_for_each(&job->dependencies, index, fence) {
> > > > > > > > +		if (unlikely(fence == DRM_DEP_JOB_FENCE_PREALLOC))
> > > > > > > > +			continue;
> > > > > > > > +		dma_fence_put(fence);
> > > > > > > > +	}
> > > > > > > > +	xa_destroy(&job->dependencies);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * drm_dep_job_fini() - clean up a dep job
> > > > > > > > + * @job: dep job to clean up
> > > > > > > > + *
> > > > > > > > + * Cleans up the dep fence and drops the queue reference held by @job.
> > > > > > > > + *
> > > > > > > > + * If the job was never armed (e.g. init failed before drm_dep_job_arm()),
> > > > > > > > + * the dependency xarray is also released here.  For armed jobs the xarray
> > > > > > > > + * has already been drained by drm_dep_job_drop_dependencies() in process
> > > > > > > > + * context immediately after run_job(), so it is left untouched to avoid
> > > > > > > > + * calling xa_destroy() from IRQ context.
> > > > > > > > + *
> > > > > > > > + * Warns if @job is still linked on the queue's pending list, which would
> > > > > > > > + * indicate a bug in the teardown ordering.
> > > > > > > > + *
> > > > > > > > + * Context: Any context.
> > > > > > > > + */
> > > > > > > > +static void drm_dep_job_fini(struct drm_dep_job *job)
> > > > > > > > +{
> > > > > > > > +	bool armed = drm_dep_fence_is_armed(job->dfence);
> > > > > > > > +
> > > > > > > > +	WARN_ON(!list_empty(&job->pending_link));
> > > > > > > > +
> > > > > > > > +	drm_dep_fence_cleanup(job->dfence);
> > > > > > > > +	job->dfence = NULL;
> > > > > > > > +
> > > > > > > > +	/*
> > > > > > > > +	 * Armed jobs have their dependencies drained by
> > > > > > > > +	 * drm_dep_job_drop_dependencies() in process context after run_job().      
> > > > > > > 
> > > > > > > Just want to clear the confusion and make sure I get this right at the
> > > > > > > same time. To me, "process context" means a user thread entering some
> > > > > > > syscall(). What you call "process context" is more a "thread context" to
> > > > > > > me. I'm actually almost certain it's always a kernel thread (a workqueue
> > > > > > > worker thread to be accurate) that executes the drop_deps() after a
> > > > > > > run_job().      
> > > > > > 
> > > > > > Some of context comments likely could be cleaned up. 'process context'
> > > > > > here either in user context (bypass path) or run job work item.
> > > > > >     
> > > > > > >       
> > > > > > > > +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> > > > > > > > +	 */
> > > > > > > > +	if (!armed)
> > > > > > > > +		drm_dep_job_drop_dependencies(job);      
> > > > > > > 
> > > > > > > Why do we need to make a difference here. Can't we just assume that the
> > > > > > > hole drm_dep_job_fini() call is unsafe in atomic context, and have a
> > > > > > > work item embedded in the job to defer its destruction when _put() is
> > > > > > > called in a context where the destruction is not allowed?
> > > > > > >       
> > > > > > 
> > > > > > We already touched on this, but the design currently allows the last job
> > > > > > put from dma-fence signaling path (IRQ).    
> > > > > 
> > > > > It's not much about the last _put and more about what happens in the
> > > > > _release() you pass to kref_put(). My point being, if you assume
> > > > > something in _release() is not safe to be done in an atomic context,
> > > > > and _put() is assumed to be called from any context, you might as well    
> > > > 
> > > > No. DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE indicates that the entire job
> > > > put (including release) is IRQ-safe. If the documentation isn’t clear, I
> > > > can clean that up. Some of my comments here [1] try to explain this
> > > > further.
> > > > 
> > > > Setting DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE makes a job analogous to a
> > > > dma-fence whose release must be IRQ-safe, so there is precedent for
> > > > this. I didn’t want to unilaterally require that all job releases be
> > > > IRQ-safe, as that would conflict with existing DRM scheduler jobs—hence
> > > > the flag.
> > > > 
> > > > The difference between non-IRQ-safe and IRQ-safe job release is only
> > > > about 12 lines of code.  
> > > 
> > > It's not just about the number of lines of code added to the core to
> > > deal with that case, but also complexity of the API that results from
> > > these various modes.
> > >   
> > 
> > Fair enough.
> > 
> > > > I figured that if we’re going to invest the time
> > > > and effort to replace DRM sched, we should aim for the best possible
> > > > implementation. Any driver can opt-in here and immediately get less CPU
> > > > ultization and power savings. I will try to figure out how to measure
> > > > this and get some number here.  
> > > 
> > > That's key here. My gut feeling is that we have so much deferred
> > > already that adding one more work to the workqueue is not going to
> > > hurt in term of scheduling overhead (no context switch if it's
> > > scheduled on the same workqueue). Job cleanup is just the phase  
> > 
> > Signaling of fences in many drivers occurs in hard IRQ context rather
> > than in a work queue. I agree that if you are signaling fences from a
> > work queue, the overhead of another work item is minimal.
> 
> I'm talking about the drm_dep_queue_run_job_queue() call which in turn
> calls queue_work() when a job gets reported as done. That, I think, is
> the most likely path, isn't it?
> 

Oh, I think I understand what you are getting at...

drm_dep_queue_run_job_queue() is called less blindly in DRM dep compared
to DRM sched. When a fence signals, drm_dep_queue_run_job_queue() only
kicks a worker if the SPSC queue is non-empty and the signal may have
freed up the credits needed to call ->run_job(). This could likely be
optimized further to skip the work item if the run_job path is blocked
on a dependency, though I’d need to think through the races.

With the way credits work in Xe (we have many per queue), it is quite
likely this won’t be triggered. Therefore, the extra worker kick to put
the job incurs an otherwise unnecessary context switch. If
drm_dep_queue_run_job_queue() always kicked a work item, the additional
work item would indeed be less costly.

> > 
> > > following the job_done() event, which also requires a deferred work to
> > > check progress on the queue anyway. And if you move the entirety of the  
> > 
> > Yes, I see Panthor signals fences from a work queue by looking at the
> > seqnos, but again, in many drivers this flow is IRQ-driven for fence
> > signaling latency reasons.
> 
> I'm not talking about the signalling of the done_fence, but the work
> that's used to check progress on a job queue
> (drm_dep_queue_run_job_queue()).
> 

See above.

> > > >   
> > > > > > 
> > > > > > Once arm() is called there is a guarnette the run_job path is called
> > > > > > either via bypass or run job work item.    
> > > > > 
> > > > > Sure.
> > > > >     
> > > > 
> > > > Let’s not gloss over this—this is actually a huge difference from DRM
> > > > sched. One of the biggest problems I found with DRM sched is that if you
> > > > call arm(), run_job() may or may not be called. Without this guarantee,
> > > > you can’t do driver-side bookkeeping in arm() that is later released in
> > > > run_job(), which would otherwise simplify the driver design.  
> > > 
> > > You can do driver-side book-keeping after all jobs have been
> > > successfully initialized, which include arming their fences. The key
> > > turning point is when you start exposing those armed fences, not
> > > when you arm them. See below.
> > >   
> > 
> > There is still the seqno critical section which starts at arm() and
> > closed at push() or drop of fence.
> 
> That's orthogonal to the rule that says nothing after _arm() can
> fail, I think. To guarantee proper job ordering, you need extra locking
> (at the moment, we rely on the VM resv lock to serialize this in
> Panthor).

Yes, you need a lock. The VM resv lock is typically how we handle this
as well, but of course in Xe it gets more complicated for kernel-issued
binds, which share a queue across VMs, or in compute cases where we do
not take resv locks in the exec ioctl paths.

> 
> > > > 
> > > > In my opinion, it’s best and safest to enforce a no-failure policy
> > > > between arm() and push().  
> > > 
> > > I don't think it's safer, it's just the semantics that have been
> > > defined by drm_sched/dma_fence and that we keep forcing ourselves
> > > into. I'd rather have a well defined dma_fence state that says "that's
> > > it, I'm exposed, you have to signal me now", than this half-enforced
> > > arm()+push() model.
> > >   
> > 
> > So what is the suggestion here — move the asserts I have from arm() to
> > something like begin_push()? We could add a dma-fence state toggle there
> > as well if we can get that part merged into dma-fence. Or should we just
> > drop the asserts/lockdep checks between arm() and push() completely? I’m
> > open to either approach here.
> 
> If we can have that INACTIVE flag added, and the associated
> dma_fence_init[64]_inactive() variants, I would say, we call
> dma_fence_init[64]_inactive() in _arm(), and we call
> dma_fence_set_active() in _push(). It'd still be valuable to have some

I think it is a valid use case to add an armed fence to dma-resv or sync
objs before calling push(), though. Xe doesn’t do this, nor does
Panthor, but IIRC other drivers do, and I believe that is completely
valid. Of course, as discussed, once that is done it becomes the
no-failure point. Hence my reasoing was make arm() the no failure
point...

How about I add a make_active() call? I can start by moving the lockdep
checks I have in place from arm() to make_active(), and we can
incorporate the dma-fence suggestions you mentioned into that logic in a
follow-up, since that is a broader change + would need buy from dma-resv
maintainers.

> sort of delimitation for the submission through some block-like macro
> with an associated context to which we can attach states and allow for
> more (optional?) runtime-checks.
> 
> > 
> > > > 
> > > > FWIW, this came up while I was reviewing AMDXDNA’s DRM scheduler usage,
> > > > which had the exact issue I described above. I pointed it out and got a
> > > > reply saying, “well, this is an API issue, right?”—and they were
> > > > correct, it is an API issue.
> > > >   
> > > > > >     
> > > > > > > 
> > > > > > > In general, I wonder if we should distinguish between "armed" and
> > > > > > > "publicly exposed" to help deal with this intra-batch dep thing without
> > > > > > > resorting to reservation and other tricks like that.
> > > > > > >       
> > > > > > 
> > > > > > I'm not exactly sure what you suggesting but always open to ideas.    
> > > > > 
> > > > > Right now _arm() is what does the dma_fence_init(). But there's an
> > > > > extra step between initializing the fence object and making it
> > > > > visible to the outside world. In order for the dep to be added to the
> > > > > job, you need the fence to be initialized, but that's not quite
> > > > > external visibility, because the job is still very much a driver
> > > > > object, and if something fails, the rollback mechanism makes it so all
> > > > > the deps are dropped on the floor along the job that's being destroyed.
> > > > > So we won't really wait on this fence that's never going to be
> > > > > signalled.
> > > > > 
> > > > > I see what's appealing in pretending that _arm() == externally-visible,
> > > > > but it's also forcing us to do extra pre-alloc (or other pre-init)
> > > > > operations that would otherwise not be required in the submit path. Not
> > > > > a hill I'm willing to die on, but I just thought I'd mention the fact I
> > > > > find it weird that we put extra constraints on ourselves that are not
> > > > > strictly needed, just because we fail to properly flag the dma_fence
> > > > > visibility transitions.    
> > > > 
> > > > See the dma-resv example above. I’m not willing to die on this hill
> > > > either, but again, in my opinion, for safety and as an API-level
> > > > contract, enforcing arm() as a no-failure point makes sense. It prevents
> > > > drivers from doing anything dangerous like the dma-resv example, which
> > > > is an extremely subtle bug.  
> > > 
> > > That's a valid point, but you're not really enforcing things at
> > > compile/run-time it's just "don't do this/that" in the docs. If you
> > > encode the is_active() state at the dma_fence level, properly change
> > > the fence state anytime it's about to be added to a public container,
> > > and make it so an active fence that's released without being signalled
> > > triggers a WARN_ON(), you've achieved more. Once you've done that, you
> > > can also relax the rule that says that "an armed fence has to be
> > > signalled" to "a fence that's active has to be signalled". With this,
> > > the pre-alloc for intra-batch deps in your drm_dep_job::deps xarray is
> > > no longer required, because you would be able to store inactive fences  
> > 
> > I wouldn’t go that far or say it’s that simple. This would require a
> > fairly large refactor of Xe’s VM bind pipeline to call arm() earlier,
> > and I’m not even sure it would be possible. Between arm() and push(),
> > the seqno critical section still remains and requires locking, in
> > particulay the tricky case is kernel binds (e.g., page fault handling)
> > which use the same queue. Multiple threads can issue kernel binds
> > concurrently, as our page fault handler is multi-threaded, similar
> > to the CPU page fault handler, so critical section between arm() and
> > push() is very late in the pipeline tightly protected by a lock.
> 
> This sounds like a different issue to me. That's the constraint that
> says _arm() and _push() ordering needs to be preserved to guarantee
> that jobs are properly ordered on the job queue. But that's orthogonal
> to the rule that says nothing between _arm() and _push() on a given job
> can fail. Let's take the Panthor case as an example:
> 
> 	for_each_job_in_batch() {
> 		// This acquires the VM resv lock, and all BO locks
> 		// Because queues target a specific VM and all jobs
> 		// in the a SUBMIT must target the same VM, this
> 		// guarantees that seqno allocation happening further
> 		// down (when _arm() is called) won't be interleaved
> 		// with other concurrent submissions to the same queues.
> 		lock_and_prepare_resvs()
> 
> 		<--- Seqno critical section starts here
> 	}
> 
>  	for_each_job_in_batch() {
> 		// If something fails here, we drop all the jobs that
> 		// are part of this SUBMIT, and the resv locks are
> 		// released as part of the rollback. This means we
> 		// consumed but didn't use the seqnos, thus creating
> 		// a whole on the timeline, which is armless, as long
> 		// as those seqnos are not recycled.
> 		ret = faillible_stuf()
>  		if (ret)
>  			goto rollback;
>  
>  		arm(job)
>  	}
>  
>  	// Nothing can fail after this point
>  
>  	for_each_job_in_batch() {

With my suggestion above...

		make_active(job);

> 		// resv locks are released here, unblocking other
> 		// concurrent submissions
>  		update_resvs(job->done_fence)
> 
> 		<--- Seqno critical section ends here in case of success
> 
>  		push(job)
>  	}
>  
> 	update_submit_syncobjs();
> 
> rollback:
> 	unlock_resvs()
> 	<--- Seqno critical section ends here in case of success
> ...
> 
> How wide your critical seqno section is is up to each driver, really.
> 

I agree with this. The same logic follows: by adding make_active(), a
driver can decide the critical non-failing section.

Another thing I could add is an option for a driver to register a
lockdep class with a DRM dep queue that asserts the lock is held in
arm(), make_active(), and push(). GPUVM and GPUSVM have similar
interfaces, for example in functions that must be protected by a
driver-side lock.

> > 
> > > there, as long as they become active before the job is pushed.
> > >   
> > > >   
> > > > > 
> > > > > On the rust side it would be directly described through the type
> > > > > system (see the Visibility attribute in Daniel's branch[1]). On C side,
> > > > > this could take the form of a new DMA_FENCE_FLAG_INACTIVE (or whichever
> > > > > name you want to give it). Any operation pushing the fence to public
> > > > > container (dma_resv, syncobj, sync_file, ...) would be rejected when
> > > > > that flag is set. At _push() time, we'd clear that flag with a
> > > > > dma_fence_set_active() helper, which would reflect the fact the fence
> > > > > can now be observed and exposed to the outside world.
> > > > >     
> > > > 
> > > > Timeline squashing is problematic due to the DMA_FENCE_FLAG_INACTIVE
> > > > flag. When adding a fence to dma-resv, fences that belong to the same
> > > > timeline are immediately squashed. A later transition of the fence state
> > > > completely breaks this behavior.  
> > > 
> > > That's exactly my point: as soon as you want to insert the fence to a
> > > public container, you have to make it "active", so it will never be
> > > rolled back to the previous entry in the resv. Similarly, a
> > > wait/add_callback() on an inactive fence should be rejected.
> > >   
> > 
> > This is bit bigger dma-fence / treewide level change but in general I
> > believe this is a good idea.
> 
> I agree it's a bit more work. It implies patching containers to reject
> insertion when the INACTIVE flag is set. If we keep !INACTIVE as the
> default (__dma_fence_init(INACTIVE) being an opt-in), fence emitters can
> be moved to this model progressively though.

See above. I think we should start with the make_active() split and then
see if we can get dma-resv/dma-fence updated with this semantic.

Matt
