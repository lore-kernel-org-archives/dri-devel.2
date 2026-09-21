Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27924C982F7
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BF989F01;
	Mon, 21 Sep 2026 14:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="afzCLhNq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7B189D7F;
 Mon, 21 Sep 2026 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789999650; x=1821535650;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b9gykGNoHEXAXPSKDVfKGRBBD9kdGAq47525kRrNmeA=;
 b=afzCLhNqY0kcWafzemeVCVD5Yp3Bik6tudWFMyDmTf3vT3wJaxsq30Oc
 AnyLSskOsVFMKA2QA5qpqfgIi+m5v3r6wJfUojJwkN2URQvGcRyz2/u6D
 DO3NWns6IqWhd0g5LuVM2lhzoZGn40LChtqsrKWEVcyCzqjv+NVPM9hqQ
 TqUw4gsIhnjlXAlcz78CP9DKtbn28kIjZo7CQ1vGupHWaDczhInsP7Cr5
 8s9fERVKU4bCV3gYNzfXsFoVO25hBsa/L33Mp5wOY3GnUB6hdYLlZWwRm
 uCoF69xoWEM7GbDC9R56IxxjbGhSmBSRlhPNxnAaXd0E2LceH7mO65BhT w==;
X-CSE-ConnectionGUID: WlbT+of8R9yvfmpCC7t+0A==
X-CSE-MsgGUID: GK40vv45RV2md0F2sQAPYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1018433"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="1018433"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 07:07:26 -0700
X-CSE-ConnectionGUID: Zylms3CZThyv5qww7WMoDQ==
X-CSE-MsgGUID: XdKJ4UB0QFCVcefit1flwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="271848580"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 07:07:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 07:07:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 07:07:25 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 07:07:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1UrScQF509hlTJ8jZ+rqe0J/gxuHcLEB3W5lyo6XSIjTb/XZd/OV7VhqkisdhiUXcf5Q8itJYDCWT2C4LgsOc12RZkPjkFj4ZnNAi2XKOmq0di1me5N7cNcUnvOIqCVF1iE4SWtcezyQ5XyAvRcb8DIUxW5OjqkhnEGc8VDxh8Vo296CnbLRPSYOq79VGJK/mfEIFwYsq+5kCL8lkQhY/r5D36oyq9QziiyoZVyDdGi6i2rmkTDrA/64pr1aclZrjR0toTRoJV8dwbg42Jk724Q9oCJgHhzcR04eTpdU7VsyYZoSzgRZNrzdrJYkXabrnNb4RHRaDWKNnzibbtdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9gykGNoHEXAXPSKDVfKGRBBD9kdGAq47525kRrNmeA=;
 b=MaqHOC2b75sPghqKnZtlco+AHj/aTwCk4AlNeH77CiQ0ID5U3j8fTUVaLVxAr8AbJX5qaZ6S2XDszXzF+d5PxqK6YBw7LEYLzI7mUdZ97b1dqyuMVEfp0tqm7iy3yGoVVv8ck1IqzuJAgTyqri9gs5WOBqtd6o5lqt3Zu0e0oG6mvZIEI6IdhzKkerxIh49l4TBeNSvxkBYi8FPIQltF1v4QoEIi4dqxGYunGESNnnp7XiJPAZrb8vYy0SjlaF+SAqKX+k5n4kepVWSK9B4jcDSRqOOka0n2bPaCmt6Rf/k+rDrmGnQw8aCnH/bFKKpXx69o01Af/4tqoDPw0jqQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10)
 by SJ2PR11MB8539.namprd11.prod.outlook.com (2603:10b6:a03:56e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:07:19 +0000
Received: from IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7]) by IA0PR11MB7307.namprd11.prod.outlook.com
 ([fe80::9d4a:f89:f548:dbc7%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:07:19 +0000
From: "Murthy, Arun R" <arun.r.murthy@intel.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, =?utf-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, "Nautiyal, Ankit K"
 <ankit.k.nautiyal@intel.com>, "G M, Adarsh" <adarsh.g.m@intel.com>
Subject: RE: [PATCH libdrm 2/2] tests/crtclist: add utility to inspect CRTC
 usage
Thread-Topic: [PATCH libdrm 2/2] tests/crtclist: add utility to inspect CRTC
 usage
Thread-Index: AQHdScpnqmrGFHjZPkOpfhOqXdeyUbbZEO8A
Date: Mon, 21 Sep 2026 14:07:18 +0000
Message-ID: <IA0PR11MB7307D575C550CFF4AB2866BCBA842@IA0PR11MB7307.namprd11.prod.outlook.com>
References: <20260921130747.2557722-1-arun.r.murthy@intel.com>
 <20260921130747.2557722-3-arun.r.murthy@intel.com>
In-Reply-To: <20260921130747.2557722-3-arun.r.murthy@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7307:EE_|SJ2PR11MB8539:EE_
x-ms-office365-filtering-correlation-id: 43b3d7d1-8d96-4fa1-e36a-08df17e9a604
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: l8Rh99KwFzDHU7xQDqYCloAafClhue718a4rMKWKEFGwkr86RumIxeoOH58OPtYLUFIvZMjsCDYCkopUZfD39um3pDJ+5u5PAY+pI/QlDsnH18YGfLqGfBusr3Dc6sv8KJmIqviR1F06XulcXXEP3/FTBvEorXGTrnzlGeHHEP2yEVnQFs1Mkr7HAATCR1Yd9VoYSF9USaBQYfYxykRUBCbPFXuVI8fCVtOjFSQN1fc4FxtTXi15QWua7AXiGfTaj+bZQBQg5vF0aS/Jc3GMTVF60qmVZS50r3dumnrvD8k88JLzN465eksW1q4QVXMaRl7tgOsqOfhDMkBHWRYEEGh6EcsARY0Yuykc34cDlDRLFZ1g1vRV7o3TcH1fdhpxliaCLkSveKeKC2QbI1Jtngb10e2ntgVpgxZKVYqYU4bcqksYBJEBqhiaZ20aJgYXDi0NFT8XidYUrEARhRpn7nkSF9AHPV4HRXFwnkb78BbbbrQwrfhaSNNgWVfE/ve5TlyGWxNFQBeiOsGZFajD2Lq3xL4aRjYCPT0i8VLuTBwiSaLSFkKNiSZdbABsMaGhStINuXGZK/Z3HHjDk0/yPUEnpvG1K7OOKBttQPHik23ZSLCPmwq8mBlP+iYdXdQexFYBPUpWzSBvCwsqSwX4EQvyNtBOsxJnAQvDU3VerI/O4labiQjUWplU2fRmUS4jwRHZ6XKTpTDKNIcaHwn4OMsHMrIbEvGKJouN30JMkRg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7307.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhNeUhmaloraHA5N0ZQZmRZZUdwNjJEL1VGK1VBVTE0aFprLzVLV1RuV3Jq?=
 =?utf-8?B?RWJYZUYyS1gwOE14SUpkVm9BaEpVckhQdE9VdHBoNGhFODZFRnovV2R0eXor?=
 =?utf-8?B?endRQ1FKNlJnYTRZNnd3UDRoTWVJRGc2NDBmaVFDOWhrbmtJTDE1N25FbVBr?=
 =?utf-8?B?QWt2cjF5YXlPUzEzajgzeE1xbG9DZnV1emNlZHBBd2pZMXY5cCt3YTFub1Ir?=
 =?utf-8?B?ZVI3M08rNHBZMGFQMGxuVVR4L2dFZmhlS1pxTVNKWHM0YzBzN2xKcXZMc1kw?=
 =?utf-8?B?eWFudE5rUXFoVFp0eTM2ZDRKZUp1dGJFazh6dk8vRm5GSmU3bjFrMUlycUo2?=
 =?utf-8?B?cjl3bWRPOGxyZUpSaGsvcCtLK1o5Slh2VlBDWER1NGtHcGN0ZDBsU1FVeTJN?=
 =?utf-8?B?c3FYOWRrZ1RjWjNsNG9yalk0OXdnTlRZVlIwak4wd3VIdjBUQnJvTTNSeSti?=
 =?utf-8?B?TytJd0tVUzhlZzBPeXFhd1JPSno2Yyt3ZG1qWkRxbG9KN3JsUytQLzhpb2Zr?=
 =?utf-8?B?bjl3aHNENllleDFBRm1mZ0JCVmxnSEN1MXhHL2g2THRmR2VXSGIyNXBSZFhq?=
 =?utf-8?B?b3oveHZqSFlRU3laS0tXTnlNWUhYOG1JMmx1NURGUEI5TVJlZzNBTy8rcjZz?=
 =?utf-8?B?QWVFcGtRVFdkOWtodnpDTzRLY3phTDJrbTgzdHdYMTZ3dFg3aEo5L281bmNP?=
 =?utf-8?B?czBqZG4wR0kwZkVlTTZEOGxSa1ltWG8ya25sM3c3ekxjbDFMZFkxT2g1K0tL?=
 =?utf-8?B?VkJnYUJVZjBWQjVNeExMbGRnc205eVlQSUZjaFRxWXdQTXNMaDArbVNOdmYr?=
 =?utf-8?B?V0E5S2JHS29LL0prbGpRQWFBUU1IYWZiK0ZtWXVFTEltUEUyRzJuRmVoRTZW?=
 =?utf-8?B?azZlYiswRWVjZFpGS05zMTN3Uk5LUE80cGcrYy9KZXZldk1FK0Z5eEQ1WHcx?=
 =?utf-8?B?VG14ZEdFQUI1a2Q5YlRqbjUreDJUQmFhbXFlWktVaTloTGQwRnpDNmY0SG5N?=
 =?utf-8?B?TkVHb1U4QVEwejI4SG9WalovZ2d2UjN0b2dlYWtXN0JndVNkMG1oaTBCaWF4?=
 =?utf-8?B?aXZROUVxQkNoTE5OSFJITnJPUDBqQTAzdlY3VGg0cGJ2VDh1aUR5bG9weGxM?=
 =?utf-8?B?eTlmeEUwVkdJeUE3U3ZRQm9HV1QxaXNEaHpHM3h4OHdWSFBlRFh3MWozT2V4?=
 =?utf-8?B?amhCTlgzS21FeHZvbkY5TVhNUXZFbEMxTXBCUnlmaGR4NkZXbTFsd0ZqV0JF?=
 =?utf-8?B?aytsdDRyVjBXNFpSQXNiSnkrQXlteXJMbFVtdWtneDhFRlFOVVlvcmV3c2NF?=
 =?utf-8?B?TGt5alBKRDV5bUVrU1lBOW9iczduL1Zud0p4UnVBMGRENTVDejZuejJPdjVI?=
 =?utf-8?B?eEpiSGJTOGIrZkMwKzhkTU41ZllXdDBUM2JLRVFQeVR6MG9IeXRNL0k2bUlr?=
 =?utf-8?B?T0hYbEh4ZnRHSXpzVkxTUVZrY3NyNWFoOTVBcUx4cDVtTmo3OXdYTmZ2SzBF?=
 =?utf-8?B?V2R1U1ovbDVqNUJ5Y3JnZ3lNeHp3Wk9aRlVWcURobzZ2Yk9KR3ZicitmUGRB?=
 =?utf-8?B?VkhsT29SUGEyQnhXWXFFZE8yOG1rQWZQMXcvV1FkWGd2cy94cisyMjNBUXp3?=
 =?utf-8?B?K25FbWpGNGtPR0JxS0QzaW5Ua1JrZnVOMzJWUVlPZHBDSXRSUHdWQzNLOER3?=
 =?utf-8?B?ZnNjbklmWURvSmthQmExVExjU3hCUFJXdUpyaVJlSW5LUEEzcWFTTWlNREow?=
 =?utf-8?B?K055OHRmNDVQb09ZMEdYZDdzeUMrL1dQM2wweEN4MThRL084bDBFbnZST2Fr?=
 =?utf-8?B?RnF6Y2g4MUFlRkJxSnJUMVVmSUVvM2lQTGZBTHVWdGFRU1V6YnVIOGRyVmFC?=
 =?utf-8?B?TThrajk5S3JzOWpZSXNqNVd2ZVRINGwzT3FucUhtR1dvSENRdk1MbWN6UzQr?=
 =?utf-8?B?NkxLd0Y5dk1lTDYwMi85ejN3Q3FLdHZ4d2JkQldwcVFPdW9uOFIvL3RjSXlY?=
 =?utf-8?B?OCtZOXlWVGFNWVVuQ1N4U1NmZ29WTkw1WDQzUE8vMndjajgydlgxZnZaNTVr?=
 =?utf-8?B?RFFJdjBmaDE2cjh6YXI4TVpVY0c0MHp6UkJHaHJ0L2p0NXJYakJrZFdPakpL?=
 =?utf-8?B?SXgyRjdGeHhHT2dtNDFuVC9GU1hzc0QrWjduWmNKWVRGTTFuOUFVNGhJZHgx?=
 =?utf-8?B?Kzhhc2JLUzZPVUZjVVMzckovcS8ydDMvbEtXYzJ0Smd2TEZSVExPQ2JRbkov?=
 =?utf-8?B?TFRCNDVtRjE5eXlxZktkT3pvL0J2dVpURlpNbFZYcDZKRC9vbzArZzhVMnVk?=
 =?utf-8?B?alk2alRicFZ2eVpXNmtYMjRucHdKUUhNUkZyT3lIZlA2VUllVXBhTnlDcXVV?=
 =?utf-8?Q?x9rTsNVd+HTKgvJSImkZxpi6t4c1lujynFBv5ht9O52OP?=
x-ms-exchange-antispam-messagedata-1: yIYaZEPwbjvkhA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eTIf/zwaPZOp47e+pZhSFi8PwDO6ACoGxUWeqjIYsRcZU/0+/Gyy+vALbTbesGYcIkTimp1B6TpcHPEoaCNgxpR7hBSgpgH/lD0ucHS5IYlHsK8akHBDPojiX+AfZnipJGQm4vKfReN58Y8n1q4OwdsaeFWN6ir6hnWt/7wVCiSQUX7ATdOWYvAa8uScc2+LDkS2qBySYJ/9CQR6cyvqMQiAW+uz3TG1TKlHJTt1fxnTM1sFv7+NZ0af4wE9nLpPahUclycbzmcJ1W/jqGS8MZcAqKPI98OcIKuwi2SJvVb3TPPcgnFFtdTFEsD3Y2iBDt25/ZGbfffbbK3EEKRyhQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b3d7d1-8d96-4fa1-e36a-08df17e9a604
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 14:07:19.0027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1xaIhGa37qqSbgIN4N7Cy0LNoMoNi8dZkJoDh/LLnxx/6ptRAmKh13n/3pDxCttGqs8WTY1aE0cB5ggpuoBUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8539
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE11cnRoeSwgQXJ1biBSIDxh
cnVuLnIubXVydGh5QGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjEsIDIw
MjYgNjozOCBQTQ0KPiBUbzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
aW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBKYW5pIE5pa3VsYQ0KPiA8amFuaS5uaWt1bGFAbGludXguaW50ZWwuY29tPjsgVmls
bGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT47DQo+IE5hdXRpeWFs
LCBBbmtpdCBLIDxhbmtpdC5rLm5hdXRpeWFsQGludGVsLmNvbT47IEcgTSwgQWRhcnNoDQo+IDxh
ZGFyc2guZy5tQGludGVsLmNvbT47IE11cnRoeSwgQXJ1biBSIDxhcnVuLnIubXVydGh5QGludGVs
LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGxpYmRybSAyLzJdIHRlc3RzL2NydGNsaXN0OiBhZGQg
dXRpbGl0eSB0byBpbnNwZWN0IENSVEMgdXNhZ2UNCj4gDQo+IEFkZCBhIHNtYWxsIGRpYWdub3N0
aWMgdXRpbGl0eSBidWlsdCBvbiB0aGUgbmV3IGRybU1vZGVHZXRDcnRjTGlzdCgpIEFQSS4gSXQN
Cj4gcHJpbnRzIHRoZSB0b3RhbCBudW1iZXIgb2YgQ1JUQ3MsIGhvdyBtYW55IGFyZSBmcmVlIHZz
IGluIHVzZSwgYW5kIGEgcGVyLUNSVEMNCj4gbGluZSB3aXRoIHN0YXRlLCBzY2Fub3V0IGZyYW1l
YnVmZmVyIGFuZCBhY3RpdmUgbW9kZS4NCj4gDQo+IEJ1aWx0IGxpa2UgdGhlIG90aGVyIHRlc3Rz
LyB1dGlsaXRpZXMgKGRybWRldmljZSwgbW9kZXByaW50KTsgaXQgaXMgYSBodW1hbi1mYWNpbmcN
Cj4gdG9vbCBhbmQgaXMgaW50ZW50aW9uYWxseSBub3QgcmVnaXN0ZXJlZCBhcyBhIG1lc29uIHRl
c3QsIHNpbmNlIGNvcnJlY3RuZXNzIGlzDQo+IGNvdmVyZWQgYnkgdGhlIGRybW1vZGVfY3J0Y19s
aXN0X3VsdCBzdWl0ZS4NCj4gDQpVTFQgaXMgcmVtb3ZlZCBmcm9tIHRoaXMgcGF0Y2gsIGFzIHRo
aXMgdXRpbGl0eSBpdHNlbGYgc2hvdWxkIHN1ZmZpY2UuDQpUaGlzIHBhcmFncmFwaCB3aWxsIGJl
IHJlbW92ZWQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KQXJ1
biBSIE11cnRoeQ0KLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBTaWduZWQtb2ZmLWJ5OiBBcnVuIFIg
TXVydGh5IDxhcnVuLnIubXVydGh5QGludGVsLmNvbT4NCj4gLS0tDQo+ICB0ZXN0cy9jcnRjbGlz
dC5jICB8IDExNg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICB0ZXN0cy9tZXNvbi5idWlsZCB8ICAgOSArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDEyNSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvY3J0Y2xpc3Qu
Yw0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2NydGNsaXN0LmMgYi90ZXN0cy9jcnRjbGlzdC5j
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+IDAwMDAwMDAwLi43YWMxNjg1Mw0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL2NydGNsaXN0LmMNCj4gQEAgLTAsMCArMSwxMTYgQEAN
Cj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgwqkgMjAyNiBJbnRlbCBDb3Jwb3JhdGlvbg0KPiArICoN
Cj4gKyAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBh
bnkgcGVyc29uDQo+ICtvYnRhaW5pbmcgYSBjb3B5DQo+ICsgKiBvZiB0aGlzIHNvZnR3YXJlIGFu
ZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmlsZXMgKHRoZQ0KPiArIlNvZnR3YXJlIiksIHRv
IGRlYWwNCj4gKyAqIGluIHRoZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRp
bmcgd2l0aG91dCBsaW1pdGF0aW9uDQo+ICt0aGUgcmlnaHRzDQo+ICsgKiB0byB1c2UsIGNvcHks
IG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vcg0K
PiArc2VsbA0KPiArICogY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJz
b25zIHRvIHdob20gdGhlIFNvZnR3YXJlDQo+ICtpcw0KPiArICogZnVybmlzaGVkIHRvIGRvIHNv
LCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoNCj4gKyAqDQo+ICsgKiBUaGUg
YWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSBzaGFsbCBi
ZQ0KPiAraW5jbHVkZWQgaW4NCj4gKyAqIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlv
bnMgb2YgdGhlIFNvZnR3YXJlLg0KPiArICoNCj4gKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURF
RCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELA0KPiArRVhQUkVTUyBPUg0K
PiArICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElF
UyBPRg0KPiArTUVSQ0hBTlRBQklMSVRZLA0KPiArICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gSU4gTk8NCj4gRVZFTlQNCj4gK1NIQUxMIFRI
RQ0KPiArICogQVVUSE9SUyBPUiBDT1BZUklHSFQgSE9MREVSUyBCRSBMSUFCTEUgRk9SIEFOWSBD
TEFJTSwgREFNQUdFUw0KPiBPUg0KPiArT1RIRVINCj4gKyAqIExJQUJJTElUWSwgV0hFVEhFUiBJ
TiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLA0KPiArQVJJU0lORyBG
Uk9NLA0KPiArICogT1VUIE9GIE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1Ig
VEhFIFVTRSBPUiBPVEhFUg0KPiArREVBTElOR1MgSU4gVEhFDQo+ICsgKiBTT0ZUV0FSRS4NCj4g
KyAqLw0KPiArDQo+ICsvKg0KPiArICogY3J0Y2xpc3QgLSBpbnNwZWN0IENSVEMgdXNhZ2Ugb24g
YSBEUk0gZGV2aWNlIHZpYSBkcm1Nb2RlR2V0Q3J0Y0xpc3QoKS4NCj4gKyAqDQo+ICsgKiBQcmlu
dHMgdGhlIHRvdGFsIG51bWJlciBvZiBDUlRDcywgaG93IG1hbnkgYXJlIGZyZWUgdnMgaW4gdXNl
LCBhbmQgYQ0KPiArICogcGVyLUNSVEMgbGluZSBzaG93aW5nIHN0YXRlLCBzY2Fub3V0IGZyYW1l
YnVmZmVyIGFuZCBhY3RpdmUgbW9kZS4NCj4gK1VzZWZ1bA0KPiArICogZm9yIGNvbXBvc2l0b3Ig
YnJpbmctdXAgdG8gc2VlIHdoaWNoIENSVENzIGFyZSBhdmFpbGFibGUuDQo+ICsgKg0KPiArICog
VXNhZ2U6IGNydGNsaXN0IFsvZGV2L2RyaS9jYXJkTl0gICAoZGVmYXVsdHMgdG8gdGhlIGZpcnN0
IEtNUyBub2RlKQ0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxmY250bC5oPg0KPiArI2luY2x1
ZGUgPHN0ZGlvLmg+DQo+ICsjaW5jbHVkZSA8dW5pc3RkLmg+DQo+ICsNCj4gKyNpbmNsdWRlIDx4
Zjg2ZHJtLmg+DQo+ICsjaW5jbHVkZSA8eGY4NmRybU1vZGUuaD4NCj4gKw0KPiArc3RhdGljIGlu
dCBvcGVuX2ttc19ub2RlKHZvaWQpDQo+ICt7DQo+ICsJY2hhciBwYXRoWzY0XTsNCj4gKwlpbnQg
aTsNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCAxNjsgaSsrKSB7DQo+ICsJCWludCBmZDsNCj4g
Kw0KPiArCQlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksICIvZGV2L2RyaS9jYXJkJWQiLCBp
KTsNCj4gKwkJZmQgPSBvcGVuKHBhdGgsIE9fUkRXUiB8IE9fQ0xPRVhFQyk7DQo+ICsJCWlmIChm
ZCA8IDApDQo+ICsJCQljb250aW51ZTsNCj4gKwkJaWYgKGRybUlzS01TKGZkKSkgew0KPiArCQkJ
cHJpbnRmKCJVc2luZyAlc1xuIiwgcGF0aCk7DQo+ICsJCQlyZXR1cm4gZmQ7DQo+ICsJCX0NCj4g
KwkJY2xvc2UoZmQpOw0KPiArCX0NCj4gKwlyZXR1cm4gLTE7DQo+ICt9DQo+ICsNCj4gK2ludCBt
YWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gK3sNCj4gKwlkcm1Nb2RlQ3J0Y0xpc3RQdHIg
bGlzdDsNCj4gKwlpbnQgZmQsIGk7DQo+ICsNCj4gKwlpZiAoYXJnYyA+IDEpDQo+ICsJCWZkID0g
b3Blbihhcmd2WzFdLCBPX1JEV1IgfCBPX0NMT0VYRUMpOw0KPiArCWVsc2UNCj4gKwkJZmQgPSBv
cGVuX2ttc19ub2RlKCk7DQo+ICsNCj4gKwlpZiAoZmQgPCAwKSB7DQo+ICsJCWZwcmludGYoc3Rk
ZXJyLCAiTm8gYWNjZXNzaWJsZSBLTVMgRFJNIGRldmljZSAodHJ5IHJ1bm5pbmcgYXMNCj4gcm9v
dCkuXG4iKTsNCj4gKwkJcmV0dXJuIDE7DQo+ICsJfQ0KPiArDQo+ICsJbGlzdCA9IGRybU1vZGVH
ZXRDcnRjTGlzdChmZCk7DQo+ICsJaWYgKCFsaXN0KSB7DQo+ICsJCWZwcmludGYoc3RkZXJyLCAi
ZHJtTW9kZUdldENydGNMaXN0KCkgZmFpbGVkXG4iKTsNCj4gKwkJY2xvc2UoZmQpOw0KPiArCQly
ZXR1cm4gMTsNCj4gKwl9DQo+ICsNCj4gKwlwcmludGYoIlRvdGFsIENSVENzIDogJWRcbiIsIGxp
c3QtPmNvdW50KTsNCj4gKwlwcmludGYoIkF2YWlsYWJsZSAgIDogJWRcbiIsIGxpc3QtPmNvdW50
X2F2YWlsYWJsZSk7DQo+ICsJcHJpbnRmKCJJbiB1c2UgICAgICA6ICVkXG5cbiIsIGxpc3QtPmNv
dW50IC0gbGlzdC0+Y291bnRfYXZhaWxhYmxlKTsNCj4gKw0KPiArCXByaW50ZigiJS01cyAlLThz
ICUtMTNzICUtOHMgJXNcbiIsDQo+ICsJICAgICAgICJpZHgiLCAiY3J0Y19pZCIsICJzdGF0ZSIs
ICJmYl9pZCIsICJtb2RlIik7DQo+ICsJcHJpbnRmKCItLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXG4iKTsNCj4gKwlmb3IgKGkgPSAwOyBpIDwg
bGlzdC0+Y291bnQ7IGkrKykgew0KPiArCQlkcm1Nb2RlQ3J0Y0luZm9QdHIgYyA9ICZsaXN0LT5j
cnRjc1tpXTsNCj4gKwkJY29uc3QgY2hhciAqc3RhdGU7DQo+ICsNCj4gKwkJaWYgKGMtPmluX3Vz
ZSkNCj4gKwkJCXN0YXRlID0gIklOIFVTRSI7DQo+ICsJCWVsc2UgaWYgKGMtPmRyaXZlcl9hY3Rp
dmUpDQo+ICsJCQlzdGF0ZSA9ICJBQ1RJVkUiOw0KPiArCQllbHNlDQo+ICsJCQlzdGF0ZSA9ICJG
UkVFIjsNCj4gKw0KPiArCQlwcmludGYoIiUtNWQgJS04dSAlLTEzcyAlLTh1ICIsDQo+ICsJCSAg
ICAgICBjLT5pbmRleCwgYy0+Y3J0Y19pZCwgc3RhdGUsIGMtPmJ1ZmZlcl9pZCk7DQo+ICsJCWlm
IChjLT5pbl91c2UpDQo+ICsJCQlwcmludGYoIiV1eCV1IEAgJXVIeiAoJXMpXG4iLA0KPiArCQkJ
ICAgICAgIGMtPndpZHRoLCBjLT5oZWlnaHQsIGMtPm1vZGUudnJlZnJlc2gsDQo+ICsJCQkgICAg
ICAgYy0+bW9kZS5uYW1lKTsNCj4gKwkJZWxzZSBpZiAoYy0+ZHJpdmVyX2FjdGl2ZSkNCj4gKwkJ
CXByaW50ZigiKGFjdGl2ZSBpbiBoYXJkd2FyZSwgbm90IGVuYWJsZWQgdmlhIEtNUylcbiIpOw0K
PiArCQllbHNlDQo+ICsJCQlwcmludGYoIi1cbiIpOw0KPiArCX0NCj4gKw0KPiArCWRybU1vZGVG
cmVlQ3J0Y0xpc3QobGlzdCk7DQo+ICsJY2xvc2UoZmQpOw0KPiArCXJldHVybiAwOw0KPiArfQ0K
PiBkaWZmIC0tZ2l0IGEvdGVzdHMvbWVzb24uYnVpbGQgYi90ZXN0cy9tZXNvbi5idWlsZCBpbmRl
eCBhYzllNjZiMC4uOWM5OGJjMmINCj4gMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL21lc29uLmJ1aWxk
DQo+ICsrKyBiL3Rlc3RzL21lc29uLmJ1aWxkDQo+IEBAIC02OSw2ICs2OSwxNSBAQCBkcm1kZXZp
Y2UgPSBleGVjdXRhYmxlKA0KPiAgICBpbnN0YWxsIDogd2l0aF9pbnN0YWxsX3Rlc3RzLA0KPiAg
KQ0KPiANCj4gK2NydGNsaXN0ID0gZXhlY3V0YWJsZSgNCj4gKyAgJ2NydGNsaXN0JywNCj4gKyAg
ZmlsZXMoJ2NydGNsaXN0LmMnKSwNCj4gKyAgaW5jbHVkZV9kaXJlY3RvcmllcyA6IFtpbmNfcm9v
dCwgaW5jX2RybV0sDQo+ICsgIGxpbmtfd2l0aCA6IGxpYmRybSwNCj4gKyAgY19hcmdzIDogbGli
ZHJtX2NfYXJncywNCj4gKyAgaW5zdGFsbCA6IHdpdGhfaW5zdGFsbF90ZXN0cywNCj4gKykNCj4g
Kw0KPiAgdGVzdCgnaGFzaCcsIGhhc2gpDQo+ICB0ZXN0KCdkcm1zbCcsIGRybXNsKQ0KPiAgdGVz
dCgnZHJtZGV2aWNlJywgZHJtZGV2aWNlKQ0KPiAtLQ0KPiAyLjI1LjENCg0K
