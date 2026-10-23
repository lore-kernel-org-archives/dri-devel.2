Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919A60A3810
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=doIIPVMw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBFA10E6B8;
	Fri, 23 Oct 2026 16:43:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00EDC10E0D7;
 Fri, 23 Oct 2026 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792773822; x=1824309822;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=x/tb/l2k12ssd8skggx0hwaZoy8nLZ4/t8n5ms751nQ=;
 b=doIIPVMw2wbJzffAk1H5qkoiq5beRxpICgnyP5s6JA0WvOXFP/49y6Tx
 N6cmLpMjLNLvunhWEUUNebowC050mZXewxFiJXXHLI6PRc8YRFPVui2TV
 43RLtQw9JUg+nbAqK5aMrKSoO4IeqJrtv5soBZwc0nMf3xBsZ9QaWemlV
 oSO/WWTBiLtI1ZjFbso24W7Oz8mrv2WSlBXrTpG+cJL73211yCb7UEnT3
 3U3OHjYGHfwvGgFnx9zyVknGPA5Jf4YSGPkrpeYQeNFVrSLSYZAmgYp1j
 ERFHZ8p+t1fE256zDCGcXEecT4YMoakR+moque4YDYo1yTbP+ojo0bl8W g==;
X-CSE-ConnectionGUID: AW/C1gspRZCtqW5g3xU5pw==
X-CSE-MsgGUID: Gj4ImBU2SsaPOmP6J+WRyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1526418"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1526418"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 09:43:41 -0700
X-CSE-ConnectionGUID: RW6P8QCyQiqWm6lkd5OQLg==
X-CSE-MsgGUID: Z3eV+miZSWqRjBGmZM/M3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="4081909"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 09:43:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 09:43:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 09:43:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 09:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jmu7/UQxRRtv/uSdxSdl+yNtwtl9SgBeDkckr9GHsCygA8FNZwjjxfNi9FX5ABViDnekl0JHror9T8szAozxMJaO245k9DSaC+acTPL8dJXcMg/Pxdb05spBxPHCvC35/Sffl41rhmN7S+IPsriFWTVV741tOoOLcp/QUnYGcKDnk/DU1jS/z+f2m7B6SbIGxGUORI+s9V3pA7QKHA4W+JUxDWGdhihYG+/CyFqyG4RmzttvDqvUD5FV+UhEubekvsFYlK9HeBWbb9AR8vu3Y0Ca16Z4CmFULprNzKgFxjIed2jW+ZgbGN0WNK8so2sd6um/U3uuU+iz+gYaklA5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/tb/l2k12ssd8skggx0hwaZoy8nLZ4/t8n5ms751nQ=;
 b=YSb8Cd1rfNN8q9F+AkyK4mgNm2Jhv53WnGFuyJAAYScHZ58kLWMcvW4CU2EpjDL4dSohTDPmvVqKUWpZrUmDhDBoL5ex/IXH7a1TEWbI2AF3VAGjqo8xUdVxlUMATM9bgFiMMHr73T0MEpKQJJZqtchE3o7Tuq6DNcD3w2NDpDwcYPA70WKBwgrOmWwdQR090ZfT2vZR9hS5uZwdHdou9L64fYiZUdvudpqupmtcgY60c0uiZ9UHWzEs4PsjR07qPwFglyGt4KyJcQmGtKi5QfmtGrq7Ywmu2c5J0Qb/Sa29RsvuM9Xs9P0KwKqVKmVWf3LEaHfQEX8IBzVz5DVpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by DS6PR11MB371697.namprd11.prod.outlook.com (2603:10b6:8:4a5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 16:43:38 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 16:43:38 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Topic: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Index: AQHdYoQLXPS/murewE6Kya5v6j0PxrcKRaUAgAEQngA=
Date: Fri, 23 Oct 2026 16:43:38 +0000
Message-ID: <6374a5991a04fe617a96fb283ba33b79431a62b1.camel@intel.com>
References: <20261023001827.170645-2-alan.previn.teres.alexis@intel.com>
 <sashiko-outbox-182172@kernel.org>
In-Reply-To: <sashiko-outbox-182172@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|DS6PR11MB371697:EE_
x-ms-office365-filtering-correlation-id: 154c5172-cf62-4990-9744-08df3124c9b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|38070700021|261022115727099003|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|261022105027099003|261022075727099003;
x-microsoft-antispam-message-info: 49BpHNSSj465F1IdHSsSAhkZ9CweD9g7qbjqeiGaBa+2fIiEuT7szs9WH8Lj9tF6gpXTYnLvfoOBDnSGm6o3MV03UOM6CpowhyqJWR7a3fEa0rKoEOGQJUnNeXoYNi0qo8EtwuENRa/tUluroMkwMdZvWF2fIBkkzfCDRaw0GJ0XDG/+MKkUJKLh0Oh1dh9a2qPHdiux0v+IM+3apuufVRMog1xxmTb8f8WukfS9euIdk0h42CDej1pZE9Po0pgVe3wEZGs5xbYKUBQZG0x/Lu6yyFsMewK3l/cYOZJ2W7oocXGDauJZOuxDU89VsPSzssIU9gIA3COLtpDr+mlQQgTJExyOxlQmODN34dbLabIna2P721EYIX7+wn3JgRbStZDrwPpapaRNQFQ8k5M+euCGB0x80+dKma7Dk+U/lEoxkU7ZJoE7itE6TnJYZ4Afzo+u0x6eaJs5BIC8sJdwyUaYh1DUKc86v79MmkXCtRjYl+DdclTeQnAjJV54wbC6JUGhF8yr+Vwfl61in7Jql0yrNLf+/80jF0dnssULZqfME53yitPEeiu3NBZjfy9jdcRm+oZBM5cd0oZZQgYxM2n/BQZhE0SKEMwL/v7sdyFQoR07wIt1/b98GUHUnN+fBGl0s/SHOgeZM+QjqM2bzBQ/1gufhPELp+EZZGn2nP3/GCKAC4hA2dNKwCXmCrZ3ASYmXZcXt/95mqdVct+kj+QUPPy/As+ofHv54tQBb2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(38070700021)(261022115727099003)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckFtazBwb1VDcnFSTHpiN3hsTWdRQ3RaSFJhKzZDOEFrNExzRS8zLzFRK0Zj?=
 =?utf-8?B?WmFtdVluZ08xV1VwSUhXYTJka1U2NTJEd0pRZ09wcS8rVzdBaWpOTHZlNTky?=
 =?utf-8?B?M0tkaGdURFo3VUpacWNkQjV2eVN2bnRNeEVIMVJFWlR1L0UxVzNpUUVVM0pi?=
 =?utf-8?B?bEpVRmtJelpEaHo3ZnRNSmZDeThpSDAya3F1R2t4ZFZ2Qm1lTURxNDlpNk5y?=
 =?utf-8?B?Mm9lNkgyWjBSRjFZcm1ycC94WE4xaVhsdStSYmVzd1JaTGY4Qm9LLzdlWnd5?=
 =?utf-8?B?S282WUdRZklsckJ2RDM1ZnU4TVphRVpCcUU1WFB1SHV6eSt3bW44Qk5PeHc0?=
 =?utf-8?B?emVBWURxQ3lPczZzcDRXMDNxSTRCcVhRTS9Va2w0ekIzbDZuTUtXNTNXa09z?=
 =?utf-8?B?dCtVaFZSR1UzejA3MkpzalVOdVJ5VDJzVEE4U1FvazBXSjFucTdaQUpOWHhF?=
 =?utf-8?B?a0NkeVd0djFiaExDbUVmbkZPSDJyK0N2ZmpnMkdKY053cHRObVBKbVk2SXVD?=
 =?utf-8?B?UXdlc2pucDFqcHlmYXRyd01zUEJXUjVPMlFzVEtkS1ZZSzRrRkN0QXBPT3hk?=
 =?utf-8?B?ME1xbndJYlUwaitGQ0J2WnpxNHpNVzJWamRHSG1INktoVkNTLzlXYzg5SG1R?=
 =?utf-8?B?YVI2UURxOGN6dzVtOURQbWttYkgvWFdUM0VEbFB2OHhYeUpDR1NWaXJvOHM5?=
 =?utf-8?B?dElxYW84THMycTBZWHJzZ2U1U21KdGx0U2Z5cmJQK3FYZjIxUzJTY2FXcHhu?=
 =?utf-8?B?Q1g2cE1nWUhURkR1ekNXNUowSTF1RXQxVmN3ak53OGx6ZWJEN2wra1Vqb25U?=
 =?utf-8?B?R05XQnBWRjdLUWVlS2lQYWtpSjBsTEJ2UThZRzgxREV4VExYV0FySUpyQ0pl?=
 =?utf-8?B?Tnc2OXcrOXF2aFRtcDQvM1BJVXpzalp5NHI1VE90L0ptTXQyOFJQNWwwWHFI?=
 =?utf-8?B?eDVUL2MvQ2dySmFFU1kybjY4QkpCVjBpbDZiVHY4aG1sMGp1UkxTbGZ4UUo3?=
 =?utf-8?B?ZS9mbTZMVk9oR05jZzBlVWgzR2pWdHRCQURJRVhFZ0VZV3JFQ0MvY1VJWXBP?=
 =?utf-8?B?bFhjNkV2WlpCbGIyUXhiTXNWN3BaalZKN3V3ZFNvaXBaa0pwVld3cXRUN3FE?=
 =?utf-8?B?RjVkcUNsM1p4Sks3YjRMQVAwNVdoaE5MeTQ4aDRoY0h6cWxJRTduOTg4N3FY?=
 =?utf-8?B?QU8xdmRVcDFoWXQ5TUZWbVRPalgzWDgzQ2xnd01DMDltcUhqRkp6azRBVVl1?=
 =?utf-8?B?MVNsWFNYVElwdEFTdHA0b0JiWEh0Zm1QNkxKQ3VicmFmS29QQXVvZ2N5SDBk?=
 =?utf-8?B?NXd3aGUrMVR0RHRCYysyVXlQZkFhMnJHRndFUWRRR3BycHEzTVZkR0tPZCtK?=
 =?utf-8?B?Wk1rWlBhM3ZuR0ZHdkxaMzZsMGJHbER5VEViSnpOMDdIZHR2VEQ3QXA2Yllk?=
 =?utf-8?B?dUhwV2RKcTVCMEl6ZWZJekZVb3IxRGgxVDFlc2ZlVC9sRGlENHpBMmpQVFBM?=
 =?utf-8?B?QnBNZ0IxNmw3VW8zQXNENVFmVnBGaGlkKzhTa0xjWDhzeXN5R3NSSHoyeGJU?=
 =?utf-8?B?dk92cHRpNU1LR2IxRUIrTlpMdjdqWTlSSjI0SENxcSs5dFJJbk5wWnJmdFNP?=
 =?utf-8?B?cDFJNXlRckZoK3VidUgwZUN0aFhOYlpwTVhPUUpCcnhIQkVqUjYvbmk5MnNn?=
 =?utf-8?B?d1QvWjJ1YlVwd3FJaVUrdlZmczhDeHpxamJIdk5DV2pORVZlOGt3WCtpcVF5?=
 =?utf-8?B?RVMrM1prb3lPOW1rQmI4WVhvcGt3UnYrYndaOVcxRDFWaTd0S0VGb2tjdEVw?=
 =?utf-8?B?YlNLRzJLVmZISGFHU1Job2JkQXRqMGxaQkhOVzRUNGt0ZTdFTTFZalFMQUV3?=
 =?utf-8?B?dUFCcHRVNlJzdjBHNHNlU1Y0OFF6OEptSHBPQ1YrTWxTWTRVdWRnSUt4QSt4?=
 =?utf-8?B?dmJMQUQxaUpPR0NXVlVERXJsY3FxaEN4TEljZDVqQmpncE5EbGQvMXFpS0U2?=
 =?utf-8?B?a3F3WWRydjJIMzFWZHVScDZwUlZjTG45OFhsWkVrMlAwbjQ1ejdadTVYY0ZG?=
 =?utf-8?B?enMxWDg5ZUc4QnM3ZVl0bzJUMzdBUXh6WXQxck55MFpzdFpvekg1YkFDQjlM?=
 =?utf-8?B?ejhERWYxdDIyUDFtb25NVytsQTM1andhN3JwMTcxU05nS3VHM1NQZCt4YWxs?=
 =?utf-8?B?SHBwYzcxNkw2aTdoVG5UaitLKzZJMVdxS2dlY0NkMUN6TXBoVEFUejlLbUFC?=
 =?utf-8?B?WkhUakJYYXpLZUhkZHV4VWVFYVBQa0Y0bFd6RC9JdXdBZWFIaFI4NU9kd1lW?=
 =?utf-8?B?NXRHbWltbDJVN1ZhRno5QWViYVpvOGJLbnNxTjNZOHk5YjBDMWdpWnZBUzZU?=
 =?utf-8?Q?Yb14nRfRoVm9EqeIn+cMwFZBYNfTpJzC+Ik+V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40E970EF4634FE4FA7B5908F838E5414@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vsxGvrSM9gtmZB4DuqG6gO8SaZLZHYr+s7lCDwnZc0nuo/Suo8FJYqcwjFN91ojqOfQF4XE/YGlt67FH1epHWCx7ioKyHOAV3kw47fvSzw/k5o/e02HM13eRyO/0ZnMdveZrTlfyCtTXWL7JwWUAAxQSgxoKyFPn8W5ufRbnKIVlK93Zr7mNe1aRLBGHq/qr8Y55s258s63xTrDMNEhkOg9OdTwKFRov4U541RVRZu9ihD1btJQRDJcrnft9oIYDqO5uvEU3Yozy9ak99cTjqRtvwvk6Qs1QkRa42XdeHUthFsLhonpGcP2s9EoynqxvgFTWTpsCijRGw2HdWkWIfw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154c5172-cf62-4990-9744-08df3124c9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 16:43:38.2310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ujMIObCMHlsLrC/rdBI1CRKyRkxgGdHZ63sHfYXNe/JU/L8AZEC+FHaW6461PmczicXxRz/HM1zwMd+toKOF9q3/9JNMk6160/nMCH9Ugnr29prZiNNBW209oEr4Enf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB371697
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiANCmFsYW46IFtzbmlwXQ0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gQ2FuIHRoZSBmaXJzdCBl
bHNlIGJyYW5jaCBpbnNpZGUgaWYgKHN1cnZpdmVfZXJyKSBldmVyIGJlIHJlYWNoZWQsIGFuZCBk
b2VzDQo+IHRoZSBzZWNvbmQgZWxzZSBicmFuY2ggbG9nIGEgbWlzbGVhZGluZyBtZXNzYWdlIG9u
IHVuc3VwcG9ydGVkIHBsYXRmb3Jtcz8NCj4gDQo+IEluIGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9z
dXJ2aXZhYmlsaXR5X21vZGUuYywNCj4geGVfc3Vydml2YWJpbGl0eV9tb2RlX2Jvb3RfZW5hYmxl
KCkgaW1tZWRpYXRlbHkgcmUtY2hlY2tzDQo+IHhlX3N1cnZpdmFiaWxpdHlfbW9kZV9pc19yZXF1
ZXN0ZWQoeGUpIGFuZCByZXR1cm5zIDAgd2hlbiBpdCBpcyBmYWxzZToNCj4gDQo+IGludCB4ZV9z
dXJ2aXZhYmlsaXR5X21vZGVfYm9vdF9lbmFibGUoc3RydWN0IHhlX2RldmljZSAqeGUpDQo+IHsN
Cj4gCXN0cnVjdCB4ZV9zdXJ2aXZhYmlsaXR5ICpzdXJ2aXZhYmlsaXR5ID0gJnhlLT5zdXJ2aXZh
YmlsaXR5Ow0KPiAJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KHhlLT5kcm0uZGV2
KTsNCj4gDQo+IAlpZiAoIXhlX3N1cnZpdmFiaWxpdHlfbW9kZV9pc19yZXF1ZXN0ZWQoeGUpKQ0K
PiAJCXJldHVybiAwOw0KPiANCj4gQW5kIHhlX3N1cnZpdmFiaWxpdHlfbW9kZV9pc19yZXF1ZXN0
ZWQoKSByZXR1cm5zIGZhbHNlIGJvdGggd2hlbg0KPiBzdXJ2aXZhYmlsaXR5IGlzIG5vdCByZXF1
ZXN0ZWQgYW5kIHdoZW4gdGhlIHBsYXRmb3JtIG9yIFZGIGRvZXMgbm90IHN1cHBvcnQNCj4gc3Vy
dml2YWJpbGl0eSBtb2RlOg0KPiANCj4gYm9vbCB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVx
dWVzdGVkKHN0cnVjdCB4ZV9kZXZpY2UgKnhlKQ0KPiB7DQo+IAkuLi4NCj4gCWlmICghSVNfREdG
WCh4ZSkgfHwgSVNfU1JJT1ZfVkYoeGUpIHx8IHhlLT5pbmZvLnBsYXRmb3JtIDwgWEVfQkFUVExF
TUFHRSkNCj4gCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiBCZWNhdXNlIHhlX3N1cnZpdmFiaWxpdHlf
bW9kZV9ib290X2VuYWJsZSgpIHJldHVybnMgMCB3aGVuZXZlcg0KPiB4ZV9zdXJ2aXZhYmlsaXR5
X21vZGVfaXNfcmVxdWVzdGVkKCkgaXMgZmFsc2U6DQo+IA0KPiAxLiBJbiB4ZV9kZXZpY2VfcHJv
YmVfZWFybHkoKSwgd2hlbiBwY29kZV9lcnIgaXMgbm9uLXplcm8gYW5kDQo+ICAgIHN1cnZpdmFs
X3JlcXVlc3RlZCBpcyBmYWxzZSwgc3Vydml2ZV9lcnIgd2lsbCBiZSAwICh1bmxlc3MgdGhlIHJl
ZHVuZGFudA0KPiAgICBzZWNvbmQgY2FsbCB0byB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVx
dWVzdGVkKCkgcmVhZHMgYSBjaGFuZ2VkDQo+ICAgIGNvbmZpZ2ZzIG9yIFBDT0RFX1NDUkFUQ0go
MCkgc3RhdGUsIGluIHdoaWNoIGNhc2Ugc3Vydml2YWJpbGl0eSB3YXMNCj4gICAgYWN0dWFsbHkg
cmVxdWVzdGVkKS4gVGhhdCBtYWtlcyB0aGUgIkVhcmx5IHBjb2RlIGVyciglcGUpLCBzdXJ2aXZh
YmlsaXR5DQo+ICAgIG5vdCByZXF1ZXN0ZWQgYW5kIHVuYXZhaWxhYmxlKCVwZSkiIGJyYW5jaCB1
bnJlYWNoYWJsZSB1bmRlciBub3JtYWwNCj4gICAgZXhlY3V0aW9uLg0KPiANCj4gMi4gT24gaW50
ZWdyYXRlZCBHUFVzLCBTUi1JT1YgVkZzLCBvciBkR1BVcyBwcmlvciB0byBYRV9CQVRUTEVNQUdF
IHdoZXJlDQo+ICAgIHN1cnZpdmFiaWxpdHkgbW9kZSBpcyB1bnN1cHBvcnRlZCAoYW5kIHdoZXJl
IHhlX2NvbmZpZ19kZXZpY2VfaXNfdmlzaWJsZSgpDQo+ICAgIGluIGRyaXZlcnMvZ3B1L2RybS94
ZS94ZV9jb25maWdmcy5jIGhpZGVzIGF0dHJfc3Vydml2YWJpbGl0eV9tb2RlKSwgYW4NCj4gICAg
ZWFybHkgcGNvZGUgZmFpbHVyZSB3aWxsIGhhdmUgc3Vydml2ZV9lcnIgPT0gMCBhbmQgc3Vydml2
YWxfcmVxdWVzdGVkID09DQo+ICAgIGZhbHNlLCBmYWxsaW5nIHRocm91Z2ggdG8gbG9nICJDb25z
aWRlciB4ZV9jb25maWdmcyIgZXZlbiB0aG91Z2ggdGhlDQo+ICAgIHN1cnZpdmFiaWxpdHlfbW9k
ZSBjb25maWdmcyBhdHRyaWJ1dGUgaXMgbm90IGF2YWlsYWJsZSBvbiB0aGF0IGRldmljZS4NCj4g
DQo+IFNob3VsZCB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfYm9vdF9lbmFibGUoKSBvciBpdHMgaGVs
cGVyIGRpc3Rpbmd1aXNoIGJldHdlZW4NCj4gInVuc3VwcG9ydGVkIiBhbmQgIm5vdCByZXF1ZXN0
ZWQiLCBhbmQgYXZvaWQgY2FsbGluZw0KPiB4ZV9zdXJ2aXZhYmlsaXR5X21vZGVfaXNfcmVxdWVz
dGVkKCkgdHdpY2U/DQo+IA0KPiANCg0KYWxhbjogU2hhc2lrbydzIHBvaW50cyBhcmUgdmFsaWQu
IGkgZG9udCB3YW50IHRvIHJlZmFjdG9yIHRoZSBvcmlnaW5hbCBjb2RlIGFuZCBjaGFuZ2UgdGhl
IGZsb3csIHNvIGknbGwgb25seSBsaW1pdA0KdGhlIG1lc3NhZ2VzIHNvIGl0cyBuZXZlciByZWZs
ZWN0aW5nIGFuIGludmFsaWQgY2FzZS4NCg==
