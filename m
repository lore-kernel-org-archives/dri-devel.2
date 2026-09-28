Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4312C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB0310E4E1;
	Mon, 28 Sep 2026 10:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d1CgbEIX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5113510E4E1;
 Mon, 28 Sep 2026 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790589774; x=1822125774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iFAYymRGm19PKHXyEKbCgeANaWaqZWnFba+UUDWUzrQ=;
 b=d1CgbEIX/kKD1Qy5zSKCvEfJgr5+MlNwbKqZybpYqeqqd0x3F6PeBNQT
 blM1kZ+vFwOfgWKMaTdcIXEKOaUfy2SrusraqMuHYEfo/k3D3q9Cg64ww
 sklDl0mjRMhcrz59mDlmrmuSfDROagKXs3lbVMJADotrbgO2fyq/0v+HR
 v3PZe//skBdaoQW+TMTzJNtfZz976bJOn9DcTGDFDqV7dlQ+6nNp6Obz9
 UANwqMqCtb5iXP2RRDJM2k0tpIbWrx9Kp0tWVf4pBrtMEkXJd6x9Le2DL
 SritLcLfG9nk6Deaes5ezxd2TYK7QvRpBfDAwl0sMCv0kkrB3ILOIk8tM A==;
X-CSE-ConnectionGUID: mjLp7WNvSMWqRrCj7ibXlw==
X-CSE-MsgGUID: zY2OUTRIQOKxpoRXV4pRRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="108773593"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="108773593"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:02:54 -0700
X-CSE-ConnectionGUID: 2qkV1s+LRa+NNtCwCQaURg==
X-CSE-MsgGUID: uPqaIBLIRKuBoJafDqEWdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="274522192"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:02:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:02:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:02:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD4y4gh4ikAuBPtAHjZouC0rOJhxmm9s7fm76zMenCvGpyK4bLHw2N0WJa9ou1Y3E/IwmALhUlQGEMD0tU7L7HtVP2O1kr0pkeMhq4v5XOp+kTCak+F4bJ6/Xi+5Wk/pObLUAReG9MWWljQFv1iGHuSupN7Y1wbDr/pS6aZvjiTlfvCmVqev4psAOpId71FtSLuHT3NqsETquybjpuFbA2dt7I6J9/IjzTS5e2YYertQglnl6ITIaFQ0PTxovMfFlN1KqnsyIqY+tMvXQSq9jnwdUtWaFrMdTj4BNESiFBoz8XIZ2aXr33ieeJtvn0gn3Jj4hfFsHunNxf3wG29oOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFAYymRGm19PKHXyEKbCgeANaWaqZWnFba+UUDWUzrQ=;
 b=T/u2Qcp43jZdyxMXvxIyVU9o1eenbvBs1LwARFNd1Ofswfu9SEfn69LNKndrXW6c1LF4NldUUhFihdDEdyC+nvuoDMeiVls/rNDTtV79WmuU8teMV1XusO/xqDk1pUzaPPOUXkJHjdVpTGBIYY05gzURv438DbDaY1Ezsfz53Ljxg6iBgjx+MRSMsfCG9R+8SjOQo0htYxCqdO5Mi9q9V72IrTaMeP2TMSB13xXt60tCk5l0YJqp7sz3iAwQ2u3Frqfrnzi3/8pQGz/bqH2HscfIerQvdk0r8PtzhZMQ8pq1Kx0XlVN17eR1xpcExKaj1chpcOQiYhpdmcelVVxYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CHAPR11MB9631.namprd11.prod.outlook.com (2603:10b6:610:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:02:49 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:02:49 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 02/18] drm/i915/alpm: Move alpm sink capability readout
 into a separate function
Thread-Topic: [PATCH v6 02/18] drm/i915/alpm: Move alpm sink capability
 readout into a separate function
Thread-Index: AQHdRUGFXVXfGy64UkS81TVA42Hu1rbj1TiAgAABS4A=
Date: Mon, 28 Sep 2026 10:02:49 +0000
Message-ID: <7fd6b17c2e096ce7c0367fcfd43cbdc86c16db53.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-3-animesh.manna@intel.com>
 <befabf4be95ed6e5d62aa77a89a8689134d7d64c.camel@intel.com>
In-Reply-To: <befabf4be95ed6e5d62aa77a89a8689134d7d64c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CHAPR11MB9631:EE_
x-ms-office365-filtering-correlation-id: 1a65596e-5e71-4da6-4ac4-08df1d47a722
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: rual4iMagtvwGgL+GlY0+TCM0F1DWTnFHRJ5HUcXe+6SgR6AP29rDIa/t3+RIwe6V9xxQ7peFoIgzSJpK1e1LmQyZgC7waozEOoJ+GNZ242iPMDM1ZCxMyxpxqZ7oXNWhHfigSaCeB+YyKWowmfazmWI1k0xymeKVM06ihfV8Ru6APC5ckKyBAxy+ZQiDMldzPKhpYSnPHSIw64OVf4geaSGl+izsKM1esmnspLEKRKJ3qhkx2B6bRpBJPaVoJPbcvNVce+L6DiSIozzBIcyR+K9NhmGBLQGJPnE1sE3G4vEaFatQdPmsbDfuXMeO7EQ01dmOpDblLXDNqvGbMFwOkK/EkCIO2I3Z/TAQsQH46qSyCUnWspsnPpBtIqBLGVIJf+C0a3k9po1KD5kU3r64s8MsAIMGzvFxr54TzksIxSAsR3SVsyTuX0pB9jP26dC8wKFY4RlO32qQ5NXXKJEdd3Wl2Z+uPJpN7ljZlXBE0HrZE1pQohUKAjtzX0gJ4H6dnoeKzQMKg+U70Whohm5giTGPretggdl44oyt5COD+RfExWDG4xX7YMPSBAaATJs147NNT2XfqBYWKEdI785sB/VIMezG+iGN/afaG7Y8p/k13kloNy4AkBxMbiva8hvc7G3IT68XCGbrdA8NnD4+l+m2hsGduI+3ZiyzOa+pmINYW8NW2lvAeRcPTGICdHUIl0Mvs5bfou3WTzPHw+KNeytK6bBxmkE9v+PvWNS0sQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkI0WkZoeTljSWpjdGlqMlVlU000MzdZOWFlTDFweVRGNUJ3SG5IelkxM255?=
 =?utf-8?B?RUhxL05KcWJLQXVhbjYxcUFYUHVpU0RGbUdtNXJQcEZPYlB6ekhUWkxpbE1J?=
 =?utf-8?B?VkZrOVRERHYzUUpWOThBckFHSCt6dkVDNWprRVMzMVFJdi9zRmJibm9QeGxz?=
 =?utf-8?B?U1M3b3FHNDFVOVN3OU52dGJocGRnSkxqWTRUT0JvdXhJamZLak1rLzZKeXRl?=
 =?utf-8?B?b25wN3hqdnpGdUg1NjVBcjU1R2xOVnZDK2hiUFU1K2dMb2VuL0Ztc1hXODQ4?=
 =?utf-8?B?VlNZU1hucFFHQ215QTJFZVl0bGlWaEpyNEpBbGVHM0x6Rk5XOTVPcWNXbTZ3?=
 =?utf-8?B?clRoVWU4d2ZkT21mb3FJRDhOK0Y5NGlEa284Y0RVMVVVNXozTkdRS2tPUll4?=
 =?utf-8?B?WWx4VjR4U1NZeDVWSW9pQkYycDhPMXl6b1gwRDFnb2xhcmdZQXNDSXpLV29k?=
 =?utf-8?B?WlpHTjliZnlWRUZDNzZ3dEE3b2VzKzZETGFpZmw1L2pybG1VbFF0S0pmTWVk?=
 =?utf-8?B?Tkk2bC9FdGdCT1VaRWRJWkp6WEErM2RGMVhyK3cyZFNBeFNrVk5yME52Yits?=
 =?utf-8?B?Q0kya21GZ3hCTUlHSzRyTW1Cek9tdCtnUlV3YXNRTENrL2tMbERZcHBEWnZJ?=
 =?utf-8?B?VE8yTmNCRUdaTXBiUkZvbTlDblZHaGNORnV3VU9JNHRIVkxZRmxJMUFYMlhW?=
 =?utf-8?B?QWVNa0ZBeWFsdUVWUUZyL3pWUDFWNU5wcmJWK3dIdVgwZERzcDVQQURpN25D?=
 =?utf-8?B?aisrYjN6Qmk5WWRmZjY5cFBsODZ6aFltYi9mWVYwU3lhbGxQbjVpQkhadHpu?=
 =?utf-8?B?T1p5Tk8vd1VNQ2NrWkRrN0w4OElMdGthbFZ2YXRNdkJVVVBxdTFZWTh4bEt4?=
 =?utf-8?B?ZGVFSU5QQkFCMjlpUEFzUDFZUm1MR1RiWk5DeHJXM3hFbVUxSUd6N1NlQjBh?=
 =?utf-8?B?N1NITVgySkl2RUhucytLVFFGb1hocGFUSlFPSWVUM3FlcE9XQlNwMmZVWTNR?=
 =?utf-8?B?cUZJanJnVlpkL0dwaVM4ZXhLUjE4NGlkSFBOSkhBdHdobmJuWjcwaWFCVWFu?=
 =?utf-8?B?VG5IUWM5ZmIyK0Y5WGYvMkhoV29hQXBINkpMODA1aFdlWXZMTEh6NDJsSXVq?=
 =?utf-8?B?dFpFODNOUWg4d3Jaa3k3TS9rbDVsbUV3MHFMS0svZjR3NmR5V3Y3YTRSSFl4?=
 =?utf-8?B?QkszcHM3OURwa1pMKzlrLzhqa3k4YjFVTXVHVGNUU0JWNzJaQ1R6VjVVaHIz?=
 =?utf-8?B?UHE1YXlza21HaDBSbnZuWkFSb0RJaHhFa1FUYTdRdHBSd3lPM0t2NktyN2Z5?=
 =?utf-8?B?M3V1dlhCVVIyM1JYa0pVa3RkNm9Xamtnb3g2c1FrTVo4dU9xeGE4Rzc5bmR5?=
 =?utf-8?B?QzhOaXB3SVVRTFh6YXpQb3ByQk1UbTMyVk14TDVScW9WMENxYm5uejMrb2FV?=
 =?utf-8?B?cHdwTFJ1K3ZBb0JMYlhLS0pNeG1nYXlvdi9iblB4Z1E2WnhPb0lsMWoyL0w1?=
 =?utf-8?B?Q1ZiTWlHTkpuZ0JBVmdtYlgvYUdzSGUvQWVINVUyeGZBYWJiTno5TXBJVUxh?=
 =?utf-8?B?ZXd0Qk5wVjEwMnVXNTd2ZTdjUU5ISTIvVWFGRUhHdHNWVHZ3SDlkeFhPcEg5?=
 =?utf-8?B?MWlaa01lMGRoUG12ajJ5OE5XQzN4a2lIWGNhb0x0WXZWTzJySG42U1k3WHhQ?=
 =?utf-8?B?WGRWZGRrM1k0MFVlQ2lSem94Sjh0SUZCR3FaZVphczN4bFRrcVphNE1RcHd0?=
 =?utf-8?B?dmgwenI2aUQ5dll1Q2RRUDRVMk1qbVRzN2VaeVJtM3RpRWNPbzJ2U2cvNEVE?=
 =?utf-8?B?QXVweEhuNXk4WkUrdGpvT0l2aWtETnJYbzdSVUxQV1p1MmlzUHVLY3hXNmxz?=
 =?utf-8?B?SWdPaHBkaXBYSDdFY3JKejJseUMrNkxabXNuQ2RHOGxqdkN6TC9lMlpydERH?=
 =?utf-8?B?NUhzUktNR21nTmp5a3lpbFM0VlVKMjhPQjlXMlBPaHFqeUFOT0h6bUhLdXJU?=
 =?utf-8?B?bFloS0wrOGFvcDlHZG5TMmcrQ1RSMi9wcng0aHJIN1hFckVZOTZIYkh4Sjk0?=
 =?utf-8?B?SjRTd3NBSldZb1JLMDdyOUZPVDBmY2JkcGNYS243WmdES3p0M2N3bnhYalBV?=
 =?utf-8?B?ZGZHSllrdTRKT01MODc5MG1WMER5NGZzL1dQTlNyYXBhTjQyd280WUc0b1Fa?=
 =?utf-8?B?VHZ5UkRFWDZpTjJ5L3BCZHNjYnpiK3F6cC9LQk0zYVpnSEFyU3JNcTBMQUNB?=
 =?utf-8?B?MllKV284UVBCbENsUlR4MnFFZ2IzYUJVWE1uczVzK0ZnTXFYTG9ZajZ4aW10?=
 =?utf-8?B?bldIaGxNVVB3QzZteEpOMjFLdTE1QS9vM2kzZW41czBMMW9ZWnkvaWw2SjJN?=
 =?utf-8?Q?G74h3KkpsD0/YxJc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACA625037D1E534AA20370A38358330C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k9cz9FNMOFBSHcD2gAVjtOEc5Oln08npE6FsUwvWCDgr3inFbsr27pUH+ETf6ZB00XxP9/6PXfoOEo1mGVL9x6V6G63yMyvVaRJaTSkErdWdorFhV/OUaiQKI2MFJ3VGdzVkiz8TbgYhGCZOuTuD3C5rLkXO9crr5PiHpGyi/U1nq7T7jfiS9/IIlfPFpeY3sNo0FVVvX+oL/I8h9+rY87fAGvyYOyM6zzxgXQ3JH4u6FWZFmic5Gfn86ikw69XJU4sCLP1AuE3KYX6UVFeMJDEBXmnurL4WllRSaZdzRK1/BBim8F0pJbw7XNyS+WmL5D4Ai83Tho1BDPaek/zKxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a65596e-5e71-4da6-4ac4-08df1d47a722
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 10:02:49.3515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wl9DfT5kk1MBD9AM71NSV+9yKg0XO8yubMWwiOjUTmwvupYOg0RXXvc2TvVBdD69Opm6x6CLuDRrnUyLiquAG4RklF+kEQNJnDzd0wX8cQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9631
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

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDEyOjU4ICswMzAwLCBIb2dhbmRlciwgSm91bmkgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyNi0wOS0xNSBhdCAyMzozNCArMDUzMCwgQW5pbWVzaCBNYW5uYSB3cm90
ZToNCj4gPiBBYnN0cmFjdCBBTFBNIERQQ0QgaW5pdGlhbGl6YXRpb24gaW50byBpdHMgb3duIGZ1
bmN0aW9uLg0KPiA+IA0KPiA+IHYyOg0KPiA+IC0gSW1wcm92ZSBjb21taXQgZGVzY3JpcHRpb24u
IFtTdXJhaiwgSm91bmldDQoNClNtYWxsIG5vdGUgaGVyZS4gSXQgaXMgbm90IGp1c3QgY29tbWl0
IGRlc2NyaXB0aW9uIHRoYXQgY2hhbmdlZC4gQWxzbw0KZXJyb3IgdmFsdWUgb2YgaW50ZWxfYWxw
bV9pbml0X2RwY2QgaXMgaGFuZGxlZCBhbmQgdGhlcmUgaXMgZWFybHkgZXhpdA0KaW4gaW50ZWxf
ZWRwX2luaXRfZHBjZC4NCg0KQlIsDQpKb3VuaSBIw7ZnYW5kZXINCj4gPiANCj4gPiBDYzogSm91
bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IA0KPiBSZXZpZXdl
ZC1ieTogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IA0KPiA+
IC0tLQ0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMgfCAx
MSArKysrKysrKysrKw0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9h
bHBtLmggfMKgIDEgKw0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9k
cC5jwqDCoCB8wqAgNiArLS0tLS0NCj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ID4gaW5kZXggMTA5NDM1MzliYzdjLi5hNjc0M2ZlNjJk
NDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9h
bHBtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0u
Yw0KPiA+IEBAIC00Myw2ICs0MywxNyBAQCBib29sIGludGVsX2FscG1faXNfYWxwbV9hdXhfbGVz
cyhzdHJ1Y3QgaW50ZWxfZHANCj4gPiAqaW50ZWxfZHAsDQo+ID4gwqAJCShjcnRjX3N0YXRlLT5o
YXNfbG9iZiAmJg0KPiA+IGludGVsX2FscG1fYXV4X2xlc3Nfd2FrZV9zdXBwb3J0ZWQoaW50ZWxf
ZHApKTsNCj4gPiDCoH0NCj4gPiDCoA0KPiA+ICtib29sIGludGVsX2FscG1faW5pdF9kcGNkKHN0
cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApDQo+ID4gK3sNCj4gPiArCXU4IGRwY2Q7DQo+ID4gKw0K
PiA+ICsJaWYgKGRybV9kcF9kcGNkX3JlYWRfYnl0ZSgmaW50ZWxfZHAtPmF1eCwNCj4gPiBEUF9S
RUNFSVZFUl9BTFBNX0NBUCwgJmRwY2QpIDwgMCkNCj4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4g
Kw0KPiA+ICsJaW50ZWxfZHAtPmFscG1fZHBjZCA9IGRwY2Q7DQo+ID4gKwlyZXR1cm4gdHJ1ZTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiDCoHZvaWQgaW50ZWxfYWxwbV9pbml0KHN0cnVjdCBpbnRlbF9k
cCAqaW50ZWxfZHApDQo+ID4gwqB7DQo+ID4gwqAJbXV0ZXhfaW5pdCgmaW50ZWxfZHAtPmFscG0u
bG9jayk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0u
aA0KPiA+IGluZGV4IGY4ZjYwNWQ5NGY5Ni4uNTZjM2UxNDgyZTM3IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5oDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgNCj4gPiBAQCAtMTUsNiArMTUs
NyBAQCBzdHJ1Y3QgaW50ZWxfY29ubmVjdG9yOw0KPiA+IMKgc3RydWN0IGludGVsX2F0b21pY19z
dGF0ZTsNCj4gPiDCoHN0cnVjdCBpbnRlbF9jcnRjOw0KPiA+IMKgDQo+ID4gK2Jvb2wgaW50ZWxf
YWxwbV9pbml0X2RwY2Qoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCk7DQo+ID4gwqB2b2lkIGlu
dGVsX2FscG1faW5pdChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKTsNCj4gPiDCoGJvb2wgaW50
ZWxfYWxwbV9jb21wdXRlX3BhcmFtcyhzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwLA0KPiA+IMKg
CQkJwqDCoMKgwqDCoMKgIHN0cnVjdCBpbnRlbF9jcnRjX3N0YXRlDQo+ID4gKmNydGNfc3RhdGUp
Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rw
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiA+IGlu
ZGV4IDBjZDVlNmI1MDM0Yy4uNjUwYzhiMzkyNzBiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiA+IEBAIC00NzgzLDcgKzQ3ODMsNiBAQCBzdGF0
aWMgYm9vbA0KPiA+IMKgaW50ZWxfZWRwX2luaXRfZHBjZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVs
X2RwLCBzdHJ1Y3QNCj4gPiBpbnRlbF9jb25uZWN0b3IgKmNvbm5lY3RvcikNCj4gPiDCoHsNCj4g
PiDCoAlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9DQo+ID4gdG9faW50ZWxfZGlzcGxh
eShpbnRlbF9kcCk7DQo+ID4gLQlpbnQgcmV0Ow0KPiA+IMKgCXU4IGRwcng7DQo+ID4gwqANCj4g
PiDCoAkvKiB0aGlzIGZ1bmN0aW9uIGlzIG1lYW50IHRvIGJlIGNhbGxlZCBvbmx5IG9uY2UgKi8N
Cj4gPiBAQCAtNDgyOSwxMCArNDgyOCw3IEBAIGludGVsX2VkcF9pbml0X2RwY2Qoc3RydWN0IGlu
dGVsX2RwDQo+ID4gKmludGVsX2RwLA0KPiA+IHN0cnVjdCBpbnRlbF9jb25uZWN0b3IgKmNvbm5l
Y3Rvcg0KPiA+IMKgCSAqLw0KPiA+IMKgCWludGVsX2RwX2luaXRfc291cmNlX291aShpbnRlbF9k
cCk7DQo+ID4gwqANCj4gPiAtCS8qIFJlYWQgdGhlIEFMUE0gRFBDRCBjYXBzICovDQo+ID4gLQly
ZXQgPSBkcm1fZHBfZHBjZF9yZWFkX2J5dGUoJmludGVsX2RwLT5hdXgsDQo+ID4gRFBfUkVDRUlW
RVJfQUxQTV9DQVAsDQo+ID4gLQkJCQnCoMKgwqAgJmludGVsX2RwLT5hbHBtX2RwY2QpOw0KPiA+
IC0JaWYgKHJldCA8IDApDQo+ID4gKwlpZiAoIWludGVsX2FscG1faW5pdF9kcGNkKGludGVsX2Rw
KSkNCj4gPiDCoAkJcmV0dXJuIGZhbHNlOw0KPiA+IMKgDQo+ID4gwqAJLyoNCj4gDQoNCg==
