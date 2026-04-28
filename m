Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9B4FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 20:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6CE10E390;
	Tue, 28 Apr 2026 20:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cAS8MV8D";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6AF710E383;
 Tue, 28 Apr 2026 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777406509; x=1808942509;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CJPCyrRbM+eNWTQJJP0SXjXP/Kwqj0He70GvpSRtazA=;
 b=cAS8MV8DX3RK0sU2UffvHpUNRiJGu6SZSqHEd750xHe8cPtJ1iRLvhTw
 bolA90L6FQYAp1YIe3bmlfpoKslIoMU5oDm6iGSHYTTTM7r+hnULyU+Al
 bcX1LVcPrwS9UK150W5ZwmtXHSN6XX7VEu4mF8gqlKqEUl5VlpA8Kf4kD
 TWU0L278jsCqlX+h2Tj421eNJYVD2j/v/02OMsGmpfU7HRyi2Vdo7Zb6y
 32pyTAxCTR8s71b7yx2FEv3c5XaXe98Ul3CoTUaJxyTL0U/NfGPSWeoUp
 Y/ipWtlFbj/4e7tpwg9RyhDeYjw4275UBkZJjhVthE7cWBPfHyUO3NOun g==;
X-CSE-ConnectionGUID: ONyd10PuRomh6b7JJ6T1yw==
X-CSE-MsgGUID: u5eHW90NROGCSvQM0AgZrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89790056"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="89790056"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 13:01:49 -0700
X-CSE-ConnectionGUID: GoWqMXz5TS2q5GpFJgx/Rw==
X-CSE-MsgGUID: PvfYkXeaR5m5393emM0mfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="235810082"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 13:01:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 13:01:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 13:01:47 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 13:01:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdeC/e1TSUIKkwQAN9ah5ZiG0iyjLOWUkeaFYTzrAzxB3sADM/PkB2Ym9LYkYOaTWt8au8Un/P2LCNm+zpr2EMqHv6dRN4GMf5BQB+LpHo/94q0Ip5Jt5d2Al/hvH6Dk/bxZVWQ5r5xF56763LTWjHUX4SAHCsKvVkb26u8FubT4fvxeDcWlVo6gahJRlcerCMLivbZrmyVDyvevv5Nn7jXL3ji0XbdnForUzYMU5QDfOiirA9jn/Q8UNKszoGZgAsVrFFxvNqseKxOjt/iCtEg42jkv+rI9Czy8wrYRLDNGr/WD8lMnTv6iczrZDCOa/2JcM4gVTzJZaDGqrQ2Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJPCyrRbM+eNWTQJJP0SXjXP/Kwqj0He70GvpSRtazA=;
 b=og1rWNNi6f7s0Zk8b+6l9Gnmk5/f72HHRjPADWFtcCLQzVVq5GAjLUhBcJwruPMRez85DiLj/VCo8dFFdXJzvG18vEuQ8qwObXHOVsgOqeqfSeDIwcv+CY740jBCr2XuAqM+vcvjcD2nrqmtjqJloqCGvkTIMdVx88Lpi2t1ZrNl8+NmlHpT5HJkB1sAFIGd1jF6Eukrs2a+5ss16YsofQ0Ldwih5BK3rsLfXRisiaEj8qLRJ2yuEWbuNAXx6yExuryEC1d47WDpdcEGdBKM/eHSLsIRNaja2txf45WocS3BlBkt013iydVlc9PYcK2hh2HLV6A0Kxm6u+nYNFOybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by MW4PR11MB5909.namprd11.prod.outlook.com (2603:10b6:303:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 20:01:43 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::7396:3750:f6eb:4765%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 20:01:41 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Brost, Matthew"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
Thread-Topic: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
Thread-Index: AQHc1vlsbtCF/31GwES5LjCUe0So2bX0UQaAgACTxQCAAACRAA==
Date: Tue, 28 Apr 2026 20:01:41 +0000
Message-ID: <c039c23483b6b280806b8c7fa100f6de26e18ce0.camel@intel.com>
References: <20260428102527.189593-2-u.kleine-koenig@baylibre.com>
 <be82fd356047513f23a3193d8007a2e5e8d97e35@intel.com>
 <afERYJuuvZmexQ4-@intel.com>
In-Reply-To: <afERYJuuvZmexQ4-@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|MW4PR11MB5909:EE_
x-ms-office365-filtering-correlation-id: e7b65c8c-374c-450c-8e44-08dea560f767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: kjSpCV3Cxv860CuhsDNsh4VPpZ3qRpORUim7bRtlHcj4oB1Qe7+lunpdz6azBu7UaKhEQqks3ungy9enh0OVy5krX3AUnqAi4PqSkKOLLiqYVmOSVp5+P15XaSZYfeSI3QXdANystHmg11O2zQIsfqL4XPl9o3xn4oIFEv1uN+a2DYP2zgc/jWIP6Pcs3ZXJwVCmjPhPRgPHoj2L2reLj+jR+RBvymOs9oUXII++XKz08gzoIzb81B3LwrQAdZWHMuxCN/GEka1iKVb0mYaSl5j9IhpNzHnZxgLURJ6rrn4+toNSqrFB7IfDLapAG7iKXvwNk0AWuV5+T07RvtBjRt71hW9vtFbdjp6ZWyZa+tbQz+gLR4fE/cQv0zgLRtTLeN+YDbxrLvVr2XQozYBttfVNmRoqW1lNx461e57H8YkHiP709HBXExdhAYC96F77TbUZT4BmKHh6wx379vbVxt88PHU9rxXuyHHM+XtqgGZBLNMnH4EzWogleEZB2NxPdt/Ry+XGOWxR4CIT9cfR0e8z2NfJ1mkapYJbx59TQCL99GFhqu0exl/xK3p6vfPexykMvaJEZkZ5Efefjjp4QLAiv/ubJw7n3dau0q3eX9TC2bQAWVrtXPUQT2XmTOZIuONV7A1oma2O0rOF3wzG35Gbc7DE4Ynf0AC3E2YjkrmGJENYGENB+xzhn+DoQX2iuz84swevYI8PGCT9vTqJ75ssjHhVSwWJVkf3MN8w+7/bFlI4k6QzBW23UrL6J4Ls
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB8179.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0I0bG80anFNNnBZY3ZDN3VSTVpja1NkS3lkTzZtN2hkVEVQNXFuRUE3S2ZF?=
 =?utf-8?B?Sjk2TDN0R0pSdHF0cFBEL3d5MjJQWndPYzFXWTVQeGtVWkdDNkE5UTAvdGNm?=
 =?utf-8?B?Q3h4US9TU2tsT2FFOXJBMUZMTnorQkEzSUIzOGk5Qi9uY0pxazdxUVBXemZ6?=
 =?utf-8?B?Z2FIS0s4b1Fjd3pHbUNDV2lCL3pCYUhudmtaSDhzMTUvMGlQSVd3N2dXaXda?=
 =?utf-8?B?N01CVlNaM2t0T2NvSVJoaDJoR251bUZjQUZ2cGVGc1RvRVBrcjhhcFpkL1d3?=
 =?utf-8?B?bnVlVTBvQms3MEQ0ODdhUERMSHJ1bDdUUnVvWXAvc2lWTEtJTzRCbmwxY1Zy?=
 =?utf-8?B?ZjdoL1U4RUJTbjNiTXlwK0FBSHZqVXJZTTk2RHRpS3ZCV0lRVzBoQ29rRS9t?=
 =?utf-8?B?ZGVoU3JGeXVmSEZXenc5VE9DUlRERkRPQmRLWWVRYXZVVm5qdUlwNGovc0Vh?=
 =?utf-8?B?ak5UWDR0MDZuUmFWak16U2hYaFdSeGZucmlJUEdOdnkyeHpBU096T0pydFh2?=
 =?utf-8?B?U0xoak5LS0RJS0N5bWVWUDRsOTVHSEJzY2FmSkVsZW1rMkdDWjVhckE2eGg1?=
 =?utf-8?B?MDl2d0Z6cmpqZWdGN295WWlDakpJMXh2WmFpRDdHWVNkRlR0TXBVODVQUngr?=
 =?utf-8?B?VVMxMzExWkE0aG5ON254YlJSczFTdm1OMFhyeVZRN3FWMXU3UWdEalgvTGNk?=
 =?utf-8?B?NmVKa2VGM1RHNG0waXpiZjlYY0FnMWFjSWo5TXpadVg4MElxOVN2Y3pHWE1t?=
 =?utf-8?B?NmZ3dEhETjlOcWx0VmQ2anZyek1ZdVhZQjBJazl1VFZ3Mjk4c3JyZDNaK2Rp?=
 =?utf-8?B?eEhNcnljNHdzRGhQVmRjcHJBc1R0M3U0UVdIZkQ4OENnQXZBQ2VUeHJrNFpY?=
 =?utf-8?B?R1F6c2xGTVJFbW5PMlFpNnVzNDNUcFIxMXB5QzBmTG1IUlJKeUZOQ0xjUGpE?=
 =?utf-8?B?cWlQY09JeGJQQmdabElOWnpWUHZ6WTBxQWx3eURkMmFlMkZDdVpaZityRUlJ?=
 =?utf-8?B?ZVVmOFp5aEVIdnJpWXhFb1k2TTA4N0xLSVptb2ZQd01YSWRTaG1VdDlVRDh4?=
 =?utf-8?B?QjI3bkxPV0N1QnBvSzNaWlRHTHV2d1VyT0IyRXlwejJJTHQySkF6dFhWRE1l?=
 =?utf-8?B?dFY2SHg2TmMwdklkbEFScUJ3LzQ3Y1ByK2hyTjlVNHJEZFprOHlqVXVSczZM?=
 =?utf-8?B?TEluRGpVVHBiSkFFL0tyS1FrR2tlZmRLVDBzYXpZT2ttVHMwdzV5THgvK203?=
 =?utf-8?B?SUtweWl6NzUyWU9YN3VuM24wNUJtYnBjakNReFNlL3k0QzFZVVZMWTI3NFUw?=
 =?utf-8?B?blFPUXhzT0JwTlB0ZnlJRTV2UnZMVmc5TFdzcGxZRE1rZ0o3RkE3bkxRWkt4?=
 =?utf-8?B?QkdsM2UzUzkrSkFpUWdiR00xRHdSSWp5RkFIdTd2VjBmOW9RaWNDWE1WK3Vk?=
 =?utf-8?B?cWp3aUY3eVJTc00zMWsvYW91WHpneHZ1T0FLdVg3WVdYUjQrZHVKL2VySGNl?=
 =?utf-8?B?OE02cEllYmJkZXRGTXJwUElVODREWFlDcUtYRUI4K2cvRmdzeDhGdlY5Ujlm?=
 =?utf-8?B?V0kxY1htanVEYjc5THk1RVBxUURodGVJUXM3b1M4WFB6T25wWTA5aXBZUXF6?=
 =?utf-8?B?SXY5c203cWFvaUhuWXI5b1BUWmFhaDRIbjRmakxabk1TK2g3ejJTaExDQ3M2?=
 =?utf-8?B?Y0NqOFJCUUtQdTlkRGdlQ1hDcWFtdlY0S3Nxcm9wOFd4SFIzaXdRRWoxM1l4?=
 =?utf-8?B?dGN5a1FiYWZJSy8xRVdGenU2aUtWd3huNW1mZXBYbThRZTQxemlSUkZZVy9h?=
 =?utf-8?B?V2ZySmkvRDh6STl6dXlZZ1pyTldrWXRGSHF5SHpsS240NVdJMGhDUThTRzdM?=
 =?utf-8?B?ZVBsclE5NDYyejliV1FYWi9pM2FkK1RsTERxMmlXK2RYdUgxUXlrNmNsMHNS?=
 =?utf-8?B?SjNPR0dmUFR1OXJhakJWM1hCSWhqRk5XTk1JVXlKbS9oc2VIVUxTdTlVd0ly?=
 =?utf-8?B?eUlDVUZRbWxJWkpuemFyTmJjWDlMdEdaczMyU1lIZVZiYnNoNGtYY1JEL0h4?=
 =?utf-8?B?NmNnZGpKUGxXWEN4SzgrVk5qdkMwOUhUeGZOaVRzMGxCYmd0OENBdlp2YWNI?=
 =?utf-8?B?RkE1QzRCa3ZnbWcvcHRZTlBYMzU3NDV2ZjU0U3ZvZVA5V3lxY1BwRGloS2V1?=
 =?utf-8?B?V1pUaVBDYTAzLzBiOHl5MDR6R2JPM3VmVFhNUzZiS0NKczZTMVU5ajhQOFVm?=
 =?utf-8?B?RVRtWE9pRDBlZnJ3dHZ3Z1B2aDVCdlhFQmFPaVFoaFJDLzByMjVzd3I2RFY3?=
 =?utf-8?B?R0xCVTdWMitva1g2QUZobEIrRTNzeGVXYTMrN3dGZlQyNzRkelBoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91C095C41CF610429FDF4FA038F82E24@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G+3NpeFlibR2jq+dPTW3JbD/LVm3DWj6ggfeIbLsyltwcb3EA/7yEqQaIEpUg90IX5VCc+yzU+oP07AwkkwHOhYibrKeIualBDo0A9+eA2rY2VZCZVHh9bi0ZHSbIDFsuS2+LqCdobLtzIGnkIHMReg8Q5Hh6s3jqktN0tj5/IPMNpvq4Y9WYVCI+28voHo1GMYt1Y1dGHqGh0LBgLoMa8kf/5jCYWKyjy5pPQuPDtVqhyp23Pv2FhrOhyIvq/POtmMpIbyydUcfqORcCD1H5MsrSZksQLb9XkzYx1E11abAgNZw7YK3G0AlSxTcfh5SRjSi+zqU41IvTeyegUZk2w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b65c8c-374c-450c-8e44-08dea560f767
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 20:01:41.9091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJEb2W4iq6l5VOQGnnqLT4kQzDTuRvgIq2ptPdmi+ffLELUi5jjVWnJtnN6d2j3hHqfM0Qoe8w6Ip2ZOhuc3xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
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

T24gVHVlLCAyMDI2LTA0LTI4IGF0IDE1OjU4IC0wNDAwLCBSb2RyaWdvIFZpdmkgd3JvdGU6DQo+
IE9uIFR1ZSwgQXByIDI4LCAyMDI2IGF0IDAyOjA5OjMxUE0gKzAzMDAsIEphbmkgTmlrdWxhIHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjggQXByIDIwMjYsIFV3ZSBLbGVpbmUtS8O2bmlnIChUaGUgQ2Fw
YWJsZSBIdWIpDQo+ID4gPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+IHdyb3RlOg0KPiA+
ID4gVVRTX1JFTEVBU0UgZXZhbHVhdGVzIHRvIGEgc3RhdGljIHN0cmluZyBhbmQgY2hhbmdlcyBx
dWl0ZSBlYXNpbHkNCj4gPiA+IChlLmcuDQo+ID4gPiB1bmNvbW1pdHRlZCBjaGFuZ2VzIGluIHRo
ZSBzb3VyY2UgdHJlZSBvciBuZXcgY29tbWl0cykuIFNvIHdoZW4NCj4gPiA+IGNoZWNraW5nDQo+
ID4gPiBpZiBhIHBhdGNoIGludHJvZHVjZXMgY2hhbmdlcyB0byB0aGUgcmVzdWx0aW5nIGJpbmFy
eSBlYWNoIHVzYWdlDQo+ID4gPiBvZg0KPiA+ID4gVVRTX1JFTEVBU0UgaXMgc291cmNlIG9mIGFu
bm95YW5jZS4NCj4gPiA+IA0KPiA+ID4gSW5zdGVhZCBvZiB1c2luZyBVVFNfUkVMRUFTRSBkaXJl
Y3RseSB1c2UgaW5pdF91dHNuYW1lKCktPnJlbGVhc2UNCj4gPiA+IHdoaWNoDQo+ID4gPiBldmFs
dWF0ZXMgdG8gdGhlIHNhbWUgc3RyaW5nIGJ1dCB3aXRoIHRoYXQgYSBjaGFuZ2Ugb2YNCj4gPiA+
IFVUU19SRUxFQVNFDQo+ID4gPiBkb2Vzbid0IGFmZmVjdCB4ZV9kZXZjb3JlZHVtcC5vLg0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyAoVGhlIENhcGFibGUg
SHViKQ0KPiA+ID4gPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+ID4gDQo+ID4gUmV2
aWV3ZWQtYnk6IEphbmkgTmlrdWxhIDxqYW5pLm5pa3VsYUBpbnRlbC5jb20+DQo+IA0KPiBDYzog
Sm9zw6kgUm9iZXJ0byBkZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQo+IA0KPiBKb3Nl
LCBhY2sgb24gdGhpcz8hDQo+IA0KPiBJJ20gYWZyYWlkIHRoaXMgY291bGQgYnJlYWsgdGhlIGN1
cnJlbnQgTWVzYSBwYXJzZXIsIHNvIGJldHRlcg0KPiBjaGVja2luZyBmaXJzdC4uLg0KPiANCg0K
SXQgd2lsbCBub3QgY2F1c2UgYW55IHByb2JsZW1zLg0KDQpBY2tlZC1ieTogSm9zw6kgUm9iZXJ0
byBkZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQoNCj4gPiANCj4gPiA+IC0tLQ0KPiA+
ID4gSGVsbG8sDQo+ID4gPiANCj4gPiA+IChpbXBsaWNpdCkgdjEgb2YgdGhpcyBwYXRjaCBpcyBh
dmFpbGFibGUgYXQgDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy8yMDI2MDQyNzE2MDkw
Mi4xMTI2MDI3LTItdS5rbGVpbmUta29lbmlnJTQwYmF5bGlicmUuY29tDQo+ID4gPiAuDQo+ID4g
PiANCj4gPiA+IFRoZSBvbmx5IGNoYW5nZXMgc2luY2UgdGhlbiBpcyB0aGF0IGluc3RlYWQgb2Yg
ZHJvcHBpbmcgdGhlDQo+ID4gPiBrZXJuZWwgbGluZSwNCj4gPiA+IGluaXRfdXRzbmFtZSgpLT5y
ZWxlYXNlIGlzIHVzZWQsIHdoaWNoIGlzIG5lYXJseSB3aGF0IEphbmkgTmlrdWxhDQo+ID4gPiBz
dWdnZXN0ZWQuDQo+ID4gDQo+ID4gQWxtb3N0IHRoZSBzYW1lLCBidXQgYmV0dGVyLiA7KQ0KPiA+
IA0KPiA+IEkgd29uZGVyIGlmIG1vc3QgVVRTX1JFTEVBU0UgdXNlcyBpbiB0aGUga2VybmVsIHNo
b3VsZCBiZSBjaGFuZ2VkDQo+ID4gdGhlDQo+ID4gc2FtZSB3YXk/DQo+ID4gDQo+ID4gDQo+ID4g
QlIsDQo+ID4gSmFuaS4NCj4gPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzDQo+
ID4gPiBVd2UNCj4gPiA+IA0KPiA+ID4gwqBkcml2ZXJzL2dwdS9kcm0veGUveGVfZGV2Y29yZWR1
bXAuYyB8IDQgKystLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3hlL3hlX2RldmNvcmVkdW1wLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNv
cmVkdW1wLmMNCj4gPiA+IGluZGV4IDU1OGExYTk4NDFhMC4uMDdjN2M4OTI0MGQ4IDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2RldmNvcmVkdW1wLmMNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9kZXZjb3JlZHVtcC5jDQo+ID4gPiBAQCAtOCw3ICs4
LDcgQEANCj4gPiA+IMKgDQo+ID4gPiDCoCNpbmNsdWRlIDxsaW51eC9hc2NpaTg1Lmg+DQo+ID4g
PiDCoCNpbmNsdWRlIDxsaW51eC9kZXZjb3JlZHVtcC5oPg0KPiA+ID4gLSNpbmNsdWRlIDxnZW5l
cmF0ZWQvdXRzcmVsZWFzZS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC91dHNuYW1lLmg+DQo+
ID4gPiDCoA0KPiA+ID4gwqAjaW5jbHVkZSA8ZHJtL2RybV9tYW5hZ2VkLmg+DQo+ID4gPiDCoA0K
PiA+ID4gQEAgLTEwMSw3ICsxMDEsNyBAQCBzdGF0aWMgc3NpemVfdCBfX3hlX2RldmNvcmVkdW1w
X3JlYWQoY2hhcg0KPiA+ID4gKmJ1ZmZlciwgc3NpemVfdCBjb3VudCwNCj4gPiA+IMKgDQo+ID4g
PiDCoAlkcm1fcHV0cygmcCwgIioqKiogWGUgRGV2aWNlIENvcmVkdW1wICoqKipcbiIpOw0KPiA+
ID4gwqAJZHJtX3ByaW50ZigmcCwgIlJlYXNvbjogJXNcbiIsIHNzLT5yZWFzb24pOw0KPiA+ID4g
LQlkcm1fcHV0cygmcCwgImtlcm5lbDogIiBVVFNfUkVMRUFTRSAiXG4iKTsNCj4gPiA+ICsJZHJt
X3ByaW50ZigmcCwgImtlcm5lbDogJXNcbiIsIGluaXRfdXRzbmFtZSgpLT5yZWxlYXNlKTsNCj4g
PiA+IMKgCWRybV9wdXRzKCZwLCAibW9kdWxlOiAiIEtCVUlMRF9NT0ROQU1FICJcbiIpOw0KPiA+
ID4gwqANCj4gPiA+IMKgCXRzID0ga3RpbWVfdG9fdGltZXNwZWM2NChzcy0+c25hcHNob3RfdGlt
ZSk7DQo+ID4gPiANCj4gPiA+IGJhc2UtY29tbWl0OiAyNTRmNDk2MzRlZTE2YTczMTE3NGQyYWUz
NGJjNTBiZDVmNDVlNzMxDQo+ID4gDQo+ID4gLS0gDQo+ID4gSmFuaSBOaWt1bGEsIEludGVsDQo=
