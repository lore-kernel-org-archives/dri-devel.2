Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE6CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DE210E239;
	Thu,  1 Oct 2026 14:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eOh/ZM0l";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D5A10E6BC;
 Thu,  1 Oct 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790863940; x=1822399940;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=w/7Kbm2J8DsBmWpUL2truYKfDg9GxeUiLJopRRc2ZW8=;
 b=eOh/ZM0lgTc34e3iSdX9bOo8Wa3rO8N0QQgAQFUnRnqxSMcyNyH5hzUM
 XaNP5vBctYdOw7xvf/4XN/B8ANuOYbD5fd5MgfIcjTX27/3+/Grkj9k7h
 YuMJRsJ16h9yWY6z4DodBirUHM3BB0MS4RC8lVAPgL669fACt72sYSxgD
 Qy7ptC8RKNtvK7lQaEJa/h53EJuBvIf4HNWw052yDdEQG4dk1oyPcc4/Y
 +DMWnu0200W3t4NKxXMfuW70CttllojZ/rmc6OQ7a8rrXtg8mZkCqswep
 4q8ID99g0W7JgSNu9YZjf+7zj51zyFRDJkLIgouhoy4PoAhKRlm5XJoGx A==;
X-CSE-ConnectionGUID: 28+p/dKmRh6JGRoN2ZSiRQ==
X-CSE-MsgGUID: a7/9FQuyQcuOV8HvIIW3Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102294247"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="102294247"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:12:19 -0700
X-CSE-ConnectionGUID: FiBktc2MSXC7suwOMdg+CA==
X-CSE-MsgGUID: aGH89RVRR1yTPrRDjQ/lxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="272426495"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:12:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 07:12:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 07:12:18 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 07:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcSgiCi1KF6sIpT5El9g8MRpqCiVDaMR9VtuvwCrMSR5YPnKrYOl69H3k5Mp8WioTpknBvpw2XrzWDFQr/Q3I4cRdHpM+ylwGUF96UiaZK6WIcuGbooVAOgoDrwhTyUAQF2oYiKO1jS+yRvr0QSEfaAERbLtVjxXemYsjDK6rJ6xrJKxMlQVwjI79G9IUozEHQJYKdN9TyD927p0ObA4c2ezyfZiOU5JcoEVH2IvatSiqqViCtPqYFfjd8h1lVJVboiguwtW++hEA6P5mXQW/cwu9nYNWhpkmBOTc8bX7X6eQtVeFyh4LxHGIzhUHJfC5nPHi1VocdIKF1iSqjM3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T15z78v/8iTZ7DI5MzRjGDKIKZcOxl5YmNxq9JqtiE=;
 b=XtBatevS0JAqtokumQTUmLwDmtDgj1rsfZH2z62yovv9/smM5Ck2zvORPywTxs2jCZgr8YrlT/fg2JkmE8vQf0/1zduxgYVdioVosOXrCiF2kS7hVGoYCrFvNaIl8GS7u4QU25jX0RSvpUJvICIMzSyZ3tfnk+cvhbcdhzDQObh4qiHUzaPGIojjXwBlX7/tCzKJE0mZZ50m4mQ1Ir3oHO8BoQhbdGNWPi2u2g1yVQo1xcxzHFxdkLohqOsFuQoF9QlHUiBMyvJ7DE29XM/LFM5hSFGzqOAb/hz3yZZ7coqhZHFA7rKgNfNR/3Fssyjr5aFqIOfPP+9MLDF/TRMrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by PH3PPF8B755DBFD.namprd11.prod.outlook.com (2603:10b6:518:1::d36)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:12:09 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:12:08 +0000
Date: Thu, 1 Oct 2026 10:11:51 -0400
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
Subject: [PULL] drm-xe-fixes
Message-ID: <ar5qJ-OV2gNI1TwN@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|PH3PPF8B755DBFD:EE_
X-MS-Office365-Filtering-Correlation-Id: d355f0af-2831-49ea-3bf9-08df1fc5fa7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: q5h14b67uxs9HG6zP5XdhrCblDk60XUmF9w9Rpe/ZiYCm+37Sh2ZAGa3DFtyWLMS0PUp/qg73ffBhM7kC4A0U9M01I+FVbreiyvBcot22Jdc5Gg19IXZ4Oe2LuIbLdB916eqp/a+TIXZviBz5VhTbwifVTJQ6Lm3T6yCThwqX9wIa5pjeCxPtKuB7G4pH83MuQbMfa4aoEGfDAgO8Mj50NS66hP/Kz50WQHL95uL9LHlLzZM9PR9brY9z76hYaqhoQhh9+JbqXTfsaHR0foBYWJ2qDxs6y6dBLXMvruvf++w5Z9KOscIOQsEGLRZxeAXl5yIWdbtg6dzmbG7SL0P7OIhwhZiG2ftcgjvj3jNTUxO0+FgCqwSCJ4R+Vs3ig7qH55RgRl9c439ZTv7mnUtxnr5OX+2cp5bEUyLpd0DtviluOoor9zt+Vs5UO/tzU+Vt1K1QPVyVRQoQ+iwWkcdB+GgRLtzDFaBahr3kaXuSwuTEOFtv3GYa1AJuAc8spJATSdTgBxw8QhT2CZyDCfvtGhuoFoQ6DRQsSU6s9pQrHWNl74Hq0+crLZ3Em5FAkrnUEvMd5Iv6L+aM6DHfdrZm/SP51ITtkxUnLz+Ms+egKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3eGgApkLRC7rSOhZThO7niuWL39D9hzzeLzVFafk2f61mqz7rMRJxcCSNxxd?=
 =?us-ascii?Q?Upc9peABlka8aVkwQoNCCGI8m1x+YRetGTB095TgdFN5TpiQIhnvw/GDF12g?=
 =?us-ascii?Q?NOP7Munw/3kBihBf0rsAJ/mn0O7iNj9qkonAkUc/MxMcejgmoVUrEo1qH+ax?=
 =?us-ascii?Q?6eLFfi8eDHtJ8gys902t61euLZVf9C6DsBG7+DHApweC/Xd+kQnJ79nrJ+RY?=
 =?us-ascii?Q?D3PoGFsr04yjtf6Gj5kuLis3m/shZ9Hfo/zMgygGD/Zeo18g9TnuL5v0d2aA?=
 =?us-ascii?Q?b/Evyi7Jssa4EubO4WuYVHBEUXUX6RNj0/ag3jaBmDJ4YZw4oQV0e4xvzq6I?=
 =?us-ascii?Q?m52XZEN6B6W2XXB/vIcKf23GhXG0GxNvL7uWTF7fZ+oo6NbRkYLbZotRReyc?=
 =?us-ascii?Q?pyjZuptNV4gIxlwkPVdA7WlIlypTY0V2qPi9wFWOMa5WWnq4SrcF1hl5d+1m?=
 =?us-ascii?Q?n0MmvyMt/GimJbVeFEkeW5JVs5L3lPESpWYrJJ/Dvkd4fp/ZPz3PCNUI3i23?=
 =?us-ascii?Q?UCPjjyMKS9YPHDRU1fNbg4mIbn9Cp8+lzbMWdqmta0+7kAJLQRVAxQxM7Sp5?=
 =?us-ascii?Q?vW9dvfU6NJPml5ZXoEnasXBfQ/+d5jpyQpjozmJu/AUJX2PYQIaY4T+mpAx/?=
 =?us-ascii?Q?sqycTXtsMld/CaGlcYghThXkwbBHzl72mWQbYeizJf7FdYhFhjne0iWcWiPi?=
 =?us-ascii?Q?715E/Kl+Pg6KMnQUmi04e1lhSXzTtIe/7ZOXmQ6nX+e46MS2YUP3AeQJYLMi?=
 =?us-ascii?Q?ryer4mUUv7jSgZMbIR49q9HzRgrJzg03bG3YnL6TMMZ++pymeorTAa+IEsVk?=
 =?us-ascii?Q?aWUOp40wjXebeigGk96UJz0l+cvNqXpG7esZlB3rBBZNZPWmKd4ynndB6m2R?=
 =?us-ascii?Q?feB63q1Fykyh4Ypf0kpVUAZW7XwmZKm2z5ijCjHBtAl6pB9va0x4UIDgM0et?=
 =?us-ascii?Q?BANjCtHM7unRKq7CZcJ3ATKJDAilckCiPCnLrDnFQ74fpbd56AzJeorD+4Hw?=
 =?us-ascii?Q?aPLeP9rHnm0kLcPZSgFKVi0t+AAvjQcaPMKs9wu7MhQjm86TylBd5nfgC5Xf?=
 =?us-ascii?Q?+Yv2VpJ9tCJaRVqQH/HSxAZDbA88P2IoL+f3G+JFrCo5A/wYGeFFInrQOjDq?=
 =?us-ascii?Q?dTxD9vcXoeQtqnvoRXeItubmumQx05Nyla53fOCdcx/dDKDONiyyvGmMUfA3?=
 =?us-ascii?Q?Gxc6ZHhfxz5Xs+z1zvhhxqCD2OF/nHHZ/ZKB4dB3DQdMCp/jW1/I7qPqsvRl?=
 =?us-ascii?Q?svjHI+yDDf5Zb/rMU+OiGy4KeHHI0rrmsYBrfhr09tOMra6R3j3V0eel4QBM?=
 =?us-ascii?Q?9JRGhPeyd877u9wPrrtN0pkJUUABYfDcikOBsqgjn7jMjmYaL/gcKVUu1znE?=
 =?us-ascii?Q?UbdQgWnMD/a+FIDpKClAq/zPjf62tIGqVtFOreEFBdiMDEQJs/aya8Qfxds/?=
 =?us-ascii?Q?GeicSSBdbyIFa6MPgCK5mTTu7+CS++NooKqy9MldqZSKUvSkPI0rSAqpLP93?=
 =?us-ascii?Q?SmAmdoyVIwQq1UHT2paBX7mAZryI2fu/0U5TthCmFc/adKe2HXPo8+q5WlY8?=
 =?us-ascii?Q?mMHFywzyauxFDmtTZqFM75cpveZIZHkMoh1CjAo0hVKYU9qKx/3bPTaU+G81?=
 =?us-ascii?Q?kssZFL6B55jt/6eaoNmPdkWp7RzPz5vW3zIanBX1SW8EOMTTr4S0N9RLnyX+?=
 =?us-ascii?Q?B5se4FFA/cZgTSUu8Dhx2f/QEMxKdRESNbYaNwO2GyPw8+sknCXovswRZkrr?=
 =?us-ascii?Q?5Zh0lVf3hwTss/QlzCtmxVh9QiOhEd4=3D?=
X-Exchange-RoutingPolicyChecked: mIvuOywo4112o9e01WcLKJZgLfxtQKsNtMgCs5ywI3MFEkyKsbvjn0DAkYMJvXuToabevTpJoUel6wk5swXgxKw7Ko8JYK73L4UdChawO1hTDZKmFBf37YVl0pRZA9z6eYMubYB/VCU0YTLr3cD4ivAcJsvMvl8UL09YJIxavIGHEbDoCb+nrOSwmRHDQ5rd/FeJ6rM40Bf0WCjCz/lpC8HMnCJK4SFS5y+hIwO1xVPE1CrkgPPx3W75VAPHTCTID6VW7B2UXPtCQRkJWtwpJ0RaP78XIL5Ow3UT1QT39NHrGeTZM0WjFz42DBMS6E7g078Y6IDDqxfRyWowNFMNdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d355f0af-2831-49ea-3bf9-08df1fc5fa7e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:12:08.8454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rpnhzlUvvsEpEhPF06mxYuq2Hoy6ezE+br90oK4UdFLy1gEGJagF5lUNf2oivng7y9jP4rIzqEfW3i4SbA/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8B755DBFD
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

Here goes our xe-fixes PR for this round.

Thanks,
Rodrigo.

drm-xe-fixes-2026-10-01:
Only 1 fix to Keep VF LMEM BAR size low if no VFs enabled from
Marcin and a preparation patch for that.
The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-10-01

for you to fetch changes up to 72207463f7a4a6818a88f4ef57802b42da534301:

  drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled (2026-09-28 10:19:35 -0400)

----------------------------------------------------------------
Only 1 fix to Keep VF LMEM BAR size low if no VFs enabled from
Marcin and a preparation patch for that.

----------------------------------------------------------------
Marcin Bernatowicz (1):
      drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled

Michal Wajdeczko (1):
      drm/xe/pf: Refactor VF LMEM BAR resize helper function

 drivers/gpu/drm/xe/xe_pci_sriov.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)
