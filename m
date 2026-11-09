Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A859606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l0Mu4C7E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C6C10F1B0;
	Mon,  9 Nov 2026 11:38:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DC810E8A3;
 Mon,  9 Nov 2026 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794224300; x=1825760300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=iskVRf+UQZVDzDeKJrsg192/9ktUMHZKYQsNdflpWl0=;
 b=l0Mu4C7Errr9bMHV5SP4EAF8T4JaH9/MnqtIyUBWQaqwGl4t0P8Xkn+f
 VDw94LpNunF5xXuU8AWOuW7vHyLRfF8KYSCuGa5YSsWyYVi5yovSvSG0/
 8/Bt/FsbOAnhLRLUvLJsrRVVx+NJjLqeqYsYziXraCflf04NpwOQl206R
 UjG9fcpTwk/evSnZzF52D7y0hFjRlsEaaAv0c+mUdEnT6y2dLsYkQ/qN/
 67Wgbeg194Ps/ICDemR38dFY5z6WzERINV4Xm/DM3I9GDwxPTl/ppHyX0
 TrnFhWGTiNx4HnAi0DoX0nOp9T4SEM7o29NxunXucpdB84xOoV0kllwl5 w==;
X-CSE-ConnectionGUID: wIwpf43RTNSHnir6EXrvhg==
X-CSE-MsgGUID: 5Xanc2kpRuiXTK9LKVOq1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2938488"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2938488"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:20 -0800
X-CSE-ConnectionGUID: 77Sb/35/QFGLw7QR7uinzA==
X-CSE-MsgGUID: 97ubY3+wThieFTWj0RSPuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8282621"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:18 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:38:18 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBnbmxTCq5Tl9zQyE8HZhFXEsdy1PlW4QMkVeQoqTRqUVR5UbGyZhbulRD+ZDUCmo4WJpcaYDknePLyxKEz4HZdOodSfDhmF14CO00wUw48cJ39CkEs3mTz2n51E/MaubBzwkVF60GV5hC2D8BViXOGQCZToJAP+mhGcA9/GGVt4iyTjM1IoJnH5jj8mjmhtnzbky6yqTXX1hfS71lfJS8kEoJ5YO4Y9WcbJhKsVEZwKU1hUDkMjH3AQjsu/jj309FnkUJSP17U5QGa7MLRXEx8axpZbKFLeVQ2bBnoeXdF+fvxEl+JLJeiPmhzdQGv2bjGsdr0BzhE+xVku93WG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuhFmn5axkCyWm2zp1ezglgk8+97DnVuWHPj0DfuoFk=;
 b=U1v/qyP8QGNpWRxrWvt07ZpQxFqnqpGqDbrygttTLzoBZFTpzG8iD/zrVSyxLxj0sCX48MTZh8zjW4h0g1ptCxb2WdiZTQSDG4aXwdMQpFZDT1yHI+7xzpZNpVq/E2DvRKVytpf73Nfk5KW/aEXfig5VKIoAnSQR5tl4smmcoracrC0QqFJykIzY6ENe0zIMxWReekjCh2R+HqQD643HB2xASkb0SF8L2nTm5eQ0ytaS4MTttblLaWGESdfLKSo0JwFvw6qGVRbgMn76bGd7JW2FiNIIE99ctoDycnd54QypwZL8kTRHxAxqT2PZHUQlQY53t7T4wStWdfy9jyoipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7199.namprd11.prod.outlook.com
 (2603:10b6:208:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:38:16 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:38:16 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 <stable@vger.kernel.org>
Subject: [PATCH v8 2/6] drm/i915/gem: Count mapped pages in a folio
Date: Mon, 9 Nov 2026 11:37:54 +0000
Message-ID: <20261109113758.1491891-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109113758.1491891-1-krzysztof.karas@intel.com>
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0215.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::10) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: d30e1724-c19b-41bd-cebf-08df3e55f216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|10067099003|11063799006|56012099006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: NErwrKw4TEukaY/v1sEPHBvsqHo9jFRoBY7JxJRSVaB20AR5Nxcm0y0yTHUPByPBO7EKdeFJRkjpImLF/RJLdwQngznnIZ5tSgiOIU8FpEthk6V+ekh7LjWp2DrBnc3+nSqTVnUaz/x+dIp+uqV29AFultq9c0qnLfV3Fn68XWNYy0QEFAqKfj8eIfJZbA3bXsU6Stg/vBHrRuOtF+Frd1teIAAcoYChqQP4zOZKh5tbYdAjRqGhsHvAL60KqQ/P4S1qua0eqcYxS8iqu7oPLhtSTePCP2WxzNyHRsIkwWdNE0kseKtsz1HHTM7OB78cEsOdZQDVMbWG9ra7ey60J6mEnbwV7tWJ6bVoD8F9jh4LPBykhY2Y4vI48iZzTdQJxOmYbWXiNhWpDVHzSXgJSRnZ930LihnGzWeh8UEg9DlikzdlysMYKbAkcAqV2JKco8Na/E2D2PJfi+ON753EmD+zlVSk+a/iPq+6zr1rPR0lO+zpE4vxnk867Lol6V7uwDmi6mLISoZZhSnsLR2DrGQDTOPzLqieFNxz87yYDqQJR2b9i6pLObE8Qz1kuJFuVAk1l4k0oiuu0AA823T1MqjsWgGn2GL+a5a/G8BxMRL1jZd1ltAuKMg/Mo33Twq+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltSD8yHhCTcRQZ9JJo1ODdV3RJXjWOHxFW9fCoIEAYT8WGUogqmuSVafHRQk?=
 =?us-ascii?Q?Q8+a03pzfYTjjP2SxbxTUpEa5L9LGOH/05USpQX3J4VKIkMpxXZxntXPLsOM?=
 =?us-ascii?Q?/ziA4vMTsh/odtyGBE5WFiM5SMaqeA4B7c9fotKatCsyP9A2RS129s7gZO9i?=
 =?us-ascii?Q?eUHgiwucNr1Ld5e3ACxyjgRdfZHpSEuhbfAiX3qryZnXYoz+xvZVv6xh3fP4?=
 =?us-ascii?Q?uq2+rzBHH3drIbmZOHsl8iv0erY7hG90/GYGYdw5Ij2y8edKe0a5KPya9XHx?=
 =?us-ascii?Q?XTeop1HvERX/HqaV+Vd3hdxPYiz/JkDvDLFGLDBvHGsTnJS+TGC9nPNADWel?=
 =?us-ascii?Q?EJDR+N1XhtH1eluVFnNIkPuwVH/+vnsujXFmW+nO55aTq5gnEiu7LjDjquk2?=
 =?us-ascii?Q?WCR8liQHcL7a71Mjvu3CB/ZOkXpsKSI+o53SGruFpbqGwrtrn6xQpS0gkm1U?=
 =?us-ascii?Q?LNfKPA14DncmH1u3aacXj1nqTW3BxGLz3xjBQPkVMzsReq4nt7PRzROQ2Ypo?=
 =?us-ascii?Q?X/U9l0zXxh71GT+EZMqp0Pi7hXxZEBGuRp9WuU4Kk1MGw426moQ9kT+Iub20?=
 =?us-ascii?Q?qHsrEgeUkYqmAFf8qIvmXgDgSUiJl619lXRexTb/g6sx2/HCTJBYYhVU/5rj?=
 =?us-ascii?Q?eaCSejjBuXeLeaEhMlqerSlKKLTddRVrLc8MjJxIQcTFRz670k+bpcTHkcnj?=
 =?us-ascii?Q?rA1dvpPo6pL8FXTm31VlTzaeN3tckKh0/m8rJVjwD8I+bMjejonwWndp1594?=
 =?us-ascii?Q?i+SdMdYYOku7Qqut4lMuH32k4UOh9uGZ25PW/p15mlA2lYos5OZA42nenmuw?=
 =?us-ascii?Q?CArV7p4lKJxwImxcdfXqT58pB84nFip+otU+Q6COM99TzhdSk8EKIQKUYr9f?=
 =?us-ascii?Q?WXX9Q2pPJg8JiYrhw+/o4O59sBDcn+kI8JEYFsOlYj4Aj0Yhl/qBpoOfMYgo?=
 =?us-ascii?Q?+xYwOWVeUkF4EklnDU9PzitrhfTOtjcBDkISSTJWxlnzWPC3k6Aw2F//0z5T?=
 =?us-ascii?Q?/x+f8fXQtRxC/nOL7517xwaViCo+XnzEgoQ/mD1WJvVxVKyH4nYUcb2mVpBY?=
 =?us-ascii?Q?PP1Nm9VbtUnncouo7LGuyIt8INV39PFcjJhsqaiKE/QpChQHEKkhEde0/3qG?=
 =?us-ascii?Q?mN7E552Zgpus+1v1hbB3o5PrPmfrWRp1aIl0IFNzzItF2W+qXFNawcdIi4C/?=
 =?us-ascii?Q?EXZgNC8vMBg2mNA805VAeGi9NzgbBCxJMypBKOpHz75mTzKSIm9I5BxLVY/a?=
 =?us-ascii?Q?UFzRaP9+/Z8zPFbZxN+FJ0dGzWcMuPVGwZ5dJU0/IqXbZyOF1bXibGiR/k/B?=
 =?us-ascii?Q?pdNSnXl5XRRN4XJEMq+/1Gpgc2qysxH2j+7stq1eYcR97KJQNpjJUp15VcIH?=
 =?us-ascii?Q?K4px2TjuLfYqm5WyEIfOq6G6P0hD2/atN00cCzuiHzr6elCy1tm70LdTqkjA?=
 =?us-ascii?Q?JB8JPv9P6R7mWtDwtuxurYve17+nEtrUCVr9fOGsYMkdzuxTKUjt+BbYHZrX?=
 =?us-ascii?Q?46lCsxk+qbBFsr2UY745kIbuzzp2FFcw+eK5sxRK9Juc5tmWt4htUL5o6Exr?=
 =?us-ascii?Q?sOrksabXNJQGlUEE1yikHNfo9k2mJQ0HKrz7biM0vDvYHBlCxnq8RsU0G+nM?=
 =?us-ascii?Q?mNA0nrJedJCsyzdCkHtLQntmve5kJLey1cgkiyh4lS/0mW4fW37kdFM1jDSK?=
 =?us-ascii?Q?hIYFr2mBECnRyWJ3S0HyHhUAPjas1Rxgb9w2CglYeBdNQ4HUIaSgFpuCcb9A?=
 =?us-ascii?Q?rdMAU6XzI0lFxBjigufDk7m0Fn46r50=3D?=
X-Exchange-RoutingPolicyChecked: Am1KFAO+O9bIuSLKxxBDUH/75sENTPh3bVK6bQdAva79L9HCM7TVtiTExOJczGTWeqkLLIZ79aZanUA6dgMU9azHD5OYqJ0hniqAEu1YczgDVKZSvF2nCoWsoSR8s+bHKeDxH433WOeR2QMijJD09Ja5eUKhZfBEOxSjJy4wDSf9SBsEFSJT2HXYk8Rh9iQQm9AT34B/95s1n0+yjgnnZrFlVWGnCnUKDlhoig8FghFnu7eeheXcg9CNztS7FgYs/POTl50kuUUj8UftGOJLWi806ADOl9ZQ0Av5qehINZkKCBaHf6cPBmrqT8uSJbcJRIpZ3EAc5ls7mtF1fzTgNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d30e1724-c19b-41bd-cebf-08df3e55f216
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:38:16.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tgn3gzjguU8gboyW7MNSk8KSHSPdoLyWBMUymgQUYXdVRt8HJpxL1taK/ry9d61MfgodwMpiuyucjL3P1hwojk4rZwYTeiVrjOkfgVy3p6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 101 +++++++++++++---------
 1 file changed, 59 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index e35ee4bd456f..d57b5c67d47b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -71,6 +71,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	unsigned long i;
 	struct scatterlist *sg;
 	unsigned long next_pfn = 0;	/* suppress gcc warning */
+	struct folio *folio = NULL;
 	gfp_t noreclaim;
 	int ret;
 
@@ -104,7 +105,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	sg = st->sgl;
 	st->nents = 0;
 	for (i = 0; i < page_count; i++) {
-		struct folio *folio;
+		unsigned long folio_page_index;
 		unsigned long nr_pages;
 		const unsigned int shrink[] = {
 			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
@@ -112,51 +113,61 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
-		do {
-			cond_resched();
-			folio = shmem_read_folio_gfp(mapping, i, gfp);
-			if (!IS_ERR(folio))
-				break;
-
-			if (!*s) {
-				ret = PTR_ERR(folio);
-				goto err_sg;
-			}
+		if (!i || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
+			/* Grab the next folio if we exhausted the current one. */
+			do {
+				cond_resched();
+				folio = shmem_read_folio_gfp(mapping, i, gfp);
+				folio_page_index = 0;
+				if (!IS_ERR(folio))
+					break;
 
-			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
+				if (!*s) {
+					ret = PTR_ERR(folio);
+					goto err_sg;
+				}
 
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
+				 * We've tried hard to allocate the memory by reaping
+				 * our own buffer, now let the real VM do its job and
+				 * go down in flames if truly OOM.
+				 *
+				 * However, since graphics tend to be disposable,
+				 * defer the oom here by reporting the ENOMEM back
+				 * to userspace.
 				 */
-				gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-			}
-		} while (1);
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
+		} else {
+			/*
+			 * Otherwise, we are still inside the same folio,
+			 * so just update its page index.
+			 */
+			folio_page_index = next_pfn - folio_pfn(folio);
+		}
 
-		nr_pages = min3(folio_nr_pages(folio),
+		nr_pages = min3(folio_nr_pages(folio) - folio_page_index,
 				page_count - i, max_segment / PAGE_SIZE);
 
 		if (!i ||
@@ -166,13 +177,19 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 				sg = sg_next(sg);
 
 			st->nents++;
-			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
+			sg_set_page(sg, folio_page(folio, folio_page_index),
+				    nr_pages * PAGE_SIZE, 0);
 		} else {
 			nr_pages = min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
 
 			sg->length += nr_pages * PAGE_SIZE;
 		}
-		next_pfn = folio_pfn(folio) + nr_pages;
+
+		/*
+		 * Store the next PFN, so contiguous physical pages
+		 * can be merged into the same SG entry.
+		 */
+		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
 		i += nr_pages - 1;
 
 		/* Check that the i965g/gm workaround works. */
-- 
2.34.1

