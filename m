Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177D606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FU6O06D6;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=WeMmqA27
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E6510E255;
	Tue, 24 Nov 2026 20:21:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D8910E0EC;
 Tue, 24 Nov 2026 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795551707; x=1827087707;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=IpBzvEJ76GdUDp40CVISAx93250jKjIHpXzzN6YS3F4=;
 b=FU6O06D6Ej8D26pNQ+iDyttZJMZ8uMXtgRjcR1ISnxtJuqzaLO98ZIx4
 HMtEPe79UXKexxKxWGTWUoCoJ7v9rrIu76/xZzX+zoyiBDo0CM5sIJs4v
 0zDPN+qJcTrBOCw4pPwWRQW4ftVDkNGN0cF1QvoKqoAc3kcEm1skMsK8b
 Rg+NlAFy+cxu8fpgBEwX4tNLHtflSOLv4R3C8LIjElVCXiqcUy7CHmwRM
 7IX+2dBUIP+mWWCBCEIKftwzYal0JESUu18fMNJBTzjf5y8153zv7dVSA
 lubffIpiqW+pO86WRNFdiP0huHAEnJKknbfuWxdXKoDpORAQzX8YZ4okM w==;
X-CSE-ConnectionGUID: sxNnlMEKRxGZymlt93hprg==
X-CSE-MsgGUID: DOiJVEp6TXymP6Zbq4uMXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4267768"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4267768"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:21:46 -0800
X-CSE-ConnectionGUID: BfQlj9apSxijZRRpH7NEmw==
X-CSE-MsgGUID: 1PibYgbnRZmL2gYgHLXHjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="13682201"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:21:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:21:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:21:45 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:21:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR8uYODdtnPRXd/rVng01+Nj8s7pREO96yduqb9Z0j4YubyQSpjs3Ya3LOM46uUYYagbApaW9uXX0xt+zEk2duTsL5wx7v+eRBYllutD4g7wkJyRJ+TSeGmMoyvFozTRuJxk7xZULKhsqNBnG9eo+kvIZUGIeOEO5CXxucYWpfo5I0M5sxXItbdnDwopZ7GAkV+XU+xt8KASMhD0UO6hOt6YTyTTKRLJPqzAlSbKNdZjcfsqNnrBC8ZF9EDJ529774FbbiJHVN6hOfQvZORTMYCuEkAo7Omsf0l21UVHW2NONGKCAHxsGHuoQt0rkREHSs+jeYKQLNHa1TPrUpBstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MpO8/7HP90AE2ljTkPCX+8lyW8sxXJkh5AsN9dAtRE=;
 b=nJkbC/JSoagH2KiT0HxWyAcnT5yFXk54L5Z6SQoENdA9R+PtbridjhtZgBdxEypeaW4Qpw4J5TIjowVNfHaxrrmBDcEn0SfPQ8ltU5+Uju/zm9qRK0H3H8gRl+5tgIkzOilUEASgdKqLb+eSNfVLhSn5Bc9Lca/4Y0bXSgKnXmZaxU3HY7dHiQD8P/RrIFjBIPQECJRt33rAxhVyea1F/puhaqzNQNWjOija2eUCLFhEXQ+FUW6Q5CmsVABUgNBpbeeIgP6KmVh92O7dzMFSIUNnJxGUyz906WsZCCvmUUhtCmtc8bTustUthii41hGOSxzk9jG/NRbkzNfv4QbLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MpO8/7HP90AE2ljTkPCX+8lyW8sxXJkh5AsN9dAtRE=;
 b=WeMmqA27H5IqivayixGpneat6mgyCDXcpCXm35VUKt1hV7I8Nsch6Bcbu1PqDdvFvTDlcZB8u4IP2NNSQcwGtRAR9iexAyjSb++gx52DorOd1xIA8OdIsW3akJ24LGgwJopdcHKpTAYAFXnqn2XfWatxEvRVlqM5CTHQTZABPlY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS3PR11MB177157.namprd11.prod.outlook.com (2603:10b6:8:43d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 20:21:07 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 20:21:07 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>, "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: [PATCH] drm/ras: Do not fail an error-counter dump on a skipped last
 ID
Date: Tue, 24 Nov 2026 15:21:03 -0500
Message-ID: <20261124202102.3578912-2-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS3PR11MB177157:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5c47b8-a240-4c06-577b-08df4a6878d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|261026140227099003|261022075727099003|11063799006|56012099006|261022105027099003|261009223027099003|261102123227099003|261021123027099003|261028144727099003|261021121427099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7l3LEHFP/FMLCjCIH8KtHg0XqVNxd2QKWZcbvU9PcC4cy6tEk0kUAXWZ751XxEoMXsneRBguIgzk0bGq+BvBNdWoto8SUA1UOdUAKLrPqnuVKhZtWk3OSxzV4jBN3RLBFjhgE7uJ/OJBNBxoVJfibZ+89ByD7LJ3zX+mkhXJ8LOKsUGvBa5r43JHxDLds1BWJvh7rtXu68x/8SA/q0UrOfKn/mA94V3tZyhD4ldf3m4dH13Tqjo4Aaa44BsZu6tepAE97N05gY939hyEyhtizHDQ5Enj78O7r0WSt5vWg1BtsYuPczB7SqZvf/qQgTp76Rc3hBASk7m3C8TMMA1podFRjvl4F+i9+KRFy6XDnEcwPnZ/y1KX/jCnMNBv6yJSkCBGLVDl3ljx5KMh1QO/enJKP9Wyrd0Chs41A0Semn8Hy18/rrIDCp1j2bUZK588o+YwM66He4VROZobPmZF+0f2VuEXr/JI+oI+qpbWNB+DaIvz9xkgww8C6OSA7tzjsazNCVaOZiWZFAtxY/yj/mqzpNejU/L83hrN+CnPUfI3qojhbb3/nh5zErLIUtaaLaIOdhJIHDMEzG0J/B2h1IBNWlv19foifCyDToVUYSz8bQuG98MohNGG4bZ6bfC0sIa1LXe2rcEwBmeXRxp7Phvs/b1Qc/RoszqheVM2uFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(261026140227099003)(261022075727099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261102123227099003)(261021123027099003)(261028144727099003)(261021121427099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hCsTnYDzG9nF7PGpRdbWsxiOv59+V2oyMXQIAXeO5rFKBrLwEkJoQ0c+tGhl?=
 =?us-ascii?Q?6ZWPEOTtwpmKcUcTnbOzG+XabK05OhiClfFOSaF1FwJP3GZWHjpAGiHJIaAr?=
 =?us-ascii?Q?rphIb56UMtuJSNKeZGJhrh7gI6FlwilLup0pF8ydUSBjY7C3gATQ4tlMHWQY?=
 =?us-ascii?Q?/tbfzAtraVGZa170t9zEEs4B8Th1OYzQX2VzJTH7zyt14LmSP6aQETA9MqEQ?=
 =?us-ascii?Q?sCkqwbkToD3dwdzzVTs7jFzfA7dMkfw9X5wu/wz4qjzJu/pglqajZcMnu3Uu?=
 =?us-ascii?Q?wqkoPjc5/nIJDgTX5Z6wnr1gY2Xa9OkfcaJ2nWO0jJndIWqCOvn57QzSbUsz?=
 =?us-ascii?Q?pZ3ywYFfOI3VZLNU/jN8pp/du7yXRJ3OuMbq82/wqTt4f4JYkdmmBnBJlP4h?=
 =?us-ascii?Q?4kWkaN8LJBdNohzIxSCx93SbhEDL+VZdAplyBCZkyQKguJBijbLzYvyOxMRM?=
 =?us-ascii?Q?+Jq1Glvi6Ollq4FlDEMJLxT54r9fGqcmUE5rpu6Wa760DvODIkYG5GBbuGs8?=
 =?us-ascii?Q?jiTRlg0xTG8RZycLKt7iSyyDC6CFf0yzfei63oVWbptYbWc2kq6/csi9zeH/?=
 =?us-ascii?Q?9QS/LjWqbuT3gGSyeLIqWwjgbcadk63ldd5MyuCFEsTIToTo+yDFoPKMHWYt?=
 =?us-ascii?Q?CDoPMGjiv5ELNS5zYMOwmbe4n5Bm3OkCR1GswVpEKhSwER8iWXOqO1Ks5qys?=
 =?us-ascii?Q?5bqF/p0UuQZI91i1FiOQa1OkpgOA976NOIoLZoWEZNXRcdxzEMHjBVdoiJ6i?=
 =?us-ascii?Q?nkZLXMrMSW2N3DANq+/GF6T1FjS+r1STlr05biXQUwycIVpvbEDThTrTtkce?=
 =?us-ascii?Q?JQIKoNxXqCEIFqlKRQrl+1Jm2V9Kb1UaeBUpTIY7Wxy2P1ymvnvYqhAUXtNv?=
 =?us-ascii?Q?bHFouG+KKq6CZDFPJnYvXu3r818gPOhcaNa3hWm+5dfDk2bngaeCS6N1asl5?=
 =?us-ascii?Q?+5JUQ1oco+dAcL8+8kv1QONgbUFCnm3L1w7/h5U9Zx4o6ir8FK9ax4Qky+hN?=
 =?us-ascii?Q?S3XGmOl7tdsCqzSuz+bAdNK6g06F93jWVvE7rOpK/0tHsGS5fJOOC5eIlMu4?=
 =?us-ascii?Q?u31fNJW0Y55dpVmp3UcuvCynK2+iEZVqsiNxlEeEbHI0OXPoX2/uykmG3n2x?=
 =?us-ascii?Q?ORfoEWoRx8PSvwkWrVNXGOA4MRwIzJfkB3Ql7ENJqWirbtCO4XEZLyoWuv9Q?=
 =?us-ascii?Q?TxzxsX1cG0FrbHLjWU0mxZSWDM7GqCZxJyG2mooGtlwx3RkQACH9lBccwjLX?=
 =?us-ascii?Q?gYAQxnglOZM/f4h9ifo56X1qRH9DH6jCLffzY/iAvr/sTjulg6iKruPjpzkQ?=
 =?us-ascii?Q?qxt10YLtDXqcurWmdC3VinQm2y03QwG+sizqQzs8n/VUBmrnaHZVEGQHCMNj?=
 =?us-ascii?Q?0N+xDppy/aFYJ2BNA2vXXUwVp7R0As4qUuFoPFObeuIdGG0hwpzXGXxSEBNr?=
 =?us-ascii?Q?rgjzuGrI9HB7tN5nlXtKd7XYcHOJDa6cEdjVB6lee/GiJmIYbqWrRZmJgcO+?=
 =?us-ascii?Q?aAPkkFecWjktIFBrtPRGtXwpeyDHe+IHuht1BdJa/SJmhZGhXGXCfJ1mBJN/?=
 =?us-ascii?Q?69FTYNSY7+JUdvpMb7Nrljga8oKVKsAZDiEWS9qj+UBUdTl4ggAnru58x5GP?=
 =?us-ascii?Q?RpNVkp7PvdSvqkxm6fZ+aX7whARrP5W5p7qFsZjP+FVf4ZMr2lOK2lQpmSRP?=
 =?us-ascii?Q?8VIJrc9sTwMjcaiRE0BSRKLlUKJ/V3C19cGGq5Wjr2efBjisPvYF3yu2gIQO?=
 =?us-ascii?Q?rp5QzQj5uQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: krpBq6NFm3k/BXiUAsxLsU2PLVZDQB68vqTKWRn7gVME2ebAjEqT0vmWccNqGt2Zb6EaVIcDAKY1QtiFM+RfiOzcj0LJzMsTfSsMbtW8O1/1YbHA2OZUYhdyiQWEpHNbBKOzO80VXv0oEAK9QqRt8s956gfggYScc5A+P5vymdNP64W0NszFICsdCkHX2ImsrqolXp4QV69kB/HuFkC3yECxsEnFzscjTJuOcDZ+GsCzl5wboNz5OErhmEBZKxyiwkqftdx1IQ589yOvrIlYe5lw7W5ytbKacx2tOm7DSzYh8mIFaHGUvWt/PN2kgA5uKmaSrxsLFBgpF5zCJmeyqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5c47b8-a240-4c06-577b-08df4a6878d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:21:07.6392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iixU6sqJwKyiqlPHf7PhFYECKW5RtGNGQOuNvoG2LrT3XqvID+sFk46eILUcNXzX0tmzjjwz1kDn9vsUTddp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB177157
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

drm_ras_nl_get_error_counter_dumpit() skips the IDs the driver reports
as -ENOENT, but keeps that value in ret. If the last ID of the range is
skipped, a complete dump then fails with -ENOENT.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index bc30bf0745e5..82fcc766b84b 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -616,8 +616,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 		 * For non-contiguous range, driver return -ENOENT as indication
 		 * to skip this ID when listing all errors.
 		 */
-		if (ret == -ENOENT)
+		if (ret == -ENOENT) {
+			ret = 0;
 			continue;
+		}
 		if (ret)
 			break;
 
-- 
2.56.0

