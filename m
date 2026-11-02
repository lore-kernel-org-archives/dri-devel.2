Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05554606B1E0
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HLNudpBM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F8710E670;
	Mon,  2 Nov 2026 16:47:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A81210E0A6;
 Mon,  2 Nov 2026 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793638056; x=1825174056;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pT1sW12cMZoYA75PbPnhSEh9yUH2KqJnFO4VO0cotJU=;
 b=HLNudpBM7GJ7mMkUiE/CfcEaI67KTqY8SnzPWgNw2jvBaQBXDtr9ot8H
 1duo6SqMe1FOpAtjqdnypjl4wNk5yJd3owa/nJZs7jAgBEbcRpXudo8tp
 U8BNUTHF9S+2HVv2xvyNPZKVVdY03FYdNLz+zOao/E9xljzQj15dFHuNw
 oByFjZJ4EcaziPfkGQ/hqj7pSJCQ2sWkYD09bdjdxDlMLH/fODqKYwLQM
 W0t9jrGt8NUhI6+xjvzLmtljZSEMsPlpvAaMJj7TL7XyaaMZMxgEezmq+
 NW0uF/Nm/9RNsL0s7JSwSiwc0I01yadbKMq+SmPKL8otbgiCHinjElBmU A==;
X-CSE-ConnectionGUID: N8sYd91mQSaMpZnRC5xs9w==
X-CSE-MsgGUID: DsnnjJXeSMOft/Et5miNhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2215799"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2215799"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 08:47:36 -0800
X-CSE-ConnectionGUID: slSPjHbISUahf8uUp4P2+Q==
X-CSE-MsgGUID: T7pobAu5S2CfgKlhnvS1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6505533"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 08:47:36 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 08:47:35 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 08:47:35 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 08:47:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3R5oI+GUshD8jPSPC/s6lSba9vT5t7Wc+xGuzqSno9k+fCEzSItbmNuv+KSyDXdEn0GrfdaBQwRfTymtmyMrPyYQdUVHrD2ea6wBV1svSKf+6BYo2ZUUZ3KRHTx0JQW8QMsW+n8XzNOBzTRSbqgJmYILoGFUcyme9XjcEZ+mhXJz1e7yr4lTlKOBdIHg2B4uVSm0zoAwtVWCtAL/aT0InpzEg25ZMKDmkqZX1LxxxfpzsKNgET9kQRbhVLb2EPLFhDQ/+bMyxsgdI8YHatxLb0vbY4go60Mc3QzXS93/qCTPOx+kgGrWJUWiP/5Mdyu4QKbU5JDXFPEG/mN2gHRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT1sW12cMZoYA75PbPnhSEh9yUH2KqJnFO4VO0cotJU=;
 b=iZsptn/WgTsQwVrdhG6cnPktW7GLPwQSzynOQ6H4nSY0XqCRDO2e0BTQ8UgZWamzUIE5SRAKJFNx4FE6mj0lcWoFeZ8JtJnRViCBfBsxP4Ri5YOwnZac7deCu2wimkkdD43KBpkHeW0baCBj+mr4D135A3vCCMeFkgjDuaL8KJcLAifpaXnbxq+WE3fgWNf1D0fqFAaVHjFb9Q1XT1ZEa0U4K8uaTAsg1K8DTRrhQGtNJaF4739r5cRtRXAFF1FIRJYTBTxFQ5O3K+9D5GrNBwxCmf2Iv2ib2gJeqIXcVs6VMqZNWcjBZo0dCvHjh/MmV77OxscDw8Lddh1x39+lHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by DSM1PF66CA93CEB.namprd11.prod.outlook.com (2603:10b6:f:fc02::148)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:47:32 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:47:32 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Sousa, 
 Gustavo" <gustavo.sousa@intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH 1/1] drm/xe: Add support for WA 14028250015
Thread-Topic: [PATCH 1/1] drm/xe: Add support for WA 14028250015
Thread-Index: AQHdZ9DVM1sSjDLrFk2gqwizBwdxY7cWuK6AgARLYwA=
Date: Mon, 2 Nov 2026 16:47:32 +0000
Message-ID: <10a999d06de867a938a67fbc345e4acda9ddafff.camel@intel.com>
References: <20261029181039.598756-2-alan.previn.teres.alexis@intel.com>
 <874ie2u6jc.fsf@intel.com>
In-Reply-To: <874ie2u6jc.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|DSM1PF66CA93CEB:EE_
x-ms-office365-filtering-correlation-id: 2cf066be-8e6e-4831-492d-08df3900fd62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261022105027099003|261026140227099003|261022113327099003|261026121527099003|261009223027099003|261028144727099003|260925022911599003|260925021911599003|260925021311599003|38070700021;
x-microsoft-antispam-message-info: VBg7iFUR3CORKJtDQ1mx0RnrrEBrlVyCxfhFRrtn5VPQNlY1wF1FrpTcstA5atn8Gdypmex2R8TTvdJx7es8I9rSd8WWaPcexyANfrlpDYcaPCdVh8j1r24CkOswkV4D/bQ3y/EOqvfH3PoxcHEbV50XaT9vdBzNFscnOP1iHb9WiKlI1CLBjgAlLczomFSxUHg2ofQYO+j3tbsRVAKeIXJ5EjpMXEWCeF/q2KQNeW6lPS5fpXLk4C6VxUPDKRZ/vmbreGAnjsYtDLPLIjDHt2qwrhifEuwJopR+iIUy6TlgjApiSBZPzvWV36oeOMtTckGvhJjQJpEHiuhn7UVMCUShGEaJx338wh1GmJKFWIxcTerRftajb5lo39w14MFQURgUPWU81yebvtUh5nXPtKjGh28uepmqS9fUkvTC6qlilvCM97ry5FirkwgU7mP4k9F01vF9n92sBwhniSqDDIh0gL3p/uLagb9VSpNRfhzgjWD6sGgfHuliSGowzQ8l+F8B5YzLedCfoBS07QYTWYBib/MK+sUOWzbltNKCL5e9724fkpkug+XWAldDXm+l6Am7FWM7aVmoTIzTnV1CS/2HXkM8CL5bHUnloSmjT2I/j5zJbGylyoh6wYxJdpFm6KqFziIhY9NroWQU21Z4Ipq9zwa4+fC7MUrugdFzFpnMxv9jvLnWd0g0darsDbyvQ0ZmJBjDrEBYW5PCQkMFE7aNhlRqvz7cGg8bm8RT1bY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026140227099003)(261022113327099003)(261026121527099003)(261009223027099003)(261028144727099003)(260925022911599003)(260925021911599003)(260925021311599003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTAwTDd0TnliNi9nNWRPbVRXdnZJQm8veGxaTEdkQk5JaEU1bDUxRWRic0NO?=
 =?utf-8?B?c0oxQkJST2Y3WExianJhdWhsUTkyS3NudGlCRktyYTZoUVFjWmtNVzNEdDlk?=
 =?utf-8?B?T3VQZWFoTElKTWJ2dmRKTndQcEZ2aU5hakljbWp6ako5VXY5ZWdwMW81UWhZ?=
 =?utf-8?B?bDFDa0IxQ2R6NWdEQWpteVhKK1J0UE9pMXNNVHNtb3hUbm50T1d6UGZ3TTdx?=
 =?utf-8?B?OXdzdHFsaTJjK1BMdWxSMTl1S0J1Mm1FRDVXK1ByaDdSZ1BZdDFGdFdrWWJH?=
 =?utf-8?B?UGNQbUlId1RHQk9YdkU3bENOZEdQaEJGL0dmTnNsNUwyeVd6UWUxUTJXVkpa?=
 =?utf-8?B?OGNQSFlzdWI0YmYyNFhyUkZhRy9YcmM4eWR3MmZDOXk2REpEb0Z5TTJUQ0tR?=
 =?utf-8?B?QW51bm4zTWtCMFVFTVp4Q2ZXQmNXQmpkdnQyMVl2N3MxM1lSZHBITHl4QnNz?=
 =?utf-8?B?bHdwS2dZakxxeGY1NlBGd0tUT1BLeGVPK2FtMGRzVW0xb0ZSZ1p4Z1dDRjF1?=
 =?utf-8?B?RFE3bjVJbnZTOTZveFl2bmV5SEF0L05vZThsdEpsZmMxR2o4RDM0ckZKMUY3?=
 =?utf-8?B?Zjgwd2dOMmFEWElUT0xlcHpSWFpXWEVkUnVhYU0zdzJ4blNueEJEOTNkZlBW?=
 =?utf-8?B?UkdDZ0daUmRCOGNvWTFoc1F4bk9aQ0Z0VHpEdGt1R3BHSitVNm85ZTBzNHEy?=
 =?utf-8?B?a0FpNE53ZGxqa3pxZnlaVC9XSDJRMFA5MktlbDlndkgySW9KbkVSWkFOalFR?=
 =?utf-8?B?eUNkaDNvSlJIR0ZKczI5enUxaS81dnEzbXMzcFJUM0c5YlFaMVV4WEZGaGxx?=
 =?utf-8?B?QzhCeWk3QjJpQzVNREFPb1g3YVVKYTBDaHVtdlhTZ2JiTkNnUUJGakJmVkxG?=
 =?utf-8?B?M1NVK2xmL3dFTDgvUVhsNXVqZ3EvcitZeWxYTHV4RE02ZDJabWJpMUljYmZH?=
 =?utf-8?B?aW55bVZWVEtsZFpQKzZ1STRDMGFDemNxV3NudXcxZndFeG5YLzNhdXpMSitF?=
 =?utf-8?B?S2drOEVWMFdyR1ByQ2VjRlBVUWFsL0VUMXVDM0taQUlpSkVpN1FYdW9JRnQr?=
 =?utf-8?B?NFJRQXRldjRydHBBYWZGdXNuSWk5bERxZjE1MDNWMnhHVUZTaXJHdWJicDFH?=
 =?utf-8?B?dWtUR1U5U2NDNHZXMDQrMWs4cjJPMTRyRVdlczhFSDIzYU9Na1QrZ2l4RDV3?=
 =?utf-8?B?VVpHemdKMVA5NWdCcGl3bjVuNThDREdPWHpoYkFBeTEzWTJyMGZ4U0NVek5t?=
 =?utf-8?B?Y1hROVVKcFFqYzI0MVhmN2o0bFVoVFhJT0ZPb290RjU4a2M3L2I5TkhHcUJJ?=
 =?utf-8?B?R0M0SHlpOTFZazdUa1cxOTJvTnNnNVNOZk85cFBLVjNXTjdpaVlNekhTRTBC?=
 =?utf-8?B?UTVKcFV2ei9jZEJGRW5heFl1aXlYc0hBMUFFUjgrYnhhN1gwRVZaRTdyQ05S?=
 =?utf-8?B?TkJ6bGJvU1B5a3UvSWo0WjQ2ZjJhV1B3R3ZCQjFpWlpzNnYzNi9nMkZBNDF2?=
 =?utf-8?B?VEUvWE8vK0lkM2V5L21IRW5XZWxOSFZmdEozN0pvNlZER0VacHZrbDYyZW5v?=
 =?utf-8?B?bGR5bkVUQmppWmZjNE1ZcUQ5RCtXZ1VsY29iWS9rVmJzN3NWMnRvTHc4cThD?=
 =?utf-8?B?dlhuaFIrSXlGa1I4ZW9mL3UyRXlMTWkvam94eE1YLzUxOUNlTG93aytHZDhG?=
 =?utf-8?B?OGdEdTk4TnVSM1c2ZDM1OHZreEhZS21JMWhRMmZ1N21RKzQ3YTJ0UDA2a1F6?=
 =?utf-8?B?b2tPYkwwRnpkUUg0c0V5cTMxTTZwbGZxZkJ5YlBBWndVcFRmU1BaY3o0U1pj?=
 =?utf-8?B?T0VJNXlTMkFBeEhwb2dlcXNHWFV1ZEl5c3dOT2lCNDArM1BDZjlsZHc4THY3?=
 =?utf-8?B?WjlSSk9Dcmw1TTRubWJxTkhGRDZoblhvRk5HSFFHWFY3WVpGekhQSlVkaHBK?=
 =?utf-8?B?Y3pSdENTWXdYZ2F6OXljODRJSmtQVGxxNXFZbmZNZVpvRlFFeWVWd1JhbytG?=
 =?utf-8?B?WmluVGhCWnhhM3hpSVBNL05taEowMXJqUjduQ0JIR0YrRVdFUmlnS055ZU0y?=
 =?utf-8?B?ekpOQVliYmZBQ1VBKzlMd3Y0SzVYOFVSc0JxQk4zbnNvSTJZRFRjRTl0Zm44?=
 =?utf-8?B?TzJqTXlRMHgxSXFsbUh5L3QrTDNlYTNVTXJabTl0ZzZBd3JhRzlqYVZQNjl2?=
 =?utf-8?B?VzdVWm5sejNCdlBGSHhmUy9RNnA1alFoR09RcUtrcVJBSjRBcStOSUdkOUNO?=
 =?utf-8?B?L1dJWnFMYjFWQjBibk5TQ1FtM0dLZXhBTzYzMWl4QWE1N1MwM01ZbVhTMGVm?=
 =?utf-8?B?SWUzaHNNb29raisrNXpxVmNYQlRZdkVnWnVzK1JzUWc4MmJpOFc1clRVQnJI?=
 =?utf-8?Q?mDje9bPNrjo01GUbcZt5dSzDk+UGII12zQPWZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17F4DC7C60FBED4ABA42A302A2D73D70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a3drrI6KTDPwsEKGSWLfZ86UpguSATFMJQO5ouAdg27tvgmbTvQ30y7fSBvsJitft1WVBvvgqVC5XLlg3jaPUH+MYzkQhaAg5WJaPz9VOU7PIjlY1McgtiQHJVLmbnx/kqISdiM929UltdaV1qRuaNrjhQIHTjxzDnXmuKZ0iBXq5QHhu5n2XXoV+V/MDL/GFtxOIn2WBzDXHjgu9WSPY9jRC/6AvGvTnRNm56byXt+2Gf7L+JvNTuKaluP+DhFApjY4KS/+Zjp/RlQpksFdhQDyrigSTaBkYsLDb88381gHPYIz+Iq8J9RKSiG7djQdUnNRu12itQNA3ntXG0baDQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf066be-8e6e-4831-492d-08df3900fd62
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 16:47:32.3219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMkc7RsMziBhAHSvYMq893Xw2rBXUvre3lLHSFYEMh8Sm5Z/bpHpr4M1sD6qHJ+/w+hLiQnZID+FT8iGTwjREZEl6MUoUR9PKN0tPM5bWQmUCgZZLT3AVA5FlprF10Az
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSM1PF66CA93CEB
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

DQpbc25pcF0NCg0KPiBBbHNvLCBvbiB0aGUgc3ViamVjdCwgSSB3b3VsZCBwcmVmZXIgdGhhdCB3
ZSBzdGljayB0byB0aGUgbm90YXRpb24NCj4gV2FfMTQwMjgyNTAwMTUuDQp3aWxsIGZpeA0KW3Nu
aXBdDQoNCj4gDQo+ID4gIAlHVUNfV0FfS0xWX1JFTUFQX1JBTkdFRF9UTEJfSU5WCQkJCQkJCT0g
MHg5MDBmLA0KPiA+ICAJR1VDX1dBX0tMVl9JR05PUkVfTU1JT19SRUFEX1NFTV9UT0tFTl82NAkJ
CQkJPSAweDkwMTAsDQo+ID4gIAlHVUNfV0FfS0xWX0lHTk9SRV9NVUxUSVFfQ1RYX0NPTVBMRVRF
X1dJVEhfUFJFRU1QVF9JTl9DU0IJCQk9IDB4OTAxMSwNCj4gPiArCUdVQ19XQV9LTFZfRU5BQkxF
X1BBR0VfUkVDTEFJTV9FUlJPUl9DT01QTEVUSU9OCQkJCQk9IDB4OTAxMiwNCj4gDQo+IFByb2Jh
Ymx5IGJldHRlciB0byB1c2UgdGhlIHNhbWUgbmFtZSBhcyBkZWZpbmVkIGJ5IEd1QyBoZXJlPw0K
aWYgdSBtZWFuIHRoZSBpbnRlcm5hbCBzcGVjIC0gc3VyZSBpIGNhbiBkbyB0aGF0IGJ1dCBpIGRp
ZG50IHJlYWxpemUgdGhhdCBpcyB0aGUgY29udmVudGlvbiBoZXJlLg0KW3NuaXBdDQoNCj4gPiAr
CS8qIE9uIEd1QyA3MC43OCBvbndhcmRzLCB3ZSBlbmFibGUgR3VDIFBSTC1jb21wbGV0aW9uLUlS
USB3b3JrYXJvdW5kIG9uIGFwcGxpY2FibGUgR01JRHMgKi8NCj4gPiArCWlmIChYRV9HVF9XQShn
dCwgMTQwMjgyNTAwMTUpICYmIEdVQ19GSVJNV0FSRV9WRVJfQVRfTEVBU1QoJmd0LT51Yy5ndWMs
IDcwLCA3OCkgJiYNCj4gPiArCSAgICBndF90b194ZShndCktPmluZm8uaGFzX3BhZ2VfcmVjbGFp
bV9od19hc3Npc3QpDQo+IA0KPiBTaG91bGQgd2UgcmVhbGx5IGdhdGUgdGhpcyBieSB0aGUgaGFz
X3BhZ2VfcmVjbGFpbV9od19hc3Npc3QgZmVhdHVyZQ0KPiBmbGFnPyAgVGhpcyBmbGFnIGNhbiBi
ZSBjaGFuZ2VkIGF0IHJ1bnRpbWUgdmlhIGRlYnVnZnMuICBJIHdvdWxkIGFzc3VtZQ0KPiB0aGF0
IEd1QyB3b3VsZCBkbyB0aGUgcmlnaHQgdGhpbmcgaWYgUFJMIGlzIG5vdCBzdXBwb3J0ZWQgb24g
dGhlIElQIGl0DQo+IGlzIHJ1bm5pbmcuDQoNCnllYWggLSBsaWtlIHlvdXIgaWRlYSBiZXR0ZXIg
LSB3aWxsIGp1c3QgYWx3YXlzIGRvIGl0Lg0KDQpbc25pcF0NCg==
