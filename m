Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3DDCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AED10ECE1;
	Tue, 29 Sep 2026 05:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LoOqT3b4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354DE10E9B3;
 Tue, 29 Sep 2026 05:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790660326; x=1822196326;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CbcjeBhOorfSLAQNQFQnu/09ofcWdUhGPDl04Hji1rk=;
 b=LoOqT3b4UQehTtoyWplOn0OK4YgVODGPtRgN6mD07AEnKRv7QirnoWIP
 X1agkWlA/yaZR5OK99i1iBfi2wwYeixc/mG6C527dT+ZIANRcyJgluBf+
 y9xpW90piqdDqUqODGiBird2eFc68MbSaCd8h9MFSVuievW4Q0QUFt8p1
 8ajsnF64dAa2++wuckiygPl8mNcRDlVdg7gdF4TmkAVQqGHKHPDvyipuG
 4OU0J845gA/h1EA0Q0KgOyHJXPFAiKplMRzGz8OcvklXNUHRipB/AMw7K
 eLc6B7lvup7xSIJl5C5dZDGs4NzF0Q1Xq+eziEcJ0M7a9Gn8lTMVbj8WM A==;
X-CSE-ConnectionGUID: tO/1wLKGSD2gDGfNdVSM/Q==
X-CSE-MsgGUID: EY1awANYSJS85fbSA22/Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90588846"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; d="scan'208";a="90588846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 22:38:45 -0700
X-CSE-ConnectionGUID: rdnuT5Q1S8+lsYkQ8regxg==
X-CSE-MsgGUID: zQ1JN5KsRAea2noyWikHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; d="scan'208";a="273881960"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 22:38:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 22:38:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 22:38:45 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 22:38:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc402aoo/k15g/5kXfea2Zh98gqSzCPx5Nrjtdteonp4udy73Nz3mE0YljXEvbfKjCo9PDzBslgxzKa6PygiI6upoQvKdMZnJ6Qdt3gC4zQNxg2bjDA8Oeek6Fdoq6k6QdO8p+tYaZcPnP6xlct7EBOr2XaNKQzlsoxma4k5QAWWqaoMIH/06ilnnmfJtyEd1GmuVNjAzNTpmICztepMu2Euu6GxfN3Btmv229jpqdiTrz+TPt9SBkNr/k+Fax52VyVuLCPtCJjTe7k8Vbv/mi8HYOSdn2jSFQbkUjbN7qPaYP5JgP2zZWBCvQDkJo6zsc/bPgKkkJPH8IN2N9xZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbcjeBhOorfSLAQNQFQnu/09ofcWdUhGPDl04Hji1rk=;
 b=GfXc+V8F4OF+rWPakdyzlgHQpXL7eC33K16/5p3QcZTSsQemG1KG66XUrHjb7YzZsg7Ay1Dkeu7fJ9G7EQwzt/WIbNHxgS1ub/9tR/9D73fvPP8TOfHumn5++KHTk8Xc/HeaQvv3rL0uuRNxgUV2eNWScA6ro329jWZbIqS0tFIKe/VW8SrAb2MBkhGWq0cfAyCMmt6z6KnI8/C9ZmOGh67EoCTwQjrfdRh8Qjl9XAWwlbl5XhDreknbEigxaneRB2/MredxP7vKpKWWq2611uDdDiTYw/YBut9I4hx13Tx+L5LWUzFZSA/fokD9eUSviY9Lk8wI9aanuPDWQiENtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 05:38:42 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 05:38:42 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 06/18] drm/i915/alpm: Auxless wake time calculation for
 Xe3p
Thread-Topic: [PATCH v6 06/18] drm/i915/alpm: Auxless wake time calculation
 for Xe3p
Thread-Index: AQHdRUGLXN+a1tuO00KSxdTokGiymLblHw0A
Date: Tue, 29 Sep 2026 05:38:42 +0000
Message-ID: <684a65c9a5bc6d76462c7d9f84a367fa710602cb.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-7-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-7-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|SJ0PR11MB5200:EE_
x-ms-office365-filtering-correlation-id: 32042d44-dbdf-4592-8377-08df1debec14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|260925021911599003|3023799007|260925022911599003|260925021311599003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: Ub0y+O4vuZbp4e1+ziFzU8VNIdX49VbPpEs1wVlnswvjrqMAWRR94es1ocHjk/xJriE1AW7ekYfHb94uW6OwDJgAbqhnM34IuUu18qjcB1eE5BvPnCNTl3XDEGr5IqP49kQHIwTnO1mmI+ubSSOZY+kcDy3lJ1QG7UWhwDDMTsoWf6XbZHmwVFeDZph31xeFY2khEWLKfob8t69pje+J6Xbbxn2MknU/MOdB89X6KKjHSXoqOcD6jtAa46pBdJDJgAVJJVJK+5bmoxwEB987Hmxs+o1MFkixdsrvHHBWMy39bQpI/xCrwTmdPh/W9RcpeNCzP6Ll9Z7wSNnHyWxTwRKi2a6XwER3lhMAzc9veF/3ADv5QjyMrx7h3ufvRVI6FBUgWPtM3sq+N+r4npjhppwdOaZXDpUQsl3eBKp74bjDcevoy0kyQqPpd/8DFO7tOovSe+PX7foXv4wC7Defhi90LpquWxCBsWhmCPdxcFR7b+yRPjQ00DXTnm05MgtD9ZWdmBOZNiiUSCP9uN6HrJRTCHndVJM50Y96YDeEhac9Z+uAV3tD/XfvibZbsnTtpGOpALHMg1KVU9198j+rKpPYDfIyNdWfc8pTIPszZISSY0X9GoiOUEPVKSEUtBZc1VV2kamYvbJPXQn7oi6Pm/nIkjBgCvmCfD0mB8TyLc9o8vCfLM979yGECAV0vHwH0MB01/JJXJaksuSdNggahD62BC1rdzePip0dgJNAoog=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(260925021911599003)(3023799007)(260925022911599003)(260925021311599003)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmRMTmxlMmYvTG56S3Nsa01WS3E1ODI0b0RCWmMvRitmRElXRlBPYkNPR3l3?=
 =?utf-8?B?ckZaNWJFS1hGTTRxZ011TGZKUml5eDRrenh5cldrKzYrcklHK3hDNG0rN0Nx?=
 =?utf-8?B?cVBhMEJ5czNIblNJSGhNdFo5UHF5d2lUS0dJeW9TNDA1R1dmcGZ2WjJ2Vks4?=
 =?utf-8?B?OFh5dnkxUVA2cUQrZXdpbUwvVXZLSDJuazczTWp0aFIvM3h3eEFyWFdRU2Ex?=
 =?utf-8?B?dlF3emNNNkRBVmZwMzhpM1VOalZIQmt2VmprY0Z2eTYzNlVOUlRGK0JYS0pC?=
 =?utf-8?B?MTRmYjUrL0p0cERYQ0QwYTd2ZVVkU1FOK004d3EwajQySE4reE1ONk53S3lZ?=
 =?utf-8?B?VFB2V0krWk8rKzlHc01Samgrc083MG1BdE5HNXRFWXp6Qi9WRUhlbVNyTklt?=
 =?utf-8?B?a1p2SmdNb0JReVRkc3ZxdCtiVGxuaHhJR1dnSDZFSnY3aGcrOWJtY2Yyaitr?=
 =?utf-8?B?TmNyVlQwU2ZYMGFxMm8zcnpTa0hueFpYRTZCWEtNalFkUTEzWWJWRURwejlY?=
 =?utf-8?B?VzdCdDFYMnA1Q0VJTkphOWhDVk55L05BZUhSYnZsME1rSEh4Z2JoYm82YkdR?=
 =?utf-8?B?eGF1ZTBMRCsrS1RYUTdWOHYzNkdDNGxnaVFhQ1lJb2I3M2FwWGpObG1mckdp?=
 =?utf-8?B?VHNFZE4wOStRMHYrTk9NVk9DeW91TWxoQ0FvRS9hN0xLMC9QSlpSdjlCOHNv?=
 =?utf-8?B?azFXUm9ZZm56TURhbVpFRzY1cndVTGF0MCtSNENWUStFbkVkWEE2VmJQb21j?=
 =?utf-8?B?ay8vUVloaHd0MTFjUTYwc3Vud1I2L3ZDZFFaR3BxNkZ6Umd2S2lNTys0VjNj?=
 =?utf-8?B?UnY0Y0hMaHN3ZkhSZHBOWnJvaHY5eWZjWWhyUzVmazA1ZG0xZzlSNm9wNGMz?=
 =?utf-8?B?V2NiU3VQcERjNld1UE5pY1hac0NCWWNiSnExUFZOYkZhUys5RVlaK1N5OUdP?=
 =?utf-8?B?dTJwWS9odytWdkZ1SUJ3cWloeVV6S2Y3WlFaeXJEQjMycjRJbzJNY21uMzNj?=
 =?utf-8?B?UkFmM1ZKeU5ZY2QvbHUrNEROSjAxckEzallOODNiZ3JxKzc2SExUUEtmSzVO?=
 =?utf-8?B?VlNoTTRjeWpuOEpqWHRPQS94OWhkSEpsYUZuK0EvZW5OcTFKcmVOb0VQUktD?=
 =?utf-8?B?ZFp4N0FtUzljV1NhMXZON1h4L296NnRRVXlxWStQbUx0ak1rNWt2T0w1RFo1?=
 =?utf-8?B?VUdlelFZNlpDQUZaRk0wakY3d0tNQWQ2bkFnc3FxKzdYVVg4SGVTejFDOUtr?=
 =?utf-8?B?OTBlQ2dJdnpSUTYySzE2N3A0OFlOZnR2cWc5Nm90SmpPZFZDV0dDRkhJaUd2?=
 =?utf-8?B?eG9tU0tjZkFnTnY1YTcrMHh5NmlpN2dCRzVYWVlGVC83UkRTVURCUlBSUUM1?=
 =?utf-8?B?OEJ4RzRlTi8wdGp0TGVWUGtXSUdYdFFWOWM2NzZweGppcXVtMEdjMSs4TUdW?=
 =?utf-8?B?Tis5MVhXTVRrTHluSFRGZVB1amRNcXV2MkI2bDRMQmExNERvcjJtRmlENFNZ?=
 =?utf-8?B?YWdUc1BuSmkreTd4NkxkaEJWYzhENGUwSHpGbDZWVWRwN2NCd21lcnp0QStI?=
 =?utf-8?B?aGlYYTlDTXRJN3VvWHo0aGxKbThYSmJWT2lHUGRlNmI5b0pBZFFNS0wxY0gr?=
 =?utf-8?B?VExra28vaFZ2eVJqMWN5RG84aWdYdlR2NHAvenVZdVpPMWVRTkp1ZnhIOGtC?=
 =?utf-8?B?YnlTWXc0ZXVmb2V4WDYweHZ5NWlRMEJLS05Lck0wUFl3bDFNWkhpVDhrdkto?=
 =?utf-8?B?ZTI0MmFRKzVVRjlDTWVEUjIvYzgvUDd1R1lTbEJteHZXQ0FRRVd4ZTI1MS9k?=
 =?utf-8?B?QVNUMW45bmVHOXdXdjRCM1dwT0UrU3lnUnpvaEw0R2tqc1Z2cmc4VWsvQ2dh?=
 =?utf-8?B?b2lVVWVFUTczYjg2czhsdnZvdm0wb2N0UUw4ck5zZVk3elF5UUdDNTdwNGJM?=
 =?utf-8?B?TkxEZmtPNi9XYURxYTlLZnN4OXdHNUwxQVdJakE2QWUrSllhYUlpZXRhdXJw?=
 =?utf-8?B?RUZnMlVvcVVyWHdzUG1ZS2JpcEhtVVdONks0MjVkaXNNVW40UFVrMTl3MU1y?=
 =?utf-8?B?dnpCYTlBMUFoNFZsdXNBUXhFZVAzbFNOSGJxaGkxdDBTYTU5S3A4Sk4wampq?=
 =?utf-8?B?c0ladGV3aHhiNU5kZFg4a1hNamlabm1VK0kxbnRIU2VCbU56RjM0R0tlM1p6?=
 =?utf-8?B?Vi90YmlDMWVWWDUxSkE1emdZbVNOeTVBZ0Iyb0JKWkgvL0JlcmIrTnBnNnM3?=
 =?utf-8?B?NUk0RkpWcVZETkN2UWh1T0VEOGlDenpWeGVpNWpJbmhCakhhazg4NW9jbVRL?=
 =?utf-8?B?aDR3b0lIZngxNFhiUDViNmNyZEQ4cVNZU3IvODRIdnYxMmQweG5IU3FEamFq?=
 =?utf-8?Q?bIgm5yGo/kfajcPo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <454F1E9ABD78A149BA4FC662ED54B3E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1M+bwJDy8u1vcQu2+rLkYra/lhwu1tVbDO6UiftABkiacpCiNB2M1bOZ6+YyOj0TylL2/rbdlpgQ6N5M9FuiAyk8EEe9WNGwF4APeh3u9VYcklj7wvO6rwZfsKV5bH7nGt552osfHwtGMryeK1uf/QnLczgD9zWkflNNySd++W0lL/dKnRsS7zGnI26zm01eY7xnzI4jBcWVN7YXBaalZ5lhhUsYpvsu882sObwqkwv+TIsVY6nOJODZw8axTmfaVaXeOfCTTn3uWIHwFgL64sCy8Z1KjFvZBh42lLVOaOintrQDg1XFjVm3UrQllbpsIybKQmCZNFGF12ogtYKzGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32042d44-dbdf-4592-8377-08df1debec14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 05:38:42.5125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w277R2gYfTbO4zLVd/Iemlyxl7MrrTSnNL8MupB81K2yVBySMgTV2o+Cb0jGsz9Mr5aW9+g44b9naLqb8KeLvendJgvVXrfuEA7nmVaFLsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
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
PiBBZGQgc3VwcG9ydCBmb3IgYXV4bGVzcyB3YWtldGltZSBjYWxjdWxhdGlvbiBmb3IgRFAyLjEg
QUxQTQ0KPiBhcyBkZXBlbmRlbnQgcGFyYW1ldGVyIGdvdCBjaGFuZ2VkLg0KPiANCj4gdjE6IElu
aXRpYWwgdmVyc2lvbi4NCj4gdjI6IFVzZSBpbnRlbF9kcF9pc191aGJyKCkuIFtKYW5pXQ0KPiB2
MzoNCj4gLSBTZXBhcmF0ZSBvdXQgc3dpdGNoIHRvIGFjdGl2ZSBsYXRlbmN5IGNhbGN1bGF0aW9u
Lg0KPiAtIFVzZSBtYWNybyBkZWZpbml0aW9uIGZvciBNTF9QSFlfTE9DSyBsZW5ndGguIFtTdXJh
al0NCj4gdjQ6DQo+IC0gRml4IDMyLWJpdCBzaWduZWQgaW50ZWdlciBvdmVyZmxvdy4gW3Nhc2hp
a29dDQo+IC0gRml4IG5lZ2F0aXZlIHJldHVybiBvZiBkcm1fZHBfbHR0cHJfY291bnQoKS4gW3Nh
c2hpa29dDQo+IC0gSW50cm9kdWNlIGdldF9tbF9waHlfbG9ja19sZW4oKSBhbmQgZ2V0X2RwX2xp
bmtfc3ltYm9sX3NpemUoKS4NCj4gW0pvdW5pXQ0KPiAtIEFsaWduIHZhcmlhYmxlIG5hbWluZyB3
aXRoIGJwZWMgZm9ybXVsYSBvZiBlc3RhYmxpc2htZW50X3BlcmlvZC4NCj4gW0pvdW5pXQ0KPiAN
Cj4gQnNwZWM6IDcxNDc3DQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGlu
dGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBp
bnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
YWxwbS5jIHwgNjkgKysrKysrKysrKysrKysrKysrKy0tDQo+IC0tDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDU4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gaW5kZXggZDU4MjMxNzQ1NzZhLi45
MjRmYThkZDQ2MzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfYWxwbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
YWxwbS5jDQo+IEBAIC0xMDIsMjEgKzEwMiw2NCBAQCBzdGF0aWMgaW50IGdldF9sZnBzX2hhbGZf
Y3ljbGVfY2xvY2tzKGNvbnN0DQo+IHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRl
KQ0KPiDCoAkJMTAwMCAvICgyICogTEZQU19DWUNMRV9DT1VOVCk7DQo+IMKgfQ0KPiDCoA0KPiAr
I2RlZmluZSBNTF9QSFlfTE9DS19MRU4JCTI1Mg0KPiArI2RlZmluZSBNTF9QSFlfTE9DS19MRU5f
VUhCUgkzOTYNCj4gKw0KPiDCoHN0YXRpYyBpbnQgZ2V0X3RwaHkyX3AyX3RvX3AwKGNvbnN0IHN0
cnVjdCBpbnRlbF9jcnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0KPiDCoHsNCj4gLQlyZXR1cm4g
MTIgKiAxMDAwOw0KPiArCXN0cnVjdCBpbnRlbF9kaXNwbGF5ICpkaXNwbGF5ID0NCj4gdG9faW50
ZWxfZGlzcGxheShjcnRjX3N0YXRlKTsNCj4gKw0KPiArCXJldHVybiBESVNQTEFZX1ZFUihkaXNw
bGF5KSA+PSAzNSA/ICgyMCAqIDEwMDApIDogKDEyICoNCj4gMTAwMCk7DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyBpbnQgZ2V0X21sX3BoeV9sb2NrX2xlbihjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19z
dGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gK3sNCj4gKwlyZXR1cm4gaW50ZWxfZHBfaXNfdWhicihj
cnRjX3N0YXRlKSA/IE1MX1BIWV9MT0NLX0xFTl9VSEJSIDoNCj4gTUxfUEhZX0xPQ0tfTEVOOw0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGdldF9kcF9saW5rX3N5bWJvbF9zaXplKGNvbnN0IHN0
cnVjdCBpbnRlbF9jcnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0KPiArew0KPiArCXJldHVybiBp
bnRlbF9kcF9pc191aGJyKGNydGNfc3RhdGUpID8gMzIgOiAxMDsNCj4gwqB9DQo+IMKgDQo+IC1z
dGF0aWMgaW50IGdldF9lc3RhYmxpc2htZW50X3BlcmlvZChjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0
Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gK3N0YXRpYyBpbnQgZ2V0X2VzdGFibGlzaG1lbnRf
cGVyaW9kKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+ICsJCQkJwqDCoMKgIGNvbnN0IHN0
cnVjdCBpbnRlbF9jcnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0KPiDCoHsNCj4gwqAJaW50IHQx
ID0gNTAgKiAxMDAwOw0KPiAtCWludCB0cHM0ID0gMjUyOw0KPiAtCS8qIHBvcnRfY2xvY2sgaXMg
bGluayByYXRlIGluIDEwa2JpdC9zIHVuaXRzICovDQo+IC0JaW50IHRtbF9waHlfbG9jayA9IDEw
MDAgKiAxMDAwICogdHBzNCAvIGNydGNfc3RhdGUtDQo+ID5wb3J0X2Nsb2NrOw0KPiArCWludCB0
cHM0ID0gZ2V0X21sX3BoeV9sb2NrX2xlbihjcnRjX3N0YXRlKSAqDQo+IGdldF9kcF9saW5rX3N5
bWJvbF9zaXplKGNydGNfc3RhdGUpOw0KPiArCS8qDQo+ICsJICogcG9ydF9jbG9jayBpcyBsaW5r
IHJhdGUgaW4gMTBrYml0L3MgdW5pdHMsIHNvIG11bHRpcGx5aW5nDQo+IGJ5DQo+ICsJICogKDEw
MDAgKiAxMDAwKS8xMCA9IDEwMDAwMA0KPiArCSAqLw0KPiArCWludCB0bWxfcGh5X2xvY2sgPSAx
MDAwMDAgKiB0cHM0IC8gY3J0Y19zdGF0ZS0+cG9ydF9jbG9jazsNCj4gKwlpbnQgbHR0cHJfY291
bnQgPSAwOw0KPiDCoAlpbnQgdGNkcywgZXN0YWJsaXNobWVudF9wZXJpb2Q7DQo+IMKgDQo+IC0J
dGNkcyA9ICg3ICsgRElWX1JPVU5EX1VQKDY1MDAsIHRtbF9waHlfbG9jaykgKyAxKSAqDQo+IHRt
bF9waHlfbG9jazsNCj4gLQllc3RhYmxpc2htZW50X3BlcmlvZCA9IChTSUxFTkNFX1BFUklPRF9U
SU1FICsgdDEgKyB0Y2RzKTsNCj4gKwlpZiAoaW50ZWxfY3J0Y19oYXNfdHlwZShjcnRjX3N0YXRl
LCBJTlRFTF9PVVRQVVRfRURQKSkgew0KPiArCQl0Y2RzID0gKDcgKyBESVZfUk9VTkRfVVAoNjUw
MCwgdG1sX3BoeV9sb2NrKSArIDEpICoNCj4gdG1sX3BoeV9sb2NrOw0KPiArCX0gZWxzZSB7DQo+
ICsJCXRjZHMgPSA3ICogdG1sX3BoeV9sb2NrOw0KPiArCQlsdHRwcl9jb3VudCA9IGRybV9kcF9s
dHRwcl9jb3VudChpbnRlbF9kcC0NCj4gPmx0dHByX2NvbW1vbl9jYXBzKTsNCg0KWW91IHNob3Vs
ZCBjaGVjayBkcm1fZHBfbHR0cHJfY291bnQgcmV0dXJuIHZhbHVlLg0KDQpCUiwNCkpvdW5pIEjD
tmdhbmRlcg0KDQo+ICsJfQ0KPiArDQo+ICsJaWYgKGx0dHByX2NvdW50ID4gMCkgew0KPiArCQkv
KiB0bHcgYW5kIHRjcyB2YWx1ZXMgYXJlIHRha2VuIGZyb20gRFAyLjEgc3BlYyAqLw0KPiArCQlp
bnQgdGx3ID0gMTMwMDA7DQo+ICsJCWludCB0Y3MgPSAxMDAwMDsNCj4gKwkJaW50IHRsZnBzX3Bl
cmlvZCA9IGdldF9sZnBzX2N5Y2xlX3RpbWUoY3J0Y19zdGF0ZSk7DQo+ICsJCWludCB0ZGNzID0g
KFNJTEVOQ0VfUEVSSU9EX1RJTUUgKyB0MSArIHRjcyArDQo+ICsJCQnCoMKgwqAgKGx0dHByX2Nv
dW50IC0gMSkgKiAodGx3ICsNCj4gdGxmcHNfcGVyaW9kKSk7DQo+ICsJCWludCB0YWNkcyA9IDcw
MDAwOw0KPiArCQlpbnQgdGRzID0gNyAqIHRtbF9waHlfbG9jazsNCj4gKw0KPiArCQkvKiB0ZHJs
IGlzIHNhbWUgYXMgdGNkcyovDQo+ICsJCWVzdGFibGlzaG1lbnRfcGVyaW9kID0gdGx3ICsgdGxm
cHNfcGVyaW9kICsgdGRjcyArDQo+IHRhY2RzICsNCj4gKwkJCQnCoMKgwqDCoMKgwqAgKGx0dHBy
X2NvdW50IC0gMSkgKiB0ZHMgKw0KPiB0Y2RzOw0KPiArCX0gZWxzZSB7DQo+ICsJCS8qIFRPRE86
IEFkZCBhIGNoZWNrIGZvciBkYXRhIHJlYWxpZ24gYnkgRFBDRA0KPiAweDExNlszXSAqLw0KPiAr
DQo+ICsJCWVzdGFibGlzaG1lbnRfcGVyaW9kID0gKFNJTEVOQ0VfUEVSSU9EX1RJTUUgKyB0MSAr
DQo+IHRjZHMpOw0KPiArCX0NCj4gwqANCj4gwqAJcmV0dXJuIGVzdGFibGlzaG1lbnRfcGVyaW9k
Ow0KPiDCoH0NCj4gQEAgLTEzOCwxMiArMTgxLDE2IEBAIHN0YXRpYyBpbnQgZ2V0X2VzdGFibGlz
aG1lbnRfcGVyaW9kKGNvbnN0DQo+IHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRl
KQ0KPiDCoCAqIHdpdGhpbiB0aGUgQ0RTIHBlcmlvZCBjb21wbGV0ZSB3aXRoaW4gdGhlIENEUyBw
ZXJpb2QgcmVnYXJkbGVzcw0KPiBvZg0KPiDCoCAqIGVudHJ5IGludG8gdGhlIHBlcmlvZA0KPiDC
oCAqIHRNTF9QSFlfTE9DSyA9IFRQUzQgTGVuZ3RoICogKCAxMCAvIChMaW5rIFJhdGUgaW4gTUh6
KSApDQo+IC0gKiBUUFM0IExlbmd0aCA9IDI1MiBTeW1ib2xzDQo+ICsgKiBNTF9QSFlfTE9DSyBM
ZW5ndGggKDhiLzEwYik6IDI1Mg0KPiArICogTUxfUEhZX0xPQ0sgTGVuZ3RoICgxMjhiLzEzMmIp
OiAzOTYNCj4gKyAqIFRQUzQgTGVuZ3RoID0gTUxfUEhZX0xPQ0sgKiBSYXRlIERpdg0KPiArICog
UmF0ZSBEaXYgPSAzMiBmb3IgMTI4Yi8xMzJiIGFuZCAxMCBmb3IgOGIvMTBiLg0KPiDCoCAqLw0K
PiAtc3RhdGljIGludCBfbG5sX2NvbXB1dGVfYXV4X2xlc3Nfd2FrZV90aW1lKGNvbnN0IHN0cnVj
dA0KPiBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlKQ0KPiArc3RhdGljIGludCBfbG5sX2Nv
bXB1dGVfYXV4X2xlc3Nfd2FrZV90aW1lKHN0cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAsDQo+
ICsJCQkJCcKgwqAgY29uc3Qgc3RydWN0DQo+IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUp
DQo+IMKgew0KPiDCoAlpbnQgdHBoeTJfcDJfdG9fcDAgPSBnZXRfdHBoeTJfcDJfdG9fcDAoY3J0
Y19zdGF0ZSk7DQo+IC0JaW50IGVzdGFibGlzaG1lbnRfcGVyaW9kID0NCj4gZ2V0X2VzdGFibGlz
aG1lbnRfcGVyaW9kKGNydGNfc3RhdGUpOw0KPiArCWludCBlc3RhYmxpc2htZW50X3BlcmlvZCA9
DQo+IGdldF9lc3RhYmxpc2htZW50X3BlcmlvZChpbnRlbF9kcCwgY3J0Y19zdGF0ZSk7DQo+IMKg
DQo+IMKgCXJldHVybiBESVZfUk9VTkRfVVAodHBoeTJfcDJfdG9fcDAgKw0KPiBnZXRfbGZwc19j
eWNsZV90aW1lKGNydGNfc3RhdGUpICsNCj4gwqAJCQnCoMKgwqAgZXN0YWJsaXNobWVudF9wZXJp
b2QsIDEwMDApOw0KPiBAQCAtMTU4LDcgKzIwNSw3IEBAIF9sbmxfY29tcHV0ZV9hdXhfbGVzc19h
bHBtX3BhcmFtcyhzdHJ1Y3QgaW50ZWxfZHANCj4gKmludGVsX2RwLA0KPiDCoAkJbGZwc19oYWxm
X2N5Y2xlOw0KPiDCoA0KPiDCoAlhdXhfbGVzc193YWtlX3RpbWUgPQ0KPiAtCQlfbG5sX2NvbXB1
dGVfYXV4X2xlc3Nfd2FrZV90aW1lKGNydGNfc3RhdGUpOw0KPiArCQlfbG5sX2NvbXB1dGVfYXV4
X2xlc3Nfd2FrZV90aW1lKGludGVsX2RwLA0KPiBjcnRjX3N0YXRlKTsNCj4gwqAJYXV4X2xlc3Nf
d2FrZV9saW5lcyA9IGludGVsX3VzZWNzX3RvX3NjYW5saW5lcygmY3J0Y19zdGF0ZS0NCj4gPmh3
LmFkanVzdGVkX21vZGUsDQo+IMKgCQkJCQkJwqDCoMKgwqDCoMKgDQo+IGF1eF9sZXNzX3dha2Vf
dGltZSk7DQo+IMKgCXNpbGVuY2VfcGVyaW9kID0gZ2V0X3NpbGVuY2VfcGVyaW9kX3N5bWJvbHMo
Y3J0Y19zdGF0ZSk7DQoNCg==
