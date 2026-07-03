Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4A4C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C83410E5AF;
	Fri,  3 Jul 2026 09:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k55TRQq+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE2210E5AF;
 Fri,  3 Jul 2026 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783072459; x=1814608459;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CoXkzgDhmQAAM/Dw6Z+elOVla2tEDvvdNqFop86pVIc=;
 b=k55TRQq+xi2Tizso1snZ2Znwr9uUZ7AOjBfY+t09w0XKh/umhwzlvVLA
 5T+UtgPV7Lmy5BJbBtj24xKlcDcq+FPhXiWEuJ2xAGGCT+tfJl/Gsuhja
 xH51V9+YOqFtFeg92mX2tv7aC5phgftpP9XIk1s939QY0zWHJCxo4zJ1Z
 EK0n/3NNoNuXhEg9W1awUKRpPlOktSVqwXMfdOO68AGY2f7SNSFHZYXGs
 TB45VbCH0b1MqJEeoCt/isJvzgywJwasApISJ4SqAgcsEBMrjn6Dg2nQO
 Wy3pAdQ8vis9RLsLQJ84jG7GY2B2GGSy+FWdyDAjsu1nbRu9y9gm2tjbv w==;
X-CSE-ConnectionGUID: Z6XTZv+lRLq9W3tFQtGujw==
X-CSE-MsgGUID: zfMxtWNXTzmB7hy4RrPF6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83691753"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="83691753"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 02:54:19 -0700
X-CSE-ConnectionGUID: rtPGWxmSSJyzUVxiYtAX+Q==
X-CSE-MsgGUID: AEv/zY7ZTue4do97rHfy9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="256656409"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 02:54:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 02:54:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 02:54:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 02:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHstf5mfJ/supQsdPzL3PX6ZE4kv6QPNhJXFRcGdFzgY6czuK051xaJg1Tvwic6XPT7z0lnxMpKr3ttw5eBv0nQMigKB9DTtVWf7S3jOMUnW/R0wITgd2KyEXe3OutskIpQmGrjfYbkL/fxv7oLEYN/96UafdEXdjjBYJgu5RLCb/sBSTuWfKCdcAkeGQxlK9BNZiz0/RJjeFNJm3Xkjs7+HmxZRjGruZUdwi8LxKrY3lMcM2+buP/c89s3ttaiMAmlGB6Tcp+v+WWBAbP0ZNeUtNcO2U6cYG8dYFcYgVh6Cm9JJ45Slce/DFIWTBOlgCC6M2m+gF7cErMFb54iuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoXkzgDhmQAAM/Dw6Z+elOVla2tEDvvdNqFop86pVIc=;
 b=wjnyLaNuwCu4NgyctxoAr4Qfn0ny+gZIL7OTP6hWy3PzeD2OWc2Giqicg491xbyr6L1BSQMtZ+xtKnJ1Sj3Bd8snTl0BKUcTZcGGpxcKkEdDsJSNwzMg9NeS94gWxA3+8tTGICWdzIDnbAOuXme3k23eswP5BuV+7EiQb+w+QjjhCjLWIj6Q3uWpA9z71HqaZaUhx//+B2mNdE7WhWmHqsHLkHbFpLDgn/Br7lkLGCiO5QJNmSwa5p1g+Fq2pKIqschFbOg3jXtu6MCrJSzrFBUThrJpll7k695WzkNF9Zi5UBXtYRUzntGgoWxdbA0TZVUbJKLVpdOVtH2vK0pIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9251.namprd11.prod.outlook.com (2603:10b6:208:56f::13)
 by DM4PR11MB6406.namprd11.prod.outlook.com (2603:10b6:8:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 09:54:14 +0000
Received: from IA4PR11MB9251.namprd11.prod.outlook.com
 ([fe80::c87c:19e3:6b0b:1931]) by IA4PR11MB9251.namprd11.prod.outlook.com
 ([fe80::c87c:19e3:6b0b:1931%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:54:14 +0000
From: "Sokolowski, Jan" <jan.sokolowski@intel.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 "igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>
CC: "siqueira@igalia.com" <siqueira@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Christian
 Koenig" <christian.koenig@amd.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?=
 <thomas.hellstrom@linux.intel.com>, Kamil Konieczny
 <kamil.konieczny@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: RE: [PATCH i-g-t v3 0/7] add dmem_cgroups test
Thread-Topic: [PATCH i-g-t v3 0/7] add dmem_cgroups test
Thread-Index: AQHdCiMXIROgPCVAa0OdorrtyRE+/bZbj1FQ
Date: Fri, 3 Jul 2026 09:54:14 +0000
Message-ID: <IA4PR11MB9251D24975F81CFD242F88F299F42@IA4PR11MB9251.namprd11.prod.outlook.com>
References: <20260702130108.1397444-1-cascardo@igalia.com>
In-Reply-To: <20260702130108.1397444-1-cascardo@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9251:EE_|DM4PR11MB6406:EE_
x-ms-office365-filtering-correlation-id: 0b46bcd8-4f90-4f7e-44cb-08ded8e90a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|11063799006|6133799003|56012099006;
x-microsoft-antispam-message-info: +9siv4BBdFxR3JOi7o8jKflHl1bkI8ULXVTZPKs1baSZCU+A9w0U2QL4CTXSaktWLFg/QgoJN2XjeP+p7ZW5ePB+X4rYyoAMUvCfcyVuDXhASe89Jiqh/nxFbv/pkkxZ6Y1TyZFqivBd6qHZeiig/47H3kF374QKUrvk9xCsGwmsbl+t8u7+WAsufKITI09hyNN0T+Qi4E3GXcke77BwfHwM0LJCpcmncQ0IWbHKP1aCR+jWGQr/cHJX5E6jVUL44IaFwM0A1llBbMeMMMODgkrs9r7ahMbvyjT2p4869HPxHPKPWFulkl+mE8Tg0oY14E+TpsId4JzeahE63ha5rsIL2laYTvE040VZV7EJ27YTwLotxsdI1EM2MaBbHnNmfmxiUA+LVtyBzCvepIg3pfHInwQbMBaeW54KzQH83Z6L8Tph++w4mokhGXnucuu6sPsoGZ732hTAroSWvuv8OD6tR1/8guIKtCG1dK/Ny9vKLNn7NJlaxmDFQZtxURuJfx1WWhUv2a5oYX5ol/NToNKUd/K/2qBOj+FLvBpuqkwnNDtW88VB4H9CjyRq9BP2BcHJtThIalQ2gPRCTdy+WlT4NoRk46g9/fVFmmPacOOEo5A1yNVbo8yDWR3bjZbozIMDuNuXMjFpAnXL3L+g6kD1bK/vuXc0iGegR5/SdEs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9251.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzlkR3U3NUREaXdINnVuUVAzMnNjWUd0a29FQmdUeW0vUW1hOFJpa2o0UTF3?=
 =?utf-8?B?Q2tYUmVxYjAzSzhSR1dLQmVxcmVDalN1Y05ZcUV6aUlCMGovckdJd1hCRDd2?=
 =?utf-8?B?YlNaVm5kWitlTExtVGlka3JuMll4cTlkZE44UU9tSlBOQ3p6S2laVkRtS0RT?=
 =?utf-8?B?U3F2Qm5HeGlnMFlRQ3lNQW5NenJtVmlVS1FjQi9BUTErdTBlUVdxMmVPVnli?=
 =?utf-8?B?VnB1eE1MTk9VV2NtN1kzOW16MzBGZVZHbzF3ZW8vWXFjN0xHekJzODEvZnlY?=
 =?utf-8?B?bTVyRzF3bU5PV01IRnFDTUVWeHNkZWJtZWV4SG1OcGxRTGpyQ2VvVE1VUG53?=
 =?utf-8?B?cEZJMU5JQThKWXMyRFZLS2wzeC9iSXN2UkZyT3hNOVFDbFYzMFBWbjZoanR0?=
 =?utf-8?B?ZDdQVFVLSXV4a3BHSUV4MVVBZ3k5YzZzTTBpNWd4L1JDcGFnUDl0YW1uS0wx?=
 =?utf-8?B?bUxLOFVrVlhHZFlJbVpPblhvZGo3c21JTlU3ODF1TEJZOGpxWFBMWHlVUWJ2?=
 =?utf-8?B?QktWd0tWWUVhdHlEZDJ6TERQc1pValQySEx3SWdMc2JmL09aRXhLODVEMnJO?=
 =?utf-8?B?c2FIQU9VL1liRE01N3pReGY4RlM0WTZuSjdmMURIeXdZZjZTY1k2Q2drU3Na?=
 =?utf-8?B?aHBZVkUzSGRKWHgyRHhNN09jL2EzQTM2ZS9VNnI2WDVhK2k3UEZtNTRpS1JF?=
 =?utf-8?B?bDRMM0d3TTBCZGVnbDY2VVlEMndGbWNJUDhadUVuVFowNGZvQUwvOCtJdjZl?=
 =?utf-8?B?Z2p2K2Y5bE02bzBGN1l2QkdzemgzK3VlVjdnaHkrU0gwWnl2TldJM3E5bE1H?=
 =?utf-8?B?S0ZvMmJ2NUkveDNPblBtaXE2azQwdXMxZlpyeVIzM1ZVc1lYK3hYNTBDODds?=
 =?utf-8?B?a0RiSmtSYmJQT21Pbm5mM1k2dFpHWHJNM2h1QUhsZTZVN2JETDlrVzFsWVhX?=
 =?utf-8?B?eGI1UXc3SHNmc2Z5MFE4eWNZZDVZSmtwdTV1dlJVNXNudG53WHJyWEJVQ1ZT?=
 =?utf-8?B?UENub2lqN0RmRWFqeXFmS1p1QXlTUXRZNHBRVXhMSGZoRFZxU0F0dnJMWjJC?=
 =?utf-8?B?Z3E5L1hJeUxyNDFmeWxUeHZWM0tnS0hlMzdHWXAyd01uc0FIL0M5QnZ5TTc1?=
 =?utf-8?B?Vm9xNnV2cVVmVlh3K1g5R2JZNXJSUm9JU2xESG1EUVdPdDhmWUtKQ3ZQTlJn?=
 =?utf-8?B?czZzWi93RnhXZ3h3S2taVkozMnZxWHZDZHdUOWd2bDJ2dHNXQ2RzZ3QySmZE?=
 =?utf-8?B?US91Um9wL2RiYjZnL3JVYjZQUy9tbUdNNEx4Sm5zVmx6YUlSVmk5T3U5NHdX?=
 =?utf-8?B?M1Vnc2l6MDRKU3M1cjJmNUpDRzBVbmtoQW5mdXZocWRyYS9ZamYrd1M2SDFD?=
 =?utf-8?B?NU1hRmFXSVM0ckVKY1kwMjh3NXg5VDh3OUFJYUhlTmh6T0VTcmNsRy9ueWFJ?=
 =?utf-8?B?bzJZNGIzSVB1alBjbFZiaEM1MlhjaUdCdUh5bzF2QXNEVG1uNW5PTEl5TEwv?=
 =?utf-8?B?dGo1dVh0U01sSjBRL3pOQjVvNFJwbEJsWWcwUUg3ZGdiUGpOdnMrVllrbHRB?=
 =?utf-8?B?bGhvbDROSVAyMXdYTEk3aFBQOTFJdEVyWW1KRzJBY05EZTVDcXR4R2I5T1Ez?=
 =?utf-8?B?UWRJZ0NJM1BGR0RRWHBIZmMxcE9vU0FIWC9PZkIwRFpERytOZk10V29Zcm1U?=
 =?utf-8?B?N2FrUFNwODhqNW9QV2VQWUxlMzVnMGVucTl3K0ZEL1d0cUVVY1lRRWE1VGlj?=
 =?utf-8?B?blNRaEQwZEhERTNnc2t3bkRzaTYwY3J5SjhENGpmNHI5dy93MnlSVEVnaDFO?=
 =?utf-8?B?eHdxTVZDOHM4b1VlS1VpMk1ReTdGYjAyclN2R3ZMK0phVk15VzJ1MzlvL0ds?=
 =?utf-8?B?b1FYd0NEUEVWUDV1TExuZitpNXlsSC9ERHRiSmRMeFhGZTA4MzhaVkNKcE1Y?=
 =?utf-8?B?SXU5WEp0RUY0YW9aRFBjZGpIa1BJZEU5TXBiODJaU0p6ZTRMZjFUTUV2UjNj?=
 =?utf-8?B?dzJpQ3NYMjhOdUd2TnJUU2pjSUdIWkp6UFY4dGR1Y2hGTnF1RXFhemRNU1Ix?=
 =?utf-8?B?N3Z0TkErU003Rm1HOUxWZHhuUWxPV3RDTzJtRVQ4bGoxdThnWmdjbGplSyto?=
 =?utf-8?B?WUlUendHQUt6elBNeHNlbGhrYkROZWpwazhHcmJDSGhOYjl1bnJ0aWZ2TXl1?=
 =?utf-8?B?dEZjNUsyNzdhY2NlRm41bk5JeFZKdkMyeFp1eUgyUjNuSU9PVThhd2taMTh3?=
 =?utf-8?B?QXRsVGMwNlh3cEx0VG5HUnVLc0FobWhydEVJdlhSSmNVcEU3NjZ2SnNYMUN6?=
 =?utf-8?B?a2FRanJnaUxNR1BjTnozT0QzQmY2Q2pVOVZuU0lZQlpSWnJXNlcrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KlGfZH3nIyTzzta2Wv6KX+ZUjvW4ZDlaAxwXEpUT9gN8srTXnczMdEvWfN3qNNh2ICYEEUpz+/V5g8stYqr3Pq9i+XFpIMozav+ouF69t+0BZ0HoABZA5iqggGrGjMkwhf6EZTv8yC00t7iNZWOLqvYuejKQKa38c0+pHK2/C+AmadNMl6NdhbyitLksnHbuBrECZnYAxJe2Ws04KlyUQGCDHQfFoN/FNLGAy53C5iR0s63QXpWNVuwyq0iNxv/85Tdsn1GrYE78ogoP2jdSh214nsEVuQ+sn5hfSJZLd7sawiuVa6UXJfFRA5ipXrrT+FKZdRfnrujwqyFMxSP/xA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b46bcd8-4f90-4f7e-44cb-08ded8e90a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 09:54:14.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02NpVexZ4KZtWtxSxd57gmXdiPtBNCXqm7ohvyrRDSKfOy6QkJjArH+nVwRpGlSGlP8+QJcEBXn23j8jIHKTgAJ0DL+GP2yz8jAUf5B0iq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6406
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

SSBkb24ndCBrbm93IGlmIHRoYXQncyBhIHByb2JsZW0gb3Igbm90LCBidXQgeW91ciBwYXRjaGVz
IGluIHBhdGNoIHNlcmllcyBhcmUgdGl0bGVkIGFzIHYyIGluc3RlYWQgb2YgdjMsIGF0IGxlYXN0
IHRoYXQncyBob3cgSSBzZWUgdGhlbS4NCg0KSmFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogaWd0LWRldiA8aWd0LWRldi1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz4gT24gQmVoYWxmIE9mIFRoYWRldQ0KPiBMaW1hIGRlIFNvdXphIENhc2NhcmRvDQo+IFNl
bnQ6IFRodXJzZGF5LCBKdWx5IDIsIDIwMjYgMzowMSBQTQ0KPiBUbzogaWd0LWRldkBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IHNpcXVlaXJhQGlnYWxpYS5jb207IFRoYWRldSBMaW1hIGRl
IFNvdXphIENhc2NhcmRvDQo+IDxjYXNjYXJkb0BpZ2FsaWEuY29tPjsgZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRl
bC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IENocmlzdGlhbiBLb2VuaWcNCj4gPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT47IG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbTsgVGhv
bWFzDQo+IEhlbGxzdHLDtm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPjsgS2Ft
aWwgS29uaWVjem55DQo+IDxrYW1pbC5rb25pZWN6bnlAbGludXguaW50ZWwuY29tPjsgSmFudXN6
IEtyenlzenRvZmlrDQo+IDxqYW51c3oua3J6eXN6dG9maWtAbGludXguaW50ZWwuY29tPjsgVml0
YWx5IFByb3N5YWsNCj4gPHZpdGFseS5wcm9zeWFrQGFtZC5jb20+OyBOYXRhbGllIFZvY2sgPG5h
dGFsaWUudm9ja0BnbXguZGU+OyBUdnJ0a28NCj4gVXJzdWxpbiA8dHZydGtvLnVyc3VsaW5AaWdh
bGlhLmNvbT47IGtlcm5lbC1kZXZAaWdhbGlhLmNvbQ0KPiBTdWJqZWN0OiBbUEFUQ0ggaS1nLXQg
djMgMC83XSBhZGQgZG1lbV9jZ3JvdXBzIHRlc3QNCj4gDQo+IHYzIFRMRFI6DQo+IFNlbmRpbmcg
YWdhaW4gZm9yIGZpeGVzIHdoZW4gcnVubmluZyBvbiB0b3Agb2YgWGUuDQo+IA0KPiBUaGlzIHBh
dGNoc2V0IGlzIGJhc2VkIG9uIHRoZSB3b3JrIG9mIFRob21hcyBIZWxsc3Ryw7ZtIGF0IFsxXSBh
bmQgYQ0KPiBmb2xsb3d1cCBJIGhhdmUgc3VibWl0dGVkIGF0IFsyXS4gVGhpcyBpcyBub3cgYSB2
Mywgc2luY2UgSSBzdWJtaXR0ZWQgWzZdLg0KPiANCj4gV2l0aCB0aGlzIHZlcnNpb24sIEkgcmV2
ZXJ0ZWQgdGhlIG9yZGVyIGluIHdoaWNoIHRvIGFwcGx5IHRoZSBwYXRjaHNldHMsIGFzDQo+IHRo
aXMgb25lIGFkZHMgdGhlIGluZnJhc3RydWN0dXJlIGFuZCB0aGUgZHJpdmVycyBtZWNoYW5pc21z
LCBhbmQgYSB0ZXN0IGZvcg0KPiBkbWVtLmN1cnJlbnQgYW5kIGl0cyBiZWhhdmlvciBhcm91bmQg
ZG1lbS5tYXggdGhhdCBpcyBjdXJyZW50bHkNCj4gc3VwcG9ydGVkDQo+IGluIHRoZSBrZXJuZWwu
DQo+IA0KPiBBcyBmb3IgdGhlIG5ldyBkbWVtLm1heCBldmljdGlvbiBiZWhhdmlvciwgaW50cm9k
dWNlZCBieSBbM10sIGl0IGhhcyBiZWVuDQo+IHB1c2hlZCB0byBhIGJyYW5jaCBhdCBbNF0uIElm
IHByZWZlcnJlZCwgSSBjYW4gc3VibWl0IHRoZSB0d28gcGF0Y2hlcw0KPiBpbmRlcGVuZGVudGx5
Lg0KPiANCj4gSSBoYXZlIHJ1biB0aGUgdGVzdHMsIGluY2x1ZGluZyB0aGUgb25lcyB0aGF0IHRl
c3QgZG1lbS5tYXggZXZpY3Rpb24NCj4gYmVoYXZpb3Igb24gYSBzeXN0ZW0gd2l0aCBhIDFHaUIg
VlJBTSBhbWRncHUgY2FyZC4gUm9kcmlnbyBTaXF1ZWlyYQ0KPiBoZWxwZWQNCj4gbWUgcnVuIGl0
IG9uIGEgWGUgc3lzdGVtLiBXZSBoYXZlIGFwcGxpZWQgdGhlIHBhdGNoc2V0IGF0IFszXSBvbiB0
b3Agb2YNCj4gY3VycmVudCBsaW51eCBvcmlnaW4vbWFzdGVyIFs1XSwgd2l0aCBhIGZpeHVwIGZv
ciB0aGUgYW1kZ3B1IGRyaXZlci4NCj4gDQo+IE5vdywgZm9yIHRoZSBjaGFuZ2VzIHNpbmNlIHYx
IFsyXToNCj4gLSBDaGFuZ2VkIHRoZSB0ZXN0IG5hbWUgZnJvbSBkcnZfZG1lbV9jZ3JvdXBzIHRv
IGRtZW1fY2dyb3Vwcy4NCj4gLSBIYXZlIHN5c3RlbSBpbmNsdWRlcyBiZWZvcmUgaWd0IG9uZXMu
DQo+IC0gRG9jdW1lbnRlZCB0aGUgY3VycmVudCBTVUJURVNULg0KPiAtIENoYW5nZWQgZnJlZV92
cmFtIGRyaXZlciBob29rIHRvIG9ubHkgcmVsZWFzZSBhIGdpdmVuIEJPLiBUaGlzIGFsbG93cyBm
b3INCj4gICB0aGUgZXZpY3Rpb24gdHJpZ2dlciBieSBhIG5ldyBhbGxvY2F0aW9uIGFkZGVkIGJ5
IHdyaXRlX2V2aWN0aW9uX25vbmJsb2NrDQo+ICAgc3VidGVzdC4NCj4gLSBDaGFuZ2VkIGFsbG9j
YXRlX3ZyYW0gdG8ga2VlcCBtb3JlIHN0YXRlIG5lY2Vzc2FyeSBmb3IgcmVsZWFzaW5nIGEgc2lu
Z2xlDQo+IEJPLg0KPiAtIEFkZGVkIGEgZ2xvYmFsIGZyZWVfdnJhbSBoZWxwZXIgdG8gZnJlZSBh
bGwgYWxsb2NhdGVkIFZSQU0uDQo+IA0KPiBDb21wYXJlZCB0byB2MyBvZiBbMV06DQo+IC0gSSBo
YXZlIGtlcHQgd2FpdF9mb3JfdXNhZ2VfZHJvcCBhcyByZWxlYXNlIGNhbiBiZSBsYXp5IGFuZCB3
ZSB0ZXN0IGZvciBpdA0KPiAgIG9uIHRlc3RfY3VycmVudCBTVUJURVNULCBidXQgaGFkIFVTQUdF
X0RST1BfVElNRU9VVF9NUyBiZSBhIGxpdHRsZQ0KPiAgIGxvbmdlci4NCj4gLSBDaGFuZ2VkIEJP
X1NJWkUgYW5kIEVWSUNUX1NURVAgdG8gYWxsb3cgZm9yIG1vcmUgdGhhbiB0d28gZXZpY3Rpb24g
c3RlcHMNCj4gICBvbiBhIDFHaUIgVlJBTSBzeXN0ZW0uDQo+IC0gUmVkdWNlZCBVU0FHRV9TTEFD
SyB0byBhdm9pZCBmYWxzZSBwb3NpdGl2ZXMsIGJ1dCBzdGlsbCBhbGxvdyBmb3Igc29tZQ0KPiAg
IHBhZ2UgdGFibGUgYWNjb3VudGluZy4NCj4gDQo+IENvbXBhcmVkIHRvIHYyIG9mIHRoaXMgb25l
IFs2XToNCj4gDQo+IC0gSWdub3JlIC1FTk9NRU0gYW5kIC1FTk9TUEMgd2hlbiB0cnlpbmcgdG8g
ZmlsbCBWUkFNLg0KPiAtIFdoZW4gbGltaXRpbmcgbWF4IG1lbW9yeSwgYWxsb3cgZm9yIHNvbWUg
c2xhY2ssIGFzIHRoZXJlIG1pZ2h0IGJlIHNvbWUNCj4gICBvdmVyaGVhZC4NCj4gLSBPbiBYZSwg
YWxsb2NhdGUgR0VNIG9iamVjdCB3aXRoIG5vIGRlZmVycmVkIGJhY2tpbmcsIGFuZCBza2lwIGJp
bmRpbmcuDQo+IA0KPiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Nlcmll
cy8xNjM5MzUvI3JldjMNCj4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9z
ZXJpZXMvMTY2NDk2Lw0KPiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLWRldmVsLzIw
MjYwNjExMTczMzAxLjE3NDczLTEtDQo+IHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29t
Lw0KPiBbNF0gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2Nhc2NhcmRvL2lndC1ncHUt
dG9vbHMvLQ0KPiAvY29tbWl0cy9kbWVtX21heD9yZWZfdHlwZT1oZWFkcw0KPiBbNV0gNTAyZDgw
MWYwYWIwICgiTWVyZ2UgdGFnICdlcm9mcy1mb3ItNy4yLXJjMScgb2YNCj4gZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3hpYW5nL2Vyb2ZzIikNCj4gWzZdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2RyaS1kZXZlbC8yMDI2MDYyMzE3NDMxOS40MTM4NjQ4LTEt
DQo+IGNhc2NhcmRvQGlnYWxpYS5jb20vDQo+IA0KPiANCj4gVGhhZGV1IExpbWEgZGUgU291emEg
Q2FzY2FyZG8gKDQpOg0KPiAgIGxpYi94ZTogSW50cm9kdWNlIGRtZW0gZHJpdmVyIGFuZCBpbXBs
ZW1lbnQgWGUgc3VwcG9ydA0KPiAgIGxpYi9hbWRncHU6IGFkZCBhbWRncHVfY2dyb3VwX3JlZ2lv
bl9uYW1lDQo+ICAgbGliL2FtZGdwdTogYWRkIGFtZGdwdSBzdXBwb3J0IHRvIGlndF9kbWVtX2Ry
aXZlcg0KPiAgIHRlc3RzL2RtZW1fY2dyb3VwczogYWRkIHRlc3QgZm9yIGRtZW0uY3VycmVudA0K
PiANCj4gVGhvbWFzIEhlbGxzdHLDtm0gKDMpOg0KPiAgIGxpYi9pZ3RfY2dyb3VwOiBhZGQgY2dy
b3VwIHYyIGFuZCBkbWVtIGNvbnRyb2xsZXIgaGVscGVycw0KPiAgIHRlc3RzL2Nncm91cF9kbWVt
OiBhZGQgZG1lbSBjZ3JvdXAgY29udHJvbGxlciB0ZXN0DQo+ICAgbGliL3hlOiBhZGQgeGVfY2dy
b3VwX3JlZ2lvbl9uYW1lKCkgaGVscGVyDQo+IA0KPiAgbGliL2FtZGdwdS9hbWRfZG1lbS5jICAg
fCAgOTkgKysrKysrKw0KPiAgbGliL2FtZGdwdS9hbWRfbWVtb3J5LmMgfCAgMjUgKysNCj4gIGxp
Yi9hbWRncHUvYW1kX21lbW9yeS5oIHwgICAyICsNCj4gIGxpYi9pZ3QuaCAgICAgICAgICAgICAg
IHwgICAxICsNCj4gIGxpYi9pZ3RfY2dyb3VwLmMgICAgICAgIHwgNjM4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGxpYi9pZ3RfY2dyb3VwLmggICAgICAgIHwg
IDU2ICsrKysNCj4gIGxpYi9pZ3RfZG1lbV9kcml2ZXIuaCAgIHwgIDI1ICsrDQo+ICBsaWIvbWVz
b24uYnVpbGQgICAgICAgICB8ICAgMyArDQo+ICBsaWIveGUveGVfZG1lbS5jICAgICAgICB8IDE0
MyArKysrKysrKysNCj4gIGxpYi94ZS94ZV9xdWVyeS5jICAgICAgIHwgIDMyICsrDQo+ICBsaWIv
eGUveGVfcXVlcnkuaCAgICAgICB8ICAgMiArDQo+ICB0ZXN0cy9jZ3JvdXBfZG1lbS5jICAgICB8
ICA5MiArKysrKysNCj4gIHRlc3RzL2RtZW1fY2dyb3Vwcy5jICAgIHwgMjQ1ICsrKysrKysrKysr
KysrKw0KPiAgdGVzdHMvbWVzb24uYnVpbGQgICAgICAgfCAgIDIgKw0KPiAgMTQgZmlsZXMgY2hh
bmdlZCwgMTM2NSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL2FtZGdw
dS9hbWRfZG1lbS5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL2lndF9jZ3JvdXAuYw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi9pZ3RfY2dyb3VwLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBsaWIvaWd0X2RtZW1fZHJpdmVyLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIveGUveGVf
ZG1lbS5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvY2dyb3VwX2RtZW0uYw0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2RtZW1fY2dyb3Vwcy5jDQo+IA0KPiAtLQ0KPiAyLjQ3LjMN
Cg0K
