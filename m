Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D97DCA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5BB10ED10;
	Tue, 29 Sep 2026 07:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VkFB+007";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53CD10ED04;
 Tue, 29 Sep 2026 07:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790665230; x=1822201230;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Dfgps0rA7le4/17VZPYnocj1i3AbXlg8kZ6Id849cSo=;
 b=VkFB+007crHMOvoBIzwcr2u67BQl7xaoqUOVfnV0+XbLgnQwKDbqnrQC
 KlrPWgZ1p/H7s7uaS3p6aqlAI1rfQH7LtFyWGRjzPB4doDECXWP1w+ukQ
 fVLOHaI26CkYLpqyssRYj2Z8/jvwcfLY9OR5Qw+Rs+HUKR1wcf2lSSMTk
 R/QyeJI1pvMmppRUIE7PoLNA2eBV4J/BRQuBmXEoZbXQEJ6uo9HvcLn7S
 CoDj8h6eRRfrerZMEyaKLayCeimZtnJSAxutOB8rI9YaGmb57yDgE1sUI
 ooBEgd7eNkQmoBUmm7XNWr9ETQO2laD6tmVMm7NREis+04bP+yxHcWjpS A==;
X-CSE-ConnectionGUID: LlgYs9t8SFeUAyeEhkyd0g==
X-CSE-MsgGUID: bkqIJE/aQTGVpxigKsC/+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101541425"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101541425"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 00:00:29 -0700
X-CSE-ConnectionGUID: lfWn85CsTCOVJyWU/KAlEA==
X-CSE-MsgGUID: kfRpDaXLSJi6xHVJ0FDhNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="304787641"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 00:00:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:00:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 00:00:28 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYU6ynUp0BCv2/2nVQUioStcSHxDJw/XGwVIQdpFl4aKY+2zrn2pYyoTbK8259mCLZPDL9q6geA8251BmTYCz9FANSuxeB5t+/OaqgsXuHDvoIVxIUiVUbOMwHrVr7Bw5E1L7DkISVB8NSlWVxm1Jv4HpYXmgkF1Oba6u2CyxlLb/g6wOQsuu7UTem4l/P1lQ8faD6Ff1Bgr3mWtl8fPZ4RhCTzIE7vV/GpabaDqsY+0+ZH8f8lIshJEbVCeSAqv3lzoLAJkJKeE/sRYl+IwH+PbAKD81NSk50i1A3VWpERINNRZqn5qC3hpV7tIY6QFIf8SzQfm4Ugdpe9P89m+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfgps0rA7le4/17VZPYnocj1i3AbXlg8kZ6Id849cSo=;
 b=yEwV9RA7FTt5mw/KSluvnSSsfnTzr7wG8MaojN1/tEGMHSuRT4Y7uY2RgZily5Yoz9r+OQkpni7JP9xohubkT6tYsp+D7m2tDlSzJUlS/WJYC9lS9uVIlq+V77DmxE2z62qiJ6GFwHwWqewAqOPFLHNui0J/JnH98fwukbPwDqETUikPkeJAOcfSE+DyJ5QodqzSmyDTDAghRyeXd5BRHkwNe19+Gqw2lUfo2YUuCWKvK3XvxgUIuhcYDULTtPsPrSZ6mq3iiniH7goAGo0n3XTU10N1R4GL83qO620fRDTzSBdP0b3IioXupBKv5lQmoLcGjO4MgzZRonQKO7s/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Tue, 29 Sep 2026 07:00:24 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 07:00:24 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 08/18] drm/i915/alpm: table based establishment period
Thread-Topic: [PATCH v6 08/18] drm/i915/alpm: table based establishment period
Thread-Index: AQHdRUGOKmuWy//RiUShNN1ucxLVBrblNeAA
Date: Tue, 29 Sep 2026 07:00:24 +0000
Message-ID: <dfc66a1292774129a0277ea75a3be0e49ee52eec.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-9-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-9-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CH3PR11MB8436:EE_
x-ms-office365-filtering-correlation-id: 0cc8701f-0532-4255-b5b0-08df1df755a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|3023799007|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: HuPJW1eEwu/yw8kYAAuIJC2HyOTdCeQ9F2wYQGBqGUe11a8lGjRaYsiiRX3RqjcKgZDGO8lKn/g7id54K+rDyWONfiZVL3ZZSR6Rn9oxsv2d8+n0qQU5Rtu28VpmrbNGzCU4jtZiq+86WTP0xmuTPZTN1XEeiyIO/2IFZi/4+WdGuL+o8J1YW7iJK37pXi9EXWIMLWqr9Q7zpvi/1YyzBsj4VEiPguCg+8lcJBxiRRXvlnAQI4En08Bk9wIyWtDDVRZ+UczWgjb0VivvK229oOL3abjAhOXwnEPXbUDpqqHM/fUAUUgPheawdm9Gz/nIaqp+84gonxtrIRwN97qIQVpEsjnr0FBWgvh3sR7biHnyDeDlph/uYymwp7KYzS5fagITauj3IbSVVvJ1kWDyLGCWkttiaGspdOiiZgWEpCamtiNTTVYkPncE61gnDepnkEWLrf3iOIebxh42HZ/X3DMZrclEiOWESsGp5zFDPVTk4EH5yW+2/C/cm/vBzkJBYNrwpjbErpbSQ4U6kECSQxtDaYOM4db8QkXncKs+jqPff5F2Sd2Y0S12U2eH0WIbz6/rT4LK8OTDmcYBheL9uWv1TeZASkiMwePHp3D9YDMrhvAg50wsEyjChYSQwq1T8T0guzpF3d2n1vHphzz1h9buJcP6lmL3a4+QFiovPoNqQTVEwze+b5hXNt1+wHPF1kfsJp2lMi+YMFqyXjpJIM6zbMQdiWfFreAYrF2ohCc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXphV00vS1pKSmhOYjA3MDBzdVE0MXRDQTFacUF1OGdZbUIrZzJLWmdwMncw?=
 =?utf-8?B?aDNERGM2VEJkMUdRU1d6RjkyZzk0VnU0UHBQQjdsVjcyTklXcjVxSWtJZXRN?=
 =?utf-8?B?dFNab0o4SmtyL0VzZWt6ZXlFSkgrV3pjZzJuZmdUUHRMbllzUjllQnREejVq?=
 =?utf-8?B?YkdOREhkd001L3FRaEkyMkxJUnk5NGtEaHBLT2lvN1MwWVNrbHFaTGwvczN5?=
 =?utf-8?B?TFdMS0JTYVg5MjZ6OFRtYnd0ZHh6ZmxobW4vT3d4NElWQ2lhMFN1SHlvaHVh?=
 =?utf-8?B?ZHNqYVZ4NDNlMkQ2ZE5udXBNbWtFRTdYSnE2bE5xYzJ3eDFIRGk2L01MeGx6?=
 =?utf-8?B?YUo1YURrRWFvTXFYSmlCQm9YZW12RkZ5QjJveTU5Ry8zRkk1cS9iMUhKVEFa?=
 =?utf-8?B?Q0lLUk1Oc2FrMnNiQUNoc0JlREprWkxiVWUwcmltakVMT245cS9mVjRYcjVm?=
 =?utf-8?B?dlNVTlBxZlE3WTlBd3Q0OHRBb0taN0tDZms3Ync4dlVSdzRTK3ArZWZGYlpK?=
 =?utf-8?B?RHA5ZWRyUzNPSWxKQWVXb2F3cGI0bXllZ0VJL2pSMDVPRHJ6cnRndU9JZlJJ?=
 =?utf-8?B?UTNnL0ZrQm02c0hEL1FlUTNBd3h0bE9MNVpFV3ViTlROaHZXaTdRSVV2QTV6?=
 =?utf-8?B?dTZoaWlObkh1UUFMQW0wVEhxNGIydEt4dlZ5MWFPcC9iQXZ1a3dndS9NVzlu?=
 =?utf-8?B?ajlYOHRFVXJMSitGaVpkRTFKWmVkZStnY3VhNHJlMWJrL2F0TktzMW9yR1lE?=
 =?utf-8?B?OTFPcHhzd3NsUlZPZnJ1V3FrZFJETkxGUGpGcU1BaDNUL1VhRUNZZGhnS1Nm?=
 =?utf-8?B?YmdsN2wxN2tmcHdRS3d0bkJaTkRQRGVRTU9ua2RzbllzTWRidTMzVWFtK1Ji?=
 =?utf-8?B?bkRYa1JJQTBxK0RzMk1iMm0rbWlkOGlGSzdmdlZUUkZEdDZWRVZ5ME80NVhk?=
 =?utf-8?B?VjJ6OVgwOWhlWU9QdDRuZEdEVUlaUnpmUStlOTk5QTRYdmI5elI3K1JTQm1R?=
 =?utf-8?B?cGt1cDJjejFXdVg0eG9FOVdjcjZEVEowd1MwdzRhbHh3a1pYeWExdUxwVjh3?=
 =?utf-8?B?cE9tcXN3c0lUUzVGdllpUjJDOXdvcFV0cldoemRveUxTU1hCNEV6TXVvT2JO?=
 =?utf-8?B?NlliVk1JRStiQ0JVazlxQmw5QU9VVnFnK3JMTUZTVWlnQnhJKzVIV2ZvUlFm?=
 =?utf-8?B?K21QYjdYWWdxbFN5eGk5by9GYXNrSGc2MFhEMThBNysvTjFRd1QyZkxobTJG?=
 =?utf-8?B?MWxBdkZPaTVwcFFUZi9uTGRCSDhVaVVTLzNTRFRWOEMxUXNJL1dGbjZlUlRK?=
 =?utf-8?B?dDNPUHd0NDFRUXNKRDIvL3hRYmZ0ZUVrUTBPRzQ0cTBMclRMbTlJWUx5alR3?=
 =?utf-8?B?VGZUNGFvU3V2V0NKdXlIMlQvNzNKWW5FUVh2dkVPZ3ZiMEVVaWMyVmdMUWZx?=
 =?utf-8?B?OCt2TnlIdzRjWmZqYmhySWhEN3cyNkxITGwxTGVia0Q5R2JieE5LOC9aaHFX?=
 =?utf-8?B?QXVIdjB3aXNRZFFlOFhYMUh1Z3N5L1pXN1N2KzNzbWpwTEo5ZW1CM0pJWG0w?=
 =?utf-8?B?SEVSb3A1ZHU1SHpYTFk2V0tFNHpEeFhqUk5Yck9SNTJSeTV4TVUxYy9mSi83?=
 =?utf-8?B?WjF3akxiZzhySUlQaW82WEo4WDQzSThiQ2kvYXhiTWIxSEVhZ3JpSVl5dEZy?=
 =?utf-8?B?VVJwaHFkRmN5VjBJWVhLSTMyN0M5TzRHSXNEL3V3cHc2Z3N6c05jQXJ4ZzhH?=
 =?utf-8?B?MXdBd2I4T0cvSlBoTUQzQWk3ZVJxU0hGWkxqMFM1UnhhOWRCUkZhV2N0bU0y?=
 =?utf-8?B?TWRJTXl4S1lLb3lwMVIvVm9udDM3RE1YNUszOThQZVdoN3kxeUIxZjZZREZG?=
 =?utf-8?B?RlBraCs0VGdtM1YwbEQ0a2Q3eTJXUnNEZkVXazB1dCthK25namF1M2lsQm1U?=
 =?utf-8?B?ODZCdnkrYnM1WHZIcmNveXlWZGJMK2loZ0lnMDM3c0FoTDM3SUFsWGNBTUxM?=
 =?utf-8?B?aXduNk9ZQ2pXVHo2eEJ2SmRGY1QvK280TnlTbU05SmkrNUtScUFwc0F3MFhs?=
 =?utf-8?B?WnVEMDMvY0dxRzJSM1ljNmd3TUlSR2dMU2F4SUR3Z3ovRGJEb1dKOG1RdVpa?=
 =?utf-8?B?Z0JzM3lqa2Y3LzhJWE5LS0ZpQmhhbkZRSXVGUng4elJGYkhiWUlRUnp4ajFJ?=
 =?utf-8?B?MDYwWWhLaVhTSWpsQ1JFYjVIcE9XSTkxUFRQOHlYdU5pNG50dDcyZktQdENr?=
 =?utf-8?B?dWFaL1RtRkx0c1l1OWQvK2pnL2RuaHg0NmcyODNrYmtqdEV6d3ZNVDdLSStY?=
 =?utf-8?B?S2p3TER5L3psTWdvYUIzTEVNKzF3aDJ2UFNyRjVyRjRVLzRUd0owNWV1RDgv?=
 =?utf-8?Q?KsvjQJ6V77hc1qFI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FCE4B1B43F53D44A9CC6325743B6F5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BdhWCRFnvvJOpMY6k/B21Liyi17d/4ZJ5Nh74QQ5sCLo74nDo30HQveJVWLBHaA6jcb+cJIgXT5jqNbNjkGj7Zq6P64bOj4kVPVi+vyhlc30yrN4CYnWWtlutBEzBjvZZ2F2bpmETKDQY/CrKwVqkfs9x+JZT+fRixEiZo9lnv+75ZPJk7iphYw/ZUB8Y4rnXqm/BTLRw+P1kz/GjJt/tf1xPweip8cSh93cXqjy58dpz6nDi4gO/4wreUIBG471iGDIxPXVBnKAWs5b+DNMTvgkPuHCBCePGVBLoTYvtfvIm3YerpQxTkxj29DA2SszAmgWcmoh1NCaf1VU9E+HXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc8701f-0532-4255-b5b0-08df1df755a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:00:24.0585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joeb5sz+A/ygZbw85i+ATufI+SNVEHwySXStzc8gpf36nAOSVuticAbbCGcpfJShPKzzG58IpF57HDoWkjVKj3XOV0FFvX9EOA5uoCKbs6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
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
PiBPbmx5IHVzZSB0aGUgdGFibGUgd2hlbiB0aGUgbGluayByYXRlIGlzIGxpc3RlZCAoaWR4IHZh
bGlkKQ0KPiBhbmQgdGhlIExUVFBSIGNvdW50IGlzIHdpdGhpbiB0aGUgdGFibGUgYm91bmRzLiBB
IHplcm8gZW50cnkNCj4gbWVhbnMgdGhlIHJhdGUgaGFzIG5vIHRhYnVsYXRlZCB2YWx1ZSwgc28g
ZmFsbCBiYWNrIHRvIHRoZQ0KPiBjb21wdXRlZCBlc3RhYmxpc2htZW50IHBlcmlvZCBiZWxvdy4N
Cj4gDQo+IE5vdGU6IFRoZSB0YWJsZSBhbmQgaXRzIHZhbHVlcyBhcmUgdGFrZW4gZnJvbSBEUDIu
MSB2ZXNhIHNwZWMuDQo+IA0KPiB2MjogQWRkIGNoZWNrIGZvciBuZWdhdGl2ZSBlcnJvciBjb2Rl
cyBmcm9tIGRybV9kcF9sdHRwcl9jb3VudCgpLg0KPiBbc2FzaGlrb10NCj4gDQo+IENjOiBKb3Vu
aSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
QW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZl
cnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jIHwgOTUNCj4gKysrKysrKysrKysr
KysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gaW5kZXggZGMw
MjUwNThhNjI2Li5jYjI0YmJhODAxYTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC0xMjIsNiArMTIyLDkyIEBAIHN0YXRpYyBpbnQgZ2V0
X2RwX2xpbmtfc3ltYm9sX3NpemUoY29uc3Qgc3RydWN0DQo+IGludGVsX2NydGNfc3RhdGUgKmNy
dGNfc3RhdGUpDQo+IMKgCXJldHVybiBpbnRlbF9kcF9pc191aGJyKGNydGNfc3RhdGUpID8gMzIg
OiAxMDsNCj4gwqB9DQo+IMKgDQo+ICsjZGVmaW5lIERFRkFVTFRfTUFYX0xUVFBSX0NPVU5UIDcN
Cj4gKyNkZWZpbmUgTUFYX1NVUFBPUlRFRF9EUF9MSU5LX1JBVEVTIDEyDQo+ICsNCj4gK3N0YXRp
YyBjb25zdCB1MzINCj4gZXN0YWJsaXNobWVudF9wZXJpb2RzW0RFRkFVTFRfTUFYX0xUVFBSX0NP
VU5UXVtNQVhfU1VQUE9SVEVEX0RQX0xJTktfDQo+IFJBVEVTXSA9IHsNCj4gKwkvKiAxNjIwLCAy
MTYwLCAyNDMwLCAyNzAwLCAzMjQwLCA0MzIwLCA1NDAwLCA2NzUwLCA4MTAwLA0KPiAxMDAwMCwg
MTM1MDAsIDIwMDAwICovDQo+ICsJLyogTm8gUmV0aW1lcnMgKi8NCj4gKwl7IDYxMDcwLCAwLCAw
LCA1NjcxMCwgMCwgMCwgNTM0NTAsIDAsIDUyMzYwLCA1OTA1MCwgNTY3NTAsDQo+IDU0NjIwIH0s
DQo+ICsJLyrCoCAxIFJldGltZXLCoCAqLw0KPiArCXsgMTU1NjcwLCAwLCAwLCAxNTEzMTAsIDAs
IDAsIDE0ODA1MCwgMCwgMTQ2OTYwLCAxNTM2NTAsDQo+IDE1MTM1MCwgMTQ5MjIwIH0sDQo+ICsJ
LyrCoCAyIFJldGltZXJzICovDQo+ICsJeyAxODExNjAsIDAsIDAsIDE3MjQ1MCwgMCwgMCwgMTY1
OTEwLCAwLCAxNjM3NDAsIDE3NzEyMCwNCj4gMTcyNTIwLCAxNjgyMjAgfSwNCj4gKwkvKsKgIDMg
UmV0aW1lcnMgKi8NCj4gKwl7IDIwNjY1MCwgMCwgMCwgMTkzNTgwLCAwLCAwLCAxODM3ODAsIDAs
IDE4MDUxMCwgMjAwNTkwLA0KPiAxOTM2OTAsIDE4NzI5MCB9LA0KPiArCS8qwqAgNCBSZXRpbWVy
cyAqLw0KPiArCXsgMjMyMTQwLCAwLCAwLCAyMTQ3MTAsIDAsIDAsIDIwMTY1MCwgMCwgMTk3Mjkw
LCAyMjQwNjAsDQo+IDIxNDg2MCwgMjA2MzIwIH0sDQo+ICsJLyrCoCA1IFJldGltZXJzICovDQo+
ICsJeyAyNTc2MjAsIDAsIDAsIDIzNTg1MCwgMCwgMCwgMjE5NTEwLCAwLCAyMTQwNzAsIDI0NzUz
MCwNCj4gMjM2MDMwLCAyMjUzNjAgfSwNCj4gKwkvKsKgIDYgUmV0aW1lcnMgKi8NCj4gKwl7IDI4
MzExMCwgMCwgMCwgMjU2OTgwLCAwLCAwLCAyMzczODAsIDAsIDIzMDg1MCwgMjcxMDAwLA0KPiAy
NTcyMDAsIDI0NDM5MCB9LA0KPiArfTsNCj4gKw0KPiArZW51bSBsaW5rX3JhdGVfaWR4IHsNCj4g
KwlMSU5LX1JBVEVfSU5WQUxJRCA9IC0xLA0KPiArCUxJTktfUkFURV8xLA0KPiArCUxJTktfUkFU
RV8yLA0KPiArCUxJTktfUkFURV8zLA0KPiArCUxJTktfUkFURV80LA0KPiArCUxJTktfUkFURV81
LA0KPiArCUxJTktfUkFURV82LA0KPiArCUxJTktfUkFURV83LA0KPiArCUxJTktfUkFURV84LA0K
PiArCUxJTktfUkFURV85LA0KPiArCUxJTktfUkFURV8xMCwNCj4gKwlMSU5LX1JBVEVfMTEsDQo+
ICsJTElOS19SQVRFXzEyDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IGdldF9saW5rX3JhdGVf
aW5kZXgoaW50IHBvcnRfY2xvY2spDQo+ICt7DQo+ICsJaW50IGxpbmtfcmF0ZV9pbmRleDsNCj4g
Kw0KPiArCXN3aXRjaCAocG9ydF9jbG9jaykgew0KPiArCWNhc2UgMTYyMDAwOg0KPiArCQlsaW5r
X3JhdGVfaW5kZXggPSBMSU5LX1JBVEVfMTsJLy8gUmF0ZV8xIChSQlIpIC0NCj4gMS42MiBHYnBz
L0xhbmUNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSAyMTYwMDA6DQo+ICsJCWxpbmtfcmF0ZV9pbmRl
eCA9IExJTktfUkFURV8yOwkvLyBSYXRlXzLCoMKgwqDCoMKgwqAgLQ0KPiAyLjE2IEdicHMvTGFu
ZQ0KPiArCQlicmVhazsNCj4gKwljYXNlIDI0MzAwMDoNCj4gKwkJbGlua19yYXRlX2luZGV4ID0g
TElOS19SQVRFXzM7CS8vIFJhdGVfM8KgwqDCoMKgwqDCoCAtDQo+IDIuNDMgR2Jwcy9MYW5lDQo+
ICsJCWJyZWFrOw0KPiArCWNhc2UgMjcwMDAwOg0KPiArCQlsaW5rX3JhdGVfaW5kZXggPSBMSU5L
X1JBVEVfNDsJLy8gUmF0ZV80IChIQlIpIC0NCj4gMi43MCBHYnBzL0xhbmUNCj4gKwkJYnJlYWs7
DQo+ICsJY2FzZSAzMjQwMDA6DQo+ICsJCWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV81Owkv
LyBSYXRlXzUgKFJCUjIpLQ0KPiAzLjI0IEdicHMvTGFuZQ0KPiArCQlicmVhazsNCj4gKwljYXNl
IDQzMjAwMDoNCj4gKwkJbGlua19yYXRlX2luZGV4ID0gTElOS19SQVRFXzY7CS8vIFJhdGVfNsKg
wqDCoMKgwqDCoCAtDQo+IDQuMzIgR2Jwcy9MYW5lDQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgNTQw
MDAwOg0KPiArCQlsaW5rX3JhdGVfaW5kZXggPSBMSU5LX1JBVEVfNzsJLy8gUmF0ZV83IChIQlIy
KS0NCj4gNS40MCBHYnBzL0xhbmUNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSA2NzUwMDA6DQo+ICsJ
CWxpbmtfcmF0ZV9pbmRleCA9IExJTktfUkFURV84OwkvLyBSYXRlXzjCoMKgwqDCoMKgwqAgLQ0K
PiA2Ljc1IEdicHMvTGFuZQ0KPiArCQlicmVhazsNCj4gKwljYXNlIDgxMDAwMDoNCj4gKwkJbGlu
a19yYXRlX2luZGV4ID0gTElOS19SQVRFXzk7CS8vIFJhdGVfOSAoSEJSMyktDQo+IDguMTAgR2Jw
cy9MYW5lDQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgMTAwMDAwMDoNCj4gKwkJbGlua19yYXRlX2lu
ZGV4ID0gTElOS19SQVRFXzEwOwkvLyBSYXRlXzEwDQo+IChVSEJSMTApIC0gMTAuMCBHYnBzL0xh
bmUNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSAxMzUwMDAwOg0KPiArCQlsaW5rX3JhdGVfaW5kZXgg
PSBMSU5LX1JBVEVfMTE7CS8vIFJhdGVfMTENCj4gKFVIQlIxMy41KSAtIDEzLjUgR2Jwcy9MYW5l
DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgMjAwMDAwMDoNCj4gKwkJbGlua19yYXRlX2luZGV4ID0g
TElOS19SQVRFXzEyOwkvLyBSYXRlXzEyDQo+IChVSEJSMjApIC0gMjAuMCBHYnBzL0xhbmUNCj4g
KwkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJbGlua19yYXRlX2luZGV4ID0gTElOS19SQVRF
X0lOVkFMSUQ7DQo+ICsJCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiBsaW5rX3JhdGVf
aW5kZXg7DQo+ICt9DQoNCkRpZmZlcmVuY2UgYmV0d2VlbiB3aGF0IHRoaXMgdGFibGUgaXMgZ2l2
aW5nIHVzIGFuZCB3aGF0IHdlIGFyZSBnZXR0aW5nDQpmcm9tIHRoZSBmb3JtdWxhIGlzIGNvbWlu
ZyBmcm9tIFNJTEVOQ0VfUEVSSU9EX1RJTUUgYW5kIHRsZnBzX3BlcmlvZC4NCkluIERQIHNwZWMg
dGhleSBhcmUgdXNpbmcgbWF4IHZhbHVlcyB3aGlsZSBvdXIgY2FsY3VsYXRpb24gaXMgdXNpbmcN
Cm1pZHBvaW50Lg0KDQpJIHRoaW5rIHdlIGNvdWxkIGp1c3Qgc3dpdGNoIHRvIG1heCB2YWx1ZXMg
b24gdGhlc2UgYW5kIGRyb3AgYWRkaW5nDQp0YWJsZXMgY29tcGxldGVseS4NCg0KQlIsDQpKb3Vu
aSBIw7ZnYW5kZXINCg0KPiArDQo+IMKgc3RhdGljIGludCBnZXRfZXN0YWJsaXNobWVudF9wZXJp
b2Qoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCwNCj4gwqAJCQkJwqDCoMKgIGNvbnN0IHN0cnVj
dCBpbnRlbF9jcnRjX3N0YXRlDQo+ICpjcnRjX3N0YXRlKQ0KPiDCoHsNCj4gQEAgLTEzOCw4ICsy
MjQsMTcgQEAgc3RhdGljIGludCBnZXRfZXN0YWJsaXNobWVudF9wZXJpb2Qoc3RydWN0DQo+IGlu
dGVsX2RwICppbnRlbF9kcCwNCj4gwqAJaWYgKGludGVsX2NydGNfaGFzX3R5cGUoY3J0Y19zdGF0
ZSwgSU5URUxfT1VUUFVUX0VEUCkpIHsNCj4gwqAJCXRjZHMgPSAoNyArIERJVl9ST1VORF9VUCg2
NTAwLCB0bWxfcGh5X2xvY2spICsgMSkgKg0KPiB0bWxfcGh5X2xvY2s7DQo+IMKgCX0gZWxzZSB7
DQo+ICsJCWludCBpZHggPSBnZXRfbGlua19yYXRlX2luZGV4KGNydGNfc3RhdGUtDQo+ID5wb3J0
X2Nsb2NrKTsNCj4gKw0KPiDCoAkJdGNkcyA9IDcgKiB0bWxfcGh5X2xvY2s7DQo+IMKgCQlsdHRw
cl9jb3VudCA9IGRybV9kcF9sdHRwcl9jb3VudChpbnRlbF9kcC0NCj4gPmx0dHByX2NvbW1vbl9j
YXBzKTsNCj4gKw0KPiArCQlpZiAoaWR4ICE9IExJTktfUkFURV9JTlZBTElEICYmIGx0dHByX2Nv
dW50ID49IDAgJiYNCj4gKwkJwqDCoMKgIGx0dHByX2NvdW50IDwgREVGQVVMVF9NQVhfTFRUUFJf
Q09VTlQgJiYNCj4gKwkJwqDCoMKgIGVzdGFibGlzaG1lbnRfcGVyaW9kc1tsdHRwcl9jb3VudF1b
aWR4XSkgew0KPiArCQkJZXN0YWJsaXNobWVudF9wZXJpb2QgPQ0KPiBlc3RhYmxpc2htZW50X3Bl
cmlvZHNbbHR0cHJfY291bnRdW2lkeF07DQo+ICsJCQlyZXR1cm4gZXN0YWJsaXNobWVudF9wZXJp
b2Q7DQo+ICsJCX0NCj4gwqAJfQ0KPiDCoA0KPiDCoAlpZiAobHR0cHJfY291bnQgPiAwKSB7DQoN
Cg==
