Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C29FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 03:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDA710F1DF;
	Thu, 30 Apr 2026 03:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S14aauz2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D42810E02D;
 Thu, 30 Apr 2026 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777518029; x=1809054029;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/B5+VCPb+8ftaGozRG/ugUx5ypXryKCZ2urgsh8boAE=;
 b=S14aauz2fYjy2/NAWNIkm213usjArBnruUiMuTXkCllEsECM+PW3DK/P
 X1dfe97S+L0dCZswhLospm/0jCkx54Fnt71xGnvswqeC5PFRy3pdYb8ij
 RUQt9Vifqg3DXZTnxMPoG1DtvP6S67qbqn5uqnTaGMp8S4CYq4fnmJnuf
 YOT6cL3sM3B3qnaJTrdIMloZtrtVI1t7W6j+yjQrB6UveGpZ3agSYiQ8Y
 ej5X0mSV2WtF5QwECpi6S2Jfk0xI2NDzTGNlNc4KDrCUII1qPnIaYvXTf
 NDZUAaYTCX6SScaXuOVNsJbDL5EkolOAN4VlxPTAtTXZnSJF7tkFkmzdE g==;
X-CSE-ConnectionGUID: 4Y3i65DCSs29qoj/Nx1IcA==
X-CSE-MsgGUID: roK/GIM7Q/W3ZKo6R26nEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78448362"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78448362"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 20:00:29 -0700
X-CSE-ConnectionGUID: b2xhMauFSXq2Ut/Vw7duyA==
X-CSE-MsgGUID: hBPnAlB4Qv+c4fZwigGBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="230096958"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 20:00:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 20:00:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 20:00:27 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 20:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dczU7jQD52tKlSmwuCdSpEXk0q0uze30gNINA9gjxVy8upEM8x84uMXv1Rn7PNlNXoS0guyxh988DMLSHfPa/U42zF9Qiyy38jCZ2bRGkRQF7WXRL9xA6eLCQ9dYcGlzNJM9SqZh45qT9UabdHNC+7uPkF5hI6t7pWTDTskUTScPR7IZn4jpkaWWOkErPctJMKVO0nm7Jj6nxBf8e7YX+7T3rIPGFxEVEPuD7VfrDSTGK7XcFRySJN9xJD73j5s5tLqZqvUjM+9UVdkfr7Kiw7uekU7OTz8BB9tZ1tK+GzC+MEeRmoHNJ3k0TM2php1REhI6jgMOj6KVP4I22aaFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0agh5gJJY79ELuvgCykhgms+i2wuc5AetwgQzQBX83A=;
 b=BJYoJrH5yfdxEX7bdfmKhzDgFBr+BETp2xpUnOFd+o3c4dhLo6pqxh7KMXecZCJTemMRp3bAAIei+IJlu9i3vNE+HFAhiiqTFrsa09qweIUQ8gWynp8xjS5LE18HELr+SNzRvUnjY3ugP74IMcNOvbe1R5P6MoqxzjmFBdEliKXex1zbhZJO5NmViDQuGS3yfwxrmAgixopi42waP+8OS9mkvGn3WAqE0ww7y9aVdPbWoREJySPpT0pLujiPXY6nrEPkg8jn972YXiIwILraP7V93kHyXdxEiy+dwUMERX5YCRQeKwXvIG6PDm1SVag0rO/jdfyIqyHbIMxiv3bT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 03:00:17 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 03:00:17 +0000
Date: Wed, 29 Apr 2026 20:00:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
CC: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Carlos Santa
 <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
Message-ID: <afLFvbiouYUgpOTj@gsse-cloud1.jf.intel.com>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
 <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 300eb2de-c0fe-4a9a-b754-08dea6649bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: spcEbB8Rllv4Y9EKle38fH+e4FLoDlXBKdLYEMJspOsto1MSThjncycinyRblcxKBwiYf+dbgIFKFEFM0NNoYV/2HfigfSdLcSqacsEV8JBzkyW7mYgox9HT24tQMAYcjCgAC9JiKvPZeMZ9r1KPn9oklvy/0NAYkXgVMT1KEzlVVsRQmYRAPD6irQM9AfScp8Ko0u6pba88A0LnHNEfE8w2fGZ7KMNcyU486Zds1/hIXUQktChrgc+fK8pUvS7dOVXlbEomgmMXJTfLdecyIGYzvM+sNDlrEaJYt8M6ix4t7hbrBiX6pHznCI2QbLV2blG7c4esYqhCKYT/beIz+KQg5jE35Dy/bnhbAim9Uz817j5ETlrMWpKfAvgrahkpccpHyndG26tUD4Uf3oBMsrLBzQ6KtCgeEoDMJ7tzGLxdjnvGh/qW+Oxm+ebXuAcbK8VGfH/55c3V2cfkcnv44W23VLovFHajH01kYbWhsdKs5iykNTbAahjGrD1WFVSly+C9bjnrcD3nGUEYva3Mm5DhkKGUPPsGpiC+dfVWEIiNibNmC4jDHJpEXrGBW4HWLRZ3/wQMc93DN6CpVWyTndbX1fILqd5DcL7X/Fbwn/C9/wCq5Ct3H3cc56Ui/LOOuHAbRN8e6xILoo33RTqGJdDo9OTYXDh6M5x7gSaOdARXspX7lbyi4dU8ntCulyca+Wz/+kMxaEPx/1TVAtEEXHcYExmLjWjXOWvD98jd+BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M3DLOYn0mFkfdiDtW891cxMrC3OBwjuwxlfBvC+fjc6JnEkhszWgJ/uO+3?=
 =?iso-8859-1?Q?Kpd+0fvRwNz2qNX+Fut2AyovZUVW1AFKK+2SKBw2NIBWjMJnTnskfLhfDL?=
 =?iso-8859-1?Q?Y2xK/c9n+jTGfSJQ18f3gKJoQpz3iASl/5DrYvmIJXgtBTgHJ0z/NBF2wM?=
 =?iso-8859-1?Q?WcTav4UWXEEKleFlnk4+zQ6WOjWo/4bI6rgpl4uyPgUba1Oy60gPOQ/8uX?=
 =?iso-8859-1?Q?X85qDUDTNIct3+9FnwvvCC0SA7xSKniQO98k4m21s5NOl7gdmJ+Wuh4J/V?=
 =?iso-8859-1?Q?Ghqg9Ge3BdAvlgnD/vXG9kirwe0YCVMhVeWBU6966+asyJFLz3EDrvKBHi?=
 =?iso-8859-1?Q?dLCSptucrRR3kwiv7/2J1x1LvWIr1KjiFQt89lcXGJvLJyZBI4uji4uEYD?=
 =?iso-8859-1?Q?2PsfnEaeRLdWonbtmcDGNobNawNJjnEOhRidW60gEuVMeip5V5dcw0tTDf?=
 =?iso-8859-1?Q?CjChDfSz+K7ww0ZcI8rPOQFQVBctmXjSer4Xi/32XwO0yvv9JjhGUDP6Sj?=
 =?iso-8859-1?Q?RD4WvvUYeJLZ+j+inid1fiTcn7KDgR8Ppe51DOFAxvSTY2pLhGg9poyUYl?=
 =?iso-8859-1?Q?6YOYGw16JBQZbsCCcgTmKmdHjLixl6P61Y4CnuY4kcKpFndUAULN5eRF9+?=
 =?iso-8859-1?Q?mbctpUMQg4dK1+ESSom+0S7HJpWlk7wrFpQYIwtilrQB7qGvmgS8SbwraG?=
 =?iso-8859-1?Q?rFSLMMPKuKf0nU/NT8bSEgSVyHcUsenXtLzeaMKcyvibQbNIPEOdGt8W/i?=
 =?iso-8859-1?Q?G7sTmBHrq/rVv/Ggf5uzvx2U4ZF2DiwP65ucK7+i8WlP0hEdI9O6O+50C/?=
 =?iso-8859-1?Q?O/JNIQ/P+nIFk8VPk9Q4W0Ihu4aoxggVNJs1Wfm+LU4GE/D77JKFgKFk9Z?=
 =?iso-8859-1?Q?diJplVZl7jIDj9M5jzfyDCjttI3WGHEHsNN7k0m3QXNnQtX0vaUWQ4CG18?=
 =?iso-8859-1?Q?7an2C6keFWKfCEhivywA2JwhfWIIZmK2MGARAGqZsz4KzjDCzY2qv1wRyT?=
 =?iso-8859-1?Q?HpYpPIlFl3iL3bejdLvtRF+GcjLpRlkbiX6R+JxYEgY865+cuBqi2KOiLl?=
 =?iso-8859-1?Q?Nc4edDaA6N9/uDoKpy6lO0Y1C20QYvbfmfELdozK8E8W/UZDrHdnuKeGDv?=
 =?iso-8859-1?Q?e+yYzFJDRy4xWpvZU7OGKgSkkGPHrMDW5xeqV93ECy97FoezEdj+vFLDyS?=
 =?iso-8859-1?Q?QSs4mk5OP4QgKrYOE/BjVqIO28XZFmsQxJpl9MydOFcfqD48/4YaT+nusw?=
 =?iso-8859-1?Q?gr6tsELz2j4EezIT88CvSkvrxVgRzmJUsGyYwRZG1f/Lehu2Kinf7gpK/n?=
 =?iso-8859-1?Q?IURVqaeDOC0pmub2lZX4KWYaFnd5wv3usxWT59cCZwEOU6tP+BBFMCD4M4?=
 =?iso-8859-1?Q?vG5Y8YADKQu5ilNT3xlAMZh40XfcCEACZMdCSZHhELxbVwfnN6yGdh0tO3?=
 =?iso-8859-1?Q?3rCwqgc1eq6Xm4R2OHLvEl2J8o5Apml2vmV02RsgVi2yDDjcUm5eSowHsE?=
 =?iso-8859-1?Q?ii+7aF14qCtmfJoKCU03uURg/gG1Q2Kjv3CXZ+fFWCBRwgJXGsdH9nEAjK?=
 =?iso-8859-1?Q?BN72QjpDEjYzRwc2YZ9BQpkIhZtdokkZGURe86HFmB7JgqdzYEIEIfpach?=
 =?iso-8859-1?Q?IOiNgSIFL1Z4spC6qPWnh1gpmyTifOmdVjBx6RRUDSK9aVHHk4FQPSzyZl?=
 =?iso-8859-1?Q?u/iIT15T4E4shn3QPVnpl3FBFKQTt5+0AdF39HT+n8/M1xDTyN0CHghuDq?=
 =?iso-8859-1?Q?k+lLOgSWGVKD8GyZevswgoWs5QDJDLr4+90ZIcY94b5EYpSl3/w6pj3Z5t?=
 =?iso-8859-1?Q?Hg4S+ACnIA=3D=3D?=
X-Exchange-RoutingPolicyChecked: px/jd9sgIsfa7+0nF3ZWwfsmMbiXFvsuqZJh1JHm+4MmLItvAbLfIIKjo9hU8ZRWKc3fMZbLw+mbgpylcJL4+wwKTptioR2d0PuzSqQiym02oTHmKmpq4aiO/wuV41HVpt2apFwG/JXqjq3I//2rd3L9whj3zMOxbPFPTwyQOnDgJlysNBx+tsAo3qgSa3lCH5fsxQe03U0v/HqXg6upIoGspBOfIIZK3I2jYC9mejrHG5rhsgoDX0v0bdlKXZZd+ej0pRYTrZdKwXvxDza6pgkdrYy8qQGxq5FIgSAonF8E+8nvw+Bw8YfD5BJa4qnuIN33N8DDr4yFKTUaWSNmdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 300eb2de-c0fe-4a9a-b754-08dea6649bc7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 03:00:17.5370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CsHl4ay2JLn0IwshrqoP+2z0/dB4JKELaq9CLXK4tiUSaD7mljZKqGMsYmgKaeDe93OnrEs8Z+OsoVhYWonnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
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

On Tue, Apr 28, 2026 at 02:45:52PM +0100, Tvrtko Ursulin wrote:
> 
> On 22/04/2026 21:41, Matthew Brost wrote:
> > On Wed, Apr 22, 2026 at 09:41:54AM +0200, Christian König wrote:
> > > On 4/22/26 09:32, Tvrtko Ursulin wrote:
> > > > 
> > > > On 21/04/2026 02:26, Matthew Brost wrote:
> > > > > Triggering kswap at an order higher than beneficial_order makes little
> > > > > sense, as the driver has already indicated the optimal order at which
> > > > > reclaim is effective. Similarly, issuing direct reclaim or triggering
> > > > > kswap at a lower order than beneficial_order is ineffective, since the
> > > > > driver does not benefit from reclaiming lower-order pages.
> > > > > 
> > > > > As a result, direct reclaim should only be issued with __GFP_NORETRY at
> > > > > exactly beneficial_order, or as a fallback, direct reclaim without
> > > > > __GFP_NORETRY at order 0 when failure is not an option.
> > > > > 
> > > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > > Cc: Carlos Santa <carlos.santa@intel.com>
> > > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > Cc: David Airlie <airlied@gmail.com>
> > > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > > CC: dri-devel@lists.freedesktop.org
> > > > > Cc: Daniel Colascione <dancol@dancol.org>
> > > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > > ---
> > > > >    drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
> > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > > index 26a3689e5fd9..8425dbcc6c68 100644
> > > > > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > > > > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > > > > @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> > > > >         * Do not add latency to the allocation path for allocations orders
> > > > >         * device tolds us do not bring them additional performance gains.
> > > > >         */
> > > > > -    if (beneficial_order && order > beneficial_order)
> > > > > -        gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> > > > > +    if (order && beneficial_order && order != beneficial_order)
> > > > > +        gfp_flags &= ~__GFP_RECLAIM;
> > > > >          if (!ttm_pool_uses_dma_alloc(pool)) {
> > > > >            p = alloc_pages_node(pool->nid, gfp_flags, order);
> > > > 
> > > > I missed this conversation so don't know if this was discussed -
> > 
> > I meant to CC you here, but missed including you.
> > 
> > > > having less of 64k pages is not a concern? I mean slightly higher TLB pressure etc on hardware which supports this PTE size.
> > > 
> > > At least for AMD GPUs 64k doesn't matter at all.
> > > 
> > 
> > Same on Intel GPUs for system memory mappings - it is either 4k or 2M
> > GPU pages. VRAM can we 64k pages but that isn't involved here.
> > 
> > > There was a large push from the Windows side to use that size, but we have more than enough evidence to prove that this size is actually completely nonsense for almost all use cases.
> > > 
> > > I have no idea how we ended up with that in the first place.
> > > 
> > > It could be that there is still HW out there which can only handle that size, but in that case such HW should just set beneficial_order to 64k.
> > > 
> > 
> > Or we move to a table config if we find drivers have multiple
> > beneficial_orders.
> 
> Or a bitmask of direct reclaim orders?
> 

Yes, mask makes more sense actually. I thought of this after I replied.

I'm going to respin this tomorrow and if a mask is preferred we can
start with this and build in more control if needed too.

Matt

> I am not saying it is required to be "smarter" than this patch does it, for
> AMD and Intel apparently isn't, but for other drivers I don't know so it
> does need looking into.
> 
> Regards,
> 
> Tvrtko
> 
> > 
> > > > Also, does clearing __GFP_RECLAIM disable compaction completely and is that wanted?
> > > 
> > > Oh good point, most likely not.
> > > 
> > 
> > Without completely reverse engineering the core MM, I'm not sure here.
> > 
> > I just read the kernel doc for __GFP_KSWAPD_RECLAIM [1] and this to
> > indicate if this is clear compaction won't be entered.
> > 
> > Matt
> > 
> > [1] https://elixir.bootlin.com/linux/v7.0/source/include/linux/gfp_types.h#L198
> > > Regards,
> > > Christian.
> > > 
> > > > 
> > > > Regards,
> > > > 
> > > > Tvrtko
> > > > 
> > > 
> 
