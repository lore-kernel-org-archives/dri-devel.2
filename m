Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7276CC982CC
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BD010E1FC;
	Thu, 17 Sep 2026 02:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nLsH+vyG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0452110E1FC;
 Thu, 17 Sep 2026 02:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789610827; x=1821146827;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kpgbqX+/dcteFZhfEPTGih0bOfwaLYKnQFmXZ47zGyk=;
 b=nLsH+vyGl4TXAf0snRJJ5mJ8f+EpebV6EO5fM9nDFn8ymESICkIbKqx1
 kfumk5Sy1VSt1PCWQPTGVjsQ3ivR1mKwsPGS8Q7TbjwnX92Fy+uVIASlj
 K78u6PRdJehp1IVytaEqyQU3GeHkLH9mrAbZC6nSc9ve7MKW3spy8yIbN
 DZ9yFg9xd8C7Xft5S5qirnAWgsogFQVPTy0/EDoxa2Q5nceEBN4VIs22q
 9Mdf9+ifYPbHoskveapI4gAWyzPWKVF+cEi+x8eLTpYE4H6s+aUhiipf5
 oLpli05GAJ7Ezu3s+uopEXaqDs5C2gYjo2sbVlwqGoIrslimkd+jXzRJl g==;
X-CSE-ConnectionGUID: NUoZPU2WT7i0pu0fFfA9Iw==
X-CSE-MsgGUID: qXlJLRsUQgeYrxINLMpWeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101337229"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101337229"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 19:07:06 -0700
X-CSE-ConnectionGUID: Ns3Dr75hQjmW7V7P0pfviQ==
X-CSE-MsgGUID: WfE9JPcmRK+Q7eHR1Vf/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1924494"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 19:07:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 19:07:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 19:07:05 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 19:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5qVTCEMV2UWbrgoVr6rxZZknqoVNo+J+4TRWlbrM93IkYCnq4dqVJnsX9BmzPaMXl57McRBIw1tOfHXKqsmYoOs9rF9X0fUVSDiwWOLlFQCYDHm6GKIBKniDb413mNwUOhvb81pqnQ17A5+dD/8lq/+c2mC9UkQuJU51WXFp1HQqXzbn8jUH4qvcBNINFaeWBbZ3IYhyXqq3GJfmtb9mkLLDlWbUw8l1iA/OlC8Ia1vn9bNWUX2OCHOCSUkkbNexDORtOM3Qy4WREGCrkHeosA0B98rw3ubenIeHsGaOBKJYZFPBgsf7+6kX9s77hYedO6elGmUy0QqCHe72YTgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpgbqX+/dcteFZhfEPTGih0bOfwaLYKnQFmXZ47zGyk=;
 b=x3ANI0QwIrtZF0mXf3Fa9BvQodgcMCuCo5RGCua8Um+bqRaccolHGgQ3moemAgTz1k4HzZACOuK8srNWnyNErJzs+TN8IC39t3HFBOUXuilty491/RTGvznImP1X4KemQskDcxfNIUOApR4hlRbWyf35Z03aRbyWzSWP9O1Hr4KUGpbXe1TbGE09s96krQMe6EQD8gku/3eM+5HSns+GAc+/UsX9ViviB9ARY6AflVHGwPr5P817cqW3cSExsDNWhVsSRxQvcSzunj8HADpLrOOZJ8X9lZm5SZi5KdCPVZya/gtF52GkToSVyRykcuwV58TlJ2ixSvS8iYhMOLJ5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 02:07:00 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0428.009; Thu, 17 Sep 2026
 02:07:00 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Nikula, 
 Jani" <jani.nikula@intel.com>, "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Topic: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Index: AQHdRJQayossBqMXeEuwdmvTfN5itbbPQDQAgACNaICAAHK1AIABVHkAgABgO4CAABRDAA==
Date: Thu, 17 Sep 2026 02:07:00 +0000
Message-ID: <f4f3390fe950479cd6ef9367924861a3ec74ee95.camel@intel.com>
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
 <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
 <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
 <aqnL7lUojj9jm8q_@intel.com>
 <6f8deb9d5f07feae11f35363e8b22d5ae606e63d.camel@intel.com>
 <aqs6Q9D_JywZ65-z@intel.com>
In-Reply-To: <aqs6Q9D_JywZ65-z@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|DS7PR11MB6102:EE_
x-ms-office365-filtering-correlation-id: 487e2ba1-7641-498b-c4da-08df14605be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|38070700021|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: EO+23fd2D+hBCF/CKuHE+hilR0IuKhoM2cEvENBg6alvLEe69+BA/qAsyZwPybzNFKcZRnBvZmLkHUg9a6c23hYXvVHTPuHIP2xSfO0v56n38yD37YBClCjLti3EhpchIv5TKvR3UETDqs6z+hC8ZRiHXXkRWJODK9+SKMx0/x8iPkULtFnsoRQ+L9/HD4AA9aMncy1mnQ1URF7fNTmEGrjemaJSJX1WH+J0jrby4VKvWvmzC0tRjziRro0v2/c492Q48cjWambpxH6y0PJD2XIazK2KGxW6n89y32O6KVH9DkhHG3Bkyz+zSUYoA4ieYPhEBQBquT7lbS1jI8Thiwl8XtRPceOZ9sVpsp1IMvpe/YuSgfJX5VbU+jqiUFH8+pdRrs8/fRKErXPSQrizN7kaen/D6jA5gVNhkxjde5ENVPOwKl86vJPuW7HGvuSJlHjDJNV7nk2yw5XHLZt8Ww0vsIw2foOFVhEd7MhEO0VTX6cIg8jAQHuMEBZs90Mbcb+9FxgP+JdMP98+hfBe9OG1hXhxDY/IlGNHSy4UV6eh9eurkqc8oGBhKQtSrv2wiajQfTqcA3WVhvC7+FUNXpgNzhOTMsRDO0Oeb2rl1gN4HuvUrR+HBK0Jlul3Hj/exvJmupi1zSsm/n188F86C6kgo0QFU0C2ykKEPgFgRrFMM5e0+sbsBWz55iqHJp556hIhVi3ifeWrHlyYcBm+DliRjNgUqVOHFu2Px4S/uTI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjFYY0ZrajcvNHM1OVZicnNCV0tLU2M4YXlKbjNIRWJVVjg4WVJhamdralhv?=
 =?utf-8?B?ZmVjbCtEQ2NMZmM3WFRFZzFXc0hCOVF3cjlDd090VWlVbDB5enROeDJSOHlJ?=
 =?utf-8?B?Q2h3cU5vZWViRXdRQTNCOS95WjVZd0lCNUVGSDA2OUgyQlg0Z1lEZytxeEQ5?=
 =?utf-8?B?Wlc1SUNYM3ArOG1vZ01CamxtOFNIZVNXb0ROVVY0cTdVUTBvR1pteTd6dTB4?=
 =?utf-8?B?cHRyYk1NeUcybW85ZHRwV0d3eHBNUFhtcXNkcVc0ZGErVXhCL0syWi9oWkx3?=
 =?utf-8?B?SU5mNUIxci9jc1IxOEFhUVpDVHFjRTVPd3dvUHc1aDJmU1JFa3UraXNRT3B3?=
 =?utf-8?B?MXBsZjdnZ1laZlBLMUxQQThtekJEb3oxbjV4cjNkNzNIbjA0eDdUNjZtb2p4?=
 =?utf-8?B?cEZmRHdUTUNaeGUyeWtvTE04MzNoUG9Uak05VlJTTkpCN2o0M2JZUFRURmZw?=
 =?utf-8?B?SHhmZFJTazZuWnBEZEs3amdvRVdDb01kWFhYQzQ3MnU2YmRJU05uQWtlM0lE?=
 =?utf-8?B?R1VSeVFNdXFaY201YjFKYlRXNWwrY3JraUVxQlJHbC84MWxWUmlYZWx4ZFhQ?=
 =?utf-8?B?MjlKQW1icENUcDlkNnQwZC90Y2QzZmFBTTBqbEpvUHVyVjJCRURNSnNzbHFX?=
 =?utf-8?B?ZlZEbGxzbEcrTk5nbW81QWw3OVMyVzkwSDlCSGFxNWpqdEZlWEZDeFZjNENa?=
 =?utf-8?B?Sm9pVEJaZGl3bksraHVwWGkySGdhTjZtVHYwMmZ1d1UybkUwR1g3WkZ3V25p?=
 =?utf-8?B?cVJKUXN2VlJsT3J1aFg1ampXZXlMK0lQMnpEaTR2UGl6aXMrZmFYNUMxVTll?=
 =?utf-8?B?d3o3Y203Yy9oOFJ6T0xROCsxWUpKWUZpUU5GNnljMWdjZUZxdm9jVnBZYkM4?=
 =?utf-8?B?T3A4dFNWK0hMS2phVHlIanJxcGtRcmF2RS8zZGkxZE1Bbm5lT2RmVDh5aU1M?=
 =?utf-8?B?VFp5UUN2ZmE1M2JxQTRnYUdkZGlxWldQbCt0d1FWaXBrSEtINWp4bHFNL0ZI?=
 =?utf-8?B?OEl1L2lpZ0RHRHdXelhTK2YzZmtFQm5kV3Ayd2tJaEhuVmNuS0xSOThGOXNC?=
 =?utf-8?B?aCtwbmZXNis5cC8xZjU2TGU3dWNFa1k3b29KYmhJMSt4VXlNek8rZVdhZUtG?=
 =?utf-8?B?Z2V2QmlxREkrbHJVeVVrVld4MVFqKzl0WmlieE5RZTczczVZSE44aEZDN2N4?=
 =?utf-8?B?UGsxL3lwbllKMFoxM29MRmMrOWFPdGhNOUdjM2VvOEt6SWtybFRDMEdhbE9H?=
 =?utf-8?B?dmdMRnFzeXgrVDYrSVJ2Y09mbmwveEZvWmU2bmtqSTV2RHplT3pvOFVVSi9G?=
 =?utf-8?B?ZFdUcFZsa20rRlhDWVl5S1gwcDlkVHdzWnRvTjVhbjJCVEQwNXpLSVc2cTda?=
 =?utf-8?B?NXFlTjhYakE1MWdKTk9VWmIyS3ZVY3ROT0R1Q09KUGxzY1l5dEh6RUZvZW1j?=
 =?utf-8?B?Z2xkTnY2U0VPQnJENDdQdGQ4aDUwcGcrZ3NBQmVURE96ZGtValc1d1V1djMr?=
 =?utf-8?B?KzJaNVVVYzNpVXdVYkhRcmIycVVYbDRuUFdzdkp5Q0hqUExGOWRyNm9pUkFs?=
 =?utf-8?B?ak4rN2J4Z3NQbW1jQ3dxNEJBNXh4a0pXSEtiK0ZRbjlEUHpQb2tXWTcvVjNx?=
 =?utf-8?B?OGZjZHRZdlIzbHl4dW9HWnBrTjZLRzBsV2dhbzFKSjZtL2RnVm1hdFFNTXNL?=
 =?utf-8?B?VGx3RDVyRUNhMGZ2dWhzUG9LRldEdEVWMzZaUVlwUVVqaXhubkZGUG50SnJ0?=
 =?utf-8?B?NVhxTGRsYnZGWVZjOG9aK3RWTG5SazlGQUZGZC9MVGdJVFpzYXF2Y2tpaXFT?=
 =?utf-8?B?V2ZjSW9NelRRU1hGZGlZbFZaenN0ZWMyNzBSQlNJSXpjc20xeS9nQXlLdHFJ?=
 =?utf-8?B?NzE1U2Y0WThoS1NQSUpoODZMQ3ZBM3ZDL0hSL1ZyUSs1ZXAyOVVaTmNwSjlr?=
 =?utf-8?B?d2hTcTBNcjZmQ0k0R2RLRy9GQ1JET3VBTTBURVJFTEgxOGNMbWlzL1NFV1dk?=
 =?utf-8?B?SmVWbzRNbVJnb1lXNzlyaHJ6dmhhNm9LVXZyZ2JNRjV5dnhoRWE2S0U0TVVZ?=
 =?utf-8?B?cTM1ejJoaHc1YkNXazkzeHJudTE5VjFPZHg0Z1JOMjhZVXJDc2RFUGZWNUZq?=
 =?utf-8?B?SFNwbC9LQzlkTm1BcmR4Y1Z5UE5wdVBkWkZmYzAvM0NieFhGS3lsQ29iQXhz?=
 =?utf-8?B?RE56cm10OGVnNGR4QlR3aE1VRDFBMzF0SjZDYXgxS0laWGZiOGEvRFpCS1dv?=
 =?utf-8?B?K2FMeU1yZklDNmIvYUVhcDNaczFsMm5LblJLQjRHNVRXNFp0dndkR1hhank4?=
 =?utf-8?B?TVhFdmNXaFdZMUp4OUFjVzBrVFErWHRic3Y4V01nUmhBOFhtNFhCeGRtOUtJ?=
 =?utf-8?Q?zWaubT2BHksugvo7PgTf8+My9thRvdlUq1N/k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <825CDADE7221824B835F0D14511075B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kjY4pzNtV7DYrMyTATONI4nwgUGSgtCeRzLh5A+PIRgy90uJUpn9i4uJ3fIN6QNXiYuaEV9bVey0nk97mDcTsJdEMVMHqZv2bSIDfIXNm4lkyv9eXREECKRC3ftH3v175V7QrYOFf0TLv3Rq5zGCHxrHj0vREqEqekKnkZPCfd7KbOZJdFXE20VMx6acsaF+2Nf0wPxX1UoNA6zMCchD5sVcsv7IIVMFvmtGuWVm7Av3G4IUDA1A2hQYC9qScMUJDERLJLoSWoLn2e2Q4gjuUa9lDTe3LEcAuvhkq9HGM5D7d+F2rpjlPse8GjvyJCdUnDEpmL3THwqsIWr7/asm8Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487e2ba1-7641-498b-c4da-08df14605be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 02:07:00.0714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4KmKhpxH1jUMsvi6eHz9v5jcSqhhjFDesfQSNrF6kVIfWgzBI+eIJXiu2OMgehoaUU5Hdxe2IG39ygtZ0MqSXGmIkO8qtwMl2n4EaT3kXwb4T90U3ovEwP/YPt9sfwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6102
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

T24gV2VkLCAyMDI2LTA5LTE2IGF0IDIwOjU0IC0wNDAwLCBWaXZpLCBSb2RyaWdvIHdyb3RlOg0K
PiBPbiBXZWQsIFNlcCAxNiwgMjAyNiBhdCAwNzoxMDoxMVBNICswMDAwLCBUZXJlcyBBbGV4aXMs
IEFsYW4gUHJldmluIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAxODo1MSAtMDQw
MCwgVml2aSwgUm9kcmlnbyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgU2VwIDE1LCAyMDI2IGF0IDA0
OjAwOjU0UE0gKzAwMDAsIFRlcmVzIEFsZXhpcywgQWxhbiBQcmV2aW4gd3JvdGU6DQo+ID4gPiA+
IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAxMDozNCArMDMwMCwgTmlrdWxhLCBKYW5pIHdyb3RlOg0K
PiA+ID4gPiA+IE9uIE1vbiwgMTQgU2VwIDIwMjYsIEFsYW4gUHJldmluIDxhbGFuLnByZXZpbi50
ZXJlcy5hbGV4aXNAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gYWxhbjpzbmlwDQo+ID4gPiA+
ID4gPiAgaW50IHhlX21taW9fd2FpdDMyKHN0cnVjdCB4ZV9tbWlvICptbWlvLCBzdHJ1Y3QgeGVf
cmVnIHJlZywgdTMyIG1hc2ssIHUzMiB2YWwsIHUzMiB0aW1lb3V0X3VzLA0KPiA+ID4gPiA+ID4g
LQkJICAgdTMyICpvdXRfdmFsLCBib29sIGF0b21pYykNCj4gPiA+ID4gPiA+ICsJCSAgIHUzMiAq
b3V0X3ZhbCkNCj4gPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4gPiAtCXJldHVybiBfX3hlX21taW9f
d2FpdDMyKG1taW8sIHJlZywgbWFzaywgdmFsLCB0aW1lb3V0X3VzLCBvdXRfdmFsLCBhdG9taWMs
IHRydWUpOw0KPiA+ID4gPiA+ID4gKwl1MzIgcmVhZDsNCj4gPiA+ID4gPiA+ICsJaW50IHJldDsN
Cj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJcmV0ID0gcG9sbF90aW1lb3V0X3VzKHJlYWQg
PSB4ZV9tbWlvX3JlYWQzMihtbWlvLCByZWcpLCAocmVhZCAmIG1hc2spID09IHZhbCwNCj4gPiA+
ID4gPiA+ICsJCQkgICAgICAxMCwgdGltZW91dF91cywgZmFsc2UpOw0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFlvdSBwcm9iYWJseSBkbyBuZWVkIHRvIGxldCB0aGUgY2FsbGVycyBwYXNzIGluIHRo
ZSB3YWl0IHRvby4gMTAgdXMgd2FpdA0KPiA+ID4gPiA+IHdpdGggYSBsb25nIHRpbWVvdXQgaXMg
Z29pbmcgdG8gYmUgcHJldHR5IGJhZC4NCj4gPiA+IA0KPiA+ID4gYWdyZWVkDQo+ID4gPiANCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gYWxhbjogb2theSAtIHBlcmhhcHMgaSBjYW4g
bWFrZSBldmVyeSBjYWxsZXIgcGFzcyBpbiBhIHBvbGxpbmctd2FpdCB0aGF0cyBhIGZyYWN0aW9u
IG9mIHRoZWlyIHdhaXQgdGltZS4NCj4gPiA+ID4gKGFzIGEgc3RhcnRpbmcgcG9pbnQgc2luY2Ug
aSBkb250IGtub3cgd2hhdCdzIHRoZSBleHBlY3RlZCBiZWhhdmlvciBvZiBldmVyeSBjYWxsZXIp
Lg0KPiA+ID4gPiBzbyBwZXJoYXBzIHNvbWV0aGluZyBsaWtlICJ0aW1lb3V0X3VzIDw8IDQiIChp
LmUuIDEvMTZ0aCkgYnV0IHBhc3MgaW4gMTAgdXMgaWYgaXRzIGFueXRoaW5nIHNtYWxsZXIgdGhh
biB0aGF0DQo+ID4gPiA+IChpLmUuIHNtYWxsZXIgdGhhbiAxNiB1c2VjKS4NCj4gPiA+IA0KPiA+
ID4gSSB0aGluayB3ZSBtaWdodCBiZSBjb21wbGljYXRpbmcgdGhpcyB0b28gbXVjaC4uDQo+ID4g
PiANCj4gPiA+IHdoYXQgYWJvdXQgc29tZXRoaW5nIHNpbXBsZXIgbGlrZToNCj4gPiA+IA0KPiA+
ID4gI2RlZmluZSBYRV9NTUlPX1dBSVRfTUFYX0JBQ0tPRkZfVVMgICAxMDAwDQo+ID4gPiANCj4g
PiA+IC4uLg0KPiA+ID4gLSAgICAgICAgICAgICB3YWl0IDw8PSAxOw0KPiA+ID4gKyAgICAgICAg
ICAgICB3YWl0ID0gbWluX3QoczY0LCB3YWl0IDw8IDEsIFhFX01NSU9fV0FJVF9NQVhfQkFDS09G
Rl9VUyk7DQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IGFsYW46IGkgZG9udCB1bmRlcnN0YW5k
IHlvdXIgdGhpcyBjb21tZW50IG9uIHRoZSBpbmNyZWFzaW5nIHRoZSAid2FpdCBieSB4MiIgaW4g
dGhlIGxvb3AgYWZ0ZXIgYWdyZWVpbmcgd2l0aCBKYW5pIG9uIHRoZSBlYXJsaWVyIHN0YXRlbWVu
dC4NCj4gDQo+IFdoYXQgSSBhZ3JlZWQgd2l0aCBKYW5pIHdhcyB0aGF0IGEgaGFyZGNvZGVkIDEw
dXMgcG9sbCBpbnRlcnZhbCBhZ2FpbnN0DQo+IGEgMnMgdGltZW91dCBpcyBiYWQuIFRoYXQgd2Fz
IGFsbC4NCj4gDQo+ID4gU29tZSBoaXN0b3JpY2FsIGNvbnRleHQ6DQo+ID4gDQo+ID4gIDEuIGN1
cnJlbnQgYmFzZWxpbmUgY29kZSBpdCBzdGFuZHMgdG8gZGF5IElTIGluIHZpb2xhdGlvbiBvZiBs
aW51eCBydWxlcyBmb3IgaG93IHRvIHVzZSB0aG9zZSBzbGVlcC9kZWxheSBmdW5jdGlvbnMNCj4g
DQo+IHJpZ2h0LCBhbmQgSSBiZWxpZXZlIHRoYXQgdGhpcyBzaW5nbGUgbGluZSBjaGFuZ2UgaXMg
ZW5vdWdoIHRvIGZpeCB0aGlzDQo+IHZpb2xhdGlvbi4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRo
YXQgd2UgZG91YmxlIHdhaXQgZXZlcnkgbG9vcCAxMCwgMjAsIDQwLCA4MCDigKYgMjA0ODAsIDQw
OTYwIGFuZA0KPiBuZXZlciBzdG9wcyBkb3VibGluZy4gdWRlbGF5KCkgaXMgb25seSBsZWdhbCB1
cCB0byB+NTAwMHVzIChwZXJoYXBzIDEwMDA/ISksDQo+IHNvIG9uY2UgdGhlIGRvdWJsaW5nIHBh
c3NlcyB0aGF0LCB3ZSdyZSBicmVha2luZyB0aGUgcnVsZS4NCj4gDQo+IFNhbWUgb24gdGhlIHNs
ZWVwaW5nIHNpZGU6IGl0IGVuZHMgdXAgYXNraW5nIHVzbGVlcF9yYW5nZSgpIHRvIHNsZWVwIDEu
MyBzLA0KPiB3aGljaCBpcyBub3Qgd2hhdCB0aGF0IGZ1bmN0aW9uIGlzIGZvci4NCj4gDQo+IFRo
ZSBvbmUgbGluZSBqdXN0IHN0b3BzIHRoZSBkb3VibGluZyBhdCAxMDAwdXM6DQo+IA0KPiB3YWl0
ID0gbWluX3QoczY0LCB3YWl0IDw8IDEsIDEwMDApOw0KPiANCj4gQWZ0ZXIgdGhhdCwgdGhlIHdh
aXQgY2FuIGJlIDEwLCAyMCwgNDAg4oCmIHVwIHRvIDEwMDAsIGFuZCB0aGVuIGl0IHN0YXlzIGF0
DQo+IDEwMDAgZm9yZXZlci4gSXQgY2FuIG5ldmVyIHJlYWNoIDIwNDgwIG9yIDEzMDAwMDAuDQo+
IA0KPiBTbyB0aGUgaWxsZWdhbCB2YWx1ZSBuZXZlciBnZXRzIHBhc3NlZCB0byB1ZGVsYXkoKSBv
ciB1c2xlZXBfcmFuZ2UoKSDigJQgZXZlci4NCj4gDQo+ID4gIDIuIG15IGluaXRpYWwgcmV2cyBv
biBmaXhpbmcgdGhpcyB3YXMgdG8gbWluaW1pemUgdGhlIGNoYW5nZXMgc28gaXRzIG5vdCBjb21w
bGljYXRlZCBieSBzaW1wbHkgZml4aW5nIHRoZSBjb2RlIGluIHBsYWNlLg0KPiANCj4gSSBiZWxp
ZXZlIHRoaXMgc2ltcGxlIGxpbmUgYWxpbmdzIHdpdGggeW91ciB2MSwgYnV0IGp1c3Qgc2ltcGxl
ci4NCj4gDQo+ID4gIDMuIEphbmkgc2FpZCB3ZSByZWFsbHkgc2hvdWxkIHVzZSB0aGUgcHJvcGVy
IGxpbnV4IGtlcm5lbCBoZWxwZXJzOiBwb2xsX3RpbWVvdXRfdXMgLyBwb2xsX3RpbWVvdXRfdXNf
YXRvbWljLg0KPiA+ICA0LiBUaG9zZSBoZWxwZXJzIGhhdmUgdGhlICJ0aW1lb3V0X3VzIiBhbmQg
dGhlICJpbnRyYS1sb29wLXdhaXQtdXMiIHBlcmlvZC4gSSBoYXJkY29kZWQgdG8gMTAgdXNlYy4N
Cj4gPiAJLSBKYW5pIHNhaWQgaSBzaG91bGQgbm90IGhhcmRjb2RlIGFuZCBlbnN1cmUgYWxsIHVw
LXRoZS1zdGFjayBjYWxsZXJzIG9mIHRoZSB4ZV9tbWlvX3dhaXQzMiBmdW5jdGlvbiBwYXNzZXMg
aW4gdGhlIGludHJhLXdhaXQtbG9vcA0KPiA+IHZhbHVlLiANCj4gPiAJLSBUaGVuIHlvdSAoUm9k
cmlnbykgYWdyZWVkIHdpdGggaGlzIHJlcXVlc3QgYnV0IGdvIG9uIHRvIHByb3Bvc2UgZ29pbmcg
YmFjayB0byBleHBvbmVudGlhbCAyeCBpbnRyYS13YWl0LWxvb3AuDQo+ID4gCQktIGJ1dCB0aGF0
IGNvbnRyYWRpY3RzIEphbmkncyByZXF1ZXN0IHUgYWdyZWVkIHRvIGFuZCBhbHNvIHRoYXQgbWVh
bnMgd2UgaW1wbGVtZW50IHRoZSBpbnRyYS13YWl0LWxvb3A/IChpLmUuIGRvbnQgdXNlIHRoZQ0K
PiA+IHByb3BlciBsaW51eCBoZWxwZXI/KQ0KPiANCj4gc29ycnkgZm9yIG5vdCBiZWluZyBjbGVh
ciBvbiBteSBwcmV2aW91cyByZXNwb25zZS4gUGVyaGFwcyB3ZSBoYXZlIGEgY2xlYW5lcg0KPiBl
bmQgY29kZSB3aXRoIHRoZSBwb2xsX3RpbWVvdXRfdXMgYW5kIHBvbGxfdGltZW91dF91c19hdG9t
aWMgaW5kZWVkLg0KPiANCj4gVGhlbiBwZXJoYXBzIHdlIGhhdmUgdGhpcyBzaW5nbGUgZml4ZXMg
cGF0Y2ggYW5kIGRvIG90aGVyIGF0dGVtcHRzIGluIGdldA0KPiBjbGVhbmVyIGxvb3BzPw0KPiAN
Cj4gVGhhbmtzLA0KPiBSb2RyaWdvLg0KPiANCmFsYW46IEkgdGhpbmsgaSB1bmRlcnN0YW5kIHdo
YXQgdSBtZWFuLiBCdXQgaSBiZWxpZXZlIGEgc2luZ2xlIGxpbmUgcGF0Y2ggd2lsbCBOT1Qgc3Vm
ZmljZQ0KdG8gbWFpbnRhaW4gZXhpc3RpbmcgYmVoYXZpb3IgZm9yIHRoZSBub24tYXRvbWljIGNh
c2UuIEluIHRoZSBvbGQgY29kZSwgaWYgY2FsbGVyIHdhcw0KcmVxdWVzdGluZyBmb3Igbm9uLWF0
b21pYywgJ3dhaXQnIHdvdWxkIGNvbnRpbnVlIGRvdWJsaW5nIGluIHVzbGVlcF9yYW5nZSAod2hp
Y2ggaGFzIG5vDQpvdmVyZmxvdyBsaW1pdCBmb3IgaXRzIHBhcmFtcykgc28gd2UgYWN0dWFsbHkg
Q0FOIGtlZXAgZG91YmxpbmcuIFRodXMgY2FsbGVycyB0aGF0IGhhdmUNCnZlcnkgbGFyZ2UgdGlt
ZW91dHMsIHdlJ2xsIGJlIHNhdmluZyBvbiBDUFUgY3ljbGVzIGFzIGl0IGluY3JlYXNlcy4gQnV0
IHdpdGggYSAxIG1zIGNoYW5nZQ0KYXMgeW91IHByb3Bvc2VkLCB3ZSdkIGJlIGluY3JlYXNpbmcg
Q1BVIGN5Y2xlcyB0byBnZXQgdXMgdG8gdGhlIGVuZC4gT2ZjIEkgYWdyZWUgdGhhdA0KZG91Ymxp
bmcgZm9yZXZlciBpcyBub3QgaWRlYWwgZXZlbiBmb3IgdGhlIG5vbi1hdG9taWMgdXNsZWVwX3Jh
bmdlIGNhc2UsIChrZXJuZWwNCmRvY3VtZW50YXRpb24gc3RhdGluZyB0aGF0IGl0cyBnb29kIGZv
ciBib3RoIHNob3J0IGFuZCBsb25nIHRpbWVvdXRzKSwgaG93ZXZlciBrZXJuZWwNCmRvY3VtZW50
YXRpb24gRE9FUyBzdGF0ZSBpdCdzIGFuIGV4cGVuc2l2ZSBvcGVyYXRpb24gd2l0aCB0aGUgaHJ0
dGltZXIsIHdoaWNoIGlzIHdoeQ0KaSB3YW50ZWQgdG8gYWxsb3cgdGhlIGRvdWJsaW5nIG9mICd3
YWl0JyBmb3IgdXNsZWVwX3JhbmdlIGNhc2UgKGxpa2Ugb3JpZ2luYWwgY29kZSkgYnV0DQpjYXAg
aXQgdG8gMjUlIG9mIHRoZSBjYWxsZXIgcHJvdmlkZWQgZmluYWwgdGltZW91dC4gKHdoaWxlIGNh
cHBpbmcgdGhlIGF0b21pYyB2ZXJzaW9uIHRvDQpNQVhfVURFTEFZX01TIGZvciBzaG9ydCBkZWxh
eXMgb3IgdGhlIHNhbWUgMjUlIGZvciBsb25nIGRlbGF5cykuIFRoaXMgd2lsbCBlbnN1cmUgdGhl
DQpvdmVyYWxsIGJlaGF2aW9yIGluIHRlcm1zIG9mIGNwdSBjeWxlcyBhbmQgZXhwZW5zaXZlIGhy
dHRpbWVyIGNhbGxzIGFyZSBzaW1pbGlhciBhcyBiZWZvcmUNCkFORCBhbHNvIGZpeGluZyBpbiBh
Y2NvcmRhbmNlIHRvIHRoZSBydWxlcy4gQWN0dWFsbHkgaWYgdSBzZWUgcmV2MywgdGhpcyBpcyB3
aGF0IGkgbWVhbg0KSXRzIG5vdCAxIGxpbmUgYnV0IGl0cyBtdWNoIHNpbXBsZXIgZml4IGFuZCBk
b2VzIEkgYmVsaWV2ZSBpdCBkb2VzIGFsaWduIHdpdGggeW91ciB2aXNpb24uDQoNCj4gPiANCj4g
PiAgLi4uYWxhbg0KPiA+IA0KPiA+IA0KPiA+ID4gQWxzbyB0aGUgRml4ZXMgdGFnIGlzIG5vdCB0
aGUgcmlnaHQgb25lLi4uIHRoZSBidWcgd2FzIHRoZXJlIGJlZm9yZS4uLg0KPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiAuLi5hbGFuDQo+ID4gDQoNCg==
