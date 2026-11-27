Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B50606A324
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KcHLkNG5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A11112CCB;
	Fri, 27 Nov 2026 17:59:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73AC112CB1;
 Fri, 27 Nov 2026 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802381; x=1827338381;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=aWJEc37VmMO3fzwvdBaqC03r5Q+e+z58JFjvG9CPZ4c=;
 b=KcHLkNG5DoC7/ziGPsXLmCR/5jVsXlb9pkvl1yKa1Kmk0JRFs7WhqHMB
 ZSD6krQXT+XhmmCUaM64aHD2IneFMJ3opB53BTFuxJ8r4COir3ON6cVlD
 CCV1c//kESGl8iv7A8zVI3NcwXOjRE2hKp3BpLp5tgM4NvBBmqzK+tTbf
 0GeN/bjvnobnA9KM57slIIWKZqvvJWo2ts6KiysbPP2XOcwQq2r5dDjF/
 0TYBRnV/wngec14DpEMyHNONYx+y4KkGDh/AHai44/5/L3AhlBfnVOUgR
 teMO2TqSuyEMLfgI/bcxrvgwUybuNZ/QUEHlxnY9JIACZiunOL6a5Wm0b w==;
X-CSE-ConnectionGUID: sBLdFM3pSVOBHU10WmzTAA==
X-CSE-MsgGUID: Om8T3bviRJuGdAJKymhIgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4678104"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4678104"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:41 -0800
X-CSE-ConnectionGUID: HhikNKClQk6GUvFl+F5EkQ==
X-CSE-MsgGUID: sXYhCARfRFO4y4JhHG6OAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12789927"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:40 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:39 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmfD0cjvfJa4gKg52pHRP9e+yu6nB138S9GPOq1appiZ6jWtsAdzSquxsZM/e8c1ZkjSbXxcqfOama4npO+p/e6uGnLRkynIgULb2QITVAnP0fcR0kon+HcxpNBCtl4CRA8Bqwf3JW64T+EGAVLAgVLHPeczzd3lNI8biq0ONZ7L2by08/Wf+QwU2KoRqPLdE+EsxpZQYEIa5anEosx8ynurgGA3vGKVg87BmDzXFOXg4ziRf48qH+rvTiJChmOdm9PLPzc5P2ugZYY+F49i2C5KIiPt+xap6V5tVH+q2iIN789R3/1i3jt8h2KYHbGB5DJGos31RvSpsyrHidi5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLasNQrz6BxjKksQy1I59Ckyc3I17aLNl1w6ccDsLRM=;
 b=XOHh/GPEc8XmjGuHIY8A3/WyBaDPkyEsHxElHEPpKUnMeImev7mgBtMY//RfVDx0KykQlOnMzaLtRiv75HvHBNAwT4rhojnkzbj7oGaBB6r7tiK88Wngd/vl91EfhktciyYcx4Z6uqu9weSulDuvc5MTXpWxuGYqWtf9hRL5eiafec9yiTq9jWBEOalF4yKxwN5wLD86sKp1EGCmWFszaTOUNOX8nAIu5GV2ibsSZpLJYAkfOuEa2d3lKXDCgUFyny61gTtYcXv9xGl/vyWF2YUyEfCuwy6cDWPnCKqwkbC0NqVn80sZDvnsEwUdf4EU0zPVGJJh6fayZZZL2GIdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:36 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:36 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH i-g-t 7/9] lib/igt_drm_ras_nl: Add retired pages helpers
Date: Fri, 27 Nov 2026 12:59:18 -0500
Message-ID: <20261127175914.784751-16-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::47) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: e99f0f40-7d92-4c92-72cb-08df4cb032b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261102123227099003|261022075727099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: dpOm7xaKD1XAdc/sCP9jwuoZamnQIKAPh/3DVAoUr2oOHb85tH0bi78y2wOABrCw5ax0aEMOhN5ouG9avJ7A618hgcls12HG37jALuWid1XBj2zf1/rfIGBTmsGPWZYF41CJBtCOnYVsSs8Y/H66TZKX/0djKcsSkmAcV1riFnYd2GDT5nuoJx5D2SaJycqvuDYwpGL3gV7OqFjvym9QdeKdQp8bdV219A3VEVQ2nxj3I9KqcUI9PY9C6jeCzAzlYfTRhJ7G070PKcrHzdRBep0hPJ9+L+7BAzh1O4kefm4TpdbVAaLrVITQ2Yg1bFUfv12ty883gSQ4COdiGnIfezq8o6HVO/N9rMum+eGJpgfT0xwDdyrUk37OCHppfgyzpgDNFM5WKpAYhrNbLkBXcmVZ1icDNSnmCs16/tyU8xn2EzMFRJEVJcoDfjeOZZccgIttEnct4TAlPyStFo3oYprLqw3Jo3x6sWOEMLhb9Affq3nitB0BfL01ZnLGWwWgkZsXQRmoz6Y3gct/v3/9i5HTFKw4O5rBLaDObNxi3vCeNXDkT9jM/fdzmhvsTy/8OORXi8hj77QSBSiwhlvY+01ClRvoWhnn34gcV62ZL3D+2ZbDntfTzgId/c8QYyy9TMLLm4HAuEew01Tx/fsKjDgRZB4o3XbnkNLdf2ZijVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261102123227099003)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OxqqFW2tp2hH3HSNnM/EzOwopOhc+WOk3ly23FcTb1X5qU2n5bcQoZfO2t/T?=
 =?us-ascii?Q?hGhTcDGVj7Xeko1CpSckSPlOlNOtZdfI0QJ2uC07+EGbYUkk4JwtxTa0BzZQ?=
 =?us-ascii?Q?0iF7p7tL85C6pJkFZbveIZR7IBDjh0vDf6JKAlpL6j20C4s62dx10THaeRy8?=
 =?us-ascii?Q?IBTSvHeaALL0thjFux0Edus1hyXPgg52nQerS46zm4fTMW/3CCKeUxg/OBj/?=
 =?us-ascii?Q?mzRlev9dnlyWw5XCLdVh+l3950OoMz3DKbW1TSm7dYcCf/tpb4XbQ4HxZ/t5?=
 =?us-ascii?Q?OZU7rVwYmM9ovTmM6/pZLqOybAyMlTAj07carXbRldt2L6RzkE5IpnIEgyVp?=
 =?us-ascii?Q?35uId37AjhygMTWkeuKeUoDIgY0VuWeS1paMYZalR+cywFRD0ENClX84oSvh?=
 =?us-ascii?Q?hX/stlRQFjZkgcgsCUZvY8DxsoMWLvH5+J4as4WbGJEZmE5reR3+3q+Oz/aR?=
 =?us-ascii?Q?KRf0VTDMBZ1Kqd1rxpJ8IHrDgaZv6b8hZ/IYlnJvv/l4Nvl807qqMAAPPn+5?=
 =?us-ascii?Q?gjd100/36K/35T4uM7AZWh0lGqc+S65vjbdUlKtjKAW9I+kXnr8kzBEvQ9vH?=
 =?us-ascii?Q?6wbGjNjAPGeSWsVJT1V2B87jq8AsC6q8vbg9aW8cNlWd9KDcCPpeF3w1YJCm?=
 =?us-ascii?Q?KtVwmzIPy3yilLjUrJMI2Uhc2CiuM/65HCMgaVIFI2IZFNFwGfvcF0jMLMrN?=
 =?us-ascii?Q?c4snzi227mXxxDgHPDb1iDceObeSAgurr4s/V2gVzhbuhGwEa3lrkxdSIcMC?=
 =?us-ascii?Q?y2yWLHwPKZy7QBhSIFAU3thVflb2BzvcUQRXJv5U9P+7V3u3NOIYNjIeuuAU?=
 =?us-ascii?Q?TvtJjMSzLQph7nc/6uamqycfUYNnyOXgp8SFJgfyskFAzasnmfMaoPiUgNe2?=
 =?us-ascii?Q?BdeREprhUF5csa65UKBstpu9aUxxa6qM4ZPc8+8kCDSPqDldrlL42Ithuuj2?=
 =?us-ascii?Q?F4Xpk8Pjd0zMn2vat+y/Fjql7rRXmUjiM5r3pbvef+LJVliaPXtBgS5wZTO2?=
 =?us-ascii?Q?wDN6beLjyOXkrqepdK7+OUuzB3HG7IsSg/nEiHZX5hIcPRJQA13OQ611/fip?=
 =?us-ascii?Q?ukf1pZcC4/Lm7iDYsFTgGws2968Phc2ssyCQZJHh8/43oKaoGmQvd5AjoZhf?=
 =?us-ascii?Q?Fuwv05Mi7zozHBQHDHNepmphoDPQULUeEUa3RYmRhaqFYGlkOp2sZ7Pw9Kxl?=
 =?us-ascii?Q?s2gH+aPbl5rzYpjsXZSa4kOGvy8a1lXT9kw/uX1iZgBqGjy/yCn77MDShe/H?=
 =?us-ascii?Q?Mwy+itDHJ0EBzIvCqp1Mvhe/8DlO/Xs+3KTs26GeFPfb65CKoOLb7f423NED?=
 =?us-ascii?Q?aFx5zYyi5dNd2WDn5vINBQ2r74Q64soEjC4sM82fhBQnWYYD+49fxd+Xrga5?=
 =?us-ascii?Q?F6Vc9iL5J90NX+yJoERx00oLzNUGQF/9MDwq8WGTTzXG2iju4k9569Th6d+N?=
 =?us-ascii?Q?xdx5WP4ebs5nhrKolup7lu54oP693StWNjiPAg1D559eSinaD5GWOaUGEyKl?=
 =?us-ascii?Q?xm87Xwqjls8hg+6fbYEYKSgdNicDQS3TONzEVdN0mkh36U2E8d26nDM2E+NV?=
 =?us-ascii?Q?lTHCkXGld1RRa6y9rVYlkaPkWy9d9DSematP4KOwtRjnpgImZTcnX/UGtHAa?=
 =?us-ascii?Q?K4xPHwHfOsJ59e4csfA4nwi/xYsS2JzShfDS2vsAh7gB+g05uS7YmBD4zCsS?=
 =?us-ascii?Q?UMsn9xWP1NWWMrQvr6r9ayUvP6FoJj7qY/ch83M6ncsPX1y/0x++uYs3ucy0?=
 =?us-ascii?Q?HcNG/VZqxg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Nzy3LVtknO/QMRqkRGQt522u4nhfcYq6Cp7eVsNkq7rb0j15eLb9g7OLxUKspISdtky0dvDWBXoagBaZqo8fuSRrNFxH3STY1TNglRdEtVzmx4WK99FBMlqSZJ4j5dsDwXSy8Es6jjRhIpBxL4J1/JhEZxjVXGh5SOxftQIxDbqF65mt28QY4/UMN+CtRxyh6Ow4FWRs0D+ppGOWm5h4Ds+W8qe5M0tU2m5nwaXIaLPkM+4bSbTXJ2mrdZG+fWxVNnfn3O15woxqfMtUD/XbeAbGes+IMpt4tgHFHS75qdZX7sv+B6cLqW+cYdkg5Polmxi6WncxQEAoRdfAU9qY4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e99f0f40-7d92-4c92-72cb-08df4cb032b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:36.0571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51BDwzYKZJCb/jUSF7Cr/vFo5715y2Iiw1jDkfTyQOTed2ZA7zoIAxO5AmJnaQh+FM0fSO+Tcvz7GT+IXZcXXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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

Add igt_drm_ras_nl_get_retired_pages_info() and
igt_drm_ras_nl_list_retired_pages() for retired-pages nodes.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 lib/igt_drm_ras_nl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 lib/igt_drm_ras_nl.h | 18 +++++++++++
 2 files changed, 94 insertions(+)

diff --git a/lib/igt_drm_ras_nl.c b/lib/igt_drm_ras_nl.c
index 177d2bc88..45173bfcc 100644
--- a/lib/igt_drm_ras_nl.c
+++ b/lib/igt_drm_ras_nl.c
@@ -1002,3 +1002,79 @@ int igt_drm_ras_nl_telemetry_set(struct igt_drm_ras_nl_context *ctx, uint32_t no
 
 	return telemetry_request(ctx, DRM_RAS_CMD_TELEMETRY_SET, node_id, field, &value, &reply);
 }
+
+static int retired_pages_info_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX + 1];
+	uint64_t *max_pages = arg;
+
+	if (genlmsg_parse(nlmsg_hdr(msg), 0, tb, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX, NULL) ||
+	    !tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES])
+		return NL_SKIP;
+
+	*max_pages = nla_get_uint_any(tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES]);
+
+	return NL_OK;
+}
+
+/**
+ * igt_drm_ras_nl_get_retired_pages_info - Get the retired page limits of a node
+ * @ctx: initialized DRM RAS netlink context
+ * @node_id: retired-pages node ID
+ * @max_pages: set to the maximum number of pages that can be retired
+ *
+ * Returns: 0 on success, negative errno otherwise.
+ */
+int igt_drm_ras_nl_get_retired_pages_info(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+					  uint64_t *max_pages)
+{
+	return request(ctx, DRM_RAS_CMD_GET_RETIRED_PAGES_INFO, 0,
+		       DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id,
+		       retired_pages_info_cb, max_pages);
+}
+
+struct retired_page_list {
+	igt_drm_ras_retired_page_fn fn;
+	void *data;
+};
+
+static int retired_page_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX + 1];
+	struct retired_page_list *list = arg;
+	struct igt_drm_ras_retired_page page;
+
+	if (genlmsg_parse(nlmsg_hdr(msg), 0, tb, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX, NULL) ||
+	    !tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS] ||
+	    !tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE] ||
+	    !tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS])
+		return NL_SKIP;
+
+	page.address = nla_get_uint_any(tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS]);
+	page.size = nla_get_uint_any(tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE]);
+	page.status = nla_get_u32(tb[DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS]);
+
+	list->fn(&page, list->data);
+
+	return NL_OK;
+}
+
+/**
+ * igt_drm_ras_nl_list_retired_pages - Call @fn for each retired page of a node
+ * @ctx: initialized DRM RAS netlink context
+ * @node_id: retired-pages node ID
+ * @fn: called once per page, in increasing address order
+ * @data: passed to @fn
+ *
+ * @ctx->dump_interrupted tells whether the list changed while it was read.
+ *
+ * Returns: 0 on success, negative errno otherwise.
+ */
+int igt_drm_ras_nl_list_retired_pages(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				      igt_drm_ras_retired_page_fn fn, void *data)
+{
+	struct retired_page_list list = { fn, data };
+
+	return request(ctx, DRM_RAS_CMD_GET_RETIRED_PAGES, NLM_F_DUMP,
+		       DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id, retired_page_cb, &list);
+}
diff --git a/lib/igt_drm_ras_nl.h b/lib/igt_drm_ras_nl.h
index 1b2a8f164..1abbbcdb4 100644
--- a/lib/igt_drm_ras_nl.h
+++ b/lib/igt_drm_ras_nl.h
@@ -107,11 +107,25 @@ struct igt_drm_ras_telemetry_field {
 	uint64_t mode;
 };
 
+/**
+ * struct igt_drm_ras_retired_page - DRM RAS retired page
+ */
+struct igt_drm_ras_retired_page {
+	/** @address: Device address of the page */
+	uint64_t address;
+	/** @size: Size of the page in bytes */
+	uint64_t size;
+	/** @status: Retirement status (enum drm_ras_retired_page_status) */
+	uint32_t status;
+};
+
 typedef void (*igt_drm_ras_node_fn)(const struct igt_drm_ras_node *node, void *data);
 typedef void (*igt_drm_ras_error_counter_fn)(const struct igt_drm_ras_error_counter *counter,
 					     void *data);
 typedef void (*igt_drm_ras_telemetry_field_fn)(const struct igt_drm_ras_telemetry_field *field,
 					       void *data);
+typedef void (*igt_drm_ras_retired_page_fn)(const struct igt_drm_ras_retired_page *page,
+					    void *data);
 
 void igt_drm_ras_nl_cleanup(struct igt_drm_ras_nl_context *ctx);
 int igt_drm_ras_nl_init(struct igt_drm_ras_nl_context *ctx);
@@ -132,5 +146,9 @@ int igt_drm_ras_nl_telemetry_get(struct igt_drm_ras_nl_context *ctx, uint32_t no
 				 uint64_t field, int64_t *value, int64_t *status);
 int igt_drm_ras_nl_telemetry_set(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
 				 uint64_t field, int64_t value, int64_t *status);
+int igt_drm_ras_nl_get_retired_pages_info(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+					  uint64_t *max_pages);
+int igt_drm_ras_nl_list_retired_pages(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				      igt_drm_ras_retired_page_fn fn, void *data);
 
 #endif /* IGT_DRM_RAS_NL_H */
-- 
2.56.0

