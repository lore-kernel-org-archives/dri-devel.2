Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE99CD4F47
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109DE10E296;
	Sun, 17 May 2026 18:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OLi+9a77";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEF610E296
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779041515; x=1810577515;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=TWJHydl649xnSWiNQ0DZnhbDvlfZ8JltpbF/62E0Y+Q=;
 b=OLi+9a77UWlOvmBitFnLjSrtSl9UTeuxO9rXj2jFm+6PfW4Rr/2NFm97
 03YM+i1TigOuV8zfoq/qRPWkQNFcaNYMVh8giChc1IaJ0WxNrxzx6EJWV
 tAhSALsTYJsafganvmOxFaPKLIoiAPxyVzD/sO49pIRZdbcKwgxelWh46
 36JLf3q9+fzeShOh676HC/SChrikf3u8iH18VgAEf4Zrrm+qm/hY0wil/
 EMz0+8Es4f2UdTv64FVMtGuUcwqNnzi40pHNrrj0enVnbLr1WXVvX4NPN
 6ZYOwxRUyn1xkDHLAn6Pp9nKtjQKx55LKtEJ9/J6xb423Zhit82RKhv8T g==;
X-CSE-ConnectionGUID: 1uuASMV7RHaBMfMjHE6u+w==
X-CSE-MsgGUID: SA1YXiVcQY+0mzGRnOXEuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="82470305"
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; d="scan'208";a="82470305"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 11:11:54 -0700
X-CSE-ConnectionGUID: Awhv5NP1SCeSJKx8yxU7JQ==
X-CSE-MsgGUID: cn/fpRlpQ+qh0Q76JSB2jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; d="scan'208";a="262730586"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 11:11:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 17 May 2026 11:11:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 17 May 2026 11:11:54 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 17 May 2026 11:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNhlueGU6LUjB7YJISiZYKP9GvB8jv+aqEVi3gYyTm+PIToRg6QKZMfHK5r/f2N/1QXHyrxVffPCqhWqq78c0ds8A/lCq0eQc58dUK1jl8BX3SN/vydchUQo2dCYWFGWgftMrlxGkuIrlwmm3z48+AKEXVqbZQP5ZcgzfSVUllUTpndUwlNf5dq8R6TT8WOuxfYJ40EQnZBb8OKgWUpwrKyAH0ovOJAcMCna/ePfuFkhxyAEJnNqbK7+5Ej5jc3Y7nkFVXx5jmHIsBjCcBQLYe7XDbr8V21xSJNSi9MNWzR7TMHksrWVNfkDkndQ1W0d1rx8G+E0hksgtDyX0lrh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWJHydl649xnSWiNQ0DZnhbDvlfZ8JltpbF/62E0Y+Q=;
 b=W7b2A7dYKieZo7Jr7v7d2ga1g8LwoXNKBkAENU3xvjLuEEbhJb+oe+7J8uoRywQtsYEURUvie3KcTSl0BM6ikuLgK3OaVmvV4FszQ0xoD6j0W4lujM8cVDBHrLQXVkyWjFQgVPaawqV0RHdCZWXzAsrkhLx0N1kwt2ZhSPQMZ9ArsV1gqoEPkI52iYWQgij6ZvA7KOqswnbXQFad0AJGt9vYI706+u5uyBgd3kfa/VWUlrWUiotkl5qGbspDc+PipecIL75XeN+yvcPm8hsWgkyM9aWQStlemnhZYkOIJzjmnrIP0hv5ZGjHKAq8ics9tSJ2FB525RgWkC5gjzUFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by IA1PR11MB7320.namprd11.prod.outlook.com (2603:10b6:208:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sun, 17 May
 2026 18:11:52 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.20.9913.009; Sun, 17 May 2026
 18:11:52 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>, "kraxel@redhat.com"
 <kraxel@redhat.com>
Subject: RE: [PATCH v8 0/3] Virtio-GPU S4 (hibernation) support
Thread-Topic: [PATCH v8 0/3] Virtio-GPU S4 (hibernation) support
Thread-Index: AQHc5ihQz3M8s9vL30mm7APkVbOd1rYShHcw
Date: Sun, 17 May 2026 18:11:52 +0000
Message-ID: <PH0PR11MB5112E393E66E0B7C5AE322C0FA022@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <10895864-b440-4ed9-b9d9-a6f63f1ba10b@collabora.com>
In-Reply-To: <10895864-b440-4ed9-b9d9-a6f63f1ba10b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|IA1PR11MB7320:EE_
x-ms-office365-filtering-correlation-id: ba29610a-951f-4c57-188b-08deb43fc586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|4143699003|11063799003;
x-microsoft-antispam-message-info: Gtgm+OLoJbOotKtx1WvQ1JjJ8wWdpcwAl4YkQssqbj59S1DwMFQzEiiupFOf9f4K/TThHQaz4ZWs2JVRpZ97UGI5c6Va8sytWCm6TfKT8aQldmT39wttsPVrPHzTbVM2xSvT/Zspa85dPaLviF10YVDahRuRXU228qgQ8ZxslBPPIjeeo8ydpkaEpnMeLtBCZvwoyD07OSyp9JKV0/FKz5/ZpLaqY1zvoK5YH06tkE/JtJGobcsn5dqkdyCt0Vc4yBemgVM+XyF+ipM0ji78ByOAJ74LNX7V4L4NtowLjXN5YOUO0opEY4PiAboC+RbGkqaMbwpNPekPJfHAZlYP9t/9haCGUjPwc6A9OCoLt9tAaxhmPYsthiIpLbP2L94Rag868t6YHqbf0gQ7bUy+8rodQZKqDZ0k7gJbBF8RNamOyvk5OIAyoigLHsLVHC0AQF+gxseELoNEnOoCI1qXvfOUnMSOfFLLXX+wgRZbLohfHUIqec9XyUMGYY4FvMF4UF4Zfkq+0KHbrZx7OnuGJ5qoXvy1oLCnMJ6vz7u3D2gN5qHt3ru1QbddqPAoR29oKjdjwOwBkiOI6/xtccYArPMdDxa8Ycx6/Z9NPhIo7L7tT5/4HuYD6OHcOXbJ4DCZKJVd1HS+M1mx4qsyNmb+ZRCVC9PtKMRUUWzuBk9s/9r873NYbT/ibfKRE02NzlZNb4h+pOznMrYSIrFdrIAYIrUjhptJlpGP6FYyOJ3xJ1KvZiVkiPk/m9K+1VkRw6Jn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0JQK0NkZHdzMVR4eXc4VkJ0QXo2K3QwaHR6SDhnY2l5cnJnZHhRbDBrTldo?=
 =?utf-8?B?dWFBcktxVnZ2VnlVWlF0VitXM3RmSUtXVHQrdnlOd2Q5K3pBcWRab2tMNUd5?=
 =?utf-8?B?cjVWd3RxMmlkeXc2T3ZKWmZGT3JFc0U3RXZqREtRT1VoOWVFL1lVZ3puUkFm?=
 =?utf-8?B?T0k3Rkw3WmtUR0txRGJuU0N4SFRFNWNnaCtuU3hWenQzQ2cvMVJFWUo0NERF?=
 =?utf-8?B?elo1TzFxc3hCWkZXY3RLRmNPMFRKVWQvdGMyRXY1Vngrbnp0TExEZHBNWmVO?=
 =?utf-8?B?Sk5YWTg0UFhsdE4wL2ZXbE9tUkxtQkxKSzdLOHllWWR1d0h6RklZeVpJUWVn?=
 =?utf-8?B?OU9ucUVQd0E5cTFUSlQrV2I4Vmk0TU45NUNROHRidm5Ic2R3dTY3bXhuUzQ4?=
 =?utf-8?B?VUdSTDljU0RFVWpRVEozUHJxQXoxeHZNa044RUFqSnRUbDFQK1gvZlZWL2VN?=
 =?utf-8?B?RVRvNnl0Ky83Q1k0ai9jYURoZHJOSkVRZEY1aXpBbWdUZDBkdTBVWkpueDVh?=
 =?utf-8?B?dFpqQURYcTFnSzZZV3FwN3ZSNXh1VE1BQ2ZTYUk4dmJ2S1phV2NpOEw1eXVD?=
 =?utf-8?B?SmRsTXlaK3ZoaVN0ZDVQc0lQUDdtMFlCdGNRUFU5RVhuNFk4ci9yT044WmtH?=
 =?utf-8?B?b3BCNnpJRE9naDllVlVXQVhVK0dWdzJQTU1DLzlqTWdNc3pJSzNwTkhQZ25E?=
 =?utf-8?B?NklDTVFSblpyMWFOWlJzeS9Oczd2VUNsa2RCR1lBdGo5eVF3czA3WHN4em51?=
 =?utf-8?B?SWlSWlRlNktPdmhHTDh5d0MxMDBDd1hMaGJWaHc5UlBNN3QwODM5aE05ZnBw?=
 =?utf-8?B?RG5Lb0ltdXlzMFFKS1l4NnVGaDdwSlBxSTVtOEVQV0hrK0VFK2VFdWx2ZjNk?=
 =?utf-8?B?bmtrK2VVV1R4c0gyZGRUSkUvaEVPNzdEbjFRazFWeVhhYkQ3Vm9xckxmWXlt?=
 =?utf-8?B?NHFwN2tyL0VCMzBuSk9XWU1UejZxSWIzbms1cm5TM25tWC9kYmhORTB6L1dQ?=
 =?utf-8?B?WlczQk9zN1B1Y1JRc1ppUEtCN25WZi9yU3pPcFkyaGwrV3hXNXNyUm1uZ2F6?=
 =?utf-8?B?ZWNmUVJTTEJGVVBCOGxNNm4xM2lLeHB6dFFCUUhGcXhtemtHU3lVcnU4anJ1?=
 =?utf-8?B?UnZGWUZHcHRsSklEWXlOZjZvcVZ3dno0VlBxSW5BRjVxTmxSUlBTVVIveWlS?=
 =?utf-8?B?Lys4ell1MUVjQlk2YWtsZXg5Z2hzUjdZZTVGNEFYZ0tIakw1QS9KZFJHM09q?=
 =?utf-8?B?MlRkcE0vRVpTWWI2c0J6aUU2S3NIczlVdnpjeEVLREFwekJqbGtLT3lMVFZF?=
 =?utf-8?B?OFllWGxZQ0w0cnN0Z2dCMFNUc2J6WHhUTGJiUHBuTWVUU2Y2OHMxSUh0R0ln?=
 =?utf-8?B?TGJsM3kxK2NmRy91QTVGcUExelZleXJUa29URkx3b0lJTzBlTjRLc0lxTHJM?=
 =?utf-8?B?Z1Q3TWtGWml4eGRXY2pjVE9PTG1HTzZodEVUZjFhUlJZY1U2ZXhpL2FvUXJ2?=
 =?utf-8?B?ZzIvc0NTbE5maDN0M0lMcHZWOWJOTUwra3hGUS90QnBlZzJ6VkJONFNKMUNx?=
 =?utf-8?B?QmM1QjZ3SnNOYVNjUld2SWNwVVpIY3dnT0Y5WE5BcmpDUVJrSEtaa0xjR0hQ?=
 =?utf-8?B?UW1TdkdsVERvUFdkTGVwQVJtQTYwOTYxQ2N0K3djcHFteDh0NTA5THovY3Ji?=
 =?utf-8?B?eHhGcWJ6RTV1OFdCTHdsd2s3MmJNbG5NYzg5a2hNbklEdGoxc1ZQbmJDVFZp?=
 =?utf-8?B?Zlg3T3dDTVE1VmM1bnJNeUpHQTdTdFNVRGszZDhkZmgzMG9kVWk4TVlBWVlX?=
 =?utf-8?B?OXVKbDNWMGY2ZWdpM3liVGJTeUhPbEhIM3Bvdng2bGhkejBielFZWGlqYjdB?=
 =?utf-8?B?WEVSSk1GZmNzMWczYUpNSXVTdzMxQXhvTXluKzd5bW9NMEpaSHRkcFlqVTB2?=
 =?utf-8?B?Rkk3UERrTmNUSTZJVDYzb1N4WkdCUlF0clBKVGx2bkJWK1YzaHhHdzZ0TEs0?=
 =?utf-8?B?cUhwZFJIeU5wQWZFS3NNTG9zU0NLUUh4L2x6cS8yVHRRZDhTN2JsVm5LVjRZ?=
 =?utf-8?B?TWlBcnlTbzY2Y0paMzAzdnlWaEtpT0RHWVF2OHA0Yk5tb3BJVDlpWlJhREdp?=
 =?utf-8?B?alA4eUsySE5hYlJMMFQzR0V4YmFocEVCTDloc1h5K1JCcStsd1VHM3hybVdm?=
 =?utf-8?B?R2JNTE9qbEJObCtPdHZ2RU1OTEhlRVIxWEh2U2tmeVRHUU5FYVdqbnAwL3Jx?=
 =?utf-8?B?dFgyRDlDYWs5U0pLYkJBbXRrZDJxaUdsMXJleFFqSnhSblF5clNrdlB2Y1Fk?=
 =?utf-8?B?czZCWjNUTTVLOUJUd3R0VFU5WGs0OG84RnE3YjVvUzRMU0R2SHRCZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qae19NquPm1FaBXcoNmsNy4SD+Yob73+8pLzzUfBQlxNqBxCN2oXHAOv+iJ2eBRsV7KeJQm4LwiLGPe+0fPnskqmeWZJcrAsoVlZGPmF2MAPcM3ngebICAGuphaFsQod+1FAKb+Pqstz5HpjXpFfPeTQ19si6s0J40Z8QTDyNAABgw5V/BwL00YOCuZ9DuoGd+ipLYwyk9fkCvkXiSrwtgiPYYkqctTG83yxzv1gf74HJlIy6cjYCYWX2tPJimXXz7Ecly1fmXafJIx1HWdLvItf/h5z0l0SenE4tHXh4nSy0RFfsNfBXZH5uDHrBZ7E27O3FbV+ifd2gp0OU9UXLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba29610a-951f-4c57-188b-08deb43fc586
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2026 18:11:52.2007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvgkccV4micHI6UrdexWL+MI3dCmkJdu/438uLnznjFRMm+r9XkEHK5kTnHY23cizOnF8KWCv/Q1Ur3YZX4qEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7320
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

SGkgRG1pdHJ5LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMC8zXSBWaXJ0aW8tR1BVIFM0
IChoaWJlcm5hdGlvbikgc3VwcG9ydA0KPiANCj4gSGksDQo+IA0KPiAyOS4wNC4yMDI2IDIzOjQ3
LCBkb25nd29uLmtpbUBpbnRlbC5jb20g0L/QuNGI0LXRgjoNCj4gPiBGcm9tOiBEb25nd29uIEtp
bSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW1w
bGVtZW50cyB0aGUgLmZyZWV6ZSBhbmQgLnJlc3RvcmUgaG9va3MgZm9yIHRoZQ0KPiA+IHZpcnRp
by1ncHUgZHJpdmVyLCBhbG9uZ3NpZGUgYSBQTSBub3RpZmllciB0byBtYW5hZ2Ugb2JqZWN0DQo+
ID4gcmVzdG9yYXRpb24gZHVyaW5nIFM0DQo+ID4gKGhpYmVybmF0aW9uKSBjeWNsZXMuDQo+ID4N
Cj4gPiBUaGUgc2VyaWVzIGlzIHN0cnVjdHVyZWQgYXMgZm9sbG93czoNCj4gPg0KPiA+IDEuIFRo
ZSBmaXJzdCBwYXRjaCBpbnRyb2R1Y2VzIGB2aXJ0Z3B1X2ZyZWV6ZWAgYW5kIGB2aXJ0Z3B1X3Jl
c3RvcmVgLiBUaGVzZQ0KPiA+ICAgIGZ1bmN0aW9ucyBoYW5kbGUgdGhlIHRlYXJkb3duIG9mIHZp
cnRpbyBxdWV1ZXMgYmVmb3JlIHN1c3BlbnNpb24gYW5kDQo+IHRoZWlyDQo+ID4gICAgc3Vic2Vx
dWVudCByZWNyZWF0aW9uIGR1cmluZyB0aGUgcmVzdW1lIHByb2Nlc3MuDQo+ID4NCj4gPiAyLiBU
aGUgc2Vjb25kIHBhdGNoIGltcGxlbWVudHMgYSB0cmFja2luZyBhbmQgcmVzdG9yYXRpb24gbWVj
aGFuaXNtIGZvcg0KPiA+ICAgIGB2aXJ0aW9fZ3B1X29iamVjdGAgaW5zdGFuY2VzLiBUaGlzIGlz
IGVzc2VudGlhbCBiZWNhdXNlIHRoZSBob3N0IChlLmcuLA0KPiBRRU1VKQ0KPiA+ICAgIGRlc3Ry
b3lzIGFsbCBhc3NvY2lhdGVkIGdyYXBoaWNzIHJlc291cmNlcyBkdXJpbmcgdGhlIHZpcnRpby1n
cHUgcmVzZXQNCj4gPiAgICB0cmlnZ2VyZWQgYnkgdGhlIGhpYmVybmF0aW9uL3Jlc3VtZSBjeWNs
ZS4NCj4gPg0KPiA+IDMuIFRoZSB0aGlyZCBwYXRjaCBhZGRzIGEgUE0gbm90aWZpZXIgdG8gaGFu
ZGxlIHRoZSByZXN1Ym1pc3Npb24gb2YgdGhlc2UNCj4gPiAgICB0cmFja2VkIHZpcnRpby1ncHUg
b2JqZWN0cyB0byB0aGUgaG9zdCBvbmNlIHRoZSBndWVzdCByZXN0b3JlcyBpdHMNCj4gPiAgICB2
aXJ0cXVldWVzLg0KPiA+DQo+ID4gVG9nZXRoZXIsIHRoZXNlIGNoYW5nZXMgZW5zdXJlIHRoYXQg
dGhlIHZpcnRpby1ncHUgZHJpdmVyIGNhbiBzdXJ2aXZlDQo+ID4gaGliZXJuYXRpb24gd2l0aG91
dCByZXNvdXJjZSBsb3NzIG9yIGludmFsaWQgcmVzb3VyY2UgZXJyb3JzLg0KPiA+DQo+ID4gdjI6
IC0gQWRkZWQgMTBtcyBzbGVlcCBpbiB2aXJ0Z3B1X2ZyZWV6ZSB0byBwcmV2ZW50IGxvY2t1cHMg
ZHVyaW5nDQo+IHJlc3VtcHRpb24uDQo+ID4NCj4gPiB2MzogLSBSZXBsYWNlZCB0aGUgZml4ZWQg
MTBtcyBkZWxheSB3aXRoIHdhaXQgY2FsbHMgdGhhdCB0cmlnZ2VyIG9uY2UgdGhlDQo+ID4gICAg
ICAgdmlydGlvIHF1ZXVlIGlzIGVtcHR5Lg0KPiA+ICAgICAgIChEbWl0cnkgT3NpcGVua28pDQo+
ID4NCj4gPiB2NDogLSBMaW1pdGVkIHRoZSBzY29wZSB0byBTNCAoaGliZXJuYXRpb24pLiBTMyBy
ZXNvdXJjZSBsb3NzIGNhbiBiZSBhdm9pZGVkDQo+ID4gICAgICAgdmlhIFFFTVUgY29uZmlndXJh
dGlvbnMgKGUuZy4sIHgtcGNpZS1wbS1uby1zb2Z0LXJlc2V0PXRydWUpLg0KPiA+DQo+ID4gdjU6
IC0gSW1wbGVtZW50ZWQgcmVtb3ZhbCBvZiBvYmplY3RzIGZyb20gdGhlIHJlc3RvcmUgbGlzdCBi
ZWZvcmUgZnJlZWluZyB0bw0KPiA+ICAgICAgIHByZXZlbnQgYSB1c2UtYWZ0ZXItZnJlZSBzaXR1
YXRpb24uDQo+ID4gICAgICAgKE5pcm1veSBEYXMpDQo+ID4NCj4gPiAgICAgLSBQcm90ZWN0ZWQg
cmVzdG9yZSBsaXN0IG9wZXJhdGlvbnMgd2l0aCBhIHNwaW5sb2NrLg0KPiA+ICAgICAgIChOaXJt
b3kgRGFzKQ0KPiA+DQo+ID4gICAgIC0gTW92ZWQgdGhlIHJlc3RvcmUgbGlzdCBub2RlIGludG8g
dGhlIHZpcnRpb19ncHVfYm8gc3RydWN0IHRvIG9wdGltaXplDQo+ID4gICAgICAgbWVtb3J5IHVz
YWdlLg0KPiA+ICAgICAgIChEbWl0cnkgT3NpcGVua28pDQo+ID4NCj4gPiAgICAgLSBSZW1vdmVk
IHVudXNlZCBoZWFkZXI6IGRybV9hdG9taWNfaGVscGVyLmguDQo+ID4gICAgICAgKERtaXRyeSBP
c2lwZW5rbykNCj4gPg0KPiA+IHY2OiAtIEFkZGVkIHN1cHBvcnQgZm9yIG9iamVjdHMgYmFja2Vk
IGJ5IGltcG9ydGVkIGRtYS1idWZzLg0KPiA+ICAgICAgIChEbWl0cnkgT3NpcGVua28pDQo+ID4N
Cj4gPiAgICAgLSBFeGNsdWRlZCB2aXJnbCAzRCBvYmplY3RzIGZyb20gdGhlIHJlc3RvcmUgbGlz
dCBhcyB0aGV5IGFyZSBjdXJyZW50bHkNCj4gPiAgICAgICBub24tcmVjb3ZlcmFibGUuDQo+ID4g
ICAgICAgKERtaXRyeSBPc2lwZW5rbykNCj4gPg0KPiA+ICAgICAtIFJlbmFtZWQgdGhlIGxpc3Qg
bm9kZSB0byAncmVzdG9yZV9ub2RlJy4NCj4gPiAgICAgICAoTmlybW95IERhcykNCj4gPg0KPiA+
ICAgICAtIFN3aXRjaGVkIGZyb20gc3BpbmxvY2sgdG8gbXV0ZXggZm9yIHJlc3RvcmUgbGlzdCB1
cGRhdGVzLg0KPiA+ICAgICAgIChOaXJtb3kgRGFzKQ0KPiA+DQo+ID4gICAgIC0gSW5pdGlhbGl6
ZWQgcmVzdG9yZV9ub2RlIGF0IGNyZWF0aW9uIHRvIGFsbG93IHNhZmUgJ2xpc3RfZW1wdHknIGNo
ZWNrcy4NCj4gPg0KPiA+ICAgICAtIEludHJvZHVjZWQgYSAnaGliZXJuYXRpb24nIGZsYWcgaW4g
dGhlIFBNIG5vdGlmaWVyIHRvIHRyaWdnZXIgcmVzdG9yYXRpb24NCj4gPiAgICAgICBhdCB0aGUg
Y29ycmVjdCBzdGFnZSBpbiBgdmlydGdwdV9yZXN0b3JlYC4NCj4gPg0KPiA+IHY3OiAtIEFkZGVk
IGhlbHBlcjogdmlydGlvX2dwdV9hZGRfb2JqZWN0X3RvX3Jlc3RvcmVfbGlzdC4NCj4gPiAgICAg
ICAoRG1pdHJ5IE9zaXBlbmtvKQ0KPiA+DQo+ID4gICAgIC0gSW1wbGVtZW50ZWQgdW5yZWZlcmVu
Y2luZyBvZiBhbGwgaG9zdC1zaWRlIG9iamVjdHMgYmVmb3JlIGhpYmVybmF0aW9uDQo+ID4gICAg
ICAgdG8gZW5zdXJlIGEgY2xlYW4gc3RhdGUgdXBvbiByZXN1bWUuDQo+ID4gICAgICAgKERtaXRy
eSBPc2lwZW5rbykNCj4gPg0KPiA+IHY4OiAtIEludHJvZHVjZWQgdmlydGlvX2dwdV9yZW1vdmVf
ZnJvbV9yZXN0b3JlX2xpc3QgaGVscGVyIGFuZCBlbnN1cmVkDQo+IGl0IGlzDQo+ID4gICAgICAg
Y2FsbGVkIGFjcm9zcyBhbGwgb2JqZWN0IGRlc3RydWN0aW9uIHBhdGhzIChHZW5lcmFsLCBQcmlt
ZSwgYW5kIFZSQU0pDQo+ID4gICAgICAgdG8gcHJldmVudCB1c2UtYWZ0ZXItZnJlZS4NCj4gPiAg
ICAgICAoRG1pdHJ5IE9zaXBlbmtvKQ0KPiA+DQo+ID4gICAgIC0gUmVsb2NhdGVkIHJlc3RvcmUg
bGlzdCByZW1vdmFsIGxvZ2ljIGZyb20gdGhlIGZpbmFsIGNsZWFudXAgc3RhZ2UgdG8NCj4gPiAg
ICAgICB0aGUgaW5pdGlhbCBmcmVlIHN0YWdlIGZvciBpbXByb3ZlZCBzeW5jaHJvbml6YXRpb24u
DQo+ID4gICAgICAgKERtaXRyeSBPc2lwZW5rbykNCj4gPg0KPiA+ICAgICAtIEFkZGVkIG1pc3Np
bmcgZHJtX3ByaW50LmggaGVhZGVyLg0KPiA+DQo+ID4gRG9uZ3dvbiBLaW0gKDMpOg0KPiA+ICAg
ZHJtL3ZpcnRpbzogRnJlZXplIGFuZCByZXN0b3JlIGhvb2tzIHRvIHN1cHBvcnQgc3VzcGVuZCBh
bmQgcmVzdW1lDQo+ID4gICBkcm0vdmlydGlvOiBBZGQgc3VwcG9ydCBmb3Igc2F2aW5nIGFuZCBy
ZXN0b3JpbmcgdmlydGlvX2dwdV9vYmplY3RzDQo+ID4gICBkcm0vdmlydGlvOiBBZGQgUE0gbm90
aWZpZXIgdG8gcmVzdG9yZSBvYmplY3RzIGFmdGVyIGhpYmVybmF0aW9uDQo+ID4NCj4gPiAgZHJp
dmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X2Rydi5jICAgIHwgNzQgKysrKysrKysrKysrKysr
KysrKystDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuaCAgICB8IDI0
ICsrKysrKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X2ttcy5jICAgIHwg
NTQgKysrKysrKysrKysrKy0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9v
YmplY3QuYyB8IDg4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrLSAgZHJpdmVycy9ncHUv
ZHJtL3ZpcnRpby92aXJ0Z3B1X3ByaW1lLmMgIHwgNDUNCj4gKysrKysrKysrKysrLQ0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRncHVfdnEuYyAgICAgfCAxMyArKystDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV92cmFtLmMgICB8ICA1ICstDQo+ID4gIDcgZmls
ZXMgY2hhbmdlZCwgMjg5IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0K
PiB2OCB3b3JrcyB3ZWxsLCBsZWZ0IGNvdXBsZSBtaW5vciBjb21tZW50cw0KDQpJIHdpbGwgc2hv
cnRseSBjb21lIHVwIHdpdGggdjkgd2l0aCB5b3VyIHN1Z2dlc3Rpb25zIGFwcGxpZWQuDQoNCj4g
DQo+IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gRG1pdHJ5DQoNClRoYW5rcywNCkRXDQo=
