Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51B7CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D637310F26C;
	Tue,  6 Oct 2026 09:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NAuFtW0E";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F5F10F26C;
 Tue,  6 Oct 2026 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280767; x=1822816767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Ipfy1zTC1HnkJb+mwF+s4it/M328fESY5VO3GQ2s+/g=;
 b=NAuFtW0EMvr4yf06/1M1Gy1eyCmFDXjZNmGaNs9QmhpuG2A52IpsQ0oL
 C25SqFwKI1KgoffzxnBJJOe6t/Or5Ly7wOSQl8vpH6/uIz7kf7q1M0YCG
 /cgaK0/uZwSjqZPNr3JtUgaAscrEW6V/76JwgZhlzMKs/+i+y5qnV0EKg
 lRLwyvOZiW3c3xOvZ9by9AKnkrVlE7cgwAMjy1CSBO27xNZLF4H87dn0S
 JmHC4LSmEcY4R33iW923YEKC5RrepsmU27i3zS8emaX5lACXeDe23rahF
 lYMvkmgcq0qDZuWx2wWSrDTSHp8rKz06NAURWu2UI9on0o9lc5R1d//8h A==;
X-CSE-ConnectionGUID: PI2Yo5ejSDiWMpW31IgqsQ==
X-CSE-MsgGUID: hva6UNBFSfygRTe9nnre7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="16184"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="16184"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:27 -0700
X-CSE-ConnectionGUID: MPuagZaLQAu1oRz4G0rZ5w==
X-CSE-MsgGUID: eo985DP0TXa/C5cGfgWalw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="306590863"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:59:26 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvwMqmeVBmPbMQGeAtMejrLSxPT0TQGEncfWWlPPGn5f9NsTCrulj6w92tM2IAVoyhXERgpRC6mQvG9bYRaIGd7crOJyEQujekgbplvYBX8vSfi3e7NIDRQNkRjWdngBhazJ4/YuUigYDkTTDwYMH2WDhzUBQvFpgDSjyBAgCACsNr/fA07FwLtq2QnjXXr1f0TtyfleLV+JuC34pXDmlKGKAvaYiQeTwcXW2uPfFf9NX4rZTmUiKe5ZdE9AqO0EhAlQppWT5iAysJOhi46oVXWkHd+UeegblDHtmBw6j7N13SM8XtQq5cvmsL4UxQj9vk/52uCDub92Ov6lisSCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XQj8LjUpN03TxOHIhCclkTb2K8IESjA/nsUenPtLQ4=;
 b=NmyHPEBxPN3/Oz2YUIkIRwXP+SmPiDDPU26OZzlgHGlFLQpq+hlxbcU538VjAwDnrFxfPkFdnOIRYd7wPRlj0co3y8BDbiXmDfQNfjr+BmKLHCfDeERcey35TB4KKhH/c2iRQ6pzMwxeIh66afgizgmAmfJcczXevKplgqCDs9XgY3kGCI2ETv/ckcZ2hxRI7fDeuf1lJifgXq+6ceeXz2bE8OSBA3NakrZg7KK71H09o4XU9ztnC3t83rbyy5Cxpg1ZSwk2h+qpk8/yP7T6jIT6h+UKOUr/GKNDHnr5lH5iCcEqFvqi63ea4qf2HsnkOsxxErhHwBIlkpf2dGF0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 09:59:07 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 09:59:07 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v7 4/6] drm/i915/gem: Pull out size validation into a separate
 function
Date: Tue, 6 Oct 2026 09:58:43 +0000
Message-ID: <20261006095845.451212-5-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006095845.451212-1-krzysztof.karas@intel.com>
References: <20261006095845.451212-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::30) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8a4302-8dab-4782-f65b-08df239075c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sW3Cuj8Wm/AHUblDU8h+osZTOICUGa/1Tpk0WZgnOA844HA3+XLNzdcYNH6ElPloPu77cPMg4cdHQhULYpCCw9bl5ZUPlGLoJvaGjlHvGTw046oeh2EHk9gWIUpjFfEw9er3sf5Jd+/uwzjkKd84QXScoMstrEixwkYpdTA2fh/+jrqt6Xf8TK1irEstHpSQWzXNikYxQE8ot7Py5ljgyCKqJYLuB0HEuWwQUv2i6/3Jb1NZCVi56zift+VHkFF8Td9+ovu86pfPt0sBWA7xLRQ1V9C1r11N+eviAFTszybCxtsirunmfkYkh7p5bqlDXmdB2OWF6oSJu2qFSKj87dElCxsJxEhDayFJoFY9hR7KvOxLtoPkgMaDACAB9CIuW9HqoqRsUlA3fFoE3cbUbHEmp+DJx0fBRw9edZRmG1cXEaX+AD5gqbfKDSgm9H/Ck4/TQc5XMk4eK/exgWoTPADhEa99thyyRtD5WvUVuzEl97D2XkbNrTk3TbX7Z9eplTdVqwfygZSbvshWrNNIod2uRNndpNAzK8MjzTRz4g4HRRE0fqXq7gNCJ0jbhyB0lGme97o+l77dKS2Ql+og86AvTsUViswNZpBLjpodTRX6+WuG1xZGqPQ3lh9lfUvWdZ01Su9sttNNb1Ny4sE2ZF1apPkZdmXC9RLs0zC07FE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RCQliK/9P/TMKfM6M5EQHoTUQE+mx+Fkks/RUOvZMAO2EZZAKitt4Ayz9VGG?=
 =?us-ascii?Q?zulPHF7+nTbKgKYBD4M2Sd7fjseAjE4hgkeWrkuk0KjnjpTM7e0Kb4BH+x6o?=
 =?us-ascii?Q?50HWBx7v+9AgxLz2QvbU168Nlc5TVIAxh1TLC7V1pD4tFcwcp5iDbbx2Ghps?=
 =?us-ascii?Q?4aNMx4rbpGrqyM+vKpiOLTsqLZUMj6rH/zFJt1D6W98giEZ8qjJKe5x9gfaR?=
 =?us-ascii?Q?vZFgezwn6VNRJSkglWAtA87bQR8C+gjGslc8tskvr351kdFyMOy9MLEkpAHi?=
 =?us-ascii?Q?HLD2yaHbgQjIqv1zHlSDXvjaipI/Jl67Y++O38SZLBxVlwhZHCZmalRSdhNh?=
 =?us-ascii?Q?Wsljow0PLgizV70BIYwnXrs+RTXn6DNL0NhMLfvb67e/8UE/N9/qejdDW/kx?=
 =?us-ascii?Q?2F79OpyfzAaP5LzPnDndkmkEyQ+foRYcFJvjekIQPmtCJ6M7D8s5eY2e8eGn?=
 =?us-ascii?Q?aqR61dCdt2f64GmBE7blKEHI4qtxEKdhgRyatnnOn7OZDpqYV6+att3p/GPP?=
 =?us-ascii?Q?+DbNgURAH3z9kk18c11enbt2w9dNgL8g/P6FS6VUZAX59s7hDBO4GxdpFSSi?=
 =?us-ascii?Q?MXgGnTOzrDddGcSIoMUFLYPUtPfIvNdLqSu+QyGeu1V+c0k8S+k7pBw5Uuj8?=
 =?us-ascii?Q?uu6o0AZ80PyI/zdUS7wiaVksXh62uVToRF1ub3rRemgu4tSou9VZKWt+io2E?=
 =?us-ascii?Q?7mOYKtXBl+O4G4/sJ6ApLbIj7Bmjn3afZSFZ5usGI95BpWPll7ws4Mk1IMEk?=
 =?us-ascii?Q?YdRaFIcb5zt/sfGCSAudr5ISCtGRzmQCUQ3PcAdV9VGeiSMTn7mqHMytyXHW?=
 =?us-ascii?Q?mwFy1uWbK9XiKOmX1I2hYBY7b+HzSqb/UrFl8ihQMgpjD+8u093lhHFWQYJM?=
 =?us-ascii?Q?9jzDgX6D79PjNgzydLt8W7Tju2UPUSw8Y+Y4ABfeXneprFq9skG28Paq805Q?=
 =?us-ascii?Q?wCI+PR/u9B3wZp3cQxR6x4Kpuegvo2nPYST9TbzxJuMx5iVLJb2fwJNQqyeh?=
 =?us-ascii?Q?qJ63PbQKsAPWyV/tcnF9l11QqnEemqBEPvYhY1MIlo8aGtaom/JEU1+7DEYU?=
 =?us-ascii?Q?dvIQUJNJt6TtDXKGxWb3PTxaypRHtAu6KNrypmMJuGzrqU+e4Bq1A0kCQLxh?=
 =?us-ascii?Q?m573q78El4au44O3lMsFTGi6nsbfFPg4SHtyqk6LyyU5ao9WxwRZ9ErcM9KY?=
 =?us-ascii?Q?F7FPdKCpbrnTmSFBcS0zEs7ygXgrLMfazTsu6tG3Z/8uNV0sr1Dr4Z7ZA/N+?=
 =?us-ascii?Q?U/Ah3IL/FuAuuU+D8uyH0aRQ5Wo6c/BXA8OZl2AsO260Xy8HJrSru29DeCAX?=
 =?us-ascii?Q?3gzoujDYql/LZ/VdM8L6xrLSdaJddlLPm9qiBc/wwdBYKeQez9TZ9/ZSzSt9?=
 =?us-ascii?Q?o/BFh6a4JqVr+ycwBvSorlYd1a3tpPFgXBAGFtf+YOwYEpsEiHog9VnGiV1a?=
 =?us-ascii?Q?ySOiPdLs6O4BFPSAUQKa9yxL1k1TwtNdXybsTC1dNjZI0REj3tA2Vlc4ov9a?=
 =?us-ascii?Q?4c0hmQSKFzAXOPnRYdZeqWTatAkedhHMGCYDO/rA8ZGUj4Fk0FYiYjEgsNV6?=
 =?us-ascii?Q?W41rvmCBncFZk0UBPEtbyvvGt0qYQVyh7rIa4ox0mFg/fs5y8gcIq8HtJNy8?=
 =?us-ascii?Q?qN/MideNjQU/y2Wdkwccwz7JuA+sJaTVYgZPeTwPM4JvrhvtQS9utskK70/+?=
 =?us-ascii?Q?/sDG74L8LiIBlCIQW3MsgomyPErmn+v3dPWCllA+fwMmR9DuAllWD/jJwTWM?=
 =?us-ascii?Q?MJWOFYas6L6sUAmS2b19B9c0pqI/ERs=3D?=
X-Exchange-RoutingPolicyChecked: N2KUBX5gibIxA0446NgHi9Tb7/rxngFgMQ/KcUt/z5Rfh1f2FFL1ax+0Aqd0S+TYq+y+zO5JcxgkPq86TAz/E+jtkWiahHjdW2bOOYIt02tdfYBhbl6Fr5SWNus3tmbc9F64P6J3mYgZ3JWEWCBNhkcHb1rQsUBqb6eLvaT6z9PvJ0vZvFKsmZ933HOG5QGcKWut0GpYIQ8RhM7PbtPqBBgNf3GAXofq5H+4ZzlmD0W2X/pEskNKaBHc2/02DqNzKN6YXtcgf5F1Nv6em6OSsrVcl3hKan9BY14Be+Z9vXPkaOcpST/VqcH/Geso1Pp3176V/+g5rkXWTlbADrCYTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8a4302-8dab-4782-f65b-08df239075c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:59:06.9399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VOad1r5Me4zpTnCzpYccSfOCZhW1kB/cqNK1QV2TuNw2eDlzTcuqH1fJtdeGX6SqC9ghkJHIcCiGDMDAYdpoAlIs8yJ+63lN8nUEMjGss8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
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

shmem_sg_alloc_table is a very large and hard to read function,
so reduce the number of operations it is responsible for by
placing "size" validation and page_count assignment in a new
helper.

Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
v7:
 * Test the helper's return value for nonzero rather than 
   negative. (Andi)

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 76836f4882d3..256ef414755f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -62,6 +62,23 @@ void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
 	sg_free_table(st);
 }
 
+static int validate_set_page_count(size_t size, unsigned int *page_count,
+				   struct intel_memory_region *mr)
+{
+	if (overflows_type(size / PAGE_SIZE, *page_count))
+		return -E2BIG;
+
+	/*
+	 * If there's no chance of allocating enough pages for the whole
+	 * object, bail early.
+	 */
+	if (size > resource_size(&mr->region))
+		return -ENOMEM;
+
+	*page_count = size / PAGE_SIZE;
+	return 0;
+}
+
 int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 size_t size, struct intel_memory_region *mr,
 			 struct address_space *mapping,
@@ -76,16 +93,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	gfp_t noreclaim;
 	int ret;
 
-	if (overflows_type(size / PAGE_SIZE, page_count))
-		return -E2BIG;
-
-	page_count = size / PAGE_SIZE;
-	/*
-	 * If there's no chance of allocating enough pages for the whole
-	 * object, bail early.
-	 */
-	if (size > resource_size(&mr->region))
-		return -ENOMEM;
+	ret = validate_set_page_count(size, &page_count, mr);
+	if (ret)
+		return ret;
 
 	if (max_segment < PAGE_SIZE || !PAGE_ALIGNED(max_segment))
 		return -EINVAL;
-- 
2.34.1

