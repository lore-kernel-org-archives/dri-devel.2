Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2FB606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OXkhxPqX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AC210EADA;
	Fri, 27 Nov 2026 18:18:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09738112CCF;
 Fri, 27 Nov 2026 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795803485; x=1827339485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=u/pv9YNuopxeTVXxUbHjNlRAVSG8aaGqZtdwOYDXWME=;
 b=OXkhxPqX/tpZqHK4mZg5Aa3s+nlDSbiZKsmbNHrPP4r7pmHJaUw8EdMH
 OjnXcErvOK2FADFSqa5ZiOUQQ8h8JCIDgPGucmI/cNpCH1CsC0BeZales
 JQPVWp0hVhqPuW0ybaC42Yar+QRKu3P0O00D1sZYSd/OkxVlvRQhE2n5H
 xJjcgy+YnvQOTfARsBALMeo7umaZDASEdyAoRK//d+so0LJsLrW0z1Ei8
 gWqTgQ8jPCEAKHzA0A31/MDXgpFAku4A37RLl14Sjtvb+Z2E+6CQyB8yV
 LVi/L0wzfeMDX/5GOSafWtHlngzK7UNxAJqyHrAPhv3K4FEhUHERUSlZr w==;
X-CSE-ConnectionGUID: TFZdbzKsR9CCRP2D6of4lQ==
X-CSE-MsgGUID: 7LAxFCB5SSCEH89U9GC9yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4611440"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4611440"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:18:04 -0800
X-CSE-ConnectionGUID: UcR85XIIQB612SR7lXm+4Q==
X-CSE-MsgGUID: 4RiJjyqiS3SH6vD6evv0nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12600299"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:18:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:18:04 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:18:04 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:18:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFwimgQUefOtGzGiAruhLsYt2Xxqk+0XCKQ1TBPl0FjV1Qah06R2mtzxmd9vwvDQ+Pmz2GKmmAbMal1G5eGcyYWBykZcGF0js/FVivK5saPfmBJS3htf4PJXYvefzPk9TFDEvImGffhZdoLMRu+YqodzI1ld2JTbjUxlzz9MoOoh0rRCAWKvasSLhEBS1/tcZLQtFvF0h80do1zXYvO9uOr8T5OLxy/Sxm+hIYeSSZ8Z8SmvEN8wK+I1uv6adF2OjjJRbJi4y+U/nJWpzxjTdA7vSaHR2Iua7u1DXmx8C+sjJGskSA5JmWwXpxXOBhXVjTbC15/hnIB78ekiMK19KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1V1o6xezc4lLafEMzxrjQenPayyT6t1gUZQkEm49r8=;
 b=QlOJ0lElYOJwca8p/pGaHaxveRsm/j9wvWt9DGIW4BwbI/YvDDaSYMLA6Xc4hYqpqfbuIqJ3aaD+pdyj7jJHHu2A4A01ZTlUslEcYUXmmzeB+B4diYCJ/tVXPS09AnaM67833ZiN4FRTBK9W/8TW15xBZr+fL2pixJnhsKQ7A4zBtpZNKRnagK5ikR91FYusfqlMLqUCYuoaVF77cg+PDXMsLOhcnfftfTeWsk0zUZT2OgX6HCVBhvoB9u2zPxzJS/Cqji3/mopLtlOGWWX/SINqRuyzA4btcejLNrKhnM8EEydZwQJEFRiGMSnB0Xxs6Qc0Gk7OmnBHSEgcmenTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 18:17:58 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 18:17:58 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Riana Tauro <riana.tauro@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>
Subject: [PATCH v6 1/3] drm/ras: Check the node type in node lookups
Date: Fri, 27 Nov 2026 13:17:52 -0500
Message-ID: <20261127181750.806528-6-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127181750.806528-5-rodrigo.vivi@intel.com>
References: <20261127181750.806528-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS0PR11MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cfc1e4-9bb9-4a96-f56a-08df4cb2c406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|261009220027099003|261009223027099003|261009221227099003|261009221727099003|261009223327099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: cLScOz/al6RW/cmRWZse9WlbctJH+OdsjlLK9Q6S9mZ+9c4CKQihUMBlwEy2HWRdjQ2mAS65A4yJwFYdlUpwblJDv2HdUvmMsuA8Lqh/ti7tIzYmUovMr++BMFiiThO2iuzgijNMfwfmjZVNmd2xEtagdboi/IzdY7AR1tPq79N77sNzlwd8OLyBSiwPiIsPop0QztH3J1oiOrAzYt3a3SENq3KzQY/eG7lU+jehI4yjyqVs0YqkSr+V6t11WkguGSrrV3Vdi0B/MwAL4LR9Obr5dwv5/h6Nd6dYFT5AEfGAinCzGLJYuduHKbQRtaQFl6agZdBsq2eXyCD7LPAuE6MnsKegQSfe9NC9p6F87glOCT8iyyPf+ueER2GJzxlYsAZNVcQmObkT852ypL2ByWkFNmKJOLKhJwkdBW5bsODdzswnuZsH7fYdp6HDanohDENdDSmo6hELCa7fuwLbJeZkBOI29Vy93z9I30sgfXYK3s5cHJyynbuejYH8OirfQpBgPLFE0McyMXnNCSSOjozfLZ0ae7cRkIsq1T580h+zkV9NpMF8KRT4bflJv3J0G0GO9zA2kIPRoI7i4gxwTrCA8gmE7ilSaZgQZA9xkawOnjhviZ7TWAw8FwUq3YYtDo/OxlXE0EHDH8TILebQp69oDAtnOz0snQS+3niZRxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009220027099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009223327099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U5vvtcHZrNSV2FPZsGGXKEbmriVl5v3ACH3hKXZ/ZHvTEsUPiqCQlNZquf1J?=
 =?us-ascii?Q?Z1PWdjTq7s5ySazvy0OvMQKiD8JW4oifg7lYBddun4RidPJ9EMzz9eRTiUyg?=
 =?us-ascii?Q?/DIj53k3o1AFoXU4nPMUVRKchEIHDwAesuV7Tr9GlwwRLsMPbAphFzFwmfrR?=
 =?us-ascii?Q?QvT3O5zqm5Lzm5waUD5E8gZP/Sm9AglmU+NOsF9D0imwcDDfJAr8x2KAB7UH?=
 =?us-ascii?Q?exkOhcXI1DsolReSGBqT1ZsJpSgCr3SChF2WFPH6BFAF1YnE0mvfLJzz1qEa?=
 =?us-ascii?Q?BNzmeQaqmZnajF1yGVz2t8ddjiDTL72345nH7CAod8FzvCwg3L1h/Bjsp3lh?=
 =?us-ascii?Q?897GO3//+9BInG5hhncU+lLxkpky/YbconSKU4jOTIAMNMhOgDYyU8leRyvr?=
 =?us-ascii?Q?NFPtHH6rEAeexj0NKgx28ms0ObSd0BNsEsop9cQ4AreBDVUMV6DNacWyemCo?=
 =?us-ascii?Q?er8teh2lC5RH7a/lCCEr0urTT2Po7AVr0TnyhbiyPW9JpkuOrycMM4qFhL14?=
 =?us-ascii?Q?ObDpMIY1pg1iowANIbFPOlDwcEdLRYOr0NReWtK8UH+T7ldEQ1jye9HNin4S?=
 =?us-ascii?Q?d5KBuryVHgHqeoVkmzPU7xVn/A5QSYYMWBsU9UisBagOUviwQkezujQX1GcI?=
 =?us-ascii?Q?hPo+AdpimKOUuDfrUqubEgPKvHDfTzvQQ1jhZKyNIOZLTWxfFzwrB+N1DeFQ?=
 =?us-ascii?Q?xjF0TafmnAqqou4joh9p312zRMgMY3Lezve9CsxGWTS4E1uIaGRjlPoee3WP?=
 =?us-ascii?Q?t5BpuGlcm29BkuSGmrgd4AOB8b53s4ZVxg/UjFelL4EUpWBmqGRCu5cjWq3F?=
 =?us-ascii?Q?XCBbhc7btMB2gSecF+eRpjSF40BdHdp4VJ07SsogPZ8bEyKAQZIK76p0v5em?=
 =?us-ascii?Q?0HX5FyLM99GvTDu+2M2R7d8UUsdxQfxPUCzQVi/4Hma3NBHHmzhkUCpy/apm?=
 =?us-ascii?Q?nonbfmTSwj7Xg8dhGzodY5AzalMnVagUhzsUHzvDNJmHLuh5ex0fov56WzaY?=
 =?us-ascii?Q?ishE07E7iFG0opVoliQN1QFypiIBu4hRF2qTcqH+kVnq1EBvWVm9JW20dYl2?=
 =?us-ascii?Q?B1mDzh7TTVaOvY8VtPyPenfyq2CoBCraaIDzR6TPFdnIzaSDGrlcUQWtcukA?=
 =?us-ascii?Q?5zztKVjSWounD42mLTQx5CgBLevpNvojdoPrGZZC2vVEsHkIF7KWQgVya+Pt?=
 =?us-ascii?Q?JL9CE8RGLDV2LbZgXL7HeGEGA8iQwrVofI1x+DQq5Xb9SRArtqYKJcxSwKQ6?=
 =?us-ascii?Q?IHoftEz/zm53GEUym4YhOKgTgFYi3htbhs/S/soEQnifGiwMS7oCNiq2sl4j?=
 =?us-ascii?Q?mDYotqGTv7Lcfr03L0Oh3E8k/pbC1SpT7wJyOQg4SvFisQgApZzzK4fJbvzI?=
 =?us-ascii?Q?m5KxWFgAroqEE/0yG/O1zQ3VBLL6Pb74PaglkHKJ9iGqYB9Slgo/e98/upCc?=
 =?us-ascii?Q?1Lvm+dALNk3L58Xw9ylBvQgnhyNR8LwaX+vweZ0z1YSNRrwoQsO9ewvA5/3v?=
 =?us-ascii?Q?IVdzCjBNusjj1sVqBmNW12xu03zyq4U5D80UREqbbFloXPhh/A8zMhvbbvxW?=
 =?us-ascii?Q?3xQIoQQxz4c4mXurz2AGEwB7R6PvBnw2Czufqyyttvx8iojdF+jSzrAHpXcK?=
 =?us-ascii?Q?af47XF0kyk5bvgmB8FNyKfqS6vWQqqtqOC5KMHgRlHByUJhCu/oreu47Dp/N?=
 =?us-ascii?Q?O4R9RowbLDcjW0XQOugtDtjeOqd4qM7onp/Szpdw1j6ZufwEVVgNGD5HZbOQ?=
 =?us-ascii?Q?gWgIpNcLtw=3D=3D?=
X-Exchange-RoutingPolicyChecked: YP13Wy0tzyBKpRbJdHy3wE5uhxmlR5SJh7wygdO+/SVpnsatccJONHDPwreMXG9SlpzjFWu70ysfgdkmoKXbeQvjys/oyUZnuIPuQut/vnFNjp+xOqK6zz9DssYp6xmFn6CtMPrh3e0ZNMgwY/RMpwaVXxprJ0Tl9cEAu+E0ncvwNiyeGIcbN8M2cLfZhBwQguiQhUMIueiOBrKPOduyFjEjY5Kp6L2BsEbcsNXTccjLQ5R3Z8XU8DMY12IMA2JXBBhZ0UmSP5AUKOKuVeZHMT35bHMjaByit7dPdFwN640Wl95yZJuqs5xRpRCTmKkUO9LoWxS2nDOWH9lyvyDnyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cfc1e4-9bb9-4a96-f56a-08df4cb2c406
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:17:58.8355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FXM2+ZhOxB5u9s2eKErvTqmZJM8XwC2iWNU4aAcbfVXMVTCUcNmGlX1iAGV/duS6szVDKpKYICztKYlXmoiEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_ras_node_get() returns a node of any type. The telemetry handlers
check the type themselves, but the error-counter ones do not, so an
error-counter operation on a telemetry node fails with -EOPNOTSUPP or
walks its empty counter range, instead of reporting -ENOENT.

Pass the expected type to drm_ras_node_get(), so a node of another
type is not found, and drop the type checks of the telemetry handlers.

Suggested-by: Riana Tauro <riana.tauro@intel.com>
Acked-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 82fcc766b84b..5ae6d0a3b751 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -169,6 +169,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
 /**
  * drm_ras_node_get() - Look up a RAS node by ID and take a reference
  * @node_id: ID of the node to look up
+ * @type: Expected type of the node
  *
  * Looks the node up in the global xarray and, if found, takes a reference to
  * it so that it cannot be freed while the caller is using it. The lookup and
@@ -179,16 +180,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
  *
  * The caller must drop the returned reference with drm_ras_node_put().
  *
- * Return: the referenced node, or NULL if no node with @node_id is registered.
+ * Return: the referenced node, or NULL if no node of @type with @node_id is
+ * registered.
  */
-static struct drm_ras_node *drm_ras_node_get(u32 node_id)
+static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)
 {
 	struct drm_ras_node *node;
 
 	xa_lock(&drm_ras_xa);
 	node = xa_load(&drm_ras_xa, node_id);
-	if (node)
+	if (node && node->type == type)
 		refcount_inc(&node->ref);
+	else
+		node = NULL;
 	xa_unlock(&drm_ras_xa);
 
 	return node;
@@ -412,7 +416,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	u32 value;
 	int ret;
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -461,7 +465,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
 	u32 threshold;
 	int ret;
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -603,7 +607,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -699,7 +703,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node || !node->clear_error_counter) {
 		drm_ras_node_put(node);
 		return -ENOENT;
@@ -770,7 +774,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
 
-	node = drm_ras_node_get(node_id);
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
 	if (!node)
 		return -ENOENT;
 
@@ -808,10 +812,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
 		return -EINVAL;
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-	node = drm_ras_node_get(node_id);
-	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
+	if (!node) {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-		drm_ras_node_put(node);
 		return -ENOENT;
 	}
 
@@ -892,10 +895,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
 
-	node = drm_ras_node_get(node_id);
-	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
+	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
+	if (!node) {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
-		drm_ras_node_put(node);
 		return -ENOENT;
 	}
 
-- 
2.56.0

