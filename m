Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71A8CD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 23:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291BB10E634;
	Wed, 17 Jun 2026 23:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QFVdfjeR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24ACC10EBBA;
 Wed, 17 Jun 2026 23:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781739018; x=1813275018;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PNKI7HidkQpKAYFoTo0dvwR9lCZ2xLjWjZkqjQeNHW0=;
 b=QFVdfjeRmnpBQeda3aHrSPgKB4Cs2tMGLAdMc8/oZ9QB60QDJHVdf7f4
 nh/RoqmGTuq4rqjq8IrBWLyalv1V9Ue0a+BXY3eSmuT78DTZdWjWE54yQ
 GQ/VUGJW5FF/C5AA+16yZYOc3rH4n2xEM74GlYG7nB2K01GuLk8j7VbfR
 vQZfhZsz36yTsd7lwN0DO92VhSpyLvhxnYQ6zGQIvl8v+IWw31gCRGHAx
 sUhiDtrG6dLWiZj1NW/jt/TdSg7yzrb1DBl7Y+pI4daZ/dV6UJ3drtba5
 tIh03bCxVJTg844fj54djoSwyOReJgr4duslX6N6o9ALEaBPO35udx2T3 g==;
X-CSE-ConnectionGUID: IvxriQKyTpq/m1ZdZYxuwQ==
X-CSE-MsgGUID: f3d7JbkFSiioLxKlacq1eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86404249"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="86404249"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 16:30:18 -0700
X-CSE-ConnectionGUID: 8DF8JRb5RIOjN6aOD+/mqg==
X-CSE-MsgGUID: 6XZaV4dpQSK941JNR3h6yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="247059115"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 16:30:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 16:30:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 16:30:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 16:30:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEY4BID+aZM09yoyH9j0uhdN/sx6yybieo/eBRigXg2/ARDbI3I48ac8CaAWhZlJ1kiG89Ra5nx1feoJ90E4IBtDNcgO77VjkqKeO3TED77tjyD0So0wj+P3FEu6wfFcIBjfyuwwgHiEQe7QsJA5CkhIPRe4EYZmGGVvyHeUVIclmqtdv8fSzY/F+7HVYQbG8a3wqvOFw0G9RouTThyxcxZyn5Z4Mp+5bW46PjwFX64W/WJ9ZlyKa2SBQjVG0/CHJNn13AqhvVQjxkXr2nCSfWkNRUVARdo/IVLwmVBk/OcchjgZvGcvDtIPlvO30ls5iUcigmkQg3Pd9OkAJ3g80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxBtj/hqiRmFecxtqyRGvA1Zmsql1bXHs5NjqWmhrIY=;
 b=Hh0xJAyZwrw3ocu9f37JS21rRrdBwEhbTwArJNi6vOHAvNAF4ertsNDHRObx8Qben7CY+7EX/tX/Ws3ovMaycSErP6nzLrgSlTNyo1O+5cSUAAuQQdGEIoxDhCH/zcm7JmoEgslwb6ygwsWX4BIA33HKy8zX+3MYorwszhlgKADimFHUJFDi8VXSncG/UJIWFIaaOdRd4hI5Zz6g2PXj03n2s773H2qmNU2pdX0zsahvfBhbzzpMLBz7Ld4KVvY3iqIUbtuPMoH3zo9Bu7b8MDWrhDZoE6O2jF6SGceHKtL/C3CoXYdjyI++Rh/mZdXNxy+1FJVacSKx3ZzEOiDlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 23:30:13 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 23:30:12 +0000
Date: Wed, 17 Jun 2026 16:30:09 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
 <alex.zuo@intel.com>, <mripard@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>, <Rodrigo.vivi@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <thomas.hellstrom@linux.intel.com>,
 <tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/2] drm/xe/pagefault: Add SRCID to pagefault reporting
Message-ID: <ajMuAc9qWxnvT7HJ@gsse-cloud1.jf.intel.com>
References: <20260617181849.769247-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260617181849.769247-1-jonathan.cavitt@intel.com>
X-ClientProxiedBy: MW4PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:303:16d::22) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ2PR11MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3d2bc7-43c5-4ad1-065b-08deccc86105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oQUu5yVFWWQ2MGDCJFhrKdUQw3aYJe9q67lO4YLmgraMObSDFUFDC5Z1bw5YGxRSjSFYaJsdSVOu5VD6VRAv5iC8Cm4Zi6/5d/fA6KZw2auiEGtTY9P9DonbTUKZDjo43V0fKPRSg7seTY3cxAyBOt2xrEYHtaCyjMMIh2wVicZsgJdkrKXuRrRJnStHuIZpBon7BUN8LeeCHB7NY8dEm/jaB4uziSdNcStqms7LA0akcKHML/LNyIRiB2ZhqJvFVkM5/Y5HUUOqnqsk58gcmybGVFkjm0zt13plW4z1hhsRhSaXzQKVG8c0Ky/+gHD1oVlUtcyrMR9+SoZ81mLD/IMpYNEbEywRvx5PuKS95/Ku4npA2d3141jbH554EdpW2gxoeaMGUKR6+Vy84Y2mKpeBc9YfkAawXn+gKsxMetV5awfxnSGLE8MuJQMitSaCbmutbG7GfiKvJa6w7KGbnz2H82m+sSOXm3AWzGY6gsP1ssyfJvLFjoUhpz0Hgif4BWasTfP+Jf+l3oPPIDCYWy0nK4t89XkcvtGlwvm61cgspi5od8dW9JqtHEQIOIKo6Ki1J2j8Om8nCzjM2tKYBE2BrKSSqzn5n9XIxSUqVDfJekxJxbJ7n8uX4FFeI1ApZ8t9Z4dIheqBlIGBGpWTJeO2tFDn0YTjk+RN1jifDlHIlZn46/qg1Pp5Wbj0xP0R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rORfZiv62j/JStwnCSxKdxt4yd1ePQa7tZlUa8Fs/YN1ei6zEN4WHDCV8iHc?=
 =?us-ascii?Q?qPneGUfLhycGWnBJU1FZikt9tQ5ryLWeY7MWfXgLixp3UNZD8PHU3+REnRd3?=
 =?us-ascii?Q?muF2O5/Rpr2bwTKq71v9GKMTfsn45I/NYW+3MAESPV6neObo+EZQB1T7YrRI?=
 =?us-ascii?Q?+A5Wk6e1hn/qVeq3hDd/t2YpbWVWhqBeUYxtGxSirg83dupfHkY0qaip6iU1?=
 =?us-ascii?Q?xuj3gfsto/PYDY0jSC61nja0pGZ2iRbmlqBGO+YicVpt4t8D16B7TtykIHlQ?=
 =?us-ascii?Q?l/rQMOHpf6nbFNg4zoelPDRWDIJ2SB/PFwaF96HYVXSZFFu103annWny/r8w?=
 =?us-ascii?Q?CvoTUGVeprclWhmkvnTk4clFtinh+oEKyhwr+KDf9zc6bnDBjdx3z8qcRat0?=
 =?us-ascii?Q?Bk8y9oRlh5cQf8uyj8YBxXkBlzFi3artok2MKzSWwuT2fAc60YXXldQhbWGT?=
 =?us-ascii?Q?+gRjFyhJDt8ime9mFs3BRRsyb3Pv7Px3gyffLIhST1osoCkaQHrBpY18ZaJo?=
 =?us-ascii?Q?7NXArFQZRV6da8PxEOB6utaroDeqtZEl1a+xQsug+3m4I6NrJPWmNKALutAV?=
 =?us-ascii?Q?FzMdL/OkU/pH1NibDasE+E74WorlXYWdD1bvtjUm4rC68uX1js/5qU8dUlTx?=
 =?us-ascii?Q?J/sPPK9z2NYaNZVM7ZAAgDdMBndIABnhfNsN+Bqat/mRwZbemXI202KdlA6l?=
 =?us-ascii?Q?kTkJy8mTorW2zOP1AIyLxHfdUFIKijzw5p+v8vFABFQSSlG6/NJSM1itp6OO?=
 =?us-ascii?Q?yCktzlMeONlRc8sB7DL0rz9eXFezkLVBkFoY0lPiSoXEGuZVRZ1tbXswBtfz?=
 =?us-ascii?Q?zwcRQB+gyg3YESWP58rQgWPuf0oVIHoj/wdcsrOXgAmUWpAKF2DCRoPiRue3?=
 =?us-ascii?Q?g2R2mb7D71iry1A71f9f5z9v0T9r1B8govsrXAQ7XbZE+06PFNXl+wkAJbmT?=
 =?us-ascii?Q?eHzeto3jtwEKkQZp5RTTlHSILIvC2UkzWYrAQdnigrHony02Go2Bl3KxOdsg?=
 =?us-ascii?Q?CuIhkmCB6zSvu0F2DJ/pIrOMqwSrt8DAOnOlVF6eWG0qguN5EflYpdHX/zqu?=
 =?us-ascii?Q?+WM90oCTu9kbCtIHW+2+uNz40v29mcy1LLEVsEd6Zf+9yNGSIgNbzBnMqWNG?=
 =?us-ascii?Q?pPZgEkIJoQd1OvDa8dptk3Z+sTw4aAtNavXZZKRXE+58E7cCQ3bJXDxxBUQk?=
 =?us-ascii?Q?2TFMIJnX95YThvLoP1zb+AqxCa98I1W8lFRLJQ5ia+enqowW4d0LFWVxhdJE?=
 =?us-ascii?Q?pAQ1qGqTyfDbJOBI0IulIiq1uRa6XvtP4JmY6gPUyBtJJHFlw6YtDHRDNZX8?=
 =?us-ascii?Q?owa7yxd0FkpJ6E2NKZGWaxjaBP4e16anWglXjKtihzFcynL5JLB3/ppppgiA?=
 =?us-ascii?Q?dA/jGNwaiFHyfw0LBGE43WbNNSLGpx4wqKG4p0VdOWLXjrtUhBm/zN+FTzgT?=
 =?us-ascii?Q?1VCgfaYF74FIPt7910xMC1uy6ZbSQmPIHhOVc4Fx7CT2taidNEyFWCloiXcH?=
 =?us-ascii?Q?+W3tK6GxUTUBbnzL1nq5QAOTzrZMffOA/bI3sR1v4q4ww3yCGKZlHGPczB9y?=
 =?us-ascii?Q?+RhlsnUDBQbwMlinlvP71Qk48ik2gko88iVq54d9FdEix0j2Laud4ho8l4X8?=
 =?us-ascii?Q?8R7kInS0bxNaPStvSVEUOux2A2rycmco/Lnw7GcYETHNgnIFz73kDyp/01BB?=
 =?us-ascii?Q?E9ZUEDrIK720F7Ot4PegSSqqoEAnoEedd5ZrMDpqlsg1yhwMg/uSheZXMW/5?=
 =?us-ascii?Q?pbJLjg+i0g=3D=3D?=
X-Exchange-RoutingPolicyChecked: YPMQS+mYLq/mkYttVASZ2VcNxkZHxnDHSNsj7Uq9uyD0HyqS0h7G/kZHqzWpGqE+TDMWtvpy4m1DqdIdKYQKGHAfO08Xc5ypiSqENhZdv323TJf92cx2FXVOHcJCve7rz/4N0cTKtGh81rQvIFxZLjlFK8G9ugUwXkJIXEgJz62t3cbIRRcUdE50SiDAC9PiF+oWFvlsy0XPL3OgyRLmlCfB16rb2kt2Rgg2EieNbUaCbfuyWH3qNVjPeazd3ogr/ZKbPH9LfXK8IWD8EOvSGx4BTGWfRM+yjHHAsOBkLWGX3BpDMWXtTJ0evo1G2Xo6YZx/4lR9YCbUw7XHj+vogQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3d2bc7-43c5-4ad1-065b-08deccc86105
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 23:30:12.8904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0XmA/regXU3uDMhS7VXN1Srp7pEF60TXyDBiEhnWbMqAoAjdK6HX/B1gjtm8Lu5gUo9QSYfc66F4eyvvmBQlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
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

On Thu, Jun 18, 2026 at 02:18:46AM +0800, Jonathan Cavitt wrote:
> Add SRCID to the xe_pagefault struct, which reports the ID of the
> faulting hardware unit.  This will be passed on to the

So is this the EU ID?

> xe_vm_get_property_ioctl for reading per-vm faults and will assist in
> diagnosing pagefaults.
> 

Is anyone asking for this? I'm wondering as this will conflict with one
of my series that is inflight upstream and believe is merged in some
internal branches.

Matt

> v2:
> - Readd pad check, as the pad in the ioctl struct was not changed
>   (jcavitt)
> 
> v3:
> - Rebase
> 
> Jonathan Cavitt (2):
>   drm/xe/pagefault: Add SRCID to pagefault struct
>   drm/xe/vm: Add srcid to xe_vm_get_property_ioctl fault report
> 
>  drivers/gpu/drm/xe/xe_guc_pagefault.c   | 1 +
>  drivers/gpu/drm/xe/xe_pagefault.c       | 6 ++++--
>  drivers/gpu/drm/xe/xe_pagefault_types.h | 4 +++-
>  drivers/gpu/drm/xe/xe_vm.c              | 8 ++++++++
>  drivers/gpu/drm/xe/xe_vm_types.h        | 2 ++
>  include/uapi/drm/xe_drm.h               | 4 ++--
>  6 files changed, 20 insertions(+), 5 deletions(-)
> 
> -- 
> 2.53.0
> 
