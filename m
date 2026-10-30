Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273460A2601
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jlGq4IkZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C99210E8DB;
	Fri, 30 Oct 2026 21:16:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923EA10E1CB;
 Fri, 30 Oct 2026 21:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793395004; x=1824931004;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+XXj8VvehC2f+AUxlsIRV07mJLFuaF6fWdnh+sOfJ38=;
 b=jlGq4IkZk9SzY0k3oB+bPAmagqWJfgRpNF7WWGw0jCcQiQlqaoGoiq37
 1pT4sbT/PjoX1xMqnh6xu8BMhKNnhXSg32QPoqPc+P9HC/toRZvdXmTDQ
 +ieEJgSqlCQG0J8vFOZqLPf96mcgDnOMD41prnPEGu3fkfFy2kFANmmkE
 3uFo68RS7VaJ0IBXF6+eR4oTNS9cYqkPQB1mbbLltszcz55zbPApaAwP4
 CXDyVNyznyK0v1Qs0I1QxQsWpVMbd83mUh+sX66BOn+torT9qzDYhTYGQ
 oMlA+vEAQBLXfdAJZa+GQqAOy0NE/9OFO56v0bq/ZbmU5rEw9/VCszYsH Q==;
X-CSE-ConnectionGUID: AL1AbQbiQm6uo75GS2il5w==
X-CSE-MsgGUID: 18wZFjUVSGmeg+OGJzM/kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2183602"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2183602"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 14:16:44 -0700
X-CSE-ConnectionGUID: Zbo1JvNQQPi50mmuA2qxDA==
X-CSE-MsgGUID: hS0uCRr1QoyOxDR4n8HFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7330146"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 14:16:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 14:16:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 14:16:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 14:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C85g/5ad3cwmu6sbEm7w7W0fBGMkhCa1V/HnMf+1OZy/ixVbk/28ixABDBS79YxOBShqZ+P9xSPWp7oEqWvtmZFTPHC5bTO7nZJjXGu70TlA4t/kk6j++njKZAyCo53uuN3yLP5kKZFVUH4dcohOXpBR2GWJn3vSC/nwb1DNS/7VSDa2rectMad9to3dsVmK5F/p8Kmw9OencsYPC7M7OHg8M9IM4Hljgc81rNv7nOBRPnHhdTAcF3w9bX36du6WjDqU1k5SM3RcFrzJegTt/bNcEKjnN03ze+8H5YQ1sTvrOCasc7F+/Li1+KKfMLpq5Ln9oAzydkA0ZBJF2xlCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZHwxYD1xKZ25vGBeBukUad0iqPOrlIOa7obeyxYvT4=;
 b=TWjunTqFsNXZp3tfwKOePJN5wpD5dC01UkHgOHH4j70qahvjlSqUvL9Q5a9Gm3UrjvR/g1iEKxivM60fGmzGHcG0Ouj7Tgut5ip8BvtjuK1vdNdtof3//Pr4ebdxItmfw7xEugUZTybhu7Rn6tZ3lVXNc5OO3ihR4XdLkfQs90BAdkeZ9YZLb4cXqMXZydu7LwHX7DR9hfYlp+uYE83FOBGZ0n4CW0owy44kbICbtSqCjWazgQ9o2ZQx6+xe/4ZTmBjrCvMv0m+9+QuQxCzhFxTrHjuMK1OYGGynfLzF756yPvCJBMPYZjrUMBOTiEJgp18KMAyr6gjh+mf2ZesA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SABPR11MB9962.namprd11.prod.outlook.com (2603:10b6:806:50d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 21:16:40 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:16:40 +0000
Date: Fri, 30 Oct 2026 14:16:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 3/3] drm/xe: Add a minimum age gate to the shrinker
Message-ID: <auUJNoo1ZpzBevGR@gsse-cloud1.jf.intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-4-matthew.brost@intel.com>
 <bff778512e4c9a9abde641a23b98514309509d56.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bff778512e4c9a9abde641a23b98514309509d56.camel@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SABPR11MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: a46e29d9-f18f-4232-649d-08df36cb1735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|260925021911599003|260925021311599003|260925022911599003|10067099003|5023799004|11063799006|4143699003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|6133799003|261028144727099003|261009223027099003|261009220027099003|261009223327099003|261009221727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: 78ELXvJ3aZUm9uQGsvXlO+VZm+Ypb67ZL8N+GjH3imsaHHRbsne/Th+4L34yURaTD9pidhI5B6s7NCp4JNLamWewbYBWTBob/PUsrPs52V3cj+SpTakimdrqyir0mvkgAVvuAUPxjrc8ZhcVic1rWE7G/2GbEDKxytnK3BbZE6HPBjyCo8h86ObqQ/yisA9XLd283Gxlw6utjLmQL27xJTh7I3R7oG+DJf6yos8SJEA92a5aW71LxtJetKmPw5tCOKYTZA0N/d0SnlgVPUp+cD57phImDpuyJ09cyHLrM1xdUSTZjlu+Jlht8MShwwUyEoxPotQogxgvjdZ7nRPPdPKSurT+PoMzUaNWJ6V8ij2YZlVQ3yYmoRH9PrKv2tLggqpQugMSCmy6H5RGClZl+BzKKOGNTefGO2lEJzQsIqfi1USfEEtlDTZk846CZ5IT1PTOTYLOhs7MoYXib6UmS1Pf+PN3ioBX8Fmo0IeTK3kLd19/QbhmXSRgDyrkqno/QembMC5lqJ6lWeqAUW1Uc06bfpL6AlxfIbqdg9N58sbKe/5ptojmgeKyf4fHFE54p6Sbt4DRHURyuu1jLu2P59oz6sJnHqkhJR2IQR3JNrYrlKKO9q32FbmWgVAosaJ/tvWKZWLvsXVmQdK332XrwjLiFMd/Jsf/ph1VpEVAACQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(5023799004)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(6133799003)(261028144727099003)(261009223027099003)(261009220027099003)(261009223327099003)(261009221727099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uLh5nQloHoIIKLeHXwXomDgvhGPDQ5LM/Rm4iBNGbm+g4HfMRqvwSYn493?=
 =?iso-8859-1?Q?delJy5nwn70iNBYNKLZN6qIOuUb4L+z1k3Zy4atEUzV7jRfds/kpp0WWvT?=
 =?iso-8859-1?Q?fmUSNguMsfvxVyKQxRHIbaaLd37KCEm2cAytOw20COe/pTg3AV1cRTR/St?=
 =?iso-8859-1?Q?Z3V7EF3tLVxfUOtd/jhIvUIjrqAUs02K0B/PKtL87xbLjg1P4tF6ci/h6h?=
 =?iso-8859-1?Q?RvUnF905ft1Tsc3wA+YYOCsWT3um38uclFZ2yzzz5P0otr1zxsvNWY3FcU?=
 =?iso-8859-1?Q?JirqKLZdZ1THy8Ijx7JOAVygkm3FpVAhF2rkaRupKgBAR04nESpEE8Cotb?=
 =?iso-8859-1?Q?lr6e+k3uZWGiwZjnbLdQ6QXrObK9Q6MZ2N3yBgFZsp4GfjI2yYx7/38Qhj?=
 =?iso-8859-1?Q?lcIaIL2ix5IalrmPjq9S5Zkz4F7SPy6L98h6fuf3diWuVFxTArmziDrdvZ?=
 =?iso-8859-1?Q?LzVN+2QnLZbqVy9W/exMI8MGMHmC7OFjIrIjzu4KrZJNHxdxCYUSvkEhIu?=
 =?iso-8859-1?Q?roibAVMvT6XcJccOmf/remwoJoFyr0w8/WuIUcRf0mC+6vWhyelr0o1o69?=
 =?iso-8859-1?Q?jT/mb2sQXy8oS/HcJwpbqBrYpe3yTWo3N3PirMQ0gcEkl5xNgw0GtSKixw?=
 =?iso-8859-1?Q?0gOQJUMm+kM3og0F0MH9irFN5TnxAc1NlzeMbyqas5DyWka/rEvRQIgYET?=
 =?iso-8859-1?Q?iqt8jU4pggu7SNrLlVKILVkpVaqQxeIUSeRDMQSLuvmHyGhP+PuFNO9iNv?=
 =?iso-8859-1?Q?12uRbUk3TuLCGFO761N3m9QgtE9CYSPU7AfvbqXQkg4J39BFBnMAnV3u/k?=
 =?iso-8859-1?Q?t+hxk6UDAuUVLDUyjAyeIFnO93Yq4gJTMpwhPQoMaweRRrqK9EMqsLlryn?=
 =?iso-8859-1?Q?90qwI3POO/ALFHIGqlDId53J2zozWJ22eo9v6dqsOYacn0u1ntRUmKaIPI?=
 =?iso-8859-1?Q?l1roKLBYpTgCkxtAbPBryFCflSPSI/AkgtEtWpPZxYO22ET3zZFFa5sw+s?=
 =?iso-8859-1?Q?d25YgwEdYWG5ovXhReqYrhiN5HI/oIgqiiC6RuEoqoZ9FAB7pmK0PsSAXU?=
 =?iso-8859-1?Q?b1P+z3jibJtd7Si6d6U6NwaxROxaFViO4UnsoXVoN6EO1TqCBAG+B+n9JI?=
 =?iso-8859-1?Q?RstbNrCUIulh4GL44g67ELfyTyFL7W/byKX/1GynbSx49rXDdF2PrR9iSb?=
 =?iso-8859-1?Q?GrqpzVK6yfnII9fdOV7sPgGruMDbTbQjBxbsdv4cNThdfGq4G8NXnexSd3?=
 =?iso-8859-1?Q?NXyKUquk4CHrn1uc0CoU1dFhhx4daBYmhU281nQStNFPwFfMd3lAiOYKFx?=
 =?iso-8859-1?Q?9dpcJ3EG8JfBdGoKpXVAwmX0+X3XnJleOPaOSvooUvKxaEsL9VLEE9CVXb?=
 =?iso-8859-1?Q?5QB1oL2bbDf730xKPNNdsrmyesvQT41QUqvESXyrjuSZju3n+DjR22aOnZ?=
 =?iso-8859-1?Q?M4SqoAo1ukd5KnzP4ZHeGOqsnkW7IKjdneFsKxbD6A8HlO0ODe0rnD8uyP?=
 =?iso-8859-1?Q?znw8XMo4n8LYxu/R8hCoGYdABsR3sO+V+F8JDe+0RxInkYbMpJQFKPivfU?=
 =?iso-8859-1?Q?VKiQ5hkDrBf1qMZBJ2AyK/rOx0sahP1kYAYrNufsRwKz/ce6otN34NjfZK?=
 =?iso-8859-1?Q?uDeAhRFVE1Ssh7P8gJIoOJw4+MthqUMXC2dm7VLu4PcqF/Cf/uJu/yaZwC?=
 =?iso-8859-1?Q?ipMqAyKMDqw0e64ENRigQZD9wMTxocFGGLt32JwVUknVAVxNfb5Zy9ZjD2?=
 =?iso-8859-1?Q?OCKJwr+i2fA8o0bIWY+fvI2gvHnDXmB+INq+hxij4Tm7ZYWTvPa2CV6Evm?=
 =?iso-8859-1?Q?jaotZwvXmg=3D=3D?=
X-Exchange-RoutingPolicyChecked: qSpXrHW8w5Nk461+MJQcBjWeQW9v1/u33zoYc5bEn4ryuzb4oD9L4EMG/HyQRRHd2oKwMDC/WT05obzgLcWNfpEzQtbt3PpAljF53j6BWvuCrdG3/jjf9YK872dIxwmRseaWIqjHi43XF1ucbBNh4F+GktrWEoXtcRZ+B9zfidNVdhsxp4Lg0MKUpPwM1+fYSgwxOuilziCx8oeAxNoJ1Uv/AOvqw2sjNdqUaecROyB3Gnsyu9xC8osqjeW+5gGUrvvlsgJVkAarSBM8Xs/eSX9Cr30615h7PpObB7Fcy8KYkBpTOMii8YQpibGowwTGhVAo2QbOzJY9R7baxgbm0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: a46e29d9-f18f-4232-649d-08df36cb1735
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:16:40.7301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9c5iPxgGYYjYgAD23Y1Mclz2ghAdsxOXNkZ3W06r5AVPlY3mBs+ByCandcuLJ5HUiDdOmMrwSCdLxn6G7aK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9962
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 04:17:20PM +0100, Thomas Hellström wrote:
> On Tue, 2026-10-27 at 15:49 -0700, Matthew Brost wrote:
> > Backing up a BO costs a GPU blit plus a page copy, and if the BO is
> > part
> > of an active working set it is faulted straight back in on the next
> > exec.
> > Evicting a BO that was used moments ago is therefore almost always a
> > loss, yet the shrinker has no notion of recency beyond LRU order.
> > 
> > Timestamp BOs wherever their LRU position is updated, and read the
> > stamp
> > back from whatever owns that position. A BO in a VM's bulk move is
> > anchored inside its range, so it is aged by the VM-wide stamp taken
> > in
> > xe_vm_bump_lru() alongside the bulk move itself. Any other BO carries
> > its own, stamped there too and on a successful move into TT in
> > xe_bo_move(), where ttm_resource_alloc() has already placed the new
> > resource at the LRU tail.
> > 
> > Add a per-device shrinker_min_age_ms sysfs attribute, defaulting to
> > CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS (0, disabled). While set, the
> > shrinker
> > won't back up BOs younger than the delay. Each LRU priority is
> > roughly
> > age ordered, so the gate is applied per priority: xe_shrinker_count()
> > snoops the first shrinkable BO of each priority and reports nothing
> > only
> > if all of them are young, and the backup walk skips to the next
> > priority
> > at the first young BO, both as a backstop for the count sample and so
> > a
> > hot priority doesn't shield colder BOs in another one.
> > 
> > Only BOs this shrinker would actually back up have a say. BOs in
> > XE_PL_SYSTEM, which are not GPU mapped and hence not part of a
> > working
> > set, and BOs xe_bo_shrink() rejects outright are never young.
> > Purgeable
> > BOs and those advised DONTNEED are neither: they are dropped rather
> > than
> > backed up and accounted to the purgeable shrinker, so they are never
> > young and the count snoop skips their XE_BO_PRIORITY_LOW band
> > entirely.
> > 
> > The gate is hard and applies at every reclaim priority, so a working
> > set
> > kept younger than the delay is never backed up and can lead to OOM.
> > This
> > is deliberate, and why it is off by default.
> 
> For completeness, Perhaps add to the commit message that
> the plan is to follow up with an OOM notifier?
> 

That is a possible option. Another idea I had was if we can get the
priority exported from the shrinker core - we have a config knob that
says 'at this priority or greater', shrink BOs which have been used
recently.

> I also wonder what happens during the PM notifier preparing for suspend
> on DGFX, Does that move mark bos accessed, hence possibly blocked by
> the shrinker at suspend time?
> 

I haven't tried this on DGFX, can give it try but this off by default.

I'm also a little confused by this - does the shrinker run at suspend
time? I thought once the memory in ram a hiberation image in created
from the that - i.e., there isn't a requirement the BOs to get shrunk
into shmem.

> > 
> > Assisted-by: LLM
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >  drivers/gpu/drm/xe/Kconfig.profile   |  15 +++
> >  drivers/gpu/drm/xe/xe_bo.c           |  83 ++++++++++++++
> >  drivers/gpu/drm/xe/xe_bo.h           |   5 +
> >  drivers/gpu/drm/xe/xe_bo_types.h     |   8 ++
> >  drivers/gpu/drm/xe/xe_device_sysfs.c |  35 ++++++
> >  drivers/gpu/drm/xe/xe_pagefault.c    |   2 +-
> >  drivers/gpu/drm/xe/xe_shrinker.c     | 164
> > +++++++++++++++++++++++++--
> >  drivers/gpu/drm/xe/xe_shrinker.h     |   3 +
> >  drivers/gpu/drm/xe/xe_vm.c           |   4 +-
> >  drivers/gpu/drm/xe/xe_vm_types.h     |   8 ++
> >  10 files changed, 316 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/Kconfig.profile
> > b/drivers/gpu/drm/xe/Kconfig.profile
> > index 23045ed2aa94..dd3985e502b8 100644
> > --- a/drivers/gpu/drm/xe/Kconfig.profile
> > +++ b/drivers/gpu/drm/xe/Kconfig.profile
> > @@ -74,6 +74,7 @@ config DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT
> >  	  to apply to applicable user. For elevated user, all above
> > MIN
> >  	  and MAX values will apply when this configuration is
> > enable to
> >  	  apply limitation. By default limitation is applied.
> > +
> >  config DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS
> >  	int "Default seeks value of the non-purgeable bo shrinker"
> >  	default 8
> > @@ -86,3 +87,17 @@ config DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS
> >  	  reclaim pressure on non-purgeable buffer objects, which
> > need
> >  	  GPU idling and writeback to be reclaimed, in favour of
> > purgeable
> >  	  ones and other kernel caches.
> > +
> > +config DRM_XE_SHRINKER_MIN_AGE_MS
> > +	int "Default minimum BO age before shrinker backup (ms)"
> > +	default 0
> > +	range 0 1000000
> > +	help
> > +	  Default for the per-device shrinker_min_age_ms sysfs
> > attribute. The
> > +	  shrinker won't back up a BO that was moved into TT, or
> > bumped on the
> > +	  LRU by an exec, less than this many milliseconds ago. BOs
> > already
> > +	  evicted to system memory are not part of a working set and
> > are
> > +	  never protected. This applies at every reclaim priority: a
> > working
> > +	  set kept younger than this is never backed up and can
> > cause OOM.
> > +	  Only set if that risk is preferred over thrashing a hot
> > working
> > +	  set. 0 disables.
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 42a6aa1a2e4a..a4c0c6284a24 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -1357,9 +1357,92 @@ static int xe_bo_move(struct ttm_buffer_object
> > *ttm_bo, bool evict,
> >  		xe_tt_unmap_sg(xe, ttm_bo->ttm);
> >  	}
> >  
> > +	/*
> > +	 * ttm_resource_alloc() already placed the new resource at
> > the tail of
> > +	 * its LRU, or of @bo's bulk move, so only record when that
> > happened.
> > +	 */
> > +	if (!ret && ttm_bo->resource && ttm_bo->resource->mem_type
> > == XE_PL_TT)
> > +		WRITE_ONCE(bo->lru_stamp, jiffies);
> > +
> >  	return ret;
> >  }
> >  
> > +/**
> > + * xe_bo_bump_lru_locked() - Bump a BO on the LRU and stamp its last
> > use
> > + * @bo: The buffer object, reserved by the caller.
> > + *
> > + * Move @bo to the tail of its LRU and record the time for the
> > shrinker's
> > + * minimum age gate. Only meaningful for BOs outside a bulk move,
> > since a
> > + * BO in one is anchored inside its range and is bumped, and aged,
> > with it.
> > + * The caller must hold the device LRU lock.
> > + */
> > +void xe_bo_bump_lru_locked(struct xe_bo *bo)
> > +{
> > +	WRITE_ONCE(bo->lru_stamp, jiffies);
> > +	ttm_bo_move_to_lru_tail(&bo->ttm);
> > +}
> > +
> > +/**
> > + * xe_bo_shrink_backup_candidate() - Whether the shrinker may back
> > up a BO
> > + * @bo: The TTM buffer object, reserved by the caller.
> > + *
> > + * A BO is a backup candidate if backing it up is the only way to
> > reclaim it.
> > + * BOs advised DONTNEED, which sit at XE_BO_PRIORITY_LOW, and
> > purgeable ones
> > + * are not: their pages are simply dropped, which is cheap, and they
> > are
> > + * accounted to the purgeable shrinker. Neither are the BOs
> > xe_bo_shrink()
> > + * hands to xe_bo_shrink_purge() outright: ghost BOs, which aren't
> > xe BOs,
> > + * and BOs already freed and waiting to be reaped. Nor are BOs whose
> > tt
> > + * isn't TTM_TT_FLAG_EXTERNAL_MAPPABLE, which xe_bo_shrink()
> > rejects.
> > + *
> > + * Return: true if @bo would be backed up by a non-purge shrink
> > pass.
> > + */
> > +bool xe_bo_shrink_backup_candidate(struct ttm_buffer_object *bo)
> > +{
> > +	struct xe_ttm_tt *xe_tt;
> > +
> > +	if (!xe_bo_is_xe_bo(bo) || !kref_read(&bo->base.refcount) ||
> > !bo->ttm ||
> > +	    !(bo->ttm->page_flags & TTM_TT_FLAG_EXTERNAL_MAPPABLE)
> > ||
> > +	    bo->priority <= XE_BO_PRIORITY_LOW)
> > +		return false;
> > +
> > +	xe_tt = container_of(bo->ttm, struct xe_ttm_tt, ttm);
> > +
> > +	return !xe_tt->purgeable;
> > +}
> > +
> > +/**
> > + * xe_bo_shrink_too_young() - Whether a BO was used too recently to
> > shrink
> > + * @bo: The TTM buffer object, reserved by the caller.
> > + * @min_age: Minimum age in jiffies. 0 disables the check.
> > + *
> > + * The age is taken from whatever owns @bo's LRU position:
> > &xe_vm.lru_stamp
> > + * if @bo rides along with a VM's bulk move, its own
> > &xe_bo.lru_stamp if not.
> > + *
> > + * BOs that the shrink walk would not back up anyway are never
> > considered
> > + * young, see xe_bo_shrink_backup_candidate(). Neither are BOs in
> > + * XE_PL_SYSTEM: they are not GPU mapped, hence not part of a
> > working set,
> > + * and must be moved back to TT, refreshing the stamp, before use.
> > + *
> > + * Return: true if @bo was touched less than @min_age jiffies ago.
> > + */
> > +bool xe_bo_shrink_too_young(struct ttm_buffer_object *bo, unsigned
> > long min_age)
> > +{
> > +	struct xe_bo *xe_bo;
> > +	unsigned long stamp;
> > +
> > +	if (!min_age || bo->resource->mem_type == XE_PL_SYSTEM ||
> > +	    !xe_bo_shrink_backup_candidate(bo))
> > +		return false;
> > +
> > +	xe_bo = ttm_to_xe_bo(bo);
> > +	if (bo->bulk_move && xe_bo->vm)
> > +		stamp = READ_ONCE(xe_bo->vm->lru_stamp);
> > +	else
> > +		stamp = READ_ONCE(xe_bo->lru_stamp);
> > +
> > +	return stamp && time_before(jiffies, stamp + min_age);
> > +}
> > +
> >  static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
> >  			       struct ttm_buffer_object *bo,
> >  			       unsigned long *scanned)
> > diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> > index 77b3a02e9b8e..65d4c638e8d8 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > @@ -623,6 +623,11 @@ struct xe_bo_shrink_flags {
> >  	u32 writeback : 1;
> >  };
> >  
> > +void xe_bo_bump_lru_locked(struct xe_bo *bo);
> > +
> > +bool xe_bo_shrink_backup_candidate(struct ttm_buffer_object *bo);
> > +bool xe_bo_shrink_too_young(struct ttm_buffer_object *bo, unsigned
> > long min_age);
> > +
> >  long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct
> > ttm_buffer_object *bo,
> >  		  const struct xe_bo_shrink_flags flags,
> >  		  unsigned long *scanned);
> > diff --git a/drivers/gpu/drm/xe/xe_bo_types.h
> > b/drivers/gpu/drm/xe/xe_bo_types.h
> > index 0265fb314c77..f63b668c7134 100644
> > --- a/drivers/gpu/drm/xe/xe_bo_types.h
> > +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> > @@ -49,6 +49,14 @@ struct xe_bo {
> >  	u32 flags;
> >  	/** @vm: VM this BO is attached to, for extobj this will be
> > NULL */
> >  	struct xe_vm *vm;
> > +	/**
> > +	 * @lru_stamp: jiffies at the last LRU bump, done on a move
> > into TT
> > +	 * and at exec time. Only describes the LRU position of a BO
> > outside
> > +	 * a bulk move; BOs in one are aged by &xe_vm.lru_stamp
> > instead.
> > +	 * Consulted by the shrinker's minimum age gate. Accessed
> > with
> > +	 * READ_ONCE()/WRITE_ONCE().
> > +	 */
> > +	unsigned long lru_stamp;
> >  	/**
> >  	 * @q: Queue this BO is attached to, mostly for LRC BO, NULL
> > otherwise.
> >  	 * Protected by the BO dma_resv: readers must hold it across
> > both the
> > diff --git a/drivers/gpu/drm/xe/xe_device_sysfs.c
> > b/drivers/gpu/drm/xe/xe_device_sysfs.c
> > index ff5d25dd867c..26b1f71ed522 100644
> > --- a/drivers/gpu/drm/xe/xe_device_sysfs.c
> > +++ b/drivers/gpu/drm/xe/xe_device_sysfs.c
> > @@ -38,6 +38,12 @@
> >   * reclaimed by the shrinker. Higher values reduce reclaim pressure
> > on
> >   * non-purgeable buffer objects. Valid values are 1 to 64. Defaults
> > to
> >   * CONFIG_DRM_XE_SHRINKER_NON_PURGEABLE_SEEKS.
> > + *
> > + * shrinker_min_age_ms - Report/change the minimum time, in ms,
> > since a BO was
> > + * last moved to TT or bumped on the LRU by an exec before the
> > shrinker may
> > + * back it up. BOs evicted to system memory are never protected.
> > Defaults to
> > + * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, 0 disables. This applies at
> > every
> > + * reclaim priority, so a non-zero value can lead to OOM.
> >   */
> >  
> >  static ssize_t
> > @@ -331,8 +337,37 @@ shrinker_non_purgeable_seeks_store(struct device
> > *dev,
> >  
> >  static DEVICE_ATTR_RW(shrinker_non_purgeable_seeks);
> >  
> > +static ssize_t
> > +shrinker_min_age_ms_show(struct device *dev, struct device_attribute
> > *attr,
> > +			 char *buf)
> > +{
> > +	struct xe_device *xe = pdev_to_xe_device(to_pci_dev(dev));
> > +
> > +	return sysfs_emit(buf, "%u\n", xe_shrinker_min_age_ms(xe-
> > >mem.shrinker));
> > +}
> > +
> > +static ssize_t
> > +shrinker_min_age_ms_store(struct device *dev, struct
> > device_attribute *attr,
> > +			  const char *buff, size_t count)
> > +{
> > +	struct xe_device *xe = pdev_to_xe_device(to_pci_dev(dev));
> > +	unsigned int ms;
> > +	int ret;
> > +
> > +	ret = kstrtouint(buff, 0, &ms);
> > +	if (ret)
> > +		return ret;
> > +
> > +	xe_shrinker_set_min_age_ms(xe->mem.shrinker, ms);
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(shrinker_min_age_ms);
> > +
> >  static struct attribute *shrinker_attrs[] = {
> >  	&dev_attr_shrinker_non_purgeable_seeks.attr,
> > +	&dev_attr_shrinker_min_age_ms.attr,
> >  	NULL
> >  };
> >  
> > diff --git a/drivers/gpu/drm/xe/xe_pagefault.c
> > b/drivers/gpu/drm/xe/xe_pagefault.c
> > index 6828f81df50e..895866d639f8 100644
> > --- a/drivers/gpu/drm/xe/xe_pagefault.c
> > +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> > @@ -226,7 +226,7 @@ static int xe_pagefault_handle_vma(struct xe_gt
> > *gt, struct xe_vma *vma,
> >  
> >  			if (bo) {
> >  				scoped_guard(spinlock, &vm->xe-
> > >ttm.lru_lock)
> > -					ttm_bo_move_to_lru_tail(&bo-
> > >ttm);
> > +					xe_bo_bump_lru_locked(bo);
> >  			}
> >  		}
> >  		xe_validation_ctx_fini(&ctx);
> > diff --git a/drivers/gpu/drm/xe/xe_shrinker.c
> > b/drivers/gpu/drm/xe/xe_shrinker.c
> > index c86455ea08d1..64e5e684f591 100644
> > --- a/drivers/gpu/drm/xe/xe_shrinker.c
> > +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> > @@ -39,6 +39,8 @@
> >   * @shrink: Pointer to the mm shrinker handling non-purgeable
> > (shrinkable) objects.
> >   * @purge_shrink: Pointer to the mm shrinker handling purgeable
> > objects.
> >   * @pm_worker: Worker to wake up the device if required.
> > + * @min_age_ms: Minimum BO age before backup, in ms. 0 disables.
> > Defaults to
> > + * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, overridable through sysfs.
> >   */
> >  struct xe_shrinker {
> >  	struct xe_device *xe;
> > @@ -50,6 +52,7 @@ struct xe_shrinker {
> >  	struct shrinker *shrink;
> >  	struct shrinker *purge_shrink;
> >  	struct work_struct pm_worker;
> > +	unsigned int min_age_ms;
> >  };
> >  
> >  static struct xe_shrinker *to_xe_shrinker(struct shrinker *shrink)
> > @@ -104,6 +107,7 @@ static void xe_shrinker_runtime_pm_put(struct
> > xe_shrinker *shrinker, bool runtim
> >  static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
> >  			      struct ttm_operation_ctx *ctx,
> >  			      const struct xe_bo_shrink_flags flags,
> > +			      unsigned long min_age,
> >  			      unsigned long to_scan, unsigned long
> > *scanned,
> >  			      unsigned long *freed)
> >  {
> > @@ -136,6 +140,16 @@ static int __xe_shrinker_walk(struct xe_shrinker
> > *shrinker,
> >  			if (flags.purge && ttm_bo->priority >
> > XE_BO_PRIORITY_LOW)
> >  				break;
> >  
> > +			/*
> > +			 * Each LRU priority is roughly age ordered,
> > so the
> > +			 * rest of this priority is most likely
> > young too.
> > +			 * Move on to the next priority.
> > +			 */
> > +			if (xe_bo_shrink_too_young(ttm_bo, min_age))
> > {
> > +				ttm_bo_lru_cursor_skip_priority(&cur
> > s);
> > +				continue;
> > +			}
> > +
> >  			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
> >  				continue;
> >  
> > @@ -171,6 +185,7 @@ static int __xe_shrinker_walk(struct xe_shrinker
> > *shrinker,
> >  static int xe_shrinker_walk(struct xe_shrinker *shrinker,
> >  			    struct ttm_operation_ctx *ctx,
> >  			    const struct xe_bo_shrink_flags flags,
> > +			    unsigned long min_age,
> >  			    unsigned long to_scan, unsigned long
> > *scanned,
> >  			    unsigned long *freed)
> >  {
> > @@ -180,26 +195,126 @@ static int xe_shrinker_walk(struct xe_shrinker
> > *shrinker,
> >  
> >  	swap(no_wait_gpu, ctx->no_wait_gpu);
> >  	save_flags.writeback = false;
> > -	ret = __xe_shrinker_walk(shrinker, ctx, save_flags, to_scan,
> > scanned,
> > -				 freed);
> > +	ret = __xe_shrinker_walk(shrinker, ctx, save_flags, min_age,
> > +				 to_scan, scanned, freed);
> >  	swap(no_wait_gpu, ctx->no_wait_gpu);
> >  	if (ret || *scanned >= to_scan)
> >  		return ret;
> >  
> >  	if (!ctx->no_wait_gpu) {
> > -		ret = __xe_shrinker_walk(shrinker, ctx, save_flags,
> > to_scan, scanned,
> > -					 freed);
> > +		ret = __xe_shrinker_walk(shrinker, ctx, save_flags,
> > min_age,
> > +					 to_scan, scanned, freed);
> >  		if (ret || *scanned >= to_scan)
> >  			return ret;
> >  	}
> >  
> >  	if (flags.writeback)
> > -		ret = __xe_shrinker_walk(shrinker, ctx, flags,
> > to_scan, scanned,
> > -					 freed);
> > +		ret = __xe_shrinker_walk(shrinker, ctx, flags,
> > min_age,
> > +					 to_scan, scanned, freed);
> >  
> >  	return ret;
> >  }
> >  
> > +/**
> > + * DOC: Shrinker minimum age
> > + *
> > + * The per-device shrinker_min_age_ms sysfs attribute, defaulting to
> > + * CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS, protects recently used BOs
> > from backup.
> > + * A BO's age is taken from whatever owns its position on the LRU,
> > and is
> > + * stamped wherever that position is updated: the VM-wide stamp for
> > a BO
> > + * riding along with a VM's bulk move, bumped on exec in
> > xe_vm_bump_lru(),
> > + * its own stamp otherwise, bumped there as well and on a move into
> > TT in
> > + * xe_bo_move(). BOs in XE_PL_SYSTEM are never young: they are not
> > GPU
> > + * mapped, so not part of a working set, and will be stamped again
> > when
> > + * moved back to TT for use.
> > + *
> > + * The gate is applied per LRU priority, each of which is roughly
> > age
> > + * ordered. xe_shrinker_count() snoops the first shrinkable BO of
> > each
> > + * priority on each TT-backed LRU. Only if all of them are young
> > does it stop
> > + * reporting shrinkable pages; anything else, including reaching no
> > verdict
> > + * at all, lets it report. The backup walk in xe_shrinker_scan()
> > skips to the
> > + * next priority at the first young BO, as a backstop since the
> > count snoop
> > + * is only a sample. A hot priority thus doesn't shield colder BOs
> > in another
> > + * priority. BOs that aren't backed up anyway have no say either
> > way: those
> > + * in XE_PL_SYSTEM are never young, and purgeable and DONTNEED ones,
> > which
> > + * belong to the purgeable shrinker, are ignored by the snoop
> > entirely.
> > + *
> > + * The gate is hard and applies at every reclaim priority. A working
> > set kept
> > + * younger than the delay is never backed up, which can lead to OOM.
> > This is
> > + * intended for users who prefer that risk over thrashing a hot
> > working set,
> > + * hence it is disabled by default.
> > + */
> > +static unsigned long xe_shrinker_min_age(struct xe_shrinker
> > *shrinker)
> > +{
> > +	unsigned int ms = READ_ONCE(shrinker->min_age_ms);
> > +
> > +	return ms ? msecs_to_jiffies(ms) : 0;
> > +}
> > +
> > +/* Max shrink-unsuitable BOs to skip per LRU before giving up the
> > snoop. */
> > +#define XE_SHRINKER_SNOOP_MAX	16
> > +
> > +/*
> > + * Whether the first BO of every priority on every TT-backed LRU
> > that this
> > + * shrinker would back up is younger than @min_age. BOs are
> > trylocked through
> > + * the reserved LRU walker since their tt may be torn down while
> > still on the
> > + * LRU. Contended BOs are skipped by the walker, and may be all of
> > them. If no
> > + * verdict can be reached, because nothing was inspected or the
> > snoop budget
> > + * ran out, report not young and leave it to the scan side check.
> > + */
> > +static bool xe_shrinker_lru_young(struct xe_shrinker *shrinker,
> > +				  unsigned long min_age)
> > +{
> > +	struct ttm_operation_ctx ctx = {
> > +		.interruptible = false,
> > +		.no_wait_gpu = false,
> > +	};
> > +	struct xe_device *xe = shrinker->xe;
> > +	unsigned int mem_type;
> > +	bool young = false;
> > +
> > +	for (mem_type = XE_PL_SYSTEM; mem_type <= XE_PL_TT;
> > ++mem_type) {
> > +		struct ttm_resource_manager *man =
> > ttm_manager_type(&xe->ttm, mem_type);
> > +		struct ttm_bo_lru_cursor curs;
> > +		struct ttm_buffer_object *ttm_bo;
> > +		struct ttm_lru_walk_arg arg = {
> > +			.ctx = &ctx,
> > +			.trylock_only = true,
> > +		};
> > +		unsigned int budget = XE_SHRINKER_SNOOP_MAX;
> > +
> > +		if (!man || !man->use_tt)
> > +			continue;
> > +
> > +		ttm_bo_lru_for_each_reserved_guarded(&curs, man,
> > &arg, ttm_bo) {
> > +			/*
> > +			 * Nothing in the DONTNEED band is backed
> > up, and it
> > +			 * is accounted to the purgeable shrinker,
> > so it has
> > +			 * no say here. Skip the whole band in one
> > go.
> > +			 */
> > +			if (ttm_bo->priority <= XE_BO_PRIORITY_LOW)
> > {
> > +				ttm_bo_lru_cursor_skip_priority(&cur
> > s);
> > +				continue;
> > +			}
> > +
> > +			if (!ttm_bo_shrink_suitable(ttm_bo, &ctx) ||
> > +			    !xe_bo_shrink_backup_candidate(ttm_bo))
> > {
> > +				if (!--budget)
> > +					return false;
> > +				continue;
> > +			}
> > +
> > +			if (!xe_bo_shrink_too_young(ttm_bo,
> > min_age))
> > +				return false;
> > +
> > +			young = true;
> > +			ttm_bo_lru_cursor_skip_priority(&curs);
> > +		}
> > +	}
> > +
> > +	return young;
> > +}
> > +
> >  static unsigned long
> >  xe_shrinker_count_purgeable(struct shrinker *shrink, struct
> > shrink_control *sc)
> >  {
> > @@ -239,7 +354,7 @@ static unsigned long
> >  xe_shrinker_count(struct shrinker *shrink, struct shrink_control
> > *sc)
> >  {
> >  	struct xe_shrinker *shrinker = to_xe_shrinker(shrink);
> > -	unsigned long num_pages;
> > +	unsigned long num_pages, min_age;
> >  	bool can_backup = !!(sc->gfp_mask & __GFP_FS);
> >  
> >  	if (!can_backup)
> > @@ -263,6 +378,10 @@ xe_shrinker_count(struct shrinker *shrink,
> > struct shrink_control *sc)
> >  
> >  	write_unlock(&shrinker->lock);
> >  
> > +	min_age = xe_shrinker_min_age(shrinker);
> > +	if (num_pages && min_age && xe_shrinker_lru_young(shrinker,
> > min_age))
> > +		return SHRINK_EMPTY;
> > +
> >  	return num_pages ? num_pages : SHRINK_EMPTY;
> >  }
> >  
> > @@ -297,7 +416,8 @@ static unsigned long
> > xe_shrinker_scan_purgeable(struct shrinker *shrink,
> >  		.purge = true,
> >  	};
> >  
> > -	xe_shrinker_walk(shrinker, &ctx, shrink_flags, nr_to_scan,
> > &nr_scanned, &freed);
> > +	xe_shrinker_walk(shrinker, &ctx, shrink_flags, 0,
> > nr_to_scan, &nr_scanned,
> > +			 &freed);
> >  
> >  	sc->nr_scanned = nr_scanned;
> >  
> > @@ -322,7 +442,9 @@ static unsigned long xe_shrinker_scan(struct
> > shrinker *shrink, struct shrink_con
> >  	/* Might need runtime PM to access backed-up or CCS-
> > compressed data. */
> >  	runtime_pm = xe_shrinker_runtime_pm_get(shrinker);
> >  
> > -	xe_shrinker_walk(shrinker, &ctx, shrink_flags, nr_to_scan,
> > &nr_scanned, &freed);
> > +	xe_shrinker_walk(shrinker, &ctx, shrink_flags,
> > +			 xe_shrinker_min_age(shrinker), nr_to_scan,
> > &nr_scanned,
> > +			 &freed);
> >  
> >  	sc->nr_scanned = nr_scanned;
> >  	xe_shrinker_runtime_pm_put(shrinker, runtime_pm);
> > @@ -387,6 +509,29 @@ int xe_shrinker_set_non_purgeable_seeks(struct
> > xe_shrinker *shrinker,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * xe_shrinker_min_age_ms() - Get the shrinker minimum BO age
> > + * @shrinker: Pointer to the struct xe_shrinker.
> > + *
> > + * Return: Minimum age, in ms, a BO must reach before it may be
> > backed up.
> > + */
> > +unsigned int xe_shrinker_min_age_ms(struct xe_shrinker *shrinker)
> > +{
> > +	return READ_ONCE(shrinker->min_age_ms);
> > +}
> > +
> > +/**
> > + * xe_shrinker_set_min_age_ms() - Set the shrinker minimum BO age
> > + * @shrinker: Pointer to the struct xe_shrinker.
> > + * @ms: Minimum age, in ms. 0 disables the gate.
> > + *
> > + * See DOC: Shrinker minimum age. A non-zero value can lead to OOM.
> > + */
> > +void xe_shrinker_set_min_age_ms(struct xe_shrinker *shrinker,
> > unsigned int ms)
> > +{
> > +	WRITE_ONCE(shrinker->min_age_ms, ms);
> > +}
> > +
> >  /**
> >   * xe_shrinker_create() - Create an xe per-device shrinker
> >   * @xe: Pointer to the xe device.
> > @@ -415,6 +560,7 @@ int xe_shrinker_create(struct xe_device *xe)
> >  
> >  	INIT_WORK(&shrinker->pm_worker, xe_shrinker_pm);
> >  	shrinker->xe = xe;
> > +	shrinker->min_age_ms = CONFIG_DRM_XE_SHRINKER_MIN_AGE_MS;
> >  	rwlock_init(&shrinker->lock);
> >  
> >  	shrinker->purge_shrink->count_objects =
> > xe_shrinker_count_purgeable;
> > diff --git a/drivers/gpu/drm/xe/xe_shrinker.h
> > b/drivers/gpu/drm/xe/xe_shrinker.h
> > index 4b3c73689619..586d7772bd58 100644
> > --- a/drivers/gpu/drm/xe/xe_shrinker.h
> > +++ b/drivers/gpu/drm/xe/xe_shrinker.h
> > @@ -18,4 +18,7 @@ int xe_shrinker_non_purgeable_seeks(struct
> > xe_shrinker *shrinker);
> >  int xe_shrinker_set_non_purgeable_seeks(struct xe_shrinker
> > *shrinker,
> >  					unsigned int seeks);
> >  
> > +unsigned int xe_shrinker_min_age_ms(struct xe_shrinker *shrinker);
> > +void xe_shrinker_set_min_age_ms(struct xe_shrinker *shrinker,
> > unsigned int ms);
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index 86c3b4fd232f..583c55b7f97d 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -463,13 +463,15 @@ void xe_vm_bump_lru(struct xe_vm *vm, struct
> > drm_exec *exec)
> >  	spinlock_t *lru_lock = &vm->xe->ttm.lru_lock;
> >  	struct drm_gem_object *obj;
> >  
> > +	WRITE_ONCE(vm->lru_stamp, jiffies);
> > +
> >  	spin_lock(lru_lock);
> >  	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
> >  	drm_exec_for_each_locked_object(exec, obj) {
> >  		if (!drm_gpuvm_is_extobj(&vm->gpuvm, obj))
> >  			continue;
> >  
> > -		ttm_bo_move_to_lru_tail(&gem_to_xe_bo(obj)->ttm);
> > +		xe_bo_bump_lru_locked(gem_to_xe_bo(obj));
> >  		cond_resched_lock(lru_lock);
> >  	}
> >  	spin_unlock(lru_lock);
> > diff --git a/drivers/gpu/drm/xe/xe_vm_types.h
> > b/drivers/gpu/drm/xe/xe_vm_types.h
> > index fb9305124679..046505a285e9 100644
> > --- a/drivers/gpu/drm/xe/xe_vm_types.h
> > +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> > @@ -267,6 +267,14 @@ struct xe_vm {
> >  	/** @lru_bulk_move: Bulk LRU move list for this VM's BOs */
> >  	struct ttm_lru_bulk_move lru_bulk_move;
> >  
> > +	/**
> > +	 * @lru_stamp: jiffies at the last xe_vm_bump_lru(), which
> > is where
> > +	 * @lru_bulk_move is moved to the LRU tail. Ages every BO in
> > that
> > +	 * bulk move for the shrinker's minimum age gate. Accessed
> > with
> > +	 * READ_ONCE()/WRITE_ONCE().
> > +	 */
> > +	unsigned long lru_stamp;
> 
> Isn't the bo resv / vm resv always held then this is accessed?
>

xe_bo_shrink_too_young is the lockless read side.

Matt
 
> Thanks,
> Thomas
> 
> 
> 
> > +
> >  	u64 size;
> >  
> >  	struct xe_pt *pt_root[XE_MAX_TILES_PER_DEVICE];
