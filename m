Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82D606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qh1+prbx;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=PN/7kEmu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFED10E021;
	Wed, 25 Nov 2026 19:17:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F28D10FE23;
 Wed, 25 Nov 2026 19:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795634209; x=1827170209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=D/18AUBvgYhSPC4oIUZd/2cDRcywvtscZlzsMb3/oc0=;
 b=Qh1+prbx5iG2RVeuBnnzKWxfLu0W3cF16LtlXVhYvpn1eEiZ4xqEpwC3
 4eR7ECTyLYm6+UJaefL1rlRvsYcEIy+NAWMYQUI+1sKICHy3j/e9uOKEu
 VbWB3ZIexW5/NQghWAmhetPCH4QxrNacT3zZ60dPIU1hhJNv+oL5htfBe
 +lv2kEFOdr/VJwFK2sV+vsTwYh6NYN94NfuY7C0y7UK1Q4GZZF+qD0xND
 jSa4cDF6jeISX8gacbynTeX+ah7Mpy52EKCc+ENGZR1xFnxEZ/H+zcPIV
 p4h6Aeg7DhPPEPK0ul0sjjkc5qKRWxEjhQ1Adq4+BfqK9cJay7NWNHdFu w==;
X-CSE-ConnectionGUID: ja4Lpq7UTvyRq0scBKhNNA==
X-CSE-MsgGUID: +8TIga9gTgy+IIn5Fyk8rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4431500"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4431500"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 11:03:07 -0800
X-CSE-ConnectionGUID: Ne3e/x39RRWgyCq3GbTspA==
X-CSE-MsgGUID: 4Q/rnTaSRtqHzO7O6X0EBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12059944"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 11:03:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 11:03:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 11:03:06 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 11:03:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQIVqZJcJXhlFstjz0vsRX3ybxhY7ryKXc1wY4/DittOryHdvsjvuxQL1MVOI5C2ICV0dKVTqW2KozHwsYsMi4tJ2OxOj12JMpOpNBfp4ddTb7/W+SkSCQU+3da24clYLf1noLvH+xFtVtvgSFhgMrnKLdhh0wFC6MwR90clA9SmOw5ReO7NXt7MdMlKKDQFNd8xNtkZRU4U03rRbgLzk3yrapCLSKMr4kzZiKPto3+IhnEGKDQFaVQEyiEnvfE6P2XEuoGheORjQoTQkw+bWB5l20A44mDjjXiob9RExKeZWrBdhjSVPR4LWKvGBdreSZObVThG+y334PmoiOfXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReuB8VXKy70ZTCdMisSBqb1m/vKl9gNUFjrk3kpjh6Y=;
 b=B1l5tBvKUnbTikfZCMyDOLmuShfPdMTJ4hzlhqHw86DpKqNEfx0zb/vYiBOFwC3r/smjVqffox1jJypGhusmSRwpgXCGwB2B2gaLdDPiR/KfZmEkajDBbz/esooT1l8DVwT3UuzxQCxH6XzAqaR2tr4ct5CIEp7Cx4K/iHwTBfV2QaIL586tjBH5UHaZGXsGq18CMqrnqFn7Exy/DUhuliHFV98Y1hC/SCaVwYuEDAX+7sqxtkOIlW7cxJjZTvZHkSM7eJ/LLEmWlXLbyXhf4yAamyQ50P5UyXKBp/IVGWPF4bYqObUbX3FNatFADR2TIhZFqchUXi8/HWAlGA3EJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReuB8VXKy70ZTCdMisSBqb1m/vKl9gNUFjrk3kpjh6Y=;
 b=PN/7kEmuY0Gj4CEDlZTQGbFljAzM+ERv0bkyhQU5pVeMUpdD4FsYJOUn29pyALvCC+m4tErcjytZdI+bNxwRKtF1qmKwX7mbMM2+OMjqCW0UEmtz8L8CM46BNiF5UGDZsrhyMuZtjXzwAzU/+JdnGGKWj2fWqfLXRbLPhSGtjWM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 19:03:01 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 19:03:01 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Aravind Iddamsetty
 <aravind.iddamsetty@linux.intel.com>, Tejas Upadhyay
 <tejas.upadhyay@intel.com>, Himal Prasad Ghimiray
 <himal.prasad.ghimiray@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v5 2/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Wed, 25 Nov 2026 14:02:52 -0500
Message-ID: <20261125190249.156217-6-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125190249.156217-4-rodrigo.vivi@intel.com>
References: <20261125190249.156217-4-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SN7PR11MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2bcf30-ae8a-4636-41a5-08df4b26b9c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|261022075727099003|261022105027099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0eWQ4heHxSPah76JQHGElsMi8/2qn3Z1XTJqYocTUh9/T2mW6ajBVflSYw3IPo/GLXjDijVR8zCryoGcbbZqGkGSfnYUydPHWAW1X08k9N4ofS10ivA7o8V2BvONZg/rtrCjiQuuN3AiBqCCqfRZ40QbAjgwNlrhv1Jvu0uGPjpixPlZ2lF45o8eNiH1RMvRhZfu/0wPG9aGQKGcBFV9N6FUv4dPbaKGchs3X7LnxMDXAbXAqsxDYfvOZpsqaZhg5ZFnpWxs2M61eXC6429ms58Lvct9nobnupKPJh9Y4G4K+Z09HV8j8Eo0hOZGCobmPPLEgbna9zIfhEgLDmJgMdmX3ZNy99sms4nG4huVJVxUwUwmmwQzDZDcJ56Fc56Yjh4bsi1KJzeXuFrI2WvUqnEwKRL+2KmxTBxPrRPxCjudGJaciBV8GhrQAPiQtoDQ/FguJfyLm/IX0j0L2wFM2NislqgaS/t+V326CN5AYn2hfLn+I/Y+THtGTfLJeYRPD1wRAmFKXUm2AOglp/aMBn/SGjlaRIzf2z7xDOXwdY5kaPRAnJ/3ox6bCr01pxY+8W9nze5cSZJabqnDCe2ukitGHjWniKfalYejNd19tQxCyWxtqHtJUzwyYrgcW90/+oopNv0zjPShhixsjbDwOe2yAClXcdA5iBkuUXUthPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MckhvwhUACmlbRyaPSdG2dzdWLUV/bn/hHHTwMsChoXre0eZ0PCXLBQ51ZDD?=
 =?us-ascii?Q?4mWTnGmCgFuEyDVssBE4PwG5QW6wUgwf5x8+13DkvOLDsA4vlMUyd4jYaOPz?=
 =?us-ascii?Q?AP79Ah8CU3roOERImK5WcdKQZZOcEirbZ7tWMVJvefe26bZ2nYZWpjoHuoFK?=
 =?us-ascii?Q?BterqSHnkomHERR/CCq3yDUZcIPzxeT9t3AeRHcwO9bFp1fKlzQLPQb9IquT?=
 =?us-ascii?Q?EdDV7RANNvAHAnX9rGLVtvxZi47PBT97COPDfVnRtgLKc9esjbwwhj76D4r9?=
 =?us-ascii?Q?yuQqeGhUvTSUt7uhbHorNyQJo92ORdEzMq9UZWJC7kBfgnUstF4mqnQcy9mR?=
 =?us-ascii?Q?Q5zAPYiC1/AK8xV8WeMjJi3xdvQHfPXNTqYCYzp0sX8mTnql9VnFMy1AB5TL?=
 =?us-ascii?Q?yb46tM4ztCQXpD86pCBGuj4PP0io7sq7w7oQyg9b1ejJap7btdCSzGdsQOpj?=
 =?us-ascii?Q?zdgIOIeM8TFqZ7Ur7wITEB2zN8z+R54wmhBvl0jo0rSYF519adKDyxBxRjbG?=
 =?us-ascii?Q?NbOZMRk9RqcnQ85OzmD5Ciic88PFmJa4vb+YZCZuMaJD4+OiqukmimDFNEOK?=
 =?us-ascii?Q?GI6X7TAP/LytigO3SDWTxd3Hm9Eh+9gQ2XpRXIPa3b0YMBkT6X9+9NfD8BeT?=
 =?us-ascii?Q?10WCQnXt4Ocmpfm/RgvQNjxA0qFZtH444zERRl4esICUlCFIGNZwyyPNGQGL?=
 =?us-ascii?Q?DvaeXFA8W+dKm+m2ocv7fL+2q2HJ0FUxjtUTwJgkv4A0ZEVcPk9cTRhx9avy?=
 =?us-ascii?Q?e1GYfN1JkI9ycRTaDLmr5C2UU+irGR9gzicyQM+dI/2RpZfeFPTIHQMzqO7A?=
 =?us-ascii?Q?RWSwy/EP2jWakVELNPhbLc/IU85hfsPjKorgGHFH80XV5xsfSwLJkhV8ETZL?=
 =?us-ascii?Q?VUqvwbn9lQs0sGS+iK9PB4WbosMLuPCv1SLd2iZOs0XseA1d/dpQ06C7hczX?=
 =?us-ascii?Q?54g+2/My9lNomuV6A5nIfFZ0X9acEl7xXqiXBSu/TSNn6biBYs3lJ3PDE4Kj?=
 =?us-ascii?Q?2BSj19rEYafWBcKepiC0svLxWi82xSYIQPpD/W9gI+FMyb4Oa5RF2WHO8Knv?=
 =?us-ascii?Q?NxoMxr4OrqQ1T3Qs21Tg1JJCTqp/mA24i+f2+hvkXbtyL2vag2n+qd5kXr3m?=
 =?us-ascii?Q?XydnnOVtvbHX+Il8crm4jGbOzLOITvYGlxdvrKr4GJ+6N0n5rItDGqM9lm/E?=
 =?us-ascii?Q?dORohL79zfLFYW+kcwyOjaRCr31y5Re0AdwhAUKwDvOKJ9XS2ejTIkw/QSzv?=
 =?us-ascii?Q?wtnqb01BrE37Juv6KhO//jX0T434A+FqYXrqG11apBNrXatck/ZdDCMq7pdT?=
 =?us-ascii?Q?+AxF/xUXVLmZ8S6vCTgGFWPklhkemUxF25duU8e5gGhU7jEDyreEDhTKEDHa?=
 =?us-ascii?Q?rgvQcAbc0QC7A6PXGcWIHVV73Jhq80ot1n4prRUyOTLDgM93RNPpJrVZ5KXZ?=
 =?us-ascii?Q?+YyyypjtYbbImQdCvL9XcRvJhkrJta5kSb3jzf+r5zccKrpy6n/ddytF1lDX?=
 =?us-ascii?Q?RBN+mppTjvMgmoFyNQudCEt8jG+FegdLAT0BeICvMnMivYBIQZnwDym9WtIY?=
 =?us-ascii?Q?IQhED/Xc1R2h8JPMgzqnEhEYP6/Gp+g3T1UgF5YOkBGF/QPmu0adLn1XYYqw?=
 =?us-ascii?Q?qcnbVD8uafhcjiTw9L5z0Bley2d5w3M6C22N/zvsD/rRV+jL5aWgh+XFaNQ3?=
 =?us-ascii?Q?Ov5hsMLzhJJXNOXpf6nP7cFxfs8JfYfsr4A7oa5/oOKBM+XymFaVm7mKqRLe?=
 =?us-ascii?Q?28BZ+aRDDQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: C4qTY6Kc5nszXYxhgMpbgO3by6zbfj82V/MD0nc+oKBHP8nXbSrfUwkDZ8a617RnZ88HeY1ak80DKh7wGN4q6QGu8fIysC+zNB6nH+NSAdGr2STz8LnzD/NE6ZfZSfibhxMzQHzjRifEzz/2Y4VDFxui5czZ+eFXCrIEEpr+mu2oIV2yGlWAv9izT4OnYibeGgGlX+r3sgD6q/RWeJJ2Bqiq6zErIopBglBuzbd4MZ5Mvru2PW1kVAu1dMDTZi8hO1v2li5BZWcgC72uYrNO2LVtipaqBc76Hct02MgHLa3/VdpvkqD+Fl1N91KEpEnRuaC5y2Z+eDGdrff/vmYckg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2bcf30-ae8a-4636-41a5-08df4b26b9c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:03:00.9689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL+oaB4dM4VyeNNBUk7a39mkKVSpF7TInQluKLsUjOmQ0n3ABjwZfu6WnUEU9bnKRr/51a/CQ+I2Nk7HJ4e2vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
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

