Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE48CA5FA4
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D7F10E87F;
	Mon, 28 Sep 2026 09:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Rgxu/buZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A68610E099;
 Mon, 28 Sep 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790589500; x=1822125500;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+HrUwwIhzfKMzrCn7ExP6wFbIrXchKgTppdO/Jal4jk=;
 b=Rgxu/buZh/a3EnO64eUx0R+BwwlJUEJdI5Ns0BKkZstG4M764hTPJTpX
 Fdf7DgaBznHLeJAj/Rsr6iloBL0I47XuxH6tGok7u/bCX7Gdlan6+XxMO
 79JFYtDY/cDQsrVjJjuivN6QI+B6gf2tuOLVFa4TCugQGWWymBFPHochg
 lmAKEC6aizbWLZZSCk8RzcZcoEHaggqYWbdNKDOqS7EK38QCp/cPKsjy0
 2ZLRsa7Ln/ThRRSPF9y1HFxX26SFdMJm1ZFpzOTzTGSel68GmdK1WCh4w
 +fTJ2e/e54gR+eKGyq3EpEiOh5n/3r5LV69wutoohFLc/OyplNXBDNHPH g==;
X-CSE-ConnectionGUID: YkSVDs8qRxKyRi1bur4gIQ==
X-CSE-MsgGUID: 2Wfa6mOVT76NiKvmXT6INg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90411770"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90411770"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 02:58:19 -0700
X-CSE-ConnectionGUID: 4dwKhNqyTjikDnR6sdYDSg==
X-CSE-MsgGUID: noAV51p8QtGZrVhprI02QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="275135348"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 02:58:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 02:58:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 02:58:19 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 02:58:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efCt//TfZdfcMSvdTcQOalWKQj48LySy8eQhF/IwWl90adl1RWVFi3TfSQajn6QXbaivyEGxfrsQCs7fzQhz+uRt5OL7aemSVbnkJKWDrGP7F3DXqEPvgk5XJcYL8RdZHpf64SDz8wLGgQEbFXfomO0sYfKau5B1EyUef7kxtQXXSycy53ovzaT+wnI4QeUW7EmV5m18ClvdIjhsG8TPabqMfzfxPNIBm5Uj2W4miVu677SzPGQAAYhcuGi6OGHrYTfFiqRPKJ0ZNM5QgLW7uuloGmRIDmeXm7QxJ21FyMtNEeoNjaF3fvUckYyWxDtqwUo1KzrEXdKLk16SroO4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HrUwwIhzfKMzrCn7ExP6wFbIrXchKgTppdO/Jal4jk=;
 b=v4uHY2i//HVd/v8JRl1wCmGYkddKO6TgSUWAxMlHuvyB2ln/YZi19y24Zg8Aexu8K70vaGc6zV8P+llRAYI90cbhipvJLIwLjP4D3M+zeSIFRsrpoghiaINlYPNhoDD39v/Rxac7xk6Uc8QNOhAdlReEBTiPXwPXRTjm7zywxU01IEhrRK1TQKT2TGlPK5UawqjgWI2ZLojyl6XiBJc0YoMHGMOf3XBTr/z4RYSCFu9jZcdPkFILcqfO70trOqPDUgV6oyTOCNLl9wv1bYdAT6w/zoNw7heIWYJDWqdeCAsVOkqHhiXSk+j88Go3Xh/FNJ2COUQatFiUzLt7GbdKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CHAPR11MB9631.namprd11.prod.outlook.com (2603:10b6:610:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 09:58:12 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:58:11 +0000
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
Thread-Index: AQHdRUGFXVXfGy64UkS81TVA42Hu1rbj1TiA
Date: Mon, 28 Sep 2026 09:58:11 +0000
Message-ID: <befabf4be95ed6e5d62aa77a89a8689134d7d64c.camel@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-3-animesh.manna@intel.com>
In-Reply-To: <20260915180449.277933-3-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CHAPR11MB9631:EE_
x-ms-office365-filtering-correlation-id: 65f7f0b2-1976-4823-7e1b-08df1d4701b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: LLoscxtppygrYuV43Ce/FmeNBsG+a4CiPP2MPqWfaGdSS8YdFADQZqpgJlQbfzQdB5L3/LtEsIqHW/HxKFDIpU2IB3tLSvq8Q/tFuf3bP13DzQPtInWribBp4pPiU37rDs3hQcLugma2+QtHLa1b4SKxwDTLKAgLt/ZGSrTcTWbIhWH5e5LG5my1imc34zn4N6ITQC0Io/nOUkB8FmTPMyNRNWw1pZXjwbizI4siHUE03kDKeqaS5SZLjASIkSydtCUD8UlLtVUJrO5iZdAL2gmDI7EibrzQdk0gQT3HJW59q0CQ8gLRSVfrXNoFQA4LN841JF0e37BblYQ7AcGD1QPd0PEuPYJMp1zgfrOxT7DdtwWx+iAFfgs1XNrrLlLPNzgGd0U2OcZRcKQdEx/jWSfYQiLB8Msu+d0ZEryd/MAJlZbrOWjso2YFgMoOp7upmG1vJcdZjWnRf5LUAWDCQu5vCjfh5+rBoF2R4vgSsp950+jdw8k1Le9iQIhXsoVawNcIBSUYT3SByFybbaYi6vieQMA2t6KANo3yeeSSj9hR/BAw0/pHPm35tj8mBZgH2FvNJOezCSFZymdeWwXvJIrkoA41nuDjUSRjizCUrbHfVFCYHdGNCHWqFJNKd5AkvkOSYmbkJQy4X6vCKeXnuvLI5My+lf45FX2sYfRZuBGqpp7L0X76KDMTXAP0WjMcSgzqN00sDcaoyUR+v2b60uXNKdSc5N4ZjiquCcUiXaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RE1WRVZsWTRSNGx4RnZpTDhCcEx1R01uV29wV1I5RXl3eFQ2TTZpY1JKS2JE?=
 =?utf-8?B?T2RGNVBCTEE3QytMdTQ2R1BoTU04NUFwSUh2K2ROczlqUUFvN2J3VmxUa1JJ?=
 =?utf-8?B?UEpwUTN6QWxPQ0N3T0pXL3lucVJYK25xRmJjdVdtSmk3QU9GclhERzVrOWNu?=
 =?utf-8?B?dEpsUGZ1SzRoZEtGd0ZOTTNrT1VGaWZnc2dRQlFJc28rUlI2VUplNkY4Qlc5?=
 =?utf-8?B?eEd0ampjNE5KdmRWeW54bUhBeDVLWktJVG5YS2lWaWhHOU4wTE5DQU42NkdS?=
 =?utf-8?B?NnRwblhBUlAxOHphMnZ2c0ZyMFJPUGZaT1FHazQwNWJubFFSS1U1bjZnS2VH?=
 =?utf-8?B?RS9pVDBMRWpiV0NtUDNubU93Uk4yemFLdlZkekdrcSs3WHdodUNzZFFieDRP?=
 =?utf-8?B?OXBZaUREUTZEeXpOWURDRHhnVko4WHg5QThZQ1prTzVLSCtBWmJKOUU4dExZ?=
 =?utf-8?B?dkFZOS85QlhrWFhvYlI0ZmhrUkpRb0tqc1ZUNDBYVGhlRWt1Uk4yZTJGWEM4?=
 =?utf-8?B?dXdiMTI4djRuSXlySUdZYUliTnI1WkJKYnczUG1aOTJsVTc4R1A2cmlRM00v?=
 =?utf-8?B?S01LN1RndjhsbHFyOVhFMkFVNERncGhxeXNCZU1oOCtObTk3eWJlZnkzWVM3?=
 =?utf-8?B?SVc2UjczL3dEWDN2dnh6ZUVhaFozZHVLKzBEcXRsL0daUHFhVW9ITjRpcjN2?=
 =?utf-8?B?WnI5aUJVUS90WkRkMk1IZ2QwR1hQTmhERnlzWGNjaVhsQjhxd3Z5SjFlUnZR?=
 =?utf-8?B?S3ZJdFNVbTBnay9KQ1haRUtMOXBDTnVJYTZQRzZka0NLZ2VrWEo0QlBqMmVs?=
 =?utf-8?B?MFRlTEo5RWlVZDB4b1g1c3dKRFpuZW1SbjJSUys3UE8vaUxSWEpqbk9QaVhu?=
 =?utf-8?B?cnlSdDJWOXdkQkR5Z3FNWXpIZlhEcEZQYzEzR1BWTGxBOXNkdHYvSHFZZW1y?=
 =?utf-8?B?L05KcG1rTWpNeW9zZ2dZelA0ZHVMR3hkZHVKL01EOG9aUkFVV0dKNWhGV3dD?=
 =?utf-8?B?WFJrUXdmMlhUWmVBMXFTck1wcTFvRFZlQTJjMXJqV05QUTc1VGd3TDFWaWZw?=
 =?utf-8?B?aGpMWU9zM2ZYMzU5MmRreCthak9XL2RGT1ZHK1JqalQxN0t5L01jam5iQ1c4?=
 =?utf-8?B?NC9FQ1paNVhIM21mbjJ2b0p1aHBjRXdMaUlTekFGQ1RnM0Qzdm14WGFMeXF5?=
 =?utf-8?B?OWxlTktsVDR6VE91STk2dlV5VkN5RXd2SENSMGs1L1RxWnptQVhYeDZKdTRP?=
 =?utf-8?B?OTJoVVNVK3NzSWJWSXVaUmZobDJTN1JpckFhRWtGaGNQUUU3ZzhvUW9hZWpB?=
 =?utf-8?B?RjNlbEZjSTYycFRaSWZybDJOdndaTTNFdjNhYWZZSWhoVGE5MHBZQk1GbGx6?=
 =?utf-8?B?QnV4TzU5T1BzN3Bxb0V0ZkhONXBpcTJ3bHgwV050U1Fxa0NSdFhyWXVQOEVI?=
 =?utf-8?B?ajRMRzNrZDlPdzZqTzlJVWRjbUVXTEd4QWpPTzhhcXE5TGdBUHp3SmJNN2w3?=
 =?utf-8?B?RStuY3d1eWM4RzhLeUR4eXRTcHNEOTFxeFk5TkVib1puejdXK2RpRU5HUXg5?=
 =?utf-8?B?VTdOanB4US8yYWZGY2IwUWlocFFPUDMyUVd6UDhMRmhoWTQ0dDM2M3FBa2NY?=
 =?utf-8?B?T2tncUE1cU1Ed2dIcVBGeTllTzg0S21SN2k5YzNYS3p5QVBKelc4OU0wTXFE?=
 =?utf-8?B?RG9pV2JnRTFXTDNwdEF4V0lqOFh0S3BFbzd0ZDV6bnltMkZYOFFJWUFWWjh1?=
 =?utf-8?B?ZVQ5RzBjZUJyWmQzT2FnYUZuZzlkRkxOcC9qbVFaQ1lJOWVnZGdEbkFoWnps?=
 =?utf-8?B?Nm8rYTFPOWFodjRndzFjbWZNNVh1Z3FPTVZVbnRmZlZpY0RDei85aHlsQUln?=
 =?utf-8?B?NEpkaHpjYmdxaHdCRDNnSE1HMlQydk1pM1B6MG9MY1BKdW10RDNGelFwRkhD?=
 =?utf-8?B?U3djNHZ6WWJwby84YmJZTXZqY095SmcvNVRYVnFXOEcybGRWZzlHb1ptU3NB?=
 =?utf-8?B?enJJUTZvSVFsbkpsdW9iOCsrVUMydy8xU3BJcVA2QnpPZGtnZFVyeERtMWox?=
 =?utf-8?B?V3Rna0RQdGRwOXE5L2l1Y25kZG14dHpjMVpxMExqb25HY0hPK3JTSlJNaEZr?=
 =?utf-8?B?VGY4UXBjYTNNbE0vNjd0V0xONjFFeUdzbjlxK21wa2lnbWRHbmpSL01yN01j?=
 =?utf-8?B?L3B6cng3b1VjdjlLVDNuTDVKZlB2NFJlbDJZcGd2ZStyZ0QwNVlWZ2dsYVhm?=
 =?utf-8?B?QWYwT1VJTWxnZjFxSncrQnZFRWt2OTJWVG1PVGl5T0tBTDVVd1VGYUpTNG52?=
 =?utf-8?B?bnlQMk1HVGNwZmdqak5KVEo4aWZEek5lcS9JUXRydjZZOUczRmUvTjE1ckpO?=
 =?utf-8?Q?poKMfNEgpzVeEwsM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F65D8C689991B458857138D38EEF7B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aL0iH6vuOHuxY/RJgNvadW6UP64XHLj+KWt6ppVzQl07bSiU0pq7Jl/c0IWsLOaoXmgORLNtr8iV3/uJ/A6UXTYJOInszyS2BOTcfKLNNZpCuxVRjIKqDzcit8MyEP0fNQanL3lthN5qM8NZuUY8RWae1HmWVOVwCaxlznE+iV59cg5RsNWhBmG40EL+3zlWrtJXJOPOqj6bmK0hQ9FehXflW0a2bd9bf11DePmhoaPLTRfQq718utwvMgpzE4ceONip7n/rYxPJjiU3ubOr1erjchsMUA+7IdLRdOg9BGPFQFqkXvI5Tw4XXOUtKK0UT6v/tzZWZDom474s/6j3bg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f7f0b2-1976-4823-7e1b-08df1d4701b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:58:11.7725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNmC9R3ryGS8cz7TjYvCOa1XsOJRjcm0onz1EXZ6F8eqWVqlfh0ejdascgKwhNECbGMdownsuKDlXCmRFWf91BigyA/YBTZptkz8Ju1VduY=
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

T24gVHVlLCAyMDI2LTA5LTE1IGF0IDIzOjM0ICswNTMwLCBBbmltZXNoIE1hbm5hIHdyb3RlOg0K
PiBBYnN0cmFjdCBBTFBNIERQQ0QgaW5pdGlhbGl6YXRpb24gaW50byBpdHMgb3duIGZ1bmN0aW9u
Lg0KPiANCj4gdjI6DQo+IC0gSW1wcm92ZSBjb21taXQgZGVzY3JpcHRpb24uIFtTdXJhaiwgSm91
bmldDQo+IA0KPiBDYzogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEFuaW1lc2ggTWFubmEgPGFuaW1lc2gubWFubmFAaW50ZWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5j
b20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBt
LmMgfCAxMSArKysrKysrKysrKw0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5oIHzCoCAxICsNCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVs
X2RwLmPCoMKgIHzCoCA2ICstLS0tLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfYWxwbS5jDQo+IGluZGV4IDEwOTQzNTM5YmM3Yy4uYTY3NDNmZTYyZDQ4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtNDMs
NiArNDMsMTcgQEAgYm9vbCBpbnRlbF9hbHBtX2lzX2FscG1fYXV4X2xlc3Moc3RydWN0IGludGVs
X2RwDQo+ICppbnRlbF9kcCwNCj4gwqAJCShjcnRjX3N0YXRlLT5oYXNfbG9iZiAmJg0KPiBpbnRl
bF9hbHBtX2F1eF9sZXNzX3dha2Vfc3VwcG9ydGVkKGludGVsX2RwKSk7DQo+IMKgfQ0KPiDCoA0K
PiArYm9vbCBpbnRlbF9hbHBtX2luaXRfZHBjZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKQ0K
PiArew0KPiArCXU4IGRwY2Q7DQo+ICsNCj4gKwlpZiAoZHJtX2RwX2RwY2RfcmVhZF9ieXRlKCZp
bnRlbF9kcC0+YXV4LA0KPiBEUF9SRUNFSVZFUl9BTFBNX0NBUCwgJmRwY2QpIDwgMCkNCj4gKwkJ
cmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJaW50ZWxfZHAtPmFscG1fZHBjZCA9IGRwY2Q7DQo+ICsJ
cmV0dXJuIHRydWU7DQo+ICt9DQo+ICsNCj4gwqB2b2lkIGludGVsX2FscG1faW5pdChzdHJ1Y3Qg
aW50ZWxfZHAgKmludGVsX2RwKQ0KPiDCoHsNCj4gwqAJbXV0ZXhfaW5pdCgmaW50ZWxfZHAtPmFs
cG0ubG9jayk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2FscG0uaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfYWxwbS5o
DQo+IGluZGV4IGY4ZjYwNWQ5NGY5Ni4uNTZjM2UxNDgyZTM3IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uaA0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uaA0KPiBAQCAtMTUsNiArMTUsNyBAQCBzdHJ1
Y3QgaW50ZWxfY29ubmVjdG9yOw0KPiDCoHN0cnVjdCBpbnRlbF9hdG9taWNfc3RhdGU7DQo+IMKg
c3RydWN0IGludGVsX2NydGM7DQo+IMKgDQo+ICtib29sIGludGVsX2FscG1faW5pdF9kcGNkKHN0
cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApOw0KPiDCoHZvaWQgaW50ZWxfYWxwbV9pbml0KHN0cnVj
dCBpbnRlbF9kcCAqaW50ZWxfZHApOw0KPiDCoGJvb2wgaW50ZWxfYWxwbV9jb21wdXRlX3BhcmFt
cyhzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwLA0KPiDCoAkJCcKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
aW50ZWxfY3J0Y19zdGF0ZSAqY3J0Y19zdGF0ZSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2RwLmMNCj4gaW5kZXggMGNkNWU2YjUwMzRjLi42NTBjOGIzOTI3MGIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwLmMNCj4gQEAgLTQ3ODMs
NyArNDc4Myw2IEBAIHN0YXRpYyBib29sDQo+IMKgaW50ZWxfZWRwX2luaXRfZHBjZChzdHJ1Y3Qg
aW50ZWxfZHAgKmludGVsX2RwLCBzdHJ1Y3QNCj4gaW50ZWxfY29ubmVjdG9yICpjb25uZWN0b3Ip
DQo+IMKgew0KPiDCoAlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9IHRvX2ludGVsX2Rp
c3BsYXkoaW50ZWxfZHApOw0KPiAtCWludCByZXQ7DQo+IMKgCXU4IGRwcng7DQo+IMKgDQo+IMKg
CS8qIHRoaXMgZnVuY3Rpb24gaXMgbWVhbnQgdG8gYmUgY2FsbGVkIG9ubHkgb25jZSAqLw0KPiBA
QCAtNDgyOSwxMCArNDgyOCw3IEBAIGludGVsX2VkcF9pbml0X2RwY2Qoc3RydWN0IGludGVsX2Rw
ICppbnRlbF9kcCwNCj4gc3RydWN0IGludGVsX2Nvbm5lY3RvciAqY29ubmVjdG9yDQo+IMKgCSAq
Lw0KPiDCoAlpbnRlbF9kcF9pbml0X3NvdXJjZV9vdWkoaW50ZWxfZHApOw0KPiDCoA0KPiAtCS8q
IFJlYWQgdGhlIEFMUE0gRFBDRCBjYXBzICovDQo+IC0JcmV0ID0gZHJtX2RwX2RwY2RfcmVhZF9i
eXRlKCZpbnRlbF9kcC0+YXV4LA0KPiBEUF9SRUNFSVZFUl9BTFBNX0NBUCwNCj4gLQkJCQnCoMKg
wqAgJmludGVsX2RwLT5hbHBtX2RwY2QpOw0KPiAtCWlmIChyZXQgPCAwKQ0KPiArCWlmICghaW50
ZWxfYWxwbV9pbml0X2RwY2QoaW50ZWxfZHApKQ0KPiDCoAkJcmV0dXJuIGZhbHNlOw0KPiDCoA0K
PiDCoAkvKg0KDQo=
