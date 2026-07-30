Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89ACC55166
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368F310EFD7;
	Thu, 30 Jul 2026 16:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AY4oVNfL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0197010EFC9;
 Thu, 30 Jul 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785427618; x=1816963618;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=ZTg2dt3uNW2UEQsPG0J1F3NgGmef8i6gGDXbo+b1GxU=;
 b=AY4oVNfLnstBlwWCcX/Rncqj3pgADcbowQ/Lnngbrfx9MmqBw4X4qjAl
 5xBxQGXG8uAOQq+BwzazFh1Pypv5dmN2zO89/vIGIAD5W3jamtobVfCEe
 CpN0M2jgEE2BabSJt9lLXDYLGpEsxL3Rz6EYl1cIPSafuv6VZQmsf/eKL
 jwEzqEYzDLOywRQDxKnhW6isqRIvDOntUl+QR07rBh9WUI2LMkK4tWior
 tsIPs6ckp/zbY5VftRG2zg65DL+5/t/Z0QE2ntI0oaaKkhv5QJxd6muXK
 nFgR4k76ZR1EMFKlwHekQcpZy6C/Vlg3MYE6A3wWRkiiLPSLzRnbPB/ow g==;
X-CSE-ConnectionGUID: 9VVf6ZrhTdyqbKiTW3WPvA==
X-CSE-MsgGUID: tpq3dqdMQJuiaJyFMqiEdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85814720"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="85814720"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 09:06:57 -0700
X-CSE-ConnectionGUID: 6FGE7YyJSIOEDbJn3wG1YA==
X-CSE-MsgGUID: mrOYGlIVQX6hTQszNhHmoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; d="scan'208";a="284928011"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 09:06:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 09:06:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 09:06:55 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 09:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob+Au6ugPCLqUDeek4hF+geu/THe3kplEyACnf4En3qwqvJIiIHIQarfexz5FL1hIXljE7yadIuSyDjbcpV2qQS/kLihv0pWQeNuAwsAhHPOnihMYqwPWqNYmgkFOVqy+IYxZ7ixNlO4gWTNxDiSpGMKkE8CcIswRMnJYqVHf24Ca3hSmdHjg+cvBuWaTKSjmNwzun71aKfcStEUIwnR14rM6J+MeMNiDY3YjA4o4CNopOieXXlO0jQpkfM6HtQLCnVQDFdGGDlc3u3x8ppdfAUVFemXEZIwsi61e3+2x4BQIwCAlZeIND04J39TNhrczmwPbyy0EjbNrjCtaAaqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SKod4/B+UMt4ogIFKt1R4FZYQsrmlJgnqlkBfs9m/4=;
 b=R+h4GH+K80nNkEae36sUoNC+UoQJn7ypIXpo/vwQwtkfS7I0vkKBLUIh1TwgQeD2l2W3IoRk5kOQr/0S1Xm35T/wArKKyeIMzYhiq/sLG3AtiUVhZsBvs3b0gt47sdNggoc1I4jIRw2NxKwovYcBfhrj3C4fJJ4H/YASxqPxrBo5w4GJThJKaQUBkm0W7+7cRQq/0DWevjzIOGXx1PLpZ+FGIXUVzxbX8PzuxVkdtFx7Q0Gtn5QEHHEomC/xrLO89ueWFOxT1xiusWdtwcRigELL8OgDWS307AFbmEddY0RyY7AxPyUE809DwqF7MtrywlESLUO1Pk2u+ctAfEDngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SN7PR11MB7089.namprd11.prod.outlook.com (2603:10b6:806:298::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 16:06:45 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 16:06:45 +0000
Date: Thu, 30 Jul 2026 12:06:40 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-next
Message-ID: <amt2kDVdyBK6VEyU@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SN7PR11MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e63b8c0-0f97-42d7-e0e3-08deee548d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|10067099003|18002099003|18092099006|3023799007;
X-Microsoft-Antispam-Message-Info: At9GMnb70mTn/GTRCofOfOCDomFd3dkQCHKNnz2Z6pa/ghsxD7fDFIdPfpCIAGibkHgB//2YVC3ozNTFumG+gdWE4DqrYU9SaivUlCAP7KthwS0L10owoS5KuGoGNvSLY0QY2LLaH7Bl5XwID4i/Sfh18CR1Mvu1aQpSd6yn0SzpOe0xuazvrKANXtwp48XvsCKkOUldFCFIqJiCXyTM2HzbrUuVS5mYS+DMAf/LQtvcwKHw2gLl3tGA9tzieuNn5KlcqQmM8ndwoPslAJYXpH5BIJecdcLXUekEAnBdDgWLuQuiqWX8zCglCytd3cMVFW4+iqcGDRa346kmE9AXl6UZDR9pmv1gQ4qljOCvJg4Y7/Ya916lCzSwuoQiKST9N2917IRv1rGuU9zwHPQNujgT7TfTdKTCBFwuUaPWpq+5wS2g8VOAdYdJiGP1ooxH1B/dOobKheheZxmdY5LNgf95Gh1Kvn4ux1/0J4u2imYCfgwIjmTvkNUQPLHq6/bNUYvG8JzhjcPFZ9aIHrkWQBaqaringDDHtzkJr1ejYvYbs5xQOfqm4jkHt7IORAJEUdOhQGsgrPHxoViEdB4PccitNYJi1HnqugHON+hqh5mQVqdFw0/K3k/b5uZDRBOl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(18092099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nk+ZuxKoqmaDsibRwX+HIpMTJDxvSr8XieKb3P5lyTgHk0gv1ygNjlPQ6u?=
 =?iso-8859-1?Q?3cFA60AiGhSqtwP1rc0ucvW9t/7FLl9/DZW4UkjUJeKc4Rv1qSMel1b0Fs?=
 =?iso-8859-1?Q?TIgCR4G9NIqONx6o+l2dudntOdDxPpO1WACV3incZFkKdbuUSdvYnzEMQO?=
 =?iso-8859-1?Q?1OddO91q+hdXgCRhuctpMng/559FcQcTG+/bqaWMhGRoMH48//hbqa+inI?=
 =?iso-8859-1?Q?7ZKk6ouQJWFuVYoVJaVRcLSoNTFZZruhy9osHqSd6DSm+hrXaW7Uq+deeD?=
 =?iso-8859-1?Q?dLZW/RVW3Xbws4TNp/cUWHNPIGRueKkDR5qt9Onr4Ec/+Pk/LQnciDCKuW?=
 =?iso-8859-1?Q?MR4Ba5FIl4Jl/J/x+Oyj4mj+l8oAKmiq8gUXGs3HnZG5+2jKCy+xh95nET?=
 =?iso-8859-1?Q?zgwD9aj3l9pn1c5rwKKevvAWI9o4bU9k50n+aR+s6sFHB7X70AAXAj7SrW?=
 =?iso-8859-1?Q?/dSXXrIujtDPoVFVHH5v831o72guJz5KNjHEWQlQIbxiBbmjZaMYMekoz0?=
 =?iso-8859-1?Q?2w58C8B7h2MLFT1653UFdhR7WmqWBir0RYbLyeE2/1F5MYHasg1f4sRRnb?=
 =?iso-8859-1?Q?MJq4khL2x1yN/2NGGKotnebsg93y8BskjTJzfHhz1L4OJCA6L82cdStFLF?=
 =?iso-8859-1?Q?mZiG9B+I5aZpMFiOdd3y5KumoPr1sAcuAnjDZB1HDOnGtTVO1mLBYAKPAa?=
 =?iso-8859-1?Q?YU7seA8ydYeX4gJbKKgrRfUtio4MbRBPhRCSRARGsjqJI0ZSRLeeJ0ndjX?=
 =?iso-8859-1?Q?ocQXUrxVPmhCdSmp6ejGPGijEr2LynEnuF4xVi6DkW28+AcDvWtfHYw+sg?=
 =?iso-8859-1?Q?gfutNY46eEPoT/hAV46K6KQIqBGqsPHsilloQ7N1nptzAL4PdvXBRYvm9y?=
 =?iso-8859-1?Q?jrYLHT6DmU6zGmKIV8UaFLPQ8nkLKqd8vCdIQexrZ7DuxQm0oNW6ZIomOU?=
 =?iso-8859-1?Q?ClXZfRKUmvydQwOXm6Up72/3ia/oVE+oiXY8WBxEQXV8D/5PoGgHn8kHwM?=
 =?iso-8859-1?Q?DEzH7gQRA5c0j3PfFsdFhOW32cGHuuJBVlOjJlUjWLW7X7z34imxqFlZep?=
 =?iso-8859-1?Q?58EjA2JMIpPL8MoDSo+vJJUm7UvdpACS+xqjo+8D7r62xVBABHAyPzBX5C?=
 =?iso-8859-1?Q?ndTZUXRPGah6+E7Y25LgKPMtmFXhzgNvYpzcoxJ9AxE869DzIVPAjnwCI7?=
 =?iso-8859-1?Q?g5j4P1nJSr+DLJJFvIm8JVtzm2Sf3nhrY20Hzp0BArt9UDS4ioasnnd6ft?=
 =?iso-8859-1?Q?DfN1tOtt2dlTOO7Vbsk1Qg9dc2f5Sf5hXqN7JRoOT/3eh7Hzf7gVv4+Qp6?=
 =?iso-8859-1?Q?fP2ls8PAyh5lAGoJSQfa12FTCS5W4Oj/6wSy9/kZo1uLnRPJjfBaxpwmoy?=
 =?iso-8859-1?Q?DuOJBBHzxNdVdS8VdMz1Gn1rcU7R18CQHz0ia9cnU9cuvbnBs2rshQjCSc?=
 =?iso-8859-1?Q?3db6j+i4h4zcOggkxrTCVyOb0kHXnoRlX6xugvF40h2Yjx0WdZri1xOVm0?=
 =?iso-8859-1?Q?sagJvXI4Ljnjy7jg5+0HvdEAK1KdE0srD3ocHt8W7xb8xrsR/U4Cc+nDqJ?=
 =?iso-8859-1?Q?sDIJkNtfcrdH5K/SfZf2aRGie+6kmijIOf//rWkfWg1cmG1i+At/oCGcXv?=
 =?iso-8859-1?Q?t4/Ougy3tRNMSFkdOtM4Jorm5d+eOO8/knBAvK7fKB8pecVc8a2vZ8DN4B?=
 =?iso-8859-1?Q?Lra/l2n6DMoUs7n/T4Kx5BF3w3tHVubiFt8iclw5BboCI4fItYO4LV9eHR?=
 =?iso-8859-1?Q?eM47NzLP/kqeZnOIy0dwaXmgwtDWKUeS/DMjSKsArQCyi+WBUVdLckjCoI?=
 =?iso-8859-1?Q?W+5Swtq4Gw=3D=3D?=
X-Exchange-RoutingPolicyChecked: spHqiCjqOPTVVt2F2haAOb0n3k6bjsbtt143ltmPHICSPoIWU5U6QXuRZdzxfk4LaSHxcnuaIM123uZUoe/IenFeWTuEs31/7pL95OZPxZETBV0DEWSImKIGzDJAj6sd2raxY1f5M3OakUcIhLXSAwF07vw8H2BDYba0ObspSvtONdEmCnVIWj3Bq14gMkXMzMorp1jP3HaoDnHm3s8bkUYrtNPjFoZBjaEK1v9Z6wmDxVPG9S/mm/XoBTfOONAkNV4IzhSfqWao4OJRqDmyVz8f9TlgrY7unZ7hWDeXXjDOU29VZwsPtlCZWL3eLsncnU3IAjwpMlIOtaq/OCkpUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e63b8c0-0f97-42d7-e0e3-08deee548d64
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 16:06:45.5088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIBwiwPA7TvvaNWXE+JcioUXwmM/ckxrMVippahVbt+rfQokLW4orGtj5xK/qcIjc2wY2rS6i90H1VkhFea15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7089
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

Hi Dave and Sima,

Here goes our last drm-xe-next towards 7.3.

Highlight here is the removal of the force_probe protection for
NVL-s, RAS additions, and a bunch of GuC related work.

Thanks,
Rodrigo.

drm-xe-next-2026-07-30:
- Wait on external BO kernel fences in exec IOCTL (Brost)
- General clean-up (Anas)
- Documentation fix (Rafael)
- Add a debugfs for pcode information (Karthik)
- Free madvise VMA array on L2 flush failure (Guangshuo)
- Page Table related fixes (Shuicheng, Zongyao)
- Improvements GuC error handling and GuC small fixes (Sk, Zhanjun, Arvind)
- Add new W/As	(Daniele, Harish)
- GuC paging engine support (Auld)
- Add and use more KLV helpers (Michal)
- Balance exec queue suspend/resume (Niranjana, Thomas)
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC (Himal)
- SRIOV: Disable display in admin only PF mode (Satya)
- Fix writable override for CRI NVM (Sasha)
- Fix VF CCS attach/detach race with in-flight BO moves (Brost)
- Introduce Xe Uncorrectable Error Handling (Riana)
- Fix WOPCM size for LNL+ (Daniele)
- Consolidate debugfs fault injection functions (Mallesh)
- Multi-queue related fixes and improvements (Niranjana, Jagmeet, Shuicheng)
- Add RAS GPU health indicator (Soham)
- PAT related improvements (Roper, Sanjay)
- NULL deref fix on migration on VF (Satya)
- i2c related fix (Raag)
- Fix SVM leak and clean up xe_vm_create (Shuicheng)
- Drop force_probe requirement for NVL-s (Gustavo)
- Optimise TT population for DONTNEED BOs (Auld)
- Add page size allocation mode control and coverage (Himal, Nareshkumar)
The following changes since commit e3cdab67efa8b1981620c792a845da91f75aaa63:

  Merge tag 'amd-drm-next-7.3-2026-07-09' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2026-07-10 11:43:22 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-07-30

for you to fetch changes up to 60693b580ab5f7f3158adcc2bab5ae816edd49ff:

  drm/xe/tests: add live KUnit coverage for BO page-size allocation modes (2026-07-30 08:49:34 +0530)

----------------------------------------------------------------
- Wait on external BO kernel fences in exec IOCTL (Brost)
- General clean-up (Anas)
- Documentation fix (Rafael)
- Add a debugfs for pcode information (Karthik)
- Free madvise VMA array on L2 flush failure (Guangshuo)
- Page Table related fixes (Shuicheng, Zongyao)
- Improvements GuC error handling and GuC small fixes (Sk, Zhanjun, Arvind)
- Add new W/As	(Daniele, Harish)
- GuC paging engine support (Auld)
- Add and use more KLV helpers (Michal)
- Balance exec queue suspend/resume (Niranjana, Thomas)
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC (Himal)
- SRIOV: Disable display in admin only PF mode (Satya)
- Fix writable override for CRI NVM (Sasha)
- Fix VF CCS attach/detach race with in-flight BO moves (Brost)
- Introduce Xe Uncorrectable Error Handling (Riana)
- Fix WOPCM size for LNL+ (Daniele)
- Consolidate debugfs fault injection functions (Mallesh)
- Multi-queue related fixes and improvements (Niranjana, Jagmeet, Shuicheng)
- Add RAS GPU health indicator (Soham)
- PAT related improvements (Roper, Sanjay)
- NULL deref fix on migration on VF (Satya)
- i2c related fix (Raag)
- Fix SVM leak and clean up xe_vm_create (Shuicheng)
- Drop force_probe requirement for NVL-s (Gustavo)
- Optimise TT population for DONTNEED BOs (Auld)
- Add page size allocation mode control and coverage (Himal, Nareshkumar)

----------------------------------------------------------------
Alexander Usyskin (1):
      drm/xe/nvm: fix writable override for CRI

Anas Khan (1):
      drm/xe: remove duplicate <kunit/test-bug.h> include

Arvind Yadav (2):
      drm/xe/guc: Keep scheduler timeline name alive
      drm/xe/guc: Hold device ref until queue teardown completes

Daniele Ceraolo Spurio (3):
      drm/xe: Add support for WA 22022079272
      drm/xe: Add support for WA 16029897822
      drm/xe/wopcm: fix WOPCM size for LNL+

Guangshuo Li (1):
      drm/xe: free madvise VMA array on L2 flush failure

Gustavo Sousa (1):
      drm/xe/nvls: Drop force_probe requirement

Harish Chegondi (1):
      drm/xe/eustall: Add WA 14027054324 support for graphics IP 35.11

Himal Prasad Ghimiray (2):
      drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC
      drm/xe/pt: check no-DMA huge-pte cases before DMA segment test

Jagmeet Randhawa (1):
      drm/xe/multi_queue: Reject PXP usage on multi-queue exec queues

Julia Filipchuk (1):
      drm/xe/guc: Define GuC firmware for NVL-S

Karthik Poosa (2):
      drm/xe/pcode: Add support to get pcode version from PMT
      drm/xe/debugfs: Add debugfs for pcode information

Mallesh Koujalagi (1):
      drm/xe: Consolidate debugfs fault injection functions

Matt Roper (1):
      drm/xe/xe3p_lpg: Program TR_PTA_MODE

Matthew Auld (11):
      drm/xe/guc: refactor ads to use guc_class
      drm/xe/guc: refactor to_guc_class() to accept hwe
      drm/xe/guc: add the plumbing for GUC_PAGING_CLASS
      drm/xe/hw_engine: don't open code is_usm_hwe()
      drm/xe: refactor the paging engine setup
      drm/xe/guc: handle guc logical instance for paging engine
      drm/xe/guc: handle submit mask with paging engine
      drm/xe/vf: wire up NUM_PAGING_ENGINE_INSTANCES
      drm/xe/hw_engine: document top-down paging requirement
      drm/xe/guc: toggle paging engine support for NVL-S+
      drm/xe/bo: optimise TT population for DONTNEED BOs

Matthew Brost (2):
      drm/xe: Wait on external BO kernel fences in exec IOCTL
      drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves

Michal Wajdeczko (13):
      drm/xe/guc: Allow to print single KLV
      drm/xe/guc: Prepare to print group KLVs
      drm/xe/guc: Add basic KLV encoding helpers
      drm/xe/guc: Add string KLV encoding helper
      drm/xe/guc: Add object KLV encoding helper
      drm/xe/guc: Add KLV parsing helper
      drm/xe/guc: Formalize Reserved KLVs
      drm/xe/tests: Add GuC KLV helpers basic tests
      drm/xe/tests: Add string encoding helper test
      drm/xe/tests: Add object encoding helper test
      drm/xe/tests: Add GuC KLV printer test
      drm/xe/tests: Add migration packet test
      drm/xe/pf: Handle migration descriptor using KLV helpers

Nareshkumar Gollakoti (6):
      drm/xe: add page size allocation control state to xe_device
      drm/xe/debugfs: add page-size allocation mode knob
      drm/xe: add XE_BO_FLAG_NEEDS_1G for minimum page-size sizing
      drm/xe: apply debug page-size allocation policy to user BOs
      drm/xe/pt: allow selecting the bind leaf PTE level
      drm/xe/tests: add live KUnit coverage for BO page-size allocation modes

Niranjana Vishwanathapura (6):
      drm/xe: only resume exec queues that were actually suspended
      drm/xe/guc: ban exec queue on suspend timeout
      drm/xe/guc: add uninterruptible suspend wait for cross-process cleanup
      drm/xe/hw_engine_group: propagate suspend failures during mode switch
      drm/xe/multi_queue: preempt primary on queue group suspend
      drm/xe/multi_queue: wait for secondary's own suspend in suspend_wait

Nitin Gote (1):
      drm/xe: Hold a dma-buf reference for imported BOs

Raag Jadav (1):
      drm/xe/i2c: Allow per domain unique id

Rafael Passos (1):
      drm/xe: Documentation: fix chars used for subsection

Riana Tauro (7):
      drm/xe/xe_sysctrl: Make sysctrl flood limit reusable
      drm/xe/xe_ras: Add support for uncorrectable core-compute errors
      drm/xe/xe_ras: Query errors from system controller on probe
      drm/xe/xe_pci_error: Process errors in mmio_enabled
      drm/xe/xe_survivability: Decouple survivability info from boot survivability
      drm/xe/xe_ras: Handle uncorrectable SoC Internal errors
      drm/xe/xe_ras: Add support to query device memory errors

Rodrigo Vivi (1):
      Merge drm/drm-next into drm-xe-next

Sanjay Yadav (1):
      drm/xe/migrate: Revamp PAT index selection for migrate PTEs

Satyanarayana K V P (2):
      drm/xe/pf: Disable display in admin only PF mode
      drm/xe/vf: Add drm_dev guards when detaching CCS read/write buffers

Shuicheng Lin (6):
      drm/xe/userptr: Stub notifier_lock helpers when DRM_GPUSVM=n
      drm/xe/configfs: Add enable_multi_queue attribute
      drm/xe: Use xe_tile_info() in alloc_primary_gt() and alloc_media_gt()
      drm/xe/vm: Fix SVM leak on resv obj alloc failure in xe_vm_create()
      drm/xe/vm: Remove redundant INIT_WORK() for rebind_work in xe_vm_create()
      drm/xe/vm: Use regular comment for GSC VM lockdep note in xe_vm_create()

Sk Anirban (2):
      drm/xe/guc: distinguish wedged from recoverable cancellation
      drm/xe/guc: fix activity stats error message format

Soham Purkait (1):
      drm/xe/xe_ras: Add RAS GPU health indicator

Thomas Hellström (1):
      drm/xe/guc: Add suspend refcount to exec queue ops

Zhanjun Dong (1):
      drm/xe/guc: Handle GuC local uncorrectable error notifications

Zongyao Bai (1):
      drm/xe/pt: Reset current_op in xe_pt_update_ops_init()

 .../ABI/testing/sysfs-driver-intel-xe-ras          |  30 ++
 Documentation/gpu/xe/xe_device.rst                 |   7 +
 drivers/gpu/drm/xe/Kconfig.debug                   |  16 +
 drivers/gpu/drm/xe/abi/guc_actions_abi.h           |   1 +
 drivers/gpu/drm/xe/abi/guc_capture_abi.h           |   3 +-
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |  39 +-
 drivers/gpu/drm/xe/abi/guc_scheduler_abi.h         |   3 +-
 drivers/gpu/drm/xe/abi/xe_driver_klvs_abi.h        |  27 ++
 drivers/gpu/drm/xe/regs/xe_pmt.h                   |   2 +
 drivers/gpu/drm/xe/regs/xe_regs.h                  |   2 +
 drivers/gpu/drm/xe/tests/xe_bo.c                   | 242 ++++++++++++
 .../gpu/drm/xe/tests/xe_guc_klv_helpers_kunit.c    | 429 ++++++++++++++++++++
 drivers/gpu/drm/xe/tests/xe_live_test_mod.c        |   6 +
 drivers/gpu/drm/xe/tests/xe_pci.c                  |   1 -
 drivers/gpu/drm/xe/tests/xe_sriov_packet_kunit.c   |  89 +++++
 drivers/gpu/drm/xe/xe_bo.c                         | 230 ++++++++++-
 drivers/gpu/drm/xe/xe_bo.h                         |   4 +-
 drivers/gpu/drm/xe/xe_bo_types.h                   |   2 +
 drivers/gpu/drm/xe/xe_configfs.c                   |  65 +++
 drivers/gpu/drm/xe/xe_configfs.h                   |   2 +
 drivers/gpu/drm/xe/xe_debugfs.c                    | 165 +++++++-
 drivers/gpu/drm/xe/xe_debugfs.h                    |   6 +
 drivers/gpu/drm/xe/xe_device.c                     |  29 +-
 drivers/gpu/drm/xe/xe_device.h                     |  48 +++
 drivers/gpu/drm/xe/xe_device_types.h               |  37 +-
 drivers/gpu/drm/xe/xe_dma_buf.c                    |   2 +-
 drivers/gpu/drm/xe/xe_eu_stall.c                   |  37 +-
 drivers/gpu/drm/xe/xe_exec.c                       |  22 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  17 +-
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |  27 ++
 drivers/gpu/drm/xe/xe_execlist.c                   |   1 +
 drivers/gpu/drm/xe/xe_gt.c                         |   5 +-
 drivers/gpu/drm/xe/xe_gt.h                         |  14 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c        |   5 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_policy.c         |   5 +-
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c                |  47 +++
 drivers/gpu/drm/xe/xe_gt_sriov_vf.h                |   1 +
 drivers/gpu/drm/xe/xe_gt_sriov_vf_types.h          |   4 +
 drivers/gpu/drm/xe/xe_gt_types.h                   |  17 +-
 drivers/gpu/drm/xe/xe_guc.c                        |  70 ++++
 drivers/gpu/drm/xe/xe_guc.h                        |  23 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                    | 134 +++++--
 drivers/gpu/drm/xe/xe_guc_capture.c                |  21 +-
 drivers/gpu/drm/xe/xe_guc_capture.h                |   6 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  43 +-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c        |  12 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |  12 +
 drivers/gpu/drm/xe/xe_guc_fwif.h                   |   1 +
 drivers/gpu/drm/xe/xe_guc_klv_helpers.c            | 260 +++++++++++-
 drivers/gpu/drm/xe/xe_guc_klv_helpers.h            |  10 +
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 434 ++++++++++++++++++---
 drivers/gpu/drm/xe/xe_guc_submit.h                 |   1 +
 drivers/gpu/drm/xe/xe_guc_types.h                  |   2 -
 drivers/gpu/drm/xe/xe_hw_engine.c                  |  82 +++-
 drivers/gpu/drm/xe/xe_hw_engine_group.c            |  85 +++-
 drivers/gpu/drm/xe/xe_hw_engine_types.h            |   7 +-
 drivers/gpu/drm/xe/xe_hw_error.c                   |  11 +-
 drivers/gpu/drm/xe/xe_i2c.c                        |   5 +-
 drivers/gpu/drm/xe/xe_migrate.c                    |  86 ++--
 drivers/gpu/drm/xe/xe_migrate.h                    |   4 +-
 drivers/gpu/drm/xe/xe_module.c                     |  49 +++
 drivers/gpu/drm/xe/xe_module.h                     |   5 +
 drivers/gpu/drm/xe/xe_nvm.c                        |   9 +-
 drivers/gpu/drm/xe/xe_pat.c                        |  44 +++
 drivers/gpu/drm/xe/xe_pci.c                        |  35 +-
 drivers/gpu/drm/xe/xe_pci_error.c                  |  21 +-
 drivers/gpu/drm/xe/xe_pci_types.h                  |   2 +
 drivers/gpu/drm/xe/xe_pcode.c                      |  32 ++
 drivers/gpu/drm/xe/xe_pcode.h                      |   7 +
 drivers/gpu/drm/xe/xe_preempt_fence.c              |   7 +
 drivers/gpu/drm/xe/xe_pt.c                         |  97 ++++-
 drivers/gpu/drm/xe/xe_ras.c                        | 353 ++++++++++++++++-
 drivers/gpu/drm/xe/xe_ras.h                        |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h                  | 165 ++++++++
 drivers/gpu/drm/xe/xe_sriov_packet.c               | 115 +++---
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c               |  32 +-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.h               |   3 +-
 drivers/gpu/drm/xe/xe_survivability_mode.c         |  13 +-
 drivers/gpu/drm/xe/xe_sysctrl_event.c              |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h        |   3 -
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |   9 +
 drivers/gpu/drm/xe/xe_trace.h                      |   5 +
 drivers/gpu/drm/xe/xe_uc_fw.c                      |   1 +
 drivers/gpu/drm/xe/xe_vm.c                         |  57 ++-
 drivers/gpu/drm/xe/xe_vm_madvise.c                 |   2 +-
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |   6 +
 drivers/gpu/drm/xe/xe_wopcm.c                      |  15 +-
 include/uapi/drm/xe_drm.h                          |   6 +-
 88 files changed, 3714 insertions(+), 381 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-ras
 create mode 100644 drivers/gpu/drm/xe/abi/xe_driver_klvs_abi.h
 create mode 100644 drivers/gpu/drm/xe/tests/xe_guc_klv_helpers_kunit.c
 create mode 100644 drivers/gpu/drm/xe/tests/xe_sriov_packet_kunit.c
