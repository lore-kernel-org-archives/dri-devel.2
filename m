Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B08C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DEC10F08F;
	Thu, 23 Jul 2026 10:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a751lsj8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B1F10F078;
 Thu, 23 Jul 2026 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802451; x=1816338451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ZsM8dLzIFx7S0bA9KmnUrxKCiJ9/sGr2t4l1o8PQfDo=;
 b=a751lsj8I9v3tpOgCjyxl6ybO5oO/Ji0ZFLSodR+b4g3q3BxHQtsAIpm
 QY/pL5v3rl0UetO5DDsMRmD01CL+KC33ut+jJPVsqJLKZ6++9BU3onWaJ
 uBn7/kMtsafl1J7VY+L0qmuEv0nSAIBsG9xsLj+v1GZrOrlynThp23FhM
 m0gJbRmXjjzbSKK3x4BV++zr2CGVhw0rmLHRRq+CI+Vb4JtsvWEzXAeU7
 MRk7gCYK9o3YjEOQmQkNBm5LDyb0HwNT5/+jwSzDNxOmFat51LDJNlGet
 M9djIfrRiVYYMtvCD50aO/Z3Z2bUXI6aF3TvjxnUXHr3+L+KvmoxXT8MF g==;
X-CSE-ConnectionGUID: 9IOP821BQnmzk0jcAY5oxA==
X-CSE-MsgGUID: FUxGKGg0RayHHcmwJDxJYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="87995345"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="87995345"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:12 -0700
X-CSE-ConnectionGUID: 9nEGGXdLQ6mRQrILH1dmhg==
X-CSE-MsgGUID: prhPuoIFQn63+c/A80I55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="296588888"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:26:12 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxp2pH3ICQGH4h4sRTi04AFjJVKC5iqJNK3Dw5MPXxbQEqR8kxBYBjUX2IVd6eOVKv9EQ/L/C/b3lOT8m6f4eNvYhi8QiCKDHNr7+yb/KGCpS0+DoocsrNvL60rIJcoj7tGIvzW7Hwlf24BexTuL2qRsYK8DwdrqyKhKFOoUutud41DGw5uzB49/4/Bt2o6rNbW1DcYBJf4Mye8G2+wO/KQcEhHkx2nQVQun3tusfASD5FTFcofciqiEu8BLpcCIhpbM+rG+8Z5pKY0qFNNIdeqmUi5EIL7mjtC+B9HqlbF03SNBifFxkSIP9YYpWeKLTafz+a1C8fclPeJNR0pxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnG7tAqUP8e94hs/+nL9nbat0w004XZngvFtDkPtpnc=;
 b=JjlngvtBiEK1Z2XfIcFkRZ1P7/B2buRqs+jROyG47rcazeFZnNokKP4MQmNqWmKJy7C2X2l4I4wMteZyfweQoJZ7H91SSFWqx/iw3s4dOXsZ9aeN0y+jm7yA38/pA/EYJKFIyAgDaKHUYXHY25Qu/AvHDkTjdIxepb0DfUkFMdz6K0Mywdxwyusstvg7+Iv3B8nNNwPZkA5Cwq+wFR19O/+Cu/QQ8fJpxJI2t89MvsmK9EccU5PW2DY08pLxV+43imkrOVnvkHPW80lm6TvghooXr+nI2VYQzLuPE4ONiMAGw00iLE0mM2Ioh2/6v5boSrhBuz8lt1nF4pgasXFH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by EAYPR11MB9969.namprd11.prod.outlook.com (2603:10b6:303:2d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:26:10 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:26:09 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 4/5] drm/i915/gem: Read and shrink memory in a separate
 function
Date: Thu, 23 Jul 2026 10:25:41 +0000
Message-ID: <20260723102542.3245495-5-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: b401769e-6241-4106-8664-08dee8a4d016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yQNNMpEvHs8woZIJLEHObGFD96Wu5+5my3/8gWbZsnCTvDiEHNkoWEmbSewF7jIiCrylvJQEhklZRw5RbnshWxJKyxv7T50WPRyU2sy9PYNPZ7mVF2ik7lAR6+g8Q3HHHklKApN/5jQ0Is+Y2Ml9Tdm87Y1Fn20dLN1ije6DEhSlzDamD322t2OodxVTFXtjNac+5s3+3QSmLSfQ6E5zkfO8PqYMR4zk/8/OZ71Gxv3mFdkrvjn0VykQFuSuj8v2oCEt3of8QnV/jkQ1CtTnLeKMFYTEfdH3Hm0+6Kx6g2cRCWhNJQd1xfxaFAWjANGV+OPe/J6zVPg2ggHrhQ6iVKHFFYHSzk1xxSxWIRR3qm2yvV1CBCyH/96bi1NhAX7UoeDWSh+//Dsd9PEalQHF/wmyoq9GToETVT6cSRkn5gysN83HZlSEpOIqQRfigw+t8mrdVw5Cey3c38mIggoSPlIVau4B1osjzYsyb6j4H/DYOEGWkG6YKqglK2qbSdU0V5gfQwJTCPTm6uT3iMSCWcpuJ8kF8shTM3HS98n+XV7dZAx+592Qh6bbG4QPcwxFUs4ixk4rXOnYZA6u40UcjP55PklGmCpCVV7i8Dhw2f2hCgE1DIkthLHqgBAgtRuvcpjJhY+o1SjRM3a1e1+d0JRYWa/wSE0KPNGu+qQmHDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vh83CSMKGNJXKBMYorskZHeogwjFw6nK0Q7TbuX488mMpIHPOenPVE8nOah9?=
 =?us-ascii?Q?cHRJ9Dh3n6oDXxD5jLr3WzBOC0g2jKJnt85wz9/Z6XxGZktaLFzntB/VXl0T?=
 =?us-ascii?Q?dZ+wA2Jt4wp36Rc9iFfE5rFW3B88yRKxaSbsCtPPQJ7143i7P5ZoxpwkQm8G?=
 =?us-ascii?Q?st3qGOl1ppNClGEuAjXzpKRBrUcVI2jJgvS4PfpdGknWXMTfW5r+MSGSq7nj?=
 =?us-ascii?Q?/GRYxyylDfjMehNUgZk+qCWwDHtI4Yeoa8F2UCTpOsXSme68q0Cxcl1PkKhF?=
 =?us-ascii?Q?/k9RfVshtktArcwplKqiTcraKm7h01jyXbZ00T86JcZzcE3yP56ijywvWrGy?=
 =?us-ascii?Q?L2ZV/lmVc08Xu31qu0yro28DmyyMKlr7OQ/b//GA04oxogfewX7qgnvsPcRA?=
 =?us-ascii?Q?67A5b5jtDTRVN3xTbR5Qf02aHt+G7R8ooU6tKQrvcJ4HvjRTeO+Oe1LhSnu0?=
 =?us-ascii?Q?6Pl7F0yKFiF/pyF67rmvfw4XPFZc6JycdIh9W23d/bmCDz/1UdVOpn1NKyBm?=
 =?us-ascii?Q?NH8Jc6VGf/kalVRVwuHF13k8dybFPmpgGTEhK/fu8w+xY2cd1LMAUqpKblx+?=
 =?us-ascii?Q?8YL3JGaFCrqHOHkH0PLrePDItrV7uLEKvnQIMaq0yrd9F0a1E6r20jV27pb1?=
 =?us-ascii?Q?EihgXUPNVoJXhQ5WjFoIUru7H3+MYKUqVpVC1YzLAlTU1CsfQPT2jBJRneXD?=
 =?us-ascii?Q?THd19bW4t501TFEmMi8mKlAG4Dl1B+izW9T+GXgqRfaj4CumDMCWAQ0Lv0v5?=
 =?us-ascii?Q?fIIQZ2kwT1n4NuPgl9R96dhunQqlojQvXCn55/H8EzRQkDwRg34c79LfFY6Z?=
 =?us-ascii?Q?Pljx4Oa682+2nVi6OHkyfqtBv777v4J7sXS+uPf2A2+J3mvoNDO+q7Krd3fw?=
 =?us-ascii?Q?sXBHQIawQDHAmRQcJ2IfpFYnVWukHCk8zxRgSgATxwv7wspTeQg/EAcOlFNB?=
 =?us-ascii?Q?366zIlb3NmBrDVuy19BG3Zq6OLmHxczPUyIMssHzKfTgYqFot3LNOGPHyTBf?=
 =?us-ascii?Q?1oP004RpDmEvh7GkmkxmOMw6zcfvstOdHxGFcp5KeBJysbHv+okGd62tn0wG?=
 =?us-ascii?Q?RxtbWga/oHPXLHOZAHt4wrHdGrJbMLReLm9iVraE+iQku7CyRjSnZDzUyrne?=
 =?us-ascii?Q?nCzl6Qu6fAVhP2tHe5pnvJbKJP+vzyr2AucIHS4F/o+ZEinFQTZaL7ZORg1z?=
 =?us-ascii?Q?kpIjkgVA7vAnM/SCsoO9yaOLJViN/Z1xonXefH+km0v+ZLIa0iPrXZ1bxRQv?=
 =?us-ascii?Q?0T00+tk+ciH5euB2+JcNqMBM9HyKfFL8LFS412xU1uVjcdDGekWf1kqV0q5z?=
 =?us-ascii?Q?T4fYWkeMtpT65fwDux+jZYr08UkxRcTkoO2ciwytGNZdZeZExQS56H4zcnoB?=
 =?us-ascii?Q?2Nyz2pd0ONdOuvp9bTpgINxfPnD7XQv7F1A8lEf7zVwtlU+FRGRy2YhVHfkY?=
 =?us-ascii?Q?8+V34ZleEBoDrc5zJslPxVR9KuStSSCSoorD4IpacKppi+wK6pC6DP62vymx?=
 =?us-ascii?Q?F2MIhyO0A4u4aqZWAaXWUb81AwQZeKU6T3abZgBz8ezadK/1cy8+O0ctcBHN?=
 =?us-ascii?Q?KES+n/9hPgSUUrwFpRBGdunkieoalnFEl+JORZqN3hJdXXgjtpwC4fRQTvQZ?=
 =?us-ascii?Q?d5AW/yF2DZSAdA7mNb3M9AGfxNYoZvo1KVffEJCJ66YoWt7yUeYX9Gek4vla?=
 =?us-ascii?Q?4KrNTOD+T/tc7HDf/08NLRUkOBJu+oZ+0BMK4gTxp3WFRIgTTgcYIId+Av+5?=
 =?us-ascii?Q?vpSyAVsT91YPBa6c2ztFHm16N9qkw80=3D?=
X-Exchange-RoutingPolicyChecked: hw14WBKJQjcSMDSJNqILSaNrN9+57uj8bLE74kM5pRJvNtQUZKB8z1dbIclMgeVHsikqGF0/6XxaRZOxJatzjNZGHA19H6J8TxnPXHRqQc+qXlCAAy17azh0LBjAzblzN01H2u2lj3WFbQysYO6goetYovmfIjeYahI2EUInMT8Pm0cFpaDntWjWbU6C60Tq+Uo58h3lbRuTbSuFPLnFAZLlf6q/FakZuHpCCQvMNCHhaq0a5sjwq5Hf4qZiJ6+pq4ASAAjKS1vJijAKsawjvXWcrAuS1OEBJvxDfogJTKdg5898hUUl4bMU0wLAf9ZoJI0Gld1MX52Ak4S9z0aMdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b401769e-6241-4106-8664-08dee8a4d016
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:26:09.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtF7K4QRzVxvDKI2ZE8X7Oeqsl28d1Zha3no6yTbhdlSeZEPCT25hFYjXpRzFsG3b3fA618eVlNkUfLFUKT67SkbGqWuh8NwGhjGAoOQ0e4=
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

Continue unloading shmem_sg_alloc_table by placing reading
folios and shrink call into a new helper.
Remove the loop, since calling shrink multiple times does not
bring any benefits.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
 * Removed do-while loop;

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 103 ++++++++++++----------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index f35b7efa1fc2..ac8022997553 100644
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
-				* We've tried hard to allocate the memory by reaping
-				* our own buffer, now let the real VM do its job and
-				* go down in flames if truly OOM.
-				*
-				* However, since graphics tend to be disposable,
-				* defer the oom here by reporting the ENOMEM back
-				* to userspace.
-				*/
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

