Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEDECA5FFF
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C1010E351;
	Tue,  6 Oct 2026 09:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CHHvZmfL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B462F10E341;
 Tue,  6 Oct 2026 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280744; x=1822816744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=cJVQ+GO2oxFTlT6uez9H/TIxgijMrpL/bxw1lcRBMwA=;
 b=CHHvZmfL2ZL/PYNWJKg/N6ZOrxvtkl6iYerzZOIP+pyh285lFmYMaYLb
 rZjmN6p9aMNt9iormwgYbl6S2BHbndrP8riOAwQgCK5ZG112l7Zq77Dx5
 sldcmLSWsbyZW/V+Ifm4Z4EgwGHtb3BwmMmQQJAKOjsDZcXRzqbtGDBkt
 oeUh+Tooblzcy7eZlo6sgOMB3Trz/8UuN3IWuuBmgLB3iAGf/pI9pXsBQ
 4g0k01kG+pFwa4G+OwsodERt4nFlZbgsymwDkHFBYLGMloyFBIbK/cQCM
 R7oVkMsrFfc9JOzFwPfp2SvPJsKBQ2FenTEBNfKBwqPdtIL3wgSi8l/Tm Q==;
X-CSE-ConnectionGUID: BMAjIz4iTKiIDFKVudW7Qg==
X-CSE-MsgGUID: C9ZPnnRASwGxnYkUar6pyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="16108"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="16108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:04 -0700
X-CSE-ConnectionGUID: SuE4C/SXRWacrVf5EBz3UQ==
X-CSE-MsgGUID: bw2r0aCVT9CYHqg+7X4m2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="277218501"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:59:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 02:59:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 02:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2CfvKjL4gt34Xr7mce9kQz7eG/UM1DCfcpCcMcJER+1rW50m+RbRN2YXBCOk+twWNmK+8WJNqF2CQLRGEVOL6znntsrKWUK3QnXeebXwQm4YyU/9RYB9ArZSdO+WNixTRxWjty+fBIHncqy6AEt5ZefbREPdxTxXVv1w4O2ihHRQRp3sbXQ+/+D/ld4Zs5q9/8rK+whe3iUWW0Di3quEJQGxkA/rpkUszUmdU46z2jKt5yT1bKODcnd/rUaXosCgGicSnHNTGeSnddE71ZBRdzwZ9G1FsA5mtW6QGaHu8HL7ixoIDfRcGluNQgnxojbDPj4zBe9T84KEKeiAGHJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGQnZwhYjsT5pkFWj3mNPyIkNhnzAOvkHwFH9V9/X3Q=;
 b=k+5uzYKnFPWnM4xFhXOnCtJZpC0Xn2/B5EHuV/3lcfM6C0js6Ab2EbXW/gLMHi45F//Dl0jUkIPP9EfZDfWeQRipvnD3G03whAQnmf+92Vz8DPJJhq06ybhUTR1cJunvyvVUkL6vPDNkj8OJAZy9f2EHA/43CTHE4v2elcgKzQzNJIIeEiVLaKYz+ranTSyvzghz44XCO3xNe/jHqiMJ9A/a0dc/jJIw1Ickj+2GAHZ4WH6Oa+FyZXR2slVPiJCggAfTagmvxlBZY2ccBHmTxkMUpSKFgMgyyEX5Yrk7Z5mTUdIj/9GunkYvy8+Z4lF+KcrgCA3UQaniIOq/FGJ6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 09:59:00 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 09:59:00 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v7 1/6] drm/i915/shmem: Validate max_segment
Date: Tue, 6 Oct 2026 09:58:40 +0000
Message-ID: <20261006095845.451212-2-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f60a062-1875-4231-3990-08df239071a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Nzhm9NBXnu8rUpEzmwNJ+wksda0MpyeSajSz2noJmO5Si6hXr3Jl4B0HTMEDxGHZOcsW4ARV7XNqfXYONrr6rNOzx+Y9TX92ayrtUFT2fWaD0KLZ9nNOdItIL9WTRYKgcygMETaZsy0WMz5XDQK03Gc4EcPhBDz/Ya275dm9ZpM+JJVe4lXwQPRX10FjRUMcjr0f2F4SCsntr/zo/ob5Js1MMuuJ2ipq1S00b0CCAdsOck2TayKNvgWjEiQRV7FMNB7gmlVknzAeAIdQtjkRKJ4nyz61rjQCxDs9Nm8nTQIlmC0Gqt7YRd974cETf4Ifh1W5UIieIhasUNgEGAkAJlyu2ur2fY8gFOF7uWIS+r9ZDN10K0/bDMpVcBYZUev1L0QS39G8SFlLe4XDtQz9ZTTWzcwlElUe8pH7v2u2ydJ9UOZAi5CqmOy0o2zB+xfxZZcb4VIg+3MnhjSrfI8Xgar7uq2LpXuSkBic/Y7Zi4d2QdxpFpDadBQB9rQuhAVZdNBttC6LeSaedUo3AOOqLPhhgXa6NVFIZvRM4IRLJf+ho8Zkfy7YmK4/QVW4YCIj6tsSwrGexmQAT/Nl+A5+ATrswKZV4xB2o3ZpmaoDJGhoZFtYJLwZHf3VYCEX5nJvBuzAzpaMuzw3TEKthpo0mjkWiS1bDhkYlHhQYRAnjKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jc9LfXyNw3zhUO1snILR13nDWbCycdTw3zRhPbE5Fj4HuZFZMEvqJGbSt7Dc?=
 =?us-ascii?Q?thPl/VCYwko8sxILsTDEgKezKnOczY2epGz3b5+ZZbqbPs3/rBAeWv//VoSM?=
 =?us-ascii?Q?6D9zZyyKb+bkwPGMQvlF6a5lpWAL/azuVPYFrdk2tyRlKE8lYKyOToolIMwK?=
 =?us-ascii?Q?yEv97r9z37VwFMYKtBfmf4Zlucou1m2rDVLqogpYLXTJQiKnYAvqk16zTIFc?=
 =?us-ascii?Q?c+J8FRHhaS6aRKx1+rFer5ScAWtqCliAtvohwSm6HZtDsahIhmh6aAzfh/Tx?=
 =?us-ascii?Q?y6Yolk2FH2iSS0suOg7vAj9sYvIi3YozWFVmIyqyZ3qhJjRPrxm0q6vt07yF?=
 =?us-ascii?Q?iRO/lhaOc5Mqw99fetyqzzR45M3iiMjVxhGUu6gtb51F38EJ5R44ysLEESPX?=
 =?us-ascii?Q?wgdtkdQxVWprgMK6ngGDvofXSaVx862xuM0YnCnoqJcVTpIhwU0/nk2K7Cvm?=
 =?us-ascii?Q?C0zbrrXpm3nKyNVaTalhd7SwRVsqpQB9Y3cAnVHTJh6S8b0pfz+enKcDrUaG?=
 =?us-ascii?Q?yvvDpq6rtIVBJxB9yjWlTF6esyyAD3TNWIieC3PlgRgfIu2OSQcQS55b+pP1?=
 =?us-ascii?Q?sK3AlDvQloBdaAQPav+FXA5Olh4hjdJfbGbrqAYAWMSoLUZrtYnF8Ji/WIJ7?=
 =?us-ascii?Q?F2nkjWiyg4smM/33HN45Tp0ncp94UhxA1zSdaWYFEeUSidzVQFDHx59bud9q?=
 =?us-ascii?Q?LWh81Ioqx8aN25tOAUlKjxsm1pnDhRStPbqn/KvFIPXlFhC9l/pfY/L+DH6M?=
 =?us-ascii?Q?nZoAftTgdngrZGZswy/HHk57lud1Y7QAjioQ84REFPycrNj4K8X0JwhnvGjO?=
 =?us-ascii?Q?1Vl0D6BwEtCvaQARJPF9xW7HuLRAJ0Gr0QW9BaaYR7lAnZWkDxi6Nv2okH0i?=
 =?us-ascii?Q?KIKBBxCuK4LCLBn8T3zLN1Vp9/t0JhDAg6XAXb1X/ITXqj+JUwqn0Z4E7El9?=
 =?us-ascii?Q?gHV+Kp7tOavBKI+YIieVQVPP0v8xBqM0Ox9jhDFEs+C/3rGFFkEbUaw+WpEQ?=
 =?us-ascii?Q?piOVh9WSem2hPrHLakKVyQ7O3GP2GOLhIJhyHUAcLC5nveaeTpxwRDNf+8I6?=
 =?us-ascii?Q?eIs+XhLy9foZxv0axXY7a+r57H2rgJ5vgDOhzh3OjDAPJBuanJ8NJI7Ei5B5?=
 =?us-ascii?Q?x+UZVOpc57cKyYiyJK2topaXkZwrL1SpPJ2VxS/Lc/NMQzSz6ExVRPMd1g4u?=
 =?us-ascii?Q?8XFUlK0/QDQoJV+g5UpNPGTLL+ghGLjM0xOvnQ2GgjVnRH+lmNWszF04/NP5?=
 =?us-ascii?Q?eGiEFMxUtWVS3xbqkUWCHKj8hwB4hLiBW9KaSoJse8K6EpFK+xoQWu6DtvZY?=
 =?us-ascii?Q?v8u8CfJQTGXnAgwl6mxR931QMkc0rPN4qpgUTdA86OyGJ75K8a6hJ8AeWUKQ?=
 =?us-ascii?Q?HCjqPBv9HX1w4JxUNhXdpAMZT6FS2bpHFg7zRjaMKWVItKs8fQt1xQqDkrmo?=
 =?us-ascii?Q?+lot7FSJ46enI9ej++NO7CCzYXgZDIGti4Efpqtlj/fbXpery9HMVV82YdlO?=
 =?us-ascii?Q?XOjZf766rEwN2RwhhM49f/SJUGbsIyfYeASwG0hb6+8lAfbWG96S5ki1Us7+?=
 =?us-ascii?Q?oz17UB7AbcdVIoNkRm3+VSiHlPcu6aK8lgg9ekSKUMlLw9bRmvMBAbj9iMdF?=
 =?us-ascii?Q?pNqEo5WPnmMR1+GslwZDogaSeD48w/6MpKes8QczoOoZ7w2Pp+ehsWtwv+Z+?=
 =?us-ascii?Q?BE04Jofa57xtFEoEP4NFk5j6oXpKUWZbeSHLFvaBqhSYjbW4JVfbHYBaeTXP?=
 =?us-ascii?Q?4WeXgEBx9nIKzTHXgU9OfPC4T+TnYCg=3D?=
X-Exchange-RoutingPolicyChecked: gFqgBvSVAoKFL7QXzy1odstrsbOit0O+zFdQxZh40SOFVSRnb1TRNW/oPxv8w44e5YP7buA0/beL7mcD1AYIx4o/V79UYxsylMhd23XJg+Y+bmPXx0/InLaS5JbxdF21Mwn9t+cL6RVVI9im/V8xH1AYBAJgWazUQZ5Xx8Wn/apF/tvs6rTIj7g876j2tV8tbZyezRNmMiBRwbcnLQsblBNdyH9h2toLxi7kn+O3ErmrWSoT6Z0fWTl60WBPVYzWE6ZWJ2Oxzmax7xVDMH+wOz7PhAy5+e4FO/hTKrcFl0xdSHljzghwaL4CtChQjBalKOjPkEi4ZbbvI4Im43izdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f60a062-1875-4231-3990-08df239071a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:59:00.1746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62gHnZdfWEvSWRFvfjalHyEi0mYG0WAA8yvJZLRpdhBTT2y6nnEmI5Hhq/ztmYzlYfsSaIOCb3Qe00RGamZBM96t1ITx0cqpn7EZwX9srdU=
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

There is nothing preventing user of shmem_sg_alloc_table() from
passing max_segment smaller than PAGE_SIZE, which would result
in nr_pages = max_segment / PAGE_SIZE == 0 and cause a
non-terminating loop.
Also, ensure that this value io page-aligned.

Suggested-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Assisted-by: LLM
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v7:
 * Also reject max_segment values that are not
   PAGE_SIZE-aligned. (Andi)

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index bf9e7480f0f5..e35ee4bd456f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -85,6 +85,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	if (size > resource_size(&mr->region))
 		return -ENOMEM;
 
+	if (max_segment < PAGE_SIZE || !PAGE_ALIGNED(max_segment))
+		return -EINVAL;
+
 	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
 		return -ENOMEM;
 
-- 
2.34.1

