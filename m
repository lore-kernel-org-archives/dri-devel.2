Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F384FC61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A4410F068;
	Wed,  2 Sep 2026 08:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="afz83LWW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 191FC10F051;
 Wed,  2 Sep 2026 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337555; x=1819873555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=s7mS3gPcnZyXAWi25Hv/Xt6OfiF0LXzRUPXvH7yWcnQ=;
 b=afz83LWWF+/z2C70hz91y+4tbDNYVHRgkdX0Sc0GyQ5wgfrpZmgdgazL
 S1U4O/antO5S+NPoUNwT3R0OgGvWKk3p/pWYi9GcdO006Sav2XvFHiHf6
 K6WqupS3qEDYiaNqAc//BiQjU9I+Y/aTmwes69CNccx2p6kqgOq5ezy0t
 VNY8jCw2BqNotdmf4RKd/2dOV3xEB5tLqZSBDWnLq+1LfNC7iqkX+II93
 yyhzr2tG7/FVpGBacQYCXpGTxx237yAtNlcxlOi+huXGm08Yk/eIjsW/n
 k/IjVyD31Vcaic/Oox09RXFB3hLojESC7VhQK2gWXIYqT56BqMyRFUVeo w==;
X-CSE-ConnectionGUID: qAil+/JBTrmgCSQsWJWaYQ==
X-CSE-MsgGUID: ZdAmZH9sQx+y6460+SdfQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106156711"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="106156711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:55 -0700
X-CSE-ConnectionGUID: x8ylikaDQ1KA3eIRycRwlA==
X-CSE-MsgGUID: /t5uehcARAuX4SGe725OyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269364460"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:25:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bags8jb4FlNZcqToqJ869gAgAvgDk+8qnJoMM/U/V1uWZiEwm4CmzfxTie0hdOCLa71puNP+mJc7cbWpiYlskMvFhambTKQbfJ6WIGumLdmFa4rjh6jGVjvNW2wfXKy0BhLk6UkBpoXlNFkO63wjemu4iEDjwgSVjVJY221oaT6DxkFC5NrZDRKv6omp5PL9gI32Szl8Ee1xLuGfX1o5RttpK4LSQ1agOwlRzESz3JRKD2L4D7eWsvuqiH3TCOy5RgCanHn4LJP8y+og5eaGnU9BZBsEKcLO8Ba05Szoe93/iwKB7P2pGRiwYl4W3mtXZzdhe/BWqYMRorv9kxX7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FniGx64jP3U3mYYdDVsgcl/ewKJREPr7WSD8l6okCaA=;
 b=fmuHYsNhpNOsB7k5mazWkfVPv8vOqTKds4zPvLtJwGY/d75vzCgHUSmn7k8ZOe/jresd/RCDa1w4sjyNyEYHSrc54FRvf+q0BZLVmsy+kY8sxsmJbMtCl3OZEOi0NDrH2wAkVXV6E+qhk9CPc8Jh7KvFthey53j/T0f/IrEcAcTMhwI/xkzl/nL95Ndvia4SXS2BWRLHObrP6g0LgiwZWnwbc4xXvnTyiagQxdVVCaC3x0ra1DaHyKXXzDmvxMQbfugR8rDdFVoIH1MUH7Rfud/VRtPdC2hCD6/wzNEtJPmTdXWjKVi8FErXPsIdG8rE7mt7y/8dG4V1LWGfs7cAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:25:53 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:25:52 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 2/7] drm/i915/gem: Count mapped pages in a folio
Date: Wed, 2 Sep 2026 08:25:20 +0000
Message-ID: <20260902082525.1149367-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902082525.1149367-1-krzysztof.karas@intel.com>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0200.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::25) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SABPR11MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a44ae3-e7ca-41e3-0dbf-08df08cbcd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OjtuusGlOu4dz3Ec7pNX0cTP+NBpWxItZqnlmAsYPLRDrMdLW+Yu9C+ztRU0Jb+wrPvc6Genim3sSWehGJVcmVx8ljtvKN96/LzBuB+eB7Wtfs4haZ3aOtKXKipyRQ/CC5Fa5atasaVdI3TRISR5LjsAnBEt6A9ddkw/0q89muqZI/e0KIAJ7EdQI49tg0nRoyCdQzPWAAf597Sx0n3AiGeXWkx+vpn9QLRbZgub3WTHK+oI4iCNKhzKzgLUpJ4e+LVQi2MwpQQ6XD2j2Z9dBYsd57kLPGBP5Gx5izrQigb0rWloOjUITP53AZa2ZP8OkGZZCuKnmEjwAQhJe7c4hy4GmdszU4iR48OFSTr7Bqrl2yiV/aTdhZdIl0X1XISW1vgLme6Jje2fPGCKyndfrk5Q9FnxK9IKM7kplz1BdeNlMCdFd3BT4vtbqJPNBX6HpmYKYFgBh6gOJAWwrWRNHHOuOEknilW6ImEiSgX9aSc7F3YzLzYG4BpgtYpLDRnNyNpF03nzdty7KmI3rR0L1cbYFcHz5BgVtq6Yym8ZesuLmUJsbvUu0azOlOGV2798w5uv9bA5YTLGaUWECW5KhrSrvg3B0PLtjdxp+qM8wcmwqO2GY6YmdHsJSlvDGqK2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Vaqd0RU7XKrWeHSNk8YglaSvkpoLF/yYWHgo+U6ZpzbmXhNWuIS3KC3zNfC?=
 =?us-ascii?Q?ub8oak6Nilv94jkUdG/NWt3TFkQT7XTSFY1z0x752wUCkNTNlfkeA1G8OHpE?=
 =?us-ascii?Q?yp8W1/mPfTCWZmrn9ua8g23ho+RdGDbrRbpi/uaXiDjVuQskWGo9tbO2GO+L?=
 =?us-ascii?Q?7+Y6wkPeQNUZHNeW9OkCgWqUrTylxAW+AB2/ZIXZuupMyfeBExKrYPgLalUZ?=
 =?us-ascii?Q?kLyyqZwnDFRSIB3AbKoi0dgMvI8I+O4a84NFvwix+VrB9CVnJ4qH5i6Ok/rL?=
 =?us-ascii?Q?VWgxAxFaB8pnX4DFbG+OJ2qEh5kVcx82BIeo50VQEoorw9OT1VeJeHQ+/gAN?=
 =?us-ascii?Q?slGqXmlIzubnWE09jJTHw2aU58vmnppBh+URRduQYyB34Xr/FMdOz73NV8ae?=
 =?us-ascii?Q?9lWPG9V8KsTRC8/AEj7SgeKDTUS11B6YJbOehOxB9S0+4XMVem+EgIv/FI2a?=
 =?us-ascii?Q?jMt9tNenbp9XExrhzvkx/L5ntvf1jop5TP4jm8ZSGyvxRKDDSafaulwQ1Thx?=
 =?us-ascii?Q?RYvOrI6irSTSSIkzjmA5miIYjiSqaYTw1HmhgtwSQkLVf9TlopE+a8VgjAue?=
 =?us-ascii?Q?ehgXJVSgousvSzrz++vZO4nllOB/2sD0qeJ/unL0u5mqsZbP9VyUxfr7mlwW?=
 =?us-ascii?Q?AgyoyH9rgLROA9+Tpfk+zcOrfcE22bmwQXudAze1mQO0P8s2Wwa+OcwH/PPV?=
 =?us-ascii?Q?JByZDHORkrqglcRTY2hziokB6GrVgZlAkJvzPxJWDkSek398QC2z6X/ZXI9O?=
 =?us-ascii?Q?QxaoZXI2fwr97VjEhIHK+N4frDoBMrl8dyR+9JAbt4dI1FrXPmrIavCBQ4g9?=
 =?us-ascii?Q?yYBgXjuI9twiac5SYVL+DLFPnYr8IQAfSEQ2d2cFlPaPFGoGVxcFzmV6aZN6?=
 =?us-ascii?Q?AcLDY7MU+aGpEmQFHLgBX/x3JMR5bRvWpogbkR0RvOrNryGDQqJc6L0hWeKJ?=
 =?us-ascii?Q?KXxgxpNoAlRJimhT+1lBU8c/GRQhnA0S5xxlf1dGV1GQN05eP8aBY5BIKIu0?=
 =?us-ascii?Q?O9X/+1zJLQc5HOFhaj2nrrZ+VYmUNq3cCdTSf3w5jq6hZ9UYT56B768yXgGO?=
 =?us-ascii?Q?V8tIdf3Rf4nj1Vk246bXuABSM312a7uy++s35wyasAkicQqkOlkeUpBBADBX?=
 =?us-ascii?Q?HIE2zG9oLa1nLQeAk83dqwICqY7f/SeP5AZ/bPJ6zFFkRni/APwhHmeSOT2L?=
 =?us-ascii?Q?iRGKe2tpDnMEXfiivmaGr5s6b3RfoAPy/zY5vSQaigYbCz9Vc84t+Suglp7i?=
 =?us-ascii?Q?WIZYFD9IM3gt0+igGcXxekDtUXoPt5bypZW4bpTX/XWVmR3syKpCNp9TT/z/?=
 =?us-ascii?Q?Mo54CtMnGBneK8f/YJ2bI+I9dWwlB6MiG9STWlte78M8UmSXkx6QVFBS2aP3?=
 =?us-ascii?Q?BefcCTYgQGDnCE7ZDDyCauvfOQGUMI8TXHDov0Xn0GzD3MufRMZX++Pzw/KT?=
 =?us-ascii?Q?NCjUcPdo7BKG89r7os54THpgJ6JNZqFMotAiVB9LPaA4s/CraXH2HBiltLIv?=
 =?us-ascii?Q?y8pZBGnuMAa9u5z8AY3I83HvMnW4Wfq33Kf5jr2jIlbhy6X5E7tknu00lW9B?=
 =?us-ascii?Q?Vw9TIYQIC5QN7KPTrSDLPmXzwWSKpfOl8miJuEEb1mXvq+ryZ0QbfGq0E5J0?=
 =?us-ascii?Q?sm6ZD0ZKgE59eKCcBdSVCz/n/W8gw5+SN5lCyhWOffLFXWTW0Qi8aOlMN9EG?=
 =?us-ascii?Q?NBLgWWwd/afF7ftfrHKlftQ952hJZzJ3WvsCWvcGiUXKVOC+s6x+AXXnCBla?=
 =?us-ascii?Q?ojw+EcfTRRHphtVTifGfYTlGxBCTwtI=3D?=
X-Exchange-RoutingPolicyChecked: McLVOcJYXDIfWNq9LSXqcFurcn6QgrPzTIQ56bZP3Y4ho+CVTfuF2uVKLJruUQ3gCkW9JVXUnPa0eSwcf43lQx++KJr2TjEQg+pMXWRzBt4O1AJF9R5efXeSgFti4N0KFQBTYjjqxlb6blzVEzIDkMtpEmgEZ4nBozLroDUwOZAqGjXh8lQ4Vey2pzoLOoeyBt+VDjCFTiZWpauK3ifo5kBolH0aQBdXT2p4YDdjs9PCKkrfubD4+KnqkBeeBjFq86FBrsHhVIFsTD3EJCUayF7OXW/aOatkIOMHm8V235P1uERugi3mbleWP6STyTcnW2PGBkAVuz25rVSeYV8sbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a44ae3-e7ca-41e3-0dbf-08df08cbcd54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:25:52.8449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS59k5Dgv3sG7gvgY6AOk9GoIBHiTEVR80m8ZsQga6TkozfzaBB8PvFUIBWgKA/xUl/DlSoqd4jEraW4kCi7A8rmRa/s8BNAG8sFdvG9Na0=
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

Before addition of commit 029ae067431a
("drm/i915: Fix potential overflow of shmem scatterlist length")
and after folios were introduced complete folios were always
allocated, possibly overloading the scatterlist capacity which
was never truly limited to PAGE_SIZE when requested via
max_segment. The above commit addressed scatterlist overloading,
but unintentionally disabled PAGE_SIZE as a valid max_segment
value and failed to take care of remaining pages from folios
above max_segment boundary.
This created a state, where multitude of scatterlists were used
for the same folio, but never counting enough of its pages to
jump to the next folio.

Furthermore, current do-while loop goes over the same folio
multiple times, increasing the refcount each time, and breaks
get/put symmetry: many shmem_read_folio_gfp() gets and only one
put in i915_gem_object_put_pages_shmem() per folio.

Track how many pages have already been counted in a folio and
use that number as an offset on consecutive allocations from the
same folio to ensure it is fully covered before reading next
folio.

Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterlist length")
Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v6:
 * moved max_segment check into its own patch;
 * moved comment about gcc warnings above block of
   initializations;
 * removed
   WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))
   block (Andi);
 * restored original condition (folio_pfn(folio) != next_pfn)
   (Janusz);
 * dropped folio_page_index and folio initializations;
 * expanded the commit message to contain information about
   previously unexplained folio reference leaks;
 * ran final checks with Claude Opus and added a tag.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 112 +++++++++++++---------
 1 file changed, 67 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 4b5ce9a2f74f..8e5f2a7d5f6b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -70,7 +70,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	unsigned int page_count; /* restricted by sg_alloc_table */
 	unsigned long i;
 	struct scatterlist *sg;
-	unsigned long next_pfn = 0;	/* suppress gcc warning */
+	/* suppress gcc warnings */
+	unsigned long next_pfn = 0;
+	unsigned long folio_start = 0;
+	unsigned long folio_end = 0;
+	struct folio *folio;
 	gfp_t noreclaim;
 	int ret;
 
@@ -104,7 +108,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	sg = st->sgl;
 	st->nents = 0;
 	for (i = 0; i < page_count; i++) {
-		struct folio *folio;
+		unsigned long folio_page_index;
 		unsigned long nr_pages;
 		const unsigned int shrink[] = {
 			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
@@ -112,51 +116,58 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
-		do {
-			cond_resched();
-			folio = shmem_read_folio_gfp(mapping, i, gfp);
-			if (!IS_ERR(folio))
-				break;
+		/* Grab the next folio if we exhausted the current one. */
+		if (!i || i > folio_end) {
+			do {
+				cond_resched();
+				folio = shmem_read_folio_gfp(mapping, i, gfp);
+				if (!IS_ERR(folio))
+					break;
 
-			if (!*s) {
-				ret = PTR_ERR(folio);
-				goto err_sg;
-			}
+				if (!*s) {
+					ret = PTR_ERR(folio);
+					goto err_sg;
+				}
 
-			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
-
-			/*
-			 * We've tried hard to allocate the memory by reaping
-			 * our own buffer, now let the real VM do its job and
-			 * go down in flames if truly OOM.
-			 *
-			 * However, since graphics tend to be disposable,
-			 * defer the oom here by reporting the ENOMEM back
-			 * to userspace.
-			 */
-			if (!*s) {
-				/* reclaim and warn, but no oom */
-				gfp = mapping_gfp_mask(mapping);
+				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
 
 				/*
-				 * Our bo are always dirty and so we require
-				 * kswapd to reclaim our pages (direct reclaim
-				 * does not effectively begin pageout of our
-				 * buffers on its own). However, direct reclaim
-				 * only waits for kswapd when under allocation
-				 * congestion. So as a result __GFP_RECLAIM is
-				 * unreliable and fails to actually reclaim our
-				 * dirty pages -- unless you try over and over
-				 * again with !__GFP_NORETRY. However, we still
-				 * want to fail this allocation rather than
-				 * trigger the out-of-memory killer and for
-				 * this we want __GFP_RETRY_MAYFAIL.
-				 */
-				gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-			}
-		} while (1);
-
-		nr_pages = min3(folio_nr_pages(folio),
+				* We've tried hard to allocate the memory by reaping
+				* our own buffer, now let the real VM do its job and
+				* go down in flames if truly OOM.
+				*
+				* However, since graphics tend to be disposable,
+				* defer the oom here by reporting the ENOMEM back
+				* to userspace.
+				*/
+				if (!*s) {
+					/* reclaim and warn, but no oom */
+					gfp = mapping_gfp_mask(mapping);
+
+					/*
+					 * Our bo are always dirty and so we require
+					 * kswapd to reclaim our pages (direct reclaim
+					 * does not effectively begin pageout of our
+					 * buffers on its own). However, direct reclaim
+					 * only waits for kswapd when under allocation
+					 * congestion. So as a result __GFP_RECLAIM is
+					 * unreliable and fails to actually reclaim our
+					 * dirty pages -- unless you try over and over
+					 * again with !__GFP_NORETRY. However, we still
+					 * want to fail this allocation rather than
+					 * trigger the out-of-memory killer and for
+					 * this we want __GFP_RETRY_MAYFAIL.
+					 */
+					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+				}
+			} while (1);
+
+			folio_start = folio_pgoff(folio);
+			folio_end = folio_start + folio_nr_pages(folio) - 1;
+		}
+
+		folio_page_index = i - folio_start;
+		nr_pages = min3(folio_nr_pages(folio) - folio_page_index,
 				page_count - i, max_segment / PAGE_SIZE);
 
 		if (!i ||
@@ -166,13 +177,24 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 				sg = sg_next(sg);
 
 			st->nents++;
-			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
+			sg_set_page(sg, folio_page(folio, folio_page_index),
+				    nr_pages * PAGE_SIZE, 0);
 		} else {
+			/*
+			 * If our prediction about folio placement is true and
+			 * scatterlist still has space left for more pages,
+			 * then we land here.
+			 */
 			nr_pages = min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
 
 			sg->length += nr_pages * PAGE_SIZE;
 		}
-		next_pfn = folio_pfn(folio) + nr_pages;
+
+		/*
+		 * We assume folios are placed one after the other in memory
+		 * and predict where the next folio begins.
+		 */
+		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
 		i += nr_pages - 1;
 
 		/* Check that the i965g/gm workaround works. */
-- 
2.34.1

