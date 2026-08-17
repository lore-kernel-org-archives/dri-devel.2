Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11FFC5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9D810E71F;
	Mon, 17 Aug 2026 09:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O0s1wHnM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EF610E713;
 Mon, 17 Aug 2026 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786960632; x=1818496632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=pnDnNyDCDD4Ny/EcChx7dq8tzjtphsFoNXy8drwTGlc=;
 b=O0s1wHnMBzL274qentnBmbcp3G7gOHb/rAVZgpkzLACqD8XNCNxpMf6F
 ntIm9BuZNZ/rCoJqo7K8RsFq7phGXkhOXLGFA6cKFQT3YIdeo2vPFgwjN
 83VyxPv4UJN/s6v+9fVt6AONPboMxgAdWc2Sn0PN/Tjapcd7cmxqoDu5m
 rLOskY1SDVaBihHvihCVRH8qjibk/lX3I74sR6aiYFnMg6vno7lPFsCKg
 DzBA2VgMPJnqZvvQwTjUj27vV9nXDXaIfI3SVMC+/XE4SWpEqIAvJdYnP
 lYa+7ZDIlgIUhcd28vBP6McGP5WtKyo0aHKVO0Su/YlwC9uF/ik7VbIGh w==;
X-CSE-ConnectionGUID: IEGmVb1IQEuILKgzsj1lbw==
X-CSE-MsgGUID: 7m1NWmY2SbWeKKTA38y2gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98093761"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="98093761"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:12 -0700
X-CSE-ConnectionGUID: DUl0Lo5rQsmHWU0l9b6xlA==
X-CSE-MsgGUID: 9918RsLXTgWjc8wNz0wKRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="268713779"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:57:11 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ray+OGwkmNgDoFGmmA8tIh93e83KdTa5QGsY5fdl4KkW35Rz9rPWXpm2pscJm2TkOd+kJYEeoOJmUdnMl82EJJ7UhWAAf/w+/qrywCq9kR5P/4uGXBaELhMtcOzMIrgwPqcmxrkRO+ezqRRIFCEcd0zqDF7UgY6iC9wU8auEj/GDvPc875xncJRlwPyVP/ZMeWOuVMvqFpMv1RE/xjBiCS0mtUvs6LeqfxYpf+tQkcmH9mpIjqEtFJ7NXutgTVAHkECOJIE+jVjWF+2BcYSa2qhzMZSwMHMpOMN8YHEio8bykDlLRfukfgq9bxybv2cKc0bFTD01dIZ5gOBNHcry/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FydegKusX3ZlZsUsU6duiAf/wwkn0UuKxXsX1chNo/8=;
 b=lll/Q8RvlRU6NuZxT+tAO4ND3O2XWI6+iT9aZIHi3/RJM1fG5IKKs3jmNhRjf7TpLzDSarlYTycvsG3KeyNzXu6hUQuBijeLzRXm8yBwOcALMNKQwQHvtrmz3SJiTT6T7g4Lwbo2dwoAonPSl80GAAUhAaA7N2gfG/FNEcJaKD6b/AxNL8Bf3N90DFQdELNdTRyJcN8bLREl53Xc165XtYICFajvQXj4JYB2JqljIpyPrgwazv9FbO/FAt76xBbNmnh9GJW48wQmNMjvMEYe8ENbvz3liviTcOwDxIqHS0zEcpgDmME7t3/IbdBfZIouDk+IY2TkoTikwUeTnQgbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:57:08 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:57:07 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 4/6] drm/i915/gem: Pull out size validation into a separate
 function
Date: Mon, 17 Aug 2026 09:56:46 +0000
Message-ID: <20260817095648.2438192-5-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54c5ae79-55ab-4bae-a594-08defc45e62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JOkbn/UGBIxS0/OGJ0A+2fSgvxsU5csV0/QvEOH4wjCVat7l1fhKDndFW/Eo/hO8iyfDLNP6BG5OXsvNDPCZFGYMlMllIxI8tall2ZBOjTuhW3xOW7/E2Rmk2HM9lPXIgnh73MV62YaD2PKS867i5DS1p/tcP3v013AP63ZzLF0hfGH6CSVCi8enTX7MxPDOVM7I8K4S49pnzhLEA8N+fJBSYnF305PuNPacuwbma9ckfF9+MKMuKZVXw63L/WK4WwQFeMGelwereQTc08SqitW2N+UuohM4/6Jyb7eiUrkm0YtjJBLV4rpMwOyAEZ6MfSaD6MnCfgvTP/cN5/a1ePKAd/XKJqfHGw0X+6IuVosmpqxzNsqgcZxXHlYZ1ht+5Wz+HQMV9fO60sLK3EqfgTVSsrVxgDrzfmh6NzWSx7Y3fET+/Qe5XwFpzAg/n9Bg0IRnbvI7AygnsoJa9R35zMqACYbnxgbVGrHFjTMl/h7a84mBl4weQeKtymXXE8V2zycXjJsEcLdoLe0Gd+xBfc4YcayuQbvAdxn1d7eNuX6bMT46sQ8ymwkgUWBUM96+v24iXvSMRCBJrb8M+/jZJq2nLllENSOSYPW2L2z2qUgYXyMyo7Cmpq5q0eVIygIK6arVEe0ci7mn/04areTo2Ws1DB7Dz/lF6cQzMmEJwEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GpoF8lFv7Eu9qA3LNRwcN7H93bs8bG1yqkNO+Yc/mLN4uWWALIbQ4NoXqryk?=
 =?us-ascii?Q?h5P6fA37SywqXPc+6nUcn3Ci+1WUTRXNwfuiOv8Qv4oXyWTT4EZ85/9jtu+g?=
 =?us-ascii?Q?oIPT78TRZuMUz3hN7PmhnhqoG9BrHvfQRJ1AFt2ss0fVOLktkkNlV6j8roLf?=
 =?us-ascii?Q?OBJE0zWUHbHxCXoDYJZCOoecUvrhRE3HH4gmj/lCLPxX0fS+iumenUJ6Sw72?=
 =?us-ascii?Q?SgVKdnoKl2LIieK4zIUIHlpPv4OHmwmWHAJ4+yNidpVrf6UlPU5prKgB+wK0?=
 =?us-ascii?Q?EaBUenIZoLHhtLnZen+nkgGSk9IxxVK1IK3E9nvYnqx2pMO7q3C5MDdSJFWZ?=
 =?us-ascii?Q?JFEkAD3UTvVYP5EM5PLgNZSyEG3xDPFCmN/PiuxuLx93hneDjJYXHRbuvKT5?=
 =?us-ascii?Q?IsfnyEq2QfsofhAqJuOWdEVwcbdvfv8PA239j82iyx9FGr5GU5FCdb3QgOCt?=
 =?us-ascii?Q?0WK5YovdhowuJ9GaLEVTEk7mwA32l9tHyv0ob7w/NRrzi6mY4uGwTyYoA0sb?=
 =?us-ascii?Q?Vqn3Glm/D81NBFeLPgYXDCHuJ/Jkk52/zMwXFq5vEOAWBJmIVlj+6nrO+9Ha?=
 =?us-ascii?Q?edrSmHNkPZo6BbIdQr7xp4SfNd8RXLtlhRQ/gS78qFWYXMrF5LZq3ti2VpXx?=
 =?us-ascii?Q?Wvz+R+iR1amHW3J8HJ/Vxf6m44GKayoml56UXkGrhPKH4N27N/z0GB9iKfZW?=
 =?us-ascii?Q?R9Vthz1aHHC8Rge7pAjxkVw41BkfqyvZP9drVhJzgmGlivggyjUjTwT2hhgf?=
 =?us-ascii?Q?E+ICxsFvma5u1vU8yKl6axRK6te1re+JLc+lrSySl7voa6J51jejEI4N5/sA?=
 =?us-ascii?Q?5lCaCO8YILQskQm5xAUYsrSdrf3FXNeRenmsJjn5Gz4QPdlTiknZ22ggZ5C0?=
 =?us-ascii?Q?AgFv7qNqhTl+Jo9g9dGOiOv5zEmv/bXmYhRzT840OK+WpyMA1EtP5Jst/CFI?=
 =?us-ascii?Q?gCHIdMMHoh83lD476TtPlkBy8BmCcsGVSgkBEkVMqiSjiUSQ8qe182i3tALl?=
 =?us-ascii?Q?PwC28u9fua01kBY3HJoo0dp/j25P4DrwdankNqooja/M9Fp/S5soGbPv4BqF?=
 =?us-ascii?Q?ve3pshQp/lTL+RkhreqWsDbK4njN3noPoWvOb1aWKXCyiLK48DZqNl8g6csJ?=
 =?us-ascii?Q?vNnQy50fJNl6g5JLF5YCqOKwSpYvLWPbHTq7u4isZYY65/AgYoZpjkl0iYob?=
 =?us-ascii?Q?Y9gYDv0aht/lgSa/1q9y8P9IqunmTOVkHBnC04WCOrPZq7KfPAaxB64p2+A4?=
 =?us-ascii?Q?cWmm71ufmQYBKN0yZZsyMi8vviZyQ8G/DAqb+kuTAq7eM4wOUt5ntWCuzTjb?=
 =?us-ascii?Q?6q40+qKP0TTPyhYyU+U3jXCLMNoBnP8E5o4fw80e4VuosFM3oAFbYt+cWzvB?=
 =?us-ascii?Q?bvg1E6VSN/m2BDsNHnHnQcDTLQn11z9GvlVs7zx5l3H+SAqpbWtvuP2E6J91?=
 =?us-ascii?Q?yVO983/zbpV7ygZJHUct3LF6QS5X22GTajbudnXKba4OpsOsR+SYxysvJZ5N?=
 =?us-ascii?Q?OakIccgKw80HO3HV6bYDXjFWMRDATiJoT2pSI0WDCbk7kO6x6TKAJ3vtow1c?=
 =?us-ascii?Q?KA5b7w8UUw7yw6P9xTbNqsc8CiFoDT28WfLKeQ4Rb/kY0eGZcNp7abtqGNSj?=
 =?us-ascii?Q?kLrOt251Fjrym2qNdU4X0c5K3rnwBZq0DWeklkb7zp+OIOUNgXkTpoFQjzd8?=
 =?us-ascii?Q?eiO41IbA7usm0Slvv48t+Rvjuwrp86uecJmeFqMxuimAfC+NHb1m+oDIiiEW?=
 =?us-ascii?Q?DDu32bZNOq/zTVGsSuBLjyr3J4jzqIQ=3D?=
X-Exchange-RoutingPolicyChecked: ber8vwSmBsrokIbOH3Ne9o+JeJmwXYddQXa3VjFDWyYD3PU6btCIpi1p/pNn4ojLn+kf8WYBkrM4kV16zbKsZlzgMKJVpi86N6HzTJDfgdgwP5ffbjbboS9l+Cc/a3oG2ibIm0ICjiXr7XRMPLd+KT8r373PRuxoabXlcgXFGHu28udbWvPlWSgpG5zmbq8JHWc5//Ecn0GMRML+I9DNNJZjNya5GXY+8wp/PnUqY7Pp6vGlYWmTPYWrcdWmATQAYFNL3443zWWEaoqa1sJ0Hw1LeUuhoD4q1xo9XgC38TRR4T9uB3vbmi3ySG74OahaOiyqc1wJywoDXTsJYdbsHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c5ae79-55ab-4bae-a594-08defc45e62b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:57:07.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBcUh+8+Aji0wrIFIt1Dn5RuajEpwYcksHFzh2OwALevOO4V/5JLyiZocyBzowgdfVsJrOFEhC1zJW6LzLKm19UwQiLLCn18jZ2Bt8lr9+Q=
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

shmem_sg_alloc_table is a very large and hard to read function,
so reduce the number of operations it is responsible for by
placing "size" validation in a new helper.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index d6243f4e51ab..b63a9395306d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -62,6 +62,23 @@ void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
 	sg_free_table(st);
 }
 
+static int set_page_count_from_size(size_t size, unsigned int *page_count,
+			 struct intel_memory_region *mr)
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
@@ -77,16 +94,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	unsigned long i;
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
+	ret = set_page_count_from_size(size, &page_count, mr);
+	if (ret < 0)
+		return ret;
 
 	if (max_segment < PAGE_SIZE)
 		return -EINVAL;
-- 
2.34.1

