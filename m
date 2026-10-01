Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B00CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D12C10E25B;
	Thu,  1 Oct 2026 11:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hX4o/9fm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3354810E21A;
 Thu,  1 Oct 2026 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790853684; x=1822389684;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YDrYP4SZjUREft85amCAuo3SHjNjxbcMWN4fCCIXIRo=;
 b=hX4o/9fmt6LwHJW0ZMDdAC3x8aInCG4wwKFnnFsr9IabRUaOQLzqswQJ
 5I6YTmdThj9N3WWOOeKURpp41DhhehR84wxV3sxDU9wjfq53+Xl6sI4Zc
 f9f1v4DK686Q7i0W9/UgQ8NPkR/0jFKpb2NUPneT4JJp/D5DKVBbqt7ws
 MwXx5sTs0qwz6somNESq1Fgf2Go8e2lEQZi0txU95HFuBAwNnXKQyvHbZ
 ZIDr6IiU7f/9KJIu77nJMEZvLIa6CoJWFepBXiz99YZ1bW5yDBYfVlod9
 4+CsIUgu/QJy5u3b9ckEfGUD+/ayRjaLAT3u+5DQTk+oWEuA+MrcOG7p8 w==;
X-CSE-ConnectionGUID: l/vFs7t8TQa3/fbEICf6cg==
X-CSE-MsgGUID: Yu2vt+8JTRumZiQwVkZiOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90820132"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="90820132"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:21:23 -0700
X-CSE-ConnectionGUID: 9ahYUDnmSQO/5hXlpm+Vug==
X-CSE-MsgGUID: mPYwTp3tT3SasStj7dTgrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="274054882"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 04:21:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:21:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 04:21:22 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 04:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVt8jC3pJWbmJ5FMCBsJhT0sOmsjOWvCzIpQcB55jF47KsGHWr+20M3goG7BHDcsMw7T1tzsl6iAQKu3XtelI9i2FbJuY+yQGY4Tq2xtqMIvqw4kMpMEYqg57iP3Ywf4+u0IUQhzwaIwT4vMMRMLw8ApcpYTpiNPsvYmHNx1l8BMX4tKFnO5TL6GRG5ol3ZR/7ixzxt3AFoyw7QMNBy1aVJKvC4vdqh7iQd4pGyRBqkWwFwvqnhCFQh/6Ya5XfevCLVulKl5x+X39iYLEdNHPOn4KXPEajbJWcGZE6o9lCFdjbHcBfNxslUNdh+Dt+TiDU5ck9UjH+SoggdDn9VP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDrYP4SZjUREft85amCAuo3SHjNjxbcMWN4fCCIXIRo=;
 b=ZSH2SODorAtuFea7slJ1DpYUMgTetx51X/kJ8v6E7RDREUJsPR42qRKDOXYf6+/43YTUd50T9nGVysZ4TnoNIAtlcH7KZCtUBZadg6xhxLSURD8N9H890rxL9VeHlmMTamF6BsMGBgEBzeJVpLGu+Lv7jIU1gBZeWZCqBQEejYTe30Ymc/3u5qLJmMTc557CHMZVrCKVnWAoOtkPUoym87hi4AROCLH7ytuAgAizceS8es2Oea/tATh+L1Jp8u94JXwt2gmIetkbVb9Di0XyQDlbkAcQPdYbvU+ewil9+NMMQ52TpTAbBP3rUufve4hGpQnuFmYGN7Pq5LvKO4l1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) by
 CY8PR11MB6866.namprd11.prod.outlook.com (2603:10b6:930:5e::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.27; Thu, 1 Oct 2026 11:21:19 +0000
Received: from DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb]) by DS0PR11MB8049.namprd11.prod.outlook.com
 ([fe80::603c:772d:6793:d4eb%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 11:21:19 +0000
From: "Manna, Animesh" <animesh.manna@intel.com>
To: "Nikula, Jani" <jani.nikula@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "Kandpal, Suraj"
 <suraj.kandpal@intel.com>
Subject: RE: [PATCH v6 02/18] drm/i915/alpm: Move alpm sink capability readout
 into a separate function
Thread-Topic: [PATCH v6 02/18] drm/i915/alpm: Move alpm sink capability
 readout into a separate function
Thread-Index: AQHdRUGFifx7UNgoj0ujRax9QgVIGbbm2jeAgAHH9nA=
Date: Thu, 1 Oct 2026 11:21:18 +0000
Message-ID: <DS0PR11MB80492B52C8B9856389A89CDDF98A2@DS0PR11MB8049.namprd11.prod.outlook.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-3-animesh.manna@intel.com>
 <2ed6b4ccefd2d302433fb990401b0d62efa75c84@intel.com>
In-Reply-To: <2ed6b4ccefd2d302433fb990401b0d62efa75c84@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8049:EE_|CY8PR11MB6866:EE_
x-ms-office365-filtering-correlation-id: 07837127-c52b-470d-f4f5-08df1fae1d7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: HJclEhjUybqSns6R0XXdBSYtrGxewsi3PdRagC3bnbwMvvJn8ioq/b9r/mG06ns/Y6tiFz4wgErFt8uLehX2ezMIiW2W2AbGsiIMcIqmFBbl85dX9u26nQRyi/1ejtVv4RCC/tNwGuNUOoNFccyFOywXoLGF/QRcFWrEPjNZEc9K/suaBVRgagtzelqhXBtBC+xqMPoU9DGYfscwLBiyGONPRUi1gpYmPKn6YtzKGQG25OONkZmQzzFB+lR8grU4af8NA81F4bUy4Y+siaDvqycHtpzl4dIIWEQwmMPdT+M+Ep7lwUdJhtqzbjZClto6RgQQ0v+w0pBS4wwlsQAGfeU6RAPoG/SQqkL9Zrt4jQkt7tAxCQzpsw0/3ecZ1F8OzeCaH+0EhUluVmx6H3SFIC4STYHUz+RgmlYwetf3oL+qbB8/7wwctQEDuApSqUYuLSvhaUSo+K8ItCss0Z4ig3nnOgA1VgOgm/Brg/uvqEcbQYuDw7eX7f9gE7+4F2Q14ya5SR+1KnKbZJpw04KLfpMcPTDj3gx5vKKstPLCwPpgH7wd4BX7Mmu4/gsSjxv2TM9y+sy/E8D1krMbrinYdJO1+CS6vXHF5xXUbnnI0urE44rlVIgSCiirzU/qP2zDp2ujv3ewKkJRdsbVi6GAxR075280xRG7zmjv8bW0rEUCTd/JxTg9wHwrr7UYhDXUHCkq67gWl3vmMtrcXW4h+wLfSlLz1mU1NoUEzsfOXW8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8049.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWFrREdxSkJ4MlJrSHh2SzhuemdHcFh6UFRwdFJCV1VibmlJRWpUMHRmRHpW?=
 =?utf-8?B?a2xsMUcyYzIwWWpEeGNIa3A2UGlpSTFjWlpzbEZsZU1EckRmRHRPYnNML3Jt?=
 =?utf-8?B?bEEwZU15WFlSbTBORmVSSHI1MnRjQVVtNk1JRmJDM1Zza1dFajh3cXV1anpZ?=
 =?utf-8?B?MHNtWFI0eWcyWWltNjJ4bWVoSWRBNmtoZTIwc21kTDhWc29NWjVYQy9IdFMy?=
 =?utf-8?B?eDVqU3VGNDhxbzRmYUxabUxiMFp3Z29iSnQ3RXk3UFU3Smdrd1FQQVRhWXRR?=
 =?utf-8?B?MERiUDdRUUlsdHBuNThXbGxQaDJjQjZDdnp3a2tQMjdzSkV4eHBHSC8vT0dX?=
 =?utf-8?B?QVpXN0dnTlRNUEVaUVpVR25ra1AwTjhJditWbkl1ckxFd0VVUlcwazZqM2VK?=
 =?utf-8?B?M2xZblhKZ0srME1YclJ6RkxpeE83WUx1eGJRa0NYaWY3dkZwaGEwZWd3SkJr?=
 =?utf-8?B?amRpQjZVRGRRVldNaXFTZ0laNWdmTHRhNmYrd3pNaEVUUTNXd29JUWxFL1do?=
 =?utf-8?B?T0lhakNkcXpFQVVkSkMzWm9aa21DZUJJTGNhSGlSMEljZ3lMV1NMcDRtVFM4?=
 =?utf-8?B?R29OcmdaNDdxdnlBZVYxcEp4TWMrM1poaHljM2xXaUhxMS9JN0orRm8ra0xY?=
 =?utf-8?B?NllaTDd6RE5kQzdUQjRlOFkrOU4wb2w5ZVJmSFYyejB4OXRzdFMvM0ZicDhk?=
 =?utf-8?B?OHR5YlJsY09uOTAyVXhOQU94Y1FJdnpjUzQ2Z1Q1UXRPYk4za3dxN25ubS96?=
 =?utf-8?B?Ri9DWlorS1RTZFI3NmdEZ2Y4MFh0dnhEb1RpYyt2Kzh4YkplRnRZRmMzUW9h?=
 =?utf-8?B?NnA4Z254MzZuWS8zRnJKY0RUNGtYSjVjZ0paaVJMUGw4QTFJcVJOTGFiRW9V?=
 =?utf-8?B?eXNldlk1Vmptd09GQURNck1GSitib3BpdFpZSzhIUWtHbUtNOUdHUFdVYjVC?=
 =?utf-8?B?MkdVNW9ENVFrNHJ4ZndOcW92b0YzTDU5SHNuWWpDMEIzbkYycWNWRFo4bVRq?=
 =?utf-8?B?c3FGUGwySHV6djF0bXg1Q0tIUlZSWnFXeDRCNnFsWFROZStvUEJZemxXTzhJ?=
 =?utf-8?B?anRZQkFEMWo2UUJQZEhYU2RlaEZzbnBGS3ZsN0FuSENGeitoYmtGbDJReDNr?=
 =?utf-8?B?U0ZDRVl1RFlZQTUyN3NQVXh2eEhUNnBrMTU4RlRMZXJjeElrSy9GNHVQNERE?=
 =?utf-8?B?V0ZlM3ZkN3VTb0E1cE43eFZTTE8xeUtPZmwvREdWWU53cGlNRlNuZXA0ZEMx?=
 =?utf-8?B?d0hnYkNhbDRLNXpKWENtVldLR1FSUnNsSEErbkRCZG83Z0J3TGwyQmw4K3pu?=
 =?utf-8?B?ZnAxOU44czMwSjhsYjh0YnJ5WWpwZVZrYlFpNmNKejQzUkt0WUkvbktVSDlj?=
 =?utf-8?B?NTJ1a2J5NWdtank5R3ZqZXlzaFM3bW9YYVhpbUZETlhsd0g4U05vQ2dlcGhY?=
 =?utf-8?B?SzlTb1UwQjdGR0p3YWpiSmhLSy9kQ2JaaURDcjZaUXlmdUsrSFZyWUlyazFq?=
 =?utf-8?B?S0Evam1PcUt4Qyt6aEtMSU9UL3RtWXdXVTN1NFM5SUFtSHJIMkQyUFg5WTRx?=
 =?utf-8?B?ckVUeHZNWGlBSEErZklrRU11b05sMVZsOTV6cGE5YzNZR054UmdwRmxWOW8y?=
 =?utf-8?B?cWJDdkpFTHRRd1FlZW5Ba1ZncXpGa3NYbXM0ZUwrQ1gwcDZoZ1pRTGV4dHJQ?=
 =?utf-8?B?MHRpRnM0RFdxZWFpcTg5VVRIY3NlM3FROUptaUNJM3h2Q1U5cGxNUlhKdTZ6?=
 =?utf-8?B?WHcvRjdqTkRDZVlVUitJRTl6SjJKMHh5TmQwTFp6a25xSXRNUFh0V29vaGV5?=
 =?utf-8?B?NUFQM3F5VVNxb0Y0d3hGZkZXRE5NcWxoRVljWXNDTTBZNzRpMy9KM3dxQjZ1?=
 =?utf-8?B?YlhzMmtkWlQ1WmJBTit3Tk5iN0lubUROQ3lXM1FRUVdrcHluVHFrWkQ5ZWUx?=
 =?utf-8?B?TG9LUFJRZ21ZeDVySHdWMjdyMHdnQU1jSnFqditQbHRBWTRoRnovbHVpRjA3?=
 =?utf-8?B?S01jU0NkNnpJSlByNXVDdUs5OGZWMjZxWUd1RGFuRS9CTXpTUWxRVGNIeFdz?=
 =?utf-8?B?QTFYbDltY0VheUpDRG5XS3l5eXpIZHFaaVBxOHBTZFJxQXo3a242SHZjK2Z5?=
 =?utf-8?B?U0lVOVJUVkJHL3dEZWZ0SmZscWFGcFAzNUVvWEJ5V3dqTG1mZEFuWmRQVVRF?=
 =?utf-8?B?d3ZZcHpnK0FLc3pxOTBYemsyWFhXa0NaSldhTzJ5bFdsN0VpYW9ORkQzbEYw?=
 =?utf-8?B?T3czNUNha0twcmxRTTh2bitROVZpOTdTMUZVZk52M1ZHZGJ0Ym5JalVJTWhY?=
 =?utf-8?B?dXdlRnUvK0QrRmVWc0JEQ3JuazgrV01SckxCcFJhNEZwWkE5S0hHVXNGb0Ni?=
 =?utf-8?Q?RQh2FvyXf1Ibc2OM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NEG4rNp1zwaFZwOW1IDRLz7eaLG3EAZnhd7JlHpCDOqeBllq6lVK0PeomMf39RKNzYPN+jFjEE7sHEWD8OBhy8TO2zyQTWA950boxKekNbKT4xI/OG5eKq6GQHbymKJfxdm9Az5v7HyJTT+dTn+O0H9LT5ZNeNjA5BxPhKZTbe4eIIEfh23VV4o8GG+eloVVR3Ivi8/0PQt2wKMkYYS5PEKDi/7j9kVdT6SeC3ygKl77tR1IrML4sSMkiM5a6WaD3/7m5UpuM3g1JARg1J7AiEpwOAQSj3XT5uIZqt0Ye4YvCMRGyKBsSfxG0lpdkZNLOZaS65qlTyuzXKgg6BFTfQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07837127-c52b-470d-f4f5-08df1fae1d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 11:21:18.8932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S89SMNwZN5MGcyfHYjYFJ5V2t1SJCnu0xvsZphXvA7pV5MKA6zemjPo+O10yVIK+2mqwwSuL4LhzDX0RYvKUYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmlrdWxhLCBKYW5pIDxq
YW5pLm5pa3VsYUBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDMwLCAy
MDI2IDE6MzUgUE0NCj4gVG86IE1hbm5hLCBBbmltZXNoIDxhbmltZXNoLm1hbm5hQGludGVsLmNv
bT47IGludGVsLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC14ZUBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IGRyaS0NCj4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBIb2dhbmRlciwgSm91bmkgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT47IEthbmRwYWwsIFN1
cmFqDQo+IDxzdXJhai5rYW5kcGFsQGludGVsLmNvbT47IE1hbm5hLCBBbmltZXNoIDxhbmltZXNo
Lm1hbm5hQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMi8xOF0gZHJtL2k5
MTUvYWxwbTogTW92ZSBhbHBtIHNpbmsgY2FwYWJpbGl0eQ0KPiByZWFkb3V0IGludG8gYSBzZXBh
cmF0ZSBmdW5jdGlvbg0KPiANCj4gT24gVHVlLCAxNSBTZXAgMjAyNiwgQW5pbWVzaCBNYW5uYSA8
YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IEFic3RyYWN0IEFMUE0gRFBDRCBp
bml0aWFsaXphdGlvbiBpbnRvIGl0cyBvd24gZnVuY3Rpb24uDQo+ID4NCj4gPiB2MjoNCj4gPiAt
IEltcHJvdmUgY29tbWl0IGRlc2NyaXB0aW9uLiBbU3VyYWosIEpvdW5pXQ0KPiA+DQo+ID4gQ2M6
IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYyB8IDExICsrKysr
KysrKysrDQo+ID4gZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmggfCAg
MSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYyAgIHwgIDYg
Ky0tLS0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2FscG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9h
bHBtLmMNCj4gPiBpbmRleCAxMDk0MzUzOWJjN2MuLmE2NzQzZmU2MmQ0OCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gQEAgLTQzLDYg
KzQzLDE3IEBAIGJvb2wgaW50ZWxfYWxwbV9pc19hbHBtX2F1eF9sZXNzKHN0cnVjdCBpbnRlbF9k
cA0KPiAqaW50ZWxfZHAsDQo+ID4gIAkJKGNydGNfc3RhdGUtPmhhc19sb2JmICYmDQo+ID4gaW50
ZWxfYWxwbV9hdXhfbGVzc193YWtlX3N1cHBvcnRlZChpbnRlbF9kcCkpOw0KPiA+ICB9DQo+ID4N
Cj4gPiArYm9vbCBpbnRlbF9hbHBtX2luaXRfZHBjZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2Rw
KSB7DQo+ID4gKwl1OCBkcGNkOw0KPiA+ICsNCj4gPiArCWlmIChkcm1fZHBfZHBjZF9yZWFkX2J5
dGUoJmludGVsX2RwLT5hdXgsDQo+IERQX1JFQ0VJVkVSX0FMUE1fQ0FQLCAmZHBjZCkgPCAwKQ0K
PiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArDQo+ID4gKwlpbnRlbF9kcC0+YWxwbV9kcGNkID0g
ZHBjZDsNCj4gPiArCXJldHVybiB0cnVlOw0KPiA+ICt9DQo+IA0KPiBXaHkgbm90IHByb3BhZ2F0
ZSB0aGUgb3JpZ2luYWwgZXJyb3IgaW5zdGVhZCBvZiBmbGF0dGVuaW5nIHRvIGEgYm9vbGVhbj8N
Cj4gV2hhdCBkb2VzIGJvb2xlYW4gdHJ1ZS9mYWxzZSBtZWFuIGZvciBhIGZ1bmN0aW9uIHRoYXQn
cyBub3QgYSBwcmVkaWNhdGUNCj4gZnVuY3Rpb24gYnV0ICJpbml0Ij8NCj4gDQo+IEZyb20gYSBt
YWludGVuYW5jZSBwZXJzcGVjdGl2ZSwgdGhlIG1peGluZyBvZiBib29sIHZzLiBpbnQgcmV0dXJu
IHZhbHVlcyBpcyBhDQo+IHByb2JsZW0gYmVjYXVzZSB5b3UgbmV2ZXIga25vdyB3aGF0IGlzIGJl
aW5nIGNoZWNrZWQgZm9yIGluIHRoZSBjYWxsZXIgc2lkZToNCj4gDQo+IAlpZiAoIWludGVsX2Fs
cG1faW5pdF9kcGNkKCkpDQo+IA0KPiBEb2VzIHRoYXQgcmV0dXJuIGJvb2wgYW5kIGZhbHNlIG1l
YW5zIGZhaWx1cmU/IE9yIGRvZXMgdGhhdCByZXR1cm4gaW50IGFuZA0KPiBmYWxzZSBtZWFucyBz
dWNjZXNzPyENCg0KZmFsc2UgaW5kaWNhdGVzIHRoYXQgaXQgaXMgbm90IGNvcnJlY3RseSBpbml0
aWFsaXplZC4NCkdvdCB5b3VyIGNvbmNlcm4sIHdpbGwgdHJ5IHRvIGtlZXAgcmV0dXJuIHZhbHVl
IGFzIGludC4NCg0KUmVnYXJkcywNCkFuaW1lc2gNCj4gDQo+IA0KPiBCUiwNCj4gSmFuaS4NCj4g
DQo+IA0KPiA+ICsNCj4gPiAgdm9pZCBpbnRlbF9hbHBtX2luaXQoc3RydWN0IGludGVsX2RwICpp
bnRlbF9kcCkgIHsNCj4gPiAgCW11dGV4X2luaXQoJmludGVsX2RwLT5hbHBtLmxvY2spOw0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uaA0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgNCj4gPiBpbmRl
eCBmOGY2MDVkOTRmOTYuLjU2YzNlMTQ4MmUzNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+ID4gQEAgLTE1LDYgKzE1LDcgQEAgc3RydWN0
IGludGVsX2Nvbm5lY3RvcjsgIHN0cnVjdCBpbnRlbF9hdG9taWNfc3RhdGU7DQo+ID4gc3RydWN0
IGludGVsX2NydGM7DQo+ID4NCj4gPiArYm9vbCBpbnRlbF9hbHBtX2luaXRfZHBjZChzdHJ1Y3Qg
aW50ZWxfZHAgKmludGVsX2RwKTsNCj4gPiAgdm9pZCBpbnRlbF9hbHBtX2luaXQoc3RydWN0IGlu
dGVsX2RwICppbnRlbF9kcCk7ICBib29sDQo+ID4gaW50ZWxfYWxwbV9jb21wdXRlX3BhcmFtcyhz
dHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwLA0KPiA+ICAJCQkgICAgICAgc3RydWN0IGludGVsX2Ny
dGNfc3RhdGUgKmNydGNfc3RhdGUpOyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2RwLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZHAuYw0KPiA+IGluZGV4IDBjZDVlNmI1MDM0Yy4uNjUwYzhiMzkyNzBiIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiA+IEBAIC00
NzgzLDcgKzQ3ODMsNiBAQCBzdGF0aWMgYm9vbA0KPiA+ICBpbnRlbF9lZHBfaW5pdF9kcGNkKHN0
cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAsIHN0cnVjdCBpbnRlbF9jb25uZWN0b3INCj4gPiAqY29u
bmVjdG9yKSAgew0KPiA+ICAJc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkgPSB0b19pbnRl
bF9kaXNwbGF5KGludGVsX2RwKTsNCj4gPiAtCWludCByZXQ7DQo+ID4gIAl1OCBkcHJ4Ow0KPiA+
DQo+ID4gIAkvKiB0aGlzIGZ1bmN0aW9uIGlzIG1lYW50IHRvIGJlIGNhbGxlZCBvbmx5IG9uY2Ug
Ki8gQEAgLTQ4MjksMTANCj4gPiArNDgyOCw3IEBAIGludGVsX2VkcF9pbml0X2RwY2Qoc3RydWN0
IGludGVsX2RwICppbnRlbF9kcCwgc3RydWN0DQo+IGludGVsX2Nvbm5lY3RvciAqY29ubmVjdG9y
DQo+ID4gIAkgKi8NCj4gPiAgCWludGVsX2RwX2luaXRfc291cmNlX291aShpbnRlbF9kcCk7DQo+
ID4NCj4gPiAtCS8qIFJlYWQgdGhlIEFMUE0gRFBDRCBjYXBzICovDQo+ID4gLQlyZXQgPSBkcm1f
ZHBfZHBjZF9yZWFkX2J5dGUoJmludGVsX2RwLT5hdXgsDQo+IERQX1JFQ0VJVkVSX0FMUE1fQ0FQ
LA0KPiA+IC0JCQkJICAgICZpbnRlbF9kcC0+YWxwbV9kcGNkKTsNCj4gPiAtCWlmIChyZXQgPCAw
KQ0KPiA+ICsJaWYgKCFpbnRlbF9hbHBtX2luaXRfZHBjZChpbnRlbF9kcCkpDQo+ID4gIAkJcmV0
dXJuIGZhbHNlOw0KPiA+DQo+ID4gIAkvKg0KPiANCj4gLS0NCj4gSmFuaSBOaWt1bGEsIEludGVs
DQo=
