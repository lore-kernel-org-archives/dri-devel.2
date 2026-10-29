Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A82606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bhky9h4l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2F410E6CD;
	Thu, 29 Oct 2026 18:57:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA30E10E159;
 Thu, 29 Oct 2026 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793300233; x=1824836233;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=PAX9U+q6RTi6xNIJlC+fS9iNq0o4rqzfrL9TwDB/trI=;
 b=bhky9h4lDmAfE9CmvJoRkzRwaKEOLms/skIKbvc32uAiX6ip8rFFg0Dk
 CXtXO3NuH6amHTdwZTywY3d/CG4Ztn1YBEQHQ3RN9V6v5uxeahaPYLKZx
 jtHb/HaRilUD5YPHAHfsJj/tg2eq9VITxTHy1tsVQR8BcVyYItRXcDaQ9
 iWEAIachmDLOFITW32imV/fggTQLwbLcOyoNzFSoIDg16nFRLm6g5IZ9u
 jA12o3wxwXo8UcvS7xIY9r548y2zekxkQBl4hF0W73MvYQrZ6TZoZU39z
 VH+DlLEeN1mZCb5c+F72Qedf0GwfNNfoR+Tatknx8DJYD9mX4ODwo2aMG Q==;
X-CSE-ConnectionGUID: DxVRdm6jTXSihYMaEN3DuA==
X-CSE-MsgGUID: 54xZmSfJTp+gvubqgrUfTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1954966"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1954966"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 11:57:12 -0700
X-CSE-ConnectionGUID: Hoc4wuDuQVKnB9DRQOyctA==
X-CSE-MsgGUID: I421G1XJQWyri3KT4YxeHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5590741"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 11:57:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 11:57:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 11:57:11 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 11:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec+N7ZUTCAJPzaCAlSlrMtJLtYePXJ54LV5Jm2AgluOr0pUjT+iFILJwnw4PZZB1Bdw0t3w3tQncTnuEWFI2SB4IA3XgpL6RjjaMrENTMggUE3gLMOnSaOY2ofyqzjt3pUm/8E20uMhkaDlpKWFYkD76EV1uvMV1VqhLL3klV/fEYCPKpQWULolH5fyG/t6kLdenGg0NBE/Gl2VhvSOb1QHxNTxOjeUrd2QFljCCbaD5KZf4nLpkIoWG5o8P4yls1tmvGKbGn5lda3LSpxYp3dF6FMEZI3RUw6sZO3exXu/ouDJlZTbot0t2xPmr3/l3a3kuqEvtbl5MoNEl3gDb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAX9U+q6RTi6xNIJlC+fS9iNq0o4rqzfrL9TwDB/trI=;
 b=KalNgWULEcp+VFMTA+1wSwFXWU805tXwiQ9qTRIl9b6KRAPVFv3ghw5W8C/lYW/x8pR+6PufVd4HpwYXd4nKG4rLyzuqZ9wqO+k/N9oq1Jb34O5MzzH8GRT/OR3Zvdu/aLqFoZnjH+jDOIs0KUdGt3Tkpmi+yU6U1hv51q8paU1Ca1durAntz/JRblwDXoE2Y1vVF3Sp0s1h1fn0f/F+hYntpx8HGXqlxJotaA+kwZuM51Zlz8ot5c4aZu72ktPO0MPCaBcSERsnzZGhs/3/w9FmlcG1fZQfJqFpkbrrs3Qund60ByALeLNqmYVyxjV4wKNbgCwBTqV3WVSGEPu90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11)
 by IA4PR11MB9179.namprd11.prod.outlook.com (2603:10b6:208:560::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 18:57:09 +0000
Received: from LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e]) by LVWPR11MB9883.namprd11.prod.outlook.com
 ([fe80::310:e83f:69b8:e11e%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 18:57:09 +0000
From: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>, "Jadav, Raag"
 <raag.jadav@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Topic: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Thread-Index: AQHdYxUQrX/Q3sL74kOuQzp1gjK0A7cST8SAgAEpCACAAIJtgIAAURCAgACXpwCAAAR8gA==
Date: Thu, 29 Oct 2026 18:57:09 +0000
Message-ID: <40e6e0bc0c8a7aa97208629a41255568e7faa319.camel@intel.com>
References: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
 <auFpdeRIafjgKSV9@black.igk.intel.com>
 <f7f8745978c21de8687e1e539a15f0be9f9d4a6a.camel@intel.com>
 <auLQCWmLV395IoS7@black.igk.intel.com>
 <63ba65de-4292-4f7a-9df3-f98fef5c88fe@intel.com>
 <b5964a238b9677518cc46648a90a7c5c7034396f.camel@intel.com>
In-Reply-To: <b5964a238b9677518cc46648a90a7c5c7034396f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR11MB9883:EE_|IA4PR11MB9179:EE_
x-ms-office365-filtering-correlation-id: 368e443e-d230-4b4f-9805-08df35ee6f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|56012099006|4143699003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021123027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: J3B9s8NQaAO2B8IyFzjo2ERoHjxpmP545EwW34ewNHOc6lLNnEvAvRV9pb+Hrr06P/D5RJy0mUjM/opn9GjKksEcO4czxuwMr2MVQ6qhVonBBVRlvo2CZbwOeKnBTDFUwnHvh3q426qCEc8q6KNasPLV79ojikPX15BR0CcjQiRfstZ7iKbMOo97KRkdgXqeBSN62zJtJWEYyyVHYC5lRtl0DLfW6cQyHT6dnX1bUJE+2ECOeyCNt6MBl1+pKx+v4KnvMcpprMr9VD7IWOnKRm32pXMslib1CEBwLRNZFUyGvDDcYo/aAjE9+q0WBhWm8hjXlRvEqO/Wb4CD31fJSUKAuP1Q7ny2gCoHLe4Gqg/821hx93icmV9oHth1BVCZRmIAnE86lrlauO/mvdxKLXHyFqCULr1UQ8cjIZzyJpNc40PNndpw+QkT5RoKp9rXYoCtzgAjVBQTiaI/UJ/9u4txCksHoipvvhMYNLIhrZsrX0XoXvK1h+xludCdgEc8s535VrC8ZYsqwF0Ky1FBHIbhO1EXl5q//Tg1owTDdWQGbf/sNOGjEx0ka+N2yaXZDSL3rN1Icvu9mjJVyGNQD7whwIhmVTuPZeQ9dlZZda108gYXlHuht8LXlP5+P8x8duYKjExFk0XqbZQXRkqpg6o/db0bdhtev5khPSkr6hNZihriggSqYCUAJ7RFJnAUCggbwmKHrKIEARTF37BiAXr0qn9t1aXIJNwHmX73Vxc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVWPR11MB9883.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZNWVdEUHVUNDd4SG1NcUxnN0JYQnU3cU5BVCtrQkhVOW1yWTZQaFhHVEVD?=
 =?utf-8?B?aTN2bTIrWDM2NUJ6b2l1NEx1RnhoeHJOMHFhWWkyWjZIU2hvQzRnNGllQkQ4?=
 =?utf-8?B?ZGI3eTN5SWFTbmpkcnBDYXZsRXAzRFVudW8zUC84eTR0OVVRN3BTcWFvcnFB?=
 =?utf-8?B?ZzJLS0MrWFRpZ2hvcE4wcjgrMGp0SlU1MEF1aUV2OEVIR3ZBWSswM3BjNEtB?=
 =?utf-8?B?ZmJVSWlzM0JtUHlsZlV6VFhIcDZleXE3T2pBSjlrU3VTMXZtWVEzN2JzVlV5?=
 =?utf-8?B?ZU9qK2pIQ0RqNThJUFRBTjN4NTlzN3M5WThIYXAzYmlzWndxVk1aT1NramEy?=
 =?utf-8?B?cUkyL09yQ0VWVVg1YnB0ZUMrbllucmhnRzBTcjM1Y2IwUVFkdFAwcXVZRnFR?=
 =?utf-8?B?dDFvY2hQS1AxekZ0T09ucXZNeHJlV21mMzZ5NnJnbWpsZThoMGtUTElTRm1U?=
 =?utf-8?B?N29RM0h0SnpiQlg3WU5rR3MvRFArbG8rcnpOZEhRV0Q1OWEzTnVBOXFBeEt3?=
 =?utf-8?B?WHdGcHkzamlQTDUvbkd2MG1TZWR6RmlxbmxFWjVYaUtYUllOT1JOTi8zMGww?=
 =?utf-8?B?SHRMVFlPRVowMUwxQUptMlovUlhhb1ZEdXJVM0xvSXZWODlEK01CRDgxa2dC?=
 =?utf-8?B?Uld1TmhwcHFqMU1NVytnK2IvVnJUNWduMHVsdEErWmhHR2JZa1U3Q0s4dElL?=
 =?utf-8?B?Q1hoS1V6c2NEUzZQV0ZMQVN0RzYwaHFYWHpvWFRvNFVweW0zOFdYeUxOVzkz?=
 =?utf-8?B?K0tKVkNYNS9tK2c2eCt4djRTWHRJdXpmZmtUUTV0c1lndU9yOG1xRDRTbXBm?=
 =?utf-8?B?WjYyOXMyRG04blBrR2tJbEFOOVdWbnYzTTkveU1ydzBmbnVUWGs5Vy91aDlN?=
 =?utf-8?B?ckJEWXh0ZDJhNy9IbEpHSnlCWktaVCtaMncveTFRT1ZRMXFqaXU2SnpvYVJY?=
 =?utf-8?B?RUQ4YkdFWklIU25wOU0raXVHWE11NlBOZ3ZrckhIbkk5UWphczdIbGtscHZD?=
 =?utf-8?B?S28rOThRMHI2ZzlkVHpIZitNTzdyMTMyTVFqSEtaYWhEbTNXblBFOVFYM2kv?=
 =?utf-8?B?WitENmZIUUxLWmtpUDBhSTVmaFFlR1RES2ZLSlowR0x1YlI0ZnZQaUg1WHdv?=
 =?utf-8?B?NjgvN2ZvbGZrbW1rRmlGVm5WR0FzRVlaemZTcGZlR2IvbnVpa2loSWtGRnVw?=
 =?utf-8?B?RnpkcjgxdXV3dVJsdnlZRVlOSURIeURhSEN1UkpoSmxiRE4wVlVxbXRUbUdq?=
 =?utf-8?B?cTZ1WGhaQS92S25xTXRpbnQvUmlQd2NQbVpnVEhHU1hjNExtKzN1aXFpTDZo?=
 =?utf-8?B?NlRVTi95K2F5N3pMVjdtV1JoVXhlVG1zNlM1Z3BSQWJ2WDhxT0t2eTVaenBy?=
 =?utf-8?B?QU10R1NQR0o3cWxJQzFHYUt2Q01EeUhKM3FxSmhIaHZka2hWVlZzdEhibWl1?=
 =?utf-8?B?S3lVTEswK1E4RmtZZjMwNi9lOGphM1ZWZ09QR0FLNEUzZUVMWmtEeUw4akZZ?=
 =?utf-8?B?cURwa081NkgvZlB1bGl3b2pjRm15N204UW1PamxWRTl1dVdtRlppVUhGVlFj?=
 =?utf-8?B?MlR2cmRkcEFtaytJUHdDV01XcGlzRUlJaHhrZ1RWbXhncUxVU1dnOUZyRUFx?=
 =?utf-8?B?YW13WjJzdkZDc1dHWTVxYm1hQ0dwV09EZmpSTjgyenVqNmFLS0c1QTNqb0V4?=
 =?utf-8?B?L01xUXNWc1grLzhMb2IxMlZYR04zV3dPczd4djFRZW1tMHBTdVM2dS91N3Fy?=
 =?utf-8?B?Rkl2ZXFEZStyQ2R0U0IweG43WEtWWVlwcHNVV2w3YThBZmdWd2xZR0hvQ3FR?=
 =?utf-8?B?VExFSm1rTGtFRWF6NWJpZGVLeE1UTmY4b0NHNnZKaVBtV0I0Zm85MUtUZkZB?=
 =?utf-8?B?RU5XRkdvNWU2QXFzZ05JbDlsZGtSOTJKTW5tYVdVNUR6WUpoV1NCV2hieTZF?=
 =?utf-8?B?MGZveFU1bGwrSnlrOEJYb2w1cU4rdWVlb3BqOFRMVTZaYUwxamJIbGNqckg0?=
 =?utf-8?B?MUlvbHpWODBvM0NKbmhVOVFkV0hFTGZjOGlsUTZUQlZmRFB5NmIzRWdVK2ty?=
 =?utf-8?B?MEJ4UnNwak9Kd2NBTnR6U0ZtVUZZbW9hVG4wZTVNODBUWFE2V0NtbWxWUXdV?=
 =?utf-8?B?ZUNacldTTkpXZUpLOUtqN1VOQXRROTVLVUszUmhVUUJXVjMyWnFDT0dzYlFN?=
 =?utf-8?B?Z2psS0ZuOUVpT01BQjVyTVhNbVVvanNnMDVPVytSbGVuaFJrSWh1YTd3cTNk?=
 =?utf-8?B?RlJSVWJRZzFSeCtXYkZWMmFRaUN3djZQQ1RmZGVUdTk3N2NpNTdhUGFNUFlK?=
 =?utf-8?B?cVkzeExvQTNCM0pGazJvMVlkZjFWbHExd1NHeU5sOVdmcDVKTTVGVlJoYnZq?=
 =?utf-8?Q?Nz/p+xA++94lxdjNpUbQWu2pkFMENjxQOdEdT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C60ABB64ED98E4DA9B16EF22194D0F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SHvswUA7OYuZGjBhJ9a6P4JlhFoBoVjQgAhzjs535McsE2duBWSareZkU4loDI2epUWOxo/IG1P9aq90As6yT9i6QffTnESS02ZsmvLTkQBeV5KMkFpnzjawcOBSh/hPAULMCVxNaBVU5WBs4dgYqr2PWiANdpC235GOT6Ew5Lv4ipan4dI7mznQuY30qfFQN3eKVhfhzTTwJ8/HbNz4hpPPQ0s2XHfFlHfutfH3i3K0MVudCWo2Q3TB/od+xkpq0z/kB6scRMHiPZkAXe1AnATHzVPK5E586FK/TvxoNeLW9cnWoJS04NPF/oKwxbcEemyv3qttkSfIUTXBNKJqLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR11MB9883.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368e443e-d230-4b4f-9805-08df35ee6f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 18:57:09.4326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdlVS7+2pxm/4Pb9rgqWH53NTLsbp+l9l6kEC3voWhzOqkoWNG48l0wfuYpIZf1XnJ+UR+I7em6s4PNKpcrKSegY3uh0pq1cNVehtbBlTGjvuogVyEZNHudJKXXAyNqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9179
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTI5IGF0IDExOjQxIC0wNzAwLCBUZXJlcyBBbGV4aXMsIEFsYW4gUHJl
dmluIHdyb3RlOg0KPiA+ID4gPiANCg0KV2hpbGUgaSBoYXZlIHlvdXIgdGltZSBvbiB0aGlzIGFy
ZWEgb2YgY29kZSBpIGp1c3QgcmVhbGl6ZWQgd2UgaGF2ZSBhIGJ1Zw0Kd2l0aCBob3cgd2UgYXJl
IHVzaW5nIHVkZWxheSB3aXRoaW4gcGNvZGVfdHJ5X3JlcXVlc3Qgd2hlcmUgdGhlICJ3YWl0IiBw
YXJhbQ0KaW5jcmVhc2VzIGV4cG9uZW50aWFsbHkgd2l0aG91dCBib3VuZGluZyB0byAoTUFYX1VE
RUxBWV9NUyoxMDAwKSAtIHdoaWNoIGNhbg0KY2F1c2Ugb3ZlcmZsb3cgYW5kIHBvdGVudGlhbGx5
IG5vdCB3YWl0aW5nIGxvbmcgZW5vdWdoLiB0aGlzIHNob3VsZCBiZSBhIGZpeHVwDQpzbyBpbGwg
cG9zdCBzZXBhcmF0ZWx5Lg0K
