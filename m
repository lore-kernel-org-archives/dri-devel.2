Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBC606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dEhB5mqo;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=RnkH2Fl2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E1010FBF9;
	Wed, 18 Nov 2026 12:58:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D4110FBED;
 Wed, 18 Nov 2026 12:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795006650; x=1826542650;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hGFwzz+sLtbp3+RSeNn9meE8dmpms/URk0ngFoABFbU=;
 b=dEhB5mqoDQGozFPRr9SUiRlF+me8VtbbF6urv7r0+pUDiPN3SH/VlMf9
 F0Cu9vdeTMGJrt36ZrU/DC0kaYoa7iuaCwjJMqxiqTkgK7HyZMh6GFam7
 PcWGPqIFPJw12WgejOh0s7xcrymTRuXI3Q4+t9krDsPJP7EZpQ6BfUG5l
 g0Pva9EHVWyg2RnK1pwf1Hgtlyoc9mZKIMO4XdwX1USfo7yqzEozzNxQJ
 GZt+MEFg2jdjIcDAC5n6BRMB1qWJjjHUPJfl5l+tk2f7O/ouereclVzRX
 Rr/70AWcZ2A5OhPaa/sI+aH2jlihVeG3Ad+qWQSscobUZC+DjdD6wwxOD w==;
X-CSE-ConnectionGUID: CqskljltTHmh6u1sKI14SQ==
X-CSE-MsgGUID: PxNc2RxqT0yTMrCgctanWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3804957"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3804957"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:57:30 -0800
X-CSE-ConnectionGUID: N60k9OJRTtaqOULiFs9i/A==
X-CSE-MsgGUID: dR8hWgIlTzGKu3iAyTUUvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9927566"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 04:57:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:57:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 04:57:28 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 04:57:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH71H52zGY9X9/6FNK9aoihtmzCjS2NwifttZ+hB7N+I+WLhzPTfydqAnmts/KowQSenTI4g+aXciLLmYtxhwTkTv4/RgqMyVCFk8n30MZxnBjnTLlzvrBqLZB6bPf5uckVRsdTUkVZBzGnx8+aWcKbgLANVLAD63hlX8s4iASTXRiyrx1Px+QCxX6opJNxzLE8zbzXClfqgMHCfZW/NRXuCizeOCGTZ5gqobB3oq6JMNwulHId77L8b94sv9prlB0x4TE9o4OqsuvH2wXMi6hsMsZBA+atpwtJ4WlwJFYzFBXpioua8BdVd3zno8M5iW0DZM7EaVTfMlPAcMzhcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGFwzz+sLtbp3+RSeNn9meE8dmpms/URk0ngFoABFbU=;
 b=f2tgzpBQYbetX5JCL5GOwqoZrDJAtgD7Tw1Kkv8kVcObvrXJRVS/C9IjhWY424vwnA9eqdPMHaMiUw9i6CsgQOvN8z0YHZ6jQ1zQA9RuEhKz5wVF/KqG7eqD7FrsU9yyAMj6aqx8/jeiEdlb90v2fvJtSqLBhSO7C3AR1w0eTE5KMHTf4Pt71IZHzXtBMdajKX6dga9Jophe0P/oYNWWsC8AykClURIu8F7dDDGdbRUy7gQ4EPs/ii7Mrn/WUIHaStowo7MaUlCSH8tQ8bm43qJdj6DO2aAoUU6Ny+gqAHGMu+bCZfqf6EAEprJb0n8W8AiajfAnKkq1aPKPTofzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGFwzz+sLtbp3+RSeNn9meE8dmpms/URk0ngFoABFbU=;
 b=RnkH2Fl29SYYt1UV3DVq2wgVxV95MQ2RAct6+2RtgcoF78AlAO1LLNCGNakhqwMIV8TyJZDxiwAw9TilUnashufAhnnDltctmZQ36N2+2WkdzFgYABY+WDoYoThoSzqbpme2DO+beLB7qbF4C0eA1+SE6sFwyu+dgJvXhChVuOo=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by IA3PR11MB8896.namprd11.prod.outlook.com (2603:10b6:208:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:57:24 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:57:24 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 17/20] drm/i915/alpm: Disallow ALPM for UHBR link rate
Thread-Topic: [PATCH v7 17/20] drm/i915/alpm: Disallow ALPM for UHBR link rate
Thread-Index: AQHdZQyf2GFtwrRKcky7xTSk/VjsELcz7puA
Date: Wed, 18 Nov 2026 12:57:24 +0000
Message-ID: <17047cd21ec79faa9fefdde7c7c3b78a3e50cf4e.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-18-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-18-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|IA3PR11MB8896:EE_
x-ms-office365-filtering-correlation-id: de3860ae-ef78-4a94-1c7e-08df45737dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|10067099003|11063799006|56012099006|4143699003|261021121427099003|261021123027099003|261102123227099003|22082099003|261009223027099003|18002099003;
x-microsoft-antispam-message-info: UJHILsseqcFrHJMgaeSMsSkRimWd12Zf4jv4nrMxU1TtrhgD9fzeHPfspmna5LmuruWJUeTJpt+bNtNwG/F+NzWdhuMiHH6x0PSVOWTxfYH2AGBt33GA/81KBCSMeBAznhg8urHhBdjRlJ80RzmiyxwaF+PKLtKAajE5BQT6HfEB5qXxl5Gc6lPjvg77MAm8/1QZott2f60N7i6usjaiSWxcxkDYzUBTeeScIQnhAtCUm0odgseWB/QGLD3f14eMKlSHYR7igQAvGNWflSClbENfgDkb4ELrKgoI4VjA2UFAiN/XXKC6UCzHanmBBRsAzY6wFaeSNZsG5HZAT0fkqaOYBowy2nzBeoUxyvGeuqXfTRYckaKVa+mnUk2P6a/vLouHI3NKgVytpBX7b7XFOM6WLHP9l2y7csyKhuEK3MsJMkgfYqYVkKelpEp5aeo7mWSCd+icWXYEZq5oZVMRFKwpfNoKB5YFnxs/9UGOrpSodNfHQmHYC4t7T83NAlTW3qKQoy3ogEm0Lri73udNBf8HuPPNSyf8nhmMbd+YbX8X394HZVFM0iU/vPbDLGICIhAl2KgtztsXeVzhQt0h2Vh+2HRRqkZwXb8pCp5c1lNoVdURfIBf/xUMe/RJo6Bc2Y4Uz+1fhYbXPZGAIvkNcE+joSP0C9NPXWxyVxV9yL+UPxesk1agR/Yqjb7WeLp4cd7inxrQwnwv3xU8MAgABP1sNLEyGNIlHhDkN4VDxCc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261021123027099003)(261102123227099003)(22082099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVNObmJFZGNkRG00U0ZocjhzSCs4TXJtbFJaTzdPZytQVVptaW8wek5IckMw?=
 =?utf-8?B?UGVvaTFnRk9RVnFTSmJYWUZLb1NZRHd5TGRzZTVxa2w4K0hGSk9xckxRaWJs?=
 =?utf-8?B?TlNyaXk0UzU0RWF4L2hiaG13dVlHeWM5Uy9lSkdYdmxJNTVUSm94b2tMUHh1?=
 =?utf-8?B?MkZzT2x3ZlM4S0VLOFRUV0NyY3hYVnZ1bUY0cXV2RHRzUkUyNXdVdmRNZ3do?=
 =?utf-8?B?MXcwaHNzcllLVFByR0JCOGpTYnFXNDVlM2QxUHRwN1hMaEorM2tQOUxHTjV1?=
 =?utf-8?B?SkZuQVZVZExiY0I1eGxybVNpeHhrTFRYa25RendlZm5WcW9FbE8rVmV6bjVk?=
 =?utf-8?B?ejhlbktFbSttRGVxRy96WVlUanVLOG5FRzlRZGxsdHFBSENDOHNrbjFjYXZl?=
 =?utf-8?B?OXIxQjZsdU9jRGVaU0Q1ZzE2T2RLdkhMSTZ0bW10ZER2TmptTExyK2l4ZFpy?=
 =?utf-8?B?QjJaWVdSSmdRQTVVcUp2TEdSOFBzME5VSHdlQmtKUVNhdGZnUldtcXBRZ0M0?=
 =?utf-8?B?eGFOQ3FoeCtFMVRKdUt6NUZmVlREWWlEMisyY0hIMVpUa09kUGdIMzEyK3BM?=
 =?utf-8?B?Q0VrOFdydUplZVA5Mm5pQ1ZUdHo4aks5WWg4WDBwaTNFL2hpN2lUMmpkS3ph?=
 =?utf-8?B?ZnY1cW84V2toTDkyVTQ2UGJlT2Vjb2VmZWtLejZPT3VKWm9lQzJkWklPMm5p?=
 =?utf-8?B?QVk2aGp2VXZ1SXZtOXZWTlVCekUxck5iWGdJa0pFY3JZZ05pektDZ3VUQXZF?=
 =?utf-8?B?Y0tkcXFPNFlLOFNuZ0ZUQlpRM0c5ckNhWnIrVlBKTjVSZGVYS0xrRlRCaTFU?=
 =?utf-8?B?MGh3c3RaN0svWXl4NzRLK0s2QXc0TVpNWG9NQTZEbkgyMWdUQVU1c0Y2T2tv?=
 =?utf-8?B?ekszSFFhaHpTWDdhNlVzUDh4eENvNVdmckhVeC9TUE02anZ3TnBxOFVUYXE3?=
 =?utf-8?B?U2RWQ2FvekRTWVgwdGVWYmFZa3FEMDVLa3FRQWhZTFhXYW1VQUlpVVA1dUhj?=
 =?utf-8?B?eXhBamd5d3Nkd1dSSkhxcDlLdkE0eDMvaktiRnVoSzN1NndBTmp0bmJOdnEy?=
 =?utf-8?B?d0plWUlBQWc0Yy96RDNlRXpNb2tSWEVQY2RKUktaZUg2eDJDVDNiTWFYdWdq?=
 =?utf-8?B?MXNybTgwdUZhblVxQ2s5Q2FLVi9jOWJpM1JWeStBaVh0K0NPU1VRQThJMmcr?=
 =?utf-8?B?YUpPUXQwZTVZeGdYNDFLdk82Y28wQ1lBMGJvRzB3LzJnZHBTYURBczJpQ2JM?=
 =?utf-8?B?Mlh3cXczOHMyK0NjOUpnaHowRmZSRWZLK2xNZVM5M2VSMms2bjNyMHlibWxn?=
 =?utf-8?B?Q0xvZVhWUXVXemxSUkNHRnExRWZrZktCOUgxaUgzL2ljdFkrUUVzVkF2VE9k?=
 =?utf-8?B?L01jUEN5eHY1dVFjbnBESS84Z0Y1bVh5cllQUzJUZEhRM29YWnp6Y1ArdlJS?=
 =?utf-8?B?T2hMNEM3Vis0NkJmcFhOTW9VTHZibXVXbVl0QWdvTjE0c21pUHFoS3c2Wm82?=
 =?utf-8?B?SU5KYUk0NGlpc3dReWhDRU9keHBZU0xXQmc4SC90dHY2ZmMvRk1IdmxiOUlt?=
 =?utf-8?B?OVF0RlZ6K24xTVlWSjRtbFZWTCtyUWwrQjA0UnVWeXJ1OStGencxUXluR2tw?=
 =?utf-8?B?WjRVUDhrdkRMUjcra3RvdkhYekIvNjRJS3ZlTjJNc0tLT3lUMjFoWlUxQkc5?=
 =?utf-8?B?SlNlZEhlL3Y3cjFBRFhaZjVKODd4clA5dGZ6WVY0YVdvRCsyMGhzYTFSSU9v?=
 =?utf-8?B?VlI1Mm1xM01CYXo1Smg0U255d0lDcEhhRmxxUTYzMVJIU0d1THZ4dlBHSng2?=
 =?utf-8?B?UUxST1JEdWVXK25vQmhOQzhQaXo4dmw4RTFpbkxzL1loQ0M1WFBhdkhxZDJt?=
 =?utf-8?B?eWk5cGhuZGxXZXZzYmhlK0hYM0ExTktoLzFCY2EySlBMSEErSk1TZnNncnhF?=
 =?utf-8?B?bVdRdFRxczhiNVpQTk80VklqTnljWWtOR2RKcHhCdjVNT2dxam5HZlhZd1g1?=
 =?utf-8?B?RkNIUlJOMmlmZ0YrcVRuUGRENlNGSUI4UHZkMmVrbCtpRFVNeG96UDl5QVRi?=
 =?utf-8?B?bnpvdW1sK09pem53SjBpT1lYWjc2cDRmT3JmMXNYN3I1emMyUld5dGVnYVNq?=
 =?utf-8?B?eEpWNitQYXFJd0sxSkFBOHhBS3B4ZXpOSkFldi8vbWpiN0ljK2hySmxQQk1l?=
 =?utf-8?B?c2xacW1nZk1RRTdNQy9IeHp6S3V0d0lOOUhZRG8zQi9IajV1Rkg5N29PZVVB?=
 =?utf-8?B?V1NrZHd6L3pxYUZTSllXNktINkxqS3NhenAzWFBndWNGaUhVRFFRZXoxK3hl?=
 =?utf-8?B?SmhiZzUzUEdXeWhVSE1ML2RrUmp5UVBkRm5yT0pIdWV5d2Q4MStRWkFXSmpm?=
 =?utf-8?Q?4e8hl5WpfrYycPug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6B20F6696A3A145B140CEA6F3510A76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aw5zmtAD0+lR+yKrZwKBGDRY3j8AnAbgI5rXiSfHCPTg35HoyJ9B1PFeH/mmbYdZ9taUjyhj7AJk8pvNS7BflPFokY6HmRzeWsw02Za/F1O2NTvSYMmHlMzHyy39h0HjTylIOvBz1a5IEaAUdiowuFoD5GjqaG25Nv8pjcnN1hrnkqIgOUlSS+wN37DbxBEpHg0zjA+6JEbGkzDEzCZ69/DaoLZQyy1UWFa1RX9pWCeDE/PX191zUbf0w4s2lpdxWVzonU4YoKvkNqWKB5TfUHZumAZZMTqjnlTQSfhwZoekUiFlq3COEasYiASLzl4KTBv+9SXraIJj9xu1BPW9hw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3860ae-ef78-4a94-1c7e-08df45737dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 12:57:24.5391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: se/X8tbCEilNu2D9dcScWPtuWcnR7B/aacjhWRhqiqUj5SfbcLTa3+Qh5nZZTT8ylVtSY0RJVfOvuFFd9sFii3cO/E8QdduiWE5CVs63e9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8896
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

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDExOjA5ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBEUDIuMSBBTFBNIGlzIG5vdCBzdXBwb3J0ZWQgb24gVUhCUiAoMTI4Yi8xMzJiKSBsaW5rIHJh
dGVzIG9uIHRoZSBOVkwNCj4gcGxhdGZvcm0uIFJlcG9ydCBBTFBNIGFzIG5vdCBwb3NzaWJsZSBp
biBpbnRlbF9hbHBtX2lzX3Bvc3NpYmxlKCkgZm9yDQo+IGV4dGVybmFsIERQIHJ1bm5pbmcgYXQg
YSBVSEJSIHJhdGUgb24gZGlzcGxheSB2ZXJzaW9uIDM1LCBzbyB0aGF0DQo+IEFMUE0NCj4gYW5k
IHRoZSBmZWF0dXJlcyByZWx5aW5nIG9uIGl0IGFyZSBub3QgZW5hYmxlZCBpbiB0aGF0IGNhc2Uu
IGVEUCBpcw0KPiBleGNsdWRlZCBzbyBlRFAgQUxQTSBrZWVwcyB3b3JraW5nIGF0IGFueSBsaW5r
IHJhdGUuDQo+IA0KPiB2MjoNCj4gLSBNb3ZlIHRoZSBjaGVjayBpbnRvIGludGVsX2FscG1faXNf
cG9zc2libGUoKS4gW0pvdW5pXQ0KPiANCj4gQ2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9n
YW5kZXJAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmltZXNoIE1hbm5hIDxhbmltZXNo
Lm1hbm5hQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmku
aG9nYW5kZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNw
bGF5L2ludGVsX2FscG0uYyB8IDExICsrKysrKysrKy0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5
MTUvZGlzcGxheS9pbnRlbF9hbHBtLmggfMKgIDMgKystDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gaW5kZXggMjA1ZjFhZTEwZDQzLi4zMTIzMjk2
ZGY2YjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
YWxwbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5j
DQo+IEBAIC03NiwxMyArNzYsMjAgQEAgdm9pZCBpbnRlbF9hbHBtX2luaXQoc3RydWN0IGludGVs
X2RwICppbnRlbF9kcCkNCj4gwqAJbXV0ZXhfaW5pdCgmaW50ZWxfZHAtPmFscG0ubG9jayk7DQo+
IMKgfQ0KPiDCoA0KPiAtYm9vbCBpbnRlbF9hbHBtX2lzX3Bvc3NpYmxlKHN0cnVjdCBpbnRlbF9k
cCAqaW50ZWxfZHApDQo+ICtib29sIGludGVsX2FscG1faXNfcG9zc2libGUoc3RydWN0IGludGVs
X2RwICppbnRlbF9kcCwNCj4gKwkJCcKgwqDCoCBjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0
ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4gwqB7DQo+ICsJc3RydWN0IGludGVsX2Rpc3BsYXkgKmRpc3Bs
YXkgPSB0b19pbnRlbF9kaXNwbGF5KGludGVsX2RwKTsNCj4gwqAJdTggbHR0cHJfYWxwbV9jYXBz
Ow0KPiDCoA0KPiDCoAlpZiAoIShpbnRlbF9kcC0+YWxwbV9kcGNkICYgKERQX0FMUE1fQ0FQIHwN
Cj4gRFBfQUxQTV9BVVhfTEVTU19DQVApKSkNCj4gwqAJCXJldHVybiBmYWxzZTsNCj4gwqANCj4g
KwkvKiBEUDIuMSBBTFBNIGlzIG5vdCBzdXBwb3J0ZWQgb24gVUhCUiAoMTI4Yi8xMzJiKSBsaW5r
DQo+IHJhdGVzIG9uIE5WTC4gKi8NCj4gKwlpZiAoRElTUExBWV9WRVIoZGlzcGxheSkgPT0gMzUg
JiYgIWludGVsX2RwX2lzX2VkcChpbnRlbF9kcCkNCj4gJiYNCj4gKwnCoMKgwqAgaW50ZWxfZHBf
aXNfdWhicihjcnRjX3N0YXRlKSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+IMKgCWlmIChk
cm1fZHBfbHR0cHJfY291bnQoaW50ZWxfZHAtPmx0dHByX2NvbW1vbl9jYXBzKSA8PSAwKQ0KPiDC
oAkJcmV0dXJuIHRydWU7DQo+IMKgDQo+IEBAIC01NTYsNyArNTYzLDcgQEAgdm9pZCBpbnRlbF9h
bHBtX2xvYmZfY29tcHV0ZV9jb25maWcoc3RydWN0DQo+IGludGVsX2RwICppbnRlbF9kcCwNCj4g
wqAJaWYgKGludGVsX2RwLT5hbHBtLnNpbmtfYWxwbV9lcnJvcikNCj4gwqAJCXJldHVybjsNCj4g
wqANCj4gLQlpZiAoIWludGVsX2FscG1faXNfcG9zc2libGUoaW50ZWxfZHApKQ0KPiArCWlmICgh
aW50ZWxfYWxwbV9pc19wb3NzaWJsZShpbnRlbF9kcCwgY3J0Y19zdGF0ZSkpDQo+IMKgCQlyZXR1
cm47DQo+IMKgDQo+IMKgCWlmIChESVNQTEFZX1ZFUihkaXNwbGF5KSA8IDIwKQ0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmgNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uaA0KPiBpbmRleCA5MzE5NTcyYzIy
MWUuLjI0YzMxOWJjNWVmZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9hbHBtLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9hbHBtLmgNCj4gQEAgLTE3LDcgKzE3LDggQEAgc3RydWN0IGludGVsX2NydGM7DQo+IMKg
DQo+IMKgaW50IGludGVsX2FscG1faW5pdF9kcGNkKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAp
Ow0KPiDCoHZvaWQgaW50ZWxfYWxwbV9pbml0KHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApOw0K
PiAtYm9vbCBpbnRlbF9hbHBtX2lzX3Bvc3NpYmxlKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHAp
Ow0KPiArYm9vbCBpbnRlbF9hbHBtX2lzX3Bvc3NpYmxlKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxf
ZHAsDQo+ICsJCQnCoMKgwqAgY29uc3Qgc3RydWN0IGludGVsX2NydGNfc3RhdGUNCj4gKmNydGNf
c3RhdGUpOw0KPiDCoGJvb2wgaW50ZWxfYWxwbV9jb21wdXRlX3BhcmFtcyhzdHJ1Y3QgaW50ZWxf
ZHAgKmludGVsX2RwLA0KPiDCoAkJCcKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0
ZSAqY3J0Y19zdGF0ZSk7DQo+IMKgdm9pZCBpbnRlbF9hbHBtX2xvYmZfY29tcHV0ZV9jb25maWco
c3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCg==
