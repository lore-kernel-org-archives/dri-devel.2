Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C1CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C4610EE24;
	Wed,  1 Jul 2026 07:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZN54rOEb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E116510EE24
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782892100; x=1814428100;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dhp6npYgrnlTzCMwfQ+OtkA6tMKzo8EtZTEBsRfozpY=;
 b=ZN54rOEbizBZCsVfMkr2WqFdy98FlSKMUShi5oKUQsKL2LsoGT7leWWV
 XEDvgt4ED5lG+sKZ93zdruQwU7hRWA/ETFnLXuXI/HncuMphat6/dyFnE
 xcWYKXxNjaAEFCrHeQI1symBzpTeZTRdLJtbW+obv5SLP9idChfEYiC0i
 kjRq3pS0UnB+bewhlsdtP8FxByYUby2ud7C2IeQm90hueSIcxQ1nQGJBa
 pDvl/x7UBoVfofwv3plHuVTg/IStnG646uoSEHZBFqG4Kefk0GKJP81eT
 6rKfZ2WVxp/L2krW0D3KYeqhkNyiENihvzd0nQLEm7t+aejilGa2XgEMT Q==;
X-CSE-ConnectionGUID: icRwA1W1SCeftr3KUESG/Q==
X-CSE-MsgGUID: +eNqNyBBR0+9t4aMhO9ZsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82733731"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="82733731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 00:48:19 -0700
X-CSE-ConnectionGUID: QyfMPaA9RP+NTe8r6xQ9mA==
X-CSE-MsgGUID: PKQnjaioTvOTd/31Zygjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="251441840"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 00:48:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 00:48:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 00:48:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 00:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOajmAbPuoH82qIOq4oB61Ybwltklk49vdVbjEmRhr/YGyCoEp8PTOBNmaUdTPxUtoXxnC0MD4k23F9vqHpFFqPPAIaAcmljolimzeTwh8PF+QkE0UIQTZUaTeJcWBtQsX1/X6TCm+aHqJOHe4K4mmmY2Rq7qIk4fnvuaa/sejCfct3mzX0wfioYJyRoxOdmNxcVV3jF6GJpEhINE7p2ZSQXJ1TOlqfTsYI6Wq0RohcDj0aGg8gjYhz4BVxy4lejvQKv66Lmi+oEkKuWOyjLHqMBMjyIwpLYEIiOuaXsDcdTYYN4/aMRN7TRRyrgQLln71aLPFvGCNpWvWllqvPhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY6qhvJGWvm1fZEHOCjz1aB/UOjYHP7Cl2BiPfOxzQQ=;
 b=k2FDY3aTsGAbkWtk7x5c7J5ZQfy5wWl0PiOIrKY0ZonDeN96JBwHZnCH5vP1Wmj+PAhnglUZSyads9N2QQ3+43xOV0L+880MJq1/E5J+nYgo6CVE7trgT5oMVQkXCpbrYoJUoyLz/2W58GGPGS4PSZ2gzPpQqQ54QC3yBnPt2Y0dfz+2ZOLL1XN01WIVeu0RH6zfz+cFhDYWvMCjOg2Ud5hVXKRqjh4x0CxWo/u3mM425OaJJtbbae5+xGDVXwzCgpJiHQ2DBOjWAJ0VVLpsDaVh++Fg4xivWzyWH1QkkIuPMdixHF9M2CUCOQZFKVjXp6B/GugI6EPAF8ENm65enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH3PPFC15E4803C.namprd11.prod.outlook.com (2603:10b6:518:1::d4a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:48:16 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 07:48:16 +0000
Date: Wed, 1 Jul 2026 07:48:06 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
CC: <dri-devel@lists.freedesktop.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>,
 "Andi Shyti" <andi.shyti@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH 2/2] gpu/tests: Add a dedicated .kunitconfig
Message-ID: <yoa7u7g67jaldlucbj2icdkitdvhuwibjjbmyre6aagu2tg7of@lmb3czi5xhvr>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260618152331.36763-1-krzysztof.niemiec@intel.com>
 <20260618152331.36763-3-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260618152331.36763-3-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DB9PR06CA0021.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::26) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH3PPFC15E4803C:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b875db-0fd6-4afc-ff57-08ded7451c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: zIXm80ZNYo5A4CvrXe7GLWSFqZCHUVHjVGT1R/aUzPXcFzSOz1MZyq99TDV6Dq7kYv6NOX3j7u7Up0kVlkQ9omcB7T8Gl8Bg0kvpSmUDBri/DuZv+tQrD3iCNsb2S+OxtMpOTo/mXkxzLK5zpaz0e3/wHqRE7ulxP7wOFkIotXueYSXDIZK1XSVTssT05FfWoZpliT4yMymWf9Sxtu4FJhJysH17I5QxG2PsDsSE+r6mKV2TRDI5r/MLnpzO6LA+IpSAFkJLcxIxHYkyiQ8j7PmZ4mrl2WEyjGpNgVL6FvNZ5j44YnNZffPSYvCt5LsN4ykHApeUi0puMwC2v85JTkRuEwUSc4PgOVd9TYaBYSV5VM1DgFb2KgeN4hx0m0pVIVp/+uweyQdsIGMtXljEZd9b3lrAHUnguzWAVvSudeCLSbY/+rcmlu97MaBDkpyUTerYnnfiU5EBuzt3MSUvHVNewhDXMGhWBZzAabfNGy6H6ePt5xW6oxc0Q/osocHTAZP6mSnB1QzBpR6Ya1n4y9NX+oSN8EqrEclzEj2br3Pw625xA2f1M4j6Lzkyd5AH5CPqVKE4G3imWwP7HLFrlae5jqL7WjJ7myNHE3Ag1pGqkHTUvFG/igtmEIPIQblqMBkne/lvOh3X/lUAvbFwy+2Gfuyi5S2zHUWP7PwXCvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZPeTFBa1hLQnR0alJrRHhvMDNUc2YxTk9xUktBTmg4K25FU1JrdzkxQWpS?=
 =?utf-8?B?K29pYW1UbkFVY2lMZVAxRG50Ri9GU3hYWFZiL2tITjdOdDlCcGpoSmtPY0xr?=
 =?utf-8?B?dkdyYXZiYTZSMjdzMm51Z251T2tqVGU3MzUwQlR3Z0J3Qms4aTJKUStiZlZC?=
 =?utf-8?B?SEVZN1JwTk8zUmpUMUJSaVlGT0VsbHJiMzdzRGd0WnQ5Y3dOMlo1OHM5RWt1?=
 =?utf-8?B?cEFURnFrZzdva2VtVk5wRnpMN2hMYlhVWFE5ak9YUE9hL0V1OXdzRVZETWI5?=
 =?utf-8?B?ajVhT0piUVlsRER4Nnhsd2VVUmVSNy9ON3ZWbG51SVQ3bVNPbmFVWjRsdmVO?=
 =?utf-8?B?VnhiUnVaak80b2l6VVJOaFNubjlWdmhBYWdMdlZralVscUh6UmoxdXdPUXl5?=
 =?utf-8?B?SWVoT3RLb0F6eG1FVURQbVVSeFFzbUpOMEJSalRCZ2lBWjhsRDZ2UVQxOFp5?=
 =?utf-8?B?QnJKMUlra3ozc1Z4eU16Q3ZiYnpxL3grQnBRb21qTG1EOWxTUXRINnM2aWEz?=
 =?utf-8?B?K1JIemFPM1FqTkVlN0hPYVNWWlJpbzJEMThzN1MrSUU4VkdFS1drcWVkVFpx?=
 =?utf-8?B?OS80czBBUm1RWW5YbUdrbGNwWFZXcmxrS0U2aFFMa3hPa21iZjJJTlQzaXdu?=
 =?utf-8?B?SlhEN25mZ1NjVlIyWnBUUWg5YzBXVm9tYXlSZDM4UmFueTFkL3NpQjV1dStI?=
 =?utf-8?B?a3E1d3F6VlZkbXA4TG5jSDFXaVpPSDNuUGkzMkN0RmxuWDVZOVBLd3puQ1hJ?=
 =?utf-8?B?UHc3MFhUVmloT2wxNGxZem9qZkNKNHBuY0hCZ1cxejNiaDBpOUlZYWQyT2dh?=
 =?utf-8?B?ek1MdkpIRk1CSkhoZXlIdVBwaFUyWjNmYW9TSzNHNlRmMTg5dVEwRFBiK3RS?=
 =?utf-8?B?RGRFUnZRZnQ1Y2dtNElMbDg1M3dJRmJDY2lhMTQ1aEFEWE1LQVFlYU1jOXhz?=
 =?utf-8?B?STQ1L0s3dTB2c29MS0cwaTNFanNEdk9COVVKVENqQnRWT29OQkhWSHhhMFBC?=
 =?utf-8?B?SHZ6eU5sTWhtUzFYRkMvU0piVmJiaU1ndFI2dWZVZTFwYXpQRDg3RHhFdXln?=
 =?utf-8?B?MWtrTEo5YUNKczdLZ2dzclQ0UWdvLzVmZHN6T1JHYVdCNW1yOVg1TEtDT0p4?=
 =?utf-8?B?WUZ0UDdHc1htWklMaXBrak1hWjNLOWNCVW5XV0Q5VmNpWnUycnBtRHRMb2Rm?=
 =?utf-8?B?bHR5bllnaDRaWWNSRU8xZkx1YlE3SVJRck9sc21GV0RWbUJONDJPMTQzaDJs?=
 =?utf-8?B?L3BETkRpd2VWNXMrQmhjRi8rQnRZTjlkWUxFUTVjeDNjKzVtaTQ2Qm9HUmZG?=
 =?utf-8?B?bGRVQ0xWZkIvbzRCMytwNUk4Qm9OSm5ZOSt0L3BCM3g3eHkrRTI4N1hlZWEy?=
 =?utf-8?B?R0hNUHJQM0JiWGNmY3RiWUMrSml2dTZTZTNXTGhEWE02dDEwcFg1blVXRGNu?=
 =?utf-8?B?YmJEM1VOL0YzdWRVY2xGTmU4UG1GcCtCZGtqMXNSbFlOSklpTEFHaEJaS0ZY?=
 =?utf-8?B?eExkUVJLOVpueFNmOFNzTVlaZ0VmMGFFNFBjZjZ0OUhRekU1R3ljYi9Pcitt?=
 =?utf-8?B?WjVUVVUrc1ErMDV1c3k5YVlNM0E5UWhYMTdiektHNVIrVXZRNEZCVHdMZ3Vx?=
 =?utf-8?B?SisvS0xhaGl0bUpGVDlkdC9FaTAyb0NnTGQySE9mbnFnTlg2QU1BVWc4a3dO?=
 =?utf-8?B?QnZFMDlwNlQ3OGM1dUYyZi9SRDR0WHpjd2pHd2IyZStldEcwWXJOQ1BwRTJy?=
 =?utf-8?B?aTlEeEY0K2FRZFR1UmxJYStiOUJPbWlOYjlVanc5aVBZTHFuYlF5bmtGUGtk?=
 =?utf-8?B?aWF0RERzWEZQQVhEak51WkJPOVUvYnRQOHN1djFhZjQwdHZwSkR6ckRDU3lP?=
 =?utf-8?B?bkdkYlJ3bmcxK0N3engwUjhBYm44SXBUcy9FMFErVlhBZ282UUg2YnF2Rjlp?=
 =?utf-8?B?Zmd3dXF1QVNqL2xlc0tkbjkyanUvSFd3aTh0c1Y4NWlCNldsUW0vOTVzMHlI?=
 =?utf-8?B?VTNmYW5XN3NURTRFSXloQTNieDNTMVE4dGZVakNkZk1vandNZ2N1dndJS3Fq?=
 =?utf-8?B?VEdFcmU5cjMxWEJEbGh5L0tENnpKYlRWTGlCWTI4dkNWNVFhQzMwVWQ4WHh0?=
 =?utf-8?B?MjBuVnhUSzM3TVZLcGtxRVBjdlN2MGJJbERMa0JCZGcxTEVxZmxGRG1WcVdK?=
 =?utf-8?B?RmxIRmQyRWN6OWQ2L3JVdDZ5di9kdW95c2Q4aGoxQXM0eitVVTgvYzc5ZGpu?=
 =?utf-8?B?cEp6MjA3TkIrU0tpcFpPbjl0eWlGQnY2WFZyTGZGRE55dFZXNkhLRndaK0o1?=
 =?utf-8?B?KzNIUE5qSmRrTmVORmVxMmd3UHhTTEdvb2p5aTU1eDVWRGtKaFI0U1ZMRllD?=
 =?utf-8?Q?JHQ455fvsSMqzyqE=3D?=
X-Exchange-RoutingPolicyChecked: PxgEcIHIhZLmOCFkLEhtEouz7QEpzqWrsPp6gAoQfQhkSZiaEcYE+0jdqKrCY6mh7MNbdKlkUjU1olXjGUdEDaTe0gMPe+jsrZjIvckaYXP6ca8PHleWqMj+2k3oPAWXiEzNsOitcIgbqm4CPIfj46/9w/Of0yLKJq1kZusCgnH9CZ4wGfwZTWd9ioKU9aR36g+zucJhtTNFOnC6lY2ynXJbvVYtcgomZ2J721bHxvdpyb86qZbvuFreff62KaXaTTmn6qFX9jKcJ1VOG2mkE+ULGNVHRf2KfC75uyATOT38wSs9MD6E61EHQ82IG0PeesjmZIRpUpZ32F1gQ8bsvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b875db-0fd6-4afc-ff57-08ded7451c57
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:48:16.2750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FL2CKDi1NDfU01Uo/NLUgklpWJBzW69oR5LIct5KhegrpWSNtrdd8V1zxpMxXUv+EddHlgUktNP7+Quw/i+zn0LkyXuoTXYzuFb2v17TPdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC15E4803C
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

Hi Krzysztof,

On 2026-06-18 at 17:23:31 +0200, Krzysztof Niemiec wrote:
> Add a dedicated .kunitconfig for running the GPU buddy allocator tests.
> 
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
>  drivers/gpu/tests/.kunitconfig | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 drivers/gpu/tests/.kunitconfig
> 
> diff --git a/drivers/gpu/tests/.kunitconfig b/drivers/gpu/tests/.kunitconfig
> new file mode 100644
> index 000000000000..fd611b3dfe09
> --- /dev/null
> +++ b/drivers/gpu/tests/.kunitconfig
> @@ -0,0 +1,2 @@
> +CONFIG_KUNIT=y
> +CONFIG_GPU_BUDDY_KUNIT_TEST=y
> -- 
> 2.45.2
> 

Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

-- 
Best Regards,
Krzysztof
