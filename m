Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2810C5DF7E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A0010E72A;
	Mon, 17 Aug 2026 09:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d3fx4PVu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5148A10E717;
 Mon, 17 Aug 2026 09:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786960633; x=1818496633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=g9P/glKhiueQHZ7ByE6nv3qjl0c+x7eV94ZqK7b3r0c=;
 b=d3fx4PVu6Aj0FDWryHRrS9YFH4EXFoU5VG+Ff24sfWodqg9nFn6goKYq
 InmzOiBkc66Wb66f3Q6IQynqoNseNQzmUF2t6wxmQWr03g3SlI8sSyUfB
 JeRVnz9Xh1cKNpv0xjswjOS+008odpNR2B3mp7ViZD7ZpJnhbP85eC/rl
 yvDmFtHL0wE7j+viAb+77oupx9DGr5TfQfDievMP4ebZRiPXoePvhixlR
 LNLUYwd5ViQRMSlFT47MxpvQP2vTm7qWLIVR0Pm7IHXEb9xbfGD3mxDku
 LUcE+wnFxz4E7DP8kH/DfX0jeBdnKMs2B9PEhOlG2ALnpmHrKCdyctj/L w==;
X-CSE-ConnectionGUID: hsxM0WZ5Ro2bQlTYKxL8iA==
X-CSE-MsgGUID: U3+HSp1WTvyFsi+Ur1aDdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86551617"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="86551617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:13 -0700
X-CSE-ConnectionGUID: 1t1LuRZETA2uYSiz8gvqhw==
X-CSE-MsgGUID: VcWQtTfjRT2rIpRj3scPEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="269148265"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:57:12 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCp86KZt4jL6OI7HOCYLaoM/J3/ubZVjBYiK7XFmKpcJLovy4boZQ4m8qyONkfG1WmXW4+F8AbdE9VpDQnSThsqXy5uEoHiu5PjqzCfJQm4m6usyP44x8h5uGCzHDwKoKCLEf5HgqMJzIpp0BCy925HOa5zzKK7jVLgxJ5AbBbugLeSnuAHxpN74dQjoJlUs09JLxpvSNGCi8OdUJQG+IXVzCdM2SQXKAQpIqUTEBDhC9DnVZTJ9P4OUif6ztSqmwx/wRdZhjiLcH6cZofyxVO3hOIGfLdwSoYEtEq3gCu6pdKRKSfbdtcRJWpHfAixZNhREEpviX4oxQwbPRbYqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdsUis3U3xsFv6pYL1oAZ4O9LFmio2mx9g8Hf51Nagg=;
 b=qMZoyfVnun/zwo7aiIxwSC98i9ZJPhWK88JyXXCixlBDqNmVnHmlCjs+u49TbFw1xW1pSMq8hqNHKwIsMRkncdd/cQe1xadVOPMX6sn4jq/OqOJop29EX5nfHLHoYzThnc9yNGpd+lDthQIBnsph4GpviZhYM5MP742AB1Ve1bjK14IVHQFZ00SQIeuHhDf/wIKn866JDgpqsvpsxsby1eA9nEywuND3j9am/Qn8QBkErWLEk9Y+LlAeA6JVLa+JvF/ldBsYEFNvIJicUyVN+K6Z6zukFUAvsWppdIP29iDG/LLyP32UCUC6RotO6QY5vrRtU9NCcucBk7cZ7zNgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:57:10 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:57:10 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 5/6] drm/i915/gem: Read and shrink memory in a separate
 function
Date: Mon, 17 Aug 2026 09:56:47 +0000
Message-ID: <20260817095648.2438192-6-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817095648.2438192-1-krzysztof.karas@intel.com>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a85fda2-645a-49a1-5aa6-08defc45e7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: CE7HK1+ZQOvMzJJIvaaJIbqSeM3DclCNh+oFlbfMyP6FI5xSal4HBlGewh9eBDFOFChZ9+Z/JfJOwmIVDqmv3rFWewGEHnVrLuOthv3//lEGER1kUxqtXiZcI0rPeqGEsmxqYfqQGO5x1MaQLk8Cz5Xd0/hfMDxNRdQ80+fMPBRc57kNOSTVYSnLr3MWIMkw/uyLCLP0MvDPqQadcckhgRIps4Xlb1e9uUtDs7iSGDsVGRSiaNkC5+zq+3dIiLXHJmIVBssjUnXRxUVeUiTOSn1CLtwPPPz7XVXC3bC58+3zYVBRbGxal9ehghk9/ck4T8XbBTUndW329Ve4jmjzPTiRnEG8RvfcUXzgP+EXnO2v3P6q1O+chUxwjh7Uhj2LRM4RArhwGvxj+yttvRIIrZc4VVmpCsCYIJocP5ZN3II4DkDS0PaQZ7+0HnsdYJfJrYpLOcMGIr3d1TENoK3UwuNIr1BYqWnjYUi4aSBCdw5ytNc+fX5A7TbNen/QPkjeNAFdhFD2XHymxclAg4VIDCge3HWGJ8OtNXgqQAN21CFQHOSS6TMhFw4m7xPB9MidUgT43iFK4TlgYxhgdpogYJtodvmFyn2SRwY4EumzDguF8OAibwXjydikWSKA7E8Ix43dRuVISBuzDQ0NQPST/XZjK9ticAjrzE59MK6fzw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qlpIru7TakYIK/URTwjBK+DsdrJ620WandYZy0ZgHDfdyEXs53cIQVO+Noes?=
 =?us-ascii?Q?929dX2Xp4hu0pRJ39+je+C6lkgBHdY5rnBCL/kWtA+XEs8z4ICpehtdiz7nI?=
 =?us-ascii?Q?mA6it3wdkNHWPTvCNi7JYsH05BbasmP+xAu39GMUoi6data2rT0oZOlTCBwl?=
 =?us-ascii?Q?owjIq2cFnIanpPAsa1lV66m9LaQDVFrTyHjlmw6jROp5CD1rZ8vLemqcN0tj?=
 =?us-ascii?Q?T73yZpsOqsh/RLPGCDBP50yB6o0raVK91xCnb2vSHotOwKY34/k9pqkeY+hL?=
 =?us-ascii?Q?/V8IkIKpKKXokfSWqXG3+lnNvcoR9z3SkGuVZ5fmutaoz+PowPOZNDAWZenJ?=
 =?us-ascii?Q?jLuXTCsrpG1kjRU7p3x0n2TS42A9yCziJLoyv6+ALI2b6WptVa4JxO4fKXJu?=
 =?us-ascii?Q?+5LAI5ZH/wFwyAdztzw8aXb3ZY6mHT9ZtHPOBxCkKonGUKD3EwcIW8h+jmz2?=
 =?us-ascii?Q?3xOWdiKJa83L6wpjXsu6PXmFwERIXSerO4nfeMZg/qjU+LC5altDauEdbJty?=
 =?us-ascii?Q?sI5jkxyOW1IREOyn0TNUX+GQ5LHLeS9DQ/H0xgPrgYNPEbfrTkN5TIElUVUQ?=
 =?us-ascii?Q?3k9mK5uZuCfQvlbK1Ci7FvdclVhrntXFQxqjDMhLgt+A5wpbOyJl+RBvMK+S?=
 =?us-ascii?Q?LdbvnBY5j7gct2FugddNVbBmpEfdbT3Hp5vlsQhUhrJ5IUYJk2CP0ZXIf7eD?=
 =?us-ascii?Q?GqMccDcZo+ORz9GPZGpOywEnKalgR7+TtyU/QzX5WhJlPg+aGqHD4g8eaWEp?=
 =?us-ascii?Q?Ycg1zmFEqQSP8ufdxWqr+2E2KkGPjzKIU1d0kN8u0a+jGfGFMaUoCHI6bteJ?=
 =?us-ascii?Q?E3JgbxHzgJj0aNqPfg+B7ZR1lEhDXSgpQrTDw8f2kDhw0UxMQ2WTKlLeguXc?=
 =?us-ascii?Q?++fqSSCiL00lGd0dsrYaiPRaCwuhPmU+HPFmrsCh79UiV7cxdD3vRk+/Mw83?=
 =?us-ascii?Q?A/OI7d6wjfrJrHr2Ca+stBqyLkYeIAMK1p2f/2PjE+zoZR6nJ/KGsY4BmfLV?=
 =?us-ascii?Q?grv6u9WTuddVnQw2v2Ts3ZdS+ApkY6zu4uSqKUpGKjK2pxVuM8hQYaCRkpYK?=
 =?us-ascii?Q?AejYI3dlfoS703AMz0ywwRHdMq3bn6D8oVi1KnlRjp6qV4F0JWfNjedS6LjI?=
 =?us-ascii?Q?xRZp9BcQVM7rCYkt/gqzdrnhWtdEZJIPLxI9Dokvk8rF++6eT94E7E6Injl7?=
 =?us-ascii?Q?qE910TOFujJiDJb3aq8ZPYxo2fputiLF7rizllR3Wq9yapEhLQy6APi4Bwfc?=
 =?us-ascii?Q?WJWuTfp6bhgUAmYIkKg2EFzgGMuL07HU1KQzxwFeWrDIJLG8xMSSfUfAD1N3?=
 =?us-ascii?Q?v2atbYdTazJgF05BMice6BP7+KH0XVGaLVHK1G1Fd9qnKKg0LPf4OKepSErg?=
 =?us-ascii?Q?gDHz8WYJu40ue6MG0cGmdnRKIMyHG1azUBmUoWWSQXQFWEB8tYkHglvN+gVE?=
 =?us-ascii?Q?VeytDoytERFF64Ul/o5E3Fs7xo0JnOCo9E+Nv8yGArUWTPfsWheNoceFZ6oa?=
 =?us-ascii?Q?t3nW2htNJw1YdnoBiO4qOkA0OmND/dnggV+Pqq+0rhlc0sETZIMNOx8RKnHv?=
 =?us-ascii?Q?cdW+7ujZ2f7DvgPcbsuVuvfUPEft5hJ5VPHoedQjv7d6hRnhfBTEfWPx8Uk8?=
 =?us-ascii?Q?QGlgciY0EYOScn8jjD8z9+VLxFIGJHb9tde/VVx1nHyX0+TJlM7GVER33EKm?=
 =?us-ascii?Q?qbOpInrv/ZspDw46Do7snlMT/FgXdKIFWpoHOc1iv3O909x9CWSZJUcYFnK6?=
 =?us-ascii?Q?k+RoKJlauHCer2Q1VkvPVq2uCkZ6C4Y=3D?=
X-Exchange-RoutingPolicyChecked: BqoviASHY9qv7LCct7IMfuHmjyJsF1i6mGr76om+pULRD6HSUPtEuHprX42aHWpI5bMR7SvduOQMiw/dgmXQPtKqrg9hmmBpS8eNv4E0cCmyWITppV+mG2TB7uRTVDZmULyD4mRfc9G9uCGHGOZX1mzFj6nkCo1jEgnOXDGlCtjrPnAloRBEI8KvJILGJYKXb/tSTLqcZ/OcXXoXiUfc4eZw0p+8c9bS7105xdLuLqzTUQQj0x/VlED2c/al1QA895oD/BEly2Xg1w7p2jOO+CSQVr0uk4lsmCU0/jb8Yb6RRBhReq4joT2Bxx8fuTlKayjnRNdLDAW9QgKSTKQaXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a85fda2-645a-49a1-5aa6-08defc45e7a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:57:10.4067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eA1/Q/eRpirY2vgzsShZwz2rz2wItta0Gvyf1Jb7vJpJKZB1LYAuRL15IDqG1+0GJ9rCZLmxN8DWHYdPITzNe9K/wk6WZMJmKpasHJqlNy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
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

Continue unloading shmem_sg_alloc_table by placing reading
folios and shrink call into a new helper.
Make the code more reader-friendly by removing two iteration
loop over a structure and replacing it with instruction
sequence.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 103 ++++++++++++----------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index b63a9395306d..a8ffcfc0017b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -79,6 +79,56 @@ static int set_page_count_from_size(size_t size, unsigned int *page_count,
 	return 0;
 }
 
+static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
+					    unsigned long folio_index,
+					    gfp_t gfp, unsigned int page_count,
+					    struct drm_i915_private *i915)
+{
+	struct folio *folio = NULL;
+
+	cond_resched();
+	folio = shmem_read_folio_gfp(mapping, folio_index, gfp);
+	if (IS_ERR(folio)) {
+		i915_gem_shrink(NULL, i915, 2 * page_count, NULL,
+				I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
+
+		/*
+		 * We've tried hard to allocate the memory by reaping
+		 * our own buffer, now let the real VM do its job and
+		 * go down in flames if truly OOM.
+		 *
+		 * However, since graphics tend to be disposable,
+		 * defer the oom here by reporting the ENOMEM back
+		 * to userspace.
+		 *
+		 * Reclaim and warn, but no oom.
+		 */
+		gfp = mapping_gfp_mask(mapping);
+
+		/*
+		 * Our bo are always dirty and so we require
+		 * kswapd to reclaim our pages (direct reclaim
+		 * does not effectively begin pageout of our
+		 * buffers on its own). However, direct reclaim
+		 * only waits for kswapd when under allocation
+		 * congestion. So as a result __GFP_RECLAIM is
+		 * unreliable and fails to actually reclaim our
+		 * dirty pages -- unless you try over and over
+		 * again with !__GFP_NORETRY. However, we still
+		 * want to fail this allocation rather than
+		 * trigger the out-of-memory killer and for
+		 * this we want __GFP_RETRY_MAYFAIL.
+		 */
+		gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+
+		/* Retry once after shrinking and gfp modification. */
+		cond_resched();
+		folio = shmem_read_folio_gfp(mapping, folio_index, gfp);
+	}
+
+	return folio;
+}
+
 int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 size_t size, struct intel_memory_region *mr,
 			 struct address_space *mapping,
@@ -119,57 +169,16 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	for (i = 0; i < page_count; i++) {
 		unsigned long folio_page_index = 0;
 		unsigned long nr_pages;
-		const unsigned int shrink[] = {
-			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
-			0,
-		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
 		/* Grab the next folio if we exhausted the current one. */
 		if (!i || i > folio_end) {
-			do {
-				cond_resched();
-				folio = shmem_read_folio_gfp(mapping, i, gfp);
-				if (!IS_ERR(folio))
-					break;
-
-				if (!*s) {
-					ret = PTR_ERR(folio);
-					goto err_sg;
-				}
-
-				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
-
-				/*
-				 * We've tried hard to allocate the memory by reaping
-				 * our own buffer, now let the real VM do its job and
-				 * go down in flames if truly OOM.
-				 *
-				 * However, since graphics tend to be disposable,
-				 * defer the oom here by reporting the ENOMEM back
-				 * to userspace.
-				 */
-				if (!*s) {
-					/* reclaim and warn, but no oom */
-					gfp = mapping_gfp_mask(mapping);
-
-					/*
-					 * Our bo are always dirty and so we require
-					 * kswapd to reclaim our pages (direct reclaim
-					 * does not effectively begin pageout of our
-					 * buffers on its own). However, direct reclaim
-					 * only waits for kswapd when under allocation
-					 * congestion. So as a result __GFP_RECLAIM is
-					 * unreliable and fails to actually reclaim our
-					 * dirty pages -- unless you try over and over
-					 * again with !__GFP_NORETRY. However, we still
-					 * want to fail this allocation rather than
-					 * trigger the out-of-memory killer and for
-					 * this we want __GFP_RETRY_MAYFAIL.
-					 */
-					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-				}
-			} while (1);
+			folio = shmem_shrink_get_folio(mapping, i, gfp,
+						       page_count, i915);
+			if (IS_ERR(folio)) {
+				ret = PTR_ERR(folio);
+				goto err_sg;
+			}
 
 			folio_start = folio_pgoff(folio);
 			folio_end = folio_start + folio_nr_pages(folio) - 1;
-- 
2.34.1

