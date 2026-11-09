Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDA606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gLT+gN3Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6795810F1D2;
	Mon,  9 Nov 2026 11:38:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C9F10F1C4;
 Mon,  9 Nov 2026 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794224312; x=1825760312;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=uM4j0sLFKg3e0xBL4/USnT+kQDf4aOaaDGzUSoaW3NY=;
 b=gLT+gN3YJ6UycSjGmY9ldq0rl3J0S9zFZ9cK715O72Qtl2VfdxjkHQ+O
 zdQP3EIV1JyxJhxFbEiLoWaNaGxrg7/rlX88Z/r9QZNHtcqgqLd92tW21
 oHkImcj5jgYNwkQMKLPXQn/V8ROo6InpNCm9AP8OG3ByEXJXPSpFGveHh
 soyg2O5qVpdXw0dTnDYfMmtTVU4/wmQo4k6/Lq+IhJdrK+F+RSBi7VUpB
 tKF9FbJdiAQXfXCxsON8dZGbUZxOPe0gi2oNPodoaHhLFi4Lqb0T3PJoo
 S2jIy1otS2KyDqib/kCOvZgdtxyyPyffRsBwh0Ta9r5fljUX2ljp6o5t2 w==;
X-CSE-ConnectionGUID: KGf+76c7QnmsNDNdN4WRqA==
X-CSE-MsgGUID: XfnP8sarSIyoiIFZ21p55Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2938511"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2938511"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:32 -0800
X-CSE-ConnectionGUID: y+BOHoAzTg2hsONMrdERGA==
X-CSE-MsgGUID: Ufxtt3bRRiuqBArSxyo63w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8282699"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:31 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:30 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:38:30 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIBJ03b5Z6DoGM0bB3g2KCetnwHlK+EKEp55MWwE157zr2CwFLXvTxGtPj7cJ9flY2jMYHKd5I00fCNHpOxf7iGyNVvVpksFWg1ZjOldXR/UGHiFkEL3pc4PtIGc3DKuKbAElkRTDJqfwsIk3+apYxx7ITTGT3UWc5uhlCEpWNwl93RF8GdlKAKbNgV2dj3LKjaxpavsY4ITBlM8rvOzdZmfLhJi50p3xaf+FU/L3Xu/4hpMo4CWz1Zxp+CzptEWnfRm+fr8DL9E6+q1ujyUE1HkKvESnX9CxUljMBq3gpr77+62PgyATCl/fdu5mC3yiC6YLbqWzmBBXZ5loJ+V3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG2O0iTP8hP/8Nt55QGWDD0TLd1fQxKKzZW9rJU7EAo=;
 b=b5W7AfPx+NgPZDHv8tmo0lxTkMcg9QDlAoOcOMvSLOPR1X/MD4GZQPvndKBnZ+f5nHX6HMF9MRE+jviT5QnDxq9byCI/JeNupwTQqH8vLM5m9HQ/HbXG621rlmh4yTlJDy/6O3tSsrgUJohlVu3U2c7ZOPnmQgQEIHmAOuouLFs3NYHsWwDQKdlXEdJn3KJHI8mqtj+BnhFTY4GlrvHuqu6mwLSUs7y3k1onIElnq8BZvU995tZeyReV2Fw4GsOIQVHEpKbVV2pUrwySdLW11xrzxjzPoSyJhLMhwV/o/V9IgeI9jw3nN+JTup5pyxKMoj0l6jGdIPT+rhFJSpLzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7199.namprd11.prod.outlook.com
 (2603:10b6:208:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:38:20 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:38:20 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v8 4/6] drm/i915/gem: Pull out size validation into a separate
 function
Date: Mon, 9 Nov 2026 11:37:56 +0000
Message-ID: <20261109113758.1491891-5-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4050db2d-0b0a-4c11-d949-08df3e55f4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: RIBlYdRgv7J5Er/xnlZ2nwuEGgoL4FsxxokzKOiUE3cbiTZ9Zele3M3Iu3IQEW8R9bvvWQuQkLEWdToIdXACDbOqGQqLR1ssp+AlpnkC8fGeAJYOsyXXD0P5cwmdLp3JljpbBlWzETWzHNiHQvyCDCAHEb8BCxrJ6m1/fiRXLJ7hsbaU7gq6EAvp2Syq7Wr5Hw7nj+P54xX0tkv9s1fOxi7osu/UY3yZnBS0EzXDTETkUXoenoJZ6FCDW6TjAlF39T/0fOkYwW5ZevE93ZQwMCrMzm2fCT0d39rN+tWXLfODlH3ELkx4yyoGULX9o4SaYuSW/1m3tBH15g/ggYUeqtGPoVtIKJ1iWpO8HE+8XvQxX8GpgfvIdeDITIRTLEsHrRynJFKddY0t2zJQR1eYUwrUcqoTLo4Z5MGyGRB4IR41r+RKic6I3E3bUfqTDcucJOaisw/iBvndKWJzLNAnLbx0y941tZul2DoU75TgbjQ67/9uHtNv/ZC0a6XPRBgD2LKQnRhXPsQdSAGBSM1VNpP0LEuRvo8Kr1m4YeQNJUNjCZ0fSLGPppuYzFNM1EBY3Mzx2mxfEpA/pjvxzNu3+FwJ234ZcsayXksXeTH6Rr2egw1lnw2UldRVovFb/bPO5HBux7k7J1sOXj8c/t+lln4Wk+1y99jTF0kCD1oAk0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teHLZrMWXy0IspHd/uGPfMxra8mx/V6ZMi3ZlgLoTtU3JNL1uBCHExSIYSlP?=
 =?us-ascii?Q?1uPY2hZyFs+R9DGPnKU/+oF1DFDTYlIzpZcu43jV+y7tmTBbHkC/veZJuiSV?=
 =?us-ascii?Q?JeqrG6MovVTC6W+i4uigj3/7G+Rr1GnWoZbollb3/yjBHXGwh6QYthLDKrdY?=
 =?us-ascii?Q?kFNLyBu5Prw67x0nCQ94t46QLNZz/E86EK2eebRnIyxD5KEmkuFSbum/35qF?=
 =?us-ascii?Q?Lro1M9TBDprZk3YE4yZm219OaDnKk+rXl7V97SDClWRa5MxPYgXaIlYs627i?=
 =?us-ascii?Q?DgvHu3Dupr1f9xDAtNAQ1sYbeHk/nenNodvnXkWDMCFCg8R0XmWFDdy0+WDn?=
 =?us-ascii?Q?ohW/D7UR5+jupUxd2mzLP0BXmF1xP4NH+//VIPS+HSn5wrmR98qQ3BmYAjXs?=
 =?us-ascii?Q?7Hz2N7bhxyCvzK5MoQYOr6GCv/pDM0Ue9XW5282d7ouBpyuGT5PyA/TdHtzH?=
 =?us-ascii?Q?lxPaMMyTbO+sUQI0FKNkz0UOlsfbtOF9gOoMLXXcK2YDZroS1KGQasDVcLj2?=
 =?us-ascii?Q?NctpKXQP9MABZU/YaLARSR3P+JHQbBqRxoVcNTYGcHRdVKM6AQ97fwajKyMb?=
 =?us-ascii?Q?kFkaJD+rX3XFzeGECt8KeWTGizSesZqcksEsS1wkxckXCPthiWD1L2KeYZZf?=
 =?us-ascii?Q?BOHDx7FRVK5mrv6k4vrqxplvriMDRmSWxT5aNniFOmGBdde7zsMCTjaOPfSP?=
 =?us-ascii?Q?7AVfpWSGthqCg+5iZY3r2eOoY+6+TRf0QjuAWMYWuOIgE9P9zvdOlD6I53Zh?=
 =?us-ascii?Q?v4wgARYTCqLeAMMDjaHU06tTejKWKqOIRTEyc68EtZ3d09B/NWvdkpuZVbZA?=
 =?us-ascii?Q?GcKrNPt8pdEhsoCbuAuXmgfMnWc8NY+g7Pdm2jwoZ51OUiP98g8JXM4MLw/d?=
 =?us-ascii?Q?q0sAIOIzX0amImJYoUVr8AZgbT5FXei//blAALXSbGk1rK50Gq0gWE17UYVJ?=
 =?us-ascii?Q?/Sb6uvSKXa6PTd7BHQ8Qa/6Vc8mUgqbJ7hHbx6XNxK0zwsK6cXz0CvUb5Teo?=
 =?us-ascii?Q?avpFtplG4k+eSuxr4T79iW0lCldKrhIt5NpQNxY+0SXLKbI7PLfoCnfby+Lm?=
 =?us-ascii?Q?t9PUGY4LT5LrAEjdL9DrBgXZ3kzUw0dPkED9Efwx8X+/uCZ3DOZs9IZZzuMW?=
 =?us-ascii?Q?INPZ6Mzi2oxgVMoLbbLEuZcqMPjCgOzeA1rJOioc8EecWE3zxgbg/1A4c/Sh?=
 =?us-ascii?Q?dJazCMhGXIdHw8vFwVqr+QR0ujUD+K/2a0u71tUXmVsev7aPaFNcXbrCWlKc?=
 =?us-ascii?Q?shdUk8eDSlNK3gowcen0snQmOrwQ8gnYfFA1qt5H091A4pUxdyEgcbA7QJY+?=
 =?us-ascii?Q?M2BS0GOHzdaiogk/4G1YPFTrj0Happn/aWn2ZN3/t2PRFB5tgEZIGZipjE30?=
 =?us-ascii?Q?TliX4PVIL/ObIgZ0ilSFBOjbdJJrLmmeirWxR0nQgLk78cougn4CPZ4xq8HA?=
 =?us-ascii?Q?wjxRJD/suh83hu36ARgNvkt5S77PNtGDYSVN500MkIf+VrreIwLgsfV41cw1?=
 =?us-ascii?Q?ZMdTIJQC7ikXVM0vEIhAQF6rQqwkqZu67R1zp6AP2CKwhN7H7cwnanNVvK6z?=
 =?us-ascii?Q?WuBxpkWAtmT1gylq/SxbTiJLVO1jI5hASG0RO8PK+sd73E+xP4qgXuhcx44x?=
 =?us-ascii?Q?UgAmfhvHSAG43odIBG8Nfm1+21tOSsfDC9gJumf58Iku8u8JMW1fbi0hJ+P6?=
 =?us-ascii?Q?rtjOXw5Vtyb1brhXI2xe40lUEeivjKcjNbJ40qkIfQmmjrN4/xfT8AFYA7IF?=
 =?us-ascii?Q?X5md9WZAUixsVevuEZUlYLem8L7rdm8=3D?=
X-Exchange-RoutingPolicyChecked: S1LdMbBcGFKTCVLyW20Qm9uGpGAF1/7PtOlpLcMHVhqcfi37+lBXyxD9tOKkqsFjTzXsjTxUiwSUZQJo3d6dI6MA3QtzXmbHQKmyhtFliF72xhEQsXLr/ywCGYmtDsNDAyRNebT5WhRS3qPp1u7Y0TL3MjfvXUgP7dDMsLCYdPqQHrVej4/skWDVTxg0D2+OblWog2Bcdo+YQSfmBw3KypZjCPXtovLhUBRktCHgnMKtoQBa4v68FU8FlvcKK+nclxQtj6meIpmoiTUVgcGk5gBx9utgKCb0/548YV7Cyr7Leh7ty8uMtv3YjDeS31f3zpA2LTMwAz2Pa+6+QY+Z8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4050db2d-0b0a-4c11-d949-08df3e55f4a8
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:38:20.8688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2KJC44jcuwVq0PCY5qTJcisGE9rcIlLYqAbk3JaJJx0w+/m6qsIvk07zRUwMbWUp2HzWIb/HAckmrFb19YbzzerN8kNZQ9dfWi91ZKMAcM=
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

shmem_sg_alloc_table is a very large and hard to read function,
so reduce the number of operations it is responsible for by
placing "size" validation and page_count assignment in a new
helper.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index f4a2a3f34c36..b09b83402b8c 100644
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
@@ -75,16 +92,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
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

