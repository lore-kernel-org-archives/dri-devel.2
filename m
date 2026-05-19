Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643B9CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 18:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCC810E1BE;
	Tue, 19 May 2026 18:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WE2CiEYn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D757410E1BE
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779215333; x=1810751333;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=37s1FTX9BmWydsHyCcaoT0jErWDcDL/N78GZILFXw0I=;
 b=WE2CiEYnfnXHBBQDYZCEmhNmBGj9xHpEP3H8ZvUyiy9JWpF1rf5LskDE
 9WZxXwEElZZJVMh2xHmDVMhaZai/2WzUYy96CzyLBOPw+yWifvfU8D06v
 wDagZHV0UdZ+CYFLWLkoqaLGhICAhSFoRr5FuMgC5KkunqSC8rqCjRw7N
 tZ9pudBWuSfbgaEsimtk8V8HGVD2y55nlawvzZHuGSkqH5TE3lMXCiL9i
 4oeMr2gIADnZi+V+hIrfj3RURqYJE3Qq5IhISdv50agDX/DB/yF9ELMmQ
 YwScloNFlTm8PBZPgjid1mJ0GTELba6YLvX39vS84IMf6vEw8jhQ2xtUd g==;
X-CSE-ConnectionGUID: mtTNsZtfRc6ABgQ0mPqpcw==
X-CSE-MsgGUID: PAw+HyeFSiKJMsDV7z4kQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80135336"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80135336"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 11:28:52 -0700
X-CSE-ConnectionGUID: kRbm7EFuQJyaw9+TPqmwZQ==
X-CSE-MsgGUID: lwT2wWOUQd6WxJBmJn/3JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244844841"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 11:28:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 11:28:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 11:28:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 11:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEwpGdLdbAXL0Ptk1L7+0W6egqbU2aMwN2jFwvILb0Wcn744xfu1vZ/Mw4pxv5tNDWAyzPCnPQy+c8g+y+KutBCeeG9oUbKVYRp4eeMVylujYweOqdaV29G6TZAmCZ64aDRBOc5l1ryXsRxhNblQ3lphFhYajXF787+Q9YffO1JJDJ6RM6eXpJuJMD1L8oVl0HD6O1hKMJGfR/0XN8jHACuKUAmA443rhIM6yvHCPP9TZz/JPqIFnkTWoldYfmHRZ+SJmCYNFsb+tHwwgdStjyGbRxN0cfe2P0wfn0t2VWMF1OBneQT2Hu8GBzZia43JXDlVlYqabtv3RJhQjxAy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37s1FTX9BmWydsHyCcaoT0jErWDcDL/N78GZILFXw0I=;
 b=QnQMIf8pTtm1rWkDmamZyLtTWnJ5MB0tLDN3KqtdghxbzAbv5jEukGCKxQ1HNatFY1W+gl9mUbkopCME1KXggBK166xHzFZU/PfbjO46diYFuCn1hMSQhiixUg0OfrPRD37H6FnTBeoyOxkz0eIdHFvovicBSFzG06vq6dhQsJzDpFgUg5fGYvz0KfShopQm5mjWCKkuF2Mcc4mASS/5pxaZ/S6XW6YvyMJlFg7a3QCrGJ49KdsJZVH3seEDtOtDNAZfjj2CgfGlIKyrikUmiaNMjL45jKOS6uTpEXlHYDA+kdNu99QjkS+MnLjRMs1k1eLRlNaJWzBCH8ooFOzfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH8PR11MB9771.namprd11.prod.outlook.com (2603:10b6:510:3a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Tue, 19 May
 2026 18:28:49 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 18:28:49 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>, "kraxel@redhat.com"
 <kraxel@redhat.com>
Subject: RE: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
 virtio_gpu_objects
Thread-Topic: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
 virtio_gpu_objects
Thread-Index: AQHc5ib5WXECW3MZUkCvzhm+J7MqIbYUfjSwgABc6ACAANDVoA==
Date: Tue, 19 May 2026 18:28:49 +0000
Message-ID: <PH0PR11MB511260F7209810CD9569E696FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <20260429204729.993669-3-dongwon.kim@intel.com>
 <4ec04daf-9665-4b15-9e62-b83eb9aaa7c9@collabora.com>
 <PH0PR11MB5112A54866C6888080137302FA002@PH0PR11MB5112.namprd11.prod.outlook.com>
 <8ff5d9cd-62bc-4136-af00-96acd3a2c07f@collabora.com>
In-Reply-To: <8ff5d9cd-62bc-4136-af00-96acd3a2c07f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|PH8PR11MB9771:EE_
x-ms-office365-filtering-correlation-id: a149e189-b205-490a-a175-08deb5d4787e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|11063799006|4143699003|56012099003|22082099003|5023799004|38070700021;
x-microsoft-antispam-message-info: F2pWWQHOc2iKmcwQi9sURX/J73YCNil8vZb2Tyfep3oV0j5xJbP+JVDuZoAs/rYbsX4VpNK+qBqTj1JwkluDpNzDi/cYAoaM9eUeUkso7Qo8W65F/iqLFjGvE+QWZNMREIBevAJnCwwGkSZP5y5TOxGaROLjARxfPm0NGIrCy2o/FW0RE4WjFUP9ZLCf9vU1y+pOYXKUdxruj6COjlQiRp1OXDFxqUBCuojpepaRnL69IDud3hcefg9mepMTKu38t5aWC52Avgp2fA8gVPuwRdfEb+DfBDd/ytI+as6iJC1QkG2OcRI7i3W5P1+JQLwd5ZsMljynZVDzpXrEpP221JJppdC7Rs+4wf2Ca0JnV4EIJSmxY1EGJNQrk4ao3ZRA02/lDauSC/PUixhNopfupovQox9Dwf/YJWRL+pCrpJsAksdKA+KtuOvQEP1rhnAQKDC9RGCmf7n8LwOB9Jt+00vbQBduHeirlfX5MGK9RZC8v/E1HH9fR0xDJCDCluHmVOiKX4TckrvVo+kr7Am2zS6eZbbj4FSNxVtjl9m5xUFsBrhve0mp+18heBqJFpqU/n8F49QArd1sSiv2VKFSp0aVtkJ6eYHGTWonwlICiw0WlaZpUyw9DgjA/zfuWGmANzTdNS5VAclWDTNj/hQ2wx6Rn4XONzdjJMLTl7P57kCslSZh25rrrAj77+5QBxQrot9FZjWelB3tb8pKH8rCkAlF7PGwVqBSXMXU0fJ/lihSfksDTf2+biuZmV1plOJR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(11063799006)(4143699003)(56012099003)(22082099003)(5023799004)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VklCTmYwQmVRWHNBTUUwY3RXM1pMY3pqUlVDZWVxeFNNcEI5OWtyU0l3dWZv?=
 =?utf-8?B?amN5ZlBVNFZmc3hVWGJVdzhWL2xYWkg1VWt5MVoyNW8vTFVJb1RZQUJlN0Rx?=
 =?utf-8?B?NzUxekVJanlkR09mZ1JwZG94amlSdm1TajVpbnB3dDB5cVNHbEZ0SktnZVBq?=
 =?utf-8?B?LzBZeE8vN0dWdHFtWUpjREtDdEdnelVpRlVGZTh3cGlDWGpiTFVTSVBTZ3dx?=
 =?utf-8?B?VEN0bmo3M2tGclh2S2gyUGo3ZTQyZVEzclgyZ0xaaHZtZUpXOS80dXFWa0xR?=
 =?utf-8?B?dG9HUmE2ZExpdi9vcFBxdU1QcVE1Umw4VitEanEvNmlqYnFFNFpLdDVYamNj?=
 =?utf-8?B?SUl6eDB2N3BkR3RIN3lIVmNBNTZ0bzVwVnZ1RURDbExuTGFDZXVidzJYWkpm?=
 =?utf-8?B?amdNRDIxT1M0SkFESUhXNFFDL1o2ZE9uWFRSMXZhTDRSeHNCZGJJZHNDcVpK?=
 =?utf-8?B?bkxNSmc1M0xSc2FZblVPRDZ1VmRLYnZ5U1A5QTFGbHpXL2V4ZzJIOHhjZnB0?=
 =?utf-8?B?WXJ6aW9KcnJuVGJkd1ZpWkJHM1U2MDVOdDNCNDNJTGtGR3hTcmZmenJNUWo1?=
 =?utf-8?B?UEQzK2krWVd2b3pWSllndVpubG5SZHZJQVRVTTErdFJYeEtuTTAwKzF3MnVy?=
 =?utf-8?B?YUcyZjZsckkwaGJ4RnhVakNKZk5RZjh2cENDbFBNQTJ5VnBNa3Z1RjE5Qllx?=
 =?utf-8?B?aEs0c1hYSTM3bDZzaWxYbEdEaTZrd2twL2ROb0s0SzRPQzdKMDFhbk0yR0Zk?=
 =?utf-8?B?Yk0yTmF4cExGcFNrVFo0aVcyNXR1VzRkUE5TdkdIRWdwY3ExdFQwUTRzdk94?=
 =?utf-8?B?WHZ0V0NWNFQ5VVZiemZmNCtoVW9wVGhwclFNLzBYemV5L0prTjJtM05FUjFR?=
 =?utf-8?B?M3EyZHlFL2tUWjdjaldld1gyNmx6SWlLbmo1MzVxYzNzNzFFaWdwQW0wc3FI?=
 =?utf-8?B?Z0tJSFhzOVNxMy9abkMvRjJtUnBOYW9nL1BhZUV6bTJqRGtQTXdtbCt3U2Jk?=
 =?utf-8?B?Tm54bnJ2allncEFvTS92dmtHM3VYUEZieTZjK0lxQ3YzR1J1QXRGdVRBMHdI?=
 =?utf-8?B?QnVxK0FsYUVSbjRjT3ZTYkJ4RmNLOVV4d2NXWmswWFNqSnRkMjU0ZVR6ODc2?=
 =?utf-8?B?Zk04Slg3ZHUrY1dJNDB0UGdhdXpETXFTQkM5WTlCU3pIT2w4QW54T291MGxo?=
 =?utf-8?B?K0g4aDZpLzRvcHA3dTdQRFJYU2tjMUNmRkMvL0k4RVhLdE14NkVIaEdNa2pY?=
 =?utf-8?B?SmQ1YnMxR0pQdzRrRmttQkFqV29XZzNibDVLLzFFMTc5U0s5VVBoaTQ2QVo2?=
 =?utf-8?B?TnNXQy9BKzI0OVJ5M2hpRWFxZ3VPdk9oOWJualBIdnpCcE9IOFRpNkxpUGpS?=
 =?utf-8?B?ZlFTUStYWVp5enNjWHRRRSs4cHlhYjV5M2tIWWxhN1VoczRRSXVuVHI0T0hp?=
 =?utf-8?B?ZC84NmEwWEdYc1VtSDdCb0lESGo5UVlVYVNEdi9KeXpobzl3djJiWnZnci9J?=
 =?utf-8?B?SUpSd3VtU1BZZHhYNjZmMHpxSGMvQ0F0UWpvOXkwUm15MDB1RFVwS0JHNGx4?=
 =?utf-8?B?NGFDcmN3UGUvMGJzNmNjUjd6NEJUZGk5cUxCeTc5ZVZNclRwayt0VWdMTDBw?=
 =?utf-8?B?L0R2Z1BCQnY3NFNKamlBOW1ueWVkZ1Uvc0IrNWR1bld6RldxNklOQXl1VkJ0?=
 =?utf-8?B?RlBOdUNrdkNBV3dJdlFVK1BzMHF2K0xxRy9nSDUzMFFyYUVjTHdXT1Z4Z0ha?=
 =?utf-8?B?Y2o3ZUlJRVVBTTZCYVhwUmFQczVnUVJlTUZrN1hyS3laRzlocVZtVXdlVnFq?=
 =?utf-8?B?T2ozK1hhcjRlQWxFeTVDTHQvRGMrOTJzbC9EUmxsalBScGhTYTFlajE5TC9Z?=
 =?utf-8?B?czVsVTB0UG1VeUY4NWhjYlZhV25HK0ZFT0FLTTBkMkdHYnhEc1Z6YjZlL3Ry?=
 =?utf-8?B?aWVlYTVHN3NUN1JQeU4yMWdZYWlwVmVUTFZHclc3MGtOb0ZaWnNVcGJTYVNk?=
 =?utf-8?B?VGZIbFVjdXMvdUZhNHZJMk9zNStVanBkKzdJUEEyeW9FN2J4WXNkVSt1OGFJ?=
 =?utf-8?B?aURoazlXa3VLTzRMUllnYWFYSDhTMVlXdWZPMzl2a1BXSUdvWnN3WEJ4RmRt?=
 =?utf-8?B?K0VJK2cxVWF4N0FXVXFDYm5wT3lBMDlSWktJUUg4U1hXeWM3bkNiQmhnd0ts?=
 =?utf-8?B?M3kySCtydHdVRE1IQTNzVlV4enpxcUpnNHlVTGNVRnZUN2J3TlNicXgzQlAv?=
 =?utf-8?B?c2s0QmxTVWJUajI1d0hyWURqcFY3b3duVzBxSlFFRDRacmtSTVNXYVdXQnpp?=
 =?utf-8?B?cHRueVk2cnN3ZHBaQ3d6emhDOE01SWNGTFJIYzJLb05iVjF3QVJuQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kZx69ERh2cWnnFBT8YlUk6BPaVYumPXPLPU6haqH9vnxzzIJFni9SzPkCRdh1HIiLKi3f2gvgkdIQUqXYdDJuZmpMtojQfUTS2emdjqkRohD2k9NIAMYwcIK8xJrKiWo8GoloF53YSBnskFPVvCjblj/dVFaMbxkahATQdredGdMsdxFn0i2AFDXHROtxqUxbzejkRr7aJg+5rjrGsdu1nBUIedQx0iYXUtnoQjJp0P8yfi9sxSMTAsoUahGVUAecUNsUZuA3AuH8wNtT4rmFVHLy3tehILjr22WZJJaf9ey7VVZj49nT5rZBO5ZLX/vmKojCiMrjUsCeL0xnFalZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a149e189-b205-490a-a175-08deb5d4787e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 18:28:49.1932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qR5cu+YKwW/9plRfULiH4e6G0iYTjpH1fIUwPI5MLYEbwzW6TsyjMMZq05H/Mm8+/Yd+py0rOJ98eUPbB9OOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9771
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

SGkgRG1pdHJ5LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMi8zXSBkcm0vdmlydGlvOiBB
ZGQgc3VwcG9ydCBmb3Igc2F2aW5nIGFuZCByZXN0b3JpbmcNCj4gdmlydGlvX2dwdV9vYmplY3Rz
DQo+IA0KPiBPbiA1LzE5LzI2IDAzOjIzLCBLaW0sIERvbmd3b24gd3JvdGU6DQo+ID4+IENhbiB2
aXJ0aW9fZ3B1X3JlbW92ZV9mcm9tX3Jlc3RvcmVfbGlzdCgpIGJlIG1vdmVkIHRvDQo+ID4+IHZp
cnRpb19ncHVfY21kX3VucmVmX3Jlc291cmNlKCk/DQo+ID4gWWVzLCB0ZWNobmljYWxseSBpdCBj
YW4gYmUgZG9uZSBhbmQgd2UgY2FuIHJlbW92ZSBzb21lIHJlZHVuZGFuY3kgYnV0DQo+ID4gZG9u
J3QgeW91IHRoaW5rIGFkZGluZyBpdCBvciByZW1vdmluZyBpdCBmcm9tIHRoZSBsaXN0IHdvdWxk
IGJlIGJldHRlcg0KPiA+IHRvIGJlIGhhbmRsZWQgb3V0c2lkZSBvZiB2cSBmdW5jdGlvbnMgKHZp
cnRncHVfdnEuYykgd2hlcmUgYWN0dWFsDQo+ID4gY29tbXVuaWNhdGlvbiBtZXNzYWdlcyBhcmUg
cHJvY2Vzc2VkPw0KPiANCj4gY21kX3VucmVmKCkgaW5kZWVkIGlzbid0IGEgZ29vZCBmaXQNCj4g
DQo+IENvdWxkIHlvdSBwbGVhc2UgY2hlY2sgaWYgbGlzdCBub2RlIGNhbiBub3cgYmUgcmVtb3Zl
ZCBmcm9tDQo+IHZpcnRpb19ncHVfY2xlYW51cF9vYmplY3QoKT8gSUlSQywgdGhlcmUgd2FzIGEg
cHJvYmxlbSB3aXRoIHRoYXQgaW4gb2xkZXIgcGF0Y2gNCj4gdmVyc2lvbnMuDQoNClllcywgeW91
IGFyZSB0YWxraW5nIGFib3V0IHBhdGNoIHY3IHdoZXJlIHJlbW92YWwgb2YgdGhlIG5vZGUgd2Fz
IGRvbmUgaW4gdmlydGlvX2dwdV9jbGVhbnVwX29iamVjdCgpLg0KWW91IGFjdHVhbGx5IG1lbnRp
b25lZCB0aGlzIGF0IHRoYXQgdGltZSwNCg0KIiBBbHNvLCBsb29rcyB3cm9uZyB0byBkZWxldGUg
b2JqZWN0J3Mgbm9kZSBmcm9tIHRoZSBsaXN0IGJ5IHRoZQ0KdmlydGlvX2dwdV9jbGVhbnVwX29i
amVjdCgpIHRoYXQgaXMgaW52b2tlZCBmcm9tIGNtZC1jb21wbGV0aW9uIGNhbGxiYWNrLiBZb3Ug
Y2FsbGluZyB2aXJ0aW9fZ3B1X29iamVjdF91bnJlZl9hbGwoKSB0aGF0IHdhbGtzIHVwIG9ial9y
ZXN0b3JlX2xpc3Qgd2hpbGUgb2JqIGFscmVhZHkgbWF5IGJlIGluIHByb2Nlc3Mgb2YgYXN5bmMg
dW5yZWYnaW5nPyINCg0KWW91ciBjb25jZXJuIHdhcyB2YWxpZCBzbyBJIG1vdmVkIG5vZGUgcmVt
b3ZhbCByaWdodCBiZWZvcmUgY21kIHVucmVmIGNhbGwgaW4gdjggKHRoZSBsYXRlc3Qgc28gZmFy
KS4NCg0KVGhhbmtzLA0KRFcNCg0KPiANCj4gLS0NCj4gQmVzdCByZWdhcmRzLA0KPiBEbWl0cnkN
Cg==
