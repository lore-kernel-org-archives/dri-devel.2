Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B6F8D76E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF5F10E22A;
	Thu, 16 Apr 2026 20:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TydHbmKP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EED010E22A;
 Thu, 16 Apr 2026 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776371013; x=1807907013;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HYlMj5VEHiaBqMNct/TFbSUOf4NqVWyWgOJ+I0n7qws=;
 b=TydHbmKPHwVLhobbY1I/k/qt8Rfod4Hp9Hp8FQOiUiFV0FZSRqp0HaMr
 w8bNSKIAQp944VGCp7oaevQNbBOuP4yWmdMWSoyIUH/QJ8DTJQQTb3hrA
 YdC1A4XTkNT4IdxGLQmbZwELj70mba+bg03XdjvsJqGiEwHy7dHojhNUM
 j19ARMGIIVC1QqzK4nIps9xTIiy2xb/gaW06FxQldTbye/YKuiIg87r1I
 Dr8ehre5rrKqUrv+eAHcpd1kUOrjSvMdiU9dC8KvSwDidKfah7Xiyxgqe
 bbLwuz0hsdGbCxmZWQSoEwTA312xr9VevMpKt3Pn6ukAuFRstNg6ObdzY g==;
X-CSE-ConnectionGUID: 4MIh/Qa5TjCSgchHWf6HBQ==
X-CSE-MsgGUID: pI9jttTUTcu6HvodWIHNug==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88768463"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="88768463"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 13:23:33 -0700
X-CSE-ConnectionGUID: LoVkzuCfRaW6TUWaZFtBQA==
X-CSE-MsgGUID: BxCElBAPRzaABQ05rnoIyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="229990808"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 13:23:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:23:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 13:23:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 13:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaiER0A5Miw+pffyHKrx8hqX+kjIx+XKim8OnqZGdYsL/XFnpnQe/luxJtOtBO2ZFU4n+EWLtDFWVQb9IpmWTvHAH38iE/08E52vMCq2i5C3m/M5JG7yjx/TWMDpRfl9T2vf6UM8IB9+EyvSxclr2biJeWovWrmF2p5J920EtdnIQ8GBrGFpSexoEsiG5WelotmbeFher5WjZozlkfSCEVrZZWW/JHR1PvgkM8BhXeyYlmJd9xkI21MfgviGH48cH7VUOebukRMoEttXwaTgUtWWz2JYgA46tuRTGJOPv0hRO2Ci3p0T7pXsaSYTsXDT8bnGZJ0TIH8aYfgDzvFXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYlMj5VEHiaBqMNct/TFbSUOf4NqVWyWgOJ+I0n7qws=;
 b=iN87HG6Z0F0x8pBFNp/yM/F0bmFbeb1DVNW5137iOFHdkRmxBzZ1UBWPl6+hDE/s9sKjzcdxw2j6HZ1hHfuxqBCjaSogkLAp9R54quFkpTrKPU1eooNZyVeqte5h7rnqXOAMy6e278+q/T2JH8CTqDAm0DRdyKeh/gwW/w4w/ZcTDgmsMIcgE0R91R5G1XGijHNg9jxylzIv4SCu8k6piuxWsUyUPaCI+HdLLg5iD1b+F7qrjr0Xdv3xtcQUKN6I7TL5FwW0mlGijuhu+aALUwWbT5QLLQbP52W4e6D0rSQGdLL4EOF6AhEDGA3nM7Uf6KoYZ5RZAY/1WPUQH87IXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 20:23:26 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5081:cd4:1a4b:a73e]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::5081:cd4:1a4b:a73e%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 20:23:26 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>, "Brost, Matthew" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>, dri-devel
 <dri-devel-bounces@lists.freedesktop.org>
Subject: RE: [PATCH] drm/gpuvm: Do not prepare NULL objects
Thread-Topic: [PATCH] drm/gpuvm: Do not prepare NULL objects
Thread-Index: AQHckh1u5T2qHuPPzE+mYb1XlAUHI7Xik08AgAAFuEA=
Date: Thu, 16 Apr 2026 20:23:25 +0000
Message-ID: <CH0PR11MB54449980CA120479A4ACC019E5232@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20260130191953.61718-2-jonathan.cavitt@intel.com>
 <DHUUHT136HPP.1L7OL7DR568Q6@kernel.org>
In-Reply-To: <DHUUHT136HPP.1L7OL7DR568Q6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|MN2PR11MB4517:EE_
x-ms-office365-filtering-correlation-id: bbd4b52c-1bd6-4b70-5138-08de9bf603c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 9YjJxphKxUxd4u3kIz7ktc6uziWKzoUdxr4l14VYlFbZF18hmVFgnMh2gjY+uvvitgmdaCyzYI7/T3hyrZfWl7OFICg+WfbQGOcvhU8lLINkHut4tSaXRrPt7SOiyHkKOL/4x9QYyG4ATU2WtgLsb6Ru4ckj+qHyHSS86A3I84aC5mI5IlcTnllrah0d/ySfldw8sGfVlqpWuAHp/lZhUoSBUGldEbtFtRWRCThHX1c+nUxarxWiqj1cqrdPRHqR46supNZ+euy7nNbfzZnQh+ieM6Xdz1VXF4IrFddekHQCKbrFG/Qqp1+z3+RMqEqSXqrtYuIaOdsitM1OywDCf5L/zxCRpLRps24dns0TUMj35ZycTbdDcFiqYLgudJd4YqYECmqePNLKtDocKS+wwmjmYSCXuK/wBiI/s2lHnC1jgUC9DnKu2UhC67PjxZsKoWDmFdpfEK7dYv5TIJfk416TCzpgsUFa8caj7GHGLNPzrvKeEdLaUBwWKbA3/99eYOUoznbqVA1cWgGfPW90X5yt94w5J6Wz3jrin5WJjzaeH1TRxD6BHiOkSbJQSkkFhVkwrXhghKmPu1TEcq3yidr9zW/FuuqPDD8lnkqT+wwwcWgjIPfrU4alBPaCO8eQvrtN1ZZa7knKwNX8sGEpGAFBX0uI8w0MOU5P7EGqtWmIc/TfNBiaWMk+rnHlW9soFHLEaE1o3br+jbW0yFqzw7Im+TxkqGbCbqGFKegV3PM1VVjQuW/4TAQROBbfregYkgxOsIbCMO72KkwGLgSEVzFLaNEJ/fRCb9Z7Idsbrqw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR11MB5444.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ui96VDNjT1pQczAzTXg4RmhWOVZXVno3QVM4Z0JaVVdXVGxSd281TE5ad2hF?=
 =?utf-8?B?NCtVNWJHSkp6bkZobDU3MFA0ck9kU1pRWUY1a0ozV0IyR1h4eEVzaU5qV0xW?=
 =?utf-8?B?c0FSRExEZHI1SlZTR2Z4UkJ2K3FZMEVEd0h4Q3Ewcnc4ZWRGN2RqT21zLzJz?=
 =?utf-8?B?Rmc5ZDc1cHQ3MTlVS1hpZWtLNEltRHJ0WmZBOTU5NEt4NEpPNzFnVmlBNVpO?=
 =?utf-8?B?azBVMGVXSTFLYXRSNWpDTlhycXQyVG9CTTZsV0szOEhtcXB0Uzg3aS9VRnZQ?=
 =?utf-8?B?OHNnTEFBUjJQaDNDT2syVFBIempxL2lFYUFBSktqREpBUVVXYUlDY2tsTDZD?=
 =?utf-8?B?d3VBUU14aEw3a0ZJTjltR2d1RlJmRWlsWW03RlhPZ1A2aUJUNXIrTlVCbkZT?=
 =?utf-8?B?dVJuTWZCUEdFUm1USEwyRHVxSE83US9vMFNXZDA1VUdRcHNaYXlOUXVadmlw?=
 =?utf-8?B?eHZibXZoUTBabzg0NUlibFZzZEJseXVVbUUxYUNTMitzR0RIem9peGNaWTMx?=
 =?utf-8?B?eEVkRUw4aFB6M2k0TDUrT2FOc09sNFhhY0VmNnJIU1J3YmJEVnJRY1VtMDZk?=
 =?utf-8?B?aGpzcm02Uy9XODVrNmdXbXYzMUlaK0R1R2ZCUGg4VG9WM2U3NGRRaTVZcXhJ?=
 =?utf-8?B?R2hEbGVOUytpQmNNWjNlWk95VnlRNUVzWUhESlhIWUg3QTljdzBpZU0ycEw1?=
 =?utf-8?B?WjBDcTdGWktMenllZGFSbHdHZndLNDBZeWNGWGo3QXhVOVpYdUxuN2grNE9v?=
 =?utf-8?B?dmg1dkV2Y3MwVkgxMVlBTWphbDNveityWW43SVNPOWt5QWlMZysvTEkyUVhq?=
 =?utf-8?B?aEVRMkRHK0Y3V25vZmRQSlRvNVVYL1R3T1JoUkxmem5sMDlmSjQ4aXEzekdQ?=
 =?utf-8?B?a2Q2d1hSZ1ZUOTVEYjd0UDlEai8rckFZcXNLSGIwaHpyRlFsUVF5YzRycncx?=
 =?utf-8?B?QlBVZUdtb2lKZ0VLL1BpaEdTbnd2YkRjWEx0RUhITTRyQnh4Q0d6ZzdpV2Ro?=
 =?utf-8?B?RERtNVJjTFRJaEgreHd5ZjVlQmNNNzVsa3YxYzd1OVF1a3U0SzlISlM0VXF1?=
 =?utf-8?B?YjhnSzRXSGh6a0VmRFgzd0VCek9kRmYyOHE3c21ZeFVxQ0lzWndaNTlWUXI1?=
 =?utf-8?B?ZnBabzlDMlpxQmVaaHRLTm5oWGl5WGtjZXF6MlVuQ0xPQVBoaHpEM0QzTTN2?=
 =?utf-8?B?WlFTUHFHWm1kYlJ6NGkwUUZja1JnWWpFdkFXK0gxL0xqZER6cXlmRmdrbVlX?=
 =?utf-8?B?S3AxeFNyeWJqZnpnRUczcTJCcStkMDY2QjY0dStEMCt1SURWYlFSWlZaMWJV?=
 =?utf-8?B?dm1mekM1Y0NINURKR0ZhRWFjYjJUQ0NyUkd2ZEZDejN2MW1ldlIyb1J5dC9i?=
 =?utf-8?B?RnFYOTQyWk5yM3hWZy9QeG42YVlLNktHS25qeXRjN3pyV01pcnh3Q0k3eFJD?=
 =?utf-8?B?MW9uNnRnM1V6eVU3enczckF1eDFNOTNBbTZuWmlTRWdyekJoa2FkNWd3OU5S?=
 =?utf-8?B?R0dES1IwdGpRSno0WjVoMENML0FBSmRDWG5YZjN5MGhQUEhmZ0tjMzFnUmt0?=
 =?utf-8?B?em9raUpSUHpGODlDNmMvNXBsak1rcGdCWkt4NFFyaG8ybUt5eDFsUmkvczV2?=
 =?utf-8?B?clVqVFRnQ1hEbTNGaWlFdVNzVVAxKzhQaFpNSjkxQWh4djRnbXBQRW5wY2R2?=
 =?utf-8?B?YmJvTXBGcVE1R0FyWHV6SWw0VGpweWh1OHBPUGNSc3BTYnpySTAxTzJXaTZp?=
 =?utf-8?B?K2RoRkVxLzQ1VzI2cTlsS0RCekhpUFNCQ3JlRUJta1NQNHlhUndldERPc2dk?=
 =?utf-8?B?bW56N1IydzFGV3JRNDR4WUdhbG9hMjNMeXludno1Yi9DcitvU0xBcGZEWnlo?=
 =?utf-8?B?NG5hRGxCMHF5d2UzWVlDVTQydThpNGpxeStBSHYvVHpuaDQ3ekNrZFlUTXdr?=
 =?utf-8?B?QVMyRjlqak1BMjBhR3JWb3hQR1lWN1E5ZnNxeFJVeGhvSzlYclpGM3ROTFNp?=
 =?utf-8?B?YnFYeGVVUjFySlJLdFRmZmQrUjJZNnVwSTh3cG1xVTBqcitkQ2UyUWFxOGI5?=
 =?utf-8?B?K0pKNTlzdXhNcjYvUWdsR1VxZU05SkJ5VlpybWlKUlBrYWV1ZFltOUVzYjBW?=
 =?utf-8?B?NDNOd0Ezb1pPQXd1aTBnSVFGQksrMXI2REQrTHMzeTIvODRlTHNSZlB5Yzda?=
 =?utf-8?B?cUF4U0tkdHV3YkF4ZTJ3T09ZSDJ5ZFVqR2tJeko3amxmUXoyNHZwZVJjWG0x?=
 =?utf-8?B?Tjk1YWtDYnAxa0RzVzNVSmxxbkhTL2QyNWZBblhTSWdKbUM4V2ozek5UeWQ2?=
 =?utf-8?B?WVFOT2JmVWVYY2ZidTVBN0tKVzE5ODBQTWpGbkg0cUkzL3RtUFpNZlNLT01S?=
 =?utf-8?Q?JjSmPuijLFDlTcOdCjV51i57SfOMkR0ifP5EpSoE6JDa+?=
x-ms-exchange-antispam-messagedata-1: CupSkZGB8CHe8g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mZo9L+mW0Lt1+HDaQuINyHGYevOpdJPuawG+EW2Cj+5UW6WYwkMDHGUujy/W55R5mJO1lse+povvCOICq6mqkiwdA4kmnbwUSqwrt085QxDb/MGT9PyW+W6vb02VSKd1lDnJ9U0vkMIZ0zbByTTSoNboIJ/wGW+QsyJv6cN2Yu18UI2MRIFC/hSnKpWfCSSrnVX/KYuN3en1jJY6ZfH5LHYwqySBx9AwsFUU/Gb5vuga1Mi7rq4mh5UZDfZ75Q4k7gPiOJnq5q0Ohtp6j/Qi4DykDamSEW+Kcs55ZfNlL1sSKeeUxfSRTMqMkjNPRgX0llf27pDcY656Ruq2inncpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd4b52c-1bd6-4b70-5138-08de9bf603c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 20:23:26.0367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8gyos3HlODHgUMmPpOYaLfnJvR6E95WAVKxjvpcp4vrVgpLuUqbgQjuVhG2TVyYwXhyTqNJlCXbgG1bc4QLZ8zJ+RiQ4JZb0wQ8GxE6zsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
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

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IERhbmlsbyBLcnVtbXJpY2ggPGRha3JA
a2VybmVsLm9yZz4gDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMTYsIDIwMjYgMTowMSBQTQ0KVG86
IENhdml0dCwgSm9uYXRoYW4gPGpvbmF0aGFuLmNhdml0dEBpbnRlbC5jb20+DQpDYzogZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgR3VwdGEsIFNhdXJhYmhnIDxzYXVyYWJoZy5ndXB0
YUBpbnRlbC5jb20+OyBadW8sIEFsZXggPGFsZXguenVvQGludGVsLmNvbT47IEJyb3N0LCBNYXR0
aGV3IDxtYXR0aGV3LmJyb3N0QGludGVsLmNvbT47IHRob21hcy5oZWxsc3Ryb21AbGludXguaW50
ZWwuY29tOyBhbGljZXJ5aGxAZ29vZ2xlLmNvbTsgZHJpLWRldmVsIDxkcmktZGV2ZWwtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vZ3B1dm06
IERvIG5vdCBwcmVwYXJlIE5VTEwgb2JqZWN0cw0KPiANCj4gKENjOiBBbGljZSkNCj4gDQo+IE9u
IEZyaSBKYW4gMzAsIDIwMjYgYXQgODoxOSBQTSBDRVQsIEpvbmF0aGFuIENhdml0dCB3cm90ZToN
Cj4gPiBTdGF0aXMgYW5hbHlzaXMgaXNzdWU6DQo+ID4NCj4gPiBkcm1fZ3B1dm1fcHJlcGFyZV9y
YW5nZSBpc3N1ZXMgYW4gZXhlY19vYmplY3RfcHJlcGFyZSBjYWxsIHRvIGFsbA0KPiA+IGRybV9n
ZW1fb2JqZWN0cyBtYXBwZWQgYmV0d2VlbiBhZGRyIGFuZCBhZGRyICsgcmFuZ2UuICBIb3dldmVy
LCBpdCBpcw0KPiA+IHBvc3NpYmxlIChhbGJlaXQgdmVyeSB1bmxpa2VseSkgdGhhdCB0aGUgb2Jq
ZWN0cyBmb3VuZCB0aHJvdWdoDQo+IA0KPiBJdCBpcyBub3QgYXMgdW5saWtlbHkgYXMgeW91IG1p
Z2h0IHRoaW5rLiBUaGUgZG9jdW1lbnRhdGlvbiBvZg0KPiBkcm1fZ3B1dm1fZm9yX2VhY2hfdmFf
cmFuZ2UoKSBleHBsaWNpdGx5IHN0YXRlczoNCj4gDQo+IAkiVGhpcyBpdGVyYXRvciBkb2VzIG5v
dCBza2lwIG92ZXIgdGhlICZkcm1fZ3B1dm0ncyBAa2VybmVsX2FsbG9jX25vZGUuIg0KPiANCj4g
QW5kIHRoZSBrZXJuZWxfYWxsb2Nfbm9kZSBkb2VzIG5vdCBoYXZlIGEgR0VNIG9iamVjdCBzZXQu
IEFsc28sIGRyaXZlcnMgYXJlIGZyZWUNCj4gdG8gaW5zZXJ0IFZBcyB0aGF0IGRvIG5vdCBoYXZl
IGEgR0VNIG9iamVjdCBzZXQsIGUuZy4gd2hlbiB0aGV5IGhhdmUgdGhlDQo+IERSTV9HUFVWQV9T
UEFSU0UgZmxhZyBzZXQuDQo+IA0KPiA+IGRybV9ncHV2bV9mb3JfZWFjaF92YV9yYW5nZSAoYXMg
Y29ubmVjdGVkIHRvIHZhLT5nZW0pIGFyZSBOVUxMLCBhcyBzZWVuDQo+ID4gaW4gb3RoZXIgZnVu
Y3Rpb25zIHN1Y2ggYXMgZHJtX2dwdXZhX2xpbmsgYW5kIGRybV9ncHV2YV91bmxpbmtfZGVmZXIu
DQo+IA0KPiBUaGF0IHNhaWQsIHRoZXJlIGlzIGEgInJlYWwiIGp1c3RpZmljYXRpb24sIG90aGVy
IHRoYW4gIndlIGRvIHRoZSBzYW1lIHRoaW5nIGluDQo+IG90aGVyIGZ1bmN0aW9ucyIgdGhhdCB3
b3VsZCBoYXZlIGJlZW4gZ29vZCB0byBwdXQgdGhpcyBpbnRvIHRoZSBjb21taXQgbWVzc2FnZS4N
Cj4gDQo+IFRoZSByZWFzb24gSSBzYXkgIndvdWxkIGhhdmUgYmVlbiIgaXMgYmVjYXVzZSB0aGlz
IHBhdGNoIGhhcyBhbHJlYWR5IGJlZW4NCj4gYXBwbGllZCAtLSB1bmZvcnR1bmF0ZWx5IHdpdGhv
dXQgZ29pbmcgdGhyb3VnaCB0aGUgY29ycmVzcG9uZGluZyBtYWludGFpbmVyIChhbmQNCj4gbm9u
LUludGVsIHJldmlld2VycykuIEkgb25seSBub3RpY2VkIGl0IGJ5IGFjY2lkZW50IGFzIEkgc2F3
IGl0IHBvcCB1cCBpbg0KPiBkcm0tbWlzYy1uZXh0Lg0KPiANCj4gTm8gYWN0aW9uIG5lZWRlZCBh
cyB0aGUgY29kZSBpdHNlbGYgaXMgb2J2aW91c2x5IGNvcnJlY3QsIGJ1dCBmb3IgdGhlIG5leHQg
dGltZSwNCj4gcGxlYXNlIG1ha2Ugc3VyZSB0byBzZW5kIHBhdGNoZXMgdG8gdGhlIGNvcnJlc3Bv
bmRpbmcgbWFpbnRhaW5lcnMgYW5kIHJldmlld2Vycy4NCg0KUXVlc3Rpb24gZm9yIHRoZSBmdXR1
cmU6DQpJcyBMYW5raG9yc3QsIE1hYXJ0ZW4gYSBwcm9wZXIgbWFpbnRhaW5lciBmb3IgdGhpcyBj
b21wb25lbnQ/DQpJZiBub3QsIGlzIHRoZXJlIGEgbGlzdCBJIGNhbiByZWZlcmVuY2UgdG8gZGV0
ZXJtaW5lIHdobyB0aGUgcHJvcGVyIG1haW50YWluZXJzIEkgc2hvdWxkDQpiZSBjb250YWN0aW5n
IGFyZT8NCi1Kb25hdGhhbiBDYXZpdHQNCg0KPiANCj4gLSBEYW5pbG8NCj4gDQo=
