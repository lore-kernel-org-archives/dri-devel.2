Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36F2C624D6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFAA10E9C5;
	Wed,  2 Sep 2026 05:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nC/5p50b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B1A10E6F5;
 Wed,  2 Sep 2026 05:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788325538; x=1819861538;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=R2tT58GiPYSo6aVe7WhXSqF5vJK/FXScE30cqNjImss=;
 b=nC/5p50bOZOMV3OgI3RH0Z2iSZpXgmrsgY3iYnLYr9ohNkxxfw3AHQkR
 2vi/kEHTDCKicxrvpGGCIaicMZQ9v/Eg8mVKncZ41bo7sgimoZSYGS9sK
 kUx4exeVY6EG7RKfdMi8xhcTsUxZxwjeCZSrf5OVTy42MBpMDvn288N/I
 d+WtUmzVxAvjeCFcvXHzZGFGq3fjTsuQqsprTpi28QAwjLybJzh/qEfRL
 v4rkyw3yXdWN6NXQyEzfq1wDWx9Qq6k2VKoMutkPxC4NoNyve18ThS99p
 LVDnIZVXY7JOKqVUTECmL1JJB0arUrdtg2YKQXfBt0jV/48GjB/q8Co/t w==;
X-CSE-ConnectionGUID: XpnjHYw/Rpiond++hdu6Ew==
X-CSE-MsgGUID: /7hMn23tRjOshJuR5ipRqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106141245"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="106141245"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:05:37 -0700
X-CSE-ConnectionGUID: BjYtVSTtQ76jwNuCuqdYsw==
X-CSE-MsgGUID: RA7lv7l8TRu2ZM9Y2yMeag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="292812723"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:05:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:05:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 22:05:36 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAxf3+2Bd/DdcwzhOkV5g/bNA2UgsRZBlTS7Iz+U/Znfx6WWGOFbzqxq1nNdT0zRyjnjErmhXmFlr12RIglTqUjwpLFyyX6q7JlSV46qaLxyWylxVnFLTlD5foPx6xiD0Yb70RNals+xnG8fR3jmvTOQUF7xMpoEvKcZFxFM6kSj0rExNnfgzleoXjuvwEcoORwDbQ8jUYyaTBlEhOQrC5wMf7ve7mrSqqXgK4xEz1aIZaCNKxmZe9EsZqEV0Dacz24RMJGErdmOULfS0sGohA88lXLVFVZ6VV4vL5QazGe8K/4wP4mBDx1kNTOGNanj/etDH7vjSWP+EdsMfeJUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2tT58GiPYSo6aVe7WhXSqF5vJK/FXScE30cqNjImss=;
 b=RBdp036+MJy0d48DB5Qbn6HdOmBBlPeMIoGaQYfeLBtja6f2hyRQ7vhJ+E2aF07fBexTz3sV6RukNviIZvfR2wRqjhw6AiYtiqv/L8C72CZZRGsSdg9RwzMbDAoednY9vU7zMyP/xFdPf77Gj1UJrf0tnt2PblE+RWuYvfcBiNN7zsOd0qqhO0fK/uzrYpD2Dm7uhd7BmiD2h/iOAc8rgKT9hbqv7rda6LWIfAM/5y1XrJoIV1tp3hNU1mmtKkd5RlsaFLKW4UtsBgrtTliHPY999zo7NkCfN2Ec+uloMyjnGC2HQax6lq3p1MVa5jndsoVYxtIxf66klKB30E/yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.10; Wed, 2 Sep 2026 05:05:33 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:05:33 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "j@metarealtyinc.ca" <j@metarealtyinc.ca>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Kahola, 
 Mika" <mika.kahola@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915/psr: clear the Panel Replay error status
 register
Thread-Topic: [PATCH v2] drm/i915/psr: clear the Panel Replay error status
 register
Thread-Index: AQHdOlTkReaO8ylLlkGvZ+iHUMlfj7a6vLGA
Date: Wed, 2 Sep 2026 05:05:32 +0000
Message-ID: <7840f6ad7fd6621d33d2651618acb2b23b5b9b8b.camel@intel.com>
References: <20260901203633.92628-1-j@metarealtyinc.ca>
 <20260901205956.130779-1-j@metarealtyinc.ca>
In-Reply-To: <20260901205956.130779-1-j@metarealtyinc.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CY8PR11MB6818:EE_
x-ms-office365-filtering-correlation-id: 9721891c-4668-4630-e947-08df08afd11e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 12QYiqVhSgkeOM9QosZptp7TQUC4vEnktzILudyJSwOmWnaF5VUIqz7tfnfn8IpVgcSO3yCdDu1RO2sejNNipVtNwBri9POV4qrVmxhcOogKobm35y5AjdlPfPJZbEIzHQD/iEF6t9WWTU9dRbYyPhsVCXqAAj9Fsc+WqzUyvTGqD8jeA6WyXG36HTOBO1Ng0AY4Bdn0cylVIcBaLMGN05+KGV2qIjAQe14tC1ui7aHneCVk7hFbpOW0PgL+o6jmlF7kUrxMaR2y6mqxzmxyFBhcUcBcAGTpAF5mp7heEGgbOKHvBZxgBK6dZFUZ3sSBNwTz7embHxkR7i+KcKMbU7WaX9jZYB6RJ+LSGspj2fSuDmXicJ5FUtcNM+ycPEPLpBV65ksXRxnz/h3UTJCWdkVPP3P4ca+9ycnrRlsREmXUtLT3k2DAPI0+BuEQyeTULUzV2EQEhza+BIwc1yXcUAhZKWCOj4+YXL97ZHVnGAE+G5Sjf+Kii/KuucpvUZ0/ueEquMm8mqYbVrK+V1KOpsvDoaqBNQsNpfMp/0iLvHPWPT8TnRsTXv4zLWLdbHHz6YZ87CF9tTau1hAudK0859+w1//4lfFMBIHKxuC+aL29XVNF1Wa4huRPTHyYpfPHBROxGVc0YgtRv+yuis8M8S+FDNf8Im69VFtTWuT2AQK1MV+ItVsAwqN+WnamMqV9Y9A2WUNn31ad0HDP7UIST34F1rTmsRa54LLcdXPvZHQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU9aUE9ZaXVDSm81V21QV1VUeG8zcGVPUVdZTGRXK2dmUkJ2M1NKVnBsQ2U1?=
 =?utf-8?B?UWZtWU8yYTNtWWJYZ0R4eU9HTjZCSzVLQ0VUaGVSYTBobTJzUFlaUm9lTGd6?=
 =?utf-8?B?enVUNGd0VUtIdmJoaE9GSTZteisxUGdKWmhNQjU4V3BHRFFMRE1iWGh5Vkts?=
 =?utf-8?B?aDd3NFlHcU1PSVZxNzVEVVBFNjRYTDE2cW81bllhVGY5b1VjRm1lK1UzSXN0?=
 =?utf-8?B?bG9DVjZHM3ZFaWJoRDQrL20zako5WU96U1EyZ0FJZ0I0M3hKMW1GMXlCbFBO?=
 =?utf-8?B?WmsvQUhVcnZMQWZGaGZVek5tbk9WdlMwMVE3dDEvcFZDV2dLL29pb3N0N3Ey?=
 =?utf-8?B?MFVGOGI5Nk9SZ01VZDBNcDRzNHRWQlI2R1NicDR3bmRRbTYzcGRrNTV1T2Y3?=
 =?utf-8?B?Yjk1NmpDNTQwSElKQUNpa3RpTE9aM0xpdDZuTnBZWGhVRVpUOG5lcS8zOEpD?=
 =?utf-8?B?RWlXVnZBS0plLytVZ01zQ1pFZGtINENGOENaMnJCVCtqZWIzS2F2UWJXaXJR?=
 =?utf-8?B?SWRqN3JaVTIwTG4yRHlrTEtoUS9jZlZ5bjNKTmNPOEt0ZHRYdEliMFl2QXNs?=
 =?utf-8?B?Y0w1dGNablcxUmY5eEFONWdKWTdWS0NpUFczVXYybTNHUzBiM0dOR2VkazJw?=
 =?utf-8?B?SDAweGRJK052K2swZXhNVkNDZ2lBLzh0UjBoUXRiMk9KMjQzV1Fjc3pWRjcy?=
 =?utf-8?B?azRXMTIxZ3IrZ3B3QUM1M3lLTldqK3JacmM4OStTazMxS0ExbmUxdTlwbVE5?=
 =?utf-8?B?VXN2alBQVkUyeWVQMG5WZktWdDZPVnhJUjd2TC9oN01wdUM1dHJKUC9Qcnp1?=
 =?utf-8?B?YmFxc01EdUNNcVNMY0Z4clErSUJsYVVubUlKN3FpcVhTT01NN1NLekU0T3Ir?=
 =?utf-8?B?WTNMRmgrVU9OVWNrVUZEOG5wS1VVUWEyNGc3ellSUjFJRmJCY2c5eUpqVFdW?=
 =?utf-8?B?cEQ5M2gzOSs0aHNFTHZZNm5jUHlaNXJQa3JMVXNTLzBvRFg2eHFhSlQ0WW1P?=
 =?utf-8?B?bCt2RnNrUjhzQkJ4L2xHUEdhMW9va01OTStkWDdjVWV4QVpuNkllemJXcGJR?=
 =?utf-8?B?Vm5IenRSQTJPMGVHQnRvOFNWQXE3eE9Ma213eCtYZnRHVThYbDVFOEg5cEYr?=
 =?utf-8?B?MlhUV3Y5N25GOXUrQ3NuSTJoc2dFTldsRGhKL0RuYitleWZmcDZDYWF3Qi83?=
 =?utf-8?B?SnE2Z1pNUUlLdjlyU1VGNjk5cllxbkUrWjloUWxJK0ZTa1EwZWZobGRDTHFj?=
 =?utf-8?B?VmQ5TzZGQnRhRlFJelZUV1VNalFkcWQzaFhkbENDVEI5SGpQOWJNR2hpNm5Z?=
 =?utf-8?B?Wkd2SHdvUktvMXNrRFI4MWtiQWtNb3FwaVBmc2xLcUxlcmpDTzlMaUpRYUZF?=
 =?utf-8?B?ajlLaTFnVmVrOW1sZVhoOTV4elc2UmpkUlR6eklIQUhKZEZTRFk1Q1kyTWxn?=
 =?utf-8?B?N0dWclk4OEhtaG0rdER2WUJ0TTFEVTA0NjdwVWJWMGFjeFJpcXBRc3hZQ2pO?=
 =?utf-8?B?cFo2WXpJL0hncHo3QkJ1YjJjcExESWZ1VmJ5ajFrcFJHUkJjTG9XMG9JeUFk?=
 =?utf-8?B?NUZKZHhjVGZQSHZLR3hZYlN6M3VTbElKZ0lVTGNaeFBhaXBPWVIwZWNBeVhL?=
 =?utf-8?B?SGFHSU9wSlkrbVJCVExyNlVhQ2RrMXNMSzBuMmx4N0g3bFlXN1o4UnRNSTd0?=
 =?utf-8?B?K0pxenB2RWxVbkxKK2IrWm1jVzdLeVk3U3ppK29ITEpYYW1BSSs2QXlPQkpR?=
 =?utf-8?B?blF0MEE3bVdPTHVOWUcwdWM4c2sxLzE4ajFISmlXVXR4S3BxMnphZTVnZzEz?=
 =?utf-8?B?VkU3SFVmdk5SS3V3U0ZIRnNqdU16VW9RdHNYRDRTcU9DOHVuQU1JUDMxS0Fh?=
 =?utf-8?B?VzdxVis0c3dKcStzOGpuL0VMN2NQNytDWFFZV3RwSkVzQ2hHeElicnN3blow?=
 =?utf-8?B?bHAwOWlvdHIrNS9iaEVHSVI2OEx0YnFIUXhNOGxFZXo2QU9RMGpiMm1Ed3BY?=
 =?utf-8?B?Smkxd3VMWVpweXMwN0NKOE9PT1Vac1JvZFhXYmhLaWlIMWVRRVZETGJIRE1L?=
 =?utf-8?B?MmwyUHoxQmp0YWxJamp3bStYUWZKZVVXMEZsOXJIcUZULytReDBoSTE3TGRX?=
 =?utf-8?B?WXE1cjZTSHBIb1l6YW1MbU1hVWZ0c29Hc3RvYnRQMzZ0bWtraDkxZW14SGRY?=
 =?utf-8?B?ZW55NW9ISEhXL2ZqanI4Q1BNQU4rTWszVVoyRnFXL2FLV0dzOS9SZUtoS2Nz?=
 =?utf-8?B?ZDF4QVZCZ29hRVZSK2Vadkg2TEM5RndNYnBBU3AxQkJKNDNRdVJNY0xhVHVR?=
 =?utf-8?B?dEszVFV4YWd3UVFqZGUxb1FrcFRZSExPWk1WSmZJa0lqQXB5azBLMzJXMHRL?=
 =?utf-8?Q?VuwHapYX/CrTzAC0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFA122CD1CBB664F84242FB3B1F4111F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bImemV0bm8VjpZvJ2nAeC5t4aiYRcj8AY7Ucu8YaUTtmRHHlo+Cq5yli6w5enxtvdNJRabWYu97YlwlGJEer/XgzKoEADLGqIavCxShbsHsBipJYPRbE9WTnTWfg2OkzCo8DMdNUiMYJGcevJddrtdncQh/KplbaQsNRA18qyDCVWLAmaKj6nS00+o5Gxh2Il43mWJLJ840+1uu4IVfkmKy8IA8YjG6q3GokQ4MNXjWH3ov7qWaNYruQ2vQvVmB2ytnnOi6Zy51+l78ZCfhVWN1E89gRpw0UHG9dHxLOSqlUNhdHsdjKZURaNZfnJJH3Y9+tkGA7O1+mnYutS/uW4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9721891c-4668-4630-e947-08df08afd11e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 05:05:33.0404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfFUrPEWXYa8OFtZz5XGTXppxsdC6kfY9iwmkh5naXeTfjKz1VjLwYSYZLcvwasWiC76pbsWYEmZf7/UbOxtSBcEjIfUglcSWSXQtfdVDn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
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

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDE2OjU5IC0wNDAwLCBKYWtlIFN0ZWlubWFuIHdyb3RlOg0K
PiBwc3JfZ2V0X3N0YXR1c19hbmRfZXJyb3Jfc3RhdHVzKCkgc2VsZWN0cyB0aGUgRFBDRCBvZmZz
ZXQgdG8gcmVhZCB0aGUNCj4gZXJyb3INCj4gc3RhdHVzIGZyb20gYmFzZWQgb24gd2hldGhlciBQ
YW5lbCBSZXBsYXkgaXMgZW5hYmxlZDoNCj4gDQo+IAlvZmZzZXQgPSBpbnRlbF9kcC0+cHNyLnBh
bmVsX3JlcGxheV9lbmFibGVkID8NCj4gCQkgRFBfUEFORUxfUkVQTEFZX0VSUk9SX1NUQVRVUyA6
IERQX1BTUl9FUlJPUl9TVEFUVVM7DQo+IA0KPiBidXQgaW50ZWxfcHNyX3Nob3J0X3B1bHNlKCkg
YWNrbm93bGVkZ2VzIGl0IHVuY29uZGl0aW9uYWxseSB0byB0aGUNCj4gUFNSDQo+IHJlZ2lzdGVy
LiBVbmRlciBQYW5lbCBSZXBsYXkgdGhlIGVycm9yIGlzIHRoZXJlZm9yZSByZWFkIGZyb20NCj4g
RFBfUEFORUxfUkVQTEFZX0VSUk9SX1NUQVRVUyAoMHgyMDIwKSBhbmQgdGhlIGFja25vd2xlZGdl
bWVudCB3cml0dGVuDQo+IHRvDQo+IERQX1BTUl9FUlJPUl9TVEFUVVMgKDB4MjAwNikuIERQX1BB
TkVMX1JFUExBWV9FUlJPUl9TVEFUVVMgaXMgbmV2ZXINCj4gd3JpdHRlbg0KPiBhbnl3aGVyZSBp
biB0aGUgdHJlZTsgaXQgYXBwZWFycyBvbmx5IGluIHRoZSByZWFkIGFib3ZlIGFuZCBpbiBpdHMN
Cj4gb3duICNkZWZpbmUuDQo+IA0KPiBUaGUgc2luaydzIFBhbmVsIFJlcGxheSBlcnJvciBsYXRj
aCBjYW4gY29uc2VxdWVudGx5IG5ldmVyIGJlDQo+IGNsZWFyZWQuIE9uY2UgaXQNCj4gbGF0Y2hl
cywgZXZlcnkgc3Vic2VxdWVudCBzaG9ydCBwdWxzZSByZS1yZWFkcyB0aGUgc2FtZSBlcnJvcnMs
IHNvDQo+IFBTUiBpcw0KPiBkaXNhYmxlZCB3aXRoIHNpbmtfbm90X3JlbGlhYmxlIHNldCBwZXJt
YW5lbnRseSwgYW5kIHVudGlsIGEgc2hvcnQNCj4gcHVsc2UNCj4gYXJyaXZlcyB0aGUgZHJpdmVy
IGtlZXBzIFBhbmVsIFJlcGxheSBlbmFibGVkIHdoaWxlIHRoZSBzaW5rIGlzDQo+IHJlcG9ydGlu
Zw0KPiBlcnJvcnMgaXQgY2Fubm90IHNlZS4NCj4gDQo+IE9ic2VydmVkIG9uIGEgRGVsbCBYUFMg
MTYgREExNjI2MCAoUGFudGhlciBMYWtlLCBBcmMgQjM5MCwgZGlzcGxheQ0KPiB2ZXJzaW9uDQo+
IDMwLjAwKSB3aXRoIHRoZSBlRFAgUGFuZWwgUmVwbGF5IHF1aXJrIGZyb20gY29tbWl0IGNiOGQx
NTViMDgwNg0KPiByZW1vdmVkDQo+IGxvY2FsbHkgc28gdGhlIGZlYXR1cmUgY291bGQgYmUgZXhl
cmNpc2VkLiBUaGUgc2luayByZXBvcnRzIGENCj4gcGVyc2lzdGVudGx5DQo+IGxhdGNoZWQgZXJy
b3I6DQo+IA0KPiAJU2luayBQQU5FTC1SRVBMQVkgc3RhdHVzOiAweDIgW2FjdGl2ZSwgZGlzcGxh
eSBmcm9tIFJGQl0NCj4gCVNpbmsgUEFORUwtUkVQTEFZIGVycm9yIHN0YXR1czogMHgxOg0KPiAJ
CVBBTkVMLVJFUExBWSBMaW5rIENSQyBlcnJvcg0KPiANCj4gd2hpY2ggc3Vydml2ZXMgYWNyb3Nz
IHJlYWRzIGluZGVmaW5pdGVseSwgd2hpbGUgZG1lc2cgc3RheXMgc2lsZW50DQo+IGFuZCBQYW5l
bA0KPiBSZXBsYXkgU2VsZWN0aXZlIFVwZGF0ZSByZW1haW5zIGVuYWJsZWQuDQo+IA0KPiBVc2Ug
dGhlIHNhbWUgY29uZGl0aW9uYWwgb2Zmc2V0IHdoZW4gY2xlYXJpbmcuIHBzci0NCj4gPnBhbmVs
X3JlcGxheV9lbmFibGVkDQo+IGNhbm5vdCBiZSB1c2VkIGF0IHRoYXQgcG9pbnQgYmVjYXVzZSBp
bnRlbF9wc3JfZGlzYWJsZV9sb2NrZWQoKQ0KPiBjbGVhcnMgaXQNCj4gZWFybGllciBpbiB0aGUg
c2FtZSBmdW5jdGlvbiB3aGVuZXZlciBhbiBlcnJvciB3YXMgZGV0ZWN0ZWQsIHdoaWNoIGlzDQo+
IGV4YWN0bHkNCj4gdGhlIGNhc2UgdGhhdCBuZWVkcyB0aGUgUGFuZWwgUmVwbGF5IG9mZnNldCwg
c28gc2F2ZSBpdCBiZWZvcmVoYW5kLg0KPiANCj4gdjI6IHVzZSBhIGNvcHkgb2YgcGFuZWxfcmVw
bGF5X2VuYWJsZWQgdGFrZW4gYmVmb3JlDQo+IMKgwqDCoCBpbnRlbF9wc3JfZGlzYWJsZV9sb2Nr
ZWQoKSBjbGVhcnMgaXQuIEluIHYxIHRoZSBjb25kaXRpb24gd2FzDQo+IGV2YWx1YXRlZA0KPiDC
oMKgwqAgYWZ0ZXIgdGhlIGRpc2FibGUsIHNvIGl0IHNlbGVjdGVkIERQX1BTUl9FUlJPUl9TVEFU
VVMgaW4gdGhlDQo+IGVycm9yIHBhdGgNCj4gwqDCoMKgIGFuZCB0aGUgcGF0Y2ggd2FzIGEgbm8t
b3AgdGhlcmUuIENhdWdodCBieSBTYXNoaWtvIEFJIHJldmlldy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEpha2UgU3RlaW5tYW4gPGpAbWV0YXJlYWx0eWluYy5jYT4NCg0KUmV2aWV3ZWQtYnk6IEpv
dW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoGRy
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMgfCAxNCArKysrKysrKysrKyst
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5jDQo+IEBAIC0zODQw
LDYgKzM4NDAsNyBAQA0KPiDCoAlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9IHRvX2lu
dGVsX2Rpc3BsYXkoaW50ZWxfZHApOw0KPiDCoAlzdHJ1Y3QgaW50ZWxfcHNyICpwc3IgPSAmaW50
ZWxfZHAtPnBzcjsNCj4gwqAJdTggc3RhdHVzLCBlcnJvcl9zdGF0dXM7DQo+ICsJYm9vbCBwYW5l
bF9yZXBsYXlfZW5hYmxlZDsNCj4gwqAJY29uc3QgdTggZXJyb3JzID0gRFBfUFNSX1JGQl9TVE9S
QUdFX0VSUk9SIHwNCj4gwqAJCQnCoCBEUF9QU1JfVlNDX1NEUF9VTkNPUlJFQ1RBQkxFX0VSUk9S
IHwNCj4gwqAJCQnCoCBEUF9QU1JfTElOS19DUkNfRVJST1I7DQo+IEBAIC0zODYwLDYgKzM4NjEs
MTIgQEANCj4gwqAJCWdvdG8gZXhpdDsNCj4gwqAJfQ0KPiDCoA0KPiArCS8qDQo+ICsJICogU2F2
ZSB0aGlzIGJlZm9yZSBpbnRlbF9wc3JfZGlzYWJsZV9sb2NrZWQoKSBjbGVhcnMgaXQ7DQo+IHRo
ZSBlcnJvcg0KPiArCSAqIHN0YXR1cyBpcyBhY2tub3dsZWRnZWQgdG8gYSBkaWZmZXJlbnQgRFBD
RCBhZGRyZXNzDQo+IGRlcGVuZGluZyBvbiBpdC4NCj4gKwkgKi8NCj4gKwlwYW5lbF9yZXBsYXlf
ZW5hYmxlZCA9IHBzci0+cGFuZWxfcmVwbGF5X2VuYWJsZWQ7DQo+ICsNCj4gwqAJaWYgKCghcHNy
LT5wYW5lbF9yZXBsYXlfZW5hYmxlZCAmJiBzdGF0dXMgPT0NCj4gRFBfUFNSX1NJTktfSU5URVJO
QUxfRVJST1IpIHx8DQo+IMKgCcKgwqDCoCAoZXJyb3Jfc3RhdHVzICYgZXJyb3JzKSkgew0KPiDC
oAkJaW50ZWxfcHNyX2Rpc2FibGVfbG9ja2VkKGludGVsX2RwKTsNCj4gQEAgLTM4ODUsNyArMzg5
MiwxMCBAQA0KPiDCoAkJCSJQU1JfRVJST1JfU1RBVFVTIHVuaGFuZGxlZCBlcnJvcnMgJXhcbiIs
DQo+IMKgCQkJZXJyb3Jfc3RhdHVzICYgfmVycm9ycyk7DQo+IMKgCS8qIGNsZWFyIHN0YXR1cyBy
ZWdpc3RlciAqLw0KPiAtCWRybV9kcF9kcGNkX3dyaXRlYigmaW50ZWxfZHAtPmF1eCwgRFBfUFNS
X0VSUk9SX1NUQVRVUywNCj4gZXJyb3Jfc3RhdHVzKTsNCj4gKwlkcm1fZHBfZHBjZF93cml0ZWIo
JmludGVsX2RwLT5hdXgsDQo+ICsJCQnCoMKgIHBhbmVsX3JlcGxheV9lbmFibGVkID8NCj4gKwkJ
CcKgwqAgRFBfUEFORUxfUkVQTEFZX0VSUk9SX1NUQVRVUyA6DQo+IERQX1BTUl9FUlJPUl9TVEFU
VVMsDQo+ICsJCQnCoMKgIGVycm9yX3N0YXR1cyk7DQo+IMKgDQo+IMKgCWlmICghcHNyLT5wYW5l
bF9yZXBsYXlfZW5hYmxlZCkgew0KPiDCoAkJcHNyX2FscG1fY2hlY2soaW50ZWxfZHApOw0KDQo=
