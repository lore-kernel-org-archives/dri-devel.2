Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B55C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE63010F06A;
	Wed,  2 Sep 2026 08:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UALwLQ1c";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB7110F06A;
 Wed,  2 Sep 2026 08:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337552; x=1819873552;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=5j1iUB7evyz9zP4nzdQBh8wre1KU4TKWIKcfvwKy7mQ=;
 b=UALwLQ1cGuZkzSsiILYOjcao9DJMjoOGahOX3s92emnMh6NwozC9Okwl
 OEAHB588pFIkG8gL8clQoT3tkcgCG3NtvWcasqchUrIrfH5lL7tzJip9A
 SGNq3n1BNKfNWPZG/LC54yRQdSvJwI/Hyd4gmxBk0rpg8L3tvOheqTrtp
 +sbe/1FvUXW2hl5JmsHNU+FzI/YSp3/IKAa4bKsSYKPtImUTigcBlwdL0
 LvJ/z1nSJxiB3XqL0sr289J6BmL/9ZWW9nKsHR+mX6E49AEaO9NagXKHV
 l+NVoj5FZ0aa6o4pkheA7wyugHZ99+NwR+9BmZ3nDhU1trAZFyr/S1FYA w==;
X-CSE-ConnectionGUID: WR2qRFX1R12K/OXxkwAUoA==
X-CSE-MsgGUID: 3Y69chU5RoiZ8eSeuPyMzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106156695"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="106156695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:51 -0700
X-CSE-ConnectionGUID: +bNSXEXeRE+ZqSBAWPIN1g==
X-CSE-MsgGUID: Sh5Q5xcyS7SiMLxZGCgEOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269364454"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:25:50 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+5HepZ4jFqPGleOo9HrMXKgUMzHf7FINNyJby8HEcjZ/dWihIuHB8tSI/gzGfcWXVkjO2FP1qrT1PiDJNzxr9QvFXtpwH2GyGcTrwwqU+kG3iBetT7XuIfcO2Do+hjeWHaJcZ2OpIeXh8PA0wEohy1qIzI2UA4wUaR2ymkHPrR6MTN6eYU/Y8V0gTRylRvv2MRdwo6HcQLVyFUFMsYh+bc/kIWWkQep1EvDi6I6MgHWfV/NoGDBCwE2OvnfbKQDyO3Y0b8tu/dqXF5KtI+fZEbHuy0VU45w3pko8urDFLnmJRMAMelY9B1ItyY80uyI+gydJdAb8rvm5nRXt8ZNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7M+J/uMyvAzSzMPh21pBKSWJJzD1BL1r4XBlDCg4Ms=;
 b=l8EjlJQ20nnDTQragqvJW2wk41Q9UiY8T/ZBPJnLR13mdRukb5UuyP+l31cAqi0Q8efw98W/v2W062PvEWC4ODEM0D3rvKLnATXvv9APX+OM4jTtvYF76q/GqeEehEOx1yzcYUxN985e4GU7QUURDd0O7zhRoszG/ZdjI642r3glkIoxPyA3hVTl8EQM4DZKbduvC9NdP/mjja5ojhRS4eT0e78i5i36LG+vF5mUOeQHoNoNzkldyEaWHWQPmLMsViYyMqhJBZv0t+xxaB2FkYUo9XfKjTRIJApFN/EY/l2SebS6GMkoKRU147j2D44DMMwEpdxZZzKUQtFArr9/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:25:47 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:25:47 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 0/7] drivers: Improve memory management for large object
 allocations when i915/shmem is used with iommu
Date: Wed, 2 Sep 2026 08:25:18 +0000
Message-ID: <20260902082525.1149367-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0200.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::25) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SABPR11MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fdf3d0-a26d-4886-e0d4-08df08cbca2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: t5/wD90M6sPjOuw/UxAqWUTY64q6rKg/iOcFr8F9JnP1cj+6gvSe91rjtJqRIHEFlWKgVLhW6rQ9ajg+7sWIjjMHLZjBBKMX7ymFsO4U+sZsvau3a4Wfz0cBpiGm99Fsv4x5Kz3i7/UkPKmVtvq/jM4d9DflqruodOMl8p4A5xKbExq/M2mlpIOB8egZyUqnlZzaXYBuzVooQYfIl8yTwgeL2Nat3QMZo/dMTIpjF8aXY9CxVWNEJFUyE+DzN4M3J47frb+LXFbxolPkhGU2ICU8OF1LSHygsEQVvL0/H0GYqrBVq86nKU2lZcdn/7kH5OGXH3VKBoOmt/tls2Gp3zezVIBopAlz1aX2eAAQbAht343268C8P+5P7+wWAL/d5gHfdHUjjJ0yVSlACR3H+3p6GHojRMjEEjzX3jCcJ2tjGD2pUthZzwNvv8/eai+5nZWwqcVc0Jip8lzDSEd6WP+1dC6Ul8ejgy2iIhiMm7urBcr3uSZBeA3PyFkf8gHa+nILSbGDh0zSaEyVG2UWTqRD907ZubaRP6QdZHFX9GkM0dbsngDdccDgRVdSBVmjAFuezYhvtWpx5msZgE0XN6ipx0DNMjqUuEiIa79DaW9L6MyV6fjvXPlZY9Jsr+2h/uJ8L2WgXag+1p4cD6sU2nAk5l1ptNqIPQnFMVfcDqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+RA9dBkxeotyBfiXKKILXsXYmrIM9m81kjsUjoaLqLuGY2NU6/LWFGUrafaD?=
 =?us-ascii?Q?SmSc6Tph7sJWiLapwumSJ7Rm4Ugo+VU1UE+SlNwbRcuqJOjpXz19yC0vn4Ri?=
 =?us-ascii?Q?C1wSWOhWVXHJG2NPF0sXNQlAxihR2ezi/BSDVRyQIc0SABA5e6IosRucXFsP?=
 =?us-ascii?Q?P8ryToWy8RP7aaJGbbmWoSQf00kpH69EuGP0L4MKcG92z+cy9lGrbD/d3M82?=
 =?us-ascii?Q?RxvSEEnjV5izMdoeHAWbf4jOlHL01Ji0ddMkovDbW54d/THzN6N0TsIx8gBL?=
 =?us-ascii?Q?4QtLAdf08bI74ImqwJPlbOzFjSAXgiBV+j0djDQ0EoaOJe+EW1jYZ9NBY5QR?=
 =?us-ascii?Q?aiS5IHe4bxXk/MJG60YiqQfgLz7b1Z2BHxRJocAlwDTgUBnn3dssb8+uKArY?=
 =?us-ascii?Q?1WX9mepSEXdSzDp3kqBD3OCcHtiFXMJHgCWTWtsS0qncrRTouKw9/R+SjxYg?=
 =?us-ascii?Q?wk/w/O+yCWdaeOD6M/VkTMO+f2YK4/R67bAiFk2F0dXcQUD5Yj04bBRfw0o4?=
 =?us-ascii?Q?J6RYXk7ozYKGC57+UXx5NmCXDnrPrd/NWgvZ6B2eCOYRJPAl6APpiITKx/mb?=
 =?us-ascii?Q?te6++hRAajbmRgpN8/xBC11YAO+qmGhY3/7gxHdd4tKYRSMrjSDj7HnVMBcW?=
 =?us-ascii?Q?CyXLDhm6xrMFdyT0amWxMfDBrmXY/R/gXCFB+Rd5OPnrIu070V3+AmooToPH?=
 =?us-ascii?Q?eNjnMInVNPB8NO9qqOwMrkhaLpp15zlU0gh3auIcM/KI0OMOHmJOUhHz8OTI?=
 =?us-ascii?Q?EDzSMeKwUVOtdxgkaX2feexjRaBqI75eby4ORbxze1q+KvMtIDBnyzYiUdrK?=
 =?us-ascii?Q?cp0i9IYZ6frV9QijW2Z2Bod9VEDCGM/nE43YrxesIUWsjQ5le1hGqOkLb6oS?=
 =?us-ascii?Q?4GALGaCr3tymJvEMWecBjG1ys6LWcxKFzEXoiEKQYIFBL/+qOkDQ2/OtCaIA?=
 =?us-ascii?Q?g+n1qucnDo8nFzf2371HARtzbmazSA6iB3DtO1wDgePhi9sb1GVwRjeAqNcS?=
 =?us-ascii?Q?CTZYerU2BF/b2iAUfQNDXAptx5eW68aAke0g8HWUVjFA1ExX4QhyyE08UZv3?=
 =?us-ascii?Q?7OIuZRHvatp2BnW+mckaqvRQ9e2duYFoHnDQg2tSB4oP3uuhRbKneUQ4JIOa?=
 =?us-ascii?Q?aznPvNcFFUpoTg10RbJXz926x2GysqYlvpRh4uo2NOBkCjSU1H8jhs+shtPo?=
 =?us-ascii?Q?UwqBZG8pFjfzkqxEP4HEbx4ipPX/iwzmoToeP49mGcwI8PW9XtQO461kKfn3?=
 =?us-ascii?Q?3DueKCcKgU+2h6/LS1y1OMtNJaCnTbvxTv+rZuTl4iL7tsmdA2OIIPBsFa2U?=
 =?us-ascii?Q?SiahFvLPldoBAfSDnvLmujhT/RD42tPPjRbAXryECT8jSns3wltb2wWdTm6l?=
 =?us-ascii?Q?j+LBd0l4HFX2CXIFqicmRUpXRONbvHBpNkfcHq0L+JmQ7XwciMXc0BgaKcQ5?=
 =?us-ascii?Q?ZbmQVfpjNvk9qhJpO0VT4W2wDsF6pffvU2PkIhwElxkZKitPPInoSXbEKg1C?=
 =?us-ascii?Q?UHW1KNqmCIg3jFZCVJ2WZtRQcWdxFcPwaL7f6yvEFkIj+5QGIDjQMYpQwi0E?=
 =?us-ascii?Q?ZHfyHizyVNQVLKCOZBqVqE/XnJEbAjQGjS/kN8WSaQnb7ISDlt6Jkgj8mhqk?=
 =?us-ascii?Q?/VbkL9SkuiJ+da65W5TS8Xug37M4FHLVepHl6GZEIgdTKPXYnw/UlnKh1DP0?=
 =?us-ascii?Q?bdwyfOAuZwY22v+NbYCgYtwl9FlLXRtqNHggivMJw3NhcQOlMZj0arUM6AlV?=
 =?us-ascii?Q?v+Vnm5aWlYqlElqrAdntzd0jBrX5nYk=3D?=
X-Exchange-RoutingPolicyChecked: RVOibnZuELEe9xtqaqT7wN2zKD+UVtTBhnvd7pf6o3xFIQK7bxm+aCEg/ZkeIDyrZzhYsl27+2rJ/4QRHNgN72Fh7MmIwE4G3BaOdE7WarHO9dSO98O5vxDuW1D+m6PjlgE4m+khLqQsuK1AA1GbPHKXOY4Kd3GFAZfHaQ+tkQkXbUXo0wEQGxJ8Sc6+L96I6uK9uoGoOBqypXw0YcXHA1j7bmBNYeAEHm3v80b3C7qXV3LnacZK8VnWGs5zQAYUTWx0mJE7+6gWvW+w5+L+cKRVqgzS/4oyYstSzX37SpiKKAU3tZ0CjtaQMq3xEgL3sqKlv6pnFxdaPRnrQiCX+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fdf3d0-a26d-4886-e0d4-08df08cbca2d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:25:47.6137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcTYiSjgsIVPkzfCr0geq1eWaS6e5kyeZi5Ap6MLTLksTfjSf84V17+489hymxi3okFqfWEtENvNAfW/kSqr2/vtdi6d/No0on2PjtFLTK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9937
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

It was observed that allocating large objects via i915 driver
(igt-gpu-tools/tests/gem_exec_big/single) the folios and their
pages were not handled properly leading to buffer corruptions
during relocations.
Furthermore, using iommu driver in this context would leave
residual mappings in memory that could not be released, hogging
available RAM even after the process ended.

v6:
 * split max_segment validation into its own patch;
 * added Fixes: tags and Cc: stable to the fixup patches;
 * repaired bits pointed out by checkpatch;
 * ran local regression checks and automated review process via
   Claude Opus and added Assisted-by: tags.

Krzysztof Karas (7):
  drm/i915/shmem: Validate max_segment
  drm/i915/gem: Count mapped pages in a folio
  drm/i915/gem: Free sg table on failure to acquire second folio
  iommu/dma: Catch scatterlist length overflows
  drm/i915/gem: Pull out size validation into a separate function
  drm/i915/gem: Read and shrink memory in a separate function
  drm/i915/gem: Remove iterator and use while loop

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 172 ++++++++++++++--------
 drivers/iommu/dma-iommu.c                 |  17 ++-
 2 files changed, 124 insertions(+), 65 deletions(-)

-- 
2.34.1

