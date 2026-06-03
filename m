Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556BACD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C98F10FFB1;
	Wed,  3 Jun 2026 15:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hN0ML422";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB25D10FFB0;
 Wed,  3 Jun 2026 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780499591; x=1812035591;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iB+/MQJG8pjDUl3hX+dNSElMQvU0sC0AS+UtrjUjtR4=;
 b=hN0ML4229EZWzVc4N5u053O7pCxdLFcq58XVksKMpP5sov9VLmb9XYtL
 5kbXiAB+2aXwLEzQaLRjnu9aTIeCNMQwZzdDIip43XKmSB0+ckpoMEnlu
 bvqAONeEWGqvGjxDS88CYIkzXV35WT6s8WDxYNmXMgfTguh6E96l6nZ6F
 YUaoWrdfaeenGZiyyRpS7SBk8Zi9TpMgAfm399aq4ZpS4sIZ1cGIZl5Nf
 UMwTzFJ0CDFfSbrDmDx9p6cqbD68YoamPbTHAG3KrW/vGta+USP9WlFDS
 2yACFtmVIar5nKhZqh/PuQ4KLmE24KMzyLm43uDRCusrqQl4zlJFK+JSP g==;
X-CSE-ConnectionGUID: 8Ap/GCqbSn+JnJUc56f22w==
X-CSE-MsgGUID: D33WNI58SCed3OlXfrIhVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81052538"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="81052538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 08:13:10 -0700
X-CSE-ConnectionGUID: vhs9IxRxSC68tq6GCiQvbA==
X-CSE-MsgGUID: rb2tSgDHRHuIhmL0CrukvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="243203216"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 08:13:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:13:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 08:13:09 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7MLMCBJbWqPivdUBn52iR0hGmXUM/N672/25eIjffMQRVD77MlYgow4b5Y9otCi/69FSJRyALpjaizKT53DUAPzXtRuk3c5Xry5m9dpBa1Ky+gj51MYiYnKSanlvNKCIc/oLkCR7rCkw+HX2RBXbXSyys+CxhjxoJS3tpW9NUU7Nt0T+iZNzk/AzpaWKjEOG7lCHJ1lUT1iSQZsJiMQZHwys1Op9+bS3gX37/psVBK+9NMyQVjQ2n7n7fjQCvxFrmXDHVDzOF4LCYJi+5KraBCa/5LXcA4m4n5z2lqNbnHGXp3bEYExe10shBFlkfAwZvdgjSdJUF3RZT1huEqpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB+/MQJG8pjDUl3hX+dNSElMQvU0sC0AS+UtrjUjtR4=;
 b=i8PPEI357eBJQbSKlPkZNN0ls3ecbUI4fW4PN6PUffbfaPBG8a++PvlMsDTYjvW1lgxOwVV2nVVfLpor5Dx0u+BffxLOS7RdIDQZhq4cJHJ11q97IFlMD8ehEv/+FE+VUV0oqjQq6HUDnwnNOw+psbR8w5cQAA/HaN0u3Tm2eAoO3PeX8NjfAsLDYFlzhS89YOso36Xp9BSog0JjxlDRCLeS0D/FnmFU3Xt++l9oluHHDRF9ScIbCAIJe3b8jWQTYg8clGo+/KvsnzK2PMlV+PB5Pf/DCMXFUr0Ag+jFfVv9zdFkBs2iRURUUSdy384Ecl1XCIwCDU2XR/MqJATRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) by
 SAWPR11MB9782.namprd11.prod.outlook.com (2603:10b6:806:4c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:13:07 +0000
Received: from DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::3e49:3435:98fa:130f]) by DS0PR11MB7733.namprd11.prod.outlook.com
 ([fe80::3e49:3435:98fa:130f%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:13:07 +0000
From: "Hellstrom, Thomas" <thomas.hellstrom@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Auld, Matthew"
 <matthew.auld@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "nirmoy.das@intel.com" <nirmoy.das@intel.com>, "Yang, Fei"
 <fei.yang@intel.com>, "Vishwanathapura, Niranjana"
 <niranjana.vishwanathapura@intel.com>, "Roper, Matthew D"
 <matthew.d.roper@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Brost, Matthew"
 <matthew.brost@intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "Yadav, Sanjay Kumar"
 <sanjay.kumar.yadav@intel.com>, "Lankhorst, Maarten"
 <maarten.lankhorst@intel.com>, "Nerlige Ramappa, Umesh"
 <umesh.nerlige.ramappa@intel.com>, "Lahtinen, Joonas"
 <joonas.lahtinen@intel.com>
Subject: Re: [RFC PATCH 1/3] drm/xe: skip banning kernel migration queue on
 TDR timeout
Thread-Topic: [RFC PATCH 1/3] drm/xe: skip banning kernel migration queue on
 TDR timeout
Thread-Index: AQHc81KLrmXcKtXVsU6sCUdXdIYCg7YsxjaAgAATfQCAABadAA==
Date: Wed, 3 Jun 2026 15:13:07 +0000
Message-ID: <0f807204d796836f3e993118c622352a3800f95b.camel@intel.com>
References: <20260603120641.473434-4-sanjay.kumar.yadav@intel.com>
 <5634e7fc-6931-465f-ba3d-4068b4fe53ba@intel.com>
 <aiAxiiYO8nkE2gvl@intel.com>
In-Reply-To: <aiAxiiYO8nkE2gvl@intel.com>
Accept-Language: en-SE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7733:EE_|SAWPR11MB9782:EE_
x-ms-office365-filtering-correlation-id: 0478ce5d-b5c0-4b2c-1f26-08dec1829e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|3023799007|4143699003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: 7mg/fLzhmCTZGJn0z8AKQHs1gAhcHr6GpUPCHwKKtM34Ig7hVfUK2DkUhXJz8MMtCzV3zvLw8A5TqgEoWPNN4gYmts/lUg7awaFTnt+hEHIjpMxRcd8OKIuFIQjGmRa65CVLkVcH2NGZROF10B1vpVGKjc7QJ46W7voSI6WR9QpZIlZf8OuKHg/pqps2d3cayAbYSaEZCllZ8877rOuUgjSkcYQ0FtFJ3bQdMPFHhy1YwRMqIYD21FhQuL5T+hmgjzdabSmhpHCGWp393Hk8VgZ9SgPevF6rHXamKXnmsUCWRVHPfwn+9pxFEalYHGgAY8PjFJ35fPpvAFou10gDQ9np9ZGt6oPeZRE7xovLYuDeC+DwBmXdR0s9FPcOoHtXfz69iUTdWue8JQg9uR1OibgAkw5yPVNQauvmQ7d0IWhr2oJUI2R+OFz53XSWEr5M56EtY5Fd5AAaQMqBMPVkby4JO/TA2xoj68aMbw6T4lSxMBqjEhnf+5XYjC0L7zSh9eNtMDRIih39H/VEGbkPuTa/jFTKUj9FnetizJuMIqsWiqcG7E+DrrphfK6TNg4K2uG+1C4eSt/7HCNB6HoamPXaAOsr4JX3H6LbaQBDu9+pczrGHZvJ/egiyESwnTtLDw+Piu1AiirH0D6LSsvjbZr+w+5WeDgikfrr6ca+ezaKXeDL7zcBdbnYU3W0SHAc0m4JRtMatnCdUlHYa4mbflgWKMpex9vLClQSaaJ17Xi5R4oF6XT34y6K7+dE8udf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7733.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(3023799007)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU10ckp2UytsRUdzQWdtWnZXQ3hMNWZ2ZTVuc1BnMTlCL0dDc0JIUWhwZ2hR?=
 =?utf-8?B?NGVBRjFvN1BzamJrcGs5Y0EwaG01dVo0aEVnVEV6VXZDK3pnRWVoUXoyQTZN?=
 =?utf-8?B?N0Z5TjBUL1R1MDc3TTc2QThSMEc2bTJydnNITkllVFRLNC93YlNXUVIxOHRT?=
 =?utf-8?B?bmpTNHdVV3ZrRUpLME41ZXptTzloMysxanNFYjhwemV3S0JZRUpLTFBtVU1D?=
 =?utf-8?B?ZTZQeFhMOWJ1UEF1bHZlK28wbWE2ZWZQYmRqQVE0bFJBUkVjTnNTYWhSZmow?=
 =?utf-8?B?UUh0K0FWZ3VkUk9MUGloNkxieCtlR1ppaWd6ZGMvbFNNQytCUU5QMmprSkxa?=
 =?utf-8?B?V3RRMlBXRGlyRHV4QUFRZ251ZGN4NHhjYXkyWkVoMURpTnVZdkkxT2p2Zk5w?=
 =?utf-8?B?ZFFzNWViZHJDR09FVm5Zd0hHdEdwK2hkdk9PdWs0Z2xGQ01FcnBGc2hUc1B5?=
 =?utf-8?B?dHpNc1VrVEFyMHdwKy9iNEZoOWIycXpTL2lxREZkbnpuWHJTa3Q5MUJVelY1?=
 =?utf-8?B?bU5YenFNV1lTUHpPQS9kL3JKL1Z6cmUyV0NPYlEzazlUbDRjM3lORjRaOUdL?=
 =?utf-8?B?b2FwNU51RGplb3dBY2Rrdm90ZUJpQjYwWGdDVmFyUkt2MnBxVXZrOEJISVll?=
 =?utf-8?B?aTVNYjdVL2UxL1FvdC96QmFBVzE2ZzVKQU9ieCtRZTdHbXkxNW94K0FGNm9K?=
 =?utf-8?B?eWU1dzB2SWxqekR4SVNwdkFpODVqTC9qVTQwQURkK3BYQ0lQVGR6NUdwTHRI?=
 =?utf-8?B?NmZ1RnIvSEpBTlpLbk1WaUVLZ0RhN0hvaXdyYmN3U2JrYmNtZm56TlBzUmhS?=
 =?utf-8?B?dE1wQVlCU1d6cm1kMGRIMERpcGpYUjhWak1mM3RDb1hTd2paYTQzQ2FnbWtU?=
 =?utf-8?B?V2M1c1oycHMzbjZnOSswYm9IeXpCZjI2NVZSMnQ4RWw0U1ErK2EvT2VYZWpv?=
 =?utf-8?B?N1FoR2pmTG1WOVVQbFA4bHVxU0Q2c0FBaVAwRVVnTVBSb3VFRmJvZmphRVR5?=
 =?utf-8?B?UmRQRndDU0Z1VmhwYzdBYnFtZXJnZHNVdnJ1a2tYby90ZzlNR3J2ODV5Q1hB?=
 =?utf-8?B?dkFxQ3MrYmw1NktOZ2xZUjRicDAzVUFIRGM4SisyWFF2UkdPUXlTemdMcnVE?=
 =?utf-8?B?ZU5wbnh5d3VmZlhHWWFqR2lTbFk3WjRteDM3bmcxZ0V5clhCNFNWM1dqcEtn?=
 =?utf-8?B?S0hYSXhTZWdVbXFJVmhJbjRNU3ExQnFudjBJWXhtd3g5M3F0b2RFVHpzMEhj?=
 =?utf-8?B?SGlpb0FERUJ1SGhBbm5kZHBDYWVGRGVpTnJIZTNsZ2kwRDZyR00vcWtwaith?=
 =?utf-8?B?NDN3Z3cyNDZzcmJQNEtQeW8wdG9iZEl6RFlSbGNwaUxhNlNUUU9MVXdiYndv?=
 =?utf-8?B?Si9rNHJqMHdqZFhtdHZuZWpmQWFUeVZXZHZaK00wbHdiS1g3bS9RSWhsWEVF?=
 =?utf-8?B?dlhLNGttVDBnbmYrbExGMHFta1RGcEJUQkhtREZMZmF4QU5hUjZiMk1kY0x6?=
 =?utf-8?B?OWlTLzN1K3ZsSWcxWnorbENySWhQcDc0dXN6bmlEUWpNdkZYSm4xdEFGekh0?=
 =?utf-8?B?bnNXU21GbE1EaDZBWk1GazQxTDhMM1M1U3NoOGxpbXpQN3dubisrUDV6a2xE?=
 =?utf-8?B?dUJoZkIyOUIwYUxYK0FGenlsb3g5ZWh3cENQb2VHcjJjT1RtdUxYc2NtejFK?=
 =?utf-8?B?eVByeVdkdUZMSlBRMmFjbko5QVF4eTdtdWwzMGNmSXJqaFFvcC9MT25TUWdR?=
 =?utf-8?B?V2JOaDBEVFpydHhGallVTStwR0tuSUFBaEtyTG5KUHpJaVk5Mlk1YmpYOW9F?=
 =?utf-8?B?RjRUeXNaSDlHRzZHNGhmbzV3dndtbjB6OEYzZFQ0bkZrYjdqM3ZsMnVrQ0pG?=
 =?utf-8?B?Y2NtTERBR1pMRWY1WDV0RUxCcXVmQW9ZZlA4eXBnT2ZMeGFITi9xellwZ1lz?=
 =?utf-8?B?MHJ1YlM4d2xkTDdvMWZFdllRb0VhUFJNcEUrcldQQm4wNG9SSzNoK3ZteWts?=
 =?utf-8?B?U1k3YnZyVUd6c2lORTFySGNCNnZ5NDNyWkw5Qm1GMEVSMXNvSCszaVFrcmZM?=
 =?utf-8?B?a05jRWZxRlJjYUJYWkZkT3ViUXBzbkZJVzBhUnpMcWpobkROSy9ib0lSMDVW?=
 =?utf-8?B?eGIrVW9VSGlGSlFQY3ZDQjlhZE9FR2VvenhGZy94eEsxbVVueW81OWpXNk0r?=
 =?utf-8?B?TEhPYlVVaEpmdGo1c2Z6TjZRVTc1Y1crUjhnZDNUMkw4YTA5NVRxSlorKytW?=
 =?utf-8?B?S0VtbktRSkJEYk9oTUhNT2Y4R0g5NUV3QXh1eWFPVzZ1eGFDTjhtcEFWcGtn?=
 =?utf-8?B?Q1N6STFGR3B5RWdrWndia0orZHRvQmRYSDkwNzdYdnBjaSt2Rno2SVRHQnFo?=
 =?utf-8?Q?6Ogw2gGT8oHy6/TkvaqmcCoG2m4gVNknLFUtFTD7F/fQG?=
x-ms-exchange-antispam-messagedata-1: FE+hk3IwViXkOg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCE89549FFFC3948BD6451CBC5C2A2D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IKCuQtz7NivNnWVtTihUFpqjW4QkEhGcXyJiWIIuT4KY2/5Z/Yd353ML1rRpHMAbft80Kno6U7saLmG3Hy9tXYOf2AB9sL2rS3KK6TlcV8VwIeyIPSBzHMGpZJKjtnvzC4GK94bbkfcuEsUdI76yAS4grO0+7F9uI3sPq8FF+tHsxkveQj5ISPKNfjyLjd1ChyiDrf6KvELdXouWQQXdTv71fc6tP/6xw/GCXI41cNKYM8YMXskCxifUms3ynk/mC9H+YPfylywsCPz/lDZeChO7Lh/PiGf+6lRfweqmBjvTSaesNGy6nrRta5RHSlE9zDfVnH5DmSa8iR7DhJjXTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0478ce5d-b5c0-4b2c-1f26-08dec1829e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 15:13:07.5742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRPgnGyvjE5jwKlJH1ojY/wXg9d6ebDOeGc36mxYAyL7412Kw9dpobyFMS4fArPPZMDAALWwQ3iXz32FkTdbQ7/HhqAy9wb/C8XatrbxizI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9782
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

T24gV2VkLCAyMDI2LTA2LTAzIGF0IDA5OjUyIC0wNDAwLCBSb2RyaWdvIFZpdmkgd3JvdGU6DQo+
IE9uIFdlZCwgSnVuIDAzLCAyMDI2IGF0IDAxOjQyOjI1UE0gKzAxMDAsIE1hdHRoZXcgQXVsZCB3
cm90ZToNCj4gPiBPbiAwMy8wNi8yMDI2IDEzOjA2LCBTYW5qYXkgWWFkYXYgd3JvdGU6DQo+ID4g
PiBndWNfZXhlY19xdWV1ZV90aW1lZG91dF9qb2IoKSB1bmNvbmRpdGlvbmFsbHkgYmFucyB0aGUg
cXVldWUgb25jZQ0KPiA+ID4gYQ0KPiA+ID4gam9iIHRpbWVzIG91dC4gRm9yIHRoZSBrZXJuZWwg
bWlncmF0aW9uIHF1ZXVlIHRoaXMgaXMgZmF0YWwg4oCUDQo+ID4gPiBvbmNlDQo+ID4gPiBiYW5u
ZWQsIG5vIHBhZ2UgdGFibGUgbWlncmF0aW9ucyBjYW4gY29tcGxldGUgYW5kIHRoZSBHUFUgaXMN
Cj4gPiA+IGVmZmVjdGl2ZWx5IGRlYWQgdW50aWwgZHJpdmVyIHJlbG9hZC4NCj4gPiA+IA0KPiA+
ID4gVGhlIHN1Ym1pc3Npb24gaXMgYWxyZWFkeSBzdG9wcGVkIGFuZCB0aGUgdGltZWQtb3V0IGpv
YiBpcyBlcnJlZA0KPiA+ID4gb3V0LA0KPiA+ID4gc28gYmFubmluZyBpcyBub3QgbmVlZGVkIGZv
ciBjb3JyZWN0bmVzcy4gR1QgcmVzZXQgaGFuZGxlcyB0aGUNCj4gPiA+IGFjdHVhbA0KPiA+ID4g
aGFyZHdhcmUgcmVjb3ZlcnkuIFNraXAgYmFubmluZyBmb3Iga2VybmVsIHF1ZXVlcyBzbyB0aGV5
IHJlbWFpbg0KPiA+ID4gYXZhaWxhYmxlIGFmdGVyIHJlc2V0Lg0KPiA+IA0KPiA+IElzIHdlZGdp
bmcvcmVsb2FkIG5vdCB0aGUgbW9yZSBjb3JyZWN0IHRoaW5nIGhlcmU/IEtlcm5lbCBqb2IgaXMN
Cj4gPiB1c3VhbGx5DQo+ID4gcGVyZm9ybWluZyBjcml0aWNhbCBhbmQgcG90ZW50aWFsbHkgc2Vj
dXJpdHkgc2Vuc2l0aXZlIHdvcmssIGxpa2UNCj4gPiBtZW1vcnkNCj4gPiBjbGVhcmluZywgbWln
cmF0aW9ucywgYmluZGluZyBldGMuIElmIHNvbWV0aGluZyBnb2VzIHdyb25nIGluIG9uZQ0KPiA+
IG9mIHRob3NlDQo+ID4gam9icywgaG93IHNob3VsZCB3ZSBnbyBhYm91dCByZWNvdmVyaW5nIGZy
b20gdGhhdD8gSXMgZHJpdmVyDQo+ID4gcmVsb2FkL3dlZGdlDQo+ID4gbm90IHRoZSBtb3JlIGFw
cHJvcHJpYXRlIHRoaW5nIGhlcmUsIG9yIGxlYXN0IHdvdWxkIG5lZWQgYSBtb3JlDQo+ID4gZWxh
Ym9yYXRlDQo+ID4gcmVjb3Zlcnk/DQo+ID4gDQo+ID4gRm9yIGV4YW1wbGUsIG1lbWNsZWFyIGdl
dCBudWtlZCwgd2hhdCBzdG9wcyB0aGUgdXNlciBmcm9tIGFjY2Vzc2luZw0KPiA+IHVuY2xlYXJl
ZCBtZW1vcnkgbGF0ZXI/IE9yIGEgbWlncmF0aW9uL2NvcHkvc2F2ZS9yZXN0b3JlLyBqb2IgZ2V0
cw0KPiA+IG51a2VkLA0KPiA+IGZyb20gY29ycmVjdG5lc3MgcG92IGhvdyBkbyB3ZSByZWNvdmVy
IGZyb20gdGhhdD8NCj4gDQo+IEkgYWdyZWUgd2l0aCBNYXR0IGhlcmUgc29tZXRoaW5nIGlzIG9m
Zi4gd2UgY2Fubm90IGJsaW5kbHkgc2tpcCB0aGVzZQ0KPiBrZXJuZWwgc3VibWlzc2lvbiBjYXNl
cy4uLiAoVGhpcyBhbmQgdGhlIG90aGVyIHBhdGNoIGluIHRoaXMgc2VyaWVzKQ0KDQorMQ0KDQpT
aW5jZSBJJ20gbm90IDEwMCUgdXAtdG8tZGF0ZSB3aXRoIHRoZSBzY2hlZHVsaW5nIEkgYXNrZWQg
Q2xhdWRlIHRvDQpsb29rIGZvciBhbnkgc29mdHdhcmUtcHJvcGFnYXRlZCBlcnJvcnMgb3IgYXBw
YXJlbnQgU1cgYnVncyB0aGF0IGNvdWxkDQpjYXVzZSB0aGUgbWlncmF0aW9uIGpvYnMgdG8gZmFp
bCAoYXNzdW1pbmcgdGhhdCBvdXIgYmF0Y2hlcyBhcmUgT0sNCm9mYyksIGFuZCBpdCBjb3VsZG4n
dCBmaW5kIG9uZS4gSXQgc2VlbXMgbGlrZSB0aGUgZHJtIHNjaGVkdWxlciBoYW5kbGVzDQp0aGUg
ZGVwZW5kZW5jeSB0aW1lb3V0IGNhc2UgY29ycmVjdGx5Lg0KDQpJZiB0aGVyZSBhcmUgcmVjb3Zl
cmFibGUgcmVzZXRzIHRoYXQgbWlnaHQgb2NjYXNpb25hbGx5IHNwaWxsIG92ZXIgdG8NCnRoZSBt
aWdyYXRpb24gcXVldWUgd2Ugc2hvdWxkIGZpZ3VyZSB0aGF0IG91dCBhbmQgaW4gdGhhdCBjYXNl
IGNvbnNpZGVyDQppbXBsZW1lbnRpbmcgYXN5bmMgU1cgY2xlYXJpbmcgLyBtaWdyYXRpb24gZm9y
IHRoZSBmYWlsZWQgam9icyAobGlrZQ0KaTkxNSkgdG8gYXZvaWQgd2VkZ2luZy4gQnV0IEknZCBy
YXRoZXIgc2VlIHVzIG5vdCBkb2luZyB0aGF0IGlmIGl0J3MNCm5vdCBzdHJpY3RseSBuZWNlc3Nh
cnkgd2l0aCBhIHByb3ZlbiByZXByb2R1Y2VyLg0KDQpUaGFua3MsDQpUaG9tYXMNCg0KDQo+IA0K
PiA+IA0KPiA+ID4gDQo+ID4gPiBGaXhlczogYmI2M2U3MjU3ZTYzICgiZHJtL3hlOiBBdm9pZCB0
b2dnbGluZyBzY2hlZHVsZSBzdGF0ZSB0bw0KPiA+ID4gY2hlY2sgTFJDIHRpbWVzdGFtcCBpbiBU
RFIiKQ0KPiA+ID4gQ2M6IE1hdHRoZXcgQnJvc3QgPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPg0K
PiA+ID4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVs
LmNvbT4NCj4gPiA+IENjOiBSb2RyaWdvIFZpdmkgPHJvZHJpZ28udml2aUBpbnRlbC5jb20+DQo+
ID4gPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQuNg0KPiA+ID4gU3VnZ2VzdGVk
LWJ5OiBIaW1hbCBQcmFzYWQgR2hpbWlyYXkNCj4gPiA+IDxoaW1hbC5wcmFzYWQuZ2hpbWlyYXlA
aW50ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2FuamF5IFlhZGF2IDxzYW5qYXkua3Vt
YXIueWFkYXZAaW50ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoCBkcml2ZXJzL2dwdS9kcm0v
eGUveGVfZ3VjX3N1Ym1pdC5jIHwgMyArKy0NCj4gPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS94ZS94ZV9ndWNfc3VibWl0LmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2d1Y19zdWJtaXQuYw0KPiA+ID4gaW5kZXggYWI1MDE1MTNkODA2Li5lNmFkNTdjYmJm
MGUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX3N1Ym1pdC5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX3N1Ym1pdC5jDQo+ID4gPiBA
QCAtMTU0Myw3ICsxNTQzLDggQEAgZ3VjX2V4ZWNfcXVldWVfdGltZWRvdXRfam9iKHN0cnVjdA0K
PiA+ID4gZHJtX3NjaGVkX2pvYiAqZHJtX2pvYikNCj4gPiA+IMKgwqAJaWYgKCFleGVjX3F1ZXVl
X2tpbGxlZChxKSkNCj4gPiA+IMKgwqAJCXdlZGdlZCA9DQo+ID4gPiBndWNfc3VibWl0X2hpbnRf
d2VkZ2VkKGV4ZWNfcXVldWVfdG9fZ3VjKHEpKTsNCj4gPiA+IC0Jc2V0X2V4ZWNfcXVldWVfYmFu
bmVkKHEpOw0KPiA+ID4gKwlpZiAoIShxLT5mbGFncyAmIEVYRUNfUVVFVUVfRkxBR19LRVJORUwp
KQ0KPiA+ID4gKwkJc2V0X2V4ZWNfcXVldWVfYmFubmVkKHEpOw0KPiA+ID4gwqDCoAkvKiBLaWNr
IGpvYiAvIHF1ZXVlIG9mZiBoYXJkd2FyZSAqLw0KPiA+ID4gwqDCoAlpZiAoIXdlZGdlZCAmJiAo
ZXhlY19xdWV1ZV9lbmFibGVkKHByaW1hcnkpIHx8DQo+ID4gDQo=
