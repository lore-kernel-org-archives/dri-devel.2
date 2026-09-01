Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08091C61DE4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377DA10E954;
	Tue,  1 Sep 2026 06:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QFuiZLyP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE8310E954;
 Tue,  1 Sep 2026 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788243600; x=1819779600;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=s8UyRMtv3gM98MlBzUI4/Lo+PqQ2ljvtTKV2oZdPmLY=;
 b=QFuiZLyP91dUUtDuWBBn5i03cgragELIMfsqACGtRsaOy4gLloGs7pJJ
 EA2FmQkfYPBzpEJketzBpmihmNRJofQuIOqZyiY+Zeq/hBEyIH125OzTb
 ABJ4PZMorwRG2aNEm88wD8uj0s0K50PHBHLoZuyv6HHC06hxZ3+Ge+lmD
 zqTon8pO9MwJodEosz9nnTzArcn9j6fRpAQOt6OfCxyg2CzspF1OS7fjR
 jrTESmki7hmlcZvu74eHljuoiqaxKTZ9pvHZ3oT3x6KBbUp40+vjQtPHa
 EgFZJrZAuM5+OLu9mBwBp6VoYLEVl8o9LZkr+6Pdeao8PJTM3X3Xp0wMe Q==;
X-CSE-ConnectionGUID: Xx/3prEpTAyENkOGCTt5Mg==
X-CSE-MsgGUID: z4mrpiK3RcKWlmQEfVgYSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88513271"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="88513271"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 23:20:00 -0700
X-CSE-ConnectionGUID: 1iJGg3lGRqeCNdUj3/B3IQ==
X-CSE-MsgGUID: bifGI19WTkmxdV0q2FeNkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="269045097"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 23:20:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 23:19:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 23:19:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 23:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxJyaMV6Uev4WmRVwJtY7nWmT9Xdu0Vazeo+NzwV5In3FB/K5qn5EjKP72XFb6kC5ahggDoCps4DWW8aQtdq+UltqdWowPupwbZ9wlE2qhc2elrq45leOhCfv6fmWjHb2AH9XuCfX+ta3kpqNdoVEOmYzBBup7lAkEkG6ydWdwot4aY8VPKM/CvGicFEofegBwkz8ci5f1l7/dFXKoTCZ8zGTnZ50+b1BkaxWGxaHBayb1U9OjsvASYLCLs742LB/htZk5AiwD3DeRRYlBcYilLkS9ioUgefynn+PCbXPBXRLpiHEycWm4qPQpiLI5RO/bnLzE2OFoCJM8rrNV0OPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxP/LGzUDwkVezcZ4nj2qz4FJG7SCzKtGAQUjXOFjfY=;
 b=UF6qxviv+VvTiAUlEifXsMFKx6Y4B7Vw9EQ8Q2dcyqZ088p5cmslUNsFLjxVe4uY7BsqTrhUWjGgWzXUEplK2mWQBVCJepER9HXW0III88RE+ckMsaBBJ8yV9JHfPeD9Mbu8OSyscm3MHpxySOb862iUrs3i9ehXsCgMUZi79B2aEH+C1jjMTwuHktFRVns3YkwUhuA5zlfaudnARdl2pRivk7tcCNk/UPr+qzv5g+BfV0emc4DEVl8psM/f/nHRsaGeZXr/dCYI4GEloFwsWSttZh/KETQ6kbhJMEDLnATt+U2IUPAYyWWTsR+o7N60wjhuwjcYGthpRZihk1awAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DSSPR11MB9641.namprd11.prod.outlook.com (2603:10b6:8:377::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:19:52 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:19:52 +0000
Date: Tue, 1 Sep 2026 06:19:39 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti
 <andi.shyti@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, <dri-devel@lists.freedesktop.org>,
 <igt-dev@lists.freedesktop.org>
Subject: Re: [PATCH] drm/i915/selftests: Wait longer for request to start
Message-ID: <2fn7euzh5tuunytl5lgkefiitsjrprvsiqyphb77p5q4qz3enw@yj63s65lvdgw>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DSSPR11MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a60df5-a171-46ec-252d-08df07f108b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7u4IDKShxEXwvYsC1vADmoQ2i5hvw2aE7wcVrfJlYNuZf2Mni9HeB8/iseQeErNGKmOCXjaqyY1+uUxrz6zYwPQkxfLOUD0jNR1PwV3AGlyXUmUbMaKpSZdAGfDxBM3nU/WlQ8JU9+L7EmsREOUy7qoko5jU8/ncAYausRoOw5+ZVPw3IAnk9HCPGS6toYTIBIlnqsgfBoL5CHsrMg6mpBa0K9CrxX3WdUPnIKmoOymTRZ/uGVWZ04f/6Ae++i4y5O0ZqBkqJq4IGijCOiwdp8rrvg7xgs6fGYVGo5q7Us7KMdi1qMEcuJRDIg31rlhB0BKFFalN5PXCFTIi2LuXDH47J/bk0dR0eUcBq03onnITLo2YxCVB/m8IXvztUYkiyCYk9xb/i3kFp/1QAiJCFw8p3zgnvPmdD7QbSZt05CnULPASyW85jKAF3mmCm7d/Tras19RpFPZt1PzRkT9Oy/rg3xZjV6QgN+D2OuR9k6d/5bQRmB2wiubq2JzXuSP22nyHt7V4kusGUh/z1kwitlXgZmc2x1TTgQ/eu3Cap7kVhoh4kyS4TwsGiPUTbmSVgmhJHUK5SRFxZgYnSsKXbHS01TSdFooQ7VQfUCR+y7u/vJSZrBt6o1WU2zloAn4w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXA0Q0Z4TXNCQ1NwT3haNmdxUmNlY2VPNHcrL3FMZzRBMGoyR1NoQkNYK2RP?=
 =?utf-8?B?cUE4SDNDTTVGWVNyNW5zMnNZZUM0OGlmOVBzejNmNHVsZkhyNndDdHVEYUpj?=
 =?utf-8?B?RkkyNlQ0UVNQTnJOSTQwalhNZTkxZ3pydDV4UnZZY25vcFBFUFNKOWJqdTVk?=
 =?utf-8?B?aWNpR3B4UUxHdzdmYWxNekl5SzZPSVlKZzdoa3B5WHgyNksyNWF5Qm5jTzl3?=
 =?utf-8?B?c0d0UzNhYXhtanJOQmNLaUNFQTdQVWZLeXFlUExEZTArVEZsSHBLRDZVUHBH?=
 =?utf-8?B?MjNFd1VVRWNEY1ZpbkRwYkRqTzN0eHNDZHFIZ0JZekEreWs0Qmtqa01uemtT?=
 =?utf-8?B?clRWY3l1clNnQUxJVm8zdDN1WWx3MUVlSHN5YUZkb3Q3bmxqUG05TkZ4a2pn?=
 =?utf-8?B?QncvS1Z5NStJcTFQNkdBbUppUGMzeEsvbzIzQ3hUbjZkQ1JxbWRaYU8yRVht?=
 =?utf-8?B?U2VSM0hQR1I5WjJzNFJ2T3FKTWMzdHgySDVVQWozaGpwSlpnakg0TTFQMEEv?=
 =?utf-8?B?UE1sTUZmODJpa2MwMG9MaTV1UUxCY0h2Z0tEMU04eklVVzFLR0dKczhBblhQ?=
 =?utf-8?B?OGNiWUMxM3YzczNPb1dKYUkyT2hmNE9tMlNxK1JRUUhVUXBWWHd1bTU4UVN0?=
 =?utf-8?B?Q3RRb05Lc3llODRJNEJmTDBiTHhtaGNFb0dhL1VzS3dqZWFEUkN3NFhCVVJJ?=
 =?utf-8?B?UmJ6dDlMYWErbXNCSE5nRTAyYmkwbWxLNGMxS3hQRmZmYTdpclFpRUo1eThW?=
 =?utf-8?B?QTBMTkZma0dhcTF5S0ZydTJyRmxrdnBoYUwyaGE2OVh3QWpQdjRPc0w1Y25k?=
 =?utf-8?B?U2IrcVJ2WjdNQUV2UWNUcVUydGIrU3JZYkVMM3EvL01CaE02V09WZmJWcDZQ?=
 =?utf-8?B?eXFwbFd1MFhLZEx0NWZpZlFiNjQrYk1IelNleVZuNHpaQ2dxUmErQ3hFT3BZ?=
 =?utf-8?B?dlBVbjNRUDI5Z3k4VzI4RS8yUlF0cENlZ2QrZnJEamhrWmppdG1ab3dOZnNn?=
 =?utf-8?B?L0pTSUV6OXVDTHR6V05Yd0ZOc0pTS21qbEpMYlNic1I1eDRLWVFLbmxjQzM0?=
 =?utf-8?B?MGhQZ2hZdmhBMk9ad3ViUkg5MVcwaEhiY0l6aVRxM3dNa3RycHRST1VpTENY?=
 =?utf-8?B?dFg1NjBxeWVrTkVIV2NLbHJFbXNZMVhYVlZGS0o5bG15NnJVcENnbXFQU0dH?=
 =?utf-8?B?STlpcld0azI2TkV1STM0MmFXa2xNMFFyTUdMakVXL0c0NkdFRUxtSjhWcW5W?=
 =?utf-8?B?dHhZZFJuemM1MXRCRFd6WldRRUhXUlN5UThMazMxSURKSW9xa1B1SktrTGhS?=
 =?utf-8?B?Kyt5NVpqNCtHR0hMY3hmUVprQkh5K0JyWnpIU1NEM0JvZzVzM3pCWmtEcHRy?=
 =?utf-8?B?U1lxWWNDaXRSeXpZam1aT2lpZFJvM2JlVzRzSWdIZW5PV1FMbUw0TGFuaE5S?=
 =?utf-8?B?cy9wcjNPUVNJN1I4TS9JS1A5cEVFU3NVdjBKeWRUQVlMNFhhK093RDdESlp6?=
 =?utf-8?B?Q2lRQ1NSRTdaRjlyR0RaUWJRM2dPYWlYWmdIUFVxM0VlMFo4dE5GOHBENmR4?=
 =?utf-8?B?bmN6N1BrSkNuL0l0QURFdkZsNGRERE44SVprdCs3VDlCKzRDV1dnbnpuKzFp?=
 =?utf-8?B?aW1aQUZqS1lidjdIUndkWStpbW1yaEQ3VmhhRHV0ZDNCVTAwTjJnVVVSZVFs?=
 =?utf-8?B?a1lPdkJ5cnA2eGxjd3V1VGlld3hUSDBwWEkzVGFDUEcwa2U3ZmhIM1grZkE1?=
 =?utf-8?B?ckQxMFRTdXNBMzYxaml3WUcyaVlJcjdXeFhpTjJWa3FYQ2J6SkNWVEVLWUJl?=
 =?utf-8?B?YlFLdElPVFFWdXRQNEN3dmM5OVFoOFl5bjZqVXZSTXpSZTU3cXlpMGVzRG9j?=
 =?utf-8?B?RXVuOGo5bEpjMDZZOXNpSFpUczdSY2tKbjhrcXVaYmphVUpKdHQwVW1vWWRi?=
 =?utf-8?B?Vy9JSjhMRWxVcjNzMThXS0tpcUF6T3hNSkc2azB0eUNFSkxwT3g1cEFla1F6?=
 =?utf-8?B?ZDJpSDR0VndER2VkTEw2SzhvdW84RzhnWktEUUxFVEhNNkprbnhEL24zSFJj?=
 =?utf-8?B?Uk9ZU2xaWXdIVjZVMHNNZ2FlbHlkN0tiZmQwaStHMmQzSkluaDhNNzBGeGhW?=
 =?utf-8?B?UG9pbSt4VCtyYTR2eVVycmhMbGh2K3paNzc1Mm0waitKVWRGMVRxbitNZEtO?=
 =?utf-8?B?L1RiUnMyQXNvdFd0TllWdXdxY1kxRndQdkRYem94NEZaTzQvY1RPL3NTM2FI?=
 =?utf-8?B?WlE1NWt6enVMYVMrODFVdzc5Y04xS1pmYzR1OWZNTzhrNU96bWxOekZDWnY3?=
 =?utf-8?B?Y3J4b1N3VmtQT2tzRm4zTzgwZWZTQ0JaT2IrVUZBbVRpeWdWM0haVVdLcmVq?=
 =?utf-8?Q?gkrfAsjjnJxzLSKc=3D?=
X-Exchange-RoutingPolicyChecked: rEDIEOAc1wEJxQQo2kkjzY6DUQbRGy5R1wOBfQdWS2MaK/VuC+VRTsN2dx5+iLIvbX4um9N3u3sVKuBdxup9jlOqRWW/JAFKugU9k9IBsBbqi6k7nQum3JURfRF81+fPStr2wUCtqbdDKwgso/qwYoJC0clf10bhHHajhAsPZF7GbOoIRlScLVvVmn270zkkxHItFTS9FmrDRO3i3ytSfVcpVeVpMDMA0MGpu21d43+C9mXnXaoBrPgTIDxvzi5rQRMzPLxkV52jy1OM6LKLA98GW1kbf/QfMO/+16tJ14n83QkPAfj1xX03iGxVCXRsO9OH3U4fShMjwYO7ZV+wOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a60df5-a171-46ec-252d-08df07f108b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 06:19:52.5672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6MX+9Lf1TMFjI6j43WQtnFQxlVIF3oHCYxEIno9rjGwlaFM9eHtCj7iivzn17Rb6VvS3odTTJBdzYWQ0dy9uaZpJCWzLFlCv2ydVqMAZ9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9641
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

Hi Janusz,

On 2026-08-31 at 11:33:08 +0200, Janusz Krzysztofik wrote:
> CI extreamly sporadically (five times over last six mohths) reported
extreamly -> extremely, mohths -> months

> failures of igt@i915_selftest@live@hangcheck on ARL-S machines.  The
> selftest was timing out while waiting up to 1 second for a request
> supposed to trigger a GPU hang to be started.  It occurred possible to
> reproduce this issue manually by running the selftest in a loop for a
> few hours.
> 
> Among results from 5 occurrences reported by CI so far, and two manual
> reproductions, two of them contained messages that suggested a
> posssibility of the awaited request to actually start soon after
> timeout.  With the timeout extended from 1 to 2 seconds, it occurred no
> longer possible to trigger the failure, even when running the test in a
> loop for 10, then for 12 hours, on the same machine where it was failing
> before in 2-3 hours.
> 
> Assume the conditions that prevented the hang requests to start within 1
> second were always transient, and 2 seconds is sufficient for those
> requests to start effectively on machines in the CI environment.  Fix
> the issue by using that value as the timeout.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16624
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gt/selftest_hangcheck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> index 00dfc37221fac..53f3ce5c33a47 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> @@ -278,7 +278,7 @@ static bool wait_until_running(struct hang *h, struct i915_request *rq)
>  			     10) &&
>  		 wait_for(i915_seqno_passed(hws_seqno(h, rq),
>  					    rq->fence.seqno),
> -			  1000));
> +			  2000));
>  }
>  
>  static int igt_hang_sanitycheck(void *arg)
> -- 
> 2.54.0
> 

Patch is trivial, so:
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

though, it would probably need a rebase, since it does not apply
cleanly for CI build process.

-- 
Best Regards,
Krzysztof
