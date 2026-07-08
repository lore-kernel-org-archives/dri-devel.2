Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB379C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D84810F31B;
	Wed,  8 Jul 2026 22:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fVHpnD+y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C556910F31B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783550403; x=1815086403;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=IlcvVHIIwa3lawruHSuSGJwsSg1MiLDct8w0U9Yf/pk=;
 b=fVHpnD+yLsEET2UgfWVyj3Gia4UGkZSshL5+moZtz1niKeVxoU6gtyut
 un9I9iVhEpHPdzH+tps0LToIOgKMazzAIpRneEYWYjiwVd0CbKk3ajleU
 XDuVNEACPtxI19TSz9gT1SOY55+HJ41GmpomrCn3bo0b218DKxx9T5Wwc
 z+c1DbKXeCv/DL/muFMrMxSNQ073BE47NEazjwXXgHcIpYPznl/nVZMdC
 ix6r2NiC/7Lb03Xe2zUyoZ0iL/ylWPDr5XKn6euj+jjFS4j/zmg9f8vD8
 jTUwAS6b1dPbwK94okoJHEk1nl9Qwq5/jzAzJ2Nbg3mghLA7VQpO0IMSa g==;
X-CSE-ConnectionGUID: IiVKUEl4RCC2xCELi6uGiw==
X-CSE-MsgGUID: IijvWrLTSIC0G5BK7i2Xyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101653012"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="101653012"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:40:02 -0700
X-CSE-ConnectionGUID: n1AtforfRR6+l4kNjTl9OQ==
X-CSE-MsgGUID: Khl+wY5JQKONkTRAuoMsJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="259310826"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 15:40:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:40:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 15:40:01 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.22)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 15:40:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rT/JPncdnkv0KQyenpNXvzsIHp78/rjIV4EyTXH9tp2Qfar7bSbNFuiPAafY8AxaS3Y0YQI89KGR/RFfCNBPH2PLIArpGKaKe+hKoN39BedSrGxpHcRH5nNrYEouLw8SOCwBJ90nzifa4OgC2kCUNHT3hXdUeECMhHfMTm/gqEKURmgTs1xUgDWc4uC8ssEVgfyshG+VqGlEAmqk9d1X3QcNOEzFyVdHuxsxMYBOVULPTRsO9HOCFjn3j8BqDimC/53V/FarKd/1XYOiLnJQfQftYvBZWxpvVdp9JPuBMsAKMd2+BWqf70BIjk5Twp616Hgu4TGLPMnBQYoTdOJ+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JzSI07jUzHrDkFOhsT4zPaQbyLjGLC4aUilFmpuyHE=;
 b=cC7Bw3jabCcybz5ON8PE37Gk1pACwQkkUnf6aSfRQulUABcXy3kTrGv92TyI4qN7Qxvu68cDPHLRIrcVwPs0oIHq9gJieJ1CzKPLZmLBkZhhfgHaJmNgdNA6LqniotPakABfNRYIj4u0CwcxNrgvALVnYHJcL6ThApIdMKm1mgO5+p/eqIeohk3MV8t2Q4hnfZ13biTUvBe/W4aVpUi3SRej5MfUSXxJcm9g37PeCkRorGQIKvBazb/ojPokIW39vQNwDafwIjZ+gDISUNl3CGn73wnKMFlo+ar/41aJasKL03RGt8WGTl63QqSJTkKA3mkXsuaWvOZCIFyt7S+pXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SAWPR11MB9545.namprd11.prod.outlook.com (2603:10b6:806:4e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 22:39:58 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 22:39:57 +0000
Date: Wed, 8 Jul 2026 15:39:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <ak7Ru+STL9knR1xS@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
 <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
 <akym7rllMDFFcz8q@gsse-cloud1.jf.intel.com>
 <992e86a0-990c-46ab-8816-cf3c030d274a@igalia.com>
 <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak63Qzqxn1k9ezEd@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::35) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SAWPR11MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2a9053-4c63-4c0a-04c9-08dedd41d6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|11063799006|5023799004|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3eZwF21MZvpEe+PkgNarCD0rPQbEsmnz2kzVAKEVr2hy16VVSHruBiHDgy8uw5+geFJ+U3Q7gggi0kScUlJQ0sElMKZ6Ch6KR60T02uytfFHFj+0eaQP0WYlrPvJzYUZXTxLS2pmUujgMhbV9abiCPm4eGA0rpEHzrw++c7SsPAFaLZ1mV0iGQpNg+gTPT9GFN87XZP/VkkbwdQrSCShc0ux50c4e2/2yHEG8PF72qihe/s3bhej0SqetdkWsWYr2Hr7mBoMG1wx8eLpaa6DnC4T9A827dMVRuEzJbV1/QQgW28hBogYj22mJiK80nNB4YNoJWsL5HB0nmuAGs/SSlmRfiEl68j3K9S2KeoovM9RAS4oY/D+bGjwHWMtCtsJ2084ayjWybaKb32QhmOTN9DHtTSnjKIFbgrU/IfOM81+N0gnr7pL7/Wb5sbfkUzAlxUGeXVKSePUj/h5PI9fmDkPnjI+aXXQxIVZRIMOZ1SyCiboG+42RJlNnrvBu+HdJNn1s/ohkCLBYCNwEyMb8zpJ6haPWMUiRd5F3eF9vsd3Xifk9RScpO6p4UdMjs4jMZHM7ao48tk/0ckJP6ngbvtZhI8E7h0GfGx3mHT/gy+lxSPSWGnFOazhxvGHPTiS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(11063799006)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REI0Y2ZoWE1xVS80c1NJM3ZJZTNtcEFqczh6RkNCOFhCdFpyNC9JUG5Gb2xk?=
 =?utf-8?B?bUxVdmg4cUZSWG1sWGFieDFQWjZ3cWNFWTNaZlZOYjhUa3JVZmppd1Q1aDlQ?=
 =?utf-8?B?cEZBVjVYaUFhN2xxL2pQQ1pvVW9kMHBDeVRQbWhZbS8rdW5hWGY0eG5XNnVV?=
 =?utf-8?B?SUEwQTFGWTRMNUU4Zi91Zm9mUmdiVjJPVFV3ZnBjQUhrQVJmMmpmVFFaZzhS?=
 =?utf-8?B?YU5YcUhEand5c0lvMTNKTDZkaWRjRnl5WEJaSmZsaDRWSnRyZ0FZTVV0d1Nh?=
 =?utf-8?B?ZGhYQnBocmJJZkg4WnZ5Tm9XV3F5YXNyM2M2MURpeWRCZ1pJVzJHMWw1NVVH?=
 =?utf-8?B?eXdLZWtDcGpqc1FnSGVJc3F4SjAvaFBKbHRBc3Iwd0JsV2ZlRThxbXRjN1h2?=
 =?utf-8?B?RnhLUkNRV1F0dkowbkcvQWc5NmpSck5TS2d2aXc0cktmK0FKYXZFQ2VyVGFh?=
 =?utf-8?B?UlFvbDZTelNLTWF2ZHNISUlqNlRnN3BmaGk4TGFVbit0elE5bmwydUF6MEx5?=
 =?utf-8?B?VitsU25Ia05NSDkwY0Juek1RbGNqZko5Y2x5QWNHWjluLytMSXlxck1DR2tO?=
 =?utf-8?B?akpTUzdJanJMeWJxTzhPYzJIUCtzbitFMnI3SHN5VVQvQk9qYi82ak5LQW51?=
 =?utf-8?B?am1aaE1kUlRRbEsxdDYwUTJWUjM0NzVicVdnd0tRQjRCaTlVSmoxZjVnODNE?=
 =?utf-8?B?MEhyNkRrZW95RG4vWTdYSmRwci9HVXRiazBGS0JyOHQxVUkrRk9meTc3N1VR?=
 =?utf-8?B?djRvbjRCS0llK1hSRFlLRVgrV0JFOXJ6MC8vRldRdFRnUWlCc1d2VWNSS1Jo?=
 =?utf-8?B?bWoyTlJ6R25CSENDejZWZnJBZmVVUkxIMk14d0hSZDliNnFzSzA4eFpERUg2?=
 =?utf-8?B?c3l1R09WcXlnQkhRT2ttbWtjOUk5K0N4bGhyVVVTUlhzMjRXSjFQdXlPVXZM?=
 =?utf-8?B?SnlNSmUxR3c3SllBVitrSVdIcEVlZisreXk1bXdGa0JPbkpGbGFVSlB2YThy?=
 =?utf-8?B?L1F0SSt1VlllQjIyTnhKTFNHeTJDNThuZEpxUm40elhKTGpSQ1I3RlJXQURP?=
 =?utf-8?B?ek1tRjlaMEp3dCsvd3laRkx3d0sxbzRSVFRXN2I3b0NyRkppOEM3dkhQQXk3?=
 =?utf-8?B?eHNJM1NqaERrZDFhRkVYVWE1Und6ckRzWnY3MXk1Zlc0cVVIQnBUaFhST3Yz?=
 =?utf-8?B?Nmk2M1JOYWhuR0pBQk9TYkJ0cTJWOGRYWHY3R3EwcGg1M3JkOXQvSERVakRy?=
 =?utf-8?B?UDYyOVhBVHpRbVc4WUd5dEJ4Q2hIYWd6ODBnVFk0RE5rMldZamJYL2hsejBv?=
 =?utf-8?B?MjVVTEJlbVcrbnBwQmErcG0vc2xWdHF5dlU2VkhQYlFNY0J2Z3lQMDF5QllM?=
 =?utf-8?B?ZlA3eE4wMnpnUkdRWCsyNGNEbnpSbTlpb2FpL3lLWUNlYXJQNjMyczF3ZVZE?=
 =?utf-8?B?RW9mQTZWMVNrL01xNy9nbkZNVmVWdWwrc1ltdVlEditaLzVXS2hROWc4RnB3?=
 =?utf-8?B?TjZmTmQwajd1d3lmRWlPN3ZWUmdMWDJMeENiRlNZUzE0ZGdxeUx5THgzcGkx?=
 =?utf-8?B?WkRwU0FTT0JXbnhTN3NMbkhTc20vNzJmSWZmaHlGSGs5dXF0K0w5VnFCL0d3?=
 =?utf-8?B?SjRFYU5TSE45dlRhcDFsSWRKSFNoMmdKdGN1Y0d3NGROSFJOZVByaGJOVUJJ?=
 =?utf-8?B?WkpZNmJkWTBXUHdCeVBpaUFERmx0VkgxZGVzNVBFdDA5eGtnbFY1akNhRVpO?=
 =?utf-8?B?MHRrVDRHbVVHUkx0R1BrSGdrUEhrdmlKTHNqOUFwVFZSMlIydGhCYVU4M3FJ?=
 =?utf-8?B?Y1d5bDN5VHlQb2RLUzhNUXVzYzZjTG1HbjJ1dDJXa0tYaEhtaENSRHZEbFl1?=
 =?utf-8?B?T3JWV3dseENSOVBwTStOY3U4Ly9PTGFwVUdJQzA3OFhWWDR6RCtMUVg3d0NN?=
 =?utf-8?B?bkN3WitRNUlGOEc1MngwLzRwVlM4R1hhdEcxUnFPMllBaWZFMStxSXdmbUhn?=
 =?utf-8?B?T1l6WWNUTEc4YlRyNkZFeStCSGpKK2E0VUFKdU44Z0FxYXl4NVFRRWdOaFkr?=
 =?utf-8?B?NFZualJBdGxUVFFZTHBhekxSQThseWFEa2YwZFlTWVZ5dTBtM1Z2eCtBc1J6?=
 =?utf-8?B?R1czcnBKRmV4c3l3eDcyNlBxUzZyZkFFVUp0V2ZGbStjZllteldGRWIxaHZ3?=
 =?utf-8?B?YXozT2k3ZzhJc25ZUmErdlZRL0dhcmtFRlBrQ3ZPM2h0RzAvUXUyQXp3M21R?=
 =?utf-8?B?R0ZXOWZhclI0d0V3bkRWS0xzRG4zTk1PV0swMTBOa2ZsTW0wRitQczF0VENt?=
 =?utf-8?B?Q3ltTnoyTnB5YTA1Q2ttZDBMdFdzczFGMWs4c0RRcXQxTks3R0l3dz09?=
X-Exchange-RoutingPolicyChecked: YEv0F/mDkC/G1v8oN0IdaqcE9edONl4hI66ND1pYmzXhR1DZKegYIUzoz3qRnwPalMa841PoVM+IeoyAk0F9lm1jCrK+2LLvqUuHiOE9EoF1tfuCtgUyh4xZOnGz3T/0z0uuITXEdJLa24AVcHUltoWd7Z9BS4L57sP30p0npojk8c8ZoEFuAssYht3DrDxT4qDCDsgpqVtpYqmzlb7KT7QueUdfUi8P9CGlLizwgWI54m/x9Yj0aRdbuhOua6EWhlfUwuhGiRaDmNV9n9R3aXU3cBPrtyhny/qei3IwNaVM5Tcz5QIQIwvewOGpcS8Yui3O70GXObXqyFvPNx7xkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2a9053-4c63-4c0a-04c9-08dedd41d6a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 22:39:57.8775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwHWVIjWjxxL1kylDo4QzwmmCGZ0I52nfPqIfIuCkv1aBfoodPy5iBY/HglsGDbIkcuqBDe99b4hCIccyXnDDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9545
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

On Wed, Jul 08, 2026 at 01:46:59PM -0700, Matthew Brost wrote:
> On Wed, Jul 08, 2026 at 06:01:55PM +0100, Tvrtko Ursulin wrote:
> > 
> > On 07/07/2026 08:12, Matthew Brost wrote:
> > > On Mon, Jul 06, 2026 at 03:54:45PM -0700, Matthew Brost wrote:
> > > > On Mon, Jul 06, 2026 at 01:41:01PM +0100, Tvrtko Ursulin wrote:
> > > > > 
> > > > > On 03/07/2026 10:22, Matthew Brost wrote:
> > > > > > On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:
> > > > > > > The problem statement is explained quite well and succinctly at:
> > > > > > > https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
> > > > > > > 
> > > > > > > Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
> > > > > > > high-priority DRM client gets latency injected into the GPU submission path due
> > > > > > > to the DRM scheduler use of workqueues.
> > > > > > > 
> > > > > > > This patch series proposes to replace the workqueues with kthread_work and
> > > > > > > priority inheritance to solve this problem.
> > > > > > > 
> > > > > > > In the above linked issue Chia-I benchmarked the submit latencies which
> > > > > > > show a striking improvement:
> > > > > > > 
> > > > > > > 		median	95%	99%
> > > > > > >     before	41us	1.5ms	2.6ms
> > > > > > >      after	15us	19us	24us
> > > > > > 
> > > > > > Can you give more information on these numbers? e.g., What you ran / how
> > > > > > you measured these. It is hard to argue with numbers.
> > > > > 
> > > > > I believe Chia-I observed latency on some production hw/sw and then wrote a
> > > > > synthetic benchmark to test it more easily. Details are in the above linked
> > > > > issue.
> > > > > 
> > > > 
> > > > Thanks, I see this now. Part of the problem, as far as I can tell, is
> > > > that fences are signaled from work items rather than directly from IRQ
> > > > context.
> > > > 
> > > > For example:
> > > > 
> > > > "There is another 2.5 ms of scheduling latency from
> > > > panthor_sched_report_fw_events() (running on irq/105-panthor, PID 257)
> > > > to process_fw_events_work() (running on kworker/u32:1, PID 62)."
> > > > 
> > > > I assume this is only addressing the scheduling portion of the latency,
> > > > but you also mentioned a 9.5 ms delay for vkQueueWaitIdle(), where part
> > > > of the latency appears to be on the signaling side due to the worker
> > > > thread.
> > > > 
> > > > > > > This is obviously really good for preventing compositors from missing frames and
> > > > > > 
> > > > > > Modern compositors do not pass render-job fences to draw jobs as input
> > > > > > dependencies. On Wayland, this functionality is provided by
> > > > > > linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
> > > > > > later. SurfaceFlinger has also operated this way for quite some time.
> > > > > > 
> > > > > > The obvious solution for compositors is to submit work directly through
> > > > > > the ioctl (i.e., bypass path in sched) when there are no input
> > > > > > dependencies, which should be the common case. The main exception is
> > > > > > when one of the BOs mapped into the compositor is migrating or otherwise
> > > > > > busy (i.e., a BO has a fence in a kernel dma-resv slot).
> > > > > 
> > > > > You mean the direct submit RFC you floated some time ago? What was the
> > > > > verdict on that one, wasn't it rejected?
> > > > > 
> > > > 
> > > > I had some patches for DRM sched that I never posted. It turned out to
> > > > be a little tricky because of some other quirks in DRM sched, but it was
> > > > still roughly 100 LoC plus an additional lock.
> > > > 
> > > 
> > > Side note: I quickly rebased DRM DEP here [1] and prototyped some RT
> > > solutions.
> > > 
> > > I added a DRM_DEP_QUEUE_FLAGS_RT flag to internally choose between a
> > > workqueue and kthread_work, and to enable FIFO scheduling in [2]. Most
> > > of the details are hidden internally, but I had to make a few small
> > > changes in Xe to support this on the driver side [3].
> > > 
> > > Putting aside whether or when DRM DEP will land, if DRM sched really
> > > wants FIFO scheduling instead of bypass (the IMO this is somewhat
> > > questionable), I think the approach I took in DRM DEP makes a lot more
> > > sense. I haven't looked into what changes would be required in DRM
> > > sched, though; hopefully it wouldn't be too messy.
> > > 
> > > Of course, kthreads are now directly exposed to userspace, but this
> > > would be limited to privileged userspace with FIFO scheduling
> > > capabilities, which seems reasonable. Additionally, this approach does
> > > not require the kind of large paradigm shifts proposed by this series.
> > 
> > This sounds plausible and TBH I also considered worker duality. If you look
> > at my series I wrap everything to drm_sched_work and drm_sched_worker so
> > drivers do not even have to know what is the underlying implementation.
> > 
> 
> You could probably abstract this to some extent, but any driver-side
> functions that process work on scheduler workers would still require
> dedicated function signatures. Perhaps some creative macros could do
> something like:
> 
> DRM_SCHED_DECL_DRIVER_WORK_FUNC(driver_sched, work_func);
> DRM_SCHED_INIT_DRIVER_WORK_FUNC(driver_sched, work_func);
> 
> However, this would only eliminate functions that perform a
> `container_of()` conversion or use an `if` statement to select between
> workqueues and `kthread_work`.
> 
> > It is definitely true this solution would simplify the implementation, as
> 
> Yea, I think when I pushed back supporting kthreads + work queues, I
> wasn't aware of kthread_work which sematicly matches work queues. Given
> the same semantics supporting both seems trivial.
> 
> > you say, problem of thread explosion is limited to RT tasks so basically a
> > non-issue. And the need to create own worker pool implementation also goes
> > away.
> > 
> > Why I was unsure about deciding at drm_sched_init time is a) runtime
> > priority changes, but perhaps that is not such a big deal and we could live
> 
> Xe only allow static priorities on queues, unsure about other drivers.
> 

Sorry for the double reply. Even dynamic priorities are likely workable.
If you stop a scheduler, you should be able to reinitialize it in a
different mode (e.g., switch between a workqueue and `kthread_work`)
and then restart it.

I think DRM sched would need slightly stronger stop semantics, though—
for example, a lock around the "stopped" state and work queuing—but it
seems possible if absolutely necessary.

Matt

> Matt
> 
> > with a static setup, and b) the priority inversion problems relating to
> > other workqueues used by various drivers (like the panthor issue Boris
> > raised).
> > 
> > Or we can cap the number of workqueues to some reasonable number and then
> > Tejun maybe can give us RT workers. There are many options on the table so
> > lets see how to discussion develops.
> > 
> > Regards,
> > 
> > Tvrtko
> > 
> > > [1] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/drm-dep-rebase-7-6
> > > [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/fdc38e4acefc9327637fd818b5b91fd6b2a6198f?file_path=include%2Fdrm%2Fdrm_dep.h#line_99bf000ae_A178
> > > [3] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/f1483af15747a2d5d73262d2cdfc9b616230c5d9
> > > 
> > > > DRM dep has this built in without any of that complexity. I'm hoping to
> > > > get around to rebasing it soon, but of course there's always something
> > > > else to work on. Sooner or later, it will get rebased, and Xe will move
> > > > over to it given the latency and power-saving benefits I observed. Given
> > > > power savings, I'd think drivers for ARM based phones would be pretty
> > > > keen on moving over too.
> > > > 
> > > >  From an architecture point of view, bypass is the ultimate win because
> > > > the context switch is completely avoided. Again, this is primarily for
> > > > compositor use cases, since they do not wait on fences.
> > > > 
> > > > Also, in general, if Panthor selects PANTHOR_GROUP_PRIORITY_REALTIME, it
> > > > would be very odd to pass in fences. The RT priority then depends on
> > > > other work completing before the RT job can be scheduled, which
> > > > seemingly defeats the purpose of having RT priority in the first place.
> > > > 
> > > > > > > similar. Another good quote for the above issue, explaining the consequence of
> > > > > > > CPU starvation of the submit path, is this:
> > > > > > > 
> > > > > > > """
> > > > > > > As a result, vkQueueWaitIdle blocks for 9.5ms for a gpu job that takes 4.5ms
> > > > > > > gpu time.
> > > > > > > """
> > > > > > 
> > > > > > More details here?
> > > > > 
> > > > > This just illustrates how long can the workqueue wait for it's slice on the
> > > > > CPU if the cores are loaded with other tasks. In other words, how long since
> > > > > job is runnable to it actually being passed to the GPU.
> > > > > 
> > > > 
> > > > Yes. I do wonder if this is an Android quirk, though. While working on
> > > > some MM-related Android issues, I noticed it has quite a few quirks.
> > > > 
> > > > I've done a lot of profiling around workqueues in Xe (submission, page
> > > > faults, resuming after preempt fences, etc.), and I've seen latency
> > > > spikes of perhaps 10–20 µs, but never anything on the millisecond scale
> > > > on Linux.
> > > > 
> > > > I also recently fixed a workqueue bug [1] that showed up fairly often on
> > > > Android. In that case, workqueues could stop scheduling under the right
> > > > conditions. If I recall correctly, a flush_work() could get the work
> > > > item unstuck. It might be worth looking into whether that helps here.
> > > > 
> > > > [1] https://patchwork.freedesktop.org/series/164199/
> > > > 
> > > > > > > DRM scheduler was originally using kthreads but was converted workqueues due
> > > > > > > desire by xe to create thousands of schedulers. This series also questions
> > > > > > > whether that was needed, given how the submission is serialized by a device
> > > > > > > global lock (per GT, so almost device global). Panthor has a similar situation;
> > > > > > > hence the series contains two patches to move those two to a setup which matches
> > > > > > > the design of those drivers.
> > > > > > > 
> > > > > > > Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
> > > > > > > scheduler as a hardware scheduler, where number of instances follow the number
> > > > > > > of hardware blocks instead the number of userspace contexts, are completely
> > > > > > > fine.
> > > > > > > 
> > > > > > > There are use cases however which do currently track the number of userspace
> > > > > > > contexts and which do allow for more parallelism. For those a straight
> > > > > > > kthread_work conversion would be a problem due an explosion in number of
> > > > > > > threads.
> > > > > > > 
> > > > > > > The most direct example is panthor VM bind queue which creates a scheduler per
> > > > > > > userspace context and relies on work queue concurrency management to keep the
> > > > > > > number of threads in check.
> > > > > > > 
> > > > > > > This creates a challenge for the kthread_work conversion. To solve which I for
> > > > > > > now opted to create a trivial round-robin thread pool. For the RFC this is
> > > > > > > limited to four CPU threads and is something which will need to be discussed.
> > > > > > 
> > > > > > 4 CPU threads per device, per drm sched module?
> > > > > 
> > > > > 4 CPU threads per drm_sched_create_concurrent_worker(). So depends on the
> > > > 
> > > > Ugh, that is a pretty ugly API.
> > > > 
> > > > Matt
> > > > 
> > > > > driver how it wants to use it. For xe there are no usages of that, albeit
> > > > > you say single thread is not workable, we can discuss that in the other
> > > > > sub-thread. For panthor this RFC uses that flavour of the worker for the VM
> > > > > bind queues and in that case it is 4 CPU threads per device which handle VM
> > > > > bind requests from all userspace clients.
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Tvrtko
> > > > > 
> > > > > > 
> > > > > > I have more questions but let's get some clarification first.
> > > > > > 
> > > > > > Matt
> > > > > > 
> > > > > > > Ie. how much parallelsim those really need. The true answer is somewhere between
> > > > > > > "at most the number of active userspace contexts and the number of CPU cores".
> > > > > > > Or it could be less than that, since after all, VM BIND parallelism is
> > > > > > > eventually going to choke on a narrower gate of actual GPU execution. We could
> > > > > > > also allow drivers to pick their number.
> > > > > > > 
> > > > > > > In terms of how I implemented priority inheritance, the most important
> > > > > > > characteristic is that it is temporary. As many userspace clients may be
> > > > > > > submitting to a single DRM scheduler instance, a generic solution is to only
> > > > > > > elevate the submission worker priority while there are active high priority
> > > > > > > submitters. The mechanism is light weight and has a hysteresis built in to avoid
> > > > > > > frequent scheduler operations.
> > > > > > > 
> > > > > > > That's pretty much it for now apart for an important detail that this RFC will
> > > > > > > not build for all drivers! Out of those which directly use the DRM scheduler
> > > > > > > APIs changed, I converted only panthor and xe. Amdgpu will also work by the way.
> > > > > > > Others I have not tried to build.
> > > > > > > 
> > > > > > > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > > > Cc: Steven Price <steven.price@arm.com>
> > > > > > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > > > > > Cc: Chia-I Wu <olvaffe@gmail.com>
> > > > > > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > > > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > > > > Cc: Philipp Stanner <phasta@kernel.org>
> > > > > > > 
> > > > > > > Tvrtko Ursulin (8):
> > > > > > >     drm/panthor: Remove redundant drm_sched_job_cleanup() from the
> > > > > > >       .free_job callback
> > > > > > >     drm/panthor: Use separate workqueue for DRM scheduler
> > > > > > >     drm/sched: Use generic naming for workqueue helpers
> > > > > > >     drm/xe: Convert to per gt scheduler workers
> > > > > > >     drm: Wrap DRM scheduler worker in own abstraction
> > > > > > >     drm/sched: Convert the scheduler job submission to kthread_worker
> > > > > > >     drm/sched: Add ability to change drm_sched_worker priority
> > > > > > >     drm/sched: Notify worker of the entity submission priority
> > > > > > > 
> > > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |   4 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |   2 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   8 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |   8 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |   2 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> > > > > > >    drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> > > > > > >    drivers/gpu/drm/msm/adreno/adreno_device.c  |   4 +-
> > > > > > >    drivers/gpu/drm/panthor/panthor_mmu.c       |  20 +-
> > > > > > >    drivers/gpu/drm/panthor/panthor_sched.c     |  23 ++-
> > > > > > >    drivers/gpu/drm/scheduler/sched_entity.c    |   3 +
> > > > > > >    drivers/gpu/drm/scheduler/sched_main.c      | 168 +++++++++++-----
> > > > > > >    drivers/gpu/drm/scheduler/sched_rq.c        | 202 ++++++++++++++++++++
> > > > > > >    drivers/gpu/drm/xe/xe_dep_scheduler.c       |   6 +-
> > > > > > >    drivers/gpu/drm/xe/xe_dep_scheduler.h       |   6 +-
> > > > > > >    drivers/gpu/drm/xe/xe_exec_queue.c          |   6 +-
> > > > > > >    drivers/gpu/drm/xe/xe_gpu_scheduler.c       |  21 +-
> > > > > > >    drivers/gpu/drm/xe/xe_gpu_scheduler.h       |   2 +-
> > > > > > >    drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |   2 +-
> > > > > > >    drivers/gpu/drm/xe/xe_gt.c                  |   7 +
> > > > > > >    drivers/gpu/drm/xe/xe_gt_types.h            |   3 +
> > > > > > >    drivers/gpu/drm/xe/xe_guc_submit.c          |  18 +-
> > > > > > >    drivers/gpu/drm/xe/xe_tlb_inval.c           |  14 +-
> > > > > > >    drivers/gpu/drm/xe/xe_tlb_inval_types.h     |   5 +-
> > > > > > >    include/drm/gpu_scheduler.h                 | 131 ++++++++++++-
> > > > > > >    27 files changed, 551 insertions(+), 134 deletions(-)
> > > > > > > 
> > > > > > > -- 
> > > > > > > 2.54.0
> > > > > 
> > 
