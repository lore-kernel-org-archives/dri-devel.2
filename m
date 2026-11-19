Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5B606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bjLQdrbJ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=KOa3FlUc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF4710ECC3;
	Thu, 19 Nov 2026 17:25:07 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B87510EE0C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:24:56 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJH4pr31447053; Thu, 19 Nov 2026 11:24:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8flZzl3n6J+aCG1pKDzpfL0zZFssIr4BJBt70mILS
 44=; b=bjLQdrbJGTrGIy5I66/oysqEWkGhg+n2+22y37LRrRlHQEiRx93pbUfAn
 lEpXDTxC64dhddlhZLiSwjZPYKdS7lrYDVWWH7WkQDznojKghqOxI33TFKTX3kx7
 vtGbqelI0MedHl8kzIKDH3hWW5Xhtih53YAD6k8X8PuYxRY1EAN1+mMNhOZd6bZs
 SJSx0XIxHrhYsCSXQ7ztTiVJGsf+bZNaeDoRNglywQJwBcdIREunpkCi7w8rynCu
 BIBdFbQwyEr6tT+/Tgqum5nxiIUx/sXMV2xl9hPZF042daghYujAbr+oneri0qTA
 yTYp23VdiJGEYcNiVgfn/kxSIYlJw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j1p6d5fch-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 11:24:43 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzS8vIZRaeWSfYnoHymsccGf9HStBlPED+CbJbyTTOnOsl3KgzWCuZ5PdfouMtecW8Tig32VJe5/Xm8v6p2T3DcOpqG8dON16U9UzY8eNA771Z6Cpwe+YmA7c1vuHcdfA6Pd90rAC6PWBBWTPjoPcj2tk/b6IH3tMhe0MrwScFaalihHiwCnRHiJ9wj4YcrGn7q2peHDGKaflCfaoEEKIhxFaCiSyZbb5wvoX5LHw8XjNEq6nfiKv6uEfO2yMpPxkb1gtR1ACxsFIaCqYB0k95SRIPPvs7B6wbipSzZ2atZHt+iKDsU/w92krY+I3RJjAmroLEEUc0kJRYT10+Sr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8flZzl3n6J+aCG1pKDzpfL0zZFssIr4BJBt70mILS44=;
 b=XU4Pc6uWkgl4IimI4oMxmbZUHjJ4paoe31RO/U6TN3mqwlouSbs/rMR352jiz9v1Lz0oZd+y5CJSKZIWiHCDp1j4U9JItamfK0cLCI/cxXofinvxznNkfTJXfFfgiAb63JfmZKpSxwZw1KJX0rioGOWa90bdLYxRW9CDaZNDPMyx7YAscCwPl+ChB0Fm/weNJWfAxMGmagR7P6qerSKiwgp5ozvazOFifwPV5qUQNgoJNomJH7BwH1imIBo+Hq1RZAzO2FbEsQ3CUh4RVlcb2iSk41tPCqH7Ee7y2cYPEclyEKYsaWN32s7dU47DqECnBQbEOrVbQw063WOf+F4ZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ti.com; dmarc=pass action=none header.from=ti.com; dkim=pass
 header.d=ti.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8flZzl3n6J+aCG1pKDzpfL0zZFssIr4BJBt70mILS44=;
 b=KOa3FlUcOYPf/PKL43vaCJ42KDCz/qKKZMtrJ5ofRckgtrTWzixUX9wOtrQY/8tju7i07BrzJSNUdaHBH9woJjDrOgX3itFs1B+oCxjIwx74vWvtsv+RZcsjNiSfxDzSo4Y9OLLZFTpZd2z3w7Gr4xk/kyq2jD1VLvE69qXazuY=
Received: from BN8PR10MB3652.namprd10.prod.outlook.com (2603:10b6:408:ba::10)
 by IA4PR10MB560350.namprd10.prod.outlook.com (2603:10b6:207:145::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:23:59 +0000
Received: from BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a]) by BN8PR10MB3652.namprd10.prod.outlook.com
 ([fe80::86d1:377b:3bec:884a%7]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 17:23:58 +0000
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Javier Martinez Canillas
 <javierm@redhat.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Menon, Nishanth"
 <nm@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 LiangCheng Wang <zaq14760@gmail.com>,
 "SAHU, JEEVAN KUMAR" <j-sahu@ti.com>, "Hegde, Yogesh" <y-hegde@ti.com>,
 "Sadik, Shaik Mahammed" <s-sadik@ti.com>, "Bajjuri, Praneeth"
 <praneeth@ti.com>
Subject: Re: [PATCH v3 00/14] Add DRM driver for Solomon SSD16xx e-paper
 display controllers
Thread-Topic: [PATCH v3 00/14] Add DRM driver for Solomon SSD16xx e-paper
 display controllers
Thread-Index: AQHdYBIJicBDufohR0WBrO0yH0Jr3LcnYN6AgAAHPICADm1GgA==
Date: Thu, 19 Nov 2026 17:23:58 +0000
Message-ID: <ff738606-0ca7-44d9-8389-43bafd624b9e@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <xlv1o6bweu88.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <avMWcdpHuf8CX41p@houat>
In-Reply-To: <avMWcdpHuf8CX41p@houat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ti.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR10MB3652:EE_|IA4PR10MB560350:EE_
x-ms-office365-filtering-correlation-id: 352f3307-b797-40c9-3d7a-08df4661e5b4
x-ld-processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|56012099006|261026140227099003|261026121527099003|261022115727099003|261022105027099003|10067099003|261022075727099003|261022113327099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: RKKad5xSOgA3azNcDi2iKhcnO/gghmIVAkqC+mhMIbprtAZfeFRxITs0aVsA+5sxPACqyo9ss5Uq84d4x2geEbeVIbD7FMUWkiTUhLZIbZnkxxFDcX4accGwVnUyUjLGwdXlHxb80qIEH4Rb5feOEToc8HY1198teYKvg0PMwGJrrnca9oEoigvOO+VCtZsmBz7hXu7GohIilh5a62ayrMEsEkyOkedUXo0gcZVGlNy5HdFcQpO5lFxGVnnSUxTCkqD/eEgrv4t//qbNaPv15oC59PY7OGo+lznQKQnJID0rZN+NQJ64tWrzOgjqevvKRawrg7xD5plQljKwxNcCWj5e2w5rNoT8dNrcCftMIm26TJ1DNQEFKDAoSGZQSZwUAdwtw8SHWLTCfF4eUpqh50b9KF2pbf+aawHY+5sZEG0MUOxj+rK/gNY+kDY+OSBhcSPjbu40h/Q+C16CuwpHUuLovmadPqXy7y/VtB3fkGH6NFBJzZZHlve+BYB12j+Ver1aRI4O0tuPTXslIF0+X76KPirdftdqL6e0cmH2SPnXcC1uaL27hxdd6jvAdjyoSrQ/rb/t/totsJlWQaumHZ5DrFHSOYro5c5Yf8de0Y7on0tFopzaILpqMIDqcLK1VwZRdUgn0myZn5cZ61cgW2aw3Gan063UJl2PJ//XYis=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3652.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(261026140227099003)(261026121527099003)(261022115727099003)(261022105027099003)(10067099003)(261022075727099003)(261022113327099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFkxWnBRRzdJcUpING94N0p1dHJxRTFvZmNKYnVaZ3VnOE5pL1Z6M2QrcGJl?=
 =?utf-8?B?UEFVVzhnSFVETnZvL21KTFV0QTB6dldFcXo0Vms2UnBaS2RaUEdKbHIrMWxi?=
 =?utf-8?B?dnRDQVVneGVPR1RJRy9HbVZwZnRHUUNjUXBkL2FpZFFnM0srN3luU1RqbWdz?=
 =?utf-8?B?T0pVSDQ0QjY5N3crM3p6NmhxZU1pWlVqSDYrNnNPYitwZVM3YjIyc1AxeExF?=
 =?utf-8?B?enNHY2dqOHg5SFRHaXZ3dHpBelo1VVhPWnJmOEhKZy9NTkprcXRDbHN0VEd1?=
 =?utf-8?B?SktuQU91Q2ZCMFhZV3E3NUM1UjNmcDd1MWM0akc0ZmlzSmNwTTRqVzd6ZjZ2?=
 =?utf-8?B?RmRpam55UGF6NjRNc24vOFp6YmFlVkxzbW9MY3lRUTFvemtISWRTYTN2ZWk1?=
 =?utf-8?B?VVo5dzduQnFnVVBoMHhpK3dJaTBzem5oYy9lMkNPS2F1NW15cW9xZkNCMkNI?=
 =?utf-8?B?elJwSFYvdU1kQUllNFBWYVNWRXVGQXBtbjJSQk9Ub3Y1MDEyNGxMUjVzK3JD?=
 =?utf-8?B?c1pJM3NVdS94K3g4dFpDWWhQbittcXBXV2hadG1YODduNU5zbE9EMkNPMHh2?=
 =?utf-8?B?dUNLVmY0WklUSXpwcVJkR2ErMU5MeEF3aVJoeWFvcTdwdDg0eTFCQi9TMkx1?=
 =?utf-8?B?QjBDRk1qYTU5QXhyNDdwV1ZWbHFQaVk2dlpvUGp5ejBhckpOQ3VuOFVxeEgy?=
 =?utf-8?B?VnpGSkJUUldTWnExZjBvdU5zRk52b3hUYlZ1QTFtcVpjSlFuYndhWnNsTXdl?=
 =?utf-8?B?elZuYTJZcnZ2YmZISGFjU3VUUlpZNk5aSVpPQWJiZ1Vwa2YzWTNuMkdnbk1K?=
 =?utf-8?B?VEs1dHkrOHd0RTBzZE9YOXlnVlpRYUFxZWdzRWdPR3I3dHE0c1g5a2prQVpz?=
 =?utf-8?B?L3I1UExGRlc1Qmh3eDVBbEtVRXV2cDgvUGZMVTBLRVAraXdrKzY1SHBuOUVS?=
 =?utf-8?B?VUZpdzIxOUdubU9nRjZQREhjaUkrREJ4dC9Fbkl2L3ZrbGlLVHBtQWVrcGc1?=
 =?utf-8?B?WklHTkNhc1MvUWl3KzVoMU9FcVdxWURvY0ZUNDl4cnVqSE5RVU1CRU91clky?=
 =?utf-8?B?QmJhcHpzT2M2cHNQU2RpcDJvYjZmS2ZLZUJlYWllR2VmM0tDcVV0VnhIcm82?=
 =?utf-8?B?L3RxM3lST3plbVpZczBzTFhMRjVJNldvVHpLUW5MTi95cndLUk8yNVg0bEhq?=
 =?utf-8?B?TGlqazZialc3QnlqSGpPeVhFa1U5NWl5ZjM4RU1NTUlNaUVwOWs0QmxwaVNB?=
 =?utf-8?B?bWhIV0YxaXFrOXgrckRNRFRuV2JGZE4ra1p4Wndkc3ZOZms3ZHFnQzI4YWdp?=
 =?utf-8?B?ZTNqeGVLb0RDaGQ4Wi9YUTQ1SDQxZDlMWDlxNGNsNWI3d0gxdkNHWUVDMnFW?=
 =?utf-8?B?YnRXTWg5aWt6UHR2NTZ2N2V3dVRwWitReEpuZTZDZ2xlU0ZJNEQ1TnNXV21q?=
 =?utf-8?B?RTFCN1lMK21xYzU4aWd4KzJaeUtCM0JRZ2d5dzRid3N5aTFSbDdPYXVkWTJZ?=
 =?utf-8?B?SlRSSWo3c2pvRzIxbHBEWUNkcGRqZ0RwQVlhTXkzTnpBOTZoa0s5WmNCR2Jn?=
 =?utf-8?B?SFdXNDgyV29yN1NYWkVkbFJZZzNCbmNmOUFyOWtKUHJNeXBHSnRwOU9pVWM5?=
 =?utf-8?B?U2pIUnlGNDE0STNsbE5RWE5OZjVWSTFmSGp4N1A4MCtJQVNsNVNMSTBqeFVX?=
 =?utf-8?B?eHlLY2FXemxoOWMrTDdPd2NkSDA5UGpZZ3NPTHRqREgyWnh2SS9DNk1mMmRF?=
 =?utf-8?B?WnNwVHdVU2owaEtoaG9lTFN3am9zc3k4L3grL29JRERCL2VQczZoUzgvRkhI?=
 =?utf-8?B?aWdKbWR5aFU0MENTb2dnemJ3SWQwa1NOZEkwSm92eit2bWpmZWtpanlYaEtx?=
 =?utf-8?B?bVMxTDI0ekx5eUMyT3I3SVBJU1Uxa3pFcEIvZld6a3NrdStkMVdZN2RXUFEy?=
 =?utf-8?B?K1JCb1IzdTVHZXdON1FRV3RWYVZtLzJlRW5rblBuT1lkK2ZhUTRwdDFtQ0lt?=
 =?utf-8?B?Ykd4ZTQzZGU4R2xiQlRiL3Q4bmdtK3dEY0NVbHI2QTY5dmVQT0M2ZGFsc2t6?=
 =?utf-8?B?dkNWOGF4WmYvWGsrSFkvNndGdjlIME9xTGR5U2I2Nm1sV2ZUeWNGbnhXSkVs?=
 =?utf-8?B?YzNEa0JHNlZPQnhJampqSDNrY0Q1NjVETFY2dFdNZ3NvZ3NRNVdubnA3TFRO?=
 =?utf-8?B?UlFYWEp1S2xNaG1xRTdiSDV3c2tzdGhoU0dQbmhHVi95UnRWOHJKR0xTR2VC?=
 =?utf-8?B?LzZySzk3cksydWQ0LzhjMUl0dm5ZZGMwOENiU3A1OWl1T1I5c1JTZEl4L1g3?=
 =?utf-8?Q?FsVCQ/n1wTjHyW67W+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DC0AAEE8D83294496357EC75B00781F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HJI0R6c+6EURCsSQU+os6fvt8iqTM1+smBDkSnTeEbXWM5aikA83IH5VRUm3n04wDm23CrLy5pnmUvpuoihgKqnE0ftnNFHCC87/MNOkE12DcUx+wQ0nrTaxiDhoLYngAdzJ7Yji9SlGXnMMG74pty/yOblSrC5jF4ynn5Rcl6yz4NjezQGEP95Lus29l0oT6eg784AtPefC5e94ZAppMNTvDoN9oZYou9tF8quKVqPrtyOKaJlinEDcdAO1lwyR6h/8kBSK4BKKM5sle1jXmDRykPAnyQXdyvab07fnhfR38lEed/aP35sOIWKL6EzWZN1rrpLL28iYCJ1MNGwOog==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3652.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352f3307-b797-40c9-3d7a-08df4661e5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 17:23:58.8535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GmpW5/fE+z3gD0QL99URHYg88206fWGg1CwvwM5XiRQyX+WIDRnG1Vcpgo0Kq7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB560350
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2OSBTYWx0ZWRfX9oqBJLBz1c7O
 jdUD40jtzuVyCt3gy4s6aNKpopjusOHfbAGg6GRYdTQsfeWmpohx68csakdOHm0dUHfAV8RQ0F2
 g/BcUx1sw1LJlGRkDuv9EW8y12C2LMegfBxL+dHW2W+Ggb2Dtdz1rKH7aNgIxhb/bMkUqYNa5RM
 ixid20QcM4bn4oBDV87yO5WNrJraOHyTA6dGSvxbXa4/Tt7BbwKN8114QsNpRd6X+vmcYwadz+k
 bNWKJmH6+mK09GyT+TlhTgwPvnRPwDMaVll6A9HNrf4Exz8QoGDk0j4yWahJuWS571YZmttPd8k
 k+wiaqF9zC5W+7eYWibCSe4FnraHXCwCwuSIHbVIa8U1pb66OCRpXaZwSmanNTb/Xn/S98AnPKQ
 06Fni7e3fKcwNZs9BsoEKuduSJIfW4Msqg5i74uoDLD/kyzsrQFu9mqlXqbVVtC/2TJc+V3oPgf
 mz+mh26Ua1aJnJ9Oy9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2OSBTYWx0ZWRfXzh5EE++s30gA
 up9L6LCac4JexIY1ja806aNtC0Nx0VfYEeTNqtlnjnbZ1Y94penqBzpciJtvycMLfaqiN3h7qir
 vDagINB398BDvdDZ32zXz1mZ1twc1aw=
X-Authority-Analysis: v=2.4 cv=Qc/zLcbv c=1 sm=1 tr=0 ts=6aff30db cx=c_pps
 a=2Xzm8ETwQMStJzsoEhJbWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=u8tZN5zBAAAA:20 a=Ep_Mk7Q0AAAA:20 a=9agzWqybAAAA:20 a=vFMwHQQjAAAA:20
 a=pPcZ8gmpAAAA:20 a=sozttTNsAAAA:8 a=E382MQpOp3A03FxZTPkA:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: IM4fQErOX5u0mNarqqhGJKskWPr-NPJP
X-Proofpoint-ORIG-GUID: IM4fQErOX5u0mNarqqhGJKskWPr-NPJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190069
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTWF4aW1lLCBKYXZpZXIsDQoNCk9uIDExLzEwLzIwMjYgNjozNSBQTSwgTWF4aW1lIFJpcGFy
ZCB3cm90ZToNCj4gT24gVHVlLCBOb3YgMTAsIDIwMjYgYXQgMDE6Mzk6MTlQTSArMDEwMCwgSmF2
aWVyIE1hcnRpbmV6IENhbmlsbGFzIHdyb3RlOg0KPj4gRGV2YXJzaCBUaGFra2FyIDxkZXZhcnNo
dEB0aS5jb20+IHdyaXRlczoNCj4+DQo+PiBIZWxsbyBEZXZhcnNoLA0KDQpbLi4uXQ0KDQo+Pg0K
Pj4gWy4uLl0NCj4+DQo+Pj4gICBkcm0vc29sb21vbjogc3NkMTZ4eDogRXhwb3NlIHJlZnJlc2gg
bW9kZSBhcyBwbGFuZSBwcm9wZXJ0eQ0KPj4+ICAgZHJtL3NvbG9tb246IHNzZDE2eHg6IEV4cG9z
ZSBjb2xvciBtb2RlIGFzIHBsYW5lIHByb3BlcnR5DQo+Pj4gICBkcm0vc29sb21vbjogc3NkMTZ4
eDogRXhwb3NlIHNlc3Npb24gbWFuYWdlbWVudCBhcyBwbGFuZSBwcm9wZXJ0aWVzDQo+Pg0KPj4g
VGhlcmUgaXMgYSBmdW5kbWVudGFsIGlzc3VlIHdpdGggdGhlc2UgMyBwYXRjaGVzLiBUaGV5IGFy
ZSBhZGRpbmcgY3VzdG9tDQo+PiBkZXZpY2Utc3BlY2lmaWMgcGxhbmUgcHJvcGVydGllcywgYnV0
IHRoZSBLTVMvRFJNIHN1YnN5c3RlbSByZXF1aXJlcyBhbGwNCj4+IEtNUyBwcm9wZXJ0aWVzIHRv
IGJlIGdlbmVyaWMgYW5kIHN0YW5kYXJkaXplZDoNCj4+DQo+PiBodHRwczovL2RvY3Mua2VybmVs
Lm9yZy9ncHUvZHJtLWttcy5odG1sI3JlcXVpcmVtZW50cw0KPiANCj4gQW5kIHdpdGggYW4gZXN0
YWJsaXNoZWQgb3Blbi1zb3VyY2UgcHJvamVjdCB1c2luZyBpdC4NCj4gDQoNClRoYW5rcyBmb3Ig
dGhlIHJldmlldywgYW5kIGFncmVlZCBvbiB0aGUgcmVxdWlyZW1lbnRzLiBJIHdpbGwgZHJvcA0K
dGhlIHRocmVlIHByb3BlcnR5IHBhdGNoZXMgZnJvbSB2NCBhbmQgdXNlIGZpeGVkIHBlci1wYW5l
bCBkZWZhdWx0cywNCnNvIHY0IGFkZHMgbm8gbmV3IHVBUEkuDQoNCkkgd291bGQgYWxzbyBsaWtl
IHlvdXIgZ3VpZGFuY2Ugb24gaG93IHRvIG1ha2UgdGhlc2UgcHJvcGVydGllcyBnZW5lcmljLA0K
aW4gcGFydGljdWxhciBvbiB0aGUgb3Blbi1zb3VyY2UgdXNlci1zcGFjZSByZXF1aXJlbWVudC4N
Cg0KVG8gbXkga25vd2xlZGdlLCBubyBkaXNwbGF5IHNlcnZlciBvciBjb21wb3NpdG9yIHRhcmdl
dHMgZS1wYXBlciB0b2RheS4NClVzZXJzIHdyaXRlIHN0YW5kYWxvbmUgYXBwbGljYXRpb25zIHRo
YXQgZHJpdmUgdGhlIHBhbmVsIHRocm91Z2ggS01TLA0KYW5kIG91cnMgYXJlIGJlaW5nIGJ1aWx0
IG9uIExWR0wgWzFdLCBhbiBNSVQtbGljZW5zZWQgZW1iZWRkZWQgR1VJDQpsaWJyYXJ5LiBJIHNl
ZSB0aGF0IGl0cyB1cHN0cmVhbSBEUk0gYmFja2VuZCBhbHJlYWR5IHVzZXMgYXRvbWljIGNvbW1p
dHMNCmFuZCBzZXRzIHBsYW5lIGFuZCBDUlRDIHByb3BlcnRpZXMsIHNvIHN1cHBvcnRpbmcgYSBn
ZW5lcmljIGUtcGFwZXINCnByb3BlcnR5IHRoZXJlIHNob3VsZCBiZSBmZWFzaWJsZS4NCg0KICAx
LiBXb3VsZCBzdXBwb3J0IGluIHRoZSB1cHN0cmVhbSBMVkdMIERSTSBiYWNrZW5kIGJlIGFuIGFj
Y2VwdGFibGUNCiAgICAgb3Blbi1zb3VyY2UgdXNlcj8NCg0KICAyLiBXb3VsZCBhIGdlbmVyaWMg
ZS1wYXBlciByZWZyZXNoIG1vZGUgcHJvcGVydHksIGNyZWF0ZWQgYnkgYQ0KICAgICBjb3JlIGhl
bHBlciBhbmQgZGVjb2RlZCBieSB0aGUgY29yZSwgYmUgYWNjZXB0YWJsZSBpbiBwcmluY2lwbGU/
DQogICAgIEkgd291bGQgc3RhcnQgd2l0aCB0aGUgcmVmcmVzaCBtb2RlIGFsb25lLg0KDQogIDMu
IFdvdWxkIGEgQ1JUQyBwcm9wZXJ0eSBiZSB0aGUgcmlnaHQgb2JqZWN0PyBBIHJlZnJlc2ggZHJp
dmVzDQogICAgIHRoZSB3aG9sZSBwYW5lbCB3aXRoIG9uZSB3YXZlZm9ybSBhZnRlciB0aGUgcGxh
bmVzIGFyZSBjb21wb3NlZCwNCiAgICAgc28gd2l0aCBtb3JlIHRoYW4gb25lIHBsYW5lIGEgcGVy
LXBsYW5lIG1vZGUgY291bGQgY29uZmxpY3QNCiAgICAgd2l0aGluIG9uZSBjb21taXQ/IFRob3Vn
aCBpbiBnZW5lcmFsIGkgaGF2ZSBzZWVuIHNpbmdsZSBwbGFuZQ0KZXBhcGVyIHBhbmVscyBvbmx5
Lg0KDQpTb21lIGJhY2tncm91bmQ6IEkgc2hvdWxkIGhhdmUgbWVudGlvbmVkIGluIHRoZSBjb21t
aXQgbWVzc2FnZXMgdGhhdA0Kd2UgYnJvdWdodCB1cCB0aGlzIHRvcGljIGF0IHRoaXMgeWVhcidz
IERpc3BsYXkgTmV4dCBIYWNrZmVzdCB0b28sIHdoZXJlDQpJIHByZXNlbnRlZCBvbiBlLXBhcGVy
IHJlZnJlc2ggbW9kZXMgYW5kIGhvdyBwYXJ0cyBvZiB0aGVtIGNvdWxkIGJlDQpnZW5lcmFsaXpl
ZCBpbiBhIGNvbW1vbiBoZWxwZXIuDQoNClNpbWlsYXIgdG8gZHJtX2NydGNfY3JlYXRlX3NjYWxp
bmdfZmlsdGVyX3Byb3BlcnR5KCksIHdlIGNhbiBjcmVhdGUNCmEgaGVscGVyIHRoZSBkcml2ZXIg
cGFzc2VzIGEgZGVmYXVsdCBhbmQgdGhlIG1vZGVzIGl0cyBwYW5lbCBzdXBwb3J0cywNCg0KICAg
ICAgICBkcm1fY3J0Y19jcmVhdGVfZXBhcGVyX3JlZnJlc2hfcHJvcGVydHkoY3J0YywNCiAgICAg
ICAgICAgICAgICAgICAgICAgIERSTV9FUEFQRVJfUkVGUkVTSF9QQVJUSUFMLCAgLyogZGVmYXVs
dCAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgQklUKERSTV9FUEFQRVJfUkVGUkVTSF9QQVJU
SUFMKSB8DQogICAgICAgICAgICAgICAgICAgICAgICBCSVQoRFJNX0VQQVBFUl9SRUZSRVNIX0ZV
TEwpIHwNCiAgICAgICAgICAgICAgICAgICAgICAgIEJJVChEUk1fRVBBUEVSX1JFRlJFU0hfRkFT
VCkpOw0KDQphbmQgdGhlIGNvcmUgY3JlYXRlcyBhbiAiZXBhcGVyX3JlZnJlc2giIGVudW0gcHJv
cGVydHkgbGltaXRlZCB0bw0KdGhvc2UgbW9kZXMsIGFuZCBkZWNvZGVzIGl0IGludG8gdGhlIENS
VEMgc3RhdGUsIGFzIGl0IGRvZXMgZm9yDQp0aGUgc2NhbGluZyBmaWx0ZXIgcHJvcGVydHkgdG9k
YXkuDQoNCkkgaGF2ZSBzaW5jZSB3cml0dGVuIHVwIGFuIHVwZGF0ZSBvZiB0aG9zZSBzbGlkZXMg
aW4gWzJdLiBJdCBnb2VzDQp0aHJvdWdoIGVhY2ggdjMgcHJvcGVydHkgYW5kIGl0cyB1c2UgY2Fz
ZXMsIGFuZCBjb3ZlcnMgd2hpY2ggb25lcyB3ZQ0KdGhpbmsgY2FuIGJlIGdlbmVyaWMgYW5kIHdo
aWNoIHNob3VsZCBzdGF5IGRyaXZlciBpbnRlcm5hbCBhdCBsZWFzdCBmb3INCm5vdy4gVG8gc3Vt
bWFyaXplLCBmb3Igbm93IHRoZSBnZW5lcmljIGNhbmRpZGF0ZXMgYXJlIGFzIGJlbG93Og0KDQog
IC0gcmVmcmVzaCBtb2RlIHBlciB1cGRhdGUgKHBhcnRpYWwgLyBmdWxsIC8gZmFzdCk7IHRoZSBk
cml2ZXINCiAgICBkZWNsYXJlcyB0aGUgc3Vic2V0IGl0cyBwYW5lbCBzdXBwb3J0cw0KICAtIHJl
ZnJlc2ggbW9kZSBmb3IgdGhlIGZpcnN0IGZyYW1lIG9mIGEgbmV3IERSTSBtYXN0ZXINCiAgLSBj
bGVhcmluZyB0aGUgcGFuZWwgd2hlbiBhIG5ldyBtYXN0ZXIgb3BlbnMsIHdoZW4gaXQgY2xvc2Vz
DQogICAgKGluY2x1ZGluZyBhIGNyYXNoKSwgYW5kIG9uIENSVEMgZGlzYWJsZS4gQSBiaXN0YWJs
ZSBwYW5lbA0KICAgIG90aGVyd2lzZSBrZWVwcyB0aGUgbGFzdCBpbWFnZS4NCg0KVGhlc2UgZGVw
ZW5kIG9uIHRoZSBhcHBsaWNhdGlvbiByYXRoZXIgdGhhbiB0aGUgcGFuZWwuIEZvciBleGFtcGxl
LA0KYSBib2FyZGluZy1wYXNzIGtpb3NrIG11c3QgZXJhc2UgdGhlIHBhc3NlbmdlcidzIGRldGFp
bHMgb24gZXhpdCwNCndoaWxlIGEgY29uZmVyZW5jZSBiYWRnZSBzaG91bGQga2VlcCB0aGUgbmFt
ZSBzaG93bi4NCg0KSSBzZWUgc2ltaWxhciBjaG9pY2VzIGV4aXN0IG91dHNpZGUgU1NEMTZ4eCwg
c28gaW4gZnV0dXJlIGlmIG5ldyBlcGFwZXINCmRyaXZlcnMgYXJlIGFkZGVkIHRoZXkgbWF5IGJl
bmVmaXQgd2l0aCB0aGVzZSBnZW5lcmljIHByb3BlcnRpZXMgdG9vLg0KDQpGb3IgZS5nLiwgVGhl
IFdhdmVzaGFyZSByZWZlcmVuY2UgZHJpdmVycyBoYXZlIHNlcGFyYXRlIGZ1bGwgLyBmYXN0IC8N
CnBhcnRpYWwgdXBkYXRlIGNhbGxzIFszXSwgYW5kIE5YUCdzIGRvd25zdHJlYW0gRVBEQyBkcml2
ZXIgdGFrZXMgYQ0Kd2F2ZWZvcm0gYW5kIGEgcGFydGlhbCAvIGZ1bGwgbW9kZSB3aXRoIGVhY2gg
dXBkYXRlIFs0XS4gVGhlIG91dC1vZi10cmVlDQpyb2NrY2hpcF9lYmMgZHJpdmVyIHVzZXMgcGFy
dGlhbCB1cGRhdGVzIGZvciBlYWNoIGZyYW1lIGFuZCBhIGdsb2JhbA0KcmVmcmVzaCBvdGhlcndp
c2UsIGFuZCB0aGUgUGluZU5vdGUgdHJlZSBhZGRzIGEgcHJpdmF0ZSBpb2N0bCB0byByZXF1ZXN0
DQpvbmUgZ2xvYmFsIHJlZnJlc2ggWzVdLg0KDQpDb3VsZCB5b3UgcGxlYXNlIHNoYXJlIHlvdXIg
b3BpbmlvbiBvbiB0aGlzID8NCg0KT25jZSB0aGUgZGlyZWN0aW9uIGlzIGNsZWFyLCBJIHdpbGwg
d29yayBvbiB0aGUgZ2VuZXJpYyBwcm9wZXJ0aWVzIGFzDQphIHNlcGFyYXRlIFJGQywgc28gdGhh
dCB0aGV5IGRvIG5vdCBibG9jayB0aGUgZHJpdmVyLg0KDQpbMV0NCmh0dHBzOi8vZ2l0aHViLmNv
bS9sdmdsL2x2Z2wvYmxvYi8yZWU1NjU0NDQwYmZjMjFhMmNhZGU0YWE2ZTI0OGY4ZDM0YjVlMzNl
L3NyYy9kcml2ZXJzL2Rpc3BsYXkvZHJtL2x2X2xpbnV4X2RybS5jI0w0NDItTDQ5Mw0KDQpbMl0N
Cmh0dHBzOi8vZ2l0aHViLmNvbS9kZXZhcnNodC9saW51eC1uZXh0L2Jsb2IvZXBhcGVyX3Y0X2Ns
ZWFudXAvZXBhcGVyLXJlZnJlc2gtbW9kZXMubWQNCg0KWzNdDQpodHRwczovL2dpdGh1Yi5jb20v
d2F2ZXNoYXJldGVhbS9lLVBhcGVyL2Jsb2IvZDI4YjNjNGNmYzc4ZWVmMWM2Y2Q2ZTZlMzAxMzY1
NGU0NDlkMjg2NC9SYXNwYmVycnlQaV9KZXRzb25OYW5vL3B5dGhvbi9saWIvd2F2ZXNoYXJlX2Vw
ZC9lcGQyaW4xM19WNC5weSNMMjY4LUwyODcNCg0KWzRdDQpodHRwczovL2dpdGh1Yi5jb20vbnhw
LWlteC9saW51eC1pbXgvYmxvYi8wNjIxM2JiMDExNWY1ODdmNTVlYzFmNDVmYWMwMzU0NDg1NWY5
N2E3L2luY2x1ZGUvdWFwaS9saW51eC9teGNmYi5oI0wxMzEtTDEzNA0KDQpbNV0NCmh0dHBzOi8v
Z2l0aHViLmNvbS9tLXdlaWdhbmQvbGludXgvYmxvYi8xMWE4NDk4NTFhOGQzMWRkOGYwZWVjMDAz
ZDQ1NzYzZGQzMjEyYzc3L2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9lYmMuYyNM
MTQxOC1MMTQzNw0KDQpSZWdhcmRzLA0KRGV2YXJzaA0KDQo+IE1heGltZQ0KDQo=
