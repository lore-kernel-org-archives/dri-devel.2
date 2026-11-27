Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1D606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B9SGidB1;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JkVjog75
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FF41124C6;
	Fri, 27 Nov 2026 07:40:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D293111234C;
 Fri, 27 Nov 2026 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795765198; x=1827301198;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6KDahHvWBmIO+hIQhlVMzzoaAN8NcCiOkzZG0E9m9nE=;
 b=B9SGidB1dtmcrNR2b1h1h71EmEEV0EaYq5KmAaFXHCwWLeBwWuRk620h
 CZYrmmuYirDw7iFb+AVPCpR8CTZYgpTAdvqBZUPOy62UiMswfLSSCI3Er
 c6BVC7WxB0vxcxpvyahir9MZAHBuRiQZpe11NJXMvDyKry/4vib0MUoQM
 KzxR2LVzyurpfcI/KcfgrC3rzlh4T+ppaTEPwdJSPi0drdhtUggJv+w3L
 9UIHkLzC5b5GftAUVTTfEIWOzFfi7zreTDWJj1w9ffDAAZZz2ju2Tr6pJ
 da6qUn5ED72NHiuGq64EUyfSJs89qa9yC8dG380SMO19ddUPqkndgIPrc w==;
X-CSE-ConnectionGUID: uuu9iOwXSryv7giHxNvq1Q==
X-CSE-MsgGUID: 7B7Ws+ERQQW4LeHv0GQahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4555356"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4555356"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:39:58 -0800
X-CSE-ConnectionGUID: jeoWLP3ZRou46yn/Q8nTZg==
X-CSE-MsgGUID: 7uJ4hSl9RoWMwq+0VfFjHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12369642"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 23:39:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:39:57 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 23:39:57 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.66)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:39:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRhXRQv0aZ21E3HCcqxneA5fzGX3n1/Hum8vzH9SOHopyTUNqUxyBip9r3mANmbdyHQNbV1GcphXeW+vKtm071GLnrW0uZn9RDZOfbk2s/J4DLuSoOxBc8Z+2JFcBSg3qDH9imeK7FMGtCJqBZEItEGGSg/fL2ZDsbcKm1cg+2pgvYaFBjNrSyNMftJaYWgHFzMTzBlqXE8ANygY5qeSLAJ85OJOeHe9tUBOrwBeH7KJrN2e3mT/r8eAqKmV4mFRFtn7EJzciiG8LzP0uqsl2ZYHSa4dcy/zd5MZ/VY/ZGDEjYbNFn/TY/DopuRfH67LxfEe06vuVYQyDlQZwhGHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5jXxGrY55EgxHqe0FbjApcrOKMt12qlCaInDFvk6YE=;
 b=k183dK5r6W6AvtdFW7+fLeyA1bhhne+zpYvWaPdcQe/S5hrKjmo31oqws6vmbnkz7iYIvoDBq55AexVs0xGsnD4NtTJIxpE55NX/HzwGgME0IlFZHhIp36CRzclSSay3e7kQOXQU1LMYyR2VTPd82Rw8bN1VeCpfQrWUydBc5RDINI6YWV3kzlTO+xkj53ctq6KM4BswWa0CLz44WQLZ3+Lv6pQItEC1HZoPXLOB6GYwsNqW3qlj+fr6KH4mlC100V5uU+QWF++bTx2tSt6w4UKlhy0dHvIO8ZFHvcshAwRwHL9YFJi+WGavJ1kAguw7jFQFw4d85UhBlg4GtD5yaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5jXxGrY55EgxHqe0FbjApcrOKMt12qlCaInDFvk6YE=;
 b=JkVjog75DOrIRKDDSks09+Sv3Vdw4MFjT0EAtnpxeu5w7g214aiz/xQ0YTlSQS74k/jTTvaK8V2SUbBzXybe5Tl2b10bgbjAWKafC6eVDjbYdyIH1UQ7D8eysqAPuF5KuHCtDTNdZjNt6vdTfUKeQltJ6zkj7ZZsI2Z+10nD2cQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 07:39:54 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:39:54 +0000
Message-ID: <fad3182a-de99-489f-89f8-a8ee2a1d91a0@intel.com>
Date: Fri, 27 Nov 2026 13:09:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/ras: Add retired-pages node type
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
References: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
 <20261124203833.3618507-5-rodrigo.vivi@intel.com>
 <90a912c9-2936-49c9-bdce-1267825f1678@intel.com> <awcwFHXV25lieJic@intel.com>
 <81dcc8ef-da18-4eeb-9732-641127aa6827@intel.com> <awgv3wH7RqsvSJz5@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <awgv3wH7RqsvSJz5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0266.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::14) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c45d0a4-b259-4611-f8ed-08df4c59a055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|6133799003|261009223327099003|261009221227099003|261009220027099003|261009223027099003|261009221727099003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261022113327099003;
X-Microsoft-Antispam-Message-Info: 1z5G+EMtGNVDKQuCeVTWzDrGEN6WbAjXOjdP2T88Iuw7VQklueTY6YDEqRkqoWWKky1GNs9nGESiyoXW+Q/OGotzZ2+DzLGXlaiCgqAEUMp8qfCTCf3Vh/9xRA5MAEIS5meL6fcMHWKSVPCOUnmpKEDdITRH4dsGFk4Kt8WOmRSqp/kd/CuzbtYF5sENrvN2No588NqBqSm+99Uw1gSRMGDC9ff/ssIskxM61H9zk0520C/pPgf5VokwKWw+KxJAbCX9sYfHgohz68u6e9tpIXzqy1n6Uy6dpEmnGQomBO24SKpxhC6kF+UGrO+86Ga+eMHn3IMI3p9PkbnaIyWAr1gGgKJzZThUcRTzUmbKcmoBP5To7QvkxWez0OkijP1OqM/MPlHgAJUYMy2dkIxt/pt0Bbm7SnDfhG9dJdmxCcxpWiCkrcS3r8EDStx3wb6oecx8GcsZkURdZT3J4trBL4dFtH+15g5SsoWPFMUSt4WJEWmIBQwwql4kGQMwpBOanrOGU9pgeDhzrXm6VpBbZt3dWfyCpmHABbQMYm3ciW1+Q0obxRDNYG+2rWY26Aq5iDI2benNuNB4xxhqH7ap+XQcPJJ0Qe8M8VODJ3dLwQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(6133799003)(261009223327099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009221727099003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9BWTU4M2JsYjhhZGNBMlp1UkNPQ0JvQkVjR3g0c2NiL2ZWSEpmTFVVMWl6?=
 =?utf-8?B?dEIzK1IzOTBFNWxaSHFmcVd3VHQ0NmxYcFpHa2RhUjNYWjdBZTVDUVdWbWJI?=
 =?utf-8?B?a05Pa0RaVjMwaGx1WmVQZzZvMjYrTURTY0ladlpmekJKa1JGM3NyRWpFSWo3?=
 =?utf-8?B?UmxIakxHVTR5MTJSelIweWFhNW5iaDd6RzM4Tndxa3RCSG1qU1ZsbytMUXFU?=
 =?utf-8?B?NjRFUGJ3M1pkRjdEZTRXTWpKS0pxbjBnRGlrbUFUbE01dTgxQnZ0a2NEbjNL?=
 =?utf-8?B?d043ZGZOR1NIbit3b211M1dzU3JpdEpadE1kVXg0K05XVWw1ck9VVXVJcUFI?=
 =?utf-8?B?YUtLWXYxT1hmd0tzdmFUMFFqSXk5dVE5Z2ZaZWh6WExNRFpCcy9hYjVsVW5D?=
 =?utf-8?B?eE9PRml5S3Q2WmdqT3Q0VjBWenNTL01GdE9VUldhcHIydEk0em5yalM4Yllm?=
 =?utf-8?B?NEdZTE0vc2pWUktETy9VM0tBSCtSMVBJdlVBZGlIZUw5U2tGbTRkK0hkN3Ey?=
 =?utf-8?B?V3VWNDIwQVAzOEZncUdTOGsyeERLVEpBd2I4dzBHUUNsS0Vnd1NwSy9tUzhR?=
 =?utf-8?B?MjBmUHpaQmo3OVM3VkJPSHp3UmtwK1JOQjBab1IyTjdITDZ3R2NGNC8xRVFs?=
 =?utf-8?B?UTVwaXFOV0EwYllxK05HTkdNZTg4WXJYNVcrOWd5cldCVEtxMjI5aUFlVHM3?=
 =?utf-8?B?eHFIYjluU2g3YzNUa0ZCSGZNM29IQVZyMHBETlRwMUN1RzIzb0IxQ1J5OTBr?=
 =?utf-8?B?NGxSODlQMU9iYXdhWnBwV0JNenJTQ0lYRzFWOG1PRXhJNlNlMHFPNW05dDdk?=
 =?utf-8?B?aVRpMXNlaXcwUHAydDc1YTJYaHh5dUVEOXR3STdoZ2RxN09SaXZ1enI1K01G?=
 =?utf-8?B?WDY0ZWU4WHN5QWRjbGZ4UGd5NnVFMU1ZSm5iNWJJN3UyTVJhK3RtYmdqN20z?=
 =?utf-8?B?WnMrVnd4eWxKVm1NT3Q5YVFBL2hVeXREN3RTblZNbWkrTVdqdmk2NC9oSjNO?=
 =?utf-8?B?VGI2UWkvelFUYTVyUlkvV1dvRTExWEc5Z3o2UVc2b01oVzE2RGNaTk5xSHUz?=
 =?utf-8?B?VGVmQ09CMmE2azl3ejI1RXdBd2szQ25QdXlrSzZhUDQ2ZDg1QW9XUHkrd24y?=
 =?utf-8?B?QzJ4NlhpTzZWVUZESElhL3VBUk5BUmxqNFQ1VDl1My9lVE5pQWFIdG1kWFV0?=
 =?utf-8?B?MEM4RDlPMWV6S3RWcHhrcGtGZzh3VC9oeXFmb3R2enlRMDhkQU5lcFFaTldS?=
 =?utf-8?B?TDFFYXpxMXQ3WkdYK0F2VVVEK0kvencxSk0rTW9RSFdtOGwxNTBiT0V1RFVt?=
 =?utf-8?B?WURNbndCSElQSThYQ2s0bU90L1RPYWFmWUtTNjVPL3FRc1VxUGdQZUJabWJy?=
 =?utf-8?B?NVR1dUZCaGRmU1BEemxqVXgyRjZHaDI5c1BLdmd1TlRqdEd2Yzd5eWRIUE5U?=
 =?utf-8?B?ek84d2NieE16ZEwxQjFmVDJ3dHFidVlCbUdOa1JObXBscmkxVjhSSkZTeE9M?=
 =?utf-8?B?L2xRQ1NuaXUwV3pzVkpKZWF5Vk15QTMvYnd1RHlCajRyd2RBMmlJelNqa3d2?=
 =?utf-8?B?RVNaT01sSEQ4Z05UNitaeG1HQXljWmNOMStDRHVxZXlQZGhxZkNFb09LbWRP?=
 =?utf-8?B?YWhEYWJmL0d5SEk2OUNHcHk3OWJCcFVNb0d5bEhabDF0NFVxb25HbWxRTHlP?=
 =?utf-8?B?RWpFSzNuTUdUQVFuTi9LUUpQMU9SWm5QSEUwdGhQTk1henQ5TEpBNnJqOUx6?=
 =?utf-8?B?QjhHbG5NYms2LzBBbzJrbE8xWkxjOWZUb2NDMUx3SHo4YWxoeWovNzcvRCtM?=
 =?utf-8?B?aGhOZW55UWVHV09ZS3RjU3lTajVHdDJHM3daNVlDckZ5RDhBNUNhNTJLR2N2?=
 =?utf-8?B?cElicXBkbFJ0dE5KbFJyd2FSOHh6UHFzZ0Zlc25vOTEwYzhxVlRjS0NCbEh4?=
 =?utf-8?B?Q3EzWjNlekxENkl1dXhPUWVNK2dlUENGUFBoMGJHTndFOFZubXVaN20xSnJr?=
 =?utf-8?B?ZE9rZDlCSVpYMHhvRG9tUFdqbksyOEkxdWR6NVlCZDRjbVowNGNQa2R2ZktQ?=
 =?utf-8?B?QStjYXJWUWJycHkydlNKdUlpeUg0ZjlKczg5YUluM1FvMUNVdWE5MTdFTmRQ?=
 =?utf-8?B?eVVJZm1pN3pmRW1zN3VmZkV6eHFZR2tMVGVIZjR1WHZzZ1FHQ2x3L3JjWUpl?=
 =?utf-8?B?ZEVRWG1pRXJoUFhsNmVrUGNtb3BrMUxDbVMrRkRDcUltRTNvZG01a3lBRXVN?=
 =?utf-8?B?VndBaXEvbnRKNFcwUFdRNnp0R1ZIUHlubW5uSE53eUZiQnAveTZuMy9sNXhX?=
 =?utf-8?B?bk5rMFlNaXpJWTNTeVlqTVVubitieUNaSmFXeWllakQ2aXpScUQ1QT09?=
X-Exchange-RoutingPolicyChecked: dp+UidNaG7A7BmVHCQp1v4VKq5Mzjp44HH/45mXAi6HMge+JX/Gcz2gbrRQEiOHtkdhe0E7vFwvuylfX1QG9FItko6ne21zLmliT8boB2Z49KhEztqrNQMtOFKf8H2+CezMLWvbf5v8oE+6SQU0e9NaLb84TfvXemhpgeSxyUJWKrQJGNRC9wCZBtnUOFufKlnpxGJRXrI8QUYxTQOtqT4LYoNbyGm3oB9iRdo+AjdWCo+5OCyfVKnZ5RV8Sbo9YigRZo/LGVYGiL4Nx13IqzYzg2l4AGstyn3AiaHOrmHbFk3pvI0ip2g81cC+oYTg+VuHkULltwZrgRngkKlKF1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c45d0a4-b259-4611-f8ed-08df4c59a055
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:39:53.9600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l7aM3KNt1qhRz61Cam+Lzu2IgsQ6vt6dpgbDaJPgB3ZDYxGGuCMJzY/N6ql15D83VO/ppcP4nbPSAjG0zr6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26-11-2026 18:40, Rodrigo Vivi wrote:
> On Thu, Nov 26, 2026 at 10:39:10AM +0530, Tauro, Riana wrote:
>> On 26-11-2026 00:29, Rodrigo Vivi wrote:
>>> On Wed, Nov 25, 2026 at 04:45:38PM +0530, Tauro, Riana wrote:
>>>> Hi Rodrigo
>>>>
>>>> On 25-11-2026 02:08, Rodrigo Vivi wrote:
>>>>> From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
>>>>>
>>>>> Add a retired-pages node type to drm-ras so drivers can report the
>>>>> memory pages they have taken out of service, with two operations:
>>>>>
>>>>>     - get-retired-pages: dump one entry per page with its address, size
>>>>>       and status (retired, pending or failed). The dump is flagged with
>>>>>       NLM_F_DUMP_INTR if the list changes while it is read.
>>>>>     - get-retired-pages-info: return the maximum number of pages that can
>>>>>       be retired.
>>>>>
>>>>> v3 (Rodrigo+LLM):
>>>>>     - Split the drm-ras core from the xe user.
>>>>>     - Flatten the page attributes and name the node type retired-pages
>>>>>       instead of retired-resources, avoiding the over-wrapping
>>>>>       anti-pattern pointed out by Jakub: the type-specific nest and the
>>>>>       resource-type enum are gone.
>>>>>     - Use uint for address, size and max-pages, no pad (Jakub).
>>>>>     - Start the status enum at 1.
>>>>>     - Move max-pages to its own do operation instead of a leading dump
>>>>>       entry.
>>>>>     - Set NLM_F_DUMP_INTR from a driver generation counter.
>>>>>     - Report unknown node IDs with NL_SET_BAD_ATTR.
>>>>>     - Removed deprecated Assisted-by tag.
>>>>>
>>>>> v4 (Rodrigo+LLM):
>>>>>     - Check the dump consistency once a page message is filled (Sashiko),
>>>>>       and on the final NLMSG_DONE (local Sashiko), so NLM_F_DUMP_INTR is
>>>>>       not lost.
>>>>>     - Make the error-counter operations reject other node types (Sashiko).
>>>>>     - Hold a node reference in the new handlers (local Sashiko).
>>>>>     - Rebase on the telemetry node type, moving the type check of its
>>>>>       handlers into drm_ras_node_get().
>>>>>
>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>> Cc: Riana Tauro <riana.tauro@intel.com>
>>>>> Cc: Raag Jadav <raag.jadav@intel.com>
>>>>> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>>>>> Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
>>>>> Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
>>>>> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>>>> ---
>>>>>     Documentation/netlink/specs/drm_ras.yaml |  74 +++++++-
>>>>>     drivers/gpu/drm/drm_ras.c                | 226 +++++++++++++++++++++--
>>>>>     drivers/gpu/drm/drm_ras_nl.c             |  24 +++
>>>>>     drivers/gpu/drm/drm_ras_nl.h             |   4 +
>>>>>     include/drm/drm_ras.h                    |  49 +++++
>>>>>     include/uapi/drm/drm_ras.h               |  31 +++-
>>>>>     6 files changed, 388 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>>>>> index 0f1ceb705d3d..bc17d22e2156 100644
>>>>> --- a/Documentation/netlink/specs/drm_ras.yaml
>>>>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>>>>> @@ -16,16 +16,28 @@ definitions:
>>>>>         type: enum
>>>>>         name: node-type
>>>>>         value-start: 1
>>>>> -    entries: [error-counter, telemetry]
>>>>> +    entries: [error-counter, telemetry, retired-pages]
>>>>>         doc: >-
>>>>>              Type of the node. The error-counter nodes expose reliability counters
>>>>> -         for a hardware/software component, and telemetry nodes expose an
>>>>> -         interface for reading and writing telemetry values to a device.
>>>>> +         for a hardware/software component, telemetry nodes expose an
>>>>> +         interface for reading and writing telemetry values to a device, and
>>>>> +         retired-pages nodes list the memory pages that have been taken out
>>>>> +         of service.
>>>> I noticed the node type was changed.
>>>> Earlier reviews mentioned reusing the node for other resources, such as
>>>> fabric
>>>> https://patchwork.freedesktop.org/patch/749454/?series=173066&rev=1
>>>> Could you please help understand why this was changed? Are we not re-using
>>>> it?
>>> avoiding the anti-pattern issue raised by Jakub.
>>>
>>> Reusing it needed a resource specific nest and a resource type enum,
>>> which is the over-wrapping Jakub pointed out. Fabric would not have
>>> addresses and sizes anyway, so it fits better as its own node type,
>>> and the node type enum can grow without breaking anything.
>> The current drm-ras design lets drivers register nodes for different kinds
>> of data: for example, error-counter nodes can represent different error
>> types,
>> and telemetry nodes can be created for different telemetry types like soc ,
>> component specific .
>> With a retired-pages node type, would drivers be limited to registering only
>> page-related resources?
>> We might need to add a new node type uapi for each resource.
> I really don't see this happening for us right now, but that is already
> supported. Same style as the others hold here.
>
> For instance, with current v5 code you already can do this:
>
>          /* Existing node, as today */
>          vram->node_name = "vram-retired-pages";
>          vram->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
>          vram->query_retired_page = query_retired_page;
>          vram->priv = xe;
>          drm_ras_node_register(vram);
>
>          /* New node, same type, another name and memory */
>          lpddr->node_name = "lpddr-retired-pages";
>          lpddr->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
>          lpddr->query_retired_page = query_lpddr_retired_page;
>          lpddr->priv = xe;
>          drm_ras_node_register(lpddr);
>
> $ sudo $CLI --dump list-nodes
> [{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name': 'correctable-errors', 'node-type': 'error-counter'},
>   {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name': 'uncorrectable-errors', 'node-type': 'error-counter'},
>   {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name': 'vram-retired-pages', 'node-type': 'retired-pages'},
>   {'device-name': '0000:03:00.0', 'node-id': 3, 'node-name': 'lpddr-retired-pages', 'node-type': 'retired-pages'}]
>
> $ sudo $CLI --dump get-retired-pages --json '{"node-id": 2}'
> [{'address': 12807041024, 'size': 4096, 'status': 'retired'}]
>
> $ sudo $CLI --dump get-retired-pages --json '{"node-id": 3}'
> [{'address': 4294971392, 'size': 4096, 'status': 'retired'},
>   {'address': 4295000064, 'size': 4096, 'status': 'pending'}]
>
> So, the only thing you might question is the 'vram-' name our driver is
> choosing for CRI. But I'm not planing to change that because that was
> what it was designed and agreed upon for CRI.
> But this component here is flexible enough to accommodate the case
> you are bringing up.

With system memory already reporting page offlining separately, this 
node seems to be device-memory specific in
practice, although I can see it extending to different memory regions or 
types as you said.

Since generic resources was Aravind's design and he acked the design 
change for non-generic type.
I'll leave the node type decision to you both.

>
>> Would it make sense to keep a single node type and support multiple
>> operations, or keep attributes optional depending on the resource?
> No please. That brings us back to the anti-patter that Jakub pushed back.
> It would complicate any possible parse.
> If we have this case we introduce a new type. Our infra is already
> flexible for that.
>
>>>>>       -
>>>>>         type: flags
>>>>>         name: telemetry-field-mode
>>>>>         entries: [read, write]
>>>>>         doc: Bitmask of access modes supported by a telemetry field.
>>>>> +  -
>>>>> +    type: enum
>>>>> +    name: retired-page-status
>>>>> +    value-start: 1
>>>>> +    entries: [retired, pending, failed]
>>>>> +    doc: >-
>>>>> +         Status of a retired page. retired means the page is reserved and out
>>>>> +         of service; pending means the retirement is queued but the
>>>>> +         reservation is not complete yet; failed means the reservation failed
>>>>> +         and the page may still be in use.
>>>>>     attribute-sets:
>>>>>       -
>>>>> @@ -140,6 +152,30 @@ attribute-sets:
>>>>>             doc: >-
>>>>>                  Bitmask of access modes (read/write) supported by the
>>>>>                  telemetry field.
>>>>> +  -
>>>>> +    name: retired-page-attrs
>>>>> +    attributes:
>>>>> +      -
>>>>> +        name: node-id
>>>>> +        type: u32
>>>>> +        doc: Node ID targeted by this retired pages operation.
>>>>> +      -
>>>>> +        name: address
>>>>> +        type: uint
>>>>> +        doc: Device address of the retired page.
>>>>> +      -
>>>>> +        name: size
>>>>> +        type: uint
>>>>> +        doc: Size of the retired page in bytes.
>>>>> +      -
>>>>> +        name: status
>>>>> +        type: u32
>>>>> +        doc: Retirement status of the page.
>>>>> +        enum: retired-page-status
>>>>> +      -
>>>>> +        name: max-pages
>>>>> +        type: uint
>>>>> +        doc: Maximum number of pages that can be retired on this node.
>>>>>     operations:
>>>>>       list:
>>>>> @@ -287,6 +323,38 @@ operations:
>>>>>                 - field
>>>>>                 - field-name
>>>>>                 - mode
>>>>> +    -
>>>>> +      name: get-retired-pages
>>>>> +      doc: >-
>>>>> +           Retrieve the pages retired on a retired-pages node, one entry per
>>>>> +           page. The dump is flagged as interrupted if the list changes while
>>>>> +           it is being read.
>>>>> +      attribute-set: retired-page-attrs
>>>>> +      flags: [admin-perm]
>>>>> +      dump:
>>>>> +        request:
>>>>> +          attributes:
>>>>> +            - node-id
>>>>> +        reply:
>>>>> +          attributes:
>>>> Nit:For large number of pages, size and node-id would be repetitive
>>> v5 drops node-id from the dump entries, like the error-counter dump.
>>> The size stays per page, so a node can report pages of different
>>> sizes, if a device ever retires memory at more than one granularity.
>>>
>>>>> +            - node-id
>>>>> +            - address
>>>>> +            - size
>>>>> +            - status
>>>>> +    -
>>>>> +      name: get-retired-pages-info
>>>> max-pages since it's not generic ? Or maybe we can add size as part of info
>>>> since it will remain same per node.
>>> With the size per page, the info is only max-pages for now, and the
>>> operation can grow if more node limits come up.
>>>
>>>>> +      doc: >-
>>>>> +           Retrieve the retired page limits of a retired-pages node.
>>>>> +      attribute-set: retired-page-attrs
>>>>> +      flags: [admin-perm]
>>>>> +      do:
>>>>> +        request:
>>>>> +          attributes:
>>>>> +            - node-id
>>>>> +        reply:
>>>>> +          attributes:
>>>>> +            - node-id
>>>>> +            - max-pages
>>>>>     mcast-groups:
>>>>>       list:
>>>>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>>>>> index 82fcc766b84b..b6e203448d22 100644
>>>>> --- a/drivers/gpu/drm/drm_ras.c
>>>>> +++ b/drivers/gpu/drm/drm_ras.c
>>>>> @@ -69,6 +69,14 @@
>>>>>      *     Each field contains the uAPI defined enum string, its numerical value,
>>>>>      *     and its mode bitmask, which encodes read/write capabilities.
>>>>>      *
>>>>> + * 11. GET_RETIRED_PAGES: Dump the retired pages of a given node.
>>>>> + *     Userspace must provide Node ID.
>>>>> + *     Returns one entry per page with its address, size and status.
>>>>> + *
>>>>> + * 12. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
>>>>> + *     Userspace must provide Node ID.
>>>>> + *     Returns the maximum number of pages that can be retired.
>>>>> + *
>>>>>      * Node registration:
>>>>>      *
>>>>>      * - drm_ras_node_register(): Registers a new node and assigns
>>>>> @@ -121,6 +129,13 @@
>>>>>      *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
>>>>>      *       to enforce permissions checks on telemetry operations.
>>>>>      *
>>>>> + * - RETIRED_PAGES:
>>>>> + *     + The driver must implement the query_retired_page() callback, returning
>>>>> + *       the retired page with the lowest address at or above a cursor, and
>>>>> + *       -ENOENT when there is none.
>>>> With many retired pages (say 10,000 or more), the dump calls into the driver
>>>> once per page.
>>>>    From a quick look, the driver walks over the list to find lowest address
>>>> and for such large number
>>>> of pages would cause a noticeable delay
>>>> Wouldn't it be better to take a snapshot?
>>> I'd like to get the basic support in first.
>>>
>>> Anyway, the list is limited by max-pages the firmware can track,
>>> so it is not an issue in practice.
>> The maximum page count reported by the firmware is currently in the tens of
>> thousands for our
>> usecase. So this would be an issue in practice
>>
>>> Also, if we ever have that many bad pages we have bigger problems
>>> than the dump time.
>>>
>>> So, the v5 that I'm about to send won't include that, but anyway the
>>> patch with the snapshot is ready and tested, for a follow-up:
>>> https://github.com/rodrigovivi/linux/commits/xe-ras-retired-pages-snapshot
>>>
>> Sure will take a look at this.
> Please take a look there, but I will only send that after you give
> a confirmation that you are good with the patches 1 and 2 on v5.
>
> So v6 would address any remaining concern from you + add this patch
> on top. I don't plan to squash on Aravind patch to avoid changing
> his patch a lot.


for v6 i took a look at the github. Can you please combine the 3rd patch
with the existing ones as functionality for dump changes and it would be 
tough to
review it separately.

Thanks
Riana


>
> Thanks,
> Rodrigo.
>
>> Thanks
>> Riana
>>
>>> Thanks,
>>> Rodrigo.
>>>
>>>> Thanks
>>>> Riana
>>>>
>>>>> + *     + The driver can implement query_retired_pages_info() to report the
>>>>> + *       maximum number of pages that can be retired.
>>>>> + *
>>>>>      * Netlink handlers:
>>>>>      *
>>>>>      * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
>>>>> @@ -147,6 +162,10 @@
>>>>>      * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
>>>>>      *   dumpit operation, enumerating all telemetry fields and their supported
>>>>>      *   access modes for a telemetry node.
>>>>> + * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
>>>>> + *   operation, listing the retired pages of a specific node.
>>>>> + * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
>>>>> + *   doit operation, fetching the retired page limits of a specific node.
>>>>>      */
>>>>>     static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>>>>> @@ -162,6 +181,8 @@ struct drm_ras_ctx {
>>>>>     	unsigned long restart;
>>>>>     	/* Node targeted by a telemetry get/set doit */
>>>>>     	struct drm_ras_node *node;
>>>>> +	/* Which retired page address to restart the dump from */
>>>>> +	u64 cursor;
>>>>>     };
>>>>>     static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
>>>>> @@ -169,6 +190,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
>>>>>     /**
>>>>>      * drm_ras_node_get() - Look up a RAS node by ID and take a reference
>>>>>      * @node_id: ID of the node to look up
>>>>> + * @type: Expected type of the node
>>>>>      *
>>>>>      * Looks the node up in the global xarray and, if found, takes a reference to
>>>>>      * it so that it cannot be freed while the caller is using it. The lookup and
>>>>> @@ -179,16 +201,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
>>>>>      *
>>>>>      * The caller must drop the returned reference with drm_ras_node_put().
>>>>>      *
>>>>> - * Return: the referenced node, or NULL if no node with @node_id is registered.
>>>>> + * Return: the referenced node, or NULL if no node of @type with @node_id is
>>>>> + * registered.
>>>>>      */
>>>>> -static struct drm_ras_node *drm_ras_node_get(u32 node_id)
>>>>> +static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)
>>>>>     {
>>>>>     	struct drm_ras_node *node;
>>>>>     	xa_lock(&drm_ras_xa);
>>>>>     	node = xa_load(&drm_ras_xa, node_id);
>>>>> -	if (node)
>>>>> +	if (node && node->type == type)
>>>>>     		refcount_inc(&node->ref);
>>>>> +	else
>>>>> +		node = NULL;
>>>>>     	xa_unlock(&drm_ras_xa);
>>>>>     	return node;
>>>>> @@ -412,7 +437,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>>>>>     	u32 value;
>>>>>     	int ret;
>>>>> -	node = drm_ras_node_get(node_id);
>>>>> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>>>>>     	if (!node)
>>>>>     		return -ENOENT;
>>>>> @@ -461,7 +486,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
>>>>>     	u32 threshold;
>>>>>     	int ret;
>>>>> -	node = drm_ras_node_get(node_id);
>>>>> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>>>>>     	if (!node)
>>>>>     		return -ENOENT;
>>>>> @@ -603,7 +628,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>>>>>     	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>>>>> -	node = drm_ras_node_get(node_id);
>>>>> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>>>>>     	if (!node)
>>>>>     		return -ENOENT;
>>>>> @@ -699,7 +724,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>>>>>     	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
>>>>>     	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>>>>> -	node = drm_ras_node_get(node_id);
>>>>> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>>>>>     	if (!node || !node->clear_error_counter) {
>>>>>     		drm_ras_node_put(node);
>>>>>     		return -ENOENT;
>>>>> @@ -770,7 +795,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>>>>>     	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
>>>>>     	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
>>>>> -	node = drm_ras_node_get(node_id);
>>>>> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
>>>>>     	if (!node)
>>>>>     		return -ENOENT;
>>>>> @@ -781,6 +806,176 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>>>>>     	return ret;
>>>>>     }
>>>>> +static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
>>>>> +{
>>>>> +	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
>>>>> +	struct drm_ras_node *node;
>>>>> +
>>>>> +	node = drm_ras_node_get(nla_get_u32(attr), DRM_RAS_NODE_TYPE_RETIRED_PAGES);
>>>>> +	if (!node)
>>>>> +		NL_SET_BAD_ATTR(info->extack, attr);
>>>>> +
>>>>> +	return node;
>>>>> +}
>>>>> +
>>>>> +static int msg_put_retired_page(struct sk_buff *msg, u32 node_id,
>>>>> +				const struct drm_ras_retired_page *page)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	return nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status);
>>>>> +}
>>>>> +
>>>>> +static int dump_retired_pages(struct sk_buff *skb, struct netlink_callback *cb,
>>>>> +			      struct drm_ras_node *node)
>>>>> +{
>>>>> +	const struct genl_info *info = genl_info_dump(cb);
>>>>> +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
>>>>> +	struct drm_ras_retired_page page;
>>>>> +	void *hdr;
>>>>> +	int ret;
>>>>> +
>>>>> +	for (;;) {
>>>>> +		ret = node->query_retired_page(node, ctx->cursor, &page);
>>>>> +		if (ret && ret != -ENOENT)
>>>>> +			return ret;
>>>>> +
>>>>> +		/* Never zero, so the first message is checked as well */
>>>>> +		cb->seq = page.generation + 1;
>>>>> +		if (ret == -ENOENT)
>>>>> +			return 0;
>>>>> +
>>>>> +		hdr = genlmsg_iput(skb, info);
>>>>> +		if (!hdr)
>>>>> +			return -EMSGSIZE;
>>>>> +
>>>>> +		ret = msg_put_retired_page(skb, node->id, &page);
>>>>> +		if (ret) {
>>>>> +			genlmsg_cancel(skb, hdr);
>>>>> +			return ret;
>>>>> +		}
>>>>> +
>>>>> +		genl_dump_check_consistent(cb, hdr);
>>>>> +
>>>>> +		genlmsg_end(skb, hdr);
>>>>> +		ctx->cursor = page.address + 1;
>>>>> +	}
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
>>>>> + * @skb: Netlink message buffer
>>>>> + * @cb: Callback context for multi-part dumps
>>>>> + *
>>>>> + * Appends one message per retired page, in increasing address order. The
>>>>> + * dump resumes from the next address after a buffer overflow, and is flagged
>>>>> + * with %NLM_F_DUMP_INTR if the list changed between messages.
>>>>> + *
>>>>> + * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
>>>>> + *         (requires multi-part continuation), or a negative error code on
>>>>> + *         failure.
>>>>> + */
>>>>> +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
>>>>> +					struct netlink_callback *cb)
>>>>> +{
>>>>> +	const struct genl_info *info = genl_info_dump(cb);
>>>>> +	struct drm_ras_node *node;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	node = get_retired_pages_node(info);
>>>>> +	if (!node)
>>>>> +		return -ENOENT;
>>>>> +
>>>>> +	ret = dump_retired_pages(skb, cb, node);
>>>>> +	drm_ras_node_put(node);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int doit_reply_retired_pages_info(struct genl_info *info, struct drm_ras_node *node)
>>>>> +{
>>>>> +	struct sk_buff *msg;
>>>>> +	u64 max_pages;
>>>>> +	void *hdr;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (!node->query_retired_pages_info)
>>>>> +		return -EOPNOTSUPP;
>>>>> +
>>>>> +	ret = node->query_retired_pages_info(node, &max_pages);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>>> +	if (!msg)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	hdr = genlmsg_iput(msg, info);
>>>>> +	if (!hdr) {
>>>>> +		ret = -EMSGSIZE;
>>>>> +		goto free_msg;
>>>>> +	}
>>>>> +
>>>>> +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id);
>>>>> +	if (ret)
>>>>> +		goto cancel_msg;
>>>>> +
>>>>> +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages);
>>>>> +	if (ret)
>>>>> +		goto cancel_msg;
>>>>> +
>>>>> +	genlmsg_end(msg, hdr);
>>>>> +
>>>>> +	return genlmsg_reply(msg, info);
>>>>> +
>>>>> +cancel_msg:
>>>>> +	genlmsg_cancel(msg, hdr);
>>>>> +free_msg:
>>>>> +	nlmsg_free(msg);
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
>>>>> + * @skb: Netlink message buffer
>>>>> + * @info: Generic Netlink info containing attributes of the request
>>>>> + *
>>>>> + * Return: 0 on success, or negative errno on failure.
>>>>> + */
>>>>> +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
>>>>> +					   struct genl_info *info)
>>>>> +{
>>>>> +	struct drm_ras_node *node;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	node = get_retired_pages_node(info);
>>>>> +	if (!node)
>>>>> +		return -ENOENT;
>>>>> +
>>>>> +	ret = doit_reply_retired_pages_info(info, node);
>>>>> +	drm_ras_node_put(node);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
>>>>>      * @ops: Generic netlink operations
>>>>> @@ -808,10 +1003,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
>>>>>     		return -EINVAL;
>>>>>     	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>>>>> -	node = drm_ras_node_get(node_id);
>>>>> -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
>>>>> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
>>>>> +	if (!node) {
>>>>>     		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>>>>> -		drm_ras_node_put(node);
>>>>>     		return -ENOENT;
>>>>>     	}
>>>>> @@ -892,10 +1086,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
>>>>>     	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>>>>> -	node = drm_ras_node_get(node_id);
>>>>> -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
>>>>> +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
>>>>> +	if (!node) {
>>>>>     		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>>>>> -		drm_ras_node_put(node);
>>>>>     		return -ENOENT;
>>>>>     	}
>>>>> @@ -1100,7 +1293,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
>>>>>     	if (!node->device_name || !node->node_name)
>>>>>     		return -EINVAL;
>>>>> -	/* Currently, only Error Counter and Telemetry endpoints are supported */
>>>>>     	switch (node->type) {
>>>>>     	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
>>>>>     		/* Mandatory entries for Error Counter Node */
>>>>> @@ -1112,6 +1304,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
>>>>>     		if (!node->telemetry_get || !node->telemetry_fields)
>>>>>     			return -EINVAL;
>>>>>     		break;
>>>>> +	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
>>>>> +		if (!node->query_retired_page)
>>>>> +			return -EINVAL;
>>>>> +		break;
>>>>>     	default:
>>>>>     		return -EINVAL;
>>>>>     	}
>>>>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>>>>> index 589c6445eff7..c56220205876 100644
>>>>> --- a/drivers/gpu/drm/drm_ras_nl.c
>>>>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>>>>> @@ -59,6 +59,16 @@ static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A
>>>>>     	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>>>>     };
>>>>> +/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
>>>>> +static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
>>>>> +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>>>> +};
>>>>> +
>>>>> +/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
>>>>> +static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
>>>>> +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
>>>>> +};
>>>>> +
>>>>>     /* Ops table for drm_ras */
>>>>>     static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>>>     	{
>>>>> @@ -126,6 +136,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>>>>     		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
>>>>>     		.flags		= GENL_CMD_CAP_DUMP,
>>>>>     	},
>>>>> +	{
>>>>> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
>>>>> +		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
>>>>> +		.policy		= drm_ras_get_retired_pages_nl_policy,
>>>>> +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
>>>>> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>>>>> +	},
>>>>> +	{
>>>>> +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
>>>>> +		.doit		= drm_ras_nl_get_retired_pages_info_doit,
>>>>> +		.policy		= drm_ras_get_retired_pages_info_nl_policy,
>>>>> +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
>>>>> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>>>> +	},
>>>>>     };
>>>>>     static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
>>>>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>>>>> index 7a1cba70fd50..880b0c2befe3 100644
>>>>> --- a/drivers/gpu/drm/drm_ras_nl.h
>>>>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>>>>> @@ -34,6 +34,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
>>>>>     int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
>>>>>     int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
>>>>>     					    struct netlink_callback *cb);
>>>>> +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
>>>>> +					struct netlink_callback *cb);
>>>>> +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
>>>>> +					   struct genl_info *info);
>>>>>     enum {
>>>>>     	DRM_RAS_NLGRP_ERROR_REPORT,
>>>>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>>>>> index 76bdcc6f96a5..5c3900a53278 100644
>>>>> --- a/include/drm/drm_ras.h
>>>>> +++ b/include/drm/drm_ras.h
>>>>> @@ -28,6 +28,23 @@ struct drm_ras_telemetry_field {
>>>>>     	u32 mode;
>>>>>     };
>>>>> +/**
>>>>> + * struct drm_ras_retired_page - A retired page reported by a driver
>>>>> + */
>>>>> +struct drm_ras_retired_page {
>>>>> +	/** @address: Device address of the page. */
>>>>> +	u64 address;
>>>>> +	/** @size: Size of the page in bytes. */
>>>>> +	u64 size;
>>>>> +	/** @status: Retirement status (enum drm_ras_retired_page_status). */
>>>>> +	enum drm_ras_retired_page_status status;
>>>>> +	/**
>>>>> +	 * @generation: Generation of the retired page list, changed by the
>>>>> +	 * driver whenever a page is added, removed or changes status.
>>>>> +	 */
>>>>> +	u32 generation;
>>>>> +};
>>>>> +
>>>>>     /**
>>>>>      * struct drm_ras_node - A DRM RAS Node
>>>>>      */
>>>>> @@ -184,6 +201,38 @@ struct drm_ras_node {
>>>>>     	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
>>>>>     			     s64 *status);
>>>>> +	/* Retired-Pages Related Callbacks */
>>>>> +
>>>>> +	/**
>>>>> +	 * @query_retired_page:
>>>>> +	 *
>>>>> +	 * This callback is used by drm-ras to list the retired pages of a node.
>>>>> +	 * It must fill @page with the retired page that has the lowest address
>>>>> +	 * greater than or equal to @cursor. @page->generation must be set even
>>>>> +	 * when no page is found.
>>>>> +	 *
>>>>> +	 * The @query_retired_page is a mandatory callback for
>>>>> +	 * retired_pages_node.
>>>>> +	 *
>>>>> +	 * Returns: 0 on success,
>>>>> +	 *          -ENOENT when no page is at or above @cursor, which ends the
>>>>> +	 *                  list.
>>>>> +	 *          Other negative values on errors that should terminate the
>>>>> +	 *          netlink query.
>>>>> +	 */
>>>>> +	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
>>>>> +				  struct drm_ras_retired_page *page);
>>>>> +
>>>>> +	/**
>>>>> +	 * @query_retired_pages_info:
>>>>> +	 *
>>>>> +	 * This callback is used by drm-ras to query the maximum number of pages
>>>>> +	 * that can be retired on a node.
>>>>> +	 *
>>>>> +	 * Returns: 0 on success, negative error code on failure.
>>>>> +	 */
>>>>> +	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
>>>>> +
>>>>>     	/** @priv: Driver private data */
>>>>>     	void *priv;
>>>>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>>>>> index 56e0588af5d5..e7f2da18cc4c 100644
>>>>> --- a/include/uapi/drm/drm_ras.h
>>>>> +++ b/include/uapi/drm/drm_ras.h
>>>>> @@ -12,12 +12,14 @@
>>>>>     /*
>>>>>      * Type of the node. The error-counter nodes expose reliability counters for a
>>>>> - * hardware/software component, and telemetry nodes expose an interface for
>>>>> - * reading and writing telemetry values to a device.
>>>>> + * hardware/software component, telemetry nodes expose an interface for reading
>>>>> + * and writing telemetry values to a device, and retired-pages nodes list the
>>>>> + * memory pages that have been taken out of service.
>>>>>      */
>>>>>     enum drm_ras_node_type {
>>>>>     	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
>>>>>     	DRM_RAS_NODE_TYPE_TELEMETRY,
>>>>> +	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
>>>>>     };
>>>>>     /*
>>>>> @@ -28,6 +30,18 @@ enum drm_ras_telemetry_field_mode {
>>>>>     	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
>>>>>     };
>>>>> +/*
>>>>> + * Status of a retired page. retired means the page is reserved and out of
>>>>> + * service; pending means the retirement is queued but the reservation is not
>>>>> + * complete yet; failed means the reservation failed and the page may still be
>>>>> + * in use.
>>>>> + */
>>>>> +enum drm_ras_retired_page_status {
>>>>> +	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
>>>>> +	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
>>>>> +	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
>>>>> +};
>>>>> +
>>>>>     enum {
>>>>>     	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
>>>>>     	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
>>>>> @@ -73,6 +87,17 @@ enum {
>>>>>     	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
>>>>>     };
>>>>> +enum {
>>>>> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
>>>>> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
>>>>> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
>>>>> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
>>>>> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
>>>>> +
>>>>> +	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
>>>>> +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
>>>>> +};
>>>>> +
>>>>>     enum {
>>>>>     	DRM_RAS_CMD_LIST_NODES = 1,
>>>>>     	DRM_RAS_CMD_GET_ERROR_COUNTER,
>>>>> @@ -83,6 +108,8 @@ enum {
>>>>>     	DRM_RAS_CMD_TELEMETRY_GET,
>>>>>     	DRM_RAS_CMD_TELEMETRY_SET,
>>>>>     	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
>>>>> +	DRM_RAS_CMD_GET_RETIRED_PAGES,
>>>>> +	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
>>>>>     	__DRM_RAS_CMD_MAX,
>>>>>     	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
