Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983EA606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gvlrmi79;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=fUNaJyk4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FE010FB4E;
	Wed, 18 Nov 2026 11:45:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F064B10FB4A;
 Wed, 18 Nov 2026 11:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795002291; x=1826538291;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=X9ZqC4AtLdr6LxevPoDvizhFLDX56v4d+GmTHJLRsDk=;
 b=gvlrmi79J7ty2h4CqP6l1jzuOnWYYHFj9tRo5YfUjzrww6JiPnZgLtbO
 3sXiEdve+v4zMwoEDxBC8KbPH/5EUFxFFUaAbLK80XVesO0EEdmcm3VzV
 GALjQq5JJFqet5Xrtui0d7PId/zPv5pn80FO65Tqwnvwruz/d/vP1qybo
 uNerBKDi/ProCbVvxhaHISPD1B55551AN4uVJvN86Q7dgHkbEMXyFjJr+
 yqz0AcmPHdUoW/PX3be63mHogUuE4vy/sztDJWXTL9ihMolAoGqJrhs+T
 Z3ASyQ24LA/qQjatlN3C1/4njoDBIyx/bH46OTQcCrAfXjXPFDzSGWiNl Q==;
X-CSE-ConnectionGUID: 6TO9Y4gSRsGklqz6WFmnYg==
X-CSE-MsgGUID: dvj2pxliTiGl595DY2BQZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3696565"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3696565"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:44:50 -0800
X-CSE-ConnectionGUID: +HZGi96YSIe72BtWX5d0+A==
X-CSE-MsgGUID: 5i4g7FUwTLmOQ1WdyBGe0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10457741"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:44:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:44:50 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 03:44:50 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:44:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn66UHzSPdmZ1z9YmpEGOpcNmEB4I9WFpO94eMw7FKg0EU9QgPAUduV22Hs3iZ/SsWkR1Mj6p4YMqOsnP4pHCFpmtr9owT+HpVz1DWAA3f9pDbSbym6mGry+ZQVdxNB1qc3WzLjYsJzdPFZy0YINeFosKzi22hxKenEXW4+eqQWXQP36iGbydGolLcCzQ9iXR+9fh2TdFKWZgYmHrvq/luvyNm5tB/1BUtBfpQnmqBeqde3SduN8HaUQ/Zl2j3WSlH3O3dsWvsUuG2mXASjTykiCVlXlVcj2Er3anRa2PlNorvzyu0RWZwFn8Gx53bnuYUSGbqhBnho0leXeOXizZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9ZqC4AtLdr6LxevPoDvizhFLDX56v4d+GmTHJLRsDk=;
 b=EfNCq89J0MO/z+1YXLP9qk2jkrja9E7YGBYi20sKYkhXx7bQbPAfBCePx1oqSvaHcBDSExNgNRia8oQKHMRGit23ZodpqNfKBh/kAVBPjE0PvDK3TTWoG/cBJBkWmPDyIuMDbKI1rOEn333QlipXQ2AhZmsRuWjnUJGNdOn5fRIjVKe966JNDfROdyYD8tCHZ2SUlVuo/1smf6RaVZ7eJjpcxE8WA9smqUy1SH3DWqUAtfYn/3lbkRC++WVjpKg+Ma1eRzTTY03WbCMaxBMnsTBuCagow4rXtdAZtFiiIqBsKTNG5FKaozzxh6mLyax54yiOXcIxUGSRsIgj2FN/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9ZqC4AtLdr6LxevPoDvizhFLDX56v4d+GmTHJLRsDk=;
 b=fUNaJyk41fo20QSqtd9/QkzEJHgefBAjRcrcLYwAP4X7GyXBg2zdObY1+JjV4tXBFFaNfxNNXOTKPwIavfvnshXKQ4dS3kfyUvopAPeC1clkFU4LV+ESEx5VY5ptxXc5rX1YaH+MMcWmnPthhT1nY6XcOMUj59ZkteePYWUmYgo=
Received: from LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:44:47 +0000
Received: from LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b]) by LV2PR11MB6024.namprd11.prod.outlook.com
 ([fe80::38ad:3190:bbb2:412b%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:44:45 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Manna,
 Animesh" <animesh.manna@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
CC: "Kandpal, Suraj" <suraj.kandpal@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>
Subject: Re: [PATCH v7 04/20] drm/i915/alpm: alpm_init() for DP2.1
Thread-Topic: [PATCH v7 04/20] drm/i915/alpm: alpm_init() for DP2.1
Thread-Index: AQHdZQyIPQmn5TgJh0KmMPHLaRJGc7cz2kyA
Date: Wed, 18 Nov 2026 11:44:43 +0000
Message-ID: <345800f1fe804faf4f4246d52ae7f2afd03f85d3.camel@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-5-animesh.manna@intel.com>
In-Reply-To: <20261026054001.799894-5-animesh.manna@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6024:EE_|SA3PR11MB7653:EE_
x-ms-office365-filtering-correlation-id: 801c511d-e89e-4774-20a5-08df45695788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|56012099006|11063799006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info: qKPBrZPvZPEsrrzJY5bedmNTlxJYkZyx6gdFVMai9plOSvm2UR+cMVI+szWzEUMqquv8dqdrEt1jwnW8p0V282tAJykEn+cFIZrSxgauBvg/0Q8cmtMJwMj8x0NpSfP2JKwRIC8JdfUczFjin0Jrdk6eSt+LMLwrd5Dpv0MBslEwjaYfxIAjsdZONnClqdkA8ORd0ihRdgX3pizP26y5uKsss2ico8lUit+UgLUEuKlH3WZaxVkcGTr4dl0nXUHB3WgDaASESx7tiQtAI1qeGQHM3Xk7bTw9onVoF7TnS/xQgV5pEzIhUlggpTKMuYVFzjY6WMVl7PCmJd0uVN9ul7x68g6VFxlwin3jz0oedJirJbA8rCtO7X5KD1FM3ct2nQ7scmaDpbjbBt3E7JmndWnTpFPW0PaGwe0TnqpVku14F2eSP7ZI24jNqt9FNszjwmHnC3yzH+Yld0h0im8AtZPPuY26RJHmXfopRx68OX92g4fFIE/HpAPw2syh5/d2BqKv/6U4jqNjT62LRXCe9TT/oVOfdJDeP8X/EtSAcaqJPJbX6x4BhvWdTDuvHGP5ICx2izec2oKrz8EuZa/eNu7lixMSL0g4M6WstnrJ1Lm1lFgLyTVO1genuXCZpLRR49je61bvzAyggIu2O136bgF//pxjJEyPHPeYGuPBM81zE1dN+zwQvni+oayr1//6rQppg6VBy4UbbQYF168gcZFeWAh0OS793JTF7zGRy0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZvdlhieEJOOHBJbGhha3dsY2U2K0JpUmxBOWVLa1ZjV2FBMUJCTmVEd2ZE?=
 =?utf-8?B?dUNqeDdvQ01QZHZMdEpZYkhlelIwUC9Ga2hySm9QamVTTStxR2Z6U3BoZWt1?=
 =?utf-8?B?SXdJQWNrVjBnT0pjUG5KMGpqUklpYmRYNWo1c21mald0cVc1QWdRZDNtbFZK?=
 =?utf-8?B?RCtKS3lwMUM2bUJUd2F6NDFaUElUTi8ybUdjZ1dKbjFyK3hjbmUvbzcwNERW?=
 =?utf-8?B?RmM1TGxmaVFVSTV4dmw2bVdCS1p6TnBtUWgwTWgvWUJBZjVjY3lsT0F5eG9j?=
 =?utf-8?B?ZDhKSUhOKzV3dklsQ3ZKOExrV3RzNGplYnpQQ2d0ZzF5QUNhRXBHeTk4bmwy?=
 =?utf-8?B?ZnkvL0xmWjZrL3FmWk5uRGh0eFJ5KzdFSm93bWoxempTREh3akgyWmFDOEVK?=
 =?utf-8?B?eHJKTW1GcTV0aDkveFUrSEZCKy96RVY3RUcyK29jMG42Nmd2alFEaGxreU1C?=
 =?utf-8?B?V0pTbUxTMEVaVDd5ak9XSUxIL1FzaC9DdzFGc1JZZmVXK2hJU0VTV2Nwd2ZI?=
 =?utf-8?B?OUJQdlJiaWoxZTlSWTdIVFU1ZjhaMlNIcjAvYStZR0RFdW9aSzg4SXJLdnVY?=
 =?utf-8?B?ZFNvV1RnTXRUZlhRMG5Wb1NYNWMzSCt6cWZvWDUxNGdOTUlUUTJKTGl0N0ty?=
 =?utf-8?B?ZmFaZlVCUllaQWVhZ3FHM2hsRHhPVXIrMnJjR0dYelZ0U1g5U1I3anBJMzNv?=
 =?utf-8?B?OWIwWC8zU2ZjWEhRQ25jSHdYY2ZXdCtvci9TNHdvbWdBNENsTEIxMVlkemFE?=
 =?utf-8?B?c1NERU8rSXVtdDZGMEJ0SXByS1Fsb2NDandqNDNLQVZEaDZQS1l0dllkaUlq?=
 =?utf-8?B?OE00OUdrcTBBOG0zdG9yK3JZZC9md2JlL3hIcWh4MHdlVEJibEIrMFVKbTNv?=
 =?utf-8?B?S0pEYzFGdEhZREc4OWt5VDd1OHpwMkpCdlg5UFJNeVlHSUMrNmZFZnhyMmNp?=
 =?utf-8?B?bkpTaVAwZVZQSXdVbytENDZyNWtwLzVZL2hCR2JmYzVMMnRwRjBCRHg5Z1JS?=
 =?utf-8?B?bVd5R3dRUEpuQzY2OE82bEdSUUJqdGt2Nlo3aThNSCtqbzBpV2xDdUwzWWhq?=
 =?utf-8?B?QWlYZk5xUmw0KzR2WlFzbHY0SFJkVGZsQnpsbUdkU0E2QUJwZEJLb09EMVFq?=
 =?utf-8?B?KzhLN1NmZlkrNDJaY0lFd0o3aXNnOTVicXFiUExWUnZMRTJJd1lpNjNERDBs?=
 =?utf-8?B?a01LcWQ0VUx1L1BoQ3I0SHdZRlg5U3ZQcmdGSUhKamRYSzBMbm53S3FuRitm?=
 =?utf-8?B?dVMwWWt1MW5mL2xQSjM1U25Nc2lRc0ZoeUFSYXZCRHNjTlhuNG45bkZGV1hH?=
 =?utf-8?B?blBBSzZOcTZWdEl2bkZoWURJeXE2dGtEanU0NXBsTkpxb1RMa0huUDZwczlm?=
 =?utf-8?B?cTU3YUFXQTRKbGM1bHJyM3RRWld3YlFJNDVZaE5xZmU2UElYK21HVm4yTkpF?=
 =?utf-8?B?QWhyYXVMZVR5SUJWdDJ6azRtNWlZM1QwUUZUQ3hkZ1VYS1hBS3NvdVdXRTR4?=
 =?utf-8?B?K2NMNUI3bGJnelZRbXlIVkpPZXV6enp4ODZBTG5oOWhlb0VWYnpPMjJtdnZR?=
 =?utf-8?B?eTE3NVdRUVhZVkZIM0ZGcG1vZmFka2pMWktYVGJrRUpqTCtCcWRUdElnTVp0?=
 =?utf-8?B?NWo5TGk2eWp1QnpORVVrRGszaEFaME55ZW1WSlljM0VRcUF2T3B5MUZ0Y2pD?=
 =?utf-8?B?ZG14WGNOYmg2NjlKeENsdy9YeW1lc3hMdWFqSWU3VGFtN3ZlQVVzWXRQOE54?=
 =?utf-8?B?dWxOK2RKTlZBRE1sSmowTStib1RxZEtHbUM0R3EvNjQ1T0tDdTliaXJieElp?=
 =?utf-8?B?VCtsQzZDTWRmZEYyVnRWZDFTVTRsck1Zclc1eE5XVHhXb3ZUeU8vRWRzMTRU?=
 =?utf-8?B?ZmlKRW5hRE4zTzVIL0JjRHpNZFc4eTZnOEZ0S0NTQVV6ZnlmdVlETkF1WlBj?=
 =?utf-8?B?YmVBcEt1dzRnaVRtaXJMZzVHTERZRk9BUDYwcGwrdXB4RzJZdDg2TTRvOGQx?=
 =?utf-8?B?VDBJWDMxaEJZSzBpT3ZhM205N1JtVmtGRUxncGlia1FkRytxeGJ5eEFTOHNk?=
 =?utf-8?B?TVFac2NhbHBuSzVMdytkQk9KZ0x4T3NqbmhQYnRhQThUdjRyMDZGN2pxdmxJ?=
 =?utf-8?B?N0IwelRqR29aZ0hBRHM0dEo4MWFWbnRXZG1tOUYrRjNaWGZteUpPVEc5RjhR?=
 =?utf-8?B?eHdLdjl4YnZHeUdMQStmQWQvR2Z6Y25lSHR5bWRkSTRTZ1BBQTJIMnZoenp4?=
 =?utf-8?B?V3lwWDYwQ2pBaHY2Q3ppN1gycGkrdkVsWUMvUkFyTzNoekxzeXI1VWM3bW84?=
 =?utf-8?B?T3hvR2lVOTc5OWZxWGw0SEdjUm9QeFZZSkpWVFNnUHFIa3huNTlNcEtrS0xE?=
 =?utf-8?Q?72mj2XR9NJv30p1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9FAD140762815429BC4B05354869930@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: otxwCVnHQuVktr9G4DQGi0kaFzEk6MEp9BURdyX/BVDPBI1q2O+zI5KbLMBwwGLrx/I85dD/uor7m4a/jhsb+wkDxMep7KMohkaRnp9kbXAmRnZKCdAXno5p0RVzdsdIKcw3FPUC/DQ/H+cHSb1jM9fpvITYIEkWcY/4g3ftDK0rcuEyJkdtfFPlT5nksRdaCWw6CTkGs9Ne+Hk4jEZvEvaNjcVtZ87oURrc2gvniekA1h3aSxgcl3hs5sFBoEGnF51z+kk6nYAH0Zyh/d56LwT7QGfCYvFZvg17wgeB3/q2POls8DYrFXPhH6bcQpv9kpphKcke16QByWILdMrj+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801c511d-e89e-4774-20a5-08df45695788
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 11:44:43.1671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8e78Sa+dWh+YHI8dpNn37TZlPHZrujsnYbgOKdPI8wSYalF8fo9+aRgyaICXC40fCYMkGVelFyfanYBcPGdjLV3aICPnuRIUVlIy8shplc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
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
PiBJbml0aWFsaXplIEFMUE0gZm9yIERQMi4xIGFuZCBzZXBhcmF0ZSBvdXQgQUxQTSBtdXRleC1p
bml0DQo+IGZyb20gYWxwbS1pbml0Lg0KPiANCj4gdjI6IFNlcGFyYXRlIG91dCBtdXRleC1pbml0
LiBbSmFuaV0NCj4gdjM6IFJlZmFjdG9yIGZ1cnRoZXIgdG8gYXZvaWQgRElTUExBWV9WRVIgY2hl
Y2sgaW4gbXVsdGlwbGUgcGxhY2VzLg0KPiBbSmFuaV0NCj4gdjQ6IENvc21ldGljIGNoYW5nZXMu
IFtTdXJhal0NCj4gdjU6IFJlc2V0IGFscG1fZHBjZCBhbmQgc2ltcGxpZnkgc291cmNlLXN1cHBv
cnRlZCBjaGVjay4NCj4gdjY6IERyb3AgZGlzcGxheS12ZXJzaW9uIGNoZWNrIGZvciBlRFAgZm9y
IGJhY2t3YXJkIGNvbXBhdGlibGUuDQo+IHY3Og0KPiAtIFJlYWQgQUxQTSBEUENEIGluIGRldGVj
dCBvbmx5IGZvciBEUCwgZURQIGFscmVhZHkgZG9lcyBpdC4gW0pvdW5pXQ0KPiAtIE1vdmUgc291
cmNlLXN1cHBvcnRlZCBjaGVjayBpbnRvIGludGVsX2FscG1faW5pdC9fZHBjZCgpLiBbSm91bmld
DQo+IC0gQ2hlY2sgc291cmNlIHN1cHBvcnQgaW5zdGVhZCBvZiBzaW5rIGNhcHMgaW4gaW50ZWxf
YWxwbV9kaXNhYmxlKCkNCj4gwqAgYXMgYWxwbV9kcGNkIGlzIHJlc2V0IG9uIGRpc2Nvbm5lY3Qg
YmVmb3JlIHRoZSBDUlRDIGlzIGRpc2FibGVkLg0KPiDCoCBbU2FzaGlrb10NCj4gDQo+IENjOiBK
b3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IFN1cmFqIEthbmRwYWwgPHN1cmFqLmthbmRwYWxAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbmltZXNoIE1hbm5hIDxhbmltZXNoLm1hbm5hQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBk
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYyB8IDE5ICsrKysrKysrKysr
KysrKysrKy0NCj4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwLmPCoMKg
IHzCoCA5ICsrKysrKy0tLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2FscG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfYWxwbS5jDQo+IGluZGV4IGNiMWQ2OGZlZjE5OC4uYjYzMDc4NjJiNzU2IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiBAQCAtNDMsMTEgKzQz
LDIxIEBAIGJvb2wgaW50ZWxfYWxwbV9pc19hbHBtX2F1eF9sZXNzKHN0cnVjdCBpbnRlbF9kcA0K
PiAqaW50ZWxfZHAsDQo+IMKgCQkoY3J0Y19zdGF0ZS0+aGFzX2xvYmYgJiYNCj4gaW50ZWxfYWxw
bV9hdXhfbGVzc193YWtlX3N1cHBvcnRlZChpbnRlbF9kcCkpOw0KPiDCoH0NCj4gwqANCj4gK3N0
YXRpYyBib29sIGludGVsX2FscG1fc291cmNlX3N1cHBvcnRlZChzdHJ1Y3QgaW50ZWxfZHAgKmlu
dGVsX2RwKQ0KPiArew0KPiArCXN0cnVjdCBpbnRlbF9kaXNwbGF5ICpkaXNwbGF5ID0gdG9faW50
ZWxfZGlzcGxheShpbnRlbF9kcCk7DQo+ICsNCj4gKwlyZXR1cm4gaW50ZWxfZHBfaXNfZWRwKGlu
dGVsX2RwKSB8fCBESVNQTEFZX1ZFUihkaXNwbGF5KSA+PQ0KPiAzNTsNCj4gK30NCj4gKw0KPiDC
oGludCBpbnRlbF9hbHBtX2luaXRfZHBjZChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKQ0KPiDC
oHsNCj4gwqAJdTggZHBjZDsNCj4gwqAJaW50IHJldDsNCj4gwqANCj4gKwlpZiAoIWludGVsX2Fs
cG1fc291cmNlX3N1cHBvcnRlZChpbnRlbF9kcCkpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+IMKg
CXJldCA9IGRybV9kcF9kcGNkX3JlYWRfYnl0ZSgmaW50ZWxfZHAtPmF1eCwNCj4gRFBfUkVDRUlW
RVJfQUxQTV9DQVAsICZkcGNkKTsNCj4gwqAJaWYgKHJldCA8IDApDQo+IMKgCQlyZXR1cm4gcmV0
Ow0KPiBAQCAtNTksNiArNjksOSBAQCBpbnQgaW50ZWxfYWxwbV9pbml0X2RwY2Qoc3RydWN0IGlu
dGVsX2RwICppbnRlbF9kcCkNCj4gwqANCj4gwqB2b2lkIGludGVsX2FscG1faW5pdChzdHJ1Y3Qg
aW50ZWxfZHAgKmludGVsX2RwKQ0KPiDCoHsNCj4gKwlpZiAoIWludGVsX2FscG1fc291cmNlX3N1
cHBvcnRlZChpbnRlbF9kcCkpDQo+ICsJCXJldHVybjsNCj4gKw0KPiDCoAltdXRleF9pbml0KCZp
bnRlbF9kcC0+YWxwbS5sb2NrKTsNCj4gwqB9DQo+IMKgDQo+IEBAIC03NTAsNyArNzYzLDExIEBA
IHZvaWQgaW50ZWxfYWxwbV9kaXNhYmxlKHN0cnVjdCBpbnRlbF9kcA0KPiAqaW50ZWxfZHApDQo+
IMKgCXN0cnVjdCBpbnRlbF9kaXNwbGF5ICpkaXNwbGF5ID0gdG9faW50ZWxfZGlzcGxheShpbnRl
bF9kcCk7DQo+IMKgCWVudW0gdHJhbnNjb2RlciBjcHVfdHJhbnNjb2RlciA9IGludGVsX2RwLT5h
bHBtLnRyYW5zY29kZXI7DQo+IMKgDQo+IC0JaWYgKERJU1BMQVlfVkVSKGRpc3BsYXkpIDwgMjAg
fHwgIWludGVsX2RwLT5hbHBtX2RwY2QpDQo+ICsJLyoNCj4gKwkgKiBEb24ndCBjaGVjayBzaW5r
IEFMUE0gY2FwcyBoZXJlLCB0aGV5IGFyZSByZXNldCBvbg0KPiBkaXNjb25uZWN0DQo+ICsJICog
YmVmb3JlIHRoZSBDUlRDIGlzIGRpc2FibGVkLg0KPiArCSAqLw0KPiArCWlmIChESVNQTEFZX1ZF
UihkaXNwbGF5KSA8IDIwIHx8DQo+ICFpbnRlbF9hbHBtX3NvdXJjZV9zdXBwb3J0ZWQoaW50ZWxf
ZHApKQ0KPiDCoAkJcmV0dXJuOw0KPiDCoA0KPiDCoAltdXRleF9sb2NrKCZpbnRlbF9kcC0+YWxw
bS5sb2NrKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiBp
bmRleCA4MTYzMzdlZmViOTEuLmM1NDNmZTU1MWViOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiBAQCAtNjYwNyw2ICs2NjA3LDcgQEAgaW50ZWxfZHBf
ZGV0ZWN0KHN0cnVjdCBkcm1fY29ubmVjdG9yDQo+ICpfY29ubmVjdG9yLA0KPiDCoAkJY29ubmVj
dG9yLT5kcC5wYW5lbF9yZXBsYXlfY2Fwcy5zdV9zdXBwb3J0ID0gZmFsc2U7DQo+IMKgCQljb25u
ZWN0b3ItPmRwLnBhbmVsX3JlcGxheV9jYXBzLmRzY19zdXBwb3J0ID0NCj4gwqAJCQlJTlRFTF9E
UF9QQU5FTF9SRVBMQVlfRFNDX05PVF9TVVBQT1JURUQ7DQo+ICsJCWludGVsX2RwLT5hbHBtX2Rw
Y2QgPSAwOw0KPiDCoA0KPiDCoAkJaW50ZWxfZHBfbXN0X2Rpc2Nvbm5lY3QoaW50ZWxfZHApOw0K
PiDCoA0KPiBAQCAtNjYyOSw4ICs2NjMwLDEwIEBAIGludGVsX2RwX2RldGVjdChzdHJ1Y3QgZHJt
X2Nvbm5lY3Rvcg0KPiAqX2Nvbm5lY3RvciwNCj4gwqAJaWYgKHJldCA9PSAxKQ0KPiDCoAkJY29u
bmVjdG9yLT5iYXNlLmVwb2NoX2NvdW50ZXIrKzsNCj4gwqANCj4gLQlpZiAoIWludGVsX2RwX2lz
X2VkcChpbnRlbF9kcCkpDQo+ICsJaWYgKCFpbnRlbF9kcF9pc19lZHAoaW50ZWxfZHApKSB7DQo+
ICsJCWludGVsX2FscG1faW5pdF9kcGNkKGludGVsX2RwKTsNCj4gwqAJCWludGVsX3Bzcl9pbml0
X2RwY2QoaW50ZWxfZHAsIGNvbm5lY3Rvcik7DQo+ICsJfQ0KPiDCoA0KPiDCoAlpbnRlbF9kcF9k
ZXRlY3RfZHNjX2NhcHMoaW50ZWxfZHAsIGNvbm5lY3Rvcik7DQo+IMKgDQo+IEBAIC03MjcyLDgg
KzcyNzUsNiBAQCBzdGF0aWMgYm9vbCBpbnRlbF9lZHBfaW5pdF9jb25uZWN0b3Ioc3RydWN0DQo+
IGludGVsX2RwICppbnRlbF9kcCwNCj4gwqAJICovDQo+IMKgCWludGVsX2hwZF9lbmFibGVfZGV0
ZWN0aW9uKGVuY29kZXIpOw0KPiDCoA0KPiAtCWludGVsX2FscG1faW5pdChpbnRlbF9kcCk7DQo+
IC0NCj4gwqAJLyogQ2FjaGUgRFBDRCBhbmQgRURJRCBmb3IgZWRwLiAqLw0KPiDCoAloYXNfZHBj
ZCA9IGludGVsX2VkcF9pbml0X2RwY2QoaW50ZWxfZHAsIGNvbm5lY3Rvcik7DQo+IMKgDQo+IEBA
IC03NDg4LDYgKzc0ODksOCBAQCBpbnRlbF9kcF9pbml0X2Nvbm5lY3RvcihzdHJ1Y3QNCj4gaW50
ZWxfZGlnaXRhbF9wb3J0ICpkaWdfcG9ydCwNCj4gwqANCj4gwqAJaW50ZWxfcHNyX2luaXQoaW50
ZWxfZHApOw0KPiDCoA0KPiArCWludGVsX2FscG1faW5pdChpbnRlbF9kcCk7DQo+ICsNCj4gwqAJ
cmV0dXJuIHRydWU7DQo+IMKgDQo+IMKgZmFpbDoNCg==
