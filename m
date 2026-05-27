Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46346CD5BDE
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 09:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFC510E1A7;
	Wed, 27 May 2026 09:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EUvdWayh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A26810E1A7;
 Wed, 27 May 2026 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779873888; x=1811409888;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5L0t7Co4WquRBiizd3UmHsV8eD0imTBRKOUJBNpZFcQ=;
 b=EUvdWayh89j/f7c/JdeXn+YfBY9qeYUPE0kAesziGRmxPcXU0Ruq9giJ
 s73oYfntMFMXTzf/YB59K6B9SeQKYBeusCzIPaxSiQkTG2Ct5xUbohNce
 qAeICX+fHuISzdWlXw4lbP2vdIb4jHjoeiDgzxebyQrLmlRuie3hPBxFG
 VcH2bcTg3PnJXmiXers1soA9mpgASQ0+7HQ1BnB688xMXzjKQ1AyEHH5O
 k0urzxmFItsOuAKehVl9D3qWFZq9Eo6Mir7OyUVzBQUJhTQjjWwaVU9gP
 WSWlxYWt4Lcotjlpvwao27d1w7rh+jAiT2b9ioMYNuV1UAZRxwOIHgMSe g==;
X-CSE-ConnectionGUID: uFLwBhutTcumkVjFR1PPQg==
X-CSE-MsgGUID: uZUuDuWvRPmZO167WwgHNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84590826"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="84590826"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:24:47 -0700
X-CSE-ConnectionGUID: Cwq0YWoWRG6dSu0Z+suUPg==
X-CSE-MsgGUID: USOjATleTRq97z0jjPRM/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="247130815"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 02:24:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 02:24:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 02:24:47 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 02:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLoBVrdT8P8XF5j7QxxYVgalvrRLAaiOpeNNDTBq1hCIT732GFka8Y23K9wOOCWl4Y70Qwwka0oSXKJK26QgB8KrS17RgxRfw7wsKevv3aweqzV2ZkjWTabqMmR0KhhuvP7byD8LpRagFs2axC5DpjPBdSy7bA0P8AUIlarI4DK20yumJt0/IvGhjxuwmBv92Cn579KXQ3kT3quZ5pqgl8zfw71ZVrzpTpUfMZNQjHqyVDzSMp7nWODxXtQyJf77EFd7Jh/pOgwF3K/pSILMAkYkwbfhvssLtNxtjt+moexwNxasIDQTmW269KNZl3IEMDB0J1dGvJwgW1JWmjsT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L0t7Co4WquRBiizd3UmHsV8eD0imTBRKOUJBNpZFcQ=;
 b=x/3aooom37rOwv9N+8dgtg1zvNv0mrMIffcWyuZJ/keIWvI06S/0+G1/dLKILXv+Kd/4S2lZYlTlpOE70d+rYYk62IXMPs4HUKaC0g1+msTqqTyQa/23s1wGiDFcCtAYso0Jy80WjzMFoG3WX9Jcgsb9V4Mglr/BMMUx2TDP87AM3O2gCt9/4JPozy5CjLMFFFEb+3JFBTCOdSXhVOb479ABwK7YBdOmjjsktd8Dgroc1PZLCK6ohXg+ddeG043zrPj7vcnrIHgT1udsh8xpocCXroeP7rgfq3o0L03VrTyshHshA/BNi7zicQkFfBiDkg65hL/e2o9Reu+E32gSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:24:41 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 09:24:41 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Auld, Matthew" <matthew.auld@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
Thread-Topic: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
Thread-Index: AQHc54sVkWg3vZ8iC0KRpDwXur9Kf7YWnVkAgAAYUlCAAvLDAIAH/RTw
Date: Wed, 27 May 2026 09:24:41 +0000
Message-ID: <DS0PR11MB8718D8AFC4B935BCD917255D81082@DS0PR11MB8718.namprd11.prod.outlook.com>
References: <20260519122817.45770-12-tejas.upadhyay@intel.com>
 <20260519122817.45770-15-tejas.upadhyay@intel.com>
 <835d204d-0c2a-4a81-8c60-9d047809f6ef@amd.com>
 <DS0PR11MB871852B659D0736A9582D23081012@DS0PR11MB8718.namprd11.prod.outlook.com>
 <468b9064-9eed-4651-b54a-4a15c7c4400f@amd.com>
In-Reply-To: <468b9064-9eed-4651-b54a-4a15c7c4400f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8718:EE_|PH0PR11MB4790:EE_
x-ms-office365-filtering-correlation-id: d5ebcbb8-e32b-4c47-e55e-08debbd1c81f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: FpDWHHQCZ/HTxLKrmrTxERnOxh+Qv5/hm7kXYC8emq+cibamRhu1FKCeHQc6UIHXUP4lsQPwMNGGxreKItmRROCN0i8mP07mUau0HDOnZGYZv0p1HdMrXNyC/gx8ZxUuoC+pp2hU5oTUGPl4klvhgf56YI3EUdhWaREfDvzcgombgLc8y6o4MwiCBwkSEbrm9L6mLuOhwf2BxEIXfA+FfuskJdoYL8Wf8y+hcJOtLVfKDMUh1HKhRoAYdARq3UU9f9Sv2MQLZrYOHhqPT68IXV5syPsIBzcG1yqIccE12zUpqJrxKrp1fumg5et/fBQBlFJQEZ4nR+08vkj0egsnCHxasSkj1uA4MOdvlrMt2EkrRKI2xYygvgFQhfjqHKQWP8ePNI/x7Hs/3t+whwGHGT/rxYkdzITML3M9kb3yoVkW9X85JPV7osvfA8F3J96ZXoaFmKvjrQ4EmFleG+iezHJfpEbXbbYWUbRvfszAGa23jnT89IGVImiz8GlBzyRpBqL0H5WzitrsrWWN9dPjkjxZCO9H5DMscHxs8IN8oxrjCnHN5HFNY3PkW8EoF6rK8X9vN14N0enJbBI5dH8/s2s+woh/8VXjvQ/qtmD+3u/YRlpa8QySFluNDrFSvojxQGgVFmTFQZjA4XK3SGZrT4psfexdV5X8BMJm0Sm8d2Ngr162gakCDiqGTF2/BtD+gfJmbZHiDxJEH+kd2dgQMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEdrN2dqd3V2bHNIRXdQMTBIaG5uTzRUeCtSbnRjbGMydkNXRHZxWSs5RDN5?=
 =?utf-8?B?MDlEeDBEbWdlS2pkczhHYUVsSWJEeHFoZ21RdDYrRzdPMy9sRDhtd0h5SWRI?=
 =?utf-8?B?cG5JeGtLWXN0S0g3NGppU0xRTHhZYksreXI2T0lwbEdWMkRTVWcvNUY3SU81?=
 =?utf-8?B?ZjhSRFp2UEJGSmY5UmNZd1VBR3ZMSmxoSUtQUGJSbXRLQTk3Qmc2andyRDZv?=
 =?utf-8?B?YjBJZmFpYUc1bFV4bTUzR2xwYWdMeW8yTUNENHNmNGpaTnI2VFhQWTdXTWR0?=
 =?utf-8?B?djRzUFE5R1JzY1RJNWJiWGs3SnZyM0p3cm12SUc5bGlHYVFwSlB4WDU0L0My?=
 =?utf-8?B?dXFva3pZSkR6cmdXZFJteFhXQmw5VXpKeEVFMG5Md21wM2xtZ3NaUzFWYW5u?=
 =?utf-8?B?WlNzZ1JZenRYMzdFSjBCVkhINEtrS1pCanRBaXN3S0lkSU1kNWlFYkV6dzRR?=
 =?utf-8?B?cW5KVlJRc3R2TjRjK2s5QnhxNHpNanBXTk1VVkRnNTFxaVZUTzhvcGJza2RK?=
 =?utf-8?B?c1JSZzhPajVDWTJZblBaa0F4b0FWUXpHNUhNZUpHSFVrL3ZwZFNhbkdKSlJH?=
 =?utf-8?B?clBGY2VJZEFwY1dnOHRVN0xwNm1VR2t1RmRLMGdHdFJTczcwYlBvZmFMQURj?=
 =?utf-8?B?b3lQb2IzRHUzeHhYMG43dEVtSUUrOFo1UXpHMDVMeENQU0JzRVFES2V0aVlS?=
 =?utf-8?B?Ui9XNmNsVWRDTDhQZWtEMjFyUTZiSU1XWXBFS3Zxb0dwdGV6VDFJaEEwVVRP?=
 =?utf-8?B?ZFBnbWp5c3JxSGF5VWpDMmF6YWJrRGt1eUhwLytqQUgzYmdRclNhU3dpbzFC?=
 =?utf-8?B?bnhBc245dXlpRW1rcU9VMmlVTHZCMEYrLzFMWTRWMGdJeXUvUTJJVGNmL283?=
 =?utf-8?B?ZExOazd6K3o3NERvYnV5RVR6dGR4YWpmT3dvbWlNcEkzazFPTm8wWE9QMko0?=
 =?utf-8?B?QVVjTjc2cDJJZjRxMUJYT1hUUzI5OTNzdUVqRG1ZQ2QvTVB2R1JkaktlREFX?=
 =?utf-8?B?VC96VWdyS3hkOFRyOTNpMUIveFRGazZKYVM1T01SQlBSbTRZUXpJQkUyUmRh?=
 =?utf-8?B?Wm8yVDdIWitDY01xL3pkdEJYOG9SREZjRjl0NUs0V2hUWlVLOFc4YjJlWEJi?=
 =?utf-8?B?ams4enZ4MVNXQ1dSQkVKdHczbmlQNzdNSGdPb0VjSkloWFphUDJDa3k1bnlB?=
 =?utf-8?B?YUNVdm5LRHlTU3Z2RzVXNll1Ym5yb3J4T0UrZEVVeFE1R0Q4aXpUK2hzSFJS?=
 =?utf-8?B?V05vM0hjMEx2Y0RDbzk1SHNMODdiWjNqdnlOOTJmNUNtcnlPMDNUQjI5Q2xM?=
 =?utf-8?B?UlNmWnBCYWtmaDkxWnRIMjNrMjlNaEpGQUI2cGNmTnBCWEoyRG4ydld2d2RD?=
 =?utf-8?B?bGtua0ZLQjZGS0lGNzM2NjE0a3RtOVhmUEViTkRnZ3B3UThtMzkxYzFkWWpP?=
 =?utf-8?B?UEtDTTZ2eGR6SmtCNXZvVTZuL0hVVGhXcHpwZXFDTDJWaXZRYmFna08vM2Zh?=
 =?utf-8?B?K2RqcTBBWWRwRnZhdVZGbU9zdGQ5cU12ZmhaRXY5TFQrVGg1LzhOV1A1MWdY?=
 =?utf-8?B?RFhHQyt6MDNYLzFVOWluZmh6RzNLeFpSK0UxUUdRWjBPWnRYem9zcFgyWWsx?=
 =?utf-8?B?dDRpeWdIQWpTMCtVMVE5VWcxa0hucmwyY2d3THhLSFJta2dyREJ4c0VtK24w?=
 =?utf-8?B?SHNienhwaGc2NjhBaElqU1FvOU5MdUhuYnBacGJyb2F4NC95M1c0Zk91bmhI?=
 =?utf-8?B?Y1N2aVZaWGRXR016Rnc1SDhKdmxnTmYwNi96UGtTZ3FuWEhPaDVHK0dHM0Nw?=
 =?utf-8?B?eUpsYjFja0RFbmVUcVZzeFRTNElTREFDY0dWMHgyWlk4MS9TN29mQ29uRXZI?=
 =?utf-8?B?RTI2TWNtaHY0STB2K0RPRUp4b0xLVUZFTHplRW5HZWtHL2lyaWRXSDFCQWlK?=
 =?utf-8?B?aDU4bnZTanFWUVFMbFByZDljdUROS21tQUEza2o3WDB0U1dhZ3poR2VKcGlr?=
 =?utf-8?B?SWNzc1JDUDVKY3JRZWwwMlZ5a0VIRWZGeUdHeS9TdzNCV0lNUGhJbjV5ZElx?=
 =?utf-8?B?ZkN2b1Z5ZURUOWtRcUloeENXc1NDVGlscWtUc01ndmI4RUFnZ3B4ZmhXeVd0?=
 =?utf-8?B?WTh3ZmNheWZxLzN4ZWNOTFVmSU10b2Vob0dsaWVZRkJ1YmZKOFpoOGJTZWFk?=
 =?utf-8?B?Y0xNRmJtVUhMcm9naWl2eS8xeDZ2ZnZaMVAycUp2MGM5L29tWUhhbXJIOGk1?=
 =?utf-8?B?WTZNWkhHZHFlSUxVakRkMTFlQjhKb0dHdW1jaXkxMGEySzB3MjBjN0Zvcnll?=
 =?utf-8?B?WjNOT3JLZ04wMWV2RDlHTHh1M3NUVnJhbStyZEVlblB2ZWt1WXlpQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Im1DRYEJggcK78k0l2HbXQ+UA2b6XIJH8FqgeoZWfWKrWXTa2xISTyKUS6y4zOME+E2FVSuNkfsQcoIo9JHQod77eocO+wIlD0Ut4hI/pDXbjJlamtllRb6rAfYEzwhMl4L6iUFKB8xRnSVBIataMyLkIJYncEDMI5ZM2bScBqVsKJwiWWd5Y3QrKtwYJ3s9x0viyKtFzPiOx3iEQGXzPejLHjT6LWpw8kTMiFiUnzBhoUM/+E2Vz4VmrXXeW38M9xckOkhDOmefcTctqoC+eeNc2doh3EAWDyJO6ltmHKYXHCST0xNfNr5CHUnRZaSOes5D8cd0DgYpMnlyO3EyXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ebcbb8-e32b-4c47-e55e-08debbd1c81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 09:24:41.3266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 008cVkIUFGzHxV8Fmz6aMxZX2/m5DkYZM5diqg4SgiMcuhWId9lcQR4SMvU0yiJwuL+NVTwejnwi/pEz011+XSpKQSbm/wU5LbpVDnSNfC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJ1bnByYXZpbiBQYW5l
ZXIgU2VsdmFtIDxhcnVucHJhdmluLnBhbmVlcnNlbHZhbUBhbWQuY29tPg0KPiBTZW50OiAyMiBN
YXkgMjAyNiAxMjo1Mw0KPiBUbzogVXBhZGh5YXksIFRlamFzIDx0ZWphcy51cGFkaHlheUBpbnRl
bC5jb20+OyBpbnRlbC0NCj4geGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBBdWxkLCBN
YXR0aGV3IDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPjsgQnJvc3QsIE1hdHRoZXcNCj4gPG1hdHRo
ZXcuYnJvc3RAaW50ZWwuY29tPjsgdGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb207IEdo
aW1pcmF5LA0KPiBIaW1hbCBQcmFzYWQgPGhpbWFsLnByYXNhZC5naGltaXJheUBpbnRlbC5jb20+
OyBkcmktDQo+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIFYxMCAwMy8xMF0gZHJtL2dwdTogQWRkDQo+IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90
b19ibG9jayBoZWxwZXINCj4gDQo+IA0KPiANCj4gT24gNS8yMC8yMDI2IDM6NTIgUE0sIFVwYWRo
eWF5LCBUZWphcyB3cm90ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBBcnVucHJhdmluIFBhbmVlciBTZWx2YW0gPGFydW5wcmF2aW4ucGFuZWVyc2Vs
dmFtQGFtZC5jb20+DQo+ID4+IFNlbnQ6IDIwIE1heSAyMDI2IDE0OjI0DQo+ID4+IFRvOiBVcGFk
aHlheSwgVGVqYXMgPHRlamFzLnVwYWRoeWF5QGludGVsLmNvbT47IGludGVsLQ0KPiA+PiB4ZUBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcuYXVs
ZEBpbnRlbC5jb20+OyBCcm9zdCwgTWF0dGhldw0KPiA+PiA8bWF0dGhldy5icm9zdEBpbnRlbC5j
b20+OyB0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbTsNCj4gPj4gR2hpbWlyYXksIEhp
bWFsIFByYXNhZCA8aGltYWwucHJhc2FkLmdoaW1pcmF5QGludGVsLmNvbT47IGRyaS0NCj4gPj4g
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEw
IDAzLzEwXSBkcm0vZ3B1OiBBZGQNCj4gPj4gZ3B1X2J1ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Js
b2NrIGhlbHBlcg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiA1LzE5LzIwMjYgNTo1OCBQTSwg
VGVqYXMgVXBhZGh5YXkgd3JvdGU6DQo+ID4+PiBBZGQgaGVscGVyIHdpdGggcHJpbWFyeSBwdXJw
b3NlIGlzIHRvIGVmZmljaWVudGx5IHRyYWNlIGEgc3BlY2lmaWMNCj4gPj4+IHBoeXNpY2FsIG1l
bW9yeSBhZGRyZXNzIGJhY2sgdG8gaXRzIGNvcnJlc3BvbmRpbmcgVFRNIGJ1ZmZlciBvYmplY3Qu
DQo+ID4+Pg0KPiA+Pj4gdjI6DQo+ID4+PiAtDQo+ID4+DQo+ICVzL2dwdV9idWRkeV9hZGRyX3Rv
X2Jsb2NrL2dwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jayhNYXR0QSkNCj4gPj4+IC0g
cmVtb3ZlIGNsZWFyLT5hdmFpbCBhbmQgc3BsaXQgbm9kZXMgY2hlY2soTWF0dEEpDQo+ID4+PiAt
IEFkYXB0IGxvY2tkZXAoTWF0dEIpDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogVGVqYXMg
VXBhZGh5YXkgPHRlamFzLnVwYWRoeWF5QGludGVsLmNvbT4NCj4gPj4+IENjOiBBcnVucHJhdmlu
IFBhbmVlciBTZWx2YW0gPGFydW5wcmF2aW4ucGFuZWVyc2VsdmFtQGFtZC5jb20+DQo+ID4+PiBD
YzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+Pj4gLS0tDQo+ID4+PiAgICBk
cml2ZXJzL2dwdS9idWRkeS5jICAgICAgIHwgNTMNCj4gPj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4+PiAgICBpbmNsdWRlL2xpbnV4L2dwdV9idWRkeS5oIHwg
IDIgKysNCj4gPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9idWRkeS5jIGIvZHJpdmVycy9ncHUvYnVk
ZHkuYyBpbmRleA0KPiA+Pj4gZWIxNDU3Mzc2MzA3Li45ZGU5ODcyMjk0YTYgMTAwNjQ0DQo+ID4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9idWRkeS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9idWRk
eS5jDQo+ID4+PiBAQCAtNTk0LDYgKzU5NCw1OSBAQCB2b2lkIGdwdV9idWRkeV9mcmVlX2Jsb2Nr
KHN0cnVjdCBncHVfYnVkZHkNCj4gPj4gKm1tLA0KPiA+Pj4gICAgfQ0KPiA+Pj4gICAgRVhQT1JU
X1NZTUJPTChncHVfYnVkZHlfZnJlZV9ibG9jayk7DQo+ID4+Pg0KPiA+Pj4gKy8qKg0KPiA+Pj4g
KyAqIGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jayAtIGdpdmVuIHJlbGF0aXZlIGFk
ZHJlc3MgZmluZA0KPiA+Pj4gK3RoZSBhbGxvY2F0ZWQgYmxvY2sNCj4gPj4+ICsgKg0KPiA+Pj4g
KyAqIEBtbTogR1BVIGJ1ZGR5IG1hbmFnZXINCj4gPj4+ICsgKiBAYWRkcjogUmVsYXRpdmUgYWRk
cmVzcw0KPiA+Pj4gKyAqDQo+ID4+PiArICogUmV0dXJuczoNCj4gPj4+ICsgKiBncHVfYnVkZHlf
YmxvY2sgb24gc3VjY2VzcywgTlVMTCBvciBlcnJvciBjb2RlIG9uIGZhaWx1cmUgICovDQo+ID4+
PiArc3RydWN0IGdwdV9idWRkeV9ibG9jayAqZ3B1X2J1ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Js
b2NrKHN0cnVjdA0KPiA+Pj4gK2dwdV9idWRkeSAqbW0sIHU2NCBhZGRyKSB7DQo+ID4+PiArCXN0
cnVjdCBncHVfYnVkZHlfYmxvY2sgKmJsb2NrOw0KPiA+Pj4gKwlMSVNUX0hFQUQoZGZzKTsNCj4g
Pj4+ICsJdTY0IGVuZDsNCj4gPj4+ICsJaW50IGk7DQo+ID4+PiArDQo+ID4+PiArCWdwdV9idWRk
eV9kcml2ZXJfbG9ja19oZWxkKG1tKTsNCj4gPj4+ICsNCj4gPj4+ICsJZW5kID0gYWRkciArIFNa
XzRLIC0gMTsNCj4gVGhlIGxvb2t1cCByYW5nZSBpcyBkZWZpbmVkIHVzaW5nIFNaXzRLLCB3aGls
ZSB0aGUgYWxsb2NhdG9yIGl0c2VsZiBvcGVyYXRlcyBpbg0KPiB1bml0cyBvZiBjaHVua19zaXpl
Lg0KPiBUaGlzIHdvcmtzIHdoZW4gY2h1bmtfc2l6ZSA9PSA0SywgYnV0IGl0IGNyZWF0ZXMgYSBt
aXNtYXRjaCBpZiB0aGUgYWxsb2NhdG9yIGlzDQo+IGNvbmZpZ3VyZWQgZGlmZmVyZW50bHkgKGUu
Zy4gbGFyZ2VyIGNodW5rIHNpemVzKS4NCj4gU2hvdWxkIHRoaXMgaGVscGVyIGJlIHRpZWQgdG8g
YWxsb2NhdG9yIGdyYW51bGFyaXR5IChpLmUuIHVzZQ0KPiBtbS0+Y2h1bmtfc2l6ZSkgaW5zdGVh
ZD8NCg0KWW91IGFyZSByaWdodCwgZm9yIGFsbCBhcmNocyBvciBwYWdlc2l6ZSB0byB3b3JrLCBo
ZXJlIEkgc2hvdWxkIGNoYW5nZSB0byBlbmQgPSBhZGRyICsgbW0tPmNodW5rX3NpemUgLSAxOy4g
VGhhbmtzIGZvciByZXZpZXcgaGVyZS4gV2l0aCB0aGF0IGNoYW5nZSwgaXMgcGF0Y2ggYXBwcm92
ZWQ/IE9yIHlvdSBoYXZlIGZ1cnRoZXIgY29tbWVudHM/DQoNClRlamFzDQo+IA0KPiBSZWdhcmRz
LA0KPiBBcnVuLg0KPiA+Pj4gKwlmb3IgKGkgPSAwOyBpIDwgbW0tPm5fcm9vdHM7ICsraSkNCj4g
Pj4+ICsJCWxpc3RfYWRkX3RhaWwoJm1tLT5yb290c1tpXS0+dG1wX2xpbmssICZkZnMpOw0KPiA+
Pj4gKw0KPiA+Pj4gKwlkbyB7DQo+ID4+PiArCQl1NjQgYmxvY2tfc3RhcnQ7DQo+ID4+PiArCQl1
NjQgYmxvY2tfZW5kOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJYmxvY2sgPSBsaXN0X2ZpcnN0X2VudHJ5
X29yX251bGwoJmRmcywNCj4gPj4+ICsJCQkJCQkgc3RydWN0IGdwdV9idWRkeV9ibG9jaywNCj4g
Pj4+ICsJCQkJCQkgdG1wX2xpbmspOw0KPiA+Pj4gKwkJaWYgKCFibG9jaykNCj4gPj4+ICsJCQli
cmVhazsNCj4gPj4+ICsNCj4gPj4+ICsJCWxpc3RfZGVsKCZibG9jay0+dG1wX2xpbmspOw0KPiA+
Pj4gKw0KPiA+Pj4gKwkJYmxvY2tfc3RhcnQgPSBncHVfYnVkZHlfYmxvY2tfb2Zmc2V0KGJsb2Nr
KTsNCj4gPj4+ICsJCWJsb2NrX2VuZCA9IGJsb2NrX3N0YXJ0ICsgZ3B1X2J1ZGR5X2Jsb2NrX3Np
emUobW0sIGJsb2NrKSAtDQo+ID4+IDE7DQo+ID4+PiArDQo+ID4+PiArCQlpZiAoIW92ZXJsYXBz
KGFkZHIsIGVuZCwgYmxvY2tfc3RhcnQsIGJsb2NrX2VuZCkpDQo+ID4+PiArCQkJY29udGludWU7
DQo+ID4+PiArDQo+ID4+PiArCQlpZiAoZ3B1X2J1ZGR5X2Jsb2NrX2lzX2FsbG9jYXRlZChibG9j
aykpDQo+ID4+PiArCQkJcmV0dXJuIGJsb2NrOw0KPiA+Pj4gKwkJZWxzZSBpZiAoZ3B1X2J1ZGR5
X2Jsb2NrX2lzX2ZyZWUoYmxvY2spKQ0KPiA+Pj4gKwkJCXJldHVybiBOVUxMOw0KPiA+Pj4gKw0K
PiA+Pj4gKwkJbGlzdF9hZGQoJmJsb2NrLT5yaWdodC0+dG1wX2xpbmssICZkZnMpOw0KPiA+Pj4g
KwkJbGlzdF9hZGQoJmJsb2NrLT5sZWZ0LT50bXBfbGluaywgJmRmcyk7DQo+ID4+PiArCX0gd2hp
bGUgKDEpOw0KPiA+Pj4gKw0KPiA+Pj4gKwlyZXR1cm4gRVJSX1BUUigtRU5YSU8pOw0KPiA+Pj4g
K30NCj4gPj4+ICtFWFBPUlRfU1lNQk9MKGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9j
ayk7DQo+ID4+PiArDQo+ID4+PiAgICBzdGF0aWMgdm9pZCBfX2dwdV9idWRkeV9mcmVlX2xpc3Qo
c3RydWN0IGdwdV9idWRkeSAqbW0sDQo+ID4+PiAgICAJCQkJICBzdHJ1Y3QgbGlzdF9oZWFkICpv
YmplY3RzLA0KPiA+Pj4gICAgCQkJCSAgYm9vbCBtYXJrX2NsZWFyLA0KPiA+Pj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZ3B1X2J1ZGR5LmggYi9pbmNsdWRlL2xpbnV4L2dwdV9idWRkeS5o
DQo+ID4+PiBpbmRleCA3MTk0MWEwMzk2NDguLmU3ZTIyZmEwNWVlMiAxMDA2NDQNCj4gPj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvZ3B1X2J1ZGR5LmgNCj4gPj4+ICsrKyBiL2luY2x1ZGUvbGludXgv
Z3B1X2J1ZGR5LmgNCj4gPj4+IEBAIC0yNzIsNiArMjcyLDggQEAgdm9pZCBncHVfYnVkZHlfcmVz
ZXRfY2xlYXIoc3RydWN0IGdwdV9idWRkeQ0KPiA+PiAqbW0sDQo+ID4+PiBib29sIGlzX2NsZWFy
KTsNCj4gPj4+DQo+ID4+PiAgICB2b2lkIGdwdV9idWRkeV9mcmVlX2Jsb2NrKHN0cnVjdCBncHVf
YnVkZHkgKm1tLCBzdHJ1Y3QNCj4gPj4+IGdwdV9idWRkeV9ibG9jayAqYmxvY2spOw0KPiA+Pj4N
Cj4gPj4+ICtzdHJ1Y3QgZ3B1X2J1ZGR5X2Jsb2NrICpncHVfYnVkZHlfYWxsb2NhdGVkX2FkZHJf
dG9fYmxvY2soc3RydWN0DQo+ID4+PiArZ3B1X2J1ZGR5ICptbSwgdTY0IGFkZHIpOw0KPiA+PiBD
b3VsZCB5b3UgcGxlYXNlIGNsYXJpZnkgd2hlcmUgd2UgcGxhbiB0byB1c2UgdGhpcyBoZWxwZXIg
ZnVuY3Rpb24gaW4NCj4gPj4gdGhlIGNvZGUgcGF0aD8gSSBkbyBub3Qgc2VlIGFueSBjYWxsZXJz
IGFkZGVkIGluIHRoZSBjdXJyZW50IHBhdGNoIHNlcmllcy4NCj4gPiBTdXJlLCBpdCBpcyBnZXR0
aW5nIGNhbGxlZCBpbiBBUEkgeGVfdHRtX3ZyYW1fcmVzZXJ2ZV9wYWdlX2F0X2FkZHIoKQ0KPiA+
IGF0DQo+ID4NCj4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzcyNjI1
Mi8/c2VyaWVzPTE2MTQ3MyZyZXY9MTANCj4gPg0KPiA+IFRlamFzDQo+ID4+IFJlZ2FyZHMsDQo+
ID4+IEFydW4uDQo+ID4+PiArDQo+ID4+PiAgICB2b2lkIGdwdV9idWRkeV9mcmVlX2xpc3Qoc3Ry
dWN0IGdwdV9idWRkeSAqbW0sDQo+ID4+PiAgICAJCQkgc3RydWN0IGxpc3RfaGVhZCAqb2JqZWN0
cywNCj4gPj4+ICAgIAkJCSB1bnNpZ25lZCBpbnQgZmxhZ3MpOw0KDQo=
