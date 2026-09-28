Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039C2CA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5765610EA37;
	Mon, 28 Sep 2026 11:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AFUD5gfW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302F310EA33;
 Mon, 28 Sep 2026 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790596197; x=1822132197;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Sx3X/D38SeffqmHlWr2FQaz7HZ197n+k4/w09Jyfsug=;
 b=AFUD5gfWlG3NHpbTlXJrlfkSuiuzNKVOTPB/MNuwa8fix2qQl5kiNqgd
 /2ugdcKdNwCBuE5LoyzG0FsAtnb3IoWyiNz0Rl1bkvLA0BQYEBXja5Ozy
 kRfqxiitaD4+1kRGKLkLFHArPmOyCjTSbUB8Jbkl/0Xri41h2LoiON19r
 6HyExc4d+R/HZqPJXYfpJWuuJ9RNAbAKN5M69PlvyyzmPoxaDW22ccoYp
 tyPRUIVhbcVqjZjCR24m5Jn8uiMATSE68YJE1GX6CtSmrnuPKyDOZ58w8
 Dl8kUnBqavs0fbk2hiZUZ1Yfh6YxLdHvO4dfy224VwVDx9mkJLJMX6N5S w==;
X-CSE-ConnectionGUID: YMunZ+OcSC6MEz6P2WEieg==
X-CSE-MsgGUID: SNutICXbRC+XAIAu/qdotg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90197105"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90197105"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 04:49:56 -0700
X-CSE-ConnectionGUID: /8LOpSqJSnKVj4wuTfZWtQ==
X-CSE-MsgGUID: jltCGwwfSA6D6a3MIAGVlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="283107567"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 04:49:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 04:49:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 04:49:56 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 04:49:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDsG4Vy0FS9w+1cA7+jp83CLrxEjiLOqRgN016taP9zZTONb+exhSgqr/K7IUskcNOepg3ZAG3FUKOEf3kkb8YsMR/BSKK6ZDZhQWwTAFFOAhv1i/vV9UTMxsdhPJdP1cIxy4uRer5ovXO9Y/2yOcXxnKpxWjFDb3l5cz5uUAUgDOz52BYGp/TC5Gs+yxmLUAoBw89chQcuQGitHAhlJWdWoBSXe+IKHHSXGVGazaoLPZ18wnYHrJrK/0OKGcNyQVg3dhiMD7Jmh39JOKVtdvhCMWPotWLLhmwTbW8RplVLgYofuTejt0u17TI3dB3p3EizXKh72J2zjRjuPfCLmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx3X/D38SeffqmHlWr2FQaz7HZ197n+k4/w09Jyfsug=;
 b=KOKrTgVeiHKmX+SnsAwQTOiS/5A4N3H55s1c3bqVMfc0T8K9hmrSKd/tUPUVw8KMPnzEYY6BlGmB9eYbWNs0DN9xKwhgCaQYgmmspnjApKoSVjNDCby1lqQMe+L7o1AhYiHkHLgfKS7374PZMZ6Ok+Rs9+A1oqSV9446gZKMd9PMZY6K8zg/vFFsS11lFYFbmhhd2cv4u1/nVfZSUHCqY9u0xYkLjZS682FiJNqvzdvb97woAipdWz6Jj/w6nPUfrnHnMbdhxAV1rm8NXT9TaLFjJ3dpv8yT6OrFSPP5epA25cY7utLuAQYMsv2mZNcC2tVF36/1KACNEv2OWo6Hjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 11:49:54 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:49:54 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 05/18] drm/i915/alpm: Refactor Auxless wake time
 calculation
Thread-Topic: [PATCH v6 05/18] drm/i915/alpm: Refactor Auxless wake time
 calculation
Thread-Index: AQHdRUGJcXz0OHWzHkSq0byDyF9DNLbj9G4A
Date: Mon, 28 Sep 2026 11:49:54 +0000
Message-ID: <def041d44708d80a6769f45c72c8ddcdbe7aeb98.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-6-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-6-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: 616804d6-8456-4716-e892-08df1d569cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|260925021311599003|3023799007|10067099003|260925021911599003|260925022911599003|5023799004|11063799006|4143699003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: VC/AXsBvg73/Oy4CCMaahl5dhxZ7lLLHti3GROLSyLl8FEuSVGLmKFSlV7JCI5bPrDToJFoFVjl1RmnG8InH3K2qYBkSdOtrYESI7gIhgcmLwgFFnADeNJyriWWIJBuGtiRdRRC4gLNFcdElRsQMIeyTz4sLZR9k1fD7w3UsKnLGgnTeVhQJKwfEMl5oaVD191pl37vt52bkKTxB8JmCmja6UQGKs4CD1GASxKvYpL0bD/a+h6zC8ygn6GtpnncEXdmDr/EtHSxY1rIAXcaEICyHkDjtxOcR4f5zK49EXs0M+AR6JbSHipVX7goP6DOZrDLceTXS6YydDe9+5k/jU0vwT8BOCTB3/RLcAcSpZVrrehUwBPYvxR+iDGV8a7HiLiTw9/N0WJ/ccqJCNW5SSrtuDLoGKn+6BC+tJiMJn8y32G9jrLMju602UPodSNe/V0YjZRAWeKM/niIKpfKYLCsRN5DvwSE0DhpChO79xg2R/ilmie9XoF+P+fXi8lCyld0K7/I1ZKYbtWaSEPrQuRjZvGuwYis8JT3MpUGZL/SP1KS/x9SHTMzT38cilI0HY0PeNjXH7TYpejj7+W7XkYwRhcceAMS1nEGYXzBad/7ZkIh7HRK6hSct6LWlToGlTpDkOu7O88s210H/8YIrs488nzFthSvznc+6XH6HEsicyCbA7c2BauPmQ6+NKClD9wyPdUB/14dFn07Qqof3Lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(260925021311599003)(3023799007)(10067099003)(260925021911599003)(260925022911599003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVFNRXVwWlJ3NGowbGNJekpCZkNoK2YvY2UvSGkyOGN2VlVZamxkVEN4M0M5?=
 =?utf-8?B?Yzd2czRnNGVvdjYvVG1sclNQeXJMOFAzTDlGZHhTNHU3ZG5sZXlaVVFra3I3?=
 =?utf-8?B?eXlyTi96MjZ1K0ZtUFRZV2t1RTROdVBsRUMvcVZkVDNvTzFJbnBiUzRPeW5R?=
 =?utf-8?B?bXhuT01NWTN6aTIyd0o0WmEwbGZtUGpqRVZad0tmMDAwVEpra0dKQ1ZoSzJs?=
 =?utf-8?B?Q1NNTHhwMjZCdklHdDIzcEJVMEJYam95NERMYUFvd2h4OHQ5dXV3Wk1pbWY2?=
 =?utf-8?B?TFFCRzlHZlRLaG1VVWNFTW9TLzljQjMvdVY1a0VlZDNxaHRwSi8wQVByTHV1?=
 =?utf-8?B?a3FIYlVjcERxc0xCR0FxcWNuYXJjS0VuUllpWkhZRE90ZWdEUElDS1VISm5v?=
 =?utf-8?B?Vll5WHVia1VyS2ttUTdoN0xxN0VVWUJCckV6NTA3OXhWQUNVcTBqZzlwd2lk?=
 =?utf-8?B?eVh1N2MzZVIvWnJVV2Ewd29lOEhmWWgzRC8zNEhoTXNBK0tvUTNFMkFvZTdY?=
 =?utf-8?B?VWhDZU9kTDdzbDd1VE9KSG0yMDdsUVJQV0RJQUlyWlp2Y1RoN0JsTWlGWmxy?=
 =?utf-8?B?Ri9VY3N4UEJpczh5RnVoWm1qYmZ4ZlRsZkp1d0lWQ3IvTVR3alc2MmhvenIx?=
 =?utf-8?B?dVZpSDdWdDFFOXVveXpLM2ozbWtTZ3VWYjlRUm9aWWlPZU91SE94UTVpaURk?=
 =?utf-8?B?TnpHMXhTMHFlYTlMM2VUTXE5Ty82ekRTTm9kRVQyc2hWT2Y2K2FsWWgzVGJP?=
 =?utf-8?B?VEQvVC9sZURad3BRTVdhWXAwVVFjdHFoeHFucnVoVUswUENjVnJ1cXBZc0Zj?=
 =?utf-8?B?VitiN1E3dmIzdnBXNk84Q0hLTmRmZjRDMHJFQUxxS2M5TWZKY2VvOEcrZ1k1?=
 =?utf-8?B?VmYvN2NMQ2dvcTY4U1c2dktDSVViZWtWeHZYSzArdW5nR1QxWWR1K1R2ampa?=
 =?utf-8?B?MkNzS2lEZEF0UHRxOHZFR3lZaTVrY0xzaG5ta0lIdlFSdHZlR3ZNYlJhaVdw?=
 =?utf-8?B?RjdyRFZTUUpLeVJCTUsybHo0QVRBWk5HYXZCWWE5YktHNVI5TmFBRVRHeUFx?=
 =?utf-8?B?TDh5Um9MU01vNjJvUTJtUHVNcmtZcU9SZ0VLVk03UGJ0VFUwcExvVVVHTVZN?=
 =?utf-8?B?TEU5c2M5YzRNeE5meXJ6YW12cmZhNzlWaW1ndTR1VGl3UFFCdzBlY290MU0y?=
 =?utf-8?B?eFZYdnpNVlorM05zaFNDQnU1VDFQRTE1akY2aC9LVXZMOFQ0ZWhIWXptaDRW?=
 =?utf-8?B?SUpqam85bTdEc1cwSVdWWmpxNmR2dUdiNXFOZHg4THJNQS93QlVQNXhGbFBV?=
 =?utf-8?B?cnd4WFBGUkVCelNFdjlaM2hJUkpIdWJ4RnhMMmQyeXBpYk4rY2xTbmZIWkdR?=
 =?utf-8?B?VVB1Q3V4c3EyYlJmSGF0WEVESVdURTRKUEV4MjdXYjFPUll6U3UyQ2JBYzBN?=
 =?utf-8?B?R3FhN1k4TEd4UWpzVGNlNHpnRWFuSDZ3RTVPU3dEMzdRYVJ0cEpEZm4xUkU0?=
 =?utf-8?B?N2YzdFRPZ1ljdi91dkR5OHpSR3NwZENqbjRDU0o3TGRnci9iL2xiYUNOcUpL?=
 =?utf-8?B?eGlLZDhtQi9hUElrVzFCWlhtZURicC9ncEdUdzQ2M2grdjRYclkzaGJvdTVh?=
 =?utf-8?B?QXdqTWh6SDAzQ2xtaDhnQXNOdEJQTlpkS1FyaDBEZ2pwUndWUUVlY3JMY09o?=
 =?utf-8?B?WkNaR3ZUa1czYTRkVnQyL0J3bUNleHo1bW1JM0xzUzYxaWhBeHpGMXdRN1JT?=
 =?utf-8?B?OU9SSjN1Q2pKeVFXN1dYbnVNb1dzODJnc1ZLaFpZS0hBeXozNU5PZXhLcGRX?=
 =?utf-8?B?alFmdkp5VGJGMi85WWorSng4R1RiK2MrbWpqQUJ5RS9QcW8ySmdoaUdXWkpx?=
 =?utf-8?B?dzh6M21hUE05aXFWdVJZSkZKbHRiNzJyUlVWZklxK3FFa2VDUnhNeXlaVUlh?=
 =?utf-8?B?eUU0Mmt1NmVxZGFrU25FaWE0YXo3bndEN1VaYmtIdDEyWWR6WE0yemdlM1BR?=
 =?utf-8?B?c3hranNseENkNTU1VnZDbGJyNyt0M1o2RVBSMnkxakQ4UkxTMzl3T0grM2dN?=
 =?utf-8?B?RVZZd3FRWVBzM0VrK0dpbXlocjVNak1nVjdBNVM5Nkc3K0cwb3JLK2VkVnpM?=
 =?utf-8?B?dGtBR3E0RURwNDVLT3IxVXhwWUl6RkNWSllvNFJ1NEtJbGVWRHZXUGluUmFX?=
 =?utf-8?B?NHhLSDdwQmU0UkJJb0lGbE84Q2pkL3JFWldwUWVzc2lMejVJdHNBZ29QSTRJ?=
 =?utf-8?B?ZmtYWGRBWEx1OWlZdTI1NkdzVmJUNGtIODgwQlcxN2hDcFhhSzAyUXo0M3Zu?=
 =?utf-8?B?dnFteitHZ2pIekxlbUhaeTBaL3FVb2JFOUxESzZvYUw0Y2VoTFNwQUFuaG5L?=
 =?utf-8?Q?gwOJ1N3fn3aJTCHQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C022591A24BCF24B896BE7460B5C7ACF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jBmoS+DyGGVXYOhC7HtmACzqP1C/dTGWrrQUP5kgiyQJYrq3A+rW1qW5gmtLdLeN+9orNrF7KX33apfFEFqqZ9MJiPmBF6cqPNeQ5JF9npbbpK09ylBUS6zi2apM8txGD8wp/oDAWBj2kLcNVpaz9HywKvbchutJiDruguhT31/dxWRVuJJ9Snpd32J1FvetSayyB7Pqa8cdfnzDYy7Bwp2b6nBNYeUXPhs2sj7QJXHyUd1aJAZU3N4ZWMFX6to+izpEBBlQUexg+gZHbsN9+kWNIpF8P8peO2qKItXdT7YiotvcLN7L4o/2U1mEySSZD7R6oZeYlEyU1aKaK56PoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616804d6-8456-4716-e892-08df1d569cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 11:49:54.2391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpV8oC9YQEKgBA7lu6NC2rQWt1435oYlPSMvkUMlve+tmWU/7g2XPSI+6G8u8OwuYq6gneH3egxKNeLLj/tSU8FTb5XZ6XyL2swxe00GsIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
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
PiBEaXZpZGUgdGhlIGF1eGxlc3Mgd2FrZSB0aW1lIGNhbGN1bGF0aW9uIGluIHBhcnRzIHdoaWNo
IHdpbGwNCj4gaGVscCBsYXRlciB0byBhZGQgWGUzcCByZWxhdGVkIG1vZGlmaWNhdGlvbi4NCj4g
DQo+IHYyOiBSZWZhY3RvciBmaXJzdCBleGlzdGluZyBjYWxjdWxhdGlvbi4gW0phbmldDQo+IHYz
OiBDb3NtZXRpYyBjaGFuZ2VzLiBbSmFuaSwgU3VyYWpdDQo+IA0KPiBCc3BlYzogNzE0NzcNCj4g
Q2M6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiBSZXZpZXdl
ZC1ieTogU3VyYWogS2FuZHBhbCA8c3VyYWoua2FuZHBhbEBpbnRlbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50ZWwuY29tPg0KPiAtLS0NCj4g
wqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYyB8IDMxICsrKysrKysr
KysrKysrKystLS0tLQ0KPiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9hbHBtLmMNCj4gaW5kZXggOTAxNDkzYmIxNDQ4Li5kNTgyMzE3NDU3NmEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC0xMDIsNiAr
MTAyLDI1IEBAIHN0YXRpYyBpbnQgZ2V0X2xmcHNfaGFsZl9jeWNsZV9jbG9ja3MoY29uc3QNCj4g
c3RydWN0IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUpDQo+IMKgCQkxMDAwIC8gKDIgKiBM
RlBTX0NZQ0xFX0NPVU5UKTsNCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMgaW50IGdldF90cGh5Ml9w
Ml90b19wMChjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0Y19zdGF0ZSkNCj4g
K3sNCj4gKwlyZXR1cm4gMTIgKiAxMDAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGdldF9l
c3RhYmxpc2htZW50X3BlcmlvZChjb25zdCBzdHJ1Y3QgaW50ZWxfY3J0Y19zdGF0ZQ0KPiAqY3J0
Y19zdGF0ZSkNCj4gK3sNCj4gKwlpbnQgdDEgPSA1MCAqIDEwMDA7DQo+ICsJaW50IHRwczQgPSAy
NTI7DQo+ICsJLyogcG9ydF9jbG9jayBpcyBsaW5rIHJhdGUgaW4gMTBrYml0L3MgdW5pdHMgKi8N
Cj4gKwlpbnQgdG1sX3BoeV9sb2NrID0gMTAwMCAqIDEwMDAgKiB0cHM0IC8gY3J0Y19zdGF0ZS0N
Cj4gPnBvcnRfY2xvY2s7DQo+ICsJaW50IHRjZHMsIGVzdGFibGlzaG1lbnRfcGVyaW9kOw0KPiAr
DQo+ICsJdGNkcyA9ICg3ICsgRElWX1JPVU5EX1VQKDY1MDAsIHRtbF9waHlfbG9jaykgKyAxKSAq
DQo+IHRtbF9waHlfbG9jazsNCj4gKwllc3RhYmxpc2htZW50X3BlcmlvZCA9IChTSUxFTkNFX1BF
UklPRF9USU1FICsgdDEgKyB0Y2RzKTsNCg0KSGVyZSB5b3UgY291bGQgcmV0dXJuIFNJTEVOQ0Vf
UEVSSU9EX1RJTUUgKyB0MSArIHRjZHMuDQoNCj4gKw0KPiArCXJldHVybiBlc3RhYmxpc2htZW50
X3BlcmlvZDsNCj4gK30NCj4gKw0KPiDCoC8qDQo+IMKgICogQVVYLUxlc3MgV2FrZSBUaW1lID0g
Q0VJTElORyggKChQSFkgUDIgdG8gUDApICsgdExGUFNfUGVyaW9kLA0KPiBNYXgrDQo+IMKgICog
dFNpbGVuY2UsIE1heCsgdFBIWSBFc3RhYmxpc2htZW50ICsgdENEUykgLyB0bGluZSkNCj4gQEAg
LTEyMywxNyArMTQyLDExIEBAIHN0YXRpYyBpbnQgZ2V0X2xmcHNfaGFsZl9jeWNsZV9jbG9ja3Mo
Y29uc3QNCj4gc3RydWN0IGludGVsX2NydGNfc3RhdGUgKmNydGNfc3RhdGUpDQo+IMKgICovDQo+
IMKgc3RhdGljIGludCBfbG5sX2NvbXB1dGVfYXV4X2xlc3Nfd2FrZV90aW1lKGNvbnN0IHN0cnVj
dA0KPiBpbnRlbF9jcnRjX3N0YXRlICpjcnRjX3N0YXRlKQ0KPiDCoHsNCj4gLQlpbnQgdHBoeTJf
cDJfdG9fcDAgPSAxMiAqIDEwMDA7DQo+IC0JaW50IHQxID0gNTAgKiAxMDAwOw0KPiAtCWludCB0
cHM0ID0gMjUyOw0KPiAtCS8qIHBvcnRfY2xvY2sgaXMgbGluayByYXRlIGluIDEwa2JpdC9zIHVu
aXRzICovDQo+IC0JaW50IHRtbF9waHlfbG9jayA9IDEwMDAgKiAxMDAwICogdHBzNCAvIGNydGNf
c3RhdGUtDQo+ID5wb3J0X2Nsb2NrOw0KPiAtCWludCBudW1fbWxfcGh5X2xvY2sgPSA3ICsgRElW
X1JPVU5EX1VQKDY1MDAsIHRtbF9waHlfbG9jaykgKw0KPiAxOw0KDQpJIHRoaW5rIHlvdSBzaG91
bGQga2VlcCBudW1fbWxfcGh5X2xvY2sgYWxzbyBpbiB5b3VyIGhlbHBlci4gSnVzdCB0bw0Ka2Vl
cCByZWFkYWJpbGl0eS4gQWxzbyBpbiBwYXRjaCA2IHlvdSB3aWxsIGhhdmUgdGhlbjoNCg0KaWYg
KGludGVsX2NydGNfaGFzX3R5cGUoY3J0Y19zdGF0ZSwgSU5URUxfT1VUUFVUX0VEUCkpIHsNCglu
dW1fbWxfcGh5X2xvY2sgPSA3ICsgRElWX1JPVU5EX1VQKDY1MDAsIHRtbF9waHlfbG9jaykgKyAx
Ow0KfSBlbHNlIHsNCi4uLg0KCW51bV9tbF9waHlfbG9jayA9IDc7DQouLi4NCg0KdGNkcyA9IG51
bV9tbF9waHlfbG9jayAqIHRtbF9waHlfbG9jazsNCg0KQlIsDQpKb3VuaSBIw7ZnYW5kZXINCg0K
PiAtCWludCB0MiA9IG51bV9tbF9waHlfbG9jayAqIHRtbF9waHlfbG9jazsNCj4gLQlpbnQgdGNk
cyA9IDEgKiB0MjsNCj4gKwlpbnQgdHBoeTJfcDJfdG9fcDAgPSBnZXRfdHBoeTJfcDJfdG9fcDAo
Y3J0Y19zdGF0ZSk7DQo+ICsJaW50IGVzdGFibGlzaG1lbnRfcGVyaW9kID0NCj4gZ2V0X2VzdGFi
bGlzaG1lbnRfcGVyaW9kKGNydGNfc3RhdGUpOw0KPiDCoA0KPiDCoAlyZXR1cm4gRElWX1JPVU5E
X1VQKHRwaHkyX3AyX3RvX3AwICsNCj4gZ2V0X2xmcHNfY3ljbGVfdGltZShjcnRjX3N0YXRlKSAr
DQo+IC0JCQnCoMKgwqAgU0lMRU5DRV9QRVJJT0RfVElNRSArIHQxICsgdGNkcywgMTAwMCk7DQo+
ICsJCQnCoMKgwqAgZXN0YWJsaXNobWVudF9wZXJpb2QsIDEwMDApOw0KPiDCoH0NCj4gwqANCj4g
wqBzdGF0aWMgaW50DQoNCg==
