Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401D5CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 04:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A442010E325;
	Fri,  2 Oct 2026 04:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dEqmp5wg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BA110E0C2;
 Fri,  2 Oct 2026 04:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790916101; x=1822452101;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PvbfeFV/PSVuE9nb+BAXb6mUGUz8m9FhVp06mBzUikQ=;
 b=dEqmp5wgqondhihjB8du7pEv0MeP4RrnTA+IvjPOdgvkXwFuY46Uz2fL
 kbZp+pKdJ3sjAgajWdYXmiZJLqEcsr6/4R6eR+C512QZ3AxNwaFRyoDJ7
 JLQmww7aIyLYuLTVCLGA6k3it4i0gTIr4LVX/xXXpOKzwBO4HtEfeCQVo
 pj4mLuESH6G1lNcgFlqRsM2St9alEbncndeR1V7J3NlWkOah9k0gVZ9HS
 /J8gLbi+Uwhewi+ya75Bt+Md5RQj7hVTcnqtD6sf2P+RKau8vBUqJTBLy
 YcaE7I4/Gc0jWEpgpTOc4X8L7/TQ/RcHr+PioNjX3qSvdaWOplSwg+Jzi Q==;
X-CSE-ConnectionGUID: Zp7rN8rzTRG4CWszktNMwQ==
X-CSE-MsgGUID: WFDkGOMzSNuhNUC1cVDn1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94396060"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="94396060"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 21:41:40 -0700
X-CSE-ConnectionGUID: iWt4zQnVSZqQUJ2kr09RHw==
X-CSE-MsgGUID: U6psyuyRS26I0bwiBSe48w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="304126612"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 21:41:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 21:41:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 21:41:39 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 21:41:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HooiK2qp0XRCK1IY5anp+k2LOtn7uzsmoOz+48F2LMJjHQkuG+MWwoqGgrj68LmlmkgJktwX5jT+dgnESEL/Pno0VWEZMN0Tmy84dTixu6KY/hatzXpIu/t0NpNbOGGbv4zHU6MFTXPqBDj+uZv6olo88Ez99tlS7EkjnHGif/LTz0u7myKoHOO/42fmUmXi+9WeLkHbw1hwwAToWwfgKnyGl2OxpKoYrA0/P8KRp7IVMYiUhqQdrhdrnRWMOx8+hUkiwXDAdbspc+Q9PcYqd7kyg+Es9VzjAZIcBTzmdTDAwnqzg69bTjzvakUHGTWCjHXoq4hSHnG8Q0vE+evFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvbfeFV/PSVuE9nb+BAXb6mUGUz8m9FhVp06mBzUikQ=;
 b=pqG0C98lyTpXXztcPO1IO0UKflpHVTCvE0PG2XsfIXx2N1+Ptxiue16dYG3m2WjWsEYmPCHs6V+uWt9rhDVBeqn45KibfT12lp9wTxhCMJQvmdRjEhCv/EsQjzJ9VkhkyZoQUM+ozasr24Vn9m0a9VlivQWLGq350JsErKXAYyYI0fZ5TZ3oEhSWFAdigkSJ/LqGIoeKyWMwu1Ha8DM+0GWyGWF7IYRXlN6EtJnUJEo3tojSPgREFf5g+YU78dVxqY3E5XVWQ1w7Hi2m9ZDBLgrcqs7Qz8AcwISJhpWA3r9J+wjfFLNR134EpjYjLWL1ktda0chWNivW0yxb26516w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CY8PR11MB7289.namprd11.prod.outlook.com (2603:10b6:930:99::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.26; Fri, 2 Oct 2026 04:41:37 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 04:41:37 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 12/18] drm/i915/alpm: Program LTTPR count for DP 2.1
 ALPM
Thread-Topic: [PATCH v6 12/18] drm/i915/alpm: Program LTTPR count for DP 2.1
 ALPM
Thread-Index: AQHdRUGVVMFGhCiNkUm287L0pvh1tLbpxhiA
Date: Fri, 2 Oct 2026 04:41:37 +0000
Message-ID: <c2ca60e3b9742c58002c14c4800bfa1d0ea88e7b.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-13-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-13-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CY8PR11MB7289:EE_
x-ms-office365-filtering-correlation-id: a60791fe-b9af-45db-9b04-08df203f719a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: jo2DxfZVyRH7TBdioHJl3EvaRMLl3pBF4p/IVN6bB/r591uyhJKadY1GlfH1HEwApWhDE9XL1hpyBaawPMu4O4zgvR9WsFS5pQ4vfK2fRqV0Uoo6Cdwnsqmcy7F7qVQZRKM68ZuJyfs6aK6LgnIZNn+SSQ0aPhGZ5DAXOSPK3H29gClKXN2IBEDN3R3W+WkX9R4lUPoG7bXDZ5+c/ZLhMEwFoW2l+g1WVtMRWz7hqRApkQsczOMwKEZM1rIHReug72i3NSf3l9YvcuGObut6V3t8KJOxAy6dARJ6VePQbGo6Kt8ZCMCPKQzqRWgTUiNOKKxX0MXV6Lp+BRLvf0dKZxpfJ/7Fo3r3DmbzQzcz1q38wFjXCb0OvXsydyGB56gjU0F61j2KOZhuPuRSlztuHeX1d/3kaW6a+FU3FMysiAipmo/nwdSRwCcGi6vhjATyE9eXrxac3vyXpYzPPjPlUJ2iA9VuWnek7y19QiN9Zz6KoR0WoJTVLaMRKndoiBPdtpLiv7EFbyq5AsccjXDnZGiy1ktwvGR+3RFv5IIqhSxgWkFy94EGi2EX2QQuDmGiM2no1zn7m1MgZ1axmGvyxEvMK2UwFvukq8djFTTNwPe8EUPtl8nfnk5oPEvY6Lm9H9UDDS1ba8SFeJdEZrIsUx9OQNvqOyPkrslDaYy5gwODJ0fsIH30QhrsUFtbEJ01BljBPzqTgpNPPog1SKDFvaYSMb4xXkR7f9PdhvJ5b2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTg4Y3NpTzd2dXRUZmcvRXBxc0VNQitFSk45OGhJY09Cd1MwRGVVOTdCbWgw?=
 =?utf-8?B?TkQzVnp4cXB5NzVxNllYcXR6NGNmSmJsZ1A0aHMwSUZzTUFlR2lpMys1TU5G?=
 =?utf-8?B?OGNyb3E3NzdOMy81cUxNREk0QjZuSks4bG5lcmgvQkY4L2VoRG1CUnhrYmdP?=
 =?utf-8?B?NExXZU9xZzFKSTROYTM2L2RrbXRNMlJmYk0rbXA4cEZSVnBzenA2UnJIMU9L?=
 =?utf-8?B?QlZoZXV6WEJnaHYxelhmT3dzMklrRm96Nm9Pak9hN1g0WVpSNk1CaXFVVk9t?=
 =?utf-8?B?a0VRakZCdXFhUmJTZmhvZFNXV0R1aDNaY3k5VThXb01KcDR5dm9CbXdNVkMw?=
 =?utf-8?B?c0R1a2c2N1NhcEZvVWNhRHpFeDFmL1dacWxUaFpGNzY0RzEyZkMyVHdUUjlM?=
 =?utf-8?B?WnB3T3E4aDJQbDg5TVRIN1BLZW9oSFJmaDhZNjdPT3lWNGVMdzA0M3VuZk0x?=
 =?utf-8?B?L2kzSW85SytQeTFxUEhySGNPZVBTYWJHdURZelJ0bG45V3BEenlLZk9STHJp?=
 =?utf-8?B?bmFJdU9PendoeVZHTGw0UGtvbEVtckZycU9pRUxjeHhCd0l1cWpBdGhmWVZT?=
 =?utf-8?B?US9VL0lPWXVDWlJ4UkFlWVdXd3hvQVFCWmFhRTJkYzN5Z3Iyd3hFeFMzTWxo?=
 =?utf-8?B?UWUvcEx6RDBvbnpzS0pUZUtUdzVqd3VTU0QyR0JxbXk5S1hZN3dieW9SOFd6?=
 =?utf-8?B?MmllTWpqUGN1T0J0Q3hIMEdiRk9CTTBPQlZRby9FU3l4M3V2dkZMKzFMUWdN?=
 =?utf-8?B?eGtwcTViVDVnUUNLRHp2QlJUV1hUdVd4WDVtUXJ6RUJBVEJ6RzE5ZUxaS3J1?=
 =?utf-8?B?RlJ3WG5GeG10RkRmQTRSaUFyWm4zZ241SHIyc0JHKzdYeDBZUDVIeGxCbGJk?=
 =?utf-8?B?TmZlUE9aTG1TS2k1V0kyYWFhamlvZ1Nselpmc2xhcy9WN3pvWkdTUy94TVJw?=
 =?utf-8?B?WmdyVzZ1N2cveTA0ZXRTc21NVytDZ2U5cDZHU3dYRzI1WjFvZVJlQ3V2dVFq?=
 =?utf-8?B?YWxha0xKL3MvSktxV0llV3FWRDNPRVg4VU9QUk5YSjloVFhpZFRpWTN0L1F5?=
 =?utf-8?B?UlN0cG5vaHFpa0VVVmg1QklZWDdubVI5NzRnSTJkTVdGUk1BeFhjSWVXeEcx?=
 =?utf-8?B?V1VlMThZV0NBMVdsMEI5VmdOWURiZGIwZ0ZHWTZlbEp3czhqQ21DeXlZWk9B?=
 =?utf-8?B?amk0dEtRMHpSNWhPaEl3K0h2Y3llcFA1MWVzdDR0dXQ2ejFvK0c0dS9YUHJy?=
 =?utf-8?B?dnJuVmhVaDcxZHNkbWxvaENkWXlsVDIzV29xMk1FcVp4bUo0Y21DQmFHOHZp?=
 =?utf-8?B?RFRRNGhLbm4vVjlVZU8yUWd3Z040RzQ1UWR5T01BK3dBbjR2Qi9NRVdXN3Rh?=
 =?utf-8?B?QlJNaFE3NFRIRFpGVVh2TmowRi9EWnkzT3c1am5CRFh3NUwyRkYxcjRJYTgw?=
 =?utf-8?B?MnQ2M0FXQ0RGSHVISC9mWmhmYjVUNlhnNlROUTJzNnduaVl0bGJ4cVpVa0la?=
 =?utf-8?B?MG5XSVFvQWFwV0x4dTQ2YlNVOVVWbUNYdGtwN2hCa1QxZ2xSZUVQMWs3ZHpD?=
 =?utf-8?B?R3EzbDFaV09CWW1wZnlTNXcwVFhLUk1URjdSQnVZVTBmYkhoTlFDYStLUWZE?=
 =?utf-8?B?ak9jbUxpTGtuMzFWRDRtd1o5T3UvQXpnYm5QVzlNSSsrK1FJTmhLQXA2LzNK?=
 =?utf-8?B?czZkK1RZZFU5dWxBQ3BtaXVrVy9pK09nWkJVcmsxeFk1a1JNcHYzK0pvZDQ0?=
 =?utf-8?B?eEVhNm8yNlFSaEovODFpaEQ4ZHYxdVFxSVJtQjVuUzBZVkV2bTM3UExUVXN6?=
 =?utf-8?B?dmI3ei82R2ovay80VCt6aUFDTFlZWm8xdVNwRGNxSzhkUEZRRXduS3RJTnVn?=
 =?utf-8?B?U3ZPZFdYVnNtKy85VlZuMkpxOTRvQ3ovMGM3RkJjcGo0YXZQUTdNV1l5UGpS?=
 =?utf-8?B?WnRleDY5dmxVOW5YS3ZjaDA1QVpacGhVdzhBMGt3K1YxUWlna0ZtQU5yTzkr?=
 =?utf-8?B?T21EamVsaUFTcGtUK1Y4eHBvdGgrQ0dHY2ZFa0xiZ1hxYkxnNnRpNmF1QnJz?=
 =?utf-8?B?RlNqZUhTeGJIdllNMmRSZDBMZGdlSEdlK0lITDhmbEhlTjlwcm85cEVXZWs2?=
 =?utf-8?B?UEhxdUxhSnVqQVNGSWtJZzNCZkE3aDIzMlArdHVtS2dBcXVJV0ZBN1I1VC8r?=
 =?utf-8?B?elFkU2gxV0VXWHFjQU13dzZkRWxvT3lYVjBWeXRhYkJ0WFhHKzdIVFZ3Y1g0?=
 =?utf-8?B?MElTU3dKaVE3RHpUQ2JLRTNpMjNmaDBxUlhCUTQwVlNvNThucjEzM0tkWE5i?=
 =?utf-8?B?NytpWUdkMDhubEhob0hmQ2x6enNJZndJVG1SaUI5VzVhN3ErSXdia0h4THo2?=
 =?utf-8?Q?XLJQlg2Exls6+7cc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B25F22AAA31071478442586ABBCA5979@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nUVBx0useoc7R6tMCRf6cfxvzEoCTAVBaZSqzzbZ8FTIuW+iD3/mFiO9qFCPUP+6e4nHr608y0GgpLVICIv6jHjutIxsIOiP+AZhiv7WuZWhUMky52sge8NPadmC7xuzr9m8nl8zijouXjBvPSlwednHRyj90Jc8Zd3Hpdm3EdQ29fPu4ASk0JphsO99ozcOuwNqdc08aOHygmWhmvkyVXKqL5BV7F+dCqWGmRj+Ovts6u9nWgY89qItuUp2kN1dGEErIwy0l71YSg+WcPVMk4DN/aSf4AeoaI0NDkQv/CnJPgLVt6bJZyIJjUN0zH7AaVkpaPz9HTJ3kL2NnDOBaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60791fe-b9af-45db-9b04-08df203f719a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 04:41:37.0665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpkjVsjrojc+la8MCd15Qd4FpFX2oQkzmlvAutZoz7xxY0GhmDQVdDRXXl6fetCxUIzutuvzS5+9BeWw8M5b6DkT6w/lmhPB5SpuEfKH264=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7289
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDIzOjM0ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBJc3N1ZSBhIEFVWCB3cml0ZSB0cmFuc2FjdGlvbiB0byBEUENEIERQX1RPVEFMX0xUVFBSX0NO
VCAoMHhmMDAwYSkNCj4gd2l0aCB0b3RhbCBudW1iZXIgb2YgTFRUUFIgYmVmb3JlIGxpbmsgdHJh
aW5pbmcuDQo+IA0KPiB2MjogQ29zbWV0aWMgY2hhbmdlcy4gW1N1cmFqXQ0KPiB2MzoNCj4gLSBV
c2Ugc2FtZSBlbmNvZGluZyBmb3JtYXQgZm9yIGx0dHByX2NvdW50LiBbSm91bmldDQo+IC0gQXZv
aWQgcmVhZGluZyBhbHBtX2N0bDIgcmVnaXN0ZXIuIFtKb3VuaV0NCj4gDQo+IENjOiBKb3VuaSBI
w7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5p
bWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jwqDCoMKgwqAgfMKgIDcgKysrKysrLQ0K
PiDCoC4uLi9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwX2xpbmtfdHJhaW5pbmcuYyB8IDIxDQo+
ICsrKysrKysrKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfYWxwbS5jDQo+IGluZGV4IGRhNjUzYTQwN2U5Ny4uMDZjMWE1OWFhMmM1IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtNzI2LDcg
KzcyNiw3IEBAIHN0YXRpYyB2b2lkIGxubF9hbHBtX2NvbmZpZ3VyZShzdHJ1Y3QgaW50ZWxfZHAN
Cj4gKmludGVsX2RwLA0KPiDCoHsNCj4gwqAJc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3BsYXkg
PSB0b19pbnRlbF9kaXNwbGF5KGludGVsX2RwKTsNCj4gwqAJZW51bSB0cmFuc2NvZGVyIGNwdV90
cmFuc2NvZGVyID0gY3J0Y19zdGF0ZS0+Y3B1X3RyYW5zY29kZXI7DQo+IC0JdTMyIGFscG1fY3Rs
Ow0KPiArCXUzMiBhbHBtX2N0bCwgYWxwbV9jdGwyLCBsdHRwcl9jb3VudDsNCj4gwqANCj4gwqAJ
aWYgKERJU1BMQVlfVkVSKGRpc3BsYXkpIDwgMjAgfHwNCj4gKCFpbnRlbF9wc3JfbmVlZHNfYWxw
bShpbnRlbF9kcCwgY3J0Y19zdGF0ZSkgJiYNCj4gwqAJCQkJCcKgICFjcnRjX3N0YXRlLT5oYXNf
bG9iZikpDQo+IEBAIC03NjIsNiArNzYyLDExIEBAIHN0YXRpYyB2b2lkIGxubF9hbHBtX2NvbmZp
Z3VyZShzdHJ1Y3QgaW50ZWxfZHANCj4gKmludGVsX2RwLA0KPiDCoA0KPiDCoAlhbHBtX2N0bCB8
PSBBTFBNX0NUTF9BTFBNX0VOVFJZX0NIRUNLKGNydGNfc3RhdGUtDQo+ID5hbHBtX3N0YXRlLmNo
ZWNrX2VudHJ5X2xpbmVzKTsNCj4gwqANCj4gKwlsdHRwcl9jb3VudCA9IGRybV9kcF9sdHRwcl9j
b3VudChpbnRlbF9kcC0NCj4gPmx0dHByX2NvbW1vbl9jYXBzKTsNCg0KWW91IHNob3VsZCBjaGVj
ayB0aGUgcmV0dXJuIHZhbHVlIGhlcmUuDQoNCj4gKw0KPiArCWFscG1fY3RsMiA9IEFMUE1fQ1RM
Ml9OVU1CRVJfT0ZfTFRUUFIobHR0cHJfY291bnQpOw0KPiArDQo+ICsJaW50ZWxfZGVfd3JpdGUo
ZGlzcGxheSwgQUxQTV9DVEwyKGRpc3BsYXksIGNwdV90cmFuc2NvZGVyKSwNCj4gYWxwbV9jdGwy
KTsNCj4gwqAJaW50ZWxfZGVfd3JpdGUoZGlzcGxheSwgQUxQTV9DVEwoZGlzcGxheSwgY3B1X3Ry
YW5zY29kZXIpLA0KPiBhbHBtX2N0bCk7DQo+IMKgCW11dGV4X3VubG9jaygmaW50ZWxfZHAtPmFs
cG0ubG9jayk7DQo+IMKgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9kcF9saW5rX3RyYWluaW5nLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2RwX2xpbmtfdHJhaW5pbmcuYw0KPiBpbmRleCBjYjkyY2ZmOTA2MTQuLjM3
YzgzMDZhMWZhMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9kcF9saW5rX3RyYWluaW5nLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9kcF9saW5rX3RyYWluaW5nLmMNCj4gQEAgLTIyNjUsNiArMjI2NSwyNSBAQCBp
bnRlbF9kcF8xMjhiMTMyYl9saW5rX3RyYWluKHN0cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHAs
DQo+IMKgCXJldHVybiBwYXNzZWQ7DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIHZvaWQgaW50ZWxf
ZHBfdXBkYXRlX2x0dHByX2NvdW50KHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAsDQo+ICsJCQkJ
CWludCBsdHRwcl9jb3VudCkNCj4gK3sNCj4gKwl1OCB2YWw7DQo+ICsNCj4gKwkvKg0KPiArCSAq
IFByb2dyYW0gb25seSBmb3IgRFAyLjEgYW5kIHJldHVybiBpZiBMVFRQUiByZXZpc29uIGlzDQo+
IGxlc3MgdGhhbiAweDIwDQo+ICsJICogd2hlcmUgMDozIHJlcHJlc2VudHMgbWlub3IgcmV2IGFu
ZCA0OjcgcmVwcmVzZW50IG1ham9yDQo+IHJldg0KPiArCSAqLw0KPiArCWlmICghaW50ZWxfZHBf
aXNfZWRwKGludGVsX2RwKSB8fA0KDQpUaGlzIGlzIHdyb25nLiBZb3UgcHJvYmFibHkgbWVhbnQN
CmludGVsX2RwX2lzX2VkcChpbnRlbF9kcClpbnRlbF9kcF9pc19lZHAoaW50ZWxfZHApLg0KDQo+
ICsJwqDCoMKgIGx0dHByX2NvdW50IDwgMCB8fA0KDQpObyBuZWVkIHRvIGNoZWNrIHRoaXMuIEl0
J3MgYWxyZWFkeSBzZXQgYXMgMCBpbiBzdGFydF9saW5rX3RyYWluIGlmIDwNCjAuDQoNCkJSLA0K
Sm91bmkgSMO2Z2FuZGVyDQoNCj4gKwnCoMKgwqAgaW50ZWxfZHAtPmx0dHByX2NvbW1vbl9jYXBz
WzBdIDw9IDB4MjApDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCXZhbCA9IGludGVsX2RwLT5sdHRw
cl9jb21tb25fY2Fwc1tEUF9QSFlfUkVQRUFURVJfQ05UIC0NCj4gKwkJCQkJwqANCj4gRFBfTFRf
VFVOQUJMRV9QSFlfUkVQRUFURVJfRklFTERfREFUQV9TVFJVQ1RVUkVfUkVWXTsNCj4gKwlkcm1f
ZHBfZHBjZF93cml0ZWIoJmludGVsX2RwLT5hdXgsIERQX1RPVEFMX0xUVFBSX0NOVCwgdmFsKTsN
Cj4gK30NCj4gKw0KPiDCoC8qKg0KPiDCoCAqIGludGVsX2RwX3N0YXJ0X2xpbmtfdHJhaW4gLSBz
dGFydCBsaW5rIHRyYWluaW5nDQo+IMKgICogQHN0YXRlOiBBdG9taWMgc3RhdGUNCj4gQEAgLTIz
MDQsNiArMjMyMyw4IEBAIHZvaWQgaW50ZWxfZHBfc3RhcnRfbGlua190cmFpbihzdHJ1Y3QNCj4g
aW50ZWxfYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4gwqANCj4gwqAJaW50ZWxfZHBfcHJlcGFyZV9s
aW5rX3RyYWluKGludGVsX2RwLCBjcnRjX3N0YXRlKTsNCj4gwqANCj4gKwlpbnRlbF9kcF91cGRh
dGVfbHR0cHJfY291bnQoaW50ZWxfZHAsIGx0dHByX2NvdW50KTsNCj4gKw0KPiDCoAlpZiAoaW50
ZWxfZHBfaXNfdWhicihjcnRjX3N0YXRlKSkNCj4gwqAJCXBhc3NlZCA9IGludGVsX2RwXzEyOGIx
MzJiX2xpbmtfdHJhaW4oaW50ZWxfZHAsDQo+IGNydGNfc3RhdGUsIGx0dHByX2NvdW50KTsNCj4g
wqAJZWxzZQ0KDQo=
