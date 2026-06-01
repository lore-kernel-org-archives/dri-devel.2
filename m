Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F88ACD6E5D
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB401132A6;
	Mon,  1 Jun 2026 12:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h0yuvVk/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9481132A6;
 Mon,  1 Jun 2026 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780316368; x=1811852368;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Z67mZonzClLHvNrRkavFqk9PMZu+ZmyMS9snIt9SOwk=;
 b=h0yuvVk/sFS15WJPDtBgIARZTHYWKLNVhdH5IzjzCBumWHNIgGi81BJG
 AA30iqqzaOA/rHqtwX4w7jJVzmpGCpeFX8LyKkVpMc704srPcMA6v9Wt8
 cgCaavZpPAra5AhhuSzJyE6HvhkiS5Gf1w3quKuJt0Jy1jG2uXn1gpvW5
 qpA8vMgVSu5lkjP4rGQBog1ynFhbASMTkAxSjTR02Kqr2U/CDbFfh+/0r
 kbTlONb89UIN4L3qIRKzayH8/xxc4eTC5iyPCgFKNMpA/lA/z33/iR3WT
 C2hQxOu8ixncbi0524AZyiobVYaPK8eV5vUnXImscjjUV6v4+JYw2veUB g==;
X-CSE-ConnectionGUID: do+9RMIsSR2rLHDgHEd0pQ==
X-CSE-MsgGUID: HBLIhaLcR8KivOogFuy12A==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92547148"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="92547148"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 05:19:28 -0700
X-CSE-ConnectionGUID: 3jUzlpxOT3uEZCbkQ/aOpA==
X-CSE-MsgGUID: k0H6oV4jR62Xvw2/gRhWqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="243388578"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 05:19:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 05:19:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 05:19:27 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 05:19:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF6MbbyYo+h710F9ZWXDmXMJT4B7x6uaxDCiIkh0nK6JK8Jp860SQC1L4r1ABO0wNZxTP28/ksOFlANTi2KF3+Ys0uCSGGP2BL9kN3CqDG1bw4EGZaoBQpdzER0PpSiPEjG0iZXoLC8TMiXqwqrplZC7wb0VHppvp5yLWCnnGWPbbriuLAPEoGfW6AayYG8scMz/EfpIWpdpY3MSF5uyu4OXrDxxCRd5fEEa8fduozQHXfGcZjuUMS4fbvte0myoa37MNLOfZpzqYF7Dh4BEK0y8LxJVNnyU1GTELXtu5nwWUUOgv7y83ociD4p5q8lt/PE1t9LphmKWP3tZjuwdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z67mZonzClLHvNrRkavFqk9PMZu+ZmyMS9snIt9SOwk=;
 b=lbjI4ncrJoIV5AbwMphtXfSzJLSjkWMwpdd3lmoR+hvJ/A03qcA9Ok7ArWMm/MbA2Luss8FsLa0m88OdcoemtJ+VWoi81TuDtQ9805FtJvWsWSZJMv6idPJuwRql9yhLORXXx9aHMt3BSzsvaHMNFYnJWJx/4psBJSl97vPpyMa8fhoH20OmKecZLs2H2/WysN4IRa77ycQJOnVAFIavRxM1A4plw0HoRr6W5LNznz0oO0BzHrrAx7CM/aTa5dDmzfjTNcCNPs4YdRdCyWJvcTMqBg/9QxWLyV2G5pDsp3eD/fk+a5GMAIsrPH85zXvuRLm6wo6cHuYwKiR4v763FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 12:19:17 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 12:19:14 +0000
From: "Upadhyay, Tejas" <tejas.upadhyay@intel.com>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Auld, Matthew" <matthew.auld@intel.com>, "Brost, Matthew"
 <matthew.brost@intel.com>, "thomas.hellstrom@linux.intel.com"
 <thomas.hellstrom@linux.intel.com>, "Ghimiray, Himal Prasad"
 <himal.prasad.ghimiray@intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
Thread-Topic: [PATCH V10 03/10] drm/gpu: Add gpu_buddy_allocated_addr_to_block
 helper
Thread-Index: AQHc54sVkWg3vZ8iC0KRpDwXur9Kf7YWnVkAgAAYUlCAAvLDAIAH/RTwgAgM7gA=
Date: Mon, 1 Jun 2026 12:19:13 +0000
Message-ID: <DS0PR11MB8718D3EB3D6DB27623E0A7B181152@DS0PR11MB8718.namprd11.prod.outlook.com>
References: <20260519122817.45770-12-tejas.upadhyay@intel.com>
 <20260519122817.45770-15-tejas.upadhyay@intel.com>
 <835d204d-0c2a-4a81-8c60-9d047809f6ef@amd.com>
 <DS0PR11MB871852B659D0736A9582D23081012@DS0PR11MB8718.namprd11.prod.outlook.com>
 <468b9064-9eed-4651-b54a-4a15c7c4400f@amd.com>
 <DS0PR11MB8718D8AFC4B935BCD917255D81082@DS0PR11MB8718.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB8718D8AFC4B935BCD917255D81082@DS0PR11MB8718.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8718:EE_|PH7PR11MB8527:EE_
x-ms-office365-filtering-correlation-id: 358bff72-53d3-4cee-4729-08debfd7fe5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: RP9YNPznF+ihcXo/dbT+1O+3cbHHggfpLFLIeszQWzKXul1l++SEMKvQwiIRtt4E1qUZr72USFwkshQ9+gl2BhQKWawBsI+ubs8wVRnhXIiV2FMsycIDKGy38Vd2YPJPrxWp5s+SQsLI+leTycFMkfrun0eZ63KX3mbdWKC+UFMj3fdUQ0xaMQZWf60I1xrNI0ImZ7PJUvUbSsibX5kjib/EfrwI7oXaS1BbujE9GAjeGfQMPF1LgaQ4tcrdAuPE5MZCnetNmUXSMXRRgL8aZoBaA9nXXBSYbjt22sc4R5YA+BPz+dhkXFFAUlkpcSmHTbWeAlKvS3xhETieVmT1OyP6hNKKXa5H/zKmArfjK5yg7nG8ZciMalCmyDj49GqZWrP1nGyDYCHUqFiY1rQdmQAojNOZZ0hlLy7dEJRLCNXarshpymXw48SoarWoXB258eyRbZ4JMtZ/UkcY28v5MLskXomC3r2vuJ+ZwLm2iCs9AFZHja2wAcqJAtih9B02V304SUzeELvBtymf/e8EZVH3ymGIhf8IHUzXEH2M+huNA14S5KS3+9106wHn1DaN6k8zj91aeXfmlAuJvdPiE2YnwhMZq3j+lNd8xCOfB5ltAQ5glSBx6NjbZOpvIFSQfGkSdaa3ILcCEzrojARQKUpFVi+AvelxKK9Cb5s8Vrxa2r3pJhnifDEL0Yfteg7g+UPazd/GvDuHOfDAR8pDWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8718.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG9IbTRKRHhZMXRFRk8wbGFVMUk2am5yMXoxZWRBemFiTXV4c3pKUWdDWlZm?=
 =?utf-8?B?dnlKVDd5czFxcDRvOXZRRXZudnJBRVBWZHlLUWZNNmtVM2RKMjk1dVJmc1Bw?=
 =?utf-8?B?ejNtMk1sdjN4ajFyMk1rNHlMcnB3V2E4akRUS2FFcjFPYmI5WG5JU0xFTzZ6?=
 =?utf-8?B?b3hqOHJBcXhVSitaRUhrTXJUOU5CZ2laakN0WjFBU0RnSGx1eVJiVWhDakZl?=
 =?utf-8?B?MTRMWU1GTUprRzF6YmN6a1BNVkR6WlZ1TzY3SXFOOXN4bk1pckRFdzNILzZV?=
 =?utf-8?B?clJFdE1XSHZPd1lYV3hzR1FCQzg1UUNnQXc4QWlKWTE4UmZsS1JsbG5pQUNo?=
 =?utf-8?B?VmQ1ai9VazBPMXJsT3hsVVlBaTl3aGhvS2FIVXJtYVNUWU9vRzcrb3JXR2RE?=
 =?utf-8?B?ZEJqM3VleE9LRWsxSjZWbmNXV3JzQm82N1dNUGdadk5SOGVXb1BEY3FveXQv?=
 =?utf-8?B?YmJiNTcvTk1KeDFpMmdMUGxjOHp2MG5wa09ka0lVSzdaUVhRMlpZejJsTjUy?=
 =?utf-8?B?SzRBUUNaVGNvbG5Tb3UxU3E0YktadzBVRTdyd3IrNGdKWlJQeEk2Wk5aZWg2?=
 =?utf-8?B?YmVOaHdGQkZXR28vTXNmMENpSlJmK0I5dm5TejIrQTN5b2dEc1NmeC9xSkp2?=
 =?utf-8?B?R0N0TWtCMHRvR21TVkdQTldkYnNpSnR0TElFNU9WdmllaUdvbk5iS29XOTdN?=
 =?utf-8?B?VEpGRTZuSUFXYmJFWVBybUhxVEZ0dnA5L3Zhc1VPYmdwM0t2WHRpNTZBZ3Vw?=
 =?utf-8?B?MUFoZWFMdXBQU1dGVEp2U0RTS1BzcTV0MFJNR3pTMEVTQlo2eE5ubktnTzkr?=
 =?utf-8?B?YnBndHlDN1hLZnJtcE1XNUlNMkM2S3NybVFQMjRGcldZYWNudXh3cXhTcmZj?=
 =?utf-8?B?aUdLWS9QK3diekFJalYvSWdsZVU0MW9saEdZbXJURWxoMlJRYko0K0Nsbkt4?=
 =?utf-8?B?eXVXazNsOG50Z2t3UDNyRkVyclg3R2I3RVNmK1Nnb0lLWVkwaGh1ZlBSKzNn?=
 =?utf-8?B?YVNsc0VwbTB6SDY1WVcwMGsxSEdrY2lmTUhMU29XMXJuV2JYcjlGUjdJanFI?=
 =?utf-8?B?T01Ud3RlZi9nLzVQWW1hNVlUT3B3MTJ6dDFsQVd2ZkRYdGNCOElHSENPYUx4?=
 =?utf-8?B?U1JCNDYxUkFmLzIzMFc1RnhURlBFSFUwMkJENklmTnlucG1vUVZ1RGJRbGxi?=
 =?utf-8?B?V3ZlMmJ3RW5BbW1hbVh0Y0d0YXR3Si9zU01TNFNnekRJK254ZnFibS84bTlX?=
 =?utf-8?B?bDFQNmd0a2x1cllGQ1FsV28yUWd2L1Via1VId0h1TkNwRU8rbmdVNkZJN3E0?=
 =?utf-8?B?S29RT2xRTEpzODVId0NOUGtVQys3aEptZ0NlUTJSQnJieDBYRTNoMnM0eDNt?=
 =?utf-8?B?V2tCY1g0b2xjOXNqSmkwL3NhNVFCU0J5VUFQZ1VPVVFBaFlIS3NUSUhJYXY4?=
 =?utf-8?B?WTNHMndUQXIvS1Y4SlVFYWdGOFlKWDNjaWZMSmVWenpwNmJHd0F0bmpKZi81?=
 =?utf-8?B?SHdVczVEZTJjZWxqQVJZRXlVV1ExbWhKSEFqdGh6ZUk1OUllUFJIYnlPc3FO?=
 =?utf-8?B?YUN4Ty9vVGtaM2lRamVscGVlQlRMR2hFWnVFZnRzakhLRXdmZXRueEo3aUxH?=
 =?utf-8?B?NTRzY3RTQTNNbm94eUdvaC9veGFhTElwV1E4Wmw2Z0hLYzdkRU85WGVMaGIy?=
 =?utf-8?B?eEwwRW1KaTltRGhQVDZvT0xZOStiZGQvZ1AydnBickYxS1FXSUdKVVhsVXlB?=
 =?utf-8?B?Qm1TS3JCNzBUNGZhS1I3RVh5Sk1UNTJiU2ZQYVhKVkhsbVVLeGxwbDBYVkh3?=
 =?utf-8?B?STM3cDE4Wi9wR2NrV0t6ZEFxcFN1ZGV4VjRjMElKNG5Ud0cyVmpXZjJiWStj?=
 =?utf-8?B?SXZ5NGc2OFI0Z1I1ejFya3lOZE42VjYwdENKTGljdHhCYVlkRG1QdjNHNDdz?=
 =?utf-8?B?ZElnMVlGbkFsUUtSanVpRGQwazE1blNYejZPczVCV2c0ZUlIdlNFRHQxenlG?=
 =?utf-8?B?c2w5TmxFU202VHJhK1ZLajJmSUVqQnRTY3dBMlM5R2lxZnFPYzJZcTB1eEZr?=
 =?utf-8?B?aGFCNUtQSGc4bE5SOTZjWURTTHVKcG5Id0N5a2FuTnRaVGlwZ29TTTF0Z1o5?=
 =?utf-8?B?Nk5Oa1pHZldBTHBzYzJwTlI2d3E5Y3Y4bFVtRjNHSERlY0hCZURvMUd2bVRJ?=
 =?utf-8?B?blNEazQrM1NxUmpOcGR1a1JkSUdUL2NHZnlEbDlnNmxHUkh6TFkzdk5nRC92?=
 =?utf-8?B?YzRPZEhNMWYxS0xXWGlWSlpUZ2lCWFFOTkVwL0dOLzY1MDQ1QzJaRndER251?=
 =?utf-8?B?YkZqWFRpSmVTdTNQSjNWaGU2Ly9xL1M3cXpIWWhMMWQyZThidXBodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kaIJW8YyikZaZohRxWGUeZWiOre+nXYe6bXGSKP4U2cG1FSVghuwj1HwLk949sr4zoyxxfv9S2PppPqzO/dblxSHcSh2D3c+JtlUuhhoC4ZoTdwmSOgw622G6XXNoOS23oEqkHaaNHiJpk9CbXXG+pOA75qglfFzIl59Q8KlMATK40molDa8Gbd57/CerLkHpoIDj6Ryxi05dc/eUY9uy0r3BeL/Og+5YzcXhm8yvjDV55n4ZyOScBlZl6ey2d/sXZaoaub0siFr6Iur07RRBXmk2ddSTWwux8G4hvHMSqDtxgV7SKaSpjIZ4yTBdO8b4VpycEePn5zauM4ivJfBJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358bff72-53d3-4cee-4729-08debfd7fe5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 12:19:13.9618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3RPW4tjymtsUmRestIg0KgaCX+YP9jPeE1BQyu39G2ERz8TLu1Lv9xur9oDTLivkqqXNNKx3IJq4bNdrW5wsbr7aCDjoZ4GkMuh2nQI7c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXBhZGh5YXksIFRlamFz
DQo+IFNlbnQ6IDI3IE1heSAyMDI2IDE0OjU1DQo+IFRvOiBBcnVucHJhdmluIFBhbmVlciBTZWx2
YW0gPGFydW5wcmF2aW4ucGFuZWVyc2VsdmFtQGFtZC5jb20+OyBpbnRlbC0NCj4geGVAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBBdWxkLCBNYXR0aGV3IDxtYXR0aGV3LmF1bGRAaW50ZWwu
Y29tPjsgQnJvc3QsIE1hdHRoZXcNCj4gPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPjsgdGhvbWFz
LmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb207IEdoaW1pcmF5LA0KPiBIaW1hbCBQcmFzYWQgPGhp
bWFsLnByYXNhZC5naGltaXJheUBpbnRlbC5jb20+OyBkcmktDQo+IGRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYxMCAwMy8xMF0gZHJtL2dwdTogQWRk
DQo+IGdwdV9idWRkeV9hbGxvY2F0ZWRfYWRkcl90b19ibG9jayBoZWxwZXINCj4gDQo+IA0KPiAN
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEFydW5wcmF2aW4gUGFu
ZWVyIFNlbHZhbSA8YXJ1bnByYXZpbi5wYW5lZXJzZWx2YW1AYW1kLmNvbT4NCj4gPiBTZW50OiAy
MiBNYXkgMjAyNiAxMjo1Mw0KPiA+IFRvOiBVcGFkaHlheSwgVGVqYXMgPHRlamFzLnVwYWRoeWF5
QGludGVsLmNvbT47IGludGVsLQ0KPiA+IHhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IENj
OiBBdWxkLCBNYXR0aGV3IDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPjsgQnJvc3QsIE1hdHRoZXcN
Cj4gPiA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+OyB0aG9tYXMuaGVsbHN0cm9tQGxpbnV4Lmlu
dGVsLmNvbTsgR2hpbWlyYXksDQo+ID4gSGltYWwgUHJhc2FkIDxoaW1hbC5wcmFzYWQuZ2hpbWly
YXlAaW50ZWwuY29tPjsgZHJpLQ0KPiA+IGRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjEwIDAzLzEwXSBkcm0vZ3B1OiBBZGQNCj4gPiBncHVfYnVk
ZHlfYWxsb2NhdGVkX2FkZHJfdG9fYmxvY2sgaGVscGVyDQo+ID4NCj4gPg0KPiA+DQo+ID4gT24g
NS8yMC8yMDI2IDM6NTIgUE0sIFVwYWRoeWF5LCBUZWphcyB3cm90ZToNCj4gPiA+DQo+ID4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+PiBGcm9tOiBBcnVucHJhdmluIFBhbmVl
ciBTZWx2YW0gPGFydW5wcmF2aW4ucGFuZWVyc2VsdmFtQGFtZC5jb20+DQo+ID4gPj4gU2VudDog
MjAgTWF5IDIwMjYgMTQ6MjQNCj4gPiA+PiBUbzogVXBhZGh5YXksIFRlamFzIDx0ZWphcy51cGFk
aHlheUBpbnRlbC5jb20+OyBpbnRlbC0NCj4gPiA+PiB4ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gPiA+PiBDYzogQXVsZCwgTWF0dGhldyA8bWF0dGhldy5hdWxkQGludGVsLmNvbT47IEJyb3N0
LCBNYXR0aGV3DQo+ID4gPj4gPG1hdHRoZXcuYnJvc3RAaW50ZWwuY29tPjsgdGhvbWFzLmhlbGxz
dHJvbUBsaW51eC5pbnRlbC5jb207DQo+ID4gPj4gR2hpbWlyYXksIEhpbWFsIFByYXNhZCA8aGlt
YWwucHJhc2FkLmdoaW1pcmF5QGludGVsLmNvbT47IGRyaS0NCj4gPiA+PiBkZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYxMCAwMy8xMF0gZHJt
L2dwdTogQWRkDQo+ID4gPj4gZ3B1X2J1ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrIGhlbHBl
cg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+Pg0KPiA+ID4+IE9uIDUvMTkvMjAyNiA1OjU4IFBNLCBU
ZWphcyBVcGFkaHlheSB3cm90ZToNCj4gPiA+Pj4gQWRkIGhlbHBlciB3aXRoIHByaW1hcnkgcHVy
cG9zZSBpcyB0byBlZmZpY2llbnRseSB0cmFjZSBhIHNwZWNpZmljDQo+ID4gPj4+IHBoeXNpY2Fs
IG1lbW9yeSBhZGRyZXNzIGJhY2sgdG8gaXRzIGNvcnJlc3BvbmRpbmcgVFRNIGJ1ZmZlciBvYmpl
Y3QuDQo+ID4gPj4+DQo+ID4gPj4+IHYyOg0KPiA+ID4+PiAtDQo+ID4gPj4NCj4gPg0KPiAlcy9n
cHVfYnVkZHlfYWRkcl90b19ibG9jay9ncHVfYnVkZHlfYWxsb2NhdGVkX2FkZHJfdG9fYmxvY2so
TWF0dEEpDQo+ID4gPj4+IC0gcmVtb3ZlIGNsZWFyLT5hdmFpbCBhbmQgc3BsaXQgbm9kZXMgY2hl
Y2soTWF0dEEpDQo+ID4gPj4+IC0gQWRhcHQgbG9ja2RlcChNYXR0QikNCj4gPiA+Pj4NCj4gPiA+
Pj4gU2lnbmVkLW9mZi1ieTogVGVqYXMgVXBhZGh5YXkgPHRlamFzLnVwYWRoeWF5QGludGVsLmNv
bT4NCj4gPiA+Pj4gQ2M6IEFydW5wcmF2aW4gUGFuZWVyIFNlbHZhbSA8YXJ1bnByYXZpbi5wYW5l
ZXJzZWx2YW1AYW1kLmNvbT4NCj4gPiA+Pj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gPiA+Pj4gLS0tDQo+ID4gPj4+ICAgIGRyaXZlcnMvZ3B1L2J1ZGR5LmMgICAgICAg
fCA1Mw0KPiA+ID4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ID4+PiAgICBpbmNsdWRlL2xpbnV4L2dwdV9idWRkeS5oIHwgIDIgKysNCj4gPiA+Pj4gICAgMiBm
aWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQo+ID4gPj4+DQo+ID4gPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9idWRkeS5jIGIvZHJpdmVycy9ncHUvYnVkZHkuYyBpbmRleA0KPiA+
ID4+PiBlYjE0NTczNzYzMDcuLjlkZTk4NzIyOTRhNiAxMDA2NDQNCj4gPiA+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvYnVkZHkuYw0KPiA+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9idWRkeS5jDQo+ID4g
Pj4+IEBAIC01OTQsNiArNTk0LDU5IEBAIHZvaWQgZ3B1X2J1ZGR5X2ZyZWVfYmxvY2soc3RydWN0
IGdwdV9idWRkeQ0KPiA+ID4+ICptbSwNCj4gPiA+Pj4gICAgfQ0KPiA+ID4+PiAgICBFWFBPUlRf
U1lNQk9MKGdwdV9idWRkeV9mcmVlX2Jsb2NrKTsNCj4gPiA+Pj4NCj4gPiA+Pj4gKy8qKg0KPiA+
ID4+PiArICogZ3B1X2J1ZGR5X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrIC0gZ2l2ZW4gcmVsYXRp
dmUgYWRkcmVzcw0KPiA+ID4+PiArZmluZCB0aGUgYWxsb2NhdGVkIGJsb2NrDQo+ID4gPj4+ICsg
Kg0KPiA+ID4+PiArICogQG1tOiBHUFUgYnVkZHkgbWFuYWdlcg0KPiA+ID4+PiArICogQGFkZHI6
IFJlbGF0aXZlIGFkZHJlc3MNCj4gPiA+Pj4gKyAqDQo+ID4gPj4+ICsgKiBSZXR1cm5zOg0KPiA+
ID4+PiArICogZ3B1X2J1ZGR5X2Jsb2NrIG9uIHN1Y2Nlc3MsIE5VTEwgb3IgZXJyb3IgY29kZSBv
biBmYWlsdXJlICAqLw0KPiA+ID4+PiArc3RydWN0IGdwdV9idWRkeV9ibG9jayAqZ3B1X2J1ZGR5
X2FsbG9jYXRlZF9hZGRyX3RvX2Jsb2NrKHN0cnVjdA0KPiA+ID4+PiArZ3B1X2J1ZGR5ICptbSwg
dTY0IGFkZHIpIHsNCj4gPiA+Pj4gKwlzdHJ1Y3QgZ3B1X2J1ZGR5X2Jsb2NrICpibG9jazsNCj4g
PiA+Pj4gKwlMSVNUX0hFQUQoZGZzKTsNCj4gPiA+Pj4gKwl1NjQgZW5kOw0KPiA+ID4+PiArCWlu
dCBpOw0KPiA+ID4+PiArDQo+ID4gPj4+ICsJZ3B1X2J1ZGR5X2RyaXZlcl9sb2NrX2hlbGQobW0p
Ow0KPiA+ID4+PiArDQo+ID4gPj4+ICsJZW5kID0gYWRkciArIFNaXzRLIC0gMTsNCj4gPiBUaGUg
bG9va3VwIHJhbmdlIGlzIGRlZmluZWQgdXNpbmcgU1pfNEssIHdoaWxlIHRoZSBhbGxvY2F0b3Ig
aXRzZWxmDQo+ID4gb3BlcmF0ZXMgaW4gdW5pdHMgb2YgY2h1bmtfc2l6ZS4NCj4gPiBUaGlzIHdv
cmtzIHdoZW4gY2h1bmtfc2l6ZSA9PSA0SywgYnV0IGl0IGNyZWF0ZXMgYSBtaXNtYXRjaCBpZiB0
aGUNCj4gPiBhbGxvY2F0b3IgaXMgY29uZmlndXJlZCBkaWZmZXJlbnRseSAoZS5nLiBsYXJnZXIg
Y2h1bmsgc2l6ZXMpLg0KPiA+IFNob3VsZCB0aGlzIGhlbHBlciBiZSB0aWVkIHRvIGFsbG9jYXRv
ciBncmFudWxhcml0eSAoaS5lLiB1c2UNCj4gPiBtbS0+Y2h1bmtfc2l6ZSkgaW5zdGVhZD8NCj4g
DQo+IFlvdSBhcmUgcmlnaHQsIGZvciBhbGwgYXJjaHMgb3IgcGFnZXNpemUgdG8gd29yaywgaGVy
ZSBJIHNob3VsZCBjaGFuZ2UgdG8gZW5kID0NCj4gYWRkciArIG1tLT5jaHVua19zaXplIC0gMTsu
IFRoYW5rcyBmb3IgcmV2aWV3IGhlcmUuIFdpdGggdGhhdCBjaGFuZ2UsIGlzDQo+IHBhdGNoIGFw
cHJvdmVkPyBPciB5b3UgaGF2ZSBmdXJ0aGVyIGNvbW1lbnRzPw0KDQpBbHNvIGNvbW1lbnQgYXBw
cmVjaWF0ZWQgb24gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzcyNjI1
NS8/c2VyaWVzPTE2MTQ3MyZyZXY9MTAgYXMgd2VsbC4NCg0KVGVqYXMNCj4gDQo+IFRlamFzDQo+
ID4NCj4gPiBSZWdhcmRzLA0KPiA+IEFydW4uDQo+ID4gPj4+ICsJZm9yIChpID0gMDsgaSA8IG1t
LT5uX3Jvb3RzOyArK2kpDQo+ID4gPj4+ICsJCWxpc3RfYWRkX3RhaWwoJm1tLT5yb290c1tpXS0+
dG1wX2xpbmssICZkZnMpOw0KPiA+ID4+PiArDQo+ID4gPj4+ICsJZG8gew0KPiA+ID4+PiArCQl1
NjQgYmxvY2tfc3RhcnQ7DQo+ID4gPj4+ICsJCXU2NCBibG9ja19lbmQ7DQo+ID4gPj4+ICsNCj4g
PiA+Pj4gKwkJYmxvY2sgPSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJmRmcywNCj4gPiA+Pj4g
KwkJCQkJCSBzdHJ1Y3QgZ3B1X2J1ZGR5X2Jsb2NrLA0KPiA+ID4+PiArCQkJCQkJIHRtcF9saW5r
KTsNCj4gPiA+Pj4gKwkJaWYgKCFibG9jaykNCj4gPiA+Pj4gKwkJCWJyZWFrOw0KPiA+ID4+PiAr
DQo+ID4gPj4+ICsJCWxpc3RfZGVsKCZibG9jay0+dG1wX2xpbmspOw0KPiA+ID4+PiArDQo+ID4g
Pj4+ICsJCWJsb2NrX3N0YXJ0ID0gZ3B1X2J1ZGR5X2Jsb2NrX29mZnNldChibG9jayk7DQo+ID4g
Pj4+ICsJCWJsb2NrX2VuZCA9IGJsb2NrX3N0YXJ0ICsgZ3B1X2J1ZGR5X2Jsb2NrX3NpemUobW0s
IGJsb2NrKSAtDQo+ID4gPj4gMTsNCj4gPiA+Pj4gKw0KPiA+ID4+PiArCQlpZiAoIW92ZXJsYXBz
KGFkZHIsIGVuZCwgYmxvY2tfc3RhcnQsIGJsb2NrX2VuZCkpDQo+ID4gPj4+ICsJCQljb250aW51
ZTsNCj4gPiA+Pj4gKw0KPiA+ID4+PiArCQlpZiAoZ3B1X2J1ZGR5X2Jsb2NrX2lzX2FsbG9jYXRl
ZChibG9jaykpDQo+ID4gPj4+ICsJCQlyZXR1cm4gYmxvY2s7DQo+ID4gPj4+ICsJCWVsc2UgaWYg
KGdwdV9idWRkeV9ibG9ja19pc19mcmVlKGJsb2NrKSkNCj4gPiA+Pj4gKwkJCXJldHVybiBOVUxM
Ow0KPiA+ID4+PiArDQo+ID4gPj4+ICsJCWxpc3RfYWRkKCZibG9jay0+cmlnaHQtPnRtcF9saW5r
LCAmZGZzKTsNCj4gPiA+Pj4gKwkJbGlzdF9hZGQoJmJsb2NrLT5sZWZ0LT50bXBfbGluaywgJmRm
cyk7DQo+ID4gPj4+ICsJfSB3aGlsZSAoMSk7DQo+ID4gPj4+ICsNCj4gPiA+Pj4gKwlyZXR1cm4g
RVJSX1BUUigtRU5YSU8pOw0KPiA+ID4+PiArfQ0KPiA+ID4+PiArRVhQT1JUX1NZTUJPTChncHVf
YnVkZHlfYWxsb2NhdGVkX2FkZHJfdG9fYmxvY2spOw0KPiA+ID4+PiArDQo+ID4gPj4+ICAgIHN0
YXRpYyB2b2lkIF9fZ3B1X2J1ZGR5X2ZyZWVfbGlzdChzdHJ1Y3QgZ3B1X2J1ZGR5ICptbSwNCj4g
PiA+Pj4gICAgCQkJCSAgc3RydWN0IGxpc3RfaGVhZCAqb2JqZWN0cywNCj4gPiA+Pj4gICAgCQkJ
CSAgYm9vbCBtYXJrX2NsZWFyLA0KPiA+ID4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9n
cHVfYnVkZHkuaCBiL2luY2x1ZGUvbGludXgvZ3B1X2J1ZGR5LmgNCj4gPiA+Pj4gaW5kZXggNzE5
NDFhMDM5NjQ4Li5lN2UyMmZhMDVlZTIgMTAwNjQ0DQo+ID4gPj4+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvZ3B1X2J1ZGR5LmgNCj4gPiA+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9ncHVfYnVkZHkuaA0K
PiA+ID4+PiBAQCAtMjcyLDYgKzI3Miw4IEBAIHZvaWQgZ3B1X2J1ZGR5X3Jlc2V0X2NsZWFyKHN0
cnVjdCBncHVfYnVkZHkNCj4gPiA+PiAqbW0sDQo+ID4gPj4+IGJvb2wgaXNfY2xlYXIpOw0KPiA+
ID4+Pg0KPiA+ID4+PiAgICB2b2lkIGdwdV9idWRkeV9mcmVlX2Jsb2NrKHN0cnVjdCBncHVfYnVk
ZHkgKm1tLCBzdHJ1Y3QNCj4gPiA+Pj4gZ3B1X2J1ZGR5X2Jsb2NrICpibG9jayk7DQo+ID4gPj4+
DQo+ID4gPj4+ICtzdHJ1Y3QgZ3B1X2J1ZGR5X2Jsb2NrICpncHVfYnVkZHlfYWxsb2NhdGVkX2Fk
ZHJfdG9fYmxvY2soc3RydWN0DQo+ID4gPj4+ICtncHVfYnVkZHkgKm1tLCB1NjQgYWRkcik7DQo+
ID4gPj4gQ291bGQgeW91IHBsZWFzZSBjbGFyaWZ5IHdoZXJlIHdlIHBsYW4gdG8gdXNlIHRoaXMg
aGVscGVyIGZ1bmN0aW9uDQo+ID4gPj4gaW4gdGhlIGNvZGUgcGF0aD8gSSBkbyBub3Qgc2VlIGFu
eSBjYWxsZXJzIGFkZGVkIGluIHRoZSBjdXJyZW50IHBhdGNoDQo+IHNlcmllcy4NCj4gPiA+IFN1
cmUsIGl0IGlzIGdldHRpbmcgY2FsbGVkIGluIEFQSSB4ZV90dG1fdnJhbV9yZXNlcnZlX3BhZ2Vf
YXRfYWRkcigpDQo+ID4gPiBhdA0KPiA+ID4NCj4gPg0KPiBodHRwczovL3BhdGNod29yay5mcmVl
ZGVza3RvcC5vcmcvcGF0Y2gvNzI2MjUyLz9zZXJpZXM9MTYxNDczJnJldj0xMA0KPiA+ID4NCj4g
PiA+IFRlamFzDQo+ID4gPj4gUmVnYXJkcywNCj4gPiA+PiBBcnVuLg0KPiA+ID4+PiArDQo+ID4g
Pj4+ICAgIHZvaWQgZ3B1X2J1ZGR5X2ZyZWVfbGlzdChzdHJ1Y3QgZ3B1X2J1ZGR5ICptbSwNCj4g
PiA+Pj4gICAgCQkJIHN0cnVjdCBsaXN0X2hlYWQgKm9iamVjdHMsDQo+ID4gPj4+ICAgIAkJCSB1
bnNpZ25lZCBpbnQgZmxhZ3MpOw0KDQo=
