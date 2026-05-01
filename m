Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBBDFF886F
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 00:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B67310E4C0;
	Fri,  1 May 2026 00:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LlTKMe5Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2EE10E4C0;
 Fri,  1 May 2026 00:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777596668; x=1809132668;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9+D9FB9s+ZjGpZuQumoEm7h8ERw59r2vJsR0Rrwho9o=;
 b=LlTKMe5QZ2LNXcppB31v2RoNy6YcgN4Nf6k2V6hlav9VC7PmpFSx+mv6
 9d56Wk6nZ6Ktl51KqjTeSATwndqk0lLRTS4Wz2RrvLWYs3QV9J1MbQfWG
 OpNH00KyuxdQxkTokbf/lJSHqgn52+RZFsXj+xDm4SxxovhDFIaGEtWKe
 37vr2GeZhjLwhPzsvYKiG/trQ3MVbJGZ113vTrwzzZv3slLNbf6yZ3Ypp
 D6YAc4Z/KmGc/h+3o4Q93oHsU0UFjQsrBTjqf3e8/dd1UpGnlwigUPQEI
 P+1i8a6Fr/96cDGbIqRoJqlIUpSj33F2HWmIMxCKcm7dVMU42HBO1HkWR Q==;
X-CSE-ConnectionGUID: TM4MZs2kSvKqj2/P1hVBuA==
X-CSE-MsgGUID: Hob+NdZOT/GTTb8ec5xQ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="66099714"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="66099714"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 17:51:04 -0700
X-CSE-ConnectionGUID: iHeVcYXBRBy1pi3kkD/S/w==
X-CSE-MsgGUID: KAsV6F/eTeyMTB0p6QdGLA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 17:51:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 17:51:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 17:51:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 17:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbyU/14dwS9VdCQA5tJ+ixyn1Axo1hzuL7k3WOhpBGRVjwLC3QqsnKZLWmSb6sJDFNh/k4oxe0ymsD+3pCGAgwYaT6mhddv1HZnhESk5zU++enaeHWHTUH/WY6S12sCUyQ458fEhCKxxhU/An/yopLuYTCKm/Hq3ePdBnGrtU3gYHb/yx4SgPt/WNpX46tVrp5ncEEQsYFTUsyw1yNpQ5Ss9NI1KUW7r/jN/NPii088ng4NGRYzgqIVs3Zjqzj9SBEWQvt4+EEJ/rrVoBXIMfsgcPy/M9iZzOQBJ2YzEH+meZ6q5YAynx12g35AkhsPDmbE0Vyj1bAB25EXV2mKgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+D9FB9s+ZjGpZuQumoEm7h8ERw59r2vJsR0Rrwho9o=;
 b=EpBnh88TCdQPOz/1qoAvYlzk0HW+S8dfuzI0rUaZn6dJKmy5cQcdXmmNdVvw+jnX85CWlNIfVl518QWr9Tx8wGAeKOxj+/EfvgIEZ5uL2umVizdB0a4rT6mEhg3dVSBdMyI3PKvD+Anp86qlwrg644goBSL6sm9QbJR9ePRzC7zXapmEoVQXriyLI5tv2OoVoT78BS+BbOZ6IwIihj2ReXaCEsS17vepixY1yTSwkqSZGoC73fEku3bz2Mo49iq+PrBcdNR5fPgmjnwSwTeXa7n0nWRF/O+wjf7fWwfU7Si4hq70Sc6qFnIEDEYcviDg+5oAC4zOPqd/yFZUVUtOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19)
 by LVUPR11MB9786.namprd11.prod.outlook.com (2603:10b6:408:39c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Fri, 1 May
 2026 00:50:59 +0000
Received: from CY5PR11MB6283.namprd11.prod.outlook.com
 ([fe80::fa60:e858:a245:4901]) by CY5PR11MB6283.namprd11.prod.outlook.com
 ([fe80::fa60:e858:a245:4901%5]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 00:50:59 +0000
From: "Santa, Carlos" <carlos.santa@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Brost, 
 Matthew" <matthew.brost@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "david@kernel.org"
 <david@kernel.org>, "surenb@google.com" <surenb@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "ljs@kernel.org" <ljs@kernel.org>, "vbabka@kernel.org" <vbabka@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>
Subject: Re: [PATCH v4 2/6] mm: Introduce zone_maybe_fragmented_in_shrinker()
Thread-Topic: [PATCH v4 2/6] mm: Introduce zone_maybe_fragmented_in_shrinker()
Thread-Index: AQHc2NYrwNSnOfWXSEquYFhK04QrFLX4V3YA
Date: Fri, 1 May 2026 00:50:58 +0000
Message-ID: <63cfdaec94fdbc6620846d98a47c18c0dfe3bc3e.camel@intel.com>
References: <20260430191809.2142544-1-matthew.brost@intel.com>
 <20260430191809.2142544-3-matthew.brost@intel.com>
In-Reply-To: <20260430191809.2142544-3-matthew.brost@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6283:EE_|LVUPR11MB9786:EE_
x-ms-office365-filtering-correlation-id: 4cc6832f-4939-4d1d-6dbb-08dea71bb5d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: CuUXI9vD693CJb1bYOeZNh+B+Ja65dvuN7di8bMqe/crSYqVpTZWugAFmsQzt91BaWaZ5/sNH+WLTwzWqLFUF26wS/fOmfPEgeUHqw8MpaVxd7BBgicPJWPnZsNUFF2IiaFBmhBTT5jeUmwtZXN8g9U19v09V1HtJ2IhHlU5fBpKH4aKaqBfjR3vu1yaJdEyDFfG49rpNixp67dve7s0+/D6QiFWjIiB6VcGSWnNOQE7ZbbqIhtN19oIBcTMFd8qzP8yg2ZrsnX4HI29xMHXq347eFZcMy0g9IhKfbp2raaOCBE4zInkwyTrP0ELo7LM8gYU+LpFZMhhBddK7cA6AZjUR9gJTDIjTUFYYcJ2vl9rrKMDf6AwrAPUfWr04iNgMbdkybcEskhzxwQ+asexszgT0JnVhfA5heYxdlEztCeczVVoS1gxwkGV7Sww3x/FEg6vLJ1uhzPfAuJctXhpdj2I1zR3M8DzT3DZ84gR1ymF7CGGsY60WVDuSqjtfkGM8WJ6Vp0/RQM+r11R6KNpZQ13x5H0BTCp98JbM+XsaxUSKM78BtaRANtWMCqSFbZSunLuQ1UiDiaWaOCkKVDFFuhfRIuuOjHfiQpboRQO/35aUvLQNEgLp0WA1yUBsvfBflX7tJidQfMK6uCz/JV5sRHefVJNHrCJdg8/4y5qH4W43D7npBwGHuRgW0YE4Po7mUaWKsHMHoOpI13KQ+ct7v1lMk0wMyAkNK2ct/W+iLc6ZYfcpM1NhZeZ/xW1xCDv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6283.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzF2RDFvS3YzcWx1ek50am5GTXk1OG93cTR2aXlHcUFUaWpvZlZnT1VYLzRQ?=
 =?utf-8?B?NzkrNzNNaThuVmtuWjBvNDlxUXJVWFB2QVdVcVloeTAwM0E4d1JrK2JTL2NF?=
 =?utf-8?B?cVM4RVVPWmlDYXl5NmVqb2tpYXM4bGR5VHVleGZhUHFrQi9IaEFqaHVzc2o3?=
 =?utf-8?B?R1J2SzZKaHhpTTRoVjd1T3pyY0FCeHNFWmRhWkdoWkZDK2xxcFBKTWlEemtk?=
 =?utf-8?B?NmcySnY1bHRoV1d5Zkt4OVplckRCN0dIL0JteFNEeXU5U25DMis1ZXlzSEVI?=
 =?utf-8?B?Y0dGOFpQS1V4Z3ZXMFROc1JMdFNsbGNqRjZoM1RHekpJZjhVcXRTcVRSVnZV?=
 =?utf-8?B?OVVkTHZmV3RoSVFvZnptRGNxeGhhc3FJT3A0TktSVW5OSjI0b1E0VDd6NGk5?=
 =?utf-8?B?YTNRQkZ1MUQ1VGhUY1QvblNCVWJoVTV0NlBjWjhobXJkNjJXblRwTmM3SThr?=
 =?utf-8?B?cVBVc1NvZjdwazZtVi9oN3lGUzVSbmhkRzhsaG9HZHBwc0lOWGpMMWd5akhI?=
 =?utf-8?B?S3RxOFo4Z3ZweThkODdDYmVTZUdtakdHcUJSajJhQ3I5dU44d1pYemgvdjNJ?=
 =?utf-8?B?c1FFYjA0T1o0bW9aRkVlMEdSVm53VWRrTWRwZXdndWtUK2Jqc1NDYWdGYVJh?=
 =?utf-8?B?OVdGK3Q2eFdncGdSMFE5Q2daVXhBTG5nMjNWYnVKWGp0a0JFclVSTWxlS1dv?=
 =?utf-8?B?UG1JaXkzNDJja1hhbUZWWFhuQktJRFp1c1VTNEd2N2RKNW1wQit2bDcxY2ps?=
 =?utf-8?B?aFRRNENQclh3eDNzSVdTK2FFbm9BY2RqM2hIWHJpN0NkVWlDUUNzTHRHMFZZ?=
 =?utf-8?B?OS8yY2hoaXFoVWdld3hFOGdWdWZqelV4eUl1Nnl2NDIyS3pTM3FFZnZpa05F?=
 =?utf-8?B?bkZnbVo3a21kUGIrUjgya2xxV1NTYnBiTTRidjdFMnozUDdWbW9MRzY0ekhM?=
 =?utf-8?B?ekV0dXVMb2JqaThxVkY1eEI1N3lXYXJUMGMxcDZ0dGRUNFNsRThuN1piczY1?=
 =?utf-8?B?OU9oUDh4VUJUVGIrR2Y3TVh3a2ZJaFFqVVo2WjZrOWM2ZGhkdTBSaWhjejN5?=
 =?utf-8?B?RW1oSHNtYmUxQ1RlTlpOdEVYeUxIZEh6Mkw3RnFpUmoyVW80bFdhTW1VTzIz?=
 =?utf-8?B?RUhKNWt0Y3VqLzZCQ1VTTEVMcEpZelJyak9NeUpLY3E4QjhyWTAyUjZIdnhW?=
 =?utf-8?B?SkVBaW1DODdkY1BFMkswVVZ5QUcwY2cxK2xKRWgxRzRqOVEzRmxobzI5Wkgr?=
 =?utf-8?B?MWlyemh6VTJuaTNZMXIrcVZOb1MxQ2JUMmNSdGhIY1VoaWZjUlh0b1hDbnBw?=
 =?utf-8?B?THVXSGg2NjFFUGxJd2VGT1dhUjMwa29BZEFjWmNaNGhZKy9yOWZiMW1FcVRn?=
 =?utf-8?B?cDNPNkJ5NFh4N3ovUDIydFV2cEd6R1pzVFdsN2FSK1Q1YWdiNXJrekEyTmVU?=
 =?utf-8?B?Y0xNTDI3Z0RKaVM2akkvRXJrVXcwcVZaNVJGdllQNk5xbnN6dmY5c0ZaV0dH?=
 =?utf-8?B?UVNzY2ZsVC9kSklsUlVlZ0hoYXA2UDdNSVRpSFB2ek5EODFkN1kyT1ZXeUxN?=
 =?utf-8?B?Y1JESUdMaGRVVFFVcG4vZnR0SElVZDBTOHkvN2NwTm5uU0RCMndlODNwcSty?=
 =?utf-8?B?L3N5OHVSclhOdkNzaGRLRjVncDN6MDRrRjUyZm9YNThGUmZXVklpcTR3U3dq?=
 =?utf-8?B?cTZ2SXA4TWNkV3dRY2svL0x2M2lCcUgwMTU1a1VqdW13T25yTlFLUTh2aUNO?=
 =?utf-8?B?OVppYmhmMXo4cDJUb1pRK0ExbW9ycjdlaG5oS1FGTHFvQXJxd2k5K0FydWRE?=
 =?utf-8?B?MTRpcmcrWFZZMDN2U0l1S3RRRm43ZENtd2xjT004MTZaZmRvSzFqYmpYcjhF?=
 =?utf-8?B?YnpJTzRYay9Md3N3L2VTUjV4QjR1aEdOc3puM3ZHa3h0SExZaWZ0SU1pdnNE?=
 =?utf-8?B?QXNTcnhMQzVZVlppbk5INGNma0pNajY1TjNyS0RUTk1VWnkxTGRFZkRaWXpU?=
 =?utf-8?B?NlVaQmFKdlhFSkQzUncxT1hkejhTaUtJUkRyQ3ppODlvUjhadkhycllkcWNF?=
 =?utf-8?B?MURIRzJPNnpMRCt1dDZvRzZ5bE1IUkRyTXpGb21IeXhGbUJsNWYvRkI5a3JR?=
 =?utf-8?B?QlM5Q0lRMStNb292cGhsbG1FYWY4eVlGM1pUc2g0bDluenNaWGc3UWxkOFRM?=
 =?utf-8?B?QllzSFBvNUhSQm1TNnZ6NUFVMWdZVlhSdDg1amh1UkVLaU03eGhQbllZMFdo?=
 =?utf-8?B?ekV4OGlrTnRITHNjSS91RFRNNnAvZTBHRVVtZFljbUhmdkhwUFZ0RnNrbjBU?=
 =?utf-8?B?TnRBNGlFbXk5WHRNc3BiRVR5WENEb0twaU4yVVY0MVFtV2tqcjNEMExLYnV1?=
 =?utf-8?Q?7wRYs7RR4Nx9u3Pw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B8BE2B914562409720674A53538627@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PmtGepIeWKdohws2atJwu85ix4bh0nQHpaCqdvLZYQqapLQ7H4qezwRIAMtErwuJWeq+bbJDNkq/n3/H+qUzbe8inzos727TEaouVO27U8WPe1vNjkC75v6oc6FBoJaXbrc3yk3TsIlLfVpgkwnMyD9bfw+keFjXmrUkr1/aHbPHGI3w7UiuQ+vOOtF4Id3EULa1hKjUpElMYDi8oZLd4YBpmaDRLnzXUa2nu9keg+wIlrPHSAt8M7k6UkFqPHk/wGP/7/i+h+daPF0ssahuccaI0WxdUvFfmFBENYoH7AFea0nKSc4V3n4CxUX71cGCtPP1DssEM9XN49QoV2c8lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc6832f-4939-4d1d-6dbb-08dea71bb5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 00:50:58.9310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiAo+PmSD6TKHLvxDMxHQ0UZIQkFFNUXTWMGZVlfGJcPd7LwQ5grarTUT3S7/hBBTMHkQ+M8iMpmDUsAGmXDKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9786
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

T24gVGh1LCAyMDI2LTA0LTMwIGF0IDEyOjE4IC0wNzAwLCBNYXR0aGV3IEJyb3N0IHdyb3RlOg0K
PiBJbnRyb2R1Y2Ugem9uZV9tYXliZV9mcmFnbWVudGVkX2luX3Nocmlua2VyKCkgYXMgYSBsaWdo
dHdlaWdodCBoZWxwZXINCj4gdG8NCj4gYWxsb3cgc3Vic3lzdGVtcyB0byBtYWtlIGNvYXJzZSBk
ZWNpc2lvbnMgYWJvdXQgcmVjbGFpbSBiZWhhdmlvciBpbg0KPiB0aGUNCj4gcHJlc2VuY2Ugb2Yg
bGlrZWx5IGZyYWdtZW50YXRpb24uDQo+IA0KPiBUaGUgaGVscGVyIGltcGxlbWVudHMgYSBzaW1w
bGUgaGV1cmlzdGljOiBpZiB0aGUgbnVtYmVyIG9mIGZyZWUgcGFnZXMNCj4gaW4gYSB6b25lIGV4
Y2VlZHMgdHdpY2UgdGhlIGhpZ2ggd2F0ZXJtYXJrLCB0aGUgem9uZSBpcyBjb25zaWRlcmVkIHRv
DQo+IGhhdmUgYW1wbGUgZnJlZSBtZW1vcnkgYW5kIGFsbG9jYXRpb24gZmFpbHVyZXMgYXJlIG1v
cmUgbGlrZWx5IGR1ZSB0bw0KPiBmcmFnbWVudGF0aW9uIHRoYW4gb3ZlcmFsbCBtZW1vcnkgcHJl
c3N1cmUuDQo+IA0KPiBUaGlzIGlzIGludGVudGlvbmFsbHkgaW1wcmVjaXNlIGFuZCBpcyBub3Qg
bWVhbnQgdG8gcmVwbGFjZSB0aGUgY29yZQ0KPiBNTSBjb21wYWN0aW9uIG9yIGZyYWdtZW50YXRp
b24gYWNjb3VudGluZyBsb2dpYy4gSW5zdGVhZCwgaXQgcHJvdmlkZXMNCj4gYSBjaGVhcCBzaWdu
YWwgZm9yIGNhbGxlcnMgKGUuZy4sIHNocmlua2VycykgdGhhdCB3aXNoIHRvIGF2b2lkDQo+IG92
ZXJseSBhZ2dyZXNzaXZlIHJlY2xhaW0gd2hlbiBzdWZmaWNpZW50IGZyZWUgbWVtb3J5IGV4aXN0
cyBidXQNCj4gaGlnaC1vcmRlciBhbGxvY2F0aW9ucyBtYXkgc3RpbGwgZmFpbC4NCj4gDQo+IE5v
IGZ1bmN0aW9uYWwgY2hhbmdlczsgdGhpcyBpcyBhIHByZXBhcmF0b3J5IGhlbHBlciBmb3IgZnV0
dXJlIHVzZXJzLg0KPiANCj4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9t
QGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRh
dGlvbi5vcmc+DQo+IENjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAa2VybmVsLm9yZz4NCj4g
Q2M6IExvcmVuem8gU3RvYWtlcyA8bGpzQGtlcm5lbC5vcmc+DQo+IENjOiAiTGlhbSBSLiBIb3ds
ZXR0IiA8TGlhbS5Ib3dsZXR0QG9yYWNsZS5jb20+DQo+IENjOiBWbGFzdGltaWwgQmFia2EgPHZi
YWJrYUBrZXJuZWwub3JnPg0KPiBDYzogTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPg0K
PiBDYzogU3VyZW4gQmFnaGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4NCj4gQ2M6IE1pY2hh
bCBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPg0KPiBDYzogbGludXgtbW1Aa3ZhY2sub3JnDQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcg
QnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPg0KPiANCj4gLS0tDQo+IA0KPiB2Mzogcy96
b25lX2FwcGVhcl9mcmFnbWVudGVkL3pvbmVfbWF5YmVfZnJhZ21lbnRlZF9pbl9zaHJpbmtlciAo
RGF2aWQNCj4gwqDCoMKgIEhpbGRlbmJyYW5kKQ0KPiAtLS0NCj4gwqBpbmNsdWRlL2xpbnV4L3Zt
c3RhdC5oIHwgMTIgKysrKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Ztc3RhdC5oIGIvaW5jbHVk
ZS9saW51eC92bXN0YXQuaA0KPiBpbmRleCAzYzljMjY2Y2Y3ODIuLjFhZDQ4ZjcwYzlkOSAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC92bXN0YXQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4
L3Ztc3RhdC5oDQo+IEBAIC00ODMsNiArNDgzLDE4IEBAIHN0YXRpYyBpbmxpbmUgY29uc3QgY2hh
ciAqem9uZV9zdGF0X25hbWUoZW51bQ0KPiB6b25lX3N0YXRfaXRlbSBpdGVtKQ0KPiDCoAlyZXR1
cm4gdm1zdGF0X3RleHRbaXRlbV07DQo+IMKgfQ0KPiDCoA0KDQpvbiB0aGUgYmVsb3cgaGV1cmlz
dGljLCBJIHdhcyB0aGlua2luZyBvZiB0aGUgZm9sbG93aW5nIGNhc2U6IGEgbGFyZ2UNCm1lbW9y
eSBzeXN0ZW0gKHNheSAxNkcsIDMyRyksIGhlYXZpbHkgZnJhZ21lbnRlZCAoZm9yIHdoYXRldmVy
IHJlYXNvbikNCmJ1dCBjb25zdHJhaW50IGJ5IHRoZSBJT01NVSByZXF1aXJpbmcgbGFyZ2UgcGFn
ZXMgZHVlIHRvIGh3IGFsaWdubWVudCwNCmlmIEkgYW0gbm90IG1pc3Rha2VuIHRoZSBiZWxvdyBj
aGVjayB3aWxsIGNhdXNlIHRoZSBzaHJpbmtlciB0byBiYWlsDQpvdXQgdG9vICdlYXJseScgc2lu
Y2UgdGhlIHRoZXJlJ3MgcGxlbnR5IG9mIGF2YWlsYWJsZSBtZW1vcnkgYnV0IG5vbmUNCm9mIHRo
YXQgaXMgY29udGlndW91cywgdGhlbiBlbmQgcmVzdWx0IHNob3VsZCBiZSBnaXZpbmcgYmFjayBz
bWFsbA0KcGFnZXMgd2hpY2ggc2hvdWxkIHJlZHVjZSBwZXJmb3JtYW5jZSwgcmlnaHQ/DQoNCmJl
bG93IGFyZSBzb21lIG1hZGUgdXAgbnVtYmVyczoNCg0KDQpNZXRyaWMgICAgICAgICAgfCA4R0Ig
ICAgICAgICAgICAgICB8IDE2R0INCi0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0t
LXwtLS0tLS0tLS0tLS0tLS0tLS0tDQpIaWdoIFdtYXJrICAgICAgfCB+NDVNQiAoMTFrIHBncykg
ICB8IH45ME1CICgyM2sgcGdzKQ0KQmFpbCBHYXRlICgyeCkgIHwgfjkwTUIgKDIyayBwZ3MpICAg
fCB+MTgwTUIgKDQ2ayBwZ3MpDQpGcmVlIFJBTSAgICAgICAgfCAxMjBNQiAgICAgICAgICAgICB8
IDcxMDBNQiAoNy4xR0IpDQpTaHJpbmtlciAgICAgICAgfCBSVU5TIChGcmVlPEdhdGUpICB8IEJB
SUxTIChGcmVlPkdhdGUpDQpPdXRjb21lICAgICAgICAgfCBNZXJnZXMgMk1CIGJsb2NrcyB8IDRL
QiBwYWdlcw0KDQpJbiBvdGhlciB3b3JkcywgcmVwbGFjaW5nIHRoZSBjaGVjayB3aXRoIG51bWJl
cnM6DQoNClN5c3RlbSAgICAgICB8IEZyZWUgUkFNIChQYWdlcykgfCBHYXRlIChQYWdlcykgfCBG
cmVlIDwgR2F0ZT8gfCBSZXN1bHQNCi0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0tLS0tfC0t
LS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tfC0tLS0tLS0NCjhHQiAgICAgICAgICB8IDIwLDQ4
MCAoODBNQikgICAgfCAyMiw5NDYgICAgICAgfCAyMDQ4MCA8IDIyOTQ2fCBSVU5TDQoxNkdCICAg
ICAgICAgfCAxLDgzMiw3NDAgKDcuMUcpIHwgNDUsODk0ICAgICAgIHwgMS44TSA8IDQ1az8gIHwg
QkFJTFMNCg0KDQpDYXJsb3MNCg0KPiArc3RhdGljIGlubGluZSBib29sIHpvbmVfbWF5YmVfZnJh
Z21lbnRlZF9pbl9zaHJpbmtlcihzdHJ1Y3Qgem9uZQ0KPiAqem9uZSkNCj4gK3sNCj4gKwkvKg0K
PiArCSAqIFNpbXBsZSBoZXVyaXN0aWM6IGlmIHRoZSBudW1iZXIgb2YgZnJlZSBwYWdlcyBpcyBt
b3JlDQo+IHRoYW4gdHdpY2UgdGhlDQo+ICsJICogaGlnaCB3YXRlcm1hcmssIHRoaXMgbWF5IHN1
Z2dlc3QgdGhhdCB0aGUgem9uZSBpcyBoZWF2aWx5DQo+IGZyYWdtZW50ZWQuDQo+ICsJICogV2hl
biBjYWxsZWQgZnJvbSBhIHNocmlua2VyLCBhZ2dyZXNzaXZlbHkgZXZpY3RpbmcgbWVtb3J5DQo+
IGluIHRoaXMgY2FzZQ0KPiArCSAqIG1heSBkbyBtb3JlIGhhcm0gdG8gb3ZlcmFsbCBzeXN0ZW0g
cGVyZm9ybWFuY2UgdGhhbiBnb29kLg0KPiArCSAqLw0KPiArCXJldHVybiB6b25lX3BhZ2Vfc3Rh
dGUoem9uZSwgTlJfRlJFRV9QQUdFUykgPg0KPiArCQloaWdoX3dtYXJrX3BhZ2VzKHpvbmUpICog
MjsNCj4gK30NCj4gKw0KPiDCoCNpZmRlZiBDT05GSUdfTlVNQQ0KPiDCoHN0YXRpYyBpbmxpbmUg
Y29uc3QgY2hhciAqbnVtYV9zdGF0X25hbWUoZW51bSBudW1hX3N0YXRfaXRlbSBpdGVtKQ0KPiDC
oHsNCg0K
