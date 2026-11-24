Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34524606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B3ck2ZFn;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=KLxoAok2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C4310F2DA;
	Tue, 24 Nov 2026 01:51:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828F110F2C7;
 Tue, 24 Nov 2026 01:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795485052; x=1827021052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=F0KovYYqSHiNI2zvf4BYFt9JEW2AurFi3cCkfofVqvo=;
 b=B3ck2ZFnzkAGzXscG20D+62UM0z/wxvJ95TkwNgWHlx9m8xDgyUmrxIc
 gQykVKBq2Hh5uOYCgh35iJzUMZ0jLB3kn3jXong51VBUyQGoSQTOy6N9D
 6qUXRjb7j/Tkv5ibb4seLL3ShauSwxcn1s+rYl/wLRZB4EmzjHQX3kmaB
 UQEDC2ELSehnl+HfrxLhWnHl3LCA6pav5RFmwob/fH45xZ43od78xRngI
 z4PrsoycgAUsLHtvrqjt7Fpjt7KDsPH73cNKwGaiZEqTRvxzHWv4ejt2r
 f1peEf0dEeT+y3rB92vbB7UbQSQUB6To63KFGWfBmurCKetBYr3dEBd6b g==;
X-CSE-ConnectionGUID: SqUuCUh2TOaJcjUeV69KRg==
X-CSE-MsgGUID: EPr+ZtjaRtK2SrZZkl7tMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4348834"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4348834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:52 -0800
X-CSE-ConnectionGUID: Uh9CZkllTFGmpoiJDYVObA==
X-CSE-MsgGUID: N/2LFNSEQnyYBOKfQz/nUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11521459"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 17:50:50 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 17:50:50 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 17:50:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7l/viJ4ve00j4Jg4UI0//oVvuQ9BEnGRZ4f0NyZTpDhDljVc0z7RYSOVhhfpa7f3cjIjnBK1QKJwy1OTwDmAnWykD3MGxIBgVFOTOBy+oAtNlgLBied9bpDA8zOVit051fj0JZaFYsmLmoi5nYcXHjmLYqujZJ2tx1qf7q6JlZKPyPkBlanBACnts5dRK7t83NwgffIxO/2KBKouX5prCUZs4QK14zgVfawqXi5dTn3DNB+KjbJfxV0k1iMRxGN0prgQ7Q6o4FssIAzfiZ3cBIt3xHNqOfGWMIYca3WMKtTTlBaiD9z+qOU2JPi026Q1nfKBnoL8k/b3xmtY8hBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0YQTNWFJ8K+jiVAJ+GEu2yacMqk2e+24soQq1Ia22s=;
 b=U07mp88cRcwOzDvVigVwVyEWBswx9rQfXh+kPVnVCsge28zeS6yTH7+I4KKsiMjiu6KFkryKyD9+Z4NQK3hE//Jek+iDXGnV9qJQ3hG5Uqr3z8BL9tCgUfS5vJPBG7HyT+NdUb6xDjw8xlgBpTV/og7jlWVZ+g9FUsgYYVyCN7s2wUEpqy3u+oMMzGR/BFjZz1ywngKCG5O8Fw/LIEmdmgJBrgWPAxpUvnAK/ARV2+2T2I7Dn7gvJLnHx8cdGjWb2vtnevRMCQsTVnHuAEEnZ9HupSW5+175fQBT5C6x6FnMB19bZqGwnVI0j6+xGvaMd9d5TlbeMYPXrRAI9SagtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0YQTNWFJ8K+jiVAJ+GEu2yacMqk2e+24soQq1Ia22s=;
 b=KLxoAok2qCOSzRLXVhkpe4xxwBeJDqURcbM5R8gFwIO93QJemL24jbtY9Pxsi3IkfLW8NXDU5w5Vp2zc8eNuhXmGQl7ziGtyaJIH0IhkplmJRH7aSVcXCeaMC7qSymNfpAFZygPjHaeUU1dFtOaveLY9hC5eqLWNT7wtNvg3lO0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 01:50:47 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 01:50:47 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v2 3/3] drm/ras: Keep nodes alive while netlink operations use
 them
Date: Mon, 23 Nov 2026 20:50:39 -0500
Message-ID: <20261124015035.3100218-8-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124015035.3100218-5-rodrigo.vivi@intel.com>
References: <20261124015035.3100218-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CO1PR11MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e410d1-8ed4-4352-3665-08df49cd5c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|261102130727099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: DP04CjFeWhoXMPlS0rW4FhJzVqa7OI508OAw5TXKFsZa7TfyZZLreE2H/OyNUEga+DhMuHUoawGllqvrzaPIh8AypSD904My/R5WVT8sJmZxeb/Qasx5kRRPHMRxWARr+fON4DvI8VDi4HjsdnVpCI0YVxRaEQ1twq6GsYr3ejfY5HOjBX8F4WIhCjUh/G7zEABkxuUYRIS0mAlZHBTvHhGeN4qCC6PZbUgRRImky4paIfp6bQmQ0VmaWGx5DnGVwLBi9mWc8bNQOL47TBbIGemLc91XrDB44WkwIr/chbkn1Pga4+zmI943uAQDx+nXaUewJSobEHS5eOdzQt01yteehi87gGZRZ7JPmrFo29AquduATkxIKZWwD7LNQBdSrwGVSdviHbRYYovmxK9HYwWn6x97wcA47CihjQIyPKeFd/QuXPfHD7qzNkdeKe7oXUG0Sh+fF1P5szknUdd5cNZGjgLb3EEi0iWkniYPjjIz0xpSEojHOI3L/lK2+RjzsOJRMEZ13yOxO2yrX+7ZMdmwihk1ERZUXGA0IPoxTWsTKYW+7/AXXMnRhXOuI71FZwfkvQek2zhwbeRf96UkVaU9EHwZ7Q/Hyt7NfWyL/x9+4IbUFx4YCZ0XTZz55ikeOYNXFIHEsoVWW5bbAxUM7/0mepMi8ZEoMm9Yz+Rou3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102130727099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0a1EbgtfMrLHoZr8YzjdXCNHhn4PZM2T/QdQkUKDiMIRwWa2DkfXadQeFPkd?=
 =?us-ascii?Q?mFmS3J1liewF4p1fCmgTO23zMUK7OKgKLN8yapIURvQCgE0A0pN9Uv5sgfVF?=
 =?us-ascii?Q?tr7O1YD5AhtL4fN3CD0GnVcqthhmScQ5QfBbaQADnID5ZDXIhfuBkdPzY8we?=
 =?us-ascii?Q?i30IG0nEwVeHcKBDft6UzcInJtqHmX0+yrwVdIJDJX6KJGgq2gCSI+qyZxeu?=
 =?us-ascii?Q?nMwNT4G68djHCWgOuoZqNzl841jYtKSHlGcOLfA696QkoVlMEbZf6Ui24KFQ?=
 =?us-ascii?Q?T5/Qm25Kpwqy6xhd1yofsrbZbv0AT/6fQhi7r4tJ4fTy3DHcw9aTduQHkoUJ?=
 =?us-ascii?Q?pJOXoegmsDk4UD1pHnj+MjDSapxIz/QbkA0ieDq6E0kcroGyuK4ox5LKEdvY?=
 =?us-ascii?Q?bwlj9ZE5AtQg4rMSOona/OkhKHR+5lHxl7hYvblKzu/gVgYy9C9kzjG+7BYh?=
 =?us-ascii?Q?kKfKY34VIAXG4U6A03BmOPYdxb/C2tPtrxLGNja4kwh3rMayO9vQ9fijdLqy?=
 =?us-ascii?Q?LWQpgWjCoR1glcPyditHtRg7FTUpvm5pQstHTdcHFpMwQkjMIU51d3Vqah1n?=
 =?us-ascii?Q?muaMlo2sg+hKT5AN1Px48pl1CaKykuYZ3lGdY+jwZuwidUO0RoTkwLMCqoJo?=
 =?us-ascii?Q?pYMQMAvb6H+uVBY4apbfe3iaF3GOc04YDA+sW7DaWdeF5vaPvfAeXVt4vqDl?=
 =?us-ascii?Q?Mb7yaV5wTtcG+F+REwHnMqQuZ5UaKGN/fdaEyABHFoMuyYokJUzHEXVOltRl?=
 =?us-ascii?Q?CkqYyZhx3k6VR4hs3KDBJqgIN/3hDSgnPluGDSaBRQTpRe13ICD6O6h7P9dZ?=
 =?us-ascii?Q?ws3LS/FW6gllY0HsEcq5xVpltYb4wUGhNpslC+9OXpQ2+9jwT2b2wl16lFoS?=
 =?us-ascii?Q?OL0essTOo1gkzaN2iSHOSVIlJG3AiGYq38mcUJyPTFcdLaQ/gNVJu0Rc58eb?=
 =?us-ascii?Q?KM+BQtsmdZ3gFcHzSMFLvWujWGE+6bsbadcMoOOWPdGsiN2RFpxW8u4gUo74?=
 =?us-ascii?Q?8K2X8Qjy+2G5B3LGJ7NmtB9HTjVbDntxs9XdCBA/9Ah8JbchHPwfxnJRm+RS?=
 =?us-ascii?Q?iCgOz9uDiwNz/1jumJv8dpdIJ5O6wVYZLBOZAv5WnydPBiG6qSUk8lYmpOxF?=
 =?us-ascii?Q?4Ma5S7qv+tTVsBjZa4tvLfv0h88VnB1IQq0L59Dx3toQ5vGkmMS5C8Ly5AED?=
 =?us-ascii?Q?u3tzh6nu1B538rh+JuKSDR/6nKJ82dSqJHwQ+llvC6ALa++dr0T0KG0YPPE0?=
 =?us-ascii?Q?xjnKExc19g5jVXuVji6abN8tuKyYGe4imUsW1fhUuU96Sc3XNBp1n6UUV9xT?=
 =?us-ascii?Q?Q1qi9iI6L+Vz4hImBpKPqz2aX1NnbJjF6wTe742vzBMjC1OjCTDbaDqkFE+O?=
 =?us-ascii?Q?A62C00Lm/AEuUgRLygNB2TBEd9okqtQG37m8wrXyBnljc7j8C2YlGnqLEvLe?=
 =?us-ascii?Q?5MFvZg/JC4SUZpAc/D+pN0oczUvxkCtg68NV1DGF5kJdgsQTaFZ7xCh8uBNf?=
 =?us-ascii?Q?v8meT1yUKK76nRylPiJ7wCbXP/BBlL8B3JWT3zwyvUVFbke9bVIhUk6QsIh7?=
 =?us-ascii?Q?v6PmVwDjNZNUTSoL/NDXxq0bQqFlI7l/TTp1807KRX2FTZk4y4LMCItL41Cp?=
 =?us-ascii?Q?pcFiurD/zmZ0UKf2D1DwL7I2XHxsQ5X+H7i2HmQg9gaZ+9irytMS+SSfxAwC?=
 =?us-ascii?Q?f22a8zJDv8+nwGlspvWVAPReTCVGApywZhtE7BmLwfYGwvfWEsEOBPLB3iJ1?=
 =?us-ascii?Q?NEm0NVkknQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: XfuWMIww2kcZhsaWi65gmHNzNwKGqQyTNb0tUKZjvisEQ3ADxrsjL6ZH9I7pdViGuJckKBtOXGEKCzuXH6zByrXM1EBt4Lg2YK+xWnaitSuNFQ2xhqhRT5UKO00/5i8eiTTAjEf6dIEZ5s+sTo7QIe6tot4K9WKyxjjM3GTCYnOPp+vsp6TCH6AXqcE8uVRNF1rc8ASH+xZdb7IvQROIuWhv/0AyKLUsiS2KT3Az6Y7dcEJUZIeGX18WuoPY71p3nP9zU24OW4n4pNA8Kac/ecWm4msGG8lhPqLMBtjyZt69aeU//gjchf4vqZNr9b2pm2FSUkapPScbXN2jSSqtHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e410d1-8ed4-4352-3665-08df49cd5c4b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 01:50:47.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BnhWBxE4J1dKPLJ/g1mudUrsBh9rcOGVq1jFwN7qk2188s5zNhAGscHx94N+ITuUTKICpjav8sLUUUASI6xDQ==
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

The netlink handlers look nodes up without holding anything, so
drm_ras_node_unregister() can return while a handler is still using the
node, and the driver then frees it.

Reference count the nodes: the xarray holds one reference, each handler
takes another for as long as it uses the node, and unregister drops the
xarray one and waits for the others. List-nodes only reads the nodes,
so it holds xa_lock instead.

drm_ras_nl_error_event() gets the node from the driver, so the driver
must stop reporting events on a node before unregistering it. Document
that.

v2:
 - Take the reference once per handler and pass the node to the
   helpers, so the reply and the whole dump are covered (Sashiko).
 - Use explicit get/put instead of __free(), which also drops the
   DEFINE_FREE checkpatch warning.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 135 +++++++++++++++++++++++++++-----------
 include/drm/drm_ras.h     |   8 +++
 2 files changed, 106 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index f561604e7e96..8feaf787d904 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -107,6 +107,29 @@ struct drm_ras_ctx {
 	unsigned long restart;
 };
 
+static void drm_ras_node_release(struct kref *ref)
+{
+	complete(&container_of(ref, struct drm_ras_node, ref)->released);
+}
+
+static void drm_ras_node_put(struct drm_ras_node *node)
+{
+	kref_put(&node->ref, drm_ras_node_release);
+}
+
+static struct drm_ras_node *drm_ras_node_get(u32 id)
+{
+	struct drm_ras_node *node;
+
+	xa_lock(&drm_ras_xa);
+	node = xa_load(&drm_ras_xa, id);
+	if (node)
+		kref_get(&node->ref);
+	xa_unlock(&drm_ras_xa);
+
+	return node;
+}
+
 /**
  * drm_ras_nl_list_nodes_dumpit() - Dump all registered RAS nodes
  * @skb: Netlink message buffer
@@ -132,6 +155,8 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 	unsigned long id;
 	int ret = 0;
 
+	xa_lock(&drm_ras_xa);
+
 	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
 		hdr = genlmsg_iput(skb, info);
 		if (!hdr) {
@@ -169,19 +194,18 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 		genlmsg_end(skb, hdr);
 	}
 
+	xa_unlock(&drm_ras_xa);
+
 	if (ret == -EMSGSIZE)
 		ctx->restart = id;
 
 	return ret;
 }
 
-static int get_node_error_counter(u32 node_id, u32 error_id,
+static int get_node_error_counter(struct drm_ras_node *node, u32 error_id,
 				  const char **name, u32 *value)
 {
-	struct drm_ras_node *node;
-
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node || !node->query_error_counter)
+	if (!node->query_error_counter)
 		return -ENOENT;
 
 	if (error_id < node->error_counter_range.first ||
@@ -191,14 +215,21 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
-static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
+static int clear_node_error_counter(struct drm_ras_node *node, u32 error_id)
 {
-	struct drm_ras_node *node;
-
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node)
+	if (!node->clear_error_counter)
 		return -ENOENT;
 
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->clear_error_counter(node, error_id);
+}
+
+static int get_node_error_threshold(struct drm_ras_node *node, u32 error_id,
+				    const char **name, u32 *threshold)
+{
 	if (!node->query_error_threshold)
 		return -EOPNOTSUPP;
 
@@ -208,14 +239,8 @@ static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name
 	return node->query_error_threshold(node, error_id, name, threshold);
 }
 
-static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
+static int set_node_error_threshold(struct drm_ras_node *node, u32 error_id, u32 threshold)
 {
-	struct drm_ras_node *node;
-
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node)
-		return -ENOENT;
-
 	if (!node->set_error_threshold)
 		return -EOPNOTSUPP;
 
@@ -287,7 +312,7 @@ static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *er
 	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, threshold);
 }
 
-static int doit_reply_value(struct genl_info *info, u32 node_id,
+static int doit_reply_value(struct genl_info *info, struct drm_ras_node *node,
 			    u32 error_id)
 {
 	struct sk_buff *msg;
@@ -306,8 +331,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 		goto free_msg;
 	}
 
-	ret = get_node_error_counter(node_id, error_id,
-				     &error_name, &value);
+	ret = get_node_error_counter(node, error_id, &error_name, &value);
 	if (ret)
 		goto cancel_msg;
 
@@ -326,7 +350,8 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	return ret;
 }
 
-static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
+static int doit_reply_threshold(struct genl_info *info, struct drm_ras_node *node,
+				u32 error_id)
 {
 	const char *error_name;
 	struct sk_buff *msg;
@@ -344,7 +369,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
 		goto free_msg;
 	}
 
-	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
+	ret = get_node_error_threshold(node, error_id, &error_name, &threshold);
 	if (ret)
 		goto cancel_msg;
 
@@ -374,7 +399,8 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
  *
  * Context: Process context only. Uses %GFP_KERNEL and multicasts to all
  *          netns, which is unbounded work; callers in interrupt handlers
- *          or other atomic context must defer event.
+ *          or other atomic context must defer event. Must not race
+ *          with drm_ras_node_unregister() for @node.
  *
  * Return: 0 on success, or negative errno on failure.
  */
@@ -462,15 +488,14 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 
-	node = xa_load(&drm_ras_xa, node_id);
+	node = drm_ras_node_get(node_id);
 	if (!node)
 		return -ENOENT;
 
 	for (error_id = max(node->error_counter_range.first, ctx->restart);
 	     error_id <= node->error_counter_range.last;
 	     error_id++) {
-		ret = get_node_error_counter(node_id, error_id,
-					     &error_name, &value);
+		ret = get_node_error_counter(node, error_id, &error_name, &value);
 		/*
 		 * For non-contiguous range, driver return -ENOENT as indication
 		 * to skip this ID when listing all errors.
@@ -480,7 +505,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 			continue;
 		}
 		if (ret)
-			return ret;
+			break;
 
 		hdr = genlmsg_iput(skb, info);
 
@@ -498,6 +523,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 		genlmsg_end(skb, hdr);
 	}
 
+	drm_ras_node_put(node);
+
 	if (ret == -EMSGSIZE)
 		ctx->restart = error_id;
 
@@ -518,7 +545,9 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 				      struct genl_info *info)
 {
+	struct drm_ras_node *node;
 	u32 node_id, error_id;
+	int ret;
 
 	if (!info->attrs ||
 	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
@@ -528,7 +557,14 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	return doit_reply_value(info, node_id, error_id);
+	node = drm_ras_node_get(node_id);
+	if (!node)
+		return -ENOENT;
+
+	ret = doit_reply_value(info, node, error_id);
+	drm_ras_node_put(node);
+
+	return ret;
 }
 
 /**
@@ -546,6 +582,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 {
 	struct drm_ras_node *node;
 	u32 node_id, error_id;
+	int ret;
 
 	if (!info->attrs ||
 	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
@@ -555,15 +592,14 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	node = xa_load(&drm_ras_xa, node_id);
-	if (!node || !node->clear_error_counter)
+	node = drm_ras_node_get(node_id);
+	if (!node)
 		return -ENOENT;
 
-	if (error_id < node->error_counter_range.first ||
-	    error_id > node->error_counter_range.last)
-		return -EINVAL;
+	ret = clear_node_error_counter(node, error_id);
+	drm_ras_node_put(node);
 
-	return node->clear_error_counter(node, error_id);
+	return ret;
 }
 
 /**
@@ -579,7 +615,9 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
  */
 int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drm_ras_node *node;
 	u32 node_id, error_id;
+	int ret;
 
 	if (!info->attrs ||
 	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
@@ -589,7 +627,14 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	return doit_reply_threshold(info, node_id, error_id);
+	node = drm_ras_node_get(node_id);
+	if (!node)
+		return -ENOENT;
+
+	ret = doit_reply_threshold(info, node, error_id);
+	drm_ras_node_put(node);
+
+	return ret;
 }
 
 /**
@@ -604,7 +649,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
  */
 int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct drm_ras_node *node;
 	u32 node_id, error_id, threshold;
+	int ret;
 
 	if (!info->attrs ||
 	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
@@ -616,7 +663,14 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
 
-	return set_node_error_threshold(node_id, error_id, threshold);
+	node = drm_ras_node_get(node_id);
+	if (!node)
+		return -ENOENT;
+
+	ret = set_node_error_threshold(node, error_id, threshold);
+	drm_ras_node_put(node);
+
+	return ret;
 }
 
 /**
@@ -642,6 +696,9 @@ int drm_ras_node_register(struct drm_ras_node *node)
 	    (!node->error_counter_range.last || !node->query_error_counter))
 		return -EINVAL;
 
+	kref_init(&node->ref);
+	init_completion(&node->released);
+
 	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
 }
 EXPORT_SYMBOL(drm_ras_node_register);
@@ -650,10 +707,14 @@ EXPORT_SYMBOL(drm_ras_node_register);
  * drm_ras_node_unregister() - Unregister a previously registered node
  * @node: Node structure to unregister
  *
- * Removes the given node from the global node xarray using its ID.
+ * Removes the given node from the global node xarray using its ID, and waits
+ * for the netlink operations still using it. The caller must have stopped
+ * calling drm_ras_nl_error_event() for @node.
  */
 void drm_ras_node_unregister(struct drm_ras_node *node)
 {
 	xa_erase(&drm_ras_xa, node->id);
+	drm_ras_node_put(node);
+	wait_for_completion(&node->released);
 }
 EXPORT_SYMBOL(drm_ras_node_unregister);
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 1765a3130b09..cadca07aeb64 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -6,6 +6,8 @@
 #ifndef __DRM_RAS_H__
 #define __DRM_RAS_H__
 
+#include <linux/completion.h>
+#include <linux/kref.h>
 #include <linux/types.h>
 
 #include <uapi/drm/drm_ras.h>
@@ -102,6 +104,12 @@ struct drm_ras_node {
 
 	/** @priv: Driver private data */
 	void *priv;
+
+	/** @ref: Reference count, private to drm-ras. */
+	struct kref ref;
+
+	/** @released: Completed when the last reference is dropped, private to drm-ras. */
+	struct completion released;
 };
 
 struct drm_device;
-- 
2.56.0

