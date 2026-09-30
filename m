Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3567DCA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B2B10F1B1;
	Wed, 30 Sep 2026 06:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wn5FHQk3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AB810F1B1;
 Wed, 30 Sep 2026 06:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790748188; x=1822284188;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XpWQ5XWboaK4Z3+2uHtgvxD2Jyc33ztcv6Zoku3KxAA=;
 b=Wn5FHQk3dahrF3SB/HK3e+0W5bZ6rJtu4yztVJyuiuTNTA3EXEuf4jdv
 GJj/8mFVW77Y/O1+3HGKNhaO905f+8GE38wxVYPh0QegSKanvSZxTRuPs
 TLqP8LfaENd424xeQpsT4dsnovxcYJwHdB17zyjHNqCXjX1/Grnz7O8gQ
 VdWDmcv7BcrQuDBPyrnOAuPDWVFuLJfD+pnPT7JCuVOXrPOYALh0CBpGr
 iWmbRbSdfuerxQC4UJY9z9nPYVPjp5bpF4PlKXIcp7llGzer84vX5tOgu
 ZtDLTVrM/cWn2rqpxh7yc4EiazXshWe+H1K3dHtlyaFjwU/Q39hPwnMFm g==;
X-CSE-ConnectionGUID: YOufPdgZQBmhA1kQW4vFEg==
X-CSE-MsgGUID: 2S9m7xcmR8CVGAjVdwLIJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90605580"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90605580"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 23:03:07 -0700
X-CSE-ConnectionGUID: VAtecxY6SRSwJkHXlS081A==
X-CSE-MsgGUID: 4PHHQAv6Q/WYKOoUtyhxtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="274203080"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 23:03:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 23:02:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 23:02:29 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 23:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E49vTl1qwzxpWx6sKKWPs3G0KCMBsrTc3Fm7dwwXIp2zmyR2ykEJcW5CK3T/SX6AWX/rG+NFQzCqe8jTzLhQlErQr0noOYcCDivi+G4rTr7MU9LDlmGwo5+azE2HoocBlyYH/38+BfNypS5u6sF/STkUui97ebIYp0wvffdEUcULh7VFlouMfNovdHx5GNV9McpPmrJs8z3yHr9iUka22vi9kvhtkjfYufn6cghhhZ2DQ+XQD/eq3FN29bXS9Q2V6CRwn2e0YeXx09X62Fz7PddAkULHluOhBue9E5wEADzBzWKZET8Yg8emzfa2JubFVN4FHARnY+mPKwHpcQh92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3vKCi01SLI2Rl827gG2kAKotytEOOIFswmZ6GmMELA=;
 b=AkQkumUIvSwfbGt/DYJC3Lyb+Py0PSHCUQgaSPO2sofbGDGPubcJU3msdWUSxM5vItM/IfGPvKOXTbMJ46QUOzaBS5B5pc+bhF3JKK3Ov5KbIyJjpR7JWWt1q753P6Wrl3HlokDZ0lFSHG5q5Iyzq+pyHQyI919LWubBOwnWEr1IiMkJfAYaBtluhcvtRDwBwYqz2akyNEg1J54swjlufxN3tClJJsWMolSoRVTQBGIDiLUgLd+f0QD32xyrwy/IkHuZ1J3D+GDQW0Q8ELOc8mU5EFofmCj+OVLn/4gsU1UCHncd0m4yXAhhlQ6mZmfREoYLCFoMm+sbDNF8zJVE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:01:29 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 06:01:29 +0000
Date: Wed, 30 Sep 2026 06:01:17 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 4/8] drm/i915/gt/selftests: Use drm_* prints in
 aggregated gt selftests
Message-ID: <vhogge4e7tr5qv2zeiocmmainjykmk6llxrxgwmqfzoioect4c@hr7y4usgrgid>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-5-krzysztof.karas@intel.com>
 <apGwueLe3rE7gPLj@zenone.zhora.eu>
 <dnxu2clblnzurzncqpvwztmcmgs6vygq2yd5w6zldcnjhtvtsc@shzi3wcxynvw>
 <aqHOZatceKX5Gljr@zenone.zhora.eu>
 <d6n6pdqhf62m33vvawh2b2ayzsratsoae6n6v57kyjbbrvyius@zs3wyc6jszov>
 <arws71LttyyKPINu@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <arws71LttyyKPINu@zenone.zhora.eu>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DS0PR11MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c64c32-000b-4888-0922-08df1eb84531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G0yIuao/39G1I0nb/cwfvFQWNsmJedZyuXiHDaBghH2s1KUYg0jXFvXWcvtvj/b/RBYsZMhJYJlLqAgWFRVWSd/gBpv2ev7IMCR3eVUOoEuiHGJQztgmXRkqoVu4eA3ZnqUFlF8EpE+kzwyPTE3z6EnPi/RpQanI76lSWVrq1UrLqEGC1Hl0Oh/2M9v7CBLzQoQEc0GwKkvKzQSvmtN9UuVCaNm06Sf7kCUlrtE5RR3oFUnw8A8mwDexuKUqKzD5m8ejUVQry4luTncrbZzV9LlmcPb8DdTv3IrRGF7vEodrpj0xDbAz+qugZsb7repKYOyRfDh1elgQ5ex4GwGJWaNO6iLeVOm5czpwuH9R/BXy7hwsg+/p1hxv+DPLN0Hm2+yL5GPorgFi15RVgD0vpjfTHMq6YEjO0LvF6bKztxhYzbACp3+eo4DM4CN9nZtzxwIdgqtRlitqvYhvwjFeWEeo2SSijAjeaMJpPBr7dZ/EM7lpDzedbYsKT7GA1KXrqqrZTHW9mnXdcq0fIsMnXdYzb+BiWQoFf1vsfD6iCj2OG/5jt1A5w43K/fnm3Rv+mFs33pJjZx0DdlMGyR9lGHKi+WojYHouk5xGimnFM4L9AeORTL/uiTp6zNyklmeln9AR7XqvLPJiqYzqmQvgVkP7De0uXhxWNrEwzmu/af8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZGV3BReUU4bmF1d3pjZWRwaS9lcW9NRmxTdmh0ZHNUSCtzS2dXb1VzNXhs?=
 =?utf-8?B?cXQ3MCtOc3RoMDRWWjJUN2FpMmZwa2Z2VythYWdRKzg3RzJFTW1nNkRNZGtP?=
 =?utf-8?B?b3UyS042N29BN0ZNazZnRG10M3Y3SlpITFhGcytyZ21Fd0tvUVRBRmVPWXZ0?=
 =?utf-8?B?S3M1TE55Y1FHVDRQUTFES1FEK1pFdzUrR2lYRXdBZTZ2YktDOHVlRURFVjh3?=
 =?utf-8?B?MVdYTWNlY3I0MzdZTGh2TExWeGFsclFrMHIycENqaVphR1A2dEczd1RFUElr?=
 =?utf-8?B?QVV1MGI0YW81Y0ZoR00xOVpxY1VCd3BxOU5zTFQ3NjJjSkxLckhEWkJ3QThQ?=
 =?utf-8?B?K0N2NFZlS25tNUVRQTRuR3dLQS9BOXNVajFiVjBzR2NGRUJFMWJRT0xib1BL?=
 =?utf-8?B?QTlhbC9BeGVsMjFSaVE5QnRUK0NLVFVocjBQOWxxejI5RzFhNkQyN3AyZ1R6?=
 =?utf-8?B?RHNHUjNwcWlibTFSY09sUHIyVE94VnJNR2VsdTVQelRaVVZFbTVaUzFpOGJm?=
 =?utf-8?B?ZTM4TXdocURrRVFSOUFKaWxIY1IvUUlIV0VTVkFhSmVFOHRPYTF5QzkzZk5T?=
 =?utf-8?B?TjhjZUNSbjRTaXg1ZjB2M1BSVFZpZHZ1WjJwRHA4QkVKWUQ3RksvQVFFS0Jk?=
 =?utf-8?B?WTk4RE82QUhGSUo3enhQUDJGVmFQTFE2bVJPZ1UxTWxRY0NiMVlWK1VhN3cz?=
 =?utf-8?B?dWN5b2VDNFNBcDR4NnJxaXRkdmtNbFc1OGt2N1dKc1ZWblZITW4xalI5cys5?=
 =?utf-8?B?TDdacE9TV3E5bksrbnR6OFlvMFBWTmlnSDJ5SXZxUFlUMEtyanJBY2JoWG1I?=
 =?utf-8?B?cGlndVBKcHY1Mlh2Rmg2K1dWQ1BVOHIxaDBOdlNTNER6QkpCWUlwRzNWZS9i?=
 =?utf-8?B?Q1J0ekE2LzU1Y21FckNxUHlaNnhadkV3RjUzRGd1aHNmcUFNbVVpOVpmT0U5?=
 =?utf-8?B?bDlSb0tIKy9BR2kwWm9WelFHbzh4bitJdWpvWDluczMvK0I4T1VLUTZkSFJ0?=
 =?utf-8?B?NnFkTE9SUk1hbmFqb25EQ09LZDNqWVNEUW5PWkNFaEhzNjVmSzRLNHRWZXpP?=
 =?utf-8?B?T3NWSE44MjRrSkNsUFhzbitBcjN1ejBJLzJKUnNzMUkyVTZjdjNIZ2lUZi8x?=
 =?utf-8?B?SWMyeHhBOGZjZmg0T1BPd1lFUUgycDV2d3Z3MklEZ0tKQTluRHN0alRuU2lh?=
 =?utf-8?B?eUNpd0g5U25ZdXZHcVArUGJiNldLY2U1a3EzeE9oVExLak1URVVIeTJQd2JE?=
 =?utf-8?B?M2lsTWZQS1VMbklrMkxnbG1QdGFsYnY4SHFVNmgwNDVPZkg0SzdJMko1cEdQ?=
 =?utf-8?B?WGVnOUNqdHFnUytsSCt4SnNZU0ZzWXVaNnFtUXJodGRFYnNMeWp3NTF1R1VE?=
 =?utf-8?B?MXhxNlRJR0Z4M1FTcGlqUUh6c1JaMUFyOTYzS1BmZ3lXOFVialBYYThOd2l6?=
 =?utf-8?B?WEt1T253MDR2bmszcWp5R1cvZnZMbXdmOEVNbG5KK3BOQkk2U3VlZmx0aGo1?=
 =?utf-8?B?b3lvLzB3NS9ZUzlmQ0lJOTBLSDE5WlZqbHVCNEdHcFN1N0VHOXJsRFNqL1VE?=
 =?utf-8?B?U3EvRklQRWRYa0dYTFNmQ290bGg0dGlyUWFLaklxUzhXTjE1d05lSFdaODVp?=
 =?utf-8?B?Vk8xRi9ra2gxaHJPUTE0SDJXRFBYRTdlcDljbUdkYnNzS0FvOVR3R0lLVkdI?=
 =?utf-8?B?MVFCbm9jOG5ha3NGSnZ3Q2dlRytrME9kOWVocnJMN2VzOXI1eW5JalgxYVUz?=
 =?utf-8?B?SlJUcTFaN0MzYmVkVEttdUFzOXdMSmQvYnBJQjB4MnNPM09KUEUyenFtYkxz?=
 =?utf-8?B?QVFpMkd1dm1LL1d5c3hTRTQ4OVF5VFdILzhUOHZiQkU5Q0VRcmRvTDRjeWtK?=
 =?utf-8?B?bXBTOUQvc3FmbHkwNjYxeVBuSU43bGJCVHBobEdQazFKemVxZFNnYmVCenpq?=
 =?utf-8?B?amF1Zy8zQmFqQUQ1bGtTWmdJRW5SbjQzOEY3Vk9nOWRlWXljZU5nSEZjaGdx?=
 =?utf-8?B?MXVUbWlnY2ViTU5IeDJ1UHA4VmpiOEtsYndxR1ZhbkxhbktINHN2Q2puZzhu?=
 =?utf-8?B?ejlFZlh1ZjAvTFRneEdPeDljeS8zSXBnMHFUK1BUbGhrTzI1R1dPTThqdkZm?=
 =?utf-8?B?S2lnandWZGVGNkozY0w2anM2Skg4L21HcTFaSmhnNTFsK2UweUhxOGc0RGh6?=
 =?utf-8?B?bEFZTjVrNS85NmpraGFzK2VIaG44U0RpTlB3R0hWRjFNblRCYXkvbEdzY1h6?=
 =?utf-8?B?SkZwOGhNelJwUTVSVDhtbnllQzR6Z1pnc2IvUFNmcXBqSFYxTy9GaXUzam1Q?=
 =?utf-8?B?V3hSczRWcnZEWnlRWFZjTEVxaVAwQnIvK0hybllnT1Q1NlpMdFpVZnlKWGZt?=
 =?utf-8?Q?BIf5kR4tpo6LMt98=3D?=
X-Exchange-RoutingPolicyChecked: rRgpDBi26vTfXuPTAf2TSPMtFJOHxgYOr58oSq1NPUwMWbOG0fYU2scgQHYTdflp8m1gvH1ZmrTr1xxGu5DuvZA+mv4yF84Oa9SCB1a6w53DiEMHFAA4nAKe860AjPpxbkITEsm5kvj0I62HIYnfxI2PIpOOwTKOWBKmHX/P4Kirp78nADKab6rKavfGcuYjabS1yXLLMHy6ybDQolSbY6Cy/6rIMbQNb0hAoQJO5bWDksk3C5/QbYqXZNbXy4sL7ncTR3ofJMbZW4dj0cS9Oapn3vjxdoBSzdo9H1u836o+uPfO8u8i/JmRHFGhhqnW677kUs1HMvtcwxCTa6D02A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c64c32-000b-4888-0922-08df1eb84531
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:01:29.4801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex2xgtFAB+oaUgecDNl4EHQfOpRmMTQngn/3krxb4QgwGlzBjzz7R3KjRH0tAWIGQN6nPPhxb9yOBLX+jfRwmmfN7kBfR22LdFdzNOzlOaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
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

Hi Andi,

On 2026-09-29 at 23:27:00 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> On Tue, Sep 29, 2026 at 12:06:15PM +0000, Krzysztof Karas wrote:
> > On 2026-09-09 at 23:25:55 +0200, Andi Shyti wrote:
> > > On Thu, Sep 03, 2026 at 12:39:10PM +0000, Krzysztof Karas wrote:
> > > > On 2026-08-28 at 18:18:35 +0200, Andi Shyti wrote:
> > > > > On Fri, Aug 28, 2026 at 10:03:35AM +0000, Krzysztof Karas wrote:
> > > > > > Move away from generic pr prints to device context aware drm
> > > > > > versions.
> > > > > > 
> > > > > > Assisted-by: GitHub-Copilot:claude-opus-5
> > > > > 
> > > > > what a ride!
> > > > > 
> > > > > While reviewing everything I was thinking whether it would make
> > > > > sense to add an i915_err() like xe and gt.
> > > > The idea makes sense, the question is when to introduce this
> > > > macro. I have the v4 pretty much ready to send, apart from a few
> > > > minor issues I have to fix, but I am not against modifying it to
> > > > accomodate i915_* family of prints.
> > > > If we agreed on this, then we'd have this new macro ready when
> > > > we'd be replacing pr_* prints in other parts of the driver.
> > > > 
> > > > I think it would be worth to keep the series in the oven for a
> > > > few more days, especially when it is not that critical of a
> > > > change. What do you think?
> > > 
> > > yes, i915_* can come later, of course, it's out of the scope of
> > > this series.
> > > 
> > > Andi
> > 
> > I checked again and again these past two weeks for your reply
> > and none came into my inbox, only for me to notice today that it
> > was finally pulled by my mailer client recently. I posted
> > another version of this series, because I was under the
> > impression that silence meant I should introduce the i915_*
> > prints. That version was met with disapproval from Jani as well,
> > so please just ignore v4.
> > Sorry for the spam.
> 
> it's also true that I haven't been very active in reviews lately.
> 
> Are you now preparing a v5?
Truth be told, I prepared two versions simultaneously while
waiting for reviews on v3: one with and one without i915_*
prints, both addressing earlier reviews. I updated the local
version without i915_*, so it is pretty much ready to send, just
need to run final checks.

> 
> Andi

-- 
Best Regards,
Krzysztof
