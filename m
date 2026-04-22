Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E107FAD3E1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF75410E2D8;
	Wed, 22 Apr 2026 23:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dGB5BbnC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFDF10E2D4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 23:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776902117; x=1808438117;
 h=message-id:date:to:cc:from:subject:
 content-transfer-encoding:mime-version;
 bh=STUPb2uhGO4rBlh6JH+BsvhHLW8j+J0jpvw1+jCARSY=;
 b=dGB5BbnCOuoMcdyG8TFeDyPwHOESKVYZHJcUKrA9jvoRN+wMUM2hhJ8D
 LPgzziU+fXxkpz3QMI9vmp32Nvph/qBO2DwI8uVgfwO/s3a/tm4bNyJUI
 m98oYJCLWK9hLXcM/3i7DbQp+zo5RbeA8UFnVdx+lJPK+mx2PEjcC/Emm
 E70XxIvWIusFV8VixQKjlkcEPxWwzaJdUzr6ZxSRPGcfm0putm3HY6LOR
 0r9PloCNtyNWtE+flcVzPuCg6GkOb2TOxf+yh8x3O2JcX4qfVzAMDkoq3
 pwaOVeVMOMHjeBLJwOcCQEG/0MFoO7p8cxkP9kuT5JEPCpORS0t5sOGTj A==;
X-CSE-ConnectionGUID: i8bRr9h6RdaHuTiKrLGM2A==
X-CSE-MsgGUID: jpOojHWmSP6Oh/FkW072KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81728458"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="81728458"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 16:55:16 -0700
X-CSE-ConnectionGUID: 3+RzGJoLQ56nt1k3S0djTg==
X-CSE-MsgGUID: K4aEA1jUQMmVCM4m4eTBcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="231445784"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 16:55:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 16:55:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 16:55:15 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 16:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMTmZHbElrfSS+iqLT0/QlA3i4juOzTbn7IzBLZla3EEjk5b8tHGWmHDKxSQKfEEoBF6S0MZSnM30YX3yfjkyKJGJj0MB13fJxEGBD/4d/7nm27jZRmnAG0yv7PLZmCn1yNjP6Hr/Yke6dCQntNkdE01PqD14ZpHd222dnBYYyflTUyGHr/PVKIjSN5bG9KjotBRnVB2q0tOq8S5fVmooB0wGWKSqGtz062C596sGe4c5J1ZePjF+4pQCjk9ul4A3wLT2RWOsCGXsYpHoNgzmTXNJyckT8NYpmH0wbYkrfw1s6/eXSooLHDG5UzafvTx6Ikt+CqSVY/3zurBbkrmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Aa1t2kQ1RDD2ORase9IyQxPvpHZ6NQiqFIixzlsW8w=;
 b=fjcIhEpEE/uyMS/+gsX7ua14bd63tCnVIH9ZarFP55Dq6D5Zy67ZqbrX4RFOiky4OsOP6mvxeXH+CH84v/Rnzxxe0I0BFWalNqDMWhC0Z6CUPfcdxRceqWan19yYyyRqV4kAo8ov8dk7HoPaa7acTvXT9IDjvyYMDxw3pTkxT1eRj3Rp1qPl1Qn/Jy9Q0V4o85zsnM6dfUYX4sk3iltTtG267AwLR5l0T5z4pTHpV+Ml4bajB7X3nlmEo+g/2UmgNJKL+MI922jnXLi6dtB/rD85rga3AsN4PnOu5vHerPMo6coErMoh7PCi3iAW9UqB6nfJg+30AP+w4nKpOxK7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 23:55:08 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 23:55:08 +0000
Message-ID: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
Date: Wed, 22 Apr 2026 16:55:06 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jocelyn Falempe <jfalempe@redhat.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, "airlied@redhat.com" <airlied@redhat.com>
CC: <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Pasi Vaananen <pvaanane@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: further issues with MGA G200 graphics chipset
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:303:2b::18) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2544ae37-8ff8-4099-b0d2-08dea0ca956b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: DDQGe5uzUOy4zEhUSWDKLxImR6rzlKr0dN9Z+LNlppnJEEQo15jJRf2Y0ZIPXmglJ51YY4+vDF9mC0YboHrRPkZR0NLY+V7YWgCorjcmp5AgT6RXdc7qWEeVdxJoqmXeaMHKStZzOuBoKKIFUgmqIrmahXDXWVxGcMhKBBq4oDXWKauO6oYwUkFn5PTS6dgkSaW0kjPIXgzojIGEJbQzbCGJ6ntpw+j1VwCJ6ZMX69ZDAXimet1f92auxkcxr+5hmGvoggspXSMEbDq5X+AoriePXR/pBJOgXkYPO3kUHbL1vIfpCBJmzhrDxJZisdrvQbhHJ5G9KQ4H1TX5zGgape/iKatZTVh0HH65YjifakPET1ny3lvjMoivhQ2gDvedNXQcBNGl41QCwKasiBfF2UHTVyhTImnTUnOe8/FUe6AqpzG6Grk1bXNlqT7CXJIGh2gc0gpZrO7UDwSra1RiPMmAbcc/GtBMmA+4uDhvS8Qa49DLRnWBhZaYumgZkJe9fVRn82dRtTLO8qDVPQX2pjgP/9y86MwOTArQNLXtapcSZ4u/DYF37VOnMxsqx7R4hhn+TFasIi7qZ0yExeyOQxKgvtGfGHrDXYohYDW3GlZ/0Jlcxi3QekP0hSPBxpfscAmqebWjvfd00zSPAEAmntrLwgxdp5EzGx00aPksOWIwBbDIIyIdgaNcfx7JiQ/pDZxSzSeZlEftsobWvTmR2d2YzXlMVt/nTnDyLt/Ee29mAg4XngvnLfFsGF2Jlg4g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7579.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lpSlloOHpYbVRDNDdnaEQzRHZabmxnMjhnQWZHTFN3QWwzRnQvNFFuSmEx?=
 =?utf-8?B?dTNBdHZTeVZmZG0wT2dmTGgrc2RxakVmQWJzVi8vQWlYR3hSQzJzc2JZT24v?=
 =?utf-8?B?UnYwUUlTQ1I2bU9melBKTyt3RXlNMGlySnhsWHdWZjV0T0lrWHFMZmN3OUZl?=
 =?utf-8?B?M3ZxSWJKS2tQYnB1a082dVJZQ0x1ekw0NGJzY2E1cUp5ZXhWcEJwYW5uZWZQ?=
 =?utf-8?B?S3BjMUdDS3EzamVvOXk4YU5MWkdoNjN2UUxWSzNZSCtFSU03eStCR3VES29Y?=
 =?utf-8?B?N09iYjAvYm1qMUtrd0YvamNMcDFjelNBR1pUNXBoMlNveVhQMlM5VVhJR3R5?=
 =?utf-8?B?MkNuWHd6Unhhbm94MTNyYjRHMUphenR4T3dmZFRNK1pRck83MFh4NVpQUnVG?=
 =?utf-8?B?ZXh4WjNUUzRFNFp2VWdNWjc5aVVaeEw5b0x0RXJkN3hZeEw0dE1WTEE1TDJa?=
 =?utf-8?B?RzJqSkZoVVVVWTRzT1RvWWorM2dRK01jTDJoNklSWThzU2E4QUxSVlRIWGdp?=
 =?utf-8?B?c0RXVEx2QUNnT20vU1NXM2VucTRvOUxGUmRsNjBmTHlNbkkzUjZpOXZGTDhx?=
 =?utf-8?B?Z0pDK1M0ZlBycG1ZWjV6bmdlNEZKL1l5VEJ5T1dSRzgrUndQZGZzNVVMaVhL?=
 =?utf-8?B?dkhwbWdhR0NYWTNPUFJvT29YTm5GYzJObHZMdC82cU8yWFg2VHl3dWxaSnFj?=
 =?utf-8?B?RndzRjczMllPQWVURUJjNFc0eHhVcU8yUFBFSytCaW1FM1pvOUZmYTJuNi9k?=
 =?utf-8?B?cFRRMzRuTTl0b1BmRmN3Z3N5QlN5cXNIelZXWFNFZXVndC9EUkFaYmhEa04w?=
 =?utf-8?B?S0FQbGJLRmNqWlFUS0VIQmpwd011UjBmYWNmSjBFL245V1RmQWhJQjVsK3gw?=
 =?utf-8?B?NXM0Z0JhY0dMQnlVeVRaUW5mMHlLRUZZUlFPN3dZUWw3Z3B2K3RQcGdTZlNI?=
 =?utf-8?B?L1cwZEdpdDZKdGdZOWJaMWtTZnVEQ3p0QVF2RGF6RHpMOCtybFZVMnlHZEdN?=
 =?utf-8?B?S0dnMGtjTzc1eTdXL3EzaWl6bVZockoreVhYYVU4ZzN5SVVwODJCY1FGQ3VY?=
 =?utf-8?B?dEIyZHRaT2p3VjhERGV3b0pqYm9iK0ZGcXM5SnVNZkZ0NWNyblZHVTJ5MDEy?=
 =?utf-8?B?K0pkTndnRXJGajFwWVF3R3hZYnFqNDkwVFg4ZDVXeGhiZjcyQWVBUXVrNnE2?=
 =?utf-8?B?U2ZaUStnMTRQalFVTHQ4L1NyemV4RHovSFZIR2NrdEZzelZmOEJlU1lkSGdU?=
 =?utf-8?B?bkRrS1F5R3VPeXhNV3VIZGhLbm1KdTR2TFRvUlR1cVV3Y3c1QnBlNkxMWWZt?=
 =?utf-8?B?dEpKaHllYWVoN3JTVmpUcGFwM1I3ZXA1Q0pWTnhyS0wydWpMN1VMazBRYTdj?=
 =?utf-8?B?cjRGVElNN2liU1UvTlZ4czdUb1V6Vmt5Y2tkMHVUNmI2M0NLeGROdFhrQkNF?=
 =?utf-8?B?dE85bGpLMkdLRSt4S290RnNYdk95RDlCMzFHU3RFRnpZaVhFS0VGQUxsaUZk?=
 =?utf-8?B?SlVwNkxKNEVHazV2YzhNUGh3WnZFcHlwUnZoWkgyQlJCRG1GQnFxYmRqeldP?=
 =?utf-8?B?YytKUEFsVnlKM3h4cUp0eWRxSVdIcHFTbjQ3SHNYNHViWGc3YXZSK3Z3U09R?=
 =?utf-8?B?a0dxV3FQM0N3TDJOdXpZQmJlY3NyUmFzbFk0Q3ZvanJtTWJZOW0rNUhObXdp?=
 =?utf-8?B?b0hBd1dmZTVCa2ZhdWplYVBoYWY5RHdHZy9KblYvejdZd1pDU2d1YmJONFUz?=
 =?utf-8?B?am1nS1U2eEZjMy9PZmlreGJrV1ZvN2szWDB3U2xMKytMMGo3T2ZCR1pIemll?=
 =?utf-8?B?dWdIV1N3WGFoRHBPQWxKcmxNT3pISUR0cHdMazNkVWU2SUhuTnlYbFo2UVpt?=
 =?utf-8?B?bUkvbzRXVXVqZGhEWFFTVU1PNElkVUVUK0xxdnpOOE5NSHV2U3VCeVlzSmN0?=
 =?utf-8?B?YnMybHF0QlMzRXl2eXZ6THVBdDdIWVhXWjJnWWF3TE5Bd1ZFWGRmUldVNXhJ?=
 =?utf-8?B?VHRHVEwzSnh5cTFVdjgwbkl0VTBsMVZiT3Y2NThHK2NadXVTcVBocmJYMlZn?=
 =?utf-8?B?Z1ZMK2x6dGdReG9NSEZyRm9JdXVobVB4a3YxSzhKVkVYbndjQS9RSXVsR3o1?=
 =?utf-8?B?RWhrZmFNSmM2ZFA3UTB6NmdLRUk0TGtJaFhSWjVEY2JwQXhIbklIVGtFM1Ew?=
 =?utf-8?B?Tk1uOTBnOHJnaXhORXZacWhuOUZyM1FKa0VYd1ZCeVVMNnhjRGpIK3VQOUN1?=
 =?utf-8?B?UklxdTJFdTVOR0RCM0NWOWp2cWNkSkovTjFNQ3E4USsrTHA5aitkLzljRy9G?=
 =?utf-8?B?SFZ2Y3RCZWUxZ3Z3cGxaL3VNODhSY0EvdzZveWR2dTg0c2h6c3dibnhyYkUy?=
 =?utf-8?Q?9zWQD8pe2OYya2b4=3D?=
X-Exchange-RoutingPolicyChecked: Bkh+vsYEAMf7qbhc9y58BCzFbetDCE1gTjjH14FsXk8TmglysmSLod5vJyIMicTiTZM8xIj0VaitTIhuTZWVnSk0rrT0VZF+tHkMkjmej/sJ6eZGOd9pgERWT2AyK9iLPOdkDLzbkLNN/tCN3lQjFoE8VFvun02PlYTNcF7GlmUKuWNgY5eMAEM76NsK9qhKyA5ml4WU0VDsGHSEhUV6IjOzayhr20OVcVGgh/HReKb+lpKBzO5NDf19T0R2n81g9epIVHouXhC4hS+k4uqA9cjdENRrLS5r+ttAeT97tdOGDGlGoSHQnlHcklJXj5xi7YSrcv9EZe/hVCf+6Bkg4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2544ae37-8ff8-4099-b0d2-08dea0ca956b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 23:55:08.5277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJKn9+7mJ54ite5hFKGH6KmzEQqnCFvh5jAU7CnMbxD9HlUORO9eLy0oQAQYgqtXdWkFCw+TRcRSeUvK1DEXv2R0j7acVQ7w5syi5wNntT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
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

Hello,

You may recall the issues I recently reported and submitted a fix for in
the mgag200 DRM driver from [1].

[1]:
https://lore.kernel.org/all/20260202-jk-mgag200-fix-bad-udelay-v2-1-ce1e9665987d@intel.com/

I recently have been running into another issue with the mgag200
graphics driver on a similar platform. I noticed occasional spikes where
Tx timestamps from the ice driver were delayed, very similar behavior to
what was going on with the original bug report. However, this was on a
system running v6.12.76, which contains my MGA G200 usleep fix.

I analyzed the data with perf and have discovered what looks like
another issue where the mgag200 polling routine is causing us issues.

Here's a perf report which captures the cycles samples between the start
of a Tx timestamp request and the point where we report it to the stack:

> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] ret_from_fork_asm
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] ret_from_fork
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] kthread
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] worker_thread
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] process_one_work
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] output_poll_execute
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_client_dev_hotplug
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_fbdev_shmem_client_hotplug
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_fb_helper_hotplug_event
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_client_modeset_probe
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_helper_probe_single_connector_modes
> +   89.87%     0.00%  kworker/65:1-ev  [mgag200]                 [k] mgag200_vga_bmc_connector_helper_get_modes
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_connector_helper_get_modes
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_edid_read
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_edid_read_custom
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] _drm_do_get_edid
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] edid_block_read
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_do_probe_ddc_edid
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] i2c_transfer
> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] __i2c_transfer
> +   89.87%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] bit_xfer
> -   59.65%    59.65%  kworker/65:1-ev  [kernel.kallsyms]         [k] delay_halt_tpause
>      ret_from_fork_asm
>      ret_from_fork
>      kthread
>      worker_thread
>      process_one_work
>      output_poll_execute
>      drm_client_dev_hotplug
>      drm_fbdev_shmem_client_hotplug
>      drm_fb_helper_hotplug_event
>      drm_client_modeset_probe
>      drm_helper_probe_single_connector_modes
>      mgag200_vga_bmc_connector_helper_get_modes
>      drm_connector_helper_get_modes
>      drm_edid_read
>      drm_edid_read_custom
>      _drm_do_get_edid
>      edid_block_read
>      drm_do_probe_ddc_edid
>      i2c_transfer
>      __i2c_transfer
>    + bit_xfer
> +   59.65%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] __udelay
> +   59.65%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] __const_udelay
> +   51.11%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] sclhi
> +   30.22%    30.22%  kworker/65:1-ev  [kernel.kallsyms]         [k] ioread8
> +    7.30%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] delay_halt
> +    7.30%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] acknak
> +    7.29%     0.00%  kworker/65:1-ev  [mgag200]                 [k] mgag200_ddc_algo_bit_data_setscl
> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] secondary_startup_64
> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] start_secondary
> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] cpu_startup_entry
> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] do_idle
> +    3.60%     0.00%  swapper          [kernel.kallsyms]         [k] call_cpuidle
> +    3.60%     0.00%  swapper          [kernel.kallsyms]         [k] cpuidle_enter
> +    3.53%     0.00%  swapper          [kernel.kallsyms]         [k] cpuidle_enter_state
> +    2.57%     0.00%  kworker/65:1-ev  [mgag200]                 [k] mgag200_ddc_algo_bit_data_setsda
> +    2.14%     0.00%  perf             [unknown]                 [k] 0xffffffffffffffff
> +    2.14%     0.00%  perf             perf                      [.] __cmd_record.constprop.0
> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k] entry_SYSCALL_64
> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k] do_syscall_64
> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k] x64_sys_call
> +    2.06%     2.06%  swapper          [kernel.kallsyms]         [k] intel_idle
> +    1.31%     0.42%  perf             [kernel.kallsyms]         [k] do_sys_poll
> +    1.31%     0.00%  perf             perf                      [.] fdarray__poll
> +    1.31%     0.00%  perf             libc.so.6                 [.] __poll
> +    1.31%     0.00%  perf             [kernel.kallsyms]         [k] __x64_sys_poll
> +    1.06%     0.00%  systemd-journal  systemd-journald          [.] 0x00005d6bb7cb3f64
> +    1.06%     0.00%  systemd-journal  libc.so.6                 [.] __libc_start_main
> +    1.06%     0.00%  systemd-journal  libc.so.6                 [.] 0x00007d6ce3a2a1c9
> +    1.06%     0.00%  systemd-journal  systemd-journald          [.] 0x00005d6bb7cb389e
> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.] sd_event_run
> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.] sd_event_dispatch
> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.] 0x00007d6ce409d413
> +    1.00%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] i2c_stop
> +    0.83%     0.00%  perf             [kernel.kallsyms]         [k] perf_poll
> +    0.83%     0.00%  perf             perf                      [.] record__mmap_read_evlist
> 

As you can see, in this case we are spending +60% of the cycles in
delay_halt_tpause which is part of the bit_xfer function for
implementing i2c.

I also occasionally see these messages coming on dmesg:
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 11 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 19 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 35 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 67 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 131 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: work_for_cpu_fn hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: work_for_cpu_fn hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:44 1762811 kernel: workqueue: work_for_cpu_fn hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
> Apr 20 23:14:45 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 259 times, consider switching to WQ_UNBOUND
> Apr 20 23:15:15 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> Apr 20 23:15:25 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
> Apr 20 23:15:46 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
> Apr 20 23:16:27 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 11 times, consider switching to WQ_UNBOUND
> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 11 times, consider switching to WQ_UNBOUND
> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 19 times, consider switching to WQ_UNBOUND
> Apr 20 23:17:49 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 19 times, consider switching to WQ_UNBOUND
> Apr 20 23:20:33 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 35 times, consider switching to WQ_UNBOUND
> Apr 20 23:26:00 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 67 times, consider switching to WQ_UNBOUND
> Apr 20 23:36:56 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 131 times, consider switching to WQ_UNBOUND
> Apr 20 23:58:46 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 259 times, consider switching to WQ_UNBOUND
> Apr 21 00:34:27 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 515 times, consider switching to WQ_UNBOUND
> Apr 21 00:42:28 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 515 times, consider switching to WQ_UNBOUND
> Apr 21 02:09:51 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 1027 times, consider switching to WQ_UNBOUND
> Apr 21 03:27:40 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 1027 times, consider switching to WQ_UNBOUND
> Apr 21 05:04:37 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 2051 times, consider switching to WQ_UNBOUND
> Apr 21 08:09:39 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 35 times, consider switching to WQ_UNBOUND
> Apr 21 08:10:07 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 67 times, consider switching to WQ_UNBOUND
> Apr 21 08:10:10 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 131 times, consider switching to WQ_UNBOUND
> Apr 21 08:10:21 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 259 times, consider switching to WQ_UNBOUND
> Apr 21 09:14:18 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 2051 times, consider switching to WQ_UNBOUND
> Apr 21 10:54:08 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 4099 times, consider switching to WQ_UNBOUND
> Apr 21 21:11:47 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4099 times, consider switching to WQ_UNBOUND
> Apr 21 22:33:11 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 8195 times, consider switching to WQ_UNBOUND
> Apr 22 20:31:04 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 8195 times, consider switching to WQ_UNBOUND
> Apr 22 21:51:17 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 16387 times, consider switching to WQ_UNBOUND

These all appear to be workqueue warnings about functions that are
hogging CPU. If I look carefully, it looks like they are all possibly
related to the same mgag200 driver. At the very least
output_poll_execute is certainly related to the mgag200 stall.

I do noot understand exactly what is causing the driver to get stuck,
its something in the i2c routine for reading the EDID block.

I also see this being printed:

 EDID block 0 (tag 0x00) checksum is invalid, remainder is 125

It appears to print quite consistently every few seconds. I guess this
might be possibly related to a bad EDID block on the mgag200 device?
What does this even mean?

I am not sure how I'd go about verifying this, or root causing what is
going wrong.

It looks like we print the message as part of _drm_do_get_edid(), and
this definitely is called as part of the mgag200 routines:

> -   33.33%    33.33%  kworker/64:1-ev  [kernel.kallsyms]  [k] _drm_do_get_edid
>      ret_from_fork_asm
>      ret_from_fork
>      kthread
>      worker_thread
>      process_one_work
>      output_poll_execute
>      drm_client_dev_hotplug
>      drm_fbdev_shmem_client_hotplug
>      drm_fb_helper_hotplug_event
>      drm_client_modeset_probe
>      drm_helper_probe_single_connector_modes
>      mgag200_vga_bmc_connector_helper_get_modes
>      drm_connector_helper_get_modes
>      drm_edid_read
>      drm_edid_read_custom
>      _drm_do_get_edid

This makes me think that we're reading a bad EDID. I enabled drm.debug
setting to get more data:

> Apr 22 23:47:11 1762811 kernel: EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:connector_bad_edid] [CONNECTOR:36:VGA-1] EDID is invalid:
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  00 ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x720": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x768": 60 68250 1280 1328 1360 1440 768 771 778 790 0x40 0x9 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x768": 60 79500 1280 1344 1472 1664 768 771 778 798 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x800": 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x800": 60 83500 1280 1352 1480 1680 800 803 809 831 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x960": 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x1024": 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1360x768": 60 85500 1360 1424 1536 1792 768 771 777 795 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1366x768": 60 85500 1366 1436 1579 1792 768 771 774 798 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1366x768": 60 72000 1366 1380 1436 1500 768 769 772 800 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1400x1050": 60 101000 1400 1448 1480 1560 1050 1053 1057 1080 0x40 0x9 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1400x1050": 60 121750 1400 1488 1632 1864 1050 1053 1057 1089 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1440x900": 60 88750 1440 1488 1520 1600 900 903 909 926 0x40 0x9 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1440x900": 60 106500 1440 1520 1672 1904 900 903 909 934 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1600x900": 60 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1600x1200": 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1680x1050": 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1680x1050": 60 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1792x1344": 60 204750 1792 1920 2120 2448 1344 1345 1348 1394 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1856x1392": 60 218250 1856 1952 2176 2528 1392 1393 1396 1439 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1200": 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x40 0x9 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1200": 60 193250 1920 2056 2256 2592 1200 1203 1209 1245 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1440": 60 234000 1920 2048 2256 2600 1440 1441 1444 1500 0x40 0x6 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "2048x1152": 60 162000 2048 2074 2154 2250 1152 1153 1156 1200 0x40 0x5 (VIRTUAL_X)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:VGA-1] probed modes:
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "1024x768": 60 65000 1024 1048 1184 1344 768 771 777 806 0x48 0xa
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "800x600": 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "800x600": 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "848x480": 60 33750 848 864 976 1088 480 486 494 517 0x40 0x5
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "640x480": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] enabled? yes
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] Not using firmware configuration
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] looking for cmdline mode
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] looking for preferred mode, tile 0
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] Found mode 1024x768
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] picking CRTCs for 1024x768 config
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CRTC:34:crtc-0] desired mode 1024x768 set (0,0)
> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_dev_hotplug] fbdev: ret=0

Does anyone have any idea whats going wrong here? A google search seems
to imply this is reading the EDID data from the VGA cable...

I'm also curious if its possible to stop polling for so long with udelay
in the i2c logic somehow? I am not very familiar with i2c, but it is
frustrating that this driver is causing yet another stall that is
impacting timing sensitive data. Even if in this case its due to a
faulty cable.. it is frustrating that such result causes the PTP
failures. Would switching to WQ_UNBOUND be helpful here at all?

Thanks,
Jake
