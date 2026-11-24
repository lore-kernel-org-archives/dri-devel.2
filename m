Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381ED606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eO+iOAW+;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=U1MldS+C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883B910E790;
	Tue, 24 Nov 2026 20:39:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2D210E790;
 Tue, 24 Nov 2026 20:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795552768; x=1827088768;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=D/18AUBvgYhSPC4oIUZd/2cDRcywvtscZlzsMb3/oc0=;
 b=eO+iOAW+b3mJ8+ZCd49NqgoQ6LnlyQiC74HL43zVveaN8TqQsUQnMWA1
 4zvncyoS2vTw3csYkpYj93Ei8xkylBmfC2cgDeAGcHy0b9fQgs3Qxc14m
 7LAr/hpEOBt1cimKpQjd/sO7nT1nDU3ecJyGCH7TZLd/j3haihkGktq1N
 cIUO5+NnyF9DYtjDTJiTEsl+3/eHUuhsIGvJytyyF82Bcuv3jEYYxABm9
 cvE/eldN40B0i7hlpeQyoJq48aHEUtmWnXx7dpSIir2/C8oOYSqV6D7p8
 rxTqzsVLXjJcVwBDrTewia+N1R+CBXcs4ckbvClzPhY6H4SWpYDt4LSVd g==;
X-CSE-ConnectionGUID: DyJhcQGaRmq7bXX5gy0GFA==
X-CSE-MsgGUID: VjuTHey5Q06PprtbRDMLRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4411445"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4411445"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:39:28 -0800
X-CSE-ConnectionGUID: ZbNE3QYwTFi+r5/cCC8imA==
X-CSE-MsgGUID: W0IhUq44TyawQLP9A1qMRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11548379"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:39:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:39:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:39:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:39:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrWanpO2b22vZrErD+//o8Ynnu6t1cJxiDVHSh/UpBJqTsiJWPwcoKxUB4uxLu0zqcpmjcdKQucm6cJrERvt0AYCaTiJWut/PVWSP8IafMl1Q2IGe+mKdaxfJZXv3SIyOGHor2PE81sd5fuMKJ0+OaDbwZ0zvke/WmZKTDtt6/oIhJpZSCSSpC6QpJZ72WVoe2Kdlb/8DHuhFOzwOI9t60FA8a3jDdOgIEwxfIb8rTS7yf0+RJy12voXLA9BuLIy8qUGAbxhXLyJ+Cmi/OjT/N4M8PG1jICI6vnwiCbe8sgTQtrE7GMePen6QELWi+ryFvJ2vd16O6/b8z4WzFdQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReuB8VXKy70ZTCdMisSBqb1m/vKl9gNUFjrk3kpjh6Y=;
 b=ySYSMiu/oHK3Ht3nIVlnV1Ie0r9eE4ENFPN4WQGZX9D6qn+dTimlvCEmn6ZyXEP7k5h1X7EAqy2wysakXHL4ue0S9OXRFgXJUuaEEgSLEEON0jvggDtEM8tXY5CZUvBgTa04TxZef8Vi1q2RZW+FweL2tv69eVguOsHcY1GuV8UXlm24+Rd7Lv1BbNJP2Ruj1fbtdfEE8RPrAAKkCn4Hwply1iCdjxs0ZPSIkPzMSR4c+KQokvjRbOMlFvdOVV/BgOmmpOmCnaH+m5F5/dmjGusIZI2RhbWEgCpTmADl/vVamRFC/qpydtpy8dcMZ4XgEIKLn1ZBkcx83vSrEbnPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReuB8VXKy70ZTCdMisSBqb1m/vKl9gNUFjrk3kpjh6Y=;
 b=U1MldS+CqeL899xxK+sJo0A/BbQ1yf0260HlwnjW/LSvLbGqYUMyoTWtV8b7JsQU8YJtLhDVJiZj0LXFlOAXgE+8mT0IuZvWh5EmTW3ndbP9Gpb6bKqJpvmUY+bTRVZ6n1t6qkTreiAidYaOYJEBYrum7MtnvhUZ5CqhiMfem+M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 20:38:45 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 20:38:45 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Tejas Upadhyay
 <tejas.upadhyay@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v4 2/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Tue, 24 Nov 2026 15:38:36 -0500
Message-ID: <20261124203833.3618507-6-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
References: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9563fd66-549a-4929-f99d-08df4a6aed86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|22082099003|18002099003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: qIZPl6iWYDQdm9NeXiRaSRalFi/ZfJbhZfp48RTqlB9r0XCls7kjzn4bKw8jXSveCWm9ZuG79Ak2V6pn+INP4n9JyYfL6qVpIfaLauFzLwnQPMs6KOPcgkF7acyvDPd0Ja2PMUrzABAkS7whDwxsUy/kF5sGocSt/zOoxS5uCffuhjBhPo/HF0YgycS3fEzcAwcOwbKP1besRAIVN18Vq/6yn5zssvI3/3tkj11qFFW6XWtsGeJCnMxMY/xWyBBL1kyaakh3m7AW5qRgMUq5ElI7mrYwKNLbZXkPvLQewwpyQIvoZCkK+ZoUSMK+bAD1J9D4uepuy54fyK/9pY/1axwxqvaAlEC0A3NJlZvJ5ARSRqEbnqWIAv9JH8BCfZoiBppI9rnJDSeWDt+ikL5sVnqI2ki84TDxKt7XgLE5pdYGgn7gErwv78zwDWpdIphcJcn3zkgjDClpn0Ekfq/gPPis0fR9KZ/wdc8smObCaqAW0/EYZ6pevqTjT3GVVuME+4NSdHk4HgyZH8QkJAneyCoa969aS2idmbLgQmWwjyqWMkLiffePh0Iyaz3AVvin3AnHx3kgJhWAGk3BF733JOBANNa/FRaJvs5H4gkYWJVTMhj7n20Jxb2erDCIRycWYbdOGvOIgstkBrqXZwlPeWROk1fOdSipeLf+S6oKhC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0HxwseLikFSBXU/0eznTFkB2HoJ3prtC1p9RVhTajp2OenQSHXrC9dUUN7i9?=
 =?us-ascii?Q?JjfqGTgFwRNtVV3W4jqsUPjflhFgEAqQp00fZvP5q6vb+dvRQ4pjUbGDlGYb?=
 =?us-ascii?Q?aQdE3MgiLGS/cUbnV9L1M7M0+B5Qtjqez5mbG8eOsNR5g/1a1Cvcjdoog/78?=
 =?us-ascii?Q?wqYdXtgOq5ZQnxONyj8PeMOMfBPj/FLJodnKeY18Ync1Wl7tavICcvRwFoXQ?=
 =?us-ascii?Q?vZCnwD9jdfrAi+djm8fwD8qefHlcG48eaYUx3Zm4v9e5IRfBdd5zJnOqIYo2?=
 =?us-ascii?Q?lbFzi5RpBavOBCIP6+2JjXdMal1GrbLnqQas2s0qRWv2kffEx4oi6A4rlReI?=
 =?us-ascii?Q?4xFcrrD9M0dPO5YzBvPQIQHZev0ef3aONJMONMpYvirGJBZnl9lozry+1Ttd?=
 =?us-ascii?Q?2997NRZ192Qj3kKpUmOPoaIhHYUBbh0LLFlqRXgGGyAwG2xJJSlthsIPuufk?=
 =?us-ascii?Q?b4EDVNjT6uti8mV7XgRxw6fsEanjpp0whpMOEXl1TTUTLUftcOl9fxbNGzz4?=
 =?us-ascii?Q?Mji37KNmpNGxu9rATknJAVxuobjc3mWgoY7L9G91M3Uno9JjReG/BazmNodX?=
 =?us-ascii?Q?3MHXG8MAyQAGe0I9gHyGp1G6PlsnIEvICSTUFYRiQNJQwWZA+xSIaESpanKX?=
 =?us-ascii?Q?t4DRMKlDMDm4TLEBdHVWMXyolJgIFvzX8GlW23TE2aYMoHM8Km14w4LSeCy1?=
 =?us-ascii?Q?xmNHAGwPm0TRW2n342q/KUK6bOKKNpJerbIAnVonHl3El3NS6eFl5Ovycmfd?=
 =?us-ascii?Q?jB9jXd8WNHT5XFcOsif0vmMt7RCnpTU4YfvK8c0pUsO0q9ljAAdMcrIvygZj?=
 =?us-ascii?Q?2OWCYbVV8f7nx0ChQ9u+kAA9c4N9u3KOKsfyT04QB9Wqztzcdu+V1L0iq8gm?=
 =?us-ascii?Q?z3+S5kFKaY9Um8rIMQ2Xw1+A36f4PpUV6Go2hmY7Ut9HiyazoBaX2zbcth4I?=
 =?us-ascii?Q?n+ZfrYGSKJvYxet1odlsY0BxH3CFjY4PXE5IKIi+Pxmu02piCZPGWNKbYv4h?=
 =?us-ascii?Q?B4fB8kJF/zDGiNsZYsICQ/lOT038bt5O+V99iiml2EntUgngxuVeSBbIYTn9?=
 =?us-ascii?Q?qsWJdl+bclLem3neG1oUv6YInjpejLTK/HlxEOuySe6oHNgobFbMoxbdcu9w?=
 =?us-ascii?Q?kS3vGTU4Hzn/JX+JWYSnO4yBPbM6j+XN6UFEtoN2geYMoWDdLVOiiro4J5rK?=
 =?us-ascii?Q?5zM2XOmTv+ZQioXXGrav1gujpZc1mqla4EiBrtwR4TpqyHsdlkleb0EE5ZTt?=
 =?us-ascii?Q?PR93SkTDjgXmwdq6am4bY2NOTzItLaBHjppNDg4oluRbhiTFDgeaIr6oPfEB?=
 =?us-ascii?Q?JCYFkmAxs0Wd2OrwQ6Qhaj3xwNv59isb1H1r0OZNRhPCx48cXCpPqTabJ6Rz?=
 =?us-ascii?Q?ZJWOpThX5ZtxyFltQvHM42QOZOUErC9xn6buijVXmhO+1q6Ty2OuJXY8AmGS?=
 =?us-ascii?Q?Honb9QmeFYQHgLdWV0wMUmcibcSN5F6QAklQJZur3lPg9px6nadP1Z4MtVK/?=
 =?us-ascii?Q?NggIrXIT8P7PjvdEHK9t+Cl0E846hcal+/39z7vX/5wpo2X5Lj6xrCxHETNe?=
 =?us-ascii?Q?Bmy5wYhONTOtSK6s8mLQv6RDC5Gr1LBOWDpeePmXuu9He5bwyRDURDg1wZRE?=
 =?us-ascii?Q?nvIcGYCKqkpUqLypmjwJ7+eUMkTgUBWHCL4NAmDMTzDUEuHfuuyBvmeKdji8?=
 =?us-ascii?Q?hQMOS6HpKs8tmnt2xpeB7Eiw7pJ6I6FINQhWiRYa7kym67U4XU/eL5vd5Rfx?=
 =?us-ascii?Q?fJ+Rmj3IIg=3D=3D?=
X-Exchange-RoutingPolicyChecked: iqN4Ud40Y7NvezKq37q9JNNSq/bjmk+lg/yFsnNT5+pOyBCBZzEyKJtpNYmNJYG04TiLsU3EtOIH0V/01Ox+KqERzlUMsWSz8yvl5w+H3SAHUL7EX36ewiCp+IjP47v02q52wnVY5yojc/lm/nCR76nuqox5WxZY3EBRdRftipKIAWIrJmKq4YQeZuE16PaUEDfpK/JHQSwQf74mDbxe3WvmqbdsBMRZFehjyt2d69Re5Zpq6dVrH7IaWXu694nwJTF6bedla0tL7pHFQG9TC8BXCBrgeXHdA6UttqRzImeIiR9zxx9JqzQhh/mM/1F+kU2IYw+A4hsMhA4BvkDYhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9563fd66-549a-4929-f99d-08df4a6aed86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:38:42.3835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQnppAZe+1qNMNuYcVmCtQWUURHUSPoVvnZzn7y5l7cjvCkWpdCqVg47QX73dlow+rx76kH/bE0yQEnyt9V67Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
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

From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>

Retired VRAM pages are only visible through the vram_bad_pages debugfs
file today. Register a drm-ras retired-pages node so userspace gets
them, and the maximum number of pages that can be retired, through a
stable interface.

The page lists are walked under the VRAM manager lock, and a generation
counter on each manager lets drm-ras flag dumps that raced with a page
being added, retired or failing its reservation.

v3 (Rodrigo+LLM):
 - Use the drm-ras retired-pages node type, which replaces the nested
   retired-resources layout (Jakub).
 - Walk the lists under mgr->lock instead of RCU, which they are not
   protected by, and stop reading the buddy blocks (Sashiko).
 - Add a generation counter for interrupted dumps.
 - Keep the vram_bad_pages debugfs file for now.
 - Remove deprecated Assisted-by tag.

v4 (Rodrigo+LLM):
 - Register the node at the end of xe_ras_init(), once the retired page
   lists are fetched. That point is only reached with a system
   controller, which replaces the XE_CRESCENTISLAND check and keeps the
   node off VFs (local Sashiko).
 - Report the list generation also when no page is left (local Sashiko).

Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c            | 56 +++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h            |  1 +
 drivers/gpu/drm/xe/xe_ras.c                |  4 ++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       | 72 +++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h       |  3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |  5 ++
 6 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 86c589437a9f..5382b60bb328 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -13,6 +13,7 @@
 #include "xe_device_types.h"
 #include "xe_drm_ras.h"
 #include "xe_ras.h"
+#include "xe_ttm_vram_mgr.h"
 #include "xe_wedge.h"
 
 static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
@@ -272,6 +273,61 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+static int query_retired_page(struct drm_ras_node *node, u64 cursor,
+			      struct drm_ras_retired_page *page)
+{
+	return xe_ttm_vram_get_retired_page(node->priv, cursor, page);
+}
+
+static int query_retired_pages_info(struct drm_ras_node *node, u64 *max_pages)
+{
+	*max_pages = xe_ras_get_max_pages(node->priv);
+
+	return 0;
+}
+
+/**
+ * xe_drm_ras_register_retired_pages() - Register the retired VRAM pages node
+ * @xe: xe device instance
+ *
+ * Called once the retired page lists are populated.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int xe_drm_ras_register_retired_pages(struct xe_device *xe)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct drm_ras_node *node;
+	int ret;
+
+	if (!xe->info.has_drm_ras)
+		return 0;
+
+	node = drmm_kzalloc(&xe->drm, sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->device_name = kasprintf(GFP_KERNEL, "%04x:%02x:%02x.%d",
+				      pci_domain_nr(pdev->bus), pdev->bus->number,
+				      PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	if (!node->device_name)
+		return -ENOMEM;
+
+	node->node_name = "vram-retired-pages";
+	node->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
+	node->query_retired_page = query_retired_page;
+	node->query_retired_pages_info = query_retired_pages_info;
+	node->priv = xe;
+
+	ret = drm_ras_node_register(node);
+	if (ret) {
+		cleanup_node_param(node);
+		return ret;
+	}
+
+	return drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+}
+
 /**
  * xe_drm_ras_event() - Report drm-ras error event to userspace
  * @xe: xe device structure
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 723229b2cffb..a6fc2255986d 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -13,6 +13,7 @@ struct xe_device;
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+int xe_drm_ras_register_retired_pages(struct xe_device *xe);
 void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 9b04be3405ca..8e5e2df2c9f7 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -1508,6 +1508,10 @@ int xe_ras_init(struct xe_device *xe)
 	get_offline_list(xe);
 	get_offline_queue(xe);
 
+	ret = xe_drm_ras_register_retired_pages(xe);
+	if (ret)
+		return ret;
+
 	/*
 	 * During probe, process and log any errors detected by firmware while the driver was not
 	 * loaded. Critical errors such as Punit and CSC are reported through Pcode init failure,
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 36d47de8b11b..4a7b9ea36211 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -10,6 +10,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_buddy.h>
+#include <drm/drm_ras.h>
 #include <uapi/drm/xe_drm.h>
 
 #include <drm/ttm/ttm_placement.h>
@@ -240,13 +241,17 @@ static void xe_ttm_vram_retry_queued_pages(struct xe_ttm_vram_mgr *mgr)
 					    PAGE_SIZE, PAGE_SIZE, &pos->blocks,
 					    GPU_BUDDY_RANGE_ALLOCATION, NULL,
 					    &pos->used_visible_size)) {
-			pos->status = XE_PAGE_RESERVE_FAIL;
+			if (pos->status != XE_PAGE_RESERVE_FAIL) {
+				pos->status = XE_PAGE_RESERVE_FAIL;
+				mgr->retired_gen++;
+			}
 			continue;
 		}
 		--mgr->n_queued_pages;
 		list_del(&pos->queued_link);
 		++mgr->n_offlined_pages;
 		list_add(&pos->offlined_link, &mgr->offlined_pages);
+		mgr->retired_gen++;
 	}
 }
 
@@ -625,6 +630,68 @@ u64 xe_ttm_vram_get_avail(struct ttm_resource_manager *man)
 	return avail;
 }
 
+static void retired_page_update(struct drm_ras_retired_page *page, bool *found,
+				u64 cursor, u64 addr, enum drm_ras_retired_page_status status)
+{
+	if (addr < cursor || (*found && addr >= page->address))
+		return;
+
+	page->address = addr;
+	page->status = status;
+	*found = true;
+}
+
+/**
+ * xe_ttm_vram_get_retired_page - Get the next retired VRAM page
+ * @xe: xe device instance
+ * @cursor: lowest device address to consider
+ * @page: filled with the retired page that has the lowest address >= @cursor
+ *
+ * Return: 0 on success, -ENOENT if no retired page is at or above @cursor.
+ */
+int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
+				 struct drm_ras_retired_page *page)
+{
+	struct xe_ttm_vram_offline_resource *pos;
+	struct xe_tile *tile;
+	bool found = false;
+	u32 gen = 0;
+	u8 id;
+
+	for_each_tile(tile, xe, id) {
+		struct xe_vram_region *vr = tile->mem.vram;
+		struct ttm_resource_manager *man;
+		struct xe_ttm_vram_mgr *mgr;
+
+		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
+		if (!man || !vr)
+			continue;
+		mgr = to_xe_ttm_vram_mgr(man);
+
+		guard(mutex)(&mgr->lock);
+
+		gen += mgr->retired_gen;
+
+		list_for_each_entry(pos, &mgr->offlined_pages, offlined_link)
+			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
+					    DRM_RAS_RETIRED_PAGE_STATUS_RETIRED);
+
+		list_for_each_entry(pos, &mgr->queued_pages, queued_link)
+			retired_page_update(page, &found, cursor, pos->addr + vr->dpa_base,
+					    pos->status == XE_PAGE_RESERVE_FAIL ?
+					    DRM_RAS_RETIRED_PAGE_STATUS_FAILED :
+					    DRM_RAS_RETIRED_PAGE_STATUS_PENDING);
+	}
+
+	page->generation = gen;
+	if (!found)
+		return -ENOENT;
+
+	page->size = PAGE_SIZE;
+
+	return 0;
+}
+
 static int xe_ttm_vram_purge_page(struct xe_device *xe, struct xe_bo *bo)
 {
 	u32 q_flag = DRM_XE_EXEC_QUEUE_BAN_REASON_PAGE_OFFLINE;
@@ -825,6 +892,7 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
 			/* Queue free(to-be-purged) pages */
 			++vram_mgr->n_queued_pages;
 			list_add(&nentry->queued_link, &vram_mgr->queued_pages);
+			vram_mgr->retired_gen++;
 		} else {
 			/* Immediately offline unoccupied pages */
 			/* Queue free(to-be-reserved) pages */
@@ -839,10 +907,12 @@ static int xe_ttm_vram_reserve_page_at_addr(struct xe_device *xe, u64 addr,
 					addr, ret);
 				++vram_mgr->n_queued_pages;
 				list_add(&nentry->queued_link, &vram_mgr->queued_pages);
+				vram_mgr->retired_gen++;
 				return 0;
 			}
 			++vram_mgr->n_offlined_pages;
 			list_add(&nentry->offlined_link, &vram_mgr->offlined_pages);
+			vram_mgr->retired_gen++;
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
index d77f067d197b..91147385718c 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
@@ -9,6 +9,7 @@
 #include "xe_ttm_vram_mgr_types.h"
 
 enum dma_data_direction;
+struct drm_ras_retired_page;
 struct xe_device;
 struct xe_tile;
 struct xe_vram_region;
@@ -33,6 +34,8 @@ void xe_ttm_vram_get_used(struct ttm_resource_manager *man,
 			  u64 *used, u64 *used_visible);
 int xe_ttm_vram_handle_addr_fault(struct xe_device *xe, u64 addr);
 int xe_ttm_vram_inject_fault(struct xe_device *xe);
+int xe_ttm_vram_get_retired_page(struct xe_device *xe, u64 cursor,
+				 struct drm_ras_retired_page *page);
 
 static inline struct xe_ttm_vram_mgr_resource *
 to_xe_ttm_vram_mgr_resource(struct ttm_resource *res)
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
index 4a2cd27a5b61..6a49ee8b09ef 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h
@@ -27,6 +27,11 @@ struct xe_ttm_vram_mgr {
 	struct list_head queued_pages;
 	/** @n_queued_pages: Number of queued pages */
 	u16 n_queued_pages;
+	/**
+	 * @retired_gen: Changed whenever @offlined_pages or @queued_pages
+	 * change. Protected by @lock.
+	 */
+	u32 retired_gen;
 	/** @visible_size: Probed size of the CPU visible portion */
 	u64 visible_size;
 	/** @visible_avail: CPU visible portion still unallocated */
-- 
2.56.0

