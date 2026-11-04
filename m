Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AF606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HKHGAsqQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5BE210FA5A;
	Wed,  4 Nov 2026 08:31:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4894C10FA5A;
 Wed,  4 Nov 2026 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793781099; x=1825317099;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5q0Cw26zXSNsmOmuz8ig4xGpV0KuUbcXRm6n7VbEmeo=;
 b=HKHGAsqQl5JwWNrttXsixHesrE13LUdBVFA9JOro4cswEk57Ui8buAzD
 s4YKbxAXXxwk27C4Z+WCfGpOp8mZgeWhM+Lz3Fz1sGp96ODRDhVI3nus6
 wBmtaUfSBp/ZGh1aJ4UePz9WoCBx71OMg5bLkahH1cwddiXOWPuWuQzNY
 7Zeca/lmmMhP69aW4z2xxPVgj7dq8nav/NWA/90Bt3TMNtw8ysDnWRb5F
 RPIK8GU9zHrv2/QrwzE1wohPly5NRr+n8yrgtl1OGEvAitSlku1ZLjmEw
 g1b19XGhEXbxVnFi1qrVAFW0PDs5iDuoVbpjPDrmH36QFcvCfimBhYsxQ g==;
X-CSE-ConnectionGUID: frlPQzHfSIuximKAvKkA1Q==
X-CSE-MsgGUID: Y92VjNe/Sfu0iqzquWj0zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2562227"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2562227"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 00:31:38 -0800
X-CSE-ConnectionGUID: I26l3NTyTUKwwKxALwJzKw==
X-CSE-MsgGUID: oTk2a8DSSBCtvqjiXivMUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6669298"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 00:31:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 00:31:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 00:31:37 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 00:31:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSJ0l7BhsHZFy2CWIhC+Ms31Qsvpm75lCLp5AJEI9FS6ac427dLbP5zPmCukS3kWfd4FV4djWz5s2bqS9EmBasPdcyz3EZy8tm/sLE+Px7MrQZpm6LUsWuOOMkF9Uaf2eXOBE6UxDil483HkIW7xTSRTZrLKdSqVFQHSchmy/0stlAS6D2qtsfRBbQHYWLi3gF92pe4k6+yyJfanT5pvXt4YdIQP0X+OEIRVCxsKHkg79qxNEPV8T/wc2ytSW5yPF/+Gn9GpA9DXYd/Zecflq0jtBlRBzSY4mEm5YodZdcYN0pSkccFuNk+iOMZYsZN1vOoDzsmqYiMSQ3jFsGFczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3d/5X9/aLOSV9tFNtsyx5MPuGRWsjf245KCdcvb73A=;
 b=wxYZ6AuUU5VzYJW6dv/XemKFBe5iwdDkWITKXYBUgdOpdmV+/cKeXfmiE28QapWAvXoIuLEeWyljHM9PvSbCtVryjNIJB4KR8nlFSTaqQFWhFSJbSRMpOQ8QZ+4LbfNQi3UyOf1T2jfWO08UjFFdD8FHQ7nIR6GPTt+Sda18cBdZ+2xNAkusETO3qE6HlIe2yo+6mFV2v12/JASi3GUUkdEgdumikag6IGQzUrNR8TWTH+f66O5t+vj2MxEjT0NP94eHrmY6VkhAOK+PIiUFmtZG5ygRtIzz6wKz62JEJ9ecto7X+vqihDpOsnp6MpAWz7dAGpVBFz/Y3ea7zArFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by SN7PR11MB8262.namprd11.prod.outlook.com
 (2603:10b6:806:26e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 08:31:29 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 08:31:29 +0000
Date: Wed, 4 Nov 2026 08:31:18 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [RFC 1/5] drm/i915/selftests: Port GT-dependent selftests to
 work with multi-GT (low-hanging fruits part 1)
Message-ID: <dfu5i2azyy33rdspuob75ytvy6glyenaxme6a24yqqeaku3hyd@ixfi5dengytn>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
 <20261029014155.55865-2-krzysztof.niemiec@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20261029014155.55865-2-krzysztof.niemiec@intel.com>
X-ClientProxiedBy: DU2PR04CA0277.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::12) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|SN7PR11MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d71797-03e3-4bbe-db2e-08df3a4e062f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|261102123227099003|56012099006|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|4143699003|11063799006|261026140227099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 14h+IQdNuCv+PBIsZRjTBmq+SdC7MzRIgoLhnN8jGoe+JGGziYNyYsgr54ZuEFcRHFqrBmpBhKUbQ0oDXh0JYfwsUxHr6NdpjgpPQEG/QeXud2LrFOxjTmFmBEmAsJnGnfM1nuMtBT2eIFbIbboXzKAhuo1Tyn8iQLkRxB6lW57ZgCIfa5cVWyzF5xLN3AVvtDwdlwjUZPzJMI6WvuhRgsJ7zVDTI+48WLWIkLQzLq72mkhB8aLKdfpxJT+XP3rmhAX4s3vB8asnUDr7rJhTJMk9IGggKcQWsOIsYKPIsRdRZdPXTx7MPaA2KMPegfOdsq/5+JIxDSka6PED+TljpXLw0N1gFkK6iNvToP1xTph1Z8cT3b4GbXKQcg0fn16noBpYurleOIRK8Gliq3/H+uUWA6XEUE9qynAT288PsUvxNqgqyNRM+jyabjwUUJ+DcWkEpI7OqeBkSp2WT0d8jzr773s8FQRvSfghxqpC4gcGjtUBApRfPb5ku2RJbL0DZlh3KZjgnnDD30szNKnDf4RBFFL5RsOdHBt/V23B+j9i6l+Xt3RsBKpJcvyhKbI2OUyOdl6N9ZwXANuDDZQlw6tDceseyVvJAHkDeHfAEurPmicY9u7Y6j2bxkp6Ndnhc+0dEwo7xtDlQ4eDwS11ACC0McVxuk/csyya6JXfIvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(261102123227099003)(56012099006)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?endmRVhCYVpsTlVsbVN0eTZxTlNHMXRNSFdGSVJBNXhoZ2VUY3Y3cWpZVFUr?=
 =?utf-8?B?VU83NldRUzZ6Vjh3RWhmbGZveXdDU1hrS1FFRmpNSmZwdjdOdDlrV3lXV0FF?=
 =?utf-8?B?anhKM1YvZW8rRHlVUml3eHYvc29SaFFTMFlwMG82N0JoRXJoUGY3VXVyc2hy?=
 =?utf-8?B?YTY3R0p2Q1I1ZXVFZ0RYaWJKU01NSEp1V0xERWUzTDVVSFBtM0FTYkIwcVNZ?=
 =?utf-8?B?TmQreWxaQmMzWEIrcXlIaitxM0g1WnFuMWM5alZzNDlwTzIyQ2xQdkthL3hK?=
 =?utf-8?B?Vkx2VnNqL0ZibTBHMit3S043ZWRiNzdZdGYxZENVRDZJaDduV3hvZFpESXZO?=
 =?utf-8?B?Q1lYdDNHalo0Y0E1alNySUZuS21UNFF3MVRxK25pWFhETkRITVYvVVVEU1Fl?=
 =?utf-8?B?UFh4QmhGSGNIMHZrckUxT3lra1VCc3laVCtxTXo4RDQxM3RBVFZ2OUlQT1BT?=
 =?utf-8?B?aHpMTjVET1h0YkJzYUpISlNucjN2ek4xa0VoM0ErZHV1QnRXTDVrVDZvcksv?=
 =?utf-8?B?blN0dWp2dkVUejZHQXEvZkxaRU40K1VGM0wrT3A5UXRURmtFa09DTEFWZXpz?=
 =?utf-8?B?Nk1ZUHIzUHBpRmlmNk9KTnZUblNMUzBSNk9xYU92eW12dkViblFZdXBhZklH?=
 =?utf-8?B?TkZNaGJtbUdscnpQOWZoaHRIVlk1ZVNaNDlMMGlCR2l2cHJGb3RJa0hsNVo2?=
 =?utf-8?B?eWN0L0JyWjBNcXJsTFY4T3lUOTkrbUtTWDhUTTlmVjNKdGYyMFl6cTVuN2lx?=
 =?utf-8?B?azN1amFyRWdmL1c3enJIL0ZMR21UTWpLV0l4VGJrTm1jNWMrL25oZTJvWVpl?=
 =?utf-8?B?RWlvOUtZNjRNZXVrL24zYzBVSEx3dENZOVRaUkJ4QjhWbEdTZ1FqdDEvbVAz?=
 =?utf-8?B?SWpqOVREblZzZkN0a0lxUnJsK1NIRVFzSFEzNzdHUU5RTERCWmp0aElZdlRX?=
 =?utf-8?B?M2Y0ZnVPU3A0ODk5VWdLRlJ5Ym5uRldJZW9WRTg3SnpycVZKUExKa3JmdWl2?=
 =?utf-8?B?Z290L1BGOXJxRGhSRzdZMWowSDIyMTVlbjlqcjhDVVl5VjVIbStUNnMwRDZ4?=
 =?utf-8?B?VUVEcDBjS1N1K3lYZXJvQVdSaDhLTWJHQWdBbThzMlJlRnp3MkhNbmYwUmF1?=
 =?utf-8?B?aXJhQ1ZyNWFoL3BhdlNYdzJ0d3NZd0VhbGw4RHFQSHpsdkhTZTJqN2RzY1RQ?=
 =?utf-8?B?SFlKUEJkdXdSUHR6cThYNE1BazVJWDJpOVJjOGNETDRVUVl3dGRxQzZEazla?=
 =?utf-8?B?MFVlV0V3MmttcHorS2tzaHg3WjU3bUxGd2xicCtIRlZiemN5dmk0ck8vY3dy?=
 =?utf-8?B?UFdCRFJwTVNkaklLUk1wZE1zK0Jpd2I0QlAvYU9na3pVNzBNUE9xRDI1S1Yr?=
 =?utf-8?B?bkpWZU01Lzg0b3JhcXVLY25VUzVDMERZYTFMS1Y5Z0FxZGVqUTNlbkowT21x?=
 =?utf-8?B?M2ZIbVZIcHNyU1BjSjd5VG4waEtId2g3SEVxY1NyQ1hGQVNnZXYybGgwMmhy?=
 =?utf-8?B?ZisrOUJDTzYycll3S1Fsb1J1Z3haZmhZV3VOcCt6TU5qclJ1bm5uTmhBUjZ1?=
 =?utf-8?B?TWlnWHNicDcvZWhHN25udjFiMkVYWiszRUZqeEN4eTA1d1lxZFloVExhQVhw?=
 =?utf-8?B?aUM1RUZQMnFYY0pMM1g3Q1U1ZWh5aHdDSWhJdUlVeC8xRThreWpiY2lrWW1B?=
 =?utf-8?B?dnIxTkdYbDAySkFDUkhRQmZVbUtUUitrbUp4RGU3OWZjZHF0ekgxa2xhWitG?=
 =?utf-8?B?SVFBQzRDZ010eERiRFJQRW54U0UwK21DN09mdVRxdUd1V3JuK2lmWXBLVnEr?=
 =?utf-8?B?eDFYUkk3UDEvdlRJTjk4clArSVdUcUJOM2ViYVFVT21LOW4yODlrMmZ3ZHhx?=
 =?utf-8?B?RTRvUHV2WEZBVWwzNWg0SGhjaXp1TDk0N2VzVjM3QlVnWnNaYTFsb0UzTG5T?=
 =?utf-8?B?bHgwQUVKbGtCZTlkcnJSdGRiQlI4VDBMejVaMStYL0o5dUV6MDRmNDl2Y0s5?=
 =?utf-8?B?d2xselZlU1FjUDZOWUtjMFdkYjEzYWp3Tk9rSWhsTlVDQTNjZ2RtMjJOYk8y?=
 =?utf-8?B?czBsMFdYYUxmMEE4ZlBmNE9FbGNiUFYydGFFeWg1dG8xVi9xSUg2VWN2azUz?=
 =?utf-8?B?NWhIYUszS1F3N1FoR1BZU0JBT3VkRU1mL2REZS91OTJqN1ZZbHhKcythNHRn?=
 =?utf-8?B?Rk5vMmxzalZkVzlIdi8zalRoYSsyb0NpRVBYU2hpK0gzeGZJTm8vRVRRc1VP?=
 =?utf-8?B?ZXpSbzdtZGpXNWlJa01PaGNTVkJiQlR2WFIzU3VZSGg4UkFDWk9DdGVZTUo4?=
 =?utf-8?B?TFB4cDE0NEJIUCtHZ2ZIcWRtNktENmloVUc3ZmdIWlh0QkJrdUp0NTdBSmdo?=
 =?utf-8?Q?C1xHXQcxqMCksWvE=3D?=
X-Exchange-RoutingPolicyChecked: PKm6mqEDK++MS0Wi5R76HpsNRghdRk0QoX15IDlNIU1YLItBx5pb/q1DBQDk5gC1R84DxlpSQYzcIwOK32hJOxpLsKp4XIYB78V3GiRBsxUN7NK/NuwBllWq/dv+iHRsXY8av0E3m4FOF9tiNdMPKn2RTwNofQJYmV+bUjB3tmHvbVm9nGEPtVNvMNlL+eqQnjzoZiMgvt5i98t0sXEdSHGgx0QBueM3eZq1bvrxFLQzNUILVQaphEyBBEPj2Pwxb7U39az+47mk7hjIk2QsXm6O39sOUX+z7EjdMYo1LWKKWedoYWxy35OhvV+pCQGNKh2GAMF5Aj0BrnXAzFAtJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d71797-03e3-4bbe-db2e-08df3a4e062f
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:31:29.7684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neZDj6B8oVQ9A9t10lI6i9L2PQe/YGwmYYTs4bx1YmtTx4ECy97ard+X8OGoYDBRPeCD9Q3y34t5JLlKrjsbClRl0556MhY1mxBVYlrCA/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
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

Hi Krzysztof,

On 2026-10-29 at 02:41:51 +0100, Krzysztof Niemiec wrote:
> Port tests that take GT as argument or otherwise depend on a specific GT
> to work to correctly check every GT on system.
> 
> This patch addresses the test suites that only really needed to have the
> test calls wrapped inside for_each_gt with little to no other intervention.
There was no other intervention, was there? You only rearranged
error returns a bit. I think "little to no other intervention"
could just be "no other intervention".

> 
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
> 
> Note that the mock device related tests haven't been touched. This is
> because the mock device is hard-coded to have a single GT, so to_gt()
> will always be correct. At this moment the single GT assumption is
> reasonable to make from the perspective of the test developer, and
> changing those to handle multi-gt mock devices is IMO out of scope and
> should be done if/when mock devices are expanded to have multiple GTs.
> 
> Maybe it's worth it to annotate the places where the single GT
> assumption is made for mock devices?
No, mock devices always have one GT, do not pollute the code
with redundant information.

The code looks OK, but there have been some failures in the
BATs, so I'll refrain from giving r-b just yet.

> 
>  .../drm/i915/gem/selftests/i915_gem_migrate.c | 11 +++++-
>  drivers/gpu/drm/i915/gt/selftest_context.c    | 16 ++++++--
>  drivers/gpu/drm/i915/gt/selftest_engine.c     | 15 +++++---
>  drivers/gpu/drm/i915/gt/selftest_engine_cs.c  | 15 ++++++--
>  .../drm/i915/gt/selftest_engine_heartbeat.c   | 22 +++++++----
>  drivers/gpu/drm/i915/gt/selftest_execlists.c  | 19 +++++++---
>  drivers/gpu/drm/i915/gt/selftest_gt_pm.c      | 15 ++++++--
>  drivers/gpu/drm/i915/gt/selftest_hangcheck.c  | 24 +++++++-----
>  drivers/gpu/drm/i915/gt/selftest_lrc.c        | 11 +++++-
>  drivers/gpu/drm/i915/gt/selftest_migrate.c    | 38 +++++++++++++------
>  drivers/gpu/drm/i915/gt/selftest_mocs.c       | 11 +++++-
>  drivers/gpu/drm/i915/gt/selftest_reset.c      | 20 +++++++---
>  .../drm/i915/gt/selftest_ring_submission.c    | 15 ++++++--
>  drivers/gpu/drm/i915/gt/selftest_timeline.c   | 15 ++++++--
>  .../gpu/drm/i915/gt/selftest_workarounds.c    | 15 ++++++--
>  drivers/gpu/drm/i915/gt/uc/selftest_guc.c     | 20 +++++++---
>  .../drm/i915/gt/uc/selftest_guc_hangcheck.c   | 20 +++++++---
>  .../drm/i915/gt/uc/selftest_guc_multi_lrc.c   | 20 +++++++---
>  .../gpu/drm/i915/selftests/i915_gem_evict.c   | 15 ++++++--
>  drivers/gpu/drm/i915/selftests/intel_uncore.c | 11 +++++-
>  20 files changed, 260 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
> index d8f4a10d71de..3d4ffca8087c 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
> @@ -520,9 +520,18 @@ int i915_gem_migrate_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(igt_lmem_pages_failsafe_migrate),
>  		SUBTEST(igt_lmem_async_migrate),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
>  	if (!HAS_LMEM(i915))
>  		return 0;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +	for_each_gt(gt, i915, id) {
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_context.c b/drivers/gpu/drm/i915/gt/selftest_context.c
> index ab76703f6e8b..ae56b410a320 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_context.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_context.c
> @@ -446,10 +446,18 @@ int intel_context_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_active_context),
>  		SUBTEST(live_remote_context),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
> +
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
>  
> -	return intel_gt_live_subtests(tests, gt);
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine.c b/drivers/gpu/drm/i915/gt/selftest_engine.c
> index 57fea9ea1705..bd96db071859 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine.c
> @@ -12,15 +12,18 @@ int intel_engine_live_selftests(struct drm_i915_private *i915)
>  		live_engine_pm_selftests,
>  		NULL,
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
>  	typeof(*tests) *fn;
> +	unsigned int id;
>  
> -	for (fn = tests; *fn; fn++) {
> -		int err;
> +	for_each_gt(gt, i915, id) {
> +		for (fn = tests; *fn; fn++) {
> +			int err;
>  
> -		err = (*fn)(gt);
> -		if (err)
> -			return err;
> +			err = (*fn)(gt);
> +			if (err)
> +				return err;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> index 5ffa5e30f419..99348395b92b 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> @@ -380,11 +380,20 @@ int intel_engine_cs_perf_selftests(struct drm_i915_private *i915)
>  		SUBTEST(perf_mi_bb_start),
>  		SUBTEST(perf_mi_noop),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
>  
>  static int intel_mmio_bases_check(void *arg)
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> index b893a8fde895..933f30d250c7 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> @@ -266,18 +266,26 @@ int intel_heartbeat_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_heartbeat_off),
>  	};
>  	int saved_hangcheck;
> +	struct intel_gt *gt;
> +	unsigned int id;
>  	int err;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	saved_hangcheck = i915->params.enable_hangcheck;
> -	i915->params.enable_hangcheck = INT_MAX;
> +		saved_hangcheck = i915->params.enable_hangcheck;
> +		i915->params.enable_hangcheck = INT_MAX;
>  
> -	err = intel_gt_live_subtests(tests, to_gt(i915));
> +		err = intel_gt_live_subtests(tests, gt);
>  
> -	i915->params.enable_hangcheck = saved_hangcheck;
> -	return err;
> +		i915->params.enable_hangcheck = saved_hangcheck;
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
>  
>  void st_engine_heartbeat_disable(struct intel_engine_cs *engine)
> diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> index 21e5ed9f72a3..ddf71b3784bf 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
> @@ -4495,12 +4495,21 @@ int intel_execlists_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_virtual_slice),
>  		SUBTEST(live_virtual_reset),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (to_gt(i915)->submission_method != INTEL_SUBMISSION_ELSP)
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (gt->submission_method != INTEL_SUBMISSION_ELSP)
> +			continue;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
> index 07eaf71955c4..09c0c4096665 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_gt_pm.c
> @@ -205,9 +205,18 @@ int intel_gt_pm_late_selftests(struct drm_i915_private *i915)
>  		 */
>  		SUBTEST(live_rc6_ctx_wa),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> index 53f3ce5c33a4..d67a6d75c56a 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> @@ -2016,21 +2016,27 @@ int intel_hangcheck_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(igt_reset_evict_fence),
>  		SUBTEST(igt_handle_error),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
>  	intel_wakeref_t wakeref;
> +	struct intel_gt *gt;
> +	unsigned int id;
>  	int err;
>  
> -	if (!intel_has_gpu_reset(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (!intel_has_gpu_reset(gt))
> +			continue;
>  
> -	if (intel_gt_is_wedged(gt))
> -		return -EIO; /* we're long past hope of a successful reset */
> +		if (intel_gt_is_wedged(gt))
> +			return -EIO; /* we're long past hope of a successful reset */
>  
> -	wakeref = intel_runtime_pm_get(gt->uncore->rpm);
> +		wakeref = intel_runtime_pm_get(gt->uncore->rpm);
>  
> -	err = intel_gt_live_subtests(tests, gt);
> +		err = intel_gt_live_subtests(tests, gt);
>  
> -	intel_runtime_pm_put(gt->uncore->rpm, wakeref);
> +		intel_runtime_pm_put(gt->uncore->rpm, wakeref);
>  
> -	return err;
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
> index 23f04f6f8fba..ac26c91b1e1f 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
> @@ -1986,9 +1986,18 @@ int intel_lrc_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_lrc_indirect_ctx_bb),
>  		SUBTEST(live_lrc_per_ctx_bb),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
>  	if (!HAS_LOGICAL_RING_CONTEXTS(i915))
>  		return 0;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +	for_each_gt(gt, i915, id) {
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
> index 5b986a7687d9..997fd1ec155c 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
> @@ -562,7 +562,7 @@ static int live_emit_pte_full_ring(void *arg)
>  	 * nearly full.
>  	 */
>  
> -	if (igt_spinner_init(&st.spin, to_gt(i915)))
> +	if (igt_spinner_init(&st.spin, gt))
>  		return -ENOMEM;
>  
>  	obj = i915_gem_object_create_internal(i915, 2 * PAGE_SIZE);
> @@ -806,12 +806,20 @@ int intel_migrate_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(thread_global_copy),
>  		SUBTEST(thread_global_clear),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (!gt->migrate.context)
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (!gt->migrate.context)
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, gt);
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
>  
>  static struct drm_i915_gem_object *
> @@ -1027,13 +1035,21 @@ int intel_migrate_perf_selftests(struct drm_i915_private *i915)
>  		SUBTEST(perf_clear_blt),
>  		SUBTEST(perf_copy_blt),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	if (!gt->migrate.context)
> -		return 0;
> +		if (!gt->migrate.context)
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, gt);
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_mocs.c b/drivers/gpu/drm/i915/gt/selftest_mocs.c
> index d73e438fb85f..916ceba580da 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_mocs.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_mocs.c
> @@ -445,9 +445,18 @@ int intel_mocs_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_mocs_reset),
>  	};
>  	struct drm_i915_mocs_table table;
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
>  	if (!get_mocs_settings(i915, &table))
>  		return 0;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +	for_each_gt(gt, i915, id) {
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_reset.c b/drivers/gpu/drm/i915/gt/selftest_reset.c
> index 2cfc23c58e90..43f90b0687d7 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_reset.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_reset.c
> @@ -382,13 +382,21 @@ int intel_reset_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(igt_atomic_reset),
>  		SUBTEST(igt_atomic_engine_reset),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (!intel_has_gpu_reset(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (!intel_has_gpu_reset(gt))
> +			continue;
>  
> -	if (intel_gt_is_wedged(gt))
> -		return -EIO; /* we're long past hope of a successful reset */
> +		if (intel_gt_is_wedged(gt))
> +			return -EIO; /* we're long past hope of a successful reset */
>  
> -	return intel_gt_live_subtests(tests, gt);
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
> index 600333ae6c8c..6ce7be6e7692 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
> @@ -291,9 +291,18 @@ int intel_ring_submission_live_selftests(struct drm_i915_private *i915)
>  	static const struct i915_subtest tests[] = {
>  		SUBTEST(live_ctx_switch_wa),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (to_gt(i915)->submission_method > INTEL_SUBMISSION_RING)
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (gt->submission_method > INTEL_SUBMISSION_RING)
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/drm/i915/gt/selftest_timeline.c
> index 29d860a5c9c8..0aad7bd50926 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
> @@ -1421,9 +1421,18 @@ int intel_timeline_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_hwsp_rollover_kernel),
>  		SUBTEST(live_hwsp_rollover_user),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/selftest_workarounds.c b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
> index 4e4c420ae67f..8f9705b25f70 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_workarounds.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_workarounds.c
> @@ -1374,9 +1374,18 @@ int intel_workarounds_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_gpu_reset_workarounds),
>  		SUBTEST(live_engine_reset_workarounds),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
> +
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
> index 63a75272924f..c8ce82692614 100644
> --- a/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc.c
> @@ -407,13 +407,21 @@ int intel_guc_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(intel_guc_steal_guc_ids),
>  		SUBTEST(intel_guc_fast_request),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	if (!intel_uc_uses_guc_submission(&gt->uc))
> -		return 0;
> +		if (!intel_uc_uses_guc_submission(&gt->uc))
> +			continue;
> +
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
>  
> -	return intel_gt_live_subtests(tests, gt);
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
> index 83801c992488..91a129e73665 100644
> --- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
> +++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c
> @@ -150,13 +150,21 @@ int intel_guc_hang_check(struct drm_i915_private *i915)
>  	static const struct i915_subtest tests[] = {
>  		SUBTEST(intel_hang_guc),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	if (!intel_uc_uses_guc_submission(&gt->uc))
> -		return 0;
> +		if (!intel_uc_uses_guc_submission(&gt->uc))
> +			continue;
> +
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
>  
> -	return intel_gt_live_subtests(tests, gt);
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> index 18077801b2e6..e4652b1b303d 100644
> --- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> @@ -172,13 +172,21 @@ int intel_guc_multi_lrc_live_selftests(struct drm_i915_private *i915)
>  	static const struct i915_subtest tests[] = {
>  		SUBTEST(intel_guc_multi_lrc_basic),
>  	};
> -	struct intel_gt *gt = to_gt(i915);
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(gt))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
>  
> -	if (!intel_uc_uses_guc_submission(&gt->uc))
> -		return 0;
> +		if (!intel_uc_uses_guc_submission(&gt->uc))
> +			continue;
>  
> -	return intel_gt_live_subtests(tests, gt);
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> index 718cddde7e73..fd58faf31fe5 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_evict.c
> @@ -563,9 +563,18 @@ int i915_gem_evict_live_selftests(struct drm_i915_private *i915)
>  	static const struct i915_subtest tests[] = {
>  		SUBTEST(igt_evict_contexts),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	if (intel_gt_is_wedged(to_gt(i915)))
> -		return 0;
> +	for_each_gt(gt, i915, id) {
> +		if (intel_gt_is_wedged(gt))
> +			continue;
> +
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/intel_uncore.c b/drivers/gpu/drm/i915/selftests/intel_uncore.c
> index 514d2200751b..e741dd322537 100644
> --- a/drivers/gpu/drm/i915/selftests/intel_uncore.c
> +++ b/drivers/gpu/drm/i915/selftests/intel_uncore.c
> @@ -288,6 +288,15 @@ int intel_uncore_live_selftests(struct drm_i915_private *i915)
>  		SUBTEST(live_fw_table),
>  		SUBTEST(live_forcewake_ops),
>  	};
> +	struct intel_gt *gt;
> +	unsigned int id;
> +	int err;
>  
> -	return intel_gt_live_subtests(tests, to_gt(i915));
> +	for_each_gt(gt, i915, id) {
> +		err = intel_gt_live_subtests(tests, gt);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
> -- 
> 2.55.0
> 

-- 
Best Regards,
Krzysztof
