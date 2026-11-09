Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FBE606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FNbQp1Yn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DAE10F1C0;
	Mon,  9 Nov 2026 11:38:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C68910F1B6;
 Mon,  9 Nov 2026 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794224308; x=1825760308;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=7zm+L2E/owCGiAriWvK28KEWCLrXPEWz34BX5YY/rXo=;
 b=FNbQp1Yn3PQGpmmEQFeo2welrGm7eZAtXEmxS64OM1XvVFDZKhqPuSfM
 uUjXAcqxjaimKpB7tQYRkHf4YFYEpJ5yAgzU9JlQxohsoHZpLZ2dCdIcA
 55zN0U9pwm/ErkvWMVWFeELXHJG7ajGBAaOORhPuvat3QvPNVJlalC8WG
 kGMaPCW+CuD762yUoVMCsLzYRd3iTVXss9+qBLCkK5ITAmuKf8uQ7p0l6
 8cw5zVDyvoaGUTY5BZGzjsJzXEfE5UXb+JepPOu1TSQ9SkFa5FQ0UpBZh
 qqQG16vfylUTaU+UR0wLZiPDz+XRjJcFZP7I5kcywFQYw1LZKYvvH473T A==;
X-CSE-ConnectionGUID: GlWhHkILS5OgJazmilVyAw==
X-CSE-MsgGUID: yOSEehWsQCOQDMbCu+c92w==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2938504"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2938504"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:27 -0800
X-CSE-ConnectionGUID: yR5uBaLOQ8esv5QFcDYdkg==
X-CSE-MsgGUID: 0bziJUTjQDOmMkap5ASKNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8282656"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:27 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:38:26 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlK1KpAQdNS1NFs8Ia3Q+ozT/cnxXH1SQEZyvqh6HrsngKWnGSNuZkguClKiFEguUbggnSw0PEDRWVf01AiBrJl+GMTYAD2alzq2w1I12ihRBWxcUdi/Ys3R1LeuBoJJ01d11LmzS24mazTb08uC4EXdMgXBdiOGvV51AVQlWTEj+iVv7Jwk+8GxGU11z0u7HRjzUNE+Nv4U9Z4hePOBjTc56ZYIm3ue9wTI0Fay+ekzgdQ3HIKIeTRdeQ/hBlQqe5LDjdEKrHLczH0si2yrufS80RnmtCHbnCvd75SGkRdyhecN22Mb32Yeo0GX+/LiyTY8CDzvKIgy8SxbVrMADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGUjOPHyBcoryjfYVyYJ3dO0ekWBlJvumAjeOj5F6IY=;
 b=QXWqnpyuk5OaB6eAK+gX6ERJeHfzQ+IuKeB048O6h3mJsDLp3DstL/5LvnDrVqPfbpziqloouaH2XzwaQ62woxJORI54X7UNB7J7PSv97FqvP71+vyKJqwZRjUC0xP1MDnZ99+G1y7xjEf+szei9zwY6lDVItSvVF8w+zxJD5JmkDsaxe4D5oh6ZxLX1RDCIqDgH8s2tHxhqpD3nkG+9qUmqA83LEcO5wn+sAPPalMdZ8/kyulKRi+tpNm+Mo0t4XxClmFv+FlMUflwlf4XQM8T+tg3eBwG4EtNoCmbIA6fryKNRnD0dFcvUy+Nk6LCL3GfK2KAE/V9uLgczzN2X1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7199.namprd11.prod.outlook.com
 (2603:10b6:208:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:38:23 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:38:23 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v8 5/6] drm/i915/gem: Read and shrink memory in a separate
 function
Date: Mon, 9 Nov 2026 11:37:57 +0000
Message-ID: <20261109113758.1491891-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7c1b614-8fc5-45d6-3c68-08df3e55f5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|6133799003|10067099003|3023799007|11063799006|56012099006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: +62KBb61nwh5MkHSP93AZTlf5kVwluCLGKzqUXeMIcSeBZaNHRT2oSGx4JYxj78RXOsZ3Dh+ZviVFnNmgarbJmDpElIwyD59TtdYiI6FitzlFHNII4dp0TPnRGx+WjGrrt3zz7Qw3uARYnxhsCnDQSlMW8ZjnOPuEZHbVt92+54HctNNce1vOkbBlFXWnQ/Kc1MoMGmKgaMQsTv3LfnIMJ6DiOzYWRSkrJfD/gkdQjyTVQwZn08vHNQCSpuuL4omp4Uu29Z1Xo/RFnjWX4kOnrX4cZ9zWLER4uvLNCZnnVqlRWvjrYkDUjuOzKzjFj6Y7HY47rYzao/nlujtgi5Eim0DQm+D/MBFKAQXDJOik8471nS6TKybZDaTpTwJM1Nnr0N5l26R8t3H3Yc+j1DdjBDW8jo0Cf9pyWzDSe7mij5k9i2KjakxRhgVETqvnOQ7/tiCjTRDmJXNuLXUqO+K4aRZTOBpBI7SKFect33UWGkkfUNzRsAxZcOj5lXEIK1qRQy5H/YO5S+jXDc6zcxxclBSj+ssT05ygGg2mnPimJDSWkiXvFHzdk7UM+zA9diUE+N9wbZpj8Xj291lc9tcT6xQQKzIgMpbTJ5LGtt8Rz1+bHvjBbj+Vnp3FAZ7S4T1uTw/Z/O8j+aB8NpAdZZ0trgd3PAs15IQvcPgZ2eMU+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lPUY8wFG63X3SVVlhk+KDZ84nHT2+JhjLmyL5Yydfd8zAgz/1vMkLTo+Ah//?=
 =?us-ascii?Q?dRa4uon7/W35etVYh6M2GzF6bnOFlHyVjYz47MMQjEK0HIDoN9LaSGqbdTF6?=
 =?us-ascii?Q?Wn53PvFl+NuTZSmGprP1+RBJW5gC3ne9oRQ85/1SVspfkN3VFR4dtRMec+xk?=
 =?us-ascii?Q?vU51V7r7gAF7j+1rCf4R8GOvqaCs/c+QcGZDGWB50jISmOdWJemZAhWZgfRZ?=
 =?us-ascii?Q?UcVetMLAn1IjRcDJcgnAkkCehrlybZnkcKoheNloVDK/MGTTGJ5aG9U1GWVK?=
 =?us-ascii?Q?yX1U23CM/sN4BdaxWu6A6nQD9LtyJ6cjPAxpF2O4LZRA8ooGstGiOaWku3Eo?=
 =?us-ascii?Q?SABOEXoEz3OzlpW7k6aJquTMdh8PPGjt1P481fgOA+MPAkc0h3XdcWIXgR/t?=
 =?us-ascii?Q?YGqZqqvNjfYxsLOr+hZULIipKoAUC6Q1l9CO2iJwDXv92QG8Z2qsSmKryXpp?=
 =?us-ascii?Q?+tvJk9WrYHnWzyqdqJQ9nBpjmgeuo2TkXwJj/uVu6jWyq+ea7sLG659zK5c5?=
 =?us-ascii?Q?6YrxPh2UCBQazKJXAS9VfQeHjKiDDupfsRihJLHfCyqNa7IIUUkqymDZdNTy?=
 =?us-ascii?Q?9Mq4a/x+Gy8VB5hVOfrDqfw5SacOdMxxlQLVvegUAYVlBE36UXPf5/2yts1P?=
 =?us-ascii?Q?65tbyC/hqjjgFuyioBWUh4MfbEQDZGZweQbLU3PasQDtaZ802gBwI76IstvA?=
 =?us-ascii?Q?1SypV2Bcyte3VCSll1ViTzu/+s8a5bH66EECrvJTYymkfgLngzxafP5CZH0/?=
 =?us-ascii?Q?678SKWl+PVR1AHZRrmhCgXq2VNolASU5BBKE4dfSQb6b/Px5R7a8x33Xn2SY?=
 =?us-ascii?Q?oJRvmwGGr4OriOIiH8RPngui/vH6dyWuVj9STYTKpeYOZ7SiUFIRB4586Wkn?=
 =?us-ascii?Q?5MJOO8b0zyagV3D9lOAt9S8N12zev0lfubxSA7A/kHHD0hc7wiZMKzgU2ndd?=
 =?us-ascii?Q?yLUZ8eaRAHUWOF2P53z59FEWKZVrW2iNKIk+3Ov+4MoqWYp8rF2ivh2EXS+K?=
 =?us-ascii?Q?y/U9jVtsDXR+TzOQgs+ocJStUbGNfw2jZPWm2b3cqfb+WdmnPef9yERL3TyQ?=
 =?us-ascii?Q?1hb7//4yZEDPOjUe54zz99whJkWYTzJc2fC00Xbua41iF127Y5HI3xu0c3uQ?=
 =?us-ascii?Q?CoNaiG0TPaWfGaTYZzYLcY2pyFf5UyT/HyMt6fIiAU4gLWZDTW9jCQzV5TmB?=
 =?us-ascii?Q?D5bdLGUvYOVbf8oaoA7WE1WZvPx1oqUGGleRM1ktETClAbHVdwNOAy+ds+kJ?=
 =?us-ascii?Q?tymo4Ju2cX/Plek1uaofecl5oZ1xV0ApCGoph01MK/eazJJjw7O7HGbTVfRp?=
 =?us-ascii?Q?+Kflfso1HT8PbP1tB2w8E6yd+1ex8bRfFjb3DSo7b58Cj6DUK0EPiGtGQAbk?=
 =?us-ascii?Q?Erwiwt0LByKFj5X6CI98RDwklsO4Z/81rEAVOXPefJdKFpj9gCvRNlVJ/5z9?=
 =?us-ascii?Q?Eganyv9mxVvrZPQ7d/fqMoUUy4PreSmICQ6oqvmaB0+sgb9uEr7SK1YIiF+/?=
 =?us-ascii?Q?v3AVyDNBThYXJjKJt/lc0FrpLPSDIrruHBXZ3eo7AFBZmkHkWYjfVLW7mOGB?=
 =?us-ascii?Q?cEu3ubAm8Oj7f7xV8YCoLMYVPVXqwOATR1Bw1E5nfH33AzPybXIUtGX2WqQ7?=
 =?us-ascii?Q?A46bzqh8v/GLvfJd3PcyLPX0ULbnB//83CgyCsRy6M95ySNQXAZ6NFt/YwGp?=
 =?us-ascii?Q?DhmxqVyWL2CSj/yaiOr2id0CCVMrlmZemkFDn/xw0zR2fktyp/SoIT+brdPU?=
 =?us-ascii?Q?JdoCtYnobcWJkd1CMGAZ+E1M5iuk0xI=3D?=
X-Exchange-RoutingPolicyChecked: WOfpwZqU5bKj5MCcxhRnt8aF4RxjxUSR64VlLl0XKmJ9c2zT0r223+a7yzm0S+/QPYTg/DMKQok5a4u3dwmvWGY7z15YAWKr1dAeSozbhtSER71yf8nK0e28hBhWkU9KlIUsKMAcedt6aB52X30ub5pd1nrAzyBskCayrjxQk9BH8H0GdLBCzYX9itAfSj4Bjj4FWan1mfHHXxDk0VR4jBKewd9mFke30rOB1sxwN+43MegoeEcxejA1d6B5Zu9+cBbfalyU2NXIT7YxKm9x/70FW6vQykjb4JrKtAj4Mp86ahkdv6pPnRSCTTUcBMARhfIhkXpnPbXl463YAlco9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c1b614-8fc5-45d6-3c68-08df3e55f5fe
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:38:23.1001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y91iUR4GmLwAkVFlvStmx4t31spR/qWEwKt1s87m4gog2RzD1G7qOWNqbmedxPh71O/AyaTyaEgRiZgB0GOXXpw+hn+T7Xbgvv6gVqtliRE=
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

Continue unloading shmem_sg_alloc_table by placing reading
folios and shrink call into a new helper.
Make the loop a bit more reader-friendly by removing iteration
over a structure and replacing it with inlined instructions.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 105 ++++++++++++----------
 1 file changed, 57 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index b09b83402b8c..59dae47fcfc8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -79,6 +79,56 @@ static int validate_set_page_count(size_t size, unsigned int *page_count,
 	return 0;
 }
 
+static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
+					    unsigned long folio_index,
+					    gfp_t *gfp, unsigned int page_count,
+					    struct drm_i915_private *i915)
+{
+	struct folio *folio;
+
+	cond_resched();
+	folio = shmem_read_folio_gfp(mapping, folio_index, *gfp);
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
+		*gfp = mapping_gfp_mask(mapping);
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
+		*gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+
+		/* Retry once after shrinking and gfp modification. */
+		cond_resched();
+		folio = shmem_read_folio_gfp(mapping, folio_index, *gfp);
+	}
+
+	return folio;
+}
+
 int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 size_t size, struct intel_memory_region *mr,
 			 struct address_space *mapping,
@@ -117,58 +167,17 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	for (i = 0; i < page_count; i++) {
 		unsigned long folio_page_index;
 		unsigned long nr_pages;
-		const unsigned int shrink[] = {
-			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
-			0,
-		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
 		if (!i || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
 			/* Grab the next folio if we exhausted the current one. */
-			do {
-				cond_resched();
-				folio = shmem_read_folio_gfp(mapping, i, gfp);
-				folio_page_index = 0;
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
+			folio = shmem_shrink_get_folio(mapping, i, &gfp,
+						       page_count, i915);
+			folio_page_index = 0;
+			if (IS_ERR(folio)) {
+				ret = PTR_ERR(folio);
+				goto err_sg;
+			}
 		} else {
 			/*
 			 * Otherwise, we are still inside the same folio,
-- 
2.34.1

