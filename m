Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0852DCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B77B10E888;
	Mon, 28 Sep 2026 10:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Jdxd9qZq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B3710E05B;
 Mon, 28 Sep 2026 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790592296; x=1822128296;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nsTPS8PhGQGWylT+GNn3NivBW35nCQFIsK50BBA7HCc=;
 b=Jdxd9qZqxzs0C0YhfbJMEClxw+vpRlipjHWQXEnfTjYVeaJgTnR9n3U8
 CL2Q90njtKeCFkWdZqyq6BLFaOGxEQXetEAgDahmQEMlZoAYHyHpcz+vQ
 k0V0JgV8vVC59Fw2Z+2YgG+hgZFELnAk4Z/ysH/ooocnGziEoxlHXSEnI
 JlbVu1TSchaqxTjjNJEqii5JjxZFcaiidv/CVmSx6eQ4uNoMdVNxmD38f
 qoAKDKRTZf7iefSPo1Cu5VWICKZSQgurZ87ThQDX3nEXG36Ewz2zp41LZ
 NGX6EZM4zx7+1F/XfbL6KP6QCsa08vN1kPS5MbUTADwLob52bA0TiADfU Q==;
X-CSE-ConnectionGUID: c369bhRAQy+B4FGI/pXSAw==
X-CSE-MsgGUID: 5XgH8jj+SNiOAo706HW0rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="91308086"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="91308086"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:44:55 -0700
X-CSE-ConnectionGUID: HpGblOi1ReeIEyM2szKvGQ==
X-CSE-MsgGUID: AInZyM/pSI63rDkT+2/Psw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="283096790"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:44:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:44:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:44:55 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:44:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ynqbq6WC8XkJD1li487G1oW8A8w/jhuG4OHSbd/zCkaEm1f9IZp5s9h44eG+Tqg+1wOBFUrzjEMsRdMqSAw+WfL2+QeJFrQEi8pxJGT1JkWmoaEGG/pORR3mz9Wq5EmJaAyLDC5F/tOyXUxb1EgHXA1jtvhjq8upKyYJHGTC+/JrUVUmAUI9jsOvDl2oRnA/LhDob2e6ed7aHthVtFKWe0NTPoqLd6CU+gwcxSzF/XRh5xly3xQ8CFDVqcKbi0S89/KpheCVpcR4d+ED7sJzlygyUk9546Zhyrf9XsRiQr8A9ks/9WjjGnqmjxiwieaK1q3cBNIeEDWlK1LpoFj7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsTPS8PhGQGWylT+GNn3NivBW35nCQFIsK50BBA7HCc=;
 b=RHAFDeZvdLXDBKmuCd1RgRrFvsWgJMGuKLiIV1KzmKHKB2SVMGWMuNCMGpMTczYIO+uKQuAmP8kCPLBo0VAUrMh/xAaEz8SEX5rDBvZp1tG9xgp9KNCc0Md2TxqPYFtSKHxT6NMFWKDb9gvh9TRZ6j9Uxt5CoEz8bKFNj7gv6je6Vx8lBSHzOPY3rH0ZWqrE4BiKW7xR5M2mY0IGVwX5IJqT8qkm3ya6uwSp07Z8+CjHn1cTSvUzDeYoaKW9vQYkSPMkfZ/I/b7Dlj2dhN13o5l8cAQgwnbscUfI/EMRl3pu2oEOOOPBuuYCuXHE66T5RuUsF2DqZyQgeD/8pV4iYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 IA1PR11MB9496.namprd11.prod.outlook.com (2603:10b6:208:5b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:44:52 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:44:52 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 03/18] drm/i915/alpm: alpm_init() for DP2.1
Thread-Topic: [PATCH v6 03/18] drm/i915/alpm: alpm_init() for DP2.1
Thread-Index: AQHdRUGC1KMY5cTzN0+6nLB4gpgdaLbj4kMA
Date: Mon, 28 Sep 2026 10:44:52 +0000
Message-ID: <666ed15610846357b76f93eefdc3c87d4bbfa898.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-4-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-4-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|IA1PR11MB9496:EE_
x-ms-office365-filtering-correlation-id: 4e739681-8048-4865-6bcb-08df1d4d8729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|5023799004|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 8KJYyi93+Ofsw3vA7wTwRTZpl3i5YTWRBcpfasGwHsSWv4BoUxad2OtTcFU27iBDRiCouusU8SyG9w/OBMrTTy8WEaDGj1Q/A2kIiP3o5UtqqO+foCA0AC2VX6fQY8bL9iQnM3iLatF2K9+UoXMenGuGPXyzTkZ/xM3hsR1WHE7I/Vyk7k26ml98K8ECVvRadjixTI1rZoXt/evb9Aymd9AovRu+dfGxl1EE1FggQ/YnArNOY2+9MR1YceHXL1axMj5NOkt/0Fm2+7x6+GqgaAwr7X8gC4jLBTUKt2Y923P2Mnc86SqqaTGxaexgIMOWNlcO0jiPytr5at+MW3hYZVIOVaZnDD6M8s7BoOBxggO/BQTiHthV5dH+acuYRxYQuEdyl/SOXPksGJbMn5R53rCgKzzFps7s8D++ERymBK2PguCIWDr75UxrlZ2bTj/B8fpludKLBqr5CciP0DSwTtPAfNq8xJkUscMBYJtz1c91Ahn1dgk1LLiv3TJl7yPMSAfNBJs90SS5KWGwp7MkIDh2VBqJLFma35wPT/IsE4V5Pp/KS33XAuYBg4m6IRwnOsLNdABmThf2OkMgh9UEkH6v71eqO7aCryHNXlmOAJUmSnDle39bTo79dw1o5fp9ZUhDbxSKQDytX6jlEPq3fLu0U9COQ3KkEzO/Dct6G50LndthMbYzxU8UscKS5s0egIws7cGDP8K3Ys2GleqAHVpLhe6TK31hk36tMxBu1Ho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1dHKzRuUjcrMjNKTXl4VGkyTkNtWFRPRlhxZFB3dTdCSVlPSUlQY1ZPV2hk?=
 =?utf-8?B?TGFldDhJZFV3NjNBSlN1UFU2dU5lay82aXdmL3RkS1VUT0o5cWdhU1U1KzJh?=
 =?utf-8?B?Z0tLcEhjWDBaa3RiSnBSUXVlVCtKaXhaVzBZb3ZFWHA4U2hJK0U4ampYZlZ2?=
 =?utf-8?B?S0hsL1ZHdWJKU2QwRndmK1NYWERDYzF3eW9DOXBoUUtzQmEwWTFjdGdHY3Zh?=
 =?utf-8?B?ek5hQ0J0ZnUzeXhBVEVJNWUwNUYvRVNZM2JXaGltbWhkdkRuZjB0Mzhwd3Bl?=
 =?utf-8?B?Uy9QcHhCQURIL093Yk01emZJcjZOMTF6WmQwY0kwYnp4QlEwMmhDanFqY2cz?=
 =?utf-8?B?NWpOSVhOSmtXOVJVbHJ5VTFyQWQ4N2ZRVi9CUXV3MXFiZUdLcFVXWG9NT0JN?=
 =?utf-8?B?Z1lNRVRrTnN4RzdNNXFjS2FreHBCUlBOUmIrSHYwMXdRRG1tUkhQSVA0VG8x?=
 =?utf-8?B?ZWFwK0lRUUpTcFZhZ0U5VmdrN0dyb2xiZUM5QjArNXRwUkUxaXFhbGt0UHV1?=
 =?utf-8?B?cTU4dVhkTkVNWWhZTEp0UldBL21pS2dBdUtmQWNlVFArdllYWFkzY25uRitU?=
 =?utf-8?B?R0thNHBxaEQ2QUdZd3NsN0dFbHR3R1dteXFlQjUwTWFvVDdjeVo0cDIvNkUy?=
 =?utf-8?B?L2Z5Y0hyclp4YUp0VytwTi9DWU9iVFd6S1VSTEJhQ0lCanlkZjdBeGRtejBX?=
 =?utf-8?B?bU53aU9hbU93eXUxc0VKVFg4Y1h1Yk01WktyZklLZS85bnFQQjhld1ZlMGt5?=
 =?utf-8?B?UWM3bFRXVDdncXVGMkMzWlduaHFxT0ZaMzF5UkpNbklsRDBMYy9HM1E0TTlm?=
 =?utf-8?B?OE1MRkgwTER5cVlQLzlQTnkzMW9BZTU2bm9kaVRjeXAxVVhKWjdFbFNTYVl3?=
 =?utf-8?B?MWpjaFk4OFllNTRER0ZxVDY4OFFJcWhJeTh6UVFzb2pvbmZmZS9QUm8vNC9H?=
 =?utf-8?B?Tmd2YzNaZnZ5cjQ2bWsvZTl1bXVRNjVDVGZ1L3FQOEUvRjMweE9pVVJDSUFV?=
 =?utf-8?B?dk0zZVVBWE11SmtybDkzTXFLbENUR0VaZW1kK3pFN3FoUHk5VWJxZEl1R2Z3?=
 =?utf-8?B?cThTL01Da1dxS1BWQjVtY3Nwc0t1VGtUWUpSRlZVUWlSTTE0Z29jaXlTODZ1?=
 =?utf-8?B?NHFoN1lzS1pCTDZHWWkrdjQxNmhyS3ArZk1OcllZTFg0M0pXOTNqYzhiMzdD?=
 =?utf-8?B?eFIrQ0JEcTJJbGFBbjcyRkU4OGhLSFhyTXdmSDB0cFljU2ljM2pwOFNNTktK?=
 =?utf-8?B?U2g3YUJ5eTVNalk4dzBLK2ZRSUpIcnh2a3FQQWRXamwvbDl3Sk95S1JIR2oy?=
 =?utf-8?B?KzI2ZERWRlFZcHRnSzk1L0tJNU83OFZIUUx1OGQ5eC9DNFBXeHNFT0JOalFJ?=
 =?utf-8?B?VUxQNjlkN1grWjBhalZzb0hNTzJ0NUczYkFGU0dSeWFRNDB2R2VqSklBYzJ5?=
 =?utf-8?B?VXJPYkNIRjZJVjJlL3liUVhWcGg5REs5SkVoTmdFT2JUSVd1MkxibXNJWUZp?=
 =?utf-8?B?aXM1RmJYWURMWWlQWTlDWVVha1pXaFpwYXV0QjUyNjhuNkdFTElJdmVqMU1E?=
 =?utf-8?B?NG5mN0wrY0RWVlZmRHVTQnRGSE96dG4wQXM5cmJkSlVjcVdvYmRRVTl2TFkv?=
 =?utf-8?B?WWhBb01qb0pDYlRlRFFObDh2UzRWd1RZYitDUVZsdWpoKzBzRmJRQTljOS8v?=
 =?utf-8?B?eklhLy8vUjdIK2QwNHFVMmJZMnlrRW9hRy92S25UUkNCWEZOaGZlS3NNOFBX?=
 =?utf-8?B?VWMwQUhUMWlNQmNzN1BnRnk0c2I0NlFPZEV6TXdSTDBSUVhrZlRhVEhCL2xz?=
 =?utf-8?B?OEtZbTBEZnpBNHpzNHg1Z2VLVjhDcnBmY0NhT1RhWmpZUVRYeXlnK3JWSG9s?=
 =?utf-8?B?MmxmSEYxaXUwQ0xQUVJVdE9GOEZQZHVOZjM1UzJSYS81S1BxU3JVOVV0MEps?=
 =?utf-8?B?K0VLTENYZnE4RDZOUTRFMWRKLzhGSXY1WEpnc1owZ1hvSFBPTitERWN1TkVh?=
 =?utf-8?B?dUxmcGJ5RzB3dmpYZmhGamh3K0JuRVI1VllKMUtxN0Z0SW4rblRSSEU2emVT?=
 =?utf-8?B?WmtSNUozRnlpait1N0doWmhlSWZLTTJlMTY1L1JvUnY3NnpwMDFUaEtWd2tu?=
 =?utf-8?B?dnovVXo2ck1HMjVWcmQzVkFkM2paZDNzNmtPbGF1cHhtM1ZSM3h4aEUyRDlK?=
 =?utf-8?B?c1NTYWNWUXBkL0krdlh1Z0U2TldEVmVyaG90Z2tqck1lVmpLMFFGbWQrYUFZ?=
 =?utf-8?B?Q1RRSVhuNU53OUFzcFVrc29XakhCVjcrOFc4WkVFMmRFTGh5Rm1xZXFBUDQz?=
 =?utf-8?B?UWMvdFk2SkFhM3dYczVZSHRNL0h0ZFVldk5menFJQnJXR1Y2N0pKVi85cWtD?=
 =?utf-8?Q?y35++z/xO/aQXPxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42D732CD31D8394EBA39DB9B1661373F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zdkW2HvU+fvrxPzAA0C/L0TuUKAh67pE4my+PrQUyy6blwsdYYOAMbbGSsKkqLM7Wl8/rvSq8V/BdKqI9fV32ro7pDz5RSoeKVXlrog9ydPa96zI1KPL6JhOZMHtLi2JXo7EV+bkZfhPOH1W1D6S8b/YK7drAcocW/kuAe7150MX49plJ703A6tf26AvAPOqDkyz7Y1TBFIwpJMggJZdCNiXnNeAfXf5GAllNPJWYSvTF91zKq+DNU3nc7F1auG0ElpUT96Am6k1e4zcwvcki8euO89ocYyXwyplGO5A91lgVgK+/Soo/XYShCnd2O428Dad5cDUcwFvnKOZPk78vQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e739681-8048-4865-6bcb-08df1d4d8729
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 10:44:52.7024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkNaI60KkQtTGWUTSe5C9IWEUWzKPCdNG4jVY4ea/uvfB47Cw+QqXIYmzwETwi63kuEgezX5rTvSfmjPHIccPWNP419lYo9DhzQ538MWW/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9496
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDIzOjM0ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBJbml0aWFsaXplIEFMUE0gZm9yIERQMi4xIGFuZCBzZXBhcmF0ZSBvdXQgQUxQTSBtdXRleC1p
bml0DQo+IGZyb20gYWxwbS1pbml0Lg0KPiANCj4gdjI6IFNlcGFyYXRlIG91dCBtdXRleC1pbml0
LiBbSmFuaV0NCj4gdjM6IFJlZmFjdG9yIGZ1cnRoZXIgdG8gYXZvaWQgRElTUExBWV9WRVIgY2hl
Y2sgaW4gbXVsdGlwbGUgcGxhY2VzLg0KPiBbSmFuaV0NCj4gdjQ6IENvc21ldGljIGNoYW5nZXMu
IFtTdXJhal0NCj4gdjU6IFJlc2V0IGFscG1fZHBjZCBhbmQgc2ltcGxpZnkgc291cmNlLXN1cHBv
cnRlZCBjaGVjay4NCj4gdjY6IERyb3AgZGlzcGxheS12ZXJzaW9uIGNoZWNrIGZvciBlRFAgZm9y
IGJhY2t3YXJkIGNvbXBhdGlibGUuDQo+IA0KPiBDYzogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5o
b2dhbmRlckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBTdXJhaiBLYW5kcGFsIDxzdXJhai5r
YW5kcGFsQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVz
aC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5jIHwgOSArKysrKysrKysNCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2FscG0uaCB8IDEgKw0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZHAuY8KgwqAgfCA5ICsrKysrKystLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGluZGV4IGE2NzQzZmU2MmQ0OC4uNDgwMWZjNmJh
ZGUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Fs
cG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0K
PiBAQCAtNDMsNiArNDMsMTUgQEAgYm9vbCBpbnRlbF9hbHBtX2lzX2FscG1fYXV4X2xlc3Moc3Ry
dWN0IGludGVsX2RwDQo+ICppbnRlbF9kcCwNCj4gwqAJCShjcnRjX3N0YXRlLT5oYXNfbG9iZiAm
Jg0KPiBpbnRlbF9hbHBtX2F1eF9sZXNzX3dha2Vfc3VwcG9ydGVkKGludGVsX2RwKSk7DQo+IMKg
fQ0KPiDCoA0KPiArYm9vbCBpbnRlbF9hbHBtX3NvdXJjZV9zdXBwb3J0ZWQoc3RydWN0IGludGVs
X2Nvbm5lY3RvciAqY29ubmVjdG9yKQ0KPiArew0KPiArCXN0cnVjdCBpbnRlbF9kaXNwbGF5ICpk
aXNwbGF5ID0gdG9faW50ZWxfZGlzcGxheShjb25uZWN0b3IpOw0KPiArDQo+ICsJcmV0dXJuIChj
b25uZWN0b3ItPmJhc2UuY29ubmVjdG9yX3R5cGUgPT0NCj4gRFJNX01PREVfQ09OTkVDVE9SX0Rp
c3BsYXlQb3J0ICYmDQo+ICsJCURJU1BMQVlfVkVSKGRpc3BsYXkpID49IDM1KSB8fA0KPiArCcKg
wqDCoMKgwqDCoMKgIGNvbm5lY3Rvci0+YmFzZS5jb25uZWN0b3JfdHlwZSA9PQ0KPiBEUk1fTU9E
RV9DT05ORUNUT1JfZURQOw0KPiArfQ0KPiArDQo+IMKgYm9vbCBpbnRlbF9hbHBtX2luaXRfZHBj
ZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKQ0KPiDCoHsNCj4gwqAJdTggZHBjZDsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgNCj4gaW5kZXggNTZjM2Ux
NDgyZTM3Li45YTAyZmEzODZlZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5oDQo+IEBAIC0xNSw2ICsxNSw3IEBAIHN0cnVjdCBpbnRlbF9jb25uZWN0
b3I7DQo+IMKgc3RydWN0IGludGVsX2F0b21pY19zdGF0ZTsNCj4gwqBzdHJ1Y3QgaW50ZWxfY3J0
YzsNCj4gwqANCj4gK2Jvb2wgaW50ZWxfYWxwbV9zb3VyY2Vfc3VwcG9ydGVkKHN0cnVjdCBpbnRl
bF9jb25uZWN0b3IgKmNvbm5lY3Rvcik7DQo+IMKgYm9vbCBpbnRlbF9hbHBtX2luaXRfZHBjZChz
dHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKTsNCj4gwqB2b2lkIGludGVsX2FscG1faW5pdChzdHJ1
Y3QgaW50ZWxfZHAgKmludGVsX2RwKTsNCj4gwqBib29sIGludGVsX2FscG1fY29tcHV0ZV9wYXJh
bXMoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfZHAuYw0KPiBpbmRleCA2NTBjOGIzOTI3MGIuLmI0NzQyYmQzM2NiNCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcC5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiBAQCAtNjM1NCw2
ICs2MzU0LDcgQEAgaW50ZWxfZHBfZGV0ZWN0KHN0cnVjdCBkcm1fY29ubmVjdG9yDQo+ICpfY29u
bmVjdG9yLA0KPiDCoAkJY29ubmVjdG9yLT5kcC5wYW5lbF9yZXBsYXlfY2Fwcy5zdV9zdXBwb3J0
ID0gZmFsc2U7DQo+IMKgCQljb25uZWN0b3ItPmRwLnBhbmVsX3JlcGxheV9jYXBzLmRzY19zdXBw
b3J0ID0NCj4gwqAJCQlJTlRFTF9EUF9QQU5FTF9SRVBMQVlfRFNDX05PVF9TVVBQT1JURUQ7DQo+
ICsJCWludGVsX2RwLT5hbHBtX2RwY2QgPSAwOw0KPiDCoA0KPiDCoAkJaW50ZWxfZHBfbXN0X2Rp
c2Nvbm5lY3QoaW50ZWxfZHApOw0KPiDCoA0KPiBAQCAtNjM3Niw2ICs2Mzc3LDkgQEAgaW50ZWxf
ZHBfZGV0ZWN0KHN0cnVjdCBkcm1fY29ubmVjdG9yDQo+ICpfY29ubmVjdG9yLA0KPiDCoAlpZiAo
cmV0ID09IDEpDQo+IMKgCQljb25uZWN0b3ItPmJhc2UuZXBvY2hfY291bnRlcisrOw0KPiDCoA0K
PiArCWlmIChpbnRlbF9hbHBtX3NvdXJjZV9zdXBwb3J0ZWQoY29ubmVjdG9yKSkNCj4gKwkJaW50
ZWxfYWxwbV9pbml0X2RwY2QoaW50ZWxfZHApOw0KDQpUaGlzIGlzIGRvbmUgYWxyZWFkeSBmb3Ig
ZURQLiBZb3UgY291bGQgbWFrZSBpdCBjb25kaXRpb25hbCB0bw0KIWludGVsX2RwX2lzIGVkcC4N
Cg0KSSBhbHNvIGZvdW5kIGl0IGEgYml0IGNvbmZ1c2luZyB3aHkgYWxwbV9pbml0X2RwY2QgaXMg
Y29uZGl0aW9uYWwgdG8NCmludGVsX2FscG1fc291cmNlX3N1cHBvcnRlZCBpbiBjYXNlIG9mIERQ
IGJ1dCBub3QgaW4gY2FzZSBvZiBlRFAuIEhvdw0KYWJvdXQgbW92aW5nIGludGVsX2FscG1fc291
cmNlX3N1cHBvcnRlZCBpbiBpbnRlbF9hbHBtX2luaXQvX2RwY2Q/DQoNCkJSLA0KSm91bmkgSMO2
Z2FuZGVyDQoNCj4gKw0KPiDCoAlpZiAoIWludGVsX2RwX2lzX2VkcChpbnRlbF9kcCkpDQo+IMKg
CQlpbnRlbF9wc3JfaW5pdF9kcGNkKGludGVsX2RwLCBjb25uZWN0b3IpOw0KPiDCoA0KPiBAQCAt
NzAxOSw4ICs3MDIzLDYgQEAgc3RhdGljIGJvb2wgaW50ZWxfZWRwX2luaXRfY29ubmVjdG9yKHN0
cnVjdA0KPiBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+IMKgCSAqLw0KPiDCoAlpbnRlbF9ocGRfZW5h
YmxlX2RldGVjdGlvbihlbmNvZGVyKTsNCj4gwqANCj4gLQlpbnRlbF9hbHBtX2luaXQoaW50ZWxf
ZHApOw0KPiAtDQo+IMKgCS8qIENhY2hlIERQQ0QgYW5kIEVESUQgZm9yIGVkcC4gKi8NCj4gwqAJ
aGFzX2RwY2QgPSBpbnRlbF9lZHBfaW5pdF9kcGNkKGludGVsX2RwLCBjb25uZWN0b3IpOw0KPiDC
oA0KPiBAQCAtNzIzNSw2ICs3MjM3LDkgQEAgaW50ZWxfZHBfaW5pdF9jb25uZWN0b3Ioc3RydWN0
DQo+IGludGVsX2RpZ2l0YWxfcG9ydCAqZGlnX3BvcnQsDQo+IMKgDQo+IMKgCWludGVsX3Bzcl9p
bml0KGludGVsX2RwKTsNCj4gwqANCj4gKwlpZiAoaW50ZWxfYWxwbV9zb3VyY2Vfc3VwcG9ydGVk
KGNvbm5lY3RvcikpDQo+ICsJCWludGVsX2FscG1faW5pdChpbnRlbF9kcCk7DQo+ICsNCj4gwqAJ
cmV0dXJuIHRydWU7DQo+IMKgDQo+IMKgZmFpbDoNCg0K
