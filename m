Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E39CC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22FF10ED2E;
	Tue, 22 Sep 2026 14:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QMGhjMWC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDDB10ED16;
 Tue, 22 Sep 2026 14:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790087659; x=1821623659;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kXV77gobxSs5fF5Adx1apX51fHY6ykv+GEkGNuv3tJI=;
 b=QMGhjMWC6Y+6H0WpUyVd4rH3VSaaFVcHNRXs8rb0vIaPrqdcTOeiZEgg
 LJwtnZo3d7q+todirqXynktTGEjhpnk0fV7tP2b8adtXITdlS63ShZtCL
 MZHurIsYJzUmPXLumRcMDMhVmapGFml5rM6TTxUBoaG+Kqf4YR9bHtVGY
 aEQSvl33RPoSaN6g6MeXEvWtAtSmm1ddoanBSQsCU2ZK15YGB/rT4+a1G
 Mfi9Qbah4U2JPLXHZn2dZvNmVgsD2jbmLQv+PMTFvPpEMRSYwaDY6Mm0B
 8mFaoAKQCxu+hfd4rqbhHoignC0rpd1jJs7uJKbKM1Ym+XNrQSKrMEX4z w==;
X-CSE-ConnectionGUID: wgw27gDCRJ6P+EV2Rfx5cg==
X-CSE-MsgGUID: MUid1LMrT/i7GogTJXOk2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78248004"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="78248004"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 07:34:19 -0700
X-CSE-ConnectionGUID: sXkzFY8QT/CVT3QFw5Ratg==
X-CSE-MsgGUID: oA48MP0uSY2e54M+YAUl2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="273330465"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 07:34:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:34:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 07:34:18 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 07:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o58BqQrY9/JPxNqWUaexpq27+X/xK9f6lnpvXppSmywVQzk3qhoM9jKsjTw+cQc+Wz7HJLbSTG3dMqtSvly9BsiziS5xftjd/vU6KtXYOEjWLt7/FTVUUbbasbJDCSXg4d9Vva8WLxp0GybtEpqSLT/dk9GnKeSjlFrmNM4KXxd6zEGIQQWy65tG1T0zd2Yu02Hcx6M4pd8lE4dg+XT7ZKB/FF+8hTOrbsRrujXnu0+yK/34ekm9TpYc3DeAqneOoAy+ATq/WcmxvzdX+aDp7PGn1jAngvL+rxxTgBHXbLysLBM8hC8dbjy22uwg18zin6MNhfYRoflZbFQblkDmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXV77gobxSs5fF5Adx1apX51fHY6ykv+GEkGNuv3tJI=;
 b=nG5b2wMzNb2CBn6FUyfW4OA7fPOWX0sKE2YPXaAZhs26kj6FFUKUvtd1Qw3xJjHHByx3uHBd/x03In/TiuQm2CXkSE0JviqZRBplswNKIaBGQi43lUeRE+JczA1VE7bMbxID5CiAQb/Psd64xyz9ZGVY+8IoNezu1vuzKotGZ1UKoGZh3prDyRNT6VwH9lb3912hxbCHvrSmAExGK6v/XdzqyorNrQLrtmtBLXSlxYQLlWFkOodbTbi2uBJ7RjFgJDMgkIuPbBoEgYWCYQPq/LEQq3kVMk6+FR5d1L+Pj6pZc2nFwjqU1e0x8uIgsl+j5/6pl1oaPBpHMUeB4gxn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Tue, 22 Sep 2026 14:34:08 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 14:34:08 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Thread-Topic: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Thread-Index: AQHdCOF1lbPxpopA/0itXMF8igkPpbZXtN2AgADdC4CAAE7mgICA67EggADd+4CAAH5VAA==
Date: Tue, 22 Sep 2026 14:34:08 +0000
Message-ID: <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
In-Reply-To: <179005959984.27165.4749331452130832177@jlahtine-mobl>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: joonas.lahtinen@linux.intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|DM4PR11MB6264:EE_
x-ms-office365-filtering-correlation-id: 22778bec-1665-4918-29de-08df18b68fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|42112799006|11063799006|56012099006|4143699003|38070700021|10067099003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: yc5pgcg/MOAzexLwoYm7WEziKfqM5R01Qe9rfONYdqumkCpbaz30QmZAWMQIVvovuc/ldCx++GjR34iRH6VrAbLhalJnnD85qxi9eAwk9ShxPpMZtoRjd6JFCiJXaOAP4Gdoh2e8Zbm3IKvofqWZkAXrSAh0VqCRhpa5M/87GcZ/oqsYPvbzoOA+nXxOIW0WkM6TnAsfOzjtw76kJ+DknVTUBnLLZmWYV2WL8QGrimJv2qZmGWj4x6muKtS1WvJiFJ6ymwRy7XTOfDVCjWJgeAQ5r7ucj0+jUXX7lwmHBFaF9+mehdGRqjh0oVeXqR6iN8w08aXAtbmo5SwCFQlIRsz+ChIerz9OzP6DGCKWa9I5DTIWDJ1TiwGKfp4tjdsSV1YuGlWNSJbyF26IzpfJKsQ8HIOoH8CJTLJgTKaAkavvjeOCBlC015RPdmy61zC7IIKKvfhEP16J1Qip+5cs5lK2R/JeKm40vc2jiGhQwemdVdsSWg8ZkpICCGkymIixpTOlLq4UZg0wRDTqUKSyzAxnGWgzlmNMG7wMhYw0Wamzg+RwAOiHDwJL5mV4THohQj68na3eCcm7wlTyTU7Vz6s3pEIg6Qtn4bhcCoeTc2mqrNefRRjq1GTvVqisyxj9lAV01ieZFd4sKNE3TpN+CTbP6h5AEL8yCrXwhySd8QbuOEOp9rRQcny0+ySNggtvmy6P4MriDWzv07lEmgy3/NcH8aWLu1OtCJfYVvte8a8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(42112799006)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVc3emRDYUt5WHZpaGpGZ3c1M3U4M0QxMnhQZDFIK0hETzZRT3BZUzNVeUNU?=
 =?utf-8?B?WVZacVdwcWEwd1JVR0dMSExEcFplb0lUL2RzOUgrekxaRmlnYkJnRU9xVTJx?=
 =?utf-8?B?MmxCSEZMdE85dis0eHprSjJrNDY5YVo1NS83TUo2N0xHdTZrYTFOOEdMMDJW?=
 =?utf-8?B?RWNUSVZTc0VPbm9wWkNsRG1WMExXRkVGL0pRSXBSQVdhUVR2YllMLzd0WVdE?=
 =?utf-8?B?aWh6dDJzczJLcGEvWlhWanhSY0prUVlkZVNDNUYxZDZoTGF3bXlINS9NV2Ry?=
 =?utf-8?B?NlBBRTV5aGNmVi93UStEYU53OGtZQzBuZnV3KzRvcVBKMXJkdnNpK05GUVRC?=
 =?utf-8?B?SjRDTVB1eHdQOXBEblhhL2ZISmE2clByTy9RU1dHNUF6UmxzVVFXc3hUbGE0?=
 =?utf-8?B?Y1U1aHh2VmRtUVlvZ1VvMDhSZEJnTHlEdHF5clowZ09YQ0R1b2F3a3ZsNmZi?=
 =?utf-8?B?VlJtbDd4Mk9wMTNEcDlkVjAvcWFvV09Ddy9tVVNyNlBhc0tJNnhBa0d5RUh5?=
 =?utf-8?B?d29kK2VzR1ZlV1gxUFowdklvcEd1Q1VwNkJMTlJDQ281Q0k1Y0N4Q05rQVFj?=
 =?utf-8?B?MW5tRkZUTWM1YmFjMHJvangwL0FMblpzRUp0UVFNQUVJTGdCMzJpL1BsZGd4?=
 =?utf-8?B?R08xL1pkQ1FlUGtuVVVhVFE2T0d3T1c0WlMzUnU0S1p3THE5cCtjNERpOC95?=
 =?utf-8?B?Mys3SUk2WGZQV0lXOXFvZHE5c0c0dXMvUEJnTER1SXByWWdlblBzSlNCSEJo?=
 =?utf-8?B?alA4MWdBcnlWeDJ5c2xXS0V6alJ5Y1ZHcUZZM0RxQ1lhSVBWWmJtaE9hL3c1?=
 =?utf-8?B?aEhsQlBXb1c4ZktnMXoyOXVHcklVNkYycXV3RjJhdU5uVjBVaHJ6Um5BQWUr?=
 =?utf-8?B?MDMxQ2x5Umc1ajhhNXBFUmF6QVJhZGxXTE9ENC9OeGE5NkE0NkhsUUc0dmZI?=
 =?utf-8?B?U1JVT2FWSDdOSXFqSkVzTlBWT2Q2ZU9vVlgwVU5LOVdhUm92dHRubGU4R3RI?=
 =?utf-8?B?ZDZiWHFnN2xReS9qTlFsUXBpQlJJUGRKRXdSZ2dCMDI4OFBHSEE5YnNRVnJx?=
 =?utf-8?B?aFZXM0Z1L3NzMU5uLytHQ0thNVIzeHBlcjc0c2Nkd1NpUkQxa3QxL1pNRkdY?=
 =?utf-8?B?bXdmRjA1MnVXNlRzblhxYmVCRjVMbVVBNlZ4Yk4xeXNiUTU4N2xTcnlycWlD?=
 =?utf-8?B?WjNnVU10WlNqRVI4WlNqMDRBQmNrRTIxaFNvYktVQjNvVmR5WSttQjVvYmNM?=
 =?utf-8?B?Q3RFbkxhWjZLRmZCZk9zVEdOTTJ1aVZVRURJQStiUHhmVlVzTjQ3Z1B4LzBW?=
 =?utf-8?B?M20vY0Q3UngyOURLTjFZaENzdDNsWFFsN29aZlYwSk93MFgzV3d6NXlUYTln?=
 =?utf-8?B?WjNSaTNMR3BLeE0xcHVxUFprcGZrd0lRaVN3MXgxTC9rZEhDWkdKN2pMYVli?=
 =?utf-8?B?TG9jdWZuaWhpL0tRWVJzOTFYa0lqd281RkFFZ2p6QWNpc1B2bTBIVFpUQ0VO?=
 =?utf-8?B?SkRNanp2OVdqcThocW1YRTlwbUZoQUZ2cWZDWEFaRWFiSHZQNElld1dZSTVB?=
 =?utf-8?B?bEFxWVBQYXV5OTR3U25OUHJOcTdWQmk4Um5pZFBLUGMwZWhrRXQ4SjZnaC9W?=
 =?utf-8?B?dlpPL1JTc3FFNklEVnc1QUQ0dCtNMnp4d0tTbTkzK3FnOFBRRXNCeE1nVFJi?=
 =?utf-8?B?OTJSdDk0ZGgvcFBVQjI2eWRjSUtVSkZuSlNTeHlWNnZmVTBKMTBzazlhTnhU?=
 =?utf-8?B?bFhJMm1sWmhtTm5HS0dHWGRWeHRJdU8vSG43Sjk4OHBCeXpIK3ZNNkVyWDRn?=
 =?utf-8?B?TjM2N0xPMnNSNzdqVW5ibUVLRXNQV0w0dzlEU2w3VVgrbXgxVUZyNHAyODY2?=
 =?utf-8?B?MVl4L0E3WTRzZG1uZitVVmo0eGhXQm4zK25mV1FDdjRZMVNiaXBNQ3VZWm9Y?=
 =?utf-8?B?MHFDWHRlY3NJajB4NjlCYXA1UTdQMVVZMVBNZVJpRXU2d0ZBa0VNL2dkTUhp?=
 =?utf-8?B?dTZoUThZdUUvbFlKV0FPOWVmcWcxaXdiVDMzTjBkZGVSUzk5YjgxeUdJajk2?=
 =?utf-8?B?bmdGQWQ0TjRWRGhuSUMyN3pRbnEvSnBHKy8rWmYwYTI0ZVpqZnh5T1ZyaEs0?=
 =?utf-8?B?L1RENnRSbTBQUGlDYUdIK00xOUx4WE9SNjI3WjBOdktOYmdmMDNQbnJkdG9T?=
 =?utf-8?B?d2M2QXdjZGFySmV0c29rSUIzN1UwekFFNk1LYjRsa0pqbnd6NGJDUEQ4djBZ?=
 =?utf-8?B?dzRmbjdac1F0bnp1TUlLdTVxaHdHdytCaElnZGtjL0pLZjVmK3RMSGF3SWNm?=
 =?utf-8?Q?1ZfsPPgygcuf/19XgW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zMyhC4aOkNMKOjEtsNQNeUstQScXl7YLVXGes6oCk7+Eskupa8ullXz+iWUdX7OK62jRm7Q2Wmnv3lRoZF9+EpsiEaw8NLDGR7lcm8MKxQYbQQ0gHPSeVYY6ykQxO+E6f3BgMCH7a+77uKkBtvs8/YEY0LEZi+x0Nqrj8Dfhh2lowuH1JA87KFD7uU7WUrF66qnicJSwAzobnWmokr3CoFEWCm3SzlGoAb9LJVQW09FamV20hpVEnHoXSQbcfV8jU5DJPQYdhyjUdBSPDWfp5VyJ/InhbCD9o1mK+b36aMqHFXd8qo/twc+ZI/tQ3KoqhQjEkVdCx0oa1YfT4Q+uSA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22778bec-1665-4918-29de-08df18b68fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 14:34:08.4395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xApvT+4K38dUjg16eO9Z1RGj3RgOASSjFZkVQTldKVrNqPCePJbUab0wqpiR9ZqapLuZ5B1XzyV4kSnPq+axZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
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

SGkgQEpvb25hcyBMYWh0aW5lbiwNCg0KRm9yIFJDUyAtPiBVTlNFVA0KRm9yIENDUw0KMS4gT2xk
IGNvbXB1dGUgcnVudGltZSAtPiBVTlNFVA0KMi4gTmV3IGNvbXB1dGUgcnVudGltZSAtPiBVU0VS
DQoNCklmIHdlIHRha2UgdGhlcmUncyBvbmx5IG9uZSBjb21wdXRlIHJ1bnRpbWUgdmVyc2lvbiwg
YW5kIHByaW9yaXR5IFVTRVIgPiBVTlNFVD8gIFdoZXJlJ3MgdGhlIGNvbmZsaWN0IGNvbWUgZnJv
bT8NCg0KQnV0IGlmIHdlIHRha2UgdGhlcmUncyBtb3JlIHRoYW4gb25lIGNvbXB1dGUgcnVudGlt
ZSB2ZXJzaW9uLCBhbmQgdGhlaXIgcHJpb3JpdHkgaXMgZXF1YWwsICBVTlNFVCBjYW4gY292ZXIg
VVNFUiwgIFVTRVIgY2FuIGNvdmVyIFVOU0VULCAgZXZlbiB3aXRoIHR3byBjbGllbnRzIHRoZXkg
Y291bGQgY292ZXIgZWFjaCBvdGhlci4NCg0KV2Ugc2hvdWxkIHRha2UgaXQgZWFzeS4NCk9uY2Ug
d2UgcmVhY2hlZCBVU0VSLCBzZXQgYnkgbmV3IGNvbXB1dGUsIHdlIHNob3VsZCBsYXRjaCBpdCwg
Zm9yIHRoZSBXQSBoYXMgYmVlbiBpbXBsZW1lbnRlZCBieSBVU0VSLg0KDQpUaGFua3MsDQpKaWEg
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9vbmFzIExhaHRpbmVu
IDxqb29uYXMubGFodGluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRl
bWJlciAyMSwgMjAyNiAxMTo0NyBQTQ0KPiBUbzogWWFvLCBKaWEgPGppYS55YW9AaW50ZWwuY29t
Pjsgc2FzaGlrby1ib3RAa2VybmVsLm9yZzsgc2FzaGlrby0NCj4gcmV2aWV3c0BsaXN0cy5saW51
eC5kZXYNCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IFJvcGVyLA0KPiBNYXR0aGV3IEQgPG1hdHRoZXcuZC5yb3Bl
ckBpbnRlbC5jb20+OyBUdnJ0a28gVXJzdWxpbg0KPiA8dHVyc3VsaW5AdXJzdWxpbi5uZXQ+DQo+
IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjldIGRybS9pOTE1L2RnMjogQWRkIHBlci1jb250ZXh0IGNv
bnRyb2wgZm9yDQo+IFdhXzIyMDEzMDU5MTMxDQo+IA0KPiBRdW90aW5nIFlhbywgSmlhICgyMDI2
LTA5LTIxIDIwOjMzOjAzKQ0KPiA+IEhpIEBMYWh0aW5lbiwgSm9vbmFzLA0KPiA+DQo+ID4gVGhl
IGtleSBpcyBMU0NfQ0hJQ0tFTl9CSVRfMCBpcyBhIGdsb2JhbCByZWdpc3Rlci4NCj4gPg0KPiA+
IEV2ZW4gd2UgdXNlIHBlci1jbGllbnQsICB3ZSBzaG91bGQgY29uc2lkZXIgdGhlIGZvbGxvd2lu
ZyBjYXNlczoNCj4gPg0KPiA+IDEuIFNob3VsZCBjb25mbGljdGluZyBjb25maWd1cmF0aW9ucyB3
aXRoaW4gYSBjbGllbnQgYmUgcmVqZWN0ZWQ/DQo+ID4gSSByZWNvbW1lbmQgdGhlIGZpcnN0IHNl
dHRpbmcgc2hvdWxkIGJlIGxhdGNoZWQuDQo+IA0KPiBGcm9tIHVBUEkgcGVyc3BlY3RpdmUgaXQg
d291bGQgYmUgc2ltcGxlciB0byBzZXQgdGhpcyBhdCB0aGUgRFJNIGNsaWVudCBsZXZlbCBhdA0K
PiBvbmNlLiBIb3dldmVyIHdlIGRvbid0IHNlZW0gdG8gaGF2ZSBzdWNoIHVBUEkgaW4gYWN0aXZl
IHVzZSBjdXJyZW50bHkgKGFsbA0KPiBkcm1fbm9vcCkgc28geW91J2QgaGF2ZSB0byBjb21wYXJl
IHRoZSBjb21wbGV4aXR5IGJldHdlZW4gaW5kaXJlY3RseQ0KPiBzZXR0aW5nIGl0IGF0IERSTSBj
bGllbnQgbGV2ZWwgYnkgZmlyc3QgY3JlYXRlZCBjb250ZXh0IG9yIGFkZGluZyBzdWNoIGFuIHVB
UEkgdG8NCj4gc2V0IGl0IGV4cGxpY2l0bHkgcGVyIGNsaWVudC4NCj4gDQo+ID4gMi4gU2hvdWxk
IGNvbmZsaWN0aW5nIGNvbmZpZ3VyYXRpb25zIGFjcm9zcyBkaWZmZXJlbnQgY2xpZW50cyBiZSBy
ZWplY3RlZD8NCj4gPiBJIHRoaW5rIHRoZSBsYXR0ZXIgc2V0dGluZyBjYW4gY292ZXIgcHJldmlv
dXMgb25lLg0KPiANCj4gRFJNIGNsaWVudHMgbmVlZCB0byBiZSBpbmRlcGVuZW50IGZyb20gdGhl
IGRyaXZlciBwZXJzcGVjdGl2ZSwgd2UgY2FuJ3QgZG8NCj4gdGhhdC4NCj4gDQo+IFRoZSB3aG9s
ZSBwb2ludCBvZiBtYWtpbmcgaXQgcGVyIERSTSBjbGllbnQgaXMgdGhhdCBnaXZlbiB0aGUgaW1w
YWN0ZWQgU0tVDQo+IG9ubHkgaGFzIDEgQ0NTIGVuZ2luZS4gV2UgaGF2ZSB0aGUgYWRkcmVzcyBz
cGFjZSBtYXRjaGluZyByZXF1aXJlbWVudA0KPiBiZXR3ZWVuIENDUyBhbmQgUkNTLCBzbyB3aGVu
IGJvdGggQ0NTIGFuZCBSQ1MgYXJlIHJ1bm5pbmcsIHdlIGtub3cgdGhleQ0KPiBiZWxvbmcgdG8g
dGhlIHNhbWUgRFJNIGNsaWVudCBhbmQgdGh1cyB0aGV5IHdpbGwgbm90IGNvbmZsaWN0IHdpdGgg
dGhlIFdBDQo+IG1vZGUuIEFuZCBpZiBvbmx5IG9uZSBvZiB0aGVtIGlzIHJ1bm5pbmcsIHRoZXJl
IGNhbiBiZSBubyBjb25mbGljdCBlaXRoZXIgYXMgaXQncw0KPiBqdXN0IG9uZSBjb250ZXh0Lg0K
PiANCj4gPiBFdmVuIGxpa2UgdGhpcywgc3RpbGwgY2FuJ3QgY292ZXIgYWxsIHRoZSByYWNlIGNv
bmRpdGlvbi4NCj4gDQo+IFdoaWNoIHJhY2UgY29uZGl0aW9ucyBkbyB5b3UgdGhpbmsgd291bGQg
cmVtYWluPyBXZSBkZWZpbml0ZWx5IGhhdmUgdG8NCj4gZWxpbWluYXRlIGFueSByYWNlIGNvbmRp
dGlvbnMgdG8gbGFuZCB0aGlzLg0KPiANCj4gUmVnYXJkcywgSm9vbmFzDQo=
