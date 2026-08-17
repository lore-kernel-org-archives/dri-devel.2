Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CF5C5DF80
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85B910E727;
	Mon, 17 Aug 2026 09:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KjwZzapH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBF910E721;
 Mon, 17 Aug 2026 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786960636; x=1818496636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=fHpOwdMRKnH1xuh6PgPihLplgIfv96mXiZIqI6PzkpI=;
 b=KjwZzapH3nac/YJ62QNySh3EwgZ5J74zMABARazxG3SG3tMUZvF1/4cM
 o5dtaAk17JdHevGzbWHub/I0AUIlOyVZLP+FhKe1GYgvrxlrK97Ldd85K
 Lh0zQ5dtfuSstdLY+3zC28bTgC0qXSmYsVN3lKv3977iUN50Srid2Yagb
 2rtIkNB5Uo7GM7fhGU58rauryBAbpsHAFOD4OHIwS1N4kTepVfTjjGbGb
 tYiA2Sym337cloYqtr6TzX/hafJlQyPATxL+vcXcJvLd+QZXvOU7zzHak
 nQ01lUF2DhhyJ7qxtxBuKwHnR6wlDd+aaOu0EE3DUAH0ZAwQWnTrzn61A g==;
X-CSE-ConnectionGUID: T7yVRYiTTemkQmsI8xlDSQ==
X-CSE-MsgGUID: r2+I7uCMTi+TAB++w5MUfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98093768"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="98093768"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:15 -0700
X-CSE-ConnectionGUID: owGRVYcJRuawOVEoBXKvLQ==
X-CSE-MsgGUID: itVsi68sThewG0DCkPIxUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="268713790"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:57:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7zUwFdoiPXZ2kNwh16MgJ9J4FXWvzNiN/o71Qu0zZRRedYfHh2pmUoDFGzgG9qctsXMuyyrCwPaJifPfyaSEwDYZbC4VItLeb2/hMgT9tUIgeLnmJrvRl4PuNmMN+fHvm43wVVnsh2Ke+S8hFfLuyiz+nq0UUBKKfoE5gjP6uw3hehkp6nzpGfgd2aPUBSp9KRyEHGxtNUkY3P+qtGeFGTwNo0mu8/T18aW9J1n/acKyNe5q9WSS03hvmW9ak+JrJqCsRXrkzBkKDmR9KISamZwOwZyS4gTiMrlonOIhwLGjubVTBEL2UV20Bw0EeItQyXjWfevxnTF2eNBuzJosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vcd0JG5lt+QaZ5M3ObhPVF2pl9HvdyEX8SNfzW7fXLU=;
 b=P4V9Bb0PxfU0fBroAd8iabvQhCP6w2f0XxQoyTNaxW9OLJcQkGTSG4eCTXXbo962UWDvaJbdpmXQObkovsRlUmcMa6zKwZWhekV14a+j9edg6yvqYlEC3h78OvHiuXY8elU91cTsNJrFrv+e3XtwuvRS6tQxQQgbeDQ9ZdrKDHWSgoMFUqQa250IpEgJjTl7VP1AwQ7N/843lGCh8HO8ZZD4PPRVXDoP+SKvmingGZtQCKgFQRO7XPb+DK/7cRjYi58ZqGpX/jDMrXRIvnDu77ccZJdRNx0y49njfD0XqZDV613KSRDTDtbemkR/DL7DImlfGRoHPSShnwySjiy+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:57:12 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:57:12 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 6/6] drm/i915/gem: Remove iterator and use while loop
Date: Mon, 17 Aug 2026 09:56:48 +0000
Message-ID: <20260817095648.2438192-7-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f91dae1-3fe1-455e-0c97-08defc45e91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qepjI+V+mj1Ugt3+6Ql/bRo5hV/IUNKiPSXcX+5USrcJQvY4hDQUQKrnO8io20xIIjnm1Ui49ZsJdbxNEL+ETNfFGWIR0oyqpywdoyokkPg5lIT9OrxdORrmAkdkOYPDHjd2o2M6Pp7lKkK5qPiyrlF398PLUYHE3b5A51PwC9OSE8Apd+naKda6mNcgxqQN+7efBWRnmHf2xdhzCoPT4L2RJXTy/gHxnr/zooksFwXEfFW7WMFpflY3BpKoecbLq8BNAv/Fy+7RyMWIAtja6ACXDgCkMk+r3Obtavu6sPmnDLmftUOTk/cTeEtjLNexHcv3Me6q9ig2VXVFuiNTFWEYK0kqHNxvD0hAcK5PBgVX4nwYleHjXXOusw6BS5WAuQMZ+8GmHTsoG/F2ScAQ9xMOKSg8Z6uouGxNv4qSDjjbrQpMYcRFd6Qo73w0W5hT0pjkhVN7clN1GJycv7La2Zlq79MDMcM2xYBEXJv7KPwHZgU1blZ0a4FApv2RogY00ZCDHd2cub7Y6yOL8CYh2+y33SgMM2DTueeeEF9U0yCrmGx38nBS3QBuzDe5kCb22wYTpBLo0GY2kKf5S+xtsvV+gsgX5GIsUoZdSrWVrWvgBhFKG+O/eNm3YWr8H7jIuaztLj+iRRsNdwE7vZnRwKd+T6McsvxjOPNog/NZq/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZqxkpMmUdcT+Xf3A/6OMoIaD/jJ9SUyE1Qmwb4hLamM1kYVaubdZGtZHJ5K?=
 =?us-ascii?Q?3NYlRzknDw9j4A3g6TOPzlNokAgjaFRLRQioANwsdv0tw5nR3yu04hLhzZds?=
 =?us-ascii?Q?8ohNX9SE1jd3yxJRuotVX6bhtKEjWqdfJVxIxOZCnxkCXukSGNOjM4Pj67ce?=
 =?us-ascii?Q?4GxmdBWMZh8qdGaacZ0XH1N36JAl+ujpZiDnAFc9NDzGal19ZOt7QIi8WG3x?=
 =?us-ascii?Q?vqkp6TBEsAvOkLKgvyRzAtAEQYQviKP4PTMTPkZyBugozi5ts3zqH0t/zOci?=
 =?us-ascii?Q?CNsdpUQgznd41c1O8n70skyVyKbuyyR5wQ9BumhjfUUZ7rQdLB0abXybLi20?=
 =?us-ascii?Q?kSKH81mPgfwWx4Z2xS+inYXHxtT7rwVjqTIATp5/cACNIHxNux7JEhL1h722?=
 =?us-ascii?Q?S5669x2yofP6LlewJzj8Fv0sxucivc9hdI2xhi1CQkF+s3WiT4/aZibBVEdh?=
 =?us-ascii?Q?kndG8MwgklXN1zcXF7K+Uss4+rCiTXs2k0shxyrT2rm5SOpHViLf52MC6UBD?=
 =?us-ascii?Q?sG7BDBIrz/nJO/4iD8GtxeFr5+iatinfuaKx15/dmCrmMWMiH4mCfd/4T8Gm?=
 =?us-ascii?Q?qImg2iauxmNmBNfLpjNDJaydqvLbRXnWbHXD4/LqOYO2LrwgKJXHeWT/sAnt?=
 =?us-ascii?Q?gjY6QPf/g1oomd2NFELpGdTM1fKD2XtNMg2cTn3bQ6s/gcexzLjPY5P7u1Uu?=
 =?us-ascii?Q?dm+peehB8t2pB7l+BTeX2LyM/NJrb6VLPtKnZTeCFKNa2lpuojJhRi4AdAt/?=
 =?us-ascii?Q?3RFVS9GS2Ewby+ihLnRvC81EI9JYMATsmZcKYAzk697kwheF74g45F1Z/f41?=
 =?us-ascii?Q?Ur/D/842Ulx9snTzkUksREv96w0/YicweF2N6r7RbWEWXL/yQZoW6HM9oCiN?=
 =?us-ascii?Q?GxwSRYnCU9O4Y9id36s02DaByBgkwjUpHjgVNciFt/MnPlXGll6n1aKLz+pA?=
 =?us-ascii?Q?LUQa6AdwGTKcr++2L0hwqnqNxhDCZSFeDPoSPeAuxI8npeiZb92nrrKLsPl2?=
 =?us-ascii?Q?XACYWNo5gadFYggnZZfj6BLLLVfQZDYsCBniKXWYuUx9C1EOtfyIfzHI0SGA?=
 =?us-ascii?Q?QGgY2UlVNj7GW0hSzqsHdoiDczVe61yZ1/vtnQyE0NIugx+oKBZdwqwGpdpa?=
 =?us-ascii?Q?ex+GDlHNzAKqPG4jgoEeKVAkOU9rCnpaOJaYiuIGLEy30XiNXXA7L1VGDbLc?=
 =?us-ascii?Q?+jHGUL0ltQwXyDxce06MAKKsElWpZIyoQEtJdeMUX6zv0Z+U8BEXB4Qx3tvN?=
 =?us-ascii?Q?gWAGb8moCS8WWvddRtPZjRVO8L1SYTDkJhGMxymITU+BJ1jNfFln9m9CAKpN?=
 =?us-ascii?Q?n7Sj5BeT5RLPO3adFWAg7lQTv2dh0Spi/MNw7yj2/okResykNbo0jdoM07JB?=
 =?us-ascii?Q?QemewL01rGr/ULmRyrABuS/WmUSqLD/e+x0pYbaPpnVlxfCfxCpgNEfIWZkf?=
 =?us-ascii?Q?S6MzRZSsP4yGoLH3PaAgHDcp45yyvmnNJNFLrChzDUgyhtyZB3Q5Y57SMYFf?=
 =?us-ascii?Q?hq6xMatsdivhi1Gdy+CA1kKrzWkwoOmkfMb0bTw6QXAnXXp/6UjzZ7oe/qtz?=
 =?us-ascii?Q?VFQwodoh8+eFAeut9VyQKe6xWWLgg5z2gxFZ1nTsspwWI2B/iwrQacZWPevu?=
 =?us-ascii?Q?+U95GIdsAegHjVRlTIA781OLje0nyHtllgCt2VnxpTDdac8ht/fmqnqyoFY5?=
 =?us-ascii?Q?VB03j5LYw6nlgGP0ZClt7iNYaxwugy8lxscozlo5Bi1c6aiOiCr0bGCgi3AK?=
 =?us-ascii?Q?avLWN0kEBYdrRicl4TCJSKjOAIJny9s=3D?=
X-Exchange-RoutingPolicyChecked: a6Rl3mJ2tSYKFRw0XWEIdxdcDeZ1bo7yI2jv+1f851qkA4/sWDJM4v3HrnN5agyij/kOrh6+X+TcwGJAqblW3u3A+1U+YJBFBWiJJ5qWkUwLMCgm+dnGGLW2Mcg3YyLxdtyBEPl4oJ7T/VjDaZTwzGGcPMpii27PNtHWF49ezWMYM5rfGRx/o09i0qbuX152dFe5omBq4nZezqmfbaIo8M8ROrjDSqtIc322/+5E9YihmpBRpLSb7x9P4Ugp/X0/hbo4LY+KumygRrDxMwYFR3kQp0nycnKmKjvVhU1NIE48ee7eK7nl0P9bsje0NG7II37Q9x8h4UQ8nCEMpRro2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f91dae1-3fe1-455e-0c97-08defc45e91d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:57:12.8597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tujvmNOAQ24o4T4gqXFB1NKYCMadVg35DXi4+v2mKuKyaXgZWcz95BBlg35yb0QzCbLw5vffuoVUaT7ssbKhTzsU7ppKXcQgmVIUGNX/ds=
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

Change the main "for" loop into "while" to get rid of obscure
iterator "i" and use more descriptive name to indicate how many
pages were already covered. Detect first loop with st->nents.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index a8ffcfc0017b..1556c59f9c8f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -137,11 +137,11 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	unsigned int page_count; /* restricted by sg_alloc_table */
 	unsigned long next_pfn = 0; /* suppress gcc warning */
 	unsigned long folio_start = 0;
+	unsigned long pages_done = 0;
 	unsigned long folio_end = 0;
 	struct folio *folio = NULL;
 	struct scatterlist *sg;
 	gfp_t noreclaim;
-	unsigned long i;
 	int ret;
 
 	ret = set_page_count_from_size(size, &page_count, mr);
@@ -166,15 +166,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 	sg = st->sgl;
 	st->nents = 0;
-	for (i = 0; i < page_count; i++) {
+	while (pages_done < page_count) {
 		unsigned long folio_page_index = 0;
 		unsigned long nr_pages;
 		gfp_t gfp = noreclaim;
 
 		/* Grab the next folio if we exhausted the current one. */
-		if (!i || i > folio_end) {
-			folio = shmem_shrink_get_folio(mapping, i, gfp,
-						       page_count, i915);
+		if (!pages_done || pages_done > folio_end) {
+			folio = shmem_shrink_get_folio(mapping, pages_done, gfp,
+						       page_count - pages_done, i915);
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
 				goto err_sg;
@@ -184,7 +184,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			folio_end = folio_start + folio_nr_pages(folio) - 1;
 		}
 
-		folio_page_index = i - folio_start;
+		folio_page_index = pages_done - folio_start;
 		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
 			ret = -EINVAL;
 			folio_put(folio);
@@ -193,14 +193,14 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 		nr_pages = min_array(((unsigned long[]) {
 					folio_nr_pages(folio) - folio_page_index,
-					page_count - i,
+					page_count - pages_done,
 					max_segment / PAGE_SIZE,
 				      }), 3);
 
-		if (!i ||
+		if (!st->nents ||
 		    sg->length >= max_segment ||
 		    folio_pfn(folio) + folio_page_index != next_pfn) {
-			if (i)
+			if (st->nents)
 				sg = sg_next(sg);
 
 			st->nents++;
@@ -223,7 +223,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		 * and predict where the next folio begins.
 		 */
 		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
-		i += nr_pages - 1;
+		pages_done += nr_pages;
 
 		/* Check that the i965g/gm workaround works. */
 		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);
-- 
2.34.1

