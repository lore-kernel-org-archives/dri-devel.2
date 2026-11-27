Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAC606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O7LfD/PO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6956112C8D;
	Fri, 27 Nov 2026 17:59:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67AE10E8F2;
 Fri, 27 Nov 2026 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802376; x=1827338376;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=5qOw6dKpOoHbshcdjxnR9S8WNYg/xM+gu0E2EwhiDMw=;
 b=O7LfD/POQhNWmL6U8MqSeuS1rbOkGYdQKZHJEfru08mOINy5WQDjOenR
 T5ZxlAsIDBpRuudoXY5w1KkXC+wxRC2+Z3dyD1Obp3x1ozKXjnxDYWFZZ
 qAmay9w2XJXbQctAmgkDwK7ZyT/NaeMQlNv2GBZ0hBl2JRDxkchuQK7xQ
 z5xVQPH8zreOLBGWE6+i241400z1DpB+E7EvyF86uCoEXdk9i51ZOR+pN
 c2rPbrEWE03um+QBCocEct/pePO37xSfRAS8PEQfUHOxiO9fY0wUqwVY0
 qI/e+Q9cimNoaZ3oFU4Qddn+4FCtuCocdqHy0/a2HSAQxBSXaBOgpjING g==;
X-CSE-ConnectionGUID: NT/YYjcCToOILIYGOg971g==
X-CSE-MsgGUID: JaG3jXvdQGiuW9KypUzHzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4717112"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4717112"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:36 -0800
X-CSE-ConnectionGUID: 8Wh6PkmxTA2ttcTOnaXwHQ==
X-CSE-MsgGUID: ehWx3lYvT6m4GQnW5/Weiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12228767"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:36 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:36 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:36 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS26ema9G96FnJ5ilhPq+2ENRtaengHGemztB9oUggi8AZ2okTYfueNUwYgC0oHZKo4y0Aoiwpvh7AsIbRZ8RU300k5ra7eW2d9Qd9AxFnqWpYigfTXkFHWb2+OdOVuLjp0L572lFYHy2o+TBbek6tUJuXHJ1JDC5YhzzkoPqSxpljLHjI8qAS3CvyzHKDc28d86heB6yOsx63xKs6ZuD629LjD+apMumZsvkyLRPqSZdv7dRv0rh3sthvJ6cBgLh9TkVQf8QfX6sB9P1duBXxIgeb2+fiRKhy2kdpybPga2rPxh4q9H21YZ/IepzvFlz+B/X/kqHqNNONjdg9FyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYFbg1NDHWBp/wZgkSv5P3d/rAMdieLfdeCzm3XwV14=;
 b=QMia/WVosVseDqw/S4tyGHs/Uz3XaPss0Dqj89MWJUvk7eUtbLL+8NJdiWuSAW3EB0yTvJ253A7YShkXv9TjucwPT89xUmDnI+58bzaNjBiSE40dT9osJmdR7QgRXj27pYxCZ149JkjQLnlEJlQ9lb166wdoXPJk0Dfa5eNQ4kw4s1UwSQf8Tzw4nMwQbpYY8jLr8QXOv5C7e22sCs8i0MEk3kcbJRWhf+VhwXJjlY+s3z7h5S94Eq+o+1tWRBFQnQFOZDzeGpIahheTXavcquCzQOea8PByjHE14nhz12IdZHVTQltNc5RH/IgqkH5wykozL/igSLaXedfoLbgZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:33 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:33 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH i-g-t 6/9] drm-uapi/drm_ras: Sync with kernel for retired pages
Date: Fri, 27 Nov 2026 12:59:17 -0500
Message-ID: <20261127175914.784751-15-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f33c6c-d8b8-43a1-30f1-08df4cb03122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: WyAxVZXuoKIGi3swSnobRAuXfnDIwIGrJVEoUfqrVWQCko49IzCIG6yPlpvEg/kpV6mMbDc2UV++04H0z0RQNalOIuQCZo7wS9mh+dH6GosP8dGSmgWdeaCTgHjKBBn91jkkRRgzHqDoM9G5p0MnQkV/zqz4mesh9pGpcyThVCpH3j0byVw8lakfcCYTSTXAzCcH8ojg9D5zhoqNSRW9dnw3WP9uymtlaHQp+YvYUyx+lMgNyd9sGWIBjrWxztcrlzuMWbkaV1DpRATZUdVMD+CzMWvFRFy020LkCm4SblFiz/cKm06RCJLiGZI6OaszlksB9JGW70aXn3sTs2MjXnyqzs9+8Ftfct9DMUx1GR4+CksHOjlvB6+YT4/DFLQtk+S5A53HXlhPFf3ecu5Y/00gjjRIXktw+C/Oxs0kGw+AuPywSL9GeRPVJs4GA3TD/ftFUuR/mldQDa7JIONKNnzuRiBI5LZvnd6IYrUWh/TyMhojx7G4MNpnUKHwuBtF1BXBPJAnIPcMvX44fx8wE4OkYkhz9pE6bdqdlZwWzSe6v5dMp9iLgKgdNgFcYls+myE5hOWmJPaXJ1/yls3PDUQrWDkXpDdTw6/delHTvKT2P5xjaEXZR4ZY+AfpjhQEMtbwjplZEYhOQBfwcbXJd1KfR6KSJMj92DFr3bQNGyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zmu/kf3H8vQbVZCFHMHOgP+yihHI2y0FsAPPi1RoVx3B6bi0u+RP5zwxMqLS?=
 =?us-ascii?Q?b7+ZyVXRhmvDSeYb9XnTdK4yKizsu/fwo77edAt3BOVaCRmSmHFldlbUcqeu?=
 =?us-ascii?Q?X2bxTc+OXtj4I9pME/+Yf481xPwlYVZosK3ymwLGqY77ZNpvebOhme4Ej+VB?=
 =?us-ascii?Q?we1XKq/NBxjrBigygw38yzmbBEueZRh7t3P130dQDibOuHg7oNt/deyhXqnK?=
 =?us-ascii?Q?+xjkrYC3sjsSD6Tt9nAJTwWdpE2BucyTXoJLN5hZsddpVaKiP0ltZkOcC53Q?=
 =?us-ascii?Q?BQwqPevv+9J0URQvFf5Y4Se/aQTCZOxInxdbLvlEXilkaAdvKCN6GB/poSNb?=
 =?us-ascii?Q?nluEGYLJbrHS2f7k831Zw98TyNyQZa3beR+TmxdvJ7Oae80Lo6a40aY1P3DS?=
 =?us-ascii?Q?xAFiedIlbCP4rcB4kYYruXloT2raxUv/mnZG87LiJxTGIjYSnYGoS2zBIqM9?=
 =?us-ascii?Q?pD3yPdhRaKhtd/nIRgI9eGM7Wd6QvX5Zl7wqe0nFckfdoEdOJqTAqOBkNS04?=
 =?us-ascii?Q?hhZGc1lQqH6aoVPOBPFNG9iEtUBvLz1gY2+gMv1f+aHs38nhITYgkiUoUSZB?=
 =?us-ascii?Q?/2Mw/w2rtg2M8HKiyxLn8NFyanCcMXap7pOWspTiK2bgm7HUle72BL0pwN4q?=
 =?us-ascii?Q?bqjz8q5nUo1JQIJexvkjOOlbbdHjiV2eWbHYLvPB/uB1G9RKBUPuZYOuFgHg?=
 =?us-ascii?Q?/RIuly4zmsqGwiu2nAgnLI/gmpU2w427jpgye47xaR4BifXg4A1/MTYyp3Z3?=
 =?us-ascii?Q?Vszrg2HuLlHwsh3RlOBCJGe3bNp+CBT7XIizMKRpxyuRNlMcokk1JvQ3N3pU?=
 =?us-ascii?Q?L7/G0Zp933GdMe4LrPewFgZi2uxquxrHm0epQJOI0mw80ETBB4ODmOv8eHis?=
 =?us-ascii?Q?2yM7g0QDs+iO3Oytzl59dy2Ff9Sf7keL+WwC2gcQd2I5PJHORAY7MXiFKJBj?=
 =?us-ascii?Q?zgJzF+W86C6mCMJXPt+7cAoM0Xgmk/K7G5/gDIVuFyB5CRps6ldQzKNABUtg?=
 =?us-ascii?Q?WHj/WsulIy84CjuwEryrD580qH+rYxjy+0uoSKRQ5ne23/0Qu2cmq8lTYn1m?=
 =?us-ascii?Q?HXcq8HDvLBWXSc2cCBiXOVcEj5OD45FuGsfw7/F/IGJ/VHwxnrN4YmHDy+iT?=
 =?us-ascii?Q?7G0VfHq3Q9oR6clTD40UcGEGqodZWZfmFMA9yR3qQQrudYz7u7A3qfEIgiHQ?=
 =?us-ascii?Q?8H/y/NgRi2QQ/fY+LrxUFCT9/tEZaDzpuhIDZzDlWQCsNFGOo2RLeiOFDg7P?=
 =?us-ascii?Q?4fK/ayMmBAV9f6iAVyTU+RIUgkaSZvmcdUZmolRHwsduRzoSE+S6ZYBX2qJO?=
 =?us-ascii?Q?p53/hpbR3k5BGnVqGk1wE7D2Q9apa28HE+zRtEb2mBuSkYSzKPS/VbfjM4vb?=
 =?us-ascii?Q?Mh8y0HvefA6Z8zLJ7nwCO8m5egXuWgV3OQJMxgPGKBJOh33leb4tbYh8MEkP?=
 =?us-ascii?Q?suOgurTT+us5VIeDgT21z/I41uBRj+JtSJ4xbaiQ/clRQxgBJ/WgZh82N2YY?=
 =?us-ascii?Q?MyosDRismMmkW5eor2qpiNJQ+YotZ2XnSlZYbdX/rlDSsQZe/YJnikDpPe6a?=
 =?us-ascii?Q?vOtuqRGfjdYV3aM3aSsyxq3F5MC31wzVjx2v+wT8EwjvXCvRRfSMvLJoAhSS?=
 =?us-ascii?Q?BvEyTBA2npBnGMGSjBV/hGbLD10EEhKO4UTWccv8ag/7DWEuwLbltmTMRC7n?=
 =?us-ascii?Q?KZ+OHFgAV6qkIB9ouJMTkrrjIgiXcyiwTkcc/VOzZ5MQ7MD9dYsMVo4f8PQ1?=
 =?us-ascii?Q?sDJYNyPcYw=3D=3D?=
X-Exchange-RoutingPolicyChecked: cGsNQi46cTxlLZvhJY4rqrYdXdSTvHVrz4CnEXi+5E/RjShv6Lebpw5STHiS855etySl+IjlvkWqv9ZcCDmasSK/L2sbso4B0Oyeich1wbWHYWAGqQo7G6/3setbBhJBU2bE1SfuEKMVU4H4CgkjX/H/+LH3WobNUHHogHgSUbTQ/ybv172FL4hrKR5JbbE1qcDdeoCYcIOohb6HhncCGgGLNJ050uXmy6FyzRJLqxLMM/DZUboC7Va6dutVMx2hDyrT7wYj2NaoCo5oWx9ucd+eBk1wyjaPLAC3eZn3LF8GyhdzcRtmcyTkbtnBTEOWOm3GJc246pBKqfKckborIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f33c6c-d8b8-43a1-30f1-08df4cb03122
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:33.3789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDlqnUwWl3eSZdDgGJx6STQ9FKdzJ67Ysc9d3U4UYDbMW4XLz6l9DEEXQH9cUktxKittlpP7HZzXgppwuy3MXg==
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

Add the retired-pages node type, its attributes and the
get-retired-pages and get-retired-pages-info commands from the drm-ras
retired pages series. To be replaced by a sync with the upstream commit
once it lands.

v3:
 - Generate the header with make headers_install (Zack).

v4:
 - Regenerate for the kernel v6, which documents each status value.

Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 include/drm-uapi/drm_ras.h | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/drm-uapi/drm_ras.h b/include/drm-uapi/drm_ras.h
index 71b342bc5..8fbce20ff 100644
--- a/include/drm-uapi/drm_ras.h
+++ b/include/drm-uapi/drm_ras.h
@@ -12,12 +12,14 @@
 
 /*
  * Type of the node. The error-counter nodes expose reliability counters for a
- * hardware/software component, and telemetry nodes expose an interface for
- * reading and writing telemetry values to a device.
+ * hardware/software component, telemetry nodes expose an interface for reading
+ * and writing telemetry values to a device, and retired-pages nodes list the
+ * memory pages that have been taken out of service.
  */
 enum drm_ras_node_type {
 	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
 	DRM_RAS_NODE_TYPE_TELEMETRY,
+	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
 };
 
 /*
@@ -28,6 +30,21 @@ enum drm_ras_telemetry_field_mode {
 	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
 };
 
+/**
+ * enum drm_ras_retired_page_status - Status of a retired page.
+ * @DRM_RAS_RETIRED_PAGE_STATUS_RETIRED: The page is reserved and out of
+ *   service.
+ * @DRM_RAS_RETIRED_PAGE_STATUS_PENDING: The retirement is queued, but the
+ *   reservation is not complete yet.
+ * @DRM_RAS_RETIRED_PAGE_STATUS_FAILED: The reservation failed, and the page
+ *   may still be in use.
+ */
+enum drm_ras_retired_page_status {
+	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
+	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
+	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
+};
+
 enum {
 	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
 	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
@@ -73,6 +90,17 @@ enum {
 	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
+
+	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
+	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
@@ -83,6 +111,8 @@ enum {
 	DRM_RAS_CMD_TELEMETRY_GET,
 	DRM_RAS_CMD_TELEMETRY_SET,
 	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
+	DRM_RAS_CMD_GET_RETIRED_PAGES,
+	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.56.0

