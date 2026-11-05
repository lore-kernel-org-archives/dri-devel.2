Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7CE606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BWZBo67A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E1110E5F2;
	Thu,  5 Nov 2026 14:12:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D201B10E277;
 Thu,  5 Nov 2026 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793887946; x=1825423946;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U3XiSL7YlrGeq6aqdVJj9z5pRnCn9nYrvC/pbUdIXf0=;
 b=BWZBo67AMepz3+srDa4DhJrHiUfOlqYXxtbBTZh71FOTni8q3Sew9o28
 4Or+b3w359+a0yHj9NlRU521D8TOsdVvssdKoXnUgHMCLyp2g2dT1LHhd
 PVSCuFvOQBR2H/EDxkRYvjxiHRC2UBEGwTddRkHvhDqHg4Vth2Pl8JVSd
 JQPA9FBuK3fanIYAqMZO7YUcfe3biyir6wF+4X/h13A++iMQQa/jmXpWa
 vP3RDK8Lg6mBq0Xo51NXqQOH0dfuF/FcRGE3pCJhH3yne6Yvq1Tlc41XT
 5OOQE0+ntovhf/KYYwUtP/12RKHE7K7MADU3FiNL0MEdCJ6mEWuX2+vRG g==;
X-CSE-ConnectionGUID: ssuNX8khQn+1e4upxUGz+g==
X-CSE-MsgGUID: 7V2bR5YhQpGUzI6r3t0TsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2547200"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2547200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:12:23 -0800
X-CSE-ConnectionGUID: /7zVW5t6Rcu+L5uog+37Dw==
X-CSE-MsgGUID: dxnI/OEUR92ytDhEDZPWTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6900492"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:12:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 06:12:22 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 06:12:22 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 06:12:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8fNhRdR3stNX7sjZxXhFJIxSB7aIxuBVFVDPWsBqSVNacSms1MW/CwHMbsSC31W/nHlqMyvGrj78F8iqbHIxSOIUhodoM5BEOQ+hWErJuks7ul9gD90J84m0HncIQRTZTTtgHxUQRxg2AU5WYfhxLHSLBBYdZ1hYCNq15Tpdzpp2AQBxsmxG1Qzv9U/QVXuQVkuc517rxqMA3q+Rst8xilRz7SYsxmWNS8gSLVobGKFtQySbnCUUiO7iudazDUEpKoSpuj2oJYFskFjIlPNZK1mNePlcRiCF4MGsH3Q9U2DmyQ+nMirJSjchtqhocLwK3HrVoqPuWKl8Euj9H0S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3XiSL7YlrGeq6aqdVJj9z5pRnCn9nYrvC/pbUdIXf0=;
 b=XAl7+gD4xMPOl6aDasvCkjCdS65Wdz1JpqJjO6MgkE1KtHKdu/uOutsBNU48KzWOdUN0EHJfrBlS3lxHjkZTf+2gRqKVUQhf1mqvafzKK6btyaot4k26VuDxfzkP1Q6XKrfHXf8tqbdMl4yo2Ed59v8pdilgEGJUIq5kD5BkE+5QfKcN/MPM35st9f3iH675+I8WRWbhBQiZMttkDiXmALTP979Co6ZYGNcgN6f1Ost6ftW5Q1+osaMqrC83WCAo5BAuHNek0K/DaDlKJrnyxmBD/IkKOdohKUwsEG7UuE7Jqd2j6ekv7dViTAGIklDRD5Nf9uqD2OQMq+7IgVreLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:12:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:12:18 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 3/5] drm/xe: Mark VMs as closing before queue cleanup
Thread-Topic: [PATCH 3/5] drm/xe: Mark VMs as closing before queue cleanup
Thread-Index: AQHdRcFYHHTrTxanikGGh4fmKYjFg7cf0tJw
Date: Thu, 5 Nov 2026 14:12:18 +0000
Message-ID: <DS0PR11MB871807B50344B8869802E47781772@DS0PR11MB8718.namprd11.prod.outlook.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-4-arvind.yadav@intel.com>
In-Reply-To: <20260916095337.3104891-4-arvind.yadav@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8718:EE_|SJ1PR11MB6180:EE_
x-ms-office365-filtering-correlation-id: be4566a8-e8fb-44da-0451-08df3b46ccf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|38070700021|261026121527099003|261026140227099003|4143699003|11063799006|56012099006|261021123027099003|261009223027099003|261102123227099003|261021121427099003|261022105027099003|261028144727099003|261022075727099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: bqah8GN2Zq+7YAa5PQya14avJA0WCZdMpWiBNrtf3j47JWbfAQYAZzDHMzvVuHU2V5QvkK0Kzat6S7atwzbhqaIfnSekhTiNWeIPWbMgi/MaWPIIWz6b4M+FDyVDwUY5MLQ0YesfVl1ezkMT2mztJf27bT5g5mpAVcZpkZ/ROSv1yQQKOHAthUae48iFbHH9KLgy3nzHN0BTAoR0w8vxbPSMuNwltWUbS83j2sxGt0aF0nRR0JVGZ6tKWmuGqxKb0fb5H4E49JItnFtqVi7jKjQ1Qw3uChU7mBDHmpIbbyQgPeIkvwGflC57RV9Gyn1vhcnOZUSlrVh2cJBrNkPGX8bAffUif/hmgym3UtvTeSzp4tVRiwaXhTlIMFf+GOAQT1xkN/Tj5AP7fPhEJ9cqryyaeajOSWBf4Q3ReGes+0jU50OgG9KI1HSTdbwO+pT2MQXQNx7SAbImw8Dh1c9hNbfp7YgvwR+4khwMvCT0zAuTIPM9Ke0WcwBFWcjVNpJImaXCeYoch+3bBvPW29+Jq/IlOHkiDTSPV801yuInSU6lkK13T8FFviJKFVncYAbPxHTFODbVLWI1N823paKM7O/fbVQpt7lsEVTA2Fh6epwf4vCtOHD3GYkFkcyTHJWyJu8PjOqLd2Hl0oMb1adc2yJAZJAHOVABnYfIvVDuAf4mMOVSIe0qmxqdSkCAgybYe4XBf8eeMZGNl3PRYqgOy23WkhJQkBZy4nnusIU+/Pw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(38070700021)(261026121527099003)(261026140227099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpEaHoyUW9YYkhFUlY4VVIzTDZ4Njd1UEpGNTE5TDIyUCtqRTdabENLMWlx?=
 =?utf-8?B?RFY4UnZZUDU1MEZTb1gxWkpOUUJFRGQ5ZVE0TkNMOG9yYzhOQlNUaGQ0NDdh?=
 =?utf-8?B?TXU5dlk2SzFIc3BKSU1abkM1cmNBN2hkaHNnQzZ1bVI4OGlBZmEzNjVYa2pI?=
 =?utf-8?B?Wm9JeEY1Z1VpZ0dweCtRZjk0cUN4eEJVMUpNT2p4YjFTZjJEQWdlYy82WmYw?=
 =?utf-8?B?SzFCYWo0cC91S1Ntc3RIaThRZllLMG80byt5NEhTWS94U2s0NEV0NEVBeWxN?=
 =?utf-8?B?L2hpbE9xU2dZUTFOcm1aOUFFMXovYW1rTnExMmtvcmFoSktNaXJqZ1lubmFv?=
 =?utf-8?B?RGUwQzBKMFRLUW0ySzlKaXBReDNyeGJ0TktTWFNpYVF3S1Rmbm41aEF6OGZO?=
 =?utf-8?B?b0xZMFdOOWx4NVl6OHd6Umxoa1h2a09ZK3hZU3owT2JFSHV1Ukp2Vmh2VTht?=
 =?utf-8?B?TVl2YktSaDRqQTI5QmQ1OHBPc1FDMjNMR21xWGtTMXhsK0lyU1pDSVIvNlQx?=
 =?utf-8?B?VTdDdWZHalM3dHh4OEVaK0JJT1YwZ0QrdGtWRGRFK3RMbmI5Qnl5UHNBU0hF?=
 =?utf-8?B?TmpmdS8veXVMN0tna0lQK1A4N3hDZnQxNnkwKzg3bTljZXRWOExjbk45UTdp?=
 =?utf-8?B?Q2JPbVhIKzM5RXl4ZnBVaDNDRFk3bTVqSzNxRmdjZDBPOFQ0NnpkSzhaVitD?=
 =?utf-8?B?QktoaEN2eVJrWEUySUtLVURDZTN4eGIvYXRzeTRCN0dCY2plMmVGUUFWMjVs?=
 =?utf-8?B?cVNMNlJxV0E2Y2g3UG9LYXFsOTdMSzZnQ3JDOGJuMFQ0em5yVVRaQnpzQjdr?=
 =?utf-8?B?bVRYSS9NNkN3VEN0eFVvNDd2RzNIRzdSekVoS3k0em1OTFlYeTMvSU1welZ5?=
 =?utf-8?B?eTBZbWtIc0tyaVV0ZGxEenN6N3hOUGxoYlYxbTJGWnp2SHVLc1RlVWxESFZR?=
 =?utf-8?B?UHljcnZadXFPVUpaSnRqUktDRGx0cXdtWmlxcW9rVUpzbGltS0kwdm9PWVBX?=
 =?utf-8?B?RVZTeDhnb3JGVzNBcjA2aDJOSjd6SUxoVWxWSFpONnp5aGs2UUpUQWRLSURm?=
 =?utf-8?B?WGhiOUoyVEFpS2ttcXBlTm1OcldZaXROc1p4SUl6bmQxWjRKSXdla0pUSTFO?=
 =?utf-8?B?bW1MRHFmY3BLUi8rU3I0ZjBoTTBTT3MrZjhVbkxpUU13d2JqU2o2VVRsUGlp?=
 =?utf-8?B?OXU4eFN1QUJ2SndyOXdoSXM2Qi9kbmFVUW1SS2N1UFJzQzk5MU4zbzlvMkR1?=
 =?utf-8?B?MHUxQU5SZ3Nrc3JwcURGb0RhS2J2YkF6RnVmaklSMW9VU0RldjM5R1ViRFM2?=
 =?utf-8?B?Vjc2NHphWTY2M0E3cEdSR3RqYlovWVR3NytqdHVUUXMwcDcrVUk0U3pNSmhE?=
 =?utf-8?B?M3BLdFduNHNKZXpyM3VSY2dRZEFTWjJPaHAxZ0tzSGNwbHoyd2N6K0ZZOUNH?=
 =?utf-8?B?d1NlZjM4SFFBd0NIRUw1K25LVFFoT1UzVFloZmMzVkV0cjBHNDU3SzdaY0Jm?=
 =?utf-8?B?TFlwU1RaRVhNUmZNZWYrQUpBcThYMEdNWWpGRUlsa0NWZW9KcmZES1c3TlpW?=
 =?utf-8?B?Nk1wVERuVTNqekl1OE1KMVJ1Y2Z1cDNCTzJMUm40N21rRWRrZVlCNUYrMVBx?=
 =?utf-8?B?OElid3oxbFUxZFhYV1BCK1IxanBVaWRuSVBEcjN2RXlHbnpham1aQ01xUnBK?=
 =?utf-8?B?YmE4NWZpWGdHcFloM2g1eFhtLzI5Y2VaNTJuN283d2xMWkRhM3RSQUozNFNa?=
 =?utf-8?B?R0Z3cktHeE5qQTdheXlNZkJud1R0djFYQ0Q3K0VXS0prY1pmWmZYSDUxVFJ6?=
 =?utf-8?B?S1pmMVJZdHZUbUFVSE0xbjVFa0RPb2FOczRsd05PZEZkVjR3S3ZmcWJ3MEtE?=
 =?utf-8?B?NFZPd0FCZ21hNWRUNmx0LzRXK1VNTFZyY1hFaGg4UWsxbjdZRmZqZGNxZmhY?=
 =?utf-8?B?U2hwaGxQUDNEcVNXTW9icVl3ZGh2OXlJWS96T0dkd1pVblRrMW5LdUdXK3hS?=
 =?utf-8?B?NGtwV2YxTEVYeWdwb3dNakNqQ2oySWlMNmxKYitzL0Z6aVVFTDI0aHVMU3lo?=
 =?utf-8?B?bE5XdXJPRXR0dk9OMFA2VUx1RlcwdThrS2dId0t3MEhiTGRhRVJuTUpKYnV6?=
 =?utf-8?B?eVN2bVp3RmQvQitNcTNjeWNwRVFvVUFpVmtzUHg1b25lSVdHMU1GYWUwWVVN?=
 =?utf-8?B?dkl1UjdVbXREVHpZdHhSakg5WmxUeDdyaHFxS01sWk1FRDJ4ZzFUQXRqWWM0?=
 =?utf-8?B?L3R4d1JkWWQ2eXU1YUl2SW9BRXpUTG5ZK1pVRFgyRU8wN1ByZmNPMEtoRnU5?=
 =?utf-8?B?WVFhQldjZTY2amMyMTYxUE9sbXM1NEl0VFlUdmdQYUFwWWtoeE5WS3YwOXI5?=
 =?utf-8?Q?BlynG5x1n4Ky468R9CX0dpg36Na5FsDKw/aVQ+lrsuF98?=
x-ms-exchange-antispam-messagedata-1: 5sAg5J1T64Asgw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RBMJao7i+EtYZPc7XKuw3U/RPxuZvHLIuA/bgqm9rMOXY37o9rwdcCdWb0dloXkT58ku09Nz+lyjJ/ALv1DO5W4p2jV7RVvkTFfA2CKM+DmBEWxPR0tUb0AmpbmzIEBf6xtPplEQoeqJ6Fjv0TpusFnXhfsYQDOl2Jwmlq04Ddoku9kRIqzt+vbnhN/nDkgf0CkrPFrhVROxHVNmyoXVlt3nWxfZnSVFJOnGnfIWmyQLXRrGwciKGP7xp6YN+1NSZNX8BqH6YAkpAcCOyUkzGwR9Ldt/dh3l5n2CpGxbiSrTetneL2DUlDO21+OM+FAlmfDrjKITptOwOUOLsSj3pA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4566a8-e8fb-44da-0451-08df3b46ccf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 14:12:18.1333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGGBzLftdeBRzaFwR+4nu3y5WL9kuvbtZVxQ39rWo9yeqQ9DwAF+APCJKfHZVCJD7xtc0DnhbiOmJrUJ5rwheWJpfjYpwxMAO0XHMzEQ2is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwteGUgPGludGVs
LXhlLWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQXJ2aW5kDQo+
IFlhZGF2DQo+IFNlbnQ6IDE2IFNlcHRlbWJlciAyMDI2IDE1OjI0DQo+IFRvOiBpbnRlbC14ZUBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IFZpdmksIFJvZHJpZ28gPHJvZHJpZ28udml2aUBpbnRlbC5jb20+OyBCcm9zdCwgTWF0dGhl
dw0KPiA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+OyBHaGltaXJheSwgSGltYWwgUHJhc2FkDQo+
IDxoaW1hbC5wcmFzYWQuZ2hpbWlyYXlAaW50ZWwuY29tPjsgdGhvbWFzLmhlbGxzdHJvbUBsaW51
eC5pbnRlbC5jb20NCj4gU3ViamVjdDogW1BBVENIIDMvNV0gZHJtL3hlOiBNYXJrIFZNcyBhcyBj
bG9zaW5nIGJlZm9yZSBxdWV1ZSBjbGVhbnVwDQo+IA0KPiBRdWV1ZSBjbGVhbnVwIGlzIGFzeW5j
aHJvbm91cy4gTmV3IFZNIHdvcmsgY2FuIHRoZXJlZm9yZSByYWNlIHdpdGggZmlsZQ0KPiBjbG9z
ZSBvciBWTSBkZXN0cm95IHdoaWxlIGNsZWFudXAgaXMgc3RhcnRpbmcuDQo+IA0KPiBBZGQgYSBj
bG9zaW5nIHN0YXRlIGFuZCBzZXQgaXQgYmVmb3JlIHN0YXJ0aW5nIHF1ZXVlIGNsZWFudXAuIFRy
ZWF0IGEgY2xvc2luZyBWTQ0KPiBhcyB1bmF2YWlsYWJsZSBmb3IgbmV3IGV4ZWMsIGJpbmQsIHJl
YmluZCBhbmQgcGFnZS1mYXVsdCB3b3JrLg0KPiANCj4gS2VlcCB2bS0+c2l6ZSB2YWxpZCB3aGls
ZSB0aGUgVk0gaXMgY2xvc2luZyBzbyBTVk0gaW52YWxpZGF0aW9uIGNhbiBzdGlsbCBkcmFpbg0K
PiBleGlzdGluZyBtYXBwaW5ncy4NCj4gDQo+IENjOiBNYXR0aGV3IEJyb3N0IDxtYXR0aGV3LmJy
b3N0QGludGVsLmNvbT4NCj4gQ2M6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9t
QGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IEhpbWFsIFByYXNhZCBHaGltaXJheSA8aGltYWwucHJh
c2FkLmdoaW1pcmF5QGludGVsLmNvbT4NCj4gQ2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZp
QGludGVsLmNvbT4NCj4gQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy00LTgNCj4gU2ln
bmVkLW9mZi1ieTogQXJ2aW5kIFlhZGF2IDxhcnZpbmQueWFkYXZAaW50ZWwuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZpY2UuYyAgICB8ICA0ICsrKysNCj4gIGRyaXZl
cnMvZ3B1L2RybS94ZS94ZV9wYWdlZmF1bHQuYyB8ICAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0v
eGUveGVfc3ZtLmMgICAgICAgfCAgMyArKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5j
ICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3ZtLmggICAgICAgIHwgIDkgKysrKysrKystDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfdm1f
dHlwZXMuaCAgfCAgMSArDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2Rl
dmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmljZS5jDQo+IGluZGV4IDIwNWNiNGU3
ZjllOC4uOTU0ZjA5NjVkZWI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVf
ZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmljZS5jDQo+IEBAIC0x
NzksNiArMTc5LDEwIEBAIHN0YXRpYyB2b2lkIHhlX2ZpbGVfY2xvc2Uoc3RydWN0IGRybV9kZXZp
Y2UgKmRldiwNCj4gc3RydWN0IGRybV9maWxlICpmaWxlKQ0KPiANCj4gIAlndWFyZCh4ZV9wbV9y
dW50aW1lKSh4ZSk7DQo+IA0KPiArCS8qIEJsb2NrIG5ldyBWTSB3b3JrIGJlZm9yZSBzdGFydGlu
ZyBhc3luY2hyb25vdXMgcXVldWUgdGVhcmRvd24uDQo+ICovDQo+ICsJeGFfZm9yX2VhY2goJnhl
Zi0+dm0ueGEsIGlkeCwgdm0pDQo+ICsJCXhlX3ZtX2Nsb3NlX3N0YXJ0KHZtKTsNCj4gKw0KPiAg
CS8qDQo+ICAJICogTm8gbmVlZCBmb3IgZXhlY19xdWV1ZS5sb2NrIGhlcmUgYXMgdGhlcmUgaXMg
bm8gY29udGVudGlvbiBmb3IgaXQNCj4gIAkgKiB3aGVuIEZEIGlzIGNsb3NpbmcgYXMgSU9DVExz
IHByZXN1bWFibHkgY2FuJ3QgYmUgbW9kaWZ5aW5nIHRoZSBkaWZmDQo+IC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3hlL3hlX3BhZ2VmYXVsdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3Bh
Z2VmYXVsdC5jDQo+IGluZGV4IGFlYjU2ZmY1ZDU4ZS4uNGJkZDcxNGI5Zjg4IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfcGFnZWZhdWx0LmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3hlL3hlX3BhZ2VmYXVsdC5jDQo+IEBAIC0yNjUsNyArMjY1LDcgQEAgc3RhdGljIGlu
dCB4ZV9wYWdlZmF1bHRfc2VydmljZShzdHJ1Y3QgeGVfcGFnZWZhdWx0DQo+ICpwZikNCj4gDQo+
ICAJZG93bl9yZWFkKCZ2bS0+bG9jayk7DQo+IA0KPiAtCWlmICh4ZV92bV9pc19jbG9zZWQodm0p
KSB7DQo+ICsJaWYgKHhlX3ZtX2lzX2Nsb3NlZF9vcl9iYW5uZWQodm0pKSB7DQoNCklzbnQgc3Rp
bGwgaXQgYSBjb25jZXJuIGZvciBjYWNoZWQgZmF1bHRzLCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5k
LCBzb21lIHJhbmdlcyBhcmUgY2FjaGVkIGFuZCBpZiBzYW1lIGlzIGNhY2hlIGhpdCwgaXQgd2ls
bCBub3QgcmVhY2ggaGVyZSBhbmQgcmVzcG9uc2Ugc3VjY2Vzc2Z1bC4gQ29udGV4dCBtYXkgdGhl
biBrZWVwIHJ1bm5pbmcgYW5kIG1vcmUgZmF1bHRzIGlmIFZNIHdoaWNoIGlzIGNsb3NpbmcgcmVt
b3ZpbmcgcmVsYXRlZCBtYXBwaW5ncyBkdXJpbmcgZXhlY3V0aW9uLCBtYXkgZ2V0IGNhdCBlcnJv
ciB3b3JzZT8gDQoNCkNhbiB3ZSBjaGVjayBWTSBzdGF0ZSBzb21laG93IHdoaWxlIHJlc3BvbmRp
bmcgY2FjaGVkIGZhdWx0cz8NCg0KVGVqYXMNCj4gIAkJZXJyID0gLUVOT0VOVDsNCj4gIAkJZ290
byB1bmxvY2tfdm07DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X3N2bS5jIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N2bS5jDQo+IGluZGV4IDZjMzAzM2ZjNGRi
Ny4uYzJhOWRkOThmMzYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfc3Zt
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3N2bS5jDQo+IEBAIC0yMTgsNyArMjE4
LDggQEAgeGVfc3ZtX3JhbmdlX25vdGlmaWVyX2V2ZW50X2VuZChzdHJ1Y3QgeGVfdm0NCj4gKnZt
LCBzdHJ1Y3QgZHJtX2dwdXN2bV9yYW5nZSAqciwNCj4gDQo+ICAJZHJtX2dwdXN2bV91bm1hcF9w
YWdlcygmdm0tPnN2bS5ncHVzdm0sICYodG9feGVfcmFuZ2UociktDQo+ID5wYWdlcyksDQo+ICAJ
CQkgICAgICAgZHJtX2dwdXN2bV9yYW5nZV9zaXplKHIpID4+IFBBR0VfU0hJRlQsICZjdHgpOw0K
PiAtCWlmICgheGVfdm1faXNfY2xvc2VkKHZtKSAmJiBtbXVfcmFuZ2UtPmV2ZW50ID09DQo+IE1N
VV9OT1RJRllfVU5NQVApDQo+ICsJaWYgKCF4ZV92bV9pc19jbG9zZWQodm0pICYmICF4ZV92bV9p
c19jbG9zaW5nKHZtKSAmJg0KPiArCSAgICBtbXVfcmFuZ2UtPmV2ZW50ID09IE1NVV9OT1RJRllf
VU5NQVApDQo+ICAJCXhlX3N2bV9nYXJiYWdlX2NvbGxlY3Rvcl9hZGRfcmFuZ2Uodm0sIHRvX3hl
X3JhbmdlKHIpLA0KPiAgCQkJCQkJICAgbW11X3JhbmdlKTsNCj4gIH0NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtLmMg
aW5kZXgNCj4gMjY0YmRhYjc1ZGUyLi41ZDBiNjE2YTI3YjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS94ZS94ZV92bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bS5j
DQo+IEBAIC0xOTEzLDYgKzE5MTMsMjAgQEAgc3RhdGljIHZvaWQgeGVfdm1fY2xvc2Uoc3RydWN0
IHhlX3ZtICp2bSkNCj4gIAkJZHJtX2Rldl9leGl0KGlkeCk7DQo+ICB9DQo+IA0KPiArdm9pZCB4
ZV92bV9jbG9zZV9zdGFydChzdHJ1Y3QgeGVfdm0gKnZtKSB7DQo+ICsJZG93bl93cml0ZSgmdm0t
PmxvY2spOw0KPiArCWlmICh4ZV92bV9pbl9mYXVsdF9tb2RlKHZtKSkNCj4gKwkJeGVfc3ZtX25v
dGlmaWVyX2xvY2sodm0pOw0KPiArDQo+ICsJLyogS2VlcCBzaXplIHZhbGlkIHNvIFNWTSBpbnZh
bGlkYXRpb24gc3RpbGwgcGVyZm9ybXMgaXRzIGZ1bGwgZHJhaW4uICovDQo+ICsJdm0tPmZsYWdz
IHw9IFhFX1ZNX0ZMQUdfQ0xPU0lORzsNCj4gKw0KPiArCWlmICh4ZV92bV9pbl9mYXVsdF9tb2Rl
KHZtKSkNCj4gKwkJeGVfc3ZtX25vdGlmaWVyX3VubG9jayh2bSk7DQo+ICsJdXBfd3JpdGUoJnZt
LT5sb2NrKTsNCj4gK30NCj4gKw0KPiAgdm9pZCB4ZV92bV9jbG9zZV9hbmRfcHV0KHN0cnVjdCB4
ZV92bSAqdm0pICB7DQo+ICAJTElTVF9IRUFEKGNvbnRlc3RlZCk7DQo+IEBAIC0yMjE0LDggKzIy
MjgsMTAgQEAgaW50IHhlX3ZtX2Rlc3Ryb3lfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwN
Cj4gdm9pZCAqZGF0YSwNCj4gIAkJeGFfZXJhc2UoJnhlZi0+dm0ueGEsIGFyZ3MtPnZtX2lkKTsN
Cj4gIAltdXRleF91bmxvY2soJnhlZi0+dm0ubG9jayk7DQo+IA0KPiAtCWlmICghZXJyKQ0KPiAr
CWlmICghZXJyKSB7DQo+ICsJCXhlX3ZtX2Nsb3NlX3N0YXJ0KHZtKTsNCj4gIAkJeGVfdm1fY2xv
c2VfYW5kX3B1dCh2bSk7DQo+ICsJfQ0KPiANCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0veGUv
eGVfdm0uaCBpbmRleA0KPiBjNWI5MDBmMzhkZWQuLjcwNDU2ZmZlMjdlMiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX3ZtLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hl
L3hlX3ZtLmgNCj4gQEAgLTU5LDYgKzU5LDExIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB4ZV92bV9p
c19jbG9zZWQoc3RydWN0IHhlX3ZtICp2bSkNCj4gIAlyZXR1cm4gIXZtLT5zaXplOw0KPiAgfQ0K
PiANCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB4ZV92bV9pc19jbG9zaW5nKHN0cnVjdCB4ZV92bSAq
dm0pIHsNCj4gKwlyZXR1cm4gdm0tPmZsYWdzICYgWEVfVk1fRkxBR19DTE9TSU5HOyB9DQo+ICsN
Cj4gIHN0YXRpYyBpbmxpbmUgYm9vbCB4ZV92bV9pc19iYW5uZWQoc3RydWN0IHhlX3ZtICp2bSkg
IHsNCj4gIAlyZXR1cm4gdm0tPmZsYWdzICYgWEVfVk1fRkxBR19CQU5ORUQ7DQo+IEBAIC02Nyw3
ICs3Miw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB4ZV92bV9pc19iYW5uZWQoc3RydWN0IHhlX3Zt
ICp2bSkNCj4gc3RhdGljIGlubGluZSBib29sIHhlX3ZtX2lzX2Nsb3NlZF9vcl9iYW5uZWQoc3Ry
dWN0IHhlX3ZtICp2bSkgIHsNCj4gIAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZ2bS0+bG9jayk7DQo+
IC0JcmV0dXJuIHhlX3ZtX2lzX2Nsb3NlZCh2bSkgfHwgeGVfdm1faXNfYmFubmVkKHZtKTsNCj4g
KwlyZXR1cm4geGVfdm1faXNfY2xvc2VkKHZtKSB8fCB4ZV92bV9pc19iYW5uZWQodm0pIHx8DQo+
ICsJCXhlX3ZtX2lzX2Nsb3Npbmcodm0pOw0KPiAgfQ0KPiANCj4gIHN0cnVjdCB4ZV92bWEgKg0K
PiBAQCAtMjE0LDYgKzIyMCw3IEBAIGludCB4ZV92bV9nZXRfcHJvcGVydHlfaW9jdGwoc3RydWN0
IGRybV9kZXZpY2UNCj4gKmRldiwgdm9pZCAqZGF0YSwNCj4gIAkJCSAgICAgc3RydWN0IGRybV9m
aWxlICpmaWxlKTsNCj4gDQo+ICB2b2lkIHhlX3ZtX2Nsb3NlX2FuZF9wdXQoc3RydWN0IHhlX3Zt
ICp2bSk7DQo+ICt2b2lkIHhlX3ZtX2Nsb3NlX3N0YXJ0KHN0cnVjdCB4ZV92bSAqdm0pOw0KPiAN
Cj4gIHN0YXRpYyBpbmxpbmUgYm9vbCB4ZV92bV9pbl9mYXVsdF9tb2RlKHN0cnVjdCB4ZV92bSAq
dm0pICB7IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfdm1fdHlwZXMuaCBi
L2RyaXZlcnMvZ3B1L2RybS94ZS94ZV92bV90eXBlcy5oDQo+IGluZGV4IDY0ODAzMWU2NDE0NS4u
MTZiMDUxYTBjZjEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfdm1fdHlw
ZXMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfdm1fdHlwZXMuaA0KPiBAQCAtMjg2
LDYgKzI4Niw3IEBAIHN0cnVjdCB4ZV92bSB7DQo+ICAjZGVmaW5lIFhFX1ZNX0ZMQUdfU0VUX1RJ
TEVfSUQodGlsZSkJRklFTERfUFJFUChHRU5NQVNLKDcsIDYpLA0KPiAodGlsZSktPmlkKQ0KPiAg
I2RlZmluZSBYRV9WTV9GTEFHX0dTQwkJCUJJVCg4KQ0KPiAgI2RlZmluZSBYRV9WTV9GTEFHX05P
X1ZNX09WRVJDT01NSVQgICAgIEJJVCg5KQ0KPiArI2RlZmluZSBYRV9WTV9GTEFHX0NMT1NJTkcJ
CUJJVCgxMCkNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiANCj4gIAkvKioNCj4gLS0NCj4g
Mi40My4wDQoNCg==
