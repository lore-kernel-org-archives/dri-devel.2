Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3FCCA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B5910E9CC;
	Tue, 29 Sep 2026 12:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Sr+MojpT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3319010E189;
 Tue, 29 Sep 2026 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790683262; x=1822219262;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=D1v8ibjJ+dr+TC8DAHPQpVWIYR8wyH5Xy0ZyFq0b3HE=;
 b=Sr+MojpT4AG2+fdt8fyYMvlqZJyXNt48EldfJyOT6FZGHW/2vmsssigc
 fpt39urO6yv9IJ6awFtydac0fwu+NZgLtnJ0uIjH/kKt3JDrFfeDcxhHL
 FCTK5UbJIzWtyVmqFGOk4cA91aBvFRQ1M/ao9jZceP2TDHHfKli/7Q2C0
 kfTdgKVMtLR3ckg1AYwe72mxwhKenDDg47Bw7VYHHjfoatls2Pvvzz1QH
 NyYv2JLtNiRIPNvfvaTUbSVAtaCdhnFJz+YQCnlqUWVKIm9Q3Dr8KtOWx
 9ltFOw7QCpOCAddV7IV/OzYDmWasDz0ApMfQGxPq37Zf7NpGCiyiXuPw8 w==;
X-CSE-ConnectionGUID: 1uiBSDFJRCCCA6A5jwX+OQ==
X-CSE-MsgGUID: 8BMGhAvtQfSp7h302pTU5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="108887968"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="108887968"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 05:01:01 -0700
X-CSE-ConnectionGUID: +v+/J1LkTliB34BTS0LpSA==
X-CSE-MsgGUID: phcM9J9GRCC4UTegXWhPqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274442809"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 05:01:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 05:01:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 05:01:00 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 05:00:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKZR5XQdgiHKW5fcUYt6+Q/SjynNZOuTZhlbaj1BcDmiK/NLBUI5D4PRO4FD1uDROB+nP9LsMBCUdQcmwr6PdGPTEOqlvl+mnQQ46dUaSTrTEk8M6mLl9+sOkM5X6LUR0JulNSelUSMVolffcZi86odOhV3Cff97cmg2ILXH2ZNzryJMiV7ArIi7Ou9z3CMunr6VAfGpZlY6OxWzoDf0myvbXdyy7n4gYp9Z4EqLegwLlZdvLohBCiPU+e11g1XPnw6T8nZjqHH55Ji3fa2G5hrXI1OscOb1J2Jr1cokQk0GX97WlOsHc6XdynD+DOjpepmiYN31vz5treCauAdY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB936eKAevsEv6btmcIT7U7r1YnYeTxhjWaVwhWnq2s=;
 b=DPd3qTJ5LmNJbZyadJNrP2p/ASCOcU74kmrVQbYwF96Av//xn2FNT1OrEOiGMPDmWb1g0SsEQ9y9rJAmgXfpIaQpR7NWGwAUhHbd0kM4C+Wfw8mLS4o43WzEU6u5NsFFKnUtqwN2oe26IbjR1q2BHfti/nU+z0G9einFci4PPl5YYRGtwp9yqnC57sYT45wjJakihNjDfPBv6VWrmhr6ZVxsB1qpf0dtJt1qiYQt2213Z095hNb7fvk2Tbr50y8JZVzLugRMdRWJgB6eISjjRVBAoU9nzd6Zm0hF7O7R74hj+jNLr0FDS2s+46kakZ5t+YhIR49w8xngHxzX65MBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:00:54 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 12:00:52 +0000
Date: Tue, 29 Sep 2026 12:00:42 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Andi Shyti" <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v4 2/7] drm/i915: Add i915_* printer macros
Message-ID: <jvuyuzawwrcu6t3s2gqekqphkiuwboixfcvx6kob7oelhapqsb@7y7c5exlvr2a>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260924120147.1305127-1-krzysztof.karas@intel.com>
 <20260924120147.1305127-3-krzysztof.karas@intel.com>
 <344886121db0900dd7c22b3807ee75632f230f3d@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <344886121db0900dd7c22b3807ee75632f230f3d@intel.com>
X-ClientProxiedBy: DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da85cf3-9aca-432c-a380-08df1e214f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KD0UOBzxzBY7S4KPRteM40AlHcZk2gKT0bDrYFx2fPr3ootndow5kGg2Ku4mOnGa6Lm+Tf0/PERiLXkMFh6TCvM4riIENhlg3ddTG2EJuh8C/NB0jh52xIMprKQPXVZOWMBF4+kwbgk8tnGEShrT6u0Yq1pHdsne1YA9bTD2uhiuX53Z3z442Yd4RLY/gVGhocjhooT5Ik5JhDHSqMCvpYlS8PQOGp2hZumYpGkEtcO81bthHure289tR5uR6WKXnxz0u8ToedDMFma2Ul2CmUOMMua63vw0KgL4luOIybTkecyC6uBL6sXb/zQR+qLOlVSDr7pLXv8iAVUnr4GN+wD5m7JQkCMRl0CX4ZZp/TctioH4frycnra2FamD2euHU8yOm9zWWTiOuzqAU/tr6Nwc9KIln+8p3vRvvOmlUZNqlmO3e0/iWGdGJL4vzo+X9f411slGfhEbU6m/23jDH0PlrMnyTjLdb/lc6rR++dhd5x5ZNg0CWPNHHe298aoQPnc5J3b5Yq6N9cmljgorRNbdLi66542mJoD3ckIt1qa4I+gEQ3d+zI4YL4SrUJlGS93K4l64svI4VXfN88eEyulSa9OpCJy6zUzOwIovSeye44gzE1fbLDbWrPPM1GYCabupw8V+mHAcMDx012J46Sk4RbiJN+T+yMNYsAwtMkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVoSFlpL2dLMzFTMDVkTmlqeitEdEhXdWk5bW9RTG1BNGxGVUNwMUhEV3pK?=
 =?utf-8?B?RnNBUUt2VC9WTmtaSW5teHpYNDN1eUErejlla2QyMjJ4eFA5YXVCcmthMHpw?=
 =?utf-8?B?b0FjbFVyTVYvZXk2WnBzZzRKMHpjTzBTRHowdU1KZU5vMEIxeEx5WFpSeWN4?=
 =?utf-8?B?MjNUNmpwa0FvemlXL3o0R2xJSk1JTzM2c0JjbytWZHlwcU40VTFzUkE4akkx?=
 =?utf-8?B?NytUQ1ZLK2tmaVVmcE1jVG5LUlBmVTRFSDI1UjdlcC95d1E3VysrWDdKY3Q1?=
 =?utf-8?B?Rzc5aFRMeEM1dnp1bkVuNndCUWpMSDFPdmFwakY0bUt1c1QyNHhVZ3cxY1JS?=
 =?utf-8?B?SXNLRDc1YTU5bVk0VUVzSTE3YmZZQ09VbHhEVjdGOEQva1ljMFplOG9kMVk1?=
 =?utf-8?B?TS81WlZoTkNDdWczRHhsQkFpZm1OWTlDbkdPZ1hsbUNUbnhKcjF4cHZ1ZGhx?=
 =?utf-8?B?UEtJRzdkdTBXUmptc3ZYR2xQYXA0SERya1dkSy9hejhYdVhscW5XbEZoWjZn?=
 =?utf-8?B?TUYxNkp3d0xSbEpidmlNamFqajEveTNpTFVnQnpwQmxmNm0yYWFxT2dPa3gy?=
 =?utf-8?B?VWxlaDR0UzR3NzBnRjhxSUExSmdJa3FoU2tQSDNLbUdPVnZha25jeGhGcWJr?=
 =?utf-8?B?Y3Y4MTZzYUZMaVFkQkZWMU1DZ0o3UThvekdJZytVdm0veW5nczNUTnhvdERu?=
 =?utf-8?B?aXdSUGluT1ZNSURPLy9iNTZZZ1FUbFpka1R3am5xQzhUNzY2RFIzd1RicU4w?=
 =?utf-8?B?NDZPRDNUNFc5WWdlRGc1VDlBZndJaG9ycS9zUWNBOFgxanNvWU5QbmhCbXY3?=
 =?utf-8?B?YnBQSmtQUm9LckE5MzYrMXFsUW1ibmdpT2R3SFVIaUJDQ3ZrdTFLQzVPK0ZE?=
 =?utf-8?B?SVlMRXcyS1pOU0c3MlN2NnNrc0ZyWEFRSWJDZ3A5NEQ5TWZDUjBjM2dCTExT?=
 =?utf-8?B?RG5ZN1pOS2YxZHJHZEpjQ0tuK1J5YnNRN3dJSjlIZjNsOWFlREdjcTNOTlpF?=
 =?utf-8?B?UitWb00xS2hJeVBTUWIwa2F5ZFVSM1hKTUJsRlJzcGJWcFc0VUJnQ3VPL1Q3?=
 =?utf-8?B?UDJ4QzRFY2FTZ2NiZjV6aFE2YjdyUCs3RHh5WG9JRHdFUVN4OGVFekpjZlZ2?=
 =?utf-8?B?Q09EUkJKd0ROUmt6VDhjempXc2JYVTY1b2JkV25mcmZ0M3ZrckdSTno0bzM2?=
 =?utf-8?B?R0Q2MStxRUgyV0NxaDV6L0FyeFBueXRXZC9Na0JGUHY1K2ViRmduUllIVzZw?=
 =?utf-8?B?STVWVERJUHFiRXU0UERVVFo1WW1MVjBZVnJNV2RXQkpzNWJJcjFLMGltNzNR?=
 =?utf-8?B?Q296UndXUkNjcCswY1dNUDlOSmFQbHZHRGQ0L3N3aDQxeFRBZ2wxVGJKNlVm?=
 =?utf-8?B?bG4zL1VUcGZhRmN6QXdxMHY3cW5KbjZudGIvMm5VMzZXWUxlbytDa1pDdlFQ?=
 =?utf-8?B?aElYekIrdGU5Q1lvMEcrMXZUTzczTTZYdG42TTZsNk9TZmJVZStQQUZZMFF4?=
 =?utf-8?B?cUtnbkFySDBaakZuWGV1T2RxY1V0TzFacDJLaFd5R2J1dUR6Skxlb0EyOXJ3?=
 =?utf-8?B?Nk5lU1BxRHlIcWlBUzhTYWJKb1BGb1dOZ2g3L1gweWxDc3ZqaStEQ2ZEQ1dV?=
 =?utf-8?B?RndqaXJrWEtkZVRYYzdoY0UxNzN4L3IxWk9qdGZkRmtHMjRwUlB6Y09taXN2?=
 =?utf-8?B?bFVEL2pWYmpCWXlGS1JWSVIrM1NQR3I0UEpWbTdMUlR5Ukp0dThJdWlpZ0Y3?=
 =?utf-8?B?cWNVRW1MUlluQnVCVXNZVXlhWUN1R0xGTngvMG5JK3MrSXp3dWRrQSt4WEdG?=
 =?utf-8?B?VmtVank4dUNkSm5QNVJRQ29LR3h4VFVtN0hvUHZKOVgyUTQ2eTl3aVZZOFQv?=
 =?utf-8?B?K1RTTzAxMkQxbTZRMnV5WlA2QnliUE9sZmFzUlpEVkkwR3lCYTgvM0I4SnlL?=
 =?utf-8?B?RXlnTm9DeXlsNjJ6RUhjNzNudG5VcEFERHVIaStzSFIza3YxNnlKYm1zbjBi?=
 =?utf-8?B?Qjh5VXFtU2ZYZFV1ZXMxSkJwdUJvVmpuU0RHdzFxTER5U09SN2VLVzR5MThL?=
 =?utf-8?B?UG4rbFdpQnFYVm1VZ0ZTTktwMmRWQ09zQndPQkMrTkxrS3pjd1BxbmxxUXNC?=
 =?utf-8?B?N0hzemg2cGsrcTQ4cFhpaGdBeXBkT3RUUUtGWk5yM21aYllQa1dleGpwZkkw?=
 =?utf-8?B?VHUyYkhORXBSYXBqWGJJTDk1NUtYL0pSUjU3MjFVdHdadkt4Q3FSNEtYRlRa?=
 =?utf-8?B?Wk1zblM0OEhJekdNYWVSZ2NDOGZVdHBKYWM2Q3hQTjFnVDJmNzU2cEpKd0dy?=
 =?utf-8?B?YUJoTlF6eUZMaTl3Qi91ai9DeEliOGM0Z1ZSWEM3ZjhjekUxODNHR0Q3NXNJ?=
 =?utf-8?Q?IpaJIuKo0ozzC2HE=3D?=
X-Exchange-RoutingPolicyChecked: Djo+T64ZSY7URwmeWwrdqdc+XuNZOYqFt2SS24ZK00KZNpu2TadRL/B+ULOFpQREeCZS1IBYMU2cKt5IRUJvXBcktJlZFioSEYwRdnvePv1YfewQwvlSRc74nNAHszz9BUUusU7eAOdLmGpOXAb8Zb7+OhWebgHRncHGDactI3jDAUDZDrL9kkxHPhCy0sR+vT32wMb9QizvxCUbCAs0FWEiyVTd+bjzJXtUF48ebGR2QL8+pbVIMv2hTxA54y+xkBsoHxhAIOinnZtlUsyALNQ2GM9995wiUw7P3QPOkMmptDV2sd0XraAducoGZj3wm2/xehsxpU1+q0bXDZZWCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da85cf3-9aca-432c-a380-08df1e214f75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:00:52.7173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkqstzMFrVrZUxnXutWP3YWhXKFFCJQu+6yErfhYt59BHKtfanD7p2vlfOrJIjSoUO3XI4YBIuGyD/q9eMfVgQiWZ9xEJgt10ndpgDs+UGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
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

Hi Jani,

On 2026-09-25 at 13:47:39 +0300, Jani Nikula wrote:
> On Thu, 24 Sep 2026, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> > Add i915_* family of printer macros, following existing example
> > of gt_* and xe_* prints.
> 
> Frankly, I don't want *any* of this.
> 
> The drm_* macros are already a bunch of wrappers around dev_*
> macros. IMO this is just too much, just to avoid writing &i915->drm.
> 
> (And yes, I dislike what's been done in xe too.)
Then, we'll have to live with two different print families and
that is the end of that. I'll revert this series to its former
version (and include other comments that still apply too).

In any case, thanks for your input.

> 
> 
> BR,
> Jani.
> 
> >
> > Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> > Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> > ---
> >  drivers/gpu/drm/i915/i915_printk.h | 53 ++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 drivers/gpu/drm/i915/i915_printk.h
> >
> > diff --git a/drivers/gpu/drm/i915/i915_printk.h b/drivers/gpu/drm/i915/i915_printk.h
> > new file mode 100644
> > index 000000000000..5bbbe604cae8
> > --- /dev/null
> > +++ b/drivers/gpu/drm/i915/i915_printk.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: MIT */
> > +/*
> > + * Copyright © 2026 Intel Corporation
> > + */
> > +
> > +#ifndef _I915_PRINTK_H_
> > +#define _I915_PRINTK_H_
> > +
> > +#include <drm/drm_print.h>
> > +
> > +#define i915_printk(_i915, _level, _fmt, ...) \
> > +	drm_##_level(&(_i915)->drm, _fmt, ## __VA_ARGS__)
> > +
> > +#define i915_err(_i915, _fmt, ...) \
> > +	i915_printk((_i915), err, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_err_once(_i915, _fmt, ...) \
> > +	i915_printk((_i915), err_once, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_err_ratelimited(_i915, _fmt, ...) \
> > +	i915_printk((_i915), err_ratelimited, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_warn(_i915, _fmt, ...) \
> > +	i915_printk((_i915), warn, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_notice(_i915, _fmt, ...) \
> > +	i915_printk((_i915), notice, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_info(_i915, _fmt, ...) \
> > +	i915_printk((_i915), info, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_dbg(_i915, _fmt, ...) \
> > +	i915_printk((_i915), dbg, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_dbg_ratelimited(_i915, _fmt, ...) \
> > +	i915_printk((_i915), dbg_ratelimited, _fmt, ##__VA_ARGS__)
> > +
> > +#define i915_WARN_type(_i915, _type, _condition, _fmt, ...) \
> > +	drm_WARN##_type(&(_i915)->drm, _condition, _fmt, ## __VA_ARGS__)
> > +
> > +#define i915_WARN(_i915, _condition, _fmt, ...) \
> > +	i915_WARN_type((_i915), _condition, __I915_PRINTK_FMT((_i915), _fmt, ## __VA_ARGS__))
> > +
> > +#define i915_WARN_ONCE(_i915, _condition, _fmt, ...) \
> > +	i915_WARN_type((_i915), _ONCE, _condition, __I915_PRINTK_FMT((_i915), _fmt, ## __VA_ARGS__))
> > +
> > +#define i915_WARN_ON(_i915, _condition) \
> > +	i915_WARN((_i915), _condition, "%s(%s)", "WARN_ON", __stringify(_condition))
> > +
> > +#define i915_WARN_ON_ONCE(_i915, _condition) \
> > +	i915_WARN_ONCE((_i915), _condition, "%s(%s)", "WARN_ON_ONCE", __stringify(_condition))
> > +
> > +#endif
> 
> -- 
> Jani Nikula, Intel

-- 
Best Regards,
Krzysztof
