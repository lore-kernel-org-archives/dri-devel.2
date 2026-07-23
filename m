Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F911C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644E410F074;
	Thu, 23 Jul 2026 10:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f4mJJoNN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9729210F078;
 Thu, 23 Jul 2026 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802365; x=1816338365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=lT72cQoGMLxPhvGFKuFvpA1fS56hlgQNg4nRIyqi0Kk=;
 b=f4mJJoNNlZ5IMRSYtgL91m+5wNRPQ6MeKnttVVNsnQ3GUFQFaypkKo48
 UK7NMIsbFXQj56+tMiCmjTXydQarWKaq3mCtX7i5lseazQCuqrQhBVTVv
 XieZPntxvxFSgiX7rGfBC4J/MdeBwI4YWvPFB948Vi5g5S2/T9BlLWbSq
 xrwCyuF6hfzgkgD3AueVb5EpR7fssWHqaWKa28tiXcummDlLrr1qCf9Ht
 ciuflhvacjZZHidPAttKcQwXJ7XyChZKEVlqf6wRAZljx21psNyuHNj9z
 pOD1LvTAq8t+hxjc/EBrfmS5KQfONP44+PhIo26QHj4+X+y5mYhioxLa2 g==;
X-CSE-ConnectionGUID: oJ6dvo9cRA6Il0dl2QsF/g==
X-CSE-MsgGUID: Le+zbsqNTS20XfpHJEMLJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96970827"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96970827"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:04 -0700
X-CSE-ConnectionGUID: +HbUfiSRRyOYsh8OzB3F/w==
X-CSE-MsgGUID: dHit3Ix8R8qWo6U5JGoVaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="254442011"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:26:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btNOHlKOgC5k2rsA0cawAL/76qLDRTGnMkkgl2Wo0/2pScH3D5T/PqssNCXsIRDhNkKeTl5cZ+WzsLCVcxhOMwcwi2IOjMZbw8bghYM2p14XFMZ76I72HeW9TmRhIXDgSN8LqXyn/Ikj6dIP38HKtvrl+tnzwXVcYx56STIewNZb+Tw5wV8X1LFAfK7vn7cppo/OV155B/XVyB0S7ZEObZvlQwuTJj7d8cWUcw2dg4zauZAofFiGC+Ed2KnLgU7MLCjOvu38wNp/gLC1ZqYSNE2B/DOkmACBeRhY6AaXjsLSKDGPmREMj5ABYhYikUtlxYS0agvzryxHnLdDN9nQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7CU9jSiuY9ZPBLpSdyqA1vP5SMdIh0w/hKBZH928bk=;
 b=C3z4i8WTMDB0SMtJCrNqI+WwVhnGEon+i2At/OuXR4US0A9YyyH1vpLrTYBe44J/ZAnSwKKjqT8cjlA2o3/+goitNfi29CV4r3vVh/88qOybrq9J8WPnb82qB2M7KvCTkP6gZPq2i6mJRRCj74oA18ThiBw6kYC6Cf7EDBzH+UOlNu2xoMeDyrmvt4zZ1aK8F61WEML93jwpeJDDVh3ZtPL6wO+6BovE5SpBtavK0MMiJt+Hau85lIMc5h8u8QanIkfnZyyQwrDWTaTXlY+D6M+AcVbfgGvenDm9CSJsSRZcJr17UW/8jRrk1EtR/OiJJVKnHCxzZUfDh+QiRiVE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by EAYPR11MB9969.namprd11.prod.outlook.com (2603:10b6:303:2d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:25:59 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:25:58 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 1/5] drm/i915/gem: Count mapped pages in a folio
Date: Thu, 23 Jul 2026 10:25:38 +0000
Message-ID: <20260723102542.3245495-2-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723102542.3245495-1-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|EAYPR11MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: ac93d67e-85ff-4dfa-6ecb-08dee8a4c974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dyRkbkXU5tWLCeCoID9Ii5pG+v+0lhW42q/nmGpfVWUSdwFkhPl01ngG2JX+DJJB/+oWzC0ocoK2iOGnwARppheEqsIDxsN9+0Ewd9FH0ofFUYgH0fJhvsS2mXXF4horiybZGi7fiWLJLPFDXRaj1Exf8oZQOTsfTsgf+IYrbcVaelKkDOIPtOt79qduzFFZnHFuofYtyURkIU4f77ILlfOS0NbdAiVTNkSGv6iYMFtOYPbDKpr7tDkQdcaCC6X+gEtwlJLlaZnheSH5fTa3bePYgB56IXiF8T4Ayvd1Td4fBHe7zcmCsLk3GbmImc0V1v5IMZdAmIPvLkeioK2VoASDgEk1FmfYpP5LbWKhOE7mjSNSP135FcFw3rp/uCepoZoXNiYNOm09uY6gf7aKaQ4nllfyMwF6US9A9AosTmT5xADRfDqNrq6f192Gc3+jrwKc05SYcYK36JAYggy9oLFRVkv6eMLzP9es/Cp+KoT+p+mWxWtYEwjG4au2uZVLdnr9kkoO96B4kp52PPb/0y5XlWlzT3UgOcUieudeA7bdaTlvQKwtym0Ns8hhHDi3uHziZc9y+XsvclVFMvgKBBRmvYJSfEzRUX3kYqJFUb0ZOoUh3Bi3q8GSwFl5cnYQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fpVsOs/3ucarOyTC/A+WVdiE3iH1oD7JTWzeJc1eh1XRGlIBMHfoNj3D8fhg?=
 =?us-ascii?Q?BqdXgjo+/3y/JZjh9mABM44tSOhjwDaLj9Rt995vfYXl4SxPXR4z88QW6rRZ?=
 =?us-ascii?Q?UA0bJPTQijOMnLUvimJSzZKLT9YfbC130hCowOXNYC+3s2k0yNR/5HBUTeqk?=
 =?us-ascii?Q?14jCyzaTPGrFdKzVaBqmPy3poysmqU5oa6mUn+w6IOOKpYj8bjNwvLI0BZ4k?=
 =?us-ascii?Q?Xd/fGgq2zTTmchc856B8DCYAHkTpS+YMBG2D+tjdirQzqfgtw9vGu3ozlwwf?=
 =?us-ascii?Q?j8tHDWU5A3a8GevyZuqxvF/xKJC2H6HbNQuueQWFnHh0ajdi/rY69ZK13Yjk?=
 =?us-ascii?Q?OCD7d137Qv1GPvkWdbGm2k29FfNl7HyBnEhjbvSQ0eSLXWWDqKEytavKY4qN?=
 =?us-ascii?Q?iyxPKgGbz5/OwPtssfU80lg4cGMYdyxPZVPz8hAfeS/zLPGO4TKt/DUNs1T2?=
 =?us-ascii?Q?Mya+SfauoPLVTU+LXYs5+PW8YvvNXSoXgMUIvYdgCSRvyDYcGuMhi11qlZgy?=
 =?us-ascii?Q?BmvHdO7/zEwhZSWYeEe6320xoB3jUfJ/LX7kKvSSF7iC7toAtQChm7/NmmXr?=
 =?us-ascii?Q?eSzA09wWjD6yXifbM9qx2eZ+m/CAkzcOIsSeob/rI/FCDBkwGqA8v0jqvBg+?=
 =?us-ascii?Q?o8s26czRGlpq0TBgrsI3qRQ1YCw4gm02u2fVwRZirgXvJ0Meiuoz8iFJLvBC?=
 =?us-ascii?Q?FF1j4EbxTvDADU6x6p1xRBUs0W4luHz9szCY+1qs8i/Zu9K9y8UeuLbA7sBn?=
 =?us-ascii?Q?neVsXEpqRz1ktaGSd8CTBkkOxhrjqxl7n2TEQ4tXKArTl8rNCwPhNH5uD7Lg?=
 =?us-ascii?Q?JqnIVmbS68NqqSa0FDSudRjZ8jWp8G/oPNJwht2KeKJj7VnIyxMMTDXj7bvz?=
 =?us-ascii?Q?dsPOJ6+n29wQoZfOdhTN5sEXBBrTe1vlWwSLb0lM1KBNBmfIJHd3qsmmx4t+?=
 =?us-ascii?Q?xKoGzGbc3WBVu/Zvs6zjPV9y57dM0W4LmHXzyLT3tsrDOTRsn5gjtt3gSDzr?=
 =?us-ascii?Q?kN2+T6dA1pYgzZssAT3nb4zmpVcO246RRGJeC9kn1FAeEe6PEH2b5QD3DZMn?=
 =?us-ascii?Q?Y3b2zHKb0cMn+wppX/2x/VKiads0dBjMCjXua0q3B62m5OAViY6Tk5txEf4r?=
 =?us-ascii?Q?ei6SQ9U3W9wXp+9CurAUfJpzMnf9WyjpASm5/JJBcgHF13+iaWzYBeBUeAMs?=
 =?us-ascii?Q?937HMkxor613w3+zrr5Pkuaw+mxvHHQxMxFsWLxjJjYxElrUMWcAsmzJS2lS?=
 =?us-ascii?Q?V4L0qbt/JKvOXtfOL/51cq9hiLBX8YEvXCxnT/8evZfYHejQPTHNqTpRqL5w?=
 =?us-ascii?Q?5WB5wI9NBAtZW2Y4OWRLgu9PmIsonAQpwVeK90rbHkDfbhX7w0i6HTtQjSQd?=
 =?us-ascii?Q?VKH1f0dua/4KHPSdozvPN4zt33tGr7E7dQ0YEnojTLCYeu2m8D4IRBMdUJbG?=
 =?us-ascii?Q?VJf2eNwJCGcNe0cPlpcVksJ0RWzm12mCEzJb/j9SotwISblYEN0sy4kIbBFz?=
 =?us-ascii?Q?bRVz6YV9TVZXXDkp5QJ59nYpqe0Hqjj5RW1dCV9xksoFZLGj0ttuUsx9D+HQ?=
 =?us-ascii?Q?Hx3yB7nYkkomcyJatucdJLIaAmK+uR3HQHC+DxIh3mnFQS+uvaT5Gi2dLvEO?=
 =?us-ascii?Q?ByG6Om9WrrmIf9CoISiNXv+Vjca17IBhAnfF5reTCEvpwC6FZjzL1ycdyo5C?=
 =?us-ascii?Q?8dHwFg7Luap4Qd3avMFr0xs7kXdLyOxoQYgsSw5BD01+CEf8SwPa0ppkbeIP?=
 =?us-ascii?Q?L5s2kZKYWPUzBdkKtGM6WhGcAILOWlg=3D?=
X-Exchange-RoutingPolicyChecked: O1MRsM9AXbogYS7QwxWlewpZI0WTgjgfvbtH8hLADu1L5m3mZagEEEEpYrUd+vmvKge8vIqaFKAlLWJrLdkngT1TIZxaPenozOSoT6nNHRjCbQhbeDRohkcZ+wwA9Gr286icHpo3x0Jz0ojDii+fbjeznptTyVJ+1NsKSxbg2FgKKRK39SnQZRHnvNPiRXvnAdULxmzismXT31g2wus+zO1pzEydldy0T9/AhVpIWFmmztK79iYkrZ/bq2Ri5dEUsOOYcJvzDXty1a4PMIu4fgwQqpmImMgVra6Q8hNCN1v1Oof4ZsaZ2K93Eq1qAvDTSIWIDj57jE1KZu2JU4y53g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac93d67e-85ff-4dfa-6ecb-08dee8a4c974
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:25:58.6973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U692AESxkvIC3uieM+W9l2Wi9udNe+PL94LCGifKJd6D22eJVL+PVz0ZPUw4AcGXmpW4CoQt010oyNfE+blm1iEIIu4h3ZG3VAGui9rtc9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9969
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

Track how many pages have already been counted in a folio and
use that number as an offset on consecutive allocations from the
same folio to ensure it is fully covered before reading next
folio.

Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterlist length")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
 * Rewrote commit message to be more explicit about the problem
  (Janusz);
 * Moved max_segment validation to the beginning of the function
  (Janusz);

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 123 ++++++++++++++--------
 1 file changed, 77 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 06543ae60706..af195db63038 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -68,10 +68,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 unsigned int max_segment)
 {
 	unsigned int page_count; /* restricted by sg_alloc_table */
-	unsigned long i;
+	unsigned long next_pfn = 0; /* suppress gcc warning */
+	unsigned long folio_start = 0;
+	unsigned long folio_end = 0;
+	struct folio *folio = NULL;
 	struct scatterlist *sg;
-	unsigned long next_pfn = 0;	/* suppress gcc warning */
 	gfp_t noreclaim;
+	unsigned long i;
 	int ret;
 
 	if (overflows_type(size / PAGE_SIZE, page_count))
@@ -88,6 +91,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
 		return -ENOMEM;
 
+	if (max_segment < PAGE_SIZE)
+		return -EINVAL;
+
 	/*
 	 * Get the list of pages out of our struct file.  They'll be pinned
 	 * at this point until we release them.
@@ -101,7 +107,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	sg = st->sgl;
 	st->nents = 0;
 	for (i = 0; i < page_count; i++) {
-		struct folio *folio;
+		unsigned long folio_page_index = 0;
 		unsigned long nr_pages;
 		const unsigned int shrink[] = {
 			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
@@ -109,71 +115,95 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
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
+		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
+			ret = -EINVAL;
+			folio_put(folio);
+			goto err_sg;
+		}
 
 		nr_pages = min_array(((unsigned long[]) {
-					folio_nr_pages(folio),
+					folio_nr_pages(folio) - folio_page_index,
 					page_count - i,
 					max_segment / PAGE_SIZE,
 				      }), 3);
 
 		if (!i ||
 		    sg->length >= max_segment ||
-		    folio_pfn(folio) != next_pfn) {
+		    folio_pfn(folio) + folio_page_index != next_pfn) {
 			if (i)
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
 			nr_pages = min_t(unsigned long, nr_pages,
 					 (max_segment - sg->length) / PAGE_SIZE);
 
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
@@ -186,6 +216,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	i915_sg_trim(st);
 
 	return 0;
+
 err_sg:
 	sg_mark_end(sg);
 	if (sg != st->sgl) {
-- 
2.34.1

