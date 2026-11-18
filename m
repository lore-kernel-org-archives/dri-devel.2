Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3C60A2612
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AJOef7AQ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JTSEL1BA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A393A10FBD0;
	Wed, 18 Nov 2026 12:42:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D5C10E0B1;
 Wed, 18 Nov 2026 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795005738; x=1826541738;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Nii2I6twla9TBcp7FdiFauxmIV31cojmofwY84uDmEk=;
 b=AJOef7AQyk4VoSmGsPi9PTJ/Apb08PDs8cqeHQaEFJpZYStFSM5WMPKj
 oT2LNjGsWfzPNMK1W+Aazc4bIiYWyf29NdqV9dLOL5hvJ5zGjS49NEz93
 gcmMR6F9uwsmFhr1V8+3q2rV8Q+me0lGhl6pqFhgl5Rdy8q0nIEWtHjW0
 4+aXb2OrRNbentZkcchxJd0BLrgt93KOtqmc/CBfAInHB5jKLkPXxUT/p
 5IyhP/6cygMMWo48Up3aaBxcJV1lIhVcExN+t85boQ3rwUEpywVPBHSdW
 9fOiqqxZ45ZSHDugGXlIw+rUJfrHrgx0uYo1QaPAIXMYV7MBQeKdWkTDa A==;
X-CSE-ConnectionGUID: 2ly69EjtTgyGfatW3M1kGg==
X-CSE-MsgGUID: vPqKWQnoQRGSUm4I1VU4Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3708398"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3708398"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:42:17 -0800
X-CSE-ConnectionGUID: Zf0gucQ2Rduno4ZxQEnrpw==
X-CSE-MsgGUID: NgNVJ404RbWTIr1S/WJ5JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10473304"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:42:15 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:42:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:42:11 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:42:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+yDO/F9ZoJLYooMYOUa5v88d6gIvJqpBqH6GiQ5Ve0kghku2DVU0v3fbwJqdiuepgDICTiVwl7OUR59JnzvSNBi1qKgPsrdUdhJF7StGAkkpZkbIdieDxxA1mNLXt+wCFNk6yBvwN9uuj/i9HBOTUUBYTH7GLx97Njpq4xfedh1nxBvVAH4vPWHgRYbmZQGPNyXUllVDwn+5UDegDCj/7GTM8AKTuxwA2wiZ1y+X/WKo3ZSDlqbhm6MVRo3A99dkg8UQjSDTKqv/2wgtl4zMfh+ygAIiv2TapuiS0Iajzdqo8HvZS+U27MAaoHzb08/YDXWztXLZ2ZU1z2S3ZeFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nii2I6twla9TBcp7FdiFauxmIV31cojmofwY84uDmEk=;
 b=Vp6JJtiVr/x3jjlZZVltMeKLr7os9RozI3ajwvYv7Yz0pvtoK/4tE+IMz7hEd+Vfy6Xf08kPFCTduK/Fsc3U/yjXrrUIQt38VlEhpYt10xWLAfE+cbPqPcwfcJfhKowthdZ1PoRDYqHIcFPoqdeIaK4tThZlyzrlge4Ejn2pTD1ecKL+DFQaa5QpQdfq8DXn4b0XZHT0cykNChSibBj5Dl4eV6RI5r8WiWzX54Qsm6yd+gSKHUGpKhZfuQU6SA54fht88rU29mxb5kkPDPBHz51x4T+inEA5i+8FNwFvKHuQp2KNQJsBfjOEqi6N2MIUJYypali1HyO5crSQBjeBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nii2I6twla9TBcp7FdiFauxmIV31cojmofwY84uDmEk=;
 b=JTSEL1BANp3tdVWyz/RSIm1rwPJegFzi6B0iCcL+2L0DPoKCAcuwO+hKaHs/uo6jCrskUCA0OPvWMvyX4IlVjenMFFVkKQ+hjtw+14y3civpeatEhScgj2BVeYB33QMqENToSbn1mkslliXWCs/KiP0WLjYs+NePo1TrtA+50ZM=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:42:01 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:42:00 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 14/20] drm/i915/alpm: Enable MAC Transmitting LFPS for
 LT PHY
Thread-Topic: [PATCH v7 14/20] drm/i915/alpm: Enable MAC Transmitting LFPS for
 LT PHY
Thread-Index: AQHdZQyYe6W8VIcC6UWnbNsltKCZsbcz6k6A
Date: Wed, 18 Nov 2026 12:42:00 +0000
Message-ID: <5f992a5888b895da9c11ea005e901d94ad9e0574.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-15-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-15-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|BL1PR11MB6004:EE_
x-ms-office365-filtering-correlation-id: 25551356-6d41-4b73-11a8-08df4571574f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261102123227099003|38070700021|56012099006|4143699003|11063799006|261026140227099003|10067099003|261028144727099003|261026121527099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: wAT2F6n3EREJTeCVp+EFuvUux0Su4wGCChJsiFZuzo+B/3EexN3wB+cMyaJ9+UL/IO0Es0gKflPsIqPxdv+ynOiI3dTebK1wJTA9ywhuCjJwDp6qPBdg8cd6wYbe3dW53AkORuj60hvGlzzpZadD/qsyoAYhe/uavxStvLKZKYkxTaFGp/pzly7eqVUAzsSs/aNBNdycQIeAEewym5UAvzJhLW6xWOhmDixXjE0j+St12vPSgzs/0GSTitffw5End4Mt6KJEPmrAklESyJ5DhL1+I+IiFJu8jjIgra4gF4ELWez/iW1rfg3E/YB//3itxJVlg70Nij1GV7niRJhzc9JYYMIJ95x339zA59IUMtaTOrFlrz07FqLWn0zb/8z8gln1NdU29/6uhobjQX70PPmcVSRMv1Wmh1s9ZKr6msFgmN46hMngEmjSvbIO8KdBA3SibceeOXLi9aJLXEBWPWVDJg58xNEGT9OTqy5nqhzElOTQ7UcYIaz2cXzYcuSEP1Ku2kHbryFt+9lZAWr42uq+H2IBoi5iFltQJRF5+FRdz+XjS8Xg26Zv8FFqqtX2cxou87XT535jgTgpfHNPnamcXR7s16+4xRMb8B19pPY8kH9nQ3FjmxZzIkOQyfr7tWxf+mythi5Kxr3IGVCEblLPBdUZjG4oM2MVuXVaJrWwonB5c2qXbCAB0W0cHVZZgRAkQndZ54pwv6YjnK0fWDKyEL6tMVrZaw7PCj2Bz0w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261102123227099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026140227099003)(10067099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkJZQTliTGtyWDNhN3JFZlJHVEpLRGh0cHB5R0kxNnVEN3d4UVpneHgyMWhW?=
 =?utf-8?B?RDJSZW1aYjZMamMrMGNRNkdYL214bkhsUFo2TlhPbVlZQndpZWtLNStPN3l2?=
 =?utf-8?B?c09HWWFCNzZZWnEydnRYY2dUU3RURDFrM1Awb2w5S1ROUnhyaElRa0RRZk5n?=
 =?utf-8?B?UTFpSy8zZXZzUHRjZUROeFg4TlQyRDN0Yll5ZnQrWXgvTlU1eE9oUkJwWEVi?=
 =?utf-8?B?VEt5dWFraGpTZjlJN2tHYXBLZ0k3aWl0djRhSkdEczVPNU8xN08xMXRNOUZN?=
 =?utf-8?B?VmJheTNQcVhGdlpZR2ljM1UrZnRrVk03dXFzbUFFUjg5SlVINFVwRnZocWNR?=
 =?utf-8?B?QWd5WURzQ1g5SzB4dElBT2NoODRMVTJVTXFTUFpiWEpkWnlMRkdTQzB3dFND?=
 =?utf-8?B?RUpYYjJ5Y1gyNHFHS3p3V3hjelVqVHVmVUUyK0RBQlR5OVJMcVJQd1pzUDQ1?=
 =?utf-8?B?aTdWckZSa1hVZW9DOWVhUkhsOWVPT3YvYjlLRXVVRmhIOHVhaWs3SkxDNUxo?=
 =?utf-8?B?VUE1LzdEN0hKUGxUSnpsWHBaVURqNnlTK3pYZkFlbUNTVnNGYXpZUzlOenVC?=
 =?utf-8?B?ckI0a2p1RWVNcmxBNVBqUXZOWnlhRjJ0NjhEWjE5cmY3RGsxRGVQbU83T1lV?=
 =?utf-8?B?dkZlYkFET2IzYS9yd2pWejUwQlVFK3dsTE9VWkdEQ3JWMTAxNnk4RWNybEhO?=
 =?utf-8?B?czV0T2lPQVgrak1hL3RFeEw2bWx2a1ZRRWFNQ0ZERERJSXBDS2FrajlaWUcz?=
 =?utf-8?B?aytlVmY0Mmw0aFo4dWdKQWFWbDkrajZ3blh3TUxnQ0luTzEyYlRFOExIeTN4?=
 =?utf-8?B?enhKdzcyMmZ5aExycVlpemg3bi9CK09hTGVwMUFQYzROQWErbzA1ZVI4WDZB?=
 =?utf-8?B?V3lXcWUyWE1WNUJyaUFQR2szbE5LbWNkMTdCanRSUnZpM20zS01vNi92eU1C?=
 =?utf-8?B?K0hRc2JFM0xTSnBEbThCNDhubDV6QnNtTHJqeXlrNzc2aHlITzVOZTYwK2lT?=
 =?utf-8?B?cFlLSFJSVS9Ib1FudHZidXdoU3VQRzNTVUZWYytHdFpxZmhSZlZsMXdhbHhP?=
 =?utf-8?B?V0JINlI3bDl3N2xzYko0cnJxNktLZ2tSQ0Nzd2FlUDhMaUdtcGFQNTdLNDRz?=
 =?utf-8?B?ZWRFeUpXbnZqUlVNSzhuUHdqWHpyZTJySEJ4OHlINjhQZm1zdjZHcWNEeTVm?=
 =?utf-8?B?YmZyNWdUR2ZndzQrKzE0ejVMU2pKUmN5SDJOMlpKUllCdHZiYlJmNzNEMXBN?=
 =?utf-8?B?VlJoek8ycGJ6OUFNV1FoM3pNNHNFVlowWWQvY05hVVFzK280Rk1qK3NuZ083?=
 =?utf-8?B?MHloYjJwTUE4OFFwaDhhSEY5blN3T1BuYTlDNE1JTlQ4a1Z3Y0Uva1VaeFRL?=
 =?utf-8?B?UUNBUHVBWlNpVjUxb0JSTUNMdWI1eTVnQmE2Z0ZFRFZzRTBPREtrUFdzMUUy?=
 =?utf-8?B?OFpDUHBsTUR1ZkwwMU9PTUFpSURJQVRLSFVvMWJzQzhISkNsekhlS1lNZ25S?=
 =?utf-8?B?VjhrVUphSm42ZTFFYzNJaGhFaHlVUHRiVmJKOTlESjduTFRGcStYUDBjT0FJ?=
 =?utf-8?B?VDFXdkxiRlZYRnJETUdKUkI5d28xSDRiVmlQeEMwd0RMTHpSMUdBYlNETTdB?=
 =?utf-8?B?WE5vVDE3SE9xZkc3TWZqL2hzM2ZyTWthdFloUzhLcHJ2aW4xS2hGejBOMmF4?=
 =?utf-8?B?YWxFSEc1L0tyMks2alY5RDBDMXdwTm5Lc1lMWVh2YTJZdWlJN3Y2OVRFSklC?=
 =?utf-8?B?eVFEVXMrbCtrSitQL2lZZDl6MFFvd0ZSTlhqVG15RmxmZXgxcUdjZGJmSzE2?=
 =?utf-8?B?VFNTempzM3JyVFVpMWRIVU1ZTy8yTlBiVEtUY1pJY2ZBcjNqRTJlejJnLzgw?=
 =?utf-8?B?cllBOEtxT0M4MnVrTjduYmVUNXhlL1pnMDRQK21jS0V5QkdUZ0tMZGl6QTZk?=
 =?utf-8?B?Q1Z3eGxtdlE5bGQ4TFRORG4yVmNpNXd1UitMZGMvY0tTWFYzOFE2Y2FUR3Rk?=
 =?utf-8?B?NlU4NkFvNXhqRldxMVpKZWZnbVpNTnV3Yk81WldnK1BHMnpXd0JuQTZlZDlL?=
 =?utf-8?B?TFd6dEJJb08rTFhEbVJPMnI5WDlPNU9tOUZoYTRoaWI2c2crdk9pMG1kZTVl?=
 =?utf-8?B?THB5RmNyWXo2UGg4WkhCZGdQTXhQYnoxdHNKcUNnMDVqbUNiM1pNMTVOcGNN?=
 =?utf-8?B?N1BZYVpKV0pUMytWMzdEemZTN3JyNitXZVBiREFxNktsT2pBdVlXR3FIN3N6?=
 =?utf-8?B?T295ZnNyakpvUHNFOWdqVC82SGhib29DcnNacUdYejJ4WWNXM2oycUhUMTh4?=
 =?utf-8?B?cEorTHNVTlZYOHJTMUdEcE9SRjZiQUlXYkRxdkV5eUxXS1FSVTFIWTBMcXAz?=
 =?utf-8?Q?Oe6FrwTcJ8Oc+Tco=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <782886361F6EF74D8D57020C8B608EBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A7MIdgfaNfhup69sPTKtd5ioTDOdDtCfbJ0gve4UszxTzUwqp323jx3HHwjjR55kBF0gDAPWv3PZJ2dlzJSOWhNLTCdowb1LjcNUeZx3M3nd9xs8joG8fgcR4aftu1JdaCz7r9rT+yYiLaB5WKmeZZX7U4cdsToUOvHX/+uzPHidSYSGVXrTZJagksXFf2iWZZD8IGqFdiv78EKvWMce+UgOklvddeOHSqxVmje9Jw3eqyTzmOlanqfVhLItZP+RzYCj8wypFSqXoqiPBFEKQ6n8JFh+v07gv/8i6jdXbJ+VS2FVZieM2OQoOpjvtXykMwH9ZmDasKVsHTqhK5ZhEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25551356-6d41-4b73-11a8-08df4571574f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:42:00.7866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xYucOMUZt4W/w7VelrLZGRRiIy3WTEyewE5uc+wE7HQ3TMPm3KKhCmeo5HUyfBo9TOi5KbijCkNTXuHHyzs5RfSNjncGCUsZ6XbWsjYGg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBFbmFibGUgTUFDIHRvIHRyYW5zbWl0IExGUFMgdmlhIExUIFBIWSBkdXJpbmcgYXV4LWxlc3Mg
YWxwbS4NCj4gDQo+IHYyOg0KPiAtIENvcnJlY3QgY29tbWl0IGRlc2NyaXB0aW9uLiBbU3VyYWpd
DQo+IC0gUmVtb3ZlIGxvb3AgYXMgbm8gZGVwZW5kZW5jeSBvbiB0aGUgdHJhbnNtaXR0ZXIgTFRf
UEhZX0NNTl9DVEwwLg0KPiBbU3VyYWpdDQo+IHYzOiBDb3NtZXRpYyBjaGFuZ2VzLiBbU3VyYWpd
DQo+IHY0Og0KPiAtIEFkZCBCc3BlYyByZWZlcmVuY2UuIFtKb3VuaV0NCj4gLSBSZW5hbWUgaW50
ZWxfeGUzcGxwZF9tYWNfdHJhbnNtaXRfbGZwcygpIHRvDQo+IMKgIGludGVsX2x0X21hY190cmFu
c21pdF9sZnBzKCkuIFtKb3VuaV0NCj4gLSBSZW5hbWUgTFRfUEhZX0NNTl9MRlBTX0VOQUJMRSB0
byBMVF9QSFlfQ01OX01BQ19UUkFOU01JVF9MRlBTIHRvDQo+IMKgIGZvbGxvdyBCc3BlYy4gW0pv
dW5pXQ0KPiANCj4gQnNwZWM6IDc0NTAwDQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhv
Z2FuZGVyQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFN1cmFqIEthbmRwYWwgPHN1cmFqLmth
bmRwYWxAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNo
Lm1hbm5hQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmku
aG9nYW5kZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX2RkaS5jwqDCoMKgwqDCoCB8wqAgNSArKystDQo+IMKgZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9sdF9waHkuY8KgwqAgfCAyNw0KPiArKysrKysrKysrKysrKysr
KysrDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9sdF9waHkuaMKgwqAg
fMKgIDIgKysNCj4gwqAuLi4vZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfbHRfcGh5X3JlZ3Mu
aMKgIHzCoCAzICsrKw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZGRpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rk
aS5jDQo+IGluZGV4IGE0NmFiNWQzZDcwZi4uNmExOTZkZjI2OTFlIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RkaS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGRpLmMNCj4gQEAgLTM4MDgsNyArMzgwOCwxMCBA
QCBzdGF0aWMgdm9pZA0KPiBtdGxfZGRpX3ByZXBhcmVfbGlua19yZXRyYWluKHN0cnVjdCBpbnRl
bF9kcCAqaW50ZWxfZHAsDQo+IMKgCSAqwqDCoMKgwqAgaWkuIEVuYWJsZSBNQUMgVHJhbnNtaXRz
IExGUFMgaW4gdGhlICJQSFkgQ29tbW9uDQo+IENvbnRyb2wgMCIgUElQRQ0KPiDCoAkgKsKgwqDC
oMKgwqDCoMKgwqAgcmVnaXN0ZXINCj4gwqAJICovDQo+IC0JaW50ZWxfbG5sX21hY190cmFuc21p
dF9sZnBzKGVuY29kZXIsIGNydGNfc3RhdGUpOw0KPiArCWlmIChIQVNfTFRfUEhZKGRpc3BsYXkp
KQ0KPiArCQlpbnRlbF9sdF9tYWNfdHJhbnNtaXRfbGZwcyhlbmNvZGVyLCBjcnRjX3N0YXRlKTsN
Cj4gKwllbHNlDQo+ICsJCWludGVsX2xubF9tYWNfdHJhbnNtaXRfbGZwcyhlbmNvZGVyLCBjcnRj
X3N0YXRlKTsNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgaW50ZWxfZGRpX3ByZXBhcmVf
bGlua19yZXRyYWluKHN0cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAsDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2x0X3BoeS5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9sdF9waHkuYw0KPiBpbmRleCA4NjQ5MjY1MWIw
MWQuLjViMjY5NTdkN2ZiOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9sdF9waHkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2x0X3BoeS5jDQo+IEBAIC01LDYgKzUsNyBAQA0KPiDCoA0KPiDCoCNpbmNsdWRlIDxk
cm0vZHJtX3ByaW50Lmg+DQo+IMKgDQo+ICsjaW5jbHVkZSAiaW50ZWxfYWxwbS5oIg0KPiDCoCNp
bmNsdWRlICJpbnRlbF9jeDBfcGh5LmgiDQo+IMKgI2luY2x1ZGUgImludGVsX2N4MF9waHlfcmVn
cy5oIg0KPiDCoCNpbmNsdWRlICJpbnRlbF9kZGkuaCINCj4gQEAgLTIzNTcsMyArMjM1OCwyOSBA
QCB2b2lkIGludGVsX2x0X3BoeV92ZXJpZnlfcGxscyhzdHJ1Y3QNCj4gaW50ZWxfZGlzcGxheSAq
ZGlzcGxheSkNCj4gwqAJaW50ZWxfbHRfcGh5X3BsbF92ZXJpZnlfdGFibGVzKGRpc3BsYXksDQo+
IHhlM3BscGRfbHRfZWRwX3RhYmxlcyk7DQo+IMKgCWludGVsX2x0X3BoeV9wbGxfdmVyaWZ5X3Rh
YmxlcyhkaXNwbGF5LA0KPiB4ZTNwbHBkX2x0X2hkbWlfdGFibGVzKTsNCj4gwqB9DQo+ICsNCj4g
Ky8qDQo+ICsgKiBBY2NvcmRpbmcgdG8gSEFTIHdlIG5lZWQgdG8gZW5hYmxlIE1BQyBUcmFuc21p
dHRpbmcgTEZQUyBpbiB0aGUNCj4gIlBIWSBDb21tb24NCj4gKyAqIENvbnRyb2wgMCIgUElQRSBy
ZWdpc3RlciBpbiBjYXNlIG9mIEFVWCBMZXNzIEFMUE0gaXMgZ29pbmcgdG8gYmUNCj4gdXNlZC4g
VGhpcw0KPiArICogZnVuY3Rpb24gaXMgZG9pbmcgdGhhdCBhbmQgaXMgY2FsbGVkIGJ5IGxpbmsg
cmV0cmFpbiBzZXF1ZW5jZS4NCj4gKyAqLw0KPiArdm9pZCBpbnRlbF9sdF9tYWNfdHJhbnNtaXRf
bGZwcyhzdHJ1Y3QgaW50ZWxfZW5jb2RlciAqZW5jb2RlciwNCj4gKwkJCQljb25zdCBzdHJ1Y3Qg
aW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgaW50ZWxf
ZHAgKmludGVsX2RwID0gZW5jX3RvX2ludGVsX2RwKGVuY29kZXIpOw0KPiArCXN0cnVjdCByZWZf
dHJhY2tlciAqd2FrZXJlZjsNCj4gKwl1OCBvd25lZF9sYW5lX21hc2s7DQo+ICsNCj4gKwlpZiAo
IWludGVsX2FscG1faXNfYWxwbV9hdXhfbGVzcyhpbnRlbF9kcCwgY3J0Y19zdGF0ZSkpDQo+ICsJ
CXJldHVybjsNCj4gKw0KPiArCXdha2VyZWYgPSBpbnRlbF9sdF9waHlfdHJhbnNhY3Rpb25fYmVn
aW4oZW5jb2Rlcik7DQo+ICsNCj4gKwlvd25lZF9sYW5lX21hc2sgPSBpbnRlbF9sdF9waHlfZ2V0
X293bmVkX2xhbmVfbWFzayhlbmNvZGVyKTsNCj4gKw0KPiArCWludGVsX2x0X3BoeV9ybXcoZW5j
b2Rlciwgb3duZWRfbGFuZV9tYXNrLCBMVF9QSFlfQ01OX0NUTF8wLA0KPiArCQkJIExUX1BIWV9D
TU5fTUFDX1RSQU5TTUlUX0xGUFMsDQo+ICsJCQkgTFRfUEhZX0NNTl9NQUNfVFJBTlNNSVRfTEZQ
UywNCj4gTUJfV1JJVEVfQ09NTUlUVEVEKTsNCj4gKw0KPiArCWludGVsX2x0X3BoeV90cmFuc2Fj
dGlvbl9lbmQoZW5jb2Rlciwgd2FrZXJlZik7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2x0X3BoeS5oDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9sdF9waHkuaA0KPiBpbmRleCAxNmRlMzk0ODQ3NzkuLjFjM2U5
ZTIwMDc0OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9sdF9waHkuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2x0
X3BoeS5oDQo+IEBAIC00OSw1ICs0OSw3IEBAIHZvaWQgaW50ZWxfeGUzcGxwZF9wbGxfZW5hYmxl
KHN0cnVjdCBpbnRlbF9lbmNvZGVyDQo+ICplbmNvZGVyLA0KPiDCoAkJCcKgwqDCoMKgwqAgY29u
c3Qgc3RydWN0IGludGVsX2RwbGxfaHdfc3RhdGUNCj4gKmRwbGxfaHdfc3RhdGUpOw0KPiDCoHZv
aWQgaW50ZWxfeGUzcGxwZF9wbGxfZGlzYWJsZShzdHJ1Y3QgaW50ZWxfZW5jb2RlciAqZW5jb2Rl
cik7DQo+IMKgdm9pZCBpbnRlbF9sdF9waHlfdmVyaWZ5X3BsbHMoc3RydWN0IGludGVsX2Rpc3Bs
YXkgKmRpc3BsYXkpOw0KPiArdm9pZCBpbnRlbF9sdF9tYWNfdHJhbnNtaXRfbGZwcyhzdHJ1Y3Qg
aW50ZWxfZW5jb2RlciAqZW5jb2RlciwNCj4gKwkJCQljb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19z
dGF0ZQ0KPiAqY3J0Y19zdGF0ZSk7DQo+IMKgDQo+IMKgI2VuZGlmIC8qIF9fSU5URUxfTFRfUEhZ
X0hfXyAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9sdF9waHlfcmVncy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9s
dF9waHlfcmVncy5oDQo+IGluZGV4IGZmNmQ3ODI5ZGJiOS4uYTQ4ZGE4MzE1NDEzIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2x0X3BoeV9yZWdzLmgN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9sdF9waHlfcmVncy5o
DQo+IEBAIC0zNSw2ICszNSw5IEBADQo+IMKgI2RlZmluZSBMVF9QSFlfVFhZX0NUTDEwX01BQyhp
ZHgpCV9NTUlPKExUX1BIWV9UWFlfQ1RMMTAoaWR4KSkNCj4gwqAjZGVmaW5lwqAgTFRfUEhZX1RY
X0xBTkVfRU5BQkxFCQlSRUdfQklUOCgwKQ0KPiDCoA0KPiArI2RlZmluZSBMVF9QSFlfQ01OX0NU
TF8wCQkoMHg4MDApDQo+ICsjZGVmaW5lwqAgTFRfUEhZX0NNTl9NQUNfVFJBTlNNSVRfTEZQUwlS
RUdfQklUOCgxKQ0KPiArDQo+IMKgLyogTFQgUGh5IFZlbmRvciBSZWdpc3RlciAqLw0KPiDCoCNk
ZWZpbmUgTFRfUEhZX1ZEUl8wX0NPTkZJRwkweEMwMg0KPiDCoCNkZWZpbmXCoCBMVF9QSFlfVkRS
X0RQX1BMTF9FTkFCTEUJUkVHX0JJVCg3KQ0K
