Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5674CC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 05:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E97010E40F;
	Wed, 22 Jul 2026 05:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Hr5Gvehg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5556A10E40F;
 Wed, 22 Jul 2026 05:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784698338; x=1816234338;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X2DdcAHRLof4GXz1hUrOy8oTvRQ3Exh4viPlKwL4/to=;
 b=Hr5Gvehgej10lt7wSNDee/kC984KJH8JKssxAW/zbMJ4QypWVMLEQGnx
 a+Os+++GWfEcND3et10rz37eY6jFwMjIHTJM+HI0kCr99TEAdejqaQ6NY
 mtIzxOOjn9MQZTMypkBRHFdxt8+MSrdp1r+MzoaKbouxRmBAFnABMX/RW
 wL2+pt7K4BxjO59f2PlBOIX9Xp7eWT/znjwytzPaKN0NrAgknGYKENzGP
 X93E+0xMQ7aWKxGlCtdUNtCRVYLMipgKtLkavvbU3USNQde4X/srH8+2p
 CcJG6y3Hr5SDe0+A4Yn7jtkNGBvC/8tgdnpJl/twZ/uAFXHLfI6C//nGD Q==;
X-CSE-ConnectionGUID: q/HCm8DSR+a4U2uoCAnKVg==
X-CSE-MsgGUID: 8IkgtzefT8W0yqOXqegQyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="102868865"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="102868865"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 22:32:18 -0700
X-CSE-ConnectionGUID: hfqhOka6T8iHwXY2oWZJnQ==
X-CSE-MsgGUID: qk7YyhhrSMaqaiVFkF9E8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254076468"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 22:32:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 22:32:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 22:32:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 22:32:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIwPdYkTW2Bg2BlwVmbQPN7M3KJlMilxZd4c6ZIDFCKnhFIn/r8dZGdrUv8VO7TZzuJMgSwcuppDk77wSu6s8ulhUcmLmqzGItYYZCODdUiiNEpnjyXweAB91NJV2F27MueuuEHQDIX8pH/8S9I8jhnHKZDGWrQAPt5q4ohVWPsTgvPBRTblH9k2S7DAvWrRqvJn5zV1K3xA1mPk/qbH7GWPassQjUrClh5tFodEdP5vw6v3gDuHkqER/vr0E6BpEDJr3T8D8Q3ghoF/k+MwcZ+Ligq5zvcg6zw7Shc8dK2/pHP/cqmkgRFMb5YdbLGjFxs+9PlZYN/iBOFbXpBFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/4CE9uQSixyj0Sy2NnC4ETwplb+lmo/WcDhZCwSOV0=;
 b=CALmsqcsKSlTm2OBoAmylXJ9RagTI+KgGwbY5hoLPnwk/uQFk4+OzYi8p/+dGIbzGFLlTdlWHtV9HkpdUCv3E7kOospEKWZdGJO2zbC0EhYS2F6HWqnSziimibqpyoEx/smKgLg3Mqb+2Wtjg7Xu8UJV8y5WIfgvr6fdPB9S+2mc+FzXZa0JjtebYACSC7TgI2X4lUuNiPbViXoBWCQzAWIAFQ88LKS4igxKJoiFL9iojseZpWY8+wntIg4tDLHArHanZXcp//C6krFRj2ZWSXS8mOUzQaKgs6R/umicOHzd3Sq7q9Nz60becWo0Ga9BvACp+r0G0o0Kopn74XfZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by IA1PR11MB7173.namprd11.prod.outlook.com
 (2603:10b6:208:41b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 05:32:13 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983%8]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 05:32:12 +0000
Message-ID: <e3bf3249-40d3-4c70-9600-c31c3d0ed177@intel.com>
Date: Wed, 22 Jul 2026 11:02:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/pagemap: Guard HPAGE_PMD_ORDER use with
 CONFIG_ARCH_ENABLE_THP_MIGRATION
To: Matthew Brost <matthew.brost@intel.com>, <intel-xe@lists.freedesktop.org>, 
 <dri-devel@lists.freedesktop.org>
CC: kernel test robot <lkp@intel.com>, Jan Stancek <jstancek@redhat.com>
References: <20260721223244.1102276-1-matthew.brost@intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20260721223244.1102276-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::17) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 29720fd6-a087-4c96-c5d9-08dee7b29506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4S45s4+jMPV08RV7OiSPUF3RKEhQKRYCQdKN8uZ+BHNpbjZjBYKC9aHEDLTX6srOIF9MCGsvYnNmFb4nG3L0ND0jkbeb8CB499iZIif6bReNkDkNPKoiXqmGKG3+NPBb2ZFwVamHDaX9CBQMvp7Gkr2Z+LeLj69mNyXxnbYhPyh4koUxesuElPX4+r+i9wWFemlz7L+dSONWZJDUNHffEUk+A4fqHHfFB2bVIRb5Jvpo21TgrOxNyj/bRNzoFNdWe5PjSIpoNKi5Oj7qpQzIASNJJGLXHvQ6OMZKSuftP4qL/1wbzNHb86SMiqO0aB5sPmat/Fx7BTsOd5afWtRgWMIxYpah1LDTo3H/fhgAb8DPZ76/thz9qKUphljeUBJ60QYTdqCZYy3hJw0/h0c+Qck1nDZAVTD9GSL2deEgw8+abGi4l9eIWx8yhH+KBVwOf4dfQ7BJqq8qYlxHuGdQ+Yv6xbpadxMihOjSpE1t+zS+sMBQFvseCwWCuPS56uuA7YAm6QS2HHa1KME+d4TBnlfYceLAGYcp5BTS/E4PGUfcOTeILXpwBlqDuh6MXKJRAzV3V3ii28GUSGVenoB5J6K3p7P8xCWPJO52io4Iqdoui7c/5BCYF9nTYYBngUhOJWTU4l5yyEAQ7PODOWZhjM8Tf25Myu25TsxFmldW3MI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF691668CDD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGNMUG5yM1BXUEcrLzNXSjY0YzdsQmxiOFR1Q2FheW9lbWhjYXduc1h1UERx?=
 =?utf-8?B?RE5raDZibUJ2VXhSeHd2eGtrZFRTSXVmTEg4dzA1OHpZSG4vSzc5WmtqQkF5?=
 =?utf-8?B?bXl6Uy9ib1RmOXlxMnVoRzNMOTEvalBQbkoyWmJJaHN5Y1pFNmZucm5yUjJ3?=
 =?utf-8?B?Q0FEVkR5U1Y5eEFicnRiYjJlWFFwOUE3aWluNEFxTEpIZkRDc2NiRWNOZHAx?=
 =?utf-8?B?c2s0V2dINEEzQ0dZY1o4dTFLaUltWW82YzVsZXZlbU5PTUJmQzBjNVpQekNU?=
 =?utf-8?B?NFM5ZWhnL1FtRlREeU16VHJrM1VkV1VJRE9pOFlWN0pkZFBrN1cveWJ1ZGQ1?=
 =?utf-8?B?eENzVkgvbXJmQnZBSk1pK1RaSG5QbVFoSm4yKzdLMG44andhcEFVNThqR1V5?=
 =?utf-8?B?ZU5SNmhURDh3L1BtMWhxS0JhZWMweFR3dERZMUZBWGhlUDROdFNxVVdVMDJ0?=
 =?utf-8?B?eHhlR3RNWnVsWkh6OWZETUNXSk5MTHFCN2VodWR4NEtFbDA0Ym1ub0dydm1z?=
 =?utf-8?B?eXRIaGI3Tk5mYTkzdDQrMEYyNlBrWjZRdmdnTXhJTDlHeHFRakE3UzdZY0Qx?=
 =?utf-8?B?akxSQ3hJdk1BU3BUbHREelVTSzJJL0k2WEthakdWUE1NaHBSZ2J3RUVkWE1o?=
 =?utf-8?B?WVprUVdPWTV1Q0VCRGVQbkdYRGFWUEpraEU3NmN2ZU5kV0Zxemc1M0s5MnQw?=
 =?utf-8?B?ekpWLzhCcEQxRlJ0QUdVNUNxakRSYW9HS242dTJuRk1yUVFLZUh6RkJlTHdM?=
 =?utf-8?B?OXY2dUpFeWhRMC8rRFpxYUFuUGd6WjBiZDVmS0FLV21DNXdXc0NHWnVHOWwv?=
 =?utf-8?B?NkpDNE5BU1M5T3AvV0FkSi90bGh0ZXdUSWpBdFZQdi9YS1BTU0VsQ01lT3Fm?=
 =?utf-8?B?clVQdTdFOFpIUkVoM0hUOWNUS0t3VTVuYkdPd2FwMDZ3Zy81OGJDWVFEdEsx?=
 =?utf-8?B?ZkpCNUJZMUhBMkxBS3FTQzVINWRJd0llZEZpSm93Qm5sTWZ5VitjblJWZHZj?=
 =?utf-8?B?NjJkM2NYWWN3dG1yM0ppTWtzVUZ1Snl1eTBQRmFKYmQwMDFBaGE2OUF5dzYy?=
 =?utf-8?B?TDl3Wm5CQjU4WTZMemxMTVJQdVdxZC9mcEZaTmlrWGlZY0VweC80bFRwWmJP?=
 =?utf-8?B?TlVCRjlRWlRCbkNUYXhEc2ttWGVMek5lVVZ1bDU0L0tsaXVDNFh4TWg4dXFO?=
 =?utf-8?B?K05HRnMxTDdQYVNIL2FzRit3WWFPY0Rtc0VGeEhTNHpkaERHODNzSERxRHRu?=
 =?utf-8?B?ZlFRTVBTV0ErYWJRczlPdUFsalpjR25EK0JLRERFck15MEJGSW1oUVdsSktY?=
 =?utf-8?B?U1FZY0JKd1Vucy84cE5Ock51V1RJRE9FRlZVUnZydnBjQjRpVHp1NFpML1Jn?=
 =?utf-8?B?QUcxVG42cXVjSWlRNWUwOFZqK0gxQnN4MEpRdzZ0bSs2SFpkTjl4bkhYM3JX?=
 =?utf-8?B?M0JqV3NabjdyS0Y4Y28xcUNMdm9iU21yK2d1REQxRFZiTUtsVzhvYU9kUGZJ?=
 =?utf-8?B?RzVWK2trZUI5MU81Q2FlUTFEbmwyYkpicnFUWWNVNy9OSWVSVWFsTXQ3clFN?=
 =?utf-8?B?MjVnblI4MmZMeFg0UFh1RnRpOWJablZLRVZtRVBlL3RWWVgzT3czL2IrSDM4?=
 =?utf-8?B?bFlIMHNwMndzSkVraXprWG9nbStCdzFHUVpXcjBTaE1QUGVBR055SEtRcGN4?=
 =?utf-8?B?Q2FCVGZUZzQ2Q085ZVFQamNvUDF4V1ptQW9abDRrVlhGY3FneCtxR3VFa1ZG?=
 =?utf-8?B?aFJlVUJJZ08xTGVwb3FGdmgvWTBNQS9JcFB6VjlXZW5jcCsxUzF3Njk1WXFY?=
 =?utf-8?B?S04xSjJTV05mNFRTQmJIYzRpVUNoSlYzRks1aVdpUG5aeXNaT0dNV0xrSjNT?=
 =?utf-8?B?UkRtTmNqazErNTVnVlExSDhIMUk4Zm5FT01pbS9OeVZocis3T2NabnM4cWEv?=
 =?utf-8?B?L0dsODlpK29OcDlIenpSRzNUNkc0QXZNM01NTVlNc3FmanE0VmNGaTZucE91?=
 =?utf-8?B?UmVwWXM2WFNQbUZzSWJsRU1wOW5lWi94TEUxbmx6SnRCWWE2djh4WnZuY1JK?=
 =?utf-8?B?MlFxMjlBYXNud1FqRnNBT3lUSDkvaU1qdTNhRkFFeXhPMzEyTDhiekp4cXBO?=
 =?utf-8?B?YkpuYk5BSWhMaDJIaW05Um9JVlJyQzU0eTlNM0NlWVJsQkhvNGRhck4xR0ZO?=
 =?utf-8?B?MWltSXY1dUpJQjV3SXJBTGw3dE5oRGRBaDBxRkZmVEZuNFRleGxQQ3BYTzda?=
 =?utf-8?B?NHNhaDAyd0IxNGZsNW1wNEhYSjFxMnBqbTIvMkJhMzFVc1NqWURianFwTEVF?=
 =?utf-8?B?RkJDZHVLRFpDWlpnMFhCN0hGSy9DcGFjaHR5dnFDa3h6ZTJYSkttZlpHQWlU?=
 =?utf-8?Q?gZF/tIXetRetonvE=3D?=
X-Exchange-RoutingPolicyChecked: O43BANpRU6pgYEEtKWXG0EI/4Hy67ESTF7vJP6ZMXnHCnsCPxI2ImyQZkd3pxcbKlynMm6/zTBRqL84eGcrLZHR5+L+oORo2z2JkThD/xuHNHdulv1Z7jcZTNeucEL+wJKOPM59sVU4Lc8oaBA1D0RVVv2729B5evIVBX8Vkep8VTcbivbZlz5M5ULVnXuQ6oOQrL51/1cOUHHCkyQO5fzWqIqLGRJkDNPCFP5M7l+6q7yVejlQQrLej7HlRfxGSkaZSkyVUFkDO0/qbzkP9CzVAxdsARAVoKjrlQ/Oa7VxRBs62r4oFB/ZPDPcWilhr+snT/jcbsPPCsnxikl6c1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29720fd6-a087-4c96-c5d9-08dee7b29506
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 05:32:12.7711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVxyiCdia+shG9pAYvQ9yJniJLo+a7qilMRqjB9diVwyOwQZza+8zMLik9aI3cNyiPE58GwPwC0U4NLSrmgQA3JCTQeXRNmTRh9rGkYQbvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
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



On 22-07-2026 04:02, Matthew Brost wrote:
> HPAGE_PMD_SHIFT expands to BUILD_BUG() when CONFIG_PGTABLE_HAS_HUGE_LEAVES
> is not set, causing a compile error when both CONFIG_TRANSPARENT_HUGEPAGE
> and CONFIG_HUGETLB_PAGE are disabled:
> 
>   drivers/gpu/drm/drm_pagemap.c:480:12: error: call to '__compiletime_assert_458'
>   declared with 'error' attribute: BUILD_BUG failed
>     480 |                         order = HPAGE_PMD_ORDER;
>         |                                 ^
>   include/linux/huge_mm.h:117:26: note: expanded from macro 'HPAGE_PMD_ORDER'
>     117 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>         |                          ^
>   include/linux/huge_mm.h:113:28: note: expanded from macro 'HPAGE_PMD_SHIFT'
>     113 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> 
> Define DRM_PAGEMAP_PMD_ORDER, which maps to HPAGE_PMD_ORDER when
> CONFIG_ARCH_ENABLE_THP_MIGRATION is enabled and to -1 otherwise.
> 
> This is safe because all code paths that use DRM_PAGEMAP_PMD_ORDER are
> reachable only when CONFIG_ARCH_ENABLE_THP_MIGRATION is enabled.
> 
> Fixes: 139ab31aea8a ("drm/pagemap: Correct cpages calculation for migrate_vma_setup")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202607201914.LpAGsbXs-lkp@intel.com/
> Cc: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

> ---
>   drivers/gpu/drm/drm_pagemap.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b..951cd92c930c 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -12,6 +12,12 @@
>   #include <drm/drm_pagemap_util.h>
>   #include <drm/drm_print.h>
>   
> +#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
> +#define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
> +#else
> +#define DRM_PAGEMAP_PMD_ORDER	(-1)
> +#endif
> +
>   /**
>    * DOC: Overview
>    *
> @@ -579,7 +585,7 @@ static int drm_pagemap_cpages(unsigned long *migrate_pfn, unsigned long npages)
>   			order = folio_order(folio);
>   			cpages += NR_PAGES(order);
>   		} else if (migrate_pfn[i] & MIGRATE_PFN_COMPOUND) {
> -			order = HPAGE_PMD_ORDER;
> +			order = DRM_PAGEMAP_PMD_ORDER;
>   			cpages += NR_PAGES(order);
>   		}
>   
> @@ -765,10 +771,11 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>   
>   		if (migrate.src[i] & MIGRATE_PFN_COMPOUND) {
>   			drm_WARN_ONCE(dpagemap->drm, src_page &&
> -				      folio_order(page_folio(src_page)) != HPAGE_PMD_ORDER,
> +				      folio_order(page_folio(src_page)) !=
> +				      DRM_PAGEMAP_PMD_ORDER,
>   				      "Unexpected folio order\n");
>   
> -			order = HPAGE_PMD_ORDER;
> +			order = DRM_PAGEMAP_PMD_ORDER;
>   			migrate.dst[i] |= MIGRATE_PFN_COMPOUND;
>   
>   			for (j = 1; j < NR_PAGES(order) && i + j < npages; j++)

