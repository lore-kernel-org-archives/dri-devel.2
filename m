Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67463C9831A
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63A310F472;
	Thu, 24 Sep 2026 12:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZgYEA4Gy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6DA10E907;
 Thu, 24 Sep 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790251379; x=1821787379;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=hXFTNe/TrhRbnDYJ78K6deGxvDlKUUGYKh28E2sn3w4=;
 b=ZgYEA4GytMXgeYQl/h9qO6X8PH0Qk+HI29RuRcglDNkddleGq05FoH1d
 ROra9UdYbRjEyobyfTO+KpG3pAioN0dpS9UM9FUX9pk5eZllM4AHgPvhH
 QtVt6l7WwbAlQ1mp/gTJyGN+jU84SPKMQ2daMf/JTQ6TvH9UDZHz7rzFj
 k8LCcRdHXlDcw3W42wNAbhun1Kc1E1BpnX/2YVksHqrAdnhMpHAjbL5J8
 jprZ6+1rqd+E5UAInLtBP8j7wd16LeguPPMYLvTkQLNBm7nLsrJF8Vm1/
 NiRf4/3/dwL+aTM9kiYV8tJhsOA8gaLtfIcxm6oSEGsl16V5hDipBnaW1 g==;
X-CSE-ConnectionGUID: 9wPFUiC0SWCA6fW7xFCtcA==
X-CSE-MsgGUID: zyJhceE7SZWK+NolUoKX5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89923995"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="89923995"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:59 -0700
X-CSE-ConnectionGUID: oXxxYHmWTliiNj3KoAU1WA==
X-CSE-MsgGUID: SHpbVAZDRR+Q8xVTXxz+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311921310"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:02:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 05:02:57 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 05:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2CfZSLZzBBieMXnlgkwZ0UbBpE2E4Nxu0EG5bctjrB11nAfHA1mTP0czrMW1Kp0AN2EcXsQKHCFzapf1ji/5+3juFhTUNMziPt9mkR6Jk1nPdH7moFwGkH94quzlrmEqudRBSbAnpVNwxrWfcTomAY1icJBwslJkMitExGsZNPcqvtlJ7aMWbSWCXlOVPhNM5khN3yM2O8uI7MmTFr1pvpg6b84lxvQngX8g0UeWuGgr2IjnXP99aFLUCfWMzbCQjkxXrrOX08Ha7agy8OTXVT0vZRuwBx+9HllG6Qp35hHQIbHtJEYivlcbXrw/mdTaNoMcxt+sEyHCwwJIp/qVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgja2mvF21xQNB7JRhSuHYr3qo+ND8eVCdO0bDnSX5A=;
 b=iiG/zBibn7a9x1BZ0Nb7XXo/hlRe3ZIfGzfYJnWdntvk0We2H515dNlAkGKhpXQ4HxeFLTiAp+iRr0PsBmus46zC09hJO9mUhoS0gv7S3+bITHlorby9UCfEVhY26UdFaSuEU8Ee2weMEfJuWxHoMeRFzbTYDVGZSMdEgJxBfDYwFVn8Q8gdJTiNCIzxKvZ/J7fs0IeD7TvfFpoRW+ZyvWSK8hawZaJ+CHD2zmqu8o24B4Hv1D0ERXXT/l1+wL0ghrKy38iYBVdi+otwf2lP0lAgx/PcEqze8Z1oG+2qgagxyCWk/9xOibFVOUeL34WZNin9mdF5J7neQOuXeBD0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:02:43 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:02:36 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 3/7] drm/i915/selftests: Use gt_*/i915_* prints in selftest
 helpers
Date: Thu, 24 Sep 2026 12:01:43 +0000
Message-ID: <20260924120147.1305127-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924120147.1305127-1-krzysztof.karas@intel.com>
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c56f8e-1f60-4487-2e07-08df1a33b945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZM6lXIa3dZVRCPt5tzNCPEwik+7iaCfMzJTHbFdvaySsA3ol/5uDdh0pwEXAM0RdgnVKhxQEL5ygq8+nIJEwVbD5nilm0ILNFWltSn6+gJLM3RXwiArjdNFMJJYdQ6ZdXIRqky9GiHcnnZDyzjGeMhYjq2j2zL98BeNCZtzqbLfuT5Ct+ra8hORZboCsGQph8DM8bpvXHFCCNDvEP1wckqQN1ZB5npymmyGPJm/ChysHDH0SnUyrqpvVwF4lk/sNARX5/tu5hh8BZmEusx2efA6SgvmuInv3bdYmj65hB6uGacIPlvdGXQ/L1UzZHrPHkOSEJ/OeJyqFPF5ZHGMRa0QK1CgOnhdooWDSbqxx8xHf5RTZcveuumMLdY6nfCqGRwc27j0iJwqK6pG5z1oU/8IOMcJvKY6ZC4j5WJKvZb0k9oKvMRj83cwGvS0Fd81tdHtIzKasMo6y94+KjQVEqKzrFQ0DKd9oMSUazlAaDylus8HmtcjPohNJJvf7CQjdtQOCe1Lv21xxYJf2Sy7Oui5qVvQoNau9MMQ7cg/AspuCM9hxu6cHxx4PKwjfxnTSHxI2V6DKbyez54ZHQWDuaSuXm6ui/wydfpIMYHcgoXXSfM0Eg+PPxSmw4SgGWNRF3/E/zcQDGZlFMZEYd+h1yoi+nMQrtAg150vvWg8B9BY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PctuqTuDt27Pe+rWDCYkvqALfPymV6qZqDOKYSzyPk32ONtxnNr5CqmgTh5I?=
 =?us-ascii?Q?dSpY8HkqsLS6JuPIJcbIeqCZ/N+4SqInyBymuhMGjyLW3Fqu7lxeuuTlqnDw?=
 =?us-ascii?Q?kPmMPURCCZIajaVN+T4HXHnTKkOGNoPDIJ0NQ0Y51qjE74eoExdrfDsaMf5e?=
 =?us-ascii?Q?8w3geErJAhg8j2A99/tfIfYVbXDvCPbOXFh+KQahuwPr42jMfgiA6Akyo6Jh?=
 =?us-ascii?Q?zKnka8niu5fP6+Xmsdq3D1dM7IVmFM796l3GwTRO8lXcQXsdGcexKbvXFEJD?=
 =?us-ascii?Q?nRhJfaAMNLPHxO5AX6mFWbcoSVa8GLd9m3skzj1ODiqyiqpLUgll/8Kzc+8l?=
 =?us-ascii?Q?iXKg1dvwi0NwtcQt+G48B40dAvn8suiMddIoLQt73wtoQcfqZCQvhgsjInpV?=
 =?us-ascii?Q?u4Vb2aINjkFvXTvGIJCyMyvaIvxQCUnbzLWO1Ftd/fz8zEhSoyBfWtmPYkP2?=
 =?us-ascii?Q?bvgMbonFrWWCU0z0UR6UeEZ1Vxt1NxhfKSaM44GY/6cDloladJlwBsugn4iY?=
 =?us-ascii?Q?3R0DVFyG3IdHUzE/9R+hN/9KXxztEMwI+lUd6UAzBXzzUZvRMkdV2oK4ENRq?=
 =?us-ascii?Q?xQkCQPx5ainVxEOXyksKf9s7S7KdtadtG0SNy9/864dubsgA4XCKE3TMJn++?=
 =?us-ascii?Q?aRH72GgzJKB/fpqEh5Wsj47D1s4iDBno67gfSASjCzUGVIEbgS4seSbGgcq+?=
 =?us-ascii?Q?KZ8cyiengLdB6TyzSSdzAtCgclxDkOBkHmmQp7F6723blrOfrLyhT/8Zb6xB?=
 =?us-ascii?Q?Z5IzBUEOAcbLnFWFkWghK5HZXkuIm46hyGA7kUt0YeD9eCJO5zMR8v81vII+?=
 =?us-ascii?Q?PEkxOl2mRlMPRVVWoN6mRvcBmbqkMAwWVUg25hv7wbtpyKPgc0WIxoCYPRyg?=
 =?us-ascii?Q?9cqDB2pzuUDnJ3xoGTp5YL/TCccm6z5iYIsijI0lZsExLUN/ZiKjdHTQbcek?=
 =?us-ascii?Q?NraHVhSi7InrCRHAV/XO9oHwvzNsauNJ0W4KHvEqDut2w8NaKmPEMJ3ruicI?=
 =?us-ascii?Q?jH54PTs0JgByEox3SggdxrEu+D4OGOzEnVh72hdxT7dZdS5Yzz/m2vCx7GIk?=
 =?us-ascii?Q?rzaFmUx2vXIrP9eC0P+RdvTfoyJnrClLjbOo/JK7gs1SPufJbFB6iG7RfB3f?=
 =?us-ascii?Q?sE4IrZA2xdPk+KVCOW4VQ9yCtXBlP/dB3HlBqV6WwGBJlnEJQyLlf7muWDZj?=
 =?us-ascii?Q?YWESaXZiX9ofY6q4OAkakPZ2PzCRxxvzlFWDm9Wl84k7pElYQOpIKQXlu+rd?=
 =?us-ascii?Q?2elRhBBvONFBo9YgiF8mUaQXriHqswrVF2+YZjqU6UhzOvagx5ZYTBLrwIBF?=
 =?us-ascii?Q?HDxyNFoD8s1MjEE52hbJdKtMltjIhK9eWc5+qTfVF9Ot8yrcwo3wfKzp1Kad?=
 =?us-ascii?Q?2DT96TjN8Wo1nTOS2RMmC/rWyBAzioqFxQB4sqOJ35Za5bzA4U8RP4lrt3rQ?=
 =?us-ascii?Q?h2rKQTNd3WfvEnDQcB/5jcTGq4rDC5oTjttc6hiVyD6h7WrgblXfVo5smr9R?=
 =?us-ascii?Q?NoDuEy/PvieCkG5NPk7MYfxp8WqOZXLjYoAxz14eqWLdVUaARUfgRQuwXdsh?=
 =?us-ascii?Q?iX8/rJ5BkKegJjWSYLpfYL/o6Cgbaw3PveJJ7WEsQ3PlbAt12uArO2XaekJ6?=
 =?us-ascii?Q?5Sr4BtwwTu6OXBTvqDuS+Lg1hHRDHXwYehJubyypcX8gBoKtwhxW8zZ787QT?=
 =?us-ascii?Q?gXgCbxuMRL9d0wRnaFJoIsgUanRoTDkjJ9YECwy4ICgRrFP/BZkBvroatu7+?=
 =?us-ascii?Q?sYYRbCIqY5ygmaTn/w97xKawfCby54g=3D?=
X-Exchange-RoutingPolicyChecked: BRu0LDnkjn5EMqnIPj8v3KN9gGnfzp5Bb5ZuNvFmtrLgSqWWeqS6ffyaEhNkcUK/8dpnG55CC+iR9DlyBqvvLD9EOk4ds5smxQ9D1mzwmoMpF8gEm4y8zBrwa5SWpjBPJr2ZLAI9go0rXVmHXo1zqQRH+fFDu+L36kKOFH+wQEq2RhjWXr7kf247wvJU31bbFdQLQCbpWsQbBUvo4Bh2SEqRMVFEfKyAaFIaV8e1s7NXld2pc/rpKopRSNEI2RXvVCOddblluZkhgxCNWMXd3R2oMgNKt5Rj60n4RfcmvIkM9aC8QHmLdLleaJKwDAUISsN9C5luinXQAhCPrCx7cQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c56f8e-1f60-4487-2e07-08df1a33b945
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:02:36.5181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/cW4Vz1VV21v59wmEG92fh0xSpWH1UYVegVwRH35gWxaQJIOTmvOWPFlhaYB8gAbHgSsTCN+2tmthdS7ArHQZwIrYeCANw4+y1L3vOwFn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
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

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with both the device and the tile it
came from.

igt_live_test.c and i915_active.c now use i915_* prints: both are
driven by a bare struct drm_i915_private and have no unambiguous
GT to attribute the message to.

For mocked device in mock_gem_device.c use dev_err() instead.

Assisted-by: GitHub-Copilot:claude-opus-5
Assisted-by: GitHub-Copilot:claude-sonnet-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4: 
- switch i915_active.c and igt_live_test.c to the new i915_*
  prints instead of drm_* (Andi Shyti);
- fix include ordering (drm/gt print headers with the rest of
  the local includes) (Krzysztof Niemiec, Jani Nikula);

 drivers/gpu/drm/i915/selftests/i915_active.c        | 13 ++++++++-----
 drivers/gpu/drm/i915/selftests/igt_flush_test.c     |  4 +++-
 drivers/gpu/drm/i915/selftests/igt_live_test.c      |  7 ++++---
 drivers/gpu/drm/i915/selftests/igt_reset.c          |  4 +++-
 .../drm/i915/selftests/intel_scheduler_helpers.c    |  7 +++++--
 drivers/gpu/drm/i915/selftests/mock_gem_device.c    |  4 +++-
 6 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..98f606877aa5 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -12,6 +12,7 @@
 #include "gem/i915_gem_pm.h"
 #include "gt/intel_gt.h"
 
+#include "i915_printk.h"
 #include "i915_selftest.h"
 
 #include "igt_flush_test.h"
@@ -115,7 +116,7 @@ __live_active_setup(struct drm_i915_private *i915)
 			err = i915_active_add_request(&active->base, rq);
 		i915_request_add(rq);
 		if (err) {
-			pr_err("Failed to track active ref!\n");
+			i915_err(i915, "Failed to track active ref!\n");
 			break;
 		}
 
@@ -124,12 +125,13 @@ __live_active_setup(struct drm_i915_private *i915)
 
 	i915_active_release(&active->base);
 	if (READ_ONCE(active->retired) && count) {
-		pr_err("i915_active retired before submission!\n");
+		i915_err(i915, "i915_active retired before submission!\n");
 		err = -EINVAL;
 	}
 	if (atomic_read(&active->base.count) != count) {
-		pr_err("i915_active not tracking all requests, found %d, expected %d\n",
-		       atomic_read(&active->base.count), count);
+		i915_err(i915,
+			 "i915_active not tracking all requests, found %d, expected %d\n",
+			 atomic_read(&active->base.count), count);
 		err = -EINVAL;
 	}
 
@@ -236,7 +238,8 @@ static int live_active_barrier(void *arg)
 
 	__i915_active_wait(&active->base, TASK_UNINTERRUPTIBLE);
 	if (!READ_ONCE(active->retired)) {
-		pr_err("i915_active not retired after flushing barriers!\n");
+		i915_err(i915,
+			 "i915_active not retired after flushing barriers!\n");
 		err = -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.c b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
index c383d31d46b0..c59425e7ccae 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
@@ -5,6 +5,7 @@
  */
 
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "gt/intel_gt_requests.h"
 
 #include "i915_drv.h"
@@ -35,7 +36,8 @@ int igt_flush_test(struct drm_i915_private *i915)
 
 		/* 2x longest preempt timeout, experimentally determined */
 		if (intel_gt_wait_for_idle(gt, HZ * timeout_ms / 500) == -ETIME) {
-			pr_err("%pS timed out, cancelling all further testing.\n",
+			gt_err(gt,
+			       "%pS timed out, cancelling all further testing.\n",
 			       __builtin_return_address(0));
 
 			GEM_TRACE("%pS timed out.\n",
diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.c b/drivers/gpu/drm/i915/selftests/igt_live_test.c
index 7d41874a49c5..80351f58b4d1 100644
--- a/drivers/gpu/drm/i915/selftests/igt_live_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_live_test.c
@@ -8,6 +8,7 @@
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_print.h"
 
+#include "i915_printk.h"
 #include "../i915_selftest.h"
 #include "igt_flush_test.h"
 #include "igt_live_test.h"
@@ -59,9 +60,9 @@ int igt_live_test_end(struct igt_live_test *t)
 		return -EIO;
 
 	if (t->reset_global != i915_reset_count(&i915->gpu_error)) {
-		pr_err("%s(%s): GPU was reset %d times!\n",
-		       t->func, t->name,
-		       i915_reset_count(&i915->gpu_error) - t->reset_global);
+		i915_err(i915, "%s(%s): GPU was reset %d times!\n",
+			 t->func, t->name,
+			 i915_reset_count(&i915->gpu_error) - t->reset_global);
 		return -EIO;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.c b/drivers/gpu/drm/i915/selftests/igt_reset.c
index a2838c65f8a5..6be63451317a 100644
--- a/drivers/gpu/drm/i915/selftests/igt_reset.c
+++ b/drivers/gpu/drm/i915/selftests/igt_reset.c
@@ -8,6 +8,7 @@
 
 #include "gt/intel_engine.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 
 #include "../i915_drv.h"
 
@@ -16,7 +17,8 @@ void igt_global_reset_lock(struct intel_gt *gt)
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
 
-	pr_debug("%s: current gpu_error=%08lx\n", __func__, gt->reset.flags);
+	gt_dbg(gt, "%s: current gpu_error=%08lx\n", __func__,
+	       gt->reset.flags);
 
 	while (test_and_set_bit(I915_RESET_BACKOFF, &gt->reset.flags))
 		wait_event(gt->reset.queue,
diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
index e14ac0ab1314..2441887e3b28 100644
--- a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
+++ b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
@@ -7,6 +7,7 @@
 
 //#include "gt/intel_engine_user.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "i915_drv.h"
 #include "i915_selftest.h"
 
@@ -24,7 +25,7 @@ struct intel_engine_cs *intel_selftest_find_any_engine(struct intel_gt *gt)
 	for_each_engine(engine, gt, id)
 		return engine;
 
-	pr_err("No valid engine found!\n");
+	gt_err(gt, "No valid engine found!\n");
 	return NULL;
 }
 
@@ -60,7 +61,9 @@ int intel_selftest_modify_policy(struct intel_engine_cs *engine,
 		break;
 
 	default:
-		pr_err("Invalid scheduler policy modification type: %d!\n", modify_type);
+		gt_err(engine->gt,
+		       "Invalid scheduler policy modification type: %d!\n",
+		       modify_type);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index 796c9b070e41..c0dadcd961bb 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -169,7 +169,9 @@ struct drm_i915_private *mock_gem_device(void)
 	i915 = devm_drm_dev_alloc(&pdev->dev, &mock_driver,
 				  struct drm_i915_private, drm);
 	if (IS_ERR(i915)) {
-		pr_err("Failed to allocate mock GEM device: err=%ld\n", PTR_ERR(i915));
+		dev_err(&pdev->dev,
+			"Failed to allocate mock GEM device: err=%ld\n",
+			PTR_ERR(i915));
 		devres_release_group(&pdev->dev, NULL);
 		put_device(&pdev->dev);
 
-- 
2.34.1

