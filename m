Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C31606A333
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BgNYzdSp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=c0fIQb0j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD2011262F;
	Fri, 13 Nov 2026 15:09:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF0311262F;
 Fri, 13 Nov 2026 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794582562; x=1826118562;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=VW1cI/qemyFNYrhcwASWCPLjlraB4JmGakamuvUw1FU=;
 b=BgNYzdSpzeOwzqEXOGl8ROpPZClJgt91OsqGEMb9OojDxqfszkTbTgAR
 y7DIed5kGW5q7UM3pdiFSYvDJVNbMOT3gI/ISXVhcuxKAZMQRahaLOqP/
 YjkZBPgI9z80HOi1WDomYqrF0tebV0RtG3W31vEczBbYkMotZrnzK5O3+
 pFEQ2KMP/LBcXwEBDfu4u0qGwzUUWW9BZOG7ZMbDr+MZ+cKR3HsCURYOb
 Zdv2Aa+8ugINsCJtEIRFcsbcdz5gYNoUPb7Vrc4ptk6gcFlZ2fmVrnL5O
 BpBjbNwU7rF1rLK/t9HpfaK+m71us4Gg/qdqLwbneIFyPQd0DXWLfnpPY Q==;
X-CSE-ConnectionGUID: 5ZuLJsyqTWyn1U1sQSfp+w==
X-CSE-MsgGUID: R1NWYv3mRO++d9I5JYdd8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3421574"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3421574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:09:21 -0800
X-CSE-ConnectionGUID: FsPdEJDBSHqkiZ6AOFbAlw==
X-CSE-MsgGUID: Ku0sNUv6TKe5361NPaax5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9215813"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:09:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 07:09:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 07:09:20 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 07:09:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5TCXb3xpVt6HVqQ97zigqndk1YzsqWQmndJoE+gkDdKV9t82UfZfGqmHSLTT+USpnvLQsGdMeYLkJvXEPL33pHhT+fEoM8FkhaLQXZdMuHi7VTJUABwXKFEbHvZPkxbeA92cWu9rm3XVp6n8uYQDvxoikK+vXBNUvVoFFTh+BDqhF8Bov9SGpnva4xzCQElpGLzpbuDoGrIaehXdIs8CskH21pvpEudMK/fGnCe0hfffSGNW+Sb2n3vLqCA9Xu9yQIJ4etUIB7p3w42e2cF9U87oztemrN5q/ShgUeZYTH3Cm/SXulKYcWIQvN5bavqIaE0HPcrM0ycmN6c4JYecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knUxariH0ZZqi0WHiqJ+vCbrC8phH67nrj0Atf84wZc=;
 b=AzAh+kvgYDrp+RYWjzYvy77mPA/DOvNwqpLUn9IBDfFhaomY7Bbt+OwfxzNKUTntxBByww36j/Tv57WUJVTDt3rxZWwpxwkfABfmKZzJagIi//itdyB7FSFx4z83f2+/CqvqMfNt8KMDKPdp7cai35gmAM6ftI8DdqHVmsYhOWQix47cE8OqsbXWTuYNjDlpSiGJSbM6RdWplJjDcpQeIo61frkI++wxqBU4o2rqIGHJcT3e69Adyy5FEJ0GpMHGaPZnJtPkFsmP7tG36Z/dpDsFVCQXd3yZfSzm7hRYWDY/wR9Kttyv0CZpq0PQhCLNrHprVpGdl9wtCCzPomXC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knUxariH0ZZqi0WHiqJ+vCbrC8phH67nrj0Atf84wZc=;
 b=c0fIQb0jzTEBcMqUuUKG68qt9IPNxfg+ruKIqm5crDPk7rUSQ6d6YOwX2+YW9InDKWWPcjfI67lPQiGAfS0ryBzUAKNMyf5utlfsjsGLQITXO0ZP4ScRm4FJUkXTbFLj3fC3ZLJAEJRKnSUXEKyFoJLqz9dRkVqxY7QDtwvcVvQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA4PR11MB8990.namprd11.prod.outlook.com (2603:10b6:208:56b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 15:09:11 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 15:09:11 +0000
Date: Fri, 13 Nov 2026 07:09:09 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH] drm: increase 64-bit mmap_range size to 8TB
Message-ID: <avcoFV3ugyumPTnn@gsse-cloud1.jf.intel.com>
References: <20261112122049.1990826-2-matthew.auld@intel.com>
 <007c58e6-9af5-4d42-b307-0827df55fbb4@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007c58e6-9af5-4d42-b307-0827df55fbb4@amd.com>
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA4PR11MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 45892a60-0e9f-4be8-9265-08df4198128f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261102123227099003|261021121427099003|261009221227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KUF/41rOjjanIVvM5SQ04/F4Ztaor7QoqB+NCya9BOX6bJT2cLwFVzIKMppHTTA2Yxn4vD+X3p/uYuAyOWqfdguUSVbSc9fJfkuL8Djn6RJIoVKsrlLm2WKsRGDczNtJs8mcO1aWx8mnT7UoOJeHuxSuNUJ4KiZY6nj7JOAzsxUDX9WdYQYH/J3MjyOADwkKjU8aisHz48TNb/WB+q3dbSoICP5sXx2AfScOMGRRDqHRULDWuxJoSYID6Izet5AZmz6c38YB067RyxY/qqqJ4qpDAgH3z3VybWOUbtxAWIzsZXgsrh5/8ppUbzrAJ6J0ueUZ9M/s+qhEHr+ypPIECyp9L8JSHX60sIKJ80P57vohGLm/+NDmaeJ/MMIS19z2aRf67CDyTj4loaPJoR3i2bYAVBfNV4F8E8DXXl5gSMFrN2d4+qNGsukuGXY/xj68LG1mI+2jZc271ilGPOaVn6gvloDjEu1cJ7PQQhad0IG6OhpZQ1imdZjIopeFIEudClFQ8a+b3zu/cOpaz933YBdsnrEikiVuW5ppWqtxCT6B6uutWM7j/R0OJWvKxNpPg9p/5e9xae75hQKKh+FSaqnUX8vtcQxtgmpD2XM+6kk+NvpZyExGSGXsFCaBm0A0wKQDMeCrzo7KvrJAHcZ5VJsM8PFIs/uUflpNWMkY9VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W7Q7nZIYQQ33M7WIRZiw98l6XqNpzloGh4wmwKe6I76lEZCP0KsMpimKFn?=
 =?iso-8859-1?Q?VVLzIUXeHTrqUdw1gnuMh4Y+vzFulZBoDdzJB716JAwqBRTvsJa7dSLExG?=
 =?iso-8859-1?Q?4zT4QLNz1/v+hAOgfquQ69XMqFS4JxFOGAGN9VhP1fF/UZIf+lb++uAzSj?=
 =?iso-8859-1?Q?9syi9mUQkvnkplPKNzWa5UA90arIxMjhL1vR7agTnm9ztR+cVx2ppuQ9f2?=
 =?iso-8859-1?Q?XoT7X683Nsr8Hsi/qlxuHMahPWMheY3LxcypHPKKtd1ZWlCvS3GFp6Tk77?=
 =?iso-8859-1?Q?2LXPQsKgOWGF4RfPbyvanGTMvTUhCJ324IllNTVMOxJdNJ33gKhhRtchCq?=
 =?iso-8859-1?Q?CevDJGDkf4/v8kNoRhiFlqkIlMw9gmcYdOB933GYuzooapDpRvW/NsNIYJ?=
 =?iso-8859-1?Q?0AJ82ddOVsoHSbI9IPR+NXGCCfFC0uuc7vMfHxOW88JAB7ZuAIP8DZkX5r?=
 =?iso-8859-1?Q?nmIPrOzFn12tdqwMfhYg2oQu2rsYow46D7hibfcL2u2GzJfW0o+EGAf7rv?=
 =?iso-8859-1?Q?YdE7QcFfcfJU0MkWVkey6/ahDKvt1GOYN1tJEdx2OlIfDQlsicUcGOhFwZ?=
 =?iso-8859-1?Q?cAgDGHRT5Gl5mY5Knlp4PkZB6c7JIY4wtc+YeiQ6CTdzXJceQpEsoofEG2?=
 =?iso-8859-1?Q?J60xEr+z8D+826XHdVShJOrK7fLPSzgA6eib7qDVJfbOdnV6jdiwjmXbHl?=
 =?iso-8859-1?Q?+idsJkUBERsrQKHviPBRjFCh4ndSoolpjRvIrPCzbvo32fcAwhhkWB9Ijw?=
 =?iso-8859-1?Q?VOQjvrofpi7HJf4RaeAmRDRVZiJIUKLysp6vvsPpiJtnDJp4yAUJ2AR6uX?=
 =?iso-8859-1?Q?4EBVURNPfdtJKBUn953BWQiewUuwavPsFSlB06guSaCMKP1j9drA4MJw2i?=
 =?iso-8859-1?Q?P7lSYx2a3Z4vaJ0B3IVpndGQnwm1vkI2x9FlSJXULINKSIxy6cPYfhtR+B?=
 =?iso-8859-1?Q?y12pzEHtCNKSQorh2BHdRBCRnxpW7meevGbRrOrwm4ffpkvKL9GoamR80E?=
 =?iso-8859-1?Q?y9Wsve2BU3fjYou1ekTgdEOp/GEUiXaWYsB0nqqy++jvZp1QhDzchHZbFV?=
 =?iso-8859-1?Q?SYvSN62fw4DZUr/UqA5yR6MR9zjg/c0XvddGMpq3mfAvXD07+peRpSDLfr?=
 =?iso-8859-1?Q?F6XC+5sg+WL003iP1wAJJbHWbr2D6fgSKHkkGhcJnqWbcVF61cOTcM/vzx?=
 =?iso-8859-1?Q?sf8gLVD1ExykqEuyBNNp0O3dIBmWXcJ1KxnTXolFh/7czg+Y6yNREAnxTg?=
 =?iso-8859-1?Q?QY8pgBNRwYvwr66X3wDvB5isH5rUCJZ7JWA63tiCz+9GqRKHH5aA70pMx0?=
 =?iso-8859-1?Q?xrYCCthCSitsGMano4DVCF8O0NJ+f76B0X6qy6S3Gx4Ze5GI7kg5K6QTpp?=
 =?iso-8859-1?Q?gzniZA6YP0RxIrBTjcXZCWlejtkGg2m/zIlnMH48wVIOB+1x2b6olM7L0A?=
 =?iso-8859-1?Q?DNJnj9aDEZ6AlJWhMCmPbl0hXK5JXpj/1PFCyDGSHtG//hj6IP7jsq/7jf?=
 =?iso-8859-1?Q?IssiGABps944kqgeSbuR3khNmhQXhCh0b2U8/wD9kl6E/neb+SDfyN1Qol?=
 =?iso-8859-1?Q?hvm5QfQNmFJeRN3JJ6Ysk840bMwAW3ra9ODunKU8+/MOMvQeid6V6gYPLN?=
 =?iso-8859-1?Q?OD0oZo+9kKlkbnLCndYsMNygQ7ule5BHV8KQRYiVtuLW+VLJw+I5C93ytI?=
 =?iso-8859-1?Q?tmv0fveZ5HZ382xIwro7JepSokWbHrob56TQIaQvkCgw48gVv7nJALXYOK?=
 =?iso-8859-1?Q?s6ubepgl8YKE6qQ6vzQC9NY7R48ulWcg4FiLWOf5Q31pQVGXhCnrFX8M+O?=
 =?iso-8859-1?Q?CXIevA2vNw=3D=3D?=
X-Exchange-RoutingPolicyChecked: zubn4/huEPOWneMzeweiqxqWfyfRuMPuIhDjSRHWBJ121aOgCFCpJRxWjE+lG/lmxiv9LxMi2SZCeIEvitMxjTy6q2OPuXTE25EtZgzDV48OqT+tA+AUfupGeuDGeC6nLN8rpQg/ixuoEdD1na2MTPj0L3XCReUU0gy2Bx4vP2FgM8g+zZZyieSJPlGQLkWr2kAQ8Ipt0vpvWmFM0WFl22qVG4hqkpvHmBaUDJpyM4josFcDk4f5rfig+ILuI1tZ8+yyd9aE3ukzUyh8gyTWyjfR3KVtWx3W5BRe18PQ8toRpo/rPuDM9SVLtitaY1hwZrwZJkk+Th9qMfQ0ejUs0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45892a60-0e9f-4be8-9265-08df4198128f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:09:11.3911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gORcdFbHTNL+Y+cMMnWF58oXWsWKeo+sTDefTwNc+HVHmhkqOqys09JtJtolMUdm1hkcF/N5uJrG1e37+mLnCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8990
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 01:58:22PM +0100, Christian König wrote:
> On 11/12/26 13:20, Matthew Auld wrote:
> > Every GEM/TTM buffer object, including imported dma-bufs, allocates a
> > fake mmap offset from the per-device drm_vma_offset_manager. On multi-GPU
> > systems with large VRAM, peer-to-peer dma-buf imports across devices and
> > processes can exhaust the current 1 TiB 64-bit range and fail BO creation
> > or PRIME import with -ENOSPC. Skipping mmap offset allocation for
> > imported sg buffers is not straightforward without risking userspace
> > regressions, as existing userspace (such as Intel compute-runtime) still
> > queries mmap_offset on imported host dma-bufs even when mapping the
> > dma-buf fd directly.
> 
> I was just about to ask why the heck we grab mmap offsets for imported DMA-bufs :)
> 
> > Increase DRM_FILE_PAGE_OFFSET_SIZE on 64-bit kernels so the fake offset
> > range spans up to 8 TiB (SZ_8T). This stays strictly below panthor's
> > DRM_PANTHOR_USER_MMIO_OFFSET_32BIT (1ULL << 43) carveout and within
> > 32-bit compat mmap2's pgoff limit (16 TiB with 4K pages).
> > 
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
> > ---
> >  include/drm/drm_vma_manager.h | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/drm/drm_vma_manager.h b/include/drm/drm_vma_manager.h
> > index 6c2a2f21dbf0..2c3233f9dec4 100644
> > --- a/include/drm/drm_vma_manager.h
> > +++ b/include/drm/drm_vma_manager.h
> > @@ -26,16 +26,23 @@
> >  #include <drm/drm_mm.h>
> >  #include <linux/mm.h>
> >  #include <linux/rbtree.h>
> > +#include <linux/sizes.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/types.h>
> >  
> > -/* We make up offsets for buffer objects so we can recognize them at
> > +/*
> > + * We make up offsets for buffer objects so we can recognize them at
> >   * mmap time. pgoff in mmap is an unsigned long, so we need to make sure
> > - * that the faked up offset will fit
> > + * that the faked up offset will fit.
> > + *
> > + * On 64-bit, cap the range at 8 TiB (SZ_8T) so offsets remain below both
> > + * panthor's DRM_PANTHOR_USER_MMIO_OFFSET_32BIT (1ULL << 43) and 32-bit
> > + * compat mmap2's pgoff ceiling (16 TiB with 4K pages).
> >   */
> >  #if BITS_PER_LONG == 64
> >  #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFFUL >> PAGE_SHIFT) + 1)
> > -#define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFFUL >> PAGE_SHIFT) * 256)
> > +#define DRM_FILE_PAGE_OFFSET_SIZE ((SZ_8T >> PAGE_SHIFT) - \
> > +				   DRM_FILE_PAGE_OFFSET_START)
> >  #else
> >  #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFUL >> PAGE_SHIFT) + 1)
> >  #define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFUL >> PAGE_SHIFT) * 16)
> 
