Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A7CFF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239E910E4A1;
	Fri,  1 May 2026 06:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NBQiU2Il";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE4810E0B4;
 Fri,  1 May 2026 06:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777616896; x=1809152896;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZojGBuk+Lj2e7UnJ2m9lEv7gbbi8PYeIJyWufk7VK38=;
 b=NBQiU2IlRXgT7oBvoWtgvXiG2R3K0fW6zDjTDX/wuXM6ryShL3Ik1nlk
 9I03VwTuSXKkoQ+SAtVU98yX+Vpd9RUGwZqxZZ637yhRRBZ7QSf+0nUZ3
 4uVhhcnGRCvJqQPzbFoOuhDqYVD8j0g7Ih05SIVDvZMgF+1VuNuhGDpOv
 ZhgcyLfLwULvqEhhtAJ7BYIwDSP4T2P9jTyvxvY4VmllKFn8L1PwJji9g
 u9kxgFB7P06YWegXaFZchUGnDDQY+zBJNIkKTlZQHIN467pLA/nNMx1AA
 oOAoyLkJLRK1feBhoKtEPV1myz3R4zDspxRm10f7FARHThXBgyMSrJdGs w==;
X-CSE-ConnectionGUID: wq2i2t7wQZKuCrA564K9Jg==
X-CSE-MsgGUID: FzR+yxH2Rkqs2kTPXS1dOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="82186857"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="82186857"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 23:28:15 -0700
X-CSE-ConnectionGUID: rwdNYWguRXyS/mGLkejTNw==
X-CSE-MsgGUID: lI5TxS3nRRWbHzb3BZBssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="234855057"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 23:28:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 23:28:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 23:28:14 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 23:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C512PChmntfh/JraFSg0QVBIK1ch3Eef4VBC06damNNRklQCsxbf3XEngFyOBwBCLkxWMu2Byi5CU8bMxvw8eKykWta164lApxPa7Nnis7X5ONhKPAoJlyUs8wZ/gTKkvhz2tc9Sepf6vLWLsxJBhnWRI9B0iLduNvZmdWsvM1d5aays0n/sj9hXdiKeN7sp6DoSr0WrJywib7gBQ11VsWB12/xUgmpA0UixQMZrjfcodlC2Adbi+0RedjFXUv9VFB+lcf3ublgzF1Z2cGcQdCgA87saECmTB1wWDqM0sy21+i3PG5eyv1Sskwhr1Mv6ysTnCayKSJgtgrBqfCDMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz3oaff/x/3Z5v0YFyguA7nWKQwM+G+t2jcU9wl/W9E=;
 b=FOO2ZePuN2LdfxSXD8IS+zBRqgc57XqAwpKWbnzKl1gcpFWK4Jjpl9zVxZ2uyE2SNY5m2klXLE3yGAmavelPtq4xxWsER93ex6eBvxvNsqZ2gs4r6L6hyxJiZW4BLtTWjCU2xP3r9GY7pT+brcqVyL7WGjQU+cwY8ergSJcXs/3NbtqdPLJ3lQWZmMD1YqDXi+Geg8+p+g4heYxEI0FV7N0Zj7LJP2hcq4EWiHL57RESZsk5uM5kMq45amReRgQ3cMIKxXWTVK1iSWFLWMBdt8FCyiWw5Uztv2JTxfRE0bFEHH1+ll/RVM0baxFbLePHqWB/r0ZeFaUCQ+LWqrrhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 06:28:12 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 06:28:11 +0000
Date: Thu, 30 Apr 2026 23:28:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Dave
 Chinner" <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 "Roman
 Gushchin" <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>,
 "David Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] mm, drm/ttm, drm/xe: Avoid reclaim/eviction loops
 under fragmentation
Message-ID: <afRH+KUNw9zap4sp@gsse-cloud1.jf.intel.com>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
 <20260430160105.a3b74ec3bb316bbfbf8f9808@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430160105.a3b74ec3bb316bbfbf8f9808@linux-foundation.org>
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW4PR11MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 629a5b77-bee2-4af0-618c-08dea74ad161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +5tbvZ5Ri6VP8NzbwLY+lnJtXiJ+IdPGiBK5FoDC1NxaOwBYYqUw9YlrRfyqRgcdDLUVXEpF2Eecd/j1YQR9fFAqn0jotZxKIwdCkdWtl6178u+RnBbHO6J2NGSTd0sZpWjlbKWNi+mK/EHPhJb8Ytg47HSh4NqkbOB2OzNSiRepj9Vmz6DmVLU3uvqhVyUAOFXaAZjdzyZBWJtu9O3UbN7bMVeAK3UPfCIYC0IVyXmS0WW/4xntFWqvKwkjqKPp5cKn4S/WkTJJD1tQVn4bZuJe/wlGsIK55/wqw7TEWw4/Z6XSQGIEPTiuxUlZlLC+nTgBkfc3r8t6Qz+Sz29qm98sftRiiW4/8e4a3rCjYekyO82nqxqoeKsuGECAVVM/aQg1y5HKq3s/IY+pmxaZYSWsSASQXlsc06qA1NxYJRgkMc4lAlg25V7FsWSw9C2FftOvwXMihf2AI5Iv4uw2J2iBWdZ0IKEmk7fPNgtVmU6yPhgzbhD30Dw2bGN8hnkq29S7E4d81U3K2nMvIOmfSxiJrU53O5rvVn6AntjFv1WHfVum7cSha9U8UN/3clFTjUu7YWreyyI9aEmYWJQo+/GNYZAFzHOXwE16v3l0EIMER+xuEHPV8fxccNYpl/6vJ/08SmQM9B23a4iMjfYfdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RGRmVMdmtIRlVudjRPQmJYazBlZ21DeEtwbkJSZGU5T0xzS2E4Z3pJVEhy?=
 =?utf-8?B?bHlLbXJOekZxUi9MOEdRWHNrV1lvRUNqMmMwSkZ5NjBhN2ttdzRPNVBzR05h?=
 =?utf-8?B?aVNrSzJISDEzbzVDR21kVzMxUGllMDE3blprSGZ2Nkt2allicGJXZ0J4eEVt?=
 =?utf-8?B?d3E5VnQwTFptTTZOTS94eVVZdHMzVFk2VTl1UVpLRHd1VU1nMVNGdzBHWEhJ?=
 =?utf-8?B?bkNidmxPcVVydWYxNmlkSUJ6SWxlQjVFQ29JUXhkVjlXUXVGcFk2YWlxMHdv?=
 =?utf-8?B?Q2NUYkc5VVN4ZkFsV0tyUWlsK0VFTlk2TGJKMTN3MXZRZVNXbWsrR0ZsT1l1?=
 =?utf-8?B?TEZ2VXJWK3NDQkR0aTcwUExES2doekt2NFdFMnNraHg2OXh3eXpvaWREdU1K?=
 =?utf-8?B?UExZOGhjdWwwd2t6bnVKWWsvcm44V0ZDY2IvbHlCeTFaQVhDaEpaV1ZuZ3JQ?=
 =?utf-8?B?MUtFcHArOWRzMzhYdC93dFFQYVM5VUVFSStiRlBqRlVNTjNnc0R0M0ZIN2lN?=
 =?utf-8?B?NWZMakxncEJWVHNNYzhpK25TeVN6RDVaQTZxMEdhYUg5akl3NFZqR0orMms3?=
 =?utf-8?B?aXF6OGU4eUN6cjUydnVWT2RUS2ZaelRRcXdXR0xVOTRuWFBjZk82cUNGZU5h?=
 =?utf-8?B?eUVDK29VUFRITHdEaEVQczlqQlc0UWZNdjVkMmp5N3EyZmluRXpoNGZEdVRz?=
 =?utf-8?B?ajFrVjJkUEgwUURFY25kc1p5VjBNMDVWRUtRTEx5aTNYNVpOcXFLaDA5SFl1?=
 =?utf-8?B?d29pMzFDVGtaSXZpTUd2V0pETlllRVdFeDJtOVcyNjhqQWVabzFpYnlreU13?=
 =?utf-8?B?WjF5Y3I3UDgvb2xPdEE5V3U5dFVSOHNXNEhLOTZCYUQyWGU3dWNhMy9uTEk0?=
 =?utf-8?B?THZLblB2R1Y1SWR0Mmlsa1BBaitVLzh4OHlBWTMyaXFjL0NmTC9qYUNkUTZL?=
 =?utf-8?B?RUd2ZWYrOVl4VW1Bd1N4VnpIRHhmTCtsQ0ZTSUVNbS9aUGdwc3gzdmdzRDB1?=
 =?utf-8?B?alUwUVdLeUY3eFFUWDMzOXNJNXkxN294SEh3WlBVZ2VHMGtzaWd5SVVoRy81?=
 =?utf-8?B?ZXhDZUlGV3BlbTVsbEdtN2U0dTFDaG8yOGxhY1ZYN1dmYXdnQlFGeEFFZUlG?=
 =?utf-8?B?MWh6Ui9IOGE0cWZZWExWUEZZQ1Z6cTdRZkRxZkxvT0JubHdxbTFiM1dneDBB?=
 =?utf-8?B?aElzRDFSYkZUWFFnUHcwSkJZSUJMSHBKTGJ2c2xxR09WRENaSWRqRGVrK1NP?=
 =?utf-8?B?L0hCR0YyajNMSEMxYWNpL3IwdGhqS25UUHNlWnRLWVhXTTlHeU9COVoxbUZ2?=
 =?utf-8?B?Z3ZJTU5PR3IzWEN2azBDOGlSdTllc3N5Ly9lMUVIU0pzaVZVOWtDTzl1Wmhs?=
 =?utf-8?B?MlpqR1BlRXBFeGdIbU43TVFkZVlVUUIzRmFtOUpRa3RpNk9tM0pPbXl3bStx?=
 =?utf-8?B?MU90ZkpJVWZ1cWdxNkh4KzcyNmp1R0Z6bjFPRlpHWWhPa0tVMGJqVFlHL0cz?=
 =?utf-8?B?UUowRTVSSXJKQnpFWjhqZFBhODU2NjhMWGVLS2RGL2JLS3VJR3I3eVoxc0JX?=
 =?utf-8?B?WHE1VWJTQnFlaTBoYlBKZTRMOUpNVk1vRU1keUw4bE93SDBEcUlFaHhKSFZo?=
 =?utf-8?B?U0VnQ3Vtc2VZdGJxYUtPaS9WK2huUjZJbWEvWDlXeWJyNnljMVdZLytHTFpM?=
 =?utf-8?B?S1lKSWNwajhQZUpTVmdBSUhtQ0xqVHdTMWRjdkJpdWxTbkVhUmo1bHhYdERo?=
 =?utf-8?B?WUo5UDIvVGF2ei93U2drK3NFTWtWQldTamxkQThCeW5tQ1hJUVpJTjFwaDRL?=
 =?utf-8?B?TklJSEs4ZnFTWGxjYlFXcEpvV0x4SlZLM3hEa1R3VHFrcXRmcU9VdVNHd2RH?=
 =?utf-8?B?U2RuZXhNV3dRcDNHRkdqc1YwTG5JNEJwTzVUQWdoZG93WnVraG5zRmt5ajZ6?=
 =?utf-8?B?MTdjYlEwckZySmlrbVQwa1U3Wmhtb29CSmlFMnZ5YnFXNVZZNDhya01Dc0wz?=
 =?utf-8?B?N3MwM2REeDlWbi9OTHd3YjAwQ2lXcE5UK1IveHh2UWRnQkV5OHIzUUV5eVhX?=
 =?utf-8?B?MG1sQ1hUS3Fjd1RYSXJic281WWFzamxrZ29MeHFwWUZPTWtvTjdtSmhZMEN3?=
 =?utf-8?B?TmR2aXd0dG5tWGtRVmRkaWFsQWt2MmdIZi9LNHVRKzVaQzlHWWp2T05VUENS?=
 =?utf-8?B?OEZwTE40Z2ZwVEtGc3VwUWlZK0ZQTTZOMFMyS29rZHJHSUpjZDBwelFZT3Yv?=
 =?utf-8?B?VXAzN0p1K25maU5VVnlvY1dYOTZGTWJDOWtxYnJia1U4MkhvZzBLRlNDZGl2?=
 =?utf-8?B?eVMwcVIrdVk5cGlOYzBibHhBVHQ5aUJWYW04MEJWZnU2SkZhaGpHdz09?=
X-Exchange-RoutingPolicyChecked: HKrRE1N5Muc4ryYi1ta1iUmfhSD1AJ2Hkpmq2UCpWRLxzIi0CckzC8gSdkO/gpUFX0RpKKlgVmumYVKWo0UhJwFmJvOw/TdW+UJSPkRrkzzSYzjkPQOCsdgMxpADe2+6R4dbhPydmj3iwSmn8noji8zPr4lS/mRQOakX338kKSIK1SJ4DMj3zT/u3fa41rVC6oCyrJyFipdTeWVX+Sj0xXvdaHvuFhUn+3C2EV6TUZ7+vzHPuvub7wS7dyn1qVt9YQBlWHCWhPN8D0bOdU2ILB9HVj0f670P8bCeWwt0rTpzcMq3WVUg3EiGqOrwT/dfsKkGg7lYKWdXvLAHwjpGzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 629a5b77-bee2-4af0-618c-08dea74ad161
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 06:28:11.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6lWkzdsWLr+T8VjFBZFFS5vsslbmwKxDrE2GcgabKbOt32ZzpkH1r9svDwEVeBkwFUWJFqE+47yL4Xq4UvGSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6887
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

On Thu, Apr 30, 2026 at 04:01:05PM -0700, Andrew Morton wrote:
> On Thu, 30 Apr 2026 12:18:03 -0700 Matthew Brost <matthew.brost@intel.com> wrote:
> 
> > TTM allocations at higher orders can drive Xe into a pathological
> > reclaim loop when memory is fragmented:
> > 
> > kswapd → shrinker → eviction → rebind (exec ioctl) → repeat
> > 
> > In this state, reclaim is triggered despite substantial free memory,
> > but fails to produce contiguous higher-order pages. The Xe shrinker then
> > evicts active buffer objects, increasing faulting and rebind activity
> > and further feeding the loop. The result is high CPU overhead and poor
> > GPU forward progress.
> > 
> > ...
> >
> > This series addresses the issue in two ways:
> > 
> > TTM: Restrict direct reclaim to beneficial_order. Larger allocations
> > use __GFP_NORETRY to fail quickly rather than triggering reclaim.
> > 
> > Xe: Introduce a heuristic in the shrinker to avoid eviction when
> > running under kswapd and the system appears memory-rich but
> > fragmented.
> 
> Please cc everyone on all the patches?  It's kind of annoying to have
> to hunt around to find out how these proposed changes will be used. 
> Personal preference, anyway.
> 

Will do - we discussed this in the past and thought we landed on Cc
everyone on the cover then individual patches but will blast everyone
going forward.

> AI review flagged a few possible issues:
> 	https://sashiko.dev/#/patchset/20260430191809.2142544-1-matthew.brost@intel.com

Idk, who authors sashiko but what make it really nice if you could reply
to it to talk things out.

Looking at replies...

- 'Could this global counter drift significantly'
	this is looks right for multi-CPU which isn't really the target
	here, but will adjust

- 'Additionally, does NR_FREE_PAGES implicitly include CMA pages?'
	this is looks right, will adjust

- 'Can high_wmark_pages(zone) evaluate to zero during early boot'
	theoretically possible (?), but non-issue IMO, certainly a GPU
	shrinker which is current use case this is impossible but maybe
	add a warn_on if high_wmark_pages(zone) returns zero

- 'Is this description accurate?'
	I inverted the TTM kernel doc vs the code, will fix

Matt
