Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0635BC624D0
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3915110EAEC;
	Mon, 31 Aug 2026 20:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HAatmDMz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B94710EAEA;
 Mon, 31 Aug 2026 20:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788207705; x=1819743705;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=IhGgFggJ5xa6xWVNgKcvuQqg8UFkNYBtc9tPiQo5Gs8=;
 b=HAatmDMzlr4zzSzNGPLo9GRjU1Rf2ENzoKhZBZqPARcKwopQmXEoZmhA
 Ld14y20WnOPfADsHwxPSwNH8q197mdR9ATWKDuYXZb/7RiY6paFwXv/I3
 qwjihxzz6jGez6d78paPAL6Ty/J8c8BZt1aHSAb+K2CHFvAf6QcK/5mfv
 UZN8PicPCTEgiwBeCPL9WHFSqDwaamIjpHRZYOsmmYKB91DWgcUNXog0V
 OWqkCbrRSloB0dvF4hawRbL7y4ElH1Vm/tH9hzhQC47z7kElj5GcJno4h
 sFhRNzl/j8rMUcx8CiIzoW9CeEJwPQtVTwYXX2iWknT3OciGMwiNwQVEt w==;
X-CSE-ConnectionGUID: NtmHu4prQgO0PEDpEf9qLw==
X-CSE-MsgGUID: VzCJnCN1RlOQLBH+evjydw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99785189"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="99785189"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:21:45 -0700
X-CSE-ConnectionGUID: b7MsH8B0TjOyRt7DIAtWaQ==
X-CSE-MsgGUID: n9KhE4TpSC6dabl+hpIz6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="274160581"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:21:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:21:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 13:21:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/9Kud8AkewfIcAq5IguYgb9OEM2oD1gExs2vAyeMUaKt9ELv8a8ENZjSlQid6ZBOTxoaPk0+qVfAmpyAnHgjMoiKyiis9aCyrXKXaR6ZgpGB6AZKfZspkvXlw0azCV8lwM74KkPU19Wv7bPfBmySaKmp8DpUb9t+Dd+G/RmKXUtDWHglGkKgSAMIOKT+I+pchZ0JXW3W6+sPqjMRoYZRR4lPbOFRwVU0rjqaBSWXe0HVyj4Ayo/vN5otadzP2ENNSrAvey6gNJz5GyJWOM+YKsKBOf+DexCKDvC56FCKgCCRIvLI3nOphKrMBPXzfSuQo4jS0LAcDeXT/ZcYfPZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvRVzd6KL2Q5go99rwgfSWz7BGOesDHk2GP6OUisxig=;
 b=fapppMfD5W9Tda5CcMigHVtDypmuSUwkQW1CB0mhNQUdOrZ8AYWFXpbn21AsjU9kce+5S7HIr6xFt0hxX6re9A8r74HUNx+rlssEt1HYt8RUhnVoqy/7wg8vqWAOpuwgeyQhUvYIJMIQbzC4Y8Z9Fp0zN47aX3DyjFZsIZlsfv/o1ct1HWe7p5xhmVyuJgCtqncbmdAXYMl9ZSmie62OdGDPUYFOvD3dktM0JfCtbDG9VabTvWWz4QpgOmCfAgb1IwRa5+iweOmxjhgLt/+a5q3xEDcaEjwTgCnvYBLfulPRwlrXjPqVztWBtaIKYuozl48DMcgycnh53NbWfy3kuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS7PR11MB7932.namprd11.prod.outlook.com (2603:10b6:8:e5::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 20:21:41 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 20:21:40 +0000
Date: Mon, 31 Aug 2026 13:21:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
CC: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v6 1/4] drm: Add drm_work_fence helper
Message-ID: <apXiUtrKHlSaw6Yc@gsse-cloud1.jf.intel.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831134539.112690-2-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS7PR11MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: b01f4dc3-9645-4dab-1930-08df079d7796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|4143699003|56012099006|11063799006|22082099003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: NkX+grXek2nRWlZkT9x3Nr2UpgLyksAMJOF1mHlG980eQxDnX3Xo/l2bnooumpeBHaTgp6nkrEyEZw76q4oMa3PUILamaV/2ndsoPCtJR14YDpKLxf97/vt45qhEVAFViTSsDbWR/u/o1kgPN1UBE79LgoG9fJxMB3Pk1kDAO7wGADQ2h/lvQ9eG6nM8+KfNJbmgPpgGFbaP05gNCJ51VMBrMS27Oe2O/JFN5KqeINuZNJ8prmKUh/pRndQPRMrJDDH7/GN/2S50gu6rXuTt0R3BP87wa9lAEtKQRP5vm4Ef1whY2U/UE1ZK4fq8VLAJfo/cMyfAfab1znNOd464rlXwYQwziBQWyA8dX5L1k0fJ6MIDELagO4oK98d5+mFJv7JCNHdzUjPh8C7nQyl1OeC+BEbs8hq4NxC65cXCUdJ+EYqFxaaK+R7/2UdpcxCncB5pqai+dsdvHo8prC5TmIH9dGUPDvrIDlPku9Gq1bAEDX6u9PUgPmBUo8+UxQV5Ixu63X3RlTuZBGSKSngqL96oyAkS8TqW8GQu6A+Q1ERv6slSHEZ+WPAmDK5leYoUxrtBFXntq70p8AC42Hw0HnOmkUYwlWXMkPasEW5fLJJKEglUkWDB6OeQ8dx9+Zw+2e2PKj4UaK0IRQraqkz5fL5/q4nECE8vsgEZOYGqkQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(4143699003)(56012099006)(11063799006)(22082099003)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXduNWZuY1pxdytXNzZsQ1Z4TGZzM3BCMjJLMDM2b1NuZkNZMFlSOVF6VExz?=
 =?utf-8?B?b050UDZuL3Boc1ZvNFhCRkxKbnFHVVBTUlVFUExpMjdJbEdlWGxtZVVwVmRM?=
 =?utf-8?B?Tk9reHMxVmdwWGtIZmNmbE03TUZ4ZzIxK3ROODdKbmF1TEVsVmpueGo3ZHkw?=
 =?utf-8?B?ekxNdFRLdU80dGdaeWw4eVY0Z1ZrR0E0ejNSOVdnaHFEMFNNVlpmNEs1SVo5?=
 =?utf-8?B?ZWtkaWVLdGQzTXJGTGdrZ3ZOZk5GTG15QUx4UG56T0J6QW10T0ZadGVGTmVK?=
 =?utf-8?B?QVJsOEVKVjJiZVlGVFlPWm0zSWM0Q1F3WlJKWFMzK2t0eXlUdDNCSGNMdndW?=
 =?utf-8?B?Q0FqWjltSlZsSnIxRnBLM05WeWdqNXVIWkptRzNDeDJrYkpOb2pWK3BTM3p3?=
 =?utf-8?B?ZDl0NE9BV1BjUFQwL1Y4SENQbHlyZWxORjJ0bzdlZStNMkJtTmI5TTlxS29E?=
 =?utf-8?B?NkxOU1RZL3h2Q1pvZENjUUJjcjhUeEI0WHR6ZVRBRlJVajgvUEZQQmdsY3I3?=
 =?utf-8?B?UkZqcVkvcjdRRXRhd3NaTGxMQklsUE9BdGlkMjJPTklFL21RNEhiRVRBSFEw?=
 =?utf-8?B?a1dJYmk2czM5Und6ZnBMbzNlWnJrZE00UDV1WXpqODB6MGFNK241TnBPbWZa?=
 =?utf-8?B?NUwrdXQ3b3BsSldxMjBFcVBpTUxlOVZ5WEsvRW83c3BCczlwRUI4UVJ6ZVJn?=
 =?utf-8?B?L3BaVEQxb3BNWGhVOGFWU2t5VkxaWTVESmhRbWxqOXg1WlRuZjhxbml2SExl?=
 =?utf-8?B?K2lIZ0M4ZlZwbnJLMWVPVzVCQWV0YW5OOWIxallpZmloNmk3RFQzbWhPZHFR?=
 =?utf-8?B?SGhtd0pVa3dUYUxjcHozc2RnZFNRc0VVczgxREc5bjA3WnI4cDBtQmFSVXEx?=
 =?utf-8?B?Y2tMTWxiTHFDdUYvbUxYOEdEN3F3TmJBWmtWZ3ErWGlpZ0ZjbC93VkRyZjRD?=
 =?utf-8?B?bG01SVVOak5rUEtoWWg4L29MUHJ4dkc2YmlmeXBnUkxRdzk3VFB2cWF0Zk5S?=
 =?utf-8?B?Y0p1WHpmdXc4eWJVUTgxNXZxL0pxVlNnMi9iNWVpSGNKdGpFYnRRaUZ2TDkw?=
 =?utf-8?B?NzJIanNEdjQ5SkVnUy9panIzWlpMK002dG4vU3loZjAra0ZRRTgrb0VCbEdP?=
 =?utf-8?B?Sm1PZFUxZ2F0ZHlOWFRTNE9VKzh6ME9FaHdNRFEyajBHU00yODlDRGdvUE9K?=
 =?utf-8?B?QVozejlROHEzY0R1RlBaeW9BQ0dOTFhzZnVGWjA2eitNcUtCR2krYTI1RjhK?=
 =?utf-8?B?S0FrQkExSi8rekxOeGViK1I0S3Rjb201YVlUeUNJc0cvOFhvbkp4bE9uaTJX?=
 =?utf-8?B?MUQ0bStpVGNQWEJFV1hlMXFsSWV1Y0hYUXMzc0VUZ3dweDd0RjhSeDJYQ1pw?=
 =?utf-8?B?TWh4S2c3eG56a1dSd2RzTzlQSmF2QmVyYXZXUUxLMk9ZcmR0dnY0TlFPMC9n?=
 =?utf-8?B?ekFaQ2FSQWVNR3ZUNGpGSXRWTzBhd1JhNHNDbkpONkRYcWNWMVBkcU9uRC9B?=
 =?utf-8?B?UHV1eno2SmtKa0UzODAwblVTVGdnRGRjWUZIT2F0Wnh2bjFPZGJlTHdEa2Fh?=
 =?utf-8?B?Y2t4SllFblFtSnZyamxPaU5HMnB4QXRTcThZaGlINEdkMFFwMjczY0JKTXJj?=
 =?utf-8?B?dzJRWkhkcEk3SHZIZVZwcW9POWprUWw1dkc3TXhWNHE4aW40NTMxazVML1dN?=
 =?utf-8?B?aWRNRnZhanNEQTZsT2YwS0xWaER0MDZvZ01Lc3hNV3hNT0JWWElWMlVLaDFG?=
 =?utf-8?B?VGMwRFFYMU82Unlxb3FsSkpiWG5iR2s3Q3Jkdi9qMExibjZpeFVKZXRvSTVV?=
 =?utf-8?B?dEY0aEd6VXNCOWl1aDFxNFRYQ0I1bUNsZmFLWTdUYittUWZDR3VVb1lOeU02?=
 =?utf-8?B?N1FlVzJvMUpxeUVLVFp2bUhpN0s3Nk5KUnZ5Znc4ckRWZ0Uvc0lDaTdMNmtB?=
 =?utf-8?B?TEx0R0ZLMVpFOTJNbXRNV29VZjZmR3E0L25EZExGYUpybUhQRE9IZEdlQ2t1?=
 =?utf-8?B?bW92VWowbjVxZGxmdTVCdERvRkZIeDZKY2hFL0lGUlBWdUNRWlJSNnRtMHpG?=
 =?utf-8?B?R1UzNHlocm94ellVM25Zb2x1M2NWenZaK0FGVWpCSHJxNXk0dmtRLzlUbE83?=
 =?utf-8?B?dEJwNGpxeWdodkpmZDhOeXpCYWhXYSt5NVNJTzVFalliOURqd0NnZjlGSE5w?=
 =?utf-8?B?WklVUnNlVTBzZi9pVWVUa3Q4UW5FZ1VQeE50LzdVdGtMK2JhdnhMK09zWkhC?=
 =?utf-8?B?ZGR4bDZFWi9nQno5ZFcvS3IrZUZOZTVvSkNrUmdFOTVsTFJyNFp6VVFiRVpM?=
 =?utf-8?B?L2VDVnF5a1VjQjBxZTk2QlV5QXhOVzI4c0lKMTdJTDkvU3lJeUZ3akxWeWU2?=
 =?utf-8?Q?FFlppE4/VrqPmYi8=3D?=
X-Exchange-RoutingPolicyChecked: psN9agHAcLUkeEa7edG+AIruw7a/0JfPjGVIyTNJK1D+9ZMHmn1HJ7nlAxn/0gcyXZDkC4rpfxGnVdZ21PsFmi3g6W6WNZ7p8/cGr3RcFOTLPzZ2p3P1Ny0eZqPwX5q0CTvLlG27bNh+7n+1C420fx4erxO6pviMxgZSW/ngeScedEE4pzItYNAJOdU5Nw/eFt4dwiYagdnkJyYOYLA5/It/Cjg24eyUu1hh4aQ02XFaPxFfFje9H9o5PiqSiMRFyIRRR+kYywhbphPHTcFeYcuhDx1jtxfOJ2y7xhMG7zHxnN0WeD3gebsT69h4dJiLuATvthQ72j02RHcSym3vCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b01f4dc3-9645-4dab-1930-08df079d7796
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:21:40.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2WTOsb56U1zAX4zrr/lTyFXOtLXKHsn83Y4kYxxGgTOqgpoMn6j58ys4NCW2Kmh8l2ybcjXVGBx0ETiGox5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7932
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

On Mon, Aug 31, 2026 at 07:15:36PM +0530, Srinivasan Shanmugam wrote:
> GPU drivers often need to queue work when a dma-fence signals
> because certain operations (copy_to_user, eventfd_signal, memory
> allocation) cannot run in IRQ context. This pattern is currently
> open-coded in multiple drivers.
> 
> Introduce drm_work_fence — an embeddable base structure that handles
> the dma-fence-callback-to-workqueue pattern in one place. Drivers
> embed this in their own structure and implement ops->work() for the
> deferred work and ops->destroy() for cleanup.
> 
> The helper manages:
>  - kref lifetime
>  - dma-fence callback registration
>  - workqueue dispatch on fence signal
>  - safe cancellation before driver teardown
> 
> For work that additionally requires borrowing the process MM via
> kthread_use_mm(), see drm_user_fence which builds on top of this.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/Makefile         |   1 +
>  drivers/gpu/drm/drm_work_fence.c | 195 +++++++++++++++++++++++++++++++
>  include/drm/drm_work_fence.h     |  76 ++++++++++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_work_fence.c
>  create mode 100644 include/drm/drm_work_fence.h
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd783..c5be8e80d0c8 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -72,6 +72,7 @@ drm-y := \
>  	drm_vblank.o \
>  	drm_vblank_work.o \
>  	drm_vma_manager.o \
> +	drm_work_fence.o \
>  	drm_writeback.o
>  drm-$(CONFIG_DRM_CLIENT) += \
>  	drm_client.o \
> diff --git a/drivers/gpu/drm/drm_work_fence.c b/drivers/gpu/drm/drm_work_fence.c
> new file mode 100644
> index 000000000000..9f6b779d0fe9
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_work_fence.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2024 The Linux Foundation
> + *
> + * Common DRM work fence helper.
> + *
> + * When a GPU dma-fence signals, drivers often need to perform work that
> + * cannot run in IRQ context (e.g., memory allocation, copy_to_user,
> + * eventfd_signal). This helper queues a work item when a dma-fence
> + * signals, allowing that work to run safely in a workqueue context.
> + *
> + * NOTE: This helper consumes dma_fences but CANNOT implement
> + * dma_fence_ops. Work items queued here may sleep; dma_fence_ops
> + * callbacks are called under the fence spinlock and must not sleep.
> + *
> + * For work that additionally requires accessing userspace memory via
> + * kthread_use_mm(), see drm_user_fence which builds on top of this.
> + */
> +
> +#include <linux/workqueue.h>
> +
> +#include <drm/drm_work_fence.h>
> +
> +static void drm_work_fence_destroy(struct kref *kref)
> +{
> +	struct drm_work_fence *wfence =
> +		container_of(kref, struct drm_work_fence, refcount);
> +
> +	if (wfence->fence)
> +		dma_fence_put(wfence->fence);
> +
> +	wfence->ops->destroy(wfence);

I'd invert these for safety in case destroy wants to looks at the fence,
admittedly that would be an odd use case.

So...

	struct drm_work_fence *wfence =
		container_of(kref, struct drm_work_fence, refcount);
	struct dma_fence *fence = wfence->fence;

	wfence->ops->destroy(wfence);
	dma_fence_put(fence);	/* this has a NULL check */


> +}
> +
> +/**
> + * drm_work_fence_get - Acquire a reference to a work fence
> + * @wfence: work fence
> + */
> +void drm_work_fence_get(struct drm_work_fence *wfence)
> +{
> +	kref_get(&wfence->refcount);
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_get);
> +
> +/**
> + * drm_work_fence_put - Release a reference to a work fence
> + * @wfence: work fence
> + */
> +void drm_work_fence_put(struct drm_work_fence *wfence)
> +{
> +	kref_put(&wfence->refcount, drm_work_fence_destroy);
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_put);
> +
> +static void drm_work_fence_work(struct work_struct *w)
> +{
> +	struct drm_work_fence *wfence =
> +		container_of(w, struct drm_work_fence, work);
> +
> +	wfence->ops->work(wfence);
> +	drm_work_fence_put(wfence);
> +}
> +
> +static void drm_work_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
> +{
> +	struct drm_work_fence *wfence =
> +		container_of(cb, struct drm_work_fence, cb);
> +
> +	queue_work(wfence->wq, &wfence->work);
> +	/*
> +	 * Put the transferred reference from add_callback. The stored
> +	 * reference in wfence->fence is released in drm_work_fence_destroy().
> +	 */
> +	dma_fence_put(fence);
> +}
> +
> +/**
> + * drm_work_fence_init - Initialize a work fence
> + * @wfence: work fence to initialize
> + * @wq: workqueue to run the worker on (must be ordered if sequencing matters)
> + * @ops: driver operations
> + */
> +void drm_work_fence_init(struct drm_work_fence *wfence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_work_fence_ops *ops)
> +{
> +	kref_init(&wfence->refcount);
> +	wfence->wq = wq;
> +	wfence->ops = ops;
> +	wfence->fence = NULL;
> +	INIT_WORK(&wfence->work, drm_work_fence_work);
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_init);
> +
> +/**
> + * drm_work_fence_add_callback - Attach a work fence to a dma-fence
> + * @wfence: work fence
> + * @fence: dma-fence to watch; ownership of this reference is transferred
> + *         to the callback — caller must NOT put it afterward.

This isn't right. It is perfectly reasonable for caller to hold more
than 1 reference to @fence, thus put it again. It consumes a single
reference @fence on success or failure - that is it.

> + *
> + * When @fence signals, a work item is queued that calls ops->work().
> + * If @fence has already signaled, the work item is queued immediately.
> + *
> + * An additional reference to @fence is stored internally in @wfence to
> + * allow drm_work_fence_cancel() to be called safely without the caller
> + * needing to hold a separate fence reference.
> + *

Ideally get rid of double ref count on @fence. I don't think above
reasoning justifies the needed for a double ref on the fence. I'd tie
exactly one refernece @fence which is attached to lifetime of @wfence
(i.e., drop the dma_fence_put in drm_work_fence_cb).

> + * On any return value the caller's fence reference is consumed.
> + *

I'd mention regardless of success or fail, a reference to drm_work_fence
is consumed too.

> + * Return: 0 on success, negative errno on error.
> + */
> +int drm_work_fence_add_callback(struct drm_work_fence *wfence,
> +				struct dma_fence *fence)
> +{
> +	int err;
> +
> +	drm_work_fence_get(wfence);
> +	wfence->fence = dma_fence_get(fence);
> +
> +	err = dma_fence_add_callback(fence, &wfence->cb, drm_work_fence_cb);
> +	if (err == -ENOENT) {
> +		queue_work(wfence->wq, &wfence->work);
> +		dma_fence_put(fence);

Keep the implementation in one place?

drm_work_fence_work(&wfence->work);

> +		err = 0;
> +	} else if (err) {
> +		dma_fence_put(wfence->fence);
> +		wfence->fence = NULL;
> +		drm_work_fence_put(wfence);

Won't drm_work_fence_put just drop the 'wfence->fence' reference if
'wfence->fence' isn't set to NULL. i.e., drm_work_fence_put(wfence) can
replace the above 3 lines.

> +		dma_fence_put(fence);
> +	}
> +	/* on success: transferred ref goes to drm_work_fence_cb */
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_add_callback);
> +
> +/**
> + * drm_work_fence_cancel - Cancel a pending work fence callback
> + * @wfence: work fence
> + *
> + * Attempts to remove the pending callback before driver context teardown.
> + * The caller must hold a reference to @wfence across this call.
> + *
> + * If the callback has already fired this returns false and all cleanup
> + * has been handled internally.
> + *
> + * If removal succeeds the callback reference is released internally.
> + * The caller must still release its own reference via drm_work_fence_put().
> + *
> + * This function is safe to call from atomic context as it only acquires
> + * the dma-fence spinlock internally. If the caller also needs to wait
> + * for the worker to finish, use drm_work_fence_cancel_sync() instead,
> + * which may sleep.
> + *
> + * Return: true if callback was removed, false if it had already fired.
> + */
> +bool drm_work_fence_cancel(struct drm_work_fence *wfence)
> +{
> +	struct dma_fence *fence = wfence->fence;
> +
> +	if (!fence)
> +		return false;
> +
> +	if (dma_fence_remove_callback(fence, &wfence->cb)) {
> +		wfence->fence = NULL;
> +		dma_fence_put(fence);  /* callback ref */
> +		dma_fence_put(fence);  /* stored ref */
> +		drm_work_fence_put(wfence);

Same comments as above: No need for 'wfence->fence = NULL' and
drm_work_fence_put, drm_work_fence_put is work by itself. Also see my
comment about dropped the double ref, that isn't need either.

> +		return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_cancel);
> +
> +/**
> + * drm_work_fence_cancel_sync - Cancel callback and wait for worker to finish
> + * @wfence: work fence
> + *
> + * Calls drm_work_fence_cancel() then cancel_work_sync() to guarantee
> + * the worker has fully completed before returning.
> + *
> + * This function may sleep. Must not be called from atomic or interrupt
> + * context. Use drm_work_fence_cancel() instead when sleeping is not allowed.
> + *
> + * Drivers must call this during teardown before freeing any resources
> + * accessed by ops->work().
> + */
> +void drm_work_fence_cancel_sync(struct drm_work_fence *wfence)
> +{
> +	drm_work_fence_cancel(wfence);
> +	if (cancel_work_sync(&wfence->work))
> +		drm_work_fence_put(wfence);

This will UAF if drm_work_fence_cancel removed the callback.

I actually don't think drm_work_fence_cancel, drm_work_fence_cancel_sync
is safe unless the caller has reference to drm_work_fence.

Consider the following case:

- A driver calls drm_work_fence_add_callback
- Sometime later if calls drm_work_fence_cancel or drm_work_fence_cancel_sync
- drm_work_fence_work completes before either drm_work_fence_cancel,
  drm_work_fence_cancel_sync completes, we UAF

So with additional reference at the caller assumed...

I'd write this like:

if (drm_work_fence_cancel(wfence))
	return;	/* Worker not running, all internal refs dropped */

if (cancel_work_sync(&wfence->work))
	drm_work_fence_put(wfence);	/* Worker cancelled, drop it ref */

> +}
> +EXPORT_SYMBOL_GPL(drm_work_fence_cancel_sync);
> diff --git a/include/drm/drm_work_fence.h b/include/drm/drm_work_fence.h
> new file mode 100644
> index 000000000000..4fa369f937d7
> --- /dev/null
> +++ b/include/drm/drm_work_fence.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2024 The Linux Foundation
> + */
> +
> +#ifndef __DRM_WORK_FENCE_H__
> +#define __DRM_WORK_FENCE_H__
> +
> +#include <linux/dma-fence.h>
> +#include <linux/kref.h>
> +#include <linux/workqueue.h>
> +
> +struct drm_work_fence;
> +
> +/**
> + * struct drm_work_fence_ops - driver callbacks for a DRM work fence
> + */
> +struct drm_work_fence_ops {
> +	/**
> +	 * @work: Called from workqueue context when the dma-fence signals.
> +	 * Perform any work that cannot run in IRQ context here.
> +	 */
> +	void (*work)(struct drm_work_fence *wfence);
> +
> +	/**
> +	 * @destroy: Called when the last reference is dropped.
> +	 * Free the containing structure here.
> +	 */
> +	void (*destroy)(struct drm_work_fence *wfence);
> +};
> +
> +/**
> + * struct drm_work_fence - embeddable DRM work fence
> + *
> + * Provides a dma-fence callback that queues a work item when the fence
> + * signals, allowing work that cannot run in IRQ context to be deferred
> + * to a workqueue. Drivers embed this in their own structure.
> + *
> + * NOTE: This helper is a *consumer* of dma_fences only. It CANNOT be
> + * used to implement dma_fence_ops. dma_fence callbacks are invoked
> + * while holding the fence spinlock; work queued here may sleep
> + * (copy_to_user, kthread_use_mm, eventfd_signal) and must not be
> + * called under that spinlock.
> + *
> + * Call drm_work_fence_init() at creation and drm_work_fence_add_callback()
> + * to arm. Call drm_work_fence_cancel_sync() before driver teardown.
> + */
> +struct drm_work_fence {
> +	/** @refcount: Reference count. */
> +	struct kref refcount;
> +	/** @work: Work item queued when the dma-fence signals. */
> +	struct work_struct work;
> +	/** @cb: dma-fence callback. */
> +	struct dma_fence_cb cb;

You could likely use union trick here on work_struct, dma_fence_cb and
only defer the INIT_WORK to drm_work_fence_cb.

> +	/**
> +	 * @fence: Extra reference held for safe cancel(). Set during
> +	 * add_callback, released in destroy().
> +	 */

See my comments this ref count. Ideally: "A single reference held for
the lifetime of drm_work_fence after drm_work_fence_init is called"

Matt

> +	struct dma_fence *fence;
> +	/** @wq: Workqueue to run @work on. */
> +	struct workqueue_struct *wq;
> +	/** @ops: Driver operations. */
> +	const struct drm_work_fence_ops *ops;
> +};
> +
> +void drm_work_fence_init(struct drm_work_fence *wfence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_work_fence_ops *ops);
> +void drm_work_fence_get(struct drm_work_fence *wfence);
> +void drm_work_fence_put(struct drm_work_fence *wfence);
> +int drm_work_fence_add_callback(struct drm_work_fence *wfence,
> +				struct dma_fence *fence);
> +bool drm_work_fence_cancel(struct drm_work_fence *wfence);
> +void drm_work_fence_cancel_sync(struct drm_work_fence *wfence);
> +
> +#endif /* __DRM_WORK_FENCE_H__ */
> -- 
> 2.34.1
> 
