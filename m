Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0168606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YYn5W0Jn;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=IMoHD2e4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E39F10F2C3;
	Tue, 24 Nov 2026 01:51:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FD810ED0A;
 Tue, 24 Nov 2026 01:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795485049; x=1827021049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=/UozpsWsq7r3cYRqZ7s8MAQtOVw5oI5pf8+09roSpRA=;
 b=YYn5W0JnQZ9cMp6q759RGrkaBBHWNTSquHMgSToRNVfJPNFFW4wVnZhx
 6ENTqIBJ8YtH8APkoAeVZPkRlkFj89JHAFjQl2re8AXm/Iwk1KAvD5Bqx
 7A/JLAj0lxswUETIuPVAziQxb5Q7iiujWN4CoOmqIBb+4cXYNDP4F72rN
 ZYu8Vngy23a0idLC934WnB7tVsh9zYP3valVeODDYhN+X/1hIVSfB+H2h
 4ewm3D6Si6koeCRe/VJKSOoGhXgcRUX3yL3VG8opknrWmuaLYkOTwAYP5
 Kzi/gGyFW1GLP9PXCP7jI5Gd9Ioh8n7JIlzKF/aF519KhYdrj87KGR4Sy Q==;
X-CSE-ConnectionGUID: Oo/B5i34R069BNUENXoZIw==
X-CSE-MsgGUID: BD+G0zyPSNiOHc5vWHn7CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4184266"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4184266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:48 -0800
X-CSE-ConnectionGUID: V+9o3PQLSXCjfK1lFomGRg==
X-CSE-MsgGUID: g7JOOJtdTF6zFxF02JEyTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11757195"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 17:50:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 17:50:47 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 17:50:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/hShYnW6hBfBOqTgT64kW5rrbBTxJIWAS3Tioh1zG27dXKp/tYc0DP62i0A1kxtYu7D6OeDQuQ2TevswUFzTRqvcux7d7qTA5jVW24wva5X8y8gfMwj3sZKBYj2ZM3IXRehRBKBO5bBSNAtyG8+n5+DxQGEJ90h5FCl9j+YeRomXsnO+hXEU0kUwmDbIVohrvJkqwO8oMvxwQjiqfOumJJbpKhwrhM36ugNgGVoHdPQxKYjKC6YXdCXktg9X8Nhypo0XbHMZH8YhqnQVEYwvQrK4wU2QLNMKtj4AjK8Mf2s2gYQABIgFFF0IXHE87+ZjNkMWvW8ylqIOkm6vqmYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbJaX8j69SCbwzde/koSn5lcDm3moJqBOYp5DHIIy6s=;
 b=C7OQLOOSe/+B+BZsSNm6Nfqb5S5SCRtJmagNhuon9c/7IDytyl3h8N+pKyzQR+o0Ta4adQxFnLMsYaLYqVl33DHEQogbRpGOhW1nLZi9UsGOmVQRYtUwdyIUI4zYpRueeLrE1c+X2BMgNSkvBk7n51QxYL325hGpZMI4Ofo/7lnTwuIWwjyBW54qHkg5MLJ62hjJA43YHOqP16iIoy1bD/vPpbI3gIeA0cFp4bhHknuyWPBW+zoAf9QMkypR6D1fKiUu7TbNX+f/wH7zfmGE1XsaeAfsy8JpEAVXrSBiLX5RJzcZV8aqp1zZOKAcKwBfUews1J9/auENvnx6qd9low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbJaX8j69SCbwzde/koSn5lcDm3moJqBOYp5DHIIy6s=;
 b=IMoHD2e4RN+o9f31q1yrgpmkqm6IHgHP2ff0H3gJ0+O5fScyNIcWxEnSDM/kbEo8ptkAl/v7raw78wYBG9Numn4+LE4IFepoZPW23N1/ZCTXFLR05qWacDbRX/BL4et8KBkPlGGPLpkbEGYMj2VhdleSq2RyOXaNaO5wckaVCMo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 01:50:42 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 01:50:42 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: [PATCH v2 1/3] drm/ras: Initialize ret in the list-nodes dump
Date: Mon, 23 Nov 2026 20:50:37 -0500
Message-ID: <20261124015035.3100218-6-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124015035.3100218-5-rodrigo.vivi@intel.com>
References: <20261124015035.3100218-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CO1PR11MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc5e837-bee0-467d-49bf-08df49cd5926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261026121527099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 1WfZrIjyRh7uuyWNNamoeCFbzoMn2YHGwNSRnlVMhRfouyV6mxldvlFZubPRkMoy60RDAM/sN7Tgo+Ajo9BCglyM4y2Ro2D3ZhhWYAqblpLRoK+X0cFhu3NnKQpAOS66cm5pnKWAlftMcBAC27Wi3Y9dtdn/4CNIoSrNT7hJYqy069ccy+RNBn8UaiBgF0cExEDMe5RrhBwpNYR8lB4FR9GL/sfqLng8KVowqJ3sdJNj1J+7+5XB4YWCL9I7UOY0huR5LC7z7JcSgauxVX0e7m9Y12Ew7Cq7WVETTONRnP+oXkdronAcARH3/K31RKZ2ju89NEIxXqf6hH6kViqa93/TSbzekqmSYGer35gzd0C20XiytZWN/Ke+Fm5YppOXtTxEQ5OWo1CJWW1RsOQqUDjBULCGFrLUdDVrpVI5QhwuqkuR5jqz0knZju1rt8cz8Ay4gjKqWEwvP/0POM3d/u8uQ7HsaWkcUrXmd3xVWUVmudVExo9mKdlWI6GInTW3ECKGALXHt931HFVtvtzZAPP8EhqfwCVrOuqaI6dvSLRc+OUEFQbPb5E2kxGmb/CV67PkguDDiRm0iCz5PFz9F+VYXFPKpdUGVypsQpqbnWw5crt2OE6hi5fVR8of1L07T0cj6Cxjewa8tEcosJ856FKP6R2sbNvVCTvk8xklhDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0CBSEy2OUuWVUHffB6LAF8o3j/41NClOrb9Na+1r131vLJ7cqhA7zCB+ipg?=
 =?us-ascii?Q?04s5vvdY+jTZvYcM/rtpXbAqOLpY1W+yck19DqbKwqeNc6+XjoS0RGZD7f65?=
 =?us-ascii?Q?9t0XR5kCDV5sUyZevGq1eYK79Z+MY8GjDLraB98oPvPsbXiU16D6KdW9LnbW?=
 =?us-ascii?Q?xrEWuL8iFd2EtsCyYUmIUImQOHr5mjhn3vSd9MOFcHa6qcmBLkpO/9U8ZOnk?=
 =?us-ascii?Q?c+HSe6ZolYL2LI9T0w8vwBDgx2sX7MKpig2x+1r4TbkZne2p+p0/Km1Hg7Tt?=
 =?us-ascii?Q?MVkJISWDG6mrAeJyc1OYb3Pgda60qPsYAh0EtpO1htHHO+b19UtyBwI+l0He?=
 =?us-ascii?Q?fwwoZuJFBVxR4MGBmoDDNBHMRlYBbuvsJYbKGpXyaI+OyQW4kS9CbMHKCm9+?=
 =?us-ascii?Q?oclhYrL63Sh/fPFV5XyIFt0NRm7WDVf6AORSgY2wT+DjtgbF3WEcATDE2GSY?=
 =?us-ascii?Q?etFut9W2psbgDksd7TGI56Y1Qedm8wKsFrJy7ih0ADryqSNRbiJtF784Tn1+?=
 =?us-ascii?Q?B0Onau4GQmhtxf2xoTD37SKfaf/nRbMsOEo+RKcAa5TuEmlcSEcEBFaFvcQ0?=
 =?us-ascii?Q?Q5nHVkrMK7lJL7NBKbBNLFgh/aSfZ+BmFQCl83bKiBNjiXQgRn8qR7/jcEyl?=
 =?us-ascii?Q?VyrXWjK5Me9qJq4VxgEk8UXeXYfOylUNDbqjVMixPc+1r9FGAjv+cBfJUERH?=
 =?us-ascii?Q?aQYb5ENv1miC/b7GjwD2pns4hu/69V7rpxYYhMbGqadXskYvcFR6caJMY6AB?=
 =?us-ascii?Q?9uOAIzAAPEHqzK7Gs3AoXYJqfT1jtFdnP/HQNex/BxWSD0knD2457b5/Bwp3?=
 =?us-ascii?Q?VOISMhY2ccIvf1a9xtnQwh6+LKasmpUS+8HqX9JKGVYSii6eP1oBhgDFn80/?=
 =?us-ascii?Q?8F11CxvqSnU45GfAQI6EgIA/7/3AOsfBi4n1bfBoG1mGIQ2F9Dzb9K6wn/Oz?=
 =?us-ascii?Q?qz7CzZ7A4kJrqee+Rm4/8x9IMvnaLsSapt6FzYP7Gwec4pAX8C1ToNF4alId?=
 =?us-ascii?Q?EzioQTibl51SAF/pHOAT7t4yrKWpnwnjuNaG0IWik/YMw1kgzJziESY4ff7c?=
 =?us-ascii?Q?DPS1dM3IObeEUt5AVaBRpBWC7dGoyJDfOq1okGWvaMYKOiDWF3ioHVjQlJsa?=
 =?us-ascii?Q?zQTkJD2N9iFSya/IgXQLGNFglOaABaNuS19OA4ASs3sSD8XA7nhLAUQgFOxK?=
 =?us-ascii?Q?SuPBy07CmUn2AeFZ8ST1mZlfHM2XeUi0EWWvgNDYYZnIM5N2cF/S5VorzO4a?=
 =?us-ascii?Q?yOKe5t9pDDKMg0+FhOzJOLdPz5GBRjEGwLhjoLU9pENkUL6DOivIu0rgGu4e?=
 =?us-ascii?Q?Eje2XPvyoMwFMd0Bga10xCwCpJOZLA9qk+19fmyHdBoEK+fE24UTKxF0knJa?=
 =?us-ascii?Q?uBLFi4LsnqO/Qs190YfnCv7AYhdbFiYvWTwHiCWIVi37RddA2q2LEb8cXUmP?=
 =?us-ascii?Q?soCVlWf3OsI/FOfq8lsAMruLRhTVEqnloVLOZCX/hf+Et9eKDkyJIzRWrHXG?=
 =?us-ascii?Q?6h7Tb9mlc6OORR4Td0aR+BwvkkNiWYn6fzoly5tWSUvzt7CQmuE/3j+SwByZ?=
 =?us-ascii?Q?yMYoaGR0o1gEv6/2SBTKVa8vBfFKRX2Ye5J8OfL+EMAClVSkABL0P0bIq+pA?=
 =?us-ascii?Q?MetBNzF00nSMMfW1j0TtOkRj4pWIcRKySd1wbFU7vw7o/i/oznHEtOiAh7N4?=
 =?us-ascii?Q?87jNqUb0THGb1WrKgg3zFq0Xw+Mz0VQO078j+nZM6GPFmDyvSGso+rwrJgUB?=
 =?us-ascii?Q?Z0fAt64LXQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: dddH6GR7MusSacXMOtWvkOa4zrhI0Z4x3hTlGv8Ard5WkvmC/P6E5bR9O58LEK3QwKNKEYrgP2WpHodFEhxjbbD8aB/lZjN2H6/FlaV5XOfU9AX4x+uW+nwdlWi07Bj8aGaQMY78l4uMZ12O4/k2qz6JwTGRuGuNGlUmtV9wzPnqU7T8+DTzGrDU8GtcC72qsOS32blAsTLzTN28luXbYHihIFi6sWG1qGWuKxM32gNo7emKKQT+d7wqgQ40s7aEAkQ+yIbLZhDBlHpHCdWnTObyU7d7Gnnj1uovjY1MDJtEpndn7RZhgu/Q9eV6Bg2XzxKht8biKuvRM1IxJ0lm+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc5e837-bee0-467d-49bf-08df49cd5926
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 01:50:42.4678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7sOYGVj9HUqzOQSvxCrtp+Yj+NUWePgJ3XKNNPhyA2e2c+6/hpxR5NxrywitOPFDyXeuSRkoghvqFXQ66JauQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4804
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

The drm-ras family is registered by the DRM core, so list-nodes can be
requested while no node is registered. The loop then does not run and
drm_ras_nl_list_nodes_dumpit() returns an uninitialized value.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b099eb67836e..4f4777060a4e 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -130,7 +130,7 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 	struct drm_ras_node *node;
 	struct nlattr *hdr;
 	unsigned long id;
-	int ret;
+	int ret = 0;
 
 	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
 		hdr = genlmsg_iput(skb, info);
-- 
2.56.0

