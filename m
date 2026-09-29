Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E095BCA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD35210ED2D;
	Tue, 29 Sep 2026 07:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZguGmXa8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2129110ED2D;
 Tue, 29 Sep 2026 07:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790667167; x=1822203167;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Hmrym7lMBPE2uyD/WmdMm0GUeeV96bwOMnKcHT74iG0=;
 b=ZguGmXa8YrlyMR+xlck9LwOEx/MLvqDBeUoTgovlzrM/bvae1Nlc6JRj
 tFiz7hrL+HrkeR5KnWrRclhAnK6N+4HKaXnXIyA+8DiQtZaK/7O7dOLj5
 9LLmIMyKJu/6JAFnDe0CX6rgHE1U4ZZhYZVBkPdSv6qDy9NZw2mNi1cgl
 8FRtiwX2qIjYjEgWj+oyvUQXVRlcGCTvQTg3K31eIM4GN8azXGlOVrpCO
 zxgk3G933VAFODLuNOau1S1VP/dLUUU+5QoxESmORnsnfRK78nK79TKNk
 n6WpIqVsP2Ap5Cp6IxgrPeKxizu9gjlVe+qIJFpord1Z//vnPyzjrZIv1 Q==;
X-CSE-ConnectionGUID: xc+e6Nh6Rtm2OFUEs3hyTA==
X-CSE-MsgGUID: Q7e+bWhuRI6IX/x+J1LFzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101901798"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101901798"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 00:32:46 -0700
X-CSE-ConnectionGUID: odgdsJ3/Q8e5wc2UnVymJg==
X-CSE-MsgGUID: KQP0syiPSOy07cZBlm3bOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="279116074"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 00:32:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:32:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 00:32:46 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkL2uqiZFiLIqxHBpjr+mt6FPYm7maBy0QWVfOMAYq9NRpcdcvi2qWltuTllFGd1ZAHzaYZYVwcYXKKMHT7KqHApu4/JyrDVyY+S8i9T8T/jiLN80cFdggTOXvZtVtnyFKt2uF4ui1Z51eDLCBdtTwLpsTd1TJ2iUOF3dwM9NOmOtxOU2E5eaTFAAGmhNBP3jlqaFvj8dYs+/Hgfm8DMbcIobhQH6rpcKehmNCyQgUvG7KQ43MMbOVx6++t7PIixf1hqMjyLhKmEiB6bj6Hh+KmJObPo57W3cYXQieo5/vUFmA7PWDi/uYJHRmW5NHJrdL4OQ1ndUnxCO90sPveXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmrym7lMBPE2uyD/WmdMm0GUeeV96bwOMnKcHT74iG0=;
 b=JsUbtTb4Ul/vRNH8rIb1BZ/uFFV/14bkZGVBqtyPEsqOBFdFqq8E/Gyn8k7AgUXvgpALRywhGIwwv/sJv11ZJbE3XSKClhgYfH4IKuoaFRV7Ix1O+t/+IDxSVF6TeMQmHB75DD440TDyyT5dPXifXlVen6HE8XbeaYPhJaedInIn/OjR2MzcXDVbp9I6stchEOcIuiWg3HmuQ9KTgH724QA1zKyceCJsQcnXmvrB6ZDcz1l6qQw+DWAcv25/0qE+ZK6sxn3GDzxB2YgqpCwGf5HeCg0szfoUX2SOvDvl+I6CoYZ/b5hL5e/FBqCsc3UlPo/wXgWJQLzkjoGdztJ/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.25; Tue, 29 Sep 2026 07:31:04 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 07:31:04 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 08/18] drm/i915/alpm: table based establishment period
Thread-Topic: [PATCH v6 08/18] drm/i915/alpm: table based establishment period
Thread-Index: AQHdRUGOKmuWy//RiUShNN1ucxLVBrblNeAAgAAIkgA=
Date: Tue, 29 Sep 2026 07:31:04 +0000
Message-ID: <cbd2bdcd92344591e59f815aef41dbed8cc822be.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-9-animesh.manna@intel.com>
 <dfc66a1292774129a0277ea75a3be0e49ee52eec.camel@intel.com>
In-Reply-To: <dfc66a1292774129a0277ea75a3be0e49ee52eec.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CYXPR11MB8663:EE_
x-ms-office365-filtering-correlation-id: f461fd87-a6fb-45c6-bfb5-08df1dfb9ea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|38070700021|4143699003|3023799007|6133799003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: rWZOZtaEmuhuInef0nzU0ASR4DZ9U9nnSchBljh/YFF+5CLt/98agT8sE3BgeDnAHH4kB4yHXvA4C4nIqpAVFu5zSto0zC1oKByZTq4zV04bXbfUbjYebgw2Ve7WRQJ6jV+yK9I+XgQE2GAbqxHvghrLjLEap012sQoNsarB0cBwDj2KfqZjZFOUslCg7TYGNJo1pq6OLGyxQAJBO+2etplccWio1KldIaq5b/exkiJR2ycjk0EaayKI4535LeQN5WCNjf2wwdvG6dlrC57hL2Y6iRuc+2RGQyfTOk2MMuDmHbIsWr2yB1IEeoQm/+Kl4LFx0gGIM+ef3JqLqBEGYS3PVfI4f7xEtfwnnbUpW5LNNUnQs5W+QD3EkbNqtzAH8xF3ugM2guDTdQ6ueo2R5L4wuJ0k0ELsTOiHMI9um07g4jyMnLQq5L3/zHEl9pnF6rkvLM6ANqAsepon01ZikUjEOOaMh3+Zw7bUECDPlttoCy3Pyuuk2RUjy8p4JNY3iKpsbA2ZqKQbYRlwL7VjAzjqTOLRrLvEbAng8Adtu/SrPeY2yOufZDmLOIcGmrlMxwbOJof/uwDuRM02yAe1gKZzzJAjosMvJ2b52xsT1iHx0QwGz8o4L1dvRviyaRBZfWnDHu9V6tJpEue7ZTk+psY3UCKCG8xb0KRSWIX994F+4nokadf9sDeRD/IFVHjdcGM+Mv2PYDnGEv43vvc8at33v77UvfcLF8BTrRg6pd4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdlSThpcGRJRWg5TTY2dkRUaFN0WXBNTlYzWGsxZVJlOWtlS2FuenYxWlJv?=
 =?utf-8?B?WHZJaGJYaTJuMXBrc3VPMStSbzBiTitCTkM5cE1XL1hXdkl3ZzB4UXFHWmQx?=
 =?utf-8?B?ZDVKZ3cwZ0hWb3FCaDFCUnVUTmsxS3JnWG41SGZKVVQ0SVNNNHBxSXBFeE44?=
 =?utf-8?B?bDRqNzNMS3BCUUtuM1BOcUlxSTdZS2I1R0ZHYlA3ZVhMQmxTUkVCYnZybnZ3?=
 =?utf-8?B?WDdnaHR3QlA0MFNZaHY3bFBnYkZLY2NiWjI0cnB0U1o5VjB5OUhYbTI0TTdp?=
 =?utf-8?B?Z3VQMjZtQzRMbWxsNnhRbnNkY2p5R3NoNG1yN0crOGU4MzdhLzE2SG5yenNQ?=
 =?utf-8?B?RDZic05TNllBTzhJMFc3M0wrcU5sZVN6NVBBcTI2VlhJVldLQW9pdFF4am5G?=
 =?utf-8?B?ZXFkTUEvcTVSUFMzYnlJaU52ZkV6V2ZQZldCeHQ3ZmxJcTlHVnY2SERJU0x0?=
 =?utf-8?B?ZitmSWtOZW1HWWtORTZFMWpKYlRzaktQTUZUUHNRN1ZEb2tWM2NaOVU0clNL?=
 =?utf-8?B?N3ljY3Y4RnJZSGhSdWFOQ25Sd0JHZTBXa01OOFVkVjNRZkJpdlNIUkY4VTZt?=
 =?utf-8?B?UEExWDkyZDFyYkd6S3RJditYakJqWmJidnE4bmtpbEVEZ0UvVkJjM1hOd1dj?=
 =?utf-8?B?NHQwcHFkVktQSkd6MnNkeDIvT3VtUHk5S1Q3Y2g1cGlpenAwZHp0dEFXdjhU?=
 =?utf-8?B?WWFGd2ZVOUw5NzdEQlZzazZnT0s1YUxYRFdFOGVMVDdRUm8yQzA1L25TZ1g4?=
 =?utf-8?B?SFgyUTZsT2ZRd2RiMVF5dDRmaWJBVFJLNmxaY2xBVHpXUVJkaXRDMGRwL2E0?=
 =?utf-8?B?ZW1IdHdXN2ZSRDErNjY0ZG1UcTZ4ZG5YS3BqbjFmTGEwWUQ1YUZTS1ZoN1JY?=
 =?utf-8?B?MVBaVEd5OXYwRUlzVTlKdmNFM1c0NXlBVnZ2RlUwcnNvUE1PbmY4c05ZT2Rp?=
 =?utf-8?B?U3NXVUxyaWhWTHcxeVlLYU9iTkNyUVlqMlIvTlUzb0o0bXcvcUd1VkFZeEpT?=
 =?utf-8?B?Q1FXQXhTTVRmTmZKbTZ1NG12bmFXMlRjOG0zRUJEdWt5QzZIZUdWWmp0Sk9O?=
 =?utf-8?B?RDFMZTRuSjRwRWJxWTdPdUpDRlZxeUJIS0Z0azlVWW9tdjdVNHVsNW1PYjdq?=
 =?utf-8?B?UzdoZG9CTXFPcll5Z0krdmZ4Ti9CZ1RWcHU1bnRmYkxiZmhpeThUN2RsWWpD?=
 =?utf-8?B?dWtLRWNadHhiUllEd2Q1RllaM0tNMXZaNGphdllzK24zazZCelhaSEQyQ3NL?=
 =?utf-8?B?NHJndE9TSGhGc3BPMVlGMytSNC81T1dUQWtnaDdZSS8xNTVtMktLbE00ZHhM?=
 =?utf-8?B?K3UzV0hHSU4wcU9CcXI1RElqU1oyaDdGNlg1ajhxNGtTeHlNQTlzSUFOb3JH?=
 =?utf-8?B?YllmUzZ4VE53MjlHNlNwZkdSMFRWVG5yU3BKa1plNFIyOU5nYmQ2K01ncDE0?=
 =?utf-8?B?TjJCcTh2OVYweDlSM1JhSE5VR2pENVMvdkYrelN5MEgybzhhaGkyaTJKUHBS?=
 =?utf-8?B?RGZKZDBWWC9NZmhVOXFEbGFlQzltVHVCZnZWTkQ2THc5ZTBoa3daN0UxT1Zv?=
 =?utf-8?B?V2I3NEdSSHJneFU1R1A3RWx2a1k4MUdQZ2lKZUMvd3pQUGtKNitOR2tYYzJw?=
 =?utf-8?B?dmlRdzVnRGdSUU93ajlsKzM5NFlGWE9YUUQvanJwWjJYRllSNkhoUzVDekh6?=
 =?utf-8?B?d25UMXlwS1JtbmE0Z0VtcDZTWEZoNk9lVmIrY0lDRTNCaWRicy9yS1JITGcr?=
 =?utf-8?B?SlpCTUtJWjZSeUxqdWE0RDV0TjlpaGQzTENaRHkwMkNoOFNKclo3N0pzd3Vh?=
 =?utf-8?B?SEdsOEtIdW9ZRlQveGhUbXhNbEpNWG9obUpmNzRoT05Tc1JiSStVRUJUWUtj?=
 =?utf-8?B?KzN6RmN3VlJhcHFueUpnVnc2YVR4YUwyQ0JTVGJ3dEpQSTVmVFp0Q3dBT2Rh?=
 =?utf-8?B?L2tVMG80RU8yYjBFUEg5aWtRMkxUUW05WnR1Vm5IV1diSG5YVGxaSjQ2cWs4?=
 =?utf-8?B?M3lMQW82eEJ3WTB1VjlabERVbm16cU9uRWZ4SGRSVHNOZXNGa3VXczJkdk1W?=
 =?utf-8?B?bXkrWFhBYTJWeE11Tmp1TEJWaXVDSWJwR2s5U09hd2h6SzByMGxJdm5ZeWR4?=
 =?utf-8?B?RjA2WFNwRk9kOHBHd2RGRGdwR0xvNWN5U1MyYUlBcFR3YUdwSHFxd0RVMXA4?=
 =?utf-8?B?ODRFQTlLQWk2SHpZb01icWE2ODc1SnRmYXpPMmQ4VkloQklqMmhsalU1NXJE?=
 =?utf-8?B?RndaRE05c2hJNkxLb3ZHMVlCSE5RMjBIcnF0WllSZytBQUxNVlFySkxGaStk?=
 =?utf-8?B?VzY4RnRGWmhuak1VQWhGLzllR1NyT1haWGNwVnp4Wm8xODFxa3BVYklvZnJx?=
 =?utf-8?Q?/IrJHw0RD24AhLp0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32677F0D749B604595440CDCBB51E622@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iHRDBWrxGalO0THiwZH2Vwi9JIkIDVXRi5GZ4SRRgiS8kLbk4+5eiyURRdLTpdK6F0YBDqnlorKGQWRu2ZuLIsq2SJoZ82DgagdU/hISVMl4wyPpT1+v02sXGStekySuzfY5VuLC36pYhoFWeGYnRCW7dHiG/dDL0XjDlRcj0J3/e7MetfjuQbrBsxkcf4WXKO0dSW4YibWdSO7LrRiKmP1yLoEC3O/G96JTXdjVF0wMNOUJrvQMskq3TvT/81BddwFBI3Ifk+chdLT/moMpEt7pgjNor/m4Oe5pZVZRhYC0uKYtOYNUInXA2eKxekSxfPujnGZ96cKqresgGAHXng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f461fd87-a6fb-45c6-bfb5-08df1dfb9ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:31:04.4676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3ZUcEIiyiSJNwlfsoCfDlrCdgixbMGxMdmHVj67n1KqylFLlmYAkuf/LrGNkndcPAeYhfebnrw69POOudwqOwox8AatXEO52FRMlI0jN7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
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

T24gVHVlLCAyMDI2LTA5LTI5IGF0IDEwOjAwICswMzAwLCBIb2dhbmRlciwgSm91bmkgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAyMzozNCArMDUzMCwgQW5pbWVzaCBNYW5uYSB3cm90
ZToNCj4gPiBPbmx5IHVzZSB0aGUgdGFibGUgd2hlbiB0aGUgbGluayByYXRlIGlzIGxpc3RlZCAo
aWR4IHZhbGlkKQ0KPiA+IGFuZCB0aGUgTFRUUFIgY291bnQgaXMgd2l0aGluIHRoZSB0YWJsZSBi
b3VuZHMuIEEgemVybyBlbnRyeQ0KPiA+IG1lYW5zIHRoZSByYXRlIGhhcyBubyB0YWJ1bGF0ZWQg
dmFsdWUsIHNvIGZhbGwgYmFjayB0byB0aGUNCj4gPiBjb21wdXRlZCBlc3RhYmxpc2htZW50IHBl
cmlvZCBiZWxvdy4NCj4gPiANCj4gPiBOb3RlOiBUaGUgdGFibGUgYW5kIGl0cyB2YWx1ZXMgYXJl
IHRha2VuIGZyb20gRFAyLjEgdmVzYSBzcGVjLg0KPiA+IA0KPiA+IHYyOiBBZGQgY2hlY2sgZm9y
IG5lZ2F0aXZlIGVycm9yIGNvZGVzIGZyb20gZHJtX2RwX2x0dHByX2NvdW50KCkuDQo+ID4gW3Nh
c2hpa29dDQo+ID4gDQo+ID4gQ2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9hbHBtLmMgfCA5NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gwqAxIGZp
bGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gPiBpbmRleCBkYzAyNTA1OGE2MjYuLmNi
MjRiYmE4MDFhMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5
L2ludGVsX2FscG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5jDQo+ID4gQEAgLTEyMiw2ICsxMjIsOTIgQEAgc3RhdGljIGludCBnZXRfZHBfbGlu
a19zeW1ib2xfc2l6ZShjb25zdA0KPiA+IHN0cnVjdA0KPiA+IGludGVsX2NydGNfc3RhdGUgKmNy
dGNfc3RhdGUpDQo+ID4gwqAJcmV0dXJuIGludGVsX2RwX2lzX3VoYnIoY3J0Y19zdGF0ZSkgPyAz
MiA6IDEwOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gKyNkZWZpbmUgREVGQVVMVF9NQVhfTFRUUFJf
Q09VTlQgNw0KPiA+ICsjZGVmaW5lIE1BWF9TVVBQT1JURURfRFBfTElOS19SQVRFUyAxMg0KPiA+
ICsNCj4gPiArc3RhdGljIGNvbnN0IHUzMg0KPiA+IGVzdGFibGlzaG1lbnRfcGVyaW9kc1tERUZB
VUxUX01BWF9MVFRQUl9DT1VOVF1bTUFYX1NVUFBPUlRFRF9EUF9MSU4NCj4gPiBLXw0KPiA+IFJB
VEVTXSA9IHsNCj4gPiArCS8qIDE2MjAsIDIxNjAsIDI0MzAsIDI3MDAsIDMyNDAsIDQzMjAsIDU0
MDAsIDY3NTAsIDgxMDAsDQo+ID4gMTAwMDAsIDEzNTAwLCAyMDAwMCAqLw0KPiA+ICsJLyogTm8g
UmV0aW1lcnMgKi8NCj4gPiArCXsgNjEwNzAsIDAsIDAsIDU2NzEwLCAwLCAwLCA1MzQ1MCwgMCwg
NTIzNjAsIDU5MDUwLCA1Njc1MCwNCj4gPiA1NDYyMCB9LA0KPiA+ICsJLyrCoCAxIFJldGltZXLC
oCAqLw0KPiA+ICsJeyAxNTU2NzAsIDAsIDAsIDE1MTMxMCwgMCwgMCwgMTQ4MDUwLCAwLCAxNDY5
NjAsIDE1MzY1MCwNCj4gPiAxNTEzNTAsIDE0OTIyMCB9LA0KPiA+ICsJLyrCoCAyIFJldGltZXJz
ICovDQo+ID4gKwl7IDE4MTE2MCwgMCwgMCwgMTcyNDUwLCAwLCAwLCAxNjU5MTAsIDAsIDE2Mzc0
MCwgMTc3MTIwLA0KPiA+IDE3MjUyMCwgMTY4MjIwIH0sDQo+ID4gKwkvKsKgIDMgUmV0aW1lcnMg
Ki8NCj4gPiArCXsgMjA2NjUwLCAwLCAwLCAxOTM1ODAsIDAsIDAsIDE4Mzc4MCwgMCwgMTgwNTEw
LCAyMDA1OTAsDQo+ID4gMTkzNjkwLCAxODcyOTAgfSwNCj4gPiArCS8qwqAgNCBSZXRpbWVycyAq
Lw0KPiA+ICsJeyAyMzIxNDAsIDAsIDAsIDIxNDcxMCwgMCwgMCwgMjAxNjUwLCAwLCAxOTcyOTAs
IDIyNDA2MCwNCj4gPiAyMTQ4NjAsIDIwNjMyMCB9LA0KPiA+ICsJLyrCoCA1IFJldGltZXJzICov
DQo+ID4gKwl7IDI1NzYyMCwgMCwgMCwgMjM1ODUwLCAwLCAwLCAyMTk1MTAsIDAsIDIxNDA3MCwg
MjQ3NTMwLA0KPiA+IDIzNjAzMCwgMjI1MzYwIH0sDQo+ID4gKwkvKsKgIDYgUmV0aW1lcnMgKi8N
Cj4gPiArCXsgMjgzMTEwLCAwLCAwLCAyNTY5ODAsIDAsIDAsIDIzNzM4MCwgMCwgMjMwODUwLCAy
NzEwMDAsDQo+ID4gMjU3MjAwLCAyNDQzOTAgfSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK2VudW0g
bGlua19yYXRlX2lkeCB7DQo+ID4gKwlMSU5LX1JBVEVfSU5WQUxJRCA9IC0xLA0KPiA+ICsJTElO
S19SQVRFXzEsDQo+ID4gKwlMSU5LX1JBVEVfMiwNCj4gPiArCUxJTktfUkFURV8zLA0KPiA+ICsJ
TElOS19SQVRFXzQsDQo+ID4gKwlMSU5LX1JBVEVfNSwNCj4gPiArCUxJTktfUkFURV82LA0KPiA+
ICsJTElOS19SQVRFXzcsDQo+ID4gKwlMSU5LX1JBVEVfOCwNCj4gPiArCUxJTktfUkFURV85LA0K
PiA+ICsJTElOS19SQVRFXzEwLA0KPiA+ICsJTElOS19SQVRFXzExLA0KPiA+ICsJTElOS19SQVRF
XzEyDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGdldF9saW5rX3JhdGVfaW5kZXgo
aW50IHBvcnRfY2xvY2spDQo+ID4gK3sNCj4gPiArCWludCBsaW5rX3JhdGVfaW5kZXg7DQo+ID4g
Kw0KPiA+ICsJc3dpdGNoIChwb3J0X2Nsb2NrKSB7DQo+ID4gKwljYXNlIDE2MjAwMDoNCj4gPiAr
CQlsaW5rX3JhdGVfaW5kZXggPSBMSU5LX1JBVEVfMTsJLy8gUmF0ZV8xIChSQlIpIC0NCj4gPiAx
LjYyIEdicHMvTGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSAyMTYwMDA6DQo+ID4gKwkJ
bGlua19yYXRlX2luZGV4ID0gTElOS19SQVRFXzI7CS8vIFJhdGVfMsKgwqDCoMKgwqDCoCAtDQo+
ID4gMi4xNiBHYnBzL0xhbmUNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgMjQzMDAwOg0KPiA+
ICsJCWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV8zOwkvLyBSYXRlXzPCoMKgwqDCoMKgwqAg
LQ0KPiA+IDIuNDMgR2Jwcy9MYW5lDQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIDI3MDAwMDoN
Cj4gPiArCQlsaW5rX3JhdGVfaW5kZXggPSBMSU5LX1JBVEVfNDsJLy8gUmF0ZV80IChIQlIpIC0N
Cj4gPiAyLjcwIEdicHMvTGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSAzMjQwMDA6DQo+
ID4gKwkJbGlua19yYXRlX2luZGV4ID0gTElOS19SQVRFXzU7CS8vIFJhdGVfNSAoUkJSMiktDQo+
ID4gMy4yNCBHYnBzL0xhbmUNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgNDMyMDAwOg0KPiA+
ICsJCWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV82OwkvLyBSYXRlXzbCoMKgwqDCoMKgwqAg
LQ0KPiA+IDQuMzIgR2Jwcy9MYW5lDQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIDU0MDAwMDoN
Cj4gPiArCQlsaW5rX3JhdGVfaW5kZXggPSBMSU5LX1JBVEVfNzsJLy8gUmF0ZV83IChIQlIyKS0N
Cj4gPiA1LjQwIEdicHMvTGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSA2NzUwMDA6DQo+
ID4gKwkJbGlua19yYXRlX2luZGV4ID0gTElOS19SQVRFXzg7CS8vIFJhdGVfOMKgwqDCoMKgwqDC
oCAtDQo+ID4gNi43NSBHYnBzL0xhbmUNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgODEwMDAw
Og0KPiA+ICsJCWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV85OwkvLyBSYXRlXzkgKEhCUjMp
LQ0KPiA+IDguMTAgR2Jwcy9MYW5lDQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIDEwMDAwMDA6
DQo+ID4gKwkJbGlua19yYXRlX2luZGV4ID0gTElOS19SQVRFXzEwOwkvLyBSYXRlXzEwDQo+ID4g
KFVIQlIxMCkgLSAxMC4wIEdicHMvTGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2FzZSAxMzUw
MDAwOg0KPiA+ICsJCWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV8xMTsJLy8gUmF0ZV8xMQ0K
PiA+IChVSEJSMTMuNSkgLSAxMy41IEdicHMvTGFuZQ0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJY2Fz
ZSAyMDAwMDAwOg0KPiA+ICsJCWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV8xMjsJLy8gUmF0
ZV8xMg0KPiA+IChVSEJSMjApIC0gMjAuMCBHYnBzL0xhbmUNCj4gPiArCQlicmVhazsNCj4gPiAr
CWRlZmF1bHQ6DQo+ID4gKwkJbGlua19yYXRlX2luZGV4ID0gTElOS19SQVRFX0lOVkFMSUQ7DQo+
ID4gKwkJYnJlYWs7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGxpbmtfcmF0ZV9pbmRl
eDsNCj4gPiArfQ0KPiANCj4gRGlmZmVyZW5jZSBiZXR3ZWVuIHdoYXQgdGhpcyB0YWJsZSBpcyBn
aXZpbmcgdXMgYW5kIHdoYXQgd2UgYXJlDQo+IGdldHRpbmcNCj4gZnJvbSB0aGUgZm9ybXVsYSBp
cyBjb21pbmcgZnJvbSBTSUxFTkNFX1BFUklPRF9USU1FIGFuZCB0bGZwc19wZXJpb2QuDQo+IElu
IERQIHNwZWMgdGhleSBhcmUgdXNpbmcgbWF4IHZhbHVlcyB3aGlsZSBvdXIgY2FsY3VsYXRpb24g
aXMgdXNpbmcNCj4gbWlkcG9pbnQuDQo+IA0KPiBJIHRoaW5rIHdlIGNvdWxkIGp1c3Qgc3dpdGNo
IHRvIG1heCB2YWx1ZXMgb24gdGhlc2UgYW5kIGRyb3AgYWRkaW5nDQo+IHRhYmxlcyBjb21wbGV0
ZWx5Lg0KDQpUaGlzIHdvdWxkIHVubmVjZXNzYXJpbHkgaW5jcmVhc2Ugb3VyIHdha2UtdGltZS4g
TWF5YmUgd2UgY291bGQganVzdA0KYWNjZXB0IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gY2FsY3Vs
YXRlZCBhbmQgcHJlLWNhbGN1bGF0ZWQgdmFsdWVzIGFzDQp3ZSB1bmRlcnN0YW5kIHdoZXJlIGl0
IGNvbWVzIGZyb20/IFdlIGFyZSB1c2luZyBtaWQgcG9pbnQgaW4gdGhlDQpjb25maWd1cmF0aW9u
IGFuZCB0aGF0IGlzIHdoYXQgd2UgdXNlIGluIHdha2UgdGltZSBjYWxjdWxhdGlvbiBhcyB3ZWxs
Lg0KVmFsdWVzIHRhYmxlIGZyb20gVkVTQSBzcGVjIGFyZSBjYWxjdWxhdGVkIHVzaW5nIG1heCB2
YWx1ZXMuDQoNCkJSLA0KSm91bmkgSMO2Z2FuZGVyDQo+IA0KPiBCUiwNCj4gSm91bmkgSMO2Z2Fu
ZGVyDQo+IA0KPiA+ICsNCj4gPiDCoHN0YXRpYyBpbnQgZ2V0X2VzdGFibGlzaG1lbnRfcGVyaW9k
KHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+ID4gwqAJCQkJwqDCoMKgIGNvbnN0IHN0cnVj
dCBpbnRlbF9jcnRjX3N0YXRlDQo+ID4gKmNydGNfc3RhdGUpDQo+ID4gwqB7DQo+ID4gQEAgLTEz
OCw4ICsyMjQsMTcgQEAgc3RhdGljIGludCBnZXRfZXN0YWJsaXNobWVudF9wZXJpb2Qoc3RydWN0
DQo+ID4gaW50ZWxfZHAgKmludGVsX2RwLA0KPiA+IMKgCWlmIChpbnRlbF9jcnRjX2hhc190eXBl
KGNydGNfc3RhdGUsIElOVEVMX09VVFBVVF9FRFApKSB7DQo+ID4gwqAJCXRjZHMgPSAoNyArIERJ
Vl9ST1VORF9VUCg2NTAwLCB0bWxfcGh5X2xvY2spICsgMSkNCj4gPiAqDQo+ID4gdG1sX3BoeV9s
b2NrOw0KPiA+IMKgCX0gZWxzZSB7DQo+ID4gKwkJaW50IGlkeCA9IGdldF9saW5rX3JhdGVfaW5k
ZXgoY3J0Y19zdGF0ZS0NCj4gPiA+IHBvcnRfY2xvY2spOw0KPiA+ICsNCj4gPiDCoAkJdGNkcyA9
IDcgKiB0bWxfcGh5X2xvY2s7DQo+ID4gwqAJCWx0dHByX2NvdW50ID0gZHJtX2RwX2x0dHByX2Nv
dW50KGludGVsX2RwLQ0KPiA+ID4gbHR0cHJfY29tbW9uX2NhcHMpOw0KPiA+ICsNCj4gPiArCQlp
ZiAoaWR4ICE9IExJTktfUkFURV9JTlZBTElEICYmIGx0dHByX2NvdW50ID49IDANCj4gPiAmJg0K
PiA+ICsJCcKgwqDCoCBsdHRwcl9jb3VudCA8IERFRkFVTFRfTUFYX0xUVFBSX0NPVU5UICYmDQo+
ID4gKwkJwqDCoMKgIGVzdGFibGlzaG1lbnRfcGVyaW9kc1tsdHRwcl9jb3VudF1baWR4XSkgew0K
PiA+ICsJCQllc3RhYmxpc2htZW50X3BlcmlvZCA9DQo+ID4gZXN0YWJsaXNobWVudF9wZXJpb2Rz
W2x0dHByX2NvdW50XVtpZHhdOw0KPiA+ICsJCQlyZXR1cm4gZXN0YWJsaXNobWVudF9wZXJpb2Q7
DQo+ID4gKwkJfQ0KPiA+IMKgCX0NCj4gPiDCoA0KPiA+IMKgCWlmIChsdHRwcl9jb3VudCA+IDAp
IHsNCj4gDQoNCg==
