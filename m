Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC9606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CivFqC/m;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=O1qoXL9n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6E310E034;
	Wed, 18 Nov 2026 12:31:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D7410FBA2;
 Wed, 18 Nov 2026 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795005097; x=1826541097;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pXlSaxWIS6AcKi85RGfpNbBKoqPP0HD/TUdDpJ+Fp+I=;
 b=CivFqC/mAJV1rHyCZlcinFFKZYv0/towWWkNdhp9M/WqwxkuBSNao9R2
 kzHDYXo2Y5uiqE0Fr3W/iFKc4qS9teg2i9zQlpnNAd4kyZYtA+b4hwZOf
 XZ7odcECoXU2x6F1Y8I4HxB11a+KON+lV0hXV6Jdu7fw6U9fdlBBUoVlF
 vZSDNTJ5+KiuFMlUFKY4+FFVKMA2M0OW7t3YbiuhO4CnAI1UsW0BQkbL7
 y8oA8f2gN0+iTFyPoC7Ylg3ztz1NiIsbLhlrJGYOSc7d7Dxquw0f/mPo3
 Z8eqhG4KcXJfyuUlbEB2qy0W8ZXl45+03UUSoydoXPFbBZlBLq7RqAHcF A==;
X-CSE-ConnectionGUID: lvvrrJ7gQ+iq8ID4wD5sSw==
X-CSE-MsgGUID: sRlJwhMESdubvWK29y5zWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3694409"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3694409"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:31:37 -0800
X-CSE-ConnectionGUID: K8bnUa0qTSWZGWGZiIt+xg==
X-CSE-MsgGUID: kNxpERwAQeyF1YqwDsH/yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10140501"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:31:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:31:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:31:36 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:31:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe2dvmzQgEYizY/PWnMY8PmQ1BC3sk5NV28Qft6vD6XE57+WxsE4tLasv0LotJpHmzvvtviFWkVZIkYQRymDZWhrTbTX4p+DsNHIrAQvKAhfiTZQ1rR0n/5kjZULX3qv23QKC3PslkQ7DBfAjrlmaDtnrQTVBsCLn0aZ72I0G5x+6vEayoRhJbS/d/uhe60AsjYNaARsWdB/Y6EVTZMIGlCFVcm96y/T1PFEENFig0ajqM9PQY9JDxxY5m84kH1/uNdy3lIkROJHP9wRMJQMY8+NOPqRSKP3CShlGEBKKtfBJe1fxI6Wo9p44ogbDcgPTCFaSh9YBa1lUpuE4b+FhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXlSaxWIS6AcKi85RGfpNbBKoqPP0HD/TUdDpJ+Fp+I=;
 b=pcwx+vWu1UV/Ll9jkoc1uRo6YD+zK4EHDAZNl2Cxk7UMSe6dUrSJaiiUp7AQN78PRphLiq0BSaBMv2f178oo7q0CrolQgD5uU4nS9x7Dr4zPIVonKhCa2JKEXLcWp8buiciaQDm/npVTA0/h4pFXDcMdmkfRTF/1WQu0KrBvX2C1kBuNaXJfldfzIczLGA+U/sYoH2pQByliJ0FRnKYzmmgrBad4XDygqX/i3iIIfHRcTixkFHDRs1BfryhiHKJVr47bG5ZLEwHtwsKibdVyuioAvlENdyQ8wDA4aOb1rY4lYDLchTizX6+50kPhxK6s5nFA+kBpe6/EVwub3vM0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXlSaxWIS6AcKi85RGfpNbBKoqPP0HD/TUdDpJ+Fp+I=;
 b=O1qoXL9np+ShsvRyyBc+Psi2CHRHPZCh28IlMyNHch8FW1UQEBxt4EtrAkwjSBB7lIZltmGh9WWbfYRJKoFkcWXZ78bPgrkDQCIPJ2qWV2f0QD4AF0i6Qkc0P5gcxmHKK70QFh1tXXrGlMURkf51zRmqgzMgVCrX+zrEolDTLyU=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by DS0PR11MB7261.namprd11.prod.outlook.com (2603:10b6:8:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 12:31:33 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:31:33 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 10/20] drm/i915/alpm: Half LFPS cycle calculation
Thread-Topic: [PATCH v7 10/20] drm/i915/alpm: Half LFPS cycle calculation
Thread-Index: AQHdZQyXmh5EOUQfikK9cDgxpacsILcz52IA
Date: Wed, 18 Nov 2026 12:31:33 +0000
Message-ID: <04c5a8d823caf6a42a5f41988848e111f3aa3c7b.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-11-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-11-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|DS0PR11MB7261:EE_
x-ms-office365-filtering-correlation-id: 8df1492f-03d7-47da-0aee-08df456fe145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: 8eDaIBLmj15VLt0/IWDUaUuelAPZ+/Vj31QYYJJExxBoEBcqkW/7do2Ro+3d/WswhmoeNcUhDBP3vPUxRJynecDziTQHXeXSIrdJ42J8pYB71ACDltaeJumweurxGkIgRHfugwAAPWSaPzhDIwPr3mgSPX1h2if1fNBtbVw94uoxKPKQdkfWRfj2uSDOiipfbWNCqM7/zdu5VI1c2K8544in3550p17TiNKqNqvs+dSktCwUIyf27ih7eJc854iAjpS3Pkdv6/VrQtSryiLVbXzimm3NhLKJ2ipG0dkLh+/3V81hOdwPVIBj8vknn1E2oIf688yL5VOseNvCas99TIgafBu3CzKY4TQPRwgt05MnvCGtpDzM6ygyxFIDDvdiizMkfKKExXM1YJNqYAnTZ+sASU0Kvw77YALmLieiiNWfhG3W3RkMAcSITlhqu6wamfqgctAqC9sIb9b8wZYIsufKGWbiAYBQLA8o2VvmapedwFLQqgH1EFvH6pESbCgk/94IusTn1vk+1mrmAiu3lM1khEc9NOlkLVC7Q1E4Kp3LkK9wsGMX6T+z2z2e5eJuUITpSKYvPVlNAdAydXPPdBmDfE0r0Bd9jgXV4SDIxUDrhbiMfPdcfUcHPoa8wurNTuAtJ9INw9J+vBOWDAwwKUs+fgyI/OfSWYO1SBhvo3Hbg+DMeN/2M3lbkQsJoNZfvNNFuPzjpsXlde7EzITXj0NIRNFAu/afBKx6sh3z4dM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHJ2NmtQeTVVSGVwMkJySnJ3b0lsbGh5NHpWYUFwamZ4ZEtGOG1iSC9icVNQ?=
 =?utf-8?B?ZlloL3pXQUs0WlF4Q0w0ZElXOG5PZ3RQTlJydnh2RSs2ZDdJWndodzljYzQv?=
 =?utf-8?B?dU96V1dWZmk1MTl4aHNWc3RwQTkxY2lUK1BNY0FJSlR2UmVyay85V1dJNmN5?=
 =?utf-8?B?cllzby9YekxYYkNlbWJjQ0xaWmN6Z1JWTW9XZTR0Slh4bUJrTVRjOFJuM0t2?=
 =?utf-8?B?TlFUeXZGMWs3Z3RBSjA4Tlgra3YranpKTkJQYmpWMnIzVnU1R290eE9oR3Bi?=
 =?utf-8?B?VkNLajlocjYzcHgrTGVFYnB4NHBFbzBGc1ZwMEpGYXhON0k0cDlIak5Pb0JI?=
 =?utf-8?B?ajFBRXNDSjZHWGtPNy8zSzlqL0FrQ1Q5Vi9XRFRXNW9VUTJNSndOR0NPVTg3?=
 =?utf-8?B?b3NmZlFZRUExK3VFNmlqUHlmN0JlMUNaZG5xS2haWHBSZ0Q2YjhMR1pITURL?=
 =?utf-8?B?MEdtOWZmdEI0NnhuY1FrRkxVOG5sc2NJQU1pcDk1SFBaU1BFT0I4QmRsZjl4?=
 =?utf-8?B?d0g2NUlmV2lzdUZDUjJPWlg3WCtyS2QvYWFjRldweDlzUmRyQkdqMlRWb2pj?=
 =?utf-8?B?TDA2Y0hkVW9wMDYvNHEwb3dTaVJwSGF3emR3K0szWDh0amxHNnp0QW9paEY1?=
 =?utf-8?B?U1I0NTRWeGRaZ3FUMlN1SXl3eFpNSDJjNE5Qa2ttcGNndTBNQ1FBd1pFT3Yx?=
 =?utf-8?B?cGkwd0dJVmRGUm9hc245UC9sbXVuZ1pjcG5lc2IxL1VmTE1vQWdIOVFvUXdp?=
 =?utf-8?B?QTVGYkUwa21CU2NLU1l5UFU4bFRrSWFuaDZEZkpDRi80d2NPdzVBcU1Hampp?=
 =?utf-8?B?cW9Oc0RHM0lZZGY2L0gxYjA4Rkp1OXpJdnlGWktZYVJBSmlaMnFVREpWQXlm?=
 =?utf-8?B?aTVOcUJBdDhVR1Vrb1Vvc255YWJXNnNEOUVmS011T1daYVpCMFc4VERQMDJD?=
 =?utf-8?B?UXVoWm42ejVUZTZJNFd1VXkyRjBjYXdpSFp1VEgyUUpOQUFRMjBwaXRVZkd3?=
 =?utf-8?B?ditNaGl5NldScldvSkV5TEVNV21OaWF2Vmc0clFabmQwdlpXZXkwSjB5QklV?=
 =?utf-8?B?MFJDQkZOalNrcTRQYUdmOWVaMTdVMnlTZXVCaTVBU3RZSjVDSDhrVHJVOE9E?=
 =?utf-8?B?SG82aU1HT0xuKzV2VVRnSGp2RjBrczNDczc1NDVDUTkzOHVacklZcndLY2w2?=
 =?utf-8?B?WkNFM3kyUGJGMElrY2hLeUZyaWdUcTZONFhQY0RST3FHb0R2ajAwU05wYVlG?=
 =?utf-8?B?MXdIdXZFTEdqb0Rmdk1EWkpUYUI2UHRqZURwOTNKbzVwK1ZYelRFQjRuOUxa?=
 =?utf-8?B?V1NDV1FkVHlDQVhhWGN6NHNNYmFMWi84MFl5di80bUthS3Q1RlRZU2EzdnZK?=
 =?utf-8?B?ajVJbnIvRXRRMmxtb1huNmJmYzBxNXQxZm1xN2R3Y2UrQytMTS94ZTNrUVlO?=
 =?utf-8?B?Z3VyblVhVjFLd1lnOHV4T2ZXMFozR1NLZ1VjRExRSXhGTUZkOU1YaGp5dy9P?=
 =?utf-8?B?SkFEQ0tlOFZDalY5Sk80cE8zeittQitCVzM4WUpiWld1dWJ1WEV6S1l5bVB2?=
 =?utf-8?B?TmNTcVRNSVhCNzZadU9JVnlqQ29VTXkxOG5uQWl0ZnFQa0hpZUE0Y2dTK0FC?=
 =?utf-8?B?NXlHLzhOMGFBcmJkSFRZRWJtczBrYy9wVjUrWlhEK2VnZEpMTlgycllYQS9h?=
 =?utf-8?B?R0pJYWRxeWlLOHorc2VaL1VuOGE5akw4MFd3a2JIQzUrZHJmV09OQkxiVlZo?=
 =?utf-8?B?U2VZMlBlYXdldTdvQ05UdFFjdXRuNjZmZVVLUFJLK1NCT0RCcGxyQWR1dk51?=
 =?utf-8?B?Vy8vbG41MnlIb2thRjVJSzVBdkcvY1M5ZE1YVHB3di9XcFduaDdBVHVBOFlv?=
 =?utf-8?B?Q3JJYXorMjFqdExPeUk4Y0hPd3AzNUVMNVpxT1dhTDJ6ajhXOFRGbTVUZC8r?=
 =?utf-8?B?OW02YTRKMHVSV1h5UlRwMElKbzlNTmlNREJZTEwzYSt5ZXlVOXhjMlFSR1Vr?=
 =?utf-8?B?UUppVENkM0lCaExxSjZlczlMTS80bzBQczNwQzFJZ3ZZWXo1YWlndENaRkhp?=
 =?utf-8?B?ZWVRT0VpcHFWT2dJV20vTzg1WnF4YW1MS1VybzlZSThVZkgwYktsT2w4SkdW?=
 =?utf-8?B?NzNIcGdaU0VjQ01Mc3Q4c1FURVkzZmp4K2E3N2lIaHAzUnhQTnRUOGNQUERa?=
 =?utf-8?B?eC9jNys2UTVHYUhGdk5QTFg4UnM3ZTV6RzBFQlVha0JzazZ1R08zY2RUVmhs?=
 =?utf-8?B?amV4UWdxNnQwK2prK0MvZkhQQ3dYUktOSjhTUnRmNmpHOEVLbkFqR2srRUl4?=
 =?utf-8?B?MS9iQncxOGxMa2hkWHNZSHU0QVlJYk9oWlpnVTFZSlR5NlFLSUFIaTdVbytq?=
 =?utf-8?Q?qTo8/CytEa9HhWQY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D245CF09EEBAF4BB3DBBC3D1FB2F46C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pEiAuFNvEbERRXz3qwDkLkrtNnJyRAXLyJXzn932bDIp8eBdei5FWLDNfYopLPz9nDngaUy2LtWikGnaHbKoRcyKeRuNO1n9odwOcwJTdI2d7HV9HcyaCE0uIVvkgJiT8sOPiM6Zwk3mAyxGXIJrD6mHtrKVZT1cxISYIjD13Lti76imTDkvpMeR7PhcPQMPajs1Tg/QAFkxZ/Fh0Vo4Jq4dnAoGV8UQ2a+ArLJcbOuIPMeVEyVznnnZfSDdkYXf9J3jhrjMHhRGoqSZ4ja9gdFnKp3ELnuHKbF//D6r3Czk4zM9t4mlmQWRcepH10fd7d9wXfVI5QqORawI2ngP1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df1492f-03d7-47da-0aee-08df456fe145
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:31:33.2768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zRN6s8MJbbzJFvoCkFN5N5wI5Qsh8Gk4FmPsHVVWA320q9CMqbdzsBi7a0yFsAmklxtATp7JXkcP+TK+EbXQ9VWgl16dLcH3e239HkK++s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7261
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
PiBBZGQgc3VwcG9ydCBmb3IgaGFsZiBMRlBTIGN5Y2xlIGNhbGN1bGF0aW9uIGZvciBEUDIuMSBB
TFBNIGFzDQo+IGRlcGVuZGVudA0KPiBwYXJhbWV0ZXJzIGdvdCBjaGFuZ2VkLg0KPiANCj4gdjE6
IEluaXRpYWwgdmVyc2lvbi4NCj4gdjI6IEF2b2lkIHJldHVybmluZyBlYXJseS4gW0phbmldDQo+
IHYzOiBVc2UgaW50ZWxfY3J0Y19oYXNfdHlwZSgpLiBbU3VyYWpdDQo+IHY0OiBTcGxpdCBpbiBz
ZXBhcmF0ZSBmdW5jdGlvbiBiYXNlZCBvbiBIQVNfTFRfUEhZKCkgY2hlY2suIFtKb3VuaV0NCj4g
djU6IFVzZSBsdF8gcHJlZml4IGZvciB0aGUgSEFTX0xUX1BIWSgpIHNwZWNpZmljIGhlbHBlci4g
W0pvdW5pXQ0KPiANCj4gQ2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVs
LmNvbT4NCg0KVGhpcyBwYXRjaCBpcyBvayB0b2dldGhlciB3aXRoICJkcm0vaTkxNS9hbHBtOiBN
b2RpZnkgTEZQUyBjeWNsZSBjb3VudA0KZm9yIERQIEFMUE0iIEFsb25lIGl0IGlzIGtpbmQgb2Yg
d3JvbmcgYXMgaXQgaXMgbm90IHN3aXRjaGluZyB0bw0KaW50ZWxfZHBfbGlua19zeW1ib2xfY2xv
Y2sgYW5kIGdldF9sZnBzX2N5Y2xlX2NvdW50LiBJIHdvdWxkIHByb3Bvc2UNCnNxdWFzaGluZyB0
aGVzZSB0d28gcGF0Y2hlcy4NCg0KQlIsDQpKb3VuaSBIw7ZnYW5kZXINCg0KPiAtLS0NCj4gwqBk
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYyB8IDQxICsrKysrKysrKysr
KysrKysrKy0tLQ0KPiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCA4
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRl
bF9hbHBtLmMNCj4gaW5kZXggMmJmMmNhOTU2NDM5Li5iNmRlOTM4OTkwZGQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC04MSwyNCArODEs
NDkgQEAgc3RhdGljIGludCBnZXRfc2lsZW5jZV9wZXJpb2Rfc3ltYm9scyhjb25zdA0KPiBzdHJ1
Y3QgaW50ZWxfY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSkNCj4gwqAJCTEwMDAgLyAxMDAwOw0KPiDC
oH0NCj4gwqANCj4gLXN0YXRpYyB2b2lkIGdldF9sZnBzX2N5Y2xlX21pbl9tYXhfdGltZShjb25z
dCBzdHJ1Y3QNCj4gaW50ZWxfY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSwNCj4gLQkJCQkJaW50ICpt
aW4sIGludCAqbWF4KQ0KPiArc3RhdGljIHZvaWQgbG5sX2dldF9sZnBzX3BlcmlvZF9taW5fbWF4
X3RpbWUoY29uc3Qgc3RydWN0DQo+IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUsDQo+ICsJ
CQkJCcKgwqDCoMKgIGludCAqbWluLCBpbnQgKm1heCkNCj4gwqB7DQo+IC0JaWYgKGNydGNfc3Rh
dGUtPnBvcnRfY2xvY2sgPCA1NDAwMDApIHsNCj4gLQkJKm1pbiA9IDY1ICogTEZQU19DWUNMRV9D
T1VOVDsNCj4gLQkJKm1heCA9IDc1ICogTEZQU19DWUNMRV9DT1VOVDsNCj4gLQl9IGVsc2Ugew0K
PiArCWlmIChpbnRlbF9jcnRjX2hhc190eXBlKGNydGNfc3RhdGUsIElOVEVMX09VVFBVVF9FRFAp
KSB7DQo+ICsJCWlmIChjcnRjX3N0YXRlLT5wb3J0X2Nsb2NrIDwgNTQwMDAwKSB7DQo+ICsJCQkq
bWluID0gNjUgKiBMRlBTX0NZQ0xFX0NPVU5UOw0KPiArCQkJKm1heCA9IDc1ICogTEZQU19DWUNM
RV9DT1VOVDsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCSptaW4gPSAxNDA7DQo+ICsJCQkqbWF4ID0g
ODAwOw0KPiArCQl9DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBsdF9nZXRfbGZw
c19wZXJpb2RfbWluX21heF90aW1lKGNvbnN0IHN0cnVjdA0KPiBpbnRlbF9jcnRjX3N0YXRlICpj
cnRjX3N0YXRlLA0KPiArCQkJCQnCoMKgwqAgaW50ICptaW4sIGludCAqbWF4KQ0KPiArew0KPiAr
CWlmIChpbnRlbF9jcnRjX2hhc190eXBlKGNydGNfc3RhdGUsIElOVEVMX09VVFBVVF9FRFApKSB7
DQo+IMKgCQkqbWluID0gMTQwOw0KPiDCoAkJKm1heCA9IDgwMDsNCj4gKwl9IGVsc2Ugew0KPiAr
CQkqbWluID0gMzIwOw0KPiArCQkqbWF4ID0gMTYwMDsNCj4gwqAJfQ0KPiDCoH0NCj4gwqANCj4g
K3N0YXRpYyB2b2lkIGdldF9sZnBzX3BlcmlvZF9taW5fbWF4X3RpbWUoY29uc3Qgc3RydWN0DQo+
IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUsDQo+ICsJCQkJCWludCAqbWluLCBpbnQgKm1h
eCkNCj4gK3sNCj4gKwlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9DQo+IHRvX2ludGVs
X2Rpc3BsYXkoY3J0Y19zdGF0ZSk7DQo+ICsNCj4gKwlpZiAoSEFTX0xUX1BIWShkaXNwbGF5KSkN
Cj4gKwkJbHRfZ2V0X2xmcHNfcGVyaW9kX21pbl9tYXhfdGltZShjcnRjX3N0YXRlLCBtaW4sDQo+
IG1heCk7DQo+ICsJZWxzZQ0KPiArCQlsbmxfZ2V0X2xmcHNfcGVyaW9kX21pbl9tYXhfdGltZShj
cnRjX3N0YXRlLCBtaW4sDQo+IG1heCk7DQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgaW50IGdldF9s
ZnBzX2N5Y2xlX3RpbWUoY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNfc3Rh
dGUpDQo+IMKgew0KPiDCoAlpbnQgdGxmcHNfY3ljbGVfbWluLCB0bGZwc19jeWNsZV9tYXg7DQo+
IMKgDQo+IC0JZ2V0X2xmcHNfY3ljbGVfbWluX21heF90aW1lKGNydGNfc3RhdGUsICZ0bGZwc19j
eWNsZV9taW4sDQo+IC0JCQkJwqDCoMKgICZ0bGZwc19jeWNsZV9tYXgpOw0KPiArCWdldF9sZnBz
X3BlcmlvZF9taW5fbWF4X3RpbWUoY3J0Y19zdGF0ZSwgJnRsZnBzX2N5Y2xlX21pbiwNCj4gKwkJ
CQnCoMKgwqDCoCAmdGxmcHNfY3ljbGVfbWF4KTsNCj4gwqANCj4gwqAJcmV0dXJuIHRsZnBzX2N5
Y2xlX21pbiArwqAgKHRsZnBzX2N5Y2xlX21heCAtDQo+IHRsZnBzX2N5Y2xlX21pbikgLyAyOw0K
PiDCoH0NCg==
