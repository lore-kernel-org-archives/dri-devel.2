Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AC5606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SCFzlAU8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F658112493;
	Thu, 29 Oct 2026 18:41:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC24110E832;
 Thu, 29 Oct 2026 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793299269; x=1824835269;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8knBMaf6LJhxk+0LOZS/44coWPLvUx2NhfeO3cAshY8=;
 b=SCFzlAU8fWCdhNr6T+479aL43rtjeZ0FWDvxAsWY3tXM9kFPppkfTwcn
 TLoVQBIte5+aH7h0lPxCGMmEBJP6cel2HPBaAYLjRtg0g0UIp3HORazFy
 Zrue6TnyQQBuPYx0z8Sk2dsi89PpQJIDCvdU26j059xFFwzz/HY33z6Sn
 fAYaovgFKOB8sS9ji10UCShwK2hBG8/S03EfnZU/CTCjpJz2chyJODl0h
 96FggkDQLUPivxughiYDLMN1Nl7ifxx64qp8c0F62X56SJsyxCoHS3eTD
 xILVvl+aqp9rT57u9u6+f9S7bd3aVAuQw9ePNpPcL1db5OgEW4M2B6aqz w==;
X-CSE-ConnectionGUID: gXtb0PEBSLK7djZXLfpshA==
X-CSE-MsgGUID: MBPg/hWxQU+3NKvJqwu/1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2078636"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2078636"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 11:41:08 -0700
X-CSE-ConnectionGUID: QQy+TF+TSCiRXaDyrd8dcQ==
X-CSE-MsgGUID: u0sxfvjzTAmcoHSoCGkJYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5368498"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 11:41:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 11:41:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 11:41:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 11:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/jYv5Mn49BFjo8CW9We/1RYhqm3T8cJkYLOt11zDGKghPuIHNCR+377nRS42zbfJ9+b1oVhoAiNhw9zGFNfTLP+pyNQX/Lj3FoLXV30X2ZOk4rgPpcCeZLI5bMRgbe6n9pl7CwlQupagHqZnl67NnhyGvKLXYjJtxqvp9G8gJe2UW2E8VWddo91wSyygsovJg8e03UumXRk5syWf3OmgUJLliSJlYVA9MButSwLD4xEa6hBFhiDWqCf+Q13yC/uix8nopp0NP/M4AYxfwEPZrz/zntzTJQbbc6BQYQi+waiK27A1SuGybFA41dV/s8dDpBiRgtQTeNQArX6jRldtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8knBMaf6LJhxk+0LOZS/44coWPLvUx2NhfeO3cAshY8=;
 b=EUEKV+nV7a5Yk66ldjbVQlLnro0tmgfFOgE+EsfVcNTNIYvFbJKztNlT2DRlcTzRiBikJGgBz24FchszN+WMIE7zhXMG1F2+jKCIpcLq7tUu3Ce7c6lDQVWT3sQxAkHwIVNKu7K2O2C248VQDs+JMyAb5B2LAE9PmVZ1X2BaBBxp4DUnuWQJ7yLHfr462yeRUADa9Fglq6XCD3tx7cTPgJxTjz7sUjSG9Z/F6HGYG4F9WN1c2ZIRPCFgLHsz3DrBixIdADqS7H8jNtIzaTarzebEfXRRos9IGFTcukFKwphEUU6tAU4sGZTpH/HpSNNYZaJktSki0yfOdp58uHKORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by SA3PR11MB649961.namprd11.prod.outlook.com (2603:10b6:806:532::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 18:41:06 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 18:41:06 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>, "Jadav, Raag"
 <raag.jadav@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Topic: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Index: AQHdYxUQrX/Q3sL74kOuQzp1gjK0A7cST8SAgAEpCACAAIJtgIAAURCAgACXpwA=
Date: Thu, 29 Oct 2026 18:41:06 +0000
Message-ID: <b5964a238b9677518cc46648a90a7c5c7034396f.camel@intel.com>
References: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
 <auFpdeRIafjgKSV9@black.igk.intel.com>
 <f7f8745978c21de8687e1e539a15f0be9f9d4a6a.camel@intel.com>
 <auLQCWmLV395IoS7@black.igk.intel.com>
 <63ba65de-4292-4f7a-9df3-f98fef5c88fe@intel.com>
In-Reply-To: <63ba65de-4292-4f7a-9df3-f98fef5c88fe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|SA3PR11MB649961:EE_
x-ms-office365-filtering-correlation-id: 031ada24-76cb-4157-64db-08df35ec3110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|5023799004|11063799006|56012099006|261009223027099003|4143699003|261026140227099003|261026121527099003|261028144727099003|10067099003|261022105027099003|261021135927099003|261021121427099003|18002099003|22082099003;
x-microsoft-antispam-message-info: r0N6oJuz1d1ajD78KngudoJwO1tsf5eSsY1/0A+kg5FXKDHrhXPjNx1oIAxj4gykevWPDnLVQ8gJRibeKUs4rm2MjQ+T2IOrxGpuy49DMvu0lG87bBTnJQxp/x8I03dxa6Ka3Qtx0ERqY1UNxYp5r6KzLFJsMit+cHtqjTj2Lze3Dt8mPT66dJ5qyjm46jpEkMdSm2qTzEhqxVUovmUgCsDGZoDvEImqzVf7eZ53nWk0vxxlfwPqCvoab3qUwbdiqT6IK55z9xeTFyhSx2ZDnpzT+Gbj2DiE7DHZT56UWxR7mHNsriHGR7tzBMiKNLZ7TFPZ4Gm+KWrWvpKjAKrDZAWB3U3FXU1R//Ue5N352q5whYuBqz7HPLYYK38Z3MFQw3rjKaejjkQSb+0RXsCUSSN7sdv2x7V/0AbnrVGt6bp0xE1iA7cjHVmD4krwZaSv0T7ED8hOFiAsiZLmVq92JWAcuz4Q/TTbzr4My90AH6+ICum5lEYTo3Yw8+JhKVjbyelvVKX9zcfNURBzWajugcg6iK+6sj08z4ac88kgcddl7Iv2Tmg16bBNTxD86hy0+ixWU2x1dDBMTM3qMMccBGYu9h5mlzDZm3QeK1Q/JIY/ihnrZzyiO4yif27IPmYp7IRIG/tsXg+qxnXkF/i6Rv102wITnt6jYA1EOLErBeFCvqFI0f+Kl/uUgHm+7F0f0yRJMAlOYImi2grtmHkoFziHPTuLu9RMuxi4LfTGIgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(5023799004)(11063799006)(56012099006)(261009223027099003)(4143699003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022105027099003)(261021135927099003)(261021121427099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emFySmFRNktKdXZWekIveHZZWjF0cHdVVU5VSDN1dWxaY2RQVzNTVjh5S0tZ?=
 =?utf-8?B?MHphaUJiYjhSaUd5d2xpaTh6NE1LUVNEWVNUV29XMlNjcXplYjhVc0hndmYv?=
 =?utf-8?B?aXhrN2pZNTdmcHRFbnhMUSswdlZjVU9sSHY2dHlEa1d2SGxiNzFneVJhM3ZU?=
 =?utf-8?B?dVJrSUIzRWpjeGxyaVgwdjBiWEsxeHd0QS9Zd0JTSE9oK3hJc1BWaGFpY012?=
 =?utf-8?B?VWg0Y0EyU1RLSnJ6NDBnczduNktYRnJQRHZoRmZYcC9pVDhoa0MzNXRxSytn?=
 =?utf-8?B?bGttbk9sUjJrVENEL1NhMXI0VWEzZENQMXhDOVM4Uy9CWDdKS2Vta294Z3gw?=
 =?utf-8?B?WVU4WFpnTTc1MmZra1hDM2FBQ3Y4ci8zUjFGbUJoVlhvNXVlNGphV1hENTU0?=
 =?utf-8?B?OVBSd1BLc0VYYnhpR3krUXFwUVVJLy90d0c3QWFtVndCbVZNWTBJN21RNEw5?=
 =?utf-8?B?NkF6TGZEMG1FWXRoZ2hnd0dCcXpKemIzYUNlZW1LRE1maDZLSWlRWUVYOStu?=
 =?utf-8?B?YkpqczREZnZ3eVVuc2FWdUpmdUdOOU93ZWEvMFVqMFBudkwwR0NxVW1JWGo3?=
 =?utf-8?B?Y3RBd1hOV3BHTzFpRU1RS2Y5NTNCNllpYTJpdEpRVk5uRVFwditHcTM3OEJ0?=
 =?utf-8?B?WHhPSFcvcVZNUm9sbkNGU0F5eWFka1FGL1p2OXltbzBZZFZ2RjJuS1pReU9l?=
 =?utf-8?B?KzhhK3RrZXE4S000QU5yMHp1aUZTdzdBWFVVbFdNUHZzZEFlcHhXTGlTRVJJ?=
 =?utf-8?B?UFNpMnJGaUtFMytYbGJ1ZFQ5Q3FnaWY5aXlnRkE2LzFUOXBRM1R1K0FXYXQr?=
 =?utf-8?B?Vzc2WTJoa0NpTTBzU0ZDSGZlY25ZVisxNGpGa01DRjdLcTNyREFjcDlSZ1Bn?=
 =?utf-8?B?Y0ppd3NUb1c4Nk8yNnoxWEhiVjh4VG4xdW5Ib1EySUdsejJPcGhpbmh4MTM0?=
 =?utf-8?B?T3ZERUROUVgzTTFIUEdJTVVGR3RRYmhwUXd5djlFMjY2TWo0QlI3M01QMVRm?=
 =?utf-8?B?SmFFcnBrUWRoNGgzeFpkc0Fxb0hlbTVhd2NFVTlyQ2hIcW43Q3c5U2lHYnEy?=
 =?utf-8?B?RkVnZTgvSVduVkluY2NEN1ZwWFBQMGYzVU5BZkxWckM0cTdpWnRQSzYwVWMx?=
 =?utf-8?B?M2k4L1o3bzViNThiZjZLd1k4VjhFSDBtaXpWL2E3amY2N21BT0pLZms1WXJh?=
 =?utf-8?B?L25HTXB5cHJNNmZyeVpTcXJ6RHIwbUxnYjFIZTBDNnV0bklzR0w1OWIyVEI0?=
 =?utf-8?B?RmNYdEhoTVRNeXkwTU9IODVZYktKeGpvVldyK1JWcFpIMDNnNjVoMkFVcHJt?=
 =?utf-8?B?TlZsaExkZXNLRHpRczZ5V0hBUUkvb0VwR1NjcHJiZ2plZ0pQS3p3UGpSWXhB?=
 =?utf-8?B?TzVHWjcxdDJxd3JXRGc2a1o3Z0tvWjJsVjZHUUZXeTVmRDlYd3hiVE9KaUVG?=
 =?utf-8?B?akYxOXRBdjBIZDNZOHpwbjRPNy96WWJQV3RNd3dObExGWFpkaUFHU0VqNU54?=
 =?utf-8?B?bVRLdlp0YlZWQ281dUJ5QUd0bkh4M3hFRWNZNVZVdDhianVwTGNnNTRWOHY1?=
 =?utf-8?B?eFNqd0FmanhJa2V1WEs0TEgwU1ZhMVZ1dUN0cEdzUzhEYnA0UE9vSW9kaWN3?=
 =?utf-8?B?V2ZpcEFLV2tzQVBRNFA3RmorbjVrMU11d2ZIUDQxd0NtdGQ0UU42UWx2eklL?=
 =?utf-8?B?ZnlmTTd2OGM2clVoQlRJVnZvN1UwanZ5cmVXK2hxdFpOSGFiWE5DQlJ0UEhX?=
 =?utf-8?B?dVcvNE1GdzdiUS9jVGUvWktXcWE2MVc3ZHExbzhwRXRweHo2dWd1YkZZWHlQ?=
 =?utf-8?B?ZG9KdnVCVTlabGFhYWZWSUg2bGtud214SFhhQjJBempNU29wZjlPekVvZFBs?=
 =?utf-8?B?WjE1c2drOTFmUEpvY0kvVzFmRWFYU2lTbTIxOVJMWG54bEZPMEpjWUV4UnlV?=
 =?utf-8?B?cGF3bHBFQ2pwVElsT3pUNU1tejU3ZndrVDB1UXRKc1Mxcnk4RDhpU2E3WllN?=
 =?utf-8?B?TWJvZXRQRUNBWG5LZFFkQm1rdXprdFZuM0xxS3E1S3A0UU5SZ2IwdVNwbjY1?=
 =?utf-8?B?cGtBRlV4MTRNVlB0aGhuT2VlS0FNVm9sRVhjYW1nSC8yU1E4bGZzTDF0aXBJ?=
 =?utf-8?B?NWZkTkxnQTE0dnNnR1BaNkhhT1lyY0FzV05QUnE3ZVkwTU01Z0xMWnQvNkJ1?=
 =?utf-8?B?SU9BNlhObHFXSGZvSHVqTVRGL1kyd3FXdlNkaENyMmx1WUFuR3k1cXl0b2J5?=
 =?utf-8?B?K21nSWZqQjNFMWI0NlBhb3FlU1VDK3FjTUdyZ3E2ODhZV3NnTktwQ25ZL1lR?=
 =?utf-8?B?a2NtK2hoakdMNDFwbUdFOVIyd0tuMGJDK1BOZm15WExjeFptL085QTNMeFJm?=
 =?utf-8?Q?igoUJ8XPhI4DpL2Yrj5f0B9iy0r68DTywcCoF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26AB1C6552B98948AC2B2EEE0B98160A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1Og6CIyaX2FGXjtI2lwiTKg1KbWbJEZCeemTMuQP4dqNRljyhmqBbj39oWl3o7WgWqUtAyYeWVwAS4FPnR5E2L0KaXy1+v86tKmW9zwZzNSmNpXphYrGnqTB5UVkWm/z/sRus5NmLRUJtW0YIK3LHNUPJLsN0CCyPYZHB0cT8fmitOwslokgxFDvfecFuJdZq1DvmUqdFShxsktDhmCIJRuGaJ861G1D0RXhh6VSsuVJ5AT1qZaOkULcbnwYsor8wNZKEFQcX8XPnEibicXbNWqsss1hndnHC4kC320sDosMPc+xlt+0h4tZ4AWI5K4Uni0UX92EYNJdFGq+3Ciesw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031ada24-76cb-4157-64db-08df35ec3110
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 18:41:06.1056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+kuzZb07N9M6GnScEmKhzcvjAKcgxV7+i1/0lEP7d+kz+YkEKAfb+pZ/yz87qgNaSdLMBWxBnpJL6hZMehGhcDUSQBgOEo9EQK2x5uxzow26E95y4eKJCcDbKg1zHjI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB649961
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiA+ID4gSSBiZWxpZXZlIHRoZSBpc3N1ZSBjb3VwbGUgb2YgdXMgb2JzZXJ2ZWQgd2FzIHVuZXhw
ZWN0ZWQgdmFsdWUgaW4gY2hlY2tfYm9vdF9mYWlsdXJlDQo+ID4gPiBjYWxsZWQgZnJvbSB4ZV9z
dXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVxdWVzdGVkLiBCdXQgYXMgd2Ugd2VudCBiYWNrIHVwIHRo
ZSBzdGFjayB3ZQ0KPiA+ID4gaGFkIGFic29sdXRleSB6ZXJvIGluZGljYXRpb24gdGhlcmUgd2Fz
IGFueSBlcnJvci4gbm90aGluZyBpbmRpY2F0ZWQgd2Ugd2VyZSBldmVuDQo+ID4gPiBpbiBzdXJ2
aXZhYmlsaXR5IG1vZGUuIEF0IGxlYXN0IGluIHRoYXQgZmFpbHVyZSBwb2ludCBjYXNlLg0KPiA+
ID4gDQo+ID4gPiBJIHVuZGVyc3RhbmQgd2UgaGF2ZSBpbmplY3RlZCBzaWdpZCBjb2RlIGxvZ2dp
bmcgaW4gdGhlIHZhcmlvdXMgb3RoZXIgYnJhbmNoZXMNCj4gPiA+IG9mIGRvd25zdHJlYW0gbG9n
aWMgKGZyb20geGVfZGV2aWNlX3Byb2JlX2Vhcmx5LT54ZV9wY29kZV9wcm9iZV9lYXJseSAvDQo+
ID4gPiB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVxdWVzdGVkKSwgaG93ZXZlciwgSSBpdCB3
b3VsZCBiZSBtb3JlIGludHVpdGl2ZQ0KPiA+ID4gdG8gcHV0IGEgc2luZ2xlIG1lc3NhZ2UgYXQg
dGhhdCB0b3AgbGV2ZWwgdG8gYXQgbGVhc3QgaW5kaWNhdGUgc29tZSBraW5kIG9mDQo+ID4gPiBz
dXJ2aXZhYmlsaXR5IGFjdGl2aXR5IHdhcyBkaXJlY3RlZCwgYXR0ZW1wdGVkIGFuZCBlbnRlcmVk
LW9yLWZhaWxlZC10by1lbnRlcg0KPiA+ID4gDQo+ID4gPiBJZiB5b3UgYmVsaWV2ZSB0aGUgY29y
cmVjdCBmaXggc2hvdWxkIGJlIHRvIE9OTFkga2VlcCBlcnJvciBsb2dzIGF0IGV2ZXJ5DQo+ID4g
PiBzdWJicmFuY2ggaW5zdGVhZCBhdCB0aGUgdG9wIGxldmVsLCB0aGF0cyBmaW5lIHdpdGggbWUg
dG9vIHRvbyBidXQgaSBub3RpY2UNCj4gPiA+IHRoZXkgY3VycmVudGx5IGRvbid0IGFjdHVhbGx5
IGNvbnZleSB0aGUgc3Vydml2YWJpbGl0eSBzdGF0ZS4NCj4gPiA+IFdlIGhhdmUgbWVzc2FnZXMg
bGlrZSAiRmlybXdhcmUgZmxhc2ggcmVxdWlyZWQiIG9yICJCb290IG1vZGUgZW5hYmxlZCINCj4g
PiA+IGJ1dCBub3RoaW5nIHNheWluZyB3ZSBhcmUgaW4gc3Vydml2YWJpbGl0eSBhbmQgdGhlIGdw
dSBpc250IHVzYWJsZS4NCj4gPiAgRnJvbSB3aGF0IEkgZm91bmQgYm90aCBzdWNjZXNzIGFuZCBm
YWlsIGNhc2VzIGFyZSBsb2dnZWQgaGVyZS4NCj4gPiANCj4gPiAgICAgICAgICBpZiAoY2hlY2tf
Ym9vdF9mYWlsdXJlKHhlKSkNCj4gPiAgICAgICAgICAgICAgICAgIHhlX2xvZ19lcnJfZmF0YWwo
cGRldiwgU1VSVklWQUJJTElUWSwgMCwgIkJvb3QgTW9kZSBlbmFibGVkIVxuIik7DQo+ID4gICAg
ICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgeGVfbG9nX2luZm8ocGRldiwgU1VSVklW
QUJJTElUWSwgIkJvb3QgTW9kZSBlbmFibGVkIVxuIik7DQo+ID4gDQo+ID4gVGhlc2UgbG9ncyB1
c2UgU1VSVklWQUJJTElUWSBhcyBhIGNvbXBvbmVudCB3aGljaCB3b3VsZCBhcHBlYXIgaW4gZG1l
c2cNCj4gPiAobm90IGEgZmFuIG9mIGl0IG15c2VsZiwgYnV0IHRoYXQncyB1bmZvcnR1bmF0ZWx5
IHRoZSB4ZV9sb2cgZGVzaWduKS4NCmFsYW46IHBlcnNvbmFsIG5vdGUgLSBpIHRoaW5rIGZvciB0
aGVzZSBraW5kcyBvZiBnbG9iYWxseSBpbXBhY3RpbmcgZXZlbnQgbWVzc2FnZXMNCmkgdGhpbmsg
aXQgbWFrZXMgc2Vuc2UgdG8gYmUgcHJlc2VudCBkbWVzZy4NCg0KPiA+IA0KPiA+IEkgZG8gYWdy
ZWUgdGhhdCB3ZSBjb3VsZCBsb2cgc29tZXRoaW5nIGxpa2UgIkVudGVyaW5nIHN1cnZpdmFiaWxp
dHkgbW9kZSINCj4gPiBzb21ld2hlcmUgaWYgeGVfc3Vydml2YWJpbGl0eV9tb2RlX2lzX3JlcXVl
c3RlZCgpIHdlcmUgdG8gcmV0dXJuIHRydWUsDQo+ID4gdW5sZXNzIFJpYW5hIGhhcyBhIGJldHRl
ciBpZGVhLg0KPiANCj4gDQo+IElmIHdlIGFyZSBzZWVpbmcgYSBwY29kZSBpbml0IGZhaWx1cmUg
d2l0aG91dCBib290IHN0YXR1cyBmYWlsZWQsIHRoZW4gDQo+IHRoYXQgaXMgYSBpc3N1ZS4NCj4g
VGhlIG9ubHkgb3RoZXIgd2F5IHRvIGVuYWJsZSB0aGlzIGlzIHZpYSBjb25maWdmcy4NCj4gDQo+
IFNJR0lEIGxvZ3MgZG8gcHJpbnQgc3Vydml2YWJpbGl0eQ0KPiANCj4gPDM+eGUgMDAwMDowMzow
MC4wOiBbZHJtXSAqRVJST1IqIFNJR0lEPTEwMyBGQVRBTCBTVVJWSVZBQklMSVRZOiBCb290IA0K
PiBNb2RlIGVuYWJsZWQhDQo+IA0KPiBBZ3JlZSB3aXRoIFJhYWcgaGVyZS7CoCBXZSBjYW4gcmVt
b3ZlIHRoaXMgbG9nIGZyb20gDQo+IGVuYWJsZV9ib290X3N1cnZpdmFiaWxpdHlfbW9kZQ0KPiBh
bmQgYWRkIGl0IGluIGlzX3JlcXVlc3RlZCBpbnN0ZWFkLg0KPiANCj4gVGhhbmtzDQo+IFJpYW5h
DQo+IA0KPiANCj4gPiANCj4gPiBSYWFnDQoNCg0Kc291bmRzIGdvb2QgLSB3aWxsIGFkZCBzaW5n
bGUgeGVfbG9nX2luZm8gIHRvIF9pc19yZXF1ZXN0ZWQuDQo=
