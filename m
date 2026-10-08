Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F6CCA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5162E10FC38;
	Thu,  8 Oct 2026 04:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f9t7CtmF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED3F10FC35;
 Thu,  8 Oct 2026 04:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791434453; x=1822970453;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Z+B0jYh6IHaOGpe9+dJ7mKQKGRvM2aVKpM7TIKBk4LY=;
 b=f9t7CtmFV7MIQ37T+F8U4yWDotKhH3sOfiVzhljab6UWF518hNhprdV2
 Sl2yODwzBl9awxp3b5Vrn9JuHZyzZaSPTIasbrJ+WITvz12Gm35oZuvXD
 T+yL90sYfNUfXL5k4SVq+pCBtEdxQoVe3NWyQFGxZ5leFTE4wXqzfRFoC
 KDLtptWZ4hyCGxCMDtY7dUn7sCiXU0zII/DtkIwN1i712ttLDcvlZYr8g
 ycW+dpb3FyHqBLvgJIx65kTWb0PGOYq5zNh54zjO30CwvNQNPtSo2jeYj
 dWrnaVRRLg16qEqIPi/TQu/8zjI6mT69gU1Pqll22tEUeS0Dl5EkVMeJl w==;
X-CSE-ConnectionGUID: 4KhvxyAjT02NOrqt0NUkSw==
X-CSE-MsgGUID: vdBrbluhRIyCN3Rk1OZSQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="94831"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="94831"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 21:40:52 -0700
X-CSE-ConnectionGUID: M58V4AISRiuQgGAhgkwa1A==
X-CSE-MsgGUID: J3+nPTwgQy+MHAup8qAfYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="7358"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 21:40:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 21:40:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 21:40:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 21:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8uUEsSYGN16NMTws1G7sY0f3HZ9a8+GHh67WNYHdbVROObsaf4qIrSmJe9DIeC01PrE06/cuI8E+70LBqfmSlQ4FcYSee4iEWdJFj0kFkNsRzA7mLf0HJFn+6bW8bNs+biwuoIAb82UK9P4VChEg10y9dI9HgZ3kTxsi/Sd9x3Pgq7DZITfevrES+nhbZOHj4W3t2NiyDyh/nianiQN6Yl0HoQI1YGZwH+fvZE+4ckHq230don7IMFsSinSXIW4p8u+JWawmNmQC/WIy15ujLoLE4BcC2i/lp55wn6tbaz6wuG6qc1a/U+FmG1Bf8NcqT8U/BJULumaXieKrtc19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+B0jYh6IHaOGpe9+dJ7mKQKGRvM2aVKpM7TIKBk4LY=;
 b=A/V5RCdPJiUYHOrS1dflFYNB9PHrMyVyM0g6Yyyk/U2KCqimPVBPa4d7THSVwyUEXjhc0YZknC26eoxkZwKD5k7LisvEPmC0AVyZwNnACgVTnvksGMysXNIYFsg4qeqDbBJw0/kM6LIzziKvz3xXAeI0bZ78SxSZMhjJe1aMvrOPShfM8/rbPBOgq2r7d+CTMmTIe42PIl4FjriyHU5v0H+nFLyflPWm5plYeJe/wZc93bVug5rw7NMqcp0+d4XXX79xqw1C8NLaUS1w0fSvPvr9yu4kRFC9T5r08HBz796iMCANH07kY9SLvryJ8Z67B+e6CG/Nzyu2IrRjD91ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 DS6PR11MB163730.namprd11.prod.outlook.com (2603:10b6:8:529::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 04:40:49 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 04:40:48 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 04/18] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Topic: [PATCH v6 04/18] drm/i915/alpm: Enable debugfs for DP2.1
Thread-Index: AQHdRUGGiVamVKja4kCGBKljYMs6rLbj7NGAgAS5uYCACo1SgA==
Date: Thu, 8 Oct 2026 04:40:48 +0000
Message-ID: <0ad102d6ee344517c9eb4f7abfcbb89a705cab5e.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-5-animesh.manna@intel.com>
 <337289744188eab13f37d8725002ce9dcbd4cc9f.camel@intel.com>
 <DS0PR11MB8049AF56AF4BFC89809B0E29F98A2@DS0PR11MB8049.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB8049AF56AF4BFC89809B0E29F98A2@DS0PR11MB8049.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|DS6PR11MB163730:EE_
x-ms-office365-filtering-correlation-id: 9affd955-84bf-486d-530b-08df24f65332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: H7dHm4XHMyUsPOov3yjcZ+m+QISeaqac+GTtn6DK8wNesxG7M9b1Teb0pEofq22ixWwHwvk9NIxD9Dpvf9rrrx/my3oOctXZZZBt+smeoru55R8opJkL5yhZnkzWm1+6OekDLcX4zejPpnzhG0fev2tdHTZJ1RBazhdwtR6xdkW/lDtHenTCveTFPBwjqlqeM9NvH+nTtNInbag1dl69SQ4R2LnKa2oMRJ+IEwhQtopdRL3fAhdI9mJpHiXu2fyfN7Vd17SDNc31lElpFW8dA4fvN25fPgz52CRpGKl6P1yspcbtle41PMFUfdya/ywNXt7g6iLmkS/+hpk/F8V+CVJfBJeaDrzjskfzItaG2GR7fbZeinOhBIFGMlFtH0/m+WHrV5ocf3prhXlelxG9SmJ6tpc8LPxOWg/btuZu2iHq+4bKESa0/Ugx1Cy7MhueMyj/ZqAMiD+YeK+EB5pxzi5QfO88qd8tB/nT/onYrNH8Gt5WX/yrmNIkJHafjOKbnIEhflAeNnXZDSg7tiEhG/D1zXN9/0mj9CEsZlYo5FRxlto7e3DJBR6JOxI7xCkqUVApPyCVbK0UPOddmjYkRZ4tmxbYlhrOvT5QbCEM66AzFAW0Pr51v/FyCkpF+x31yhz6zlU1ZXZ7EV9Mhd5i+mJvEEET+PDsdUkyqcd8cwmfoela4FDJwVRLzwcwECQYa8yz7o2DLPgDHpl5UPIfygrO0iWbMzzM2PkX/l7DGPI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cERMdUMwQTBlb2NOOFhaU0p0YzdCaHBYWEEwVGU2Ui9tNGp6RGhCMnZ0cVJR?=
 =?utf-8?B?VDkvWUhQaWZoN3N4T0tpcnFIRlZsNno0Mmc4K2NNbHZZcTIvTkFzUDYrbFAz?=
 =?utf-8?B?cWw2dkFKU1kzZG4rbDFuUDdFcVQ1cCtkaFF6SU5RRG5mSG90OHgzMVFlNXJS?=
 =?utf-8?B?a250VlZRdUZLSjdyRnZnZDFMdVVUUFNZOGl1SHVtUmVHT2lRRjY3SEl6cWJp?=
 =?utf-8?B?T1Q4dTAvMDVrd2U1d3J2cE9yb081NXY0NlNZczlCQnE5YnNEK1hKam9WV1ly?=
 =?utf-8?B?U2F3OFltN1kvczdPTW1rRDZXc1VYRVh6cnF1MHptZDBTRlhBUDhYV0R1YlBi?=
 =?utf-8?B?dnIrZWJORjBQQytQd2swNkJ5SjRtNWIzZ0RXUFY5emYwRWpsbklCbXJ1dEY4?=
 =?utf-8?B?UFZqOXllbU1YbWVibzQyTDluRjg5bk1BWmdMTnUrMmNSVHFhUGFNVHI4WDNh?=
 =?utf-8?B?RmpsWGpCbmpkRm9peXpwWHUzR0VVaWR4N0JOQ1BvVFlid0s1VzFDVGZ6VUtz?=
 =?utf-8?B?c1F5QWZXbkdsT3ZJMVNoRGszM1d6cVc0QklXYklBZy9ac09rZW14MFBodU1y?=
 =?utf-8?B?MHFHZnBCQkZRb2VCRVV2UXp4VHVwdm1QTXQ2UUVwK3dTODhqY09FSlVjQU1s?=
 =?utf-8?B?L2U2c21MUjhBRHF6bk1YREM5aW5hN0gzd01KYzMxemdyM0RLbDQ1QUFKSjY1?=
 =?utf-8?B?THlsTU54a3BxbUxZMnpYalhjaGVPVkdOZlBjVzA1djFzSlIrQTQwbEF1UlFv?=
 =?utf-8?B?SnhJYTh3OVpWOWkvcUFQbkNSTHUxdzQ1WTZjWDVvRkZ4SCtqQUNWc0tZOUZi?=
 =?utf-8?B?WTEybjNSempSWWlmUVFOMTg5OTVZdW1Rc1c4d0dFZXhWbnRzd1l6Q3l1NGI4?=
 =?utf-8?B?M3B6NWxQN3RXVkJiN0ZSVzZ6djVyZWJIdDBuQTJQMzZqV0RNcW13WGRqVWh4?=
 =?utf-8?B?QU5IcFUwdjgzL0hnbCtnMUF6YXNKeSsyM29XUHVKbytaYzlPa3lKbUwrK3Bo?=
 =?utf-8?B?WjJzcHJyeVV5QTBhTmZ6Z2liWnRLTmRFcWV2di8vekNLWVNBaTlLbC92Mldq?=
 =?utf-8?B?YjZQajQySmdaUk5sSzFDeTNwTVh0VUtIMWJMUnYrNVlKdjNTODRmWXcyUE5l?=
 =?utf-8?B?a0cyMTRjOTZyZy90U21FUUxINm9ZaHFkNUdkUW5qa0JxZDVrSXNJdVpuZFA1?=
 =?utf-8?B?Mi9VaHBoWEhMQ3NiN2xVekQzTzc3NlVON2JSR3BrUWt4TjNaNUx1c1VFOVpN?=
 =?utf-8?B?aVdFTkZJSUVZcGxaaUZ0ay8vNWozNjNnZk1wa1h0dHBKTlczOFpYcXNEWkEx?=
 =?utf-8?B?bnlnMU03c0hUMXluanlYR082U3pyNnBFMzZORVplSmhNbTB5enNTWDNXUnVS?=
 =?utf-8?B?L0VEczdKR2dhZGRuVFhCd2ZQMlhwYWorVWJ2TW1uSDEzN2pNNEN1a09OdUpT?=
 =?utf-8?B?M3k1N1NWVXdUaDJ4Uml6M295ZjZneFJPbjdnTGNIWUxvVHBhcFc0SkMyN2I1?=
 =?utf-8?B?QjBXd1Ntc1VpM1BTZlh3WnVkOUJvUkEzQXVDek9YUXBmT3RwVVk5Vk40NTVF?=
 =?utf-8?B?ZVoxR0JkeW51L1ZvWXduNkYvbW10a2xvWEpBNWpybU92VFRsaHN5ZHR0bTNI?=
 =?utf-8?B?ZFd3NmVCYURDcHJLQnYxRE91dmdiVzJsOVRmUUNnRU83TTIxT1NCK0NCQTZD?=
 =?utf-8?B?YkgxZ2ZHSTdhQ1l1ZVMvcFl0NExiWDNma2hrYkZzVXpBYkdDYkZ5alJWSHVq?=
 =?utf-8?B?Q3dMSlB2NFFlNVArN1QxUk9CUlo3UHNFUlZQRDNtSzNHanI1NjNlZDh1QkRB?=
 =?utf-8?B?dE5CeDZ3WjZPT0tQSTBuOTlpb1hiZDM1NndSMVA2YUlYNm10NDcwRkFPamhu?=
 =?utf-8?B?RUZEd3paME9OY3lIS0ZZdGErNzZyWkphV004dXg4dmlSYWYxZUZSUFVxM2pr?=
 =?utf-8?B?MzJWcEpVV0pRY0ZIMTlFc2MwSUJaUGdzOU5xVWRsSUZTaVByTGJTbS9EaWdv?=
 =?utf-8?B?UXhKKzFpTy9lNWRoNmM4MTl6amh1RXh6SUJUUW1DYjlHVnpJZ09qTVhuRHgy?=
 =?utf-8?B?M0FFRVpmNVBzTGQ2K1h2UGNrUThYanFOTzJ6OFo1aVJaRmJrNTdvaTh3WXV6?=
 =?utf-8?B?bzRDOEdTYUY5YkFOSFhmdFNWK0o1T2duaHlyTHRVbUVvZ05nSTd1SGJ3RWk5?=
 =?utf-8?B?Z0ozNmJJdkozbmQ2QUV1UGJxVHZoTERodEVMcEtTUG1xMU9NcWVMU3ozQWN5?=
 =?utf-8?B?VlNwZEFENGo0U04rejNsaHEvQ25SNm9vOFhTSGN4QWJEL0h0VE9jQ1BaVllG?=
 =?utf-8?B?MTVLOTRSMjRSN0NrTFNwNzJhYjVENFFpVGNLcFJxV3UzYm80UDF6MnNwOExM?=
 =?utf-8?Q?XoQYpxGf9B6utC5E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA46F1093CBD74584822BA93E0E04C1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: frgRA2XV15neVJY206FQNZvzrvChY2PYSBK+T3WcPi1aBPKqnF1A4i1N1cThRtTDw5G98tI0m+ODtooGHh7P1Nnvs9bilAZiLvBSBJsUMoV8QM6hRJIuOPRR1xniggMo4/JFkGfJW0c8hMejLRrg5uWURKQ3BNm5hDhKeJWC1SrMzavoVUKvN22QK9ox4dHu1YUHR3R9MHGnamPAT6u8whdawVp/pXkjaKsYHkNjxiTA+T53adOik7S35fuDOMOG2CbrdqQvemlPYrESEPkuh5QBZKPd9vxJrixCEuUgCUNznuJdZMGZaTWJBk6nvWGvLFEqz6/blApfPjM+Fd99oQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9affd955-84bf-486d-530b-08df24f65332
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 04:40:48.5711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UF2/EdJj8/xK8rpfg9nILmoR91xUgH8hq3Pps78Zq3GRt6r88ySvm3y68+80mVAjL3oN+eABLKsUz0QzUWLxs4D0EG9B5mwFjl0G0dPgX1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB163730
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

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDExOjMyICswMDAwLCBNYW5uYSwgQW5pbWVzaCB3cm90ZToN
Cj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogSG9nYW5k
ZXIsIEpvdW5pIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBT
ZXB0ZW1iZXIgMjgsIDIwMjYgNDo1MyBQTQ0KPiA+IFRvOiBpbnRlbC14ZUBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7DQo+ID4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWFubmEsDQo+
ID4gQW5pbWVzaCA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+OyBpbnRlbC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+ID4gQ2M6IEthbmRwYWwsIFN1cmFqIDxzdXJhai5rYW5kcGFsQGludGVs
LmNvbT47IE5pa3VsYSwgSmFuaQ0KPiA+IDxqYW5pLm5pa3VsYUBpbnRlbC5jb20+DQo+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NiAwNC8xOF0gZHJtL2k5MTUvYWxwbTogRW5hYmxlIGRlYnVnZnMg
Zm9yDQo+ID4gRFAyLjENCj4gPiANCj4gPiBPbiBUdWUsIDIwMjYtMDktMTUgYXQgMjM6MzQgKzA1
MzAsIEFuaW1lc2ggTWFubmEgd3JvdGU6DQo+ID4gPiBFbmFibGUgQUxQTSBkZWJ1ZyBpbmZvIHRo
cm91Z2ggbG9iZiBkZWJ1ZyBpbmZvLg0KPiA+ID4gDQo+ID4gPiB2MjogY29zbWV0aWMgY2hhbmdl
LiBbU3VyYWpdDQo+ID4gPiB2MzogVXNlIGNvbW1vbiBhcGkgaW5zdGVhZCBvZiBESVNQTEFZX1ZF
UiBjaGVjayBpbiBtdWx0aXBsZQ0KPiA+ID4gcGxhY2VzLg0KPiA+ID4gW0phbmldDQo+ID4gPiB2
NDogQWRkIGRpc3BsYXktdmVyc2lvbiBjaGVjayBhcyBpdCBkcm9wcGVkIGZvciBFRFAuDQo+ID4g
PiANCj4gPiA+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4N
Cj4gPiA+IFJldmlld2VkLWJ5OiBTdXJhaiBLYW5kcGFsIDxzdXJhai5rYW5kcGFsQGludGVsLmNv
bT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50
ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfYWxwbS5jIHwgNiArKysrLS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gPiBpbmRleCA0ODAxZmM2YmFkZTIu
LjkwMTQ5M2JiMTQ0OCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX2FscG0uYw0KPiA+ID4gQEAgLTczOSw4ICs3MzksMTAgQEAgdm9pZCBpbnRlbF9h
bHBtX2xvYmZfZGVidWdmc19hZGQoc3RydWN0DQo+ID4gPiBpbnRlbF9jb25uZWN0b3IgKmNvbm5l
Y3RvcikNCj4gPiA+IMKgCXN0cnVjdCBpbnRlbF9kaXNwbGF5ICpkaXNwbGF5ID0NCj4gPiA+IHRv
X2ludGVsX2Rpc3BsYXkoY29ubmVjdG9yKTsNCj4gPiA+IMKgCXN0cnVjdCBkZW50cnkgKnJvb3Qg
PSBjb25uZWN0b3ItPmJhc2UuZGVidWdmc19lbnRyeTsNCj4gPiA+IA0KPiA+ID4gLQlpZiAoRElT
UExBWV9WRVIoZGlzcGxheSkgPCAyMCB8fA0KPiA+ID4gLQnCoMKgwqAgY29ubmVjdG9yLT5iYXNl
LmNvbm5lY3Rvcl90eXBlICE9DQo+ID4gPiBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KPiA+ID4g
KwlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPCAyMCkNCj4gPiA+ICsJCXJldHVybjsNCj4gPiA+
ICsNCj4gPiA+ICsJaWYgKCFpbnRlbF9hbHBtX3NvdXJjZV9zdXBwb3J0ZWQoY29ubmVjdG9yKSkN
Cj4gPiA+IMKgCQlyZXR1cm47DQo+ID4gPiANCj4gPiA+IMKgCWRlYnVnZnNfY3JlYXRlX2ZpbGUo
Imk5MTVfZWRwX2xvYmZfZGVidWciLCAwNjQ0LCByb290LA0KPiA+IA0KPiA+IFRoZXNlIGFyZSBu
YW1lZCBhcyBpOTE1X2VkcF9sb2JmX2RlYnVnIGV2ZW4gaWYgdGhleSBhcmUgY3JlYXRlZCBvbg0K
PiA+IERQDQo+ID4gY29ubmVjdG9yLg0KPiANCj4gV2UgaGF2ZSBjb3VwbGUgb2Ygb3B0aW9ucywN
Cj4gaSkgcmVuYW1lIHRvIGk5MTVfbG9iZl9kZWJ1ZywgYnV0IGJhY2t3YXJkIGNvbXBhdGliaWxp
dHkgd2lsbCBiZQ0KPiBicm9rZW4uDQo+IGlpKSBjcmVhdGUgYSBuZXcgZGVidWdmcyBmb3IgZHAg
LSBpOTE1X2RwX2xvYmZfZGVidWcuIENvZGUNCj4gZHVwbGljYXRpb24gd2lsbCBiZSB0aGVyZS4N
Cj4gaWkpIGFzIExPQkYgaW50cm9kdWNlZCBmaXJzdCBvbiBlZHAgdG8gc28gRFAgd2lsbCB1c2Ug
ZXhpc3RpbmcgZWRwLQ0KPiBpbnRlcmZhY2UuIA0KPiANCj4gR29vZCB0byBrbm93IHlvdXIgb3Bp
bmlvbiwgSSBzZWUgYWxsIHRoZXNlIG9wdGlvbnMgaGF2ZSBwcm9zIGFuZA0KPiBjb25zLg0KDQpJ
IHdvdWxkIHZvdGUgZm9yIG5hbWluZyBib3RoIGFzIGk5MTVfbG9iZl9kZWJ1Zy4gRFAvZURQIGlz
IGFscmVhZHkgaW4NCmNvbm5lY3RvciBwYXRoLiBDb2RlIChJR1QgaW4gcHJhY3RpY2UpIGNvdWxk
IGZpcnN0IHRyeSBuZXcgaW50ZXJmYWNlDQphbmQgdGhlbiBpZiBub3QgZm91bmQgdHJ5IG9sZCBu
YW1pbmcuDQoNCkJSLA0KSm91bmkgSMO2Z2FuZGVyDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEFuaW1l
c2ggDQo+ID4gDQo+ID4gQlIsDQo+ID4gSm91bmkgSMO2Z2FuZGVyDQo+IA0KDQo=
