Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B749C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C1610E284;
	Tue, 15 Sep 2026 16:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ivQ3xN5P";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB92310E284;
 Tue, 15 Sep 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789488062; x=1821024062;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LoF6Six5pQFXpx9FujbcsqZ7Sw0IxULxEVoSZ2hK6MM=;
 b=ivQ3xN5PqEZbGdbizA6ejuVyhaWIeouiRzfbXJhqNUe3EJNCpFOYRxim
 yKbqzRmgqCTxqns3umvol+m9WATYKkTKBWMXi0bilZImCRbfQtIM2GHdO
 eIlqvKxGnEWlbzFf/whzX1QAdBwHufd+j9rSY4o8vZ17HJv5/KSwai5Ro
 c+nAlvlDaxBpZit7zuwzoJNU/SiYNG37RX4WlW0LoKovACk5MYVQb5452
 wiQnyzyamVLIcTgWz0Z/3B+BpLJR7P2vtvzb6VQSaPxZhp00Ur6oZrWeB
 9AlR8Sxe3bS6QFVZpi/u43dmsg6B3ioXbtBzg9E6OTnM874Bnq+DEDCb0 w==;
X-CSE-ConnectionGUID: TD3C22eoQnKyqTfUNnF1KA==
X-CSE-MsgGUID: AlS5qYJKTKOES2zUZVaW+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89728560"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89728560"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 09:01:02 -0700
X-CSE-ConnectionGUID: 8rxzbNZuQXC2IvopLwqkPw==
X-CSE-MsgGUID: 1dzTN4y+Rh2fcK9IC6mJqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270427944"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 09:00:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:00:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 09:00:58 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg7idMo7hZdqm3WvfqfZrwPyVxKU8xY6f5GjL/9FYBmV6iRP7Pl2KYoBozHs9NSD1UwheswL4h0XUfCtg+zx+80/FDAh75E8uiok/5qxuDGhQtZTtQsnd5938r2wjY8yCfgT9OGIUbsqM+Vu9AHyLeODMcwH7uqMOd4QYRaTwRecp92n5HdW4jbeoM2IV7RTIXyvAkbUKO2RVNKHx/kvZ9BEWTLkNMOwgou6Qo4fJlk6cvGX4lybtJrFVLNYA/YtYrog2m0IPId9VlaakpqMn3gO3CPNSqPjisb9KRZ9oAGXtWOIk+itqtIKO7gA9kATswfCe09bkh7ka4Z6bRTEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoF6Six5pQFXpx9FujbcsqZ7Sw0IxULxEVoSZ2hK6MM=;
 b=XHSvMp3Q7jdJnr0rI5vNr8XcuALDaNhExiurgifDM4r9PiHYWhRjv67v5CnTHOK/c6ni3JQMN5IMXqucDX98N8LndMx5CL7ANi1AoAenx3WogM2f3c4NOrz+DpwgVkvo4+t4qRuNb/6hqX5+nim9R8EAyUzo2HJDuDU+6ERpfu52gEGmRkX6wXOWzH0s7640wYCIj4SnagXbAe7m3hG8OmyN7fGPJaq/+D9XKHpUUNE7U7fValbrjszI4w1Hmhaytjtuc8yASj1nbq6PmOol8x8kGukk019/FbaWKALDfEIiozEWfyQyYFFrb/TbwTPGr3orvzBdzvrAQwA2GiwFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by PHXPR11MB9685.namprd11.prod.outlook.com (2603:10b6:510:3ca::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 16:00:55 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 16:00:55 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Nikula, Jani" <jani.nikula@intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Topic: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Thread-Index: AQHdRJQayossBqMXeEuwdmvTfN5itbbPQDQAgACNaIA=
Date: Tue, 15 Sep 2026 16:00:54 +0000
Message-ID: <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
 <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
In-Reply-To: <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|PHXPR11MB9685:EE_
x-ms-office365-filtering-correlation-id: 27a17728-dbf0-480e-8969-08df13428630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: VW74wRnVHQywMwyqKZgv4syTkgaUjZTyCnlBtmSn4GnXKbHTSOvCaZCgYpfcOb/s4viGO5ciMVnVnOSjBOk1w1kkhCu0Tcs+LCmcVY1oqCa14Rzxi+oPjZ5BsOObQfvvq2bdsJTo/jKWE1ajV0mqM9mEEUrzIE3zLvObIT04DDfBt+Dks8ZRwrhFSbMx3pUHUndiRADUusm2d7EX6NLw8v1pwuuKsmQIs+AAnnR+TSXEC9ZzMjvGbxBT7OFYRzDnR2uEXRNWdpPxi1Z4L8uK7pjppgq9F/5szz3GaE544PEbgiOgxDsrdgTgoY3ERrf7XjEMHg9QSv5EKy7eokIa7Bll2sH6VWg3Qr/vltNL7nq76miLfhIueD/meGkfrDX+5drMhxvee7fyl6rkSkixqA8RACIogg1PcQwpdWZ3/i4X7rktsCeuHbjpw895E3PDpPpSzLhkKoyXdXf2Qsf230Idjn8JublM4x/YSA8adlNZAPrZBNJ+x1jgZOdX34YbsXmGMfraKQQ2By5nAJsim+9L8pQDqx1z0guS21qa8leQm8nsjpqp3LI8Ox7b7XJzJ79vnxdsu8j3nXxhkFeGTGtuJljcG0MuvcWQasOFIpOYmElwxIAHSw4Y+03TfNtc+MK/5NWre6g+XeU8uud+0FZpu8CFAXAxCL4DHy6HXV3PaMTJNzOVOFRTXrMXH4100EQQXrxPgPA4bK0J3KQP6SH+REnnReStUXLEw2fFhD0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWgxS2FhdHRncmNoblRlS05FcGpFblhrRHZ0c2VMaGtLamZLSUVQN29pLzJE?=
 =?utf-8?B?YkRtOTJJYVpXUlpMcjM5OHEwY2t5V1pDWlBFSCtWMGttM0RrZC9GemdyUWkx?=
 =?utf-8?B?WkY2ZGVpbGZjUWx6WVJ1U1hCeDZFMy8yWHVuNzcxM1VYSFZtYUtZRVk4Rmhi?=
 =?utf-8?B?UlRQVnZrOVJFN3hVMU9HNzYvKzJqd0dQeW5oejEzMVlmOVZsVDVQL3dsVjRl?=
 =?utf-8?B?SzZiOE5GUmR6Q3UrWXFlcEFHeERNbVNiMmhrT0ZWdHREMGJraWxjY0J1MUQy?=
 =?utf-8?B?TG1zWkxXcm5RcEVBSzRMSGhtZTd2UWJWKzNiNE9ZSkZwSmV2YjhZVkE5d3dI?=
 =?utf-8?B?QmJNZkNWcmsxSWkwT3NFdjNGeFVLQWlPRzE0RCtGN3N1V3JydllteVNLT0ly?=
 =?utf-8?B?OVN6SFliSDlCcENvNkxxL0tYVFVpeVFoUm9ERkZJeVZRNnJPc0crMWVsZGVi?=
 =?utf-8?B?dkRsbzFER1RTcWczN2wrMWR3ZnlXVjNYSmpvTC9QSmo3TDFGcENsWG9HNGFR?=
 =?utf-8?B?NWhKdEsybDUwNjYrWVN6YitvdzhFWllQeGovMkk4YnpDUHBXMEh0RkZBTXc3?=
 =?utf-8?B?a3NLcFN3Z28xZU0xMy83b0hYb1ovK3RUSndMRTJwMTkwU1ZQTkFkRkZqLzND?=
 =?utf-8?B?SlhPdkxOd0NlOXE1VGNQTndTbTd0bU5KMm1xbFlTS3BJUHBPOU9OcnEzclJB?=
 =?utf-8?B?RGh3K3luSG1rT1lab0U0bkQzZDdLY1ordHlhVnhDVWRRUGRjVTFjV1FKeEVs?=
 =?utf-8?B?NGpUaTlGN2RNUGNLRGZHUDNRbGxWaUVQZzlQd2Y3VldLQTdHL2swM3R6OE94?=
 =?utf-8?B?ODhSQXJoQVRXMnIxdGZvZ2gxNmI3YzdEWlZQWUcwZnc2bzhJMGNYQ1lzSmVq?=
 =?utf-8?B?Tks4Z1lJY1NOMGtHZXBHREREZisvUGdoZlhzVEljcFFpZkREZkhEblkvbGlB?=
 =?utf-8?B?K09TREg1TGFLcHV5b1lXbStYRVY0ZU0wTzhaVFp6aXVsQ3BwekhBVVF5c3dH?=
 =?utf-8?B?cmlmWjF2WjBHcTBxc1VWR0t4eUE3Q21jcGFnK0dtU1RIZyttVVhRS04va0Fh?=
 =?utf-8?B?eUsyNWtCdmhVd2dwV1hJQWFOS1JIcUliSmF3WnpieGlrWVlBV202QTRaak1N?=
 =?utf-8?B?NWFPcThrMnJkZ0cwMjlDSmdQR1dsSStOTnljMzBmZzlsc0w4NEJMT1p3RUxT?=
 =?utf-8?B?WnZVMkx4WWFwTTQ1NG1iRGlFR1dYNi9PY0J0L1d6NlZMcWNBSU1IZUpSN0xH?=
 =?utf-8?B?cnBLNE82bS9FclI2VGFyaUpMREVwbFBhVVpjYk1PUVIrNkJFVWJkeWVXeGZX?=
 =?utf-8?B?Nll5c3V6RXRxZS9UQzRkVjFVUHk1S3ZvajNYL2UvdUlzR2VqMDFIV0lEM29q?=
 =?utf-8?B?Q2FQWXdRR2ZVVzZUZFBUOHFOZFJTN1BBV1YrbURTd3BvOC83RUN3MllkczFm?=
 =?utf-8?B?d21VOXJyWGZWU1BmMlJod2hLTHoxRkhPTFV4RnVHVStZYlRLaHhvd25QbGtB?=
 =?utf-8?B?ZGEvdUw1NTVxVHA3UHRRY3l1NzJZV2NzdjNLNUUwd0JQck9CTnVkbUxSNUVP?=
 =?utf-8?B?WEtlY0tTc0MxRnhwaHFjMHVVbitBR0xsNEUvdGVRbGtraUdlajl2bG55NVVY?=
 =?utf-8?B?K0ZxYTJOOW9lelJLZmVoVGlZclhrQU1qejNlQTUxK1dSTzdQUHlKTmNoK2Jl?=
 =?utf-8?B?MmVDRnBTczMvR3I3a2gyU2RVK25LclNFdEkxWEw5YkRPellZKzBvaTBDQ2Nz?=
 =?utf-8?B?VVppdE9aczJ6TTd2UzN2RmdZM2xkRFVFL1Y3N2p4d05WcGdjNTRIYmNpK1JI?=
 =?utf-8?B?VDIzNVhmQlBqZDRyYXNsbnpzazJ0TWEyQ1NBcTF1RkFjZ05PdXVRT3phV3g0?=
 =?utf-8?B?dzduamxXZWM3RmlZUWdkZWRYUEFqQk8vRVlmQllhR1lGVUlNZkZQRkM3em1m?=
 =?utf-8?B?NFJmYkNrREZSWmRadjVnc0xKRHdNQjZDVWxZNkVYWFp5Tm5zZlc5S3NkOTIz?=
 =?utf-8?B?aFI5ak5jbnRyOGkyNDE5Skt2VVlxT3hUa1VpMXoxcjZhYkMzenBVSXZPdGRX?=
 =?utf-8?B?RDZRZzJWY2pBVzFuQ0tsc0xyV3VtTGloeFZPS1pRbTFvMDQ2SVgra0s5WndF?=
 =?utf-8?B?NjZONVpQOHZLK05ydDU2TEl6aVJzT1dkdzhua25vVDZYay94T0lZNXFtZHdY?=
 =?utf-8?B?WGxickZVQ2QrUWdoamNNVnVpUzNPUjdiTHF3dkZHemZGTjdWYVRJTnNONk5h?=
 =?utf-8?B?aUdsbnVrTW9XWnh4WGs4ank0RkJIUnU3VlpkQmFKbHZBWDcrSXR5OVZCVHA2?=
 =?utf-8?B?V0FvVWVIc1lPL1JvMStVUHpkaUw3UFFqcVI2MUxNeklKSTljR0lpbE4yb3k4?=
 =?utf-8?Q?Bvi/LYLUgYYjcOm0H/vR6jhzYqFGc4bJlVR6G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30731BDC7284464D8422B9799817216A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gdwt1nvoytQFmhdrQcLzWhCX5haRgmpyFltSmtpCLPOG3gW5YPg3ttgODnVPBkEfHyz6EyYvjKiXgujiMK31ha5kwI/28U6p46plyme+DWcGsgDij7HeSImUxCSEQP/SUxvuxhHizETWaZGpgzmxOi114PUskGE2kEjnw2Y2DERyutA5UMSM9rRqrxsDW5KkD4kS3P/LRjJyNmgvqrQdRfcb/9zco4LIT7RbxJDhUqVQqBrERHZ1qlvULCNcA7xHkBoR4e2xNGn3TVxk8UQNAfZOKLOXT54mG+YVqpgzshg9cJI+AUjmi2WAl5805K6KavyKGkqRApAEKpV9518YIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a17728-dbf0-480e-8969-08df13428630
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 16:00:54.9633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mZquT5e1/zdSZIoiHiv0cBoGkAkDrQxGXAdnFyJ8AsAJ5IqX+VBjC0PCQle43VOMKWfF3grUkPGsZO2kCvB2PE+5Ew+U8Zffr3c+BIfXC4zbiFsQk+H9qIrK9HyuLym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9685
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDEwOjM0ICswMzAwLCBOaWt1bGEsIEphbmkgd3JvdGU6DQo+
IE9uIE1vbiwgMTQgU2VwIDIwMjYsIEFsYW4gUHJldmluIDxhbGFuLnByZXZpbi50ZXJlcy5hbGV4
aXNAaW50ZWwuY29tPiB3cm90ZToNCmFsYW46c25pcA0KPiA+ICBpbnQgeGVfbW1pb193YWl0MzIo
c3RydWN0IHhlX21taW8gKm1taW8sIHN0cnVjdCB4ZV9yZWcgcmVnLCB1MzIgbWFzaywgdTMyIHZh
bCwgdTMyIHRpbWVvdXRfdXMsDQo+ID4gLQkJICAgdTMyICpvdXRfdmFsLCBib29sIGF0b21pYykN
Cj4gPiArCQkgICB1MzIgKm91dF92YWwpDQo+ID4gIHsNCj4gPiAtCXJldHVybiBfX3hlX21taW9f
d2FpdDMyKG1taW8sIHJlZywgbWFzaywgdmFsLCB0aW1lb3V0X3VzLCBvdXRfdmFsLCBhdG9taWMs
IHRydWUpOw0KPiA+ICsJdTMyIHJlYWQ7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCXJl
dCA9IHBvbGxfdGltZW91dF91cyhyZWFkID0geGVfbW1pb19yZWFkMzIobW1pbywgcmVnKSwgKHJl
YWQgJiBtYXNrKSA9PSB2YWwsDQo+ID4gKwkJCSAgICAgIDEwLCB0aW1lb3V0X3VzLCBmYWxzZSk7
DQo+IA0KPiBZb3UgcHJvYmFibHkgZG8gbmVlZCB0byBsZXQgdGhlIGNhbGxlcnMgcGFzcyBpbiB0
aGUgd2FpdCB0b28uIDEwIHVzIHdhaXQNCj4gd2l0aCBhIGxvbmcgdGltZW91dCBpcyBnb2luZyB0
byBiZSBwcmV0dHkgYmFkLg0KPiANCj4gDQphbGFuOiBva2F5IC0gcGVyaGFwcyBpIGNhbiBtYWtl
IGV2ZXJ5IGNhbGxlciBwYXNzIGluIGEgcG9sbGluZy13YWl0IHRoYXRzIGEgZnJhY3Rpb24gb2Yg
dGhlaXIgd2FpdCB0aW1lLg0KKGFzIGEgc3RhcnRpbmcgcG9pbnQgc2luY2UgaSBkb250IGtub3cg
d2hhdCdzIHRoZSBleHBlY3RlZCBiZWhhdmlvciBvZiBldmVyeSBjYWxsZXIpLg0Kc28gcGVyaGFw
cyBzb21ldGhpbmcgbGlrZSAidGltZW91dF91cyA8PCA0IiAoaS5lLiAxLzE2dGgpIGJ1dCBwYXNz
IGluIDEwIHVzIGlmIGl0cyBhbnl0aGluZyBzbWFsbGVyIHRoYW4gdGhhdA0KKGkuZS4gc21hbGxl
ciB0aGFuIDE2IHVzZWMpLg0KDQouLi5hbGFuDQo=
