Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB2C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 04:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037A110E6FE;
	Wed, 22 Jul 2026 04:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hA0lurG4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D729910E4C4;
 Wed, 22 Jul 2026 04:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784695105; x=1816231105;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KvFaHIlVaMCr5sc6KZGCOayMQcdC6hCrt4o3+wETgAA=;
 b=hA0lurG4g+BuodgbkfadrYxGbJuVzZmV57XCZozU6YmRvkSPIH5hg8xt
 2ngkxXE/g7AOJivAPCDrtPZHrgPucjuM1xRVrrXSUpXcFH9Shl9WGBJg9
 53twtunLIfguYHGYtghgyMLTyXFwfrJy7yEpDr2AhIMs2ojeOTb6g+IsL
 m3YWL4rJwRojEf2rQEv7W7m91kCCuwRnGjL67v9KM60l5E7VXAe04QWkS
 9bMfZmi3uNgw/1EOvlwqvPrDTjotPs97zdA7ciDFKBmv6cBssyesveycB
 crHkRhvKQMDyem4Nhsu4k8oyUfRsbgycOvjR9KcVKYMfr33C7TInLz5Yp g==;
X-CSE-ConnectionGUID: EWLC9erbQLapZ+ZPB6RZtw==
X-CSE-MsgGUID: R3yb3KbARPmr9Wp+V+CQEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85515227"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="85515227"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:38:24 -0700
X-CSE-ConnectionGUID: wAdwFBH9Q9eyysUENnk3vA==
X-CSE-MsgGUID: 6jCaFP6nTkO5Xtz2eQqlwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="251653684"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 21:38:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 21:38:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 21:38:22 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 21:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO2/idEIR+sxW/ZZBeOkBLx/8JoVigdmsU2C1ubDCk7K2sxQkqma+QefiuG3oCfwmbu5NvP/e3QOuqMr59iU5Y8+il/OP8JS/VevBfFXdQLn1uQVAZttEdZiXKsHZbvww3W+4yxw8L7nOSqPVxO+PxxR5x2GHKSWQaqZqyvxZlA+MGCwZyzPQGif5nBF7Fc/pu5xkeWrjX54sc1vKcLfdhvgXt1F+xu/gmLpmtmlfTIUHkJ9wGkNUzf/HMfp/oKN30rcO9iVxZq0QAlqKei7BpEAoLVzY3ZgTnVhkuq6vTBLZyWxI7G/474jegcC5vHTUVNYzmOvotCc8DItOoPJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APQfVMOaejoEO6Fz05gIkqTXvZmpP5D1KF8GlCECi7U=;
 b=S9jX7sDY5TEQXGeWSAwufW0+EyJkXobfSD9ES9zziVzxiefHyPbt0X57xaZfntaNWo1ht1On6HzuUZssMdeJybQzJJgT+PHdHy2F3KTEi16mziCwW8NL4Zv97PE7cd5h78mCEoQCgg2OqorOu6PECS6Ngix8J1hyiOwRhIPDQsac2ccvthkL7iX3OtTuBPtD4m9sebAiIiyvL1+rualQdXYJlj1ROQU5UAEnsD80HSG03CYMNH+0zxWKjujDIbEnhjn97T9Hmy8JYTWgtMPR2WF4CtXGC7CUKTF6ukEZOcWKg/Yparqbzh/CjeqDpoKq7ooqwZEg3LKiA+V0+fxbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 04:38:14 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 04:38:13 +0000
Message-ID: <06623acf-e89c-4410-8621-a86d1afe0f5d@intel.com>
Date: Wed, 22 Jul 2026 10:08:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error events to
 userspace
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <aravind.iddamsetty@linux.intel.com>,
 <anshuman.gupta@intel.com>, <rodrigo.vivi@intel.com>,
 <joonas.lahtinen@linux.intel.com>, <kuba@kernel.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mallesh.koujalagi@intel.com>,
 <soham.purkait@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-7-riana.tauro@intel.com>
 <al8v2STXTiMhp5C5@black.igk.intel.com>
 <0e842368-3bbf-436e-839d-cc7fec29b0cb@intel.com>
 <al-neyeoG873l1xX@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <al-neyeoG873l1xX@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::13) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DM4PR11MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: b88dd650-945b-4434-8197-08dee7ab0a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: W6WEnTzNNe/7tvAjiLFGXCWotqOFlPV2XsnUs6P4HYkrl+uiwyC0DPAXq6+KdABy+IgxSH+1D0n8tEDReP0RGOTQhhINeAXORVygqXG46YpqiljJOxi+on0WBIS2v2ONXzsvVvUNkr978tIV7g05gCLIu7laMU4R+OvApYfedqZzzeR26V/KbwvgQGO6mmcC8lI1aukgrd+W7NDZgZGeKqgMK3NBMAvgUgZdAQ+h9jKS4tvqalv5SZuvx2gBVefQrWUYE9H+oTdVHxhXpwKshM+/OZlFFtYTLZIMlpJSmH9rj3TvWNEm0xaMhlR4wPy1VGUcafFb9Kbs/92cLc2x2sSKe+ZFedQdGDC0B2WdWBt0gMP5pt6C7fRCcBUJqg8B9pz5fOyzr7zOXYa6q04WZAHQ49UHTinRPnBNVJU8xRgIVZAbkQARhUaWK6dQp4UCS0PgK+AR2NPK+uEYsqRCcxyCRgAZWIaBB/IK2ae8vHBwxroK5EdzWehcD8PtBweV3Nqbio+txcnvmPlffNZXU52WrGLYuS74h236VnluXQW9A3nkRIuHLCM04gouzlcP8S3QN3nk1drSd89i8PsQX6janYtObJ0KZjFpUAqZ1bKp+4bcJJOT3soi5mrxkQhJOT3vYnPNsB3Q92kVJHlLbDHEPNgKNMXAruINOB+j2ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZPbEt5UllCOUIzdVVvOW1HNThPWi9jNGVXM3FnS0FzOG1CRVRoemV0UlBm?=
 =?utf-8?B?Q0d0dFd2SFIyeVBrVzFFL0oxcEdqWllmUThXVVNCMEtTQjY5WXNBR1hHMUZV?=
 =?utf-8?B?TGJOMVRCT1o0b21kM3AyMW11WUlKU2o1dFc3L2s2bUR3UE51ckNhZlNJYTRI?=
 =?utf-8?B?REhyc3ZKbHQ4OFgrc2d4eThEZmkwbkxQRUJHbUxmY3FHakxRM3hVQ0kvSVg2?=
 =?utf-8?B?UjdxNW12d2R5SzFNZTJTR3d2ejZsTi84M3d4ZkhKR0dwTzdsNUlWVllNbnlm?=
 =?utf-8?B?QWo4ZWFYODNSTUZRejhiVGFURkhIODBKSjl1NGdGK1hoOUpDZTluU09vVGVl?=
 =?utf-8?B?ekhlSWkweWp2TFIyc1hUdWE0RVdIbDQ2dGh3bTBENnZoRVRsRW9ZR0dJaExL?=
 =?utf-8?B?MVJyYk8vTDh1YXNhQ0pPSWhUN3ZIOW5Nd00vZVY5eXQvaWU1SmdDQkw2Q3NT?=
 =?utf-8?B?N1Ruc0Z1SVJhRURNRUkvQ1FtR0ZKWlR2TUdkaTUwc29Kai9ib3NpVFZiSWRT?=
 =?utf-8?B?RExrREJzMjF4UFdvSVRBSTU0eUxIRFd5dk9lTk92cFh3VkNqeTZZM2VUS2k3?=
 =?utf-8?B?NSsyN1dqNXFYRTNVSkl3ZW1mYThSYitOV1hZRWhqQk1wV2p0VjNweEZwQUNn?=
 =?utf-8?B?MEVERjhlNVRzTFVmYlRBSXRsL3dPdkZqcEtpeXJoaTVPT0VwempraE1kSkov?=
 =?utf-8?B?dDQzWUlBTUZaM29XY1JlQm9xSUNNcUJoaHJtcFkxYWpvM3dCa2d2SGJrYzdR?=
 =?utf-8?B?YmJWMVI0Y3hGUDhnZDZiQzRpWkVxR1VYeCtNS2F2YVJHaTU1Uy9JUnpVZzFp?=
 =?utf-8?B?TjRHRzhqZmpPcmx5a3RRcjMvdmU1bWVxdFZycDN1b0xjUWhBYlgvVzdtejlK?=
 =?utf-8?B?Z0s2cHZpV2tOQzhnTmViT1Rhb25jT3RaTE9SMzRDSS9yQUIwSEpqSmZYamZ0?=
 =?utf-8?B?eFJwOWJvaXgwcTNHQjdnQmgzMGgvbmNLRFFTdjFFN2VhQkZpQ2tIRTk1ZzVo?=
 =?utf-8?B?TEpZL09tUThPUld6RSs0SGZjME5CWXh3OXZaaDlTYjRPQXdSaGNzeFRTUmZi?=
 =?utf-8?B?L2kwOTBZQ1IvektLU1EzNDJTRmR5eU1hYU52T3lXek1pbHRtUXhaNWJlMW14?=
 =?utf-8?B?dS82Qk1OLzg0Ulp5NEE4aHVMN0xGTHNQbEZkUTlWNDlxdUR1ajFaR1VraG5Y?=
 =?utf-8?B?RGlvMWY4a0dHb1l2Tk9HMlJkc3MxYUpQTjZpU0crL1BBL01zbDFxN0ZqZWY5?=
 =?utf-8?B?WTRXZXJhUmlxZ09US1VnVWNPNGVGZEd2c1NQWG1lR05DMHZTNnl4cUVMYUNO?=
 =?utf-8?B?c0FrdWpOOTNEUkFxSGJ0SGVlcWlTZlVPRDY0M2c5OUJqdHpob0F3MXhuZU1V?=
 =?utf-8?B?U3pmUmd5OWc4a0FmUnhXZHF4UXFvK0c2bWNiV0c2blp6dVdzQ3luZXVCK3hO?=
 =?utf-8?B?RVNBWSthN08xa1ViNWs1UElzbkwxZElpbTBIVFg4Q2hBNWc5TjUzdmlRSHl2?=
 =?utf-8?B?N3ZCUFAxb2djZ1BabHAwblRORHNKcFJXd0NvbzMvRFRxSXg0ZjNNMEhSUFg0?=
 =?utf-8?B?ZVhOMWNBTFUvdVpOaTdsNDUwMUtkLzcvWjB1ZWhpVVYrYnd1R21EazNYb3Za?=
 =?utf-8?B?NTNMTElTVy81S2hRelJRNll6VmJGeFRtaGkrOU41L1VPRU9rNHVvbnhnV1BN?=
 =?utf-8?B?aE9uZjg0QXRYSVpWc0wvOUxGTkNxaElUUldxVXRsRG1BSnA0WmcreExMYTE5?=
 =?utf-8?B?WENZVUJrcHB0VUxPMGd1NlpNVTlQUy9MdEJTOHBnZ1ovSWNjSXZzWG1ETFVa?=
 =?utf-8?B?OWluUlpFZkVWaFdxNHE1V01GUysrQ2MrVlB5Zk5qRGtmQzl5NlQvOU5CVVJJ?=
 =?utf-8?B?Mnh2d2R4cFNTUXRGcjB4RnV3YlQveFVGRmJRZkRpMis2Q2EzanNkUi9CUTFH?=
 =?utf-8?B?Rld2R3d1UTU4Vm5aWS9qQU45Zmd6TU1UOWxtZWFiRjFFVzlJOFp4Q2kyQXFu?=
 =?utf-8?B?QWQ0OU1rS0oxWHQzazNBT3AxdlVjcDZMaXVBTjE2UUlDOXVzYzcydWFOa0Jq?=
 =?utf-8?B?WlZTWGd1SThEVkhHM0pVZU1Bb1JMd2w2STdrM3c5azR4U2h0QUNZRnpQR0V4?=
 =?utf-8?B?NHM4RDdhd0JvZlFDSWlMNFBUNEY1UTVuZHFwOXpqcE15Z1hhOVpWWnFGa2NY?=
 =?utf-8?B?dFRoMVdGTXlrWlR4clpxSmdyUlNQbHNac2E0cjBkRDNJUHpEeEJVKy9NSmtQ?=
 =?utf-8?B?OXViWFJDeGtHb1VzS1NJdGxYN28xeHh4SDd6ZW45dktJRjhjSVIrRzQvTFgv?=
 =?utf-8?B?UXI3QWVvaVVYUEN4cjRDSTNmamtrM3UwZWxVcG1RVTh6QVN1NXI3QT09?=
X-Exchange-RoutingPolicyChecked: Mo8i0Kjalw0gnnax6lwezR4tYbYxwctcP/Ej0evZ+Z9fcIKV7sGbsVjSytk3i8Q7ZD+FDAwXhUkSH6WSjXYH5SyU/P6Py/FCyp9yY3O1dvlabWf6NZdJuyTPBIqbbPhN3EbxsAWl0KUQjNoQ6te3IOC6r0Xutrqc99krafeoFUfaI0Fik7cnJQg5zAt/V1xBvKbFW/SHamdAo0t/j1VjXf/HyeRpdSzG14fnUDee2uzp8PtKS4tHzbM99u3gXgWSbd8TyWJK+AeE2+mkgHvc1MnMP9a+apegJUyrzu+O/DO36sMqOrJTUI+lXpcbYZ3wfPp1+fvKxr6nOIz23B1BHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b88dd650-945b-4434-8197-08dee7ab0a72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 04:38:13.7589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xJjvejC7cvaBZOtW4Wowkjw6aRwmtJqlcRU8fncOxOfQ211HhYVkupudd4m+QXMXA6pa2F8dR14dtOviv1LUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
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


On 21-07-2026 22:38, Raag Jadav wrote:
> On Tue, Jul 21, 2026 at 06:52:51PM +0530, Tauro, Riana wrote:
>> On 21-07-2026 14:07, Raag Jadav wrote:
>>> On Mon, Jul 20, 2026 at 01:52:11PM +0530, Riana Tauro wrote:
>>>> When an interrupt is received indicating that error counter has crossed
>>>> its threshold, read the current counter value and deliver a drm_ras error
>>>> event to userspace for each affected component.
>>>>
>>>> To avoid sending duplicate events when the same component appears multiple
>>>> times in the response. Send the error-event once per component.
>>> ...
>>>
>>>> +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)
>>>> +{
>>>> +	struct xe_drm_ras *ras = &xe->ras;
>>>> +	struct xe_drm_ras_counter *info;
>>>> +	struct drm_ras_node *node;
>>>> +	int ret;
>>>> +
>>>> +	/* Event is supported only if drm_ras is enabled */
>>>> +	if (!xe->info.has_drm_ras)
>>>> +		return;
>>>> +
>>>> +	if (component >= DRM_XE_RAS_ERR_COMP_MAX) {
>>> IIUC this is error_id and should be validated against first/last counter
>>> range in drm_ras layer (similar to registration code).
>> This should be done before because we are accessing the nodes here.
>> The nodes anyway won't be available in xe_drm_ras if not registered with
>> drm_ras.
> Yes. We get the node from severity which we already validate here, but
> error_counter_range is the property of the node and unrelated to xe.
> Even if you prefer it here, these checks must be in core functions to
> make sure they are not abused.

But here we are searching for already registered nodes with drm_ras.
So registered nodes are already range checked. The only reason of adding 
this here was to avoid
array out of bounds.

Agreed will remove the check since patch [1] is taking care of the check 
before
it reaches this function.

>
>>>> +		drm_warn(&xe->drm, "unsupported component %u\n", component);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (severity >= DRM_XE_RAS_ERR_SEV_MAX) {
>>>> +		drm_warn(&xe->drm, "unsupported severity %u\n", severity);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	node = &ras->node[severity];
>>>> +	info = ras->info[severity];
>>>> +
>>>> +	if (!info || !info[component].name)
>>>> +		return;
>>>> +
>>>> +	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
>>>> +	if (ret)
>>>> +		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
>>>> +				    info[component].name, error_severity[severity]);
>>>> +}
>>> ...
>>>
>>>> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
>>>> +{
>>>> +	struct xe_ras_error_class counter = {0};
>>>> +	u8 drm_severity, drm_component;
>>>> +	u32 value;
>>>> +	int ret;
>>>> +
>>>> +	counter.common.severity = severity;
>>>> +	counter.common.component = component;
>>>> +
>>>> +	ret = get_counter(xe, &counter, &value);
>>>> +	if (ret)
>>>> +		return;
>>>> +
>>>> +	drm_severity = xe_to_drm_ras_severity(severity);
>>>> +	drm_component = xe_to_drm_ras_component(component);
>>>> +
>>>> +	xe_drm_ras_event(xe, drm_component, drm_severity, value);
>>>> +}
>>> This entire function can be dropped. See below.
>> We don't need to drop function. It's cleaner to have it in the function
>> than repeating it twice.
> I thought we'd lay the groundwork for cper which'll also need get_counter()
> in the same path, but upto you.

confused. CPER requires a get counter on a detailed error_class. Unlike 
here which is a aggregated class
and is called once per component.

So would retain the function and remove the severity and component checks.

Thanks
Riana

> Raag
