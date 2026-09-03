Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7509AC624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB7510F581;
	Thu,  3 Sep 2026 12:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NjEgMFeR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E415710F581;
 Thu,  3 Sep 2026 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788439175; x=1819975175;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y5pHofwkdkd03omDp5d+AN23xjdV071M8EoTXCJlQXs=;
 b=NjEgMFeRz4J0Jeq10jDrZyPJFvXjJVALkyeH149lQGqtynT5pOToWG0v
 Z+gQj+XKblRYnQaYvWWaYbKTzLJIHeW9aJkX+UZCanoLNsW6d9U95g9XF
 sUmZsjiRR4gLg7AY1XCV8VlZRpINsnwvK1iHzhszqg9SShrNe/gtr0QC2
 EoQqHY63zV5k4LdXxF1noevLJ0Uc8Kzb0eD1FdHd/5f2AkU4DdgD3hMMN
 B+p60LvSUAw+aVkufGKWQA16/97w1/L7ip9hCqGL+5MiXa7H6LYF3X4XL
 4Ug707ofacaUxjjctNlNdtFW2GGuSF+/JgjNOVGgE5SgzAUi/2Cowyv2T Q==;
X-CSE-ConnectionGUID: Cf9pxQKUSa+6ZdZsy34slw==
X-CSE-MsgGUID: 7fVjvT1eSi6f/FHOh47rRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89042408"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="89042408"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 05:39:34 -0700
X-CSE-ConnectionGUID: g7KWG7VkRIKo3ak5g+r0DA==
X-CSE-MsgGUID: tKvlCV3/S5Gu3kKATnNxog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="299576052"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 05:39:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 05:39:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 05:39:23 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 05:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5DVMT6+ZtpA0Of+QZBIqomvCc+jtfglcR3GBAFYZ1NAtJGI34tDozVGRmehtrL90qeq/N9VQbr3aY8y95JM0yzfsA9AowpAV7zw4Zw77f3L/S+jK3d1ZmyVq9f6j6QVyuRsnZlyMqjAiz3zJJdR440pCSpreuLCrYPr8S4BeB5RnkT9CqpV3zQo5zWZAenpoXervIngJK6SrdtV+kDbJJs0omC/YMSglTgsluDkAIYeoGwr04y8ZrgeuW35hCJ2XEVynJzCNQYQGmReZI+33w6WqO8/XNXoE9EFwJe+SyXAAnrtGHz3JKi5OolQP4eU9HPOdavSxaFA49hhKdGO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnCX42/oN1ni+lFf9yRSTkCqO7UdWxScgOdT3H0nl3Y=;
 b=CZJ9FORAIg85VE4aHQmVhUTTfu3pcwyVVsfypD/CMGLoJVuEPQzr7JmPOAeemCS9VP31/37BYu8mwTjMtTmy/1fkvOLLEvkj0K2C09VP4gvhAZeq7wyedH4CrANfLuHZeQddIynPUU3R+OEUMKX1yAfXkBVbzYRy0XQ818rQj5IPM7RTvc76wHDZhn/NzufQOzE4s/evkkLZZ7esCnFQwHVQTIUvGcjL529t/mSxDA4tOl2R7yAgPuU+7mfv7n1bTFM8VzhZwGPwq/lEAYzlIeEvqyajckIqf+Sk/8oUZZfdNPvCvHQhLSPqEiauHLAjbZou1WtmM/zyRF5JRFFH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH8PR11MB9856.namprd11.prod.outlook.com (2603:10b6:510:3c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:39:20 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:39:20 +0000
Date: Thu, 3 Sep 2026 12:39:10 +0000
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
Message-ID: <dnxu2clblnzurzncqpvwztmcmgs6vygq2yd5w6zldcnjhtvtsc@shzi3wcxynvw>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-5-krzysztof.karas@intel.com>
 <apGwueLe3rE7gPLj@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <apGwueLe3rE7gPLj@zenone.zhora.eu>
X-ClientProxiedBy: AS8PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::8) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH8PR11MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9d3088-4406-4753-9a1e-08df09b8606a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aEDpfA6gYc2PCNqk4dmhNGQDOCyCX5G5GvJayC3TWCA41wrIoSIsLRsOJ3pvh8uNcJke2PYUwWvrVq0elrllwUXfOTE9fGpam+cKk1P8EWlGIV8TaPFisI0lvFtxrrHQgv+/QmKMHEIMXS0Po+1zg79Puvt9mk7HbM3hMrUVuPmW377WEMB+6qlpuSobTseanT0l43jbL0GBmgh6LuGdXCb2pmSG/dZ3dLb1OApQ9b5F7PVgUQ5OdhpW/QWlQ+E+dRY7vsxAawdNcmrAnPkGrg0yohaZR6D1Gpn9p8gf9Sk54y9iRmLvQBp/bRTeNoE7h+gHLveT6RSQK+CVKtU4j2V0q/U9hQfRWpat5o8jYntgEianMs0Kb4nv8DQrA0F9qZ00/tPi/5dye1ZPQvwZeO2ZuSP0aVTrrmo2WwWqntNt1QPRUBhacM/WY2gTeBiqD7ZTXqwaoFZcFWJ7ftwelKs0MRaPyAY0oB0ggkglT8m4cPaXWQ/KYPJPBuE3obDcVS/8Wb8MESYEeLQ3N4YSQZte1oSdFfiZXTOd4AQB+VsmJieA4Q652FJ0wL5W8hAGB3jnXAuAK2lm/w84LwL2DfFwfyJNJJM3yuEQ4tLUOVtSLhNZCbH/rkgJOCW7U7nz9d7iHZU+He4NEKqZeGJ+wHg6BGxtNecYgeA6Eu4oQEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdlYWQ1ZTYwbVpERnFuRkhEQm9USGN1cXp6SU0yMzAwa1hzVlNZbGZwSlFo?=
 =?utf-8?B?UUJiaXNiTnk2VDZZdllvMWtRYmE1NW5nOFlmZzd1VnZiNGJPYWdqNytabDBZ?=
 =?utf-8?B?SENwalVqMUZaTm02WFM5SzZBdG42QlAzbkY3RDZpZlFwQS9JWlM0SGJlWUtw?=
 =?utf-8?B?eU82Y0U0ekpwenBXUXRodmNJUldKUm9QczFRVXBiYmRhR05PZ2gzaWRvY1pR?=
 =?utf-8?B?RG5EdEt2ZGMyMmhUMkJaZ1FpOHFSR1ZzNHFsQXZaUTBUUW1vWkpRU1RqN3Zo?=
 =?utf-8?B?NFBITGtGeDU4c1MyZWFSRklPcU4xOWJ0S0ppa0krOHNXV3NIOVB0dW5oK2ha?=
 =?utf-8?B?ZGxoTExEUFhMZ2dvbi9aUzF5NUZvVzFYV2h0WjJ3RksvVXlDQWhGeUViK0Nm?=
 =?utf-8?B?ZFRwN1JSYnFDZWk0NnJoQ000WFRoUWFPT0ppdUI5Y3NlYXdlejNaNXpEQUlL?=
 =?utf-8?B?REZuSUsydm16UUdTeWxsMlUvWXJyVll0dlM5RWlvK3VMSHRGR0NNdDVHRG5Q?=
 =?utf-8?B?SEFhNnNSanUrc21qT0xhQjhFcXQwTDR0OWltRDhpZXpBQVFxV0t1ckQ5ZnVt?=
 =?utf-8?B?TTk1T21BOExMWENySHFiQ0RWSG5jWFBtT1BmczlKcUY0U3B1R2p5dDFVeTNj?=
 =?utf-8?B?d3ZwQXNjWDFFVFVMVEFhbXFZSzJ0eU9PUmtPOWU1cUsvak9Ja0dDMkJSWUta?=
 =?utf-8?B?TlNoU3FSK2xUcGhXUnRjbVE4ZFdxYmlubDNja0txeWdZRkdtVFdkMHdSUjFN?=
 =?utf-8?B?TTFyTW5uRTQrQ2tRYmZCZUFjK0U2K3lZaXd3bUtMVjA3cEdWT2xmenpMTG14?=
 =?utf-8?B?RkdGQmVoY1RXMmZEWmhhSS9lOUgxOXl6ejFLL1RWKzE0VEhzT3FjaitpckNV?=
 =?utf-8?B?TlQwcWJicGsrN20wQ1NkOFZOY0UzTUVLdzRHV2ZoRkl4L2NYUGxKV3FEcmxa?=
 =?utf-8?B?bXRPVWpJSlNVZGZTRzAvK3NJWk44ZHRoanpueHo2QzM0anJIeXhjbjVXQzJl?=
 =?utf-8?B?RHpMUkIxWVNiaDUycHZZanVPS05uRzltQWVqY0NFcVNoQzd5YUVLb2xsbi84?=
 =?utf-8?B?dXBGVkdxODJtTi9rZVVRSisyVnJrUCtGdzZSVkprYlFaYVBXOXZFczBnQms4?=
 =?utf-8?B?VzhJcEVxenRmRmRLcjdycDhxN0FGVExhcjRpK2t5WnhNaFdYcjIrenkvUURR?=
 =?utf-8?B?U1lhM3BMa08ybjBYOGVNSUFadFhZbjNSTWZVOFgwZUhqZkRqMlhTaXc4aWZv?=
 =?utf-8?B?c3JzMzAyWmlwNDRMRDFmbXErQ0VRVGlzQWZMODJJYUN2RWdtUnVTQXdWTk9Q?=
 =?utf-8?B?NTlGVVd0d1pKUDFFM2k1UitFMC9jc3I5SloyQWF6d2dkWWxqWkc2SkJHZXBk?=
 =?utf-8?B?Q205b0lEeWpZVUp2anNiM1hWOGZ5TGM3aXZNTk5yWWJGdDhJR0FMdUpSTGh0?=
 =?utf-8?B?NGVHVjgrZiswM3NPcTdsWWZvc0NSUkxkSVVvNTBONldnSmV6dVgwWnhDNGFm?=
 =?utf-8?B?bUE3Y1dEektVZFpaYnlxME1Da3ptUWo5Qk9QU1lGRGhzNjZNeVhZajFSaGhJ?=
 =?utf-8?B?cGgvWlNiOXNUMU5QOWszK1UrV0pqMGdtVzZaeXYxS1ZSSkxZSlNlVzE2eGVB?=
 =?utf-8?B?YXdZb3RzTy9OdjV4QklselNIMGVLT0pFbkxJUGlCdXJHRWtPcTJzUUQ0WGwy?=
 =?utf-8?B?ampNRHNEYXVHUG4wRkthZTJQZ21GcUhPRVl4V2IyMUl0a2lReDNWeUE4WFhC?=
 =?utf-8?B?RDdxYUJ5NzUzZ3EzSzJSZTVqWlVaTTlHZWFIZmEzQm9sVlFTTDMwb3ErVDhG?=
 =?utf-8?B?akZ0QWpvUnd5azJkYlRaZkh3TWlxc2pZVnFTQ1hZK2xDeXZVcC8vdEJIWDdi?=
 =?utf-8?B?NWJOR05oM1I0bHhILzdIY0tmWnBMcmRaVENDdnhGaHBrQUZ0amdqZno2SU1i?=
 =?utf-8?B?MWlBMk1HMHRNakorK2NmaDRCZmpVakF4NnpVOUJYaUY1RzREQjRBbXQvL2pl?=
 =?utf-8?B?eFRJeEVqbFI3MlpNUzV1RUdsS1VUaTVKOEc3QUduVmNJOXh6VFhyWGQ3SGpt?=
 =?utf-8?B?Y3hXUTBWWDZoeTZEeUpLdG9xdzJqYTZsUG1CK21wbnA3Q1UrcklmVERHdGpI?=
 =?utf-8?B?ZFNBSXN2SXBqOG56ZStLbGIzTTd2eEhveWJMUlRONWNzdXovTmVsYU5FR0M2?=
 =?utf-8?B?R2xNWC80a2pvRFpCQmhzbFZzc3NOU1g0RzRRQ3Q0SlhUUWd5enZrVmtCREtY?=
 =?utf-8?B?OVdIcVZEM0VsdHVhRmhOd1V6M2xzQ2NkTmZDRTBMZWcxREd2SktBU0MxUDd4?=
 =?utf-8?B?amk1VGhhRGoxUjcyclNMbjFqWkZVRG1ZQVplSjg3Q2xhVmpBQnIxbG40VEps?=
 =?utf-8?Q?rbCHUFRTDAkaE1Y0=3D?=
X-Exchange-RoutingPolicyChecked: AFTTx8AwNnGlXz0SqWMKxNavgGH338KPz8F+v6Q0P7U20goFNJ/a9F32+QTgh9V9uh72a/VFJndPIyo6EfAp74g2ZNGuhKKbICw2EB6wKzO0+0K/4GNPl+ih7GB/+1UPos3mTrboaF8zxleqfIcMXgOUngdP/I9LQX6Q/HrZzBMUnuSUWCtd9ETLXWJmuJpUgHRUYIyZB2GFM54b7J30KkZ+dSocXGyRVv2FryxplYB9pUbGz1l2wDunZAIkREruT8SnWBRQIVIUAzgndQl1Q2srInS7GhC2QmFxaMALIK7Q1ztF8DgnuzTYTqjwEAsAguDbknMQbWOp++I92PSXdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9d3088-4406-4753-9a1e-08df09b8606a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:39:20.7946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KLSzj6WDQ95tPlQ4A58Em0QJO31LbQNCSMwdmR16uM4d8Qev/nkwoygoRjtgxu4V6iHVS0lB7FE+Kd2TRQ8o2YmvDuV/aplcojOTDcnqAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9856
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

On 2026-08-28 at 18:18:35 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> On Fri, Aug 28, 2026 at 10:03:35AM +0000, Krzysztof Karas wrote:
> > Move away from generic pr prints to device context aware drm
> > versions.
> > 
> > Assisted-by: GitHub-Copilot:claude-opus-5
> 
> what a ride!
> 
> While reviewing everything I was thinking whether it would make
> sense to add an i915_err() like xe and gt.
The idea makes sense, the question is when to introduce this
macro. I have the v4 pretty much ready to send, apart from a few
minor issues I have to fix, but I am not against modifying it to
accomodate i915_* family of prints.
If we agreed on this, then we'd have this new macro ready when
we'd be replacing pr_* prints in other parts of the driver.

I think it would be worth to keep the series in the oven for a
few more days, especially when it is not that critical of a
change. What do you think?

> 
> ...
> 
> > @@ -540,7 +551,7 @@ static void spinner_kill(struct timer_list *timer)
> >  	struct spinner_timer *st = timer_container_of(st, timer, timer);
> >  
> >  	igt_spinner_end(&st->spin);
> > -	pr_info("%s\n", __func__);
> > +	drm_info(st->spin.hws->base.dev, "killing spinner\n");
> 
> considering that you kept the __func__ reference everywhere else,
> you could have also kept it here. I like that you have added a
> message, though.
> 
> As you are going to resend, anyway, please fix this little nit.
Roger that.

> 
> >  }
> 
> ...
> 
> >  	sort(t, ARRAY_SIZE(t), sizeof(*t), wrap_ktime_compare, NULL);
> > -	pr_info("%s: %zd KiB copy: %lld MiB/s\n",
> > -		ce->engine->name, sz >> 10,
> > -		div64_u64(mul_u32_u32(4 * sz,
> > -				      1000 * 1000 * 1000),
> > -			  t[1] + 2 * t[2] + t[3]) >> 20);
> > +	drm_info(&ce->engine->i915->drm, "%s: %zd KiB copy: %lld MiB/s\n",
> 
> Not a binding comment: rq->i915 would have made it a bit shorter.
> 
> > +		 ce->engine->name, sz >> 10,
> > +		 div64_u64(mul_u32_u32(4 * sz, 1000 * 1000 * 1000),
> > +			   t[1] + 2 * t[2] + t[3]) >> 20);
> >  	return 0;
> >  }
> 
> ...
> 
> > @@ -1211,7 +1231,7 @@ live_gpu_reset_workarounds(void *arg)
> >  	if (!lists)
> >  		return -ENOMEM;
> >  
> > -	pr_info("Verifying after GPU reset...\n");
> > +	drm_info(&gt->i915->drm, "Verifying after GPU reset...\n");
> 
> I'm thinking whether it's better to use gt_info() when we have
> the gt reference.
Sure.

> 
> Andi
> 
> >  
> >  	igt_global_reset_lock(gt);
> >  	wakeref = intel_runtime_pm_get(gt->uncore->rpm);

-- 
Best Regards,
Krzysztof
