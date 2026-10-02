Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D13CA5FE3
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11D910EA7D;
	Fri,  2 Oct 2026 11:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TnehXs6R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E5810E62D;
 Fri,  2 Oct 2026 11:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790940795; x=1822476795;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ySxoKfIaSlSPki4ClR8UACAmUmI5+Owp0HELzsMG3vQ=;
 b=TnehXs6RD2frEQhGJAVKe/1/Ic+CW0sEzPVbnFA05yqXS74ygGDtPJeM
 igopBQzt32O+pY5v4X0vuqGs5M2wAnfdyuDmqREdGuNKrrMCBB5JWpCn7
 zq9KPdlS9JYWwILH61/npDaIHBsdk/Toda1GqIFN12C8i5TmYX/0ynL/w
 8GjGpdA9Doey3L1GNLoYdq5MmnEyuG7CTSAELQhV/SAg0edYPobc0UObw
 Bc+iJOJdugJHE6rzK3ADErQ8zu2xFQBXfBrzyjOBFegvW5TOlQco1OMTn
 1nPbwqRMiIA6sj8Ubtb5aJ0qh2XNJen8MHk7m7QDirVdgfQeKKCdTtT1e g==;
X-CSE-ConnectionGUID: 6RLxg+0eTCK+yST3MkqIDA==
X-CSE-MsgGUID: edOKeiuvQRmvyU6e5HZQPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90659684"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="90659684"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:33:14 -0700
X-CSE-ConnectionGUID: F/M4O5woRn+nbHPPk2V+4A==
X-CSE-MsgGUID: SmCL4vcITD2uXrhr3zh/zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="279969411"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 04:33:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 04:33:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 04:33:12 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 04:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPBmLsJllvZnHXY0EjOWQKGDgpkdqZP0Xa6S+kRiMBDrC0eqpNv3WHiTsq//dTaRhw1NJ2qtuNxr+Eu4Zw06a3VS6XV6R+3x3kYHottHDw/0df4uyhX5/4EIB2LKRjGVmIOjaEBKkW/mr6M7jDiqrJje5sYDm0IQAuMoeVqPI1WXXMAff0SsixtpiriIuoHCdqOtbmJEH/1oToPng0236f7NuZMiQVlMbsR3ldXQ2wGC1dKDtmySq8M5Kogny/tmPMlkMOMLPKyDRrEAYUdnqmegPRJEgd9c98TJZUkBlvBHEoL3TsVplir8cAJ2H5ty1vWQ5nRziCSe+FpzAaXIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySxoKfIaSlSPki4ClR8UACAmUmI5+Owp0HELzsMG3vQ=;
 b=GsdNkL6jEvj2EWdYcHGdt7RMhvUHr8vf+Og1S5WLTbkmzyr5tG2sqFzqUUOTA9oinBf6h0g5b7FE6vZ/24bbzac13b8xBM3x94j9A5rjbzOU/MWRSY3k9yVlPS2Bq0xPRIUW1WdScjX0u/A8RSHFumdrMAkt0sTstRzdRzB8pTtrvDk7uaKJw6wcCZqtJDEU1fV+W0fdEMuyRwwWwh/uGw20kNqBrG9cC8owHlOkRUqTph4zs/vth67WDnkm/DApER8LFram0MitGXBueckIx+06nUcRPFQ8VUTd/COG0ipSltd+oysPtVTuspjEu10JDAS2BaCI1b+LY0b4WLUGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by DS6PR11MB9920.namprd11.prod.outlook.com (2603:10b6:8:464::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 11:33:08 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%4]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 11:33:08 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 18/18] drm/i915/alpm: Disallow ALPM for UHBR link rate
Thread-Topic: [PATCH v6 18/18] drm/i915/alpm: Disallow ALPM for UHBR link rate
Thread-Index: AQHdRUGeMSHOMX85IEG/msnTNG+H4bbqOROA
Date: Fri, 2 Oct 2026 11:33:08 +0000
Message-ID: <a87002b7391c82c1ca8c8692bb0a30be8fab497f.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-19-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-19-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|DS6PR11MB9920:EE_
x-ms-office365-filtering-correlation-id: c0beee57-482e-4fe8-1526-08df2078eeea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|38070700021|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: jKxWDtgQGyu3on90l4Jf/wTXxRD8nqL4UGN0Vbv5gud/2+vrlCZYqX8ZQObQcWEpbK691H9Cyos9PE19F2FZjzAor513HxBiTwkcPofsBsHNbB5J4hpXwPLLLq7c2tsmg5A63Zv2fhgmqAu7MYLkZSs9rnGGTLTUjheLiOwJQcelQ5NrFmhKajPLNuBSi+TB8371FazA4v8SK9rjsADrbX3P0uYX+722aGOd//4RMhVWjZb5TzwGey+ba2DIkyXKtcx4F8a7s+nsd1FG/UcFgEtlK14b6+BbOeoS1QX7Ou9Hka/NLRkubfhO+Zl3XDWFWuuBALGuEeyh8M2hbGYMwUXB8jF1x0qS7bhQc6kMJR+7NVgFJTV4dA4SZA/0JIskZ5V4Flmf23qSwt+ySjYySwVT5fw5Od6cyAUVroS2fSHZ//pXtZZe7QvjsXig+elk3BIFaiFwwsmJSeGisD9D0IoFBPvfRLlMHDILoF/nl0hj9ZYilUCFGFzGXBvf5Lc958TEpmPJwUUFzNBu7OZrych9GLYXumxaF5smgdKTi7QMn88G3xP5IaXrReVTMpAmZtL/pnF1Yd8hqoa3hcG8Gr0F1QdlFk9yojdPM14lQmOcY5IBoMtk0sHeILHWEh/JIFTTOyUGvDR7Baq21Kqi8HvWP9eWHyiLhSMIA43yWIuE4GP16rbq/vW+O6dXlcw9p+KMtyfd7tfy4OV3xYrRtMGC0AJq52mZ6AlyGSMSD4E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TENFenBXbUozLzltNjdhU1M2VitDUWc5K3E5SUlPS1IvVTVwYzczcGJGekJh?=
 =?utf-8?B?ZFRVVm5nbURiYmI3YXBncFkvU0Q4K3g4UUJBbUg4U21yMldmQXR2K0s1UEJJ?=
 =?utf-8?B?UnRFR1dBQ0c5eEFPTUhMNi9iYWs3c1lDVDkrL3BQQWVyaHZpOGdxY3Z4bWlP?=
 =?utf-8?B?cHpHS29paDJJaWhFSmNuanBMNjJrYVQ0a1llSmg1cEorU0cwSTA4WXJmRjN5?=
 =?utf-8?B?TkdnU3RFRmhsd3hvSldiMXNDaUIvRVYvSkJqME9ybUpkSThKVURGY0tSS3V6?=
 =?utf-8?B?ZzlFckpXZnV2RklxbGR3K3JUcGtlem9UNXZwUm9xR2hHT0lMdnRob1Z4OUZO?=
 =?utf-8?B?UUM0NXJOTk5lTXZIeXRoOFJSL1NEdTRIT1YzNzZJZlJqK0VjNndRY2dhVERD?=
 =?utf-8?B?Z3V6ZklGeHBtTy8vYmlBM2o3WDBLWVNveXJ3RDl1RkRPcXVqa1QyK0ZEQnox?=
 =?utf-8?B?alNMY0JHSDh6cG1EWm9VZzRLbVNRc2loeEFRaUozbFlUTkFZUTM1Zng4TVM5?=
 =?utf-8?B?TDN2Nk9WQ1hscVdnS2ZRcGhLckxSSUI2bmlXMU50cjRVTVhZaHRuRGg5bFVq?=
 =?utf-8?B?SldXakJaYzYwamJUd0ZLRXdWSnFzQ1VrRGlRaVc0ZTFVQUxKSlFiZDhhR3M3?=
 =?utf-8?B?WFJ3eERsWGd0VjRpWmlYbFZqeUF4bjR2Mmc3NUtacDRoOEo5bjUxMlFPVEJU?=
 =?utf-8?B?VkphN3Q2K25ab3lHUmFDVlllVXlYcXU5SVU5UTM0cmZ5QndFdjl4ZUN0RStm?=
 =?utf-8?B?Vm1qZmN1UjFpc1NIY0ZUbHNVdkVBQUNKNUcxMFJVdldEaW1oNytkYWdEVlJq?=
 =?utf-8?B?YXFoTi9CbXhrRFdKTFErckRaS0YrZVNaQktwVkJzY0VVWTd0ZC9EV0dkMGhW?=
 =?utf-8?B?SjlKZG14b1UxMlk5UmIxcWZFK3NBKzRCL0U5alJVb2cyZFJaY3NtZkhHRGNr?=
 =?utf-8?B?c3hySWl0MjdHZE5jNHFZR0hiK0YxRmpZaS9nSmQ2d1lKNnp4QWlWR052Y2ZM?=
 =?utf-8?B?bGx6UVZTR2dCa0RERnc1Zld4OGVBSmpBYWZVQVltUVRqTFhBMFI1YWVMTkRn?=
 =?utf-8?B?OG1HSW5LREk0TUJNTmNDOU1WTHdBZFNpdjJKLzVGNnc5Q0lwUkdEQldmVTJu?=
 =?utf-8?B?eTA5WW95WDZqTUo2b0RWSHZ1UzgzdEJRVmdzTlJyaHc4YVB5aHZmNlVzdWVu?=
 =?utf-8?B?Q0FGMXJtcERXZGxJK2V3RE9PRzg1ckhqaUxxUFU3Z1hoREVpZ1Q3M2Z5VHc2?=
 =?utf-8?B?eVBuSTdkaWtRY1RJU0srQ2xwT2trY2NCTjFYMDV6clBKZGMzYVpqVXoyRloy?=
 =?utf-8?B?MlZUSU9qTmNiQnVZTmkyNjlBeGw3V2JVTDFURW9VbmNkSlArOGRQWDhPaUVk?=
 =?utf-8?B?aDQzaXdTQjBoQXdzaHgzd1lONFp4bUk3U1hoRVNTN082YTQrU2svdTB6Ym9s?=
 =?utf-8?B?NlRLZjkvOGF6aW8wREFXSmRtSWQyQ2MyenBpZVhFWG9IQkMyRGhSSmVhaXpD?=
 =?utf-8?B?R1JFWHZPMVdNd1dqNFZqOU5KaVkxYkV0d0hDK3VreHErOGY2RU9Sb0RxUCs1?=
 =?utf-8?B?d2NCcDRncFpWVDNMZnoxMHRoYjBCR3p6YXpPbXN4c3ZQUE5saFRyM1lNR21i?=
 =?utf-8?B?dEdaM2R0WWRuaHJLdU9iOWdSSTVHUFdVeHNyVm01eW1vc3NQWGhlY0dRcW1M?=
 =?utf-8?B?NFhlQys3YTZVT3dtQzNKZHdIaHA1NlFFSS9zZHEwUEI3QlJYRkdTdE55c3F3?=
 =?utf-8?B?SHF5ZkliMVdwT2JBd1FDNUkzNTNjOEsrV00wUnI0eXA2TFZTTEtmYVRScjJV?=
 =?utf-8?B?WjRrTlJHTWVLbklubnFiVlVGemQ1bllISWRCbzVDTVg4Qm9CUkRuampWcUV1?=
 =?utf-8?B?RVNTWm9jOFNROUNJVVJCSkYzWmNLMCsrcStvYjkvY2JFNnJabDJrSmRmY20y?=
 =?utf-8?B?czl4NUNab1dUcmwxcEZ0N0FkcStZMG0ycFpteEgwaGVkUzc3b2NOL1NxSVF2?=
 =?utf-8?B?UDk1SGtucnRKRm9LWk5qUzBSQTl3VFNLeTBUOXRBdmNTaE5TQVZuZFJZdmFF?=
 =?utf-8?B?M3J2RUI2U0NqbnBiMWNkZVJrd09WVFFJVXFNWjFKYnJpdlFDenAyREJkR25n?=
 =?utf-8?B?RTRmYWlqSWd4eTl0aE0rU0NhY282cndRbFYvbGlZOVdONVozSEIrTE1XWENL?=
 =?utf-8?B?c200K2h4dE1tVmpER0VuSjFKeDFScDRQSnBnNEcyZFNQRXJqd2JDbEhmMHpq?=
 =?utf-8?B?RlJKRy93d3l1Q014Qzd5ZmZmSy9vak1sYlVpNmZLbi95ZnBOQXhkckd6RXpX?=
 =?utf-8?B?N2R1Y21KUlh5SFBhMlZQcHJvUlE5Ym52c2dEM3cvQzNkNktZMVVlcEVqNklL?=
 =?utf-8?Q?XqV9gny9chxOCkBo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71BE6ED538FBB34D889ADD26BC9350FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kRoBD2gV46V0clQNk4o3Pw3T5gnc1PBlemYT/P3QcTnql1atAJ3vvItgfBaGtspvaXAs/jofBchJhIey68ncCbQ0vcpl7azDA8/GV3KsHYys4zakCIbkzCiSP8HpBvOpdOSH8gNKHiPoRSng0FdPimfloKB6KgVekkDsq288/GX1BRzifDJwfyrKLwmHt1iOg0hf73+3WZpSuL5uk2k/Ogc5wI9OYAlVReJMGM+GEVriVUzlHujSS/zR5FUpcZRfS3sFm6e5sGLD6wraXfxVKtVzVSJhXyqKHhw1D8E/VnrnVpjWqvq8qhzLjgIokAMYU08jCnZMBYRGT96C5p56Fw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0beee57-482e-4fe8-1526-08df2078eeea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 11:33:08.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrowL0v9jN3io3ckTtA7NzqSb5GNeDR+8B85OfvWwy46yknbO9odlWi5HJbvdVpJfaWRlnArrgPSI37s2fLU8cXzCy5J73WDJe0t7VB95tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9920
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
PiBEUDIuMSBBTFBNIGlzIG5vdCBzdXBwb3J0ZWQgb24gVUhCUiAoMTI4Yi8xMzJiKSBsaW5rIHJh
dGVzIG9uIHRoZSBOVkwNCj4gcGxhdGZvcm0uIFJlamVjdCB0aGUgQUxQTSBwYXJhbWV0ZXIgY29t
cHV0YXRpb24gZm9yIGV4dGVybmFsIERQDQo+IHJ1bm5pbmcNCj4gYXQgYSBVSEJSIHJhdGUgb24g
ZGlzcGxheSB2ZXJzaW9uIDM1LCBzbyB0aGF0IEFMUE0gKGFuZCB0aGUgUGFuZWwNCj4gUmVwbGF5
DQo+IGFuZCBMT0JGIGZlYXR1cmVzIHRoYXQgcmVseSBvbiBpdCkgaXMgbm90IGVuYWJsZWQgaW4g
dGhhdCBjYXNlLiBlRFANCj4gaXMNCj4gZXhjbHVkZWQgc28gZURQIEFMUE0ga2VlcHMgd29ya2lu
ZyBhdCBhbnkgbGluayByYXRlLg0KPiANCj4gQ2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9n
YW5kZXJAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNo
Lm1hbm5hQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9hbHBtLmMgfCA2ICsrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5j
DQo+IGluZGV4IDg0Nzc3YzhkMzFiYi4uNTE4MDVhNmJjYTg2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtNDUzLDYgKzQ1MywxMiBAQCBi
b29sIGludGVsX2FscG1fY29tcHV0ZV9wYXJhbXMoc3RydWN0IGludGVsX2RwDQo+ICppbnRlbF9k
cCwNCj4gwqAJaW50IHByZWNoYXJnZSA9IGludGVsX2RwX2F1eF9md19zeW5jX2xlbihpbnRlbF9k
cCkgLQ0KPiBwcmVhbWJsZTsNCj4gwqAJdTggbWF4X3dha2VfbGluZXM7DQo+IMKgDQo+ICsJLyog
RFAyLjEgQUxQTSBpcyBub3Qgc3VwcG9ydGVkIG9uIFVIQlIgKDEyOGIvMTMyYikgbGluaw0KPiBy
YXRlcyBvbiBOVkwuICovDQo+ICsJaWYgKERJU1BMQVlfVkVSKGRpc3BsYXkpID09IDM1ICYmDQo+
ICsJwqDCoMKgICFpbnRlbF9jcnRjX2hhc190eXBlKGNydGNfc3RhdGUsIElOVEVMX09VVFBVVF9F
RFApICYmDQo+ICsJwqDCoMKgIGludGVsX2RwX2lzX3VoYnIoY3J0Y19zdGF0ZSkpDQo+ICsJCXJl
dHVybiBmYWxzZTsNCj4gKw0KPiDCoAlpb193YWtlX3RpbWUgPSBtYXgocHJlY2hhcmdlLA0KPiBp
b19idWZmZXJfd2FrZV90aW1lKGNydGNfc3RhdGUpKSArDQo+IMKgCQlwcmVhbWJsZSArIHBoeV93
YWtlICsgdGZ3X2V4aXRfbGF0ZW5jeTsNCj4gwqAJZmFzdF93YWtlX3RpbWUgPSBwcmVjaGFyZ2Ug
KyBwcmVhbWJsZSArIHBoeV93YWtlICsNCg0KSSB0aGluayBtb3JlIGxvZ2ljYWwgcGxhY2UgZm9y
IHRoaXMgd291bGQgYmUgaW4gaW50ZWxfYWxwbV9pc19wb3NzaWJsZS4NCg0KQlIsDQpKb3VuaSBI
w7ZnYW5kZXINCg==
