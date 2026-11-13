Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F3606A8A1
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FR6BBMeR;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BH5uY89l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74D810E122;
	Fri, 13 Nov 2026 18:29:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A68E10E122;
 Fri, 13 Nov 2026 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794594569; x=1826130569;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=K90GhH5BNOCrydl92KMJY9VY8jZuxhCeKheZf8Ls2vY=;
 b=FR6BBMeRTCMSO/kIihZhhvSjjyvijv/QRlQg2TSZIyfcaKvinFq4iZWz
 qbgQGuG+vVmRCwhncjuM4ttSEd5JOJEYL/evwqaPy+89/3sAlIM2kW3xD
 g2Mc5LRLe3crpnhFmHdCIq5BrQwfsyhkWOIix7AsXJUViOmlUFLhIk7nn
 vSJAsOAsFL/H9RtyKUWjR3fGhqGQWiI1j21sqhc+XeJ3GJVzKPPMpIOzZ
 NtXsKKoCAz4TwLLpepwyZyB7l6/FmHyy5x9yRWZFhFBpx3CIxZURtlP+l
 NuOMsDeEsNsRa24NpByKLLCAp/U7s9zGvCCXRKHueCMkMGLzWH6rRhjmE A==;
X-CSE-ConnectionGUID: a9Amf3JGQkaMzXlTQbW4gQ==
X-CSE-MsgGUID: 892x1clYT0+wjo2FpcwBgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3310133"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3310133"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:29:28 -0800
X-CSE-ConnectionGUID: MmDl86MZQl2jlJnCKuqZCg==
X-CSE-MsgGUID: Xk2EQoI9QjmuxEPOZsaYig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9518412"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 10:29:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:29:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 10:29:27 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:29:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0oeUm1zOd4S796av3FkpWxwoltD2ikM5E9sBMc6wtKWoR0SJYA+T5RG/wNKsW5glK9a3SgjIseJFdmgf/ji2zMDSUASBny31Equ/a2V5xSJlDUVOFxYY2esvb/xkCCKjmzNxWM2pRpPN7hMt51JC0h2K5OT+euHr1nD6H1/JkA013SZg8gCWbfnza9f5T1ULmBhJjXeuNyTRsDkvAGbBO4XF/yPxXu8QyeFrrCAAreaQvhNSPVlW1u4vagaCV5+E9eZVqR6cMJVtHGDl7b7HWv7xtUP1YTLWEBOPo1Naid0DeMtzfPzUue+ShAvqoYzKSrHjXSORblkSE8GRKNDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3y/KkNC1rXy3J6zmuUonVg+fk6NbuZLNEWrROXUiqQ=;
 b=Vh9hjoEQWkSdSHjK1HWY/Wu4XGcivopSFoT3bFW38kwomKCsQtVNLa4b1u9yRqyZ/WXd84CSfNAEf2LsQvliCvaxM+twp5jW27yLFmHM3X+FXyT5ZqPacf/mBblHlG6LkucrwC3HWAmPGf9fIp4/t6laGWTrG8xKH9AwzA84wOwAjMNPpqiBlfoVWQp8sEaMXXugh3ki7h9zhgM913dchchZPM+9SdQSNwyTT8wrAaQyhawaPPtpfoRwkZwI68AiTWvsZjQCUHszN4XWNrpGHBw5W3CuWuJN/Ilkwp2YPTPusQVre+g8ubEfBt272xl1G7mH635rjMR8vqI9xrwSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3y/KkNC1rXy3J6zmuUonVg+fk6NbuZLNEWrROXUiqQ=;
 b=BH5uY89lEtSoryzc47mdZzAoJH6CVoEcG6fAfukDrySSP4meerUuh2IINs+PEDQMEfj0s73KlNpY8+N1SrjtO0Ia7C8mLL7CWz3lBCAhC4lDWRLHn6ipWUqJsX4Yn9hnfD5QXp4JqFlk+4sRzOAn/okhXcGmEQFssnkpEXjsxDk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by CH8PR11MB585767.namprd11.prod.outlook.com (2603:10b6:610:703::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 17:58:30 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:58:30 +0000
Date: Fri, 13 Nov 2026 12:58:21 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
CC: Arnd Bergmann <arnd@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lucas De
 Marchi <demarchi@kernel.org>, Riana Tauro <riana.tauro@intel.com>, Arnd
 Bergmann <arnd@arndb.de>, Matthew Auld <matthew.auld@intel.com>, Shuicheng
 Lin <shuicheng.lin@intel.com>, Armin Wolf <W_Armin@gmx.de>, Zhanjun Dong
 <zhanjun.dong@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Piotr =?iso-8859-1?Q?Pi=F3rkowski?= <piotr.piorkowski@intel.com>, "Tejas
 Upadhyay" <tejas.upadhyay@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: xe: select configfs
Message-ID: <avdPvYEu-TBCbKTJ@intel.com>
References: <20261026102603.2045493-1-arnd@kernel.org>
 <avS7mZMrS7nQv_RK@intel.com> <20261113162212.GB7214@mdroper-desk1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113162212.GB7214@mdroper-desk1>
X-ClientProxiedBy: PH1PEPF00013312.namprd07.prod.outlook.com
 (2603:10b6:518:1::d) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|CH8PR11MB585767:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6934aa-4628-4492-4f47-08df41afb99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|6133799003|18002099003|261009223327099003|261009221727099003|261009221227099003|261009223027099003|261009220027099003|4143699003|56012099006|10067099003|11063799006|5023799004|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: boOWF+fvgWwIHZWt3o802VJahWHxItuBimvtPZtTyoNcTs3MXFwDfa6EcJhhVH5J7PX6HazlapBw9Jk37Xiact9SsAKAMClUuNUoKsXh9z3Qx5isF8TMtSxu4G1Jko6goQksnkDFT7AxdTKmplCi+gqGIjpq5QZLeuhPc7SQLiS7X8nVg5FGxEMWtnpKrae50V6XK0+yxetRwba+Aa++Y87gh2HtsFm1mnmnXBVqGFjvvb1fhfkykAeL0y6iR1bqjh4Xid607Ay33EmtuaXyBhZYW4c4tPWoXBr88c3pNWkRR+9Qi3MYLzZi/9jJE/kETJYRavzxvV6QiA8S5mZmHGBA8fjz/HOoAuovCagLnClqmxZS1Lekd+mudqf4E5Yw3TrAv6nh/Rsry7mM6bA83G/P6UxA3UaQoQl+2LRj3OAgWiw++TByc9wc0kei8FRBlftYEfqO3diVxtycl77kbwCh7Lhfodj+fWGoUnAyJzuh1HwJ/laUIRp7OjuyEjDaDpacQCyAKRVi8fly1JN26eXbFOCb7LBhKhVgPLm62rZIUAt+or4C3jzkVSoz0HbfHE4HFQHN5nSd36rJYQUqnT9DiAB0MUs6Umh169hNIUZEBzFiWN0Hr0BekK0j4+udAtiB6T92njgZQphV9n2ziMXg7GkRDWgTp5gOLGau4nI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(6133799003)(18002099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009220027099003)(4143699003)(56012099006)(10067099003)(11063799006)(5023799004)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vtI2HLyuV+PbR6XTgs2h5cqyF39lcKUz5NdWKT2NmPciFvmHDyyBI6QSUO1?=
 =?us-ascii?Q?2vIa9yy4/R/aE429s37r5NWdPMB+q9kxuqw//TKLvVW8r0VYDhuvauWJBLhH?=
 =?us-ascii?Q?D8jWsEEYdN513vE0mn0wonY2ssD2Km4KM6prrIo5Iln+c+S1IWrBfZ/s56Sm?=
 =?us-ascii?Q?KJxuIkMAWoEbOzfddS1FFBbVb+64Sxs0/5Jxv72XW+78Ai5yyKyGeqfoyRb/?=
 =?us-ascii?Q?sEVllJDWxFhvsKaiTz39xPBTxopk7/qRzotMBjajnBnOcFJLpN8COch3gc7g?=
 =?us-ascii?Q?0a3vjzkrlR824+lXD7RxViXWz+VOdI1OMiSETpKo3llORw4UmVFUxJJhfPtP?=
 =?us-ascii?Q?gsR8BOhEHdelXW7yrg4CuCBL7UIQ7++5iDZlHrOusKy57qm31X2yw3BsiISQ?=
 =?us-ascii?Q?1Ull3XwLtC416MtYegjMOeVOfuR5u9kCEBu4lOXoUg9odIsV7cWeDs+ehdPO?=
 =?us-ascii?Q?EWMj8DlgjUps38cebVqW++GlVJXpgRyaIbNQBVEImgmM3cWIbdPZ4jJ34Hu8?=
 =?us-ascii?Q?x6FXXFRkdXCRAlCaj3S9MCdDksfGE/cNk7Uq1wh5Q4i8/1EiLNYQdl/38NKf?=
 =?us-ascii?Q?z6zl1JkN8ULQCUIvg8QoNPvfnVsBzytIvz8P0rJ9vSfIHObYuWW5SmxuYP5l?=
 =?us-ascii?Q?wCQR+m7EJWGsKZFvD/5VMQx5d5N8Y8uCr6c2PulUsTiaP0L446wyRdosLY6j?=
 =?us-ascii?Q?EjIdPHIzhUA5WEgo5SAWUbYQ9A2FtUN1x64/AkAO0RuJ8WIwEc1xYPE2m3Tk?=
 =?us-ascii?Q?sNS86FxcEl85OuB3YcvlXFg2eo5kvaZzr346JVSr0PnOUJfTKJYRkngWZzil?=
 =?us-ascii?Q?xD1Q+vYjcg9/4PFxowyFm2Bzkkv+gbH7MpJ063bkotin9Mo+RFRPweytULsX?=
 =?us-ascii?Q?DxZk1N4Ja/JDWK1eZQ14HLvbjOSdS6pl/XZuMNwiHUviKv4oBEiZGJxRB9rQ?=
 =?us-ascii?Q?vg1A0CDF0uUZFaqlOniJlH8QoNuG5bXIWAEWUFvx77M30ODxMf19umMoaByM?=
 =?us-ascii?Q?1Tn6ItidY1vCQ/RL/4PjCyyJdi0aBjPXcCLAeXXPaIiitTeCcwQkJP6ZbGqd?=
 =?us-ascii?Q?yU1gZ4uX5Jbp3i43IXs6voE8Y73nfP9FFhm5UDwpnlAzU4B1bM5G4q3WlYe1?=
 =?us-ascii?Q?LTC7TJn3LOZcCo4IzY1iOhvfqNBtPG6f2NI9rRLEJ3yxtdg4auYEhfgtxRRg?=
 =?us-ascii?Q?rll9XmJ05hc1bW7Fj/Xio8gXs3Sk2rEhtn33PjSVkzuFwrnCe97MAjqDwQa7?=
 =?us-ascii?Q?+q6pclr7N0hRCMW5cJghYUFRHLe/Wt+UEL/9QPZ6FVa7JECmSgvmAhw3JvMH?=
 =?us-ascii?Q?lnZsencgDq3E9iXaSIeqIYpyXcXXQz7uSZpfi3w8pad997URHGMdosErPA2K?=
 =?us-ascii?Q?tRF3gzRFi4JKOfNUDNmuaoeg9qqDlgAp0O4bjZD4QUd2p4WeVMXDLhOXcygr?=
 =?us-ascii?Q?8mSfkAWjiCfBDA2ba43btDAa/K4EtQYb0D1RSQhtUpemth7MwWZ4YDKc/w9T?=
 =?us-ascii?Q?zbex329wxWy8G8uHXiXPoXuOBhH50fx9CfjKTYNPQ5trQ9kys6tHf+YdCvxs?=
 =?us-ascii?Q?E2hrJwUhXQXM4bhnOzZhNv1sCKIEdlO3zkYK7c0JBItBAs0tdH7e7U4EadIi?=
 =?us-ascii?Q?ZNYwchzyrOAROMN6dqB8ll0EW6tr5XpgTi8dR0erpbgLyVUDfI6oHxcZR5di?=
 =?us-ascii?Q?YNOj9O7t0fOUu6zaxWlU6FtWhjF+49BdWSHqV3okrv6lhNgwhcmR6YBQNUp8?=
 =?us-ascii?Q?jSFKIOaS0A=3D=3D?=
X-Exchange-RoutingPolicyChecked: 21j0lqOaXFd701UkuirOsVSo3+ax+M5x3PLLuBfqhTuRLy79yUG04pExeAsbc/oqHMY8EHHhQZVEReYOotPHffinqv5koKG542vVJ3EstDqkogGEvYFt/UOwr7ftIJeRUhFpLSBsr6IbFIEjltbv35EhcI+/rY8Ys0Wqq55df5LlzgUBjxnAg876MC7FVka9glqUP2QhsTLuRn/sRkvrGq1r65tDcHBtDWEN9X+itSSnQZOA0/JXhqvtlh0mDDzk/HuwDES9UN3Zi+lFCOWc10oXU+QMQmROmYOubBIB9AC9KBpuLtkcF+BDECL1q/G+pWRRv/v5D7YKTLAsE1IRzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6934aa-4628-4492-4f47-08df41afb99c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:58:30.3386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYoSaL8NfJReIRUaeByjtQZJJF558KFGKfobEuRGEzPtQL08puXrTkKYsBSryZ2msIyOnuUjk0H/pmePI9QfKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB585767
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 08:22:12AM -0800, Matt Roper wrote:
> On Wed, Nov 11, 2026 at 02:01:45PM -0500, Rodrigo Vivi wrote:
> > On Mon, Oct 26, 2026 at 11:25:50AM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The original addition of configfs to xe missed a compile-time dependency,
> > > which leads to a link failure when configfs is enabled as a loadable module:
> > > 
> > > ld.lld-21: error: undefined symbol: xe_configfs_get_survivability_mode
> > > >>> referenced by xe_survivability_mode.c:224
> > > >>>               drivers/gpu/drm/xe/xe_survivability_mode.o:(xe_survivability_mode_is_requested) in archive vmlinux.a
> > > 
> > > A recent workaround added a 'IS_REACHABLE()' check around the calls into
> > > configfs, which makes it link in this configuration, but this is generally
> > > a bad idea because it makes the actual behavior inconsistent and confusing
> > > to users that expect configfs to work if both xe and configfs are enabled.
> > > 
> > > Use 'select CONFIGFS_FS' instead, like every other configfs user does,
> > > and remove the unnecessary stub functions. There is little practical
> > > difference here as anyone using XE graphics is likely to have a complex
> > > configuration that already selects configfs anyway, and the link error
> > > or the IS_REACHABLE() would only manifest during randconfig testing.
> > > 
> > > Fixes: 30499cbd7961 ("drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m")
> > > Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/gpu/drm/xe/Kconfig       |  1 +
> > >  drivers/gpu/drm/xe/xe_configfs.h | 30 ------------------------------
> > >  2 files changed, 1 insertion(+), 30 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> > > index 4fc8abdc5cb6..b52a8dc28f97 100644
> > > --- a/drivers/gpu/drm/xe/Kconfig
> > > +++ b/drivers/gpu/drm/xe/Kconfig
> > > @@ -11,6 +11,7 @@ config DRM_XE
> > >  	# the shmem_readpage() which depends upon tmpfs
> > >  	select SHMEM
> > >  	select TMPFS
> > > +	select CONFIGFS_FS
> > 
> > Perhaps another option would be what Jani had suggested:
> > 
> > config DRM_XE_CONFIGFS
> > 	def_bool y
> > 	depends on DRM_XE && CONFIGFS_FS
> > 	depends on CONFIGFS_FS=y || DRM_XE=m
> > 
> > But anyway, we are depending more and more on the configfs for
> > production choices. So, let's go with you select and close this
> > for good.
> 
> I really don't think this patch was the way we wanted to go.
> IS_REACHABLE was giving us exactly the behavior that we wanted,

But it caused other issues like reported in the commit msg of this patch.
With the risk of other complications like Jani had pointed out earlier.

> but now
> we're getting behavior that we did not want.  Xe absolutely does not
> depend on configfs in any way.  _If_ configfs is there we'll enable some
> config options in it, but none of those are mandatory for our driver as
> a whole.  We're perfectly happy to build and run without configfs if
> it's not selected in the config.  We're also happy to build and run
> without configfs functionality if the user wanted Xe built directly into
> the kernel, but configfs was built as an unreachable module solely for
> other non-Xe purposes.
> 
> While this change won't matter to 99% of the cases where someone is
> running with a typical distro kernel, this is the kind of thing that
> makes embedded users unhappy since they're very carefully managing their
> configurations and we've taken away their ability to avoid configfs now.

I believe some other user could be angry as well for ending in a case
where they need manual survivability mode to flash the firmware, but
they don't have this option available because in his config this
option was not reachable.

Soon SRIOV will be another production case that will depend on the configfs.
I know, one might argue that we should then select only if SRIOV is enabled.

But I don't like the complication this is taking on a very simple thing.

> 
> Also, as mentioned earlier in the threads, using 'select' on a
> user-visible config option rather than a hidden option often causes
> cascading problems down the road because it ignores any dependencies of
> the option being selected (configfs in this case).  At the moment I
> don't think configfs has any dependencies of its own, but if it gets
> some down the road, this can cause problems.

I'm not strongly in favor of any approach, as long that it doesn't cause
other issues and regressions. So, if someone want to try to bring this
again, proving it is a good config combination solution that won't
cause further issue I will be glad to accept.

Thanks,
Rodrigo.

> 
> 
> Matt
> 
> > 
> > I'm pushing this to drm-xe-next.
> > 
> > Thanks for the patch.
> > 
> > 
> > >  	select DRM_BUDDY
> > >  	select DRM_CLIENT_SELECTION
> > >  	select DRM_KMS_HELPER
> > > diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
> > > index 327b648944ff..d726800de26a 100644
> > > --- a/drivers/gpu/drm/xe/xe_configfs.h
> > > +++ b/drivers/gpu/drm/xe/xe_configfs.h
> > > @@ -14,7 +14,6 @@
> > >  
> > >  struct pci_dev;
> > >  
> > > -#if IS_REACHABLE(CONFIG_CONFIGFS_FS)
> > >  int xe_configfs_init(void);
> > >  void xe_configfs_exit(void);
> > >  void xe_configfs_check_device(struct pci_dev *pdev);
> > > @@ -36,34 +35,5 @@ u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> > >  unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
> > >  bool xe_configfs_admin_only_pf(struct pci_dev *pdev);
> > >  #endif
> > > -#else
> > > -static inline int xe_configfs_init(void) { return 0; }
> > > -static inline void xe_configfs_exit(void) { }
> > > -static inline void xe_configfs_check_device(struct pci_dev *pdev) { }
> > > -static inline bool xe_configfs_get_survivability_mode(struct pci_dev *pdev) { return false; }
> > > -static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return true; }
> > > -static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
> > > -static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
> > > -static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
> > > -static inline bool xe_configfs_get_enable_multi_queue(struct pci_dev *pdev) { return true; }
> > > -static inline u32 xe_configfs_get_migrate_ulls_period_ms(struct pci_dev *pdev) { return 5; }
> > > -static inline bool xe_configfs_get_disable_vram_page_offline(struct pci_dev *pdev) { return false; }
> > > -static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
> > > -						     enum xe_engine_class class,
> > > -						     const u32 **cs) { return 0; }
> > > -static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> > > -						      enum xe_engine_class class,
> > > -						      const u32 **cs) { return 0; }
> > > -#ifdef CONFIG_PCI_IOV
> > > -static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev)
> > > -{
> > > -	return xe_modparam.max_vfs;
> > > -}
> > > -static inline bool xe_configfs_admin_only_pf(struct pci_dev *pdev)
> > > -{
> > > -	return XE_DEFAULT_ADMIN_ONLY_PF;
> > > -}
> > > -#endif
> > > -#endif
> > >  
> > >  #endif
> > > -- 
> > > 2.53.0
> > > 
> 
> -- 
> Matt Roper
> Graphics Software Engineer
> Linux GPU Platform Enablement
> Intel Corporation
