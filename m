Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28E8CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D557C10ECF3;
	Tue, 29 Sep 2026 06:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B2kfLSFK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E7D210ECEB;
 Tue, 29 Sep 2026 06:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790662805; x=1822198805;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Lfq+PX4V/t95dAUI0AnLGrOLCeYhdVMksaVWxdrc7e4=;
 b=B2kfLSFK3GVLysj7GUv5jWykknDvH2tYW81wreNXw68H38mPUOPuOtNw
 32vuXAfHkrV/3MlmgE2YnxQ/F27KiF6yIJI81N//DO6rWm9aQKrpVQLB9
 bbTPJBIt+2/oNP1B97WHli0zbFtfxor/KpfEDi2h0lkXdUSnePo9cBAbz
 6/7K9LSDqb8oIEboELayQtNgiPusmNafrVRzjgwo7vTZoLYLcdzl9mFy3
 4U5KJuwXhiIMCd1eOxtVtLTxyrVNu67GFzYzlPljVyro9N99qanFbAG9V
 jjogRxPrZW1cBsTB1ciF6YwfgdxKVvUANgyJocqRVgh4rwcOaJAtG3M9v Q==;
X-CSE-ConnectionGUID: 94FvGPacTs+1e+s491fzyA==
X-CSE-MsgGUID: 9injnLjjSe+iqpG5JEkXQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90415574"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90415574"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 23:20:04 -0700
X-CSE-ConnectionGUID: 4cIOL8y0TPKcIaOyUqXoyQ==
X-CSE-MsgGUID: hz1jPT8dSC6jE3/7dt/HWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="283366197"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 23:20:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 23:20:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 23:20:03 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 23:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p40dhIZWqOoW1vdSIBtkxhGWVT6laeyQLZZFAHsQ4z7PjYJ2UwbeFLPWvpQDvH1eJdsoUFQRVXSpRJull3N2i8+LFPGNzcp+ZK64GLV34gZS/zWegALOmueq02wVz/g7uDDK3+FDLUXyptmc0vx9zPZHLFgYPJp5Adr3dZbG9l78NR+na5cVR1cKilhkhT0kFlZwc79AWlZlTdzxQTXUcg+J5AZCpjdpA2QmTo8sxtIPz7i8gkVwPnEsHlYil9SZhaO1x/KaLjkVY4hE5BquDlmwq/zGHMGF/xgKw2TOLN8iJDnKHacFMKUYDM+tlRr7+EvsZiZQh+Gcdw5o99LamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfq+PX4V/t95dAUI0AnLGrOLCeYhdVMksaVWxdrc7e4=;
 b=lHPNkakbyOYjj2YR8hE3vy9HJHEvBOGpJ7+K3ejrTcAG8D311VxIal0cdlS3Ng7U72TtOpXpEqi5E4RyLcrPxpOB/hKnFShTN1OFOILE+oYmHJDaIgXXOB8KuVSaddogWN7MupYqZ150VrotluQ7FuDxgOyFMZeJF/GZ02G5jm4ojR3ZD1EjqI6xExYQJ0q4GczZ6jJzHuR+3bJrR/+NkEE5oi+BCe+OxqMovyJuwOTcsucrBv62Domd2Ijtbntxug3xxHxuf3drFJevqPLqHPyVBPEDAAAaFkv7AXbziZErfqaFU3+V2ml65c9jGmCtYoimttTmRGd7wyOl+b4WBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 06:20:01 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 06:20:01 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v6 07/18] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Topic: [PATCH v6 07/18] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
Thread-Index: AQHdRUGPylj2ezHKzE2xQuO8ZUExo7blKpiA
Date: Tue, 29 Sep 2026 06:20:01 +0000
Message-ID: <8af383a7c8b8e3bea15b68517d15492975d2b1ef.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-8-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-8-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|MW3PR11MB4619:EE_
x-ms-office365-filtering-correlation-id: 6a739512-a7bc-4f16-395a-08df1df1b199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: KtZ8khapo+mw6NlG3rxs5r2axCprPyXcTNcRPxv54TBT6KvCKGvt0jyz9SqHP91Gse9z3QAeA2nkAWkwXjnmAWb6tE7xniQ98xkJoVOxlDSD9pENauT3qEJCn24Nf1mtufP1qC2wJAtZvWuAvEZgW5e/c9eePExfcWH9KXkbpDZKQfnAAl/dtmJj1fGAl6nwd36wwkAAI4sFwfbE5PrYqR88Llhf2YP7awLGz1l8LMMtumqgAPO63erphoLmXGLVhImB0da3qzuGwAyW97OPnJu9KzRHC+mEt++KNDDAjW6zuv2fXgF4My1PNStuuqPWxzv9efCzfzmNT9QAIwCTo3ntF3vTyS0UUa1i0GcP9tfYQL0A7qUFzYRU6ML2F4bSUF1B21Id8gfbWOwTGZ86Ef30h6g4Jq4qKf8PqQqchnIcxsU8IvCWPbUvNcZQWWt/ZRrMztVLQl5u1svjC0kUBlOxaJ3HckVG7FWnkSzAna8EzsPOy4GSVrRvlWpHXG52MP4OzYBUfE8XEP38u/f0SOj9pfTqa14qU4OgFKUC5b/fI8UhqGObVrisczK0ocSeCpLFYpIPnHylEdYJVfzPeIaIbnE/20kHZe1puQXoL4VaGT2/Y1mp1rnldnrFlN7C4PHnNL7b6GoUjgXocRxUMYqMya+8fLoWU6zU3pGUOwMKDAV+0YmzOL9LdhH+GspvKl7qSsaDNl4WJGnyDj7TVKdf9Uow4fHcaZQ4Sw4o15g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0d1UGhoNEtUVHREbGlEd2RDVU84SlV3U0tiQTViSzhyeFJ3YnpZUGF4czZE?=
 =?utf-8?B?a3UwdTNIS1pEMGRleEx6aGU1Y0pQdCtrV082ZVpmZnJIMFl0Ly9QeTJ3M05v?=
 =?utf-8?B?UWRLNGMzSkJja2kvSXR2TFBpNTJRYTFRMWNrZWRDano5eWhjcThxUlhCRlNN?=
 =?utf-8?B?UnZ0STBXV2h4eEpTd0FrSFlyVEJQdW9JcnlmdWZNNjYxMEkzUWszOUJuS25E?=
 =?utf-8?B?L09Nd1ZNdUtlNTVLVStnWVh3T0VnWHR1WDB2dG9CdGs1YkR6MkRIWDZyQ1I3?=
 =?utf-8?B?RS9OajlTYmQ3U3M0bnU2Wm9oM3IwTzFhT1pRZHRsdVBjWnc1TzZLZVVYU0dL?=
 =?utf-8?B?MjlSNnhHdE9GM2o4VnFmcFRnYWp1YkFvbzRpSDF6ekhxU3phT0xMa2RoOE50?=
 =?utf-8?B?aVIxZUFVdXR3QUVmamNhVXRscWlqU3pDRVpKL0JBdStyR2V3b2YwamxWcEVO?=
 =?utf-8?B?TkpCVE80dFdaaTJqSzlsT0Fsd3BMUTA3S0lYTE1yQXFKUG5RMFpxb3E5RmlV?=
 =?utf-8?B?eUMzOWRNZTFlV2QwcFl0M1BKdGRDOU1BSWV3RlJUNzhUZkxweTg0eC9BUkl5?=
 =?utf-8?B?WFdlQU9SUGFsaHMrNkRXSWlCVUZtOHA2ZUpUaEZJTU90ZVJIdEZFSlBuS3V1?=
 =?utf-8?B?RkhtSU9IYTc1ZHZmU3NrVzNiUE54YmZ1Q1J5UmE4ck1pelBNWldTU3N4aTBl?=
 =?utf-8?B?YnpraVZyamlnRWU3cHJJSXNMaGwxS0dpWmtSMkFzOEZOejUwbFN2RUxRNzlZ?=
 =?utf-8?B?UjcyS3poT05TalJLcTMzUG1Tem05SEFreU9zTldZYjlXUzFMMFk4TWM4RjRh?=
 =?utf-8?B?eVdxOTkzcWg2YnVaVnc0VnQrT1pvd1BtWWdHcjZuM0JyZHlIMDBvUnEzMTRO?=
 =?utf-8?B?YzNxVStpL1lyVkJBd3RTOGxEQjN1OTB6a2tNUVFnRGNjeHhkeE1RVUV3MUhN?=
 =?utf-8?B?dE5WemVJSnp6bmdCQVNSTkQxd2t2MW0rN2owQXF1OWR5WjZwbDNkdkRDYnBx?=
 =?utf-8?B?RmpsQWFaLzJ1RWtySEQ1YXN5MGgrLzF6RUVHN29WK1ZqbFlSOHVaMlpCb1dW?=
 =?utf-8?B?enhBZHRaRGlDL2Vqbnh4cUxkOHU0c1d5M1lxZEt6cTBndHRuM0dFekU2akgz?=
 =?utf-8?B?UW4zaWdCbEpXdmFFR2Z2ellxNG4wUWVoTXQ5M2cyMEY4M1VPR0ltbU1XeEFw?=
 =?utf-8?B?VjVOYjQwc2libzNwbUo5bGhRUUFUaWFrREhlK0VrR2J6RXJGOHk4NWJXWUt4?=
 =?utf-8?B?QXA2U1lwaEsxUTJGbEx4NkdOWEtHbkNnVE14MjQwUTljNTB1UE5VckFJUTBn?=
 =?utf-8?B?YkV0d2d4M1dBcEVkMUhObmRJVFVwK3NnelNwS2tRMVIzTU01ZTNwZ2Q3QnE5?=
 =?utf-8?B?bitEb2JCMFJYRnQ5aE5kYk9hU0V4QUhBL1grNzRPNEJZaWZoZnkyT3c0R0JJ?=
 =?utf-8?B?bktKODhLMXVhb2NDMzVnaVpmMG5NSndmNXpudDRvUzQ2a1VYOVppU2VjWXkw?=
 =?utf-8?B?MmVieE1KMEtDZzljbVR4S3hSZHovYWZuRnFWcWpoUHIrbmsyZll3VHB6SW1D?=
 =?utf-8?B?RVZHc045SlEvYzNqK2VHN1pVdFJyQnNSOGUybjZrcFBkemFDazEzbkF6a2Mw?=
 =?utf-8?B?UDg5VUdoTS83cWFXY0tDanNSRHBieEVoNk1VWnBoNFBJRkdwcmJ0SVN2S0lm?=
 =?utf-8?B?bEFGc2hLS1pEQnNpNFU4NWg3S29Sb0JKcHBSVElvcTVSWUpSZ3FLS2c2NWJ6?=
 =?utf-8?B?cUpzZzRnQlAwLzU0SDVVOVZWWGZVblRQRFNiaEFDWi82SHdDUktYZE1yU0RO?=
 =?utf-8?B?bnRKTUtHY1ZPL1lKUklweUdTZVFpNDNrRlRSZjNsdWdaazQ1TStNd3ptRFNB?=
 =?utf-8?B?bFg0M2ZteUpwMWZZQzAvSlpUcnl3eWtiTUNyT1czcytCdW0vYklMR1FUREtt?=
 =?utf-8?B?MUxnSWNoMXNZeG9CQU5BbWxhRXNIWUJQK1dxeFI1blNOajAzdkV3bzVUR1lN?=
 =?utf-8?B?aUpiem9qZmpscUZqNkdxOHFBQ1RpS3hlU21sTnFYR3M5c1VQMXhxMWJhRlMx?=
 =?utf-8?B?eHJ4N3VnV0txRVlFSjFpWmI2eVJsdVJLditlclEyWUZCbEN1Rm4zVTFYVG9Z?=
 =?utf-8?B?RlUxa3dxbkNQV2JKekNFUUExVUlCVUhqUmpiaWdvYS83RDFSMkZqRTRMdVY4?=
 =?utf-8?B?cUltS01PU1dLUi9CUVovUWVsa0FFbkRlNkhTYkVUNWMzcXVOVWc0VHEyY0xk?=
 =?utf-8?B?SmozOU80ampmZTNBQXpIRTNpazYwZkoyUkpDRE50bjBrL3E1NkVkeXRQZEN4?=
 =?utf-8?B?SzdaNkhqYWZDYnMxQUE2U2I5QnVLWGM5R081YUM3U3FuNlRsVlNzMVk1SjZt?=
 =?utf-8?Q?cIamgvK0sqHgB88M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D9273F1AFD9FB499483340B8B0056B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tQ+cdjvomYERgSG8j6/KVAfrOJ+LV/5TgkQ1ABoGuK523/902d1yFoMZPC2dR100vYCpzjjq8FOI+wpfAkRORztM+CJkuuNMZN1ME58pMMjGZFDKmy9xJBpuxaK5Zw0EjCizOLMKP7hUKVxXus54l551G26sPtsUkst02pRkbVlfcNGrtFaf82E/K3B/rzsUj6hssAd5ZYUK4NmWBYZhDVAvA7EhHlc1QmnXKwV5GCkgWz8/t8tbib7aD/yXdHnl1vbdTPoUOukWoyeF6XfrMvJTnKsKZQLFB2kDlHGrvxyC5uz1/3HrNBjtdB2gkCWSPEGxqpBr1F6rmC2aURorXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a739512-a7bc-4f16-395a-08df1df1b199
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 06:20:01.2738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qz8t1UZrjoT/Vs0lp7Pf30FCnhzFLu1dP5VRMgs1fAykS7+Cc5gWBfKfie3Gwl3kzYRtvTg1p9GvjoVU2q6jWnEojZgcp/SenxJUDiK3xxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
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
PiBUaGUgQVVYX0xFU1NfV0FLRV9USU1FIGJpdGZpZWxkIGluIEFMUE1fQ1RMIGlzIHdpZGVuZWQg
ZnJvbSA2IGJpdHMgdG8NCj4gOCBiaXRzIHN0YXJ0aW5nIGZyb20geGUzbHBkIChkaXNwbGF5IHZl
cnNpb24gMzUpLiBBZGQgdGhlIHJlZ2lzdGVyDQo+IG1hc2sNCj4gYW5kIGZpZWxkIG1hY3JvIGZv
ciB0aGUgd2lkZXIgYml0ZmllbGQgYW5kIHByb2dyYW0gdGhlIHdha2UgdGltZQ0KPiB1c2luZw0K
PiB0aGUgYXBwcm9wcmlhdGUgbWFjcm8gYmFzZWQgb24gdGhlIGRpc3BsYXkgdmVyc2lvbi4NCj4g
DQo+IHYyOiBNb2RpZnkgQVVYX0xFU1NfV0FLRV9USU1FIGJpdGZpZWxkIGZvciB4ZTNscGQuIFtT
dXJhal0NCj4gdjM6IFNlcGFyYXRlIG91dCBBVVhfTEVTU19XQUtFX1RJTUUgYml0ZmllbGQgY2hh
bmdlIGludG8gaXRzIG93bg0KPiBwYXRjaC4gW0pvdW5pXQ0KPiANCj4gQnNwZWM6IDcxNDc3DQo+
IENjOiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogQW5pbWVzaCBNYW5uYSA8YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+IC0tLQ0K
PiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jwqDCoMKgwqAgfCA4
ICsrKysrKy0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3JfcmVn
cy5oIHwgMiArKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkv
aW50ZWxfYWxwbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBt
LmMNCj4gaW5kZXggOTI0ZmE4ZGQ0NjM4Li5kYzAyNTA1OGE2MjYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5jDQo+IEBAIC02MTAsOCArNjEwLDEyIEBA
IHN0YXRpYyB2b2lkIGxubF9hbHBtX2NvbmZpZ3VyZShzdHJ1Y3QgaW50ZWxfZHANCj4gKmludGVs
X2RwLA0KPiDCoAlpZiAoaW50ZWxfYWxwbV9pc19hbHBtX2F1eF9sZXNzKGludGVsX2RwLCBjcnRj
X3N0YXRlKSkgew0KPiDCoAkJYWxwbV9jdGwgPSBBTFBNX0NUTF9BTFBNX0VOQUJMRSB8DQo+IMKg
CQkJQUxQTV9DVExfQUxQTV9BVVhfTEVTU19FTkFCTEUgfA0KPiAtCQkJQUxQTV9DVExfQVVYX0xF
U1NfU0xFRVBfSE9MRF9USU1FXzUwX1NZTUJPTFMNCj4gfA0KPiAtCQkJQUxQTV9DVExfQVVYX0xF
U1NfV0FLRV9USU1FKGNydGNfc3RhdGUtDQo+ID5hbHBtX3N0YXRlLmF1eF9sZXNzX3dha2VfbGlu
ZXMpOw0KPiArCQkJQUxQTV9DVExfQVVYX0xFU1NfU0xFRVBfSE9MRF9USU1FXzUwX1NZTUJPTFMN
Cj4gOw0KPiArDQo+ICsJCWlmIChESVNQTEFZX1ZFUihkaXNwbGF5KSA8IDM1KQ0KPiArCQkJYWxw
bV9jdGwgfD0NCj4gQUxQTV9DVExfQVVYX0xFU1NfV0FLRV9USU1FKGNydGNfc3RhdGUtDQo+ID5h
bHBtX3N0YXRlLmF1eF9sZXNzX3dha2VfbGluZXMpOw0KPiArCQllbHNlDQo+ICsJCQlhbHBtX2N0
bCB8PQ0KPiBBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUVfWEUzTFBEKGNydGNfc3RhdGUtDQo+
ID5hbHBtX3N0YXRlLmF1eF9sZXNzX3dha2VfbGluZXMpOw0KDQpZb3Ugc2hvdWxkIG1vZGlmeSBf
bG5sX2NvbXB1dGVfYXV4X2xlc3Nfd2FrZV90aW1lIHRvIHRha2UgdGhpcyBjaGFuZ2UNCmludG8g
YWNjb3VudC4NCg0KQlIsDQpKb3VuaSBIw7ZnYW5kZXINCg0KPiDCoA0KPiDCoAkJaWYgKGludGVs
X2RwLT5hc19zZHBfc3VwcG9ydGVkKQ0KPiDCoAkJCWludGVsX2FscG1fY29uZmlndXJlX3ByX2Fz
X3NkcChpbnRlbF9kcCwNCj4gY3J0Y19zdGF0ZSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzcl9yZWdzLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX3Bzcl9yZWdzLmgNCj4gaW5kZXggYmI1NzdlN2UzYmJkLi4wMTZj
ZTI0OTQ0ZGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfcHNyX3JlZ3MuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVs
X3Bzcl9yZWdzLmgNCj4gQEAgLTMwMSw3ICszMDEsOSBAQA0KPiDCoCNkZWZpbmXCoCBBTFBNX0NU
TF9FWFRFTkRFRF9GQVNUX1dBS0VfTUlOX0xJTkVTCQk1DQo+IMKgI2RlZmluZcKgDQo+IEFMUE1f
Q1RMX0VYVEVOREVEX0ZBU1RfV0FLRV9USU1FKGxpbmVzKQlSRUdfRklFTERfUFJFUChBTFBNX0NU
TF9FWFRFTkRFRF9GQVNUX1dBS0VfVElNRV9NQVNLLChsaW5lcyktQUxQTV9DVExfRVhURU5ERURf
RkFTVF9XQUtFX01JTl9MSU5FUykNCj4gwqAjZGVmaW5lwqANCj4gQUxQTV9DVExfQVVYX0xFU1Nf
V0FLRV9USU1FX01BU0sJCVJFR19HRU5NQVNLKDUsIDApDQo+ICsjZGVmaW5lwqANCj4gQUxQTV9D
VExfQVVYX0xFU1NfV0FLRV9USU1FX01BU0tfWEUzTFBECVJFR19HRU5NQVNLKDcsIDApDQo+IMKg
I2RlZmluZcKgDQo+IEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRSh2YWwpCQlSRUdfRklFTERf
UFJFUChBTFBNX0NUTF9BVVhfTEVTU19XQUtFX1RJTUVfTUFTSyx2YWwpDQo+ICsjZGVmaW5lwqAN
Cj4gQUxQTV9DVExfQVVYX0xFU1NfV0FLRV9USU1FX1hFM0xQRCh2YWwpCVJFR19GSUVMRF9QUkVQ
KEFMUE1fQ1RMX0FVWF9MRVNTX1dBS0VfVElNRV9NQVNLX1hFM0xQRCx2YWwpDQoNCj4gwqANCj4g
wqAjZGVmaW5lIF9BTFBNX0NUTDJfQQkweDYwOTU0DQo+IMKgI2RlZmluZSBBTFBNX0NUTDIoZGV2
X3ByaXYsIHRyYW4pCV9NTUlPX1RSQU5TMihkZXZfcHJpdiwgdHJhbiwNCj4gX0FMUE1fQ1RMMl9B
KQ0KDQo=
