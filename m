Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACCACA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FD410EE7C;
	Tue, 29 Sep 2026 12:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TT5Ky1uG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736D210EE75;
 Tue, 29 Sep 2026 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790683591; x=1822219591;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GgM2ylo1+nhRJNoTjdoiGsfe36MlnbvJZ0tcI5NPX24=;
 b=TT5Ky1uG0JdRK1bUQVKZcrNG358B8iaHnKVqQ1g+wyy/VNaocE4beDcj
 pHwZMZPwi1vy3z10HVF7IZkNkT2gmlEw3mDUrGr0r1PZ9qS+lL+X1Sb5D
 ckkajA6WEW6NrFICfJHzNpDMoivcHzFvOhwJ0YrGLqGUujZKKyaOzKoxm
 xxmoiif9XA0XszemwiuSuL0Zzl5H8eEqotGFjL2J/r+1DgT4CrPbQw+X0
 4arWgZc8U6gnwfwWTGep3R57BzoG5emFItyFHE4rqEXxl2cGNV4qqO7X3
 Sus+eniSRMMTsfPqz/lYiMh/PHUd1WPMB8p2h2kgsgC7Ey63BDlkNNfrr A==;
X-CSE-ConnectionGUID: ivfVl+8ZTku1zqzVPekFog==
X-CSE-MsgGUID: /Ndu1gGsQsOrRnlCFyf5nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90453084"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90453084"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 05:06:30 -0700
X-CSE-ConnectionGUID: vp++8ewbTD2dhVviRpPMbQ==
X-CSE-MsgGUID: 8GrNO3AFS/Kw5Cpgszgp0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273960238"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 05:06:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 05:06:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 05:06:29 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 05:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze36KNG930o3q4SFaHI/d2qUXNvOrOooXfPKSqM0RkHhzVY+0gC1tm9/gwhgRxPFqCH1/jeRFz8oPgVliBywDLPKabXDtxSZKvemquBy33b2o7xccYvRhZWNc3/jc4GZDaEdAZR/Uebi5y49tyC4VDfmg6wSbiNKb2R0vDzuhnYWfkKmWdCXk+Aq171nfVP8GoFBIRpCxaVFTlObktbD+wfZaDoCxD3b6zrjuPUn+RlkKLyyoVGdK2PsHwAVDcDU4zoxJMzsicOvpWsQ16bS0HOVT1nCPwbs/63DfNL+a9VofQxI/41EKlo/FYg2XOOfpebwfqdSBag1J3wf6L/c0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adFRcnQERCEq0P0jHQfBy7VeYBwvb4A7vJyo6NdkaNQ=;
 b=b6Jaodqj5uJKEm8mlU2gM2ewUpyrBRB/04rQ/6/55uIL2ktol+Sd8HF369WukVNC6KM+pkN4Hl74H+/vONHsv83BmV1GFuGtGhXdCLQuvYbHLr8B32bRzE+kREnsWiPKm7bqwZR9vjHuU1V+LaxiPq+KT5V4DzXcSA0WPd7PxcUHg9cyJp7FtlsZWHbZocQAfgsyLj/SVPwrqgmwwOF60ZMP7TuzADEq8QAoUaegLuPvTFmcxTOjRbfXn/tNUv+1hlq6ePQec/rXIRBzWacDOdeemW5uxMil7PklnazTE0APSTuCRo9U1PmnLVVtVHZkwoJWgstBzZJHGwX8GE7blA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 12:06:25 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 12:06:25 +0000
Date: Tue, 29 Sep 2026 12:06:15 +0000
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
Message-ID: <d6n6pdqhf62m33vvawh2b2ayzsratsoae6n6v57kyjbbrvyius@zs3wyc6jszov>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-5-krzysztof.karas@intel.com>
 <apGwueLe3rE7gPLj@zenone.zhora.eu>
 <dnxu2clblnzurzncqpvwztmcmgs6vygq2yd5w6zldcnjhtvtsc@shzi3wcxynvw>
 <aqHOZatceKX5Gljr@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aqHOZatceKX5Gljr@zenone.zhora.eu>
X-ClientProxiedBy: DU2P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::23) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CY8PR11MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f23f7e-367a-43b2-c72e-08df1e2215c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A22tDkmRknnlGXSddeID3X6JH5OVXA4PshpUpG4QTYRI5StwgrNDbdkTuLkJZ/rYaYe+k2NS4TYbSxetHUS72hWGFnfYWwFYCPnRmYO0O8o0H+hB7JqxHyHrHkE7mJj81nmOaeVqLdsY1jtwAmkCXblIn7zpr2hvpR26Mn/pGMfPw9G2Xe6ObeuDBuFsZViMXQg95vZkj8tVllB4NIG7oQtQpURcLQu2tlmpB0sEBRunjNWS0SVAlRkXgNPjP5z/bSep1rIJKS8EF5T5Q4qmeUro9zH4NwdCZxMGXhWW1z7i7fK0Q9ZZuAnQucmpgDbnU+ThoIevDwQKIWFZrH3fPdAOXeBrc+NJXo0gxgugbv7uduHXcIrVfxWaBHak3swPVU7IJdCjN6RFQuSpyBpo/4j9OL5l2sO3iruyj3zakR67XHR4AZoe0Qydq2ETjDFg+TiRW+rb8x20ExvzZCXuR7bsTqviNRp1WLvErGh2uFTWrjJmp4iLfdsZ1cpkDPeEdtOAvenWSeEOtmAaEtHZ271ytMKmFtjkJduWlhlOtnPjgxtZEWAj3FTxe9uDI+JtkTJELEfbWtLDOY2TYGnrc0MwP8lNh9sOxShKaxSzO4jNj8/LtSXYiWfQ+RRStEEQNqnOhS6MQRB6D1YoZ4x0egQFcXolFg0I9Hzw2Z24GwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJQZ083TG5hNWZ6NkVCTTZSVi9wRTA0NUE0b3FMRVRMZ21xSWl5OWh2emdv?=
 =?utf-8?B?Rlc3anhWTGgwUFhvYkhsenp0SkZCTTFSdHhoT1JXSCtiSFRkc0tPdmJHcCtl?=
 =?utf-8?B?dzM4SnVwWXdBb3ZUSHJxVjhiOXFGUFR3ci90TVFmYStLdlZNWDJPSTB5ODBp?=
 =?utf-8?B?OEZQUWdYa3RxbG1zbDMyRUl0OS83ZDk5ZXNGOHdxMkdNb1RWS3dWMktBSVpJ?=
 =?utf-8?B?dXlScE9JWkRWbG4zbENicUNMVitZTW01ZmpieVhWbWl3NmJvZ2tzYzZKdzRy?=
 =?utf-8?B?bVVqL0xLNFhmMkZSQ3RCRmpMT0kvc0JpQ2M2ZElqc2VxNTZ1dXlpQ2VnRWlI?=
 =?utf-8?B?ekE1a1NpVGNNbDgrYUMvVG1pNUo5cmVQL3NiN29KZlNVYVoxVkVscVhzMUI1?=
 =?utf-8?B?T3c2YmRDMTdNUnlPSTRvZkNUMnNiRTBBV04zQ0ZObkJTbDZxWm9WRFpBSUpp?=
 =?utf-8?B?L21GTVV3cHYyaVVqcElWamZqQXZ5R29XQm9RLzRJajZCays5QWxCVFkvUWNU?=
 =?utf-8?B?K1FFQ2pISmZrMVpKajk1REZYaEdCRlpEdzNMdjFwQU5HOXBlWmYwMUN3TTZ4?=
 =?utf-8?B?azcrTno0MFJMSm51M2N0SEhyTE1XdC9GSnJOcHg5Q0dPYlR1Y3MxQXJDNkMr?=
 =?utf-8?B?M1NTUVcwdmE1YkZ6eHBTejVyOHRBTytlTzVreCtBWHZqYncrWkJ1VG1HOWdO?=
 =?utf-8?B?NEVIb0swUm1sajVnWWJwQXB0ZnZZeTdJQUwweWRFbkt2cGowUjZkZXl4ci9R?=
 =?utf-8?B?SDR2VWFKWHo4V2YrUDZnU1lzRG1uUXlNZU5GSUZPMHQvb3BoUXFVbnZMWkRx?=
 =?utf-8?B?NVgvQndBQlRpcUpGZTEvWTAwL28reW1ldG1EVjRSSXdBT1dud0FsNkthVGpz?=
 =?utf-8?B?Q2E1MTkvYjZWTG1xMFd5VHEwc0VlZ1RpUDBleEdxSDl0ZUVIN05zRTdtMUR3?=
 =?utf-8?B?ZDJZbngxajZDZnYxSUFQazZ6b2lQbWF6U09Qbm5JelhMcU5LVEdBajZIaUQ1?=
 =?utf-8?B?d1BUdG1Idmp5UGJZRmJSWG0vb2kwUjFYSTZ5ZmVKVmwvQXJQQ3RHV20xZUtU?=
 =?utf-8?B?VDYyT05vcnRoTDZSNXJQeDBiMXIzSXhSTzMyZVNFV0hQREJWaVFvMzJ6eUd4?=
 =?utf-8?B?NU8zQUtZTU9WaTlIeFN6bkNMWm12eXVrSjdMVEp2N2l0UnlScEZKUXVZYVBt?=
 =?utf-8?B?SFNycVJ3TGN6aGFMZ2FPcWgweVNYcXhJNTNZang3YnhrMm85b1R6M3F6Sktj?=
 =?utf-8?B?SnlVNXZPS1hNSVRmYThLUGtxSEljUEpzQko3d3lITTF5TVNBcXVUS1pVNUJW?=
 =?utf-8?B?RS9DaldlalAxdHEwN3hIbVIzNE9VSG44UWE5Nk5PVTJYTkNTUXNqcVhBaVJM?=
 =?utf-8?B?eUU3THhoL1JNRStkZXIxYnc1TWJrSjF3LzQ3eGExZDhYN05tN0kyU1dwQjdn?=
 =?utf-8?B?VEdQelo1eHJJSThQTlM1Zjk4MTBkYVVOVDdZdWJ4UTN5dTJsOEZ0Q1dUUXZX?=
 =?utf-8?B?all3bmNGSlo1dW9RK1hGTGc2R1hTLzFIWml6Vk45UFplYXQ1N05HOXJnZ1NF?=
 =?utf-8?B?MmUvblBWNUl3NXdCU0RFU2FIdTllMTQ0cnJXMU9oQVM1MlpKY3ZOYnljdGNJ?=
 =?utf-8?B?ZVc2MndxZFBqY1VTamMvLzkyK2FtdUNqbm1ycGhZWEdqZnMxYkpTSVZEb3BL?=
 =?utf-8?B?UzhyaWpUcHNpSFY3aUZvMy91R2xXeUhvME1Zd09KNDkvZnUwdDRyWmcxMDB4?=
 =?utf-8?B?V0Z2TENtRkllMEZic2ZxaFNuYy9KQWZYRU1RMUtNOGRDODhVZ3dFYVhVdnlV?=
 =?utf-8?B?TERVSjUxWGhEL2Y4UUZpczFYbmhBWitwTW1Ob1pKMUVQcTV6eEpqMDJvUmk5?=
 =?utf-8?B?L2YzclNDa0ZhczhvTDh5a0dzOUd5NlpURk9Vb0lvaXNnOTZobFEwTDJmdTB4?=
 =?utf-8?B?dlRkdSsrcFR6RDZGRFJEOTRiMWxsdVI0YXV1eGhKbnhGSXgvYndGUWZLVlhK?=
 =?utf-8?B?VDhxMk9hRGt5RHFiWkdmN2RhejlFQVVYcU1KTkRDTVMzaDFXelBPZDQ5cGdp?=
 =?utf-8?B?Qy9BVkdLMlFSL0M0Nm1MMVYwaGxMaitzRGhkancvdEZWZGNCbWc5VHZwZ1NI?=
 =?utf-8?B?NDhXeE55dTNuRGtSS1hNSUYySGRVaE9xZjhici9vS2dJeWFIbjRlcVVpREZV?=
 =?utf-8?B?RnhaaW05SUlhdTlPeG9Ic1d3WlQ1SkVpYm4ySGFRMmwzc3FlbUZRUnNUa2Er?=
 =?utf-8?B?MmhIV0NUakxxN2NJMm55ajVra1hKNGNoa1ppdjlrSjhvUUZyVEt0Y3FGYjB6?=
 =?utf-8?B?cWg4bXFrSGVjRG9pQTl1NVNtMnlkSE00Q3dKWTdka3hsWTI5SzA5MHRNNDFw?=
 =?utf-8?Q?ZOV7VJpe+nZY5tGY=3D?=
X-Exchange-RoutingPolicyChecked: AuzAUfouOz0AIzzG3my1mR5Xuk1f2rfrFn/ddWA17VnMLfowMQAxOSuEd3jVNvw6a42HTtFWVxxdVXUXh+PirQmWzXlHaojG8i7QzZsTMX+dc8NE6M7sxG02PRbEQy4Xk1xOTY1AovdpjZQlJpx3mUoGAuptiEF30RkViuamiE4KcVdzigZhY7ykUgWPmgX7OT2WQNC96hvrkS/jOH+I10H1WaXhKbbGFtSz3clZ1Q+xeijPkhTQl9Q4Lt6hXxK9OM0jcOe8wD+ZLAYZgbCBufbEJ+UnVcWQ3nOWmkfQ0lYfz0MSSrb3LbcTarukucchobkFEzzBf/b37to8R6jR4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f23f7e-367a-43b2-c72e-08df1e2215c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:06:25.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouZXOR/mtU9sF8uzCGxtYQkJ1jjHSiwwx5lM5+HPgeu3rxJ3xPSeRAHjEvmtDZKBs0QmSji33/1R045YlVD8tZgygImlt8Bq8vPlCO+JW10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
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

On 2026-09-09 at 23:25:55 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> On Thu, Sep 03, 2026 at 12:39:10PM +0000, Krzysztof Karas wrote:
> > Hi Andi,
> > 
> > On 2026-08-28 at 18:18:35 +0200, Andi Shyti wrote:
> > > Hi Krzysztof,
> > > 
> > > On Fri, Aug 28, 2026 at 10:03:35AM +0000, Krzysztof Karas wrote:
> > > > Move away from generic pr prints to device context aware drm
> > > > versions.
> > > > 
> > > > Assisted-by: GitHub-Copilot:claude-opus-5
> > > 
> > > what a ride!
> > > 
> > > While reviewing everything I was thinking whether it would make
> > > sense to add an i915_err() like xe and gt.
> > The idea makes sense, the question is when to introduce this
> > macro. I have the v4 pretty much ready to send, apart from a few
> > minor issues I have to fix, but I am not against modifying it to
> > accomodate i915_* family of prints.
> > If we agreed on this, then we'd have this new macro ready when
> > we'd be replacing pr_* prints in other parts of the driver.
> > 
> > I think it would be worth to keep the series in the oven for a
> > few more days, especially when it is not that critical of a
> > change. What do you think?
> 
> yes, i915_* can come later, of course, it's out of the scope of
> this series.
> 
> Andi

I checked again and again these past two weeks for your reply
and none came into my inbox, only for me to notice today that it
was finally pulled by my mailer client recently. I posted
another version of this series, because I was under the
impression that silence meant I should introduce the i915_*
prints. That version was met with disapproval from Jani as well,
so please just ignore v4.
Sorry for the spam.

-- 
Best Regards,
Krzysztof
