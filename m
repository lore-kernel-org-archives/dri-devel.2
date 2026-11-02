Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F4606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZvsSUTby
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E085410EB5D;
	Mon,  2 Nov 2026 06:06:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA4A10E00B;
 Mon,  2 Nov 2026 06:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793599604; x=1825135604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DxPWA//W7kJjiBSwGtBP5yrcZ1yEJxmlypxm65hmQcc=;
 b=ZvsSUTby1IdKB0emYSwgMrYF7wZriQzpMFxN+92/mTbqF6KAumXCQAH8
 tdyWNJPt7Ru+istG6EPSeoMMpcfw6knI6rALw8BTZu9rjyED/tks3CuXy
 61hVf7rxaLihoUB8nCiC98cj77uuScp3KDzBuD1/rY6hUapbb9lt2agda
 mfNkjm5r9ijPjW1KcPUXyXsGX8BemBreXLtg1SYYTD4Yt+qYza/x6OOMM
 rsv8OjB4+KeQEPlKWObAdbvf63q2/DfwgLbCGFXT2NYsZJtAx2ak+A/Rk
 UDv313fTHuXZAn0Vvua9T9N1ryhf71FGKViYWS9GnODwE7aaUKF4hISu8 g==;
X-CSE-ConnectionGUID: wdMEBmfAQ5ahiaYwJFGGVw==
X-CSE-MsgGUID: 81swBS8aS1qAoxlYJYYREg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2158112"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2158112"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 22:06:44 -0800
X-CSE-ConnectionGUID: Ch34sQbtR+aVgfJtlvUgQA==
X-CSE-MsgGUID: xB3ULCv7TgKPaAvbgchMaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6073241"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 22:06:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 22:06:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 22:06:43 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 22:06:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljbrYV9aFYUNWz21Vdgutf64QbeSsgfbiH5SZeFfTCRw4Xgk3FJWOSFGKPFuKNhmLPPVcbYeFPQe7WxeOGBAqO/7uoihmfqHvrbRPtf/Xv2bdrEk4q4tq07rd2ikYS7ooKsq1tXFVDg1xBriR/hhIcCv15A8i9TsQxa9WsLrvVWIK5PL76tztJTpAqpmMHugwByJMHWEo0mSXbBQ69TWCbs+p6sx8ZgaFFnbZsbKAPhCevMMLwAXScpi1TxvHT+lTAQXswDfC4hg+4X/tQnbB0WVXgQtsYnhd5Z9zJFE32L3Mnzp1QHR1U0hjREf3U42ZuvDl7RHJZGQ4RIRWkFhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxPWA//W7kJjiBSwGtBP5yrcZ1yEJxmlypxm65hmQcc=;
 b=Gn61QwMksNklwjYZf+01zj06jfVe+vPV0tkiZt8xmNHladKlQMSJehdEsGIHXjYEws/MlJ64JvkiKMAYXgSDlCcKIpdWlDjdwC4wgy22y7IgZkS8YRqLP9BmvgtPvL1xhDZEkJLkUEC/RBa039O0HjZ4/FVLsNl7ARAQUogFl1z4sSCRddTO1r4QBCZlgl+PL+pzX4K7xclZwcciKcLbqWaStYBwJsADuFt9RjV6UKhDKYJcq3Wh1QoCcIKDrR6LLP/YPCLrxuLOOF2sdww0agHPO9Yf73v9a7kanZJ3ztNHcwoLp5t3CWfSXy8+/nkDXJz9ON6/ncTbW79nSviPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by PH5PR11MB320987.namprd11.prod.outlook.com
 (2603:10b6:510:500::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:06:41 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:06:41 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Manna, Animesh" <animesh.manna@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: RE: [PATCH v7 08/20] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Topic: [PATCH v7 08/20] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Index: AQHdZQyRFUZA1gIO706LuPQejX7Z0bcaVkow
Date: Mon, 2 Nov 2026 06:06:40 +0000
Message-ID: <DS4PPFE901A304F9C8E1F1402A677C8D507E36A2@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-9-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-9-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|PH5PR11MB320987:EE_
x-ms-office365-filtering-correlation-id: 2ad2d507-3c2a-48d8-70f3-08df38a77696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|4143699003|11063799006|56012099006|261021123027099003|261009223027099003|261009221227099003|261021121427099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Pcyjdl0Ctgha8ZPivCmVDc+dwNLLngE7Rv6V2WPBuYkIpuLZpzlgN1m4FO9Hu/As1PMQCOJK+D8kkRuuaai1YqVm/dPHM8c0CYRr0rBU9AXlHby1rfE5ySqf7jmjcmk1vVEQpo6Bbk8dMG//7J97cxEnu5/aNb9p3dwpJ7qRsGb/oydGNOHQYmYVjhbBKvvnAhBufWOFCbLAosUz/cm20TtD9j+wbJailxdIJjdLsOHrlJekwwTrW1LWfgSP/tnAdvU+73lK9KJunR5YLhx5pSbxkaWak3cD45tHHCcXeutFuFScQ7VLDe/kHl3fJqla5dFrqJ8thIwKFGyzYzJJne9OCx9G5m3lTSZBt6uNRBdR7J9CRp8H3ylkCL0YJ0SNuVY8DY1E2twrEyonSRMZjOBC+lQ52snqT7t6b3zGKuSv+wtuye3PeifZbWOZ6gKT3lYzibZEK2GaIDMiC0IyzIET9dgxIpOmD4dyU5KD4Xb83PE17JhIRP3ccYbbFIQF1LBGJth9cNLzsFpFjsXRq+p4QfPbodNO280J+UXpgY09ujRTJEpmS8tFZsYNyND9V3NJNITwp+3/pdTYbncg/L7S4lVfIYUKSAa6GAbTDelYsVCCAZCjDIdBUAuCwKtS3Bg1L7BDwFiSutAkvIuK13o+qjvtwxsrWvl1+LmWmSdPd3Z0MUejE4gUbb85yKy2P+klRqeoJ63JR3t7p09WBhrWW6Q0XU9NLj+1IMcfd0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261009221227099003)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnhzdkZBdlZYTWZOWms3MXFBbE5pS0ZyTXIvZXB4eENwMFZ1b2UyMS9nL25n?=
 =?utf-8?B?YkNUUHI2VjFyZjFiQVdyVHZGUnVBYWdIRW84VDNOUWx6NmsyZ3Uvam1XRC95?=
 =?utf-8?B?NXZlVUFFR1UrSnFHQTdyWHNFRk9UWXVPaTZjMWVRRWZ3VVNrMEh4RnRIWmZI?=
 =?utf-8?B?bnh6TjhQR25mU2lTQU9hNmNyMFg1ZVp3bVh0V2dLbkJEemwxd01YdDUrRzFv?=
 =?utf-8?B?TTFIQ2FBajZ0NEgwblE5NnczMnFJODl0Mm1KdHllT2V4ZDF6cjUrQVhxUmx4?=
 =?utf-8?B?VkhjakF3VEJ0QlJua0RLa05ycFpiSnM4elBiNVpvcnF6d2dDTTAzSjZhMHMz?=
 =?utf-8?B?TG9kUXBlbEhSRDZEdDlhNDV0a1pteFRZTXB3TUhaM2NNeDNNV2xyd1pLK0M3?=
 =?utf-8?B?STlGbEZwS0c1UHdFT2tjbTJaK3MxRmZ0WHBUbFUrOUNyTmsrTk1qeklWTWQ4?=
 =?utf-8?B?eFkyUFpubE94bTY4WW5yZ3BtN25mWjZvbmVGUXJaYzk2NkpPSVhGYkJhOVZ6?=
 =?utf-8?B?YVZXVDNONlU4dmcxTHBpdHpVR1I0dnFQMVVXQUtuaVl5YnlmbkEwNGJpS3Vk?=
 =?utf-8?B?SWk5d2JMV1NYVUloNnR0QWE3Y05OMXo5Z2VSTlR6TGhFbjZhblJObjVVTlB0?=
 =?utf-8?B?QXBJSFVleDVqZGx0eGNXdmxYNGd2R1pHQjBPZ2E0VFVOK0dUVEE2bFBpKzB5?=
 =?utf-8?B?T0QwWG4raTV0MjIxMFdYSjRreHVjeEsvcEQ1QVhFZDRkQS9FNlE5TGRXSHdv?=
 =?utf-8?B?TVdWTFVmL1BrOEt2Wi9yb01nZnN0VDlaSlh6a0NSeW04dFRPd2pmWHE3WU5O?=
 =?utf-8?B?WnhXbEovTGVFWHJSd0J5UFlaaG1ZaXhuZFBSQ2FxMnpBeFZiaUpZSk5TN0t2?=
 =?utf-8?B?ZFFWcjhHbDlpcWZDV0krN0hBcTNhamtHc1VxdXR3N09nTmxPUnpvK2ZURkVZ?=
 =?utf-8?B?NzBacHBKa3E3bksyMmQ0STRFYUtCTjh5UEFrY1F0YllScDlCOWRLT3N3TjJO?=
 =?utf-8?B?MStJaEF5eGI1RWhFdFBzK3FQKys2N3NzTTQ2VHpVU09jd29CWEw5OElPajdj?=
 =?utf-8?B?R3hyT2tvNXFzeUdOVzhHbkZaZ1VjVWI2UkFRaFB3M2N3MXJZY2xQNWl3TVNn?=
 =?utf-8?B?UmhjYWw1a3djaW1ZTnBxTTZaMUFObUdDWTYxbklLVVBBRlFaYmQwRTFCeVpT?=
 =?utf-8?B?VzJQaHNFVzZOaGQ3cEh6N00wckR3dDlEb0w0YzBRRWVKQVBRWE9GSDh3NHNz?=
 =?utf-8?B?bVFvNGlydjYzQmxLb3BRUnBUNVJ4eXZBZDNCMUxQcEhTN3hNUXNTWXdBc0hu?=
 =?utf-8?B?MHp0QXk4VkRmdy9jbE5TYm9BS3AxRngrcHBLZ080QzFra1VERG9DWnhnK1JH?=
 =?utf-8?B?aklKd0RVcjlOY0ZHTFVuM0lxemNtRTl0ZHA0TjMyS1Q0cXRSaExHNVVGaXNo?=
 =?utf-8?B?aEw4VStKNk5RR0gxTzNpNjY1V2ZUa2ljRDdNYllQbVF3ejdPdkpkU08vcXJo?=
 =?utf-8?B?bTl2OUJXenJZWS9CejBJY0I1UjVhS1RXV3FLZnlRakVoM0JVY29SekFEdWc3?=
 =?utf-8?B?Qk5wM0dYUjRUZVhZRUR2a0VJQTFXKzh4UjE2MC81c3h1aVEvWjZlSURPUUNU?=
 =?utf-8?B?dHlsdXoxaFh4Mi9oUHpoWDlqSGVTRExtZzA2OXhCbWRnMjdnR05PQ0l2TVZC?=
 =?utf-8?B?TmR3TVRKZCt5WFBXTUpEQmFtaWpXMDV6WE9nRlcwbTcvS1FqdkVTcDJ4YjQ2?=
 =?utf-8?B?dmk0anRyT2cxbEl4Z0JFOFBpNEN2dHYvRHp1akdQQ2ZIZXV3MmRSYk9RamRU?=
 =?utf-8?B?SytlU1FrYVBxY2syYStaTHgyanZhVW8rZnVFa1A1dTEyODFYQ2k2ODJIYnNo?=
 =?utf-8?B?dVVrV2MzVFFJOTkvR2lyWHA0cko1eGJNZ2c5aFJQaEpyd3YyN0hTcDhNejBS?=
 =?utf-8?B?bE4wMzQ5VXRwaFZYTzAralRBQVgzWDAvdjRSUUR0Qm1zVjRHTENZMW1OUkFV?=
 =?utf-8?B?VjRwQjlKdnUvNkRUYUthRExpNkRaUzFJeFlHaVo0VWZNUUZLWmNaUGlJbVUx?=
 =?utf-8?B?eTNpYVY2dDA2VUpOT1BwaTU3dzhCWHpVOFhjdW51bHdsUXlwS045MTY3dTRy?=
 =?utf-8?B?dXFYUGZzeVdQdk9ZeEtqOXJqRlVhbStnalQzT0hYM1VXTzRtTXVDSlBVdVdF?=
 =?utf-8?B?d1ViVzlZVHNNQnNmbUZSSU9raVU4dHhRWkVlNDc2Y3pCdkh4T09QcDlZSGg4?=
 =?utf-8?B?anZjaW9TZ2FldEhGZW4wU0JwSWF4OFNOZCs4ZmRCL3lnbWpieURqd2R6ME52?=
 =?utf-8?B?L0hPdE5VREZFcFBuMmNUWmFGWVFKSDNJWVhlcWRDclpFUVhiZHZaUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cer+cq3IYCIT+JCgOT4HcBE4MAUxs+5F6zcvsnxAx/Bf1D/V7Yya4lnC1PlKKkINOOgXUZ54xjdOIteQ9uukyfGh0eYPctT369rg1BjaM5h6szraPkQ553u/bKKOX9bLAruw4r92zRSoH89eu/OOhjxO7uiTZgF7tgpRXL9a0CuQ2J6fnuUMUOvWJhbtBCgfC7X7kcZPrsEUfEQ9fDyIciipCBsFNvBOPMj1+s6mN+zZS+Ebrh5Bhy2WtkzOH/YbWhDybUWEm6VrnzdUoo6sLwTgWhEdNjGjibM622Zwothl/A+wXE7RS3KiJWwdpCum5nIYmX6hjI2/pwCfWf7B4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad2d507-3c2a-48d8-70f3-08df38a77696
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 06:06:40.9219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bmt+3zAnXGUyEI/ypQ50JeDpCS1O2H87ZYM4ZbL5UbIl2DJH1Zhg9vX9+vhJ/d1cstrK4MWCZr0Uyg9i7l96gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR11MB320987
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQo+IFN1YmplY3Q6IFtQQVRDSCB2NyAwOC8yMF0gZHJtL2k5MTUvYWxwbTogTW9kaWZ5IEFVWF9M
RVNTX1dBS0VfVElNRQ0KPiBiaXRmaWVsZCBmb3IgeGUzbHBkDQoNCkRJU1BMQVkgVmVyID09IDM1
IGlzIHhlM3Agbm90IHhlM2xwZA0KDQo+IA0KPiBUaGUgQVVYX0xFU1NfV0FLRV9USU1FIGJpdGZp
ZWxkIGluIEFMUE1fQ1RMIGlzIHdpZGVuZWQgZnJvbSA2IGJpdHMgdG8NCj4gOCBiaXRzIHN0YXJ0
aW5nIGZyb20geGUzbHBkIChkaXNwbGF5IHZlcnNpb24gMzUpLiBBZGQgdGhlIHJlZ2lzdGVyIG1h
c2sgYW5kIGZpZWxkDQo+IG1hY3JvIGZvciB0aGUgd2lkZXIgYml0ZmllbGQgYW5kIHByb2dyYW0g
dGhlIHdha2UgdGltZSB1c2luZyB0aGUgYXBwcm9wcmlhdGUNCj4gbWFjcm8gYmFzZWQgb24gdGhl
IGRpc3BsYXkgdmVyc2lvbi4gQWxzbyB1c2UgdGhlIHdpZGVyIGxpbWl0IHdoZW4gdmFsaWRhdGlu
Zw0KPiB0aGUgY29tcHV0ZWQgd2FrZSBsaW5lcyBhbmQgZm9yIHRoZSBzYWZlc3QgcGFyYW1zIGZh
bGxiYWNrLg0KPiANCj4gdjI6IE1vZGlmeSBBVVhfTEVTU19XQUtFX1RJTUUgYml0ZmllbGQgZm9y
IHhlM2xwZC4gW1N1cmFqXQ0KPiB2MzogU2VwYXJhdGUgb3V0IEFVWF9MRVNTX1dBS0VfVElNRSBi
aXRmaWVsZCBjaGFuZ2UgaW50byBpdHMgb3duIHBhdGNoLg0KPiBbSm91bmldDQo+IHY0OiBVc2Ug
dGhlIHdpZGVyIGJpdGZpZWxkIGxpbWl0IGluIGF1eC1sZXNzIHdha2UgdGltZSBjb21wdXRhdGlv
biBhbmQgc2FmZXN0DQo+IHBhcmFtcy4gW0pvdW5pLCBzYXNoaWtvXQ0KPiANCj4gQnNwZWM6IDcx
NDc3DQo+IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMgICAgIHwg
MjAgKysrKysrKysrKysrKysrLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wc3JfcmVncy5oIHwgIDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5jDQo+IGluZGV4IGI5ZTMxYzI5YWI5Ni4uMDA4Mzc1MmQ5NGYwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtMjA0
LDYgKzIwNCwxMiBAQCBzdGF0aWMgaW50IF9sbmxfY29tcHV0ZV9hdXhfbGVzc193YWtlX3RpbWUo
c3RydWN0DQo+IGludGVsX2RwICppbnRlbF9kcCwNCj4gIAkJCSAgICBlc3RhYmxpc2htZW50X3Bl
cmlvZCwgMTAwMCk7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCBnZXRfYXV4X2xlc3Nfd2FrZV9s
aW5lc19tYXgoc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkpIHsNCj4gKwlyZXR1cm4gRElT
UExBWV9WRVIoZGlzcGxheSkgPj0gMzUgPw0KPiBBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUVf
TUFTS19YRTNMUEQgOg0KPiArDQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRV9NQVNLOyB9
DQo+ICsNCj4gIHN0YXRpYyBpbnQNCj4gIF9sbmxfY29tcHV0ZV9hdXhfbGVzc19hbHBtX3BhcmFt
cyhzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwLA0KPiAgCQkJCSAgc3RydWN0IGludGVsX2NydGNf
c3RhdGUgKmNydGNfc3RhdGUpIEBAIC0NCj4gMjIwLDE0ICsyMjYsMTQgQEAgX2xubF9jb21wdXRl
X2F1eF9sZXNzX2FscG1fcGFyYW1zKHN0cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAsDQo+IA0K
PiAgCWxmcHNfaGFsZl9jeWNsZSA9IGdldF9sZnBzX2hhbGZfY3ljbGVfY2xvY2tzKGNydGNfc3Rh
dGUpOw0KPiANCj4gLQlpZiAoYXV4X2xlc3Nfd2FrZV9saW5lcyA+IEFMUE1fQ1RMX0FVWF9MRVNT
X1dBS0VfVElNRV9NQVNLDQo+IHx8DQo+ICsJaWYgKGF1eF9sZXNzX3dha2VfbGluZXMgPiBnZXRf
YXV4X2xlc3Nfd2FrZV9saW5lc19tYXgoZGlzcGxheSkgfHwNCj4gIAkgICAgc2lsZW5jZV9wZXJp
b2QgPiBQT1JUX0FMUE1fQ1RMX1NJTEVOQ0VfUEVSSU9EX01BU0sgfHwNCj4gIAkgICAgbGZwc19o
YWxmX2N5Y2xlIDwgMSB8fA0KPiAgCSAgICBsZnBzX2hhbGZfY3ljbGUgPg0KPiBQT1JUX0FMUE1f
TEZQU19DVExfTEFTVF9MRlBTX0hBTEZfQ1lDTEVfRFVSQVRJT05fTUFTSyArIDEpDQo+ICAJCXJl
dHVybiBmYWxzZTsNCj4gDQo+ICAJaWYgKGRpc3BsYXktPnBhcmFtcy5wc3Jfc2FmZXN0X3BhcmFt
cykNCj4gLQkJYXV4X2xlc3Nfd2FrZV9saW5lcyA9DQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0Vf
VElNRV9NQVNLOw0KPiArCQlhdXhfbGVzc193YWtlX2xpbmVzID0NCj4gZ2V0X2F1eF9sZXNzX3dh
a2VfbGluZXNfbWF4KGRpc3BsYXkpOw0KPiANCj4gIAljcnRjX3N0YXRlLT5hbHBtX3N0YXRlLmF1
eF9sZXNzX3dha2VfbGluZXMgPSBhdXhfbGVzc193YWtlX2xpbmVzOw0KPiAgCWNydGNfc3RhdGUt
PmFscG1fc3RhdGUuc2lsZW5jZV9wZXJpb2Rfc3ltX2Nsb2NrcyA9IHNpbGVuY2VfcGVyaW9kOw0K
PiBAQCAtNjE3LDEwICs2MjMsMTYgQEAgc3RhdGljIHZvaWQgbG5sX2FscG1fY29uZmlndXJlKHN0
cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAsDQo+ICAJICogY2hlY2sgcGFuZWwgc3VwcG9ydCBh
dCB0aGlzIHBvaW50Lg0KPiAgCSAqLw0KPiAgCWlmIChpbnRlbF9hbHBtX2lzX2FscG1fYXV4X2xl
c3MoaW50ZWxfZHAsIGNydGNfc3RhdGUpKSB7DQo+ICsJCWludCB3YWtlX2xpbmVzID0gY3J0Y19z
dGF0ZS0+YWxwbV9zdGF0ZS5hdXhfbGVzc193YWtlX2xpbmVzOw0KPiArDQo+ICAJCWFscG1fY3Rs
ID0gQUxQTV9DVExfQUxQTV9FTkFCTEUgfA0KPiAgCQkJQUxQTV9DVExfQUxQTV9BVVhfTEVTU19F
TkFCTEUgfA0KPiAtDQo+IAlBTFBNX0NUTF9BVVhfTEVTU19TTEVFUF9IT0xEX1RJTUVfNTBfU1lN
Qk9MUyB8DQo+IC0JCQlBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUUoY3J0Y19zdGF0ZS0NCj4g
PmFscG1fc3RhdGUuYXV4X2xlc3Nfd2FrZV9saW5lcyk7DQo+ICsNCj4gCUFMUE1fQ1RMX0FVWF9M
RVNTX1NMRUVQX0hPTERfVElNRV81MF9TWU1CT0xTOw0KPiArDQo+ICsJCWlmIChESVNQTEFZX1ZF
UihkaXNwbGF5KSA8IDM1KQ0KPiArCQkJYWxwbV9jdGwgfD0NCj4gQUxQTV9DVExfQVVYX0xFU1Nf
V0FLRV9USU1FKHdha2VfbGluZXMpOw0KPiArCQllbHNlDQo+ICsJCQlhbHBtX2N0bCB8PQ0KPiBB
TFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUVfWEUzTFBEKHdha2VfbGluZXMpOw0KPiANCj4gIAkJ
aWYgKGludGVsX2RwLT5hc19zZHBfc3VwcG9ydGVkKQ0KPiAgCQkJaW50ZWxfYWxwbV9jb25maWd1
cmVfcHJfYXNfc2RwKGludGVsX2RwLCBjcnRjX3N0YXRlKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyX3JlZ3MuaA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyX3JlZ3MuaA0KPiBpbmRleCA3OGEwNTM4N2VhYjUu
LjEyNGFhNzRlMWRiYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxh
eS9pbnRlbF9wc3JfcmVncy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfcHNyX3JlZ3MuaA0KPiBAQCAtMzAxLDcgKzMwMSw5IEBADQo+ICAjZGVmaW5lICBBTFBN
X0NUTF9FWFRFTkRFRF9GQVNUX1dBS0VfTUlOX0xJTkVTCQk1DQo+ICAjZGVmaW5lICBBTFBNX0NU
TF9FWFRFTkRFRF9GQVNUX1dBS0VfVElNRShsaW5lcykNCj4gCVJFR19GSUVMRF9QUkVQKEFMUE1f
Q1RMX0VYVEVOREVEX0ZBU1RfV0FLRV9USU1FX01BU0ssDQo+IChsaW5lcykgLSBBTFBNX0NUTF9F
WFRFTkRFRF9GQVNUX1dBS0VfTUlOX0xJTkVTKQ0KPiAgI2RlZmluZSAgQUxQTV9DVExfQVVYX0xF
U1NfV0FLRV9USU1FX01BU0sNCj4gCVJFR19HRU5NQVNLKDUsIDApDQo+ICsjZGVmaW5lICBBTFBN
X0NUTF9BVVhfTEVTU19XQUtFX1RJTUVfTUFTS19YRTNMUEQNCj4gCVJFR19HRU5NQVNLKDcsIDAp
DQo+ICAjZGVmaW5lICBBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUUodmFsKQ0KPiAJUkVHX0ZJ
RUxEX1BSRVAoQUxQTV9DVExfQVVYX0xFU1NfV0FLRV9USU1FX01BU0ssIHZhbCkNCj4gKyNkZWZp
bmUgIEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRV9YRTNMUEQodmFsKQ0KPiAJUkVHX0ZJRUxE
X1BSRVAoQUxQTV9DVExfQVVYX0xFU1NfV0FLRV9USU1FX01BU0tfWEUzTFBELA0KDQoqeGUzcA0K
DQpSZWdhcmRzLA0KU3VyYWogS2FuZHBhbA0KDQo+IHZhbCkNCj4gDQo+ICAjZGVmaW5lIF9BTFBN
X0NUTDJfQQkweDYwOTU0DQo+ICAjZGVmaW5lIEFMUE1fQ1RMMihkZXZfcHJpdiwgdHJhbikJX01N
SU9fVFJBTlMyKGRldl9wcml2LCB0cmFuLA0KPiBfQUxQTV9DVEwyX0EpDQo+IC0tDQo+IDIuNDMu
MA0KDQo=
