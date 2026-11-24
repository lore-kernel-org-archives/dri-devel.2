Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F1606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b844NRNV;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Mu3pKCkd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6EC10F6D9;
	Tue, 24 Nov 2026 15:51:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0FD10F6D9;
 Tue, 24 Nov 2026 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795535508; x=1827071508;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=4r1ffuAeYkuVMmlvNr6ieWt2CgKbqXVsdvSbsofAjfo=;
 b=b844NRNVppacU6bZ997nYuADjLhNNH891Ve/wfSm6w4xh8nEsVVjtbgy
 lVoZBvzuF7vX0JalnGKmg6wjkfBF8F7v9RhVPKS/CldsR1y6yDLsji7uc
 UpISlTRpIPA4BHHelyrB3uBliz+9D8L04GNVzCL9H78VtnHA7pFhTS3a6
 ByK3yP76qgxe5yXGzAL39tmEtEO50YY4NLB5MUe9ZfZmsAuafdUoA2crD
 4hZXAegWX3EVy8+g0gtfM7rTVkiCUfXcckF4bLLH8IcgX9A6fV0WRfDH0
 yYmKdTYEJ56JSFmH94jfb8z34GHNjZGwqO/xetaObbHcJyKWGux718bab w==;
X-CSE-ConnectionGUID: HtY0RuWdShaGFU0PzT8RZw==
X-CSE-MsgGUID: d3d20pgsQ4umabNWXcI6yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4469482"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4469482"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:29:53 -0800
X-CSE-ConnectionGUID: bbrgjBjzSxyQo1Ied2u+2A==
X-CSE-MsgGUID: DLuAqGJqSSiXkqCAGietOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11569140"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 07:29:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:29:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 07:29:52 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 07:29:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX3JktNCElt0/QkRE6nWzInxvuXTz5Xx+uqCGlwpLejvMN2ThQ3ihs/S8SzgOBZFofHqD75iOPb7GpSt+Uca9swQEIddutNTAjMZqkopCcE5YLuXVd2uOeYaU360rInGtfeNcrKutw3MFfrRxcsW2kMpP3yfCascmR1qy2zJ9/w6ilzh7AiA3YI6LguDjLk2kFg+/R4hdrLw1pZvoRkf9tyRO2M5IvpYjt08tEOLWdr2V0hGa121Xi6hclk57HW8kzGQpZ5jZ2c88bQoZUU87hqnSTG3e3LIbYmH78fI1S0HUNGHpY+tP3+6JgNvqhq1IXf568cYceqEq9pN3AT4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s02IWw27U7bML5YHS2JN6O2x2NE89xsxbTKwyFrbzUc=;
 b=rnkGpbXennGKQ7x4K6wOr9nvAdyFS1rhoe7Pv5Mp2HHaKbocbX13MMsjwcg0vppEJLKOnd9Y+t82BpBX1zk4jzXMfNM0bGEJhpVuKlu/5ieIsxQelW8zyeFTYWaF2InftCzw24vqIAs/dg69y2K9C5a3srreNND0rr4Hn38vdTIMfRnKLg+g6IdD7o0sXufAthoFvuu/wTqug4ltlAgi0bSo/tQS1/MCO/MZr2JNISVOOGFu3o72Yv6i2dRv1AhQwYu6HpNDSmY/XKOFeMr7QmOCp5Ddjtn4IViLlp6iKEmoCzfsVwTccya4bWJwZIgHOApU5u0AvpLLss9XZTgrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s02IWw27U7bML5YHS2JN6O2x2NE89xsxbTKwyFrbzUc=;
 b=Mu3pKCkdSbDrbKzXwiYnSsZa3cS9kdxlqjJF7PhKsiJteZHZkcuqYn0pHwPB0wraNhDTVq2Ac+YdMdRYS95YBuevaOLfMXmCRLSF/s2fY8iR+SoLUUvR4TJrNQzbOb0d2MG5N7LN4unUF8VbfNJAClFMjXAlT/5AC7bBKGshlgQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 15:29:49 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 15:29:49 +0000
Date: Tue, 24 Nov 2026 10:29:45 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@linux.intel.com>
CC: Dave Airlie <airlied@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, Ian Forbes <ian.forbes@broadcom.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>
Subject: Re: [PATCH v1 1/1] drm/ttm/tests: do not count pages after pool's
 teardown
Message-ID: <awWtaej2_LwbdgAM@intel.com>
References: <20261124004312.3880264-1-michal.grzelak@linux.intel.com>
 <20261124004312.3880264-2-michal.grzelak@linux.intel.com>
 <CAPM=9tz_nwv4Cy5N_ihBqp6JS5rghETbJYiub4aVrJh=wy2-iQ@mail.gmail.com>
 <dme6l2hqdoxoavmormwnskhzogx6ojevu7aofnokbtqx2yl6qf@z3ligafvj6fi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dme6l2hqdoxoavmormwnskhzogx6ojevu7aofnokbtqx2yl6qf@z3ligafvj6fi>
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS0PR11MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: d67e075f-3a77-4723-d735-08df4a3fc6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261028144727099003|10067099003|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|261021135927099003|261022075727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V2BO4SBPUGGnkofEGzP2mNHagR5P1TNzLC7Rzai+RfGWZjzfNklbj3L9FV5Uiudga/o+YjKgcMvi+eUI7l13KwLSKKF34xtaQojBfwyHCu2jSUwHjIZb75dZoX8U0nbHRHgPV3I50uYSxi6j+y85vFp4GYNlyDA3HwQQDVh9mVscg01qBhLwkQimVRkYGK3XnO82MGxWIYgn/nEpBF5ebqQ22FtCS8b9CbiHYu8V8rk0AkCoQ9V63WzmwJNB1bXCUjmqHkuhwv1AMKTJPeSz0/YWoekuBsIscAHn9SXfkYO5PsX6BGcP2P+qrkrLh0Jk3awGfvSV71FMej4aQUK11LuES2M9cEk0Q5LFTJQhfHvz6IOl+aNYHTmiQWWVjcors36B0p4pr+u7BLFAG3bKwe1h4Qu1CQujZdOFMRuU9njAs1PjGn/Be/bfkPtRkl0aB1Ec1l7sxNGqlOg1+4bGz4xafzGWtndkkdV7JFdO9Z+tyOGPulTs++LIJfJ2NUMrIaAgHMhdoDuKEgOpRQiQQcs+uyuibFZLuUGFQukGDZBkrWYIwa0xetBRVrBGPwjrXKLey9iUxjaZYnPsMXxsYIkGBICD0ay0Nt6CFaeZoZu/AmeayLz8zzsLjHwNkreLIo7TKfN8Kcyv1SsvNvSMdSgkT3dptwhYxhX/ozlZjd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261028144727099003)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021135927099003)(261022075727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVmdVZPakJJL1p3dTVIY1hTVU5GMUVNb01QR2taMU1LaHBVNzhOL3plNHFN?=
 =?utf-8?B?Y0tjWUtJcG9IMjFTSFlUZklaVTVhUXdJQXNxUC9vbHVRQ2EwRXErMlhiRGhs?=
 =?utf-8?B?cGJSNVhDc0xJcmhPa3NDOTd1Nks2Sm9Fc04wT2YveVV6NDlFQjNXenJsS2lR?=
 =?utf-8?B?UXozSUNHa1JiNWFxT2w3akJKcnJwTWVTUTVZaXhLK3M5UEZLNnJpQ2taaXFS?=
 =?utf-8?B?cGY2Mkl1cG15NTl3K3BReURVekJQaWRwWkJoekVLVXpsRVZUNzVGTzhGeHF6?=
 =?utf-8?B?YVg5YWMxSlNRMzdBVmdqU1htaHVXTDZNdkRZYlV0MGlxelR4a3IxZHZHVklT?=
 =?utf-8?B?YlJCSGd6NnpiN2NhYjcxOTFXNm4rMk1kMHkyN2xQbm9uYStvdER5Yk5jQlBt?=
 =?utf-8?B?cFNYTTQvYzl4eG5rNzVYK2ZGMmd2RGlHVmtBOUF6ekxDU2Rpb3NoN3ZJdHY3?=
 =?utf-8?B?YmdQSXZGZExvRVdkdWRNbC9TV3hYbW4yT0UwTFgzOHZZK3VFYmRyWlhHVnZS?=
 =?utf-8?B?RFhWb0RUY1M2YjNsOTFiMFdEZVBsK1FQZzhvT2ljU1RTVFREc1Bmc25sbWR3?=
 =?utf-8?B?bE1OUGltRlN0OFMyaGVqckJ5ZDhoeVpSRml6d1lDQjkydnd6M2Z2aEtoUVNR?=
 =?utf-8?B?SWpyMHcrRzI2dVBEOGdWQUJiczBNNmlKQTFrZkNkT2JUZURIakdudnhaQnhX?=
 =?utf-8?B?Vm1XUmZ3L1M3WVRsSEZvbUh3OGhhc1ArWUU3TWxjUHJUcGdNT0hJT1ZyMWln?=
 =?utf-8?B?SVZYOWw2Tm5jYkxxZUVFZ1ZZbHJuQmNWMjg3RmZzUUdSS3FEV0EvM2lwZzBa?=
 =?utf-8?B?L3lkdU9ETjlyNDlaZnNNbW13VW5xbW80WHIyNDdBTVRkbmZhM1hzUStWUW95?=
 =?utf-8?B?L3YwanRkdkdxMFplWkNlRElYTnJsTXNvSzRkL3BuN0ErN3RSM2psaDZXWG5J?=
 =?utf-8?B?S1V1S0hyRWx1WSs1QzM1OWpsNWV5NjNpNG03UGdaeFlmdFplbU9rZG4xMnZG?=
 =?utf-8?B?dUtaR0hqYnYzSzBEVVVwSHQvS0VYNVNUN3ZZTXY5aWJnMFMwWjBjODljeWJm?=
 =?utf-8?B?T1NaUGFUYmRSY3NZWGV3UmpYTUdhTC9XcU1jRjJrRHQrZnJiUnhnN00zRjNF?=
 =?utf-8?B?RncwdldQSnFONDhZdEtUcU9QTkJFR21mSW5tKzdGOFkvWmVtbFduWGhyT2V3?=
 =?utf-8?B?cWRCaWN6Q281NDA3MitWTGp6T3BhV1NTVlhDNDFDR01UcWlSbnZxdTljaWdh?=
 =?utf-8?B?WndnWDVER3BpMWtFNGtJZUZHMGVoM2ovQzZZL3p6cmtHZFdsb0RyTnBmMXox?=
 =?utf-8?B?dTNDZmxwMEtBMDFOdWZJK096WFREKzdsOWkzVVpHQldPTlZGR1VNYlYwMFl1?=
 =?utf-8?B?NklXR0NUL3hmUnZZRDFnTW04VHJNL2MybFZkcG9pYjhBNUgxWmRzT1JVY3hM?=
 =?utf-8?B?aU1relpBMXA1YitHTFBnVnFxQnpMaUN1Q0lIZkp4RGRCUVIxYTJSSTh5bjFF?=
 =?utf-8?B?bEFHaUhUaWZvdC93djBoRXF3bkV2UUpCeEFIMzk1TWxDTnJDWktqd0Nka0dk?=
 =?utf-8?B?T0ZBRlhYM1pUVmhST0cyckhnWmlaeitCejErcTdJcWVKZk8rNHBMOE5ZWVUy?=
 =?utf-8?B?bnNockNMcGVSRVNDeFVGb0xmRWgrU2x4OXdKQ2dOV2o3V3RKUnlFZzhrM3lu?=
 =?utf-8?B?cEpZb21tRWtLZnJrV3lsYVRvcDZydHpja05MVDlSN05EcEYxak1TVWdzdkFF?=
 =?utf-8?B?L1lWYTArQzJOQzFKQk5ET1RwYXVZVTRwMk5QMk9vOHliQzZ6KzZnMzJRelJI?=
 =?utf-8?B?d3RJcHNTN01WdUIrTWRxdDJFSGxKTkhZNzRXeUdhTzBwR2JtUXBNU2hzTEdF?=
 =?utf-8?B?NTcyMGJuWWJCTDVUN1ZTa2ZQUnJYRmpWRjhnYTVCQVZBUGcreGxuMitCL2tY?=
 =?utf-8?B?enJOcG5LNUJqVDBzOFkraVhWNUhIemhKbUs4WWZoa21WWTJsWTJUWXN3Y0lh?=
 =?utf-8?B?d2Y0QkV5bFluZit4R3pIQWd3a2lhS0tBK0lNdVd0V0tSOVUxcUpqZkxxelp6?=
 =?utf-8?B?U2xnenpXUVUrTTJieFEyTUwvZFY4dVhoNzlVOVhxSGFDbEdiZXRUdEpNZFg4?=
 =?utf-8?B?L29hWGprMjF6L0ZXNXBSYnNhd0dORHdvK0dUZUI2SlVUWXdyZU11SjIweU1r?=
 =?utf-8?B?cVFjZmxrSm94UzgrYk1pVmdkWkIvWWFqSDJwQWRuek5abGV4aS9QdkU1YlFk?=
 =?utf-8?B?QU1TV3NYT2Q2dXc4K3VGV1BFQm1KK0VyQ1FZQmpYbWFpOW1sL0lhRzRVZkpY?=
 =?utf-8?B?VzRZYnE2YUswUVU4QmZCK0ZiMjk5MW5BYjlsY0Q3dE80aVJzTC9NUT09?=
X-Exchange-RoutingPolicyChecked: UdWenJlT6HNHdJ0bHliSs75sPa0tgOLg4YogrUEwBajqWoeA+GSWctAsQGF22XnSW/wThu/AfPVRInwBdyEUsZsgTh4Pekp7tyO6fadb0IGoqjymCIcLh9l2E0nvTEyIwRzC9gyrFbaCC9qw0s6jHeQyMTL+OQoDx9L6tbdDGFPVUXLF5tse9PDwbI46p4IZynxmNjLNwlNTk0MMHOTLKLxgZ6beGHsg7KvvVugGJKS17nZ/r6W2vaBZFCDzXo0S4zqKnZG2PztUCgxe7mwKEY+zQvtBDSfl9GK6tGRz9PlJbHC0BnzqQcBmAkGil14cF6maC6CvuKN8fRIMwh+eUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d67e075f-3a77-4723-d735-08df4a3fc6d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:29:49.1403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLkx7T9JQRepxK05izdvUJpW0+UfsoXOsbCkqnwaZaW1/GFaMeYAUY5BW6l7NiIP+YciRQ4Tr+bHGqsuJRP4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 09:15:27AM +0100, Michał Grzelak wrote:
> On Tue, Nov 24, 2026 at 11:41:35AM GMT, Dave Airlie wrote:
> > On Tue, 24 Nov 2026 at 11:01, Michał Grzelak
> > <michal.grzelak@linux.intel.com> wrote:
> > >
> > > Currently ttm_pool_fini_basic() checks if page count of pool-type's lru
> > > list is zero after tearing down its pre-populated pool.
> > >
> > > After commit 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> > > this check causes NULL dereference because page's lru list is destroyed
> > > during pool's teardown which leads to KUnit's crash:
> > >
> > > [20:08:24] ========== [PASSED] ttm_pool_alloc_basic_dma_addr ==========
> > > [20:08:24] [PASSED] ttm_pool_alloc_order_caching_match
> > > [20:08:24] [PASSED] ttm_pool_alloc_caching_mismatch
> > > [20:08:24] [PASSED] ttm_pool_alloc_order_mismatch
> > > [20:08:24] [PASSED] ttm_pool_free_dma_alloc
> > > [20:08:24] [PASSED] ttm_pool_free_no_dma_alloc
> > > [20:08:25] [ERROR] Test: ttm_pool: missing expected subtest!
> > > [20:08:25]
> > > [20:08:25] Pid: 80, comm: kunit_try_catch Tainted: G        W        N  7.4.0-rc4-g401a3e7b64d1
> > > [20:08:25] RIP: 0033:list_lru_count_node+0xe/0x20
> > > [20:08:25] RSP: 00000000a08dbef8  EFLAGS: 00010246
> > > [20:08:25] RAX: 0000000000000001 RBX: 00000000a0803c70 RCX: 0000000000000020
> > > [20:08:25] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000060853030
> > > [20:08:25] RBP: 0000000060853000 R08: 00000000a08dbe98 R09: 00000000601246ac
> > > [20:08:25] R10: 000000009f227d00 R11: 0000000000000000 R12: 0000000060124640
> > > [20:08:25] R13: 0000000060853030 R14: 000000006047c950 R15: 00000000604c6488
> > > [20:08:25] Kernel panic - not syncing: Segfault with no mm
> > > [20:08:25] [CRASHED]
> > > [20:08:25] [ERROR] Test: ttm_pool: missing subtest result line!
> > > [20:08:25] # module: ttm_pool_test
> > > [20:08:25] ==================== [CRASHED] ttm_pool ====================
> > > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > > [20:08:25] [CRASHED]
> > > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > > [20:08:25] [CRASHED]
> > > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > > [20:08:25] [CRASHED]
> > > [20:08:25] [ERROR] Test: main: missing expected subtest!
> > > [20:08:25] [CRASHED]
> > > [20:08:25] ============================================================
> > > [20:08:25] Testing complete. Ran 28 tests: passed: 23, crashed: 5, errors: 6
> > >
> > > The crash in turn prevents Xe CI from running IGT.
> > >
> > > Drop the post-teardown assertion.
> > >
> > > Fixes: 5ffdc8f83613 ("ttm/pool: Don't leak LRU list on shutdown")
> > > Cc: Ian Forbes <ian.forbes@broadcom.com>
> > > Cc: Christian König <christian.koenig@amd.com>
> > > Signed-off-by: Michał Grzelak <michal.grzelak@linux.intel.com>
> > 
> > Reviewed-by: Dave Airlie <airlied@redhat.com>
> > 
> > Let's land this and unblock CI and if we need to revisit do it after.
> > 
> 
> Thank you Dave for your review. Could you apply this or help to merge
> this? I don't have commit bit for drm-misc.

I just pushed to drm-misc-fixes.

Thanks,
Rodrigo.

> 
> BR,
> Michał
