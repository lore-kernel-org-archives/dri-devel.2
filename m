Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506F606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CKxVMGfw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=EpzTY9Hd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B594810E17D;
	Mon, 16 Nov 2026 06:24:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AFD10E07D;
 Mon, 16 Nov 2026 06:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794810284; x=1826346284;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aaowbHo0VFUqs/28EG/AaO0riL34L6dA9XdRBPvESQ0=;
 b=CKxVMGfwYLr5DCarGwgSfSGRr3tM6x3yYhPvc8Swk7YzNk4d1721U8+P
 rI8F0GGabbDKRVeOGaTiUUGC6b9cwmIXBEMu4jIIpyjS/yveYWNQqkZVB
 jA+i1buW/bgnDcRJWQJ3OPJ0KMMgb2KuN/Lc3BUSo+Fstr7oin7FZ5Gxd
 ItYkEtfQvoIiR3Lfgs/XBYirBc2iv1gbzESyLoJ+WBR+srvmDSu/ZV/B8
 pr7pmsTZRLlBRp9r4/nhvK/Xwhn/f3jdM6hlxhaBjRZTppHBU1AriF2Qc
 Ms0FkIQdOQ6QjgF56HGu+rzd9VgdNDr0cQCg9jS0+rHBTLEMmExwgXi7a Q==;
X-CSE-ConnectionGUID: n3x2zYjOQ5eZ3jHYWTfxqw==
X-CSE-MsgGUID: DVkwoDheQuq+vhclOpcjew==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3410869"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3410869"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:24:43 -0800
X-CSE-ConnectionGUID: y9wUcWfcRu++iy8EqaiexA==
X-CSE-MsgGUID: negd6t1tR1Oubt2WO5pVYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9818141"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 22:24:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 22:24:42 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 15 Nov 2026 22:24:42 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 22:24:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObehLAhSo5ltXvPrOLfGN/rkzrV//DdJ/NtfYgKLTFpTQKK+LPzqGz6z9yl3Ac3Gyx7PrG9F4ME2d6n1P3JMjWttXPiUBtU3r6f4Ke8qYlfgFE2oU8gQnsG3iCJzZXqUMw277rd3Qoe1VAo3niLaTzJMgwaXcnSkSXnQI0P/JLeJNZDujjF42lhw3RfCTLNNXLW4hRcZsYBLgys4bLXknHG0cVammV9JEgXITa+DbA1FkTezLSEDTRa5wOLtspK3EucGpFxKFNQvskLK7Ard1stfmrR8rRb8sWZYPWaDWvzKoKlYyzYBWdecGozglaTUpomcUy4EnVwjxw5p9YzJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL3ZW4fhLkYAStsKXkve3u+VMshpOkBPNjMxUNsTeGs=;
 b=A3+RdQQaa6pLSFLOVzYvdp4csJAtt9SsOnDvbfQuRvolGXfRJorHpqSE4M4Go+SljHgcyuISAh85B6OzHsHxrUGAZTAcrckEWYoZ7fbTN9LTBG5RGWdFSSIx+L0m9wpjE11meNo6DuVhoR7D48VtRLo+s1ZlckprBC3yE2NkbaXUAfao8+oOc1RogZWZFNsa841DYeas6FeWgHZeI4H7BCmqvZnKc8WIc1aTdRUyGjpGUbyt8D0URf2qF40jwzSmlvqeqclkUQLQgtZ0yyWTWXo7PBs/5I+mbyW8OQcXDnmdBqIb4DU9pua6tS1BmZeCM1B2//NYh3L31gaO1LO9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL3ZW4fhLkYAStsKXkve3u+VMshpOkBPNjMxUNsTeGs=;
 b=EpzTY9Hd3muI02fXk+1jOrBoy5oNQKwMTIBETv3DIqyvBrzo8aRuNPb2moMgxuz+fV7x5Xlog5OBsQAhrpZ6ovnsgQ1oms26Au/umW2waWNTbyUjonuKF/NDw5XL1nWkUGr1xARM9qpiKJ0giYnLdcvYnkKHpvl7YRzJrM2ydjM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 06:24:38 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 06:24:38 +0000
Message-ID: <3d681fa3-e8e4-4da1-95ea-6ad5cc73e63e@intel.com>
Date: Mon, 16 Nov 2026 11:54:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/svm: Take write access only for GC attribute resets
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>, <thomas.hellstrom@linux.intel.com>
References: <20261026122045.2709500-1-arvind.yadav@intel.com>
 <auENFUKFEcjZorM6@gsse-cloud1.jf.intel.com>
 <6b8b81b5-0da8-4f02-acc0-5de6a89ec88f@intel.com>
 <avdm/ajA/I0rwQ5a@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <avdm/ajA/I0rwQ5a@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::11) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7ac71b-9b45-4637-11d1-08df43aa4a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: I3KuhaaaKi+nqdDbvIgaPZAnngp7TE/2Uub/DHjHt3jqUpkIri9dB5F6+K8SNSHuqBxIKonz5ZG+WJl0j1lPk9WSo82TvbOyIFKOTeqwB/wq+6wb+oUXwV1+46fXFxyDcwY3iNX+tSee2R8MMjgwK2OkGhVkVbfQL5BE9PQK2YLyODRhAosFn3+VzE3Jr9TsjqIzOpLuFfexN5vKk05MtSL0P+xXf4ssCeV62JBNmlr7EMxdCwIAoZzt3p4RW/xQgmu7wTy07w3jf6/IOqfddZahNq3hNHkxAb5QfARNd9bcX4OnDGiBYn0XazQwKLgkHinAneT2YHSFMcCARWTaS44VJQBzBxNPDZYhrhJzYmfw0+hKWuZ4BvYAGdLGljIivbsOg3vZ0eDmrYKv5v5xv0GWrIHRa8MSSl5AZfmEvEPWMDFM8hb3nXzaKOaCT+Sbx5wRFF27hZKiMTWCvwRXxNAyN9Q2ZhMTcsPalHtOh3iodk3/c7oRDd0ALYaYcgDhypv55K60++IwOINDVvYIsGqSVIWxTlBscoDlmeM5kogGpmohWi1Qe8JMuyaxOMjoQ+SASb6GC3NNgaWP6LfO3mFkfMCwpDL/UzwFCzSSckjxZYzE6yYWfza7liRZx+mK+hXHohCzFPa9AeOC6+k3yeoTTKlkQFg9mLNuKc2vTUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkl6akdrR1JTY29IbUIxOGRvcW1ENnZnTWRzdTFiTnVSdElrTUk2Mm5meCta?=
 =?utf-8?B?aTBCN3QreDFoTGRKNEtiUzNmRThaOWVtSGR6VzhCdGZLM3liVVFJKzFjSTRp?=
 =?utf-8?B?S09TMityME9IRWpnREdNQzN3MTNhQnlmQlVqSHlpVmZ3VlFVckxpNDB3V21q?=
 =?utf-8?B?Ui9yVEVuc1h5VW9lTHRlUjFoZUJMSVZEMkZaU3h5dlR3ckdHZno3WUpXeDNW?=
 =?utf-8?B?RHlCNzdGdnhFcFpIeUkyS3JDb2YyQm5rNm5qUGJHQmQvcm5KVkw5RHVHV0VQ?=
 =?utf-8?B?MXM1MGpEWmZhK2EvQ3A3K0pZYVNtTFYwREhoZXVkTVdUU3R5MmVoTkJwZE0r?=
 =?utf-8?B?a0tCN1lZREZwZFNTcG1INnNaWFBUY1ZVMm1ucTlhaGhrd29VYWNPSnZibGhr?=
 =?utf-8?B?OHNaYW0wV2VDUnNRc0ZiRGtHbWxPRCtIeXhhVDJHNVVjYTh6bEtVS3F3ajBk?=
 =?utf-8?B?cHU3WXdPU2lHdXVOMVBRQms0YitmYVVSdE1rRVQ2UTVxRUM2MEwwQWpyM3Vv?=
 =?utf-8?B?dWpyVUF4VFQ0RmVlTGVRRTJScm8xcWN4d1dLd3I5TTJUUm9JTUdiZDFoaldK?=
 =?utf-8?B?WXRRSjU3LzF1bmZTcWl1QVh2WXFGWnF5ZURBaGI2emlndnhJcXJnSVIvdS9V?=
 =?utf-8?B?MFhWd1VTUTJTcUVmUnhBdDZqY256MFBMc2xEL1k5NUFkT1FvUHAzRlU2OHIy?=
 =?utf-8?B?NmVYcXZvZEQ0RkZ5MzN3RXZ4TWhES2I1anRPSkFzaUxwRXowQWJWUE4wY3ov?=
 =?utf-8?B?VGo2M3NUOTdXSWV0Uk1xTFVKMk5FY01jbk0wSDFxM04vYnA2MHYvaTQ4VWVL?=
 =?utf-8?B?ZzBXOWtZOU44MGk3RkdTN0U4VUdVeG5na1ZQbGRpV2ZKOXBlanFxeDByT24v?=
 =?utf-8?B?UXlpY0xXM1NERnZ1cjBPeFQvQ3g2c1lUYnZScENUaVJVNURlQTJNZFExaDJS?=
 =?utf-8?B?RUFPamhZb2F3NCtsRTVhVUEvSkhxUWU4MGxsOG9vQVh2OGQyM1A0RFo1Q0Y4?=
 =?utf-8?B?UHFTR21YVFc2R2VuM2J0V3FhQVl0NWdnb0xrQnBVOXJ2SlRVTFVPUE5OR1Vp?=
 =?utf-8?B?OUJPSDlzdzdVS0VFZTgrYUR6bDZucWpKTzk4ZDAvRlVhTWNBQUp5dExvQzlw?=
 =?utf-8?B?d3hHR01ZRXdJZUVnOFlFV1BBVE1wNEJVOExrVlJscUs0b1V0ek40ZXcxZVls?=
 =?utf-8?B?a1d3T0daS2FDQkhLQVdhcVlVK0xoTFNkODVGMTRqQkY3Lzd6NHJ5QWIxUlZ3?=
 =?utf-8?B?b2p1V1o1UFhUQU0rMURibFhYbXVSQitDeEdNUCtMalBUTEN0ZFlLTkFybDBr?=
 =?utf-8?B?MkFpT3VNdzJjY0FCQmI1RVdLdVh6c1ZKQUNYbkJNUzNyS2VTVEJFaHJvck51?=
 =?utf-8?B?dmNWSE8yVHNrSlJualdrUmpMMXRUd1JXZ1pZeUlOejhsREdXVnBadU9TTXAr?=
 =?utf-8?B?QzlVMEdpNWxDRWNlcmE1eVJZd1IxMUZRYUFPVFByMkRxQ0RTNEorckFLTGFI?=
 =?utf-8?B?MEFEdGdudzdPcTdqcXNHSVh6dDd5NWFyTjVOc08yQmwzUHhxWjd5U2tvR0h3?=
 =?utf-8?B?WlJ2b0pvc1BKTm5vekdMWHFUSWlYcTZMSTVWd2VTV3k0YjI4TkZpSWNwUGF5?=
 =?utf-8?B?SEZDUTRjWEE5YnR3Znp2MnFzVU42T1U5Z1pnYlpWOTdISHlUR2tQL1FDVXUv?=
 =?utf-8?B?c1NtVTlhQ0gxdUlVdGVhTndJTnpSdEU1MkJZSStrcW5jZGlmWFVKaklXVjFu?=
 =?utf-8?B?RUdRbS82UDBhYW9xVlZBd0VEVndTNHNCT0l6SGZXdjYvOXh5a1krd2MrckJq?=
 =?utf-8?B?RTFSR0lKYys0MTZwcGptTktCTVk3SXNRT0psYzNwTHhPR2FnZmZIWXA3ODJF?=
 =?utf-8?B?TnlRb2NpdzlyOHd1YzQrejZ4UHorbGZwTzVpMFBJcEpybTViajJ4K2JabnNw?=
 =?utf-8?B?Q1ovQ0lmLzdvRU5mZEdwRkFpYUJOQm1jeHFnejNtQVFPZWg0TVRJUDRFWEto?=
 =?utf-8?B?OUZEcDdtditmLzJGMXl6NlNURG5seXN1MFducnE1NjRMdkNQbXhiY3FUMEcy?=
 =?utf-8?B?NEZvbVRDTWw4S3J4Wk1ZVEw4Q3U1R21hTGtudTFXMUFLRDIxTGRzVVZ6anl0?=
 =?utf-8?B?RXFKNUNtQ1o3ZXJyOXZoMU1kQXRmaWNmKzhMMTU4THc5em10cFk3Z1EzMXEv?=
 =?utf-8?B?QUgwNnJhUittM2lxUG5XSUVRc3FoSmRwTWhZdzE1aTZBU0lSWjFNMGxZUmdO?=
 =?utf-8?B?QmlHbmJUQXJ1TnZLVjVXRTIxMDVFR2dsYms0bVRUM0dQMjBGQlBIL282L1ln?=
 =?utf-8?B?THBFY0FjcHJsd0IxWS9wTmx3RzI3OWdEaFhjQmRzNkxySXlVNHg0Zz09?=
X-Exchange-RoutingPolicyChecked: SmH7NNzPvzfMSM64rX0hfX8kuO2mfOZcJJItVUlXeyVWH24u2E+bnB5lMyCLjkrR2+ildcqfXRejzGZW0NB5BwYXxdWBb4rpSZaIiezuPgaLLB3ulNp2QFJuS1FM8nH/O/61Q083Z0aYQEsKJKpC9oHXdX8Xb46dftfPkEZusgj3LP8qix+MvoRtDuGFmCLVjyVGEvA7rYHlEi0dor2CCvxloT1QSHrZ8EiFID1yfCyzvsZIcixzoi34y0HnXfuv4Zm/GoaWbBR3MNuz5C63+6HBc7pZrHSymoq/aS3BbfWpWBu6noWUQaxHGMNhvRXeSBrZgCj9a9NTHB/ExVMqUA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7ac71b-9b45-4637-11d1-08df43aa4a93
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:24:38.7778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZASmhVfGbzCAeBn7g7yDxCKMRmyPCIrTOSA6yXaktg+s3RdhXAOCUrkixnjYW0ecaE5+5/b9mO2F+xzg/hiepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 14-11-2026 01:07, Matthew Brost wrote:
> On Thu, Oct 29, 2026 at 09:20:33AM +0530, Yadav, Arvind wrote:
>> On 28-10-2026 02:14, Matthew Brost wrote:
>>> On Mon, Oct 26, 2026 at 05:50:45PM +0530, Arvind Yadav wrote:
>>>> Fault service holds vm->lock for read while using a VMA. SVM garbage
>>>> collection also runs under the read lock and can reset AUTORESET
>>>> attributes. The reset can split or merge VMAs and immediately free a
>>>> VMA that another fault worker is still using. The GC mutex serializes
>>> I'll have to think about this one for a bit but quick thought:
>>>
>>> Can we use some ref counting (e.g., add a VMA ref count) rather than
>>> changing the locking?
>>
>> A VMA ref count would keep it alive while the fault worker uses it. But the
>> reset also changes "vma->attr" which the fault worker reads. The ref count
>> would not protect those updates.
>>
> Can't this race only happen if say a fault starts (A), an unmap occurs
> on A's fault, and different fault starts (B) and see A's unmap and blows
> away A's VMA? This is memory unsafe as A can currently UAF but ref
> counting could make this memory safe.
>
> Now to the attribute race - wouldn't A fail somewhere on a notifier
> retry if its attributes actually change? I guess we don't always lookup
> on a retry but we could.


Thanks for your suggestion.
Yes,  A VMA reference will prevent the UAF, and we can look up the VMA 
again and rebuild the fault context when notifier validation or the 
removed-range check causes a retry.
I will try this approach.

Thanks,
Arvind

>
> Matt
>
>> I will check if we can avoid changing the attributes in place and retry the
>> fault when the VMA is replaced, keeping the current locking. If You have any
>> other suggestion please let me know.
>>
>> Thanks,
>> Arvind
>>
>>> Matt
>>>
>>>> collectors but does not protect VMA readers.
>>>>
>>>> Keep backing collection under read access when no attribute change is
>>>> needed. Defer ranges requiring a reset and return -EAGAIN so the caller
>>>> can release its read-side state and collect with write access.
>>>>
>>>> In fault service, discard the old VMA pointer before releasing the read
>>>> lock. After acquiring write access, recheck VM state and collect the
>>>> queued ranges. Downgrade to read and repeat VMA lookup, permission checks
>>>> and advice-dependent setup.
>>>>
>>>> Drain GC under the existing write lock before madvise, bind and attribute
>>>> query. Require write access for VMA changes while retaining parallel
>>>> fault service when no reset is needed.
>>>>
>>>> [ 2163.042338] ==================================================================
>>>> [ 2163.042353] BUG: KASAN: slab-use-after-free in __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>>>> [ 2163.042815] Read of size 8 at addr ffff88813f879b70 by task kworker/u65:3/3115
>>>>
>>>> [ 2163.042834] CPU: 0 UID: 0 PID: 3115 Comm: kworker/u65:3 Kdump: loaded Tainted: G S      W  O        7.3.0-lgci-xe-svm-22oct #16 PREEMPT(full)
>>>> [ 2163.042841] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE
>>>> [ 2163.042842] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 1002 03/31/2023
>>>> [ 2163.042845] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
>>>> [ 2163.043326] Call Trace:
>>>> [ 2163.043327]  <TASK>
>>>> [ 2163.043330]  dump_stack_lvl+0x91/0xf0
>>>> [ 2163.043336]  print_report+0xd1/0x610
>>>> [ 2163.043340]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>>>> [ 2163.043825]  ? __virt_addr_valid+0x1b2/0x350
>>>> [ 2163.043831]  ? kasan_complete_mode_report_info+0x6a/0x210
>>>> [ 2163.043836]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>>>> [ 2163.044340]  kasan_report+0xa3/0xe0
>>>> [ 2163.044344]  ? __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>>>> [ 2163.044881]  __asan_load8+0x8b/0xe0
>>>> [ 2163.044885]  __xe_svm_handle_pagefault+0x297/0x1460 [xe]
>>>> [ 2163.045456]  ? lock_acquire+0x1b0/0x320
>>>> [ 2163.045461]  ? xe_vm_find_overlapping_vma+0x88/0x310 [xe]
>>>> [ 2163.046072]  ? __pfx___xe_svm_handle_pagefault+0x10/0x10 [xe]
>>>> [ 2163.046679]  ? rcu_is_watching+0x21/0x60
>>>> [ 2163.046684]  ? __mutex_lock+0x1172/0x18b0
>>>> [ 2163.046690]  ? find_held_lock+0x31/0x90
>>>> [ 2163.046696]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
>>>> [ 2163.047273]  ? __kasan_check_write+0x14/0x30
>>>> [ 2163.047278]  ? __mutex_unlock_slowpath+0x10f/0x660
>>>> [ 2163.047285]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
>>>> [ 2163.047295]  ? mutex_unlock+0x12/0x20
>>>> [ 2163.047299]  ? xe_vm_find_overlapping_vma+0xa1/0x310 [xe]
>>>> [ 2163.047844]  xe_svm_handle_pagefault+0x5c/0x140 [xe]
>>>> [ 2163.048355]  xe_pagefault_queue_work+0x19ad/0x2450 [xe]
>>>> [ 2163.048843]  process_one_work+0x5ae/0xdd0
>>>> [ 2163.048847]  ? __lock_acquire+0x58a/0x2820
>>>> [ 2163.048850]  ? __schedule+0x22a6/0x3670
>>>> [ 2163.048858]  ? __pfx_process_one_work+0x10/0x10
>>>> [ 2163.048866]  ? __pfx_xe_pagefault_queue_work+0x10/0x10 [xe]
>>>> [ 2163.049345]  ? assign_work+0xe4/0x1d0
>>>> [ 2163.049350]  worker_thread+0x3b4/0x6a0
>>>> [ 2163.049357]  ? __pfx_worker_thread+0x10/0x10
>>>> [ 2163.049361]  kthread+0x204/0x250
>>>> [ 2163.049364]  ? kthread+0xf1/0x250
>>>> [ 2163.049369]  ? __pfx_kthread+0x10/0x10
>>>> [ 2163.049372]  ret_from_fork+0x465/0x6a0
>>>> [ 2163.049377]  ? __pfx_ret_from_fork+0x10/0x10
>>>> [ 2163.049381]  ? __switch_to+0x26f/0x740
>>>> [ 2163.049386]  ? __pfx_kthread+0x10/0x10
>>>> [ 2163.049390]  ret_from_fork_asm+0x1a/0x30
>>>> [ 2163.049399]  </TASK>
>>>>
>>>> [ 2163.049654] Allocated by task 522570:
>>>> [ 2163.049662]  kasan_save_stack+0x26/0x60
>>>> [ 2163.049668]  kasan_save_track+0x14/0x40
>>>> [ 2163.049672]  kasan_save_alloc_info+0x37/0x60
>>>> [ 2163.049677]  __kasan_kmalloc+0xc3/0xd0
>>>> [ 2163.049681]  __kmalloc_cache_noprof+0x2b4/0x6c0
>>>> [ 2163.049686]  xe_vma_create+0xe3/0xe60 [xe]
>>>> [ 2163.050170]  new_vma+0x416/0x540 [xe]
>>>> [ 2163.050654]  vm_bind_ioctl_ops_parse+0xc3e/0x1110 [xe]
>>>> [ 2163.051139]  xe_vm_alloc_vma+0x243/0xd60 [xe]
>>>> [ 2163.051623]  xe_vm_alloc_madvise_vma+0x92/0xd0 [xe]
>>>> [ 2163.052107]  xe_vm_madvise_ioctl+0x783/0x14f0 [xe]
>>>> [ 2163.052591]  drm_ioctl_kernel+0x143/0x200
>>>> [ 2163.052597]  drm_ioctl+0x419/0x790
>>>> [ 2163.052600]  xe_drm_ioctl+0x9e/0xf0 [xe]
>>>> [ 2163.053074]  __x64_sys_ioctl+0xd5/0x130
>>>> [ 2163.053079]  x64_sys_call+0x2b5/0x27e0
>>>> [ 2163.053084]  do_syscall_64+0xef/0x6c0
>>>> [ 2163.053088]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>
>>>> [ 2163.053098] Freed by task 17929:
>>>> [ 2163.053105]  kasan_save_stack+0x26/0x60
>>>> [ 2163.053110]  kasan_save_track+0x14/0x40
>>>> [ 2163.053114]  kasan_save_free_info+0x3b/0x60
>>>> [ 2163.053118]  __kasan_slab_free+0x6f/0xa0
>>>> [ 2163.053123]  kfree+0x2bb/0x600
>>>> [ 2163.053127]  xe_vma_free+0x5a/0x70 [xe]
>>>> [ 2163.053610]  xe_vma_destroy_late+0xae/0xf0 [xe]
>>>> [ 2163.054093]  xe_vma_destroy+0xda/0xf20 [xe]
>>>> [ 2163.054576]  xe_vm_alloc_vma+0x304/0xd60 [xe]
>>>> [ 2163.055059]  xe_vm_alloc_cpu_addr_mirror_vma+0x8f/0xd0 [xe]
>>>> [ 2163.055543]  xe_svm_garbage_collector+0x388/0x5d0 [xe]
>>>> [ 2163.056028]  xe_svm_garbage_collector_work_func+0x2a/0x40 [xe]
>>>> [ 2163.056512]  process_one_work+0x5ae/0xdd0
>>>> [ 2163.056517]  worker_thread+0x3b4/0x6a0
>>>> [ 2163.056521]  kthread+0x204/0x250
>>>> [ 2163.056525]  ret_from_fork+0x465/0x6a0
>>>> [ 2163.056530]  ret_from_fork_asm+0x1a/0x30
>>>>
>>>> Fixes: 941bcc1a4bbf ("drm/xe: Fine grained page fault locking")
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>>>> Assisted-by: LLM
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
>>>> ---
>>>>    drivers/gpu/drm/xe/xe_pagefault.c  |  37 +++++-
>>>>    drivers/gpu/drm/xe/xe_svm.c        | 179 ++++++++++++++++++++++-------
>>>>    drivers/gpu/drm/xe/xe_svm.h        |   8 ++
>>>>    drivers/gpu/drm/xe/xe_vm.c         |  54 +++++----
>>>>    drivers/gpu/drm/xe/xe_vm_madvise.c |   5 +
>>>>    5 files changed, 212 insertions(+), 71 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
>>>> index 5247321c805e..9e1377df9d01 100644
>>>> --- a/drivers/gpu/drm/xe/xe_pagefault.c
>>>> +++ b/drivers/gpu/drm/xe/xe_pagefault.c
>>>> @@ -270,8 +270,9 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>>>>    	struct xe_device *xe = gt_to_xe(gt);
>>>>    	struct xe_vm *vm;
>>>>    	struct xe_vma *vma = NULL;
>>>> +	enum xe_pagefault_error error;
>>>>    	int err;
>>>> -	bool atomic;
>>>> +	bool atomic, svm_relookup = false;
>>>>    	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
>>>>    	/* Producer flagged this fault to be nacked */
>>>> @@ -297,10 +298,13 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>>>>    		goto unlock_vm;
>>>>    	}
>>>> +lookup_vma:
>>>>    	vma = xe_vm_find_vma_by_addr(vm, xe_pagefault_addr(pf));
>>>>    	if (!vma) {
>>>>    		err = -EINVAL;
>>>> -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
>>>> +		xe_pagefault_set_error(pf, svm_relookup ?
>>>> +				       XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND :
>>>> +				       XE_PAGEFAULT_ERROR_VMA_NOT_FOUND);
>>>>    		goto unlock_vm;
>>>>    	}
>>>> @@ -313,11 +317,36 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
>>>>    	atomic = xe_pagefault_access_is_atomic(pf->consumer.access_type);
>>>> -	if (xe_vma_is_cpu_addr_mirror(vma))
>>>> +	if (xe_vma_is_cpu_addr_mirror(vma)) {
>>>>    		err = xe_svm_handle_pagefault(vm, vma, pf, gt,
>>>>    					      xe_pagefault_addr(pf), atomic);
>>>> -	else
>>>> +		if (err == -EAGAIN) {
>>>> +			/* GC needs to change VMAs. Drop all read-side state. */
>>>> +			vma = NULL;
>>>> +			up_read(&vm->lock);
>>>> +			down_write(&vm->lock);
>>>> +
>>>> +			if (xe_vm_is_closed(vm)) {
>>>> +				err = -ENOENT;
>>>> +				error = XE_PAGEFAULT_ERROR_VM_CLOSED;
>>>> +			} else {
>>>> +				err = xe_svm_garbage_collect(vm);
>>>> +				error = XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR;
>>>> +			}
>>>> +
>>>> +			downgrade_write(&vm->lock);
>>>> +			if (err) {
>>>> +				xe_pagefault_set_error(pf, error);
>>>> +				goto unlock_vm;
>>>> +			}
>>>> +
>>>> +			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
>>>> +			svm_relookup = true;
>>>> +			goto lookup_vma;
>>>> +		}
>>>> +	} else {
>>>>    		err = xe_pagefault_handle_vma(gt, vma, pf, atomic);
>>>> +	}
>>>>    unlock_vm:
>>>>    	if (err)
>>>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>>>> index bc6902b5bf57..d19cb0c4b154 100644
>>>> --- a/drivers/gpu/drm/xe/xe_svm.c
>>>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>>>> @@ -356,12 +356,36 @@ static void xe_vma_set_default_attributes(struct xe_vma *vma)
>>>>    	xe_vma_mem_attr_copy(&vma->attr, &default_attr);
>>>>    }
>>>> +/* vm->lock keeps the VMA and its attributes stable during this check. */
>>>> +static bool xe_svm_range_needs_attr_reset(struct xe_vm *vm, u64 start)
>>>> +{
>>>> +	struct xe_vma *vma;
>>>> +	u64 end;
>>>> +
>>>> +	lockdep_assert_held(&vm->lock);
>>>> +
>>>> +	vma = xe_vm_find_vma_by_addr(vm, start);
>>>> +	if (!vma || !(vma->gpuva.flags & XE_VMA_MADV_AUTORESET))
>>>> +		return false;
>>>> +
>>>> +	if (!xe_vma_has_default_mem_attrs(vma))
>>>> +		return true;
>>>> +
>>>> +	start = xe_vma_start(vma);
>>>> +	end = xe_vma_end(vma);
>>>> +	xe_vm_find_cpu_addr_mirror_vma_range(vm, &start, &end);
>>>> +
>>>> +	return start != xe_vma_start(vma) || end != xe_vma_end(vma);
>>>> +}
>>>> +
>>>>    static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
>>>>    {
>>>>    	struct xe_vma *vma;
>>>>    	bool has_default_attr;
>>>>    	int err;
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>> +
>>>>    	vma = xe_vm_find_vma_by_addr(vm, start);
>>>>    	if (!vma)
>>>>    		return -EINVAL;
>>>> @@ -397,70 +421,134 @@ static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
>>>>    		return err;
>>>>    	}
>>>> -	/*
>>>> -	 * On call from xe_svm_handle_pagefault original VMA might be changed
>>>> -	 * signal this to lookup for VMA again.
>>>> -	 */
>>>> -	return -EAGAIN;
>>>> +	return 0;
>>>>    }
>>>> -static int xe_svm_garbage_collector(struct xe_vm *vm)
>>>> +/*
>>>> + * With reset_attrs false, defer ranges requiring a VMA change and return
>>>> + * -EAGAIN after collecting the remaining ready ranges in the batch. The
>>>> + * caller must release all read-side state before collecting them with
>>>> + * vm->lock held for write.
>>>> + */
>>>> +static int xe_svm_garbage_collector(struct xe_vm *vm, bool reset_attrs)
>>>>    {
>>>>    	struct xe_svm_range *range;
>>>> -	u64 range_start;
>>>> -	u64 range_end;
>>>> -	int err, ret = 0;
>>>> +	LIST_HEAD(pending);
>>>> +	LIST_HEAD(deferred);
>>>> +	u64 range_start, range_end;
>>>> +	bool needs_reset;
>>>> +	int err = 0, ret = 0;
>>>>    	lockdep_assert_held(&vm->lock);
>>>> +	if (reset_attrs)
>>>> +		lockdep_assert_held_write(&vm->lock);
>>>>    	if (xe_vm_is_closed_or_banned(vm))
>>>>    		return -ENOENT;
>>>>    	guard(mutex)(&vm->svm.garbage_collector.lock);
>>>> +	/* Process a finite batch, excluding events queued during this pass. */
>>>> +	spin_lock(&vm->svm.garbage_collector.list_lock);
>>>> +	if (list_empty(&vm->svm.garbage_collector.range_list)) {
>>>> +		spin_unlock(&vm->svm.garbage_collector.list_lock);
>>>> +		return 0;
>>>> +	}
>>>> +	list_splice_init(&vm->svm.garbage_collector.range_list, &pending);
>>>> +	spin_unlock(&vm->svm.garbage_collector.list_lock);
>>>> +
>>>>    	for (;;) {
>>>>    		spin_lock(&vm->svm.garbage_collector.list_lock);
>>>> -		range = list_first_entry_or_null(&vm->svm.garbage_collector.range_list,
>>>> -						 typeof(*range),
>>>> +		range = list_first_entry_or_null(&pending, typeof(*range),
>>>>    						 garbage_collector_link);
>>>> -		if (!range)
>>>> +		if (!range) {
>>>> +			spin_unlock(&vm->svm.garbage_collector.list_lock);
>>>>    			break;
>>>> +		}
>>>>    		range_start = xe_svm_range_start(range);
>>>>    		range_end = xe_svm_range_end(range);
>>>> -
>>>>    		list_del(&range->garbage_collector_link);
>>>>    		spin_unlock(&vm->svm.garbage_collector.list_lock);
>>>> +		/*
>>>> +		 * Keep the backing range alive until its attributes can be
>>>> +		 * reset. The GC mutex excludes other collectors and explicit
>>>> +		 * range removal requires vm->lock for write.
>>>> +		 */
>>>> +		needs_reset = xe_svm_range_needs_attr_reset(vm, range_start);
>>>> +		if (needs_reset && !reset_attrs) {
>>>> +			spin_lock(&vm->svm.garbage_collector.list_lock);
>>>> +			list_add_tail(&range->garbage_collector_link, &deferred);
>>>> +			spin_unlock(&vm->svm.garbage_collector.list_lock);
>>>> +			ret = -EAGAIN;
>>>> +			continue;
>>>> +		}
>>>> +
>>>>    		err = __xe_svm_garbage_collector(vm, range);
>>>>    		if (err) {
>>>>    			drm_warn(&vm->xe->drm,
>>>>    				 "Garbage collection failed: %pe\n",
>>>>    				 ERR_PTR(err));
>>>> +			/* Leave the failed range in the tree for VM teardown. */
>>>>    			xe_vm_kill(vm, true);
>>>> -			return err;
>>>> +			goto out;
>>>>    		}
>>>> -		err = xe_svm_range_set_default_attr(vm, range_start, range_end);
>>>> -		if (err) {
>>>> -			if (err == -EAGAIN)
>>>> -				ret = -EAGAIN;
>>>> -			else
>>>> -				return err;
>>>> +		if (needs_reset) {
>>>> +			err = xe_svm_range_set_default_attr(vm, range_start, range_end);
>>>> +			if (err)
>>>> +				goto out;
>>>>    		}
>>>>    	}
>>>> +
>>>> +out:
>>>> +	/* Restore ranges not yet processed, including deferred resets. */
>>>> +	spin_lock(&vm->svm.garbage_collector.list_lock);
>>>> +	list_splice_tail_init(&pending, &vm->svm.garbage_collector.range_list);
>>>> +	list_splice_tail_init(&deferred, &vm->svm.garbage_collector.range_list);
>>>>    	spin_unlock(&vm->svm.garbage_collector.list_lock);
>>>> -	return ret;
>>>> +	return err ?: ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xe_svm_garbage_collect() - Collect SVM ranges and reset their attributes
>>>> + * @vm: The VM, with vm->lock held for write.
>>>> + *
>>>> + * Process one batch of queued ranges, including attribute resets. Ranges
>>>> + * queued during this pass are left for a later collection.
>>>> + *
>>>> + * Call before changing advice or bindings, or querying attributes, so the
>>>> + * batch is reset before applying new advice or reporting attributes.
>>>> + * No VMA pointer may be retained across this call.
>>>> + *
>>>> + * Return: 0 on success, negative error code on error.
>>>> + */
>>>> +int xe_svm_garbage_collect(struct xe_vm *vm)
>>>> +{
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>> +
>>>> +	if (!xe_vm_in_fault_mode(vm))
>>>> +		return 0;
>>>> +
>>>> +	return xe_svm_garbage_collector(vm, true);
>>>>    }
>>>>    static void xe_svm_garbage_collector_work_func(struct work_struct *w)
>>>>    {
>>>>    	struct xe_vm *vm = container_of(w, struct xe_vm,
>>>>    					svm.garbage_collector.work);
>>>> +	int err = 0;
>>>> -	guard(rwsem_read)(&vm->lock);
>>>> -	xe_svm_garbage_collector(vm);
>>>> +	scoped_guard(rwsem_read, &vm->lock)
>>>> +		err = xe_svm_garbage_collector(vm, false);
>>>> +
>>>> +	if (err != -EAGAIN)
>>>> +		return;
>>>> +
>>>> +	guard(rwsem_write)(&vm->lock);
>>>> +	xe_svm_garbage_collect(vm);
>>>>    }
>>>>    #if IS_ENABLED(CONFIG_DRM_XE_PAGEMAP)
>>>> @@ -1302,13 +1390,15 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>>>    	if (range) {
>>>>    		mutex_unlock(&range->lock);
>>>>    		drm_gpusvm_range_put(&range->base);
>>>> -	}
>>>> -	/* Always process UNMAPs first so view SVM ranges is current */
>>>> -	err = xe_svm_garbage_collector(vm);
>>>> -	if (err) {
>>>> -		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
>>>> -		return err;
>>>> +		/* The caller collected before the initial service attempt. */
>>>> +		err = xe_svm_garbage_collector(vm, false);
>>>> +		if (err) {
>>>> +			if (err != -EAGAIN)
>>>> +				xe_pagefault_set_error(pf,
>>>> +						      XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
>>>> +			return err;
>>>> +		}
>>>>    	}
>>>>    	dpagemap = ctx.devmem_only ? xe_tile_local_pagemap(tile) :
>>>> @@ -1468,14 +1558,28 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>>>     * Create GPU bindings for a SVM page fault. Optionally migrate to device
>>>>     * memory.
>>>>     *
>>>> - * Return: 0 on success, negative error code on error.
>>>> + * The caller must hold vm->lock for read. On -EAGAIN, discard @vma before
>>>> + * releasing that lock. Collect with write access, then repeat VMA lookup
>>>> + * and permission checks before retrying.
>>>> + *
>>>> + * Return: 0 on success, -EAGAIN if the caller must collect with write
>>>> + * access and repeat VMA lookup, or another negative error code on error.
>>>>     */
>>>>    int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>>>    			    struct xe_pagefault *pf, struct xe_gt *gt,
>>>>    			    u64 fault_addr, bool atomic)
>>>>    {
>>>>    	int need_vram, ret;
>>>> -retry:
>>>> +
>>>> +	/* Consume older UNMAPs before reading advice or building the context. */
>>>> +	ret = xe_svm_garbage_collector(vm, false);
>>>> +	if (ret) {
>>>> +		if (ret != -EAGAIN)
>>>> +			xe_pagefault_set_error(pf,
>>>> +					       XE_PAGEFAULT_ERROR_SVM_GARBAGE_COLLECTOR);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>    	need_vram = xe_vma_need_vram_for_atomic(vm->xe, vma, atomic);
>>>>    	if (need_vram < 0) {
>>>>    		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_NEEDS_VRAM_CHECK);
>>>> @@ -1485,18 +1589,9 @@ int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>>>    	ret =  __xe_svm_handle_pagefault(vm, vma, pf, gt, fault_addr,
>>>>    					 need_vram ? true : false);
>>>>    	if (ret == -EAGAIN) {
>>>> -		/*
>>>> -		 * Retry once on -EAGAIN to re-lookup the VMA, as the original VMA
>>>> -		 * may have been split by xe_svm_range_set_default_attr.
>>>> -		 */
>>>> -		vma = xe_vm_find_vma_by_addr(vm, fault_addr);
>>>> -		if (!vma) {
>>>> -			xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_VMA_NOT_FOUND);
>>>> -			return -EINVAL;
>>>> -		}
>>>> -
>>>> +		/* Retry from the caller after collecting with write access. */
>>>>    		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_NONE);
>>>> -		goto retry;
>>>> +		return ret;
>>>>    	}
>>>>    	if (ret && xe_pagefault_get_error(pf) == XE_PAGEFAULT_ERROR_NONE)
>>>>    		xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_SVM_SERVICE_FAILED);
>>>> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
>>>> index ffc1cc808102..523213a8cd26 100644
>>>> --- a/drivers/gpu/drm/xe/xe_svm.h
>>>> +++ b/drivers/gpu/drm/xe/xe_svm.h
>>>> @@ -109,6 +109,8 @@ void xe_svm_fini(struct xe_vm *vm);
>>>>    void xe_svm_close(struct xe_vm *vm);
>>>> +int xe_svm_garbage_collect(struct xe_vm *vm);
>>>> +
>>>>    int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>>>    			    struct xe_pagefault *pf, struct xe_gt *gt,
>>>>    			    u64 fault_addr, bool atomic);
>>>> @@ -316,6 +318,12 @@ void xe_svm_close(struct xe_vm *vm)
>>>>    {
>>>>    }
>>>> +static inline
>>>> +int xe_svm_garbage_collect(struct xe_vm *vm)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static inline
>>>>    int xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>>>    			    struct xe_pagefault *pf, struct xe_gt *gt,
>>>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>>>> index d12365b11186..6afe6f1be1d4 100644
>>>> --- a/drivers/gpu/drm/xe/xe_vm.c
>>>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>>>> @@ -1308,19 +1308,12 @@ static void vma_destroy_cb(struct dma_fence *fence,
>>>>    	xe_destroy_wq_queue(&vma->destroy_work);
>>>>    }
>>>> -static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
>>>> -{
>>>> -	lockdep_assert(lockdep_is_held_type(&vm->lock, 0) ||
>>>> -		       (lockdep_is_held_type(&vm->lock, 1) &&
>>>> -			lockdep_is_held_type(&vm->svm.garbage_collector.lock, 0)));
>>>> -}
>>>> -
>>>>    static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
>>>>    {
>>>>    	struct xe_vm *vm = xe_vma_vm(vma);
>>>>    	struct xe_bo *bo = xe_vma_bo(vma);
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	xe_assert(vm->xe, list_empty(&vma->combined_links.destroy));
>>>>    	if (xe_vma_is_userptr(vma)) {
>>>> @@ -1416,7 +1409,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
>>>>    	int err;
>>>>    	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	mutex_lock(&vm->snap_mutex);
>>>>    	err = drm_gpuva_insert(&vm->gpuvm, &vma->gpuva);
>>>> @@ -1429,7 +1422,7 @@ static int xe_vm_insert_vma(struct xe_vm *vm, struct xe_vma *vma)
>>>>    static void xe_vm_remove_vma(struct xe_vm *vm, struct xe_vma *vma)
>>>>    {
>>>>    	xe_assert(vm->xe, xe_vma_vm(vma) == vm);
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	mutex_lock(&vm->snap_mutex);
>>>>    	drm_gpuva_remove(&vma->gpuva);
>>>> @@ -2267,7 +2260,7 @@ static int xe_vm_query_vmas(struct xe_vm *vm, u64 start, u64 end)
>>>>    	struct drm_gpuva *gpuva;
>>>>    	u32 num_vmas = 0;
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held(&vm->lock);
>>>>    	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end)
>>>>    		num_vmas++;
>>>> @@ -2280,7 +2273,7 @@ static int get_mem_attrs(struct xe_vm *vm, u32 *num_vmas, u64 start,
>>>>    	struct drm_gpuva *gpuva;
>>>>    	int i = 0;
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held(&vm->lock);
>>>>    	drm_gpuvm_for_each_va_range(gpuva, &vm->gpuvm, start, end) {
>>>>    		struct xe_vma *vma = gpuva_to_vma(gpuva);
>>>> @@ -2330,6 +2323,12 @@ int xe_vm_query_vmas_attrs_ioctl(struct drm_device *dev, void *data, struct drm_
>>>>    	if (err)
>>>>    		goto put_vm;
>>>> +	if (!xe_vm_is_closed_or_banned(vm)) {
>>>> +		err = xe_svm_garbage_collect(vm);
>>>> +		if (err)
>>>> +			goto unlock_vm;
>>>> +	}
>>>> +
>>>>    	attrs_user = u64_to_user_ptr(args->vector_of_mem_attr);
>>>>    	if (args->num_mem_ranges == 0 && !attrs_user) {
>>>> @@ -2487,7 +2486,7 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_vma_ops *vops,
>>>>    	u64 range_end = addr + range;
>>>>    	int err;
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	vm_dbg(&vm->xe->drm,
>>>>    	       "op=%d, addr=0x%016llx, range=0x%016llx, bo_offset_or_userptr=0x%016llx",
>>>> @@ -2694,7 +2693,7 @@ static struct xe_vma *new_vma(struct xe_vm *vm, struct drm_gpuva_op_map *op,
>>>>    	struct xe_vma *vma;
>>>>    	int err = 0;
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	if (bo) {
>>>>    		err = 0;
>>>> @@ -2795,7 +2794,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>>>>    	switch (op->base.op) {
>>>>    	case DRM_GPUVA_OP_MAP:
>>>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +		lockdep_assert_held_write(&vm->lock);
>>>>    		err |= xe_vm_insert_vma(vm, op->map.vma);
>>>>    		if (!err)
>>>> @@ -2806,7 +2805,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>>>>    		u8 tile_present =
>>>>    			gpuva_to_vma(op->base.remap.unmap->va)->tile_present;
>>>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +		lockdep_assert_held_write(&vm->lock);
>>>>    		prep_vma_destroy(vm, gpuva_to_vma(op->base.remap.unmap->va),
>>>>    				 true);
>>>> @@ -2842,7 +2841,7 @@ static int xe_vma_op_commit(struct xe_vm *vm, struct xe_vma_op *op)
>>>>    		break;
>>>>    	}
>>>>    	case DRM_GPUVA_OP_UNMAP:
>>>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +		lockdep_assert_held_write(&vm->lock);
>>>>    		prep_vma_destroy(vm, gpuva_to_vma(op->base.unmap.va), true);
>>>>    		op->flags |= XE_VMA_OP_COMMITTED;
>>>> @@ -2889,7 +2888,7 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
>>>>    	u8 id, tile_mask = 0;
>>>>    	int err = 0;
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	for_each_tile(tile, vm->xe, id)
>>>>    		tile_mask |= 0x1 << id;
>>>> @@ -3072,7 +3071,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>>>>    	switch (op->base.op) {
>>>>    	case DRM_GPUVA_OP_MAP:
>>>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +		lockdep_assert_held_write(&vm->lock);
>>>>    		if (op->map.vma) {
>>>>    			prep_vma_destroy(vm, op->map.vma, post_commit);
>>>> @@ -3083,7 +3082,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>>>>    	{
>>>>    		struct xe_vma *vma = gpuva_to_vma(op->base.unmap.va);
>>>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +		lockdep_assert_held_write(&vm->lock);
>>>>    		if (vma) {
>>>>    			xe_svm_notifier_lock(vm);
>>>> @@ -3098,7 +3097,7 @@ static void xe_vma_op_unwind(struct xe_vm *vm, struct xe_vma_op *op,
>>>>    	{
>>>>    		struct xe_vma *vma = gpuva_to_vma(op->base.remap.unmap->va);
>>>> -		xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +		lockdep_assert_held_write(&vm->lock);
>>>>    		if (op->remap.prev) {
>>>>    			prep_vma_destroy(vm, op->remap.prev, prev_post_commit);
>>>> @@ -4092,6 +4091,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>>>>    		goto release_vm_lock;
>>>>    	}
>>>> +	/* Consume queued resets before replacing VMAs. */
>>>> +	err = xe_svm_garbage_collect(vm);
>>>> +	if (err)
>>>> +		goto release_vm_lock;
>>>> +
>>>>    	for (i = 0; i < args->num_binds; ++i) {
>>>>    		u64 range = bind_ops[i].range;
>>>>    		u64 addr = bind_ops[i].addr;
>>>> @@ -4907,7 +4911,7 @@ static int xe_vm_alloc_vma(struct xe_vm *vm,
>>>>    	u16 default_pat;
>>>>    	int err;
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	if (is_madvise)
>>>>    		ops = drm_gpuvm_madvise_ops_create(&vm->gpuvm, map_req);
>>>> @@ -5041,7 +5045,7 @@ int xe_vm_alloc_madvise_vma(struct xe_vm *vm, uint64_t start, uint64_t range)
>>>>    		.map.va.range = range,
>>>>    	};
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	vm_dbg(&vm->xe->drm, "MADVISE_OPS_CREATE: addr=0x%016llx, size=0x%016llx", start, range);
>>>> @@ -5073,7 +5077,7 @@ void xe_vm_find_cpu_addr_mirror_vma_range(struct xe_vm *vm, u64 *start, u64 *end
>>>>    {
>>>>    	struct xe_vma *prev, *next;
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held(&vm->lock);
>>>>    	if (*start >= SZ_4K) {
>>>>    		prev = xe_vm_find_vma_by_addr(vm, *start - SZ_4K);
>>>> @@ -5105,7 +5109,7 @@ int xe_vm_alloc_cpu_addr_mirror_vma(struct xe_vm *vm, uint64_t start, uint64_t r
>>>>    		.map.va.range = range,
>>>>    	};
>>>> -	xe_vm_assert_write_mode_or_garbage_collector(vm);
>>>> +	lockdep_assert_held_write(&vm->lock);
>>>>    	vm_dbg(&vm->xe->drm, "CPU_ADDR_MIRROR_VMA_OPS_CREATE: addr=0x%016llx, size=0x%016llx",
>>>>    	       start, range);
>>>> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
>>>> index 5c7aefc641ee..1af5e79bbfd3 100644
>>>> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
>>>> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
>>>> @@ -638,6 +638,11 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
>>>>    		goto unlock_vm;
>>>>    	}
>>>> +	/* Consume queued resets before publishing new advice. */
>>>> +	err = xe_svm_garbage_collect(vm);
>>>> +	if (err)
>>>> +		goto unlock_vm;
>>>> +
>>>>    	err = xe_madvise_details_init(vm, args, &details);
>>>>    	if (err)
>>>>    		goto unlock_vm;
>>>> -- 
>>>> 2.43.0
>>>>
